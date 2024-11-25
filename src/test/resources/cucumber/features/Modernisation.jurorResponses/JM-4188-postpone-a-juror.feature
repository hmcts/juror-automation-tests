  Feature: 4188 - postpone juror

  @JurorTransformationMulti
  Scenario Outline: Test to mark juror as postponed and add to future pool

    Given I am on "Bureau" "ithc"

    Given a bureau owned pool is created with jurors
      | court | juror_number  	    | pool_number	    | att_date_weeks_in_future	| owner |
      | 415   | <juror_number> 	    | <pool_number>     | 5				            | 400	|

    And I log in as "<user>"
    And I navigate to the pool request screen
    And I create an active "Crown" court pool request for court "415", "30" Mondays in the future

    And I search for juror "<juror_number>"
    And I click the update juror record button
    Then I do not see "Postpone" on the page

    And I insert dob for juror "<juror_number>"

    And I search for juror "<juror_number>"
    And I click the update juror record button
    And I set the radio button to "Postpone service start date"
    And I click continue on the update juror record screen
    And I enter a date "30" mondays in the future for the new service start date
    When I click continue on the postponement page
    And I select a postponement date
    And I click continue on the postponement page

    Then I see "Juror record updated: Postponed" on the page

    Examples:
      | user          | juror_number  | pool_number  |
      | MODTESTBUREAU | 041500125     | 415300225    |