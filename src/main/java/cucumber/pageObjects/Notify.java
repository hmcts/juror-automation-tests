package cucumber.pageObjects;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertThat;
import static org.junit.Assert.assertTrue;

import java.util.List;

import org.apache.log4j.Logger;
import org.hamcrest.CoreMatchers;
import org.junit.Assert;
import org.openqa.selenium.By;
import org.openqa.selenium.JavascriptExecutor;
import org.openqa.selenium.Keys;
import org.openqa.selenium.NoSuchElementException;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import org.openqa.selenium.support.ui.ExpectedConditions;
import org.openqa.selenium.support.ui.WebDriverWait;

import cucumber.testdata.DataSetup;
import cucumber.utils.AngularJsHTTPCallWait;
import cucumber.utils.ReadProperties;
import cucumber.utils.WaitUtil_v2;
import cucumber.utils.WaitUtils;

public class Notify {
	private static WebDriver driver;
	private static Logger log = Logger.getLogger(Notify.class);
	private WaitUtils wait;
	private WaitUtil_v2 wait1;
	private AngularJsHTTPCallWait aJsWait;
	private NavigationShared NAV;


	public Notify(WebDriver driver) {
		Notify.driver = driver;
		PageFactory.initElements(driver, this);
		wait = new WaitUtils(driver);
		wait1 = new WaitUtil_v2(driver);
		aJsWait = new AngularJsHTTPCallWait(driver);
		NAV = new NavigationShared(driver);		
	}
    
	@FindBy(id = "notificationsCheck")
	WebElement notificationsCheck;
	
	public String fetch_password(String username) {
		return null;
	}


	public void amNot_subscribedToNotifications() {
		wait.activateImplicitWait();
		notificationsCheck.getAttribute("class").contains("fa-times-circle");
		log.info("Saw that on the current page, there icon contained fa-times-circle for icon with NotificationsCheck ID - We are not subscribed to Notifications! (As Expected)");
	}
	
	public void am_subscribedToNotifications() {
		wait.activateImplicitWait();
		notificationsCheck.getAttribute("class").contains("fa-check-circle");
		log.info("Saw that on the current page, there icon contained fa-check-circle for icon with NotificationsCheck ID - We are subscribed to Notifications! (As Expected)");
	}

}