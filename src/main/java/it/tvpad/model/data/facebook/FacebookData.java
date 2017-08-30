package it.tvpad.model.data.facebook;

import it.tvpad.model.data.AbstractData;
import it.tvpad.model.request.Request;
import it.tvpad.model.request.Source;

import java.io.Serializable;
import java.math.BigDecimal;
import java.sql.Timestamp;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;


/**
 * The persistent class for the FEED database table.
 * 
 */
@Entity
@Table(name="FACEBOOK_DATA")
public class FacebookData extends AbstractData implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	@Column(name="ID")
	private long id;
	
	@Column(name="SN_ID", columnDefinition="VARCHAR(MAX)")
	private String snId;

	@Column(name="AUTHOR_ID")
	private BigDecimal authorId;

	@Column(name="CAPTION", columnDefinition="VARCHAR(MAX)")
	private String caption;

	@Column(name="CREATION_DATE", nullable=false)
	private Timestamp creationDate;

	@Column(name="DESCRIPTION", columnDefinition="VARCHAR(MAX)")
	private String description;

	@Column(name="LIKES")
	private BigDecimal likes;

	@Column(name="[LINK]", columnDefinition="VARCHAR(MAX)")
	private String link;

	@Column(name="[MESSAGE]", columnDefinition="VARCHAR(MAX)")
	private String message;

	@Column(name="PICTURE", columnDefinition="VARCHAR(MAX)")
	private String picture;

	@Column(name="[TYPE]")
	private String type;
	
	@Column(name="FEED_REF", columnDefinition="VARCHAR(MAX)")
	private String feedRef;
	

	//bi-directional many-to-one association to Request
	@ManyToOne
	@JoinColumn(name="REQUEST_ID", nullable=false)
	private Request request;

	//bi-directional many-to-one association to Source
	@ManyToOne
	@JoinColumn(name="SOURCE_ID", nullable=false)
	private Source source;

	public FacebookData() {
	}

	public long getId() {
		return this.id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public BigDecimal getAuthorId() {
		return this.authorId;
	}

	public void setAuthorId(BigDecimal authorId) {
		this.authorId = authorId;
	}

	public String getCaption() {
		return this.caption;
	}

	public void setCaption(String caption) {
		this.caption = caption;
	}

	public Timestamp getCreationDate() {
		return this.creationDate;
	}

	public void setCreationDate(Timestamp creationDate) {
		this.creationDate = creationDate;
	}

	public String getDescription() {
		return this.description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public BigDecimal getLikes() {
		return this.likes;
	}

	public void setLikes(BigDecimal likes) {
		this.likes = likes;
	}

	public String getLink() {
		return this.link;
	}

	public void setLink(String link) {
		this.link = link;
	}

	public String getMessage() {
		return this.message;
	}

	public void setMessage(String message) {
		this.message = message;
	}

	public String getPicture() {
		return this.picture;
	}

	public void setPicture(String picture) {
		this.picture = picture;
	}

	public String getType() {
		return this.type;
	}

	public void setType(String type) {
		this.type = type;
	}
	

	public String getSnId() {
		return snId;
	}

	public void setSnId(String snId) {
		this.snId = snId;
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

	public String getFeedRef() {
		return feedRef;
	}

	public void setFeedRef(String feedRef) {
		this.feedRef = feedRef;
	}
	
	

}