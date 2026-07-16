Feature: JS-622 - Shuffle address

  @JurorTransformation @Bureau
  Scenario Outline: Shuffle address data when address4 is null

    Given I am on "Bureau" "<environment>"

    Given a bureau owned pool is created with jurors
      | court |juror_number  	| pool_number	| att_date_weeks_in_future	| owner |
      | 452   |<juror_number> 	| <pool_number> | 5				            | 400	|

    And I clear down existing jurors for shuffle address test in pool "<pool_number>"

    And I log in as "<user>"

    And new voter records are inserted into the voters table for address shuffle
    And I reset the catchment area for shuffle address

    And I press the "Apps" button
    And I click on the "Pool management" link
    And I click on the "Search" link
    And I set "Pool number" to "<pool_number>"
    And I press the "Continue" button
    And I see "<pool_number>" on the page

    And I press the "Summon jurors" button
    And I set "Extra citizens to summon" to "5"
    And I press the "Summon more citizens" button

    And I verify the juror address shuffles are correct for pool "<pool_number>"

    Examples:
     | juror_number | pool_number | user          | environment |
     | 045278833    | 452388166   | MODTESTBUREAU | ithc        |
