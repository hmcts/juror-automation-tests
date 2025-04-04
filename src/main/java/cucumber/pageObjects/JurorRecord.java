package cucumber.pageObjects;


import cucumber.testdata.DatabaseTester;
import org.apache.log4j.Logger;
import org.junit.Assert;
import org.openqa.selenium.*;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import org.openqa.selenium.support.ui.WebDriverWait;

import java.text.SimpleDateFormat;
import java.time.Duration;
import java.util.*;


public class JurorRecord {

    private static WebDriver driver;
    private static final Logger log = Logger.getLogger(JurorRecord.class);
    private final DatabaseTester DBT;

    private NavigationShared NAV;

    public JurorRecord(WebDriver webDriver) {
        JurorRecord.driver = webDriver;
        PageFactory.initElements(webDriver, this);
        DBT = new DatabaseTester();
        NAV = new NavigationShared(driver);
    }

    @FindBy(className = "govuk-heading-l")
    WebElement heading;

    @FindBy(xpath = "//div/strong[@class='govuk-tag govuk-tag--turquoise']")
    WebElement jurorRecordTag;

    @FindBy(xpath = "//a[contains(@class, 'govuk-button') and normalize-space(text()) ='Enter summons reply']")
    WebElement enterSummonsReplyButton;

    @FindBy(xpath = "//*[contains(text(),'Update juror record')]")
    WebElement updateJurorRecordButton;

    @FindBy(id = "jurorNumber")
    WebElement jurorNumber;

    @FindBy(xpath = "//div[contains(text(),\"Juror status\")]/following-sibling::div")
    WebElement jurorStatus;

    @FindBy(id = "poolNumber")
    WebElement poolNumber;

    @FindBy(id = "courtStartDate")
    WebElement courtStartDate;

    @FindBy(id = "courtName")
    WebElement courtName;

    @FindBy(id = "main-content")
    WebElement mainBody;

    @FindBy(xpath = "//*[@id=\"jurorStatus\"]/span[@class='icon mod-icon-urgent']")
    WebElement jurorStatusWarningIcon;

    @FindBy(id = "overviewTab")
    WebElement overviewTab;

    @FindBy(id = "detailsTab")
    WebElement jurorDetailsTab;

    @FindBy(id = "summonsTab")
    WebElement summonsTab;

    @FindBy(xpath = "//dt[contains(text(),'Reply status')]/following-sibling::dd")
    WebElement replyStatus;

    @FindBy(xpath = "//dt[contains(text(),'Processing outcome')]/following-sibling::dd")
    WebElement processingOutcome;

    @FindBy(xpath = "//div[@id=\"jurorStatus\"]/span[@class=\"icon mod-icon-urgent\"]")
    WebElement processingOutcomeWarningIcon;

    @FindBy(xpath = "//dt[contains(text(),'Reply date')]/following-sibling::dd")
    WebElement replyDate;

    @FindBy(xpath = "//dt[contains(text(),'Reply method')]/following-sibling::dd")
    WebElement replyMethod;

    @FindBy(xpath = "//*[contains(text(),'View summons reply')]")
    WebElement viewSummonsReplyLink;

    @FindBy(id = "financeTab")
    WebElement financeTab;

    @FindBy(id = "attendanceTab")
    WebElement attendanceTab;

    @FindBy(id = "notesTab")
    WebElement notesTab;

    @FindBy(id = "historyTab")
    WebElement historyTab;

    @FindBy(xpath = "//*[contains(text(),'Reassign to another pool')]")
    WebElement reassignRadioButton;

    @FindBy(xpath = "//*[contains(text(),'Reassign to another pool')]")
    WebElement reassignJuror;

    @FindBy(xpath = "//div[contains(string(),'Choose a pool to reassign to')][1]/following-sibling::table[1]")
    WebElement reassignActivePoolsTable;

    @FindBy(xpath = "//*[contains(text(),'Transfer to another court')]")
    WebElement transferCourtRadioButton;

