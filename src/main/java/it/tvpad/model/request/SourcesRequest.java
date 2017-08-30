package it.tvpad.model.request;

import java.io.Serializable;

import javax.persistence.*;


/**
 * The persistent class for the SOURCES_REQUEST database table.
 * 
 */
@Entity
@Table(name="SOURCES_REQUEST")
@NamedQueries({
	@NamedQuery(name="SourcesRequest.findAll", query="SELECT s FROM SourcesRequest s")	
})

public class SourcesRequest implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	@Column(name="ID")
	private long id;

	//bi-directional many-to-one association to Request
	@ManyToOne
	@JoinColumn(name="REQUEST_ID" , nullable=false)
	private Request request;

	//bi-directional many-to-one association to Source
	@ManyToOne
	@JoinColumn(name="SOURCE_ID", nullable=false)
	private Source source;

	public SourcesRequest() {
	}

	public long getId() {
		return this.id;
	}

	public void setId(long id) {
		this.id = id;
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

}