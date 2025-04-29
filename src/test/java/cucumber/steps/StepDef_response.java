package cucumber.steps;


import cucumber.pageObjects.*;
import io.cucumber.datatable.DataTable;
import io.cucumber.java.en.Given;
import io.cucumber.java.en.When;
import org.openqa.selenium.By;
import org.openqa.selenium.JavascriptExecutor;
import org.openqa.selenium.TimeoutException;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.support.PageFactory;
import org.openqa.selenium.support.ui.ExpectedConditions;
import org.openqa.selenium.support.ui.WebDriverWait;

import java.time.Duration;
import java.util.List;
import java.util.Map;

import static org.junit.Assert.assertTrue;

public class StepDef_response {

	private aSamplePO SPO;
	private Login LGN;
	private NavigationShared NAV;
	private Groups GRP;
	private final WebDriver webDriver;
	private ScreenShotTaker SST;
	private final SummonsReply SUMMONS_REPLY;

	public StepDef_response(SharedDriver webDriver, SummonsReply summons_reply) {
		this.webDriver = webDriver;
		SPO = PageFactory.initElements(webDriver, aSamplePO.class);
		LGN = PageFactory.initElements(webDriver, Login.class);
		NAV = PageFactory.initElements(webDriver, NavigationShared.class);
		GRP = PageFactory.initElements(webDriver, Groups.class);
		SST = PageFactory.initElements(webDriver, ScreenShotTaker.class);
		SUMMONS_REPLY = summons_reply;
	}

	@Given("^I have completed the response for$")
	public void searchComplete_response(DataTable arg1) throws Throwable {
		List<Map<String, String>> list = arg1.asMaps(String.class, String.class);
		for (int i = 0; i < list.size(); i++) {
			String part_no = list.get(i).get("part_no");

			String env = "demo";
			if (System.getProperty("env.database") != null)
				env = System.getProperty("env.database");

			NAV.accessLoginPage("bureau", env);

			LGN.login();
			NAV.click_link_by_text("Search");
			NAV.set_valueTo("Juror number", part_no);
			NAV.press_buttonByName("Search");
			NAV.textPresentOnPage("1 results for");
			NAV.textPresentOnPage("Date received");
			NAV.clickText_inSameRow_asText(part_no, part_no);
			NAV.textPresentOnPage("Record status");
			try {
//				NAV.select_fromDropdown("Excusal", "Process reply");
				NAV.press_buttonByName("Process reply");
				NAV.setProcessReplyTo_("Excusal");
				GRP.click_radioButtonWithLabel("Accept excusal");
				NAV.textPresentOnPage("Reason for excusal re");
				NAV.select_fromDropdown("D - DECEASED", "Reason for the excusal request");
				NAV.press_buttonByName("Confirm");
			} catch (Exception | AssertionError e) {
				NAV.textPresentOnPage("Completed");
				NAV.textPresentOnPage("Responded");
			}

		}
	}

	;

	@Given("^I have submitted a first party English straight through response$")
	public void submitFirstEnglishStraightThroughResponse(DataTable arg1) throws Throwable {
		List<Map<String, String>> list = arg1.asMaps(String.class, String.class);
		for (int i = 0; i < list.size(); i++) {
			String part_no = list.get(i).get("part_no");
			String pool_number = list.get(i).get("pool_number");
			String last_name = list.get(i).get("last_name");
			String postcode = list.get(i).get("postcode");
			String email = list.get(i).get("email");
			String env = "demo";
			if (System.getProperty("env.database") != null)
				env = System.getProperty("env.database");

			NAV.accessLoginPage("public", env);

//			NAV.press_buttonByName("Start now");
			GRP.click_radioButtonWithLabel("I am replying for myself");
			NAV.press_buttonByName("Continue");
			NAV.textPresentOnPage("You can find your juror number on your jury summons letter.");
			NAV.set_valueTo("9-digit juror number", part_no);
			NAV.set_valueTo("Juror last name", last_name);
			NAV.set_valueTo("Juror postcode", postcode);
			NAV.press_buttonByName("Continue");
			NAV.textPresentOnPage("Is the name we have for you correct?");
			GRP.click_radioButtonWithLabel("Yes");
			NAV.press_buttonByName("Continue");
			NAV.textPresentOnPage("Is this your address?");
			GRP.click_radioButtonWithLabel("Yes");
			NAV.press_buttonByName("Continue");

			NAV.set_valueTo("Main phone", "07551179225");
			NAV.press_buttonByName("Continue");

			NAV.set_valueTo("Enter your email address", email);
			NAV.set_valueTo("Enter your email address again", email);
			NAV.press_buttonByName("Continue");

			Thread.sleep(500);
			((JavascriptExecutor) webDriver).executeScript("document.getElementById('dobDay').value = '01';");
			((JavascriptExecutor) webDriver).executeScript("document.getElementById('dobMonth').value = '01';");
			((JavascriptExecutor) webDriver).executeScript("document.getElementById('dobYear').value = '1990';");
			NAV.press_buttonByName("Continue");

			NAV.textPresentOnPage("Confirm you're eligible for jury service");
			NAV.press_buttonByName("Continue");

			GRP.click_radioButtonWithLabel("Yes");
			NAV.press_buttonByName("Continue");

			NAV.textPresentOnPage("Have you worked in the");
			GRP.click_radioButtonWithLabel("No");
			NAV.press_buttonByName("Continue");

			NAV.textPresentOnPage("Are you currently");
			GRP.click_radioButtonWithLabel("No");
			NAV.press_buttonByName("Continue");

			NAV.textPresentOnPage("Have you been");
			GRP.click_radioButtonWithLabel("No");
			NAV.press_buttonByName("Continue");

			NAV.textPresentOnPage("Are you being detained");
			GRP.click_radioButtonWithLabel("No");
			NAV.press_buttonByName("Continue");

			NAV.textPresentOnPage("Has it been decided that you 'lack mental capacity'?");
			GRP.click_radioButtonWithLabel("No");
			NAV.press_buttonByName("Continue");

			GRP.click_radioButtonWithLabel("Yes, I can start on");
			NAV.press_buttonByName("Continue");

//			GRP.click_radioButtonWithLabel("Yes");
//			NAV.press_buttonByName("Continue");

			NAV.textPresentOnPage("Do you have a disability");
			GRP.click_radioButtonWithLabel("No");
			NAV.press_buttonByName("Continue");

			NAV.textPresentOnPage("The information I have given is true to the best of my knowle");
			NAV.check_checkbox("The information I have given is true to the best of my knowle");
			NAV.press_buttonByName("Submit");

			NAV.textPresentOnPage("You have completed your reply");

		}
	}

    //| part_no		|pool_number	| last_name			|postcode	| email |
	@Given("^I have submitted a third party English straight through response$")
	public void submitThirdEnglishStraightThroughResponse(DataTable arg1) throws Throwable {
		List<Map<String, String>> list = arg1.asMaps(String.class, String.class);
		for (int i = 0; i < list.size(); i++) {
			String part_no = list.get(i).get("part_no");
			String pool_number = list.get(i).get("pool_number");
			String last_name = list.get(i).get("last_name");
			String postcode = list.get(i).get("postcode");
			String email = list.get(i).get("email");
			String env = "demo";
			if (System.getProperty("env.database") != null)
				env = System.getProperty("env.database");

			NAV.accessLoginPage("public", env);

//		NAV.press_buttonByName("Start now");
			GRP.click_radioButtonWithLabel("I am replying for someone else");
			NAV.press_buttonByName("Continue");
//		NAV.textPresentOnPage("The juror number can be found on the jury s");
			NAV.set_valueTo("9-digit juror number", part_no);
			NAV.set_valueTo("Juror last name", last_name);
			NAV.set_valueTo("Juror postcode", postcode);
			NAV.press_buttonByName("Continue");

			NAV.textPresentOnPage("What is your name?");
			NAV.set_valueTo("First name", "FirstName");
			NAV.set_valueTo("Last name", "LastName");
			NAV.press_buttonByName("Continue");

			NAV.textPresentOnPage("Your relationship to the person");
			NAV.set_valueTo("How do you know the person you're replying for?", "Friend");
			NAV.press_buttonByName("Continue");

			NAV.textPresentOnPage("Your contact information");
			NAV.check_checkbox("By phone (UK Numbers only)");
			NAV.set_valueTo("Main phone", "07551179225");
			NAV.check_checkbox("By email");
			NAV.set_valueTo("Enter your email address", email);
			NAV.set_valueTo("Enter your email address again", email);
			NAV.press_buttonByName("Continue");

			NAV.textPresentOnPage("Why are you replying for the other person?");
			GRP.click_radioButtonWithLabel("The person is not here");
			NAV.press_buttonByName("Continue");

			NAV.waitForPageLoad();
			NAV.textPresentOnPage("Is the name we have for them correct?");
			GRP.click_radioButtonWithLabel("Yes");
			NAV.press_buttonByName("Continue");
			NAV.textPresentOnPage("Is this their address?");
			GRP.click_radioButtonWithLabel("Yes");
			NAV.press_buttonByName("Continue");

//		NAV.textPresentOnPage("Please give the date of birth for the person you're replying for");
			NAV.set_valueTo("Day", "27");
			NAV.set_valueTo("Month", "09");
			NAV.set_valueTo("Year", "1981");
			NAV.press_buttonByName("Continue");

			NAV.textPresentOnPage("We might need to get in touch with the person to ask them more questions or give them information about their jury service");
			GRP.click_radioButtonWithLabel("Use the phone number that you have already given to contact you");
			GRP.click_radioButtonWithLabel("Use the email address that you have already given to contact you");
			NAV.press_buttonByName("Continue");

//		#eligibility
			NAV.press_buttonByName("Continue");

//		#residency
			GRP.click_radioButtonWithLabel("Yes");
			NAV.press_buttonByName("Continue");

//		#cjs
			GRP.click_radioButtonWithLabel("No");
			NAV.press_buttonByName("Continue");

//		#bail
			GRP.click_radioButtonWithLabel("No");
			NAV.press_buttonByName("Continue");

//		#convictions
			GRP.click_radioButtonWithLabel("No");
			NAV.press_buttonByName("Continue");

//		#MH1
			GRP.click_radioButtonWithLabel("No");
			NAV.press_buttonByName("Continue");

//		#MH2
			GRP.click_radioButtonWithLabel("No");
			NAV.press_buttonByName("Continue");

//		#I can do service
			GRP.click_radioButtonWithLabel("Yes");
			NAV.press_buttonByName("Continue");

//		#reasonable adjustments
			GRP.click_radioButtonWithLabel("No");
			NAV.press_buttonByName("Continue");

			NAV.check_checkbox("The answers I have given for the person I'm replying for are true as far as I know.");
			NAV.press_buttonByName("Submit");

			NAV.waitForPageLoad();
			NAV.textPresentOnPage("You have completed your reply");

		}
	}

	;

