package cucumber.steps;

import org.openqa.selenium.OutputType;
import org.openqa.selenium.TakesScreenshot;
import org.openqa.selenium.WebDriver;
import cucumber.pageObjects.Login;
import cucumber.pageObjects.NavigationShared;
import cucumber.pageObjects.ScreenShotTaker;
import cucumber.pageObjects.SharedDriver;
import cucumber.pageObjects.SuspendDelete;
import cucumber.pageObjects.aSamplePO;
import io.cucumber.java.en.*;
import io.cucumber.java.PendingException;
import io.cucumber.datatable.DataTable;
import io.cucumber.java.Before;
import io.cucumber.java.After;
import io.cucumber.java.Scenario;

import org.openqa.selenium.support.PageFactory;

public class StepDef_suspendDelete {
	
	private aSamplePO SPO;
	private Login LGN;
	private SuspendDelete SD;
	private NavigationShared NAV;
	private final WebDriver webDriver;
	private ScreenShotTaker SST;
	
	public StepDef_suspendDelete(SharedDriver webDriver) {
		this.webDriver = webDriver;
		SPO = PageFactory.initElements(webDriver, aSamplePO.class);
		LGN = PageFactory.initElements(webDriver, Login.class);
		NAV = PageFactory.initElements(webDriver, NavigationShared.class);
		SST = PageFactory.initElements(webDriver, ScreenShotTaker.class);
		SD = PageFactory.initElements(webDriver, SuspendDelete.class);
	}
	
	@Then("^under the \"([^\"]*)\" heading I see \"([^\"]*)\"$")
	public void seeText_underHeading(String heading, String text){
	    try{
	    	SD.seeText_underHeading(text, heading);
	    } catch (Exception e) {
	    	NAV.waitForPageLoad();
	    	SD.seeText_underHeading(text, heading);
	    }
	};

	@Then("^under the \"([^\"]*)\" heading I do not see \"([^\"]*)\"$")
	public void doNotSeeText_underHeading(String heading, String text){
	    try{
	    	SD.seeText_underHeading(text, heading);
	    	throw new Error("Saw text under heading when not expected");
	    } catch (Exception e) {
	    	//pass
	    }

	};
	
}

