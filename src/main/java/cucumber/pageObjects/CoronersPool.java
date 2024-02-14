package cucumber.pageObjects;

import cucumber.testdata.DatabaseTester;
import cucumber.utils.AngularJsHTTPCallWait;
import cucumber.utils.WaitUtil_v2;
import cucumber.utils.WaitUtils;
import org.apache.log4j.Logger;
import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;

import java.sql.SQLException;
import java.util.List;

public class CoronersPool {

    private static WebDriver driver;
    private static final Logger log = Logger.getLogger(Search.class);
    private final WaitUtils wait;
    private final WaitUtil_v2 wait1;
    private final AngularJsHTTPCallWait aJsWait;
    private final NavigationShared NAV;
    private final DatabaseTester DBT;
    private final DatabaseTester DBTNSD;

    public CoronersPool(WebDriver driver) {
        CoronersPool.driver = driver;
        PageFactory.initElements(driver, this);
        wait = new WaitUtils(driver);
        wait1 = new WaitUtil_v2(driver);
        aJsWait = new AngularJsHTTPCallWait(driver);
        NAV = new NavigationShared(driver);
        DBT = new DatabaseTester();
        DBTNSD = new DatabaseTester();
    }

    @FindBy(xpath = "//dt[text()[contains(.,'Date requested')]]/../dd")
    WebElement requestedOnDateCoroners;
    @FindBy(xpath = "//dt[text()[contains(.,'Jurors requested')]]/../dd")
    WebElement numberOfJurorsCoroners;

    @FindBy(id = "courtName")
    WebElement coronersCourtName;
    @FindBy(id = "courtLocCode")
    WebElement coronersCourtCode;

    @FindBy(id = "poolType")
    WebElement coronersPoolType;

    @FindBy(xpath = "//div/span[text()[contains(.,'Pool capacity')]]//ancestor::div/span/span[text()[contains(.,'/')]]")
    WebElement coronersCapacity;

    @FindBy(xpath = "//div/span[text()[contains(.,'Pool summary')]]//ancestor::div/span/span")
    WebElement coronersNumberAdded;

    @FindBy(xpath = "//dt[text()[contains(.,'Name')]]/../dd")
    WebElement requestedByNameCoroners;

    @FindBy(xpath = "//dt[text()[contains(.,'Email')]]/../dd")
    WebElement requestedByEmailCoroners;

    @FindBy(xpath = "//dt[text()[contains(.,'Phone')]]/../dd")
    WebElement requestedByPhoneCoroners;

    @FindBy(xpath = "//a[text()[contains(.,'Create a coroner')]]")
    WebElement createCoronerPoolButton;

    @FindBy(xpath = "//dd[2]/a[text()[contains(.,'Change')]]")
    WebElement changeCoronerPoolRequestDetailsLink;

    @FindBy(xpath = "//dl[2]/div[1]/dd[2]/a")
    WebElement changeCoronerPoolRequestedByLink;

    @FindBy(id = "requestedDateDay")
    WebElement todayDayField;

    @FindBy(id = "requestedDateMonth")
    WebElement todayMonthField;

    @FindBy(id = "requestedDateYear")
    WebElement todayYearField;

    @FindBy(id = "requestedDate")
    WebElement todayDateField;

    @FindBy(xpath = "//div[@class=\"after-header__pool-record-number\"]/h1")
    WebElement coronersPoolNumber;

    @FindBy(xpath = "//div[2]/label")
    WebElement firstPostCodeVotersCount;

    @FindBy(xpath = "//div[2]/input")
    public
    WebElement firstPostCodeVotersInput;

    public void clickCreateCoronerPool() {
        log.info("Clicking on create coroners pool button");
        createCoronerPoolButton.click();
    }

    public void changeCoronerPoolRequestDetails() {
        log.info("Clicking on change coroners pool request details");
        changeCoronerPoolRequestDetailsLink.click();
    }

    public void changeCoronerPoolRequestedBy() {
        log.info("Clicking on change coroners pool request details");
        changeCoronerPoolRequestedByLink.click();
    }

