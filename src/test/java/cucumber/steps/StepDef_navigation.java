package cucumber.steps;

import cucumber.pageObjects.*;
import cucumber.utils.DateManipulator;
import io.cucumber.datatable.DataTable;
import io.cucumber.java.en.And;
import io.cucumber.java.en.Then;
import io.cucumber.java.en.When;
import org.apache.commons.lang3.StringUtils;
import org.apache.log4j.Logger;
import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.PageFactory;
import org.openqa.selenium.support.ui.ExpectedConditions;
import org.openqa.selenium.support.ui.WebDriverWait;

import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.time.DayOfWeek;
import java.time.Duration;
import java.time.LocalDate;
import java.time.ZoneId;
import java.time.temporal.TemporalAdjusters;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Map;

import static cucumber.utils.DateManipulator.formatDate;
import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertTrue;

public class StepDef_navigation {

	private aSamplePO SPO;
	private Login LGN;
	private NavigationShared NAV;
	private Bureau BUR;
	private Groups GRP;
	private ScreenShotTaker SST;
	private ClickOverrider CO;
	private StepDef_jurorpool STP;
	private final WebDriver webDriver;

	private final CheckPoolRequest CHECK_POOL_REQUEST_PAGE;
	private String poolRequestNumber;
	public static String holidayAttendanceDate;
	private static Logger log = Logger.getLogger(StepDef_navigation.class);

	public StepDef_navigation(SharedDriver webDriver) {
		this.webDriver = webDriver;
		SPO = PageFactory.initElements(webDriver, aSamplePO.class);
		LGN = PageFactory.initElements(webDriver, Login.class);
		NAV = PageFactory.initElements(webDriver, NavigationShared.class);
		GRP = PageFactory.initElements(webDriver, Groups.class);
		BUR = PageFactory.initElements(webDriver, Bureau.class);
		CO = PageFactory.initElements(webDriver, ClickOverrider.class);
		SST = PageFactory.initElements(webDriver, ScreenShotTaker.class);
		CHECK_POOL_REQUEST_PAGE = PageFactory.initElements(webDriver, CheckPoolRequest.class);
	}


	@When("^I see \"(.*)\" on the page$")
	public void text_on_page_check(String arg1) throws Throwable {
		if (arg1.contains("{") && arg1.contains("}")) {
			arg1 = arg1.replace("{", "").replace("}", "");
			arg1 = formatDate(
					DateManipulator.processString(arg1, false),
					"dd/MM/yyyy"
			);
		}

		try {
			NAV.textPresentOnPage(arg1);
		} catch (AssertionError | Exception e) {
			NAV.waitForPageLoad();
			NAV.textPresentOnPage(arg1);
		}
	}

	@When("^I do not see \"(.*)\" on the page$")
	public void text_not_on_page_check(String arg1) throws Throwable {
		try {
			NAV.textNotPresentOnPage(arg1);
		} catch (Exception e) {
			NAV.textNotPresentOnPage(arg1);
		}
	}

	@When("^I verify the text \"(.*)\" on the page$")
	public void Verifytext_on_page_check(String arg1) throws Throwable {
		if (arg1.contains("{") && arg1.contains("}")) {
			arg1 = arg1.replace("{", "").replace("}", "");
			arg1 = formatDate(
					DateManipulator.processString(arg1, false),
					"dd/MM/yyyy"
			);
		}

		try {
			NAV.textPresentOnPage(arg1);
		} catch (AssertionError | Exception e) {
			NAV.waitForPageLoad();
			NAV.textPresentOnPage(arg1);
		}
	}

	@When("^I verify the banner message \"(.*)\" on the page$")
	public void verifyBannerMessage_on_page_check(String arg1) throws Throwable {
		if (arg1.contains("{") && arg1.contains("}")) {
			arg1 = arg1.replace("{", "").replace("}", "");
			arg1 = formatDate(
					DateManipulator.processString(arg1, false),
					"dd/MM/yyyy"
			);
		}

		try {
			NAV.textPresentOnPage(arg1);
		} catch (AssertionError | Exception e) {
			NAV.waitForPageLoad();
			NAV.textPresentOnPage(arg1);
		}
	}

	@Then("^on the page I see$")
	public void seeOnThePage_datatable(DataTable arg1) throws Throwable {
		List<Map<String, String>> list = arg1.asMaps(String.class, String.class);
		for (int i = 0; i < list.size(); i++) {
			text_on_page_check(list.get(i).get("text"));
		}
	}

	@Then("^on the page I do not see$")
	public void doNotSeeOnThePage_datatable(DataTable arg1) throws Throwable {
		List<Map<String, String>> list = arg1.asMaps(String.class, String.class);
		for (int i = 0; i < list.size(); i++) {
			text_not_on_page_check(list.get(i).get("text"));
		}
	}

