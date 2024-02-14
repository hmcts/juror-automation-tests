Feature: JM-4494 Jury officer Delete Juror Deferral

  @JurorTransformationMulti
  Scenario Outline: Jury Officer Delete Juror deferral - paper
    Given I am on "Bureau" "test"

    Given the juror numbers have not been processed new schema
      |part_no   | pool_no   | owner |
      |<part_no> | <pool_no> | 400   |


    And "<part_no>" has "NEXT_DATE" as "5 mondays time" new schema

    Then a new pool is inserted for where record has transferred to the court new schema
      |part_no   | pool_no   | owner |
      |<part_no> | <pool_no> | 415   |

    Given I log in as "MODTESTCOURT"
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
    When I select to Choose a different date
    Then I set the "alternate" choice to "45" Mondays in the future
    And I press the "Continue" button

    Then I see "There are no active pools for this date" on the page
    And I press the "Put in deferral maintenance" button

    And I do not see "Sorry, there is a technical problem" on the page

    When the user searches for juror record "<part_no>" from the global search bar
    And I see the juror status on the juror record screen is "Deferred"
    And I see the number of deferrals is "1"
    And I see under pool details the pool number is "In deferral maintenance"
    And I click the change link for the juror deferral
    Then I press the "Delete deferral" button
    And I see "Juror record updated: Responded" on the page
    And I see the juror status on the juror record screen is "Responded"

    Examples:
      | part_no		| pool_no	|
      |641500371	|415170402	|