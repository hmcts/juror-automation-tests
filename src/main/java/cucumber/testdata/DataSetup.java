package cucumber.testdata;

import cucumber.pageObjects.aSamplePOWithDB;
import cucumber.utils.RequestHandler;
import org.apache.log4j.Logger;

import java.sql.CallableStatement;
import java.sql.Connection;

import static org.junit.Assert.assertEquals;

public class DataSetup {

	private static Logger log = Logger.getLogger(aSamplePOWithDB.class);

	private DBConnection db;
	private Connection conn;
	private CallableStatement stmt = null;

	/**
	 * Refactor me - Add Environmental Logic
	 * @param username
	 */
	public void setUser_firstTimeLogin(String username)  {
		
		// Add Environment selector here
		String url = "http://10.200.11.4:8000/10.200.11.11/user/"
				+ username
				+ "/create/basic";
		
		try {
			RequestHandler.request_post(url);
			resetUser(username);
		} catch (Exception e) {
			log.warn("Unexpected Exception after creating user and resetting it");
		}
	}
	
	public void setAdmin_firstTimeLogin(String username)  {
		
		// Add Environment selector here
		String url = "http://10.200.11.4:8000/10.200.11.11/user/"
				+ username
				+ "/create/admin/basic";
		
		try {
			RequestHandler.request_post(url);
			resetUser(username);
		} catch (Exception e) {
			log.warn("Unexpected Exception after creating user and resetting it");
		}
	}

	public void resetUser(String username) {
		// Add Environment selector here
		String url = "http://10.200.11.4:8000/10.200.11.11/user/"
				+ username
				+ "/reset/all";		
		try {
			RequestHandler.request_post(url);
		} catch (Exception e) {
			log.warn("Unexpected Exception after creating user and resetting it");
		}
	}

	public void setUser_attribute(String username, String attribute, String attributeValue) {
		//http://10.200.11.4:8000/10.200.11.11/user/fred@gmail.com/attribute/telephoneNumber/replace/12333
		String url = "http://10.200.11.4:8000/10.200.11.11/user/"
				+ username
				+ "/attribute/"
				+ attribute
				+ "/replace/"
				+ attributeValue;		
		
		try {
			RequestHandler.request_post(url);
		} catch (Exception e) {
			log.warn("Unexpected Exception after Setting User Attribute");
		}
		
	}

	public void setUser_password(String username, String password) {
		//http://10.200.11.4:8000/10.200.11.11/user/fred@gmail.com/reset/password/password
		String url = "http://10.200.11.4:8000/10.200.11.11/user/"
				+ username
				+ "/reset/"
				+ "password/"
				+ password;
		
		try {
			RequestHandler.request_post(url);
		} catch (Exception e) {
			log.warn("Unexpected Exception after Setting User Password");
		}
		
	}

	public void setUser_compliant(String username) {
		String url = "http://10.200.11.4:8000/10.200.11.11/user/"
				+ username
				+ "/create/"
				+ "compliant";		
		try {
			RequestHandler.request_post(url);
		} catch (Exception e) {
			log.warn("Unexpected Exception after trying to create a compliant user");
		}		
	}
	
	public void setAdmin_compliant(String username) {
		String url = "http://10.200.11.4:8000/10.200.11.11/user/"
				+ username
				+ "/create/admin/"
				+ "compliant";
		try {
			RequestHandler.request_post(url);
		} catch (Exception e) {
			log.warn("Unexpected Exception after trying to create a compliant admin user");
		}
	}
	

	public void setUser_contentSubscription(String username, String group, String content, String area, String subscription) {
		///<hostname>/user/<username>/subscription/group/<group>/content/<content>/area/<area>/subscriptionType/<subscription_type>/
		subscription = subscription.replaceAll(" ", "%20");
		group = group.replaceAll(" ", "%20");
		content = content.replaceAll(" ", "%20");
		area = area.replaceAll(" ", "%20");
		
		
		String url = "http://10.200.11.4:8000/10.200.11.11/user/"
				+ username
				+ "/subscription/group/"
				+ group
				+ "/content/"
				+ content
				+ "/area/"
				+ area
				+ "/subscriptionType/"
				+ subscription
				+ "/";		
		try {
			RequestHandler.request_post(url);
		} catch (Exception e) {
			log.warn("Unexpected Exception after trying to setup contentSubscriptions for user");
		}	
		
	}