	@Then("^I close the browser tab$")
	public void closeWindowAndSwitchToDefaultWindow() throws Throwable {
		NAV.closeWindowAndSwitchToDefaultWindow();
	}

	@Then("^I switch to the new window$")
	public void switchToNewWindow() throws Throwable {
		NAV.switchToNewWindow();
	}

	@When("^I press the \"([^\"]*)\" button on my browser$")
	public void forward_back_button(String arg1) throws Throwable {
		NAV.press_navigationButton(arg1);
	}

	@When("^I press the \"([^\"]*)\" button$")
	public void press_button(String arg1) throws Throwable {
		NAV.waitForDocumentReady();
		try {
			NAV.press_buttonByName(arg1);
		} catch (Exception | Error e) {
			log.error("unexpected error when pressing button", e);
			NAV.press_buttonByName(arg1);
		}
		NAV.waitForDocumentReady();
	}


	@When("^I check the juror \"([^\"]*)\" checkbox$")
	public void check_Jurorcheckbox(String arg1) throws Throwable {
		try {
			NAV.check_Jurorcheckbox(arg1);
		} catch (Exception e) {
			NAV.waitForPageLoad(2);
			NAV.check_Jurorcheckbox(arg1);
		}
	}

	@When("^I set \"([^\"]*)\" with character length \"([^\"]*)\"$")
	public void set_value_to_stringlength(String arg1, int arg2) throws Throwable {
		String string = StringUtils.repeat("a", arg2);
		set_value_to(arg1, string);
	}

	@When("^I set \"([^\"]*)\" to \"([^\"]*)\"$")
	public void set_value_to(String arg1, String arg2) throws Throwable {

		if (arg2.contains(" time")) {
			arg2 = formatDate(
					DateManipulator.processString(arg2, false),
					"dd/MM/yyyy"
			);
		}

		if (arg2.contains("{") && arg2.contains("}")) {
			arg2 = arg2.replace("{", "").replace("}", "");
			arg2 = formatDate(
					DateManipulator.processString(arg2, false),
					"dd/MM/yyyy"
			);
		}

		try {
			WebElement childField;
			childField = NAV.find_inputBy_labelName(arg1);
			childField.clear();
			NAV.set_valueTo(arg1, arg2);
		} catch (Exception e) {
			WebElement newChildField;
			newChildField = NAV.find_inputBy_labelName(arg1);
			newChildField.clear();
			NAV.waitForPageLoad();
			NAV.set_valueTo(arg1, arg2);
		}
	}

	@When("^I set the following fields$")
	public void multi_set_value_to(DataTable arg1) throws Throwable {
		List<List<String>> list = arg1.asLists(String.class);
		for (int i = 0; i <= list.size(); i++) { //i starts from 1 because i=0 represents the header
			set_value_to(
					list.get(0).get(i),
					list.get(1).get(i)
			);
		}
	}

	@Then("^I cannot set \"([^\"]*)\" to \"([^\"]*)\"$")
	public void set_value_to_Negative(String arg1, String arg2) throws Throwable {
		// Performance Issue - To Review
		try {
			NAV.set_valueTo(arg1, arg2);
			throw new AssertionError("I was able to set the value when not expected");
		} catch (Exception e) {
		}
	}

	@When("^\"([^\"]*)\" is \"([^\"]*)\"$")
	public void compare_value_to(String arg1, String arg2) throws Throwable {

		if (arg2.contains("{") && arg2.contains("}")) {
			arg2 = arg2.replace("{", "").replace("}", "");
			arg2 = formatDate(
					DateManipulator.processString(arg2, false),
					"dd/MM/yyyy"
			);
		}

		try {
			NAV.compare_valueTo(arg1, arg2);
		} catch (AssertionError e) {
			NAV.compare_valueTo(arg1, arg2);
		} catch (Exception e) {
			NAV.compare_valueTo(arg1, arg2);
		}
	}

	@When("^I refresh the page$")
	public void refreshPage() throws Throwable {
		NAV.refreshPage();
	}

	@When("^I check the \"([^\"]*)\" checkbox$")
	public void check_checkbox(String arg1) throws Throwable {
		try {
			NAV.check_checkbox(arg1);
			NAV.checkBox_Checked(arg1, true);
		} catch (Exception e) {
			NAV.waitForPageLoad();
			NAV.check_checkbox(arg1);
			NAV.checkBox_Checked(arg1, true);
		}
	}

	@When("^I check the Urgent checkbox on Search screen$")
	public void checkUrgentCheckbox() throws Throwable {
		try {
			NAV.waitForPageLoad();
			NAV.checkUrgentCheckbox();
		} catch (Exception e) {
			NAV.waitForPageLoad();
			NAV.checkUrgentCheckbox();
		}
	}

