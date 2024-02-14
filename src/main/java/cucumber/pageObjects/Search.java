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

import cucumber.utils.AngularJsHTTPCallWait;
import cucumber.utils.ReadProperties;
import cucumber.utils.WaitUtil_v2;
import cucumber.utils.WaitUtils;

public class Search {
	private static WebDriver driver;
	private static Logger log = Logger.getLogger(Search.class);
	private WaitUtils wait;
	private WaitUtil_v2 wait1;
	private AngularJsHTTPCallWait aJsWait;
	private NavigationShared NAV;


	public Search(WebDriver driver) {
		Search.driver = driver;
		PageFactory.initElements(driver, this);
		wait = new WaitUtils(driver);
		wait1 = new WaitUtil_v2(driver);
		aJsWait = new AngularJsHTTPCallWait(driver);
		NAV = new NavigationShared(driver);		
	}
    
	

	public void search_personOrganisationTopSearch(String arg1) {
		WebElement searchBox = driver.findElement(By.id("searchBox"));
		searchBox.sendKeys(arg1);
		searchBox.sendKeys(Keys.ENTER);
		
		log.info("Searched and pressed enter for text =>"+arg1);
	}
	
	

}