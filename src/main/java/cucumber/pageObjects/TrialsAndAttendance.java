package cucumber.pageObjects;

import cucumber.utils.WaitUtil_v2;
import cucumber.utils.WaitUtils;
import org.apache.log4j.Logger;
import org.junit.Assert;
import org.openqa.selenium.*;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;

import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.YearMonth;
import java.time.format.DateTimeFormatter;
import java.util.*;
import java.util.NoSuchElementException;

public class TrialsAndAttendance {

    private static WebDriver driver;
    private static final Logger log = Logger.getLogger(TrialsAndAttendance.class);

    private WaitUtils wait;
    private WaitUtil_v2 wait1;
    private NavigationShared NAV;
    private Header HEADER_PAGE;

    public TrialsAndAttendance(WebDriver driver) {
        TrialsAndAttendance.driver = driver;
        PageFactory.initElements(driver, this);
        wait = new WaitUtils(driver);
        wait1 = new WaitUtil_v2(driver);
        NAV = new NavigationShared(driver);
        HEADER_PAGE = PageFactory.initElements(driver, Header.class);
    }

    @FindBy(xpath = "//*[@id=\"main-content\"]/div[2]/div/dl/div[1]/dd")
    WebElement defendantName;

    @FindBy(xpath = "//*[@id=\"main-content\"]/div[2]/div/dl/div[2]/dd")
    WebElement trialType;

    @FindBy(xpath = "//*[@id=\"main-content\"]/div[2]/div/dl/div[3]/dd")
    WebElement trialStartDate;

    @FindBy(xpath = "//*[@id=\"main-content\"]/div[2]/div/dl/div[4]/dd")
    WebElement judgeSelected;

    @FindBy(xpath = "//*[@id=\"main-content\"]/div[2]/div/dl/div[5]/dd")
    WebElement courtRoom;

    @FindBy(xpath = "//*[@id=\"main-content\"]/div[2]/div/dl/div[6]/dd")
    WebElement trialProtection;

    @FindBy(xpath = "//input[@name='selectedPools']")
    WebElement poolNumberCheckbox;

    @FindBy(id = "numberOfJurors")
    WebElement enterNoOfJurorsForPanel;

    @FindBy(id = "checkInTimeHour")
    static WebElement confirmAttendanceCheckInHour;

    @FindBy(id = "checkInTimeMinute")
    static WebElement confirmAttendanceCheckInMinute;

    @FindBy(id = "checkInTime-am")
    WebElement confirmAttendanceCheckInRadioButtonAm;

    @FindBy(id = "checkInTime-pm")
    WebElement confirmAttendanceCheckInRadioButtonPm;

    @FindBy(id = "checkOutTimeHour")
    static WebElement confirmAttendanceCheckOutHour;

    @FindBy(id = "checkOutTimeMinute")
    static WebElement confirmAttendanceCheckOutMinute;

    @FindBy(id = "checkOutTime-am")
    WebElement confirmAttendanceCheckOutRadioButtonAm;

    @FindBy(id = "checkOutTime-pm")
    WebElement confirmAttendanceCheckOutRadioButtonPm;

    @FindBy(xpath = "//a[text()[contains(.,'Confirm attendance')]]")
    static WebElement confirmAttendanceButton;

    @FindBy(xpath = "//*[@id=\"main-content\"]/div[4]/div/dl/div[2]/dd")
    WebElement jurorAttendances;

    @FindBy(xpath = "//*[@id=\"main-content\"]/div[4]/div/dl/div[3]/dd[1]")
    WebElement jurorAbsences;

    @FindBy(xpath = "//th[@class=\"govuk-table__header jd-middle-align\"]/button")
    public List<WebElement> headerTableName;

    @FindBy(xpath = "//div[@class=\"govuk-button-group mod-flex mod-justify-end\"]/a")
    public List<WebElement> trialManagementButtonName;

    @FindBy(id = "returnPanelButton")
    WebElement trialManagementBtnReturnPanelnumber;

    @FindBy(xpath = "//div[@class=\"govuk-grid-column-one-half trial-detail__header\"]/div/h1")
    WebElement trialHeaderNumber;
    @FindBy(xpath = "//div[@class=\"govuk-grid-column-one-half trial-detail__header\"]/div/strong")
    WebElement trialStatus;