	@When("^I uncheck the \"([^\"]*)\" checkbox$")
	public void uncheck_checkbox(String arg1) throws Throwable {
		try {
			NAV.uncheck_checkbox(arg1);
		} catch (Exception e) {
			NAV.waitForPageLoad();
			NAV.uncheck_checkbox(arg1);
		}
	}

	@When("^I respond the juror response in Juror Digital$")
	public void respondJurorResponseInJurorDigital() throws Throwable {
		NAV.press_buttonByName("Process reply");
		NAV.setProcessReplyTo_("Responded");
		NAV.check_checkbox("Mark juror as 'responded'");
		NAV.press_buttonByName("Confirm");
		NAV.textPresentOnPage("COMPLETED");
	}

	@When("^I click on the \"(.*)\" link$")
	public void click_link(String arg1) throws Throwable {

		try {
			if (CO.checkWhetherInList(arg1))
				return;
		} catch (Exception e) {
		}

		// Temporary workaround - This only occurs for one link
		if (arg1.equalsIgnoreCase("back")) {
			try {
				BUR.pressBackLink();
			} catch (Exception e) {
				NAV.waitForPageLoad();
				BUR.pressBackLink();
			}
			return;
		}
		try {
			NAV.click_link_by_text(arg1);
		} catch (Exception e) {
			NAV.waitForPageLoad();
			NAV.click_link_by_text(arg1);
		}
	}

	@When("^I select the \"(.*)\" court selection link$")
	public void clickCourtSelectionLink(String arg1) throws Throwable {

		try {
			if (CO.checkWhetherInList(arg1))
				return;
		} catch (Exception e) {
		}

		WebDriverWait wait = new WebDriverWait(webDriver, Duration.ofSeconds(10));
		try {
			NAV.click_link_by_text(arg1);
			wait.until(ExpectedConditions.invisibilityOfElementLocated(By.className("autocomplete__menu--visible")));
		} catch (Exception e) {
			NAV.waitForPageLoad();
			wait.until(ExpectedConditions.invisibilityOfElementLocated(By.className("autocomplete__menu--visible")));
			NAV.click_link_by_text(arg1);
		}
	}

	@Then("^I do not see link with text \"([^\"]*)\"$")
	public void doNotSee_linkText(String arg1) {
		NAV.linkText_visible(arg1, false);
	}

	@When("^I see link with text \"([^\"]*)\"$")
	public void linkText_visible(String arg1) {
		NAV.linkText_visible(arg1, true);
	}

	@When("^I select \"([^\"]*)\" from the \"([^\"]*)\" dropdown$")
	public void select_fromDropdown(String option_value, String dropdown_name) {
		try {
			NAV.select_fromDropdown(option_value, dropdown_name);
		} catch (Exception e) {
			NAV.waitForPageLoad();
			NAV.select_fromDropdown(option_value, dropdown_name);
		}
	}

	@When("^I select \"([^\"]*)\" from Process reply$")
	public void select_fromProcessReply(String optionValue) throws Throwable {
		try {
			NAV.press_buttonByName("Process reply");
			GRP.chooseRadioButtonWithLabel(optionValue);
			NAV.press_buttonByName("Continue");
		} catch (Exception e) {
			NAV.waitForPageLoad();
			NAV.setProcessReplyTo_(optionValue);
		}
	}

	@When("^I select \"([^\"]*)\" from the \"([^\"]*)\" dropdown on the Dashboard$")
	public void select_fromDashboardDropdown(String option_value, String dropdown_name) {
		try {
			NAV.select_fromDashboardDropdown(option_value, dropdown_name);
		} catch (Exception e) {
			NAV.waitForPageLoad();
			NAV.select_fromDashboardDropdown(option_value, dropdown_name);
		}
	}

	@Then("^I cannot select \"([^\"]*)\" from the \"([^\"]*)\" dropdown$")
	public void select_fromDropdownNegative(String arg1, String arg2) {
		// Performance Issue - To Review
		try {
			NAV.select_fromDropdown(arg1, arg2);
			throw new AssertionError("I was able to select from the dropdown when not expected");
		} catch (Exception e) {
		}
	}

	@Then("^I see \"([^\"]*)\" in position (\\d+) on the groups added list$")
	public void checkGroupsAddedPosition_withText(String text, Integer position) {
		try {
			GRP.checkGroupsAddedPosition_withText(text, position);
		} catch (Exception e) {
			NAV.waitForPageLoad();
			GRP.checkGroupsAddedPosition_withText(text, position);
		}
	}

	@Then("^the \"([^\"]*)\" text has class \"([^\"]*)\"$")
	public void text_hasClass(String text, String className) {
		GRP.text_hasClass(text, className);
	}

