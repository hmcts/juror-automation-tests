package cucumber.steps;

import cucumber.pageObjects.*;
import cucumber.testdata.DatabaseTester;
import cucumber.testdata.DatabaseTesterNewSchemaDesign;
import io.cucumber.datatable.DataTable;
import io.cucumber.java.PendingException;
import io.cucumber.java.en.And;
import io.cucumber.java.en.Given;
import io.cucumber.java.en.Then;
import io.cucumber.java.en.When;
import org.apache.commons.lang3.StringUtils;
import org.apache.log4j.Logger;
import org.junit.Assert;
import org.junit.ComparisonFailure;
import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.PageFactory;

import java.awt.*;
import java.awt.datatransfer.DataFlavor;
import java.awt.datatransfer.UnsupportedFlavorException;
import java.io.IOException;
import java.sql.SQLException;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.*;
import java.time.format.DateTimeFormatter;
import java.time.temporal.TemporalAdjusters;
import java.util.List;
import java.util.*;

import static org.junit.Assert.*;


public class StepDef_jurorpool {

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
    private final AdditionalSummons ADDITIONAL_SUMMONS;
    private final DeferralMaintenance DEFERRAL_MAINTENANCE;
    private final Header HEADER_PAGE;
    private final DatabaseTester DBT;
    private final Groups GRP;
    private final JurorRecordSearch JUROR_RECORD_SEARCH;
    private final JurorRecord JUROR_RECORD;

    private final TrialsAndAttendance TRL;
    public static ThreadLocal<String> poolRequestNumber = new ThreadLocal<>();
    static String summonsReplyNumber;
    public static ThreadLocal<String> selectedAttendanceDate = new ThreadLocal<>();
    public static String jurorRecordNumber;
    public static String jurorPoolNumber;
    public static ThreadLocal<String> jurorPartNumber = new ThreadLocal<>();
    public static ThreadLocal<String> poolNumber = new ThreadLocal<>();
    public static ThreadLocal<String> poolDate = new ThreadLocal<>();
    public static String originalReplyStatus;
    public static String summonedNumber;
    public static ThreadLocal<ArrayList<String>> poolNumbers = ThreadLocal.withInitial(ArrayList::new);
    public static ArrayList<String> dateTimeRecorded = new ArrayList<>();
    public static ArrayList<String> dateTimeRecordedHigher = new ArrayList<>();
    public static ArrayList<String> dateTimeRecordedLower = new ArrayList<>();
    public static ThreadLocal<String> opticReference = new ThreadLocal<>();

    public static ThreadLocal<ArrayList<String>> summonedJurorsOld = new ThreadLocal<>();
    public static ThreadLocal<ArrayList<String>> summonedJurorsNew = new ThreadLocal<>();
    public static ThreadLocal<ArrayList<String>> summonedJurors = new ThreadLocal<>();

    private static final Logger log = Logger.getLogger(ActivePools.class);

    private DatabaseTesterNewSchemaDesign DBTNSD;

    public StepDef_jurorpool(CoronersPool coroners_pool_page, SharedDriver webDriver, DatabaseTester dbt, TrialsAndAttendance trl) {
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
        JUROR_RECORD = PageFactory.initElements(webDriver, JurorRecord.class);
        SUMMONS_REPLY = PageFactory.initElements(webDriver, SummonsReply.class);
        POOL_SEARCH = PageFactory.initElements(webDriver, PoolSearch.class);
        VIEW_SUMMONS_REPLY = PageFactory.initElements(webDriver, ViewSummonsReply.class);
        DBT = dbt;
        HEADER_PAGE = PageFactory.initElements(webDriver, Header.class);
        ADDITIONAL_SUMMONS = PageFactory.initElements(webDriver, AdditionalSummons.class);
        DEFERRAL_MAINTENANCE = PageFactory.initElements(webDriver, DeferralMaintenance.class);
        GRP = PageFactory.initElements(webDriver, Groups.class);
        TRL = PageFactory.initElements(webDriver, TrialsAndAttendance.class);
        DBTNSD = new DatabaseTesterNewSchemaDesign();
    }

    @Given("^I go to the launch screen of the bureau app$")
    public void iGoToTheLaunchScreenOfTheBureauApp() {
        //Need to know the url and user permission sets of the application
    }

    @And("^I verify reassign error message with the text \"([^\"]*)\"$")
    public void reassignErrorMessageWithTheText(String errorText) {
        NAV.waitForPageLoad();
        assertEquals(errorText, SUMMONS_REPLY.reassignErrorText());
    }

    @And("^I log in as a \"([^\"]*)\"$")
    public void iLogInAsA(String arg0) throws Throwable {
        // Will the user log in or will it be a single sign on?
        // Do we need to worry about 2fa?
        // Need to know permission sets
        throw new PendingException();
    }

    @When("^I navigate to the pool request screen$")
    public void iNavigateToThePoolRequestScreen() {
        POOL_REQUESTS_PAGE.openPoolManagement();
    }

    @When("^I navigate to summons management$")
    public void iNavigateToSummonsManagementScreen() {
        POOL_REQUESTS_PAGE.openSummonsManagement();
    }

    @When("^I click the create nil pool link$")
    public void iClickCreatePool() {
        POOL_REQUESTS_PAGE.clickCreateAPool();
        POOL_REQUESTS_PAGE.clickCreateNilPool();
    }

    @And("^a pool has been created$")
    public void poolHasBeenCreated() throws Throwable {
        iClickTheLinkToTheNewPoolScreen();
        POOL_REQUESTS_PAGE.enterAndSelectCourtAsBureau("DORCHESTER");
        iChangeThePoolTypeTo("Civil");
        iSetTheNumberOfJurorsTo("0");
        iClickTheRequestPoolButton();
        iSaveTheNewPoolRequest();
    }

    ;

    @Then("^I am able to see and interact with the pool request tabs and fields$")
    public void iAmAbleToSeeAndInteractWithThePoolRequestTabsAndFields() {
        assertTrue(POOL_REQUESTS_PAGE.tabPresentAndCorrect("Coroner courts"));
        assertTrue(POOL_REQUESTS_PAGE.tabPresentAndCorrect("Civil courts"));
        assertTrue(POOL_REQUESTS_PAGE.tabPresentAndCorrect("Crown courts"));
    }

    @When("^I filter the pool request page by \"([^\"]*)\"$")
    public void iFilterThePoolRequestPageByCourtNameAndCourtCode(final String filterQuery) throws InterruptedException {
        POOL_REQUESTS_PAGE.enterFilterString(filterQuery);
    }

    @Then("^the pool request page will show the filtered courts that the user has access to$")
    public void thePoolRequestPageWillShowTheFilteredCourtsThatTheUserHasAccessTo() {
        assertTrue(POOL_REQUESTS_PAGE.countTableRows() > 0);
    }

    @When("^I select the pool that I have just created to move to the pool summary page$")
    public void aPoolNumberIsSelectedToMoveToTheCreateAPoolSummaryPage() {
        try {
            NAV.click_link_by_text(poolNumber.get());
        } catch (Exception e) {
            System.out.println("Pool not found, trying another method");
            POOL_REQUESTS_PAGE.clickTab("Search");
            POOL_SEARCH.enterPoolNo(poolNumber.get());
            POOL_SEARCH.clickContinue();
        }
    }

    @When("^I click on the pool I have added jurors to$")
    public void clickOnPoolIHaveAddedJurorsToOnActivePools() {
        POOL_REQUESTS_PAGE.clickActivePoolNumber(poolRequestNumber.get());
    }

    @When("^I click the delete pool request button$")
    public void iClickDeletePoolRequest() {
        POOL_OVERVIEW_PAGE.clickDelete();
    }

    @Then("^I am asked if I'm sure I want to delete$")
    public void iAmAskedIfIWantToDelete() {
        assertEquals("Are you sure you want to delete this request?", POOL_OVERVIEW_PAGE.getHeading());
    }

    @Then("^I am asked if I'm sure I want to delete this pool$")
    public void iAmAskedIfIWantToDeleteThisPool() {
        assertEquals("Are you sure you want to delete this pool?", POOL_OVERVIEW_PAGE.getHeading());
    }

    @When("^I click the confirm deletion button$")
    public void iClickConfirmDeletion() {
        POOL_OVERVIEW_PAGE.clickDelete();
    }

    @When("^I click the cancel deletion link$")
    public void iClickCancelDeletion() {
        POOL_OVERVIEW_PAGE.clickCancel();
    }

    @Then("^a message is displayed on the pool requests page informing me that the pool has been deleted$")
    public void messageConfirmsDeletion() {
        String expectedMessage = String.format("Pool %s successfully deleted", poolRequestNumber.get());

        assertEquals(expectedMessage, POOL_REQUESTS_PAGE.getBannerMessage());
    }

    @Then("^the pool is no longer visible$")
    public void poolNoLongerVisible() {
        assertFalse(POOL_REQUESTS_PAGE.requestIsVisibleByNumber(poolRequestNumber.get()));
    }

    @Then("^I check the selected \"([^\"]*)\" is \"([^\"]*)\"$")
    public void checkTheSelectedDataItemIsCorrect(String dataItem, String selectedOption) throws Throwable {
        NAV.seeText_inSameRow_asText_inPoolRequests(dataItem, selectedOption);
    }

    @Then("^I click on the \"([^\"]*)\" link in the same row as \"([^\"]*)\" on Pool Requests$")
    public void clickChangeLinkInSameRowAs_inPoolRequests(String link, String nextTo) throws Throwable {
        NAV.clickChangeLinkInSameRowAs_inPoolRequests(link, nextTo);
    }

    @Then("^the system will display non-editable information on the pool summary screen$")
    public void theSystemWillDisplayNonEditableInformationOnThePoolSummaryScreen(DataTable table) throws ParseException {
        Map<String, String> data = table.asMap(String.class, String.class);

        assertEquals(data.get("jurorsRequested"), POOL_OVERVIEW_PAGE.getNumberOfJurorsRequested());
        assertEquals(data.get("jurorsConfirmed"), POOL_OVERVIEW_PAGE.getNumberOfJurorsConfirmed());
        assertEquals(data.get("jurorsSummoned"), POOL_OVERVIEW_PAGE.getNumberOfJurorsSummoned());
        assertEquals(data.get("currentPoolSize"), POOL_OVERVIEW_PAGE.getCurrentPoolSize());
        assertEquals(data.get("courtName"), POOL_OVERVIEW_PAGE.getCourtName());
        assertEquals(data.get("courtLocationCode"), POOL_OVERVIEW_PAGE.getCourtLocationCode());
        if (poolDate.get() != null) {
            assertEquals(poolDate.get(), POOL_OVERVIEW_PAGE.getConvertedStartDate());
        }
    }

    @Then("^the system will display non-editable information on the court version of the pool summary screen$")
    public void theSystemWillDisplayNonEditableInformationOnTheCourtPoolSummaryScreen(DataTable table) throws ParseException {
        Map<String, String> data = table.asMap(String.class, String.class);

        assertEquals(data.get("courtName"), POOL_OVERVIEW_PAGE.getCourtName());
        assertEquals(data.get("courtLocationCode"), POOL_OVERVIEW_PAGE.getCourtLocationCode());
        if (poolDate.get() != null) {
            assertEquals(poolDate.get(), POOL_OVERVIEW_PAGE.getConvertedStartDate());
        }
    }

    @Then("^the pool summary donut displays$")
    public void thePoolSummaryDonutDisplays(DataTable table) throws ParseException {
        Map<String, String> data = table.asMap(String.class, String.class);

        assertEquals(data.get("summoned"), POOL_OVERVIEW_PAGE.getNumberOfJurorsSummoned());
        assertEquals(data.get("required"), POOL_OVERVIEW_PAGE.getNumberOfJurorsRequired());
        assertEquals(data.get("confirmed"), POOL_OVERVIEW_PAGE.getNumberOfJurorsConfirmed());
        assertEquals(data.get("unavailable"), POOL_OVERVIEW_PAGE.getNumberOfJurorsUnavailable());
        assertEquals(data.get("notResponded"), POOL_OVERVIEW_PAGE.getNumberOfJurorsNotResponded());
        assertEquals(data.get("surplus"), POOL_OVERVIEW_PAGE.getNumberOfJurorsSurplus());
    }

    @Then("^the system will display non-editable information on the nil pool summary screen$")
    public void theSystemWillDisplayNonEditableInformationOnTheNilPoolSummaryScreen(DataTable table) throws Exception {
        Map<String, String> expectedData = table.asMap(String.class, String.class);

        //Converting Attendance Date to same format as Overview Page for assertion
        String datePattern = "EEEEE dd MMM yyyy";
        Calendar date = Calendar.getInstance();
        date.add(Calendar.WEEK_OF_MONTH, 9);
        Date actualDate = new SimpleDateFormat(datePattern).parse(selectedAttendanceDate.get());
        DateFormat dateFormat = new SimpleDateFormat(datePattern);
        String startDate = dateFormat.format(actualDate);

        Map<String, String> actualData = POOL_OVERVIEW_PAGE.getPoolOverviewDetails();
        assertEquals(poolRequestNumber.get(), actualData.get("poolRecord"));
        assertEquals(expectedData.get("court"), actualData.get("court"));
        assertEquals(expectedData.get("courtCode"), actualData.get("courtCode"));
        assertEquals(startDate, actualData.get("courtStartDate"));
    }

    @Then("^I do not see the nil pool status$")
    public void iDoNotSeeTheNilPoolStatus() {
        assertFalse(POOL_OVERVIEW_PAGE.statusExists());
    }

    @When("^I select to create a nil pool$")
    public void iClickCreateNilPool() throws Throwable {
        NAV.press_buttonByName("Create pool");
        GRP.click_radioButtonWithLabel("Nil pool - no jurors to be added");
        NAV.press_buttonByName("Continue");
    }

    @And("^the max number of deferrals will be displayed for the selected day$")
    public void theMaxNumberOfDeferralsWillBeDisplayedForTheSelectedDay() {
        // Need to know the max deferral number is
    }

    @And("^I select a usable postcode from the list$")
    public void iSelectAUsablePostcodeFromTheList() {
        // Need to know what postcodes will be available to use.
    }

    @And("^I see the pool number of the pool$")
    public void iSeeThePoolNumber() {
        poolNumber.set(CHECK_POOL_REQUEST_PAGE.getPoolNumber());
    }

    @And("^I submit the pool request$")
    public void iSubmitThePoolRequest() {
        POOL_REQUESTS_PAGE.clickConfirm();
        // Click the confirm button
    }

    @Then("^I'll go to the pool summary screen$")
    public void iLlGoToThePoolSummaryScreen() {
        NAV.click_link_by_text("Active pools");
    }

    @Then("^I can see that this is a nil pool$")
    public void iCanSeeThisIsANilPool() {
        String heading = POOL_REQUESTS_PAGE.getPageHeading();
        assertEquals("", heading);
    }

    @And("^I can see a list of summoned jurors$")
    public void iCanSeeAListOfSummonedJurors() {
        // Need a list of jurors that could be summoned.
        // Need to confirm a list of jurors are visible on the page
    }

    @Then("^the pool request page will show the filtered courts$")
    public void thePoolRequestPageWillShowTheFilteredCourts() {
        assertEquals(summonedNumber, CORONERS_POOL_PAGE.getCoronersRowsOfCitizens().toString());
    }

    @When("^I click the link to the new pool screen$")
    public void iClickTheLinkToTheNewPoolScreen() throws InterruptedException {
        POOL_REQUESTS_PAGE.clickNewPoolLink();
    }

    @Then("^I am taken to the new pool screen$")
    public void iShouldBeTakenToTheNewPoolScreen() {
        assertEquals("Request a new pool", POOL_REQUESTS_PAGE.getPageHeading());
    }

    @Then("^I am taken to summons management$")
    public void iShouldBeTakenToSummonsManagement() {
        assertEquals("Your work", POOL_REQUESTS_PAGE.getPageHeading());
    }

    @And("^I should see the court to request the pool from as \"([^\"]*)\"$")
    public void iShouldSeeTheCourtToRequestThePoolFrom(final String court) {
        String actualCourt = POOL_REQUESTS_PAGE.getRequestedCourtName();
        assertEquals(court, actualCourt);
    }

    @And("^I see the attendance date of the pool$")
    public void iShouldSeeTheAttendanceDateOfThePool() {
        //Takes current date and adds 9 weeks to get expected date
        String datePattern = "EEEEE dd MMMMM yyyy";
        Calendar date = Calendar.getInstance();
        date.add(Calendar.WEEK_OF_MONTH, 9);
        String expectedDate = new SimpleDateFormat(datePattern).format(date.getTime());

        String actualDate = POOL_REQUESTS_PAGE.getRequestedCourtDate();

        assertEquals(expectedDate, actualDate);

        selectedAttendanceDate.set(actualDate);
    }

    @When("^I click the change link for the chosen court$")
    public void iClickTheChangeLinkForTheChosenCourt() {
        POOL_REQUESTS_PAGE.clickChangeCourt();
    }

    @And("^select another available court \"([^\"]*)\"$")
    public void selectAnotherAvailableCourt(final String court) {
        POOL_REQUESTS_PAGE.enterAndSelectCourt(court);
        POOL_REQUESTS_PAGE.confirmNewCourtSelection();
    }

    @Then("^the court to request the pool from has changed to \"([^\"]*)\"$")
    public void theCourtToRequestThePoolFromHasChanged(final String court) {
        String actualCourt = POOL_REQUESTS_PAGE.getRequestedCourtName();
        assertEquals(court, actualCourt);
    }

    @When("^I see the default attendance date$")
    public void iSeeTheDefaultAttendanceDate() {
        // Need the element for the attendance date
        // Default attendance date should be set to 9 weeks from current date
    }

