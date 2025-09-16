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


//    @FindBy(xpath = "//*[@class='govuk-heading-l' and contains(text(),'Summoning progress')]")
//    WebElement summoningProgressBanner;
//    @FindBy(id = "courtNameOrLocation")
//    WebElement courtNameOrLocationInput;
//    @FindBy(id = "poolType")
//    WebElement crownRadioButton;
//    @FindBy(id = "poolType-2")
//    WebElement civilRadioButton;
//    @FindBy(id = "poolType-3")
//    WebElement highRadioButton;
//    @FindBy(xpath = "//*[@class='govuk-button' and contains(text(),'Search')]")
//    WebElement searchButton;

    public String totalExpectedToday() {
        return totalExpectedToday.getText();
    }

    public String totalExpectedLastSevenDays() {
        return totalExpectedLastSevenDays.getText();
    }


//    public boolean summoningProgressBannerIsDisplayed(){return summoningProgressBanner.isDisplayed();}
//
//    public void enterCourtCodeForSearch(String courtCode) { courtNameOrLocationInput.sendKeys(courtCode);
//    }
//
//    public void clickCrownRadioButton() {crownRadioButton.click();
//    }
//
//    public void clickCivilRadioButton() {civilRadioButton.click();
//    }
//
//    public void clickHighRadioButton() {highRadioButton.click();
//    }
//    public void clickSearch(){searchButton.click();}
//    public String[] getRowOfTableContainingPoolNumber(String poolCreated){
//        List<WebElement> rowContainingPool = driver.findElements(By.xpath("//*[text()='" +poolCreated+"']/parent::*/parent::*/td"));
//        int index = 0;
//        int noOfElements = rowContainingPool.size();
//        String[] row = new String[noOfElements];
//
//        do {
//           row[index] = rowContainingPool.get(index).getText();
//           index++;
//        } while (index < noOfElements);
//        return row;
//    }
}