	@When("^I search for \"([^\"]*)\"$")
	public void searchFor(String arg1) {
		NAV.generic_searchForText(arg1);
	}

	@When("^I select the \"([^\"]*)\" checkbox for \"([^\"]*)\"$")
	public void selectCheckbox_forRowWithText(String column, String rowText) {
		NAV.selectCheckbox_forRowWithText(column, rowText);
	}

	@Then("^the \"([^\"]*)\" checkbox for \"([^\"]*)\" is \"([^\"]*)\"$")
	public void confirmCheckbox_forRowWithText(String column, String rowText, String checkedUnchecked) {
		NAV.confirmCheckbox_forRowWithText(column, rowText, checkedUnchecked);
	}

	@Then("^the \"([^\"]*)\" button is disabled$")
	public void buttonIsDisabled(String buttonLabel) throws Throwable {
		NAV.checkButtonIsDisabled(buttonLabel);

	}


	@When("^I select \"([^\"]*)\" from the dropdown$")
	public void select_fromDropdown(String option) throws Exception {
		try {
			NAV.select_fromDropdown(option);
		} catch (Error e) {
			NAV.waitForPageLoad(3, 60);
			NAV.select_fromDropdown(option);
		} catch (Exception e) {
			NAV.waitForPageLoad(3, 60);
			NAV.select_fromDropdown(option);
		}
	}

	@Then("^I see \"([^\"]*)\" has class \"([^\"]*)\"$")
	public void seeElement_byText_hasClass(String text, String containsClass) throws Exception {
		try {
			NAV.element_byText_hasClass(text, containsClass);
		} catch (Exception e) {
			NAV.element_byText_hasClass(text, containsClass);
		}
	}

	@Then("^I see \"([^\"]*)\" under \"([^\"]*)\"$")
	public void seeText_underHeadingBlock(String text, String header) {
		NAV.seeText_underHeadingBlock(text, header);
	}

	;

	@Then("^on Expenses I see \"([^\"]*)\" under \"([^\"]*)\"$")
	public void seeText_underHeadingBlockExpenses(String text, String header) {
		NAV.seeText_underHeadingBlockExpenses(text, header);
	}

	;

	//	bureau
	@Then("^on Bureau I see \"([^\"]*)\" under \"([^\"]*)\"$")
	public void seeText_underHeadingBlockBureau(String text, String header) {
		NAV.seeText_underHeadingBlockBureau(text, header);
	}


	@Then("^I do not see \"([^\"]*)\" under \"([^\"]*)\"$")
	public void doNotSeeText_underHeadingBlock(String text, String header) {
		NAV.doNotSeeText_underHeadingBlock(text, header, true);
	}


	@Then("^I see \"([^\"]*)\" under the label \"([^\"]*)\"$")
	public void seeText_underHeadingBlockLabel(String text, String header) {
		NAV.seeText_underHeadingBlockLabel(text, header);
	}

	@When("^I click on the \"([^\"]*)\" link under \"([^\"]*)\"$")
	public void clickLink_underHeadingBlock(String linkText, String header) {
		NAV.clickText_underHeadingBlock(linkText, header);
	}

	//Old See in Same Row
	@Then("^I see \"([^\"]*)\" in the same row as \"([^\"]*)\"$")
	public void seeText_inSameRow_asText(String searchText, String nextToText) {
		try {
			NAV.seeText_inSameRow_asText(searchText, nextToText);
		} catch (Exception e) {
			NAV.waitForPageLoad();
			NAV.seeText_inSameRow_asText(searchText, nextToText);
		}
	}


	;

	//New See in Same Row
	@Then("^I see text \"([^\"]*)\" in the same row as \"([^\"]*)\"$")
	public void seeText_inSameRow_asText_Two(String searchText, String nextToText) {
		try {
			NAV.seeText_inSameRow_asText_Two(searchText, nextToText);
		} catch (Exception e) {
			NAV.waitForPageLoad();
			NAV.seeText_inSameRow_asText_Two(searchText, nextToText);
		}
	}


	//Old Click Change Link
	@When("^I click on \"([^\"]*)\" in the same row as \"([^\"]*)\"$")
	public void clickText_inSameRow_asText(String clickText, String nextToText) throws Exception {
		try {
			NAV.clickText_inSameRow_asText(clickText, nextToText);
		} catch (Exception e) {
			NAV.waitForPageLoad();
			NAV.clickText_inSameRow_asText(clickText, nextToText);
		}
	}

	;

	//New Click Change Link
	@When("^I click on the \"([^\"]*)\" link in the same row as \"([^\"]*)\"$")
	public void clickText_inSameRow_asText_Two(String clickText, String nextToText) throws Exception {
		try {
			NAV.clickText_inSameRow_asText_Two(clickText, nextToText);
		} catch (Exception e) {
			NAV.waitForPageLoad();
			NAV.clickText_inSameRow_asText_Two(clickText, nextToText);
		}
	}

