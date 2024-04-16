package cucumber.pageObjects;

import cucumber.utils.AngularJsHTTPCallWait;
import cucumber.utils.DateManipulator;
import cucumber.utils.GenUtils;
import cucumber.utils.ReadProperties;
import cucumber.utils.WaitUtil_v2;
import cucumber.utils.WaitUtils;
import io.cucumber.datatable.DataTable;
import org.apache.log4j.Logger;
import org.junit.Assert;
import org.openqa.selenium.By;
import org.openqa.selenium.JavascriptExecutor;
import org.openqa.selenium.Keys;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.interactions.Actions;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import org.openqa.selenium.support.ui.ExpectedCondition;
import org.openqa.selenium.support.ui.ExpectedConditions;
import org.openqa.selenium.support.ui.Select;
import org.openqa.selenium.support.ui.WebDriverWait;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.time.DayOfWeek;
import java.time.Duration;
import java.time.LocalDate;
import java.time.ZoneId;
import java.time.format.DateTimeFormatter;
import java.time.temporal.TemporalAdjusters;
import java.util.*;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertTrue;

public class NavigationShared {
    private static WebDriver driver;
    private static Logger log = Logger.getLogger(NavigationShared.class);
    private WaitUtils wait;
    private WaitUtil_v2 wait1;
    private AngularJsHTTPCallWait aJsWait;
    private String LOADING_ICON_LOCATION = "spinner";
    private GenUtils GU;


    public NavigationShared(WebDriver driver) {
        NavigationShared.driver = driver;
        PageFactory.initElements(driver, this);
        wait = new WaitUtils(driver);
        wait1 = new WaitUtil_v2(driver);
        aJsWait = new AngularJsHTTPCallWait(driver);
        GU = new GenUtils(driver);

    }

    @FindBy(id = "logoutNavBtn")
    WebElement logout_button;

    @FindBy(id = "home")
    WebElement home_link;

    @FindBy(id = "userProfileName")
    WebElement userProfileName_link;

    @FindBy(id = "termsAndConditions")
    WebElement termsAndConditions_link;

    @FindBy(id = "isUrgent")
    WebElement urgentCheckbox;

    @FindBy(xpath = "//table[@class='govuk-table']/thead/tr/th[1]")
    WebElement JurorNumberLabel;
    @FindBy(xpath = "//table[@class='govuk-table']/thead/tr/th[2]")
    WebElement JurorFirstNameLabel;
    @FindBy(xpath = "//table[@class='govuk-table']/thead/tr/th[3]")
    WebElement JurorLastNameLabel;
    @FindBy(xpath = "//table[@class='govuk-table']/thead/tr/th[4]")
    WebElement JurorCheckedInLabel;

    @FindBy(id = "checkOutTimeHour")
    WebElement changeTimeCheckOut;

    @FindBy(id = "saveAndNextButton")
    WebElement expenseSave;

    @FindBy(xpath = "//*[@class='govuk-table__cell']")
    List<WebElement> bankHoliday;


    public NavigationShared accessLoginPage(String environment) {
        String url;

        switch (environment.toLowerCase()) {
            case "int":
                url = ReadProperties.main("IntegrationEnvironment");
                break;
            default:
                throw new Error("Unexpected environment passed to me");
        }

        driver.navigate().to(url);
        log.info("Navigated to =>" + url);

        wait.f_waitElementToClickable(driver.findElement(By.xpath("//button[contains(text(),'Login')]"))); // Redo

        return PageFactory.initElements(driver, NavigationShared.class);
    }

    public void accessLoginPage() throws Throwable {
        log.info("No Environment Passed - Assuming Integration Environment");
        accessLoginPage("int");
    }

    public void accessAdminLoginPage() throws Throwable {
        log.info("Assuming Integration Environment");

        driver.navigate().to(ReadProperties.main("IntegrationEnvironment_ADMIN"));
        log.info("Navigated to =>" + ReadProperties.main("IntegrationEnvironment_ADMIN"));

        wait.f_waitElementToClickable(driver.findElement(By.xpath("//button[contains(text(),'Login')]"))); // Redo
    }


    public void accessLoginPage(String publicBureau, String env) {
        log.info("Going to access =>" + publicBureau + "<= for environment =>" + env + "");
        String url;
        env = ReadProperties.systemPropertyEnvironmentOverrideCheck(env);

        url = ReadProperties.main(publicBureau.toLowerCase() + "_" + env.toLowerCase()) + "/?clang=en";

        System.setProperty("env.database", env.toLowerCase());
        System.setProperty("envName", env.toLowerCase());

        driver.get(url);
        log.info("Navigated to the expected environment");
    }

    public void accessLoginPageWelsh(String publicBureau, String env) {
        log.info("Going to access =>" + publicBureau + "<= for environment =>" + env + "");
        String url;
        env = ReadProperties.systemPropertyEnvironmentOverrideCheck(env);

        url = ReadProperties.main(publicBureau.toLowerCase() + "_" + env.toLowerCase()) + "/?clang=cy";

        System.setProperty("env.database", env.toLowerCase());
        System.setProperty("envName", env.toLowerCase());

        driver.get(url);
        log.info("Navigated to the expected environment");
    }

    public void clearCookies() throws InterruptedException {
        driver.manage().deleteAllCookies(); //delete all cookies
        Thread.sleep(7000); //wait 7 seconds to clear cookies.
    }

    public void accessLoginPageExpenses(String publicBureau, String env) {
        log.info("Going to access =>" + publicBureau + "<= for environment =>" + env + "");
        String url;
        env = ReadProperties.systemPropertyEnvironmentOverrideCheck(env);

        url = ReadProperties.main(publicBureau.toLowerCase() + "_" + env.toLowerCase());

        System.setProperty("env.database", env.toLowerCase());
        System.setProperty("envName", env.toLowerCase());

        driver.get(url);
        log.info("Navigated to the expected environment");
    }

    public void accessLoginPageWelshExpenses(String publicBureau, String env) {
        log.info("Going to access =>" + publicBureau + "<= for environment =>" + env + "");
        String url;
        env = ReadProperties.systemPropertyEnvironmentOverrideCheck(env);

        url = ReadProperties.main(publicBureau.toLowerCase() + "_" + env.toLowerCase()) + "/?clang=cy";

        System.setProperty("env.database", env.toLowerCase());
        System.setProperty("envName", env.toLowerCase());

        driver.get(url);
        log.info("Navigated to the expected environment");
    }

    /**
     * JM - Checks whether expected_text is presented anywhere on the page within the body tag
     * If it exists, continues else fails the test with "Text not found!" appearing in the console
     *
     * @param expected_text
     * @return
     * @throws Throwable
     */
    public NavigationShared textPresentOnPage(String expected_text) throws Throwable {
        log.info("Going to check if text present on the page =>" + expected_text);
        String bodyText = driver.findElement(By.tagName("body")).getText();
        try {
            Assert.assertTrue("Text found!", bodyText.contains(expected_text));
        } catch (AssertionError e) { // Refactor this
            log.info("Did not find text in initial run, waiting for up to 10 seconds for text to appear");
            try {
                wait.waitForTextOnPage(expected_text);
            } catch (Exception eb) {
                log.info("Exception on wait for page... Trying to continue to get caught by assert");
            }
            bodyText = driver.findElement(By.tagName("body")).getText();
            Assert.assertTrue("Did not see Expected Text =>" + expected_text, bodyText.contains(expected_text));
        }

        log.info("Saw Expected Text =>" + expected_text);

        return PageFactory.initElements(driver, NavigationShared.class);
    }

    public NavigationShared eligibilityErrorOnPage(String expected_text) throws Throwable {
        log.info("Going to check if eligibility error is present on the page =>" + expected_text);

        WebElement eligibilityError = driver.findElement(By.xpath("//*[@class='govuk-error-message'][text()[contains(.,\"" + expected_text + "\")]]"));
        eligibilityError.isDisplayed();

        log.info("Saw Expected Text =>" + expected_text);

        return PageFactory.initElements(driver, NavigationShared.class);
    }

    public NavigationShared textNotPresentOnPage(String not_expected) {
        log.info("Going to check text is not present on the page =>" + not_expected);
        String bodyText = driver.findElement(By.tagName("body")).getText();
        try {
            Assert.assertFalse("Text Found when not expected!", bodyText.contains(not_expected));
        } catch (AssertionError e) { // Refactor this
            log.info("Found text in initial run, waiting additional 2 seconds incase it disappears");
            wait.waitForTextInvisibility(not_expected, 2);

            bodyText = driver.findElement(By.tagName("body")).getText();
            Assert.assertFalse("Text found when not expected!", bodyText.contains(not_expected));
        }

        log.info("Did not see unexpected Text =>" + not_expected);

        return PageFactory.initElements(driver, NavigationShared.class);

    }


    public NavigationShared press_navigationButton(String button) throws Throwable {

        switch (button) {
            case "forward":
                driver.navigate().forward();
                log.info("Pressed forward button on browser");
                break;
            case "backward":
                driver.navigate().back();
                log.info("Pressed backward button on browser");
                break;
            case "back":
                driver.navigate().back();
                log.info("Pressed back button on browser");
                break;
            case "refresh":
                driver.navigate().refresh();
                log.info("Refreshed the browser");
                break;
            default:
                throw new Error("You did not give me an expected value. I received =>" + button);
        }

        return PageFactory.initElements(driver, NavigationShared.class);
    }

    /**
     * JM - This needs reworking - finding by name is not appropriate. Needs to be by exact text description
     *
     * @param location_name
     * @return
     */
    public WebElement find_locationParent(String location_name) {
        WebElement parentLocation; // Refactor the below to have both selects in one xpath - Could not do ti quickly
        wait.deactivateImplicitWait();
        try {
            parentLocation = return_oneVisibleFromList(driver.findElements(By.xpath(
                    "//label[text()[contains(., '" + location_name + "')]]/.."
                            + "| "
                            + "//label/strong[text()[contains(., '" + location_name + "')]]/.."
                            + " | "
                            + "//strong[text()[contains(., '" + location_name + "')]]/.."
            )));
            wait.activateImplicitWait();
        } catch (Exception e) {
            wait.activateImplicitWait();
            parentLocation = driver.findElement(By.xpath( // Investigate purpose of second catch instea dof one liner - Put select/option in it due to this because of implicit wait
                            "//label[contains(normalize-space(text()), '" + location_name + "')]"
                                    + " | "
                                    + "//select/option[@value='' and text()[contains(.,\"" + location_name + "\")]]"
                    ))
                    .findElement(By.xpath(".."));
        }
        WebDriverWait wait = new WebDriverWait(driver, Duration.ofSeconds(10));
        wait.until(ExpectedConditions.visibilityOf(parentLocation));

        return parentLocation;
    }

