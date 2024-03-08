package cucumber.pageObjects;

import org.apache.log4j.Logger;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;


public class CourtJurorRecord {

    private static WebDriver driver;
    private static final Logger log = Logger.getLogger(CourtJurorRecord.class);

    public CourtJurorRecord(WebDriver webDriver) {
        CourtJurorRecord.driver = webDriver;
        PageFactory.initElements(webDriver, this);
    }

    @FindBy(xpath = "//div/strong[@class='govuk-tag govuk-tag--turquoise']")
    WebElement jurorRecordTag;

    @FindBy(xpath = "//a[contains(@class, 'govuk-button') and normalize-space(text()) ='Enter summons reply']")
    WebElement enterSummonsReplyButton;

    @FindBy(id = "overviewTab")
    WebElement overviewTab;

    @FindBy(id = "detailsTab")
    WebElement jurorDetailsTab;

    @FindBy(id = "expensesTab")
    WebElement financeTab;

    @FindBy(id = "attendanceTab")
    WebElement attendanceTab;

    @FindBy(id = "notesTab")
    WebElement notesTab;

    @FindBy(id = "historyTab")
    WebElement historyTab;


    public boolean seeJurorRecordTag() { return jurorRecordTag.isDisplayed(); }

    public boolean seeEnterSummonsReplyButton() { return enterSummonsReplyButton.isDisplayed(); }

    public boolean seeOverviewTab() { return overviewTab.isDisplayed(); }

    public boolean seeDetailsTab() { return jurorDetailsTab.isDisplayed(); }

    public boolean seeFinanceTab() { return financeTab.isDisplayed(); }

    public boolean seeAttendanceTab() { return attendanceTab.isDisplayed(); }

    public boolean seeNotesTab() { return notesTab.isDisplayed(); }

    public boolean seeHistoryTab() { return historyTab.isDisplayed(); }



}

