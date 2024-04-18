package cucumber.steps;

import cucumber.pageObjects.*;
import cucumber.testdata.DatabaseTester;
import io.cucumber.datatable.DataTable;
import io.cucumber.java.en.And;
import io.cucumber.java.en.Then;
import io.cucumber.java.en.When;
import org.junit.Assert;
import org.openqa.selenium.By;
import org.openqa.selenium.Keys;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.PageFactory;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.time.DayOfWeek;
import java.time.LocalDate;
import java.time.ZoneId;
import java.time.format.DateTimeFormatter;
import java.time.temporal.TemporalAdjusters;
import java.util.*;

import static org.junit.Assert.*;

public class StepDef_jurorRecord {

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
    private final SummonsReplySearch SUMMONS_SEARCH;
    private final ViewSummonsReply VIEW_SUMMONS_REPLY;
    private final PoolSearch POOL_SEARCH;

    private final Header HEADER_PAGE;
    private final DatabaseTester DBT;
    private final JurorRecordSearch JUROR_RECORD_SEARCH;
    private final CourtJurorRecord COURT_JUROR_RECORD;
    private final JurorRecord JUROR_RECORD;

    private String poolRequestNumber;
    private static String summonsReplyNumber;
    public static String selectedAttendanceDate;
    public static String jurorRecordNumber;
    public static String poolNumber;
    public static String originalReplyStatus;

    public StepDef_jurorRecord(SharedDriver webDriver, DatabaseTester dbt, JurorRecord juror_record) {
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
        COURT_JUROR_RECORD = PageFactory.initElements(webDriver, CourtJurorRecord.class);
        JUROR_RECORD = juror_record;
        SUMMONS_SEARCH = PageFactory.initElements(webDriver, SummonsReplySearch.class);
    }

    @Then("^I am on the Juror Record for juror \"([^\"]*)\"$")
    public void iAmOnJurorRecord(String jurorRecordNumber) throws Throwable {
        NAV.waitForPageLoad();
        NAV.textPresentOnPage(jurorRecordNumber);
        assertTrue(JUROR_RECORD.seeJurorRecordTag());
        assertTrue(JUROR_RECORD.seeOverviewTab());
        assertTrue(JUROR_RECORD.seeDetailsTab());
        assertTrue(JUROR_RECORD.seeSummonsTab());
        assertTrue(JUROR_RECORD.seeAttendanceTab());
        assertTrue(JUROR_RECORD.seeNotesTab());
        assertTrue(JUROR_RECORD.seeHistoryTab());

    }

    @Then("^I see the Juror Record tag$")
    public void jurorRecordTagIsVisible() {
        assertTrue(JUROR_RECORD.seeJurorRecordTag());
    }

    @Then("^I see the juror's status on the juror record screen is \"([^\"]*)\"$")
    public void jurorStatusHasUpdatedTo(String jurorStatus) {
        assertEquals(jurorStatus, JUROR_RECORD.getJurorStatus());
    }

    @Then("^I see the court name on the juror record screen is \"([^\"]*)\"$")
    public void courtNameOnJurorRecordIs(String courtName) {
        assertEquals(courtName, JUROR_RECORD.getCourtName());
    }

    @Then("^the warning icon is displayed next to the juror status$")
    public void jurorStatusWarningSymbol() {
        assertTrue(JUROR_RECORD.seeJurorStatusWarningSymbol());
    }

    @When("^I click on the Summons Reply tab$")
    public void clickSummonsTab() {
        JUROR_RECORD.clickSummonsTab();
    }

    @Then("^I see the reply status of the summons reply on juror record is \"([^\"]*)\"$")
    public void sumonsReplyStatus(String replyStatus) {
        assertEquals(replyStatus, JUROR_RECORD.getReplyStatus());
    }

    @Then("^I see the processing outcome of the summons reply on juror record is \"([^\"]*)\"$")
    public void summonsReplyProcessingOutcome(String processingOutcome) {
        assertEquals(processingOutcome, JUROR_RECORD.getProcessingOutcome());
    }

    @Then("^the warning icon is displayed next to the processing outcome$")
    public void processingOutcomeWarningSymbol() {
        assertTrue(JUROR_RECORD.seeProcessingOutcomeWarningSymbol());
    }

