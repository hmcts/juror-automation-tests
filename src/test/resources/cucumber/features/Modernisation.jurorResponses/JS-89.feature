Feature: JS-89

  @JurorTransformation
  Scenario Outline: Check days for attendance are locked after 7 days

    Given I am on "Bureau" "ithc"

    And I log in as "<user>"

    #check in jurors
    And I press the "Apps" button
    And I click on the "Juror management" link
    And I click on the "Record attendance" link

    And I see link with text "Confirm attendance"
    And I click on the previous attendance day link "7" amount of times
    And I see "Confirmed" on the page
    And I do not see link with text "Confirm attendance"
    
    Examples:
      |user			|
      |MODTESTCOURT |


  @JurorTransformation
  Scenario Outline: Confirm attendance as many times as wanted within a week

    Given I am on "Bureau" "ithc"

    Given a bureau owned pool is created with jurors
      | court | juror_number  	    | pool_number	        | att_date_weeks_in_future	| owner |
      | 415   | <juror_number> 	    | <pool_number>         | 5				            | 400	|
      | 415   | <juror_number_1>    | <pool_number>         | 5				            | 400	|

    Then a new pool is inserted for where record has transferred to the court new schema
      |part_no             | pool_no           | owner |
      |<juror_number>      | <pool_number>     | 415   |
      |<juror_number_1>    | <pool_number>     | 415   |

    And I Confirm all the data in the record attendance table is cleared
    And I log in as "<user>"

    #set juror as responded
    And I update juror "<juror_number>" to have a status of responded in order to record attendance
    And I update juror "<juror_number_1>" to have a status of responded in order to record attendance

    #check in jurors
    And I press the "Apps" button
    And I click on the "Juror management" link
    And I click on the "Record attendance" link

    And I set the radio button to "Check in"
    And I set "Hour" to "09"
    And I set "Minute" to "00"
    And I set the radio button to "am"
    And I input juror "<juror_number>" to be checked in
    And I press the "Check in juror" button
    When I press the "Confirm attendance" button
    And I set "Hour" to "11"
    And I set "Minute" to "30"
    And I set the radio button to "pm"
    And I press the "Continue" button
    And I press the "Confirm attendance list is correct" button

    And I click on the previous attendance day link "1" amount of times

    And I set the radio button to "Check in"
    And I set "Hour" to "09"
    And I set "Minute" to "00"
    And I set the radio button to "am"
    And I input juror "<juror_number_1>" to be checked in
    And I press the "Check in juror" button
    When I press the "Confirm attendance" button
    And I set "Hour" to "11"
    And I set "Minute" to "30"
    And I set the radio button to "pm"
    And I press the "Continue" button
    And I press the "Confirm attendance list is correct" button

    And I press the "Apps" button
    And I click on the "Juror management" link
    And I click on the "Record attendance" link

    And I set the radio button to "Check in"
    And I set "Hour" to "09"
    And I set "Minute" to "00"
    And I set the radio button to "am"
    And I input juror "<juror_number_1>" to be checked in
    And I press the "Check in juror" button
    When I press the "Confirm attendance" button
    And I set "Hour" to "11"
    And I set "Minute" to "30"
    And I set the radio button to "pm"
    And I press the "Continue" button
    And I press the "Confirm attendance list is correct" button

    And I click on the previous attendance day link "1" amount of times

    And I set the radio button to "Check in"
    And I set "Hour" to "09"
    And I set "Minute" to "00"
    And I set the radio button to "am"
    And I input juror "<juror_number>" to be checked in
    And I press the "Check in juror" button
    When I press the "Confirm attendance" button
    And I set "Hour" to "11"
    And I set "Minute" to "30"
    And I set the radio button to "pm"
    And I press the "Continue" button
    And I press the "Confirm attendance list is correct" button

    Examples:
      |user			|juror_number  |juror_number_1 | pool_number   |
      |MODTESTCOURT |041521779     |041521778      | 415321235     |


  @JurorTransformation
  Scenario Outline: Check juror is removed from jurors in waiting list after empanelling them

    Given I am on "Bureau" "ithc"

    Given a bureau owned pool is created with jurors
      | court | juror_number  	    | pool_number	    | att_date_weeks_in_future	| owner |
      | 415   | <juror_number> 	    | <pool_number>     | 5				            | 400	|

    Then a new pool is inserted for where record has transferred to the court new schema
      |part_no              | pool_no           | owner |
      |<juror_number>       | <pool_number>     | 415   |

    And I Confirm all the data in the record attendance table is cleared
    And a new trial is inserted with the trial number "<trial_number>"
    And I log in as "<user>"

    #set juror as responded
    And I update juror "<juror_number>" to have a status of responded in order to record attendance

    #check in juror
    And I press the "Apps" button
    And I click on the "Juror management" link
    And I click on the "Record attendance" link

    #go back a day
    And I click on the previous attendance day link "1" amount of times
    And I set the radio button to "Check in"
    And I set "Hour" to "09"
    And I set "Minute" to "00"
    And I set the radio button to "am"
    And I input juror "<juror_number>" to be checked in
    And I press the "Check in juror" button

    #go to current day/check in
    And I press the "Apps" button
    And I click on the "Juror management" link
    And I click on the "Record attendance" link

    And I set the radio button to "Check in"
    And I set "Hour" to "09"
    And I set "Minute" to "00"
    And I set the radio button to "am"
    And I input juror "<juror_number>" to be checked in
    And I press the "Check in juror" button

    And I press the "Apps" button
    And I click on the "Trial management" link
    And I click on the trial number "<trial_number>"

    And I press the "Generate panel" button
    And I see "Generate a panel" on the page
    And I see "Which jurors do you want to generate a panel from?" on the page
    And I set the radio button to "All available jurors"
    And I set "Number of jurors needed on this panel" to "1"
    And I press the "Continue" button

    #empanel juror
    And I check the juror "<juror_number>" checkbox

    #Empanel jury
    And I press the "Empanel jury" button
    And I see "How many jurors do you want to empanel?" on the page
    And I set number of jurors to empanel to "1"
    And I press the "Continue" button
    And I see "Empanel jury" on the page
    And I see "When you confirm, anyone not used or challenged will be returned to the ‘jurors in waiting’ list." on the page

    And I select the radio button with name "<juror_number>" and value "juror"
    And I press the "Confirm and empanel jury" button
    And I see "Juror" in the same row as "<juror_number>"

    And I press the "Apps" button
    And I click on the "Juror management" link
    And I click on the "Record attendance" link
    And I do not see "<juror_number>" on the page

    And I click on the previous attendance day link "1" amount of times
    And I see "<juror_number>" on the page

    Examples:
      | user		  | juror_number     | pool_number   | trial_number |
      | MODTESTCOURT  | 041523749        | 415321234     | TRIALTEST88  |


  @JurorTransformation
  Scenario Outline: Check jurors attendance can be confirmed while being in a completed status

    Given I am on "Bureau" "ithc"

    Given a bureau owned pool is created with jurors
      | court | juror_number  	    | pool_number	    | att_date_weeks_in_future	| owner |
      | 415   | <juror_number> 	    | <pool_number>     | 5				            | 400	|

    Then a new pool is inserted for where record has transferred to the court new schema
      | part_no            | pool_no       | owner|
      | <juror_number>     | <pool_number> | 415  |

    And I Confirm all the data in the record attendance table is cleared
    And I log in as "<user>"

    #set juror as responded
    And juror "<juror_number>" has "DOB" as "1971-08-13 00:00:00.000" new schema
    And I update juror "<juror_number>" to have a status of responded in order to record attendance

    #check in jurors
    And I press the "Apps" button
    And I click on the "Juror management" link
    And I click on the "Record attendance" link
    And I set the radio button to "Check in"

    And I set "Hour" to "09"
    And I set "Minute" to "00"
    And I set the radio button to "am"
    And I input juror "<juror_number>" to be checked in
    And I press the "Check in juror" button

    When the user searches for juror record "<juror_number>" from the global search bar
    And I click the update juror record button
    And I set the radio button to "Complete service"
    And I press the "Continue" button
    And I set the "Completion date" single date field to a Monday "0" weeks in the future
    And I press the "Complete service" button
    Then I see "Juror's service completed" on the page
    And I see the juror status on the juror record screen is "Completed"

    And I press the "Apps" button
    And I click on the "Juror management" link
    And I click on the "Record attendance" link

    When I press the "Confirm attendance" button
    And I set "Hour" to "11"
    And I set "Minute" to "30"
    And I set the radio button to "pm"
    And I press the "Continue" button
    And I press the "Confirm attendance list is correct" button
    And I see "11:30pm" in the same row as "<juror_number>"
    And I see "Completed" in the same row as "<juror_number>"

    Examples:
      |user			|juror_number   | pool_number    |
      |MODTESTCOURT |041523746      | 415321231      |