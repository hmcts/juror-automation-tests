package cucumber.steps;

import cucumber.pageObjects.*;
import cucumber.testdata.DatabaseTester;
import io.cucumber.datatable.DataTable;
import io.cucumber.java.en.And;
import io.cucumber.java.en.Then;
import io.cucumber.java.en.When;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.support.PageFactory;

import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.ZoneId;
import java.util.Calendar;
import java.util.Date;
import java.util.Map;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertTrue;


public class StepDef_coronerPool {

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
    private final Groups GRP;

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

    public StepDef_coronerPool(SharedDriver webDriver, DatabaseTester dbt) {
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
        GRP = PageFactory.initElements(webDriver, Groups.class);
        DBT = dbt;
        HEADER_PAGE = PageFactory.initElements(webDriver, Header.class);
    }

    @When("^I select to create a coroner's pool$")
    public void iClickCreateCoronerPool() throws Throwable {
        NAV.press_buttonByName("Create pool");
        GRP.click_radioButtonWithLabel("Coroner");
        NAV.press_buttonByName("Continue");
    }

    @And("^I see date requested on coroner pool request is today$")
    public void iSeeDateRequestedIsToday() {
        String fullDatePattern = "dd/MM/yyyy";
        String fullDatePatternConverted = "d MMMMM yyyy";
        Calendar calendar = Calendar.getInstance();
        LocalDate localDate = calendar.toInstant().atZone(ZoneId.systemDefault()).toLocalDate();

        Date date =Date.from(localDate.atStartOfDay().atZone(ZoneId.systemDefault()).toInstant());

        String todayDateFull = new SimpleDateFormat(fullDatePattern).format(date);
        String todayDateFullConverted = new SimpleDateFormat(fullDatePatternConverted).format(date);

        assertEquals(CORONERS_POOL_PAGE.checkCoronerDateRequested(), todayDateFull);

        coronersRequestedOnDate = todayDateFullConverted;
    }

    @And("^I should see the details of the coroner's court pool summary$")
    public void iShouldSeeTheDetailsOfTheCoronersCourtPool(DataTable table) throws SQLException, ParseException {
        Map<String, String> data = table.asMap(String.class, String.class);

        assertEquals(coronersRequestedOnDate, CORONERS_POOL_PAGE.getRequestedOnDateCoroners());
        assertEquals(data.get("courtName"), CHECK_POOL_REQUEST_PAGE.getCourtName());
        assertEquals(data.get("totalJurorsRequired"), CORONERS_POOL_PAGE.getNumberOfJurorsCoroners());
        assertEquals(data.get("requestedByName"), CORONERS_POOL_PAGE.getRequestedByNameCoroners());
        assertEquals(data.get("requestedByEmail"), CORONERS_POOL_PAGE.getRequestedByEmailCoroners());
        assertEquals(data.get("requestedByPhone"), CORONERS_POOL_PAGE.getRequestedByPhoneCoroners());

        newCoronersPoolNumber = CORONERS_POOL_PAGE.getCoronerPoolNextNumber();
    }

    @And("^I should see the coroner's court pool$")
    public void iShouldSeeTheCoronersCourtPool(DataTable table) throws SQLException {
        Map<String, String> expectedData = table.asMap(String.class, String.class);

        NAV.waitForPageLoad();
        assertEquals(newCoronersPoolNumber.toString(), CORONERS_POOL_PAGE.coronersPoolNumber());
        assertEquals(expectedData.get("court"), CORONERS_POOL_PAGE.getCoronersCourtName());
        assertEquals(expectedData.get("courtCode"), CORONERS_POOL_PAGE.getCoronersCourtCode());
        assertEquals(expectedData.get("poolType"), CORONERS_POOL_PAGE.getCoronersPoolType());
        assertEquals(expectedData.get("jurorsAdded"), CORONERS_POOL_PAGE.getCoronersNumberAdded());
        assertEquals(expectedData.get("jurorsRequired"), CORONERS_POOL_PAGE.getCoronersCapacity());
        assertEquals(expectedData.get("rowsOfCitizens"), CORONERS_POOL_PAGE.getCoronersRowsOfCitizens().toString());
    }

