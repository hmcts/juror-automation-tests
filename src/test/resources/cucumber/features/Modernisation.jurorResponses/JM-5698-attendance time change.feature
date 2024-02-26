Feature: As a jury officer I need to send a attendance time change message

  @JurorTransformationWIP @NewSchemaConverted @Messages
  Scenario Outline: Send attendance time change message for Juror using Text including error checks

    Given I am on "Bureau" "test"

    Given a bureau owned pool is created with jurors
      | court |juror_number      | pool_number	    | att_date_weeks_in_future	| owner |
      | 415   |<juror_number>    | <pool_number>     | 5				        | 400	|

    Then a new pool is inserted for where record has transferred to the court new schema
      |part_no               | pool_no          | owner |
      |<juror_number>        | <pool_number>    | 415   |

    And I update juror "<juror_number>" to be able to send a message to them


    #log on and search for juror
    And I log in as "<user>"

    And I press the "Apps" button
    And I click on the "Messaging" link
    And I see "Send messages" on the page
    And I click on the "Attendance time changed" link
    And I see "Message details" on the page
    And I see the draft message template
    And I see "The time of your attendance for Jury Service has changed to <attend_time>. The date remains the same. If you have any questions, please contact the jury office on <court_phone>." on the page
    And I press the "Continue" button
    And I see error "Enter an attendance time"
    And I set "Hour" to "09"
    And I set "Minute" to "00"
    And I set the radio button to "am"
    And I press the "Continue" button

    And I see "Find jurors to send message to" on the page
    And I press the "Continue" button
    And I see error "Select how you want to search for jurors to send message to"
    And I set the radio button to "Juror number"
    And I press the "Continue" button
    And I see error "Enter juror number"
    And I set "Enter juror number" to "<juror_number>"
    And I press the "Continue" button
    And I see "Select jurors to send message to" on the page
    And I press the "Send message" button
    And I see "Select at least one juror to send message to" in the error banner
    And I click on the methods dropdown and select "Text" for juror "<juror_number>"
    And I check the juror "<juror_number>" checkbox
    And I press the "Send message" button

    And I see "Check and send message" on the page
    And I see "You’re sending the following message to 1 jurors. You cannot undo this after sending." on the page
    And I see "The time of your attendance for Jury Service has changed to 09:00. The date remains the same. If you have any questions, please contact the jury office on 01244 317606." on the page
    And I press the "Send message" button
    And I see the message sent banner containing "Message will be sent to 1 jurors"
    And I see the juror "<juror_number>" has a message in the database

    Examples:
      |user			| juror_number | pool_number |
      |MODTESTCOURT | 041529969    | 415980996   |


  @JurorTransformationWIP @NewSchemaConverted @Messages
  Scenario Outline: Send attendance time change message for Juror

    Given I am on "Bureau" "test"

    Given a bureau owned pool is created with jurors
      | court |juror_number      | pool_number	    | att_date_weeks_in_future	| owner |
      | 415   |<juror_number>    | <pool_number>    | 5				            | 400	|

    Then a new pool is inserted for where record has transferred to the court new schema
      |part_no               | pool_no          | owner |
      |<juror_number>        | <pool_number>    | 415   |

    And I update juror "<juror_number>" to be able to send a message to them

    #log on and search for juror
    And I log in as "<user>"

    And I press the "Apps" button
    And I click on the "Messaging" link
    And I see "Send messages" on the page
    And I click on the "Attendance time changed" link
    And I see "Message details" on the page
    And I see the draft message template
    And I see "The time of your attendance for Jury Service has changed to <attend_time>. The date remains the same. If you have any questions, please contact the jury office on <court_phone>." on the page
    And I set "Hour" to "09"
    And I set "Minute" to "00"
    And I set the radio button to "am"
    And I press the "Continue" button

    And I see "Find jurors to send message to" on the page
    And I set the radio button to "Juror number"
    And I set "Enter juror number" to "<juror_number>"
    And I press the "Continue" button
    And I click on the methods dropdown and select "Text" for juror "<juror_number>"
    And I check the juror "<juror_number>" checkbox
    And I press the "Send message" button

    And I see "Check and send message" on the page
    And I see "You’re sending the following message to 1 jurors. You cannot undo this after sending." on the page
    And I see "The time of your attendance for Jury Service has changed to 09:00. The date remains the same. If you have any questions, please contact the jury office on 01244 317606." on the page
    And I press the "Send message" button
    And I see the message sent banner containing "Message will be sent to 1 jurors"
    And I see the juror "<juror_number>" has a message in the database

    Examples:
      |user			| juror_number | pool_number |
      |MODTESTCOURT | 041529968    | 415980996   |


  @JurorTransformationWIP @NewSchemaConverted @Messages
  Scenario Outline: Send attendance time change message for Juror via their Name

    Given I am on "Bureau" "test"

    Given a bureau owned pool is created with jurors
      | court |juror_number      | pool_number	    | att_date_weeks_in_future	| owner |
      | 415   |<juror_number>    | <pool_number>     | 5				            | 400	|

    Then a new pool is inserted for where record has transferred to the court new schema
      |part_no               | pool_no          | owner |
      |<juror_number>        | <pool_number>    | 415   |

    And I update juror "<juror_number>" to be able to send a message to them

    #log on and search for juror
    And I log in as "<user>"

    And I press the "Apps" button
    And I click on the "Messaging" link
    And I see "Send messages" on the page
    And I click on the "Attendance time changed" link
    And I see "Message details" on the page
    And I see the draft message template
    And I see "The time of your attendance for Jury Service has changed to <attend_time>. The date remains the same. If you have any questions, please contact the jury office on <court_phone>." on the page
    And I set "Hour" to "09"
    And I set "Minute" to "00"
    And I set the radio button to "am"
    And I press the "Continue" button

    And I see "Find jurors to send message to" on the page
    And I set the radio button to "Juror name"
    And I press the "Continue" button
    And I see error "Enter juror name"
    And I set "Enter juror name" to "fname lname"
    And I press the "Continue" button
    And I click on the methods dropdown and select "Text" for juror "<juror_number>"
    And I check the juror "<juror_number>" checkbox
    And I press the "Send message" button

    And I see "Check and send message" on the page
    And I see "You’re sending the following message to 1 jurors. You cannot undo this after sending." on the page
    And I see "The time of your attendance for Jury Service has changed to 09:00. The date remains the same. If you have any questions, please contact the jury office on 01244 317606." on the page
    And I press the "Send message" button
    And I see the message sent banner containing "Message will be sent to 1 jurors"
    And I see the juror "<juror_number>" has a message in the database

    Examples:
      |user			| juror_number | pool_number |
      |MODTESTCOURT | 041529967    | 415980996   |

  @JurorTransformationWIP @NewSchemaConverted @Messages
  Scenario Outline: Send attendance time change message for Juror via their Pool number

    Given I am on "Bureau" "test"

    Given a bureau owned pool is created with jurors
      | court |juror_number      | pool_number	    | att_date_weeks_in_future	| owner |
      | 415   |<juror_number>    | <pool_number>     | 5				            | 400	|

    Then a new pool is inserted for where record has transferred to the court new schema
      |part_no               | pool_no          | owner |
      |<juror_number>        | <pool_number>    | 415   |

    And I update juror "<juror_number>" to be able to send a message to them

    #log on and search for juror
    And I log in as "<user>"

    And I press the "Apps" button
    And I click on the "Messaging" link
    And I see "Send messages" on the page
    And I click on the "Attendance time changed" link
    And I see "Message details" on the page
    And I see the draft message template
    And I see "The time of your attendance for Jury Service has changed to <attend_time>. The date remains the same. If you have any questions, please contact the jury office on <court_phone>." on the page
    And I set "Hour" to "09"
    And I set "Minute" to "00"
    And I set the radio button to "am"
    And I press the "Continue" button

    And I see "Find jurors to send message to" on the page
    And I set the radio button to "Pool"
    And I press the "Continue" button
    And I see error "Enter pool number"
    And I set "Enter pool number" to "<pool_number>"
    And I press the "Continue" button
    And I click on the methods dropdown and select "Email" for juror "<juror_number>"
    And I check the juror "<juror_number>" checkbox
    And I press the "Send message" button

    And I see "Check and send message" on the page
    And I see "You’re sending the following message to 1 jurors. You cannot undo this after sending." on the page
    And I see "The time of your attendance for Jury Service has changed to 09:00. The date remains the same. If you have any questions, please contact the jury office on 01244 317606." on the page
    And I press the "Send message" button
    And I see the message sent banner containing "Message will be sent to 1 jurors"
    And I see the juror "<juror_number>" has a message in the database

    Examples:
      |user			| juror_number | pool_number |
      |MODTESTCOURT | 041529966    | 415980996   |

  @JurorTransformationWIP @NewSchemaConverted @Messages
  Scenario Outline: Send attendance time change message for Juror in Trial

    Given I am on "Bureau" "test"

    Given a bureau owned pool is created with jurors
      | court |juror_number      | pool_number	    | att_date_weeks_in_future	| owner |
      | 415   |<juror_number>    | <pool_number>     | 5				            | 400	|

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
    And I click on the "Attendance time changed" link
    And I see "Message details" on the page
    And I see the draft message template
    And I see "The time of your attendance for Jury Service has changed to <attend_time>. The date remains the same. If you have any questions, please contact the jury office on <court_phone>." on the page
    And I set "Hour" to "09"
    And I set "Minute" to "00"
    And I set the radio button to "am"
    And I press the "Continue" button

    And I see "Find jurors to send message to" on the page
    And I set the radio button to "Trial"
    And I press the "Continue" button
    And I press the "Continue with selected" button
    And I see "Select a trial" in the error banner
    And I select the "<trial_number>" trial number radio button
    And I press the "Continue with selected" button
    And I check the juror "<juror_number>" checkbox
    And I click on the methods dropdown and select "Email" for juror "<juror_number>"
    And I press the "Send message" button

    And I see "Check and send message" on the page
    And I see "You’re sending the following message to 1 jurors. You cannot undo this after sending." on the page
    And I see "The time of your attendance for Jury Service has changed to 09:00. The date remains the same. If you have any questions, please contact the jury office on 01244 317606." on the page
    And I press the "Send message" button
    And I see the message sent banner containing "Message will be sent to 1 jurors"
    And I see the juror "<juror_number>" has a message in the database

    Examples:
      |user			| juror_number | pool_number |trial_number       |
      |MODTESTCOURT | 041529965    | 415980996   |T202419999994  |


  @JurorTransformationWIP @NewSchemaConverted @Messages
  Scenario Outline: Send attendance time change message for Juror - Next start date

    Given I am on "Bureau" "test"

    Given a bureau owned pool is created with jurors
      | court |juror_number      | pool_number	     | att_date_weeks_in_future	| owner |
      | 415   |<juror_number>    | <pool_number>     | 5			            | 400	|

    Then a new pool is inserted for where record has transferred to the court new schema
      |part_no               | pool_no          | owner |
      |<juror_number>        | <pool_number>    | 415   |

    And I update juror "<juror_number>" to be able to send a message to them

    #log on and search for juror
    And I log in as "<user>"

    And I press the "Apps" button
    And I click on the "Messaging" link
    And I see "Send messages" on the page
    And I click on the "Attendance time changed" link
    And I see "Message details" on the page
    And I see the draft message template
    And I see "The time of your attendance for Jury Service has changed to <attend_time>. The date remains the same. If you have any questions, please contact the jury office on <court_phone>." on the page
    And I set "Hour" to "09"
    And I set "Minute" to "00"
    And I set the radio button to "am"
    And I press the "Continue" button

    And I see "Find jurors to send message to" on the page
    And I set the radio button to "Next due at court"
    And I press the "Continue" button
    And I see error "Enter date next due at court"
    And I set the "Next due at court" date to a Monday "5" weeks in the future
    And I press the "Continue" button
    And I click on the methods dropdown and select "Email" for juror "<juror_number>"
    And I check the juror "<juror_number>" checkbox
    And I press the "Send message" button

    And I see "Check and send message" on the page
    And I see "You’re sending the following message to 1 jurors. You cannot undo this after sending." on the page
    And I see "The time of your attendance for Jury Service has changed to 09:00. The date remains the same. If you have any questions, please contact the jury office on 01244 317606." on the page
    And I press the "Send message" button
    And I see the message sent banner containing "Message will be sent to 1 jurors"
    And I see the juror "<juror_number>" has a message in the database

    Examples:
      |user			| juror_number | pool_number |
      |MODTESTCOURT | 041529964    | 415980996   |


  @JurorTransformationWIP @NewSchemaConverted @Messages
  Scenario Outline: Send attendance time change message for Juror via their deferred date

    Given I am on "Bureau" "test"

    Given a bureau owned pool is created with jurors
      | court |juror_number      | pool_number	    | att_date_weeks_in_future	| owner |
      | 415   |<juror_number>    | <pool_number>     | 5				            | 400	|

    Then a new pool is inserted for where record has transferred to the court new schema
      |part_no               | pool_no          | owner |
      |<juror_number>        | <pool_number>    | 415   |

    And I update juror "<juror_number>" to be able to send a message to them

    #log on and search for juror
    And I log in as "<user>"

    When the user searches for juror record "<juror_number>" from the global search bar

  #record paper summons response
    And I click the Enter summons reply button
    Then the juror details form is displayed

  #juror details
    When I fill in all of the juror details for the summons reply
    And I click continue on the juror summons reply page

  #eligibility
    Then the juror summons reply eligibility page is displayed
    When I answer the juror summons reply eligibility questions
    And I click continue on the juror summons reply page

  #can attend on date
    Then the juror summons reply types page is displayed
    When I set the radio button to "Deferral request"
    And I click continue on the juror summons reply page

  #cjs
    Then the juror summons reply CJS employment page is displayed
    When I select that the juror has not worked in the criminal justice system
    And I click continue on the juror summons reply page

  #reasonable adjustments
    Then the juror summons reply reasonable adjustments page is displayed
    When I select that the juror does need adjustments
    And I set "What help does the juror need at court?" to "Childcare"
    And I click continue on the juror summons reply page

  #confirm/sign
    Then the juror summons reply Signature page is displayed
    When I select that the summons reply has been signed
    And I click done on the juror summons reply page

    And I see the reply "status" on the response is "TO DO"
    And I see the reply "type" on the response is "DEFERRAL"

    And I press the "Process reply" button
    And I set the radio button to "Deferral request"
    And I press the "Continue" button

    And I set the "first" choice to "5" Mondays in the future
    And I set the "second" choice to "7" Mondays in the future
    And I set the "third" choice to "9" Mondays in the future
    And I press the "Continue" button
    Then I select "O - OTHER" from the "Reason for the deferral request" dropdown
    Then I set the radio button to "Choose a different date"
    And I set the "Deferral" date to a Monday "49" weeks in the future
    And I press the "Continue" button

    Then I see "There are no active pools for this date" on the page
    And I press the "Put in deferral maintenance" button

    When the user searches for juror record "<juror_number>" from the global search bar
    And I see the juror status has updated to "Deferred"

    And I press the "Apps" button
    And I click on the "Messaging" link
    And I see "Send messages" on the page
    And I click on the "Attendance time changed" link
    And I see "Message details" on the page
    And I see the draft message template
    And I see "The time of your attendance for Jury Service has changed to <attend_time>. The date remains the same. If you have any questions, please contact the jury office on <court_phone>." on the page
    And I set "Hour" to "09"
    And I set "Minute" to "00"
    And I set the radio button to "am"
    And I press the "Continue" button

    And I see "Find jurors to send message to" on the page

    And I set the radio button to "Date deferred to"
    And I press the "Continue" button
    And I see error "Enter date deferred to"
    And I set the "Deferral" date to a Monday "49" weeks in the future
    And I press the "Continue" button
    And I click on the methods dropdown and select "Email" for juror "<juror_number>"
    And I check the juror "<juror_number>" checkbox
    And I press the "Send message" button

    And I see "Check and send message" on the page
    And I see "You’re sending the following message to 1 jurors. You cannot undo this after sending." on the page
    And I see "The time of your attendance for Jury Service has changed to 09:00. The date remains the same. If you have any questions, please contact the jury office on 01244 317606." on the page
    And I press the "Send message" button
    And I see the message sent banner containing "Message will be sent to 1 jurors"
    And I see the juror "<juror_number>" has a message in the database

    Examples:
      |user			| juror_number | pool_number |
      |MODTESTCOURT | 041529963    | 415980996   |

  @JurorTransformationWIP @NewSchemaConverted @Messages
  Scenario Outline: Send attendance time change message for Juror using Text for multiple jurors

    Given I am on "Bureau" "test"

    Given a bureau owned pool is created with jurors
      | court |juror_number      | pool_number	    | att_date_weeks_in_future	| owner |
      | 415   |<juror_number>    | <pool_number>     | 5				         | 400	|
      | 415   |<juror_number_2>    | <pool_number>     | 5				         | 400	|
      | 415   |<juror_number_3>    | <pool_number>     | 5				         | 400	|

    Then a new pool is inserted for where record has transferred to the court new schema
      |part_no               | pool_no          | owner |
      |<juror_number>        | <pool_number>    | 415   |
      |<juror_number_2>        | <pool_number>    | 415   |
      |<juror_number_3>        | <pool_number>    | 415   |

    And I update juror "<juror_number>" to be able to send a message to them
    And I update juror "<juror_number_2>" to be able to send a message to them
    And I update juror "<juror_number_3>" to be able to send a message to them

