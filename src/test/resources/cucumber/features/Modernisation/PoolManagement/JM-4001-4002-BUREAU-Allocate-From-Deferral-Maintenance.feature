Feature: JM-4001 and JM-4002 - Bureau User

  Background:

    #needs to stay in single thread pack

    Given I am on "Bureau" "test"
    Given "3" new pool's are inserted for court "415" with owner "400" and a deferral date "1" Mondays in the future new schema

    #reset data
    Then juror "041500000" has "LAST_NAME" as "TESTNAME" new schema
    Then juror "041500001" has "LAST_NAME" as "TESTNAME" new schema
    Then juror "041500002" has "LAST_NAME" as "TESTNAME" new schema
    Then juror "041500000" has "FIRST_NAME" as "0FNAME0" new schema
    Then juror "041500001" has "FIRST_NAME" as "0FNAME1" new schema
    Then juror "041500002" has "FIRST_NAME" as "0FNAME2" new schema

    And I log in as "MODTESTBUREAU"
    When I navigate to the pool request screen
    And I click on deferral maintenance
    Then I see "Enter court name or location code" on the page

    #select court
    When I set input field with "ID" of "courtNameOrLocationCode" to "CHESTER"
    And I click on the "Chester (415)" link
    And I press the "Find" button

    #navigate to the deferral maintenance screen for selected court
    Then I am taken to the deferral maintenance screen for the selected court "Chester (415)"
    And The deferrals table is displayed
    When I set the deferral deferred to filter to "1" Mondays in the future
    And I filter on name "TESTNAME"
    And I press the Juror number table header
    Then The first deferral in the table is "041500000, 0FNAME0, TESTNAME, 415000000" with a deferral date "1" Mondays in the future
    And Row "3" deferral in the table is "041500002, 0FNAME2, TESTNAME, 415000002" with a deferral date "1" Mondays in the future

  @JurorTransformationWIP @JM-5873
    Scenario: Happy path to allocate one juror to a pool from deferral maintenance

    #needs to stay in single thread pack

      #select juror deferral to add to active pool
      When I select juror "041500000" from the deferrals table
      And I press the "Add to a pool" button
      Then I see "Choose an active pool to add selected jurors to" on the page
      And I select pool "415111111" from the active pools table
      And I press the "Continue" button
      Then I see "Selected jurors added to pool 415111111" on the page

  @JurorTransformationWIP @JM-5873
    Scenario: Happy path to allocate multiple juror to a pool from deferral maintenance

    #needs to stay in single thread pack

      #select juror's deferral to add to active pool
      When I select juror "041500000" from the deferrals table
      When I select juror "041500001" from the deferrals table
      And I press the "Add to a pool" button
      Then I see "Choose an active pool to add selected jurors to" on the page
      And I select pool "415111111" from the active pools table
      And I press the "Continue" button
      Then I see "Selected jurors added to pool 415111111" on the page

  @JurorTransformationWIP @JM-5873
    Scenario: Test to change selected court while on deferral maintenance

    #needs to stay in single thread pack

      #select juror deferral to add to active pool
      Given "1" new pool's are inserted for court "416" with owner "400" and a deferral date "1" Mondays in the future
      #select court
      When I set input field with "ID" of "courtNameOrLocationCode" to "CHICHESTER"
      And I click on the "Chichester (416)" link
      And I press the "Find" button
      Then I am taken to the deferral maintenance screen for the selected court "Lewes Sitting At Chichester (416)"
      And The deferrals table is displayed
      When I press the "Juror number" button
      And The first deferral in the table is "041600000, 0FNAME0, TESTNAME, 416000000" with a deferral date "1" Mondays in the future

  @JurorTransformationWIP @JM-5873
    Scenario: Test to check sort functionality on deferral maintenance page

    #needs to stay in single thread pack

      #sort by Juror number (descending)
      When I press the "Juror number" button
      Then Row "3" from last deferral in the table is "041500002, 0FNAME2, TESTNAME, 415000002" with a deferral date "1" Mondays in the future
      And The last deferral in the table is "041500000, 0FNAME0, TESTNAME, 415000000" with a deferral date "1" Mondays in the future
      #sort by First name (ascending)
      When I press the "First name" button
      Then The first deferral in the table is "041500000, 0FNAME0, TESTNAME, 415000000" with a deferral date "1" Mondays in the future
      And Row "3" deferral in the table is "041500002, 0FNAME2, TESTNAME, 415000002" with a deferral date "1" Mondays in the future
      #sort by First name (descending)
      When I press the "First name" button
      Then Row "3" from last deferral in the table is "041500002, 0FNAME2, TESTNAME, 415000002" with a deferral date "1" Mondays in the future
      And The last deferral in the table is "041500000, 0FNAME0, TESTNAME, 415000000" with a deferral date "1" Mondays in the future

      #sort by Pool number (ascending)
      When I press the "Pool number" button
      Then The first deferral in the table is "041500000, 0FNAME0, TESTNAME, 415000000" with a deferral date "1" Mondays in the future
      And Row "3" deferral in the table is "041500002, 0FNAME2, TESTNAME, 415000002" with a deferral date "1" Mondays in the future
      #sort by Pool number (descending)
      When I press the "Pool number" button
      Then Row "3" from last deferral in the table is "041500002, 0FNAME2, TESTNAME, 415000002" with a deferral date "1" Mondays in the future
      And The last deferral in the table is "041500000, 0FNAME0, TESTNAME, 415000000" with a deferral date "1" Mondays in the future
      #sort by Deferred to (ascending)
      When I press the "Deferred to" button

    Then The first deferral in the table is "041500002, 0FNAME2, TESTNAME, 415000002" with a deferral date "1" Mondays in the future
    And Row "3" deferral in the table is "041500000, 0FNAME0, TESTNAME, 415000000" with a deferral date "1" Mondays in the future
      #sort by Deferred to (descending)
      When I press the "Deferred to" button
    Then Row "3" from last deferral in the table is "041500002, 0FNAME2, TESTNAME, 415000002" with a deferral date "1" Mondays in the future
    And The last deferral in the table is "041500000, 0FNAME0, TESTNAME, 415000000" with a deferral date "1" Mondays in the future
      #change data
      Then juror "041500000" has "LNAME" as "TESTNAMEA" new schema
      Then juror "041500001" has "LNAME" as "TESTNAMEB" new schema
      Then juror "041500002" has "LNAME" as "TESTNAMEC" new schema
      Then juror "041500000" has "FNAME" as "TESTFNAME" new schema
      Then juror "041500001" has "FNAME" as "TESTFNAME" new schema
      Then juror "041500002" has "FNAME" as "TESTFNAME" new schema

      #refresh def maintenance results set as the data has been updated
      And I click on deferral maintenance

      #select court
      When I set input field with "ID" of "courtNameOrLocationCode" to "CHESTER"
      And I click on the "Chester (415)" link
      And I press the "Find" button

      When I set the "last name" deferral filter to "TESTNAMEC"
      Then The first deferral in the table is "041500002, TESTFNAME, TESTNAMEC, 415000002" with a deferral date "1" Mondays in the future

      #clear filter
      And I set the "first name" deferral filter to "TESTFNAME"

      #sort by Last name (ascending)
      When I press the "Last name" button
      Then The first deferral in the table is "041500000, TESTFNAME, TESTNAMEA, 415000000" with a deferral date "1" Mondays in the future
      And Row "3" deferral in the table is "041500002, TESTFNAME, TESTNAMEC, 415000002" with a deferral date "1" Mondays in the future
      #sort by Last name (descending)
      When I press the "Last name" button
      Then Row "3" from last deferral in the table is "041500002, TESTFNAME, TESTNAMEC, 415000002" with a deferral date "1" Mondays in the future
      And The last deferral in the table is "041500000, TESTFNAME, TESTNAMEA, 415000000" with a deferral date "1" Mondays in the future

  @JurorTransformationWIP @JM-5873
    Scenario: Test to check filter functionality on deferral maintenance page

    #needs to stay in single thread pack

      #apply Juror number filter
      When I set the "juror number" deferral filter to "041500001"
      Then The first deferral in the table is "041500001, 0FNAME1, TESTNAME, 415000001" with a deferral date "1" Mondays in the future
      #apply First name filter
      When I set the "first name" deferral filter to "0FNAME1"
      Then The first deferral in the table is "041500001, 0FNAME1, TESTNAME, 415000001" with a deferral date "1" Mondays in the future

      #apply Deferred to filter
      When I set the deferral deferred to filter to "1" Mondays in the future
      And I press the "Juror number" button
      Then The first deferral in the table is "041500000, 0FNAME0, TESTNAME, 415000000" with a deferral date "1" Mondays in the future
      And Row "3" deferral in the table is "041500002, 0FNAME2, TESTNAME, 415000002" with a deferral date "1" Mondays in the future

      #apply NON_EXISTENT Juror number filter
      When I set the "juror number" deferral filter to "000000000"
      Then I see "There are no results to display" on the page

  @JurorTransformationWIP @JM-5873
    Scenario: Test to check juror number hyperlink on deferral maintenance page

    #needs to stay in single thread pack

      #navigate to juror record from juror number hyperlink
      When I click on the "041500000" link
      Then I am on the Juror Record for juror "041500000"

  @JurorTransformationWIP @JM-5873
    Scenario: Test to check error for empty court search

    #needs to stay in single thread pack

      #dont select a court and press find button
      And I press the "Find" button
      Then I see "Enter a court name or location code" on the page