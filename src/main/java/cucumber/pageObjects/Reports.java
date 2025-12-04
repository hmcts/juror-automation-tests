package cucumber.pageObjects;

import org.apache.log4j.Logger;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;

public class Reports {
    private static WebDriver driver;
    private static final Logger log = Logger.getLogger(Reports.class);

    @FindBy(xpath = "//a [@href='/reporting/digital-summons-received']/../main/div[2]/div//div [contains(text(),'Total number of replies received')]/../div[2]")
    WebElement digitalSummonsReceivedTotalReceived;

    @FindBy(xpath = "//td[2]")
    WebElement numberReminderSMSSent;

    @FindBy(xpath = "//td[3]")
    WebElement numberFailedSMSSent;

    @FindBy(xpath = "//td[4]")
    WebElement numberDateAndTimeSMSSent;

    @FindBy(xpath = "//td[5]")
    WebElement numberTimeChangedSMSSent;

    @FindBy(xpath = "//td[6]")
    WebElement numberCompleteAttendedSMSSent;

    @FindBy(xpath = "//td[7]")
    WebElement numberCompleteNotNeededSMSSent;

    @FindBy(xpath = "//td[8]")
    WebElement numberNextDateSMSSent;

    @FindBy(xpath = "//td[9]")
    WebElement numberOnCallSMSSent;

    @FindBy(xpath = "//td[10]")
    WebElement numberPleaseContactSMSSent;

    @FindBy(xpath = "//td[11]")
    WebElement numberDelayedSMSSent;

    @FindBy(xpath = "//td[12]")
    WebElement numberSelectionSMSSent;

    @FindBy(xpath = "//td[13]")
    WebElement numberBadWeatherSMSSent;

    @FindBy(xpath = "//td[14]")
    WebElement numberCheckJunkSMSSent;

    @FindBy(xpath = "//td[15]")
    WebElement numberBringLunchSMSSent;

    @FindBy(xpath = "//td[16]")
    WebElement numberExcusedSMSSent;

    @FindBy(xpath = "//td[17]")
    WebElement numberTotalSMSSent;

    @FindBy(xpath = "//div[contains(text(),'Total SMS sent')]/../div[2]")
    WebElement totalSMSSent;

    public String totalDigitalResponsesReceived() {
        return digitalSummonsReceivedTotalReceived.getText();
    }

    public String numberReminderSMSSentMatchesExpected() {
            return numberReminderSMSSent.getText();
    }

    public String numberFailedSMSSentMatchesExpected() {
        return numberFailedSMSSent.getText();
    }

    public String numberDateAndTimeSMSSentMatchesExpected() {
        return numberDateAndTimeSMSSent.getText();
    }

    public String numberTimeChangedSMSSentMatchesExpected() {
        return numberTimeChangedSMSSent.getText();
    }

    public String numberCompleteAttendedSMSSentMatchesExpected() {
        return numberCompleteAttendedSMSSent.getText();
    }

    public String numberCompleteNotNeededSMSSentMatchesExpected() {
        return numberCompleteNotNeededSMSSent.getText();
    }

    public String numberNextDateSMSSentMatchesExpected() {
        return numberNextDateSMSSent.getText();
    }

    public String numberOnCallSMSSentMatchesExpected() {
        return numberOnCallSMSSent.getText();
    }

    public String numberPleaseContactSMSSentMatchesExpected() {
        return numberPleaseContactSMSSent.getText();
    }

    public String numberDelayedSMSSentMatchesExpected() {
        return numberDelayedSMSSent.getText();
    }

    public String numberSelectionSMSSentMatchesExpected() {
        return numberSelectionSMSSent.getText();
    }

    public String numberBadWeatherSMSSentMatchesExpected() {
        return numberBadWeatherSMSSent.getText();
    }

    public String numberCheckJunkSMSSentMatchesExpected() {
        return numberCheckJunkSMSSent.getText();
    }

    public String numberBringLunchSMSSentMatchesExpected() {
        return numberBringLunchSMSSent.getText();
    }

    public String numberExcusedSMSSentMatchesExpected() {
        return numberExcusedSMSSent.getText();
    }

    public String numberTotalSMSSentMatchesExpected() {
        return numberTotalSMSSent.getText();
    }

    public String totalSMSSentMatchesExpected() {
        return totalSMSSent.getText();
    }

}
