package cucumber.pageObjects;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.nio.charset.Charset;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Arrays;
import java.util.List;

import org.apache.chemistry.opencmis.client.api.CmisObject;
import org.apache.chemistry.opencmis.client.api.Session;
import org.apache.chemistry.opencmis.client.api.SessionFactory;
import org.apache.chemistry.opencmis.client.runtime.SessionFactoryImpl;
import org.apache.chemistry.opencmis.commons.exceptions.CmisObjectNotFoundException;
import org.apache.commons.io.FileUtils;
import org.apache.log4j.Logger;
import org.junit.Assert;

import com.google.common.io.Files;

import cucumber.testdata.DBConnection;
import cucumber.utils.AlfrescoUtils;
import cucumber.utils.ReadProperties;

public class MessageLoader {

	private static Logger log = Logger.getLogger(MessageLoader.class);

	private DBConnection db;
	private Connection conn;
	private PreparedStatement pStmt = null;

	public boolean check_UUIDExists_inMGW(String GW_UUID) throws SQLException {
		
		db = new DBConnection();
		conn = db.getPostGresConnection("cp_mirror_gateway_db");
		
		try {
	    	
	    	 pStmt = conn.prepareStatement("select message_uuid as mu from cp_mirror_gateway_db.public.message_audit where message_uuid=?"); // SQL Statement here
	    	 pStmt.setString(1, GW_UUID);    	 
	    	 
	    	 ResultSet rs = pStmt.executeQuery();
	    	 
	    	 while (rs.next()) {
	    		 log.info("Saw UUID of =>" + rs.getString("mu") + "<= as expected");
	    		 return true;
	    	 }
	     } catch (SQLException e)  {
	         e.printStackTrace();
	         log.error("Message:" + e.getMessage());       
	     }
	     finally {
   	    	pStmt.close();
			conn.close();			
		}
		log.info("Did not see UUID =>"+GW_UUID+"<= as expected");
		return false;
	}
	
	public void check_UUIDExists_inSUBS(String GW_UUID) throws SQLException {
		
		db = new DBConnection();
		conn = db.getPostGresConnection("cp_subscriptionscheduler_db");
		
		try {
	    	
	    	 pStmt = conn.prepareStatement("select relates_to as mu from cp_subscriptionscheduler_db.public.message_audit where relates_to=?"); // SQL Statement here
	    	 pStmt.setString(1, GW_UUID);    	 
	    	 
	    	 ResultSet rs = pStmt.executeQuery();
	    	 
	    	 while (rs.next()) {
	    		 log.info("Saw relates_to of =>" + rs.getString("mu") + "<= as expected");
	    		 return;
	    	 }
	     } catch (SQLException e)  {
	         e.printStackTrace();
	         log.error("Message:" + e.getMessage());       
	     }
	     finally {
   	    	pStmt.close();
			conn.close();			
		}
		log.info("Did not see UUID =>"+GW_UUID+"<= as expected");
		throw new Error("Did not see file name in table");
	}
	public String grabUUID_fromGW_againstRelatesToCol(String relatesVal) throws SQLException {
		db = new DBConnection();
		conn = db.getConnection();

	     try {
	    	
	    	 pStmt = conn.prepareStatement("select MESSAGE_UUID from CP_SOAP_GATEWAY_OWNER.MESSAGE_AUDIT where relates_to=? order by MESSAGE_AUDIT_ID desc "); // SQL Statement here
	    	 pStmt.setString(1, relatesVal);    	 
	    	 
	    	 ResultSet rs = pStmt.executeQuery();
	    	 
	    	 while (rs.next()) {
	    		 log.info("Saw =>" + rs.getString("MESSAGE_UUID") + "<= for file with name =>" + relatesVal);
	    		 return rs.getString("MESSAGE_UUID");
	    	 }
	     } catch (SQLException e)  {
	         e.printStackTrace();
	         log.error("Message: " + e.getMessage());       
	     }
	     finally {
    	    pStmt.close();
			conn.close();			
		}
	     
	    return null;
	}


	public void clearWorkspace() throws IOException {
		String workspace_location = ReadProperties.main("MessageLoader_workspace");
		log.info("Going to clear workspace located here =>"+workspace_location);
		String git_command = "git --git-dir="+workspace_location+" --work-tree="+workspace_location+" clean -f";
		
		Process rt = Runtime.getRuntime().exec(git_command);
		
		log.info("Directory Cleaned");
	}


	public void emptyDirectory(String arg1) throws IOException {
		String workspace_location = 
				ReadProperties.main("MessageLoader_workspace") +
				arg1;
		File workspace_dir = new File(workspace_location); 
		log.info("Going to clear the directory =>"+workspace_location);
		try {
			log.info("Saw =>"+new File(workspace_location).list().length+"<= files in the directory");
		} catch (Exception e) {
			log.info("Empty Directory - Continuing");
			return;
		}
		FileUtils.cleanDirectory(workspace_dir);
		
		log.info("Cleared directory =>"+workspace_location);
		
		try {
			log.info("Saw =>"+new File(workspace_location).list().length+"<= files in the directory");
		} catch (Exception e) {
			log.info("Empty Directory - Continuing");
			return;
		}
		
	}


