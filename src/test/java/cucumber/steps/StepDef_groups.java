package cucumber.steps;

import cucumber.pageObjects.*;
import io.cucumber.java.en.Given;
import io.cucumber.java.en.Then;
import io.cucumber.java.en.When;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.support.PageFactory;

import static org.testng.AssertJUnit.assertTrue;

public class StepDef_groups {
	
	private aSamplePO SPO;
	private Login LGN;
	private Groups GRP;
	private Organisations ORG;
	private NavigationShared NAV;
	private final WebDriver webDriver;
	
	public StepDef_groups(SharedDriver webDriver) {
		this.webDriver = webDriver;
		SPO = PageFactory.initElements(webDriver, aSamplePO.class);
		LGN = PageFactory.initElements(webDriver, Login.class);
		NAV = PageFactory.initElements(webDriver, NavigationShared.class);
		GRP = PageFactory.initElements(webDriver, Groups.class);
		ORG = PageFactory.initElements(webDriver, Organisations.class);
	}
	
	@Given("^I click on the icon next to \"([^\"]*)\"$")
	public void click_iconNextTo(String text) throws Exception{
	    try{
	    	GRP.click_iconNextTo(text);
	    } catch (Exception e) {
	    	NAV.waitForPageLoad();
	    	GRP.click_iconNextTo(text);
	    }
	}

	@Then("^I see \"([^\"]*)\" in the Groups added list$")
	public void see_inGroupAddedList(String arg1) throws Exception {
		try{
			GRP.seeText_inGroupAddedList(arg1);
		} catch (Exception e) {
			NAV.waitForPageLoad();
			GRP.seeText_inGroupAddedList(arg1);
		}
	}

	@Then("^I do not see \"([^\"]*)\" in the Groups added list$")
	public void doNotSee_inGroupAddedList(String arg1) throws Exception {
		try{
			GRP.doNotSeeText_inGroupAddedList(arg1);
		} catch (Exception e) {
			NAV.waitForPageLoad();
			GRP.doNotSeeText_inGroupAddedList(arg1);
		}
	}	
	
	@Then("^in the panel for header \"([^\"]*)\" I see \"([^\"]*)\"$")
	public void see_inPanelHeader(String headerName, String expectedText){
		GRP.seeText_inPanelHeader(headerName, expectedText);
	}

	@Then("^in the panel for header \"([^\"]*)\" I click on \"([^\"]*)\"$")
	public void click_inPanelHeader(String headerName, String expectedText){
		try{
			GRP.click_inPanelHeader(headerName, expectedText);
		} catch (Exception e) {
			NAV.waitForPageLoad();
			GRP.click_inPanelHeader(headerName, expectedText);
		}
		NAV.waitForPageLoad();
	};
	
	@When("^I \"([^\"]*)\" the checkbox for \"([^\"]*)\" \"([^\"]*)\"$")
	public void setCheckbox_forRowCol(String checkUncheck, String rowName, String colName){
	    GRP.setCheckbox_forRowCol(checkUncheck, rowName, colName);
	};
	
	@When("^I set the radio button to \"([^\"]*)\"$")
	public void setRadioButton(String arg1) throws Throwable {
	    try{
	    	GRP.click_radioButtonWithLabel(arg1);
	    } catch (Throwable e) {
	    	NAV.waitForPageLoad();
	    	GRP.click_radioButtonWithLabel(arg1);
	    }
	};

	@When("^I choose the \"([^\"]*)\" radio button$")
	public void chooseRadioButton(String arg1) throws Throwable {
		try{
			GRP.chooseRadioButtonWithLabel(arg1);
		} catch (Throwable e) {
			NAV.waitForPageLoad();
			GRP.chooseRadioButtonWithLabel(arg1);
		}
	}
	@Then("^the radio button \"([^\"]*)\" is \"([^\"]*)\"$")
	public void confirm_Radiobutton_withNameChecked(String radioButtonLabel, String selectUnSelected){
	    GRP.confirm_Radiobutton_withNameChecked(radioButtonLabel, selectUnSelected);
	};
	@Then("^I see the Gov licence description on the page$")
	public void jurorRecordTagIsVisible() {
		assertTrue(GRP.seeGovNote());
	}
	@When("^I click any radio button while prioritising pool numbers for deferral$")
	public void clickAnyRadioButtonExcludingSpecificText() throws Throwable {
		try {
			GRP.clickDeferralRadioButtonExcludingMaintenance();
		} catch (Throwable e) {
			NAV.waitForPageLoad();
			GRP.clickDeferralRadioButtonExcludingMaintenance();
		}
	}
}
