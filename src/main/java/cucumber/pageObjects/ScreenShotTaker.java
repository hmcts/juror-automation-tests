package cucumber.pageObjects;

import java.io.File;
import java.io.IOException;
import org.apache.log4j.Logger;
import org.openqa.selenium.OutputType;
import org.openqa.selenium.TakesScreenshot;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;

import cucumber.utils.WaitUtil_v2;
import cucumber.utils.WaitUtils;

import org.apache.commons.io.FileUtils;

public class ScreenShotTaker {
	private static Logger log = Logger.getLogger(ScreenShotTaker.class);
	private WaitUtil_v2 wait1;
	private WaitUtils wait;		
	private WebDriver driver;
	
	public ScreenShotTaker(WebDriver webDriver) {
		this.driver = webDriver;
		wait1 = new WaitUtil_v2(driver);
		wait = new WaitUtils(driver);
	}

	
	public ScreenShotTaker captureScreenShot(){
		File src = ((TakesScreenshot) driver).getScreenshotAs(OutputType.FILE);
		try {
			
			FileUtils.copyFile(src,	new File("ScreenShot/" + System.currentTimeMillis()	+ ".png"));
			log.info("Took Screenshot as called");
			
		} catch (IOException e) {
			
			log.info(e.getMessage());
			
		}
		
		return PageFactory.initElements(driver, ScreenShotTaker.class);
	}
}
