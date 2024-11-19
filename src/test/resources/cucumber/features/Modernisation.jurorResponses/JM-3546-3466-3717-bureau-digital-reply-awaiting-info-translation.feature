Feature: JM-3546 and JM-3466 Bureau User Marks Digital Response as Awaiting Info

  @JurorTransformation @NewSchemaConverted
  Scenario Outline: Bureau User Marks Digital Response as Awaiting Info - happy path

    Given I am on "Public" "ithc"

    Given a bureau owned pool is created with jurors
      | court | juror_number  	    | pool_number	    | att_date_weeks_in_future	| owner |
      | 415   | <juror_number> 	    | <pool_number>     | 5				            | 400	|

	# Submit response in pool
    Given I have submitted a first party English ineligibilty response
      |part_no	      |pool_number    |last_name	|postcode	|email 	|
      |<juror_number> |<pool_number>  |<last_name>	|<postcode>	|a@a.com|

    #log on
    Given I am on "Bureau" "ithc"
    And I log in as "MODTESTBUREAU"

    #search for response
    And I click on the "Search" link
    And I set "Juror number" to "<juror_number>"
    And I press the "Search" button
    When I click on "<juror_number>" in the same row as "<juror_number>"

	#check options
    Then I press the "More actions" button

    Then I click on the "Mark as awaiting information" link

    When I set the radio button to "Court"
    Then the radio button "Juror" is "unselected"
    Then the radio button "Court" is "selected"
    Then the radio button "Translation unit" is "unselected"

    When I set the radio button to "Translation unit"
    Then the radio button "Juror" is "unselected"
    Then the radio button "Court" is "unselected"
    Then the radio button "Translation unit" is "selected"

    When I set the radio button to "Juror"
    Then the radio button "Juror" is "selected"
    Then the radio button "Court" is "unselected"
    Then the radio button "Translation unit" is "unselected"

    Then I press the "Confirm" button

    #check response is updated correctly
    And I am on the modernisation version of View Summons Reply
    Then I see the reply "status" on the response is "Awaiting juror info"
	Then I see the reply "type" on the response is "Needs review"
    Then I see Reply Method is "Digital"

    Examples:
      | juror_number| pool_number 	| last_name 		| postcode 	|
      | 041500152	| 415300251 	|lname	            | CH2 2AA	|

  @JurorTransformationMulti @NewSchemaConverted
  Scenario Outline: Bureau User Marks Digital Response as Awaiting Info - navigation

    Given I am on "Public" "ithc"

    Given a bureau owned pool is created with jurors
      | court | juror_number  	    | pool_number	    | att_date_weeks_in_future	| owner |
      | 415   | <juror_number> 	    | <pool_number>     | 5				            | 400	|

	# Submit response in pool
    Given I have submitted a first party English ineligibilty response
      | part_no	        | pool_number   | last_name		| postcode	| email 	|
      | <juror_number>	| <pool_number>	| <last_name>	| <postcode>| a@a.com   |

    #log on
    Given I am on "Bureau" "test"
    And I log in as "MODTESTBUREAU"

    #search for response
    And I click on the "Search" link
    And I set "Juror number" to "<juror_number>"
    And I press the "Search" button
    When I click on "<juror_number>" in the same row as "<juror_number>"

	#go to awaiting inforamation
    Then I press the "More actions" button
    Then I click on the "Mark as awaiting information" link

    When I set the radio button to "Juror"
    Then the radio button "Juror" is "selected"

    #cancel
    When I click on the "Cancel" link
    And I am on the modernisation version of View Summons Reply
    Then I see the reply "status" on the response is "To do"

    #go to awaiting inforamation
    Then I press the "More actions" button
    Then I click on the "Mark as awaiting information" link

    When I set the radio button to "Juror"
    Then the radio button "Juror" is "selected"
    Then I press the "Confirm" button

    #check response is updated correctly
    And I am on the modernisation version of View Summons Reply
    Then I see the reply "status" on the response is "Awaiting juror info"
    Then I see the reply "type" on the response is "Needs review"
    Then I see Reply Method is "Digital"

    Examples:
      | juror_number| pool_number 	| last_name 		| postcode 	|
      | 041500153	| 415300252 	| lname	            | CH2 2AA	|

  @JurorTransformationMulti @NewSchemaConverted
  Scenario Outline: Bureau User Marks Digital Response as Awaiting Info - errors and warnings

    Given I am on "Public" "test"

    Given a bureau owned pool is created with jurors
      | court | juror_number  	    | pool_number	    | att_date_weeks_in_future	| owner |
      | 415   | <juror_number> 	    | <pool_number>     | 5				            | 400	|

	# Submit response in pool
    Given I have submitted a first party English ineligibilty response
      |part_no	        |pool_number    |last_name		|postcode	|email 	|
      |<juror_number>	|<pool_number>	|<last_name>	|<postcode>	|a@a.com|

    #log on
    Given I am on "Bureau" "test"
    And I log in as "MODTESTBUREAU"

    #search for response
    And I click on the "Search" link
    And I set "Juror number" to "<juror_number>"
    And I press the "Search" button
    When I click on "<juror_number>" in the same row as "<juror_number>"

	#go to awaiting inforamation
    Then I press the "More actions" button
    Then I click on the "Mark as awaiting information" link

    #errors when no option selected
    When I press the "Confirm" button
    Then I see "Select whether you’re waiting for information from either the juror, court or translation unit" on the page

    When I set the radio button to "Juror"
    Then the radio button "Juror" is "selected"
    Then I press the "Confirm" button

    #check response is updated correctly
    And I am on the modernisation version of View Summons Reply
    Then I see the reply "status" on the response is "Awaiting juror info"
    Then I see the reply "type" on the response is "Needs review"
    Then I see Reply Method is "Digital"

    Examples:
      | juror_number| pool_number 	| last_name 		| postcode 	|
      | 041500154	| 415300253 	| lname             | CH2 2AA	|