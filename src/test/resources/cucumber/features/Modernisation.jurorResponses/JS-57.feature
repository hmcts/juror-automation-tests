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
    And I set "Date of birth" to "03/06/1992"
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

    And I set "Main phone - UK only (optional)" to "07966676541"
    And I press the "Save" button
    And I see "Juror details" on the page

    And the user searches for juror record "<juror_number>" from the global search bar
    And I click on the "Juror details" link
    And I click on the "Add or change" link
    And I set "Main phone - UK only (optional)" to "(0207)2573902!"
    And I press the "Save" button
    And I see "Juror details" on the page



    Examples:
      |user			| juror_number | pool_number |
      |MODTESTBUREAU | 041531675    | 415981923   |