    @FindBy(id = "attendanceDate")
    WebElement attendanceDate;

    @FindBy(xpath = "//*[contains(text(),'They will be transferred to a new pool')]")
    WebElement transferConfirmationBody;

    //    @FindBy(xpath = "/html/body/div[2]/main/div[4]/div/dl/div/dd")
    @FindBy(xpath = "/html/body/div[3]/main/div[4]/div/dl/div[1]/dd")
    WebElement policeCheckStatus;

    @FindBy(xpath = "//dt[contains(text(),'Number of deferrals')]/../dd")
    WebElement numberOfDeferrals;

    @FindBy(id = "postponeTo")
    WebElement newServiceStartDate;

    @FindBy(id = "deferralDateAndPool")
    WebElement postponementDatePoolRadio;

    public void clickPostponementDatePoolRadio() {
        postponementDatePoolRadio.click();
    }

    public void enterNewServiceStartDate(String date) {
        newServiceStartDate.clear();
        newServiceStartDate.sendKeys(date);
    }

    @FindBy(id = "changeJurorDetailsAnchor")
    WebElement deferralChangeLink;

    @FindBy(xpath = "//dt[contains(text(),'Pool number')]/../dd")
    WebElement poolNumberValue;

    @FindBy(xpath = "//dt[contains(text(),'Deferred to')]/../dd")
    WebElement deferredToDate;

    @FindBy(xpath = "//a[contains(text(),'Run a police check')]")
    WebElement runPoliceCheckLink;

    @FindBy(xpath = "//button[contains(text(),'Run police check')]")
    WebElement runPoliceCheckButton;

    @FindBy(id = "notes")
    WebElement notesField;

    @FindBy(id = "saveButton")
    WebElement saveNotes;

    @FindBy(id = "addNotesButton")
    WebElement addOrEditNotes;

    @FindBy(id = "logContactButton")
    WebElement logNewContact;

    @FindBy(id = "courtNameOrLocation")
    WebElement courtNameOrLocation;

    @FindBy(xpath = "//*[@id='ac-courtNameOrLocation']")
    WebElement courtNameLocationValue;

    @FindBy(xpath = "/html/body/div[3]/main/form/div[2]/div/p")
    WebElement updatedJurorName;

    @FindBy(xpath = "//div[2]/div[2]/p")
    WebElement namePendingApproval;

    @FindBy(xpath = "//a[contains(text(),'Approve or reject')]")
    WebElement approveOrRejectName;

    @FindBy(xpath = "//a[@href [contains(.,'/pool-management/pool-overview')]]")
    WebElement poolNumberLink;

    @FindBy(xpath = "//*[contains(text(),'to approve')]")
    WebElement sjoNotificationBanner;

    @FindBy(id = "rejectComments")
    WebElement rejectCommentsField;

    @FindBy(id = "attendanceDate")
    WebElement nextDueAtCourt;

    @FindBy(xpath = "//*[@id=\"failed-to-attend\"]")
    WebElement failedToAttendCheckbox;

    @FindBy(xpath = "//thead[@class='govuk-table__head']/tr/th/a[@role='button']")
    public List<WebElement> DeferralGrantedResultsheaderTableName;

    @FindBy(xpath = "//input[@name='selectedJurors']")
    public WebElement uncompleteJurorCheckbox;

    @FindBy(xpath = "//*[@id=\"addNonAttendanceDayButton\"]")
    public WebElement addNonAttendanceDayButton;

    @FindBy(id = "nonAttendanceDay")
    public WebElement nonAttendanceDate;

    @FindBy(xpath = "//*[@id=\"nonAttendanceDayForm\"]/div[2]/button")
    public WebElement confirmNonAttendanceDateButton;

    @FindBy(xpath = "//thead[@class=\"govuk-table__head\"]/tr/th/button")
    public List<WebElement> DeferralRefusedResultsheaderTableName;
    @FindBy(xpath = "/html/body/div[3]/main/div[4]")
    public List<WebElement> postponementJurorsResultsheaderTableName;

