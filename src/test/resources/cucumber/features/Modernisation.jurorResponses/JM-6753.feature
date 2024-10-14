Feature: JM-6753 - As a jury officer I want to be able to confirm the attendance for jurors on a trial

  @JurorTransformation
  Scenario Outline: Confirm Attendance for Jurors on a trial - Happy Path

    Given I am on "Bureau" "ithc"

    Given a bureau owned pool is created with jurors
      | court |juror_number  	    | pool_number	    | att_date_weeks_in_future	| owner |
      | 415   |<juror_number> 	    | <pool_number>     | 5				            | 400	|

    Then a new pool is inserted for where record has transferred to the court new schema
      |part_no           | pool_no       | owner|
      |<juror_number>    | <pool_number> | 415  |

    And I Confirm all the data in the record attendance table is cleared
    And I delete trials data
    And I log in as "<user>"

    #create trial manually
    And I press the "Apps" button
    And I click on the "Trial management" link
    And I press the "Create a trial" button
    And I see "Create a trial" on the page
    And I set "Case number" to "<trial_number>"
    Then I set the radio button to "Criminal"
    And I set "Defendants" to "Defendant"
    And I set the "Start date for Trial" date to a Monday "0" weeks in the future
    And I set "Judge" to "PATRICIA H AITKEN"
    And I set the radio button to "Chester"
    And I set "Courtroom" to "JURY ASSEMBLY ROOM"
    And I press the "Create trial" button

    #set juror as responded
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
    And I see "When you confirm, anyone not used or challenged will be returned to the ‘jurors in waiting’ list." on the page
    And I see "1 selected of 1 jurors needed" on the page

    #jurors set to JUROR will still show in panel with status of Juror
    And I press the "Confirm and empanel jury" button
    And I see "Juror" in the same row as "<juror_number>"

    And I press the "Apps" button
    And I click on the "Juror management" link
    And I click on the "Record attendance" link
    And I click on the "Jurors on a trial" link
    And I see "Confirm attendance" in the same row as "<trial_number>"
    And I click on "Confirm attendance" in the same row as "<trial_number>"
    And I set the radio button to "Today"

    And I set juror check in hour to "9" on confirm attendance
    And I set juror check in minute to "20" on confirm attendance
    And I click on the am radio button for juror check in on confirm attendance

    And I set juror check out hour to "5" on confirm attendance
    And I set juror check out minute to "15" on confirm attendance
    And I click on the pm radio button for juror check out on confirm attendance
    And I check the juror "<juror_number>" checkbox
    And I press the "Confirm" button
    And I see "1 of 1" in the same row as "<trial_number>"

    Examples:
      |user			| juror_number  | pool_number  | trial_number  |
      |MODTESTCOURT | 041583771     | 415362298    | TEST12TRIAL   |


  @JurorTransformation
  Scenario Outline: Confirm Attendance for Jurors on a trial - Unhappy Path

    Given I am on "Bureau" "ithc"

    Given a bureau owned pool is created with jurors
      | court |juror_number  | pool_number	    | att_date_weeks_in_future	| owner |
      | 415   |<juror_number>| <pool_number>    | 5				            | 400	|

    Then a new pool is inserted for where record has transferred to the court new schema
      |part_no            | pool_no       | owner|
      |<juror_number>     | <pool_number> | 415  |

    And I Confirm all the data in the record attendance table is cleared
    And I delete trials data
    And I log in as "<user>"

     #create trial manually
    And I press the "Apps" button
    And I click on the "Trial management" link
    And I press the "Create a trial" button
    And I see "Create a trial" on the page
    And I set "Case number" to "<trial_number>"
    Then I set the radio button to "Criminal"
    And I set "Defendants" to "Defendant"
    And I set the "Start date for Trial" date to a Monday "0" weeks in the future
    And I set "Judge" to "PATRICIA H AITKEN"
    And I choose the "Chester" radio button
    And I set "Courtroom" to "JURY ASSEMBLY ROOM"
    And I press the "Create trial" button

    #set juror as responded
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
    And I see "When you confirm, anyone not used or challenged will be returned to the ‘jurors in waiting’ list." on the page
    And I see "1 selected of 1 jurors needed" on the page

    And I press the "Confirm and empanel jury" button
    And I see "Juror" in the same row as "<juror_number>"

    And I press the "Apps" button
    And I click on the "Juror management" link
    And I click on the "Record attendance" link
    And I click on the "Jurors on a trial" link
    And I see "Confirm attendance" in the same row as "<trial_number>"
    And I click on "Confirm attendance" in the same row as "<trial_number>"
    And I press the "Confirm" button

    #error check
    And I see error "Select which day you’re confirming attendance for"
    And I see error "Enter a check in time or delete this juror's attendance"
    And I see error "Enter a check out time"
    And I see error "Select which jurors attended at these times"
    

    And I set the radio button to "A different date"
    And I set the "Different date" date to a Monday "-12" weeks in the future

    And I set juror check in hour to "9" on confirm attendance
    And I set juror check in minute to "20" on confirm attendance
    And I click on the am radio button for juror check in on confirm attendance

    And I set juror check out hour to "5" on confirm attendance
    And I set juror check out minute to "15" on confirm attendance
    And I click on the am radio button for juror check out on confirm attendance

    And I check the juror "<juror_number>" checkbox
    And I press the "Confirm" button
    And I see error "Check out time cannot be earlier than check in time"
    And I click on the pm radio button for juror check out on confirm attendance
    And I press the "Confirm" button
    And I see "1 of 1" in the same row as "<trial_number>"

    Examples:
      |user			|juror_number    | pool_number    | trial_number  |
      |MODTESTCOURT |041583772       | 415362294      | TEST11TRIAL   |


  @JurorTransformation
  Scenario Outline: Confirm Attendance for Jurors on a trial - Previous working day

    Given I am on "Bureau" "ithc"

    Given a bureau owned pool is created with jurors
      | court |juror_number  	    | pool_number	    | att_date_weeks_in_future	| owner |
      | 415   |<juror_number> 	    | <pool_number>     | 5				            | 400	|

    Then a new pool is inserted for where record has transferred to the court new schema
      |part_no               | pool_no       | owner|
      |<juror_number>        | <pool_number> | 415  |

    And I Confirm all the data in the record attendance table is cleared
    And I delete trials data
    And I log in as "<user>"

     #create trial manually
    And I press the "Apps" button
    And I click on the "Trial management" link
    And I press the "Create a trial" button
    And I see "Create a trial" on the page
    And I set "Case number" to "<trial_number>"
    Then I set the radio button to "Criminal"
    And I set "Defendants" to "Defendant"
    And I set the "Start date for Trial" date to a Monday "0" weeks in the future
    And I set "Judge" to "PATRICIA H AITKEN"
    And I choose the "Chester" radio button
    And I set "Courtroom" to "JURY ASSEMBLY ROOM"
    And I press the "Create trial" button

    #set juror as responded
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
    And I see "When you confirm, anyone not used or challenged will be returned to the ‘jurors in waiting’ list." on the page
    And I see "1 selected of 1 jurors needed" on the page

    And I press the "Confirm and empanel jury" button
    And I see "Juror" in the same row as "<juror_number>"

    And I press the "Apps" button
    And I click on the "Juror management" link
    And I click on the "Record attendance" link
    And I click on the "Jurors on a trial" link
    And I see "Confirm attendance" in the same row as "<trial_number>"
    And I click on "Confirm attendance" in the same row as "<trial_number>"
    And I press the "Confirm" button

    #error check
    And I see error "Select which day you’re confirming attendance for"
    And I see error "Enter a check in time or delete this juror's attendance"
    And I see error "Enter a check out time"
    And I see error "Select which jurors attended at these times"

    And I set the radio button to "Today"
    And I set juror check in hour to "9" on confirm attendance
    And I set juror check in minute to "20" on confirm attendance
    And I click on the am radio button for juror check in on confirm attendance

    And I set juror check out hour to "5" on confirm attendance
    And I set juror check out minute to "15" on confirm attendance
    And I click on the pm radio button for juror check out on confirm attendance
    And I check the juror "<juror_number>" checkbox
    And I press the "Confirm" button
    And I see "1 of 1" in the same row as "<trial_number>"

    Examples:
      | user		 | juror_number    | pool_number    | trial_number  |
      | MODTESTCOURT | 041586776       | 415362254      | TEST13TRIAL   |