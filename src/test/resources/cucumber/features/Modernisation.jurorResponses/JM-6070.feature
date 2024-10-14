Feature: JM-6070 - As a jury officer, I want to record a juror's financial loss for a non-attendance day

  @JurorTransformationMulti
  Scenario Outline: To record a juror's financial loss for a non-attendance day

    Given I am on "Bureau" "ithc"
    When a bureau owned pool is created with jurors
      | court | juror_number   | pool_number	| att_date_weeks_in_future	| owner |
      | 415   | <juror_number> | <pool_number>  | -1				        | 400	|

    Then a new pool is inserted for where record has transferred to the court new schema
      | part_no         | pool_no       | owner |
      | <juror_number>  | <pool_number> | 415   |

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
    When I check the "Tick to overwrite any existing draft expenses with these amounts for this juror." checkbox
    And I press the "Save default expenses" button
    Then I see "Daily expenses" on the page
    And I see "3 hours 15 minutes" in the same row as "Travel time"
    And I see "£100.00" in the same row as "Loss of earnings or benefits per day"
    And I see "3 miles" in the same row as "Miles travelled"
    And I see "123456789" in the same row as "Smartcard number"
    And I press change juror bank details button
    And I set "Account number" to "12345678"
    And I set "Sort code" to "123456"
    And I set "Account holder's name" to "Account Holder"
    And I press the "Save" button
    And I press the "Apps" button
    And I click on the "Juror management" link
    And I click on the "Record attendance" link
    And I press the "Confirm attendance" button
    And I set "Hour" to "11"
    And I set "Minute" to "30"
    And I set the radio button to "pm"
    And I press the "Continue" button
    And I press the "Confirm attendance list is correct" button

    And the user searches for juror record "<juror_number>" from the global search bar
    And I click on the "Expenses" link
    And I click on the "View all expenses" link
    And I click on the "View expenses" link
    And I press the "Add a non-attendance day" button
    And I set the non-attendance date to yesterday
    And I press the "Add non-attendance day" button
    When I click on the non attendance expense link
    Then I see "fname lname" on the page
    And I see "Payment method" on the page
    And I set "Loss of earnings or benefits" to "100"
    And I set the radio button to "Cash"
    When I set "Extra care costs" to "10"
    Then I see "Save and next" on the page
    And I see "Save and back to all days" on the page
    And I see "Cancel without saving" on the page
    And I verify the banner message "You’ve made changes" on the page
    When I click the Recalculate totals link
    Then I see the following details on the enter expenses form
      | Total due                     |£64.95               |
      |Financial loss (capped)        |£64.95               |
    And I press "Save and next" button
    And I see "Juror’s financial loss is over the daily limit" on the page
    And I press the "Continue" button
    And I press "Save and next" button

    Examples:
      | user		 | juror_number | pool_number   |
      | MODTESTCOURT | 041530030    | 415360984     |