package cucumber.pageObjects;

import cucumber.utils.AngularJsHTTPCallWait;
import cucumber.utils.WaitUtil_v2;
import cucumber.utils.WaitUtils;
import org.apache.log4j.Logger;
import org.openqa.selenium.*;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import org.openqa.selenium.support.ui.ExpectedCondition;
import org.openqa.selenium.support.ui.WebDriverWait;

import java.time.Duration;
import java.util.List;

public class DeferralMaintenance {

    private static WebDriver driver;
    private static final Logger log = Logger.getLogger(Search.class);
    private final WaitUtils wait;
    private final WaitUtil_v2 wait1;
    private final AngularJsHTTPCallWait aJsWait;
    private final NavigationShared NAV;

    public DeferralMaintenance(WebDriver driver) {
        DeferralMaintenance.driver = driver;
        PageFactory.initElements(driver, this);
        wait = new WaitUtils(driver);
        wait1 = new WaitUtil_v2(driver);
        aJsWait = new AngularJsHTTPCallWait(driver);
        NAV = new NavigationShared(driver);
    }

    @FindBy(xpath = "//*[@id=\"main-content\"]/div/div/h1")
    WebElement pageHeading;

    @FindBy(xpath = "//*[@id=\"main-content\"]/div/div/h2")
    WebElement courtName;

    @FindBy(id = "deferral-maintenance-show-filter")
    WebElement showFilterButton;

    @FindBy(xpath = "//span[contains(text(),'Add to a pool')]")
    WebElement addToAPoolButton;

    @FindBy(xpath = "//span[contains(text(),'Postpone')]")
    WebElement postponeButton;

    @FindBy(id = "deferral-selected-count")
    WebElement selectedCount;

    @FindBy(id = "deferral-total-count")
    WebElement totalCount;

    @FindBy(xpath = "//*[@id=\"deferral-maintenance-table-wrapper\"]/div/table")
    WebElement deferralsTable;

    @FindBy(id="deferral-all")
    WebElement selectAllCheckBox;

    @FindBy(xpath = "//*[@id=\"deferral-maintenance-table-wrapper\"]/div/table/thead/tr/th[2]/a[@id=\"jurorNumber\"]")
    WebElement jurorNumberTableHeading;

    @FindBy(xpath = "//*[@id=\"deferral-maintenance-table-wrapper\"]/div/table/thead/tr/th[3]/a[@id=\"firstName\"]")
    WebElement firstNameTableHeading;

    @FindBy(xpath = "//*[@id=\"deferral-maintenance-table-wrapper\"]/div/table/thead/tr/th[4]/a[@id=\"lastName\"]")
    WebElement lastNameTableHeading;

    @FindBy(xpath = "//*[@id=\"deferral-maintenance-table-wrapper\"]/div/table/thead/tr/th[5]/a[@id=\"poolNumber\"]")
    WebElement poolNumberTableHeading;

    @FindBy(xpath = "//*[@id=\"deferral-maintenance-table-wrapper\"]/div/table/thead/tr/th[6]/a[@id=\"deferredTo\"]")
    WebElement deferredToTableHeading;

    @FindBy(xpath = "//*[@id=\"poolNumber\"]/div[1]/table")
    WebElement activePoolsTable;

    @FindBy(id="deferral-maintenance-filter")
    WebElement filterPanel;

    @FindBy(id="jurorNumber")
    WebElement jurorNumberFilter;

    @FindBy(id="firstName")
    WebElement firstNameFilter;

    @FindBy(id="lastName")
    WebElement lastNameFilter;

    @FindBy(id="deferredTo")
    WebElement deferredToFilter;

    @FindBy(id="applyFiltersButton")
    WebElement applyFiltersButton;

    @FindBy(id="clearFiltersLink")
    WebElement clearFiltersLink;

    @FindBy(className = "govuk-pagination__list")
    WebElement paginationLinks;

    @FindBy(xpath = "//a[@id='jurorNumber']")
    WebElement jurorNumberTableHeader;

    public void clickJurorNumberHeader() {
        jurorNumberTableHeader.click();
    }
    public void waitforPageLoad()

    {
        waitForPageLoad(driver) ;
    }

    public  void waitForPageLoad(WebDriver driver) {
        ExpectedCondition<Boolean> pageLoadCondition = new
                ExpectedCondition<Boolean>() {
                    public Boolean apply(WebDriver driver) {
                        return ((JavascriptExecutor)driver).executeScript("return document.readyState").equals("complete");
                    }
                };
        WebDriverWait wait = new WebDriverWait(driver, Duration.ofSeconds(30));
        wait.until(pageLoadCondition);
    }
    public String getPageHeading(){
        log.info("Getting page heading");
        return pageHeading.getText();
    }

    public String getCourtName(){
        log.info("Getting court name");
        return courtName.getText();
    }

    public void clickShowFilterButton(){
        log.info("Clicking show filter button");
        int maxRetries = 2;
        int retryCount = 0;
        StaleElementReferenceException lastException = null;

        while (retryCount < maxRetries) {
            try {
                showFilterButton.click();
                return;
            } catch (StaleElementReferenceException e) {
                lastException = e;
                retryCount++;

                if (retryCount == maxRetries) break;

                PageFactory.initElements(driver, this);

                try {
                    Thread.sleep(200);
                } catch (InterruptedException ie) {
                    Thread.currentThread().interrupt();
                }
            }
        }

        log.error("Failed to click show filter button due to stale element: " +
                (lastException != null ? lastException.getMessage() : "unknown error"));
        throw new RuntimeException("Unable to click show filter button after retries.");
    }

