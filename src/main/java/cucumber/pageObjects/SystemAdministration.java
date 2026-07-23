package cucumber.pageObjects;

import cucumber.utils.WaitUtil_v2;
import cucumber.utils.WaitUtils;
import org.apache.log4j.Logger;
import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;

public class SystemAdministration {

    private static WebDriver driver;
    private static final Logger log = Logger.getLogger(SystemAdministration.class);

    private WaitUtils wait;
    private WaitUtil_v2 wait1;
    private NavigationShared NAV;
    private Header HEADER_PAGE;

    public SystemAdministration(WebDriver driver) {
        SystemAdministration.driver = driver;
        PageFactory.initElements(driver, this);
        wait = new WaitUtils(driver);
        wait1 = new WaitUtil_v2(driver);
        NAV = new NavigationShared(driver);
    }


    public String getSJOStatusForUser(String user) {
        log.info("getting SJO status for user: " + user);
        return driver.findElement(By.xpath("//td/a[contains(text(),'" + user + "')]/../../td[6]")).getText();
    }

    public String getManagerStatusForUser(String user) {
        log.info("getting manager status for user: " + user);
        return driver.findElement(By.xpath("//td/a[contains(text(),'" + user + "')]/../../td[5]")).getText();
    }

    public String getActiveStatusForUser(String user) {
        log.info("getting active status for user: " + user);
        return driver.findElement(By.xpath("//td/a[contains(text(),'" + user + "')]/../../td[8]")).getText();
    }
}