    @FindBy(xpath = "//div[@class=\"govuk-grid-column-one-half\"]/span[1]")
    WebElement jurorsWaitingLabelText;

    @FindBy(xpath = "//div[@class=\"govuk-grid-column-full\"]/strong")
    WebElement unConfiredSatusLabelText;

    @FindBy(xpath = "//div[@class=\"govuk-form-group\"]/fieldset/legend")
    WebElement recordAttendenceLabelText;
    @FindBy(xpath = "//div[@class=\"govuk-grid-column-full\"]/strong")
    WebElement confirmedLabelText;

    @FindBy(xpath = "//span[@class=\"govuk-caption-l\"]")
    WebElement changeTimeAttendenceTextLabel;

    @FindBy(xpath = "//h1[@class=\"govuk-heading-l\"]")
    WebElement changeTimeAttendenceJurorNameTextLabel;

    @FindBy(xpath = "//div[@class=\"govuk-form-group\"]/fieldset/legend")
    public List<WebElement> changeTimeEnterCheckInAndsCheckoutTimeTextLabel;

    @FindBy(xpath = "//div[@class=\"govuk-summary-list__row\"]/dt[1]")
    public List<WebElement> trialManagemntLabeltext;

    @FindBy(xpath = "//div[@class=\"govuk-summary-list__row govuk-summary-list__row--no-actions\"]//dd[@class=\"govuk-summary-list__value\"]")
    public List<WebElement> courtAttendanceTime;

    @FindBy(id = "attendanceDate")
    WebElement nextDueAtCourt;

    @FindBy(xpath = "//*[@id=\"failed-to-attend\"]")
    WebElement failedToAttendCheckbox;

    @FindBy(id = "checkInJurorNumber")
    WebElement checkInJuror;

    @FindBy(id = "checkOutJurorNumber")
    WebElement checkOutJuror;

    @FindBy(id = "selectedGroupsTable")
    WebElement selectedGroupsTable;
    @FindBy(id = "checkOutTime-am")
    List<WebElement> checkboxCheckAM;
    @FindBy(id = "checkOutTime-pm")
    List<WebElement> checkboxCheckPM;

    @FindBy(id = "checkOutTimeHour")
    WebElement selectchangeTimeCheckoutHour;

    @FindBy(id = "checkOutTimeMinute")
    WebElement selectchangeTimeCheckoutMinute;

    @FindBy(className = "govuk-pagination__next")
    WebElement nextPaginationLink;

    @FindBy(className = "govuk-summary-list__value")
    List<WebElement> absenceCountValue;

    @FindBy(xpath = "//div/strong[@class='govuk-tag mod-tag--dark-blue']")
    static WebElement lockedFlag;

    @FindBy(id = "searchTrialNumber")
    WebElement searchTrialNumberInput;

    @FindBy(id = "search-trials-button")
    WebElement searchTrialButton;

    @FindBy(id = "selectAllCheckbox")
    WebElement selectAllCheckbox;

    public Map<String, String> getTrialDetails() {
        Map<String, String> details = new HashMap<>();

        details.put("defendantName", defendantName.getText());
        details.put("trialType", trialType.getText());
        details.put("judgeSelected", judgeSelected.getText());
        details.put("courtRoom", courtRoom.getText());
        details.put("trialProtection", trialProtection.getText());

        return details;
    }

    public void checkPoolNumberCheckbox() {
        log.info("Clicked pool number checkbox");
        poolNumberCheckbox.sendKeys(Keys.SPACE);
    }

    public void checkPoolNumberCheckboxFor(String poolNumber) {
        try {
            log.info("Attempting to click pool number checkbox for: " + poolNumber + " using JavaScript executor.");
            WebElement checkbox = driver.findElement(By.id("select-" + poolNumber));
            ((JavascriptExecutor) driver).executeScript("arguments[0].click();", checkbox);
            log.info("Clicked pool number checkbox for: " + poolNumber + " using JavaScript executor.");
        } catch (Exception e) {
            log.error("Failed to click pool number checkbox for: " + poolNumber + " using JavaScript executor: " + e.getMessage());
            throw new RuntimeException("Unable to click pool number checkbox for: " + poolNumber);
        }
    }

    public void jurorsForPanel(String noOfJurors) {
        enterNoOfJurorsForPanel.clear();
        enterNoOfJurorsForPanel.sendKeys(noOfJurors);
    }

