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

    public String totalDigitalResponsesReceived() {
        return digitalSummonsReceivedTotalReceived.getText();
    }

}
