Feature: JM-4326 - Defer a juror and then complete their service at a later date

  @JurorTransformationMulti
  Scenario Outline: Mark juror as deferred - Add to pool Happy path paper - Bureau Officer

    Given I am on "Bureau" "demo"

    Given I log in as "<user>"

    Given a bureau owned pool is created with jurors
      | court |juror_number       | pool_number      | att_date_weeks_in_future | owner |
      | 415   |<juror_number>     | <pool_number>     | 5                      | 400  |

    And pool "<pool_number>" has attendance date as "5 mondays time" new schema

    #create a pool to defer to
    Given I navigate to the pool request screen
    Given I create an active "Crown" court pool request for court "415", "14" Mondays in the future

    #search for juror and record paper response
    When the user searches for juror record "<juror_number>" from the global search bar
    Then I record a happy path deferral paper summons response
    And I see the reply "type" on the response is "Deferral"

    #process response as deferral
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

    #check summons response
    When the user searches for juror record "<juror_number>" from the global search bar
    And I press the "Update juror record" button
    And I set the radio button to "Deferral - grant or refuse"
    And I press the "Continue" button
    Then I select "O - OTHER" from the "Reason for the deferral request" dropdown
    And I set the radio button to "Grant deferral"
    And I set the radio button to "Other"
    And I set the "Deferral" date to a Monday "45" weeks in the future
    And I press the "Continue" button
    And I see "Confirm mutliple deferral" on the page
    And I press the "Confirm deferral" button

    When the user searches for juror record "<juror_number>" from the global search bar
    And I click on the "Summons reply" link
    And I see "Deferral granted (other)" in the same row as "Processing outcome"
    And I click on the "View summons reply" link
    And I see the reply status has updated to "Completed"
    And I see the reply type has been updated to "Deferral"

    Examples:
      |user			|juror_number  |pool_number  |
      |MODTESTBUREAU|041530012     |415300301    |

  @JurorTransformationMulti
  Scenario Outline: Mark juror as deferred - Add to pool Happy path paper - Jury Officer
    Given I am on "Bureau" "test"

    Given a bureau owned pool is created with jurors
      | court |juror_number  	    | pool_number	    | att_date_weeks_in_future	| owner |
      | 415   |<juror_number> 	    | <pool_number>     | 5				            | 400	|

    Then a new pool is inserted for where record has transferred to the court new schema
      |part_no              | pool_no           | owner |
      |<juror_number>       | <pool_number>     | 415   |

    And pool "<pool_number>" has attendance date as "5 mondays time" new schema

    #log on and search for juror
    And I log in as "<user>"
    When the user searches for juror record "<juror_number>" from the global search bar

    #record paper summons type - deferral
    Then I record a happy path deferral paper summons response
    And I see the reply "type" on the response is "Deferral"

    #process as deferral
    Then I click the process reply button
    Then I set the radio button to "Deferral request"
    And I click continue on the process reply page

    Then I set the "first" choice to "18" Mondays in the future
    Then I set the "second" choice to "19" Mondays in the future
    Then I set the "third" choice to "20" Mondays in the future
    And I click continue on the process reply page

    Then I select "O - OTHER" from the "Reason for the deferral request" dropdown
    Then I set the radio button to "Choose a different date"
    Then I set the "alternate" choice to "14" Mondays in the future
    And I press the "Continue" button

    #assign to pool
    Then I see "Select a pool for this date" on the page
    And I select one of the active pools available
    And I press the "Continue" button


    When the user searches for juror record "<juror_number>" from the global search bar
    And I press the "Update juror record" button
    And I set the radio button to "Deferral - grant or refuse"
    And I press the "Continue" button
    Then I select "O - OTHER" from the "Reason for the deferral request" dropdown
    And I set the radio button to "Grant deferral"
    And I set the radio button to "Other"
    And I set the "Deferral" date to a Monday "45" weeks in the future
    And I press the "Continue" button
    And I see "Confirm mutliple deferral" on the page
    And I press the "Confirm deferral" button

    When the user searches for juror record "<juror_number>" from the global search bar
    And I click on the "Summons reply" link
    And I see "Deferral granted (other)" in the same row as "Processing outcome"
    And I click on the "View summons reply" link
    And I see the reply status has updated to "Completed"
    And I see the reply type has been updated to "Deferral"


    Examples:
      |user			|juror_number  |pool_number  |
      |MODTESTCOURT |041537780     |415366829    |


  @JurorTransformationMulti
  Scenario Outline: Mark juror as deferred - Add to pool - Digital Response Bureau Officer

    Given I am on "Public" "ithc"

    Given a bureau owned pool is created with jurors
      | court |juror_number  	    | pool_number	    | att_date_weeks_in_future	| owner |
      | 415   |<juror_number> 	    | <pool_number>     | 5				            | 400	|

    And pool "<pool_number>" has attendance date as "5 mondays time" new schema

    #record digital response
    And I record a digital response for a juror with a deferral
      | jurorNumber   | <juror_number>      |
      | jurorLname    | lname            |
      | jurorPostcode | CH2 2AA        |

    #log on and create a pool to defer to
    Given I am on "Bureau" "ithc"
    Given I log in as "<user>"

    Given I navigate to the pool request screen
    And I see "Pool requests" on the page
    Given I create an active "civil" court pool request for court "415", "14" Mondays in the future

    #search for juror and process reply
    When the user searches for juror record "<juror_number>" from the global search bar
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

    #search for juror and view reponse
    When the user searches for juror record "<juror_number>" from the global search bar
    And I click on the "Summons reply" link
    And I click on the "View summons reply" link
    And I see the reply status has updated to "Completed"

    Examples:
      | user		  | juror_number  | pool_number |
      | MODTESTBUREAU | 041500138     | 415300238   |

  @JurorTransformationMulti
  Scenario Outline: Mark juror as deferred - Add to pool - Digital Response Jury Officer

    Given I am on "Public" "ithc"

    Given a bureau owned pool is created with jurors
      | court |juror_number  	    | pool_number	    | att_date_weeks_in_future	| owner |
      | 415   |<juror_number> 	    | <pool_number>     | 5				            | 400	|

    And pool "<pool_number>" has attendance date as "5 mondays time" new schema

    #record digital response
    And I record a digital response for a juror with a deferral
      | jurorNumber   | <juror_number> |
      | jurorLname    | lname          |
      | jurorPostcode | CH2 2AA        |

    #transfer pool to court
    Then a new pool is inserted for where record has transferred to the court new schema
      |part_no              | pool_no           | owner |
      |<juror_number>       | <pool_number>     | 415   |

    Given I am on "Bureau" "ithc"
    And I log in as "<user>"

    #search for juror and view response
    When the user searches for juror record "<juror_number>" from the global search bar
    And I click the summons reply tab

    #failing due to JM-4750
    And I click on the "View summons reply" link
    And I see the reply "type" on the response is "Deferral"

    #process as deferral
    Then I click the process reply button
    Then I set the radio button to "Deferral request"
    And I click continue on the process reply page

    Then I select "O - OTHER" from the "Reason for the deferral request" dropdown
    Then I select to Choose a different date
    Then I set the "alternate" choice to "14" Mondays in the future
    And I press the "Continue" button

    #assign to pool
    Then I see "Select a pool for this date" on the page
    And I select one of the active pools available
    And I press the "Continue" button

    When the user searches for juror record "<juror_number>" from the global search bar
    And I press the "Update juror record" button
    And I set the radio button to "Deferral - grant or refuse"
    And I press the "Continue" button
    Then I select "O - OTHER" from the "Reason for the deferral request" dropdown
    And I set the radio button to "Grant deferral"
    And I set the radio button to "Other"
    And I set the "Deferral" date to a Monday "45" weeks in the future
    And I press the "Continue" button
    And I see "Confirm mutliple deferral" on the page
    And I press the "Confirm deferral" button

    #check summons response
    When the user searches for juror record "<juror_number>" from the global search bar
    And I click on the "Summons reply" link
    And I see "Deferral granted (other)" in the same row as "Processing outcome"
    And I click on the "View summons reply" link
    And I see the reply status has updated to "Completed"
    And I see the reply type has been updated to "Deferral"

    Examples:
      |user			|juror_number  |pool_number  |
      |MODTESTCOURT |041537779     |415366829    |