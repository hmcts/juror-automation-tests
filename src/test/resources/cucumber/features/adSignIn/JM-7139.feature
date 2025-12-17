@JurorTransformationMulti
Feature: JM-7139 - As a tester I want to be able to provide an email to sign into the application

  Scenario: Sign in as a Bureau user
    Given I am on "Bureau" "demo"
    And I log in as "MODTESTBUREAU"

    Then I see "Jury Central Summoning Bureau" on the page
    And I see "(400)" on the page
    And I see "Summons replies" on the page
    And I see "Your work" on the page

  Scenario: Sign in as a court user
    Given I am on "Bureau" "demo"
    And I log in as "MODCOURT" selecting court "415"

    Then I see "Chester" on the page
    And I see "(415)" on the page
    And I see "Notifications" on the page

  Scenario: Sign in as a court user to a specific court and be able to change to one of the satellite courts
    Given I am on "Bureau" "test"
    And I log in as "MODCOURT" selecting court "415"

    Then I see "Chester" on the page
    And I see "(415)" on the page

    Then I click the Change link to change the court
    And I change the court to "767"

    Then I see "Knutsford" on the page
    And I see "(767)" on the page

  Scenario: Sign in as a court user to a satellite court and only be able to change to the owner court or another satellite
    #JM-7402 - bug raised
    Given I am on "Bureau" "test"
    And I log in as "MODCOURT" selecting court "415"

    Then I see "Chester" on the page
    And I see "(415)" on the page

    Then I click the Change link to change the court
    And I see "CHESTER (415)" on the page
    And I see "KNUTSFORD (767)" on the page
    And I see "WARRINGTON (462)" on the page

    And I do not see "Guildford SITTING AT CHICHESTER (416)" on the page

    And I do not see "MOLD (769)" on the page
    And I do not see "WELSHPOOL (774)" on the page

  Scenario: Sign in as a court user to a court with no satellites and need to re-log to change to another court
    Given I am on "Bureau" "test"
    And I log in as "MODCOURT" selecting court "416"

    Then I see "Guildford Sitting At Chichester" on the page
    And I see "(416)" on the page
    And I do not see the link to change the court