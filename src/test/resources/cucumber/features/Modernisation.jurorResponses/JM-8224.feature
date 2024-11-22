Feature: JM-8224 - Cannot defer a juror who has an attendance

  @JurorTransformation
  Scenario Outline: Check that you cannot defer a juror with an attendance

    Given I am on "Bureau" "ithc"

    When a bureau owned pool is created with jurors
      | court | juror_number   | pool_number	| att_date_weeks_in_future	| owner |
      | 415   | <juror_number> | <pool_number>  | -1				        | 400	|

    Then a new pool is inserted for where record has transferred to the court new schema
      | part_no         | pool_no       | owner |
      | <juror_number>  | <pool_number> | 415   |

    And I Confirm all the data in the record attendance table is cleared
    And I log in as "<user>"

    #set juror as responded
    And I update juror "<juror_number>" to have a status of responded in order to record attendance
    Then juror "<juror_number>" has "DOB" as "1971-08-13 00:00:00.000" new schema

    #check in jurors
    And I press the "Apps" button
    And I click on the "Juror management" link
    And I click on the "Record attendance" link
    And I set the radio button to "Check in"

    And I set "Hour" to "9"
    And I set "Minute" to "00"
    And I set the radio button to "am"
    And I input juror "<juror_number>" to be checked in
    And I press the "Check in juror" button

    And the user searches for juror record "<juror_number>" from the global search bar

    And I press the "Update juror record" button
    And I see "Update Juror Record" on the page
    And I do not see "Deferral - grant or refuse" on the page
    And I see "Change juror status to ‘Failed to attend’" on the page

    Examples:
      | user		 | juror_number | pool_number   |
      | MODTESTCOURT | 041500081    | 415300171     |