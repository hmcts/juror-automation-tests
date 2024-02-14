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

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class AdditionalSummons {

    private static WebDriver driver;
    private static final Logger log = Logger.getLogger(Search.class);
    private final WaitUtils wait;
    private final WaitUtil_v2 wait1;
    private final AngularJsHTTPCallWait aJsWait;
    private final NavigationShared NAV;

    public AdditionalSummons(WebDriver driver) {
        AdditionalSummons.driver = driver;
        PageFactory.initElements(driver, this);
        wait = new WaitUtils(driver);
        wait1 = new WaitUtil_v2(driver);
        aJsWait = new AngularJsHTTPCallWait(driver);
        NAV = new NavigationShared(driver);
    }

    @FindBy(className = "govuk-caption-l")
    WebElement poolNumber;

    @FindBy(xpath = "//*[@id=\"main-content\"]/div/div/form/p[1]")
    WebElement jurorsRequested;

    @FindBy(xpath = "//*[@id=\"main-content\"]/div/div/form/p[2]")
    WebElement jurorsConfirmed;

    @FindBy(xpath = "//*[@id=\"main-content\"]/div/div/form/p[3]")
    WebElement jurorsRequired;

    @FindBy(xpath = "//*[@id=\"main-content\"]/div/div/form/p[4]")
    WebElement citizensSummoned;

    @FindBy(xpath = "//*[@id=\"catchmentArea\"]/div/dd[1]")
    WebElement catchmentArea;

    @FindBy(id = "citizensToSummon")
    WebElement extraCitizensToSummon;

    @FindBy(xpath = "//*[@class='govuk-error-summary']")
    WebElement respondedError;

    @FindBy(xpath = "//*[@class='govuk-error-summary']/div/ul/li/a")
    WebElement respondedErrorText;

    @FindBy(xpath = "//*[@id=\"catchmentArea\"]/div/dd[2]/a")
    WebElement changeCatchmentAreaLink;

    @FindBy(id = "postcodes")
    WebElement postcodes;

    public String getPoolNumber(){
        log.info("Getting pool number");
        // Remove "Pool Number " from string
        String poolNo = poolNumber.getText().substring(5);
        return poolNo;
    }

    public String getJurorsRequested(){
        log.info("Getting jurors requested");
        // Remove "Jurors Requested \n " from string
        return jurorsRequested.getText().substring(17);
    }

    public String getJurorsConfirmed(){
        log.info("Getting jurors confirmed");
        // Remove "Jurors confirmed \n " from string
        return jurorsConfirmed.getText().substring(17);
    }

    public String getJurorsRequired(){
        log.info("Getting jurors required to complete the request");
        // Remove "jurors required to complete the request \n " from string
        return jurorsRequired.getText().substring(40);
    }

    public String getCitizensSummoned(){
        log.info("Getting citizens summoned");
        // Remove "Citizens summoned \n " from string
        return citizensSummoned.getText().substring(18);
    }

    public String getCatchmentArea(){
        log.info("Getting catchment area");
        return catchmentArea.getText();
    }

    public void setExtraCitizensToSummon(String noCitizens){
        log.info("Setting extra citizens to summon to " + noCitizens);
        extraCitizensToSummon.sendKeys(noCitizens);
    }

    public boolean errorIsPresent() {
        return respondedError.isDisplayed();
    }

    public String getErrorText() {
        return respondedErrorText.getText();
    }

    public void clickChangeCatchmentAreaLink(){
        log.info("Clicking change catchment area link");
        changeCatchmentAreaLink.click();
    }

    public void clickAllPostcodeCheckboxes(){
        List<WebElement> checkboxes = postcodes.findElements(By.tagName("input"));
        for(int i = 0; i < checkboxes.size(); i++){
            WebElement checkbox = checkboxes.get(i);
            checkbox.click();
        }
    }

}
