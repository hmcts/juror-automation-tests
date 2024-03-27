Feature: JM-4365-As a jury officer I need to be able to check jurors out for their attendance on the day

  @JurorTransformation @NewSchemaConverted
  Scenario Outline: Happy path to Check jurors out for their attendance on the day

    #return to single thread when fixed, not multi

    Given I am on "Bureau" "test"
    When a bureau owned pool is created with jurors
      | court |juror_number  	    | pool_number	    | att_date_weeks_in_future	| owner |
      | 415   |<juror_number_1>     | <pool_number>     | 5				            | 400	|
      | 415   |<juror_number_2> 	| <pool_number>     | 5				            | 400	|
      | 415   |<juror_number_3> 	| <pool_number>     | 5				            | 400	|
      | 415   |<juror_number_4> 	| <pool_number>     | 5				            | 400	|

    Then a new pool is inserted for where record has transferred to the court new schema
      |part_no              | pool_no           | owner |
      |<juror_number_1>     | <pool_number>     | 415   |
      |<juror_number_2>     | <pool_number>      | 415   |
      |<juror_number_3>     | <pool_number>      | 415   |
      |<juror_number_4>     | <pool_number>      | 415   |

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
    And I am able to see and interact with the Record attendance tabs and fields

    #check out 4 jurors
    And I set the radio button to "Check out"
    And I set "Hour" to "4"
    And I set "Minute" to "00"
    And I select the checkout radio button to "pm"
    And I input juror "<juror_number_1>" to be checked out
    And I press the "Check out juror" button
    And I set "Hour" to "5"
    And I set "Minute" to "30"
    And I select the checkout radio button to "pm"
    And I input juror "<juror_number_2>" to be checked out
    And I press the "Check out juror" button
    And I set "Hour" to "6"
    And I set "Minute" to "30"
    And I select the checkout radio button to "pm"
    And I input juror "<juror_number_3>" to be checked out
    And I press the "Check out juror" button
    And I set "Hour" to "7"
    And I set "Minute" to "30"
    And I select the checkout radio button to "pm"
    And I input juror "<juror_number_4>" to be checked out
    When I press the "Check out juror" button
    Then I see "<juror_number_1>" in the same row as "4:00pm"
    And I see "<juror_number_2>" in the same row as "5:30pm"
    And I see "<juror_number_3>" in the same row as "6:30pm"
    And I see "<juror_number_4>" in the same row as "7:30pm"

    #change link
    When I click on "Change" in the same row as "<juror_number_1>"
    And I am able to see and interact with the change time and fields for "fname lname"
    Then I see "Save changes" on the page
    And I see "Cancel" on the page
    And I see "Delete attendance and mark as absent" on the page
    And I set "Hour" to "10"
    And I set "Minute" to "00"
    And I set the radio button to "am"
    And I set "check out" "Hour" to "8"
    And I set "check out" "Minute" to "00"
    And I select the checkout radio button to "pm"
    And I press the "Save changes" button
    Then I see "10:00am" in the same row as "<juror_number_1>"
    Then I see "8:00pm" in the same row as "<juror_number_1>"

    #delete attendance
    When I click on "Change" in the same row as "<juror_number_1>"
    And I click on the "Delete attendance and mark as absent" link
    Then I see "Are you sure you want to delete attendance for fname lname?" on the page
    And  I see "Yes - delete" on the page
    And I see "Cancel" on the page
    When I press the "Yes - delete" button
    Then I do not see "<juror_number_1>" on the page

    Examples:
      |user			|juror_number_1 | juror_number_2  |   juror_number_3 |juror_number_4 |    pool_number   | trial_number |
      |MODTESTCOURT |041530007      | 041530008        |041530009       |  041530010    | 415300301        | T202495832   |


  @JurorTransformationWIP @NewSchemaConverted @JM-6720
  Scenario Outline: To confirm all the jurors  attendance on the day

    Given I am on "Bureau" "test"
    When a bureau owned pool is created with jurors
      | court |juror_number  	    | pool_number	    | att_date_weeks_in_future	| owner |
      | 415   |<juror_number_1>     | <pool_number>     | 5				            | 400	| 
      | 415   |<juror_number_2> 	| <pool_number>     | 5				            | 400	|
      | 415   |<juror_number_3> 	| <pool_number>     | 5				            | 400	|
      | 415   |<juror_number_4> 	| <pool_number>     | 5				            | 400	|

    Then a new pool is inserted for where record has transferred to the court new schema
      |part_no              | pool_no           | owner |
      |<juror_number_1>     | <pool_number>     | 415   |
      |<juror_number_2>     | <pool_number>      | 415   |
      |<juror_number_3>     | <pool_number>      | 415   |
      |<juror_number_4>     | <pool_number>      | 415   |

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

    #Confirm all the attendence
    When I press the "Confirm attendance" button
    Then I see "Some jurors have not been checked out" on the page
    And The system shall display the non editable details on the Confirm attendance screen
    And I press the "Continue" button
    And I see error "Enter a check out time"
    And I set "Hour" to "05"
    And I set "Minute" to "00"
    And I set the radio button to "pm"
    When I press the "Continue" button
    Then I see "Confirm attendance list" on the page
    And I see "jurors attended court today" on the page
    And I see "jurors were due to attend today but were not checked in" on the page
    And I see "Confirm attendance list is correct" on the page
    And I see "Back to attendance list" on the page
    When I press the "Confirm attendance list is correct" button
    #Below step will fail due to JM-6720
    Then I do not see "Confirm attendence " on the page
    And I do not see " Change" on the page
    And I do not see "Check in" on the page
    And I do not see "Check out" on the page
    And I am able to see and interact with the Record attendance confirmation screen

    Examples:
      |user			|juror_number_1 | juror_number_2  |   juror_number_3 |juror_number_4 |    pool_number   | trial_number |
      |MODTESTCOURT |041530007      | 041530008        |041530009       |  041530010     | 415300301        | T202495832   |
