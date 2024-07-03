Feature: JM-5962 - As a jury officer I need to be able to bulk change jurors attendance date

  @JurorTransformation @NewSchemaConverted
  Scenario Outline: As a jury officer I want to bulk change multiple jurors attendance date - Happy Path

    Given I am on "Bureau" "test"
    When a bureau owned pool is created with jurors
      | court |juror_number  	    | pool_number	      | att_date_weeks_in_future	| owner |
      | 415   |<juror_number>       | <pool_number>       | 5				            | 400	|
      | 415   |<juror_number_1>     | <pool_number>       | 5				            | 400	|
      | 415   |<juror_number_2>     | <pool_number>       | 5				            | 400	|
      | 415   |<juror_number_3>     | <pool_number>       | 5				            | 400	|
      | 415   |<juror_number_4>     | <pool_number>       | 5				            | 400	|

    Then a new pool is inserted for where record has transferred to the court new schema
      |part_no              | pool_no             | owner |
      |<juror_number>       | <pool_number>       | 415   |
      |<juror_number_1>     | <pool_number>       | 415   |
      |<juror_number_2>     | <pool_number>       | 415   |
      |<juror_number_3>     | <pool_number>       | 415   |
      |<juror_number_4>     | <pool_number>       | 415   |

    And I update juror "<juror_number>" to have a status of "Responded"
    And I update juror "<juror_number_1>" to have a status of "Responded"
    And I update juror "<juror_number_2>" to have a status of "Responded"
    And I update juror "<juror_number_3>" to have a status of "Responded"
    And I update juror "<juror_number_4>" to have a status of "Responded"

    And I log in as "<user>"
    Then I press the "Apps" button
    And I click on the "Pool management" link
    And I click on the "Search" link
    And I set "Pool number" to "<pool_number>"
    And I press the "Continue" button
    And I see "<pool_number>" on the page
    And I see "Jurors in this pool" on the page

    And I check the juror "<juror_number>" checkbox
    And I check the juror "<juror_number_3>" checkbox
    And I check the juror "<juror_number_4>" checkbox
    And I press the "Change next due at court" button
    And I set the "Next due date" date to a Monday "4" weeks in the future
    And I press the "Continue" button
    And I see "Confirm date next due at court" on the page
    And I see "3 jurors will be next due to attend on" on the page
    Then I press the "Continue" button
    And I see the banner for next due at court date

    Examples:
      | user         | juror_number | juror_number_1 | juror_number_2 | juror_number_3 | juror_number_4 | pool_number |
      | MODTESTCOURT | 041537788    | 041537789      | 041537786      | 041537785      | 041537784      | 415366828   |


  @JurorTransformation @NewSchemaConverted
  Scenario Outline: As a jury officer I want to bulk change multiple jurors attendance date - Unhappy Path
    Given I am on "Bureau" "test"
    When a bureau owned pool is created with jurors
      | court |juror_number  	    | pool_number	      | att_date_weeks_in_future	| owner |
      | 415   |<juror_number>       | <pool_number>       | 5				            | 400	|
      | 415   |<juror_number_1>     | <pool_number>       | 5				            | 400	|
      | 415   |<juror_number_2>     | <pool_number>       | 5				            | 400	|
      | 415   |<juror_number_3>     | <pool_number>       | 5				            | 400	|
      | 415   |<juror_number_4>     | <pool_number>       | 5				            | 400	|

    Then a new pool is inserted for where record has transferred to the court new schema
      |part_no              | pool_no             | owner |
      |<juror_number>       | <pool_number>       | 415   |
      |<juror_number_1>     | <pool_number>       | 415   |
      |<juror_number_2>     | <pool_number>       | 415   |
      |<juror_number_3>     | <pool_number>       | 415   |
      |<juror_number_4>     | <pool_number>       | 415   |

    And I update juror "<juror_number>" to have a status of "Responded"
    And I update juror "<juror_number_1>" to have a status of "Responded"
    And I update juror "<juror_number_2>" to have a status of "Responded"

    And I log in as "<user>"
    Then I press the "Apps" button
    And I click on the "Pool management" link
    And I click on the "Search" link
    And I set "Pool number" to "<pool_number>"
    And I press the "Continue" button
    And I see "<pool_number>" on the page
    And I see "Jurors in this pool" on the page

    And I check the juror "<juror_number>" checkbox
    And I check the juror "<juror_number_3>" checkbox
    And I check the juror "<juror_number_4>" checkbox
    And I press the "Change next due at court" button
    And I see error "2 jurors are in an incorrect status to change next due at court date"

    And I update juror "<juror_number_1>" to have a status of "Responded"
    And I update juror "<juror_number_2>" to have a status of "Responded"

    And I click on the "Search" link
    And I set "Pool number" to "<pool_number>"
    And I press the "Continue" button
    And I see "<pool_number>" on the page
    And I check the juror "<juror_number_1>" checkbox
    And I check the juror "<juror_number_2>" checkbox
    And I press the "Change next due at court" button
    And I see "Enter date next due at court" on the page

    And I set the "Next due date" date to a Monday "-23" weeks in the future
    And I press the "Continue" button
    And I see error "Date must be in the future"

    And I set "Enter date next due at court" to "2019/02/10"
    And I press the "Continue" button
    And I see error "Enter a real date"

    And I set "Enter date next due at court" to "2019/02/1!"
    And I press the "Continue" button
    And I see error "Date next due at court can only include numbers and forward slashes"

    And I set "Enter date next due at court" to "15/04/20242222"
    And I press the "Continue" button
    And I see error "Enter a date they’re next due at court in the correct format, for example, 31/01/2023"

    And I set the "Next due date" date to a Monday "5" weeks in the future
    And I press the "Continue" button

    And I see "Confirm date next due at court" on the page
    And I see "2 jurors will be next due to attend on" on the page
    Then I press the "Continue" button
    And I see the banner for next due at court date

    Examples:
      | user         | juror_number | juror_number_1 | juror_number_2 | juror_number_3 | juror_number_4 | pool_number |
      | MODTESTCOURT | 041537783    | 041537782      | 041537781      | 041537780      | 041537779      | 415366829   |
