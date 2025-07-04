package cucumber.pageObjects;

import cucumber.utils.AngularJsHTTPCallWait;
import cucumber.utils.WaitUtil_v2;
import cucumber.utils.WaitUtils;
import org.apache.log4j.Logger;
import org.openqa.selenium.*;
import org.openqa.selenium.NoSuchElementException;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import org.openqa.selenium.support.ui.ExpectedConditions;
import org.openqa.selenium.support.ui.WebDriverWait;

import java.time.Duration;
import java.util.*;
import java.util.stream.Collectors;

public class PoolRequests {

    private static final Logger log = Logger.getLogger(Search.class);
    private static WebDriver driver;
    private final WaitUtils wait;
    private final WaitUtil_v2 wait1;
    private final AngularJsHTTPCallWait aJsWait;
    private final NavigationShared NAV;
    private final Header HEADER_PAGE;
    @FindBy(xpath = "//div[@class=\"govuk-summary-list__row govuk-summary-list__row--no-actions\"]//dd[@class=\"govuk-summary-list__value\"]")
    public List<WebElement> courtAttendanceTime;
    @FindBy(linkText = "Create pool")
    WebElement requestNewPoolLink;
    @FindBy(xpath = "//h1")
    WebElement pageHeading;
    @FindBy(id = "continueButton")
    WebElement continueButton;

