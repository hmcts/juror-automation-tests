package cucumber.steps;

import cucumber.testdata.DatabaseTester;
import cucumber.testdata.DatabaseTesterNewSchemaDesign;
import io.cucumber.datatable.DataTable;
import io.cucumber.java.en.And;
import io.cucumber.java.en.Given;
import io.cucumber.java.en.Then;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import static org.junit.jupiter.api.Assertions.assertEquals;


public class StepDef_DatabaseNewSchema {

    private DatabaseTester DBT;
    private DatabaseTesterNewSchemaDesign DBTNSD;


    public StepDef_DatabaseNewSchema() {
        DBT = new DatabaseTester();
        DBTNSD = new DatabaseTesterNewSchemaDesign();
    }

    @Given("^\"([^\"]*)\" has \"([^\"]*)\" as \"([^\"]*)\" new schema$")
    public void updateJurorPool_toSetColumn_asValueNSD(String part_no, String columnName, String columnValue) throws SQLException {
        DBTNSD.updateJurorPool_toSetColumn_asValueNSD(part_no, columnName, columnValue);
    }

    @Given("^\"([^\"]*)\" is not active new schema$")
    public void updateJurorPool_toInactiveNSD(String part_no) throws SQLException {
        DBTNSD.updateJurorPool_toInactiveNSD(part_no);
    }

    @Given("^juror \"([^\"]*)\" has \"([^\"]*)\" as \"([^\"]*)\" new schema$")
    public void updateJuror_JurorPool_toSetColumn_asValueNSD(String part_no, String columnName, String columnValue) throws SQLException {
        DBTNSD.updateJuror_JurorPool_toSetColumn_asValueNSD(part_no, columnName, columnValue);
    }

    @Given("^pool \"([^\"]*)\" has attendance date as \"([^\"]*)\" new schema$")
    public void updateJurorUniquePool_toSetAttendanceDate_asValueNSD(String pool_no, String columnValue) throws SQLException {
        DBTNSD.updateJurorUniquePool_toSetAttendanceDateNSD(pool_no, columnValue);
    }

    @Given("^\"([^\"]*)\" has \"([^\"]*)\" . \"([^\"]*)\" as \"([^\"]*)\" where \"([^\"]*)\" is \"([^\"]*)\" new schema$")
    public void updateJuror_table_toSetColumn_asValueNSD(String part_no, String table, String columnName, String columnValue, String columnNameA, String columnValueA) throws SQLException {
        DBTNSD.updateJuror_table_toSetColumn_asValueNSD(part_no, table, columnName, columnValue, columnNameA, columnValueA);
    }

    //Danielle update Juror Digital data for Dashboard
    @Given("^the \"([^\"]*)\" for juror \"([^\"]*)\" is set to \"([^\"]*)\" new schema$")
    public void updateJurorDigitalNSD(String column, String part_no, String value) throws SQLException {
        DBTNSD.updateJurorDigitalNSD(column, part_no, value);
    }

    @Given("^an RSUM row is generated for juror \"([^\"]*)\" in pool \"([^\"]*)\" new schema$")
    public void insertRSUMRowNSD(String part_no, String pool_no) throws SQLException {
        DBTNSD.insertRSUMRowNSD(part_no, pool_no);
    }

    @Given("^an RESP row is generated for juror \"([^\"]*)\" in pool \"([^\"]*)\" new schema$")
    public void insertRESPRowNSD(String part_no, String pool_no) throws SQLException {
        Integer newId = DBTNSD.getNextIdNSD("juror_mod.juror_history");
        DBTNSD.insertRESPRowNSD(part_no, pool_no, newId);
    }

    @Given("^an PUND row is generated for juror \"([^\"]*)\" in pool \"([^\"]*)\" new schema$")
    public void insertPUNDRowNSD(String part_no, String pool_no) throws SQLException {
        Integer newId = DBTNSD.getNextIdNSD("juror_mod.juror_history");
        DBTNSD.insertPUNDRowNSD(part_no, pool_no, newId);
    }