    @FindBy(xpath = "//*[@class='govuk-table__cell']")
    public List<WebElement> listofJurorCodes;

    @FindBy(xpath = "//*[@class='govuk-link govuk-link--no-visited-state']")
    public List<WebElement> listofSystemCodes;

    @FindBy(xpath = "//*[@class='govuk-table']/tbody/tr/td")
    public List<WebElement> listDisqualificationCode;

    @FindBy(xpath = "//input[@id='livingOverseas']")
    public WebElement livingOverseasFlagYes;

    @FindBy(xpath = "//input[@id='livingOverseas-2']")
    public WebElement livingOverseasFlagNo;

    public String getHeading() {
        return heading.getText();
    }

    public void checkUncompleteJuror() {
        uncompleteJurorCheckbox.sendKeys(Keys.SPACE);
    }

    public boolean seeJurorRecordTag() {
        return jurorRecordTag.isDisplayed();
    }

    public boolean seeEnterSummonsReplyButton() {
        return enterSummonsReplyButton.isDisplayed();
    }

    public void clickUpdateJurorRecordButton() {
        updateJurorRecordButton.click();
    }

    public void clickAddOrEditNotes() {
        addOrEditNotes.click();
    }

    public void clickLogNewContact() {
        logNewContact.click();
    }

    public void enterNotes(String notes) {
        notesField.clear();
        notesField.sendKeys(notes);
    }

    public void enterComments(String comments) {
        rejectCommentsField.clear();
        rejectCommentsField.sendKeys(comments);
    }

    public void saveNotes() {
        saveNotes.click();
    }

    public String getJurorNumber() {
        return jurorNumber.getText();
    }

    public String getJurorStatus() {
        return jurorStatus.getText();
    }

    public String getPoolNumber() {
        return poolNumber.getText();
    }

    public String getCourtStartDate() {
        return courtStartDate.getText();
    }

    public String getCourtName() {
        return courtName.getText();
    }

    public boolean seeJurorStatusWarningSymbol() {
        log.info("Checking juror status warning symbol is present");
        return jurorStatusWarningIcon.isDisplayed();
    }

    public boolean seeOverviewTab() {
        return overviewTab.isDisplayed();
    }

    public boolean seeDetailsTab() {
        return jurorDetailsTab.isDisplayed();
    }

    public boolean seeSummonsTab() {
        return summonsTab.isDisplayed();
    }

    public void clickSummonsTab() {
        summonsTab.click();
    }

    public String getReplyStatus() {
        return replyStatus.getText();
    }

    public String getProcessingOutcome() {
        return processingOutcome.getText();
    }

    public boolean seeProcessingOutcomeWarningSymbol() {
        log.info("Checking processing outcome warning symbol is present");
        return processingOutcomeWarningIcon.isDisplayed();
    }

    public String getReplyDate() {
        return replyDate.getText();
    }

    public String getReplyMethod() {
        return replyMethod.getText();
    }

    public boolean seeFinanceTab() {
        return financeTab.isDisplayed();
    }

    public boolean seeAttendanceTab() {
        return attendanceTab.isDisplayed();
    }

    public boolean seeNotesTab() {
        return notesTab.isDisplayed();
    }

    public void clickNotesTab() {
        notesTab.click();
    }

    public boolean seeHistoryTab() {
        return historyTab.isDisplayed();
    }

    public void clickReassignRadioButton() {
        reassignRadioButton.click();
    }

    public void clickReassignJuror() {
        reassignJuror.click();
    }

    public boolean seeReassignActivePoolsTable() {
        return reassignActivePoolsTable.isDisplayed();
    }

    public List<String> getReassignActivePoolsHeadings() {
        log.info("Getting reassign active pool table headings");
        List<WebElement> headings = reassignActivePoolsTable.findElements(By.tagName("th"));
        headings.remove(0);
        List<String> headingsText = new ArrayList<>();
        for (int i = 0; i < headings.size(); i++) {
            headingsText.add(headings.get(i).getText());
        }
        return headingsText;
    }

