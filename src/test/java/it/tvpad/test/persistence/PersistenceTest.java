package it.tvpad.test.persistence;

import java.io.File;

import org.apache.log4j.PropertyConfigurator;

import it.tvpad.control.database.DatabaseService;
import it.tvpad.control.database.exception.DatabaseConnectionException;
import it.tvpad.control.properties.db.DatabasePropertiesReader;
import it.tvpad.control.properties.exception.PropertiesException;

public class PersistenceTest {

	private static final String DB_PROPERTIES_PATH = "config" + File.separator + "database.properties";

	public static void main(String[] args) {

		PropertyConfigurator.configure("config" + File.separator + "log4j.properties");

		DatabasePropertiesReader dbPropReader = new DatabasePropertiesReader(DB_PROPERTIES_PATH);
		try {
			dbPropReader.loadProperties();
		} catch (PropertiesException e) {
			e.printStackTrace();
			return;
		}

		DatabaseService dbService = new DatabaseService();
		dbService.setDriver(dbPropReader.getDatabaseDriver());
		dbService.setUrl(dbPropReader.getDatabaseUrl());
		dbService.setUser(dbPropReader.getUserName());
		dbService.setPassword(dbPropReader.getPassword());

		try {
			dbService.connect();
			dbService.disconnect();
		} catch (DatabaseConnectionException e) {
			e.printStackTrace();
		}

	}

}
