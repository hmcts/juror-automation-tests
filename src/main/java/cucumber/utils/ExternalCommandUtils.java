package cucumber.utils;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Properties;

import org.apache.chemistry.opencmis.client.api.Repository;
import org.apache.chemistry.opencmis.client.api.Session;
import org.apache.chemistry.opencmis.client.api.SessionFactory;
import org.apache.chemistry.opencmis.client.runtime.SessionFactoryImpl;
import org.apache.chemistry.opencmis.commons.SessionParameter;
import org.apache.chemistry.opencmis.commons.enums.BindingType;
import org.apache.log4j.Logger;

import cucumber.pageObjects.MessageLoader;

public class ExternalCommandUtils {
	
	private static Logger log = Logger.getLogger(MessageLoader.class);
	
	public static Session returnSession() {
		
		SessionFactory factory = SessionFactoryImpl.newInstance();
		
		Map<String, String> parameter = new HashMap<String, String>();

		// user credentials
		parameter.put(SessionParameter.USER, 
					ReadProperties.main("alfresco_user")
				);
		parameter.put(SessionParameter.PASSWORD,
					ReadProperties.main("alfresco_password")
				);

		// connection settings
		parameter.put(SessionParameter.BROWSER_URL, 
					ReadProperties.main("alfresco_url")
				);
		parameter.put(SessionParameter.BINDING_TYPE, BindingType.BROWSER.value());
		
		
		parameter.put(SessionParameter.REPOSITORY_ID, 
					ReadProperties.main("alfresco_repository_id")
				);
			
		// create session
		Session session = factory.createSession(parameter);
		
		//List<Repository> repositories = factory.getRepositories(parameter);
		//Session session = repositories.get(0).createSession();
		log.info("Made successful connection to alfresco =>"
					+ ReadProperties.main("alfresco_url")
				);
		return session;
	}
	
}