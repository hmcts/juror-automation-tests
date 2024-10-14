Feature: JM-4001 and JM-4002 - Court User

  Background:

    #needs to stay in single thread pack

    Given I am on "Bureau" "ithc"
    Given "3" new pool's are inserted for court "415" with owner "415" and a deferral date "1" Mondays in the future new schema

    #reset data
    Then juror "041500000" has "LAST_NAME" as "TESTNAME" new schema
    Then juror "041500001" has "LAST_NAME" as "TESTNAME" new schema
    Then juror "041500002" has "LAST_NAME" as "TESTNAME" new schema
    Then juror "041500000" has "FIRST_NAME" as "0FNAME0" new schema
    Then juror "041500001" has "FIRST_NAME" as "0FNAME1" new schema
    Then juror "041500002" has "FIRST_NAME" as "0FNAME2" new schema

    And I log in as "MODTESTCOURT"
    When I navigate to the pool request screen
    And I click on deferral maintenance

    And I set the deferral deferred to filter to "1" Mondays in the future
    And I filter on name "TESTNAME"
    Then I click the "juror number" column header
    Then The first deferral in the table is "041500000, 0FNAME0, TESTNAME, 415000000" with a deferral date "1" Mondays in the future
    And Row "3" deferral in the table is "041500002, 0FNAME2, TESTNAME, 415000002" with a deferral date "1" Mondays in the future

  @JurorTransformation
    Scenario: Happy path to allocate one juror to a pool from deferral maintenance as court user

      #needs to stay in single thread pack

      #select juror deferral to add to active pool
      When I select juror "041500000" from the deferrals table
      And I press the "Add to a pool" button
      Then I see "Choose an active pool to add selected jurors to" on the page
      And I select pool "415111111" from the active pools table
      And I press the "Continue" button
      And I see "You cannot postpone a juror without a date of birth - please ensure all selected jurors have a date of birth" on the page
      And I insert dob for juror "041500000"
      And I select pool "415111111" from the active pools table
      And I press the "Continue" button
      Then I see "Selected jurors added to pool 415111111" on the page

  @JurorTransformation
    Scenario: Happy path to allocate multiple juror to a pool from deferral maintenance

      #needs to stay in single thread pack

      #select juror's deferral to add to active pool
      When I select juror "041500000" from the deferrals table
      When I select juror "041500001" from the deferrals table
      And I press the "Add to a pool" button
      Then I see "Choose an active pool to add selected jurors to" on the page
      And I select pool "415111111" from the active pools table
      And I press the "Continue" button
      And I see "You cannot postpone a juror without a date of birth - please ensure all selected jurors have a date of birth" on the page
      And I insert dob for juror "041500000"
      And I insert dob for juror "041500001"
      And I select pool "415111111" from the active pools table
      And I press the "Continue" button
      Then I see "Selected jurors added to pool 415111111" on the page

  @JurorTransformation
    Scenario: Test to check sort functionality on deferral maintenance page

      #needs to stay in single thread pack

      #sort by Juror number (descending)
      Then I click the "juror number" column header
      Then Row "3" from last deferral in the table is "041500002, 0FNAME2, TESTNAME, 415000002" with a deferral date "1" Mondays in the future
      And The last deferral in the table is "041500000, 0FNAME0, TESTNAME, 415000000" with a deferral date "1" Mondays in the future
      #sort by First name (ascending)
      Then I click the "first name" column header
      Then The first deferral in the table is "041500000, 0FNAME0, TESTNAME, 415000000" with a deferral date "1" Mondays in the future
      And Row "3" deferral in the table is "041500002, 0FNAME2, TESTNAME, 415000002" with a deferral date "1" Mondays in the future
      #sort by First name (descending)
      Then I click the "first name" column header
      Then Row "3" from last deferral in the table is "041500002, 0FNAME2, TESTNAME, 415000002" with a deferral date "1" Mondays in the future
      And The last deferral in the table is "041500000, 0FNAME0, TESTNAME, 415000000" with a deferral date "1" Mondays in the future

      #sort by Pool number (ascending)
      Then I click the "pool number" column header
      Then The first deferral in the table is "041500000, 0FNAME0, TESTNAME, 415000000" with a deferral date "1" Mondays in the future
      And Row "3" deferral in the table is "041500002, 0FNAME2, TESTNAME, 415000002" with a deferral date "1" Mondays in the future
      #sort by Pool number (descending)
      Then I click the "pool number" column header
      Then Row "3" from last deferral in the table is "041500002, 0FNAME2, TESTNAME, 415000002" with a deferral date "1" Mondays in the future
      And The last deferral in the table is "041500000, 0FNAME0, TESTNAME, 415000000" with a deferral date "1" Mondays in the future
      #sort by Deferred to (ascending)
      Then I click the "deferred to" column header
      Then Row "3" from last deferral in the table is "041500000, 0FNAME0, TESTNAME, 415000000" with a deferral date "1" Mondays in the future
      And The last deferral in the table is "041500002, 0FNAME2, TESTNAME, 415000002" with a deferral date "1" Mondays in the future
      #sort by Deferred to (descending)
      Then I click the "deferred to" column header
      Then The first deferral in the table is "041500000, 0FNAME0, TESTNAME, 415000000" with a deferral date "1" Mondays in the future
      And Row "3" deferral in the table is "041500002, 0FNAME2, TESTNAME, 415000002" with a deferral date "1" Mondays in the future

      #change data
      Then juror "041500000" has "LAST_NAME" as "TESTNAMEA" new schema
      Then juror "041500001" has "LAST_NAME" as "TESTNAMEB" new schema
      Then juror "041500002" has "LAST_NAME" as "TESTNAMEC" new schema
      Then juror "041500000" has "FIRST_NAME" as "TESTFNAME" new schema
      Then juror "041500001" has "FIRST_NAME" as "TESTFNAME" new schema
      Then juror "041500002" has "FIRST_NAME" as "TESTFNAME" new schema

      #refresh def maintenance results set as the data has been updated
      And I click on deferral maintenance

      #clear filter
      And I set the "first name" deferral filter to "TESTFNAME"

      #sort by Last name (ascending)
      Then I click the "last name" column header
      Then The first deferral in the table is "041500000, TESTFNAME, TESTNAMEA, 415000000" with a deferral date "1" Mondays in the future
      And Row "3" deferral in the table is "041500002, TESTFNAME, TESTNAMEC, 415000002" with a deferral date "1" Mondays in the future
      #sort by Last name (descending)
      Then I click the "last name" column header
      Then Row "3" from last deferral in the table is "041500002, TESTFNAME, TESTNAMEC, 415000002" with a deferral date "1" Mondays in the future
      And The last deferral in the table is "041500000, TESTFNAME, TESTNAMEA, 415000000" with a deferral date "1" Mondays in the future

  @JurorTransformation
    Scenario: Test to check filter functionality on deferral maintenance page

      #needs to stay in single thread pack

      #apply Juror number filter
      And I press the "Hide filter" button
      When I set the "juror number" deferral filter to "041500001"
      Then The first deferral in the table is "041500001, 0FNAME1, TESTNAME, 415000001" with a deferral date "1" Mondays in the future
      #apply First name filter
      When I set the "first name" deferral filter to "0FNAME1"
      Then The first deferral in the table is "041500001, 0FNAME1, TESTNAME, 415000001" with a deferral date "1" Mondays in the future
      #apply Last name filter
      When I set the "last name" deferral filter to "TESTNAME"
      Then The first deferral in the table is "041500000, 0FNAME0, TESTNAME, 415000000" with a deferral date "1" Mondays in the future

      #apply Deferred to filter
      When I set the deferral deferred to filter to "1" Mondays in the future
      Then I click the "juror number" column header
      Then The first deferral in the table is "041500000, 0FNAME0, TESTNAME, 415000000" with a deferral date "1" Mondays in the future
      And Row "3" deferral in the table is "041500002, 0FNAME2, TESTNAME, 415000002" with a deferral date "1" Mondays in the future

      #apply NON_EXISTENT Juror number filter
      Then I press the "Hide filter" button
      When I set the "juror number" deferral filter to "000000000"
      Then I see "There are no results to display" on the page

  @JurorTransformation
    Scenario: Test to check juror number hyperlink on deferral maintenance page

      #needs to stay in single thread pack

      #navigate to juror record from juror number hyperlink
      When I click on the "041500000" link
      Then I am on the Juror Record for juror "041500000"
