Feature: JS-291

  @JurorTransformationMulti
  Scenario Outline: Defer to another court as a bureau officer

    Given I am on "Bureau" "ithc"

    Given a bureau owned pool is created with jurors
      | court |juror_number  	| pool_number	| att_date_weeks_in_future	| owner |
      | 415   |<juror_number1> 	| <pool_number> | 5				            | 400	|
      | 415   |<juror_number2> 	| <pool_number> | 5				            | 400	|
      | 415   |<juror_number3> 	| <pool_number> | 5				            | 400	|

    Given a bureau owned pool is created with jurors
      | court |juror_number  	| pool_number	  | att_date_weeks_in_future	| owner |
      | 457   |<juror_number4> 	| <pool_number2>  | 34			                | 400	|

    And I log in as "<user>"

    Given juror "<juror_number1>" has "DOB" as "1971-08-13 00:00:00.000" new schema
    Given juror "<juror_number2>" has "DOB" as "1971-08-13 00:00:00.000" new schema
    Given juror "<juror_number3>" has "DOB" as "1971-08-13 00:00:00.000" new schema
    Given juror "<juror_number1>" has "LAST_NAME" as "XAVIER" new schema
    Given juror "<juror_number2>" has "LAST_NAME" as "XAVIER" new schema
    Given juror "<juror_number3>" has "LAST_NAME" as "XAVIER" new schema

    When the user searches for juror record "<juror_number1>" from the global search bar
    And I press the "Update juror record" button
    And I choose the "Deferral - grant or refuse" radio button
    And I press the "Continue" button
    Then I select "O - OTHER" from the "Reason for the deferral request" dropdown
    Then I choose the "Grant deferral" radio button
    And I choose the "Other" radio button
    And I set "Deferral date" to "34 mondays time"
    And I choose the "Other" radio button
    And I press the "Continue" button

    When the user searches for juror record "<juror_number2>" from the global search bar
    And I press the "Update juror record" button
    And I choose the "Deferral - grant or refuse" radio button
    And I press the "Continue" button
    Then I select "O - OTHER" from the "Reason for the deferral request" dropdown
    Then I choose the "Grant deferral" radio button
    And I choose the "Other" radio button
    And I set "Deferral date" to "34 mondays time"
    And I choose the "Other" radio button
    And I press the "Continue" button

    When the user searches for juror record "<juror_number3>" from the global search bar
    And I press the "Update juror record" button
    And I choose the "Deferral - grant or refuse" radio button
    And I press the "Continue" button
    Then I select "O - OTHER" from the "Reason for the deferral request" dropdown
    Then I choose the "Grant deferral" radio button
    And I choose the "Other" radio button
    And I set "Deferral date" to "34 mondays time"
    And I choose the "Other" radio button
    And I press the "Continue" button

    And I click on the "Pool management" link
    And I click on deferral maintenance
    And I set input field with "ID" of "courtNameOrLocationCode" to "CHESTER"
    And I click on the "Chester (415)" link
    And I press the "Find" button

    Then I am taken to the deferral maintenance screen for the selected court "Chester (415)"
    And The deferrals table is displayed
    When I set the "last name" deferral filter to "XAVIER"

    And I see "<juror_number1>" on the page
    And I see "<juror_number2>" on the page
    And I see "<juror_number3>" on the page

    When I press the "Move to another court" button
    Then I see error "Select the deferrals you want to move court"

    #move single juror to different court
    When I check the juror "<juror_number1>" checkbox
    And I press the "Move to another court" button
    Then I see "Select a court to move the selected jurors to" on the page
    And I set input field with "ID" of "courtNameOrLocation" to "SWANSEA"
    And I click on the "Swansea Crown Court (457)" link
    And I press the "Continue" button
    Then I see "Choose an active pool to add selected jurors to" on the page

    When I choose the "<pool_number2>" radio button
    And I press the "Continue" button
    Then I see "1 Juror successfully moved to Swansea Crown Court (457) and remain deferred" in the pool banner

    And I do not see "<juror_number1>" on the page

    Then I am taken to the deferral maintenance screen for the selected court "Chester (415)"
    And The deferrals table is displayed
    When I set the "last name" deferral filter to "XAVIER"

    #move multiple jurors to different court
    When I check the select all checkbox
    And I press the "Move to another court" button
    Then I see "Select a court to move the selected jurors to" on the page
    And I set input field with "ID" of "courtNameOrLocation" to "SWANSEA"
    And I click on the "Swansea Crown Court (457)" link
    And I press the "Continue" button
    Then I see "Choose an active pool to add selected jurors to" on the page

    When I choose the "<pool_number2>" radio button
    And I press the "Continue" button
    Then I see "2 Jurors successfully moved to Swansea Crown Court (457) and remain deferred" in the pool banner

    And I do not see "<juror_number2>" on the page
    And I do not see "<juror_number3>" on the page

    When I set input field with "ID" of "courtNameOrLocationCode" to "457"
    And I click on the "Swansea Crown Court (457)" link
    And I press the "Find" button
    And The deferrals table is displayed

    When I set the "last name" deferral filter to "XAVIER"
    Then I see "<juror_number1>" in the same row as "<pool_number2>"
    And I see "<juror_number2>" in the same row as "<pool_number2>"
    And I see "<juror_number3>" in the same row as "<pool_number2>"

    When I click on the "<juror_number1>" link
    And I click on the "History" link

    Then I see "Reassigned to pool - <pool_number2>" on the page

    Examples:
      | user          | pool_number| juror_number1 | juror_number2   | juror_number3 | pool_number2 | juror_number4  |
      | MODTESTBUREAU | 415308245  | 041500450     | 041500451       | 041500452     | 457308245    | 045700450      |
