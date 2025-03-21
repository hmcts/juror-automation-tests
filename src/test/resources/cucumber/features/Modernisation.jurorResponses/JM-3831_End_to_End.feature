Feature: JM-3831

  @JurorTransformationMulti @NewSchemaConverted
  Scenario Outline: Decline Excusal Request as Bureau user - happy path

    Given I am on "Bureau" "ithc"

    Given a bureau owned pool is created with jurors
      | court |juror_number  	    | pool_number	    | att_date_weeks_in_future	| owner |
      | 415   |<juror_number> 	    | <pool_number>     | 7				            | 400	|

    And I log in as "<user>"

    When the user searches for juror record "<juror_number>" from the global search bar

    #record paper summons response
    And I click the Enter summons reply button
    Then the juror details form is displayed

    #juror details
    When I fill in all of the juror details for the summons reply
    And I click continue on the juror summons reply page

    #eligibility
    Then the juror summons reply eligibility page is displayed
    When I answer the juror summons reply eligibility questions
    And I click continue on the juror summons reply page

    #can attend on date
    Then the juror summons reply types page is displayed
    When I set the radio button to "Excusal request"
    And I click continue on the juror summons reply page

    #cjs
    Then the juror summons reply CJS employment page is displayed
    When I select that the juror has not worked in the criminal justice system
    And I click continue on the juror summons reply page

    #reasonable adjustments
    Then the juror summons reply reasonable adjustments page is displayed
    When I select that the juror does not need adjustments
    And I click continue on the juror summons reply page

    #confirm/sign
    Then the juror summons reply Signature page is displayed
    When I select that the summons reply has been signed
    And I click done on the juror summons reply page
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
    And I see "Excusal refused" on the page
    And I see the juror status has updated to "Responded"
    Examples:
      | user          | juror_number   | pool_number   |
      | MODTESTBUREAU | 641500248      | 415170501     |