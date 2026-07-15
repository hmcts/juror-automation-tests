Feature: JS-727

  @JurorEr
  Scenario Outline: Login to JUROR ER

    Given I am on "Er" "test"

    And I see link with text "Cookies"
    When I click on the "Cookies" link
    And I switch to the new window
    Then I see "Cookies" on the page
    And I see "/cookies" in the URL
    And I see "Cookies are small files saved on your phone, tablet or computer when you visit a website." on the page
    And I see "We use cookies to make the 'Electoral register data portal' service work securely." on the page
    And I see "Essential cookies" on the page
    And I see "Essential cookies keep your information secure while you use this service. We do not need to ask permission to use them." on the page
    And I see "Essential cookies we use" on the page
    And I see "juror_er_portal_session" on the page
    And I see "Keeps track of whether you're logged in or not" on the page
    And I see "_csrf" on the page
    And I see "Ensures website security by validating that requests are intentionally made by the legitimate user" on the page

    And I focus page to the original tab

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
