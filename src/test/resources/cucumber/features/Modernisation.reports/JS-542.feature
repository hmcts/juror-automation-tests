Feature: JS-542

  @JurorTransformation
  Scenario: Check Digital summons received report

    Given I am on "Bureau" "ithc"

    Given paper responses are deleted new schema
    
    And a digital summons reply has been entered for the summoned juror "564138536" new schema

    When I log in as "MODTESTBUREAU"
    And I click on the "Apps" link
    And I click on the "Reporting" link
    And I see "Team lead reports" on the page
    And I see link with text "Digital summons received report"
    
    And I click on the "Digital summons received report" link
    And I see "reporting/digital-summons-received" in the URL
    Then I see "Select month to view digital summons received for" on the page

    And I press the "Continue" button
    Then I see "digital-summons-received/report/" in the URL
    And I see "Total number of replies received" on the page
    And I see "Report created" on the page
    And I see "Time created" on the page
    And Digital summons received report shows total number of replies received is "1"

    #jenkins cant run this bit
#    And I press the "Print" button
#    And I focus page to the new tab
#    Then I see "/print" in the URL
#    Then I close the browser tab

    #dont see report as standard user
    Given I am on "Bureau" "ithc"
    When I log in as "TeamPickListUser"
    And I click on the "Apps" link
    And I click on the "Reporting" link
    And I do not see "Team lead reports" on the page
    And I do not see link with text "Digital summons received report"