	//| part_no		|pool_number	| last_name			|postcode	| email |
	@Given("^I have submitted a first party Welsh straight through response$")
	public void submitFirstWelshStraightThroughResponse(DataTable arg1) throws Throwable {
		List<Map<String, String>> list = arg1.asMaps(String.class, String.class);
		for (int i = 0; i < list.size(); i++) {
			String part_no = list.get(i).get("part_no");
			String pool_number = list.get(i).get("pool_number");
			String last_name = list.get(i).get("last_name");
			String postcode = list.get(i).get("postcode");
			String email = list.get(i).get("email");
			String env = "demo";
			if (System.getProperty("env.database") != null)
				env = System.getProperty("env.database");

			NAV.accessLoginPageWelsh("public", env);

//		NAV.click_link_by_text("Welsh (Cymraeg)");
//		NAV.press_buttonByName("Dechrau nawr");
			GRP.click_radioButtonWithLabel("Rwy'n ymateb dros fy hun");
			NAV.press_buttonByName("Parhau");
//		NAV.textPresentOnPage("Gellir dod o hyd i'ch rhif rheithiwr ar eich llythyr gwŷs rheithgor");
//		NAV.set_valueTo("Rhif rheithiwr – 9 digid", part_no);
			NAV.set_valueTo("Rhif rheithiwr", part_no);
			NAV.set_valueTo("Cyfenw'r Rheithiwr", last_name);
			NAV.set_valueTo("Cod post Rheithiwr", postcode);
			NAV.press_buttonByName("Parhau");
			NAV.textPresentOnPage("A yw'r enw sydd gennym ar eich cyfer chi yn gywir?");
			GRP.click_radioButtonWithLabel("Ydy");
			NAV.press_buttonByName("Parhau");
			NAV.textPresentOnPage("Eich cyfeiriad chi yw hwn?");
			GRP.click_radioButtonWithLabel("Ie");
			NAV.press_buttonByName("Parhau");

			NAV.set_valueTo("Prif rif ff", "07590309447");
			NAV.press_buttonByName("Parhau");

			NAV.set_valueTo("Nodwch eich cyfeiriad e-bost", email);
			NAV.set_valueTo("Nodwch eich cyfeiriad e-bost eto", email);
			NAV.press_buttonByName("Parhau");

			NAV.set_valueTo("Diwrnod", "27");
			NAV.set_valueTo("Mis", "09");
			NAV.set_valueTo("Blwyddyn", "1981");
			NAV.press_buttonByName("Parhau");

			NAV.textPresentOnPage("Cadarnhau a ydych yn gymwys i wasanaethu ar reithgor");
			NAV.press_buttonByName("Parhau");

			GRP.click_radioButtonWithLabel("Do");
			NAV.press_buttonByName("Parhau");

			GRP.click_radioButtonWithLabel("Nac ydw");
			NAV.press_buttonByName("Parhau");

			NAV.textPresentOnPage("Ydych chi ar fechn");
			GRP.click_radioButtonWithLabel("Nac ydw");
			NAV.press_buttonByName("Parhau");

			NAV.textPresentOnPage("Ydych chi wedi");
			GRP.click_radioButtonWithLabel("Naddo");
			NAV.press_buttonByName("Parhau");

			GRP.click_radioButtonWithLabel("Na");
			NAV.press_buttonByName("Parhau");

			GRP.click_radioButtonWithLabel("Na");
			NAV.press_buttonByName("Parhau");

			GRP.click_radioButtonWithLabel("Ydw, rydw i'n gallu dechrau");
			NAV.press_buttonByName("Parhau");

			GRP.click_radioButtonWithLabel("Nac oes");
			NAV.press_buttonByName("Parhau");

			NAV.check_checkbox("Mae'r wybodaeth a roddais uchod yn wir hyd eithaf fy ngwybodaeth.");
			NAV.press_buttonByName("Cyflwyno");

			NAV.textPresentOnPage("Rydych wedi cwblhau'r broses ymateb");

		}
	}

	;

	//| part_no		|pool_number	| last_name			|postcode	| email |
	@Given("^I have submitted a third party Welsh straight through response$")
	public void submitThirdWelshStraightThroughResponse(DataTable arg1) throws Throwable {
		List<Map<String, String>> list = arg1.asMaps(String.class, String.class);
		for (int i = 0; i < list.size(); i++) {
			String part_no = list.get(i).get("part_no");
			String pool_number = list.get(i).get("pool_number");
			String last_name = list.get(i).get("last_name");
			String postcode = list.get(i).get("postcode");
			String email = list.get(i).get("email");
			String env = "demo";
			if (System.getProperty("env.database") != null)
				env = System.getProperty("env.database");

			NAV.accessLoginPage("public", env);

			NAV.click_link_by_text("Welsh (Cymraeg)");
			NAV.press_buttonByName("Dechrau nawr");
			GRP.click_radioButtonWithLabel("Rwy'n ymateb ar ran rhywun arall");
			NAV.press_buttonByName("Parhau");
			NAV.textPresentOnPage("Gellir dod o hyd i'r rhif rheithiwr ar y llythyr gwŷs rheithgor");
			NAV.set_valueTo("Rhif rheithiwr – 9 digid", part_no);
			NAV.set_valueTo("Cyfenw'r Rheithiwr", last_name);
			NAV.set_valueTo("Cod post Rheithiwr", postcode);
			NAV.press_buttonByName("Parhau");

			NAV.textPresentOnPage("Beth yw eich enw?");
			NAV.set_valueTo("Enw cyntaf", "FirstName");
			NAV.set_valueTo("Cyfenw", "LastName");
			NAV.press_buttonByName("Parhau");

			NAV.textPresentOnPage("Eich perthynas â'r unigolyn");
			NAV.set_valueTo("Sut ydych chi'n adnabod yr unigolyn rydych yn ymateb ar ei ran?", "Friend");
			NAV.press_buttonByName("Parhau");

			NAV.textPresentOnPage("Eich manylion cyswllt");
			NAV.check_checkbox("Dros y ffôn (rhifau yn y DU yn unig)");
			NAV.set_valueTo("Prif rif ffôn", "07551179225");
			NAV.check_checkbox("Trwy e-bost");
			NAV.set_valueTo("Nodwch gyfeiriad e-bost", email);
			NAV.set_valueTo("Nodwch gyfeiriad e-bost eto", email);
			NAV.press_buttonByName("Parhau");

			NAV.textPresentOnPage("Pam ydych chi'n ymateb ar ran yr unigolyn arall?");
			GRP.click_radioButtonWithLabel("Nid yw'r unigolyn yma");
			NAV.press_buttonByName("Parhau");

			NAV.textPresentOnPage("A yw'r enw sydd gennym ar ei gyfer yn gywir?");
			GRP.click_radioButtonWithLabel("Ydy");
			NAV.press_buttonByName("Parhau");
			NAV.textPresentOnPage("Ei gyfeiriad ef yw hwn?");
			GRP.click_radioButtonWithLabel("Ie");
			NAV.press_buttonByName("Parhau");

			NAV.textPresentOnPage("Nodwch ddyddiad geni'r unigolyn rydych chi'n ymateb ar ei ran");
			NAV.set_valueTo("Diwrnod", "27");
			NAV.set_valueTo("Mis", "09");
			NAV.set_valueTo("Blwyddyn", "1981");
			NAV.press_buttonByName("Parhau");

			NAV.textPresentOnPage("Efallai bydd yn rhaid inni gysylltu â'r unigolyn i ofyn rhagor o gwestiynau neu roi rhagor o wybodaeth iddynt am eu gwasanaeth rheithgor");
			GRP.click_radioButtonWithLabel("Defnyddio'r rhif ffôn rydych eisoes wedi'i ddarparu i gysylltu â chi");
			GRP.click_radioButtonWithLabel("Defnyddio'r cyfeiriad e-bost rydych eisoes wedi'i ddarparu i gysylltu â chi");
			NAV.press_buttonByName("Parhau");

			NAV.textPresentOnPage("A yw'r unigolyn rydych chi'n ymateb ar ei ran yn gymwys i wasanaethu ar reithgor?");
			NAV.press_buttonByName("Parhau");

			GRP.click_radioButtonWithLabel("Do");
			NAV.press_buttonByName("Parhau");

			NAV.textPresentOnPage("A yw'r unigolyn yn glaf dan");
			GRP.click_radioButtonWithLabel("Nac ydi");
			NAV.press_buttonByName("Parhau");

			NAV.textPresentOnPage("A oes gan yr unigolyn ddiffyg galluedd meddyliol");
			GRP.click_radioButtonWithLabel("Nac ydi");
			NAV.press_buttonByName("Parhau");

			NAV.textPresentOnPage("A yw'r unigolyn ar fechnïaeth");
			GRP.click_radioButtonWithLabel("Nac ydi");
			NAV.press_buttonByName("Parhau");

			NAV.textPresentOnPage("A yw'r unigolyn wedi'i gael");
			GRP.click_radioButtonWithLabel("Nac ydi");
			NAV.press_buttonByName("Parhau");

			GRP.click_radioButtonWithLabel("Ydi, mae'r unigolyn yn gallu dechrau");
			NAV.press_buttonByName("Parhau");

			GRP.click_radioButtonWithLabel("Naddo");
			NAV.press_buttonByName("Parhau");

			NAV.textPresentOnPage("A oes gan yr unigolyn anabledd neu nam");
			GRP.click_radioButtonWithLabel("Nac oes");
			NAV.press_buttonByName("Parhau");

			NAV.check_checkbox("Hyd gwn i, mae'r wybodaeth rwyf wedi ei rhoi am yr unigolyn rwyf yn ymateb ar ei ran yn gywir.");
			NAV.press_buttonByName("Cyflwyno");

			NAV.textPresentOnPage("Rydych wedi cwblhau'r broses ymateb");

		}
	}

	@Given("^I have submitted a first party English ineligibilty response$")
	public void submitFirstEnglishIneligbileResponse(DataTable arg1) throws Throwable {
		List<Map<String, String>> list = arg1.asMaps(String.class, String.class);
		for (int i = 0; i < list.size(); i++) {
			String part_no = list.get(i).get("part_no");
			String pool_number = list.get(i).get("pool_number");
			String last_name = list.get(i).get("last_name");
			String postcode = list.get(i).get("postcode");
			String email = list.get(i).get("email");
			String details = list.get(i).get("details");
			String env = "demo";
			if (System.getProperty("env.database") != null)
				env = System.getProperty("env.database");

			NAV.accessLoginPage("public", env);

			GRP.click_radioButtonWithLabel("I am replying for myself");
			NAV.press_buttonByName("Continue");
			NAV.textPresentOnPage("You can find your juror number on your jury summons letter.");
			NAV.set_valueTo("9-digit juror number", part_no);
			NAV.set_valueTo("Juror last name", last_name);
			NAV.set_valueTo("Juror postcode", postcode);
			NAV.press_buttonByName("Continue");
			NAV.textPresentOnPage("Is the name we have for you correct?");
			GRP.click_radioButtonWithLabel("No");
			NAV.press_buttonByName("Continue");
			NAV.set_value_to("Last name", "Changed");
			NAV.press_buttonByName("Continue");
			NAV.textPresentOnPage("Is this your address?");
			GRP.click_radioButtonWithLabel("Yes");
			NAV.press_buttonByName("Continue");

			NAV.set_valueTo("Main phone", "01234561234");
			NAV.press_buttonByName("Continue");

			WebDriverWait wait = new WebDriverWait(webDriver, Duration.ofSeconds(3));
			try {
				wait.until(ExpectedConditions.visibilityOfElementLocated(By.id("emailAddress")));
				System.out.println("Email field located and ready for input");
			} catch (TimeoutException e) {
				System.out.println("Email field not located and not ready for input");
			}

			NAV.set_valueTo("Enter your email address", email);
			NAV.set_valueTo("Enter your email address again", email);
			NAV.press_buttonByName("Continue");

			NAV.set_valueTo("Day", "01");
			NAV.set_valueTo("Month", "01");
			NAV.set_valueTo("Year", "1990");
			NAV.press_buttonByName("Continue");

			NAV.textPresentOnPage("Confirm you're eligible");
			NAV.press_buttonByName("Continue");

			GRP.click_radioButtonWithLabel("No");
			NAV.set_valueTo("Provide details", "Not resident");
			NAV.press_buttonByName("Continue");

			GRP.click_radioButtonWithLabel("No");
			NAV.press_buttonByName("Continue");

			NAV.textPresentOnPage("Are you currently");
			GRP.click_radioButtonWithLabel("Yes");
			NAV.set_valueTo("Provide details", "Bailed");
			NAV.press_buttonByName("Continue");

			NAV.textPresentOnPage("Have you been");
			GRP.click_radioButtonWithLabel("Yes");
			NAV.setTextAreaWith_toText("id", "convictedDetails", "Convicted");
			NAV.press_buttonByName("Continue");

			NAV.waitForPageLoad();
			NAV.textPresentOnPage("Are you being detained");
			GRP.click_radioButtonWithLabel("Yes");
			NAV.set_valueTo("Provide details", "Am detained");
			NAV.press_buttonByName("Continue");

			NAV.waitForPageLoad();
			NAV.textPresentOnPage("Has it been decided that you 'lack mental capacity'?");
			GRP.click_radioButtonWithLabel("Yes");
			NAV.set_valueTo("Provide brief details about why it was decided you lack mental capacity", "Lack capacity");
			NAV.press_buttonByName("Continue");

			GRP.click_radioButtonWithLabel("Yes, I can start on");
			NAV.press_buttonByName("Continue");

			NAV.textPresentOnPage("Do you have a disability");
			GRP.click_radioButtonWithLabel("No");
			NAV.press_buttonByName("Continue");

			NAV.check_checkbox("The information I have given is true to the best of my knowle");
			NAV.press_buttonByName("Submit");

			NAV.textPresentOnPage("You have completed your reply");

		}
	}