    @FindBy(xpath = "//*[@id=\"poolSearchForm\"]/descendant::button[contains(text(),'Continue')]")
    WebElement poolSearchContinue;
    @FindBy(id = "deferralMaintenanceAnchor")
    WebElement deferraMaintenanceLink;
    @FindBy(id = "confirmButton")
    WebElement confirmButton;
    @FindBy(xpath = "//label[@for=\"selectedCourtName\"]/following-sibling::dl[1]//dd[@class=\"govuk-summary-list__value\"]")
    WebElement courtName;
    @FindBy(xpath = "//dl[@id=\"attendanceDate\"]//dd[1]")
    WebElement courtDate;
    @FindBy(xpath = "//dl[@id=\"requestDetails\"]//div[3]//dd[1]")
    WebElement courtDateCheckDetails;
    @FindBy(xpath = "//dl[@id=\"attendanceDate\"]//dd[1]")
    WebElement courtDateRequestPool;
    @FindBy(xpath = "//dl[@id=\"attendanceTime\"]//dd[@class=\"govuk-summary-list__value\"]")
    WebElement courtTime;
    @FindBy(xpath = "//label[@for=\"selectedCourtName\"]/following-sibling::dl[1]//a[@class=\"govuk-link\"]")
    WebElement changeCourtLink;
    @FindBy(css = "#attendanceDate a")
    WebElement changeDateLink;
    @FindBy(css = "#attendanceTime a")
    WebElement changeTimeLink;
    @FindBy(css = "#poolNumber a")
    WebElement changePoolNumberLink;
    @FindBy(id = "attendanceTimeHour")
    WebElement timeHours;
    @FindBy(id = "attendanceTimeMinute")
    WebElement timeMinutes;
    @FindBy(xpath = "//input[@id=\"courtNameOrLocation\"]")
    WebElement courtTextBox;
    @FindBy(id = "continueButton")
    WebElement submitButton;
    @FindBy(id = "courtNameOrLocation__option--0")
    WebElement courtDropdownFirstOption;
    @FindBy(id = "attendanceDate")
    WebElement attendanceDateField;
    @FindBy(id = "additionalRequirements-2")
    WebElement onCallPoolCheckbox;
    @FindBy(id = "numberOfJurorsRequired")
    WebElement numberOfJurorsField;
    @FindBy(className = "govuk-error-summary")
    WebElement errorSummary;
    @FindBy(css = "#numberOfCourtDeferrals a")
    WebElement changeDeferralsLink;
    @FindBy(id = "numberOfDeferrals")
    WebElement numberOfDeferralsField;
    @FindBy(linkText = "Cancel")
    WebElement cancelLink;
    @FindBy(id = "courtNameOrLocation")
    WebElement filterField;
    @FindBy(className = "autocomplete__option")
    WebElement filterAutocompleteOption;
    @FindBy(xpath = "//button[@type=\"submit\"]")
    WebElement filterButton;
    @FindBy(xpath = "//div[@Class='govuk-grid-column-full']/p[@Class='govuk-body']")
    WebElement attendanceDateWarning;
    @FindBy(linkText = "Continue")
    WebElement warningContinue;
    @FindBy(css = "#poolRequestsTable td:nth-child(1) .govuk-link ")
    WebElement firstPoolRequestLink;
    @FindBy(className = "moj-alert__content")
    WebElement bannerMessage;
    @FindBy(id = "courtNameOrLocation")
    WebElement courtNameTextBox;
    @FindBy(id = "courtNameOrLocation__option--0")
    WebElement courtNameLocationOption1;
    @FindBy(css = ".govuk-summary-list__key.govuk-heading-m")
    WebElement tableHeading;
    @FindBy(id = "activePoolsAnchor")
    WebElement activePoolsLink;
    @FindBy(xpath = "//dt[@class=\"govuk-summary-list__key\"]/a")
    WebElement existingPoolNumber;
    @FindBy(xpath = "//span[@class='govuk-caption-l']")
    WebElement summonCitizensPoolNumber;
    @FindBy(id = "poolNumber")
    WebElement poolNumberInput;
    @FindBy(id = "searchAnchor")
    WebElement searchTab;
    @FindBy(xpath = "//*[@id=\"poolRequestsTable\"]/tbody/tr/td[1]/a[1]")
    WebElement poolNumberSummary;
    @FindBy(xpath = "//*[@id=\"poolNumber\"]/div[2]/dd")
    WebElement poolNumberOnDetails;
    @FindBy(xpath = "/html/body/div[3]/main/div[3]/div[3]/div/div/div[1]/p/time")
    WebElement timelineDateAndTime;
    @FindBy(xpath = "/html/body/div[3]/main/div[1]/div[2]/a")
    WebElement requestNewPoolButton;
    @FindBy(xpath = "/html/body/div[3]/main/div/div/form/div/button")
    WebElement requestPoolButton;
    @FindBy(xpath = "/html/body/div[3]/main/div[3]/div[4]/a")
    WebElement summonJurorsButton;
    @FindBy(xpath = "/html/body/div[3]/main/div/div/form/div[5]/button")
    WebElement createPoolAndSummonCitizensButton;
    @FindBy(id = "membersListTable")
    WebElement jurorPartNumbertable;
    @FindBy(xpath = ("//button[contains(text(),'Create a pool')]"))
    WebElement createAPool;
    @FindBy(xpath = ("//a[contains(text(),'Create a nil pool')]"))
    WebElement createNilPool;
    @FindBy(xpath = "//div/strong[@class='govuk-tag govuk-tag--blue']")
    WebElement poolStatusRequestedTag;
    @FindBy(xpath = "//strong[contains(text(),'Active')]")
    WebElement poolStatusActiveTag;
    @FindBy(className = "govuk-pagination__next")
    WebElement nextPaginationLink;
    @FindBy(id = "poolRequestsTable")
    WebElement activePoolsTable;
    @FindBy(xpath = "//td[2]/a")
    WebElement firstJurorInList;
    @FindBy(xpath = "//div[@class='moj-alert moj-alert--success']//a")
    WebElement courtOnlyPoolRequestSuccessLink;
    private Groups GRP;

    public PoolRequests(WebDriver driver) {
        PoolRequests.driver = driver;
        PageFactory.initElements(driver, this);
        wait = new WaitUtils(driver);
        wait1 = new WaitUtil_v2(driver);
        aJsWait = new AngularJsHTTPCallWait(driver);
        NAV = new NavigationShared(driver);
        HEADER_PAGE = PageFactory.initElements(driver, Header.class);
    }

    public void clickSearchTab() {
        searchTab.click();
    }

    public void enterAndSelectCourtAsBureau(String courtName) {
        log.info("Entering and selecting court");
        courtNameTextBox.sendKeys(courtName);
        courtNameLocationOption1.click();
        submitButton.click();
    }

    public void clickNewlyCreatedCourtOnlyPoolLink() {
        courtOnlyPoolRequestSuccessLink.click();
    }