    public void jurorCheckInMinute(String checkInTime) {
        confirmAttendanceCheckInMinute.clear();
        confirmAttendanceCheckInMinute.sendKeys(checkInTime);
    }

    public void jurorCheckInHour(String checkInTime) {
        confirmAttendanceCheckInHour.clear();
        confirmAttendanceCheckInHour.sendKeys(checkInTime);
    }

    public void jurorCheckInRadioButtonAm() {
        confirmAttendanceCheckInRadioButtonAm.click();
    }

    public void jurorCheckInRadioButtonPm() {
        confirmAttendanceCheckInRadioButtonPm.click();
    }

    public void jurorCheckOutMinute(String checkOutTime) {
        confirmAttendanceCheckOutMinute.clear();
        confirmAttendanceCheckOutMinute.sendKeys(checkOutTime);
    }

    public void jurorCheckOutHour(String checkOutTime) {
        confirmAttendanceCheckOutHour.clear();
        confirmAttendanceCheckOutHour.sendKeys(checkOutTime);
    }

    public void jurorCheckOutRadioButtonAm() {
        confirmAttendanceCheckOutRadioButtonAm.click();
    }

    public void jurorCheckOutRadioButtonPm() {
        confirmAttendanceCheckOutRadioButtonPm.click();
    }

    public void selectStatusForEmpanelledJuror(String formId, String jurorNumber, String status) {
        String radioButtonXPath = "//form[@id='" + formId + "']//input[@name='" + jurorNumber + "' and @value='" + status + "']";
        try {
            WebElement radioButton = driver.findElement(By.xpath(radioButtonXPath));
            radioButton.click();

            log.info("Selected radio button with name '" + jurorNumber + "' and value '" + status + "'");
        } catch (NoSuchElementException e) {
            log.error("Radio button with name '" + jurorNumber + "' and value '" + status + "' not found");
        }
    }

    public void tabPresent(final String tabName) {
        log.info("Checking tab is present and correct");
        verifyHeaderTabAndLabels(tabName);
    }

    public Map<String, String> getAttendanceDetails() {
        Map<String, String> details = new HashMap<>();
        details.put("Attendances", jurorAttendances.getText());
        details.put("Absences", jurorAbsences.getText());
        return details;
    }

