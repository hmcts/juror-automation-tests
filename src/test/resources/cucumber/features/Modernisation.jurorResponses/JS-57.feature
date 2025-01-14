Feature: JS-57

  @JurorTransformationMulti @Messages
  Scenario Outline: Check juror number can contain special charcters

    Given I am on "Bureau" "ithc"

    Given a bureau owned pool is created with jurors
      | court |juror_number      | pool_number	    | att_date_weeks_in_future	| owner |
      | 415   |<juror_number>    | <pool_number>    | 5				            | 400	|

    #log on and search for juror
    And I log in as "<user>"

    And the user searches for juror record "<juror_number>" from the global search bar
    And I click on the "Juror details" link
    And I click on the "Add or change" link
    And I set "Main phone - UK only (optional)" to "079399-58017"
    And I press the "Save" button
    And I see "079399-58017" in the same row as "Main phone"

    And the user searches for juror record "<juror_number>" from the global search bar
    And I click on the "Juror details" link
    And I click on the "Add or change" link
    And I set "Main phone - UK only (optional)" to "+447939958017"
    And I press the "Save" button
    And I see "+447939958017" in the same row as "Main phone"


    And the user searches for juror record "<juror_number>" from the global search bar
    And I click on the "Juror details" link
    And I click on the "Add or change" link
    And I set "Main phone - UK only (optional)" to "++44(0)7939958017"
    And I press the "Save" button
    And I see "+44(0)7939958017" in the same row as "Main phone"

    And the user searches for juror record "<juror_number>" from the global search bar
    And I click on the "Juror details" link
    And I click on the "Add or change" link
    And I set "Main phone - UK only (optional)" to "0044(0)7939958017"
    And I press the "Save" button
    And I see "0044(0)7939958017" in the same row as "Main phone"

    And the user searches for juror record "<juror_number>" from the global search bar
    And I click on the "Juror details" link
    And I click on the "Add or change" link
    And I set "Main phone - UK only (optional)" to "(079)39958017"
    And I press the "Save" button
    And I see "(079)39958017" in the same row as "Main phone"

    And the user searches for juror record "<juror_number>" from the global search bar
    And I click on the "Juror details" link
    And I click on the "Add or change" link
    And I set "Main phone - UK only (optional)" to "07939958017777777777"
    And I press the "Save" button
    And I see "UK mobile number can only contain 11 digits" in the error banner

    And I set "Main phone - UK only (optional)" to "02082112"
    And I press the "Save" button
    And I see "UK telephone number must contain 11 to 13 digits" in the error banner

    And the user searches for juror record "<juror_number>" from the global search bar
    And I click on the "Juror details" link
    And I click on the "Add or change" link
    And I set "Main phone - UK only (optional)" to "02072573902!"
    And I press the "Save" button
    And I see "Telephone number cannot contain letters or special characters apart from hyphens, dashes, brackets or a plus sign." in the error banner

    And I set "Main phone - UK only (optional)" to "02072573902P"
    And I press the "Save" button
    And I see "Telephone number cannot contain letters or special characters apart from hyphens, dashes, brackets or a plus sign." in the error banner

    And I set "Main phone - UK only (optional)" to "+337908 208777"
    And I press the "Save" button
    And I see "Enter a UK telephone number" in the error banner

    And I press the "Apps" button
    And I click on the "Messaging" link
    And I see "Send messages" on the page
    And I click on the "Bad weather" link
    And I see "Message details" on the page
    And I see the draft message template
    And I see "Due to local adverse weather conditions, you are not required to attend the court until further notice. Please await further information. If you have any questions, please contact the jury office on <court_phone>." on the page
    And I press the "Continue" button
    And I see "Find jurors to send message to" on the page

    And I choose the "Juror number" radio button
    And I set "Enter juror number" to "<juror_number>"
    And I press the "Continue" button
    And I click on the methods dropdown and select "Text" for juror "<juror_number>"
    And I check the juror "<juror_number>" checkbox
    And I press the "Send message" button

    And I see "Check and send message" on the page
    And I see "You’re sending the following message to 1 jurors. You cannot undo this after sending." on the page
    And I see "Due to local adverse weather conditions, you are not required to attend the court until further notice. Please await further information. If you have any questions, please contact the jury office on 01244 356726." on the page
    And I press the "Send message" button
    And I see the message sent banner containing "Message will be sent to 1 jurors"
    And I see the juror "<juror_number>" has a message in the database


    Examples:
      |user			| juror_number | pool_number |
      |MODTESTBUREAU | 041531675    | 415981923   |