    @Then("^I see the reply method of the summons reply on juror record is \"([^\"]*)\"$")
    public void summonsReplyReplyMethod(String replyMethod) {
        assertEquals(replyMethod, JUROR_RECORD.getReplyMethod());
    }

    @Then("^I see the reply date of the summons reply on juror record is \"([^\"]*)\"$")
    public void summonsReplyReplyDate(String replyDate) {
        String expectedDate = replyDate;
        if (replyDate.equals("today")) {
            String datePattern = "d MMMM YYYY";
            Calendar date = Calendar.getInstance();
            expectedDate = new SimpleDateFormat(datePattern).format(date.getTime());
        }
        assertEquals(expectedDate, JUROR_RECORD.getReplyDate());
    }

    @When("^I click the reassign to another pool radio button$")
    public void clickReassignPoolRadioButton() {
        JUROR_RECORD.clickReassignRadioButton();
    }

    public void clickJurorFromReassignlist() {
        List<WebElement> jurors = driver.findElements(By.tagName("a"));
        for (WebElement lijurors : jurors) {
            if (lijurors.getText().contains(poolNumber)) ;
            JUROR_RECORD.clickReassignJuror();
        }

    }

    @Then("^I see the reassign active pools table$")
    public void seeReassignActivePoolsTable() {
        assertTrue(JUROR_RECORD.seeReassignActivePoolsTable());
        List<String> tableHeadings = JUROR_RECORD.getReassignActivePoolsHeadings();
        assertEquals("Pool number", tableHeadings.get(0));
        assertEquals("Summoning status", tableHeadings.get(1));
        assertEquals("Service start date", tableHeadings.get(2));
    }

    @Then("^the juror record pool number has updated to \"([^\"]*)\"$")
    public void getJurorRecordPoolNumber(String poolNo) {
        assertEquals(poolNo, JUROR_RECORD.getPoolNumber());
    }

    @Then("^the juror record court name has updated to \"([^\"]*)\"$")
    public void getJurorRecordCourtName(String courtName) {
        assertEquals(courtName, JUROR_RECORD.getCourtName());
    }

    @Then("^I see police check has updated to \"([^\"]*)\"$")
    public void iSeePoliceCheckHasUpdatedTo(String policeCheckStatus) {
        assertEquals(policeCheckStatus, JUROR_RECORD.getPoliceCheckText());
    }

    @And("^I see the police check value is \"([^\"]*)\"$")
    public void iSeePoliceValueIs(String policeCheckStatus) {
        assertEquals(policeCheckStatus, JUROR_RECORD.getPoliceCheckText());
    }

    @And("^I see the police check value is not \"([^\"]*)\"$")
    public void iSeePoliceValueIsNot(String policeCheckStatus) {
        assertNotEquals(policeCheckStatus, JUROR_RECORD.getPoliceCheckText());
    }

    @When("^I click the transfer to another pool radio button$")
    public void clickTransferCourtRadioButton() {
        JUROR_RECORD.clickTransferCourtRadioButton();
    }

    @Then("^I am on the select a court to transfer to page$")
    public void seeCourtToTransferToPage() {
        assertEquals("Select a court to transfer to", JUROR_RECORD.getHeading());
    }

    @When("^I set attendance date to \"([^\"]*)\" Mondays in the future$")
    public void setAttendanceDateMondaysInFuture(String noWeeks) {
        Calendar calendar = Calendar.getInstance();
        calendar.add(Calendar.WEEK_OF_MONTH, Integer.parseInt(noWeeks));
        LocalDate localDate = calendar.toInstant().atZone(ZoneId.systemDefault()).toLocalDate();
        LocalDate localDateMonday = localDate.with(TemporalAdjusters.next(DayOfWeek.MONDAY));
        //Add a leading 0 to anything less than double digits
        JUROR_RECORD.enterAttendanceDate(localDateMonday.format(DateTimeFormatter.ofPattern("dd/MM/YYYY")));
    }

    @When("^I set attendance date to a date that doesn't exist")
    public void setAttendanceDateInvalid() {
        JUROR_RECORD.enterAttendanceDate("01/13/2023");
    }

    @And("^I see the number of deferrals is \"([^\"]*)\"$")
    public void iSeeTheNumberOfDeferralsIs(String noOfDeferrals) {
        assertEquals(noOfDeferrals, JUROR_RECORD.getNumberOfDeferrals());
    }

