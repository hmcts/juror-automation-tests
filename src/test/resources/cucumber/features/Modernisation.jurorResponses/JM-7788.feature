Feature: JM-7788

  @JurorTransformationMulti @NewSchemaConverted
  Scenario Outline: Search for juror name globally

    Given I am on "Bureau" "ithc"

    Given a bureau owned pool is created with jurors
      | court |juror_number  	    | pool_number	    | att_date_weeks_in_future	| owner |
      | 415   |<juror_number> 	    | <pool_number>     | 5				            | 400	|

    #log on and search for juror
    And I log in as "<user>"

    And I update juror "<juror_number>" to have a first name of "Testing" and a last name of "LP Lastnametest"
    And I select the global search
    And I click on the "Advanced juror search" link
    
    And I see "Search for a juror record" on the page
    And I set "Juror name" to "Testing Lastnametest"
    And I press the "Search" button
    And I am on the Juror Record for juror "<juror_number>"

    And I select the global search
    And I click on the "Advanced juror search" link

    And I see "Search for a juror record" on the page
    And I set "Juror name" to "Testing LP Lastnametest"
    And I press the "Search" button
    And I am on the Juror Record for juror "<juror_number>"

    And I update juror "<juror_number>" to have a first name of "Middlename" and a last name of "H Tester"

    And I select the global search
    And I click on the "Advanced juror search" link

    And I see "Search for a juror record" on the page
    And I set "Juror name" to "Middlename Tester"
    And I press the "Search" button
    And I am on the Juror Record for juror "<juror_number>"


    Examples:
      |user			|juror_number  |  pool_number    |
      |MODTESTBUREAU |041525583     |  415327233      |