    public String getPoliceCheckText() {
        return policeCheckStatus.getText().split("\n")[0];

    }

    public void clickTransferCourtRadioButton() {
        transferCourtRadioButton.click();
    }

    public void enterAttendanceDate(String text) {
        attendanceDate.clear();
        attendanceDate.sendKeys(text);
    }

    public String getTransferConfirmationBody() {
        return transferConfirmationBody.getText();
    }

    public String getNumberOfDeferrals() {
        return numberOfDeferrals.getText();
    }

    public void clickDeferralChange() {
        deferralChangeLink.click();
    }

    public String getPoolNumberValue() {
        return poolNumberValue.getText();
    }

    public String getDeferredToDate() {
        return deferredToDate.getText();
    }

    public boolean runPoliceCheckIsLinkDisplayed() {
        return runPoliceCheckLink.isDisplayed();
    }

    public boolean runPoliceCheckLinkInvisible() {
        List<WebElement> elements = driver.findElements(By.xpath("//a[contains(text(),'Run a police check')]"));
        return elements.isEmpty();
    }

    public boolean runPoliceCheckIsButtonDisplayed() {
        return runPoliceCheckButton.isDisplayed();
    }

    public void clickRunPoliceCheckLink() {
        runPoliceCheckLink.click();
    }

    public void clickRunPoliceCheckButton() {
        runPoliceCheckButton.click();
    }

    public boolean seeHistoryItemCreatedBy(String historyMessage, String user) {
        WebElement historyItemElement = driver.findElement(By.xpath("//div[@class='moj-timeline__header']/h2[text()[contains(.,'" + historyMessage + "')]]/following-sibling::div[text()[contains(.,'" + user + "')]]"));

        if (historyItemElement.isDisplayed()) {
            return true;
        } else {
            return false;
        }
    }

    public boolean getTextCourtNameLocation(String expectedText) {
        String courtsLocations = courtNameLocationValue.getAttribute("data-content");
        Boolean containsExpected = courtsLocations.contains(expectedText);
        return containsExpected;
    }

    public void setCourtOrLocation(String courtOrLocationCode) {
        courtNameOrLocation.sendKeys(Keys.BACK_SPACE);
        courtNameOrLocation.sendKeys(Keys.BACK_SPACE);
        courtNameOrLocation.sendKeys(Keys.BACK_SPACE);

        courtNameOrLocation.sendKeys(courtOrLocationCode);
    }

    public String getUpdatedJurorName() {
        return updatedJurorName.getText();
    }

    public String jurorNamePendingApproval() {
        return namePendingApproval.getText();
    }

    public void clickApproveOrRejectLink() {
        approveOrRejectName.click();
    }

    public void clickPoolNumberLink() {
        poolNumberLink.click();
    }

    public void clickChangeLinkInSameRowAs_inCreateJurorRecord(String link, String nextTo) throws Throwable {
        By changeLink = By.xpath("//dt[contains(text(),'" + nextTo + "') or contains(text(),'" + nextTo + "')]/following-sibling::*/a[@class='govuk-link' and contains(text(),'" + link + "')]");

        WebElement element = driver.findElement(changeLink);
        element.click();

        log.info("Found =>" + link + "<= in the same row as =>" + nextTo + "<= and clicked on 'Change' link as expected");
    }

    public void sjoNotification() {
        sjoNotificationBanner.getText();
    }

    public void clickSjoNotification() {
        sjoNotificationBanner.click();
    }

    public boolean sjoNotificationNotPresent() {
        List<WebElement> elements = driver.findElements(By.xpath("//*[contains(text(),'to approve')]"));
        return elements.isEmpty();
    }

