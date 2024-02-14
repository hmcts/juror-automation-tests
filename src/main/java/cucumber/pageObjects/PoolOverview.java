package cucumber.pageObjects;

import cucumber.utils.AngularJsHTTPCallWait;
import cucumber.utils.WaitUtil_v2;
import cucumber.utils.WaitUtils;
import org.apache.log4j.Logger;
import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;

public class PoolOverview {

    private static WebDriver driver;
    private static final Logger log = Logger.getLogger(Search.class);
    private final WaitUtils wait;
    private final WaitUtil_v2 wait1;
    private final AngularJsHTTPCallWait aJsWait;
    private final NavigationShared NAV;

    public PoolOverview(WebDriver driver) {
        PoolOverview.driver = driver;
        PageFactory.initElements(driver, this);
        wait = new WaitUtils(driver);
        wait1 = new WaitUtil_v2(driver);
        aJsWait = new AngularJsHTTPCallWait(driver);
        NAV = new NavigationShared(driver);
    }

    @FindBy(xpath = "//span[contains(text(),'Court name')]/following-sibling::span")
    WebElement courtName;

    @FindBy(xpath = "//span[contains(text(),'Court location code')]/following-sibling::span")
    WebElement courtLocationCode;

    @FindBy(xpath = "//span[contains(text(),'Court start date')]/following-sibling::span")
    WebElement courtStartDate;

    @FindBy(xpath = "//span[contains(text(),'Court start date')]//ancestor::div/span[2]")
    WebElement overviewCourtStartDate;

    @FindBy(xpath = "//span[contains(text(),'Additional requirements')]/following-sibling::span")
    WebElement additionalRequirements;

    @FindBy(xpath = "//div[@class='bullet required']/../span")
    WebElement numberOfJurorsRequested;

    @FindBy(xpath = "//div[@class='bullet available']/following-sibling::span[@class='amount']")
    WebElement numberOfJurorsConfirmed;

    @FindBy(xpath = "//div[@class='bullet unavailable']/following-sibling::span[@class='amount']")
    WebElement numberOfJurorsUnavailable;

    @FindBy(xpath = "//div[@class='bullet unresolved']/following-sibling::span[@class='amount']")
    WebElement numberOfJurorsNotResponded;

    @FindBy(xpath = "//div[@class='bullet surplus']/following-sibling::span[@class='amount']")
    WebElement numberOfJurorsSurplus;

    @FindBy(id = "deletePoolButton")
    WebElement deleteButton;

    @FindBy(id = "cancelLink")
    WebElement cancelLink;

    @FindBy(xpath = "//div[@class='total']/span[@class='number']")
    WebElement numberOfJurorsSummoned;

    @FindBy(xpath = "//div[@class=\"pool-values__summary\"]/span[2]")
    WebElement currentPoolSize;

    @FindBy(className = "govuk-heading-l")
    WebElement heading;

    @FindBy(xpath = "//*[@id=\"main-content\"]/div[1]/div/div/strong")
    WebElement status;

    @FindBy(id = "poolJurorReassign")
    WebElement jurorsTable;

    public String getCourtName() {
        log.info("Getting court name");
        return courtName.getText();
    }

    public String getCourtLocationCode() {
        log.info("Getting court location code");
        return courtLocationCode.getText();
    }

    public String getCourtStartDate() {
        log.info("Getting court start date");
        return courtStartDate.getText();
    }

    public String getConvertedStartDate() throws ParseException {
        String overviewStartDate = overviewCourtStartDate.getText();

        DateFormat df = new SimpleDateFormat("EEEE dd MMM yyyy");
        Date convertedStartDate = df.parse(overviewStartDate);

        String newDateFormat = "EEEE dd MMMM yyyy";
        String newStartDate = new SimpleDateFormat(newDateFormat).format(convertedStartDate);

        log.info("Getting court start date");
        return newStartDate;
    }

    public String getAdditionalRequirements() {
        log.info("Getting additional requirements");
        return additionalRequirements.getText();
    }

