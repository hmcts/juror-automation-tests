package cucumber.pageObjects;

import cucumber.utils.WaitUtil_v2;
import cucumber.utils.WaitUtils;
import org.apache.log4j.Logger;
import org.openqa.selenium.By;
import org.openqa.selenium.JavascriptExecutor;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.interactions.Actions;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;

import java.util.ArrayList;
import java.util.List;
import java.util.Random;

public class ActivePools {

    private static WebDriver driver;

    private static final Logger log = Logger.getLogger(ActivePools.class);
    private final NavigationShared NAV;

    @FindBy(xpath = "//input[@type='radio']")
    WebElement firstPoolNoInList;

    @FindBy(xpath = "/html/body/div[2]/main/div/div/form/table")
    WebElement randomActivePool;

    @FindBy(xpath = "//input[@name='check-all-jurors' or @id='check-all-jurors']")
    WebElement poolOverviewSelectAll;

    @FindBy(id = "check-all-jurors")
    WebElement bureauPoolOverviewSelectAll;

    public ActivePools(WebDriver driver) {
        ActivePools.driver = driver;
        PageFactory.initElements(driver, this);
        NAV = new NavigationShared(driver);
    }

    public List<String> getTableHeaders() {
        List<String> headers = new ArrayList<>();
        List<WebElement> elements = driver.findElements(By.xpath("//th"));

        elements.forEach(element -> headers.add(element.getText()));
        return headers;
    }

    public List<String> getCourtNames() {
        List<String> names = new ArrayList<>();
        List<WebElement> elements = driver.findElements(By.xpath("//tbody/tr/td[4]"));

        elements.forEach(element -> names.add(element.getText()));
        return names;
    }

    public void selectFirstPoolNoInList() {
        log.info("Clicked first pool number in list");
        firstPoolNoInList.click();

    }

    public void checkSelectAllCheckbox() {
        log.info("Clicked select all checkbox");
        poolOverviewSelectAll.click();
    }

    public void checkSelectAllCheckboxOnPoolOverview() {
        poolOverviewSelectAll.click();
        log.info("Clicked select all checkbox on pool overview");
    }
    public void bureauCheckSelectAllCheckboxOnPoolOverview() {
        log.info("Clicked select all checkbox on pool overview");
        Actions actions = new Actions(driver);
        actions.moveToElement(bureauPoolOverviewSelectAll);
        actions.perform();
        bureauPoolOverviewSelectAll.click();

    }
    public void selectAnyActivePool() {
        String activePoolsTable = "/html/body/div[2]/main/div/div/form/table";
        List<WebElement> rows = driver.findElements(By.xpath(activePoolsTable + "/tbody/tr"));

        Random random = new Random();
        int randomRowIndex = random.nextInt(rows.size());
        List<WebElement> radioButtons = rows.get(randomRowIndex).findElements(By.xpath(".//input[@type='radio' and @name='poolNumber']"));
        int randomActivePool = random.nextInt(radioButtons.size());
        radioButtons.get(randomActivePool).click();
        log.info("Random active pool found and clicked");
    }
    public boolean seeJurorsInCannotBeMovedTable(String jurorNumber) {
        String jurorsCannotBeMovedTable = "//*[@id=\"deferralForm\"]/div[2]/div/div/table";
        List<WebElement> rows = driver.findElements(By.xpath(jurorsCannotBeMovedTable + "/tbody/tr"));

        for (WebElement row : rows) {
            List<WebElement> cells = row.findElements(By.tagName("td"));
            for (WebElement cell : cells) {
                if (cell.getText().contains(jurorNumber)) {
                    return true;
                }
            }
        }
        return false;
    }

    public void checkSelectAllCheckboxOnPoolOverviewForCourt() {
        log.info("Clicked select all checkbox on pool overview");
        poolOverviewSelectAll.click();    }
}