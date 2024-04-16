Feature: As a system administrator, I want to view a list of bank holidays

  @JurorTransformationMulti @NewSchemaConverted
  Scenario Outline: Verify system administrator can able to view the list of bank holiday

    Given I am on "Bureau" "test"
    When I log in as "<user>"
    And I clear the bank holiday table data in the database
    And I add the bank holiday for the year 2024 in the database
    And I add the bank holiday for the year 2025 in the database
    And I click on the "Bank holidays" link
    Then I see the following details on bank holiday for the year 2024

      | Friday 28 March       | Good Friday           |
      | Monday 1 April	      | Easter Monday         |
      | Monday 6 May	      | Early May bank holiday|
      | Monday 27 May	      | Spring bank holiday   |
      | Monday 26 August	  | Summer bank holiday   |
      | Wednesday 25 December | Christmas Day         |
      | Thursday 26 December  | Boxing Day            |
    
    And I see the following details on bank holiday for the year 2025

      | Wednesday 1 January   | New years Day        |
      | Friday 18 April	      | Good Friday           |
      | Monday 21 April	      | Easter Monday         |
      | Monday 5 May	      | Early May bank holiday|
      | Monday 26 May	      | Spring bank holiday   |
      | August 25 Monday      | Summer bank holiday   |
      | Thursday 25 December | Christmas Day         |
      | Friday 26 December    | Boxing Day            |

    When I clear the bank holiday table data in the database
    And I click on the "Bank holidays" link
    Then I do not see "2024" on the page
    And I do not see "2025" on the page
    And I do not see "Friday 28 March" on the page
    And I do not see "New years Day" on the page

    Examples:
      | user         |
      | SYSTEMADMIN  |