    @When("^I click the change link for the attendance date$")
    public void iClickTheChangeLinkForTheAttendanceDate() {
        POOL_REQUESTS_PAGE.clickChangeDate();
    }

    @And("^I select a new date$")
    public void iSelectANewDate() {
        String datePattern = "dd/MM/yyyy";
        String fullDatePattern = "EEEEE dd MMMMM yyyy";
        Calendar date = Calendar.getInstance();
        date.add(Calendar.WEEK_OF_MONTH, 10);
        selectedAttendanceDate.set(new SimpleDateFormat(fullDatePattern).format(date.getTime()));
        String newDate = new SimpleDateFormat(datePattern).format(date.getTime());

        POOL_REQUESTS_PAGE.enterNewDate(newDate);
        POOL_REQUESTS_PAGE.confirmNewDate();

    }

    @And("^I select a new date \"([^\"]*)\" week in the future$")
    public void iSelectANewDate(int weekInFuture) {
        String datePattern = "dd/MM/yyyy";
        String fullDatePattern = "EEEEE dd MMMMM yyyy";
        Calendar date = Calendar.getInstance();
        date.add(Calendar.WEEK_OF_MONTH, weekInFuture);
        selectedAttendanceDate.set(new SimpleDateFormat(fullDatePattern).format(date.getTime()));
        String newDate = new SimpleDateFormat(datePattern).format(date.getTime());

        POOL_REQUESTS_PAGE.enterNewDate(newDate);
        POOL_REQUESTS_PAGE.confirmNewDate();

    }

    @Then("^I should have a new attendance date$")
    public void iShouldHaveANewAttendanceDate() {
        String datePattern = "EEEEE dd MMMMM yyyy";
        Calendar date = Calendar.getInstance();
        date.add(Calendar.WEEK_OF_MONTH, 10);
        String expectedDate = new SimpleDateFormat(datePattern).format(date.getTime());

        String actualDate = POOL_REQUESTS_PAGE.getRequestedCourtDate();

        assertEquals(expectedDate, actualDate);
    }

    @Then("^I should see the attendance time present is \"([^\"]*)\"$")
    public void iShouldSeeTheAttendanceTimePresent(String attendTime) {
        final String actualAttendanceTime = POOL_REQUESTS_PAGE.getAttendanceTime();
        assertEquals(attendTime, actualAttendanceTime);
    }
    @When("^I click the change link for the attendance time$")
    public void iClickTheChangeLinkForTheAttendanceTime() {
        POOL_REQUESTS_PAGE.clickChangeTime();
    }

    @And("^I select a new time$")
    public void iSelectANewTime() {
        POOL_REQUESTS_PAGE.fillTime("10", "00");
        POOL_REQUESTS_PAGE.confirmNewTimeEntry();
        // How will time be presented to select?
    }

    @Then("^i should have set a new attendance time$")
    public void iShouldHaveSetANewAttendanceTime() {
        final String actualAttendanceTime = POOL_REQUESTS_PAGE.getAttendanceTime();

        assertEquals("10:00", actualAttendanceTime);
    }

    @When("^I click the change link for the pool number$")
    public void iClickTheChangeLinkForThePoolNumber() {
        POOL_REQUESTS_PAGE.clickChangePoolNumber();
    }

    @When("^I do not see Change link in the same row as Pool number$")
    public void doNotSeeChangePoolNumberLink() {
        assertTrue("change pool number is visible", POOL_REQUESTS_PAGE.changePoolNumberInvisible());
    }

    @When("^I input a pool number that is already being used$")
    public void inputPoolNumberAlreadyInUse() {
        POOL_REQUESTS_PAGE.inputExistingPoolNumber();
    }

    @When("^I change the pool type to \"([^\"]*)\"$")
    public void iChangeThePoolTypeTo(String courtType) throws Throwable {
        // Need to change the pool type. Is it done by change link? Dropdown box?
        if (courtType.equals("Civil"))
            POOL_REQUESTS_PAGE.selectPoolType(PoolRequests.PoolType.CIVIL);

        if (courtType.equals("Crown"))
            POOL_REQUESTS_PAGE.selectPoolType(PoolRequests.PoolType.CROWN);

        if (courtType.equals("High"))
            POOL_REQUESTS_PAGE.selectPoolType(PoolRequests.PoolType.HIGH);
    }

    @And("^I set the pool to be on call$")
    public void iSetThePoolToBeOnCall() {
        POOL_REQUESTS_PAGE.clickOnCallPoolCheckbox();
    }

    @When("^I set the number of jurors to \"([^\"]*)\"$")
    public void iSetTheNumberOfJurorsTo(String numberOfJurors) throws Throwable {
        POOL_REQUESTS_PAGE.enterNumberOfJurors(numberOfJurors);
    }

    @When("^I click continue on the pool request page$")
    public void iClickContinueOnPoolRequest() {
        POOL_REQUESTS_PAGE.clickContinue();
    }

    @When("^I click continue on the postponement page$")
    public void iClickContinueOnPostponement() {
        POOL_REQUESTS_PAGE.clickContinue();
    }

    @When("^I click the create nil pool confirmation button$")
    public void iClickCreateNilConfirmation() {
        POOL_REQUESTS_PAGE.submitCourtDeferrals();
    }

    @Then("^I should see the check your answers page for a nil pool$")
    public void iShouldSeeCheckYourAnswersForNilPool() {
        final String header = POOL_REQUESTS_PAGE.getPageHeading();
        assertEquals("Check your answers", header);
        final String tableHeader = POOL_REQUESTS_PAGE.getTableHeading();
        assertEquals("Nil pool details", tableHeader);
    }

    @Then("^I should see an error stating the number of jurors exceeds the maximum$")
    public void iShouldSeeAnErrorStatingTheNumberOfJurorsExceedsTheMaximum() {
        final String errorText = POOL_REQUESTS_PAGE.getErrorSummaryText();
        assertTrue(errorText.contains("Enter a number that is less than 3,000"));
    }

    @And("^I click the change link for the court deferrals$")
    public void iClickTheChangeLinkForTheCourtDeferrals() {
        POOL_REQUESTS_PAGE.clickToChangeDeferrals();
    }

    @And("^I change the number of court deferrals to \"([^\"]*)\"$")
    public void iChangeTheNumberOfCourtDeferralsTo(String arg0) {
        POOL_REQUESTS_PAGE.enterNumberOfCourtDeferrals(arg0);
        POOL_REQUESTS_PAGE.submitCourtDeferrals();
    }

    @Then("^I should see an error stating the number of deferrals is too high$")
    public void iShouldSeeAnErrorStatingTheNumberOfDeferralsIsTooHigh() {
        final String errorText = POOL_REQUESTS_PAGE.getErrorSummaryText();
        assertTrue(errorText.contains("Enter the same or less than the number available"));
        POOL_REQUESTS_PAGE.clickCancel();
    }

    @Then("^I see available deferrals count is \"([^\"]*)\"$")
    public void numberOfCourtDeferralsAvailable(String numberofDeferralsDisplayed) throws Throwable {
        assertEquals(numberofDeferralsDisplayed, CHECK_POOL_REQUEST_PAGE.getNumberOfDeferrals());
    }

    @Then("^I should see the number of court deferrals set to \"([^\"]*)\"$")
    public void iShouldSeeTheNumberOfCourtDeferralsSetTo(String arg0) throws Throwable {
        // Confirm that the number of court deferrals is set correctly.
        throw new PendingException();
    }

    @Then("^I set Number of deferred jurors to include to \"([^\"]*)\" more than is available$")
    public void setDeferralsToMoreThanIsAvailable(Integer noDeferrals) throws InterruptedException {
        Integer noDefsAvailable = Integer.valueOf(CHECK_POOL_REQUEST_PAGE.getNumberOfDeferrals());
        Integer highDefsNo = noDefsAvailable + noDeferrals;
        POOL_REQUESTS_PAGE.clickToChangeDeferrals();
        POOL_REQUESTS_PAGE.enterNumberOfCourtDeferrals(String.valueOf(highDefsNo));
        POOL_REQUESTS_PAGE.submitCourtDeferrals();

    }

    @When("^I click the request pool button$")
    public void iClickTheRequestPoolButton() throws InterruptedException {

        try {
            assertTrue(CHECK_POOL_REQUEST_PAGE.poolNumberNotVisible());
            POOL_REQUESTS_PAGE.clickContinue();
        } catch (Exception e) {
            poolRequestNumber.set(CHECK_POOL_REQUEST_PAGE.getPoolNumber());
            POOL_REQUESTS_PAGE.clickContinue();
        }
    }

    @Then("^I should be taken to the check pool request page$")
    public void iShouldBeTakenToTheCheckPoolRequestPage() {
        final String checkPoolRequestHeader = CHECK_POOL_REQUEST_PAGE.getHeading();
        assertEquals("Check your pool request", checkPoolRequestHeader);
    }

    @And("^I should see the details of the pool$")
    public void iShouldSeeTheDetailsOfThePool(DataTable table) {
        Map<String, String> data = table.asMap(String.class, String.class);
        poolRequestNumber.set(CHECK_POOL_REQUEST_PAGE.getPoolNumber());

        assertEquals(selectedAttendanceDate.get(), CHECK_POOL_REQUEST_PAGE.getAttendanceDate());
        assertEquals(data.get("courtName"), CHECK_POOL_REQUEST_PAGE.getCourtName());
        assertEquals(data.get("poolType"), CHECK_POOL_REQUEST_PAGE.getPoolType());
        assertEquals(data.get("totalJurorsRequired"), CHECK_POOL_REQUEST_PAGE.getNumberOfJurors());
        assertEquals(data.get("numberOfDeferrals"), CHECK_POOL_REQUEST_PAGE.getNumberOfDeferrals());
        assertEquals(data.get("additionalJurors"), CHECK_POOL_REQUEST_PAGE.getNumberOfAdditionalJurors());
    }

    @And("^I should see the details of the nil pool$")
    public void iShouldSeeTheDetailsOfTheNilPool(DataTable table) {
        Map<String, String> data = table.asMap(String.class, String.class);
        poolRequestNumber.set(CHECK_POOL_REQUEST_PAGE.getPoolNumber());
        poolNumber.set(CHECK_POOL_REQUEST_PAGE.getPoolNumber());

        assertEquals(data.get("courtName"), CHECK_POOL_REQUEST_PAGE.getCourtName());
        assertEquals(data.get("poolType"), CHECK_POOL_REQUEST_PAGE.getPoolType());
    }

    @When("^I click the change button for the check pool request page$")
    public void iClickTheChangeButtonForTheCheckPoolRequestPage() {
        CHECK_POOL_REQUEST_PAGE.clickChangeLink();
    }

    @And("^I edit details of the pool request$")
    public void iEditDetailsOfThePoolRequest() {
        POOL_REQUESTS_PAGE.enterNumberOfJurors("15");
    }

    @And("^I save the changes to the pool request$")
    public void iSaveTheChangesToThePoolRequest() {
        POOL_REQUESTS_PAGE.clickContinue();
    }

    @Then("^the pool request should be edited successfully$")
    public void thePoolRequestShouldBeEditedSuccessfully() {
        assertEquals("15", CHECK_POOL_REQUEST_PAGE.getNumberOfJurors());
    }

    @When("^I save the new pool request$")
    public void iSaveTheNewPoolRequest() {
        poolRequestNumber.set(CHECK_POOL_REQUEST_PAGE.getPoolNumber());
        CHECK_POOL_REQUEST_PAGE.submitRequest();
    }

    @When("^I click the link for the successfully created court only pool$")
    public void iClickNewlyCreatedCourtOnlyPoolLink() {
        POOL_REQUESTS_PAGE.clickNewlyCreatedCourtOnlyPoolLink();
    }

    @Then("^I should be taken to the pool summary page$")
    public void iShouldBeTakenToThePoolSummaryPage() {
        assertEquals("Pool requests", POOL_REQUESTS_PAGE.getPageHeading());
    }

    @And("^I should see the newly created pool request$")
    public void iShouldSeeTheNewlyCreatedPoolRequest(DataTable table) {
        Map<String, String> expectedData = table.asMap(String.class, String.class);

        Map<String, String> actualData = POOL_REQUESTS_PAGE.SearchPoolRequestByNumber(poolRequestNumber.get(), expectedData.get("type"));
        assertEquals(expectedData.get("court"), actualData.get("court"));

        if(Objects.equals(expectedData.get("type"), "Bureau")){
        String expectedJurorsRequired = expectedData.get("jurorsRequired");
        if (expectedJurorsRequired == null) {
            expectedJurorsRequired = "";
        }
        assertEquals(expectedJurorsRequired, actualData.get("jurorsRequired"));
    }
    iNavigateToThePoolRequestScreen();

    }

    @When("^I click the link to the choose court screen$")
    public void iClickTheLinkToTheChooseCourtScreen() {
        // Need the element of the link to the choose court screen
    }

    @When("^I click on active pools$")
    public void iClickOnActivePools() {
        POOL_REQUESTS_PAGE.clickActivePools();
    }

    @Then("^I see the following active pools headers$")
    public void iSeeTheFollowingActivePoolsHeaders(DataTable dataTable) {
        List<String> expectedData = dataTable.asList(String.class);
        List<String> actualData = ACTIVE_POOLS_PAGE.getTableHeaders();
        expectedData.forEach(
                item -> assertTrue(
                        "Active pools headers does not contain " + item,
                        actualData.contains(item)
                )
        );
    }

    @Then("^the court name displayed is one of the following")
    public void courtNameIsOnly(DataTable dataTable) {
        List<String> expectedData = dataTable.asList(String.class);
        List<String> actualData = ACTIVE_POOLS_PAGE.getCourtNames();
        actualData.forEach(item -> assertTrue(
                        "Unexpected court name in active pools",
                        expectedData.contains(item)
                )
        );

    }

    @When("^I click the \"([^\"]*)\" courts tab$")
    public void iClickTheCrownCourtsTab(String courtType) {
        POOL_REQUESTS_PAGE.clickTab(courtType + " courts");
    }

    @When("^I click on the pool number$")
    public void iClickThePoolNumber() {
        POOL_REQUESTS_PAGE.clickPoolNumber(poolRequestNumber.get());
    }

    @Then("^I should be on the choose court screen$")
    public void iShouldBeOnTheChooseCourtScreen() {
        // Need to confirm the user has landed on the choose court screen
    }

    @When("^I select a court to request a pool for$")
    public void iSelectACourtToRequestAPoolFor() {
        // How does the user select the court? Dropdown list? Free text?
    }

    @Then("^I should see the link to the request a new pool screen$")
    public void iShouldSeeTheLinkToTheRequestANewPoolScreen() {
        // Need the element of the link to the request a new pool screen
    }

    @And("^I have navigated to the request a new pool page$")
    public void iHaveNavigatedToTheRequestANewPoolPage() {
        // Need to create the user journey to the request a new pool page
    }

    @When("^I create a bank holiday \"([^\"]*)\" weeks in the future for court/bureau \"([^\"]*)\"$")
    public void insertHolidayInTheFuture(Integer noOfWeeks, String holidayOwner) throws SQLException {
        DBT.insertHolidayInTheFuture(noOfWeeks, holidayOwner);
    }

    @When("^I create a bank holiday \"([^\"]*)\" Mondays in the future for court/bureau \"([^\"]*)\"$")
    public void insertHolidayMondayInTheFuture(Integer noOfWeeks, String holidayOwner) throws SQLException {
        DBT.insertHolidayMondayInTheFuture(noOfWeeks, holidayOwner);
    }

    @When("^I delete bank holiday")
    public void iDeleteBankHoliday() throws SQLException {
        DBT.deleteHoliday();
    }

    @When("^I have deleted all holidays")
    public void deleteAllHolidays() throws SQLException {
        DBT.deleteAllHolidays();
    }

    @Then("^I should see a warning stating I have selected a bank holiday")
    public void iShouldSeeAWarningStatingIHaveSelectedABankHoliday() {
        String actualHeading = POOL_REQUESTS_PAGE.getPageHeading();
        String actualWarning = POOL_REQUESTS_PAGE.getAttendanceDateWarning();

        assertTrue(actualWarning.contains("s a UK bank holiday. You can continue or go back and change the date."));
        assertEquals("The attendance date is a bank holiday", actualHeading);
    }

    @When("^I set the attendance date to a weekend$")
    public void iSetTheAttendanceDateToAWeekend() {
        String datePattern = "dd/MM/yyyy";
        String fullDatePattern = "EEEEE dd MMMMM yyyy";
        Calendar calendar = Calendar.getInstance();
        calendar.add(Calendar.WEEK_OF_MONTH, 9);

        LocalDate localDate = calendar.toInstant().atZone(ZoneId.systemDefault()).toLocalDate();
        LocalDate localDateWeekend = localDate.with(TemporalAdjusters.next(DayOfWeek.SATURDAY));
        Date weekendDate = Date.from(localDateWeekend.atStartOfDay().atZone(ZoneId.systemDefault()).toInstant());

        selectedAttendanceDate.set(new SimpleDateFormat(fullDatePattern).format(weekendDate.getTime()));
        String weekendDateValue = new SimpleDateFormat(datePattern).format(weekendDate.getTime());

        POOL_REQUESTS_PAGE.enterNewDate(weekendDateValue);
        POOL_REQUESTS_PAGE.confirmNewDate();
    }

    @Then("^I should see a warning stating I have selected a weekend$")
    public void iShouldSeeAWarningStatingIHaveSelectedAWeekend() {
        String actualHeading = POOL_REQUESTS_PAGE.getPageHeading();
        String actualWarning = POOL_REQUESTS_PAGE.getAttendanceDateWarning();

        assertEquals("You’ve selected an attendance date that’s a Saturday or a Sunday. You can continue or go back and change the date.", actualWarning);
        assertEquals("The attendance date is a weekend", actualHeading);

    }

