
Feature: As a system administrator,I want to view a list of bank holidays

  @JurorTransformationMulti
  Scenario Outline: Verify system administrator can able to view the list of bank holiday

    Given I am on "Bureau" "ithc"
    When I log in as "<user>"

    And I clear the bank holiday table data in the database

    And I create a bank holiday "24" weeks in the future for court/bureau "<courtCode>" and display on screen
    And I create a bank holiday "6" weeks in the future for court/bureau "<courtCode>" and display on screen

    And I click on the "Bank holidays" link
    Then I see the bank holiday "6" weeks in the future on the admin screen
    And I see the bank holiday "24" weeks in the future on the admin screen
    And I clear the bank holiday table data in the database
    And I click on the "Bank holidays" link
    And I do not see "Date" on the page

    Examples:
      | user         |courtCode|
      | SYSTEMADMIN  |415      |

