package cucumber.steps;

import cucumber.pageObjects.*;
import cucumber.testdata.DatabaseTester;
import cucumber.testdata.DatabaseTesterNewSchemaDesign;
import io.cucumber.java.en.Then;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.support.PageFactory;

import static org.junit.Assert.assertEquals;

public class StepDef_reports {
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
    private final Reports REP;

    public StepDef_reports(PoolSummoningProgress poolSummoningProgress, SharedDriver webDriver, DatabaseTester dbt, DatabaseTesterNewSchemaDesign dbtnsd, Header dash){
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
        REP = PageFactory.initElements(webDriver, Reports.class);
    }

    @Then("^Digital summons received report shows total number of replies received is \"([^\"]*)\"$")
    public void totalDigitalSummonsMatchesExpected(String expected) {
        assertEquals(expected, REP.totalDigitalResponsesReceived());
    }

    @Then("^the total SMS sent for selected court is \"([^\"]*)\"$")
    public void totalSMSMatchesExpected(String expected) {
        assertEquals(expected, REP.totalSMSSentMatchesExpected());
    }

    @Then("^the number of \"([^\"]*)\" SMS sent by selected court is \"([^\"]*)\"$")
    public void numberReminderSMSSentMatchesExpected(String expected, String messageType) {

        switch (messageType) {
            case "Reminder":
                assertEquals(expected, REP.numberReminderSMSSentMatchesExpected());
                break;
            case "Failed to Attend":
                assertEquals(expected, REP.numberFailedSMSSentMatchesExpected());
                break;
            case "Date and Time changed":
                assertEquals(expected, REP.numberDateAndTimeSMSSentMatchesExpected());
                break;
            case "Time changed":
                assertEquals(expected, REP.numberTimeChangedSMSSentMatchesExpected());
                break;
            case "Complete (attended)":
                assertEquals(expected, REP.numberCompleteAttendedSMSSentMatchesExpected());
                break;
            case "Complete (not needed)":
                assertEquals(expected, REP.numberCompleteNotNeededSMSSentMatchesExpected());
                break;
            case "Next Date":
                assertEquals(expected, REP.numberNextDateSMSSentMatchesExpected());
                break;
            case "On Call":
                assertEquals(expected, REP.numberOnCallSMSSentMatchesExpected());
                break;
            case "Please Contact":
                assertEquals(expected, REP.numberPleaseContactSMSSentMatchesExpected());
                break;
            case "Delayed Start":
                assertEquals(expected, REP.numberDelayedSMSSentMatchesExpected());
                break;
            case "Selection":
                assertEquals(expected, REP.numberSelectionSMSSentMatchesExpected());
                break;
            case "Bad Weather":
                assertEquals(expected, REP.numberBadWeatherSMSSentMatchesExpected());
                break;
            case "Check Junk":
                assertEquals(expected, REP.numberCheckJunkSMSSentMatchesExpected());
                break;
            case "Bring Lunch":
                assertEquals(expected, REP.numberBringLunchSMSSentMatchesExpected());
                break;
            case "Excused":
                assertEquals(expected, REP.numberExcusedSMSSentMatchesExpected());
                break;
            case "Total":
                assertEquals(expected, REP.numberTotalSMSSentMatchesExpected());
                break;
        }

    }

}