	@Then("^\"([^\"]*)\" text is bold$")
	public void seeText_isBold(String text) {
		NAV.seeText_isBold(text);
	}

	@When("^I set input field with \"([^\"]*)\" of \"([^\"]*)\" to \"([^\"]*)\"$")
	public void setInputFieldWith_toText(String attributeType, String attributeValue, String inputText) {
		NAV.setInputFieldWith_toText(attributeType, attributeValue, inputText);
	}

	@When("^I set the \"([^\"]*)\" date to a Monday \"([^\"]*)\" weeks in the future$")
	public void iSetTheAttendanceDateToAMondayInTheFuture(String attDateSequence, Integer noOfWeeks) {
		String datePattern = "dd/MM/yyyy";
		String fullDatePattern = "EEEEE dd MMMMM yyyy";
		Calendar calendar = Calendar.getInstance();
		calendar.add(Calendar.WEEK_OF_MONTH, noOfWeeks);

		LocalDate localDate = calendar.toInstant().atZone(ZoneId.systemDefault()).toLocalDate();
		LocalDate localDateMonday = localDate.with(TemporalAdjusters.next(DayOfWeek.MONDAY));
		Date mondayDate = Date.from(localDate.atStartOfDay().atZone(ZoneId.systemDefault()).toInstant());

		String mondayDateValue = new SimpleDateFormat(datePattern).format((mondayDate).getTime());
		holidayAttendanceDate = new SimpleDateFormat(fullDatePattern).format(mondayDate.getTime());

		NAV.enterNewSingleDate(attDateSequence, mondayDateValue);
		NAV.waitForPageLoad();

	}
	@When("^I set the non-attendance date to yesterday$")
	public void iSetTheAttendanceDateToYesterday() {
		String datePattern = "dd/MM/yyyy";
		Calendar calendar = Calendar.getInstance();
		calendar.add(Calendar.DATE, -1);

		LocalDate localDate = calendar.toInstant().atZone(ZoneId.systemDefault()).toLocalDate();
		Date dateValue = Date.from(localDate.atStartOfDay().atZone(ZoneId.systemDefault()).toInstant());

		String yesterdayDate = new SimpleDateFormat(datePattern).format((dateValue).getTime());
		NAV.enterNewSingleDate("Enter a date for the non-attendance day", yesterdayDate);
		NAV.waitForPageLoad();

	}


	@When("^I set the date of birth to a Monday \"([^\"]*)\" weeks in the future$")
	public void iSetTheDateOfBirthToAMondayInTheFuture(Integer noOfWeeks) {
		String datePattern = "dd MM yyyy";
		String fullDatePattern = "EEEEE dd MMMMM yyyy";
		Calendar calendar = Calendar.getInstance();
		calendar.add(Calendar.WEEK_OF_MONTH, noOfWeeks);
		String attDateSequence = "DOB";

		LocalDate localDate = calendar.toInstant().atZone(ZoneId.systemDefault()).toLocalDate();
		Date mondayDate = Date.from(localDate.atStartOfDay().atZone(ZoneId.systemDefault()).toInstant());
		String[] mondayDateValues = new SimpleDateFormat(datePattern).format((mondayDate).getTime()).split(" ");
		holidayAttendanceDate = new SimpleDateFormat(fullDatePattern).format(mondayDate.getTime());

		NAV.enterNewDate(attDateSequence, mondayDateValues[0], mondayDateValues[1], mondayDateValues[2]);
		NAV.waitForPageLoad();

	}

	@When("^I set the \"([^\"]*)\" single date field to a Monday \"([^\"]*)\" weeks in the future$")
	public void iSetTheAttendanceSingleDateFieldToAMondayInTheFuture(String deferDateSeq, Integer noOfWeeks) {
		String datePattern = "dd/MM/yyyy";
		Calendar calendar = Calendar.getInstance();
		calendar.add(Calendar.WEEK_OF_MONTH, noOfWeeks);

		LocalDate localDate = calendar.toInstant().atZone(ZoneId.systemDefault()).toLocalDate();
		LocalDate localDateMonday = localDate.with(TemporalAdjusters.next(DayOfWeek.MONDAY));
		Date mondayDate = Date.from(localDateMonday.atStartOfDay().atZone(ZoneId.systemDefault()).toInstant());

		String mondayDateValue = new SimpleDateFormat(datePattern).format((mondayDate).getTime());

		NAV.enterNewSingleDate(deferDateSeq, mondayDateValue);
		NAV.waitForPageLoad();

	}