    @Then("^I set the \"([^\"]*)\" choice to \"([^\"]*)\" Mondays in the future$")
    public void iSetTheChoiceTo(String weekChoice, int mondaysInFuture) {
        try {
            switch (weekChoice.toLowerCase()) {
                case "first":
                    SUMMONS_REPLY.setFirstChoicePaper(StepDef_jurorpool.mondayWeeksInFuture(mondaysInFuture));
                    break;
                case "second":
                    SUMMONS_REPLY.setSecondChoicePaper(StepDef_jurorpool.mondayWeeksInFuture(mondaysInFuture));
                    break;
                case "third":
                    SUMMONS_REPLY.setThirdChoicePaper(StepDef_jurorpool.mondayWeeksInFuture(mondaysInFuture));
                    break;
                case "alternate":
                case "only":
                case "new":
                    SUMMONS_REPLY.setAltChoicePaper(StepDef_jurorpool.mondayWeeksInFuture(mondaysInFuture));
                    break;
            }
        } catch (Exception e) {
            switch (weekChoice.toLowerCase()) {
                case "first":
                    SUMMONS_REPLY.setFirstChoice(StepDef_jurorpool.mondayWeeksInFuture(mondaysInFuture));
                    break;
                case "second":
                    SUMMONS_REPLY.setSecondChoice(StepDef_jurorpool.mondayWeeksInFuture(mondaysInFuture));
                    break;
                case "third":
                    SUMMONS_REPLY.setThirdChoice(StepDef_jurorpool.mondayWeeksInFuture(mondaysInFuture));
                    break;
            }
        }
    }

    @Then("^I select to Choose a different date")
    public void selectDifferentDate() {
        SUMMONS_REPLY.deferralOptionDifferent();
    }

    @And("^I select the pool I created for the deferral$")
    public void iSelectThePoolICreatedForTheDeferral() {
        ArrayList<String> pools = StepDef_jurorpool.poolNumbers.get();
        System.out.println(pools.get(0));
        SUMMONS_REPLY.clickPoolCreatedForDeferral(pools.get(0));
    }

    @And("^I click the change link for the juror deferral$")
    public void iClickTheChangeLinkForTheJurorDeferral() {
        JUROR_RECORD.clickDeferralChange();
    }

    @And("^I select the first deferral choice$")
    public void iSelectFirstChoice() {
        SUMMONS_REPLY.deferralOption1();
    }

    @And("^I see under pool details the pool number is \"([^\"]*)\"$")
    public void iSeeUnderPoolDetailsThePoolNumberIs(String poolNumberValue) {
        assertEquals(poolNumberValue, JUROR_RECORD.getPoolNumberValue());
    }

    @And("^I see Deferred to is \"([^\"]*)\" Mondays in the future$")
    public void iSeeDeferredToIsMondaysInTheFuture(int mondaysInFuture) {
        String originalDatePattern = "dd/MM/yyyy";
        String datePattern = "EEEE dd MMMM yyyy";
        CharSequence dateToPattern = StepDef_jurorpool.mondayWeeksInFuture(mondaysInFuture);
        DateTimeFormatter originalDate = DateTimeFormatter.ofPattern(originalDatePattern);
        DateTimeFormatter formattedDate = DateTimeFormatter.ofPattern(datePattern);
        LocalDate date = LocalDate.parse(dateToPattern, originalDate);
        System.out.println();
        assertEquals(formattedDate.format(date), JUROR_RECORD.getDeferredToDate());
    }

    @And("^I see the link to run a police check$")
    public void iSeeTheLinkToRunAPoliceCheck() {
        assertTrue(JUROR_RECORD.runPoliceCheckIsLinkDisplayed());
    }

    @And("^I do not see the link to run a police check$")
    public void iDoNotSeeTheLinkToRunAPoliceCheck() {
        assertTrue(JUROR_RECORD.runPoliceCheckLinkInvisible());
    }

    @And("^I see the button to run a police check$")
    public void iSeeTheButtonToRunAPoliceCheck() {
        assertTrue(JUROR_RECORD.runPoliceCheckIsButtonDisplayed());
    }

    @And("^I click the link to run a police check$")
    public void iClickTheLinkToRunAPoliceCheck() {
        JUROR_RECORD.clickRunPoliceCheckLink();
    }

