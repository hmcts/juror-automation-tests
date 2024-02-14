package cucumber.pageObjects;

import org.apache.log4j.Logger;
import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;

import java.util.List;

public class PoolSearch {

    private static WebDriver driver;
    private static final Logger log = Logger.getLogger(PoolSearch.class);

    public PoolSearch(WebDriver webDriver) {
        PoolSearch.driver = webDriver;
        PageFactory.initElements(driver, this);
    }

    @FindBy(id = "poolNumber")
    WebElement poolNo;

    @FindBy(id = "courtNameOrLocation")
    WebElement locationCode;

    @FindBy(id = "serviceStartDate")
    WebElement serviceStartDate;

    @FindBy(id = "poolStatus")
    WebElement poolRequested;

    @FindBy(id = "poolStatus-2")
    WebElement poolActive;

    @FindBy(id = "poolStatus-3")
    WebElement poolCompleted;

    @FindBy(id = "poolStage")
    WebElement withTheBureau;

    @FindBy(id = "poolStage-2")
    WebElement atCourt;

    @FindBy(id = "poolType")
    WebElement crownCourt;

    @FindBy(id = "poolType-2")
    WebElement civilCourt;

    @FindBy(id = "poolType-3")
    WebElement highCourt;

    @FindBy(css = "#advancedSearch span")
    WebElement expandAdvanced;

    @FindBy(xpath = "//button[@type='submit']")
    WebElement continueButton;

    @FindBy(className = "after-header__pool-record-label")
    WebElement poolRecordHeader;

    @FindBy(css = "div h2")
    WebElement poolSearchError;

    @FindBy(xpath = "//div[@class='govuk-grid-column-full']/h3")
    WebElement poolSearchResultsTableHeader;

    @FindBy(className = "govuk-table__body")
    WebElement poolSearchResultsTable;
    @FindBy(className = "govuk-pagination__next")
    public
    WebElement nextButton;



    public void enterPoolNo(String text) {
        poolNo.sendKeys(text);
    }

    public void enterLocationCode(String text) {
        locationCode.sendKeys(text);
    }

    public void enterServiceStartDate(String text) {
        serviceStartDate.sendKeys(text);
    }

    public void clickAdvancedSearch() {
        expandAdvanced.click();
    }

    public void clickPoolRequested() { poolRequested.click(); }

    public void clickPoolActive() { poolActive.click(); }

    public void clickPoolCompleted() { poolCompleted.click(); }

    public void clickWithTheBureau() { withTheBureau.click(); }

    public void clickAtCourt() { atCourt.click(); }

    public void clickCrownCourt() { crownCourt.click(); }

    public void clickCivilCourt() { civilCourt.click(); }

    public void clickHighCourt() {
        highCourt.click();
    }

    public void clickContinue() {
        continueButton.click();
    }

    public boolean poolRequestedIsSelected() { return poolRequested.isSelected(); }

    public boolean poolActiveIsSelected() { return poolActive.isSelected(); }

    public boolean poolCompletedIsSelected() { return poolCompleted.isSelected(); }

    public boolean withTheBureauIsSelected() { return withTheBureau.isSelected(); }

    public boolean atCourtIsSelected() { return atCourt.isSelected(); }

    public boolean crownCourtIsSelected() { return crownCourt.isSelected(); }

    public boolean civilCourtIsSelected() { return civilCourt.isSelected(); }

    public boolean highCourtIsSelected() { return highCourt.isSelected(); }

    public boolean poolRecordIsDisplayed() {
        return poolRecordHeader.isDisplayed();
    }

    public String getPoolSearchErrorText() {
        return poolSearchError.getText();
    }

    public String getPoolSearchResultText(){
        return poolSearchResultsTableHeader.getText();
    }

    public Integer getPoolSearchNumberOfResults(){
        By element = By.className("govuk-pagination__next");
        List <WebElement> nextNavButton = driver.findElements(element) ;
        int numberOfRows = 0;
        if(!nextNavButton.isEmpty()) while (!nextNavButton.isEmpty()) {
            numberOfRows = numberOfRows + poolSearchResultsTable.findElements(By.tagName("tr")).size();
            log.info("Number of rows: " + numberOfRows);
            nextButton.click();
            nextNavButton = driver.findElements(element);
        }
        if(nextNavButton.isEmpty()) {
            numberOfRows = numberOfRows + poolSearchResultsTable.findElements(By.tagName("tr")).size();
            log.info("Number of rows: " + numberOfRows);
        }

        return numberOfRows;
    }

    public void clickPoolNumberInSearchList(String poolnumber) {

        try {
            if (driver.findElement(By.xpath("//a[contains(text(),'" + poolnumber + "' )]")).isDisplayed()) {
                driver.findElement(By.xpath("//input[@id='pool-"+ poolnumber + "']")).click();
            }

        } catch (Exception e) {
            log.info("Received error when searching for the expected pool number from the ressign list");
            log.info(e);
        }
    }
}