    @And("^coroners court contact details are$")
    public void iShouldSeeTheCoronersCourtContactDetails(DataTable table) throws SQLException {
        Map<String, String> expectedData = table.asMap(String.class, String.class);

        assertEquals(coronersRequestedOnDate.toString(), CORONERS_POOL_PAGE.getRequestedOnDateCoroners());
        assertEquals(expectedData.get("name"), CORONERS_POOL_PAGE.getRequestedByNameCoroners());
        assertEquals(expectedData.get("email"), CORONERS_POOL_PAGE.getRequestedByEmailCoroners());
        assertEquals(expectedData.get("phone"), CORONERS_POOL_PAGE.getRequestedByPhoneCoroners());
    }

    @When("^I set first postcode field to more than is available$")
    public void iSetVotersToMoreThanIsAvailable() {
        String votersCountPlus1 = String.valueOf(CORONERS_POOL_PAGE.firstPostCodeVotersCount() + 1);
        CORONERS_POOL_PAGE.firstPostCodeVotersInput.sendKeys(votersCountPlus1);
    }

    @When("^I set the Coroners pool requested on date to a Monday \"([^\"]*)\" weeks in the future$")
    public void iSetTheCoronersPoolRequestedOnDateToAMondayInTheFuture(Integer noOfWeeks) {
        String datePattern = "dd/MM/yyyy";
        String fullDatePatternConverted = "d MMMMM yyyy";
        Calendar calendar = Calendar.getInstance();
        calendar.add(Calendar.WEEK_OF_MONTH, noOfWeeks);

        LocalDate localDate = calendar.toInstant().atZone(ZoneId.systemDefault()).toLocalDate();
        Date mondayDate = Date.from(localDate.atStartOfDay().atZone(ZoneId.systemDefault()).toInstant());
        String todayDateFull = new SimpleDateFormat(datePattern).format(mondayDate);
        String todayDateFullConverted = new SimpleDateFormat(fullDatePatternConverted).format(mondayDate);


        coronersRequestedOnDate = todayDateFullConverted;
        CORONERS_POOL_PAGE.enterNewCoronerRequestedOnDate(todayDateFull);
        NAV.waitForPageLoad();

    }

    @When("^I click on the change coroners pool request details link$")
    public void iClickChangeCoronerPoolRequestDetails() {
        CORONERS_POOL_PAGE.changeCoronerPoolRequestDetails();
    }

    @When("^I click on the change coroners pool requested By link$")
    public void iClickChangeCoronerPoolRequestedBy() {
        CORONERS_POOL_PAGE.changeCoronerPoolRequestedBy();
    }

    @Then("^I am able to see the coroners pool juror headers$")
    public void iAmAbleToSeeAndInteractWithThePoolRequestTabsAndFields() throws Exception {
        CORONERS_POOL_PAGE.coronersPoolCitizensResultsTableHeaderExists("Juror number");
        CORONERS_POOL_PAGE.coronersPoolCitizensResultsTableHeaderExists("First name");
        CORONERS_POOL_PAGE.coronersPoolCitizensResultsTableHeaderExists("Last name");
        CORONERS_POOL_PAGE.coronersPoolCitizensResultsTableHeaderExists("Postcode");
    }

    @Then("^I see pool status is \"([^\"]*)\"$")
    public void iSeePoolStatusIs(String poolStatus) throws Exception {
        CORONERS_POOL_PAGE.coronerPoolStatusIs(poolStatus);
    }

    @When("^the Export pool button is not visible$")
    public void exportPoolButtonInvisible() {
        assertTrue("export pool button is visible", CORONERS_POOL_PAGE.exportPoolButtonInvisible());
    }


}