    public void verifyHeaderTabAndLabels(final String tabName) {
        log.info("Clicking tab");
        switch (tabName) {
            case "Juror number":
                Assert.assertTrue("Expected Text not found", headerTableName.get(0).getText().equals(tabName));
                log.info(" Text - " + headerTableName.get(0).getText() + " - is visible on the page ");
                break;
            case "First name":
                Assert.assertTrue("Expected Text not found", headerTableName.get(1).getText().equals(tabName));
                log.info(" Text - " + headerTableName.get(1).getText() + " - is visible on the page ");
                break;
            case "Last name":
                Assert.assertTrue("Expected Text not found", headerTableName.get(2).getText().equals(tabName));
                log.info(" Text - " + headerTableName.get(2).getText() + " - is visible on the page ");
                break;
            case "Status":
                Assert.assertTrue("Expected Text not found", headerTableName.get(3).getText().equals(tabName));
                log.info(" Text - " + headerTableName.get(3).getText() + " - is visible on the page ");
                break;
            case "Checked in":
                Assert.assertTrue("Expected Text not  found", headerTableName.get(4).getText().equals(tabName));
                log.info(" Text - " + headerTableName.get(4).getText() + " - is visible on the page ");
                break;
            case "Checked out":
                Assert.assertTrue("Expected Text not found", headerTableName.get(5).getText().equals(tabName));
                log.info(" Text - " + headerTableName.get(5).getText() + " - is visible on the page ");
                break;
            case "Defendants":
                Assert.assertTrue("Expected Text not found", trialManagemntLabeltext.get(0).getText().equals(tabName));
                log.info(" Text - " + trialManagemntLabeltext.get(0).getText() + " - is visible on the page ");
                break;
            case "Trial type":
                Assert.assertTrue("Expected Text not found", trialManagemntLabeltext.get(1).getText().equals(tabName));
                log.info(" Text - " + trialManagemntLabeltext.get(1).getText() + " - is visible on the page ");
                break;
            case "Trial start date":
                Assert.assertTrue("Expected Text not found", trialManagemntLabeltext.get(2).getText().equals(tabName));
                log.info(" Text - " + trialManagemntLabeltext.get(2).getText() + " - is visible on the page ");
                break;
            case "Judge":
                Assert.assertTrue("Expected Text not found", trialManagemntLabeltext.get(3).getText().equals(tabName));
                log.info(" Text - " + trialManagemntLabeltext.get(3).getText() + " - is visible on the page ");
                break;
            case "Courtroom":
                Assert.assertTrue("Expected Text not found", trialManagemntLabeltext.get(4).getText().equals(tabName));
                log.info(" Text - " + trialManagemntLabeltext.get(4).getText() + " - is visible on the page ");
                break;
            case "Protected?":
                Assert.assertTrue("Expected Text not found", trialManagemntLabeltext.get(5).getText().equals(tabName));
                log.info(" Text - " + trialManagemntLabeltext.get(5).getText() + " - is visible on the page ");
                break;
            case "Print panel list":
                Assert.assertTrue("Expected Text not found", trialManagementButtonName.get(0).getText().equals(tabName));
                log.info(" Text - " + trialManagementButtonName.get(0).getText() + " - is visible on the page ");
                break;
            case "Print ballot cards":
                Assert.assertTrue("Expected Text not found", trialManagementButtonName.get(1).getText().equals(tabName));
                log.info(" Text - " + trialManagementButtonName.get(1).getText() + " - is visible on the page ");
                break;
            case "Empanel jury":
                Assert.assertTrue("Expected Text not found", trialManagementButtonName.get(2).getText().equals(tabName));
                log.info(" Text - " + trialManagementButtonName.get(2).getText() + " - is visible on the page ");
                break;
            case "End trial":
                Assert.assertTrue("Expected Text not found", trialManagementButtonName.get(3).getText().equals(tabName));
                log.info(" Text - " + trialManagementButtonName.get(3).getText() + " - is visible on the page ");
                break;
            case "Return panel members":
                Assert.assertTrue("Expected Text not found", trialManagementBtnReturnPanelnumber.getText().equals(tabName));
                log.info(" Text - " + trialManagementBtnReturnPanelnumber.getText() + " - is visible on the page ");
                break;
            case "Active":
                Assert.assertTrue("Expected Text not found", trialStatus.getText().equals(tabName));
                log.info(" Text - " + trialStatus.getText() + " - is visible on the page ");
                break;
            case "Trial Number":
                Assert.assertTrue("Expected Text not found", trialHeaderNumber.getText().equals(tabName));
                log.info(" Text - " + trialHeaderNumber.getText() + " - is visible on the page ");
                break;
            case "Jurors in waiting":
                Assert.assertTrue("Expected Text not found", jurorsWaitingLabelText.getText().equals(tabName));
                log.info(" Text - " + jurorsWaitingLabelText.getText() + " - is visible on the page ");
                break;
            case "UNCONFIRMED":
                Assert.assertTrue("Expected Text not found", unConfiredSatusLabelText.getText().equals(tabName));
                log.info(" Text - " + unConfiredSatusLabelText.getText() + " - is visible on the page ");
                break;
            case "Record attendance":
                Assert.assertTrue("Expected Text not found", recordAttendenceLabelText.getText().equals(tabName));
                log.info(" Text - " + recordAttendenceLabelText.getText() + " - is visible on the page ");
                break;
            case "CONFIRMED":
                Assert.assertTrue("Expected Text not found", confirmedLabelText.getText().equals(tabName));
                log.info(" Text - " + confirmedLabelText.getText() + " - is visible on the page ");
                break;
            case "Attendance":
                Assert.assertTrue("Expected Text not found", changeTimeAttendenceTextLabel.getText().equals(tabName));
                log.info(" Text - " + changeTimeAttendenceTextLabel.getText() + " - is visible on the page ");
                break;

            case "name":
                Assert.assertTrue("Expected Text not found", changeTimeAttendenceJurorNameTextLabel.getText().equals(tabName));
                log.info(" Text - " + changeTimeAttendenceJurorNameTextLabel.getText() + " - is visible on the page ");
                break;

            case "Enter check in time":
                Assert.assertTrue("Expected Text not found", changeTimeEnterCheckInAndsCheckoutTimeTextLabel.get(0).getText().equals(tabName));
                log.info(" Text - " + changeTimeEnterCheckInAndsCheckoutTimeTextLabel.get(0).getText() + " - is visible on the page ");
                break;
            case "Enter check out time":
                Assert.assertTrue("Expected Text not found", changeTimeEnterCheckInAndsCheckoutTimeTextLabel.get(1).getText().equals(tabName));
                log.info(" Text - " + changeTimeEnterCheckInAndsCheckoutTimeTextLabel.get(1).getText() + " - is visible on the page ");
                break;

            default:
                log.info("Expected element text is not present on the page");
                break;
        }

    }

