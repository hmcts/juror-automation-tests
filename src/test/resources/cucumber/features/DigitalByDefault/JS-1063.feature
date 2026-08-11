Feature: JS-1063

  @JurorTransformation
  Scenario Outline: View updated Letter/Email queue - DBD

    Given I am on "Bureau" "<environment>"

    Given a bureau owned pool is created with jurors
      | court |juror_number   | pool_number	    | att_date_weeks_in_future	| owner |
      | 431   |<juror_number1>| <pool_number>	| 5				            | 400	|
      | 431   |<juror_number2>| <pool_number>	| 5				            | 400	|
      | 431   |<juror_number3>| <pool_number>	| 5				            | 400	|

    Given I update "<juror_number1>" to set them up for digital by default
    Given I update "<juror_number2>" to set them up for digital by default
    Given I update "<juror_number3>" to set them up for digital by default
    Given juror "<juror_number1>" has "LAST_NAME" as "LEWESDEFGRANTED" new schema
    Given juror "<juror_number2>" has "LAST_NAME" as "LEWESDEFGRANTED" new schema
    Given juror "<juror_number3>" has "LAST_NAME" as "LEWESDEFGRANTED" new schema

    And I log in as "MODTESTBUREAU"

    #DBD juror, comms sent by email, preference remains email
    And I search for juror "<juror_number1>"
    And I record a happy path paper summons response
    And I click on the "No," link
    Then I see "<juror_number1>" on the page
    And I press the "Process reply" button
    And I choose the "Deferral request" radio button
    And I press the "Continue" button
    And I set "First choice" to "10 mondays time"
    And I set "Second choice" to "11 mondays time"
    And I set "Third choice" to "12 mondays time"
    And I press the "Continue" button
    And I select "I - ILL" from the "Reason for the deferral request" dropdown
    And I choose the "Choose a different date" radio button
    And I set "Date to defer to" to "12 mondays time"
    And I press the "Continue" button
    And I press the "Put in deferral maintenance" button
    Then I see the juror record updated banner containing "Deferral granted"

    #DBD juror, comms sent by email, preference updated to paper
    And I search for juror "<juror_number2>"
    And I record a happy path paper summons response
    And I click on the "No," link
    Then I see "<juror_number2>" on the page
    And I press the "Process reply" button
    And I choose the "Deferral request" radio button
    And I press the "Continue" button
    And I set "First choice" to "10 mondays time"
    And I set "Second choice" to "11 mondays time"
    And I set "Third choice" to "12 mondays time"
    And I press the "Continue" button
    And I select "I - ILL" from the "Reason for the deferral request" dropdown
    And I choose the "Choose a different date" radio button
    And I set "Date to defer to" to "12 mondays time"
    And I press the "Continue" button
    And I press the "Put in deferral maintenance" button
    Then I see the juror record updated banner containing "Deferral granted"

    #change communication preference to paper
    And I click on the "View juror's record" link
    And I click on the "Juror details" link
    And I see "Digital" in the same row as "Communication preference"
    And I click on the "Add or change" link
    And the radio button "Digital" is "selected"
    And I check the "Paper" checkbox
    And I press the "Save" button
    And I check the "Leave as Lewes (431)" checkbox
    And I press the "Continue" button
    And I see "Paper" in the same row as "Communication preference"

    #DBD juror, preference updated to paper so that comms sent by letter,
    And I search for juror "<juror_number3>"

    #change communication preference to paper
    And I click on the "Juror details" link
    And I see "Digital" in the same row as "Communication preference"
    And I click on the "Add or change" link
    And the radio button "Digital" is "selected"
    And I check the "Paper" checkbox
    And I press the "Save" button
    And I check the "Leave as Lewes (431)" checkbox
    And I press the "Continue" button
    And I press the "Continue" button
    And I see "Paper" in the same row as "Communication preference"

    And I record a happy path paper summons response
    And I click on the "No," link
    Then I see "<juror_number3>" on the page
    And I press the "Process reply" button
    And I choose the "Deferral request" radio button
    And I press the "Continue" button
    And I set "First choice" to "10 mondays time"
    And I set "Second choice" to "11 mondays time"
    And I set "Third choice" to "12 mondays time"
    And I press the "Continue" button
    And I select "I - ILL" from the "Reason for the deferral request" dropdown
    And I choose the "Choose a different date" radio button
    And I set "Date to defer to" to "12 mondays time"
    And I press the "Continue" button
    And I press the "Put in deferral maintenance" button
    Then I see the juror record updated banner containing "Deferral granted"

    And I press the "Apps" button
    And I click on the "Documents" link
    And I see "Documents" on the page
    And I click on the "Deferral granted letters" link
    And I see "Deferral granted letters" on the page
    And I choose the "Juror name" radio button
    And I set "Enter juror name" to "LEWESDEFGRANTED"
    And I press the "Search" button
    Then I see juror "<juror_number1>" has "original" as "Email"
    Then I see juror "<juror_number1>" has "current" as "Email"
    Then I see juror "<juror_number2>" has "original" as "Email"
    Then I see juror "<juror_number2>" has "current" as "Letter"
    Then I see juror "<juror_number3>" has "original" as "Letter"
    Then I see juror "<juror_number3>" has "current" as "Letter"

    Examples:
      | juror_number1	| juror_number2	|juror_number3	|pool_number  | environment   |
      | 043100187		| 043100188		|043100189		|431309164    | ithc          |


  @JurorTransformation
  Scenario Outline: Send summons pack for juror in DBD - automatically and manually

    Given I am on "Bureau" "ithc"

    Given a bureau owned pool is created with jurors
      | court |juror_number  | pool_number	| att_date_weeks_in_future	| owner |
      | 431   |<juror_number>| <pool_number>	| 5				        | 400	|

    And I update "<juror_number>" to set them up for digital by default

    And I log in as "<user>"
    And the user searches for juror record "<juror_number>" from the global search bar
    And I see "Juror is part of the digital by default pilot" on the page
    And I click on the "Juror details" link
    And I click on the "Add or change" link
    And I set the radio button to "Paper"
    And I set "Date of birth" to "02/03/1990"
    And I press the "Save" button
    And I set the radio button to "Leave as Lewes"
    And I press the "Continue" button
    And I see "Communication preferences have been changed to paper" on the page
    And I see "Do you want to send a paper summons pack to the juror?" on the page
    And I set the radio button to "Yes"
    And I press the "Continue" button
    And I see "Paper summons sent" on the page

    And the user searches for juror record "<juror_number>" from the global search bar
    And I click on the "Juror details" link
    And I click on the "Send summons pack" link
    And I see "Are you sure you want to send a paper summons pack?" on the page
    And I see "A paper summons pack will be sent. This action will not send another summons letter." on the page
    And I press the "Yes - send summons pack" button
    And I see "Paper summons sent" on the page

    Examples:
      | juror_number	| pool_number	| user         |
      | 043127146		| 431309864     | MODTESTBUREAU |

  @JurorTransformation
  Scenario Outline: Reassign juror to court not in DBD pilot to remove them from DBD

    Given I am on "Bureau" "ithc"

    Given a bureau owned pool is created with jurors
      | court |juror_number  | pool_number	| att_date_weeks_in_future	| owner |
      | 431   |<juror_number>| <pool_number>	| 5				        | 400	|

    And I update "<juror_number>" to set them up for digital by default

    And I log in as "<user>"
    And the user searches for juror record "<juror_number>" from the global search bar
    And I see "Juror is part of the digital by default pilot" on the page

    And I press the "Update juror record" button
    And I set the radio button to "Reassign to another pool"
    And I press the "Continue" button
    And I click on the "Change court" link
    And I set "Enter a court name or location code" to "457"
    And I press the "Continue" button
    And I select any active pool from the reassign table
    And I press the "Continue" button
    And I see "Juror record updated: Reassigned to pool" on the page

    And the user searches for juror record "<juror_number>" from the global search bar
    And I do not see "Juror is part of the digital by default pilot" on the page

    Examples:
      | juror_number	| pool_number	| user         |
      | 043127188		| 431307764     | MODTESTBUREAU |