    public void deferralGrantedjurorsTabPresent(final String tabName) {
        log.info("Clicking tab");
        switch (tabName) {
            case "Juror number":
                Assert.assertTrue("Expected Text not found", DeferralGrantedResultsheaderTableName.get(0).getText().equals(tabName));
                log.info(" Text - " + DeferralGrantedResultsheaderTableName.get(0).getText() + " - is visible on the page ");
                break;
            case "First name":
                Assert.assertTrue("Expected Text not found", DeferralGrantedResultsheaderTableName.get(1).getText().equals(tabName));
                log.info(" Text - " + DeferralGrantedResultsheaderTableName.get(1).getText() + " - is visible on the page ");
                break;
            case "Last name":
                Assert.assertTrue("Expected Text not found", DeferralGrantedResultsheaderTableName.get(2).getText().equals(tabName));
                log.info(" Text - " + DeferralGrantedResultsheaderTableName.get(2).getText() + " - is visible on the page ");
                break;
            case "Postcode":
                Assert.assertTrue("Expected Text not found", DeferralGrantedResultsheaderTableName.get(3).getText().equals(tabName));
                log.info(" Text - " + DeferralGrantedResultsheaderTableName.get(2).getText() + " - is visible on the page ");
                break;
            case "Status":
                Assert.assertTrue("Expected Text not found", DeferralGrantedResultsheaderTableName.get(4).getText().equals(tabName));
                log.info(" Text - " + DeferralGrantedResultsheaderTableName.get(2).getText() + " - is visible on the page ");
                break;
            case "Deferred to":
                Assert.assertTrue("Expected Text not found", DeferralGrantedResultsheaderTableName.get(5).getText().equals(tabName));
                log.info(" Text - " + DeferralGrantedResultsheaderTableName.get(2).getText() + " - is visible on the page ");
                break;
            case "Reason":
                Assert.assertTrue("Expected Text not found", DeferralGrantedResultsheaderTableName.get(6).getText().equals(tabName));
                log.info(" Text - " + DeferralGrantedResultsheaderTableName.get(2).getText() + " - is visible on the page ");
                break;
            case "Date printed":
                Assert.assertTrue("Expected Text not found", DeferralGrantedResultsheaderTableName.get(7).getText().equals(tabName));
                log.info(" Text - " + DeferralGrantedResultsheaderTableName.get(2).getText() + " - is visible on the page ");
                break;

            default:
                log.info("Expected element text is not present on the page");
                break;
        }

    }

    public void seePrintedLetterInLettersTable(String jurorNumber) {
        Calendar today = Calendar.getInstance();
        SimpleDateFormat formatter = new SimpleDateFormat("EEE d MMM yyyy", Locale.ENGLISH);
        String printedDate = formatter.format(today.getTime());

        printedDate = enforceThreeLetterMonth(printedDate);
        System.out.println("Formatted date: " + printedDate);
        WebElement table = driver.findElement(By.xpath("//*[@id=\"main-content\"]/div[4]/div/table/tbody"));
        List<WebElement> rows = table.findElements(By.tagName("tr"));

        for (WebElement row : rows) {
            List<WebElement> cells = row.findElements(By.tagName("td"));
            boolean jurorFound = false;
            boolean dateFound = false;
            int dateColumnIndex = -1;

            for (int i = 0; i < cells.size(); i++) {
                WebElement cell = cells.get(i);
                String cellText = cell.getText().trim();

                if (cellText.contains(jurorNumber)) {
                    jurorFound = true;
                }

                if (cellText.contains(printedDate)) {
                    dateFound = true;
                    dateColumnIndex = i;
                }
            }
            if (jurorFound && dateFound && dateColumnIndex == 8) {
                System.out.println("Found matching juror and date: " + jurorNumber + ", " + printedDate);
                return;
            }
        }
        throw new RuntimeException("Matching juror and date not found: " + jurorNumber + ", " + printedDate);
    }

