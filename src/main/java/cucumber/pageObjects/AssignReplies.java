package cucumber.pageObjects;

import cucumber.testdata.DatabaseTester;
import cucumber.utils.AngularJsHTTPCallWait;
import cucumber.utils.WaitUtil_v2;
import cucumber.utils.WaitUtils;
import org.apache.log4j.Logger;
import org.junit.Assert;
import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;

public class AssignReplies {

    private static WebDriver driver;
    private static final Logger log = Logger.getLogger(Search.class);
    private final WaitUtils wait;
    private final WaitUtil_v2 wait1;
    private final AngularJsHTTPCallWait aJsWait;
    private final NavigationShared NAV;
    private final DatabaseTester DBT;

    public AssignReplies(WebDriver driver) {
        AssignReplies.driver = driver;
        PageFactory.initElements(driver, this);
        wait = new WaitUtils(driver);
        wait1 = new WaitUtil_v2(driver);
        aJsWait = new AngularJsHTTPCallWait(driver);
        NAV = new NavigationShared(driver);
        DBT = new DatabaseTester();
    }


    @FindBy(id = "allocateUrgent")
    WebElement setAssignUrgentReplies;

    @FindBy(id = "allocateNonUrgent")
    WebElement setAssignStandardReplies;

    @FindBy(xpath = "//ul[@class=\"govuk-list\"]/li")
    WebElement replyFromJurorName;

    @FindBy(id = "sendToOfficer")
    WebElement selectAnOfficer;

    @FindBy(xpath = "//div[text()[contains(.,'Send to court')]]")
    WebElement backlogCountSendToCourtLabel;

    @FindBy(xpath = "//div[text()[contains(.,'Urgent')]]")
    WebElement backlogCountUrgentLabel;

    @FindBy(xpath = "//div[text()[contains(.,'Standard')]]")
    WebElement backlogCountStandardLabel;

    @FindBy(xpath = "//div[text()[contains(.,'Total')]]")
    WebElement backlogCountTotalLabel;


    @FindBy(xpath = "//label[text()[contains(.,'Send to court')]]")
    WebElement assignCountSendToCourtLabel;

    @FindBy(xpath = "//label[text()[contains(.,'Urgent')]]")
    WebElement assignCountUrgentLabel;

    @FindBy(xpath = "//label[text()[contains(.,'Standard')]]")
    WebElement assignCountStandardLabel;

    @FindBy(xpath = "//th[text()[contains(.,'Send to court')]]")
    WebElement assignedToStaffCountSendToCourtLabel;

    @FindBy(xpath = "//th[text()[contains(.,'Urgent')]]")
    WebElement assignedToStaffCountUrgentLabel;

    @FindBy(xpath = "//th[text()[contains(.,'Standard')]]")
    WebElement assignedToStaffCountStandardLabel;

    @FindBy(xpath = "//th[text()[contains(.,'Total')]]")
    WebElement assignedToStaffCountTotalLabel;



    public void setNumberOfRepliesToAssign(String urgencyType, String numberOfReplies) {
        log.info("Setting number of " + urgencyType + " replies to " + numberOfReplies);

        switch (urgencyType) {
            case "Urgent":
                setAssignUrgentReplies.clear();
                setAssignUrgentReplies.sendKeys(numberOfReplies);
                break;
            case "Standard":
                setAssignStandardReplies.clear();
                setAssignStandardReplies.sendKeys(numberOfReplies);
                break;
        }
    }

    public void userIsNotinResultsGrid(String staffName) {
        log.info("User " + staffName + "not in results grid");
        String staffGrid = driver.findElement(By.tagName("td")).getText();
        Assert.assertFalse("Text Found when not expected!", staffGrid.contains(staffName));

    }

    public String getReplyFromJurorName() {
        return replyFromJurorName.getText();
    }

    public void clickSelectAnOfficer() {
        selectAnOfficer.click();
    }

    public void iSeeBacklogCountLabel(String backlogCountType) {

        switch (backlogCountType) {
            case "Total":
                backlogCountTotalLabel.isDisplayed();
                break;
            case "Send to court":
                backlogCountSendToCourtLabel.isDisplayed();
                break;
            case "Urgent":
                backlogCountUrgentLabel.isDisplayed();
                break;
            case "Standard":
                backlogCountStandardLabel.isDisplayed();
                break;
        }
    }

        public void iSeeAssignCountLabel(String assignCountType) {

            switch (assignCountType) {
                case "Send to court":
                    assignCountSendToCourtLabel.isDisplayed();
                    break;
                case "Urgent":
                    assignCountUrgentLabel.isDisplayed();
                    break;
                case "Standard":
                    assignCountStandardLabel.isDisplayed();
                    break;
            }
        }

    public void iSeeAssignedToStaffCountLabel(String assignCountType) {

        switch (assignCountType) {
            case "Total":
                assignedToStaffCountTotalLabel.isDisplayed();
                break;
            case "Send to court":
                assignedToStaffCountSendToCourtLabel.isDisplayed();
                break;
            case "Urgent":
                assignedToStaffCountUrgentLabel.isDisplayed();
                break;
            case "Standard":
                assignedToStaffCountStandardLabel.isDisplayed();
                break;
        }


    }





    }