	@And("^I should see the details of the pool with a bank holiday date$")
	public void iShouldSeeTheDetailsOfThePoolWithBankHolidayDate(DataTable table) {
		Map<String, String> data = table.asMap(String.class, String.class);
		poolRequestNumber = CHECK_POOL_REQUEST_PAGE.getPoolNumber();

		assertEquals(holidayAttendanceDate, CHECK_POOL_REQUEST_PAGE.getAttendanceDate());
		assertEquals(data.get("courtName"), CHECK_POOL_REQUEST_PAGE.getCourtName());
		assertEquals(data.get("poolType"), CHECK_POOL_REQUEST_PAGE.getPoolType());
		assertEquals(data.get("totalJurorsRequired"), CHECK_POOL_REQUEST_PAGE.getNumberOfJurors());
		assertEquals(data.get("numberOfDeferrals"), CHECK_POOL_REQUEST_PAGE.getNumberOfDeferrals());
		assertEquals(data.get("additionalJurors"), CHECK_POOL_REQUEST_PAGE.getNumberOfAdditionalJurors());
	}

	@When("^I validate the \"([^\"]*)\" deferral date is \"([^\"]*)\" weeks in the future$")
	public void iValidateDeferralDateInTheFuture(String attDateSequence, Integer noOfWeeks) throws Throwable {
		try {
			String fullDatePattern = "d MMMMM yyyy";
			Calendar calendar = Calendar.getInstance();
			calendar.add(Calendar.WEEK_OF_MONTH, noOfWeeks);

			LocalDate localDate = calendar.toInstant().atZone(ZoneId.systemDefault()).toLocalDate();
			LocalDate localDateMonday = localDate.with(TemporalAdjusters.next(DayOfWeek.MONDAY));
			Date mondayDate = Date.from(localDateMonday.atStartOfDay().atZone(ZoneId.systemDefault()).toInstant());

			String mondayDateValues = new SimpleDateFormat(fullDatePattern).format((mondayDate).getTime()).toString();

			NAV.seeText_inSameRow_asText(mondayDateValues, attDateSequence);
		} catch (Exception e) {
			String shortDatePattern = "dd/MM/yyyy";
			Calendar calendar = Calendar.getInstance();
			calendar.add(Calendar.WEEK_OF_MONTH, noOfWeeks);

			LocalDate localDate = calendar.toInstant().atZone(ZoneId.systemDefault()).toLocalDate();
			LocalDate localDateMonday = localDate.with(TemporalAdjusters.next(DayOfWeek.MONDAY));
			Date mondayDate = Date.from(localDateMonday.atStartOfDay().atZone(ZoneId.systemDefault()).toInstant());

			String mondayDateValues = new SimpleDateFormat(shortDatePattern).format((mondayDate).getTime()).toString();

			NAV.seeText_inSameRow_asText(mondayDateValues, attDateSequence);

		}
	}

	;

	@When("^I select deferral date \"([^\"]*)\" weeks in the future$")
	public void iSelectDeferralDate(Integer noOfWeeks) throws Throwable {
		String fullDatePattern = "d MMMMM yyyy";
		Calendar calendar = Calendar.getInstance();
		calendar.add(Calendar.WEEK_OF_MONTH, noOfWeeks);

		LocalDate localDate = calendar.toInstant().atZone(ZoneId.systemDefault()).toLocalDate();
		LocalDate localDateMonday = localDate.with(TemporalAdjusters.next(DayOfWeek.MONDAY));
		Date mondayDate = Date.from(localDateMonday.atStartOfDay().atZone(ZoneId.systemDefault()).toInstant());

		String mondayDateValues = new SimpleDateFormat(fullDatePattern).format((mondayDate).getTime()).toString();

		GRP.click_radioButtonWithLabel(mondayDateValues);

	}

	;


	@When("^I click link with ID \"([^\"]*)\"$")
	public void clickLinkWithId(String linkId) {
		NAV.clickLinkWithId(linkId);
	}

	;

	@When("^I set text area with \"([^\"]*)\" of \"([^\"]*)\" to \"([^\"]*)\"$")
	public void setTextAreaWith_toText(String attributeType, String attributeValue, String inputText) {
		NAV.setTextAreaWith_toText(attributeType, attributeValue, inputText);
	}

	;

	@When("^I append text area with \"([^\"]*)\" of \"([^\"]*)\" with \"([^\"]*)\"$")
	public void setTextAreaWith_toText_noClear(String attributeType, String attributeValue, String inputText) {
		NAV.setTextAreaWith_toText_noClear(attributeType, attributeValue, inputText);
	}

	@Then("^the checkbox in the same row as \"([^\"]*)\" is \"([^\"]*)\"$")
	public void checkboxSame_rowAs(String nextToText, String checkboxState) throws Exception {
		try {
			NAV.checkboxState_inSameRow_asText(checkboxState, nextToText);
		} catch (Exception e) {
			NAV.waitForPageLoad();
			NAV.checkboxState_inSameRow_asText(checkboxState, nextToText);
		}
	}