    //this one errors - need to fix
    @Given("^juror has data set new schema$")
    public void updateJurorPool_byDataTableNSD(DataTable arg1) throws SQLException {
        List<Map<String, String>> list = arg1.asMaps(String.class, String.class);

        for (int i = 0; i < list.size(); i++) {
            String jurorNumber = list.get(i).get("jurorNumber");
            String lastName = list.get(i).get("lastName");
            String zip = list.get(i).get("zip");
            String retDate = list.get(i).get("retDate");
            String nextDate = list.get(i).get("nextDate");

            DBTNSD.updateJurorPool_toSetColumn_asValueNSD(jurorNumber, "ret_date", retDate);
            DBTNSD.updateJurorPool_toSetColumn_asValueNSD(jurorNumber, "next_date", nextDate);
            DBTNSD.updateJuror_toSetColumn_asValueNSD(jurorNumber, "last_name", lastName);
            DBTNSD.updateJuror_toSetColumn_asValueNSD(jurorNumber, "zip", zip);
        }
    }

    @Then("^on \"([^\"]*)\" \\. \"([^\"]*)\" I see \"([^\"]*)\" is \"([^\"]*)\" where \"([^\"]*)\" is \"([^\"]*)\" new schema$")
    public void onDatabaseTable_seeColWithColValue_whereColColvalueNSD(
            String database, String databaseTable,
            String expectedColumn, String expectedColumnValue,
            String whereColumn, String whereColumnValue) throws SQLException {

        DBTNSD.onDatabaseTable_seeColWithColValue_whereColColvalueNSD(
                "demo",
                database, databaseTable,
                expectedColumn, expectedColumnValue,
                whereColumn, whereColumnValue
        );
    }

    @Then("^on \"([^\"]*)\" \\. \"([^\"]*)\" I see \"([^\"]*)\" is null where \"([^\"]*)\" is \"([^\"]*)\" and \"([^\"]*)\" is \"([^\"]*)\" new schema$")
    public void onDatabaseTable_seeColWithColValue_whereColColvalue_whereColColValueNSD(
            String database, String databaseTable,
            String expectedColumn, // String expectedColumnValue,
            String whereColumn, String whereColumnValue,
            String whereColumnTwo, String whereColumnValueTwo) throws SQLException {

        DBTNSD.rowsExistIn_WhereNSD(
                1,
                "demo",
                database,
                databaseTable,
                expectedColumn,
                "NULL",
                whereColumn,
                whereColumnValue,
                whereColumnTwo,
                String.valueOf(Integer.valueOf(whereColumnValueTwo))
        );
    }

    @Then("^on \"([^\"]*)\" \\. \"([^\"]*)\" I see \"([^\"]*)\" is null where \"([^\"]*)\" is \"([^\"]*)\" new schema$")
    public void onDatabaseTable_seeColWithColValue_whereColColvalueNSD(
            String database, String databaseTable,
            String expectedNullColumn,
            String whereColumn, String whereColumnValue) throws SQLException {

        DBTNSD.onDatabaseTable_seeColIsNull_whereColColvalueNSD(
                "demo",
                database, databaseTable,
                expectedNullColumn, //, expectedColumnValue,
                whereColumn, whereColumnValue
        );
    }

    @Given("^staff with name \"([^\"]*)\" does not exist new schema$")
    public void staffWithName_doesNotExistNSD(String staffName) throws SQLException {
        DBTNSD.staffWithName_doesNotExistNSD(staffName);
    }

    @Given("^pool no \"([^\"]*)\" is reset to pending allocation new schema$")
    public void resetPooltoPendingAllocationNSD(String pool_no) throws SQLException {
        DBTNSD.resetPooltoPendingAllocationNSD(pool_no);
    }
//
//    //cleans dashboard tables
//    @Given("^the dashboard tables have been cleared new schema")
//    public void cleanDashboardNSD() throws SQLException {
//        DBTNSD.clean_dashboardNSD();
//    }