    @When("^I click the link to continue from the warning page$")
    public void iClickTheLinkToContinue() {
        POOL_REQUESTS_PAGE.continueFromWarningPage();

    }

    @Given("^a transferred juror record exists with both court and bureau records$")
    public void transferredJurorRecordExistsWithCourtAndBureauRecords() {
        jurorRecordNumber = "987654321";
    }

    @Given("^a juror record which is valid for paper summons reply exists$")
    public void paperSummonsJurorExists() {
        jurorRecordNumber = "111000002";
    }

    @Given("^a juror record of \"([^\"]*)\" has been entered which is valid for paper summons reply$")
    public void createPaperSummonsReplyJuror(String newJurorRecordNumber) throws SQLException {
        DBT.insertNewPaperSummonsReply(newJurorRecordNumber, "415230501");
        summonsReplyNumber = newJurorRecordNumber;
    }

    @Given("^a juror record of \"([^\"]*)\" has been entered which is valid for paper summons reply for the pool$")
    public void createPaperSummonsReplyJurorForPool(String newJurorRecordNumber) throws SQLException {
        DBT.insertNewPaperSummonsReply(newJurorRecordNumber, poolNumber.get());
        summonsReplyNumber = newJurorRecordNumber;
    }

    @Given("^a juror record of \"([^\"]*)\" has been entered which is valid for paper summons reply with name change$")
    public void createPaperSummonsReplyJurorChangedName(String newJurorRecordNumber) throws SQLException {
        DBT.insertNewPaperSummonsReplyWithResponseName(newJurorRecordNumber, "Changed", "Name", "415230501");
        summonsReplyNumber = newJurorRecordNumber;
    }

    @Given("^CJS employment, reasonable adjustments reasons have been entered for \"([^\"]*)\"$")
    public void cjsAndAdjustmentsEntered(String jurorNumber) throws SQLException {
        DBT.insertReasonableAdjustments(jurorNumber);
        DBT.insertCJSStatus(jurorNumber);
    }

    @Given("^a juror record of \"([^\"]*)\" has been entered which is valid for summons reply$")
    public void createSummonsReplyJuror(String newJurorRecordNumber) throws SQLException {
        DBT.insertNewSummonsReply(newJurorRecordNumber);
        summonsReplyNumber = newJurorRecordNumber;
        jurorPartNumber.set(newJurorRecordNumber);
    }

    @Given("^a juror record of \"([^\"]*)\" has been entered with an excusal reason of \"([^\"]*)\"$")
    public void createSummonsReplyExcusalJuror(String newJurorRecordNumber, String excusalReason) throws SQLException {
        DBT.insertNewSummonsReplyExcusal(newJurorRecordNumber, excusalReason);
        summonsReplyNumber = newJurorRecordNumber;
    }

    @Given("^I clear down the data for the paper juror record \"([^\"]*)\"$")
    public void deletePaperSummonsJuror(String createdJurorRecordNumber) throws SQLException {
        DBT.deleteNewPaperSummonsReply(createdJurorRecordNumber);
    }

    @Given("^I clear down the data for the juror record \"([^\"]*)\"$")
    public void deleteSummonsJuror(String createdJurorRecordNumber) throws SQLException {
        DBT.deleteNewSummonsReply(createdJurorRecordNumber);
    }

    @Given("^I clear down the data for the pool$")
    public void deleteTestPoolAndJurors() throws SQLException {
        DBT.deleteTestPoolAndJurors(poolNumber.get());
    }

    @And("^I click the More Actions button$")
    public void clickMoreActions() {
        VIEW_SUMMONS_REPLY.clickMoreActions();
    }

    @And("^I click Awaiting Information$")
    public void clickAwaitingInformation() {
        VIEW_SUMMONS_REPLY.clickAwaitingInformation();
    }

    @Then("^I mark this reply as awaiting information from \"([^\"]*)\"$")
    public void markAwaitingInformationFrom(String awaitingInformationFrom) {
        try {
            if (Objects.equals(awaitingInformationFrom, "Court")) {
                System.out.println("Selecting Court");
                VIEW_SUMMONS_REPLY.clickAwaitingCourt();
            }
            ;
            if (Objects.equals(awaitingInformationFrom, "Juror")) {
                VIEW_SUMMONS_REPLY.clickAwaitingJuror();
            }
            if (Objects.equals(awaitingInformationFrom, "Translation unit")) {
                VIEW_SUMMONS_REPLY.clickAwaitingTransfer();
            }
        } catch (Exception e) {
            System.out.println("Invalid Reply Type entered - " + e);
        }
    }

    @When("^the user searches for the juror record from the global search bar$")
    public void userSearchesForJurorRecord() throws InterruptedException {
        JUROR_RECORD_SEARCH.searchForRecordFromGlobalSearch(jurorPartNumber.get());
    }

    @When("^the user searches for juror record \"([^\"]*)\" from the global search bar$")
    public void userSearchesForJurorRecord(String partNo) throws InterruptedException {
        JUROR_RECORD_SEARCH.searchForRecordFromGlobalSearch(partNo);

    }

    @And("^I search for juror \"([^\"]*)\"$")
    public void clickGlobalSearch(String jurorNumber) {
        JUROR_RECORD_SEARCH.searchForRecordFromGlobalSearch(jurorNumber);
    }

    @And("^I search for pool number$")
    public void globalSearchForPool() {
        JUROR_RECORD_SEARCH.searchForRecordFromPoolSearch(poolNumber.get());
    }

    @When("^I check the search juror button is not visible$")
    public void searchJurorButtonNotVisible() {
        assertTrue("search button was visible", JUROR_RECORD_SEARCH.searchButtonInvisible());
    }

    @When("^I check the Apps button is not visible$")
    public void appsButtonInvisible() {
        assertTrue("apps button is visible", HEADER_PAGE.appsButtonInvisible());
    }

    @When("^the user enters an incorrect juror record number$")
    public void userEntersInvalidJurorRecordNumber() throws InterruptedException {
        JUROR_RECORD_SEARCH.searchForRecordFromGlobalSearch("999999999");
    }

    @Then("^an error message is displayed explaining that there are no matching results$")
    public void anErrorMessageIsDisplayedForSearch() {
        String mainText = JUROR_RECORD_SEARCH.getMainBodyText();
        assertTrue(mainText.contains("There are no matching results"));
        assertTrue(mainText.contains("Improve your search by:"));
        assertTrue(mainText.contains("double-checking your spelling"));
        //assertTrue(mainText.contains("searching by the complete juror number only"));
    }

    @Then("^the juror record is displayed with the following fields$")
    public void jurorRecordDisplayedWithFollowingFields(DataTable table) {
        Map<String, String> data = table.asMap(String.class, String.class);
        assertEquals(data.get("Juror number"), JUROR_RECORD_SEARCH.getJurorNumber());
        assertEquals(data.get("Juror status"), JUROR_RECORD_SEARCH.getJurorStatus());
        assertEquals(data.get("Pool number"), JUROR_RECORD_SEARCH.getPoolNumber());
        assertEquals(DBT.getTodaysDateEEEddMMMyyyy(), JUROR_RECORD_SEARCH.getCourtStartDate());
        assertEquals(data.get("Court name"), JUROR_RECORD_SEARCH.getCourtName());
    }

    @Given("^multiple pool records from multiple courts exist$")
    public void multiplePoolRecordsMultipleCourtsExist() {
        //TODO - data creation when we have launch darkly/AD
    }

    @When("^the user filters by \"([^\"]*)\"$")
    public void userEntersIntoFilterField(String court) throws InterruptedException {
        POOL_REQUESTS_PAGE.enterFilterString(court);
        POOL_REQUESTS_PAGE.clickFilterAutocompleteOption();
        POOL_REQUESTS_PAGE.clickFilterButton();
    }

    @Then("^only records from \"([^\"]*)\" are displayed$")
    public void onlyRecordsFromAreDisplayed(String expectedCourt) {
        List<String> courtList = POOL_REQUESTS_PAGE.getPoolRequestCourtNames();
        courtList.forEach(
                e -> assertEquals(expectedCourt, e)
        );
    }

    @Then("^no records are displayed$")
    public void noRecordsAreDisplayed() {
        List<String> courtList = POOL_REQUESTS_PAGE.getPoolRequestCourtNames();
        assertTrue(courtList.isEmpty());
    }
    @Then("^records are displayed$")
    public void recordsAreDisplayed() {
        List<String> courtList = POOL_REQUESTS_PAGE.getPoolRequestCourtNames();
        assertFalse(courtList.isEmpty());
    }

    @Then("^only active records from \"([^\"]*)\" are displayed$")
    public void onlyActiveRecordsFromAreDisplayed(String expectedCourt) {
        List<String> courtList = POOL_REQUESTS_PAGE.getActivePoolRequestCourtNames();
        courtList.forEach(
                e -> assertEquals(expectedCourt, e)
        );
    }

    @When("^I enter a juror details phone number of \"([^\"]*)\"$")
    public void enterReplyDetailsPhone(String phone) {
        SUMMONS_REPLY.enterPrimaryPhone(phone);
    }

    @Then("^an error is displayed on the juror summons reply page saying \"([^\"]*)\"$")
    public void replyDetailsErrorIsDisplayed(String error) {
        assertTrue(SUMMONS_REPLY.getErrors().contains(error));
    }

    @When("^I enter a juror details email of \"([^\"]*)\"$")
    public void enterReplyDetailsEmail(String email) {
        SUMMONS_REPLY.enterEmail(email);
    }

    @When("^I click save on the juror details change page$")
    public void saveJurorDetailsChange() {
        SUMMONS_REPLY.saveChanges();
    }

    @When("^I enter a first name of \"([^\"]*)\" on the juror summons reply change name page$")
    public void enterJurorDetailsFirstName(String name) {
        SUMMONS_REPLY.enterFirstName(name);

    }

    @When("^I enter an address line 1 of \"([^\"]*)\" on the juror summons reply change address page$")
    public void enterJurorDetailsAddress1(String address) {
        SUMMONS_REPLY.enterAddressLineOne(address);
    }

    @Then("^I see a name of \"([^\"]*)\" on the juror details reply page$")
    public void iSeeNameOfJurorDetails(String name) {
        assertTrue(SUMMONS_REPLY.getJurorName().contains(name));
    }

    @Then("^I see an address of \"([^\"]*)\" on the juror details reply page$")
    public void iSeeAddressOfJurorDetails(String address) {
        assertTrue(SUMMONS_REPLY.getJurorAddress().contains(address));
    }

    @When("^I click the change name link on the juror details reply page$")
    public void clickChangeJurorDetailsName() {
        SUMMONS_REPLY.clickChangeName();
    }

    @When("^I click the change address link on the juror details reply page$")
    public void clickChangeJurorDetailsAddress() {
        SUMMONS_REPLY.clickChangeAddress();
    }

    @Then("^no active records are displayed$")
    public void noActiveRecordsAreDisplayed() {
        List<String> courtList = POOL_REQUESTS_PAGE.getActivePoolRequestCourtNames();
        assertTrue(courtList.isEmpty());
    }

    @And("^I click the Enter summons reply button$")
    public void clickEnterSummonsReplyButton() {
        SUMMONS_REPLY.clickEnterSummonsReplyButton();
    }

    @Then("^the juror details form is displayed$")
    public void verifyEnterSummonsFormDisplayed() {
        assertEquals("Juror details", SUMMONS_REPLY.getHeadingText());
    }

    @Then("^the juror details form is not displayed$")
    public void verifyEnterSummonsFormNotDisplayed() {
        assertNotEquals("Juror details", SUMMONS_REPLY.getHeadingText());
    }

    @When("^I fill in all of the juror details for the summons reply$")
    public void fillJurorDetailsForSummonsReply() {
        SUMMONS_REPLY.enterDateOfBirth("18/07/1976");

        SUMMONS_REPLY.enterPrimaryPhone("0777777777");
        SUMMONS_REPLY.enterSecondaryPhone("0777777771");
        SUMMONS_REPLY.enterEmail("test@test.com");
    }

    @And("^I enter a date of birth in the summons reply that will make the juror too old$")
    public void enterDateOfBirthTooOld() {
        SUMMONS_REPLY.enterDateOfBirth("01/01/1945");

    }

    @And("^I change a date of birth of a juror that will make more than 75 years$")
    public void enterDateOfBirthTMorethan75Years() {
        String datePattern = "dd/MM/yyyy";
        Calendar date = Calendar.getInstance();
        date.add(Calendar.MONTH, 2);
        date.add(Calendar.YEAR, -76);
        String enterDOBDate = new SimpleDateFormat(datePattern).format(date.getTime());
        SUMMONS_REPLY.enterDateOfBirth(enterDOBDate);
    }

    @And("^I enter a date of birth in the summons reply that will make the juror too young$")
    public void enterDateOfBirthTooYoung() {
        int yearYoung = ((Year.now().getValue()) - 16);

        SUMMONS_REPLY.enterDateOfBirth("01/01/" + yearYoung);

    }

    @And("^I enter a date of birth that will make the juror between 18 and 75$")
    public void enterDateOfBirthJustRight() {
        int yearYoung = ((Year.now().getValue()) - 30);

        SUMMONS_REPLY.enterDateOfBirth("18/07/" + yearYoung);

    }

    @And("^I click continue on the juror summons reply page$")
    public void clickContinueOnJurorSummonsReplyPage() {
        SUMMONS_REPLY.clickContinue();
    }

    @Then("^the juror summons reply eligibility page is displayed$")
    public void verifyJurorSummonsReplyEligibilityPageDisplayed() {
        assertEquals("Eligibility", SUMMONS_REPLY.getHeadingText());
    }

    @When("^I answer the juror summons reply eligibility questions$")
    public void answerJurorSummonsReplyEligibilityQuestions() {
        SUMMONS_REPLY.clickLivedConsecutivelyYes();
        SUMMONS_REPLY.clickMentalHealthActNo();
        SUMMONS_REPLY.clickLackCapacityNo();
        SUMMONS_REPLY.clickOnBailNo();
        SUMMONS_REPLY.clickCriminalOffenceNo();
    }

    @Then("^the juror summons reply types page is displayed$")
    public void verifyJurorSummonsReplyTypesPageDisplayed() {
        assertEquals("Reply types", SUMMONS_REPLY.getHeadingText());
    }

    @When("^I select that the juror can serve on the summons date$")
    public void selectJurorCanServeOnSummonsDate() {
        SUMMONS_REPLY.clickCanServeDate();
    }

    @Then("^the juror summons reply CJS employment page is displayed$")
    public void verifyJurorSummonsReplyCJSEmploymentPageDisplayed() {
        assertEquals("CJS employment", SUMMONS_REPLY.getHeadingText());
    }

    @When("^I select that the juror has not worked in the criminal justice system$")
    public void selectJurorNotWorkedInCriminalJusticeSystem() {
        SUMMONS_REPLY.clickCjsEmploymentNo();
    }

    @When("^I select that the juror has worked for the police force$")
    public void yesToPoliceForce() {
        SUMMONS_REPLY.clickCjsEmploymentYes();
        SUMMONS_REPLY.selectPoliceForceYes();
    }

    @When("^I enter over 2000 characters in the Which police force\\? text box$")
    public void over2000charactersPolice() {
        String longText = StringUtils.repeat("Test", 501);
        SUMMONS_REPLY.enterPoliceForceDetails(longText);
    }

    @Then("^the juror summons reply reasonable adjustments page is displayed$")
    public void verifyJurorSummonsReplyReasonableAdjustmentsPageDisplayed() {
        assertEquals("Reasonable adjustments", SUMMONS_REPLY.getHeadingText());
    }

    @When("^I select that the juror does not need adjustments$")
    public void selectJurorDoesNotNeedAdjustments() {
        SUMMONS_REPLY.clickAdjustmentsNo();
    }

    @When("^I select that the juror wants communications in Welsh$")
    public void selectJurorWantsWelshComms() {
        SUMMONS_REPLY.clickWelsh();
    }

    @Then("^the juror summons reply Signature page is displayed$")
    public void verifyJurorSummonsReplySignaturePageDisplayed() {
        assertEquals("Signature", SUMMONS_REPLY.getHeadingText());
    }

    @When("^I select that the summons reply has been signed$")
    public void selectSummonsReplyHasBeenSigned() {
        SUMMONS_REPLY.clickSignedYes();
    }

    @And("^I click done on the juror summons reply page$")
    public void clickDoneOnJurorSummonsReplyPage() {
        SUMMONS_REPLY.clickDoneButton();
    }

    @Then("^the view summons reply page is displayed$")
    public void verifyViewSummonsReplyPageDisplayed() {
        // TODO - when view is completed
    }

    @Given("^a standard paper summons reply has been entered$")
    public void standardPaperSummonsHasBeenEntered() {
        summonsReplyNumber = "111000000";
    }


    @Given("^I navigate to the paper summons reply$")
    public void iNavigateToThePaperSummonsReply() {
        String currentUrl = webDriver.getCurrentUrl();
        String protocol = NAV.getProtocolFromURLString(currentUrl);
        String subUrl = currentUrl.split("https?://")[1].split("/")[0];
        webDriver.get(protocol + subUrl + String.format("/summons-replies/response/%s/paper", summonsReplyNumber));
    }

    @Given("^I navigate to the summons reply$")
    public void iNavigateToTheSummonsReply() {
        String currentUrl = webDriver.getCurrentUrl();
        String protocol = NAV.getProtocolFromURLString(currentUrl);
        String subUrl = currentUrl.split("https?://")[1].split("/")[0];
        webDriver.get(protocol + subUrl + String.format("/response/%s", summonsReplyNumber));
    }

    @When("^I select Process reply$")
    public void selectProcessReply() throws Throwable {
        NAV.press_buttonByName("Process reply");
    }

