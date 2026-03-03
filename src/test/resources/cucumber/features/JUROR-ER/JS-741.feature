Feature: Send reminder to LA

@JurorEr
Scenario Outline: Send Reminders - Bulk
  
  Given I am on "Bureau" "test"

  Given all ER Local Authorities are set to active new schema

  And I log in as "<user>"

  And I press the "Apps" button
  And I click on the "Electoral register" link

  And I select the checkbox for Local Authority "West Oxfordshire"
  Then I click the Send Reminder button
  And I see "Are you sure you want to send a reminder to 1 local authority?" on the page
  And I click the yes send reminder button
  And I see the banner for sent reminder
  Then I check reminder has been sent to LA


  Examples:
    | user          |
    | MODTESTBUREAU |

  @JurorEr
  Scenario Outline: Send Reminders - Single

    Given I am on "Bureau" "test"

    Given all ER Local Authorities are set to active new schema

    And I log in as "<user>"

    And I press the "Apps" button
    And I click on the "Electoral register" link
    And I click on the "West Oxfordshire" link
    And I click on the "Send email reminder" link
    And I see "Are you sure you want to send an email reminder?" on the page
    And I click the yes send reminder button
    And I see "Email reminder sent." on the page
    Then I check reminder has been sent to LA

    Examples:
      | user          |
      | MODTESTBUREAU |

  @JurorEr
  Scenario Outline: Send Reminders - unhappy path

    Given I am on "Bureau" "test"

    Given all ER Local Authorities are set to active new schema

    And I log in as "<user>"

    And I press the "Apps" button
    And I click on the "Electoral register" link

    And I select the checkbox for Local Authority "West Oxfordshire"
    And I select the checkbox for Local Authority "Broadland"

    Then I click the Send Reminder button
    And I click the yes send reminder button
    And I see "Failed to send one or more reminder emails to Broadland." on the page

    Examples:
      | user          |
      | MODTESTBUREAU |