#    And I clear messages for juror "<juror_number_2>"
#    And I clear messages for juror "<juror_number_3>"

    #log on and search for juror
    And I log in as "<user>"

    And I press the "Apps" button
    And I click on the "Messaging" link
    And I see "Send messages" on the page
    And I click on the "Attendance time changed" link
    And I see "Message details" on the page
    And I see the draft message template
    And I see "The time of your attendance for Jury Service has changed to <attend_time>. The date remains the same. If you have any questions, please contact the jury office on <court_phone>." on the page
    And I set "Hour" to "09"
    And I set "Minute" to "00"
    And I set the radio button to "am"
    And I press the "Continue" button

    And I see "Find jurors to send message to" on the page
    And I set the radio button to "Pool"
    And I set "Enter pool number" to "<pool_number>"
    And I press the "Continue" button
    And I see "Select jurors to send message to" on the page

    And I click on the methods dropdown and select "Text" for juror "<juror_number>"
    And I check the juror "<juror_number>" checkbox
    And I click on the methods dropdown and select "Email" for juror "<juror_number_2>"
    And I check the juror "<juror_number_2>" checkbox
    And I click on the methods dropdown and select "Text" for juror "<juror_number_3>"
    And I check the juror "<juror_number_3>" checkbox

    And I press the "Send message" button
    And I see "Check and send message" on the page
    And I see "You’re sending the following message to 3 jurors. You cannot undo this after sending." on the page
    And I see "The time of your attendance for Jury Service has changed to 09:00. The date remains the same. If you have any questions, please contact the jury office on 01244 317606." on the page
    And I press the "Send message" button
    And I see the message sent banner containing "Message will be sent to 3 jurors"
    And I see the juror "<juror_number>" has a message in the database
    And I see the juror "<juror_number_2>" has a message in the database
    And I see the juror "<juror_number_3>" has a message in the database

    Examples:
      |user			| juror_number | juror_number_2 | juror_number_3 |pool_number |
      |MODTESTCOURT | 041529962    | 041529961      |041529960       |415980996   |