package cucumber.utils;

import java.util.List;
import java.time.Duration;

import org.apache.log4j.Logger;
import org.openqa.selenium.By;
import org.openqa.selenium.NoSuchElementException;
import org.openqa.selenium.StaleElementReferenceException;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.ui.ExpectedCondition;
import org.openqa.selenium.support.ui.ExpectedConditions;
import org.openqa.selenium.support.ui.FluentWait;
import org.openqa.selenium.support.ui.Wait;

import com.google.common.base.Function;

public class WaitUtil_v2 {

	private WebDriver driver;
	private static Logger log = Logger.getLogger(WaitUtil_v2.class);
	private Boolean flag;

	public WaitUtil_v2(WebDriver driver) {
		this.driver = driver;
	}

	public void Expect1(final String text1, final String text2) {
		Wait<WebDriver> wait = new FluentWait<WebDriver>(driver)
				.withTimeout(Duration.ofSeconds(105))
				.pollingEvery(Duration.ofSeconds(5))
				.ignoring(NoSuchElementException.class)
				.ignoring(StaleElementReferenceException.class);

		Function<WebDriver, Boolean> ex2 = new Function<WebDriver, Boolean>() {
			@Override
			public Boolean apply(WebDriver e) {
				log.info(" starting fluent wait");
				WebElement fw = e.findElement(By.className(text1));
				boolean fws = fw.getText().contains(text2);
				log.info(" ending fluent wait");
				return fws;
			}
		};
		wait.until(ex2);
	}

	public void Expect1CssOnly(final String text1) {
		Wait<WebDriver> wait = new FluentWait<WebDriver>(driver)
				.withTimeout(Duration.ofSeconds(55))
				.pollingEvery(Duration.ofSeconds(5))
				.ignoring(NoSuchElementException.class)
				.ignoring(StaleElementReferenceException.class);

		Function<WebDriver, Boolean> ex2 = new Function<WebDriver, Boolean>() {
			@Override
			public Boolean apply(WebDriver e) {
				log.info(" starting fluent wait");
				WebElement t = e.findElement(By.cssSelector(text1));
				return t.isEnabled();
			}
		};
		wait.until(ex2);
	}

	public void waitForButtonToBeVisible_List_2(final List<WebElement> text1) {
		Wait<WebDriver> wait = new FluentWait<WebDriver>(driver)
				.withTimeout(Duration.ofSeconds(60))
				.pollingEvery(Duration.ofSeconds(10))
				.ignoring(StaleElementReferenceException.class)
				.ignoring(NoSuchElementException.class);
				

		Function<WebDriver, ExpectedCondition<List<WebElement>>> ex2 = new Function<WebDriver, ExpectedCondition<List<WebElement>>>() {
			@Override
			public ExpectedCondition<List<WebElement>> apply(
					WebDriver e) {
				log.info(" waitForButtonToBeVisible_List_2");
				return ExpectedConditions.visibilityOfAllElements(text1);
			}
		};
		wait.until(ex2);
	}
}
