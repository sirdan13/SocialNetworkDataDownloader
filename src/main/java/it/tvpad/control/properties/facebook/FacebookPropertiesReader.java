package it.tvpad.control.properties.facebook;

import java.util.Properties;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import it.tvpad.control.properties.AbstractPropertiesReader;
import it.tvpad.control.properties.exception.PropertiesException;

public class FacebookPropertiesReader extends AbstractPropertiesReader {
	
	private String appId;
	private String appSecret;
	private String grant;
	private String redirectBaseUri;
	private String accessTokenUri;
	private Integer serverPort;
	private static Logger logger = LoggerFactory.getLogger(FacebookPropertiesReader.class);
	
	public FacebookPropertiesReader(String path) {
		super(path);		
	}
	
	@Override
	public void loadProperties() throws PropertiesException {
		
		super.loadProperties();
		Properties properties = super.getProperties();
		
		// parsing of facebook.app.id parameter
		appId = properties.getProperty("facebook.app.id");
		if (appId == null) {
			throw new PropertiesException("A value for property \"facebook.app.id\" must be specified");
		}		
		logger.info("FACEBOOK APP ID: "+appId);
		
		// parsing of facebook.app.secret parameter
		appSecret = properties.getProperty("facebook.app.secret");
		if (appSecret == null) {
			throw new PropertiesException("A value for property \"facebook.app.secret\" must be specified");
		}		
		logger.info("FACEBOOK APP SECRET: "+appSecret);	
		
		// parsing of facebook.app.redirect.base.uri parameter
		redirectBaseUri = properties.getProperty("facebook.app.redirect.base.uri");
		if (redirectBaseUri == null) {
			throw new PropertiesException("A value for property \"facebook.app.redirect.base.uri\" must be specified");
		}		
		logger.info("FACEBOOK REDIRECT BASE URI: "+redirectBaseUri);
		
		// parsing of facebook.app.grant parameter
		grant = properties.getProperty("facebook.app.grant");
		if (grant == null) {
			throw new PropertiesException("A value for property \"facebook.app.grant\" must be specified");
		}		
		logger.info("FACEBOOK GRANT: "+grant);	
		
		// parsing of facebbok.app.access.token.uri parameter
		accessTokenUri = properties.getProperty("facebbok.app.access.token.uri");
		if (accessTokenUri == null) {
			throw new PropertiesException("A value for property \"facebbok.app.access.token.uri\" must be specified");
		}		
		logger.info("FACEBOOK ACCESS TOKEN URI: "+accessTokenUri);
		
		// parsing of facebook.server.port parameter
		String serverPortStr = properties.getProperty("facebook.server.port");
		if (serverPortStr == null) {
			throw new PropertiesException("A value for property \"facebook.server.port\" must be specified");
		}else{
			try {
				serverPort = Integer.parseInt(serverPortStr);
				if(serverPort < 0 || serverPort > 65535){
					throw new PropertiesException("A value for property \"facebook.server.port\" must be an integer between 0 and  65535");
				}
			} catch (NumberFormatException e) {
				throw new PropertiesException("A value for property \"facebook.server.port\" must be an integer between 0 and  65535");
			}
		}		
		logger.info("FACEBOOK SERVER PORT: "+serverPort);
	}

	public String getAppId() {
		return appId;
	}

	public String getAppSecret() {
		return appSecret;
	}

	public String getGrant() {
		return grant;
	}

	public String getRedirectBaseUri() {
		return redirectBaseUri;
	}

	public String getAccessTokenUri() {
		return accessTokenUri;
	}

	public Integer getServerPort() {
		return serverPort;
	}
	
	

}
