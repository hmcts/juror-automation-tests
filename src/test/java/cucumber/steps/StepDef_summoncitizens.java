package cucumber.steps;

import io.cucumber.java.en.*;
import io.cucumber.java.PendingException;
import io.cucumber.datatable.DataTable;
import io.cucumber.java.Before;
import io.cucumber.java.After;
import io.cucumber.java.Scenario;
import cucumber.pageObjects.*;
import cucumber.testdata.DatabaseTester;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.support.PageFactory;

import java.text.ParseException;
import java.util.Map;

import static cucumber.steps.StepDef_jurorpool.poolNumber;
import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertTrue;


public class StepDef_summoncitizens {

    private final CoronersPool CORONERS_POOL_PAGE;
    private aSamplePO SPO;
    private Login LGN;
    private NavigationShared NAV;
    private final WebDriver webDriver;

    private static WebDriver driver;
    private ScreenShotTaker SST;
    private final PoolRequests POOL_REQUESTS_PAGE;
    private final CheckPoolRequest CHECK_POOL_REQUEST_PAGE;
    private final PoolOverview POOL_OVERVIEW_PAGE;
    private final ActivePools ACTIVE_POOLS_PAGE;
    private final SummonsReply SUMMONS_REPLY;
    private final ViewSummonsReply VIEW_SUMMONS_REPLY;
    private final PoolSearch POOL_SEARCH;

    private final Header HEADER_PAGE;
    private final DatabaseTester DBT;
    private final JurorRecordSearch JUROR_RECORD_SEARCH;
    private final SummonCitizens SUMMON_CITIZENS;

//    public static String poolNumber;

    public static String summonedNumber;

    public StepDef_summoncitizens(CoronersPool coroners_pool_page, SharedDriver webDriver, DatabaseTester dbt) {
        CORONERS_POOL_PAGE = coroners_pool_page;
        this.webDriver = webDriver;
        SPO = PageFactory.initElements(webDriver, aSamplePO.class);
        LGN = PageFactory.initElements(webDriver, Login.class);
        NAV = PageFactory.initElements(webDriver, NavigationShared.class);
        SST = PageFactory.initElements(webDriver, ScreenShotTaker.class);
        POOL_REQUESTS_PAGE = PageFactory.initElements(webDriver, PoolRequests.class);
        ACTIVE_POOLS_PAGE = PageFactory.initElements(webDriver, ActivePools.class);
        CHECK_POOL_REQUEST_PAGE = PageFactory.initElements(webDriver, CheckPoolRequest.class);
        POOL_OVERVIEW_PAGE = PageFactory.initElements(webDriver, PoolOverview.class);
        JUROR_RECORD_SEARCH = PageFactory.initElements(webDriver, JurorRecordSearch.class);
        SUMMONS_REPLY = PageFactory.initElements(webDriver, SummonsReply.class);
        POOL_SEARCH = PageFactory.initElements(webDriver, PoolSearch.class);
        VIEW_SUMMONS_REPLY = PageFactory.initElements(webDriver, ViewSummonsReply.class);
        DBT = dbt;
        HEADER_PAGE = PageFactory.initElements(webDriver, Header.class);
        SUMMON_CITIZENS = PageFactory.initElements(webDriver, SummonCitizens.class);;
    }

    @Then("^I should see the editable and non-editable information on the summon citizens for pool screen$")
    public void iShouldSeeTheEditableAndNonEditableInformationOnTheSummonCitizensForPoolScreen(DataTable table) throws ParseException{
        Map<String, String> data = table.asMap(String.class, String.class);
        assertEquals("Summon citizens", POOL_REQUESTS_PAGE.getPageHeading());
        assertEquals(poolNumber.get(), POOL_REQUESTS_PAGE.getSummonCitizensPoolNumber());
        assertTrue(SUMMON_CITIZENS.summonedCitizensChangeDeferralsIsPresent());
        assertTrue(SUMMON_CITIZENS.summonedCitizensChangeCatchmentIsPresent());
        assertTrue(SUMMON_CITIZENS.summonedCitizensSubmitButtonIsPresent());

        assertEquals(data.get("jurorsRequested"), SUMMON_CITIZENS.getSummonCitizensNumberOfJurorsRequested());
        assertTrue(
                Integer.parseInt(SUMMON_CITIZENS.getSummonCitizensNumberOfJurorsRequired()) > 0
        );
        assertEquals(data.get("courtCatchmentArea"), SUMMON_CITIZENS.getSummonCitizensCourtCatchmentArea());
        assertTrue(Integer.parseInt(SUMMON_CITIZENS.getSummonCitizensDeferrals()) > 0);
    }

    @When("^I click on the summon citizens for pool button$")
    public void iClickOnTheSummonCitizensForPoolButton() {
        // Need web element of the button
    }

    @When("^I see the number of citizens I summoned is \"([^\"]*)\"$")
    public void iSeeNumberCitizensIsCorrect(String numberOfCitizens) {
        assertEquals(numberOfCitizens, CORONERS_POOL_PAGE.getCoronersRowsOfCitizens().toString());
    }
    @When("^I set the number of users I want to summon to \"([^\"]*)\"$")
    public void iSetTheNumberOfUsersIWantToSummonTo(String summonNumber) throws Throwable {
        NAV.set_value_to("Citizens to summon",summonNumber);
        summonedNumber = summonNumber;
        NAV.press_buttonByName("Create pool and summon citizens");
    }

    @Then("^I should see an error stating the amount of citizens summoned is more than allowed$")
    public void iShouldSeeAnErrorStatingTheAmountOfCitizensSummonedIsMoreThanAllowed() {
        assertEquals("Number of citizens to summon is too high", SUMMON_CITIZENS.getNumberOfCitizensSummonedError());
    }

    @When("^the Summon citizens button is not visible$")
    public void summonCitizensButtonInvisible() {
        assertTrue("summon citizens button is invisible", SUMMON_CITIZENS.summonCitizensButtonInvisible());
    }

}
