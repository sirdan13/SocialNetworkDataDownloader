package it.tvpad.model.data.tweet;

import java.io.Serializable;
import javax.persistence.*;


/**
 * The persistent class for the HASHTAG database table.
 * 
 */
@Entity
@Table(name="HASHTAG")
@NamedQuery(name="Hashtag.findAll", query="SELECT h FROM Hashtag h")
public class Hashtag implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	@Column(name="ID")
	private long id;

	@Column(name="TEXT", nullable=false)
	private String text;

	//bi-directional many-to-one association to Tweet
	@ManyToOne
	@JoinColumn(name="TWEET_ID", nullable=false)
	private Tweet tweet;

	public Hashtag() {
	}

	public long getId() {
		return this.id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public String getText() {
		return this.text;
	}

	public void setText(String text) {
		this.text = text;
	}

	public Tweet getTweet() {
		return this.tweet;
	}

	public void setTweet(Tweet tweet) {
		this.tweet = tweet;
	}

}