    public String getNewAttendanceTime() {
        log.info("Getting attendance time");
        return courtAttendanceTime.get(2).getText();
    }

    public void enterNextDueAtCourt(String date) {
        nextDueAtCourt.clear();
        nextDueAtCourt.sendKeys(date);
    }

    public void checkFailedToAttendBox() {
        failedToAttendCheckbox.click();
    }

    public void failedToAttendRadioButtonNotOnScreen() {
        List<WebElement> elements = driver.findElements(By.xpath("//*[contains(text(),'Change juror status to')]"));

        if (!elements.isEmpty()) {
            throw new IllegalStateException("Failed to attend radio button found on screen");
        }
    }

    public void jurorCheckIn(String checkIn) {
        checkInJuror.clear();
        checkInJuror.sendKeys(checkIn);
    }

    public void jurorCheckOut(String checkIn) {
        checkOutJuror.clear();
        checkOutJuror.sendKeys(checkIn);
    }

    public void setRecordAttendnceChangeTimeTextbox(String selection, String data) {

        switch (selection) {
            case "Hour":
                log.info("clicking the check out hour ");
                selectchangeTimeCheckoutHour.clear();
                selectchangeTimeCheckoutHour.sendKeys(data);
                break;

            case "Minute":
                log.info("clicking the check out minute");
                selectchangeTimeCheckoutMinute.clear();
                selectchangeTimeCheckoutMinute.sendKeys(data);
                break;

            default:
                log.info("Expected textbox is not available ");
        }

    }

    public void click_CheckoutRadioButton(String selection) throws Exception {
        log.info("Clicked on radio button which contained text =>" + selection);

        switch (selection) {
            case "am":
                driver.findElements(By.id("checkOutTime-am")).get(0).click();
                log.info("checked the checkbox named label AM");
                break;

            case "pm":
                driver.findElements(By.id("checkOutTime-pm")).get(0).click();
                ;
                log.info("checked the checkbox named label PM");
                break;

            default:
                log.info("Expected checkbox is not clicked");
        }
    }


    public void clickNextPagination() {
        nextPaginationLink.click();
    }

    public void clickActiveTrialNumber(String trial_no) {
        log.info("Finding and clicking active trial number");
        boolean lastPage = false;
        while (!lastPage) {
            List<WebElement> activeTrialLink = driver.findElements(By.xpath("//*[contains(text(),'" + trial_no + "')]"));
            if (activeTrialLink.size() >= 1) {
                activeTrialLink.get(0).click();
                break;
            } else {
                if (driver.findElements(By.className("govuk-pagination__next")).size() < 1) {
                    lastPage = true;
                } else {
                    log.info("Clicking next pagination");
                    clickNextPagination();
                }
            }
        }
    }

    public void clickTrialRadioButton(String trialNumber) {
        WebElement trialRadioButton = driver.findElement(By.xpath("//input[@type='radio' and @value='" + trialNumber + "']"));
        trialRadioButton.click();
    }

    public String dismissedBanner() {
        String bannerText = NAV.messageBanner.getText();
        System.out.println("Message Sent Banner Text: " + bannerText);
        return bannerText;
    }

    public void clickAvailableJurorsButton() {
        WebElement availableJurorsButton = driver.findElement(By.xpath("//button[normalize-space()='Calculate available jurors']"));
        availableJurorsButton.click();
    }

    public void verifyAbsenceCount(String absenceNumber) {
        boolean absenceCount = false;
        String Count = absenceCountValue.get(2).getText();
        if (Count.equals(absenceNumber)) {
            log.info("verified absence count is expected value on attendance screen");
            absenceCount = true;
        } else {
            throw new AssertionError("Absence count is wrong as expected");

        }
    }

