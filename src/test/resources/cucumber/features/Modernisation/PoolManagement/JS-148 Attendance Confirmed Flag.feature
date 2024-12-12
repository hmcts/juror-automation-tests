Feature: JS-148

  @JurorTransformation
  Scenario Outline: Testing confirming multiple times a day

    Given I am on "Bureau" "ithc"

    #set up pool and 4 jurors
    Given a bureau owned pool is created with jurors
      | court | juror_number  	    | pool_number	    | att_date_weeks_in_future	| owner |
      | 415   | <juror_number_1> 	| <pool_number>     | 7				            | 400	|
      | 415   | <juror_number_2> 	| <pool_number>     | 7				            | 400	|
      | 415   | <juror_number_3> 	| <pool_number>     | 7				            | 400	|
      | 415   | <juror_number_4> 	| <pool_number>     | 7				            | 400	|

    Given a new pool is inserted for where record has transferred to the court new schema
      | part_no           | pool_no       | owner |
      | <juror_number_1>  | <pool_number> | 415   |
      | <juror_number_2>  | <pool_number> | 415   |
      | <juror_number_3>  | <pool_number> | 415   |
      | <juror_number_4>  | <pool_number> | 415   |

    And I delete trial "<trial_number>" and associated records

    Given juror "<juror_number_1>" has "DOB" as "1971-08-13 00:00:00.000" new schema
    Given juror "<juror_number_2>" has "DOB" as "1971-08-13 00:00:00.000" new schema
    Given juror "<juror_number_3>" has "DOB" as "1971-08-13 00:00:00.000" new schema
    Given juror "<juror_number_4>" has "DOB" as "1971-08-13 00:00:00.000" new schema

    Given juror "<juror_number_1>" has "last_name" as "one" new schema
    Given juror "<juror_number_2>" has "last_name" as "two" new schema
    Given juror "<juror_number_3>" has "last_name" as "three" new schema
    Given juror "<juror_number_4>" has "last_name" as "four" new schema

    And I log in as "<user>"

    #respond the 4 jurors
    When I search for juror "<juror_number_1>"
    Then I see "Summoned" on the page
    When I click the update juror record button
    When I choose the "Mark as responded" radio button
    And I press the "Continue" button
    And I check the "Mark juror as 'responded'" checkbox
    And I press the "Confirm" button
    Then I see "Responded" on the page

    When I search for juror "<juror_number_2>"
    Then I see "Summoned" on the page
    When I click the update juror record button
    When I choose the "Mark as responded" radio button
    And I press the "Continue" button
    And I check the "Mark juror as 'responded'" checkbox
    And I press the "Confirm" button
    Then I see "Responded" on the page

    When I search for juror "<juror_number_3>"
    Then I see "Summoned" on the page
    When I click the update juror record button
    When I choose the "Mark as responded" radio button
    And I press the "Continue" button
    And I check the "Mark juror as 'responded'" checkbox
    And I press the "Confirm" button
    Then I see "Responded" on the page

    When I search for juror "<juror_number_4>"
    Then I see "Summoned" on the page
    When I click the update juror record button
    When I choose the "Mark as responded" radio button
    And I press the "Continue" button
    And I check the "Mark juror as 'responded'" checkbox
    And I press the "Confirm" button
    Then I see "Responded" on the page

    #check in juror 1
    When I click on the "Apps" link
    And I click on the "Juror management" link
    And I click on the "Record attendance" link
    And I set the radio button to "Check in"
    And I set "Hour" to "09"
    And I set "Minute" to "00"
    And I set the radio button to "am"
    And I input juror "<juror_number_1>" to be checked in
    And I press the "Check in juror" button

    #create a trial
    And I press the "Apps" button
    And I click on the "Trial management" link
    And I press the "Create a trial" button
    And I set "Case number" to "<trial_number>"
    Then I set the radio button to "Criminal"
    And I set "Defendants" to "Defendent One"
    And I set "Start date" to "today"

    And I set "Judge" to "PATRICIA H AITKEN"
    And I choose the "Chester" radio button
    And I set "Courtroom" to "JURY ASSEMBLY ROOM"
    And I press the "Create trial" button

    #put juror on trial
    And I press the "Apps" button
    And I click on the "Trial management" link
    And I click on the trial number "<trial_number>"

    And I press the "Generate panel" button
    And I see "Generate a panel" on the page
    And I see "Which jurors do you want to generate a panel from?" on the page
    And I set the radio button to "All available jurors"
    And I set "Number of jurors needed on this panel" to "1"
    And I press the "Continue" button

    #juror is now not in jurors in waiting tab
    When I click on the "Apps" link
    And I click on the "Juror management" link
    And I click on the "Record attendance" link
    And I do not see link with text "<juror_number_1>"
    And I click on the "Jurors on a trial" link
    Then I see "Confirm attendance" in the same row as "<trial_number>"

    #confirm the panelled juror
    And I click on "Confirm attendance" in the same row as "<trial_number>"
    And I set the radio button to "Today"
    And I set juror check in hour to "9" on confirm attendance
    And I set juror check in minute to "00" on confirm attendance
    And I click on the am radio button for juror check in on confirm attendance
    And I set juror check out hour to "5" on confirm attendance
    And I set juror check out minute to "00" on confirm attendance
    And I click on the pm radio button for juror check out on confirm attendance
    And I check the juror "<juror_number_1>" checkbox
    And I press the "Confirm" button
    And I see "1 of 1" in the same row as "<trial_number>"

    #check in and out juror 2
    When I click on the "Apps" link
    And I click on the "Juror management" link
    And I click on the "Record attendance" link
    And I set the radio button to "Check in"
    And I set "Hour" to "09"
    And I set "Minute" to "00"
    And I choose the "am" radio button
    And I input juror "<juror_number_2>" to be checked in
    And I press the "Check in juror" button
    And I set the radio button to "Check out"
    And I set "Hour" to "4"
    And I set "Minute" to "30"
    And I select the checkout radio button to "pm"
    And I input juror "<juror_number_2>" to be checked out
    And I press the "Check out juror" button
    Then I see the confirmed status for juror "<juror_number_2>" is "-"

    #confirm juror 2
    When I press the "Confirm attendance" button
    And I see "Confirm attendance list" on the page
    And I press the "Confirm attendance list is correct" button
    Then I see the confirmed status for juror "<juror_number_2>" is "Confirmed"

    #check in and out juror 3
    And I set the radio button to "Check in"
    And I set "Hour" to "09"
    And I set "Minute" to "00"
    And I choose the "am" radio button
    And I input juror "<juror_number_3>" to be checked in
    And I press the "Check in juror" button
    And I set the radio button to "Check out"
    And I set "Hour" to "4"
    And I set "Minute" to "30"
    And I select the checkout radio button to "pm"
    And I input juror "<juror_number_3>" to be checked out
    And I press the "Check out juror" button
    Then I see the confirmed status for juror "<juror_number_3>" is "-"

    #check in juror 4
    And I set the radio button to "Check in"
    And I set "Hour" to "09"
    And I set "Minute" to "00"
    And I choose the "am" radio button
    And I input juror "<juror_number_4>" to be checked in
    And I press the "Check in juror" button
    Then I see the confirmed status for juror "<juror_number_4>" is "-"

    When I backdate juror "<juror_number_1>"'s attendance by "7" days
    When I backdate juror "<juror_number_2>"'s attendance by "7" days
    When I backdate juror "<juror_number_3>"'s attendance by "7" days
    When I backdate juror "<juror_number_4>"'s attendance by "7" days

    And I click on the previous attendance day link "7" amount of times
    Then I see the Locked flag on the page
    And I do not see "Check in" on the page
    And I do not see "Check out" on the page
    And I do not see the Confirm attendance button
    And I see the confirmed status for juror "<juror_number_2>" is "Confirmed"
    And I see the confirmed status for juror "<juror_number_3>" is "-"
    And I see the confirmed status for juror "<juror_number_4>" is "-"

    Given I am on "Bureau" "ithc"

    And I log in as "<sjo_user>"
    When I click on the "Apps" link
    And I click on the "Juror management" link
    And I click on the "Record attendance" link
    Then I see the Locked flag on the page
    And I do not see "Check in" on the page
    And I do not see "Check out" on the page
    And I do not see the Confirm attendance button
    And I see the confirmed status for juror "<juror_number_2>" is "Confirmed"
    And I see the confirmed status for juror "<juror_number_3>" is "-"
    And I see the confirmed status for juror "<juror_number_4>" is "-"
    And I see link with text "Jurors with a check in/check out time that have not had attendance confirmed"
    
    When I click on the "Jurors with a check in/check out time that have not had attendance confirmed" link
    Then I see "Change" in the same row as "<juror_number_3>"
    Then I see "Change" in the same row as "<juror_number_4>"

    When I click on "Change" in the same row as "three"
    Then check in hour is "9"
    And check in minute is "00"
    And check out hour is "4"
    And check out minute is "30"

    When I press the "Confirm attendance" button
    Then I see "Attendance confirmed for juror <juror_number_3>" on the page

    When I click on "Change" in the same row as "four"
    Then check in hour is "9"
    And check in minute is "00"
    When I press the "Confirm attendance" button
    Then I see error "Enter a check out time"

    When I set input field with "id" of "checkOutTimeHour" to "5"
    And I set input field with "id" of "checkOutTimeMinute" to "00"
    And I select the checkout radio button to "pm"
    When I press the "Confirm attendance" button
    Then I see "Attendance confirmed for juror <juror_number_4>" on the page
    And I see "No unconfirmed attendances for this date" on the page

    When I click on the "Record attendance" link
    Then I see the Locked flag on the page
    And I do not see "Check in" on the page
    And I do not see "Check out" on the page
    And I do not see the Confirm attendance button
    And I see the confirmed status for juror "<juror_number_2>" is "Confirmed"
    And I see the confirmed status for juror "<juror_number_3>" is "Confirmed"
    And I see the confirmed status for juror "<juror_number_4>" is "Confirmed"

    Given I am on "Bureau" "ithc"

    And I log in as "<user>"
    When I click on the "Apps" link
    And I click on the "Juror management" link
    And I click on the "Record attendance" link
    And I click on the previous attendance day link "7" amount of times
    Then I see the Locked flag on the page
    And I do not see "Check in" on the page
    And I do not see "Check out" on the page
    And I do not see the Confirm attendance button
    And I see the confirmed status for juror "<juror_number_2>" is "Confirmed"
    And I see the confirmed status for juror "<juror_number_3>" is "Confirmed"
    And I see the confirmed status for juror "<juror_number_4>" is "Confirmed"

    Examples:
      | user         | sjo_user | juror_number_1 | juror_number_2  | juror_number_3  | juror_number_4  | pool_number | trial_number  |
      | MODTESTCOURT | SJOUSER  | 041500109      | 041500110       | 041500111       | 041500112       | 415300175   | TRIALJS148    |
