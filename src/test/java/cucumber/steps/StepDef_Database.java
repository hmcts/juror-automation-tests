package cucumber.steps;

import io.cucumber.datatable.DataTable;
import io.cucumber.java.en.*;
import cucumber.testdata.DatabaseTester;

import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.ZoneId;
import java.util.*;

import static cucumber.steps.StepDef_jurorpool.poolDate;
import static cucumber.steps.StepDef_jurorpool.poolNumber;
import static org.junit.Assert.assertEquals;


public class StepDef_Database {

    private DatabaseTester DBT;


    public StepDef_Database() {
        DBT = new DatabaseTester();
    }

    @Given("^\"([^\"]*)\" exists in \"([^\"]*)\" \"([^\"]*)\" for the \"([^\"]*)\" end$")
    public void column_existsIn(String colName, String database, String table, String frontBackEnd) throws SQLException {
        DBT.column_existsIn(frontBackEnd, database, table, colName);
    }

    @Then("^I see (\\d+) row for \"([^\"]*)\" \"([^\"]*)\" \"([^\"]*)\" where \"([^\"]*)\" is \"([^\"]*)\" and \"([^\"]*)\" is \"([^\"]*)\" and \"([^\"]*)\" is \"([^\"]*)\"$")
    public void row_existsWhereFrontDatabaseTable(
            Integer rowCount,
            String frontBackEnd, String database, String table,
            String colA, String colAParameter,
            String colB, String colBParameter,
            String colC, String colCParameter) throws SQLException {

        DBT.rowsExistIn_Where(
                rowCount,
                frontBackEnd, database, table,
                colA, colAParameter,
                colB, colBParameter,
                colC, colCParameter
        );
    }

    @Then("^I see (\\d+) row for \"([^\"]*)\" \"([^\"]*)\" \"([^\"]*)\" where \"([^\"]*)\" is \"([^\"]*)\" and \"([^\"]*)\" is \"([^\"]*)\" and \"([^\"]*)\" is (\\d+)$")
    public void row_existsWhereFrontDatabaseTable(Integer arg1, String arg2, String arg3, String arg4, String arg5, String arg6, String arg7, String arg8, String arg9, Integer arg10) {

        DBT.rowsExistIn_Where(
                arg1,
                arg2, arg3, arg4,
                arg5, arg6,
                arg7, arg8,
                arg9, arg10
        );
    }

    @Given("^\"([^\"]*)\" table exists within the \"([^\"]*)\" schema$")
    public void table_existsInSchema(String tableName, String schemaName) throws SQLException {
        DBT.tableExistsIn(
                tableName,
                schemaName,
                "back"
        );
    }

    @Then("^\"([^\"]*)\"\\.\"([^\"]*)\" has column \"([^\"]*)\" with \"([^\"]*)\" \"([^\"]*)\"$")
    public void schemaTable_hasColumnWithThat(String schemaName, String tableName, String columnName, String columnLookup, String columnLookupValue) throws SQLException {
        DBT.schemaTable_hasColumnWithThat(
                schemaName,
                tableName,
                columnName,
                columnLookup,
                columnLookupValue
        );
    }

    @Then("^\"([^\"]*)\"\\.\"([^\"]*)\" has constraint type \"([^\\\"]*)\\\" for column \"([^\"]*)\"$")
    public void schemaTable_hasConstraint(String schemaName, String tableName, String constraintType, String columnName) throws SQLException {
        DBT.schemaTable_hasConstraint(
                schemaName,
                tableName,
                constraintType,
                columnName
        );
    }

    ;

    @Given("^\"([^\"]*)\" has \"([^\"]*)\" as \"([^\"]*)\"$")
    public void updateJurorPool_toSetColumn_asValue(String part_no, String columnName, String columnValue) throws SQLException {
        DBT.updateJurorPool_toSetColumn_asValue(part_no, columnName, columnValue);
    }

    ;

    @Given("^pool \"([^\"]*)\" has attendance date as \"([^\"]*)\"$")
    public void updateJurorUniquePool_toSetAttendanceDate_asValue(String pool_no, String columnValue) throws SQLException {
        DBT.updateJurorUniquePool_toSetAttendanceDate(pool_no, columnValue);
    }

