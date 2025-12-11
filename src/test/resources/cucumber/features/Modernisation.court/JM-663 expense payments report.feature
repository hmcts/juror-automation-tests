Feature: As a service owner I want to be able to run expense payments report for specific or all courts

  @JurorTransformation
  Scenario: As a service owner I want to be able to run expense payments report for specific or all courts

    Given I am on "Bureau" "ithc"
    Given I delete appearances data for court "401"

    And I log in as "SYSTEMADMIN"

    And I see "System administration" on the page
    And I click on the "Reports" link
    And I see "Service owner reports" on the page
    And I see "Expense payment by type" on the page
    And I click on the "Expense payment by type" link
    And I see "Expense payments" on the page

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
    When I set the "Date to" date to a Monday "-1" weeks in the future
    And I press the "Continue" button
    Then I see "‘Date to’ cannot be before ‘date from’" on the page

    When I set the "Date from" date to a Monday "-50" weeks in the future
    When I set "Date to" to "today"
    And I press the "Continue" button

    Then I see "Expense payments" on the page
    Then I see "Select one or more courts" on the page
    Then I see "reporting/expense-payments" in the URL

    When I press the "Continue" button
    Then I see "Select at least one court" in the error banner

    When I check the "Aylesbury (401)" checkbox
    And I press the "Continue" button

    And I see "Expense payments" on the page
    And I see "This report has no matching data" on the page

    Given a bureau owned pool is created with jurors
      | court | juror_number | pool_number| att_date_weeks_in_future	| owner |
      | 415   | 040127001    | 401270001  | -1				            | 400	|

    Then a new pool is inserted for where record has transferred to the court new schema
      | part_no     | pool_no    | owner |
      | 040127001   | 401270001  | 415   |

    Given I insert appearance records with expenses for court "401"

    When I click on the "Back" link
    When I check the "Aylesbury (401)" checkbox
    And I press the "Continue" button

    Then I see "Expense payments" on the page
    And the value of "Loss of earnings" expense payments selected court is "£100000.10"
    And the value of "Extra care" expense payments selected court is "£110000.11"
    And the value of "Other" expense payments selected court is "£120000.12"
    And the value of "Public transport" expense payments selected court is "£130000.13"
    And the value of "Taxi" expense payments selected court is "£140000.14"
    And the value of "Motorcycle" expense payments selected court is "£150000.15"
    And the value of "Car" expense payments selected court is "£160000.16"
    And the value of "Bicycle" expense payments selected court is "£170000.17"
    And the value of "Parking" expense payments selected court is "£180000.18"
    And the value of "Food and drink" expense payments selected court is "£190000.19"

    When I press the "Export" button
    Then I see "Expense payments" on the page

    When I press the "Print" button
    And I focus page to the new tab
    Then I see "reporting/expense-payments/report/courts/print?" in the URL