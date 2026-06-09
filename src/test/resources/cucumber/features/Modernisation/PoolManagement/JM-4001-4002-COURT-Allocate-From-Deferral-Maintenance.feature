Feature: JM-4001 and JM-4002 - Court User

  @JurorTransformation
  Scenario Outline: Happy path to allocate one juror to a pool from deferral maintenance as court user

    #needs to stay in single thread pack

    Given I am on "Bureau" "<environment>"
    Given "<number_of_pools>" new pool's are inserted for court "<court>" with owner "<owner>" and a deferral date "<deferral_mondays>" Mondays in the future new schema

    #reset data
    Then juror "<juror_number_1>" has "LAST_NAME" as "<last_name>" new schema
    Then juror "<juror_number_2>" has "LAST_NAME" as "<last_name>" new schema
    Then juror "<juror_number_3>" has "LAST_NAME" as "<last_name>" new schema
    Then juror "<juror_number_1>" has "FIRST_NAME" as "<first_name_1>" new schema
    Then juror "<juror_number_2>" has "FIRST_NAME" as "<first_name_2>" new schema
    Then juror "<juror_number_3>" has "FIRST_NAME" as "<first_name_3>" new schema

    And I log in as "<user>"
    When I navigate to the pool request screen
    And I click on deferral maintenance
    And I see "Deferral maintenance" on the page
    And I set the deferral deferred to filter to "<deferral_mondays>" Mondays in the future
    And I filter on name "<last_name>"
    Then I click the "juror number" column header
    Then The first deferral in the table is "<expected_first_deferral>" with a deferral date "<deferral_mondays>" Mondays in the future
    And Row "3" deferral in the table is "<expected_third_deferral>" with a deferral date "<deferral_mondays>" Mondays in the future

    #select juror deferral to add to active pool
    When I select juror "<juror_number_1>" from the deferrals table
    And I press the "Add to a pool" button
    Then I see "Choose an active pool to add selected jurors to" on the page
    And I select pool "<active_pool>" from the active pools table
    And I press the "Continue" button
    And I see "You cannot postpone a juror without a date of birth - please ensure all selected jurors have a date of birth" on the page
    And I insert dob for juror "<juror_number_1>"
    And I select pool "<active_pool>" from the active pools table
    And I press the "Continue" button
    Then I see "1 juror added to pool <active_pool>" on the page

    Examples:
      | environment | number_of_pools | court | owner | deferral_mondays | juror_number_1 | juror_number_2 | juror_number_3 | last_name | first_name_1 | first_name_2 | first_name_3 | user         | expected_first_deferral            | expected_third_deferral            | active_pool |
      | demo        | 3               | 415   | 415   | 1                | 041500000      | 041500001      | 041500002      | TESTNAME  | 0FNAME0      | 0FNAME1      | 0FNAME2      | MODTESTCOURT | 041500000, 0FNAME0, TESTNAME, 415000000 | 041500002, 0FNAME2, TESTNAME, 415000002 | 415111111   |

  @JurorTransformation
  Scenario Outline: Happy path to allocate multiple juror to a pool from deferral maintenance COURT

    #needs to stay in single thread pack

    Given I am on "Bureau" "<environment>"
    Given "<number_of_pools>" new pool's are inserted for court "<court>" with owner "<owner>" and a deferral date "<deferral_mondays>" Mondays in the future new schema

    #reset data
    Then juror "<juror_number_1>" has "LAST_NAME" as "<last_name>" new schema
    Then juror "<juror_number_2>" has "LAST_NAME" as "<last_name>" new schema
    Then juror "<juror_number_3>" has "LAST_NAME" as "<last_name>" new schema
    Then juror "<juror_number_1>" has "FIRST_NAME" as "<first_name_1>" new schema
    Then juror "<juror_number_2>" has "FIRST_NAME" as "<first_name_2>" new schema
    Then juror "<juror_number_3>" has "FIRST_NAME" as "<first_name_3>" new schema

    And I log in as "<user>"
    When I navigate to the pool request screen
    And I click on deferral maintenance
    And I see "Deferral maintenance" on the page
    And I set the deferral deferred to filter to "<deferral_mondays>" Mondays in the future
    And I filter on name "<last_name>"
    Then I click the "juror number" column header
    Then The first deferral in the table is "<expected_first_deferral>" with a deferral date "<deferral_mondays>" Mondays in the future
    And Row "3" deferral in the table is "<expected_third_deferral>" with a deferral date "<deferral_mondays>" Mondays in the future

    #select juror's deferral to add to active pool
    When I select juror "<juror_number_1>" from the deferrals table
    When I select juror "<juror_number_2>" from the deferrals table
    And I press the "Add to a pool" button
    Then I see "Choose an active pool to add selected jurors to" on the page
    And I select pool "<active_pool>" from the active pools table
    And I press the "Continue" button
    And I see "You cannot postpone a juror without a date of birth - please ensure all selected jurors have a date of birth" on the page
    And I insert dob for juror "<juror_number_1>"
    And I insert dob for juror "<juror_number_2>"
    And I select pool "<active_pool>" from the active pools table
    And I press the "Continue" button
    Then I see "2 jurors added to pool <active_pool>" on the page

    Examples:
      | environment | number_of_pools | court | owner | deferral_mondays | juror_number_1 | juror_number_2 | juror_number_3 | last_name | first_name_1 | first_name_2 | first_name_3 | user         | expected_first_deferral            | expected_third_deferral            | active_pool |
      | demo        | 3               | 415   | 415   | 1                | 041500000      | 041500001      | 041500002      | TESTNAME  | 0FNAME0      | 0FNAME1      | 0FNAME2      | MODTESTCOURT | 041500000, 0FNAME0, TESTNAME, 415000000 | 041500002, 0FNAME2, TESTNAME, 415000002 | 415111111   |

  @JurorTransformation
  Scenario Outline: Test to check sort functionality on deferral maintenance page

    #needs to stay in single thread pack

    Given I am on "Bureau" "<environment>"
    Given "<number_of_pools>" new pool's are inserted for court "<court>" with owner "<owner>" and a deferral date "<deferral_mondays>" Mondays in the future new schema

    #reset data
    Then juror "<juror_number_1>" has "LAST_NAME" as "<last_name>" new schema
    Then juror "<juror_number_2>" has "LAST_NAME" as "<last_name>" new schema
    Then juror "<juror_number_3>" has "LAST_NAME" as "<last_name>" new schema
    Then juror "<juror_number_1>" has "FIRST_NAME" as "<first_name_1>" new schema
    Then juror "<juror_number_2>" has "FIRST_NAME" as "<first_name_2>" new schema
    Then juror "<juror_number_3>" has "FIRST_NAME" as "<first_name_3>" new schema

    And I log in as "<user>"
    When I navigate to the pool request screen
    And I click on deferral maintenance
    And I see "Deferral maintenance" on the page
    And I set the deferral deferred to filter to "<deferral_mondays>" Mondays in the future
    And I filter on name "<last_name>"
    Then I click the "juror number" column header
    Then The first deferral in the table is "<expected_first_deferral>" with a deferral date "<deferral_mondays>" Mondays in the future
    And Row "3" deferral in the table is "<expected_third_deferral>" with a deferral date "<deferral_mondays>" Mondays in the future

    #sort by Juror number (descending)
    Then I click the "juror number" column header
    Then Row "3" from last deferral in the table is "<expected_third_deferral>" with a deferral date "<deferral_mondays>" Mondays in the future
    And The last deferral in the table is "<expected_first_deferral>" with a deferral date "<deferral_mondays>" Mondays in the future
    #sort by First name (ascending)
    Then I click the "first name" column header
    Then The first deferral in the table is "<expected_first_deferral>" with a deferral date "<deferral_mondays>" Mondays in the future
    And Row "3" deferral in the table is "<expected_third_deferral>" with a deferral date "<deferral_mondays>" Mondays in the future
    #sort by First name (descending)
    Then I click the "first name" column header
    Then Row "3" from last deferral in the table is "<expected_third_deferral>" with a deferral date "<deferral_mondays>" Mondays in the future
    And The last deferral in the table is "<expected_first_deferral>" with a deferral date "<deferral_mondays>" Mondays in the future

    #sort by Pool number (ascending)
    Then I click the "pool number" column header
    Then The first deferral in the table is "<expected_first_deferral>" with a deferral date "<deferral_mondays>" Mondays in the future
    And Row "3" deferral in the table is "<expected_third_deferral>" with a deferral date "<deferral_mondays>" Mondays in the future
    #sort by Pool number (descending)
    Then I click the "pool number" column header
    Then Row "3" from last deferral in the table is "<expected_third_deferral>" with a deferral date "<deferral_mondays>" Mondays in the future
    And The last deferral in the table is "<expected_first_deferral>" with a deferral date "<deferral_mondays>" Mondays in the future
    #sort by Deferred to (ascending)
    Then I click the "deferred to" column header
    Then Row "3" from last deferral in the table is "<expected_first_deferral>" with a deferral date "<deferral_mondays>" Mondays in the future
    And The last deferral in the table is "<expected_third_deferral>" with a deferral date "<deferral_mondays>" Mondays in the future
    #sort by Deferred to (descending)
    Then I click the "deferred to" column header
    Then The first deferral in the table is "<expected_first_deferral>" with a deferral date "<deferral_mondays>" Mondays in the future
    And Row "3" deferral in the table is "<expected_third_deferral>" with a deferral date "<deferral_mondays>" Mondays in the future

    #change data
    Then juror "<juror_number_1>" has "LAST_NAME" as "<updated_last_name_1>" new schema
    Then juror "<juror_number_2>" has "LAST_NAME" as "<updated_last_name_2>" new schema
    Then juror "<juror_number_3>" has "LAST_NAME" as "<updated_last_name_3>" new schema
    Then juror "<juror_number_1>" has "FIRST_NAME" as "<updated_first_name>" new schema
    Then juror "<juror_number_2>" has "FIRST_NAME" as "<updated_first_name>" new schema
    Then juror "<juror_number_3>" has "FIRST_NAME" as "<updated_first_name>" new schema

    #refresh def maintenance results set as the data has been updated
    And I click on deferral maintenance

    #clear filter
    And I set the "first name" deferral filter to "<updated_first_name>"

    #sort by Last name (ascending)
    Then I click the "last name" column header
    Then The first deferral in the table is "<updated_expected_first_deferral>" with a deferral date "<deferral_mondays>" Mondays in the future
    And Row "3" deferral in the table is "<updated_expected_third_deferral>" with a deferral date "<deferral_mondays>" Mondays in the future
    #sort by Last name (descending)
    Then I click the "last name" column header
    Then Row "3" from last deferral in the table is "<updated_expected_third_deferral>" with a deferral date "<deferral_mondays>" Mondays in the future
    And The last deferral in the table is "<updated_expected_first_deferral>" with a deferral date "<deferral_mondays>" Mondays in the future

    Examples:
      | environment | number_of_pools | court | owner | deferral_mondays | juror_number_1 | juror_number_2 | juror_number_3 | last_name | first_name_1 | first_name_2 | first_name_3 | user         | expected_first_deferral            | expected_third_deferral            | updated_last_name_1 | updated_last_name_2 | updated_last_name_3 | updated_first_name | updated_expected_first_deferral      | updated_expected_third_deferral      |
      | demo        | 3               | 415   | 415   | 1                | 041500000      | 041500001      | 041500002      | TESTNAME  | 0FNAME0      | 0FNAME1      | 0FNAME2      | MODTESTCOURT | 041500000, 0FNAME0, TESTNAME, 415000000 | 041500002, 0FNAME2, TESTNAME, 415000002 | TESTNAMEA           | TESTNAMEB           | TESTNAMEC           | TESTFNAME          | 041500000, TESTFNAME, TESTNAMEA, 415000000 | 041500002, TESTFNAME, TESTNAMEC, 415000002 |

  @JurorTransformation
  Scenario Outline: Test to check filter functionality on deferral maintenance page

    #needs to stay in single thread pack

    Given I am on "Bureau" "<environment>"
    Given "<number_of_pools>" new pool's are inserted for court "<court>" with owner "<owner>" and a deferral date "<deferral_mondays>" Mondays in the future new schema

    #reset data
    Then juror "<juror_number_1>" has "LAST_NAME" as "<last_name>" new schema
    Then juror "<juror_number_2>" has "LAST_NAME" as "<last_name>" new schema
    Then juror "<juror_number_3>" has "LAST_NAME" as "<last_name>" new schema
    Then juror "<juror_number_1>" has "FIRST_NAME" as "<first_name_1>" new schema
    Then juror "<juror_number_2>" has "FIRST_NAME" as "<first_name_2>" new schema
    Then juror "<juror_number_3>" has "FIRST_NAME" as "<first_name_3>" new schema

    And I log in as "<user>"
    When I navigate to the pool request screen
    And I click on deferral maintenance
    And I see "Deferral maintenance" on the page
    And I set the deferral deferred to filter to "<deferral_mondays>" Mondays in the future
    And I filter on name "<last_name>"
    Then I click the "juror number" column header
    Then The first deferral in the table is "<expected_first_deferral>" with a deferral date "<deferral_mondays>" Mondays in the future
    And Row "3" deferral in the table is "<expected_third_deferral>" with a deferral date "<deferral_mondays>" Mondays in the future

    And I see "Deferral maintenance" on the page

    #apply Juror number filter
    When I set the "juror number" deferral filter to "<juror_number_2>"
    And I see "<juror_number_2>" on the page
    Then The first deferral in the table is "<expected_second_deferral>" with a deferral date "<deferral_mondays>" Mondays in the future
    #apply First name filter
    When I set the "first name" deferral filter to "<first_name_2>"
    And I see "<first_name_2>" on the page
    Then The first deferral in the table is "<expected_second_deferral>" with a deferral date "<deferral_mondays>" Mondays in the future
    #apply Last name filter
    When I set the "last name" deferral filter to "<last_name>"
    And I see "<last_name>" on the page
    Then The first deferral in the table is "<expected_first_deferral>" with a deferral date "<deferral_mondays>" Mondays in the future

    #apply Deferred to filter
    When I set the deferral deferred to filter to "<deferral_mondays>" Mondays in the future
    Then I click the "juror number" column header
    Then The first deferral in the table is "<expected_first_deferral>" with a deferral date "<deferral_mondays>" Mondays in the future
    And Row "3" deferral in the table is "<expected_third_deferral>" with a deferral date "<deferral_mondays>" Mondays in the future

    #apply NON_EXISTENT Juror number filter
    When I set the "juror number" deferral filter to "<non_existent_juror_number>"
    Then I see "There are no results to display" on the page

    Examples:
      | environment | number_of_pools | court | owner | deferral_mondays | juror_number_1 | juror_number_2 | juror_number_3 | last_name | first_name_1 | first_name_2 | first_name_3 | user         | expected_first_deferral            | expected_second_deferral           | expected_third_deferral            | non_existent_juror_number |
      | demo        | 3               | 415   | 415   | 1                | 041500000      | 041500001      | 041500002      | TESTNAME  | 0FNAME0      | 0FNAME1      | 0FNAME2      | MODTESTCOURT | 041500000, 0FNAME0, TESTNAME, 415000000 | 041500001, 0FNAME1, TESTNAME, 415000001 | 041500002, 0FNAME2, TESTNAME, 415000002 | 000000000                 |

  @JurorTransformation
  Scenario Outline: Test to check juror number hyperlink on deferral maintenance page

    #needs to stay in single thread pack

    Given I am on "Bureau" "<environment>"
    Given "<number_of_pools>" new pool's are inserted for court "<court>" with owner "<owner>" and a deferral date "<deferral_mondays>" Mondays in the future new schema

    #reset data
    Then juror "<juror_number_1>" has "LAST_NAME" as "<last_name>" new schema
    Then juror "<juror_number_2>" has "LAST_NAME" as "<last_name>" new schema
    Then juror "<juror_number_3>" has "LAST_NAME" as "<last_name>" new schema
    Then juror "<juror_number_1>" has "FIRST_NAME" as "<first_name_1>" new schema
    Then juror "<juror_number_2>" has "FIRST_NAME" as "<first_name_2>" new schema
    Then juror "<juror_number_3>" has "FIRST_NAME" as "<first_name_3>" new schema

    And I log in as "<user>"
    When I navigate to the pool request screen
    And I click on deferral maintenance
    And I see "Deferral maintenance" on the page
    And I set the deferral deferred to filter to "<deferral_mondays>" Mondays in the future
    And I filter on name "<last_name>"
    Then I click the "juror number" column header
    Then The first deferral in the table is "<expected_first_deferral>" with a deferral date "<deferral_mondays>" Mondays in the future
    And Row "3" deferral in the table is "<expected_third_deferral>" with a deferral date "<deferral_mondays>" Mondays in the future

    #navigate to juror record from juror number hyperlink
    When I click on the "<juror_number_1>" link
    Then I am on the Juror Record for juror "<juror_number_1>"

    Examples:
      | environment | number_of_pools | court | owner | deferral_mondays | juror_number_1 | juror_number_2 | juror_number_3 | last_name | first_name_1 | first_name_2 | first_name_3 | user         | expected_first_deferral            | expected_third_deferral            |
      | demo        | 3               | 415   | 415   | 1                | 041500000      | 041500001      | 041500002      | TESTNAME  | 0FNAME0      | 0FNAME1      | 0FNAME2      | MODTESTCOURT | 041500000, 0FNAME0, TESTNAME, 415000000 | 041500002, 0FNAME2, TESTNAME, 415000002 |
