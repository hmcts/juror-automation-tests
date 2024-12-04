Feature: JS-123

  @JurorTransformation @NewSchemaConverted
  Scenario Outline: Reassign a panel member - Happy Path

    Given I am on "Bureau" "ithc"

    Given a bureau owned pool is created with jurors
      | court |juror_number  	    | pool_number	    | att_date_weeks_in_future	| owner |
      | 415   |<juror_number> 	    | <pool_number>     | 5				            | 400	|

    Then a new pool is inserted for where record has transferred to the court new schema
      |part_no              | pool_no           | owner |
      |<juror_number>       | <pool_number>     | 415   |

    And I Confirm all the data in the record attendance table is cleared
    And I delete trials data
    And a new trial is inserted with the trial number "<trial_number>"
    And a new trial is inserted with the trial number "<trial_number2>"
    And I log in as "<user>"

    #set juror as responded
    And I update juror "<juror_number>" to have a status of responded in order to record attendance

    #check in juror
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

    And I press the "Apps" button
    And I click on the "Trial management" link
    And I click on the trial number "<trial_number>"

    And I press the "Generate panel" button
    And I see "Generate a panel" on the page
    And I see "Which jurors do you want to generate a panel from?" on the page
    And I set the radio button to "All available jurors"
    And I set "Number of jurors needed on this panel" to "1"
    And I press the "Continue" button
    And I see "<trial_number>" on the page
    And I see "Panel" in the same row as "<juror_number>"

    #reassign panel member
    And I check the juror "<juror_number>" checkbox
    And I press the "Reassign panel member" button
    And I see "Select a trial to reassign to" on the page
    And I select the "<trial_number2>" trial number radio button on reassign panel screen
    And I press the "Continue with selected" button
    And I see "Reassign panel members" on the page
    And I see "<juror_number>" on the page
    And I press the "Continue and move remaining jurors" button
    And I see "1 panel members reassigned to trial <trial_number2>" on the page



    Examples:
      |user			|juror_number  |  pool_number    | trial_number | trial_number2     |
      |MODTESTCOURT |041526712     |  415323254      | TESTTRIAL165  | TESTINGREASSIGN3 |

  @JurorTransformation @NewSchemaConverted
  Scenario Outline: Reassign a panel member - Unhappy Path

    Given I am on "Bureau" "ithc"

    Given a bureau owned pool is created with jurors
      | court |juror_number  	    | pool_number	    | att_date_weeks_in_future	| owner |
      | 415   |<juror_number> 	    | <pool_number>     | 5				            | 400	|

    Then a new pool is inserted for where record has transferred to the court new schema
      |part_no              | pool_no           | owner |
      |<juror_number>       | <pool_number>     | 415   |

    And I Confirm all the data in the record attendance table is cleared
    And I delete trials data
    And a new trial is inserted with the trial number "<trial_number>"
    And a new trial is inserted with the trial number "<trial_number2>"
    And I log in as "<user>"

    #set juror as responded
    And I update juror "<juror_number>" to have a status of responded in order to record attendance

    #check in juror
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

    And I press the "Apps" button
    And I click on the "Trial management" link
    And I click on the trial number "<trial_number>"

    And I press the "Generate panel" button
    And I see "Generate a panel" on the page
    And I see "Which jurors do you want to generate a panel from?" on the page
    And I set the radio button to "All available jurors"
    And I set "Number of jurors needed on this panel" to "1"
    And I press the "Continue" button
    And I see "<trial_number>" on the page
    And I see "Panel" in the same row as "<juror_number>"

    #reassign panel member
    And I press the "Reassign panel member" button
    And I see error "Select at least one panel member to reassign"
    
    And I check the juror "<juror_number>" checkbox
    And I press the "Reassign panel member" button

    And I see "Select a trial to reassign to" on the page
    And I press the "Continue with selected" button
    And I see "Select a trial to reassign the juror(s) into" in the error banner

    And I select the "<trial_number2>" trial number radio button on reassign panel screen
    And I press the "Continue with selected" button
    And I see "Reassign panel members" on the page

    And I see "<juror_number>" on the page
    And I press the "Continue and move remaining jurors" button
    And I see "1 panel members reassigned to trial <trial_number2>" on the page


    #check you cant add juror back to previous panel
    And I press the "Apps" button
    And I click on the "Trial management" link
    And I click on the trial number "<trial_number2>"
    And I check the juror "<juror_number>" checkbox
    And I press the "Reassign panel member" button
    And I see "Select a trial to reassign to" on the page
    And I select the "<trial_number>" trial number radio button on reassign panel screen
    And I press the "Continue with selected" button
    And I see "Reassign panel members" on the page
    And I see "<juror_number>" on the page
    And I press the "Continue and move remaining jurors" button
    And I see "Juror(s) can not be reassigned back to a panel they have already been on" in the error banner

    #check button is not present when juror has status changed
    And I press the "Apps" button
    And I click on the "Trial management" link
    And I click on the trial number "<trial_number2>"
    And I check the juror "<juror_number>" checkbox
    And I press the "Reassign panel member" button
    And I see "Select a trial to reassign to" on the page

    And I update juror "<juror_number>" to have a status of "Deferred"
    And I press the "Apps" button
    And I click on the "Trial management" link
    And I click on the trial number "<trial_number2>"
    And I do not see "Reassign panel member" on the page
   # And I do not see the button to reassign panel member

    And I update juror "<juror_number>" to have a status of "Panel"
    And I press the "Apps" button
    And I click on the "Trial management" link
    And I click on the trial number "<trial_number2>"
    And I check the juror "<juror_number>" checkbox
    And I press the "Reassign panel member" button
    And I see "Select a trial to reassign to" on the page

    And I update juror "<juror_number>" to have a status of "Juror"
    And I press the "Apps" button
    And I click on the "Trial management" link
    And I click on the trial number "<trial_number2>"
    And I do not see "Reassign panel member" on the page


    Examples:
      |user			|juror_number  |  pool_number    | trial_number | trial_number2     |
      |MODTESTCOURT |041526708     |  415323255      | TESTTRIAL889  | TESTINGREASSIGN5 |
