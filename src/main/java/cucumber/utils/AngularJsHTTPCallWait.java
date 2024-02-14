package cucumber.utils;

import java.time.Duration;
import org.apache.log4j.Logger;
import org.openqa.selenium.JavascriptExecutor;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.support.ui.ExpectedCondition;
import org.openqa.selenium.support.ui.WebDriverWait;

public class AngularJsHTTPCallWait {
	
	private WebDriver driver;	
	private static Logger log = Logger.getLogger(AngularJsHTTPCallWait.class);
	public AngularJsHTTPCallWait(WebDriver driver){
		
	}

	public void untilAngularFinishHttpCalls(long timeOutSeconds) {
	             
	      final String javaScriptToLoadAngular =
	                "var injector = window.angular.element('body').injector();" + 
	                "var $http = injector.get('$http');" + 
	                "return ($http.pendingRequests.length === 0)";

	        ExpectedCondition<Boolean> pendingHttpCallsCondition = new ExpectedCondition<Boolean>() {
	             
	            public Boolean apply(WebDriver driver) {
	            
	                return ((JavascriptExecutor) driver).executeScript(javaScriptToLoadAngular).equals(true);
	                
	            }
	            
	        };
	        
	      //  WebDriverWait angularWait = new WebDriverWait(driver, timeOutSeconds);
	        new WebDriverWait(driver,Duration.ofSeconds(timeOutSeconds)).until(pendingHttpCallsCondition);
	       // WebDriverWait angularWait = new WebDriverWait(driver, timeOutSeconds);
	       // angularWait.until(pendingHttpCallsCondition);
	        log.info("Wait until Angular Finish Http Calls");
	}


}
