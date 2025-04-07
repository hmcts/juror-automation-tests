package cucumber.utils;

import org.apache.log4j.Logger;
import org.openqa.selenium.By;
import org.openqa.selenium.StaleElementReferenceException;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.ui.ExpectedConditions;
import org.openqa.selenium.support.ui.FluentWait;
import org.openqa.selenium.support.ui.Wait;
import org.openqa.selenium.support.ui.WebDriverWait;

import java.time.Duration;
import java.util.List;
import java.util.NoSuchElementException;
import java.util.concurrent.TimeUnit;

public class WaitUtils {
	private WebDriver driver;
	private static int TIME_IN_SECONDS = 60;
	private static Logger log = Logger.getLogger(WaitUtils.class);

	// not in use
	//private static int TIME_OUT = 20;
	//private static int POLLING = 500;

	public WaitUtils(WebDriver driver) {
		this.driver = driver;
	}

	public void waitForList(List<WebElement> name) {
		new WebDriverWait(driver, Duration.ofSeconds(TIME_IN_SECONDS)).ignoring(StaleElementReferenceException.class)
		.until(ExpectedConditions
				.visibilityOfAllElements(name));
		
	}
	public <T> T until(java.util.function.Function<WebDriver, T> condition, int timeoutInSeconds) {
		log.info("Waiting until condition is met with timeout of " + timeoutInSeconds + " seconds");
		return new WebDriverWait(driver, Duration.ofSeconds(timeoutInSeconds))
				.ignoring(StaleElementReferenceException.class)
				.until(condition);
	}
	public <T> T until(java.util.function.Function<WebDriver, T> condition) {
		return until(condition, TIME_IN_SECONDS);
	}
	
	public void waitForClickableElement(WebElement name, int wait_time) {
		log.info("Waiting for element to be clickable");
		new WebDriverWait(driver, Duration.ofSeconds(wait_time)).ignoring(StaleElementReferenceException.class)
			.until(ExpectedConditions.elementToBeClickable(name));	
		log.info("Element now clickable => "+name);
	}
	public void waitForClickableElement(WebElement name) {
		waitForClickableElement(name, TIME_IN_SECONDS);
	}
	
	public void waitForDisplayedElement(WebElement name, int wait_time) {
		log.info("Waiting for element to be displayed");
		new WebDriverWait(driver, Duration.ofSeconds(wait_time)).ignoring(StaleElementReferenceException.class)
			.until(ExpectedConditions.visibilityOf(name));	
		log.info("Element now visible => "+name);
		
	}
	
	public void waitForTextOnPage(String text) {
		waitForTextOnPage(text, 10);
	}
	
	public void waitForTextOnPage(String text, int wait_time) {
		//By byXpath = By.xpath("//*[contains(normalize-space(text()),'"
		By byXpath = By.xpath("//*[contains(.,'" // This resolves issues where elements are parallel to text
				+ text
				+ "')]"); 
		WebElement element = (new WebDriverWait(driver, Duration.ofSeconds(wait_time)))
		  .until(ExpectedConditions.presenceOfElementLocated(byXpath));
	}
	
	public void waitForTextInvisibility(String text, int wait_time) {
		deactivateImplicitWait();
		By byXpath = By.xpath("//*[contains(.,'" // This resolves issues where elements are parallel to text
				+ text
				+ "')]"); 
		log.info("Waiting for text =>" + text + "<= to disappear");
		Boolean element = (new WebDriverWait(driver, Duration.ofSeconds(wait_time)))
				  .until(ExpectedConditions.invisibilityOfElementLocated(byXpath));
		log.info("Finished waiting, element visibility =>" + element);
	}
	

	public void waitForNonList(WebElement name) {
		new WebDriverWait(driver, Duration.ofSeconds(TIME_IN_SECONDS)).until(ExpectedConditions
				.visibilityOf(name));
	}
	
	public void waitForElementNoLongerInTheDOM(WebElement name) {
		new WebDriverWait(driver, Duration.ofSeconds(TIME_IN_SECONDS)).until(ExpectedConditions.stalenessOf(name));
	}

	public void waitUntilTitle(WebElement element, String text) {
		new WebDriverWait(driver, Duration.ofSeconds(TIME_IN_SECONDS)).until(ExpectedConditions
				.textToBePresentInElement(element, text));
	}
	
	public void activateImplicitWait() {
		activateImplicitWait(5);
	}
	
	public void activateImplicitWait (Integer seconds) {
		log.info("Activated Implicit wait for =>"+seconds+"<= seconds");
		driver.manage().timeouts().implicitlyWait(seconds, TimeUnit.SECONDS); // Activate implicitlyWait()														
	}
	

	public void deactivateImplicitWait() {
		
		driver.manage().timeouts().implicitlyWait(0, TimeUnit.SECONDS); // nullify implicitlyWait()	
		log.info("Deactivate Implicit wait");
	}
	
	
	public void toBeClickAble(WebElement element){
		
		new WebDriverWait(driver, Duration.ofSeconds(TIME_IN_SECONDS)).until(ExpectedConditions.elementToBeClickable(element));
				
	}
	
	public void toBeSelected(WebElement element) {
		new WebDriverWait(driver, Duration.ofSeconds(TIME_IN_SECONDS)).until(ExpectedConditions.elementToBeSelected(element));
	}

	public void f_wait(List<WebElement> name) {
		Wait<WebDriver> wait = new FluentWait<WebDriver>(driver)
				.withTimeout(Duration.ofSeconds(30))
				.pollingEvery(Duration.ofMillis(500))
				.ignoring(NoSuchElementException.class)
				.ignoring(StaleElementReferenceException.class);

		wait.until(ExpectedConditions.visibilityOfAllElements(name));
	}

	public void f_waitNoList(WebElement name) {
		FluentWait<WebDriver> wait = new FluentWait<WebDriver>(driver)
				.withTimeout(Duration.ofSeconds(60))
				.pollingEvery(Duration.ofSeconds(5))
				.ignoring(NoSuchElementException.class)
				.ignoring(StaleElementReferenceException.class);

		wait.until(ExpectedConditions.visibilityOf(name));
	}

	public void f_waitElementToClickable(WebElement element) {
		log.info("Waiting for element to be clickable");
		Wait<WebDriver> wait = new FluentWait<WebDriver>(driver)
				.withTimeout(Duration.ofSeconds(30))
				.pollingEvery(Duration.ofMillis(500))
				.ignoring(NoSuchElementException.class)
				.ignoring(StaleElementReferenceException.class);

		wait.until(ExpectedConditions.elementToBeClickable(element));

	}

	
	
	

}