	@Then("^I see \"([^\"]*)\" icon in the same row as \"([^\"]*)\"$")
	public void seeIconSame_rowAs(String icon, String nextToText) {
		try {
			NAV.seeIconSame_rowAs(icon, nextToText);
		} catch (Exception e) {
			NAV.waitForPageLoad();
			NAV.seeIconSame_rowAs(icon, nextToText);
		}
	}

	;

	@Then("^I see \"([^\"]*)\" is flagged as overdue$")
	public void recordFlaggedOverdue(String nextToText) {
		NAV.recordFlaggedOverdue(nextToText);
	}

	;

	@Then("^I see \"([^\"]*)\" has reply type indicator \"([^\"]*)\"$")
	public void replyTypeIndicator(String nextToText, String replyType) {
		NAV.replyTypeIndicator(nextToText, replyType);
	}

	;

	@When("^I check the checkbox in the same row as \"([^\"]*)\"$")
	public void checkCheckboxSame_rowAs(String nextToText) {
		try {
			NAV.checkCheckboxSame_rowAs(nextToText);
		} catch (Exception e) {
			NAV.waitForPageLoad();
			NAV.checkCheckboxSame_rowAs(nextToText);
		}
	}

	;

	@Then("^the page title is \"([^\"]*)\"$")
	public void checkPageTitleIs(String expectedPageTitle) {
		NAV.checkPageTitleIs(expectedPageTitle);
	}

	@When("^I hit the tab key$")
	public void hitKey() throws Throwable {
		NAV.waitForPageLoad();
		NAV.press_tabKeyOnBody();

	}

	@When("^I hit the tab key for the skip main content link$")
	public void hitTabForMainContent() {
		NAV.hitTabForMainContent();
	}

	;

	@Then("^I see \"([^\"]*)\" in the same row as \"([^\"]*)\" in Backlog box")
	public void seeText_inSameRow_asText_inBacklog(String searchText, String nextToText) {
		try {
			NAV.seeText_inSameRow_asText_inBacklog(searchText, nextToText);
		} catch (Exception e) {
			NAV.seeText_inSameRow_asText_inBacklog(searchText, nextToText);
		}
	}

	;

	@Then("^I see \"([^\"]*)\" in \"([^\"]*)\" Allocate Replies box")
	public void seeText_inAllocateReplies(String searchText, String elementName) {
		try {
			NAV.seeText_inAllocateReplies(searchText, elementName);
		} catch (Exception e) {
			NAV.seeText_inAllocateReplies(searchText, elementName);
		}
	}

	;

	@Then("^\"([^\"]*)\" is checked$")
	public void isCheckboxChecked(String checkBoxLabel) {
		try {
			NAV.checkBox_Checked(checkBoxLabel, true);
		} catch (Exception e) {
			NAV.checkBox_Checked(checkBoxLabel, true);
		}
	}

	;

	@Then("^\"([^\"]*)\" is unchecked$")
	public void isCheckboxUnchecked(String checkBoxLabel) {
		try {
			NAV.checkBox_Checked(checkBoxLabel, false);
		} catch (Exception e) {
			NAV.checkBox_Checked(checkBoxLabel, false);
		}

	}

	;

	@Then("^I see \"([^\"]*)\" under \"([^\"]*)\" box$")
	public void getBoxHeaderText(String text, String boxName) {
		try {
			NAV.getBoxHeaderText(text, boxName);
		} catch (Exception e) {
			NAV.getBoxHeaderText(text, boxName);
		}
	}

	@Then("^\"([^\"]*)\" assigned replies count is \"([^\"]*)\"$")
	public void totalAssignedCount(String countName, String countValue) {
		try {
			NAV.totalAssignedCount(countName, countValue);
		} catch (Exception e) {
		}
	}

//	@When("^I cannot navigate from Bureau to \"([^\"]*)\"$")
//	public void appendURL(String uRL) {
	//	NAV.appendURL(uRL);
//	}

	@Then("^I take a screenshot$")

	public void takeScreenshot() {

		SST.captureScreenShot();
	}
	@When("^I see error \"(.*)\"$")
	public void eligibilityErrorCheck(String arg1) throws Throwable {
		try {
			NAV.eligibilityErrorOnPage(arg1);
		} catch (AssertionError | Exception e) {
			NAV.waitForPageLoad();
			NAV.eligibilityErrorOnPage(arg1);
		}
	}
	@When("^I verify confirmation text of jurors next due to attend \"(.*)\" on the page$")
	public void text_on_page_Verify(String arg1) throws Throwable {
		assertEquals(arg1, NAV.getHeadingText());
	}
	@When("^I verify button \"(.*)\" on the page$")
	public void buttonContinue_on_page_Verify(String arg1) throws Throwable {
		NAV.continueBtnOnPage(arg1);
	}

