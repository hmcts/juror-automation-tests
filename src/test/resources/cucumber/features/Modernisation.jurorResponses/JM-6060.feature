Feature: JM-6060 - As a jury officer, I want to be able to add or change juror's bank details

  @JurorTransformation @NewSchemaConverted
  Scenario Outline: Change juror bank details happy path

    Given I am on "Bureau" "test"
    When a bureau owned pool is created with jurors
      | court |juror_number  	    | pool_number	    | att_date_weeks_in_future	| owner |
      | 415   |<juror_number>     | <pool_number>       | 5				            | 400	|

    Then a new pool is inserted for where record has transferred to the court new schema
      |part_no              | pool_no           | owner |
      |<juror_number>     | <pool_number>     | 415   |

    And I Confirm all the data in the record attendance table is cleared
    And I log in as "<user>"

    #set juror as responded
    And I update juror "<juror_number>" to have a status of responded in order to record attendance

    #check in jurors
    And I press the "Apps" button
    And I click on the "Juror management" link

    And the user searches for juror record "<juror_number>" from the global search bar
    And I click on the "Expenses" link
    And I see "Daily expenses" on the page

    And I press change juror bank details button
    And I set "Account number" to "12345678"
    And I set "Sort code" to "123456"
    And I set "Account holder's name" to "Account Holder"
    And I see "Address Line Four" on the page

    And I press Add or Change internal note button
    And I set "Add a note" to "This is a test note"
    Then I press the "Save" button
    And I see "This is a test note" on the page


    And I press change juror change address button
    And I set "Address line 1" to "Line 1"
    And I set "Address line 2 (optional)" to "Line 2"
    And I set "Address line 3 (optional)" to "Line 3"
    And I set "Town or city" to "Town"
    And I set "County (optional)" to "County"
    And I set "Postcode" to "CH2 2AB"
    Then I press the "Save" button



    Examples:
      |user			|juror_number |   pool_number   |
      |MODTESTCOURT |041536765    | 415360585       |