Feature: JM-5178

  @JurorTransformationMulti @NewSchemaConverted
  Scenario Outline: Place a juror on call as a jury officer - Attendance screen
    Given I am on "Bureau" "test"

    Given a bureau owned pool is created with jurors
      | court | juror_number  	    | pool_number	    | att_date_weeks_in_future	| owner |
      | 415   | <juror_number> 	    | <pool_number>     | 5				            | 400	|

    Then a new pool is inserted for where record has transferred to the court new schema
      |part_no        | pool_no       | owner |
      |<juror_number> | <pool_number> | 415   |

    And I log in as "<user>"
    When the user searches for juror record "<juror_number>" from the global search bar
    And I record a happy path paper summons response and process now

    And I press the "Apps" button
    And I click on the "Juror management" link
    And I click on the "Record attendance" link
    And I click on the "Jurors in waiting" link
    And I choose the "Check in" radio button
    
    And I set "Hour" to "09"
    And I set "Minute" to "00"
    And I choose the "am" radio button
    And I input juror "<juror_number>" to be checked in
    And I press the "Check in juror" button
    And I see "9:00am" in the same row as "<juror_number>"

    When the user searches for juror record "<juror_number>" from the global search bar
    And I click on the "Attendance" link
    And I click on the "Change" link
    And I see "When are they next due at court?" on the page
    And I press the "Save" button
    And I see error "Enter when the juror is next due at court or put the juror on call"
    And I check the "Put juror on call" checkbox
    And I press the "Save" button
    And I see "On call" in the same row as "Next due at court"

    Examples:
      | user		 | juror_number | pool_number   |
      | MODTESTCOURT | 041500161    | 415300260     |