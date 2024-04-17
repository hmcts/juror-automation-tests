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
public class StepDef_expenses {
    private NavigationShared NAV;
    private ScreenShotTaker SST;
    private final DatabaseTester DBT;
    private final WebDriver webDriver;
    private final Expenses EXPENSES;

    public StepDef_expenses(SharedDriver webDriver, DatabaseTester dbt, Expenses expenses) {
        this.webDriver = webDriver;
        EXPENSES = expenses;
        NAV = PageFactory.initElements(webDriver, NavigationShared.class);
        SST = PageFactory.initElements(webDriver, ScreenShotTaker.class);
        DBT = dbt;
    }

    @When("^I press view all expenses button$")
    public void pressViewAllExpensesButton(){
        EXPENSES.pressViewAllExpensesButton();
    }
    @When("^I press change default expenses button$")
    public void pressChangeDefaultButton(){
        EXPENSES.pressChangeDefaultExpensesButton();
    }
    @When("^I press change juror bank details button$")
    public void pressChangeJurorBankDetailsButton(){
        EXPENSES.pressChangeJurorBankDetailsButton();
    }
    @When("^I press change juror change address button$")
    public void pressChangeJurorAddressButton(){
        EXPENSES.pressChangeJurorAddressButton();
    }
    @When("^I press Add or Change internal note button$")
    public void pressChangeInternalNoteButton(){
        EXPENSES.pressChangeInternalNoteButton();
    }
    @When("^I set financial loss field to \"([^\"]*)\"$")
    public void setFinancialLossField(String loss){
        EXPENSES.setFinancialLossField(loss);
    }
    @When("^I set travel time hours field to \"([^\"]*)\"$")
    public void setTimeTravelHoursField(String hours){
        EXPENSES.setTimeTravelHoursField(hours);
    }
    @When("^I set travel time minutes field to \"([^\"]*)\"$")
    public void setTimeTravelMinutesField(String minutes){
        EXPENSES.setTimeTravelMinutesField(minutes);
    }
    @When("^I set mileage to \"([^\"]*)\"$")
    public void setMileageField(String mileage){
        EXPENSES.setMileageField(mileage);
    }
    @When("^I click food and drink radio button$")
    public void clickFoodAndDrinkRadioButton() {
        EXPENSES.clickFoodAndDrinkRadioButton();
    }
    @When("^I set smart card field to \"([^\"]*)\"$")
    public void setSmartCardField(String cardNumber){
        EXPENSES.setSmartCardField(cardNumber);
    }
    @When("^I click apply to all drafts checkbox$")
    public void setApplyToAllDraftCheckbox() {
        EXPENSES.setApplyToAllDraftCheckbox();
    }
    @When("^I see the unpaid expenses table$")
    public void seeUnpaidExpensesTable() {
        assertTrue(EXPENSES.unpaidExpensesTable());
    }
    @Then("^I see the following expenses on the jurors unpaid expenses form$")
    public void iSeeTheFollowingInformationOnUnpaidExpenseTable(DataTable dataTable) {

        NAV.waitForPageLoad(3);
        Map<String, String> expectedData = dataTable.asMap(String.class, String.class);
        Map<String, String> actualData = EXPENSES.getUnpaidAttendanceDetails();

        assertEquals(expectedData.get("Attendance"), actualData.get("attendance"));
        assertEquals(expectedData.get("Loss of earnings"), actualData.get("lossOfEarnings"));
        assertEquals(expectedData.get("Extra care"), actualData.get("extraCare"));
        assertEquals(expectedData.get("Other"), actualData.get("other"));
        assertEquals(expectedData.get("P. transport"), actualData.get("transport"));
        assertEquals(expectedData.get("Taxi"), actualData.get("taxi"));
        assertEquals(expectedData.get("Motorcycle"), actualData.get("motorcycle"));
        assertEquals(expectedData.get("Car"), actualData.get("car"));
        assertEquals(expectedData.get("Bicycle"), actualData.get("bicycle"));
        assertEquals(expectedData.get("Parking"), actualData.get("parking"));
        assertEquals(expectedData.get("Food and drink"), actualData.get("foodAndDrink"));
        assertEquals(expectedData.get("(Smartcard)"), actualData.get("smartCard"));
        assertEquals(expectedData.get("Total"), actualData.get("total"));
    }

