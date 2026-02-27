package cucumber.testdata;


import cucumber.utils.DateManipulator;
import cucumber.utils.ReadProperties;
import org.apache.log4j.Logger;
import org.junit.Assert;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.time.DayOfWeek;
import java.time.LocalDate;
import java.time.ZoneId;
import java.time.format.DateTimeFormatter;
import java.time.temporal.TemporalAdjusters;
import java.util.*;

public class DatabaseTesterNewSchemaDesign {

	private static Logger log = Logger.getLogger(DatabaseTesterNewSchemaDesign.class);

    private DBConnection db;
	private Connection conn;
	private PreparedStatement pStmt = null;
	private String holidayDate;
	private String holidayOwner;
	private Date calendar;
	public static ThreadLocal<java.lang.String> newPoolDate = new ThreadLocal<>();
	private int newCoronerPoolNumber;

	public static String oracleWeeksInFuture(int noWeeks) {
		String datePattern = "dd-MMM-yyyy";
		Calendar date = Calendar.getInstance();
		date.add(Calendar.WEEK_OF_MONTH, noWeeks);

		return new SimpleDateFormat(datePattern).format(date.getTime());
	}

	public void rowsExistIn_WhereNSD(int rowCountExpected,
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

	}

	public void updateJurorPool_toSetColumn_asValueNSD(String part_no, String columnName, String columnValue) throws SQLException {
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
			pStmt = conn.prepareStatement("update JUROR_MOD.JUROR_POOL set " + columnName + "=? where juror_number=?");
			if (columnValue.contains("-") && columnValue.contains(":")) {
				pStmt = conn.prepareStatement("update JUROR_MOD.JUROR_POOL set " + columnName + "=TO_DATE(?, 'YYYY-MM-DD HH24:MI:SS') where juror_number=?");
			}
			pStmt.setString(1, columnValue);
			pStmt.setString(2, part_no);

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

	public void updateJuror_JurorPool_toSetColumn_asValueNSD(String part_no, String columnName, String columnValue) throws SQLException {
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
			pStmt = conn.prepareStatement("update JUROR_MOD.JUROR set " + columnName + "=? where juror_number=?");
			if (columnValue.contains("-") && columnValue.contains(":")) {
				pStmt = conn.prepareStatement("update JUROR_MOD.JUROR set " + columnName + "=TO_DATE(?, 'YYYY-MM-DD HH24:MI:SS') where juror_number=?");
			}
			pStmt.setString(1, columnValue);
			pStmt.setString(2, part_no);

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

	public void updateJuror_toSetColumn_asValueNSD(String part_no, String columnName, String columnValue) throws SQLException {
		db = new DBConnection();
		String env_property = System.getProperty("env.database");
		if (env_property != null)
			conn = db.getConnection(env_property);
		else
			conn = db.getConnection("demo");

		log.info("Going to update the database by setting =>" + columnName + "<= to =>" + columnValue + "<= for =>" + part_no);
		try {
			pStmt = conn.prepareStatement("update JUROR_MOD.JUROR set " + columnName + "=? where juror_number=?");
			pStmt.setString(1, columnValue);
			pStmt.setString(2, part_no);

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

	public void updateJurorPool_toInactiveNSD(String part_no) throws SQLException {
		db = new DBConnection();
		String env_property = System.getProperty("env.database");
		if (env_property != null)
			conn = db.getConnection(env_property);
		else
			conn = db.getConnection("demo");

		log.info("Going to update the database by setting =>" + part_no + " to inactive");
		try {
			pStmt = conn.prepareStatement("update JUROR_MOD.JUROR_POOL set IS_ACTIVE = NULL where juror_number=?");
			pStmt.setString(1, part_no);

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

	public void updateJurorUniquePool_toSetAttendanceDateNSD(String pool_no, String columnValue) throws SQLException {
		if (columnValue.contains(" time")) {
			columnValue = DateManipulator.processString(columnValue);
		}

		db = new DBConnection();
		String env_property = System.getProperty("env.database");
		if (env_property != null)
			conn = db.getConnection(env_property);
		else
			conn = db.getConnection("demo");

		log.info("Going to update the database by setting attendance date on juror_mod.pool to =>" + columnValue + "<= for =>" + pool_no);
		boolean success = false;
		try {
			pStmt = conn.prepareStatement("update JUROR_MOD.POOL set RETURN_DATE =? where pool_no=?");
			if (columnValue.contains("-") && columnValue.contains(":")) {
				pStmt = conn.prepareStatement("update JUROR_MOD.POOL set RETURN_DATE =TO_DATE(?, 'YYYY-MM-DD HH24:MI:SS') where pool_no=?");
			}
			pStmt.setString(1, columnValue);
			pStmt.setString(2, pool_no);

			int rowsUpdated = pStmt.executeUpdate();
			conn.commit();
			if (rowsUpdated > 0) {
				log.info("Update Successful");
				success = true;
			}

		} catch (SQLException e) {
			e.printStackTrace();
			log.error("Message:" + e.getMessage());
			throw new SQLException("Failed to update the database: " + e.getMessage(), e);
		} finally {
			if (pStmt != null) pStmt.close();
			if (conn != null) conn.close();
		}
		if (!success) {
			throw new RuntimeException("Update failed: No rows were affected. Possible invalid pool_no or columnValue.");
		}
		log.error("Could not find error within the two types of pools to update");
	}

	//Danielle update Juror data for dashboard
	public void updateJuror_table_toSetColumn_asValueNSD(String part_no, String table, String columnName, String columnValue, String columnNameA, String columnValueA) throws SQLException {
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
			pStmt = conn.prepareStatement("update JUROR_MOD." + table + " set " + columnName + "='" + columnValue + "' where juror_number='" + part_no + "' and " + columnNameA + "=?");
			pStmt.setString(1, columnValueA);

			if (table.equals("POOL")) {
				pStmt = conn.prepareStatement("update JUROR_MOD." + table + " set " + columnName + "=TO_DATE(?, 'YYYY-MM-DD HH24:MI:SS') where pool_no ='" + columnValueA + "'");
				pStmt.setString(1, columnValue);

			} else if (columnValue.contains("-") && columnValue.contains(":")) {
				pStmt = conn.prepareStatement("update JUROR_MOD." + table + " set " + columnName + "=TO_DATE(?, 'YYYY-MM-DD HH24:MI:SS') where juror_number='" + part_no + "' and " + columnNameA + "=?");
				pStmt.setString(1, columnValue);
				pStmt.setString(2, columnValueA);
			}

			pStmt.executeQuery();
			log.info("Update Successful ");
//
		} catch (SQLException e) {
			e.printStackTrace();
			log.error("Message:" + e.getMessage());
		} finally {
			conn.commit();
			pStmt.close();
			conn.close();
		}
	}

	public void backdateJurorsAttendanceInDays(String juror, String noDays) throws SQLException {

		db = new DBConnection();
		String env_property = System.getProperty("env.database");
		if (env_property != null)
			conn = db.getConnection(env_property);
		else
			conn = db.getConnection("demo");

		try {
			pStmt = conn.prepareStatement("update JUROR_MOD.appearance set attendance_date = CURRENT_DATE-" + noDays + " where juror_number='" + juror + "'");

			pStmt.executeUpdate();
			log.info("Update Successful - backdated juror " + juror + " attendance by " + noDays);

		} catch (SQLException e) {
			e.printStackTrace();
			log.error("Message:" + e.getMessage());
		} finally {
			conn.commit();
			pStmt.close();
			conn.close();
		}
	}

	//Danielle update Juror Digital data for dashboard
	public void updateJurorDigitalNSD(String column, String part_no, String value) throws SQLException {
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
			pStmt = conn.prepareStatement("update juror_mod.juror_response set " + column + "=? where juror_number='" + part_no + "'");
			pStmt.setString(1, value);

			if (value.contains("-") && value.contains(":")) {
				pStmt = conn.prepareStatement("update juror_mod.juror_response set " + column + "=TO_DATE(?, 'YYYY-MM-DD HH24:MI:SS') where juror_number='" + part_no + "'");
				pStmt.setString(1, value);
			} else if (column.contains("COMPLETED_AT")) {
				pStmt = conn.prepareStatement("update juror_mod.juror_response set " + column + "=TO_TIMESTAMP(?, 'YYYY-MM-DD HH24:MI:SS') where juror_number='" + part_no + "'");
				pStmt.setString(1, value);
            } else if (value.contains("today")) {
                pStmt = conn.prepareStatement("update juror_mod.juror_response set " + column + "=CURRENT_TIMESTAMP where juror_number='" + part_no + "'");
			}
			pStmt.execute();
			log.info("Updated juror_response " + column + "");

		} finally {
			conn.commit();
			pStmt.close();
			conn.close();
		}

	}

	public void onDatabaseTable_seeColWithColValue_whereColColvalueNSD(
			String environment, String database, String databaseTable,
			String expectedColumn, String expectedColumnValue,
			String whereColumn, String whereColumnValue) throws SQLException {

		try {
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
					Integer.valueOf(whereColumnValue)
			);

			System.out.println("[check passed: " + expectedColumn + " = " + expectedColumnValue +
					" where " + whereColumn + " = " + whereColumnValue);

		} catch (Exception e) {
			System.err.println("check failed for " + database + "." + databaseTable +
					" where " + whereColumn + " = " + whereColumnValue + ". Reason: " + e.getMessage());
			throw e;
		}
	}

	public void onDatabaseTable_seeColWithColValue_whereColColvalueNSD(String environment, String database,
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
				Integer.valueOf(whereColumnValueB)
		);
	}

	public void requestInfoLetterGeneratedNSD(String jurorPartNo) throws SQLException {

		db = new DBConnection();
		String env_property = System.getProperty("env.database");
		if (env_property != null)
			conn = db.getConnection(env_property);
		else
			conn = db.getConnection("demo");

		try {
			pStmt = conn.prepareStatement("select * from juror_mod.bulk_print_data where form_type like '5227%' and juror_no = '" + jurorPartNo + "'");

			pStmt.executeQuery();
			log.info("Selected info letter from bulk_print_data for " + jurorPartNo);

		} catch (SQLException e) {
			e.printStackTrace();
			log.error("Message:" + e.getMessage());
		} finally {
			pStmt.close();
			conn.close();
		}
	}

	public void checkConfirmationLetterIsGeneratedNSD(String jurorNo) throws SQLException {
		log.info("Checking if juror " + jurorNo + " has been sent a confirmation Letter");
		String partNo = "";
		db = new DBConnection();

		String env_property = System.getProperty("env.database");

		if (env_property != null)
			conn = db.getConnection(env_property);
		else
			conn = db.getConnection("demo");

		try {
			pStmt = conn.prepareStatement("select * from juror_mod.bulk_print_data where form_type = '5224A' and juror_no = '" + jurorNo + "'");

			ResultSet rs = pStmt.executeQuery();

			if (rs.next()) {
				log.info("Confirmation letter found for juror!");
			} else {
				log.error("Confirmation letter not found for juror: " + jurorNo);
				throw new AssertionError("Confirmation letter not found for juror " + jurorNo);
			}
		} catch (SQLException e) {
			e.printStackTrace();
			log.error("Message:" + e.getMessage());
		} finally {
			conn.commit();
			pStmt.close();
			conn.close();
		}
	}

	public void checkBilingualConfirmationLetterIsGeneratedNSD(String jurorNo) throws SQLException {
		log.info("Checking if juror " + jurorNo + " has been sent a bilingual confirmation Letter");
		String partNo = "";
		db = new DBConnection();

		String env_property = System.getProperty("env.database");

		if (env_property != null)
			conn = db.getConnection(env_property);
		else
			conn = db.getConnection("demo");

		try {
			pStmt = conn.prepareStatement("select * from juror_mod.bulk_print_data where form_type = '5224AC' and juror_no = '" + jurorNo + "'");

			ResultSet rs = pStmt.executeQuery();

			if (rs.next()) {
				log.info("Bilingual confirmation letter found for juror!");
			} else {
				log.error("Bilingual confirmation letter not found for juror: " + jurorNo);
				throw new AssertionError("Bilingual confirmation letter not found for juror " + jurorNo);
			}
		} catch (SQLException e) {
			e.printStackTrace();
			log.error("Message:" + e.getMessage());
		} finally {
			conn.commit();
			pStmt.close();
			conn.close();
		}
	}

	public void checkConfirmationLetterIsNotGeneratedNSD(String jurorNo) throws SQLException {
		log.info("Checking that juror " + jurorNo + " has not been sent a confirmation Letter");
		String partNo = "";
		db = new DBConnection();

		String env_property = System.getProperty("env.database");

		if (env_property != null)
			conn = db.getConnection(env_property);
		else
			conn = db.getConnection("demo");

		try {
			pStmt = conn.prepareStatement("select * from juror_mod.bulk_print_data where form_type like '5224A%' and juror_no = '" + jurorNo + "'");

			ResultSet rs = pStmt.executeQuery();

			if (rs.next()) {
				log.info("Confirmation letter found for juror!");
				throw new AssertionError("Confirmation letter was incorrectly found for juror " + jurorNo);
			} else {
				log.error("Confirmation letter correctly not found for juror: " + jurorNo);
			}
		} catch (SQLException e) {
			e.printStackTrace();
			log.error("Message:" + e.getMessage());
		} finally {
			conn.commit();
			pStmt.close();
			conn.close();
		}
	}

	public void onDatabaseTable_seeColIsNull_whereColColvalueNSD(String environment, String database, String databaseTable,
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
				Integer.valueOf(whereColumnValue)
		);

	}


	public void staffWithName_doesNotExistNSD(String staffName) throws SQLException {
		db = new DBConnection();
		String env_property = System.getProperty("env.database");
		if (env_property != null)
			conn = db.getConnection(env_property);
		else
			conn = db.getConnection("demo");
		try {

			pStmt = conn.prepareStatement("delete from juror_mod.user_courts where username=?");
			pStmt.setString(1, staffName);
			pStmt.execute();
			conn.commit();
			log.info("Delete all JUROR_MOD.USER_COURTS rows where name =>" + staffName);

			pStmt = conn.prepareStatement("delete from juror_mod.user_roles where username=?");
			pStmt.setString(1, staffName);
			pStmt.execute();
			conn.commit();
			log.info("Delete all JUROR_MOD.USER_ROLES rows where name =>" + staffName);

			pStmt = conn.prepareStatement("delete from juror_mod.users where username=?");
			pStmt.setString(1, staffName);
			pStmt.execute();
			conn.commit();
			log.info("Delete all JUROR_MOD.USERS rows where Name =>" + staffName);

		} catch (SQLException e) {
			e.printStackTrace();
			log.error("Message:" + e.getMessage());
		} finally {
			pStmt.close();
			conn.close();
		}
	}

	public void clean_juror_pool(String part_no) throws SQLException {
		db = new DBConnection();
		String env_property = System.getProperty("env.database");
		if (env_property != null)
			conn = db.getConnection(env_property);
		else
			conn = db.getConnection("demo");
		try {
			pStmt = conn.prepareStatement("delete from juror_mod.juror_pool where juror_number=?");
			pStmt.setString(1, part_no);
			pStmt.execute();
			log.info("Deleted from juror_mod.juror_pool where juror_number=>" + part_no);

		} catch (SQLException e) {
			e.printStackTrace();
			log.error("Message:" + e.getMessage());
		} finally {
			conn.commit();
			pStmt.close();
			conn.close();
		}

	}

	public void clean_juror_digitalNSD(String part_no) throws SQLException {
		db = new DBConnection();
		String env_property = System.getProperty("env.database");
		if (env_property != null)
			conn = db.getConnection(env_property);
		else
			conn = db.getConnection("demo");
		try {
			pStmt = conn.prepareStatement("delete from juror_mod.juror_response_aud where juror_number=?");
			pStmt.setString(1, part_no);
			pStmt.execute();
			log.info("Deleted from juror_response_aud where juror_number=>" + part_no);

			pStmt = conn.prepareStatement("delete from juror_mod.juror_response_cjs_employment where juror_number=?");
			pStmt.setString(1, part_no);
			pStmt.execute();
			log.info("Deleted from juror_response_cjs_employment where juror_number=>" + part_no);

			pStmt = conn.prepareStatement("delete from juror_mod.juror_reasonable_adjustment where juror_number=?");
			pStmt.setString(1, part_no);
			pStmt.execute();
			log.info("Deleted from juror_reasonable_adjustment where juror_number=>" + part_no);

			pStmt = conn.prepareStatement("delete from juror_mod.USER_JUROR_RESPONSE_AUDIT where juror_number=?");
			pStmt.setString(1, part_no);
			pStmt.execute();
			log.info("Deleted from USER_JUROR_RESPONSE_AUDIT where juror_number=>" + part_no);

			pStmt = conn.prepareStatement("delete from juror_mod.juror_response where juror_number=?");
			pStmt.setString(1, part_no);
			pStmt.execute();
			log.info("Deleted from juror_response where juror_number=>" + part_no);

			pStmt = conn.prepareStatement("delete from juror_mod.appearance where juror_number=?");
			pStmt.setString(1, part_no);
			pStmt.execute();
			log.info("Deleted from juror_mod.appearance where juror_number=>" + part_no);
//

		} catch (SQLException e) {
			e.printStackTrace();
			log.error("Message:" + e.getMessage());
		} finally {
			conn.commit();
			pStmt.close();
			conn.close();
		}

	}

	public void cleanTestDataNSD(String pool_number, String juror_number) throws SQLException {
		db = new DBConnection();
		String env_property = System.getProperty("env.database");
		if (env_property != null)
			conn = db.getConnection(env_property);
		else
			conn = db.getConnection("demo");
		try {

			pStmt = conn.prepareStatement("delete from juror_mod.juror_trial where juror_number='" + juror_number + "'");
			pStmt.execute();
			conn.commit();
			log.info("Deleted from juror_mod.juror_trial where juror_number=>" + juror_number);

			pStmt = conn.prepareStatement("delete from juror_mod.juror_response_aud where juror_number='" + juror_number + "'");
			pStmt.execute();
			conn.commit();
			log.info("Deleted from juror_response_aud where juror_number=>" + juror_number);

			pStmt = conn.prepareStatement("delete from juror_mod.juror_response_cjs_employment where juror_number='" + juror_number + "'");
			pStmt.execute();
			conn.commit();
			log.info("Deleted from juror_response_cjs_employment where juror_number=>" + juror_number);

			pStmt = conn.prepareStatement("delete from juror_mod.juror_reasonable_adjustment where juror_number='" + juror_number + "'");
			pStmt.execute();
			conn.commit();
			log.info("Deleted from juror_reasonable_adjustment where juror_number=>" + juror_number);

			pStmt = conn.prepareStatement("delete from juror_mod.USER_JUROR_RESPONSE_AUDIT where juror_number='" + juror_number + "'");
			pStmt.execute();
			conn.commit();
			log.info("Deleted from USER_JUROR_RESPONSE_AUDIT where juror_number=>" + juror_number);

			pStmt = conn.prepareStatement("delete from juror_mod.juror_third_party where juror_number='" + juror_number + "'");
			pStmt.execute();
			conn.commit();
			log.info("Deleted from juror_third_party where juror_number=>" + juror_number);

			pStmt = conn.prepareStatement("delete from juror_mod.juror_third_party_audit where juror_number='" + juror_number + "'");
			pStmt.execute();
			conn.commit();
			log.info("Deleted from juror_third_party_audit where juror_number=>" + juror_number);

			pStmt = conn.prepareStatement("delete from juror_mod.juror_response where juror_number='" + juror_number + "'");
			pStmt.execute();
			conn.commit();
			log.info("Deleted from juror_response where juror_number=>" + juror_number);

			pStmt = conn.prepareStatement("delete from juror_mod.juror_history where juror_number='" + juror_number + "'");
			pStmt.execute();
			conn.commit();
			log.info("Cleared JUROR_MOD.juror_history for juror_number=>" + juror_number);

			pStmt = conn.prepareStatement("delete from juror_mod.bulk_print_data where juror_no='" + juror_number + "'");
			pStmt.execute();
			conn.commit();
			log.info("Cleared juror_mod.bulk_print_data for part_no=>" + juror_number);

			pStmt = conn.prepareStatement("delete from juror_mod.juror_audit where juror_number='" + juror_number + "'");
			pStmt.execute();
			conn.commit();
			log.info("Cleared juror_mod.juror_audit for juror_number=>" + juror_number);

			pStmt = conn.prepareStatement("delete from juror_mod.rev_info where revision_number in (select revision from juror_mod.juror_audit where juror_number='" + juror_number + "')");
			pStmt.execute();
			conn.commit();
			log.info("Cleared juror_mod.rev_info for juror_number=>" + juror_number);

			pStmt = conn.prepareStatement("delete from juror_mod.contact_log where juror_number='" + juror_number + "'");
			pStmt.execute();
			conn.commit();
			log.info("Cleared juror_mod.contact_log for juror_number=>" + juror_number);

			pStmt = conn.prepareStatement("delete from juror_mod.appearance where juror_number='" + juror_number + "'");
			pStmt.execute();
			conn.commit();
			log.info("Deleted from juror_mod.appearance where juror_number=>" + juror_number);

			pStmt = conn.prepareStatement("delete from juror_mod.appearance_audit where juror_number='" + juror_number + "'");
			pStmt.execute();
			conn.commit();
			log.info("Deleted from juror_mod.appearance_audit where juror_number=>" + juror_number);

			pStmt = conn.prepareStatement("delete from juror_mod.juror_pool where juror_number='" + juror_number + "'");
			pStmt.execute();
			conn.commit();
			log.info("Deleted from juror_mod.juror_pool where juror_number=>" + juror_number);

			pStmt = conn.prepareStatement("delete from juror_mod.financial_audit_details_appearances where FINANCIAL_AUDIT_ID in (select ID from juror_mod.financial_audit_details where JUROR_NUMBER ='" + juror_number + "')");
			pStmt.execute();
			conn.commit();
			log.info("Deleted from juror_mod.financial_audit_details_appearances where juror_number=>" + juror_number);

			pStmt = conn.prepareStatement("delete from juror_mod.financial_audit_details where JUROR_NUMBER ='" + juror_number + "'");
			pStmt.execute();
			conn.commit();
			log.info("Deleted from juror_mod.financial_audit_details where juror_number=>" + juror_number);

			pStmt = conn.prepareStatement("delete from juror_mod.juror where juror_number='" + juror_number + "'");
			pStmt.execute();
			conn.commit();
			log.info("Deleted from juror_mod.juror where juror_number=>" + juror_number);

			pStmt = conn.prepareStatement("delete from juror_mod.pending_juror where juror_number='" + juror_number + "'");
			pStmt.execute();
			conn.commit();
			log.info("Deleted from juror_mod.pending_juror where juror_number=>" + juror_number);

			pStmt = conn.prepareStatement("delete from juror_mod.message where juror_number='" + juror_number + "'");
			pStmt.execute();
			conn.commit();
			log.info("Deleted from juror_mod.message where juror_number=>" + juror_number);

			pStmt = conn.prepareStatement("delete from juror_mod.bureau_snapshot where juror_number='" + juror_number + "'");
			pStmt.execute();
			conn.commit();
			log.info("Deleted from juror_mod.bureau_snapshot where juror_number=>" + juror_number);

			pStmt = conn.prepareStatement("delete from juror_mod.bulk_print_data where juror_no='" + juror_number + "'");
			pStmt.execute();
			conn.commit();
			log.info("Deleted from juror_mod.bulk_print_data where juror_number=>" + juror_number);


		} catch (SQLException e) {
			e.printStackTrace();
			log.error("Message:" + e.getMessage());
		} finally {
			conn.commit();
			pStmt.close();
			conn.close();
		}

	}

	public void cleanTestDataPoolNSD(String pool_number) throws SQLException {
		db = new DBConnection();
		String env_property = System.getProperty("env.database");
		if (env_property != null)
			conn = db.getConnection(env_property);
		else
			conn = db.getConnection("demo");

		try {
			if (getCountFromJurorPoolByPoolNoNSD(pool_number) == 0)
				pStmt = conn.prepareStatement("delete from juror_mod.pool where pool_no='" + pool_number + "'");
			pStmt.execute();
			conn.commit();
			log.info("Deleted from juror_mod.pool where pool_number=>" + pool_number);

		} catch (SQLException e) {
			e.printStackTrace();
			log.error("Message:" + e.getMessage());
		} finally {
			conn.commit();
			pStmt.close();
			conn.close();
		}

	}

	public void createPoolNSD(String court, String noWeeks, String owner, String pool_number) throws SQLException {

		db = new DBConnection();

		String env_property = System.getProperty("env.database");
		if (env_property != null)
			conn = db.getConnection(env_property);
		else
			conn = db.getConnection("demo");

		Calendar calendar = Calendar.getInstance();
		calendar.add(Calendar.WEEK_OF_MONTH, Integer.parseInt(noWeeks));

		String attDate = new SimpleDateFormat("yyyy-MM-dd").format(calendar.getTime());
		newPoolDate.set(new SimpleDateFormat("E d MMM yyy").format(calendar.getTime()));

		try {

			if (getCountFromUniquePoolNSD(pool_number) == 0)
				pStmt = conn.prepareStatement("INSERT INTO juror_mod.pool (pool_no, owner, return_date, no_requested, pool_type, loc_code, new_request, last_update, additional_summons, attend_time, nil_pool, total_no_required, date_created)"
						+ "VALUES ('" + pool_number + "', '" + owner + "', '" + attDate + "', 20, 'CRO', '" + court + "', 'N', NOW(), NULL, (timestamp '" + attDate + " 10:00:00'), false, 0, NOW())");
			pStmt.execute();
			pStmt = conn.prepareStatement("SELECT return_date FROM juror_mod.pool WHERE pool_no = ?");
			pStmt.setString(1, pool_number);
			ResultSet rs = pStmt.executeQuery();
			if (rs.next()) {
				String insertedDate = rs.getString("return_date");
				System.out.println("Actual return date in the database: " + insertedDate);
				if (!attDate.equals(insertedDate)) {

					pStmt = conn.prepareStatement("UPDATE juror_mod.pool SET return_date = '" + attDate + "' WHERE pool_no = '" + pool_number + "'");
					pStmt.executeUpdate();

					pStmt = conn.prepareStatement("SELECT return_date FROM juror_mod.pool WHERE pool_no = ?");
					pStmt.setString(1, pool_number);
					rs = pStmt.executeQuery();
					if (rs.next()) {
						insertedDate = rs.getString("return_date");
						System.out.println("Updated return date in the database: " + insertedDate);
						if (!attDate.equals(insertedDate)) {
							throw new SQLException("The return date was not updated correctly. Expected: " + attDate + ", Actual: " + insertedDate);
						}
					} else {
						throw new SQLException("The pool was not found after the update attempt.");
					}
				}
			} else {
				throw new SQLException("The updated pool was not found.");
			}

		} finally {
			conn.commit();
			pStmt.close();
			conn.close();
		}
	}

	public void setPoolLocCode(String pool_number, String loc_code) throws SQLException {

		db = new DBConnection();

		String env_property = System.getProperty("env.database");
		if (env_property != null)
			conn = db.getConnection(env_property);
		else
			conn = db.getConnection("demo");

		try {

			pStmt = conn.prepareStatement("UPDATE juror_mod.pool set LOC_CODE = '" + loc_code + "' where POOL_NO = '" + pool_number + "'");
			pStmt.executeUpdate();
			conn.commit();
			pStmt.close();
			conn.close();

		} catch (SQLException e) {
			throw new RuntimeException(e);
		}

	}

	public void createJurorsNSD(String pool_number, String juror_number, String noWeeks) throws SQLException {

		db = new DBConnection();

		String env_property = System.getProperty("env.database");
		if (env_property != null)
			conn = db.getConnection(env_property);

		else
			conn = db.getConnection("demo");

		Calendar calendar = Calendar.getInstance();
		calendar.add(Calendar.WEEK_OF_MONTH, Integer.parseInt(noWeeks));

		String attDate = new SimpleDateFormat("yyyy-MM-d").format(calendar.getTime());

		try {
			pStmt = conn.prepareStatement("insert into juror_mod.juror (juror_number,poll_number,title,last_name,first_name,dob,ADDRESS_LINE_1,ADDRESS_LINE_2,ADDRESS_LINE_3,ADDRESS_LINE_4,ADDRESS_LINE_5,POSTCODE,h_phone,w_phone,w_ph_local,responded,date_excused,excusal_code,acc_exc,date_disq,disq_code,user_edtq,notes,no_def_pos,perm_disqual,reasonable_adj_code,reasonable_adj_msg,sort_code,bank_acct_name,bank_acct_no,bldg_soc_roll_no,welsh,police_check,last_update,summons_file,m_phone,h_email,contact_preference,notifications,date_created,optic_reference,pending_title,pending_first_name,pending_last_name)"
					+ "values ('" + juror_number + "','857',null,'lname','fname',null,'address',null,null,'Address Line Four',null,'CH2 2AA',null,null,null,false,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,'N','NOT_CHECKED',null,null,null,null,null,'0',null,null,null,null,null)");
			pStmt.execute();

			pStmt = conn.prepareStatement("insert into juror_mod.juror_pool (juror_number, pool_number, owner, user_edtq, is_active, status, times_sel, def_date, location, no_attendances, no_attended, no_fta, no_awol, pool_seq, edit_tag, next_date, on_call, was_deferred, deferral_code, id_checked, postpone, paid_cash, scan_code, last_update, reminder_sent, transfer_date, date_created)"
					+ " VALUES ('" + juror_number + "', '" + pool_number + "', '400', 'MODTESTBUREAU', true, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0001', NULL, '" + attDate + "', false, NULL, NULL, NULL, NULL, NULL, NULL, NOW(), NULL, NULL, NOW())");
			pStmt.execute();

		} finally {
			conn.commit();
			pStmt.close();
			conn.close();
		}
	}

	public int getNextIdNSD(String tableName) throws SQLException {
		db = new DBConnection();
		String env_property = System.getProperty("env.database");
		conn = db.getConnection(env_property);
		try {
			pStmt = conn.prepareStatement("select MAX(id) from " + tableName + "");
			ResultSet rs = pStmt.executeQuery();
			rs.next();
			log.info("Got max ID from " + tableName);
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

	public int getNextPoolNoNSD(String newPoolNo) throws SQLException {
		db = new DBConnection();
		String env_property = System.getProperty("env.database");
		conn = db.getConnection(env_property);
		try {
			pStmt = conn.prepareStatement("select MAX(pool_no) from JUROR_MOD.pool where pool_no like '" + newPoolNo + "%'");
			ResultSet rs = pStmt.executeQuery();
			rs.next();
			log.info("Got max pool number plus 1");
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

	public void insertCourtroomsNSD(String court) throws SQLException {

		db = new DBConnection();

		String env_property = System.getProperty("env.database");
		if (env_property != null)
			conn = db.getConnection(env_property);

		else
			conn = db.getConnection("demo");

		try {
			pStmt = conn.prepareStatement("INSERT INTO juror_mod.courtroom (loc_code,room_number,description)"
					+ "VALUES ('" + court + "','Court','COURT ROOM')");
			pStmt.execute();

			pStmt = conn.prepareStatement("INSERT INTO juror_mod.courtroom (loc_code,room_number,description)"
					+ "VALUES ('" + court + "','ChkOut','PARTICIPANT CHECKED OUT')");
			pStmt.execute();

			pStmt = conn.prepareStatement("INSERT INTO juror_mod.courtroom (loc_code,room_number,description)"
					+ "VALUES ('" + court + "','Navail','Not Available')");
			pStmt.execute();

			pStmt = conn.prepareStatement("INSERT INTO juror_mod.courtroom (loc_code,room_number,description)"
					+ "VALUES ('" + court + "','Asmbly','JURY ASSEMBLY ROOM')");
			pStmt.execute();

		} finally {
			conn.commit();
			pStmt.close();
			conn.close();
		}
	}

	public void deleteCourtroomsNSD(String court) throws SQLException {

		db = new DBConnection();

		String env_property = System.getProperty("env.database");
		if (env_property != null)
			conn = db.getConnection(env_property);

		else
			conn = db.getConnection("demo");

		try {
			pStmt = conn.prepareStatement("DELETE from juror_mod.courtroom where loc_code = '" + court + "'");
			pStmt.execute();

		} finally {
			conn.commit();
			pStmt.close();
			conn.close();
		}
	}

	//Insert an RSUM row in PART_HIST
	public void insertRSUMRowNSD(String part_no, String pool_no) throws SQLException {

		db = new DBConnection();

		String env_property = System.getProperty("env.database");
		if (env_property != null)
			conn = db.getConnection(env_property);

		else
			conn = db.getConnection("demo");

		try {
			pStmt = conn.prepareStatement("INSERT INTO juror_mod.juror_history (juror_number,date_created, history_code, user_id, other_information,pool_number)"
					+ "VALUES ('" + part_no + "', NOW(), 'RSUM', 'CPASS', 'File -JURY081001.0001', '" + pool_no + "')");
			pStmt.execute();

//			pStmt = conn.prepareStatement("insert into juror_mod.rev_info (revision_number, revision_timestamp) values ((select MAX(revision_number)+1 from juror.juror_mod.rev_info), EXTRACT(EPOCH FROM current_date))");
//			pStmt.execute();
//
//			pStmt = conn.prepareStatement("INSERT INTO juror_mod.juror_audit (revision,juror_number,rev_type,title,first_name,last_name,dob,address_line_1,address_line_2,address_line_3,address_line_4,address_line_5,address6,postcode,h_email,h_phone,m_phone,w_phone,w_ph_local,bank_acct_no,bldg_soc_roll_no,sort_code,pending_title,pending_first_name,pending_last_name,claiming_subsistence_allowance,smart_card_number)"
//					+ "VALUES ((select max(revision_number) from juror_mod.rev_info),'" + part_no + "',1,NULL,'FNAME','LNAME',NULL,'Line 1','Testtown',NULL,'Testcity',NULL,NULL,'CH1 2NN',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,FALSE,NULL)");
//			pStmt.execute();
		} finally {
			conn.commit();
			pStmt.close();
			conn.close();
		}
	}

	public void insertRESPRowNSD(String part_no, String pool_no, Integer newId) throws SQLException {

		db = new DBConnection();

		String env_property = System.getProperty("env.database");
		if (env_property != null)
			conn = db.getConnection(env_property);
		else
			conn = db.getConnection("demo");

		try {
			pStmt = conn.prepareStatement("INSERT INTO juror_mod.juror_history (juror_number,date_created, history_code, user_id, other_information,pool_number)"
					+ "VALUES ('" + part_no + "', NOW(), 'RESP', 'CPASS', 'File -JURY081001.0001', '" + pool_no + "')");
			pStmt.execute();
		} finally {
			conn.commit();
			pStmt.close();
			conn.close();
		}
	}

	public void insertPUNDRowNSD(String part_no, String pool_no, Integer newId) throws SQLException {

		db = new DBConnection();

		String env_property = System.getProperty("env.database");
		if (env_property != null)
			conn = db.getConnection(env_property);
		else
			conn = db.getConnection("demo");

		try {
			pStmt = conn.prepareStatement("INSERT INTO juror_mod.juror_history (juror_number,date_created, history_code, user_id, other_information,pool_number)"
					+ "VALUES ('" + part_no + "', NOW(), 'PUND', 'CPASS', 'File -JURY081001.0001', '" + pool_no + "')");
			pStmt.execute();
		} finally {
			conn.commit();
			pStmt.close();
			conn.close();
		}
	}



	public void clean_jurorTablesPreSetListNSD(String part_no, String pool_no, String owner) throws SQLException {
		db = new DBConnection();
		String env_property = System.getProperty("env.database");
		if (env_property != null)
			conn = db.getConnection(env_property);
		else
			conn = db.getConnection("demo");
		try {
			pStmt = conn.prepareStatement("delete from juror_mod.juror_history where (juror_number=? and history_code !='RSUM') OR (juror_number=? and pool_number!=?)");
			pStmt.setString(1, part_no);
			pStmt.setString(2, part_no);
			pStmt.setString(3, pool_no);
			pStmt.execute();
			log.info("Cleared JUROR_MOD.juror_history for juror_number=>" + part_no + "<= and history_code is not RSUM OR juror_number =>" + part_no + "<= and pool_number NOT =>" + pool_no);

			pStmt = conn.prepareStatement("delete from juror_mod.bulk_print_data where juror_no=?");
			pStmt.setString(1, part_no);
			pStmt.execute();
			log.info("Cleared juror_mod.bulk_print_data for part_no=>" + part_no);

			pStmt = conn.prepareStatement("delete from juror_mod.juror_audit where juror_number=?");
			pStmt.setString(1, part_no);
			pStmt.execute();
			log.info("Cleared juror_mod.juror_audit for juror_number=>" + part_no);

			pStmt = conn.prepareStatement("delete from juror_mod.rev_info where revision_number in (select revision from juror_mod.juror_audit where juror_number=?)");
			pStmt.setString(1, part_no);
			pStmt.execute();
			log.info("Cleared juror_mod.rev_info for juror_number=>" + part_no);

			pStmt = conn.prepareStatement("delete from juror_mod.contact_log where juror_number=?");
			pStmt.setString(1, part_no);
			pStmt.execute();
			log.info("Cleared juror_mod.contact_log for juror_number=>" + part_no + "");

		} catch (SQLException e) {
			e.printStackTrace();
			log.error("Message:" + e.getMessage());
		} finally {
			conn.commit();
			pStmt.close();
			conn.close();
		}

	}

	public void clean_jurorNSD(String part_no, String pool_no, String owner) throws SQLException {
		db = new DBConnection();
		String env_property = System.getProperty("env.database");
		if (env_property != null)
			conn = db.getConnection(env_property);
		else
			conn = db.getConnection("demo");

		if (getCountFromJurorPoolNSD(part_no, pool_no) > 1)
			pStmt = conn.prepareStatement("delete from juror_mod.juror_pool where"
					+ " juror_number = '" + part_no + "'"
					+ " and "
					+ " is_active is not true");

		pStmt.execute();
		conn.commit();

		if (getCountFromJurorPoolNSD(part_no, pool_no) == 0)
			pStmt = conn.prepareStatement("insert into juror_mod.juror_pool (juror_number, pool_number, owner, user_edtq, is_active, status, times_sel, def_date, location, no_attendances, no_attended, no_fta, no_awol, pool_seq, edit_tag, next_date, on_call, was_deferred, deferral_code, id_checked, postpone, paid_cash, scan_code, last_update, reminder_sent, transfer_date, date_created)"
					+ " VALUES ('" + part_no + "', '" + pool_no + "', '400', 'MODTESTBUREAU', true, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0001', NULL, '2024-03-19', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2024-01-09 11:25:00.791', NULL, NULL, '2024-01-09 11:25:00.791')");

		pStmt.execute();
		conn.commit();

		if (checkForTransferredPoolRecordsNSD(part_no) > 1)
			pStmt = conn.prepareStatement("delete from juror_mod.juror_pool where"
					+ " juror_number = '" + part_no + "'"
					+ " and "
					+ " transfer_date is null");

		pStmt.execute();
		conn.commit();

		try {

			pStmt = conn.prepareStatement("update juror_mod.juror set"
					+ " responded=false, "
					+ " title = NULL,"
					+ "	dob = NULL,"
					+ "	ADDRESS_LINE_3 = NULL,"
					+ "	ADDRESS_LINE_4 = 'London',"
					+ "	ADDRESS_LINE_5 = NULL,"
					+ "	H_PHONE = NULL,"
					+ "	W_PHONE = NULL,"
					+ "	W_PH_LOCAL = NULL,"
					+ " EXCUSAL_CODE = NULL,"
					+ " DATE_EXCUSED = NULL,"
					+ " DATE_DISQ = NULL,"
					+ " DISQ_CODE = NULL,"
					+ " ACC_EXC = NULL,"
					+ " NO_DEF_POS = NULL,"
					+ "	USER_EDTQ = NULL,"
					+ "	NOTES = NULL,"
					+ "	WELSH = NULL,"
					+ "	POLICE_CHECK = NULL,"
					+ "	M_PHONE = NULL,"
					+ "	H_EMAIL = NULL,"
					+ "	CONTACT_PREFERENCE = NULL,"
					+ " OPTIC_REFERENCE = NULL,"
					+ " NOTIFICATIONS ='0'"
					+ " where "
					+ " juror_number = '" + part_no + "'");

			pStmt.execute();

			log.info("Cleaned up juror table where juror_number=>" + part_no);

			pStmt = conn.prepareStatement("update juror_mod.juror_pool set"
					+ " status='1', "
					+ "	TIMES_SEL = NULL,"
					+ " DEF_DATE = NULL,"
					+ "	USER_EDTQ = NULL,"
					+ "	OWNER = '400',"
					+ " ON_CALL = false,"
					+ "	POOL_NUMBER = '" + pool_no + "',"
					+ "	TRANSFER_DATE = NULL,"
					+ " IS_ACTIVE =true"
					+ " where "
					+ " juror_number = '" + part_no + "'");

			pStmt.execute();

			pStmt = conn.prepareStatement("update juror_mod.pool set"
					+ "	OWNER = '400'"
					+ " where "
					+ " pool_no = '" + pool_no + "'");

			pStmt.execute();

			log.info("Cleaned up juror_pool table where juror_number=>" + part_no);

		} catch (SQLException e) {
			e.printStackTrace();
			log.error("Message:" + e.getMessage());
		} finally {
			conn.commit();
			pStmt.close();
			conn.close();
		}
	}

	public void resetPooltoPendingAllocationNSD(String pool_no) throws SQLException {
		db = new DBConnection();
		String env_property = System.getProperty("env.database");
		if (env_property != null)
			conn = db.getConnection(env_property);
		else
			conn = db.getConnection("demo");
		try {
			pStmt = conn.prepareStatement("update juror_mod.juror_response set"
					+ " staff_login = NULL,"
					+ "	staff_assignment_date = NULL "
					+ " where processing_status='TODO' and  juror_number in "
					+ "( "
					+ "select juror_number from juror_mod.juror_pool where "
					+ " juror_number = ?"
					+ ")"
			);

			pStmt.setString(1, pool_no);

			pStmt.execute();
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

	public void straightThroughDisabledNSD() throws SQLException {
		db = new DBConnection();
		String env_property = System.getProperty("env.database");
		if (env_property != null)
			conn = db.getConnection(env_property);
		else
			conn = db.getConnection("demo");
		try {
			pStmt = conn.prepareStatement("update juror_mod.app_setting set value='TRUE' where setting in ("
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

	public void straightThroughEnabledNSD() throws SQLException {
		db = new DBConnection();
		String env_property = System.getProperty("env.database");
		if (env_property != null)
			conn = db.getConnection(env_property);
		else
			conn = db.getConnection("demo");
		try {
			pStmt = conn.prepareStatement("update juror_mod.app_setting set value='FALSE' where setting in ("
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

	public void dateReceviedFor_setTo_workingDaysBeforeCurrentNSD(String part_no, Integer workingDays) throws SQLException {
		String dateToUpdateTo = DateManipulator.addWorkingDaysToCurrentDate(-workingDays);
		db = new DBConnection();
		String env_property = System.getProperty("env.database");
		if (env_property != null)
			conn = db.getConnection(env_property);
		else
			conn = db.getConnection("demo");
		try {
			pStmt = conn.prepareStatement("update juror_mod.juror_response set date_received = TO_DATE(?, 'YYYY-MM-DD HH24:MI:SS') where juror_number=?");
			pStmt.setString(1, dateToUpdateTo);
			pStmt.setString(2, part_no);
			pStmt.execute();
			log.info("Updated juror_response to change response date to 2 days ago");

		} catch (SQLException e) {
			e.printStackTrace();
			log.error("Message:" + e.getMessage());
		} finally {
			conn.commit();
			pStmt.close();
			conn.close();
		}

	}

	public void deleteNewPoolRequestsNSD() throws SQLException {
		db = new DBConnection();

		String env_property = System.getProperty("env.database");
		if (env_property != null)
			conn = db.getConnection(env_property);
		else
			conn = db.getConnection("demo");

		try {
			pStmt = conn.prepareStatement("Delete from juror_mod.pool where new_request='T' and pool_no not in (select pool_number from juror_mod.juror_pool)");
			pStmt.executeUpdate();


		} catch (SQLException e) {
			e.printStackTrace();
			log.error("Message:" + e.getMessage());
		} finally {
			conn.commit();
			pStmt.close();
			conn.close();
		}
	}

	public void deleteNewRecordsForPartNoNSD(String partNo) throws SQLException {
		db = new DBConnection();

		String env_property = System.getProperty("env.database");
		if (env_property != null)
			conn = db.getConnection(env_property);
		else
			conn = db.getConnection("demo");

		try {
			pStmt = conn.prepareStatement("DELETE FROM juror_mod.juror_pool WHERE juror_number = '" + partNo + "'");
			pStmt.execute();

			pStmt = conn.prepareStatement("DELETE FROM juror_mod.juror_history WHERE juror_number = '" + partNo + "'");
			pStmt.execute();

			pStmt = conn.prepareStatement("DELETE FROM juror_mod.juror WHERE juror_number = '" + partNo + "'");
			pStmt.execute();

			pStmt = conn.prepareStatement("DELETE FROM juror_mod.juror_response WHERE juror_number = '" + partNo + "'");
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

	public void deleteNewPoolNSD(String court) throws SQLException {
		db = new DBConnection();

		String env_property = System.getProperty("env.database");
		if (env_property != null)
			conn = db.getConnection(env_property);
		else
			conn = db.getConnection("demo");

		try {
			pStmt = conn.prepareStatement("DELETE FROM juror_mod.juror_pool WHERE juror_number in (select juror_number from juror_mod.juror_pool where pool_number in ('" + court + "111111', '" + court + "222222', '" + court + "333333', '" + court + "444444', '" + court + "999999'))");
			pStmt.execute();

			pStmt = conn.prepareStatement("DELETE FROM juror_mod.contact_log WHERE juror_number in ('6" + court + "11111', '6" + court + "22222', '6" + court + "33333', '6" + court + "44444','6" + court + "99999')");
			pStmt.execute();

			pStmt = conn.prepareStatement("DELETE FROM juror_mod.juror_history WHERE juror_number in ('6" + court + "11111', '6" + court + "22222', '6" + court + "33333', '6" + court + "44444','6" + court + "99999')");
			pStmt.execute();

			pStmt = conn.prepareStatement("DELETE FROM juror_mod.juror WHERE juror_number in ('6" + court + "11111', '6" + court + "22222', '6" + court + "33333', '6" + court + "44444','6" + court + "99999')");
			pStmt.execute();

			pStmt = conn.prepareStatement("DELETE FROM juror_mod.pool WHERE pool_no in ('" + court + "111111', '" + court + "222222', '" + court + "333333', '" + court + "444444','" + court + "999999')");
			pStmt.execute();

			pStmt = conn.prepareStatement("DELETE FROM juror_mod.juror_response WHERE juror_number in (select juror_number from juror_mod.juror_pool where pool_number in ('" + court + "111111', '" + court + "222222', '" + court + "33333', '" + court + "444444','" + court + "999999'))");
			pStmt.execute();

			pStmt = conn.prepareStatement("DELETE FROM juror_mod.bulk_print_data WHERE juror_no in (select juror_number from juror_mod.juror_pool where pool_number in ('" + court + "111111', '" + court + "222222', '" + court + "33333', '" + court + "444444','" + court + "999999'))");
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

	public void deleteNewPoolMultiStatusNSD(String court) throws SQLException {
		db = new DBConnection();

		String env_property = System.getProperty("env.database");
		if (env_property != null)
			conn = db.getConnection(env_property);
		else
			conn = db.getConnection("demo");

		try {
			pStmt = conn.prepareStatement("DELETE FROM juror_mod.juror_pool WHERE juror_number in (select juror_number from juror_mod.juror_pool where pool_number in ('" + court + "911911'))");
			pStmt.execute();

			pStmt = conn.prepareStatement("DELETE FROM juror_mod.contact_log WHERE juror_number in ('6" + court + "91101', '6" + court + "91102', '6" + court + "91103', '6" + court + "91104','6" + court + "91105','6" + court + "91106','6" + court + "91107','6" + court + "91108','6" + court + "91109','6" + court + "91110','6" + court + "91111','6" + court + "91112','6" + court + "91113')");
			pStmt.execute();

			pStmt = conn.prepareStatement("DELETE FROM juror_mod.juror_history WHERE juror_number in ('6" + court + "91101', '6" + court + "91102', '6" + court + "91103', '6" + court + "91104','6" + court + "91105','6" + court + "91106','6" + court + "91107','6" + court + "91108','6" + court + "91109','6" + court + "91110','6" + court + "91111','6" + court + "91112','6" + court + "91113')");
			pStmt.execute();

			pStmt = conn.prepareStatement("DELETE FROM juror_mod.juror WHERE juror_number in ('6" + court + "91101', '6" + court + "91102', '6" + court + "91103', '6" + court + "91104','6" + court + "91105','6" + court + "91106','6" + court + "91107','6" + court + "91108','6" + court + "91109','6" + court + "91110','6" + court + "91111','6" + court + "91112','6" + court + "91113')");
			pStmt.execute();

			pStmt = conn.prepareStatement("DELETE FROM juror_mod.pool WHERE pool_no in ('" + court + "911911')");
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


	public void deletePoolNumberNSD(String poolNumber) throws SQLException {
		db = new DBConnection();

		String env_property = System.getProperty("env.database");
		if (env_property != null)
			conn = db.getConnection(env_property);
		else
			conn = db.getConnection("demo");

		try {

			pStmt = conn.prepareStatement("DELETE FROM juror_mod.juror WHERE juror_number in (select juror_number from juror_mod.juror_pool where pool_no in ('" + poolNumber + "'))");
			pStmt.execute();

			pStmt = conn.prepareStatement("DELETE FROM juror_mod.juror_pool WHERE pool_number in ('" + poolNumber + "')");
			pStmt.execute();

			pStmt = conn.prepareStatement("DELETE FROM juror_mod.pool WHERE pool_no in ('" + poolNumber + "')");
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

	public void deleteRequestLettNSD(String court) throws SQLException {
		db = new DBConnection();

		String env_property = System.getProperty("env.database");
		if (env_property != null)
			conn = db.getConnection(env_property);
		else
			conn = db.getConnection("demo");

		try {
			pStmt = conn.prepareStatement("DELETE FROM juror_mod.bulk_print_data WHERE form_type like '5227%' and juror_no in (select juror_number from juror_mod.juror_pool where pool_number in ('" + court + "999999', '" + court + "222222', '" + court + "333333'))");
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

	public void deleteRequestLettForPartNoNSD(String part_no) throws SQLException {
		db = new DBConnection();

		String env_property = System.getProperty("env.database");
		if (env_property != null)
			conn = db.getConnection(env_property);
		else
			conn = db.getConnection("demo");

		try {
			pStmt = conn.prepareStatement("DELETE FROM juror_mod.bulk_print_data WHERE form_type like '5227%' and juror_no = '" + part_no + "'");
			pStmt.execute();

		} catch (SQLException e) {
			e.printStackTrace();
			log.error("Message:deleted request lett for juror '" + part_no + "' + e.getMessage()");
		} finally {
			conn.commit();
			pStmt.close();
			conn.close();
		}
	}

	public void deletePaperResponsesNSD() throws SQLException {
		db = new DBConnection();

		String env_property = System.getProperty("env.database");
		if (env_property != null)
			conn = db.getConnection(env_property);
		else
			conn = db.getConnection("demo");

		try {

			pStmt = conn.prepareStatement("DELETE FROM JUROR_MOD.juror_response_cjs_employment");
			pStmt.execute();

			pStmt = conn.prepareStatement("DELETE FROM JUROR_MOD.juror_response_aud");
			pStmt.execute();

			pStmt = conn.prepareStatement("DELETE FROM JUROR_MOD.juror_reasonable_adjustment");
			pStmt.execute();

			pStmt = conn.prepareStatement("DELETE FROM JUROR_MOD.USER_JUROR_RESPONSE_AUDIT");
			pStmt.execute();

			pStmt = conn.prepareStatement("DELETE FROM JUROR_MOD.JUROR_RESPONSE");
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

	public String getTodaysDateEEEddMMMyyyyNSD() {
		String datePattern = "EEE d MMM yyyy";
		Calendar calendar = Calendar.getInstance();
		return new SimpleDateFormat(datePattern).format((calendar).getTime());
	}

	public void insertNewPoolWithDeferralNSD(String court, String noWeeks) throws SQLException {
		db = new DBConnection();

		String env_property = System.getProperty("env.database");

		if (env_property != null)
			conn = db.getConnection(env_property);
		else
			conn = db.getConnection("demo");

		try {
			Calendar calendar = Calendar.getInstance();
			calendar.add(Calendar.WEEK_OF_MONTH, Integer.parseInt(noWeeks));
			LocalDate localDate = calendar.toInstant().atZone(ZoneId.systemDefault()).toLocalDate();

			String poolNumber = court + "111111";
			String jurorNumber = "6" + court + "11111";

			pStmt = conn.prepareStatement("DELETE FROM juror_mod.juror_pool WHERE pool_number = ?");
			pStmt.setString(1, poolNumber);
			pStmt.executeUpdate();

			pStmt = conn.prepareStatement("DELETE FROM juror_mod.juror_pool WHERE juror_number = ?");
			pStmt.setString(1, jurorNumber);
			pStmt.executeUpdate();

			pStmt = conn.prepareStatement("DELETE FROM juror_mod.pool WHERE pool_no = ?");
			pStmt.setString(1, poolNumber);
			pStmt.executeUpdate();

			pStmt = conn.prepareStatement("DELETE FROM juror_mod.juror WHERE juror_number = ?");
			pStmt.setString(1, jurorNumber);
			pStmt.executeUpdate();

			pStmt = conn.prepareStatement(
					"INSERT INTO juror_mod.pool (pool_no, owner, return_date, no_requested, pool_type, loc_code, new_request, last_update, additional_summons, attend_time, total_no_required, date_created) " +
							"VALUES (?, ?, ?, 5, 'CRO', ?, 'T', NOW(), null, TIMESTAMP '2022-04-01 09:30:00.0', 5, NOW())");
			pStmt.setString(1, poolNumber);
			pStmt.setString(2, court);
			pStmt.setObject(3, localDate);
			pStmt.setString(4, court);
			pStmt.executeUpdate();

			pStmt = conn.prepareStatement(
					"INSERT INTO juror_mod.juror (juror_number, poll_number, title, last_name, first_name, dob, address_line_1, address_line_2, address_line_3, address_line_4, address_line_5, postcode, h_phone, w_phone, w_ph_local, responded, date_excused, excusal_code, acc_exc, date_disq, disq_code, user_edtq, notes, no_def_pos, perm_disqual, reasonable_adj_code, reasonable_adj_msg, sort_code, bank_acct_name, bank_acct_no, bldg_soc_roll_no, welsh, police_check, last_update, summons_file, m_phone, h_email, contact_preference, notifications, date_created, optic_reference, pending_title, pending_first_name, pending_last_name) " +
							"VALUES (?, '857', null, 'lname', 'fname', null, 'address', null, null, null, null, 'CH2 2AA', null, null, null, 'Y', null, null, null, null, null, null, null, '1', null, null, null, null, null, null, null, 'N', 'NOT_CHECKED', null, null, null, null, null, '0', null, null, null, null, null)");
			pStmt.setString(1, jurorNumber);
			pStmt.executeUpdate();

			pStmt = conn.prepareStatement(
					"INSERT INTO juror_mod.juror_pool (juror_number, pool_number, owner, user_edtq, is_active, status, times_sel, def_date, location, no_attendances, no_attended, no_fta, no_awol, pool_seq, edit_tag, next_date, on_call, was_deferred, deferral_code, id_checked, postpone, paid_cash, scan_code, last_update, reminder_sent, transfer_date, date_created) " +
							"VALUES (?, ?, ?, null, 'Y', '7', null, ?, '415', '0', null, null, null, null, null, ?, false, 'Y', 'O', null, null, null, null, CURRENT_DATE, null, null, CURRENT_DATE)");
			pStmt.setString(1, jurorNumber);
			pStmt.setString(2, poolNumber);
			pStmt.setString(3, court);
			pStmt.setObject(4, localDate);
			pStmt.setObject(5, localDate);
			pStmt.executeUpdate();

		} catch (SQLException e) {
			e.printStackTrace();
			log.error("Message:inserted new pool" + e.getMessage());
		} finally {
			conn.commit();
			pStmt.close();
			conn.close();
		}
	}

	public void insertCourtPoolWithDeferralNSD(String court, String pool_no, String part_no, String no_weeks) throws SQLException {
		db = new DBConnection();

		String datePattern = "yyyy-MM-dd";
		Calendar calendar = Calendar.getInstance();
		calendar.add(Calendar.WEEK_OF_MONTH, Integer.parseInt(no_weeks));

		LocalDate localDate = calendar.toInstant().atZone(ZoneId.systemDefault()).toLocalDate();
		Date mondayDate = Date.from(localDate.atStartOfDay().atZone(ZoneId.systemDefault()).toInstant());

		String expectedDate = new SimpleDateFormat(datePattern).format((mondayDate).getTime());
		String env_property = System.getProperty("env.database");

		if (env_property != null)
			conn = db.getConnection(env_property);
		else
			conn = db.getConnection("demo");

		try {
			if (getCountFromUniquePoolNSD(pool_no) == 0) {
				pStmt = conn.prepareStatement(
						"INSERT INTO juror_mod.pool (pool_no, owner, return_date, no_requested, pool_type, loc_code, new_request, last_update, additional_summons, attend_time, total_no_required, date_created) " +
								"VALUES (?, ?, ?, '5', 'CRO', ?, 'T', NOW(), NULL, TIMESTAMP '2022-04-01 09:30:00.0', '5', NOW())"
				);
				pStmt.setString(1, pool_no);
				pStmt.setString(2, court);
				pStmt.setDate(3, new java.sql.Date(mondayDate.getTime()));
				pStmt.setString(4, court);
				pStmt.execute();
			}

			if (getCountFromPoolNSD(part_no, pool_no) == 0) {
				pStmt = conn.prepareStatement(
						"INSERT INTO juror_mod.juror (juror_number, poll_number, title, last_name, first_name, dob, address_line_1, address_line_2, address_line_3, address_line_4, address_line_5, postcode, h_phone, w_phone, w_ph_local, responded, date_excused, excusal_code, acc_exc, date_disq, disq_code, user_edtq, notes, no_def_pos, perm_disqual, reasonable_adj_code, reasonable_adj_msg, completion_date, sort_code, bank_acct_name, bank_acct_no, bldg_soc_roll_no, welsh, police_check, last_update, summons_file, m_phone, h_email, contact_preference, notifications, date_created, optic_reference, pending_title, pending_first_name, pending_last_name) " +
								"VALUES (?, '857', NULL, 'lname', 'fname', NULL, 'address', NULL, NULL, NULL, NULL, 'CH1 2NN', NULL, NULL, NULL, 'Y', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N', NULL, NULL, NULL, NULL, NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL)"
				);
				pStmt.setString(1, part_no);
				pStmt.execute();
			}

			if (getCountFromJurorPoolNSD(part_no, pool_no) == 0) {
				pStmt = conn.prepareStatement(
						"INSERT INTO juror_mod.juror_pool (juror_number, pool_number, owner, user_edtq, is_active, status, times_sel, def_date, mileage, location, no_attendances, no_attended, no_fta, no_awol, pool_seq, edit_tag, next_date, on_call, amt_spent, was_deferred, deferral_code, id_checked, postpone, paid_cash, travel_time, scan_code, financial_loss, last_update, reminder_sent, transfer_date, date_created) " +
								"VALUES (?, ?, ?, NULL, TRUE, '2', NULL, CURRENT_DATE - 10, NULL, ?, '0', NULL, NULL, NULL, NULL, NULL, CURRENT_DATE - 10, FALSE, NULL, NULL, 'Y', NULL, NULL, NULL, NULL, NULL, CURRENT_DATE, NULL, NULL, CURRENT_DATE)"
				);
				pStmt.setString(1, part_no);
				pStmt.setString(2, pool_no);
				pStmt.setString(3, court);
				pStmt.setString(4, court);
				pStmt.execute();
			}

			pStmt = conn.prepareStatement("UPDATE juror_mod.pool SET owner = ? WHERE pool_no = ?");
			pStmt.setString(1, court);
			pStmt.setString(2, pool_no);
			pStmt.execute();

			pStmt = conn.prepareStatement(
					"UPDATE juror_mod.juror_pool SET transfer_date = CURRENT_DATE, is_active = 'Y', owner = ?, next_date = ?, status = '7', was_deferred = 'Y', deferral_code = 'O', def_date = ?, pool_number = ? WHERE juror_number = ?"
			);
			pStmt.setString(1, court);
			pStmt.setDate(2, new java.sql.Date(mondayDate.getTime()));
			pStmt.setDate(3, new java.sql.Date(mondayDate.getTime()));
			pStmt.setString(4, pool_no);
			pStmt.setString(5, part_no);
			pStmt.execute();

			pStmt = conn.prepareStatement("UPDATE juror_mod.juror SET responded = 'Y', no_def_pos = '1' WHERE juror_number = ?");
			pStmt.setString(1, part_no);
			pStmt.execute();

		} catch (SQLException e) {
			e.printStackTrace();
			log.error("Message:inserted new pool" + e.getMessage());
		} finally {
			conn.commit();
			if (pStmt != null) pStmt.close();
			conn.close();
		}
	}

	public void clearDeferralsForWeeksAndCourtNSD(int noWeeks, String court) throws SQLException {
		db = new DBConnection();

		String env_property = System.getProperty("env.database");

		if (env_property != null)
			conn = db.getConnection(env_property);
		else
			conn = db.getConnection("demo");

		try {
			int numberOfDays = noWeeks * 7;

			pStmt = conn.prepareStatement("update juror_mod.juror_pool set status='2' where is_active='Y' and status='7' and owner= '" + court + "' and def_date  =CURRENT_DATE+" + numberOfDays);
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

	public void insertCourtPoolWithDeferralExistingJurorNSD(String court, String pool_no, String part_no, String no_weeks, String loc_code) throws SQLException {
		db = new DBConnection();

		String env_property = System.getProperty("env.database");

		if (env_property != null)
			conn = db.getConnection(env_property);
		else
			conn = db.getConnection("demo");

		try {
			String datePattern = "YYYY-MM-DD";
			Calendar calendar = Calendar.getInstance();
			calendar.add(Calendar.WEEK_OF_MONTH, Integer.parseInt(no_weeks));

			LocalDate localDate = calendar.toInstant().atZone(ZoneId.systemDefault()).toLocalDate();
			Date mondayDate = Date.from(localDate.atStartOfDay().atZone(ZoneId.systemDefault()).toInstant());

			String expectedDate = new SimpleDateFormat(datePattern).format((mondayDate));

			pStmt = conn.prepareStatement("update juror_mod.juror_pool set OWNER='" + court + "', NEXT_DATE='" + mondayDate + "',STATUS='7',WAS_DEFERRED='Y', DEFERRAL_CODE='O', DEF_DATE='" + mondayDate + "' where juror_number='" + part_no + "'");
			pStmt.execute();

			pStmt = conn.prepareStatement("update juror_mod.juror set RESPONDED='Y', NO_DEF_POS='1' where juror_number='" + part_no + "'");
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

	public void insertNewPoolCompletedPoolNSD(String court) throws SQLException {
		db = new DBConnection();

		String env_property = System.getProperty("env.database");

		if (env_property != null)
			conn = db.getConnection(env_property);
		else
			conn = db.getConnection("demo");

		try {

			pStmt = conn.prepareStatement("Insert into juror_mod.pool (pool_no, owner, return_date, no_requested, pool_type, loc_code, new_request, last_update, additional_summons, attend_time, total_no_required, date_created)"
					+ "values ('" + court + "111111','" + court + "',CURRENT_DATE-10,'5','CRO','" + court + "','N',NOW(),null,TIMESTAMP'2022-04-01 09:30:00.0','5',NOW())");
			pStmt.execute();

			pStmt = conn.prepareStatement("insert into juror_mod.juror (juror_number,poll_number,title,last_name,first_name,dob,ADDRESS_LINE_1,ADDRESS_LINE_2,ADDRESS_LINE_3,ADDRESS_LINE_4,ADDRESS_LINE_5,POSTCODE,h_phone,w_phone,w_ph_local,responded,date_excused,excusal_code,acc_exc,date_disq,disq_code,user_edtq,notes,no_def_pos,perm_disqual,reasonable_adj_code,reasonable_adj_msg,sort_code,bank_acct_name,bank_acct_no,bldg_soc_roll_no,welsh,police_check,last_update,summons_file,m_phone,h_email,contact_preference,notifications,date_created,optic_reference,pending_title,pending_first_name,pending_last_name)"
					+ "values ('6" + court + "11111','857',null,'lname','fname',null,'address',null,null,null,null,'CH1 2NN',null,null,null,'Y',null,null,null,null,null,null,null,'1',null,null,null,null,null,null,null,'N','NOT_CHECKED',null,null,null,null,null,'0',null,null,null,null,null)");
			pStmt.execute();

			pStmt = conn.prepareStatement("insert into juror_mod.juror_pool (juror_number,pool_number,owner,user_edtq,is_active,status,times_sel,def_date,location,no_attendances,no_attended,no_fta,no_awol,pool_seq,edit_tag,next_date,on_call,was_deferred,deferral_code,id_checked,postpone,paid_cash,scan_code,last_update,reminder_sent,transfer_date,date_created)"
					+ "values ('6" + court + "11111','" + court + "111111','" + court + "',null,true,'13',null,CURRENT_DATE-10,'" + court + "','0',null,null,null,null,null,CURRENT_DATE-10,false,'Y','O',null,null,null,null,CURRENT_DATE,null,null,CURRENT_DATE)");
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

	public void insertJurorWithDeferralIntoPoolNSD(String poolNo, String court, String noWeeks, String jurorPartNo) throws SQLException {
		db = new DBConnection();

		String env_property = System.getProperty("env.database");

		if (env_property != null)
			conn = db.getConnection(env_property);
		else
			conn = db.getConnection("demo");

		try {
			String datePattern = "YYYY-MM-DD";
			Calendar calendar = Calendar.getInstance();
			calendar.add(Calendar.WEEK_OF_MONTH, Integer.parseInt(noWeeks));

			LocalDate localDate = calendar.toInstant().atZone(ZoneId.systemDefault()).toLocalDate();
			Date mondayDate = Date.from(localDate.atStartOfDay().atZone(ZoneId.systemDefault()).toInstant());

			String expectedDate = new SimpleDateFormat(datePattern).format((mondayDate).getTime());

//			#insert the pool, juror_pool and juror rows
			pStmt = conn.prepareStatement("Insert into juror_mod.pool (pool_no, owner, return_date, no_requested, pool_type, loc_code, new_request, last_update, additional_summons, attend_time, total_no_required, date_created)"
					+ "values ('" + poolNo + "','" + court + "','" + expectedDate + "','5','CRO','" + court + "','T',NOW(),null,TIMESTAMP'2022-04-01 09:30:00.0','5',NOW())");
			pStmt.execute();

			pStmt = conn.prepareStatement("insert into juror_mod.juror (juror_number,poll_number,title,last_name,first_name,dob,ADDRESS_LINE_1,ADDRESS_LINE_2,ADDRESS_LINE_3,ADDRESS_LINE_4,ADDRESS_LINE_5,POSTCODE,h_phone,w_phone,w_ph_local,responded,date_excused,excusal_code,acc_exc,date_disq,disq_code,user_edtq,notes,no_def_pos,perm_disqual,reasonable_adj_code,reasonable_adj_msg,sort_code,bank_acct_name,bank_acct_no,bldg_soc_roll_no,welsh,police_check,last_update,summons_file,m_phone,h_email,contact_preference,notifications,date_created,optic_reference,pending_title,pending_first_name,pending_last_name)"
					+ "values ('" + jurorPartNo + "','857',null,'lname','fname',null,'address',null,null,null,null,'CH1 2NN',null,null,null,'Y',null,null,null,null,null,null,null,'1',null,null,null,null,null,null,null,'N',null,null,null,null,null,null,'0',null,null,null,null,null)");
			pStmt.execute();

			pStmt = conn.prepareStatement("insert into juror_mod.juror_pool (juror_number,pool_number,owner,user_edtq,is_active,status,times_sel,def_date,mileage,location,no_attendances,no_attended,no_fta,no_awol,pool_seq,edit_tag,next_date,on_call,amt_spent,was_deferred,deferral_code,id_checked,postpone,paid_cash,travel_time,scan_code,financial_loss,last_update,reminder_sent,transfer_date,date_created)"
					+ "values ('" + jurorPartNo + "','" + poolNo + "','" + court + "',null,'Y','2',null,'" + expectedDate + "',null,'415','0',null,null,null,null,'N',null,false,null,null,'Y',null,null,null,null,null,null,CURRENT_DATE,null,null,CURRENT_DATE)");
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

	public void insertNewPoolTransferredToCourtNewNSD(String court, String partNumber, String poolNumber) throws SQLException {
		db = new DBConnection();

		String env_property = System.getProperty("env.database");

		if (env_property != null)
			conn = db.getConnection(env_property);
		else
			conn = db.getConnection("demo");

		try {

			pStmt = conn.prepareStatement("UPDATE JUROR_MOD.JUROR_POOL SET OWNER='" + court + "' WHERE POOL_NUMBER = '" + poolNumber + "' AND JUROR_NUMBER='" + partNumber + "' AND OWNER = '400'");
			pStmt.execute();

			pStmt = conn.prepareStatement("UPDATE JUROR_MOD.JUROR SET BUREAU_TRANSFER_DATE = CURRENT_DATE-1 WHERE JUROR_NUMBER='" + partNumber + "'");
			pStmt.execute();

			pStmt = conn.prepareStatement("UPDATE JUROR_MOD.POOL SET OWNER='" + court + "' WHERE POOL_NO = '" + poolNumber + "' AND OWNER = '400'");
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

	public void insertNewPoolNSD(String court) throws SQLException {
		db = new DBConnection();

		String env_property = System.getProperty("env.database");

		if (env_property != null)
			conn = db.getConnection(env_property);
		else
			conn = db.getConnection("demo");

		try {

			pStmt = conn.prepareStatement("Insert into juror_mod.pool (pool_no, owner, return_date, no_requested, pool_type, loc_code, new_request, last_update, additional_summons, attend_time, total_no_required, date_created)"
					+ "values ('" + court + "222222','" + court + "',CURRENT_DATE+10,'5','CRO','" + court + "','N',NOW(),null,TIMESTAMP'2022-04-01 09:30:00.0','5',NOW())");
			pStmt.execute();

			pStmt = conn.prepareStatement("insert into juror_mod.juror (juror_number,poll_number,title,last_name,first_name,dob,ADDRESS_LINE_1,ADDRESS_LINE_2,ADDRESS_LINE_3,ADDRESS_LINE_4,ADDRESS_LINE_5,POSTCODE,h_phone,w_phone,w_ph_local,responded,date_excused,excusal_code,acc_exc,date_disq,disq_code,user_edtq,notes,no_def_pos,perm_disqual,reasonable_adj_code,reasonable_adj_msg,sort_code,bank_acct_name,bank_acct_no,bldg_soc_roll_no,welsh,police_check,last_update,summons_file,m_phone,h_email,contact_preference,notifications,date_created,optic_reference,pending_title,pending_first_name,pending_last_name)"
					+ "values ('6" + court + "22222','857',null,'lname','fname',null,'address',null,null,null,null,'CH1 2NN',null,null,null,'N',null,null,null,null,null,null,null,'0',null,null,null,null,null,null,null,'N',null,null,null,null,null,null,'0',null,null,null,null,null)");
			pStmt.execute();

			pStmt = conn.prepareStatement("insert into juror_mod.juror_pool (juror_number,pool_number,owner,user_edtq,is_active,status,times_sel,def_date,mileage,location,no_attendances,no_attended,no_fta,no_awol,pool_seq,edit_tag,next_date,on_call,amt_spent,was_deferred,deferral_code,id_checked,postpone,paid_cash,travel_time,scan_code,financial_loss,last_update,reminder_sent,transfer_date,date_created)"
					+ "values ('6" + court + "22222','" + court + "222222','" + court + "',null,'Y','2',null,null,null,'" + court + "','0',null,null,null,null,null,CURRENT_DATE+10,false,'N',null,'N',null,null,null,null,null,null,CURRENT_DATE,null,null,CURRENT_DATE)");
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


	public void insertNewPaperSummonsReplyNSD(String newJurorRecordNumber, String poolNo) throws SQLException {
		insertNewPaperSummonsReplyWithResponseNameNSD(newJurorRecordNumber, "Andy", "Marshall", poolNo);
	}

	public void insertNewPaperSummonsReplyWithResponseNameNSD(String newJurorRecordNumber, String firstName, String lastName, String poolNo) throws SQLException {
		db = new DBConnection();

		String env_property = System.getProperty("env.database");

		if (env_property != null)
			conn = db.getConnection(env_property);
		else
			conn = db.getConnection("demo");

		try {
			pStmt = conn.prepareStatement("Insert into juror_mod.pool (pool_no, owner, return_date, no_requested, pool_type, loc_code, new_request, last_update, additional_summons, attend_time, total_no_required, date_created)"
					+ "values ('" + poolNo + "','400',CURRENT_DATE+112,'5','CRO','415','N',NOW(),null,TIMESTAMP'2022-04-01 09:30:00.0','5',NOW())");
			pStmt.execute();

			pStmt = conn.prepareStatement("insert into juror_mod.juror (juror_number,poll_number,title,last_name,first_name,dob,ADDRESS_LINE_1,ADDRESS_LINE_2,ADDRESS_LINE_3,ADDRESS_LINE_4,ADDRESS_LINE_5,POSTCODE,h_phone,w_phone,w_ph_local,responded,date_excused,excusal_code,acc_exc,date_disq,disq_code,user_edtq,notes,no_def_pos,perm_disqual,reasonable_adj_code,reasonable_adj_msg,sort_code,bank_acct_name,bank_acct_no,bldg_soc_roll_no,welsh,police_check,last_update,summons_file,m_phone,h_email,contact_preference,notifications,date_created,optic_reference,pending_title,pending_first_name,pending_last_name)"
					+ "values ('" + newJurorRecordNumber + "','857',null,'lname','fname',null,'address',null,null,null,null,'CH1 2NN',null,null,null,'N',null,null,null,null,null,null,null,'1',null,null,null,null,null,null,null,'N',null,null,null,null,null,null,'0',null,null,null,null,null)");
			pStmt.execute();

			pStmt = conn.prepareStatement("insert into juror_mod.juror_pool (juror_number,pool_number,owner,user_edtq,is_active,status,times_sel,def_date,mileage,location,no_attendances,no_attended,no_fta,no_awol,pool_seq,edit_tag,next_date,on_call,amt_spent,was_deferred,deferral_code,id_checked,postpone,paid_cash,travel_time,scan_code,financial_loss,last_update,reminder_sent,transfer_date,date_created)"
					+ "values ('" + newJurorRecordNumber + "','" + poolNo + "','400',null,'Y','7',null,CURRENT_DATE,null,'415','0',null,null,null,null,null,CURRENT_DATE,false,null,null,'Y',null,null,null,null,null,null,CURRENT_DATE,null,null,CURRENT_DATE)");
			pStmt.execute();

			// Insert the Response into JUROR_MOD.JUROR_RESPONSE
			pStmt = conn.prepareStatement("INSERT INTO JUROR_mod.JUROR_RESPONSE (JUROR_NUMBER,DATE_RECEIVED,TITLE,FIRST_NAME,LAST_NAME,ADDRESS_LINE_1,ADDRESS_LINE_2,ADDRESS_LINE_3,ADDRESS_LINE_4,ADDRESS_LINE_5,POSTCODE,PROCESSING_STATUS,DATE_OF_BIRTH,PHONE_NUMBER,ALT_PHONE_NUMBER,EMAIL,RESIDENCY,RESIDENCY_DETAIL,MENTAL_HEALTH_ACT,MENTAL_HEALTH_CAPACITY,MENTAL_HEALTH_ACT_DETAILS,BAIL,BAIL_DETAILS,CONVICTIONS,CONVICTIONS_DETAILS,DEFERRAL,DEFERRAL_REASON,DEFERRAL_DATE,REASONABLE_ADJUSTMENTS_ARRANGEMENTS,EXCUSAL,EXCUSAL_REASON,PROCESSING_COMPLETE,SIGNED,version,THIRDPARTY_FNAME,THIRDPARTY_LNAME,RELATIONSHIP,MAIN_PHONE,OTHER_PHONE,EMAIL_ADDRESS,THIRDPARTY_REASON,THIRDPARTY_OTHER_REASON,JUROR_PHONE_DETAILS,JUROR_EMAIL_DETAILS,STAFF_LOGIN,STAFF_ASSIGNMENT_DATE,URGENT,COMPLETED_AT,WELSH,REPLY_TYPE)"
					+ "VALUES ('" + newJurorRecordNumber + "',CURRENT_DATE-1,'Mr','" + firstName + "','" + lastName + "','7 Poppy Square','New Theo','','','','W1 1AB','TODO',CURRENT_DATE-10000,null,null,null,'Y',null,'N','N',NULL,'N',null,'N',null,null,null,null,null,null,null,'N','N','0',null,null,null,null,null,null,null,null,null,null,'MODTESTBUREAU',null,'N',null,'N','Paper')");
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

	public void insertNewSummonsReplyNSD(String newJurorRecordNumber) throws SQLException {
		db = new DBConnection();

		String env_property = System.getProperty("env.database");

		if (env_property != null)
			conn = db.getConnection(env_property);
		else
			conn = db.getConnection("demo");

		try {
			pStmt = conn.prepareStatement("Insert into juror_mod.pool (pool_no, owner, return_date, no_requested, pool_type, loc_code, new_request, last_update, additional_summons, attend_time, total_no_required, date_created)"
					+ "values ('415230501','400',CURRENT_DATE+112,'5','CRO','415','N',NOW(),null,TIMESTAMP'2022-04-01 09:30:00.0','5',NOW())");
			pStmt.execute();

			pStmt = conn.prepareStatement("insert into juror_mod.juror (juror_number,poll_number,title,last_name,first_name,dob,ADDRESS_LINE_1,ADDRESS_LINE_2,ADDRESS_LINE_3,ADDRESS_LINE_4,ADDRESS_LINE_5,POSTCODE,h_phone,w_phone,w_ph_local,responded,date_excused,excusal_code,acc_exc,date_disq,disq_code,user_edtq,notes,no_def_pos,perm_disqual,reasonable_adj_code,reasonable_adj_msg,sort_code,bank_acct_name,bank_acct_no,bldg_soc_roll_no,welsh,police_check,last_update,summons_file,m_phone,h_email,contact_preference,notifications,date_created,optic_reference,pending_title,pending_first_name,pending_last_name)"
					+ "values ('" + newJurorRecordNumber + "','857',null,'lname','fname',null,'address',null,null,null,null,null,'CH1 2NN',null,null,'N',null,null,null,null,null,null,null,'1',null,null,null,null,null,null,null,'N',null,null,null,null,null,null,'0',null,null,null,null,null)");
			pStmt.execute();

			pStmt = conn.prepareStatement("insert into juror_mod.juror_pool (juror_number,pool_number,owner,user_edtq,is_active,status,times_sel,def_date,mileage,location,no_attendances,no_attended,no_fta,no_awol,pool_seq,edit_tag,next_date,on_call,amt_spent,was_deferred,deferral_code,id_checked,postpone,paid_cash,travel_time,scan_code,financial_loss,last_update,reminder_sent,transfer_date,date_created)"
					+ "values ('" + newJurorRecordNumber + "','415230501','400',null,'Y','7',null,CURRENT_DATE,null,'415','0',null,null,null,null,null,CURRENT_DATE,false,null,null,'Y',null,null,null,null,null,null,CURRENT_DATE,null,null,CURRENT_DATE)");
			pStmt.execute();

			// Insert the Response into JUROR_MOD.JUROR_RESPONSE
			pStmt = conn.prepareStatement("INSERT INTO JUROR_mod.JUROR_RESPONSE (JUROR_NUMBER,DATE_RECEIVED,TITLE,FIRST_NAME,LAST_NAME,ADDRESS_LINE_1,ADDRESS_LINE_2,ADDRESS_LINE_3,ADDRESS_LINE_4,ADDRESS_LINE_5,POSTCODE,PROCESSING_STATUS,DATE_OF_BIRTH,PHONE_NUMBER,ALT_PHONE_NUMBER,EMAIL,RESIDENCY,RESIDENCY_DETAIL,MENTAL_HEALTH_ACT,MENTAL_HEALTH_CAPACITY,MENTAL_HEALTH_ACT_DETAILS,BAIL,BAIL_DETAILS,CONVICTIONS,CONVICTIONS_DETAILS,DEFERRAL,DEFERRAL_REASON,DEFERRAL_DATE,REASONABLE_ADJUSTMENTS_ARRANGEMENTS,EXCUSAL,EXCUSAL_REASON,PROCESSING_COMPLETE,SIGNED,version,THIRDPARTY_FNAME,THIRDPARTY_LNAME,RELATIONSHIP,MAIN_PHONE,OTHER_PHONE,EMAIL_ADDRESS_LINE_1,THIRDPARTY_REASON,THIRDPARTY_OTHER_REASON,JUROR_PHONE_DETAILS,JUROR_EMAIL_DETAILS,STAFF_LOGIN,STAFF_ASSIGNMENT_DATE,URGENT,COMPLETED_AT,WELSH,REPLY_TYPE)"
					+ "VALUES ('" + newJurorRecordNumber + "',CURRENT_DATE-1,'Mr','Fname','Lname','7 Poppy Square','New Theo','','','','W1 1AB','TODO',CURRENT_DATE-10000,null,null,null,'Y',null,'N','N',NULL,'N',null,'N',null,null,null,null,null,null,null,'N','N','0',null,null,null,null,null,null,null,null,null,null,'MODTESTBUREAU',null,'N',null,'N','Digital')");
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

	public void deleteNewPaperSummonsReplyNSD(String createdJurorRecordNumber) throws SQLException {
		db = new DBConnection();

		String env_property = System.getProperty("env.database");

		if (env_property != null)
			conn = db.getConnection(env_property);
		else
			conn = db.getConnection("demo");

		try {

			pStmt = conn.prepareStatement("DELETE FROM JUROR_MOD.JUROR_POOL WHERE JUROR_NUMBER = '" + createdJurorRecordNumber + "'");
			pStmt.execute();

			pStmt = conn.prepareStatement("DELETE FROM JUROR_MOD.POOL WHERE POOL_NO IN (SELECT POOL_NO FROM JUROR_MOD.JUROR_POOL WHERE JUROR_NUMBER = '" + createdJurorRecordNumber + "')");
			pStmt.execute();

			pStmt = conn.prepareStatement("DELETE FROM JUROR_MOD.JUROR WHERE JUROR_NUMBER = '" + createdJurorRecordNumber + "'");
			pStmt.execute();

			//Delete the specified paper response from Juror_Digital.Paper_Response
			pStmt = conn.prepareStatement("DELETE FROM JUROR_MOD.JUROR_RESPONSE WHERE JUROR_NUMBER = '" + createdJurorRecordNumber + "'");
			pStmt.execute();

		} catch (SQLException e) {
			e.printStackTrace();
			log.error("Message:deleted new juror and juror_response records with the juror_number of " + createdJurorRecordNumber + " respectively - " + e.getMessage());
		} finally {
			conn.commit();
			pStmt.close();
			conn.close();
		}
	}




	public void insertHolidayInTheFutureNSD(Integer noOfWeeks, String owner) throws SQLException {
		db = new DBConnection();

		String env_property = System.getProperty("env.database");

		if (env_property != null)
			conn = db.getConnection(env_property);
		else
			conn = db.getConnection("demo");

		LocalDate localDate = LocalDate.now().plusWeeks(noOfWeeks);

		holidayDate = localDate.toString();
		holidayOwner = owner;

		try {
			pStmt = conn.prepareStatement(
					"INSERT INTO JUROR_MOD.HOLIDAY(LOC_CODE, HOLIDAY, DESCRIPTION, PUBLIC) VALUES (?, ?, ?, ?)"
			);
			pStmt.setString(1, owner);
			pStmt.setDate(2, java.sql.Date.valueOf(localDate));
			pStmt.setString(3, "Test holiday");
			pStmt.setBoolean(4, false);

			pStmt.executeUpdate();
			conn.commit();

			log.info("Successfully inserted holiday for owner: " + owner + " on date: " + localDate);

		} catch (SQLException e) {
			log.error("Message: failed to insert bank holiday for date: " + localDate, e);
			throw e;

		} finally {
			conn.commit();
			pStmt.close();
			conn.close();
		}
	}

	public void insertHolidayMondayInTheFutureNSD(Integer noOfWeeks, String owner) throws SQLException {
		db = new DBConnection();

		String env_property = System.getProperty("env.database");

		if (env_property != null)
			conn = db.getConnection(env_property);
		else
			conn = db.getConnection("demo");

		String datePattern = "YYYY-MM-DD";
		Calendar calendar = Calendar.getInstance();
		calendar.add(Calendar.WEEK_OF_MONTH, noOfWeeks);

		LocalDate localDate = calendar.toInstant().atZone(ZoneId.systemDefault()).toLocalDate();
		LocalDate localDateMonday = localDate.with(TemporalAdjusters.next(DayOfWeek.MONDAY));

		Date mondayDate = Date.from(localDateMonday.atStartOfDay().atZone(ZoneId.systemDefault()).toInstant());

		holidayDate = String.valueOf(localDateMonday);
		holidayOwner = owner;

		try {

			pStmt = conn.prepareStatement("INSERT INTO JUROR_MOD.HOLIDAY(LOC_CODE,HOLIDAY,DESCRIPTION,PUBLIC)"
					+ "VALUES ('" + owner + "','" + localDateMonday + "','Test holiday', 'N')");
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

	public void clean_pool_requestsNSD() throws SQLException {
		db = new DBConnection();

		String env_property = System.getProperty("env.database");

		if (env_property != null)
			conn = db.getConnection(env_property);
		else
			conn = db.getConnection("demo");

		try {

			pStmt = conn.prepareStatement("DELETE FROM JUROR_MOD.POOL WHERE LAST_UPDATE <CURRENT_DATE AND POOL_NO NOT IN (SELECT POOL_NUMBER FROM JUROR_MOD.JUROR_POOL)");
			pStmt.execute();

		} catch (SQLException e) {
			e.printStackTrace();
			log.error("Message:deleted new pool records with no associated pool records with creation date <today" + e.getMessage());
		} finally {
			conn.commit();
			pStmt.close();
			conn.close();
		}
	}

	public void clean_coroners_pool_requestsNSD() throws SQLException {
		db = new DBConnection();

		String env_property = System.getProperty("env.database");

		if (env_property != null)
			conn = db.getConnection(env_property);
		else
			conn = db.getConnection("demo");

		try {

			pStmt = conn.prepareStatement("DELETE FROM JUROR_mod.CORONER_POOL_DETAIL WHERE COR_POOL_NO IN (SELECT COR_POOL_NO FROM JUROR_mod.CORONER_POOL WHERE COR_REQUEST_DT <CURRENT_DATE)");
			pStmt.execute();

			pStmt = conn.prepareStatement("DELETE FROM JUROR_MOD.CORONER_POOL WHERE COR_REQUEST_DT <CURRENT_DATE");
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

	public void deleteHolidayNSD() throws SQLException {
		db = new DBConnection();

		String env_property = System.getProperty("env.database");

		if (env_property != null)
			conn = db.getConnection(env_property);
		else
			conn = db.getConnection("demo");

		try {

			pStmt = conn.prepareStatement("DELETE FROM JUROR_MOD.HOLIDAY WHERE LOC_CODE='" + holidayOwner + "' AND HOLIDAY='" + holidayDate + "'");
			pStmt.executeUpdate();


		} catch (SQLException e) {
			e.printStackTrace();
			log.error("Message:deleted bank holiday for '" + holidayOwner + "' on '" + holidayDate + "' " + e.getMessage());
		} finally {
			conn.commit();
			pStmt.close();
			conn.close();
		}
	}

	public void deleteAllHolidaysNSD() throws SQLException {
		db = new DBConnection();

		String env_property = System.getProperty("env.database");

		if (env_property != null)
			conn = db.getConnection(env_property);
		else
			conn = db.getConnection("demo");

		try {

			pStmt = conn.prepareStatement("DELETE FROM JUROR_MOD.HOLIDAY");
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

	public void clean_modernisation_dataNSD() throws SQLException {
		db = new DBConnection();
		String env_property = System.getProperty("env.database");
		if (env_property != null)
			conn = db.getConnection(env_property);
		else
			conn = db.getConnection("demo");
		try {


			pStmt = conn.prepareStatement("delete from juror_mod.user_roles where username IN ('MODTESTBUREAU','MODTESTCOURT','MODCOURT', 'MODBUREAUOFFICER', 'AUTO', 'TeamPickListUser', 'AutomationStaffMembe', 'CPASS', 'SYSTEM', 'SJOUSER1', 'ARAMIS1', 'NEWUSER')");
			pStmt.executeQuery();
			log.info("Delete all JUROR_MOD.USER_ROLES rows where username IN ('MODTESTBUREAU','MODTESTCOURT','MODCOURT', 'MODBUREAUOFFICER', 'AUTO', 'TeamPickListUser', 'AutomationStaffMembe', 'CPASS', 'SYSTEM', 'SJOUSER1', 'ARAMIS1', 'NEWUSER')");

			pStmt = conn.prepareStatement("delete from juror_mod.user_courts where username IN ('MODTESTBUREAU','MODTESTCOURT','MODCOURT', 'MODBUREAUOFFICER', 'AUTO', 'TeamPickListUser', 'AutomationStaffMembe', 'CPASS', 'SYSTEM', 'SJOUSER1', 'ARAMIS1', 'NEWUSER')");
			pStmt.executeQuery();
			log.info("Delete all JUROR_MOD.USER_COURTS rows where username IN ('MODTESTBUREAU','MODTESTCOURT','MODCOURT', 'MODBUREAUOFFICER', 'AUTO', 'TeamPickListUser', 'AutomationStaffMembe', 'CPASS', 'SYSTEM', 'SJOUSER1', 'ARAMIS1', 'NEWUSER')");

			pStmt = conn.prepareStatement("DELETE FROM JUROR_MOD.USERS WHERE USERNAME IN ('MODTESTBUREAU','MODTESTCOURT','MODCOURT', 'MODBUREAUOFFICER', 'AUTO', 'TeamPickListUser', 'AutomationStaffMembe', 'CPASS', 'SYSTEM', 'SJOUSER1', 'ARAMIS1', 'NEWUSER')");
			pStmt.execute();
			log.info("Deleted FROM JUROR_MOD.USERS WHERE USERNAME IN ('MODTESTBUREAU','MODTESTCOURT','MODCOURT', 'MODBUREAUOFFICER', 'AUTO', 'TeamPickListUser', 'AutomationStaffMembe', 'CPASS', 'SYSTEM', 'SJOUSER1', 'ARAMIS1', 'NEWUSER')");

		} catch (SQLException e) {
			e.printStackTrace();
			log.error("Message:" + e.getMessage());
		} finally {
			conn.commit();
			pStmt.close();
			conn.close();
		}

	}

	public void cleanNewActivePoolsNSD(String poolNumbersIN) throws SQLException {
		db = new DBConnection();
		String env_property = System.getProperty("env.database");
		if (env_property != null)
			conn = db.getConnection(env_property);
		else
			conn = db.getConnection("demo");
		try {
			pStmt = conn.prepareStatement("DELETE FROM JUROR_MOD.JUROR_POOL WHERE POOL_NUMBER IN " + poolNumbersIN);
			pStmt.executeUpdate();
			conn.commit();
			log.info("DELETED FROM JUROR_MOD.JUROR_POOL WHERE POOL_NUMBER IN " + poolNumbersIN);

			pStmt = conn.prepareStatement("DELETE FROM JUROR_MOD.POOL WHERE POOL_NO IN " + poolNumbersIN);
			pStmt.executeUpdate();
			conn.commit();
			log.info("DELETED FROM JUROR_MOD.POOL WHERE POOL_NO IN " + poolNumbersIN);

		} catch (SQLException e) {
			e.printStackTrace();
			log.error("Message:" + e.getMessage());
		} finally {
			conn.commit();
			pStmt.close();
			conn.close();
		}
	}
	public void refreshVotersTableNSD(String court) throws SQLException {
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
			pStmt = conn.prepareStatement("delete from JUROR_mod.POOL_HISTORY where pool_no in (select pool_number from juror_mod.juror_pool where juror_number like '1%' or juror_number like '2%')");
			pStmt.execute();

			pStmt = conn.prepareStatement("delete from JUROR_mod.POOL_COMMENTS where pool_no in (select pool_number from juror_mod.juror_pool where juror_number like '1%' or juror_number like '2%')");
			pStmt.execute();

			pStmt = conn.prepareStatement("delete from JUROR_mod.juror_POOL where pool_number like '" + court + "%' and juror_number like '1%' or juror_number like '2%'");
			pStmt.execute();

			pStmt = conn.prepareStatement("delete from JUROR_mod.JUROR_HISTORY where juror_number like '1" + court + "%' or juror_number like '2%'");
			pStmt.execute();

			//populate voters
//			pStmt = conn.prepareStatement("update JUROR.VOTERS" + court + " set part_no = '1'||substr(part_no,2,8) where part_no like '6%'");
//			pStmt.executeUpdate();
//			pStmt = conn.prepareStatement("insert into JUROR_MOD.VOTERS SELECT '" + court + "' as LOC_CODE, PART_NO, REGISTER_LETT, POLL_NUMBER, NEW_MARKER, TITLE, LNAME, FNAME, DOB, FLAGS, ADDRESS_LINE_1, ADDRESS_LINE_2, ADDRESS_LINE_3, ADDRESS_LINE_4, ADDRESS_LINE_5, POSTCODE, DATE_SELECTED1, DATE_SELECTED2, DATE_SELECTED3, REC_NUM, PERM_DISQUAL, SOURCE_ID FROM JUROR.VOTERS" + court + " where part_no like '1%'");
//			pStmt.executeUpdate();

			pStmt = conn.prepareStatement(
					"UPDATE JUROR_MOD.VOTERS SET date_selected1 = NULL " +
							"WHERE (part_no LIKE '1%' OR part_no LIKE '2%' OR part_no LIKE '5%') " +
							"AND EXISTS ( " +
							"    SELECT 1 FROM JUROR_MOD.COURT_CATCHMENT_AREA cc " +
							"    WHERE cc.loc_code = '" + court + "' " +
							"    AND JUROR_MOD.VOTERS.zip LIKE cc.postcode || '%' " +
							")"
			);
			pStmt.executeUpdate();

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
	//refactor after testing is complete
	public void clean_pools_created_yesterdayNSD(String courtCode) throws SQLException {
		ZoneId zone = ZoneId.of("Europe/London");
		LocalDate target = LocalDate.now(zone).plusWeeks(9);
		DateTimeFormatter yyMM = DateTimeFormatter.ofPattern("yyMM");
		String likePattern = courtCode + target.format(yyMM) + "%";

		DBConnection db = new DBConnection();
		String env = System.getProperty("env.database");
		if (env == null) env = "demo";

		final String[] deletesInOrder = new String[]{
				"DELETE FROM juror_mod.juror_audit WHERE juror_number IN (" + "SELECT juror_number FROM juror_mod.juror_pool WHERE pool_number LIKE ?)",
				"DELETE FROM juror_mod.user_juror_response_audit WHERE juror_number IN (" + "SELECT juror_number FROM juror_mod.juror_pool WHERE pool_number LIKE ?)",
				"DELETE FROM juror_mod.juror_response_aud WHERE juror_number IN (" + "SELECT juror_number FROM juror_mod.juror_pool WHERE pool_number LIKE ?)",
				"DELETE FROM juror_mod.juror_response_cjs_employment WHERE juror_number IN (" + "SELECT juror_number FROM juror_mod.juror_pool WHERE pool_number LIKE ?)",
				"DELETE FROM juror_mod.juror_reasonable_adjustment WHERE juror_number IN (" + "SELECT juror_number FROM juror_mod.juror_pool WHERE pool_number LIKE ?)",
				"DELETE FROM juror_mod.juror_response WHERE juror_number IN (" + "SELECT juror_number FROM juror_mod.juror_pool WHERE pool_number LIKE ?)",
				"DELETE FROM juror_mod.pool_history  WHERE pool_no     LIKE ?",
				"DELETE FROM juror_mod.pool_comments WHERE pool_no     LIKE ?",
				"DELETE FROM juror_mod.juror_pool    WHERE pool_number LIKE ?",
				"DELETE FROM juror_mod.pool          WHERE pool_no     LIKE ?"
		};

		try (Connection conn = db.getConnection(env)) {
			conn.setAutoCommit(false);

			for (String sql : deletesInOrder) {
				try (PreparedStatement pStmt = conn.prepareStatement(sql)) {
					pStmt.setString(1, likePattern);
					pStmt.executeUpdate();
				}
			}

			conn.commit();
			log.info("Deleted all pools with prefix [" + likePattern + "]");
		} catch (SQLException e) {
			log.error("Cleanup failed", e);
			throw e;
		}
	}

	public void cleanTrialsNSD() throws SQLException {
		db = new DBConnection();
		String env_property = System.getProperty("env.database");
		if (env_property != null)
			conn = db.getConnection(env_property);
		else
			conn = db.getConnection("demo");
		try {
			pStmt = conn.prepareStatement("delete from juror_mod.juror_trial");
			pStmt.execute();
			conn.commit();

			pStmt = conn.prepareStatement("delete from juror_mod.appearance_audit");
			pStmt.execute();
			conn.commit();

			pStmt = conn.prepareStatement("delete from juror_mod.trial");
			pStmt.execute();
			conn.commit();

			log.info("deleted trials records");
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
	public void cleanTrialNumberNSD(String trial_number) throws SQLException {
		db = new DBConnection();
		String env_property = System.getProperty("env.database");
		if (env_property != null)
			conn = db.getConnection(env_property);
		else
			conn = db.getConnection("demo");
		try {
			pStmt = conn.prepareStatement("delete from juror_mod.juror_trial where trial_number='" + trial_number + "'");
			pStmt.execute();
			conn.commit();

			pStmt = conn.prepareStatement("delete from juror_mod.appearance_audit where trial_number='" + trial_number + "'");
			pStmt.execute();
			conn.commit();

			pStmt = conn.prepareStatement("delete from juror_mod.trial where trial_number='" + trial_number + "'");
			pStmt.execute();
			conn.commit();

			log.info("deleted trials records for trial '" + trial_number);
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

	public void cleanUtilReportsForCourtNSD(String court) throws SQLException {
		db = new DBConnection();
		String env_property = System.getProperty("env.database");
		if (env_property != null)
			conn = db.getConnection(env_property);
		else
			conn = db.getConnection("demo");
		try {
			pStmt = conn.prepareStatement("delete from juror_mod.utilisation_stats where loc_code='" + court + "'");
			pStmt.execute();
			conn.commit();

			log.info("deleted utilisation stat records for court '" + court);
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

	public void populateCourtCatchmentAreaTable() throws SQLException {
		db = new DBConnection();
		String env_property = System.getProperty("env.database");
		if (env_property != null)
			conn = db.getConnection(env_property);
		else
			conn = db.getConnection("demo");
		try {
			pStmt = conn.prepareStatement("delete from juror_mod.court_catchment_area");
			pStmt.execute();
			conn.commit();

			pStmt = conn.prepareStatement("INSERT INTO juror_mod.court_catchment_area (postcode,loc_code) VALUES\n" +
					"\t ('AL1','450'),\n" +
					"\t ('B4','127'),\n" +
					"\t ('B4','404'),\n" +
					"\t ('B97','797'),\n" +
					"\t ('BB11','409'),\n" +
					"\t ('BD1','402'),\n" +
					"\t ('BH7','406'),\n" +
					"\t ('BL1','470'),\n" +
					"\t ('BN3','799'),\n" +
					"\t ('BN7','431'),\n" +
					"\t ('BS1','408'),\n" +
					"\t ('CA1','412'),\n" +
					"\t ('CB1','410'),\n" +
					"\t ('CF1','411'),\n" +
					"\t ('CF10','411'),\n" +
					"\t ('CF2','411'),\n" +
					"\t ('CF3','411'),\n" +
					"\t ('CF4','411'),\n" +
					"\t ('CF47','437'),\n" +
					"\t ('CF5','411'),\n" +
					"\t ('CF6','411'),\n" +
					"\t ('CF7','411'),\n" +
					"\t ('CF8','411'),\n" +
					"\t ('CH1','415'),\n" +
					"\t ('CH2','415'),\n" +
					"\t ('CH7','769'),\n" +
					"\t ('CM1','414'),\n" +
					"\t ('CR4','794'),\n" +
					"\t ('CR9','418'),\n" +
					"\t ('CT1','479'),\n" +
					"\t ('CV1','417'),\n" +
					"\t ('CV34','463'),\n" +
					"\t ('DE1','419'),\n" +
					"\t ('DH1','422'),\n" +
					"\t ('DN1','420'),\n" +
					"\t ('DN31','425'),\n" +
					"\t ('DT1','407'),\n" +
					"\t ('DY10','798'),\n" +
					"\t ('E11','453'),\n" +
					"\t ('EC4M','413'),\n" +
					"\t ('EX1','423'),\n" +
					"\t ('EX31','750'),\n" +
					"\t ('GL1','424'),\n" +
					"\t ('GL1','795'),\n" +
					"\t ('GL10','795'),\n" +
					"\t ('GL11','795'),\n" +
					"\t ('GL12','795'),\n" +
					"\t ('GL13','795'),\n" +
					"\t ('GL18','795'),\n" +
					"\t ('GL19','795'),\n" +
					"\t ('GL2','795'),\n" +
					"\t ('GL20','795'),\n" +
					"\t ('GL3','795'),\n" +
					"\t ('GL4','795'),\n" +
					"\t ('GL5','795'),\n" +
					"\t ('GL50','795'),\n" +
					"\t ('GL51','795'),\n" +
					"\t ('GL52','795'),\n" +
					"\t ('GL53','795'),\n" +
					"\t ('GL54','795'),\n" +
					"\t ('GL55','795'),\n" +
					"\t ('GL56','795'),\n" +
					"\t ('GL6','795'),\n" +
					"\t ('GL7','795'),\n" +
					"\t ('GL8','795'),\n" +
					"\t ('GL9','795'),\n" +
					"\t ('GU1','474'),\n" +
					"\t ('HA1','468'),\n" +
					"\t ('HP20','401'),\n" +
					"\t ('HR1','762'),\n" +
					"\t ('HU1','403'),\n" +
					"\t ('IP1','426'),\n" +
					"\t ('IP33','754'),\n" +
					"\t ('KT1','427'),\n" +
					"\t ('KT3','794'),\n" +
					"\t ('KT4','794'),\n" +
					"\t ('L2','433'),\n" +
					"\t ('LA1','751'),\n" +
					"\t ('LA14','756'),\n" +
					"\t ('LE1','430'),\n" +
					"\t ('LL40','768'),\n" +
					"\t ('LL55','755'),\n" +
					"\t ('LN1','432'),\n" +
					"\t ('LS1','429'),\n" +
					"\t ('LU1','476'),\n" +
					"\t ('M1','435'),\n" +
					"\t ('M1','436'),\n" +
					"\t ('M2','435'),\n" +
					"\t ('M3','435'),\n" +
					"\t ('M4','435'),\n" +
					"\t ('M5','435'),\n" +
					"\t ('M6','435'),\n" +
					"\t ('M7','435'),\n" +
					"\t ('M8','435'),\n" +
					"\t ('ME16','434'),\n" +
					"\t ('N22','469'),\n" +
					"\t ('NE1','439'),\n" +
					"\t ('NG1','444'),\n" +
					"\t ('NN1','442'),\n" +
					"\t ('NN3','442'),\n" +
					"\t ('NN5','442'),\n" +
					"\t ('NN7','442'),\n" +
					"\t ('NP20','441'),\n" +
					"\t ('NR3','443'),\n" +
					"\t ('OX1','445'),\n" +
					"\t ('PE1','473'),\n" +
					"\t ('PE29','796'),\n" +
					"\t ('PE32','765'),\n" +
					"\t ('PL1','446'),\n" +
					"\t ('PO1','447'),\n" +
					"\t ('PO19','416'),\n" +
					"\t ('PO30','478'),\n" +
					"\t ('PR1','448'),\n" +
					"\t ('RG1','449'),\n" +
					"\t ('S1','451'),\n" +
					"\t ('S2','451'),\n" +
					"\t ('S3','451'),\n" +
					"\t ('S4','451'),\n" +
					"\t ('S5','451'),\n" +
					"\t ('S6','451'),\n" +
					"\t ('S7','451'),\n" +
					"\t ('S8','451'),\n" +
					"\t ('SA1','457'),\n" +
					"\t ('SA2','457'),\n" +
					"\t ('SA31','758'),\n" +
					"\t ('SA61','761'),\n" +
					"\t ('SE1','400'),\n" +
					"\t ('SE1','428'),\n" +
					"\t ('SE1','440'),\n" +
					"\t ('SE1','471'),\n" +
					"\t ('SE28','472'),\n" +
					"\t ('SM4','794'),\n" +
					"\t ('SN1','458'),\n" +
					"\t ('SO15','454'),\n" +
					"\t ('SO23','465'),\n" +
					"\t ('SP1','480'),\n" +
					"\t ('SS14','461'),\n" +
					"\t ('SS2','772'),\n" +
					"\t ('ST1','456'),\n" +
					"\t ('ST16','455'),\n" +
					"\t ('SW15','794'),\n" +
					"\t ('SW18','794'),\n" +
					"\t ('SW19','794'),\n" +
					"\t ('SW1P','464'),\n" +
					"\t ('SW20','794'),\n" +
					"\t ('SY2','452'),\n" +
					"\t ('SY2','774'),\n" +
					"\t ('TA1','459'),\n" +
					"\t ('TR1','477'),\n" +
					"\t ('TS1','460'),\n" +
					"\t ('TW7','475'),\n" +
					"\t ('WA1','462'),\n" +
					"\t ('WA16','767'),\n" +
					"\t ('WC2A','626'),\n" +
					"\t ('WR1','466'),\n" +
					"\t ('WV1','421'),\n" +
					"\t ('YO1','467');");
			pStmt.execute();
			conn.commit();

			log.info("populated court_catchment_area");
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

	public void populateCourtroomTable() throws SQLException {
		db = new DBConnection();
		String env_property = System.getProperty("env.database");
		if (env_property != null)
			conn = db.getConnection(env_property);
		else
			conn = db.getConnection("demo");
		try {
			pStmt = conn.prepareStatement("delete from juror_mod.courtroom");
			pStmt.execute();
			conn.commit();

			pStmt = conn.prepareStatement("INSERT INTO juror_mod.courtroom (\"loc_code\",room_number,description) VALUES\n" +
					"\t ('421','Navail','Not Available'),\n" +
					"\t ('435','Asmbly','JURY ASSEMBLY ROOM'),\n" +
					"\t ('435','CT10','Court 10'),\n" +
					"\t ('442','ChkOut','PARTICIPANT CHECKED OUT'),\n" +
					"\t ('435','Court','COURT ROOM'),\n" +
					"\t ('451','COURT4','Court 4'),\n" +
					"\t ('421','ChkOut','PARTICIPANT CHECKED OUT'),\n" +
					"\t ('442','Court ','COURT ROOM'),\n" +
					"\t ('435','COURT3','Court 3'),\n" +
					"\t ('451','COURT3','Court 3'),\n" +
					"\t ('452','ChkOut','PARTICIPANT CHECKED OUT'),\n" +
					"\t ('435','Navail','Not Available'),\n" +
					"\t ('452','Court ','COURT ROOM'),\n" +
					"\t ('417','Court ','COURT ROOM'),\n" +
					"\t ('451','COURT6','Court 6'),\n" +
					"\t ('451','COURT8','Court 8'),\n" +
					"\t ('451','ChkOut','PARTICIPANT CHECKED OUT'),\n" +
					"\t ('435','COURT1','Court 1'),\n" +
					"\t ('417','Asmbly','JURY ASSEMBLY ROOM'),\n" +
					"\t ('452','Navail','Not Available'),\n" +
					"\t ('435','COURT4','Court 4'),\n" +
					"\t ('451','COURT2','Court 2'),\n" +
					"\t ('457','ChkOut','PARTICIPANT CHECKED OUT'),\n" +
					"\t ('452','Asmbly','JURY ASSEMBLY ROOM'),\n" +
					"\t ('457','Asmbly','JURY ASSEMBLY ROOM'),\n" +
					"\t ('417','Navail','Not Available'),\n" +
					"\t ('421','Court ','COURT ROOM'),\n" +
					"\t ('421','Asmbly','JURY ASSEMBLY ROOM'),\n" +
					"\t ('435','COURT9','Court 9'),\n" +
					"\t ('451','Asmbly','JURY ASSEMBLY ROOM'),\n" +
					"\t ('415','Court ','COURT ROOM'),\n" +
					"\t ('435','ChkOut','PARTICIPANT CHECKED OUT'),\n" +
					"\t ('417','ChkOut','PARTICIPANT CHECKED OUT'),\n" +
					"\t ('435','COURT6','Court 6'),\n" +
					"\t ('451','COURT1','Court 1'),\n" +
					"\t ('435','COURT7','Court 7'),\n" +
					"\t ('451','Court','COURT ROOM'),\n" +
					"\t ('451','Navail','Not Available'),\n" +
					"\t ('457','Navail','Not Available'),\n" +
					"\t ('451','COURT9','Court 9'),\n" +
					"\t ('451','COURT5','Court 5'),\n" +
					"\t ('415','ChkOut','PARTICIPANT CHECKED OUT'),\n" +
					"\t ('451','COURT7','Court 7'),\n" +
					"\t ('442','Asmbly','JURY ASSEMBLY ROOM'),\n" +
					"\t ('442','Navail','Not Available'),\n" +
					"\t ('435','COURT5','Court 5'),\n" +
					"\t ('451','CT10','Court 10'),\n" +
					"\t ('457','Court ','COURT ROOM'),\n" +
					"\t ('415','Navail','Not Available'),\n" +
					"\t ('435','COURT8','Court 8'),\n" +
					"\t ('415','Asmbly','JURY ASSEMBLY ROOM'),\n" +
					"\t ('435','COURT2','Court 2');\n");
			pStmt.execute();
			conn.commit();

			log.info("populated courtroom");
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

	public void populateJudgeTable() throws SQLException {
		db = new DBConnection();
		String env_property = System.getProperty("env.database");
		if (env_property != null)
			conn = db.getConnection(env_property);
		else
			conn = db.getConnection("demo");
		try {

			pStmt = conn.prepareStatement("DELETE FROM JUROR_MOD.JUDGE");
			pStmt.execute();
			conn.commit();

			pStmt = conn.prepareStatement("INSERT INTO juror_mod.judge (\"owner\",code,description,telephone_number,\"name\",is_active,last_used) VALUES\n" +
					"\t ('435','DRED','DREDD',NULL,'DREDD',false,NULL),\n" +
					"\t ('421','AITK','PATRICIA H AITKEN',NULL,'PATRICIA H AITKEN',false,NULL),\n" +
					"\t ('435','LAWW','HIGHCOURT',NULL,'HIGHCOURT',false,NULL),\n" +
					"\t ('435','JUDD','LAWSON',NULL,'LAWSON',false,NULL),\n" +
					"\t ('400','AITK','PATRICIA H AITKEN',NULL,'PATRICIA H AITKEN',false,NULL),\n" +
					"\t ('442','AITK','PATRICIA H AITKEN',NULL,'PATRICIA H AITKEN',false,NULL),\n" +
					"\t ('457','DEED','JOHN',NULL,'JOHN',false,NULL),\n" +
					"\t ('451','DRED','DREDD',NULL,'DREDD',false,NULL),\n" +
					"\t ('417','AITK','PATRICIA H AITKEN',NULL,'PATRICIA H AITKEN',false,NULL),\n" +
					"\t ('415','AITK','PATRICIA H AITKEN',NULL,'PATRICIA H AITKEN',false,'2024-03-01 10:06:42.04449');\n");
			pStmt.execute();
			conn.commit();

			log.info("populated judge");
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

	public void cleanAppearancesNSD() throws SQLException {
		db = new DBConnection();
		String env_property = System.getProperty("env.database");
		if (env_property != null)
			conn = db.getConnection(env_property);
		else
			conn = db.getConnection("demo");
		try {
			pStmt = conn.prepareStatement("delete from juror_mod.appearance_audit");
			pStmt.execute();
			conn.commit();

			pStmt = conn.prepareStatement("delete from juror_mod.appearance");
			pStmt.execute();
			conn.commit();

			log.info("deleted appearances records");
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

	public void cleanAppearancesForCourtNSD(String court) throws SQLException {
		db = new DBConnection();
		String env_property = System.getProperty("env.database");
		if (env_property != null)
			conn = db.getConnection(env_property);
		else
			conn = db.getConnection("demo");
		try {
			pStmt = conn.prepareStatement("delete from juror_mod.appearance_audit where loc_code = '" + court + "'");
			pStmt.execute();
			conn.commit();

			pStmt = conn.prepareStatement("delete from juror_mod.appearance where loc_code = '" + court + "'");
			pStmt.execute();
			conn.commit();

			log.info("deleted appearances records");
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

	public void updateVotersPostcodeNSD(String court, String postcode) throws SQLException {
		db = new DBConnection();
		String env_property = System.getProperty("env.database");
		if (env_property != null)
			conn = db.getConnection(env_property);
		else
			conn = db.getConnection("demo");
		try {
			pStmt = conn.prepareStatement(
					"UPDATE JUROR_MOD.VOTERS SET ZIP = '" + postcode + "' " +
							"WHERE poll_number < '250' " +
							"AND EXISTS ( " +
							"    SELECT 1 FROM JUROR_MOD.COURT_CATCHMENT_AREA cc " +
							"    WHERE cc.loc_code = '" + court + "' " +
							"    AND JUROR_MOD.VOTERS.zip LIKE cc.postcode || '%' " +
							")"
			);
			pStmt.executeUpdate();

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

	public void pcqEnabledNSD() throws SQLException {
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
			pStmt = conn.prepareStatement("update juror_mod.app_setting set value='TRUE' where setting = 'PCQ_SERVICE_ENABLED'");
//              pStmt = conn.prepareStatement("Insert into JUROR_DIGITAL.APP_SETTINGS (SETTING,VALUE) values ('PCQ_SERVICE_RETURN_URL','http://172.117.3.70:3000/steps/confirm-information')");
			pStmt.executeQuery();

			pStmt = conn.prepareStatement("update juror_mod.app_setting set value='https://pcq.aat.platform.hmcts.net' where setting = 'PCQ_SERVICE_URL'");
			pStmt.executeQuery();

			pStmt = conn.prepareStatement("update juror_mod.app_setting set value=? where setting = 'PCQ_SERVICE_RETURN_URL'");
			pStmt.setString(1, pcq_return_value);
			pStmt.executeQuery();

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

	public void pcqDisabledNSD() throws SQLException {
		db = new DBConnection();
		String env_property = System.getProperty("env.database");
		if (env_property != null)
			conn = db.getConnection(env_property);
		else
			conn = db.getConnection("demo");
		try {
			pStmt = conn.prepareStatement("update juror_mod.app_setting set value='FALSE' where setting = 'PCQ_SERVICE_ENABLED'");
			pStmt.executeQuery();
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

	public int getCountFromUniquePoolNSD(String pool_no) throws SQLException {
		db = new DBConnection();
		String env_property = System.getProperty("env.database");
		conn = db.getConnection(env_property);
		try {
			pStmt = conn.prepareStatement("select count(*) from juror_mod.pool where pool_no='" + pool_no + "'");
			ResultSet rs = pStmt.executeQuery();
			rs.next();
			log.info("Got count of rows in pool with this pool_no");
			return rs.getInt(1);
		} catch (SQLException e) {
			e.printStackTrace();
			log.error("Message:" + e.getMessage());
			log.info(11);

		}
		return 0;
	}

	public int getCountFromPoolNSD(String part_no, String pool_no) throws SQLException {
		db = new DBConnection();
		String env_property = System.getProperty("env.database");
		conn = db.getConnection(env_property);
		try {
			pStmt = conn.prepareStatement("select count(*) from juror_mod.juror where juror_number='" + part_no + "'");
			ResultSet rs = pStmt.executeQuery();
			rs.next();
			log.info("Got count of rows in juror_pool with this part_no, pool_no");
			return rs.getInt(1);
		} catch (SQLException e) {
			e.printStackTrace();
			log.error("Message:" + e.getMessage());
			log.info(11);

		}
		return 0;
	}

	public int getCountFromJurorPoolByPoolNoNSD(String pool_no) throws SQLException {
		db = new DBConnection();
		String env_property = System.getProperty("env.database");
		conn = db.getConnection(env_property);
		try {
			pStmt = conn.prepareStatement("select count(*) from juror_mod.juror_pool where pool_number='" + pool_no + "'");
			ResultSet rs = pStmt.executeQuery();
			rs.next();
			log.info("Got count of rows in juror_pool with this pool_no");
			return rs.getInt(1);
		} catch (SQLException e) {
			e.printStackTrace();
			log.error("Message:" + e.getMessage());
			log.info(11);

		}
		return 0;
	}

	public int getCountFromJurorPoolNSD(String part_no, String pool_no) throws SQLException {
		db = new DBConnection();
		String env_property = System.getProperty("env.database");
		conn = db.getConnection(env_property);
		try {
			pStmt = conn.prepareStatement("select count(*) from juror_mod.juror_pool where juror_number='" + part_no + "'");
			ResultSet rs = pStmt.executeQuery();
			rs.next();
			log.info("Got count of rows in juror_pool with this part_no");
			return rs.getInt(1);
		} catch (SQLException e) {
			e.printStackTrace();
			log.error("Message:" + e.getMessage());
			log.info(11);

		}
		return 0;
	}

	public int getAwaitingInfoCountForUser(String user) throws SQLException {
		db = new DBConnection();
		String env_property = System.getProperty("env.database");
		conn = db.getConnection(env_property);
		try {
			pStmt = conn.prepareStatement("select count(*) from juror_mod.juror_response where staff_login='" + user + "' and processing_status like 'AWAITING%'");
			ResultSet rs = pStmt.executeQuery();
			rs.next();
			log.info("Got count of rows in juror_response where user is '" + user + "' and status is awaiting info");
			return rs.getInt(1);
		} catch (SQLException e) {
			e.printStackTrace();
			log.error("Message:" + e.getMessage());
			log.info(11);
		}
		return 0;
	}

	public int checkForTransferredPoolRecordsNSD(String part_no) throws SQLException {
		db = new DBConnection();
		String env_property = System.getProperty("env.database");
		conn = db.getConnection(env_property);
		try {
			pStmt = conn.prepareStatement("select count(*) from juror_mod.juror_pool where juror_number in (select juror_number from juror_mod.juror_pool where juror_number='" + part_no + "' and transfer_date is not null)");
			ResultSet rs = pStmt.executeQuery();
			rs.next();
			log.info("Got count of rows in juror_pool with this part_no");
			return rs.getInt(1);
		} catch (SQLException e) {
			e.printStackTrace();
			log.error("Message:" + e.getMessage());
			log.info(11);

		}
		return 0;
	}

	public void insertMultipleNewPoolsWithDeferralNSD(String court, int noOfPools, String owner, String noWeeks) throws SQLException {
		db = new DBConnection();

		String env_property = System.getProperty("env.database");

		if (env_property != null)
			conn = db.getConnection(env_property);
		else
			conn = db.getConnection("demo");

		try {

			Calendar calendar = Calendar.getInstance();
			calendar.add(Calendar.WEEK_OF_MONTH, Integer.parseInt(noWeeks));
			LocalDate localDateMonday = calendar.toInstant().atZone(ZoneId.systemDefault()).toLocalDate().with(TemporalAdjusters.next(DayOfWeek.MONDAY));

			String poolNumber = court + "111111";

			pStmt = conn.prepareStatement("DELETE FROM juror_mod.juror_pool WHERE pool_number = ?");
			pStmt.setString(1, poolNumber);
			pStmt.executeUpdate();

			pStmt = conn.prepareStatement("DELETE FROM juror_mod.pool WHERE pool_no = ?");
			pStmt.setString(1, poolNumber);
			pStmt.executeUpdate();

			pStmt = conn.prepareStatement(
					"INSERT INTO juror_mod.pool (pool_no, owner, return_date, no_requested, pool_type, loc_code, new_request, last_update, additional_summons, attend_time, total_no_required, date_created) " +
							"VALUES (?, ?, ?, 5, 'CRO', ?, 'N', NOW(), null, TIMESTAMP '2022-04-01 09:30:00.0', 5, NOW())");
			pStmt.setString(1, poolNumber);
			pStmt.setString(2, owner);
			pStmt.setObject(3, localDateMonday);
			pStmt.setString(4, court);
			pStmt.executeUpdate();

			for (int index = 0; index < noOfPools; index++) {
				String jurorNumber = "0" + court + "0000" + index;
				String poolNo = court + "00000" + index;

				pStmt = conn.prepareStatement("DELETE FROM juror_mod.bulk_print_data WHERE juror_no = ?");
				pStmt.setString(1, jurorNumber);
				pStmt.executeUpdate();

				pStmt = conn.prepareStatement("DELETE FROM juror_mod.juror_pool WHERE juror_number = ?");
				pStmt.setString(1, jurorNumber);
				pStmt.executeUpdate();

				pStmt = conn.prepareStatement("DELETE FROM juror_mod.juror_pool WHERE pool_number = ?");
				pStmt.setString(1, poolNo);
				pStmt.executeUpdate();

				pStmt = conn.prepareStatement("DELETE FROM juror_mod.pool WHERE pool_no = ?");
				pStmt.setString(1, poolNo);
				pStmt.executeUpdate();

				pStmt = conn.prepareStatement("DELETE FROM juror_mod.juror_history WHERE juror_number = ?");
				pStmt.setString(1, jurorNumber);
				pStmt.executeUpdate();

				pStmt = conn.prepareStatement("DELETE FROM juror_mod.juror WHERE juror_number = ?");
				pStmt.setString(1, jurorNumber);
				pStmt.executeUpdate();

				pStmt = conn.prepareStatement(
						"INSERT INTO juror_mod.pool (pool_no, owner, return_date, no_requested, pool_type, loc_code, new_request, last_update, additional_summons, attend_time, total_no_required, date_created) " +
								"VALUES (?, ?, ?, 5, 'CRO', ?, 'T', NOW(), null, TIMESTAMP '2022-04-01 09:30:00.0', 5, NOW())");
				pStmt.setString(1, poolNo);
				pStmt.setString(2, owner);
				pStmt.setObject(3, localDateMonday);
				pStmt.setString(4, court);
				pStmt.executeUpdate();

				pStmt = conn.prepareStatement(
						"INSERT INTO juror_mod.juror (juror_number, poll_number, title, last_name, first_name, dob, address_line_1, postcode, responded, no_def_pos, police_check, date_created) " +
								"VALUES (?, '857', null, 'lname', 'fname', null, 'address', 'CH1 2NN', 'Y', '1', 'NOT_CHECKED', CURRENT_DATE)");
				pStmt.setString(1, jurorNumber);
				pStmt.executeUpdate();

				pStmt = conn.prepareStatement(
						"INSERT INTO juror_mod.juror_pool (juror_number, pool_number, owner, user_edtq, is_active, status, def_date, location, pool_seq, last_update, date_created) " +
								"VALUES (?, ?, ?, 'MODTESTBUREAU', true, 7, ?, ?, '0001', CURRENT_DATE, CURRENT_DATE)");
				pStmt.setString(1, jurorNumber);
				pStmt.setString(2, poolNo);
				pStmt.setString(3, owner);
				pStmt.setObject(4, localDateMonday);
				pStmt.setString(5, court);
				pStmt.executeUpdate();
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

	public void inserPoolWithRespondedJurorsNSD(int noOfJurors, String court, String owner) throws SQLException {
		db = new DBConnection();

		String env_property = System.getProperty("env.database");

		if (env_property != null)
			conn = db.getConnection(env_property);
		else
			conn = db.getConnection("demo");

		try {

			pStmt = conn.prepareStatement("DELETE FROM JUROR_MOD.JUROR_POOL WHERE POOL_NUMBER = '" + court + "133333'");
			pStmt.execute();

			pStmt = conn.prepareStatement("DELETE FROM JUROR_mod.POOL WHERE POOL_NO=  '" + court + "133333'");
			pStmt.execute();

			pStmt = conn.prepareStatement("Insert into juror_mod.pool (pool_no, owner, return_date, no_requested, pool_type, loc_code, new_request, last_update, additional_summons, attend_time, total_no_required, date_created)"
					+ "values ('" + court + "133333','" + owner + "',current_date,'5','CRO','" + court + "','N',NOW(),null,TIMESTAMP'2022-04-01 09:30:00.0','5',NOW())");
			pStmt.execute();


			for (int index = 0; index < noOfJurors; index++) {

				pStmt = conn.prepareStatement("DELETE FROM JUROR_MOD.JUROR_POOL WHERE JUROR_NUMBER = '0" + court + "0001" + index + "'");
				pStmt.execute();

				pStmt = conn.prepareStatement("DELETE FROM JUROR_MOD.JUROR_HISTORY WHERE JUROR_NUMBER = '0" + court + "0001" + index + "'");
				pStmt.execute();

				pStmt = conn.prepareStatement("DELETE FROM JUROR_MOD.JUROR WHERE JUROR_NUMBER = '0" + court + "0001" + index + "'");
				pStmt.execute();

				pStmt = conn.prepareStatement("insert into juror_mod.juror (juror_number,poll_number,title,last_name,first_name,dob,ADDRESS_LINE_1,ADDRESS_LINE_2,ADDRESS_LINE_3,ADDRESS_LINE_4,ADDRESS_LINE_5,POSTCODE,h_phone,w_phone,w_ph_local,responded,date_excused,excusal_code,acc_exc,date_disq,disq_code,user_edtq,notes,no_def_pos,perm_disqual,reasonable_adj_code,reasonable_adj_msg,sort_code,bank_acct_name,bank_acct_no,bldg_soc_roll_no,welsh,police_check,last_update,summons_file,m_phone,h_email,contact_preference,notifications,date_created,optic_reference,pending_title,pending_first_name,pending_last_name)"
						+ "values ('0" + court + "0001" + index + "','857',null,'lname','fname',null,'address',null,null,null,null,'CH1 2NN',null,null,null,'Y',null,null,null,null,null,null,null,'1',null,null,null,null,null,null,null,'N',null,null,null,null,null,null,'0',null,null,null,null,null)");
				pStmt.execute();

				pStmt = conn.prepareStatement("insert into juror_mod.juror_pool (juror_number,pool_number,owner,user_edtq,is_active,status,times_sel,def_date,location,no_attendances,no_attended,no_fta,no_awol,pool_seq,edit_tag,next_date,on_call,was_deferred,deferral_code,id_checked,postpone,paid_cash,scan_code,last_update,reminder_sent,transfer_date,date_created)"
						+ "values ('0" + court + "0001" + index + "','" + court + "133333','" + owner + "', 'MODTESTBUREAU', true, 2, NULL, null, NULL, null, NULL, NULL, NULL, '0001', NULL, NULL, false, NULL, NULL, null, NULL, NULL, NULL, CURRENT_DATE, NULL, NULL, CURRENT_DATE)");
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


	public void insertNewActivePoolNSD(String court) throws SQLException {
		db = new DBConnection();

		String env_property = System.getProperty("env.database");

		if (env_property != null)
			conn = db.getConnection(env_property);
		else
			conn = db.getConnection("demo");

		try {

			pStmt = conn.prepareStatement("Insert into juror_mod.pool (pool_no, owner, return_date, no_requested, pool_type, loc_code, new_request, last_update, additional_summons, attend_time, total_no_required, date_created)"
					+ "values ('" + court + "222222','400',CURRENT_DATE+112,'5','CRO','" + court + "','N',NOW(),null,TIMESTAMP'2022-04-01 09:30:00.0','5',NOW())");
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

	public void insertNewActivePoolMultiStatusNSD(String court) throws SQLException {
		db = new DBConnection();

		String env_property = System.getProperty("env.database");

		if (env_property != null)
			conn = db.getConnection(env_property);
		else
			conn = db.getConnection("demo");

		try {

			pStmt = conn.prepareStatement("Insert into juror_mod.pool (pool_no, owner, return_date, no_requested, pool_type, loc_code, new_request, last_update, additional_summons, attend_time, total_no_required, date_created)"
					+ "values ('" + court + "911911','400',CURRENT_DATE+112,'9','CRO','" + court + "','N',NOW(),null,TIMESTAMP'2022-04-01 09:30:00.0','9',NOW())");
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

	public void insertJurorsIntoActivePoolNSD(String court) throws SQLException {
		db = new DBConnection();

		String env_property = System.getProperty("env.database");

		if (env_property != null)
			conn = db.getConnection(env_property);
		else
			conn = db.getConnection("demo");

		try {

			pStmt = conn.prepareStatement("INSERT INTO JUROR_MOD.VOTERS (PART_NO,REGISTER_LETT,POLL_NUMBER,NEW_MARKER,TITLE,LNAME,FNAME,DOB,FLAGS,ADDRESS,ADDRESS2,ADDRESS3,ADDRESS4,ADDRESS5,ADDRESS6,ZIP,DATE_SELECTED1,DATE_SELECTED2,DATE_SELECTED3,REC_NUM,PERM_DISQUAL,SOURCE_ID)" +
					"VALUES ('9" + court + "99999','999','999',NULL,NULL,'LNAMEONE','FNAMEONE',NULL,NULL,'1 STREET NAME','ANYTOWN',NULL,NULL,NULL,NULL,'CH1 2AN',CURRENT_DATE,NULL,NULL,1,NULL,NULL)");
			pStmt.execute();

			pStmt = conn.prepareStatement("INSERT INTO JUROR_MOD.VOTERS (PART_NO,REGISTER_LETT,POLL_NUMBER,NEW_MARKER,TITLE,LNAME,FNAME,DOB,FLAGS,ADDRESS,ADDRESS2,ADDRESS3,ADDRESS4,ADDRESS5,ADDRESS6,ZIP,DATE_SELECTED1,DATE_SELECTED2,DATE_SELECTED3,REC_NUM,PERM_DISQUAL,SOURCE_ID)" +
					"VALUES ('9" + court + "99998','998','998',NULL,NULL,'LNAMETWO','FNAMETWO',NULL,NULL,'2 STREET NAME','ANYTOWN',NULL,NULL,NULL,NULL,'CH1 2AN',CURRENT_DATE,NULL,NULL,1,NULL,NULL)");
			pStmt.execute();

			pStmt = conn.prepareStatement("insert into juror_mod.juror (juror_number,poll_number,title,last_name,first_name,dob,ADDRESS_LINE_1,ADDRESS_LINE_2,ADDRESS_LINE_3,ADDRESS_LINE_4,ADDRESS_LINE_5,POSTCODE,h_phone,w_phone,w_ph_local,responded,date_excused,excusal_code,acc_exc,date_disq,disq_code,user_edtq,notes,no_def_pos,perm_disqual,reasonable_adj_code,reasonable_adj_msg,sort_code,bank_acct_name,bank_acct_no,bldg_soc_roll_no,welsh,police_check,last_update,summons_file,m_phone,h_email,contact_preference,notifications,date_created,optic_reference,pending_title,pending_first_name,pending_last_name)"
					+ "values ('9" + court + "99999','857',null,'lname','fname',null,'address',null,null,null,null,'CH1 2NN',null,null,null,false,null,null,null,null,null,null,null,'1',null,null,null,null,null,null,null,'N','NOT_CHECKED',null,null,null,null,null,'0',null,null,null,null,null)");
			pStmt.execute();

			pStmt = conn.prepareStatement("insert into juror_mod.juror_pool (juror_number,pool_number,owner,user_edtq,is_active,status,times_sel,def_date,location,no_attendances,no_attended,no_fta,no_awol,pool_seq,edit_tag,next_date,on_call,was_deferred,deferral_code,id_checked,postpone,paid_cash,scan_code,last_update,reminder_sent,transfer_date,date_created)"
					+ "values ('9" + court + "99999','" + court + "222222','400',null,true,'1',null,null,'400','0',null,null,null,null,null,CURRENT_DATE+112,false,'N',NULL,null,null,null,null,CURRENT_DATE,null,null,CURRENT_DATE)");
			pStmt.execute();

			pStmt = conn.prepareStatement("insert into juror_mod.juror (juror_number,poll_number,title,last_name,first_name,dob,ADDRESS_LINE_1,ADDRESS_LINE_2,ADDRESS_LINE_3,ADDRESS_LINE_4,ADDRESS_LINE_5,POSTCODE,h_phone,w_phone,w_ph_local,responded,date_excused,excusal_code,acc_exc,date_disq,disq_code,user_edtq,notes,no_def_pos,perm_disqual,reasonable_adj_code,reasonable_adj_msg,sort_code,bank_acct_name,bank_acct_no,bldg_soc_roll_no,welsh,police_check,last_update,summons_file,m_phone,h_email,contact_preference,notifications,date_created,optic_reference,pending_title,pending_first_name,pending_last_name)"
					+ "values ('9" + court + "99998','857',null,'lname','fname',null,'address',null,null,null,null,'CH1 2NN',null,null,null,'Y',null,null,null,null,null,null,null,'1',null,null,null,null,null,null,null,'N','NOT_CHECKED',null,null,null,null,null,'0',null,null,null,null,null)");
			pStmt.execute();

			pStmt = conn.prepareStatement("insert into juror_mod.juror_pool (juror_number,pool_number,owner,user_edtq,is_active,status,times_sel,def_date,location,no_attendances,no_attended,no_fta,no_awol,pool_seq,edit_tag,next_date,on_call,was_deferred,deferral_code,id_checked,postpone,paid_cash,scan_code,last_update,reminder_sent,transfer_date,date_created)"
					+ "values ('9" + court + "99998','" + court + "222222','400',null,'Y','2',null,null,'400','0',null,null,null,null,null,CURRENT_DATE+112,false,'N',NULL,null,null,null,null,CURRENT_DATE,null,null,CURRENT_DATE)");
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

	public void insertJurorsIntoActivePoolMultiStatusNSD(String court) throws SQLException {
		db = new DBConnection();

		String env_property = System.getProperty("env.database");

		if (env_property != null)
			conn = db.getConnection(env_property);
		else
			conn = db.getConnection("demo");

		try {

			//voters

			pStmt = conn.prepareStatement("INSERT INTO JUROR_MOD.VOTERS (PART_NO,REGISTER_LETT,POLL_NUMBER,NEW_MARKER,TITLE,LNAME,FNAME,DOB,FLAGS,ADDRESS,ADDRESS2,ADDRESS3,ADDRESS4,ADDRESS5,ADDRESS6,ZIP,DATE_SELECTED1,DATE_SELECTED2,DATE_SELECTED3,REC_NUM,PERM_DISQUAL,SOURCE_ID)" +
					"VALUES ('6" + court + "91101','101','101',NULL,NULL,'LNAMEONE','FNAMEONE',NULL,NULL,'1 STREET NAME','ANYTOWN',NULL,NULL,NULL,NULL,'CH1 2AN',CURRENT_DATE,NULL,NULL,1,NULL,NULL)");
			pStmt.execute();

			pStmt = conn.prepareStatement("INSERT INTO JUROR_MOD.VOTERS (PART_NO,REGISTER_LETT,POLL_NUMBER,NEW_MARKER,TITLE,LNAME,FNAME,DOB,FLAGS,ADDRESS,ADDRESS2,ADDRESS3,ADDRESS4,ADDRESS5,ADDRESS6,ZIP,DATE_SELECTED1,DATE_SELECTED2,DATE_SELECTED3,REC_NUM,PERM_DISQUAL,SOURCE_ID)" +
					"VALUES ('6" + court + "91102','102','102',NULL,NULL,'LNAMETWO','FNAMETWO',NULL,NULL,'2 STREET NAME','ANYTOWN',NULL,NULL,NULL,NULL,'CH1 2AN',CURRENT_DATE,NULL,NULL,1,NULL,NULL)");
			pStmt.execute();

			pStmt = conn.prepareStatement("INSERT INTO JUROR_MOD.VOTERS (PART_NO,REGISTER_LETT,POLL_NUMBER,NEW_MARKER,TITLE,LNAME,FNAME,DOB,FLAGS,ADDRESS,ADDRESS2,ADDRESS3,ADDRESS4,ADDRESS5,ADDRESS6,ZIP,DATE_SELECTED1,DATE_SELECTED2,DATE_SELECTED3,REC_NUM,PERM_DISQUAL,SOURCE_ID)" +
					"VALUES ('6" + court + "91103','103','103',NULL,NULL,'LNAMETWO','FNAMETWO',NULL,NULL,'2 STREET NAME','ANYTOWN',NULL,NULL,NULL,NULL,'CH1 2AN',CURRENT_DATE,NULL,NULL,1,NULL,NULL)");
			pStmt.execute();

			pStmt = conn.prepareStatement("INSERT INTO JUROR_MOD.VOTERS (PART_NO,REGISTER_LETT,POLL_NUMBER,NEW_MARKER,TITLE,LNAME,FNAME,DOB,FLAGS,ADDRESS,ADDRESS2,ADDRESS3,ADDRESS4,ADDRESS5,ADDRESS6,ZIP,DATE_SELECTED1,DATE_SELECTED2,DATE_SELECTED3,REC_NUM,PERM_DISQUAL,SOURCE_ID)" +
					"VALUES ('6" + court + "91104','104','104',NULL,NULL,'LNAMETWO','FNAMETWO',NULL,NULL,'2 STREET NAME','ANYTOWN',NULL,NULL,NULL,NULL,'CH1 2AN',CURRENT_DATE,NULL,NULL,1,NULL,NULL)");
			pStmt.execute();

			pStmt = conn.prepareStatement("INSERT INTO JUROR_MOD.VOTERS (PART_NO,REGISTER_LETT,POLL_NUMBER,NEW_MARKER,TITLE,LNAME,FNAME,DOB,FLAGS,ADDRESS,ADDRESS2,ADDRESS3,ADDRESS4,ADDRESS5,ADDRESS6,ZIP,DATE_SELECTED1,DATE_SELECTED2,DATE_SELECTED3,REC_NUM,PERM_DISQUAL,SOURCE_ID)" +
					"VALUES ('6" + court + "91105','105','105',NULL,NULL,'LNAMETWO','FNAMETWO',NULL,NULL,'2 STREET NAME','ANYTOWN',NULL,NULL,NULL,NULL,'CH1 2AN',CURRENT_DATE,NULL,NULL,1,NULL,NULL)");
			pStmt.execute();

			pStmt = conn.prepareStatement("INSERT INTO JUROR_MOD.VOTERS (PART_NO,REGISTER_LETT,POLL_NUMBER,NEW_MARKER,TITLE,LNAME,FNAME,DOB,FLAGS,ADDRESS,ADDRESS2,ADDRESS3,ADDRESS4,ADDRESS5,ADDRESS6,ZIP,DATE_SELECTED1,DATE_SELECTED2,DATE_SELECTED3,REC_NUM,PERM_DISQUAL,SOURCE_ID)" +
					"VALUES ('6" + court + "91106','106','106',NULL,NULL,'LNAMETWO','FNAMETWO',NULL,NULL,'2 STREET NAME','ANYTOWN',NULL,NULL,NULL,NULL,'CH1 2AN',CURRENT_DATE,NULL,NULL,1,NULL,NULL)");
			pStmt.execute();

			pStmt = conn.prepareStatement("INSERT INTO JUROR_MOD.VOTERS (PART_NO,REGISTER_LETT,POLL_NUMBER,NEW_MARKER,TITLE,LNAME,FNAME,DOB,FLAGS,ADDRESS,ADDRESS2,ADDRESS3,ADDRESS4,ADDRESS5,ADDRESS6,ZIP,DATE_SELECTED1,DATE_SELECTED2,DATE_SELECTED3,REC_NUM,PERM_DISQUAL,SOURCE_ID)" +
					"VALUES ('6" + court + "91107','107','107',NULL,NULL,'LNAMETWO','FNAMETWO',NULL,NULL,'2 STREET NAME','ANYTOWN',NULL,NULL,NULL,NULL,'CH1 2AN',CURRENT_DATE,NULL,NULL,1,NULL,NULL)");
			pStmt.execute();

			pStmt = conn.prepareStatement("INSERT INTO JUROR_MOD.VOTERS (PART_NO,REGISTER_LETT,POLL_NUMBER,NEW_MARKER,TITLE,LNAME,FNAME,DOB,FLAGS,ADDRESS,ADDRESS2,ADDRESS3,ADDRESS4,ADDRESS5,ADDRESS6,ZIP,DATE_SELECTED1,DATE_SELECTED2,DATE_SELECTED3,REC_NUM,PERM_DISQUAL,SOURCE_ID)" +
					"VALUES ('6" + court + "91108','108','108',NULL,NULL,'LNAMETWO','FNAMETWO',NULL,NULL,'2 STREET NAME','ANYTOWN',NULL,NULL,NULL,NULL,'CH1 2AN',CURRENT_DATE,NULL,NULL,1,NULL,NULL)");
			pStmt.execute();

			pStmt = conn.prepareStatement("INSERT INTO JUROR_MOD.VOTERS (PART_NO,REGISTER_LETT,POLL_NUMBER,NEW_MARKER,TITLE,LNAME,FNAME,DOB,FLAGS,ADDRESS,ADDRESS2,ADDRESS3,ADDRESS4,ADDRESS5,ADDRESS6,ZIP,DATE_SELECTED1,DATE_SELECTED2,DATE_SELECTED3,REC_NUM,PERM_DISQUAL,SOURCE_ID)" +
					"VALUES ('6" + court + "91109','109','109',NULL,NULL,'LNAMETWO','FNAMETWO',NULL,NULL,'2 STREET NAME','ANYTOWN',NULL,NULL,NULL,NULL,'CH1 2AN',CURRENT_DATE,NULL,NULL,1,NULL,NULL)");
			pStmt.execute();

			//juror

			pStmt = conn.prepareStatement("insert into juror_mod.juror (juror_number,poll_number,title,last_name,first_name,dob,ADDRESS_LINE_1,ADDRESS_LINE_2,ADDRESS_LINE_3,ADDRESS_LINE_4,ADDRESS_LINE_5,POSTCODE,h_phone,w_phone,w_ph_local,responded,date_excused,excusal_code,acc_exc,date_disq,disq_code,user_edtq,notes,no_def_pos,perm_disqual,reasonable_adj_code,reasonable_adj_msg,sort_code,bank_acct_name,bank_acct_no,bldg_soc_roll_no,welsh,police_check,last_update,summons_file,m_phone,h_email,contact_preference,notifications,date_created,optic_reference,pending_title,pending_first_name,pending_last_name)"
					+ "values ('6" + court + "91101','857',null,'lname','fname',null,'address',null,null,null,null,'CH1 2NN',null,null,null,'N',null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,'N','NOT_CHECKED',null,null,null,null,null,'0',null,null,null,null,null)");
			pStmt.execute();

			pStmt = conn.prepareStatement("insert into juror_mod.juror_pool (juror_number,pool_number,owner,user_edtq,is_active,status,times_sel,def_date,location,no_attendances,no_attended,no_fta,no_awol,pool_seq,edit_tag,next_date,on_call,was_deferred,deferral_code,id_checked,postpone,paid_cash,scan_code,last_update,reminder_sent,transfer_date,date_created)"
					+ "values ('6" + court + "91101','" + court + "911911', '400', 'MODTESTBUREAU', true, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0001', NULL, NULL, false, NULL, NULL, NULL, NULL, NULL, NULL, '2024-01-10 09:18:32.634', NULL, NULL, '2024-01-10 09:18:11.734')");
			pStmt.execute();

			pStmt = conn.prepareStatement("insert into juror_mod.juror (juror_number,poll_number,title,last_name,first_name,dob,ADDRESS_LINE_1,ADDRESS_LINE_2,ADDRESS_LINE_3,ADDRESS_LINE_4,ADDRESS_LINE_5,POSTCODE,h_phone,w_phone,w_ph_local,responded,date_excused,excusal_code,acc_exc,date_disq,disq_code,user_edtq,notes,no_def_pos,perm_disqual,reasonable_adj_code,reasonable_adj_msg,sort_code,bank_acct_name,bank_acct_no,bldg_soc_roll_no,welsh,police_check,last_update,summons_file,m_phone,h_email,contact_preference,notifications,date_created,optic_reference,pending_title,pending_first_name,pending_last_name)"
					+ "values ('6" + court + "91102','857',null,'lname','fname',null,'address',null,null,null,null,'CH1 2NN',null,null,null,'Y',null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,'N','NOT_CHECKED',null,null,null,null,null,'0',null,null,null,null,null)");
			pStmt.execute();

			pStmt = conn.prepareStatement("insert into juror_mod.juror_pool (juror_number,pool_number,owner,user_edtq,is_active,status,times_sel,def_date,location,no_attendances,no_attended,no_fta,no_awol,pool_seq,edit_tag,next_date,on_call,was_deferred,deferral_code,id_checked,postpone,paid_cash,scan_code,last_update,reminder_sent,transfer_date,date_created)"
					+ "values ('6" + court + "91102','" + court + "911911', '400', 'MODTESTBUREAU', true, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0001', NULL, NULL, false, NULL, NULL, NULL, NULL, NULL, NULL, '2024-01-10 09:18:32.634', NULL, NULL, '2024-01-10 09:18:11.734')");
			pStmt.execute();

			pStmt = conn.prepareStatement("insert into juror_mod.juror (juror_number,poll_number,title,last_name,first_name,dob,ADDRESS_LINE_1,ADDRESS_LINE_2,ADDRESS_LINE_3,ADDRESS_LINE_4,ADDRESS_LINE_5,POSTCODE,h_phone,w_phone,w_ph_local,responded,date_excused,excusal_code,acc_exc,date_disq,disq_code,user_edtq,notes,no_def_pos,perm_disqual,reasonable_adj_code,reasonable_adj_msg,sort_code,bank_acct_name,bank_acct_no,bldg_soc_roll_no,welsh,police_check,last_update,summons_file,m_phone,h_email,contact_preference,notifications,date_created,optic_reference,pending_title,pending_first_name,pending_last_name)"
					+ "values ('6" + court + "91105','857',null,'lname','fname',null,'address',null,null,null,null,'CH1 2NN',null,null,null,'Y',null,null,null,null,null,null,null,'1',null,null,null,null,null,null,null,'N','NOT_CHECKED',null,null,null,null,null,'0',null,null,null,null,null)");
			pStmt.execute();

			pStmt = conn.prepareStatement("insert into juror_mod.juror_pool (juror_number,pool_number,owner,user_edtq,is_active,status,times_sel,def_date,location,no_attendances,no_attended,no_fta,no_awol,pool_seq,edit_tag,next_date,on_call,was_deferred,deferral_code,id_checked,postpone,paid_cash,scan_code,last_update,reminder_sent,transfer_date,date_created)"
					+ "values ('6" + court + "91105','" + court + "911911', '400', 'MODTESTBUREAU', true, 5, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0001', NULL, NULL, false, NULL, NULL, NULL, NULL, NULL, NULL, '2024-01-10 09:18:32.634', NULL, NULL, '2024-01-10 09:18:11.734')");
			pStmt.execute();

			pStmt = conn.prepareStatement("insert into juror_mod.juror (juror_number,poll_number,title,last_name,first_name,dob,ADDRESS_LINE_1,ADDRESS_LINE_2,ADDRESS_LINE_3,ADDRESS_LINE_4,ADDRESS_LINE_5,POSTCODE,h_phone,w_phone,w_ph_local,responded,date_excused,excusal_code,acc_exc,date_disq,disq_code,user_edtq,notes,no_def_pos,perm_disqual,reasonable_adj_code,reasonable_adj_msg,sort_code,bank_acct_name,bank_acct_no,bldg_soc_roll_no,welsh,police_check,last_update,summons_file,m_phone,h_email,contact_preference,notifications,date_created,optic_reference,pending_title,pending_first_name,pending_last_name)"
					+ "values ('6" + court + "91106','857',null,'lname','fname',null,'address',null,null,null,null,'CH1 2NN',null,null,null,'Y',null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,'N','NOT_CHECKED',null,null,null,null,null,'0',null,null,null,null,null)");
			pStmt.execute();

			pStmt = conn.prepareStatement("insert into juror_mod.juror_pool (juror_number,pool_number,owner,user_edtq,is_active,status,times_sel,def_date,location,no_attendances,no_attended,no_fta,no_awol,pool_seq,edit_tag,next_date,on_call,was_deferred,deferral_code,id_checked,postpone,paid_cash,scan_code,last_update,reminder_sent,transfer_date,date_created)"
					+ "values ('6" + court + "91106','" + court + "911911', '400', 'MODTESTBUREAU', true, 6, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0001', NULL, NULL, false, NULL, NULL, NULL, NULL, NULL, NULL, '2024-01-10 09:18:32.634', NULL, NULL, '2024-01-10 09:18:11.734')");
			pStmt.execute();

			pStmt = conn.prepareStatement("insert into juror_mod.juror (juror_number,poll_number,title,last_name,first_name,dob,ADDRESS_LINE_1,ADDRESS_LINE_2,ADDRESS_LINE_3,ADDRESS_LINE_4,ADDRESS_LINE_5,POSTCODE,h_phone,w_phone,w_ph_local,responded,date_excused,excusal_code,acc_exc,date_disq,disq_code,user_edtq,notes,no_def_pos,perm_disqual,reasonable_adj_code,reasonable_adj_msg,sort_code,bank_acct_name,bank_acct_no,bldg_soc_roll_no,welsh,police_check,last_update,summons_file,m_phone,h_email,contact_preference,notifications,date_created,optic_reference,pending_title,pending_first_name,pending_last_name)"
					+ "values ('6" + court + "91107','857',null,'lname','fname',null,'address',null,null,null,null,'CH1 2NN',null,null,null,'Y',null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,'N','NOT_CHECKED',null,null,null,null,null,'0',null,null,null,null,null)");
			pStmt.execute();

			pStmt = conn.prepareStatement("insert into juror_mod.juror_pool (juror_number,pool_number,owner,user_edtq,is_active,status,times_sel,def_date,location,no_attendances,no_attended,no_fta,no_awol,pool_seq,edit_tag,next_date,on_call,was_deferred,deferral_code,id_checked,postpone,paid_cash,scan_code,last_update,reminder_sent,transfer_date,date_created)"
					+ "values ('6" + court + "91107','" + court + "911911', '400','MODTESTBUREAU', true, 7, NULL, CURRENT_DATE+60, NULL, NULL, NULL, NULL, NULL, '0001', NULL, NULL, false, NULL, NULL, NULL, NULL, NULL, NULL, '2024-01-10 09:18:32.634', NULL, NULL, '2024-01-10 09:18:11.734')");
			pStmt.execute();

			pStmt = conn.prepareStatement("insert into juror_mod.juror (juror_number,poll_number,title,last_name,first_name,dob,ADDRESS_LINE_1,ADDRESS_LINE_2,ADDRESS_LINE_3,ADDRESS_LINE_4,ADDRESS_LINE_5,POSTCODE,h_phone,w_phone,w_ph_local,responded,date_excused,excusal_code,acc_exc,date_disq,disq_code,user_edtq,notes,no_def_pos,perm_disqual,reasonable_adj_code,reasonable_adj_msg,sort_code,bank_acct_name,bank_acct_no,bldg_soc_roll_no,welsh,police_check,last_update,summons_file,m_phone,h_email,contact_preference,notifications,date_created,optic_reference,pending_title,pending_first_name,pending_last_name)"
					+ "values ('6" + court + "91108','857',null,'lname','fname',null,'address',null,null,null,null,'CH1 2NN',null,null,null,'Y',null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,'N','NOT_CHECKED',null,null,null,null,null,'0',null,null,null,null,null)");
			pStmt.execute();

			pStmt = conn.prepareStatement("insert into juror_mod.juror_pool (juror_number,pool_number,owner,user_edtq,is_active,status,times_sel,def_date,location,no_attendances,no_attended,no_fta,no_awol,pool_seq,edit_tag,next_date,on_call,was_deferred,deferral_code,id_checked,postpone,paid_cash,scan_code,last_update,reminder_sent,transfer_date,date_created)"
					+ "values ('6" + court + "91108','" + court + "911911', '400', 'MODTESTBUREAU', true, 8, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0001', NULL, NULL, false, NULL, NULL, NULL, NULL, NULL, NULL, '2024-01-10 09:18:32.634', NULL, NULL, '2024-01-10 09:18:11.734')");
			pStmt.execute();

			pStmt = conn.prepareStatement("insert into juror_mod.juror (juror_number,poll_number,title,last_name,first_name,dob,ADDRESS_LINE_1,ADDRESS_LINE_2,ADDRESS_LINE_3,ADDRESS_LINE_4,ADDRESS_LINE_5,POSTCODE,h_phone,w_phone,w_ph_local,responded,date_excused,excusal_code,acc_exc,date_disq,disq_code,user_edtq,notes,no_def_pos,perm_disqual,reasonable_adj_code,reasonable_adj_msg,sort_code,bank_acct_name,bank_acct_no,bldg_soc_roll_no,welsh,police_check,last_update,summons_file,m_phone,h_email,contact_preference,notifications,date_created,optic_reference,pending_title,pending_first_name,pending_last_name)"
					+ "values ('6" + court + "91109','857',null,'lname','fname',null,'address',null,null,null,null,'CH1 2NN',null,null,null,'N',null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,'N','NOT_CHECKED',null,null,null,null,null,'0',null,null,null,null,null)");
			pStmt.execute();

			pStmt = conn.prepareStatement("insert into juror_mod.juror_pool (juror_number,pool_number,owner,user_edtq,is_active,status,times_sel,def_date,location,no_attendances,no_attended,no_fta,no_awol,pool_seq,edit_tag,next_date,on_call,was_deferred,deferral_code,id_checked,postpone,paid_cash,scan_code,last_update,reminder_sent,transfer_date,date_created)"
					+ "values ('6" + court + "91109','" + court + "911911', '400', 'MODTESTBUREAU', true, 9, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0001', NULL, NULL, false, NULL, NULL, NULL, NULL, NULL, NULL, '2024-01-10 09:18:32.634', NULL, NULL, '2024-01-10 09:18:11.734')");
			pStmt.execute();

			pStmt = conn.prepareStatement("insert into juror_mod.juror (juror_number,poll_number,title,last_name,first_name,dob,ADDRESS_LINE_1,ADDRESS_LINE_2,ADDRESS_LINE_3,ADDRESS_LINE_4,ADDRESS_LINE_5,POSTCODE,h_phone,w_phone,w_ph_local,responded,date_excused,excusal_code,acc_exc,date_disq,disq_code,user_edtq,notes,no_def_pos,perm_disqual,reasonable_adj_code,reasonable_adj_msg,sort_code,bank_acct_name,bank_acct_no,bldg_soc_roll_no,welsh,police_check,last_update,summons_file,m_phone,h_email,contact_preference,notifications,date_created,optic_reference,pending_title,pending_first_name,pending_last_name)"
					+ "values ('6" + court + "91111','857',null,'lname','fname',null,'address',null,null,null,null,'CH1 2NN',null,null,null,'Y',null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,'N','NOT_CHECKED',null,null,null,null,null,'0',null,null,null,null,null)");
			pStmt.execute();

			pStmt = conn.prepareStatement("insert into juror_mod.juror_pool (juror_number,pool_number,owner,user_edtq,is_active,status,times_sel,def_date,location,no_attendances,no_attended,no_fta,no_awol,pool_seq,edit_tag,next_date,on_call,was_deferred,deferral_code,id_checked,postpone,paid_cash,scan_code,last_update,reminder_sent,transfer_date,date_created)"
					+ "values ('6" + court + "91111','" + court + "911911', '400', 'MODTESTBUREAU', true, 11, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0001', NULL, NULL, false, NULL, NULL, NULL, NULL, NULL, NULL, '2024-01-10 09:18:32.634', NULL, NULL, '2024-01-10 09:18:11.734')");
			pStmt.execute();

			pStmt = conn.prepareStatement("insert into juror_mod.juror (juror_number,poll_number,title,last_name,first_name,dob,ADDRESS_LINE_1,ADDRESS_LINE_2,ADDRESS_LINE_3,ADDRESS_LINE_4,ADDRESS_LINE_5,POSTCODE,h_phone,w_phone,w_ph_local,responded,date_excused,excusal_code,acc_exc,date_disq,disq_code,user_edtq,notes,no_def_pos,perm_disqual,reasonable_adj_code,reasonable_adj_msg,sort_code,bank_acct_name,bank_acct_no,bldg_soc_roll_no,welsh,police_check,last_update,summons_file,m_phone,h_email,contact_preference,notifications,date_created,optic_reference,pending_title,pending_first_name,pending_last_name)"
					+ "values ('6" + court + "91113','857',null,'lname','fname',null,'address',null,null,null,null,'CH1 2NN',null,null,null,'Y',null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,'N','NOT_CHECKED',null,null,null,null,null,'0',null,null,null,null,null)");
			pStmt.execute();

			pStmt = conn.prepareStatement("insert into juror_mod.juror_pool (juror_number,pool_number,owner,user_edtq,is_active,status,times_sel,def_date,location,no_attendances,no_attended,no_fta,no_awol,pool_seq,edit_tag,next_date,on_call,was_deferred,deferral_code,id_checked,postpone,paid_cash,scan_code,last_update,reminder_sent,transfer_date,date_created)"
					+ "values ('6" + court + "91113','" + court + "911911', '400', 'MODTESTBUREAU', true, 13, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0001', NULL, NULL, false, NULL, NULL, NULL, NULL, NULL, NULL, '2024-01-10 09:18:32.634', NULL, NULL, '2024-01-10 09:18:11.734')");
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
	public void deleteVoterRecordNSD(String partNo) throws SQLException {
		db = new DBConnection();

		String env_property = System.getProperty("env.database");

		if (env_property != null)
			conn = db.getConnection(env_property);
		else
			conn = db.getConnection("demo");

		try {

			pStmt = conn.prepareStatement("DELETE FROM JUROR_MOD.VOTERS WHERE PART_NO = '" + partNo + "'");
			pStmt.execute();

			pStmt = conn.prepareStatement("DELETE FROM JUROR_MOD.JUROR_POOL WHERE juror_number = '" + partNo + "'");
			pStmt.execute();

			pStmt = conn.prepareStatement("DELETE FROM JUROR_MOD.JUROR_HISTORY WHERE juror_number = '" + partNo + "'");
			pStmt.execute();

			pStmt = conn.prepareStatement("DELETE FROM JUROR_MOD.juror_response_aud WHERE juror_number = '" + partNo + "'");
			pStmt.execute();

			pStmt = conn.prepareStatement("DELETE FROM JUROR_MOD.JUROR_RESPONSE WHERE juror_number = '" + partNo + "'");
			pStmt.execute();

			pStmt = conn.prepareStatement("DELETE FROM JUROR_MOD.BULK_PRINT_DATA WHERE juror_no = '" + partNo + "'");
			pStmt.execute();

			pStmt = conn.prepareStatement("DELETE FROM JUROR_MOD.JUROR WHERE juror_number = '" + partNo + "'");
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

	//to confirm when letters migrated to juror_history
	public String checkJurorSummonsLetterNSD(String jurorNo) throws SQLException {
		log.info("Checking if juror " + jurorNo + " has been sent a Summons Letter");
		String partNo = "";
		db = new DBConnection();

		String env_property = System.getProperty("env.database");

		if (env_property != null)
			conn = db.getConnection(env_property);
		else
			conn = db.getConnection("demo");

		try {

			pStmt = conn.prepareStatement("SELECT * from JUROR_mod.juror_history WHERE history_code = 'RSUM' and juror_number = '" + jurorNo + "'");
			ResultSet resultSet = pStmt.executeQuery();

			if (!resultSet.next()) {
				log.info("No summons letter for " + jurorNo);
			} else {
				partNo = resultSet.getString("juror_number");
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

	public void insertSingleDigitalSummonsReplyNSD(String newJurorRecordNumber) throws SQLException {
		db = new DBConnection();

		String env_property = System.getProperty("env.database");

		if (env_property != null)
			conn = db.getConnection(env_property);
		else
			conn = db.getConnection("demo");

		try {

//			pStmt = conn.prepareStatement("DELETE FROM JUROR_mod.JUROR_RESPONSE WHERE JUROR_NUMBER = " + newJurorRecordNumber);
//			pStmt.execute();

			pStmt = conn.prepareStatement("INSERT INTO JUROR_mod.JUROR_RESPONSE (JUROR_NUMBER,DATE_RECEIVED,TITLE,FIRST_NAME,LAST_NAME,ADDRESS_LINE_1,ADDRESS_LINE_2,ADDRESS_LINE_3,ADDRESS_LINE_4,ADDRESS_LINE_5,POSTCODE,PROCESSING_STATUS,DATE_OF_BIRTH,PHONE_NUMBER,ALT_PHONE_NUMBER,EMAIL,RESIDENCY,RESIDENCY_DETAIL,MENTAL_HEALTH_ACT,MENTAL_HEALTH_CAPACITY,MENTAL_HEALTH_ACT_DETAILS,BAIL,BAIL_DETAILS,CONVICTIONS,CONVICTIONS_DETAILS,DEFERRAL,DEFERRAL_REASON,DEFERRAL_DATE,REASONABLE_ADJUSTMENTS_ARRANGEMENTS,EXCUSAL,EXCUSAL_REASON,PROCESSING_COMPLETE,SIGNED,version,THIRDPARTY_FNAME,THIRDPARTY_LNAME,RELATIONSHIP,MAIN_PHONE,OTHER_PHONE,EMAIL_ADDRESS,THIRDPARTY_REASON,THIRDPARTY_OTHER_REASON,JUROR_PHONE_DETAILS,JUROR_EMAIL_DETAILS,STAFF_LOGIN,STAFF_ASSIGNMENT_DATE,URGENT,COMPLETED_AT,WELSH,REPLY_TYPE)"
					+ "VALUES ('" + newJurorRecordNumber + "',CURRENT_DATE-1,null,'FNAMEFIVESIXFIVE','LNAMEFIVESIXFIVE','565 STREET NAME','ANYTOWN',null,'ldsadas',null,'CH1 2AN','TODO',CURRENT_DATE-10000,null,null,null,'Y',null,'N','N',NULL,'N',null,'N',null,null,null,null,null,null,null,'N','N','0',null,null,null,null,null,null,null,null,null,null,'MODTESTBUREAU',null,'N',null,'N','Digital')");
			pStmt.execute();

			pStmt = conn.prepareStatement("UPDATE JUROR_mod.JUROR set response_entered = true where juror_number='" + newJurorRecordNumber + "'");
			pStmt.execute();

		} catch (SQLException e) {
			e.printStackTrace();
			log.error("Message:inserted new digital response into Juror_Response" + e.getMessage());
		} finally {
			conn.commit();
			pStmt.close();
			conn.close();
		}
	}

	public void insertTwoNewActivePoolsNSD(String court) throws SQLException {
		db = new DBConnection();

		String env_property = System.getProperty("env.database");

		if (env_property != null)
			conn = db.getConnection(env_property);
		else
			conn = db.getConnection("demo");

		try {

			pStmt = conn.prepareStatement("Insert into juror_mod.pool (pool_no, owner, return_date, no_requested, pool_type, loc_code, new_request, last_update, additional_summons, attend_time, total_no_required, date_created)"
					+ "values ('" + court + "222222','400',CURRENT_DATE+112,'5','CRO','" + court + "','N',NOW(),null,TIMESTAMP'2022-04-01 09:30:00.0','5',NOW())");
			pStmt.execute();

			pStmt = conn.prepareStatement("Insert into juror_mod.pool (pool_no, owner, return_date, no_requested, pool_type, loc_code, new_request, last_update, additional_summons, attend_time, total_no_required, date_created)"
					+ "values ('" + court + "333333','400',CURRENT_DATE+112,'5','CRO','" + court + "','N',NOW(),null,TIMESTAMP'2022-04-01 09:30:00.0','5',NOW())");
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
			pStmt.executeQuery();

		} catch (SQLException e) {
			e.printStackTrace();
			log.error("Message:Removed voters at court " + court + e.getMessage());
		} finally {
			conn.commit();
			pStmt.close();
			conn.close();
		}
	}

	public void updateJurorRecordPolicePhoenixCheckNSD(String policeCheck, String jurorRecord) throws SQLException {
		db = new DBConnection();

		String env_property = System.getProperty("env.database");

		if (env_property != null)
			conn = db.getConnection(env_property);
		else
			conn = db.getConnection("demo");

		try {

			pStmt = conn.prepareStatement("update juror_mod.juror set police_check='" + policeCheck + "' where juror_number='" + jurorRecord + "'");
			pStmt.execute();


		} catch (SQLException e) {
			e.printStackTrace();
			log.error("Message:attempting to update " + jurorRecord + " in Juror_mod.juror setting police_check to " + policeCheck + " and " + e.getMessage());
		} finally {
			conn.commit();
			pStmt.close();
			conn.close();
		}
	}

	public int getOpticReferenceNSD(String part_no) throws SQLException {
		db = new DBConnection();
		String env_property = System.getProperty("env.database");
		conn = db.getConnection(env_property);

		try {
			pStmt = conn.prepareStatement("select optic_reference from juror_mod.juror where juror_number='" + part_no + "'");
			ResultSet rs = pStmt.executeQuery();
			rs.next();
			log.info("Optic reference located");
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

	public void clearAllJurorsinAttendabceTable() throws SQLException {
		db = new DBConnection();

		String env_property = System.getProperty("env.database");

		if (env_property != null)
			conn = db.getConnection(env_property);
		else
			conn = db.getConnection("demo");

		try {

			pStmt = conn.prepareStatement("DELETE FROM juror_mod.appearance;");
			pStmt.executeUpdate();

		} catch (SQLException e) {
			e.printStackTrace();

		} finally {
			conn.commit();
			pStmt.close();
			conn.close();

		}
	}

	public void insertNewTrialNSD(String trialNumber) throws SQLException {
		db = new DBConnection();

		String env_property = System.getProperty("env.database");

		if (env_property != null)
			conn = db.getConnection(env_property);
		else
			conn = db.getConnection("demo");

		try {
			pStmt = conn.prepareStatement("DELETE from juror_mod.trial where trial_number='" + trialNumber + "'");
			pStmt.executeUpdate();

			pStmt = conn.prepareStatement("DELETE from juror_mod.juror_trial where trial_number='" + trialNumber + "'");
			pStmt.executeUpdate();

			pStmt = conn.prepareStatement("DELETE from juror_mod.appearance_audit where trial_number='" + trialNumber + "'");
			pStmt.executeUpdate();

			pStmt = conn.prepareStatement("select id from juror_mod.judge where owner = '415'");
			ResultSet rs = pStmt.executeQuery();
			rs.next();
			int judgeCode = rs.getInt(1);

			pStmt = conn.prepareStatement("select id from juror_mod.courtroom where description = 'JURY ASSEMBLY ROOM'");
			rs = pStmt.executeQuery();
			rs.next();
			int courtRoomNumber = rs.getInt(1);

			pStmt = conn.prepareStatement("INSERT INTO juror_mod.trial (trial_number,loc_code,description,courtroom,judge,trial_type,trial_start_date,trial_end_date,anonymous,juror_requested,jurors_sent)"
					+ "VALUES ('" + trialNumber + "','415','John Stark'," + courtRoomNumber + "," + judgeCode + ",'CRI',CURRENT_DATE,NULL,false,NULL,NULL)");
			pStmt.executeUpdate();

		} catch (SQLException e) {
			e.printStackTrace();
			log.error("Message:" + e.getMessage());

		} finally {
			conn.commit();
			pStmt.close();
			conn.close();
		}
	}

	public void insertNewProtectedTrialNSD(String trialNumber) throws SQLException {
		db = new DBConnection();

		String env_property = System.getProperty("env.database");

		if (env_property != null)
			conn = db.getConnection(env_property);
		else
			conn = db.getConnection("demo");

		try {
			pStmt = conn.prepareStatement("DELETE from juror_mod.trial where trial_number='" + trialNumber + "'");
			pStmt.executeUpdate();

			pStmt = conn.prepareStatement("DELETE from juror_mod.juror_trial where trial_number='" + trialNumber + "'");
			pStmt.executeUpdate();

			pStmt = conn.prepareStatement("DELETE from juror_mod.appearance_audit where trial_number='" + trialNumber + "'");
			pStmt.executeUpdate();

			pStmt = conn.prepareStatement("select id from juror_mod.courtroom where description = 'JURY ASSEMBLY ROOM'");
			ResultSet rs = pStmt.executeQuery();
			rs.next();
			int courtRoomNumber = rs.getInt(1);

			pStmt = conn.prepareStatement("select id from juror_mod.judge where owner = '415'");
			rs = pStmt.executeQuery();
			rs.next();
			int judgeCode = rs.getInt(1);

			pStmt = conn.prepareStatement("INSERT INTO juror_mod.trial (trial_number,loc_code,description,courtroom,judge,trial_type,trial_start_date,trial_end_date,anonymous,juror_requested,jurors_sent)"
					+ "VALUES ('" + trialNumber + "','415','John Stark'," + courtRoomNumber + "," + judgeCode + ",'CRI','2024-08-28',NULL,true,NULL,NULL)");
			pStmt.executeUpdate();

		} catch (SQLException e) {
			e.printStackTrace();
			log.error("Message:" + e.getMessage());

		} finally {
			conn.commit();
			pStmt.close();
			conn.close();
		}

	}

	public void setJurorsStatusAsRespondedNSD(String jurorNumber) throws SQLException {
		db = new DBConnection();

		String env_property = System.getProperty("env.database");

		if (env_property != null)
			conn = db.getConnection(env_property);
		else
			conn = db.getConnection("demo");

		try {
			pStmt = conn.prepareStatement("UPDATE juror_mod.juror set responded=true where juror_number='" + jurorNumber + "'");
			pStmt.executeUpdate();

			pStmt = conn.prepareStatement("UPDATE juror_mod.juror_pool set status='2' where juror_number='" + jurorNumber + "'");
			pStmt.executeUpdate();

		} catch (SQLException e) {
			e.printStackTrace();
			log.error("Message:" + e.getMessage());

		} finally {
			conn.commit();
			pStmt.close();
			conn.close();
		}
	}


	public void setJurorsStatusAsPanelNSD(String jurorNumber) throws SQLException {
		db = new DBConnection();

		String env_property = System.getProperty("env.database");

		if (env_property != null)
			conn = db.getConnection(env_property);
		else
			conn = db.getConnection("demo");

		try {
			pStmt = conn.prepareStatement("UPDATE juror_mod.juror set responded=true where juror_number='" + jurorNumber + "'");
			pStmt.executeUpdate();

			pStmt = conn.prepareStatement("UPDATE juror_mod.juror_pool set status='3' where juror_number='" + jurorNumber + "'");
			pStmt.executeUpdate();

		} catch (SQLException e) {
			e.printStackTrace();
			log.error("Message:" + e.getMessage());

		} finally {
			conn.commit();
			pStmt.close();
			conn.close();
		}
	}


	public void setJurorsDobAsIneligible(String jurorNumber) throws SQLException {
		db = new DBConnection();

		String env_property = System.getProperty("env.database");

		if (env_property != null)
			conn = db.getConnection(env_property);
		else
			conn = db.getConnection("demo");

		try {
			pStmt = conn.prepareStatement("UPDATE juror_mod.juror set DOB='26-OCT-2021' where juror_number='" + jurorNumber + "'");
			pStmt.executeUpdate();

		} catch (SQLException e) {
			e.printStackTrace();
			log.error("Message:" + e.getMessage());

		} finally {
			conn.commit();
			pStmt.close();
			conn.close();
		}
	}

	public void setJurorsStatusAsPrintedforResendDeferralLetter(String jurorNumber) throws SQLException {
		db = new DBConnection();

		String env_property = System.getProperty("env.database");

		if (env_property != null)
			conn = db.getConnection(env_property);
		else
			conn = db.getConnection("demo");

		try {
			pStmt = conn.prepareStatement("UPDATE juror_mod.bulk_print_data set extracted_flag=true where juror_no='" + jurorNumber + "'");
			pStmt.executeUpdate();

		} catch (SQLException e) {
			e.printStackTrace();
			log.error("Message:" + e.getMessage());

		} finally {
			conn.commit();
			pStmt.close();
			conn.close();
		}
	}

	public void setJurorsStatusAsExcused(String jurorNumber) throws SQLException {
		db = new DBConnection();

		String env_property = System.getProperty("env.database");

		if (env_property != null)
			conn = db.getConnection(env_property);
		else
			conn = db.getConnection("demo");

		try {
			pStmt = conn.prepareStatement("update juror_mod.juror_pool set status=5 where juror_number='" + jurorNumber + "'");
			pStmt.executeUpdate();

		} catch (SQLException e) {
			e.printStackTrace();
			log.error("Message:" + e.getMessage());

		} finally {
			conn.commit();
			pStmt.close();
			conn.close();
		}
	}

	public void updateJurorToBeAbleToSendMessage(String jurorNumber) throws SQLException {
		db = new DBConnection();

		String env_property = System.getProperty("env.database");

		if (env_property != null)
			conn = db.getConnection(env_property);
		else
			conn = db.getConnection("demo");

		try {
			pStmt = conn.prepareStatement("UPDATE juror_mod.juror set h_email='test@test.com' where juror_number='" + jurorNumber + "'");
			int rowsUpdated = pStmt.executeUpdate();
			if (rowsUpdated > 0) {
				log.info("h_email updated successfully for juror_number: " + jurorNumber);
			} else {
				throw new SQLException("Failed to update h_email for juror_number: " + jurorNumber);
			}

			pStmt = conn.prepareStatement("UPDATE juror_mod.juror set h_phone='07966676543' where juror_number='" + jurorNumber + "'");
			rowsUpdated = pStmt.executeUpdate();
			if (rowsUpdated > 0) {
				log.info("h_phone updated successfully for juror_number: " + jurorNumber);
			} else {
				throw new SQLException("Failed to update h_phone for juror_number: " + jurorNumber);
			}

			pStmt = conn.prepareStatement("UPDATE juror_mod.juror set m_phone='07966274548' where juror_number='" + jurorNumber + "'");
			rowsUpdated = pStmt.executeUpdate();
			if (rowsUpdated > 0) {
				log.info("m_phone updated successfully for juror_number: " + jurorNumber);
			} else {
				throw new SQLException("Failed to update m_phone for juror_number: " + jurorNumber);
			}

			pStmt = conn.prepareStatement("SELECT h_email, h_phone, m_phone FROM juror_mod.juror WHERE juror_number='" + jurorNumber + "'");
			ResultSet rs = pStmt.executeQuery();
			if (rs.next()) {
				String hEmail = rs.getString("h_email");
				String hPhone = rs.getString("h_phone");
				String mPhone = rs.getString("m_phone");

				if ("test@test.com".equals(hEmail) && "07966676543".equals(hPhone) && "07966274548".equals(mPhone)) {
					log.info("All fields updated successfully for juror_number: " + jurorNumber);
				} else {
					throw new SQLException("Field verification failed for juror_number: " + jurorNumber);
				}
			} else {
				throw new SQLException("Juror not found with juror_number: " + jurorNumber);
			}

		} catch (SQLException e) {
			e.printStackTrace();
			log.error("Message:" + e.getMessage());

		} finally {
			conn.commit();
			pStmt.close();
			conn.close();
		}
	}

    public void updateJurorToBeWelsh(String jurorNumber) throws SQLException {
        db = new DBConnection();

        String env_property = System.getProperty("env.database");

        if (env_property != null)
            conn = db.getConnection(env_property);
        else
            conn = db.getConnection("demo");

        try {
            pStmt = conn.prepareStatement("UPDATE juror_mod.juror set WELSH=TRUE where juror_number='" + jurorNumber + "'");
            int rowsUpdated = pStmt.executeUpdate();
            if (rowsUpdated > 0) {
                log.info("WELSH is set to TRUE for juror_number: " + jurorNumber);
            } else {
                throw new SQLException("Failed to update WELSH flag for juror_number: " + jurorNumber);
            }

        } catch (SQLException e) {
            e.printStackTrace();
            log.error("Message:" + e.getMessage());

        } finally {
            conn.commit();
            pStmt.close();
            conn.close();
        }
    }

	public int getMessageNSD(String jurorNumber) throws SQLException {
		db = new DBConnection();
		String env_property = System.getProperty("env.database");
		conn = db.getConnection(env_property);

		try {
			pStmt = conn.prepareStatement("select * from juror_mod.message where juror_number='" + jurorNumber + "'");
			ResultSet rs = pStmt.executeQuery();
			rs.next();
			log.info("Message row exists");
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

	public void clearMessagesForJuror(String jurorNumber) throws SQLException {
		db = new DBConnection();

		String env_property = System.getProperty("env.database");

		if (env_property != null)
			conn = db.getConnection(env_property);
		else
			conn = db.getConnection("demo");

		try {
			pStmt = conn.prepareStatement("delete from juror_mod.message where juror_number='" + jurorNumber + "'");
			pStmt.executeUpdate();


		} catch (SQLException e) {
			e.printStackTrace();
			log.error("Message:" + e.getMessage());

		} finally {
			conn.commit();
			pStmt.close();
			conn.close();
		}
	}

	public void clearMessagesForCourt(String court) throws SQLException {
		db = new DBConnection();

		String env_property = System.getProperty("env.database");

		if (env_property != null)
			conn = db.getConnection(env_property);
		else
			conn = db.getConnection("demo");

		try {
			pStmt = conn.prepareStatement("delete from juror_mod.message where loc_code='" + court + "'");
			pStmt.executeUpdate();


		} catch (SQLException e) {
			e.printStackTrace();
			log.error("Message:" + e.getMessage());

		} finally {
			conn.commit();
			pStmt.close();
			conn.close();
		}
	}

	public void insertMessagesForCourt(String court) throws SQLException {
		db = new DBConnection();

		String env_property = System.getProperty("env.database");

		if (env_property != null)
			conn = db.getConnection(env_property);
		else
			conn = db.getConnection("demo");

		try {
			pStmt = conn.prepareStatement("INSERT INTO juror_mod.message (juror_number,file_datetime,username,loc_code,phone,email,pool_no,subject,message_text,message_id,message_read)"
					+ "VALUES ('041500001',CURRENT_DATE,'MODTESTCOURT','" + court + "','07111111111',NULL,'415000001','Your Jury Service','Reminder','1','NR')");
			pStmt.execute();

			pStmt = conn.prepareStatement("INSERT INTO juror_mod.message (juror_number,file_datetime,username,loc_code,phone,email,pool_no,subject,message_text,message_id,message_read)"
					+ "VALUES ('041500002',CURRENT_DATE,'MODTESTCOURT','" + court + "','07111111112',NULL,'415000002','Your Jury Service','Failed to attend','2','NR')");
			pStmt.execute();

			pStmt = conn.prepareStatement("INSERT INTO juror_mod.message (juror_number,file_datetime,username,loc_code,phone,email,pool_no,subject,message_text,message_id,message_read)"
					+ "VALUES ('041500003',CURRENT_DATE,'MODTESTCOURT','" + court + "','07111111113',NULL,'415000003','Your Jury Service','Date and Time Changed','3','NR')");
			pStmt.execute();

			pStmt = conn.prepareStatement("INSERT INTO juror_mod.message (juror_number,file_datetime,username,loc_code,phone,email,pool_no,subject,message_text,message_id,message_read)"
					+ "VALUES ('041500004',CURRENT_DATE,'MODTESTCOURT','" + court + "','07111111114',NULL,'415000004','Your Jury Service','Time Changed','4','NR')");
			pStmt.execute();

			pStmt = conn.prepareStatement("INSERT INTO juror_mod.message (juror_number,file_datetime,username,loc_code,phone,email,pool_no,subject,message_text,message_id,message_read)"
					+ "VALUES ('041500005',CURRENT_DATE,'MODTESTCOURT','" + court + "','07111111115',NULL,'415000005','Your Jury Service','Complete (attended)','5','NR')");
			pStmt.execute();

			pStmt = conn.prepareStatement("INSERT INTO juror_mod.message (juror_number,file_datetime,username,loc_code,phone,email,pool_no,subject,message_text,message_id,message_read)"
					+ "VALUES ('041500006',CURRENT_DATE,'MODTESTCOURT','" + court + "','07111111116',NULL,'415000006','Your Jury Service','Complete (not needed)','6','NR')");
			pStmt.execute();

			pStmt = conn.prepareStatement("INSERT INTO juror_mod.message (juror_number,file_datetime,username,loc_code,phone,email,pool_no,subject,message_text,message_id,message_read)"
					+ "VALUES ('041500007',CURRENT_DATE,'MODTESTCOURT','" + court + "','07111111117',NULL,'415000007','Your Jury Service','Next Date','7','NR')");
			pStmt.execute();

			pStmt = conn.prepareStatement("INSERT INTO juror_mod.message (juror_number,file_datetime,username,loc_code,phone,email,pool_no,subject,message_text,message_id,message_read)"
					+ "VALUES ('041500008',CURRENT_DATE,'MODTESTCOURT','" + court + "','07111111118',NULL,'415000008','Your Jury Service','On Call','8','NR')");
			pStmt.execute();

			pStmt = conn.prepareStatement("INSERT INTO juror_mod.message (juror_number,file_datetime,username,loc_code,phone,email,pool_no,subject,message_text,message_id,message_read)"
					+ "VALUES ('041500009',CURRENT_DATE,'MODTESTCOURT','" + court + "','07111111119',NULL,'415000009','Your Jury Service','Please Contact','9','NR')");
			pStmt.execute();

			pStmt = conn.prepareStatement("INSERT INTO juror_mod.message (juror_number,file_datetime,username,loc_code,phone,email,pool_no,subject,message_text,message_id,message_read)"
					+ "VALUES ('041500010',CURRENT_DATE,'MODTESTCOURT','" + court + "','07111111110',NULL,'415000010','Your Jury Service','Delayed start','10','NR')");
			pStmt.execute();

			pStmt = conn.prepareStatement("INSERT INTO juror_mod.message (juror_number,file_datetime,username,loc_code,phone,email,pool_no,subject,message_text,message_id,message_read)"
					+ "VALUES ('041500011',CURRENT_DATE,'MODTESTCOURT','" + court + "','07111111111',NULL,'415000011','Your Jury Service','Selection','11','NR')");
			pStmt.execute();

			pStmt = conn.prepareStatement("INSERT INTO juror_mod.message (juror_number,file_datetime,username,loc_code,phone,email,pool_no,subject,message_text,message_id,message_read)"
					+ "VALUES ('041500012',CURRENT_DATE,'MODTESTCOURT','" + court + "','07111111112',NULL,'415000012','Your Jury Service','Bad Weather','12','NR')");
			pStmt.execute();

			pStmt = conn.prepareStatement("INSERT INTO juror_mod.message (juror_number,file_datetime,username,loc_code,phone,email,pool_no,subject,message_text,message_id,message_read)"
					+ "VALUES ('041500013',CURRENT_DATE,'MODTESTCOURT','" + court + "','07111111113',NULL,'415000013','Your Jury Service','Check Junk','13','NR')");
			pStmt.execute();

			pStmt = conn.prepareStatement("INSERT INTO juror_mod.message (juror_number,file_datetime,username,loc_code,phone,email,pool_no,subject,message_text,message_id,message_read)"
					+ "VALUES ('041500014',CURRENT_DATE,'MODTESTCOURT','" + court + "','07111111114',NULL,'415000014','Your Jury Service','Bring Lunch','14','NR')");
			pStmt.execute();

			pStmt = conn.prepareStatement("INSERT INTO juror_mod.message (juror_number,file_datetime,username,loc_code,phone,email,pool_no,subject,message_text,message_id,message_read)"
					+ "VALUES ('041500015',CURRENT_DATE,'MODTESTCOURT','" + court + "','07111111115',NULL,'415000015','Your Jury Service','Excused','15','NR')");
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

	public void setJurorStatus(String jurorNumber, String jurorStatus) throws SQLException {
		db = new DBConnection();

		String env_property = System.getProperty("env.database");

		if (env_property != null)
			conn = db.getConnection(env_property);
		else
			conn = db.getConnection("demo");

		try {
			pStmt = conn.prepareStatement("update juror_mod.juror_pool set status='" + jurorStatus + "' where juror_number='" + jurorNumber + "'");
			pStmt.executeUpdate();

		} catch (SQLException e) {
			e.printStackTrace();
			log.error("Message:" + e.getMessage());

		} finally {
			conn.commit();
			pStmt.close();
			conn.close();
		}
	}

	public int getStatusNumber(String statusName) {
		switch (statusName) {
			case "Summoned":
				return 1;
			case "Responded":
				return 2;
			case "Panel":
				return 3;
			case "Juror":
				return 4;
			case "Excused":
				return 5;
			case "Disqualified":
				return 6;
			case "Deferred":
				return 7;
			case "Reassigned":
				return 8;
			case "Undeliverable":
				return 9;
			case "Transferred":
				return 10;
			case "Awaiting Info":
				return 11;
			case "FailedToAttend":
				return 12;
			case "Completed":
				return 13;
			default:
				throw new IllegalArgumentException("Invalid status name: " + statusName);
		}
	}

	public void insertConfirmationLetter(String jurorNumber) throws SQLException {
		db = new DBConnection();

		String env_property = System.getProperty("env.database");

		if (env_property != null)
			conn = db.getConnection(env_property);
		else
			conn = db.getConnection("demo");

		try {

			pStmt = conn.prepareStatement("DELETE from juror_mod.bulk_print_data where juror_no='" + jurorNumber + "'");
			pStmt.executeUpdate();

			pStmt = conn.prepareStatement("INSERT INTO juror_mod.bulk_print_data (juror_no,creation_date,form_type,detail_rec,extracted_flag,digital_comms)"
					+ "VALUES ('" + jurorNumber + "',NOW(),'5224A','04 JULY 2024      415THE CROWN COURT AT CHESTER                                 JURY CENTRAL SUMMONING BUREAU           THE COURT SERVICE                  FREEPOST LON 19669                 POCOCK STREET                      LONDON                                                                                                   SE1 0YG   0845 3555567            MONDAY 15 JULY, 2024            09:00             0FNAME2             TESTNAME            ADDRESS                                                                                                                                                                                                           CH1 2NN   041500002JURY MANAGER                  ',false,false)");
			pStmt.executeUpdate();

		} catch (SQLException e) {
			e.printStackTrace();
			log.error("Message:" + e.getMessage());

		} finally {
			conn.commit();
			pStmt.close();
			conn.close();
		}

	}

	public void insertInitialSummonsLetter(String jurorNumber, String poolNumber) throws SQLException {
		db = new DBConnection();

		String env_property = System.getProperty("env.database");

		if (env_property != null)
			conn = db.getConnection(env_property);
		else
			conn = db.getConnection("demo");

		try {

			pStmt = conn.prepareStatement("DELETE from juror_mod.bulk_print_data where juror_no='" + jurorNumber + "'");
			pStmt.executeUpdate();

			pStmt = conn.prepareStatement("INSERT INTO juror_mod.bulk_print_data (juror_no,creation_date,form_type,detail_rec,extracted_flag,digital_comms)"
					+ "VALUES ('" + jurorNumber + "',NOW(),'5221','" + poolNumber + "          FNAMESEVENTHREEEIGHTLNAMESEVENTHREEEIGHT738 STREET NAME                    ANYTOWN                            ANYCITY                            CH1 2AN                                                                                                            14150073814150073826 AUGUST 2024    TUESDAY 22 OCTOBER, 2024        9:00AM  415Y                   THE CROWN COURT AT CHESTER                                 THE CASTLE                         CHESTER                            CH1 2AN                                                                                                                                               01244 356726            JURY MANAGER                  JURY CENTRAL SUMMONING BUREAU           THE COURT SERVICE                  FREEPOST LON 19669                 POCOCK STREET                      LONDON                             SE1 0YG                                                                         0845 3555567            ',true,false)");
			pStmt.executeUpdate();

		} catch (SQLException e) {
			e.printStackTrace();
			log.error("Message:" + e.getMessage());

		} finally {
			conn.commit();
			pStmt.close();
			conn.close();
		}

	}

	public void updatePendingLetterForInitialSummons(String poolNumber) throws SQLException {
		db = new DBConnection();

		String env_property = System.getProperty("env.database");

		if (env_property != null)
			conn = db.getConnection(env_property);
		else
			conn = db.getConnection("demo");
		try {
			log.info("Printing letters for pool: " + poolNumber);
			pStmt = conn.prepareStatement("UPDATE juror_mod.bulk_print_data SET extracted_flag=true WHERE detail_rec LIKE '%" + poolNumber + "%'");
			pStmt.executeUpdate();

		} catch (SQLException e) {
			e.printStackTrace();
			log.error("Message:" + e.getMessage());
		} finally {
			conn.commit();
			pStmt.close();
			conn.close();
		}
	}

	public void deletePendingLettersForInitialSummons(String pool) throws SQLException {
		db = new DBConnection();

		String env_property = System.getProperty("env.database");

		if (env_property != null)
			conn = db.getConnection(env_property);
		else
			conn = db.getConnection("demo");

		try {
			pStmt = conn.prepareStatement("DELETE FROM juror_mod.bulk_print_data WHERE form_type='5221' AND extracted_flag IS FALSE AND juror_no in (select juror_number from juror_mod.juror_pool where pool_number = '" + pool + "')");
			pStmt.executeUpdate();

		} catch (SQLException e) {
			e.printStackTrace();
			log.error("Message:" + e.getMessage());
		} finally {
			conn.commit();
			pStmt.close();
			conn.close();
			log.info("Database was updated successfully");
		}
	}

	public void updateBureauTransferDate(String jurorNumber) throws SQLException {
		db = new DBConnection();

		String env_property = System.getProperty("env.database");

		if (env_property != null)
			conn = db.getConnection(env_property);
		else
			conn = db.getConnection("demo");

		try {

			pStmt = conn.prepareStatement("update juror_mod.juror set bureau_transfer_date =CURRENT_DATE-1  where juror_number='" + jurorNumber + "'");
			pStmt.executeUpdate();

		} catch (SQLException e) {
			e.printStackTrace();
			log.error("Message:" + e.getMessage());

		} finally {
			conn.commit();
			pStmt.close();
			conn.close();
		}
	}

	public void setExpenseDailyTransportLimit() throws SQLException {
		db = new DBConnection();

		String env_property = System.getProperty("env.database");

		if (env_property != null)
			conn = db.getConnection(env_property);
		else
			conn = db.getConnection("demo");

		try {
			pStmt = conn.prepareStatement("update juror_mod.court_location set public_transport_soft_limit = 10,taxi_soft_limit = 10 where loc_code = '415'");
			pStmt.executeUpdate();

		} catch (SQLException e) {
			e.printStackTrace();
			log.error("Message:" + e.getMessage());

		} finally {
			conn.commit();
			pStmt.close();
			conn.close();
		}
	}

	public void updateAppearanceForShowCause(String jurorNumber) throws SQLException {
		db = new DBConnection();

		String env_property = System.getProperty("env.database");

		if (env_property != null)
			conn = db.getConnection(env_property);
		else
			conn = db.getConnection("demo");

		try {

			pStmt = conn.prepareStatement("UPDATE juror_mod.appearance set no_show='true' where juror_number='" + jurorNumber + "'");
			pStmt.executeUpdate();

			pStmt = conn.prepareStatement("UPDATE juror_mod.appearance set attendance_type='ABSENT' where juror_number='" + jurorNumber + "'");
			pStmt.executeUpdate();

		} catch (SQLException e) {
			e.printStackTrace();
			log.error("Message:" + e.getMessage());

		} finally {
			conn.commit();
			pStmt.close();
			conn.close();
		}
	}

	public void clearBankHolidayTableData() throws SQLException {
		db = new DBConnection();

		String env_property = System.getProperty("env.database");

		if (env_property != null)
			conn = db.getConnection(env_property);
		else
			conn = db.getConnection("demo");

		try {

			pStmt = conn.prepareStatement("delete from juror_mod.holiday");
			pStmt.executeUpdate();


		} catch (SQLException e) {
			e.printStackTrace();
			log.error("Message:" + e.getMessage());

		} finally {
			conn.commit();
			pStmt.close();
			conn.close();
		}
	}


	public void insertHolidayInTheFrontScreen(Integer noOfWeeks, String owner) throws SQLException {
		db = new DBConnection();

		String env_property = System.getProperty("env.database");

		if (env_property != null)
			conn = db.getConnection(env_property);
		else
			conn = db.getConnection("demo");

		String datePattern = "YYYY-MM-DD";
		Calendar calendar = Calendar.getInstance();
		calendar.add(Calendar.WEEK_OF_MONTH, noOfWeeks);

		LocalDate localDate = calendar.toInstant().atZone(ZoneId.systemDefault()).toLocalDate();
		Date mondayDate = Date.from(localDate.atStartOfDay().atZone(ZoneId.systemDefault()).toInstant());

		try {

			pStmt = conn.prepareStatement("INSERT INTO JUROR_MOD.HOLIDAY(LOC_CODE,HOLIDAY,DESCRIPTION,PUBLIC)"
					+ "VALUES ('" + owner + "','" + mondayDate + "','Test holiday',true)");
			pStmt.execute();

		} catch (SQLException e) {
			e.printStackTrace();
			log.error("Message:inserted bank holiday for '" + owner + "' on '" + mondayDate + "' " + e.getMessage());
		} finally {
			conn.commit();
			pStmt.close();
			conn.close();
		}
	}

	public void setJurorsAttendanceDate(String jurorNumber) throws SQLException {
		db = new DBConnection();

		String env_property = System.getProperty("env.database");

		if (env_property != null)
			conn = db.getConnection(env_property);
		else
			conn = db.getConnection("demo");

		try {

			pStmt = conn.prepareStatement("UPDATE juror_mod.appearance set no_show='true' where juror_number='" + jurorNumber + "'");
			pStmt.executeUpdate();

			pStmt = conn.prepareStatement("UPDATE juror_mod.appearance set attendance_type='ABSENT' where juror_number='" + jurorNumber + "'");
			pStmt = conn.prepareStatement("update  juror_mod.juror_pool set next_date = CURRENT_TIMESTAMP  where juror_number='" + jurorNumber + "'");
			pStmt.executeUpdate();
			pStmt = conn.prepareStatement("delete from juror_mod.holiday");
			pStmt.executeUpdate();


		} catch (SQLException e) {
			e.printStackTrace();
			log.error("Message:" + e.getMessage());

		} finally {
			conn.commit();
			pStmt.close();
			conn.close();
		}
	}

	public void setPoolNumberInAttendanceTable(String poolnumber, String jurornumber) throws SQLException {

		db = new DBConnection();

		String env_property = System.getProperty("env.database");

		if (env_property != null)
			conn = db.getConnection(env_property);
		else
			conn = db.getConnection("demo");

		try {
			pStmt = conn.prepareStatement("update juror_mod.appearance set pool_number ='" + poolnumber + "' where juror_number='" + jurornumber + "'");
			pStmt.executeUpdate();

		} catch (SQLException e) {
			e.printStackTrace();
			log.error("Message:" + e.getMessage());

		} finally {
			conn.commit();
			pStmt.close();
			conn.close();
		}
	}

	public void updatePoliceCheck(String jurorNumber, String policeCheck) throws SQLException {

		db = new DBConnection();

		String env_property = System.getProperty("env.database");

		if (env_property != null)
			conn = db.getConnection(env_property);
		else
			conn = db.getConnection("demo");

		try {
			pStmt = conn.prepareStatement("update juror_mod.juror set police_check ='" + policeCheck + "' where juror_number='" + jurorNumber + "'");
			pStmt.executeUpdate();

			pStmt = conn.prepareStatement("update juror_mod.juror_pool set status='6' where juror_number='" + jurorNumber + "'");
			pStmt.executeUpdate();

		} catch (SQLException e) {
			e.printStackTrace();
			log.error("Message:" + e.getMessage());

		} finally {
			conn.commit();
			pStmt.close();
			conn.close();
		}
	}

	public void updateServiceStartDate(String returnDate, String poolNumber) throws SQLException {

		db = new DBConnection();
		String env_property = System.getProperty("env.database");

		if (env_property != null)
			conn = db.getConnection(env_property);
		else
			conn = db.getConnection("demo");

		try {
			pStmt = conn.prepareStatement("update juror_mod.pool set return_date ='" + returnDate + "' where pool_no='" + poolNumber + "'");
			pStmt.executeUpdate();

		} catch (SQLException e) {
			e.printStackTrace();
			log.error("Message:" + e.getMessage());

		} finally {
			conn.commit();
			pStmt.close();
			conn.close();
		}
	}

	public void updateJurorName(String firstName, String lastName, String jurorNumber) throws SQLException {

		db = new DBConnection();
		String env_property = System.getProperty("env.database");

		if (env_property != null)
			conn = db.getConnection(env_property);
		else
			conn = db.getConnection("demo");

		try {
			pStmt = conn.prepareStatement("update juror_mod.juror set first_name ='" + firstName + "', last_name ='" + lastName + "' where juror_number='" + jurorNumber + "'");
			pStmt.executeUpdate();

			System.out.println("Juror " + jurorNumber + " was updated.");


		} catch (SQLException e) {
			e.printStackTrace();
			log.error("Message:" + e.getMessage());

		} finally {
			conn.commit();
			pStmt.close();
			conn.close();
		}
	}

	public void checkExcusalCodePresent(String jurorNumber) throws SQLException {
		db = new DBConnection();
		ResultSet rs = null;

		String env_property = System.getProperty("env.database");

		if (env_property != null)
			conn = db.getConnection(env_property);
		else
			conn = db.getConnection("demo");

		try {
			pStmt = conn.prepareStatement("SELECT excusal_code FROM juror_mod.juror WHERE juror_number = ?");
			pStmt.setString(1, jurorNumber);
			rs = pStmt.executeQuery();

			if (rs.next()) {
				String excusalCode = rs.getString("excusal_code");

				if (excusalCode == null) {
					log.info("Juror number " + jurorNumber + " has no excusal code. Updating to 'O'.");

					pStmt = conn.prepareStatement("UPDATE juror_mod.juror SET excusal_code = 'O' WHERE juror_number = ?");
					pStmt.setString(1, jurorNumber);
					pStmt.executeUpdate();
				} else {
					log.info("Juror number " + jurorNumber + " already has an excusal code: " + excusalCode);
				}
			}

		} catch (SQLException e) {
			e.printStackTrace();
			log.error("Message:" + e.getMessage());

		} finally {
			if (rs != null) rs.close();
			conn.commit();
			pStmt.close();
			conn.close();
		}
	}

	public void enableDisableCreateJurorPermissionForBureauUser(String enableDisable, String user) throws SQLException {
		db = new DBConnection();
		String env_property = System.getProperty("env.database");
		if (env_property != null)
			conn = db.getConnection(env_property);
		else
			conn = db.getConnection("demo");
		try {
			if (Objects.equals(enableDisable, "enable")) {
				pStmt = conn.prepareStatement("insert into juror_mod.user_permissions (username, permission) VALUES ('" + user + "', 'CREATE_JUROR')");
				pStmt.executeUpdate();
				conn.commit();
				log.info("Set CREATE_USER permission for =>" + user);
			} else
				pStmt = conn.prepareStatement("delete from juror_mod.user_permissions where username='" + user + "'");
			pStmt.executeUpdate();
			conn.commit();
			log.info("Deleted CREATE_USER permission for =>" + user);

		} catch (SQLException e) {
			e.printStackTrace();
			log.error("Message:" + e.getMessage());
		} finally {
			conn.commit();
			conn.close();
		}

	}

	public void setJurorsDob(String jurorNumber) throws SQLException {
		db = new DBConnection();

		String env_property = System.getProperty("env.database");

		if (env_property != null)
			conn = db.getConnection(env_property);
		else
			conn = db.getConnection("demo");

		try {
			pStmt = conn.prepareStatement("UPDATE juror_mod.juror set DOB='03-OCT-1992' where juror_number='" + jurorNumber + "'");
			pStmt.executeUpdate();

		} catch (SQLException e) {
			e.printStackTrace();
			log.error("Message:" + e.getMessage());

		} finally {
			conn.commit();
			pStmt.close();
			conn.close();
		}
	}

	public void updatePoolType(String poolType, String poolNumber) throws SQLException {
		db = new DBConnection();

		String env_property = System.getProperty("env.database");

		if (env_property != null)
			conn = db.getConnection(env_property);
		else
			conn = db.getConnection("demo");

		try {
			pStmt = conn.prepareStatement("UPDATE juror_mod.pool set pool_type='" + poolType + "' where pool_no='" + poolNumber + "'");
			pStmt.executeUpdate();

		} catch (SQLException e) {
			e.printStackTrace();
			log.error("Message:" + e.getMessage());

		} finally {
			conn.commit();
			pStmt.close();
			conn.close();
		}
	}

	public void cleanSummonedJurorsInPool(String pool_no) throws SQLException {
		db = new DBConnection();
		String env_property = System.getProperty("env.database");
		if (env_property != null)
			conn = db.getConnection(env_property);
		else
			conn = db.getConnection("demo");
		try {
			pStmt = conn.prepareStatement("delete from juror_mod.juror_pool where pool_number=?");
			pStmt.setString(1, pool_no);
			pStmt.executeUpdate();
			log.info("Deleted from juror_mod.juror_pool where pool_number=>" + pool_no);

		} catch (SQLException e) {
			e.printStackTrace();
			log.error("Message:" + e.getMessage());
		} finally {
			conn.commit();
			pStmt.close();
			conn.close();
		}
	}

	public void insertAppearanceRecordsNSD(String jurorNumber, String locCode, String poolNumber) throws SQLException {
		db = new DBConnection();
		String env_property = System.getProperty("env.database");
		if (env_property != null)
			conn = db.getConnection(env_property);
		else
			conn = db.getConnection("demo");

		try {
			StringBuilder sql = new StringBuilder("INSERT INTO juror_mod.appearance (attendance_date, juror_number, loc_code, time_in, time_out, trial_number, non_attendance, no_show, misc_description, pay_cash, last_updated_by, created_by, public_transport_total_due, public_transport_total_paid, hired_vehicle_total_due, hired_vehicle_total_paid, motorcycle_total_due, motorcycle_total_paid, car_total_due, car_total_paid, pedal_cycle_total_due, pedal_cycle_total_paid, childcare_total_due, childcare_total_paid, parking_total_due, parking_total_paid, misc_total_due, misc_total_paid, smart_card_due, is_draft_expense, f_audit, sat_on_jury, pool_number, appearance_stage, loss_of_earnings_due, loss_of_earnings_paid, subsistence_due, subsistence_paid, attendance_type, smart_card_paid, travel_time, travel_jurors_taken_by_car, travel_by_car, travel_jurors_taken_by_motorcycle, travel_by_motorcycle, travel_by_bicycle, miles_traveled, food_and_drink_claim_type, \"version\", expense_rates_id, attendance_audit_number, appearance_confirmed, hide_on_unpaid_expense_and_reports) VALUES ");

			for (int i = 0; i < 200; i++) {
				if (i > 0) sql.append(","); // Add comma between multiple rows
				sql.append("(?, ?, ?, '10:00:00', '16:30:00', NULL, false, NULL, NULL, false, NULL, 'MODTESTCOURT', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, true, NULL, true, ?, 'EXPENSE_ENTERED', NULL, NULL, 0.00, NULL, 'FULL_DAY', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'NONE', 4, NULL, NULL, true, false)");
			}

			pStmt = conn.prepareStatement(sql.toString());
			LocalDate date = LocalDate.of(2024, 1, 8);
			int paramIndex = 1;
			for (int i = 0; i < 200; i++) {
				pStmt.setDate(paramIndex++, java.sql.Date.valueOf(date));
				pStmt.setString(paramIndex++, jurorNumber);
				pStmt.setString(paramIndex++, locCode);
				pStmt.setString(paramIndex++, poolNumber);
				date = date.plusDays(1);
			}

			pStmt.execute();
			log.info("Inserted 200 appearance records for juror " + jurorNumber);

		} catch (SQLException e) {
			e.printStackTrace();
			log.error("Message:" + e.getMessage());
		} finally {
			conn.commit();
			pStmt.close();
			conn.close();
		}
	}

	public void insertAppearanceRecordsWithExpensesNSD(String locCode) throws SQLException {
		db = new DBConnection();
		String env_property = System.getProperty("env.database");

		if (env_property != null)
			conn = db.getConnection(env_property);
		else
			conn = db.getConnection("demo");

		try {

			//loss of earnings expense
			pStmt = conn.prepareStatement ("INSERT INTO juror_mod.appearance (attendance_date, juror_number, loc_code, time_in, time_out, trial_number, non_attendance, no_show, misc_description, pay_cash, last_updated_by, created_by, public_transport_total_due, public_transport_total_paid, hired_vehicle_total_due, hired_vehicle_total_paid, motorcycle_total_due, motorcycle_total_paid, car_total_due, car_total_paid, pedal_cycle_total_due, pedal_cycle_total_paid, childcare_total_due, childcare_total_paid, parking_total_due, parking_total_paid, misc_total_due, misc_total_paid, smart_card_due, is_draft_expense, f_audit, sat_on_jury, pool_number, appearance_stage, loss_of_earnings_due, loss_of_earnings_paid, subsistence_due, subsistence_paid, attendance_type, smart_card_paid, travel_time, travel_jurors_taken_by_car, travel_by_car, travel_jurors_taken_by_motorcycle, travel_by_motorcycle, travel_by_bicycle, miles_traveled, food_and_drink_claim_type, version, expense_rates_id, attendance_audit_number, total_due, total_paid, appearance_confirmed, hide_on_unpaid_expense_and_reports)"
					+ "VALUES (CURRENT_DATE-50, '040127001', ?, '10:00:00', '16:30:00', NULL, false, NULL, '', false, NULL, 'MODTESTCOURT', NULL, NULL, 0.00, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0.00, NULL, NULL, NULL, NULL, FALSE, NULL, NULL, '401270001', 'EXPENSE_AUTHORISED', '100000.00', '100000.00', 0.00, NULL, 'FULL_DAY', NULL, '00:00:00', NULL, FALSE, NULL, FALSE, FALSE, NULL, 'NONE', 4, '1', 'P12700001', DEFAULT , DEFAULT, true, false)");
			pStmt.setString(1, locCode);
			pStmt.executeUpdate();

			log.info("Inserted appearance record with LOSS OF EARNINGS expense for juror");

			//extra care expense
			pStmt = conn.prepareStatement ("INSERT INTO juror_mod.appearance (attendance_date, juror_number, loc_code, time_in, time_out, trial_number, non_attendance, no_show, misc_description, pay_cash, last_updated_by, created_by, public_transport_total_due, public_transport_total_paid, hired_vehicle_total_due, hired_vehicle_total_paid, motorcycle_total_due, motorcycle_total_paid, car_total_due, car_total_paid, pedal_cycle_total_due, pedal_cycle_total_paid, childcare_total_due, childcare_total_paid, parking_total_due, parking_total_paid, misc_total_due, misc_total_paid, smart_card_due, is_draft_expense, f_audit, sat_on_jury, pool_number, appearance_stage, loss_of_earnings_due, loss_of_earnings_paid, subsistence_due, subsistence_paid, attendance_type, smart_card_paid, travel_time, travel_jurors_taken_by_car, travel_by_car, travel_jurors_taken_by_motorcycle, travel_by_motorcycle, travel_by_bicycle, miles_traveled, food_and_drink_claim_type, version, expense_rates_id, attendance_audit_number, total_due, total_paid, appearance_confirmed, hide_on_unpaid_expense_and_reports)"
					+ "VALUES (CURRENT_DATE-49, '040127001', ?, '10:00:00', '16:30:00', NULL, false, NULL, '', false, NULL, 'MODTESTCOURT', NULL, NULL, 0.00, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '110000.00', '110000.00', 0.00, NULL, NULL, NULL, NULL, FALSE, NULL, NULL, '401270001', 'EXPENSE_AUTHORISED', NULL, NULL, 0.00, NULL, 'FULL_DAY', NULL, '00:00:00', NULL, FALSE, NULL, FALSE, FALSE, NULL, 'NONE', 4, '1', 'P12700002', DEFAULT, DEFAULT, true, false)");
			pStmt.setString(1, locCode);
			pStmt.executeUpdate();

			log.info("Inserted appearance record with EXTRA CARE expense for juror");

			//OTHER expense
			pStmt = conn.prepareStatement ("INSERT INTO juror_mod.appearance (attendance_date, juror_number, loc_code, time_in, time_out, trial_number, non_attendance, no_show, misc_description, pay_cash, last_updated_by, created_by, public_transport_total_due, public_transport_total_paid, hired_vehicle_total_due, hired_vehicle_total_paid, motorcycle_total_due, motorcycle_total_paid, car_total_due, car_total_paid, pedal_cycle_total_due, pedal_cycle_total_paid, childcare_total_due, childcare_total_paid, parking_total_due, parking_total_paid, misc_total_due, misc_total_paid, smart_card_due, is_draft_expense, f_audit, sat_on_jury, pool_number, appearance_stage, loss_of_earnings_due, loss_of_earnings_paid, subsistence_due, subsistence_paid, attendance_type, smart_card_paid, travel_time, travel_jurors_taken_by_car, travel_by_car, travel_jurors_taken_by_motorcycle, travel_by_motorcycle, travel_by_bicycle, miles_traveled, food_and_drink_claim_type, version, expense_rates_id, attendance_audit_number, total_due, total_paid, appearance_confirmed, hide_on_unpaid_expense_and_reports)"
					+ "VALUES (CURRENT_DATE-48, '040127001', ?, '10:00:00', '16:30:00', NULL, false, NULL, '', false, NULL, 'MODTESTCOURT', NULL, NULL, 0.00, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0.00, NULL, '120000.00', '120000.00', NULL, FALSE, NULL, NULL, '401270001', 'EXPENSE_AUTHORISED', NULL, NULL, 0.00, NULL, 'FULL_DAY', NULL, '00:00:00', NULL, FALSE, NULL, FALSE, FALSE, NULL, 'NONE', 4, '1', 'P12700003', DEFAULT, DEFAULT, true, false)");
			pStmt.setString(1, locCode);
			pStmt.executeUpdate();

			log.info("Inserted appearance record with OTHER expense for juror");

			//public transport expense
			pStmt = conn.prepareStatement ("INSERT INTO juror_mod.appearance (attendance_date, juror_number, loc_code, time_in, time_out, trial_number, non_attendance, no_show, misc_description, pay_cash, last_updated_by, created_by, public_transport_total_due, public_transport_total_paid, hired_vehicle_total_due, hired_vehicle_total_paid, motorcycle_total_due, motorcycle_total_paid, car_total_due, car_total_paid, pedal_cycle_total_due, pedal_cycle_total_paid, childcare_total_due, childcare_total_paid, parking_total_due, parking_total_paid, misc_total_due, misc_total_paid, smart_card_due, is_draft_expense, f_audit, sat_on_jury, pool_number, appearance_stage, loss_of_earnings_due, loss_of_earnings_paid, subsistence_due, subsistence_paid, attendance_type, smart_card_paid, travel_time, travel_jurors_taken_by_car, travel_by_car, travel_jurors_taken_by_motorcycle, travel_by_motorcycle, travel_by_bicycle, miles_traveled, food_and_drink_claim_type, version, expense_rates_id, attendance_audit_number, total_due, total_paid, appearance_confirmed, hide_on_unpaid_expense_and_reports)"
					+ "VALUES (CURRENT_DATE-47, '040127001', ?, '10:00:00', '16:30:00', NULL, false, NULL, '', false, NULL, 'MODTESTCOURT', '130000.00', '130000.00', 0.00, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0.00, NULL, NULL, NULL, NULL, FALSE, NULL, NULL, '401270001', 'EXPENSE_AUTHORISED', NULL, NULL, 0.00, NULL, 'FULL_DAY', NULL, '00:00:00', NULL, FALSE, NULL, FALSE, FALSE, NULL, 'NONE', 4, '1', 'P12700000', DEFAULT , DEFAULT, true, false)");
			pStmt.setString(1, locCode);
			pStmt.executeUpdate();

			log.info("Inserted appearance record with PUBLIC TRANSPORT expense for juror");

			//TAXI expense
			pStmt = conn.prepareStatement ("INSERT INTO juror_mod.appearance (attendance_date, juror_number, loc_code, time_in, time_out, trial_number, non_attendance, no_show, misc_description, pay_cash, last_updated_by, created_by, public_transport_total_due, public_transport_total_paid, hired_vehicle_total_due, hired_vehicle_total_paid, motorcycle_total_due, motorcycle_total_paid, car_total_due, car_total_paid, pedal_cycle_total_due, pedal_cycle_total_paid, childcare_total_due, childcare_total_paid, parking_total_due, parking_total_paid, misc_total_due, misc_total_paid, smart_card_due, is_draft_expense, f_audit, sat_on_jury, pool_number, appearance_stage, loss_of_earnings_due, loss_of_earnings_paid, subsistence_due, subsistence_paid, attendance_type, smart_card_paid, travel_time, travel_jurors_taken_by_car, travel_by_car, travel_jurors_taken_by_motorcycle, travel_by_motorcycle, travel_by_bicycle, miles_traveled, food_and_drink_claim_type, version, expense_rates_id, attendance_audit_number, total_due, total_paid, appearance_confirmed, hide_on_unpaid_expense_and_reports)"
					+ "VALUES (CURRENT_DATE-46, '040127001', ?, '10:00:00', '16:30:00', NULL, false, NULL, '', false, NULL, 'MODTESTCOURT', NULL, NULL, '140000.00', '140000.00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0.00, NULL, NULL, NULL, NULL, FALSE, NULL, NULL, '401270001', 'EXPENSE_AUTHORISED', NULL, NULL, 0.00, NULL, 'FULL_DAY', NULL, '00:00:00', NULL, FALSE, NULL, FALSE, FALSE, NULL, 'NONE', 4, '1', 'P12700004', DEFAULT, DEFAULT, true, false)");
			pStmt.setString(1, locCode);
			pStmt.executeUpdate();

			log.info("Inserted appearance record with TAXI expense for juror");

			//MOTORCYCLE expense
			pStmt = conn.prepareStatement ("INSERT INTO juror_mod.appearance (attendance_date, juror_number, loc_code, time_in, time_out, trial_number, non_attendance, no_show, misc_description, pay_cash, last_updated_by, created_by, public_transport_total_due, public_transport_total_paid, hired_vehicle_total_due, hired_vehicle_total_paid, motorcycle_total_due, motorcycle_total_paid, car_total_due, car_total_paid, pedal_cycle_total_due, pedal_cycle_total_paid, childcare_total_due, childcare_total_paid, parking_total_due, parking_total_paid, misc_total_due, misc_total_paid, smart_card_due, is_draft_expense, f_audit, sat_on_jury, pool_number, appearance_stage, loss_of_earnings_due, loss_of_earnings_paid, subsistence_due, subsistence_paid, attendance_type, smart_card_paid, travel_time, travel_jurors_taken_by_car, travel_by_car, travel_jurors_taken_by_motorcycle, travel_by_motorcycle, travel_by_bicycle, miles_traveled, food_and_drink_claim_type, version, expense_rates_id, attendance_audit_number, total_due, total_paid, appearance_confirmed, hide_on_unpaid_expense_and_reports)"
					+ "VALUES (CURRENT_DATE-45, '040127001', ?, '10:00:00', '16:30:00', NULL, false, NULL, '', false, NULL, 'MODTESTCOURT', NULL, NULL, NULL, NULL, '150000.00', '150000.00', NULL, NULL, NULL, NULL, NULL, NULL, 0.00, NULL, NULL, NULL, NULL, FALSE, NULL, NULL, '401270001', 'EXPENSE_AUTHORISED', NULL, NULL, 0.00, NULL, 'FULL_DAY', NULL, '00:00:00', NULL, FALSE, NULL, FALSE, FALSE, NULL, 'NONE', 4, '1', 'P12700005', DEFAULT , DEFAULT, true, false)");
			pStmt.setString(1, locCode);
			pStmt.executeUpdate();

			log.info("Inserted appearance record with TAXI expense for juror");

			//CAR expense
			pStmt = conn.prepareStatement ("INSERT INTO juror_mod.appearance (attendance_date, juror_number, loc_code, time_in, time_out, trial_number, non_attendance, no_show, misc_description, pay_cash, last_updated_by, created_by, public_transport_total_due, public_transport_total_paid, hired_vehicle_total_due, hired_vehicle_total_paid, motorcycle_total_due, motorcycle_total_paid, car_total_due, car_total_paid, pedal_cycle_total_due, pedal_cycle_total_paid, childcare_total_due, childcare_total_paid, parking_total_due, parking_total_paid, misc_total_due, misc_total_paid, smart_card_due, is_draft_expense, f_audit, sat_on_jury, pool_number, appearance_stage, loss_of_earnings_due, loss_of_earnings_paid, subsistence_due, subsistence_paid, attendance_type, smart_card_paid, travel_time, travel_jurors_taken_by_car, travel_by_car, travel_jurors_taken_by_motorcycle, travel_by_motorcycle, travel_by_bicycle, miles_traveled, food_and_drink_claim_type, version, expense_rates_id, attendance_audit_number, total_due, total_paid, appearance_confirmed, hide_on_unpaid_expense_and_reports)"
					+ "VALUES (CURRENT_DATE-44, '040127001', ?, '10:00:00', '16:30:00', NULL, false, NULL, '', false, NULL, 'MODTESTCOURT', NULL, NULL, NULL, NULL, NULL, NULL, '150000.00', '150000.00', NULL, NULL, NULL, NULL, 0.00, NULL, NULL, NULL, NULL, FALSE, NULL, NULL, '401270001', 'EXPENSE_AUTHORISED', NULL, NULL, 0.00, NULL, 'FULL_DAY', NULL, '00:00:00', NULL, FALSE, NULL, FALSE, FALSE, NULL, 'NONE', 4, '1', 'P12700006', DEFAULT , DEFAULT, true, false)");
			pStmt.setString(1, locCode);
			pStmt.executeUpdate();

			log.info("Inserted appearance record with CAR expense for juror");

			//BICYCLE expense
			pStmt = conn.prepareStatement ("INSERT INTO juror_mod.appearance (attendance_date, juror_number, loc_code, time_in, time_out, trial_number, non_attendance, no_show, misc_description, pay_cash, last_updated_by, created_by, public_transport_total_due, public_transport_total_paid, hired_vehicle_total_due, hired_vehicle_total_paid, motorcycle_total_due, motorcycle_total_paid, car_total_due, car_total_paid, pedal_cycle_total_due, pedal_cycle_total_paid, childcare_total_due, childcare_total_paid, parking_total_due, parking_total_paid, misc_total_due, misc_total_paid, smart_card_due, is_draft_expense, f_audit, sat_on_jury, pool_number, appearance_stage, loss_of_earnings_due, loss_of_earnings_paid, subsistence_due, subsistence_paid, attendance_type, smart_card_paid, travel_time, travel_jurors_taken_by_car, travel_by_car, travel_jurors_taken_by_motorcycle, travel_by_motorcycle, travel_by_bicycle, miles_traveled, food_and_drink_claim_type, version, expense_rates_id, attendance_audit_number, total_due, total_paid, appearance_confirmed, hide_on_unpaid_expense_and_reports)"
					+ "VALUES (CURRENT_DATE-43, '040127001', ?, '10:00:00', '16:30:00', NULL, false, NULL, '', false, NULL, 'MODTESTCOURT', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '150000.00', '170000.00', NULL, NULL, 0.00, NULL, NULL, NULL, NULL, FALSE, NULL, NULL, '401270001', 'EXPENSE_AUTHORISED', NULL, NULL, 0.00, NULL, 'FULL_DAY', NULL, '00:00:00', NULL, FALSE, NULL, FALSE, FALSE, NULL, 'NONE', 4, '1', 'P12700007', DEFAULT , DEFAULT, true, false)");
			pStmt.setString(1, locCode);
			pStmt.executeUpdate();

			log.info("Inserted appearance record with BICYCLE expense for juror");

			//PARKING expense
			pStmt = conn.prepareStatement ("INSERT INTO juror_mod.appearance (attendance_date, juror_number, loc_code, time_in, time_out, trial_number, non_attendance, no_show, misc_description, pay_cash, last_updated_by, created_by, public_transport_total_due, public_transport_total_paid, hired_vehicle_total_due, hired_vehicle_total_paid, motorcycle_total_due, motorcycle_total_paid, car_total_due, car_total_paid, pedal_cycle_total_due, pedal_cycle_total_paid, childcare_total_due, childcare_total_paid, parking_total_due, parking_total_paid, misc_total_due, misc_total_paid, smart_card_due, is_draft_expense, f_audit, sat_on_jury, pool_number, appearance_stage, loss_of_earnings_due, loss_of_earnings_paid, subsistence_due, subsistence_paid, attendance_type, smart_card_paid, travel_time, travel_jurors_taken_by_car, travel_by_car, travel_jurors_taken_by_motorcycle, travel_by_motorcycle, travel_by_bicycle, miles_traveled, food_and_drink_claim_type, version, expense_rates_id, attendance_audit_number, total_due, total_paid, appearance_confirmed, hide_on_unpaid_expense_and_reports)"
					+ "VALUES (CURRENT_DATE-42, '040127001', ?, '10:00:00', '16:30:00', NULL, false, NULL, '', false, NULL, 'MODTESTCOURT', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '180000.00', '180000.00', NULL, NULL, NULL, FALSE, NULL, NULL, '401270001', 'EXPENSE_AUTHORISED', NULL, NULL, 0.00, NULL, 'FULL_DAY', NULL, '00:00:00', NULL, FALSE, NULL, FALSE, FALSE, NULL, 'NONE', 4, '1', 'P12700008', DEFAULT , DEFAULT, true, false)");
			pStmt.setString(1, locCode);
			pStmt.executeUpdate();

			log.info("Inserted appearance record with PARKING expense for juror");

			//FOOD AND DRINK expense
			pStmt = conn.prepareStatement ("INSERT INTO juror_mod.appearance (attendance_date, juror_number, loc_code, time_in, time_out, trial_number, non_attendance, no_show, misc_description, pay_cash, last_updated_by, created_by, public_transport_total_due, public_transport_total_paid, hired_vehicle_total_due, hired_vehicle_total_paid, motorcycle_total_due, motorcycle_total_paid, car_total_due, car_total_paid, pedal_cycle_total_due, pedal_cycle_total_paid, childcare_total_due, childcare_total_paid, parking_total_due, parking_total_paid, misc_total_due, misc_total_paid, smart_card_due, is_draft_expense, f_audit, sat_on_jury, pool_number, appearance_stage, loss_of_earnings_due, loss_of_earnings_paid, subsistence_due, subsistence_paid, attendance_type, smart_card_paid, travel_time, travel_jurors_taken_by_car, travel_by_car, travel_jurors_taken_by_motorcycle, travel_by_motorcycle, travel_by_bicycle, miles_traveled, food_and_drink_claim_type, version, expense_rates_id, attendance_audit_number, total_due, total_paid, appearance_confirmed, hide_on_unpaid_expense_and_reports)"
					+ "VALUES (CURRENT_DATE-41, '040127001', ?, '10:00:00', '16:30:00', NULL, false, NULL, '', false, NULL, 'MODTESTCOURT', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0.00, NULL, NULL, NULL, NULL, FALSE, NULL, NULL, '401270001', 'EXPENSE_AUTHORISED', NULL, NULL, '190000.00', '190000.00', 'FULL_DAY', NULL, '00:00:00', NULL, FALSE, NULL, FALSE, FALSE, NULL, 'NONE', 4, '1', 'P12700009', DEFAULT , DEFAULT, true, false)");
			pStmt.setString(1, locCode);
			pStmt.executeUpdate();

			log.info("Inserted appearance record with FOOD AND DRINK expense for juror");

			//DRAFT expense
			pStmt = conn.prepareStatement ("INSERT INTO juror_mod.appearance (attendance_date, juror_number, loc_code, time_in, time_out, trial_number, non_attendance, no_show, misc_description, pay_cash, last_updated_by, created_by, public_transport_total_due, public_transport_total_paid, hired_vehicle_total_due, hired_vehicle_total_paid, motorcycle_total_due, motorcycle_total_paid, car_total_due, car_total_paid, pedal_cycle_total_due, pedal_cycle_total_paid, childcare_total_due, childcare_total_paid, parking_total_due, parking_total_paid, misc_total_due, misc_total_paid, smart_card_due, is_draft_expense, f_audit, sat_on_jury, pool_number, appearance_stage, loss_of_earnings_due, loss_of_earnings_paid, subsistence_due, subsistence_paid, attendance_type, smart_card_paid, travel_time, travel_jurors_taken_by_car, travel_by_car, travel_jurors_taken_by_motorcycle, travel_by_motorcycle, travel_by_bicycle, miles_traveled, food_and_drink_claim_type, version, expense_rates_id, attendance_audit_number, total_due, total_paid, appearance_confirmed, hide_on_unpaid_expense_and_reports)"
					+ "VALUES (CURRENT_DATE-40, '040127001', ?, '10:00:00', '16:30:00', NULL, false, NULL, '', false, NULL, 'MODTESTCOURT', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0.00, NULL, NULL, NULL, NULL, TRUE, NULL, NULL, '401270001', 'EXPENSE_ENTERED', NULL, NULL, '190000.00', '190000.00', 'FULL_DAY', NULL, '00:00:00', NULL, FALSE, NULL, FALSE, FALSE, NULL, 'NONE', 4, '1', 'P12700009', DEFAULT , DEFAULT, true, false)");
			pStmt.setString(1, locCode);
			pStmt.executeUpdate();

			log.info("Inserted appearance record with FOOD AND DRINK expense for juror");

			//ALL TYPEs expenses
			pStmt = conn.prepareStatement ("INSERT INTO juror_mod.appearance (attendance_date, juror_number, loc_code, time_in, time_out, trial_number, non_attendance, no_show, misc_description, pay_cash, last_updated_by, created_by, public_transport_total_due, public_transport_total_paid, hired_vehicle_total_due, hired_vehicle_total_paid, motorcycle_total_due, motorcycle_total_paid, car_total_due, car_total_paid, pedal_cycle_total_due, pedal_cycle_total_paid, childcare_total_due, childcare_total_paid, parking_total_due, parking_total_paid, misc_total_due, misc_total_paid, smart_card_due, is_draft_expense, f_audit, sat_on_jury, pool_number, appearance_stage, loss_of_earnings_due, loss_of_earnings_paid, subsistence_due, subsistence_paid, attendance_type, smart_card_paid, travel_time, travel_jurors_taken_by_car, travel_by_car, travel_jurors_taken_by_motorcycle, travel_by_motorcycle, travel_by_bicycle, miles_traveled, food_and_drink_claim_type, version, expense_rates_id, attendance_audit_number, total_due, total_paid, appearance_confirmed, hide_on_unpaid_expense_and_reports)"
					+ "VALUES (CURRENT_DATE-39, '040127001', ?, '10:00:00', '16:30:00', NULL, false, NULL, '', false, NULL, 'MODTESTCOURT', '0.13', '0.13', '0.13', '0.13', '0.15', '0.15', '0.16', '0.16', '0.17', '0.17', '0.11', '0.11', '0.18', '0.18', '0.12', '0.12', NULL, FALSE, NULL, NULL, '401270001', 'EXPENSE_AUTHORISED', '0.10', '0.10', '0.19', '0.19', 'FULL_DAY', '0.20', '00:00:00', NULL, FALSE, NULL, FALSE, FALSE, NULL, 'NONE', 4, '1', 'P12700009', DEFAULT , DEFAULT, true, false)");
			pStmt.setString(1, locCode);
			pStmt.executeUpdate();

			log.info("Inserted appearance record with ALL EXPENSES expense for juror");

		} catch (SQLException e) {
			e.printStackTrace();
			log.error("Message:" + e.getMessage());
		} finally {
			conn.commit();
			pStmt.close();
			conn.close();
		}
	}


	public void checkAddressMatchesForLetter(String jurorNumber, String jurorAddress) throws SQLException {
		db = new DBConnection();

		String env_property = System.getProperty("env.database");

		if (env_property != null)
			conn = db.getConnection(env_property);
		else
			conn = db.getConnection("demo");
		try {
			log.info("Verifying address '" + jurorAddress + "' exists in print record for juror: " + jurorNumber);
			pStmt = conn.prepareStatement("""
					    SELECT detail_rec, creation_date
					    FROM juror_mod.bulk_print_data
					    WHERE juror_no = ?
					    AND detail_rec LIKE ?
					    AND creation_date = (
					        SELECT MAX(creation_date)
					        FROM juror_mod.bulk_print_data
					        WHERE juror_no = ?
					    )
					""");
			pStmt.setString(1, jurorNumber);
			pStmt.setString(2, "%" + jurorAddress + "%");
			pStmt.setString(3, jurorNumber);
			ResultSet rs = pStmt.executeQuery();

			if (rs.next()) {
				log.info("Address found in print record!");
				log.info("Creation date: " + rs.getTimestamp("creation_date"));
			} else {
				log.error("Address not found in print record for juror: " + jurorNumber);
				throw new AssertionError("Expected address not found for juror " + jurorNumber);
			}

		} catch (SQLException e) {
			e.printStackTrace();
			log.error("Message:" + e.getMessage());
		} finally {
			conn.commit();
			pStmt.close();
			conn.close();
		}
	}

	public void checkAddressDoesNotMatchForLetter(String jurorNumber, String jurorAddress) throws SQLException {
		db = new DBConnection();

		String env_property = System.getProperty("env.database");

		if (env_property != null)
			conn = db.getConnection(env_property);
		else
			conn = db.getConnection("demo");
		try {
			log.info("Verifying address '" + jurorAddress + "' does not exist in print record for juror: " + jurorNumber);
			pStmt = conn.prepareStatement("""
					    SELECT detail_rec, creation_date
					    FROM juror_mod.bulk_print_data
					    WHERE juror_no = ?
					    AND detail_rec LIKE ?
					    AND creation_date = (
					        SELECT MAX(creation_date)
					        FROM juror_mod.bulk_print_data
					        WHERE juror_no = ?
					    )
					""");
			pStmt.setString(1, jurorNumber);
			pStmt.setString(2, "%" + jurorAddress + "%");
			pStmt.setString(3, jurorNumber);
			ResultSet rs = pStmt.executeQuery();

			if (rs.next()) {
				log.error("Address found in print record!");
				throw new AssertionError(" address incorrectly found for juror " + jurorNumber);
//				log.error("Creation date: " + rs.getTimestamp("creation_date"));
			} else {
				log.info("Address " + jurorAddress + " correctly not found in print record for juror: " + jurorNumber);
			}

		} catch (SQLException e) {
			e.printStackTrace();
			log.error("Message:" + e.getMessage());
		} finally {
			conn.commit();
			pStmt.close();
			conn.close();
		}
	}

	public void updateJurorNameLeadingSpace(String title, String firstName, String lastName, String jurorNumber) throws SQLException {
		db = new DBConnection();
		String env_property = System.getProperty("env.database");

		if (env_property != null)
			conn = db.getConnection(env_property);
		else
			conn = db.getConnection("demo");

		try {
			pStmt = conn.prepareStatement("UPDATE juror_mod.juror SET title = ? WHERE juror_number = ?");
			pStmt.setString(1, title);
			pStmt.setString(2, jurorNumber);
			pStmt.executeUpdate();

			pStmt = conn.prepareStatement("UPDATE juror_mod.juror SET first_name = ? WHERE juror_number = ?");
			pStmt.setString(1, firstName);
			pStmt.setString(2, jurorNumber);
			pStmt.executeUpdate();

			pStmt = conn.prepareStatement("UPDATE juror_mod.juror SET last_name = ? WHERE juror_number = ?");
			pStmt.setString(1, lastName);
			pStmt.setString(2, jurorNumber);
			pStmt.executeUpdate();

			System.out.println("Juror " + jurorNumber + " was updated to enter a leading space");
		} catch (SQLException e) {
			e.printStackTrace();
			log.error("Message:" + e.getMessage());
		} finally {
			conn.commit();
			conn.close();
		}
	}
	public void fallbackMethodFor99PoolsErrors() throws SQLException {
		DBConnection db = new DBConnection();
		String env = System.getProperty("env.database");
		if (env == null) env = "demo";

		try (Connection conn = db.getConnection(env)) {
			conn.setAutoCommit(false);

			int maxSuffix = -1;
			String checkMax = "SELECT MAX(RIGHT(pool_no, 2)::int) FROM juror_mod.pool";
			try (PreparedStatement ps = conn.prepareStatement(checkMax);
				 ResultSet rs = ps.executeQuery()) {
				if (rs.next()) {
					maxSuffix = rs.getInt(1);
				}
			}

			if (maxSuffix <= 89) {
				conn.commit();
				log.info("Fallback: max suffix is " + maxSuffix + " (<=89), no action needed.");
				return;
			}

			final String selectTargets =
					"SELECT p.pool_no " +
							"FROM juror_mod.pool p " +
							"LEFT JOIN juror_mod.juror_pool jp ON jp.pool_number = p.pool_no " +
							"WHERE jp.pool_number IS NULL " +
							"  AND RIGHT(p.pool_no, 2)::int > 89";

			java.util.List<String> targets = new java.util.ArrayList<>();
			try (PreparedStatement ps = conn.prepareStatement(selectTargets);
				 ResultSet rs = ps.executeQuery()) {
				while (rs.next()) {
					targets.add(rs.getString(1));
				}
			}

			if (targets.isEmpty()) {
				conn.commit();
				log.info("Fallback: no pools with suffix >89 found.");
				return;
			}

			final String delHist = "DELETE FROM juror_mod.pool_history  WHERE pool_no = ?";
			final String delComm = "DELETE FROM juror_mod.pool_comments WHERE pool_no = ?";
			final String delPool = "DELETE FROM juror_mod.pool         WHERE pool_no = ?";

			try (PreparedStatement dHist = conn.prepareStatement(delHist);
				 PreparedStatement dComm = conn.prepareStatement(delComm);
				 PreparedStatement dPool = conn.prepareStatement(delPool)) {

				for (String poolNo : targets) {
					dHist.setString(1, poolNo);
					dHist.executeUpdate();
					dComm.setString(1, poolNo);
					dComm.executeUpdate();
					dPool.setString(1, poolNo);
					dPool.executeUpdate();
				}
			}

			conn.commit();
			log.info("Fallback: deleted " + targets.size() + " pools with suffix >89 (max suffix was " + maxSuffix + ")");
		} catch (SQLException e) {
			log.error("Fallback cleanup failed", e);
			throw e;
		}
	}
	public void updateJurorNextDateIfDue() throws SQLException {

		db = new DBConnection();
		String env_property = System.getProperty("env.database");
		if (env_property != null)
			conn = db.getConnection(env_property);
		else
			conn = db.getConnection("demo");

		PreparedStatement pStmt = null;
		ResultSet rs = null;

		try {

			LocalDate today = LocalDate.now();
			LocalDate nextWeek = today.plusWeeks(1);

			log.info("Checking for jurors with next_date = " + today + " to update");

			String countSQL =
					"SELECT COUNT(*) FROM juror_mod.juror_pool " +
							"WHERE owner = ? " +
							"AND next_date = ? " +
							"AND status = ? " +
							"AND juror_number LIKE ? " +
							"AND pool_number LIKE ?";

			pStmt = conn.prepareStatement(countSQL);
			pStmt.setString(1, "415");
			pStmt.setDate(2, java.sql.Date.valueOf(today));
			pStmt.setInt(3, 2);
			pStmt.setString(4, "0767%");
			pStmt.setString(5, "767%");

			rs = pStmt.executeQuery();

			int rowCount = 0;
			if (rs.next()) {
				rowCount = rs.getInt(1);
			}

			log.info("Rows found matching criteria => " + rowCount);

			if (rowCount > 0) {

				log.info("Updating next_date to => " + nextWeek + " for " + rowCount + " row(s)");

				String updateSQL =
						"UPDATE juror_mod.juror_pool SET next_date = ? " +
								"WHERE owner = ? " +
								"AND next_date = ? " +
								"AND status = ? " +
								"AND juror_number LIKE ? " +
								"AND pool_number LIKE ?";

				pStmt = conn.prepareStatement(updateSQL);
				pStmt.setDate(1, java.sql.Date.valueOf(nextWeek));
				pStmt.setString(2, "415");
				pStmt.setDate(3, java.sql.Date.valueOf(today));
				pStmt.setInt(4, 2);
				pStmt.setString(5, "0767%");
				pStmt.setString(6, "767%");

				int updatedCount = pStmt.executeUpdate();

				conn.commit();
				log.info("Update complete rows updated => " + updatedCount);

			} else {
				log.info("No rows found, no update carried out");
			}
		} catch (SQLException e) {
			e.printStackTrace();
			log.error("Message:" + e.getMessage());

		} finally {
			conn.commit();
			conn.close();
		}
	}
	public void deleteJurorBulkData(String createdJurorRecordNumber) throws SQLException {
		db = new DBConnection();

		String env_property = System.getProperty("env.database");

		if (env_property != null)
			conn = db.getConnection(env_property);
		else
			conn = db.getConnection("demo");

		try {
			pStmt = conn.prepareStatement("DELETE FROM juror_mod.bulk_print_data WHERE JUROR_NO ='" + createdJurorRecordNumber + "'");
			pStmt.executeUpdate();

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			conn.commit();
			pStmt.close();
			conn.close();
		}
	}
	public void deleteTestPoolAndJurorsNSD(String poolRequestNumber) throws SQLException {
		db = new DBConnection();

		String env_property = System.getProperty("env.database");

		if (env_property != null)
			conn = db.getConnection(env_property);
		else
			conn = db.getConnection("demo");

		try {

			pStmt = conn.prepareStatement("DELETE FROM JUROR_MOD.JUROR WHERE JUROR_NUMBER IN (SELECT JUROR_NUMBER FROM JUROR_MOD.POOL WHERE POOL_NO = '" + poolRequestNumber + "')");
			pStmt.execute();

			pStmt = conn.prepareStatement("DELETE FROM JUROR_MOD.JUROR_POOL WHERE POOL_NUMBER = '" + poolRequestNumber + "'");
			pStmt.execute();

			pStmt = conn.prepareStatement("DELETE FROM JUROR_MOD.POOL WHERE POOL_NO = '" + poolRequestNumber + "'");
			pStmt.execute();

			pStmt = conn.prepareStatement("DELETE FROM JUROR_MOD.JUROR_HISTORY WHERE POOL_NUMBER = '" + poolRequestNumber + "'");
			pStmt.execute();

			pStmt = conn.prepareStatement("DELETE FROM JUROR_MOD.POOL_HISTORY WHERE POOL_NO = '" + poolRequestNumber + "'");
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
	public void insertNewVotersDataForShuffle() throws SQLException {
		db = new DBConnection();

		String env_property = System.getProperty("env.database");

		if (env_property != null)
			conn = db.getConnection(env_property);
		else
			conn = db.getConnection("demo");

		try {

			pStmt = conn.prepareStatement(
					"INSERT INTO juror_mod.voters (part_no,register_lett,poll_number,new_marker,title,lname,fname,dob,flags,address,address2,address3,address4,address5,address6,zip,date_selected1,date_selected2,date_selected3,rec_num,perm_disqual,source_id) VALUES" +
							" ('820211676','650','650',NULL,NULL,'LNAMESIXFIVEZERO','FNAMESIXFIVEZERO',NULL,NULL,'650 STREET NAME',NULL,'MOVETOADD4',NULL,NULL,NULL,'TF14 5AJ',NULL,NULL,NULL,650,NULL,NULL)," +
							" ('820211826','175','175',NULL,NULL,'LNAMEONESEVENFIVE','FNAMEONESEVENFIVE',NULL,NULL,'175 STREET NAME',NULL,'123 DONT MOVE',NULL,NULL,NULL,'TF14 5AJ',NULL,NULL,NULL,175,NULL,NULL)," +
							" ('820211896','968','968',NULL,NULL,'LNAMENINESIXEIGHT','FNAMENINESIXEIGHT',NULL,NULL,'968 STREET NAME',NULL,'MOVETOADD4',NULL,NULL,NULL,'TF14 5AJ',NULL,NULL,NULL,968,NULL,NULL)," +
							" ('820211816','480','480',NULL,NULL,'LNAMEFOUREIGHTZERO','FNAMEFOUREIGHTZERO',NULL,NULL,'480 STREET NAME','123 DONT MOVE',NULL,NULL,NULL,NULL,'TF14 5AJ',NULL,NULL,NULL,480,NULL,NULL)," +
							" ('820211886','545','545',NULL,NULL,'LNAMEFIVEFOURFIVE','FNAMEFIVEFOURFIVE',NULL,NULL,'545 STREET NAME','MOVETOADD4',NULL,NULL,NULL,NULL,'TF14 5AJ',NULL,NULL,NULL,545,NULL,NULL)"
			);

			pStmt.execute();

		} catch (SQLException e) {
			e.printStackTrace();
			log.error("Message: inserted voters data " + e.getMessage());
		} finally {
			conn.commit();
			pStmt.close();
			conn.close();
		}
	}

	public void insertCatchmentAreaIfNotExists() throws SQLException {
		db = new DBConnection();

		String env_property = System.getProperty("env.database");

		if (env_property != null)
			conn = db.getConnection(env_property);
		else
			conn = db.getConnection("demo");

		ResultSet rs = null;

		try {
			pStmt = conn.prepareStatement(
					"SELECT 1 FROM juror_mod.court_catchment_area " +
							"WHERE loc_code = '452' AND postcode LIKE 'TF14%'");

			rs = pStmt.executeQuery();

			if (rs.next()) {
				log.info("TF14 postcode already exists for loc_code 452. Ignoring insert.");
			} else {

			
				pStmt = conn.prepareStatement(
						"INSERT INTO juror_mod.court_catchment_area (loc_code, postcode) " +
								"VALUES ('452', 'TF14')");

				pStmt.execute();
				log.info("Inserted new TF14 catchment area for loc_code 452.");
			}

		} catch (SQLException e) {
			e.printStackTrace();
			log.error("Message: error checking/inserting catchment area " + e.getMessage());
		} finally {
			conn.commit();
			if (rs != null) rs.close();
			pStmt.close();
			conn.close();
		}
	}

	public void cleanTestDataForShuffleAddress(String pool_number, String juror_number) throws SQLException {
		db = new DBConnection();
		String env_property = System.getProperty("env.database");
		if (env_property != null)
			conn = db.getConnection(env_property);
		else
			conn = db.getConnection("demo");

		PreparedStatement pStmt = null;
		try {
			conn.setAutoCommit(false);

			String[] sqls = new String[]{
					"DELETE FROM juror_mod.voters WHERE part_no = ?",
					"DELETE FROM juror_mod.bulk_print_data WHERE juror_no = ?",
					"DELETE FROM juror_mod.juror_trial WHERE juror_number = ?",
					"DELETE FROM juror_mod.juror_response_aud WHERE juror_number = ?",
					"DELETE FROM juror_mod.juror_response_cjs_employment WHERE juror_number = ?",
					"DELETE FROM juror_mod.juror_reasonable_adjustment WHERE juror_number = ?",
					"DELETE FROM juror_mod.USER_JUROR_RESPONSE_AUDIT WHERE juror_number = ?",
					"DELETE FROM juror_mod.juror_third_party WHERE juror_number = ?",
					"DELETE FROM juror_mod.juror_third_party_audit WHERE juror_number = ?",
					"DELETE FROM juror_mod.juror_response WHERE juror_number = ?",
					"DELETE FROM juror_mod.juror_history WHERE juror_number = ?",
					"DELETE FROM juror_mod.juror_audit WHERE juror_number = ?",
					"DELETE FROM juror_mod.rev_info WHERE revision_number IN (SELECT revision FROM juror_mod.juror_audit WHERE juror_number = ?)",
					"DELETE FROM juror_mod.contact_log WHERE juror_number = ?",
					"DELETE FROM juror_mod.appearance WHERE juror_number = ?",
					"DELETE FROM juror_mod.appearance_audit WHERE juror_number = ?",
					"DELETE FROM juror_mod.juror_pool WHERE juror_number = ?",
					"DELETE FROM juror_mod.financial_audit_details_appearances WHERE FINANCIAL_AUDIT_ID IN (SELECT ID FROM juror_mod.financial_audit_details WHERE JUROR_NUMBER = ?)",
					"DELETE FROM juror_mod.financial_audit_details WHERE JUROR_NUMBER = ?",
					"DELETE FROM juror_mod.juror WHERE juror_number = ?",
					"DELETE FROM juror_mod.pending_juror WHERE juror_number = ?",
					"DELETE FROM juror_mod.message WHERE juror_number = ?",
					"DELETE FROM juror_mod.bureau_snapshot WHERE juror_number = ?"
			};

			for (String sql : sqls) {
				pStmt = conn.prepareStatement(sql);
				pStmt.setString(1, juror_number);
				pStmt.executeUpdate();
				pStmt.close();
				pStmt = null;
				log.info("Executed: " + sql + " for juror_number=>" + juror_number);
			}

			conn.commit();
			log.info("Completed clean up for juror_number => " + juror_number);

		} catch (SQLException e) {
			e.printStackTrace();
			log.error("Message:" + e.getMessage());
			try {
				if (conn != null) conn.rollback();
			} catch (SQLException ex) {
				log.error("Rollback failed: " + ex.getMessage());
			}
			throw e;
		} finally {
			try {
				if (pStmt != null) pStmt.close();
			} catch (SQLException ignored) {
			}
			try {
				if (conn != null) {
					conn.setAutoCommit(true);
					conn.close();
				}
			} catch (SQLException ignored) {
			}
		}
	}

	public void verifyJurorAddress4Updates() throws SQLException {
		db = new DBConnection();

		String env_property = System.getProperty("env.database");
		if (env_property != null)
			conn = db.getConnection(env_property);
		else
			conn = db.getConnection("demo");

		PreparedStatement pStmt = null;
		ResultSet rs = null;


		Map<String, String> expected = new HashMap<>();
		expected.put("820211676", "MOVETOADD4");
		expected.put("820211826", null);
		expected.put("820211896", "MOVETOADD4");
		expected.put("820211816", null);
		expected.put("820211886", "MOVETOADD4");

		try {
			String sql =
					"SELECT juror_number, address_line_4 " +
							"FROM juror_mod.juror " +
							"WHERE juror_number IN ('820211676','820211826','820211896','820211816','820211886')";

			pStmt = conn.prepareStatement(sql);
			rs = pStmt.executeQuery();

			while (rs.next()) {
				String juror = rs.getString("juror_number");
				String actual = rs.getString("address_line_4");
				String expectedValue = expected.get(juror);

				boolean matches =
						(expectedValue == null && actual == null) ||
								(expectedValue != null && expectedValue.equals(actual));

				if (!matches) {
					log.error("Address mismatch for juror_number=" + juror +
							" | expected=" + expectedValue +
							" | actual=" + actual);

					throw new AssertionError(
							"Address mismatch for juror " + juror +
									" expected=" + expectedValue + " but found=" + actual
					);
				}

				log.info("✔ Address correct for juror_number=" + juror +
						" | value=" + actual);
			}

		} catch (SQLException e) {
			e.printStackTrace();
			log.error("Error verifying juror address updates: " + e.getMessage());
			throw e;

		} finally {
			if (rs != null) try {
				rs.close();
			} catch (SQLException ignored) {
			}
			if (pStmt != null) try {
				pStmt.close();
			} catch (SQLException ignored) {
			}
			if (conn != null) try {
				conn.close();
			} catch (SQLException ignored) {
			}
		}
	}

    public void updateERLAsToAcvtive() throws SQLException {
        db = new DBConnection();
        String env_property = System.getProperty("env.database");

        if (env_property != null)
            conn = db.getConnection(env_property);
        else
            conn = db.getConnection("demo");

        try {
            pStmt = conn.prepareStatement("UPDATE juror_er.local_authority SET is_active = TRUE");
            pStmt.executeUpdate();

            System.out.println("All ER local authorities set to active");
        } catch (SQLException e) {
            log.error("Message:" + e.getMessage());
        } finally {
            conn.commit();
            conn.close();
        }
    }

    public int getCountOfActiveERLocalAuthorities() throws SQLException {
        db = new DBConnection();
        String env_property = System.getProperty("env.database");
        conn = db.getConnection(env_property);
        try {
            pStmt = conn.prepareStatement("select count(*) from juror_er.local_authority where is_active=TRUE");
            ResultSet rs = pStmt.executeQuery();
            rs.next();
            log.info("Got count of active LAs");
            return rs.getInt(1);
        } catch (SQLException e) {
            log.error("Message:" + e.getMessage());
            log.info(11);
        } finally {
            pStmt.close();
            conn.close();
        }
        return 0;
    }

    public int getCountOfNotUploadedERLocalAuthorities() throws SQLException {
        db = new DBConnection();
        String env_property = System.getProperty("env.database");
        conn = db.getConnection(env_property);
        try {
            pStmt = conn.prepareStatement("select count(*) from juror_er.local_authority where upload_status='NOT_UPLOADED'");
            ResultSet rs = pStmt.executeQuery();
            rs.next();
            log.info("Got count of LAs who have not uploaded docs");
            return rs.getInt(1);
        } catch (SQLException e) {
            log.error("Message:" + e.getMessage());
            log.info(11);
        } finally {
            pStmt.close();
            conn.close();
        }
        return 0;
    }

    public int getCountOfUploadedERLocalAuthorities() throws SQLException {
        db = new DBConnection();
        String env_property = System.getProperty("env.database");
        conn = db.getConnection(env_property);
        try {
            pStmt = conn.prepareStatement("select count(*) from juror_er.local_authority where upload_status='UPLOADED'");
            ResultSet rs = pStmt.executeQuery();
            rs.next();
            log.info("Got count of LAs who have uploaded docs");
            return rs.getInt(1);
        } catch (SQLException e) {
            log.error("Message:" + e.getMessage());
            log.info(11);
        } finally {
            pStmt.close();
            conn.close();
        }
        return 0;

    }

    public void updateERLAsToNotUploaded() throws SQLException {
        db = new DBConnection();
        String env_property = System.getProperty("env.database");

        if (env_property != null)
            conn = db.getConnection(env_property);
        else
            conn = db.getConnection("demo");

        try {
            pStmt = conn.prepareStatement("UPDATE juror_er.local_authority SET upload_status = NOT_UPLOADED");
            pStmt.executeUpdate();

            System.out.println("All ER local authorities set to NOT_UPLOADED");
        } catch (SQLException e) {
            log.error("Message:" + e.getMessage());
        } finally {
            conn.commit();
            conn.close();
        }
    }

    public void deleteERLAsLastUploaded(String localAuth) throws SQLException {
        db = new DBConnection();
        String env_property = System.getProperty("env.database");

        if (env_property != null)
            conn = db.getConnection(env_property);
        else
            conn = db.getConnection("demo");

        try {
            pStmt = conn.prepareStatement("DELETE from juror_er.file_uploads where la_code in (select la_code from juror_er.local_authority where la_name = "+ localAuth);
            pStmt.executeUpdate();

            System.out.println("All uploads for ER local authority "+ localAuth +" set to NOT_UPLOADED");
        } catch (SQLException e) {
            log.error("Message:" + e.getMessage());
        } finally {
            conn.commit();
            conn.close();
        }
    }

    public void setERDeadlineDate(String value) throws SQLException {
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
            pStmt = conn.prepareStatement("UPDATE juror_er.deadline set deadline_date= '" + value + "'");
            pStmt.executeUpdate();

            if (value.contains("today")) {
                pStmt = conn.prepareStatement("UPDATE juror_er.deadline set deadline_date= CURRENT_DATE");

                System.out.println("Set ER deadline date to today");
            } else if (value.contains("yesterday")) {
                pStmt = conn.prepareStatement("UPDATE juror_er.deadline set deadline_date= CURRENT_DATE-1");

                System.out.println("Set ER deadline date to today");
            }
        } catch (SQLException e) {
            log.error("Message:" + e.getMessage());
        } finally {
            conn.commit();
            conn.close();
        }
    }
}