    //Danielle update Juror data for Dashboard
    @Given("^\"([^\"]*)\" has \"([^\"]*)\" . \"([^\"]*)\" as \"([^\"]*)\" where \"([^\"]*)\" is \"([^\"]*)\"$")
    public void updateJuror_table_toSetColumn_asValue(String part_no, String table, String columnName, String columnValue, String columnNameA, String columnValueA) throws SQLException {
        DBT.updateJuror_table_toSetColumn_asValue(part_no, table, columnName, columnValue, columnNameA, columnValueA);
    }

    ;

    //Danielle update Juror Digital data for Dashboard
    @Given("^the \"([^\"]*)\" for juror \"([^\"]*)\" is set to \"([^\"]*)\"$")
    public void updateJurorDigital(String column, String part_no, String value) throws SQLException {
        DBT.updateJurorDigital(column, part_no, value);
    }

    //Danielle insert an RSUM row for dashboard test
    @Given("^an RSUM row is generated for juror \"([^\"]*)\" in pool \"([^\"]*)\"$")
    public void insertRSUMRow(String part_no, String pool_no) throws SQLException {
        DBT.insertRSUMRow(part_no, pool_no);
    }

    ;

    @Given("^an RESP row is generated for juror \"([^\"]*)\" in pool \"([^\"]*)\"$")
    public void insertRESPRow(String part_no, String pool_no) throws SQLException {
        DBT.insertRESPRow(part_no, pool_no);
    }

    ;

    @Given("^an PUND row is generated for juror \"([^\"]*)\" in pool \"([^\"]*)\"$")
    public void insertPUNDRow(String part_no, String pool_no) throws SQLException {
        DBT.insertPUNDRow(part_no, pool_no);
    }

    ;

    @Given("^juror has data set$")
    public void updateJurorPool_byDataTAble(DataTable arg1) throws SQLException {
        List<Map<String, String>> list = arg1.asMaps(String.class, String.class);
        Set<String> columnNames = list.get(0).keySet();

        for (int i = 0; i < list.size(); i++) {
            String part_no = list.get(i).get("part_no");
            String columnValue = null;
            for (String columnName : columnNames) {
                if (!columnName.equalsIgnoreCase("part_no")) {
                    columnValue = list.get(i).get(columnName);
                    updateJurorPool_toSetColumn_asValue(
                            part_no,
                            columnName,
                            columnValue
                    );
                }
            }
        }
    }

    @Then("^on \"([^\"]*)\" \\. \"([^\"]*)\" I see \"([^\"]*)\" is \"([^\"]*)\" where \"([^\"]*)\" is \"([^\"]*)\"$")
    public void onDatabaseTable_seeColWithColValue_whereColColvalue(
            String database, String databaseTable,
            String expectedColumn, String expectedColumnValue,
            String whereColumn, String whereColumnValue) throws SQLException {

        DBT.onDatabaseTable_seeColWithColValue_whereColColvalue(
                "demo",
                database, databaseTable,
                expectedColumn, expectedColumnValue,
                whereColumn, whereColumnValue
        );
    }

    @Then("^I check that a \"([^\"]*)\" letter has been generated$")
    public void requestInfoLetterGenerated(String jurorPartNo) throws SQLException {
        StepDef_jurorpool.jurorPartNumber.set(jurorPartNo);

        DBT.requestInfoLetterGenerated(jurorPartNo);
    }

    @Then("^on \"([^\"]*)\" \\. \"([^\"]*)\" I see \"([^\"]*)\" is \"([^\"]*)\" where \"([^\"]*)\" is \"([^\"]*)\" and \"([^\"]*)\" is \"([^\"]*)\"$")
    public void onDatabaseTable_seeColWithColValue_whereColColvalue
            (String database, String databaseTable,
             String expectedColumn, String expectedColumnValue,
             String whereColumn, String whereColumnValue,
             String whereColumnB, String whereColumnValueB) throws SQLException {

        DBT.onDatabaseTable_seeColWithColValue_whereColColvalue(
                "demo",
                database, databaseTable,
                expectedColumn, expectedColumnValue,
                whereColumn, whereColumnValue,
                whereColumnB, whereColumnValueB
        );
    }

    @Then("^on \"([^\"]*)\" \\. \"([^\"]*)\" I see \"([^\"]*)\" is null where \"([^\"]*)\" is \"([^\"]*)\" and \"([^\"]*)\" is \"([^\"]*)\"$")
    public void onDatabaseTable_seeColWithColValue_whereColColvalue_whereColColValue(
            String database, String databaseTable,
            String expectedColumn, // String expectedColumnValue,
            String whereColumn, String whereColumnValue,
            String whereColumnTwo, String whereColumnValueTwo) throws SQLException {

        DBT.rowsExistIn_Where(
                1,
                "demo",
                database,
                databaseTable,
                expectedColumn,
                "NULL",
                whereColumn,
                whereColumnValue,
                whereColumnTwo,
                whereColumnValueTwo
        );
    }

