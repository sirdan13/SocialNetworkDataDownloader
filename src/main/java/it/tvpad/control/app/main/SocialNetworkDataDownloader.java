package it.tvpad.control.app.main;

import it.tvpad.control.app.main.exception.ApplicationParameterException;
import it.tvpad.control.consumer.DataConsumer;
import it.tvpad.control.database.DatabaseService;
import it.tvpad.control.database.exception.DatabaseConnectionException;
import it.tvpad.control.database.exception.DatabaseException;
import it.tvpad.control.producer.AbstractRestDataProducer;
import it.tvpad.control.producer.AbstractStreamDataProducer;
import it.tvpad.control.producer.ProducerMonitor;
import it.tvpad.control.producer.facebook.data.FacebookRestDataProducer;
import it.tvpad.control.producer.facebook.server.AsyncFacebookServer;
import it.tvpad.control.producer.facebook.server.exception.ServerException;
import it.tvpad.control.producer.filters.BaseFilter;
import it.tvpad.control.producer.twitter.TwitterStreamingProducer;
import it.tvpad.control.properties.db.DatabasePropertiesReader;
import it.tvpad.control.properties.exception.PropertiesException;
import it.tvpad.control.properties.facebook.FacebookPropertiesReader;
import it.tvpad.control.properties.twitter.TwitterPropertiesReader;
import it.tvpad.model.data.AbstractData;
import it.tvpad.model.request.Request;
import it.tvpad.model.request.Source;
import it.tvpad.model.request.SourcesRequest;

import java.io.File;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Set;
import java.util.concurrent.BlockingQueue;
import java.util.concurrent.Executors;
import java.util.concurrent.LinkedBlockingQueue;
import java.util.concurrent.ScheduledExecutorService;
import java.util.concurrent.TimeUnit;

