package it.tvpad.model.request;

import java.io.Serializable;
import javax.persistence.*;
import java.sql.Timestamp;

/**
 * The persistent class for the Event database table.
 * 
 */
@Entity
@NamedQueries({ @NamedQuery(name = "Event.findAll", query = "SELECT r FROM Event r"),
		@NamedQuery(name = "Event.findById", query = "SELECT r FROM Event r WHERE r.id = :id") })
public class Event implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "ID")
	private int id;

	@Column(name = "Duration")
	private int duration;

	@Column(name = "EndDate")
	private Timestamp endDate;

	@Column(name = "Name")
	private String name;

	@Column(name = "StartDate")
	private Timestamp startDate;

	public Event() {
	}

	public int getId() {
		return this.id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public int getDuration() {
		return this.duration;
	}

	public void setDuration(int duration) {
		this.duration = duration;
	}

	public Timestamp getEndDate() {
		return this.endDate;
	}

	public void setEndDate(Timestamp endDate) {
		this.endDate = endDate;
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
}