    @Given("^juror_pool records are cleared down for \"([^\"]*)\"$")
    public void cleanJurorPoolNSD(String part_no) throws SQLException {
        DBTNSD.clean_juror_pool(part_no);
    }

    @Given("^the juror numbers have not been processed new schema$")
    public void resetJurorDetailsNSD(DataTable arg1) throws SQLException {
        List<Map<String, String>> list = arg1.asMaps(String.class, String.class);
        for (int i = 0; i < list.size(); i++) {
            String part_no = list.get(i).get("part_no");
            String pool_no = list.get(i).get("pool_no");
            String owner = list.get(i).get("owner");

            DBTNSD.clean_juror_digitalNSD(part_no);
            DBTNSD.clean_jurorNSD(part_no, pool_no, owner);
            DBTNSD.clean_jurorTablesPreSetListNSD(part_no, pool_no, owner);
        }
    }

    @Given("^a bureau owned pool is created with jurors")
    public void poolCreatedWithJurors(DataTable arg1) throws SQLException {
        List<Map<String, String>> list = arg1.asMaps(String.class, String.class);
        for (int i = 0; i < list.size(); i++) {
            String court = list.get(i).get("court");
            String juror_number = list.get(i).get("juror_number");
            String pool_number = list.get(i).get("pool_number");
            String noWeeks = list.get(i).get("att_date_weeks_in_future");
            String owner = list.get(i).get("owner");

            DBTNSD.cleanTestDataNSD(pool_number, juror_number);
            DBTNSD.cleanTestDataPoolNSD(pool_number);
            DBTNSD.createPoolNSD(court, noWeeks, owner, pool_number);
            DBTNSD.createJurorsNSD(pool_number, juror_number, noWeeks);
        }
    }

    @Given("^I have inserted court rooms for \"([^\"]*)\"$")
    public void insertCourtroomsNSD(String court) throws SQLException {
        DBTNSD.insertCourtroomsNSD(court);
    }

    @Given("^I have deleted court rooms for \"([^\"]*)\"$")
    public void deleteCourtroomsNSD(String court) throws SQLException {
        DBTNSD.deleteCourtroomsNSD(court);
    }

    @Given("^auto straight through processing has been disabled new schema$")
    public void straightThroughDisabledNSD() throws SQLException {
        DBTNSD.straightThroughDisabledNSD();
    }

    @Given("^auto straight through processing has been enabled new schema$")
    public void straightThroughEnabledNSD() throws SQLException {
        DBTNSD.straightThroughEnabledNSD();
    }

    @Given("^the date received for the juror response \"([^\"]*)\" is set to (\\d+) working days before the current date new schema$")
    public void dateReceviedFor_setTo_workingDaysBeforeCurrentNSD(String part_no, Integer workingDays) throws SQLException {
        DBTNSD.dateReceviedFor_setTo_workingDaysBeforeCurrentNSD(part_no, workingDays);
    }

    //    @Given("^\"([^\"]*)\" has court (\\d+) set as \"([^\"]*)\" new schema$")
//    public void usernameHasCourt_setAs(String username, int courtPosition, String courtRoom) throws SQLException {
//        DBTNSD.usernameHasCourt_setAsNSD(username, courtPosition, courtRoom);
//    }
//
//    @Given("^test team is deleted$")
//    public void deleteTeamNSD() throws SQLException {
//        DBT.deleteTeam();
//    }
//
    @Given("^new pool requests are deleted new schema$")
    public void deleteNewPoolRequestsNSD() throws SQLException {
        DBTNSD.deleteNewPoolRequestsNSD();
    }