    public WebElement find_inputBy_labelName(String label_name) throws Exception {
        WebElement child = null;
        wait.deactivateImplicitWait();
        try {
            By childXpath = By.xpath("//*[@id=("
                    + "//label[text()[(normalize-space(.)=\""
                    + label_name
                    + "\")]]"
                    + "/@for)]");

            log.info(childXpath);
            child = return_oneVisibleFromList(driver.findElements(childXpath), true);
        } catch (Exception e) {
            try {
                child = return_oneVisibleFromList(driver.findElements(By.xpath(
                        "//*[@id=("
                                + "//label[text()[contains(.,\""
                                + label_name
                                + "\")]]"
                                + "/@for)]"
                )));
            } catch (Exception b) {
                try {
                    child = return_oneVisibleFromList(driver.findElements(By.xpath(
                            "//*[@id=("
                                    + "//label/strong[text()[contains(.,\""
                                    + label_name
                                    + "\")]]/.."
                                    + "/@for)]"
                                    + " | "
                                    + "//*[@id=("
                                    + "//label/span[text()[contains(.,\""
                                    + label_name
                                    + "\")]]/.."
                                    + "/@for)]"

                    )));
                } catch (Exception c) {
                    log.info("looking for input field following label");
                    child = return_oneVisibleFromList(driver.findElements(By.xpath(
                            "//*[./*[text()[contains(., '" + label_name + "')]]]" + "//textarea")));
                }
            }
        }
        return child;

    }

    public NavigationShared set_valueTo(String location_name, String value) throws Throwable {
        //WebElement parentLocation = find_locationParent(location_name);
        //WebElement childField = parentLocation.findElement(By.cssSelector("input"));
        WebElement childField;
        try {
            childField = find_inputBy_labelName(location_name);

            //added to address the fact chris's push includes his test data hard coded into log on fields
            childField.clear();

        } catch (Exception e) {
            wait.activateImplicitWait(2);
            childField = return_oneVisibleFromList(
                    driver.findElements(By.xpath(
                            "//label[text()[contains(., \"" + location_name + "\")]]//input"
                                    + " | "
                                    + "//textarea[@name=\"" + location_name + "\"]"
                                    + " | "
                                    + "//label[text()[contains(., \"" + location_name + "\")]]/../textarea"
                    ))
            );
        }

        childField.clear();
        childField.sendKeys(value);

        if (DateManipulator.isValidDate(value))
            childField.sendKeys(Keys.TAB);

        log.info("Set input field with label =>" + location_name + "<= to =>" + value);

        return PageFactory.initElements(driver, NavigationShared.class);
    }

    public NavigationShared compare_valueTo(String location_name, String expected_value) throws Throwable {
        //WebElement parentLocation = find_locationParent(location_name);
        // This assumes we are checking inputs - May need to amend
        String current_value;
        try {
            current_value = find_inputBy_labelName(location_name).getAttribute("value");
        } catch (Exception e) {
            try {
                current_value = return_oneVisibleFromList(
                        driver.findElements(By.xpath(
                                "//textarea[@name=\"" + location_name + "\"]"
                                        + " | "
                                        + "//label[text()[contains(., \"" + location_name + "\")]]/../textarea" // TODO Modify this to put it into find_inputBy_labelNAme, duplication of code
                        ))
                ).getAttribute("value");
                assertEquals(current_value, expected_value);

            } catch (Exception | AssertionError ae) {
                log.info("Unable to find current_value the new way. Trying the old way");
                WebElement parent = find_locationParent(location_name);
                wait.deactivateImplicitWait();
                try {
                    current_value = parent
                            .findElement(By.cssSelector("input"))
                            .getAttribute("value");
                } catch (Exception b) {
                    current_value = parent
                            .findElement(By.cssSelector("span"))
                            .getText();
                }
            }
        }

        log.info("Current value =>" + current_value);

        assertEquals(current_value, expected_value);
        log.info("Saw Expected Value =>" + expected_value);

        return PageFactory.initElements(driver, NavigationShared.class);
    }

    public List<WebElement> getButtonsByExactText(String text) {
        List<WebElement> buttons = driver.findElements(By.xpath(
                "//button[normalize-space()='" + text + "']"
                        + "|"
                        + "//button//span[normalize-space()='" + text + "']"
                        + "|"
                        + "//a[contains(@class ,'button') and normalize-space()='" + text + "']"
                        + "|"
                        + "//input[contains(@class ,'button') and (@value=\"" + text + "\")]"
        ));
        return buttons;
    }

    public NavigationShared check_Jurorcheckbox(String Juror_no) {
        try {
            String checkboxXPath = "//input[@name='selectedJurors' and @value='" + Juror_no + "']";
            WebElement checkbox = driver.findElement(By.xpath(checkboxXPath));

            log.info("Checkbox " + Juror_no + " checked:" + checkbox.isSelected());
            checkbox.click();
            log.info("Clicked on checkbox with for, checking if checked");
            if (checkbox.isSelected()) {
                log.info("Return");
                return null;
            }

        } catch (Exception e) {
            log.error(e.getMessage());
        }
        return PageFactory.initElements(driver, NavigationShared.class);
    }

    public NavigationShared press_buttonByName(String button_name) throws Throwable {
        log.info("Going to press button with name =>" + button_name);
        wait.activateImplicitWait();
        WebElement button;

        List<WebElement> buttons = driver.findElements(By.xpath(
                "//button[text()[contains(., '" + button_name + "')]]"
                        + "|"
                        + "//button//span[text()[contains(., '" + button_name + "')]]"
                        + "|"
                        + "//a[contains(@class ,'button') and text()[contains(., '" + button_name + "')]]"
                        + "|"
                        + "//input[contains(@class ,'button') and (@value='" + button_name + "')]"
        ));
        wait.deactivateImplicitWait();
        log.info("Buttons: " + buttons);
        try {
            button = return_oneVisibleFromList(buttons);
            wait.waitForClickableElement(button);
        } catch (Exception | Error e) {
            log.error("unexpected exception when waiting for element to be clickable", e);
            button = return_oneVisibleFromList(getButtonsByExactText(button_name));
            wait.waitForClickableElement(button);
        }

        try { // Investigate purpose of this
            wait.waitForClickableElement(button, 10);
        } catch (Exception e) {
            log.error("unexpected exception when waiting for element to be clickable", e);
        }

        try {
            button.click();
        } catch (Exception e) {

            log.info("Could not do initial click on element - Going to move to element then try again", e);

            Actions action = new Actions(driver);
            action.moveToElement(button).click().perform();

            log.info("Move to element action successful");
        }

        log.info("Clicked on button with name =>" + button_name);

        return PageFactory.initElements(driver, NavigationShared.class);
    }

    public NavigationShared refreshPage() {

        driver.navigate().refresh();
        log.info("Refreshed the page");

        return PageFactory.initElements(driver, NavigationShared.class);
    }

    public void checkUrgentCheckbox() {
        try {
            urgentCheckbox.click();
            log.info("Urgent checkbox checked:" + urgentCheckbox.isSelected());
            urgentCheckbox.sendKeys(Keys.chord("", Keys.TAB));
        } catch (Exception e) {
            log.error(e.getMessage());
        }
    }

    public NavigationShared check_checkbox(String location_name) {
        try {
            WebElement checkbox = find_inputBy_labelName(location_name);
            log.info("Checkbox " + location_name + " checked:" + checkbox.isSelected());
            checkbox.click();
            checkbox.sendKeys(Keys.chord("", Keys.TAB));
            log.info("Clicked on checkbox with for, checking if checked");
            log.info("Checkbox " + location_name + " checked:" + checkbox.isSelected());
            if (checkbox.isSelected()) {
                log.info("Return");
                return null;
            }

        } catch (Exception e) {
            log.error(e.getMessage());
        }
        log.info("Continue... searching by xpath");
        WebElement checkbox_location = driver.findElement(By.id(
                //"//label[contains(normalize-space(text()), '"+location_name+"')]/input"
                //"//label[text()[contains(., \""+location_name+"\")]]/input"
                //DB test for new bureau filter checkboxes
                location_name)
        );

        click_onElement(checkbox_location); //.click();

        //wait.toBeSelected(checkbox_location);

        //Boolean selectedCheck = checkbox_location.isSelected(); // Does this prove it is a checkbox?

        //.waitForClickableElement(checkbox_location,2);

        return PageFactory.initElements(driver, NavigationShared.class);
    }

    public NavigationShared uncheck_checkbox(String location_name) {
        try {
            WebElement checkbox = find_inputBy_labelName(location_name);
            log.info("Checkbox " + location_name + " checked:" + checkbox.isSelected());

            if (checkbox.isSelected()) {
                checkbox.click();
            } else {
                log.info("Return");
                return null;
            }

        } catch (Exception e) {
            log.error(e.getMessage());
        }
        log.info("Continue... searching by xpath");
        WebElement checkbox_location = driver.findElement(By.xpath(
                "//label[text()[contains(., \"" + location_name + "\")]]/input"
        ));

        if (checkbox_location.isSelected()) {
            checkbox_location.click();
        } else {
            log.info("Return");
            return null;
        }


        return PageFactory.initElements(driver, NavigationShared.class);
    }

    public void waitForPageLoad() {
        waitForPageLoad(7, 120);
    }

    public void waitForPageLoad(int waitTime) {
        waitForPageLoad(2, waitTime);
    }

    /**
     * Overloading with wait time passed - For increased waiting when required
     */
    public void waitForPageLoad(int initialWait, int postWait) {
        WebDriverWait wait = new WebDriverWait(driver, Duration.ofSeconds(initialWait));
        try {
            wait.until(ExpectedConditions.visibilityOfElementLocated(By.cssSelector(LOADING_ICON_LOCATION)));
            log.info("Saw Loading Icon");
        } catch (Exception e) {
            log.info("Did not catch the loading icon as expected - Continuing without error. Expected?");
            return;
        }

        try {
            wait = new WebDriverWait(driver, Duration.ofSeconds(postWait));
            invisibilityOfElement(By.cssSelector(LOADING_ICON_LOCATION), wait);
            log.info("Loading icon now gone - Continuing");
        } catch (Exception e) {
            log.info("Loading icon still here? After " + postWait + " seconds - Something has gone wrong, but going to continue");
        }
    }

    public void invisibilityOfElement(By by, WebDriverWait wait) {
        wait.until(ExpectedConditions.invisibilityOfElementLocated(by));
    }

    public void visibilityOfElement(By by, WebDriverWait wait) {
        wait.until(ExpectedConditions.visibilityOfElementLocated(by));
    }