    @When("^I check the checkbox containing my expense date$")
    public void checkExpenseDateCheckbox() {
        EXPENSES.checkCheckboxWithExpenseDate();
    }
    @Then("^I see the following details on the expenses for approval form$")
    public void iSeeTheFollowingInformationOnApproveExpenseTable(DataTable dataTable) {

        NAV.waitForPageLoad(3);
        Map<String, String> expectedData = dataTable.asMap(String.class, String.class);
        Map<String, String> actualData = EXPENSES.getApproveExpenseDetails();

        assertEquals(expectedData.get("Attendance"), actualData.get("attendance"));
        assertEquals(expectedData.get("Financial loss"), actualData.get("financialLoss"));
        assertEquals(expectedData.get("Travel"), actualData.get("travel"));
        assertEquals(expectedData.get("Food and drink"), actualData.get("foodAndDrink"));
        assertEquals(expectedData.get("Smartcard"), actualData.get("smartCard"));
        assertEquals(expectedData.get("Total due"), actualData.get("totalDue"));
    }
    @When("^I see the audit report for my expense in the table$")
    public void seeAuditReportInTable() {
        EXPENSES.auditReportDisplayedInTable();
    }
    @When("^I click on view draft expenses link$")
    public void clickViewDraftExpensesLink(){
        EXPENSES.clickViewDraftExpensesLink();
    }
    @When("^I click on view approval expenses link$")
    public void clickViewApprovalExpensesLink(){
        EXPENSES.clickViewApprovalExpensesLink();
    }
    @When("^I click on view approved expenses link$")
    public void clickViewApprovedExpensesLink(){
        EXPENSES.clickViewApprovedExpensesLink();
    }
    @When("^I click the add non-attendance day button$")
    public void clickNonAttendanceDayButton(){
        EXPENSES.clickNonAttendanceDayButton();
    }
    @When("^I click the check all expenses checkbox$")
    public void clickCheckAllExpensesCheckbox(){
        EXPENSES.clickCheckAllExpensesCheckbox();
    }
    @When("^I click the add smartcard spend button$")
    public void clickAddSmartcardSpendButton(){
        EXPENSES.clickAddSmartcardSpendButton();
    }
    @When("^I set smart card amount field to \"([^\"]*)\"$")
    public void setSmartcardSpendField(String amount){
        EXPENSES.setSmartcardSpendField(amount);
    }
    @When("^I click the add smartcard spend submit button$")
    public void clickAddSmartcardSpendSubmitButton(){
        EXPENSES.clickAddSmartcardSpendSubmitButton();
    }

    @When("^I click on the non attendance expense link$")
    public void clickNonAttendencedayExpenseDateLink() {
        EXPENSES.NonAttendencedayExpenseDate();
    }
    @When("^I click the Recalculate totals link$")
    public void clickRecalculateTotalLink() {
        EXPENSES.clickRecalculateTotalLink();
    }

    @When("^I see the following details on the enter expenses form$")
    public void iSeeTheFollowingInformationOnEnterExpenseForm(DataTable dataTable) {
        Map<String, String> expectedData = dataTable.asMap(String.class, String.class);
        Map<String, String> actualData = EXPENSES.getExpenseDetailAfterRecalculate();

        assertEquals(expectedData.get("Total due"), actualData.get("Total due"));
        assertEquals(expectedData.get("Financial loss (capped)"), actualData.get("Financial loss (capped)"));

    }

    @When("^I click on my draft expense link with todays date$")
    public void clickdraftExpensesWithTodaysDate(){
        EXPENSES.clickADraftExpensesTodaysDate();
    }
    @Then("^I see the following details on the loss over limit form$")
    public void iSeeTheFollowingInformationOnlossOverLimitForm(DataTable dataTable) {

        NAV.waitForPageLoad(3);
        Map<String, String> expectedData = dataTable.asMap(String.class, String.class);
        Map<String, String> actualData = EXPENSES.getLossOverLimitDetails();

        assertEquals(expectedData.get("Juror's loss"), actualData.get("Juror's loss"));
        assertEquals(expectedData.get("Daily limit (Full day)"), actualData.get("Daily limit (Full day)"));
    }
    @Then("^I see the following Half day daily day limit details on the loss over limit form$")
    public void iSeeTheFollowingHalfDayInformationOnlossOverLimitForm(DataTable dataTable) {

        NAV.waitForPageLoad(3);
        Map<String, String> expectedData = dataTable.asMap(String.class, String.class);
        Map<String, String> actualData = EXPENSES.getLossOverHalfDayLimitDetails();

        assertEquals(expectedData.get("Juror's loss"), actualData.get("Juror's loss"));
        assertEquals(expectedData.get("Daily limit (Half day)"), actualData.get("Daily limit (Half day)"));

    }

    @When("^I see the following public expenses on travel overlimit page$")
    public void travelOverLimitExpense(DataTable dataTable){
        NAV.waitForPageLoad(3);
        Map<String, String> expectedData = dataTable.asMap(String.class, String.class);
        Map<String, String> actualData = EXPENSES.getTravelOverLimitDetails();
        assertEquals(expectedData.get("Daily limit"), actualData.get("Daily limit"));
        assertEquals(expectedData.get("Amount entered"), actualData.get("Amount entered"));

    }
    @When("^I see the following taxi expenses on travel overlimit page$")
    public void taxiOverLimitExpense(DataTable dataTable){
        NAV.waitForPageLoad(3);
        Map<String, String> expectedData = dataTable.asMap(String.class, String.class);
        Map<String, String> actualData = EXPENSES.getTaxiOverLimitDetails();
        assertEquals(expectedData.get("Daily limit"), actualData.get("Daily limit"));
        assertEquals(expectedData.get("Amount entered"), actualData.get("Amount entered"));

    }
    @When("^I click the edit expenses for approval button$")
    public void clickEditExpensesForApprovalButton(){
        EXPENSES.clickEditExpensesForApprovalButton();
    }
    @When("^I click on my expense link with todays date$")
    public void clickLinkWithExpenseDate(){
        EXPENSES.clickLinkWithExpenseDate();
    }



}

