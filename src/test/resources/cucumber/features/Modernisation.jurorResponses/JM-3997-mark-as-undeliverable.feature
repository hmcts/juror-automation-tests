Feature: JM-3997

  @JurorTransformationMulti @NewSchemaConverted
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
    And I see the summons reply status is "SUMMONS NOT RECEIVED"

    Examples:
      | user          | juror_number  | pool_number   |
      | MODTESTBUREAU | 041500146     | 415300246     |