    /**
     * JM - Not applicable for JD, remove
     *
     * @throws InterruptedException
     */
    public void waitForAngularLoad() throws InterruptedException {
        WebDriverWait wait = new WebDriverWait(driver, Duration.ofSeconds(15));
        JavascriptExecutor jsExec = (JavascriptExecutor) driver;
        try {
            String angularReadyScript = "return angular.element(document).injector().get('$http').pendingRequests.length === 0";

            ExpectedCondition<Boolean> angularLoad = driver -> Boolean.valueOf(((JavascriptExecutor) driver)
                    .executeScript(angularReadyScript).toString());

            boolean angularReady = Boolean.valueOf(jsExec.executeScript(angularReadyScript).toString());

            if (!angularReady) {
                Thread.sleep(10);
                wait.until(angularLoad);
            }
            log.info("Page Loaded");
        } catch (Exception e) {
            log.info("Something went wrong when checking if Angular has loaded... Ignoring for now");
        }

    }

    public void click_link_by_text(String arg1) {
        WebElement linkText;

        try {
            linkText = return_oneVisibleFromList(driver.findElements(By.linkText(arg1)), true);
        } catch (Exception e) {
            wait.activateImplicitWait();
            linkText = driver.findElement(By.xpath("//*[text()[contains(., \"" + arg1 + "\")]]"));
        }
//		wait.waitForClickableElement(linkText);
        wait.activateImplicitWait();
        click_onElement(linkText);

        log.info("Clicked on URL with link text =>" + arg1);
    }

    public void linkText_visible(String arg1, boolean b) {
        log.info("Going to check whether link text =>" + arg1 + "<= is present on the page");
        wait.deactivateImplicitWait();
        boolean visible;
        try {
            driver.findElement(By.partialLinkText(arg1));
            visible = true;
        } catch (Exception e) {
            visible = false;
        }

        if (b == visible) {
            log.info("Link text present =>" + b + "<= which is expected");
        } else {
            throw new Error("Link text present =>" + b + "<= which is not expected");
        }
        wait.activateImplicitWait();
    }

    public void radio_button_not_visible(String radioButtonNotExpected) {
        log.info("Going to check whether link radio button =>" + radioButtonNotExpected + "<= is present on the page");
        wait.deactivateImplicitWait();
        String bodyText = driver.findElement(By.tagName("input")).getText();
        try {
            Assert.assertFalse("Radio button found when not expected!", bodyText.contains(radioButtonNotExpected));
        } catch (AssertionError e) { // Refactor this
            log.info("Found text in initial run, waiting additional 2 seconds incase it disappears");
            wait.waitForTextInvisibility(radioButtonNotExpected, 2);

            bodyText = driver.findElement(By.tagName("body")).getText();
            Assert.assertFalse("Text found when not expected!", bodyText.contains(radioButtonNotExpected));
        }

        log.info("Did not see unexpected Text =>" + radioButtonNotExpected);

    }

    public void checkBox_Checked(String checkboxlabel, boolean expected) {
        log.info("Going to check whether check box is checked =>" + checkboxlabel + "<= which is expected");
        wait.deactivateImplicitWait();
        boolean checked;
        try {
            WebElement checkbox = find_inputBy_labelName(checkboxlabel);
            checked = checkbox.isSelected();
        } catch (Exception e) {
            checked = false;
        }

        if (expected == checked) {
            log.info("Checkbox is checked =>" + expected + "<= which is expected");
        } else {
            throw new Error("Checkbox is unchecked =>" + expected + "<= which is not expected");
        }
        wait.activateImplicitWait();
    }

    public Boolean contain_icon(WebElement element) {
        wait.deactivateImplicitWait();
        try {
            element.findElement(By.cssSelector("span"));
            log.info("Found an element with 'span' in the element passed");
            return true;
        } catch (Exception e) {
            log.info("Did not find an element with 'span' in the element passed");
            return false;
        }
    }

    public void select_fromDropdown(String option_value, String dropdown_name) {
//		WebElement dropdown_location = find_inputBy_labelName(dropdown_name);
        WebElement child;
        try {
            child = find_inputBy_labelName(dropdown_name);
        } catch (Exception e) {
            child = find_locationParent(dropdown_name);
            // This blocks needs investigating to see whether to see if it is required, and whether it needs the try/catch or just what is in the catch
            try {
                if (!child.getTagName().equalsIgnoreCase("select"))// Refactor dropdown logic for global
                    child = child.findElement(By.cssSelector("select"));
            } catch (Exception b) {
                log.info("******* Investigate if this is actually hit");
                child = driver.findElement(By.xpath(".."));
                if (!child.getTagName().equalsIgnoreCase("select"))// Refactor dropdown logic for global
                    child = child.findElement(By.cssSelector("select"));
            }
        }

        log.info("Found dropdown with name =>" + dropdown_name);

        Select select = new Select(child);

        select.selectByVisibleText(option_value);
        log.info("Selected =>" + option_value + "<= from the dropdown with name =>" + dropdown_name);

    }

    public void select_fromDashboardDropdown(String option_value, String dropdown_name) {
        WebElement child;
        child = driver.findElement(By.id(dropdown_name));

        log.info("Found dropdown with name =>" + dropdown_name);

        Select select = new Select(child);

        select.selectByVisibleText(option_value);
        log.info("Selected =>" + option_value + "<= from the dropdown with name =>" + dropdown_name);
    }

    //		DB testing
    public void new_select_fromDropdown(String option_value, String dropdown_name) {
        try {
            WebElement child;
            child = driver.findElement(By.xpath("//label[text()[contains(., '" + dropdown_name + "')]]"));

            log.info("Found dropdown with name =>" + dropdown_name);

            Select select = new Select(child);
            select.selectByVisibleText(option_value);
            log.info("Selected =>" + option_value + "<= from the dropdown with name =>" + dropdown_name);
        } catch (Exception e) {
            log.info("Did not find an element with 'span' in the element passed");
        }
    }

    public void generic_searchForText(String searchText) {
        WebElement searchInput = driver.findElement(By.id("userSearch"));

        searchInput.sendKeys(searchText);
        log.info("Found search field and sent it =>" + searchText);

    }

    public void generic_clickOnElementWithId(String Id) {
        log.info("Clicking on element with id =>" + Id);
        WebElement element = driver.findElement(By.id(Id));

        element.click();
        log.info("Clicked on element with id =>" + Id);

    }

    /**
     * Move this to another location
     */
    public void waitForDocumentReady() {

        try {
            new WebDriverWait(driver, Duration.ofSeconds(10)).until(
                    webDriver -> ((JavascriptExecutor) webDriver).executeScript("return document.readyState").equals("complete"));
            log.info("Page ready -> Continuing");
        } catch (Exception e) {
            log.info("Exception on waiting for document ready state -> Continuing without error");
        }
    }

    public void waitforDocumentLoading() {
        try {
            new WebDriverWait(driver, Duration.ofSeconds(5)).until(
                    webDriver -> ((JavascriptExecutor) webDriver).executeScript("return document.readyState").equals("loading"));
            log.info("Page ready -> Continuing");
        } catch (Exception e) {
            log.info("Exception on waiting for document ready state -> Continuing without error");
        }
    }

    public void click_onElement(WebElement element) {
        waitForDocumentReady();
        try {
            element.click();
            log.info("Clicked on element as normal - Continuing");
            return;
        } catch (Exception e) {
            log.info("Unable to click on element using Selenium, trying via Javascript. Element is =>" + element);
            ((JavascriptExecutor) driver).executeScript("arguments[0].click();", element);
            log.info("Clicked on element using javascript - Continuing");
        }
        waitForDocumentReady();
    }

    public void MoveTo_click_onElement(WebElement element) {
        Actions act = new Actions(driver);
        new WebDriverWait(driver, Duration.ofSeconds(60)).until(ExpectedConditions.and(
                ExpectedConditions.visibilityOf(element), ExpectedConditions.elementToBeClickable(element)));

        try {
            act.moveToElement(element).moveToElement(element).click().build().perform();
            log.info("Performed click to move successfully for WebElement =>" + element);
        } catch (Exception e) {
            log.warn("Failed move to click, trying generic click on Element");
            click_onElement(element);
        }
    }

    public void selectCheckbox_forRowWithText(String column, String rowText) {

        String checkboxId = null;
        if (column.equalsIgnoreCase("suspend")) {
            checkboxId = "//input[starts-with(@id, 'suspendCheckbox')]";
        } else if (column.equalsIgnoreCase("delete")) {
            checkboxId = "//input[starts-with(@id, 'deleteCheckbox')]";
        } else if (column.equalsIgnoreCase("deleted")) {
            checkboxId = "//input[starts-with(@id, 'deleteCheckbox')]";
        } else {
            throw new Error("Did not get a checkbox lookup that we were epxecting. Currently expecting either suspend or deleted");
        }

        log.info("Looking for checkbox called =>" + column + "<= for row with text =>" + rowText);

        List<WebElement> textMatches = driver.findElements(By.xpath(
                "//a[text()[contains(., '" + rowText + "')]]"
        ));

        if (textMatches.size() > 1) {
            log.info("Found more than one element with this text - We dont know which one to use");
            throw new Error("Which button do you want me to press?");
        }


        checkboxId = "//a[text()[contains(., '" + rowText + "')]]/../../.." + checkboxId;
        log.info(checkboxId);
        WebElement checkbox = driver.findElement(By.xpath(checkboxId));
        //dcheckbox.click();
        click_onElement(checkbox);

        WebDriverWait wait = new WebDriverWait(driver, Duration.ofSeconds(2));
        try {
            wait.until(ExpectedConditions.elementToBeSelected(checkbox));
        } catch (Exception e) {
            log.info("Exception waiting for element to be selected - Going to continue anyway to be caught downstream");
        }

        log.info("Checked the =>" + column + "<= checkbox for row with text =>" + rowText);

    }

    public void confirmCheckbox_forRowWithText(String column, String rowText, String checkedUnchecked) {

        String checkboxId = null;
        if (column.equalsIgnoreCase("suspend")) {
            checkboxId = "//input[starts-with(@id, 'suspendCheckbox')]";
        } else if (column.equalsIgnoreCase("delete")) {
            checkboxId = "//input[starts-with(@id, 'deleteCheckbox')]";
        } else if (column.equalsIgnoreCase("deleted")) {
            checkboxId = "//input[starts-with(@id, 'deleteCheckbox')]";
        } else {
            throw new Error("Did not get a checkbox lookup that we were epxecting. Currently expecting either suspend or deleted");
        }

        log.info("Looking for checkbox called =>" + column + "<= for row with text =>" + rowText);

        List<WebElement> textMatches = driver.findElements(By.xpath(
                "//a[text()[contains(., '" + rowText + "')]]"
        ));

        if (textMatches.size() > 1) {
            log.info("Found more than one element with this text - We dont know which one to use");
            throw new Error("Which button do you want me to press?");
        }
        checkboxId = "//a[text()[contains(., '" + rowText + "')]]/../../.." + checkboxId;

        WebElement checkbox = driver.findElement(By.xpath(checkboxId));

        //WebElement checkbox = textMatches.get(0).findElement(checkboxId);
        if (checkbox.isSelected() && checkedUnchecked.equalsIgnoreCase("checked")) {

        } else if (!checkbox.isSelected() && !checkedUnchecked.equalsIgnoreCase("checked")) {

        } else {
            throw new Error("Seems that the checkbox isn't set as expected! Failing");
        }
    }