    //
//
//    @Then("^I check that a \"([^\"]*)\" letter has been generated$")
//    public void requestInfoLetterGeneratedNSD(String jurorPartNo) throws SQLException {
//        StepDef_jurorpool.jurorPartNumber.set(jurorPartNo);
//
//        DBT.requestInfoLetterGenerated(jurorPartNo);
//    }
//
//    @Given("^a confirmation letter is generated for juror \"([^\"]*)\"$")
//    public void insertConfLettRowNSD(String part_no) throws SQLException {
//        DBT.insertConfLettRow(part_no);
//    }
//
//    @Given("^a deferral letter is generated for juror \"([^\"]*)\"$")
//    public void insertDeferralLettRowNSD(String part_no) throws SQLException {
//        DBT.insertDeferralLettRow(part_no);
//    }
//
//    @Given("^an excusal letter is generated for juror \"([^\"]*)\"$")
//    public void insertExcusalLettRowNSD(String part_no) throws SQLException {
//        DBT.insertExcusalLettRow(part_no);
//    }
//
//    @Given("^a postponement letter is generated for juror \"([^\"]*)\"$")
//    public void insertPostponementLettRowNSD(String part_no) throws SQLException {
//        DBT.insertPostponementLettRow(part_no);
//    }
//
//    @Given("^a deferral denied letter is generated for juror \"([^\"]*)\"$")
//    public void insertDefDeniedLettRowNSD(String part_no) throws SQLException {
//        DBT.insertDefDeniedLettRow(part_no);
//    }
//
//    @Given("^an excusal denied letter is generated for juror \"([^\"]*)\"$")
//    public void insertExcDeniedLettRowNSD(String part_no) throws SQLException {
//        DBT.insertDefDeniedLettRow(part_no);
//    }
//
//    @Given("^a disqualified letter is generated for juror \"([^\"]*)\"$")
//    public void insertDisqualifiedLettRowNSD(String part_no) throws SQLException {
//        DBT.insertDisqualifiedLettRow(part_no);
//    }
//
//
    @Given("^the new pool for court \"([^\"]*)\" is deleted new schema$")
    public void deleteNewPoolNSD(String court) throws SQLException {
        DBTNSD.deleteNewPoolNSD(court);
    }

    @Given("^the new pool for court \"([^\"]*)\" with multiple statuses is deleted new schema$")
    public void deleteNewPoolMultiStatusNSD(String court) throws SQLException {
        DBTNSD.deleteNewPoolMultiStatusNSD(court);
    }

    //
//    @Given("^the request letter for court \"([^\"]*)\" is deleted$")
//    public void deleteRequestLettNSD(String court) throws SQLException {
//        DBT.deleteRequestLett(court);
//    }
//
//    @Given("^the request letter for part_no \"([^\"]*)\" is deleted$")
//    public void deleteRequestLettForPartNoNSD(String part_no) throws SQLException {
//        DBT.deleteRequestLettForPartNo(part_no);
//    }
//
    @Given("^a new pool is inserted for court \"([^\"]*)\" with a deferral date \"([^\"]*)\" Mondays in the future new schema$")
    public void insertNewPoolWithDeferralNSD(String court, String noWeeks) throws SQLException {
        String partNumber = "6" + court + "11111";
        StepDef_jurorpool.jurorPartNumber.set(partNumber);
        DBTNSD.insertNewPoolWithDeferralNSD(court, noWeeks);
    }

    @Given("^a new pool is inserted which is owned by the court and includes a deferred juror new schema$")
    public void insertNewPoolWithDeferralNSD(DataTable arg1) throws SQLException {

        List<Map<String, String>> list = arg1.asMaps(String.class, String.class);
        for (int i = 0; i < list.size(); i++) {
            String part_no = list.get(i).get("part_no");
            String pool_no = list.get(i).get("pool_no");
            String owner = list.get(i).get("owner");
            String no_weeks = list.get(i).get("no_weeks");

            StepDef_jurorpool.jurorPartNumber.set(part_no);

            DBTNSD.insertCourtPoolWithDeferralNSD(owner, pool_no, part_no, no_weeks);
        }
    }

