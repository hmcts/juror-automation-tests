Feature: JM-6261 - As a bureau officer I need to be able to resend an initial summons

  @JurorTransformationMulti @NewSchemaConverted
  Scenario Outline: As a Bureau office resent an Initial summons letter for a juror who has just been summoned

    Given I am on "Bureau" "ithc"

    Given a bureau owned pool is created with jurors
      | court |juror_number  	    | pool_number	    | att_date_weeks_in_future	| owner |
      | 415   |<juror_number> 	    | <pool_number>     | 5				            | 400	|

    #log on and search for juror
    And I delete all letters within the pool "<pool_number>" for the letter
    And a initial summons letter inserted for juror "<juror_number>"
    And I log in as "<user>" selecting court "415"
    And I press the "Apps" button
    And I click on the "Pool management" link     

    Then I print all letters within the pool "<pool_number>" for the initial summons letter
    And I press the "Apps" button
    And I click on the "Documents" link

    And I click on the "Initial summons" link
    And I set the radio button to "Pool"
    And I set "Enter pool number" to "<pool_number>"
    And I press the "Search" button
    And I see "<pool_number>" on the page
    Then I check all the checkboxes in the letters table
    And I press the "Resend initial summons" button
    And I see "sent for printing" on the page


    Examples:
      |user			 | juror_number | pool_number |
      |MODTESTBUREAU | 041535171    | 415778331   |