    @Then("^on \"([^\"]*)\" \\. \"([^\"]*)\" I see \"([^\"]*)\" is null where \"([^\"]*)\" is \"([^\"]*)\"$")
    public void onDatabaseTable_seeColWithColValue_whereColColvalue(
            String database, String databaseTable,
            String expectedNullColumn,
            String whereColumn, String whereColumnValue) throws SQLException {

        DBT.onDatabaseTable_seeColIsNull_whereColColvalue(
                "demo",
                database, databaseTable,
                expectedNullColumn, //, expectedColumnValue,
                whereColumn, whereColumnValue
        );
    }

    @Given("^staff with name \"([^\"]*)\" does not exist$")
    public void staffWithName_doesNotExist(String staffName) throws SQLException {
        DBT.staffWithName_doesNotExist(staffName);
    }

    @Given("^pool no \"([^\"]*)\" is reset to pending allocation$")
    public void resetPooltoPendingAllocation(String pool_no) throws SQLException {
        DBT.resetPooltoPendingAllocation(pool_no);
    }

    //cleans dashboard tables
    @Given("^the dashboard tables have been cleared")
    public void cleanDashboard() throws SQLException {
        DBT.clean_dashboard();
    }

    @Given("^the juror numbers have not been processed$")
    public void resetJurorDetails(DataTable arg1) throws SQLException {
        List<Map<String, String>> list = arg1.asMaps(String.class, String.class);
        for (int i = 0; i < list.size(); i++) {
            String part_no = list.get(i).get("part_no");
            String pool_no = list.get(i).get("pool_no");
            String owner = list.get(i).get("owner");

            DBT.clean_juror_digital(part_no);
            DBT.clean_juror(part_no, pool_no, owner);
            DBT.clean_jurorTablesPreSetList(part_no, pool_no, owner);
            DBT.deleteConfLettRow(part_no);
            DBT.deleteDeferralLettRow(part_no);
            DBT.deleteExcusalLettRow(part_no);
			/*
			DBT.clean_jurorTable_wherePartNoOwner("part_his", part_no, owner);
			DBT.clean_jurorTable_wherePartNoOwner("confirm_lett", part_no, owner);
			DBT.clean_jurorTable_wherePartNoOwner("defer_dbf", part_no, owner);
			DBT.clean_jurorTable_wherePartNoOwner("def_lett", part_no, owner);
			DBT.clean_jurorTable_wherePartNoOwner("def_denied", part_no, owner);
			DBT.clean_jurorTable_wherePartNoOwner("exc_lett", part_no, owner);
			DBT.clean_jurorTable_wherePartNoOwner("exec_denied_lett", part_no, owner);
			DBT.clean_jurorTable_wherePartNoOwner("disq_lett", part_no, owner);
			DBT.clean_jurorTable_wherePartNoOwner("part_amendments", part_no, owner);
			DBT.clean_jurorTable_wherePartNoOwner("phone_log", part_no, owner);
			*/
        }
    }

    @Given("^I have deleted additonal Bureau pool records for juror \"([^\"]*)\" not in pool \"([^\"]*)\"$")
    public void deleteAdditionalBureauRecords(String partNo, String poolNo) throws SQLException {
        DBT.deleteAdditionalBureauRecords(partNo, poolNo);
    }

    @Given("^there is only a bureau copy of the record for juror \"([^\"]*)\"$")
    public void deleteCourtCopyOfRecord(String partNo) throws SQLException {
        DBT.deleteCourtCopyOfRecord(partNo);
    }

    @Given("^auto straight through processing has been disabled$")
    public void straightThroughDisabled() throws SQLException {
        DBT.straightThroughDisabled();
    }

    @Given("^auto straight through processing has been enabled$")
    public void straightThroughEnabled() throws SQLException {
        DBT.straightThroughEnabled();
    }

    @Given("^the date received for the juror response \"([^\"]*)\" is set to (\\d+) working days before the current date$")
    public void dateReceviedFor_setTo_workingDaysBeforeCurrent(String part_no, Integer workingDays) throws SQLException {
        DBT.dateReceviedFor_setTo_workingDaysBeforeCurrent(part_no, workingDays);
    }

