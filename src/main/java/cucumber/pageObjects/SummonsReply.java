package cucumber.pageObjects;

import cucumber.utils.AngularJsHTTPCallWait;
import cucumber.utils.WaitUtil_v2;
import cucumber.utils.WaitUtils;
import org.apache.log4j.Logger;
import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import org.openqa.selenium.support.ui.Select;

import java.util.List;
import java.util.stream.Collectors;

public class SummonsReply {

    private static WebDriver driver;
    private static final Logger log = Logger.getLogger(SummonsReply.class);
    private final WaitUtils wait;
    private final WaitUtil_v2 wait1;
    private final AngularJsHTTPCallWait aJsWait;
    private final NavigationShared NAV;

    private final Header HEADER_PAGE;

    public SummonsReply(WebDriver driver) {
        SummonsReply.driver = driver;
        PageFactory.initElements(driver, this);
        wait = new WaitUtils(driver);
        wait1 = new WaitUtil_v2(driver);
        aJsWait = new AngularJsHTTPCallWait(driver);
        NAV = new NavigationShared(driver);
        HEADER_PAGE = PageFactory.initElements(driver, Header.class);
    }

    @FindBy(linkText = "Enter summons reply")
    WebElement enterSummonsReplyButton;

    @FindBy(id = "dobDay")
    WebElement dobDay;

    @FindBy(id = "dateOfBirthDay")
    WebElement dateOfBirthDay;

    @FindBy(id = "dobMonth")
    WebElement dobMonth;

    @FindBy(id = "dateOfBirthMonth")
    WebElement dateOfBirthMonth;

    @FindBy(id = "dobYear")
    WebElement dobYear;

    @FindBy(id = "dateOfBirthYear")
    WebElement dateOfBirthYear;

    @FindBy(id = "primaryPhone")
    WebElement mainPhone;

    @FindBy(id = "secondaryPhone")
    WebElement altPhone;

    @FindBy(id = "emailAddress")
    WebElement email;

    @FindBy(id = "jurorCompletedOnBehalf")
    WebElement completedOnBehalfYes;

    @FindBy(id = "jurorCompletedOnBehalf-2")
    WebElement completedOnBehalfNo;

    @FindBy(id = "thirdPartyReason")
    WebElement thirdPartyReasonNotHere;

    @FindBy(id = "continueButton")
    WebElement continueButton;

    @FindBy(id = "livedConsecutive")
    WebElement livedConsecutivelyYes;

    @FindBy(id = "livedConsecutive-2")
    WebElement livedConsecutivelyNo;

    @FindBy(id = "mentalHealthAct")
    WebElement mentalHealthActYes;

    @FindBy(id = "mentalHealthAct-2")
    WebElement mentalHealthActNo;

    @FindBy(id = "mentalHealthCapacity")
    WebElement lackCapacityYes;
    @FindBy(id = "mentalHealthCapacity-2")
    WebElement lackCapacityNo;

    @FindBy(id = "onBail")
    WebElement onBailYes;

    @FindBy(id = "onBail-2")
    WebElement onBailNo;

    @FindBy(id = "convicted")
    WebElement criminalOffenceYes;

    @FindBy(id = "convicted-2")
    WebElement criminalOffenceNo;

    @FindBy(id = "deferralValue")
    WebElement canServeDate;

    @FindBy(id = "deferralValue-2")
    WebElement deferralRequest;

    @FindBy(id = "deferralValue-3")
    WebElement excusalRequest;

    @FindBy(id = "cjsEmploymentResponse")
    WebElement cjsEmploymentYes;

    @FindBy(id = "cjsEmploymentResponse-2")
    WebElement cjsEmploymentNo;

    @FindBy(id = "signed")
    WebElement signedYes;

    @FindBy(id = "signed-2")
    WebElement signedNo;

    @FindBy(id = "adjustmentsResponse")
    WebElement adjustmentsYes;

    @FindBy(id = "adjustmentsResponse-2")
    WebElement adjustmentsNo;

    @FindBy(id = "welsh")
    WebElement welsh;

    @FindBy(id = "doneButton")
    WebElement doneButton;

    @FindBy(className = "govuk-heading-l")
    WebElement heading;

    @FindBy(id = "fixNameAnchor")
    WebElement changeName;
    @FindBy(id = "addressChangeAnchor")
    WebElement changeAddress;

