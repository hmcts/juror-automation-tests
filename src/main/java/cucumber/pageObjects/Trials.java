package cucumber.pageObjects;

import cucumber.utils.WaitUtil_v2;
import cucumber.utils.WaitUtils;
import org.apache.log4j.Logger;
import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.chrome.ChromeDriver;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.NoSuchElementException;

public class Trials {

    private static WebDriver driver;
    private static final Logger log = Logger.getLogger(Trials.class);

    private WaitUtils wait;
    private WaitUtil_v2 wait1;
    private NavigationShared NAV;
    private Header HEADER_PAGE;

    public Trials(WebDriver driver) {
        Trials.driver = driver;
        PageFactory.initElements(driver, this);
        wait = new WaitUtils(driver);
        wait1 = new WaitUtil_v2(driver);
        NAV = new NavigationShared(driver);
        HEADER_PAGE = PageFactory.initElements(driver, Header.class);
    }

    @FindBy(xpath = "//*[@id=\"main-content\"]/div[2]/div/dl/div[1]/dd")
    WebElement defendantName;

    @FindBy(xpath = "//*[@id=\"main-content\"]/div[2]/div/dl/div[2]/dd")
    WebElement trialType;

    @FindBy(xpath = "//*[@id=\"main-content\"]/div[2]/div/dl/div[3]/dd")
    WebElement trialStartDate;

    @FindBy(xpath = "//*[@id=\"main-content\"]/div[2]/div/dl/div[4]/dd")
    WebElement judgeSelected;

    @FindBy(xpath = "//*[@id=\"main-content\"]/div[2]/div/dl/div[5]/dd")
    WebElement courtRoom;

    @FindBy(xpath = "//*[@id=\"main-content\"]/div[2]/div/dl/div[6]/dd")
    WebElement trialProtection;

    @FindBy(name = "selectedPools")
    WebElement poolNumberCheckbox;

    @FindBy(id = "numberOfJurors")
    WebElement enterNoOfJurorsForPanel;

    @FindBy(id = "checkInTimeHour")
    WebElement confirmAttendanceCheckInHour;

    @FindBy(id = "checkInTimeMinute")
    WebElement confirmAttendanceCheckInMinute;

    @FindBy(id = "checkInTime-am")
    WebElement confirmAttendanceCheckInRadioButtonAm;

    @FindBy(id = "checkInTime-pm")
    WebElement confirmAttendanceCheckInRadioButtonPm;

    @FindBy(id = "checkOutTimeHour")
    WebElement confirmAttendanceCheckOutHour;

    @FindBy(id = "checkOutTimeMinute")
    WebElement confirmAttendanceCheckOutMinute;

    @FindBy(id = "checkOutTime-am")
    WebElement confirmAttendanceCheckOutRadioButtonAm;

    @FindBy(id = "checkOutTime-pm")
    WebElement confirmAttendanceCheckOutRadioButtonPm;

    public Map<String, String> getTrialDetails() {
        Map<String, String> details = new HashMap<>();

        details.put("defendantName", defendantName.getText());
        details.put("trialType", trialType.getText());
        details.put("judgeSelected", judgeSelected.getText());
        details.put("courtRoom", courtRoom.getText());
        details.put("trialProtection", trialProtection.getText());

        return details;
    }

    public void checkPoolNumberCheckbox() {
        log.info("Clicked pool number checkbox");
        poolNumberCheckbox.click();
    }

    public void jurorsForPanel(String noOfJurors) {
        enterNoOfJurorsForPanel.clear();
        enterNoOfJurorsForPanel.sendKeys(noOfJurors);
    }

    public void jurorCheckInMinute(String checkInTime) {
        confirmAttendanceCheckInMinute.clear();
        confirmAttendanceCheckInMinute.sendKeys(checkInTime);
    }

    public void jurorCheckInHour(String checkInTime) {
        confirmAttendanceCheckInHour.clear();
        confirmAttendanceCheckInHour.sendKeys(checkInTime);
    }

    public void jurorCheckInRadioButtonAm() {
        confirmAttendanceCheckInRadioButtonAm.click();
    }

    public void jurorCheckInRadioButtonPm() {
        confirmAttendanceCheckInRadioButtonPm.click();
    }

    public void jurorCheckOutMinute(String checkOutTime) {
        confirmAttendanceCheckOutMinute.clear();
        confirmAttendanceCheckOutMinute.sendKeys(checkOutTime);
    }

    public void jurorCheckOutHour(String checkOutTime) {
        confirmAttendanceCheckOutHour.clear();
        confirmAttendanceCheckOutHour.sendKeys(checkOutTime);
    }

    public void jurorCheckOutRadioButtonAm() {
        confirmAttendanceCheckOutRadioButtonAm.click();
    }

    public void jurorCheckOutRadioButtonPm() {
        confirmAttendanceCheckOutRadioButtonPm.click();
    }

    public void selectStatusForEmpanelledJuror(String formId, String jurorNumber, String status) {
        String radioButtonXPath = "//form[@id='" + formId + "']//input[@name='" + jurorNumber + "' and @value='" + status + "']";
        try {
            WebElement radioButton = driver.findElement(By.xpath(radioButtonXPath));
            radioButton.click();

            log.info("Selected radio button with name '" + jurorNumber + "' and value '" + status + "'");
        } catch (NoSuchElementException e) {
            log.error("Radio button with name '" + jurorNumber + "' and value '" + status + "' not found");
        }
    }
}

