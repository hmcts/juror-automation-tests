package cucumber.pageObjects;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.SQLException;

import org.apache.log4j.Logger;

import cucumber.testdata.DBConnection;

public class aSamplePOWithDB {

	private static Logger log = Logger.getLogger(aSamplePOWithDB.class);

	private DBConnection db;
	private Connection conn;
	private CallableStatement cStmt = null;

	
	public void runSQL() throws SQLException {
		db = new DBConnection();
		conn = db.getConnection();

	     try {
	    	 cStmt = conn.prepareCall("call footgunnoref()"); // SQL Statement here
	    	 cStmt.execute();
	    	 log.info("Transactional Data is cleared on Weblogic Test");
	     } catch (SQLException e)  {
	         e.printStackTrace();
	         log.error("Message: " + e.getMessage());       
	     }
	     finally {
    	    cStmt.close();
			conn.close();			
		}
	}

}
