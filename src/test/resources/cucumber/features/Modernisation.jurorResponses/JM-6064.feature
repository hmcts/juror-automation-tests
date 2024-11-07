Feature:As a jury officer, I want to edit a juror's draft daily expenses

  @JurorTransformation
  Scenario Outline: Edit draft expenses for full day

    Given I am on "Bureau" "ithc"

    When a bureau owned pool is created with jurors
      | court |juror_number       | pool_number      | att_date_weeks_in_future | owner |
      | 415   |<juror_number>     | <pool_number>    | 3                        | 400   |

    And a new pool is inserted for where record has transferred to the court new schema
      |part_no          | pool_no         | owner |
      |<juror_number>   | <pool_number>   | 415   |

    And I Confirm all the data in the record attendance table is cleared

    And I log in as "<user>"

    #set juror as responded
    And I update juror "<juror_number>" to have a status of responded in order to record attendance

     #check in juror
    And I press the "Apps" button
    And I click on the "Juror management" link
    And I click on the "Record attendance" link
    And I set the radio button to "Check in"

    And I set "Hour" to "09"
    And I set "Minute" to "00"
    And I set the radio button to "am"
    And I input juror "<juror_number>" to be checked in
    And I press the "Check in juror" button
    And I see "<juror_number>" in the same row as "9:00am"

    And the user searches for juror record "<juror_number>" from the global search bar
    And I click on the "Expenses" link
    And I see "Daily expenses" on the page

    And I press change default expenses button

    And I set "Loss of earnings or benefits per day" to "100"
    And I set "Hour" to "3"
    And I set "Minute" to "15"
    And I set "Miles travelled by car, motorcycle or bicycle per day" to "3"
    And I set the radio button to "Yes"
    And I check the "Tick to overwrite any existing draft expenses with these amounts for this juror." checkbox
    And I press the "Save default expenses" button
    And I see "Daily expenses" on the page
    And I see "3 hours 15 minutes" in the same row as "Travel time"
    And I see "£100.00" in the same row as "Loss of earnings or benefits per day"
    And I see "3 miles" in the same row as "Miles travelled"
    And I press the "Apps" button
    And I click on the "Juror management" link
    And I click on the "Record attendance" link
    And I press the "Confirm attendance" button
    And I set "Hour" to "5"
    And I set "Minute" to "30"
    And I set the radio button to "pm"
    And I press the "Continue" button
    And I press the "Confirm attendance list is correct" button
    And the user searches for juror record "<juror_number>" from the global search bar
    And I click on the "Expenses" link
    And I click on the "View all expenses" link
    And I click on "View expenses" in the same row as "<juror_number>"
    And I see the unpaid expenses table
        #edit draft expenses
    And I click on my draft expense link with todays date
    And I see "Daily expenses" on the page
    And I see "Time" on the page
    And I see "Financial loss" on the page
    And I see "Travel" on the page
    And I see "Payment method" on the page
    And I see "Food and drink" on the page
    And I see "Apply to all days" on the page
    And I see "Totals" on the page
        #change time/error checks
    And I set "Hour" to "67"
    And I set "Minute" to "98"
        #change financial loss/error checks
    And I set "Loss of earnings or benefits" to "123456!!"
    And I set "Extra care costs" to "123456!!"
    And I set "Other costs" to "123456!!"
    And I set "Description of other costs" to "Testingothercosts12!)"
        #change Travel/error checks
    And I check the "Car" checkbox
    And I see "Number of other jurors taken as passengers" on the page
    And I set "Number of other jurors taken as passengers" to "123456!!"
    And I check the "Motorcycle" checkbox
    And I check the "Bicycle" checkbox
    And I set "Parking" to "123456!!"
    And I set "Public transport" to "123456!!"
    And I set "Taxi" to "123456!!"
        #change food and drink/error checks
    And I set "Amount spent on smartcard for this day" to "123456!!"
    And I press the "Save and next" button
    And I see error "Enter minutes between 0 and 59"
    And I check the "Car" checkbox
    And I see error "Number of other jurors taken as passengers can only include numbers"
    And I see error "Amount spent on smartcard can only include numbers and a decimal point"
    And I see error "Parking amount can only include numbers and a decimal point"
    And I see error "Public transport amount can only include numbers and a decimal point"
    And I see error "Taxi amount can only include numbers and a decimal point"
    And I see error "Loss of earnings or benefits per day can only include numbers and a decimal point"
    And I see error "Extra care costs can only include numbers and a decimal point"
    And I see error "Other costs can only include numbers and a decimal point"
    And I click on the "Cancel without saving" link
    And I click on my draft expense link with todays date

    #new validation of value input
    And I set "Loss of earnings or benefits" to "10,00"
    And I set "Extra care costs" to "10:00"
    And I set "Other costs" to "0.010.10"
    And I press the "Save and next" button
    And I see error "Loss of earnings or benefits per day can only include numbers and a decimal point"
    And I see error "Extra care costs can only include numbers and a decimal point"
    And I see error "Other costs can only include numbers and a decimal point"

    And I set "Loss of earnings or benefits" to "300"
    And I set "Extra care costs" to "10"
    And I set "Other costs" to "0"
    And I verify the banner message "You’ve made changes" on the page
    And I click on the "Recalculate totals." link
    And I press the "Save and next" button
    Then I see "Juror’s financial loss is over the daily limit" on the page
    And I see "The amounts you entered will be automatically recalculated to limit the juror’s loss to £64.95." on the page
    And I see the following details on the loss over limit form
      | Juror's loss                | £310                        |
      | Daily limit (Full day)      | £64.95                      |

    Examples:
      |user         |juror_number  |  pool_number    |
      |MODTESTCOURT |041520020     |  415300201      |

  @JurorTransformation
  Scenario Outline: Edit draft expenses for half day and verify error message as Juror’s financial loss is over the daily limit

    Given I am on "Bureau" "ithc"
    When a bureau owned pool is created with jurors
      | court |juror_number      | pool_number      | att_date_weeks_in_future | owner  |
      | 415   |<juror_number>    | <pool_number>    | 5                        | 400    |

    And a new pool is inserted for where record has transferred to the court new schema
      |part_no         | pool_no           | owner |
      |<juror_number>  | <pool_number>     | 415   |

    And I Confirm all the data in the record attendance table is cleared
    And I log in as "<user>"

    #set juror as responded
    And I update juror "<juror_number>" to have a status of responded in order to record attendance

    #check in juror
    And I press the "Apps" button
    And I click on the "Juror management" link
    And I click on the "Record attendance" link
    And I set the radio button to "Check in"

    And I set "Hour" to "09"
    And I set "Minute" to "00"
    And I set the radio button to "am"
    And I input juror "<juror_number>" to be checked in
    And I press the "Check in juror" button
    And I see "<juror_number>" in the same row as "9:00am"

    And the user searches for juror record "<juror_number>" from the global search bar
    And I click on the "Expenses" link
    And I see "Daily expenses" on the page
    And I press change default expenses button
    And I set "Loss of earnings or benefits per day" to "100"
    And I set "Hour" to "3"
    And I set "Minute" to "15"
    And I set "Miles travelled by car, motorcycle or bicycle per day" to "3"
    And I set the radio button to "Yes"
    And I set "Smartcard Number" to "123456789"
    And I check the "Tick to overwrite any existing draft expenses with these amounts for this juror." checkbox
    And I press the "Save default expenses" button
    And I see "Daily expenses" on the page
    And I see "3 hours 15 minutes" in the same row as "Travel time"
    And I see "£100.00" in the same row as "Loss of earnings or benefits per day"
    And I see "3 miles" in the same row as "Miles travelled"
    And I see "123456789" in the same row as "Smartcard number"
    And I press the "Apps" button
    And I click on the "Juror management" link
    And I click on the "Record attendance" link
    And I press the "Confirm attendance" button
    And I set "Hour" to "5"
    And I set "Minute" to "30"
    And I set the radio button to "pm"
    And I press the "Continue" button
    And I press the "Confirm attendance list is correct" button
    And the user searches for juror record "<juror_number>" from the global search bar
    And I click on the "Expenses" link
    And I click on the "View all expenses" link
    And I click on "View expenses" in the same row as "<juror_number>"
    And I see the unpaid expenses table

    #edit draft expenses
    And I click on my draft expense link with todays date
    And I set the radio button to "Half day"
    And I see "Daily expenses" on the page
    And I see "Time" on the page
    And I see "Financial loss" on the page
    And I see "Travel" on the page
    And I see "Payment method" on the page
    And I see "Food and drink" on the page
    And I see "Apply to all days" on the page
    And I see "Totals" on the page
    And I click on the "Cancel without saving" link
    And I click on my draft expense link with todays date
    And I set the radio button to "Half day"
    And I set "Loss of earnings or benefits" to "45"
    And I verify the banner message "You’ve made changes" on the page
    And I click on the "Recalculate totals." link
    And I press the "Save and next" button
    Then I see "Juror’s financial loss is over the daily limit" on the page
    And I see "The amounts you entered will be automatically recalculated to limit the juror’s loss to £37.45." on the page
    And I see the following Half day daily day limit details on the loss over limit form
      | Juror's loss                | £45                      |
      | Daily limit (Half day)      | £37.45                   |

    Examples:
      |user         |juror_number  |  pool_number    |
      |MODTESTCOURT |041520020     |  415300201      |


  @JurorTransformation
  Scenario Outline: Edit draft expenses for half day and verify error message as Amounts entered are more than court’s suggested daily limits

    Given I am on "Bureau" "ithc"
    When a bureau owned pool is created with jurors
      | court |juror_number      | pool_number      | att_date_weeks_in_future | owner |
      | 415   |<juror_number>    | <pool_number>    | 5                        | 400   |

    And a new pool is inserted for where record has transferred to the court new schema
      |part_no              | pool_no           | owner |
      |<juror_number>       | <pool_number>     | 415   |

    And I Confirm all the data in the record attendance table is cleared
    And I log in as "<user>"

    #set juror as responded
    And I update juror "<juror_number>" to have a status of responded in order to record attendance
    And I update daily expense amounts entered are more than courts suggested daily limits

    #check in juror
    And I press the "Apps" button
    And I click on the "Juror management" link
    And I click on the "Record attendance" link
    And I set the radio button to "Check in"

    And I set "Hour" to "09"
    And I set "Minute" to "00"
    And I set the radio button to "am"
    And I input juror "<juror_number>" to be checked in
    And I press the "Check in juror" button
    And I see "<juror_number>" in the same row as "9:00am"

    And the user searches for juror record "<juror_number>" from the global search bar
    And I click on the "Expenses" link
    And I see "Daily expenses" on the page
    And I press change default expenses button

    And I set "Loss of earnings or benefits per day" to "100"
    And I set "Hour" to "3"
    And I set "Minute" to "15"
    And I set "Miles travelled by car, motorcycle or bicycle per day" to "3"
    And I set the radio button to "Yes"
    And I set "Smartcard Number" to "123456789"
    And I check the "Tick to overwrite any existing draft expenses with these amounts for this juror." checkbox
    And I press the "Save default expenses" button

    And I see "Daily expenses" on the page
    And I see "3 hours 15 minutes" in the same row as "Travel time"
    And I see "£100.00" in the same row as "Loss of earnings or benefits per day"
    And I see "3 miles" in the same row as "Miles travelled"
    And I see "123456789" in the same row as "Smartcard number"

    And I press the "Apps" button
    And I click on the "Juror management" link
    And I click on the "Record attendance" link
    And I press the "Confirm attendance" button
    And I set "Hour" to "5"
    And I set "Minute" to "30"
    And I set the radio button to "pm"
    And I press the "Continue" button
    And I press the "Confirm attendance list is correct" button

    And the user searches for juror record "<juror_number>" from the global search bar
    And I click on the "Expenses" link
    And I click on the "View all expenses" link
    And I click on "View expenses" in the same row as "<juror_number>"
    And I see the unpaid expenses table

        #edit draft expenses
    And I click on my draft expense link with todays date
    And I set the radio button to "Half day"
    And I see "Daily expenses" on the page
    And I see "Time" on the page
    And I see "Financial loss" on the page
    And I see "Travel" on the page
    And I see "Payment method" on the page
    And I see "Food and drink" on the page
    And I see "Apply to all days" on the page
    And I see "Totals" on the page
    And I click on the "Cancel without saving" link
    And I click on my draft expense link with todays date
    And I set the radio button to "Half day"
    And I set "Loss of earnings or benefits" to "20"
    And I set "Public transport" to "11"
    And I set "Taxi" to "11"
    And I verify the banner message "You’ve made changes" on the page
    And I click on the "Recalculate totals." link
    And I press the "Save and next" button
    Then I see "Some amounts entered are more than your court’s suggested daily limits" on the page
    And I see the following public expenses on travel overlimit page
      |Daily limit                 | £10           |
      |Amount entered              | £11           |
    And I see the following taxi expenses on travel overlimit page
      |Daily limit                 | £10           |
      |Amount entered              | £11           |
    And I click on the "Go back and change" link
    And I set the radio button to "Half day"
    And I set "Public transport" to "12"
    And I set "Taxi" to "14"
    And I press the "Save and next" button
    And I see the following public expenses on travel overlimit page
      | Daily limit                 | £10           |
      | Amount entered              | £12           |
    And I see the following taxi expenses on travel overlimit page
      | Daily limit                 | £10           |
      | Amount entered              | £14           |
    And I press the "Pay amount entered" button
    And I see "fname lname" on the page

    Examples:
      |user         |juror_number  |  pool_number    |
      |MODTESTCOURT |041520020     |  415300201      |