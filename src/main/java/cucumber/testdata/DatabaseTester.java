package cucumber.testdata;


import cucumber.utils.DateManipulator;
import cucumber.utils.ReadProperties;
import org.apache.log4j.Logger;
import org.junit.Assert;

import java.sql.*;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.DayOfWeek;
import java.time.LocalDate;
import java.time.ZoneId;
import java.time.format.DateTimeFormatter;
import java.time.temporal.TemporalAdjusters;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

public class DatabaseTester {

	private static Logger log = Logger.getLogger(DatabaseTester.class);

	private DBConnection db;
	private Connection conn;
	private PreparedStatement pStmt = null;
	private String holidayDate;
	private String holidayOwner;
	private Date calendar;
	private int newCoronerPoolNumber;

	public static String oracleWeeksInFuture(int noWeeks) {
		String datePattern = "dd-MMM-yyyy";
		Calendar date = Calendar.getInstance();
		date.add(Calendar.WEEK_OF_MONTH, noWeeks);

		return new SimpleDateFormat(datePattern).format(date.getTime());
	}

	public static String oracleMondayWeeksInFuture(int noWeeks) {
		String datePattern = "dd-MMM-yyyy";
		LocalDate nextMonday = LocalDate.now().with(TemporalAdjusters.next(DayOfWeek.MONDAY));
		nextMonday = nextMonday.plusWeeks(noWeeks);
		DateTimeFormatter dateToFormat = DateTimeFormatter.ofPattern(datePattern);

		return nextMonday.format(dateToFormat);
	}

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
		} catch (SQLException e) {
			e.printStackTrace();
			log.error("Message:" + e.getMessage());
		} finally {
			pStmt.close();
			conn.close();
		}
		return false;
	}

	public void column_existsIn(String frontBackEnd, String database, String table, String colName) throws SQLException {
		// SQL injectable due to parameters
		if (frontBackEnd.equalsIgnoreCase("front")) {
			db = new DBConnection();
			conn = db.getPostGresConnection(database);
			pStmt = conn.prepareStatement("select column_name from information_schema.columns where table_name=? and column_name=?");
			pStmt.setString(1, table);
			pStmt.setString(2, colName);
		} else if (frontBackEnd.equalsIgnoreCase("back")) {
			throw new Error("Implementation for the backend has not been implemented");
		} else {
			throw new Error("Don't know which front/backend database we are looking for");
		}

		ResultSet rs = pStmt.executeQuery();
		int rows = 0;
		while (rs.next()) {
			rows++;
		}

		Assert.assertEquals("Saw =>" + rows + "<= when expected 1", 1, rows);
		log.info("Saw that column =>" + colName + "<= existed in table =>" + table + "<= for database =>" + database);
	}

	public void rowsExistIn_Where(int rowCountExpected,
								  String environment, String database, String table,
								  String colA, String colAParameter,
								  String colB, String colBParameter,
								  String colC, String colCParameter) throws SQLException {
		try {
			db = new DBConnection();

			String env_property = System.getProperty("env.database");
			if (env_property != null)
				conn = db.getConnection(env_property);
			else
				conn = db.getConnection(environment);

			if (colAParameter == "NULL") {
				pStmt = conn.prepareStatement(
						"select 1 from " + database + "." + table + " "
								+ "where "
								+ colA + " is NULL and "
								+ colB + "=? and "
								+ colC + "=?");
				log.info("select 1 from " + database + "." + table + " "
						+ "where "
						+ colA + " is NULL and "
						+ colB + "=? and "
						+ colC + "=?");
				pStmt.setString(1, colBParameter);
				pStmt.setString(2, colCParameter);
			} else {
				pStmt = conn.prepareStatement(
						"select 1 from " + database + "." + table + " "
								+ "where "
								+ colA + "=? and "
								+ colB + "=? and "
								+ colC + "=?");

				pStmt.setString(1, colAParameter);
				pStmt.setString(2, colBParameter);
				pStmt.setString(3, colCParameter);
			}

			ResultSet rs = pStmt.executeQuery();
			int rowCountActual = 0;
			while (rs.next()) {
				rowCountActual++;
			}
			Assert.assertEquals("Saw =>" + rowCountActual + "<= when expected =>" + rowCountExpected, rowCountExpected, rowCountActual);
			log.info("Saw =>" + rowCountActual + "<= row(s) as expected when checking table =>" + table + "<= with values =>" + colAParameter + "<=, =>" + colBParameter + "<=, =>" + colCParameter);
		} catch (SQLException e) {
			e.printStackTrace();
			log.error("Message: " + e.getMessage());
		} finally {
			pStmt.close();
			conn.close();
		}
	}

	public void rowsExistIn_Where(Integer arg1, String arg2, String arg3, String arg4, String arg5, String arg6,
								  String arg7, String arg8, String arg9, Integer arg10) {
		// TODO Auto-generated method stub

	}

	/**
	 * select * from SYS.all_tables where owner='CP_SOAP_GATEWAY_OWNER'
	 *
	 * @param tableName
	 * @param schemaName
	 * @param frontBackEnd
	 * @throws SQLException
	 */
	public void tableExistsIn(String tableName, String schemaName, String frontBackEnd) throws SQLException {
		db = new DBConnection();
		if (frontBackEnd.equalsIgnoreCase("back")) {
			conn = db.getConnection();
		}
		try {
			pStmt = conn.prepareStatement(
					"select 1 from SYS.all_Tables "
							+ "where "
							+ "table_name = ? and "
							+ "owner = ?"
			);

			pStmt.setString(1, tableName.toUpperCase());
			pStmt.setString(2, schemaName.toUpperCase());
			ResultSet rs = pStmt.executeQuery();
			int rowCountActual = 0;
			while (rs.next()) {
				rowCountActual++;
			}
			Assert.assertEquals("Saw =>" + rowCountActual + "<= when expected =>1", 1, rowCountActual);
			log.info(String.format("Saw that %s exists in schema %s", tableName, schemaName));
		} catch (SQLException e) {
			e.printStackTrace();
			log.error("Message:" + e.getMessage());
		} finally {
			pStmt.close();
			conn.close();
		}
	}

	/**
	 * Assuming oracle
	 * select * from SYS.ALL_TAB_COLS where owner='CP_SOAP_GATEWAY_OWNER' and table_name='MESSAGE_AUDIT' and VERSION_NUMBER='20'
	 *
	 * @param schemaName
	 * @param tableName
	 * @param columnName
	 * @param columnLookup
	 * @param columnLookupValue
	 * @throws SQLException
	 */
	public void schemaTable_hasColumnWithThat(String schemaName, String tableName, String columnName,
											  String columnLookup, String columnLookupValue) throws SQLException {
		db = new DBConnection();
		conn = db.getConnection();

		log.info("Going to lookup column =>" + columnLookup);
		try {
			/*
			pStmt = conn.prepareStatement(
					"select 1 from SYS.ALL_TAB_COLS "
							+ "where "
								+ "table_name 	= ? and "
								+ "owner 		= ? and "
								+ "column_name 	= ? and "
								+ columnLookup.replaceAll("/[^\\w-]/", "") +" = ?"
					);
			*/

			pStmt = conn.prepareStatement(
					"SELECT * FROM ( "
							+ "SELECT to_char( " + columnLookup
							+ ") as lookup "
							+ "FROM SYS.ALL_TAB_COLS "
							+ "WHERE "
							+ "owner 		= ? AND "
							+ "table_name 	= ? AND "
							+ "column_name 	= ?"
							+ ") "
							+ "WHERE lookup = ?"
			);
			log.info("SELECT * FROM ( "
					+ "SELECT to_char( " + columnLookup
					+ ") as lookup "
					+ "FROM SYS.ALL_TAB_COLS "
					+ "WHERE "
					+ "owner 		= ? AND "
					+ "table_name 	= ? AND "
					+ "column_name 	= ?"
					+ ") "
					+ "WHERE lookup = ?");

			pStmt.setString(1, schemaName.toUpperCase());
			pStmt.setString(2, tableName.toUpperCase());
			pStmt.setString(3, columnName.toUpperCase());
			//if (columnLookupValue.chars().allMatch(Character::isDigit)) {
			//	pStmt.setInt(4, Integer.parseInt(columnLookupValue));
			//} else {
			pStmt.setString(4, columnLookupValue.toUpperCase());
			//	}
			ResultSet rs = pStmt.executeQuery();
			int rowCountActual = 0;
			while (rs.next()) {
				rowCountActual++;
			}
			Assert.assertEquals("Saw =>" + rowCountActual + "<= when expected =>1", 1, rowCountActual);
			log.info(String.format("Saw %s.%s has column %s which has attribute %s with value %s",
					schemaName, tableName, columnName, columnLookup, columnLookupValue));
		} catch (SQLException e) {
			e.printStackTrace();
			log.error("Message=>" + e.getMessage());
			throw new AssertionError("Did not get expected value");
		} finally {
			pStmt.close();
			conn.close();
		}
	}

	/**
	 * Assuming oracle
	 * SELECT cols.column_name FROM all_constraints cons NATURAL JOIN all_cons_columns cols WHERE cons.constraint_type = 'P' AND table_name = UPPER('MESSAGE_AUDIT');
	 *
	 * @param schemaName
	 * @param tableName
	 * @param constraintType
	 * @param columnName
	 * @throws SQLException
	 */
	public void schemaTable_hasConstraint(String schemaName, String tableName, String constraintType,
										  String columnName) throws SQLException {

		db = new DBConnection();
		conn = db.getConnection();
		try {
			pStmt = conn.prepareStatement(
					"select 1 from all_constraints cons "
							+ "NATURAL JOIN "
							+ "all_cons_columns cols "
							+ "WHERE "
							+ "CONS.CONSTRAINT_TYPE = ? AND "
							+ "OWNER = ? AND "
							+ "TABLE_NAME = ? AND "
							+ "COLUMN_NAME = ?"
			);

			pStmt.setString(1, constraintType.toUpperCase());
			pStmt.setString(2, schemaName.toUpperCase());
			pStmt.setString(3, tableName.toUpperCase());
			pStmt.setString(4, columnName.toUpperCase());
			ResultSet rs = pStmt.executeQuery();
			int rowCountActual = 0;
			while (rs.next()) {
				rowCountActual++;
			}
			Assert.assertEquals("Saw =>" + rowCountActual + "<= when expected =>1", 1, rowCountActual);
			log.info(String.format("Saw that %s exists in schema %s", tableName, schemaName));
		} catch (SQLException e) {
			e.printStackTrace();
			log.error("Message:" + e.getMessage());
		} finally {
			pStmt.close();
			conn.close();
		}
	}

	public void updateJurorPool_toSetColumn_asValue(String part_no, String columnName, String columnValue) throws SQLException {
		if (columnValue.contains(" time")) {
			columnValue = DateManipulator.processString(columnValue);
		}

		db = new DBConnection();
		String env_property = System.getProperty("env.database");
		if (env_property != null)
			conn = db.getConnection(env_property);
		else
			conn = db.getConnection("demo");

		log.info("Going to update the database by setting =>" + columnName + "<= to =>" + columnValue + "<= for =>" + part_no);
		try {
			pStmt = conn.prepareStatement("update JUROR.POOL set " + columnName + "='" + columnValue + "' where part_no='" + part_no + "'");
			if (columnValue.contains("-") && columnValue.contains(":")) {
				pStmt = conn.prepareStatement("update JUROR.POOL set " + columnName + "=TO_DATE(?, 'YYYY-MM-DD HH24:MI:SS') where part_no='" + part_no + "'");
				pStmt.setString(1, columnValue);
			}

			pStmt.execute();
			conn.commit();
			log.info("Update Successful ");

		} catch (SQLException e) {
			e.printStackTrace();
			log.error("Message:" + e.getMessage());
		} finally {
			pStmt.close();
			conn.close();
		}
	}

	public void updateJurorUniquePool_toSetAttendanceDate(String pool_no, String columnValue) throws SQLException {
		if (columnValue.contains(" time")) {
			columnValue = DateManipulator.processString(columnValue);
		}

		db = new DBConnection();
		String env_property = System.getProperty("env.database");
		if (env_property != null)
			conn = db.getConnection(env_property);
		else
			conn = db.getConnection("demo");

		log.info("Going to update the database by setting attendance date on unique pool to =>" + columnValue + "<= for =>" + pool_no);
		try {
			pStmt = conn.prepareStatement("update JUROR.UNIQUE_POOL set RETURN_DATE =? , NEXT_DATE =? where part_no=?");
			if (columnValue.contains("-") && columnValue.contains(":")) {
				pStmt = conn.prepareStatement("update JUROR.UNIQUE_POOL set RETURN_DATE =TO_DATE(?, 'YYYY-MM-DD HH24:MI:SS'), NEXT_DATE =TO_DATE(?, 'YYYY-MM-DD HH24:MI:SS') where pool_no=?");
			}
			pStmt.setString(1, columnValue);
			pStmt.setString(2, columnValue);
			pStmt.setString(3, pool_no);

			pStmt.executeUpdate();
			conn.commit();
			log.info("Update Successful ");

		} catch (SQLException e) {
			e.printStackTrace();
			log.error("Message:" + e.getMessage());
		} finally {
			pStmt.close();
			conn.close();
		}
	}

	//Danielle update Juror data for dashboard
	public void updateJuror_table_toSetColumn_asValue(String part_no, String table, String columnName, String columnValue, String columnNameA, String columnValueA) throws SQLException {
		if (columnValue.contains(" time")) {
			columnValue = DateManipulator.processString(columnValue);
		}

		db = new DBConnection();
		String env_property = System.getProperty("env.database");
		if (env_property != null)
			conn = db.getConnection(env_property);
		else
			conn = db.getConnection("demo");

//		log.info("Going to update the database by setting =>"+table+"<= . =>"+columnName+"<= to =>"+columnValue+"<= where =>"+columnName1+"<= is =>"+columnValue1+"<= for =>"+part_no);
		try {
			pStmt = conn.prepareStatement("update JUROR." + table + " set " + columnName + "='" + columnValue + "' where part_no='" + part_no + "' and " + columnNameA + "=?");
			pStmt.setString(1, columnValueA);

			if (table.contains("UNIQUE_POOL")) {
				pStmt = conn.prepareStatement("update JUROR." + table + " set " + columnName + "=TO_DATE(?, 'YYYY-MM-DD HH24:MI:SS') where pool_no ='" + columnValueA + "'");
				pStmt.setString(1, columnValue);

			} else if (columnValue.contains("-") && columnValue.contains(":")) {
				pStmt = conn.prepareStatement("update JUROR." + table + " set " + columnName + "=TO_DATE(?, 'YYYY-MM-DD HH24:MI:SS') where part_no='" + part_no + "' and " + columnNameA + "=?");
				pStmt.setString(1, columnValue);
				pStmt.setString(2, columnValueA);
			}

			pStmt.executeQuery();
			log.info("Update Successful ");
//
//	     } catch (SQLException e)  {
//	         e.printStackTrace();
//	         log.error("Message:" + e.getMessage());
		} finally {
			conn.commit();
			pStmt.close();
			conn.close();
		}
	}

	//Danielle update Juror Digital data for dashboard
	public void updateJurorDigital(String column, String part_no, String value) throws SQLException {
		if (value.contains(" time")) {
			value = DateManipulator.processString(value);
		}

		db = new DBConnection();
		String env_property = System.getProperty("env.database");

		if (env_property != null)
			conn = db.getConnection(env_property);
		else
			conn = db.getConnection("demo");

		try {
			pStmt = conn.prepareStatement("update juror_digital.juror_response set " + column + " = '" + value + "' where juror_number='" + part_no + "'");
			pStmt.execute();
//			if (value.contains("-") && value.contains(":")) {
//				pStmt = conn.prepareStatement("update juror_digital.juror_response set " + column + "=NOW() where juror_number='" + part_no + "'");
//				pStmt.execute();
//			} else if (column.contains("COMPLETED_AT")) {
//				pStmt = conn.prepareStatement("update juror_digital.juror_response set " + column + "=NOW() where juror_number='" + part_no + "'");
//				pStmt.execute();
//			}

			log.info("Updated juror digital " + column + "");

		} finally {
			conn.commit();
			pStmt.close();
			conn.close();
		}

	}



	public void onDatabaseTable_seeColWithColValue_whereColColvalue(String environment, String database, String databaseTable,
																	String expectedColumn, String expectedColumnValue, String whereColumn, String whereColumnValue) throws SQLException {

		rowsExistIn_Where(
				1,
				environment,
				database,
				databaseTable,
				expectedColumn,
				expectedColumnValue,
				whereColumn,
				whereColumnValue,
				whereColumn,
				whereColumnValue
		);
	}

	public void onDatabaseTable_seeColWithColValue_whereColColvalue(String environment, String database,
																	String databaseTable, String expectedColumn, String expectedColumnValue, String whereColumn,
																	String whereColumnValue, String whereColumnB, String whereColumnValueB) throws SQLException {

		rowsExistIn_Where(
				1,
				environment,
				database,
				databaseTable,
				expectedColumn,
				expectedColumnValue,
				whereColumn,
				whereColumnValue,
				whereColumnB,
				whereColumnValueB
		);
	}

	public void requestInfoLetterGenerated(String jurorPartNo) throws SQLException {

		db = new DBConnection();
		String env_property = System.getProperty("env.database");
		if (env_property != null)
			conn = db.getConnection(env_property);
		else
			conn = db.getConnection("demo");

		try {
			pStmt = conn.prepareStatement("select * from juror.request_lett where part_no = '" + jurorPartNo + "'");

			pStmt.executeQuery();
			log.info("Selected info letter from request_lett for " + jurorPartNo);

		} catch (SQLException e) {
			e.printStackTrace();
			log.error("Message:" + e.getMessage());
		} finally {
			pStmt.close();
			conn.close();
		}

	}

	public void onDatabaseTable_seeColIsNull_whereColColvalue(String environment, String database, String databaseTable,
															  String expectedNullColumn, String whereColumn, String whereColumnValue) throws SQLException {

		rowsExistIn_Where(
				1,
				environment,
				database,
				databaseTable,
				expectedNullColumn,
				"NULL",
				whereColumn,
				whereColumnValue,
				whereColumn,
				whereColumnValue
		);

	}

	/**
	 * JM - Delete from JD.STAFF table where name =
	 *
	 * @param staffName
	 * @throws SQLException
	 */
	public void staffWithName_doesNotExist(String staffName) throws SQLException {
		db = new DBConnection();
		String env_property = System.getProperty("env.database");
		if (env_property != null)
			conn = db.getConnection(env_property);
		else
			conn = db.getConnection("demo");
		try {

			pStmt = conn.prepareStatement("delete from juror_mod.user_roles where username=?");
			pStmt.setString(1, staffName);
			pStmt.executeQuery();
			log.info("Delete all JUROR_MOD.USER_ROLES rows where username =>" + staffName);

			pStmt = conn.prepareStatement("delete from juror_mod.user_courts where username=?");
			pStmt.setString(1, staffName);
			pStmt.executeQuery();
			log.info("Delete all JUROR_MOD.USER_COURTS rows where username =>" + staffName);

			pStmt = conn.prepareStatement("delete from juror_MOD.USERS where name=?"); // SQL Statement here
			pStmt.setString(1, staffName);

			pStmt.execute();
			log.info("Delete all JUROR_MOD.USERS rows where Name =>" + staffName);

		} catch (SQLException e) {
			e.printStackTrace();
			log.error("Message:" + e.getMessage());
		} finally {
			conn.commit();
			pStmt.close();
			conn.close();
		}
	}

	/*
     * Delete row from where juror_number
            juror_response
                juror_response_aud
                juror_response_cjs_employment
                juror_response_special_needs

            change_log
                change_log_item

            user_juror_response_audit
     */
	public void clean_juror_digital(String part_no) throws SQLException {
		db = new DBConnection();
		String env_property = System.getProperty("env.database");
		if (env_property != null)
			conn = db.getConnection(env_property);
		else
			conn = db.getConnection("demo");
		try {
			pStmt = conn.prepareStatement("delete from juror_digital.juror_response_aud where juror_number=?");
			pStmt.setString(1, part_no);
			pStmt.execute();
			log.info("Deleted from juror_response_aud where juror_number=>" + part_no);

			pStmt = conn.prepareStatement("delete from juror_digital.juror_response_cjs_employment where juror_number=?");
			pStmt.setString(1, part_no);
			pStmt.execute();
			log.info("Deleted from juror_response_cjs_employment where juror_number=>" + part_no);

			pStmt = conn.prepareStatement("delete from juror_digital.juror_response_special_needs where juror_number=?");
			pStmt.setString(1, part_no);
			pStmt.execute();
			log.info("Deleted from juror_response_special_needs where juror_number=>" + part_no);

			pStmt = conn.prepareStatement("delete from juror_digital.change_log_item where change_log in (select id from juror_digital.change_log where juror_number=?)");
			pStmt.setString(1, part_no);
			pStmt.execute();
			log.info("Deleted from change_log where juror_number=>" + part_no);

			pStmt = conn.prepareStatement("delete from juror_digital.change_log where juror_number=?");
			pStmt.setString(1, part_no);
			pStmt.execute();
			log.info("Deleted from change_log where juror_number=>" + part_no);

			pStmt = conn.prepareStatement("delete from juror_digital.USER_JUROR_RESPONSE_AUDIT where juror_number=?");
			pStmt.setString(1, part_no);
			pStmt.execute();
			log.info("Deleted from USER_JUROR_RESPONSE_AUDIT where juror_number=>" + part_no);

			pStmt = conn.prepareStatement("delete from juror_digital.juror_response where juror_number=?");
			pStmt.setString(1, part_no);
			pStmt.execute();
			log.info("Deleted from juror_response where juror_number=>" + part_no);

			pStmt = conn.prepareStatement("delete from juror_digital.paper_response where juror_number=?");
			pStmt.setString(1, part_no);
			pStmt.execute();
			log.info("Deleted from paper_response where juror_number=>" + part_no);

			pStmt = conn.prepareStatement("delete from juror_digital.paper_response_cjs_employment where juror_number=?");
			pStmt.setString(1, part_no);
			pStmt.execute();
			log.info("Deleted from paper_response_cjs_employment where juror_number=>" + part_no);

			pStmt = conn.prepareStatement("delete from juror_digital.paper_response_special_needs where juror_number=?");
			pStmt.setString(1, part_no);
			pStmt.execute();
			log.info("Deleted from paper_response_special_needs where juror_number=>" + part_no);

			//for locked out scenarios
			pStmt = conn.prepareStatement("delete from juror_digital.bureau_auth where username=?");
			pStmt.setString(1, part_no);
			pStmt.execute();
			log.info("Deleted from bureau_auth where username=>" + part_no);

			//for locked out scenarios
			pStmt = conn.prepareStatement("delete from juror_digital.pool_extend where part_no=?");
			pStmt.setString(1, part_no);
			pStmt.execute();
			log.info("Deleted from pool_extend where part_no=>" + part_no);

			//delete optic ref
			pStmt = conn.prepareStatement("delete from juror_digital.POOL_MEMBER_EXT where part_no=?");
			pStmt.setString(1, part_no);
			pStmt.execute();
			log.info("Deleted from POOL_MEMBER_EXT where part_=>" + part_no);


		} catch (SQLException e) {
			e.printStackTrace();
			log.error("Message:" + e.getMessage());
		} finally {
			conn.commit();
			pStmt.close();
			conn.close();
		}

	}

	//Insert an RSUM row in PART_HIST
	public void insertRSUMRow(String part_no, String pool_no) throws SQLException {

		db = new DBConnection();

		String env_property = System.getProperty("env.database");
		if (env_property != null)
			conn = db.getConnection(env_property);
		else
			conn = db.getConnection("demo");

		try {
			pStmt = conn.prepareStatement("INSERT INTO juror.part_hist (owner, part_no, date_part, history_code, user_id, other_information, pool_no, last_update)"
					+ "VALUES ('400', '" + part_no + "', CURRENT_DATE, 'RSUM', 'CPASS', 'File -JURY081001.0001', '" + pool_no + "', CURRENT_DATE)");
			pStmt.execute();
		} finally {
			conn.commit();
			pStmt.close();
			conn.close();
		}
	}

	//Insert a RESP row in PART_HIST
	public void insertRESPRow(String part_no, String pool_no) throws SQLException {

		db = new DBConnection();

		String env_property = System.getProperty("env.database");
		if (env_property != null)
			conn = db.getConnection(env_property);
		else
			conn = db.getConnection("demo");

		try {
			pStmt = conn.prepareStatement("INSERT INTO juror.part_hist (owner, part_no, date_part, history_code, user_id, other_information, pool_no, last_update)"
					+ "VALUES ('400', '" + part_no + "', CURRENT_DATE, 'RESP', 'CPASS', 'Responded', '" + pool_no + "', CURRENT_DATE)");
			pStmt.execute();
		} finally {
			conn.commit();
			pStmt.close();
			conn.close();
		}
	}

	//Insert a PUND row in PART_HIST
	public void insertPUNDRow(String part_no, String pool_no) throws SQLException {

		db = new DBConnection();

		String env_property = System.getProperty("env.database");
		if (env_property != null)
			conn = db.getConnection(env_property);
		else
			conn = db.getConnection("demo");

		try {
			pStmt = conn.prepareStatement("INSERT INTO juror.part_hist (owner, part_no, date_part, history_code, user_id, other_information, pool_no, last_update)"
					+ "VALUES ('400', '" + part_no + "', CURRENT_DATE, 'PUND', 'CPASS', NULL, '" + pool_no + "', CURRENT_DATE)");
			pStmt.execute();
		} finally {
			conn.commit();
			pStmt.close();
			conn.close();
		}
	}

	//Clean Dashboard tables
	public void clean_dashboard() throws SQLException {
		db = new DBConnection();
		String env_property = System.getProperty("env.database");
		if (env_property != null)
			conn = db.getConnection(env_property);
		else
			conn = db.getConnection("demo");
		try {
			pStmt = conn.prepareStatement("delete from juror_digital.stats_auto_processed");
			pStmt.execute();
			log.info("Deleted from juror_stats_auto_processed");

			pStmt = conn.prepareStatement("delete from juror_digital.stats_not_responded");
			pStmt.execute();
			log.info("Deleted from juror_stats_not_responded");

			pStmt = conn.prepareStatement("delete from juror_digital.stats_response_times");
			pStmt.execute();
			log.info("Deleted from juror_stats_response_times");

			pStmt = conn.prepareStatement("delete from juror_digital.stats_thirdparty_online");
			pStmt.execute();
			log.info("Deleted from juror_stats_thirdparty_online");

			pStmt = conn.prepareStatement("delete from juror_digital.stats_unprocessed_responses");
			pStmt.execute();
			log.info("Deleted from juror_stats_unprocessed_responses");

			pStmt = conn.prepareStatement("delete from juror_digital.stats_welsh_online_responses");
			pStmt.execute();
			log.info("Deleted from juror_stats_welsh_online_responses");

		} catch (SQLException e) {
			e.printStackTrace();
			log.error("Message:" + e.getMessage());
		} finally {
			conn.commit();
			pStmt.close();
			conn.close();
		}

	}

	public void clean_jurorTablesPreSetList(String part_no, String pool_no, String owner) throws SQLException {
		db = new DBConnection();
		String env_property = System.getProperty("env.database");
		if (env_property != null)
			conn = db.getConnection(env_property);
		else
			conn = db.getConnection("demo");
		try {
			pStmt = conn.prepareStatement("delete from juror.part_hist where part_no=? and owner!=? OR part_no=? and pool_no!=?");
			pStmt.setString(1, part_no);
			pStmt.setString(2, owner);
			pStmt.setString(3, part_no);
			pStmt.setString(4, pool_no);
			pStmt.execute();
			log.info("Cleared JUROR.PART_HIST for part_no=>" + part_no + "<= and owner =>" + owner + "OR part_no =>" + part_no + "<= and pool_no NOT =>" + pool_no);

			pStmt = conn.prepareStatement("delete from juror.CONFIRM_LETT where part_no=? and owner=?");
			pStmt.setString(1, part_no);
			pStmt.setString(2, owner);
			pStmt.execute();
			log.info("Cleared JUROR.CONFIRM_LETT for part_no=>" + part_no + "<= and owner =>" + owner);

			pStmt = conn.prepareStatement("delete from juror.defer_dbf where part_no=?");
			pStmt.setString(1, part_no);
			pStmt.execute();
			log.info("Cleared JUROR.defer_dbf for part_no=>" + part_no);

			pStmt = conn.prepareStatement("delete from juror.def_lett where part_no=?");
			pStmt.setString(1, part_no);
			pStmt.execute();
			log.info("Cleared JUROR.def_lett for part_no=>" + part_no);

			pStmt = conn.prepareStatement("delete from juror.def_denied where part_no=?");
			pStmt.setString(1, part_no);
			pStmt.execute();
			log.info("Cleared JUROR.def_denied for part_no=>" + part_no);

			pStmt = conn.prepareStatement("delete from juror.exc_lett where part_no=? and owner=?");
			pStmt.setString(1, part_no);
			pStmt.setString(2, owner);
			pStmt.execute();
			log.info("Cleared JUROR.exc_lett for part_no=>" + part_no + "<= and owner =>" + owner);

			pStmt = conn.prepareStatement("delete from juror.exc_denied_lett where part_no=? and owner=?");
			pStmt.setString(1, part_no);
			pStmt.setString(2, owner);
			pStmt.execute();
			log.info("Cleared JUROR.exc_denied_lett for part_no=>" + part_no + "<= and owner =>" + owner);

			pStmt = conn.prepareStatement("delete from juror.disq_lett where part_no=? and owner=?");
			pStmt.setString(1, part_no);
			pStmt.setString(2, owner);
			pStmt.execute();
			log.info("Cleared JUROR.disq_lett for part_no=>" + part_no + "<= and owner =>" + owner);

			pStmt = conn.prepareStatement("delete from juror.part_amendments where part_no=? and owner=?");
			pStmt.setString(1, part_no);
			pStmt.setString(2, owner);
			pStmt.execute();
			log.info("Cleared JUROR.part_amendments for part_no=>" + part_no + "<= and owner =>" + owner);

			pStmt = conn.prepareStatement("delete from juror.phone_log where part_no=?");
			pStmt.setString(1, part_no);
			pStmt.execute();
			log.info("Cleared JUROR.phone_log for part_no=>" + part_no + "");

		} catch (SQLException e) {
			e.printStackTrace();
			log.error("Message:" + e.getMessage());
		} finally {
			conn.commit();
			pStmt.close();
			conn.close();
		}

	}

	public void clean_juror(String part_no, String pool_no, String owner) throws SQLException {
		db = new DBConnection();
		String env_property = System.getProperty("env.database");
		if (env_property != null)
			conn = db.getConnection(env_property);
		else
			conn = db.getConnection("demo");
		try {
			pStmt = conn.prepareStatement("delete from juror.pool where part_no=? and owner!=? OR part_no=? and pool_no!=?");
			pStmt.setString(1, part_no);
			pStmt.setString(2, owner);
			pStmt.setString(3, part_no);
			pStmt.setString(4, pool_no);
			pStmt.execute();
			log.info("Cleared JUROR.POOL for part_no=>" + part_no + "<= and owner is not " + owner);

			pStmt = conn.prepareStatement("update juror.pool set"
					+ " status='1', "
					+ " responded='N', "
					+ " title = NULL,"
					+ "	dob = NULL,"
					+ "	ADDRESS3 = NULL,"
					+ "	ADDRESS4 = 'London',"
					+ "	ADDRESS5 = NULL,"
					+ "	ADDRESS6 = NULL,"
					+ "	H_PHONE = NULL,"
					+ "	W_PHONE = NULL,"
					+ "	W_PH_LOCAL = NULL,"
					+ "	TIMES_SEL = NULL,"
					+ " TRIAL_NO = NULL,"
					+ " JUROR_NO = NULL,"
					+ " EXC_CODE = NULL,"
					+ " DATE_EXCUS = NULL,"
					+ " DATE_DISQ = NULL,"
					+ " DISQ_CODE = NULL,"
					+ " ACC_EXC = NULL,"
					+ " NO_DEF_POS = NULL,"
					+ " DEF_DATE = NULL,"
					+ "	USER_EDTQ = NULL,"
					+ "	NOTES = NULL,"
					+ "	WELSH = NULL,"
					+ "	PHOENIX_DATE = NULL,"
					+ "	PHOENIX_CHECKED = NULL,"
					+ "	POLICE_CHECK = NULL,"
					+ "	M_PHONE = NULL,"
					+ "	H_EMAIL = NULL,"
					+ "	CONTACT_PREFERENCE = NULL,"
					+ " READ_ONLY ='N',"
					+ " NOTIFICATIONS ='0',"
					+ " IS_ACTIVE ='Y'"
					+ " where "
					+ " part_no = ? and pool_no = ?");

			pStmt.setString(1, part_no);
			pStmt.setString(2, pool_no);

			pStmt.executeUpdate();

			log.info("Cleaned up juror table where part_no=>" + part_no);


		} catch (SQLException e) {
			e.printStackTrace();
			log.error("Message:" + e.getMessage());
		} finally {
			conn.commit();
			pStmt.close();
			conn.close();
		}
	}

	//	#danielle
	public void resetPooltoPendingAllocation(String pool_no) throws SQLException {
		db = new DBConnection();
		String env_property = System.getProperty("env.database");
		if (env_property != null)
			conn = db.getConnection(env_property);
		else
			conn = db.getConnection("demo");
		try {
			pStmt = conn.prepareStatement("update juror_digital.juror_response set"
					+ " staff_login = NULL,"
					+ "	staff_assignment_date = NULL "
					+ " where processing_status='TODO' and  juror_number in "
					+ "( "
					+ "select part_no from juror.pool where "
					+ " pool_no = ?"
					+ ")"
			);


			pStmt.setString(1, pool_no);

			pStmt.executeUpdate();
			log.info("Reset to PENDING ALLOCATION where pool_no=>" + pool_no);


		} catch (SQLException e) {
			e.printStackTrace();
			log.error("Message:" + e.getMessage());
		} finally {
			conn.commit();
			pStmt.close();
			conn.close();
		}

	}

	public void straightThroughDisabled() throws SQLException {
		db = new DBConnection();
		String env_property = System.getProperty("env.database");
		if (env_property != null)
			conn = db.getConnection(env_property);
		else
			conn = db.getConnection("demo");
		try {
			pStmt = conn.prepareStatement("update juror_digital.app_settings set value='TRUE' where setting in ("
					+ "'STRAIGHT_THROUGH_ACCEPTANCE_DISABLED', "
					+ "'STRAIGHT_THROUGH_AGE_EXCUSAL_DISABLED',"
					+ "'STRAIGHT_THROUGH_DECEASED_EXCUSAL_DISABLED')");
			pStmt.execute();
			log.info("Updated app_settings to disable straight_through");


		} catch (SQLException e) {
			e.printStackTrace();
			log.error("Message:" + e.getMessage());
			log.info(11);
		} finally {
			conn.commit();
			pStmt.close();
			conn.close();
		}

	}

	public void deleteCourtCopyOfRecord(String partNo) throws SQLException {
		db = new DBConnection();
		String env_property = System.getProperty("env.database");
		if (env_property != null)
			conn = db.getConnection(env_property);
		else
			conn = db.getConnection("demo");
		try {
			pStmt = conn.prepareStatement("DELETE FROM JUROR.POOL WHERE OWNER !='400' AND PART_NO='" + partNo + "'");
			pStmt.execute();
			log.info("Deleted court version of juror record for juror " + partNo);

		} catch (SQLException e) {
			e.printStackTrace();
			log.error("Message:" + e.getMessage());
			log.info(11);
		} finally {
			conn.commit();
			pStmt.close();
			conn.close();
		}

	}

	public void deleteAdditionalBureauRecords(String partNo, String poolNo) throws SQLException {
		db = new DBConnection();
		String env_property = System.getProperty("env.database");
		if (env_property != null)
			conn = db.getConnection(env_property);
		else
			conn = db.getConnection("demo");
		try {
			pStmt = conn.prepareStatement("DELETE FROM JUROR.POOL WHERE OWNER ='400' AND POOL_NO != '" + poolNo + "' AND part_no='" + partNo + "'");
			pStmt.execute();
			conn.commit();

			pStmt = conn.prepareStatement("UPDATE JUROR.POOL SET IS_ACTIVE='Y' WHERE OWNER ='400' AND IS_ACTIVE='N' AND part_no='" + partNo + "'");
			pStmt.execute();

			log.info("Deleted court version of juror record for juror " + partNo);


		} catch (SQLException e) {
			e.printStackTrace();
			log.error("Message:" + e.getMessage());
			log.info(11);
		} finally {
			conn.commit();
			pStmt.close();
			conn.close();
		}

	}

	public void straightThroughEnabled() throws SQLException {
		db = new DBConnection();
		String env_property = System.getProperty("env.database");
		if (env_property != null)
			conn = db.getConnection(env_property);
		else
			conn = db.getConnection("demo");
		try {
			pStmt = conn.prepareStatement("update juror_digital.app_settings set value='FALSE' where setting in ("
					+ "'STRAIGHT_THROUGH_ACCEPTANCE_DISABLED', "
					+ "'STRAIGHT_THROUGH_AGE_EXCUSAL_DISABLED',"
					+ "'STRAIGHT_THROUGH_DECEASED_EXCUSAL_DISABLED')");
			pStmt.execute();
			log.info("Updated app_settings to enable straight_through");


		} catch (SQLException e) {
			e.printStackTrace();
			log.error("Message:" + e.getMessage());
			log.info(11);
		} finally {
			conn.commit();
			pStmt.close();
			conn.close();
		}

	}

	//update juror_response set date_received = TO_DATE('2018/02/06 10:00:00', 'YYYY/MM/DD HH:MI:SS') where juror_number='645700997'
	public void dateReceviedFor_setTo_workingDaysBeforeCurrent(String part_no, Integer workingDays) throws SQLException {
		String dateToUpdateTo = DateManipulator.addWorkingDaysToCurrentDate(-6);
		db = new DBConnection();
		String env_property = System.getProperty("env.database");
		if (env_property != null)
			conn = db.getConnection(env_property);
		else
			conn = db.getConnection("demo");
		try {
			pStmt = conn.prepareStatement("update juror_digital.juror_response set date_received = TO_DATE(?, 'YYYY-MM-DD HH24:MI:SS') where juror_number=?");
			pStmt.setString(1, dateToUpdateTo);
			pStmt.setString(2, part_no);
			pStmt.execute();
			log.info("Updated app_settings to disable straight_through");


		} catch (SQLException e) {
			e.printStackTrace();
			log.error("Message:" + e.getMessage());
		} finally {
			conn.commit();
			pStmt.close();
			conn.close();
		}

	}

	public void clean_jurorTable_wherePartNoOwner(String tableName, String part_no, String owner) throws SQLException {
		db = new DBConnection();

		String env_property = System.getProperty("env.database");
		if (env_property != null)
			conn = db.getConnection(env_property);
		else
			conn = db.getConnection("demo");
		try {
			pStmt = conn.prepareStatement("delete from juror." + tableName + " where part_no=? and owner=?");
			pStmt.setString(1, part_no);
			pStmt.setString(2, owner);
			pStmt.execute();
			log.info("Cleared down table =>" + tableName + "<= for part_no=>" + part_no + "<= and owner =>" + owner);


		} catch (SQLException e) {
			e.printStackTrace();
			log.error("Message:" + e.getMessage());
		} finally {
			conn.commit();
			pStmt.close();
			conn.close();
		}
	}


	public void resetJurorDigitalDatabase() throws SQLException {
		db = new DBConnection();

		String env_property = System.getProperty("env.database");
		if (env_property != null)
			conn = db.getConnection(env_property);
		else
			conn = db.getConnection("demo");

		try {
			pStmt = conn.prepareStatement("Delete from juror_digital.change_log_item Where change_log in (select c.id from juror_digital.change_log c, juror_digital.juror_response r where c.juror_number = r.juror_number and processing_status = 'TODO')");
			pStmt.execute();

			pStmt = conn.prepareStatement("Delete from juror_digital.change_log Where juror_number in (select juror_number from juror_digital.juror_response where processing_status = 'TODO')");
			pStmt.execute();

			pStmt = conn.prepareStatement("Delete from juror_digital.user_juror_response_audit Where juror_number in (select juror_number from juror_digital.juror_response where processing_status = 'TODO')");
			pStmt.execute();

			pStmt = conn.prepareStatement("Delete from juror_digital.juror_response_aud Where juror_number in (select juror_number from juror_digital.juror_response where processing_status = 'TODO')");
			pStmt.execute();

			pStmt = conn.prepareStatement("Delete from juror_digital.juror_response_cjs_employment Where juror_number in (select juror_number from juror_digital.juror_response where processing_status = 'TODO')");
			pStmt.execute();

			pStmt = conn.prepareStatement("Delete from juror_digital.juror_response_special_needs Where juror_number in (select juror_number from juror_digital.juror_response where processing_status = 'TODO')");
			pStmt.execute();

			pStmt = conn.prepareStatement("Delete from juror_digital.juror_response Where processing_status = 'TODO'");
			pStmt.execute();

		} catch (SQLException e) {
			e.printStackTrace();
			log.error("Message:" + e.getMessage());
		} finally {
			conn.commit();
			pStmt.close();
			conn.close();
		}
	}

	public void usernameHasCourt_setAs(String username, int courtPosition, String courtRoom) throws SQLException {
		db = new DBConnection();

		String env_property = System.getProperty("env.database");
		if (env_property != null)
			conn = db.getConnection(env_property);
		else
			conn = db.getConnection("demo");

		String courtColumnName = "COURT_" + courtPosition;
		try {
			pStmt = conn.prepareStatement("update juror_digital.staff set " + courtColumnName + "=? where login=?");
			pStmt.setString(1, courtRoom);
			pStmt.setString(2, username);
			pStmt.execute();
			log.info("Set " + courtColumnName + " to =>" + courtRoom + "<= for user =>" + username);


		} catch (SQLException e) {
			e.printStackTrace();
			log.error("Message:" + e.getMessage());
		} finally {
			conn.commit();
			pStmt.close();
			conn.close();
		}
	}

	public void deleteTeam() throws SQLException {
		db = new DBConnection();

		String env_property = System.getProperty("env.database");
		if (env_property != null)
			conn = db.getConnection(env_property);
		else
			conn = db.getConnection("demo");

		try {

			pStmt = conn.prepareStatement("delete from juror_mod.user_roles where username='TeamPickListUser'");
			pStmt.executeQuery();
			log.info("Delete all JUROR_MOD.USER_ROLES rows where username='TeamPickListUser'");

			pStmt = conn.prepareStatement("delete from juror_mod.user_courts where username='TeamPickListUser'");
			pStmt.executeQuery();
			log.info("Delete all JUROR_MOD.USER_COURTS rows where username='TeamPickListUser'");

			pStmt = conn.prepareStatement("Delete from juror_mod.users where username='TeamPickListUser'");
			pStmt.execute();


		} catch (SQLException e) {
			e.printStackTrace();
			log.error("Message:" + e.getMessage());
		} finally {
			conn.commit();
			pStmt.close();
			conn.close();
		}
	}

	public void deleteNewPoolRequests() throws SQLException {
		db = new DBConnection();

		String env_property = System.getProperty("env.database");
		if (env_property != null)
			conn = db.getConnection(env_property);
		else
			conn = db.getConnection("demo");

		try {
			pStmt = conn.prepareStatement("Delete from juror.unique_pool where new_request='T'");
			pStmt.execute();


		} catch (SQLException e) {
			e.printStackTrace();
			log.error("Message:" + e.getMessage());
		} finally {
			conn.commit();
			pStmt.close();
			conn.close();
		}
	}

	public void insertConfLettRow(String part_no) throws SQLException {
		db = new DBConnection();

		String env_property = System.getProperty("env.database");
		if (env_property != null)
			conn = db.getConnection(env_property);
		else
			conn = db.getConnection("demo");

		try {
			pStmt = conn.prepareStatement("INSERT INTO juror.confirm_lett (owner, part_no, printed, date_printed)"
					+ "VALUES ('400', '" + part_no + "', null, null)");
			pStmt.execute();

		} catch (SQLException e) {
			e.printStackTrace();
			log.error("Message:inserted conf letter" + e.getMessage());
		} finally {
			conn.commit();
			pStmt.close();
			conn.close();
		}
	}

	public void deleteConfLettRow(String part_no) throws SQLException {
		db = new DBConnection();

		String env_property = System.getProperty("env.database");
		if (env_property != null)
			conn = db.getConnection(env_property);
		else
			conn = db.getConnection("demo");

		try {
			pStmt = conn.prepareStatement("DELETE FROM juror.confirm_lett WHERE PART_NO = '" + part_no + "'");
			pStmt.execute();

		} catch (SQLException e) {
			e.printStackTrace();
			log.error("Message:deleted conf letter" + e.getMessage());
		} finally {
			conn.commit();
			pStmt.close();
			conn.close();
		}
	}

	public void insertDeferralLettRow(String part_no) throws SQLException {
		db = new DBConnection();

		String env_property = System.getProperty("env.database");
		if (env_property != null)
			conn = db.getConnection(env_property);
		else
			conn = db.getConnection("demo");

		try {
			String def_date = System.getProperty("POOL.DEF_DATE");
			String exc_code = System.getProperty("POOL.EXC_CODE");
			pStmt = conn.prepareStatement("INSERT INTO juror.def_lett (owner, part_no, date_def, exc_code, printed, date_printed)"
					+ "VALUES ('400', '" + part_no + "', '" + def_date + "', '" + exc_code + "', null, null)");
			pStmt.execute();

		} catch (SQLException e) {
			e.printStackTrace();
			log.error("Message:inserted def letter" + e.getMessage());
		} finally {
			conn.commit();
			pStmt.close();
			conn.close();
		}
	}

	public void deleteDeferralLettRow(String part_no) throws SQLException {
		db = new DBConnection();

		String env_property = System.getProperty("env.database");
		if (env_property != null)
			conn = db.getConnection(env_property);
		else
			conn = db.getConnection("demo");

		try {
			pStmt = conn.prepareStatement("DELETE FROM juror.def_lett WHERE PART_NO = '" + part_no + "'");
			pStmt.execute();

		} catch (SQLException e) {
			e.printStackTrace();
			log.error("Message:deleted def letter" + e.getMessage());
		} finally {
			conn.commit();
			pStmt.close();
			conn.close();
		}
	}

	public void insertExcusalLettRow(String part_no) throws SQLException {
		db = new DBConnection();

		String env_property = System.getProperty("env.database");
		if (env_property != null)
			conn = db.getConnection(env_property);
		else
			conn = db.getConnection("demo");

		try {
			String exc_date = System.getProperty("POOL.DATE_EXCUS");
			String exc_code = System.getProperty("POOL.EXC_CODE");
			pStmt = conn.prepareStatement("INSERT INTO juror.exc_lett (owner, part_no, date_exc, exc_code, printed, date_printed)"
					+ "VALUES ('400', '" + part_no + "', '" + exc_date + "', '" + exc_code + "', null, null)");
			pStmt.execute();

		} catch (SQLException e) {
			e.printStackTrace();
			log.error("Message:inserted exc letter" + e.getMessage());
		} finally {
			conn.commit();
			pStmt.close();
			conn.close();
		}
	}

	public void deleteExcusalLettRow(String part_no) throws SQLException {
		db = new DBConnection();

		String env_property = System.getProperty("env.database");
		if (env_property != null)
			conn = db.getConnection(env_property);
		else
			conn = db.getConnection("demo");

		try {
			pStmt = conn.prepareStatement("DELETE FROM juror.exc_lett WHERE PART_NO = '" + part_no + "'");
			pStmt.execute();

		} catch (SQLException e) {
			e.printStackTrace();
			log.error("Message:deleted exc letter" + e.getMessage());
		} finally {
			conn.commit();
			pStmt.close();
			conn.close();
		}
	}

	public void insertPostponementLettRow(String part_no) throws SQLException {
		db = new DBConnection();

		String env_property = System.getProperty("env.database");
		if (env_property != null)
			conn = db.getConnection(env_property);
		else
			conn = db.getConnection("demo");

		try {
			String date = System.getProperty("POOL.LAST_UPDATE");
			pStmt = conn.prepareStatement("INSERT INTO juror.postpone_lett (owner, part_no, date_postpone, printed, date_printed)"
					+ "VALUES ('400', '" + part_no + "', '" + date + "', null, null)");
			pStmt.execute();

		} catch (SQLException e) {
			e.printStackTrace();
			log.error("Message:inserted postpone letter" + e.getMessage());
		} finally {
			conn.commit();
			pStmt.close();
			conn.close();
		}
	}

	public void deletePostponementLettRow(String part_no) throws SQLException {
		db = new DBConnection();

		String env_property = System.getProperty("env.database");
		if (env_property != null)
			conn = db.getConnection(env_property);
		else
			conn = db.getConnection("demo");

		try {
			pStmt = conn.prepareStatement("DELETE FROM juror.postpone_lett WHERE PART_NO = '" + part_no + "'");
			pStmt.execute();

		} catch (SQLException e) {
			e.printStackTrace();
			log.error("Message:deleted postpone letter" + e.getMessage());
		} finally {
			conn.commit();
			pStmt.close();
			conn.close();
		}
	}

	public void insertDefDeniedLettRow(String part_no) throws SQLException {
		db = new DBConnection();

		String env_property = System.getProperty("env.database");
		if (env_property != null)
			conn = db.getConnection(env_property);
		else
			conn = db.getConnection("demo");

		try {
			String def_date = System.getProperty("POOL.DATE_DEF");
			String exc_code = System.getProperty("POOL.EXC_CODE");
			pStmt = conn.prepareStatement("INSERT INTO juror.def_denied (owner, part_no, date_def, exc_code, printed, date_printed)"
					+ "VALUES ('400', '" + part_no + "', '" + def_date + "', '" + exc_code + "' null, null)");
			pStmt.execute();

		} catch (SQLException e) {
			e.printStackTrace();
			log.error("Message:inserted def denied letter" + e.getMessage());
		} finally {
			conn.commit();
			pStmt.close();
			conn.close();
		}
	}

	public void deleteDefDeniedLettRow(String part_no) throws SQLException {
		db = new DBConnection();

		String env_property = System.getProperty("env.database");
		if (env_property != null)
			conn = db.getConnection(env_property);
		else
			conn = db.getConnection("demo");

		try {
			pStmt = conn.prepareStatement("DELETE FROM juror.def_denied WHERE PART_NO = '" + part_no + "'");
			pStmt.execute();

		} catch (SQLException e) {
			e.printStackTrace();
			log.error("Message:deleted def_denied letter" + e.getMessage());
		} finally {
			conn.commit();
			pStmt.close();
			conn.close();
		}
	}

	public void insertExcDeniedLettRow(String part_no) throws SQLException {
		db = new DBConnection();

		String env_property = System.getProperty("env.database");
		if (env_property != null)
			conn = db.getConnection(env_property);
		else
			conn = db.getConnection("demo");

		try {
			String exc_date = System.getProperty("POOL.DATE_EXCUS");
			String exc_code = System.getProperty("POOL.EXC_CODE");
			pStmt = conn.prepareStatement("INSERT INTO juror.exc_denied_lett (owner, part_no, date_excused, exc_code, printed, date_printed)"
					+ "VALUES ('400', '" + part_no + "', '" + exc_date + "', '" + exc_code + "' null, null)");
			pStmt.execute();

		} catch (SQLException e) {
			e.printStackTrace();
			log.error("Message:inserted exc denied letter" + e.getMessage());
		} finally {
			conn.commit();
			pStmt.close();
			conn.close();
		}
	}

	public void deleteExcDeniedLettRow(String part_no) throws SQLException {
		db = new DBConnection();

		String env_property = System.getProperty("env.database");
		if (env_property != null)
			conn = db.getConnection(env_property);
		else
			conn = db.getConnection("demo");

		try {
			pStmt = conn.prepareStatement("DELETE FROM juror.exc_denied_lett WHERE PART_NO = '" + part_no + "'");
			pStmt.execute();

		} catch (SQLException e) {
			e.printStackTrace();
			log.error("Message:deleted exc_denied letter" + e.getMessage());
		} finally {
			conn.commit();
			pStmt.close();
			conn.close();
		}
	}

	public void insertDisqualifiedLettRow(String part_no) throws SQLException {
		db = new DBConnection();

		String env_property = System.getProperty("env.database");
		if (env_property != null)
			conn = db.getConnection(env_property);
		else
			conn = db.getConnection("demo");

		try {
			String disq_date = System.getProperty("POOL.DATE_DISQ");
			String disq_code = System.getProperty("POOL.DISQ_CODE");
			pStmt = conn.prepareStatement("INSERT INTO juror.disq_lett (owner, part_no, disq_code, disq_date, date_printed, printed)"
					+ "VALUES ('400', '" + part_no + "', '" + disq_code + "', '" + disq_date + "' null, null)");
			pStmt.execute();

		} catch (SQLException e) {
			e.printStackTrace();
			log.error("Message:inserted disqualifed letter" + e.getMessage());
		} finally {
			conn.commit();
			pStmt.close();
			conn.close();
		}
	}

	public void deleteDisqualifiedLettRow(String part_no) throws SQLException {
		db = new DBConnection();

		String env_property = System.getProperty("env.database");
		if (env_property != null)
			conn = db.getConnection(env_property);
		else
			conn = db.getConnection("demo");

		try {
			pStmt = conn.prepareStatement("DELETE FROM juror.disq_lett WHERE PART_NO = '" + part_no + "'");
			pStmt.execute();

		} catch (SQLException e) {
			e.printStackTrace();
			log.error("Message:deleted disqualified letter" + e.getMessage());
		} finally {
			conn.commit();
			pStmt.close();
			conn.close();
		}
	}

	public void deleteNewRecordsForPartNo(String partNo) throws SQLException {
		db = new DBConnection();

		String env_property = System.getProperty("env.database");
		if (env_property != null)
			conn = db.getConnection(env_property);
		else
			conn = db.getConnection("demo");

		try {
			pStmt = conn.prepareStatement("DELETE FROM juror.defer_dbf WHERE part_no = '" + partNo + "'");
			pStmt.execute();

			pStmt = conn.prepareStatement("DELETE FROM juror.pool WHERE part_no = '" + partNo + "'");
			pStmt.execute();

			pStmt = conn.prepareStatement("DELETE FROM juror_digital.paper_response WHERE juror_number = '" + partNo + "'");
			pStmt.execute();

			pStmt = conn.prepareStatement("DELETE FROM juror_digital.juror_response WHERE juror_number = '" + partNo + "'");
			pStmt.execute();

		} catch (SQLException e) {
			e.printStackTrace();
			log.error("Message:deleted new records for juror '" + partNo + "' + e.getMessage()");
		} finally {
			conn.commit();
			pStmt.close();
			conn.close();
		}
	}

	public void deleteNewPool(String court) throws SQLException {
		db = new DBConnection();

		String env_property = System.getProperty("env.database");
		if (env_property != null)
			conn = db.getConnection(env_property);
		else
			conn = db.getConnection("demo");

		try {
			pStmt = conn.prepareStatement("DELETE FROM juror.defer_dbf WHERE part_no in (select part_no from juror.pool where pool_no in ('" + court + "111111', '" + court + "222222', '" + court + "333333','" + court + "444444', '" + court + "999999'))");
			pStmt.execute();

			pStmt = conn.prepareStatement("DELETE FROM juror.pool WHERE pool_no in ('" + court + "111111', '" + court + "222222', '" + court + "333333', '" + court + "444444', '" + court + "999999')");
			pStmt.execute();

			pStmt = conn.prepareStatement("DELETE FROM juror.pool WHERE part_no in ('6" + court + "11111', '6" + court + "22222', '6" + court + "33333', '6" + court + "44444','6" + court + "99999')");
			pStmt.execute();

			pStmt = conn.prepareStatement("DELETE FROM juror.unique_pool WHERE pool_no in ('" + court + "111111', '" + court + "222222', '" + court + "333333', '" + court + "444444', '" + court + "999999')");
			pStmt.execute();

			pStmt = conn.prepareStatement("DELETE FROM juror_digital.pool_request_ext WHERE pool_no in ('" + court + "111111', '" + court + "222222', '" + court + "333333', '" + court + "444444', '" + court + "999999')");
			pStmt.execute();

			pStmt = conn.prepareStatement("DELETE FROM juror_digital.pool_request_ext WHERE pool_no in ('" + court + "111111', '" + court + "222222', '" + court + "333333', '" + court + "444444', '" + court + "999999')");
			pStmt.execute();

		} catch (SQLException e) {
			e.printStackTrace();
			log.error("Message:deleted new pool for court '" + court + "' + e.getMessage()");
		} finally {
			conn.commit();
			pStmt.close();
			conn.close();
		}
	}


	public void deletePoolNumber(String poolNumber) throws SQLException {
		db = new DBConnection();

		String env_property = System.getProperty("env.database");
		if (env_property != null)
			conn = db.getConnection(env_property);
		else
			conn = db.getConnection("demo");

		try {
			pStmt = conn.prepareStatement("DELETE FROM juror.defer_dbf WHERE part_no in (select part_no from juror.pool where pool_no in ('" + poolNumber + "'))");
			pStmt.execute();

			pStmt = conn.prepareStatement("DELETE FROM juror.pool WHERE pool_no in ('" + poolNumber + "')");
			pStmt.execute();

			pStmt = conn.prepareStatement("DELETE FROM juror.pool WHERE part_no in ('" + poolNumber + "')");
			pStmt.execute();

			pStmt = conn.prepareStatement("DELETE FROM juror.unique_pool WHERE pool_no in ('" + poolNumber + "')");
			pStmt.execute();

			pStmt = conn.prepareStatement("DELETE FROM juror_digital.pool_request_ext WHERE pool_no in ('" + poolNumber + "')");
			pStmt.execute();

			pStmt = conn.prepareStatement("DELETE FROM juror_digital.pool_request_ext WHERE pool_no in ('" + poolNumber + "')");
			pStmt.execute();

		} catch (SQLException e) {
			e.printStackTrace();
			log.error("Message:deleted pool deleted -- '" + poolNumber + " --- " + e.getMessage());
		} finally {
			conn.commit();
			pStmt.close();
			conn.close();
		}
	}

	//osman testing
	public void deleteRequestLett(String court) throws SQLException {
		db = new DBConnection();

		String env_property = System.getProperty("env.database");
		if (env_property != null)
			conn = db.getConnection(env_property);
		else
			conn = db.getConnection("demo");

		try {
			pStmt = conn.prepareStatement("DELETE FROM juror.request_lett WHERE part_no in (select part_no from juror.pool where pool_no in ('" + court + "999999', '" + court + "222222', '" + court + "333333'))");
			pStmt.execute();

		} catch (SQLException e) {
			e.printStackTrace();
			log.error("Message:deleted request lett for court '" + court + "' + e.getMessage()");
		} finally {
			conn.commit();
			pStmt.close();
			conn.close();
		}
	}

	public void deleteRequestLettForPartNo(String part_no) throws SQLException {
		db = new DBConnection();

		String env_property = System.getProperty("env.database");
		if (env_property != null)
			conn = db.getConnection(env_property);
		else
			conn = db.getConnection("demo");

		try {
			pStmt = conn.prepareStatement("DELETE FROM juror.request_lett WHERE part_no = '" + part_no + "'");
			pStmt.execute();

		} catch (SQLException e) {
			e.printStackTrace();
			log.error("Message:deleted request lett for part_no '" + part_no + "' + e.getMessage()");
		} finally {
			conn.commit();
			pStmt.close();
			conn.close();
		}
	}

	public void deletePaperResponses() throws SQLException {
		db = new DBConnection();

		String env_property = System.getProperty("env.database");
		if (env_property != null)
			conn = db.getConnection(env_property);
		else
			conn = db.getConnection("demo");

		try {

			pStmt = conn.prepareStatement("DELETE FROM JUROR_DIGITAL.PAPER_RESPONSE");
			pStmt.execute();

			pStmt = conn.prepareStatement("DELETE FROM JUROR_DIGITAL.PAPER_RESPONSE_CJS_EMPLOYMENT");
			pStmt.execute();

			pStmt = conn.prepareStatement("DELETE FROM JUROR_DIGITAL.PAPER_RESPONSE_SPECIAL_NEEDS");
			pStmt.execute();

		} catch (SQLException e) {
			e.printStackTrace();
			log.error("Message:deleted paper replies");
		} finally {
			conn.commit();
			pStmt.close();
			conn.close();
		}
	}

	public String getTodaysDateEEEddMMMyyyy() {
		String datePattern = "EEE d MMM yyyy";
		Calendar calendar = Calendar.getInstance();
		return new SimpleDateFormat(datePattern).format((calendar).getTime());
	}

	public void insertNewPoolWithDeferral(String court, String noWeeks) throws SQLException {
		db = new DBConnection();

		String env_property = System.getProperty("env.database");

		if (env_property != null)
			conn = db.getConnection(env_property);
		else
			conn = db.getConnection("demo");

		try {
			String datePattern = "dd MMMMM yyyy";
			Calendar calendar = Calendar.getInstance();
			calendar.add(Calendar.WEEK_OF_MONTH, Integer.parseInt(noWeeks));

			LocalDate localDate = calendar.toInstant().atZone(ZoneId.systemDefault()).toLocalDate();
			Date mondayDate = Date.from(localDate.atStartOfDay().atZone(ZoneId.systemDefault()).toInstant());

			String expectedDate = new SimpleDateFormat(datePattern).format((mondayDate).getTime());

			pStmt = conn.prepareStatement("INSERT INTO JUROR.UNIQUE_POOL (OWNER,POOL_NO,JURISDICTION_CODE,RETURN_DATE,NEXT_DATE,NO_REQUESTED,POOL_TOTAL,REG_SPC,POOL_TYPE,LOC_CODE,NEW_REQUEST,LAST_UPDATE,READ_ONLY,DEFERRALS_USED,ADDITIONAL_SUMMONS,ATTEND_TIME)"
					+ "VALUES ('" + court + "','" + court + "111111',null,to_date(CURRENT_DATE,'DD-MON-RR'),to_date(CURRENT_DATE,'DD-MON-RR'),10,10,'R','CRO','" + court + "','N',to_date(CURRENT_DATE,'DD-MON-RR'),'N',null,null,to_date(CURRENT_DATE,'DD-MON-RR'))");
			pStmt.execute();

//			#insert the pool rows
			pStmt = conn.prepareStatement("Insert into juror.pool (OWNER,PART_NO,POOL_NO,POLL_NUMBER,TITLE,LNAME,FNAME,DOB,ADDRESS,ADDRESS2,ADDRESS3,ADDRESS4,ADDRESS5,ADDRESS6,ZIP,H_PHONE,W_PHONE,W_PH_LOCAL,TIMES_SEL,TRIAL_NO,JUROR_NO,REG_SPC,RET_DATE,DEF_DATE,RESPONDED,DATE_EXCUS,EXC_CODE,ACC_EXC,DATE_DISQ,DISQ_CODE,MILEAGE,LOCATION,USER_EDTQ,STATUS,NOTES,NO_ATTENDANCES,IS_ACTIVE,NO_DEF_POS,NO_ATTENDED,NO_FTA,NO_AWOL,POOL_SEQ,EDIT_TAG,POOL_TYPE,LOC_CODE,NEXT_DATE,ON_CALL,PERM_DISQUAL,PAY_COUNTY_EMP,PAY_EXPENSES,SPEC_NEED,SPEC_NEED_MSG,SMART_CARD,AMT_SPENT,COMPLETION_FLAG,COMPLETION_DATE,SORT_CODE,BANK_ACCT_NAME,BANK_ACCT_NO,BLDG_SOC_ROLL_NO,WAS_DEFERRED,ID_CHECKED,POSTPONE,WELSH,PAID_CASH,TRAVEL_TIME,SCAN_CODE,FINANCIAL_LOSS,POLICE_CHECK,LAST_UPDATE,READ_ONLY,SUMMONS_FILE,REMINDER_SENT,PHOENIX_DATE,PHOENIX_CHECKED,M_PHONE,H_EMAIL,CONTACT_PREFERENCE,NOTIFICATIONS,SERVICE_COMP_COMMS_STATUS,TRANSFER_DATE)"
					+ "values ('400','6" + court + "11111','" + court + "111111','857',null,'LNAME','FNAME',null,'1 STREET NAME','ANYTOWN',null,'London',null,null,'NN1 3HQ',null,null,null,null,null,null,'R',to_date(CURRENT_DATE+50,'DD-MON-RR'),null,'N',null,null,null,null,null,null,null,null,1,null,null,'Y',null,null,null,null,'0067',null,'CRO','" + court + "',to_date(CURRENT_DATE+50,'DD-MON-RR'),'N',null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,to_date(CURRENT_DATE-30,'DD-MON-RR'),'Y',null,null,null,null,null,null,null,0,null,CURRENT_DATE-20)");
			pStmt.execute();

			pStmt = conn.prepareStatement("Insert into juror.pool (OWNER,PART_NO,POOL_NO,POLL_NUMBER,TITLE,LNAME,FNAME,DOB,ADDRESS,ADDRESS2,ADDRESS3,ADDRESS4,ADDRESS5,ADDRESS6,ZIP,H_PHONE,W_PHONE,W_PH_LOCAL,TIMES_SEL,TRIAL_NO,JUROR_NO,REG_SPC,RET_DATE,DEF_DATE,RESPONDED,DATE_EXCUS,EXC_CODE,ACC_EXC,DATE_DISQ,DISQ_CODE,MILEAGE,LOCATION,USER_EDTQ,STATUS,NOTES,NO_ATTENDANCES,IS_ACTIVE,NO_DEF_POS,NO_ATTENDED,NO_FTA,NO_AWOL,POOL_SEQ,EDIT_TAG,POOL_TYPE,LOC_CODE,NEXT_DATE,ON_CALL,PERM_DISQUAL,PAY_COUNTY_EMP,PAY_EXPENSES,SPEC_NEED,SPEC_NEED_MSG,SMART_CARD,AMT_SPENT,COMPLETION_FLAG,COMPLETION_DATE,SORT_CODE,BANK_ACCT_NAME,BANK_ACCT_NO,BLDG_SOC_ROLL_NO,WAS_DEFERRED,ID_CHECKED,POSTPONE,WELSH,PAID_CASH,TRAVEL_TIME,SCAN_CODE,FINANCIAL_LOSS,POLICE_CHECK,LAST_UPDATE,READ_ONLY,SUMMONS_FILE,REMINDER_SENT,PHOENIX_DATE,PHOENIX_CHECKED,M_PHONE,H_EMAIL,CONTACT_PREFERENCE,NOTIFICATIONS,SERVICE_COMP_COMMS_STATUS,TRANSFER_DATE)"
					+ "values ('" + court + "','6" + court + "11111','" + court + "111111','857',null,'LNAME','FNAME',null,'1 STREET NAME','ANYTOWN',null,'London',null,null,'NN1 3HQ',null,null,null,null,null,null,'R',to_date(CURRENT_DATE+50,'DD-MON-RR'),to_date('" + expectedDate + "','DD-MON-RR'),'Y',to_date(CURRENT_DATE,'DD-MON-RR'),'A',null,null,null,null,null,null,7,null,null,'Y',1,null,null,null,'0067',null,'CRO','" + court + "',null,'N',null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,to_date(CURRENT_DATE-30,'DD-MON-RR'),'N',null,null,null,null,null,null,null,0,null,null)");
			pStmt.execute();

			pStmt = conn.prepareStatement("INSERT INTO JUROR.DEFER_DBF(OWNER, PART_NO, DEFER_TO, CHECKED, LOC_CODE)"
					+ "VALUES ('" + court + "','6" + court + "11111',to_date('" + expectedDate + "','DD-MON-RR'),'N','" + court + "')");
			pStmt.execute();

		} catch (SQLException e) {
			e.printStackTrace();
			log.error("Message:inserted new pool" + e.getMessage());
		} finally {
			conn.commit();
			pStmt.close();
			conn.close();
		}
	}

	public void insertCourtPoolWithDeferral(String court, String pool_no, String part_no, String no_weeks) throws SQLException {
		db = new DBConnection();

		String env_property = System.getProperty("env.database");

		if (env_property != null)
			conn = db.getConnection(env_property);
		else
			conn = db.getConnection("demo");

		if (getCountFromUniquePool(pool_no) == 0)
			pStmt = conn.prepareStatement("INSERT INTO JUROR.UNIQUE_POOL (OWNER,POOL_NO,JURISDICTION_CODE,RETURN_DATE,NEXT_DATE,NO_REQUESTED,POOL_TOTAL,REG_SPC,POOL_TYPE,LOC_CODE,NEW_REQUEST,LAST_UPDATE,READ_ONLY,DEFERRALS_USED,ADDITIONAL_SUMMONS,ATTEND_TIME)"
					+ "VALUES ('" + court + "','" + pool_no + "',null,to_date(CURRENT_DATE,'DD-MON-RR'),to_date(CURRENT_DATE,'DD-MON-RR'),10,10,'R','CRO','" + court + "','N',to_date(CURRENT_DATE,'DD-MON-RR'),'N',null,null,to_date(CURRENT_DATE,'DD-MON-RR'))");
		pStmt.execute();

		if (getCountFromPool(part_no, pool_no) == 0)
			pStmt = conn.prepareStatement("Insert into juror.pool (OWNER,PART_NO,POOL_NO,POLL_NUMBER,TITLE,LNAME,FNAME,DOB,ADDRESS,ADDRESS2,ADDRESS3,ADDRESS4,ADDRESS5,ADDRESS6,ZIP,H_PHONE,W_PHONE,W_PH_LOCAL,TIMES_SEL,TRIAL_NO,JUROR_NO,REG_SPC,RET_DATE,DEF_DATE,RESPONDED,DATE_EXCUS,EXC_CODE,ACC_EXC,DATE_DISQ,DISQ_CODE,MILEAGE,LOCATION,USER_EDTQ,STATUS,NOTES,NO_ATTENDANCES,IS_ACTIVE,NO_DEF_POS,NO_ATTENDED,NO_FTA,NO_AWOL,POOL_SEQ,EDIT_TAG,POOL_TYPE,LOC_CODE,NEXT_DATE,ON_CALL,PERM_DISQUAL,PAY_COUNTY_EMP,PAY_EXPENSES,SPEC_NEED,SPEC_NEED_MSG,SMART_CARD,AMT_SPENT,COMPLETION_FLAG,COMPLETION_DATE,SORT_CODE,BANK_ACCT_NAME,BANK_ACCT_NO,BLDG_SOC_ROLL_NO,WAS_DEFERRED,ID_CHECKED,POSTPONE,WELSH,PAID_CASH,TRAVEL_TIME,SCAN_CODE,FINANCIAL_LOSS,POLICE_CHECK,LAST_UPDATE,READ_ONLY,SUMMONS_FILE,REMINDER_SENT,PHOENIX_DATE,PHOENIX_CHECKED,M_PHONE,H_EMAIL,CONTACT_PREFERENCE,NOTIFICATIONS,SERVICE_COMP_COMMS_STATUS,TRANSFER_DATE)"
					+ "values ('400','" + part_no + "','" + pool_no + "','857',null,'LNAME','FNAME',null,'1 STREET NAME','ANYTOWN',null,'London',null,null,'NN1 3HQ',null,null,null,null,null,null,'R',to_date(CURRENT_DATE+50,'DD-MON-RR'),null,'N',null,null,null,null,null,null,null,null,1,null,null,'Y',null,null,null,null,'0067',null,'CRO','" + court + "',to_date(CURRENT_DATE+50,'DD-MON-RR'),'N',null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,to_date(CURRENT_DATE-30,'DD-MON-RR'),'Y',null,null,null,null,null,null,null,0,null,CURRENT_DATE-20)");
		pStmt.execute();

		try {
			String datePattern = "dd MMMMM yyyy";
			Calendar calendar = Calendar.getInstance();
			calendar.add(Calendar.WEEK_OF_MONTH, Integer.parseInt(no_weeks));

			LocalDate localDate = calendar.toInstant().atZone(ZoneId.systemDefault()).toLocalDate();
			Date mondayDate = Date.from(localDate.atStartOfDay().atZone(ZoneId.systemDefault()).toInstant());

			String expectedDate = new SimpleDateFormat(datePattern).format((mondayDate).getTime());

			pStmt = conn.prepareStatement("Insert into juror.pool (OWNER,PART_NO,POOL_NO,POLL_NUMBER,TITLE,LNAME,FNAME,DOB,ADDRESS,ADDRESS2,ADDRESS3,ADDRESS4,ADDRESS5,ADDRESS6,ZIP,H_PHONE,W_PHONE,W_PH_LOCAL,TIMES_SEL,TRIAL_NO,JUROR_NO,REG_SPC,RET_DATE,DEF_DATE,RESPONDED,DATE_EXCUS,EXC_CODE,ACC_EXC,DATE_DISQ,DISQ_CODE,MILEAGE,LOCATION,USER_EDTQ,STATUS,NOTES,NO_ATTENDANCES,IS_ACTIVE,NO_DEF_POS,NO_ATTENDED,NO_FTA,NO_AWOL,POOL_SEQ,EDIT_TAG,POOL_TYPE,LOC_CODE,NEXT_DATE,ON_CALL,PERM_DISQUAL,PAY_COUNTY_EMP,PAY_EXPENSES,SPEC_NEED,SPEC_NEED_MSG,SMART_CARD,AMT_SPENT,COMPLETION_FLAG,COMPLETION_DATE,SORT_CODE,BANK_ACCT_NAME,BANK_ACCT_NO,BLDG_SOC_ROLL_NO,WAS_DEFERRED,ID_CHECKED,POSTPONE,WELSH,PAID_CASH,TRAVEL_TIME,SCAN_CODE,FINANCIAL_LOSS,POLICE_CHECK,LAST_UPDATE,READ_ONLY,SUMMONS_FILE,REMINDER_SENT,PHOENIX_DATE,PHOENIX_CHECKED,M_PHONE,H_EMAIL,CONTACT_PREFERENCE,NOTIFICATIONS,SERVICE_COMP_COMMS_STATUS,TRANSFER_DATE)"
					+ "values ('" + court + "','" + part_no + "','" + pool_no + "','857',null,'LNAME','FNAME',null,'1 STREET NAME','ANYTOWN',null,'London',null,null,'NN1 3HQ',null,null,null,null,null,null,'R',to_date(CURRENT_DATE+50,'DD-MON-RR'),to_date('" + expectedDate + "','DD-MON-RR'),'Y',to_date(CURRENT_DATE,'DD-MON-RR'),'A',null,null,null,null,null,null,7,null,null,'Y',1,null,null,null,'0067',null,'CRO','" + court + "',null,'N',null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,to_date(CURRENT_DATE-30,'DD-MON-RR'),'N',null,null,null,null,null,null,null,0,null,null)");
			pStmt.execute();

			pStmt = conn.prepareStatement("INSERT INTO JUROR.DEFER_DBF(OWNER, PART_NO, DEFER_TO, CHECKED, LOC_CODE)"
					+ "VALUES ('" + court + "','" + part_no + "',to_date('" + expectedDate + "','DD-MON-RR'),'N','" + court + "')");
			pStmt.execute();

		} catch (SQLException e) {
			e.printStackTrace();
			log.error("Message:inserted new pool" + e.getMessage());

		} finally {
			conn.commit();
			pStmt.close();
			conn.close();
		}
	}

	public void clearDeferralsForWeeksAndCourt(int noWeeks, String court) throws SQLException {
		db = new DBConnection();

		String env_property = System.getProperty("env.database");

		if (env_property != null)
			conn = db.getConnection(env_property);
		else
			conn = db.getConnection("demo");

		try {
			int numberOfDays = noWeeks * 7;

			pStmt = conn.prepareStatement("DELETE FROM JUROR.DEFER_DBF WHERE LOC_CODE='"+ court +"' AND DEFER_TO=DATE_TRUNC('day', CURRENT_DATE + (8 - CAST(EXTRACT(DOW FROM CURRENT_DATE) AS INTEGER)) +" + numberOfDays + ")");
			pStmt.execute();

			System.out.println("Deferrals deleted for date falling in " + noWeeks + "weeks - for court -" + court);
		} catch (SQLException e) {
			e.printStackTrace();
			log.error("Message:deleted deferrals" + e.getMessage());
		} finally {
			conn.commit();
			pStmt.close();
			conn.close();
		}
	}

	public void insertCourtPoolWithDeferralExistingJuror(String court, String pool_no, String part_no, String no_weeks, String loc_code) throws SQLException {
		db = new DBConnection();

		String env_property = System.getProperty("env.database");

		if (env_property != null)
			conn = db.getConnection(env_property);
		else
			conn = db.getConnection("demo");

		try {
			String datePattern = "dd MMMMM yyyy";
			Calendar calendar = Calendar.getInstance();
			calendar.add(Calendar.WEEK_OF_MONTH, Integer.parseInt(no_weeks));

			LocalDate localDate = calendar.toInstant().atZone(ZoneId.systemDefault()).toLocalDate();
			Date mondayDate = Date.from(localDate.atStartOfDay().atZone(ZoneId.systemDefault()).toInstant());

			String expectedDate = new SimpleDateFormat(datePattern).format((mondayDate).getTime());

			pStmt = conn.prepareStatement("Insert into juror.pool (OWNER,PART_NO,POOL_NO,POLL_NUMBER,TITLE,LNAME,FNAME,DOB,ADDRESS,ADDRESS2,ADDRESS3,ADDRESS4,ADDRESS5,ADDRESS6,ZIP,H_PHONE,W_PHONE,W_PH_LOCAL,TIMES_SEL,TRIAL_NO,JUROR_NO,REG_SPC,RET_DATE,DEF_DATE,RESPONDED,DATE_EXCUS,EXC_CODE,ACC_EXC,DATE_DISQ,DISQ_CODE,MILEAGE,LOCATION,USER_EDTQ,STATUS,NOTES,NO_ATTENDANCES,IS_ACTIVE,NO_DEF_POS,NO_ATTENDED,NO_FTA,NO_AWOL,POOL_SEQ,EDIT_TAG,POOL_TYPE,LOC_CODE,NEXT_DATE,ON_CALL,PERM_DISQUAL,PAY_COUNTY_EMP,PAY_EXPENSES,SPEC_NEED,SPEC_NEED_MSG,SMART_CARD,AMT_SPENT,COMPLETION_FLAG,COMPLETION_DATE,SORT_CODE,BANK_ACCT_NAME,BANK_ACCT_NO,BLDG_SOC_ROLL_NO,WAS_DEFERRED,ID_CHECKED,POSTPONE,WELSH,PAID_CASH,TRAVEL_TIME,SCAN_CODE,FINANCIAL_LOSS,POLICE_CHECK,LAST_UPDATE,READ_ONLY,SUMMONS_FILE,REMINDER_SENT,PHOENIX_DATE,PHOENIX_CHECKED,M_PHONE,H_EMAIL,CONTACT_PREFERENCE,NOTIFICATIONS,SERVICE_COMP_COMMS_STATUS,TRANSFER_DATE)"
					+ "values ('" + court + "','" + part_no + "','" + pool_no + "','857',null,'LNAME','FNAME',null,'1 STREET NAME','ANYTOWN',null,'London',null,null,'NN1 3HQ',null,null,null,null,null,null,'R',to_date(CURRENT_DATE+50,'DD-MON-RR'),to_date('" + expectedDate + "','DD-MON-RR'),'Y',to_date(CURRENT_DATE,'DD-MON-RR'),'A',null,null,null,null,null,null,7,null,null,'Y',1,null,null,null,'0067',null,'CRO','" + court + "',null,'N',null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,to_date(CURRENT_DATE-30,'DD-MON-RR'),'N',null,null,null,null,null,null,null,0,null,null)");

			pStmt.execute();

			pStmt = conn.prepareStatement("INSERT INTO JUROR.DEFER_DBF(OWNER, PART_NO, DEFER_TO, CHECKED, LOC_CODE)"
					+ "VALUES ('" + court + "','" + part_no + "',to_date('" + expectedDate + "','DD-MON-RR'),'N','" + loc_code + "')");

			pStmt.execute();
			System.out.println("Deferral entered for -" + expectedDate + "- for juror -" + part_no + "- into pool -" + pool_no + "- and the owner is -" + court + "- loc_code -" + loc_code);
		} catch (SQLException e) {
			e.printStackTrace();
			log.error("Message:inserted new pool" + e.getMessage());
		} finally {
			conn.commit();
			pStmt.close();
			conn.close();
		}
	}

	public void insertNewPoolCompletedPool(String court) throws SQLException {
		db = new DBConnection();

		String env_property = System.getProperty("env.database");

		if (env_property != null)
			conn = db.getConnection(env_property);
		else
			conn = db.getConnection("demo");

		try {

			pStmt = conn.prepareStatement("INSERT INTO JUROR.UNIQUE_POOL (OWNER, POOL_NO, RETURN_DATE, NEXT_DATE, NO_REQUESTED, POOL_TOTAL, REG_SPC, POOL_TYPE, LOC_CODE, NEW_REQUEST, READ_ONLY, DEFERRALS_USED)"
					+ "VALUES('" + court + "', '" + court + "111111', CURRENT_DATE-10, CURRENT_DATE-10, 0, 0, 'R', 'CRO', '" + court + "', 'N', 'y', NULL)");
			pStmt.execute();

			pStmt = conn.prepareStatement("INSERT INTO JUROR.UNIQUE_POOL (OWNER, POOL_NO, RETURN_DATE, NEXT_DATE, NO_REQUESTED, POOL_TOTAL, REG_SPC, POOL_TYPE, LOC_CODE, NEW_REQUEST, READ_ONLY, DEFERRALS_USED)"
					+ "VALUES('400', '" + court + "111111', CURRENT_DATE-10, CURRENT_DATE-10, 0, 0, 'R', 'CRO', '" + court + "', 'N', 'N', NULL)");
			pStmt.execute();

			pStmt = conn.prepareStatement("INSERT INTO JUROR.POOL (OWNER, PART_NO, POOL_NO, LNAME, FNAME, DOB, ADDRESS, ADDRESS4, ZIP, REG_SPC, RET_DATE, RESPONDED, USER_EDTQ, STATUS, IS_ACTIVE, POOL_SEQ, POOL_TYPE, LOC_CODE, NEXT_DATE, ON_CALL, COMPLETION_FLAG, COMPLETION_DATE, WAS_DEFERRED, READ_ONLY)" +
					"VALUES('400', '6" + court + "11111', '" + court + "111111', 'PERSON', 'TEST', TIMESTAMP '1990-05-16 00:00:00.000000', '542 STREET NAME', 'ANYTOWN', 'CH1 2AN', 'R', TIMESTAMP '2023-01-23 00:00:00.000000', 'Y', 'BUREAU_USER', 2, 'Y', '0001', 'CRO', '" + court + "', TIMESTAMP '2023-01-23 00:00:00.000000', 'N', 'N', NULL, 'N', 'Y');");
			pStmt.execute();


		} catch (SQLException e) {
			e.printStackTrace();
			log.error("Message:inserted new pool" + e.getMessage());
		} finally {
			conn.commit();
			pStmt.close();
			conn.close();
		}
	}

	public void insertJurorWithDeferralIntoPool(String poolNo, String court, String noWeeks, String jurorPartNo) throws SQLException {
		db = new DBConnection();

		String env_property = System.getProperty("env.database");

		if (env_property != null)
			conn = db.getConnection(env_property);
		else
			conn = db.getConnection("demo");

		try {
			String datePattern = "dd MMMMM yyyy";
			Calendar calendar = Calendar.getInstance();
			calendar.add(Calendar.WEEK_OF_MONTH, Integer.parseInt(noWeeks));

			LocalDate localDate = calendar.toInstant().atZone(ZoneId.systemDefault()).toLocalDate();
			Date mondayDate = Date.from(localDate.atStartOfDay().atZone(ZoneId.systemDefault()).toInstant());

			String expectedDate = new SimpleDateFormat(datePattern).format((mondayDate).getTime());

//			#insert the pool rows
			pStmt = conn.prepareStatement("Insert into juror.pool (OWNER,PART_NO,POOL_NO,POLL_NUMBER,TITLE,LNAME,FNAME,DOB,ADDRESS,ADDRESS2,ADDRESS3,ADDRESS4,ADDRESS5,ADDRESS6,ZIP,H_PHONE,W_PHONE,W_PH_LOCAL,TIMES_SEL,TRIAL_NO,JUROR_NO,REG_SPC,RET_DATE,DEF_DATE,RESPONDED,DATE_EXCUS,EXC_CODE,ACC_EXC,DATE_DISQ,DISQ_CODE,MILEAGE,LOCATION,USER_EDTQ,STATUS,NOTES,NO_ATTENDANCES,IS_ACTIVE,NO_DEF_POS,NO_ATTENDED,NO_FTA,NO_AWOL,POOL_SEQ,EDIT_TAG,POOL_TYPE,LOC_CODE,NEXT_DATE,ON_CALL,PERM_DISQUAL,PAY_COUNTY_EMP,PAY_EXPENSES,SPEC_NEED,SPEC_NEED_MSG,SMART_CARD,AMT_SPENT,COMPLETION_FLAG,COMPLETION_DATE,SORT_CODE,BANK_ACCT_NAME,BANK_ACCT_NO,BLDG_SOC_ROLL_NO,WAS_DEFERRED,ID_CHECKED,POSTPONE,WELSH,PAID_CASH,TRAVEL_TIME,SCAN_CODE,FINANCIAL_LOSS,POLICE_CHECK,LAST_UPDATE,READ_ONLY,SUMMONS_FILE,REMINDER_SENT,PHOENIX_DATE,PHOENIX_CHECKED,M_PHONE,H_EMAIL,CONTACT_PREFERENCE,NOTIFICATIONS,SERVICE_COMP_COMMS_STATUS,TRANSFER_DATE)"
					+ "values ('400'," + jurorPartNo + ",'" + poolNo + "','857',null,'LNAME','FNAME',null,'1 STREET NAME','ANYTOWN',null,'London',null,null,'NN1 3HQ',null,null,null,null,null,null,'R',to_date(CURRENT_DATE+50,'DD-MON-RR'),null,'N',null,null,null,null,null,null,null,null,1,null,null,'Y',null,null,null,null,'0067',null,'CRO','" + court + "',to_date(CURRENT_DATE+50,'DD-MON-RR'),'N',null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,to_date(CURRENT_DATE-30,'DD-MON-RR'),'Y',null,null,null,null,null,null,null,0,null,CURRENT_DATE-20)");
			pStmt.execute();

			pStmt = conn.prepareStatement("Insert into juror.pool (OWNER,PART_NO,POOL_NO,POLL_NUMBER,TITLE,LNAME,FNAME,DOB,ADDRESS,ADDRESS2,ADDRESS3,ADDRESS4,ADDRESS5,ADDRESS6,ZIP,H_PHONE,W_PHONE,W_PH_LOCAL,TIMES_SEL,TRIAL_NO,JUROR_NO,REG_SPC,RET_DATE,DEF_DATE,RESPONDED,DATE_EXCUS,EXC_CODE,ACC_EXC,DATE_DISQ,DISQ_CODE,MILEAGE,LOCATION,USER_EDTQ,STATUS,NOTES,NO_ATTENDANCES,IS_ACTIVE,NO_DEF_POS,NO_ATTENDED,NO_FTA,NO_AWOL,POOL_SEQ,EDIT_TAG,POOL_TYPE,LOC_CODE,NEXT_DATE,ON_CALL,PERM_DISQUAL,PAY_COUNTY_EMP,PAY_EXPENSES,SPEC_NEED,SPEC_NEED_MSG,SMART_CARD,AMT_SPENT,COMPLETION_FLAG,COMPLETION_DATE,SORT_CODE,BANK_ACCT_NAME,BANK_ACCT_NO,BLDG_SOC_ROLL_NO,WAS_DEFERRED,ID_CHECKED,POSTPONE,WELSH,PAID_CASH,TRAVEL_TIME,SCAN_CODE,FINANCIAL_LOSS,POLICE_CHECK,LAST_UPDATE,READ_ONLY,SUMMONS_FILE,REMINDER_SENT,PHOENIX_DATE,PHOENIX_CHECKED,M_PHONE,H_EMAIL,CONTACT_PREFERENCE,NOTIFICATIONS,SERVICE_COMP_COMMS_STATUS,TRANSFER_DATE)"
					+ "values ('" + court + "'," + jurorPartNo + ",'" + poolNo + "','857',null,'LNAME','FNAME',null,'1 STREET NAME','ANYTOWN',null,'London',null,null,'NN1 3HQ',null,null,null,null,null,null,'R',to_date(CURRENT_DATE+50,'DD-MON-RR'),to_date('" + expectedDate + "','DD-MON-RR'),'Y',to_date(CURRENT_DATE,'DD-MON-RR'),'A',null,null,null,null,null,null,7,null,null,'Y',1,null,null,null,'0067',null,'CRO','" + court + "',null,'N',null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,to_date(CURRENT_DATE-30,'DD-MON-RR'),'N',null,null,null,null,null,null,null,0,null,null)");
			pStmt.execute();

			pStmt = conn.prepareStatement("INSERT INTO JUROR.DEFER_DBF(OWNER, PART_NO, DEFER_TO, CHECKED, LOC_CODE)"
					+ "VALUES ('" + court + "','" + jurorPartNo + "',to_date('" + expectedDate + "','DD-MON-RR'),'N','" + court + "')");

			pStmt.execute();

		} catch (SQLException e) {
			e.printStackTrace();
			log.error("Message:inserted new pool" + e.getMessage());
		} finally {
			conn.commit();
			pStmt.close();
			conn.close();
		}
	}

	public void insertNewPoolTransferredToCourt(String court) throws SQLException {
		db = new DBConnection();

		String env_property = System.getProperty("env.database");

		if (env_property != null)
			conn = db.getConnection(env_property);
		else
			conn = db.getConnection("demo");

		try {
			pStmt = conn.prepareStatement("INSERT INTO JUROR.UNIQUE_POOL (OWNER,POOL_NO,JURISDICTION_CODE,RETURN_DATE,NEXT_DATE,NO_REQUESTED,POOL_TOTAL,REG_SPC,POOL_TYPE,LOC_CODE,NEW_REQUEST,LAST_UPDATE,READ_ONLY,DEFERRALS_USED,ADDITIONAL_SUMMONS,ATTEND_TIME)"
					+ "VALUES ('" + court + "','" + court + "333333',null,(SELECT CURRENT_DATE FROM DUAL),(SELECT CURRENT_DATE FROM DUAL),10,10,'R','CRO','" + court + "','N',(SELECT CURRENT_DATE FROM DUAL),'N',null,null,(SELECT CURRENT_DATE FROM DUAL))");
			pStmt.execute();

//			#insert the pool rows
//			#bureau row
			pStmt = conn.prepareStatement("INSERT INTO JUROR.POOL (part_no, fname, lname, h_email, title, dob, address, address2, address3, address4, zip, h_phone, w_phone, is_active, owner, loc_code, m_phone, responded, poll_number, pool_no, on_call, completion_flag, read_only, contact_preference, reg_spc, ret_date, status, transfer_date)"
					+ "VALUES ('6" + court + "33333', 'Edward', 'Palmer', 'email-one@email.com', 'Mr', TO_DATE('1976-07-18 00:00:01', 'YYYY-MM-DD HH24:MI:SS'), '1 Test Street', 'Scotland', 'Strathaven', 'United Kingdom', 'ML106AD', '44135101-1110', '44135201-1110', 'Y', '400', '" + court + "', '44776-301-1110', 'N', 1000,'" + court + "333333', 'N', 'N', 'Y', 0, 'N', (SELECT CURRENT_DATE FROM DUAL), 1, (SELECT CURRENT_DATE FROM DUAL))");
			pStmt.execute();

//			#court row
			pStmt = conn.prepareStatement("INSERT INTO JUROR.POOL (part_no, fname, lname, h_email, title, dob, address, address2, address3, address4, zip, h_phone, w_phone, is_active, owner, loc_code, m_phone, responded, poll_number, pool_no, on_call, completion_flag, read_only, contact_preference, reg_spc, ret_date, status)"
					+ "VALUES ('6" + court + "33333', 'Edward', 'Palmer', 'email-one@email.com', 'Mr', TO_DATE('1976-07-18 00:00:01', 'YYYY-MM-DD HH24:MI:SS'), '1 Test Street', 'Scotland', 'Strathaven', 'United Kingdom', 'ML106AD', '44135101-1110', '44135201-1110', 'Y', '" + court + "', '" + court + "', '44776-301-1110', 'N', 1000,'" + court + "333333', 'N', 'N', 'N', 0, 'N', (SELECT CURRENT_DATE FROM DUAL), 1)");
			pStmt.execute();

		} catch (SQLException e) {
			e.printStackTrace();
			log.error("Message:inserted new pool" + e.getMessage());
		} finally {
			conn.commit();
			pStmt.close();
			conn.close();
		}
	}

	public void insertNewPoolTransferredToCourtNew(String court, String partNumber, String poolNumber) throws SQLException {
		db = new DBConnection();

		String env_property = System.getProperty("env.database");

		if (env_property != null)
			conn = db.getConnection(env_property);
		else
			conn = db.getConnection("demo");

		try {
//			#insert the pool rows
//			#bureau row
			pStmt = conn.prepareStatement("UPDATE JUROR.POOL SET TRANSFER_DATE = CURRENT_DATE-1, IS_ACTIVE='N', RESPONDED='Y', READ_ONLY='Y' WHERE PART_NO = '" + partNumber + "' AND OWNER = '400'");
			pStmt.execute();

//			#court row
			pStmt = conn.prepareStatement("INSERT INTO JUROR.POOL (part_no, fname, lname, h_email, title, dob, address, address2, address3, address4, zip, h_phone, w_phone, is_active, owner, loc_code, m_phone, responded, poll_number, pool_no, on_call, completion_flag, read_only, contact_preference, reg_spc, ret_date, status)"
					+ "VALUES ('" + partNumber + "', 'Edward', 'Palmer', 'email-one@email.com', 'Mr', TO_DATE('1976-07-18 00:00:01', 'YYYY-MM-DD HH24:MI:SS'), '1 Test Street', 'Scotland', 'Strathaven', 'United Kingdom', 'ML106AD', '44135101-1110', '44135201-1110', 'Y', '" + court + "', '" + court + "', '44776-301-1110', 'N', 1000,'" + poolNumber + "', 'N', 'N', 'N', 0, 'N', CURRENT_DATE, 1)");
			pStmt.execute();

		} catch (SQLException e) {
			e.printStackTrace();
			log.error("Message:inserted new pool" + e.getMessage());
		} finally {
			conn.commit();
			pStmt.close();
			conn.close();
		}
	}

	public void insertNewPoolRecord(String court, String newPartNo) throws SQLException {
		db = new DBConnection();

		String env_property = System.getProperty("env.database");

		if (env_property != null)
			conn = db.getConnection(env_property);
		else
			conn = db.getConnection("demo");

		try {

//			#insert the pool rows
			pStmt = conn.prepareStatement("INSERT INTO JUROR.POOL (part_no, fname, lname, h_email, title, dob, address, address2, address3, address4, zip, h_phone, w_phone, is_active, owner, loc_code, m_phone, responded, poll_number, pool_no, on_call, completion_flag, read_only, contact_preference, reg_spc, ret_date, status)"
					+ "VALUES ('" + newPartNo + "', 'Fname', 'Lname', 'email-one@email.com', 'Mr', TO_DATE('1976-07-18 00:00:01', 'YYYY-MM-DD HH24:MI:SS'), '1 Test Street', 'Scotland', 'Strathaven', 'United Kingdom', 'ML106AD', '44135101-1110', '44135201-1110', 'Y', '400', '" + court + "', '44776-301-1110', 'N', 1000,'" + court + "222222', 'N', 'N', 'N', 0, 'N', (SELECT CURRENT_DATE FROM DUAL), 1)");
			pStmt.execute();


		} catch (SQLException e) {
			e.printStackTrace();
			log.error("Message:inserted new pool" + e.getMessage());
		} finally {
			conn.commit();
			pStmt.close();
			conn.close();
		}
	}

	public void insertNewPool(String court) throws SQLException {
		db = new DBConnection();

		String env_property = System.getProperty("env.database");

		if (env_property != null)
			conn = db.getConnection(env_property);
		else
			conn = db.getConnection("demo");

		try {
			pStmt = conn.prepareStatement("INSERT INTO JUROR.UNIQUE_POOL (OWNER,POOL_NO,JURISDICTION_CODE,RETURN_DATE,NEXT_DATE,NO_REQUESTED,POOL_TOTAL,REG_SPC,POOL_TYPE,LOC_CODE,NEW_REQUEST,LAST_UPDATE,READ_ONLY,DEFERRALS_USED,ADDITIONAL_SUMMONS,ATTEND_TIME)"
					+ "VALUES ('" + court + "','" + court + "222222',null,(SELECT CURRENT_DATE FROM DUAL),(SELECT CURRENT_DATE FROM DUAL),10,10,'R','CRO','" + court + "','N',(SELECT CURRENT_DATE FROM DUAL),'N',null,null,(SELECT CURRENT_DATE FROM DUAL))");
			pStmt.execute();

//			#insert the pool rows
			pStmt = conn.prepareStatement("INSERT INTO JUROR.POOL (part_no, fname, lname, h_email, title, dob, address, address2, address3, address4, zip, h_phone, w_phone, is_active, owner, loc_code, m_phone, responded, poll_number, pool_no, on_call, completion_flag, read_only, contact_preference, reg_spc, ret_date, status)"
					+ "VALUES ('6" + court + "22222', 'Fname', 'Lname', 'email-one@email.com', 'Mr', TO_DATE('1976-07-18 00:00:01', 'YYYY-MM-DD HH24:MI:SS'), '1 Test Street', 'Scotland', 'Strathaven', 'United Kingdom', 'ML106AD', '44135101-1110', '44135201-1110', 'Y', '400', '" + court + "', '44776-301-1110', 'N', 1000,'" + court + "222222', 'N', 'N', 'N', 0, 'N', (SELECT CURRENT_DATE FROM DUAL), 1)");
			pStmt.execute();

		} catch (SQLException e) {
			e.printStackTrace();
			log.error("Message:inserted new pool" + e.getMessage());
		} finally {
			conn.commit();
			pStmt.close();
			conn.close();
		}
	}

	public void insertNewJurorIntoPool(String court, String jurorNumber, String poolNumber) throws SQLException {
		db = new DBConnection();

		String env_property = System.getProperty("env.database");

		if (env_property != null)
			conn = db.getConnection(env_property);
		else
			conn = db.getConnection("demo");

		try {

//			#insert the pool rows
			pStmt = conn.prepareStatement("INSERT INTO JUROR.POOL (part_no, fname, lname, h_email, title, dob, address, address2, address3, address4, zip, h_phone, w_phone, is_active, owner, loc_code, m_phone, responded, poll_number, pool_no, on_call, completion_flag, read_only, contact_preference, reg_spc, ret_date, status)"
					+ "VALUES ('" + jurorNumber + "', 'Fname', 'Lname', 'email-one@email.com', 'Mr', TO_DATE('1976-07-18 00:00:01', 'YYYY-MM-DD HH24:MI:SS'), '1 Test Street', 'Scotland', 'Strathaven', 'United Kingdom', 'ML106AD', '44135101-1110', '44135201-1110', 'Y', '400', '" + court + "', '44776-301-1110', 'N', 1000,'" + poolNumber + "', 'N', 'N', 'N', 0, 'N', (SELECT CURRENT_DATE FROM DUAL), 1)");
			pStmt.execute();

		} catch (SQLException e) {
			e.printStackTrace();
			log.error("Message:inserted new juror into pool " + poolNumber + " " + e.getMessage());
		} finally {
			conn.commit();
			pStmt.close();
			conn.close();
		}
	}

	public void insertNewJurorIntoPoolValidForDigitalReply(String court, String jurorNumber, String poolNumber) throws SQLException {
		db = new DBConnection();

		String env_property = System.getProperty("env.database");

		if (env_property != null)
			conn = db.getConnection(env_property);
		else
			conn = db.getConnection("demo");

		try {


//			#insert the pool rows
			pStmt = conn.prepareStatement("INSERT INTO JUROR.POOL (part_no, fname, lname, h_email, title, dob, address, address2, address3, address4, zip, h_phone, w_phone, is_active, owner, loc_code, m_phone, responded, poll_number, pool_no, on_call, completion_flag, read_only, contact_preference, reg_spc, ret_date, status, next_date)"
					+ "VALUES ('" + jurorNumber + "', 'Fname', 'Lname', 'email-one@email.com', 'Mr', TO_DATE('1976-07-18 00:00:01', 'YYYY-MM-DD HH24:MI:SS'), '1 Test Street', 'Scotland', 'Strathaven', 'United Kingdom', 'ML106AD', '44135101-1110', '44135201-1110', 'Y', '400', '" + court + "', '44776-301-1110', 'N', 1000,'" + poolNumber + "', 'N', 'N', 'N', 0, 'N', CURRENT_DATE+60, 1, TRUNC(CURRENT_DATE + (8 - TO_NUMBER(TO_CHAR(CURRENT_DATE, 'D'))) + 56))");
			pStmt.execute();

		} catch (SQLException e) {
			e.printStackTrace();
			log.error("Message:inserted new juror into pool " + poolNumber + " " + e.getMessage());
		} finally {
			conn.commit();
			pStmt.close();
			conn.close();
		}
	}

	public void insertNewJurorIntoPoolWithOwnerSameAsCourt(String court, String jurorNumber, String poolNumber) throws SQLException {
		db = new DBConnection();

		String env_property = System.getProperty("env.database");

		if (env_property != null)
			conn = db.getConnection(env_property);
		else
			conn = db.getConnection("demo");

		try {


//			#insert the pool rows
			pStmt = conn.prepareStatement("INSERT INTO JUROR.POOL (part_no, fname, lname, h_email, title, dob, address, address2, address3, address4, zip, h_phone, w_phone, is_active, owner, loc_code, m_phone, responded, poll_number, pool_no, on_call, completion_flag, read_only, contact_preference, reg_spc, ret_date, status, next_date)"
					+ "VALUES ('" + jurorNumber + "', 'Fname', 'Lname', 'email-one@email.com', 'Mr', TO_DATE('1976-07-18 00:00:01', 'YYYY-MM-DD HH24:MI:SS'), '1 Test Street', 'Scotland', 'Strathaven', 'United Kingdom', 'ML106AD', '44135101-1110', '44135201-1110', 'Y', '" + court + "', '" + court + "', '44776-301-1110', 'N', 1000,'" + poolNumber + "', 'N', 'N', 'N', 0, 'N', CURRENT_DATE+60, 1, TRUNC(CURRENT_DATE + (8 - TO_NUMBER(TO_CHAR(CURRENT_DATE, 'D'))) + 56))");
			pStmt.execute();

		} catch (SQLException e) {
			e.printStackTrace();
			log.error("Message:inserted new juror into pool " + poolNumber + " " + e.getMessage());
		} finally {
			conn.commit();
			pStmt.close();
			conn.close();
		}
	}

	public void insertNewPoolRequestLetter(String court) throws SQLException {
		db = new DBConnection();

		String env_property = System.getProperty("env.database");

		if (env_property != null)
			conn = db.getConnection(env_property);
		else
			conn = db.getConnection("demo");

		try {
			pStmt = conn.prepareStatement("INSERT INTO JUROR.UNIQUE_POOL (OWNER,POOL_NO,JURISDICTION_CODE,RETURN_DATE,NEXT_DATE,NO_REQUESTED,POOL_TOTAL,REG_SPC,POOL_TYPE,LOC_CODE,NEW_REQUEST,LAST_UPDATE,READ_ONLY,DEFERRALS_USED,ADDITIONAL_SUMMONS,ATTEND_TIME)"
					+ "VALUES ('" + court + "','" + court + "999999',null,(SELECT CURRENT_DATE FROM DUAL),(SELECT CURRENT_DATE FROM DUAL),10,10,'R','CRO','" + court + "','N',(SELECT CURRENT_DATE FROM DUAL),'N',null,null,(SELECT CURRENT_DATE FROM DUAL))");
			pStmt.execute();

//			#insert the pool rows
			pStmt = conn.prepareStatement("INSERT INTO JUROR.POOL (part_no, fname, lname, h_email, title, dob, address, address2, address3, address4, zip, h_phone, w_phone, is_active, owner, loc_code, m_phone, responded, poll_number, pool_no, on_call, completion_flag, read_only, contact_preference, reg_spc, ret_date, status)"
					+ "VALUES ('6" + court + "99999', 'Edward', 'Palmer', 'email-one@email.com', 'Mr', TO_DATE('1976-07-18 00:00:01', 'YYYY-MM-DD HH24:MI:SS'), '1 Test Street', 'Scotland', 'Strathaven', 'United Kingdom', 'ML106AD', '44135101-1110', '44135201-1110', 'Y', '400', '" + court + "', '44776-301-1110', 'N', 1000,'" + court + "222222', 'N', 'N', 'N', 0, 'N', (SELECT CURRENT_DATE FROM DUAL), 1)");
			pStmt.execute();

		} catch (SQLException e) {
			e.printStackTrace();
			log.error("Message:inserted new pool" + e.getMessage());
		} finally {
			conn.commit();
			pStmt.close();
			conn.close();
		}
	}

	public void insertNewPaperSummonsReply(String newJurorRecordNumber, String poolNo) throws SQLException {
		insertNewPaperSummonsReplyWithResponseName(newJurorRecordNumber, "Andy", "Marshall", poolNo);
	}

	public void insertNewPaperSummonsReplyWithResponseName(String newJurorRecordNumber, String firstName, String lastName, String poolNo) throws SQLException {
		db = new DBConnection();

		String env_property = System.getProperty("env.database");

		if (env_property != null)
			conn = db.getConnection(env_property);
		else
			conn = db.getConnection("demo");

		try {
			// Insert the Juror into JUROR.POOL
			pStmt = conn.prepareStatement("INSERT INTO JUROR.POOL (part_no, fname, lname, h_email, title, dob, address, address2, address3, address4, address5, zip, h_phone, w_phone, is_active, owner, loc_code, m_phone, responded, poll_number, pool_no, on_call, completion_flag, read_only, contact_preference, reg_spc, ret_date, status)"
					+ "VALUES ('" + newJurorRecordNumber + "', 'Andy', 'Marshall', 'pauline74@kingyslmail.top', 'Mr', TIMESTAMP'1981-12-23 00:00:00.0', '7 Poppy Square', 'New Theo', '', '', '', 'W1 1AB', '+44(0)949194874', '00713 952962', 'Y', '400', '415', '0123456789', 'N', 0, " + poolNo + ", 'N', 'N', 'N', 0, 'N', TIMESTAMP'2024-01-01 00:00:00.0', 1)");
			pStmt.execute();
			// Insert the Response into JUROR_DIGITAL.PAPER_RESPONSE
			pStmt = conn.prepareStatement("INSERT INTO JUROR_DIGITAL.PAPER_RESPONSE (JUROR_NUMBER, DATE_RECEIVED, TITLE, FIRST_NAME, LAST_NAME, ADDRESS, ADDRESS2, ADDRESS3, ADDRESS4, ADDRESS5, ZIP, PROCESSING_STATUS, DATE_OF_BIRTH, PHONE_NUMBER, ALT_PHONE_NUMBER, EMAIL, RESIDENCY, MENTAL_HEALTH_ACT, MENTAL_HEALTH_CAPACITY, BAIL, CONVICTIONS, DEFERRAL, EXCUSAL, SIGNED, WELSH)"
					+ "VALUES ('" + newJurorRecordNumber + "', TIMESTAMP'2023-05-05 17:21:10.3','Mr','" + firstName + "','" + lastName + "','7 Poppy Square','New Theo','','','','W1 1AB','TODO',TIMESTAMP'1981-12-23 00:00:00.0','+44(0)949194874','00713 952962','pauline74@kingyslmail.top','Y','N','N','N','N','N','N','Y','N')");
			pStmt.execute();

		} catch (SQLException e) {
			e.printStackTrace();
			log.error("Message:inserted new juror into Juror.Pool and new paper response into Juror_Digital.Paper_Response" + e.getMessage());
		} finally {
			conn.commit();
			pStmt.close();
			conn.close();
		}
	}

	public void insertReasonableAdjustments(String jurorRecordNumber) throws SQLException {
		db = new DBConnection();

		String env_property = System.getProperty("env.database");

		if (env_property != null)
			conn = db.getConnection(env_property);
		else
			conn = db.getConnection("demo");

		try {
			// Insert the Juror into JUROR.POOL
			pStmt = conn.prepareStatement("INSERT INTO JUROR_DIGITAL.PAPER_RESPONSE_SPECIAL_NEEDS (juror_number, spec_need, spec_need_detail, ID)"
					+ "VALUES ('" + jurorRecordNumber + "', 'L', 'Limited mobility', 125)");
			pStmt.execute();


		} catch (SQLException e) {
			e.printStackTrace();
			log.error("Message:inserting special needs into JUROR_DIGITAL.PAPER_RESPONSE_SPECIAL_NEED" + e.getMessage());
		} finally {
			conn.commit();
			pStmt.close();
			conn.close();
		}
	}

	public void insertCJSStatus(String jurorRecordNumber) throws SQLException {
		db = new DBConnection();

		String env_property = System.getProperty("env.database");

		if (env_property != null)
			conn = db.getConnection(env_property);
		else
			conn = db.getConnection("demo");

		try {
			// Insert the Juror into JUROR.POOL
			pStmt = conn.prepareStatement("INSERT INTO JUROR_DIGITAL.PAPER_RESPONSE_CJS_EMPLOYMENT (juror_number, cjs_employer, cjs_employer_details, ID)"
					+ "VALUES ('" + jurorRecordNumber + "', 'HMCTS', 'CJS Employment notes', 125)");
			pStmt.execute();


		} catch (SQLException e) {
			e.printStackTrace();
			log.error("Message:inserting special needs into JUROR_DIGITAL.PAPER_RESPONSE_SPECIAL_NEED" + e.getMessage());
		} finally {
			conn.commit();
			pStmt.close();
			conn.close();
		}
	}

	public void insertNewSummonsReply(String newJurorRecordNumber) throws SQLException {
		db = new DBConnection();

		String env_property = System.getProperty("env.database");

		if (env_property != null)
			conn = db.getConnection(env_property);
		else
			conn = db.getConnection("demo");

		try {
			// Insert the Juror into JUROR.POOL
			pStmt = conn.prepareStatement("INSERT INTO JUROR.POOL (part_no, fname, lname, h_email, title, dob, address, address2, address3, address4, zip, h_phone, w_phone, is_active, owner, loc_code, m_phone, responded, poll_number, pool_no, on_call, completion_flag, read_only, contact_preference, reg_spc, ret_date, status)"
					+ "VALUES ('" + newJurorRecordNumber + "', 'Fname', 'Lname', 'Milne0@email.com', 'Rev', TO_DATE('1976-07-18 00:00:01', 'YYYY-MM-DD HH24:MI:SS'), '1 Test Street', 'Scotland', 'Strathaven', 'United Kingdom', 'ML106AD', '44135101-1110', '44135201-1110', 'Y', '400', '415', '44776-301-1110', 'N', 0, 415230501, 'N', 'N', 'N', 0, 'N', (SELECT CURRENT_DATE FROM DUAL), 1)");
			pStmt.execute();
			// Insert the Response into JUROR_DIGITAL.JUROR_RESPONSE
			pStmt = conn.prepareStatement("INSERT INTO JUROR_DIGITAL.JUROR_RESPONSE (JUROR_NUMBER,DATE_RECEIVED,TITLE,FIRST_NAME,LAST_NAME,ADDRESS,ADDRESS2,ADDRESS3,ADDRESS4,ADDRESS5,ADDRESS6,ZIP,PROCESSING_STATUS,DATE_OF_BIRTH,PHONE_NUMBER,ALT_PHONE_NUMBER,EMAIL,THIRDPARTY_REASON,RESIDENCY,RESIDENCY_DETAIL,MENTAL_HEALTH_ACT,MENTAL_HEALTH_ACT_DETAILS,BAIL,BAIL_DETAILS,CONVICTIONS,CONVICTIONS_DETAILS,DEFERRAL_REASON,DEFERRAL_DATE,SPECIAL_NEEDS_ARRANGEMENTS,EXCUSAL_REASON, VERSION, JUROR_PHONE_DETAILS, JUROR_EMAIL_DETAILS, URGENT, SUPER_URGENT)"
					+ "VALUES ('" + newJurorRecordNumber + "',(SELECT CURRENT_DATE - interval '0' minute FROM DUAL),'Rev','Fname','Lname','1 Test Street','Scotland','Strathaven','United Kingdom',null,null,'ML106AD','TODO',null,null,null,null,null,'0',null,'0',null,'0',null,'0',null,null,null,null,null,555,'Y', 'Y', 'N', 'N')");
			pStmt.execute();

		} catch (SQLException e) {
			e.printStackTrace();
			log.error("Message:inserted new juror into Juror.Pool and new paper response into Juror_Digital.Juror_Response" + e.getMessage());
		} finally {
			conn.commit();
			pStmt.close();
			conn.close();
		}
	}

	public void insertNewSummonsReplyExcusal(String newJurorRecordNumber, String excusalReason) throws SQLException {
		db = new DBConnection();

		String env_property = System.getProperty("env.database");

		if (env_property != null)
			conn = db.getConnection(env_property);
		else
			conn = db.getConnection("demo");

		try {

			pStmt = conn.prepareStatement("INSERT INTO JUROR.POOL (part_no, fname, lname, h_email, title, dob, address, address2, address3, address4, zip, h_phone, w_phone, is_active, owner, loc_code, m_phone, responded, poll_number, pool_no, on_call, completion_flag, read_only, contact_preference, reg_spc, ret_date, status)"
					+ "VALUES ('" + newJurorRecordNumber + "', 'Eleanor', 'Milne', 'Milne0@email.com', 'Rev', TO_DATE('1976-07-18 00:00:01', 'YYYY-MM-DD HH24:MI:SS'), '1 Test Street', 'Scotland', 'Strathaven', 'United Kingdom', 'ML106AD', '44135101-1110', '44135201-1110', 'Y', '400', '415', '44776-301-1110', 'N', 0, 415230501, 'N', 'N', 'N', 0, 'N', (SELECT CURRENT_DATE FROM DUAL), 1)");
			pStmt.execute();

			// Insert the Response into JUROR_DIGITAL.JUROR_RESPONSE
			pStmt = conn.prepareStatement("INSERT INTO JUROR_DIGITAL.JUROR_RESPONSE (JUROR_NUMBER, DATE_RECEIVED, TITLE, FIRST_NAME, LAST_NAME, ADDRESS, ADDRESS2, ADDRESS3, ADDRESS4, ADDRESS5, ADDRESS6, ZIP, PROCESSING_STATUS, DATE_OF_BIRTH, PHONE_NUMBER, ALT_PHONE_NUMBER, EMAIL, RESIDENCY, RESIDENCY_DETAIL, MENTAL_HEALTH_ACT, MENTAL_HEALTH_ACT_DETAILS, BAIL, BAIL_DETAILS, CONVICTIONS, CONVICTIONS_DETAILS, DEFERRAL_REASON, DEFERRAL_DATE, SPECIAL_NEEDS_ARRANGEMENTS, EXCUSAL_REASON, PROCESSING_COMPLETE, VERSION, THIRDPARTY_FNAME, THIRDPARTY_LNAME, RELATIONSHIP, MAIN_PHONE, OTHER_PHONE, EMAIL_ADDRESS, THIRDPARTY_REASON, THIRDPARTY_OTHER_REASON, JUROR_PHONE_DETAILS, JUROR_EMAIL_DETAILS, STAFF_LOGIN, STAFF_ASSIGNMENT_DATE, URGENT, SUPER_URGENT, COMPLETED_AT, WELSH)"
					+ "VALUES ('" + newJurorRecordNumber + "',(SELECT CURRENT_DATE - interval '0' minute FROM DUAL),'Rev', 'Eleanor', 'Milne', '1 Test Street', 'Scotland', 'Strathaven', 'United Kingdom', NULL, NULL, 'ML106AD', 'TODO', TIMESTAMP '1981-12-23 00:00:00.000000', '44135101-1110', '44135201-1110', 'test@test.com', 'Y', NULL, 'N', NULL, 'N', NULL, 'N', NULL, NULL, NULL, NULL, '" + excusalReason + "', '', 555, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Y', 'Y', NULL, NULL, 'N', 'N', NULL, 'N')");
			pStmt.execute();

		} catch (SQLException e) {
			e.printStackTrace();
			log.error("Message:inserted new juror into Juror.Pool and new paper response into Juror_Digital.Juror_Response" + e.getMessage());
		} finally {
			conn.commit();
			pStmt.close();
			conn.close();
		}
	}

	public void deleteNewPaperSummonsReply(String createdJurorRecordNumber) throws SQLException {
		db = new DBConnection();

		String env_property = System.getProperty("env.database");

		if (env_property != null)
			conn = db.getConnection(env_property);
		else
			conn = db.getConnection("demo");

		try {
			//Delete the specified Juror from Juror.Pool
			pStmt = conn.prepareStatement("DELETE FROM JUROR.POOL WHERE PART_NO = '" + createdJurorRecordNumber + "'");
			pStmt.execute();

			//Delete the specified paper response from Juror_Digital.Paper_Response
			pStmt = conn.prepareStatement("DELETE FROM JUROR_DIGITAL.PAPER_RESPONSE WHERE JUROR_NUMBER = '" + createdJurorRecordNumber + "'");
			pStmt.execute();

		} catch (SQLException e) {
			e.printStackTrace();
			log.error("Message:deleted new juror.pool and juror_digital.paper_response records with the part_no and juror_number of " + createdJurorRecordNumber + " respectively - " + e.getMessage());
		} finally {
			conn.commit();
			pStmt.close();
			conn.close();
		}
	}

	public void deleteTestPoolAndJurors(String poolRequestNumber) throws SQLException {
		db = new DBConnection();

		String env_property = System.getProperty("env.database");

		if (env_property != null)
			conn = db.getConnection(env_property);
		else
			conn = db.getConnection("demo");

		try {
			//Delete the specified Juror from Juror.UNIQUE_POOL
			pStmt = conn.prepareStatement("DELETE FROM JUROR.UNIQUE_POOL WHERE POOL_NO = '" + poolRequestNumber + "'");
			pStmt.execute();

			//Delete the specified Juror from Juror.POOL
			pStmt = conn.prepareStatement("DELETE FROM JUROR.POOL WHERE POOL_NO = '" + poolRequestNumber + "'");
			pStmt.execute();

			//Delete the pool history from Juror.POOL_HIST
			pStmt = conn.prepareStatement("DELETE FROM JUROR.POOL_HIST WHERE POOL_NO = '" + poolRequestNumber + "'");
			pStmt.execute();

		} catch (SQLException e) {
			e.printStackTrace();
			log.error("Message:deleted new juror.unique_pool, juror.pool and juror.pool_hist records with the pool_no " + poolRequestNumber + " respectively - " + e.getMessage());
		} finally {
			conn.commit();
			pStmt.close();
			conn.close();
		}
	}

	public void deleteNewSummonsReply(String createdJurorRecordNumber) throws SQLException {
		db = new DBConnection();

		String env_property = System.getProperty("env.database");

		if (env_property != null)
			conn = db.getConnection(env_property);
		else
			conn = db.getConnection("demo");

		try {
			//Delete the specified Juror from Juror.Pool
			pStmt = conn.prepareStatement("DELETE FROM JUROR.POOL WHERE PART_NO = '" + createdJurorRecordNumber + "'");
			pStmt.execute();

			//Delete the specified paper response from Juror_Digital.Paper_Response
			pStmt = conn.prepareStatement("DELETE FROM JUROR_DIGITAL.JUROR_RESPONSE WHERE JUROR_NUMBER = '" + createdJurorRecordNumber + "'");
			pStmt.execute();

		} catch (SQLException e) {
			e.printStackTrace();
			log.error("Message:deleted new juror.pool and juror_digital.Juror_response records with the part_no and juror_number of " + createdJurorRecordNumber + " respectively - " + e.getMessage());
		} finally {
			conn.commit();
			pStmt.close();
			conn.close();
		}
	}

	public void insertHolidayInTheFuture(Integer noOfWeeks, String owner) throws SQLException {
		db = new DBConnection();

		String env_property = System.getProperty("env.database");

		if (env_property != null)
			conn = db.getConnection(env_property);
		else
			conn = db.getConnection("demo");

		String datePattern = "dd MMM yyyy";
		Calendar calendar = Calendar.getInstance();
		calendar.add(Calendar.WEEK_OF_MONTH, noOfWeeks);

		LocalDate localDate = calendar.toInstant().atZone(ZoneId.systemDefault()).toLocalDate();
		Date mondayDate = Date.from(localDate.atStartOfDay().atZone(ZoneId.systemDefault()).toInstant());

		holidayDate = new SimpleDateFormat(datePattern).format((mondayDate).getTime());
		holidayOwner = owner;

		try {

			pStmt = conn.prepareStatement("INSERT INTO JUROR.HOLIDAYS(OWNER,HOLIDAY,DESCRIPTION)"
					+ "VALUES ('" + owner + "','" + holidayDate + "','Test holiday')");
			pStmt.execute();

		} catch (SQLException e) {
			e.printStackTrace();
			log.error("Message:inserted bank holiday for '" + owner + "' on '" + holidayDate + "' " + e.getMessage());
		} finally {
			conn.commit();
			pStmt.close();
			conn.close();
		}
	}

	public void insertHolidayMondayInTheFuture(Integer noOfWeeks, String owner) throws SQLException {
		db = new DBConnection();

		String env_property = System.getProperty("env.database");

		if (env_property != null)
			conn = db.getConnection(env_property);
		else
			conn = db.getConnection("demo");

		String datePattern = "dd MMM yyyy";
		Calendar calendar = Calendar.getInstance();
		calendar.add(Calendar.WEEK_OF_MONTH, noOfWeeks);

		LocalDate localDate = calendar.toInstant().atZone(ZoneId.systemDefault()).toLocalDate();
		LocalDate localDateMonday = localDate.with(TemporalAdjusters.next(DayOfWeek.MONDAY));
		Date mondayDate = Date.from(localDateMonday.atStartOfDay().atZone(ZoneId.systemDefault()).toInstant());

		holidayDate = new SimpleDateFormat(datePattern).format((mondayDate).getTime());
		holidayOwner = owner;

		try {

			pStmt = conn.prepareStatement("INSERT INTO JUROR.HOLIDAYS(OWNER,HOLIDAY,DESCRIPTION)"
					+ "VALUES ('" + owner + "','" + holidayDate + "','Test holiday')");
			pStmt.execute();

		} catch (SQLException e) {
			e.printStackTrace();
			log.error("Message:inserted bank holiday for '" + owner + "' on '" + holidayDate + "' " + e.getMessage());
		} finally {
			conn.commit();
			pStmt.close();
			conn.close();
		}
	}

	public void clean_pool_requests() throws SQLException {
		db = new DBConnection();

		String env_property = System.getProperty("env.database");

		if (env_property != null)
			conn = db.getConnection(env_property);
		else
			conn = db.getConnection("demo");

		try {

			pStmt = conn.prepareStatement("DELETE FROM JUROR.UNIQUE_POOL WHERE LAST_UPDATE <CURRENT_DATE AND POOL_NO NOT IN (SELECT POOL_NO FROM JUROR.POOL)");
			pStmt.execute();

		} catch (SQLException e) {
			e.printStackTrace();
			log.error("Message:deleted new unique_pool records with no associated pool records with creation date <today" + e.getMessage());
		} finally {
			conn.commit();
			pStmt.close();
			conn.close();
		}
	}

	public void clean_coroners_pool_requests() throws SQLException {
		db = new DBConnection();

		String env_property = System.getProperty("env.database");

		if (env_property != null)
			conn = db.getConnection(env_property);
		else
			conn = db.getConnection("demo");

		try {

			pStmt = conn.prepareStatement("DELETE FROM JUROR.CORONER_POOL_DETAIL WHERE COR_POOL_NO IN (SELECT COR_POOL_NO FROM JUROR.CORONER_POOL WHERE COR_REQUEST_DT <CURRENT_DATE)");
			pStmt.execute();

			pStmt = conn.prepareStatement("DELETE FROM JUROR.CORONER_POOL WHERE COR_REQUEST_DT < trunc(CURRENT_DATE)");
			pStmt.execute();

		} catch (SQLException e) {
			e.printStackTrace();
			log.error("Message:deleted new coroner_pool_detail and coroner_pool records with requested on date <today" + e.getMessage());
		} finally {
			conn.commit();
			pStmt.close();
			conn.close();
		}
	}

	public void deleteHoliday() throws SQLException {
		db = new DBConnection();

		String env_property = System.getProperty("env.database");

		if (env_property != null)
			conn = db.getConnection(env_property);
		else
			conn = db.getConnection("demo");

		try {

			pStmt = conn.prepareStatement("DELETE FROM JUROR_MOD.HOLIDAY WHERE OWNER='" + holidayOwner + "' AND HOLIDAY='" + holidayDate + "'");
			pStmt.execute();

		} catch (SQLException e) {
			e.printStackTrace();
			log.error("Message:deleted bank holiday for '" + holidayOwner + "' on '" + holidayDate + "' " + e.getMessage());
		} finally {
			conn.commit();
			pStmt.close();
			conn.close();
		}
	}

	public void deleteAllHolidays() throws SQLException {
		db = new DBConnection();

		String env_property = System.getProperty("env.database");

		if (env_property != null)
			conn = db.getConnection(env_property);
		else
			conn = db.getConnection("demo");

		try {

			pStmt = conn.prepareStatement("DELETE FROM JUROR.HOLIDAYS");
			pStmt.execute();


		} catch (SQLException e) {
			e.printStackTrace();
			log.error("Message:deleted all bank holidays" + e.getMessage());
		} finally {
			conn.commit();
			pStmt.close();
			conn.close();
		}
	}

	public void clean_modernisation_data() throws SQLException {
		db = new DBConnection();
		String env_property = System.getProperty("env.database");
		if (env_property != null)
			conn = db.getConnection(env_property);
		else
			conn = db.getConnection("demo");
		try {
			pStmt = conn.prepareStatement("DELETE FROM JUROR_DIGITAL.STAFF WHERE LOGIN IN ('MODTESTBUREAU','MODTESTCOURT','MODCOURT', 'MODBUREAUOFFICER')");
			pStmt.execute();
			log.info("Deleted FROM JUROR_DIGITAL.STAFF WHERE LOGIN IN ('MODTESTBUREAU','MODTESTCOURT','MODCOURT', 'MODBUREAUOFFICER')");

			pStmt = conn.prepareStatement("DELETE FROM JUROR.PASSWORD WHERE LOGIN IN ('MODTESTCOURT','MODTESTBUREAU','MODCOURT', 'MODBUREAUOFFICER')");
			pStmt.execute();
			log.info("Deleted FROM JUROR_DIGITAL_USER.PASSWORD WHERE LOGIN IN ('MODTESTCOURT','MODTESTBUREAU','MODCOURT', 'MODBUREAUOFFICER')");

		} catch (SQLException e) {
			e.printStackTrace();
			log.error("Message:" + e.getMessage());
		} finally {
			conn.commit();
			pStmt.close();
			conn.close();
		}

	}

	public void cleanNewActivePools(String poolNumbersIN) throws SQLException {
		db = new DBConnection();
		String env_property = System.getProperty("env.database");
		if (env_property != null)
			conn = db.getConnection(env_property);
		else
			conn = db.getConnection("demo");
		try {
			pStmt = conn.prepareStatement("DELETE FROM JUROR.POOL WHERE POOL_NO IN " + poolNumbersIN);
			pStmt.execute();
			conn.commit();
			log.info("DELETED FROM JUROR.POOL WHERE POOL_NO IN " + poolNumbersIN);

			pStmt = conn.prepareStatement("DELETE FROM JUROR.UNIQUE_POOL WHERE POOL_NO IN " + poolNumbersIN);
			pStmt.execute();
			conn.commit();
			log.info("DELETED FROM JUROR.UNIQUE_POOL WHERE POOL_NO IN " + poolNumbersIN);

		} catch (SQLException e) {
			e.printStackTrace();
			log.error("Message:" + e.getMessage());
		} finally {
			conn.commit();
			pStmt.close();
			conn.close();
		}
	}

	public void insert_modernisation_data() throws SQLException {
		db = new DBConnection();
		String env_property = System.getProperty("env.database");
		if (env_property != null)
			conn = db.getConnection(env_property);
		else
			conn = db.getConnection("demo");
		try {

			// USERS TABLE
			pStmt = conn.prepareStatement("INSERT INTO juror_mod.users (owner, user_type, username, email, name, active, version) "
 					+ "VALUES "
 					+ "('400', 'BUREAU', 'MODTESTBUREAU', 'MODTESTBUREAU@email.gov.uk', 'MODTESTBUREAU', true, 1), "
					+ "('415', 'COURT', 'MODTESTCOURT', 'MODTESTCOURT@email.gov.uk', 'MODTESTCOURT', true, 1), "
					+ "('400', 'SYSTEM', 'AUTO', 'AUTO@email.gov.uk', 'AUTO', true, 1), "
					+ "('400', 'BUREAU', 'TeamPickListUser', 'TeamPickListUser@email.gov.uk', 'TeamPickListUser', true, 1), "
 					+ "('400', 'BUREAU', 'AutomationStaffTWO', 'AutomationStaffTWO@email.gov.uk', 'AutomationStaffTWO', true, 1), "
 					+ "('400', 'SYSTEM', 'SYSTEM', 'SYSTEM@email.gov.uk', 'SYSTEM', true, 1), "
 					+ "('416', 'COURT', 'SJOUSER1', 'SJOUSER1@email.gov.uk', 'SJOUSER1', true, 1), "
 					+ "('400', 'BUREAU', 'CPASS', 'CPASS@email.gov.uk', 'CPASS', true, 1), "
 					+ "('400', 'BUREAU', 'NEWUSER', 'NEWUSER@email.gov.uk', 'NEWUSER', true, 1), "
 					+ "('400', 'BUREAU', 'ARAMIS1', 'ARAMIS1@email.gov.uk', 'ARAMIS1', true, 1), "
 					+ "('415', 'COURT', 'MODCOURT', 'MODCOURT@email.gov.uk', 'MODCOURT', true, 1); ");
			pStmt.execute();
			conn.commit();

			// USER_ROLES TABLE
			pStmt = conn.prepareStatement("INSERT INTO juror_mod.user_roles (username, role) "
					+ "VALUES "
					+ "('MODTESTBUREAU', 'TEAM_LEADER'), "
					+ "('SJOUSER1', 'SENIOR_JUROR_OFFICER')");
			pStmt.execute();
			conn.commit();

			// USER_COURTS TABLE
			pStmt = conn.prepareStatement("INSERT INTO juror_mod.user_courts (username, loc_code) "
					+ "VALUES "
					+ "('MODTESTBUREAU', '400'), "
					+ "('MODTESTCOURT', '415'), "
					+ "('MODCOURT', '415'), "
					+ "('MODCOURT', '769'), "
					+ "('MODCOURT', '416'), "
					+ "('AUTO', '400'), "
					+ "('TeamPickListUser', '400'), "
					+ "('AutomationStaffTWO', '400'), "
					+ "('SYSTEM', '400'), "
					+ "('SJOUSER1', '416'), "
					+ "('CPASS', '400'), "
					+ "('ARAMIS1', '400'), "
					+ "('NEWUSER', '400');");
			pStmt.execute();
			conn.commit();
			log.info("INSERTED INTO JUROR_MOD.USERS");

		} catch (SQLException e) {
			e.printStackTrace();
			log.error("Message:" + e.getMessage());
		} finally {
			conn.commit();
			pStmt.close();
			conn.close();
		}

	}

	public void runLaunchDarklyHack() throws SQLException {
		db = new DBConnection();
		String env_property = System.getProperty("env.database");
		if (env_property != null)
			conn = db.getConnection(env_property);
		else
			conn = db.getConnection("demo");
		try {
			pStmt = conn.prepareStatement("CREATE OR REPLACE FORCE VIEW JUROR_DIGITAL_USER.PASSWORD (OWNER, LOGIN, PASSWORD, LAST_USED, USER_LEVEL, ARAMIS_AUTH_CODE, ARAMIS_MAX_AUTH, PASSWORD_CHANGED_DATE, LOGIN_ENABLED_YN) AS"
					+ " SELECT"
					+ " p.owner,"
					+ " p.login,"
					+ " p.password,"
					+ " p.last_used,"
					+ " p.user_level,"
					+ " p.aramis_auth_code,"
					+ " p.aramis_max_auth,"
					+ " p.password_changed_date,"
					+ " p.login_enabled_yn"
					+ " FROM JUROR.PASSWORD p"
					+ " WHERE p.owner = '400' OR p.LOGIN in ('MODTESTCOURT', 'MODTESTBUREAU', 'MODCOURT', 'MODBUREAUOFFICER')");
			pStmt.execute();
			log.info("ran launch darkly hack");
		} catch (SQLException e) {
			e.printStackTrace();
			log.error("Message:" + e.getMessage());
			log.info(11);
		} finally {
			conn.commit();
			pStmt.close();
			conn.close();
		}
	}

	public void refreshVotersTable(String court) throws SQLException {
		db = new DBConnection();
		String env_property = System.getProperty("env.database");
		if (env_property != null)
			conn = db.getConnection(env_property);
		else
			conn = db.getConnection("demo");
		try {

//			//clear down JUROR_DIGITAL.VOTERS for selected court where part_no starts "1"
//			pStmt = conn.prepareStatement("delete from JUROR_DIGITAL.VOTERS where loc_code='" + court + "' and part_no like '1%'");

			//delete associated records for part_nos like "1" or "2" for selected court
			pStmt = conn.prepareStatement("delete from JUROR.POOL_HIST where pool_no in (select pool_no from juror.pool where part_no like '1%' or part_no like '2%')");
			pStmt.execute();
			conn.commit();

			pStmt = conn.prepareStatement("delete from JUROR.POOL_STATS where pool_no in (select pool_no from juror.pool where part_no like '1%' or part_no like '2%')");
			pStmt.execute();

//			pStmt = conn.prepareStatement("delete from JUROR.UNIQUE_POOL where pool_no in (select pool_no from juror.pool where part_no like '1%' or part_no like '2%')");
//	pStmt.executeUpdate();

			pStmt = conn.prepareStatement("delete from JUROR.POOL_COMMENTS where pool_no in (select pool_no from juror.pool where part_no like '1%' or part_no like '2%')");
			pStmt.execute();

			pStmt = conn.prepareStatement("delete from JUROR.POOL_DETAILS where part_no like '1" + court + "%' or part_no like '2" + court + "%'");
			pStmt.execute();

			pStmt = conn.prepareStatement("delete from JUROR.POOL where loc_code='" + court + "' and part_no like '1%' or part_no like '2%'");
			pStmt.execute();

			pStmt = conn.prepareStatement("delete from JUROR.PART_HIST where part_no like '1" + court + "%' or part_no like '2%'");
			pStmt.execute();

//			conn.commit();
//
//			//populate voters
//			pStmt = conn.prepareStatement("update JUROR.VOTERS" + court + " set part_no = '1'||substr(part_no,2,8) where part_no like '6%'");
//			pStmt.execute();
//			pStmt = conn.prepareStatement("insert into JUROR_DIGITAL.VOTERS SELECT '" + court + "' as LOC_CODE, PART_NO, REGISTER_LETT, POLL_NUMBER, NEW_MARKER, TITLE, LNAME, FNAME, DOB, FLAGS, ADDRESS, ADDRESS2, ADDRESS3, ADDRESS4, ADDRESS5, ADDRESS6, ZIP, DATE_SELECTED1, DATE_SELECTED2, DATE_SELECTED3, REC_NUM, PERM_DISQUAL, SOURCE_ID FROM JUROR.VOTERS" + court + " where part_no like '1%'");
//			pStmt.execute();
//
			//update VOTERS set date_selected null for court where part_no begins "1"
			pStmt = conn.prepareStatement("update JUROR_DIGITAL.VOTERS set date_selected1=null where loc_code='" + court + "' and part_no like '1%' or part_no like '2%'");
			pStmt.execute();

			conn.commit();


			log.info("refreshed voters for court '" + court + "'");
		} catch (SQLException e) {
			e.printStackTrace();
			log.error("Message:" + e.getMessage());
			log.info(11);
		} finally {
			conn.commit();
			pStmt.close();
			conn.close();
		}
	}

	public void clean_pools_created_yesterday() throws SQLException {
		db = new DBConnection();
		String env_property = System.getProperty("env.database");
		if (env_property != null)
			conn = db.getConnection(env_property);
		else
			conn = db.getConnection("demo");
		try {
			pStmt = conn.prepareStatement("delete from juror.pool where pool_no in  (select pool_no from juror.pool_hist where history_code='PHSI' and trunc(date_part) in (trunc(CURRENT_DATE), trunc(CURRENT_DATE-1), trunc(CURRENT_DATE-2), trunc(CURRENT_DATE-3)))");
			pStmt.execute();

			pStmt = conn.prepareStatement("delete from juror.unique_pool where pool_no in  (select pool_no from juror.pool_hist where history_code='PHSI' and trunc(date_part) in (trunc(CURRENT_DATE), trunc(CURRENT_DATE-1), trunc(CURRENT_DATE-2), trunc(CURRENT_DATE-3)))");
			pStmt.execute();

			pStmt = conn.prepareStatement("delete from juror.pool_hist where pool_no in  (select pool_no from juror.pool_hist where history_code='PHSI' and trunc(date_part) in (trunc(CURRENT_DATE), trunc(CURRENT_DATE-1), trunc(CURRENT_DATE-2), trunc(CURRENT_DATE-3)))");
			pStmt.execute();

			log.info("deleted pools created today, 1 day ago, 2 days ago and 3 days ago");
		} catch (SQLException e) {
			e.printStackTrace();
			log.error("Message:" + e.getMessage());
			log.info(11);
		} finally {
			conn.commit();
			pStmt.close();
			conn.close();
		}
	}

	public void updateVotersPostcode(String court, String postcode) throws SQLException {
		db = new DBConnection();
		String env_property = System.getProperty("env.database");
		if (env_property != null)
			conn = db.getConnection(env_property);
		else
			conn = db.getConnection("demo");
		try {
			pStmt = conn.prepareStatement("update JUROR_DIGITAL.VOTERS set zip='" + postcode + "' where loc_code='" + court + "' and poll_number <'250'");
			pStmt.execute();

			log.info("updated 250 voters postcodes to '" + postcode + "' for court '" + court + "'");
		} catch (SQLException e) {
			e.printStackTrace();
			log.error("Message:" + e.getMessage());
			log.info(11);
		} finally {
			conn.commit();
			pStmt.close();
			conn.close();
		}
	}

	public void pcqEnabled() throws SQLException {
		db = new DBConnection();
		String env_property = System.getProperty("env.database");
		String pcq_return_value;
		if (env_property != null) {
			conn = db.getConnection(env_property);
			pcq_return_value = ReadProperties.main("pcqreturnurl_" + env_property.toLowerCase());

		} else {
			conn = db.getConnection("demo");
			pcq_return_value = ReadProperties.main("pcqreturnurl_demo");
		}
		try {
			pStmt = conn.prepareStatement("update juror_digital.app_settings set value='TRUE' where setting = 'PCQ_SERVICE_ENABLED'");
//              pStmt = conn.prepareStatement("Insert into JUROR_DIGITAL.APP_SETTINGS (SETTING,VALUE) values ('PCQ_SERVICE_RETURN_URL','http://172.117.3.70:3000/steps/confirm-information')");
			pStmt.execute();

			pStmt = conn.prepareStatement("update juror_digital.app_settings set value='https://pcq.aat.platform.hmcts.net' where setting = 'PCQ_SERVICE_URL'");
			pStmt.execute();

			pStmt = conn.prepareStatement("update juror_digital.app_settings set value=? where setting = 'PCQ_SERVICE_RETURN_URL'");
			pStmt.setString(1, pcq_return_value);
			pStmt.execute();

			log.info("Updated app_settings to enable PCQ with return url " + pcq_return_value);
		} catch (SQLException e) {
			e.printStackTrace();
			log.error("Message:" + e.getMessage());
			log.info(11);
		} finally {
			conn.commit();
			pStmt.close();
			conn.close();
		}
	}

	public void pcqDisabled() throws SQLException {
		db = new DBConnection();
		String env_property = System.getProperty("env.database");
		if (env_property != null)
			conn = db.getConnection(env_property);
		else
			conn = db.getConnection("demo");
		try {
			pStmt = conn.prepareStatement("update juror_digital.app_settings set value='FALSE' where setting = 'PCQ_SERVICE_ENABLED'");
			pStmt.execute();
			log.info("Updated app_settings to disable PCQ");
		} catch (SQLException e) {
			e.printStackTrace();
			log.error("Message:" + e.getMessage());
			log.info(11);
		} finally {
			conn.commit();
			pStmt.close();
			conn.close();
		}
	}

	public int getCountFromUniquePool(String pool_no) throws SQLException {
		db = new DBConnection();
		String env_property = System.getProperty("env.database");
		conn = db.getConnection(env_property);
		try {
			pStmt = conn.prepareStatement("select count(*) from juror.unique_pool where pool_no='" + pool_no + "'");
			ResultSet rs = pStmt.executeQuery();
			rs.next();
			log.info("Got count of rows in unique pool with this pool_no");
			return rs.getInt(1);
		} catch (SQLException e) {
			e.printStackTrace();
			log.error("Message:" + e.getMessage());
			log.info(11);

		}
		return 0;
	}

	public int getCountFromPool(String part_no, String pool_no) throws SQLException {
		db = new DBConnection();
		String env_property = System.getProperty("env.database");
		conn = db.getConnection(env_property);
		try {
			pStmt = conn.prepareStatement("select count(*) from juror.pool where owner='400' and part_no='" + part_no + "' and pool_no='" + pool_no + "'");
			ResultSet rs = pStmt.executeQuery();
			rs.next();
			log.info("Got count of rows in pool with this part_no, pool_no and owner 400");
			return rs.getInt(1);
		} catch (SQLException e) {
			e.printStackTrace();
			log.error("Message:" + e.getMessage());
			log.info(11);

		}
		return 0;
	}

	public int getCoronerPoolNoNSD() throws SQLException {
		db = new DBConnection();
		String env_property = System.getProperty("env.database");
		conn = db.getConnection(env_property);
		try {
			pStmt = conn.prepareStatement("select MAX(cor_pool_no) from JUROR_MOD.coroner_pool");
			ResultSet rs = pStmt.executeQuery();
			rs.next();
			log.info("Got last coroner court pool number");
			return rs.getInt(1) + 1;
		} catch (SQLException e) {
			e.printStackTrace();
			log.error("Message:" + e.getMessage());
			log.info(11);
		} finally {
			pStmt.close();
			conn.close();

		}
		return 0;
	}

	public int getNewSpecNeedId() throws SQLException {
		db = new DBConnection();
		String env_property = System.getProperty("env.database");
		conn = db.getConnection(env_property);
		try {
			pStmt = conn.prepareStatement("select MAX(ID) from juror_digital.juror_response_special_needs");
			ResultSet rs = pStmt.executeQuery();
			rs.next();
			log.info("Got last special needs ID");
			return rs.getInt(1) + 1;
		} catch (SQLException e) {
			e.printStackTrace();
			log.error("Message:" + e.getMessage());
			log.info(11);
		} finally {
			pStmt.close();
		}
		return 0;
	}

	public int getMaxVotersPlus1() throws SQLException {
		db = new DBConnection();
		String env_property = System.getProperty("env.database");
		conn = db.getConnection(env_property);
		try {
			pStmt = conn.prepareStatement("select MAX(cor_pool_no) from JUROR.coroner_pool");
			ResultSet rs = pStmt.executeQuery();
			rs.next();
			log.info("Got last coroner court pool number");
			return rs.getInt(1) + 1;
		} catch (SQLException e) {
			e.printStackTrace();
			log.error("Message:" + e.getMessage());
			log.info(11);
		} finally {
			pStmt.close();
			conn.close();

		}
		return 0;
	}

	public void resetVoters(String courtCode) throws SQLException {
		db = new DBConnection();
		String env_property = System.getProperty("env.database");
		if (env_property != null)
			conn = db.getConnection(env_property);
		else
			conn = db.getConnection("demo");
		try {
			pStmt = conn.prepareStatement("update JUROR_DIGITAL.VOTERS set date_selected1 = null where loc_code= '" + courtCode + "' and part_no not in (select part_no from juror.pool)");
			pStmt.execute();
			log.info("Updated juror_digital.voters to set '" + courtCode + "' rows to unselected");
		} catch (SQLException e) {
			e.printStackTrace();
			log.error("Message:" + e.getMessage());
			log.info(11);
		} finally {
			conn.commit();
			pStmt.close();
			conn.close();
		}
	}

	public void insertMultipleNewPoolsWithDeferral(String court, int noOfPools, String owner, String noWeeks) throws SQLException {
		db = new DBConnection();

		String env_property = System.getProperty("env.database");

		if (env_property != null)
			conn = db.getConnection(env_property);
		else
			conn = db.getConnection("demo");

		try {

			String datePattern = "dd MMMMM yyyy";
			Calendar calendar = Calendar.getInstance();
			calendar.add(Calendar.WEEK_OF_MONTH, Integer.parseInt(noWeeks));

			LocalDate localDate = calendar.toInstant().atZone(ZoneId.systemDefault()).toLocalDate();
			LocalDate localDateMonday = localDate.with(TemporalAdjusters.next(DayOfWeek.MONDAY));
			Date mondayDate = Date.from(localDateMonday.atStartOfDay().atZone(ZoneId.systemDefault()).toInstant());

			String expectedDate = new SimpleDateFormat(datePattern).format((mondayDate).getTime());

			pStmt = conn.prepareStatement("DELETE FROM JUROR.UNIQUE_POOL WHERE POOL_NO=  '" + court + "111111'");
			pStmt.execute();

			pStmt = conn.prepareStatement("INSERT INTO JUROR.UNIQUE_POOL (OWNER, POOL_NO, RETURN_DATE, NEXT_DATE, NO_REQUESTED, POOL_TOTAL, REG_SPC, POOL_TYPE, LOC_CODE, NEW_REQUEST, LAST_UPDATE, READ_ONLY) VALUES" +
					"('415', '" + court + "111111', to_date('" + expectedDate + "','DD-MON-RR'), to_date('" + expectedDate + "','DD-MON-RR'), 4, 0, 'R', 'CRO', '" + court + "', 'T', TIMESTAMP'2022-03-02 09:22:09.0', 'Y')");
			pStmt.execute();

			pStmt = conn.prepareStatement("INSERT INTO JUROR.UNIQUE_POOL (OWNER, POOL_NO, RETURN_DATE, NEXT_DATE, NO_REQUESTED, POOL_TOTAL, REG_SPC, POOL_TYPE, LOC_CODE, NEW_REQUEST, LAST_UPDATE, READ_ONLY) VALUES" +
					"('400', '" + court + "111111',  to_date('" + expectedDate + "','DD-MON-RR'), to_date('" + expectedDate + "','DD-MON-RR'), 4, 0, 'R', 'CRO', '" + court + "', 'N', TIMESTAMP'2022-03-02 09:22:09.0', 'N')");
			pStmt.execute();

			for (int index = 0; index < noOfPools; index++) {

				pStmt = conn.prepareStatement("DELETE FROM JUROR.POOL WHERE PART_NO = '6" + court + "1111" + index + "'");
				pStmt.execute();

				pStmt = conn.prepareStatement("DELETE FROM JUROR.POOL WHERE PART_NO = '0" + court + "0000" + index + "'");
				pStmt.execute();

				pStmt = conn.prepareStatement("INSERT INTO JUROR.POOL" +
						"(OWNER, PART_NO, POOL_NO, POLL_NUMBER, LNAME, FNAME, DOB, ADDRESS, ADDRESS2, ZIP, REG_SPC, RET_DATE, DEF_DATE, RESPONDED, USER_EDTQ, STATUS, IS_ACTIVE, NO_DEF_POS, POOL_SEQ, POOL_TYPE, LOC_CODE, ON_CALL, READ_ONLY, NOTIFICATIONS)" +
						"VALUES('" + owner + "', '0" + court + "0000" + index + "', '" + court + "00000" + index + "', '540', 'TESTNAME', '0FNAME" + index + "', TIMESTAMP'1990-07-25 00:00:00.0', '540 STREET NAME', 'ANYTOWN', 'CH1 2AN', 'R', TIMESTAMP'2023-06-26 00:00:00.000000', TIMESTAMP'2023-06-12 00:00:00.000000', 'Y', 'BUREAU_USER_1', 7, 'Y', 1, '0109', 'CRO', '415', 'N', 'N', 0)");
				pStmt.execute();

				pStmt = conn.prepareStatement("DELETE FROM JUROR.DEFER_DBF WHERE PART_NO = '6" + court + "1111" + index + "'");
				pStmt.execute();

				pStmt = conn.prepareStatement("DELETE FROM JUROR.DEFER_DBF WHERE PART_NO = '0" + court + "0000" + index + "'");
				pStmt.execute();

				pStmt = conn.prepareStatement("INSERT INTO JUROR.DEFER_DBF(OWNER, PART_NO, DEFER_TO, CHECKED, LOC_CODE)"
						+ "VALUES ('" + owner + "','0" + court + "0000" + index + "', to_date('" + expectedDate + "','DD-MON-RR'),'N','" + court + "')");
				pStmt.execute();

			}


		} catch (SQLException e) {
			e.printStackTrace();
			log.error("Message:inserted new pool" + e.getMessage());
		} finally {
			conn.commit();
			pStmt.close();
			conn.close();
		}

	}

	public void deleteReasonableAdjustment(String createdJurorRecordNumber) throws SQLException {
		db = new DBConnection();

		String env_property = System.getProperty("env.database");

		if (env_property != null)
			conn = db.getConnection(env_property);
		else
			conn = db.getConnection("demo");
		try {
			//Delete the specified Juror from JUROR_DIGITAL.JUROR_RESPONSE_SPECIAL_NEEDS
			pStmt = conn.prepareStatement("DELETE FROM JUROR_DIGITAL.JUROR_RESPONSE_SPECIAL_NEEDS WHERE JUROR_NUMBER = '" + createdJurorRecordNumber + "'");
			pStmt.execute();
			pStmt = conn.prepareStatement("DELETE FROM JUROR_DIGITAL.POOL_MEMBER_EXT WHERE PART_NO = '" + createdJurorRecordNumber + "'");
			pStmt.execute();

			//Delete the specified Juror from JUROR_DIGITAL.PAPER_RESPONSE_SPECIAL_NEEDS
			pStmt = conn.prepareStatement("DELETE FROM JUROR_DIGITAL.PAPER_RESPONSE_SPECIAL_NEEDS WHERE JUROR_NUMBER = '" + createdJurorRecordNumber + "'");
			pStmt.execute();
//			pStmt = conn.prepareStatement("DELETE FROM JUROR_DIGITAL.POOL_MEMBER_EXT WHERE PART_NO = '"+ createdJurorRecordNumber +"'");
//			pStmt.execute();

		} catch (SQLException e) {
			e.printStackTrace();
			log.error("Message:deleted new JUROR_DIGITAL.JUROR_RESPONSE_SPECIAL_NEEDS records with the juror_number of " + createdJurorRecordNumber + " respectively - " + e.getMessage());
		} finally {
			conn.commit();
			pStmt.close();
			conn.close();
		}
	}

	public void insertNewSummonsReplyReasonableAdjustment(String newJurorRecordNumber, String newJurorAdjustmentCode, String newJurorAdjustment) throws SQLException {
		db = new DBConnection();

		String env_property = System.getProperty("env.database");

		if (env_property != null)
			conn = db.getConnection(env_property);
		else
			conn = db.getConnection("demo");

		try {

			String newSpecNeedId = String.valueOf(getNewSpecNeedId());
			// Insert the Juror into JUROR.POOL
			pStmt = conn.prepareStatement("INSERT INTO JUROR.POOL (part_no, fname, lname, h_email, title, dob, address, address2, address3, address4, zip, h_phone, w_phone, is_active, owner, loc_code, m_phone, responded, poll_number, pool_no, on_call, completion_flag, read_only, contact_preference, reg_spc, ret_date, status)"
					+ "VALUES ('" + newJurorRecordNumber + "', 'Eleanor', 'Milne', 'Milne0@email.com', 'Rev', TO_DATE('1976-07-18 00:00:01', 'YYYY-MM-DD HH24:MI:SS'), '1 Test Street', 'Scotland', 'Strathaven', 'United Kingdom', 'ML106AD', '44135101-1110', '44135201-1110', 'Y', '400', '415', '44776-301-1110', 'N', 0, 415230501, 'N', 'N', 'N', 0, 'N', (SELECT CURRENT_DATE FROM DUAL), 1)");
			pStmt.execute();
			// Insert the Response into JUROR_DIGITAL.JUROR_RESPONSE
			pStmt = conn.prepareStatement("INSERT INTO JUROR_DIGITAL.JUROR_RESPONSE (JUROR_NUMBER,DATE_RECEIVED,TITLE,FIRST_NAME,LAST_NAME,ADDRESS,ADDRESS2,ADDRESS3,ADDRESS4,ADDRESS5,ADDRESS6,ZIP,PROCESSING_STATUS,DATE_OF_BIRTH,PHONE_NUMBER,ALT_PHONE_NUMBER,EMAIL,THIRDPARTY_REASON,RESIDENCY,RESIDENCY_DETAIL,MENTAL_HEALTH_ACT,MENTAL_HEALTH_ACT_DETAILS,BAIL,BAIL_DETAILS,CONVICTIONS,CONVICTIONS_DETAILS,DEFERRAL_REASON,DEFERRAL_DATE,SPECIAL_NEEDS_ARRANGEMENTS,EXCUSAL_REASON, VERSION, JUROR_PHONE_DETAILS, JUROR_EMAIL_DETAILS, URGENT, SUPER_URGENT)"
					+ "VALUES ('" + newJurorRecordNumber + "',(SELECT CURRENT_DATE - interval '0' minute FROM DUAL),'Rev','Eleanor','Milne','1 Test Street','Scotland','Strathaven','United Kingdom',null,null,'ML106AD','TODO',TO_DATE('1976-07-18 00:00:01', 'YYYY-MM-DD HH24:MI:SS'),'44135101-1110','44776-301-1110','Milne0@email.com',null,'N',null,'N',null,'N',null,'N',null,null,null,null,null,555,'Y', 'Y', 'N', 'N')");
			pStmt.execute();

			// Insert Reasonable adjustment in JUROR_DIGITAL.JUROR_RESPONSE_SPECIAL_NEEDS
			pStmt = conn.prepareStatement("INSERT INTO JUROR_DIGITAL.JUROR_RESPONSE_SPECIAL_NEEDS (JUROR_NUMBER, SPEC_NEED, SPEC_NEED_DETAIL, ID)"
					+ "VALUES ('" + newJurorRecordNumber + "', '" + newJurorAdjustmentCode + "', '" + newJurorAdjustment + "', '" + newSpecNeedId + "')");
			pStmt.execute();

		} catch (SQLException e) {
			e.printStackTrace();
			log.error("Message:inserted new juror into Juror.Pool, new paper response into Juror_Digital.Juror_Response, and new additional requirement into Juror_Digital.Juror_Response_Special_Needs" + e.getMessage());
		} finally {
			conn.commit();
			pStmt.close();
			conn.close();
		}

	}

	public void insertNewPaperSummonsReplyReasonableAdjustment(String newJurorRecordNumber, String newJurorAdjustmentCode, String newJurorAdjustment) throws SQLException {
		db = new DBConnection();

		String env_property = System.getProperty("env.database");

		if (env_property != null)
			conn = db.getConnection(env_property);
		else
			conn = db.getConnection("demo");

		try {
			String newSpecNeedId = String.valueOf(getNewSpecNeedId());
			// Insert the Juror into JUROR.POOL
			pStmt = conn.prepareStatement("INSERT INTO JUROR.POOL (part_no, fname, lname, h_email, title, dob, address, address2, address3, address4, zip, h_phone, w_phone, is_active, owner, loc_code, m_phone, responded, poll_number, pool_no, on_call, completion_flag, read_only, contact_preference, reg_spc, ret_date, status)"
					+ "VALUES ('" + newJurorRecordNumber + "', 'Eleanor', 'Milne', 'Milne0@email.com', 'Rev', TO_DATE('1976-07-18 00:00:01', 'YYYY-MM-DD HH24:MI:SS'), '1 Test Street', 'Scotland', 'Strathaven', 'United Kingdom', 'ML106AD', '44135101-1110', '44135201-1110', 'Y', '400', '415', '44776-301-1110', 'N', 0, 415230501, 'N', 'N', 'N', 0, 'N', (SELECT CURRENT_DATE FROM DUAL), 1)");
			pStmt.execute();

			// Insert the Response into JUROR_DIGITAL.PAPER_RESPONSE
			pStmt = conn.prepareStatement("INSERT INTO JUROR_DIGITAL.PAPER_RESPONSE (JUROR_NUMBER, DATE_RECEIVED, TITLE, FIRST_NAME, LAST_NAME, ADDRESS, ADDRESS2, ADDRESS3, ADDRESS4, ADDRESS5, ZIP, PROCESSING_STATUS, DATE_OF_BIRTH, PHONE_NUMBER, ALT_PHONE_NUMBER, EMAIL, RESIDENCY, MENTAL_HEALTH_ACT, MENTAL_HEALTH_CAPACITY, BAIL, CONVICTIONS, DEFERRAL, EXCUSAL, SIGNED, WELSH)"
					+ "VALUES ('" + newJurorRecordNumber + "',(SELECT CURRENT_DATE - interval '0' minute FROM DUAL),'Rev','Eleanor','Milne','1 Test Street','Scotland','Strathaven','United Kingdom','','W1 1AB','TODO',TO_DATE('1976-07-18 00:00:01', 'YYYY-MM-DD HH24:MI:SS'),'44135101-1110','44135101-1110','Milne0@email.com','Y','N','N','N','N','N','N','Y','N')");
			pStmt.execute();

			// Insert Reasonable adjustment in JUROR_DIGITAL.PAPER_RESPONSE_SPECIAL_NEEDS
			pStmt = conn.prepareStatement("INSERT INTO JUROR_DIGITAL.PAPER_RESPONSE_SPECIAL_NEEDS (JUROR_NUMBER, SPEC_NEED, SPEC_NEED_DETAIL, ID)"
					+ "VALUES ('" + newJurorRecordNumber + "', '" + newJurorAdjustmentCode + "', '" + newJurorAdjustment + "', '" + newSpecNeedId + "')");
			pStmt.execute();

		} catch (SQLException e) {
			e.printStackTrace();
			log.error("Message:inserted new juror into JUROR.POOL, new paper response into JUROR_DIGITAL.PAPER_RESPONSE, and new additional requirement into JUROR_DIGITAL.PAPER_RESPONSE_SPECIAL_NEEDS" + e.getMessage());
		} finally {
			conn.commit();
			pStmt.close();
			conn.close();
		}
	}

	public void insertNewActivePool(String court) throws SQLException {
		db = new DBConnection();

		String env_property = System.getProperty("env.database");

		if (env_property != null)
			conn = db.getConnection(env_property);
		else
			conn = db.getConnection("demo");

		try {

			pStmt = conn.prepareStatement("INSERT INTO JUROR.UNIQUE_POOL (OWNER,POOL_NO,JURISDICTION_CODE,RETURN_DATE,NEXT_DATE,NO_REQUESTED,POOL_TOTAL,REG_SPC,POOL_TYPE,LOC_CODE,NEW_REQUEST,LAST_UPDATE,READ_ONLY,DEFERRALS_USED,ADDITIONAL_SUMMONS,ATTEND_TIME) " +
					"VALUES ('" + court + "','" + court + "222222',NULL,(SELECT CURRENT_DATE FROM DUAL)+112,(SELECT CURRENT_DATE FROM DUAL)+112,5,0,'R','CRO','" + court + "','T',(SELECT CURRENT_DATE FROM DUAL)+112,'Y',NULL,NULL,(SELECT CURRENT_DATE FROM DUAL)+112)");
			pStmt.execute();

			pStmt = conn.prepareStatement("INSERT INTO JUROR.UNIQUE_POOL (OWNER,POOL_NO,JURISDICTION_CODE,RETURN_DATE,NEXT_DATE,NO_REQUESTED,POOL_TOTAL,REG_SPC,POOL_TYPE,LOC_CODE,NEW_REQUEST,LAST_UPDATE,READ_ONLY,DEFERRALS_USED,ADDITIONAL_SUMMONS,ATTEND_TIME) " +
					"VALUES ('400','" + court + "222222',NULL,(SELECT CURRENT_DATE FROM DUAL)+112,(SELECT CURRENT_DATE FROM DUAL)+112,5,0,'R','CRO','" + court + "','N',(SELECT CURRENT_DATE FROM DUAL)+112,'N',NULL,NULL,(SELECT CURRENT_DATE FROM DUAL)+112)");
			pStmt.execute();

			pStmt = conn.prepareStatement("INSERT INTO JUROR_DIGITAL.POOL_REQUEST_EXT (POOL_NO,TOTAL_NO_REQUIRED,LAST_UPDATE) " +
					"VALUES ('" + court + "222222',5,(SELECT CURRENT_DATE FROM DUAL))");
			pStmt.execute();

		} catch (SQLException e) {
			e.printStackTrace();
			log.error("Message:inserted new pool" + e.getMessage());
		} finally {
			conn.commit();
			pStmt.close();
			conn.close();
		}
	}

	public void insertJurorsIntoActivePool(String court) throws SQLException {
		db = new DBConnection();

		String env_property = System.getProperty("env.database");

		if (env_property != null)
			conn = db.getConnection(env_property);
		else
			conn = db.getConnection("demo");

		try {

			pStmt = conn.prepareStatement("INSERT INTO JUROR_DIGITAL.VOTERS (LOC_CODE,PART_NO,REGISTER_LETT,POLL_NUMBER,NEW_MARKER,TITLE,LNAME,FNAME,DOB,FLAGS,ADDRESS,ADDRESS2,ADDRESS3,ADDRESS4,ADDRESS5,ADDRESS6,ZIP,DATE_SELECTED1,DATE_SELECTED2,DATE_SELECTED3,REC_NUM,PERM_DISQUAL,SOURCE_ID)" +
					"VALUES ('" + court + "','9" + court + "99999','999','999',NULL,NULL,'LNAMEONE','FNAMEONE',NULL,NULL,'1 STREET NAME','ANYTOWN',NULL,NULL,NULL,NULL,'CH1 2AN',(SELECT CURRENT_DATE FROM DUAL),NULL,NULL,1,NULL,NULL)");
			pStmt.execute();

			pStmt = conn.prepareStatement("INSERT INTO JUROR_DIGITAL.VOTERS (LOC_CODE,PART_NO,REGISTER_LETT,POLL_NUMBER,NEW_MARKER,TITLE,LNAME,FNAME,DOB,FLAGS,ADDRESS,ADDRESS2,ADDRESS3,ADDRESS4,ADDRESS5,ADDRESS6,ZIP,DATE_SELECTED1,DATE_SELECTED2,DATE_SELECTED3,REC_NUM,PERM_DISQUAL,SOURCE_ID)" +
					"VALUES ('" + court + "','9" + court + "99998','998','998',NULL,NULL,'LNAMETWO','FNAMETWO',NULL,NULL,'2 STREET NAME','ANYTOWN',NULL,NULL,NULL,NULL,'CH1 2AN',(SELECT CURRENT_DATE FROM DUAL),NULL,NULL,1,NULL,NULL)");
			pStmt.execute();

			pStmt = conn.prepareStatement("INSERT INTO JUROR.POOL (OWNER,PART_NO,POOL_NO,POLL_NUMBER,TITLE,LNAME,FNAME,DOB,ADDRESS,ADDRESS2,ADDRESS3,ADDRESS4,ADDRESS5,ADDRESS6,ZIP,H_PHONE,W_PHONE,W_PH_LOCAL,TIMES_SEL,TRIAL_NO,JUROR_NO,REG_SPC,RET_DATE,DEF_DATE,RESPONDED,DATE_EXCUS,EXC_CODE,ACC_EXC,DATE_DISQ,DISQ_CODE,MILEAGE,LOCATION,USER_EDTQ,STATUS,NOTES,NO_ATTENDANCES,IS_ACTIVE,NO_DEF_POS,NO_ATTENDED,NO_FTA,NO_AWOL,POOL_SEQ,EDIT_TAG,POOL_TYPE,LOC_CODE,NEXT_DATE,ON_CALL,PERM_DISQUAL,PAY_COUNTY_EMP,PAY_EXPENSES,SPEC_NEED,SPEC_NEED_MSG,SMART_CARD,AMT_SPENT,COMPLETION_FLAG,COMPLETION_DATE,SORT_CODE,BANK_ACCT_NAME,BANK_ACCT_NO,BLDG_SOC_ROLL_NO,WAS_DEFERRED,ID_CHECKED,POSTPONE,WELSH,PAID_CASH,TRAVEL_TIME,SCAN_CODE,FINANCIAL_LOSS,POLICE_CHECK,LAST_UPDATE,READ_ONLY,SUMMONS_FILE,REMINDER_SENT,PHOENIX_DATE,PHOENIX_CHECKED,M_PHONE,H_EMAIL,CONTACT_PREFERENCE,NOTIFICATIONS,TRANSFER_DATE,SERVICE_COMP_COMMS_STATUS)" +
					"VALUES ('400','9" + court + "99999','" + court + "222222','99999',NULL,'LNAMEONE','FNAMEONE',NULL,'1 STREET NAME','ANYTOWN',NULL,NULL,NULL,NULL,'CH1 2AN',NULL,NULL,NULL,NULL,NULL,NULL,'R',(SELECT CURRENT_DATE FROM DUAL),(SELECT CURRENT_DATE FROM DUAL),'N',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,'Y',NULL,NULL,NULL,NULL,'0001',NULL,'CRO','" + court + "',(SELECT CURRENT_DATE FROM DUAL),NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,(SELECT CURRENT_DATE FROM DUAL),'N',NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL)");
			pStmt.execute();

			pStmt = conn.prepareStatement("INSERT INTO JUROR.POOL (OWNER,PART_NO,POOL_NO,POLL_NUMBER,TITLE,LNAME,FNAME,DOB,ADDRESS,ADDRESS2,ADDRESS3,ADDRESS4,ADDRESS5,ADDRESS6,ZIP,H_PHONE,W_PHONE,W_PH_LOCAL,TIMES_SEL,TRIAL_NO,JUROR_NO,REG_SPC,RET_DATE,DEF_DATE,RESPONDED,DATE_EXCUS,EXC_CODE,ACC_EXC,DATE_DISQ,DISQ_CODE,MILEAGE,LOCATION,USER_EDTQ,STATUS,NOTES,NO_ATTENDANCES,IS_ACTIVE,NO_DEF_POS,NO_ATTENDED,NO_FTA,NO_AWOL,POOL_SEQ,EDIT_TAG,POOL_TYPE,LOC_CODE,NEXT_DATE,ON_CALL,PERM_DISQUAL,PAY_COUNTY_EMP,PAY_EXPENSES,SPEC_NEED,SPEC_NEED_MSG,SMART_CARD,AMT_SPENT,COMPLETION_FLAG,COMPLETION_DATE,SORT_CODE,BANK_ACCT_NAME,BANK_ACCT_NO,BLDG_SOC_ROLL_NO,WAS_DEFERRED,ID_CHECKED,POSTPONE,WELSH,PAID_CASH,TRAVEL_TIME,SCAN_CODE,FINANCIAL_LOSS,POLICE_CHECK,LAST_UPDATE,READ_ONLY,SUMMONS_FILE,REMINDER_SENT,PHOENIX_DATE,PHOENIX_CHECKED,M_PHONE,H_EMAIL,CONTACT_PREFERENCE,NOTIFICATIONS,TRANSFER_DATE,SERVICE_COMP_COMMS_STATUS)" +
					"VALUES ('400','9" + court + "99998','" + court + "222222','99998',NULL,'LNAMETWO','FNAMETWO',NULL,'2 STREET NAME','ANYTOWN',NULL,NULL,NULL,NULL,'CH1 2AN',NULL,NULL,NULL,NULL,NULL,NULL,'R',(SELECT CURRENT_DATE FROM DUAL),(SELECT CURRENT_DATE FROM DUAL),'N',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,'Y',NULL,NULL,NULL,NULL,'0001',NULL,'CRO','" + court + "',(SELECT CURRENT_DATE FROM DUAL),NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,(SELECT CURRENT_DATE FROM DUAL),'N',NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL)");
			pStmt.execute();

		} catch (SQLException e) {
			e.printStackTrace();
			log.error("Message:inserted new pool" + e.getMessage());
		} finally {
			conn.commit();
			pStmt.close();
			conn.close();
		}
	}

	public void insertCourtOwnedJurorsIntoActivePool(String court) throws SQLException {
		db = new DBConnection();

		String env_property = System.getProperty("env.database");

		if (env_property != null)
			conn = db.getConnection(env_property);
		else
			conn = db.getConnection("demo");

		try {

			pStmt = conn.prepareStatement("INSERT INTO JUROR_DIGITAL.VOTERS (LOC_CODE,PART_NO,REGISTER_LETT,POLL_NUMBER,NEW_MARKER,TITLE,LNAME,FNAME,DOB,FLAGS,ADDRESS,ADDRESS2,ADDRESS3,ADDRESS4,ADDRESS5,ADDRESS6,ZIP,DATE_SELECTED1,DATE_SELECTED2,DATE_SELECTED3,REC_NUM,PERM_DISQUAL,SOURCE_ID)" +
					"VALUES ('" + court + "','9" + court + "99999','999','999',NULL,NULL,'LNAMEONE','FNAMEONE',NULL,NULL,'1 STREET NAME','ANYTOWN',NULL,NULL,NULL,NULL,'CH1 2AN',(SELECT CURRENT_DATE FROM DUAL),NULL,NULL,1,NULL,NULL)");
			pStmt.execute();

			pStmt = conn.prepareStatement("INSERT INTO JUROR_DIGITAL.VOTERS (LOC_CODE,PART_NO,REGISTER_LETT,POLL_NUMBER,NEW_MARKER,TITLE,LNAME,FNAME,DOB,FLAGS,ADDRESS,ADDRESS2,ADDRESS3,ADDRESS4,ADDRESS5,ADDRESS6,ZIP,DATE_SELECTED1,DATE_SELECTED2,DATE_SELECTED3,REC_NUM,PERM_DISQUAL,SOURCE_ID)" +
					"VALUES ('" + court + "','9" + court + "99998','998','998',NULL,NULL,'LNAMETWO','FNAMETWO',NULL,NULL,'2 STREET NAME','ANYTOWN',NULL,NULL,NULL,NULL,'CH1 2AN',(SELECT CURRENT_DATE FROM DUAL),NULL,NULL,1,NULL,NULL)");
			pStmt.execute();

			pStmt = conn.prepareStatement("INSERT INTO JUROR.POOL (OWNER,PART_NO,POOL_NO,POLL_NUMBER,TITLE,LNAME,FNAME,DOB,ADDRESS,ADDRESS2,ADDRESS3,ADDRESS4,ADDRESS5,ADDRESS6,ZIP,H_PHONE,W_PHONE,W_PH_LOCAL,TIMES_SEL,TRIAL_NO,JUROR_NO,REG_SPC,RET_DATE,DEF_DATE,RESPONDED,DATE_EXCUS,EXC_CODE,ACC_EXC,DATE_DISQ,DISQ_CODE,MILEAGE,LOCATION,USER_EDTQ,STATUS,NOTES,NO_ATTENDANCES,IS_ACTIVE,NO_DEF_POS,NO_ATTENDED,NO_FTA,NO_AWOL,POOL_SEQ,EDIT_TAG,POOL_TYPE,LOC_CODE,NEXT_DATE,ON_CALL,PERM_DISQUAL,PAY_COUNTY_EMP,PAY_EXPENSES,SPEC_NEED,SPEC_NEED_MSG,SMART_CARD,AMT_SPENT,COMPLETION_FLAG,COMPLETION_DATE,SORT_CODE,BANK_ACCT_NAME,BANK_ACCT_NO,BLDG_SOC_ROLL_NO,WAS_DEFERRED,ID_CHECKED,POSTPONE,WELSH,PAID_CASH,TRAVEL_TIME,SCAN_CODE,FINANCIAL_LOSS,POLICE_CHECK,LAST_UPDATE,READ_ONLY,SUMMONS_FILE,REMINDER_SENT,PHOENIX_DATE,PHOENIX_CHECKED,M_PHONE,H_EMAIL,CONTACT_PREFERENCE,NOTIFICATIONS,TRANSFER_DATE,SERVICE_COMP_COMMS_STATUS)" +
					"VALUES ('400','9" + court + "99999','" + court + "222222','99999',NULL,'LNAMEONE','FNAMEONE',NULL,'1 STREET NAME','ANYTOWN',NULL,NULL,NULL,NULL,'CH1 2AN',NULL,NULL,NULL,NULL,NULL,NULL,'R',(SELECT CURRENT_DATE FROM DUAL),(SELECT CURRENT_DATE FROM DUAL),'N',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,'Y',NULL,NULL,NULL,NULL,'0001',NULL,'CRO','" + court + "',(SELECT CURRENT_DATE FROM DUAL),NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,(SELECT CURRENT_DATE FROM DUAL),'Y',NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL)");
			pStmt.execute();

			pStmt = conn.prepareStatement("INSERT INTO JUROR.POOL (OWNER,PART_NO,POOL_NO,POLL_NUMBER,TITLE,LNAME,FNAME,DOB,ADDRESS,ADDRESS2,ADDRESS3,ADDRESS4,ADDRESS5,ADDRESS6,ZIP,H_PHONE,W_PHONE,W_PH_LOCAL,TIMES_SEL,TRIAL_NO,JUROR_NO,REG_SPC,RET_DATE,DEF_DATE,RESPONDED,DATE_EXCUS,EXC_CODE,ACC_EXC,DATE_DISQ,DISQ_CODE,MILEAGE,LOCATION,USER_EDTQ,STATUS,NOTES,NO_ATTENDANCES,IS_ACTIVE,NO_DEF_POS,NO_ATTENDED,NO_FTA,NO_AWOL,POOL_SEQ,EDIT_TAG,POOL_TYPE,LOC_CODE,NEXT_DATE,ON_CALL,PERM_DISQUAL,PAY_COUNTY_EMP,PAY_EXPENSES,SPEC_NEED,SPEC_NEED_MSG,SMART_CARD,AMT_SPENT,COMPLETION_FLAG,COMPLETION_DATE,SORT_CODE,BANK_ACCT_NAME,BANK_ACCT_NO,BLDG_SOC_ROLL_NO,WAS_DEFERRED,ID_CHECKED,POSTPONE,WELSH,PAID_CASH,TRAVEL_TIME,SCAN_CODE,FINANCIAL_LOSS,POLICE_CHECK,LAST_UPDATE,READ_ONLY,SUMMONS_FILE,REMINDER_SENT,PHOENIX_DATE,PHOENIX_CHECKED,M_PHONE,H_EMAIL,CONTACT_PREFERENCE,NOTIFICATIONS,TRANSFER_DATE,SERVICE_COMP_COMMS_STATUS)" +
					"VALUES ('400','9" + court + "99998','" + court + "222222','99998',NULL,'LNAMETWO','FNAMETWO',NULL,'2 STREET NAME','ANYTOWN',NULL,NULL,NULL,NULL,'CH1 2AN',NULL,NULL,NULL,NULL,NULL,NULL,'R',(SELECT CURRENT_DATE FROM DUAL),(SELECT CURRENT_DATE FROM DUAL),'N',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,'Y',NULL,NULL,NULL,NULL,'0001',NULL,'CRO','" + court + "',(SELECT CURRENT_DATE FROM DUAL),NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,(SELECT CURRENT_DATE FROM DUAL),'Y',NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL)");
			pStmt.execute();

			pStmt = conn.prepareStatement("INSERT INTO JUROR.POOL (OWNER,PART_NO,POOL_NO,POLL_NUMBER,TITLE,LNAME,FNAME,DOB,ADDRESS,ADDRESS2,ADDRESS3,ADDRESS4,ADDRESS5,ADDRESS6,ZIP,H_PHONE,W_PHONE,W_PH_LOCAL,TIMES_SEL,TRIAL_NO,JUROR_NO,REG_SPC,RET_DATE,DEF_DATE,RESPONDED,DATE_EXCUS,EXC_CODE,ACC_EXC,DATE_DISQ,DISQ_CODE,MILEAGE,LOCATION,USER_EDTQ,STATUS,NOTES,NO_ATTENDANCES,IS_ACTIVE,NO_DEF_POS,NO_ATTENDED,NO_FTA,NO_AWOL,POOL_SEQ,EDIT_TAG,POOL_TYPE,LOC_CODE,NEXT_DATE,ON_CALL,PERM_DISQUAL,PAY_COUNTY_EMP,PAY_EXPENSES,SPEC_NEED,SPEC_NEED_MSG,SMART_CARD,AMT_SPENT,COMPLETION_FLAG,COMPLETION_DATE,SORT_CODE,BANK_ACCT_NAME,BANK_ACCT_NO,BLDG_SOC_ROLL_NO,WAS_DEFERRED,ID_CHECKED,POSTPONE,WELSH,PAID_CASH,TRAVEL_TIME,SCAN_CODE,FINANCIAL_LOSS,POLICE_CHECK,LAST_UPDATE,READ_ONLY,SUMMONS_FILE,REMINDER_SENT,PHOENIX_DATE,PHOENIX_CHECKED,M_PHONE,H_EMAIL,CONTACT_PREFERENCE,NOTIFICATIONS,TRANSFER_DATE,SERVICE_COMP_COMMS_STATUS)" +
					"VALUES ('415','9" + court + "99999','" + court + "222222','99999',NULL,'LNAMEONE','FNAMEONE',NULL,'1 STREET NAME','ANYTOWN',NULL,NULL,NULL,NULL,'CH1 2AN',NULL,NULL,NULL,NULL,NULL,NULL,'R',(SELECT CURRENT_DATE FROM DUAL),(SELECT CURRENT_DATE FROM DUAL),'N',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,2,NULL,NULL,'Y',NULL,NULL,NULL,NULL,'0001',NULL,'CRO','" + court + "',(SELECT CURRENT_DATE FROM DUAL),NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,(SELECT CURRENT_DATE FROM DUAL),'N',NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL)");
			pStmt.execute();

			pStmt = conn.prepareStatement("INSERT INTO JUROR.POOL (OWNER,PART_NO,POOL_NO,POLL_NUMBER,TITLE,LNAME,FNAME,DOB,ADDRESS,ADDRESS2,ADDRESS3,ADDRESS4,ADDRESS5,ADDRESS6,ZIP,H_PHONE,W_PHONE,W_PH_LOCAL,TIMES_SEL,TRIAL_NO,JUROR_NO,REG_SPC,RET_DATE,DEF_DATE,RESPONDED,DATE_EXCUS,EXC_CODE,ACC_EXC,DATE_DISQ,DISQ_CODE,MILEAGE,LOCATION,USER_EDTQ,STATUS,NOTES,NO_ATTENDANCES,IS_ACTIVE,NO_DEF_POS,NO_ATTENDED,NO_FTA,NO_AWOL,POOL_SEQ,EDIT_TAG,POOL_TYPE,LOC_CODE,NEXT_DATE,ON_CALL,PERM_DISQUAL,PAY_COUNTY_EMP,PAY_EXPENSES,SPEC_NEED,SPEC_NEED_MSG,SMART_CARD,AMT_SPENT,COMPLETION_FLAG,COMPLETION_DATE,SORT_CODE,BANK_ACCT_NAME,BANK_ACCT_NO,BLDG_SOC_ROLL_NO,WAS_DEFERRED,ID_CHECKED,POSTPONE,WELSH,PAID_CASH,TRAVEL_TIME,SCAN_CODE,FINANCIAL_LOSS,POLICE_CHECK,LAST_UPDATE,READ_ONLY,SUMMONS_FILE,REMINDER_SENT,PHOENIX_DATE,PHOENIX_CHECKED,M_PHONE,H_EMAIL,CONTACT_PREFERENCE,NOTIFICATIONS,TRANSFER_DATE,SERVICE_COMP_COMMS_STATUS)" +
					"VALUES ('415','9" + court + "99998','" + court + "222222','99998',NULL,'LNAMETWO','FNAMETWO',NULL,'2 STREET NAME','ANYTOWN',NULL,NULL,NULL,NULL,'CH1 2AN',NULL,NULL,NULL,NULL,NULL,NULL,'R',(SELECT CURRENT_DATE FROM DUAL),(SELECT CURRENT_DATE FROM DUAL),'N',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,2,NULL,NULL,'Y',NULL,NULL,NULL,NULL,'0001',NULL,'CRO','" + court + "',(SELECT CURRENT_DATE FROM DUAL),NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,(SELECT CURRENT_DATE FROM DUAL),'N',NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL)");
			pStmt.execute();

		} catch (SQLException e) {
			e.printStackTrace();
			log.error("Message:inserted new pool" + e.getMessage());
		} finally {
			conn.commit();
			pStmt.close();
			conn.close();
		}
	}

	public void deleteVoterRecord(String partNo) throws SQLException {
		db = new DBConnection();

		String env_property = System.getProperty("env.database");

		if (env_property != null)
			conn = db.getConnection(env_property);
		else
			conn = db.getConnection("demo");

		try {

			pStmt = conn.prepareStatement("DELETE FROM JUROR_DIGITAL.VOTERS WHERE PART_NO = '" + partNo + "'");
			pStmt.execute();

			pStmt = conn.prepareStatement("DELETE FROM JUROR.POOL WHERE PART_NO = '" + partNo + "'");
			pStmt.execute();

		} catch (SQLException e) {
			e.printStackTrace();
			log.error("Message:Voter record deleted" + e.getMessage());
		} finally {
			conn.commit();
			pStmt.close();
			conn.close();
		}
	}

	public String checkJurorSummonsLetter(String jurorNo) throws SQLException {
		log.info("Checking if juror " + jurorNo + " has been sent a Summons Letter");
		String partNo = "";
		db = new DBConnection();

		String env_property = System.getProperty("env.database");

		if (env_property != null)
			conn = db.getConnection(env_property);
		else
			conn = db.getConnection("demo");

		try {

			pStmt = conn.prepareStatement("SELECT * from JUROR.CONFIRM_LETT WHERE PART_NO = " + jurorNo);
			ResultSet resultSet = pStmt.executeQuery();

			if (!resultSet.next()) {
				log.info("No summons letter for " + jurorNo);
			} else {
				partNo = resultSet.getString("PART_NO");
				log.info("Juror summons letter sent to " + partNo);
			}

		} catch (SQLException e) {
			e.printStackTrace();
			log.error("Message:inserted new pool" + e.getMessage());
		} finally {
			conn.commit();
			pStmt.close();
			conn.close();
		}
		if (!partNo.isEmpty()) {
			return "Juror summons letter sent to " + partNo;
		}
		return "No summons letter for " + jurorNo;
	}


	public void insertNewPoolWithDeferralMatchingNewRequest(String court, String poolDate) throws SQLException {
		db = new DBConnection();

		String env_property = System.getProperty("env.database");

		if (env_property != null)
			conn = db.getConnection(env_property);
		else
			conn = db.getConnection("demo");

		try {
			String startDate = poolDate;

			DateFormat df = new SimpleDateFormat("EEEE dd MMM yyyy");
			Date convertedStartDate = df.parse(startDate);

			String newDateFormat = "dd MMMM yyyy";
			String newStartDate = new SimpleDateFormat(newDateFormat).format(convertedStartDate);


			pStmt = conn.prepareStatement("INSERT INTO JUROR.UNIQUE_POOL (OWNER,POOL_NO,JURISDICTION_CODE,RETURN_DATE,NEXT_DATE,NO_REQUESTED,POOL_TOTAL,REG_SPC,POOL_TYPE,LOC_CODE,NEW_REQUEST,LAST_UPDATE,READ_ONLY,DEFERRALS_USED,ADDITIONAL_SUMMONS,ATTEND_TIME)"
					+ "VALUES ('" + court + "','" + court + "555555',null,to_date(CURRENT_DATE,'DD-MON-RR'),to_date(CURRENT_DATE,'DD-MON-RR'),10,10,'R','CRO','" + court + "','N',to_date(CURRENT_DATE,'DD-MON-RR'),'N',null,null,to_date(CURRENT_DATE,'DD-MON-RR'))");
			pStmt.execute();

//			#insert the pool rows
			pStmt = conn.prepareStatement("Insert into juror.pool (OWNER,PART_NO,POOL_NO,POLL_NUMBER,TITLE,LNAME,FNAME,DOB,ADDRESS,ADDRESS2,ADDRESS3,ADDRESS4,ADDRESS5,ADDRESS6,ZIP,H_PHONE,W_PHONE,W_PH_LOCAL,TIMES_SEL,TRIAL_NO,JUROR_NO,REG_SPC,RET_DATE,DEF_DATE,RESPONDED,DATE_EXCUS,EXC_CODE,ACC_EXC,DATE_DISQ,DISQ_CODE,MILEAGE,LOCATION,USER_EDTQ,STATUS,NOTES,NO_ATTENDANCES,IS_ACTIVE,NO_DEF_POS,NO_ATTENDED,NO_FTA,NO_AWOL,POOL_SEQ,EDIT_TAG,POOL_TYPE,LOC_CODE,NEXT_DATE,ON_CALL,PERM_DISQUAL,PAY_COUNTY_EMP,PAY_EXPENSES,SPEC_NEED,SPEC_NEED_MSG,SMART_CARD,AMT_SPENT,COMPLETION_FLAG,COMPLETION_DATE,SORT_CODE,BANK_ACCT_NAME,BANK_ACCT_NO,BLDG_SOC_ROLL_NO,WAS_DEFERRED,ID_CHECKED,POSTPONE,WELSH,PAID_CASH,TRAVEL_TIME,SCAN_CODE,FINANCIAL_LOSS,POLICE_CHECK,LAST_UPDATE,READ_ONLY,SUMMONS_FILE,REMINDER_SENT,PHOENIX_DATE,PHOENIX_CHECKED,M_PHONE,H_EMAIL,CONTACT_PREFERENCE,NOTIFICATIONS,SERVICE_COMP_COMMS_STATUS,TRANSFER_DATE)"
					+ "values ('400','6" + court + "55555','" + court + "555555','857',null,'LNAME','FNAME',null,'1 STREET NAME','ANYTOWN',null,'London',null,null,'NN1 3HQ',null,null,null,null,null,null,'R',to_date(CURRENT_DATE+50,'DD-MON-RR'),to_date('" + newStartDate + "','DD-MON-RR'),'Y',to_date(CURRENT_DATE,'DD-MON-RR'),'A',null,null,null,null,null,null,7,null,null,'Y',1,null,null,null,'0067',null,'CRO','" + court + "',null,'N',null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,to_date(CURRENT_DATE-30,'DD-MON-RR'),'N',null,null,null,null,null,null,null,0,null,null)");
			pStmt.execute();

			pStmt = conn.prepareStatement("INSERT INTO JUROR.DEFER_DBF(OWNER, PART_NO, DEFER_TO, CHECKED, LOC_CODE)"
					+ "VALUES ('400','6" + court + "55555',to_date('" + newStartDate + "','DD-MON-RR'),'N','" + court + "')");
			pStmt.execute();

		} catch (SQLException | ParseException e) {
			e.printStackTrace();
			log.error("Message:inserted new pool" + e.getMessage());
		} finally {
			conn.commit();
			pStmt.close();
			conn.close();
		}
	}

	public void deletePoolWithDeferral(String poolNo) throws SQLException {
		db = new DBConnection();

		String env_property = System.getProperty("env.database");
		if (env_property != null)
			conn = db.getConnection(env_property);
		else
			conn = db.getConnection("demo");

		try {
			pStmt = conn.prepareStatement("DELETE FROM juror.defer_dbf WHERE part_no in (select part_no from juror.pool where pool_no = '" + poolNo + "')");
			pStmt.execute();

			pStmt = conn.prepareStatement("DELETE FROM juror.pool WHERE part_no = '641555555'");
			pStmt.execute();

			pStmt = conn.prepareStatement("DELETE FROM juror.unique_pool WHERE pool_no = '" + poolNo + "'");
			pStmt.execute();

		} catch (SQLException e) {
			e.printStackTrace();
			log.error("Message:deleted new pool '" + poolNo + "' + e.getMessage()");
		} finally {
			conn.commit();
			pStmt.close();
			conn.close();
		}
	}

	public void insertSingleDigitalSummonsReply(String newJurorRecordNumber) throws SQLException {
		db = new DBConnection();

		String env_property = System.getProperty("env.database");

		if (env_property != null)
			conn = db.getConnection(env_property);
		else
			conn = db.getConnection("demo");

		try {

			pStmt = conn.prepareStatement("DELETE FROM JUROR_DIGITAL.JUROR_RESPONSE WHERE JUROR_NUMBER = " + newJurorRecordNumber);
			pStmt.execute();

			pStmt = conn.prepareStatement("INSERT INTO JUROR_DIGITAL.JUROR_RESPONSE (JUROR_NUMBER,DATE_RECEIVED,TITLE,FIRST_NAME,LAST_NAME,ADDRESS,ADDRESS2,ADDRESS3,ADDRESS4,ADDRESS5,ADDRESS6,ZIP,PROCESSING_STATUS,DATE_OF_BIRTH,PHONE_NUMBER,ALT_PHONE_NUMBER,EMAIL,THIRDPARTY_REASON,RESIDENCY,RESIDENCY_DETAIL,MENTAL_HEALTH_ACT,MENTAL_HEALTH_ACT_DETAILS,BAIL,BAIL_DETAILS,CONVICTIONS,CONVICTIONS_DETAILS,DEFERRAL_REASON,DEFERRAL_DATE,SPECIAL_NEEDS_ARRANGEMENTS,EXCUSAL_REASON, VERSION, JUROR_PHONE_DETAILS, JUROR_EMAIL_DETAILS, URGENT, SUPER_URGENT)"
					+ "VALUES ('" + newJurorRecordNumber + "',(SELECT CURRENT_DATE - interval '0' minute FROM DUAL),'Rev','Fname','Lname','1 Test Street','Scotland','Strathaven','United Kingdom',null,null,'ML106AD','TODO',null,null,null,null,null,'0',null,'0',null,'0',null,'0',null,null,null,null,null,555,'Y', 'Y', 'N', 'N')");
			pStmt.execute();

		} catch (SQLException e) {
			e.printStackTrace();
			log.error("Message:inserted new juror into Juror.Pool and new paper response into Juror_Digital.Juror_Response" + e.getMessage());
		} finally {
			conn.commit();
			pStmt.close();
			conn.close();
		}
	}

	public void insertTwoNewActivePools(String court) throws SQLException {
		db = new DBConnection();

		String env_property = System.getProperty("env.database");

		if (env_property != null)
			conn = db.getConnection(env_property);
		else
			conn = db.getConnection("demo");

		try {

			pStmt = conn.prepareStatement("INSERT INTO JUROR.UNIQUE_POOL (OWNER,POOL_NO,JURISDICTION_CODE,RETURN_DATE,NEXT_DATE,NO_REQUESTED,POOL_TOTAL,REG_SPC,POOL_TYPE,LOC_CODE,NEW_REQUEST,LAST_UPDATE,READ_ONLY,DEFERRALS_USED,ADDITIONAL_SUMMONS,ATTEND_TIME) " +
					"VALUES ('" + court + "','" + court + "222222',NULL,(SELECT CURRENT_DATE FROM DUAL)+112,(SELECT CURRENT_DATE FROM DUAL)+112,5,0,'R','CRO','" + court + "','T',(SELECT CURRENT_DATE FROM DUAL)+112,'Y',NULL,NULL,(SELECT CURRENT_DATE FROM DUAL)+112)");
			pStmt.execute();

			pStmt = conn.prepareStatement("INSERT INTO JUROR.UNIQUE_POOL (OWNER,POOL_NO,JURISDICTION_CODE,RETURN_DATE,NEXT_DATE,NO_REQUESTED,POOL_TOTAL,REG_SPC,POOL_TYPE,LOC_CODE,NEW_REQUEST,LAST_UPDATE,READ_ONLY,DEFERRALS_USED,ADDITIONAL_SUMMONS,ATTEND_TIME) " +
					"VALUES ('400','" + court + "222222',NULL,(SELECT CURRENT_DATE FROM DUAL)+112,(SELECT CURRENT_DATE FROM DUAL)+112,5,0,'R','CRO','" + court + "','N',(SELECT CURRENT_DATE FROM DUAL)+112,'N',NULL,NULL,(SELECT CURRENT_DATE FROM DUAL)+112)");
			pStmt.execute();

			pStmt = conn.prepareStatement("INSERT INTO JUROR_DIGITAL.POOL_REQUEST_EXT (POOL_NO,TOTAL_NO_REQUIRED,LAST_UPDATE) " +
					"VALUES ('" + court + "222222',5,(SELECT CURRENT_DATE FROM DUAL))");
			pStmt.execute();

			pStmt = conn.prepareStatement("INSERT INTO JUROR.UNIQUE_POOL (OWNER,POOL_NO,JURISDICTION_CODE,RETURN_DATE,NEXT_DATE,NO_REQUESTED,POOL_TOTAL,REG_SPC,POOL_TYPE,LOC_CODE,NEW_REQUEST,LAST_UPDATE,READ_ONLY,DEFERRALS_USED,ADDITIONAL_SUMMONS,ATTEND_TIME) " +
					"VALUES ('" + court + "','" + court + "333333',NULL,(SELECT CURRENT_DATE FROM DUAL)+120,(SELECT CURRENT_DATE FROM DUAL)+120,5,0,'R','CRO','" + court + "','T',(SELECT CURRENT_DATE FROM DUAL)+120,'Y',NULL,NULL,(SELECT CURRENT_DATE FROM DUAL)+120)");
			pStmt.execute();

			pStmt = conn.prepareStatement("INSERT INTO JUROR.UNIQUE_POOL (OWNER,POOL_NO,JURISDICTION_CODE,RETURN_DATE,NEXT_DATE,NO_REQUESTED,POOL_TOTAL,REG_SPC,POOL_TYPE,LOC_CODE,NEW_REQUEST,LAST_UPDATE,READ_ONLY,DEFERRALS_USED,ADDITIONAL_SUMMONS,ATTEND_TIME) " +
					"VALUES ('400','" + court + "333333',NULL,(SELECT CURRENT_DATE FROM DUAL)+120,(SELECT CURRENT_DATE FROM DUAL)+120,5,0,'R','CRO','" + court + "','N',(SELECT CURRENT_DATE FROM DUAL)+120,'N',NULL,NULL,(SELECT CURRENT_DATE FROM DUAL)+120)");
			pStmt.execute();

			pStmt = conn.prepareStatement("INSERT INTO JUROR_DIGITAL.POOL_REQUEST_EXT (POOL_NO,TOTAL_NO_REQUIRED,LAST_UPDATE) " +
					"VALUES ('" + court + "333333',5,(SELECT CURRENT_DATE FROM DUAL))");
			pStmt.execute();

		} catch (SQLException e) {
			e.printStackTrace();
			log.error("Message:inserted new pool" + e.getMessage());
		} finally {
			conn.commit();
			pStmt.close();
			conn.close();
		}
	}

	public void insertTwoNewCourtOwnedActivePools(String court) throws SQLException {
		db = new DBConnection();

		String env_property = System.getProperty("env.database");

		if (env_property != null)
			conn = db.getConnection(env_property);
		else
			conn = db.getConnection("demo");

		try {

			pStmt = conn.prepareStatement("INSERT INTO JUROR.UNIQUE_POOL (OWNER,POOL_NO,JURISDICTION_CODE,RETURN_DATE,NEXT_DATE,NO_REQUESTED,POOL_TOTAL,REG_SPC,POOL_TYPE,LOC_CODE,NEW_REQUEST,LAST_UPDATE,READ_ONLY,DEFERRALS_USED,ADDITIONAL_SUMMONS,ATTEND_TIME) " +
					"VALUES ('" + court + "','" + court + "222222',NULL,(SELECT CURRENT_DATE FROM DUAL)+112,(SELECT CURRENT_DATE FROM DUAL)+112,5,0,'R','CRO','" + court + "','N',(SELECT CURRENT_DATE FROM DUAL)+112,'N',NULL,NULL,(SELECT CURRENT_DATE FROM DUAL)+112)");
			pStmt.execute();

			pStmt = conn.prepareStatement("INSERT INTO JUROR.UNIQUE_POOL (OWNER,POOL_NO,JURISDICTION_CODE,RETURN_DATE,NEXT_DATE,NO_REQUESTED,POOL_TOTAL,REG_SPC,POOL_TYPE,LOC_CODE,NEW_REQUEST,LAST_UPDATE,READ_ONLY,DEFERRALS_USED,ADDITIONAL_SUMMONS,ATTEND_TIME) " +
					"VALUES ('400','" + court + "222222',NULL,(SELECT CURRENT_DATE FROM DUAL)+112,(SELECT CURRENT_DATE FROM DUAL)+112,5,0,'R','CRO','" + court + "','N',(SELECT CURRENT_DATE FROM DUAL)+112,'Y',NULL,NULL,(SELECT CURRENT_DATE FROM DUAL)+112)");
			pStmt.execute();


			pStmt = conn.prepareStatement("INSERT INTO JUROR_DIGITAL.POOL_REQUEST_EXT (POOL_NO,TOTAL_NO_REQUIRED,LAST_UPDATE) " +
					"VALUES ('" + court + "222222',5,(SELECT CURRENT_DATE FROM DUAL))");
			pStmt.execute();

			pStmt = conn.prepareStatement("INSERT INTO JUROR.UNIQUE_POOL (OWNER,POOL_NO,JURISDICTION_CODE,RETURN_DATE,NEXT_DATE,NO_REQUESTED,POOL_TOTAL,REG_SPC,POOL_TYPE,LOC_CODE,NEW_REQUEST,LAST_UPDATE,READ_ONLY,DEFERRALS_USED,ADDITIONAL_SUMMONS,ATTEND_TIME) " +
					"VALUES ('" + court + "','" + court + "333333',NULL,(SELECT CURRENT_DATE FROM DUAL)+120,(SELECT CURRENT_DATE FROM DUAL)+120,5,0,'R','CRO','" + court + "','N',(SELECT CURRENT_DATE FROM DUAL)+120,'N',NULL,NULL,(SELECT CURRENT_DATE FROM DUAL)+120)");
			pStmt.execute();

			pStmt = conn.prepareStatement("INSERT INTO JUROR.UNIQUE_POOL (OWNER,POOL_NO,JURISDICTION_CODE,RETURN_DATE,NEXT_DATE,NO_REQUESTED,POOL_TOTAL,REG_SPC,POOL_TYPE,LOC_CODE,NEW_REQUEST,LAST_UPDATE,READ_ONLY,DEFERRALS_USED,ADDITIONAL_SUMMONS,ATTEND_TIME) " +
					"VALUES ('400','" + court + "333333',NULL,(SELECT CURRENT_DATE FROM DUAL)+120,(SELECT CURRENT_DATE FROM DUAL)+120,5,0,'R','CRO','" + court + "','N',(SELECT CURRENT_DATE FROM DUAL)+120,'Y',NULL,NULL,(SELECT CURRENT_DATE FROM DUAL)+120)");
			pStmt.execute();


			pStmt = conn.prepareStatement("INSERT INTO JUROR_DIGITAL.POOL_REQUEST_EXT (POOL_NO,TOTAL_NO_REQUIRED,LAST_UPDATE) " +
					"VALUES ('" + court + "333333',5,(SELECT CURRENT_DATE FROM DUAL))");
			pStmt.execute();

		} catch (SQLException e) {
			e.printStackTrace();
			log.error("Message:inserted new pool" + e.getMessage());
		} finally {
			conn.commit();
			pStmt.close();
			conn.close();
		}
	}

	public void removeVotersAtCourt(String court) throws SQLException {
		db = new DBConnection();

		String env_property = System.getProperty("env.database");

		if (env_property != null)
			conn = db.getConnection(env_property);
		else
			conn = db.getConnection("demo");

		try {

			pStmt = conn.prepareStatement("DELETE FROM JUROR_DIGITAL.VOTERS WHERE LOC_CODE = " + court);
			pStmt.execute();

		} catch (SQLException e) {
			e.printStackTrace();
			log.error("Message:Removed voters at court " + court + e.getMessage());
		} finally {
			conn.commit();
			pStmt.close();
			conn.close();
		}
	}

	public void insertStraightThroughVoterForCourt(String court) throws SQLException {
		db = new DBConnection();

		String env_property = System.getProperty("env.database");

		if (env_property != null)
			conn = db.getConnection(env_property);
		else
			conn = db.getConnection("demo");

		try {

			pStmt = conn.prepareStatement("INSERT INTO JUROR_DIGITAL.VOTERS (LOC_CODE,PART_NO,REGISTER_LETT,POLL_NUMBER,NEW_MARKER,TITLE,LNAME,FNAME,DOB,FLAGS,ADDRESS,ADDRESS2,ADDRESS3,ADDRESS4,ADDRESS5,ADDRESS6,ZIP,DATE_SELECTED1,DATE_SELECTED2,DATE_SELECTED3,REC_NUM,PERM_DISQUAL,SOURCE_ID)"
					+ "VALUES ('" + court + "','6" + court + "88888','88888','88888',NULL,NULL,'LNAMEEIGHTEIGHT','FNAMEEIGHTEIGHT',TIMESTAMP '2000-04-17 00:00:00.000000',NULL,'88 STREET NAME','ANYTOWN',NULL,'SOMETHING',NULL,NULL,'SY2 5BL',NULL,NULL,NULL,88888,NULL,NULL)");
			pStmt.execute();

		} catch (SQLException e) {
			e.printStackTrace();
			log.error("Message:inserted new pool" + e.getMessage());
		} finally {
			conn.commit();
			pStmt.close();
			conn.close();
		}
	}

	public void deleteAllPoolsAtCourt(String court) throws SQLException {
		db = new DBConnection();

		String env_property = System.getProperty("env.database");

		if (env_property != null)
			conn = db.getConnection(env_property);
		else
			conn = db.getConnection("demo");

		try {

			pStmt = conn.prepareStatement("DELETE FROM juror.defer_dbf WHERE loc_code = " + court);
			pStmt.execute();

			pStmt = conn.prepareStatement("DELETE FROM juror.pool WHERE loc_code = " + court);
			pStmt.execute();

			pStmt = conn.prepareStatement("DELETE FROM juror.unique_pool WHERE loc_code = " + court);
			pStmt.execute();

			pStmt = conn.prepareStatement("DELETE FROM juror_digital.pool_request_ext WHERE pool_no LIKE '%" + court + "%'");
			pStmt.execute();

		} catch (SQLException e) {
			e.printStackTrace();
			log.error("Message:deleted all pools at court " + court + e.getMessage());
		} finally {
			conn.commit();
			pStmt.close();
			conn.close();
		}
	}

	public void updateJurorRecordPolicePhoenixCheck(String policeCheck, String phoenixChecked, String jurorRecord) throws SQLException {
		db = new DBConnection();

		String env_property = System.getProperty("env.database");

		if (env_property != null)
			conn = db.getConnection(env_property);
		else
			conn = db.getConnection("demo");

		try {

			pStmt = conn.prepareStatement("update juror.pool set Police_Check='" + policeCheck + "',phoenix_checked='" + phoenixChecked + "' where part_no='" + jurorRecord + "'");
			pStmt.execute();


		} catch (SQLException e) {
			e.printStackTrace();
			log.error("Message:attempting to update " + jurorRecord + " in Juror.Pool setting police_check to " + policeCheck + " and phoenix_checked to: " + phoenixChecked + " - " + e.getMessage());
		} finally {
			conn.commit();
			pStmt.close();
			conn.close();
		}
	}

	public void deleteJurorHistory(String createdJurorRecordNumber) throws SQLException {
		db = new DBConnection();

		String env_property = System.getProperty("env.database");

		if (env_property != null)
			conn = db.getConnection(env_property);
		else
			conn = db.getConnection("demo");
		try {
			//Delete the specified Juror from Juror.Pool
			pStmt = conn.prepareStatement("DELETE FROM JUROR.PART_HIST WHERE PART_NO = '" + createdJurorRecordNumber + "'");
			pStmt.execute();

		} catch (SQLException e) {
			e.printStackTrace();
			log.error("Message:deleted juror.part_hist records with the part_no of " + createdJurorRecordNumber + " - " + e.getMessage());
		} finally {
			conn.commit();
			pStmt.close();
			conn.close();
		}
	}


	public void updateJurorSettingDateWeekInFuture(String column, int weeksInFuture, String jurorNumber) throws SQLException {
		db = new DBConnection();

		String env_property = System.getProperty("env.database");

		if (env_property != null)
			conn = db.getConnection(env_property);
		else
			conn = db.getConnection("demo");

		try {
			//Delete the specified Juror from Juror.Pool
			pStmt = conn.prepareStatement("UPDATE juror.pool SET " + column + " = '" + oracleWeeksInFuture(weeksInFuture) + "' WHERE part_no = " + jurorNumber);
			pStmt.execute();

		} catch (SQLException e) {
			e.printStackTrace();
			log.error("Message:updated juror.pool setting " + column + " to '" + oracleWeeksInFuture(weeksInFuture) + "' WHERE part_no = " + jurorNumber + " - " + e.getMessage());
		} finally {
			conn.commit();
			pStmt.close();
			conn.close();
		}
	}

	public int getOpticReference(String part_no) throws SQLException {
		db = new DBConnection();
		String env_property = System.getProperty("env.database");
		conn = db.getConnection(env_property);

		try {
			pStmt = conn.prepareStatement("select optic_reference from juror_digital.POOL_MEMBER_EXT where part_no='" + part_no + "'");
			ResultSet rs = pStmt.executeQuery();
			rs.next();
			log.info("Optic reference located in pool member extension table for pool");
			return rs.getInt(1);

		} catch (SQLException e) {
			e.printStackTrace();
			log.error("Message:" + e.getMessage());
			log.info(11);
		} finally {
			pStmt.close();
			conn.close();
		}

		return 0;
	}

	public void deleteBulkDataJuror(String createdJurorRecordNumber) throws SQLException {
		db = new DBConnection();

		String env_property = System.getProperty("env.database");

		if (env_property != null)
			conn = db.getConnection(env_property);
		else
			conn = db.getConnection("demo");

		try {
			//Delete the specified Juror from bulk print table
			pStmt = conn.prepareStatement("DELETE FROM juror_mod.bulk_print_data WHERE JUROR_NO ='" + createdJurorRecordNumber + "'");
			pStmt.execute();

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			conn.commit();
			pStmt.close();
			conn.close();
		}
	}


    public ArrayList<String> getUserCourts(String user) throws SQLException {
        db = new DBConnection();
        String env_property = System.getProperty("env.database");
        if (env_property != null)
            conn = db.getConnection(env_property);
        else
            conn = db.getConnection("demo");

        ResultSet rs;
		ArrayList<String> courtCodes = new ArrayList<>();
        try {
            //Delete the specified Juror from bulk print table
            pStmt = conn.prepareStatement("select loc_code from juror_mod.court_location where owner in(select loc_code from juror_mod.user_courts where username = '" + user + "')");
            pStmt.execute();
			rs = pStmt.getResultSet();
			while (rs.next()) {
				courtCodes.add(rs.getString("loc_code"));
			}

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {

            conn.commit();
            pStmt.close();
            conn.close();
        }
        return courtCodes;
    }
}