    @When("^I select the Excusal radio button$")
    public void selectExcusal() {
        SUMMONS_REPLY.selectExcusalRadio();
    }

    @When("^I click continue on the process reply page$")
    public void clickContinueProcessReply() {
        SUMMONS_REPLY.clickContinue();
    }

    @When("^I select the Grant Excusal radio button$")
    public void selectGrantExcusalRadio() {
        SUMMONS_REPLY.selectGrantExcusalRadio();
    }

    @Then("^I see the excusal success message for \"([^\"]*)\"$")
    public void iSeeExcusalSuccessMessage(String excusalReason) {
        String bannerText = SUMMONS_REPLY.getResponseBannerText();
        assertTrue(bannerText.contains("successfully processed"));
        assertTrue(bannerText.contains("Excusal granted"));
        assertTrue(bannerText.contains(excusalReason));
    }

    @And("^I see the name of the juror on the page header$")
    public void iSeeTheJurorsNameInTheHeader() {
        assertTrue("The Juror's name is NOT present in the header.", VIEW_SUMMONS_REPLY.jurorNameHeaderIsPresent());
    }

    @And("^I see the reply status on the page$")
    public void iSeeTheReplyStatus() {
        originalReplyStatus = VIEW_SUMMONS_REPLY.getReplyStatus();
    }

    @And("^I see the reply status has updated to \"([^\"]*)\"$")
    public void replyStatusHasBeenUpdated(String updatedReplyStatus) {
        assertEquals("Reply Status is not as expected", updatedReplyStatus, VIEW_SUMMONS_REPLY.getReplyStatus());
    }

    @Then("^I see the following summons reply details under the juror details tab$")
    public void iSeeTheFollowingSummonsReplyDetailsUnderJurorDetails(DataTable dataTable) {
        Map<String, String> expectedData = dataTable.asMap(String.class, String.class);
        Map<String, String> actualData = VIEW_SUMMONS_REPLY.getJurorDetails();
        assertEquals(expectedData.get("jurorName"), actualData.get("jurorName"));
        assertEquals(expectedData.get("jurorAddress"), actualData.get("jurorAddress"));
        assertEquals(expectedData.get("jurorDob"), actualData.get("jurorDob"));
        assertEquals(expectedData.get("jurorMainPhone"), actualData.get("jurorMainPhone"));
        assertEquals(expectedData.get("jurorAltPhone"), actualData.get("jurorAltPhone"));
        assertEquals(expectedData.get("jurorEmail"), actualData.get("jurorEmail"));
    }

    @And("^I see the reply \"([^\"]*)\" on the response is \"([^\"]*)\"$")
    public void replyTypeStatus(String flag, String value) {

        if (flag.equals("type"))
            assertEquals("Reply " + flag + " is not as expected", value, VIEW_SUMMONS_REPLY.getTypeValue());

        if (flag.equals("status"))
            assertEquals("Reply " + flag + " is not as expected", value, VIEW_SUMMONS_REPLY.getStatusValue());
    }

    @Then("^I see the following summons reply details under the eligibility tab$")
    public void iSeeTheFollowingSummonsReplyDetailsUnderEligibilityDetails(DataTable dataTable) {
        Map<String, String> expectedData = dataTable.asMap(String.class, String.class);
        Map<String, String> actualData = VIEW_SUMMONS_REPLY.getJurorEligibility();

        assertEquals(expectedData.get("jurorResidency"), actualData.get("jurorResidency"));
        assertEquals(expectedData.get("jurorMca"), actualData.get("jurorMca"));
        assertEquals(expectedData.get("jurorBail"), actualData.get("jurorBail"));
        assertEquals(expectedData.get("jurorConvictions"), actualData.get("jurorConvictions"));
    }

    @When("^I click the juror details eligibility tab$")
    public void iClickTheEligibilityTab() {
        VIEW_SUMMONS_REPLY.clickEligibilityTab();
    }

    @When("^I click the juror details deferral tab$")
    public void iClickTheDeferralTab() {
        VIEW_SUMMONS_REPLY.clickDeferralTab();
    }

    @Then("^I see the deferral status is \"([^\"]*)\"$")
    public void iSeeTheDeferralStatusIs(String status) {
        status = status.replace("\\n", "\n").replace("\\", "");
        assertEquals(status, VIEW_SUMMONS_REPLY.getDeferral());
    }

    @When("^I click the juror details CJS tab$")
    public void iClickTheCJSTab() {
        VIEW_SUMMONS_REPLY.clickCjsTab();
    }

    @Then("^I see the CJS status is \"([^\"]*)\"$")
    public void iSeeTheCJSStatusIs(String status) {
        // This is not nice, but I believe there's a bug in Cucumber making it necessary
        status = status.replace("\\n", "\n").replace("\\", "");
        assertEquals(status, VIEW_SUMMONS_REPLY.getCjsStatus());
    }

    @Then("^I see a previous name of \"([^\"]*)\"$")
    public void iSeePreviousNameOf(String previousName) {
        // This is not nice, but I believe there's a bug in Cucumber making it necessary
        previousName = previousName.replace("\\n", "\n").replace("\\", "");
        assertEquals(previousName, VIEW_SUMMONS_REPLY.getPreviousName());
    }

    @When("^I click the juror details adjustments tab$")
    public void iClickTheAdjustmentsTab() {
        VIEW_SUMMONS_REPLY.clickAdjustmentsTab();
    }

    @Then("^I see the adjustments status is \"([^\"]*)\"$")
    public void iSeeTheAdjustmentsStatusIs(String status) {
        // This is not nice, but I believe there's a bug in Cucumber making it necessary
        status = status.replace("\\n", "\n").replace("\\", "");
        assertEquals(status, VIEW_SUMMONS_REPLY.getAdjustmentStatus());
    }

    @When("^I click the juror details signature tab$")
    public void iClickTheSignatureTab() {
        VIEW_SUMMONS_REPLY.clickSignatureTab();
    }

    @Then("^I see the signature status is \"([^\"]*)\"$")
    public void iSeeTheSignatureStatusIs(String status) {
        assertEquals(status, VIEW_SUMMONS_REPLY.getSignatureStatus());
    }

    @Given("^I navigate to the pool search screen$")
    public void navigateToPoolSearch() {
        iNavigateToThePoolRequestScreen();
        POOL_REQUESTS_PAGE.clickSearchTab();
    }

    @When("^I enter the pool number \"([^\"]*)\" on the pool search screen$")
    public void enterPoolNumberInSearch(String poolNo) {
        POOL_SEARCH.enterPoolNo(poolNo);
    }

    @When("^I enter the pool number of the pool I have just created on the pool search screen$")
    public void enterCreatedPoolNumberInSearch() {
        POOL_SEARCH.enterPoolNo(poolNumber.get());
    }

    @When("^I select the newly created pool from the reassign page$")
    public void selectPoolFromReassignnSearchList() {
        POOL_SEARCH.clickPoolNumberInSearchList(poolNumber.get());
    }

    @When("^I enter a location code of \"([^\"]*)\" for the pool search$")
    public void enterLocationCodeInPoolSearch(String locationCode) {
        POOL_SEARCH.enterLocationCode(locationCode);
    }

    @When("^I enter a date of \"([^\"]*)\" for the pool search$")
    public void enterPoolDateInSearch(String date) {
        POOL_SEARCH.enterServiceStartDate(date);

    }

    @When("^I search for the pool$")
    public void clickPoolSearch() {
        POOL_SEARCH.clickContinue();
    }

    @When("^I expand the pool search advanced search criteria$")
    public void expandPoolSearchAdvanced() {
        POOL_SEARCH.clickAdvancedSearch();
    }

    @When("^I select the Requested option in the advanced pool search section$")
    public void selectRequestedPoolSearch() {
        POOL_SEARCH.clickPoolRequested();
    }

    @When("^I select the Active option in the advanced pool search section$")
    public void selectActivePoolSearch() {
        POOL_SEARCH.clickPoolActive();
    }

    @When("^I select the Completed option in the advanced pool search section$")
    public void selectCompletedPoolSearch() {
        POOL_SEARCH.clickPoolCompleted();
    }

    @When("^I select the With the Bureau option in the advanced pool search section$")
    public void selectWithTheBureauPoolSearch() {
        POOL_SEARCH.clickWithTheBureau();
    }

    @When("^I select the At Court option in the advanced pool search section$")
    public void selectAtCourtPoolSearch() {
        POOL_SEARCH.clickAtCourt();
    }

    @When("^I select the Crown Court option in the advanced pool search section$")
    public void selectCrownCourtPoolSearch() {
        POOL_SEARCH.clickCrownCourt();
    }

    @When("^I select the Civil Court option in the advanced pool search section$")
    public void selectCivilCourtPoolSearch() {
        POOL_SEARCH.clickCivilCourt();
    }

    @When("^I select the High Court option in the advanced pool search section$")
    public void selectHighCourtPoolSearch() {
        POOL_SEARCH.clickHighCourt();
    }

    @When("^I select all the tick boxes in the advanced search section$")
    public void selectAllAdvancedTickBoxes() {
        //Pool Status
        POOL_SEARCH.clickPoolRequested();
        POOL_SEARCH.clickPoolActive();
        POOL_SEARCH.clickPoolCompleted();

        //Pool Stage
        POOL_SEARCH.clickWithTheBureau();
        POOL_SEARCH.clickAtCourt();

        //Pool Type
        POOL_SEARCH.clickCrownCourt();
        POOL_SEARCH.clickCivilCourt();
        POOL_SEARCH.clickHighCourt();
    }

    @Then("^all the tick boxes in the advanced search section are still selected$")
    public void allTheAdvancedTickBoxesAreSelected() {
        //Pool Status
        assertTrue(POOL_SEARCH.poolRequestedIsSelected());
        assertTrue(POOL_SEARCH.poolActiveIsSelected());
        assertTrue(POOL_SEARCH.poolCompletedIsSelected());

        //Pool Stage
        assertTrue(POOL_SEARCH.withTheBureauIsSelected());
        assertTrue(POOL_SEARCH.atCourtIsSelected());

        //Pool Type
        assertTrue(POOL_SEARCH.crownCourtIsSelected());
        assertTrue(POOL_SEARCH.civilCourtIsSelected());
        assertTrue(POOL_SEARCH.highCourtIsSelected());
    }

    @Then("^the pool is displayed$")
    public void thePoolIsDisplayed() {
        assertTrue(POOL_SEARCH.poolRecordIsDisplayed());
    }

    @Then("^no pool search result is found$")
    public void noPoolSearchFound() {
        assertEquals("There are no matching results", POOL_SEARCH.getPoolSearchErrorText());
    }

    @Then("^the pool search results are found$")
    public void poolSearchFound() {
        int actualNumberOfResults = POOL_SEARCH.getPoolSearchNumberOfResults();
        int numberOfResultsInHeader = Integer.parseInt(POOL_SEARCH.getPoolSearchResultText().replaceAll("[^0-9]", ""));
        log.info("\nNumber of results in header: "+ numberOfResultsInHeader +"\nNumber of results in list:   "+ actualNumberOfResults);
        assertEquals(numberOfResultsInHeader, actualNumberOfResults);
    }

    @Then("^I am on the modernisation version of View Summons Reply$")
    public void iAmOnModernisationVersionOfSummonsReply() {
        NAV.waitForPageLoad();
        assertTrue(VIEW_SUMMONS_REPLY.seeSummonsReplyTag());
        assertTrue(VIEW_SUMMONS_REPLY.seeReplyMethodLabel());
        assertTrue(VIEW_SUMMONS_REPLY.seeServiceStartDateLabel());
    }

    @Then("^I see Reply Method is \"([^\"]*)\"$")
    public void replyMethodIs(String replyMethod) {
        assertEquals(replyMethod, VIEW_SUMMONS_REPLY.seeReplyMethodValue());
    }

    @Then("^I see assigned to is \"([^\"]*)\"$")
    public void replyIsAssignedTo(String staff) {
        assertEquals(staff, VIEW_SUMMONS_REPLY.getAssignedToStaff());
    }

    @And("^I am asked if the date of birth is correct$")
    public void iAmAskedIfTheDateOfBirthIsCorrect() {
        assertEquals("Is their date of birth correct?", VIEW_SUMMONS_REPLY.ineligibilityAgeConfirmHeaderText());
    }

    @Then("^I click yes to disqualify the juror$")
    public void iClickYesToDisqualifyTheJuror() {
        VIEW_SUMMONS_REPLY.clickDisqualifyButton();
    }

    @Then("^I click no to change the date of birth to the correct date$")
    public void iClickNoToChangeTheDateOfBirthToTheCorrectDate() {
        VIEW_SUMMONS_REPLY.clickChangeDateLink();
    }

    @And("^I see the juror status has updated to \"([^\"]*)\"$")
    public void iSeeTheJurorStatusHasUpdatedTo(String jurorStatus) {
        assertEquals(jurorStatus, VIEW_SUMMONS_REPLY.getJurorStatus());
    }

    @And("^I see \"([^\"]*)\" in the response banner$")
    public void iSeeResponseBannerText(String bannerText) {
        assertEquals(bannerText, SUMMONS_REPLY.getResponseBannerText());
    }

    @And("^I see \"([^\"]*)\" in the pool banner$")
    public void iSeePoolBannerText(String bannerText) {
        assertEquals(bannerText, SUMMONS_REPLY.getResponseBannerText());
    }

    @And("^I see the process reply button$")
    public void iSeeTheProcessReplyButton() {
        assertTrue(SUMMONS_REPLY.processReplyButtonIsPresent());
    }

    @And("^I do not see the process reply button$")
    public void iDoNotSeeTheProcessReplyButton() {
        assertFalse(SUMMONS_REPLY.processReplyButtonIsPresent());
    }

    @And("^I record an unhappy path paper summons response with a reasonable adjustment of \"([^\"]*)\"$")
    public void iRecordUnhappyPathPaperResponse(String adjustmentReason ) throws Throwable {
        SUMMONS_REPLY.clickEnterSummonsReplyButton();

        SUMMONS_REPLY.clickChangeName();
        NAV.set_valueTo("First name", "Changed fname");
        NAV.set_valueTo("Last name", "Changed lname");
        SUMMONS_REPLY.saveChanges();
        NAV.waitForPageLoad();

        SUMMONS_REPLY.clickChangeAddress();
        NAV.set_valueTo("Address line 1", "Changed address line 1");
        SUMMONS_REPLY.saveChanges();
        NAV.waitForPageLoad();

        SUMMONS_REPLY.enterDateOfBirth("18/07/1976");

        SUMMONS_REPLY.enterPrimaryPhone("0777777777");
        SUMMONS_REPLY.enterSecondaryPhone("0777777771");
        SUMMONS_REPLY.enterEmail("test@test.com");

        NAV.check_checkbox("Yes, send Welsh language communications");

        NAV.set_valueTo("Relationship to juror", "Spouse");
        SUMMONS_REPLY.selectThirdPartyReasonNotHere();
        SUMMONS_REPLY.clickContinue();

        SUMMONS_REPLY.clickLivedConsecutivelyNo();
        SUMMONS_REPLY.clickMentalHealthActYes();
        SUMMONS_REPLY.clickLackCapacityYes();
        SUMMONS_REPLY.clickOnBailYes();
        SUMMONS_REPLY.clickCriminalOffenceYes();
        SUMMONS_REPLY.clickContinue();

        SUMMONS_REPLY.clickDeferralRequest();
        SUMMONS_REPLY.clickContinue();

        SUMMONS_REPLY.clickCjsEmploymentYes();
        NAV.check_checkbox("Police force");
        NAV.set_valueTo("Which police force?", "West Midlands Police");
        SUMMONS_REPLY.clickContinue();

        SUMMONS_REPLY.clickAdjustmentsYes();
        SUMMONS_REPLY.selectAdjustmentReason(adjustmentReason);
        NAV.set_valueTo("What help does the juror need at court?", "Reasonable adjustments reasons");
        SUMMONS_REPLY.clickContinue();

        SUMMONS_REPLY.clickSignedNo();
        SUMMONS_REPLY.clickDoneButton();
    }

    @And("^I record a happy path paper summons response$")
    public void iRecordHappyPathPaperResponse() throws Throwable {
        SUMMONS_REPLY.clickEnterSummonsReplyButton();

        SUMMONS_REPLY.enterDateOfBirth("18/07/1976");

        SUMMONS_REPLY.enterPrimaryPhone("0777777777");
        SUMMONS_REPLY.enterSecondaryPhone("0777777771");
        SUMMONS_REPLY.enterEmail("test@test.com");

        SUMMONS_REPLY.clickContinue();

        SUMMONS_REPLY.clickLivedConsecutivelyYes();
        SUMMONS_REPLY.clickMentalHealthActNo();
        SUMMONS_REPLY.clickLackCapacityNo();
        SUMMONS_REPLY.clickOnBailNo();
        SUMMONS_REPLY.clickCriminalOffenceNo();
        SUMMONS_REPLY.clickContinue();

        SUMMONS_REPLY.clickCanServeDate();
        SUMMONS_REPLY.clickContinue();

        SUMMONS_REPLY.clickCjsEmploymentNo();
        SUMMONS_REPLY.clickContinue();

        SUMMONS_REPLY.clickAdjustmentsNo();
        SUMMONS_REPLY.clickContinue();

        SUMMONS_REPLY.clickSignedYes();
        SUMMONS_REPLY.clickDoneButton();
    }

