package it.tvpad.control.properties.twitter;

import java.util.ArrayList;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.List;
import java.util.Properties;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import it.tvpad.control.properties.AbstractPropertiesReader;
import it.tvpad.control.properties.exception.PropertiesException;

public class TwitterPropertiesReader extends AbstractPropertiesReader{
	
	private static Logger logger = LoggerFactory.getLogger(TwitterPropertiesReader.class);
	private String  consumerKey;
	private String  consumerSecret;
	private String  accessToken;	
	private String  accessTokenSecret; 	
	private List<String> basePropertiesList;
	private HashMap<String, String> extendedTwitterProperties;
			
			
	public TwitterPropertiesReader(String path) {
		super(path);		
	}
	
	@Override
	public void loadProperties() throws PropertiesException{
		super.loadProperties();
		Properties properties = super.getProperties();
		
		// parsing of twitter4j.oauth.consumerKey parameter
		consumerKey = properties.getProperty("twitter4j.oauth.consumerKey");
		if (consumerKey == null) {
			throw new PropertiesException("A value for property \"twitter4j.oauth.consumerKey\" must be specified");
		}		
		logger.info("TWITTER CONSUMER KEY: "+consumerKey);
		// parsing of twitter4j.oauth.consumerSecret parameter
		consumerSecret = properties.getProperty("twitter4j.oauth.consumerSecret");
		if (consumerSecret == null) {
			throw new PropertiesException("A value for property \"twitter4j.oauth.consumerSecret\" must be specified");
		}		
		logger.info("TWITTER CONSUMER SECRET: "+consumerSecret);
		
		// parsing of twitter4j.oauth.accessToken parameter
		accessToken = properties.getProperty("twitter4j.oauth.accessToken");
		if (accessToken == null) {
			throw new PropertiesException("A value for property \"twitter4j.oauth.accessToken\" must be specified");
		}		
		logger.info("TWITTER ACCESS TOKEN: "+accessToken);
		// parsing of twitter4j.oauth.accessTokenSecret parameter
		accessTokenSecret = properties.getProperty("twitter4j.oauth.accessTokenSecret");
		if (accessTokenSecret == null) {
			throw new PropertiesException("A value for property \"twitter4j.oauth.accessTokenSecret\" must be specified");
		}		
		logger.info("TWITTER ACCESS TOKEN SECRET: "+accessTokenSecret);
		
		basePropertiesList = new ArrayList<String>();
		basePropertiesList.add("twitter4j.oauth.consumerKey");
		basePropertiesList.add("twitter4j.oauth.consumerSecret");
		basePropertiesList.add("twitter4j.oauth.accessToken");
		basePropertiesList.add("twitter4j.oauth.accessTokenSecret");

		//Properties systemProperties = System.getProperties();setProperty(param, param);
		Enumeration<Object> propKeyEnum = properties.keys();
		extendedTwitterProperties = new HashMap<String, String>();
		while(propKeyEnum.hasMoreElements()){
			String param = (String) propKeyEnum.nextElement();
			if(!basePropertiesList.contains(param)){
				String value = properties.getProperty(param);
				extendedTwitterProperties.put(param, value);
				logger.info(param+": "+value);
			}	
			
		}		
	}

	public String getConsumerKey() {
		return consumerKey;
	}

	public String getConsumerSecret() {
		return consumerSecret;
	}

	public String getAccessToken() {
		return accessToken;
	}

	public String getAccessTokenSecret() {
		return accessTokenSecret;
	}

	public HashMap<String, String> getExtendedTwitterProperties() {
		return extendedTwitterProperties;
	}
	

}
