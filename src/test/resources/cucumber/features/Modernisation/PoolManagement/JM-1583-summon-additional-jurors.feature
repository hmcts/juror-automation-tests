Feature: JM-1583 Summon Additional Jurors

  @JurorTransformationMulti
  Scenario: Happy path to summon an additional juror for an active pool

    Given I am on "Bureau" "ithc"

    And I log in as "MODTESTBUREAU"

    #create pool request
    And I press the "Apps" button
    And I click on the "Pool management" link

    And I click on active pools
    Then I see the following active pools headers
      | Pool number        |
      | Jurors requested   |
      | Jurors confirmed   |
      | Court name         |
      | Pool type          |
      | Service start date |

    And I click on the "Pool requests" link
    And I create a "Civil" court pool request for court "415", "10" weeks in the future
    Then I select the pool that I have just created to move to the pool summary page
    And I press the "Summon jurors" button
    And I set "Citizens to summon" to "10"
    And I press the "Create pool and summon citizens" button
    And I see "Active pools" on the page
    Then I select the pool that I have just created to move to the pool summary page

    Then the system will display non-editable information on the pool summary screen
      |jurorsRequested|10 |
      |jurorsConfirmed|0|
      |jurorsSummoned|10|
      |currentPoolSize|0 /10|
      |courtName|Chester|
      |courtLocationCode|415|
      |courtStartDate||
      |additionalRequirements||

    And I click on the "Jurors" link
    And I press the "Summon jurors" button
    And I set "Extra citizens to summon" to "1"
    And I press the "Summon more citizens" button
    Then the system will display non-editable information on the pool summary screen
      |jurorsRequested|10|
      |jurorsConfirmed|0|
      |jurorsSummoned|11|
      |currentPoolSize|0 /10|
      |courtName|Chester|
      |courtLocationCode|415|
      |courtStartDate||
      |additionalRequirements||
    Then I click on the "Juror number" link
    Then The "11" new jurors have been sent a summons letter new schema

  @JurorTransformationMulti
  Scenario: Negative testing for summoning more citizens errors

    Given I am on "Bureau" "demo"

    And I log in as "MODTESTBUREAU"

    #create pool request
    And I press the "Apps" button
    And I click on the "Pool management" link

    And I click on active pools
    Then I see the following active pools headers
      | Pool number        |
      | Jurors requested   |
      | Jurors confirmed   |
      | Court name         |
      | Pool type          |
      | Service start date |

    And I click on the "Pool requests" link
    And I create a "Civil" court pool request for court "415", "10" weeks in the future
    Then I select the pool that I have just created to move to the pool summary page
    And I press the "Summon jurors" button
    And I set "Citizens to summon" to "10"
    And I press the "Create pool and summon citizens" button
    And I see "Active pools" on the page
    Then I select the pool that I have just created to move to the pool summary page

    Then the system will display non-editable information on the pool summary screen
      |jurorsRequested|10|
      |jurorsConfirmed|0|
      |jurorsSummoned|10|
      |currentPoolSize|0 /10|
      |courtName|Chester|
      |courtLocationCode|415|
      |courtStartDate||
      |additionalRequirements||

    And I click on the "Jurors" link
    And I press the "Summon jurors" button
    Then The system shall display the following non editable details on the additional summons screen
      |poolNumber      |         |
      |jurorsRequested |10       |
      |jurorsConfirmed |0        |
      |jurorsRequired  |10       |
      |citizensSummoned|10       |
      |catchmentArea   |415      |

    #Empty field
    When I press the "Summon more citizens" button
    Then there is an error message with the text "Number of citizens to summon is missing" on the additional summons page
    #Invalid number
    When I set extra citizens to summon to "-5"
    And I press the "Summon more citizens" button
    Then there is an error message with the text "Number of citizens to summon is wrong" on the additional summons page
    #Number too high
    When I set extra citizens to summon to "10000"
    And I press the "Summon more citizens" button
    Then there is an error message with the text "The number of citizens summoned is too high and exceeds the yield" on the additional summons page
    #No postcodes selected
    When I set extra citizens to summon to "1"
    And I click all postcode checkboxes
    And I press the "Summon more citizens" button
    Then there is an error message with the text "Postcodes to summon from is missing" on the additional summons page
    #Changing catchment area
    When I click the change catchment area link
    And I set input field with "ID" of "courtNameOrLocation" to "417"
    And I click on the "Coventry (417)" link
    Then I press the "Continue" button
    Then The system shall display the following non editable details on the additional summons screen
      |poolNumber      |         |
      |jurorsRequested |10       |
      |jurorsConfirmed |0        |
      |jurorsRequired  |10       |
      |citizensSummoned|10       |
      |catchmentArea   |417      |