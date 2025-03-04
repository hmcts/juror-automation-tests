Feature: As a jury officer I need to be able to print a failed to attend letter

  @JurorTransformation
  Scenario Outline:Verify jury officer able to print a failed to attend letter

    Given I am on "Bureau" "ithc"

    When a bureau owned pool is created with jurors
      | court | juror_number   | pool_number      | att_date_weeks_in_future | owner |
      | 415   | <juror_number> | <pool_number>    | 5                         | 400  |

    And a new pool is inserted for where record has transferred to the court new schema
      | part_no          | pool_no         | owner |
      | <juror_number>   | <pool_number>   | 415   |

    Then I Confirm all the data in the record attendance table is cleared

    #log on and search for juror
    And I update juror "<juror_number>" to have confirm attendance date as todays date
    And I log in as "<user>"
    And I update juror "<juror_number>" to have a status of responded in order to record attendance
    And I press the "Apps" button
    And I click on the "Juror management" link
    And I click on the "Record attendance" link
    And I press the "Confirm attendance" button
    And I press the "Confirm attendance list is correct" button
    And I update pool number "<pool_number>" on the appearance table for the "<juror_number>"
    And I press the "Apps" button
    And I click on the "Documents" link
    When I click on the "Failed to attend letters" link
    And I check the juror "<juror_number>" checkbox
    And I press the "Print failed to attend letter" button
    Then I see "documents/failed-to-attend/letters-list" in the URL

    Examples:
      | juror_number  | pool_number | user           |
      | 041530039     | 415300355   | MODTESTCOURT   |

  @JurorTransformation
  Scenario Outline:Verify jury officer able to print the failed to attend letter from the juror record under the attendance tab.

    Given I am on "Bureau" "ithc"

    When a bureau owned pool is created with jurors
      | court | juror_number    | pool_number      | att_date_weeks_in_future | owner |
      | 415   | <juror_number>  | <pool_number>    | 5                        | 400  |

    And a new pool is inserted for where record has transferred to the court new schema
      |part_no               | pool_no           | owner |
      |<juror_number>       | <pool_number>      | 415   |
    And I Confirm all the data in the record attendance table is cleared
    #log on and search for juror
    And I update juror "<juror_number>" to have confirm attendance date as todays date
    And I log in as "<user>"
    And I update juror "<juror_number>" to have a status of responded in order to record attendance
    And I press the "Apps" button
    And I click on the "Juror management" link
    And I click on the "Record attendance" link
    And I press the "Confirm attendance" button
    And I press the "Confirm attendance list is correct" button
    And I update pool number "<pool_number>" on the appearance table for the "<juror_number>"
    When the user searches for juror record "<juror_number>" from the global search bar
    And I click on the "Attendance" link
    Then I see Absence displayed as "1" on the attendance table
    When I click on the "Print FTA letter" link
    Then I see "Document sent for printing" on the page

    Examples:
      | juror_number  | pool_number | user           |
      |  041530040    |415300355    | MODTESTCOURT   |