	@Given("^I submit a digital response with reasonable adjustment$")
	public void submitDigitalReasonableAdjustmentResponse(DataTable arg1) throws Throwable {
		List<Map<String, String>> list = arg1.asMaps(String.class, String.class);
		for (int i = 0; i < list.size(); i++) {
			String part_no = list.get(i).get("part_no");
			String pool_number = list.get(i).get("pool_number");
			String last_name = list.get(i).get("last_name");
			String postcode = list.get(i).get("postcode");
			String email = list.get(i).get("email");
			String details = list.get(i).get("details");
			String adjustmentNeededCap = list.get(i).get("adjustmentNeededCap");
			String env = "demo";
			if (System.getProperty("env.database") != null)
				env = System.getProperty("env.database");

			NAV.accessLoginPage("public", env);

			GRP.click_radioButtonWithLabel("I am replying for myself");
			NAV.press_buttonByName("Continue");

			NAV.set_valueTo("9-digit juror number", part_no);
			NAV.set_valueTo("Juror last name", last_name);
			NAV.set_valueTo("Juror postcode", postcode);
			NAV.press_buttonByName("Continue");

			GRP.click_radioButtonWithLabel("Yes");
			NAV.press_buttonByName("Continue");

			GRP.click_radioButtonWithLabel("Yes");
			NAV.press_buttonByName("Continue");

			NAV.set_valueTo("Main phone", "01234561234");
			NAV.press_buttonByName("Continue");

			NAV.textPresentOnPage("email address?");
			NAV.set_valueTo("Enter your email address", email);
			NAV.set_valueTo("Enter your email address again", email);
			NAV.press_buttonByName("Continue");

			NAV.set_valueTo("Day", "01");
			NAV.set_valueTo("Month", "01");
			NAV.set_valueTo("Year", "1990");
			NAV.press_buttonByName("Continue");

			NAV.press_buttonByName("Continue");

			GRP.click_radioButtonWithLabel("Yes");
			NAV.press_buttonByName("Continue");

			GRP.click_radioButtonWithLabel("No");
			NAV.press_buttonByName("Continue");

			GRP.click_radioButtonWithLabel("No");
			NAV.press_buttonByName("Continue");

			GRP.click_radioButtonWithLabel("No");
			NAV.press_buttonByName("Continue");

			GRP.click_radioButtonWithLabel("No");
			NAV.press_buttonByName("Continue");

			GRP.click_radioButtonWithLabel("No");
			NAV.press_buttonByName("Continue");

			GRP.click_radioButtonWithLabel("Yes, I can start on");
			NAV.press_buttonByName("Continue");


			GRP.click_radioButtonWithLabel("Yes");
			NAV.check_checkbox(adjustmentNeededCap);
			NAV.set_valueTo("Tell us about any special arrangements", details);
			NAV.press_buttonByName("Continue");

			NAV.check_checkbox("The information I have given is true to the best of my knowle");
			NAV.press_buttonByName("Submit");

			NAV.textPresentOnPage("You have completed your reply");

		}
	}

	@Given("^I have submitted a third party English ineligibilty response$")
	public void submitThirdEnglishIneligbileResponse(DataTable arg1) throws Throwable {
		List<Map<String, String>> list = arg1.asMaps(String.class, String.class);
		for (int i = 0; i < list.size(); i++) {
			String part_no = list.get(i).get("part_no");
			String pool_number = list.get(i).get("pool_number");
			String last_name = list.get(i).get("last_name");
			String postcode = list.get(i).get("postcode");
			String email = list.get(i).get("email");
			String env = "demo";
			if (System.getProperty("env.database") != null)
				env = System.getProperty("env.database");

			NAV.accessLoginPage("public", env);

			GRP.click_radioButtonWithLabel("I am replying for someone else");
			NAV.press_buttonByName("Continue");
			NAV.textPresentOnPage("You can find their juror number on the jury summons letter.");
			NAV.set_valueTo("9-digit juror number", part_no);
			NAV.set_valueTo("Juror last name", last_name);
			NAV.set_valueTo("Juror postcode", postcode);
			NAV.press_buttonByName("Continue");

			NAV.textPresentOnPage("What is your name?");
			NAV.set_valueTo("First name", "FirstName");
			NAV.set_valueTo("Last name", "LastName");
			NAV.press_buttonByName("Continue");

			NAV.textPresentOnPage("Your relationship to the person");
			NAV.set_valueTo("How do you know the person you're replying for?", "Friend");
			NAV.press_buttonByName("Continue");

			NAV.textPresentOnPage("Your contact information");
			NAV.check_checkbox("By phone (UK Numbers only)");
			NAV.set_valueTo("Main phone", "02078211818");
			NAV.check_checkbox("By email");
			NAV.set_valueTo("Enter your email address", email);
			NAV.set_valueTo("Enter your email address again", email);
			NAV.press_buttonByName("Continue");

			NAV.textPresentOnPage("Why are you replying for the other person?");
			GRP.click_radioButtonWithLabel("The person is not here");
			NAV.press_buttonByName("Continue");

			NAV.textPresentOnPage("Is the name we have for them correct?");
			GRP.click_radioButtonWithLabel("Yes");
			NAV.press_buttonByName("Continue");
			NAV.textPresentOnPage("Is this their address?");
			GRP.click_radioButtonWithLabel("Yes");
			NAV.press_buttonByName("Continue");

			NAV.textPresentOnPage("Give the date of birth for the person you're replying for");
			NAV.set_valueTo("Day", "27");
			NAV.set_valueTo("Month", "09");
			NAV.set_valueTo("Year", "1981");
			NAV.press_buttonByName("Continue");

			NAV.textPresentOnPage("We might need to get in touch with the person to ask them more questions or give them information about their jury service");
			GRP.click_radioButtonWithLabel("Use the phone number that you have already given to contact you");
			GRP.click_radioButtonWithLabel("Use the email address that you have already given to contact you");
			NAV.press_buttonByName("Continue");

//			#eligibility
			NAV.press_buttonByName("Continue");

//			#residency
			GRP.click_radioButtonWithLabel("No");
			NAV.set_valueTo("Provide details about where the person you are answering for has lived since their 13th birthday", "Not resident");
			NAV.press_buttonByName("Continue");

//			#cjs
			GRP.click_radioButtonWithLabel("No");
			NAV.press_buttonByName("Continue");

//			#bail
			GRP.click_radioButtonWithLabel("Yes");
			NAV.set_valueTo("Provide details about the person's bail and criminal offence", "Bailed");
			NAV.press_buttonByName("Continue");

//			#convictions
			GRP.click_radioButtonWithLabel("Yes");
			NAV.setTextAreaWith_toText("id", "convictedDetails", "Convicted");
			NAV.press_buttonByName("Continue");

//			#mh1
			GRP.click_radioButtonWithLabel("Yes");
			NAV.set_valueTo("Provide details about how they're being detained, looked after or treated under the Mental Health Act", "Am detained");
			NAV.press_buttonByName("Continue");

//			#mh2
			GRP.click_radioButtonWithLabel("Yes");
			NAV.set_valueTo("Provide brief details about why it was decided they lack mental capacity", "Lack capacity");
			NAV.press_buttonByName("Continue");

//			#can do service
			GRP.click_radioButtonWithLabel("Yes");
			NAV.press_buttonByName("Continue");

//			#reasonable adjustments
			GRP.click_radioButtonWithLabel("No");
			NAV.press_buttonByName("Continue");

			NAV.check_checkbox("The answers I have given for the person I'm replying for are true as far as I know.");
			NAV.press_buttonByName("Submit");

			NAV.textPresentOnPage("You have completed your reply");

		}
	}

	;

	@Given("^I have submitted a first party Welsh ineligibilty response$")
	public void submitFirstWelshIneligbileResponse(DataTable arg1) throws Throwable {
		List<Map<String, String>> list = arg1.asMaps(String.class, String.class);
		for (int i = 0; i < list.size(); i++) {
			String part_no = list.get(i).get("part_no");
			String pool_number = list.get(i).get("pool_number");
			String last_name = list.get(i).get("last_name");
			String postcode = list.get(i).get("postcode");
			String email = list.get(i).get("email");
			String env = "demo";
			if (System.getProperty("env.database") != null)
				env = System.getProperty("env.database");

			NAV.accessLoginPageWelsh("public", env);

//				NAV.click_link_by_text("Welsh (Cymraeg)");
//				NAV.press_buttonByName("Dechrau nawr");
			GRP.click_radioButtonWithLabel("Rwy'n ymateb dros fy hun");
			NAV.press_buttonByName("Parhau");
			NAV.textPresentOnPage("Rhif rheithiwr");
			NAV.set_valueTo("Rhif rheithiwr", part_no);
			NAV.set_valueTo("Cyfenw'r Rheithiwr", last_name);
			NAV.set_valueTo("Cod post Rheithiwr", postcode);
			NAV.press_buttonByName("Parhau");
			NAV.textPresentOnPage("A yw'r enw sydd gennym ar eich cyfer chi yn gywir?");
			GRP.click_radioButtonWithLabel("Ydy");
			NAV.press_buttonByName("Parhau");
			NAV.textPresentOnPage("Eich cyfeiriad chi yw hwn?");
			GRP.click_radioButtonWithLabel("Ie");
			NAV.press_buttonByName("Parhau");

			NAV.set_valueTo("Prif rif ff", "02078211818");
			NAV.press_buttonByName("Parhau");

			NAV.waitForPageLoad();
			NAV.set_valueTo("Nodwch eich cyfeiriad e-bost", email);
			NAV.set_valueTo("Nodwch eich cyfeiriad e-bost eto", email);
			NAV.press_buttonByName("Parhau");

			NAV.set_valueTo("Diwrnod", "27");
			NAV.set_valueTo("Mis", "09");
			NAV.set_valueTo("Blwyddyn", "1981");
			NAV.press_buttonByName("Parhau");

			NAV.textPresentOnPage("Cadarnhau a ydych yn gymwys i wasanaethu ar reithgor");
			NAV.press_buttonByName("Parhau");

			GRP.click_radioButtonWithLabel("Naddo");
			NAV.set_valueTo("Rhowch fanylion", "Not resident");
			NAV.press_buttonByName("Parhau");

			GRP.click_radioButtonWithLabel("Nac ydw");
			NAV.press_buttonByName("Parhau");

			NAV.textPresentOnPage("Ydych chi ar fechn");
			GRP.click_radioButtonWithLabel("Ydw");
			NAV.set_valueTo("Rhowch fanylion", "Bailed");
			NAV.press_buttonByName("Parhau");

			NAV.textPresentOnPage("Ydych chi wedi'ch cael");
			GRP.click_radioButtonWithLabel("Do");
			NAV.setTextAreaWith_toText("id", "convictedDetails", "Convicted");
			NAV.press_buttonByName("Parhau");

			NAV.textPresentOnPage("Ydych chi'n cael eich cadw");
			GRP.click_radioButtonWithLabel("Ie");
			NAV.set_valueTo("Eglurwch sut yr ydych yn cael eich cadw dan glo, sut ofal ydych yn ei gael neu sut yr ydych yn cael eich trin o dan y Ddeddf Iechyd Meddwl", "Am sectioned");
			NAV.press_buttonByName("Parhau");

			NAV.textPresentOnPage("A benderfynwyd nad oes gennych y gallu meddyliol");
			GRP.click_radioButtonWithLabel("Ie");
			NAV.set_valueTo("Eglurwch yn gryno pam y penderfynwyd nad oes gennych alluedd meddyliol", "Lack capacity");
			NAV.press_buttonByName("Parhau");

			GRP.click_radioButtonWithLabel("Ydw, rydw i'n gallu dechrau");
			NAV.press_buttonByName("Parhau");

			NAV.textPresentOnPage("A oes gennych anabledd neu nam");
			GRP.click_radioButtonWithLabel("Oes");
			NAV.check_checkbox("Clefyd siwgr");
			NAV.set_valueTo("Rhowch wybod", "Reasonable Adjustment");

			NAV.press_buttonByName("Parhau");

			NAV.check_checkbox("Mae'r wybodaeth a roddais uchod yn wir hyd eithaf fy ngwybodaeth.");
			NAV.press_buttonByName("Cyflwyno");

			NAV.textPresentOnPage("Rydych wedi cwblhau'r broses ymateb");

		}
	}

