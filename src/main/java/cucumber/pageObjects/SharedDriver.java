package cucumber.pageObjects;

import java.io.File;
import java.util.concurrent.TimeUnit;

import cucumber.utils.DatabaseSetup;
import org.openqa.selenium.UnexpectedAlertBehaviour;
//import org.openqa.selenium.Dimension;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.chrome.ChromeDriver;
import org.openqa.selenium.chrome.ChromeOptions;
import org.openqa.selenium.firefox.FirefoxBinary;
import org.openqa.selenium.firefox.FirefoxDriver;
import org.openqa.selenium.firefox.FirefoxOptions;
import org.openqa.selenium.firefox.FirefoxProfile;
import org.openqa.selenium.ie.InternetExplorerDriver;
import org.openqa.selenium.ie.InternetExplorerOptions;
import org.openqa.selenium.phantomjs.PhantomJSDriver;
import org.openqa.selenium.phantomjs.PhantomJSDriverService;
import org.openqa.selenium.remote.CapabilityType;
import org.openqa.selenium.remote.DesiredCapabilities;
import org.openqa.selenium.support.events.EventFiringWebDriver;
//msedge
import org.openqa.selenium.Capabilities;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.remote.RemoteWebDriver;
import org.openqa.selenium.remote.service.DriverCommandExecutor;
import org.openqa.selenium.By;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.edge.EdgeDriver;
import org.openqa.selenium.edge.EdgeOptions;
import org.openqa.selenium.support.ui.ExpectedCondition;
import org.openqa.selenium.support.ui.WebDriverWait;


import cucumber.utils.ReadProperties;

public class SharedDriver extends EventFiringWebDriver {

	private static WebDriver REAL_DRIVER;
	private static Thread CLOSE_THREAD = new Thread() {
		@Override
		public void run() {
			REAL_DRIVER.quit();
		}
	};

	static {
		String usingDriver = ReadProperties.machine("usingDriver");
		String usingProxy = ReadProperties.machine("usingProxy");
		String headlessChrome = ReadProperties.machine("headlessChrome");


		if (System.getProperty("envDriver") != null)
			usingDriver = System.getProperty("envDriver");

		if (usingDriver.toLowerCase().equals("ie")) {
			System.setProperty("webdriver.ie.driver", ReadProperties.machine("ie_driver"));
			InternetExplorerOptions options = new InternetExplorerOptions();
			options.introduceFlakinessByIgnoringSecurityDomains();
			org.openqa.selenium.Proxy proxy = new org.openqa.selenium.Proxy();
			proxy.setProxyType(org.openqa.selenium.Proxy.ProxyType.DIRECT);
			options.setProxy(proxy);

			REAL_DRIVER = new InternetExplorerDriver(options);
		} else if (usingDriver.equalsIgnoreCase("msedge")) {
			System.setProperty("webdriver.edge.driver", "src/test/resources/msedgedriver.exe");
			EdgeOptions options = new EdgeOptions();
			try {
				REAL_DRIVER = new EdgeDriver(options);
			} catch (Exception e) { // intended settings for running in jenkins
				System.setProperty("webdriver.edge.driver", "/usr/bin/msedgedriver");
				options.addArguments("--headless");
				options.addArguments("--window-size=1920,1080");
				options.addArguments("--disable-dev-shm-usage");
				options.addArguments("--remote-allow-origins=*");
				REAL_DRIVER = new EdgeDriver(options);
			}
		} else if (usingDriver.toLowerCase().equals("phantomjs")){
			DesiredCapabilities DesireCaps = new DesiredCapabilities();
			DesireCaps.setCapability(PhantomJSDriverService.PHANTOMJS_EXECUTABLE_PATH_PROPERTY, "src/test/resources/phantomjs.exe");
			REAL_DRIVER = new PhantomJSDriver(DesireCaps);
		} else if (usingDriver.equalsIgnoreCase("firefox")){
			System.setProperty("webdriver.gecko.driver", "src/test/resources/geckodriver.exe");
			FirefoxOptions options = new FirefoxOptions();
			options.addArguments("--headless");
			try {
				REAL_DRIVER = new FirefoxDriver(options);
			} catch (Exception e) { // intended settings for running in jenkins
				System.setProperty("webdriver.gecko.driver", "/usr/bin/geckodriver");
				REAL_DRIVER = new FirefoxDriver(options);
			}
		} else { // Assuming Chrome
			// These settings are intended for Windows machines
			System.setProperty("webdriver.chrome.driver","src/test/resources/drivers/chromedriver91.exe");
			ChromeOptions options = new ChromeOptions();
			options.addArguments("--disable-features=VizDisplayCompositor");
			options.addArguments("--start-maximized");
//			options.addArguments("--no-proxy-server");
//			options.addArguments("--version");
			options.addArguments("--incognito");
			options.setUnhandledPromptBehaviour(UnexpectedAlertBehaviour.IGNORE);
			if (headlessChrome.equalsIgnoreCase("true")) {
				options.addArguments("--headless");
				options.addArguments("--window-size=1920,1080");
				options.addArguments("--user-agent=Chrome/117.0.5938.132");
			} else {
				//options.addArguments("--start-maximized");
			}
			try {
				REAL_DRIVER = new ChromeDriver(options);
			} catch (Exception e) {
				try {
					// These settings are intended for dev macbooks
					System.setProperty("webdriver.chrome.driver","src/test/resources/chromedriver_mac");
					REAL_DRIVER = new ChromeDriver(options);
				} catch (Exception f) { // intended settings for running in jenkins
					System.setProperty("webdriver.chrome.driver","src/test/resources/drivers/chromedriver-linux64/chromedriver");
					options.addArguments("--headless");
					options.addArguments("--window-size=1920,1080");
					options.addArguments("--disable-dev-shm-usage");
					options.addArguments("--user-agent=Chrome/117.0.5938.132");		
					REAL_DRIVER = new ChromeDriver(options);
				}
			}
		}

		REAL_DRIVER.manage().timeouts().implicitlyWait(15, TimeUnit.SECONDS);
		REAL_DRIVER.manage().deleteAllCookies();

		// REAL_DRIVER.manage().window().setSize(new Dimension(1024,728));
		Runtime.getRuntime().addShutdownHook(CLOSE_THREAD);
	}

	public SharedDriver() {
		super(REAL_DRIVER);

	}

	@Override
	public void close() {
		if (Thread.currentThread() != CLOSE_THREAD) {
			throw new UnsupportedOperationException(
					"You shouldn't close this WebDriver. It's shared and will close when the JVM exits.");
		}
		super.close();
	}

}
