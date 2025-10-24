Feature: JS-537 Defer Beyond 12 Months

  @JurorTransformationMulti
  Scenario Outline: Bureau Manager Defer Beyond 12 Months

    Given I am on "Bureau" "ithc"

    Given a bureau owned pool is created with jurors
      | court |juror_number  	        | pool_number	    | att_date_weeks_in_future	| owner |
      | 415   |<juror_number> 	        | <pool_number>     | 5				            | 400	|

    Given I log in as "MODTESTBUREAU"
    When the user searches for juror record "<juror_number>" from the global search bar
    Then I record a happy path deferral paper summons response
    And I see the reply "type" on the response is "Deferral"

    Then I click the process reply button
    Then I set the radio button to "Deferral request"
    And I click continue on the process reply page

    Then I set the "first" choice to "200" Mondays in the future
    Then I set the "second" choice to "201" Mondays in the future
    Then I set the "third" choice to "202" Mondays in the future
    And I click continue on the process reply page

    Then I select "O - OTHER" from the "Reason for the deferral request" dropdown
    When I select to Choose a different date
    Then I set the "alternate" choice to "203" Mondays in the future
    And I press the "Continue" button

    Then I see "There are no active pools for this date" on the page
    And I press the "Put in deferral maintenance" button

    Then I see "Confirm long deferral" on the page
    And I see "Are you sure you want to defer the juror for over 12 months?" on the page
    And I press the "Continue" button

    When the user searches for juror record "<juror_number>" from the global search bar
    And I see the juror status on the juror record screen is "Deferred"
    And I see the number of deferrals is "1"
    And I see under pool details the pool number is "In deferral maintenance"

    And I click the change link for the juror deferral
    And I set "Date to defer to" to "304 mondays time"
    And I press the "Save changes" button

    Then I see "There are no active pools for this date" on the page
    And I press the "Put in deferral maintenance" button

    Then I see "Confirm long deferral" on the page
    And I see "Are you sure you want to defer the juror for over 12 months?" on the page
    And I press the "Continue" button

    And I see "Juror record updated" on the page

    Examples:
      | juror_number| pool_number |
      | 041500063	| 415300170	  |

  @JurorTransformationMulti
  Scenario Outline: Bureau Non-Manager Cannot Defer Beyond 12 Months

    Given I am on "Bureau" "ithc"

    Given a bureau owned pool is created with jurors
      | court |juror_number  	        | pool_number	    | att_date_weeks_in_future	| owner |
      | 415   |<juror_number> 	        | <pool_number>     | 5				            | 400	|

    Given I log in as "ARAMIS1"
    When the user searches for juror record "<juror_number>" from the global search bar
    Then I record a happy path deferral paper summons response
    And I see the reply "type" on the response is "Deferral"

    Then I click the process reply button
    Then I set the radio button to "Deferral request"
    And I click continue on the process reply page

    Then I set the "first" choice to "200" Mondays in the future
    Then I set the "second" choice to "201" Mondays in the future
    Then I set the "third" choice to "202" Mondays in the future
    And I click continue on the process reply page

    And I see "Date cannot be more than 12 months after the original summons date" on the page

    Then I set the "first" choice to "6" Mondays in the future
    Then I set the "second" choice to "7" Mondays in the future
    Then I set the "third" choice to "8" Mondays in the future
    And I click continue on the process reply page

    Then I select "O - OTHER" from the "Reason for the deferral request" dropdown
    And I choose the "Choose a different date" radio button
    And I set the "Deferral" date to a Monday "49" weeks in the future
    And I press the "Continue" button

    Then I see "There are no active pools for this date" on the page
    And I press the "Put in deferral maintenance" button

    When the user searches for juror record "<juror_number>" from the global search bar
    And I see the juror status on the juror record screen is "Deferred"
    And I see the number of deferrals is "1"
    And I see under pool details the pool number is "In deferral maintenance"

    And I click the change link for the juror deferral
    And I set "Date to defer to" to "203 mondays time"
    And I press the "Save changes" button
    Then I see "Date cannot be more than 12 months after the original summons date" on the page

    Examples:
      | juror_number| pool_number |
      | 041500079	| 415300176	  |


  @JurorTransformationMulti
  Scenario Outline: Court Manager Defer Beyond 12 Months

    Given I am on "Bureau" "ithc"

    Given a bureau owned pool is created with jurors
      | court |juror_number  	        | pool_number	    | att_date_weeks_in_future	| owner |
      | 415   |<juror_number> 	        | <pool_number>     | 5				            | 400	|

    Then a new pool is inserted for where record has transferred to the court new schema
      |part_no        | pool_no       | owner |
      |<juror_number> | <pool_number> | 415   |

    Given I log in as "CMANAGER"
    When the user searches for juror record "<juror_number>" from the global search bar
    Then I record a happy path deferral paper summons response
    And I see the reply "type" on the response is "Deferral"

    Then I click the process reply button
    Then I set the radio button to "Deferral request"
    And I click continue on the process reply page

    Then I set the "first" choice to "100" Mondays in the future
    Then I set the "second" choice to "101" Mondays in the future
    Then I set the "third" choice to "102" Mondays in the future
    And I click continue on the process reply page

    Then I select "O - OTHER" from the "Reason for the deferral request" dropdown
    When I select to Choose a different date
    Then I set the "alternate" choice to "102" Mondays in the future
    And I press the "Continue" button

    Then I see "There are no active pools for this date" on the page
    And I press the "Put in deferral maintenance" button

    Then I see "Confirm long deferral" on the page
    And I see "Are you sure you want to defer the juror for over 12 months?" on the page
    And I press the "Continue" button

    And I see "Do you want to print a deferral granted letter?" on the page
    And I choose the "No" radio button
    And I press the "Continue" button

    When the user searches for juror record "<juror_number>" from the global search bar
    And I see the juror status on the juror record screen is "Deferred"
    And I see the number of deferrals is "1"
    And I see under pool details the pool number is "In deferral maintenance"

    And I click the change link for the juror deferral
    And I set "Date to defer to" to "304 mondays time"
    And I press the "Save changes" button

    Then I see "There are no active pools for this date" on the page
    And I press the "Put in deferral maintenance" button

    Then I see "Confirm long deferral" on the page
    And I see "Are you sure you want to defer the juror for over 12 months?" on the page
    And I press the "Continue" button

    And I see "Juror record updated" on the page

    Examples:
      | juror_number| pool_number |
      | 041500080	| 415300177	  |

  @JurorTransformationMulti
  Scenario Outline: Court Non-Manager Cannot Defer Beyond 12 Months

    Given I am on "Bureau" "ithc"

    Given a bureau owned pool is created with jurors
      | court |juror_number  	        | pool_number	    | att_date_weeks_in_future	| owner |
      | 415   |<juror_number> 	        | <pool_number>     | 5				            | 400	|

    Then a new pool is inserted for where record has transferred to the court new schema
      |part_no        | pool_no       | owner |
      |<juror_number> | <pool_number> | 415   |

    Given I log in as "MODTESTCOURT"
    When the user searches for juror record "<juror_number>" from the global search bar
    Then I record a happy path deferral paper summons response
    And I see the reply "type" on the response is "Deferral"

    Then I click the process reply button
    Then I set the radio button to "Deferral request"
    And I click continue on the process reply page

    Then I set the "first" choice to "200" Mondays in the future
    Then I set the "second" choice to "201" Mondays in the future
    Then I set the "third" choice to "202" Mondays in the future
    And I click continue on the process reply page

    And I see "Date cannot be more than 12 months after the original summons date" on the page

    Then I set the "first" choice to "6" Mondays in the future
    Then I set the "second" choice to "7" Mondays in the future
    Then I set the "third" choice to "8" Mondays in the future
    And I click continue on the process reply page

    Then I select "O - OTHER" from the "Reason for the deferral request" dropdown
    And I choose the "Choose a different date" radio button
    And I set the "Deferral" date to a Monday "49" weeks in the future
    And I press the "Continue" button

    Then I see "There are no active pools for this date" on the page
    And I press the "Put in deferral maintenance" button

    When the user searches for juror record "<juror_number>" from the global search bar
    And I see the juror status on the juror record screen is "Deferred"
    And I see the number of deferrals is "1"
    And I see under pool details the pool number is "In deferral maintenance"

    And I click the change link for the juror deferral
    And I set "Date to defer to" to "203 mondays time"
    And I press the "Save changes" button
    Then I see "Date cannot be more than 12 months after the original summons date" on the page

    Examples:
      | juror_number| pool_number |
      | 041500093	| 415300186	  |