Feature: JM-3897 mark juror as deferred paper

  @JurorTransformationMulti @NewSchemaConverted
  Scenario Outline: Mark juror as deferred - Send to deferral maintenance Happy path paper
    Given I am on "Bureau" "test"

    Given a bureau owned pool is created with jurors
      | court | juror_number  	    | pool_number	    | att_date_weeks_in_future	| owner |
      | 415   | <juror_number> 	    | <pool_number>     | 5				            | 400	|

    Given I log in as "<user>"
    Given I navigate to the pool request screen
    Given I create an active "civil" court pool request for court "415", "14" Mondays in the future
    When the user searches for juror record "<juror_number>" from the global search bar
    Then I record a happy path deferral paper summons response
    And I see the reply "type" on the response is "DEFERRAL"
    
    Then I click the process reply button
    Then I set the radio button to "Deferral request"
    And I click continue on the process reply page

    Then I set the "first" choice to "11" Mondays in the future
    Then I set the "second" choice to "12" Mondays in the future
    Then I set the "third" choice to "13" Mondays in the future
    And I click continue on the process reply page

    Then I select "O - OTHER" from the "Reason for the deferral request" dropdown
    Then I set the radio button to "Choose a different date"
    Then I set the "alternate" choice to "51" Mondays in the future
    And I press the "Continue" button
  
    Then I see "There are no active pools for this date" on the page
    And I press the "Put in deferral maintenance" button
    
    And I do not see "Sorry, there is a technical problem" on the page
    And I see "Deferral granted (other)" on the page

    Then the user searches for juror record "<juror_number>" from the global search bar
    And I click the summons reply tab

    And I click on the "View summons reply" link
    And I see the reply "type" on the response is "DEFERRAL"
    And I see the reply "status" on the response is "COMPLETED"

    Examples:
      | user		  | juror_number| pool_number  |
      | MODTESTBUREAU | 041500056   | 415300146    |

  @JurorTransformationMulti @NewSchemaConverted
  Scenario Outline: Mark juror as deferred - Add to pool Happy path paper
    # This test may pass but only because of temporary soft deletion of data until JM-4750 is closed
    Given I am on "Bureau" "test"

    Given a bureau owned pool is created with jurors
      | court |juror_number  	    | pool_number	    | att_date_weeks_in_future	| owner |
      | 415   |<juror_number> 	    | <pool_number>     | 5				            | 400	|

    Given I log in as "<user>"
    Given I navigate to the pool request screen
    Given I create an active "civil" court pool request for court "415", "14" Mondays in the future
    When the user searches for juror record "<juror_number>" from the global search bar
    Then I record a happy path deferral paper summons response
    And I see the reply "type" on the response is "DEFERRAL"

    Then I click the process reply button
    Then I set the radio button to "Deferral request"
    And I click continue on the process reply page

    Then I set the "first" choice to "11" Mondays in the future
    Then I set the "second" choice to "12" Mondays in the future
    Then I set the "third" choice to "13" Mondays in the future
    And I click continue on the process reply page

    Then I select "O - OTHER" from the "Reason for the deferral request" dropdown
    Then I set the radio button to "Choose a different date"
    Then I set the "alternate" choice to "14" Mondays in the future
    And I press the "Continue" button

    Then I see "Select a pool for this date" on the page
    And I select the pool I created for the deferral
    And I press the "Continue" button

    And I do not see "Sorry, there is a technical problem" on the page
    And I see "Deferral granted (other)" on the page

    When the user searches for juror record "<juror_number>" from the global search bar
    And I click the summons reply tab
    And I click on the "View summons reply" link
    And I see the reply "type" on the response is "DEFERRAL"
    And I see the reply "status" on the response is "COMPLETED"

    Then I clear down the data for all the pools I created for this test
    Then the poolNumbers lists is empty

    Examples:
      | user		  | juror_number| pool_number |
      | MODTESTBUREAU | 041500057   | 415300147   |

  @JurorTransformationMulti @NewSchemaConverted
  Scenario Outline: Mark juror as deferred - No dates entered validation paper
    Given I am on "Bureau" "test"

    Given a bureau owned pool is created with jurors
      | court |juror_number  	    | pool_number	    | att_date_weeks_in_future	| owner |
      | 415   |<juror_number> 	    | <pool_number>     | 5				            | 400	|

    Given I log in as "<user>"
    When the user searches for juror record "<juror_number>" from the global search bar
    Then I record a happy path deferral paper summons response
    And I see the reply "type" on the response is "DEFERRAL"

    Then I click the process reply button
    Then I set the radio button to "Deferral request"
    And I click continue on the process reply page
    
    And I click continue on the process reply page
    
    Then I see "Enter at least one preferred start date for this juror" on the page

    Examples:
      | user		  | juror_number| pool_number  |
      | MODTESTBUREAU | 041500058   | 415300148    |

  @JurorTransformationMulti @NewSchemaConverted
  Scenario Outline: Mark juror as deferred - Incorrect date format validation paper
    Given I am on "Bureau" "test"

    Given a bureau owned pool is created with jurors
      | court |juror_number  	    | pool_number	    | att_date_weeks_in_future	| owner |
      | 415   |<juror_number> 	    | <pool_number>     | 5				            | 400	|

    Given I log in as "<user>"
    When the user searches for juror record "<juror_number>" from the global search bar
    Then I record a happy path deferral paper summons response
    And I see the reply "type" on the response is "DEFERRAL"

    Then I click the process reply button
    Then I set the radio button to "Deferral request"
    And I click continue on the process reply page

    And I set "First choice" to "12-12-2023"
    And I click continue on the process reply page

    Then I see "Dates must only include numbers and forward slashes" on the page

    Examples:
      | user		  | juror_number  | pool_number  |
      | MODTESTBUREAU | 041500055     | 415300145    |