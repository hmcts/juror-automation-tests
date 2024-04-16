Feature: As a system administrator, I want to view a list of bank holidays

  @JurorTransformationMulti @NewSchemaConverted
  Scenario Outline: Verify system administrator can able to view the list of bank holiday

    Given I am on "Bureau" "test"
    When I log in as "<user>"
    And I clear the bank holiday table data in the database
    And I create a bank holiday "6" weeks in the future for court/bureau "<courtCode>" and display on screen
    And I click on the "Bank holidays" link
    And I see the bank holiday "6" weeks in the future in the admin screen
    Then I do not see "2024" on the page

    Examples:
      | user         |courtCode|
      | SYSTEMADMIN  |415      |
