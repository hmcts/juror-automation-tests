package cucumber.pageObjects;

import cucumber.testdata.DBConnection;
import cucumber.utils.WaitUtils;
import org.apache.log4j.Logger;
import org.openqa.selenium.By;
import org.openqa.selenium.JavascriptExecutor;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;
import java.util.Locale;

import static org.junit.Assert.assertEquals;

public class DigitalByDefault {

    private static final Logger log =
            Logger.getLogger(DigitalByDefault.class);
    private static final DateTimeFormatter SERVICE_START_DATE_FORMAT =
            DateTimeFormatter.ofPattern("EEEE d MMMM uuuu", Locale.ENGLISH);
    private final NavigationShared NAV;

    private final WebDriver driver;
    private final WaitUtils wait;

    public DigitalByDefault(WebDriver driver) {
        this.driver = driver;
        PageFactory.initElements(driver, this);
        wait = new WaitUtils(driver);
        NAV = new NavigationShared(driver);
    }

    @FindBy(css = "[data-test='response-start-what']")
    private WebElement whatJuryServiceInvolvesCard;

    @FindBy(css = "[data-test='response-start-attend']")
    private WebElement whenAndWhereToAttendCard;

    @FindBy(css = "[data-test='response-start-expenses']")
    private WebElement claimingExpensesCard;

    @FindBy(css = "[data-test='response-start-work']")
    private WebElement employmentAndTimeOffWorkCard;

    @FindBy(css = "[data-test='response-start-date']")
    private WebElement changeYourDatesCard;

    @FindBy(css = "[data-test='response-start-support']")
    private WebElement supportAndAccessibilityCard;

    @FindBy(css = "[data-test='response-start-eligibility']")
    private WebElement jurorEligibilityCard;

    @FindBy(css = "#main-content .govuk-inset-text p.govuk-body")
    private WebElement juryServiceSummonsInformation;

    @FindBy(xpath = "//a[text()[contains(.,'Start your response')]]")
    private WebElement startYourResponseButton;

    @FindBy(css = "a.govuk-link[aria-label='Change court catchment area']")
    private WebElement changeCatchmentAreaLink;

    @FindBy(id = "jurorOverview")
    private WebElement jurorsTable;

    @FindBy(xpath = "//table[.//caption[normalize-space()='Pools list']]")
    private WebElement reassignActivePoolsTable;

    @FindBy(xpath = "//p[text()[contains(.,'You are summoned to start jury service on')]]/../p[2]")
    private WebElement attendanceDate;

    @FindBy(xpath = "//*[@id='loss-of-earnings-details-2']/summary/span[contains(text(),'Loss of earnings')]")
    private WebElement lossOfEarningsTwoDetails;

    public void verifyWhatJuryServiceInvolvesCard() {
        verifyCard(
                whatJuryServiceInvolvesCard,
                "How jury service works"
        );
    }

    public void verifyWhenAndWhereToAttendCard() {
        verifyCard(
                whenAndWhereToAttendCard,
                "When and where to attend"
        );
    }

    public void verifyClaimingExpensesCard() {
        verifyCard(
                claimingExpensesCard,
                "Claiming expenses"
        );
    }

    public void verifyEmploymentAndTimeOffWorkCard() {
        verifyCard(
                employmentAndTimeOffWorkCard,
                "Employment and time off work"
        );
    }

    public void verifyChangeYourDatesCard() {
        verifyCard(
                changeYourDatesCard,
                "Ask to change your dates"
        );
    }

    public void verifySupportAndAccessibilityCard() {
        verifyCard(
                supportAndAccessibilityCard,
                "Support and accessibility"
        );
    }

    public void verifyJurorEligibilityCard() {
        verifyCard(
                jurorEligibilityCard,
                "Juror eligibility"
        );
    }

    public void pressStartYourResponseButton() {
        wait.waitForClickableElement(startYourResponseButton, 2);
        startYourResponseButton.click();
        log.info("Pressed the Start your response button");
    }

    public void clickChangeCatchmentAreaLink() {
        wait.waitForClickableElement(changeCatchmentAreaLink, 10);
        changeCatchmentAreaLink.click();
        log.info("Clicked the Change court catchment area link");
    }

    public void clickJurorNumberLinkOtherThan(String excludedJurorNumber) {
        wait.waitForNonList(jurorsTable);

        List<WebElement> tableLinks = jurorsTable.findElements(By.cssSelector("tbody a"));
        List<WebElement> matchingJurorLinks = new ArrayList<>();
        List<String> matchingJurorNumbers = new ArrayList<>();

        for (WebElement link : tableLinks) {
            String linkText = link.getText().trim();
            if (linkText.matches("\\d{9}") && !linkText.equals(excludedJurorNumber)) {
                matchingJurorLinks.add(link);
                matchingJurorNumbers.add(linkText);
            }
        }

        if (matchingJurorLinks.size() != 1) {
            throw new AssertionError(
                    "Expected to find exactly one juror number link other than "
                            + excludedJurorNumber + " but found " + matchingJurorNumbers
            );
        }

        WebElement jurorNumberLink = matchingJurorLinks.get(0);
        String jurorNumber = jurorNumberLink.getText().trim();
        wait.waitForClickableElement(jurorNumberLink, 10);
        jurorNumberLink.click();
        log.info("Clicked juror number link " + jurorNumber);
    }

