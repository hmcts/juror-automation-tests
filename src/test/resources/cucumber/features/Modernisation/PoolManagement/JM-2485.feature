Feature: JM-2485

  @JurorTransformationMulti @NewSchemaConverted
  Scenario: Test to browse active pools as bureau
    Given I am on "Bureau" "test"

    And I log in as "MODTESTBUREAU"

    When I navigate to the pool request screen
    And I click on active pools
    Then I see the following active pools headers
      | Pool number        |
      | Jurors requested   |
      | Jurors confirmed   |
      | Court name         |
      | Pool type          |
      | Service start date |


  @JurorTransformationMulti
  Scenario: Test to browse active pools as court

    Given I am on "Bureau" "ithc"

    And I log in as "MODTESTCOURT"

    When I navigate to the pool request screen
    And I click on active pools
    And I click on the "With the Bureau" link

    Then I see the following active pools headers
      | Pool number        |
      | Jurors requested   |
      | Jurors confirmed   |
      | Court name         |
      | Pool type          |
      | Service start date |

    And the court name displayed is one of the following
      | Knutsford   |
      | Chester     |
      | Welshpool   |
      | Warrington  |