    @FindBy(id = "firstName")
    WebElement firstNameField;

    @FindBy(id = "address1")
    WebElement address1;

    @FindBy(id = "saveButton")
    WebElement saveChanges;

    @FindBy(xpath = "//div/h2[contains(text(),'Address')]/../../div[4]/div/p")
    WebElement jurorAddress;

    @FindBy(xpath = "//div/h2[contains(text(),'Name')]/../../div[2]/div/p")
    WebElement jurorName;

    @FindBy(id = "cjsSystemOptionsPolice")
    WebElement policeForceCheckbox;

    @FindBy(id = "cjsSystemPoliceDetails")
    WebElement policeForceTextBox;

   @FindBy(id = "processReply")
    WebElement processReplyButton;

    @FindBy(xpath = "//input[@value='excusal']")
    WebElement excusalRadioButton;

    @FindBy(id = "excusalDecision")
    WebElement grantExcusalRadioButton;

    @FindBy(id = "excusalDecision-2")
    WebElement refuseExcusalRadioButton;

    @FindBy(xpath = "//div[@class='moj-banner__message']")
    WebElement responseBanner;

    @FindBy(id = "processActionType")
    WebElement markAsResponded;

    @FindBy(id = "processActionType-2")
    WebElement processActionDeferralRequest;

    @FindBy(id = "responded")
    WebElement confirmMarkAsRespondedCheckbox;
    @FindBy(xpath = "//button[text()[contains(.,'Confirm')]]")
    WebElement markAsRespondedConfirmButton;

    @FindBy(xpath = "//div[@Class='moj-banner moj-banner--success']")
    WebElement processedSuccessBanner;

    @FindBy(xpath = "//div[@Class='moj-banner moj-banner--success']/div/a")
    WebElement processedSuccessBannerLink;

    @FindBy(xpath = "//a[contains(text(),'Cancel')]")
    WebElement cancelLink;

    @FindBy(xpath = "//a[@ID='cancelAnchor'][contains(text(),'process later')]")
    WebElement cancelAnchorProcessLater;

    @FindBy(xpath = "//*[@class='info with-icon']")
    WebElement jurorStatus;

    @FindBy(xpath = "//*[@id='deferralForm']/descendant::p[@class='govuk-body']")
    WebElement reassignErrorText;

    @FindBy(xpath = "//*[@class='govuk-error-summary']")
    WebElement respondedError;

    @FindBy(xpath = "//*[@class='govuk-error-summary']/div/ul/li/a")
    WebElement respondedErrorText;

    @FindBy(xpath = "//dt[contains(text(),'Reply status')]/../..//strong")
    WebElement replyStatus;

    @FindBy(id = "jurorNumber")
    WebElement jurorNumber;

    @FindBy(id = "jurorLastName")
    WebElement jurorLastName;

    @FindBy(id = "jurorPostcode")
    WebElement jurorPostcode;

    @FindBy(id = "deferralReason")
    WebElement digitalDeferralReason;

    @FindBy(name = "deferDate1")
    WebElement firstChoice;

    @FindBy(name = "deferDate2")
    WebElement secondChoice;

    @FindBy(name = "deferDate3")
    WebElement thirdChoice;

    @FindBy(name = "deferredToDate1")
    WebElement firstChoicePaper;

    @FindBy(name = "deferredToDate2")
    WebElement secondChoicePaper;

    @FindBy(name = "deferredToDate3")
    WebElement thirdChoicePaper;

    @FindBy(name = "deferralDate")
    WebElement altChoicePaper;

    @FindBy(xpath = "//input[@value='otherDate']")
    WebElement deferralOptionDifferent;

    @FindBy(xpath = "//input[@id='deferralOption-1']")
    WebElement deferralOption1;

    @FindBy(xpath = "/html/body/div[2]/main/form/div[3]/div/div[1]/div/div[1]/button")
    WebElement dateOfBirthButton;

    @FindBy(id = "dateOfBirth")
    WebElement dateOfBirth;

    @FindBy(id = "thirdPartyEnabled")
    WebElement thirdPartyRadioButton;

    @FindBy(id = "extraSupport")
    WebElement additionalRequirementsButton;

    @FindBy(xpath = "/html/body/div[4]/main/nav/div[1]/div/div[1]/nav/ul/li[1]")
    WebElement jurorDetailsTab;

