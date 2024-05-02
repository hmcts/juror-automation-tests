Feature: JM-5072 - Dismiss random jurors

  @JurorTransformationMulti @NewSchemaConverted
  Scenario Outline: As a jury officer I want to dismiss random jurors - Happy Path

    Given I am on "Bureau" "test"
    Given a bureau owned pool is created with jurors
      | court |juror_number  	        | pool_number	    | att_date_weeks_in_future	    | owner |
      | 415   |<juror_number> 	        | <pool_number>     | -3			                | 400	|
      | 415   |<juror_number_2> 	    | <pool_number>     | -3				            | 400	|

    Then a new pool is inserted for where record has transferred to the court new schema
      |part_no               | pool_no          | owner |
      |<juror_number>        | <pool_number>    | 415   |
      |<juror_number_2>      | <pool_number>    | 415   |

    And I Confirm all the data in the record attendance table is cleared
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
    And I see "<juror_number>" in the same row as "9:00am"

    And I set "Hour" to "09"
    And I set "Minute" to "00"
    And I set the radio button to "am"
    And I input juror "<juror_number_2>" to be checked in
    And I press the "Check in juror" button
    And I see "<juror_number_2>" in the same row as "9:00am"
    
    #dismiss jurors
    And I press the "Apps" button
    And I click on the "Juror management" link

    And I press the "Dismiss jurors" button
    And I see "Dismiss jurors" on the page
    And I see "Select which pools to include" on the page
    And I see "2" in the same row as "<pool_number>"
    And I check the "<pool_number>" checkbox
    And I press the calculate available jurors button

    #this will fail here because of JM-6374
    And I see "Number of available jurors from selected pools" on the page
    And I see "2 jurors available to dismiss" on the page
    And I see "How many of these jurors do you want to dismiss?" on the page
    And I set "How many of these jurors do you want to dismiss?" to "2"
    And I press the "Generate list of jurors to dismiss" button
    
    And I see "Select jurors to dismiss" on the page
    And I check the select all checkbox
    And I press the "Dismiss selected jurors" button

    And I see "Some jurors have not been checked out" on the page
    And I set "Hour" to "7"
    And I set "Minute" to "00"
    And I set the radio button to "pm"
    Then I press the "Continue" button
    
    And I see "Complete service" on the page
    And I set the "Completion date" date to a Monday "-2" weeks in the future
    And I press the "Complete service" button
    And I see the banner for dismissed jurors containing "2 jurors dismissed and service completed."

    And the user searches for juror record "<juror_number>" from the global search bar
    And I see the juror status has updated to "Completed"

    And the user searches for juror record "<juror_number_2>" from the global search bar
    And I see the juror status has updated to "Completed"

    Examples:
      |user			|juror_number    | juror_number_2  |   pool_number    |
      |MODTESTCOURT |041588770       | 041588773       |    415388671     |


  @JurorTransformationMulti @NewSchemaConverted
  Scenario Outline:   As a jury officer I want to dismiss random jurors - Unhappy Path

    Given I am on "Bureau" "test"
    Given a bureau owned pool is created with jurors
      | court |juror_number  	        | pool_number	    | att_date_weeks_in_future	    | owner |
      | 415   |<juror_number> 	        | <pool_number>     | -3			                | 400	|
      | 415   |<juror_number_2> 	    | <pool_number>     | -3				            | 400	|
      | 415   |<juror_number_3> 	    | <pool_number>     | -3				            | 400	|

    Then a new pool is inserted for where record has transferred to the court new schema
      |part_no               | pool_no          | owner |
      |<juror_number>        | <pool_number>    | 415   |
      |<juror_number_2>      | <pool_number>    | 415   |
      |<juror_number_3>      | <pool_number>    | 415   |

    And I Confirm all the data in the record attendance table is cleared
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

    And the user searches for juror record "<juror_number_3>" from the global search bar
    And I click on the "Attendance" link
    And I click on the "Change" link
    And I check the "Put juror on call" checkbox
    And I press the "Save" button
    Then I see "On call" in the same row as "Next due at court"

    And I press the "Apps" button
    And I click on the "Juror management" link

    And I press the "Dismiss jurors" button
    And I see "Dismiss jurors" on the page
    And I see "Select which pools to include" on the page
    And I press the "Generate list of jurors to dismiss" button
    And I see error "Select at least one pool"
    And I see error "Enter how many jurors you want to dismiss"

    And I check the "<pool_number>" checkbox
    And I set "How many of these jurors do you want to dismiss?" to "3"
    And I press the "Generate list of jurors to dismiss" button
    And I see error "Amount of jurors to dismiss must be 2 or fewer"
    And I check the "Include jurors on call" checkbox
    And I check the "Include others not in attendance" checkbox
    Then I press the "Generate list of jurors to dismiss" button

    And I check the select all checkbox
    And I press the "Dismiss selected jurors" button
    And I see "Some jurors have not been checked out" on the page
    And I set "Hour" to "8"
    And I set "Minute" to "00"
    And I set the radio button to "am"
    Then I press the "Continue" button
    And I see error "Check out time must be after checked in time for all jurors"
    And I set "Hour" to "7"
    And I set "Minute" to "00"
    And I set the radio button to "pm"
    Then I press the "Continue" button
    
    And I see "Complete service" on the page
    And I set the "Completion date" date to a Monday "-2" weeks in the future
    And I press the "Complete service" button
    And I see the banner for dismissed jurors containing "3 jurors dismissed and service completed."

    And the user searches for juror record "<juror_number>" from the global search bar
    And I see the juror status has updated to "Completed"

    And the user searches for juror record "<juror_number_2>" from the global search bar
    And I see the juror status has updated to "Completed"

    And the user searches for juror record "<juror_number_3>" from the global search bar
    And I see the juror status has updated to "Completed"


    Examples:
      |user			|juror_number    | juror_number_2  | juror_number_3  |   pool_number    |
      |MODTESTCOURT |041588774       | 041588775       | 041588776       |    415388775     |
