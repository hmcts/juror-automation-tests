package cucumber.steps;

import io.cucumber.java.en.*;
import cucumber.pageObjects.*;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.support.PageFactory;

import java.util.regex.Matcher;
import java.util.regex.Pattern;
import java.util.stream.Stream;

public class StepDef {

	private aSamplePO SPO;
	private Login LGN;
	private NavigationShared NAV;
	private final WebDriver webDriver;
	private ScreenShotTaker SST;

	public StepDef(SharedDriver webDriver) {
		this.webDriver = webDriver;
		SPO = PageFactory.initElements(webDriver, aSamplePO.class);
		LGN = PageFactory.initElements(webDriver, Login.class);
		NAV = PageFactory.initElements(webDriver, NavigationShared.class);
		SST = PageFactory.initElements(webDriver, ScreenShotTaker.class);
	}

	@Given("^I am on the Login Page$")
	public void accessLoginPage() throws Throwable {
		NAV.accessLoginPage();
		NAV.waitForAngularLoad();
	}

	@Given("^I am on the Admin Login Page$")
	public void accessAdminLoginPage() throws Throwable {
		NAV.accessAdminLoginPage();
		NAV.waitForPageLoad();
	}

	@Given("^I am looking at cookies on \"([^\"]*)\" \"([^\"]*)\"$")
	public void loadPage_forCookies(String publicBureau, String env) throws Throwable {
		NAV.accessLoginPageWithCookies(publicBureau, env);
	}


	@Given("^I am looking at cookies on Welsh \"([^\"]*)\" \"([^\"]*)\"$")
	public void loadPage_forCookiesWelshWithCookies(String publicBureau, String env) throws Throwable {
		NAV.accessLoginPageWelshWithCookies(publicBureau, env);
	}

	;


	@Given("^I am on \"([^\"]*)\" \"([^\"]*)\"$")
	public void loadPage_for(String publicBureau, String env) throws Throwable {
		NAV.accessLoginPage(publicBureau, env);
		try {
			NAV.press_buttonByName("Accept analytics cookies");
			NAV.press_buttonByName("Hide cookie message");
		} catch (Exception e) {
		}
	}

	@Given("^I am on the welsh version of \"([^\"]*)\" \"([^\"]*)\"")
	public void loadPage_for_Welsh(String publicBureau, String env) throws Throwable {
		NAV.accessLoginPageWelsh(publicBureau, env);
//	    NAV.press_buttonByName("Derbyn cwcis dadansoddol");
//    	NAV.press_buttonByName("Cuddio");
		try {
			NAV.press_buttonByName("Derbyn cwcis dadansoddol");
			NAV.press_buttonByName("Cuddio");
		} catch (Exception e) {
		}
	}

	;

	@Given("^I am on expenses on \"([^\"]*)\" \"([^\"]*)\"$")
	public void loadPage_for_Expenses(String publicBureau, String env) throws Throwable {
		NAV.accessLoginPageExpenses(publicBureau, env);
		try {
			NAV.press_buttonByName("Accept analytics cookies");
		} catch (Exception e) {
		}

	}

	;

	@Given("^I am on the Welsh version of expenses on \"([^\"]*)\" \"([^\"]*)\"$")
	public void loadPage_for_Welsh_Expenses(String publicBureau, String env) throws Throwable {
		NAV.accessLoginPageWelshExpenses(publicBureau, env);
		try {
			NAV.press_buttonByName("Accept analytics cookies");
		} catch (Exception e) {
		}
	}

	;


	@Then("^I log in as \"([^\"]*)\"$")
	public void loginWith_usernameOnly(String username) throws Throwable {
		switch(username){
			case "MODTESTBUREAU":
				LGN.loginADTestRoute(username + "@email.gov.uk");
		}

		//LGN.login(username, System.getenv(username + "_PASSWORD"));
		NAV.waitForPageLoad(180); // 3 Minute login timeout - Up from 120 seconds - Up from 60 seconds
	}
	@Then("^I log in with \"([^\"]*)\" and \"([^\"]*)\"$")
	public void loginWith_usernameAndPassword(String username, String password) throws Throwable {
		LGN.login(username, password);
		NAV.waitForPageLoad(180); // 3 Minute login timeout - Up from 120 seconds - Up from 60 seconds
	}

	@Then("^I log in via AD with \"([^\"]*)\" and \"([^\"]*)\"$")
	public void loginViaADWith_usernameAndPassword(String username, String password) throws Throwable {
		LGN.loginWithAD(username, password);
		NAV.waitForPageLoad(180); // 3 Minute login timeout - Up from 120 seconds - Up from 60 seconds
	}

	@When("^I log in$")
	public void login() throws Throwable {
		LGN.login();
	}

	@When("^I log in the admin portal$")
	public void loginAdmin() throws Throwable {
		LGN.loginAdmin();
	}

	@When("^I log out$")
	public void logout() throws Throwable {
		throw new Error("No java defined for this action");
	}

	@When("^I reset the password to \"([^\"]*)\"$")
	public void resetPasswordTo(String arg1) throws Throwable {
		NAV.set_valueTo("New password:", arg1);
		NAV.set_valueTo("Confirm password:", arg1);
		NAV.press_buttonByName("Confirm");
	}

	@When("^I see \"([^\"]*)\" in the URL$")
	public void see_inURL(String urlPart) {
		NAV.see_inURL(urlPart);
	}

	;

//	@Then("^the URL equals \"([^\"]*)\"$")
//	public void urlEquals(String expectedURL) {
//	    NAV.urlEquals(expectedURL);
//	};

	@When("^I press \"([^\"]*)\" in \"([^\"]*)\"$")
	public void press_a_key(String key, String inputFieldLabel) {
		NAV.press_a_key(key, inputFieldLabel);
	}

	;

	@When("^I press backspace in text area with id \"([^\"]*)\"$")
	public void press_backspace(String textAreaId) {
		NAV.press_backspace(textAreaId);
	}

	;

	@When("^I clear field with id \"([^\"]*)\"$")
	public void clear_field(String fieldId) {
		NAV.clear_field(fieldId);

	}

	@Given("^I navigate to \"([^\"]*)\" URL$")
	public void iSeeInUrl(String appendURL) {
		String currentUrl = webDriver.getCurrentUrl();
		String protocol = NAV.getProtocolFromURLString(currentUrl);
		String subUrl = currentUrl.split("https?://")[1].split("/")[0];
		webDriver.get(protocol + subUrl + appendURL);
		NAV.iSeeInUrl(subUrl);

	}

	@And("^I set a breakpoint$")
	public void iSetABreakpoint() {
		System.out.println("setting breakpoint");
	}
}