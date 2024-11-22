package cucumber.pageObjects;

import com.google.common.base.Verify;
import cucumber.utils.AngularJsHTTPCallWait;
import cucumber.utils.WaitUtil_v2;
import cucumber.utils.WaitUtils;
import org.apache.log4j.Logger;
import org.junit.Assert;
import org.openqa.selenium.*;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;

import java.util.Arrays;
import java.util.List;

public class Groups {
	private static WebDriver driver;
	private static Logger log = Logger.getLogger(Groups.class);
	private WaitUtils wait;
	private WaitUtil_v2 wait1;
	private AngularJsHTTPCallWait aJsWait;
	private NavigationShared NAV;


	public Groups(WebDriver driver) {
		Groups.driver = driver;
		PageFactory.initElements(driver, this);
		wait = new WaitUtils(driver);
		wait1 = new WaitUtil_v2(driver);
		aJsWait = new AngularJsHTTPCallWait(driver);
		NAV = new NavigationShared(driver);
	}

	@FindBy(id = "selectedGroupsTable")
	WebElement selectedGroupsTable;

	@FindBy(className = "govuk-footer__licence-description")
	WebElement govFooterNote;

	public void click_iconNextTo(String text) throws Exception {
		log.info("Going to select on icon next to text =>" + text);
		wait.activateImplicitWait();

		try {
			WebElement iconNextTo_text = driver.findElement(By.xpath(

					"//*[text()[contains(., \"" + text + "\")]]/..//*[contains(@class,'fa')]"
					//"//label[text()[contains(., '"+location_name+"')]]"))

			));

			iconNextTo_text.click();
		} catch (Exception e) {
			log.info("Could not see icon with text for =>" + text);
			throw new Exception("Could not find icon to click on - We werent being too specific either...");
		}
		wait.deactivateImplicitWait();
	}


	public Boolean text_inGroupAddedList(String expected_text) {
		WebElement groupsAdded = driver.findElement(By.id("selectedGroupsPanel"));
		Boolean textContained = false;

		try {
			String groupsAddedText = groupsAdded.getText();
			Assert.assertTrue("Text not found!", groupsAddedText.contains(expected_text));
		} catch (AssertionError e) {
			return false;
		}
		return true;
	}

	public void seeText_inGroupAddedList(String arg1) throws Exception {
		log.info("Going to check whether text is present in the group added list");
		if (text_inGroupAddedList(arg1) == true) {
			log.info("Saw text in group added list as expected, continuing");
			return;
		}
		throw new Exception("Did not see text in group as expected");
	}

	public void doNotSeeText_inGroupAddedList(String arg1) throws Exception {
		log.info("Going to check whether text is >not< present in the group added list");
		if (text_inGroupAddedList(arg1) == false) {
			log.info("Did not see text in group added list as expected, continuing");
			return;
		}
		throw new Exception("Saw text in group added list when not expected - Failing");
	}


	/**
	 * Returns the WebElement of the panel
	 *
	 * @param headerName
	 * @return
	 */
	public WebElement getPanel_byHeaderName(String headerName) {
		log.info("Looking for panel with headerName =>" + headerName);
		return driver.findElement(By.xpath(
				"//h3"
						+ "	[contains(@id, 'orgName') "
						+ "		and text()[contains(., '" + headerName + "')]"
						+ "	]/.."
		));
	}

	public void seeText_inPanelHeader(String headerName, String expectedText) {

		WebElement panel = getPanel_byHeaderName(headerName);
		Assert.assertTrue("Text not found!", panel.getText().contains(expectedText));

		log.info("Found =>" + expectedText + "<= in panel =>" + headerName + "<=");
	}


	public void click_inPanelHeader(String headerName, String linkText) {
		WebElement panel = getPanel_byHeaderName(headerName);

		panel.findElement(By.linkText(linkText)).click();
		log.info("Clicked on linktext =>" + linkText + "<= successfully");

	}

	public Integer groupsPosition_byText(String text) {
		log.info("Check Position of groups by text =>" + text);

		WebElement textElement = driver.findElement(By.xpath("//table[@id='selectedGroupsTable']//td[contains(text(),'" + text + "')]"));
		List<String> strList = Arrays.asList(textElement.getAttribute("id").split("-"));

		log.info("Saw Position =>" + strList.get(1) + "<= with text =>" + text);

		return Integer.valueOf(strList.get(1)) + 1;
	}


	public void checkGroupsAddedPosition_withText(String text, Integer position) {
		Integer currentPosition = groupsPosition_byText(text);
		Assert.assertEquals(position, currentPosition);
		log.info("Got expected position, expected =>" + position);
	}


	public void text_hasClass(String text, String className) {
		wait.activateImplicitWait();
		driver.findElement(By.xpath("//*[text()[contains(.,'" + text + "')] and contains(@class, '" + className + "')]"));
		wait.deactivateImplicitWait();
		////*[text()[contains(.,'1. User Details')] and contains(@class, 'completed')]")

		log.info("Found li element which has text =>" + text + "<= with class =>" + className);
	}