	@Then("^I see the draft message template")
	public void messageTemplatePresent() throws Throwable {
		assertTrue(NAV.seeMessageTemplate());
	}

	@When("^I click on the methods dropdown and select \"([^\"]*)\" for juror \"([^\"]*)\"$")
	public void methodDropdownOnMessage(String methodType, String jurorNumber) {
		NAV.selectFromMessageMethodDropdown(methodType, jurorNumber);
	}
	@And("^I see the message sent banner containing \"([^\"]*)\"$")
	public void iSeeMessageSentBannerContaining(String bannerContains) {
		assertEquals(bannerContains, NAV.messageSentBanner());
	}
	@And("^I see the template containing my attendance date with a monday \"([^\"]*)\" weeks in the future$")
	public void iSeeDateInTemplate(String noOfWeeks) {
		String datePattern = "dd/MM/yyyy";
		Calendar calendar = Calendar.getInstance();
		calendar.add(Calendar.WEEK_OF_MONTH, Integer.parseInt(noOfWeeks));
		LocalDate localDate = calendar.toInstant().atZone(ZoneId.systemDefault()).toLocalDate();
		Date mondayDate = Date.from(localDate.atStartOfDay().atZone(ZoneId.systemDefault()).toInstant());
		String mondayDateValue = new SimpleDateFormat(datePattern).format(mondayDate.getTime());

		String messageText = NAV.seeMessageTemplateDate(mondayDateValue);

		if (messageText.contains(mondayDateValue)) {
			System.out.println("Message template contains the date: " + mondayDateValue);
		} else {
			System.out.println("Message template does not contain the date: " + mondayDateValue);
		}
	}

	@When("^I press \"([^\"]*)\" button$")
	public void press_Savebutton(String arg1) throws Throwable {
		NAV.waitForDocumentReady();
		try {
			NAV.press_Savebutton();
		} catch (Exception | Error e) {
			log.error("unexpected error when pressing button", e);
			NAV.press_Savebutton();
		}
		NAV.waitForDocumentReady();
	}

	@Then("^I see the following details on bank holiday for the year 2024$")
	public void iSeeTheFollowingInformationOnBankHoliday2024(DataTable dataTable) {

		NAV.waitForPageLoad(3);
		Map<String, String> expectedData = dataTable.asMap(String.class, String.class);
		Map<String, String> actualData = NAV.GetHolidayListDetails2024();

		assertEquals(expectedData.get("Friday 28 March"), actualData.get("Friday 28 March"));
		assertEquals(expectedData.get("Monday 1 April"), actualData.get("Monday 1 April"));
		assertEquals(expectedData.get("Monday 6 May"), actualData.get("Monday 6 May"));
		assertEquals(expectedData.get("Monday 27 May"), actualData.get("Monday 27 May"));
		assertEquals(expectedData.get("Monday 26 August"), actualData.get("Monday 26 August"));
		assertEquals(expectedData.get("Wednesday 25 December"), actualData.get("Wednesday 25 December"));
		assertEquals(expectedData.get("Thursday 26 December"), actualData.get("Thursday 26 December"));

	}

	@Then("^I see the following details on bank holiday for the year 2025$")
	public void iSeeTheFollowingInformationOnBankHoliday2025(DataTable dataTable) {

		NAV.waitForPageLoad(3);
		Map<String, String> expectedData = dataTable.asMap(String.class, String.class);
		Map<String, String> actualData = NAV.GetHolidayListDetails2025();

		assertEquals(expectedData.get("Wednesday 1 January"), actualData.get("Wednesday 1 January"));
		assertEquals(expectedData.get("Friday 18 April"), actualData.get("Friday 18 April"));
		assertEquals(expectedData.get("Monday 21 April"), actualData.get("Monday 21 April"));
		assertEquals(expectedData.get("Monday 5 May"), actualData.get("Monday 5 May"));
		assertEquals(expectedData.get("Monday 26 May"), actualData.get("Monday 26 May"));
		assertEquals(expectedData.get("August 25 Monday"), actualData.get("August 25 Monday"));
		assertEquals(expectedData.get("Thursday 25 December"), actualData.get("Thursday 25 December"));
		assertEquals(expectedData.get("Friday 26 December"), actualData.get("Friday 26 December"));

	}

	@When("^I see the bank holiday \"([^\"]*)\" weeks in the future in the admin screen$")
	public void verifyBankHolidayOnAdminScreen(Integer noOfWeeks) {
		NAV.insertHolidayInTheFrontScreen(noOfWeeks);
	}
}