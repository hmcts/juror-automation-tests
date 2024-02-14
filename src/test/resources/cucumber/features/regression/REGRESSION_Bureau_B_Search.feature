Feature: Bureau B Search

@Features
Scenario Outline: Lift from QC Script for Bureau B Search

	#moved to Features 02-01-24 return to Regression

	Given I am on "Public" "test"
	And pool no "<pool_no>" is reset to pending allocation
	And I have cleared down the juror digital database
	Given the juror numbers have not been processed
		| part_no 		| pool_no 	| owner |
		| <part_no> 	|<pool_no>	| 400 	|
		| <part_no_two> |<pool_no>	| 400 	|
		
	And auto straight through processing has been enabled
	
	Given juror has data set
		|part_no		|LNAME			|ZIP		|RET_DATE 	|NEXT_DATE	|
		|<part_no>		|<last_name>	|<postcode>	|<date>		|<date>		|
		|<part_no_two>	|<last_name>	|<postcode>	|<date>		|<date>		|
		
	Given I have submitted a first party English ineligibilty response
		|part_no			|pool_number	|last_name			|postcode		|email 		|details	|
		|<part_no>			|<pool_no>		|<last_name>		|<postcode>		|<email>	|<details>	|
		|<part_no_two>		|<pool_no>		|<last_name>		|<postcode>		|<email>	|<details>	|

	Given I am on "Bureau" "test"
	When I log in as "SYSTEM"
	And I click on the "Search" link
	And I set "Juror's pool number" to "<pool_no>"
	And I press the "Search" button
	
	When I click on "<part_no_two>" in the same row as "<part_no_two>"
	
	And I press the "Process reply" button
	And I click on the "Excusal" link
	Then I select "D - DECEASED" from the "Reason for the excusal request" dropdown
	And I set the radio button to "Accept excusal request"
	And I press the "Confirm" button
		
	Then I see "Search" on the page
	And I click on the "Search" link
	And I set "Juror's pool number" to "<pool_no>"
	And I set "Juror number" to ""
	
	And I select "All officers" from the "Officer assigned" dropdown
	And I press the "Search" button
	Then on the page I see
		| text 			|
		| <part_no>		|
	
	When I click on the "Select all" link
	Then the checkbox in the same row as "<part_no>" is "checked"
	
	When I press the "Send to..." button
	
	When I click on the "Cancel" link
	Then "Juror number" is ""
	
	When I click on the "Unselect all" link
	Then the checkbox in the same row as "<part_no>" is "unchecked"

	And I press the "Send to..." button
	Then I see "There is a problem" on the page
	And I see "Select the replies you want to send" on the page
	
	When I click on "<part_no>" in the same row as "<part_no>"
	Then on the page I see
		| text 			|
		|Juror details	|
		|Court name		|
		|Pool number	|
	
	When I click on the "Back" link
	Then I see "esults for" on the page
	And "Juror's pool number" is "<pool_no>"
	
	When I click on the "Advanced search" link
	And I check the "closed" checkbox
	And I press the "Search" button
	Then I see "and “Completed”" on the page
	
	When I click on "<part_no_two>" in the same row as "<part_no_two>"
	Then on the page I see
		|text |
		|Juror details|
		|Court name|
		|Pool number|
		|COMPLETED|
		
	When I click on the "Back" link
	And I click on the "Clear search" link
	Then "Juror's pool number" is ""

	And I set "Juror number" to "<part_no_two>"
	And I set "Juror's last name" to "<last_name>"
	And I set "Juror's pool number" to ""
	
	And I press the "Search" button
	Then I see "1 results for" on the page
	And I see "COMPLETED" in the same row as "<part_no_two>"
	
	When I click on "<part_no_two>" in the same row as "<part_no_two>"
	Then I see "Reply status" on the page
	And I see "COMPLETED" on the page

Examples:
	|part_no		|part_no_two	| pool_no 	| last_name 		| postcode 	|email				|date			|details	|
	|645700369		| 645700364		| 457170401 | LNAMEONEFIVEFOUR 	| CH1 2AN	|ab@automation.com	|4 mondays time	|12345abcde	|
	
@Regression @JDB-3691 
Scenario Outline: Attempt to input alpha characters into Juror Number and Pool Number fields on Seach screen on Bureau
	
	Given I am on "Bureau" "juror-test02"
	When I log in
	And I click on the "Search" link
	And I set "Juror number" to "abcdefghijklmnopqrstuvwxyz"
	And I set "Juror's pool number" to "abcdefghijklmnopqrstuvwxyz"
	And "Juror number" is ""
	And "Juror's pool number" is ""
	
	#This needs to also be done on Firefox and IE
	
Examples:
	|part_no		|pool_no 	|last_name 	|postcode 	|email				|date			|
	|641500117		|415170401 	|DOE 		|SW1H 9AJ	|email@outlook.com	|5 mondays time	|
	