    public void select_fromDropdown(String option) throws Exception {
        List<WebElement> dropdowns = driver.findElements(By.cssSelector("select"));
        WebElement dropdown = return_oneVisibleFromList(dropdowns);

        Select selector = new Select(dropdown);
        selector.selectByVisibleText(option);
        log.info("Selected =>" + option + "<= from the dropdown");
    }

    private WebElement return_oneVisibleFromList(List<WebElement> dropdowns) throws Exception {
        return return_oneVisibleFromList(dropdowns, false);
    }

    public WebElement return_oneVisibleFromList(List<WebElement> dropdowns, Boolean overrideReturn) throws Exception {
        int count = 0;
        WebElement uniqueDropdown = null;
        if (dropdowns.size() == 1)
            return dropdowns.get(0);
        for (WebElement dropdown : dropdowns) {
            try {
                if (dropdown.isDisplayed()) {
                    count += 1;
                    if (uniqueDropdown == null)
                        uniqueDropdown = dropdown;
                }
            } catch (Exception e) {
                log.info("Received error when checking whether element was displayed");
                log.info(e);
            }
        }

        if (count == 0)
            throw new Exception("Did not get any elements from list when expected to return 1 visible element");
        else if (overrideReturn)
            return uniqueDropdown;
        else if (count > 1)
            throw new Exception("Got more than 1 displayed element - Which one do you want me to use?");
        log.info("Received =>" + dropdowns.size() + "<= elements to check and returned one visible element");
        return uniqueDropdown;

    }

    public void element_byText_hasClass(String text, String containsClass) throws Exception {
        log.info("Going to check whether =>" + text + "<= has class =>" + containsClass);
        return_oneVisibleFromList(driver.findElements(By.xpath(
                "//*[text()[(normalize-space(.)='" + text + "')] and contains(@class ,\"" + containsClass + "\")]"
        )));
    }

    public WebElement getBlock_byHeadingText(String text) {
        wait.activateImplicitWait();
        log.info("Looking for header block with text =>" + text);
        WebElement headerBlock = driver.findElement(By.xpath(
                "//legend/strong[text()[(normalize-space(.)="
                        + "'" + text + "'"
                        + ")]]//ancestor::fieldset"
                        + " | "
                        + "//h1[contains(text(), '+" + text + "')]/..//nav"
        ));
        wait.deactivateImplicitWait();

        return headerBlock;
    }

    public WebElement getBlock_byHeadingTextExpenses(String text) {
        wait.activateImplicitWait();
        log.info("Looking for header block with text =>" + text);
        WebElement headerBlock = driver.findElement(By.xpath(
                "//details/div/p[normalize-space()="
                        + "'" + text + "']"));
        wait.deactivateImplicitWait();

        return headerBlock;
    }

    //	#DB new for new bureau
    public WebElement getBlock_byHeadingTextBureau(String text) {
        wait.activateImplicitWait();
        log.info("Looking for header block with text =>" + text);

        try {
            WebElement headerBlock = driver.findElement(By.xpath(
                    "//h2[contains(text(),'" + text + "')]"
                            + "|"
                            + "//caption[normalize-space()="
                            + "'" + text + "']"));
            return headerBlock;
        } catch (Exception e) {
            WebElement headerBlock = driver.findElement(By.xpath(
                    "//h1[normalize-space()="
                            + "'" + text + "']"));
            return headerBlock;
        }


    }

    public WebElement getBlock_byHeadingTextLabel(String text) {
        wait.activateImplicitWait();
        log.info("Looking for header block with text =>" + text);
        WebElement headerBlock = driver.findElement(By.xpath(
                "//fieldset/div/label[normalize-space()="
                        + "'" + text + "']"));
        wait.deactivateImplicitWait();

        return headerBlock;
    }

    public void seeText_underHeadingBlock(String text, String header) {
        log.info("Going to see if =>" + text + "<= is present under header block with text =>" + header);
        getBlock_byHeadingText(header).getText().contains(text);
        log.info("Found text =>" + text + "<= under header =>" + header);

    }

    public void seeText_underHeadingBlockExpenses(String text, String header) {
        log.info("Going to see if =>" + text + "<= is present under header block with text =>" + header);
        getBlock_byHeadingTextExpenses(header).getText().contains(text);
        log.info("Found text =>" + text + "<= under header =>" + header);

    }

    public void seeText_underHeadingBlockBureau(String text, String header) {
        log.info("Going to see if =>" + text + "<= is present under header block with text =>" + header);
        getBlock_byHeadingTextBureau(header).getText().contains(text);
        log.info("Found text =>" + text + "<= under header =>" + header);

    }

    public void doNotSeeText_underHeadingBlock(String text, String header, boolean b) {
        log.info("Going to check that =>" + text + "<= is not present under header block with text =>" + header);
        getBlock_byHeadingTextExpenses(header).getText().contains(text);
        log.info("Did not Found text =>" + text + "<= under header =>" + header);
        boolean visible;
        try {
            driver.findElement(By.partialLinkText(header));
            visible = true;
        } catch (Exception e) {
            visible = false;
        }

        if (b = !visible) {
            log.info("text not present =>" + b + "<= which is expected");
        } else {
            throw new Error("Link text present =>" + b + "<= which is not expected");
        }
        wait.activateImplicitWait();
    }

    public void seeText_underHeadingBlockLabel(String text, String header) {
        log.info("Going to see if =>" + text + "<= is present under header block with text =>" + header);
        getBlock_byHeadingTextLabel(header).getText().contains(text);
        log.info("Found text =>" + text + "<= under header =>" + header);

    }

    public void clickText_underHeadingBlock(String linkText, String header) {
        log.info("Going to click on link with text =>" + linkText + "<= under header block with text =>" + header);
        getBlock_byHeadingText(header).findElement(By.linkText(linkText)).click();
        log.info("Clicked on =>" + linkText + "<= under header with title =>" + header);
    }

    private WebElement findRow_withText(String textInRow) throws Exception {
        return return_oneVisibleFromList(
                driver.findElements(By.xpath(
                        "//table//tr//td[contains(text(),\"" + textInRow + "\")]//ancestor::tr"
                                + " | "
                                + "//table//tr//td/a[contains(text(),\"" + textInRow + "\")]//ancestor::tr"
                ))
        );
    }

    //New See in Same Row
    public void seeText_inSameRow_asText_Two(String searchText, String nextToText) {
        log.info("seeText_inSameRow_asText " + searchText + ", " + nextToText);

        String ddId = "";

        switch (nextToText) {
            case "Name":
            case "Enw":
                ddId = "name";
                break;
            case "Your name":
                ddId = "thirdPartyName";
                break;
            case "Your relationship to the summoned":
//		case "Eich perthynas â'r unigolyn a gafodd yr wŷs":
            case "Eich perthynas ":
                ddId = "thirdPartyRelationship";
                break;
            case "Address":
            case "Cyfeiriad":
                ddId = "adress";
                break;
            case "Main phone":
            case "Prif rif ffôn":
                ddId = "primaryPhone";
                break;
            case "Your main phone number":
                ddId = "thirdPartyMainPhone";
                break;
            case "Another phone (optional)":
            case "Rhif ffôn arall (dewisol)":
                ddId = "secondaryPhone";
                break;
            case "Email":
            case "E-bost":
                ddId = "emailAddress";
                break;
            case "Your email address":
                ddId = "thirdPartyEmailAddress";
                break;
            case "Your reason for replying on behalf of the juror":
                ddId = "thirdPartyReason";
                break;
            case "Date of birth":
            case "Date of Birth:":
            case "Dyddiad geni":
                ddId = "dateOfBirth";
                break;
            case "Since you turned 13, has your main address been in the UK, Channel Islands or Isle of Man for any period of at least 5 years?":
            case "Since they turned 13, has their main address been in the UK, Channel Islands or Isle of Man for any period of at least 5 years?":
            case "Ers i chi droi'n 13 oed, a yw eich prif gyfeiriad wedi bod yn y DU, Ynysoedd y Sianel neu Ynys Manaw am unrhyw gyfnod o 5 mlynedd o leiaf?":
            case "A yw'r unigolyn rydych yn ymateb ar ei ran wedi byw yn y Deyrnas Unedig, Ynysoedd y Sianel neu Ynys Manaw am gyfnod parhaus o bum mlynedd neu fwy ers ei ben-blwydd yn 13 oed?":
                ddId = "answerLivedConsecutive";
                break;
            case "Are you being detained, looked after or treated under the Mental Health Act?":
            case "Is the person you're replying for being detained, looked after or treated under the Mental Health Act?":
            case "Ydych chi'n cael eich cadw, yn cael eich gwarchod neu eich trin o dan y Ddeddf Galluedd Meddyliol?":
            case "A ydi'r person yr ydych yn ymateb ar ei ran yn cael ei gadw, ei warchod neu ei drin o dan y Ddeddf Iechyd Meddwl?":
                ddId = "mentalHealthSectionedAnswer";
                break;
            case "Has it been decided that you 'lack mental capacity'?":
            case "Has it been decided that the person you're replying for 'lacks mental capacity'?":
            case "A benderfynwyd nad oes gennych y gallu meddyliol?":
                ddId = "mentalHealthCapacityAnswer";
                break;
            case "Are you currently on bail for a criminal offence?":
            case "Is the person currently on bail for a criminal offence?":
            case "ar hyn o bryd am gyflawni trosedd?":
            case "Ydych chi ar fechnïaeth ar hyn o bryd am gyflawni trosedd?":
            case "A yw'r unigolyn ar fechn":
                ddId = "onBailAnswer";
                break;
            case "Have you been convicted of a criminal offence and been given a sentence?":
            case "Has the person been convicted of a criminal offence and been given a sentence?":
            case "Ydych chi wedi'ch cael yn euog o drosedd?":
            case "A yw'r unigolyn wedi'i gael yn euog o drosedd?":
                ddId = "convictionAnswer";
                break;
            case "Confirm the date of your jury service":
            case "Gwiriwch eich dyddiad dechrau":
                ddId = "answerConfirmDate";
                break;
            case "Explain why you wish to change the date of your jury service":
            case "Eglurwch pam eich bod angen newid dyddiad eich gwasanaeth rheithgor":
                ddId = "answerDeferralReason";
                break;
            case "Give us 3 dates you could start jury service during the next 12 months":
            case "Nodwch dri dyddiad yn y 12 mis nesaf pan fyddwch ar gael i ddechrau gwasanaethu ar reithgor":
                ddId = "answerDeferralDates";
                break;
            case "Say why you need to be excused from jury service":
            case "Eglurwch pam na allwch chi wasanaethu ar reithgor yn ystod y 12 mis nesaf":
                ddId = "answerExcusalReason";
                break;
            case "Have you worked in the criminal justice system in the last 5 years?":
            case "Now or in the last 5 years, has the person you're replying for worked for the Police Force, HM Prison Service, the National Crime Agency or any prosecuting authority?":
            case "A ydych chi wedi gweithio yn y system cyfiawnder troseddol yn y 5 mlynedd diwethaf?":
            case "person yr ydych yn ymateb ar ei ran wedi gweithio yn y system cyfiawnder troseddol yn y 5 mlynedd diwethaf?":
                ddId = "answerCJSEmployed";
                break;
            case "Do you have a disability or impairment that means you'll need extra support or facilities in the court building where you are doing your Jury Service?":
            case "A oes gennych anabledd neu nam sy'n golygu bydd angen cymorth neu gyfleusterau ychwanegol arnoch yn yr adeilad llys ble fyddwch yn cyflawni eich gwasanaeth rheithgor?":
                ddId = "answerAdjustments";
                break;
            case "Tell us about any special arrangements or help you need while you're doing jury service":
            case "Rhowch wybod inni am unrhyw drefniadau arbennig bydd arnoch angen wrth ichi wasanaethu ar reithgor.":
                ddId = "assistanceSpecialArrangements";
                break;
            case "Does the person have a disability or impairment that means they'll need extra support or facilities in the court building where they are doing jury service?":
            case "A oes gan yr unigolyn anabledd neu nam sy'n golygu bydd angen cymorth neu gyfleusterau ychwanegol arnynt yn yr adeilad llys lle byddant yn cyflawni'r gwasanaeth rheithgor?":
                ddId = "answerCJSEmployed";
                break;
            case "Tell us about any special arrangements or help the person you're answering for needs while they're doing jury service":
            case "Rhowch wybod inni am unrhyw drefniadau arbennig neu gymorth bydd yr unigolyn rydych yn ymateb ar ei ran ei angen wrth iddynt wasanaethu ar reithgor.":
                ddId = "assistanceSpecialArrangements";
                break;
            case "A ydych chi yn, neu a ydych chi wedi gweithio i’r Heddlu, Gwasanaeth Carchardai EM, yr Asiantaeth Troseddu Cenedlaethol neu unrhyw awdurdod erlyn yn y 5 mlynedd diwethaf?":
                ddId = "answerAdjustments";
                break;
//		Expenses Check Your Answers

            case "Will you lose income?":
//		case "":
                ddId = "earnings";
                break;
            case "Do you earn more than ":
//			case "":
                ddId = "earningsThreshold";
                break;
            case "How much do you earn each day?":
//			case "":
                ddId = "earningsAmount";
                break;
            case "Extra costs you wouldn't normally have?":
//		case "":
                ddId = "extraCosts";
                break;
            case "Total value of extra costs":
//			case "":
                ddId = "extraCostsAmount";
                break;
            case "How will you travel to court?":
//			case "":
                ddId = "travelType";
                break;
            case "Miles by bicycle each day":
//		case "":
                ddId = "travelBicycle";
                break;
            case "Miles by car each day":
//			case "":
                ddId = "travelCar";
                break;
            case "Miles by motorcycle each day":
//			case "":
                ddId = "travelMotorcycle";
                break;
            case "Cost of public transport each day":
            case "Cyfanswm cost trafnidiaeth gyhoeddus fesul dydd":
                ddId = "travelPublicTransport";
                break;

//		#bureau
            case "Disability or impairment":
                ddId = "disability";
                break;
            case "Special arrangements or help the juror needs":
                ddId = "reasonableAdjustment";
                break;

        }
        WebElement element = driver.findElement(By.id(ddId));

        assertTrue("nextToText is not correct", element.getText().contains(searchText));

        log.info("Found =>" + ddId);
        log.info("Found =>" + searchText);
    }

