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

public class Profile {
	private static WebDriver driver;
	private static Logger log = Logger.getLogger(Profile.class);
	private WaitUtils wait;
	private WaitUtil_v2 wait1;
	private AngularJsHTTPCallWait aJsWait;


	public Profile(WebDriver driver) {
		Profile.driver = driver;
		PageFactory.initElements(driver, this);
		wait = new WaitUtils(driver);
		wait1 = new WaitUtil_v2(driver);
		aJsWait = new AngularJsHTTPCallWait(driver);
		
	}
    
	@FindBy(id = "confirmAccountDetailsCorrect")
	WebElement confirmAccountDetailsCorrect_checkbox;
	
	@FindBy(id = "continue")
	WebElement continue_button;
			
	public Boolean checkbox_state() throws Throwable {
		
		Boolean confirmAccountDetailsCorrect_state = confirmAccountDetailsCorrect_checkbox.isSelected();
		
		log.info("Confirm Account Details Correct Checkbox =>" + confirmAccountDetailsCorrect_state);
		
		return confirmAccountDetailsCorrect_state;
	}
	
	public Profile termsAndConditions_check() throws Throwable {
		
		confirmAccountDetailsCorrect_checkbox.click();
		
		log.info("Terms and Conditions checked");		
		checkbox_state();
		
		return PageFactory.initElements(driver, Profile.class);
	}
	
	public Profile continueButton_click() throws Throwable {
		
		confirmAccountDetailsCorrect_checkbox.click();
		
		log.info("Clicked on Continue Button");		
	
		return PageFactory.initElements(driver, Profile.class);
	}

}