    @Given("^\"([^\"]*)\" has court (\\d+) set as \"([^\"]*)\"$")
    public void usernameHasCourt_setAs(String username, int courtPosition, String courtRoom) throws SQLException {
        DBT.usernameHasCourt_setAs(username, courtPosition, courtRoom);
    }

    @Given("^test team is deleted$")
    public void deleteTeam() throws SQLException {
        DBT.deleteTeam();
    }

    @Given("^new pool requests are deleted$")
    public void deleteNewPoolRequests() throws SQLException {
        DBT.deleteNewPoolRequests();
    }

    @Given("^a confirmation letter is generated for juror \"([^\"]*)\"$")
    public void insertConfLettRow(String part_no) throws SQLException {
        DBT.insertConfLettRow(part_no);
    }

    @Given("^a deferral letter is generated for juror \"([^\"]*)\"$")
    public void insertDeferralLettRow(String part_no) throws SQLException {
        DBT.insertDeferralLettRow(part_no);
    }

    @Given("^an excusal letter is generated for juror \"([^\"]*)\"$")
    public void insertExcusalLettRow(String part_no) throws SQLException {
        DBT.insertExcusalLettRow(part_no);
    }

    @Given("^a postponement letter is generated for juror \"([^\"]*)\"$")
    public void insertPostponementLettRow(String part_no) throws SQLException {
        DBT.insertPostponementLettRow(part_no);
    }

    @Given("^a deferral denied letter is generated for juror \"([^\"]*)\"$")
    public void insertDefDeniedLettRow(String part_no) throws SQLException {
        DBT.insertDefDeniedLettRow(part_no);
    }

    @Given("^an excusal denied letter is generated for juror \"([^\"]*)\"$")
    public void insertExcDeniedLettRow(String part_no) throws SQLException {
        DBT.insertDefDeniedLettRow(part_no);
    }

    @Given("^a disqualified letter is generated for juror \"([^\"]*)\"$")
    public void insertDisqualifiedLettRow(String part_no) throws SQLException {
        DBT.insertDisqualifiedLettRow(part_no);
    }


    @Given("^the new pool for court \"([^\"]*)\" is deleted$")
    public void deleteNewPool(String court) throws SQLException {
        DBT.deleteNewPool(court);
    }

    @Given("^the request letter for court \"([^\"]*)\" is deleted$")
    public void deleteRequestLett(String court) throws SQLException {
        DBT.deleteRequestLett(court);
    }

    @Given("^the request letter for part_no \"([^\"]*)\" is deleted$")
    public void deleteRequestLettForPartNo(String part_no) throws SQLException {
        DBT.deleteRequestLettForPartNo(part_no);
    }

    @Given("^a new pool is inserted for court \"([^\"]*)\" with a deferral date \"([^\"]*)\" Mondays in the future$")
    public void insertNewPoolWithDeferral(String court, String noWeeks) throws SQLException {
        String partNumber = "6" + court + "11111";
        StepDef_jurorpool.jurorPartNumber.set(partNumber);
        DBT.insertNewPoolWithDeferral(court, noWeeks);
    }

    @Given("^a new pool is inserted which is owned by the court and includes a deferred juror$")
    public void insertNewPoolWithDeferral(DataTable arg1) throws SQLException {

        List<Map<String, String>> list = arg1.asMaps(String.class, String.class);
        for (int i = 0; i < list.size(); i++) {
            String part_no = list.get(i).get("part_no");
            String pool_no = list.get(i).get("pool_no");
            String owner = list.get(i).get("owner");
            String no_weeks = list.get(i).get("no_weeks");

            StepDef_jurorpool.jurorPartNumber.set(part_no);

            DBT.insertCourtPoolWithDeferral(owner, pool_no, part_no, no_weeks);
        }
    }

    @Given("^a deferral is inserted for an existing juror$")
    public void insertDeferralExistingJuror(DataTable arg1) throws SQLException {

        List<Map<String, String>> list = arg1.asMaps(String.class, String.class);
        for (int i = 0; i < list.size(); i++) {
            String part_no = list.get(i).get("part_no");
            String pool_no = list.get(i).get("pool_no");
            String owner = list.get(i).get("owner");
            String no_weeks = list.get(i).get("no_weeks");
            String loc_code = list.get(i).get("loc_code");
            if (loc_code == null) {
                loc_code = owner;
            }
            StepDef_jurorpool.jurorPartNumber.set(part_no);

            DBT.insertCourtPoolWithDeferralExistingJuror(owner, pool_no, part_no, no_weeks, loc_code);
        }
    }


