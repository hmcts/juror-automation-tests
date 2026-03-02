package cucumber.pageObjects;

import org.apache.log4j.Logger;
import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;

public class ElectoralRegManagement {
    private static WebDriver driver;
    private static final Logger log = Logger.getLogger(ElectoralRegManagement.class);

    public ElectoralRegManagement(WebDriver webDriver) {
        ElectoralRegManagement.driver = webDriver;
        PageFactory.initElements(driver, this);
    }

    @FindBy(xpath = "//h2[contains(text(),'Deadline')]/../../div[2]/p")
    WebElement deadlineDateField;

    @FindBy(xpath = "//span[@aria-label='Days remaining value']")
    WebElement daysRemainingField;

    @FindBy(xpath = "//span[@aria-label='Not uploaded value']")
    WebElement notUploadedField;

    @FindBy(xpath = "//span[contains(text(),'Required')]/../span[1]")
    WebElement requiredField;

    @FindBy(xpath = "//div[@class='doughnut-chart__legend']/div[1]/span")
    WebElement doughnutUploadedField;

    @FindBy(xpath = "//div[@class='doughnut-chart__legend']/div[2]/span")
    WebElement doughnutNotUploadedField;

    @FindBy(id="localAuthorityFilter")
    WebElement localAuthorityFilter;

    @FindBy(xpath="//*[@id='localAuthoritiesTable']/tbody/tr/td[2]/a")
    WebElement localAuthorityInResults;

    @FindBy(xpath = "//div[@class='selected-la-banner__container']/span")
    WebElement localAuthorityNameOnDataUploadScreen;

    @FindBy(xpath = "//th[contains(text(),'Deadline')]/../td")
    WebElement localAuthorityDeadlineDateOnDataUploadScreen;

    @FindBy(xpath = "//th[contains(text(),'Days remaining')]/../td")
    WebElement daysRemainingFieldOnLAUploadScreen;

    @FindBy(xpath = "//th[contains(text(),'Deadline')]/../td")
    WebElement deadlineDateOnLAUploadScreen;

    @FindBy(xpath = "//th[contains(text(),'Status')]/../td/strong")
    WebElement statusOnDataUploadScreen;

    public String deadlineDate() { return deadlineDateField.getText(); }

    public String daysRemainingCount() {
        return daysRemainingField.getText();
    }

    public String notUploadedCount() {
        return notUploadedField.getText();
    }

    public String requiredCount() {
        return requiredField.getText();
    }

    public String doughnutUploadedcount() {
        return doughnutUploadedField.getText();
    }

    public String doughnutNotUploadedCount() {
        return doughnutNotUploadedField.getText();
    }

    public void filterByLocalAuthority(String localAuth){
        log.info("Inputting LA filter");
        localAuthorityFilter.sendKeys(localAuth);
    }

    public String localAuthInTableName() {
        return localAuthorityInResults.getText();
    }

    public String localAuthStatusInTableHasStatus(String localAuth) {
        WebElement localAuthStatusInTable = driver.findElement(By.xpath("//*[contains(text(),'" + localAuth + "')]/../following-sibling::td"));
        return localAuthStatusInTable.getText();
    }

    public String localAuthStatusInTableHasLastUpload(String localAuth) {
        WebElement localAuthLastUpload = driver.findElement(By.xpath("//*[contains(text(),'"+ localAuth + "')]/../following-sibling::td[2]"));
        return localAuthLastUpload.getText();
    }

    public String localAuthNameOnDataUploadScreen() {
        return localAuthorityNameOnDataUploadScreen.getText();
    }

    public String localAuthDeadlineDateOnDataUploadScreen() {
        return deadlineDateOnLAUploadScreen.getText();
    }

    public String localAuthDaysRemainingDateOnDataUploadScreen() {
        return daysRemainingFieldOnLAUploadScreen.getText();
    }

    public String localAuthStatusOnDataUploadScreen() {
        return statusOnDataUploadScreen.getText();
    }
}
