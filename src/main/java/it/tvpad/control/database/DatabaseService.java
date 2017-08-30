package it.tvpad.control.database;

import it.tvpad.control.database.exception.DatabaseConnectionException;
import it.tvpad.control.database.exception.DatabaseException;
import it.tvpad.model.data.facebook.FacebookData;
import it.tvpad.model.data.tweet.Tweet;
import it.tvpad.model.request.Request;
import it.tvpad.model.request.Source;

import java.sql.Timestamp;
import java.util.HashMap;
import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.NoResultException;
import javax.persistence.Persistence;
import javax.persistence.PersistenceException;

import org.eclipse.persistence.config.CacheUsage;
import org.eclipse.persistence.config.QueryHints;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class DatabaseService {

	private static final String PERSISTENCE_UNIT_NAME = "SocialNetworkDataDownloader";
	private static Logger logger = LoggerFactory.getLogger(DatabaseService.class);
	private static EntityManagerFactory factory;
	private EntityManager entityManager;
	private String url;
	private String user;
	private String password;
	private String driver;

	// QUERYES ()

	public void setUrl(String url) {
		this.url = url;
	}

	public void setUser(String user) {
		this.user = user;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public void setDriver(String driver) {
		this.driver = driver;
	}

	public void connect() throws DatabaseConnectionException {

		HashMap<String, String> dbPropertiesMap = new HashMap<String, String>();
		dbPropertiesMap.put("javax.persistence.jdbc.url", url);
		dbPropertiesMap.put("javax.persistence.jdbc.user", user);
		dbPropertiesMap.put("javax.persistence.jdbc.password", password);
		dbPropertiesMap.put("javax.persistence.jdbc.driver", driver);

		factory = Persistence.createEntityManagerFactory(PERSISTENCE_UNIT_NAME, dbPropertiesMap);
		if (factory != null) {
			try {
				entityManager = factory.createEntityManager();
				logger.info("Connected to database");
			} catch (PersistenceException e) {
				logger.error("Unable to connect to database");
			}

		} else {
			throw new DatabaseConnectionException(
					"No Persistence provider for EntityManager named:" + PERSISTENCE_UNIT_NAME);
		}
	}

	public void disconnect() {
		if (entityManager != null) {
			if (entityManager.isOpen()) {
				entityManager.close();
				logger.info("Disconnected from database");
			}
		}
	}

	public Request getRequest(Long requestId) throws DatabaseException {
		try {
			Request request = (Request) entityManager.createNamedQuery("Request.findById").setParameter("id", requestId)
					.setHint(QueryHints.CACHE_USAGE, CacheUsage.DoNotCheckCache).getSingleResult();
			entityManager.refresh(request);
			return request;
		} catch (NoResultException e) {
			throw new DatabaseException("Request with id " + requestId + " not found");
		}
	}

	@SuppressWarnings("unchecked")
	public List<Source> getSources() throws DatabaseException {
		try {

			List<Source> listSources = (List<Source>) entityManager.createNamedQuery("Source.findById").getResultList();
			return listSources;
		} catch (NoResultException e) {
			throw new DatabaseException("Source list not found");
		}
	}

	public void storeTweet(Tweet tweet) throws DatabaseException {
		try {
			entityManager.getTransaction().begin();
		//	System.out.println(tweet.getText());
		//	String newtext = EmojiParser.parseToAliases(tweet.getText());
		//	System.out.println(newtext);
		//	System.out.println("------------------------");
		//	tweet.setText(newtext);
			
			entityManager.persist(tweet);
			entityManager.getTransaction().commit();
		} catch (Exception e) {
			throw new DatabaseException(e.getMessage());
		}
	}

	public void storeTweetList(List<Tweet> tweets) throws DatabaseException {
		try {
			entityManager.getTransaction().begin();
		//	System.out.println(tweet.getText());
		//	String newtext = EmojiParser.parseToAliases(tweet.getText());
		//	System.out.println(newtext);
		//	System.out.println("------------------------");
		//	tweet.setText(newtext);
			for (Tweet t : tweets)
				entityManager.persist(t);
			entityManager.getTransaction().commit();
		} catch (Exception e) {
			throw new DatabaseException(e.getMessage());
		}
	}

	public void storeFacebookData(FacebookData data) throws DatabaseException {
		try {
			entityManager.getTransaction().begin();
			entityManager.persist(data);
			entityManager.getTransaction().commit();
		} catch (Exception e) {
			throw new DatabaseException(e.getMessage());
		}
	}
	
	public void storeFacebookDataList(List<FacebookData> dataset) throws DatabaseException {
		try {
			entityManager.getTransaction().begin();
			for (FacebookData data : dataset)
				entityManager.persist(data);
			entityManager.getTransaction().commit();
		} catch (Exception e) {
			throw new DatabaseException(e.getMessage());
		}
	}
	

	public void setEndSavingDate(Long requestId, Timestamp t) throws DatabaseException {
		Request r;
		try {
			r = getRequest(requestId);
			entityManager.getTransaction().begin();
			r.setEndSavingDate(t);
			entityManager.getTransaction().commit();
		} catch (DatabaseException e) {
			throw new DatabaseException(e.getMessage());
		}
	}
}
