package cucumber.pageObjects;

import cucumber.utils.WaitUtil_v2;
import cucumber.utils.WaitUtils;
import org.apache.log4j.Logger;
import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindAll;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.FindBys;
import org.openqa.selenium.support.PageFactory;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class ViewSummonsReply {

    private static WebDriver driver;
    private static final Logger log = Logger.getLogger(SummonsReply.class);
    private final WaitUtils wait;
    private final WaitUtil_v2 wait1;
    private final NavigationShared NAV;

    private final Header HEADER_PAGE;

    public ViewSummonsReply(WebDriver driver) {
        ViewSummonsReply.driver = driver;
        PageFactory.initElements(driver, this);
        wait = new WaitUtils(driver);
        wait1 = new WaitUtil_v2(driver);
        NAV = new NavigationShared(driver);
        HEADER_PAGE = PageFactory.initElements(driver, Header.class);
    }

    @FindBy(id = "juror-details-section-menu-item")
    WebElement jurorDetailsTab;

    @FindBy(id = "jurorName")
    WebElement jurorDetailsName;

    @FindBy(className = "govuk-heading-l")
    WebElement jurorNameHeader;

    @FindBy(id = "jurorAddress")
    WebElement jurorDetailsAddress;

    @FindBy(id = "jurorDateOfBirth")
    WebElement jurorDetailsDob;

    @FindBy(id = "jurorPrimaryPhone")
    WebElement jurorDetailsMainPhone;

    @FindBy(id = "jurorSecondaryPhone")
    WebElement jurorDetailsAltPhone;

    @FindBy(id = "jurorEmailAddress")
    WebElement jurorDetailsEmail;

    @FindBy(id = "eligibility-section-menu-item")
    WebElement eligibilityTab;

    @FindBy(id = "residency")
    WebElement eligibilityResidency;

    @FindBy(id = "mentalHealth")
    WebElement eligibilityMha;

    @FindBy(id = "mentalHealthCapacity")
    WebElement eligibilityMca;

    @FindBy(id = "bail")
    WebElement eligibilityBail;

    @FindBy(id = "convictions")
    WebElement eligibilityConvictions;

    @FindBy(id = "deferral-excusal-section-menu-item")
    WebElement deferralTab;

    @FindBy(id = "deferralOrExcusal")
    WebElement deferralStatus;

    @FindBy(id = "cjs-employment-section-menu-item")
    WebElement cjsTab;

    @FindBy(id = "cjsEmploymentDetails")
    WebElement cjsStatus;

    @FindBy(id = "adjustments-section-menu-item")
    WebElement adjustmentsTab;

    @FindBy(id = "reasonableAdjustments")
    WebElement adjustmentsStatus;

    @FindBy(id = "reasonableAdjustment")
    WebElement opticReferenceNo;

    @FindBy(id="opticReference")
    WebElement opticReferenceInput;

    @FindBy(id = "signature-section-menu-item")
    WebElement signatureTab;

    @FindBy(css = "#view-signature dd")
    WebElement signatureStatus;

    @FindBy(id = "processAwaitingInformation")
    WebElement markAwaitingInformation;

    @FindBy(id = "moj-actions-button-menu")
    WebElement moreActionsButton;

    @FindBy(xpath = "//div[@class='info']/strong")
    WebElement replyStatus;

    @FindBy(xpath = "//div[text()[contains(.,'Reply type')]]//ancestor::div/div[@class='info']/strong")
    WebElement replyTypeValue;

    @FindBy(xpath = "//div[text()[contains(.,'Reply status')]]//ancestor::div/div[@class='info']/strong")
    WebElement replyStatusValue;

    @FindBy(id = "awaitingInformation")
    WebElement awaitingJuror;

    @FindBy(id = "awaitingInformation-2")
    WebElement awaitingCourt;

    @FindBy(id = "awaitingInformation-3")
    WebElement awaitingTransfer;

    @FindBy(xpath = "//div/strong[@class='govuk-tag govuk-tag--purple']")
    WebElement summonsReplyTag;

    @FindBy(xpath = "//div[text()[contains(.,'Reply method')]]")
    WebElement replyMethodLabel;

    @FindBy(xpath = "//div[text()[contains(.,'Reply method')]]//ancestor::div/div[@class='info']")
    WebElement replyMethodValue;

    @FindBy(xpath = "//div[text()[contains(.,'Service start date')]]")
    WebElement serviceStartDateLabel;

    @FindBy(xpath = "//div[3]/div[1]/div[3]/div[2]")
    WebElement assignedToStaff;

    @FindBy(xpath = "//*[@id=\"ineligibleAgeConfirm\"]/h2")
    WebElement ineligibilityAgeConfirmHeader;

    @FindBy(id = "disqualifyButton")
    WebElement disqualifyButton;

    @FindBy(xpath = "//*[@id=\"ineligibleAgeConfirm\"]/div/a")
    WebElement changeDateLink;

    @FindBy(xpath = "//div[text() = 'Juror status']/../div[2]")
    WebElement jurorStatus;

    @FindBy(id = "oldJurorName")
    WebElement previousName;

    @FindBy(xpath = "//*[@id=\"main-content\"]/div/div/div[2]")
    WebElement accomodateJurorName;

    @FindBy(xpath = "//*[@id=\"main-content\"]/div/div/div[4]")
    WebElement accomodateJurorNumber;

    @FindBy(xpath = "//*[@id=\"main-content\"]/div/div/div[6]")
    WebElement accomodateJurorMainPhone;

    @FindBy(xpath = "//*[@id=\"main-content\"]/div/div/div[8]")
    WebElement accomodateJurorEmail;

    @FindBy(xpath = "//*[@id=\"main-content\"]/div/div/ul/li")
    WebElement accomodateJurorAdjustmentReason;

    @FindBy(xpath = "//*[@id=\"main-content\"]/div/div/div[10]")
    WebElement accomodateJurorAdjustmentNeeded;


    public String getPreviousName() {
        return previousName.getText();
    }

    public void clickJurorDetailsTab() {
        jurorDetailsTab.click();
    }

    public void clickEligibilityTab() {
        eligibilityTab.click();
    }

    public void clickDeferralTab() {
        deferralTab.click();
    }

    public void clickCjsTab() {
        cjsTab.click();
    }

    public void clickAdjustmentsTab() {
        adjustmentsTab.click();
    }

    public void clickSignatureTab() {
        signatureTab.click();
    }

    public Map<String,String> getJurorDetails() {
        Map<String, String > details = new HashMap<>();

        details.put("jurorName", jurorDetailsName.getText());
        details.put("jurorAddress", jurorDetailsAddress.getText());
        details.put("jurorDob", jurorDetailsDob.getText());
        details.put("jurorMainPhone", jurorDetailsMainPhone.getText());
        details.put("jurorAltPhone", jurorDetailsAltPhone.getText());
        details.put("jurorEmail", jurorDetailsEmail.getText());

        return details;
    }

    public Map<String,String> getJurorEligibility() {
        Map<String, String > eligibility = new HashMap<>();

        eligibility.put("jurorResidency", eligibilityResidency.getText());
        eligibility.put("jurorMha", eligibilityMha.getText());
        eligibility.put("jurorMca", eligibilityMca.getText());
        eligibility.put("jurorBail", eligibilityBail.getText());
        eligibility.put("jurorConvictions", eligibilityConvictions.getText());

        return eligibility;
    }

    public String getDeferral() {
        return deferralStatus.getText();
    }

    public String getCjsStatus() {
        return cjsStatus.getText();
    }

    public String getAdjustmentStatus() {
        return adjustmentsStatus.getText();
    }

    public String getOpticeReferenceNo() { return opticReferenceNo.getText(); }

    public void enterOpticReferenceNumber(String reference){
        opticReferenceInput.sendKeys(reference);
    }

    public String getSignatureStatus() {
        return signatureStatus.getText();
    }

    public boolean jurorNameHeaderIsPresent(){return jurorNameHeader.isDisplayed();};

    public void clickAwaitingInformation(){markAwaitingInformation.click();}

    public void clickMoreActions(){moreActionsButton.click();}

    public String getReplyStatus(){return replyStatus.getText();}

    public void clickAwaitingCourt(){awaitingCourt.click();}

    public void clickAwaitingJuror(){awaitingJuror.click();}

    public void clickAwaitingTransfer(){awaitingTransfer.click();}

    public boolean seeSummonsReplyTag() { return summonsReplyTag.isDisplayed(); }

    public String getStatusValue(){return replyStatusValue.getText();}

    public String getTypeValue(){return replyTypeValue.getText();}

    public boolean seeReplyMethodLabel(){
        return replyMethodLabel.isDisplayed();
    }

    public String seeReplyMethodValue(){
        return replyMethodValue.getText();
    }

    public boolean seeServiceStartDateLabel(){
        return serviceStartDateLabel.isDisplayed();
    }

    public String getAssignedToStaff(){
        return assignedToStaff.getText();
    }

    public String ineligibilityAgeConfirmHeaderText() { return ineligibilityAgeConfirmHeader.getText();}

    public void clickDisqualifyButton() { disqualifyButton.click();}

    public void clickChangeDateLink() { changeDateLink.click();}

    public String getJurorStatus() { return jurorStatus.getText();}

    public Map<String,String> getCheckAccommodateJurorDetails() {
        Map<String, String > details = new HashMap<>();

        details.put("jurorName", accomodateJurorName.getText());
        details.put("jurorNumber", accomodateJurorNumber.getText());
        details.put("jurorMainPhone", accomodateJurorMainPhone.getText());
        details.put("jurorEmail", accomodateJurorEmail.getText());
        details.put("jurorAdjustmentReason", accomodateJurorAdjustmentReason.getText());
        details.put("jurorAdjustment", accomodateJurorAdjustmentNeeded.getText());

        return details;
    }



}
