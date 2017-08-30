package it.tvpad.control.producer.twitter;

import it.tvpad.control.database.DatabaseService;
import it.tvpad.control.database.exception.DatabaseException;
import it.tvpad.control.producer.AbstractStreamDataProducer;
import it.tvpad.control.producer.ProducerMonitor;
import it.tvpad.control.producer.filters.BaseFilter;
import it.tvpad.model.data.tweet.Hashtag;
import it.tvpad.model.data.tweet.Media;
import it.tvpad.model.data.tweet.Tweet;
import it.tvpad.model.data.tweet.Url;
import it.tvpad.model.request.Request;
import it.tvpad.model.request.Source;

import java.math.BigDecimal;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.List;
import java.util.concurrent.TimeUnit;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import twitter4j.FilterQuery;
import twitter4j.GeoLocation;
import twitter4j.HashtagEntity;
import twitter4j.MediaEntity;
import twitter4j.StallWarning;
import twitter4j.Status;
import twitter4j.StatusDeletionNotice;
import twitter4j.StatusListener;
import twitter4j.TwitterStream;
import twitter4j.TwitterStreamFactory;
import twitter4j.URLEntity;

public class TwitterStreamingProducer extends AbstractStreamDataProducer {

	private FilterQuery filterQuery;
	private static Logger logger = LoggerFactory.getLogger(TwitterStreamingProducer.class);
	private Long tweetCounter = 0L;
	private Date stopDate;
	private Date startDate;
	private DatabaseService databaseService;
	private int bufferSize = 1000;

	public TwitterStreamingProducer() {
		filterQuery = new FilterQuery();
	}

	public void setDatabaseService(DatabaseService databaseService) {
		this.databaseService = databaseService;
	}
	
	public void setBufferSize(int bufferSize) {
		this.bufferSize = bufferSize;
	}

	public void setRequest(Request request) {
		this.request = request;
		// set stop date
		stopDate = new Date(request.getStopDate().getTime());
		// set start date
		startDate = new Date(request.getStartDate().getTime());

		if (filter == null) {
			System.out.println("filter null");
		}
		if (filterQuery == null) {
			System.out.println("filterQuey null");
		}
		String[] data = filter.getTwitterApiKeywordFilter();
		logger.warn("Data:" + Arrays.toString(data));
		if (data == null) {
			System.out.println("data null");
		}
		filterQuery.track(data);

		// set language filter
		filterQuery.language(filter.getTwitterApiLanguageFilter());
	}

	public void setSource(Source source) {
		this.source = source;
	}

