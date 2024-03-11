Feature: Bureau B Search

@Features @NewSchemaConverted
Scenario Outline: Lift from QC Script for Bureau B Search

	#moved to Features 02-01-24 return to Regression

	Given I am on "Public" "test"

	Given a bureau owned pool is created with jurors
		| court |juror_number   | pool_number	| att_date_weeks_in_future	| owner |
		| 457   |<juror_number1>| <pool_number>	| 4				            | 400	|
		| 457   |<juror_number2>| <pool_number>	| 4				            | 400	|

	Given juror "<juror_number1>" has "LAST_NAME" as "<last_name>" new schema
	Given juror "<juror_number2>" has "LAST_NAME" as "<last_name>" new schema
	Given juror "<juror_number1>" has "POSTCODE" as "<postcode>" new schema
	Given juror "<juror_number2>" has "POSTCODE" as "<postcode>" new schema
		
	And auto straight through processing has been enabled new schema
		
	Given I have submitted a first party English ineligibilty response
		|part_no		|pool_number	|last_name	|postcode	|email 		|details	|
		|<juror_number1>|<pool_number>	|<last_name>|<postcode>	|<email>	|<details>	|
		|<juror_number2>|<pool_number>	|<last_name>|<postcode>	|<email>	|<details>	|

	Given I am on "Bureau" "test"
	When I log in as "SYSTEM"
	And I click on the "Search" link
	And I set "Juror's pool number" to "<pool_number>"
	And I press the "Search" button
	
	When I click on "<juror_number2>" in the same row as "<juror_number2>"
	
	And I press the "Process reply" button
	And I click on the "Excusal" link
	Then I select "D - DECEASED" from the "Reason for the excusal request" dropdown
	And I set the radio button to "Accept excusal request"
	And I press the "Confirm" button
		
	Then I see "Search" on the page
	And I click on the "Search" link
	And I set "Juror's pool number" to "<pool_number>"
	And I set "Juror number" to ""
	
	And I select "All officers" from the "Officer assigned" dropdown
	And I press the "Search" button
	Then on the page I see
		| text 				|
		| <juror_number1>	|
	
	When I click on the "Select all" link
	Then the checkbox in the same row as "<juror_number1>" is "checked"
	
	When I press the "Send to..." button
	
	When I click on the "Cancel" link
	Then "Juror number" is ""
	
	When I click on the "Unselect all" link
	Then the checkbox in the same row as "<juror_number1>" is "unchecked"

	And I press the "Send to..." button
	Then I see "There is a problem" on the page
	And I see "Select the replies you want to send" on the page
	
	When I click on "<juror_number1>" in the same row as "<juror_number1>"
	Then on the page I see
		| text 			|
		|Juror details	|
		|Court name		|
		|Pool number	|
	
	When I click on the "Back" link
	Then I see "esults for" on the page
	And "Juror's pool number" is "<pool_number>"
	
	When I click on the "Advanced search" link
	And I check the "closed" checkbox
	And I press the "Search" button
	Then I see "and “Completed”" on the page
	
	When I click on "<juror_number2>" in the same row as "<juror_number2>"
	Then on the page I see
		|text |
		|Juror details|
		|Court name|
		|Pool number|
		|COMPLETED|
		
	When I click on the "Back" link
	And I click on the "Clear search" link
	Then "Juror's pool number" is ""

	And I set "Juror number" to "<juror_number2>"
	And I set "Juror's last name" to "<last_name>"
	And I set "Juror's pool number" to ""
	
	And I press the "Search" button
	Then I see "1 results for" on the page
	And I see "COMPLETED" in the same row as "<juror_number2>"
	
	When I click on "<juror_number2>" in the same row as "<juror_number2>"
	Then I see "Reply status" on the page
	And I see "COMPLETED" on the page

Examples:
	|juror_number1	|juror_number2	| pool_number 	| last_name 		| postcode 	|email				|details	|
	|045700013		| 045700014		| 457300013 	| LNAMEONEFIVEFOUR 	| CH1 2AN	|ab@automation.com	|12345abcde	|
	
@Regression @NewSchemaConverted
Scenario: Attempt to input alpha characters into Juror Number and Pool Number fields on Seach screen on Bureau
	
	Given I am on "Bureau" "test"
	When I log in
	And I click on the "Search" link
	And I set "Juror number" to "abcdefghijklmnopqrstuvwxyz"
	And I set "Juror's pool number" to "abcdefghijklmnopqrstuvwxyz"
	And "Juror number" is ""
	And "Juror's pool number" is ""
	
	#This needs to also be done on Firefox and IE

	