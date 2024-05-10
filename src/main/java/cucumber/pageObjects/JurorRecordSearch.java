package cucumber.pageObjects;

import org.apache.log4j.Logger;
import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;

import java.util.List;

import static org.junit.Assert.assertTrue;


public class JurorRecordSearch {

    private static WebDriver driver;
    private static final Logger log = Logger.getLogger(JurorRecordSearch.class);

    public JurorRecordSearch(WebDriver webDriver) {
        JurorRecordSearch.driver = webDriver;
        PageFactory.initElements(webDriver, this);
    }

    @FindBy(id = "search-button")
    WebElement globalSearchExpand;

    @FindBy(id = "globalSearch")
    WebElement globalSearchField;

    @FindBy(id = "poolNumber")
    WebElement poolSearchField;

    @FindBy(xpath = "//div[@class='moj-header__navigation-dropdown-menu']//button")
    WebElement globalSearchSubmit;

    @FindBy(id = "jurorNumber")
    WebElement jurorNumber;

    @FindBy(id = "jurorStatus")
    WebElement jurorStatus;

    @FindBy(id = "poolNumber")
    WebElement poolNumber;

    @FindBy(id = "courtStartDate")
    WebElement courtStartDate;

    @FindBy(id = "courtName")
    WebElement courtName;

    @FindBy(id = "main-content")
    WebElement mainBody;

    @FindBy(id = "summonsTab")
    WebElement summonsTab;

    @FindBy(xpath = "//*[contains(text(),'View summons reply')]")
    WebElement viewSummonsReplyLink;

    @FindBy(xpath = "//*[contains(text(),'Update juror record')]")
    WebElement updateJurorRecordButton;
    @FindBy(xpath = "//*[contains(text(),'Mark as deceased')]")
    WebElement markAsDeceasedRadioButton;

    @FindBy(xpath = "//*[contains(text(),'Mark summons as undeliverable')]")
    WebElement markAsUndeliverableRadioButton;

    @FindBy(id = "jurorDeceased")
    WebElement jurorDeceasedComment;
    @FindBy(xpath = "//button[@type='submit']")
    WebElement continueButton;

    @FindBy(xpath = "//*[@class='moj-banner__message']/b")
    WebElement bannerMessageBoldText;

    @FindBy(xpath = "//*[@class='govuk-list govuk-error-summary__list']/li/a")
    WebElement errorBannerText;

    @FindBy(xpath = "//*[@id=\"main-content\"]/table")
    WebElement searchResultsTable;

    @FindBy(xpath = "//*[@id=\"main-content\"]/h2")
    WebElement searchResultsHeader;

    public void searchForRecordFromGlobalSearch(final String jurorNumber) {

        globalSearchExpand.click();
        globalSearchField.sendKeys(jurorNumber);
        globalSearchSubmit.click();
    }

    public void clickGlobalSearch() {

        globalSearchExpand.click();
    }

    public void searchForRecordFromPoolSearch(final String jurorNumber) {
        poolSearchField.sendKeys(jurorNumber);
        clickContinue();
    }

    public Boolean searchButtonInvisible() {
        List<WebElement> elements = driver.findElements(By.id("search-button"));
        return elements.isEmpty();

    }

    public String getJurorNumber() {
        return jurorNumber.getText();
    }

    public String getJurorStatus() {
        return jurorStatus.getText();
    }

    public String getPoolNumber() {
        return poolNumber.getText();
    }

    public String getCourtStartDate() {
        return courtStartDate.getText();
    }

    public String getCourtName() {
        return courtName.getText();
    }

    public String getMainBodyText() {
        return mainBody.getText();
    }

    public void clickSummonsTab(){ summonsTab.click();}

    public void clickViewSummonsReplyLink(){ viewSummonsReplyLink.click();}

    public void clickUpdateJurorRecord() { updateJurorRecordButton.click();}

    public void clickMarkAsDeceasedRadioButton() { markAsDeceasedRadioButton.click();}

    public void clickMarkAsUndeliverableRadioButton() { markAsUndeliverableRadioButton.click();}

    public void enterCommentForHistory(String commentForHistory) { jurorDeceasedComment.sendKeys(commentForHistory);}

    public void clickContinue() { continueButton.click();}

    public String jurorRecordUpdatedContains() { return bannerMessageBoldText.getText();}

    public String jurorRecordUpdatedErrorBannerText() { return errorBannerText.getText();}

    public String getSearchResultsHeader() { return searchResultsHeader.getText(); }

    public void clickJurorRecordForCourt(String court){
        WebElement tableBody = searchResultsTable.findElement(By.tagName("tbody"));
        List<WebElement> tableRows = tableBody.findElements(By.tagName("tr"));
        for(int i = 0; i < tableRows.size(); i++){
            List<WebElement> jurorRecordColumns = tableRows.get(i).findElements(By.tagName("td"));
            WebElement jurorRecordLink = jurorRecordColumns.get(0).findElement(By.tagName("a"));
            String courtName = jurorRecordColumns.get(4).getText();
            if (courtName.equals(court)){
                log.info("clicking link for juror record at: " + courtName + " jurorNumber: " + jurorRecordLink.getText());
                jurorRecordLink.click();
                break;
            }
        }
    }

}

