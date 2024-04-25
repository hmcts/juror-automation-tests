Feature: JM-3899

  @JurorTransformationMulti @NewSchemaConverted
  Scenario Outline: Decline Deferral Request for Paper Response as Bureau user - Juror Record View

    Given I am on "Bureau" "test"

    Given a bureau owned pool is created with jurors
      | court | juror_number  	    | pool_number	    | att_date_weeks_in_future	| owner |
      | 415   | <juror_number> 	    | <pool_number>     | 7				            | 400	|

    And I log in as "<user>"

    When the user searches for juror record "<juror_number>" from the global search bar

    #record paper summons response requesting deferral
    And I record a happy path deferral paper summons response

    Then the view summons reply page is displayed

    And I see the reply "status" on the response is "TO DO"
    And I see the reply "type" on the response is "DEFERRAL"

    Then I click on the "View juror's record" link
    And I click the update juror record button
    And I set the radio button to "Deferral - grant or refuse"
    Then I click continue on the update juror record screen
    And I select "O - OTHER" from the "Reason for the deferral request" dropdown
    # Grant first deferral as first deferral cannot be declined
    And I set the radio button to "Grant deferral"
    Then I select to Choose a different date
    Then I set the "new" choice to "51" Mondays in the future
    And I press the "Continue" button
    And I see "Deferral granted (other)" on the page
    And I click the update juror record button
    And I set the radio button to "Deferral - grant or refuse"
    Then I click continue on the update juror record screen
    And I select "O - OTHER" from the "Reason for the deferral request" dropdown
    And I set the radio button to "Refuse deferral"
    And I press the "Continue" button
    And I see error "Date cannot be earlier than original summons date"

    Examples:
      |juror_number	|pool_number 	|user          |
      |041540009|415300409 	|MODTESTBUREAU |
