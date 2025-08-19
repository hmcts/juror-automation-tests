package cucumber.pageObjects;

import cucumber.testdata.DatabaseTester;
import org.apache.log4j.Logger;
import org.openqa.selenium.*;
import org.openqa.selenium.NoSuchElementException;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import org.openqa.selenium.support.ui.ExpectedConditions;
import org.openqa.selenium.support.ui.WebDriverWait;

import java.text.SimpleDateFormat;
import java.time.Duration;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.*;

public class Expenses {
    private static WebDriver driver;
    private static final Logger log = Logger.getLogger(JurorRecord.class);
    private final DatabaseTester DBT;
    private NavigationShared NAV;

    public Expenses(WebDriver webDriver) {
        Expenses.driver = webDriver;
        PageFactory.initElements(webDriver, this);
        DBT = new DatabaseTester();
        NAV = PageFactory.initElements(webDriver, NavigationShared.class);

    }

    @FindBy(id = "viewAllExpensesAnchor")
    public WebElement viewAllExpensesButton;

    @FindBy(id = "changeDefaultExpensesAnchor")
    public WebElement changeDefaultExpensesButton;

    @FindBy(id = "changeJurorBankDetailsAnchor")
    public WebElement changeJurorBankDetailsButton;
    @FindBy(xpath = "//*[@id=\"addressChangeAnchor\"]")
    public WebElement changeJurorAddressButton;
    @FindBy(xpath = "//*[@id=\"notesChangeAnchor\"]")
    public WebElement changeJurorInternalNoteButton;

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

    @FindBy(xpath = "//*[@id='submitExpensesForm']/descendant::tr[@id='totals-row']/td[4]")
    public WebElement attendanceTotalApproveExpenseTable;
    @FindBy(xpath = "//*[@id='submitExpensesForm']/descendant::tr[@id='totals-row']/td[5]")
    public WebElement financialLossTotalApproveExpenseTable;

    @FindBy(xpath = "//*[@id='submitExpensesForm']/descendant::tr[@id='totals-row']/td[6]")
    public WebElement travelTotalApproveExpenseTable;

    @FindBy(xpath = "//*[@id='submitExpensesForm']/descendant::tr[@id='totals-row']/td[7]")
    public WebElement foodAndDrinkTotalApproveExpenseTable;

    @FindBy(xpath = "//*[@id='submitExpensesForm']/descendant::tr[@id='totals-row']/td[8]")
    public WebElement smartcardTotalApproveExpenseTable;

    @FindBy(xpath = "//*[@id='submitExpensesForm']/descendant::tr[@id='totals-row']/td[9]")
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

    @FindBy(xpath = "//*[@id=\"expenseDateLink\"]")
    public List <WebElement> clickNonAttendanceDayExpenseLink;

    @FindBy(xpath = "//div[@id=\"totalDueTag\"]/span[2]")
    public WebElement totalDueAmt;
    @FindBy(xpath = "//a[@id=\"recalculate-totals\"]")
    public WebElement clickRecalculateTotalLink;

    @FindBy(xpath = "//*[@id=\"expenseDateLink\"]")
    public WebElement clickExpenseDatelink;

    @FindBy(xpath = "//*[@class='govuk-summary-list__value']")
    public List <WebElement> jurorsFinancialLossAmt;

    @FindBy(xpath = "//*[@class='govuk-summary-list__value']")
    public List <WebElement> dailyLimitExpenseValue;

    @FindBy(xpath = "//*[@class='govuk-summary-list__value mod-red-text']")
    public List <WebElement> dailyLimitAmountEntered;

    @FindBy(xpath = "//*[@class=\"govuk-summary-list__value\"]")
    public List <WebElement> financialLossGetAmt;

    @FindBy(xpath = "//*[@id=\"editExpensesForApprovalButton\"]")
    public WebElement clickEditExpensesForApprovalButton;
    @FindBy(id = "totalApprovedTag-link")
    public WebElement totalApprovedLink;

