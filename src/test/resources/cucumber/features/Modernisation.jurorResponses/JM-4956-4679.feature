Feature: JM-4956 - 4679

  @JurorTransformation @NewSchemaConverted
  Scenario Outline: Create a Trial and Generate Panel

    Given I am on "Bureau" "test"

    Given a bureau owned pool is created with jurors
      | court |juror_number  	    | pool_number	    | att_date_weeks_in_future	| owner |
      | 415   |<juror_number> 	    | <pool_number>     | 5				            | 400	|
      | 415   |<juror_number_2> 	| <pool_number>     | 5				            | 400	|

    Then a new pool is inserted for where record has transferred to the court new schema
      |part_no               | pool_no           | owner |
      |<juror_number>       | <pool_number>      | 415   |
      |<juror_number_2>     | <pool_number>      | 415   |

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
    And I set "Hour" to "11"
    And I set "Minute" to "30"
    And I set the radio button to "am"
    And I input juror "<juror_number_2>" to be checked in
    And I press the "Check in juror" button

    And I see "<juror_number>" in the same row as "9:00am"
    And I see "<juror_number_2>" in the same row as "11:30am"

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
    And I set "Number of jurors needed on this panel" to "2"
    And I press the "Continue" button

    #see my jurors are panelled
    And I see "<juror_number>" in the same row as "Panel"
    And I see "<juror_number_2>" in the same row as "Panel"

    And I check the juror "<juror_number>" checkbox
    And I check the juror "<juror_number>_2" checkbox

    #check my jurors are panelled in attendance list
    And I press the "Apps" button
    And I click on the "Juror management" link
    And I click on the "Record attendance" link
    And I see "<juror_number>" in the same row as "Panel"
    And I see "<juror_number_2>" in the same row as "Panel"

    Examples:
      |user			|juror_number  | juror_number_2  | pool_number   | trial_number |
      |MODTESTCOURT |041520001     | 041520002        |415300207     | T202495831   |


  @JurorTransformation @NewSchemaConverted
  Scenario Outline: Generate a Panel for a Protected Trial

    Given I am on "Bureau" "test"

    Given a bureau owned pool is created with jurors
      | court |juror_number  	    | pool_number	    | att_date_weeks_in_future	| owner |
      | 415   |<juror_number> 	    | <pool_number>     | 5				            | 400	|

    Then a new pool is inserted for where record has transferred to the court new schema
      |part_no              | pool_no           | owner |
      |<juror_number>       | <pool_number>     | 415   |

    And I Confirm all the data in the record attendance table is cleared
    And a new protected trial is inserted with the trial number "<trial_number>"
    And I log in as "<user>"

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
    And I set the radio button to "All available jurors"
    And I set "Number of jurors needed on this panel" to "1"
    And I press the "Continue" button

    #see my jurors are anonymous
    #this will fail here as a result of JM-5972

    Examples:
      |user			|juror_number   | pool_number   | trial_number |
      |MODTESTCOURT |041520003      | 415300209     | T202495831   |


  @JurorTransformation @NewSchemaConverted
  Scenario Outline: Create a Trial and Generate Panel from a specific pool

    Given I am on "Bureau" "test"

    Given a bureau owned pool is created with jurors
      | court |juror_number  	    | pool_number	    | att_date_weeks_in_future	| owner |
      | 415   |<juror_number> 	    | <pool_number>     | 5				            | 400	|
      | 415   |<juror_number_2> 	| <pool_number>     | 5				            | 400	|

    Then a new pool is inserted for where record has transferred to the court new schema
      |part_no             | pool_no                | owner |
      |<juror_number>      | <pool_number>          | 415   |
      |<juror_number_2>    | <pool_number>          | 415   |

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

    And I set "Hour" to "09"
    And I set "Minute" to "00"
    And I set the radio button to "am"
    And I input juror "<juror_number_2>" to be checked in
    And I press the "Check in juror" button

    And I press the "Apps" button
    And I click on the "Trial management" link
    And I click on the trial number "<trial_number>"

    And I press the "Generate panel" button
    And I see "Generate a panel" on the page
    And I see "Which jurors do you want to generate a panel from?" on the page
    And I press the "Continue" button
    And I see error "Select which group of jurors you want to generate a panel from"
    And I see error "Enter how many jurors are needed on this panel"
    And I set the radio button to "Jurors from one or more specific pools"
    And I set "Number of jurors needed on this panel" to "2"
    And I press the "Continue" button

    And I see "Select jurors from one or more pools" on the page
    And I check the pool number checkbox on the select specific pool page on create panel
    And I press the "Continue" button

    And I see "<juror_number>" in the same row as "Panel"
    And I see "<juror_number_2>" in the same row as "Panel"

    Examples:
      |user			|juror_number  | juror_number_2  | pool_number   | trial_number |
      |MODTESTCOURT |041520004     | 041520005       |415300213      | T2024111111  |


  @JurorTransformation @NewSchemaConverted
  Scenario Outline: JM-4679 -  Generate a panel and then empanel - Happy Path

    Given I am on "Bureau" "test"

    Given a bureau owned pool is created with jurors
      | court |juror_number  	    | pool_number	    | att_date_weeks_in_future	| owner |
      | 415   |<juror_number> 	    | <pool_number>     | 5				            | 400	|
      | 415   |<juror_number_2> 	| <pool_number>     | 5				            | 400	|
      | 415   |<juror_number_3> 	| <pool_number>     | 5				            | 400	|

    Then a new pool is inserted for where record has transferred to the court new schema
      |part_no               | pool_no       | owner|
      |<juror_number>        | <pool_number> | 415  |
      |<juror_number_2>      | <pool_number> | 415  |
      |<juror_number_3>      | <pool_number> | 415  |

    And I Confirm all the data in the record attendance table is cleared
    And a new trial is inserted with the trial number "<trial_number>"
    And I log in as "<user>"

    #set juror as responded
    And I update juror "<juror_number>" to have a status of responded in order to record attendance
    And I update juror "<juror_number_2>" to have a status of responded in order to record attendance
    And I update juror "<juror_number_3>" to have a status of responded in order to record attendance

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

    And I set "Hour" to "10"
    And I set "Minute" to "00"
    And I set the radio button to "am"
    And I input juror "<juror_number_2>" to be checked in
    And I press the "Check in juror" button

    And I set "Hour" to "11"
    And I set "Minute" to "00"
    And I set the radio button to "am"
    And I input juror "<juror_number_3>" to be checked in
    And I press the "Check in juror" button

    And I see "<juror_number>" in the same row as "9:00am"
    And I see "<juror_number_2>" in the same row as "10:00am"
    And I see "<juror_number_3>" in the same row as "11:00am"


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
    And I set number of jurors to empanel to "10"
    And I press the "Continue" button
    And I see error "You must select a number between 1 and 3"
    And I set number of jurors to empanel to "1"
    And I press the "Continue" button
    And I see "Empanel jury" on the page
    And I see "When you confirm, anyone not used or challenged will be returned to the ‘jurors in waiting’ list." on the page

    And I select the radio button with name "<juror_number_3>" and value "juror"
    And I select the radio button with name "<juror_number>" and value "unused"
    And I select the radio button with name "<juror_number_2>" and value "challenged"
    And I see "When you confirm, anyone not used or challenged will be returned to the ‘jurors in waiting’ list." on the page
    And I see "1 selected of 1 jurors needed" on the page

    #jurors set to JUROR will still show in panel with status of Juror
    And I press the "Confirm and empanel jury" button
    And I see "Juror" in the same row as "<juror_number_3>"

    #jurors set to Not used or Challenged will be removed from panel and placed in jurors in waiting under status Responded
    And I press the "Apps" button
    And I click on the "Juror management" link
    And I click on the "Record attendance" link
    And I see "Responded" in the same row as "<juror_number>"
    And I see "Responded" in the same row as "<juror_number_2>"

    Examples:
      |user			|juror_number  | juror_number_2  |juror_number_3   | pool_number    | trial_number |
      |MODTESTCOURT |041520006     | 041520007       |041520008        | 415300211      | T202495831   |


  @JurorTransformation @NewSchemaConverted
  Scenario Outline: JM-4679 -  Generate a panel and then empanel - Unhappy Path

    Given I am on "Bureau" "test"

    Given a bureau owned pool is created with jurors
      | court |juror_number  	    | pool_number	    | att_date_weeks_in_future	| owner |
      | 415   |<juror_number> 	    | <pool_number>     | 5				            | 400	|
      | 415   |<juror_number_2> 	| <pool_number>     | 5				            | 400	|
      | 415   |<juror_number_3> 	| <pool_number>     | 5				            | 400	|
      | 415   |<juror_number_4> 	| <pool_number>     | 5				            | 400	|
      | 415   |<juror_number_5> 	| <pool_number>     | 5				            | 400	|

    Then a new pool is inserted for where record has transferred to the court new schema
      |part_no            | pool_no          | owner|
      |<juror_number>     | <pool_number>    | 415  |
      |<juror_number_2>   | <pool_number>    | 415  |
      |<juror_number_3>   | <pool_number>    | 415  |
      |<juror_number_4>   | <pool_number>    | 415  |
      |<juror_number_5>   | <pool_number>    | 415  |

    And I Confirm all the data in the record attendance table is cleared
    And a new trial is inserted with the trial number "<trial_number>"
    And I log in as "<user>"

    And I update juror "<juror_number>" to have a status of responded in order to record attendance
    And I update juror "<juror_number_2>" to have a status of responded in order to record attendance
    And I update juror "<juror_number_3>" to have a status of responded in order to record attendance
    And I update juror "<juror_number_4>" to have a status of responded in order to record attendance
    And I update juror "<juror_number_5>" to have a status of responded in order to record attendance

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

    And I set "Hour" to "10"
    And I set "Minute" to "00"
    And I set the radio button to "am"
    And I input juror "<juror_number_2>" to be checked in
    And I press the "Check in juror" button

    And I set "Hour" to "11"
    And I set "Minute" to "00"
    And I set the radio button to "am"
    And I input juror "<juror_number_3>" to be checked in
    And I press the "Check in juror" button

    And I set "Hour" to "11"
    And I set "Minute" to "20"
    And I set the radio button to "am"
    And I input juror "<juror_number_4>" to be checked in
    And I press the "Check in juror" button

    And I set "Hour" to "11"
    And I set "Minute" to "30"
    And I set the radio button to "am"
    And I input juror "<juror_number_5>" to be checked in
    And I press the "Check in juror" button


    And I see "<juror_number>" in the same row as "9:00am"
    And I see "<juror_number_2>" in the same row as "10:00am"
    And I see "<juror_number_3>" in the same row as "11:00am"
    And I see "<juror_number_4>" in the same row as "11:20am"
    And I see "<juror_number_5>" in the same row as "11:30am"

    And I press the "Apps" button
    And I click on the "Trial management" link
    And I click on the trial number "<trial_number>"

    And I press the "Generate panel" button
    And I see "Generate a panel" on the page
    And I see "Which jurors do you want to generate a panel from?" on the page
    And I set the radio button to "All available jurors"
    And I set "Number of jurors needed on this panel" to "5"
    And I press the "Continue" button

    #empanel juror
    And I check the juror "<juror_number>" checkbox
    And I check the juror "<juror_number_2>" checkbox
    And I check the juror "<juror_number_3>" checkbox
    And I check the juror "<juror_number_4>" checkbox
    And I check the juror "<juror_number_5>" checkbox

    #Empanel jury
    And I press the "Empanel jury" button
    And I see "How many jurors do you want to empanel?" on the page
    And I set number of jurors to empanel to "10"
    And I press the "Continue" button
    And I see error "You must select a number between 1 and 5"
    And I set number of jurors to empanel to "1"
    And I press the "Continue" button
    And I see "Empanel jury" on the page
    And I see "When you confirm, anyone not used or challenged will be returned to the ‘jurors in waiting’ list." on the page

    #select more jurors than i need
    And I select the radio button with name "<juror_number>" and value "juror"
    And I select the radio button with name "<juror_number_2>" and value "juror"
    And I select the radio button with name "<juror_number_3>" and value "juror"
    And I select the radio button with name "<juror_number_4>" and value "unused"
    And I select the radio button with name "<juror_number_5>" and value "challenged"
    And I see "When you confirm, anyone not used or challenged will be returned to the ‘jurors in waiting’ list." on the page
    And I see "3 selected of 1 jurors needed" on the page
    And I press the "Confirm and empanel jury" button
    And I see "You must select 1 jurors to serve on the jury" on the page
    And I select the radio button with name "<juror_number_2>" and value "unused"
    And I select the radio button with name "<juror_number_3>" and value "unused"
    And I press the "Confirm and empanel jury" button

    #jurors set to Not used or Challenged will be removed from panel and placed in jurors in waiting under status Responded
    And I press the "Apps" button
    And I click on the "Juror management" link
    And I click on the "Record attendance" link
    And I see "Responded" in the same row as "<juror_number_4>"
    And I see "Responded" in the same row as "<juror_number_5>"

    Examples:
      |user			|juror_number  | juror_number_2  |juror_number_3   | juror_number_4   | juror_number_5   | pool_number    | trial_number |
      |MODTESTCOURT |041520009     | 041520010       |041520011        | 041520022        | 041520023        | 415300214      | T202425891   |


  @JurorTransformation @NewSchemaConverted
  Scenario Outline: Create a Trial and Generate Panel - Unhappy path using more jurors than those available

    Given I am on "Bureau" "test"

    And I Confirm all the data in the record attendance table is cleared
    And a new trial is inserted with the trial number "<trial_number>"
    And I log in as "<user>"
    
    And I press the "Apps" button
    And I click on the "Trial management" link
    And I click on the trial number "<trial_number>"

    And I press the "Generate panel" button
    And I see "Which jurors do you want to generate a panel from?" on the page
    And I set the radio button to "All available jurors"
    And I set "Number of jurors needed on this panel" to "2"
    And I press the "Continue" button
    And I see "Cannot create panel - Not enough jurors available" in the error banner

    Examples:
      |user			   | trial_number |
      |MODTESTCOURT    | T2020070324  |