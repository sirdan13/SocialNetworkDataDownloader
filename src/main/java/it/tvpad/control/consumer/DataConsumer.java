package it.tvpad.control.consumer;

import it.tvpad.control.database.DatabaseService;
import it.tvpad.control.database.exception.DatabaseException;
import it.tvpad.control.producer.ProducerMonitor;
import it.tvpad.model.data.AbstractData;
import it.tvpad.model.data.facebook.FacebookData;
import it.tvpad.model.data.tweet.Tweet;

import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.concurrent.BlockingQueue;
import java.util.concurrent.TimeUnit;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class DataConsumer implements Runnable {

	private Date stopDate;
	private BlockingQueue<List<? extends AbstractData>> dataQueue;
	private DatabaseService databaseService;
	private Long requestID;
	private static Logger logger = LoggerFactory.getLogger(DataConsumer.class);

	public void setStopDate(Date stopDate) {
		this.stopDate = stopDate;
	}

	public void setDataQueue(BlockingQueue<List<? extends AbstractData>> dataQueue) {
		this.dataQueue = dataQueue;
	}

	public void setDatabaseService(DatabaseService databaseService) {
		this.databaseService = databaseService;
	}

	public void setRequestID(Long requestID) {
		this.requestID = requestID;
	}

	void storeBunch(List<? extends AbstractData> bunch, ProducerMonitor prodMon) {
		if (bunch != null && bunch.size() > 0) {
			if (bunch.get(0).getSource().getSocialNetwork().equalsIgnoreCase("TWITTER")){
				@SuppressWarnings("unchecked")
				List<Tweet> tweets = (List<Tweet>)bunch;
				try {
					databaseService.storeTweetList(tweets);
					// logger.debug("tweet stored");
					prodMon.incrementaTweetPersistiti(tweets.size());
				} catch (DatabaseException e) {
					logger.error("DataConsumer: " + e.getMessage(), e);
				}
			} else if (bunch.get(0).getSource().getSocialNetwork().equalsIgnoreCase("FACEBOOK")){
				@SuppressWarnings("unchecked")
				List<FacebookData> fbData= (List<FacebookData>)bunch;
				try {
					databaseService.storeFacebookDataList(fbData);
					logger.debug("facebook data stored");
				} catch (DatabaseException e) {
					logger.error("DataConsumer: " + e.getMessage(), e);
				}
				
			} else {
				logger.error("Social network " + bunch.get(0).getSource().getSocialNetwork() + " not supported");
			}
		}		
	}
	
	@Override
	public void run() {
		logger.info("DataConsumer: START");
		ProducerMonitor prodMon = ProducerMonitor.getInstance();
		Date now = new Date();
		// try {
		// while (now.compareTo(stopDate) <= 0
		// && (databaseService.getRequest(requestID).getStopCapturing() ==
		// null ||
		// !(databaseService.getRequest(requestID).getStopCapturing() ==
		// true))) {
		// while (prodMon.isStreamingAttivo()) {
		while (now.compareTo(stopDate) <= 0) {
			List<? extends AbstractData> bunch = null;
			try {
				bunch = dataQueue.poll(5, TimeUnit.SECONDS);
				this.storeBunch(bunch, prodMon);
			} catch (InterruptedException e) {
				logger.warn("No data available");
			}
			
					
			now = new Date();
		}
		// } catch (DatabaseException e1) {
		// logger.warn("Request not found");
		// }
		logger.info("DataConsumer: Streaming finished");
		logger.info("DataConsumer: Waiting for finish to write data on database");
		while (!dataQueue.isEmpty()) {
			logger.info("DataConsumer: DataQueue length " + dataQueue.size());
			List<? extends AbstractData> bunch = null;
			try {
				bunch = dataQueue.take();
				this.storeBunch(bunch, prodMon);
			} catch (InterruptedException e) {
				logger.error("Error: unable to poll ", e);
				e.printStackTrace();
			}
			
		}
		logger.info("STOP - DataConsumer");
		Calendar c = Calendar.getInstance();
		try {
			databaseService.setEndSavingDate(requestID, new java.sql.Timestamp(c.getTimeInMillis()));
		} catch (DatabaseException e) {
			logger.error(e.getMessage(), e);
		}
	}
}
