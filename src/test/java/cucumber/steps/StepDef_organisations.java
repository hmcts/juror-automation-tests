package cucumber.steps;

import org.openqa.selenium.WebDriver;
import cucumber.pageObjects.Groups;
import cucumber.pageObjects.Login;
import cucumber.pageObjects.NavigationShared;
import cucumber.pageObjects.Organisations;
import cucumber.pageObjects.SharedDriver;
import cucumber.pageObjects.aSamplePO;

import io.cucumber.java.en.*;
import io.cucumber.java.PendingException;
import io.cucumber.datatable.DataTable;
import io.cucumber.java.Before;
import io.cucumber.java.After;
import io.cucumber.java.Scenario;

import org.openqa.selenium.support.PageFactory;

public class StepDef_organisations {
	
	private aSamplePO SPO;
	private Login LGN;
	private Groups GRP;
	private Organisations ORG;
	private NavigationShared NAV;
	private final WebDriver webDriver;
	
	public StepDef_organisations(SharedDriver webDriver) {
		this.webDriver = webDriver;
		SPO = PageFactory.initElements(webDriver, aSamplePO.class);
		LGN = PageFactory.initElements(webDriver, Login.class);
		NAV = PageFactory.initElements(webDriver, NavigationShared.class);
		GRP = PageFactory.initElements(webDriver, Groups.class);
		ORG = PageFactory.initElements(webDriver, Organisations.class);
	}	
	
	@Then("^I see \"([^\"]*)\" is not subscribed to Notifications$")
	public void textUser_notSubscribedToNotifications (String text){
    	ORG.confirmTextUserNot_subscribedToNotifications(text);
	};

	@Then("^I see \"([^\"]*)\" is subscribed to Notifications$")
	public void textUser_subscribedToNotifications(String text){
    	ORG.confirmTextUser_subscribedToNotifications(text);
	};
	
}
