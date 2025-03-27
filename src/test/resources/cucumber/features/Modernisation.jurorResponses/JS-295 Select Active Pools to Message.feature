Feature: As a court officer I want to see a list of active pools when selecting jurors to message

  @JurorTransformationMulti @Messages
  Scenario Outline: Select active pools to message jurors

    Given I am on "Bureau" "demo"

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
    And I click on the "Reminder to attend" link
    And I see "Message details" on the page
    And I see the draft message template
    And I see "Reminder: Please attend for your Jury Service at <court_name> Court on <attend_date> at <attend_time>. If you have any questions, please contact the jury office on <court_phone>." on the page
    And I set the "Attendance date for message" date to a Monday "5" weeks in the future
    And I set "Hour" to "09"
    And I set "Minute" to "00"
    And I choose the "am" radio button
    And I press the "Continue" button

    And I choose the "Pool" radio button
    Then I see link with text "List of active pools"
    And I click on the "List of active pools" link
    Then I see "Select an active pool" on the page
    And I search for active pool "<pool_number>"
    And I press the "Continue with selected" button

    Then I see "Select jurors to send message to" on the page
    And I see "<pool_number>" on the page

    Examples:
      |user			| juror_number | pool_number |
      |MODTESTCOURT | 041525100    | 415251201   |