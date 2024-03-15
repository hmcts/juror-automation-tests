Feature: JM-4360 - As a jury officer I need to be able to check jurors in for their attendance on the day - HAPPY PATH

  @JurorTransformationMulti @NewSchemaConverted
  Scenario Outline: Check in jurors for attendance on their day
    Given I am on "Bureau" "test"

    Given a bureau owned pool is created with jurors
      | court | juror_number  	    | pool_number	    | att_date_weeks_in_future	| owner |
      | 415   | <juror_number1> 	| <pool_number>     | 5				            | 400	|
      | 415   | <juror_number2> 	| <pool_number>     | 5				            | 400	|

    Then a new pool is inserted for where record has transferred to the court new schema
      |part_no            | pool_no       | owner |
      |<juror_number1>    | <pool_number> | 415   |
      |<juror_number2>    | <pool_number> | 415   |

    And I log in as "<user>"

    #enter responses in order to be in a state to be checked in
    When the user searches for juror record "<juror_number1>" from the global search bar
    And I record a happy path paper summons response and process now

    When the user searches for juror record "<juror_number2>" from the global search bar
    And I record a happy path paper summons response and process now

    And I press the "Apps" button
    And I click on the "Juror management" link
    And I click on the "Record attendance" link
    And I click on the "Jurors in waiting" link
    And I set the radio button to "Check in"

    #check in
    And I set "Hour" to "09"
    And I set "Minute" to "00"
    And I set the radio button to "am"
    And I input juror "<juror_number1>" to be checked in
    And I press the "Check in juror" button
    And I set "Hour" to "2"
    And I set "Minute" to "30"
    And I set the radio button to "pm"
    And I input juror "<juror_number2>" to be checked in
    And I press the "Check in juror" button

    #check jurors have been checked in at their right times
    And I see "jurors listed as attending" on the page
    And I see "<juror_number1>" in the same row as "9:00am"
    And I see "<juror_number2>" in the same row as "2:30pm"

    Examples:
      |user			| juror_number1 | juror_number2 | pool_number|
      |MODTESTCOURT | 041500148     | 041500149     | 415300248  |