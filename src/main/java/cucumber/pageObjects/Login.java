package cucumber.pageObjects;

import cucumber.utils.AngularJsHTTPCallWait;
import cucumber.utils.DatabaseSetup;
import cucumber.utils.ReadProperties;
import cucumber.utils.WaitUtil_v2;
import cucumber.utils.WaitUtils;
import org.apache.log4j.Logger;
import org.openqa.selenium.*;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;

import java.util.List;

public class Login {
    private static WebDriver driver;
    private static Logger log = Logger.getLogger(Login.class);
    private WaitUtils wait;
    private WaitUtil_v2 wait1;
    private AngularJsHTTPCallWait aJsWait;
    private NavigationShared NAV;


    public Login(WebDriver driver) {
        Login.driver = driver;
        PageFactory.initElements(driver, this);
        wait = new WaitUtils(driver);
        wait1 = new WaitUtil_v2(driver);
        aJsWait = new AngularJsHTTPCallWait(driver);
        NAV = new NavigationShared(driver);
    }

    @FindBy(xpath = ".//*[contains(@id, 'blobOffenceId')]")
    List<WebElement> sampleListWebElement;

    @FindBy(id = "userID")
    WebElement username_field;

    @FindBy(id = "email")
    WebElement emailField;

    @FindBy(id = "password")
    WebElement password_field;

    @FindBy(id = "newPassword")
    WebElement newPassword_field;

    @FindBy(id = "confirmPassword")
    WebElement confirmPassword_field;

    @FindBy(id = "continue")
    WebElement continue_button;

    @FindBy(id = "continueButton")
    WebElement continueButton;

    @FindBy(xpath = "//input[@value='Sign in']")
    WebElement confirm_button;


    @FindBy(id = "loginBtn")
    WebElement login_button; // @FindBy(xpath = "//button[contains(text(),'Login')]")

    @FindBy(linkText = "Login")
    WebElement loginViaADLink;

    @FindBy(xpath = "//input[@type=\"email\"]")
    WebElement emailADLogin;

    @FindBy(xpath = "//input[@type=\"password\"]")
    WebElement passwordADLogin;

    @FindBy(xpath = "//input[@type=\"submit\"]")
    WebElement submitAD;

    @FindBy(id = "signInEmailButton")
    WebElement signInWithEmail;

    public Login login(String username, String password) throws Throwable {

        username_field.clear();
        username_field.sendKeys(username);

        password_field.clear();
        password_field.sendKeys("password");

        //login_button.click();
        NAV.press_buttonByName("Sign in");

        log.info("Logging in with Username=>" + username + "- Password=>" + password);

        return PageFactory.initElements(driver, Login.class);
    }
    public Login loginADTestRoute(String username) throws Throwable {

        emailField.clear();
        emailField.sendKeys(username);

        signInWithEmail.click();

        log.info("Logging in with Username=> " + username);

        return PageFactory.initElements(driver, Login.class);
    }

    public Login loginWithAD(String username, String password) {
        loginViaADLink.click();
        wait.waitForDisplayedElement(emailADLogin, 10);
        emailADLogin.sendKeys(username);
        submitAD.click();

        wait.waitForDisplayedElement(passwordADLogin, 10);
        passwordADLogin.sendKeys(password);
        submitAD.click();

        // There is an additional step where AD asks if you'd like to stay logged in
        wait.waitForDisplayedElement(submitAD, 10);
        submitAD.click();

        return PageFactory.initElements(driver, Login.class);
    }

    public Login login() throws Throwable {
        String username = ReadProperties.main("username");
        log.info("*** NORM  User *** => No Username provided, using username provided from properties =>" + username);
        login(username, ReadProperties.main("password"));

        return PageFactory.initElements(driver, Login.class);
    }

    public Login loginAdmin() throws Throwable {
        String username = ReadProperties.main("admin_username");
        log.info("*** ADMIN USER *** => No Username provided, using username provided from properties =>" + username);
        login(username, ReadProperties.main("admin_password"));

        return PageFactory.initElements(driver, Login.class);
    }

    public Login passwordReset(String newPassword, String confirmPassword) throws Throwable {

        newPassword_field.sendKeys(newPassword);
        confirmPassword_field.sendKeys(confirmPassword);

        log.info("Set New Password to =>" + newPassword);
        log.info("Set Confirm Password to =>" + confirmPassword);

        try {
            wait.deactivateImplicitWait();
            confirm_button.click();
            wait.activateImplicitWait();
        } catch (Exception e) {
            NAV.press_buttonByName("Confirm");
        }
        log.info("Clicked on Continue button");

        return PageFactory.initElements(driver, Login.class);
    }

    public Login passwordReset(String password) throws Throwable {
        wait.activateImplicitWait();
        passwordReset(password, password);
        return PageFactory.initElements(driver, Login.class);
    }

    public void authenticateAlert(String username, String password) {
        Alert alert = driver.switchTo().alert();
        alert.sendKeys(username + Keys.TAB + password);

    }


    public boolean courtOptionsDisplayed() {
        List<WebElement> courtOptions = driver.findElements(By.id("courtToManageForm"));
        return !courtOptions.isEmpty();
    }

    public void selectCourt(String courtCode) {
        driver.findElement(By.id("court-"+courtCode)).click();
    }

    public void clickContinue() {
        continueButton.click();
    }
}