package cucumber.steps;


import cucumber.pageObjects.Login;
import cucumber.pageObjects.MessageLoader;
import cucumber.pageObjects.NavigationShared;
import cucumber.pageObjects.SharedDriver;
import cucumber.pageObjects.aSamplePO;

import io.cucumber.java.en.*;
import io.cucumber.java.PendingException;
import io.cucumber.datatable.DataTable;
import io.cucumber.java.Before;
import io.cucumber.java.After;
import io.cucumber.java.Scenario;

import java.io.IOException;
import java.sql.SQLException;

import org.openqa.selenium.support.PageFactory;

public class StepDef_MessageLoader {
	
	private MessageLoader ML;

	
	public StepDef_MessageLoader() {
		ML = new MessageLoader();
	}
	
	@Given("^that my workspace has been cleared for the Message Loader$")
	public void clear_workspace() throws Throwable {
		ML.clearWorkspace();
	}
	
	@Given("^that the \"([^\"]*)\" directory is empty$")
	public void clear_directory(String arg1) throws IOException{
	    ML.emptyDirectory(arg1);
	};
	
	@Given("^that I have created a blank file with name \"([^\"]*)\" in the \"([^\"]*)\" directory$")
	public void create_blankFile_withName(String name, String directory) throws IOException{
	    ML.create_blankFile_withName(name, directory);
	};
	
	@Given("^\"([^\"]*)\" does not exist in Alfresco$")
	public void delete_fromAlfresco(String fileName){
	    ML.delete_fromAlfresco(fileName);
	};
	
	@Given("^that I have run the message loader$")
	public void run_messageLoader() throws IOException, InterruptedException {
	    ML.run_messageLoader();
	};
	
	/**
	 * Improve this to poll instead of generic 2 sec wait. Poll up to 15 seconds (GW timeout is 30 seconds)
	 * @param arg1
	 * @throws SQLException
	 * @throws InterruptedException
	 */
	@Then("^I see the relates_col populated with \"([^\"]*)\" in the Gateway and the same UUID is present in the mirror gateway$")
	public void confirmGateway_withMGW_viaRelates(String arg1) throws SQLException, InterruptedException {
	    try{
	    	ML.confirm_documentWithName_presentInMGW(arg1);
	    } catch (Exception e) {
	    	Thread.sleep(2000);
	    	ML.confirm_documentWithName_presentInMGW(arg1);
	    } catch (AssertionError ae) {
	    	Thread.sleep(2000);
	    	ML.confirm_documentWithName_presentInMGW(arg1);
	    }
	};
	
	@Given("^the gateway does not have any rows with a relates_to value of \"([^\"]*)\"$")
	public void delete_fromGatewayWhere_TextFileName(String arg1) throws SQLException {
	    ML.delete_fromGW_relatesEqual(arg1);
	    ML.delete_fromSUBS_relatesEqual(arg1);
	};
	
	@Then("^I see (\\d+) files in \"([^\"]*)\"$")
	public void confirm_fileCount_inDirectory(Integer fileCount, String directory) {
	    ML.confirm_fileCount_inDirectory(fileCount, directory);
	};
	
	@Then("^I see relates_col populated with \"([^\"]*)\" in the subscription scheduler audit table$")
	public void confirmSUBS_hasRelatesValuePresent(String arg1) throws SQLException{
	    ML.check_UUIDExists_inSUBS(arg1);
	};
	
}