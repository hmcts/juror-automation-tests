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

import java.util.List;

public class CheckPoolRequest {

    private static WebDriver driver;
    private static final Logger log = Logger.getLogger(Search.class);
    private final WaitUtils wait;
    private final WaitUtil_v2 wait1;
    private final AngularJsHTTPCallWait aJsWait;
    private final NavigationShared NAV;

    public CheckPoolRequest(WebDriver driver) {
        CheckPoolRequest.driver = driver;
        PageFactory.initElements(driver, this);
        wait = new WaitUtils(driver);
        wait1 = new WaitUtil_v2(driver);
        aJsWait = new AngularJsHTTPCallWait(driver);
        NAV = new NavigationShared(driver);
    }

    @FindBy(className = "govuk-heading-l")
    WebElement heading;

    @FindBy(xpath = "//dt[text()[contains(.,'Court name')]]/../dd")
    WebElement courtName;

    @FindBy(xpath = "//dt[text()[contains(.,'Attendance date')]]/../dd")
    WebElement attendanceDate;

    @FindBy(xpath = "//a[@href='#citizensToSummon']")
    WebElement numberOfCitizensSummonedError;
    @FindBy(xpath = "//dt[text()[contains(.,'Pool type')]]/../dd")
    WebElement poolType;

    @FindBy(xpath = "//dt[text()[contains(.,'Additional')]]/../dd")
    WebElement additionalRequirements;

    @FindBy(xpath = "//dt[text()[contains(.,'Number of jurors')]]/../dd")
    WebElement numberOfJurors;

    @FindBy(xpath = "//dt[text()[contains(.,'Date requested')]]/../dd")
    WebElement requestedOnDateCoroners;
    @FindBy(xpath = "//dt[text()[contains(.,'Jurors requested')]]/../dd")
    WebElement numberOfJurorsCoroners;

    @FindBy(xpath = "//dt[text()[contains(.,'Name')]]/../dd")
    WebElement requestedByNameCoroners;

    @FindBy(xpath = "//dt[text()[contains(.,'Email')]]/../dd")
    WebElement requestedByEmailCoroners;

    @FindBy(xpath = "//dt[text()[contains(.,'Phone')]]/../dd")
    WebElement requestedByPhoneCoroners;

    @FindBy(xpath = "//dt[text()[contains(.,'deferrals')]]/../dd"
            + " | "
            + "//dl[@id='numberOfCourtDeferrals']/*/dd")
    WebElement numberOfDeferrals;

    @FindBy(xpath = "//dt[text()[contains(.,'additional jurors')]]/../dd")
    WebElement numberOfAdditionalJurors;


//@FindBy(xpath = "//div[@class='govuk-summary-list__row']/dt[contains(text(),'Pool number')]/following-sibling::dd[1]")
    @FindBy(xpath = "//dl[2]/div[2]/dd")
    WebElement poolNumber;

    @FindBy(xpath = "//div[@class='govuk-summary-list__row']/dt[text()[contains(.,'Pool number')]]//ancestor::div[@class='govuk-summary-list__row']/dd[@class='govuk-summary-list__value']")
    WebElement newPoolRequestNumber;

    @FindBy(xpath = "//dt[@class='govuk-summary-list__key'][contains(text(),'Pool number')]//ancestor::div/dd")
    WebElement newCourtPoolRequestNumber;

    @FindBy(xpath = "//button[@class=\"govuk-button\"]")
    WebElement requestButton;

    @FindBy(linkText = "Change")
    WebElement changeLink;

    public String getHeading() {
        log.info("Getting heading");
        return heading.getText();
    }

    public String getCourtName() {
        log.info("Getting court name");
        return courtName.getText();
    }

    public String getAttendanceDate() {
        log.info("Getting attendance date");
        return attendanceDate.getText();
    }

    public String getPoolType() {
        log.info("Getting pool type");
        return poolType.getText();
    }

    public String getAdditionalRequirements() {
        log.info("Getting additional requirements");
        return additionalRequirements.getText();
    }

    public String getNumberOfJurors() {
        log.info("Getting number of jurors");
        return numberOfJurors.getText();
    }


    public String getNumberOfDeferrals() {
        log.info("Getting number of deferrals");
        return numberOfDeferrals.getText();
    }

    public String getNumberOfAdditionalJurors() {
        log.info("Getting number of additional jurors");
        return numberOfAdditionalJurors.getText();
    }

    public String getPoolNumber() {
        log.info("Getting pool number "+poolNumber.getText());
        return poolNumber.getText();
    }

    public Boolean poolNumberNotVisible() {
        List<WebElement> elements = driver.findElements(By.xpath("//dl[2]/div[2]/dd"));
        return elements.isEmpty();

    }

    public String getNewPoolRequestNumber() {
        log.info("Getting pool number "+newPoolRequestNumber.getText());
        return newPoolRequestNumber.getText();
    }

    public String getCourtNewPoolRequestNumber() {
        log.info("Getting pool number "+newCourtPoolRequestNumber.getText());
        return newCourtPoolRequestNumber.getText();
    }

    public String getNewPoolAttendanceDate() {
        log.info("Getting pool attendance date");
        return attendanceDate.getText();
    }

    public String getNumberOfCitizensSummonedError() {
        log.info("Getting pool attendance date");
        return numberOfCitizensSummonedError.getText();
    }

    public void clickChangeLink() {
        log.info("Click change link");
        changeLink.click();
    }

    public void submitRequest() {
        log.info("Submitting request");
        requestButton.click();
    }



}
