package cucumber.steps;

import org.openqa.selenium.WebDriver;

import cucumber.pageObjects.Login;
import cucumber.pageObjects.NavigationShared;
import cucumber.pageObjects.Notify;
import cucumber.pageObjects.SharedDriver;
import cucumber.pageObjects.aSamplePO;
import cucumber.testdata.DataSetup;

import io.cucumber.java.en.*;
import io.cucumber.java.PendingException;
import io.cucumber.datatable.DataTable;
import io.cucumber.java.Before;
import io.cucumber.java.After;
import io.cucumber.java.Scenario;

import org.openqa.selenium.support.PageFactory;

public class StepDef_notify {
	
	private aSamplePO SPO;
	private Login LGN;
	private NavigationShared NAV;
	private Notify NOT;
	private DataSetup DBB;
	private final WebDriver webDriver;
	
	public StepDef_notify(SharedDriver webDriver) {
		this.webDriver = webDriver;
		SPO = PageFactory.initElements(webDriver, aSamplePO.class);
		LGN = PageFactory.initElements(webDriver, Login.class);
		NAV = PageFactory.initElements(webDriver, NavigationShared.class);
		NOT = PageFactory.initElements(webDriver, Notify.class);
		DBB = PageFactory.initElements(webDriver, DataSetup.class);
	}
		
	
	@When("^I log in with \"([^\"]*)\" and my temporary password$")
	public void logInWith_NotifyTemporaryPassword (String username) throws Throwable{
	    String password = DBB.returnPassword_byUsername_fromNotify(username);
	    LGN.login(username, password);
	};
	
	@Then("^I can see I am not subscribed to Notifications$")
	public void amNot_subscribedToNotifications(){
	    NOT.amNot_subscribedToNotifications();
	};
	
	@Then("^I can see I am subscribed to Notifications$")
	public void am_subscribedToNotifications(){
	    NOT.am_subscribedToNotifications();
	};
	
}