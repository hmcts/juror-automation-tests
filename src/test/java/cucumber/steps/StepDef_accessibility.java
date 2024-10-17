package cucumber.steps;

import org.openqa.selenium.WebDriver;


import io.cucumber.java.PendingException;

import io.cucumber.java.en.*;
import cucumber.pageObjects.Accessibility;
import cucumber.pageObjects.Login;
import cucumber.pageObjects.NavigationShared;
import cucumber.pageObjects.SharedDriver;
import cucumber.pageObjects.aSamplePO;
import io.cucumber.java.Before;
import io.cucumber.java.After;

import org.openqa.selenium.support.PageFactory;

public class StepDef_accessibility {

	private aSamplePO SPO;
	private Login LGN;
	private NavigationShared NAV;
	private Accessibility ACS;
	private final WebDriver webDriver;

	public StepDef_accessibility(SharedDriver webDriver) {
		this.webDriver = webDriver;
		SPO = PageFactory.initElements(webDriver, aSamplePO.class);
		LGN = PageFactory.initElements(webDriver, Login.class);
		NAV = PageFactory.initElements(webDriver, NavigationShared.class);
		ACS = PageFactory.initElements(webDriver, Accessibility.class);
	}


	@When("^I do not see any links on the page that open to a new page without an alt text$")
	public void altTextCheck() throws Throwable {
		try {
			ACS.altTextCheck();
		} catch (AssertionError e) {
			ACS.altTextCheck();
		}
	}

	@When("^the page language is \"([^\"]*)\"$")
	public void pageLanguageCheck(String expectedLang) throws Throwable {
		try {
			ACS.pageLanguageCheck(expectedLang);
		} catch (Exception e) {
			ACS.pageLanguageCheck(expectedLang);
		}
	}

	@When("^I select the dropdown for \"([^\"]*)\"$")
	public void dropdownExpandedBySummaryText(String summaryText) {
		ACS.expandDropdownForLinks(summaryText);
	}
}