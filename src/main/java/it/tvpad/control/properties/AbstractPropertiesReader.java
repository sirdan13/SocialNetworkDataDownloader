package it.tvpad.control.properties;

import it.tvpad.control.properties.exception.PropertiesException;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.util.Properties;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public abstract class AbstractPropertiesReader {
	
	private static Logger logger = LoggerFactory.getLogger(AbstractPropertiesReader.class);
	protected Properties properties;
	protected String path;
	
	public AbstractPropertiesReader(String path) {
		this.path = path;
		properties = new Properties();
	}
	
	public void loadProperties() throws PropertiesException{
		try {
			logger.info("Loading properties file : "+path);
			properties.load(new FileReader(new File(path)));
		} catch (FileNotFoundException e) {
			throw new PropertiesException("File "+path+" not found");
		} catch (IOException e) {
			throw new PropertiesException("Impossible to load file "+path);
		}
	}
	
	public Properties getProperties(){
		return properties;
	}
	

}
