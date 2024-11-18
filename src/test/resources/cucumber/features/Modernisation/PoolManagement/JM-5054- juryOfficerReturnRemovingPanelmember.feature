Feature: JM-5054-As a jury officer I need to be able to return jurors from a trial to jurors in waiting

  @JurorTransformation
  Scenario Outline: Happy path to create a trial and generate Panel and return all the jurors

    Given I am on "Bureau" "ithc"
    Given a bureau owned pool is created with jurors
      | court | juror_number  	    | pool_number	    | att_date_weeks_in_future	| owner |
      | 415   | <juror_number_1>    | <pool_number>     | 5				            | 400	|
      | 415   | <juror_number_2> 	| <pool_number>     | 5				            | 400	|
      | 415   | <juror_number_3> 	| <pool_number>     | 5				            | 400	|
      | 415   | <juror_number_4> 	| <pool_number>     | 5				            | 400	|

    Then a new pool is inserted for where record has transferred to the court new schema
      | part_no              | pool_no           | owner |
      | <juror_number_1>     | <pool_number>     | 415   |
      | <juror_number_2>     | <pool_number>     | 415   |
      | <juror_number_3>     | <pool_number>     | 415   |
      | <juror_number_4>     | <pool_number>     | 415   |

    And I Confirm all the data in the record attendance table is cleared
    And a new trial is inserted with the trial number "<trial_number>"
    And I log in as "<user>"

    #set juror as responded
    And I update juror "<juror_number_1>" to have a status of responded in order to record attendance
    And I update juror "<juror_number_2>" to have a status of responded in order to record attendance
    And I update juror "<juror_number_3>" to have a status of responded in order to record attendance
    And I update juror "<juror_number_4>" to have a status of responded in order to record attendance

    #check in jurors
    And I press the "Apps" button
    And I click on the "Juror management" link
    And I click on the "Record attendance" link
    And I set the radio button to "Check in"
    And I set "Hour" to "09"
    And I set "Minute" to "00"
    And I set the radio button to "am"
    And I input juror "<juror_number_1>" to be checked in
    And I press the "Check in juror" button
    And I set "Hour" to "11"
    And I set "Minute" to "30"
    And I set the radio button to "am"
    And I input juror "<juror_number_2>" to be checked in
    And I press the "Check in juror" button
    And I set "Hour" to "12"
    And I set "Minute" to "30"
    And I set the radio button to "pm"
    And I input juror "<juror_number_3>" to be checked in
    And I press the "Check in juror" button
    And I set "Hour" to "1"
    And I set "Minute" to "30"
    And I set the radio button to "pm"
    And I input juror "<juror_number_4>" to be checked in
    When I press the "Check in juror" button
    Then I see "<juror_number_1>" in the same row as "9:00am"
    And I see "<juror_number_2>" in the same row as "11:30am"
    And I see "<juror_number_3>" in the same row as "12:30pm"
    And I see "<juror_number_4>" in the same row as "1:30pm"
    And I press the "Apps" button
    And I click on the "Trial management" link
    And I click on the trial number "<trial_number>"
    When I press the "Generate panel" button
    Then I see "Generate a panel" on the page
    And I see "Which jurors do you want to generate a panel from?" on the page
    When I press the "Continue" button
    Then I see error "Select which group of jurors you want to generate a panel from"
    And I see error "Enter how many jurors are needed on this panel"
    And I set the radio button to "All available jurors"
    And I set "Number of jurors needed on this panel" to "4"
    When I press the "Continue" button

    #see my jurors are panelled and verify label text
    And I press the "Print" button
    Then I see "Panel list (summary)" on the page
    Then I see "Panel list (detailed)" on the page
    Then I see "Panel member status report" on the page
    Then I see "Trial attendance report" on the page
    And I see "Ballot cards" on the page
    And I see "Empanel jury" on the page
    And I see "End trial" on the page
    And I am able to see and interact with the trial management tabs and fields
    And I press the "Return panel members" button
    And I see error "Select at least one panel member to return"
    And I check the juror "041530001" checkbox
    And I check the juror "041530002" checkbox
    And I check the juror "041530003" checkbox
    And I check the juror "041530004" checkbox
    When I press the "Return panel members" button
    Then I verify the text "You're returning 4 panel members to the list of jurors in waiting." on the page
    And I see "Cancel" on the page
    When I press the "Return" button

    #will require end trial functionality implemented here
    And I set the radio button to "Yes"
    And I press the "Continue" button
    Then I verify the banner message "4 jurors returned" on the page

    Examples:
      | user		 | juror_number_1 | juror_number_2   | juror_number_3  | juror_number_4 | pool_number   | trial_number |
      | MODTESTCOURT | 041530001      | 041530002        | 041530003       | 041530004      | 415300301     | T202495832   |

  @JurorTransformation
  Scenario Outline: Create a trial and generate Panel and return partial jurors

    Given I am on "Bureau" "ithc"
    When a bureau owned pool is created with jurors
      | court | juror_number  	    | pool_number	    | att_date_weeks_in_future	| owner |
      | 415   | <juror_number_1>    | <pool_number>     | 5				            | 400	|
      | 415   | <juror_number_2> 	| <pool_number>     | 5				            | 400	|
      | 415   | <juror_number_3> 	| <pool_number>     | 5				            | 400	|
      | 415   | <juror_number_4> 	| <pool_number>     | 5				            | 400	|

    Then a new pool is inserted for where record has transferred to the court new schema
      |part_no              | pool_no           | owner |
      |<juror_number_1>     | <pool_number>     | 415   |
      |<juror_number_2>     | <pool_number>     | 415   |
      |<juror_number_3>     | <pool_number>     | 415   |
      |<juror_number_4>     | <pool_number>     | 415   |

    And I Confirm all the data in the record attendance table is cleared
    And a new trial is inserted with the trial number "<trial_number>"
    And I log in as "<user>"

    #set juror as responded
    And I update juror "<juror_number_1>" to have a status of responded in order to record attendance
    And I update juror "<juror_number_2>" to have a status of responded in order to record attendance
    And I update juror "<juror_number_3>" to have a status of responded in order to record attendance
    And I update juror "<juror_number_4>" to have a status of responded in order to record attendance

    #check in jurors
    And I press the "Apps" button
    And I click on the "Juror management" link
    And I click on the "Record attendance" link
    And I set the radio button to "Check in"
    And I set "Hour" to "09"
    And I set "Minute" to "00"
    And I set the radio button to "am"
    And I input juror "<juror_number_1>" to be checked in
    And I press the "Check in juror" button
    And I set "Hour" to "11"
    And I set "Minute" to "30"
    And I set the radio button to "am"
    And I input juror "<juror_number_2>" to be checked in
    And I press the "Check in juror" button
    And I set "Hour" to "12"
    And I set "Minute" to "30"
    And I set the radio button to "pm"
    And I input juror "<juror_number_3>" to be checked in
    And I press the "Check in juror" button
    And I set "Hour" to "1"
    And I set "Minute" to "30"
    And I set the radio button to "pm"
    And I input juror "<juror_number_4>" to be checked in
    When I press the "Check in juror" button
    Then I see "<juror_number_1>" in the same row as "9:00am"
    And I see "<juror_number_2>" in the same row as "11:30am"
    And I see "<juror_number_3>" in the same row as "12:30pm"
    And I see "<juror_number_4>" in the same row as "1:30pm"
    And I press the "Apps" button
    And I click on the "Trial management" link
    And I click on the trial number "<trial_number>"
    And I press the "Generate panel" button
    And I see "Generate a panel" on the page
    And I see "Which jurors do you want to generate a panel from?" on the page
    And I press the "Continue" button
    And I see error "Select which group of jurors you want to generate a panel from"
    And I see error "Enter how many jurors are needed on this panel"
    And I set the radio button to "All available jurors"
    And I set "Number of jurors needed on this panel" to "4"
    When I press the "Continue" button

    #see my jurors are panelled and verify label text
    And I press the "Print" button
    And I am able to see and interact with the trial management tabs and fields
    When I press the "Return panel members" button
    Then I see error "Select at least one panel member to return"
    And I check the juror "<juror_number_1>" checkbox
    And I check the juror "<juror_number_3>" checkbox
    When I press the "Return panel members" button
    Then I verify the text "You're returning 2 panel members to the list of jurors in waiting." on the page
    And I see "Cancel" on the page
    When I press the "Return" button

    #will require end trial functionality implemented here
    Then I verify the banner message "2 jurors returned" on the page

    Examples:
      | user		 | juror_number_1 | juror_number_2  | juror_number_3 | juror_number_4 | pool_number   | trial_number |
      | MODTESTCOURT | 041530011      | 041530012       | 041530013      | 041530014      | 415300301     | T202495832   |