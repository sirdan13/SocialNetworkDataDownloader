package it.tvpad.model.request;

import it.tvpad.model.data.facebook.FacebookData;
import it.tvpad.model.data.tweet.Tweet;

import java.io.Serializable;

import javax.persistence.*;

import java.util.ArrayList;
import java.util.List;


/**
 * The persistent class for the SOURCE database table.
 * 
 */
@Entity
@Table(name="SOURCE")
@NamedQuery(name="Source.findAll", query="SELECT s FROM Source s")
public class Source implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@Column(name="ID")
	private long id;

	@Column(name="INFO_LEVEL")
	private String infoLevel;

	@Column(name="SOCIAL_NETWORK", nullable=false)
	private String socialNetwork;

	@Column(name="SRC_SN_ID")
	private String srcSnId;

	@Column(name="SRC_SN_NAME")
	private String srcSnName;

	@Column(name="[TYPE]", nullable=false)
	private String type;

	//bi-directional many-to-one association to Feed
	@OneToMany(mappedBy="source")
	private List<FacebookData> feeds;

	//bi-directional many-to-one association to SourcesRequest
	@OneToMany(mappedBy="source")
	private List<SourcesRequest> sourcesRequests;

	//bi-directional many-to-one association to Tweet
	@OneToMany(mappedBy="source")
	private List<Tweet> tweets;

	public Source() {
	}

	public long getId() {
		return this.id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public String getInfoLevel() {
		return this.infoLevel;
	}

	public void setInfoLevel(String infoLevel) {
		this.infoLevel = infoLevel;
	}

	public String getSocialNetwork() {
		return this.socialNetwork;
	}

	public void setSocialNetwork(String socialNetwork) {
		this.socialNetwork = socialNetwork;
	}

	public String getSrcSnId() {
		return this.srcSnId;
	}

	public void setSrcSnId(String srcSnId) {
		this.srcSnId = srcSnId;
	}

	public String getSrcSnName() {
		return this.srcSnName;
	}

	public void setSrcSnName(String srcSnName) {
		this.srcSnName = srcSnName;
	}

	public String getType() {
		return this.type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public List<FacebookData> getFeeds() {
		return this.feeds;
	}

	public void setFeeds(List<FacebookData> feeds) {
		this.feeds = feeds;
	}

	public FacebookData addFeed(FacebookData feed) {
		feed.setSource(this);
		if(feeds != null){
			feeds.add(feed);
		}else{
			feeds = new ArrayList<FacebookData>();
			feeds.add(feed);
		}
		return feed;
	}

	public FacebookData removeFeed(FacebookData feed) {
		feed.setSource(null);
		if(feeds != null){
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
		sourcesRequest.setSource(this);
		if(sourcesRequests != null){
			sourcesRequests.add(sourcesRequest);
		}else{
			sourcesRequests = new ArrayList<SourcesRequest>();
			sourcesRequests.add(sourcesRequest);			
		}

		return sourcesRequest;
	}

	public SourcesRequest removeSourcesRequest(SourcesRequest sourcesRequest) {
		sourcesRequest.setSource(null);
		if(sourcesRequests != null){
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
		tweet.setSource(this);
		if(tweets != null){
			tweets.add(tweet);
		}else{
			tweets = new ArrayList<Tweet>();
			tweets.add(tweet);
		}
		return tweet;
	}

	public Tweet removeTweet(Tweet tweet) {
		tweet.setSource(null);
		if(tweets != null){
			tweets.remove(tweet);
		}
		return tweet;
	}

}