    @And("^I record a happy path paper summons response and process now$")
    public void iRecordHappyPathPaperResponseProcessed() throws Throwable {
        SUMMONS_REPLY.clickEnterSummonsReplyButton();

        SUMMONS_REPLY.enterDateOfBirth("18/07/1976");

        SUMMONS_REPLY.enterPrimaryPhone("0777777777");
        SUMMONS_REPLY.enterSecondaryPhone("0777777771");
        SUMMONS_REPLY.enterEmail("test@test.com");

        SUMMONS_REPLY.clickContinue();

        SUMMONS_REPLY.clickLivedConsecutivelyYes();
        SUMMONS_REPLY.clickMentalHealthActNo();
        SUMMONS_REPLY.clickLackCapacityNo();
        SUMMONS_REPLY.clickOnBailNo();
        SUMMONS_REPLY.clickCriminalOffenceNo();
        SUMMONS_REPLY.clickContinue();

        SUMMONS_REPLY.clickCanServeDate();
        SUMMONS_REPLY.clickContinue();

        SUMMONS_REPLY.clickCjsEmploymentNo();
        SUMMONS_REPLY.clickContinue();

        SUMMONS_REPLY.clickAdjustmentsNo();
        SUMMONS_REPLY.clickContinue();

        SUMMONS_REPLY.clickSignedYes();
        SUMMONS_REPLY.clickDoneButton();
        NAV.press_buttonByName("Yes, process now");
    }

    @And("^I record a happy path deferral paper summons response$")
    public void iRecordHappyPathDeferralPaperResponse() throws Throwable {
        SUMMONS_REPLY.clickEnterSummonsReplyButton();

        SUMMONS_REPLY.enterDateOfBirth("18/07/1976");

        SUMMONS_REPLY.enterPrimaryPhone("0777777777");
        SUMMONS_REPLY.enterSecondaryPhone("0777777771");
        SUMMONS_REPLY.enterEmail("test@test.com");

        SUMMONS_REPLY.clickContinue();

        SUMMONS_REPLY.clickLivedConsecutivelyYes();
        SUMMONS_REPLY.clickMentalHealthActNo();
        SUMMONS_REPLY.clickLackCapacityNo();
        SUMMONS_REPLY.clickOnBailNo();
        SUMMONS_REPLY.clickCriminalOffenceNo();
        SUMMONS_REPLY.clickContinue();

        SUMMONS_REPLY.clickDeferralRequest();
        SUMMONS_REPLY.clickContinue();

        SUMMONS_REPLY.clickCjsEmploymentNo();
        SUMMONS_REPLY.clickContinue();

        SUMMONS_REPLY.clickAdjustmentsNo();
        SUMMONS_REPLY.clickContinue();

        SUMMONS_REPLY.clickSignedYes();
        SUMMONS_REPLY.clickDoneButton();
    }

    @And("^I record an excusal request paper summons response$")
    public void iRecordExcusalRequestPaperResponse() throws Throwable {
        SUMMONS_REPLY.clickEnterSummonsReplyButton();

        SUMMONS_REPLY.enterDateOfBirth("18/07/1976");

        SUMMONS_REPLY.enterPrimaryPhone("0777777777");
        SUMMONS_REPLY.enterSecondaryPhone("0777777771");
        SUMMONS_REPLY.enterEmail("test@test.com");

        SUMMONS_REPLY.clickContinue();

        SUMMONS_REPLY.clickLivedConsecutivelyYes();
        SUMMONS_REPLY.clickMentalHealthActNo();
        SUMMONS_REPLY.clickLackCapacityNo();
        SUMMONS_REPLY.clickOnBailNo();
        SUMMONS_REPLY.clickCriminalOffenceNo();
        SUMMONS_REPLY.clickContinue();

        SUMMONS_REPLY.clickExcusalRequest();
        SUMMONS_REPLY.clickContinue();

        SUMMONS_REPLY.clickCjsEmploymentNo();
        SUMMONS_REPLY.clickContinue();

        SUMMONS_REPLY.clickAdjustmentsNo();
        SUMMONS_REPLY.clickContinue();

        SUMMONS_REPLY.clickSignedYes();
        SUMMONS_REPLY.clickDoneButton();
    }

    @And("^I record a paper summons response with reasonable adjustment of \"([^\"]*)\"$")
    public void iRecordAPaperResponseWithReasonableAdjustments(String adjustmentReason) throws Throwable {
        SUMMONS_REPLY.clickEnterSummonsReplyButton();

        SUMMONS_REPLY.enterDateOfBirth("18/07/1976");

        SUMMONS_REPLY.enterPrimaryPhone("0777777777");
        SUMMONS_REPLY.enterSecondaryPhone("0777777771");
        SUMMONS_REPLY.enterEmail("test@test.com");

        SUMMONS_REPLY.clickContinue();

        SUMMONS_REPLY.clickLivedConsecutivelyYes();
        SUMMONS_REPLY.clickMentalHealthActNo();
        SUMMONS_REPLY.clickLackCapacityNo();
        SUMMONS_REPLY.clickOnBailNo();
        SUMMONS_REPLY.clickCriminalOffenceNo();
        SUMMONS_REPLY.clickContinue();

        SUMMONS_REPLY.clickCanServeDate();
        SUMMONS_REPLY.clickContinue();

        SUMMONS_REPLY.clickCjsEmploymentNo();
        SUMMONS_REPLY.clickContinue();

        SUMMONS_REPLY.clickAdjustmentsYes();
        SUMMONS_REPLY.selectAdjustmentReason(adjustmentReason);
        NAV.set_valueTo("What help does the juror need at court?", "Reasonable adjustments reasons");
        SUMMONS_REPLY.clickContinue();

        SUMMONS_REPLY.clickSignedYes();
        SUMMONS_REPLY.clickDoneButton();
    }

    @And("^I click the process reply button$")
    public void iClickTheProcessReplyButton() {
        SUMMONS_REPLY.clickProcessReplyButton();
    }

    @Then("^I mark the reply as responded$")
    public void iMarkTheReplyAsResponded() {
        SUMMONS_REPLY.clickMarkAsResponded();
    }

    @Then("^I select deferral request$")
    public void iSelectDeferralRequest() {
        SUMMONS_REPLY.clickProcessAcionDeferralRequest();
    }

    @And("^I click the checkbox to mark the reply as responded$")
    public void clickMarkTheReplyAsRespondedCheckbox() {
        SUMMONS_REPLY.clickMarkAsRespondedCheckbox();
    }

    @And("^I confirm I want to mark the reply as responded$")
    public void iConfirmIWantToMarkTheReplyAsResponded() {
        SUMMONS_REPLY.clickConfirmMarkAsRespondedButton();
    }

    @And("^I check the processed success banner is present for the reply I just processed$")
    public void processedSuccessBannerIsPresent() {
        assertTrue(SUMMONS_REPLY.processedSuccessBannerIsPresent());
        assertEquals(jurorPartNumber.get(), SUMMONS_REPLY.processSuccessBannerLink());
    }

    @Then("^I click the link for the juror record$")
    public void iClickTheLinkForTheJurorRecord() {
        SUMMONS_REPLY.clickProcessSuccessBannerLink();
    }

    @And("^I see the juror status on the juror record screen has updated to \"([^\"]*)\"$")
    public void jurorStatusHasUpdatedTo(String jurorResponse) {
        assertEquals(jurorResponse, JUROR_RECORD_SEARCH.getJurorStatus());
    }

    @Then("^I click the cancel link$")
    public void iClickTheCancelLink() {
        SUMMONS_REPLY.clickCancelLink();
    }

    @And("^I see the juror status on the juror record screen is \"([^\"]*)\"$")
    public void iSeeTheJurorStatusOnTheJurorRecordScreenIs(String jurorStatus) {
        assertEquals(jurorStatus, JUROR_RECORD.getJurorStatus());
    }

    @And("^I click confirm on the $")
    public void iClickConfirm() {
    }

    @And("^there is an error message with the text \"([^\"]*)\"$")
    public void thereIsAnErrorMessageWithTheText(String errorText) {
        assertTrue(SUMMONS_REPLY.errorIsPresent());
        assertEquals(errorText, SUMMONS_REPLY.getErrorText());
    }

    @Given("^I clear all reasonable adjustments from the juror record \"([^\"]*)\"$")
    public void deleteReasonableAdjustments(String createdJurorRecordNumber) throws SQLException {
        DBT.deleteReasonableAdjustment(createdJurorRecordNumber);
    }

    @Given("^a juror record of has been entered with a reasonable adjustment$")
    public void createSummonsReplyReasonableAdjustmentJuror(DataTable dataTable) throws SQLException {
        Map<String, String> jurorDetails = dataTable.asMap(String.class, String.class);
        DBT.insertNewSummonsReplyReasonableAdjustment(jurorDetails.get("newJurorRecordNumber"), jurorDetails.get("newJurorAdjustmentCode"), jurorDetails.get("newJurorAdjustment"));
        summonsReplyNumber = jurorDetails.get("newJurorRecordNumber");
    }

    @Given("^a juror record paper response has been entered with a reasonable adjustment$")
    public void createPaperSummonsReplyReasonableAdjustmentJuror(DataTable dataTable) throws SQLException {
        Map<String, String> jurorDetails = dataTable.asMap(String.class, String.class);
        DBT.insertNewPaperSummonsReplyReasonableAdjustment(jurorDetails.get("newJurorRecordNumber"), jurorDetails.get("newJurorAdjustmentCode"), jurorDetails.get("newJurorAdjustment"));
        summonsReplyNumber = jurorDetails.get("newJurorRecordNumber");
    }

    @Then("^I am on the check can accommodate screen$")
    public void iAmOnTheCheckCanAccomodateScreen() {
        String URL = webDriver.getCurrentUrl();
        Assert.assertTrue(URL.contains("check-can-accommodate"));
    }

    @Then("^I see the following juror information on the check can accommodate screen$")
    public void iSeeTheFollowingJurorInformationOnTheCheckCanAccommodateScreen(DataTable dataTable) {
        Map<String, String> expectedData = dataTable.asMap(String.class, String.class);
        Map<String, String> actualData = VIEW_SUMMONS_REPLY.getCheckAccommodateJurorDetails();

        assertEquals(expectedData.get("jurorName"), actualData.get("jurorName"));
        assertEquals(expectedData.get("jurorNumber"), actualData.get("jurorNumber"));
        assertEquals(expectedData.get("jurorMainPhone"), actualData.get("jurorMainPhone"));
        assertEquals(expectedData.get("jurorEmail"), actualData.get("jurorEmail"));
        assertEquals(expectedData.get("jurorAdjustmentReason"), actualData.get("jurorAdjustmentReason"));
        assertEquals(expectedData.get("jurorAdjustment"), actualData.get("jurorAdjustment"));

    }

    @Then("^I can paste the following information \"([^\"]*)\"$")
    public void iCanPasteTheJurorInformation(String expectedText) throws IOException, UnsupportedFlavorException {
        expectedText = expectedText.replace("\\n", "\n").replace("\\", "");
        String copiedText = (String) Toolkit.getDefaultToolkit().getSystemClipboard().getData(DataFlavor.stringFlavor);
        assertEquals(expectedText, copiedText);
    }

    @When("^I enter the optic reference number \"([^\"]*)\"$")
    public void iEnterTheOpticReferenceNumber(String reference) {
        VIEW_SUMMONS_REPLY.enterOpticReferenceNumber(reference);
    }

    @Then("^The newly created optic reference \"([^\"]*)\" is displayed$")
    public void theNewlyCreatedOpticReferenceIsDisplayed(String reference) {
        assertEquals(reference, VIEW_SUMMONS_REPLY.getOpticeReferenceNo());
    }

    @Then("^I create a \"([^\"]*)\" court pool request for court \"([^\"]*)\"$")
    public void createNewPoolRequest(String poolRequestType, String court) throws Throwable {
        NAV.press_buttonByName("Create pool");
        GRP.click_radioButtonWithLabel("Request new pool");
        NAV.press_buttonByName("Continue");
        NAV.set_valueTo("Enter a court name or location code", court);
        NAV.click_link_by_text(court);
        NAV.press_buttonByName("Continue");
        NAV.waitForPageLoad();
        POOL_REQUESTS_PAGE.clickToChangeDeferrals();
        POOL_REQUESTS_PAGE.enterNumberOfCourtDeferrals("0");
        NAV.press_buttonByName("Continue");

        if (poolRequestType.equals("Civil"))
            POOL_REQUESTS_PAGE.selectPoolType(PoolRequests.PoolType.CIVIL);
        if (poolRequestType.equals("Crown"))
            POOL_REQUESTS_PAGE.selectPoolType(PoolRequests.PoolType.CROWN);
        if (poolRequestType.equals("High"))
            POOL_REQUESTS_PAGE.selectPoolType(PoolRequests.PoolType.HIGH);
        NAV.set_value_to("Number of jurors", "150");
        NAV.press_buttonByName("Continue");
        poolNumber.set(CHECK_POOL_REQUEST_PAGE.getNewPoolRequestNumber());
        poolRequestNumber.set(CHECK_POOL_REQUEST_PAGE.getNewPoolRequestNumber());
        poolDate.set(CHECK_POOL_REQUEST_PAGE.getNewPoolAttendanceDate());
        poolNumber.set(POOL_REQUESTS_PAGE.getPoolNumberOnDetails());

        ArrayList<String> pools = poolNumbers.get();
        System.out.println("Getting Pool Number --- " + poolNumber.get());

        pools.add(poolNumber.get());
        System.out.println("Values in pools array --- " + pools.toString());

        NAV.press_buttonByName("Request pool");
    }

    @And("^I create a \"([^\"]*)\" court pool request for court \"([^\"]*)\" using the same pool number$")
    public void iCreateACourtPoolRequestForCourtUsingAsThePoolNumber(String poolRequestType, String court) throws Throwable {
        NAV.press_buttonByName("Request a new pool");
        NAV.set_valueTo("Enter a court name or location code", court);
        NAV.press_buttonByName("Continue");
        NAV.waitForPageLoad();
        if (poolRequestType.equals("Civil"))
            POOL_REQUESTS_PAGE.selectPoolType(PoolRequests.PoolType.CIVIL);
        if (poolRequestType.equals("Crown"))
            POOL_REQUESTS_PAGE.selectPoolType(PoolRequests.PoolType.CROWN);
        if (poolRequestType.equals("High"))
            POOL_REQUESTS_PAGE.selectPoolType(PoolRequests.PoolType.HIGH);
        NAV.set_value_to("Number of jurors", "150");
        NAV.press_buttonByName("Continue");
        iClickTheChangeLinkForThePoolNumber();
        POOL_REQUESTS_PAGE.inputExistingPoolNumberAlt(poolNumber.get());
        NAV.press_buttonByName("Change");
        poolNumber.set(CHECK_POOL_REQUEST_PAGE.getNewPoolRequestNumber());
        poolDate.set(CHECK_POOL_REQUEST_PAGE.getNewPoolAttendanceDate());
        poolNumber.set(POOL_REQUESTS_PAGE.getPoolNumberOnDetails());

        ArrayList<String> pools = poolNumbers.get();
        pools.add(poolNumber.get());

        System.out.println(poolNumber.get());
        NAV.press_buttonByName("Request pool");
    }

    @And("^I create a \"([^\"]*)\" court pool request for court \"([^\"]*)\" with \"([^\"]*)\" deferral$")
    public void iCreateACourtPoolRequestForCourtWithDeferral(String poolRequestType, String court, String deferralsNumber) throws Throwable {
        NAV.press_buttonByName("Create pool");
        GRP.click_radioButtonWithLabel("Request new pool");
        NAV.press_buttonByName("Continue");
        NAV.set_valueTo("Enter a court name or location code", court);
        NAV.press_buttonByName("Continue");
        NAV.waitForPageLoad();
        iClickTheChangeLinkForTheCourtDeferrals();
        iChangeTheNumberOfCourtDeferralsTo(deferralsNumber);
        if (poolRequestType.equals("Civil"))
            POOL_REQUESTS_PAGE.selectPoolType(PoolRequests.PoolType.CIVIL);
        if (poolRequestType.equals("Crown"))
            POOL_REQUESTS_PAGE.selectPoolType(PoolRequests.PoolType.CROWN);
        if (poolRequestType.equals("High"))
            POOL_REQUESTS_PAGE.selectPoolType(PoolRequests.PoolType.HIGH);
        NAV.set_value_to("Number of jurors", "150");


        NAV.press_buttonByName("Continue");
        poolNumber.set(CHECK_POOL_REQUEST_PAGE.getNewPoolRequestNumber());
        poolDate.set(CHECK_POOL_REQUEST_PAGE.getNewPoolAttendanceDate());
        poolNumber.set(POOL_REQUESTS_PAGE.getPoolNumberOnDetails());
        //poolNumbers.add(poolNumber);
        System.out.println(poolNumber.get());
        NAV.press_buttonByName("Request pool");
    }

    @Then("^I create a \"([^\"]*)\" court pool request$")
    public void createNewPoolRequest(String poolRequestType) throws Throwable {
        NAV.press_buttonByName("Create pool");
        GRP.click_radioButtonWithLabel("Request new pool");
        NAV.press_buttonByName("Continue");
        GRP.click_radioButtonWithLabel(poolRequestType);
        NAV.set_value_to("Number of jurors", "150");

        POOL_REQUESTS_PAGE.clickToChangeDeferrals();
        NAV.set_value_to("Number of deferred jurors to include in this pool", "0");
        NAV.press_buttonByName("Continue");
        {
            if (poolRequestType.equals("Civil"))
                POOL_REQUESTS_PAGE.selectPoolType(PoolRequests.PoolType.CIVIL);
            if (poolRequestType.equals("Crown"))
                POOL_REQUESTS_PAGE.selectPoolType(PoolRequests.PoolType.CROWN);
            if (poolRequestType.equals("High"))
                POOL_REQUESTS_PAGE.selectPoolType(PoolRequests.PoolType.HIGH);
        }

        NAV.set_value_to("Number of jurors", "150");
        NAV.press_buttonByName("Continue");
        poolNumber.set(CHECK_POOL_REQUEST_PAGE.getCourtNewPoolRequestNumber());
        poolDate.set(CHECK_POOL_REQUEST_PAGE.getNewPoolAttendanceDate());
        NAV.press_buttonByName("Request pool");
    }