    public void openPoolManagement() {
        log.info("Opening Pool Management");

        HEADER_PAGE.openAppsMenu();

        WebDriverWait wait = new WebDriverWait(driver, Duration.ofSeconds(2));

        try {
            WebElement poolManagementLinkCss = wait.until(
                    ExpectedConditions.visibilityOfElementLocated(By.cssSelector("a.govuk-link.govuk-!-font-weight-bold[href='/pool-management']"))
            );
            poolManagementLinkCss.click();
            log.info("Clicked on Pool Management using CSS Selector");
        } catch (Exception e) {
            log.error("Failed to find Pool Management using CSS Selector", e);
        }

        try {
            WebElement poolManagementLinkXpath = wait.until(
                    ExpectedConditions.visibilityOfElementLocated(By.xpath("//a[@href='/pool-management' and contains(text(),'Pool management')]"))
            );
            poolManagementLinkXpath.click();
            log.info("Clicked on Pool Management using XPath");
        } catch (Exception e) {
            log.error("Failed to find Pool Management using XPath", e);
        }
    }

    public void openSummonsManagement() {
        log.info("Opening Summons Management");
        HEADER_PAGE.openAppsMenu();
        HEADER_PAGE.clickSummonsManagement();
    }

    public void clickCreateNilPool() {
        log.info("Clicking create nil pool");
        createNilPool.click();
    }

    public void clickCreateAPool() {
        log.info("Clicking create a pool");
        createAPool.click();
    }

    public boolean tabPresentAndCorrect(final String tabName) {
        log.info("Checking tab is present and correct");
        clickTab(tabName);
        NAV.waitForPageLoad();
//        return tabFocussed(tabName) & tableHeadingsVisible();
        return tableHeadingsVisible();
    }

    public void clickTab(final String tabName) {
        log.info("Clicking tab");
        var tabElement = driver.findElement(By.linkText(tabName));
        ((JavascriptExecutor) driver).executeScript("arguments[0].click();", tabElement);
}

    public void clickActivePools() {
        log.info("Click active pools");
        activePoolsLink.click();
    }

    private Boolean tabFocussed(final String tabName) {
        log.info("Checking tab is focussed");
        WebElement tab = driver.findElement(By.linkText(tabName));
        return Objects.equals(tab.getAttribute("aria-current"), "page");
    }

    private Boolean tableHeadingsVisible() {
        log.info("Checking table headings are visible");
        List<WebElement> tableHeadings = driver.findElements(By.xpath("//th"));
        return Objects.equals(tableHeadings.size(), 4);
    }

    public void clickNewPoolLink() {
        log.info("Clicking New Pool link");
        requestNewPoolLink.click();
    }

    public String getPageHeading() {
        log.info("Getting page heading");

        int maxRetries = 2;
        int retryCount = 0;
        StaleElementReferenceException lastException = null;

        while (retryCount < maxRetries) {
            try {
                String text = pageHeading.getText();
                log.info("Successfully retrieved page heading");
                return text;
            } catch (StaleElementReferenceException e) {
                lastException = e;
                retryCount++;
                log.warn("StaleElementReferenceException when getting page heading - attempt " + retryCount);

                if (retryCount == maxRetries) break;

                PageFactory.initElements(driver, this);

                try {
                    Thread.sleep(200);
                } catch (InterruptedException ie) {
                    Thread.currentThread().interrupt();
                }
            }
        }

        throw lastException;
    }

    public String getTableHeading() {
        log.info("Getting table heading");
        return tableHeading.getText();
    }

    public String getAttendanceDateWarning() {
        log.info("Getting attendance date warning");

        int maxRetries = 2;
        int retryCount = 0;
        StaleElementReferenceException lastException = null;

        while (retryCount < maxRetries) {
            try {
                String text = attendanceDateWarning.getText();
                log.info("Successfully retrieved attendance date warning");
                return text;
            } catch (StaleElementReferenceException e) {
                lastException = e;
                retryCount++;
                log.warn("StaleElementReferenceException when getting attendance date warning - attempt " + retryCount);

                if (retryCount == maxRetries) break;

                PageFactory.initElements(driver, this);

                try {
                    Thread.sleep(200);
                } catch (InterruptedException ie) {
                    Thread.currentThread().interrupt();
                }
            }
        }

        throw lastException;
    }

    public void clickContinue() {
        log.info("Clicking continue");
        continueButton.click();
    }

    public void clickConfirm() {
        log.info("Clicking confirm");
        confirmButton.click();
    }

    public void continueFromWarningPage() {
        log.info("Continuing from warning page");
        warningContinue.click();
    }

    public String getRequestedCourtName() {
        log.info("Getting court name");
        return courtName.getText();
    }

