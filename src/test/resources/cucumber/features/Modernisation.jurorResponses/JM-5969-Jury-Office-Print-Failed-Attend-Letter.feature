Feature: As a jury officer I need to be able to print a failed to attend letter

  @JurorTransformationMulti @NewSchemaConverted
  Scenario Outline:Verify jury officer able to print a failed to attend letter

    Given I am on "Bureau" "test"
    When a bureau owned pool is created with jurors
      | court |juror_number       | pool_number      | att_date_weeks_in_future | owner |
      | 415   |<juror_number>         | <pool_number>     | 5                         | 400  |

    And a new pool is inserted for where record has transferred to the court new schema
      |part_no               | pool_no           | owner |
      |<juror_number>       | <pool_number>      | 415   |

    #log on and search for juror
    And I log in as "<user>"

    #put juror in state to have their attendance status set
    When the user searches for juror record "<juror_number>" from the global search bar
    And I record a happy path paper summons response
    And I click on the "No, skip and process later" link
    When the user searches for juror record "<juror_number>" from the global search bar
    Then I click the summons reply tab
    And I click on the view summons reply link
    And I press the "Process reply" button
    And I see "How do you want to process this reply?" on the page
    And I set the radio button to "Mark as responded"
    And I press the "Continue" button
    And I see "Mark as responded" on the page
    And I check the "Mark juror as 'responded'" checkbox
    And I press the "Confirm" button

    #mark as failed to attend/error checks
    When the user searches for juror record "<juror_number>" from the global search bar
    And I press the "Update juror record" button
    And I press the "Continue" button
    And I see error "Select how you want to update the juror record"
    And I set the radio button to "Change juror status to ‘Failed to attend’"
    And I press the "Continue" button
    And I see "This will complete their service and they will not be expected at court again" on the page
    And I press the "Change status to ‘Failed to attend’" button
    And I see "You must tick the box if you want to change this juror’s status to ‘Failed to attend’" in the error banner
    And I check the failed to attend checkbox
    And I press the "Change status to ‘Failed to attend’" button
    And I see the juror record updated banner containing "Failed to attend"
    And I see the juror status has updated to "Failed to attend"

    Examples:
      | juror_number  | pool_number | user          |
      |  041530028    |415300305    | MODTESTCOURT   |

