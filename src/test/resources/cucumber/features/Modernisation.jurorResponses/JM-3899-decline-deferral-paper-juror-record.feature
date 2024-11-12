Feature: JM-3899

  @JurorTransformationMulti @NewSchemaConverted
  Scenario Outline: Decline Deferral Request for Paper Response as Bureau user - Juror Record View

    Given I am on "Bureau" "ithc"

    Given a bureau owned pool is created with jurors
      | court | juror_number  	    | pool_number	    | att_date_weeks_in_future	| owner |
      | 415   | <juror_number> 	    | <pool_number>     | 7				            | 400	|

    And I log in as "<user>"

    When the user searches for juror record "<juror_number>" from the global search bar

    #record paper summons response requesting deferral
    And I record a happy path deferral paper summons response

    Then the view summons reply page is displayed

    And I see the reply "status" on the response "To Do"
    And I see the reply "type" on the response is "Deferral"

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
    And I see "Deferral granted" on the page
    When the user searches for juror record "<juror_number>" from the global search bar
    And I click the update juror record button
    And I set the radio button to "Deferral - grant or refuse"
    Then I click continue on the update juror record screen
    And I select "O - OTHER" from the "Reason for the deferral request" dropdown
    And I set the radio button to "Refuse deferral"
    And I press the "Continue" button

    And I see "Deferral refused (other)" on the page

    Examples:
      | juror_number | pool_number  | user          |
      | 041540009    | 415300409 	| MODTESTBUREAU |

  @JurorTransformationMulti @NewSchemaConverted
  Scenario Outline: Decline Deferral Request for Paper Response as Bureau user - New Pool

    Given I am on "Bureau" "ithc"

    Given a bureau owned pool is created with jurors
      | court | juror_number  	    | pool_number	    | att_date_weeks_in_future	| owner |
      | 452   | <juror_number> 	    | <pool_number>     | 7				            | 400	|

    And juror "<juror_number>" has "FIRST_NAME" as "fnameNewPool" new schema
    And juror "<juror_number>" has "LAST_NAME" as "lnameNewPool" new schema

    And I log in as "<user>"

    When the user searches for juror record "<juror_number>" from the global search bar

    #record paper summons response requesting deferral
    And I record a happy path deferral paper summons response

    Then the view summons reply page is displayed

    And I see the reply "status" on the response "To Do"
    And I see the reply "type" on the response is "Deferral"

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
    And I see "Deferral granted" on the page

    #retrieve record
    When I navigate to the pool request screen
    And I click on deferral maintenance
    When I set input field with "ID" of "courtNameOrLocationCode" to "452"
    And I click on the "Shrewsbury (452)" link
    And I press the "Find" button
    And I see "fnameNewPool" in the same row as "<juror_number>"
    And I check the checkbox in the same row as "<juror_number>"

    #add to new pool
    And I press the "Add to a pool" button
    And I select one of the active pools available
    And I press the "Continue" button

    #now refuse deferral in new pool
    And I search for juror "<juror_number>"
    And I click the update juror record button
    And I set the radio button to "Deferral - grant or refuse"
    Then I click continue on the update juror record screen
    And I select "O - OTHER" from the "Reason for the deferral request" dropdown
    And I set the radio button to "Refuse deferral"
    And I press the "Continue" button

    And I see "Deferral refused (other)" on the page
    And I see juror status is Responded with alert "Deferral refused"

    Examples:
      | juror_number | pool_number  | user          |
      | 045200268    | 452300247 	| MODTESTBUREAU |

