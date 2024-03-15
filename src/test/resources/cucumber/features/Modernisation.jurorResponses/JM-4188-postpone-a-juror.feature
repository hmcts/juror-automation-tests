  Feature: 4188 - postpone juror

  @JurorTransformationWIP @NewSchemaConverted @JM-5891
  Scenario: Test to mark juror as postponed and add to deferral maintenance
    Given I am on "Bureau" "test"
    Given records for juror "100000002" are deleted new schema
    And I clear down the data for the paper juror record "100000002" new schema
    And I log in as "MODTESTBUREAU"
    Given a juror record of "100000002" has been entered which is valid for paper summons reply new schema
    And I search for juror "100000002"
    And I click the update juror record button
    And I set the radio button to "Postpone service start date"
    And I click continue on the update juror record screen
    And I set the "Postpone service start date" single date field to a Monday "17" weeks in the future
    When I click continue on the postponement page
    Then I see "There are no active pools for this date" on the page
    When I press the "Put in deferral maintenance" button
    Then I see "Juror record updated: Postponed" on the page

  @JurorTransformationWIP @NewSchemaConverted @JM-5891
  Scenario Outline: Test to mark juror as postponed and add to future pool
    Given I am on "Bureau" "test"

    Given a bureau owned pool is created with jurors
      | court | juror_number  	    | pool_number	    | att_date_weeks_in_future	| owner |
      | 415   | <juror_number> 	    | <pool_number>     | 5				            | 400	|

    And I log in as "MODTESTBUREAU"
    And I navigate to the pool request screen
    And I create an active "civil" court pool request for court "415", "30" Mondays in the future

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
    | juror_number  | pool_number  |
    | 041500125     | 415300225    |