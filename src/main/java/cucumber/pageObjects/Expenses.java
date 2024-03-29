package cucumber.pageObjects;

import cucumber.testdata.DatabaseTester;
import org.apache.log4j.Logger;
import org.openqa.selenium.*;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
    @FindBy(xpath = "//*[@id=\"submitExpensesForm\"]/div[2]/div/table")
    public WebElement unpaidExpenseTable;

    @FindBy(xpath = "//*[@id=\"submitExpensesForm\"]/div[2]/div/table/tbody/tr[1]/td[3]")
    public WebElement auditReport;

    @FindBy(xpath = "//*[@id=\"submitExpensesForm\"]/div[2]/div/table/tbody/tr[2]/td[3]")
    public WebElement attendanceTotalExpenseTable;

    @FindBy(xpath = "//*[@id=\"submitExpensesForm\"]/div[2]/div/table/tbody/tr[2]/td[4]")
    public WebElement lossOfEarningsTotalExpenseTable;

    @FindBy(xpath = "//*[@id=\"submitExpensesForm\"]/div[2]/div/table/tbody/tr[2]/td[5]")
    public WebElement extraCareTotalExpenseTable;

    @FindBy(xpath = "//*[@id=\"submitExpensesForm\"]/div[2]/div/table/tbody/tr[2]/td[6]")
    public WebElement otherTotalExpenseTable;

    @FindBy(xpath = "//*[@id=\"submitExpensesForm\"]/div[2]/div/table/tbody/tr[2]/td[7]")
    public WebElement transportTotalExpenseTable;

    @FindBy(xpath = "//*[@id=\"submitExpensesForm\"]/div[2]/div/table/tbody/tr[2]/td[8]")
    public WebElement taxiTotalExpenseTable;

    @FindBy(xpath = "//*[@id=\"submitExpensesForm\"]/div[2]/div/table/tbody/tr[2]/td[9]")
    public WebElement motorcycleTotalExpenseTable;
    @FindBy(xpath = "//*[@id=\"submitExpensesForm\"]/div[2]/div/table/tbody/tr[2]/td[10]")
    public WebElement carTotalExpenseTable;

    @FindBy(xpath = "//*[@id=\"submitExpensesForm\"]/div[2]/div/table/tbody/tr[2]/td[11]")
    public WebElement bicycleTotalExpenseTable;

    @FindBy(xpath = "//*[@id=\"submitExpensesForm\"]/div[2]/div/table/tbody/tr[2]/td[12]")
    public WebElement parkingTotalExpenseTable;

    @FindBy(xpath = "//*[@id=\"submitExpensesForm\"]/div[2]/div/table/tbody/tr[2]/td[13]")
    public WebElement foodAndDrinkTotalExpenseTable;

    @FindBy(xpath = "//*[@id=\"submitExpensesForm\"]/div[2]/div/table/tbody/tr[2]/td[14]")
    public WebElement smartCardTotalExpenseTable;

    @FindBy(xpath = "//*[@id=\"submitExpensesForm\"]/div[2]/div/table/tbody/tr[2]/td[15]")
    public WebElement methodTotalExpenseTable;

    @FindBy(xpath = "//*[@id=\"submitExpensesForm\"]/div[2]/div/table/tbody/tr[2]/td[16]")
    public WebElement fullTotalTotalExpenseTable;

    @FindBy(xpath = "//*[@id=\"submitExpensesForm\"]/div[2]/div/table/tbody/tr[2]/td[4]")
    public WebElement attendanceTotalApproveExpenseTable;
    @FindBy(xpath = "//*[@id=\"submitExpensesForm\"]/div[2]/div/table/tbody/tr[2]/td[5]")
    public WebElement financialLossTotalApproveExpenseTable;

    @FindBy(xpath = "//*[@id=\"submitExpensesForm\"]/div[2]/div/table/tbody/tr[2]/td[6]")
    public WebElement travelTotalApproveExpenseTable;

    @FindBy(xpath = "//*[@id=\"submitExpensesForm\"]/div[2]/div/table/tbody/tr[2]/td[7]")
    public WebElement foodAndDrinkTotalApproveExpenseTable;

    @FindBy(xpath = "//*[@id=\"submitExpensesForm\"]/div[2]/div/table/tbody/tr[2]/td[8]")
    public WebElement smartcardTotalApproveExpenseTable;

    @FindBy(xpath = "//*[@id=\"submitExpensesForm\"]/div[2]/div/table/tbody/tr[2]/td[9]")
    public WebElement totalDueTotalApproveExpenseTable;
    @FindBy(id = "totalInDraftTag-link")
    public WebElement viewDraftExpensesLink;
    @FindBy(id = "totalForApprovalTag-link")
    public WebElement viewApprovalExpensesLink;
    @FindBy(id = "totalForApprovedTag-link")
    public WebElement viewApprovedExpensesLink;
    @FindBy(id = "nonAttendanceDayButton")
    public WebElement clickNonAttendanceDayButton;
    @FindBy(id = "check-all-expenses")
    public WebElement clickCheckAllExpensesCheckbox;
    @FindBy(id = "addSmartCardSpendButton")
    public WebElement clickAddSmartcardSpendButton;
    @FindBy(id = "smartcardAmount")
    public WebElement setSmartcardSpendField;
    @FindBy(xpath = "//*[@id=\"main-content\"]/div/div/form/div[2]/button")
    public WebElement clickAddSmartcardSpendSubmitButton;


    public void pressViewAllExpensesButton() {
        viewAllExpensesButton.click();
    }

    public void pressChangeDefaultExpensesButton() {
        changeDefaultExpensesButton.click();
    }

    public void pressChangeJurorBankDetailsButton() {
        changeJurorBankDetailsButton.click();
    }

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

    public void clickFoodAndDrinkRadioButton() {
        foodAndDrinkRadioButton.click();
    }

    public void setSmartCardField(String cardNumber) {
        smartCardField.clear();
        smartCardField.sendKeys(cardNumber);
    }

    public void setApplyToAllDraftCheckbox() {
        applyToAllDraftCheckbox.click();
    }

    public boolean unpaidExpensesTable() {
        return unpaidExpenseTable.isDisplayed();
    }

    public Map<String, String> getUnpaidAttendanceDetails() {
        Map<String, String> details = new HashMap<>();

        WebElement table = driver.findElement(By.xpath("//*[@id='submitExpensesForm']/div[2]/div/table"));
        for (WebElement row : table.findElements(By.tagName("tr"))) {
            for (WebElement ignored : row.findElements(By.tagName("td"))) {

                details.put("attendance", attendanceTotalExpenseTable.getText());
                details.put("lossOfEarnings", lossOfEarningsTotalExpenseTable.getText());
                details.put("extraCare", extraCareTotalExpenseTable.getText());
                details.put("other", otherTotalExpenseTable.getText());
                details.put("transport", transportTotalExpenseTable.getText());
                details.put("taxi", taxiTotalExpenseTable.getText());
                details.put("motorcycle", motorcycleTotalExpenseTable.getText());
                details.put("car", carTotalExpenseTable.getText());
                details.put("bicycle", bicycleTotalExpenseTable.getText());
                details.put("parking", parkingTotalExpenseTable.getText());
                details.put("foodAndDrink", foodAndDrinkTotalExpenseTable.getText());
                details.put("smartCard", smartCardTotalExpenseTable.getText());
                details.put("method", methodTotalExpenseTable.getText());
                details.put("total", fullTotalTotalExpenseTable.getText());

                return details;
            }
        }
        return details;
    }

    public void checkCheckboxWithExpenseDate() {

        LocalDate today = LocalDate.now();
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
        String formattedDate = today.format(formatter);

        try {
            String checkboxXPath = "//input[@type='checkbox' and @value='" + formattedDate + "']";

            WebElement checkbox = driver.findElement(By.xpath(checkboxXPath));

            if (!checkbox.isSelected()) {
                checkbox.click();
                log.info("Clicked on checkbox for today's date: " + formattedDate);
            } else {
                log.info("Checkbox for today's date (" + formattedDate + ") already checked.");
            }
        } catch (NoSuchElementException e) {
            log.error("Checkbox for today's date (" + formattedDate + ") not found.");
        } catch (Exception e) {
            log.error("Error occurred while processing checkbox for today's date (" + formattedDate + "): " + e.getMessage());
        }
    }

    public Map<String, String> getApproveExpenseDetails() {
        Map<String, String> details = new HashMap<>();

        WebElement table = driver.findElement(By.xpath("//*[@id='submitExpensesForm']/div[2]/div/table"));
        for (WebElement row : table.findElements(By.tagName("tr"))) {
            for (WebElement ignored : row.findElements(By.tagName("td"))) {

                details.put("attendance", attendanceTotalApproveExpenseTable.getText());
                details.put("financialLoss", financialLossTotalApproveExpenseTable.getText());
                details.put("travel", travelTotalApproveExpenseTable.getText());
                details.put("foodAndDrink", foodAndDrinkTotalApproveExpenseTable.getText());
                details.put("smartCard", smartcardTotalApproveExpenseTable.getText());
                details.put("totalDue", totalDueTotalApproveExpenseTable.getText());
                return details;
            }
        }
        return details;
    }

    public void auditReportDisplayedInTable() {
        LocalDate today = LocalDate.now();
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("EEE d MMM yyyy");
        String todayString = today.format(formatter);

        WebElement table = driver.findElement(By.id("submitExpensesForm"));
        List<WebElement> rows = table.findElements(By.tagName("tr"));
        for (WebElement row : rows) {
            List<WebElement> cells = row.findElements(By.tagName("td"));
            if (cells.size() > 1) {
                WebElement dateCell = cells.get(1);
                String dateText = dateCell.getText();
                if (dateText.equals(todayString)) {
                    WebElement auditReportElement = row.findElement(By.tagName("a"));
                    if (auditReportElement != null && auditReportElement.isDisplayed()) {
                        System.out.println("Audit Report is Displayed.");
                        break;
                    } else {
                        System.out.println("Audit Report is not Displayed.");
                    }
                }
            }
        }
    }
    public void clickViewDraftExpensesLink() {viewDraftExpensesLink.click();}
    public void clickViewApprovalExpensesLink() {viewApprovalExpensesLink.click();}
    public void clickViewApprovedExpensesLink() {viewApprovedExpensesLink.click();}
    public void clickNonAttendanceDayButton() {clickNonAttendanceDayButton.click();}
    public void clickCheckAllExpensesCheckbox() {clickCheckAllExpensesCheckbox.click();}
    public void clickAddSmartcardSpendButton() {clickAddSmartcardSpendButton.click();}
    public void setSmartcardSpendField(String amount) {
        setSmartcardSpendField.clear();
        setSmartcardSpendField.sendKeys(amount);
    }
    public void clickAddSmartcardSpendSubmitButton() {clickAddSmartcardSpendSubmitButton.click();}

}
