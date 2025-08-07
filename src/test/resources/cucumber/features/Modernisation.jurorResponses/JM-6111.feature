Feature: JM-6111 - As a jury officer, I want to view a consolidated list of expenses in draft

  @JurorTransformation
  Scenario Outline: View list of draft expenses as a jury officer

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

    #check in jurors
    And I press the "Apps" button
    And I click on the "Juror management" link
    And I click on the "Record attendance" link
    And I set the radio button to "Check in"

    And I set "Hour" to "09"
    And I set "Minute" to "00"
    And I set the radio button to "am"
    And I input juror "<juror_number>" to be checked in
    And I press the "Check in juror" button

    And the user searches for juror record "<juror_number>" from the global search bar
    And I click on the "Expenses" link
    And I see "Daily expenses" on the page
    And I press change default expenses button
    And I see "Set Default Expenses" on the page
    And I click on the "Cancel without saving" link
    And I see "Set default expenses" on the page
    And I press change default expenses button

    And I set "Loss of earnings or benefits per day" to "100"
    And I set "Hour" to "3"
    And I set "Minute" to "15"
    And I set "Miles travelled by car, motorcycle or bicycle per day" to "3"
    And I choose the "Yes" radio button
    And I set "Smartcard Number" to "123456789"
    And I press the "Save default expenses" button
    Then I see "Daily expenses" on the page
    And I see "3 hours 15 minutes" in the same row as "Travel time"
    And I see "£100.00" in the same row as "Loss of earnings or benefits per day"
    And I see "3 miles" in the same row as "Miles travelled"
    And I see "123456789" in the same row as "Smartcard number"

    And I press change juror bank details button
    And I set "Account number" to "12345678"
    And I set "Sort code" to "123456"
    
    #error checks on holders name
    And I set "Account holder's name" to "Account Holder!"
    Then I press the "Save" button
    And I see "Invalid character used in the account holder's name" in the error banner

    And I set "Account holder's name" to "The-Holder & Son'sss"
    Then I press the "Save" button
    And I see "Account holder's name must be 18 characters or fewer" in the error banner

    And I set "Account holder's name" to "The-Holder & Son's"
    Then I press the "Save" button

    And I press the "Apps" button
    And I click on the "Juror management" link
    And I click on the "Record attendance" link
    When I press the "Confirm attendance" button
    And I set "Hour" to "11"
    And I set "Minute" to "30"
    And I set the radio button to "pm"
    And I press the "Continue" button
    And I press the "Confirm attendance list is correct" button

    And the user searches for juror record "<juror_number>" from the global search bar
    And I click on the "Expenses" link
    And I click on the "View all expenses" link
    And I see "Unpaid attendance" on the page
    
    Then I click on "View expenses" in the same row as "<juror_number>"
    And I see the unpaid expenses table

    And I see the following expenses on the jurors unpaid expenses form
      | Attendance                 | 1                                    |
      | Loss of earnings           | £64.95                               |
      | Extra care                 | £0.00                                |
      | Other                      | £0.00                                |
      | P. transport               | £0.00                                |
      | Taxi                       | £0.00                                |
      | Motorcycle                 | £0.00                                |
      | Car                        | £0.00                                |
      | Bicycle                    | £0.00                                |
      | Parking                    | £0.00                                |
      | Food and drink             | £12.17                               |
      | (Smartcard)                | (£0.00)                              |
      | Total                      | £77.12                               |

    Examples:
      |user			|juror_number |   pool_number   |
      |MODTESTCOURT |041536688    | 415360983       |