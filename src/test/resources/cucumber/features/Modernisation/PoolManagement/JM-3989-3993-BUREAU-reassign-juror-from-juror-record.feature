Feature: JM-3989 JM-3993

  @JurorTransformation @NewSchemaConverted @JM-7664
  Scenario Outline: Reassign a juror to a pool for a different court - Bureau User
    Given I am on "Bureau" "test"
#    And new pool requests are deleted new schema

    Given a bureau owned pool is created with jurors
      | court  |juror_number  	| pool_number	   | att_date_weeks_in_future	| owner |
      | 415    |<juror_number>  | <pool_number>    | 5				            | 400	|

    And a digital summons reply has been entered for the summoned juror "<juror_number>" new schema
    And a new active pool is inserted for court "774" new schema
    And I log in as "<user>"
    When I navigate to the pool request screen
    And I click on active pools

    And I navigate to the pool search screen
    When I enter the pool number "<pool_number>" on the pool search screen
    And I search for the pool
    Then the pool is displayed
    And I click on the "<juror_number>" link

#    Reassign from juror record
    When I click the update juror record button
    And I click the reassign to another pool radio button
    And I press the "Continue" button
    Then I see "Active pools at Chester (415)" on the page
#    Change court
    When I click on the "Change court" link
    Then I see "Select a court to reassign to" on the page
    When I set input field with "ID" of "courtNameOrLocation" to "774"
    And I click on the "Welshpool (774)" link
    And I press the "Continue" button

    Then I see "Choose a pool to reassign to" on the page
    And I see "Active pools at Welshpool (774)" on the page
    And I see the reassign active pools table
    When I select pool "774222222" from the active pools table
    And I press the "Continue" button
    Then I see "Reassigned to pool 774222222" on the page
    And the juror record pool number has updated to "774222222"
    And the juror record court name has updated to "The Crown Court At Welshpool"

    Examples:
      | user          | juror_number   | pool_number   |
      | MODTESTBUREAU | 041531086      | 415304677     |

  @JurorTransformation @NewSchemaConverted
  Scenario Outline: Reassign a juror to a pool at the same court - Bureau User

    Given I am on "Bureau" "ithc"
    Given a bureau owned pool is created with jurors
      | court  |juror_number  	| pool_number	   | att_date_weeks_in_future	| owner |
      | 415    |<juror_number>  | <pool_number>    | 5				            | 400	|

    And a digital summons reply has been entered for the summoned juror "<juror_number>" new schema
    And I log in as "<user>"
    When I navigate to the pool request screen
    And I click on active pools

    And I navigate to the pool search screen
    When I enter the pool number "<pool_number>" on the pool search screen
    And I search for the pool
    Then the pool is displayed
    And I click on the "<juror_number>" link

    #Reassign from juror record
    When I click the update juror record button
    And I click the reassign to another pool radio button
    And I press the "Continue" button
    Then I see "Active pools at Chester (415)" on the page
    And I see "Choose a pool to reassign to" on the page
    And I see the reassign active pools table
    And I select one of the active pools available
    And I press the "Continue" button
    Then I see "Reassigned to pool" on the page
    And I confirm I have reassigned my juror in pool "<pool_number>" to another pool

    Examples:
      | user          | juror_number   | pool_number   |
      | MODTESTBUREAU | 041531088      | 415304177     |

  @JurorTransformation @NewSchemaConverted
  Scenario Outline: Reassign a juror to a pool - Bureau User - Errors

    Given I am on "Bureau" "ithc"
    Given a bureau owned pool is created with jurors
      | court  |juror_number  	| pool_number	   | att_date_weeks_in_future	| owner |
      | 415    |<juror_number>  | <pool_number>    | 5				            | 400	|

    And a digital summons reply has been entered for the summoned juror "<juror_number>" new schema
    And I log in as "<user>"
    When I navigate to the pool request screen
    And I click on active pools

    And I navigate to the pool search screen
    When I enter the pool number "<pool_number>" on the pool search screen
    And I search for the pool
    Then the pool is displayed
    And I click on the "<juror_number>" link

    #Reassign from juror record
    When I click the update juror record button
    
    #Do not select reassign juror
    And I press the "Continue" button
    Then I see "Select how you want to update the juror record" on the page

    When I click the reassign to another pool radio button
    And I press the "Continue" button
    Then I see "Active pools at Chester (415)" on the page
    When I click on the "Change court" link
    Then I see "Select a court to reassign to" on the page

    #Do not select a court
    When I press the "Continue" button
    Then I see "Enter a court name or location code" on the page

    When I set input field with "ID" of "courtNameOrLocation" to "774"
    And I click on the "Welshpool (774)" link
    And I press the "Continue" button

    Then I see "Choose a pool to reassign to" on the page
    And I see "Active pools at Welshpool (774)" on the page
    And I see the reassign active pools table

    #Do not select an active pool
    And I press the "Continue" button
    Then I see "Choose an active pool to add selected jurors to" on the page

    Examples:
      | user          | juror_number   | pool_number   |
      | MODTESTBUREAU | 041531071      | 415334177     |