	;

	@Given("^I have submitted a third party Welsh ineligibilty response$")
	public void submitThirdWelshIneligbileResponse(DataTable arg1) throws Throwable {
		List<Map<String, String>> list = arg1.asMaps(String.class, String.class);
		for (int i = 0; i < list.size(); i++) {
			String part_no = list.get(i).get("part_no");
			String pool_number = list.get(i).get("pool_number");
			String last_name = list.get(i).get("last_name");
			String postcode = list.get(i).get("postcode");
			String email = list.get(i).get("email");
			String env = "demo";
			if (System.getProperty("env.database") != null)
				env = System.getProperty("env.database");

			NAV.accessLoginPage("public", env);

			NAV.click_link_by_text("Welsh (Cymraeg)");
			NAV.press_buttonByName("Dechrau nawr");
			GRP.click_radioButtonWithLabel("Rwy'n ymateb ar ran rhywun arall");
			NAV.press_buttonByName("Parhau");
			NAV.textPresentOnPage("Gellir dod o hyd i'r rhif rheithiwr ar y llythyr gwŷs rheithgor");
			NAV.set_valueTo("Rhif rheithiwr – 9 digid", part_no);
			NAV.set_valueTo("Cyfenw'r Rheithiwr", last_name);
			NAV.set_valueTo("Cod post Rheithiwr", postcode);
			NAV.press_buttonByName("Parhau");

			NAV.textPresentOnPage("Beth yw eich enw?");
			NAV.set_valueTo("Enw cyntaf", "FirstName");
			NAV.set_valueTo("Cyfenw", "LastName");
			NAV.press_buttonByName("Parhau");

			NAV.textPresentOnPage("Eich perthynas â'r unigolyn");
			NAV.set_valueTo("Sut ydych chi'n adnabod yr unigolyn rydych yn ymateb ar ei ran?", "Friend");
			NAV.press_buttonByName("Parhau");

			NAV.textPresentOnPage("Eich manylion cyswllt");
			NAV.check_checkbox("Dros y ffôn (rhifau yn y DU yn unig)");
			NAV.set_valueTo("Prif rif ffôn", "02078211818");
			NAV.check_checkbox("Trwy e-bost");
			NAV.set_valueTo("Nodwch gyfeiriad e-bost", email);
			NAV.set_valueTo("Nodwch gyfeiriad e-bost eto", email);
			NAV.press_buttonByName("Parhau");

			NAV.textPresentOnPage("Pam ydych chi'n ymateb ar ran yr unigolyn arall?");
			GRP.click_radioButtonWithLabel("Nid yw'r unigolyn yma");
			NAV.press_buttonByName("Parhau");

			NAV.textPresentOnPage("A yw'r enw sydd gennym ar ei gyfer yn gywir?");
			GRP.click_radioButtonWithLabel("Ydy");
			NAV.press_buttonByName("Parhau");
			NAV.textPresentOnPage("Ei gyfeiriad ef yw hwn?");
			GRP.click_radioButtonWithLabel("Ie");
			NAV.press_buttonByName("Parhau");

			NAV.textPresentOnPage("Nodwch ddyddiad geni'r unigolyn rydych chi'n ymateb ar ei ran");
			NAV.set_valueTo("Diwrnod", "27");
			NAV.set_valueTo("Mis", "09");
			NAV.set_valueTo("Blwyddyn", "1981");
			NAV.press_buttonByName("Parhau");

			NAV.textPresentOnPage("Efallai bydd yn rhaid inni gysylltu â'r unigolyn i ofyn rhagor o gwestiynau neu roi rhagor o wybodaeth iddynt am eu gwasanaeth rheithgor");
			GRP.click_radioButtonWithLabel("Defnyddio'r rhif ffôn rydych eisoes wedi'i ddarparu i gysylltu â chi");
			GRP.click_radioButtonWithLabel("Defnyddio'r cyfeiriad e-bost rydych eisoes wedi'i ddarparu i gysylltu â chi");
			NAV.press_buttonByName("Parhau");

			NAV.textPresentOnPage("A yw'r unigolyn rydych chi'n ymateb ar ei ran yn gymwys i wasanaethu ar reithgor?");
			NAV.press_buttonByName("Parhau");

			GRP.click_radioButtonWithLabel("Naddo");
			NAV.set_valueTo("Rhowch fanylion", "Not resident");
			NAV.press_buttonByName("Parhau");

			NAV.textPresentOnPage("A yw'r unigolyn yn glaf dan");
			GRP.click_radioButtonWithLabel("Ydi");
			NAV.set_valueTo("Rhowch fanylion", "Am sectioned");
			NAV.press_buttonByName("Parhau");

			NAV.textPresentOnPage("A oes gan yr unigolyn ddiffyg galluedd meddyliol");
			GRP.click_radioButtonWithLabel("Ydi");
			NAV.set_valueTo("Rhowch fanylion", "Lack capacity");
			NAV.press_buttonByName("Parhau");

			NAV.textPresentOnPage("A yw'r unigolyn ar fechnïaeth");
			GRP.click_radioButtonWithLabel("Ydi");
			NAV.set_valueTo("Rhowch fanylion", "Bailed");
			NAV.press_buttonByName("Parhau");

			NAV.textPresentOnPage("A yw'r unigolyn wedi'i gael");
			GRP.click_radioButtonWithLabel("Ydi");
			NAV.set_valueTo("Rhowch fanylion", "Convicted");
			NAV.press_buttonByName("Parhau");

			GRP.click_radioButtonWithLabel("Ydi, mae'r unigolyn yn gallu dechrau");
			NAV.press_buttonByName("Parhau");

			GRP.click_radioButtonWithLabel("Naddo");
			NAV.press_buttonByName("Parhau");

			NAV.textPresentOnPage("A oes gan yr unigolyn anabledd neu nam");
			GRP.click_radioButtonWithLabel("Nac oes");
			NAV.press_buttonByName("Parhau");

			NAV.check_checkbox("Hyd gwn i, mae'r wybodaeth rwyf wedi ei rhoi am yr unigolyn rwyf yn ymateb ar ei ran yn gywir.");
			NAV.press_buttonByName("Cyflwyno");

			NAV.textPresentOnPage("Rydych wedi cwblhau'r broses ymateb");

		}
	}

	@Given("^I have submitted a first party English deferral response$")
	public void submitFirstEnglishDeferralResponse(DataTable arg1) throws Throwable {
		List<Map<String, String>> list = arg1.asMaps(String.class, String.class);
		for (int i = 0; i < list.size(); i++) {
			String part_no = list.get(i).get("part_no");
			String pool_number = list.get(i).get("pool_number");
			String last_name = list.get(i).get("last_name");
			String postcode = list.get(i).get("postcode");
			String email = list.get(i).get("email");
			String env = "demo";
			if (System.getProperty("env.database") != null)
				env = System.getProperty("env.database");

			NAV.accessLoginPage("public", env);

			GRP.click_radioButtonWithLabel("I am replying for myself");
			NAV.press_buttonByName("Continue");
			NAV.textPresentOnPage("You can find your juror number on your jury summons letter.");
			NAV.set_valueTo("9-digit juror number", part_no);
			NAV.set_valueTo("Juror last name", last_name);
			NAV.set_valueTo("Juror postcode", postcode);
			NAV.press_buttonByName("Continue");
			NAV.textPresentOnPage("Is the name we have for you correct?");
			GRP.click_radioButtonWithLabel("Yes");
			NAV.press_buttonByName("Continue");
			NAV.textPresentOnPage("Is this your address?");
			GRP.click_radioButtonWithLabel("Yes");
			NAV.press_buttonByName("Continue");

			NAV.set_valueTo("Main phone", "07551179225");
			NAV.press_buttonByName("Continue");

			NAV.set_valueTo("Enter your email address", email);
			NAV.set_valueTo("Enter your email address again", email);
			NAV.press_buttonByName("Continue");

			NAV.set_valueTo("Day", "27");
			NAV.set_valueTo("Month", "09");
			NAV.set_valueTo("Year", "1981");
			NAV.press_buttonByName("Continue");


			NAV.textPresentOnPage("Eligibility");
			NAV.press_buttonByName("Continue");

			GRP.click_radioButtonWithLabel("Yes");
			NAV.press_buttonByName("Continue");

			NAV.textPresentOnPage("Are you being detained");
			GRP.click_radioButtonWithLabel("No");
			NAV.press_buttonByName("Continue");

			NAV.textPresentOnPage("Has it been decided that you 'lack mental capacity'?");
			GRP.click_radioButtonWithLabel("No");
			NAV.press_buttonByName("Continue");


			NAV.textPresentOnPage("Are you currently");
			GRP.click_radioButtonWithLabel("No");
			NAV.press_buttonByName("Continue");

			NAV.textPresentOnPage("Have you been");
			GRP.click_radioButtonWithLabel("No");
			NAV.press_buttonByName("Continue");

			GRP.click_radioButtonWithLabel("I need to change the date");
			NAV.press_buttonByName("Continue");

			NAV.set_valueTo("You can only change the date of your jury service once", "Defer me please");
			NAV.press_buttonByName("Continue");

			NAV.set_value_to("First date", "{12 mondays time}");
			NAV.set_value_to("Second date", "{15 mondays time}");
			NAV.set_value_to("Third date", "{18 mondays time}");
			NAV.press_buttonByName("Continue");

			GRP.click_radioButtonWithLabel("No");
			NAV.press_buttonByName("Continue");

			NAV.textPresentOnPage("Do you have a disability");
			GRP.click_radioButtonWithLabel("No");
			NAV.press_buttonByName("Continue");

			NAV.check_checkbox("The information I have given is true to the best of my knowle");
			NAV.press_buttonByName("Submit");

			NAV.textPresentOnPage("You have completed your reply");

		}
	}

	@Given("^I have submitted a third party English deferral response$")
	public void submitThirdEnglishDeferralResponse(DataTable arg1) throws Throwable {
		List<Map<String, String>> list = arg1.asMaps(String.class, String.class);
		for (int i = 0; i < list.size(); i++) {
			String part_no = list.get(i).get("part_no");
			String pool_number = list.get(i).get("pool_number");
			String last_name = list.get(i).get("last_name");
			String postcode = list.get(i).get("postcode");
			String email = list.get(i).get("email");
			String env = "demo";
			if (System.getProperty("env.database") != null)
				env = System.getProperty("env.database");

			NAV.accessLoginPage("public", env);

//		NAV.press_buttonByName("Start now");
			GRP.click_radioButtonWithLabel("I am replying for someone else");
			NAV.press_buttonByName("Continue");
			NAV.textPresentOnPage("You can find their juror number on the jury summons letter.");
			NAV.set_valueTo("9-digit juror number", part_no);
			NAV.set_valueTo("Juror last name", last_name);
			NAV.set_valueTo("Juror postcode", postcode);
			NAV.press_buttonByName("Continue");

			NAV.textPresentOnPage("What is your name?");
			NAV.set_valueTo("First name", "FirstName");
			NAV.set_valueTo("Last name", "LastName");
			NAV.press_buttonByName("Continue");

			NAV.textPresentOnPage("Your relationship to the person");
			NAV.set_valueTo("How do you know the person you're replying for?", "Friend");
			NAV.press_buttonByName("Continue");

			NAV.textPresentOnPage("Your contact information");
			NAV.check_checkbox("By phone (UK Numbers only)");
			NAV.set_valueTo("Main phone", "07551179225");
			NAV.check_checkbox("By email");
			NAV.set_valueTo("Enter your email address", email);
			NAV.set_valueTo("Enter your email address again", email);
			NAV.press_buttonByName("Continue");

			NAV.textPresentOnPage("Why are you replying for the other person?");
			GRP.click_radioButtonWithLabel("The person is not here");
			NAV.press_buttonByName("Continue");

			NAV.textPresentOnPage("Is the name we have for them correct?");
			GRP.click_radioButtonWithLabel("Yes");
			NAV.press_buttonByName("Continue");
			NAV.textPresentOnPage("Is this their address?");
			GRP.click_radioButtonWithLabel("Yes");
			NAV.press_buttonByName("Continue");

			NAV.textPresentOnPage("Give the date of birth for the person you're replying for");
			NAV.set_valueTo("Day", "27");
			NAV.set_valueTo("Month", "09");
			NAV.set_valueTo("Year", "1981");
			NAV.press_buttonByName("Continue");

			NAV.textPresentOnPage("We might need to get in touch with the person to ask them more questions or give them information about their jury service");
			GRP.click_radioButtonWithLabel("Use the phone number that you have already given to contact you");
			GRP.click_radioButtonWithLabel("Use the email address that you have already given to contact you");
			NAV.press_buttonByName("Continue");

			NAV.textPresentOnPage("Confirm if the person is eligible for jury service");
			NAV.press_buttonByName("Continue");

			GRP.click_radioButtonWithLabel("Yes");
			NAV.press_buttonByName("Continue");

			GRP.click_radioButtonWithLabel("No");
			NAV.press_buttonByName("Continue");

			GRP.click_radioButtonWithLabel("No");
			NAV.press_buttonByName("Continue");

			GRP.click_radioButtonWithLabel("No");
			NAV.press_buttonByName("Continue");

			GRP.click_radioButtonWithLabel("No");
			NAV.press_buttonByName("Continue");

			GRP.click_radioButtonWithLabel("No");
			NAV.press_buttonByName("Continue");

			GRP.click_radioButtonWithLabel("No, we need to change the date");
			NAV.press_buttonByName("Continue");

			NAV.setTextAreaWith_toText("id", "deferralReason", "Defer them please");
			NAV.press_buttonByName("Continue");

			NAV.set_value_to("First choice", "{12 mondays time}");
			NAV.set_value_to("Second choice", "{15 mondays time}");
			NAV.set_value_to("Third choice", "{18 mondays time}");

			NAV.press_buttonByName("Continue");

			GRP.click_radioButtonWithLabel("Yes");
			NAV.press_buttonByName("Continue");

			GRP.click_radioButtonWithLabel("No");
			NAV.press_buttonByName("Continue");

			NAV.check_checkbox("The answers I have given for the person I'm replying for are true as far as I know");
			NAV.press_buttonByName("Submit");

			NAV.textPresentOnPage("You have completed your reply");

		}
	}

