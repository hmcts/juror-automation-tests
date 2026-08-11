package cucumber.steps;

import cucumber.pageObjects.DigitalByDefault;
import cucumber.pageObjects.SharedDriver;
import io.cucumber.java.en.When;

import java.sql.SQLException;

public class StepDef_DBD {

    private final DigitalByDefault DBD;

    public StepDef_DBD(SharedDriver webDriver) {
        DBD = new DigitalByDefault(webDriver);
    }

    @When("^I see What jury service involves card$")
    public void verifyWhatJuryServiceInvolvesCard() {
        DBD.verifyWhatJuryServiceInvolvesCard();
    }

    @When("^I see When and where to attend card$")
    public void verifyWhenAndWhereToAttendCard() {
        DBD.verifyWhenAndWhereToAttendCard();
    }

    @When("^I see Claiming expenses card$")
    public void verifyClaimingExpensesCard() {
        DBD.verifyClaimingExpensesCard();
    }

    @When("^I see Employment and time off work card$")
    public void verifyEmploymentAndTimeOffWorkCard() {
        DBD.verifyEmploymentAndTimeOffWorkCard();
    }

    @When("^I see Ask to change your dates card$")
    public void verifyChangeYourDatesCard() {
        DBD.verifyChangeYourDatesCard();
    }

    @When("^I see Support and accessibility card$")
    public void verifySupportAndAccessibilityCard() {
        DBD.verifySupportAndAccessibilityCard();
    }

    @When("^I see Juror eligibility card$")
    public void verifyJurorEligibilityCard() {
        DBD.verifyJurorEligibilityCard();
    }

    @When("^I press the start your response button$")
    public void pressStartYourResponseButton() {
        DBD.pressStartYourResponseButton();
    }

    @When("^I click the change catchment area link$")
    public void clickChangeCatchmentAreaLink() {
        DBD.clickChangeCatchmentAreaLink();
    }

    @When("^I click the juror number link that is not \"([^\"]*)\"$")
    public void clickJurorNumberLinkOtherThan(String excludedJurorNumber) {
        DBD.clickJurorNumberLinkOtherThan(excludedJurorNumber);
    }

    @When("^I select any active pool from the reassign table$")
    public void selectAnyActivePoolFromReassignTable() {
        DBD.selectAnyActivePoolFromReassignTable();
    }

    @When("^I update \"([^\"]*)\" to set them up for digital by default$")
    public void setupJurorForDigitalByDefault(String jurorNumber) throws SQLException {
        DBD.setupJurorForDigitalByDefault(jurorNumber);
    }

    @When("^I clear all jurors from juror_pool for pool \"([^\"]*)\" apart from juror \"([^\"]*)\"$")
    public void clearAllJurorsFromPoolApartFrom(
            String poolNumber,
            String jurorNumberToKeep
    ) throws SQLException {
        DBD.clearAllJurorsFromPoolApartFrom(poolNumber, jurorNumberToKeep);
    }

    @When("^I see the correct jury service start date for juror \"([^\"]*)\"$")
    public void verifyServiceStartDateForJuror(String jurorNumber) throws SQLException {
        DBD.verifyServiceStartDateForJuror(jurorNumber);
    }

    @When("^I determine whether this is a Digital By Default response and select the correct action$")
    public void determineDigitalByDefaultResponseAndSelectAction() throws SQLException {
        DBD.determineDigitalByDefaultResponseAndSelectAction();
    }

    @When("^I see juror \"([^\"]*)\" has \"([^\"]*)\" as \"([^\"]*)\"$")
    public void emailOrLetterOnDocumentsQueue(String jurorNo, String originalorCurrent, String emailorLetter) throws SQLException {
        DBD.emailOrLetterOnDocumentsQueue(jurorNo, originalorCurrent, emailorLetter);
    }

}
