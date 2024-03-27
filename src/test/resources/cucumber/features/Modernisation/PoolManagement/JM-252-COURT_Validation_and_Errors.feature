Feature: JM-252_Validation_and_Errors_COURT

  @JurorTransformationMulti @NewSchemaConverted
  Scenario Outline: Errors and Warnings on Create New Pool for Court user
    Given I am on "Bureau" "test"

    And I log in as "<user>"

    Given a bureau owned pool is created with jurors
      | court | juror_number  	    | pool_number	    | att_date_weeks_in_future	| owner |
      | 415   | <juror_number> 	    | <pool_number>     | 7				            | 400	|

    And "641500136" has "NEXT_DATE" as "5 mondays time" new schema
    And "641500136" is not active new schema
    And "641500136" has "TRANSFER_DATE" as "-2 mondays time" new schema

    #insert new pool
    Given a new pool is inserted which is owned by the court and includes a deferred juror new schema
      |owner  | pool_no   | part_no    | no_weeks   |
      |415    | <pool_number> | <juror_number>   | 9          |

    #Can see the pool request courts table tabs and fields
    When I navigate to the pool request screen

    When I press the "Create pool" button
    And I set the radio button to "Request new pool"
    And I press the "Continue" button

    #check page content

    And on the page I see
      | text|
      |Request a new pool|
      |Court name or location code|
      |<displayCourt>             |
      |Attendance date            |
      |Attendance time            |
      |Pool type                  |
      |Crown court                |
      |High court                 |
      |Civil court                |
      |Number of jurors required in total|
      |Number of court deferrals to include in this pool|

    And I see the attendance date of the pool
    Then I should see the attendance time present is "09:00"

    #change number of deferrals
    When I click the change link for the court deferrals

    #error on continue with no input
    When I press the "Continue" button
    Then I see "Number of deferrals is missing" on the page

    #error on continue with invalid input
    When I set "Number of deferred jurors to include in this pool" to "-1"
    When I press the "Continue" button
    Then I see "Number of deferrals cannot be negative" on the page

    #error when number > number of defs available
    And I click on the "Cancel" link
    Then I set Number of deferred jurors to include to "1" more than is available
    Then I see "Number of deferrals is too high" on the page

    When I set "Number of deferred jurors to include in this pool" to "10000"
    When I press the "Continue" button
    Then I see "Number of deferrals is too high" on the page

    #select 0 deferrals
    When I set "Number of deferred jurors to include in this pool" to "0"
    When I press the "Continue" button

    #go back and select 1 deferral
    When I click the change link for the court deferrals
    When I set "Number of deferred jurors to include in this pool" to "1"
    When I press the "Continue" button

    #error on Continue with no selections made
    When I press the "Continue" button
    Then I see "Pool type is missing" on the page
    And I see "Select a pool type" on the page
    And I see "Number of jurors required is missing" on the page
    And I see "Enter the number of jurors required" on the page

    #error on Continue with only number of jurors entered
    Then I set "Number of jurors required in total" to "150"
    When I press the "Continue" button
    Then I see "Pool type is missing" on the page
    And I see "Select a pool type" on the page
    And I do not see "Number of jurors required is missing" on the page
    And I do not see "Enter the number of jurors required" on the page

    #error on Continue with only pool type set
    Then I set "Number of jurors required in total" to ""
    And I set the radio button to "<courtType>"
    When I press the "Continue" button
    Then I do not see "Pool type is missing" on the page
    And I do not see "Select a pool type" on the page
    And I see "Number of jurors required is missing" on the page
    And I see "Enter the number of jurors required" on the page

    #change att time
    Then I click the change link for the attendance time
    And I see "Change the attendance time for this pool" on the page
    Then I set input field with "ID" of "attendanceTimeHour" to ""
    Then I set input field with "ID" of "attendanceTimeMinute" to ""
    And I press the "Change" button

    And I see "Please enter an attendance hour" on the page
    And I see "Please enter an attendance minute" on the page

    Then I set input field with "ID" of "attendanceTimeHour" to "ab"
    Then I set input field with "ID" of "attendanceTimeMinute" to "cd"
    And I press the "Change" button

    And I see "Please enter the hour as a number. For example, 6 for 6am or 18 for 6pm" on the page
    And I see "Please enter the minute as a number. For example, 15" on the page

    Then I set input field with "ID" of "attendanceTimeHour" to "!"
    Then I set input field with "ID" of "attendanceTimeMinute" to "!"
    And I press the "Change" button

    And I see "Please check your attendance hour" on the page
    And I see "Please check your attendance minute" on the page
    And I see "Please enter the hour as a number. For example, 6 for 6am or 18 for 6pm" on the page
    And I see "Please enter the minute as a number. For example, 15" on the page

    Then I set input field with "ID" of "attendanceTimeHour" to "9"
    Then I set input field with "ID" of "attendanceTimeMinute" to "1"
    And I press the "Change" button

    And I should see the attendance time present is "09:01"

    #complete new pool fields
    Then I set the radio button to "<courtType>"
    And I set "Number of jurors required in total" to "150"
    Then I press the "Continue" button

    #check pool request
    Then I see "Check your pool request" on the page

    And I should see the details of the pool
      | courtName              | <displayCourt> (<courtCode>)  |
      | poolType               | <courtTypeFull>               |
      | additionalRequirements | None                          |
      | totalJurorsRequired    | 150                           |
      | numberOfDeferrals      | 1                             |
      | additionalJurors       | 149                           |

    # Can submit the new pool request
    When I save the new pool request
    Then I should be taken to the pool summary page
    And I click on the "Service start date" link

    And I should see the newly created pool request
      | court          | <displayCourt> |
      | jurorsRequired | 149            |

    Examples:
      | user	        | displayCourt     | courtType    | courtTypeFull   | courtCode |juror_number|pool_number|
      | MODTESTCOURT	| Chester          | Crown        | Crown court     | 415       |041540010|415300410|
      | MODTESTCOURT	| Chester          | Civil        | Civil court     | 415       |041540011|415300411|
      | MODTESTCOURT	| Chester          | High         | High court      | 415       |041540012|415300412|

  @JurorTransformationMulti @NewSchemaConverted
  Scenario Outline: Test to assure that a warning appears if the attendance date is set to a weekend date for Court user
    Given I am on "Bureau" "test"

    And I log in as "<user>"
    When I navigate to the pool request screen
    When I click the link to the new pool screen
    And I set the radio button to "Request new pool from Bureau"
    And I press the "Continue" button

    When I click the change link for the attendance date
    And I set the attendance date to a weekend
    Then I should see a warning stating I have selected a weekend
    When I click the link to continue from the warning page
    When I change the pool type to "Civil"

    And I set the number of jurors to "10"
    And I click the request pool button
    Then I should see a warning stating I have selected a weekend
    When I click the link to continue from the warning page
    Then I should be taken to the check pool request page
    And I should see the details of the pool
      | courtName              | <displayCourt> (<courtCode>)  |
      | poolType               | <courtTypeFull>               |
      | totalJurorsRequired    | 10                            |
      | numberOfDeferrals      | 0                             |
      | additionalJurors       | 10                            |

    Examples:
      | user	        | displayCourt     | courtTypeFull   | courtCode |
      | MODTESTCOURT	| Chester          | Civil court     | 415       |

  @JurorTransformation @NewSchemaConverted
  Scenario Outline: Test to assure that a warning appears if the attendance date is set to a bank holiday date for court user

    #leaving in single thread as it deletes and sets up BHs which may break other tests

    Given I am on "Bureau" "test"

    Given I have deleted all holidays new schema

    And I log in as "<user>"

    When I navigate to the pool request screen

    When I press the "Create pool" button
    And I set the radio button to "Request new pool"
    And I press the "Continue" button

    When I click the change link for the attendance date

    And I create a bank holiday "6" weeks in the future for court/bureau "<courtCode>" new schema

    When I set the "Change the attendance date for this pool" date to a Monday "6" weeks in the future

    And I press the "Change" button

    Then I should see a warning stating I have selected a bank holiday

    When I click the link to continue from the warning page

    Then I see "Request a new pool" on the page

    #complete new pool fields
    When I click the change link for the court deferrals
    When I set "Number of deferred jurors to include in this pool" to "0"
    When I press the "Continue" button

    Then I set the radio button to "<courtTypeFull>"
    And I set "Number of jurors required in total" to "150"
    Then I press the "Continue" button

    Then I should see a warning stating I have selected a bank holiday

    When I click the link to continue from the warning page

    #check pool request
    Then I see "Check your pool request" on the page

    And I should see the details of the pool with a bank holiday date
      | courtName              | <displayCourt> (<courtCode>) |
      | poolType               | <courtTypeFull>              |
      | totalJurorsRequired    | 150                          |
      | numberOfDeferrals      | 0                            |
      | additionalJurors       | 150                          |

    #Can submit the new pool request
    When I save the new pool request
    Then I should be taken to the pool summary page
    And I click on the "Service start date" link

    And I should see the newly created pool request
      | court          | <displayCourt>  |
      | jurorsRequired | 150             |

    Then I delete bank holiday new schema

    Examples:
      | user          | courtCode | displayCourt | courtTypeFull |
      | MODTESTCOURT  | 415       | Chester      | Crown court   |

  @JurorTransformationMulti @NewSchemaConverted
  Scenario Outline: Test to assure court user cannot see courts they dont have access to
    Given I am on "Bureau" "test"

    And I log in as "<user>"

    When I navigate to the pool request screen

    When I press the "Create pool" button
    And I set the radio button to "Request new pool"
    And I press the "Continue" button

    #TRY COURT YOU DONT HAVE ACCESS TO
    Then  I click the change link for the chosen court
    And I see "Select a court for this pool" on the page
    Then I set input field with "ID" of "courtNameOrLocation" to "452"
    And I do not see link with text "Shrewsbury (452)"
    Then I see "No results found" on the page

    #CHANGE COURT TO ONE YOU DO HAVE ACCESS TO
    Then I clear field with id "courtNameOrLocation"
    Then I set input field with "ID" of "courtNameOrLocation" to "462"
    And I click on the "Warrington (462)" link
    And I press the "Continue" button

    #complete new pool fields
    Then I set the radio button to "<courtTypeFull>"
    And I set "Number of jurors required in total" to "150"
    Then I press the "Continue" button

    And I see the attendance date of the pool

    #check pool request
    Then I see "Check your pool request" on the page

    And I should see the details of the pool
      | courtName              | <displayCourt> (<courtCode>) |
      | poolType               | <courtTypeFull>              |
      | totalJurorsRequired    | 150                          |
      | numberOfDeferrals      | 0                            |
      | additionalJurors       | 150                          |

    # Can submit the new pool request
    When I save the new pool request
    Then I should be taken to the pool summary page
    And I click on the "Service start date" link

    And I should see the newly created pool request
      | court          | <displayCourt>  |
      | jurorsRequired | 150             |

    Examples:
      | user          | courtCode | displayCourt   | courtTypeFull |
      | MODTESTCOURT  | 462       | Warrington      | Crown court   |