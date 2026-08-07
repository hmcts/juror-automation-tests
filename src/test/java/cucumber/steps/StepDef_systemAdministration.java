package cucumber.steps;

import cucumber.pageObjects.*;
import io.cucumber.java.en.Then;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.support.PageFactory;

import static org.junit.Assert.assertEquals;

public class StepDef_systemAdministration {

    private aSamplePO SPO;
	private Login LGN;
	private Groups GRP;
	private Organisations ORG;
	private NavigationShared NAV;
    private SystemAdministration SYSADMIN;
	private final WebDriver webDriver;

	public StepDef_systemAdministration(SharedDriver webDriver) {
		this.webDriver = webDriver;
		SPO = PageFactory.initElements(webDriver, aSamplePO.class);
		LGN = PageFactory.initElements(webDriver, Login.class);
		NAV = PageFactory.initElements(webDriver, NavigationShared.class);
		GRP = PageFactory.initElements(webDriver, Groups.class);
		ORG = PageFactory.initElements(webDriver, Organisations.class);
        SYSADMIN = PageFactory.initElements(webDriver, SystemAdministration.class);
	}	
	
	@Then("^I see \"([^\"]*)\" is marked as SJO user \"([^\"]*)\"$")
	public void userSJOStatus (String user, String sjoStatus) {
        assertEquals (SYSADMIN.getSJOStatusForUser(user), sjoStatus);
	};

    @Then("^I see \"([^\"]*)\" is marked as Manager user \"([^\"]*)\"$")
    public void userManagerStatus (String user, String managerStatus) {
        assertEquals (SYSADMIN.getManagerStatusForUser(user), managerStatus);
    };

    @Then("^I see \"([^\"]*)\" has status: \"([^\"]*)\"$")
    public void userActiveStatus (String user, String activeStatus) {
        assertEquals (SYSADMIN.getActiveStatusForUser(user), activeStatus);
    };
	
}