    public void clickPreviousAttendanceLink() {
        WebElement link = driver.findElement(By.xpath("//html/body/div[4]/div/a"));
        link.click();
    }


    public boolean verifyAttendanceDateAfterClicks(int daysInPast) {

        Calendar calendar = Calendar.getInstance();
        calendar.add(Calendar.DAY_OF_YEAR, -daysInPast);
        SimpleDateFormat formatter = new SimpleDateFormat("EEEE d MMMM yyyy", Locale.ENGLISH);
        String targetDate = formatter.format(calendar.getTime());

        System.out.println("Target date (expected): " + targetDate);

        WebElement attendanceDateElement = driver.findElement(By.id("attendanceDate"));
        String displayedDate = attendanceDateElement.getText().trim();

        System.out.println("Displayed date: " + displayedDate);
        return displayedDate.equals(targetDate);
    }

    public void selectTrialNumberRadioButton(String trialNumber) {
        String radioButtonXPath = "//input[@type='radio' and @id='" + trialNumber + "']";
        try {
            WebElement radioButton = driver.findElement(By.xpath(radioButtonXPath));
            radioButton.click();

            System.out.println("Selected radio button with: " + trialNumber);
        } catch (NoSuchElementException e) {
            log.error("Radio button with name '" + trialNumber + "'  not found");
        }
    }

    public void selectCheckboxInDismissTable(String poolNumber) {
        log.info("Finding and selecting checkbox in table for pool number: " + poolNumber);
        boolean lastPage = false;
        JavascriptExecutor js = (JavascriptExecutor) driver;

        while (!lastPage) {
            List<WebElement> checkboxLabel = driver.findElements(By.xpath("//label[@for='pool-" + poolNumber + "']"));
            if (checkboxLabel.size() >= 1) {
                WebElement checkbox = checkboxLabel.get(0);
                js.executeScript("arguments[0].click();", checkbox);
                log.info("Checkbox for pool " + poolNumber + " selected using JavascriptExecutor.");
                break;
            } else {
                if (driver.findElements(By.className("govuk-pagination__next")).size() < 1) {
                    lastPage = true;
                    log.warn("Checkbox for pool " + poolNumber + " not found in any page.");
                } else {
                    log.info("Clicking next pagination");
                    clickNextPagination();
                }
            }
        }
    }

    public static void seeConfirmedAttendanceStatusForJuror(String juror, String confirmedStatus) {
        driver.findElement(
                By.xpath(
                        "//td[@id='" + juror + "-confirmed' and normalize-space(text()) ='" + confirmedStatus + "']"));
        log.info("Found =>" + confirmedStatus + "<= confirmed attendance status for juror  =>" + juror + "<= as expected");

    }
    public static String checkLockedFlag() {
        return lockedFlag.getText();
    }

    public static boolean confirmAttendanceButtonIsNotPresent() {
        List<WebElement> elements = driver.findElements(By.xpath("//a[text()[contains(.,'Confirm attendance')]]"));
        return elements.isEmpty();
    }

    public static String getCheckinHour() {
        log.info("Getting checkin time");
        return confirmAttendanceCheckInHour.getAttribute("value");
    }

    public static String getCheckinMinute() {
        log.info("Getting checkin time");
        return confirmAttendanceCheckInMinute.getAttribute("value");
    }

    public static String getCheckOutHour() {
        log.info("Getting checkout time");
        return confirmAttendanceCheckOutHour.getAttribute("value");
    }

    public static String getCheckOutMinute() {
        log.info("Getting checkout time");
        return confirmAttendanceCheckOutMinute.getAttribute("value");
    }

