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
import java.time.temporal.TemporalAdjusters;
import java.util.Calendar;
import java.util.Date;

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
		try {
			pStmt = conn.prepareStatement("update JUROR_MOD.POOL set RETURN_DATE =? where pool_no=?");
			if (columnValue.contains("-") && columnValue.contains(":")) {
				pStmt = conn.prepareStatement("update JUROR_MOD.POOL set RETURN_DATE =TO_DATE(?, 'YYYY-MM-DD HH24:MI:SS') where pool_no=?");
			}
			pStmt.setString(1, columnValue);
			pStmt.setString(2, pool_no);

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
			}
			pStmt.execute();
			log.info("Updated juror_response " + column + "");

		} finally {
			conn.commit();
			pStmt.close();
			conn.close();
		}

	}

	public void onDatabaseTable_seeColWithColValue_whereColColvalueNSD(String environment, String database, String databaseTable,
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
				Integer.valueOf(whereColumnValue)
		);
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
//			//for locked out scenarios
//			pStmt = conn.prepareStatement("delete from juror_digital.bureau_auth where username=?");
//			pStmt.setString(1, part_no);
//			pStmt.executeQuery();
//			log.info("Deleted from bureau_auth where username=>" + part_no);
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

		String attDate = new SimpleDateFormat("yyyy-MM-d").format(calendar.getTime());
		newPoolDate.set(new SimpleDateFormat("E d MMM yyy").format(calendar.getTime()));

		try {

			if (getCountFromUniquePoolNSD(pool_number) == 0)
				pStmt = conn.prepareStatement("INSERT INTO juror_mod.pool (pool_no, owner, return_date, no_requested, pool_type, loc_code, new_request, last_update, additional_summons, attend_time, nil_pool, total_no_required, date_created)"
						+ "VALUES ('" + pool_number + "', '" + owner + "', '" + attDate + "', 20, 'CRO', '" + court + "', 'N', NOW(), NULL, (timestamp '" + attDate + " 10:00:00'), false, 0, NOW())");
			pStmt.execute();

		} finally {
			conn.commit();
			pStmt.close();
			conn.close();
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
					+ "values ('" + juror_number + "','857',null,'lname','fname',null,'address',null,null,'Address Line Four',null,'CH2 2AA',null,null,null,'Y',null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,'N','NOT_CHECKED',null,null,null,null,null,'0',null,null,null,null,null)");
			pStmt.execute();

			pStmt = conn.prepareStatement("insert into juror_mod.juror_pool (juror_number, pool_number, owner, user_edtq, is_active, status, times_sel, def_date, location, no_attendances, no_attended, no_fta, no_awol, pool_seq, edit_tag, next_date, on_call, was_deferred, deferral_code, id_checked, postpone, paid_cash, scan_code, last_update, reminder_sent, transfer_date, date_created)"
					+ " VALUES ('" + juror_number + "', '" + pool_number + "', '400', 'MODTESTBUREAU', true, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0001', NULL, '" + attDate + "', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NOW(), NULL, NULL, NOW())");
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

	public void clean_dashboardNSD() throws SQLException {
		db = new DBConnection();
		String env_property = System.getProperty("env.database");
		if (env_property != null)
			conn = db.getConnection(env_property);
		else
			conn = db.getConnection("demo");
		try {
			pStmt = conn.prepareStatement("delete from juror_digital.stats_auto_processed");
			pStmt.executeQuery();
			log.info("Deleted from juror_stats_auto_processed");

			pStmt = conn.prepareStatement("delete from juror_digital.stats_not_responded");
			pStmt.executeQuery();
			log.info("Deleted from juror_stats_not_responded");

			pStmt = conn.prepareStatement("delete from juror_digital.stats_response_times");
			pStmt.executeQuery();
			log.info("Deleted from juror_stats_response_times");

			pStmt = conn.prepareStatement("delete from juror_digital.stats_thirdparty_online");
			pStmt.executeQuery();
			log.info("Deleted from juror_stats_thirdparty_online");

			pStmt = conn.prepareStatement("delete from juror_digital.stats_unprocessed_responses");
			pStmt.executeQuery();
			log.info("Deleted from juror_stats_unprocessed_responses");

			pStmt = conn.prepareStatement("delete from juror_digital.stats_welsh_online_responses");
			pStmt.executeQuery();
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
					+ " ON_CALL = NULL,"
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


	public void resetJurorDigitalDatabase() throws SQLException {
		db = new DBConnection();

		String env_property = System.getProperty("env.database");
		if (env_property != null)
			conn = db.getConnection(env_property);
		else
			conn = db.getConnection("demo");

		try {
			pStmt = conn.prepareStatement("Delete from juror_digital.change_log_item Where change_log in (select c.id from juror_digital.change_log c, juror_digital.juror_response r where c.juror_number = r.juror_number and processing_status = 'TODO')");
			pStmt.executeQuery();

			pStmt = conn.prepareStatement("Delete from juror_digital.change_log Where juror_number in (select juror_number from juror_digital.juror_response where processing_status = 'TODO')");
			pStmt.executeQuery();

			pStmt = conn.prepareStatement("Delete from juror_digital.USER_JUROR_response_audit Where juror_number in (select juror_number from juror_digital.juror_response where processing_status = 'TODO')");
			pStmt.executeQuery();

			pStmt = conn.prepareStatement("Delete from juror_digital.juror_response_aud Where juror_number in (select juror_number from juror_digital.juror_response where processing_status = 'TODO')");
			pStmt.executeQuery();

			pStmt = conn.prepareStatement("Delete from juror_digital.juror_response_cjs_employment Where juror_number in (select juror_number from juror_digital.juror_response where processing_status = 'TODO')");
			pStmt.executeQuery();

			pStmt = conn.prepareStatement("Delete from juror_digital.juror_response_special_needs Where juror_number in (select juror_number from juror_digital.juror_response where processing_status = 'TODO')");
			pStmt.executeQuery();

			pStmt = conn.prepareStatement("Delete from juror_digital.juror_response Where processing_status = 'TODO'");
			pStmt.executeQuery();

		} catch (SQLException e) {
			e.printStackTrace();
			log.error("Message:" + e.getMessage());
		} finally {
			conn.commit();
			pStmt.close();
			conn.close();
		}
	}

	public void usernameHasCourt_setAsNSD(String username, int courtPosition, String courtRoom) throws SQLException {
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
			pStmt.executeQuery();
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
			pStmt = conn.prepareStatement("Delete from juror_digital.staff where login='TeamPickListUser'");
			pStmt.executeQuery();


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
			pStmt.executeQuery();

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
			pStmt.executeQuery();

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
			pStmt.executeQuery();

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
			pStmt.executeQuery();

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
			pStmt.executeQuery();

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
			pStmt.executeQuery();

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
			pStmt.executeQuery();

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
			pStmt.executeQuery();

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
			pStmt.executeQuery();

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
			pStmt.executeQuery();

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
			pStmt.executeQuery();

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
			pStmt.executeQuery();

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
			pStmt.executeQuery();

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
			pStmt.executeQuery();

		} catch (SQLException e) {
			e.printStackTrace();
			log.error("Message:deleted disqualified letter" + e.getMessage());
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
			pStmt.executeQuery();

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
			pStmt.executeQuery();

		} catch (SQLException e) {
			e.printStackTrace();
			log.error("Message:deleted request lett for part_no '" + part_no + "' + e.getMessage()");
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
			String datePattern = "YYYY-MM-DD";
			Calendar calendar = Calendar.getInstance();
			calendar.add(Calendar.WEEK_OF_MONTH, Integer.parseInt(noWeeks));

			LocalDate localDate = calendar.toInstant().atZone(ZoneId.systemDefault()).toLocalDate();
			Date mondayDate = Date.from(localDate.atStartOfDay().atZone(ZoneId.systemDefault()).toInstant());

			String expectedDate = new SimpleDateFormat(datePattern).format((mondayDate).getTime());

			pStmt = conn.prepareStatement("Insert into juror_mod.pool (pool_no, owner, return_date, no_requested, pool_type, loc_code, new_request, last_update, additional_summons, attend_time, total_no_required, date_created)"
					+ "values ('" + court + "111111','" + court + "','" + localDate + "','5','CRO','" + court + "','T',NOW(),null,TIMESTAMP'2022-04-01 09:30:00.0','5',NOW())");
			pStmt.execute();

			pStmt = conn.prepareStatement("insert into juror_mod.juror (juror_number,poll_number,title,last_name,first_name,dob,ADDRESS_LINE_1,ADDRESS_LINE_2,ADDRESS_LINE_3,ADDRESS_LINE_4,ADDRESS_LINE_5,POSTCODE,h_phone,w_phone,w_ph_local,responded,date_excused,excusal_code,acc_exc,date_disq,disq_code,user_edtq,notes,no_def_pos,perm_disqual,reasonable_adj_code,reasonable_adj_msg,sort_code,bank_acct_name,bank_acct_no,bldg_soc_roll_no,welsh,police_check,last_update,summons_file,m_phone,h_email,contact_preference,notifications,date_created,optic_reference,pending_title,pending_first_name,pending_last_name)"
					+ "values ('6" + court + "11111','857',null,'lname','fname',null,'address',null,null,null,null,'CH2 2AA',null,null,null,'Y',null,null,null,null,null,null,null,'1',null,null,null,null,null,null,null,'N',null,null,null,null,null,null,'0',null,null,null,null,null)");
			pStmt.execute();

			pStmt = conn.prepareStatement("insert into juror_mod.juror_pool (juror_number,pool_number,owner,user_edtq,is_active,status,times_sel,def_date,location,no_attendances,no_attended,no_fta,no_awol,pool_seq,edit_tag,next_date,on_call,was_deferred,deferral_code,id_checked,postpone,paid_cash,scan_code,last_update,reminder_sent,transfer_date,date_created)"
					+ "values ('6" + court + "11111','" + court + "111111','" + court + "',null,'Y','7',null,'" + localDate + "','415','0',null,null,null,null,null,'" + localDate + "',null,'Y','O',null,null,null,null,CURRENT_DATE,null,null,CURRENT_DATE)");
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

	public void insertCourtPoolWithDeferralNSD(String court, String pool_no, String part_no, String no_weeks) throws SQLException {
		db = new DBConnection();

		String datePattern = "YYYY-MM-DD";
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

		if (getCountFromUniquePoolNSD(pool_no) == 0)
			pStmt = conn.prepareStatement("Insert into juror_mod.pool (pool_no, owner, return_date, no_requested, pool_type, loc_code, new_request, last_update, additional_summons, attend_time, total_no_required, date_created)"
					+ "values ('" + pool_no + "','" + court + "','" + mondayDate + "','5','CRO','" + court + "','T',NOW(),null,TIMESTAMP'2022-04-01 09:30:00.0','5',NOW())");
		pStmt.execute();

		if (getCountFromPoolNSD(part_no, pool_no) == 0)
			pStmt = conn.prepareStatement("insert into juror_mod.juror (juror_number,poll_number,title,last_name,first_name,dob,ADDRESS_LINE_1,ADDRESS_LINE_2,ADDRESS_LINE_3,ADDRESS_LINE_4,ADDRESS_LINE_5,POSTCODE,h_phone,w_phone,w_ph_local,responded,date_excused,excusal_code,acc_exc,date_disq,disq_code,user_edtq,notes,no_def_pos,perm_disqual,reasonable_adj_code,reasonable_adj_msg,COMPLETION_DATE,sort_code,bank_acct_name,bank_acct_no,bldg_soc_roll_no,welsh,police_check,last_update,summons_file,m_phone,h_email,contact_preference,notifications,date_created,optic_reference,pending_title,pending_first_name,pending_last_name)"
					+ "values ('" + part_no + "','857',null,'lname','fname',null,'address',null,null,null,null,'CH1 2NN',null,null,null,'Y',null,null,null,null,null,null,null,'1',null,null,null,null,null,null,null,null,'N',null,null,null,null,null,null,'0',null,null,null,null,null)");
		pStmt.execute();

		if (getCountFromJurorPoolNSD(part_no, pool_no) == 0)
			pStmt = conn.prepareStatement("insert into juror_mod.juror_pool (juror_number,pool_number,owner,user_edtq,is_active,status,times_sel,def_date,mileage,location,no_attendances,no_attended,no_fta,no_awol,pool_seq,edit_tag,next_date,on_call,amt_spent,was_deferred,deferral_code,id_checked,postpone,paid_cash,travel_time,scan_code,financial_loss,last_update,reminder_sent,transfer_date,date_created)"
					+ "values ('" + part_no + "','" + pool_no + "','" + court + "',null,true,'2',null,CURRENT_DATE-10,null,'" + court + "','0',null,null,null,null,null,CURRENT_DATE-10,'N',null,null,'Y',null,null,null,null,null,null,CURRENT_DATE,null,null,CURRENT_DATE)");
		pStmt.execute();

		try {

			pStmt = conn.prepareStatement("update juror_mod.pool set OWNER='" + court + "' where pool_no ='" + pool_no + "'");
			pStmt.execute();

			pStmt = conn.prepareStatement("update juror_mod.juror_pool set TRANSFER_DATE=current_date, IS_ACTIVE='Y', OWNER='" + court + "', NEXT_DATE='" + mondayDate + "',STATUS='7',WAS_DEFERRED='Y', DEFERRAL_CODE='O', DEF_DATE='" + mondayDate + "', pool_number='" + pool_no + "' where juror_number='" + part_no + "'");
			pStmt.execute();

			pStmt = conn.prepareStatement("update juror_mod.juror set RESPONDED='Y', NO_DEF_POS='1' where juror_number='" + part_no + "'");
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
					+ "values ('6" + court + "11111','857',null,'lname','fname',null,'address',null,null,null,null,'CH1 2NN',null,null,null,'Y',null,null,null,null,null,null,null,'1',null,null,null,null,null,null,null,'N',null,null,null,null,null,null,'0',null,null,null,null,null)");
			pStmt.execute();

			pStmt = conn.prepareStatement("insert into juror_mod.juror_pool (juror_number,pool_number,owner,user_edtq,is_active,status,times_sel,def_date,location,no_attendances,no_attended,no_fta,no_awol,pool_seq,edit_tag,next_date,on_call,was_deferred,deferral_code,id_checked,postpone,paid_cash,scan_code,last_update,reminder_sent,transfer_date,date_created)"
					+ "values ('6" + court + "11111','" + court + "111111','" + court + "',null,true,'13',null,CURRENT_DATE-10,'" + court + "','0',null,null,null,null,null,CURRENT_DATE-10,'N','Y','O',null,null,null,null,CURRENT_DATE,null,null,CURRENT_DATE)");
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
					+ "values ('" + jurorPartNo + "','" + poolNo + "','" + court + "',null,'Y','2',null,'" + expectedDate + "',null,'415','0',null,null,null,null,'N',null,null,null,null,'Y',null,null,null,null,null,null,CURRENT_DATE,null,null,CURRENT_DATE)");
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
					+ "VALUES ('" + court + "','" + court + "333333',null,(SELECT SYSDATE FROM DUAL),(SELECT SYSDATE FROM DUAL),10,10,'R','CRO','" + court + "','N',(SELECT SYSDATE FROM DUAL),'N',null,null,(SELECT SYSDATE FROM DUAL))");
			pStmt.executeQuery();

//			#insert the pool rows
//			#bureau row
			pStmt = conn.prepareStatement("INSERT INTO JUROR.POOL (part_no, fname, lname, h_email, title, dob, ADDRESS_LINE_1, ADDRESS_LINE_2, ADDRESS_LINE_3, ADDRESS_LINE_4, POSTCODE, h_phone, w_phone, is_active, owner, loc_code, m_phone, responded, poll_number, pool_no, on_call, read_only, contact_preference, reg_spc, ret_date, status, transfer_date)"
					+ "VALUES ('6" + court + "33333', 'Edward', 'Palmer', 'email-one@email.com', 'Mr', TO_DATE('1976-07-18 00:00:01', 'YYYY-MM-DD HH24:MI:SS'), '1 Test Street', 'Scotland', 'Strathaven', 'United Kingdom', 'ML106AD', '44135101-1110', '44135201-1110', 'Y', '400', '" + court + "', '44776-301-1110', 'N', 1000,'" + court + "333333', 'N', 'Y', 0, 'N', (SELECT SYSDATE FROM DUAL), 1, (SELECT SYSDATE FROM DUAL))");
			pStmt.executeQuery();

//			#court row
			pStmt = conn.prepareStatement("INSERT INTO JUROR.POOL (part_no, fname, lname, h_email, title, dob, ADDRESS_LINE_1, ADDRESS_LINE_2, ADDRESS_LINE_3, ADDRESS_LINE_4, POSTCODE, h_phone, w_phone, is_active, owner, loc_code, m_phone, responded, poll_number, pool_no, on_call, read_only, contact_preference, reg_spc, ret_date, status)"
					+ "VALUES ('6" + court + "33333', 'Edward', 'Palmer', 'email-one@email.com', 'Mr', TO_DATE('1976-07-18 00:00:01', 'YYYY-MM-DD HH24:MI:SS'), '1 Test Street', 'Scotland', 'Strathaven', 'United Kingdom', 'ML106AD', '44135101-1110', '44135201-1110', 'Y', '" + court + "', '" + court + "', '44776-301-1110', 'N', 1000,'" + court + "333333', 'N', 'N', 0, 'N', (SELECT SYSDATE FROM DUAL), 1)");
			pStmt.executeQuery();

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

			pStmt = conn.prepareStatement("UPDATE JUROR_MOD.JUROR_POOL SET TRANSFER_DATE = CURRENT_DATE-1, OWNER='" + court + "' WHERE POOL_NUMBER = '" + poolNumber + "' AND JUROR_NUMBER='" + partNumber + "' AND OWNER = '400'");
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

	public void insertNewPoolRecord(String court, String newPartNo) throws SQLException {
		db = new DBConnection();

		String env_property = System.getProperty("env.database");

		if (env_property != null)
			conn = db.getConnection(env_property);
		else
			conn = db.getConnection("demo");

		try {

//			#insert the pool rows
			pStmt = conn.prepareStatement("INSERT INTO JUROR.POOL (part_no, fname, lname, h_email, title, dob, ADDRESS_LINE_1, ADDRESS_LINE_2, ADDRESS_LINE_3, ADDRESS_LINE_4, POSTCODE, h_phone, w_phone, is_active, owner, loc_code, m_phone, responded, poll_number, pool_no, on_call, read_only, contact_preference, reg_spc, ret_date, status)"
					+ "VALUES ('" + newPartNo + "', 'Fname', 'Lname', 'email-one@email.com', 'Mr', TO_DATE('1976-07-18 00:00:01', 'YYYY-MM-DD HH24:MI:SS'), '1 Test Street', 'Scotland', 'Strathaven', 'United Kingdom', 'ML106AD', '44135101-1110', '44135201-1110', 'Y', '400', '" + court + "', '44776-301-1110', 'N', 1000,'" + court + "222222', 'N', 'N', 0, 'N', (SELECT SYSDATE FROM DUAL), 1)");
			pStmt.executeQuery();


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
					+ "values ('6" + court + "22222','" + court + "222222','" + court + "',null,'Y','2',null,null,null,'" + court + "','0',null,null,null,null,null,CURRENT_DATE+10,null,'N',null,'N',null,null,null,null,null,null,CURRENT_DATE,null,null,CURRENT_DATE)");
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

	public void insertNewJurorIntoPoolNSD(String court, String jurorNumber, String poolNumber) throws SQLException {
		db = new DBConnection();

		String env_property = System.getProperty("env.database");

		if (env_property != null)
			conn = db.getConnection(env_property);
		else
			conn = db.getConnection("demo");

		try {

//			#insert the pool rows
			pStmt = conn.prepareStatement("INSERT INTO JUROR.POOL (part_no, fname, lname, h_email, title, dob, ADDRESS_LINE_1, ADDRESS_LINE_2, ADDRESS_LINE_3, ADDRESS_LINE_4, POSTCODE, h_phone, w_phone, is_active, owner, loc_code, m_phone, responded, poll_number, pool_no, on_call, read_only, contact_preference, reg_spc, ret_date, status)"
					+ "VALUES ('" + jurorNumber + "', 'Fname', 'Lname', 'email-one@email.com', 'Mr', TO_DATE('1976-07-18 00:00:01', 'YYYY-MM-DD HH24:MI:SS'), '1 Test Street', 'Scotland', 'Strathaven', 'United Kingdom', 'ML106AD', '44135101-1110', '44135201-1110', 'Y', '400', '" + court + "', '44776-301-1110', 'N', 1000,'" + poolNumber + "', 'N', 'N', 0, 'N', (SELECT SYSDATE FROM DUAL), 1)");
			pStmt.executeQuery();

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
			pStmt = conn.prepareStatement("INSERT INTO JUROR.POOL (part_no, fname, lname, h_email, title, dob, ADDRESS_LINE_1, ADDRESS_LINE_2, ADDRESS_LINE_3, ADDRESS_LINE_4, POSTCODE, h_phone, w_phone, is_active, owner, loc_code, m_phone, responded, poll_number, pool_no, on_call, read_only, contact_preference, reg_spc, ret_date, status, next_date)"
					+ "VALUES ('" + jurorNumber + "', 'Fname', 'Lname', 'email-one@email.com', 'Mr', TO_DATE('1976-07-18 00:00:01', 'YYYY-MM-DD HH24:MI:SS'), '1 Test Street', 'Scotland', 'Strathaven', 'United Kingdom', 'ML106AD', '44135101-1110', '44135201-1110', 'Y', '400', '" + court + "', '44776-301-1110', 'N', 1000,'" + poolNumber + "', 'N', 'N', 0, 'N', SYSDATE+60, 1, TRUNC(SYSDATE + (8 - TO_NUMBER(TO_CHAR(SYSDATE, 'D'))) + 56))");
			pStmt.executeQuery();

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
			pStmt = conn.prepareStatement("INSERT INTO JUROR.POOL (part_no, fname, lname, h_email, title, dob, ADDRESS_LINE_1, ADDRESS_LINE_2, ADDRESS_LINE_3, ADDRESS_LINE_4, POSTCODE, h_phone, w_phone, is_active, owner, loc_code, m_phone, responded, poll_number, pool_no, on_call, read_only, contact_preference, reg_spc, ret_date, status, next_date)"
					+ "VALUES ('" + jurorNumber + "', 'Fname', 'Lname', 'email-one@email.com', 'Mr', TO_DATE('1976-07-18 00:00:01', 'YYYY-MM-DD HH24:MI:SS'), '1 Test Street', 'Scotland', 'Strathaven', 'United Kingdom', 'ML106AD', '44135101-1110', '44135201-1110', 'Y', '" + court + "', '" + court + "', '44776-301-1110', 'N', 1000,'" + poolNumber + "', 'N', 'N', 0, 'N', SYSDATE+60, 1, TRUNC(SYSDATE + (8 - TO_NUMBER(TO_CHAR(SYSDATE, 'D'))) + 56))");
			pStmt.executeQuery();

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
					+ "VALUES ('" + court + "','" + court + "999999',null,(SELECT SYSDATE FROM DUAL),(SELECT SYSDATE FROM DUAL),10,10,'R','CRO','" + court + "','N',(SELECT SYSDATE FROM DUAL),'N',null,null,(SELECT SYSDATE FROM DUAL))");
			pStmt.executeQuery();

//			#insert the pool rows
			pStmt = conn.prepareStatement("INSERT INTO JUROR.POOL (part_no, fname, lname, h_email, title, dob, ADDRESS_LINE_1, ADDRESS_LINE_2, ADDRESS_LINE_3, ADDRESS_LINE_4, POSTCODE, h_phone, w_phone, is_active, owner, loc_code, m_phone, responded, poll_number, pool_no, on_call, read_only, contact_preference, reg_spc, ret_date, status)"
					+ "VALUES ('6" + court + "99999', 'Edward', 'Palmer', 'email-one@email.com', 'Mr', TO_DATE('1976-07-18 00:00:01', 'YYYY-MM-DD HH24:MI:SS'), '1 Test Street', 'Scotland', 'Strathaven', 'United Kingdom', 'ML106AD', '44135101-1110', '44135201-1110', 'Y', '400', '" + court + "', '44776-301-1110', 'N', 1000,'" + court + "222222', 'N', 'N', 0, 'N', (SELECT SYSDATE FROM DUAL), 1)");
			pStmt.executeQuery();

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
					+ "values ('" + newJurorRecordNumber + "','" + poolNo + "','400',null,'Y','7',null,CURRENT_DATE,null,'415','0',null,null,null,null,null,CURRENT_DATE,null,null,null,'Y',null,null,null,null,null,null,CURRENT_DATE,null,null,CURRENT_DATE)");
			pStmt.execute();

			// Insert the Response into JUROR_MOD.JUROR_RESPONSE
			pStmt = conn.prepareStatement("INSERT INTO JUROR_mod.JUROR_RESPONSE (JUROR_NUMBER,DATE_RECEIVED,TITLE,FIRST_NAME,LAST_NAME,ADDRESS_LINE_1,ADDRESS_LINE_2,ADDRESS_LINE_3,ADDRESS_LINE_4,ADDRESS_LINE_5,POSTCODE,PROCESSING_STATUS,DATE_OF_BIRTH,PHONE_NUMBER,ALT_PHONE_NUMBER,EMAIL,RESIDENCY,RESIDENCY_DETAIL,MENTAL_HEALTH_ACT,MENTAL_HEALTH_CAPACITY,MENTAL_HEALTH_ACT_DETAILS,BAIL,BAIL_DETAILS,CONVICTIONS,CONVICTIONS_DETAILS,DEFERRAL,DEFERRAL_REASON,DEFERRAL_DATE,REASONABLE_ADJUSTMENTS_ARRANGEMENTS,EXCUSAL,EXCUSAL_REASON,PROCESSING_COMPLETE,SIGNED,version,THIRDPARTY_FNAME,THIRDPARTY_LNAME,RELATIONSHIP,MAIN_PHONE,OTHER_PHONE,EMAIL_ADDRESS,THIRDPARTY_REASON,THIRDPARTY_OTHER_REASON,JUROR_PHONE_DETAILS,JUROR_EMAIL_DETAILS,STAFF_LOGIN,STAFF_ASSIGNMENT_DATE,URGENT,SUPER_URGENT,COMPLETED_AT,WELSH,REPLY_TYPE)"
					+ "VALUES ('" + newJurorRecordNumber + "',CURRENT_DATE-1,'Mr','" + firstName + "','" + lastName + "','7 Poppy Square','New Theo','','','','W1 1AB','TODO',CURRENT_DATE-10000,null,null,null,'Y',null,'N','N',NULL,'N',null,'N',null,null,null,null,null,null,null,'N','N','0',null,null,null,null,null,null,null,null,null,null,'MODTESTBUREAU',null,'N','N',null,'N','Paper')");
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
					+ "values ('" + newJurorRecordNumber + "','415230501','400',null,'Y','7',null,CURRENT_DATE,null,'415','0',null,null,null,null,null,CURRENT_DATE,null,null,null,'Y',null,null,null,null,null,null,CURRENT_DATE,null,null,CURRENT_DATE)");
			pStmt.execute();

			// Insert the Response into JUROR_MOD.JUROR_RESPONSE
			pStmt = conn.prepareStatement("INSERT INTO JUROR_mod.JUROR_RESPONSE (JUROR_NUMBER,DATE_RECEIVED,TITLE,FIRST_NAME,LAST_NAME,ADDRESS_LINE_1,ADDRESS_LINE_2,ADDRESS_LINE_3,ADDRESS_LINE_4,ADDRESS_LINE_5,POSTCODE,PROCESSING_STATUS,DATE_OF_BIRTH,PHONE_NUMBER,ALT_PHONE_NUMBER,EMAIL,RESIDENCY,RESIDENCY_DETAIL,MENTAL_HEALTH_ACT,MENTAL_HEALTH_CAPACITY,MENTAL_HEALTH_ACT_DETAILS,BAIL,BAIL_DETAILS,CONVICTIONS,CONVICTIONS_DETAILS,DEFERRAL,DEFERRAL_REASON,DEFERRAL_DATE,REASONABLE_ADJUSTMENTS_ARRANGEMENTS,EXCUSAL,EXCUSAL_REASON,PROCESSING_COMPLETE,SIGNED,version,THIRDPARTY_FNAME,THIRDPARTY_LNAME,RELATIONSHIP,MAIN_PHONE,OTHER_PHONE,EMAIL_ADDRESS_LINE_1,THIRDPARTY_REASON,THIRDPARTY_OTHER_REASON,JUROR_PHONE_DETAILS,JUROR_EMAIL_DETAILS,STAFF_LOGIN,STAFF_ASSIGNMENT_DATE,URGENT,SUPER_URGENT,COMPLETED_AT,WELSH,REPLY_TYPE)"
					+ "VALUES ('" + newJurorRecordNumber + "',CURRENT_DATE-1,'Mr','Fname','Lname','7 Poppy Square','New Theo','','','','W1 1AB','TODO',CURRENT_DATE-10000,null,null,null,'Y',null,'N','N',NULL,'N',null,'N',null,null,null,null,null,null,null,'N','N','0',null,null,null,null,null,null,null,null,null,null,'MODTESTBUREAU',null,'N','N',null,'N','Digital')");
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


	public void insertHolidayInTheFutureNSD(Integer noOfWeeks, String owner) throws SQLException {
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

		holidayDate = new SimpleDateFormat(datePattern).format((mondayDate).getTime());
		holidayOwner = owner;

		try {

			pStmt = conn.prepareStatement("INSERT INTO JUROR_MOD.HOLIDAY(LOC_CODE,HOLIDAY,DESCRIPTION,PUBLIC)"
					+ "VALUES ('" + owner + "','" + mondayDate + "','Test holiday', 'N')");
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

	public void cleanNewActivePools(String poolNumbersIN) throws SQLException {
		db = new DBConnection();
		String env_property = System.getProperty("env.database");
		if (env_property != null)
			conn = db.getConnection(env_property);
		else
			conn = db.getConnection("demo");
		try {
			pStmt = conn.prepareStatement("DELETE FROM JUROR.POOL WHERE POOL_NO IN " + poolNumbersIN);
			pStmt.executeQuery();
			conn.commit();
			log.info("DELETED FROM JUROR.POOL WHERE POOL_NO IN " + poolNumbersIN);

			pStmt = conn.prepareStatement("DELETE FROM JUROR.UNIQUE_POOL WHERE POOL_NO IN " + poolNumbersIN);
			pStmt.executeQuery();
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
			pStmt = conn.prepareStatement("INSERT INTO JUROR.PASSWORD (OWNER,LOGIN,PASSWORD,LAST_USED,USER_LEVEL,ARAMIS_AUTH_CODE,ARAMIS_MAX_AUTH,PASSWORD_CHANGED_DATE,LOGIN_ENABLED_YN) VALUES ('400','MODTESTBUREAU','32CA9FC1A0F5B633',to_date(SYSDATE,'DD-MON-RR'),'1','123456789',12345678.12,to_date(SYSDATE,'DD-MON-RR'),'Y')");
			pStmt.executeQuery();
			conn.commit();
			log.info("INSERTED INTO JUROR.PASSWORD LOGIN 'MODTESTBUREAU'");

			pStmt = conn.prepareStatement("INSERT INTO JUROR.PASSWORD (OWNER,LOGIN,PASSWORD,LAST_USED,USER_LEVEL,ARAMIS_AUTH_CODE,ARAMIS_MAX_AUTH,PASSWORD_CHANGED_DATE,LOGIN_ENABLED_YN) VALUES ('415','MODTESTCOURT','32CA9FC1A0F5B633',to_date(SYSDATE,'DD-MON-RR'),'1','123456789',12345678.12,to_date(SYSDATE,'DD-MON-RR'),'Y')");
			pStmt.executeQuery();
			conn.commit();
			log.info("INSERTED INTO JUROR.PASSWORD LOGIN 'MODTESTCOURT'");

			pStmt = conn.prepareStatement("INSERT INTO JUROR.PASSWORD (OWNER,LOGIN,PASSWORD,LAST_USED,USER_LEVEL,ARAMIS_AUTH_CODE,ARAMIS_MAX_AUTH,PASSWORD_CHANGED_DATE,LOGIN_ENABLED_YN) VALUES ('415','MODCOURT','32CA9FC1A0F5B633',to_date(SYSDATE,'DD-MON-RR'),'1','123456789',12345678.12,to_date(SYSDATE,'DD-MON-RR'),'Y')");
			pStmt.executeQuery();
			conn.commit();
			log.info("INSERTED INTO JUROR.PASSWORD LOGIN 'MODCOURT'");

			pStmt = conn.prepareStatement("INSERT INTO JUROR.PASSWORD (OWNER,LOGIN,PASSWORD,LAST_USED,USER_LEVEL,ARAMIS_AUTH_CODE,ARAMIS_MAX_AUTH,PASSWORD_CHANGED_DATE,LOGIN_ENABLED_YN) VALUES ('415','MODBUREAUOFFICER','32CA9FC1A0F5B633',to_date(SYSDATE,'DD-MON-RR'),'0','123456789',12345678.12,to_date(SYSDATE,'DD-MON-RR'),'Y')");
			pStmt.executeQuery();
			conn.commit();
			log.info("INSERTED INTO JUROR.PASSWORD LOGIN 'MODBUREAUOFFICER'");

			pStmt = conn.prepareStatement("INSERT INTO JUROR_DIGITAL.STAFF (LOGIN, NAME, RANK, ACTIVE, TEAM_ID, VERSION) VALUES ('MODTESTBUREAU','MODTESTBUREAU', 1, 1, 1, 0)");
			pStmt.executeQuery();
			conn.commit();
			log.info("INSERTED INTO JUROR_DIGITAL_USER.STAFF LOGIN 'MODTESTBUREAU'");

			pStmt = conn.prepareStatement("INSERT INTO JUROR_DIGITAL.STAFF (LOGIN, NAME, RANK, ACTIVE, COURT_1, COURT_2, COURT_3, COURT_4, TEAM_ID, VERSION) VALUES ('MODTESTCOURT','MODTESTCOURT', 1, 1, '415', '457', '774', '416', 2, 0)");
			pStmt.executeQuery();
			conn.commit();
			log.info("INSERTED INTO JUROR_DIGITAL_USER.STAFF LOGIN 'MODTESTCOURT'");

			pStmt = conn.prepareStatement("INSERT INTO JUROR_DIGITAL.STAFF (LOGIN, NAME, RANK, ACTIVE, COURT_1, COURT_2, COURT_3, TEAM_ID, VERSION) VALUES ('MODCOURT','MODCOURT', 1, 1, '415', '416', '457', 2, 0)");
			pStmt.executeQuery();
			conn.commit();
			log.info("INSERTED INTO JUROR_DIGITAL_USER.STAFF LOGIN 'MODCOURT'");

			pStmt = conn.prepareStatement("INSERT INTO JUROR_DIGITAL.STAFF (LOGIN, NAME, RANK, ACTIVE, COURT_1, COURT_2, COURT_3, TEAM_ID, VERSION) VALUES ('MODBUREAUOFFICER','MODBUREAUOFFICER', 0, 1, '415', '416', '457', 2, 0)");
			pStmt.executeQuery();
			conn.commit();
			log.info("INSERTED INTO JUROR_DIGITAL_USER.STAFF LOGIN 'MODBUREAUOFFICER'");

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

			//update VOTERS set date_selected null for court where part_no begins "1"
			pStmt = conn.prepareStatement("update JUROR_MOD.VOTERS set date_selected1=null where loc_code='" + court + "' and part_no like '1%' or part_no like '2%'");
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

	public void clean_pools_created_yesterdayNSD(String courtCode) throws SQLException {
		//this block of code works out the current pool number prefix based on the date 11 weeks from today
		Calendar calendar = Calendar.getInstance();
		calendar.add(Calendar.WEEK_OF_YEAR, 9);
		String month = String.format("%02d", calendar.get(Calendar.MONTH) + 1);
		String year = String.valueOf(calendar.get(Calendar.YEAR)).substring(2);
		String poolNo = courtCode + year + month + "%'";

		db = new DBConnection();
		String env_property = System.getProperty("env.database");
		if (env_property != null)
			conn = db.getConnection(env_property);
		else
			conn = db.getConnection("demo");
		try {

			pStmt = conn.prepareStatement("Delete from juror_mod.juror_audit where juror_number in (select juror_number from juror_mod.juror_pool where pool_number like '" + poolNo + ")");
			pStmt.execute();

			pStmt = conn.prepareStatement("Delete from juror_mod.user_juror_response_audit where juror_number in (select juror_number from juror_mod.juror_pool where pool_number like '" + poolNo + ")");
			pStmt.execute();

			pStmt = conn.prepareStatement("Delete from juror_mod.juror_response_aud where juror_number in (select juror_number from juror_mod.juror_pool where pool_number like '" + poolNo + ")");
			pStmt.execute();

			pStmt = conn.prepareStatement("Delete from juror_mod.juror_response_cjs_employment where juror_number in (select juror_number from juror_mod.juror_pool where pool_number like '" + poolNo + ")");
			pStmt.execute();

			pStmt = conn.prepareStatement("Delete from juror_mod.juror_reasonable_adjustment where juror_number in (select juror_number from juror_mod.juror_pool where pool_number like '" + poolNo + ")");
			pStmt.execute();

			pStmt = conn.prepareStatement("Delete from juror_mod.juror_response where juror_number in (select juror_number from juror_mod.juror_pool where pool_number like '" + poolNo + ")");
			pStmt.execute();

			pStmt = conn.prepareStatement("delete from juror_mod.juror_pool where pool_number like '" + poolNo);
			pStmt.execute();

			pStmt = conn.prepareStatement("delete from juror_mod.pool_history where pool_no like '" + poolNo);
			pStmt.execute();

			pStmt = conn.prepareStatement("delete from juror_mod.pool_comments where pool_no like '" + poolNo);
			pStmt.execute();

			pStmt = conn.prepareStatement("delete from juror_mod.pool where pool_no like '" + poolNo);
			pStmt.execute();

			log.info("deleted pools with pool no like " + poolNo);

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

	public void updateVotersPostcodeNSD(String court, String postcode) throws SQLException {
		db = new DBConnection();
		String env_property = System.getProperty("env.database");
		if (env_property != null)
			conn = db.getConnection(env_property);
		else
			conn = db.getConnection("demo");
		try {
			pStmt = conn.prepareStatement("update JUROR_MOD.VOTERS set ZIP='" + postcode + "' where loc_code='" + court + "' and poll_number <'250'");
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
			pStmt = conn.prepareStatement("update juror_digital.app_settings set value='TRUE' where setting = 'PCQ_SERVICE_ENABLED'");
//              pStmt = conn.prepareStatement("Insert into JUROR_DIGITAL.APP_SETTINGS (SETTING,VALUE) values ('PCQ_SERVICE_RETURN_URL','http://172.117.3.70:3000/steps/confirm-information')");
			pStmt.executeQuery();

			pStmt = conn.prepareStatement("update juror_digital.app_settings set value='https://pcq.aat.platform.hmcts.net' where setting = 'PCQ_SERVICE_URL'");
			pStmt.executeQuery();

			pStmt = conn.prepareStatement("update juror_digital.app_settings set value=? where setting = 'PCQ_SERVICE_RETURN_URL'");
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

	public void pcqDisabled() throws SQLException {
		db = new DBConnection();
		String env_property = System.getProperty("env.database");
		if (env_property != null)
			conn = db.getConnection(env_property);
		else
			conn = db.getConnection("demo");
		try {
			pStmt = conn.prepareStatement("update juror_digital.app_settings set value='FALSE' where setting = 'PCQ_SERVICE_ENABLED'");
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

	public int getCoronerPoolNo() throws SQLException {
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

	public void resetVotersNSD(String courtCode) throws SQLException {
		db = new DBConnection();
		String env_property = System.getProperty("env.database");
		if (env_property != null)
			conn = db.getConnection(env_property);
		else
			conn = db.getConnection("demo");
		try {
			pStmt = conn.prepareStatement("update JUROR_MOD.VOTERS set date_selected1 = null where pool_number like '" + courtCode + "%' and part_no not in (select juror_number from juror_mod.juror_pool)");
			pStmt.execute();
			log.info("Updated juror_mod.voters to set '" + courtCode + "' rows to unselected");
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

	public void insertMultipleNewPoolsWithDeferralNSD(String court, int noOfPools, String owner, String noWeeks) throws SQLException {
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
			LocalDate localDateMonday = localDate.with(TemporalAdjusters.next(DayOfWeek.MONDAY));
//			Date mondayDate = Date.from(localDateMonday.atStartOfDay().atZone(ZoneId.systemDefault()).toInstant());

//			String expectedDate = new SimpleDateFormat(datePattern).format((mondayDate).getTime());

			pStmt = conn.prepareStatement("DELETE FROM JUROR_MOD.JUROR_POOL WHERE POOL_NUMBER = '" + court + "111111'");
			pStmt.execute();

			pStmt = conn.prepareStatement("DELETE FROM JUROR_mod.POOL WHERE POOL_NO=  '" + court + "111111'");
			pStmt.execute();

			pStmt = conn.prepareStatement("Insert into juror_mod.pool (pool_no, owner, return_date, no_requested, pool_type, loc_code, new_request, last_update, additional_summons, attend_time, total_no_required, date_created)"
					+ "values ('" + court + "111111','" + owner + "','" + localDateMonday + "','5','CRO','" + court + "','N',NOW(),null,TIMESTAMP'2022-04-01 09:30:00.0','5',NOW())");
			pStmt.execute();


			for (int index = 0; index < noOfPools; index++) {

				pStmt = conn.prepareStatement("DELETE FROM JUROR_MOD.bulk_print_data WHERE JUROR_NO = '0" + court + "0000" + index + "'");
				pStmt.execute();

				pStmt = conn.prepareStatement("DELETE FROM JUROR_MOD.JUROR_POOL WHERE JUROR_NUMBER = '0" + court + "0000" + index + "'");
				pStmt.execute();

				pStmt = conn.prepareStatement("DELETE FROM JUROR_MOD.POOL WHERE POOL_NO = '" + court + "00000" + index + "'");
				pStmt.execute();

				pStmt = conn.prepareStatement("DELETE FROM JUROR_MOD.JUROR_HISTORY WHERE JUROR_NUMBER = '0" + court + "0000" + index + "'");
				pStmt.execute();

				pStmt = conn.prepareStatement("DELETE FROM JUROR_MOD.JUROR WHERE JUROR_NUMBER = '0" + court + "0000" + index + "'");
				pStmt.execute();

				pStmt = conn.prepareStatement("Insert into juror_mod.pool (pool_no, owner, return_date, no_requested, pool_type, loc_code, new_request, last_update, additional_summons, attend_time, total_no_required, date_created)"
						+ "values ('" + court + "00000" + index + "','" + owner + "','" + localDateMonday + "','5','CRO','" + court + "','T',NOW(),null,TIMESTAMP'2022-04-01 09:30:00.0','5',NOW())");
				pStmt.execute();

				pStmt = conn.prepareStatement("insert into juror_mod.juror (juror_number,poll_number,title,last_name,first_name,dob,ADDRESS_LINE_1,ADDRESS_LINE_2,ADDRESS_LINE_3,ADDRESS_LINE_4,ADDRESS_LINE_5,POSTCODE,h_phone,w_phone,w_ph_local,responded,date_excused,excusal_code,acc_exc,date_disq,disq_code,user_edtq,notes,no_def_pos,perm_disqual,reasonable_adj_code,reasonable_adj_msg,sort_code,bank_acct_name,bank_acct_no,bldg_soc_roll_no,welsh,police_check,last_update,summons_file,m_phone,h_email,contact_preference,notifications,date_created,optic_reference,pending_title,pending_first_name,pending_last_name)"
						+ "values ('0" + court + "0000" + index + "','857',null,'lname','fname',null,'address',null,null,null,null,'CH1 2NN',null,null,null,'Y',null,null,null,null,null,null,null,'1',null,null,null,null,null,null,null,'N','NOT_CHECKED',null,null,null,null,null,'0',null,null,null,null,null)");
				pStmt.execute();

				pStmt = conn.prepareStatement("insert into juror_mod.juror_pool (juror_number,pool_number,owner,user_edtq,is_active,status,times_sel,def_date,location,no_attendances,no_attended,no_fta,no_awol,pool_seq,edit_tag,next_date,on_call,was_deferred,deferral_code,id_checked,postpone,paid_cash,scan_code,last_update,reminder_sent,transfer_date,date_created)"
						+ "values ('0" + court + "0000" + index + "','" + court + "00000" + index + "','" + owner + "', 'MODTESTBUREAU', true, 7, NULL, '" + localDateMonday + "', NULL, '" + court + "', NULL, NULL, NULL, '0001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CURRENT_DATE, NULL, NULL, CURRENT_DATE)");
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
						+ "values ('0" + court + "0001" + index + "','" + court + "133333','" + owner + "', 'MODTESTBUREAU', true, 2, NULL, null, NULL, null, NULL, NULL, NULL, '0001', NULL, NULL, NULL, NULL, NULL, null, NULL, NULL, NULL, CURRENT_DATE, NULL, NULL, CURRENT_DATE)");
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

			pStmt = conn.prepareStatement("INSERT INTO JUROR_MOD.VOTERS (LOC_CODE,PART_NO,REGISTER_LETT,POLL_NUMBER,NEW_MARKER,TITLE,LNAME,FNAME,DOB,FLAGS,ADDRESS,ADDRESS2,ADDRESS3,ADDRESS4,ADDRESS5,ADDRESS6,ZIP,DATE_SELECTED1,DATE_SELECTED2,DATE_SELECTED3,REC_NUM,PERM_DISQUAL,SOURCE_ID)" +
					"VALUES ('" + court + "','9" + court + "99999','999','999',NULL,NULL,'LNAMEONE','FNAMEONE',NULL,NULL,'1 STREET NAME','ANYTOWN',NULL,NULL,NULL,NULL,'CH1 2AN',CURRENT_DATE,NULL,NULL,1,NULL,NULL)");
			pStmt.execute();

			pStmt = conn.prepareStatement("INSERT INTO JUROR_MOD.VOTERS (LOC_CODE,PART_NO,REGISTER_LETT,POLL_NUMBER,NEW_MARKER,TITLE,LNAME,FNAME,DOB,FLAGS,ADDRESS,ADDRESS2,ADDRESS3,ADDRESS4,ADDRESS5,ADDRESS6,ZIP,DATE_SELECTED1,DATE_SELECTED2,DATE_SELECTED3,REC_NUM,PERM_DISQUAL,SOURCE_ID)" +
					"VALUES ('" + court + "','9" + court + "99998','998','998',NULL,NULL,'LNAMETWO','FNAMETWO',NULL,NULL,'2 STREET NAME','ANYTOWN',NULL,NULL,NULL,NULL,'CH1 2AN',CURRENT_DATE,NULL,NULL,1,NULL,NULL)");
			pStmt.execute();

			pStmt = conn.prepareStatement("insert into juror_mod.juror (juror_number,poll_number,title,last_name,first_name,dob,ADDRESS_LINE_1,ADDRESS_LINE_2,ADDRESS_LINE_3,ADDRESS_LINE_4,ADDRESS_LINE_5,POSTCODE,h_phone,w_phone,w_ph_local,responded,date_excused,excusal_code,acc_exc,date_disq,disq_code,user_edtq,notes,no_def_pos,perm_disqual,reasonable_adj_code,reasonable_adj_msg,sort_code,bank_acct_name,bank_acct_no,bldg_soc_roll_no,welsh,police_check,last_update,summons_file,m_phone,h_email,contact_preference,notifications,date_created,optic_reference,pending_title,pending_first_name,pending_last_name)"
					+ "values ('9" + court + "99999','857',null,'lname','fname',null,'address',null,null,null,null,'CH1 2NN',null,null,null,false,null,null,null,null,null,null,null,'1',null,null,null,null,null,null,null,'N','NOT_CHECKED',null,null,null,null,null,'0',null,null,null,null,null)");
			pStmt.execute();

			pStmt = conn.prepareStatement("insert into juror_mod.juror_pool (juror_number,pool_number,owner,user_edtq,is_active,status,times_sel,def_date,location,no_attendances,no_attended,no_fta,no_awol,pool_seq,edit_tag,next_date,on_call,was_deferred,deferral_code,id_checked,postpone,paid_cash,scan_code,last_update,reminder_sent,transfer_date,date_created)"
					+ "values ('9" + court + "99999','" + court + "222222','400',null,true,'1',null,null,'400','0',null,null,null,null,null,CURRENT_DATE+112,null,'N',NULL,null,null,null,null,CURRENT_DATE,null,null,CURRENT_DATE)");
			pStmt.execute();

			pStmt = conn.prepareStatement("insert into juror_mod.juror (juror_number,poll_number,title,last_name,first_name,dob,ADDRESS_LINE_1,ADDRESS_LINE_2,ADDRESS_LINE_3,ADDRESS_LINE_4,ADDRESS_LINE_5,POSTCODE,h_phone,w_phone,w_ph_local,responded,date_excused,excusal_code,acc_exc,date_disq,disq_code,user_edtq,notes,no_def_pos,perm_disqual,reasonable_adj_code,reasonable_adj_msg,sort_code,bank_acct_name,bank_acct_no,bldg_soc_roll_no,welsh,police_check,last_update,summons_file,m_phone,h_email,contact_preference,notifications,date_created,optic_reference,pending_title,pending_first_name,pending_last_name)"
					+ "values ('9" + court + "99998','857',null,'lname','fname',null,'address',null,null,null,null,'CH1 2NN',null,null,null,'Y',null,null,null,null,null,null,null,'1',null,null,null,null,null,null,null,'N','NOT_CHECKED',null,null,null,null,null,'0',null,null,null,null,null)");
			pStmt.execute();

			pStmt = conn.prepareStatement("insert into juror_mod.juror_pool (juror_number,pool_number,owner,user_edtq,is_active,status,times_sel,def_date,location,no_attendances,no_attended,no_fta,no_awol,pool_seq,edit_tag,next_date,on_call,was_deferred,deferral_code,id_checked,postpone,paid_cash,scan_code,last_update,reminder_sent,transfer_date,date_created)"
					+ "values ('9" + court + "99998','" + court + "222222','400',null,'Y','2',null,null,'400','0',null,null,null,null,null,CURRENT_DATE+112,null,'N',NULL,null,null,null,null,CURRENT_DATE,null,null,CURRENT_DATE)");
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

			pStmt = conn.prepareStatement("INSERT INTO JUROR_MOD.VOTERS (LOC_CODE,PART_NO,REGISTER_LETT,POLL_NUMBER,NEW_MARKER,TITLE,LNAME,FNAME,DOB,FLAGS,ADDRESS,ADDRESS2,ADDRESS3,ADDRESS4,ADDRESS5,ADDRESS6,ZIP,DATE_SELECTED1,DATE_SELECTED2,DATE_SELECTED3,REC_NUM,PERM_DISQUAL,SOURCE_ID)" +
					"VALUES ('" + court + "','6" + court + "91101','101','101',NULL,NULL,'LNAMEONE','FNAMEONE',NULL,NULL,'1 STREET NAME','ANYTOWN',NULL,NULL,NULL,NULL,'CH1 2AN',CURRENT_DATE,NULL,NULL,1,NULL,NULL)");
			pStmt.execute();

			pStmt = conn.prepareStatement("INSERT INTO JUROR_MOD.VOTERS (LOC_CODE,PART_NO,REGISTER_LETT,POLL_NUMBER,NEW_MARKER,TITLE,LNAME,FNAME,DOB,FLAGS,ADDRESS,ADDRESS2,ADDRESS3,ADDRESS4,ADDRESS5,ADDRESS6,ZIP,DATE_SELECTED1,DATE_SELECTED2,DATE_SELECTED3,REC_NUM,PERM_DISQUAL,SOURCE_ID)" +
					"VALUES ('" + court + "','6" + court + "91102','102','102',NULL,NULL,'LNAMETWO','FNAMETWO',NULL,NULL,'2 STREET NAME','ANYTOWN',NULL,NULL,NULL,NULL,'CH1 2AN',CURRENT_DATE,NULL,NULL,1,NULL,NULL)");
			pStmt.execute();

			pStmt = conn.prepareStatement("INSERT INTO JUROR_MOD.VOTERS (LOC_CODE,PART_NO,REGISTER_LETT,POLL_NUMBER,NEW_MARKER,TITLE,LNAME,FNAME,DOB,FLAGS,ADDRESS,ADDRESS2,ADDRESS3,ADDRESS4,ADDRESS5,ADDRESS6,ZIP,DATE_SELECTED1,DATE_SELECTED2,DATE_SELECTED3,REC_NUM,PERM_DISQUAL,SOURCE_ID)" +
					"VALUES ('" + court + "','6" + court + "91103','103','103',NULL,NULL,'LNAMETWO','FNAMETWO',NULL,NULL,'2 STREET NAME','ANYTOWN',NULL,NULL,NULL,NULL,'CH1 2AN',CURRENT_DATE,NULL,NULL,1,NULL,NULL)");
			pStmt.execute();

			pStmt = conn.prepareStatement("INSERT INTO JUROR_MOD.VOTERS (LOC_CODE,PART_NO,REGISTER_LETT,POLL_NUMBER,NEW_MARKER,TITLE,LNAME,FNAME,DOB,FLAGS,ADDRESS,ADDRESS2,ADDRESS3,ADDRESS4,ADDRESS5,ADDRESS6,ZIP,DATE_SELECTED1,DATE_SELECTED2,DATE_SELECTED3,REC_NUM,PERM_DISQUAL,SOURCE_ID)" +
					"VALUES ('" + court + "','6" + court + "91104','104','104',NULL,NULL,'LNAMETWO','FNAMETWO',NULL,NULL,'2 STREET NAME','ANYTOWN',NULL,NULL,NULL,NULL,'CH1 2AN',CURRENT_DATE,NULL,NULL,1,NULL,NULL)");
			pStmt.execute();

			pStmt = conn.prepareStatement("INSERT INTO JUROR_MOD.VOTERS (LOC_CODE,PART_NO,REGISTER_LETT,POLL_NUMBER,NEW_MARKER,TITLE,LNAME,FNAME,DOB,FLAGS,ADDRESS,ADDRESS2,ADDRESS3,ADDRESS4,ADDRESS5,ADDRESS6,ZIP,DATE_SELECTED1,DATE_SELECTED2,DATE_SELECTED3,REC_NUM,PERM_DISQUAL,SOURCE_ID)" +
					"VALUES ('" + court + "','6" + court + "91105','105','105',NULL,NULL,'LNAMETWO','FNAMETWO',NULL,NULL,'2 STREET NAME','ANYTOWN',NULL,NULL,NULL,NULL,'CH1 2AN',CURRENT_DATE,NULL,NULL,1,NULL,NULL)");
			pStmt.execute();

			pStmt = conn.prepareStatement("INSERT INTO JUROR_MOD.VOTERS (LOC_CODE,PART_NO,REGISTER_LETT,POLL_NUMBER,NEW_MARKER,TITLE,LNAME,FNAME,DOB,FLAGS,ADDRESS,ADDRESS2,ADDRESS3,ADDRESS4,ADDRESS5,ADDRESS6,ZIP,DATE_SELECTED1,DATE_SELECTED2,DATE_SELECTED3,REC_NUM,PERM_DISQUAL,SOURCE_ID)" +
					"VALUES ('" + court + "','6" + court + "91106','106','106',NULL,NULL,'LNAMETWO','FNAMETWO',NULL,NULL,'2 STREET NAME','ANYTOWN',NULL,NULL,NULL,NULL,'CH1 2AN',CURRENT_DATE,NULL,NULL,1,NULL,NULL)");
			pStmt.execute();

			pStmt = conn.prepareStatement("INSERT INTO JUROR_MOD.VOTERS (LOC_CODE,PART_NO,REGISTER_LETT,POLL_NUMBER,NEW_MARKER,TITLE,LNAME,FNAME,DOB,FLAGS,ADDRESS,ADDRESS2,ADDRESS3,ADDRESS4,ADDRESS5,ADDRESS6,ZIP,DATE_SELECTED1,DATE_SELECTED2,DATE_SELECTED3,REC_NUM,PERM_DISQUAL,SOURCE_ID)" +
					"VALUES ('" + court + "','6" + court + "91107','107','107',NULL,NULL,'LNAMETWO','FNAMETWO',NULL,NULL,'2 STREET NAME','ANYTOWN',NULL,NULL,NULL,NULL,'CH1 2AN',CURRENT_DATE,NULL,NULL,1,NULL,NULL)");
			pStmt.execute();

			pStmt = conn.prepareStatement("INSERT INTO JUROR_MOD.VOTERS (LOC_CODE,PART_NO,REGISTER_LETT,POLL_NUMBER,NEW_MARKER,TITLE,LNAME,FNAME,DOB,FLAGS,ADDRESS,ADDRESS2,ADDRESS3,ADDRESS4,ADDRESS5,ADDRESS6,ZIP,DATE_SELECTED1,DATE_SELECTED2,DATE_SELECTED3,REC_NUM,PERM_DISQUAL,SOURCE_ID)" +
					"VALUES ('" + court + "','6" + court + "91108','108','108',NULL,NULL,'LNAMETWO','FNAMETWO',NULL,NULL,'2 STREET NAME','ANYTOWN',NULL,NULL,NULL,NULL,'CH1 2AN',CURRENT_DATE,NULL,NULL,1,NULL,NULL)");
			pStmt.execute();

			pStmt = conn.prepareStatement("INSERT INTO JUROR_MOD.VOTERS (LOC_CODE,PART_NO,REGISTER_LETT,POLL_NUMBER,NEW_MARKER,TITLE,LNAME,FNAME,DOB,FLAGS,ADDRESS,ADDRESS2,ADDRESS3,ADDRESS4,ADDRESS5,ADDRESS6,ZIP,DATE_SELECTED1,DATE_SELECTED2,DATE_SELECTED3,REC_NUM,PERM_DISQUAL,SOURCE_ID)" +
					"VALUES ('" + court + "','6" + court + "91109','109','109',NULL,NULL,'LNAMETWO','FNAMETWO',NULL,NULL,'2 STREET NAME','ANYTOWN',NULL,NULL,NULL,NULL,'CH1 2AN',CURRENT_DATE,NULL,NULL,1,NULL,NULL)");
			pStmt.execute();

			//juror

			pStmt = conn.prepareStatement("insert into juror_mod.juror (juror_number,poll_number,title,last_name,first_name,dob,ADDRESS_LINE_1,ADDRESS_LINE_2,ADDRESS_LINE_3,ADDRESS_LINE_4,ADDRESS_LINE_5,POSTCODE,h_phone,w_phone,w_ph_local,responded,date_excused,excusal_code,acc_exc,date_disq,disq_code,user_edtq,notes,no_def_pos,perm_disqual,reasonable_adj_code,reasonable_adj_msg,sort_code,bank_acct_name,bank_acct_no,bldg_soc_roll_no,welsh,police_check,last_update,summons_file,m_phone,h_email,contact_preference,notifications,date_created,optic_reference,pending_title,pending_first_name,pending_last_name)"
					+ "values ('6" + court + "91101','857',null,'lname','fname',null,'address',null,null,null,null,'CH1 2NN',null,null,null,'N',null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,'N','NOT_CHECKED',null,null,null,null,null,'0',null,null,null,null,null)");
			pStmt.execute();

			pStmt = conn.prepareStatement("insert into juror_mod.juror_pool (juror_number,pool_number,owner,user_edtq,is_active,status,times_sel,def_date,location,no_attendances,no_attended,no_fta,no_awol,pool_seq,edit_tag,next_date,on_call,was_deferred,deferral_code,id_checked,postpone,paid_cash,scan_code,last_update,reminder_sent,transfer_date,date_created)"
					+ "values ('6" + court + "91101','" + court + "911911', '400', 'MODTESTBUREAU', true, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2024-01-10 09:18:32.634', NULL, NULL, '2024-01-10 09:18:11.734')");
			pStmt.execute();

			pStmt = conn.prepareStatement("insert into juror_mod.juror (juror_number,poll_number,title,last_name,first_name,dob,ADDRESS_LINE_1,ADDRESS_LINE_2,ADDRESS_LINE_3,ADDRESS_LINE_4,ADDRESS_LINE_5,POSTCODE,h_phone,w_phone,w_ph_local,responded,date_excused,excusal_code,acc_exc,date_disq,disq_code,user_edtq,notes,no_def_pos,perm_disqual,reasonable_adj_code,reasonable_adj_msg,sort_code,bank_acct_name,bank_acct_no,bldg_soc_roll_no,welsh,police_check,last_update,summons_file,m_phone,h_email,contact_preference,notifications,date_created,optic_reference,pending_title,pending_first_name,pending_last_name)"
					+ "values ('6" + court + "91102','857',null,'lname','fname',null,'address',null,null,null,null,'CH1 2NN',null,null,null,'Y',null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,'N','NOT_CHECKED',null,null,null,null,null,'0',null,null,null,null,null)");
			pStmt.execute();

			pStmt = conn.prepareStatement("insert into juror_mod.juror_pool (juror_number,pool_number,owner,user_edtq,is_active,status,times_sel,def_date,location,no_attendances,no_attended,no_fta,no_awol,pool_seq,edit_tag,next_date,on_call,was_deferred,deferral_code,id_checked,postpone,paid_cash,scan_code,last_update,reminder_sent,transfer_date,date_created)"
					+ "values ('6" + court + "91102','" + court + "911911', '400', 'MODTESTBUREAU', true, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2024-01-10 09:18:32.634', NULL, NULL, '2024-01-10 09:18:11.734')");
			pStmt.execute();

			pStmt = conn.prepareStatement("insert into juror_mod.juror (juror_number,poll_number,title,last_name,first_name,dob,ADDRESS_LINE_1,ADDRESS_LINE_2,ADDRESS_LINE_3,ADDRESS_LINE_4,ADDRESS_LINE_5,POSTCODE,h_phone,w_phone,w_ph_local,responded,date_excused,excusal_code,acc_exc,date_disq,disq_code,user_edtq,notes,no_def_pos,perm_disqual,reasonable_adj_code,reasonable_adj_msg,sort_code,bank_acct_name,bank_acct_no,bldg_soc_roll_no,welsh,police_check,last_update,summons_file,m_phone,h_email,contact_preference,notifications,date_created,optic_reference,pending_title,pending_first_name,pending_last_name)"
					+ "values ('6" + court + "91105','857',null,'lname','fname',null,'address',null,null,null,null,'CH1 2NN',null,null,null,'Y',null,null,null,null,null,null,null,'1',null,null,null,null,null,null,null,'N','NOT_CHECKED',null,null,null,null,null,'0',null,null,null,null,null)");
			pStmt.execute();

			pStmt = conn.prepareStatement("insert into juror_mod.juror_pool (juror_number,pool_number,owner,user_edtq,is_active,status,times_sel,def_date,location,no_attendances,no_attended,no_fta,no_awol,pool_seq,edit_tag,next_date,on_call,was_deferred,deferral_code,id_checked,postpone,paid_cash,scan_code,last_update,reminder_sent,transfer_date,date_created)"
					+ "values ('6" + court + "91105','" + court + "911911', '400', 'MODTESTBUREAU', true, 5, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2024-01-10 09:18:32.634', NULL, NULL, '2024-01-10 09:18:11.734')");
			pStmt.execute();

			pStmt = conn.prepareStatement("insert into juror_mod.juror (juror_number,poll_number,title,last_name,first_name,dob,ADDRESS_LINE_1,ADDRESS_LINE_2,ADDRESS_LINE_3,ADDRESS_LINE_4,ADDRESS_LINE_5,POSTCODE,h_phone,w_phone,w_ph_local,responded,date_excused,excusal_code,acc_exc,date_disq,disq_code,user_edtq,notes,no_def_pos,perm_disqual,reasonable_adj_code,reasonable_adj_msg,sort_code,bank_acct_name,bank_acct_no,bldg_soc_roll_no,welsh,police_check,last_update,summons_file,m_phone,h_email,contact_preference,notifications,date_created,optic_reference,pending_title,pending_first_name,pending_last_name)"
					+ "values ('6" + court + "91106','857',null,'lname','fname',null,'address',null,null,null,null,'CH1 2NN',null,null,null,'Y',null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,'N','NOT_CHECKED',null,null,null,null,null,'0',null,null,null,null,null)");
			pStmt.execute();

			pStmt = conn.prepareStatement("insert into juror_mod.juror_pool (juror_number,pool_number,owner,user_edtq,is_active,status,times_sel,def_date,location,no_attendances,no_attended,no_fta,no_awol,pool_seq,edit_tag,next_date,on_call,was_deferred,deferral_code,id_checked,postpone,paid_cash,scan_code,last_update,reminder_sent,transfer_date,date_created)"
					+ "values ('6" + court + "91106','" + court + "911911', '400', 'MODTESTBUREAU', true, 6, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2024-01-10 09:18:32.634', NULL, NULL, '2024-01-10 09:18:11.734')");
			pStmt.execute();

			pStmt = conn.prepareStatement("insert into juror_mod.juror (juror_number,poll_number,title,last_name,first_name,dob,ADDRESS_LINE_1,ADDRESS_LINE_2,ADDRESS_LINE_3,ADDRESS_LINE_4,ADDRESS_LINE_5,POSTCODE,h_phone,w_phone,w_ph_local,responded,date_excused,excusal_code,acc_exc,date_disq,disq_code,user_edtq,notes,no_def_pos,perm_disqual,reasonable_adj_code,reasonable_adj_msg,sort_code,bank_acct_name,bank_acct_no,bldg_soc_roll_no,welsh,police_check,last_update,summons_file,m_phone,h_email,contact_preference,notifications,date_created,optic_reference,pending_title,pending_first_name,pending_last_name)"
					+ "values ('6" + court + "91107','857',null,'lname','fname',null,'address',null,null,null,null,'CH1 2NN',null,null,null,'Y',null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,'N','NOT_CHECKED',null,null,null,null,null,'0',null,null,null,null,null)");
			pStmt.execute();

			pStmt = conn.prepareStatement("insert into juror_mod.juror_pool (juror_number,pool_number,owner,user_edtq,is_active,status,times_sel,def_date,location,no_attendances,no_attended,no_fta,no_awol,pool_seq,edit_tag,next_date,on_call,was_deferred,deferral_code,id_checked,postpone,paid_cash,scan_code,last_update,reminder_sent,transfer_date,date_created)"
					+ "values ('6" + court + "91107','" + court + "911911', '400','MODTESTBUREAU', true, 7, NULL, CURRENT_DATE+60, NULL, NULL, NULL, NULL, NULL, '0001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2024-01-10 09:18:32.634', NULL, NULL, '2024-01-10 09:18:11.734')");
			pStmt.execute();

			pStmt = conn.prepareStatement("insert into juror_mod.juror (juror_number,poll_number,title,last_name,first_name,dob,ADDRESS_LINE_1,ADDRESS_LINE_2,ADDRESS_LINE_3,ADDRESS_LINE_4,ADDRESS_LINE_5,POSTCODE,h_phone,w_phone,w_ph_local,responded,date_excused,excusal_code,acc_exc,date_disq,disq_code,user_edtq,notes,no_def_pos,perm_disqual,reasonable_adj_code,reasonable_adj_msg,sort_code,bank_acct_name,bank_acct_no,bldg_soc_roll_no,welsh,police_check,last_update,summons_file,m_phone,h_email,contact_preference,notifications,date_created,optic_reference,pending_title,pending_first_name,pending_last_name)"
					+ "values ('6" + court + "91108','857',null,'lname','fname',null,'address',null,null,null,null,'CH1 2NN',null,null,null,'Y',null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,'N','NOT_CHECKED',null,null,null,null,null,'0',null,null,null,null,null)");
			pStmt.execute();

			pStmt = conn.prepareStatement("insert into juror_mod.juror_pool (juror_number,pool_number,owner,user_edtq,is_active,status,times_sel,def_date,location,no_attendances,no_attended,no_fta,no_awol,pool_seq,edit_tag,next_date,on_call,was_deferred,deferral_code,id_checked,postpone,paid_cash,scan_code,last_update,reminder_sent,transfer_date,date_created)"
					+ "values ('6" + court + "91108','" + court + "911911', '400', 'MODTESTBUREAU', true, 8, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2024-01-10 09:18:32.634', NULL, NULL, '2024-01-10 09:18:11.734')");
			pStmt.execute();

			pStmt = conn.prepareStatement("insert into juror_mod.juror (juror_number,poll_number,title,last_name,first_name,dob,ADDRESS_LINE_1,ADDRESS_LINE_2,ADDRESS_LINE_3,ADDRESS_LINE_4,ADDRESS_LINE_5,POSTCODE,h_phone,w_phone,w_ph_local,responded,date_excused,excusal_code,acc_exc,date_disq,disq_code,user_edtq,notes,no_def_pos,perm_disqual,reasonable_adj_code,reasonable_adj_msg,sort_code,bank_acct_name,bank_acct_no,bldg_soc_roll_no,welsh,police_check,last_update,summons_file,m_phone,h_email,contact_preference,notifications,date_created,optic_reference,pending_title,pending_first_name,pending_last_name)"
					+ "values ('6" + court + "91109','857',null,'lname','fname',null,'address',null,null,null,null,'CH1 2NN',null,null,null,'N',null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,'N','NOT_CHECKED',null,null,null,null,null,'0',null,null,null,null,null)");
			pStmt.execute();

			pStmt = conn.prepareStatement("insert into juror_mod.juror_pool (juror_number,pool_number,owner,user_edtq,is_active,status,times_sel,def_date,location,no_attendances,no_attended,no_fta,no_awol,pool_seq,edit_tag,next_date,on_call,was_deferred,deferral_code,id_checked,postpone,paid_cash,scan_code,last_update,reminder_sent,transfer_date,date_created)"
					+ "values ('6" + court + "91109','" + court + "911911', '400', 'MODTESTBUREAU', true, 9, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2024-01-10 09:18:32.634', NULL, NULL, '2024-01-10 09:18:11.734')");
			pStmt.execute();

			pStmt = conn.prepareStatement("insert into juror_mod.juror (juror_number,poll_number,title,last_name,first_name,dob,ADDRESS_LINE_1,ADDRESS_LINE_2,ADDRESS_LINE_3,ADDRESS_LINE_4,ADDRESS_LINE_5,POSTCODE,h_phone,w_phone,w_ph_local,responded,date_excused,excusal_code,acc_exc,date_disq,disq_code,user_edtq,notes,no_def_pos,perm_disqual,reasonable_adj_code,reasonable_adj_msg,sort_code,bank_acct_name,bank_acct_no,bldg_soc_roll_no,welsh,police_check,last_update,summons_file,m_phone,h_email,contact_preference,notifications,date_created,optic_reference,pending_title,pending_first_name,pending_last_name)"
					+ "values ('6" + court + "91111','857',null,'lname','fname',null,'address',null,null,null,null,'CH1 2NN',null,null,null,'Y',null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,'N','NOT_CHECKED',null,null,null,null,null,'0',null,null,null,null,null)");
			pStmt.execute();

			pStmt = conn.prepareStatement("insert into juror_mod.juror_pool (juror_number,pool_number,owner,user_edtq,is_active,status,times_sel,def_date,location,no_attendances,no_attended,no_fta,no_awol,pool_seq,edit_tag,next_date,on_call,was_deferred,deferral_code,id_checked,postpone,paid_cash,scan_code,last_update,reminder_sent,transfer_date,date_created)"
					+ "values ('6" + court + "91111','" + court + "911911', '400', 'MODTESTBUREAU', true, 11, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2024-01-10 09:18:32.634', NULL, NULL, '2024-01-10 09:18:11.734')");
			pStmt.execute();

			pStmt = conn.prepareStatement("insert into juror_mod.juror (juror_number,poll_number,title,last_name,first_name,dob,ADDRESS_LINE_1,ADDRESS_LINE_2,ADDRESS_LINE_3,ADDRESS_LINE_4,ADDRESS_LINE_5,POSTCODE,h_phone,w_phone,w_ph_local,responded,date_excused,excusal_code,acc_exc,date_disq,disq_code,user_edtq,notes,no_def_pos,perm_disqual,reasonable_adj_code,reasonable_adj_msg,sort_code,bank_acct_name,bank_acct_no,bldg_soc_roll_no,welsh,police_check,last_update,summons_file,m_phone,h_email,contact_preference,notifications,date_created,optic_reference,pending_title,pending_first_name,pending_last_name)"
					+ "values ('6" + court + "91113','857',null,'lname','fname',null,'address',null,null,null,null,'CH1 2NN',null,null,null,'Y',null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,'N','NOT_CHECKED',null,null,null,null,null,'0',null,null,null,null,null)");
			pStmt.execute();

			pStmt = conn.prepareStatement("insert into juror_mod.juror_pool (juror_number,pool_number,owner,user_edtq,is_active,status,times_sel,def_date,location,no_attendances,no_attended,no_fta,no_awol,pool_seq,edit_tag,next_date,on_call,was_deferred,deferral_code,id_checked,postpone,paid_cash,scan_code,last_update,reminder_sent,transfer_date,date_created)"
					+ "values ('6" + court + "91113','" + court + "911911', '400', 'MODTESTBUREAU', true, 13, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2024-01-10 09:18:32.634', NULL, NULL, '2024-01-10 09:18:11.734')");
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

			pStmt = conn.prepareStatement("INSERT INTO JUROR_DIGITAL.VOTERS (LOC_CODE,PART_NO,REGISTER_LETT,POLL_NUMBER,NEW_MARKER,TITLE,LNAME,FNAME,DOB,FLAGS,ADDRESS_LINE_1,ADDRESS_LINE_2,ADDRESS_LINE_3,ADDRESS_LINE_4,ADDRESS_LINE_5,POSTCODE,DATE_SELECTED1,DATE_SELECTED2,DATE_SELECTED3,REC_NUM,PERM_DISQUAL,SOURCE_ID)" +
					"VALUES ('" + court + "','9" + court + "99999','999','999',NULL,NULL,'LNAMEONE','FNAMEONE',NULL,NULL,'1 STREET NAME','ANYTOWN',NULL,NULL,NULL,'CH1 2AN',(SELECT SYSDATE FROM DUAL),NULL,NULL,1,NULL,NULL)");
			pStmt.executeQuery();

			pStmt = conn.prepareStatement("INSERT INTO JUROR_DIGITAL.VOTERS (LOC_CODE,PART_NO,REGISTER_LETT,POLL_NUMBER,NEW_MARKER,TITLE,LNAME,FNAME,DOB,FLAGS,ADDRESS_LINE_1,ADDRESS_LINE_2,ADDRESS_LINE_3,ADDRESS_LINE_4,ADDRESS_LINE_5,POSTCODE,DATE_SELECTED1,DATE_SELECTED2,DATE_SELECTED3,REC_NUM,PERM_DISQUAL,SOURCE_ID)" +
					"VALUES ('" + court + "','9" + court + "99998','998','998',NULL,NULL,'LNAMETWO','FNAMETWO',NULL,NULL,'2 STREET NAME','ANYTOWN',NULL,NULL,NULL,'CH1 2AN',(SELECT SYSDATE FROM DUAL),NULL,NULL,1,NULL,NULL)");
			pStmt.executeQuery();

			pStmt = conn.prepareStatement("INSERT INTO JUROR.POOL (OWNER,PART_NO,POOL_NO,POLL_NUMBER,TITLE,LNAME,FNAME,DOB,ADDRESS_LINE_1,ADDRESS_LINE_2,ADDRESS_LINE_3,ADDRESS_LINE_4,ADDRESS_LINE_5,POSTCODE,H_PHONE,W_PHONE,W_PH_LOCAL,TIMES_SEL,TRIAL_NO,JUROR_NO,REG_SPC,RET_DATE,DEF_DATE,RESPONDED,DATE_EXCUS,EXC_CODE,ACC_EXC,DATE_DISQ,DISQ_CODE,MILEAGE,LOCATION,USER_EDTQ,STATUS,NOTES,NO_ATTENDANCES,IS_ACTIVE,NO_DEF_POS,NO_ATTENDED,NO_FTA,NO_AWOL,POOL_SEQ,EDIT_TAG,POOL_TYPE,LOC_CODE,NEXT_DATE,ON_CALL,PERM_DISQUAL,PAY_COUNTY_EMP,PAY_EXPENSES,SPEC_NEED,SPEC_NEED_MSG,AMT_SPENT,COMPLETION_DATE,SORT_CODE,BANK_ACCT_NAME,BANK_ACCT_NO,BLDG_SOC_ROLL_NO,WAS_DEFERRED,ID_CHECKED,POSTPONE,WELSH,PAID_CASH,TRAVEL_TIME,SCAN_CODE,FINANCIAL_LOSS,POLICE_CHECK,LAST_UPDATE,READ_ONLY,SUMMONS_FILE,REMINDER_SENT,PHOENIX_DATE,PHOENIX_CHECKED,M_PHONE,H_EMAIL,CONTACT_PREFERENCE,NOTIFICATIONS,TRANSFER_DATE,SERVICE_COMP_COMMS_STATUS)" +
					"VALUES ('400','9" + court + "99999','" + court + "222222','99999',NULL,'LNAMEONE','FNAMEONE',NULL,'1 STREET NAME','ANYTOWN',NULL,NULL,NULL,'CH1 2AN',NULL,NULL,NULL,NULL,NULL,NULL,'R',(SELECT SYSDATE FROM DUAL),(SELECT SYSDATE FROM DUAL),'N',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,'Y',NULL,NULL,NULL,NULL,'0001',NULL,'CRO','" + court + "',(SELECT SYSDATE FROM DUAL),NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,(SELECT SYSDATE FROM DUAL),'Y',NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL)");
			pStmt.executeQuery();

			pStmt = conn.prepareStatement("INSERT INTO JUROR.POOL (OWNER,PART_NO,POOL_NO,POLL_NUMBER,TITLE,LNAME,FNAME,DOB,ADDRESS_LINE_1,ADDRESS_LINE_2,ADDRESS_LINE_3,ADDRESS_LINE_4,ADDRESS_LINE_5,POSTCODE,H_PHONE,W_PHONE,W_PH_LOCAL,TIMES_SEL,TRIAL_NO,JUROR_NO,REG_SPC,RET_DATE,DEF_DATE,RESPONDED,DATE_EXCUS,EXC_CODE,ACC_EXC,DATE_DISQ,DISQ_CODE,MILEAGE,LOCATION,USER_EDTQ,STATUS,NOTES,NO_ATTENDANCES,IS_ACTIVE,NO_DEF_POS,NO_ATTENDED,NO_FTA,NO_AWOL,POOL_SEQ,EDIT_TAG,POOL_TYPE,LOC_CODE,NEXT_DATE,ON_CALL,PERM_DISQUAL,PAY_COUNTY_EMP,PAY_EXPENSES,SPEC_NEED,SPEC_NEED_MSG,AMT_SPENT,COMPLETION_FLAG,COMPLETION_DATE,SORT_CODE,BANK_ACCT_NAME,BANK_ACCT_NO,BLDG_SOC_ROLL_NO,WAS_DEFERRED,ID_CHECKED,POSTPONE,WELSH,PAID_CASH,TRAVEL_TIME,SCAN_CODE,FINANCIAL_LOSS,POLICE_CHECK,LAST_UPDATE,READ_ONLY,SUMMONS_FILE,REMINDER_SENT,PHOENIX_DATE,PHOENIX_CHECKED,M_PHONE,H_EMAIL,CONTACT_PREFERENCE,NOTIFICATIONS,TRANSFER_DATE,SERVICE_COMP_COMMS_STATUS)" +
					"VALUES ('400','9" + court + "99998','" + court + "222222','99998',NULL,'LNAMETWO','FNAMETWO',NULL,'2 STREET NAME','ANYTOWN',NULL,NULL,NULL,'CH1 2AN',NULL,NULL,NULL,NULL,NULL,NULL,'R',(SELECT SYSDATE FROM DUAL),(SELECT SYSDATE FROM DUAL),'N',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,'Y',NULL,NULL,NULL,NULL,'0001',NULL,'CRO','" + court + "',(SELECT SYSDATE FROM DUAL),NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,(SELECT SYSDATE FROM DUAL),'Y',NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL)");
			pStmt.executeQuery();

			pStmt = conn.prepareStatement("INSERT INTO JUROR.POOL (OWNER,PART_NO,POOL_NO,POLL_NUMBER,TITLE,LNAME,FNAME,DOB,ADDRESS_LINE_1,ADDRESS_LINE_2,ADDRESS_LINE_3,ADDRESS_LINE_4,ADDRESS_LINE_5,POSTCODE,H_PHONE,W_PHONE,W_PH_LOCAL,TIMES_SEL,TRIAL_NO,JUROR_NO,REG_SPC,RET_DATE,DEF_DATE,RESPONDED,DATE_EXCUS,EXC_CODE,ACC_EXC,DATE_DISQ,DISQ_CODE,MILEAGE,LOCATION,USER_EDTQ,STATUS,NOTES,NO_ATTENDANCES,IS_ACTIVE,NO_DEF_POS,NO_ATTENDED,NO_FTA,NO_AWOL,POOL_SEQ,EDIT_TAG,POOL_TYPE,LOC_CODE,NEXT_DATE,ON_CALL,PERM_DISQUAL,PAY_COUNTY_EMP,PAY_EXPENSES,SPEC_NEED,SPEC_NEED_MSG,AMT_SPENT,COMPLETION_FLAG,COMPLETION_DATE,SORT_CODE,BANK_ACCT_NAME,BANK_ACCT_NO,BLDG_SOC_ROLL_NO,WAS_DEFERRED,ID_CHECKED,POSTPONE,WELSH,PAID_CASH,TRAVEL_TIME,SCAN_CODE,FINANCIAL_LOSS,POLICE_CHECK,LAST_UPDATE,READ_ONLY,SUMMONS_FILE,REMINDER_SENT,PHOENIX_DATE,PHOENIX_CHECKED,M_PHONE,H_EMAIL,CONTACT_PREFERENCE,NOTIFICATIONS,TRANSFER_DATE,SERVICE_COMP_COMMS_STATUS)" +
					"VALUES ('415','9" + court + "99999','" + court + "222222','99999',NULL,'LNAMEONE','FNAMEONE',NULL,'1 STREET NAME','ANYTOWN',NULL,NULL,NULL,'CH1 2AN',NULL,NULL,NULL,NULL,NULL,NULL,'R',(SELECT SYSDATE FROM DUAL),(SELECT SYSDATE FROM DUAL),'N',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,2,NULL,NULL,'Y',NULL,NULL,NULL,NULL,'0001',NULL,'CRO','" + court + "',(SELECT SYSDATE FROM DUAL),NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,(SELECT SYSDATE FROM DUAL),'N',NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL)");
			pStmt.executeQuery();

			pStmt = conn.prepareStatement("INSERT INTO JUROR.POOL (OWNER,PART_NO,POOL_NO,POLL_NUMBER,TITLE,LNAME,FNAME,DOB,ADDRESS_LINE_1,ADDRESS_LINE_2,ADDRESS_LINE_3,ADDRESS_LINE_4,ADDRESS_LINE_5,POSTCODE,H_PHONE,W_PHONE,W_PH_LOCAL,TIMES_SEL,TRIAL_NO,JUROR_NO,REG_SPC,RET_DATE,DEF_DATE,RESPONDED,DATE_EXCUS,EXC_CODE,ACC_EXC,DATE_DISQ,DISQ_CODE,MILEAGE,LOCATION,USER_EDTQ,STATUS,NOTES,NO_ATTENDANCES,IS_ACTIVE,NO_DEF_POS,NO_ATTENDED,NO_FTA,NO_AWOL,POOL_SEQ,EDIT_TAG,POOL_TYPE,LOC_CODE,NEXT_DATE,ON_CALL,PERM_DISQUAL,PAY_COUNTY_EMP,PAY_EXPENSES,SPEC_NEED,SPEC_NEED_MSG,AMT_SPENT,COMPLETION_FLAG,COMPLETION_DATE,SORT_CODE,BANK_ACCT_NAME,BANK_ACCT_NO,BLDG_SOC_ROLL_NO,WAS_DEFERRED,ID_CHECKED,POSTPONE,WELSH,PAID_CASH,TRAVEL_TIME,SCAN_CODE,FINANCIAL_LOSS,POLICE_CHECK,LAST_UPDATE,READ_ONLY,SUMMONS_FILE,REMINDER_SENT,PHOENIX_DATE,PHOENIX_CHECKED,M_PHONE,H_EMAIL,CONTACT_PREFERENCE,NOTIFICATIONS,TRANSFER_DATE,SERVICE_COMP_COMMS_STATUS)" +
					"VALUES ('415','9" + court + "99998','" + court + "222222','99998',NULL,'LNAMETWO','FNAMETWO',NULL,'2 STREET NAME','ANYTOWN',NULL,NULL,NULL,'CH1 2AN',NULL,NULL,NULL,NULL,NULL,NULL,'R',(SELECT SYSDATE FROM DUAL),(SELECT SYSDATE FROM DUAL),'N',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,2,NULL,NULL,'Y',NULL,NULL,NULL,NULL,'0001',NULL,'CRO','" + court + "',(SELECT SYSDATE FROM DUAL),NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,(SELECT SYSDATE FROM DUAL),'N',NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL)");
			pStmt.executeQuery();

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

	public void deletePoolWithDeferral(String poolNo) throws SQLException {
		db = new DBConnection();

		String env_property = System.getProperty("env.database");
		if (env_property != null)
			conn = db.getConnection(env_property);
		else
			conn = db.getConnection("demo");

		try {
			pStmt = conn.prepareStatement("DELETE FROM juror.defer_dbf WHERE part_no in (select part_no from juror.pool where pool_no = '" + poolNo + "')");
			pStmt.executeQuery();

			pStmt = conn.prepareStatement("DELETE FROM juror.pool WHERE part_no = '641555555'");
			pStmt.executeQuery();

			pStmt = conn.prepareStatement("DELETE FROM juror.unique_pool WHERE pool_no = '" + poolNo + "'");
			pStmt.executeQuery();

		} catch (SQLException e) {
			e.printStackTrace();
			log.error("Message:deleted new pool '" + poolNo + "' + e.getMessage()");
		} finally {
			conn.commit();
			pStmt.close();
			conn.close();
		}
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

			pStmt = conn.prepareStatement("INSERT INTO JUROR_mod.JUROR_RESPONSE (JUROR_NUMBER,DATE_RECEIVED,TITLE,FIRST_NAME,LAST_NAME,ADDRESS_LINE_1,ADDRESS_LINE_2,ADDRESS_LINE_3,ADDRESS_LINE_4,ADDRESS_LINE_5,POSTCODE,PROCESSING_STATUS,DATE_OF_BIRTH,PHONE_NUMBER,ALT_PHONE_NUMBER,EMAIL,RESIDENCY,RESIDENCY_DETAIL,MENTAL_HEALTH_ACT,MENTAL_HEALTH_CAPACITY,MENTAL_HEALTH_ACT_DETAILS,BAIL,BAIL_DETAILS,CONVICTIONS,CONVICTIONS_DETAILS,DEFERRAL,DEFERRAL_REASON,DEFERRAL_DATE,REASONABLE_ADJUSTMENTS_ARRANGEMENTS,EXCUSAL,EXCUSAL_REASON,PROCESSING_COMPLETE,SIGNED,version,THIRDPARTY_FNAME,THIRDPARTY_LNAME,RELATIONSHIP,MAIN_PHONE,OTHER_PHONE,EMAIL_ADDRESS,THIRDPARTY_REASON,THIRDPARTY_OTHER_REASON,JUROR_PHONE_DETAILS,JUROR_EMAIL_DETAILS,STAFF_LOGIN,STAFF_ASSIGNMENT_DATE,URGENT,SUPER_URGENT,COMPLETED_AT,WELSH,REPLY_TYPE)"
					+ "VALUES ('" + newJurorRecordNumber + "',CURRENT_DATE-1,null,'FNAMEFIVESIXFIVE','LNAMEFIVESIXFIVE','565 STREET NAME','ANYTOWN',null,'ldsadas',null,'CH1 2AN','TODO',CURRENT_DATE-10000,null,null,null,'Y',null,'N','N',NULL,'N',null,'N',null,null,null,null,null,null,null,'N','N','0',null,null,null,null,null,null,null,null,null,null,'MODTESTBUREAU',null,'N','N',null,'N',null)");
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

	public void insertTwoNewCourtOwnedActivePools(String court) throws SQLException {
		db = new DBConnection();

		String env_property = System.getProperty("env.database");

		if (env_property != null)
			conn = db.getConnection(env_property);
		else
			conn = db.getConnection("demo");

		try {

			pStmt = conn.prepareStatement("INSERT INTO JUROR.UNIQUE_POOL (OWNER,POOL_NO,JURISDICTION_CODE,RETURN_DATE,NEXT_DATE,NO_REQUESTED,POOL_TOTAL,REG_SPC,POOL_TYPE,LOC_CODE,NEW_REQUEST,LAST_UPDATE,READ_ONLY,DEFERRALS_USED,ADDITIONAL_SUMMONS,ATTEND_TIME) " +
					"VALUES ('" + court + "','" + court + "222222',NULL,(SELECT SYSDATE FROM DUAL)+112,(SELECT SYSDATE FROM DUAL)+112,5,0,'R','CRO','" + court + "','N',(SELECT SYSDATE FROM DUAL)+112,'N',NULL,NULL,(SELECT SYSDATE FROM DUAL)+112)");
			pStmt.executeQuery();

			pStmt = conn.prepareStatement("INSERT INTO JUROR.UNIQUE_POOL (OWNER,POOL_NO,JURISDICTION_CODE,RETURN_DATE,NEXT_DATE,NO_REQUESTED,POOL_TOTAL,REG_SPC,POOL_TYPE,LOC_CODE,NEW_REQUEST,LAST_UPDATE,READ_ONLY,DEFERRALS_USED,ADDITIONAL_SUMMONS,ATTEND_TIME) " +
					"VALUES ('400','" + court + "222222',NULL,(SELECT SYSDATE FROM DUAL)+112,(SELECT SYSDATE FROM DUAL)+112,5,0,'R','CRO','" + court + "','N',(SELECT SYSDATE FROM DUAL)+112,'Y',NULL,NULL,(SELECT SYSDATE FROM DUAL)+112)");
			pStmt.executeQuery();


			pStmt = conn.prepareStatement("INSERT INTO JUROR_DIGITAL.POOL_REQUEST_EXT (POOL_NO,TOTAL_NO_REQUIRED,LAST_UPDATE) " +
					"VALUES ('" + court + "222222',5,(SELECT SYSDATE FROM DUAL))");
			pStmt.executeQuery();

			pStmt = conn.prepareStatement("INSERT INTO JUROR.UNIQUE_POOL (OWNER,POOL_NO,JURISDICTION_CODE,RETURN_DATE,NEXT_DATE,NO_REQUESTED,POOL_TOTAL,REG_SPC,POOL_TYPE,LOC_CODE,NEW_REQUEST,LAST_UPDATE,READ_ONLY,DEFERRALS_USED,ADDITIONAL_SUMMONS,ATTEND_TIME) " +
					"VALUES ('" + court + "','" + court + "333333',NULL,(SELECT SYSDATE FROM DUAL)+120,(SELECT SYSDATE FROM DUAL)+120,5,0,'R','CRO','" + court + "','N',(SELECT SYSDATE FROM DUAL)+120,'N',NULL,NULL,(SELECT SYSDATE FROM DUAL)+120)");
			pStmt.executeQuery();

			pStmt = conn.prepareStatement("INSERT INTO JUROR.UNIQUE_POOL (OWNER,POOL_NO,JURISDICTION_CODE,RETURN_DATE,NEXT_DATE,NO_REQUESTED,POOL_TOTAL,REG_SPC,POOL_TYPE,LOC_CODE,NEW_REQUEST,LAST_UPDATE,READ_ONLY,DEFERRALS_USED,ADDITIONAL_SUMMONS,ATTEND_TIME) " +
					"VALUES ('400','" + court + "333333',NULL,(SELECT SYSDATE FROM DUAL)+120,(SELECT SYSDATE FROM DUAL)+120,5,0,'R','CRO','" + court + "','N',(SELECT SYSDATE FROM DUAL)+120,'Y',NULL,NULL,(SELECT SYSDATE FROM DUAL)+120)");
			pStmt.executeQuery();


			pStmt = conn.prepareStatement("INSERT INTO JUROR_DIGITAL.POOL_REQUEST_EXT (POOL_NO,TOTAL_NO_REQUIRED,LAST_UPDATE) " +
					"VALUES ('" + court + "333333',5,(SELECT SYSDATE FROM DUAL))");
			pStmt.executeQuery();

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

	public void insertStraightThroughVoterForCourt(String court) throws SQLException {
		db = new DBConnection();

		String env_property = System.getProperty("env.database");

		if (env_property != null)
			conn = db.getConnection(env_property);
		else
			conn = db.getConnection("demo");

		try {

			pStmt = conn.prepareStatement("INSERT INTO JUROR_DIGITAL.VOTERS (LOC_CODE,PART_NO,REGISTER_LETT,POLL_NUMBER,NEW_MARKER,TITLE,LNAME,FNAME,DOB,FLAGS,ADDRESS_LINE_1,ADDRESS_LINE_2,ADDRESS_LINE_3,ADDRESS_LINE_4,ADDRESS_LINE_5,POSTCODE,DATE_SELECTED1,DATE_SELECTED2,DATE_SELECTED3,REC_NUM,PERM_DISQUAL,SOURCE_ID)"
					+ "VALUES ('" + court + "','6" + court + "88888','88888','88888',NULL,NULL,'LNAMEEIGHTEIGHT','FNAMEEIGHTEIGHT',TIMESTAMP '2000-04-17 00:00:00.000000',NULL,'88 STREET NAME','ANYTOWN',NULL,'SOMETHING',NULL,'SY2 5BL',NULL,NULL,NULL,88888,NULL,NULL)");
			pStmt.executeQuery();

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
			pStmt.executeQuery();

			pStmt = conn.prepareStatement("DELETE FROM juror.pool WHERE loc_code = " + court);
			pStmt.executeQuery();

			pStmt = conn.prepareStatement("DELETE FROM juror.unique_pool WHERE loc_code = " + court);
			pStmt.executeQuery();

			pStmt = conn.prepareStatement("DELETE FROM juror_digital.pool_request_ext WHERE pool_no LIKE '%" + court + "%'");
			pStmt.executeQuery();

		} catch (SQLException e) {
			e.printStackTrace();
			log.error("Message:deleted all pools at court " + court + e.getMessage());
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
			pStmt.executeQuery();

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
			pStmt.executeQuery();

		} catch (SQLException e) {
			e.printStackTrace();
			log.error("Message:updated juror.pool setting " + column + " to '" + oracleWeeksInFuture(weeksInFuture) + "' WHERE part_no = " + jurorNumber + " - " + e.getMessage());
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

			pStmt = conn.prepareStatement("INSERT INTO juror_mod.trial (trial_number,loc_code,description,courtroom,judge,trial_type,trial_start_date,trial_end_date,anonymous,juror_requested,jurors_sent)"
					+ "VALUES ('" + trialNumber + "','415','John Stark',31,1,'CRI','2024-08-28',NULL,true,NULL,NULL)");
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
					+ "VALUES ('" + jurorNumber + "',NOW(),'5224A','THE CROWN COURT AT CHESTER JURY CENTRAL SUMMONING BUREAU THE COURT SERVICE',false,false)");
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
	public void insertInitialSummonsLetter(String jurorNumber) throws SQLException {
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
					+ "VALUES ('" + jurorNumber + "',NOW(),'5221','" + jurorNumber + "          Fname Lname',true,NULL)");
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
	}
