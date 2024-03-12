package cucumber.steps;

import org.apache.log4j.Logger;
import org.openqa.selenium.JavascriptExecutor;
import org.openqa.selenium.OutputType;
import org.openqa.selenium.TakesScreenshot;
import org.openqa.selenium.WebDriver;

import cucumber.pageObjects.Login;
import cucumber.pageObjects.NavigationShared;
import cucumber.pageObjects.ScreenShotTaker;
import cucumber.pageObjects.Search;
import cucumber.pageObjects.SharedDriver;
import cucumber.pageObjects.aSamplePO;

import io.cucumber.java.en.*;
import io.cucumber.java.PendingException;
import io.cucumber.datatable.DataTable;
import io.cucumber.java.Before;
import io.cucumber.java.After;
import io.cucumber.java.Scenario;

import org.openqa.selenium.support.PageFactory;

public class StepDef_hooks {
	
	private aSamplePO SPO;
	private Login LGN;
	private NavigationShared NAV;
	private final WebDriver webDriver;
	private ScreenShotTaker SST;
	private static Logger log = Logger.getLogger(StepDef_hooks.class);
	
	public StepDef_hooks(SharedDriver webDriver) {
		this.webDriver = webDriver;
		SST = PageFactory.initElements(webDriver, ScreenShotTaker.class);
	}
	
	@After
	public void afterScenario(Scenario scenario) {
		if (scenario.isFailed()) {		
			try {
				JavascriptExecutor jse = (JavascriptExecutor)webDriver;
			    jse.executeScript("document.body.style.zoom = '100%';");
			} catch (Exception e) {
				//Untested
			}
			try {
				byte[] screenshot = ((TakesScreenshot)webDriver).getScreenshotAs(OutputType.BYTES);
				log.info("Took a screenshot");
				scenario.attach(screenshot, "image/png",scenario.getName());
				log.info("Embeded screenshot into the cucumber scenario as image/png");
			} catch (Exception e) {
				log.error("Failed to embedd with error =>" + e);
			}
		}
	}
	
}

