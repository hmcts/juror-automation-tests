Feature: JM-6114 - As a jury officer, I want to edit submitted expenses before approval

  @JurorTransformation @NewSchemaConverted
  Scenario Outline: Edit expenses while pending approval as a jury officer

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

    #check in jurors and set default expenses
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
    And I set "Loss of earnings or benefits per day" to "30"
    And I set "Hour" to "3"
    And I set "Minute" to "15"
    And I set "Miles travelled by car, motorcycle or bicycle per day" to "3"
    And I choose the "Yes" radio button
    And I set "Smartcard Number" to "123456789"
    And I check the "Tick to overwrite any existing draft expenses with these amounts for this juror." checkbox
    And I press the "Save default expenses" button
    Then I see "Daily expenses" on the page

    #Confirm attendance
    When I press the "Apps" button
    And I click on the "Juror management" link
    And I click on the "Record attendance" link
    And I press the "Confirm attendance" button
    And I set "Hour" to "11"
    And I set "Minute" to "30"
    And I set the radio button to "pm"
    And I press the "Continue" button
    Then I press the "Confirm attendance list is correct" button

    #Submit for approval
    When the user searches for juror record "<juror_number>" from the global search bar
    And I click on the "Expenses" link
    And I click on the "View all expenses" link
    Then I see "Unpaid attendance" on the page
    When I click on "View expenses" in the same row as "<juror_number>"
    And I see the unpaid expenses table
    And I check the checkbox containing my expense date
    And I press the "Submit for approval" button
    Then I see "Expenses submitted for approval" on the page
    And I click on the "For approval" link

    #Edit expense that is in approval
    When I check the checkbox containing my expense date
    And I click the edit expenses for approval button
    And I see "Edit expenses for approval" on the page
    And I click on my expense link with todays date
    Then I see "FOR APPROVAL" on the page
    When I set "Loss of earnings or benefits" to "90"
    And I set "Extra care costs" to "10"
    And I verify the banner message "You’ve made changes" on the page
    And I click on the "Recalculate totals." link
    And I press the "Save and next" button
    Then I see "Juror’s financial loss is over the daily limit" on the page
    And I see "The amounts you entered will be automatically recalculated to limit the juror’s loss to £64.95." on the page
    And I see the following details on the loss over limit form
      | Juror's loss                | £100                       |
      | Daily limit (Full day)      | £64.95                      |

    #Resubmit expenses
    When I press the "Continue" button
    And I see "Totals" in the same row as "£64.95"
    And I press the "Submit for approval" button
    Then I verify the banner message "Expenses resubmitted for approval" on the page


    Examples:
      |user			|juror_number |   pool_number   |
      |MODTESTCOURT |041536649    | 415360943       |