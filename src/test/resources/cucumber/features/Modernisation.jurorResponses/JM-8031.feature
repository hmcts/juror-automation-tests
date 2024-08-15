Feature: JM-8031

  @JurorTransformation @NewSchemaConverted
  Scenario Outline: As a jury officer I want to ensure travel expenses are not copied over for each day

    Given I am on "Bureau" "ithc"
    When a bureau owned pool is created with jurors
      | court |juror_number  	  | pool_number	    | att_date_weeks_in_future	| owner |
      | 415   |<juror_number>     | <pool_number>   | 5				            | 400	|

    Then a new pool is inserted for where record has transferred to the court new schema
      |part_no            | pool_no           | owner |
      |<juror_number>     | <pool_number>     | 415   |

    And I Confirm all the data in the record attendance table is cleared
    And I log in as "<user>"

    #set juror as responded
    And I update juror "<juror_number>" to have a status of responded in order to record attendance

    And the user searches for juror record "<juror_number>" from the global search bar
    And I click on the "Expenses" link
    And I press change default expenses button
    And I click on the "Cancel without saving" link
    And I press change default expenses button

    #enter default expense
    And I set "Loss of earnings or benefits per day" to "100"
    And I set "Hour" to "3"
    And I set "Minute" to "15"
    And I set "Miles travelled by car, motorcycle or bicycle per day" to "3"
    And I choose the "Yes" radio button
    And I set "Smartcard Number" to "123456789"
    And I check the "Tick to overwrite any existing draft expenses with these amounts for this juror." checkbox
    And I press the "Save default expenses" button

    #enter bank details
    And I press change juror bank details button
    And I set "Account number" to "12345678"
    And I set "Sort code" to "123456"
    And I set "Account holder's name" to "Account Holder"
    Then I press the "Save" button

    And the user searches for juror record "<juror_number>" from the global search bar
    And I click on the "Attendance" link
    And I press the "Add attendance day" button

    When I set the "Attendance Day" date to 8 days in the past
    #check in on confirm attendance
    And I set juror check in hour to "9" on confirm attendance
    And I set juror check in minute to "20" on confirm attendance
    And I click on the am radio button for juror check in on confirm attendance

    #check out on confirm attendance
    And I set juror check out hour to "2" on confirm attendance
    And I set juror check out minute to "30" on confirm attendance
    And I click on the pm radio button for juror check out on confirm attendance
    And I press the "Add attendance day" button

    And the user searches for juror record "<juror_number>" from the global search bar
    And I click on the "Expenses" link
    And I click on view draft expenses link
    And I click the link with the date 8 days in the past
    And I see "Daily expenses" on the page
    And I set "Parking" to "2.00"
    And I set "Public transport" to "2.00"
    And I set "Miles travelled by car, motorcycle or bicycle" to "4"
    And I press the "Save and back to all days" button

    And the user searches for juror record "<juror_number>" from the global search bar
    And I click on the "Attendance" link
    And I press the "Add attendance day" button

    When I set the "Attendance Day" date to 7 days in the past
    #check in on confirm attendance
    And I set juror check in hour to "9" on confirm attendance
    And I set juror check in minute to "20" on confirm attendance
    And I click on the am radio button for juror check in on confirm attendance

    #check out on confirm attendance
    And I set juror check out hour to "2" on confirm attendance
    And I set juror check out minute to "30" on confirm attendance
    And I click on the pm radio button for juror check out on confirm attendance
    And I press the "Add attendance day" button

    And the user searches for juror record "<juror_number>" from the global search bar
    And I click on the "Expenses" link
    And I click on view draft expenses link
    And I click the link with the date 7 days in the past

    And I verify the parking field contains "0.00"
    And I verify the mileage field contains "3"
    And I verify the public transport field contains "0.00"


    Examples:
      |user			|juror_number |   pool_number   |
      |MODTESTCOURT |041576119    | 415362481       |