    @FindBy(xpath = "/html/body/div[4]/main/nav/div[1]/div/div[1]/nav/ul/li[2]/a")
    WebElement eligibilityTab;

    @FindBy(xpath = "/html/body/div[4]/main/nav/div[1]/div/div[1]/nav/ul/li[3]/a")
    WebElement deferralOrExcusalTab;

    @FindBy(xpath = "/html/body/div[4]/main/nav/div[1]/div/div[1]/nav/ul/li[4]/a")
    WebElement cjsEmploymentTab;
    @FindBy(xpath = "/html/body/div[4]/main/nav/div[1]/div/div[1]/nav/ul/li[5]/a")
    WebElement reasonableAdjustmentsTab;

    @FindBy(xpath = "/html/body/div[4]/main/nav/div[1]/div/div[1]/nav/ul/li[6]/a")
    WebElement signatureTab;

    @FindBy(xpath = "/html/body/div[3]/main/div/div/form/div[1]/fieldset/div/div[2]/input")
    WebElement residencyNoButton;

    @FindBy(id = "processReply")
    WebElement processNowButton;

    @FindBy(xpath = "//*[@id=\"residency\"]/div[contains(text(),\"Attention\")]")
    WebElement residencyAttention;

    @FindBy(xpath = "//*[@id=\"mentalHealth\"]/div[contains(text(),\"Attention\")]")
    WebElement mentalHealthAttention;

    @FindBy(xpath = "//*[@id=\"bail\"]/div[contains(text(),\"Attention\")]")
    WebElement bailAttention;

    @FindBy(xpath = "//*[@id=\"convictions\"]/div[contains(text(),\"Attention\")]")
    WebElement convictionsAttention;

    @FindBy(xpath = "//*[@id=\"deferralOrExcusal\"]/div[contains(text(),\"Attention\")]")
    WebElement deferralExcusalAttention;

    @FindBy(xpath = "//*[@id=\"cjsEmploymentDetails\"]/div[contains(text(),\"Attention\")]")
    WebElement cjsEmploymentAttention;

    @FindBy(xpath = "//*[@id=\"disability\"]/div[contains(text(),\"Attention\")]")
    WebElement reasonableAdjustmentsAttention;

    public String getReplyStatus() {
        return replyStatus.getText();
    }

    public void selectExcusalRadio() {
        excusalRadioButton.click();
    }

    public void selectGrantExcusalRadio() {
        grantExcusalRadioButton.click();
    }

    public void selectRefuseExcusalRadio() {
        refuseExcusalRadioButton.click();
    }

    public String getHeadingText() {
        return heading.getText();
    }

    public void clickEnterSummonsReplyButton() {
        enterSummonsReplyButton.click();
    }

    public void enterDobDay(String text) {
        try {
            dobDay.clear();
            dobDay.sendKeys(text);
        } catch (Exception e) {
            dateOfBirthDay.clear();
            dateOfBirthDay.sendKeys(text);
        }
    }

    public void enterDobMonth(String text) {
        try {
            dobMonth.clear();
            dobMonth.sendKeys(text);
        } catch (Exception e) {
            dateOfBirthMonth.clear();
            dateOfBirthMonth.sendKeys(text);
        }
    }

    public void enterDobYear(String text) {
        try {
            dobYear.clear();
            dobYear.sendKeys(text);
        } catch (Exception e) {
            dateOfBirthYear.clear();
            dateOfBirthYear.sendKeys(text);
        }
    }

    public void enterPrimaryPhone(String text) {
        mainPhone.clear();
        mainPhone.sendKeys(text);
    }

    public void enterSecondaryPhone(String text) {
        altPhone.clear();
        altPhone.sendKeys(text);
    }

    public String reassignErrorText() {
        return reassignErrorText.getText();
    }

    public void enterEmail(String text) {
        email.clear();
        email.sendKeys(text);
    }

    public void selectYesOnBehalfOf() {
        completedOnBehalfYes.click();
    }

    public void selectNoOnBehalfOf() {
        completedOnBehalfNo.click();
    }

    public void selectThirdPartyReasonNotHere() {
        thirdPartyReasonNotHere.click();
    }

    public void clickContinue() {
        continueButton.click();
    }

    public void clickLivedConsecutivelyYes() {
        livedConsecutivelyYes.click();
    }

