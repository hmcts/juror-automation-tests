Feature: JM-3900

  @JurorTransformationWIP @JurorDigitalNotConverted @NewSchemaConverted
  Scenario Outline: Decline Deferral Request for Digital Response as Bureau user - Juror Record View

    Given I am on "Public" "test"

    Given the juror numbers have not been processed new schema
      | part_no   | pool_no   | owner |
      | <part_no> | <pool_no> | 400   |

    And juror "<juror_number>" has "LAST_NAME" as "<last_name>" new schema

    And juror "<juror_number>" has "POSTCODE" as "<postcode>" new schema

    And I record a digital response for a juror with a deferral
      | jurorNumber   | <part_no>  |
      | jurorLname    | <last_name>|
      | jurorPostcode | <postcode> |

    Given I am on "Bureau" "test"
    And I log in as "MODTESTBUREAU"
    When the user searches for juror record "<part_no>" from the global search bar
    Then I am on the Juror Record for juror "<part_no>"
    And I click on the "Summons reply" link
    And I click on the "View summons reply" link
    And I click the process reply button
    Then I select deferral request
    And I click continue on the juror summons reply page

    Then I select "O - OTHER" from the "Reason for the deferral request" dropdown
    Then I select to Choose a different date
    Then I set the "alternate" choice to "41" Mondays in the future
    And I press the "Continue" button

    Then I see "There are no active pools for this date" on the page
    And I press the "Put in deferral maintenance" button

    Then I click the link for the juror record
    And I see the juror status on the juror record screen has updated to "Deferred"

    And I click the update juror record button
    And I set the radio button to "Deferral - grant or refuse"
    Then I click continue on the update juror record screen
    And I select "O - OTHER" from the "Reason for the deferral request" dropdown
    And I set the radio button to "Refuse deferral"
    And I press the "Continue" button
    And I see "Deferral refused (other)" on the page
    And I see the number of deferrals is "1"
    And the warning icon is displayed next to the juror status

    Examples:
      | part_no   | pool_no   | last_name         | postcode |
      | 641500365 | 415170402 | LNAMETHREESIXFIVE | CH1 2AN  |