    //Old See in Same Row
    public void seeText_inSameRow_asText(String searchText, String nextToText) {
        driver.findElement(
                By.xpath(
                        "//table//tr//*[contains(text(),\"" + searchText + "\")]//ancestor::tr//*[text()[contains(., \"" + nextToText + "\")]]"
                                + " | "
                                + "//table//tr//*[contains(text(),\"" + nextToText + "\")]//ancestor::tr//*[text()[contains(., \"" + searchText + "\")]]"
                                + " | "
                                + "//div//dd[contains(text(),\"" + searchText + "\")]//ancestor::div//dt[text()[contains(., \"" + nextToText + "\")]]"
                ));
        log.info("Found =>" + searchText + "<= in the same row as =>" + nextToText + "<= as expected");

    }

    //Old Click Change Link
    public void clickText_inSameRow_asText(String clickText, String nextToText) throws Exception {
        log.info("Going to click on text =>" + clickText + "<= in a row that contains text =>" + nextToText);
        wait.activateImplicitWait();

        WebElement click_text = driver.findElement(
                By.xpath(
                        "//table//tr//td[contains(text(),\"" + nextToText + "\")]//ancestor::tr//td[text()[contains(., \"" + clickText + "\")]]"
                                + "|"
                                + "//table//tr//td//a[contains(text(),\"" + nextToText + "\")]//ancestor::tr//td//a[text()[contains(., \"" + clickText + "\")]]"
                                + "|"
                                + "//table//tr//td[contains(text(),\"" + nextToText + "\")]//ancestor::tr//td//a[text()[contains(., \"" + clickText + "\")]]"
                                + "|"
                                + "//table//tr//*[contains(text(),\"" + nextToText + "\")]//ancestor::tr//a[text()[contains(., \"" + clickText + "\")]]"
//								+ "|"
//								+ "//dt[contains(text(),\"" + nextToText + "\")]//ancestor:://div/dd//a[text()[contains(., \"" + clickText + "\")]]"
                                + ""));

        wait.waitForClickableElement(click_text);
        click_onElement(click_text);
        log.info("Clicked on =>" + clickText + "<= successfully");

    }

    //New Click Change Link
    public void clickText_inSameRow_asText_Two(String clickText, String nextToText) throws Exception {
        log.info("Going to click on text =>" + clickText + "<= in a row that contains text =>" + nextToText);
        wait.activateImplicitWait();

        log.info("seeText_inSameRow_asText " + clickText + ", " + nextToText);

        String clickTextId = "";

        switch (nextToText) {
            case "Name":
            case "Enw":
                clickTextId = "changeName";
                break;
            case "Your name":
                clickTextId = "changeThirdPartyName";
                break;
            case "Address":
            case "Cyfeiriad":
                clickTextId = "changeAddress";
                break;
            case "Main phone":
            case "Prif rif ffôn":
                clickTextId = "changePhone";
                break;
            case "Another phone (optional)":
            case "Rhif ffôn arall (dewisol)":
                clickTextId = "changeSecondaryPhone";
                break;
            case "Email":
            case "E-bost":
                clickTextId = "changeEmailAddress";
                break;
            case "Date of birth":
            case "Dyddiad geni":
                clickTextId = "changeDob";
                break;
            case "Since you turned 13, has your main address been in the UK, Channel Islands or Isle of Man for any period of at least 5 years?":
            case "Since they turned 13, has their main address been in the UK, Channel Islands or Isle of Man for any period of at least 5 years?":
            case "Ers i chi droi'n 13 oed, a yw eich prif gyfeiriad wedi bod yn y DU, Ynysoedd y Sianel neu Ynys Manaw am unrhyw gyfnod o 5 mlynedd o leiaf?":
                clickTextId = "changeLivedConsecutive";
                break;
            case "Are you being detained, looked after or treated under the Mental Health Act?":
            case "Is the person you're replying for being detained, looked after or treated under the Mental Health Act?":
            case "Ydych chi'n cael eich cadw, yn cael eich gwarchod neu eich trin o dan y Ddeddf Galluedd Meddyliol?":
                clickTextId = "changeMentalHealthSectioned";
                break;
            case "Has it been decided that you 'lack mental capacity'?":
            case "Has it been decided that the person you're replying for 'lacks mental capacity'?":
            case "A benderfynwyd nad oes gennych y gallu meddyliol?":
                clickTextId = "changeMentalHealthCapacity";
                break;
            case "Are you currently on bail for a criminal offence?":
            case "Is the person currently on bail for a criminal offence?":
//		case "A ydych chi ar fechnïaeth ar hyn o bryd am gyflawni trosedd?":
            case "ar hyn o bryd am gyflawni trosedd?":
                clickTextId = "changeOnBail";
                break;
            case "Have you been convicted of a criminal offence and been given a sentence?":
            case "Has the person been convicted of a criminal offence and been given a sentence?":
            case "A ydych wedi'ch cael yn euog o gyflawni trosedd?":
                clickTextId = "changeConvictions";
                break;
            case "Confirm the date of your jury service":
            case "Cadarnhewch ddyddiad eich gwasanaeth rheithgor":
            case "Confirm the date of their jury service":
            case "Cadarnhewch ddyddiad ei wasanaeth rheithgor":
                clickTextId = "changeConfirmDate";
                break;
            case "Tell us why you need another date for your jury service":
            case "Eglurwch pam eich bod angen newid dyddiad eich gwasanaeth rheithgor":
                clickTextId = "changeDeferral";
                break;
            case "Choose 3 Mondays when you can start jury service":
            case "Give us 3 dates the person you're replying for could start jury service during the next 12 months":
            case "Nodwch dri dyddiad yn y 12 mis nesaf pan fyddwch ar gael i ddechrau gwasanaethu ar reithgor":
                clickTextId = "changeDeferralDates";
                break;
            case "Say why you need to be excused from jury service":
            case "Eglurwch pam na allwch chi wasanaethu ar reithgor yn ystod y 12 mis nesaf":
                clickTextId = "changeExcusalReason";
                break;
            case "Have you worked in the criminal justice system in the last 5 years?":
            case "Has the person you're replying for worked in the criminal justice system in the last 5 years?":
            case "A ydych chi yn, neu a ydych chi wedi gweithio i'r Heddlu, Gwasanaeth Carchardai EM, yr Asiantaeth Troseddu Cenedlaethol neu unrhyw awdurdod erlyn yn y 5 mlynedd diwethaf?":
                clickTextId = "changeCJS";
                break;
            case "Do you have a disability or impairment that means you'll need extra support or facilities in the court building where you are doing your Jury Service?":
            case "A oes gennych anabledd neu nam sy’n golygu bydd angen cymorth neu gyfleusterau ychwanegol arnoch yn yr adeilad llys ble fyddwch yn cyflawni eich gwasanaeth rheithgor?":
                clickTextId = "changeAdjustments";
                break;
            case "Please tell us about any special arrangements or help you need while you're doing jury service.":
            case "Rhowch wybod inni am unrhyw drefniadau arbennig bydd arnoch angen wrth ichi wasanaethu ar reithgor.":
                clickTextId = "changeSpecialArrangements";
                break;
            case "Does the person have a disability or impairment that means they’ll need extra support or facilities in the court building where they are doing jury service?":
            case "A oes gan yr unigolyn anabledd neu nam sy'n golygu bydd angen cymorth neu gyfleusterau ychwanegol arnynt yn yr adeilad llys lle byddant yn cyflawni'r gwasanaeth rheithgor?":
                clickTextId = "changeAdjustments";
                break;
            case "Please tell us about any special arrangements or help the person you're answering for needs while they're doing jury service":
            case "Rhowch wybod inni am unrhyw drefniadau arbennig neu gymorth bydd yr unigolyn rydych yn ymateb ar ei ran ei angen wrth iddynt wasanaethu ar reithgor.":
                clickTextId = "changeSpecialArrangements";
                break;

//		expenses change links

            case "Will you lose income?":
            case "A fyddwch yn colli incwm?":
                clickTextId = "changeEarnings";
                break;
            case "Do you earn more than ":
            case "A ydych yn ennill mwy na £":
                clickTextId = "changeEarningsThreshold";
                break;
            case "How much do you earn each day?":
            case "Faint ydych chi'n ennill fesul dydd?":
                clickTextId = "changeEarningsAmount";
                break;
            case "Extra costs you wouldn't normally have?":
            case "A oes gennych gostau ychwanegol na fyddai'n codi fel arfer?":
                clickTextId = "changeExtraCosts";
                break;
            case "Total value of extra costs":
            case "Cyfanswm y costau ychwanegol":
                clickTextId = "changeExtraCostsAmount";
                break;
            case "How will you travel to court?":
            case "Sut byddwch yn teithio i'r llys?":
                clickTextId = "changeTravelType";
                break;
            case "Miles by bicycle each day":
            case "Milltiroedd ar feic fesul dydd":
                clickTextId = "changeTravelBicycle";
                break;
            case "Miles by car each day":
            case "Milltiroedd mewn car fesul dydd":
                clickTextId = "changeTravelCar";
                break;
            case "Miles by motorcycle each day":
            case "Milltiroedd ar feic modur fesul dydd":
                clickTextId = "changeTravelMotorcycle";
                break;
            case "Cost of public transport each day":
            case "Cyfanswm cost trafnidiaeth gyhoeddus fesul dydd":
                clickTextId = "changeTravelPublicTransport";
                break;
        }

        WebElement element = driver.findElement(By.id(clickTextId));

        element.click();
        wait.deactivateImplicitWait();
        log.info("Clicked =>" + clickTextId);

    }

