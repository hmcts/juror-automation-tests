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

public class Header {

    private static WebDriver driver;
    private static final Logger log = Logger.getLogger(Search.class);
    private final WaitUtils wait;
    private final WaitUtil_v2 wait1;
    private final AngularJsHTTPCallWait aJsWait;
    private final NavigationShared NAV;

    public Header(WebDriver driver) {
        Header.driver = driver;
        PageFactory.initElements(driver, this);
        wait = new WaitUtils(driver);
        wait1 = new WaitUtil_v2(driver);
        aJsWait = new AngularJsHTTPCallWait(driver);
        NAV = new NavigationShared(driver);
    }

    @FindBy(id = "apps-button")
    WebElement appsButton;

    @FindBy(linkText = "Pool management")
    WebElement poolManagementLink;

    @FindBy(linkText = "Summons management")
    WebElement summonsManagementLink;

    public void openAppsMenu()  {
        log.info("Opening apps menu");
        appsButton.click();
    }

    public Boolean    appsButtonInvisible() {
        List<WebElement> elements = driver.findElements(By.id("apps-button"));
        return elements.isEmpty();

    }

    public void clickPoolManagement() {
        log.info("Clicking pool management");
        poolManagementLink.click();
    }

    public void clickSummonsManagement() {
        log.info("Clicking Summons management");
        summonsManagementLink.click();
    }

}
