Feature: JM-5967 - As a jury officer I need to be able to print a show cause letter

  @JurorTransformation @NewSchemaConverted
  Scenario Outline: Create and Print a show cause letter - print via letter

    Given I am on "Bureau" "test"

    When a bureau owned pool is created with jurors
      | court   | juror_number    | pool_number   | att_date_weeks_in_future   | owner |
      | 415     | <juror_number>  | <pool_number> | 5                          | 400   |
      | 415     | <juror_number_2>| <pool_number> | 5                          | 400   |

    Then a new pool is inserted for where record has transferred to the court new schema
      |part_no              | pool_no           | owner |
      |<juror_number>       | <pool_number>     | 415   |
      |<juror_number_2>     | <pool_number>     | 415   |

    And I Confirm all the data in the record attendance table is cleared
    And I update juror "<juror_number>" to have a status of "Responded"
    And I update juror "<juror_number_2>" to have a status of "Responded"

    And I log in as "<user>"
    And I press the "Apps" button
    And I click on the "Juror management" link
    And I click on the "Record attendance" link
    And I set the radio button to "Check in"

    And I set "Hour" to "09"
    And I set "Minute" to "00"
    And I set the radio button to "am"
    And I input juror "<juror_number>" to be checked in
    And I press the "Check in juror" button
    And I see "<juror_number>" in the same row as "9:00am"

    And I set "Hour" to "09"
    And I set "Minute" to "00"
    And I set the radio button to "am"
    And I input juror "<juror_number_2>" to be checked in
    And I press the "Check in juror" button
    And I see "<juror_number_2>" in the same row as "9:00am"

    And I press the "Apps" button
    When I click on the "Documents" link
    And I click on the "Show cause letters" link

    And I press the "Continue" button
    And I see error "Enter a show cause hearing date"
    And I see error "Enter an hour for hearing time"
    And I see error "Select whether check out time is am or pm"

    Then I set the "Show cause" date to a Monday "-46" weeks in the future
    And I set "Hour" to "27"
    And I set "Minute" to "89"
    And I set the radio button to "pm"
    And I press the "Continue" button
    
    And I see error "Show cause hearing date cannot be today or in the past"
    And I see error "Enter an hour between 0 and 12"

    Then I set "Show cause hearing date" to "35/08/2024"
    And I press the "Continue" button
    And I see error "Enter a real date for the show cause hearing date"

    Then I set "Show cause hearing date" to "31/08!/2024!"
    And I press the "Continue" button
    And I see error "Hearing date must only include numbers and forward slashes"

    And I press the "Apps" button
    When I click on the "Documents" link
    And I click on the "Show cause letters" link

    Then I set the "Show cause" date to a Monday "12" weeks in the future
    And I set "Hour" to "9"
    And I set "Minute" to "00"
    And I set the radio button to "am"
    And I press the "Continue" button
    And I do not see "<juror_number>" on the page
    And I do not see "<juror_number_2>" on the page

    And I press the "Apps" button
    And I click on the "Documents" link
    And I update the appearance of juror "<juror_number>" for show cause letter
    And I update the appearance of juror "<juror_number_2>" for show cause letter
    And I click on the "Show cause letters" link
    And I set the "Show cause" date to a Monday "5" weeks in the future
    And I set "Hour" to "9"
    And I set "Minute" to "00"
    And I set the radio button to "am"
    And I press the "Continue" button

    And I see "Show cause letters" on the page
    And I see the absence date for juror "<juror_number>" in the letters table
    And I see the absence date for juror "<juror_number_2>" in the letters table

    And I check the "<juror_number>" checkbox
    And I check the "<juror_number_2>" checkbox
    And I press the "Print show cause letter" button
    Then I see "/documents/show-cause/letters-list" in the URL

    Examples:
      | juror_number  |juror_number_2  |pool_number | user          |
      |  041549526    | 041549527      |415991188   | MODTESTCOURT  |

  @JurorTransformation @NewSchemaConverted
  Scenario Outline: Create and Print a show cause letter from the juror record under the attendance tab

    Given I am on "Bureau" "test"
    When a bureau owned pool is created with jurors
      | court |juror_number       | pool_number      | att_date_weeks_in_future | owner |
      | 415   |<juror_number>     | <pool_number>    | 5                        | 400  |

    And a new pool is inserted for where record has transferred to the court new schema
      |part_no              | pool_no           | owner |
      |<juror_number>       | <pool_number>     | 415   |
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
    When I click on the "Print show cause letter" link
    And I set the "Show cause" date to a Monday "10" weeks in the future
    And I set "Hour" to "9"
    And I set "Minute" to "00"
    And I set the radio button to "pm"
    And I press the "Continue" button
    And I focus page to the new tab
    Then I see "/documents/show-cause/letters-list" in the URL

    Examples:
      | juror_number   |pool_number | user          |
      |  041549522     |415991190   | MODTESTCOURT  |