package cucumber.pageObjects;

import cucumber.utils.AngularJsHTTPCallWait;
import cucumber.utils.WaitUtil_v2;
import cucumber.utils.WaitUtils;
import org.apache.log4j.Logger;
import org.openqa.selenium.By;
import org.openqa.selenium.Keys;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;

public class SummonsReplySearch {
    private static WebDriver driver;
    private static Logger log = Logger.getLogger(Search.class);


    public SummonsReplySearch(WebDriver webDriver) {
        SummonsReplySearch.driver = webDriver;
        PageFactory.initElements(webDriver, this);
    }

    @FindBy(id = "searchBtn")
    WebElement searchButton;

    @FindBy(id = "jurorNumber")
    WebElement jurorNumber;

    @FindBy(id = "lastName")
    WebElement jurorsLastName;

    @FindBy(id = "poolNumber")
    WebElement poolNumber;

    @FindBy(xpath = "//*[@id=\"filterForm\"]/div[1]/fieldset/div[4]/div/details/summary")
    WebElement expandAdvanced;

    @FindBy(id = "clearBtn")
    WebElement clearButton;

    @FindBy(id = "officerAssigned")
    WebElement officerAssignedList;

    @FindBy(id = "isUrgent")
    WebElement urgentCheckBox;

    @FindBy(id = "todo")
    WebElement todoCheckbox;

    @FindBy(id = "awaitingReply")
    WebElement awaitingCourtReplyCheckbox;

    @FindBy(id = "awaitingContact")
    WebElement awaitingJurorReplyCheckbox;

    @FindBy(id = "awaitingTranslation")
    WebElement awaitingTranslationCheckbox;

    @FindBy(id = "closed")
    WebElement completedCheckbox;

    public void setJurorNumber(String jurorNum){ jurorNumber.sendKeys(jurorNum);}

    public void setLastName(String lastName){ jurorsLastName.sendKeys(lastName);}

    public void setPoolNumber(String poolNum){ poolNumber.sendKeys(poolNum);}

    public void setOfficerAssigned(String officerAssigned){
        for (int i = 0; i < 31; i++) {
            officerAssignedList.sendKeys(Keys.BACK_SPACE);
        }
        officerAssignedList.sendKeys(officerAssigned);
        officerAssignedList.sendKeys(Keys.ENTER);
    }

    public void clickSearchButton() { searchButton.click(); }

    public void clickAdvancedSearch() { expandAdvanced.click(); }

    public void clickUrgentCheckbox() {log.info("Clicked urgent checkbox");urgentCheckBox.click();}

    public void clickAwaitingCourtReplyCheckbox() {log.info("Clicked awaiting court reply checkbox");awaitingCourtReplyCheckbox.click();}

    public void clickAwaitingJurorReplyCheckbox() {log.info("Clicked awaiting juror reply checkbox");awaitingJurorReplyCheckbox.click();}

    public void clickAwaitingTranslationCheckbox() {log.info("Clicked awaiting translation checkbox");awaitingTranslationCheckbox.click();}

    public void clickToDoCheckbox() {log.info("Clicked  checkbox");todoCheckbox.click();}

    public void clickCompletedCheckbox() {log.info("Clicked completed checkbox");completedCheckbox.click();}

    public void clickClearButton() {log.info("Clicked clear button");clearButton.click();}
}
