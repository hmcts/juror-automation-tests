Feature: JM-4494 Bureau Delete Juror Deferral

  @JurorTransformationMulti
  Scenario Outline: Delete Juror deferral - digital
    Given I am on "Public" "test"

    Given the juror numbers have not been processed new schema
      |part_no   | pool_no   | owner |
      |<part_no> | <pool_no> | 400   |


    And "<part_no>" has "NEXT_DATE" as "5 mondays time" new schema

    And I record a digital response for a juror with a deferral new schema
      |jurorNumber   | <part_no>>  |
      |jurorLname    | <last_name> |
      |jurorPostcode | <postcode>  |

    Given I am on "Bureau" "test"
    Given I log in as "MODTESTBUREAU"
    When the user searches for juror record "<part_no>" from the global search bar
    And I click the summons reply tab
    And I click on the "View summons reply" link
    And I see the reply "type" on the response is "DEFERRAL"

    Then I click the process reply button
    Then I set the radio button to "Deferral request"
    And I click continue on the process reply page

    Then I select "O - OTHER" from the "Reason for the deferral request" dropdown
    Then I select to Choose a different date
    Then I set the "alternate" choice to "51" Mondays in the future
    And I press the "Continue" button

    Then I see "There are no active pools for this date" on the page
    And I press the "Put in deferral maintenance" button

    And I do not see "Sorry, there is a technical problem" on the page
    And I see "Deferral granted (other)" on the page

    Then the user searches for juror record "<part_no>" from the global search bar
    And I see the juror status on the juror record screen is "Deferred"
    And I see the number of deferrals is "1"
    And I see under pool details the pool number is "In deferral maintenance"
    And I click the change link for the juror deferral
    Then I press the "Delete deferral" button
    And I see "Juror record updated: Responded" on the page
    And I see the juror status on the juror record screen is "Responded"

    Examples:
      |part_no	|last_name	  |postcode	|pool_no	|
      |641500020|LNAMETWOZERO |CH1 2AN	|415170402	|

  @JurorTransformationMulti
  Scenario Outline: Delete Juror deferral - paper
    Given I am on "Bureau" "test"

    Given the juror numbers have not been processed new schema
      |part_no   | pool_no   | owner |
      |<part_no> | <pool_no> | 400   |


    And "<part_no>" has "NEXT_DATE" as "5 mondays time" new schema
    And pool "<pool_no>" has attendance date as "5 mondays time"

    Given I log in as "MODTESTBUREAU"

    When the user searches for juror record "<part_no>" from the global search bar
    Then I record a happy path deferral paper summons response
    And I see the reply "type" on the response is "DEFERRAL"

    Then I click the process reply button
    Then I set the radio button to "Deferral request"
    And I click continue on the process reply page

    Then I set the "first" choice to "11" Mondays in the future
    Then I set the "second" choice to "12" Mondays in the future
    Then I set the "third" choice to "13" Mondays in the future
    And I click continue on the process reply page

    Then I select "O - OTHER" from the "Reason for the deferral request" dropdown
    Then I select to Choose a different date
    Then I set the "alternate" choice to "50" Mondays in the future
    And I press the "Continue" button

    Then I see "There are no active pools for this date" on the page
    And I press the "Put in deferral maintenance" button

    And I do not see "Sorry, there is a technical problem" on the page
    And I see "Deferral granted (other)" on the page

    Then the user searches for juror record "<part_no>" from the global search bar
    And I see the juror status on the juror record screen is "Deferred"
    And I see the number of deferrals is "1"
    And I see under pool details the pool number is "In deferral maintenance"
    And I click the change link for the juror deferral
    Then I press the "Delete deferral" button
    And I see "Juror record updated: Responded" on the page
    And I see the juror status on the juror record screen is "Responded"

    Examples:
      |part_no	|pool_no	|
      |641500817|415170501	|

  @JurorTransformationMulti
  Scenario Outline: Deferral sent to pool not valid for Delete Juror deferral
    Given I am on "Bureau" "test"

    Given the juror numbers have not been processed new schema
      |part_no   | pool_no   | owner |
      |<part_no> | <pool_no> | 400   |

    And "<part_no>" has "NEXT_DATE" as "7 mondays time"

    Given I log in as "MODTESTBUREAU"

    Given I navigate to the pool request screen
    Given I create an active "civil" court pool request for court "415", "14" Mondays in the future

    When the user searches for juror record "<part_no>" from the global search bar
    Then I record a happy path deferral paper summons response

    And I see the reply "type" on the response is "DEFERRAL"
    Then I click the process reply button
    Then I set the radio button to "Deferral request"
    And I click continue on the process reply page

    Then I set the "first" choice to "11" Mondays in the future
    Then I set the "second" choice to "12" Mondays in the future
    Then I set the "third" choice to "13" Mondays in the future
    And I click continue on the process reply page

    Then I select "O - OTHER" from the "Reason for the deferral request" dropdown
    Then I select to Choose a different date
    Then I set the "alternate" choice to "14" Mondays in the future
    And I press the "Continue" button

    Then I see "Select a pool for this date" on the page
    And I select the pool I created for the deferral
    And I press the "Continue" button

    And I do not see "Sorry, there is a technical problem" on the page
    And I see "Deferral granted (other)" on the page

    Then the user searches for juror record "<part_no>" from the global search bar
    And I see the juror status on the juror record screen is "Responded"
    And I see the number of deferrals is "1"
    And I do not see "In deferral maintenance" on the page

    Examples:
      |part_no	|pool_no	|
      |641500197|415170402	|
