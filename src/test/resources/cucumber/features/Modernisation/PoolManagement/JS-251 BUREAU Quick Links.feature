Feature: JS-251

  @JurorTransformationMulti
  Scenario: Test Quick Links as Bureau user

    Given I am on "Bureau" "ithc"

    And I log in as "MODTESTBUREAU"

    And I click on the "HMCTS Juror" link

    And I see "Quick links" on the page
    And I see link with text "Your Work"
    And I see link with text "Summoning progress"
    And I see link with text "Deferral maintenance"
    And I see link with text "Active pools"
    And I see link with text "Yield performance"

    Then I click on the "Your Work" link
    And I see "/inbox" in the URL

    And I click on the "HMCTS Juror" link

    Then I click on the "Summoning progress" link
    And I see "/summoning-progress" in the URL

    And I click on the "HMCTS Juror" link

    Then I click on the "Deferral maintenance" link
    And I see "/deferral-maintenance" in the URL

    And I click on the "HMCTS Juror" link

    Then I click on the "Active pools" link
    And I see "/pool-management?status=created&tab=bureau" in the URL

    And I click on the "HMCTS Juror" link

    Then I click on the "Yield performance" link
    And I see "/yield-performance/dates" in the URL
