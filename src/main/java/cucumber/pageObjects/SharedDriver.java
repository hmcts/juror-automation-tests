package cucumber.pageObjects;

import cucumber.utils.ReadProperties;
import org.openqa.selenium.UnexpectedAlertBehaviour;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.chrome.ChromeDriver;
import org.openqa.selenium.chrome.ChromeOptions;
import org.openqa.selenium.edge.EdgeDriver;
import org.openqa.selenium.edge.EdgeOptions;
import org.openqa.selenium.ie.InternetExplorerDriver;
import org.openqa.selenium.ie.InternetExplorerOptions;
import org.openqa.selenium.support.events.EventFiringDecorator;

import java.time.Duration;
import java.util.Set;
import java.util.concurrent.ConcurrentHashMap;

public class SharedDriver extends EventFiringDecorator<WebDriver>
    implements WebDriveDecorator {

    private static final ThreadLocal<WebDriver> REAL_DRIVER = new ThreadLocal<>();
    private static final Set<WebDriver> ALL_DRIVERS = ConcurrentHashMap.newKeySet();

    static {
        Runtime.getRuntime().addShutdownHook(new Thread(() -> {
            for (WebDriver driver : ALL_DRIVERS) {
                try {
                    driver.quit();
                } catch (Exception ignored) {
                    // Driver may already be closed
                }
            }
            ALL_DRIVERS.clear();
        }));
    }

    public SharedDriver() {
        super();
        decorate(getOrCreateDriver());
    }

    private static WebDriver getOrCreateDriver() {
        WebDriver driver = REAL_DRIVER.get();
        if (driver == null) {
            driver = createWebDriver();
            REAL_DRIVER.set(driver);
            ALL_DRIVERS.add(driver);
        }
        return driver;
    }

    private static WebDriver createWebDriver() {
        String usingDriver = ReadProperties.machine("usingDriver");
        String headlessChrome = ReadProperties.machine("headlessChrome");

        if (System.getProperty("envDriver") != null) {
            usingDriver = System.getProperty("envDriver");
        }

        WebDriver driver;
        if (usingDriver.toLowerCase().equals("ie")) {
            System.setProperty("webdriver.ie.driver", ReadProperties.machine("ie_driver"));
            InternetExplorerOptions options = new InternetExplorerOptions();
            options.introduceFlakinessByIgnoringSecurityDomains();
            org.openqa.selenium.Proxy proxy = new org.openqa.selenium.Proxy();
            proxy.setProxyType(org.openqa.selenium.Proxy.ProxyType.DIRECT);
            options.setProxy(proxy);
            driver = new InternetExplorerDriver(options);
        } else if (usingDriver.equalsIgnoreCase("msedge")) {
            System.setProperty("webdriver.edge.driver", "src/test/resources/msedgedriver.exe");
            EdgeOptions options = new EdgeOptions();
            try {
                driver = new EdgeDriver(options);
            } catch (Exception e) {
                System.setProperty("webdriver.edge.driver", "/usr/bin/msedgedriver");
                options.addArguments("--headless");
                options.addArguments("--window-size=1920,1080");
                options.addArguments("--disable-dev-shm-usage");
                options.addArguments("--remote-allow-origins=*");
                driver = new EdgeDriver(options);
            }
        } else if (usingDriver.equalsIgnoreCase("phantomjs")) {
            throw new IllegalArgumentException("PhantomJS is no longer supported; use chrome with headlessChrome=true.");
        } else if (usingDriver.equalsIgnoreCase("firefox")) {
            throw new IllegalArgumentException("Firefox driver is not configured; use chrome or msedge.");
        } else {
            System.setProperty("webdriver.chrome.driver", "src/test/resources/drivers/chromedriver91.exe");
            ChromeOptions options = new ChromeOptions();
            options.addArguments("--disable-features=VizDisplayCompositor");
            options.addArguments("--start-maximized");
            options.addArguments("--incognito");
            options.setUnhandledPromptBehaviour(UnexpectedAlertBehaviour.IGNORE);
            if (headlessChrome.equalsIgnoreCase("true")) {
                options.addArguments("--headless");
                options.addArguments("--window-size=1920,1080");
                options.addArguments("--user-agent=Chrome/117.0.5938.132");
            }
            try {
                driver = new ChromeDriver(options);
            } catch (Exception e) {
                try {
                    System.setProperty("webdriver.chrome.driver", "src/test/resources/chromedriver_mac");
                    driver = new ChromeDriver(options);
                } catch (Exception f) {
                    System.setProperty("webdriver.chrome.driver",
                            "src/test/resources/drivers/chromedriver-linux64/chromedriver");
                    options.addArguments("--headless");
                    options.addArguments("--window-size=1920,1080");
                    options.addArguments("--disable-dev-shm-usage");
                    options.addArguments("--user-agent=Chrome/117.0.5938.132");
                    driver = new ChromeDriver(options);
                }
            }
        }

        driver.manage().timeouts().implicitlyWait(Duration.ofSeconds(15));
        driver.manage().deleteAllCookies();
        return driver;
    }

    @Override
    public WebDriver getDriver() {
        return getOrCreateDriver();
    }
}
