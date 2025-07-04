Feature: JM-3895 mark juror as deferred digital

  @JurorTransformationMulti
  Scenario Outline: Mark juror as deferred - Send to deferral maintenance Happy path digital

    Given I am on "Public" "ithc"

    When a bureau owned pool is created with jurors
      | court | juror_number    | pool_number      | att_date_weeks_in_future | owner |
      | 415   | <juror_number>  | <pool_number>    | 5                        | 400   |

    And I record a digital response for a juror with a deferral
      | jurorNumber   | <juror_number>    |
      | jurorLname    | lname             |
      | jurorPostcode | CH2 2AA           |

    Given I am on "Bureau" "ithc"
    Given I log in as "MODTESTBUREAU"

    When the user searches for juror record "<juror_number>" from the global search bar
    And I click on the "Summons reply" link
    And I click on the "View summons reply" link
    And I see the reply "type" on the response is "Deferral"

    Then I click the process reply button
    Then I set the radio button to "Deferral request"
    And I click continue on the process reply page

    Then I select "O - OTHER" from the "Reason for the deferral request" dropdown
    Then I select to Choose a different date
    Then I set the "alternate" choice to "51" Mondays in the future
    And I press the "Continue" button

    Then I see "There are no active pools for this date" on the page
    And I press the "Put in deferral maintenance" button

    And I do not see "Sorry, there is a technical problem" on the page
    And I see "Deferral granted" on the page

    Then the user searches for juror record "<juror_number>" from the global search bar
    And I click the summons reply tab
    And I click on the "View summons reply" link
    And I see the reply "type" on the response is "Deferral"
    And I see the reply "status" on the response is "Completed"

    Examples:
      | juror_number   | pool_number   |
      | 041500131      | 415300231     |

  @JurorTransformationMulti
  Scenario Outline: Mark juror as deferred - Add to pool Happy path digital

    Given I am on "Public" "ithc"

    When a bureau owned pool is created with jurors
      | court | juror_number      | pool_number     | att_date_weeks_in_future | owner |
      | 415   | <juror_number>    | <pool_number>   | 5                        | 400  |

    And I record a digital response for a juror with a deferral
      | jurorNumber   | <juror_number>    |
      | jurorLname    | lname             |
      | jurorPostcode | CH2 2AA           |

    Given I am on "Bureau" "ithc"
    Given I log in as "MODTESTBUREAU"

    Given I navigate to the pool request screen
    Given I create an active "civil" court pool request for court "415", "14" Mondays in the future

    When the user searches for juror record "<juror_number>" from the global search bar
    And I see "<juror_number>" on the page
    And I click the summons reply tab
    And I click on the "View summons reply" link
    And I see the reply "type" on the response is "Deferral"

    Then I click the process reply button
    Then I set the radio button to "Deferral request"
    And I click continue on the process reply page

    Then I select "O - OTHER" from the "Reason for the deferral request" dropdown
    Then I select to Choose a different date
    Then I set the "alternate" choice to "14" Mondays in the future
    And I press the "Continue" button

    Then I see "Select a pool for this date" on the page
    And I select the pool I created for the deferral
    And I press the "Continue" button

    And I do not see "Sorry, there is a technical problem" on the page
    And I verify summons reply banner processed by user "MODTESTBUREAU" and status "Responded"

    Then the user searches for juror record "<juror_number>" from the global search bar
    And I click the summons reply tab
    And I click on the "View summons reply" link
    And I see the reply "type" on the response is "Deferral"
    And I see the reply "status" on the response is "Completed"

    Then I clear down the data for all the pools I created for this test new schema
    Then the poolNumbers lists is empty

    Examples:
      | juror_number  | pool_number |
      | 041500143     | 415300243   |