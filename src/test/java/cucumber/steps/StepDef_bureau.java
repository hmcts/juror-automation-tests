package cucumber.steps;

import org.openqa.selenium.WebDriver;


import io.cucumber.java.PendingException;
import io.cucumber.java.en.*;
import cucumber.pageObjects.Bureau;
import cucumber.pageObjects.Login;
import cucumber.pageObjects.NavigationShared;
import cucumber.pageObjects.SharedDriver;
import cucumber.pageObjects.aSamplePO;
import io.cucumber.java.After;
import io.cucumber.java.Before;


import org.openqa.selenium.support.PageFactory;

public class StepDef_bureau {
	
	private aSamplePO SPO;
	private Login LGN;
	private NavigationShared NAV;
	private Bureau BUR;
	private final WebDriver webDriver;
	
	public StepDef_bureau(SharedDriver webDriver) {
		this.webDriver = webDriver;
		SPO = PageFactory.initElements(webDriver, aSamplePO.class);
		LGN = PageFactory.initElements(webDriver, Login.class);
		NAV = PageFactory.initElements(webDriver, NavigationShared.class);
		BUR = PageFactory.initElements(webDriver, Bureau.class);
	}
		
	
	@Then("^my \"([^\"]*)\" Juror \"([^\"]*)\" is \"([^\"]*)\"$")
	public void oldNew_jurorRowFor_containsText(String oldNew, String row, String text) {
		try{
			BUR.oldNew_jurorRowFor_containsText(oldNew, row, text);
		} catch (Exception e) {
			BUR.oldNew_jurorRowFor_containsText(oldNew, row, text);
		}

	};
	
	@When("^I set \"([^\"]*)\" to \"([^\"]*)\" for \"([^\"]*)\"$")
	public void set_valueTo_value_underHeader(String fieldName, String value, String headerText){
	    try{
	    	BUR.set_valueTo_value_underHeader(fieldName, value, headerText);
	    } catch (Exception e) {
	    	BUR.set_valueTo_value_underHeader(fieldName, value, headerText);
	    }
	};
	
	@When("^I set the radio button to \"([^\"]*)\" under \"([^\"]*)\"$")
	public void setRadioButton_toValue_underText(String radioName, String underText) {
	    try {
	    	BUR.setRadioButton_toValue_underText(radioName, underText);
	    } catch (Exception e) {
	    	BUR.setRadioButton_toValue_underText(radioName, underText);
	    }
	};
	
	@When("^I assign all the New Replies to \"([^\"]*)\"$")
	public void assignNewReplies_toStaff(String staffMember) throws Throwable {
		try {
 			BUR.assignNewReplies_toStaff(staffMember);
		} catch (Exception e) {
			NAV.waitForPageLoad();
			BUR.assignNewReplies_toStaff(staffMember);
		}
	};

	
}