	/**
	 * Note that this step can't fail unless it cant see the element - Ensure that a check is made in cucumber to confirm the set
	 *
	 * @param checkUncheck
	 * @param rowName
	 * @param colName
	 */
	public void setCheckbox_forRowCol(String checkUncheck, String rowName, String colName) {
		log.info("Going to set row =>" + rowName + "<+ with column =>" + colName + "<= to =>" + checkUncheck);

		List<WebElement> tables = driver.findElements(By.cssSelector("table"));

		if (tables.size() > 1)
			throw new Error("Found more than one table -  We dont know which one to use");
		WebElement table = tables.get(0);
		// Going to assume columns for now
		String column = "1";
		if (colName.equalsIgnoreCase("Court Lists"))
			column = "2";
		else if (colName.equalsIgnoreCase("Court Register"))
			column = "3";

		WebElement row = table.findElement(By.xpath("//td[contains(text(),\"" + rowName + "\")]/.."));
		log.info("Found row with text =>" + rowName);

		WebElement cell = row.findElement(By.cssSelector("td:nth-child(" + column + ")")).findElement(By.cssSelector("input"));
		log.info("Found Cell at position =>" + colName);

		if (checkUncheck.equalsIgnoreCase("check") && !cell.isSelected()) {
			cell.click();
		} else if (checkUncheck.equalsIgnoreCase("uncheck") && cell.isSelected()) {
			cell.click();
		}

		log.info("As Expected - Icon visibility");
	}

	public void click_radioButtonWithLabel(String arg1) throws Exception {
		WebElement radioButton;
		wait.activateImplicitWait();
		try {
			radioButton = NAV.return_oneVisibleFromList(driver.findElements(By.xpath(
					"//input[@id=("
							+ "//label[text()[contains(.,\"" + arg1 + "\")]]"
							+ "/@for)]"
							+ "|"
							+ "//label[text()[contains(., \"" + arg1 + "\")]]/input"
							+ "|"
							+ "//label/div[@role='text' and text()[contains(., \"" + arg1 + "\")]]/../input[@type='radio']"
			)), true);
			NAV.click_onElement(radioButton);
			radioButton.sendKeys(Keys.chord("", Keys.TAB));
		} catch (Exception e) {
			WebElement radioButtonNext = driver.findElement(By.xpath(
					"//label[text()[contains(.,'" + arg1 + "')]]"
			));
			NAV.click_onElement(radioButtonNext);
		}

		log.info("Clicked on radio button which contained text =>" + arg1);
	}

	public void chooseRadioButtonWithLabel(String arg1) throws Exception {
		WebElement radioButton;
		wait.activateImplicitWait();
		try {
			radioButton = driver.findElement(By.xpath("//label[text()[contains(.,'" + arg1 + "')]]/../input[@type='radio']"));
			NAV.click_onElement(radioButton);
			radioButton.sendKeys(Keys.chord("", Keys.TAB));
		} catch (Exception e) {
			radioButton = driver.findElement(By.xpath("//label[text()[contains(.,'" + arg1 + "')]]/../input[@type='radio']"));
			NAV.waitForPageLoad();
			NAV.click_onElement(radioButton);
//			radioButton.sendKeys(Keys.chord("", Keys.TAB));

		}

		log.info("Clicked on radio button which contained text =>" + arg1);
	}

	public void confirm_Radiobutton_withNameChecked(String radioButtonLabel, String selectUnSelected) {
		WebElement radioButtonSelected = driver.findElement(By.xpath(
				"//input[@id=("
						+ "//label[text()[contains(.,'" + radioButtonLabel + "')]]"
						+ "/@for)]"
		));
		if (selectUnSelected.equalsIgnoreCase("selected") && radioButtonSelected.isSelected()) {
			log.info("Radio button with label =>" + radioButtonLabel + "<= Selected as expected");
			return;
		} else if (selectUnSelected.equalsIgnoreCase("unselected") && !radioButtonSelected.isSelected()) {
			log.info("Radio button with label =>" + radioButtonLabel + "<= Unselected as expected");
		} else {
			Verify.verify(false, "Radio button wasnt selected as expected - Failure but continunig");
		}
	}
	public boolean seeGovNote() {

		String expectedText = "All content is available under the Open Government Licence v3.0, except where otherwise stated";

		WebElement footerElement = driver.findElement(By.cssSelector("footer"));
		JavascriptExecutor js = (JavascriptExecutor) driver;
		js.executeScript("arguments[0].scrollIntoView(true);", footerElement);


		String mainText = driver.findElement(By.xpath("/html/body/footer/div/div/div[1]/span")).getText().trim();

		mainText = mainText.replaceAll("\\s+", " ");

		if (mainText.contains(expectedText)) {
			System.out.println("Expected text found in License.");
			return true;
		} else {
			System.out.println("Expected text not found in License. Combined text: " + mainText);
			return false;
		}
	}
}