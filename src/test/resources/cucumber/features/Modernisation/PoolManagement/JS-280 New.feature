Feature: JS-280 Combined Tests

  Scenario Outline: Higher rate expenses for over 201 days attendance

    Given I am on "Bureau" "demo"

    When a bureau owned pool is created with jurors
      | court |juror_number     | pool_number	  | att_date_weeks_in_future  | owner |
      | 415   | <juror_number_1>| <pool_number>   | 1                         | 400   |

    Then a new pool is inserted for where record has transferred to the court new schema
      |part_no          | pool_no       | owner |
      |<juror_number_1> | <pool_number> | 415   |

    And I log in as "<user>"

    And I update juror "<juror_number_1>" to have a status of "Responded"

    Examples:
      | user         | pool_number   | juror_number_1  |
      | MODTESTCOURT | 415300183     | 041500167       |

  @JurorTransformation
  Scenario Outline: Check highest rate is applied for over 201 days

    Given I am on "Bureau" "ithc"
    When a bureau owned pool is created with jurors
      | court |juror_number  	  | pool_number	    | att_date_weeks_in_future	| owner |
      | 415   |<juror_number>     | <pool_number>   | 5				            | 400	|

    Then a new pool is inserted for where record has transferred to the court new schema
      |part_no            | pool_no           | owner |
      |<juror_number>     | <pool_number>     | 415   |

    And I Confirm all the data in the record attendance table is cleared
    And I update juror "<juror_number>" to have a status of "Responded"
    And I insert 200 appearance records for juror "<juror_number>" at a "415" court and pool number "<pool_number>"
    And I log in as "<user>"

    #add extra attendance days
    When the user searches for juror record "<juror_number>" from the global search bar
    And I click on the "Attendance" link
    And I press the "Add attendance day" button
    And I set the attendance date to 5 days in the past

    And I set juror check in hour to "9" on confirm attendance
    And I set juror check in minute to "30" on confirm attendance
    And I click on the am radio button for juror check in on confirm attendance

    And I set juror check out hour to "5" on confirm attendance
    And I set juror check out minute to "30" on confirm attendance
    And I click on the pm radio button for juror check out on confirm attendance
    And I press the "Add attendance day" button

    When the user searches for juror record "<juror_number>" from the global search bar
    And I click on the "Attendance" link
    And I press the "Add attendance day" button
    And I see "Add an attendance day" on the page
    And I set the attendance date to 4 days in the past

    And I set juror check in hour to "9" on confirm attendance
    And I set juror check in minute to "30" on confirm attendance
    And I click on the am radio button for juror check in on confirm attendance

    And I set juror check out hour to "5" on confirm attendance
    And I set juror check out minute to "30" on confirm attendance
    And I click on the pm radio button for juror check out on confirm attendance
    And I press the "Add attendance day" button


    When the user searches for juror record "<juror_number>" from the global search bar
    And I click on the "Attendance" link
    And I press the "Add attendance day" button
    And I see "Add an attendance day" on the page
    And I set the attendance date to 3 days in the past

    And I set juror check in hour to "9" on confirm attendance
    And I set juror check in minute to "30" on confirm attendance
    And I click on the am radio button for juror check in on confirm attendance

    And I set juror check out hour to "5" on confirm attendance
    And I set juror check out minute to "30" on confirm attendance
    And I click on the pm radio button for juror check out on confirm attendance
    And I press the "Add attendance day" button

    When the user searches for juror record "<juror_number>" from the global search bar
    And I click on the "Attendance" link
    And I press the "Add attendance day" button
    And I see "Add an attendance day" on the page
    And I set the attendance date to 2 days in the past

    And I set juror check in hour to "9" on confirm attendance
    And I set juror check in minute to "30" on confirm attendance
    And I click on the am radio button for juror check in on confirm attendance

    And I set juror check out hour to "5" on confirm attendance
    And I set juror check out minute to "30" on confirm attendance
    And I click on the pm radio button for juror check out on confirm attendance
    And I press the "Add attendance day" button

    When the user searches for juror record "<juror_number>" from the global search bar
    And I click on the "Attendance" link
    And I press the "Add attendance day" button
    And I see "Add an attendance day" on the page
    And I set the attendance date to 1 days in the past

    And I set juror check in hour to "9" on confirm attendance
    And I set juror check in minute to "30" on confirm attendance
    And I click on the am radio button for juror check in on confirm attendance

    And I set juror check out hour to "5" on confirm attendance
    And I set juror check out minute to "30" on confirm attendance
    And I click on the pm radio button for juror check out on confirm attendance
    And I press the "Add attendance day" button

    When the user searches for juror record "<juror_number>" from the global search bar
    And I click on the "Attendance" link
    And I see "205" in the same row as "Attendances"

    And I click on the "Expenses" link
    And I press change default expenses button
    And I click on the "Cancel without saving" link
    And I press change default expenses button

    #enter default expense
    And I set "Loss of earnings or benefits per day" to "300"
    And I set "Hour" to "2"
    And I set "Minute" to "30"
    And I set "Miles travelled by car, motorcycle or bicycle per day" to "123"
    And I choose the "No" radio button
    And I press the "Save default expenses" button

    When the user searches for juror record "<juror_number>" from the global search bar
    And I click on the "Expenses" link
    And I click on view draft expenses link
    And I see "Full day" in the same row as "£64.95"
    And I see "Full day (>10 days)" in the same row as "£129.91"
    And I see "Full day (>201 days)" in the same row as "£228.60"

    Examples:
      |user			|juror_number  |  pool_number    |
      |MODTESTCOURT |041542977     |  415321798      |


  @JurorTransformation
  Scenario Outline: Check higher rates can be edited and pick up correct rate for time spent that day

    Given I am on "Bureau" "demo"

    When a bureau owned pool is created with jurors
      | court |juror_number  	  | pool_number	    | att_date_weeks_in_future	| owner |
      | 415   |<juror_number>     | <pool_number>   | 5				            | 400	|

    Then a new pool is inserted for where record has transferred to the court new schema
      |part_no            | pool_no           | owner |
      |<juror_number>     | <pool_number>     | 415   |

    And I Confirm all the data in the record attendance table is cleared
    And I update juror "<juror_number>" to have a status of "Responded"
    And I insert 200 appearance records for juror "<juror_number>" at a "415" court and pool number "<pool_number>"
    And I log in as "<user>"

    #add extra attendance days
    When the user searches for juror record "<juror_number>" from the global search bar
    And I click on the "Attendance" link
    And I press the "Add attendance day" button
    And I set the attendance date to 5 days in the past

    And I set juror check in hour to "9" on confirm attendance
    And I set juror check in minute to "30" on confirm attendance
    And I click on the am radio button for juror check in on confirm attendance

    And I set juror check out hour to "5" on confirm attendance
    And I set juror check out minute to "30" on confirm attendance
    And I click on the pm radio button for juror check out on confirm attendance
    And I press the "Add attendance day" button

    When the user searches for juror record "<juror_number>" from the global search bar
    And I click on the "Attendance" link
    And I press the "Add attendance day" button
    And I see "Add an attendance day" on the page
    And I set the attendance date to 4 days in the past

    And I set juror check in hour to "9" on confirm attendance
    And I set juror check in minute to "30" on confirm attendance
    And I click on the am radio button for juror check in on confirm attendance

    And I set juror check out hour to "5" on confirm attendance
    And I set juror check out minute to "30" on confirm attendance
    And I click on the pm radio button for juror check out on confirm attendance
    And I press the "Add attendance day" button

    When the user searches for juror record "<juror_number>" from the global search bar
    And I click on the "Attendance" link
    And I press the "Add attendance day" button
    And I see "Add an attendance day" on the page
    And I set the attendance date to 3 days in the past

    And I set juror check in hour to "9" on confirm attendance
    And I set juror check in minute to "30" on confirm attendance
    And I click on the am radio button for juror check in on confirm attendance

    And I set juror check out hour to "5" on confirm attendance
    And I set juror check out minute to "30" on confirm attendance
    And I click on the pm radio button for juror check out on confirm attendance
    And I press the "Add attendance day" button

    When the user searches for juror record "<juror_number>" from the global search bar
    And I click on the "Attendance" link
    And I press the "Add attendance day" button
    And I see "Add an attendance day" on the page
    And I set the attendance date to 2 days in the past

    And I set juror check in hour to "9" on confirm attendance
    And I set juror check in minute to "30" on confirm attendance
    And I click on the am radio button for juror check in on confirm attendance

    And I set juror check out hour to "5" on confirm attendance
    And I set juror check out minute to "30" on confirm attendance
    And I click on the pm radio button for juror check out on confirm attendance
    And I press the "Add attendance day" button

    When the user searches for juror record "<juror_number>" from the global search bar
    And I click on the "Attendance" link
    And I press the "Add attendance day" button
    And I see "Add an attendance day" on the page
    And I set the attendance date to 1 days in the past

    And I set juror check in hour to "9" on confirm attendance
    And I set juror check in minute to "30" on confirm attendance
    And I click on the am radio button for juror check in on confirm attendance

    And I set juror check out hour to "5" on confirm attendance
    And I set juror check out minute to "30" on confirm attendance
    And I click on the pm radio button for juror check out on confirm attendance
    And I press the "Add attendance day" button

    When the user searches for juror record "<juror_number>" from the global search bar
    And I click on the "Attendance" link
    And I see "205" in the same row as "Attendances"

    And I click on the "Expenses" link
    And I press change default expenses button
    And I click on the "Cancel without saving" link
    And I press change default expenses button

    #enter default expense
    And I set "Loss of earnings or benefits per day" to "300"
    And I set "Hour" to "2"
    And I set "Minute" to "30"
    And I set "Miles travelled by car, motorcycle or bicycle per day" to "123"
    And I choose the "No" radio button
    And I press the "Save default expenses" button

    When the user searches for juror record "<juror_number>" from the global search bar
    And I click on the "Expenses" link
    And I click on view draft expenses link
    And I see "Full day" in the same row as "£64.95"
    And I see "Full day (>10 days)" in the same row as "£129.91"
    And I see "Full day (>201 days)" in the same row as "£228.60"

    When the user searches for juror record "<juror_number>" from the global search bar
    And I click on the "Attendance" link
    And I click on "Change" in the same row as "Mon 29 Jan 2024"
    And I choose the "Attendance" radio button
    And I set juror check in hour to "9" on confirm attendance
    And I set juror check in minute to "00" on confirm attendance
    And I choose the "am" radio button
    And I set juror check out hour to "12" on confirm attendance
    And I set juror check out minute to "00" on confirm attendance
    And I select the checkout radio button to "pm"
    And I press the "Save Changes" button

    And I click on the "Expenses" link
    And I click on view draft expenses link

    And I click the link for date "Mon 29 Jan 2024"
    And I see "Daily expenses" on the page
    And I set "Hour" to "00"
    And I set "Minute" to "30"
    And I select the Half day radio button
    And I press the "Save and back to all days" button
    And I see "Juror’s financial loss is over the daily limit" on the page
    And I see "The amounts you entered will be automatically recalculated to limit the juror’s loss to £64.95." on the page
    And I press the "Continue" button
    And I see "£64.95" in the same row as "Mon 29 Jan 2024"

    Examples:
      |user			|juror_number  |  pool_number    |
      |MODTESTCOURT |041542976     |  415321798      |