	public void setupDocumentData(String documentType, String ljaCode, String groupDescription, String courtroom,
			String sessionDate) {
		// http://10.200.11.4:8000/10.200.11.11/alfresco/lja/2163/sessionDate/17012018/ou/B01LA/courtroom/00/document/CL
		
		groupDescription = groupDescription.replaceAll(" ", "%20");
		documentType = documentType.replaceAll(" ", "%20");
		
		String url = "http://10.200.11.4:8000/10.200.11.13/alfresco/lja/"
				+ ljaCode
				+ "/sessionDate/"
				+ sessionDate
				+ "/ou/"
				+ groupDescription
				+ "/courtroom/"
				+ courtroom
				+ "/document/"
				+ documentType
				+ "";		
		try {
			RequestHandler.request_post(url);
		} catch (Exception e) {
			log.warn("Unexpected Exception after trying to add documents to alfresco");
		}
		
	}

	public void checkUser_attributeAgainst_trueFalse(String username, String attribute, String attributeValue, Boolean expected) throws Exception {
		// http://10.200.11.4:8000/10.200.11.11/user/jorge/attribute/lastLoginDate
		Boolean actual = false;
		String url = "http://10.200.11.4:8000/10.200.11.11/user/"
				+ username
				+ "/attribute/"
				+ attribute
				+ "/compare/"
				+ attributeValue;		
		
		try {
			RequestHandler.return_request_post(url, 200);
			actual = true; 
		} catch (Exception e) {
			log.warn("Did not get 200, returning false and continuing");
		}		
		log.info("Checking against Attribute value =>"+attributeValue);
		assertEquals(actual, expected);
		log.info("Attribute value is =>"+attributeValue+"<= as expected");
		
	}

	public void deleteUser_byName(String username) {		
		
		String url = "http://10.200.11.4:8000/10.200.11.11/user/"
				+ username
				+ "/delete";
		try {
			RequestHandler.request_post(url);
		} catch (Exception e) {
			log.warn("Unexpected Exception when trying to delete");
		}
	}

	public void deleteOrganisation_byName(String organisation) {
		String url = "http://10.200.11.4:8000/10.200.11.11/organisation/"
				+ organisation
				+ "/delete";
		try {
			RequestHandler.request_post(url);
		} catch (Exception e) {
			log.warn("Unexpected Exception when trying to delete");
		}		
	}

	public void createOrganisation_byName(String organisation) {
		String url = "http://10.200.11.4:8000/10.200.11.11/organisation/"
				+ organisation
				+ "/create/basic";
		try {
			RequestHandler.request_post(url);
		} catch (Exception e) {
			log.warn("Unexpected Exception when trying to create organisation");
		}
	}

	public void createEntry_forOrganisation_byName(String organisation, String entry) {
		///<hostname>/organisation/<organisation>/entry/<entry>/create/basic
		String url = "http://10.200.11.4:8000/10.200.11.11/organisation/"
				+ organisation
				+ "/entry/"
				+ entry
				+ "/create/basic";
		try {
			RequestHandler.request_post(url);
		} catch (Exception e) {
			log.warn("Unexpected Exception when trying to create organisation");
		}		
	}

	public void createEntry_forOrganisationGroup_byName(String organisation, String ou, String cn) {
		String url = "http://10.200.11.4:8000/10.200.11.11/common_name/"
				+ cn
				+ "/group/"
				+ ou
				+ "/organisation/"
				+ organisation
				+ "/create/basic";
		try {
			RequestHandler.request_post(url);
		} catch (Exception e) {
			log.warn("Unexpected Exception when trying to create organisation");
		}			
	}

	public String returnPassword_byUsername_fromNotify(String username) {
		String url = "http://10.200.11.4:8000/10.200.11.11/notify/"
				+ username
				+ "/password";		
		try {
			return RequestHandler.return_request_post(url);
		} catch (Exception e) {
			return "password";
		}
	}

}
