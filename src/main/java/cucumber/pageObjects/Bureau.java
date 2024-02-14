package cucumber.pageObjects;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertThat;
import static org.junit.Assert.assertTrue;

import java.util.List;

import org.apache.log4j.Logger;
import org.hamcrest.CoreMatchers;
import org.junit.Assert;
import org.openqa.selenium.Alert;
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

public class Bureau {
	private static WebDriver driver;
	private static Logger log = Logger.getLogger(Bureau.class);
	private WaitUtils wait;
	private WaitUtil_v2 wait1;
	private AngularJsHTTPCallWait aJsWait;
	private NavigationShared NAV;


	public Bureau(WebDriver driver) {
		Bureau.driver = driver;
		PageFactory.initElements(driver, this);
		wait = new WaitUtils(driver);
		wait1 = new WaitUtil_v2(driver);
		aJsWait = new AngularJsHTTPCallWait(driver);
		NAV = new NavigationShared(driver);		
	}
	
	@FindBy(xpath = "//table[@summary='Details about Juror']")
	WebElement jurorTable;


	public void oldNew_jurorRowFor_containsText(String oldNew, String rowText, String text) {
		WebElement row = jurorTable.findElement(By.xpath(
					"//th[text()=\""+rowText+"\"]//ancestor::tr"
				));
		int columnIndex = 0;
		log.info("Found row for =>"+rowText);
		
		// Column lazy way currently
		if (oldNew.equalsIgnoreCase("blue")) {
			columnIndex = 2;
		} else if (oldNew.equalsIgnoreCase("black")) {
			columnIndex = 4;
		}
		
		row.findElement(By.xpath(
					"//td["+columnIndex+"][text()[contains(., \""+text+"\")]]"
				));
		log.info("Row for =>"+rowText+"<= contained =>"+text);
		
	}

	public void set_valueTo_value_underHeader(String fieldName, String value, String headerText) {
		log.info("Going to set =>"+fieldName+"<= to =>"+value+"<= under head text =>"+headerText);
		WebElement child;
		try { 
			child = driver.findElement(By.xpath(
				"//fieldset[contains(@id, '"+headerText+"')]//input[@id=("
					+ "//label/strong[text()[contains(.,\""
						+fieldName
					+"\")]]/.."
				+"/@for) and contains(@id, '"+headerText+"')]"
			));
		} catch (Exception e) {
			child = driver.findElement(By.xpath(
					"//fieldset[contains(@id, '"+headerText+"')]"
							+ "//input[@id=(//label[text()[contains(.,\""+fieldName+"\")]]/@for)]"
					+ " | "
					+ "//fieldset[contains(@id, '"+headerText+"')]"
							+ "//input[@id=(//label/strong[text()[contains(.,\""+fieldName+"\")]]/../@for)]"
					));
		}
		child.clear();
		child.sendKeys(value);
	}


	public void setRadioButton_toValue_underText(String radioName, String underText) {
		try{
			WebElement radioButton = driver.findElement(By.xpath(
					"//strong[text()=\""+underText+"\"]//ancestor::fieldset//input[@type='radio' and @value=\""+radioName+"\"]"));
			wait.toBeClickAble(radioButton);
			NAV.click_onElement(radioButton);
		} catch (Exception e) {
			WebElement radioButton = driver.findElement(By.xpath(
					"//h1[normalize-space()='"+underText+"']//ancestor::fieldset//input[@type='radio' and @value=\""+radioName+"\"]"));
//			wait.toBeClickAble(radioButton);
			NAV.click_onElement(radioButton);
		}
		
		log.info("Clicked on radio button with value =>"+radioName+"<= under text =>"+underText);

		}

	public void assignNewReplies_toStaff(String staffMember) throws Throwable {
		log.info("Going to start changing the new replies to change all new to =>"+staffMember);
		WebElement allocateUrgent = driver.findElement(By.xpath("//input[contains(@id,'allocateUrgent')]"));
		WebElement allocateNonUrgent = driver.findElement(By.xpath("//input[contains(@id,'allocateNonUrgent')]"));
		WebElement allocateSuperUrgent = driver.findElement(By.xpath("//input[contains(@id,'allocateSuperUrgent')]"));
		allocateNonUrgent.clear();
		allocateNonUrgent.sendKeys(driver.findElement(By.xpath("//div[contains(@class,'jd-assign-replies-standard')]")).getText());
		allocateUrgent.clear();
		allocateUrgent.sendKeys(driver.findElement(By.xpath("//div[contains(@class,'jd-assign-replies-urgent')]")).getText());
		allocateSuperUrgent.clear();
		allocateSuperUrgent.sendKeys(driver.findElement(By.xpath("//div[contains(@class,'jd-assign-replies-send')]")).getText());
		NAV.check_checkbox(staffMember);
		NAV.press_buttonByName("Assign replies");
	}

	public void pressBackLink() throws Exception {
		NAV.waitforDocumentLoading();
		NAV.waitForDocumentReady();
		WebElement backLink = NAV.return_oneVisibleFromList(
				driver.findElements(By.linkText("Back")), true);
		backLink.click();
		try{
			wait.waitForTextInvisibility("Record status", 5);
		} catch (Exception e){
			log.info("Still on the page? - Going to try press the backLink again");
			try {
				backLink.click();
			} catch (Exception a) {
				log.info("Exception clicking on Back link again - Continuing to see where we are");
			}
		}
	}
    
}