    public String getRequestedCourtDate() {
        log.info("Getting court date");
        try {
            return courtDateCheckDetails.getText();
        } catch (Exception e) {
            return courtDateRequestPool.getText();
        }
    }

    public void clickChangeCourt() {
        log.info("Clicking change court");
        changeCourtLink.click();
    }

    public void enterAndSelectCourt(final String court) {
        log.info("Selecting new court");
        courtTextBox.sendKeys(court);
        selectFirstCourtDropdownOption();
    }

    private void selectFirstCourtDropdownOption() {
        log.info("Selecing court from dropdown");
        courtDropdownFirstOption.click();
    }

    public void confirmNewCourtSelection() {
        log.info("Clicking continue on court selection page");
        submitButton.click();
    }

    public void clickChangeDate() {
        log.info("Clicking change date");
        changeDateLink.click();
    }

    public void enterNewDate(String weekendDateValue) {
        log.info("Entering new date");
        attendanceDateField.clear();
        attendanceDateField.sendKeys(weekendDateValue);

    }


    public void confirmNewDate() {
        log.info("Clicking continue on date change page");
        submitButton.click();
    }

    public String getAttendanceTime() {
        log.info("Getting attendance time");
        return courtTime.getText();
    }

    public void clickChangeTime() {
        log.info("Clicking change time");
        changeTimeLink.click();
    }

    public void clickChangePoolNumber() {
        log.info("Clicking change pool number");
        changePoolNumberLink.click();
    }

    public boolean changePoolNumberInvisible() {
        List<WebElement> elements = driver.findElements(By.cssSelector("#poolNumber a"));
        return elements.isEmpty();

    }

    public void fillTime(final String hour, final String minute) {
        log.info("Filling time fields");
        timeHours.clear();
        timeHours.sendKeys(hour);

        timeMinutes.clear();
        timeMinutes.sendKeys(minute);

    }

    public void confirmNewTimeEntry() {
        log.info("Confirming new time");
        submitButton.click();
    }

    public void selectPoolType(final PoolType poolType) {
        log.info("Setting pool type");
        String selector = "//input[@value=\"%s\"]";

        if (poolType.equals(PoolType.CIVIL))
            selector = String.format(selector, "CIV");
        if (poolType.equals(PoolType.CROWN))
            selector = String.format(selector, "CRO");
        if (poolType.equals(PoolType.HIGH))
            selector = String.format(selector, "HGH");

        driver.findElement(By.xpath(selector)).click();
    }

    public void clickOnCallPoolCheckbox() {
        log.info("Clicking on call pool checkbox");
        onCallPoolCheckbox.click();
    }

    public void enterNumberOfJurors(final String numberOfJurors) {
        log.info("Entering number of jurors");
        numberOfJurorsField.clear();
        numberOfJurorsField.sendKeys(numberOfJurors);
    }

    public String getErrorSummaryText() {
        log.info("Getting error summary text");
        return errorSummary.getText();
    }

    public void clickToChangeDeferrals() {
        log.info("Clicking change deferrals link");
        changeDeferralsLink.click();
    }

    public void enterNumberOfCourtDeferrals(final String numberOfDeferrals) {
        log.info("Entering number of court deferrals");
        numberOfDeferralsField.sendKeys(numberOfDeferrals);
    }

    public void submitCourtDeferrals() {
        log.info("Submitting court deferrals");
        submitButton.click();
    }

    public void clickCancel() {
        log.info("Clicking cancel");
        cancelLink.click();
    }

    public void clickPoolNumber(String poolNumber) {
        log.info("Clicking pool number");
        driver.findElement(By.linkText(poolNumber)).click();
    }

    public List<String> getPoolNumbersOnPage(){
        List<String> poolNumbers = new ArrayList<>();
        List<WebElement> poolNumberLinks = driver.findElements(By.xpath("//table[@id='poolRequestsTable']//td/a"));
        for(WebElement e : poolNumberLinks){
            poolNumbers.add(e.getText());
        }
        return poolNumbers;
    }

