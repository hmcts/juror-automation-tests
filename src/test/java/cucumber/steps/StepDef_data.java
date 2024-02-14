package cucumber.steps;

import org.openqa.selenium.WebDriver;

import io.cucumber.java.PendingException;
import io.cucumber.java.en.*;
import cucumber.pageObjects.Login;
import cucumber.pageObjects.NavigationShared;
import cucumber.pageObjects.SharedDriver;
import cucumber.pageObjects.aSamplePO;
import cucumber.testdata.DataSetup;
import cucumber.testdata.DatabaseTester;
import io.cucumber.java.Before;
import io.cucumber.java.After;


import org.openqa.selenium.support.PageFactory;

public class StepDef_data {
	
	private aSamplePO SPO;
	private Login LGN;
	private DataSetup DBB;
	private NavigationShared NAV;
	private DatabaseTester DBT;
	private final WebDriver webDriver;
	
	public StepDef_data(SharedDriver webDriver) {
		this.webDriver = webDriver;
		SPO = PageFactory.initElements(webDriver, aSamplePO.class);
		LGN = PageFactory.initElements(webDriver, Login.class);
		NAV = PageFactory.initElements(webDriver, NavigationShared.class);
		DBB = PageFactory.initElements(webDriver, DataSetup.class);
		DBT = PageFactory.initElements(webDriver, DatabaseTester.class);
	}
		
	@When("^that \"([^\"]*)\" has never logged in before$")
	public void makeUserFirstTime(String username) throws Throwable {
	    DBB.setUser_firstTimeLogin(username);
	}	
	
	
	@Given("^that admin user \"([^\"]*)\" has never logged in before$")
	public void makeUserFirstTime_admin (String username) {
	    DBB.setAdmin_firstTimeLogin(username);
	};
	
	
	@When("^I have reset user \"([^\"]*)\"$")
	public void resetUser(String username) throws Throwable {
	    DBT.resetUser(username);
	}	
	
	@Given("^I have cleared down the juror digital database$")
	public void resetJurorDigitalDatabase() throws Throwable {
	    DBT.resetJurorDigitalDatabase();
	}	
	
	@Given("^\"([^\"]*)\" has attribute \"([^\"]*)\" set as \"([^\"]*)\"$")
	public void setAttribute(String username, String attribute, String attributeValue) {
		DBB.setUser_attribute(username, attribute, attributeValue);
	}
	
	@Given("^\"([^\"]*)\" attribute \"([^\"]*)\" is not \"([^\"]*)\"$")
	public void notAttribute(String username, String attribute, String attributeValue) throws Exception {
		DBB.checkUser_attributeAgainst_trueFalse(username, attribute, attributeValue, false);
	}
	
	@Given("^I reset \"([^\"]*)\" password to \"([^\"]*)\"$")
	public void set_password_to(String username, String password) {
		DBB.setUser_password(username, password);
	}	
	
	@Given("^\"([^\"]*)\" is compliant$")
	public void compliantUser(String username) {
		DBB.setUser_compliant(username);
	}
	@Given("^admin \"([^\"]*)\" is compliant$")
	public void compliantAdmin(String username) {
		DBB.setAdmin_compliant(username);
	}
	
	@Given("^\"([^\"]*)\" is in group \"([^\"]*)\" in area \"([^\"]*)\" with content \"([^\"]*)\" and subscription type of \"([^\"]*)\"$")
	public void setUser_groupContentSubscription_for_area(String username, String group, String content, String area, String subscription) {
		DBB.setUser_contentSubscription(username, group, area, content, subscription);
	}
	
	@Given("^\"([^\"]*)\" for lja \"([^\"]*)\" with ou group \"([^\"]*)\" for courtroom \"([^\"]*)\" is present on \"([^\"]*)\"$")
	public void setupDocumentData_lja_group_courtroom_date(String documentType, String ljaCode, String groupDescription, String courtroom, String sessionDate) {
		DBB.setupDocumentData(
					documentType,
					ljaCode,
					groupDescription,
					courtroom,
					sessionDate
				);
	}
	
	@Given("^that \"([^\"]*)\" does not exist$")
	public void deleteUser_withName(String username) {
		DBB.deleteUser_byName(username);
	}
	
	@Given("^Organisation group with name \"([^\"]*)\" does not exist$")
	public void deleteOrganisation_withName(String organisation) {
	    DBB.deleteOrganisation_byName(organisation);
	};
	
	@Given("^Organisation group with name \"([^\"]*)\" exists$")
	public void createOrganisation_withName(String organisation){
		DBB.createOrganisation_byName(organisation);
	};
	
	@Given("^Organisation \"([^\"]*)\" has entry \"([^\"]*)\"$")
	public void organisation_withEntry(String organisation, String entry) {
	    DBB.createEntry_forOrganisation_byName(organisation, entry);
	};
	
	@Given("^Organisation \"([^\"]*)\" has an entry called \"([^\"]*)\" under \"([^\"]*)\"$")
	public void createOrganisationGroup_entry(String organisation, String cn, String ou){
	    DBB.createEntry_forOrganisationGroup_byName(organisation, ou, cn);
	};
	
	
	
	
	
}