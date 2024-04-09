Feature: JM-6388 - As a jury officer I need to be able to manually add an attendance day

  @JurorTransformationMulti @NewSchemaConverted
  Scenario Outline: As a jury officer I want to manually add an attendance day - Happy Path

    Given I am on "Bureau" "test"
    When a bureau owned pool is created with jurors
      | court |juror_number  	    | pool_number	      | att_date_weeks_in_future	| owner |
      | 415   |<juror_number>       | <pool_number>       | 10				            | 400	|

    Then a new pool is inserted for where record has transferred to the court new schema
      |part_no              | pool_no             | owner |
      |<juror_number>       | <pool_number>       | 415   |

    Then I update juror "<juror_number>" to have a status of "Responded"

    And I log in as "<user>"
    When the user searches for juror record "<juror_number>" from the global search bar
    And I click on the "Attendance" link
    And I see "Attendance" on the page
    And I press the "Add attendance day" button
    And I see "Add an attendance day" on the page

    And I set the "Attendance Day" date to a Monday "-4" weeks in the future
    #check in on confirm attendance
    And I set juror check in hour to "9" on confirm attendance
    And I set juror check in minute to "20" on confirm attendance
    And I click on the am radio button for juror check in on confirm attendance

    #check out on confirm attendance
    And I set juror check out hour to "2" on confirm attendance
    And I set juror check out minute to "30" on confirm attendance
    And I click on the pm radio button for juror check out on confirm attendance
    And I press the "Add attendance day" button
    Then I see the date "-4" weeks from now in the same row as "Full day"
    And I see "1" in the same row as "Attendances"

    Examples:
      | user         | juror_number | pool_number  |
      | MODTESTCOURT | 041536964    | 415360964    |



  @JurorTransformationWIP @NewSchemaConverted @JM-6799
  Scenario Outline: As a jury officer I want to manually add an attendance day - Unhappy Path

    Given I am on "Bureau" "test"
    When a bureau owned pool is created with jurors
      | court |juror_number  	    | pool_number	      | att_date_weeks_in_future	| owner |
      | 415   |<juror_number>       | <pool_number>       | 5				            | 400	|

    Then a new pool is inserted for where record has transferred to the court new schema
      |part_no              | pool_no             | owner |
      |<juror_number>       | <pool_number>       | 415   |

    Then I update juror "<juror_number>" to have a status of "Responded"
    And I log in as "<user>"
    When the user searches for juror record "<juror_number>" from the global search bar
    And I click on the "Attendance" link
    And I see "Attendance" on the page
    And I press the "Add attendance day" button
    And I see "Add an attendance day" on the page
    And I press the "Add attendance day" button
    And I see error "Enter a date for the attendance day"
    And I see error "Enter a check out time"
    And I see error "Enter a check in time"

    And I set juror check in hour to "S" on confirm attendance
    And I set juror check in minute to "S" on confirm attendance
    And I click on the am radio button for juror check in on confirm attendance

    #check out on confirm attendance
    And I set juror check out hour to "T" on confirm attendance
    And I set juror check out minute to "T" on confirm attendance
    And I click on the pm radio button for juror check out on confirm attendance
    And I press the "Add attendance day" button

    And I see error "Check in time must only include numbers - you cannot enter letters or special characters"
    And I see error "Check out time must only include numbers - you cannot enter letters or special characters"

    #Then I clear date field
    And I press the "Add attendance day" button
    And I see error "Enter a date for the attendance day"

    Then I set "Enter attendance date" to "01/13/2024"
    And I press the "Add attendance day" button
    And I see error "Please enter a valid date for the attendance day"

    Then I set "Enter attendance date" to "2024/01/23"
    And I press the "Add attendance day" button
    And I see error "Enter an attendance date in the correct format, for example, 31/01/2023"
    Then I click on the "Cancel" link


    And I press the "Add attendance day" button
    And I set the "Attendance Day" date to a Monday "-8" weeks in the future

    #check in on confirm attendance
    And I set juror check in hour to "9" on confirm attendance
    And I set juror check in minute to "20" on confirm attendance
    And I click on the am radio button for juror check in on confirm attendance

    #check out on confirm attendance
    And I set juror check out hour to "2" on confirm attendance
    And I set juror check out minute to "30" on confirm attendance
    And I click on the pm radio button for juror check out on confirm attendance
    And I press the "Add attendance day" button
    And I see "Attendance date added" on the page
    Then I see the date "-8" weeks from now in the same row as "Full day"
    And I see "1" in the same row as "Attendances"

    And I press the "Add attendance day" button
    And I set the "Attendance Day" date to a Monday "-8" weeks in the future

    #check in on confirm attendance
    And I set juror check in hour to "9" on confirm attendance
    And I set juror check in minute to "20" on confirm attendance
    And I click on the am radio button for juror check in on confirm attendance

    #check out on confirm attendance
    And I set juror check out hour to "2" on confirm attendance
    And I set juror check out minute to "30" on confirm attendance
    And I click on the pm radio button for juror check out on confirm attendance
    And I press the "Add attendance day" button
    And I see "Juror 041536965 has already confirmed their attendance" in the error banner
    
    #attempt to enter attendance in future
    And I set the "Attendance Day" date to a Monday "45" weeks in the future
    #check in on confirm attendance
    And I set juror check in hour to "9" on confirm attendance
    And I set juror check in minute to "20" on confirm attendance
    And I click on the am radio button for juror check in on confirm attendance

    #check out on confirm attendance
    And I set juror check out hour to "2" on confirm attendance
    And I set juror check out minute to "30" on confirm attendance
    And I click on the pm radio button for juror check out on confirm attendance

    And I press the "Add attendance day" button
    #this will pass here, but shouldn't because of JM-6799 - shouldn't allow you to enter attendance date in future


    Examples:
      | user         | juror_number | pool_number  |
      | MODTESTCOURT | 041536965    | 415360964    |

  @JurorTransformationMulti @NewSchemaConverted
  Scenario Outline: As a jury officer I want to manually add an attendance day - Ineligible juror

    Given I am on "Bureau" "test"
    When a bureau owned pool is created with jurors
      | court |juror_number  	    | pool_number	      | att_date_weeks_in_future	| owner |
      | 415   |<juror_number>       | <pool_number>       | 5				            | 400	|

    Then a new pool is inserted for where record has transferred to the court new schema
      |part_no              | pool_no             | owner |
      |<juror_number>       | <pool_number>       | 415   |

    And I log in as "<user>"
    When the user searches for juror record "<juror_number>" from the global search bar
    And I click on the "Attendance" link
    And I see "Attendance" on the page
    And I press the "Add attendance day" button
    And I see "Add an attendance day" on the page

    And I set the "Attendance Day" date to a Monday "-8" weeks in the future
    And I set juror check in hour to "9" on confirm attendance
    And I set juror check in minute to "30" on confirm attendance
    And I click on the am radio button for juror check in on confirm attendance

    #check out on confirm attendance
    And I set juror check out hour to "2" on confirm attendance
    And I set juror check out minute to "45" on confirm attendance
    And I click on the pm radio button for juror check out on confirm attendance
    And I press the "Add attendance day" button
    And I see "Cannot check in or out a juror with an invalid status" in the error banner

    Then I update juror "<juror_number>" to have a status of "Responded"
    When the user searches for juror record "<juror_number>" from the global search bar
    And I click on the "Attendance" link
    And I see "Attendance" on the page
    And I press the "Add attendance day" button
    And I see "Add an attendance day" on the page

    And I set the "Attendance Day" date to a Monday "-8" weeks in the future
    And I set juror check in hour to "9" on confirm attendance
    And I set juror check in minute to "30" on confirm attendance
    And I click on the am radio button for juror check in on confirm attendance

    #check out on confirm attendance
    And I set juror check out hour to "2" on confirm attendance
    And I set juror check out minute to "45" on confirm attendance
    And I click on the pm radio button for juror check out on confirm attendance
    And I press the "Add attendance day" button
    And I see "1" in the same row as "Attendances"
    

    Examples:
      | user         | juror_number | pool_number  |
      | MODTESTCOURT | 041536966    | 415360964    |

