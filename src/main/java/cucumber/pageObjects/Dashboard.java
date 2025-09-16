package cucumber.pageObjects;

import org.apache.log4j.Logger;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;

public class Dashboard {
    private static WebDriver driver;
    private static final Logger log = Logger.getLogger(Dashboard.class);

    public void Dashboard(WebDriver webDriver) {
        Dashboard.driver = webDriver;
        PageFactory.initElements(driver, this);
    }

    @FindBy(xpath = "//div/canvas[@id='todayStatsChart']/../div[@class='total']")
    WebElement totalExpectedToday;

    @FindBy(xpath = "//div/canvas[@id='last7DaysStatsChart']/../div[@class='total']")
    WebElement totalExpectedLastSevenDays;

    @FindBy(xpath = "//div/canvas[@id='last7DaysStatsChart']/../div[@class='total']")
    WebElement totalDueToAttendNextSevenDays;

    public String totalExpectedToday() {
        return totalExpectedToday.getText();
    }

    public String totalExpectedLastSevenDays() {
        return totalExpectedLastSevenDays.getText();
    }

}
