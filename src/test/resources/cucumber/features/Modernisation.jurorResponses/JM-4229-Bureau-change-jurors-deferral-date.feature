Feature: Bureau change jurors deferral date

  @JurorTransformationMulti
  Scenario Outline: Change jurors deferral date

    Given I am on "Public" "test"

    Given the juror numbers have not been processed new schema
      |part_no   | pool_no   | owner |
      |<part_no> | <pool_no> | 400   |


    And "<part_no>" has "NEXT_DATE" as "5 mondays time" new schema

    And I record a digital response for a juror with a deferral new schema
      |jurorNumber   | <part_no>  |
      |jurorLname    | <last_name>|
      |jurorPostcode | <postcode> |

    Given I am on "Bureau" "test"
    Given I log in as "MODTESTBUREAU"
    Then I search for juror "<part_no>"
    And I click the summons reply tab
    And I click on the "View summons reply" link
    And I see the reply "type" on the response is "DEFERRAL"

    Then I click the process reply button
    Then I set the radio button to "Deferral request"
    And I click continue on the process reply page

    Then I select "O - OTHER" from the "Reason for the deferral request" dropdown
    Then I select to Choose a different date
    Then I set the "new" choice to "51" Mondays in the future
    And I press the "Continue" button

    Then I see "There are no active pools for this date" on the page
    And I press the "Put in deferral maintenance" button

    And I do not see "Sorry, there is a technical problem" on the page
    And I see "Deferral granted (other)" on the page

    Then I search for juror "<part_no>"
    And I see the juror status on the juror record screen is "Deferred"
    And I see the number of deferrals is "1"
    And I see under pool details the pool number is "In deferral maintenance"
    And I click the change link for the juror deferral
    And I set the "only" choice to "41" Mondays in the future
    And I press the "Save changes" button

    Then I see "There are no active pools for this date" on the page
    And I press the "Put in deferral maintenance" button
    And I see "Juror record updated: Responded" on the page
    And I see Deferred to is "41" Mondays in the future

    Examples:
      |part_no		|pool_no  |last_name        |postcode	|
      |641500048	|415170402|LNAMEFOUREIGHT	|CH1 2AN	|