    public void clickLivedConsecutivelyNo() {
        livedConsecutivelyNo.click();
    }

    public void clickMentalHealthActYes() {
        mentalHealthActYes.click();
    }

    public void clickMentalHealthActNo() {
        mentalHealthActNo.click();
    }

    public void clickLackCapacityYes() {
        lackCapacityYes.click();
    }

    public void clickLackCapacityNo() {
        lackCapacityNo.click();
    }

    public void clickOnBailYes() {
        onBailYes.click();
    }

    public void clickOnBailNo() {
        onBailNo.click();
    }

    public void clickCriminalOffenceYes() {
        criminalOffenceYes.click();
    }

    public void clickCriminalOffenceNo() {
        criminalOffenceNo.click();
    }

    public void clickCanServeDate() {
        canServeDate.click();
    }

    public void clickDeferralRequest() {
        deferralRequest.click();
    }

    public void clickExcusalRequest() {
        excusalRequest.click();
    }

    public void clickCjsEmploymentYes() {
        cjsEmploymentYes.click();
    }

    public void clickCjsEmploymentNo() {
        cjsEmploymentNo.click();
    }

    public void clickAdjustmentsYes() {
        adjustmentsYes.click();
    }

    public void clickAdjustmentsNo() {
        adjustmentsNo.click();
    }


    public void clickWelsh() {
        welsh.click();
    }

    public void clickSignedYes() {
        signedYes.click();
    }

    public void clickSignedNo() {
        signedNo.click();
    }

    public void clickDoneButton() {
        doneButton.click();
    }

    public void enterDateOfBirth(String text) {
        dateOfBirth.clear();
        dateOfBirth.sendKeys(text);
    }

    public void clickDateOfBirthButton() {
        dateOfBirthButton.click();
    }

    public void clickYesThirdPartyJurorDetailsButton() {
        thirdPartyRadioButton.click();
    }

    public void clickYesAdditionalRequirementsJurorDetailsButton() {
        additionalRequirementsButton.click();
    }

    public void clickJurorDetailsTab() {
        jurorDetailsTab.click();
    }

    public void clickEligibilityTab() {
        eligibilityTab.click();
    }


    public void clickdeferralOrExcusalTab() {
        deferralOrExcusalTab.click();
    }


    public void clickcjsEmploymentTab() {
        cjsEmploymentTab.click();
    }


    public void clickreasonableAdjustmentsTab() {
        reasonableAdjustmentsTab.click();
    }


    public void clicksignatureTab() {
        signatureTab.click();
    }

    public void clickresidencyNoButton() {
        residencyNoButton.click();

    }

    public void clickProcessNowButton() {
        processNowButton.click();
    }

    public List<String> getErrors() {
        return driver.findElements(By.xpath(
                "//ul[@class=\"govuk-list govuk-error-summary__list\"]//li"
        )).stream().map(WebElement::getText).collect(Collectors.toList());
    }

    public void clickChangeName() {
        changeName.click();
    }

    public void enterFirstName(String name) {
        firstNameField.clear();
        firstNameField.sendKeys(name);
    }

    public void clickChangeAddress() {
        changeAddress.click();
    }

    public void enterAddressLineOne(String address) {
        address1.clear();
        address1.sendKeys(address);
    }

    public void saveChanges() {
        saveChanges.click();
    }

    public String getJurorName() {
        return jurorName.getText();
    }

    public String getJurorAddress() {
        return jurorAddress.getText();
    }

    public void selectPoliceForceYes() {
        policeForceCheckbox.click();
    }

    public void enterPoliceForceDetails(String text) {
        policeForceTextBox.sendKeys(text);
    }

    public boolean processReplyButtonIsPresent() {
        return processReplyButton.isDisplayed();
    }

    public void clickProcessReplyButton() {
        processReplyButton.click();
    }

    public static Boolean processedSuccessBannerInvisible() {
        List<WebElement> elements = driver.findElements(By.xpath("//div[@class=\"moj-banner moj-banner--success\"]"));
        return elements.isEmpty();
    }

    public String getResponseBannerText() {
        return responseBanner.getText();
    }

    public void clickMarkAsResponded() {
        markAsResponded.click();
    }

    public void clickProcessAcionDeferralRequest() {
        processActionDeferralRequest.click();
    }

    public void clickMarkAsRespondedCheckbox() {
        confirmMarkAsRespondedCheckbox.click();
    }