    @And("^I click the button to run a police check$")
    public void iClickTheButtonToRunAPoliceCheck() {
        JUROR_RECORD.clickRunPoliceCheckButton();
    }


    @And("^I see \"([^\"]*)\" in the dropdown box$")
    public void iSeeInTheDropdownBox(String expectedText) {
        assertTrue(JUROR_RECORD.getTextCourtNameLocation(expectedText));
    }

    @When("^I set the court or location to \"([^\"]*)\"$")
    public void iSetTheCourtOrLocationTo(String courtOrLocationCode) {
        JUROR_RECORD.setCourtOrLocation(courtOrLocationCode);
    }

    @And("^I see the juror name has updated to \"([^\"]*)\"$")
    public void iSeeTheJurorNameHasUpdatedTo(String jurorName) {
        assertEquals(jurorName, JUROR_RECORD.getUpdatedJurorName());
    }

    @And("^I see the juror's new name \"([^\"]*)\" is pending approval$")
    public void iSeeTheJurorNameIsPendingApproval(String jurorNamePendingApproval) {
        assertEquals(jurorNamePendingApproval, JUROR_RECORD.jurorNamePendingApproval());
    }

    @When("^I click on the Approve or reject link$")
    public void selectApproveOrReject() {
        JUROR_RECORD.clickApproveOrRejectLink();
    }

    @When("^I click on the pool number link on Juror Record$")
    public void clickPoolNumberLink() {
        JUROR_RECORD.clickPoolNumberLink();
    }

    @Then("^I click on the \"([^\"]*)\" link in the same row as \"([^\"]*)\" on Check your answers$")
    public void clickChangeLinkInSameRowAs_inCreateJurorRecord(String link, String nextTo) throws Throwable {
        NAV.waitForPageLoad(2);
        JUROR_RECORD.clickChangeLinkInSameRowAs_inCreateJurorRecord(link, nextTo);
    }

    @When("^I see senior jury officer notification banner$")
    public void seeSjoNotificationBanner() {
        JUROR_RECORD.sjoNotification();
    }

    @When("^I set the first checkbox on the Uncomplete Service page$")
    public void checkUncompleteJuror() {
        JUROR_RECORD.checkUncompleteJuror();
    }

    @When("^I do not see the senior jury officer notification banner$")
    public void doNotseeSjoNotificationBanner() {
        JUROR_RECORD.sjoNotificationNotPresent();
    }

    @When("^I click on the jurors to approve link from the sjo notification$")
    public void clickLinkOnSjoNotificationBanner() {
        JUROR_RECORD.clickSjoNotification();

    }

    @When("^I comment \"([^\"]*)\" as reason for my rejection of juror$")
    public void recordCommentsWithText(String comments) {
        JUROR_RECORD.enterComments(comments);
    }

    @Then("^I am able to see and interact with the jurors Deferral letter tabs and fields$")
    public void iAmAbleToSeeAndInteractWithTheDeferralGrantedLetterTabsAndFields() {
        JUROR_RECORD.deferralGrantedjurorsTabPresent("Juror number");
        JUROR_RECORD.deferralGrantedjurorsTabPresent("First name");
        JUROR_RECORD.deferralGrantedjurorsTabPresent("Last name");
        JUROR_RECORD.deferralGrantedjurorsTabPresent("Postcode");
        JUROR_RECORD.deferralGrantedjurorsTabPresent("Status");
        JUROR_RECORD.deferralGrantedjurorsTabPresent("Deferred to");
        JUROR_RECORD.deferralGrantedjurorsTabPresent("Reason");
        JUROR_RECORD.deferralGrantedjurorsTabPresent("Date printed");
    }
    @When("^I expand the summons replies search advanced search criteria$")
    public void expandPoolSearchAdvanced() { SUMMONS_SEARCH.clickAdvancedSearch(); }

    @When("^I check the urgent checkbox$")
    public void selectUrgentCheckbox() { SUMMONS_SEARCH.clickUrgentCheckbox(); }

    @When("^I check the Awaiting Court Reply Checkbox$")
    public void selectAwaitingCourtReplyCheckbox() { SUMMONS_SEARCH.clickAwaitingCourtReplyCheckbox(); }

