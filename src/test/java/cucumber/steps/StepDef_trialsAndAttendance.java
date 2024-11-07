package cucumber.steps;

import cucumber.pageObjects.*;
import io.cucumber.datatable.DataTable;
import io.cucumber.java.en.And;
import io.cucumber.java.en.Then;
import io.cucumber.java.en.When;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.support.PageFactory;

import java.util.Map;

import static org.junit.Assert.assertEquals;

public class StepDef_trialsAndAttendance {

	private aSamplePO SPO;
	private Login LGN;
	private NavigationShared NAV;
	private final WebDriver webDriver;
	private ScreenShotTaker SST;

	private final TrialsAndAttendance TRL;

	public StepDef_trialsAndAttendance(SharedDriver webDriver) {
		this.webDriver = webDriver;
		SPO = PageFactory.initElements(webDriver, aSamplePO.class);
		LGN = PageFactory.initElements(webDriver, Login.class);
		NAV = PageFactory.initElements(webDriver, NavigationShared.class);
		SST = PageFactory.initElements(webDriver, ScreenShotTaker.class);
		TRL = PageFactory.initElements(webDriver, TrialsAndAttendance.class);

	}

	@When("^I check the pool number checkbox on the select specific pool page on create panel$")
	public void checkPoolNumberCheckbox() {
		TRL.checkPoolNumberCheckbox();
	}

	@When("^I set number of jurors to empanel to \"([^\"]*)\"$")
	public void setNumberOfJurorsForEmpanel(String noOfJurors) {
		TRL.jurorsForPanel(noOfJurors);
	}

	@And("^I select the radio button with name \"([^\"]*)\" and value \"([^\"]*)\"$")
	public void selectRadioButton(String jurorNumber, String status) {
		String formId = "juryEmpanelSelectForm";
		NAV.waitForPageLoad(2);
		TRL.selectStatusForEmpanelledJuror(formId, jurorNumber, status);
	}

	@When("^I set juror check in minute to \"([^\"]*)\" on confirm attendance$")
	public void setJurorCheckInMinute(String checkInTime) {
		NAV.waitForPageLoad(1);
		TRL.jurorCheckInMinute(checkInTime);

	}

	@When("^I set juror check in hour to \"([^\"]*)\" on confirm attendance$")
	public void setJurorCheckInHour(String checkInTime) {
		NAV.waitForPageLoad(1);
		TRL.jurorCheckInHour(checkInTime);

	}

	@When("^I click on the am radio button for juror check in on confirm attendance$")
	public void clickAmRadioButtonOnCheckIn() {
		NAV.waitForPageLoad(1);
		TRL.jurorCheckInRadioButtonAm();
	}

	@When("^I click on the pm radio button for juror check in on confirm attendance$")
	public void clickPmRadioButtonOnCheckIn() {
		NAV.waitForPageLoad(1);
		TRL.jurorCheckInRadioButtonPm();
	}

	@When("^I set juror check out minute to \"([^\"]*)\" on confirm attendance$")
	public void setJurorCheckOutMinute(String checkOutTime) {
		NAV.waitForPageLoad(1);
		TRL.jurorCheckOutMinute(checkOutTime);
	}

	@When("^I set juror check out hour to \"([^\"]*)\" on confirm attendance$")
	public void setJurorCheckOutHour(String checkOutTime) {
		NAV.waitForPageLoad(1);
		TRL.jurorCheckOutHour(checkOutTime);
	}

	@When("^I click on the am radio button for juror check out on confirm attendance$")
	public void clickAmRadioButtonOnCheckOut() {
		NAV.waitForPageLoad(1);
		TRL.jurorCheckOutRadioButtonAm();
	}

	@When("^I click on the pm radio button for juror check out on confirm attendance$")
	public void clickPmRadioButtonOnCheckOut() {
		NAV.waitForPageLoad(1);
		TRL.jurorCheckOutRadioButtonPm();
	}