    public Map<String, String> SearchPoolRequestByNumber(final String poolNumber, String type) {
        log.info(Thread.currentThread().getName() + " - Getting pool request for pool: " + poolNumber);

        clickSearchTab();
        inputExistingPoolNumberAlt(poolNumber);
        poolSearchContinue.click();

        Map<String, String> data = new HashMap<>();
        if (Objects.equals(type, "Bureau")) {
            String jurorsRequired = driver.findElement(By.xpath(
                    "//*[@class='pool-values__bureau-summoning']/descendant::span[contains(text(), 'Jurors requested')]/../span[2]"
            )).getText();
            data.put("jurorsRequired", jurorsRequired);
        }
        String court = driver.findElement(By.xpath(
                "//*[@class='court-details__grid']/descendant::span[contains(text(), 'Court name')]/../span[2]"
        )).getText();
        data.put("court", court);

        String attendanceDate = driver.findElement(By.xpath(
                "//*[@class='court-details__grid']/descendant::span[contains(text(), 'start date')]/../span[2]"
        )).getText();
        data.put("attendanceDate", attendanceDate);

        return data;
    }

    public void enterFilterString(final String filterQuery){
        log.info("Filtering by: " + filterQuery);
        filterField.clear();
        filterField.sendKeys(filterQuery);
        try {
            wait.waitForDisplayedElement(driver.findElement(By.className("autocomplete__option")), 10);
        } catch (Exception e){
            log.info("Exception: " + e);
        }
    }

    public void clickFilterAutocompleteOption() {
        WebElement autocompleteOption = driver.findElement(By.className("autocomplete__option"));
        autocompleteOption.click();
    }

    public void clickFilterButton() {
        filterButton.click();
    }

    public List<String> getPoolRequestCourtNames() {
        List<WebElement> elements = driver.findElements(By.xpath("//tr//td[3]"));
        return elements.stream().map(WebElement::getText).collect(Collectors.toList());
    }

    public List<String> getActivePoolRequestCourtNames() {
        List<WebElement> elements = driver.findElements(By.xpath("//tr//td[4]"));
        return elements.stream().map(WebElement::getText).collect(Collectors.toList());
    }

    public int countTableRows() {
        return driver.findElements(By.xpath("//tr/td[@class=\"govuk-table__cell\"][1]")).size();
    }

    public void clickFirstRequestLink() {
        log.info("Clicking first request link");
        firstPoolRequestLink.click();
    }

    public String getFirstRequestNumber() {
        log.info("Getting first request number");
        return firstPoolRequestLink.getText();
    }

    public String getExistingPoolNumber() {
        log.info("Getting existing pool number");
        return existingPoolNumber.getText();
    }

    public String getSummonCitizensPoolNumber() {
        log.info("Getting pool number on summon citizens page");
        return summonCitizensPoolNumber.getText();
    }

    public void inputExistingPoolNumber() {
        log.info("Input existing pool number");
        poolNumberInput.clear();
        poolNumberInput.sendKeys(getExistingPoolNumber());
    }

    public void inputExistingPoolNumberAlt(String poolNumber) {
        log.info("Input existing pool number");
        poolNumberInput.clear();
        poolNumberInput.sendKeys(poolNumber);
    }

    public void inputValidPoolNumber(String newPoolNo) {
        log.info("Input valid pool number");

        poolNumberInput.clear();
        poolNumberInput.sendKeys(newPoolNo);
    }

    public String getBannerMessage() {
        log.info("Getting banner message");

        int maxRetries = 2;
        int retryCount = 0;
        StaleElementReferenceException lastException = null;

        while (retryCount < maxRetries) {
            try {
                return bannerMessage.getText();
            } catch (StaleElementReferenceException e) {
                lastException = e;
                retryCount++;
                log.warn("StaleElementReferenceException when getting banner message - attempt " + retryCount);

                if (retryCount == maxRetries) break;

                PageFactory.initElements(driver, this);

                try {
                    Thread.sleep(200);
                } catch (InterruptedException ie) {
                    Thread.currentThread().interrupt();
                }
            }
        }

        log.error("Unable to get banner message due to stale element: " +
                (lastException != null ? lastException.getMessage() : "unknown"));
        throw new RuntimeException("Unable to retrieve banner message after retries.");
    }

    public boolean requestIsVisibleByNumber(String poolNumber) {
        log.info("Checking for visibility of pool request");
        try {
            driver.findElement(By.linkText(poolNumber));
            return true;
        } catch (NoSuchElementException e) {
            return false;
        }
    }

    public boolean seePoolStatusRequestedTag() {
        return poolStatusRequestedTag.isDisplayed();
    }