    private String enforceThreeLetterMonth(String date) {
        String[] months3Letters = {"Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"};
        for (String month : months3Letters) {
            if (date.contains(month)) {
                return date;
            }
        }
        return date.replaceAll("Sept", "Sep");
    }


    public void returnToPreviousTabAfterLetter() {

        String currentUrl = driver.getWindowHandle();

        String previousTabUrl = ("https://juror-test-bureau.clouddev.online/homepage");

        Set<String> windowHandles = driver.getWindowHandles();

        if (windowHandles.size() >= 2) {

            for (String handle : windowHandles) {
                if (!handle.equals(currentUrl)) {
                    driver.switchTo().window(handle);
                    driver.switchTo().window(currentUrl);
                    new WebDriverWait(driver, Duration.ofSeconds(3));
                    driver.get(previousTabUrl);
                    return;
                }
            }
        } else {
            log.info("There is only one tab open. Cannot return to the previous tab.");
        }
    }

    public void pressNonAttendanceDayButton() {
        addNonAttendanceDayButton.click();
    }

    public void PressConfirmNonAttendanceDateButton() {
        confirmNonAttendanceDateButton.click();
    }

    public void setNonAttendanceDate(String date) {
        nonAttendanceDate.clear();
        nonAttendanceDate.sendKeys(date);
    }

    public void selectAllCheckboxesInLettersTable() {
        try {
            List<WebElement> checkboxes = driver.findElements(By.xpath("//*[@id=\"main-content\"]/div[4]/div/table//input[@name='checked-jurors']"));
            JavascriptExecutor js = (JavascriptExecutor) driver;
            for (WebElement checkbox : checkboxes) {
                if (!checkbox.isSelected()) {
                    js.executeScript("arguments[0].click();", checkbox);
                }
            }

            log.info("All checkboxes in the table selected successfully");
        } catch (Exception e) {
            log.error("Error occurred while selecting checkboxes" + e.getMessage());
        }
    }

    public void selectCheckboxesInLettersTableForJuror(String juror) {
        try {
            List<WebElement> checkboxes = driver.findElements(
                    By.xpath("//*[@id='main-content']/div[4]/div/table//input[@id='juror-" + juror + "']")
            );

            JavascriptExecutor js = (JavascriptExecutor) driver;
            for (WebElement checkbox : checkboxes) {
                if (!checkbox.isSelected()) {
                    js.executeScript("arguments[0].click();", checkbox);
                }
            }
            log.info("Selected checkboxes for juror: " + juror);
        } catch (Exception e) {
            log.error("Error occurred while selecting checkboxes: " + e.getMessage());
        }
    }

    public void initialSummonsBanner() {
        NAV.messageBanner.isDisplayed();
    }

    public void checkTabsOnLettersTabPresent(final String tabName) {
        log.info("Attempting to locate the tab with text: \"" + tabName + "\"");

        Objects.requireNonNull(tabName, "Tab name cannot be null");

        JavascriptExecutor jsExecutor = (JavascriptExecutor) driver;

        String columnSearch = """
                    return Array.from(document.querySelectorAll('a'))
                        .find(a => a.textContent.trim() === arguments[0]);
                """;

        WebElement linkElement = (WebElement) jsExecutor.executeScript(columnSearch, tabName);

        if (linkElement != null) {
            log.info("Located link with text: \"" + tabName + "\". Element details: " + linkElement.toString());

            if (linkElement.isDisplayed() && linkElement.isEnabled()) {
                log.debug("Link is interactable. Proceeding with validation.");
                Assert.assertTrue("Expected link \"" + tabName + "\" is present and interactable.", true);
            } else {
                log.warn("Link is present but not interactable. Display: " + linkElement.isDisplayed() +
                        ", Enabled: " + linkElement.isEnabled());
                Assert.fail("Link with text \"" + tabName + "\" is present but not interactable.");
            }
        } else {
            log.error("Failed to locate link with text: \"" + tabName + "\". Potential causes: incorrect text, DOM timing issues, or missing element.");
            Assert.fail("Link with text \"" + tabName + "\" is not found on the page.");
        }
    }