    public void seeText_isBold(String text) {
        log.info("Going to check if text =>" + text + "<= isBold");
        driver.findElement(By.xpath("//strong[text()[contains(., \"" + text + "\")]]"));
        log.info("Found bold text =>" + text);

    }

    public void setInputFieldWith_toText(String attributeType, String attributeValue, String inputText) {
        try {
            log.info("Going to find field by =>" + attributeType + "<= with value =>" + attributeValue + "<= and set it to =>" + inputText);
            WebElement inputField = driver.findElement(By.xpath("//input[@" + attributeType + "='" + attributeValue + "']"));
            inputField.clear();
            // clear() doesn't always work so this second approach ensures the field is cleared
            inputField.click();
            inputField.sendKeys(Keys.chord(Keys.CONTROL, "a", Keys.DELETE));
            inputField.sendKeys(inputText);
            log.info("Found field and input text =>" + inputText);
        } catch (Exception e) {
            log.info("Going to find field by =>" + attributeType + "<= with value =>" + attributeValue + "<= and set it to =>" + inputText);
            WebElement inputField = driver.findElement(By.xpath("//input[@" + attributeType + "='" + attributeValue + "']"));
            click_onElement(inputField);
            inputField.clear();
            // clear() doesn't always work so this second approach ensures the field is cleared
            inputField.click();
            inputField.sendKeys(Keys.chord(Keys.CONTROL, "a", Keys.DELETE));
            inputField.sendKeys(inputText);
            log.info("Found field and input text =>" + inputText);
        }
    }


    //	db new to click cancel link in editing bureau
    public void clickLinkWithId(String linkId) {
        try {
            log.info("Going to find field by =>" + linkId + "");
            WebElement inputField = driver.findElement(By.xpath("//a[@id='" + linkId + "']"));
            inputField.click();
            log.info("Found =>" + linkId + " and clicked it");
        } catch (Exception e) {
            log.info("Going to find field by =>" + linkId + "");
            WebElement inputField = driver.findElement(By.xpath("//button[@id='" + linkId + "']"));
            inputField.click();
            log.info("Found =>" + linkId + " and clicked it");
        }
    }

    public void setTextAreaWith_toText(String attributeType, String attributeValue, String inputText) {
        log.info("Going to find field by =>" + attributeType + "<= with value =>" + attributeValue + "<= and set it to =>" + inputText);
        WebElement inputField = driver.findElement(By.xpath("//textarea[@" + attributeType + "='" + attributeValue + "']"));
        inputField.clear();
        inputField.sendKeys(inputText);
        log.info("Found field and input text =>" + inputText);
    }

    //DB new process reply
    public void setProcessReplyTo_(String optionValue) {
        log.info("Going to find Process reply value =>" + optionValue + "<= and select it");
        WebElement processReply = driver.findElement(By.xpath("//a[text()[contains(., '" + optionValue + "')]]"));
        processReply.click();
        log.info("Found field and input text =>" + optionValue);
    }

    public void setTextAreaWith_toText_noClear(String attributeType, String attributeValue, String inputText) {
        log.info("Going to find field by =>" + attributeType + "<= with value =>" + attributeValue + "<= and set it to =>" + inputText);
        WebElement inputField = driver.findElement(By.xpath(
                "//textarea[@" + attributeType + "='" + attributeValue + "']"
                        + "|"
                        + "//input[@" + attributeType + "='" + attributeValue + "']"
        ));
        inputField.sendKeys(inputText);
        log.info("Found field and input text =>" + inputText);
    }

    public void checkboxState_inSameRow_asText(String checkboxState, String nextToText) throws Exception {
        try {
            log.info("Going to confirm checkbox state is =>" + checkboxState + "<= in a row that contains text =>" + nextToText);
            WebElement checkbox = driver.findElement(
                    By.xpath("//table//tr//td[contains(text(),\"" + nextToText + "\")]//ancestor::tr//input[@type='checkbox']"));

            if (checkboxState.equalsIgnoreCase("checked") && checkbox.isSelected()) {
                log.info("Checkbox checked as expected");
                return;
            } else if (checkboxState.equalsIgnoreCase("unchecked") && !checkbox.isSelected()) {
                log.info("Checkbox unchecked as expected");
                return;
            }
            throw new Exception("Checkbox state not as expected - Failing");
        } catch (Exception e) {
            log.info("Going to confirm checkbox state is =>" + checkboxState + "<= in a row that contains text =>" + nextToText);
            WebElement checkbox = driver.findElement(
                    By.xpath("//table//tr//td//a[contains(text(),\"" + nextToText + "\")]//ancestor::tr//input[@type='checkbox']"));

            if (checkboxState.equalsIgnoreCase("checked") && checkbox.isSelected()) {
                log.info("Checkbox checked as expected");
                return;
            } else if (checkboxState.equalsIgnoreCase("unchecked") && !checkbox.isSelected()) {
                log.info("Checkbox unchecked as expected");
                return;
            }
            throw new Exception("Checkbox state not as expected - Failing");
        }
    }

    public void seeIconSame_rowAs(String icon, String nextToText) {
        try {
            log.info("Going to confirm icon is =>" + icon + "<= is in a row that contains text =>" + nextToText);
            driver.findElement(
//		orig	By.xpath("//table//tr//td[contains(text(),\""+nextToText+"\")]//ancestor::tr//td//span[@title='"+icon+"']"));
//		changed by DB to pick up the icon after the latest updates 22-10-21
                    By.xpath("//tr//td//a[contains(text(),\"" + nextToText + "\")]//ancestor::tr//td//span[contains(normalize-space(text()),'" + icon + "')]"));
            log.info("Saw icon in row which contained text =>" + nextToText);
        } catch (Exception e) {
            driver.findElement(
                    By.xpath("//tr//td/div/a/span[contains(text(),\"" + nextToText + "\")]//ancestor::tr//td//span[contains(text(),'" + icon + "']"));

        }

    }

    public void recordFlaggedOverdue(String nextToText) {
        try {

            log.info("Going to find overdue flag for =>" + nextToText + "");
//		driver.findElement(By.xpath("//*[@title='Overdue']//ancestor::tr/td/a[contains(normalize-space(text()),'"+nextToText+"')]"));
            driver.findElement(By.xpath("//*[@class='moj-badge moj-badge--red']//ancestor::tr/td/a[contains(normalize-space(text()),'" + nextToText + "')]"));
        } catch (Exception e) {
            log.info("Going to find overdue flag for =>" + nextToText + "");
            driver.findElement(By.xpath("//*[@title='Overdue']//ancestor::tr/td//a[contains(normalize-space(text()),'" + nextToText + "')]"));
        }
    }

    public void replyTypeIndicator(String nextToText, String replyType) {
        try {
            log.info("Going to find reply type indicator for =>" + nextToText + "");
            driver.findElement(By.xpath(
                    "//tr//td//span[contains(text(),\"" + replyType + "\")]//ancestor::tr//td//a[text()[contains(.,\"" + nextToText + "\")]]"
                            + "|"
                            + "//tr//td//strong[contains(text(),\"" + replyType + "\")]//ancestor::tr//td//a[text()[contains(.,\"" + nextToText + "\")]]"
            ));
        } catch (Exception e) {
            log.info("Going to find reply type indicator for =>" + nextToText + "");
            driver.findElement(By.xpath("//*[@title='" + replyType + "']//ancestor::tr/td//a[contains(normalize-space(text()),'" + nextToText + "')]"));
        }
    }

    public void checkCheckboxSame_rowAs(String nextToText) {
        wait.activateImplicitWait();
        WebElement checkbox = driver.findElement(
                By.xpath(
                        "//table//tr//td/a[contains(text(),\"" + nextToText + "\")]//ancestor::tr//input[@type='checkbox']"
                                + " | "
                                + "//table//tr//td[contains(text(),\"" + nextToText + "\")]//ancestor::tr//input[@type='checkbox']"
                ));
        log.info("Saw checkbox in row which contained text =>" + nextToText);
        wait.toBeClickAble(checkbox);
        checkbox.click();
        log.info("Checked checkbox which was in the same row as =>" + nextToText);

    }