    public void selectAnyActivePoolFromReassignTable() {
        wait.waitForNonList(reassignActivePoolsTable);

        List<WebElement> activePoolRows =
                reassignActivePoolsTable.findElements(By.cssSelector("tbody tr"));

        if (activePoolRows.isEmpty()) {
            throw new AssertionError("No active pools were displayed in the reassign table");
        }

        WebElement firstActivePoolRow = activePoolRows.get(0);
        WebElement activePoolRadioButton = firstActivePoolRow.findElement(
                By.cssSelector("input.govuk-radios__input[name='poolNumber']")
        );

        String selectedPoolNumber = activePoolRadioButton.getAttribute("value");
        ((JavascriptExecutor) driver).executeScript(
                "arguments[0].click();",
                activePoolRadioButton
        );

        boolean poolSelected = wait.until(
                ignored -> activePoolRadioButton.isSelected(),
                10
        );

        if (!poolSelected) {
            throw new AssertionError(
                    "Active pool " + selectedPoolNumber + " was not selected"
            );
        }

        log.info("Selected active pool " + selectedPoolNumber + " from the reassign table");
    }

    public void setupJurorForDigitalByDefault(String jurorNumber) throws SQLException {
        DBConnection database = new DBConnection();
        String environment = System.getProperty("env.database");

        try (Connection connection = environment == null
                     ? database.getConnection("demo")
                     : database.getConnection(environment)) {
            try {
                try (PreparedStatement jurorStatement = connection.prepareStatement(
                        "UPDATE juror_mod.juror "
                                + "SET digital_by_default = ?, dbd_preference = ? "
                                + "WHERE juror_number = ?"
                )) {
                    jurorStatement.setBoolean(1, true);
                    jurorStatement.setString(2, "Digital");
                    jurorStatement.setString(3, jurorNumber);

                    int updatedJurors = jurorStatement.executeUpdate();
                    if (updatedJurors != 1) {
                        throw new AssertionError(
                                "Expected to update one juror record for " + jurorNumber
                                        + " but updated " + updatedJurors
                        );
                    }
                }

                connection.commit();
                log.info(
                        "Configured juror " + jurorNumber
                                + " for Digital by Default"
                );
            } catch (SQLException | AssertionError exception) {
                connection.rollback();
                throw exception;
            }
        }
    }

    public void clearAllJurorsFromPoolApartFrom(
            String poolNumber,
            String jurorNumberToKeep
    ) throws SQLException {
        DBConnection database = new DBConnection();
        String environment = System.getProperty("env.database");

        try (Connection connection = environment == null
                     ? database.getConnection("demo")
                     : database.getConnection(environment)) {
            try {
                int deletedJurors;
                try (PreparedStatement deleteStatement = connection.prepareStatement(
                        "DELETE FROM juror_mod.juror_pool "
                                + "WHERE pool_number = ? AND juror_number <> ?"
                )) {
                    deleteStatement.setString(1, poolNumber);
                    deleteStatement.setString(2, jurorNumberToKeep);
                    deletedJurors = deleteStatement.executeUpdate();
                }

                try (PreparedStatement verifyStatement = connection.prepareStatement(
                        "SELECT COUNT(*) FROM juror_mod.juror_pool "
                                + "WHERE pool_number = ? AND juror_number = ?"
                )) {
                    verifyStatement.setString(1, poolNumber);
                    verifyStatement.setString(2, jurorNumberToKeep);

                    try (ResultSet resultSet = verifyStatement.executeQuery()) {
                        resultSet.next();
                        if (resultSet.getInt(1) != 1) {
                            throw new AssertionError(
                                    "Juror " + jurorNumberToKeep
                                            + " was not retained in pool " + poolNumber
                            );
                        }
                    }
                }

                connection.commit();
                log.info(
                        "Cleared " + deletedJurors
                                + " juror(s) from juror_mod.juror_pool for pool "
                                + poolNumber + " and retained juror " + jurorNumberToKeep
                );
            } catch (SQLException | AssertionError exception) {
                connection.rollback();
                throw exception;
            }
        }
    }

