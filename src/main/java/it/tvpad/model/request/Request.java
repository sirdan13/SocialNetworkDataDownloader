package it.tvpad.model.request;

import it.tvpad.model.data.facebook.FacebookData;
import it.tvpad.model.data.tweet.Tweet;

import java.io.Serializable;

import javax.persistence.*;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

/**
 * The persistent class for the REQUEST database table.
 * 
 */
@Entity
@Table(name = "REQUEST")
@NamedQueries({ @NamedQuery(name = "Request.findAll", query = "SELECT r FROM Request r"),
		@NamedQuery(name = "Request.findById", query = "SELECT r FROM Request r WHERE r.id = :id") })

public class Request implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@Column(name = "ID")
	private long id;

	@Column(name = "DESCRIPTION")
	private String description;

	@Column(name = "KEYWORD_FILTER", nullable = false)
	private String keywordFilter;

	@Column(name = "LANGUAGE_FILTER")
	private String languageFilter;

	@Column(name = "LOCATION_FILTER")
	private String locationFilter;

	@Column(name = "NAME", nullable = false)
	private String name;

	@Column(name = "START_DATE", nullable = false)
	private Timestamp startDate;

	@Column(name = "STOP_DATE", nullable = false)
	private Timestamp stopDate;
	
	@Column(name = "Type")
	private String type;

	// bi-directional many-to-one association to Feed
	@OneToMany(mappedBy = "request")
	private List<FacebookData> feeds;

	// bi-directional many-to-one association to SourcesRequest
	@OneToMany(mappedBy = "request")
	private List<SourcesRequest> sourcesRequests;

	// bi-directional many-to-one association to Tweet
	@OneToMany(mappedBy = "request")
	private List<Tweet> tweets;

	// bi-directional many-to-one association to Event
	@ManyToOne
	@JoinColumn(name = "IDEvent")
	private Event event;

	@Column(name = "StopCapturing")
	private Boolean stopCapturing;

	public Request() {
	}

	public long getId() {
		return this.id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public String getDescription() {
		return this.description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getKeywordFilter() {
		return this.keywordFilter;
	}

	public void setKeywordFilter(String keywordFilter) {
		this.keywordFilter = keywordFilter;
	}

	public String getLanguageFilter() {
		return this.languageFilter;
	}

	public void setLanguageFilter(String languageFilter) {
		this.languageFilter = languageFilter;
	}

	public String getLocationFilter() {
		return this.locationFilter;
	}

	public void setLocationFilter(String locationFilter) {
		this.locationFilter = locationFilter;
	}

	public String getName() {
		return this.name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public Timestamp getStartDate() {
		return this.startDate;
	}

	public void setStartDate(Timestamp startDate) {
		this.startDate = startDate;
	}

	public Timestamp getStopDate() {
		return this.stopDate;
	}

	public void setStopDate(Timestamp stopDate) {
		this.stopDate = stopDate;
	}

	@Column(name = "EndSavingDate")
	private Timestamp endSavingDate;

	public List<FacebookData> getFeeds() {
		return this.feeds;
	}

	public void setFeeds(List<FacebookData> feeds) {
		this.feeds = feeds;
	}

	public FacebookData addFeed(FacebookData feed) {
		feed.setRequest(this);
		if (feeds != null) {
			feeds.add(feed);
		} else {
			feeds = new ArrayList<FacebookData>();
			feeds.add(feed);
		}
		return feed;
	}

	public FacebookData removeFeed(FacebookData feed) {
		feed.setRequest(null);
		if (feeds != null) {
			feeds.remove(feed);
		}
		return feed;
	}

	public List<SourcesRequest> getSourcesRequests() {
		return this.sourcesRequests;
	}

	public void setSourcesRequests(List<SourcesRequest> sourcesRequests) {
		this.sourcesRequests = sourcesRequests;
	}

	public SourcesRequest addSourcesRequest(SourcesRequest sourcesRequest) {
		sourcesRequest.setRequest(this);
		if (sourcesRequests != null) {
			sourcesRequests.add(sourcesRequest);
		} else {
			sourcesRequests = new ArrayList<SourcesRequest>();
			sourcesRequests.add(sourcesRequest);
		}

		return sourcesRequest;
	}

	public SourcesRequest removeSourcesRequest(SourcesRequest sourcesRequest) {
		sourcesRequest.setRequest(null);
		if (sourcesRequests != null) {
			sourcesRequests.remove(sourcesRequest);
		}
		return sourcesRequest;
	}

	public List<Tweet> getTweets() {
		return this.tweets;
	}

	public void setTweets(List<Tweet> tweets) {
		this.tweets = tweets;
	}

	public Tweet addTweet(Tweet tweet) {
		tweet.setRequest(this);
		if (tweets != null) {
			tweets.add(tweet);
		} else {
			tweets = new ArrayList<Tweet>();
			tweets.add(tweet);
		}
		return tweet;
	}

	public Tweet removeTweet(Tweet tweet) {
		tweet.setRequest(null);
		if (tweets != null) {
			tweets.remove(tweet);
		}
		return tweet;
	}

	public Event getEvent() {
		return this.event;
	}

	public void setEvent(Event event) {
		this.event = event;
	}

	public Timestamp getEndSavingDate() {
		return this.endSavingDate;
	}

	public void setEndSavingDate(Timestamp endSavingDate) {
		this.endSavingDate = endSavingDate;
	}

	public Boolean getStopCapturing() {
		return stopCapturing;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}		
}