	@Then("^I see the following juror information on the Trial details screen$")
	public void iSeeTheFollowingInformationOnaTrial(DataTable dataTable) {

		NAV.waitForPageLoad(3);
		Map<String, String> expectedData = dataTable.asMap(String.class, String.class);
		Map<String, String> actualData = TRL.getTrialDetails();

		assertEquals(expectedData.get("Defendants"), actualData.get("defendantName"));
		assertEquals(expectedData.get("Trial type"), actualData.get("trialType"));
		assertEquals(expectedData.get("Judge"), actualData.get("judgeSelected"));
		assertEquals(expectedData.get("Courtroom"), actualData.get("courtRoom"));
		assertEquals(expectedData.get("Protected?"), actualData.get("trialProtection"));
	}

	@Then("^I see the following information on the Juror Attendance table$")
	public void iSeeTheFollowingInformationOnaJurorAttendanceTable(DataTable dataTable) {

		NAV.waitForPageLoad(3);
		Map<String, String> expectedData = dataTable.asMap(String.class, String.class);
		Map<String, String> actualData = TRL.getAttendanceDetails();

		assertEquals(expectedData.get("Attendances"), actualData.get("jurorAttendances"));
		assertEquals(expectedData.get("Absences"), actualData.get("jurorAbsences"));
	}

	@Then("^I am able to see and interact with the Record attendance tabs and fields$")
	public void iAmAbleToSeeAndInteractWithTheRecordAttendenceTabsAndFields() {
		TRL.tabPresent("Juror number");
		TRL.tabPresent("First name");
		TRL.tabPresent("Last name");
		TRL.tabPresent("Status");
		TRL.tabPresent("Checked in");
		TRL.tabPresent("Checked out");
		TRL.tabPresent("Jurors in waiting");
		TRL.tabPresent("UNCONFIRMED");
		TRL.tabPresent("Record attendence");
	}

	@Then("^I am able to see and interact with the Record attendance confirmation screen$")
	public void iAmAbleToSeeAndInteractWithTheRecordAttendenceConfirmationText() {
		TRL.tabPresent("Juror number");
		TRL.tabPresent("First name");
		TRL.tabPresent("Last name");
		TRL.tabPresent("Status");
		TRL.tabPresent("Checked in");
		TRL.tabPresent("Checked out");
		TRL.tabPresent("CONFIRMED");
	}

	@Then("^I am able to see and interact with the change time and fields for \"([^\"]*)\"$")
	public void iAmAbleToSeeAndInteractWithTheChangeTimeTabsAndFields(String name) {
		TRL.tabPresent("Attendance");
		TRL.tabPresent(name);
		TRL.tabPresent("Enter check in time");
		TRL.tabPresent("Enter check out time");
	}


	@Then("^I am able to see and interact with the trial management tabs and fields$")
	public void iAmAbleToSeeAndInteractWithTheTrialManagemntTabsAndFields() {
		TRL.tabPresent("Juror number");
		TRL.tabPresent("First name");
		TRL.tabPresent("Last name");
		TRL.tabPresent("Status");
		TRL.tabPresent("Defendants");
		TRL.tabPresent("Trial type");
		TRL.tabPresent("Trial start date");
		TRL.tabPresent("Judge");
		TRL.tabPresent("Courtroom");
		TRL.tabPresent("Protected?");
		TRL.tabPresent("Return panel members");
		NAV.linkText_visible("Empanel jury", true);
		NAV.linkText_visible("End trial", true);
		TRL.tabPresent("Panel list (summary)");
		TRL.tabPresent("Panel list (detailed)");
		TRL.tabPresent("Panel member status report");
		TRL.tabPresent("Panel selection report");
		TRL.tabPresent("Ballot cards");
	}

	@Then("^I am able to see and interact with the trial management status and fields$")
	public void iAmAbleToSeeAndInteractWithTheTrialManagemntStatusAndFields() {
		TRL.tabPresent("Defendants");
		TRL.tabPresent("Trial type");
		TRL.tabPresent("Trial start date");
		TRL.tabPresent("Judge");
		TRL.tabPresent("Courtroom");
		TRL.tabPresent("Protected?");
		TRL.tabPresent("Active");
		TRL.tabPresent("Trial Number");
	}