	@Override
	public void run() {
		TwitterStream twitterStream = new TwitterStreamFactory().getInstance();
		
		//ProducerMonitor prodMon = ProducerMonitor.getInstance();
		//prodMon.setStreamingAttivo(true);
		StatusListener listener = new StatusListener() {
			List<Tweet> buffer = new ArrayList<Tweet>(bufferSize); 

			public void onStatus(Status status) {
				if (!status.isRetweet()) {
					Tweet tweet = extractStatusInfo(status);
					// logger.warn("Got a tweet: " + tweet.getText());
					if (filter.filterTweet(tweet.getText())) {
						buffer.add(tweet);
						tweetCounter++;
						if (tweetCounter % 1000 == 0) {
							logger.error("Twitter Streaming: Received " + tweetCounter + " tweet");
						}
						if (buffer.size() >= bufferSize) {
							try {
								dataQueue.offer(buffer, 1, TimeUnit.SECONDS);
								// prodMon.incrementaTweetScaricati();
								// logger.warn("tweet received from streaming");
							} catch (InterruptedException e) {
								logger.error("Too much time for queue free space!");
							} finally {
								buffer = new ArrayList<Tweet>(bufferSize);
							}
						}
					}
				}
			}

			public void onDeletionNotice(StatusDeletionNotice statusDeletionNotice) {
				// logger.warn("Got a status deletion notice id:" +
				// statusDeletionNotice.getStatusId());
			}

			public void onTrackLimitationNotice(int numberOfLimitedStatuses) {
				logger.warn("Got track limitation notice:" + numberOfLimitedStatuses);
			}

			public void onScrubGeo(long userId, long upToStatusId) {
				// logger.warn("Got scrub_geo event userId:" + userId + "
				// upToStatusId:" + upToStatusId);
			}

			public void onException(Exception ex) {
				logger.warn(ex.getMessage(), ex);
			}

			public void onStallWarning(StallWarning arg0) {
				// logger.warn(arg0.getMessage() + " - " + arg0.getCode());
			}
		};
		Date now = new Date();
		// try {
		logger.error("Twitter Streaming: WAITING FOR START");
		while (now.compareTo(startDate) <= 0) {
			try {
				Thread.sleep(1000);
			} catch (InterruptedException e) {
				logger.error(e.getMessage(), e);
			}
			now = new Date();
		}

		twitterStream.addListener(listener);
		twitterStream.filter(filterQuery);

		logger.error("Twitter Streaming: START");

		// while (now.compareTo(stopDate) <= 0 &&
		// (databaseService.getRequest(this.request.getId()).getStopCapturing()
		// == null
		// ||
		// !(databaseService.getRequest(this.request.getId()).getStopCapturing()
		// == true))) {
		while (now.compareTo(stopDate) <= 0) {
			try {
				Thread.sleep(1000);
			} catch (InterruptedException e) {
				logger.error("Twitter Streaming: Exception reading DB value StopCapturing" + e.getMessage(), e);
			}
			now = new Date();
		}
		// } catch (DatabaseException e) {
		// e.printStackTrace();
		// }
		// prodMon.setStreamingAttivo(false);
		logger.error("Twitter Streaming: STOPPING...");
		twitterStream.shutdown();
		logger.error("Twitter Streaming: STOP");
	}

	private Tweet extractStatusInfo(Status status) {
		// extract tweet information
		Tweet tweet = new Tweet();
		tweet.setTweetId(new BigDecimal(status.getId()));
		tweet.setLanguage(status.getLang());
		tweet.setText(status.getText());
		// System.out.println(tweet.getText());
		// String newtext = EmojiParser.parseToAliases(status.getText());
		// tweet.setText(newtext);
		// System.out.println("Newtext:\t\t"+newtext);
		// System.out.println("--------------------------");
		GeoLocation geolocation = status.getGeoLocation();
		if (geolocation != null) {
			tweet.setLongitude(geolocation.getLongitude());
			tweet.setLatitude(geolocation.getLatitude());
		}
		tweet.setCreationDate(new Timestamp(status.getCreatedAt().getTime()));
		tweet.setFavoritesCount(status.getFavoriteCount());
		// extract user information
		tweet.setUserId(new BigDecimal(status.getUser().getId()));
		tweet.setUserLocation(status.getUser().getLocation());
		tweet.setUserListedCount(status.getUser().getListedCount());
		tweet.setUserFollowerCount(status.getUser().getFollowersCount());
		// extract medias informations
		MediaEntity[] mediaArray = status.getMediaEntities();
		if (mediaArray != null) {
			for (MediaEntity mediaEntity : mediaArray) {
				Media media = new Media();
				media.setExpandedUrl(mediaEntity.getExpandedURL());
				media.setType(mediaEntity.getType());
				tweet.addMedia(media);
			}
		}
		// extract urls informations
		URLEntity[] urlEntityArray = status.getURLEntities();
		if (urlEntityArray != null) {

			for (URLEntity urlEntity : urlEntityArray) {
				Url url = new Url();
				url.setExpandedUrl(urlEntity.getExpandedURL());
				tweet.addUrl(url);
			}
		}
		// extract hashtags informations
		HashtagEntity[] hashTagEntityArray = status.getHashtagEntities();
		if (hashTagEntityArray != null) {
			for (HashtagEntity hashTagEntity : hashTagEntityArray) {
				Hashtag hashTag = new Hashtag();
				hashTag.setText(hashTagEntity.getText());
				tweet.addHashtag(hashTag);
			}
		}
		tweet.setRequest(request);
		tweet.setSource(source);
		return tweet;
	}

	@Override
	public void setFilter(BaseFilter filter) {
		super.setFilter(filter);
	}
}