import org.apache.log4j.PropertyConfigurator;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class SocialNetworkDataDownloader {

	private static final String BASE_CONFIG_URL = "config";
	private static Long delay = 0L;
	private static Logger logger = LoggerFactory.getLogger(SocialNetworkDataDownloader.class);
	private static Long requestId;
	private static boolean searchPreviousData;

	public static void main(String[] args) {

		// configure properties for logger
		PropertyConfigurator.configure("config" + File.separator + "log4j.properties");
		HashMap<String, String> paramMap = new HashMap<String, String>();
		AsyncFacebookServer facebookServer = null;

		// check args num
		if (args.length < 1) {
			logger.error("Usage : java -jar APP_NAME req_id=num");
			System.exit(-1);
		}

		for (String param : args) {
			String[] data = param.split("\\=");
			paramMap.put(data[0], data[1]);
		}

		if (!paramMap.containsKey("req_id")) {
			logger.error("Usage : java -jar APP_NAME req_id=num");
			System.exit(-1);
		}

		// read req_id
		try {
			requestId = Long.parseLong(paramMap.get("req_id"));
		} catch (NumberFormatException e) {
			logger.error("Invalid number of req_id");
			System.exit(-1);
		}

		// load database properties
		DatabasePropertiesReader databasePropertiesReader = new DatabasePropertiesReader(
				BASE_CONFIG_URL + File.separator + "database.properties");
		try {
			databasePropertiesReader.loadProperties();
		} catch (PropertiesException e) {
			logger.error(e.getMessage(), e);
			System.exit(-1);
		}

		// setting parameters of database service
		DatabaseService dbService = new DatabaseService();
		dbService.setDriver(databasePropertiesReader.getDatabaseDriver());
		dbService.setUrl(databasePropertiesReader.getDatabaseUrl());
		dbService.setUser(databasePropertiesReader.getUserName());
		dbService.setPassword(databasePropertiesReader.getPassword());

		// connect to database
		try {
			dbService.connect();
		} catch (DatabaseConnectionException e) {
			logger.error(e.getMessage(), e);
			System.exit(-1);
		}

		// load request
		Request request = null;
		try {
			request = dbService.getRequest(requestId);
		} catch (DatabaseException e) {
			logger.error(e.getMessage(), e);
			dbService.disconnect();
			System.exit(-1);
		}

		try {
			
			chekRequestData(request);
		} catch (ApplicationParameterException e) {
			logger.error(e.getMessage(), e);
			dbService.disconnect();
			System.exit(-1);
		}

		
		//ProducerMonitor prodMon = ProducerMonitor.getInstance();
		//prodMon.setStreamingAttivo(true);
		
		// intialize base filter
		// TODO check for correct syntax of filters
		BaseFilter filter = new BaseFilter();
		filter.parseKeywordFilter(request.getKeywordFilter());
		filter.parseLanguageFilter(request.getLanguageFilter());

		// load list of sources
		List<SourcesRequest> sourcesRequests = request.getSourcesRequests();
		List<Source> sources = new ArrayList<Source>();
		Set<String> socialNetworks = new HashSet<String>();
		for (SourcesRequest sr : sourcesRequests) {
			sources.add(sr.getSource());
			socialNetworks.add(sr.getSource().getSocialNetwork());
			logger.info("Source with id: " + sr.getSource().getId() + " loaded");
		}

		// loading and setting properties
		for (String socialNetwork : socialNetworks) {
			if (socialNetwork.equalsIgnoreCase("TWITTER")) {
				TwitterPropertiesReader twitterPropertiesReader = new TwitterPropertiesReader(
						BASE_CONFIG_URL + File.separator + "twitter.properties");
				try {
					twitterPropertiesReader.loadProperties();
					System.setProperty("twitter4j.oauth.consumerKey", twitterPropertiesReader.getConsumerKey());
					System.setProperty("twitter4j.oauth.consumerSecret", twitterPropertiesReader.getConsumerSecret());
					System.setProperty("twitter4j.oauth.accessToken", twitterPropertiesReader.getAccessToken());
					System.setProperty("twitter4j.oauth.accessTokenSecret",
							twitterPropertiesReader.getAccessTokenSecret());
					HashMap<String, String> otherProp = twitterPropertiesReader.getExtendedTwitterProperties();
					for (String prop : otherProp.keySet()) {
						System.setProperty(prop, otherProp.get(prop));
					}

				} catch (PropertiesException e) {
					logger.error(e.getMessage(), e);
					System.exit(-1);
				}
			} else if (socialNetwork.equalsIgnoreCase("FACEBOOK")) {
				FacebookPropertiesReader facebookPropertiesReader = new FacebookPropertiesReader(
						BASE_CONFIG_URL + File.separator + "facebook.properties");
				try {
					facebookPropertiesReader.loadProperties();
					facebookServer = new AsyncFacebookServer();
					facebookServer.setAppId(facebookPropertiesReader.getAppId());
					facebookServer.setAppSecret(facebookPropertiesReader.getAppSecret());
					facebookServer.setGrant(facebookPropertiesReader.getGrant());
					facebookServer.setRedirectBaseUri(facebookPropertiesReader.getRedirectBaseUri());
					facebookServer.setAccessTokenUri(facebookPropertiesReader.getAccessTokenUri());
					facebookServer.setPort(facebookPropertiesReader.getServerPort());
					facebookServer.startServer();

				} catch (PropertiesException e) {
					logger.error(e.getMessage(), e);
					System.exit(-1);
				} catch (ServerException e) {
					logger.error(e.getMessage(), e);
					System.exit(-1);
				}

			} else {
				logger.error("Social network " + socialNetwork + " not supported");
				System.exit(-1);
			}
		}

		// Create a blocking queue
		BlockingQueue<List<? extends AbstractData>> dataQueue = new LinkedBlockingQueue<>(100000);

		/*
		 * LOGIC OF APPLICATION forall source 1 or 2 data producer will be
		 * initialize if the start time is previous current time will be
		 * initialized 1) A REST data producer to download data from start date
		 * to current date (REST API) 2) A STREAMING data producer to download
		 * data from current date to stop date ( STREAMING API) otherwise only a
		 * STREAMING data producer will be initialized ACTUALLY IMPLEMENTED -
		 * TWITTER: streaming data producer - FACEBOOK: rest data producer
		 */

		// Create producers
		logger.warn("REST data producer for twitter not yet implemented");
		logger.warn("STREAM data producer for facebook not yet implemented");
		List<AbstractRestDataProducer> restDataProducers = new ArrayList<AbstractRestDataProducer>();
		List<AbstractStreamDataProducer> streamDataProducers = new ArrayList<AbstractStreamDataProducer>();

		for (Source source : sources) {
			if (source.getSocialNetwork().equalsIgnoreCase("TWITTER")) {
				TwitterStreamingProducer streamingTweetProducer = new TwitterStreamingProducer();
				streamingTweetProducer.setFilter(filter);
				streamingTweetProducer.setDataQueue(dataQueue);
				streamingTweetProducer.setRequest(request);
				streamingTweetProducer.setDatabaseService(dbService);
				streamingTweetProducer.setSource(source);
				streamDataProducers.add(streamingTweetProducer);
				if (searchPreviousData) {
					// TODO initialize REST data producer for twitter
				}
			} else if (source.getSocialNetwork().equalsIgnoreCase("FACEBOOK")) {
				// TODO initialize stream data producer for facebook
				if (searchPreviousData) {
					FacebookRestDataProducer facebookRestDataProducer = new FacebookRestDataProducer();
					facebookRestDataProducer.setFilter(filter);
					facebookRestDataProducer.setDataQueue(dataQueue);
					facebookRestDataProducer.setRequest(request);
					facebookRestDataProducer.setSource(source);
					facebookRestDataProducer.setAccessTokenTimeOut(60);
					facebookRestDataProducer.setServer(facebookServer);
					restDataProducers.add(facebookRestDataProducer);
				}
			} else {
				logger.error("Social network " + source.getSocialNetwork() + " not supported");
				System.exit(-1);
			}
		}
		// Create data consumer
		DataConsumer dataConsumer = new DataConsumer();
		dataConsumer.setDatabaseService(dbService);
		dataConsumer.setDataQueue(dataQueue);
		dataConsumer.setStopDate(new Date(request.getStopDate().getTime()));
		dataConsumer.setRequestID(request.getId());

		ScheduledExecutorService scheduler = Executors
				.newScheduledThreadPool(restDataProducers.size() + streamDataProducers.size() + 1);
		if (searchPreviousData) {
			// launch rest data producers
			// for(AbstractRestDataProducer ardp : restDataProducers){
			// ardp.run();
			// }
			for (AbstractRestDataProducer ardp : restDataProducers) {
				scheduler.schedule(ardp, 0, TimeUnit.MICROSECONDS);
			}
			// launch immediately stream producer
			for (AbstractStreamDataProducer asdp : streamDataProducers) {
				scheduler.schedule(asdp, 0, TimeUnit.MICROSECONDS);
			}
		} else {
			// schedule stream producer
			for (AbstractStreamDataProducer asdp : streamDataProducers) {
				scheduler.schedule(asdp, delay, TimeUnit.MICROSECONDS);
			}
		}
		scheduler.schedule(dataConsumer, 0, TimeUnit.MILLISECONDS);

		// do not accept more tasks
		scheduler.shutdown();
		try {
			// wait for termination
			scheduler.awaitTermination(Long.MAX_VALUE, TimeUnit.MINUTES);
		} catch (InterruptedException e) {
			logger.warn("Incorrect Termination of program");
			System.exit(-1);
		}

		// close all
		//facebookServer.stopServer();
		dbService.disconnect();
		System.exit(0);
	}

	private static void chekRequestData(Request request) throws ApplicationParameterException {
		// TODO controllo al momento solo le date ma dovrei verificare anche i
		// filtri
		Date currentDate = new Date();
		Date startDate = new Date(request.getStartDate().getTime());
		Date stopDate = new Date(request.getStopDate().getTime());
		if (stopDate.getTime() - startDate.getTime() <= 0) {
			throw new ApplicationParameterException("Stop date could not be previous of start date");
		}

		if (stopDate.getTime() - currentDate.getTime() <= 0) {
			throw new ApplicationParameterException("Stop date could not be previous of current date");
		}

		// check delay and period;
		delay = startDate.getTime() - currentDate.getTime();
		if (delay < 0) {
			logger.info("Start date is previous of current date. Program will dowload also previous data");
			delay = 0L;
			searchPreviousData = true;
		}
	}
}
