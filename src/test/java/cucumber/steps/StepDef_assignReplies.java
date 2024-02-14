package cucumber.steps;


import io.cucumber.java.en.*;
import cucumber.pageObjects.*;
import cucumber.testdata.DatabaseTester;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.support.PageFactory;

import static org.junit.Assert.assertEquals;


public class StepDef_assignReplies {

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
    private final CoronersPool CORONERS_POOL_PAGE;

    private final AssignReplies ASSIGN_REPLIES_PAGE;

    private final Header HEADER_PAGE;
    private final DatabaseTester DBT;
    private final JurorRecordSearch JUROR_RECORD_SEARCH;

    private final SummonsReply SUMMONS_REPLY;

    private String poolRequestNumber;
    public static String selectedAttendanceDate;
    public static String jurorRecordNumber;
    public static String coronersRequestedOnDate;
    public static Integer newCoronersPoolNumber;
    public static String newCoronersPoolRequestedJurors;
    public static Integer votersCountPlus1;

    public StepDef_assignReplies(SharedDriver webDriver, AssignReplies assign_replies_page, DatabaseTester dbt) {
        this.webDriver = webDriver;
        SPO = PageFactory.initElements(webDriver, aSamplePO.class);
        LGN = PageFactory.initElements(webDriver, Login.class);
        NAV = PageFactory.initElements(webDriver, NavigationShared.class);
        SST = PageFactory.initElements(webDriver, ScreenShotTaker.class);
        POOL_REQUESTS_PAGE = PageFactory.initElements(webDriver, PoolRequests.class);
        CORONERS_POOL_PAGE = PageFactory.initElements(webDriver, CoronersPool.class);
        ACTIVE_POOLS_PAGE = PageFactory.initElements(webDriver, ActivePools.class);
        CHECK_POOL_REQUEST_PAGE = PageFactory.initElements(webDriver, CheckPoolRequest.class);
        POOL_OVERVIEW_PAGE = PageFactory.initElements(webDriver, PoolOverview.class);
        JUROR_RECORD_SEARCH = PageFactory.initElements(webDriver, JurorRecordSearch.class);
        SUMMONS_REPLY = PageFactory.initElements(webDriver, SummonsReply.class);
        ASSIGN_REPLIES_PAGE = assign_replies_page;
        DBT = dbt;
        HEADER_PAGE = PageFactory.initElements(webDriver, Header.class);
    }

    @When("^I set how many \"([^\"]*)\" replies I want to assign to \"([^\"]*)\"$")
    public void iSetHowManyRepliesToAssign(String urgencyType, String numberOfReplies) {
        ASSIGN_REPLIES_PAGE.setNumberOfRepliesToAssign(urgencyType, numberOfReplies);

    }

    @When("^I do not see \"([^\"]*)\" in the staff results grid$")
    public void iDoNotSeeUserInStaffResultsGrid(String staffName) {
        ASSIGN_REPLIES_PAGE.userIsNotinResultsGrid(staffName);

    }

    @When("^I see Reply from \"([^\"]*)\"$")
    public void iSeeReplyFromJurorName(String jurorName) {
        assertEquals(jurorName, ASSIGN_REPLIES_PAGE.getReplyFromJurorName());
        }

    @When("^I click on the Select an officer to send to input field")
    public void iClickSelectAnOfficer() {
        ASSIGN_REPLIES_PAGE.clickSelectAnOfficer();
    }

    @When("^I see \"([^\"]*)\" backlog count label on the page$")
    public void iSeeBacklogCountLabel(String backlogCountType) {
        ASSIGN_REPLIES_PAGE.iSeeBacklogCountLabel(backlogCountType);
    }

    @When("^I see \"([^\"]*)\" replies to assign count label on the page$")
    public void iSeeAssignCountLabel(String assignCountType) {
        ASSIGN_REPLIES_PAGE.iSeeAssignCountLabel(assignCountType);
    }

    @When("^I see \"([^\"]*)\" assigned to staff count label on the page$")
    public void iSeeAssignedToStaffCountLabel(String assignCountType) {
        ASSIGN_REPLIES_PAGE.iSeeAssignedToStaffCountLabel(assignCountType);
    }

}