	@Given("^I have submitted a first party Welsh deferral response$")
	public void submitFirstWelshDeferralResponse(DataTable arg1) throws Throwable {
		List<Map<String, String>> list = arg1.asMaps(String.class, String.class);
		for (int i = 0; i < list.size(); i++) {
			String part_no = list.get(i).get("part_no");
			String pool_number = list.get(i).get("pool_number");
			String last_name = list.get(i).get("last_name");
			String postcode = list.get(i).get("postcode");
			String email = list.get(i).get("email");
			String env = "demo";
			if (System.getProperty("env.database") != null)
				env = System.getProperty("env.database");

			NAV.accessLoginPageWelsh("public", env);

//			NAV.click_link_by_text("Welsh (Cymraeg)");
//			NAV.press_buttonByName("Dechrau nawr");
			GRP.click_radioButtonWithLabel("Rwy'n ymateb dros fy hun");
			NAV.press_buttonByName("Parhau");
//			NAV.textPresentOnPage("Gellir dod o hyd i'ch rhif rheithiwr ar eich llythyr gwŷs rheithgor");
			NAV.set_valueTo("Rhif rheithiwr – 9 digid", part_no);
			NAV.set_valueTo("Cyfenw'r Rheithiwr", last_name);
			NAV.set_valueTo("Cod post Rheithiwr", postcode);
			NAV.press_buttonByName("Parhau");
			NAV.textPresentOnPage("A yw'r enw sydd gennym ar eich cyfer chi yn gywir?");
			GRP.click_radioButtonWithLabel("Ydy");
			NAV.press_buttonByName("Parhau");
			NAV.textPresentOnPage("Eich cyfeiriad chi yw hwn?");
			GRP.click_radioButtonWithLabel("Ie");
			NAV.press_buttonByName("Parhau");

			NAV.set_valueTo("Prif rif ffôn", "07551179225");
			NAV.press_buttonByName("Parhau");

			NAV.set_valueTo("Nodwch eich cyfeiriad e-bost", email);
			NAV.set_valueTo("Nodwch eich cyfeiriad e-bost eto", email);
			NAV.press_buttonByName("Parhau");

			NAV.set_valueTo("Diwrnod", "27");
			NAV.set_valueTo("Mis", "09");
			NAV.set_valueTo("Blwyddyn", "1981");
			NAV.press_buttonByName("Parhau");

			NAV.textPresentOnPage("Cymhwyso ar gyfer gwasanaeth rheithgor");
			NAV.press_buttonByName("Parhau");

			GRP.click_radioButtonWithLabel("Do");
			NAV.press_buttonByName("Parhau");

			NAV.textPresentOnPage("A ydych chi'n glaf dan orchymyn");
			GRP.click_radioButtonWithLabel("Nac ydw");
			NAV.press_buttonByName("Parhau");

			NAV.textPresentOnPage("A oes gennych ddiffyg galluedd meddyliol");
			GRP.click_radioButtonWithLabel("Nac oes");
			NAV.press_buttonByName("Parhau");

			NAV.textPresentOnPage("A ydych chi ar fechn");
			GRP.click_radioButtonWithLabel("Nac ydw");
			NAV.press_buttonByName("Parhau");

			NAV.textPresentOnPage("A ydych wedi'ch cael");
			GRP.click_radioButtonWithLabel("Naddo");
			NAV.press_buttonByName("Parhau");

			GRP.click_radioButtonWithLabel("Rwyf angen newid dyddiad");
			NAV.press_buttonByName("Parhau");

			NAV.set_valueTo("Dim ond unwaith y gallwch newid dyddiad eich gwasanaeth rheithgor", "Defer me please");
			NAV.press_buttonByName("Parhau");

			NAV.set_value_to("Dyddiad 1", "{12 mondays time}");
			NAV.set_value_to("Dyddiad 2", "{15 mondays time}");
			NAV.set_value_to("Dyddiad 3", "{18 mondays time}");
			NAV.press_buttonByName("Parhau");

			GRP.click_radioButtonWithLabel("Nac ydw");
			NAV.press_buttonByName("Parhau");

			NAV.textPresentOnPage("A oes gennych anabledd neu nam");
			GRP.click_radioButtonWithLabel("Nac oes");
			NAV.press_buttonByName("Parhau");

			NAV.check_checkbox("Mae'r wybodaeth a roddais uchod yn wir hyd eithaf fy ngwybodaeth.");
			NAV.press_buttonByName("Cyflwyno");

			NAV.textPresentOnPage("Rydych wedi cwblhau'r broses ymateb");

		}
	}

	@Given("^I have submitted a third party Welsh deferral response$")
	public void submitThirdWelshDeferralResponse(DataTable arg1) throws Throwable {
		List<Map<String, String>> list = arg1.asMaps(String.class, String.class);
		for (int i = 0; i < list.size(); i++) {
			String part_no = list.get(i).get("part_no");
			String pool_number = list.get(i).get("pool_number");
			String last_name = list.get(i).get("last_name");
			String postcode = list.get(i).get("postcode");
			String email = list.get(i).get("email");
			String env = "demo";
			if (System.getProperty("env.database") != null)
				env = System.getProperty("env.database");

			NAV.accessLoginPage("public", env);

			NAV.click_link_by_text("Welsh (Cymraeg)");
			NAV.press_buttonByName("Dechrau nawr");
			GRP.click_radioButtonWithLabel("Rwy'n ymateb ar ran rhywun arall");
			NAV.press_buttonByName("Parhau");
			NAV.textPresentOnPage("Gellir dod o hyd i'r rhif rheithiwr ar y llythyr gwŷs rheithgor");
			NAV.set_valueTo("Rhif rheithiwr – 9 digid", part_no);
			NAV.set_valueTo("Cyfenw'r Rheithiwr", last_name);
			NAV.set_valueTo("Cod post Rheithiwr", postcode);
			NAV.press_buttonByName("Parhau");

			NAV.textPresentOnPage("Beth yw eich enw?");
			NAV.set_valueTo("Enw cyntaf", "FirstName");
			NAV.set_valueTo("Cyfenw", "LastName");
			NAV.press_buttonByName("Parhau");

			NAV.textPresentOnPage("Eich perthynas â'r unigolyn");
			NAV.set_valueTo("Sut ydych chi'n adnabod yr unigolyn rydych yn ymateb ar ei ran?", "Friend");
			NAV.press_buttonByName("Parhau");

			NAV.textPresentOnPage("Eich manylion cyswllt");
			NAV.check_checkbox("Dros y ffôn (rhifau yn y DU yn unig)");
			NAV.set_valueTo("Prif rif ffôn", "02078211818");
			NAV.check_checkbox("Trwy e-bost");
			NAV.set_valueTo("Nodwch gyfeiriad e-bost", email);
			NAV.set_valueTo("Nodwch gyfeiriad e-bost eto", email);
			NAV.press_buttonByName("Parhau");

			NAV.textPresentOnPage("Pam ydych chi'n ymateb ar ran yr unigolyn arall?");
			GRP.click_radioButtonWithLabel("Nid yw'r unigolyn yma");
			NAV.press_buttonByName("Parhau");

			NAV.textPresentOnPage("A yw'r enw sydd gennym ar ei gyfer yn gywir?");
			GRP.click_radioButtonWithLabel("Ydy");
			NAV.press_buttonByName("Parhau");
			NAV.textPresentOnPage("Ei gyfeiriad ef yw hwn?");
			GRP.click_radioButtonWithLabel("Ie");
			NAV.press_buttonByName("Parhau");

			NAV.textPresentOnPage("Nodwch ddyddiad geni'r unigolyn rydych chi'n ymateb ar ei ran");
			NAV.set_valueTo("Diwrnod", "27");
			NAV.set_valueTo("Mis", "09");
			NAV.set_valueTo("Blwyddyn", "1981");
			NAV.press_buttonByName("Parhau");

			NAV.textPresentOnPage("Efallai bydd yn rhaid inni gysylltu â'r unigolyn i ofyn rhagor o gwestiynau neu roi rhagor o wybodaeth iddynt am eu gwasanaeth rheithgor");
			GRP.click_radioButtonWithLabel("Defnyddio'r rhif ffôn rydych eisoes wedi'i ddarparu i gysylltu â chi");
			GRP.click_radioButtonWithLabel("Defnyddio'r cyfeiriad e-bost rydych eisoes wedi'i ddarparu i gysylltu â chi");
			NAV.press_buttonByName("Parhau");

			NAV.textPresentOnPage("A yw'r unigolyn rydych chi'n ymateb ar ei ran yn gymwys i wasanaethu ar reithgor?");
			NAV.press_buttonByName("Parhau");

			GRP.click_radioButtonWithLabel("Do");
			NAV.press_buttonByName("Parhau");

			NAV.textPresentOnPage("A yw'r unigolyn yn glaf dan");
			GRP.click_radioButtonWithLabel("Nac ydi");
			NAV.press_buttonByName("Parhau");

			NAV.textPresentOnPage("A oes gan yr unigolyn ddiffyg galluedd meddyliol");
			GRP.click_radioButtonWithLabel("Nac ydi");
			NAV.press_buttonByName("Parhau");

			NAV.textPresentOnPage("A yw'r unigolyn ar fechnïaeth");
			GRP.click_radioButtonWithLabel("Nac ydi");
			NAV.press_buttonByName("Parhau");

			NAV.textPresentOnPage("A yw'r unigolyn wedi'i gael");
			GRP.click_radioButtonWithLabel("Nac ydi");
			NAV.press_buttonByName("Parhau");

			GRP.click_radioButtonWithLabel("Rydw i angen newid dyddiad");
			NAV.press_buttonByName("Parhau");

			NAV.set_valueTo("Dim ond unwaith y gallwch newid dyddiad y gwasanaeth rheithgor", "Defer them please");
			NAV.press_buttonByName("Parhau");

			NAV.set_value_to("Dyddiad 1", "{12 mondays time}");
			NAV.set_value_to("Dyddiad 2", "{15 mondays time}");
			NAV.set_value_to("Dyddiad 3", "{18 mondays time}");
			NAV.press_buttonByName("Parhau");

			GRP.click_radioButtonWithLabel("Naddo");
			NAV.press_buttonByName("Parhau");

			NAV.textPresentOnPage("A oes gan yr unigolyn anabledd neu nam");
			GRP.click_radioButtonWithLabel("Nac oes");
			NAV.press_buttonByName("Parhau");

			NAV.check_checkbox("Hyd gwn i, mae'r wybodaeth rwyf wedi ei rhoi am yr unigolyn rwyf yn ymateb ar ei ran yn gywir.");
			NAV.press_buttonByName("Cyflwyno");

			NAV.textPresentOnPage("Rydych wedi cwblhau'r broses ymateb");

		}
	}

