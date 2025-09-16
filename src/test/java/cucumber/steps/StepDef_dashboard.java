package cucumber.steps;

import cucumber.pageObjects.*;
import cucumber.testdata.DatabaseTester;
import cucumber.testdata.DatabaseTesterNewSchemaDesign;
import io.cucumber.java.en.Then;
import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.support.PageFactory;

import static org.junit.Assert.assertEquals;

public class StepDef_dashboard {
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

    public StepDef_dashboard(PoolSummoningProgress poolSummoningProgress, SharedDriver webDriver, DatabaseTester dbt, DatabaseTesterNewSchemaDesign dbtnsd, Header dash){
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
    }

    @Then("^total expected today donut displays \"([^\"]*)\"$")
    public void totalExpectedTodayMatchesExpected(String expected) {
        String fullLabel = expected + " Expected";
        assertEquals(fullLabel, DASH.totalExpectedToday());
    }

    @Then("^total expected in the last 7 days donut displays \"([^\"]*)\"$")
    public void totalExpectedLastSevenDaysMatchesExpected(String expected) {
        String fullLabel = expected + " Expected";
        assertEquals(fullLabel, DASH.totalExpectedLastSevenDays());
    }

    @Then("^on the dashboard the total \"([^\"]*)\" today matches \"([^\"]*)\"$")
    public void totalTodayMatchesExpected(String label, String expected) {
        String total = webDriver.findElement(By.xpath("//div [@aria-label='Attendance doughnut chart for Today']//*/div[text()[contains(.,'" + label + "')]]/span")).getText();
        assertEquals(expected, total);
    }

    @Then("^on the dashboard the total \"([^\"]*)\" in the last 7 days matches \"([^\"]*)\"$")
    public void totalLastSevenDaysMatchesExpected(String label, String expected) {
        String total = webDriver.findElement(By.xpath("//div [@aria-label='Attendance doughnut chart for Last 7 days']//*/div[text()[contains(.,'" + label + "')]]/span")).getText();
        assertEquals(expected, total);
    }

    @Then("^on the dashboard the total due to attend matches \"([^\"]*)\"$")
    public void totalDueToAttendMatchesExpected(String expected) {
        String total = webDriver.findElement(By.xpath("//h4 [text()[contains(.,'Total due to attend')]]/../p")).getText();
        assertEquals(expected, total);
    }

    @Then("^on the dashboard the total with reasonable adjustments matches \"([^\"]*)\"$")
    public void totalWithReasonableAdjustmentsMatchesExpected(String expected) {
        String total = webDriver.findElement(By.xpath("//h4 [text()[contains(.,'Jurors with reasonable adjustments')]]/../p")).getText();
        assertEquals(expected, total);
    }

    @Then("^on the dashboard the total unconfirmed attendances matches \"([^\"]*)\"$")
    public void totalUnconfirmedAttendancesMatchesExpected(String expected) {
        String total = webDriver.findElement(By.xpath("//h3 [text()[contains(.,'Unconfirmed attendances')]]/../p")).getText();
        assertEquals(expected, total);
    }

    @Then("^on the dashboard the total on call matches \"([^\"]*)\"$")
    public void totalOnCallMatchesExpected(String expected) {
        String total = webDriver.findElement(By.xpath("//h3 [text()[contains(.,'Jurors on call')]]/../p")).getText();
        assertEquals(expected, total);
    }

    @Then("^on the dashboard the total unpaid attendances matches \"([^\"]*)\"$")
    public void totalUnpaidAttendancesMatchesExpected(String expected) {
        String total = webDriver.findElement(By.xpath("//div [@aria-label='Unpaid attendances']/span")).getText();
        assertEquals(expected, total);
    }

    @Then("^on the dashboard the oldest unpaid attendance is \"([^\"]*)\" days old$")
    public void oldestUnpaidAttendancesMatchesExpected(String expected) {
        String total = webDriver.findElement(By.xpath("//div [@aria-label='Oldest unpaid attendance']/span/span")).getText();
        assertEquals(expected, total);
    }

    @Then("^on the dashboard the date monthly utilisation report last run matches \"([^\"]*)\"$")
    public void dateUtilReportLastRunMatchesExpected(String expected) {
        String total = webDriver.findElement(By.xpath("//h3 [text()[contains(.,'Date monthly utilisation report last run')]]/../p")).getText();
        assertEquals(expected, total);
    }

    @Then("^on the dashboard the Last run monthly utilisation percentage matches \"([^\"]*)\"$")
    public void lastUtilReportPercentageMatchesExpected(String expected) {
        String total = webDriver.findElement(By.xpath("//h3 [text()[contains(.,'Last run monthly utilisation percentage')]]/../p")).getText();
        assertEquals(expected, total);
    }

}
