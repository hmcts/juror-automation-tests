Feature: JM-3546 and JM-3466 Bureau User Marks Digital Response as Awaiting Info

  @JurorTransformationWIP @NewSchemaConverted @JurorDigitalNotConverted
  Scenario Outline: Bureau User Marks Digital Response as Awaiting Info - happy path

    Given I am on "Public" "test"
    Given the juror numbers have not been processed new schema
      |part_no 	|pool_no 	|owner	|
      |<part_no>|<pool_no>	|400 	|

    Given "<juror_number>" has "NEXT_DATE" as "5 mondays time" new schema

	# Submit response in pool

    Given I have submitted a first party English ineligibilty response
      |part_no	    |pool_number|last_name		|postcode	|email 	|
      |<part_no>	|<pool_no>	|<last_name>	|<postcode>	|a@a.com|

    #log on
    Given I am on "Bureau" "test"
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
    Then I see the reply "status" on the response is "AWAITING JUROR INFO"
	Then I see the reply "type" on the response is "NEEDS REVIEW"
    Then I see Reply Method is "Digital"

    Examples:
      |part_no		|pool_no 	|last_name 			|postcode 	|
      |645200186	|452170401 	|LNAMEONEEIGHTSIX	|SY2 6LU	|

  @JurorTransformationWIP @NewSchemaConverted @JurorDigitalNotConverted
  Scenario Outline: Bureau User Marks Digital Response as Awaiting Info - navigation

    Given I am on "Public" "test"

    Given the juror numbers have not been processed new schema
      |part_no 	|pool_no 	|owner	|
      |<part_no>|<pool_no>	|400 	|

    Given "<juror_number>" has "NEXT_DATE" as "5 mondays time" new schema

	# Submit response in pool
    Given I have submitted a first party English ineligibilty response
      |part_no	    |pool_number|last_name		|postcode	|email 	|
      |<part_no>	|<pool_no>	|<last_name>	|<postcode>	|a@a.com|

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
    Then I see the reply "status" on the response is "TO DO"

    #go to awaiting inforamation
    Then I press the "More actions" button
    Then I click on the "Mark as awaiting information" link

    When I set the radio button to "Juror"
    Then the radio button "Juror" is "selected"
    Then I press the "Confirm" button

    #check response is updated correctly
    And I am on the modernisation version of View Summons Reply
    Then I see the reply "status" on the response is "AWAITING JUROR INFO"
    Then I see the reply "type" on the response is "NEEDS REVIEW"
    Then I see Reply Method is "Digital"

    Examples:
      |part_no		|pool_no 	|last_name 			|postcode 	|
      |645200289	|452170401 	|LNAMETWOEIGHTNINE	|SY2 6LU	|

  @JurorTransformationWIP @NewSchemaConverted @JurorDigitalNotConverted
  Scenario Outline: Bureau User Marks Digital Response as Awaiting Info - errors and warnings

    Given I am on "Public" "test"

    Given the juror numbers have not been processed new schema
      |part_no 	|pool_no 	|owner	|
      |<part_no>|<pool_no>	|400 	|

    Given "<juror_number>" has "NEXT_DATE" as "5 mondays time" new schema

	# Submit response in pool
    Given I have submitted a first party English ineligibilty response
      |part_no	    |pool_number|last_name		|postcode	|email 	|
      |<part_no>	|<pool_no>	|<last_name>	|<postcode>	|a@a.com|

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
    Then I see the reply "status" on the response is "AWAITING JUROR INFO"
    Then I see the reply "type" on the response is "NEEDS REVIEW"
    Then I see Reply Method is "Digital"

    Examples:
      |part_no		|pool_no 	|last_name 			|postcode 	|
      |645200289	|452170401 	|LNAMETWOEIGHTNINE	|SY2 6LU	|
