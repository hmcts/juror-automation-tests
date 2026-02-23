Feature: JS-727

  @JurorTransformation
  Scenario Outline: Login to JUROR ER

    Given I am on "Er" "test"
    And I log in to ER as "<user>"

    And I see "Electoral register data portal" on the page
    And I see "Data upload" on the page
    And I see "Upload guidance" on the page
    And I see "Account access" on the page

    And I click on the "Account access" link
    And I see "Users with portal access" on the page

    Examples:
      | user                       |
      | test_user1@localauthority1 |

  Scenario Outline: Login to JUROR ER - unhappy path

    Given I am on "Er" "test"
    And I log in to ER as "<user>"
    And I see error "No account found for the provided email address"

    Examples:
      | user              |
      | testing@email.com |