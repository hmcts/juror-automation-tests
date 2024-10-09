Feature: JM-3900

  @JurorTransformationMulti
  Scenario Outline: Decline Deferral Request for Digital Response as Bureau user - Juror Record View

    Given I am on "Public" "ithc"

    When a bureau owned pool is created with jurors
      | court |juror_number  	| pool_number	  | att_date_weeks_in_future  | owner |
      | 415   | <juror_number>  | <pool_number>   | 5                         | 400   |

    And I record a digital response for a juror with a deferral
      | jurorNumber   | <juror_number>  |
      | jurorLname    | <last_name>     |
      | jurorPostcode | <postcode>      |

    Given I am on "Bureau" "ithc"
    And I log in as "MODTESTBUREAU"
    When the user searches for juror record "<juror_number>" from the global search bar
    And I click on the "Summons reply" link
    And I click on the "View summons reply" link
    And I click the process reply button
    Then I select deferral request
    And I click continue on the juror summons reply page

    Then I select "O - OTHER" from the "Reason for the deferral request" dropdown
    Then I select to Choose a different date
    Then I set the "alternate" choice to "41" Mondays in the future
    And I press the "Continue" button

    Then I see "There are no active pools for this date" on the page
    And I press the "Put in deferral maintenance" button

    When the user searches for juror record "<juror_number>" from the global search bar
    And I see the juror status on the juror record screen has updated to "Deferred"

    And I click the update juror record button
    And I set the radio button to "Mark as responded"
    And I press the "Continue" button
    And I see "Mark as responded" on the page
    And I check the "Mark juror as 'responded'" checkbox
    And I press the "Confirm" button

    And I see the juror status on the juror record screen has updated to "Responded"

    And I click the update juror record button
    And I set the radio button to "Deferral - grant or refuse"
    Then I click continue on the update juror record screen
    And I select "O - OTHER" from the "Reason for the deferral request" dropdown
    And I set the radio button to "Refuse deferral"
    And I press the "Continue" button
    And I see "Deferral refused (other)" on the page
    And I see the number of deferrals is "1"
    And the warning icon is displayed next to the juror status

    Examples:
      | juror_number   | pool_number   | last_name  | postcode |
      | 041520027      | 415300704     | lname      | CH2 2AA  |