    public void seeAbsenceDateInTable(String jurorNumber) {
        SimpleDateFormat formatter = new SimpleDateFormat("EEE d MMM yyyy");
        String absenceDate = formatter.format(new Date());

        WebElement table = driver.findElement(By.xpath("//*[@id=\"main-content\"]/div[4]/div/table"));
        List<WebElement> rows = table.findElements(By.tagName("tr"));

        for (WebElement row : rows) {
            List<WebElement> cells = row.findElements(By.tagName("td"));
            boolean jurorFound = false;
            boolean dateFound = false;

            for (WebElement cell : cells) {
                String cellText = cell.getText();

                if (cellText.contains(jurorNumber)) {
                    jurorFound = true;
                }
                if (cellText.contains(absenceDate)) {
                    dateFound = true;
                }
            }
            if (jurorFound && dateFound) {
                System.out.println("Found matching juror and date: " + jurorNumber + ", " + absenceDate);
                return;
            }
        }
        System.out.println("Matching juror and date not found: " + jurorNumber + ", " + absenceDate);
    }

    public void getListOfSystemCodes(String systemcodes) {


        switch (systemcodes) {

            case "Disqualified code":
                Assert.assertTrue("Expected Text not found", listofSystemCodes.get(0).getText().equals(systemcodes));
                log.info(" Text - " + listofSystemCodes.get(0).getText() + " - is visible on the page ");
                break;

            case "Excusal and deferral codes":
                Assert.assertTrue("Expected Text not found", listofSystemCodes.get(1).getText().equals(systemcodes));
                log.info(" Text - " + listofSystemCodes.get(1).getText() + " - is visible on the page ");
                break;

            case "ID check codes":
                Assert.assertTrue("Expected Text not found", listofSystemCodes.get(2).getText().equals(systemcodes));
                log.info(" Text - " + listofSystemCodes.get(2).getText() + " - is visible on the page ");
                break;

            case "Juror status codes":
                Assert.assertTrue("Expected Text not found", listofSystemCodes.get(3).getText().equals(systemcodes));
                log.info(" Text - " + listofSystemCodes.get(3).getText() + " - is visible on the page ");
                break;

            case "Phone log codes":
                Assert.assertTrue("Expected Text not found", listofSystemCodes.get(4).getText().equals(systemcodes));
                log.info(" Text - " + listofSystemCodes.get(4).getText() + " - is visible on the page ");
                break;

            case "Reasonable adjustment code":
                Assert.assertTrue("Expected Text not found", listofSystemCodes.get(5).getText().equals(systemcodes));
                log.info(" Text - " + listofSystemCodes.get(5).getText() + " - is visible on the page ");
                break;

            case "Trial type":
                Assert.assertTrue("Expected Text not found", listofSystemCodes.get(6).getText().equals(systemcodes));
                log.info(" Text - " + listofSystemCodes.get(6).getText() + " - is visible on the page ");
                break;

            default:
                log.info("Expected element text is not present on the page");
                break;

        }
    }


