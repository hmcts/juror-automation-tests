Feature: JS-337

  @JurorTransformationMulti
  Scenario Outline: Set an undelivered juror to summoned - Bureau User

    Given I am on "Bureau" "ithc"

    Given a bureau owned pool is created with jurors
      | court  | juror_number  	| pool_number	   | att_date_weeks_in_future	| owner |
      | 415    | <juror_number1> | <pool_number>    | 5				            | 400	|
      | 415    | <juror_number2> | <pool_number>    | 5				            | 400	|

    Given juror "<juror_number2>" has "DOB" as "1971-08-13 00:00:00.000" new schema
    
    And I log in as "<user>"
    
    And I search for juror "<juror_number1>"
    And I press the "Update juror record" button
    And I choose the "Mark summons as undeliverable" radio button
    And I press the "Continue" button
    Then I see the juror record updated banner containing "Summons undeliverable"
    And I see the juror status has updated to "Undeliverable"
    
    When I press the "Update juror record" button
    Then I see "Mark as summoned" on the page
    And I do not see "Mark summons as undeliverable" on the page

    When I choose the "Mark as summoned" radio button
    And I press the "Continue" button
    Then I see the juror record updated banner containing "Summoned"
    And I see the juror status has updated to "Summoned"

    When I press the "Update juror record" button
    Then I do not see "Mark as summoned" on the page
    And I see "Mark summons as undeliverable" on the page

    And I search for juror "<juror_number2>"
    And I press the "Update juror record" button
    And I choose the "Mark summons as undeliverable" radio button
    And I press the "Continue" button
    Then I see the juror record updated banner containing "Summons undeliverable"
    And I see the juror status has updated to "Undeliverable"

    When I press the "Update juror record" button
    Then I see "Mark as summoned" on the page
    And I do not see "Mark summons as undeliverable" on the page

    When I choose the "Mark as summoned" radio button
    And I press the "Continue" button
    Then I see the juror record updated banner containing "Summoned"
    And I see the juror status has updated to "Summoned"

    When I press the "Update juror record" button
    Then I do not see "Mark as summoned" on the page
    And I see "Mark summons as undeliverable" on the page
    
    Examples:
      | user          | juror_number1  | juror_number2| pool_number   |
      | MODTESTBUREAU | 041531089      | 041531090    | 415304678     |