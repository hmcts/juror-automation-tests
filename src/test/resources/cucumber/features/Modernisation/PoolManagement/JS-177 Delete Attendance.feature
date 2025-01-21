Feature: JS-177 Delete Attendance

  @JurorTransformation
  Scenario Outline: JS-177 I can press back after deleting an attendance

    Given I am on "Bureau" "ithc"

    When a bureau owned pool is created with jurors
      | court | juror_number  	    | pool_number	    | att_date_weeks_in_future	| owner |
      | 415   | <juror_number_1>    | <pool_number>     | 5				            | 400	|

    Then a new pool is inserted for where record has transferred to the court new schema
      | part_no              | pool_no           | owner |
      | <juror_number_1>     | <pool_number>     | 415   |

    And I log in as "<user>"

    #set juror as responded
    And I update juror "<juror_number_1>" to have a status of responded in order to record attendance

    #check in juror
    And I press the "Apps" button
    And I click on the "Juror management" link
    And I click on the "Record attendance" link
    And I set the radio button to "Check in"
    And I set "Hour" to "09"
    And I set "Minute" to "00"
    And I set the radio button to "am"
    And I input juror "<juror_number_1>" to be checked in
    And I press the "Check in juror" button

    #check out juror
    And I set the radio button to "Check out"
    And I set "Hour" to "4"
    And I set "Minute" to "00"
    And I select the checkout radio button to "pm"
    And I input juror "<juror_number_1>" to be checked out
    And I press the "Check out juror" button
    
    #confirm attendance
    Then I see "Record attendance" on the page
    When I press the "Confirm attendance" button
    And I press the "Confirm attendance list is correct" button

    #nav to juror record
    And I press the "Apps" button
    And I click on the "Pool management" link
    And I click on the "Search" link
    And I set "Pool number" to "<pool_number>"
    And I press the "Continue" button
    And I click on the "<juror_number_1>" link
    And I click on the "Attendance" link
    And I click on "Change" in the same row as "4:00pm"
    And I click on the "Delete attendance" link
    Then I see "Absences" on the page
    And I click on the "Back" link
    Then I see "/overview" in the URL
    And I do not see "There is a problem" on the page

    Examples:
      | user		  | juror_number_1 | pool_number   |
      | MODTESTCOURT  | 041500151      | 415300178     |