    @Given("^the juror \"([^\"]*)\" is inserted into pool \"([^\"]*)\" with a deferral date \"([^\"]*)\" Mondays in the future for court \"([^\"]*)\"$")
    public void jurorWithDeferralInsertedIntoPool(String jurorPartNo, String poolNumber, String noWeeks, String court) throws SQLException {
        DBT.insertJurorWithDeferralIntoPool(poolNumber, court, noWeeks, jurorPartNo);
    }

    @Given("^a new completed pool is inserted for court \"([^\"]*)\"$")
    public void insertNewPoolCompleted(String court) throws SQLException {
        String partNumber = "6" + court + "11111";
        StepDef_jurorpool.jurorPartNumber.set(partNumber);
        DBT.insertNewPoolCompletedPool(court);
    }

    @Given("^records for juror \"([^\"]*)\" are deleted$")
    public void deleteNewPoolRecords(String partNo) throws SQLException {
        DBT.deleteNewRecordsForPartNo(partNo);
    }

    @Given("^a new pool is inserted for court \"([^\"]*)\" with part_no \"([^\"]*)\"$")
    public void insertNewPool(String court, String newPartNo) throws SQLException {
        StepDef_jurorpool.jurorPartNumber.set(newPartNo);
        StepDef_jurorpool.summonsReplyNumber = newPartNo;
        DBT.insertNewPoolRecord(court, newPartNo);
    }

    @Given("^a new pool is inserted for court \"([^\"]*)\"$")
    public void insertNewPool(String court) throws SQLException {
        String partNumber = ("6" + court + "22222");
        StepDef_jurorpool.jurorPartNumber.set(partNumber);
        StepDef_jurorpool.summonsReplyNumber = partNumber;
        DBT.insertNewPool(court);
    }

    @Given("^a new pool is inserted for court \"([^\"]*)\" for request letter$")
    public void insertNewPoolRequestLetter(String court) throws SQLException {
        String partNumber = ("6" + court + "99999");
        StepDef_jurorpool.jurorPartNumber.set(partNumber);
        DBT.insertNewPoolRequestLetter(court);
    }


    @Given("^a new pool is inserted for court \"([^\"]*)\" where record has transferred to the court$")
    public void insertNewPoolTransferredToCourt(String court) throws SQLException {
        String partNumber = ("6" + court + "33333");
        StepDef_jurorpool.jurorPartNumber.set(partNumber);
        DBT.insertNewPoolTransferredToCourt(court);
        DBT.insertRSUMRow(partNumber, (court + "222222"));
    }

    @Given("^I have cleared down deferrals for \"([^\"]*)\" weeks in the future for court \"([^\"]*)\"$")
    public void clearDownDeferralsForWeeksInFuture(int weeks, String court) throws SQLException {
        DBT.clearDeferralsForWeeksAndCourt(weeks, court);
    }

    @Given("^a new pool is inserted for where record has transferred to the court$")
    public void insertNewPoolTransferredToCourtNew(DataTable arg1) throws SQLException {
        List<Map<String, String>> list = arg1.asMaps(String.class, String.class);
        for (int i = 0; i < list.size(); i++) {
            String partNumber = list.get(i).get("part_no");
            String poolNumber = list.get(i).get("pool_no");
            String court = list.get(i).get("owner");

            DBT.insertNewPoolTransferredToCourtNew(court, partNumber, poolNumber);
            DBT.insertRSUMRow(partNumber, poolNumber);
        }
    }

    @Given("^paper responses are deleted$")
    public void deletePaperResponses() throws SQLException {
        DBT.deletePaperResponses();
    }

    @Given("^new pool requests with creation date <today have been cleared down$")
    public void clearDownPoolRequests() throws SQLException {
        DBT.clean_pool_requests();

    }

    @Given("^I have cleared down the modernisation staff data$")
    public void cleanModernisationData() throws SQLException {
        DBT.clean_modernisation_data();
    }

    @Given("^I have created the modernisation staff data$")
    public void insertModernisationData() throws SQLException {
        DBT.insert_modernisation_data();
    }

