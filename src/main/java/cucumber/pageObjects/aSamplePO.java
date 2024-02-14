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
import cucumber.utils.WaitUtil_v2;
import cucumber.utils.WaitUtils;

public class aSamplePO {
	private static WebDriver driver;
	private static Logger log = Logger.getLogger(aSamplePO.class);
	private WaitUtils wait;
	private WaitUtil_v2 wait1;
	private AngularJsHTTPCallWait aJsWait;


	public aSamplePO(WebDriver driver) {
		aSamplePO.driver = driver;
		PageFactory.initElements(driver, this);
		wait = new WaitUtils(driver);
		wait1 = new WaitUtil_v2(driver);
		aJsWait = new AngularJsHTTPCallWait(driver);
		
	}
    
	@FindBy(xpath = ".//*[contains(@id, 'blobOffenceId')]")
	List<WebElement> sampleListWebElement;	
	
	@FindBy(xpath = "//div[@id='result_87']/a/abbr")
	WebElement sampleWebElement;
	
	
	public aSamplePO sample() throws Throwable {
		
		// Do something
		log.info("Ensure something is logged!");
		
		return PageFactory.initElements(driver, aSamplePO.class);
	}
	

}