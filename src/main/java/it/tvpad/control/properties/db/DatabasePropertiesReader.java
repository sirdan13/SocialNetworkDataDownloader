package it.tvpad.control.properties.db;

import it.tvpad.control.properties.AbstractPropertiesReader;
import it.tvpad.control.properties.exception.PropertiesException;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class DatabasePropertiesReader extends AbstractPropertiesReader {

	private static Logger logger = LoggerFactory.getLogger(DatabasePropertiesReader.class);
	private String host;
	private String port;
	private String databaseName;
	private String userName;
	private String password;
	private String databaseType;
	private String databaseDriver;
	
	public DatabasePropertiesReader(String path) {
		super(path);		
	}
	
	@Override
	public void loadProperties() throws PropertiesException {
		super.loadProperties();
		logger.info("DATABASE PARAMETERS");
		// parsing of database_driver parameter
		databaseDriver = properties.getProperty("database_driver");
		if (databaseDriver == null) {
			throw new PropertiesException("A value for property \"database_driver\" must be specified");
		} 
		logger.info("DATABASE DRIVER: "+databaseDriver);
		
		// parsing of database_type parameter
		databaseType = properties.getProperty("database_type");
		if (databaseType == null) {
			throw new PropertiesException("A value for property \"database_type\" must be specified");
		} 
		logger.info("DATABASE TYPE: "+databaseType);
		
		// parsing of host parameter
		host = properties.getProperty("database_host");
		if (host == null) {
			throw new PropertiesException("A value for property \"database_host\" must be specified");
		} 
		logger.info("DATABASE HOST: "+host);
		
		// parsing of port parameter
		port = properties.getProperty("database_port");
		if (port == null) {
			throw new PropertiesException("A value for property \"database_port\" must be specified");
		} 
		logger.info("DATABASE PORT: "+port);
		
		// parsing of database_name parameter
		databaseName = properties.getProperty("database_name");
		if (databaseName == null) {
			throw new PropertiesException("A value for property \"database_name\" must be specified");
		} 
		logger.info("DATABASE NAME: "+databaseName);
		
		// parsing of datbase_user_name parameter
		userName = properties.getProperty("datbase_user_name");
		if (userName == null) {
			throw new PropertiesException("A value for property \"datbase_user_name\" must be specified");
		} 
		logger.info("DATABASE USER NAME: "+userName);
		
		// parsing of database_user_password parameter
		password = properties.getProperty("database_user_password");
		if (password == null) {
			throw new PropertiesException("A value for property \"database_user_password\" must be specified");
		} 
		logger.info("DATABASE USER PASSWORD: "+password);		
	}

	public String getHost() {
		return host;
	}

	public String getPort() {
		return port;
	}

	public String getDatabaseName() {
		return databaseName;
	}

	public String getUserName() {
		return userName;
	}

	public String getPassword() {
		return password;
	}
	
	
	public String getDatabaseType() {
		return databaseType;
	}

	public String getDatabaseDriver() {
		return databaseDriver;
	}

	public String getDatabaseUrl(){
		return "jdbc:"+databaseType+"://"+host+":"+port+";databaseName="+databaseName;
		
	}
	
	

}
