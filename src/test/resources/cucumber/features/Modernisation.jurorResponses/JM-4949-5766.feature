Feature: JM-4949 & JM-5766

  @JurorTransformation @NewSchemaConverted
  Scenario Outline: Return all jurors on a panel

    Given I am on "Bureau" "ithc"

    Given a bureau owned pool is created with jurors
      | court |juror_number  	    | pool_number	    | att_date_weeks_in_future	| owner |
      | 415   |<juror_number> 	    | <pool_number>     | 5				            | 400	|

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
    And I press the "Confirm and empanel jury" button
    And I see "Juror" in the same row as "<juror_number>"

    #retrurn jury process
    And I check the juror "<juror_number>" checkbox
    And I press the "Return jury" button
    And I see "How do you want to return the juror you selected?" on the page
    And I press the "Continue" button
    And I see error "Select how you want to return the juror"
    And I set the radio button to "Return and confirm attendance"
    And I press the "Continue" button
    And I see "Confirm attendance" on the page
    And I press the "Continue" button
    
    And I see error "Enter a check in time"
    And I see error "Enter a check out time"

    #check in on confirm attendance
    And I set juror check in hour to "9" on confirm attendance
    And I set juror check in minute to "20" on confirm attendance
    And I click on the am radio button for juror check in on confirm attendance

    #check out on confirm attendance
    And I set juror check out hour to "2" on confirm attendance
    And I set juror check out minute to "30" on confirm attendance
    And I click on the pm radio button for juror check out on confirm attendance

    And I press the "Continue" button
    And I see "Return jurors and confirm attendance" on the page
    And I see "You're returning 1 juror and confirming their attendance for today." on the page
    And I see "A check in time of 9:20am will be applied to any juror without a check in time." on the page
    And I see "A check out time of 2:30pm will be applied to all juror." on the page
    And I see "They'll be returned to the list of jurors in waiting, to continue their service." on the page

    #return juror
    And I press the "Return" button
    Then I verify the text "Do you want to end this trial?" on the page
    And I choose the "No" radio button
    And I press the "Continue" button
    And I see "1 juror returned" on the page

    And I press the "Add panel members" button
    And I see "Select where to add more panel members from" on the page
    And I click on the "Cancel" link

    #check juror has been returned to jurors in waiting
    And I press the "Apps" button
    And I click on the "Juror management" link
    And I click on the "Record attendance" link
    And I click on the "Jurors on a trial" link
    And I see "<trial_number>" in the same row as "1 of 1"

    Examples:
      |user			|juror_number  |  pool_number    | trial_number |
      |MODTESTCOURT |041520012     |  415300201      | TEST2022222  |


  @JurorTransformation @NewSchemaConverted
  Scenario Outline: Return select jurors on a panel to keep panel active

    Given I am on "Bureau" "test"
    Given a bureau owned pool is created with jurors
      | court |juror_number  	        | pool_number	    | att_date_weeks_in_future	| owner |
      | 415   |<juror_number> 	        | <pool_number>     | 5				            | 400	|
      | 415   |<juror_number_2> 	    | <pool_number>     | 5				            | 400	|
      | 415   |<juror_number_2> 	    | <pool_number>     | 5				            | 400	|
      | 415   |<juror_number_3> 	    | <pool_number>     | 5				            | 400	|

    Then a new pool is inserted for where record has transferred to the court new schema
      |part_no               | pool_no          | owner |
      |<juror_number>        | <pool_number>    | 415   |
      |<juror_number_2>      | <pool_number>    | 415   |
      |<juror_number_3>      | <pool_number>    | 415   |

    And I Confirm all the data in the record attendance table is cleared
    And a new trial is inserted with the trial number "<trial_number>"
    And I log in as "<user>"

   #set juror as responded
    And I update juror "<juror_number>" to have a status of responded in order to record attendance
    And I update juror "<juror_number_2>" to have a status of responded in order to record attendance
    And I update juror "<juror_number_3>" to have a status of responded in order to record attendance

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

    And I set "Hour" to "09"
    And I set "Minute" to "00"
    And I set the radio button to "am"
    And I input juror "<juror_number_2>" to be checked in
    And I press the "Check in juror" button
    And I see "<juror_number_2>" in the same row as "9:00am"

    And I set "Hour" to "09"
    And I set "Minute" to "00"
    And I set the radio button to "am"
    And I input juror "<juror_number_3>" to be checked in
    And I press the "Check in juror" button
    And I see "<juror_number_3>" in the same row as "9:00am"

    And I press the "Apps" button
    And I click on the "Trial management" link
    And I click on the trial number "<trial_number>"

    And I press the "Generate panel" button
    And I see "Generate a panel" on the page
    And I see "Which jurors do you want to generate a panel from?" on the page
    And I set the radio button to "All available jurors"
    And I set "Number of jurors needed on this panel" to "3"
    And I press the "Continue" button

    #empanel juror
    And I check the juror "<juror_number>" checkbox
    And I check the juror "<juror_number_2>" checkbox
    And I check the juror "<juror_number_3>" checkbox

    #Empanel jury
    And I press the "Empanel jury" button
    And I see "How many jurors do you want to empanel?" on the page
    And I set number of jurors to empanel to "3"
    And I press the "Continue" button
    And I see "Empanel jury" on the page
    And I see "When you confirm, anyone not used or challenged will be returned to the ‘jurors in waiting’ list." on the page

    And I select the radio button with name "<juror_number>" and value "juror"
    And I select the radio button with name "<juror_number_2>" and value "juror"
    And I select the radio button with name "<juror_number_3>" and value "juror"
    And I press the "Confirm and empanel jury" button
    And I see "Juror" in the same row as "<juror_number>"
    And I see "Juror" in the same row as "<juror_number_2>"
    And I see "Juror" in the same row as "<juror_number_3>"


    #retrurn jury process
    And I check the juror "<juror_number>" checkbox
    And I check the juror "<juror_number_2>" checkbox
    And I press the "Return jury" button
    And I see "How do you want to return the jurors you selected?" on the page
    And I press the "Continue" button
    And I see error "Select how you want to return the jurors"
    And I set the radio button to "Return and confirm attendance"
    And I press the "Continue" button
    And I see "Confirm attendance" on the page
    And I press the "Continue" button

    And I see error "Enter a check in time"
    And I see error "Enter a check out time"

    #check in on confirm attendance
    And I set juror check in hour to "9" on confirm attendance
    And I set juror check in minute to "20" on confirm attendance
    And I click on the am radio button for juror check in on confirm attendance

    #check out on confirm attendance
    And I set juror check out hour to "2" on confirm attendance
    And I set juror check out minute to "30" on confirm attendance
    And I click on the pm radio button for juror check out on confirm attendance

    And I press the "Continue" button
    And I see "Return jurors and confirm attendance" on the page
    And I see "You're returning 2 jurors and confirming their attendance for today." on the page
    And I see "A check in time of 9:20am will be applied to any jurors without a check in time." on the page
    And I see "A check out time of 2:30pm will be applied to all jurors." on the page
    And I see "They'll be returned to the list of jurors in waiting, to continue their service." on the page

    #return juror
    And I press the "Return" button
    And I see "2 jurors returned" on the page

    #check juror is still in trial as they weren't returned
    And I see "Juror" in the same row as "<juror_number_3>"

    Examples:
      |user			|juror_number  |juror_number_2  |juror_number_3 | pool_number  | trial_number |
      |MODTESTCOURT |041520013     |  041520014     |  041520015    |  415300201   | TEST2022223  |


  @JurorTransformation @NewSchemaConverted
  Scenario Outline: Return juror but do not confirm attendance

    Given I am on "Bureau" "test"
    Given a bureau owned pool is created with jurors
      | court |juror_number  	    | pool_number	    | att_date_weeks_in_future	| owner |
      | 415   |<juror_number> 	    | <pool_number>     | 5				            | 400	|

    Then a new pool is inserted for where record has transferred to the court new schema
      |part_no               | pool_no           | owner |
      |<juror_number>       | <pool_number>      | 415   |

    And I Confirm all the data in the record attendance table is cleared
    And a new trial is inserted with the trial number "<trial_number>"
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

    #retrurn jury process
    And I check the juror "<juror_number>" checkbox
    And I press the "Return jury" button
    And I see "How do you want to return the juror you selected?" on the page
    And I set the radio button to "Return but do not confirm attendance"
    And I press the "Continue" button

    And I see "Return jurors without confirming attendance" on the page
    And I see "You're returning 1 juror." on the page
    And I set "Hour" to "09"
    And I set "Minute" to "00"
    And I set the radio button to "am"
    And I see "You have not confirmed their attendance yet. You’ll need to do this separately." on the page

    And I press the "Return" button
    And I verify the text "Do you want to end this trial?" on the page
    And I choose the "No" radio button
    And I press the "Continue" button
    And I see "1 juror returned" on the page

    #check juror has been returned to jurors in waiting
    And I press the "Apps" button
    And I click on the "Juror management" link
    And I click on the "Record attendance" link
    And I see "<juror_number>" in the same row as "Responded"


    Examples:
      |user			|juror_number  |  pool_number    | trial_number |
      |MODTESTCOURT |041520016     |  415300201      | TEST2022224  |


  @JurorTransformation @NewSchemaConverted
  Scenario Outline: Return juror and complete their service

    Given I am on "Bureau" "test"

    Given a bureau owned pool is created with jurors
      | court |juror_number  	    | pool_number	    | att_date_weeks_in_future	| owner |
      | 415   |<juror_number> 	    | <pool_number>     | 5				            | 400	|

    Then a new pool is inserted for where record has transferred to the court new schema
      |part_no          | pool_no           | owner |
      |<juror_number>   | <pool_number>     | 415   |

    And I Confirm all the data in the record attendance table is cleared
    And a new trial is inserted with the trial number "<trial_number>"
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

    #Empanel jury
    And I check the juror "<juror_number>" checkbox
    And I press the "Empanel jury" button
    And I see "How many jurors do you want to empanel?" on the page
    And I set number of jurors to empanel to "1"
    And I press the "Continue" button
    And I see "Empanel jury" on the page
    And I see "When you confirm, anyone not used or challenged will be returned to the ‘jurors in waiting’ list." on the page

    And I select the radio button with name "<juror_number>" and value "juror"
    And I press the "Confirm and empanel jury" button
    And I see "Juror" in the same row as "<juror_number>"

    #retrurn jury process
    And I check the juror "<juror_number>" checkbox
    And I press the "Return jury" button
    And I see "How do you want to return the juror you selected?" on the page
    And I set the radio button to "Return, confirm attendance and complete their service"
    And I press the "Continue" button

    And I see "Confirm attendance" on the page
    And I press the "Continue" button

    And I see error "Enter a check in time"
    And I see error "Enter a check out time"

    #check in on confirm attendance
    And I set juror check in hour to "9" on confirm attendance
    And I set juror check in minute to "20" on confirm attendance
    And I click on the am radio button for juror check in on confirm attendance

    #check out on confirm attendance
    And I set juror check out hour to "2" on confirm attendance
    And I set juror check out minute to "30" on confirm attendance
    And I click on the pm radio button for juror check out on confirm attendance

    And I press the "Continue" button
    And I see "Return jurors and complete their service" on the page
    And I see "You're returning 1 juror and confirming their attendance for today." on the page
    And I see "Their service will be completed." on the page
    And I press the "Return" button

    And I verify the text "Do you want to end this trial?" on the page
    And I choose the "No" radio button
    And I press the "Continue" button
    And I see "1 juror returned" on the page

    #check jurors service has been completed
    When the user searches for juror record "<juror_number>" from the global search bar
    And I see the juror status has updated to "Completed"

    Examples:
      |user			|juror_number  |  pool_number    | trial_number |
      |MODTESTCOURT |041520017     |  415300201      | TEST2022225  |


  @JurorTransformation @NewSchemaConverted
  Scenario Outline: Attempt to end trial for panel which is still active

    Given I am on "Bureau" "test"
    Given a bureau owned pool is created with jurors
      | court |juror_number  	    | pool_number	    | att_date_weeks_in_future	| owner |
      | 415   |<juror_number> 	    | <pool_number>     | 5				            | 400	|
      | 415   |<juror_number_2>     | <pool_number>     | 5				            | 400	|

    Then a new pool is inserted for where record has transferred to the court new schema
      |part_no              | pool_no           | owner |
      |<juror_number>       | <pool_number>     | 415   |
      |<juror_number_2>     | <pool_number>     | 415   |

    And I Confirm all the data in the record attendance table is cleared
    And a new trial is inserted with the trial number "<trial_number>"
    And I log in as "<user>"

    #set juror as responded
    And I update juror "<juror_number>" to have a status of responded in order to record attendance
    And I update juror "<juror_number_2>" to have a status of responded in order to record attendance

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

    And I set "Hour" to "09"
    And I set "Minute" to "00"
    And I set the radio button to "am"
    And I input juror "<juror_number_2>" to be checked in
    And I press the "Check in juror" button

    And I see "<juror_number>" in the same row as "9:00am"
    And I see "<juror_number_2>" in the same row as "9:00am"

    And I press the "Apps" button
    And I click on the "Trial management" link
    And I click on the trial number "<trial_number>"

    And I press the "Generate panel" button
    And I see "Generate a panel" on the page
    And I see "Which jurors do you want to generate a panel from?" on the page
    And I set the radio button to "All available jurors"
    And I set "Number of jurors needed on this panel" to "2"
    And I press the "Continue" button

    #empanel juror
    And I check the juror "<juror_number>" checkbox
    And I check the juror "<juror_number_2>" checkbox

    #Empanel jury
    And I press the "Empanel jury" button
    And I see "How many jurors do you want to empanel?" on the page
    And I set number of jurors to empanel to "2"
    And I press the "Continue" button
    And I see "Empanel jury" on the page
    And I see "When you confirm, anyone not used or challenged will be returned to the ‘jurors in waiting’ list." on the page

    And I select the radio button with name "<juror_number>" and value "juror"
    And I select the radio button with name "<juror_number_2>" and value "juror"
    And I press the "Confirm and empanel jury" button
    And I see "Juror" in the same row as "<juror_number>"
    And I see "Juror" in the same row as "<juror_number_2>"

    #retrurn jury process for just one of the jurors
    And I check the juror "<juror_number>" checkbox
    And I press the "Return jury" button
    And I see "How do you want to return the juror you selected?" on the page
    And I press the "Continue" button
    And I see error "Select how you want to return the juror"
    And I set the radio button to "Return and confirm attendance"
    And I press the "Continue" button
    And I see "Confirm attendance" on the page
    And I press the "Continue" button

    And I see error "Enter a check in time"
    And I see error "Enter a check out time"

    #check in on confirm attendance
    And I set juror check in hour to "9" on confirm attendance
    And I set juror check in minute to "20" on confirm attendance
    And I click on the am radio button for juror check in on confirm attendance

    #check out on confirm attendance
    And I set juror check out hour to "2" on confirm attendance
    And I set juror check out minute to "30" on confirm attendance
    And I click on the pm radio button for juror check out on confirm attendance

    And I press the "Continue" button
    And I see "Return jurors and confirm attendance" on the page
    And I see "You're returning 1 juror and confirming their attendance for today." on the page
    And I see "A check in time of 9:20am will be applied to any juror without a check in time." on the page
    And I see "A check out time of 2:30pm will be applied to all juror." on the page
    And I see "They'll be returned to the list of jurors in waiting, to continue their service." on the page

    #return juror
    And I press the "Return" button
    And I see "1 juror returned" on the page

    #check juror number 2 is still present in panel
    And I see "Juror" in the same row as "<juror_number_2>"

    And I press the "End trial" button
    And I see "You must return all jurors before you can end this trial" on the page


    Examples:
      |user			|juror_number  | juror_number_2 |   pool_number    | trial_number |
      |MODTESTCOURT |041520018     | 041520019      |    415300201      | TEST2022226  |


  @JurorTransformation @NewSchemaConverted
  Scenario Outline: Happy path to create a trial then return all the jurors and end trial

    Given I am on "Bureau" "test"
    Given a bureau owned pool is created with jurors
      | court |juror_number  	    | pool_number	    | att_date_weeks_in_future	| owner |
      | 415   |<juror_number_1>     | <pool_number>     | 5				            | 400	|
      | 415   |<juror_number_2> 	| <pool_number>     | 5				            | 400	|

    Then a new pool is inserted for where record has transferred to the court new schema
      |part_no              | pool_no           | owner |
      |<juror_number_1>     | <pool_number>     | 415   |
      |<juror_number_2>     | <pool_number>      | 415   |

    And I Confirm all the data in the record attendance table is cleared
    And a new trial is inserted with the trial number "<trial_number>"
    And I log in as "<user>"

   #set juror as responded
    And I update juror "<juror_number_1>" to have a status of responded in order to record attendance
    And I update juror "<juror_number_2>" to have a status of responded in order to record attendance

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

    Then I see "<juror_number_1>" in the same row as "9:00am"
    And I see "<juror_number_2>" in the same row as "11:30am"

    And I press the "Apps" button
    And I click on the "Trial management" link
    And I click on the trial number "<trial_number>"

    When I press the "Generate panel" button
    Then I see "Generate a panel" on the page
    And I see "Which jurors do you want to generate a panel from?" on the page
    And I set the radio button to "All available jurors"
    And I set "Number of jurors needed on this panel" to "2"
    When I press the "Continue" button

    #empanel juror
    And I check the juror "<juror_number_1>" checkbox
    And I check the juror "<juror_number_2>" checkbox

    #Empanel jury
    And I press the "Empanel jury" button
    And I see "How many jurors do you want to empanel?" on the page
    And I set number of jurors to empanel to "2"
    And I press the "Continue" button
    And I see "Empanel jury" on the page
    And I see "When you confirm, anyone not used or challenged will be returned to the ‘jurors in waiting’ list." on the page

    And I select the radio button with name "<juror_number_1>" and value "juror"
    And I select the radio button with name "<juror_number_2>" and value "juror"
    And I press the "Confirm and empanel jury" button
    And I see "Juror" in the same row as "<juror_number_1>"
    And I see "Juror" in the same row as "<juror_number_2>"

    #retrurn jury process for all jurors
    When I check the juror "<juror_number_1>" checkbox
    And I check the juror "<juror_number_2>" checkbox
    And I press the "Return jury" button
    And I see "How do you want to return the jurors you selected?" on the page
    And I set the radio button to "Return and confirm attendance"
    And I press the "Continue" button
    Then I see "Confirm attendance" on the page

    #check in on confirm attendance
    When I set juror check in hour to "9" on confirm attendance
    And I set juror check in minute to "20" on confirm attendance
    And I click on the am radio button for juror check in on confirm attendance

    #check out on confirm attendance
    And I set juror check out hour to "2" on confirm attendance
    And I set juror check out minute to "30" on confirm attendance
    And I click on the pm radio button for juror check out on confirm attendance

    And I press the "Continue" button
    Then I see "Return jurors and confirm attendance" on the page
    And I see "You're returning 2 jurors and confirming their attendance for today." on the page

    #End the trial
    When I press the "Return" button
    Then I verify the text "Do you want to end this trial?" on the page
    And I see "Continue" on the page
    And I choose the "Yes" radio button
    And I press the "Continue" button

    Then I verify the banner message "2 jurors returned and trial ended" on the page
    And I see "John Stark" in the same row as "Defendants"
    And I see "Criminal" in the same row as "Trial type"
    And I see "Trial start date" on the page
    And I see "Trial end date" on the page
    And I see "PATRICIA H AITKEN" in the same row as "Judge"
    And I see "Jury Assembly Room" in the same row as "Courtroom"
    And I see "No" in the same row as "Protected?"

    Examples:
      |user			|juror_number_1  | juror_number_2 |   pool_number    | trial_number |
      |MODTESTCOURT |041520020       | 041520021      |    415300201     | TEST2022226  |