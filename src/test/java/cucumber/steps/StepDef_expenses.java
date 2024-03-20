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
}