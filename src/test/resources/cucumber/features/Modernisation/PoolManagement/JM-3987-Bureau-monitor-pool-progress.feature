Feature: JM-3987 Monitor Pools Progress

  @JurorTransformation
  Scenario: Test to show nil pools on the summoning progress screen

    Given I am on "Bureau" "ithc"

    And I log in as "MODTESTCOURT"
    And I navigate to the pool request screen
    And I select to create a nil pool
    And I click the change link for the attendance date
    And I select a new date "4" week in the future

    And I change the pool type to "Crown"
    And I click the request pool button
    And I make a note of the pool number
    And I click the create nil pool confirmation button

    Given I am on "Bureau" "ithc"
    And I log in as "MODTESTBUREAU"
    And I navigate to the pool request screen
    And I navigate to the pool summoning progress screen
    And I enter "415" as the court
    And the radio button "Crown court" is "selected"
    And I click search
    And I do not see "There are no matching results" on the page
    And I can see the newly created pool
    And I see "Nil pool" on the page
    And I clear down the data for all the pools I created for this test new schema

  @JurorTransformation
  Scenario Outline: Test to show the no pools requested message is displayed in weeks with no pools

    Given I am on "Bureau" "ithc"
    Given new pool requests are deleted new schema

    Given a bureau owned pool is created with jurors
      | court |juror_number  	    | pool_number	    | att_date_weeks_in_future	| owner |
      | 415   |<juror_number> 	    | <pool_number>     | 5				            | 400	|

    And I update pool type to "HGH" for pool number "<pool_number>"
    And I log in as "<user>"
    And I press the "Apps" button
    And I click on the "Pool management" link
    And I click on the "Search" link
    And I set "Pool number" to "<pool_number>"
    And I press the "Continue" button

    And I press the "Summon jurors" button
    And I set "Extra citizens to summon" to "9"
    And I press the "Summon more citizens" button

    And I navigate to the pool summoning progress screen
    And I see the summoning progress page banner
    And I enter "415" as the court
    And I select the "High" court type
    And I click search
    And I do not see "There are no matching results" on the page
    And I see "<pool_number>" on the page
    And I see "No pools requested" on the page

    Examples:
      |user			  | pool_number    | juror_number |
      |MODTESTBUREAU  | 415377221      | 041582661    |

  @JurorTransformation
  Scenario: Test for correct error message is returned when no pools are returned in the search

    Given I am on "Bureau" "ithc"
    Given new pool requests are deleted new schema

    And I log in as "MODTESTBUREAU"
    And I navigate to the pool request screen
    And I navigate to the pool summoning progress screen
    And I see the summoning progress page banner
    And I enter "123" as the court
    And I select the "Crown" court type
    And I click search
    And I do not see "Week 1" on the page
    And I see "There are no matching results" on the page
    And I see "selecting a court from the list" on the page
    And I see "checking the court type" on the page

  @JurorTransformation
  Scenario: Test for correct error message is returned when no search criteria are entered

    Given I am on "Bureau" "ithc"

    Given new pool requests are deleted new schema

    And I log in as "MODTESTBUREAU"
    And I navigate to the pool request screen
    And I navigate to the pool summoning progress screen
    And I see the summoning progress page banner
    And I click search
    And I do not see "Week 1" on the page
    And I see "There is a problem" on the page
    And I see "Enter the name or location code for a court" on the page

  @JurorTransformation
  Scenario Outline: Test for correct values on table

    Given I am on "Bureau" "ithc"
    Given new pool requests are deleted new schema
    And I clear summoned jurors from pool "<pool_number>"

    Given a bureau owned pool is created with jurors
      | court |juror_number  	    | pool_number	    | att_date_weeks_in_future	| owner |
      | 415   |<juror_number> 	    | <pool_number>     | 5				            | 400	|

    And I log in as "<user>"
    And I press the "Apps" button
    And I click on the "Pool management" link
    And I click on the "Search" link
    And I set "Pool number" to "<pool_number>"
    And I press the "Continue" button

    And I press the "Summon jurors" button
    And I set "Extra citizens to summon" to "9"
    And I press the "Summon more citizens" button

    And I navigate to the pool summoning progress screen
    And I see the summoning progress page banner
    And I set "Court name or location code" to "415"
    And I set the radio button to "Crown court"
    And I press the "Search" button
    And I see the pool I created "<pool_number>" in a row on the search results with the values
      | requested   | 20  |
      | summoned    | 10  |
      | confirmed   |  0  |
      | balance     |-20  |

    Examples:
      |user			  | pool_number    | juror_number |
      |MODTESTBUREAU  | 415367341      | 041582941    |

  @JurorTransformation
  Scenario Outline: Test to show all 8 weeks are populated when an active pool exist for that week

    Given I am on "Bureau" "ithc"
    Given new pool requests are deleted new schema

    Given a bureau owned pool is created with jurors
      | court |juror_number  	    | pool_number	    | att_date_weeks_in_future	    | owner     |
      | 415   |<juror_number1> 	    | <pool_number1>     | 2				            | 400	    |
      | 415   |<juror_number2> 	    | <pool_number2>     | 3				            | 400	    |
      | 415   |<juror_number3> 	    | <pool_number3>     | 4				            | 400	    |
      | 415   |<juror_number4> 	    | <pool_number4>     | 5				            | 400	    |
      | 415   |<juror_number5> 	    | <pool_number5>     | 6				            | 400	    |
      | 415   |<juror_number6> 	    | <pool_number6>     | 7				            | 400	    |
      | 415   |<juror_number7> 	    | <pool_number7>     | 8				            | 400	    |
      | 415   |<juror_number8> 	    | <pool_number8>     | 9				            | 400	    |

    And I log in as "<user>"
    And I navigate to the pool request screen
    And I have deleted all holidays new schema

    And I navigate to the pool summoning progress screen
    And I see the summoning progress page banner
    And I set "Court name or location code" to "415"
    And I set the radio button to "Crown court"
    And I press the "Search" button
    And I do not see "There are no matching results" on the page
    And I see "<pool_number1>" on the page
    And I see "<pool_number2>" on the page
    And I see "<pool_number3>" on the page
    And I see "<pool_number4>" on the page
    And I see "<pool_number5>" on the page
    And I see "<pool_number6>" on the page
    And I see "<pool_number7>" on the page
    And I see "<pool_number8>" on the page

    Examples:
      | user          | pool_number1 | pool_number2 | pool_number3 | pool_number4 | pool_number5 | pool_number6 | pool_number7 | pool_number8 | juror_number1 | juror_number2 | juror_number3 | juror_number4 | juror_number5 | juror_number6 | juror_number7 | juror_number8 |
      | MODTESTBUREAU | 415377224    | 415377225    | 415377226    | 415377227    | 415377228    | 415377229    | 415377231    | 415377232    | 041582861     | 041582862     | 041582863     | 041582864     | 041582865     | 041582866     | 041582867     | 041582868     |