	@Given("^I have submitted a first party English excusal response$")
	public void submitFirstEnglishExcusalResponse(DataTable arg1) throws Throwable {
		List<Map<String, String>> list = arg1.asMaps(String.class, String.class);
		for (int i = 0; i < list.size(); i++) {
			String part_no = list.get(i).get("part_no");
			String pool_number = list.get(i).get("pool_number");
			String last_name = list.get(i).get("last_name");
			String postcode = list.get(i).get("postcode");
			String email = list.get(i).get("email");
			String env = "demo";
			if (System.getProperty("env.database") != null)
				env = System.getProperty("env.database");

			NAV.accessLoginPage("public", env);

			GRP.click_radioButtonWithLabel("I am replying for myself");
			NAV.press_buttonByName("Continue");
			NAV.textPresentOnPage("You can find your juror number on your jury summons letter.");
			NAV.set_valueTo("9-digit juror number", part_no);
			NAV.set_valueTo("Juror last name", last_name);
			NAV.set_valueTo("Juror postcode", postcode);
			NAV.press_buttonByName("Continue");
			NAV.textPresentOnPage("Is the name we have for you correct?");
			GRP.click_radioButtonWithLabel("Yes");
			NAV.press_buttonByName("Continue");
			NAV.textPresentOnPage("Is this your address?");
			GRP.click_radioButtonWithLabel("Yes");
			NAV.press_buttonByName("Continue");

			NAV.set_valueTo("Main phone", "07590309447");
			NAV.press_buttonByName("Continue");

			NAV.waitForPageLoad();

			NAV.set_valueTo("Enter your email address", email);
			NAV.set_valueTo("Enter your email address again", email);
			NAV.press_buttonByName("Continue");

			NAV.set_valueTo("Day", "27");
			NAV.set_valueTo("Month", "09");
			NAV.set_valueTo("Year", "1981");
			NAV.press_buttonByName("Continue");

			NAV.textPresentOnPage("eligible for jury service");
			NAV.press_buttonByName("Continue");

			GRP.click_radioButtonWithLabel("Yes");
			NAV.press_buttonByName("Continue");

			NAV.textPresentOnPage("Have you worked");
			GRP.click_radioButtonWithLabel("No");
			NAV.press_buttonByName("Continue");

			NAV.textPresentOnPage("Are you currently");
			GRP.click_radioButtonWithLabel("No");
			NAV.press_buttonByName("Continue");

			NAV.textPresentOnPage("Have you been");
			GRP.click_radioButtonWithLabel("No");
			NAV.press_buttonByName("Continue");

			NAV.textPresentOnPage("Are you being detained");
			GRP.click_radioButtonWithLabel("No");
			NAV.press_buttonByName("Continue");

			NAV.textPresentOnPage("Has it been decided that you 'lack mental capacity'?");
			GRP.click_radioButtonWithLabel("No");
			NAV.press_buttonByName("Continue");

			GRP.click_radioButtonWithLabel("I cannot do jury service and need to be excused");
			NAV.press_buttonByName("Continue");

			NAV.set_valueTo("Why do you need to be", "Excuse me please");
			NAV.press_buttonByName("Continue");

			GRP.click_radioButtonWithLabel("No");
			NAV.press_buttonByName("Continue");

			NAV.check_checkbox("The information I have given is true to the best of my knowle");
			NAV.press_buttonByName("Submit");

			NAV.textPresentOnPage("You have completed your reply");

		}
	}

	@Given("^I have submitted a third party English excusal response$")
	public void submitThirdEnglishExcusalResponse(DataTable arg1) throws Throwable {
		List<Map<String, String>> list = arg1.asMaps(String.class, String.class);
		for (int i = 0; i < list.size(); i++) {
			String part_no = list.get(i).get("part_no");
			String pool_number = list.get(i).get("pool_number");
			String last_name = list.get(i).get("last_name");
			String postcode = list.get(i).get("postcode");
			String email = list.get(i).get("email");
			String env = "demo";
			if (System.getProperty("env.database") != null)
				env = System.getProperty("env.database");

			NAV.accessLoginPage("public", env);

			GRP.click_radioButtonWithLabel("I am replying for someone else");
			NAV.press_buttonByName("Continue");
			NAV.textPresentOnPage("You can find their juror number on the jury summons letter.");
			NAV.set_valueTo("9-digit juror number", part_no);
			NAV.set_valueTo("Juror last name", last_name);
			NAV.set_valueTo("Juror postcode", postcode);
			NAV.press_buttonByName("Continue");

			NAV.textPresentOnPage("What is your name?");
			NAV.set_valueTo("First name", "FirstName");
			NAV.set_valueTo("Last name", "LastName");
			NAV.press_buttonByName("Continue");

			NAV.textPresentOnPage("Your relationship to the person");
			NAV.set_valueTo("How do you know the person you're replying for?", "Friend");
			NAV.press_buttonByName("Continue");

			NAV.textPresentOnPage("Your contact information");
			NAV.check_checkbox("By phone (UK Numbers only)");
			NAV.set_valueTo("Main phone", "02078211818");
			NAV.check_checkbox("By email");
			NAV.set_valueTo("Enter your email address", email);
			NAV.set_valueTo("Enter your email address again", email);
			NAV.press_buttonByName("Continue");

			NAV.textPresentOnPage("Why are you replying for the other person?");
			GRP.click_radioButtonWithLabel("The person is not here");
			NAV.press_buttonByName("Continue");

			NAV.textPresentOnPage("Is the name we have for them correct?");
			GRP.click_radioButtonWithLabel("Yes");
			NAV.press_buttonByName("Continue");
			NAV.textPresentOnPage("Is this their address?");
			GRP.click_radioButtonWithLabel("Yes");
			NAV.press_buttonByName("Continue");

			NAV.textPresentOnPage("Give the date of birth for the person you're replying for");
			NAV.set_valueTo("Day", "27");
			NAV.set_valueTo("Month", "09");
			NAV.set_valueTo("Year", "1981");
			NAV.press_buttonByName("Continue");

			NAV.textPresentOnPage("We might need to get in touch with the person to ask them more questions or give them information about their jury service");
			GRP.click_radioButtonWithLabel("Use the phone number that you have already given to contact you");
			GRP.click_radioButtonWithLabel("Use the email address that you have already given to contact you");
			NAV.press_buttonByName("Continue");

			NAV.textPresentOnPage("Confirm if the person is eligible for jury service");
			NAV.press_buttonByName("Continue");

			GRP.click_radioButtonWithLabel("Yes");
			NAV.press_buttonByName("Continue");

			NAV.textPresentOnPage("Has the person you're replying for worked in the criminal justice system in the last 5 years?");
			GRP.click_radioButtonWithLabel("No");
			NAV.press_buttonByName("Continue");

			NAV.textPresentOnPage("Is the person currently on bail for a criminal offence?");
			GRP.click_radioButtonWithLabel("No");
			NAV.press_buttonByName("Continue");

			NAV.textPresentOnPage("Has the person been found guilty");
			GRP.click_radioButtonWithLabel("No");
			NAV.press_buttonByName("Continue");

			NAV.textPresentOnPage("Is the person you're replying for being detained");
			GRP.click_radioButtonWithLabel("No");
			NAV.press_buttonByName("Continue");

			NAV.textPresentOnPage("Has it been decided that the person you're replying for 'lacks mental capacity'?");
			GRP.click_radioButtonWithLabel("No");
			NAV.press_buttonByName("Continue");

			GRP.click_radioButtonWithLabel("No, they cannot do jury service and need to be excused");
			NAV.press_buttonByName("Continue");

			NAV.set_valueTo("Why do they need", "Excuse them please");
			NAV.press_buttonByName("Continue");

			GRP.click_radioButtonWithLabel("No");
			NAV.press_buttonByName("Continue");

			NAV.check_checkbox("The answers I have given for the person I'm replying for are true as far as I know.");
			NAV.press_buttonByName("Submit");

			NAV.textPresentOnPage("You have completed your reply");

		}
	}

	@Given("^I have submitted a first party Welsh excusal response$")
	public void submitFirstWelshExcusalResponse(DataTable arg1) throws Throwable {
		List<Map<String, String>> list = arg1.asMaps(String.class, String.class);
		for (int i = 0; i < list.size(); i++) {
			String part_no = list.get(i).get("part_no");
			String pool_number = list.get(i).get("pool_number");
			String last_name = list.get(i).get("last_name");
			String postcode = list.get(i).get("postcode");
			String email = list.get(i).get("email");
			String env = "demo";
			if (System.getProperty("env.database") != null)
				env = System.getProperty("env.database");

			NAV.accessLoginPageWelsh("public", env);

//	NAV.click_link_by_text("Welsh (Cymraeg)");
//	NAV.press_buttonByName("Dechrau nawr");
			GRP.click_radioButtonWithLabel("Rwy'n ymateb dros fy hun");
			NAV.press_buttonByName("Parhau");
			NAV.textPresentOnPage("Gellir dod o hyd i'r rhif rheithiwr ar frig y llythyr gwŷs");
			NAV.set_valueTo("Rhif rheithiwr – 9 digid", part_no);
			NAV.set_valueTo("Cyfenw'r Rheithiwr", last_name);
			NAV.set_valueTo("Cod post Rheithiwr", postcode);
			NAV.press_buttonByName("Parhau");
			NAV.textPresentOnPage("A yw'r enw sydd gennym ar eich cyfer chi yn gywir?");
			GRP.click_radioButtonWithLabel("Ydy");
			NAV.press_buttonByName("Parhau");
			NAV.textPresentOnPage("Eich cyfeiriad chi yw hwn?");
			GRP.click_radioButtonWithLabel("Ie");
			NAV.press_buttonByName("Parhau");

			NAV.set_valueTo("Prif rif ffôn", "07551179225");
			NAV.press_buttonByName("Parhau");

			NAV.set_valueTo("Nodwch eich cyfeiriad e-bost", email);
			NAV.set_valueTo("Nodwch eich cyfeiriad e-bost eto", email);
			NAV.press_buttonByName("Parhau");

			NAV.set_valueTo("Diwrnod", "27");
			NAV.set_valueTo("Mis", "09");
			NAV.set_valueTo("Blwyddyn", "1981");
			NAV.press_buttonByName("Parhau");

			NAV.textPresentOnPage("Cymhwyso ar gyfer gwasanaeth rheithgor");
			NAV.press_buttonByName("Parhau");

			GRP.click_radioButtonWithLabel("Do");
			NAV.press_buttonByName("Parhau");

			NAV.textPresentOnPage("A ydych chi'n glaf dan orchymyn");
			GRP.click_radioButtonWithLabel("Nac ydw");
			NAV.press_buttonByName("Parhau");

			NAV.textPresentOnPage("A oes gennych ddiffyg galluedd meddyliol");
			GRP.click_radioButtonWithLabel("Nac oes");
			NAV.press_buttonByName("Parhau");

			NAV.textPresentOnPage("A ydych chi ar fechn");
			GRP.click_radioButtonWithLabel("Nac ydw");
			NAV.press_buttonByName("Parhau");

			NAV.textPresentOnPage("A ydych wedi'ch cael");
			GRP.click_radioButtonWithLabel("Naddo");
			NAV.press_buttonByName("Parhau");

			GRP.click_radioButtonWithLabel("Nac ydw, ni allaf wasanaethu ar reithgor a hoffwn gael fy esgusodi");
			NAV.press_buttonByName("Parhau");

			NAV.set_valueTo("Rhowch reswm byr pam na allwch chi wneud gwasanaeth rheithgor yn y 12 mis nesaf. Os oes arnom angen gwybodaeth neu dystiolaeth bellach, byddwn yn cysylltu ȃ chi. Nid oes angen i chi anfon gwybodaeth ychwanegol ar hyn o bryd.", "Excuse me please");
			NAV.press_buttonByName("Parhau");

			GRP.click_radioButtonWithLabel("Nac ydw");
			NAV.press_buttonByName("Parhau");

			NAV.textPresentOnPage("A oes gennych anabledd neu nam");
			GRP.click_radioButtonWithLabel("Nac oes");
			NAV.press_buttonByName("Parhau");

			NAV.check_checkbox("Mae'r wybodaeth a roddais uchod yn wir hyd eithaf fy ngwybodaeth.");
			NAV.press_buttonByName("Cyflwyno");

			NAV.textPresentOnPage("Rydych wedi cwblhau'r broses ymateb");

		}
	}

