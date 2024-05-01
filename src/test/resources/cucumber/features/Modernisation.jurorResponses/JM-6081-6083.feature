Feature: JM-6081 - 6083

  @JurorTransformationMulti @NewSchemaConverted
  Scenario Outline: Send jury sentencing date message - JM-6803

    Given I am on "Bureau" "test"

    Given a bureau owned pool is created with jurors
      | court |juror_number      | pool_number	    | att_date_weeks_in_future	| owner |
      | 415   |<juror_number>    | <pool_number>     | 5				        | 400	|

    Then a new pool is inserted for where record has transferred to the court new schema
      |part_no               | pool_no          | owner |
      |<juror_number>        | <pool_number>    | 415   |

    And I Confirm all the data in the record attendance table is cleared
    And a new trial is inserted with the trial number "<trial_number>"
    And I update juror "<juror_number>" to be able to send a message to them
    And I update juror "<juror_number>" to have a status of responded in order to record attendance


    #log on and search for juror
    And I log in as "<user>"

    #check in juror to be able to put juror on trial
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
    And I click on the "<trial_number>" link

    And I press the "Generate panel" button
    And I set the radio button to "All available jurors"
    And I set "Number of jurors needed on this panel" to "1"
    And I press the "Continue" button
    And I see "<juror_number>" in the same row as "Panel"


    #Empanel jury
    And I check the juror "<juror_number>" checkbox
    And I press the "Empanel jury" button
    And I see "How many jurors do you want to empanel?" on the page
    And I set number of jurors to empanel to "1"
    And I press the "Continue" button

    And I select the radio button with name "<juror_number>" and value "juror"
    And I see "1 selected of 1 jurors needed" on the page
    And I press the "Confirm and empanel jury" button
    And I see "Juror" in the same row as "<juror_number>"

    And I press the "Apps" button
    And I click on the "Messaging" link
    And I see "Send messages" on the page
    And I click on the "Sentencing date (email only)" link
    And I see "Message details" on the page
    And I see the draft message template
    And I see "The defendant in the trial in which you were a juror is being sentenced on <sentence_date>. Please contact the court after the hearing date on <court_phone> quoting reference number <trial_no> if you would like to know the sentence. Please do not reply to this email as this mailbox is unmonitored." on the page
    And I press the "Continue" button
    And I see error "Enter a sentence date"
    And I set the "Sentence" date to a Monday "5" weeks in the future
    And I press the "Continue" button

    And I see "Select a trial" on the page
    And I press the "Continue with selected" button
    And I see "Select a trial" in the error banner
    And I select the "<trial_number>" trial number radio button
    And I press the "Continue with selected" button
    And I click on the methods dropdown and select "Email" for juror "<juror_number>"
    And I check the juror "<juror_number>" checkbox
    And I see "Select jurors to send message to" on the page
    And I press the "Send message" button

    And I see "Check and send message" on the page
    And I see "You’re sending the following message to 1 jurors. You cannot undo this after sending." on the page
    And I see "The defendant in the trial in which you were a juror is being sentenced on" on the page
    And I see "Please contact the court after the hearing date on 01244 356726 quoting reference number T202419999999 if you would like to know the sentence. Please do not reply to this email as this mailbox is unmonitored." on the page
    And I see the template containing my attendance date with a monday "5" weeks in the future
    And I press the "Send message" button
    And I see the message sent banner containing "Message will be sent to 1 jurors"
    And I see the juror "<juror_number>" has a message in the database

    Examples:
      |user			| juror_number | pool_number | trial_number   |
      |MODTESTCOURT | 041529859    | 415980985   | T202419999999  |


  @JurorTransformationWIP @NewSchemaConverted @JM-7165
  Scenario Outline: Send jury sentencing invite message - JM-6081

    Given I am on "Bureau" "test"

    Given a bureau owned pool is created with jurors
      | court |juror_number      | pool_number	    | att_date_weeks_in_future	| owner |
      | 415   |<juror_number>    | <pool_number>     | 5				        | 400	|

    Then a new pool is inserted for where record has transferred to the court new schema
      |part_no               | pool_no          | owner |
      |<juror_number>        | <pool_number>    | 415   |

    And I Confirm all the data in the record attendance table is cleared
    And a new trial is inserted with the trial number "<trial_number>"
    And I update juror "<juror_number>" to be able to send a message to them
    And I update juror "<juror_number>" to have a status of responded in order to record attendance


    #log on and search for juror
    And I log in as "<user>"

    #check in juror to be able to put juror on trial
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
    And I click on the "<trial_number>" link

    And I press the "Generate panel" button
    And I set the radio button to "All available jurors"
    And I set "Number of jurors needed on this panel" to "1"
    And I press the "Continue" button
    And I see "<juror_number>" in the same row as "Panel"

    #Empanel jury
    And I check the juror "<juror_number>" checkbox
    And I press the "Empanel jury" button
    And I see "How many jurors do you want to empanel?" on the page
    And I set number of jurors to empanel to "1"
    And I press the "Continue" button

    And I select the radio button with name "<juror_number>" and value "juror"
    And I see "1 selected of 1 jurors needed" on the page
    And I press the "Confirm and empanel jury" button
    And I see "Juror" in the same row as "<juror_number>"

    And I press the "Apps" button
    And I click on the "Messaging" link
    And I see "Send messages" on the page
    And I click on the "Sentencing invite (email only)" link
    And I see "Message details" on the page
    And I see the draft message template
    And I see "The defendant in the trial in which you were a juror is being sentenced on <sentence_date>. Please contact the court if you wish to attend on <court_phone>. Alternatively contact the court after the hearing date quoting reference number <trial_no> if you would like to know the sentence. Please note that jurors do not have a role in sentencing, and as such your attendance is entirely voluntary and travel and subsistence payments cannot be claimed. Please do not reply to this email as this mailbox is unmonitored." on the page
    And I press the "Continue" button
    And I see error "Enter a sentence date"
    And I set the "Sentence" date to a Monday "5" weeks in the future
    And I press the "Continue" button

    And I see "Select a trial" on the page
    And I press the "Continue with selected" button
    And I see "Select a trial" in the error banner
    And I select the "<trial_number>" trial number radio button
    And I press the "Continue with selected" button
    And I click on the methods dropdown and select "Email" for juror "<juror_number>"
    And I check the juror "<juror_number>" checkbox
    And I see "Select jurors to send message to" on the page
    And I press the "Send message" button

    And I see "Check and send message" on the page
    And I see "You’re sending the following message to 1 jurors. You cannot undo this after sending." on the page
    And I see the draft message template
    
    And I see "The defendant in the trial in which you were a juror is being sentenced on" on the page
    And I see "Please contact the court if you wish to attend on 01244 356726. Alternatively contact the court after the hearing date quoting reference number T202419999998 if you would like to know the sentence. Please note that jurors do not have a role in sentencing, and as such your attendance is entirely voluntary and travel and subsistence payments cannot be claimed. Please do not reply to this email as this mailbox is unmonitored." on the page
    And I see the template containing my attendance date with a monday "5" weeks in the future
    And I press the "Send message" button
    And I see the message sent banner containing "Message will be sent to 1 jurors"
    And I see the juror "<juror_number>" has a message in the database

    Examples:
      |user			| juror_number | pool_number | trial_number   |
      |MODTESTCOURT | 041529858    | 415980985   | T202419999998  |


