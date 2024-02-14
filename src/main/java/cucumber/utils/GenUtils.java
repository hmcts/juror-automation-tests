package cucumber.utils;

import org.apache.log4j.Logger;
import org.openqa.selenium.By;
import org.openqa.selenium.JavascriptExecutor;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;

public class GenUtils {
	private WebDriver driver;
	private static int TIME_IN_SECONDS = 60;
	private static Logger log = Logger.getLogger(GenUtils.class);

	public GenUtils(WebDriver driver) {
		this.driver = driver;
	}
	
	public WebElement lookupWebElement_byPlaceholder(String lookup){		
		log.info("Looking for element with placeholder =>"+lookup);
		return driver.findElement(By.xpath(".//*[contains(@placeholder, '"
									+ lookup
									+ "')]"));		
	}
	
	public String runReturn_JS(String jsCode) {
		
		JavascriptExecutor js =(JavascriptExecutor)driver;
		String out = js.executeScript(jsCode).toString();
		
		log.info("Ran jscode =>"+jsCode);
		log.info("Saw =>"+out);
		
		return out;
	}
	
	public void exec_JS(String jsCode) {
		((JavascriptExecutor) driver).executeScript(jsCode);
		log.info("Ran jscode =>"+jsCode);
	}
	
	public void setAttributeValue(WebElement elem, String param, String value){
	    JavascriptExecutor js = (JavascriptExecutor) driver; 
	    String scriptSetAttrValue = "arguments[0].setAttribute(arguments[1],arguments[2])";
	    js.executeScript(scriptSetAttrValue, elem, param, value);
	    log.info("For element, set =>"+param+"<= to =>"+value);
	}
	
}