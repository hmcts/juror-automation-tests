Feature: JM-3989 JM-3993

  @JurorTransformation @NewSchemaConverted @JM-7664
  Scenario: Reassign a juror to a pool for a different court - Bureau User
    Given I am on "Bureau" "test"
#    And new pool requests are deleted new schema
    And the new pool for court "415" is deleted new schema
    And the new pool for court "774" is deleted new schema
    And the voter record for "941599999" is deleted new schema
    And the voter record for "941599998" is deleted new schema
    And a new active pool is inserted for court "415" new schema
    And jurors are inserted into active pool "415" new schema
    And a new active pool is inserted for court "774" new schema
    And a digital summons reply has been entered for the summoned juror "941599999" new schema
    And I log in as "MODTESTBUREAU"
    When I navigate to the pool request screen
    And I click on active pools

    And I navigate to the pool search screen
    When I enter the pool number "415222222" on the pool search screen
    And I search for the pool
    Then the pool is displayed
    And I click on the "941599999" link

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

  @JurorTransformation @NewSchemaConverted
  Scenario: Reassign a juror to a pool at the same court - Bureau User

    Given I am on "Bureau" "test"
    And the new pool for court "415" is deleted new schema
    And the voter record for "941599999" is deleted new schema
    And the voter record for "941599998" is deleted new schema
    And two new active pool's are inserted for court "415" new schema
    And jurors are inserted into active pool "415" new schema
    And a digital summons reply has been entered for the summoned juror "941599999" new schema
    And I log in as "MODTESTBUREAU"

    When I navigate to the pool request screen
    And I click on active pools
    When I navigate to the active pool "415222222" overview
    And I click on the "941599999" link

    #Reassign from juror record
    When I click the update juror record button
    And I click the reassign to another pool radio button
    And I press the "Continue" button
    Then I see "Active pools at Chester (415)" on the page
    And I see "Choose a pool to reassign to" on the page
    And I see the reassign active pools table
    When I select pool "415333333" from the active pools table
    And I press the "Continue" button
    Then I see "Reassigned to pool 415333333" on the page
    And the juror record pool number has updated to "415333333"

  @JurorTransformation @NewSchemaConverted
  Scenario: Reassign a juror to a pool - Bureau User - Errors

    Given I am on "Bureau" "test"

    Given the new pool for court "415" is deleted new schema
    Given the new pool for court "774" is deleted new schema
    Given the voter record for "941599999" is deleted new schema
    Given the voter record for "941599998" is deleted new schema
    Given a new active pool is inserted for court "415" new schema
    Given jurors are inserted into active pool "415" new schema
    Given a new active pool is inserted for court "774" new schema
    Given a digital summons reply has been entered for the summoned juror "941599999" new schema

    And I log in as "MODTESTBUREAU"
    When I navigate to the pool request screen
    And I click on active pools
    When I navigate to the active pool "415222222" overview
    And I click on the "941599999" link

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