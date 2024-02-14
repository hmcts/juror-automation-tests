Feature: JM-5178

  @JurorTransformationMulti @NewSchemaConverted
  Scenario Outline: Place a juror on call as a jury officer - Attendance screen
    Given I am on "Bureau" "test"

    Given the juror numbers have not been processed new schema
      |part_no   | pool_no   | owner |
      |<part_no> | <pool_no> | 400   |

    Then a new pool is inserted for where record has transferred to the court new schema
      |part_no   | pool_no   | owner |
      |<part_no> | <pool_no> | 415   |

    And I log in as "<user>"
    When the user searches for juror record "<part_no>" from the global search bar
    And I record a happy path paper summons response and process now

    And I press the "Apps" button
    And I click on the "Juror management" link
    And I click on the "Record attendance" link
    And I click on the "Jurors in waiting" link
    And I set the radio button to "Check in"

    And I set "Hour" to "09"
    And I set "Minute" to "00"
    And I set the radio button to "am"
    And I input juror "<part_no>" to be checked in
    And I press the "Check in juror" button
    And I see "9:00am" in the same row as "<part_no>"

    When the user searches for juror record "<part_no>" from the global search bar
    And I click on the "Attendance" link
    And I click on the "Change" link
    And I see "When are they next due at court?" on the page
    And I press the "Save" button
    And I see error "Enter when the juror is next due at court or put the juror on call"
    And I check the "Put juror on call" checkbox
    And I press the "Save" button
    And I see "On call" in the same row as "Next due at court"

    Examples:
      |user			|part_no  | pool_no   |
      |MODTESTCOURT |141500444| 415180101 |

