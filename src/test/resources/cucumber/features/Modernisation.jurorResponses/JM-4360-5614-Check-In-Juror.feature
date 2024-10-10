Feature: JM-4360 - As a jury officer I need to be able to check jurors in for their attendance on the day - JM-5614 - Unhappy Path

  @JurorTransformation
  Scenario Outline: Check in jurors for attendance on their day
    Given I am on "Bureau" "ithc"

    Given a bureau owned pool is created with jurors
      | court | juror_number  	    | pool_number	    | att_date_weeks_in_future	| owner |
      | 415   | <juror_number1> 	| <pool_number>     | 5				            | 400	|
      | 415   | <juror_number2> 	| <pool_number>     | 5				            | 400	|

    Then a new pool is inserted for where record has transferred to the court new schema
      |part_no            | pool_no       | owner |
      |<juror_number1>    | <pool_number> | 415   |
      |<juror_number2>    | <pool_number> | 415   |

    And I log in as "<user>"

    And I update juror "<juror_number1>" to have a status of "Responded"
    And I update juror "<juror_number2>" to have a status of "Responded"

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


  @JurorTransformation
  Scenario Outline: Check in jurors for attendance on their day - Unhappy Path
    Given I am on "Bureau" "ithc"

    Given a bureau owned pool is created with jurors
      | court | juror_number  	| pool_number	    | att_date_weeks_in_future	| owner |
      | 415   | <juror_number> 	| <pool_number>     | 5				            | 400	|

    Then a new pool is inserted for where record has transferred to the court new schema
      |part_no           | pool_no       | owner |
      |<juror_number>    | <pool_number> | 415   |

    And I Confirm all the data in the record attendance table is cleared
    And I update juror "<juror_number>" to have a status of "Responded"

    And I log in as "<user>"
    When the user searches for juror record "<juror_number>" from the global search bar
    And I see the juror status has updated to "Responded"
    And I click on the "Juror details" link
    And I click on the "Add or change" link
    And I click on the "Fix error in current name" link

    #change name for police check
    And I set "First name" to "Arun"
    And I set "Last name" to "Pattani"
    And I press the "Review Edit" button
    And I see "Juror details" on the page

    #change dob for police check
    And I set "Date of birth" to "13/08/1971"
    And I press the "Save" button
    And I see "13 Aug 1971" in the same row as "Date of birth"

    #change postcode for police check
    And I click on the "Add or change" link
    And I click on the "Change" link
    And I set "Postcode" to "B68ZX"
    And I press the "Review Edit" button
    And I see "Additional requirements" on the page
    And I press the "Save" button

    And I press the "Apps" button
    And I click on the "Juror management" link
    And I click on the "Record attendance" link
    And I click on the "Jurors in waiting" link
    And I set the radio button to "Check in"

    #check in
    And I set "Hour" to "09"
    And I set "Minute" to "00"
    And I set the radio button to "am"
    And I input juror "<juror_number>" to be checked in
    And I press the "Check in juror" button
    And I see "9:00am" in the same row as "<juror_number>"
    And I update juror "<juror_number>" to have a police check status of "INELIGIBLE"

    When the user searches for juror record "<juror_number>" from the global search bar
    And I see police check has updated to "Failed"

    And I press the "Apps" button
    And I click on the "Juror management" link
    And I click on the "Record attendance" link
    And I see "Failed" in the same row as "<juror_number>"

    Examples:
      |user			| juror_number | pool_number|
      |MODTESTCOURT | 041522662    | 415319228  |