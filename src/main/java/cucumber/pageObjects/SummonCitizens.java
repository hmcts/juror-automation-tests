package cucumber.pageObjects;

import cucumber.utils.AngularJsHTTPCallWait;
import cucumber.utils.WaitUtil_v2;
import cucumber.utils.WaitUtils;
import org.apache.log4j.Logger;
import org.openqa.selenium.By;
import org.openqa.selenium.StaleElementReferenceException;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;

import java.util.List;

public class SummonCitizens {

    private static WebDriver driver;
    private static final Logger log = Logger.getLogger(Search.class);
    private final WaitUtils wait;
    private final WaitUtil_v2 wait1;
    private final AngularJsHTTPCallWait aJsWait;
    private final NavigationShared NAV;

    private Groups GRP;
    private final Header HEADER_PAGE;

    public SummonCitizens(WebDriver driver) {
        SummonCitizens.driver = driver;
        PageFactory.initElements(driver, this);
        wait = new WaitUtils(driver);
        wait1 = new WaitUtil_v2(driver);
        aJsWait = new AngularJsHTTPCallWait(driver);
        NAV = new NavigationShared(driver);
        HEADER_PAGE = PageFactory.initElements(driver, Header.class);
    }

    @FindBy(xpath = "//p[contains(text(),\"Jurors requested\")]//ancestor::div/div/form/div/p[2]")
    WebElement summonCitizensNumberOfJurorsRequested;

    @FindBy(xpath = "//p[contains(text(),\"Jurors required to complete this request\")]/following-sibling::p")
    WebElement summonCitizensNumberOfJurorsRequired;

    @FindBy(xpath = "//dl[@id='catchmentArea']/div/dd")
    WebElement summonCitizensCourtCatchmentArea;

    @FindBy(xpath = "//dl[@id='bureauDeferrals']/div/dd")
    WebElement summonCitizensDeferrals;

    @FindBy(xpath = "//a[@href='#citizensToSummon']")
    WebElement numberOfCitizensSummonedError;

    @FindBy(xpath = "//dl[@id='bureauDeferrals']/div/dd/a[contains(text(),'Change')]")
    WebElement changeDeferralsLink;

    @FindBy(xpath = "//dl[@id='catchmentArea']/div/dd/a[contains(text(),'Change')]")
    WebElement changeCatchmentLink;

    @FindBy(xpath = "//button[contains(text(),'Create pool and summon citizens')]")
    WebElement summonedCitizensSubmitButton;

    public String getSummonCitizensNumberOfJurorsRequested() {
        log.info("Getting number of jurors requested on summons citizens page");
        return summonCitizensNumberOfJurorsRequested.getText();
    }

    public String getSummonCitizensNumberOfJurorsRequired() {
        log.info("Getting number of jurors required on summons citizens page");
        return summonCitizensNumberOfJurorsRequired.getText();
    }

    public String getSummonCitizensCourtCatchmentArea() {
        log.info("Getting court catchment area on summons citizens page");
        return summonCitizensCourtCatchmentArea.getText();
    }

    public String getSummonCitizensDeferrals() {
        log.info("Getting number of deferrals on summons citizens page");
        return summonCitizensDeferrals.getText();
    }

    public String getNumberOfCitizensSummonedError() {
        log.info("Getting number of citizens summoned error");

        int maxRetries = 2;
        int retryCount = 0;
        StaleElementReferenceException lastException = null;

        while (retryCount < maxRetries) {
            try {
                return numberOfCitizensSummonedError.getText();
            } catch (StaleElementReferenceException e) {
                lastException = e;
                retryCount++;
                log.warn("StaleElementReferenceException when getting 'number of citizens summoned' error - attempt " + retryCount);

                if (retryCount == maxRetries) break;

                PageFactory.initElements(driver, this);

                try {
                    Thread.sleep(200);
                } catch (InterruptedException ie) {
                    Thread.currentThread().interrupt();
                }
            }
        }

        log.error("Unable to get 'number of citizens summoned' error due to stale element: " +
                (lastException != null ? lastException.getMessage() : "unknown"));
        throw new RuntimeException("Unable to retrieve 'number of citizens summoned' error after retries.");
    }

    public boolean summonedCitizensChangeDeferralsIsPresent() {
        return changeDeferralsLink.isDisplayed();
    }

    public boolean summonedCitizensChangeCatchmentIsPresent() {
        return changeCatchmentLink.isDisplayed();
    }

    public boolean summonedCitizensSubmitButtonIsPresent() {
        return summonedCitizensSubmitButton.isDisplayed();
    }

    public Boolean    summonCitizensButtonInvisible() {
        List<WebElement> elements = driver.findElements(By.id("summonCitizensButton"));
        return elements.isEmpty();
    }
}
