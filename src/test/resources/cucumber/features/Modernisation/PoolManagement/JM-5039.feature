Feature: JM-5039

  @JurorTransformationWIP @NewSchemaConverted @JM-5923
  Scenario Outline: Transfer a juror to another court as a jury officer - Pool Record - Unhappy Path

    Given I am on "Bureau" "test"

    Given a bureau owned pool is created with jurors
      | court |juror_number  	| pool_number	| att_date_weeks_in_future	| owner |
      | 415   |<juror_number1> 	| <pool_number> | 5				            | 400	|
      | 415   |<juror_number2> 	| <pool_number> | 5				            | 400	|
      | 415   |<juror_number3> 	| <pool_number> | 5				            | 400	|

    Then a new pool is inserted for where record has transferred to the court new schema
      |part_no          | pool_no       | owner |
      |<juror_number1>  | <pool_number> | 415   |
      |<juror_number2>  | <pool_number> | 415   |
      |<juror_number3>  | <pool_number> | 415   |

    And I log in as "<user>"

    When I navigate to the pool request screen
    And I click on active pools
    And I click on the "At court" link
    When I navigate to the active pool "<pool_number>" overview
    And I select the checkbox in the same row as "<juror_number1>" in pool table
    And I select the checkbox in the same row as "<juror_number2>" in pool table
    And I select the checkbox in the same row as "<juror_number3>" in pool table
    And I see "3 of 3 selected" on the page

    And I press the "Transfer" button
    Then I see "Select a court to transfer to" on the page

    #error check
    And I press the "Continue" button
    And I see error "Enter a court name or location code to transfer to"
    And I see error "Enter a transfer date in the correct format, for example, 31/01/2023"
    Then I set input field with "ID" of "courtNameOrLocation" to "408"
    And I click on the "Bristol (408)" link
    And I set the "Change the service start date for this pool" single date field to a Monday "60" weeks in the future

    And I press the "Continue" button
    And I see error "Service start date must be within the next 12 months"

    #transfer to another court
    Then I set input field with "ID" of "courtNameOrLocation" to "408"
    And I click on the "Bristol (408)" link

    And I set the "Change the service start date for this pool" single date field to a Monday "5" weeks in the future
    And I press the "Continue" button
    And I see "Transfer to Bristol" on the page
    And I press the "Continue" button
    And I see "3 jurors transferred" on the page

    Given I am on "Bureau" "test"
    And I log in as "MODTESTBUREAU"

    #search jurors have been transferred
    When the user searches for juror record "<juror_number1>" from the global search bar
    And I click on "<juror_number1>" in the same row as "Bristol"
    And I see the juror status has updated to "Responded"

    When the user searches for juror record "<juror_number2>" from the global search bar
    And I click on "<juror_number2>" in the same row as "Bristol"
    And I see the juror status has updated to "Responded"

    When the user searches for juror record "<juror_number3>" from the global search bar
    And I click on "<juror_number3>" in the same row as "Bristol"
    And I see the juror status has updated to "Responded"
    Examples:
      | user         | pool_number| juror_number1 | juror_number2   | juror_number3 |
      | MODTESTCOURT | 415308244  | 041500449     | 041500448       | 041500447     |