    @Given("^I have run the Launch Darkly create users script$")
    public void runLaunchDarklyHack() throws SQLException {
        DBT.runLaunchDarklyHack();
    }

    @Given("^I delete pools created in the last 3 days$")
    public void cleanPoolsCreatedTesterday() throws SQLException {
        DBT.clean_pools_created_yesterday();
    }

    //@Given("^PCQs has been enabled$")
    //public void pcqEnabled() throws SQLException {
    //    DBT.pcqEnabled();
    //}

    //@Given("^PCQs has been disabled$")
    //public void pcqDisabled() throws SQLException {
    //    DBT.pcqDisabled();
    //}

    @Given("^all \"([^\"]*)\" voters have been reset to unselected state$")
    public void resetVoters(String courtCode) throws SQLException {
        DBT.resetVoters(courtCode);
    }

    @Given("^I refresh the voters table for court \"([^\"]*)\"$")
    public void refreshVoters(String court) throws SQLException {
        DBT.refreshVotersTable(court);
    }

    @Given("^coroners pools older than today have been cleared down$")
    public void clearDownCoronersPoolRequests() throws SQLException {
        DBT.clean_coroners_pool_requests();
    }

    // Need to input Owner in order to work with Bureau and Court accounts
    @Given("^\"([^\"]*)\" new pool's are inserted for court \"([^\"]*)\" with owner \"([^\"]*)\" and a deferral date \"([^\"]*)\" Mondays in the future$")
    public void insertMultipleNewPoolWithDeferral(String pools, String court, String owner, String noWeeks) throws SQLException {
        int noOfPools = Integer.parseInt(pools);
        DBT.insertMultipleNewPoolsWithDeferral(court, noOfPools, owner, noWeeks);
    }


    @Given("^a new pool is inserted for court \"([^\"]*)\" with a deferral date matching the new pool request date$")
    public void insertPoolWithDeferralMatchingNewRequest(String courtCode) throws SQLException {
        DBT.insertNewPoolWithDeferralMatchingNewRequest(courtCode, poolDate.get());
    }

    @Given("^a new pool is inserted for court \"([^\"]*)\" with a deferral date \"([^\"]*)\" weeks in the future$")
    public void insertPoolWithDeferralMatchingNewRequestWeeksInFuture(String courtCode, int weeksInFuture) throws SQLException {
        String datePattern = "EEEE dd MMM yyyy";
        Calendar calendar = Calendar.getInstance();
        calendar.add(Calendar.WEEK_OF_MONTH, weeksInFuture);
        LocalDate localDate = calendar.toInstant().atZone(ZoneId.systemDefault()).toLocalDate();
        Date newDate = Date.from(localDate.atStartOfDay().atZone(ZoneId.systemDefault()).toInstant());
        String newDateValues = new SimpleDateFormat(datePattern).format((newDate).getTime());

        DBT.insertNewPoolWithDeferralMatchingNewRequest(courtCode, newDateValues);
    }

    @Given("^a new active pool is inserted for court \"([^\"]*)\"$")
    public void insertNewActivePool(String court) throws SQLException {
        DBT.insertNewActivePool(court);
    }

    @Given("^two new active pool's are inserted for court \"([^\"]*)\"$")
    public void insertTwoNewActivePools(String court) throws SQLException {
        DBT.insertTwoNewActivePools(court);
    }

    @Given("^two new court owned active pool's are inserted for court \"([^\"]*)\"$")
    public void insertTwoNewCourtOwnedActivePools(String court) throws SQLException {
        DBT.insertTwoNewCourtOwnedActivePools(court);
    }

    @Given("^I delete pool with deferral \"([^\"]*)\"$")
    public void deletePoolWithDeferral(String poolNo) throws SQLException {
        DBT.deletePoolWithDeferral(poolNo);
    }

    @Given("^jurors are inserted into active pool \"([^\"]*)\"$")
    public void insertJurorsIntoActivePool(String court) throws SQLException {
        String partNumber = ("9" + court + "99999");
        StepDef_jurorpool.jurorPartNumber.set(partNumber);
        DBT.insertJurorsIntoActivePool(court);
        DBT.insertRSUMRow(partNumber, (court + "222222"));
    }

    @Given("^court owned jurors are inserted into active pool \"([^\"]*)\"$")
    public void insertCourtOwnedJurorsIntoActivePool(String court) throws SQLException {
        String partNumber = ("9" + court + "99999");
        StepDef_jurorpool.jurorPartNumber.set(partNumber);
        DBT.insertCourtOwnedJurorsIntoActivePool(court);
        DBT.insertRSUMRow(partNumber, (court + "222222"));
    }