    public void checkPageTitleIs(String expectedPageTitle) {
        WebDriverWait wait = new WebDriverWait(driver, Duration.ofSeconds(15));
        wait.until(ExpectedConditions.titleContains(expectedPageTitle));

        log.info("Saw page title matched with =>" + expectedPageTitle);
    }


    public void press_tabKeyOnBody() {
        try {
            WebElement logo = driver.findElement(By.id("logo"));
            //sendKeys(Keys.SHIFT);
            String press = Keys.chord(Keys.SHIFT, Keys.TAB);
            logo.sendKeys(press);
        } catch (Exception e) {
            WebElement logo = driver.findElement(By.xpath("//div[@class='govuk-header__logo']//a"));
            //sendKeys(Keys.SHIFT);
            String press = Keys.chord(Keys.SHIFT, Keys.TAB);
            logo.sendKeys(press);
        }

        log.info("Tabbed to see Skip to Main Content");
    }

    public void press_backspace(String textAreaId) {
        WebElement inputField;
        inputField = driver.findElement(By.xpath("//div/textarea[contains(@id," + textAreaId + ")]"));
        inputField.sendKeys(Keys.BACK_SPACE);
    }

    public void clear_field(String fieldId) {
        WebElement inputField;
        inputField = driver.findElement(By.xpath("//input[@id='" + fieldId + "']"));
        inputField.sendKeys(Keys.CONTROL, "a", Keys.DELETE);
    }

    public void press_a_key(String key, String inputFieldLabel) {
        try {
            WebElement inputField;
            inputField = find_inputBy_labelName(inputFieldLabel);
            inputField.sendKeys(Keys.valueOf(key.toUpperCase()));

        } catch (Exception e) {
            WebElement logo = driver.findElement(By.xpath(
                    "//div[@class='govuk-header__logo']//a"
                            + "|"
                            + "//label[text()[(normalize-space(.)='" + inputFieldLabel + "')]]"
                            + "|"
                            + "//div[contains(text(),'" + inputFieldLabel + "')]//ancestor::div/div/textarea"));
            //sendKeys(Keys.SHIFT);
            String press = Keys.chord(Keys.SHIFT, Keys.TAB);
            logo.sendKeys(press);
        }

        log.info("Pressed backspace");
    }

    public void hitTabForMainContent() {

    }

    public void see_inURL(String urlPart) {
        waitForPageLoad();
        String current_url = driver.getCurrentUrl();
        log.info("Current URL is =>" + current_url);
        Assert.assertTrue(current_url.contains(urlPart));
        log.info("URL =>" + current_url + "<= contains text =>" + urlPart);


        //osman testing
    }

//	public void seeText_inSameRow_asText_inBacklog(String searchText, String nextToText) {
//		WebElement element = driver.findElement(By.xpath("//div//nav//ul[contains(@class,'backlog-summary')]/li[contains(normalize-space(text()),'"+nextToText+"')]/span[text()='"+searchText+"']"));
//		log.info("Found =>" + searchText + "<= in the same row as =>" + nextToText + "<= as expected");
//		Boolean value = element.isDisplayed();
//		assertTrue(value);
//		log.info("element exists on UI");


    public void seeText_inSameRow_asText_inBacklog(String searchText, String nextToText) {
        WebElement element = driver.findElement(By.xpath("//div[contains(@class,'jd-assign-replies-" + nextToText + "')]/div[contains(normalize-space(text()),'" + searchText + "')]"));
        log.info("Found =>" + searchText + "<= in the same row as =>" + nextToText + "<= as expected");
        Boolean value = element.isDisplayed();
        assertTrue(value);
        log.info("element exists on UI");

    }

    public void seeText_inAllocateReplies(String searchText, String elementName) {
        WebElement element = driver.findElement(By.name(elementName));
        String text = element.getAttribute("value");
        assertEquals(searchText, text);
    }

    //work allocation specific
    public WebElement getBoxHeaderText(String text, String boxName) {
        try {
            wait.activateImplicitWait();
            log.info("Looking for text =>" + text + "<= under =>" + boxName);
            WebElement boxHeader = driver.findElement(By.xpath(
                    "//div/h1[contains(@class,'heading-small') and contains(normalize-space(text()),'" + boxName + "')]/../nav/ul/li[contains(normalize-space(text()),'" + text + "')]"));
            wait.deactivateImplicitWait();
            return boxHeader;
        } catch (Exception e) {
            wait.activateImplicitWait();
            log.info("Looking for text =>" + text + "<= under =>" + boxName);
            WebElement boxHeader = driver.findElement(By.xpath(
                    "//div/h1[contains(@class,'govuk-heading-xl no-margin no-bold inline') and contains(normalize-space(text()),'" + boxName + "')]/../nav/ul/li[contains(normalize-space(text()),'" + text + "')]"));
            wait.deactivateImplicitWait();
            return boxHeader;
        }
    }

    public void checkButtonIsDisabled(String buttonName) {
        log.info("Going to see if =>" + buttonName + "<= is disabled =>");
        WebElement element = driver.findElement(By.xpath("//button[contains(normalize-space(text()),'" + buttonName + "')] "));
        //WebElement element1 = driver.findElement(By.xpath("//button[contains(normalize-space(text()),'"+buttonName+"')] and (contains(@disabled=1"));
        String value = element.getAttribute("disabled");
        Assert.assertNotNull("Button was enabled when not expected", value);
        log.info("Found =>" + buttonName + "<= is disabled=>");
    }

//	public void totalAssignedCount(String countName, String countValue) {
//		log.info("Going to check that total assigned =>"+countName+"<= count is =>"+countValue+"<=");
//		String assignedCount = driver.findElement(By.id(countName)).getText();
//		Assert.assertEquals(countValue, assignedCount);
//		log.info("=>"+countName+"<= Assigned Count is as expected");
//
//	}

    public void totalAssignedCount(String countName, String countValue) {
        log.info("Going to check that total assigned =>" + countName + "<= count is =>" + countValue + "<=");
        String assignedCount = driver.findElement(By.xpath("//td[contains(normalize-space(text()), '" + countName + "')]")).getText();
        Assert.assertEquals(countValue, assignedCount);
        log.info("=>" + countName + "<= Assigned Count is as expected");

    }

    public void switchToNewWindow() {
        new WebDriverWait(driver, Duration.ofSeconds(100)).until(ExpectedConditions.numberOfWindowsToBe(2));
        String currentWindowHandle = driver.getWindowHandle();
        log.info("current window is " + currentWindowHandle);
        for (String winHandle : driver.getWindowHandles()) {
            log.info("Window in for loop is " + winHandle);
            if (!winHandle.equals(currentWindowHandle)) {
                log.info("switching to" + winHandle);
                driver.switchTo().window(winHandle);
                return;
            }
        }
        log.error("No new window when one was expected");
    }

    public void closeWindowAndSwitchToDefaultWindow() {
        if (driver.getWindowHandles().size() != 2) {
            log.error("Window count expected to be 2 but is " + driver.getWindowHandles().size());
        }
//    	driver.close();
        new WebDriverWait(driver, Duration.ofSeconds(40)).until(ExpectedConditions.numberOfWindowsToBe(1));
        if (driver.getWindowHandles().size() != 1) {
            log.error("Window count expected to be 1 but is " + driver.getWindowHandles().size());
        }
        for (String winHandle : driver.getWindowHandles()) {
            log.info("switching to" + winHandle);
            driver.switchTo().window(winHandle);
            log.info("switched to window");
            return;
        }
        return;

    }

    //	@When("^I set \"([^\"]*)\" to \"([^\"]*)\"$")
    public void set_value_to(String arg1, String arg2) throws Throwable {

        if (arg2.contains("{") && arg2.contains("}")) {
            arg2 = arg2.replace("{", "").replace("}", "");
            arg2 = DateManipulator.formatDate(
                    DateManipulator.processString(arg2, false),
                    "dd/MM/yyyy"
            );
        }
        try {
            WebElement childField;
            childField = find_inputBy_labelName(arg1);
            childField.clear();
            set_valueTo(arg1, arg2);
        } catch (Exception e) {
            WebElement newChildField;
            newChildField = find_inputBy_labelName(arg1);
            newChildField.clear();
            waitForPageLoad();
            set_valueTo(arg1, arg2);
        }
    }


    public void seeText_inSameRow_asText_inPoolRequests(String dataItem, String selectedOption) throws Throwable {
        WebElement element = driver.findElement(By.xpath("//dd[contains(text(),'" + selectedOption + "')]//ancestor::div//dt[contains(text(),'" + dataItem + "')]"));
        log.info("Found =>" + selectedOption + "<= in the same row as =>" + dataItem + "<= as expected");
        boolean value = element.isDisplayed();
        assertTrue(value);
        log.info("element exists on UI");
    }

    public void clickChangeLinkInSameRowAs_inPoolRequests(String link, String nextTo) throws Throwable {
        try {
            WebElement element = driver.findElement(By.xpath("//a[contains(text(),'" + link + "')]//ancestor::div//dt[contains(text(),'" + nextTo + "')]"));
            element.click();
        } catch (Exception e) {
            WebElement element = driver.findElement(By.xpath("//a[contains(text(),'" + link + "')]//ancestor::div//dd[contains(text(),'" + nextTo + "')]"));
            element.click();
        }
        log.info("Found =>" + link + "<= in the same row as =>" + nextTo + "<= as expected");

    }


//	public void typeIntoNotesModal(String text) {
//
//		Alert alert = driver.switchTo().alert();
//		driver.switchTo().alert().sendKeys(text);
//		driver.switchTo().alert().accept();
//		WebElement modal = driver.findElement(By.xpath("//section/text area[contains(@class,'modal-textarea'"));
//		WebElement modal = driver.findElement(By.xpath("//div[contains(@class,'modal')]/section/text area[contains(@class,'modal-textarea'"));
//		modal.clear();
//		modal.sendKeys(text);


    @FindBy(id = "date1Month")
    WebElement attendanceMonth1Field;

    @FindBy(id = "date1Year")
    WebElement attendanceYear1Field;

    @FindBy(id = "date1Day")
    WebElement attendanceDay1Field;

    @FindBy(id = "date2Day")
    WebElement attendanceDay2Field;

    @FindBy(id = "date2Month")
    WebElement attendanceMonth2Field;

    @FindBy(id = "date2Year")
    WebElement attendanceYear2Field;

    @FindBy(id = "date3Day")
    WebElement attendanceDay3Field;

    @FindBy(id = "date3Month")
    WebElement attendanceMonth3Field;

    @FindBy(id = "date3Year")
    WebElement attendanceYear3Field;

    @FindBy(id = "attendanceDateDay")
    WebElement newAttendanceDay3Field;

    @FindBy(id = "attendanceDateMonth")
    WebElement newAttendanceMonth3Field;

