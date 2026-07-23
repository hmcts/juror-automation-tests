Feature: JS-986 Add SJO to User Results Table

  @JurorTransformation @SystemAdmin
  Scenario Outline: Add SJO to User Results Table

    Given I am on "Bureau" "<environment>"

    When I log in as "<user>"

    Then I see "System administration" on the page
    And I see "Users" on the page
    And I see "Search for a user" on the page

    When I choose the "All users" radio button

    And I see "AutomationStaffTWO" on the page

    Then I see "ARAMIS1" has status: "Active"
    Then I see "AutomationStaffTWO" has status: "Inactive"

#    And I see "Inactive" in the same row as "AutomationStaffTWO"

    When I choose the "Active users" radio button
    
    And I see "ARAMIS1" is marked as Manager user "No"
    And I see "ARAMIS1" is marked as SJO user "No"

    And I see "CARDIFF SJO MANAGER" is marked as Manager user "Yes"
    And I see "CARDIFF SJO MANAGER" is marked as SJO user "Yes"

    And I see "CARDIFF SJO" is marked as Manager user "No"
    And I see "CARDIFF SJO" is marked as SJO user "Yes"

    And I see "CARDIFF MANAGER" is marked as Manager user "Yes"
    And I see "CARDIFF MANAGER" is marked as SJO user "No"
    
    When I click on the "Advanced search" link
    Then I see "User roles" on the page

    When I check the "Manager" checkbox
    And I check the "Senior Jury Officer" checkbox
    Then "Manager" is checked
    And "Senior Jury Officer" is checked
    
    When I press the "Search" button
    Then I do not see "ARAMIS1" on the page
    And I see "CARDIFF SJO MANAGER" on the page
    And I see "CARDIFF SJO" on the page
    And I see "CARDIFF MANAGER" on the page

    Examples:
      | user         | environment |
      | SYSTEMADMIN  | ithc        |