    @Given("^a deferral is inserted for an existing juror new schema$")
    public void insertDeferralExistingJurorNSD(DataTable arg1) throws SQLException {

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

            DBTNSD.insertCourtPoolWithDeferralExistingJurorNSD(owner, pool_no, part_no, no_weeks, loc_code);
        }
    }

    @Given("^the juror \"([^\"]*)\" is inserted into pool \"([^\"]*)\" with a deferral date \"([^\"]*)\" Mondays in the future for court \"([^\"]*)\" new schema$")
    public void jurorWithDeferralInsertedIntoPoolNSD(String jurorPartNo, String poolNumber, String noWeeks, String court) throws SQLException {
        DBTNSD.insertJurorWithDeferralIntoPoolNSD(poolNumber, court, noWeeks, jurorPartNo);
    }

    @Given("^a new completed pool is inserted for court \"([^\"]*)\" new schema$")
    public void insertNewPoolCompletedNSD(String court) throws SQLException {
        String partNumber = "6" + court + "11111";
        StepDef_jurorpool.jurorPartNumber.set(partNumber);
        DBTNSD.insertNewPoolCompletedPoolNSD(court);
    }

    @Given("^records for juror \"([^\"]*)\" are deleted new schema$")
    public void deleteNewPoolRecordsNSD(String partNo) throws SQLException {
        DBTNSD.deleteNewRecordsForPartNoNSD(partNo);
    }

    @Given("^a new pool is inserted for court \"([^\"]*)\" new schema$")
    public void insertNewPool(String court) throws SQLException {
        String partNumber = ("6" + court + "22222");
        StepDef_jurorpool.jurorPartNumber.set(partNumber);
        StepDef_jurorpool.summonsReplyNumber = partNumber;
        DBTNSD.insertNewPoolNSD(court);
    }

    @Given("^I have cleared down deferrals for \"([^\"]*)\" weeks in the future for court \"([^\"]*)\" new schema$")
    public void clearDownDeferralsForWeeksInFutureNSD(int weeks, String court) throws SQLException {
        DBTNSD.clearDeferralsForWeeksAndCourtNSD(weeks, court);
    }

    @Given("^a new pool is inserted for where record has transferred to the court new schema$")
    public void insertNewPoolTransferredToCourtNewNSD(DataTable arg1) throws SQLException {
        List<Map<String, String>> list = arg1.asMaps(String.class, String.class);
        for (int i = 0; i < list.size(); i++) {
            String partNumber = list.get(i).get("part_no");
            String poolNumber = list.get(i).get("pool_no");
            String court = list.get(i).get("owner");

            DBTNSD.insertNewPoolTransferredToCourtNewNSD(court, partNumber, poolNumber);
            DBTNSD.insertRSUMRowNSD(partNumber, poolNumber);
        }
    }

    @Given("^paper responses are deleted new schema$")
    public void deletePaperResponsesNSD() throws SQLException {
        DBTNSD.deletePaperResponsesNSD();
    }

    @Given("^new pool requests with creation date <today have been cleared down new schema$")
    public void clearDownPoolRequestsNSD() throws SQLException {
        DBTNSD.clean_pool_requestsNSD();

    }

    @Given("^I have cleared down the modernisation staff data new schema$")
    public void cleanModernisationDataNSD() throws SQLException {
        DBTNSD.clean_modernisation_dataNSD();
    }

    @Given("^I have created the modernisation staff data new schema$")
    public void insertModernisationDataNSD() throws SQLException {
        DBT.insert_modernisation_data();
    }

    @Given("^I populate the court catchment area table$")
    public void populateCourtCatchmentAreaNSD() throws SQLException {
        DBTNSD.populateCourtCatchmentAreaTable();
    }

    @Given("^I populate the courtroom table$")
    public void populateCourtroomNSD() throws SQLException {
        DBTNSD.populateCourtroomTable();
    }

    @Given("^I populate the judge table$")
    public void populateJudgeNSD() throws SQLException {
        DBTNSD.populateJudgeTable();
    }

    @Given("^I delete pools created in the last 3 days new schema for court \"([^\"]*)\"$")
    public void cleanPoolsCreatedTesterdayNSD(String courtCode) throws SQLException {
        DBTNSD.clean_pools_created_yesterdayNSD(courtCode);
    }

    @Given("^I delete trials data$")
    public void cleanTrialsNSD() throws SQLException {
        DBTNSD.cleanTrialsNSD();
    }

    @Given("^I delete appearances data$")
    public void cleanAppearancesNSD() throws SQLException {
        DBTNSD.cleanAppearancesNSD();
    }

    //
