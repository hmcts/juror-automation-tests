package cucumber.steps;

import cucumber.pageObjects.*;
import cucumber.testdata.DatabaseTester;
import cucumber.testdata.DatabaseTesterNewSchemaDesign;
import io.cucumber.java.en.Then;
import io.cucumber.java.en.When;
import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.support.PageFactory;

import static org.junit.Assert.assertEquals;

public class StepDef_electoralRegManagement {
    private final WebDriver webDriver;
    private final PoolSummoningProgress POOL_SUMMONING_PROGRESS;
    private final DatabaseTester DBT;

    private final DatabaseTesterNewSchemaDesign DBTNSD;
    private final aSamplePO SPO;
    private final Login LGN;
    private final NavigationShared NAV;
    private final ScreenShotTaker SST;
    private final PoolRequests POOL_REQUESTS_PAGE;
    private final ActivePools ACTIVE_POOLS_PAGE;
    private final CheckPoolRequest CHECK_POOL_REQUEST_PAGE;
    private final PoolOverview POOL_OVERVIEW_PAGE;
    private final JurorRecordSearch JUROR_RECORD_SEARCH;
    private final SummonsReply SUMMONS_REPLY;
    private final PoolSearch POOL_SEARCH;
    private final ViewSummonsReply VIEW_SUMMONS_REPLY;
    private final Header HEADER_PAGE;
    private final Dashboard DASH;
    private final ElectoralRegManagement ELEC;

    public StepDef_electoralRegManagement(PoolSummoningProgress poolSummoningProgress, SharedDriver webDriver, DatabaseTester dbt, DatabaseTesterNewSchemaDesign dbtnsd, Header dash){
        POOL_SUMMONING_PROGRESS = poolSummoningProgress;
        this.webDriver = webDriver;
        DBT = dbt;
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
        HEADER_PAGE = PageFactory.initElements(webDriver, Header.class);
        DBTNSD = dbtnsd;
        DASH = PageFactory.initElements(webDriver, Dashboard.class);
        ELEC = PageFactory.initElements(webDriver, ElectoralRegManagement.class);
    }

    @Then("^deadline date on Electoral Register Management dash displays \"([^\"]*)\"$")
    public void deadlineDateMatchesExpected(String expected) {
        assertEquals(expected, ELEC.deadlineDate());
    }

    @Then("^days remaining on Electoral Register Management dash displays \"([^\"]*)\"$")
    public void daysRemainingMatchesExpected(String expected) {
        assertEquals(expected, ELEC.daysRemainingCount());
    }

    @Then("^the number of Not Uploaded on Electoral Register Management dash matches \"([^\"]*)\"$")
    public void notUploadedMatchesExpected(String expected) {
        assertEquals(expected, ELEC.notUploadedCount());
    }

    @Then("^the number required in the donut on Electoral Register Management dash matches \"([^\"]*)\"$")
    public void donutRequiredMatchesExpected(String expected) {
        assertEquals(expected, ELEC.requiredCount());
    }

    @Then("^the number Uploaded in the donut on Electoral Register Management dash matches \"([^\"]*)\"$")
    public void donutUploadedMatchesExpected(String expected) {
        assertEquals(expected, ELEC.doughnutUploadedcount());
    }

    @Then("^the number Not Uploaded in the donut on Electoral Register Management dash matches \"([^\"]*)\"$")
    public void donutNotUploadedMatchesExpected(String expected) {
        assertEquals(expected, ELEC.doughnutNotUploadedCount());
    }

    @When("^I filter on Local Authority \"([^\"]*)\"$")
    public void iFilterOnLocalAuth(final String localAuth) throws Throwable {
        ELEC.filterByLocalAuthority(localAuth);
        NAV.press_buttonByName("Filter");
    }

    @Then("^the Local Authority returned in the results matches \"([^\"]*)\"$")
    public void filteredLocalAuthMatchesExpected(String expected) {
        assertEquals(expected, ELEC.localAuthInTableName());
    }

    }
