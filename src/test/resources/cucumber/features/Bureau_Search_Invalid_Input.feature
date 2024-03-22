Feature: Bureau_Search_Invalid_Input

@Regression @NewSchemaConverted
Scenario: Bureau Search with Invalid Input
	
	#log in and navigate to search
	
	Given I am on "Bureau" "test"
	When I log in as "MODTESTBUREAU"
	And I click on the "Search" link
	
	#try to enter ... in juror number
	And I set "Juror number" to "..."
	Then "Juror number" is ""
	
	#try to enter !!! in juror number
	And I set "Juror number" to "!!!"
	Then "Juror number" is ""
	
	#try to enter aaa in juror number
	And I set "Juror number" to "aaa"
	Then "Juror number" is ""
	
	#enter 111 in juror number
	And I set "Juror number" to "111"
	Then "Juror number" is "111"

	And I press the "Search" button
	Then I see "0 results for “111”" on the page