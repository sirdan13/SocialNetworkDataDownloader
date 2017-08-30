package it.tvpad.model.data.tweet;

import java.io.Serializable;
import javax.persistence.*;


/**
 * The persistent class for the URL database table.
 * 
 */
@Entity
@Table(name="URL")
@NamedQuery(name="Url.findAll", query="SELECT u FROM Url u")
public class Url implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	@Column(name="ID")
	private long id;

	@Column(name="EXPANDED_URL", nullable=false)
	private String expandedUrl;

	//bi-directional many-to-one association to Tweet
	@ManyToOne
	@JoinColumn(name="TWEET_ID", nullable=false)
	private Tweet tweet;

	public Url() {
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

	public Tweet getTweet() {
		return this.tweet;
	}

	public void setTweet(Tweet tweet) {
		this.tweet = tweet;
	}

}