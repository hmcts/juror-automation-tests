Feature: JM-8203

  @JurorTransformation
  Scenario Outline: As a jury officer I want to be able to confirm attendance for jurors that have dropped off the record attendance list

    Given I am on "Bureau" "ithc"

    Given a bureau owned pool is created with jurors
      | court |juror_number  	    | pool_number	    | att_date_weeks_in_future	| owner |
      | 415   |<juror_number> 	    | <pool_number>     | 5				            | 400	|
      | 415   |<juror_number_2> 	| <pool_number>     | 5				            | 400	|

    Then a new pool is inserted for where record has transferred to the court new schema
      |part_no               | pool_no       | owner|
      |<juror_number>        | <pool_number> | 415  |
      |<juror_number_2>      | <pool_number> | 415  |

    And I Confirm all the data in the record attendance table is cleared
    And a new trial is inserted with the trial number "<trial_number>"
    And I log in as "<user>"

    #set juror as responded
    And I update juror "<juror_number>" to have a status of responded in order to record attendance
    And I update juror "<juror_number_2>" to have a status of responded in order to record attendance

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
    And I set number of jurors to empanel to "1"
    And I press the "Continue" button
    And I select the radio button with name "<juror_number>" and value "juror"
    And I press the "Confirm and empanel jury" button

    And I press the "Apps" button
    And I click on the "Juror management" link
    And I click on the "Record attendance" link
    And I set the radio button to "Check in"
    And I set "Hour" to "10"
    And I set "Minute" to "00"
    And I set the radio button to "am"
    And I input juror "<juror_number_2>" to be checked in
    And I press the "Check in juror" button

    When I press the "Confirm attendance" button
    And I set "Hour" to "6"
    And I set "Minute" to "30"
    And I set the radio button to "pm"
    And I press the "Continue" button
    And I press the "Confirm attendance list is correct" button

    #verify jurors in limbo link
    And I see "Jurors with a check in/check out time that have not had attendance confirmed" on the page
    And I click on the "Jurors with a check in/check out time that have not had attendance confirmed" link
    And I see "Unconfirmed attendances" on the page
    And I see "<juror_number>" on the page
    And I click on the "Change" link
    And I set juror check out hour to "5" on confirm attendance
    And I set juror check out minute to "30" on confirm attendance
    And I click on the pm radio button for juror check out on confirm attendance
    And I press the "Confirm attendance" button
    And I see "Attendance confirmed for juror <juror_number>" on the page

    And I press the "Apps" button
    And I click on the "Juror management" link
    And I click on the "Record attendance" link
    And I click on the "Jurors on a trial" link
    And I see "1 of 1" in the same row as "<trial_number>"


    Examples:
      |user			|juror_number  | juror_number_2   | pool_number    | trial_number |
      |MODTESTCOURT |041526641     | 041526642        | 415388217      | TRIALLIMBO   |
