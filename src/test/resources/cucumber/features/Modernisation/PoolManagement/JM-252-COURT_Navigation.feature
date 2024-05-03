Feature: JM-252_Navigation_COURT

  @JurorTransformationMulti @NewSchemaConverted
  Scenario Outline: Navigating back and forth and changing inputs
    Given I am on "Bureau" "test"
    And I log in as "<user>"

    Given a bureau owned pool is created with jurors
      | court | juror_number   | pool_number   | att_date_weeks_in_future | owner |
      | 415   | <juror_number> | <pool_number> | 5                        | 400   |

    And juror "<juror_number>" has "LAST_NAME" as "<last_name>" new schema
    And juror "<juror_number>" has "POSTCODE" as "<postcode>" new schema

    Given a new pool is inserted which is owned by the court and includes a deferred juror new schema
      | owner | pool_no       | part_no        | no_weeks |
      | 415   | <pool_number> | <juror_number> | 9        |

    #request a pool
    When I navigate to the pool request screen
    Then I press the "Create pool" button
    And I set the radio button to "Request new pool"
    And I press the "Continue" button

    #cancel
    Then I click on the "Cancel" link
    Then I see "Pool requests" on the page
    And I see "Filter by court name or location code" on the page

    #reselect create new pool
    Then I press the "Create pool" button
    And I set the radio button to "Request new pool"
    And I press the "Continue" button

    #check page content
    And on the page I see
      | text                                              |
      | Request a new pool                                |
      | Court name or location code                       |
      | Chester                                           |
      | Attendance date                                   |
      | Pool type                                         |
      | Crown court                                       |
      | High court                                        |
      | Civil court                                       |
      | Number of jurors required in total                |
      | Number of court deferrals to include in this pool |

    #CHANGE COURT
    Then  I click the change link for the chosen court
    And I see "Select a court for this pool" on the page
    Then I set input field with "ID" of "courtNameOrLocation" to "<displayCourt>"
    And I click on the "<displayCourt> (<courtCode>)" link
    And I press the "Continue" button

    #CHANGE ATTENDANCE DATE
    Then I click the change link for the attendance date
    And I see "Change the service start date for this pool" on the page
    And I set the "Change the attendance date for this pool" date to a Monday "9" weeks in the future
    And I press the "Change" button

    #CHANGE ATTENDANCE TIME
    Then I click the change link for the attendance time
    And I see "Change the attendance time for this pool" on the page
    And I see "Attendance time" on the page
    And I see "Use the 24 hour clock. For example, 9:00 or 14:00" on the page
    Then I set input field with "ID" of "attendanceTimeHour" to "09"
    Then I set input field with "ID" of "attendanceTimeMinute" to "29"
    And I press the "Change" button

    #complete new pool fields
    Then I set the radio button to "High court"
    And I set "Number of jurors required in total" to "150"

    #SELECT TO CHANGE NUMBER OF DEFERRALS
    Then I click the change link for the court deferrals
    And I see "Number of court deferrals to include in this pool" on the page
    Then I change the number of court deferrals to "1"


    #complete new pool fields
    Then I set the radio button to "High court"
    And I set "Number of jurors required in total" to "150"

    # fails due to JM-6143
    Then I press the "Continue" button
    And I should see the attendance Pool time present is "9:29am"

    And I should see the details of the pool with a bank holiday date
      | courtName           | <displayCourt> (<courtCode>) |
      | poolType            | High court                   |
      | totalJurorsRequired | 150                          |
      | numberOfDeferrals   | 1                            |
      | additionalJurors    | 149                          |

    #change
    Then I click the change button for the check pool request page

    #Change pool type
    When I change the pool type to "Crown"

    #Change # jurors required
    When I set the number of jurors to "50"
    When I click the request pool button
    Then I should be taken to the check pool request page

    And I should see the details of the pool with a bank holiday date
      | courtName           | <displayCourt> (<courtCode>) |
      | poolType            | <courtTypeFull>              |
      | totalJurorsRequired | 50                           |
      | numberOfDeferrals   | 1                            |
      | additionalJurors    | 49                           |

    #Can submit the new pool request
    When I save the new pool request
    Then I should be taken to the pool summary page
    And I click on the "Service start date" link
    And I should see the newly created pool request
      | type           | Court          |
      | type           | Court          |
      | court          | <displayCourt> |
      | jurorsRequired | 49             |

    Given the new pool for court "415" is deleted

    Examples:
      | user         | courtCode | displayCourt | courtTypeFull | juror_number | pool_number |
      | MODTESTCOURT | 415       | Chester      | Crown court   | 041500053    | 415300143   |

  @JurorTransformationMulti @NewSchemaConverted
  Scenario Outline: Create pools for different courts and apply filters for court user
    Given I am on "Bureau" "test"

    And I log in as "<user>"

    When I navigate to the pool request screen

    When I press the "Create pool" button
    And I set the radio button to "Request new pool"
    And I press the "Continue" button

    And I click the change link for the court deferrals
    And I set "Number of deferred jurors to include in this pool" to "0"
    And I press the "Continue" button

    Then I set the radio button to "<courtType>"
    And I set "Number of jurors required in total" to "150"
    Then I should see the attendance time present is "09:30"
    Then I press the "Continue" button

    When I save the new pool request
    Then I should be taken to the pool summary page
    And I click on the "Service start date" link
    And I should see the newly created pool request
      | type           | Court   |
      | court          | Chester |
      | jurorsRequired | 150     |

    When I press the "Create pool" button
    And I set the radio button to "Request new pool"
    And I press the "Continue" button

    #CHANGE COURT
    Then  I click the change link for the chosen court
    And I see "Select a court for this pool" on the page
    Then I set input field with "ID" of "courtNameOrLocation" to "767"
    And I click on the "Knutsford (767)" link
    And I press the "Continue" button

    Then I set the radio button to "<courtType>"
    And I set "Number of jurors required in total" to "150"
    Then I should see the attendance time present is "10:00"
    Then I press the "Continue" button

    When I save the new pool request
    Then I should be taken to the pool summary page
    And I click on the "Service start date" link

    And I should see the newly created pool request
      | type           | Court     |
      | court          | Knutsford |
      | jurorsRequired | 150       |

    Then I set input field with "ID" of "courtNameOrLocation" to "415"
    Then I click on the "Chester (415)" link
    Then I press the "Filter" button
    Then only records from "Chester" are displayed

    Then I click on the "Clear filter" link

    Then I see "Chester" on the page
    And I see "Knutsford" on the page

    Then I set input field with "ID" of "courtNameOrLocation" to "767"
    Then I click on the "Knutsford (767)" link
    Then I press the "Filter" button
    Then only records from "Knutsford" are displayed

    Then I click on the "Clear filter" link

    Then I set input field with "ID" of "courtNameOrLocation" to "Chester"
    Then I click on the "Chester (415)" link
    Then I press the "Filter" button
    Then only records from "Chester" are displayed

    Then I click on the "Clear filter" link

    Then I see "Chester" on the page
    And I see "Knutsford" on the page

    Then I set input field with "ID" of "courtNameOrLocation" to "Knutsford"
    Then I click on the "Knutsford (767)" link
    Then I press the "Filter" button
    Then only records from "Knutsford" are displayed

    When I press the "Create pool" button
    And I set the radio button to "Request new pool"
    And I press the "Continue" button

    #CHANGE COURT
    Then  I click the change link for the chosen court
    And I see "Select a court for this pool" on the page
    Then I set input field with "ID" of "courtNameOrLocation" to "462"
    And I click on the "Warrington (462)" link
    And I press the "Continue" button

    Then I set the radio button to "<courtType>"
    And I set "Number of jurors required in total" to "150"
    Then I should see the attendance time present is "09:30"
    Then I press the "Continue" button

    When I save the new pool request
    Then I should be taken to the pool summary page
    And I click on the "Service start date" link

    And I should see the newly created pool request
      | type           | Court      |
      | court          | Warrington |
      | jurorsRequired | 150        |

    Then I set input field with "ID" of "courtNameOrLocation" to "462"
    Then I click on the "Warrington (462)" link
    Then I press the "Filter" button
    Then only records from "Warrington" are displayed

    Then I click on the "Clear filter" link

    Then I see "Chester" on the page
    And I see "Knutsford" on the page
    And I see "Warrington" on the page

    Examples:
      | user     | courtType |
      | MODCOURT | Crown     |

  @JurorTransformationMulti @NewSchemaConverted
  Scenario Outline: Create pool and check cannot change pool number
    Given I am on "Bureau" "test"

    And I log in as "<user>"

    When I navigate to the pool request screen

    When I press the "Create pool" button
    And I set the radio button to "Request new pool"
    And I press the "Continue" button

    Then I set the radio button to "<courtType>"
    And I set "Number of jurors required in total" to "150"
    Then I press the "Continue" button

    Then I do not see Change link in the same row as Pool number

    Examples:
      | user         | courtType |
      | MODTESTCOURT | Crown     |


  @JurorTransformationMulti @NewSchemaConverted
  Scenario: Nil pool contains no deferral options
    Given I am on "Bureau" "test"
    And I log in as "MODTESTCOURT"
    And I navigate to the pool request screen
    And I select to create a nil pool
    And I do not see "Number of court deferrals to include in this pool" on the page