    public String getNumberOfJurorsRequested() {
        log.info("Getting number of jurors requested");
        return numberOfJurorsRequested.getText();
    }

    public String getNumberOfJurorsConfirmed() {
        log.info("Getting number of jurors confirmed");
        return numberOfJurorsConfirmed.getText();
    }

    public String getNumberOfJurorsUnavailable() {
        log.info("Getting number of jurors unavailable");
        return numberOfJurorsUnavailable.getText();
    }

    public String getNumberOfJurorsNotResponded() {
        log.info("Getting number of jurors not responded");
        return numberOfJurorsNotResponded.getText();
    }

    public String getNumberOfJurorsSurplus() {
        log.info("Getting number of jurors surplus");
        return numberOfJurorsSurplus.getText();
    }

    public String getNumberOfJurorsSummoned() {
        log.info("Getting number of jurors summoned");
        return numberOfJurorsSummoned.getText();
    }

    public String getNumberOfJurorsRequired() {
        log.info("Getting number of jurors required");
        return numberOfJurorsRequested.getText();
    }

    public String getCurrentPoolSize() {
        log.info("Getting current pool size");
        return currentPoolSize.getText();
    }

    public void clickDelete() {
        log.info("Clicking delete pool request");
        deleteButton.click();
    }

    public void clickCancel() {
        log.info("Clicking cancel");
        cancelLink.click();
    }

    public String getHeading() {
        log.info("Getting heading");
        return heading.getText();
    }

    public String getStatus() {
        log.info("Getting status");
        return status.getText();
    }

    public boolean statusExists() {
        By statusLocator = By.xpath("//*[@id=\"main-content\"]/div[1]/div/div/strong");
        List<WebElement> status = driver.findElements(statusLocator);
        if (status.size() > 0) {
            return true;
        } else {
            return false;
        }
    }

    public Map<String, String> getPoolOverviewDetails() {
        log.info("Getting pool overview details for pool: " + getHeading());
        Map<String, String> data = new HashMap<>();
        data.put("poolRecord", getHeading());
        data.put("court", getCourtName());
        data.put("courtCode", getCourtLocationCode());
        data.put("courtStartDate", getCourtStartDate());
        return data;
    }

    public String getJurorTableRow(int index){
        log.info("Getting row " + index + " in juror table");
        List<WebElement> jurorRows = jurorsTable.findElements(By.tagName("tr"));
        WebElement jurorRow = jurorRows.get(index);
        List<WebElement> jurorDetails = jurorRow.findElements(By.tagName("td"));
        String jurorNumber = jurorDetails.get(0).getText();
        String firstName = jurorDetails.get(1).getText();
        String lastName = jurorDetails.get(2).getText();
        String postcode = jurorDetails.get(3).getText();
        String owner = jurorDetails.get(4).getText();
        String status = jurorDetails.get(5).getText();
        String details = jurorNumber + ", " + firstName + ", " + lastName + ", " + postcode + ", " + owner + ", " + status;
        return details;
    }

    public String getJurorNumberInRow(int row){
        log.info("Getting juror number in row " + row + " of juror table");
        List<WebElement> jurorRows = jurorsTable.findElements(By.tagName("tr"));
        WebElement jurorRow = jurorRows.get(row);
        List<WebElement> jurorDetails = jurorRow.findElements(By.tagName("td"));
        String jurorNumber = jurorDetails.get(1).getText();
        return jurorNumber;
    }
    public String[] historyHeaderAndDescInPos(int posInList){
        String[] elementsInPosition;
        String historyHeader = driver.findElement(By.xpath("//*[@class='moj-timeline__item'][" + posInList + "]/div[1]/h2")).getText();
        String historyDesc = driver.findElement(By.xpath("//*[@class='moj-timeline__item'][" + posInList + "]/div[2]/p")).getText();
        String historyTime = driver.findElement(By.xpath("//*[@class='moj-timeline__item'][" + posInList + "]/p/time")).getText();

        elementsInPosition = new String[]{
                historyHeader,
                historyDesc,
                historyTime
        };
        return elementsInPosition;

    }

}