    public void getListOfJurorCodeStatus(String listOfJurorCode) {

        switch (listOfJurorCode) {

            case "Pool":
                Assert.assertTrue("Expected Text not found", listofJurorCodes.get(1).getText().equals(listOfJurorCode));
                log.info(" Text - " + listofJurorCodes.get(1).getText() + " - is visible on the page ");
                break;

            case "Summoned":
                Assert.assertTrue("Expected Text not found", listofJurorCodes.get(4).getText().equals(listOfJurorCode));
                log.info(" Text - " + listofJurorCodes.get(4).getText() + " - is visible on the page ");
                break;

            case "Responded":
                Assert.assertTrue("Expected Text not found", listofJurorCodes.get(7).getText().equals(listOfJurorCode));
                log.info(" Text - " + listofJurorCodes.get(7).getText() + " - is visible on the page ");
                break;

            case "Panel":
                Assert.assertTrue("Expected Text not found", listofJurorCodes.get(10).getText().equals(listOfJurorCode));
                log.info(" Text - " + listofJurorCodes.get(10).getText() + " - is visible on the page ");
                break;

            case "Juror":
                Assert.assertTrue("Expected Text not found", listofJurorCodes.get(13).getText().equals(listOfJurorCode));
                log.info(" Text - " + listofJurorCodes.get(13).getText() + " - is visible on the page ");
                break;

            case "Excused":
                Assert.assertTrue("Expected Text not found", listofJurorCodes.get(16).getText().equals(listOfJurorCode));
                log.info(" Text - " + listofJurorCodes.get(16).getText() + " - is visible on the page ");
                break;

            case "Disqualified":
                Assert.assertTrue("Expected Text not found", listofJurorCodes.get(19).getText().equals(listOfJurorCode));
                log.info(" Text - " + listofJurorCodes.get(19).getText() + " - is visible on the page ");
                break;


            case "Deferred":
                Assert.assertTrue("Expected Text not found", listofJurorCodes.get(22).getText().equals(listOfJurorCode));
                log.info(" Text - " + listofJurorCodes.get(22).getText() + " - is visible on the page ");
                break;

            case "Reassigned":
                Assert.assertTrue("Expected Text not found", listofJurorCodes.get(25).getText().equals(listOfJurorCode));
                log.info(" Text - " + listofJurorCodes.get(25).getText() + " - is visible on the page ");
                break;
            case "Undeliverable":
                Assert.assertTrue("Expected Text not found", listofJurorCodes.get(28).getText().equals(listOfJurorCode));
                log.info(" Text - " + listofJurorCodes.get(28).getText() + " - is visible on the page ");
                break;
            case "Transferred":
                Assert.assertTrue("Expected Text not found", listofJurorCodes.get(31).getText().equals(listOfJurorCode));
                log.info(" Text - " + listofJurorCodes.get(31).getText() + " - is visible on the page ");
                break;
            case "Awaiting info":
                Assert.assertTrue("Expected Text not found", listofJurorCodes.get(34).getText().equals(listOfJurorCode));
                log.info(" Text - " + listofJurorCodes.get(34).getText() + " - is visible on the page ");
                break;

            case "Failed to attend":
                Assert.assertTrue("Expected Text not found", listofJurorCodes.get(37).getText().equals(listOfJurorCode));
                log.info(" Text - " + listofJurorCodes.get(37).getText() + " - is visible on the page ");
                break;

            case "Completed":
                Assert.assertTrue("Expected Text not found", listofJurorCodes.get(40).getText().equals(listOfJurorCode));
                log.info(" Text - " + listofJurorCodes.get(40).getText() + " - is visible on the page ");
                break;

            default:
                log.info("Expected element text is not present on the page");
                break;

        }

    }

    public Map<String, String> getQualificationCode() {
        Map<String, String> details = new HashMap<>();

        details.put("A", listDisqualificationCode.get(1).getText());
        details.put("B", listDisqualificationCode.get(4).getText());
        details.put("C", listDisqualificationCode.get(7).getText());
        details.put("D", listDisqualificationCode.get(10).getText());
        details.put("E", listDisqualificationCode.get(13).getText());
        details.put("M", listDisqualificationCode.get(16).getText());
        details.put("R", listDisqualificationCode.get(19).getText());
        return details;
    }


    public String getMyPoolNumber() {
        return poolNumber.getText();
    }

    public void setLivingOverseasFlag(String livingOverseasFlagValue) {

        if (Objects.equals(livingOverseasFlagValue, "no")) {
            livingOverseasFlagNo.click();
            log.info("Selected NO for living overseas flag");
        }

        if (Objects.equals(livingOverseasFlagValue, "yes")) {
            livingOverseasFlagYes.click();
            log.info("Selected YES for living overseas flag");
        }

    }
}