    @When("^I check the Awaiting Juror Reply Checkbox$")
    public void selectAwaitingJurorReplyCheckbox() { SUMMONS_SEARCH.clickAwaitingJurorReplyCheckbox(); }

    @When("^I check the Awaiting Translation Checkbox$")
    public void selectAwaitingTranslationCheckbox() { SUMMONS_SEARCH.clickAwaitingTranslationCheckbox(); }

    @When("^I check the ToDo Checkbox$")
    public void clickToDoCheckbox() { SUMMONS_SEARCH.clickToDoCheckbox(); }

    @When("^I check the Completed Checkbox$")
    public void clickCompletedCheckbox() { SUMMONS_SEARCH.clickCompletedCheckbox(); }

    @When("^I click the search button$")
    public void clickSearchButton() { SUMMONS_SEARCH.clickSearchButton();}

    @When("^I enter pool number \"([^\"]*)\"$")
    public void setPoolNumber(String poolNumber) { SUMMONS_SEARCH.setPoolNumber(poolNumber); }

    @When("^I enter juror number \"([^\"]*)\"$")
    public void setJurorNumber(String jurorNumber) { SUMMONS_SEARCH.setJurorNumber(jurorNumber); }

    @When("^I enter assigned officer \"([^\"]*)\"$")
    public void setOfficerAssigned(String officerAssigned) { SUMMONS_SEARCH.setOfficerAssigned(officerAssigned); }

    @Then("I see the printed letter for juror number \"([^\"]*)\" in the letters table$")
    public void seeThePrintedLetterForJurorInTheTable(String jurorNumber) {
        NAV.waitForPageLoad(2);
        JUROR_RECORD.seePrintedLetterInLettersTable(jurorNumber);
    }

    @When("^I return to the previous tab$")
    public void returnToPreviousTab(){
        JUROR_RECORD.returnToPreviousTabAfterLetter();
    }
    @When("^I press non-attendance day button$")
    public void pressNonAttendanceButton(){
        JUROR_RECORD.pressNonAttendanceDayButton();
    }
    @When("^I press confirm non-attendance day button$")
    public void pressConfirmNonAttendanceButton(){
        JUROR_RECORD.PressConfirmNonAttendanceDateButton();
    }

    @When("^I set non-attendance date to \"([^\"]*)\"$")
    public void setNonAttendanceDayDateWithFreeText(String text) {
        JUROR_RECORD.setNonAttendanceDate(text);
    }

    @When("^I set non-attendance date to \"([^\"]*)\" weeks in the future$")
    public void setNonAttendanceDayDate(String Weeks){

        int weeks;
        try { weeks = Integer.parseInt(Weeks); }
        catch (NumberFormatException e) { weeks = 0;}

        DateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy");
        Date today = Calendar.getInstance().getTime();
        Calendar calendar = Calendar.getInstance();
        calendar.setTime(today);
        calendar.add(Calendar.WEEK_OF_MONTH, weeks);
        Date newDate = calendar.getTime();

        JUROR_RECORD.setNonAttendanceDate(dateFormat.format(newDate));
    }

    @Then("^I see the date \"([^\"]*)\" weeks from now in the same row as \"([^\"]*)\"$")
    public void seeText_inSameRow_asText(String Weeks, String nextToText) {

        int weeks;
        try {
            weeks = Integer.parseInt(Weeks);
            }
        catch (NumberFormatException e) {
            weeks = 0;
        }

        DateFormat dateFormat = new SimpleDateFormat("EEE d MMM yyyy");
        Date today = Calendar.getInstance().getTime();
        Calendar calendar = Calendar.getInstance();
        calendar.setTime(today);
        calendar.add(Calendar.WEEK_OF_MONTH, weeks);
        Date newDate = calendar.getTime();

        try {
            NAV.seeText_inSameRow_asText(dateFormat.format(newDate), nextToText);
        } catch (Exception e) {
            NAV.waitForPageLoad();
            NAV.seeText_inSameRow_asText(dateFormat.format(newDate), nextToText);
        }
    }

