Feature: JS-727

  @JurorEr
  Scenario Outline: Login to JUROR ER

    Given I am on "Er" "ithc"
    And I log in to ER as "<user>"
    
    Then I see "/data-upload" in the URL
    
    And I click on the "Sign out" link

    And I log in to ER as "<userUpper>"

    Then I see "/data-upload" in the URL

    And I click on the "Sign out" link

    And I log in to ER as "<userMixed>"

    Then I see "/data-upload" in the URL

    And I see "Electoral register data portal" on the page
    And I see "Data upload" on the page
    And I see "Upload guidance" on the page
    And I see "Account access" on the page

    And I click on the "Account access" link
    And I see "Users with portal access" on the page

    Examples:
      | user                       | userUpper                  | userMixed                  |
      | test_user1@localauthority1 | TEST_USER1@LOCALAUTHORITY1 | Test_User1@LocalAuthority1 |

 @JurorEr
  Scenario Outline: Login to JUROR ER - unhappy path

    Given I am on "Er" "test"
    And I log in to ER as "<user>"
    And I see error "Unable to sign in with the provided email address"

    Examples:
      | user              |
      | testing@email.com |