//    @Given("^PCQs has been enabled new schema$")
//    public void pcqEnabledNSD() throws SQLException {
//        DBTNSD.pcqEnabledNSD();
//    }
//
//    @Given("^PCQs has been disabled$")
//    public void pcqDisabledNSD() throws SQLException {
//        DBT.pcqDisabled();
//    }
//
    @Given("^all \"([^\"]*)\" voters have been reset to unselected state new schema$")
    public void resetVotersNSD(String courtCode) throws SQLException {
        DBTNSD.resetVotersNSD(courtCode);
    }

    @Given("^I refresh the voters table for court \"([^\"]*)\" new schema$")
    public void refreshVotersNSD(String court) throws SQLException {
        DBTNSD.refreshVotersTableNSD(court);
    }

    @Given("^coroners pools older than today have been cleared down new schema$")
    public void clearDownCoronersPoolRequestsNSD() throws SQLException {
        DBTNSD.clean_coroners_pool_requestsNSD();
    }

    // Need to input Owner in order to work with Bureau and Court accounts
    @Given("^\"([^\"]*)\" new pool's are inserted for court \"([^\"]*)\" with owner \"([^\"]*)\" and a deferral date \"([^\"]*)\" Mondays in the future new schema$")
    public void insertMultipleNewPoolWithDeferralNSD(String pools, String court, String owner, String noWeeks) throws SQLException {
        int noOfPools = Integer.parseInt(pools);
        DBTNSD.insertMultipleNewPoolsWithDeferralNSD(court, noOfPools, owner, noWeeks);
    }

    @Given("^a new pool with \"([^\"]*)\" responded jurors is inserted for court \"([^\"]*)\" with owner \"([^\"]*)\" and attendance date of today new schema$")
    public void insertPoolWithRespondedJurorsNSD(String no_jurors, String court, String owner) throws SQLException {
        int noOfJurors = Integer.parseInt(no_jurors);
        DBTNSD.inserPoolWithRespondedJurorsNSD(noOfJurors, court, owner);
    }

    @Given("^I Confirm all the data in the record attendance table is cleared$")
    public void iVerifyRecordAttendanceTableCleared() throws SQLException {
        DBTNSD.clearAllJurorsinAttendabceTable();
    }

    @Given("^a new active pool is inserted for court \"([^\"]*)\" new schema$")
    public void insertNewActivePoolNSD(String court) throws SQLException {
        DBTNSD.insertNewActivePoolNSD(court);
    }

    @Given("^a new active pool is inserted for court \"([^\"]*)\" with multi statuses new schema$")
    public void insertNewActivePoolMultiStatusNSD(String court) throws SQLException {
        DBTNSD.insertNewActivePoolMultiStatusNSD(court);
    }

    @Given("^two new active pool's are inserted for court \"([^\"]*)\" new schema$")
    public void insertTwoNewActivePoolsNSD(String court) throws SQLException {
        DBTNSD.insertTwoNewActivePoolsNSD(court);
    }

    @Given("^jurors are inserted into active pool \"([^\"]*)\" new schema$")
    public void insertJurorsIntoActivePoolNSD(String court) throws SQLException {
        String partNumber = ("9" + court + "99999");
        StepDef_jurorpool.jurorPartNumber.set(partNumber);
        DBTNSD.insertJurorsIntoActivePoolNSD(court);
        DBTNSD.insertRSUMRowNSD(partNumber, (court + "222222"));
    }

    @Given("^jurors are inserted into active pool \"([^\"]*)\" with multi statuses new schema$")
    public void insertJurorsIntoActivePoolMultiStatusNSD(String court) throws SQLException {
        String partNumber = ("9" + court + "99999");
        StepDef_jurorpool.jurorPartNumber.set(partNumber);
        DBTNSD.insertJurorsIntoActivePoolMultiStatusNSD(court);
    }

    @Given("^the voter record for \"([^\"]*)\" is deleted new schema$")
    public void deleteVoterRecordNSD(String partNo) throws SQLException {
        DBTNSD.deleteVoterRecordNSD(partNo);
    }


    @Given("^a digital summons reply has been entered for the summoned juror \"([^\"]*)\" new schema$")
    public void summonsReplySpecificPoolNSD(String jurorNo) throws SQLException {
        DBTNSD.insertSingleDigitalSummonsReplyNSD(jurorNo);
    }

    @And("^I set Police Check to \"([^\"]*)\" for \"([^\"]*)\" new schema$")
    public void iSetPoliceCheckToAndPhoenixCheckedToForNSD(String policeCheck, String jurorRecord) throws SQLException {
        StepDef_jurorpool.jurorPartNumber.set(jurorRecord);
        DBTNSD.updateJurorRecordPolicePhoenixCheckNSD(policeCheck, jurorRecord);
    }

    @Given("^voters for court \"([^\"]*)\" have been updated to postcode \"([^\"]*)\" new schema$")
    public void updateVotersPostcodeNSD(String court, String postcode) throws SQLException {
        DBTNSD.updateVotersPostcodeNSD(court, postcode);
    }


    @And("^the pool created in this test is deleted new schema$")
    public void thePoolIsDeletedNSD() throws SQLException {
        System.out.println("Deleting pool number -- " + StepDef_jurorpool.poolNumber.get());
        DBTNSD.deletePoolNumberNSD(StepDef_jurorpool.poolNumber.get());
    }

    @And("^I check optic reference in the database for juror \"([^\"]*)\" is \"([^\"]*)\" new schema$")
    public void opticRefCheckNSD(String partNo, int opticRef) throws SQLException {
        assertEquals(DBTNSD.getOpticReferenceNSD(partNo), opticRef);
    }

    @Given("^a new trial is inserted with the trial number \"([^\"]*)\"$")
    public void insertNewTrialNSD(String trialNumber) throws SQLException {
        DBTNSD.insertNewTrialNSD(trialNumber);
    }

    @Given("^a new protected trial is inserted with the trial number \"([^\"]*)\"$")
    public void insertNewProtectedTrialNSD(String trialNumber) throws SQLException {
        DBTNSD.insertNewProtectedTrialNSD(trialNumber);

    }

    @Given("^I update juror \"([^\"]*)\" to have a status of responded in order to record attendance$")
    public void setJurorAsRespondedForRecordingAttendance(String jurorNumber) throws SQLException {
        DBTNSD.setJurorsStatusAsRespondedNSD(jurorNumber);
    }

    @Given("^I update juror \"([^\"]*)\" to have a have a date of birth which is ineligible for postponement$")
    public void updateJurorDob(String jurorNumber) throws SQLException {
        DBTNSD.setJurorsDobAsIneligible(jurorNumber);
    }

    @Given("^I update juror \"([^\"]*)\" to be able to send a message to them$")
    public void updateJurorToBeAbleToSendMessage(String jurorNumber) throws SQLException {
        DBTNSD.updateJurorToBeAbleToSendMessage(jurorNumber);
    }

    @And("^I see the juror \"([^\"]*)\" has a message in the database$")
    public void jurorMessageNSD(String jurorNumber) throws SQLException {
        DBTNSD.getMessageNSD(jurorNumber);
    }

    @Given("^I update juror \"([^\"]*)\" to have a status of Panel in order to record attendance$")
    public void setJurorAsPanelForRecordingAttendance(String jurorNumber) throws SQLException {
        DBTNSD.setJurorsStatusAsPanelNSD(jurorNumber);
    }

    @Given("^I clear messages for juror \"([^\"]*)\"$")
    public void clearMessagesForJuror(String jurorNumber) throws SQLException {
        DBTNSD.clearMessagesForJuror(jurorNumber);
    }

    @Given("^I update juror \"([^\"]*)\" to have a status of \"([^\"]*)\"$")
    public void setJurorStatus(String jurorNumber, String statusName) throws SQLException {
        int statusNumber = DBTNSD.getStatusNumber(statusName);
        DBTNSD.setJurorStatus(jurorNumber, Integer.toString(statusNumber));
    }

    @Given("^I update juror \"([^\"]*)\" to change the status of printed in order to resend letter$")
    public void setJurorAsPrinted(String jurorNumber) throws SQLException {
        DBTNSD.setJurorsStatusAsPrintedforResendDeferralLetter(jurorNumber);
    }

    @Given("^a confirmation letter inserted for juror \"([^\"]*)\"$")
    public void insertConfirmationLetterPlaceholder(String jurorNumber) throws SQLException {
        DBTNSD.insertConfirmationLetter(jurorNumber);
    }

    @Given("^I print all letters within the pool \"([^\"]*)\" for the initial summons letter$")
    public void updatePendingLetterForInitialSummons(String poolNumber) throws SQLException {
        DBTNSD.updatePendingLetterForInitialSummons(poolNumber);
    }

    @Given("^I delete all letters within the pool \"([^\"]*)\" for the letter$")
    public void deletePendingLettersForInitialSummons(String pool) throws SQLException {
        DBTNSD.deletePendingLettersForInitialSummons(pool);

    }

    @Given("^I clear down the bulk print data table for Juror \"([^\"]*)\"$")
    public void deleteBulkdatajuror(String createdJurorRecordNumber) throws SQLException {
        DBT.deleteBulkDataJuror(createdJurorRecordNumber);

    }

    @Then("^I update the bureau transfer date of the juror \"([^\"]*)\"$")
    public void updatebureautransferDateofCourtUser(String jurorNumber) throws SQLException {
        DBTNSD.updateBureauTransferDate(jurorNumber);
    }
    @Given("^I update daily expense amounts entered are more than court’s suggested daily limits$")
    public void setDailyExpensePubicTrasportAndTaxi() throws SQLException {
        DBTNSD.setExpenseDailyTransportLimit();
    }

    @Given("^I update the appearance of juror \"([^\"]*)\" for show cause letter$")
    public void updateAppearanceForShowCauseLetter(String jurorNumber) throws SQLException {
        DBTNSD.updateAppearanceForShowCause(jurorNumber);
    }
    @Given("^I update juror \"([^\"]*)\" to have confirm attendance date as todays date$")
    public void setJurorattendanceDateAsTodaysDate(String jurorNumber) throws SQLException {
        DBTNSD.setJurorsAttendanceDate(jurorNumber);
    }
    @Given("^I update pool number \"([^\"]*)\" on the appearance table for the \"([^\"]*)\"$")
    public void setPoolNumber(String poolnumber, String jurornumber) throws SQLException {
        DBTNSD.setPoolNumberInAttendanceTable(poolnumber,jurornumber);
    }

    @Given("^I update the appearance of juror \"([^\"]*)\" for show cause letter$")
    public void updateAppearanceForShowCauseLetter(String jurorNumber) throws SQLException {
        DBTNSD.updateAppearanceForShowCause(jurorNumber);
    }

    @Given("^I clear the bank holiday table data in the database$")
    public void clearBankHolidayTableData() throws SQLException {
        DBTNSD.clearBankHolidayTableData();
    }

}