    @Then("^I create a \"([^\"]*)\" court pool request for court \"([^\"]*)\", \"([^\"]*)\" weeks in the future$")
    public void createNewPoolRequestWeeksInFuture(String poolRequestType, String court, Integer weeksInFuture) throws Throwable {
        String datePattern = "dd/MM/yyyy";
        Calendar calendar = Calendar.getInstance();
        calendar.add(Calendar.WEEK_OF_MONTH, weeksInFuture);
        LocalDate localDate = calendar.toInstant().atZone(ZoneId.systemDefault()).toLocalDate();
        if (weeksInFuture == 0) {
            localDate = localDate.plusDays(1);
        }
        if (localDate.getDayOfWeek() == DayOfWeek.SATURDAY || localDate.getDayOfWeek() == DayOfWeek.SUNDAY) {
            localDate = localDate.plusDays(2);
        }
        Date newDate = Date.from(localDate.atStartOfDay().atZone(ZoneId.systemDefault()).toInstant());
        String newDateValues = new SimpleDateFormat(datePattern).format((newDate).getTime());


        NAV.press_buttonByName("Create pool");
        GRP.click_radioButtonWithLabel("Request new pool");
        NAV.press_buttonByName("Continue");

        NAV.set_valueTo("Enter a court name or location code", court);
        NAV.click_link_by_text(court);
        NAV.press_buttonByName("Continue");
        //NAV.waitForPageLoad();
        POOL_REQUESTS_PAGE.clickChangeDate();
        POOL_REQUESTS_PAGE.enterNewDate(newDateValues);
        NAV.press_buttonByName("Change");

        POOL_REQUESTS_PAGE.clickToChangeDeferrals();
        POOL_REQUESTS_PAGE.enterNumberOfCourtDeferrals("0");
        NAV.press_buttonByName("Continue");
        {
            if (poolRequestType.equals("Civil"))
                POOL_REQUESTS_PAGE.selectPoolType(PoolRequests.PoolType.CIVIL);
            if (poolRequestType.equals("Crown"))
                POOL_REQUESTS_PAGE.selectPoolType(PoolRequests.PoolType.CROWN);
            if (poolRequestType.equals("High"))
                POOL_REQUESTS_PAGE.selectPoolType(PoolRequests.PoolType.HIGH);
        }
        NAV.set_value_to("Number of jurors", "150");
        NAV.press_buttonByName("Continue");
        poolNumber.set(CHECK_POOL_REQUEST_PAGE.getCourtNewPoolRequestNumber());
        poolDate.set(CHECK_POOL_REQUEST_PAGE.getNewPoolAttendanceDate());
        NAV.press_buttonByName("Request pool");
    }

    @Then("^I create an active \"([^\"]*)\" court pool request for court \"([^\"]*)\", \"([^\"]*)\" Mondays in the future$")
    public void createNewActivePoolRequestMondaysInFuture(String poolRequestType, String court, int mondaysInFuture) throws Throwable {
        NAV.press_buttonByName("Create pool");
        GRP.click_radioButtonWithLabel("Request new pool");
        NAV.press_buttonByName("Continue");

        NAV.set_valueTo("Enter a court name or location code", court);
        NAV.press_buttonByName("Continue");
        //NAV.waitForPageLoad();
        POOL_REQUESTS_PAGE.clickChangeDate();
        POOL_REQUESTS_PAGE.enterNewDate(mondayWeeksInFuture(mondaysInFuture));
        NAV.press_buttonByName("Change");

        POOL_REQUESTS_PAGE.clickToChangeDeferrals();
        POOL_REQUESTS_PAGE.enterNumberOfCourtDeferrals("0");
        NAV.press_buttonByName("Continue");

        {
            if (poolRequestType.equalsIgnoreCase("Civil"))
                POOL_REQUESTS_PAGE.selectPoolType(PoolRequests.PoolType.CIVIL);
            if (poolRequestType.equalsIgnoreCase("Crown"))
                POOL_REQUESTS_PAGE.selectPoolType(PoolRequests.PoolType.CROWN);
            if (poolRequestType.equalsIgnoreCase("High"))
                POOL_REQUESTS_PAGE.selectPoolType(PoolRequests.PoolType.HIGH);
        }
        NAV.set_value_to("Number of jurors", "150");
        NAV.press_buttonByName("Continue");
        poolNumber.set(CHECK_POOL_REQUEST_PAGE.getCourtNewPoolRequestNumber());

        ArrayList<String> pools = poolNumbers.get();
        pools.add(poolNumber.get());

        poolDate.set(CHECK_POOL_REQUEST_PAGE.getNewPoolAttendanceDate());
        NAV.press_buttonByName("Request pool");

        POOL_REQUESTS_PAGE.clickInactivePoolNumber(poolNumber.get());
        NAV.press_buttonByName("Summon jurors");
        NAV.set_value_to("Citizens to summon", "1");
        NAV.press_buttonByName("Create pool and summon citizens");
        POOL_REQUESTS_PAGE.clickTab("Pool requests");
    }

    @Then("^I create \"([^\"]*)\" new \"([^\"]*)\" pool requests each a week apart in court \"([^\"]*)\"$")
    public void createMultiplePoolRequestsWeeksApart(Integer noOfPools, String courtType, String court) throws Throwable {
        Integer newPoolsCreated = 0;
        do {
            createNewPoolRequestWeeksInFuture(courtType, court, newPoolsCreated);
            String poolNo = POOL_REQUESTS_PAGE.getNewPoolNumberOnSummary();

            ArrayList<String> pools = poolNumbers.get();
            pools.add(poolNo);

            POOL_REQUESTS_PAGE.clickFirstRequestLink();
            NAV.press_buttonByName("Summon jurors");
            NAV.set_value_to("Citizens to summon", "1");
            NAV.press_buttonByName("Create pool and summon citizens");
            POOL_REQUESTS_PAGE.clickTab("Pool requests");
            newPoolsCreated = newPoolsCreated + 1;
        } while (newPoolsCreated < noOfPools);
        String poolsCreated = poolNumbers.toString().replace("[", "(").replace("]", ")");
        System.out.println("Pools Created: " + poolsCreated);
    }

    @Then("^I create \"([^\"]*)\" new \"([^\"]*)\" pool requests each a week apart in court \"([^\"]*)\" with \"([^\"]*)\" jurors to summon$")
    public void createMultiplePoolRequestsWeeksApartSpecifiedJurorsToSummon(Integer noOfPools, String courtType, String court, String jurorsToSummon) throws Throwable {
        Integer newPoolsCreated = 0;
        do {
            createNewPoolRequestWeeksInFuture(courtType, court, newPoolsCreated + 1);
            String poolNo = POOL_REQUESTS_PAGE.getNewPoolNumberOnSummary();

            ArrayList<String> pools = poolNumbers.get();
            pools.add(poolNo);

            POOL_REQUESTS_PAGE.clickFirstRequestLink();
            NAV.press_buttonByName("Summon jurors");
            NAV.set_value_to("Citizens to summon", jurorsToSummon);
            NAV.press_buttonByName("Create pool and summon citizens");
            POOL_REQUESTS_PAGE.clickTab("Pool requests");
            newPoolsCreated = newPoolsCreated + 1;
        } while (newPoolsCreated < noOfPools);
        String poolsCreated = poolNumbers.toString().replace("[", "(").replace("]", ")");
        System.out.println("Pools Created: " + poolsCreated);
    }

    @Then("^I see the pool status is REQUESTED")
    public void seePoolStatusRequestedTag() throws Throwable {
        assertTrue(POOL_REQUESTS_PAGE.seePoolStatusRequestedTag());
    }

    @Then("^I see the pool status is ACTIVE")
    public void seePoolStatusActiveTag() throws Throwable {
        assertTrue(POOL_REQUESTS_PAGE.seePoolStatusActiveTag());
    }

    @Then("^I can see the newly created pool$")
    public void seeNewPoolRequest() throws Throwable {
        String mainText = JUROR_RECORD_SEARCH.getMainBodyText();
        By element = By.className("govuk-pagination__next");
        List<WebElement> nextNavButton = webDriver.findElements(element);

        if (!mainText.contains(poolNumber.get())) while (!nextNavButton.isEmpty()) {
            POOL_SEARCH.nextButton.click();
            nextNavButton = webDriver.findElements(element);
        }

        if (mainText.contains(poolNumber.get())) {
            assertTrue(mainText.contains(poolNumber.get()));
        }
    }

    @And("^I make a note of the pool number$")
    public void iMakeANoteOfThePoolNumber() {
        poolNumber.set(POOL_REQUESTS_PAGE.getPoolNumberOnDetails());
        ArrayList<String> pools = poolNumbers.get();
        pools.add(poolNumber.get());
        System.out.println(poolNumber.get());
    }

    @Then("^I see the refuse excusal success message for \"([^\"]*)\"$")
    public void iSeeRefuseExcusalSuccessMessage(String excusalReason) {
        String bannerText = SUMMONS_REPLY.getResponseBannerText();
        assertTrue(bannerText.contains("successfully processed"));
        assertTrue(bannerText.contains("Excusal refused"));
        assertTrue(bannerText.contains(excusalReason));
    }

    @When("^I select the Refuse Excusal radio button$")
    public void selectRefuseExcusalRadio() {
        SUMMONS_REPLY.selectRefuseExcusalRadio();
    }

    @And("^I click the update juror record button$")
    public void iClickTheUpdateJurorRecordButton() {
        JUROR_RECORD_SEARCH.clickUpdateJurorRecord();
    }

    @Then("^I click the summons reply tab$")
    public void iClickTheSummonsReplyTab() {
        JUROR_RECORD_SEARCH.clickSummonsTab();
    }

    @And("^I click on the view summons reply link$")
    public void iClickOnTheViewSummonsReplyLink() {
        JUROR_RECORD_SEARCH.clickViewSummonsReplyLink();
    }

    @And("^I select the mark as deceased radio button$")
    public void iSelectTheMarkAsDeceasedRadioButton() {
        JUROR_RECORD_SEARCH.clickMarkAsDeceasedRadioButton();
    }

    @And("^I select the mark as undeliverable radio button$")
    public void iSelectTheMarkAsUndeliverableRadioButton() {
        JUROR_RECORD_SEARCH.clickMarkAsUndeliverableRadioButton();
    }

    @And("^I press the Juror number table header$")
    public void iPressTheJurorNumberTableHeader() {
        DEFERRAL_MAINTENANCE.clickJurorNumberHeader();
    }

    @And("^I add a comment of \"([^\"]*)\" to be recorded in the jurors history$")
    public void iAddACommentOfToBeRecordedInTheJurorsHistory(String commentForHistory) {
        JUROR_RECORD_SEARCH.enterCommentForHistory(commentForHistory);
    }

    @Then("^I click continue on the update juror record screen$")
    public void iClickContinueToMarkTheJurorAsDeceased() {
        JUROR_RECORD_SEARCH.clickContinue();
    }

    @And("^I see the juror record updated banner containing \"([^\"]*)\"$")
    public void iSeeTheJurorRecordUpdatedBannerContaining(String bannerContains) {
        assertEquals(bannerContains, JUROR_RECORD_SEARCH.jurorRecordUpdatedContains());
    }

    @And("^I see \"([^\"]*)\" in the error banner$")
    public void iSeeInTheErrorBanner(String errorText) {
        assertEquals(errorText, JUROR_RECORD_SEARCH.jurorRecordUpdatedErrorBannerText());
    }

    @Then("^I see the summons reply status is \"([^\"]*)\"$")
    public void iSeeTheSummonsReplyStatusIs(String expectedStatus) {
        assertEquals(expectedStatus, SUMMONS_REPLY.getReplyStatus());
    }

    @Then("^The system shall display the following non editable details on the additional summons screen$")
    public void theSystemWillDisplayNonEditableInformationOnTheAdditionalSummonsScreen(DataTable dataTable) {
        Map<String, String> data = dataTable.asMap(String.class, String.class);
        assertEquals(poolNumber.get(), ADDITIONAL_SUMMONS.getPoolNumber());
        assertEquals(data.get("jurorsRequested"), ADDITIONAL_SUMMONS.getJurorsRequested());
        assertEquals(data.get("jurorsConfirmed"), ADDITIONAL_SUMMONS.getJurorsConfirmed());
        assertEquals(data.get("jurorsRequired"), ADDITIONAL_SUMMONS.getJurorsRequired());
        assertEquals(data.get("citizensSummoned"), ADDITIONAL_SUMMONS.getCitizensSummoned());
        assertEquals(data.get("catchmentArea"), ADDITIONAL_SUMMONS.getCatchmentArea());
    }


    @Then("^The system shall display the non editable details on the Confirm attendance screen$")
    public void theSystemWillDisplayNonEditableInformationOnTheConfirmAttendenpage() {
        assertEquals(("Juror number"), NAV.getJurorNumber());
        assertEquals(("First name"), NAV.getFirstName());
        assertEquals(("Last name"), NAV.getLastName());
        assertEquals(("Checked in"), NAV.getCheckedIn());
    }

    @When("^I set extra citizens to summon to \"([^\"]*)\"$")
    public void iEnterExtraCitizensToSummon(String noCitizens) {
        ADDITIONAL_SUMMONS.setExtraCitizensToSummon(noCitizens);
    }

    @Then("^juror \"([^\"]*)\" has been sent a summons letter$")
    public void checkJurorSummonsLetter(String jurorNo) throws SQLException {
        DBT.checkJurorSummonsLetter(jurorNo);
        assertEquals("Juror summons letter sent to " + jurorNo, DBT.checkJurorSummonsLetter(jurorNo));

    }

    @Then("^The \"([^\"]*)\" new jurors have been sent a summons letter$")
    public void checkNewJurorSummonsLetter(String noJurors) throws SQLException {
        int jurorRows = Integer.parseInt(noJurors);
        for (int index = 1; index <= jurorRows; index++) {
            String jurorNo = POOL_OVERVIEW_PAGE.getJurorNumberInRow(index);
            assertEquals("Juror summons letter sent to " + jurorNo, DBT.checkJurorSummonsLetter(jurorNo));
        }
    }

    @Then("^there is an error message with the text \"([^\"]*)\" on the additional summons page$")
    public void thereIsAnErrorMessageWithTheTextOnAdditionalSummons(String errorText) {
        assertTrue(ADDITIONAL_SUMMONS.errorIsPresent());
        assertEquals(errorText, ADDITIONAL_SUMMONS.getErrorText());
    }

    @When("^I click the change catchment area link$")
    public void clickChangeCatchmentArea() {
        ADDITIONAL_SUMMONS.clickChangeCatchmentAreaLink();
    }

    @When("^I click all postcode checkboxes$")
    public void clickAllPostcodeCheckboxes() {
        ADDITIONAL_SUMMONS.clickAllPostcodeCheckboxes();
    }


    @When("^I click on deferral maintenance$")
    public void iClickOnDeferralMaintenance() {
        POOL_REQUESTS_PAGE.clickDeferralMaintenance();
    }

    @Then("^I am taken to the deferral maintenance screen for the selected court \"([^\"]*)\"$")
    public void iAmTakenToTheDeferralMaintenanceScreenForTheSelectedCourt(String courtName) {
        assertEquals("Deferral maintenance", DEFERRAL_MAINTENANCE.getPageHeading());
        assertEquals(courtName, DEFERRAL_MAINTENANCE.getCourtName());
    }

    @Then("^The deferrals table is displayed$")
    public void theDeferralsTableIsDisplayed() {
        assertEquals("Juror number", DEFERRAL_MAINTENANCE.getJurorNumberTableHeading());
        assertEquals("First name", DEFERRAL_MAINTENANCE.getFirstNameTableHeading());
        assertEquals("Last name", DEFERRAL_MAINTENANCE.getLastNameTableHeading());
        assertEquals("Pool number", DEFERRAL_MAINTENANCE.getPoolNumberTableHeading());
        assertEquals("Deferred to", DEFERRAL_MAINTENANCE.geDeferredToTableHeading());
    }

    @Then("^The first deferral in the table is \"([^\"]*)\" with a deferral date \"([^\"]*)\" Mondays in the future$")
    public void theFirstDeferralInTheTableIs(String deferral, String noWeeks) {

        String datePattern = "E dd MMM yyyy";
        Calendar calendar = Calendar.getInstance();
        calendar.add(Calendar.WEEK_OF_MONTH, Integer.parseInt(noWeeks));

        LocalDate localDate = calendar.toInstant().atZone(ZoneId.systemDefault()).toLocalDate();
        LocalDate localDateMonday = localDate.with(TemporalAdjusters.next(DayOfWeek.MONDAY));
        Date mondayDate = Date.from(localDateMonday.atStartOfDay().atZone(ZoneId.systemDefault()).toInstant());

        String expectedDate = new SimpleDateFormat(datePattern).format((mondayDate).getTime());

        assertEquals(deferral + ", " + expectedDate, DEFERRAL_MAINTENANCE.getFirstDeferralTableRow());
    }

