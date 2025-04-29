Feature: JS-312 - As a court officer I want to be able to add non attendance days in bulk for certain jurors

  @JurorTransformation @NewSchemaConverted
  Scenario Outline: Add non attendance day for juror via panel

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

    #non attendance
    And I check the juror "<juror_number>" checkbox
    And I press the "Add non-attendance day" button
    And I set non-attendance date to "12" weeks from now
    And I press confirm non-attendance day button
    When the user searches for juror record "<juror_number>" from the global search bar
    And I click on the "Attendance" link
    Then I see the date "12" weeks from now in the same row as "Non-attendance day"



    Examples:
      |user			|juror_number  |  pool_number    | trial_number |
      |MODTESTCOURT |041584531     |  415387215      | TRIALLLL112  |



  @JurorTransformation @NewSchemaConverted
  Scenario Outline: Add non attendance day for juror via pool

    Given I am on "Bureau" "ithc"

    Given a bureau owned pool is created with jurors
      | court |juror_number  	    | pool_number	    | att_date_weeks_in_future	| owner |
      | 415   |<juror_number> 	    | <pool_number>     | 5				            | 400	|

    Then a new pool is inserted for where record has transferred to the court new schema
      |part_no              | pool_no           | owner |
      |<juror_number>       | <pool_number>     | 415   |

    And I Confirm all the data in the record attendance table is cleared
    And I log in as "<user>"

    #set juror as responded
    And I update juror "<juror_number>" to have a status of responded in order to record attendance

    #check in juror
    And I press the "Apps" button
    And I click on the "Pool management" link
    And I click on the "Search" link
    And I set "Pool number" to "<pool_number>"
    And I press the "Continue" button

    #non attendance
    And I check the juror "<juror_number>" checkbox
    And I press the "Add non-attendance day" button
    And I set non-attendance date to "12" weeks from now
    And I press confirm non-attendance day button
    When the user searches for juror record "<juror_number>" from the global search bar
    And I click on the "Attendance" link
    Then I see the date "12" weeks from now in the same row as "Non-attendance day"



    Examples:
      |user			|juror_number  |  pool_number    |
      |MODTESTCOURT |041584533     |  415387216      |


  @JurorTransformation @NewSchemaConverted
  Scenario Outline: Add non attendance day for juror via pool - Unhappy Path

    Given I am on "Bureau" "ithc"

    Given a bureau owned pool is created with jurors
      | court |juror_number  	    | pool_number	    | att_date_weeks_in_future	| owner |
      | 415   |<juror_number> 	    | <pool_number>     | 5				            | 400	|
      | 415   |<juror_number1> 	    | <pool_number>     | 5				            | 400	|

    Then a new pool is inserted for where record has transferred to the court new schema
      |part_no              | pool_no           | owner |
      |<juror_number>       | <pool_number>     | 415   |
      |<juror_number1>       | <pool_number>     | 415   |

    And I Confirm all the data in the record attendance table is cleared
    And I log in as "<user>"

    #set juror as responded
    And I update juror "<juror_number>" to have a status of responded in order to record attendance

    #check in juror
    And I press the "Apps" button
    And I click on the "Pool management" link
    And I click on the "Search" link
    And I set "Pool number" to "<pool_number>"
    And I press the "Continue" button

    #non attendance
    And I check the juror "<juror_number>" checkbox
    And I check the juror "<juror_number1>" checkbox
    And I press the "Add non-attendance day" button
    And I set non-attendance date to "12" weeks from now
    And I press confirm non-attendance day button
    And I see error "You cannot mark this date as a non-attendance day because one or more jurors are in summoned status."


    Examples:
      |user			|juror_number |juror_number1 |  pool_number    |
      |MODTESTCOURT |041584533    |041584538     |  415387216      |