    public void clickAddToAPoolButton(){
        log.info("Clicking add to a pool button");
        addToAPoolButton.click();
    }

    public void clockPostponeButton(){
        log.info("Clicking postpone button");
        postponeButton.click();
    }

    public String getSelectedCount(){
        log.info("Getting selected count");
        return selectedCount.getText();
    }

    public String getTotalCount(){
        log.info("Getting total count");
        return totalCount.getText();
    }

    public void clickSelectAllCheckbox(){
        log.info("Clicking select all checkbox");
        selectAllCheckBox.click();
    }

    public String getJurorNumberTableHeading(){
        log.info("Getting juror number table heading");
        return jurorNumberTableHeading.getText();
    }

    public void clickJurorNumberTableHeading(){
        log.info("Clicking juror number table heading");
        jurorNumberTableHeading.click();
    }

    public String getFirstNameTableHeading(){
        log.info("Getting first name table heading");
        return firstNameTableHeading.getText();
    }

    public void clickFirstNameTableHeading(){
        log.info("Clicking first name table heading");
        firstNameTableHeading.click();
    }

    public String getLastNameTableHeading(){
        log.info("Getting last name table heading");
        return lastNameTableHeading.getText();
    }

    public void clickLastNameTableHeading(){
        log.info("Clicking last name table heading");
        lastNameTableHeading.click();
    }

    public String getPoolNumberTableHeading(){
        log.info("Getting pool number table heading");
        return poolNumberTableHeading.getText();
    }

    public void clickPoolNumberTableHeading(){
        log.info("Clicking pool number table heading");
        poolNumberTableHeading.click();
    }

    public String geDeferredToTableHeading(){
        log.info("Getting deferred to table heading");
        return deferredToTableHeading.getText();
    }

    public void clickDeferredToTableHeading(){
        log.info("Clicking deferred to table heading");
        deferredToTableHeading.click();
    }

    public void filterByJurorNumber(String jurorNumber){
        log.info("Inputting juror number filter");
        jurorNumberFilter.sendKeys(jurorNumber);
    }

    public void filterByFirstName(String firstName){
        log.info("Inputting first name filter");
        firstNameFilter.sendKeys(firstName);
    }

    public void filterByLastName(String lastName){
        log.info("Inputting last name filter");
        lastNameFilter.sendKeys(lastName);
    }

    public void filterByDeferredTo(String date){
        log.info("Inputting deferred to filter");
        deferredToFilter.sendKeys(date);
    }

    public void clickApplyFiltersButton(){
        log.info("Clicking apply filters button");
        applyFiltersButton.click();
    }

    public void clickClearFiltersLink(){
        log.info("Clicking clear filters link");
        clearFiltersLink.click();
    }

    public String getDeferralTableRow(int index){
        log.info("Getting row " + index + " in deferral table");
        List<WebElement> deferralRows = deferralsTable.findElements(By.tagName("tr"));
        WebElement jurorDeferral = deferralRows.get(index);
        List<WebElement> deferralDetails = jurorDeferral.findElements(By.tagName("td"));
        String jurorNumber = deferralDetails.get(1).getText();
        String firstName = deferralDetails.get(2).getText();
        String lastName = deferralDetails.get(3).getText();
        String poolNumber = deferralDetails.get(4).getText();
        String deferredTo = deferralDetails.get(5).getText();
        String details = jurorNumber + ", " + firstName + ", " + lastName + ", " + poolNumber + ", " + deferredTo;
        return details;
    }

    public String getFirstDeferralTableRow(){
        return getDeferralTableRow(1);
    }

    public String getLastDeferralTableRow(){
        return getDeferralTableRow( deferralsTable.findElements(By.tagName("tr")).size()-1);
    }

    public String getNthLastDeferralTableRow(int index){
        return getDeferralTableRow( deferralsTable.findElements(By.tagName("tr")).size()-index);
    }

    public void clickJurorNumber(int index){
        List<WebElement> deferralRows = deferralsTable.findElements(By.tagName("tr"));
        WebElement jurorDeferral = deferralRows.get(index);
        List<WebElement> deferralDetails = jurorDeferral.findElements(By.tagName("td"));
        log.info("Clicking juror number: " + index);
        deferralDetails.get(index).click();
    }

    public void selectJurorFromTable(String jurorNumber){
        WebElement selectCheckbox = driver.findElement(By.id("deferral-"+ jurorNumber));
        log.info("Clicking select checkbox for: " + jurorNumber);
        selectCheckbox.sendKeys(Keys.SPACE);
    }

    public void selectActivePool(String poolNumber){
        WebElement selectPool = driver.findElement(By.id("pool-"+ poolNumber));
        log.info("Selecting pool: " + poolNumber);
        selectPool.click();
    }

    public void clickLastPaginationItem(){
        if (driver.findElements(By.className("govuk-pagination__list")).size() > 0) {
            List<WebElement> paginationItems = paginationLinks.findElements(By.tagName("li"));
            WebElement lastPaginationLink = paginationItems.get(paginationItems.size()-1);
            log.info("Navigating to last page of deferral table");
            lastPaginationLink.click();
        }
    }

}