    @Then("^I see the expense date \"([^\"]*)\" weeks from now in the same row as \"([^\"]*)\"$")
    public void seeText_inSameRow_asExpenseDate(String Weeks, String nextToText) {

        int weeks;
        try {
            weeks = Integer.parseInt(Weeks);
            }
        catch (NumberFormatException e) {
            weeks = 0;
        }

        DateFormat dateFormat = new SimpleDateFormat("EEE dd MMM yyyy");
        Date today = Calendar.getInstance().getTime();
        Calendar calendar = Calendar.getInstance();
        calendar.setTime(today);
        calendar.add(Calendar.WEEK_OF_MONTH, weeks);
        Date newDate = calendar.getTime();

        try {
            NAV.seeText_inSameRow_asText(dateFormat.format(newDate), nextToText);
        } catch (Exception e) {
            NAV.waitForPageLoad();
            NAV.seeText_inSameRow_asText(dateFormat.format(newDate), nextToText);
        }
    }


    @Then("^I click the expense date \"([^\"]*)\" weeks from now in the same row as \"([^\"]*)\"$")
    public void clickText_inSameRow_asExpenseDate(String Weeks, String nextToText) throws InterruptedException {

        int weeks;
        try {
            weeks = Integer.parseInt(Weeks);
            }
        catch (NumberFormatException e) {
            weeks = 0;
        }

        DateFormat dateFormat = new SimpleDateFormat("EEE dd MMM yyyy");
        Date today = Calendar.getInstance().getTime();
        Calendar calendar = Calendar.getInstance();
        calendar.setTime(today);
        calendar.add(Calendar.WEEK_OF_MONTH, weeks);
        Date newDate = calendar.getTime();

        try {
            NAV.click_link_by_text(dateFormat.format(newDate));
        } catch (Exception e) {
            NAV.waitForPageLoad();
            NAV.click_link_by_text(dateFormat.format(newDate));
        }
    }
  
    @Then("^I am able to see and interact with the jurors Deferral Refused letter tabs and fields$")
    public void iAmAbleToSeeAndInteractWithTheDeferralRefusedLetterTabsAndFields() {
        JUROR_RECORD.deferralRefusedjurorsTabPresent("Juror number");
        JUROR_RECORD.deferralRefusedjurorsTabPresent("First name");
        JUROR_RECORD.deferralRefusedjurorsTabPresent("Last name");
        JUROR_RECORD.deferralRefusedjurorsTabPresent("Postcode");
        JUROR_RECORD.deferralRefusedjurorsTabPresent("Status");
        JUROR_RECORD.deferralRefusedjurorsTabPresent("Date refused");
        JUROR_RECORD.deferralRefusedjurorsTabPresent("Reason");
        JUROR_RECORD.deferralGrantedjurorsTabPresent("Date printed");
    }

    @When("^I check all the checkboxes in the letters table for the initial summons letter$")
    public void selectAllCheckboxesInLettersTable(){
        NAV.waitForPageLoad(2);
        JUROR_RECORD.selectAllCheckboxesInLettersTable();
    }

    @When("^I see the documents sent banner for the initial summons letters$")
    public void seeIntialSummonsLetterBanner() {
        JUROR_RECORD.initialSummonsBanner();
    }

    @Then("^I am able to see and interact with the jurors Postponement letter tabs and fields$")
    public void iAmAbleToSeeAndInteractWithThePostponementLetterTabsAndFields() {
        JUROR_RECORD.postponementjurorsTabPresent("Juror number");
        JUROR_RECORD.postponementjurorsTabPresent("First name");
        JUROR_RECORD.postponementjurorsTabPresent("Last name");
        JUROR_RECORD.postponementjurorsTabPresent("Postcode");
        JUROR_RECORD.postponementjurorsTabPresent("Status");
        JUROR_RECORD.postponementjurorsTabPresent("Postponed to");
        JUROR_RECORD.postponementjurorsTabPresent("Reason");
        JUROR_RECORD.postponementjurorsTabPresent("Date printed");
    }
    @Then("I see the absence date for juror \"([^\"]*)\" in the letters table$")
    public void seeAbsenceDateInTable(String jurorNumber) {
        NAV.waitForPageLoad(2);
        JUROR_RECORD.seeAbsenceDateInTable(jurorNumber);
    }

    @Then("I open new tab on the same browser$")
    public void openNewTabonSameBrowser() {
        NAV.openNewTab();
    }
    @Then("I return to the previous tab for letters$")
    public void returnbackpreviousBrowser() {
        NAV.selectpreviousTab();
    }


}