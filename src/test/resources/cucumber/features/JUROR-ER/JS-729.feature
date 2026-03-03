Feature: ELEC  JS-729

  @JurorEr
  Scenario Outline: As a local authority I want to be able to upload my data to the new Juror ER app

    Given I am on "Er" "test"

    Given all uploads for Local Authority "<localAuth>" are deleted new schema

    And I log in to ER as "<user>"

    Then the LA name on the ER upload screen is "<localAuth>"
    And I see "Electoral register data portal" on the page
    And I see link with text "Data upload"
    And I see link with text "Upload guidance"
    And I see link with text "Account access"
    And I check the deadline date shown on the LA upload screen matches the DB new schema
    And I check the days remaining shown on the LA upload screen is correct
    And the LA upload status on the ER upload screen is "Not uploaded"
    And I see "Upload a file" on the page
    And I see "Do not password protect the file." on the page
    And I see "Include all registered electors as of 1 December. Ensure all required fields are present and correctly formatted. File size must not exceed 100MB. Ensure character encoding is UTF-8 where applicable." on the page
    And I see "Choose a file" on the page
    And I see "No file chosen" on the page

    And I click on the "Account access" link
    And I see "Users with portal access" on the page
    
    Given I set ER deadline date to "yesterday" new schema

    When I click on the "Data upload" link

    Then I see "Update window is now closed" on the page
    And I see "The annual upload window for electoral register data has now closed. You are not able to upload files at this time." on the page
    And I see "The Jury Central Summoning Bureau will contact you when the next upload window opens. You will receive an email notification with details of the new deadline and upload period." on the page

    Given I set ER deadline date to "30 mondays time" new schema

    Examples:
      | user                       | localAuth  |
      | test_user1@localauthority2 | Broxtowe   |

