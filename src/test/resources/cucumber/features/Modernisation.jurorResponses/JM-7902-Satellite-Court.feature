Feature: JM-7902

  @JurorTransformationMulti @NewSchemaConverted
  Scenario Outline: As a Satellite court user I want to be able to click the change link on an attendance
    Given I am on "Bureau" "ithc"

    Given a bureau owned pool is created with jurors
      | court | juror_number  	    | pool_number	    | att_date_weeks_in_future	| owner |
      | 415   | <juror_number1> 	| <pool_number>     | 5				            | 400	|

    Then a new pool is inserted for where record has transferred to the court new schema
      |part_no            | pool_no       | owner |
      |<juror_number1>    | <pool_number> | 415   |

    And I log in as "<user>"

    When the user searches for juror record "<juror_number1>" from the global search bar
    And I press the "Update juror record" button
    And I set the radio button to "Reassign to another pool"
    And I press the "Continue" button
    And I click on the "Change court" link
    And I set the radio button to "Warrington (462)"
    And I press the "Continue" button
    And I select one of the active pools available
    And I press the "Continue" button
    And I see "Juror record updated: Reassigned to pool" on the page

    Given I am on "Bureau" "ithc"

    And I Confirm all the data in the record attendance table is cleared
    And I log in as "<user>" selecting court "462"

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

    And I click on the "Change" link
    And I see "Enter check in time" on the page
    And I see "Enter check out time" on the page
    And I see "Delete attendance and mark as absent" on the page



    Examples:
      |user			| juror_number1  | pool_number|
      |MODTESTCOURT | 041564399      | 415314611  |
