package cucumber.pageObjects;

import org.apache.log4j.Logger;
import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;

import javax.lang.model.element.Element;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.Instant;
import java.time.temporal.ChronoUnit;
import java.util.Date;

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

    public String deadlineDate() {
        return deadlineDateField.getText();
    }

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
        WebElement localAuthInTable = driver.findElement(By.xpath("//*[contains(text(),'"+ localAuth + "')]/../following-sibling::td/strong"));
        return localAuthInTable.getText();
    }

}
