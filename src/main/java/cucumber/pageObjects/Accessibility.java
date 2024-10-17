package cucumber.pageObjects;

import static org.junit.jupiter.api.Assertions.*;

import java.util.List;

import org.apache.log4j.Logger;
import org.hamcrest.CoreMatchers;
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

public class Accessibility {
	private static WebDriver driver;
	private static Logger log = Logger.getLogger(Accessibility.class);
	private WaitUtils wait;
	private WaitUtil_v2 wait1;
	private AngularJsHTTPCallWait aJsWait;
	private NavigationShared NAV;


	public Accessibility(WebDriver driver) {
		Accessibility.driver = driver;
		PageFactory.initElements(driver, this);
		wait = new WaitUtils(driver);
		wait1 = new WaitUtil_v2(driver);
		aJsWait = new AngularJsHTTPCallWait(driver);
		NAV = new NavigationShared(driver);		
	}
    


	public void altTextCheck() {
		log.info("Going to check whether there are any links with _blank (Which opens a new page) that do not have either a Welsh or English alt text");
		wait.deactivateImplicitWait();
		List<WebElement> invalid_elements = driver.findElements(By.xpath(
					"//*[@target='_blank' and not(@alt='Opens in a new window' or @alt='Agor mewn ffenestr newydd')]"
				));
		assertEquals(0,invalid_elements.size());
		log.info("Didn't see any links that open to a new page without a Welsh/English alt text");
	}



	public void pageLanguageCheck(String expectedLang) {
		log.info("Going to confirm whether the html lang value is correctly showing as =>"+expectedLang);
		
		driver.findElement(By.xpath("//html[@lang='"+expectedLang+"']"));
		log.info("Page Language is =>"+expectedLang+"<= as expected");
	}

	public boolean expandDropdownForLinks(String summaryText) {

		List<WebElement> summaryElements = driver.findElements(By.className("govuk-details__summary-text"));

		for (WebElement summaryElement : summaryElements) {
			if (summaryElement.getText().equals(summaryText)) {
				System.out.println("Found summary element with text: " + summaryText);

				WebElement detailsElement = summaryElement.findElement(By.xpath("ancestor::details"));

				if (detailsElement.getAttribute("open") != null) {
					System.out.println("The dropdown is already expanded.");
					return true;
				} else {
					System.out.println("The dropdown is collapsed. Expanding it now...");

					WebElement summaryClickable = detailsElement.findElement(By.tagName("summary"));
					JavascriptExecutor js = (JavascriptExecutor) driver;
					js.executeScript("arguments[0].click();", summaryClickable);

					if (detailsElement.getAttribute("open") != null) {
						System.out.println("The dropdown has been successfully expanded.");
						return true;
					} else {
						System.out.println("Failed to expand the dropdown.");
						return false;
					}
				}
			}
		}
		System.out.println("No dropdown found with summary text: " + summaryText);
		return false;
	}

}