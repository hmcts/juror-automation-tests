package cucumber.testdata;

import cucumber.utils.ReadProperties;
import org.apache.log4j.Logger;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Properties;

public class DBConnection {

	private static Logger log = Logger.getLogger(DBConnection.class);

	public Connection getConnection() throws SQLException {

		return getConnection("Default");
	}
	
	public Connection getConnection(String environment) throws SQLException {
		Connection conn = null;
		Properties props = new Properties();
		String oracle_jdbc;
		environment = ReadProperties.systemPropertyEnvironmentOverrideCheck(environment);
		log.info("Attempting to make connection to =>"+environment);
		
		
		if (environment.equalsIgnoreCase("Default")) {
			props.put("user", ReadProperties.main("oracle_username"));
			props.put("password", ReadProperties.main("oracle_password"));
			oracle_jdbc = ReadProperties.main("oracle_jdbc");
			
		} else {
			props.put("user",  ReadProperties.main("database_" + environment + "_username"));
			props.put("password",  ReadProperties.main("database_" + environment + "_password"));
			oracle_jdbc = ReadProperties.main("database_"+environment);
		}
		

		try {
			conn = DriverManager.getConnection(
						oracle_jdbc,
						props
					);
			log.info("Successfully made database connection to =>"+environment);
		} catch (SQLException e) {
			e.printStackTrace();
			log.info("Unable to make connection to database");
		}
		conn.setAutoCommit(false);
		return conn;
	}


	// TODO - This method and everything that calls it is unused in the Juror project, it doesn't break anything but will need stripping out at some point.

	public Connection getPostGresConnection(String database) {
		Connection conn = null;
		Properties props = new Properties();
		log.info("Making postgres connection");
		
		props.put("user", ReadProperties.main("postgres_username"));
		props.put("password", ReadProperties.main("postgres_password"));
		try {
			conn = DriverManager.getConnection(
						ReadProperties.main("postgres_jdbc")+database,
						props
					);
			log.info("Successfully made to postgres database");
		} catch (SQLException e) {
			e.printStackTrace();
		}			
		return conn;
	}
}
