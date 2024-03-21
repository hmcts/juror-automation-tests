package cucumber.steps;

import io.cucumber.java.en.*;
import cucumber.pageObjects.*;
import cucumber.testdata.DatabaseTester;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.support.PageFactory;

import static org.junit.Assert.*;


public class StepDef_courtJurorRecord {

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

    private final CourtJurorRecord COURT_JUROR_RECORD;

    private String poolRequestNumber;
    private static String summonsReplyNumber;
    public static String selectedAttendanceDate;
    public static String jurorRecordNumber;
    public static String poolNumber;
    public static String originalReplyStatus;

    public StepDef_courtJurorRecord(SharedDriver webDriver, DatabaseTester dbt, CourtJurorRecord court_juror_record) {
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
        COURT_JUROR_RECORD = court_juror_record;
    }

    @Then("^I am on the court Juror Record for juror \"([^\"]*)\"$")
    public void iAmOnCourtJurorRecord(String jurorRecordNumber) throws Throwable {
        NAV.waitForPageLoad();
        NAV.textPresentOnPage(jurorRecordNumber);
        assertTrue(COURT_JUROR_RECORD.seeJurorRecordTag());
        assertTrue(COURT_JUROR_RECORD.seeEnterSummonsReplyButton());
        assertTrue(COURT_JUROR_RECORD.seeOverviewTab());
        assertTrue(COURT_JUROR_RECORD.seeDetailsTab());
        assertTrue(COURT_JUROR_RECORD.seeAttendanceTab());
        assertTrue(COURT_JUROR_RECORD.seeNotesTab());
        assertTrue(COURT_JUROR_RECORD.seeHistoryTab());

    }
}