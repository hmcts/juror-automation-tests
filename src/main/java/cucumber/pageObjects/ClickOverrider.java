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

public class ClickOverrider {
	private static WebDriver driver;
	private static Logger log = Logger.getLogger(ClickOverrider.class);
	private WaitUtils wait;
	private WaitUtil_v2 wait1;
	private AngularJsHTTPCallWait aJsWait;
	private Bureau BUR;
	private NavigationShared NAV;

	public ClickOverrider(WebDriver driver) {
		ClickOverrider.driver = driver;
		PageFactory.initElements(driver, this);
		wait = new WaitUtils(driver);
		wait1 = new WaitUtil_v2(driver);
		aJsWait = new AngularJsHTTPCallWait(driver);
		BUR = PageFactory.initElements(driver, Bureau.class);
		NAV = PageFactory.initElements(driver, NavigationShared.class);
		
	}
    
	@FindBy(xpath = ".//*[contains(@id, 'blobOffenceId')]")
	List<WebElement> sampleListWebElement;	
	
	@FindBy(xpath = "//div[@id='result_87']/a/abbr")
	WebElement sampleWebElement;
	
	//|| overrideCheck.equalsIgnoreCase("cancel")
	public Boolean checkWhetherInList(String overrideCheck) throws Throwable {
		wait.activateImplicitWait();
		if (overrideCheck.equalsIgnoreCase("back")) {
			BUR.pressBackLink();
			return true;
		} else if ((overrideCheck.equalsIgnoreCase("cancel")) && driver.getTitle().equalsIgnoreCase("Response details - Juror Digital")){
			WebElement cancelLink = NAV.return_oneVisibleFromList(
											driver.findElements(By.xpath("//a[text()='cancel']")), true
										);
			wait.waitForClickableElement(cancelLink);
			NAV.click_onElement(cancelLink);
			
			try {
				
				wait.waitForClickableElement(
							NAV.return_oneVisibleFromList(driver.findElements(By.linkText("edit")),true),
							3
						);
				wait.waitForDisplayedElement(
							NAV.return_oneVisibleFromList(driver.findElements(By.linkText("edit")),true),
							3
						);
			} catch (Exception | Error e) {
				cancelLink = NAV.return_oneVisibleFromList(
						driver.findElements(By.xpath("//a[text()='cancel']")), true
					);
				wait.waitForClickableElement(cancelLink);
				NAV.click_onElement(cancelLink);
			}
			return true;
		} else if ((overrideCheck.equalsIgnoreCase("edit")) && driver.getTitle().equalsIgnoreCase("Response details - Juror Digital")){
			wait.activateImplicitWait();
			WebElement editLink;
			
			try{
				editLink = NAV.return_oneVisibleFromList(driver.findElements(By.xpath("//a[text()='edit']")), true);
			} catch (Exception e) {
				NAV.waitForPageLoad(1);
				editLink = NAV.return_oneVisibleFromList(driver.findElements(By.xpath("//a[text()='edit']")), true);
			}
			wait.waitForClickableElement(editLink);
			NAV.click_onElement(editLink);
			return true;
		}  else if ((overrideCheck.equalsIgnoreCase("save")) && driver.getTitle().equalsIgnoreCase("Response details - Juror Digital")){
			/*Boolean errorPresent = false;
			try {
				wait.deactivateImplicitWait();
				NAV.return_oneVisibleFromList(driver.findElements(By.xpath("//*[@class='error-message']")),false);
				errorPresent = true;
			} catch (Exception | Error e) {}*/
			
			wait.activateImplicitWait();
			
			WebElement saveLink = NAV.return_oneVisibleFromList(
					driver.findElements(By.xpath("//a[text()='save']")), true
				);
			wait.waitForClickableElement(saveLink);
			NAV.MoveTo_click_onElement(saveLink);
			try {
				/*if (!errorPresent)
					driver.findElement(By.xpath("//*[@class='error-message'] | //input[@value='Cancel']"));
				else {
					try{*/
				wait.activateImplicitWait(3); // This is going to be the same as an explicit wait for 3 sec if errors appear. No quick stable alternative
				driver.findElement(By.xpath("//input[@value='Cancel']"));
					/*} catch (Exception e) {}
				}*/
			} catch (Exception | Error e) {
				saveLink = NAV.return_oneVisibleFromList(
						driver.findElements(By.xpath("//a[text()='save']")), true
					);
				wait.waitForClickableElement(saveLink);
				NAV.click_onElement(saveLink);
			}
			return true;
		}
		return false;
	}
	

}