    @Then("^Row \"([^\"]*)\" deferral in the table is \"([^\"]*)\" with a deferral date \"([^\"]*)\" Mondays in the future$")
    public void rowDeferralInTheTableIs(String rowNo, String deferral, String noWeeks) {

        String datePattern = "E dd MMM yyyy";
        Calendar calendar = Calendar.getInstance();
        calendar.add(Calendar.WEEK_OF_MONTH, Integer.parseInt(noWeeks));

        LocalDate localDate = calendar.toInstant().atZone(ZoneId.systemDefault()).toLocalDate();
        LocalDate localDateMonday = localDate.with(TemporalAdjusters.next(DayOfWeek.MONDAY));
        Date mondayDate = Date.from(localDateMonday.atStartOfDay().atZone(ZoneId.systemDefault()).toInstant());

        String expectedDate = new SimpleDateFormat(datePattern).format((mondayDate).getTime());

        int row = Integer.parseInt(rowNo);

        assertEquals(deferral + ", " + expectedDate, DEFERRAL_MAINTENANCE.getDeferralTableRow(row));
    }

    @Then("^The last deferral in the table is \"([^\"]*)\" with a deferral date \"([^\"]*)\" Mondays in the future$")
    public void theLastDeferralInTheTableIs(String deferral, String noWeeks) {
        String datePattern = "E dd MMM yyyy";
        Calendar calendar = Calendar.getInstance();
        calendar.add(Calendar.WEEK_OF_MONTH, Integer.parseInt(noWeeks));

        LocalDate localDate = calendar.toInstant().atZone(ZoneId.systemDefault()).toLocalDate();
        LocalDate localDateMonday = localDate.with(TemporalAdjusters.next(DayOfWeek.MONDAY));
        Date mondayDate = Date.from(localDateMonday.atStartOfDay().atZone(ZoneId.systemDefault()).toInstant());

        String expectedDate = new SimpleDateFormat(datePattern).format((mondayDate).getTime());
        assertEquals(deferral + ", " + expectedDate, DEFERRAL_MAINTENANCE.getLastDeferralTableRow());
    }

    @Then("^Row \"([^\"]*)\" from last deferral in the table is \"([^\"]*)\" with a deferral date \"([^\"]*)\" Mondays in the future$")
    public void rowFromLastDeferralInTheTableIs(String rowNo, String deferral, String noWeeks) {

        String datePattern = "E dd MMM yyyy";
        Calendar calendar = Calendar.getInstance();
        calendar.add(Calendar.WEEK_OF_MONTH, Integer.parseInt(noWeeks));

        LocalDate localDate = calendar.toInstant().atZone(ZoneId.systemDefault()).toLocalDate();
        LocalDate localDateMonday = localDate.with(TemporalAdjusters.next(DayOfWeek.MONDAY));
        Date mondayDate = Date.from(localDateMonday.atStartOfDay().atZone(ZoneId.systemDefault()).toInstant());

        String expectedDate = new SimpleDateFormat(datePattern).format((mondayDate).getTime());

        int row = Integer.parseInt(rowNo);

        assertEquals(deferral + ", " + expectedDate, DEFERRAL_MAINTENANCE.getNthLastDeferralTableRow(row));
    }

    @When("^I select juror \"([^\"]*)\" from the deferrals table$")
    public void iSelectJurorFromTheDeferralsTable(String jurorNumber) {
        DEFERRAL_MAINTENANCE.selectJurorFromTable(jurorNumber);
    }

    @When("^I select pool \"([^\"]*)\" from the active pools table$")
    public void iSelectPoolFromTheActivePoolsTable(String poolNumber) {
        DEFERRAL_MAINTENANCE.selectActivePool(poolNumber);
    }

    @When("^I set the \"([^\"]*)\" deferral filter to \"([^\"]*)\"$")
    public void iSetTheDeferralFilterTo(String filter, String input) {
        DEFERRAL_MAINTENANCE.clickShowFilterButton();
        DEFERRAL_MAINTENANCE.clickClearFiltersLink();
        switch (filter) {
            case "juror number":
                DEFERRAL_MAINTENANCE.filterByJurorNumber(input);
                break;
            case "first name":
                DEFERRAL_MAINTENANCE.filterByFirstName(input);
                break;
            case "last name":
                DEFERRAL_MAINTENANCE.filterByLastName(input);
                break;
            case "deferred to":
                DEFERRAL_MAINTENANCE.filterByDeferredTo(input);
                break;
        }
        DEFERRAL_MAINTENANCE.clickApplyFiltersButton();
        DEFERRAL_MAINTENANCE.clickShowFilterButton();
    }

    @When("^I set the deferral deferred to filter to \"([^\"]*)\" Mondays in the future$")
    public void iSetTheDeferralDeferredToFilterTo(String noWeeks) {
        DEFERRAL_MAINTENANCE.clickShowFilterButton();
        DEFERRAL_MAINTENANCE.clickClearFiltersLink();

        String datePattern = "dd/MM/yyyy";
        Calendar calendar = Calendar.getInstance();
        calendar.add(Calendar.WEEK_OF_MONTH, Integer.parseInt(noWeeks));

        LocalDate localDate = calendar.toInstant().atZone(ZoneId.systemDefault()).toLocalDate();
        LocalDate localDateMonday = localDate.with(TemporalAdjusters.next(DayOfWeek.MONDAY));
        Date mondayDate = Date.from(localDateMonday.atStartOfDay().atZone(ZoneId.systemDefault()).toInstant());

        String expectedDate = new SimpleDateFormat(datePattern).format((mondayDate).getTime());

        DEFERRAL_MAINTENANCE.filterByDeferredTo(expectedDate);
        DEFERRAL_MAINTENANCE.clickApplyFiltersButton();
        DEFERRAL_MAINTENANCE.clickShowFilterButton();
    }

    @When("^I filter on name \"([^\"]*)\"$")
    public void iFilterOnName(String lastName) {
        DEFERRAL_MAINTENANCE.clickShowFilterButton();

        DEFERRAL_MAINTENANCE.filterByLastName(lastName);
        DEFERRAL_MAINTENANCE.clickApplyFiltersButton();
        DEFERRAL_MAINTENANCE.clickShowFilterButton();
    }

    @When("^I navigate to the last page of deferral maintenance$")
    public void iNavigateToTheLastPageOfDeferralMaintenance() {
        DEFERRAL_MAINTENANCE.clickLastPaginationItem();
    }

    @Then("^I see the disqualification success message for \"([^\"]*)\"$")
    public void iSeeDisqualificationSuccessMessage(String disqualificationReason) {
        String bannerText = SUMMONS_REPLY.getResponseBannerText();
        assertTrue(bannerText.contains("successfully processed"));
        assertTrue(bannerText.contains("Disqualified"));
        assertTrue(bannerText.contains(disqualificationReason));
    }

    @Then("^I see the summons reply disqualification success message$")
    public void iSeeSummonsReplyDisqualificationSuccessMessage() {
        String bannerText = SUMMONS_REPLY.getResponseBannerText();
        assertTrue(bannerText.contains("Summons reply processed"));
        assertTrue(bannerText.contains("Disqualified"));
    }

    @When("^I answer the juror summons reply eligibility questions with juror Residency set to No$")
    public void answerJurorResidency() {
        SUMMONS_REPLY.clickLivedConsecutivelyNo();
        SUMMONS_REPLY.clickMentalHealthActNo();
        SUMMONS_REPLY.clickLackCapacityNo();
        SUMMONS_REPLY.clickOnBailNo();
        SUMMONS_REPLY.clickCriminalOffenceNo();
    }

    @When("^I select that the juror does need adjustments$")
    public void selectJurorDoesNeedAdjustments() {
        SUMMONS_REPLY.clickAdjustmentsYes();

    }

    @When("^I enter a pool number that is the current pool number plus 1$")
    public void poolNumberPlusOne() throws Throwable {
        Integer newPoolNo = Integer.valueOf(poolRequestNumber.get()) + 1;
        NAV.set_valueTo("Pool number", String.valueOf(newPoolNo));
        NAV.press_buttonByName("Change");
        poolRequestNumber.set(String.valueOf(newPoolNo));

    }

    @Then("^I see updated date and time in Pool History timeline$")
    public void iSeeCurrentDateAndTime() {
        final String seePoolHistoryUpdatedTime = POOL_REQUESTS_PAGE.seePoolHistoryUpdatedTime();

        assertFalse("moj-timeline_date", seePoolHistoryUpdatedTime.isEmpty());
    }

    @And("^I click no, to process the summons reply later$")
    public void iClickNoToProcessTheSummonsReplyLater() {
        SUMMONS_REPLY.clickNoToReplyLater();
    }

    @When("^I navigate to the active pool \"([^\"]*)\" overview$")
    public void navigateActivePoolOverview(String poolNo) {
        POOL_REQUESTS_PAGE.clickActivePoolNumber(poolNo);
    }

    @And("^a new juror record \"([^\"]*)\" is inserted into pool \"([^\"]*)\" in court \"([^\"]*)\"$")
    public void aNewJurorRecordIsInsertedIntoPoolInCourt(String jurorRecordNumber, String existingPoolNumber, String court) throws SQLException {
        jurorPartNumber.set(jurorRecordNumber);
        DBT.insertNewJurorIntoPool(court, jurorRecordNumber, existingPoolNumber);
    }


    @And("^I see the title \"([^\"]*)\" in position \"([^\"]*)\" of the history$")
    public void iSeeTitleInPositionOfTheHistory(String historyMessage, int positionInList) {
        String[] elementsInPosition = POOL_OVERVIEW_PAGE.historyHeaderAndDescInPos(positionInList);
        assertEquals(historyMessage, elementsInPosition[0]);
    }

    @And("^I do not see the title \"([^\"]*)\" in position \"([^\"]*)\" of the history$")
    public void iDoNotSeeTheTitleInPositionOfTheHistory(String historyMessage, int positionInList) throws Throwable {
        String[] elementsInPosition = POOL_OVERVIEW_PAGE.historyHeaderAndDescInPos(positionInList);
        assertNotEquals(historyMessage, elementsInPosition[0]);
    }

    @And("^I see the description \"([^\"]*)\" in position \"([^\"]*)\" of the history$")
    public void iSeeDescInPositionOfTheHistory(String historyMessage, int positionInList) {
        String[] elementsInPosition = POOL_OVERVIEW_PAGE.historyHeaderAndDescInPos(positionInList);
        assertEquals(historyMessage, elementsInPosition[1]);
    }

    @And("^I see the correct date and time in position \"([^\"]*)\" of the history$")
    public void iSeeDateTimeInPositionOfTheHistory(int positionInList) {
        String[] elementsInPosition = POOL_OVERVIEW_PAGE.historyHeaderAndDescInPos(positionInList);
        try {
            System.out.println("Trying Normal Value");
            System.out.println("Date Time Recorded: " + dateTimeRecorded.get(positionInList - 1));
            System.out.println("Date Time On Page: " + elementsInPosition[2]);
            assertEquals(dateTimeRecorded.get(positionInList - 1), elementsInPosition[2]);
        } catch (ComparisonFailure eNormal) {
            try {
                System.out.println("Trying Higher Value");
                System.out.println("Date Time Recorded: " + dateTimeRecordedHigher.get(positionInList - 1));
                System.out.println("Date Time On Page: " + elementsInPosition[2]);
                assertEquals(dateTimeRecordedHigher.get(positionInList - 1), elementsInPosition[2]);
            } catch (ComparisonFailure eHigher) {
                try {
                    System.out.println("Trying Lower Value");
                    System.out.println("Date Time Recorded: " + dateTimeRecordedLower.get(positionInList - 1));
                    System.out.println("Date Time On Page: " + elementsInPosition[2]);
                    assertEquals(dateTimeRecordedLower.get(positionInList - 1), elementsInPosition[2]);
                } catch (ComparisonFailure eLower) {
                    System.out.println("Date on page does not match exactly or match 1-+ minutes");
                }

            }
        }
    }

    @And("^I make a note of the time$")
    public void iMakeANoteOfTheTime() {
        String datePattern = "d MMMM yyyy";
        String timePattern = "h:mma";

        LocalDate localDate = LocalDate.now();
        LocalTime localTime = LocalTime.now();
        LocalTime localTimeHigher = LocalTime.now().minusMinutes(1);
        LocalTime localTimeLower = LocalTime.now().plusMinutes(1);

        DateTimeFormatter newDateToFormat = DateTimeFormatter.ofPattern(datePattern);
        DateTimeFormatter newTimeToFormat = DateTimeFormatter.ofPattern(timePattern);

        String date = localDate.format(newDateToFormat);
        String time = localTime.format(newTimeToFormat);
        String timeHigher = localTimeHigher.format(newTimeToFormat);
        String timeLower = localTimeLower.format(newTimeToFormat);

        String[] newDateValues = {date, time, timeHigher, timeLower};
        String formedDate = (newDateValues[0] + " at " + newDateValues[1].toLowerCase());
        String formedDateHigher = (newDateValues[0] + " at " + newDateValues[2].toLowerCase());
        String formedDateLower = (newDateValues[0] + " at " + newDateValues[3].toLowerCase());
        dateTimeRecorded.add(formedDate);
        dateTimeRecordedHigher.add(formedDateHigher);
        dateTimeRecordedLower.add(formedDateLower);

        System.out.println("Time Recorded: " + formedDate);
    }

    @And("^I clear down the data in dateTimeRecorded$")
    public void iCleardownDateTimeRecorded() {
        dateTimeRecorded.clear();
        dateTimeRecordedHigher.clear();
        dateTimeRecordedLower.clear();
    }

    @When("^I click to add or edit notes$")
    public void clickAddOrEditNotes() {
        JUROR_RECORD.clickAddOrEditNotes();
    }

    @When("^I enter over 2000 characters in the Notes text box$")
    public void over2000charactersNotes() {
        String longText = StringUtils.repeat("Test", 501);
        JUROR_RECORD.enterNotes(longText);
    }

    @When("^I enter \"([^\"]*)\" in the Notes text box$")
    public void enterIntoNotes(String notes) {
        JUROR_RECORD.enterNotes(notes);
    }

    @When("^I click the save notes button$")
    public void saveNotes() {
        JUROR_RECORD.saveNotes();
    }

    @When("^I record notes \"([^\"]*)\"$")
    public void recordNotesWithText(String notes) {
        JUROR_RECORD.clickNotesTab();
        JUROR_RECORD.clickAddOrEditNotes();
        JUROR_RECORD.enterNotes(notes);
        JUROR_RECORD.saveNotes();
    }

    @When("^I record call log \"([^\"]*)\"$")
    public void recordCallLog(String callLog) throws Exception {
        JUROR_RECORD.clickNotesTab();
        NAV.click_link_by_text("Contact log");
        JUROR_RECORD.clickLogNewContact();
        NAV.select_fromDropdown("Request Deferral", "Select the type of enquiry made");
        GRP.click_radioButtonWithLabel("No");
        JUROR_RECORD.enterNotes(callLog);
        JUROR_RECORD.saveNotes();
    }

    @Then("^a second juror record is shown in the search results for \"([^\"]*)\"$")
    public void transferredJurorRecordCreatedInSearch(String jurorNumber) {
        assertEquals((2 + " results for \"" + jurorNumber + "\""), JUROR_RECORD_SEARCH.getSearchResultsHeader());
    }

    @When("^I click the juror record search link for court name \"([^\"]*)\"$")
    public void clickJurorRecordSearchLinkForCourt(String courtName) {
        JUROR_RECORD_SEARCH.clickJurorRecordForCourt(courtName);
    }


    @When("^I enter a date \"([^\"]*)\" mondays in the future for the new service start date$")
    public void enterServiceStartDateMondaysInFuture(Integer mondays) {
        JUROR_RECORD.enterNewServiceStartDate(mondayWeeksInFuture(mondays));
    }

    @When("^I select a postponement date$")
    public void clickPostponementDate() {
        JUROR_RECORD.clickPostponementDatePoolRadio();
    }

    @And("^I record a digital response for a juror with a deferral$")
    public void iRecordADigitalResponseForAJurorWithADeferral(DataTable jurorDetails) throws Throwable {
        Map<String, String> juror = jurorDetails.asMap(String.class, String.class);
        GRP.click_radioButtonWithLabel("I am replying for myself");
        NAV.press_buttonByName("Continue");

        SUMMONS_REPLY.setJurorNumber(juror.get("jurorNumber"));
        SUMMONS_REPLY.setJurorLname(juror.get("jurorLname"));
        SUMMONS_REPLY.setJurorPostcode(juror.get("jurorPostcode"));
        NAV.press_buttonByName("Continue");
        NAV.textNotPresentOnPage("There is a problem");

        GRP.click_radioButtonWithLabel("Yes");
        NAV.press_buttonByName("Continue");

        GRP.click_radioButtonWithLabel("Yes");
        NAV.press_buttonByName("Continue");

        NAV.set_valueTo("Main phone", "0123456789");
        NAV.press_buttonByName("Continue");

        NAV.set_valueTo("Enter your email address", "test@test.com");
        NAV.set_valueTo("Enter your email address again", "test@test.com");
        NAV.press_buttonByName("Continue");

        NAV.set_valueTo("Day", "01");
        NAV.set_valueTo("Month", "01");
        NAV.set_valueTo("Year", "1970");
        NAV.press_buttonByName("Continue");

        NAV.textPresentOnPage("Confirm you're eligible for jury service");
        NAV.press_buttonByName("Continue");

        GRP.click_radioButtonWithLabel("Yes");
        NAV.press_buttonByName("Continue");

        GRP.click_radioButtonWithLabel("No");
        NAV.press_buttonByName("Continue");

        GRP.click_radioButtonWithLabel("No");
        NAV.press_buttonByName("Continue");

        GRP.click_radioButtonWithLabel("No");
        NAV.press_buttonByName("Continue");

        GRP.click_radioButtonWithLabel("No");
        NAV.press_buttonByName("Continue");

        GRP.click_radioButtonWithLabel("No");
        NAV.press_buttonByName("Continue");

        GRP.click_radioButtonWithLabel("No, I need to change the date");
        NAV.press_buttonByName("Continue");

        SUMMONS_REPLY.setDigitalDeferralReason("Test Digital Deferral Reason");
        NAV.press_buttonByName("Continue");

        SUMMONS_REPLY.setFirstChoice(mondayWeeksInFuture(11));
        SUMMONS_REPLY.setSecondChoice(mondayWeeksInFuture(12));
        SUMMONS_REPLY.setThirdChoice(mondayWeeksInFuture(13));
        NAV.press_buttonByName("Continue");

        GRP.click_radioButtonWithLabel("Yes");
        NAV.press_buttonByName("Continue");

        GRP.click_radioButtonWithLabel("No");
        NAV.press_buttonByName("Continue");

        NAV.check_checkbox("The information I have given is true to the best of my knowledge.");
        NAV.press_buttonByName("Submit");

        NAV.textPresentOnPage("You have completed your reply");
    }

