package cucumber.utils;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.Properties;

import org.apache.log4j.Logger;

import cucumber.pageObjects.NavigationShared;

public class ReadProperties {
	private static Logger log = Logger.getLogger(ReadProperties.class);
	
	public static String main(String property) {
		Properties prop = new Properties();
		
		File file = new File("src/test/resources/environment.properties");
		FileInputStream fileInput = null;
		
		try {
			fileInput = new FileInputStream(file);
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		}
		
		try {
			prop.load(fileInput);
		} catch (IOException e) {
			e.printStackTrace();
		}

	    String propertyValue = prop.getProperty(property);
		if (propertyValue == null) {
			log.info("Getting value for "+property+" from Environment Variable");
			propertyValue = System.getenv(property.toUpperCase());
		}
		return propertyValue;
	}
	
	public static String machine(String property) {
		Properties prop = new Properties();
		
		File file = new File("src/test/resources/workstation.properties");
		FileInputStream fileInput = null;
		
		try {
			fileInput = new FileInputStream(file);
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		}
		
		try {
			prop.load(fileInput);
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		return prop.getProperty(property);
	}

	public static String systemPropertyEnvironmentOverrideCheck(String env) {
		String systemEnv = System.getProperty ("envName");
		if (systemEnv != null) {
			log.info("The script asked me to use =>"+env+"<= but this has been overriden by System property to use =>"+systemEnv);
			return systemEnv.toLowerCase();
		}
		
		return env;
	}
	
}