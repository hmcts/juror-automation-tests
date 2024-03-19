package cucumber.pageObjects;

import cucumber.testdata.DatabaseTester;
import org.apache.log4j.Logger;
import org.openqa.selenium.*;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;

public class Expenses {
    private static WebDriver driver;
    private static final Logger log = Logger.getLogger(JurorRecord.class);
    private final DatabaseTester DBT;

    public Expenses(WebDriver webDriver) {
        Expenses.driver = webDriver;
        PageFactory.initElements(webDriver, this);
        DBT = new DatabaseTester();
    }
    @FindBy(id = "viewAllExpensesAnchor")
    public WebElement viewAllExpensesButton;

    @FindBy(id = "changeDefaultExpensesAnchor")
    public WebElement changeDefaultExpensesButton;

    @FindBy(id = "changeJurorBankDetailsAnchor")
    public WebElement changeJurorBankDetailsButton;

    @FindBy(id = "financialLoss")
    public WebElement financialLossField;

    @FindBy(id = "travelTime-hour")
    public WebElement travelTimeHourField;

    @FindBy(id = "travelTime-minute")
    public WebElement travelTimeMinuteField;

    @FindBy(id = "mileage")
    public WebElement mileageField;

    @FindBy(id = "foodAndDrink")
    public WebElement foodAndDrinkRadioButton;

    @FindBy(id = "applyToAllDraft")
    public WebElement applyToAllDraftCheckbox;

    @FindBy(id = "smartCard")
    public WebElement smartCardField;

    public void pressViewAllExpensesButton() {viewAllExpensesButton.click();}

    public void pressChangeDefaultExpensesButton() {changeDefaultExpensesButton.click();}

    public void pressChangeJurorBankDetailsButton() {changeJurorBankDetailsButton.click();}

    public void setFinancialLossField(String loss) {
        financialLossField.clear();
        financialLossField.sendKeys(loss);
    }
    public void setTimeTravelHoursField(String hours) {
        travelTimeHourField.clear();
        travelTimeHourField.sendKeys(hours);
    }
    public void setTimeTravelMinutesField(String minutes) {
        travelTimeMinuteField.clear();
        travelTimeMinuteField.sendKeys(minutes);
    }
    public void setMileageField(String milage) {
        mileageField.clear();
        mileageField.sendKeys(milage);
    }
    public void clickFoodAndDrinkRadioButton() {foodAndDrinkRadioButton.click();}
    public void setSmartCardField(String cardNumber) {
        smartCardField.clear();
        smartCardField.sendKeys(cardNumber);
    }
    public void setApplyToAllDraftCheckbox() {applyToAllDraftCheckbox.click();}
}
