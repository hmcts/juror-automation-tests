Feature: JM-3899

  @JurorTransformationMulti @NewSchemaConverted
  Scenario Outline: Decline Deferral Request for Paper Response as Bureau user - Juror Record View

    Given I am on "Bureau" "test"

    Given the juror numbers have not been processed new schema
      |part_no   | pool_no   | owner       |
      |<part_no> | <pool_no> | 400         |

    And I log in as "<user>"

    When the user searches for juror record "<juror_number>" from the global search bar

    #record paper summons response requesting deferral
    And I record a happy path deferral paper summons response

    Then the view summons reply page is displayed

    And I see the reply "status" on the response is "TO DO"
    And I see the reply "type" on the response is "DEFERRAL"

    Then I click on the "View juror's record" link
    And I click the update juror record button
    And I set the radio button to "Deferral - grant or refuse"
    Then I click continue on the update juror record screen
    And I select "O - OTHER" from the "Reason for the deferral request" dropdown
    And I set the radio button to "Refuse deferral"
    And I press the "Continue" button
    And I see "Deferral refused (other)" on the page

    Examples:
      |part_no	|pool_no 	|user          |
      |641500455|415170402 	|MODTESTBUREAU |