    public boolean seePoolStatusActiveTag() {
        return poolStatusActiveTag.isDisplayed();
    }

    public String getNewPoolNumberOnSummary() {
        return poolNumberSummary.getText();
    }

    public String getPoolNumberOnDetails() {
        log.info("Getting pool number on details");

        int maxRetries = 2;
        int retryCount = 0;
        StaleElementReferenceException lastException = null;

        while (retryCount < maxRetries) {
            try {
                return poolNumberOnDetails.getText();
            } catch (StaleElementReferenceException e) {
                lastException = e;
                retryCount++;
                log.warn("StaleElementReferenceException when getting pool number on details - attempt " + retryCount);

                if (retryCount == maxRetries) break;

                PageFactory.initElements(driver, this);

                try {
                    Thread.sleep(200);
                } catch (InterruptedException ie) {
                    Thread.currentThread().interrupt();
                }
            }
        }

        log.error("Unable to get pool number on details due to stale element: " +
                (lastException != null ? lastException.getMessage() : "unknown"));
        throw new RuntimeException("Unable to retrieve pool number on details after retries.");
    }

    public void clickDeferralMaintenance() {
        log.info("Click deferral maintenance");
        deferraMaintenanceLink.click();
    }

    public String seePoolHistoryUpdatedTime() {
        log.info("Getting updated date and time");
        return timelineDateAndTime.getText();
    }

    public void clickNextPagination() {
        nextPaginationLink.click();
    }

    public void clickActivePoolNumber(String poolNo) {
        log.info("Finding and clicking active pool number");
        boolean lastPage = false;
        while (!lastPage) {
            List<WebElement> activePoolOverviewLink = driver.findElements(By.xpath("//*[contains(text(),'" + poolNo + "')]"));
            if (activePoolOverviewLink.size() >= 1) {
                activePoolOverviewLink.get(0).click();
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

    public void clickInactivePoolNumber(String poolNo) {
        log.info("Finding and clicking active pool number");
        boolean lastPage = false;
        while (!lastPage) {
            List<WebElement> activePoolOverviewLink = driver.findElements(By.xpath("//a[contains(text(),'" + poolNo + "')]"));
            if (activePoolOverviewLink.size() >= 1) {
                activePoolOverviewLink.get(0).click();
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

    public void clickNewPoolRequestsButton() {
        log.info("Clicking request new pool button");
        requestNewPoolButton.click();
    }

    public void clickRequestPoolButton() {
        log.info("Clicking request pool button");
        requestPoolButton.click();
    }

    public void clickSummonJurorsButton() {
        log.info("Clicking summon jurors button");
        requestPoolButton.click();
    }

    public void clickCreatePoolAndSummonCitizensButton() {
        log.info("Clicking create pool and summon citizens button");
        requestPoolButton.click();
    }

    public void selectFirstJurorInList() {
        log.info("Clicked first juror in list");
        firstJurorInList.click();
    }

    public void checkJurorCheckboxSame_rowAs(String nextToText) {
        wait.activateImplicitWait();
        WebElement checkbox = driver.findElement(
                By.xpath(
                        "//input[@type='checkbox'][@value=" + nextToText + "]"
                ));
        log.info("Saw checkbox in row which contained text => " + nextToText);
        JavascriptExecutor js = (JavascriptExecutor) driver;
        js.executeScript("arguments[0].click();", checkbox);

        log.info("Checked checkbox which was in the same row as => " + nextToText);
    }

    public enum PoolType {
        CIVIL,
        CROWN,
        HIGH
    }

    public void clickPoolNumberInSearchResults(String poolNo) throws Exception {
        log.info("Finding and clicking active pool number");
        boolean lastPage = false;
        while (!lastPage) {
            List<WebElement> activePoolOverviewLink = driver.findElements(By.xpath("//a[contains(text(),'" + poolNo + "')]"));
            if (!activePoolOverviewLink.isEmpty()) {
                WebElement radioButton = driver.findElement(By.xpath("//input[@id=('" + poolNo + "')]"));
                NAV.click_onElement((WebElement) radioButton);
                break;
            } else {
                if (driver.findElements(By.className("govuk-pagination__next")).isEmpty()) {
                    lastPage = true;
                } else {
                    log.info("Clicking next pagination");
                    clickNextPagination();
                }
            }
        }
    }
}

