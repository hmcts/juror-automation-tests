Feature: JS-159 Suummons reminders history entries

  @JurorTransformationMulti
  Scenario Outline: JS-159 Suummons reminders history entries

    Given I am on "Bureau" "ithc"
    And I log in as "<user>"

    When I navigate to the pool request screen

    When I press the "Create pool" button
    And I set the radio button to "Request new pool"
    And I press the "Continue" button
    Then I see "Select a court for this pool" on the page

    #select court
    Then I set input field with "ID" of "courtNameOrLocation" to "415"
    And I select the "Chester (415)" court selection link
    Then I press the "Continue" button

    #complete new pool fields
    Then I click the change link for the court deferrals
    Then I change the number of court deferrals to "0"

    Then I set the radio button to "High"
    And I set "Number of jurors required in total" to "5"
    Then I press the "Continue" button

    #Can submit the new pool request
    When I save the new pool request

    And I navigate to the pool search screen
    When I enter the pool number of the pool I have just created on the pool search screen
    And I press the "Continue" button
    And I press the "Summon jurors" button
    And I set "Citizens to summon" to "5"
    And I press the "Create pool and summon citizens" button
    And I see "Active pools" on the page

    #Send summons reminder
    And I press the "Apps" button
    And I click on the "Documents" link
    And I click on the "Summons reminder" link
    And I set the radio button to "Pool"
    And I search for the pool I have just created to issue summons reminders
    And I press the "Search" button
    Then I check the select all checkbox
    And I press the "Send summons reminder" button
    And I see "5 documents sent for printing" on the page

    When I press the "Apps" button
    And I click on the "Pool management" link
    And I click on the "Search" link
    When I enter the pool number of the pool I have just created on the pool search screen
    And I press the "Continue" button
    And I click on the "History" link

    Then I see "Number of Reminders Sent by MODTESTBUREAU" on the page

    When I click on the "Jurors" link
    And I select the first juror in the search results
    And I click on the "History" link

    And I see history item "Summons reminder letter issued" created by "MODTESTBUREAU"
    And I see "Reminder letter printed" on the page

    Examples:
      | user          |
      | MODTESTBUREAU |