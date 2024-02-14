package cucumber.pageObjects;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertThat;
import static org.junit.Assert.assertTrue;

import java.util.Arrays;
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

import com.google.common.base.Verify;

import cucumber.utils.AngularJsHTTPCallWait;
import cucumber.utils.ReadProperties;
import cucumber.utils.WaitUtil_v2;
import cucumber.utils.WaitUtils;

public class Organisations {
	private static WebDriver driver;
	private static Logger log = Logger.getLogger(Organisations.class);
	private WaitUtils wait;
	private WaitUtil_v2 wait1;
	private AngularJsHTTPCallWait aJsWait;
	private NavigationShared NAV;


	public Organisations(WebDriver driver) {
		Organisations.driver = driver;
		PageFactory.initElements(driver, this);
		wait = new WaitUtils(driver);
		wait1 = new WaitUtil_v2(driver);
		aJsWait = new AngularJsHTTPCallWait(driver);
		NAV = new NavigationShared(driver);		
	}
	
	@FindBy(id = "selectedGroupsTable")
	WebElement selectedGroupsTable;
	
	public WebElement return_userRowByText(String text) {
		WebElement userRow = driver.findElement(By.xpath("//table//a[text()[contains(., '"+text+"')]]//ancestor::tr"));
		log.info("Found user in table - Checking notify");		
		return userRow;
	}

	/**
	 * We know it is false if it has class => fa fa-times-circle
	 * @param text
	 */
	public void confirmTextUserNot_subscribedToNotifications(String text) {
		log.info(String.format("Going to check whether user text passed =>%s<= can be found in the table",text));
		WebElement userRow = return_userRowByText(text);
		
		userRow.findElement(By.cssSelector("td:first-of-type > div > .fa-times-circle"));
		log.info(String.format("Saw CSS with check circle - %s is subscribed", text));
		
	}
	
	/**
	 * We know it is true if it has class => fa fa-check-circle
	 * @param text
	 */
	public void confirmTextUser_subscribedToNotifications(String text) {
		log.info(String.format("Going to check whether user text passed =>%s<= can be found in the table",text));
		WebElement userRow = return_userRowByText(text);
		
		userRow.findElement(By.cssSelector("td:first-of-type > div > .fa-check-circle"));
		log.info(String.format("Saw CSS with check circle - %s is subscribed", text));
		
	}


}