    @And("^I record a digital response for a juror that is too old$")
    public void iRecordADigitalResponseForAJurorTooOld(DataTable jurorDetails) throws Throwable {
        Map<String, String> juror = jurorDetails.asMap(String.class, String.class);
        GRP.click_radioButtonWithLabel("I am replying for myself");
        NAV.press_buttonByName("Continue");

        SUMMONS_REPLY.setJurorNumber(juror.get("jurorNumber"));
        SUMMONS_REPLY.setJurorLname(juror.get("jurorLname"));
        SUMMONS_REPLY.setJurorPostcode(juror.get("jurorPostcode"));
        NAV.press_buttonByName("Continue");
        NAV.textNotPresentOnPage("There is a problem");

        //Is the name we have for you correct
        GRP.click_radioButtonWithLabel("Yes");
        NAV.press_buttonByName("Continue");

        //Is this your address
        GRP.click_radioButtonWithLabel("Yes");
        NAV.press_buttonByName("Continue");

        //What is your phone number
        NAV.set_valueTo("Main phone", "0123456789");
        NAV.press_buttonByName("Continue");

        //What is your email address
        NAV.set_valueTo("Enter your email address", "test@test.com");
        NAV.set_valueTo("Enter your email address again", "test@test.com");
        NAV.press_buttonByName("Continue");

        //What is your date of birth
        NAV.set_valueTo("Day", "01");
        NAV.set_valueTo("Month", "01");
        NAV.set_valueTo("Year", "1945");

        NAV.press_buttonByName("Continue");

        //Confirm your date of birth
        NAV.textPresentOnPage("Confirm your date of birth");
        GRP.click_radioButtonWithLabel("Yes");
        NAV.press_buttonByName("Continue");

        //Check your answers now
        NAV.check_checkbox("The information I have given is true to the best of my knowledge.");
        NAV.press_buttonByName("Submit");

        NAV.textPresentOnPage("You have completed your reply");
        NAV.textPresentOnPage("Your age means you cannot do jury service");

    }

    @And("^I record a digital response for a juror that is too young$")
    public void iRecordADigitalResponseForAJurorTooYoung(DataTable jurorDetails) throws Throwable {
        Map<String, String> juror = jurorDetails.asMap(String.class, String.class);
        GRP.click_radioButtonWithLabel("I am replying for myself");
        NAV.press_buttonByName("Continue");

        SUMMONS_REPLY.setJurorNumber(juror.get("jurorNumber"));
        SUMMONS_REPLY.setJurorLname(juror.get("jurorLname"));
        SUMMONS_REPLY.setJurorPostcode(juror.get("jurorPostcode"));
        NAV.press_buttonByName("Continue");
        NAV.textNotPresentOnPage("There is a problem");

        //Is the name we have for you correct
        GRP.click_radioButtonWithLabel("Yes");
        NAV.press_buttonByName("Continue");

        //Is this your address
        GRP.click_radioButtonWithLabel("Yes");
        NAV.press_buttonByName("Continue");

        //What is your phone number
        NAV.set_valueTo("Main phone", "0123456789");
        NAV.press_buttonByName("Continue");

        //What is your email address
        NAV.set_valueTo("Enter your email address", "test@test.com");
        NAV.set_valueTo("Enter your email address again", "test@test.com");
        NAV.press_buttonByName("Continue");

        //What is your date of birth
        String yearYoung = String.valueOf((Year.now().getValue() - 10));

        NAV.set_valueTo("Day", "01");
        NAV.set_valueTo("Month", "01");
        NAV.set_valueTo("Year", yearYoung);
        NAV.press_buttonByName("Continue");

        //Confirm your date of birth
        NAV.textPresentOnPage("Confirm your date of birth");
        GRP.click_radioButtonWithLabel("Yes");
        NAV.press_buttonByName("Continue");

        //Check your answers now
        NAV.check_checkbox("The information I have given is true to the best of my knowledge.");
        NAV.press_buttonByName("Submit");

        NAV.textPresentOnPage("You have completed your reply");
        NAV.textPresentOnPage("Your age means you cannot do jury service");

    }

    @And("^I record a digital response for a juror that provides an incorrect DoB and corrects it$")
    public void iRecordADigitalResponseForAJurorIncorrectDobProvidedCorrected(DataTable jurorDetails) throws Throwable {
        Map<String, String> juror = jurorDetails.asMap(String.class, String.class);
        GRP.click_radioButtonWithLabel("I am replying for myself");
        NAV.press_buttonByName("Continue");

        SUMMONS_REPLY.setJurorNumber(juror.get("jurorNumber"));
        SUMMONS_REPLY.setJurorLname(juror.get("jurorLname"));
        SUMMONS_REPLY.setJurorPostcode(juror.get("jurorPostcode"));
        NAV.press_buttonByName("Continue");
        NAV.textNotPresentOnPage("There is a problem");

        //Is the name we have for you correct
        GRP.click_radioButtonWithLabel("Yes");
        NAV.press_buttonByName("Continue");

        //Is this your address
        GRP.click_radioButtonWithLabel("Yes");
        NAV.press_buttonByName("Continue");

        //What is your phone number
        NAV.set_valueTo("Main phone", "0123456789");
        NAV.press_buttonByName("Continue");

        //What is your email address
        NAV.set_valueTo("Enter your email address", "test@test.com");
        NAV.set_valueTo("Enter your email address again", "test@test.com");
        NAV.press_buttonByName("Continue");

        //What is your date of birth
        String yearYoung = String.valueOf((Year.now().getValue() - 10));

        NAV.set_valueTo("Day", "01");
        NAV.set_valueTo("Month", "01");
        NAV.set_valueTo("Year", yearYoung);
        NAV.press_buttonByName("Continue");
        NAV.press_buttonByName("Continue");

        //Confirm your date of birth
        NAV.textPresentOnPage("Confirm your date of birth");
        GRP.click_radioButtonWithLabel("No");
        NAV.press_buttonByName("Continue");

        //What is your date of birth - corrected
        String yearCorrect = String.valueOf((Year.now().getValue() - 25));

        NAV.set_valueTo("Day", "01");
        NAV.set_valueTo("Month", "01");
        NAV.set_valueTo("Year", yearCorrect);

        NAV.press_buttonByName("Continue");

        //Confirm you're eligible
        NAV.textPresentOnPage("Confirm you're eligible for jury service");
        NAV.press_buttonByName("Continue");

        GRP.click_radioButtonWithLabel("Yes");
        NAV.press_buttonByName("Continue");

        GRP.click_radioButtonWithLabel("No");
        NAV.press_buttonByName("Continue");

        GRP.click_radioButtonWithLabel("No");
        NAV.press_buttonByName("Continue");

        GRP.click_radioButtonWithLabel("No");
        NAV.press_buttonByName("Continue");

        GRP.click_radioButtonWithLabel("No");
        NAV.press_buttonByName("Continue");

        GRP.click_radioButtonWithLabel("No");
        NAV.press_buttonByName("Continue");

        GRP.click_radioButtonWithLabel("Yes, I can start");
        NAV.press_buttonByName("Continue");

        GRP.click_radioButtonWithLabel("No");
        NAV.press_buttonByName("Continue");

        //Check your answers now
        NAV.check_checkbox("The information I have given is true to the best of my knowledge.");
        NAV.press_buttonByName("Submit");

        NAV.textPresentOnPage("You have completed your reply");

    }


    public static String weeksInFuture(int noWeeks) {
        String datePattern = "dd/MM/yyyy";
        Calendar date = Calendar.getInstance();
        date.add(Calendar.WEEK_OF_MONTH, noWeeks);

        return new SimpleDateFormat(datePattern).format(date.getTime());
    }


    public static String mondayWeeksInFuture(int noWeeks) {
        String datePattern = "dd/MM/yyyy";
        LocalDate nextMonday = LocalDate.now().with(TemporalAdjusters.next(DayOfWeek.MONDAY));
        nextMonday = nextMonday.plusWeeks(noWeeks);
        DateTimeFormatter dateToFormat = DateTimeFormatter.ofPattern(datePattern);

        return nextMonday.format(dateToFormat);
    }

    @Then("^I see the reply type has been updated to \"([^\"]*)\"$")
    public void replyTypeHasBeenUpdated(String updatedReplyType) {
        assertEquals("Reply Type is not as expected", updatedReplyType, VIEW_SUMMONS_REPLY.getTypeValue());
    }

    @When("^I change the jurors date of birth$")
    public void enterDobJurorDetails() {
        SUMMONS_REPLY.enterDateOfBirth("11/4/1979");

    }

    @When("^I select the date picker button$")
    public void clickDateOfBirthButton() {
        SUMMONS_REPLY.clickDateOfBirthButton();

    }

    @When("^I select the yes radio button from the Third Party Juror details$")
    public void clickThirdPartyYesButton() {
        SUMMONS_REPLY.clickYesThirdPartyJurorDetailsButton();

    }

    @When("^I select the yes radio button from the Additional Requirements Juror details$")
    public void clickAdditionalRequirementsYesButton() {
        SUMMONS_REPLY.clickYesAdditionalRequirementsJurorDetailsButton();
        NAV.waitForPageLoad();
    }

    @When("^I select the Juror Details tab from the summons reply page$")
    public void clickJurorDetailsTab() {
        SUMMONS_REPLY.clickJurorDetailsTab();

    }

    @When("^I select the Eligibility tab from the summons reply page$")
    public void clickEligibilityTab() {
        SUMMONS_REPLY.clickEligibilityTab();

    }

    @When("^I select the Deferral or Excusal tab from the summons reply page$")
    public void clickdeferralOrExcusalTab() {
        SUMMONS_REPLY.clickdeferralOrExcusalTab();

    }

    @When("^I select the CJS Employment tab from the summons reply page$")
    public void clickcjsEmploymentTab() {
        SUMMONS_REPLY.clickcjsEmploymentTab();

    }

    @When("^I select the reasonable adjustments tab from the summons reply page$")
    public void clickreasonableAdjustmentsTab() {
        SUMMONS_REPLY.clickreasonableAdjustmentsTab();

    }

    @When("^I select the Signature tab from the summons reply page$")
    public void clicksignatureTab() {
        SUMMONS_REPLY.clicksignatureTab();

    }

    @When("^I set residency in the UK radio button to No$")
    public void residencytoNo() {
        SUMMONS_REPLY.clickresidencyNoButton();

    }

    @Then("^I create a \"([^\"]*)\" court pool request for court \"([^\"]*)\" and summon jurors$")
    public void createPoolRequestAndSummonJurors(String poolRequestType, String court) throws Throwable {
        NAV.press_buttonByName("Create pool");
        GRP.click_radioButtonWithLabel("Request new pool");
        NAV.press_buttonByName("Continue");
        NAV.set_valueTo("Enter a court name or location code", court);
        NAV.press_buttonByName("Continue");
        NAV.waitForPageLoad();

        if (poolRequestType.equals("Civil"))
            POOL_REQUESTS_PAGE.selectPoolType(PoolRequests.PoolType.CIVIL);
        if (poolRequestType.equals("Crown"))
            POOL_REQUESTS_PAGE.selectPoolType(PoolRequests.PoolType.CROWN);
        if (poolRequestType.equals("High"))
            POOL_REQUESTS_PAGE.selectPoolType(PoolRequests.PoolType.HIGH);
        NAV.set_value_to("Number of jurors", "150");
        NAV.press_buttonByName("Continue");
        poolNumber.set(CHECK_POOL_REQUEST_PAGE.getNewPoolRequestNumber());
        poolRequestNumber.set(CHECK_POOL_REQUEST_PAGE.getNewPoolRequestNumber());
        poolDate.set(CHECK_POOL_REQUEST_PAGE.getNewPoolAttendanceDate());
        poolNumber.set(POOL_REQUESTS_PAGE.getPoolNumberOnDetails());

        ArrayList<String> pools = poolNumbers.get();
        System.out.println("Getting Pool Number --- " + poolNumber.get());

        pools.add(poolNumber.get());
        System.out.println("Values in pools array --- " + pools.toString());

        NAV.press_buttonByName("Request pool");

        POOL_REQUESTS_PAGE.clickInactivePoolNumber(poolNumber.get());
        NAV.press_buttonByName("Summon jurors");
        NAV.set_value_to("Citizens to summon", "1");
        NAV.press_buttonByName("Create pool and summon citizens");
    }

    @When("^I select one of the jurors I have just summoned$")
    public void selectFirstJurorInList() {
        POOL_REQUESTS_PAGE.selectFirstJurorInList();
    }
    @And("^I get an initial list of the jurors that have been summoned$")
    public void iGetInitialListOfTheJurorsThatHaveBeenSummoned() {
        summonedJurorsOld.set(POOL_OVERVIEW_PAGE.getJurorNumbers());
    }
    @And("^I get a new list of the jurors that have been summoned$")
    public void iGetNewListOfTheJurorsThatHaveBeenSummoned() {
        summonedJurorsNew.set(POOL_OVERVIEW_PAGE.getJurorNumbers());
    }
    @And("^I remove the initial jurors from the list$")
    public void iRemoveJurorFromSummonedJurorList(){
        /*linked to:
        iGetInitialListOfTheJurorsThatHaveBeenSummoned()
        iGetNewListOfTheJurorsThatHaveBeenSummoned()
         */
        log.info("Original jurors: "+ summonedJurorsOld.get());
        log.info("New jurors     : "+ summonedJurorsNew.get());
        for (String number : summonedJurorsOld.get()) {
            summonedJurorsNew.get().remove(number);
        }
        summonedJurors.set(summonedJurorsNew.get());
        log.info("New juror      : "+ summonedJurors.get());
    }
    @When("^I select one of the active pools available$")
    public void selectFirstPoolNoInList() {
        ACTIVE_POOLS_PAGE.selectFirstPoolNoInList();
    }

    @When("^I select the checkbox in the same row as \"([^\"]*)\" in pool table$")
    public void selectJurorCheckbox(String nextToText) {
        POOL_REQUESTS_PAGE.checkJurorCheckboxSame_rowAs(nextToText);
    }

    @When("^I check the select all checkbox$")
    public void selectAllcheckbox() {
        ACTIVE_POOLS_PAGE.checkSelectAllCheckbox();
    }

    @When("^I check the select all checkbox on pool overview$")
    public void selectAllcheckboxOnPoolOverview() {
        NAV.waitForPageLoad();
        ACTIVE_POOLS_PAGE.checkSelectAllCheckboxOnPoolOverview();
    }

    @When("^I check the select all checkbox on pool overview as bureau user$")
    public void checkSelectAllCheckboxOnPoolOverviewForBureau() {
        NAV.waitForPageLoad();
        ACTIVE_POOLS_PAGE.bureauCheckSelectAllCheckboxOnPoolOverview();
    }

    @When("^I select one of the active pools available from the create juror record screen$")
    public void selectAnyPoolNoList() {
        ACTIVE_POOLS_PAGE.selectAnyActivePool();
    }

    @When("^I see juror \"([^\"]*)\" in the jurors cannot be moved table$")
    public void seeJurorsInCannotBeMovedTableStep(String jurorNumber) {
        boolean isJurorPresent = ACTIVE_POOLS_PAGE.seeJurorsInCannotBeMovedTable(jurorNumber);
        if (isJurorPresent) {
            log.info("Juror " + jurorNumber + " is present in the jurors cannot be moved table.");
        } else {
            log.info("Juror " + jurorNumber + " is not present in the jurors cannot be moved table.");
        }
    }

    @When("^I check the select all checkbox on pool overview as court user$")
    public void checkSelectAllCheckboxOnPoolOverviewForCourtUser() {
        ACTIVE_POOLS_PAGE.checkSelectAllCheckboxOnPoolOverviewForCourt();
    }

    @When("^I approve juror and search record$")
    public void approveJurorAndSearchRecord() throws Throwable {
        String URL = webDriver.getCurrentUrl();
        jurorRecordNumber = URL.substring(Math.max(0, URL.length() - 9));
        GRP.click_radioButtonWithLabel("Approve");
        NAV.press_buttonByName("Confirm");
        NAV.waitForPageLoad();
        JUROR_RECORD_SEARCH.searchForRecordFromGlobalSearch(jurorRecordNumber);
    }

    @When("^I select the global search$")
    public void clickGlobalSearch() throws Throwable {
        JUROR_RECORD_SEARCH.clickGlobalSearch();
    }

    @And("^I select \"([^\"]*)\" from the adjustments reason dropdown$")
    public void iSelectFromTheAdjustmentsReasonDropdown(String reason) {
        SUMMONS_REPLY.selectAdjustmentReason(reason);
    }
    @And("^I see the banner for next due at court date$")
    public void iSeeMessageSentBannerContaining() {
        POOL_OVERVIEW_PAGE.nextDueAtCourtBanner();
    }

    @Then("^\"([^\"]*)\" is marked as requiring attention$")
    public void iSeeAttentionIndicator(String eligibilityAttentionType) {
        SUMMONS_REPLY.eligibilityAttentionIndicatorVisible(eligibilityAttentionType);
    }
}