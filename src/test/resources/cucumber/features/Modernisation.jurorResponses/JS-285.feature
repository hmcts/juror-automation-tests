Feature: JS-285

  @JurorTransformation
  Scenario Outline: Check date picker for record attendance screen

    Given I am on "Bureau" "ithc"

    Given a bureau owned pool is created with jurors
      | court | juror_number  	    | pool_number	    | att_date_weeks_in_future	| owner |
      | 415   | <juror_number1> 	| <pool_number>     | 5				            | 400	|

    Then a new pool is inserted for where record has transferred to the court new schema
      |part_no            | pool_no       | owner |
      |<juror_number1>    | <pool_number> | 415   |

    And I log in as "<user>"

    And I update juror "<juror_number1>" to have a status of "Responded"

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
    And I see "<juror_number1>" in the same row as "9:00am"
    And I select "92" days in the past from the date picker
    And I select "156" days in the past from the date picker
    And I select "3" days in the past from the date picker


    Examples:
      |user			| juror_number1  | pool_number|
      |MODTESTCOURT | 041533397      | 415369213  |