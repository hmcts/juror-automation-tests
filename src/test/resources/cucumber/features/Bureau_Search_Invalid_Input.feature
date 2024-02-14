Feature: Bureau_Search_Invalid_Input

@Regression @JDB-3458 
Scenario Outline: Bureau Search with Invalid Input
	
	#log in and navigate to search
	
	Given I am on "Bureau" "juror-test02"
	When I log in
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

	Examples:
	|part_no		|pool_no	|last_name				|postcode	| email | 
	|644200435		|442170401	|LNAMEFOURTHREEFIVE		|NN1 3HQ	|e@eeee.com|