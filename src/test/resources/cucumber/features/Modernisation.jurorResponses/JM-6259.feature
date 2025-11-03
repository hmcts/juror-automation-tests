Feature: JM-6259 - As a bureau officer I need to be able to send/resend a summons reminder letter

  @JurorTransformation
  Scenario Outline: As a Bureau officer send/resend a summons reminder letter

    Given I am on "Bureau" "ithc"

    Given a bureau owned pool is created with jurors
      | court |juror_number  	    | pool_number	    | att_date_weeks_in_future	| owner |
      | 415   |<juror_number> 	    | <pool_number>     | 5				            | 400	|

    #log on and search for juror
    And I delete all letters within the pool "<pool_number>" for the letter
    And I log in as "<user>"
    And I press the "Apps" button
    And I click on the "Pool management" link
    And I click on the "Search" link
    And I set "Pool number" to "<pool_number>"
    And I press the "Continue" button
    And I get an initial list of the jurors that have been summoned
    And I press the "Summon jurors" button
    And I set "Extra citizens to summon" to "1"
    And I press the "Summon more citizens" button
    And I get a new list of the jurors that have been summoned
    And I remove the initial jurors from the list

    #Send summons reminder
    Then I update a juror in the pool to change the status of printed in order to resend letter
    And I press the "Apps" button
    And I click on the "Documents" link
    And I click on the "Summons reminder" link
    And I set the radio button to "Pool"
    And I set "Enter pool number" to "<pool_number>"
    And I press the "Search" button
    And I see "<pool_number>" on the page
    Then I check the checkbox for one of the jurors in the pool
    And I press the "Send summons reminder" button
    And I see "1 document sent for printing" on the page

    And I press the "Apps" button
    And I click on the "Documents" link
    And I click on the "Summons reminder" link
    And I set the radio button to "Pool"
    And I set "Enter pool number" to "<pool_number>"
    And I press the "Search" button
    And I see "<pool_number>" on the page
    And I see "Pending" on the page

    #Resend summons reminder
    And I press the "Apps" button
    And I click on the "Documents" link
    Then I update a juror in the pool to change the status of printed in order to resend letter
    And I click on the "Summons reminder" link
    And I set the radio button to "Pool"
    And I set "Enter pool number" to "<pool_number>"
    And I press the "Search" button
    And I see "<pool_number>" on the page

    Then I check the checkbox for one of the jurors in the pool
    And I press the "Send summons reminder" button
    And I see "1 document sent for printing" on the page

    Examples:
      |user			| juror_number | pool_number |
      |MODTESTBUREAU | 041596235    | 415395409  |


  @JurorTransformation
  Scenario Outline: As a Bureau officer delete a summons reminder letter which is queued for printing

    Given I am on "Bureau" "ithc"

    Given a bureau owned pool is created with jurors
      | court |juror_number  	    | pool_number	    | att_date_weeks_in_future	| owner |
      | 415   |<juror_number> 	    | <pool_number>     | 5				            | 400	|

    #log on and search for juror
    And I delete all letters within the pool "<pool_number>" for the letter
    And I log in as "<user>"
    And I press the "Apps" button
    And I click on the "Pool management" link
    And I click on the "Search" link
    And I set "Pool number" to "<pool_number>"
    And I press the "Continue" button
    And I get an initial list of the jurors that have been summoned
    And I press the "Summon jurors" button
    And I set "Extra citizens to summon" to "1"
    And I press the "Summon more citizens" button
    And I get a new list of the jurors that have been summoned
    And I remove the initial jurors from the list

    And I press the "Apps" button
    And I click on the "Documents" link
    And I click on the "Summons reminder" link
    And I set the radio button to "Pool"
    And I set "Enter pool number" to "<pool_number>"
    And I press the "Search" button
    And I see "<pool_number>" on the page
    And I check the "<juror_number>" checkbox
    And I press the "Send summons reminder" button
    And I see "1 document sent for printing" on the page

    And I press the "Apps" button
    And I click on the "Documents" link
    And I click on the "Summons reminder" link
    And I set the radio button to "Show all letters queued for printing"
    And I press the "Search" button
    And I see "all letters" on the page
    And I see "Pending" in the same row as "<juror_number>"
    And I click on "Delete" in the same row as "<juror_number>"
    And I see "1 pending document deleted" on the page
    And I do not see "<juror_number>" on the page

    Examples:
      |user			  | juror_number | pool_number  |
      |MODTESTBUREAU  | 041594235    | 415981290    |