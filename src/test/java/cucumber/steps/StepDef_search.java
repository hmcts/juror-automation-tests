package cucumber.steps;

import org.openqa.selenium.OutputType;
import org.openqa.selenium.TakesScreenshot;
import org.openqa.selenium.WebDriver;
import cucumber.pageObjects.Login;
import cucumber.pageObjects.NavigationShared;
import cucumber.pageObjects.ScreenShotTaker;
import cucumber.pageObjects.SharedDriver;
import cucumber.pageObjects.Search;
import cucumber.pageObjects.aSamplePO;
import io.cucumber.java.en.*;
import io.cucumber.java.PendingException;
import io.cucumber.datatable.DataTable;
import io.cucumber.java.Before;
import io.cucumber.java.After;
import io.cucumber.java.Scenario;

import org.openqa.selenium.support.PageFactory;

public class StepDef_search {
	
	private aSamplePO SPO;
	private Login LGN;
	private NavigationShared NAV;
	private final WebDriver webDriver;
	private ScreenShotTaker SST;
	private Search SEARCH;
	
	public StepDef_search(SharedDriver webDriver) {
		this.webDriver = webDriver;
		SPO = PageFactory.initElements(webDriver, aSamplePO.class);
		LGN = PageFactory.initElements(webDriver, Login.class);
		NAV = PageFactory.initElements(webDriver, NavigationShared.class);
		SST = PageFactory.initElements(webDriver, ScreenShotTaker.class);
		SEARCH = PageFactory.initElements(webDriver, Search.class);
	}
	
	@When("^I search for person/organisation with a value of \"([^\"]*)\"$")
	public void  search_personOrganisationTopSearch(String arg1){
	    try{
	    	SEARCH.search_personOrganisationTopSearch(arg1);
	    } catch (Exception e) {
	    	NAV.waitForPageLoad();
	    	SEARCH.search_personOrganisationTopSearch(arg1);
	    }
	};

	
	

}

