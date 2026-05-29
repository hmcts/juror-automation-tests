Feature: JM-4001 and JM-4002 - Bureau User

  Background:

    #needs to stay in single thread pack

    Given I am on "Bureau" "demo"
    Given "3" new pool's are inserted for court "415" with owner "400" and a deferral date "1" Mondays in the future new schema

    #reset data
    Then juror "041500000" has "LAST_NAME" as "TESTNAME" new schema
    Then juror "041500001" has "LAST_NAME" as "TESTNAME" new schema
    Then juror "041500002" has "LAST_NAME" as "TESTNAME" new schema
    Then juror "041500000" has "FIRST_NAME" as "0FNAME0" new schema
    Then juror "041500001" has "FIRST_NAME" as "0FNAME1" new schema
    Then juror "041500002" has "FIRST_NAME" as "0FNAME2" new schema
    Then juror "041500000" has "DOB" as "1971-08-13 00:00:00.000" new schema
    Then juror "041500001" has "DOB" as "1971-08-13 00:00:00.000" new schema
    Then juror "041500002" has "DOB" as "1971-08-13 00:00:00.000" new schema

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
    Then I click the "juror number" column header
    Then The first deferral in the table is "041500000, 0FNAME0, TESTNAME, 415000000" with a deferral date "1" Mondays in the future
    And Row "3" deferral in the table is "041500002, 0FNAME2, TESTNAME, 415000002" with a deferral date "1" Mondays in the future

  @JurorTransformation
  Scenario Outline: Happy path to allocate one juror to a pool from deferral maintenance - Bureau User

    #needs to stay in single thread pack

    #select juror deferral to add to active pool
    When I select juror "<juror_number>" from the deferrals table
    And I press the "Add to a pool" button
    Then I see "Choose an active pool to add selected jurors to" on the page
    And I select pool "<target_pool>" from the active pools table
    And I press the "Continue" button
    Then I see "Selected jurors added to pool <target_pool>" on the page

    Examples:
      | juror_number | target_pool |
      | 041500000    | 415111111   |

  @JurorTransformation
  Scenario Outline: Happy path to allocate multiple jurors to a pool from deferral maintenance - Bureau User

    #needs to stay in single thread pack

    #select juror's deferral to add to active pool
    When I select juror "<juror_number_one>" from the deferrals table
    And I select juror "<juror_number_two>" from the deferrals table
    And I press the "Add to a pool" button
    Then I see "Choose an active pool to add selected jurors to" on the page
    And I select pool "<target_pool>" from the active pools table
    And I press the "Continue" button
    Then I see "Selected jurors added to pool <target_pool>" on the page

    Examples:
      | juror_number_one | juror_number_two | target_pool |
      | 041500000        | 041500001        | 415111111   |

  @JurorTransformation
  Scenario Outline: Change selected court while on deferral maintenance - Bureau User

    #needs to stay in single thread pack

    #select juror deferral to add to active pool
    Given "<number_of_pools>" new pool's are inserted for court "<court_code>" with owner "<owner>" and a deferral date "<deferral_weeks>" Mondays in the future new schema
    #select court
    When I set input field with "ID" of "courtNameOrLocationCode" to "<court_search>"
    And I click on the "<court_link>" link
    And I press the "Find" button
    Then I am taken to the deferral maintenance screen for the selected court "<selected_court>"
    And The deferrals table is displayed
    When I click on the "<sort_link>" link
    And The first deferral in the table is "<expected_first_row>" with a deferral date "<deferral_weeks>" Mondays in the future

    Examples:
      | number_of_pools | court_code | owner | deferral_weeks | court_search | court_link      | selected_court                         | sort_link    | expected_first_row              |
      | 1               | 416        | 400   | 1              | CHICHESTER   | Chichester (416) | Guildford Sitting At Chichester (416) | Juror number | 041600000, fname, lname, 416000000 |

  @JurorTransformation
  Scenario Outline: Sort deferrals on deferral maintenance page - Bureau User

    #needs to stay in single thread pack

    #sort by Juror number (descending)
    When I click on the "Juror number" link
    Then Row "3" from last deferral in the table is "<initial_third_from_last_row>" with a deferral date "<deferral_weeks>" Mondays in the future
    And The last deferral in the table is "<initial_last_row>" with a deferral date "<deferral_weeks>" Mondays in the future

    #sort by First name (ascending)
    When I click on the "First name" link
    Then The first deferral in the table is "<initial_first_row>" with a deferral date "<deferral_weeks>" Mondays in the future
    And Row "3" deferral in the table is "<initial_third_row>" with a deferral date "<deferral_weeks>" Mondays in the future
    #sort by First name (descending)
    When I click on the "First name" link
    Then Row "3" from last deferral in the table is "<initial_third_from_last_row>" with a deferral date "<deferral_weeks>" Mondays in the future
    And The last deferral in the table is "<initial_last_row>" with a deferral date "<deferral_weeks>" Mondays in the future

    #sort by Pool number (ascending)
    When I click on the "Pool number" link
    Then The first deferral in the table is "<initial_first_row>" with a deferral date "<deferral_weeks>" Mondays in the future
    And Row "3" deferral in the table is "<initial_third_row>" with a deferral date "<deferral_weeks>" Mondays in the future
    #sort by Pool number (descending)
    When I click on the "Pool number" link
    Then Row "3" from last deferral in the table is "<initial_third_from_last_row>" with a deferral date "<deferral_weeks>" Mondays in the future
    And The last deferral in the table is "<initial_last_row>" with a deferral date "<deferral_weeks>" Mondays in the future

    #sort by Deferred to (ascending)
    When I click on the "Deferred to" link
    Then The first deferral in the table is "<initial_first_row>" with a deferral date "<deferral_weeks>" Mondays in the future
    And Row "3" deferral in the table is "<initial_third_row>" with a deferral date "<deferral_weeks>" Mondays in the future
    #sort by Deferred to (descending)
    When I click on the "Deferred to" link
    Then The first deferral in the table is "<initial_first_row>" with a deferral date "<deferral_weeks>" Mondays in the future
    And Row "3" deferral in the table is "<initial_third_row>" with a deferral date "<deferral_weeks>" Mondays in the future

    #change data
    Then juror "<juror_number_one>" has "LAST_NAME" as "<last_name_a>" new schema
    Then juror "<juror_number_two>" has "LAST_NAME" as "<last_name_b>" new schema
    Then juror "<juror_number_three>" has "LAST_NAME" as "<last_name_c>" new schema
    Then juror "<juror_number_one>" has "FIRST_NAME" as "<updated_first_name>" new schema
    Then juror "<juror_number_two>" has "FIRST_NAME" as "<updated_first_name>" new schema
    Then juror "<juror_number_three>" has "FIRST_NAME" as "<updated_first_name>" new schema

    #refresh def maintenance results set as the data has been updated
    And I click on deferral maintenance

    #select court
    When I set input field with "ID" of "courtNameOrLocationCode" to "<court_search>"
    And I click on the "<court_link>" link
    And I press the "Find" button

    When I set the "last name" deferral filter to "<last_name_c>"
    Then The first deferral in the table is "<updated_last_name_filter_row>" with a deferral date "<deferral_weeks>" Mondays in the future

    #clear filter
    And I set the "first name" deferral filter to "<updated_first_name>"

    #sort by Last name (ascending)
    When I click on the "Last name" link
    Then The first deferral in the table is "<updated_first_row>" with a deferral date "<deferral_weeks>" Mondays in the future
    And Row "3" deferral in the table is "<updated_third_row>" with a deferral date "<deferral_weeks>" Mondays in the future
    #sort by Last name (descending)
    When I click on the "Last name" link
    Then The first deferral in the table is "<updated_descending_first_row>" with a deferral date "<deferral_weeks>" Mondays in the future
    And The last deferral in the table is "<updated_last_row>" with a deferral date "<deferral_weeks>" Mondays in the future

    Examples:
      | deferral_weeks | initial_first_row                  | initial_third_row                  | initial_third_from_last_row          | initial_last_row                   | juror_number_one | juror_number_two | juror_number_three | last_name_a | last_name_b | last_name_c | updated_first_name | court_search | court_link    | updated_last_name_filter_row            | updated_first_row                         | updated_third_row                         | updated_descending_first_row              | updated_last_row                          |
      | 1              | 041500000, 0FNAME0, TESTNAME, 415000000 | 041500002, 0FNAME2, TESTNAME, 415000002 | 041500002, 0FNAME2, TESTNAME, 415000002 | 041500000, 0FNAME0, TESTNAME, 415000000 | 041500000        | 041500001        | 041500002          | TESTNAMEA   | TESTNAMEB   | TESTNAMEC   | TESTFNAME          | CHESTER      | Chester (415) | 041500002, TESTFNAME, TESTNAMEC, 415000002 | 041500000, TESTFNAME, TESTNAMEA, 415000000 | 041500002, TESTFNAME, TESTNAMEC, 415000002 | 041500002, TESTFNAME, TESTNAMEC, 415000002 | 041500000, TESTFNAME, TESTNAMEA, 415000000 |

  @JurorTransformation
  Scenario Outline: Filter deferrals on deferral maintenance page - Bureau User

    #needs to stay in single thread pack

    And I see "Deferral maintenance" on the page

    #apply Juror number filter
    When I set the "juror number" deferral filter to "<juror_number_filter>"
    Then The first deferral in the table is "<filtered_juror_number_row>" with a deferral date "<deferral_weeks>" Mondays in the future
    #apply First name filter
    When I set the "first name" deferral filter to "<first_name_filter>"
    Then The first deferral in the table is "<filtered_first_name_row>" with a deferral date "<deferral_weeks>" Mondays in the future

    #apply Deferred to filter
    When I set the deferral deferred to filter to "<deferral_weeks>" Mondays in the future
    And I click on the "Juror number" link
    Then The first deferral in the table is "<expected_first_row>" with a deferral date "<deferral_weeks>" Mondays in the future
    And Row "3" deferral in the table is "<expected_third_row>" with a deferral date "<deferral_weeks>" Mondays in the future

    #apply NON_EXISTENT Juror number filter
    And I press the "Show filter" button
    And I set "Juror number" to "<no_results_juror_number>"
    And I press the "Apply filters" button
    Then I see "<no_results_message>" on the page

    Examples:
      | deferral_weeks | juror_number_filter | first_name_filter | filtered_juror_number_row          | filtered_first_name_row            | expected_first_row                  | expected_third_row                  | no_results_juror_number | no_results_message            |
      | 1              | 041500001           | 0FNAME1           | 041500001, 0FNAME1, TESTNAME, 415000001 | 041500001, 0FNAME1, TESTNAME, 415000001 | 041500000, 0FNAME0, TESTNAME, 415000000 | 041500002, 0FNAME2, TESTNAME, 415000002 | 000000000               | There are no results to display |

  @JurorTransformation
  Scenario Outline: Juror number hyperlink on deferral maintenance page - Bureau User

    #needs to stay in single thread pack

    #navigate to juror record from juror number hyperlink
    When I click on the "<juror_number>" link
    Then I am on the Juror Record for juror "<juror_number>"

    Examples:
      | juror_number |
      | 041500000    |

  @JurorTransformation
  Scenario Outline: Empty court search error on deferral maintenance page - Bureau User

    #needs to stay in single thread pack

    #dont select a court and press find button
    And I press the "<button>" button
    Then I see "<error_message>" on the page

    Examples:
      | button | error_message                       |
      | Find   | Enter a court name or location code |
