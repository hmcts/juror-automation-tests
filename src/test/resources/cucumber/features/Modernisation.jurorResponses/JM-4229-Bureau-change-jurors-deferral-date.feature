Feature: Bureau change jurors deferral date

  @JurorTransformationWIP @JurorDigitalNotConverted
  Scenario Outline: Change jurors deferral date

    Given I am on "Public" "test"

    Given a bureau owned pool is created with jurors
      | court | juror_number  	    | pool_number	    | att_date_weeks_in_future	| owner |
      | 415   | <juror_number> 	    | <pool_number>     | 5				            | 400	|

    And I record a digital response for a juror with a deferral
      |jurorNumber   | <juror_number>  |
      |jurorLname    | <last_name>|
      |jurorPostcode | <postcode> |

    Given I am on "Bureau" "test"

    Given I log in as "MODTESTBUREAU"

    Then I search for juror "<juror_number>"
    And I click the summons reply tab
    And I click on the "View summons reply" link
    And I see the reply "type" on the response is "DEFERRAL"

    Then I click the process reply button
    Then I set the radio button to "Deferral request"
    And I click continue on the process reply page

    Then I select "O - OTHER" from the "Reason for the deferral request" dropdown
    Then I select to Choose a different date
    Then I set the "new" choice to "51" Mondays in the future
    And I press the "Continue" button

    Then I see "There are no active pools for this date" on the page
    And I press the "Put in deferral maintenance" button

    And I do not see "Sorry, there is a technical problem" on the page
    And I see "Deferral granted" on the page

    Then I search for juror "<juror_number>"
    And I see the juror status on the juror record screen is "Deferred"
    And I see the number of deferrals is "1"
    And I see under pool details the pool number is "In deferral maintenance"
    And I click the change link for the juror deferral
    And I set the "only" choice to "41" Mondays in the future
    And I press the "Save changes" button

    Then I see "There are no active pools for this date" on the page
    And I press the "Put in deferral maintenance" button
    And I see "Juror record updated: Responded" on the page
    And I see Deferred to is "41" Mondays in the future

    Examples:
      | juror_number| pool_number | last_name       | postcode	|
      | 041566659	| 415300149   | lname	        | CH2 2AA	|