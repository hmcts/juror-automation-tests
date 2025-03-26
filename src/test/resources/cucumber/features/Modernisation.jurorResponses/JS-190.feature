Feature: JS-190

  @JurorTransformation
  Scenario Outline: Ensure default expenses are being entered when returning and confirming attendance from jury

    Given I am on "Bureau" "ithc"

    When a bureau owned pool is created with jurors
      | court |juror_number  	  | pool_number	    | att_date_weeks_in_future	| owner |
      | 415   |<juror_number>     | <pool_number>   | 5				            | 400	|

    Then a new pool is inserted for where record has transferred to the court new schema
      |part_no            | pool_no           | owner |
      |<juror_number>     | <pool_number>     | 415   |

    And I Confirm all the data in the record attendance table is cleared
    And a new trial is inserted with the trial number "<trial_number>"
    And I log in as "<user>"

    #set juror as responded
    And I update juror "<juror_number>" to have a status of responded in order to record attendance

    And the user searches for juror record "<juror_number>" from the global search bar
    And I click on the "Expenses" link
    And I press change default expenses button
    And I click on the "Cancel without saving" link
    And I press change default expenses button

    #enter default expense
    And I set "Loss of earnings or benefits per day" to "123"
    And I set "Hour" to "2"
    And I set "Minute" to "30"
    And I set "Miles travelled by car, motorcycle or bicycle per day" to "123"
    And I choose the "No" radio button
    And I set "Smartcard Number" to "123456789"
    And I check the "Tick to overwrite any existing draft expenses with these amounts for this juror." checkbox
    And I press the "Save default expenses" button

    #enter bank details
    And I press change juror bank details button
    And I set "Account number" to "12345678"
    And I set "Sort code" to "123456"
    And I set "Account holder's name" to "Account Holder"
    Then I press the "Save" button


    #JUROR ON TRIAL
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

    And I press the "Apps" button
    And I click on the "Trial management" link
    And I click on the trial number "<trial_number>"

    And I press the "Generate panel" button
    And I see "Generate a panel" on the page
    And I see "Which jurors do you want to generate a panel from?" on the page
    And I set the radio button to "All available jurors"
    And I set "Number of jurors needed on this panel" to "1"
    And I press the "Continue" button

    #empanel juror
    And I check the juror "<juror_number>" checkbox

    #Empanel jury
    And I press the "Empanel jury" button
    And I see "How many jurors do you want to empanel?" on the page
    And I set number of jurors to empanel to "1"
    And I press the "Continue" button
    And I see "Empanel jury" on the page
    And I see "When you confirm, anyone not used or challenged will be returned to the ‘jurors in waiting’ list." on the page

    And I select the radio button with name "<juror_number>" and value "juror"
    And I press the "Confirm and empanel jury" button
    And I see "Juror" in the same row as "<juror_number>"


    #RETURN JURY
    And I check the juror "<juror_number>" checkbox
    And I press the "Return jury" button
    And I see "How do you want to return the juror you selected?" on the page
    And I set the radio button to "Return and confirm attendance"
    And I press the "Continue" button

    #check in on confirm attendance
    And I set juror check in hour to "9" on confirm attendance
    And I set juror check in minute to "20" on confirm attendance
    And I click on the am radio button for juror check in on confirm attendance

    #check out on confirm attendance
    And I set juror check out hour to "2" on confirm attendance
    And I set juror check out minute to "30" on confirm attendance
    And I click on the pm radio button for juror check out on confirm attendance

    And I press the "Continue" button
    And I see "Return jurors and confirm attendance" on the page
    And I see "You're returning 1 juror and confirming their attendance for today." on the page
    And I see "A check in time of 9:20am will be applied to any juror without a check in time." on the page
    And I see "A check out time of 2:30pm will be applied to all juror." on the page
    And I see "They'll be returned to the list of jurors in waiting, to continue their service." on the page

    #return juror
    And I press the "Return" button
    Then I verify the text "Do you want to end this trial?" on the page
    And I choose the "No" radio button
    And I press the "Continue" button
    And I see "1 juror returned" on the page


    And the user searches for juror record "<juror_number>" from the global search bar
    And I click on the "Expenses" link
    And I click on view draft expenses link
    And I see "£64.95" in the same row as the date 0 days in the future


    Examples:
      |user			|juror_number  |  pool_number    | trial_number |
      |MODTESTCOURT |041587531     |  415381432      | TESTING13    |


  @JurorTransformation
  Scenario Outline: Ensure default expenses are being entered when returning and confirming attendance via jurors on a trial

    Given I am on "Bureau" "demo"

    When a bureau owned pool is created with jurors
      | court |juror_number  	  | pool_number	    | att_date_weeks_in_future	| owner |
      | 415   |<juror_number>     | <pool_number>   | 5				            | 400	|

    Then a new pool is inserted for where record has transferred to the court new schema
      |part_no            | pool_no           | owner |
      |<juror_number>     | <pool_number>     | 415   |

    And I Confirm all the data in the record attendance table is cleared
    And a new trial is inserted with the trial number "<trial_number>"
    And I log in as "<user>"

    #set juror as responded
    And I update juror "<juror_number>" to have a status of responded in order to record attendance

    And the user searches for juror record "<juror_number>" from the global search bar
    And I click on the "Expenses" link
    And I press change default expenses button
    And I click on the "Cancel without saving" link
    And I press change default expenses button

    #enter default expense
    And I set "Loss of earnings or benefits per day" to "123"
    And I set "Hour" to "2"
    And I set "Minute" to "30"
    And I set "Miles travelled by car, motorcycle or bicycle per day" to "123"
    And I choose the "No" radio button
    And I set "Smartcard Number" to "123456789"
    And I check the "Tick to overwrite any existing draft expenses with these amounts for this juror." checkbox
    And I press the "Save default expenses" button

    #enter bank details
    And I press change juror bank details button
    And I set "Account number" to "12345678"
    And I set "Sort code" to "123456"
    And I set "Account holder's name" to "Account Holder"
    Then I press the "Save" button


    #JUROR ON TRIAL
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

    And I press the "Apps" button
    And I click on the "Trial management" link
    And I click on the trial number "<trial_number>"

    And I press the "Generate panel" button
    And I see "Generate a panel" on the page
    And I see "Which jurors do you want to generate a panel from?" on the page
    And I set the radio button to "All available jurors"
    And I set "Number of jurors needed on this panel" to "1"
    And I press the "Continue" button

    #empanel juror
    And I check the juror "<juror_number>" checkbox

    #Empanel jury
    And I press the "Empanel jury" button
    And I see "How many jurors do you want to empanel?" on the page
    And I set number of jurors to empanel to "1"
    And I press the "Continue" button
    And I see "Empanel jury" on the page
    And I see "When you confirm, anyone not used or challenged will be returned to the ‘jurors in waiting’ list." on the page

    And I select the radio button with name "<juror_number>" and value "juror"
    And I press the "Confirm and empanel jury" button
    And I see "Juror" in the same row as "<juror_number>"

    And I press the "Apps" button
    And I click on the "Juror management" link
    And I click on the "Record attendance" link
    And I click on the "Jurors on a trial" link
    And I see "Confirm attendance" in the same row as "<trial_number>"
    And I click on "Confirm attendance" in the same row as "<trial_number>"
    And I set the radio button to "Today"

    And I set juror check in hour to "9" on confirm attendance
    And I set juror check in minute to "20" on confirm attendance
    And I click on the am radio button for juror check in on confirm attendance

    And I set juror check out hour to "5" on confirm attendance
    And I set juror check out minute to "15" on confirm attendance
    And I click on the pm radio button for juror check out on confirm attendance
    And I check the juror "<juror_number>" checkbox
    And I press the "Confirm" button
    And I see "1 of 1" in the same row as "<trial_number>"

    And the user searches for juror record "<juror_number>" from the global search bar
    And I click on the "Expenses" link
    And I click on view draft expenses link
    And I see "£64.95" in the same row as the date 0 days in the future

    Examples:
      |user			|juror_number  |  pool_number    | trial_number |
      |MODTESTCOURT |041581591     |  415381472      | TESTING15  |