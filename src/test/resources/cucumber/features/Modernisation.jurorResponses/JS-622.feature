Feature: JS-622 - Shuffle address

  @JurorTransformation
  Scenario Outline: Shuffle address data when address4 is null

    Given I am on "Bureau" "ithc"

    Given a bureau owned pool is created with jurors
      | court |juror_number  	| pool_number	| att_date_weeks_in_future	| owner |
      | 415   |<juror_number> 	| <pool_number> | 5				            | 400	|

    And I clear down my jurors for shuffle address test
      | court | juror_number  	        | pool_number	    |
      | 415   | <juror_number1> 	    | <pool_number>     |
      | 415   | <juror_number2> 	    | <pool_number>     |
      | 415   | <juror_number3> 	    | <pool_number>     |
      | 415   | <juror_number4> 	    | <pool_number>     |
      | 415   | <juror_number5> 	    | <pool_number>     |

    And I log in as "<user>"

    And new voter records are inserted into the voters table for address shuffle
    And I check the catchment area table to ensure my loc code is present

    And I press the "Apps" button
    And I click on the "Pool management" link
    And I click on the "Search" link
    And I set "Pool number" to "<pool_number>"
    And I press the "Continue" button
    And I see "<pool_number>" on the page

    And I press the "Summon jurors" button
    And I set "Extra citizens to summon" to "5"
    And I press the "Summon more citizens" button

    And I see "<juror_number1>" on the page
    And I see "<juror_number2>" on the page
    And I see "<juror_number3>" on the page
    And I see "<juror_number4>" on the page
    And I see "<juror_number5>" on the page

    And I verify the juror address shuffles are correct

    Examples:
     | juror_number | juror_number1 | juror_number2 | juror_number3 | juror_number4 | juror_number5 | pool_number | user          |
     | 041578833    | 820211676     | 820211826     | 820211896     | 820211816     | 820211886     | 452388166   | MODTESTBUREAU |