    @FindBy(id = "saveAndNextButton")
    public WebElement saveAndNextButton;

    public void pressViewAllExpensesButton() {
        viewAllExpensesButton.click();
    }

    public void pressChangeDefaultExpensesButton() {
        changeDefaultExpensesButton.click();
    }

    public void pressChangeJurorBankDetailsButton() {
        changeJurorBankDetailsButton.click();
    }

    public void pressChangeJurorAddressButton() {
        changeJurorAddressButton.click();
    }

    public void pressChangeInternalNoteButton() {
        changeJurorInternalNoteButton.click();
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
                checkbox.sendKeys(Keys.SPACE);
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
    public void NonAttendencedayExpenseDate() {clickNonAttendanceDayExpenseLink.get(0).click();}
    public void clickRecalculateTotalLink() {
        JavascriptExecutor js = (JavascriptExecutor) driver;
        js.executeScript("window.scrollBy(0,350)", "");
        js.executeScript("arguments[0].click();", clickRecalculateTotalLink);
        // clickRecalculateTotalLink.click();}
    }

    public Map<String, String> getExpenseDetailAfterRecalculate() {
        Map<String, String> details = new HashMap<>();
        NAV.waitForPageLoad();
        details.put("Total due",totalDueAmt.getText().replaceAll("\\s", ""));
        System.out.println(totalDueAmt.getText());
                details.put("Financial loss (capped)", financialLossGetAmt.get(2).getText());
        System.out.println(financialLossGetAmt.get(2).getText());

        return details;
            }

    public void clickADraftExpensesTodaysDate() {
        clickExpenseDatelink.click();

    }
    public Map<String, String> getLossOverLimitDetails() {
        Map<String, String> details = new HashMap<>();

        details.put("Juror's loss", jurorsFinancialLossAmt.get(0).getText());
        details.put("Daily limit (Full day)", jurorsFinancialLossAmt.get(1).getText());
        return details;
    }
    public Map<String, String> getLossOverHalfDayLimitDetails() {
        Map<String, String> details = new HashMap<>();

        details.put("Juror's loss", jurorsFinancialLossAmt.get(0).getText());
        details.put("Daily limit (Half day)", jurorsFinancialLossAmt.get(1).getText());
        return details;
    }
    public Map<String, String> getTravelOverLimitDetails() {
        Map<String, String> details = new HashMap<>();
        details.put("Daily limit", dailyLimitExpenseValue.get(0).getText());
        details.put("Amount entered", dailyLimitAmountEntered.get(0).getText());
        System.out.println(dailyLimitAmountEntered.get(0).getText());
        System.out.println(dailyLimitExpenseValue.get(0).getText());
        return details;
    }

    public Map<String, String> getTaxiOverLimitDetails() {
        Map<String, String> details = new HashMap<>();
        details.put("Daily limit", dailyLimitExpenseValue.get(1).getText());
        details.put("Amount entered", dailyLimitAmountEntered.get(1).getText());
        return details;
    }
    public void clickEditExpensesForApprovalButton(){
        clickEditExpensesForApprovalButton.click();
    }
    public void clickLinkWithExpenseDate() {

        LocalDate today = LocalDate.now();
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("E dd MMM yyyy");
        String formattedDate = today.format(formatter);

        try {
            NAV.click_link_by_text(formattedDate);
        } catch (Exception e) {
            NAV.waitForPageLoad();
            NAV.click_link_by_text(formattedDate);
        }
    }

    public String getTextInRowWithDate(int numberOfDays, String timeFrame) {
        String DATE_PATTERN = "EEE dd MMM yyyy";
        Calendar calendar = Calendar.getInstance();

        if ("in the future".equalsIgnoreCase(timeFrame)) {
            calendar.add(Calendar.DAY_OF_MONTH, numberOfDays);
        } else if ("in the past".equalsIgnoreCase(timeFrame)) {
            calendar.add(Calendar.DAY_OF_MONTH, -numberOfDays);
        }

        Date adjustedDate = calendar.getTime();
        SimpleDateFormat dateFormat = new SimpleDateFormat(DATE_PATTERN, Locale.ENGLISH);
        String formattedDate = dateFormat.format(adjustedDate).trim();

        By tableLocator = By.className("govuk-table");

        try {
            WebDriverWait wait = new WebDriverWait(driver, Duration.ofSeconds(10));
            WebElement table = wait.until(ExpectedConditions.visibilityOfElementLocated(tableLocator));

            By dateRowLocator = By.xpath(".//tr[td/a[contains(text(), '" + formattedDate + "')]]");
            WebElement row = table.findElement(dateRowLocator);
            String rowText = row.getText().replace(formattedDate, "").trim();

            if (rowText.isEmpty()) {
                throw new RuntimeException("No text found in the row with the date '" + formattedDate + "'.");
            }

            return rowText;

        } catch (TimeoutException e) {
            throw new RuntimeException("No row with the date '" + formattedDate + "' was found or visible in time.", e);
        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException("Failed to retrieve text in the row with the date '" + formattedDate + "'.", e);
        }
    }

    public void totalApprovedLink() {
        totalApprovedLink.click();
    }

    public void checkCheckboxWithTodaysExpense() {

        LocalDate today = LocalDate.now();
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyyMMdd", Locale.ENGLISH);
        String formattedDate = today.format(formatter);

        String checkboxId = "expense-" + formattedDate;

        try {
            WebDriverWait wait = new WebDriverWait(driver, Duration.ofSeconds(10));
            WebElement checkbox = wait.until(ExpectedConditions.presenceOfElementLocated(By.id(checkboxId)));

            if (!checkbox.isSelected()) {
                JavascriptExecutor js = (JavascriptExecutor) driver;

                js.executeScript("arguments[0].scrollIntoView({block:'center'});", checkbox);

                js.executeScript("arguments[0].click();", checkbox);

                if (!checkbox.isSelected()) {
                    js.executeScript(
                            "arguments[0].checked = true;" +
                                    "arguments[0].dispatchEvent(new Event('input', {bubbles:true}));" +
                                    "arguments[0].dispatchEvent(new Event('change', {bubbles:true}));",
                            checkbox
                    );
                }

                log.info("Clicked on checkbox with id: " + checkboxId);
            } else {
                log.info("Checkbox with id (" + checkboxId + ") already checked.");
            }
        } catch (NoSuchElementException e) {
            log.error("Checkbox with id (" + checkboxId + ") not found.");
        } catch (Exception e) {
            log.error("Error occurred while processing checkbox with id (" + checkboxId + "): " + e.getMessage());
        }
    }

    public void pressSaveAndNextButton() {
        log.info("Clicking Save and Back button via JS");

        int maxRetries = 2;
        int retryCount = 0;
        StaleElementReferenceException lastException = null;

        while (retryCount < maxRetries) {
            try {
                JavascriptExecutor js = (JavascriptExecutor) driver;
                js.executeScript("arguments[0].scrollIntoView({block:'center'});", saveAndNextButton);
                js.executeScript("arguments[0].click();", saveAndNextButton);
                return;
            } catch (StaleElementReferenceException e) {
                lastException = e;
                retryCount++;

                log.warn("StaleElementReferenceException on pressSaveAndBackButton - attempt " + retryCount);

                if (retryCount == maxRetries) break;

                PageFactory.initElements(driver, this);

                try {
                    Thread.sleep(200);
                } catch (InterruptedException ie) {
                    Thread.currentThread().interrupt();
                }
            }
        }

        log.error("Failed to click Save and Back button due to stale element: " +
                (lastException != null ? lastException.getMessage() : "unknown error"));
        throw new RuntimeException("Unable to click Save and Back button after retries.");
    }
}