Feature: Bureau B Search for Team Member

@RegressionSingle @JDB-3484 
Scenario Outline: Lift from QC Script for Bureau B Search
	
	Given I am on "Public" "test"
	
	Given auto straight through processing has been disabled
	
	Given the juror numbers have not been processed
		|part_no 		|pool_no 	|owner 	|
		|<part_no> 		|<pool_no>	|400 	|
		|<part_no_two> 	|<pool_no>	|400 	|
	
	Given juror has data set
		|part_no		|LNAME		|ZIP		|RET_DATE 	|NEXT_DATE	|
		|<part_no>		|<last_name>|<postcode>	|<date>		|<date>		|
		|<part_no_two>	|<last_name>|<postcode>	|<date>		|<date>		|
		
	Given I have submitted a first party English straight through response
		|part_no		|pool_number	|last_name		|postcode	|email 	|
		|<part_no>		|<pool_no>		|<last_name>	|<postcode>	|<email>|
		|<part_no_two>	|<pool_no>		|<last_name>	|<postcode>	|<email>|
	
	Given I am on "Bureau" "test"

	When I log in as "CPASS"
	And I click on the "Search" link
	And I set "Juror's pool number" to "<pool_no>"
	And I press the "Search" button
	Then I see "<part_no_two>" on the page
	And I click on "<part_no_two>" in the same row as "<part_no_two>"
	
	And I press the "Process reply" button
	And I click on the "Excusal" link
	Then I select "D - DECEASED" from the "Reason for the excusal request" dropdown
	And I set the radio button to "Accept excusal request"
	And I press the "Confirm" button
		
	And I click on the "Search" link
	And I set "Juror's pool number" to "<pool_no>"
	
	And I press the "Search" button
	Then on the page I see
		|text 		|
		|<part_no>	|
	
	When I click on "<juror_number>" in the same row as "<juror_number>"
	Then on the page I see
		|text 			|
		|Juror details	|
		|Court name		|
		|Pool number	|
	
	When I click on the "Back" link
	Then I see "esults for" on the page
	And "Juror's pool number" is "<pool_no>"
	
	When I click on "<part_no_two>" in the same row as "<part_no_two>"
	Then on the page I see
		|text 			|
		|Juror details	|
		|Court name		|
		|Pool number	|
		|COMPLETED		|
	
	When I click on the "Back" link
	And I click on the "Clear search" link
	Then "Juror's pool number" is ""

	And I set "Juror number" to "<part_no_two>"
	And I set "Juror's last name" to "<last_name>"
	And I set "Juror's pool number" to ""
	
	And I press the "Search" button
	Then I see "1 results for" on the page
	And I see "COMPLETE" in the same row as "<part_no_two>"
	
	When I click on "<part_no_two>" in the same row as "<part_no_two>"
	Then I see "Reply status" on the page
	And I see "COMPLETED" on the page

	Given auto straight through processing has been enabled
	
Examples:
	|part_no		|part_no_two	|pool_no 	|last_name 			|postcode 	|email				|date			|
	|641500287		|641500288		|415170601 	|LNAMEONEFIVEFOUR 	|CH1 2AN	|ab@automation.com	|4 mondays time	|
	