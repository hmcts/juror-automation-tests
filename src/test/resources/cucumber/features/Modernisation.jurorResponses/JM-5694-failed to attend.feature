Feature: As a jury officer I need to send a failed to attend message

  @JurorTransformationMulti @Messages
  Scenario Outline: Send failed to attend message for Juror using Text including error checks

    Given I am on "Bureau" "ithc"

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
    And I click on the "Failed to attend" link
    And I see "Message details" on the page
    And I see the draft message template
    And I see "You failed to attend for Jury Service at <court_name> Court on <attend_date>. Please contact the jury office on <court_phone>." on the page
    And I press the "Continue" button
    And I see error "Enter an attendance date"
    And I set the "Attendance date for message" date to a Monday "5" weeks in the future
    And I press the "Continue" button

    And I see "Find jurors to send message to" on the page
    And I press the "Continue" button
    And I see error "Select how you want to search for jurors to send message to"
    And I choose the "Juror number" radio button
    And I press the "Continue" button
    And I see error "Enter juror number"
    And I set "Enter juror number" to "<juror_number>"
    And I press the "Continue" button
    And I see "Select jurors to send message to" on the page
    And I press the "Send message" button
    And I see "Select at least one juror to send message to" in the error banner
    And I click on the methods dropdown and select "Email" for juror "<juror_number>"
    And I check the juror "<juror_number>" checkbox
    And I press the "Send message" button

    And I see "Check and send message" on the page
    And I see "You’re sending the following message to 1 jurors. You cannot undo this after sending." on the page
    And I see "You failed to attend for Jury Service at CHESTER Court on" on the page
    And I see "Please contact the jury office on 01244 356726." on the page
    And I see the template containing my attendance date with a monday "5" weeks in the future
    And I press the "Send message" button
    And I see the message sent banner containing "Message will be sent to 1 jurors"
    And I see the juror "<juror_number>" has a message in the database

    Examples:
      |user			| juror_number | pool_number |
      |MODTESTCOURT | 041529989    | 415980998   |

  @JurorTransformationMulti @Messages
  Scenario Outline: Send failed to attend message for Juror

    Given I am on "Bureau" "ithc"

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
    And I click on the "Failed to attend" link
    And I see "Message details" on the page
    And I see the draft message template
    And I see "You failed to attend for Jury Service at <court_name> Court on <attend_date>. Please contact the jury office on <court_phone>." on the page
    And I set the "Attendance date for message" date to a Monday "5" weeks in the future
    And I press the "Continue" button

    And I see "Find jurors to send message to" on the page
    And I choose the "Juror number" radio button
    And I set "Enter juror number" to "<juror_number>"
    And I press the "Continue" button
    And I click on the methods dropdown and select "Email" for juror "<juror_number>"
    And I check the juror "<juror_number>" checkbox
    And I press the "Send message" button

    And I see "Check and send message" on the page
    And I see "You’re sending the following message to 1 jurors. You cannot undo this after sending." on the page
    And I see "You failed to attend for Jury Service at CHESTER Court on" on the page
    And I see "Please contact the jury office on 01244 356726." on the page
    And I see the template containing my attendance date with a monday "5" weeks in the future
    And I press the "Send message" button
    And I see the message sent banner containing "Message will be sent to 1 jurors"
    And I see the juror "<juror_number>" has a message in the database

    Examples:
      |user			| juror_number | pool_number |
      |MODTESTCOURT | 041529988    | 415980998   |

  @JurorTransformationMulti @Messages
  Scenario Outline: Send failed to attend message for Juror via their Name

    Given I am on "Bureau" "ithc"

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
    And I click on the "Failed to attend" link
    And I see "Message details" on the page
    And I see the draft message template
    And I see "You failed to attend for Jury Service at <court_name> Court on <attend_date>. Please contact the jury office on <court_phone>." on the page
    And I set the "Attendance date for message" date to a Monday "5" weeks in the future
    And I press the "Continue" button

    And I see "Find jurors to send message to" on the page
    And I choose the "Juror name" radio button
    And I press the "Continue" button
    And I see error "Enter juror name"
    And I set "Enter juror name" to "fname lname"
    And I press the "Continue" button
    And I click on the methods dropdown and select "Text" for juror "<juror_number>"
    And I check the juror "<juror_number>" checkbox
    And I press the "Send message" button

    And I see "Check and send message" on the page
    And I see "You’re sending the following message to 1 jurors. You cannot undo this after sending." on the page
    And I see "You failed to attend for Jury Service at CHESTER Court on" on the page
    And I see "Please contact the jury office on 01244 356726." on the page
    And I see the template containing my attendance date with a monday "5" weeks in the future
    And I press the "Send message" button
    And I see the message sent banner containing "Message will be sent to 1 jurors"
    And I see the juror "<juror_number>" has a message in the database

    Examples:
      |user			| juror_number | pool_number |
      |MODTESTCOURT | 041529987    | 415980998   |


  @JurorTransformationMulti @Messages
  Scenario Outline: Send failed to attend message for Juror via their Pool number

    Given I am on "Bureau" "ithc"

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
    And I click on the "Failed to attend" link
    And I see "Message details" on the page
    And I see the draft message template
    And I see "You failed to attend for Jury Service at <court_name> Court on <attend_date>. Please contact the jury office on <court_phone>." on the page
    And I set the "Attendance date for message" date to a Monday "5" weeks in the future
    And I press the "Continue" button

    And I see "Find jurors to send message to" on the page
    And I choose the "Pool" radio button
    And I press the "Continue" button
    And I see error "Enter pool number"
    And I set "Enter pool number" to "<pool_number>"
    And I press the "Continue" button
    And I click on the methods dropdown and select "Text" for juror "<juror_number>"
    And I check the juror "<juror_number>" checkbox
    And I press the "Send message" button

    And I see "Check and send message" on the page
    And I see "You’re sending the following message to 1 jurors. You cannot undo this after sending." on the page
    And I see "You failed to attend for Jury Service at CHESTER Court on" on the page
    And I see "Please contact the jury office on 01244 356726." on the page
    And I see the template containing my attendance date with a monday "5" weeks in the future
    And I press the "Send message" button
    And I see the message sent banner containing "Message will be sent to 1 jurors"
    And I see the juror "<juror_number>" has a message in the database

    Examples:
      |user			| juror_number | pool_number |
      |MODTESTCOURT | 041529986    | 415980998   |


  @JurorTransformation @Messages
  Scenario Outline: Send failed to attend message for Juror in Trial

    Given I am on "Bureau" "ithc"

    Given a bureau owned pool is created with jurors
      | court |juror_number      | pool_number	    | att_date_weeks_in_future	| owner |
      | 415   |<juror_number>    | <pool_number>    | 5				            | 400	|

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
    And I choose the "Check in" radio button

    And I set "Hour" to "09"
    And I set "Minute" to "00"
    And I choose the "am" radio button
    And I input juror "<juror_number>" to be checked in
    And I press the "Check in juror" button
    And I see "<juror_number>" in the same row as "9:00am"

    And I press the "Apps" button
    And I click on the "Trial management" link
    And I click on the "<trial_number>" link

    And I press the "Generate panel" button
    And I choose the "All available jurors" radio button
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
    And I click on the "Failed to attend" link
    And I see "Message details" on the page
    And I see the draft message template
    And I see "You failed to attend for Jury Service at <court_name> Court on <attend_date>. Please contact the jury office on <court_phone>." on the page
    And I set the "Attendance date for message" date to a Monday "5" weeks in the future
    And I press the "Continue" button

    And I see "Find jurors to send message to" on the page
    And I choose the "Trial" radio button
    And I press the "Continue" button
    And I press the "Continue with selected" button
    And I see "Select a trial" in the error banner
    And I select the "<trial_number>" trial number radio button
    And I press the "Continue with selected" button
    And I click on the methods dropdown and select "Text" for juror "<juror_number>"
    And I check the juror "<juror_number>" checkbox
    And I press the "Send message" button

    And I see "Check and send message" on the page
    And I see "You’re sending the following message to 1 jurors. You cannot undo this after sending." on the page
    And I see "You failed to attend for Jury Service at CHESTER Court on" on the page
    And I see "Please contact the jury office on 01244 356726." on the page
    And I see the template containing my attendance date with a monday "5" weeks in the future
    And I press the "Send message" button
    And I see the message sent banner containing "Message will be sent to 1 jurors"
    And I see the juror "<juror_number>" has a message in the database

    Examples:
      |user			| juror_number | pool_number |trial_number       |
      |MODTESTCOURT | 041529985    | 415980998   |T202419999996      |


  @JurorTransformationMulti @Messages
  Scenario Outline: Send failed to attend message for Juror - Next start date

    Given I am on "Bureau" "ithc"

    Given a bureau owned pool is created with jurors
      | court |juror_number      | pool_number	     | att_date_weeks_in_future	| owner |
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
    And I click on the "Failed to attend" link
    And I see "Message details" on the page
    And I see the draft message template
    And I see "You failed to attend for Jury Service at <court_name> Court on <attend_date>. Please contact the jury office on <court_phone>." on the page
    And I set the "Attendance date for message" date to a Monday "5" weeks in the future
    And I press the "Continue" button

    And I see "Find jurors to send message to" on the page
    And I choose the "Next due at court" radio button
    And I press the "Continue" button
    And I see error "Enter date next due at court"
    And I set the "Next due at court" date to a Monday "5" weeks in the future
    And I press the "Continue" button
    And I click on the methods dropdown and select "Email" for juror "<juror_number>"
    And I check the juror "<juror_number>" checkbox
    And I press the "Send message" button

    And I see "Check and send message" on the page
    And I see "You’re sending the following message to 1 jurors. You cannot undo this after sending." on the page
    And I see "You failed to attend for Jury Service at CHESTER Court on" on the page
    And I see "Please contact the jury office on 01244 356726." on the page
    And I see the template containing my attendance date with a monday "5" weeks in the future
    And I press the "Send message" button
    And I see the message sent banner containing "Message will be sent to 1 jurors"
    And I see the juror "<juror_number>" has a message in the database

    Examples:
      |user			| juror_number | pool_number |
      |MODTESTCOURT | 041529984    | 415980998   |


  @JurorTransformationMulti @Messages
  Scenario Outline: Send failed to attend message for Juror via their deferred date

    Given I am on "Bureau" "ithc"

    Given a bureau owned pool is created with jurors
      | court |juror_number      | pool_number	    | att_date_weeks_in_future	| owner |
      | 415   |<juror_number>    | <pool_number>    | 5				            | 400	|

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
    And I choose the "Deferral request" radio button
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

    And I see the reply "status" on the response is "To Do"
    And I see the reply "type" on the response is "Deferral"

    And I press the "Process reply" button
    And I choose the "Deferral request" radio button
    And I press the "Continue" button

    And I set the "first" choice to "5" Mondays in the future
    And I set the "second" choice to "7" Mondays in the future
    And I set the "third" choice to "9" Mondays in the future
    And I press the "Continue" button
    Then I select "O - OTHER" from the "Reason for the deferral request" dropdown
    And I choose the "Choose a different date" radio button
    And I set the "Deferral" date to a Monday "49" weeks in the future
    And I press the "Continue" button

    Then I see "There are no active pools for this date" on the page
    And I press the "Put in deferral maintenance" button

    When the user searches for juror record "<juror_number>" from the global search bar
    And I see the juror status has updated to "Deferred"

    And I press the "Apps" button
    And I click on the "Messaging" link
    And I see "Send messages" on the page
    And I click on the "Failed to attend" link
    And I see "Message details" on the page
    And I see the draft message template
    And I see "You failed to attend for Jury Service at <court_name> Court on <attend_date>. Please contact the jury office on <court_phone>." on the page
    And I set the "Attendance date for message" date to a Monday "5" weeks in the future
    And I press the "Continue" button

    And I see "Find jurors to send message to" on the page
    And I choose the "Date deferred to" radio button
    And I press the "Continue" button
    And I see error "Enter date deferred to"
    And I set the "Deferral" date to a Monday "49" weeks in the future
    And I press the "Continue" button
    And I click on the methods dropdown and select "Text" for juror "<juror_number>"
    And I check the juror "<juror_number>" checkbox
    And I press the "Send message" button

    And I see "Check and send message" on the page
    And I see "You’re sending the following message to 1 jurors. You cannot undo this after sending." on the page
    And I see "You failed to attend for Jury Service at CHESTER Court on" on the page
    And I see "Please contact the jury office on 01244 356726." on the page
    And I see the template containing my attendance date with a monday "5" weeks in the future
    And I press the "Send message" button
    And I see the message sent banner containing "Message will be sent to 1 jurors"
    And I see the juror "<juror_number>" has a message in the database

    Examples:
      |user			| juror_number | pool_number |
      |MODTESTCOURT | 041529983    | 415980998   |


  @JurorTransformationMulti @Messages
  Scenario Outline: Send failed to attend message for Juror using Text for multiple jurors

    Given I am on "Bureau" "ithc"

    Given a bureau owned pool is created with jurors
      | court |juror_number      | pool_number	    | att_date_weeks_in_future	| owner |
      | 415   |<juror_number>    | <pool_number>    | 5				            | 400	|
      | 415   |<juror_number_2>  | <pool_number>    | 5				            | 400	|
      | 415   |<juror_number_3>  | <pool_number>    | 5				            | 400	|

    Then a new pool is inserted for where record has transferred to the court new schema
      |part_no               | pool_no          | owner |
      |<juror_number>        | <pool_number>    | 415   |
      |<juror_number_2>      | <pool_number>    | 415   |
      |<juror_number_3>      | <pool_number>    | 415   |

    And I update juror "<juror_number>" to be able to send a message to them
    And I update juror "<juror_number_2>" to be able to send a message to them
    And I update juror "<juror_number_3>" to be able to send a message to them

    #log on and search for juror
    And I log in as "<user>"

    And I press the "Apps" button
    And I click on the "Messaging" link
    And I see "Send messages" on the page
    And I click on the "Failed to attend" link
    And I see "Message details" on the page
    And I see the draft message template
    And I see "You failed to attend for Jury Service at <court_name> Court on <attend_date>. Please contact the jury office on <court_phone>." on the page
    And I set the "Attendance date for message" date to a Monday "5" weeks in the future
    And I press the "Continue" button

    And I see "Find jurors to send message to" on the page
    And I choose the "Pool" radio button
    And I set "Enter pool number" to "<pool_number>"
    And I press the "Continue" button
    And I see "Select jurors to send message to" on the page
    And I see "You should send this message by email if we have an email address for the juror." on the page

    And I click on the methods dropdown and select "Text" for juror "<juror_number>"
    And I check the juror "<juror_number>" checkbox
    And I click on the methods dropdown and select "Email" for juror "<juror_number_2>"
    And I check the juror "<juror_number_2>" checkbox
    And I click on the methods dropdown and select "Text" for juror "<juror_number_3>"
    And I check the juror "<juror_number_3>" checkbox
    And I see "You should send this message by email if we have an email address for the juror." on the page
    And I press the "Send message" button

    And I see "Check and send message" on the page
    And I see "You’re sending the following message to 3 jurors. You cannot undo this after sending." on the page
    And I see "You failed to attend for Jury Service at CHESTER Court on" on the page
    And I see "Please contact the jury office on 01244 356726." on the page
    And I see the template containing my attendance date with a monday "5" weeks in the future
    And I press the "Send message" button
    And I see the message sent banner containing "Message will be sent to 3 jurors"
    And I see the juror "<juror_number>" has a message in the database
    And I see the juror "<juror_number_2>" has a message in the database
    And I see the juror "<juror_number_3>" has a message in the database

    Examples:
      |user			| juror_number | juror_number_2 | juror_number_3 |pool_number |
      |MODTESTCOURT | 041529982    | 041529981      |041529980       |415980998   |