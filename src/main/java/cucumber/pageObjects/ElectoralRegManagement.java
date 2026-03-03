package cucumber.pageObjects;

import org.apache.log4j.Logger;
import org.openqa.selenium.*;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import org.openqa.selenium.support.ui.ExpectedConditions;
import org.openqa.selenium.support.ui.WebDriverWait;

import java.time.Duration;

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

    @FindBy(id = "localAuthorityFilter")
    WebElement localAuthorityFilter;

    @FindBy(xpath = "//*[@id='localAuthoritiesTable']/tbody/tr/td[2]/a")
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

    @FindBy(xpath = "//div[contains(@class,'moj-alert--success')]//div[@class='moj-alert__content']")
    WebElement remindersSentBanner;

    @FindBy(id = "sendReminderButton")
    WebElement sendReminderButton;

    @FindBy(id = "submit")
    WebElement yesSendReminderButton;

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

    public void filterByLocalAuthority(String localAuth) {
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
        WebElement localAuthLastUpload = driver.findElement(By.xpath("//*[contains(text(),'" + localAuth + "')]/../following-sibling::td[2]"));
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

    public void remindersSentSuccessBanner() {
        remindersSentBanner.isDisplayed();
        System.out.println("See Reminders sent success banner");
    }

    public void checkAuthority(String authorityName) {

        String rowXPath = "//tr[.//a[normalize-space()='" + authorityName + "']]";

        int maxRetries = 3;
        int attempts = 0;

        while (attempts < maxRetries) {
            try {
                WebDriverWait wait = new WebDriverWait(driver, Duration.ofSeconds(3));


                WebElement row = wait.until(
                        ExpectedConditions.presenceOfElementLocated(By.xpath(rowXPath))
                );

                WebElement checkbox = row.findElement(By.xpath(".//input[@type='checkbox']"));

                JavascriptExecutor js = (JavascriptExecutor) driver;

                js.executeScript("arguments[0].scrollIntoView({block:'center'});", checkbox);

                if (!checkbox.isSelected()) {
                    checkbox.click();
                }

                log.info(authorityName + " checkbox selected successfully.");
                return;

            } catch (StaleElementReferenceException e) {
                attempts++;
                log.warn("Stale element while checking " + authorityName + " - retry " + attempts);
                PageFactory.initElements(driver, this);
            } catch (Exception e) {
                log.error("Failed to check checkbox for " + authorityName + ": " + e.getMessage(), e);
                return;
            }
        }

        log.error("Failed to check checkbox for " + authorityName + " after retries.");
    }

    public void clickSendReminderButton() {
        sendReminderButton.click();
    }

    public void forceClickSendReminder() {
        try {
            WebDriverWait wait = new WebDriverWait(driver, Duration.ofSeconds(5));

            WebElement button = wait.until(
                    ExpectedConditions.presenceOfElementLocated(
                            By.xpath("//button[contains(normalize-space(), 'Yes - send reminder')]")
                    )
            );

            JavascriptExecutor js = (JavascriptExecutor) driver;

            js.executeScript("arguments[0].scrollIntoView({block:'center'});", button);
            js.executeScript("arguments[0].click();", button);

            log.info("'Yes - send reminder(s)' button clicked.");

        } catch (Exception e) {
            log.error("Failed to click send reminder button: " + e.getMessage(), e);
        }
    }
}
