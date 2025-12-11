Feature: As a service owner I want to be able to see what SMS messages courts are sending via report

  @JurorTransformation @Messages
  Scenario: As a service owner I want to be able to see what SMS messages courts are sending via report

    Given I am on "Bureau" "ithc"
    Given I clear messages for court "401"

    And I log in as "SYSTEMADMIN"

    And I see "System administration" on the page
    And I click on the "Reports" link
    And I see "Service owner reports" on the page
    And I see "Outgoing SMS messages" on the page
    And I click on the "Outgoing SMS messages" link
    And I see "Outgoing SMS messages report" on the page

    When I set "Date from" to "000000"
    When I set "Date to" to "000000"
    And I press the "Continue" button
    Then I see "Enter ‘date from’ in the correct format, for example, 31/01/2023" on the page
    Then I see "Enter ‘date to’ in the correct format, for example, 31/01/2023" on the page

    When I set "Date from" to "text"
    When I set "Date to" to "text"
    And I press the "Continue" button
    Then I see "‘Date from’ can only include numbers and forward slashes" on the page
    Then I see "‘Date to’ can only include numbers and forward slashes" on the page

    When I set "Date from" to "11111"
    When I set "Date to" to "11111"
    And I press the "Continue" button
    Then I see "Enter a real date" on the page
    Then I see "Enter a real date" on the page

    When I set "Date from" to "01-01-2025"
    When I set "Date to" to "01-01-2025"
    And I press the "Continue" button
    Then I see "‘Date from’ can only include numbers and forward slashes" on the page
    Then I see "‘Date to’ can only include numbers and forward slashes" on the page

    When I set "Date from" to "today"
    When I set "Date to" to "today"
    And I press the "Continue" button

    Then I see "Outgoing SMS messages report" on the page
    Then I see "Select one or more courts" on the page
    Then I see "reporting/outgoing-sms-messages" in the URL

    When I press the "Continue" button
    Then I see "Select at least one court" in the error banner

    When I check the "Aylesbury (401)" checkbox
    And I press the "Continue" button

    And I see "Outgoing SMS messages report" on the page
    And I see "This report has no matching data" on the page

    Given I create a message of each type for court "401"

    When I click on the "Back" link
    When I check the "Aylesbury (401)" checkbox
    And I press the "Continue" button

    Then I see "Outgoing SMS messages report" on the page
    And the total SMS sent for selected court is "15"
    And the number of "Summons" SMS sent by selected court is "1"
    And the number of "Reminder" SMS sent by selected court is "1"
    And the number of "Failed to Attend" SMS sent by selected court is "1"
    And the number of "Date and Time changed" SMS sent by selected court is "1"
    And the number of "Time changed" SMS sent by selected court is "1"
    And the number of "Complete (attended)" SMS sent by selected court is "1"
    And the number of "Complete (not needed)" SMS sent by selected court is "1"
    And the number of "Next Date" SMS sent by selected court is "1"
    And the number of "On Call" SMS sent by selected court is "1"
    And the number of "Please Contact" SMS sent by selected court is "1"
    And the number of "Delayed Start" SMS sent by selected court is "1"
    And the number of "Selection" SMS sent by selected court is "1"
    And the number of "Bad Weather" SMS sent by selected court is "1"
    And the number of "Check Junk" SMS sent by selected court is "1"
    And the number of "Bring Lunch" SMS sent by selected court is "1"
    And the number of "Excused" SMS sent by selected court is "1"
    And the number of "Total" SMS sent by selected court is "15"

    When I press the "Export data" button
    Then I see "Outgoing SMS messages report" on the page
    
    When I press the "Print" button
    And I focus page to the new tab
    Then I see "reporting/outgoing-sms-messages/report/courts/print?" in the URL