    public String getRequestedOnDateCoroners() {
        log.info("Getting requested on date coroners");
        return requestedOnDateCoroners.getText();
    }

    public String getNumberOfJurorsCoroners() {
        log.info("Getting number of jurors coroners");
        return numberOfJurorsCoroners.getText();
    }

    public String getCoronersCourtName() {
        log.info("Getting coroners court name");
        return coronersCourtName.getText();
    }
    public String getCoronersCourtCode() {
        log.info("Getting coroners court code");
        return coronersCourtCode.getText();
    }
    public String getCoronersPoolType() {
        log.info("Getting coroners pool type");
        return coronersPoolType.getText();
    }
    public String getCoronersCapacity() {
        log.info("Getting coroners capacity");
        return coronersCapacity.getText().substring(1);
    }

    public String getCoronersNumberAdded() {
        log.info("Getting coroners number added");
        return coronersNumberAdded.getText();
    }


    public Integer getCoronersRowsOfCitizens() {
        List<WebElement> rowsOfCitizens = driver.findElements(By.xpath("//tr"));

        if (rowsOfCitizens.size()>0)
                return rowsOfCitizens.size() - 1;
        else
            return rowsOfCitizens.size();
            }


    public String getRequestedByNameCoroners() {
        log.info("Getting requested by name coroners");
        return requestedByNameCoroners.getText();
    }

    public String getRequestedByEmailCoroners() {
        log.info("Getting requested by email coroners");
        return requestedByEmailCoroners.getText();
    }

    public String getRequestedByPhoneCoroners() {
        log.info("Getting requested by phone coroners");
        return requestedByPhoneCoroners.getText();
    }

    public String checkCoronerDayRequested() {
        log.info("Checking date is today's date");
        return todayDayField.getAttribute("value");
    }

    public String checkCoronerMonthRequested() {
        log.info("Checking date is today's date");
        return todayMonthField.getAttribute("value");
    }

    public String checkCoronerYearRequested() {
        log.info("Checking date is today's date");
        return todayYearField.getAttribute("value");
    }

    public String checkCoronerDateRequested() {
        log.info("Checking date is today's date");
        return todayDateField.getAttribute("value");
    }
    public int getCoronerPoolNextNumber() throws SQLException {
        log.info("Getting the next coroner pool number from DB");
        return DBTNSD.getCoronerPoolNoNSD();
    }

    public String coronersPoolNumber() {
        log.info("Getting coroners pool no displayed on page");
        return coronersPoolNumber.getText();
    }

    public Integer firstPostCodeVotersCount() {
        log.info("Getting the voters count for the first postcode on page");
        String votersCountOnPage = firstPostCodeVotersCount.getText().substring(3);
        Integer votersCountOnPageNumberOnly = Integer.valueOf(votersCountOnPage.replaceAll("[^0-9]", ""));
        return votersCountOnPageNumberOnly;
    }

    public void enterNewCoronerRequestedOnDate(String todayDateFull) {
        log.info("Setting coroners pool requested on date to a date in the future");
        todayDateField.clear();
        todayDateField.sendKeys(todayDateFull);

        }

    public void coronersPoolCitizensResultsTableHeaderExists(String headerName) throws Exception {
        log.info("I see header =>" + headerName);
        wait.activateImplicitWait();
        WebElement coronerPoolCitizensResultsHeader = driver.findElement(By.xpath("//button[contains(text(),\"" + headerName + "\")]"));
        coronerPoolCitizensResultsHeader.isDisplayed();
    }

    public void coronerPoolStatusIs(String poolStatus) throws Exception {
        log.info("I see status is =>" + poolStatus);
        wait.activateImplicitWait();
        WebElement coronerPoolStatusIs = driver.findElement(By.xpath("//strong[text()[contains(.,\"" + poolStatus + "\")]]"));
        coronerPoolStatusIs.isDisplayed();
    }

    public Boolean    exportPoolButtonInvisible() {
        List<WebElement> elements = driver.findElements(By.id("exportPoolButton"));
        return elements.isEmpty();

    }

}
