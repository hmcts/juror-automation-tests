Feature: JM-2485

  @JurorTransformationMulti
  Scenario Outline: Test to add notes over character limit

    Given I am on "Bureau" "ithc"

    Given a bureau owned pool is created with jurors
      | court |juror_number  | pool_number	| att_date_weeks_in_future	| owner |
      | 452	  |<juror_number>| <pool_number>| 5				            | 400	|

    Given I am on "Bureau" "ithc"
    Given I log in as "MODTESTBUREAU"

    When the user searches for juror record "<juror_number>" from the global search bar
    And I click on the "Notes" link
    And I click to add or edit notes
    And I see the juror status has updated to "Summoned"
    And I see "<juror_number>" on the page
    And I see "<pool_number>" on the page
    And I see "The Crown Court At Shrewsbury" on the page
    And I enter over 2000 characters in the Notes text box
    And I click the save notes button
    Then I see "The notes provided are too long" in the error banner

    Examples:
      |juror_number	|pool_number|
      |045200021    |452300017	|

  @JurorTransformationMulti
  Scenario Outline: Test to add and edit notes
    Given I am on "Bureau" "ithc"

    Given a bureau owned pool is created with jurors
      | court |juror_number  | pool_number	| att_date_weeks_in_future	| owner |
      | 452	  |<juror_number>| <pool_number>| 5				            | 400	|

    Given I am on "Bureau" "ithc"
    Given I log in as "MODTESTBUREAU"

    When the user searches for juror record "<juror_number>" from the global search bar
    And I click on the "Notes" link

    #add note
    And I click to add or edit notes
    And I enter "test notes 123" in the Notes text box
    And I click the save notes button
    Then I do not see "The notes provided are too long" on the page
    And I see "test notes 123" on the page

    # edit note
    And I click to add or edit notes
    And I enter "test2 notes2 1234" in the Notes text box
    And I click the save notes button
    Then I do not see "The notes provided are too long" on the page
    And I see "test2 notes2 1234" on the page

    Examples:
      |juror_number	|pool_number|
      |045200022    |452300018	|