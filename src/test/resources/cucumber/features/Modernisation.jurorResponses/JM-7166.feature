Feature: JM-7166

  @JurorTransformationMulti @NewSchemaConverted
  Scenario Outline: I want to be able to view jurors at a satellite pool while logged in as a parent court
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

    When the user searches for juror record "<juror_number1>" from the global search bar
    And I see the court name on the juror record screen is "The Crown Court At Warrington"

    Given I am on "Bureau" "ithc"
    And I log in as "<user>"

    When the user searches for juror record "<juror_number1>" from the global search bar
    And I see the court name on the juror record screen is "The Crown Court At Warrington"



    Examples:
      |user			| juror_number1  | pool_number|
      |MODTESTCOURT | 041514822      | 415312689  |
