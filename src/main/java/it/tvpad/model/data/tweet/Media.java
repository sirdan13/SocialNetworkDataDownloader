package it.tvpad.model.data.tweet;

import java.io.Serializable;
import javax.persistence.*;


/**
 * The persistent class for the MEDIA database table.
 * 
 */
@Entity
@Table(name="MEDIA")
@NamedQuery(name="Media.findAll", query="SELECT m FROM Media m")
public class Media implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	@Column(name="ID")
	private long id;

	@Column(name="EXPANDED_URL", nullable=false)
	private String expandedUrl;

	@Column(name="[TYPE]", nullable=false)
	private String type;

	//bi-directional many-to-one association to Tweet
	@ManyToOne
	@JoinColumn(name="TWEET_ID", nullable=false)
	private Tweet tweet;

	public Media() {
	}

	public long getId() {
		return this.id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public String getExpandedUrl() {
		return this.expandedUrl;
	}

	public void setExpandedUrl(String expandedUrl) {
		this.expandedUrl = expandedUrl;
	}

	public String getType() {
		return this.type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public Tweet getTweet() {
		return this.tweet;
	}

	public void setTweet(Tweet tweet) {
		this.tweet = tweet;
	}

}