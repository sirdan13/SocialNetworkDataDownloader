package it.tvpad.model.data.tweet;

import it.tvpad.model.data.AbstractData;
import it.tvpad.model.request.Request;
import it.tvpad.model.request.Source;

import java.io.Serializable;

import javax.persistence.*;

import java.math.BigDecimal;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;


/**
 * The persistent class for the TWEET database table.
 * 
 */
@Entity
@Table(name="TWEET")
@NamedQuery(name="Tweet.findAll", query="SELECT t FROM Tweet t")
public class Tweet extends AbstractData implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	@Column(name="ID")
	private long id;
	
	@Column(name="TWEET_ID", nullable=false )
	private BigDecimal tweetId;

	@Column(name="CREATION_DATE", nullable=false)
	private Timestamp creationDate;

	@Column(name="FAVORITES_COUNT", nullable=false)
	private int favoritesCount;

	@Column(name="[LANGUAGE]", nullable=false)
	private String language;

	@Column(name="LATITUDE")
	private double latitude;

	@Column(name="LONGITUDE")
	private double longitude;

	@Column(name="TEXT", nullable=false)
	private String text;

	@Column(name="USER_FOLLOWER_COUNT", nullable=false)
	private int userFollowerCount;

	@Column(name="USER_ID", nullable=false)
	private BigDecimal userId;

	@Column(name="USER_LISTED_COUNT", nullable=false)
	private int userListedCount;

	@Column(name="USER_LOCATION")
	private String userLocation;

	//bi-directional many-to-one association to Hashtag
	@OneToMany(mappedBy="tweet", cascade=CascadeType.PERSIST)
	private List<Hashtag> hashtags;

	//bi-directional many-to-one association to Media
	@OneToMany(mappedBy="tweet", cascade=CascadeType.PERSIST)
	private List<Media> medias;

	//bi-directional many-to-one association to Request
	@ManyToOne
	@JoinColumn(name="REQUEST_ID")
	private Request request;

	//bi-directional many-to-one association to Source
	@ManyToOne
	@JoinColumn(name="SOURCE_ID")
	private Source source;

	//bi-directional many-to-one association to Url
	@OneToMany(mappedBy="tweet", cascade=CascadeType.PERSIST)
	private List<Url> urls;

	public Tweet() {
	}

	public long getId() {
		return this.id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public Timestamp getCreationDate() {
		return this.creationDate;
	}

	public void setCreationDate(Timestamp creationDate) {
		this.creationDate = creationDate;
	}

	public int getFavoritesCount() {
		return this.favoritesCount;
	}

	public void setFavoritesCount(int favoritesCount) {
		this.favoritesCount = favoritesCount;
	}

	public String getLanguage() {
		return this.language;
	}

	public void setLanguage(String language) {
		this.language = language;
	}

	public double getLatitude() {
		return this.latitude;
	}

	public void setLatitude(double latitude) {
		this.latitude = latitude;
	}

	public double getLongitude() {
		return this.longitude;
	}

	public void setLongitude(double longitude) {
		this.longitude = longitude;
	}

	public String getText() {
		return this.text;
	}

	public void setText(String text) {
		this.text = text;
	}

	public int getUserFollowerCount() {
		return this.userFollowerCount;
	}

	public void setUserFollowerCount(int userFollowerCount) {
		this.userFollowerCount = userFollowerCount;
	}

	public BigDecimal getUserId() {
		return this.userId;
	}

	public void setUserId(BigDecimal userId) {
		this.userId = userId;
	}

	public int getUserListedCount() {
		return this.userListedCount;
	}

	public void setUserListedCount(int userListedCount) {
		this.userListedCount = userListedCount;
	}

	public String getUserLocation() {
		return this.userLocation;
	}

	public void setUserLocation(String userLocation) {
		this.userLocation = userLocation;
	}	

	public BigDecimal getTweetId() {
		return tweetId;
	}

	public void setTweetId(BigDecimal tweetId) {
		this.tweetId = tweetId;
	}

	public List<Hashtag> getHashtags() {
		return this.hashtags;
	}

	public void setHashtags(List<Hashtag> hashtags) {
		this.hashtags = hashtags;
	}

	public Hashtag addHashtag(Hashtag hashtag) {
		hashtag.setTweet(this);
		if(hashtags != null){
			hashtags.add(hashtag);
		}else{
			hashtags = new ArrayList<Hashtag>();
			hashtags.add(hashtag);
		}
		return hashtag;
	}

	public Hashtag removeHashtag(Hashtag hashtag) {
		hashtag.setTweet(null);
		if(hashtags != null){
			hashtags.remove(hashtag);
		}
		return hashtag;
	}

	public List<Media> getMedias() {
		return this.medias;
	}

	public void setMedias(List<Media> medias) {
		this.medias = medias;
	}

	public Media addMedia(Media media) {
		media.setTweet(this);
		if(medias != null){
			medias.add(media);
		}else{
			medias = new ArrayList<Media>();
			medias.add(media);
		}
		return media;
	}

	public Media removeMedia(Media media) {
		media.setTweet(null);
		if(media != null){
			medias.remove(media);
		}
		return media;
	}

	public Request getRequest() {
		return this.request;
	}

	public void setRequest(Request request) {
		this.request = request;
	}

	public Source getSource() {
		return this.source;
	}

	public void setSource(Source source) {
		this.source = source;
	}

	public List<Url> getUrls() {
		return this.urls;
	}

	public void setUrls(List<Url> urls) {
		this.urls = urls;
	}

	public Url addUrl(Url url) {
		url.setTweet(this);
		if(urls!=null){
			urls.add(url);
		}else{
			urls = new ArrayList<Url>();
			urls.add(url);
		}
		return url;
	}

	public Url removeUrl(Url url) {
		url.setTweet(null);
		if(urls != null){
			urls.remove(url);
		}
		return url;
	}

}