	public void create_blankFile_withName(String name, String directory) throws IOException {
		log.info("Going to create an empty file with name =>"+name);
		
		File file = new File(ReadProperties.main("MessageLoader_workspace") + directory + name);
		log.info("File Location =>"+ ReadProperties.main("MessageLoader_workspace") + directory + name);
		file.createNewFile();
		
		FileWriter writer = new FileWriter(file);
		writer.write("Test data");
		writer.close();
		
	}


	public void delete_fromAlfresco(String fileName) {
		String path = "/CrimePortal/" + fileName;
		log.info("Going to delete file in location =>" + path);
		
		Session session = AlfrescoUtils.returnSession();
		CmisObject cmisObject = null;
		try {
			cmisObject = session.getObjectByPath(path);
		} catch (CmisObjectNotFoundException e) {
			log.info("Did not find object by path given =>" + path);
			log.info("Continuing without error");
			return;			
		}
		String id = cmisObject.getId();
		cmisObject.delete();
		log.info("Deleted Object");
	}


	public void run_messageLoader() throws IOException, InterruptedException {
		String workspace_location = ReadProperties.main("MessageLoader_workspace");
		log.info("Going to execute the messageLoader");
		ProcessBuilder pb;
		Process pr;
		try{
			pb = new ProcessBuilder(
					"java.exe",
					"-DconfigFilePath=config\\cp-ml-config.properties",
					"-Dlog4j.configuration=file:config\\cp-ml-log4j.xml",
					"-jar", "cp-messageloader.jar "
				);
			pb.directory(new File(workspace_location));
			pb.redirectErrorStream(true);
			pr = pb.start(); 
			
		} catch (Exception e) {
			pb = new ProcessBuilder(
					"/usr/java/latest/bin/java",
					"-DconfigFilePath=config/cp-ml-config.properties",
					"-Dlog4j.configuration=file:config/cp-ml-log4j.xml",
					"-jar", "/home/jenkins/artifacts/cp-messageloader.jar"
				);
			
			
			log.info("Preparing to run in workspace =>"+workspace_location);
			pb.directory(new File(workspace_location));
			pb.redirectErrorStream(true);
			pr = pb.start(); 
		}
		 

		BufferedReader in = new BufferedReader(new InputStreamReader(pr.getInputStream()));
		String line;
		while ((line = in.readLine()) != null) {
		    log.info(line);
		}
		pr.waitFor();

		in.close();
		
		log.info("Message Loader ran");
	}


	public void confirm_documentWithName_presentInMGW(String arg1) throws SQLException {
		log.info("Going to check what the UUID is in the GW");		
		
		String GW_UUID = grabUUID_fromGW_againstRelatesToCol(arg1);		
		log.info("Going to check PostGres to confirm that UUID =>"+GW_UUID+"<= was sent to MGW");
		
		//ConfirmPresent
		Assert.assertTrue("Did not see UUID =>"+GW_UUID+"<= as expected in the MGW for relates_to with value =>"+arg1,
					check_UUIDExists_inMGW(GW_UUID)
				);		
		log.info("UUID =>"+GW_UUID+"<= is present and behaving as expected");
	}
	public void delete_fromGW_relatesEqual(String arg1) throws SQLException {
		db = new DBConnection();
		conn = db.getConnection();
		
		try {
	    	
	    	 pStmt = conn.prepareStatement("delete from cp_soap_gateway_owner.message_audit where relates_to=?"); // SQL Statement here
	    	 pStmt.setString(1, arg1);    	 
	    	 
	    	 ResultSet rs = pStmt.executeQuery();
	    	 log.info("Cleaned up GW by deleting logs where file has name =>"+arg1);
	    	
	     } catch (SQLException e)  {
	         e.printStackTrace();
	         log.error("Message:" + e.getMessage());       
	     }
	     finally {
   	    	pStmt.close();
			conn.close();			
		}		
	}
	
	public void delete_fromSUBS_relatesEqual(String arg1) throws SQLException {
		db = new DBConnection();
		conn = db.getPostGresConnection("cp_subscriptionscheduler_db");
		log.info("Going to delete the subscription audit rows with =>"+arg1);
		
		try {
	
	    	 pStmt = conn.prepareStatement("delete from message_audit where relates_to=?"); // SQL Statement here
	    	 pStmt.setString(1, arg1);    	 
	    	 
	    	 pStmt.executeUpdate();
	    	 log.info("Cleaned up SUBS by deleting logs where file has name =>"+arg1);
	    	
	     } catch (SQLException e)  {
	         e.printStackTrace();
	         log.error("Message:" + e.getMessage());       
	     }
	     finally {
   	    	pStmt.close();
			conn.close();			
		}		
	}
	
	public Integer return_fileCount_inDirectory(String directory) {
		log.info("Going to check files in directory =>"+directory);
		Integer fileCount;
		try {
			fileCount = new File(directory).list().length;
			log.info("Saw =>"+fileCount+"<= files in the directory");
		} catch (Exception e) {
			log.info("Got an error checking how many files are in the directory - Returning 0 as assuming empty/does not exist");
			fileCount = 0;
		}
		return fileCount;
	}
	
	public void confirm_fileCount_inDirectory(Integer fileCount, String directory) {
		
		String workspace_location = 
				ReadProperties.main("MessageLoader_workspace") +
				directory;
		
		Assert.assertEquals(fileCount,
					return_fileCount_inDirectory(workspace_location)
				);
	}


	
}
