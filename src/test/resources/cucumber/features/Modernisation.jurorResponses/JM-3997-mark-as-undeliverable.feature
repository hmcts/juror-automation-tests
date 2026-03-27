Feature: JM-3997

  @JurorTransformationMulti
  Scenario Outline: Test to mark as undeliverable
    Given I am on "Bureau" "test"

    And I log in as "<user>"

    Given a bureau owned pool is created with jurors
      | court | juror_number  	    | pool_number	    | att_date_weeks_in_future	| owner |
      | 415   | <juror_number> 	    | <pool_number>     | 7				            | 400	|

    When the user searches for juror record "<juror_number>" from the global search bar
    And I click the update juror record button
    And I select the mark as undeliverable radio button
    Then I click continue on the update juror record screen
    And I see the juror record updated banner containing "Summons undeliverable"
    And I see the juror status on the juror record screen has updated to "Undeliverable"
    And I click the summons reply tab
    And I see the summons reply status is "Summons not received"

    Examples:
      | user          | juror_number  | pool_number   |
      | MODTESTBUREAU | 041500146     | 415300246     |

  @JurorTransformationMulti
  Scenario Outline: Bulk Undeliverable

    Given I am on "Bureau" "test"

    And I log in as "<user>"

    Given a bureau owned pool is created with jurors
      | court | juror_number  	    | pool_number	    | att_date_weeks_in_future	| owner |
      | 415   | <juror_number1> 	| <pool_number>     | 7				            | 400	|
      | 415   | <juror_number2> 	| <pool_number>     | 7				            | 400	|

    When the user searches for juror record "<juror_number1>" from the global search bar
    And I record a happy path paper summons response and process now
    And I see the juror record updated banner containing "Responded"

    And I press the "Apps" button
    And I click on the "Summons management" link
    And I click on the "Bulk Undeliverable" link
    And I set input field with "ID" of "undeliverableJurorNumber" to "<juror_number1>"
    And I press the "Confirm" button
    Then I see "Juror must be in Summoned status to be marked as undeliverable" on the page
    And I see "Failed" in the same row as "<juror_number1>"

    And I set input field with "ID" of "undeliverableJurorNumber" to "<juror_number2>"
    And I press the "Confirm" button
    Then I do not see "Juror must be in Summoned status to be marked as undeliverable" on the page
    And I see "Remove" in the same row as "<juror_number2>"

    And I press the "Mark as undeliverable" button
    Then I see "Marked 1 jurors as undeliverable" on the page

    And on "JUROR_MOD" . "JUROR_POOL" I see "NEXTDATE" is not null where "JUROR_NUMBER" is "<juror_number1>" new schema
    And on "JUROR_MOD" . "JUROR_POOL" I see "NEXTDATE" is null where "JUROR_NUMBER" is "<juror_number2>" new schema

    Examples:
      | user          | juror_number1  | juror_number2 |pool_number   |
      | MODTESTBUREAU | 041500177      | 041500178     | 415300277    |