	@Then("^I should see the attendance Pool time present is \"([^\"]*)\"$")
	public void iShouldSeeTheAttendancePoolTimePresent(String attendTime) {
		final String actualAttendanceTime = TRL.getNewAttendanceTime();
		assertEquals(attendTime, actualAttendanceTime);
	}

	@When("^I enter a date \"([^\"]*)\" mondays in the future for the next due at court$")
	public void enterNextDueCourtDateMondaysInFuture(Integer mondays) {
		TRL.enterNextDueAtCourt(StepDef_jurorpool.mondayWeeksInFuture(mondays));
	}

	@When("^I check the failed to attend checkbox$")
	public void checkFailedToAttendCheckBox() {
		TRL.checkFailedToAttendBox();
	}

	@When("^I do not see failed to attend radio button in the update juror record section$")
	public void doNotseeFailedToAttendOption() {
		TRL.failedToAttendRadioButtonNotOnScreen();
	}

	@When("^I input juror \"([^\"]*)\" to be checked in$")
	public void checkInJuror(String checkIn) {
		TRL.jurorCheckIn(checkIn);
	}

	@When("^I input juror \"([^\"]*)\" to be checked out$")
	public void checkOutJuror(String checkIn) {
		TRL.jurorCheckOut(checkIn);
	}

	@When("^I set \"([^\"]*)\" \"([^\"]*)\" to \"([^\"]*)\"$")
	public void set_Checkoutvalue_to(String arg1, String arg2, String arg3) throws Throwable {

		TRL.setRecordAttendnceChangeTimeTextbox(arg2, arg3);

	}
	@When("^I select the checkout radio button to \"([^\"]*)\"$")
	public void selectCheckOutRadioButton(String arg) throws Throwable {
		try {
			TRL.click_CheckoutRadioButton(arg);
		} catch (Throwable e) {
			NAV.waitForPageLoad();
			TRL.click_CheckoutRadioButton(arg);
		}
	}

	@When("^I click on the trial number \"([^\"]*)\"$")
	public void click_TrialNumber(String arg1) throws Throwable {

		try {
			TRL.clickActiveTrialNumber(arg1);
			return;
		} catch (Exception e) {}
		TRL.clickActiveTrialNumber(arg1);

	}
	@When("^I select the \"([^\"]*)\" trial number radio button$")
	public void checkFailedToAttendCheckBox(String trialNumber) {
		NAV.waitForPageLoad(1);
		TRL.clickTrialRadioButton(trialNumber);
	}
	@And("^I see the banner for dismissed jurors containing \"([^\"]*)\"$")
	public void iSeeMessageSentBannerContaining(String bannerContains) {
		assertEquals(bannerContains, TRL.dismissedBanner());
	}
	@When("^I press the calculate available jurors button$")
	public void clickAvailableJurorsButton() {
		TRL.clickAvailableJurorsButton();
		NAV.waitForPageLoad(2);
	}
	@When("^I see Absence displayed as \"([^\"]*)\" on the attendance table$")
	public void verifyAbsenceCount(String absenceNumber) {
		TRL.verifyAbsenceCount(absenceNumber);

	}

    @And("^I select the jurors from the \"([^\"]*)\" pool$")
    public void iSelectTheJurorsFromThePool(String poolNumber) {
		TRL.checkPoolNumberCheckboxFor(poolNumber);
	}

	@And("^I click on the previous attendance day link \"([^\"]*)\" amount of times$")
	public void iClickOnTheLinkAmountOfTimes(String numberOfClicks) {
		int clicks = Integer.parseInt(numberOfClicks);

		for (int i = 0; i < clicks; i++) {
			TRL.clickPreviousAttendanceLink();

			try {
				Thread.sleep(2000);
			} catch (InterruptedException e) {
				Thread.currentThread().interrupt();
				System.out.println("Interrupted during sleep: " + e.getMessage());
			}
		}

		int daysInPast = clicks;
		boolean isDateCorrect = TRL.verifyAttendanceDateAfterClicks(daysInPast);

		System.out.println("Is the displayed attendance date correct? " + isDateCorrect);
	}
}