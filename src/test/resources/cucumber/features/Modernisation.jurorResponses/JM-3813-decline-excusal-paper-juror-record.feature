Feature: JM-3813

  @JurorTransformationMulti
  Scenario Outline: Decline Excusal Request for Paper Response as Bureau user - Juror Record View

    Given I am on "Bureau" "ithc"

    Given a bureau owned pool is created with jurors
      | court  | juror_number  	| pool_number	   | att_date_weeks_in_future	| owner |
      | 415    | <juror_number> | <pool_number>    | 5			                | 400	|

    And juror "<juror_number>" has "FIRST_NAME" as "<fname>" new schema
    And juror "<juror_number>" has "LAST_NAME" as "<lname>" new schema

    And I log in as "<user>"

    When the user searches for juror record "<juror_number>" from the global search bar

    #record paper summons response
    And I record an excusal request paper summons response

    Then the view summons reply page is displayed

    And I see the reply "status" on the response is "To Do"
    And I see the reply "type" on the response is "Excusal"

    #process response : cancel and return
    Then I see the name of the juror on the page header
    And I see the reply status on the page
    And I press the "Process reply" button
    Then I click on the "Cancel" link
    And I see "View juror's record" on the page

    #error message when no option selected
    And I press the "Process reply" button
    And I press the "Continue" button
    And I see error "Please select a response process type"

    #select refuse excusal
    And I set the radio button to "Excusal - grant or refuse"
    Then I press the "Continue" button
    And I select "O - OTHER" from the "Reason for excusal request" dropdown
    And I set the radio button to "Refuse excusal"
    And I press the "Continue" button

    #return to juror record
    When the user searches for juror record "<juror_number>" from the global search bar
    Then I am on the Juror Record for juror "<juror_number>"
    Then I see the juror's status on the juror record screen is "Summoned"

    #check updated summons reply tab
    When I click on the Summons Reply tab
    Then I see the reply status of the summons reply on juror record is "To Do"
    And I see the reply date of the summons reply on juror record is "today"
    And I see the reply method of the summons reply on juror record is "Paper"

    Examples:
      | user          | juror_number  | pool_number   |fname           |lname          |
      | MODTESTBUREAU | 041500078     | 415300168     |FNAMETWOZEROTWO |LNAMETWOZEROTWO|