    public void verifyServiceStartDateForJuror(String jurorNumber) throws SQLException {
        LocalDate expectedServiceStartDate = getServiceStartDateForJuror(jurorNumber);
        String expectedFormattedDate = expectedServiceStartDate.format(SERVICE_START_DATE_FORMAT);
        String expectedTextStart = "You are summoned to start jury service on "
                + expectedFormattedDate + " at ";

        wait.waitForDisplayedElement(juryServiceSummonsInformation, 10);

        String actualText = juryServiceSummonsInformation.getText().trim();

        if (!actualText.startsWith(expectedTextStart)) {
            throw new AssertionError(
                    "The jury service information is incorrect for juror " + jurorNumber
                            + ". Expected it to start with '" + expectedTextStart
                            + "' but found '" + actualText + "'"
            );
        }

        String displayedCourtName = actualText.substring(expectedTextStart.length()).trim();
        if (displayedCourtName.isEmpty()) {
            throw new AssertionError(
                    "The court name is missing from the jury service information for juror "
                            + jurorNumber
            );
        }

        log.info(
                "Verified service start date " + expectedFormattedDate
                        + " for juror " + jurorNumber
                        + " at " + displayedCourtName
        );
    }

    private LocalDate getServiceStartDateForJuror(String jurorNumber) throws SQLException {
        String sql = "SELECT jp.pool_number, p.return_date "
                + "FROM juror_mod.juror_pool jp "
                + "INNER JOIN juror_mod.pool p ON p.pool_no = jp.pool_number "
                + "WHERE jp.juror_number = ? AND jp.is_active = TRUE";

        DBConnection database = new DBConnection();
        String environment = System.getProperty("env.database");

        try (Connection connection = environment == null
                     ? database.getConnection("demo")
                     : database.getConnection(environment);
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setString(1, jurorNumber);

            try (ResultSet resultSet = statement.executeQuery()) {
                if (!resultSet.next()) {
                    throw new AssertionError(
                            "No active pool was found in juror_mod.juror_pool for juror "
                                    + jurorNumber
                    );
                }

                String poolNumber = resultSet.getString("pool_number");
                java.sql.Date returnDate = resultSet.getDate("return_date");

                if (returnDate == null) {
                    throw new AssertionError(
                            "The service start date is null in juror_mod.pool for pool "
                                    + poolNumber + " and juror " + jurorNumber
                    );
                }

                if (resultSet.next()) {
                    throw new AssertionError(
                            "More than one active pool was found for juror " + jurorNumber
                    );
                }

                log.info(
                        "Found service start date " + returnDate
                                + " in pool " + poolNumber
                                + " for juror " + jurorNumber
                );

                return returnDate.toLocalDate();
            }
        }
    }

    private void verifyCard(
            WebElement card,
            String expectedHeading
    ) {
        wait.waitForDisplayedElement(card, 3);

        if (!card.isDisplayed()) {
            throw new AssertionError(
                    expectedHeading + " card is not displayed"
            );
        }

        String actualHeading = card
                .findElement(By.cssSelector(".card__heading"))
                .getText()
                .trim();

        if (!actualHeading.equals(expectedHeading)) {
            throw new AssertionError(
                    "Expected card heading '" + expectedHeading
                            + "' but found '" + actualHeading + "'"
            );
        }

        log.info("Saw " + expectedHeading + " card");
    }

    public void determineDigitalByDefaultResponseAndSelectAction() throws SQLException {
        NAV.waitForPageLoad();

        List<WebElement> buttons = driver.findElements(By.xpath("//a[text()[contains(.,'Start your response')]]"));

        if (!buttons.isEmpty() && buttons.get(0).isDisplayed()) {
            log.info("Start your response button is present and visible.");
            buttons.get(0).click();
            log.info("Clicked the Start your response button.");
        }
    }
    public void emailOrLetterOnDocumentsQueue(String jurorNo, String originalorCurrent, String emailorLetter) throws SQLException {

        switch (originalorCurrent) {
            case "original":
                WebElement originalSentByForJuror = driver.findElement(By.xpath("//*[contains(./@id, 'originalSentBy')] [contains(./@id, '" + jurorNo + "')]/strong"));
                String actualOriginalSentBy = originalSentByForJuror.getText();
                assertEquals(actualOriginalSentBy,emailorLetter);
                break;
            case "current":
                WebElement currentPreferenceForJuror = driver.findElement(By.xpath("//*[contains(./@id, 'currentPreference')] [contains(./@id, '" + jurorNo + "')]/strong"));
                String actualCurrentPreference = currentPreferenceForJuror.getText();
                assertEquals(actualCurrentPreference,emailorLetter);
                break;
        }

        }

        public String getAttendanceDate() {
            log.info("Getting court name");
            return attendanceDate.getText().substring(0, attendanceDate.getText().length() - 8);
        }

    public void clickSecondLossOfEarningsLink() {
        wait.waitForClickableElement(lossOfEarningsTwoDetails, 10);
        lossOfEarningsTwoDetails.click();
        log.info("Clicked the second loss of earnings link");
    }

}
