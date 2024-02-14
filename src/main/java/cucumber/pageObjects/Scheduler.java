package cucumber.pageObjects;

import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.nio.charset.Charset;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.Arrays;
import java.util.List;

import org.apache.commons.io.FileUtils;
import org.apache.log4j.Logger;

import com.google.common.base.Charsets;
import com.google.common.io.Files;

import cucumber.testdata.DBConnection;
import cucumber.utils.ReadProperties;

public class Scheduler {

	private static Logger log = Logger.getLogger(Scheduler.class);

	private DBConnection db;
	private Connection conn;
	private PreparedStatement cStmt = null;

	
	public void insertIntoSchedule_notifyRequest(String content) throws SQLException {
		db = new DBConnection();
		conn = db.getPostGresConnection("cp_subscriptionscheduler_db");

	     try {
	    	 cStmt = conn.prepareStatement("insert into schedule_notify_request (notify_time, notify_request_message) values "
	    	 		+ "("
	    	 			+ "'2018-06-23 10:22:22.560000',"
	    	 			+ "?"
	    	 		+ ")");
	    	 
	    	 cStmt.setString(1, content);

	    	 cStmt.executeUpdate();
	    	 
	     } catch (SQLException e)  {
	         e.printStackTrace();
	         log.error("Message: " + e.getMessage());       
	     }
	     finally {
    	    cStmt.close();
			conn.close();			
		}
	}


	public void loadFile_intoScheduleNotifyRequestTable(String file_name) throws IOException, Exception {
		String content = Files.toString(new File("src/test/resources/schedule_notify_request_DATA/"+file_name+"_request.xml"), Charsets.UTF_8);
		insertIntoSchedule_notifyRequest(content);
		log.info("Successfully Sent the following to the database => \n"+content);
	}

}