    @Given("^the voter record for \"([^\"]*)\" is deleted$")
    public void deleteVoterRecord(String partNo) throws SQLException {
        DBT.deleteVoterRecord(partNo);
    }

    @Given("^a digital summons reply has been entered for the summoned juror \"([^\"]*)\"$")
    public void summonsReplySpecificPool(String jurorNo) throws SQLException {
        DBT.insertSingleDigitalSummonsReply(jurorNo);
    }

    @Given("^voters at court \"([^\"]*)\" have been removed$")
    public void removeVotersAtCourt(String courtNo) throws SQLException {
        DBT.removeVotersAtCourt(courtNo);
    }

    @Given("^a voter has been added that is suitable for straight through summons for court \"([^\"]*)\"$")
    public void addStraightThroughVoterForCourt(String courtNo) throws SQLException {
        String partNumber = ("6" + courtNo + "88888");
        StepDef_jurorpool.jurorPartNumber.set(partNumber);
        DBT.insertStraightThroughVoterForCourt(courtNo);
    }

    @Given("^all pools at court \"([^\"]*)\" have been deleted$")
    public void deleteAllPoolsAtCourt(String courtNo) throws SQLException {
        DBT.deleteAllPoolsAtCourt(courtNo);
    }

    @And("^I set Police Check to \"([^\"]*)\" and Phoenix Checked to \"([^\"]*)\" for \"([^\"]*)\"$")
    public void iSetPoliceCheckToAndPhoenixCheckedToFor(String policeCheck, String phoenixChecked, String jurorRecord) throws SQLException {
        StepDef_jurorpool.jurorPartNumber.set(jurorRecord);
        DBT.updateJurorRecordPolicePhoenixCheck(policeCheck, phoenixChecked, jurorRecord);
    }

    @Given("^I clear down the history for juror record \"([^\"]*)\"$")
    public void clearPartHist(String jurorNumber) throws SQLException {
        DBT.deleteJurorHistory(jurorNumber);
    }

    @Given("^voters for court \"([^\"]*)\" have been updated to postcode \"([^\"]*)\"$")
    public void updateVotersPostcode(String court, String postcode) throws SQLException {
        DBT.updateVotersPostcode(court, postcode);
    }

    @And("^a new juror record \"([^\"]*)\" is inserted into pool \"([^\"]*)\" in court \"([^\"]*)\" which is valid for a digital reply$")
    public void aNewJurorRecordIsInsertedIntoPoolInCourtWhichIsValidForADigitalReply(String jurorRecordNumber, String existingPoolNumber, String court) throws SQLException {
        DBT.insertNewJurorIntoPoolValidForDigitalReply(court, jurorRecordNumber, existingPoolNumber);
        StepDef_jurorpool.jurorPartNumber.set(jurorRecordNumber);
    }

    @And("^a new juror record \"([^\"]*)\" is inserted into pool \"([^\"]*)\" in court \"([^\"]*)\" with the owner matching the court number$")
    public void aNewJurorRecordIsInsertedIntoPoolInCourtWithOwnerSameAsCourt(String jurorRecordNumber, String existingPoolNumber, String court) throws SQLException {
        DBT.insertNewJurorIntoPoolWithOwnerSameAsCourt(court, jurorRecordNumber, existingPoolNumber);
        StepDef_jurorpool.jurorPartNumber.set(jurorRecordNumber);
    }

    @And("^I've set \"([^\"]*)\" to \"([^\"]*)\" week in the future for juror \"([^\"]*)\"$")
    public void iSetToWeekInFutureForJuror(String dbColumn, int weekInFuture, String jurorNumber) throws SQLException {
        DBT.updateJurorSettingDateWeekInFuture(dbColumn, weekInFuture, jurorNumber);
    }

    @And("^the pool created in this test is deleted$")
    public void thePoolIsDeleted() throws SQLException {
        System.out.println("Deleting pool number -- " + poolNumber.get());
        DBT.deletePoolNumber(poolNumber.get());
    }

    @And("^I check optic reference in the database for juror \"([^\"]*)\" is \"([^\"]*)\"$")
    public void opticRefCheck(String partNo, int opticRef) throws SQLException {
        assertEquals(DBT.getOpticReference(partNo), opticRef);
    }

    }