    public void searchForTrial(String trialNo) {
        searchTrialNumberInput.clear();
        searchTrialNumberInput.sendKeys(trialNo);
        searchTrialButton.click();
    }
    public String selectDateFromPast(int daysInPast) {
        try {
            LocalDate targetDate = LocalDate.now().minusDays(daysInPast);
            DateTimeFormatter readableFormatter = DateTimeFormatter.ofPattern("EEEE d MMMM yyyy", Locale.ENGLISH);
            String expectedDateText = targetDate.format(readableFormatter);

            log.info("Target date (" + daysInPast + " days ago): " + expectedDateText);

            WebElement calendarButton = driver.findElement(By.cssSelector(".js-calendar-button[data-button='datepicker-attendanceDateSelection-toggle']"));
            calendarButton.click();
            log.info("Opened calendar");

            Thread.sleep(300);

            DateTimeFormatter monthYearFormatter = DateTimeFormatter.ofPattern("MMMM yyyy", Locale.ENGLISH);
            YearMonth targetYM = YearMonth.from(targetDate);

            while (true) {
                WebElement monthYearElement = driver.findElement(By.cssSelector(".js-datepicker-month-year"));
                String visibleMonthYearText = monthYearElement.getText().toLowerCase();

                visibleMonthYearText = visibleMonthYearText.substring(0, 1).toUpperCase() + visibleMonthYearText.substring(1);
                YearMonth visibleYM = YearMonth.parse(visibleMonthYearText, monthYearFormatter);

                if (visibleYM.equals(targetYM)) break;

                if (visibleYM.isAfter(targetYM)) {
                    driver.findElement(By.cssSelector(".js-datepicker-prev-month")).click();
                } else {
                    driver.findElement(By.cssSelector(".js-datepicker-next-month")).click();
                }

                Thread.sleep(300);
            }

            String dayStr = String.valueOf(targetDate.getDayOfMonth());
            String xpath = "//button[@data-form='date-select' and not(@disabled) and contains(@style,'display: block') and text()='" + dayStr + "']";

            WebElement dayButton = driver.findElement(By.xpath(xpath));
            dayButton.click();
            log.info("Selected day: " + dayStr);

            List<WebElement> okButtons = driver.findElements(By.cssSelector(".js-datepicker-ok"));
            if (!okButtons.isEmpty()) {
                WebElement okButton = okButtons.get(0);
                if (okButton.isDisplayed() && okButton.isEnabled()) {
                    okButton.click();
                    log.info("Clicked 'Select' to confirm date");
                } else {
                    log.info("'Select' button found but not clickable, skipping.");
                }
            } else {
                log.info("No 'Select' button present — assuming date is auto-applied.");
            }

            return expectedDateText;

        } catch (Exception e) {
            log.error("Error selecting date: " + e.getMessage(), e);
            return "ERROR SELECTING DATE";
        }
    }

    public boolean verifyAttendanceDate(String expectedDateText) {
        try {
            if (expectedDateText.startsWith("ERROR")) {
                log.error("Skipping verification due to previous error: " + expectedDateText);
                return false;
            }

            WebElement attendanceDateElement = driver.findElement(By.id("attendanceDate"));
            String actualDateText = attendanceDateElement.getText();
            java.time.LocalDate expectedDate = null;
            java.time.LocalDate actualDate = null;

            try {
                java.time.format.DateTimeFormatter formatter = java.time.format.DateTimeFormatter.ofPattern("EEEE d MMMM yyyy", java.util.Locale.ENGLISH);
                expectedDate = java.time.LocalDate.parse(expectedDateText, formatter);

                String[] possibleFormats = {
                        "EEEE d MMMM yyyy",
                        "EEEE dd MMMM yyyy",
                        "EEEE d MMMM, yyyy",
                        "EEEE dd MMMM, yyyy"
                };

                for (String format : possibleFormats) {
                    try {
                        formatter = java.time.format.DateTimeFormatter.ofPattern(format, java.util.Locale.ENGLISH);
                        actualDate = java.time.LocalDate.parse(actualDateText, formatter);
                        break;
                    } catch (Exception e) {
                    }
                }
            } catch (Exception e) {
                log.error("Error parsing dates for comparison: " + e.getMessage());
            }
            if (expectedDate != null && actualDate != null) {
                boolean matches = expectedDate.equals(actualDate);
                if (matches) {
                    log.info("Attendance date verification successful (date objects match)");
                    return true;
                } else {
                    log.error("Attendance date verification failed. Expected: " + expectedDate + ", Actual: " + actualDate);
                }
            }
            boolean matches = actualDateText.equals(expectedDateText);
            if (matches) {
                log.info("Attendance date verification successful: " + actualDateText);
            } else {
                log.error("Attendance date verification failed. Expected: " + expectedDateText + ", Actual: " + actualDateText);
            }

            return matches;
        } catch (Exception e) {
            log.error("Error verifying attendance date: " + e.getMessage(), e);
            return false;
        }
    }

    public void selectAllOnTrial() {
        selectAllCheckbox.sendKeys(Keys.SPACE);
    }

}