Feature: JS-476

  @JurorTransformation
  Scenario Outline: Check monthly util stats report

    #chester
    Given I am on "Bureau" "ithc"
    When I log in as "<user>"
    And I click on the "Courts and bureau" link
    And I click the court home link for court "415"
    And I click on the "Prepare monthly utilisation report" link
    And I press the "Continue" button
    And I press the "Yes - prepare" button
    And I see "Monthly wastage and utilisation report" on the page

#    #swansea
    Given I am on "Bureau" "ithc"
    When I log in as "<user>"
    And I click on the "Courts and bureau" link
    And I click the court home link for court "457"
    And I click on the "Prepare monthly utilisation report" link
    And I press the "Continue" button
    And I press the "Yes - prepare" button
    And I see "Monthly wastage and utilisation report" on the page

#     #blackfriars
    Given I am on "Bureau" "ithc"
    When I log in as "<user>"
    And I click on the "Courts and bureau" link
    And I click the court home link for court "428"
    And I click on the "Prepare monthly utilisation report" link
    And I press the "Continue" button
    And I press the "Yes - prepare" button
    And I see "Monthly wastage and utilisation report" on the page


    Given I am on "Bureau" "ithc"
    When I log in as "<user>"
    And I click on the "Courts and bureau" link
    And I click the court home link for court "415"
    And I press the "Apps" button
    And I click on the "Reporting" link
    And I click on the "Statistics" link
    And I click on the "All court utilisation stats report" link
    And I set the radio button to "All courts"
    And I press the "Continue" button
    And I see the last run date for court "Chester (415)" is today
    And I see the last run date for court "Swansea Crown Court (457)" is today
    And I see the last run date for court "Blackfriars (428)" is today

    And I press the "Apps" button
    And I click on the "Reporting" link
    And I click on the "Statistics" link
    And I click on the "All court utilisation stats report" link
    And I set the radio button to "Specific court(s)"
    And I press the "Continue" button
    And I select the checkbox in reports for court "Chester (415)"
    And I press the "Continue" button
    And I see the last run date for court "Chester (415)" is today


    Examples:
      | user         |
      | SYSTEMADMIN  |