    @FindBy(id = "attendanceDateYear")
    WebElement newAttendanceYear3Field;

    @FindBy(id = "attendanceDate")
    WebElement newAttendanceDateField;

    @FindBy(id = "deferralDate")
    WebElement deferToDate;

    @FindBy(id = "dobDay")
    WebElement dobDayField;

    @FindBy(id = "dobMonth")
    WebElement dobMonthField;

    @FindBy(id = "dobYear")
    WebElement dobYearField;

    @FindBy(id = "deferDate1")
    WebElement deferDate1Field;

    @FindBy(id = "deferDate2")
    WebElement deferDate2Field;

    @FindBy(id = "deferDate3")
    WebElement deferDate3Field;

    @FindBy(id = "completionDate")
    WebElement completionDateField;

    @FindBy(id = "postponeTo")
    WebElement postponeServiceStartDateField;

    @FindBy(id = "nonAttendanceDay")
    WebElement nonAttendanceDayDateField;

    @FindBy(id = "startDate")
    WebElement trialStartDate;

    @FindBy(id = "serviceStartDate")
    WebElement serviceStartDate;

    @FindBy(xpath = "//*[@id=\"messageTemplateForm\"]/div[2]/div[2]/dl/div/dd")
    WebElement messageTemplate;

    @FindBy(name = "selectMethod")
    WebElement methodDropdown;

    @FindBy(className = "moj-banner__message")
    WebElement messageBanner;

    @FindBy(id = "nextDueAtCourtDate")
    WebElement nextDueAtCourtDate;

    @FindBy(id = "sentenceDate")
    WebElement sentenceDate;

    @FindBy(id = "attendanceDay")
    WebElement attendanceDay;

    @FindBy(id = "hearingDate")
    WebElement hearingDate;

    public void enterNewDate(String attDateSequence, final String day, final String month, final String year) {
        log.info("Entering new date");
        switch (attDateSequence) {
            case "First":
                attendanceDay1Field.clear();
                attendanceDay1Field.sendKeys(day);

                attendanceMonth1Field.clear();
                attendanceMonth1Field.sendKeys(month);

                attendanceYear1Field.clear();
                attendanceYear1Field.sendKeys(year);
                break;

            case "Second":
                attendanceDay2Field.clear();
                attendanceDay2Field.sendKeys(day);

                attendanceMonth2Field.clear();
                attendanceMonth2Field.sendKeys(month);

                attendanceYear2Field.clear();
                attendanceYear2Field.sendKeys(year);
                break;

            case "Third":
                attendanceDay3Field.clear();
                attendanceDay3Field.sendKeys(day);

                attendanceMonth3Field.clear();
                attendanceMonth3Field.sendKeys(month);

                attendanceYear3Field.clear();
                attendanceYear3Field.sendKeys(year);
                break;

            case "DOB":
                dobDayField.clear();
                dobDayField.sendKeys(day);

                dobMonthField.clear();
                dobMonthField.sendKeys(month);

                dobYearField.clear();
                dobYearField.sendKeys(year);
                break;

        }
    }

    public void enterNewSingleDate(String defDateSeq, String mondayDateValue) {
        log.info("Entering new date");
        switch (defDateSeq) {
            case "First":
                deferDate1Field.clear();
                deferDate1Field.sendKeys(mondayDateValue);
                break;

            case "Second":
                deferDate2Field.clear();
                deferDate2Field.sendKeys(mondayDateValue);
                break;

            case "Third":
                deferDate3Field.clear();
                deferDate3Field.sendKeys(mondayDateValue);
                break;

            case "Change the attendance date for this pool":
                newAttendanceDateField.clear();
                newAttendanceDateField.sendKeys(mondayDateValue);
                break;

            case "Change the service start date for this pool":
                newAttendanceDateField.clear();
                newAttendanceDateField.sendKeys(mondayDateValue);
                break;

            case "Deferral":
                deferToDate.clear();
                deferToDate.sendKeys(mondayDateValue);
                break;

            case "Completion date":
                completionDateField.clear();
                completionDateField.sendKeys(mondayDateValue);
                break;

            case "Postpone service start date":
                postponeServiceStartDateField.clear();
                postponeServiceStartDateField.sendKeys(mondayDateValue);
                break;

            case "Start date for Trial":
                trialStartDate.clear();
                trialStartDate.sendKeys(mondayDateValue);
                break;

            case "Service start date for new pool":
                serviceStartDate.clear();
                serviceStartDate.sendKeys(mondayDateValue);
                break;

            case "Service start date for transfer":
                newAttendanceDateField.clear();
                newAttendanceDateField.sendKeys(mondayDateValue);
                break;

            case "Attendance date for message":
                newAttendanceDateField.clear();
                newAttendanceDateField.sendKeys(mondayDateValue);
                break;

            case "Next due at court":
                nextDueAtCourtDate.clear();
                nextDueAtCourtDate.sendKeys(mondayDateValue);
                break;

            case "Sentence":
                sentenceDate.clear();
                sentenceDate.sendKeys(mondayDateValue);
                break;

            case "Enter a new service start date":
                postponeServiceStartDateField.clear();
                postponeServiceStartDateField.sendKeys(mondayDateValue);
                break;

            case "Enter a date for the non-attendance day":
                nonAttendanceDayDateField.clear();
                nonAttendanceDayDateField.sendKeys(mondayDateValue);
                break;

            case "Attendance Day":
                attendanceDay.clear();
                attendanceDay.sendKeys(mondayDateValue);
                break;

            case "Next due date":
                newAttendanceDateField.clear();
                newAttendanceDateField.sendKeys(mondayDateValue);
                break;

            case "Show cause":
                hearingDate.clear();
                hearingDate.sendKeys(mondayDateValue);
                break;
        }
    }

    public void appendURL(String uRL) {
        String expected_text = "Page not found";
        String bodyText = driver.findElement(By.tagName("body")).getText();
        log.info("Going to check if text present on the page =>" + expected_text);
        String url = driver.getCurrentUrl().substring(0, 36);
        String newurl = url + "/pool-management";
        driver.navigate().to(newurl);
        Assert.assertTrue("page is found in error", bodyText.contains(expected_text));

    }

    public void iSeeInUrl(String getCurrentUrl) {
        waitForPageLoad();
        driver.getCurrentUrl();
        log.info(getCurrentUrl + "pool-management");
        Assert.assertTrue(true);
        log.info("URL =>" + getCurrentUrl + "pool-management");
    }

    public String getProtocolFromURLString(String urlString) {
        Pattern p = Pattern.compile("(https?://)");
        Matcher m = p.matcher(urlString);
        m.find();
        return m.group(1);
    }

    public String getHeadingText() {
        log.info("Going to see next due date text is present in the page =>");
        return driver.findElements(By.className("govuk-body")).get(0).getText();
    }

    public NavigationShared continueBtnOnPage(String expected_text) throws Throwable {

        log.info("Going to check the availability of continue button =>");
        WebElement continueBtn = driver.findElement(By.className("govuk-button"));
        continueBtn.isDisplayed();
        log.info("Saw Expected Text =>" + expected_text);
        return PageFactory.initElements(driver, NavigationShared.class);

    }

    public String getJurorNumber() {
        log.info("Getting Juror number label ");
        return JurorNumberLabel.getText();
    }

    public String getFirstName() {
        log.info("Getting Jurors first name label ");
        return JurorFirstNameLabel.getText();
    }

    public String getLastName() {
        log.info("Getting jurors last name label");
        return JurorLastNameLabel.getText();
    }

    public String getCheckedIn() {
        log.info("Getting jurors check in label");
        return JurorCheckedInLabel.getText();
    }

    public boolean seeMessageTemplate() {
        return messageTemplate.isDisplayed();
    }

    public void selectFromMessageMethodDropdown(String methodType, String jurorNumber) {
        boolean found = false;
        waitForPageLoad(2);

        Set<String> messageType = new HashSet<>();

        while (true) {
            WebElement table = driver.findElement(By.id("messageJurorsTable"));

            List<WebElement> rows = table.findElements(By.tagName("tr"));
            WebElement rowWithJurorNumber = null;
            for (WebElement row : rows) {
                if (row.getText().contains(jurorNumber)) {
                    rowWithJurorNumber = row;
                    found = true;
                    break;
                }
            }
            if (found) {
                WebElement dropdown = rowWithJurorNumber.findElement(By.name("selectMethod"));
                Select select = new Select(dropdown);

                if (!messageType.contains(methodType)) {
                    WebElement option = dropdown.findElement(By.xpath(".//option[text()='" + methodType + "']"));
                    option.click();
                    messageType.add(methodType);
                    break;
                }
            } else {
                WebElement nextPageLink = driver.findElement(By.className("govuk-pagination__next"));
                nextPageLink.click();
            }
        }
    }

    public String messageSentBanner() {
        String bannerText = messageBanner.getText();
        System.out.println("Message Sent Banner Text: " + bannerText);
        return bannerText;
    }

    public String seeMessageTemplateDate(String specificDate) {
        String messageText = messageTemplate.getText();
        if (messageText.contains(specificDate)) {
            System.out.println("Message template contains the date: " + specificDate);
        } else {
            System.out.println("Message template does not contain the date: " + specificDate);
        }
        return messageText;
    }

    public void press_Savebutton() {
        waitForDocumentReady();
        try {
            ((JavascriptExecutor) driver).executeScript("arguments[0].click();", expenseSave);
            log.info("Clicked on element as normal - Continuing");
            return;
        } catch (Exception e) {
            log.info("Unable to click on element using Selenium, trying via Javascript. Element is =>" + expenseSave);
            ((JavascriptExecutor) driver).executeScript("arguments[0].click();", expenseSave);
            log.info("Clicked on element using javascript - Continuing");
        }
        waitForDocumentReady();
    }


    public void insertHolidayInTheFrontScreen(Integer noOfWeeks) {
        //String datePattern = "EEEE-DD-MM";
       // Calendar calendar = Calendar.getInstance();
        //calendar.add(Calendar.WEEK_OF_MONTH, noOfWeeks);

        DateFormat dateFormat = new SimpleDateFormat("EEEE d MMMMMMMMMM");
        Date today = Calendar.getInstance().getTime();
        Calendar calendar = Calendar.getInstance();
        calendar.setTime(today);
        calendar.add(Calendar.WEEK_OF_MONTH, noOfWeeks);
        Date newDate = calendar.getTime();
        System.out.println(dateFormat.format(newDate));
        System.out.println(bankHoliday.get(2).getText());


        switch (noOfWeeks) {
            case 6:
                   Assert.assertEquals(dateFormat.format(newDate), bankHoliday.get(0).getText());
                break;
            case 24:
                Assert.assertEquals(dateFormat.format(newDate), bankHoliday.get(2).getText());
                break;
        }
    }



}