	@Given("^I have submitted a third party Welsh excusal response$")
	public void submitThirdWelshExcusalResponse(DataTable arg1) throws Throwable {
		List<Map<String, String>> list = arg1.asMaps(String.class, String.class);
		for (int i = 0; i < list.size(); i++) {
			String part_no = list.get(i).get("part_no");
			String pool_number = list.get(i).get("pool_number");
			String last_name = list.get(i).get("last_name");
			String postcode = list.get(i).get("postcode");
			String email = list.get(i).get("email");
			String env = "demo";
			if (System.getProperty("env.database") != null)
				env = System.getProperty("env.database");

			NAV.accessLoginPage("public", env);

			NAV.click_link_by_text("Welsh (Cymraeg)");
			NAV.press_buttonByName("Dechrau nawr");
			GRP.click_radioButtonWithLabel("Rwy'n ymateb ar ran rhywun arall");
			NAV.press_buttonByName("Parhau");
			NAV.textPresentOnPage("Gellir dod o hyd i'r rhif rheithiwr ar y llythyr gwŷs rheithgor");
			NAV.set_valueTo("Rhif rheithiwr – 9 digid", part_no);
			NAV.set_valueTo("Cyfenw'r Rheithiwr", last_name);
			NAV.set_valueTo("Cod post Rheithiwr", postcode);
			NAV.press_buttonByName("Parhau");

			NAV.textPresentOnPage("Beth yw eich enw?");
			NAV.set_valueTo("Enw cyntaf", "FirstName");
			NAV.set_valueTo("Cyfenw", "LastName");
			NAV.press_buttonByName("Parhau");

			NAV.textPresentOnPage("Eich perthynas â'r unigolyn");
			NAV.set_valueTo("Sut ydych chi'n adnabod yr unigolyn rydych yn ymateb ar ei ran?", "Friend");
			NAV.press_buttonByName("Parhau");

			NAV.textPresentOnPage("Eich manylion cyswllt");
			NAV.check_checkbox("Dros y ffôn (rhifau yn y DU yn unig)");
			NAV.set_valueTo("Prif rif ffôn", "02078211818");
			NAV.check_checkbox("Trwy e-bost");
			NAV.set_valueTo("Nodwch gyfeiriad e-bost", email);
			NAV.set_valueTo("Nodwch gyfeiriad e-bost eto", email);
			NAV.press_buttonByName("Parhau");

			NAV.textPresentOnPage("Pam ydych chi'n ymateb ar ran yr unigolyn arall?");
			GRP.click_radioButtonWithLabel("Nid yw'r unigolyn yma");
			NAV.press_buttonByName("Parhau");

			NAV.textPresentOnPage("A yw'r enw sydd gennym ar ei gyfer yn gywir?");
			GRP.click_radioButtonWithLabel("Ydy");
			NAV.press_buttonByName("Parhau");
			NAV.textPresentOnPage("Ei gyfeiriad ef yw hwn?");
			GRP.click_radioButtonWithLabel("Ie");
			NAV.press_buttonByName("Parhau");

			NAV.textPresentOnPage("Nodwch ddyddiad geni'r unigolyn rydych chi'n ymateb ar ei ran");
			NAV.set_valueTo("Diwrnod", "27");
			NAV.set_valueTo("Mis", "09");
			NAV.set_valueTo("Blwyddyn", "1981");
			NAV.press_buttonByName("Parhau");

			NAV.textPresentOnPage("Efallai bydd yn rhaid inni gysylltu â'r unigolyn i ofyn rhagor o gwestiynau neu roi rhagor o wybodaeth iddynt am eu gwasanaeth rheithgor");
			GRP.click_radioButtonWithLabel("Defnyddio'r rhif ffôn rydych eisoes wedi'i ddarparu i gysylltu â chi");
			GRP.click_radioButtonWithLabel("Defnyddio'r cyfeiriad e-bost rydych eisoes wedi'i ddarparu i gysylltu â chi");
			NAV.press_buttonByName("Parhau");

			NAV.textPresentOnPage("A yw'r unigolyn rydych chi'n ymateb ar ei ran yn gymwys i wasanaethu ar reithgor?");
			NAV.press_buttonByName("Parhau");

			GRP.click_radioButtonWithLabel("Do");
			NAV.press_buttonByName("Parhau");

			NAV.textPresentOnPage("A yw'r unigolyn yn glaf dan");
			GRP.click_radioButtonWithLabel("Nac ydi");
			NAV.press_buttonByName("Parhau");

			NAV.textPresentOnPage("A oes gan yr unigolyn ddiffyg galluedd meddyliol");
			GRP.click_radioButtonWithLabel("Nac ydi");
			NAV.press_buttonByName("Parhau");

			NAV.textPresentOnPage("A yw'r unigolyn ar fechnïaeth");
			GRP.click_radioButtonWithLabel("Nac ydi");
			NAV.press_buttonByName("Parhau");

			NAV.textPresentOnPage("A yw'r unigolyn wedi'i gael");
			GRP.click_radioButtonWithLabel("Nac ydi");
			NAV.press_buttonByName("Parhau");

			GRP.click_radioButtonWithLabel("Nid yw'r unigolyn rwy'n ymateb ar ei ran yn gallu gwasanaethu ar reithgor a hoffai gael ei esgusodi");
			NAV.press_buttonByName("Parhau");

			NAV.set_valueTo("Rhowch reswm byr pam na all yr unigolyn yr ydych yn ymateb ar ei ran wneud gwasanaeth rheithgor yn y 12 mis nesaf. Os oes arnom angen gwybodaeth neu dystiolaeth bellach, byddwn yn cysylltu ȃ chi. Nid oes angen i chi anfon gwybodaeth ychwanegol ar hyn o bryd.", "Excuse them please");
			NAV.press_buttonByName("Parhau");

			GRP.click_radioButtonWithLabel("Naddo");
			NAV.press_buttonByName("Parhau");

			NAV.textPresentOnPage("A oes gan yr unigolyn anabledd neu nam");
			GRP.click_radioButtonWithLabel("Nac oes");
			NAV.press_buttonByName("Parhau");

			NAV.check_checkbox("Hyd gwn i, mae'r wybodaeth rwyf wedi ei rhoi am yr unigolyn rwyf yn ymateb ar ei ran yn gywir.");
			NAV.press_buttonByName("Cyflwyno");

			NAV.textPresentOnPage("Rydych wedi cwblhau'r broses ymateb");

		}
	}

	@Given("^I have submitted a third party English deceased response$")
	public void submitThirdEnglishDeceasedResponse(DataTable arg1) throws Throwable {
		List<Map<String, String>> list = arg1.asMaps(String.class, String.class);
		for (int i = 0; i < list.size(); i++) {
			String part_no = list.get(i).get("part_no");
			String pool_number = list.get(i).get("pool_number");
			String last_name = list.get(i).get("last_name");
			String postcode = list.get(i).get("postcode");
			String email = list.get(i).get("email");
			String env = "demo";
			if (System.getProperty("env.database") != null)
				env = System.getProperty("env.database");

			NAV.accessLoginPage("public", env);

			GRP.click_radioButtonWithLabel("I am replying for someone else");
			NAV.press_buttonByName("Continue");
			NAV.textPresentOnPage("You can find their juror number on the jury summons letter");
			NAV.set_valueTo("9-digit juror number", part_no);
			NAV.set_valueTo("Juror last name", last_name);
			NAV.set_valueTo("Juror postcode", postcode);
			NAV.press_buttonByName("Continue");

			NAV.textPresentOnPage("What is your name?");
			NAV.set_valueTo("First name", "FirstName");
			NAV.set_valueTo("Last name", "LastName");
			NAV.press_buttonByName("Continue");

			NAV.textPresentOnPage("Your relationship to the person");
			NAV.set_valueTo("How do you know the person you're replying for?", "Friend");
			NAV.press_buttonByName("Continue");

			NAV.textPresentOnPage("Your contact information");
			NAV.check_checkbox("By phone (UK Numbers only)");
			NAV.set_valueTo("Main phone", "02078211818");
			NAV.check_checkbox("By email");
			NAV.set_valueTo("Enter your email address", email);
			NAV.set_valueTo("Enter your email address again", email);
			NAV.press_buttonByName("Continue");

			NAV.textPresentOnPage("Why are you replying for the other person?");
			GRP.click_radioButtonWithLabel("The person has died");
			NAV.press_buttonByName("Continue");

			NAV.textPresentOnPage("Check your answers now");
			NAV.check_checkbox("The answers I have given for the person I'm replying for are true as far as I know.");
			NAV.press_buttonByName("Submit");

			NAV.textPresentOnPage("You have completed your reply");
			NAV.textPresentOnPage("sorry for any distress");

		}
	}

	@Given("^I have submitted a third party Welsh deceased response$")
	public void submitThirdWelshDeceasedResponse(DataTable arg1) throws Throwable {
		List<Map<String, String>> list = arg1.asMaps(String.class, String.class);
		for (int i = 0; i < list.size(); i++) {
			String part_no = list.get(i).get("part_no");
			String pool_number = list.get(i).get("pool_number");
			String last_name = list.get(i).get("last_name");
			String postcode = list.get(i).get("postcode");
			String email = list.get(i).get("email");
			String env = "demo";
			if (System.getProperty("env.database") != null)
				env = System.getProperty("env.database");

//		NAV.accessLoginPage("public", env);

//		NAV.click_link_by_text("Welsh (Cymraeg)");
//		NAV.press_buttonByName("Dechrau nawr");
			GRP.click_radioButtonWithLabel("Rwy'n ymateb ar ran rhywun arall");
			NAV.press_buttonByName("Parhau");
//		NAV.textPresentOnPage("Gellir dod o hyd i'r rhif rheithiwr ar y llythyr gwŷs rheithgor");
			NAV.set_valueTo("Rhif rheithiwr – 9 digid", part_no);
			NAV.set_valueTo("Cyfenw'r Rheithiwr", last_name);
			NAV.set_valueTo("Cod post Rheithiwr", postcode);
			NAV.press_buttonByName("Parhau");

			NAV.textPresentOnPage("Beth yw eich enw?");
			NAV.set_valueTo("Enw cyntaf", "FirstName");
			NAV.set_valueTo("Cyfenw", "LastName");
			NAV.press_buttonByName("Parhau");

			NAV.textPresentOnPage("Eich perthynas â'r unigolyn");
			NAV.set_valueTo("Sut ydych chi'n adnabod yr unigolyn rydych yn ymateb ar ei ran?", "Friend");
			NAV.press_buttonByName("Parhau");

			NAV.textPresentOnPage("Eich manylion cyswllt");
			NAV.check_checkbox("Dros y ffôn (rhifau yn y DU yn unig)");
			NAV.set_valueTo("Prif rif ffôn", "02078211818");
			NAV.check_checkbox("Trwy e-bost");
			NAV.set_valueTo("Nodwch gyfeiriad e-bost", email);
			NAV.set_valueTo("Nodwch gyfeiriad e-bost eto", email);
			NAV.press_buttonByName("Parhau");

			NAV.textPresentOnPage("Pam ydych chi'n ymateb ar ran yr unigolyn arall?");
			GRP.click_radioButtonWithLabel("Mae'r unigolyn wedi marw");
			NAV.press_buttonByName("Parhau");

			NAV.check_checkbox("Hyd gwn i, mae'r wybodaeth rwyf wedi ei rhoi am yr unigolyn rwyf yn ymateb ar ei ran yn gywir.");
			NAV.press_buttonByName("Cyflwyno");

			NAV.textPresentOnPage("Rydych wedi cwblhau'r broses ymateb");
			NAV.textPresentOnPage("Ymddiheurwn am achosi unrhyw ofid");

		}
	}