    public void clickConfirmMarkAsRespondedButton() {
        markAsRespondedConfirmButton.click();
    }

    public boolean processedSuccessBannerIsPresent() {
        return processedSuccessBanner.isDisplayed();
    }

    public String processSuccessBannerLink() {
        return processedSuccessBannerLink.getText();
    }

    public void clickProcessSuccessBannerLink() {
        processedSuccessBannerLink.click();
    }

    public void clickCancelLink() {
        cancelLink.click();
    }

    public String getJurorStatus() {
        return jurorStatus.getText();
    }

    public boolean errorIsPresent() {
        return respondedError.isDisplayed();
    }

    public String getErrorText() {
        return respondedErrorText.getText();
    }

    public Boolean enterSummonsReplyButtonInvisible() {
        List<WebElement> elements = driver.findElements(By.xpath("//a[contains(text(),'Enter summons reply')]"));
        return elements.isEmpty();

    }

    public Boolean processReplyButtonInvisible() {
        List<WebElement> elements = driver.findElements(By.xpath("//a[contains(text(),'Process reply')]"));
        return elements.isEmpty();

    }

    public void clickNoToReplyLater() {
        cancelAnchorProcessLater.click();
    }

    public void setJurorNumber(String jurorNo) {
        jurorNumber.sendKeys(jurorNo);
    }

    public void setJurorLname(String jurorLname) {
        jurorLastName.sendKeys(jurorLname);
    }

    public void setJurorPostcode(String jurorPost) {
        jurorPostcode.sendKeys(jurorPost);
    }

    public void setDigitalDeferralReason(String deferralReason) {
        digitalDeferralReason.sendKeys(deferralReason);
    }

    public void setFirstChoice(String firstChoiceDate) {
        firstChoice.clear();
        firstChoice.sendKeys(firstChoiceDate);
    }

    public void setSecondChoice(String secondChoiceDate) {
        secondChoice.clear();
        secondChoice.sendKeys(secondChoiceDate);
    }

    public void setThirdChoice(String thirdChoiceDate) {
        thirdChoice.clear();
        thirdChoice.sendKeys(thirdChoiceDate);
    }

    public void setFirstChoicePaper(String firstChoiceDate) {
        firstChoicePaper.clear();
        firstChoicePaper.sendKeys(firstChoiceDate);
    }

    public void setSecondChoicePaper(String secondChoiceDate) {
        secondChoicePaper.clear();
        secondChoicePaper.sendKeys(secondChoiceDate);
    }

    public void setThirdChoicePaper(String thirdChoiceDate) {
        thirdChoicePaper.clear();
        thirdChoicePaper.sendKeys(thirdChoiceDate);
    }

    public void setAltChoicePaper(String altChoiceDate) {
        altChoicePaper.clear();
        altChoicePaper.sendKeys(altChoiceDate);
    }

    public void deferralOptionDifferent() {
        deferralOptionDifferent.click();
    }

    public void deferralOption1() {
        deferralOption1.click();
    }

    public void clickPoolCreatedForDeferral(String poolNumber) {
        driver.findElement(By.xpath("//*[contains(text(),'" + poolNumber + "')]/../../input")).click();
    }

    public void selectAdjustmentReason(String reason) {
        WebElement dropdown = driver.findElement(By.id("adjustmentsReason"));
        Select select = new Select(dropdown);
        select.selectByVisibleText(reason);
    }

    public void eligibilityAttentionIndicatorVisible(String eligibilityCriteria) {

        switch (eligibilityCriteria) {
            case "Residency":
                residencyAttention.isDisplayed();
                break;

            case "Mental health act":
                mentalHealthAttention.isDisplayed();
                break;

            case "Bail":
                bailAttention.isDisplayed();
                break;

            case "Convictions":
                convictionsAttention.isDisplayed();
                break;

            case "Deferral or excusal":
                deferralExcusalAttention.isDisplayed();
                break;

            case "CJS employment":
                cjsEmploymentAttention.isDisplayed();
                break;

            case "Reasonable adjustments":
                reasonableAdjustmentsAttention.isDisplayed();
                break;

        }
    }
  
  public String getStatusOfItemInEligiability(String item) {
        return driver.findElement(By.xpath("//*[@Id='eligibility']/descendant::dt[contains(text(),'" + item + "')]/../dd")).getText();
    }
}