	@Given("^I have submitted a first party English underage response$")
	public void submitFirstEnglishUnderageResponse(DataTable arg1) throws Throwable {
		List<Map<String, String>> list = arg1.asMaps(String.class, String.class);
		for (int i = 0; i < list.size(); i++) {
			String part_no = list.get(i).get("part_no");
			String pool_number = list.get(i).get("pool_number");
			String last_name = list.get(i).get("last_name");
			String postcode = list.get(i).get("postcode");
			String email = list.get(i).get("email");
			String env = "demo";
			if (System.getProperty("env.database") != null)
				env = System.getProperty("env.database");

			NAV.accessLoginPage("public", env);

			GRP.click_radioButtonWithLabel("I am replying for myself");
			NAV.press_buttonByName("Continue");
			NAV.textPresentOnPage("You can find your juror number on your jury summons letter.");
			NAV.set_valueTo("9-digit juror number", part_no);
			NAV.set_valueTo("Juror last name", last_name);
			NAV.set_valueTo("Juror postcode", postcode);
			NAV.press_buttonByName("Continue");
			NAV.textPresentOnPage("Is the name we have for you correct?");
			GRP.click_radioButtonWithLabel("Yes");
			NAV.press_buttonByName("Continue");
			NAV.textPresentOnPage("Is this your address?");
			GRP.click_radioButtonWithLabel("Yes");
			NAV.press_buttonByName("Continue");

			NAV.set_valueTo("Main phone", "02078211818");
			NAV.press_buttonByName("Continue");

			NAV.set_valueTo("Enter your email address", email);
			NAV.set_valueTo("Enter your email address again", email);
			NAV.press_buttonByName("Continue");

			NAV.set_valueTo("Day", "27");
			NAV.set_valueTo("Month", "09");
			NAV.set_valueTo("Year", "2005");
			NAV.press_buttonByName("Continue");

			NAV.textPresentOnPage("Confirm your date of birth");
			NAV.press_buttonByName("Continue");

			NAV.check_checkbox("The information I have given is true to the best of my knowle");
			NAV.press_buttonByName("Submit");

			NAV.textPresentOnPage("You have completed your reply");

		}
	}

	@Given("^I have submitted a third party English overage response$")
	public void submitThirdEnglishOverageResponse(DataTable arg1) throws Throwable {
		List<Map<String, String>> list = arg1.asMaps(String.class, String.class);
		for (int i = 0; i < list.size(); i++) {
			String part_no = list.get(i).get("part_no");
			String pool_number = list.get(i).get("pool_number");
			String last_name = list.get(i).get("last_name");
			String postcode = list.get(i).get("postcode");
			String email = list.get(i).get("email");
			String env = "demo";
			if (System.getProperty("env.database") != null)
				env = System.getProperty("env.database");

			NAV.accessLoginPage("public", env);

			GRP.click_radioButtonWithLabel("I am replying for someone else");
			NAV.press_buttonByName("Continue");
			NAV.textPresentOnPage("The juror number can be found on the jury s");
			NAV.set_valueTo("9-digit juror number", part_no);
			NAV.set_valueTo("Juror last name", last_name);
			NAV.set_valueTo("Juror postcode", postcode);
			NAV.press_buttonByName("Continue");

			NAV.textPresentOnPage("What is your name?");
			NAV.set_valueTo("First name", "FirstName");
			NAV.set_valueTo("Last name", "LastName");
			NAV.press_buttonByName("Continue");

			NAV.textPresentOnPage("Your relationship to the person");
			NAV.set_valueTo("How do you know the person you're replying for?", "Friend");
			NAV.press_buttonByName("Continue");

			NAV.textPresentOnPage("Your contact information");
			NAV.check_checkbox("By phone (UK Numbers only)");
			NAV.set_valueTo("Main phone", "02078211818");
			NAV.check_checkbox("By email");
			NAV.set_valueTo("Enter your email address", email);
			NAV.set_valueTo("Enter your email address again", email);
			NAV.press_buttonByName("Continue");

			NAV.textPresentOnPage("Why are you replying for the other person?");
			GRP.click_radioButtonWithLabel("The person is not here");
			NAV.press_buttonByName("Continue");

			NAV.textPresentOnPage("Is the name we have for them correct?");
			GRP.click_radioButtonWithLabel("Yes");
			NAV.press_buttonByName("Continue");
			NAV.textPresentOnPage("Is this their address?");
			GRP.click_radioButtonWithLabel("Yes");
			NAV.press_buttonByName("Continue");

			NAV.textPresentOnPage("Please give the date of birth for the person you're replying for");
			NAV.set_valueTo("Day", "27");
			NAV.set_valueTo("Month", "09");
			NAV.set_valueTo("Year", "1927");
			NAV.press_buttonByName("Continue");

			NAV.textPresentOnPage("Confirm the date of birth for the person you're answering for");
			NAV.press_buttonByName("Continue");

			NAV.textPresentOnPage("Check your answers now");
			NAV.check_checkbox("The answers I have given for the person I'm replying for are true as far as I know.");
			NAV.press_buttonByName("Submit");

			NAV.textPresentOnPage("You have completed your reply");

		}
	}

	@Given("^I have submitted a first party Welsh underage response$")
	public void submitFirstWelshUnderageResponse(DataTable arg1) throws Throwable {
		List<Map<String, String>> list = arg1.asMaps(String.class, String.class);
		for (int i = 0; i < list.size(); i++) {
			String part_no = list.get(i).get("part_no");
			String pool_number = list.get(i).get("pool_number");
			String last_name = list.get(i).get("last_name");
			String postcode = list.get(i).get("postcode");
			String email = list.get(i).get("email");
			String env = "demo";
			if (System.getProperty("env.database") != null)
				env = System.getProperty("env.database");

			NAV.accessLoginPageWelsh("public", env);

//		NAV.click_link_by_text("Welsh (Cymraeg)");
//		NAV.press_buttonByName("Dechrau nawr");
			GRP.click_radioButtonWithLabel("Rwy'n ymateb dros fy hun");
			NAV.press_buttonByName("Parhau");
//		NAV.textPresentOnPage("Gellir dod o hyd i'ch rhif rheithiwr ar eich llythyr gwŷs rheithgor");
			NAV.set_valueTo("Rhif rheithiwr – 9 digid", part_no);
			NAV.set_valueTo("Cyfenw'r Rheithiwr", last_name);
			NAV.set_valueTo("Cod post Rheithiwr", postcode);
			NAV.press_buttonByName("Parhau");
			NAV.textPresentOnPage("A yw'r enw sydd gennym ar eich cyfer chi yn gywir?");
			GRP.click_radioButtonWithLabel("Ydy");
			NAV.press_buttonByName("Parhau");
			NAV.textPresentOnPage("Eich cyfeiriad chi yw hwn?");
			GRP.click_radioButtonWithLabel("Ie");
			NAV.press_buttonByName("Parhau");

			NAV.set_valueTo("Prif rif ffôn", "02078211818");
			NAV.press_buttonByName("Parhau");

			NAV.set_valueTo("Nodwch eich cyfeiriad e-bost", email);
			NAV.set_valueTo("Nodwch eich cyfeiriad e-bost eto", email);
			NAV.press_buttonByName("Parhau");

			NAV.set_valueTo("Diwrnod", "27");
			NAV.set_valueTo("Mis", "09");
			NAV.set_valueTo("Blwyddyn", "2005");
			NAV.press_buttonByName("Parhau");

			NAV.textPresentOnPage("Cadarnhewch y dyddiad geni");
			NAV.press_buttonByName("Parhau");

			NAV.check_checkbox("Mae'r wybodaeth a roddais uchod yn wir hyd eithaf fy ngwybodaeth.");
			NAV.press_buttonByName("Cyflwyno");

			NAV.textPresentOnPage("Rydych wedi cwblhau'r broses ymateb");

		}
	}

	@Given("^I have submitted a third party Welsh overage response$")
	public void submitThirdWelshOverageResponse(DataTable arg1) throws Throwable {
		List<Map<String, String>> list = arg1.asMaps(String.class, String.class);
		for (int i = 0; i < list.size(); i++) {
			String part_no = list.get(i).get("part_no");
			String pool_number = list.get(i).get("pool_number");
			String last_name = list.get(i).get("last_name");
			String postcode = list.get(i).get("postcode");
			String email = list.get(i).get("email");
			String env = "demo";
			if (System.getProperty("env.database") != null)
				env = System.getProperty("env.database");

			NAV.accessLoginPage("public", env);

			NAV.click_link_by_text("Welsh (Cymraeg)");
			NAV.press_buttonByName("Dechrau nawr");
			GRP.click_radioButtonWithLabel("Rwy'n ymateb ar ran rhywun arall");
			NAV.press_buttonByName("Parhau");
			NAV.textPresentOnPage("Gellir dod o hyd i'r rhif rheithiwr ar y llythyr gwŷs rheithgor");
			NAV.set_valueTo("Rhif rheithiwr – 9 digid", part_no);
			NAV.set_valueTo("Cyfenw'r Rheithiwr", last_name);
			NAV.set_valueTo("Cod post Rheithiwr", postcode);
			NAV.press_buttonByName("Parhau");

			NAV.textPresentOnPage("Beth yw eich enw?");
			NAV.set_valueTo("Enw cyntaf", "FirstName");
			NAV.set_valueTo("Cyfenw", "LastName");
			NAV.press_buttonByName("Parhau");

			NAV.textPresentOnPage("Eich perthynas â'r unigolyn");
			NAV.set_valueTo("Sut ydych chi'n adnabod yr unigolyn rydych yn ymateb ar ei ran?", "Friend");
			NAV.press_buttonByName("Parhau");

			NAV.textPresentOnPage("Eich manylion cyswllt");
			NAV.check_checkbox("Dros y ffôn (rhifau yn y DU yn unig)");
			NAV.set_valueTo("Prif rif ffôn", "02078211818");
			NAV.check_checkbox("Trwy e-bost");
			NAV.set_valueTo("Nodwch gyfeiriad e-bost", email);
			NAV.set_valueTo("Nodwch gyfeiriad e-bost eto", email);
			NAV.press_buttonByName("Parhau");

			NAV.textPresentOnPage("Pam ydych chi'n ymateb ar ran yr unigolyn arall?");
			GRP.click_radioButtonWithLabel("Nid yw'r unigolyn yma");
			NAV.press_buttonByName("Parhau");

			NAV.textPresentOnPage("A yw'r enw sydd gennym ar ei gyfer yn gywir?");
			GRP.click_radioButtonWithLabel("Ydy");
			NAV.press_buttonByName("Parhau");
			NAV.textPresentOnPage("Ei gyfeiriad ef yw hwn?");
			GRP.click_radioButtonWithLabel("Ie");
			NAV.press_buttonByName("Parhau");

			NAV.textPresentOnPage("Nodwch ddyddiad geni'r unigolyn rydych chi'n ymateb ar ei ran");
			NAV.set_valueTo("Diwrnod", "27");
			NAV.set_valueTo("Mis", "09");
			NAV.set_valueTo("Blwyddyn", "1927");
			NAV.press_buttonByName("Parhau");

			NAV.textPresentOnPage("Cadarnhewch ddyddiad geni'r unigolyn rydych chi'n ymateb ar ei ran");
			NAV.press_buttonByName("Parhau");

			NAV.check_checkbox("Hyd gwn i, mae'r wybodaeth rwyf wedi ei rhoi am yr unigolyn rwyf yn ymateb ar ei ran yn gywir.");
			NAV.press_buttonByName("Cyflwyno");

			NAV.textPresentOnPage("Rydych wedi cwblhau'r broses ymateb");

		}
	}

	@When("^I check the processed success banner is not visible$")
	public void processedSuccessBannerInvisible() {
		assertTrue("Processed Success Banner is visible", SUMMONS_REPLY.processedSuccessBannerInvisible());
	}

	@When("^the Enter summons reply button is not visible$")
	public void enterSummonsReplyButtonInvisible() {
		assertTrue("enter summons reply button is  not visible", SUMMONS_REPLY.enterSummonsReplyButtonInvisible());
	}

	@When("^the process reply button is not visible$")
	public void processReplyButtonInvisible() {
		assertTrue("process reply button is  not visible", SUMMONS_REPLY.processReplyButtonInvisible());
	}
}
