Feature: Bureau B Search for Team Member

@Features @NewSchemaConverted @JM-6728
Scenario Outline: Lift from QC Script for Bureau B Search

	#return to @RegressionSingle when defect fixed
	
	Given I am on "Public" "test"
	
	Given auto straight through processing has been disabled new schema

	Given a bureau owned pool is created with jurors
			| court |juror_number  | pool_number	| att_date_weeks_in_future	| owner |
			| 452   |<juror_number1>| <pool_number>	| 5				            | 400	|
			| 452   |<juror_number2>| <pool_number>	| 5				            | 400	|

	And juror "<juror_number1>" has "LAST_NAME" as "<last_name>" new schema
	And juror "<juror_number1>" has "POSTCODE" as "<postcode>" new schema

	And juror "<juror_number2>" has "LAST_NAME" as "<last_name>" new schema
	And juror "<juror_number2>" has "POSTCODE" as "<postcode>" new schema
		
	Given I have submitted a first party English straight through response
		|part_no		|pool_number	|last_name		|postcode	|email 	|
		|<juror_number1>|<pool_number>	|<last_name>	|<postcode>	|<email>|
		|<juror_number2>|<pool_number>	|<last_name>	|<postcode>	|<email>|
	
	Given I am on "Bureau" "test"

	When I log in as "CPASS"
	And I click on the "Search" link
	And I set "Juror's pool number" to "<pool_number>"
	And I press the "Search" button
	Then I see "<juror_number2>" on the page
	And I click on "<juror_number2>" in the same row as "<juror_number2>"
	
	And I press the "Process reply" button
	And I choose the "Excusal - grant or refuse" radio button
	And I press the "Continue" button

	Then I select "D - DECEASED" from the "Reason for excusal request" dropdown
	And I choose the "Grant excusal" radio button
	And I press the "Continue" button

	Then I see the juror record updated banner containing "Excusal granted (deceased)"
		
	And I click on the "Search" link
	And I set "Juror's pool number" to "<pool_number>"
	
	And I press the "Search" button
	Then on the page I see
		|text 				|
		|<juror_number1>	|
	
	When I click on "<juror_number1>" in the same row as "<juror_number1>"
	Then on the page I see
		|text 			|
		|Juror details	|
		|Court name		|
		|Pool number	|
	
	When I click on the "Back" link
	Then I see "esults for" on the page
	And "Juror's pool number" is "<pool_number>"
	
	When I click on "<juror_number2>" in the same row as "<juror_number2>"
	Then on the page I see
		|text 			|
		|Juror details	|
		|Court name		|
		|Pool number	|
		|COMPLETED		|
	
	When I click on the "Back" link
	And I click on the "Clear search" link
	Then "Juror's pool number" is ""

	And I set "Juror number" to "<juror_number2>"
	And I set "Juror's last name" to "<last_name>"
	And I set "Juror's pool number" to ""
	
	And I press the "Search" button
	Then I see "1 results for" on the page
	And I see "COMPLETE" in the same row as "<juror_number2>"
	
	When I click on "<juror_number2>" in the same row as "<juror_number2>"
	Then I see "Reply status" on the page
	And I see "Completed" on the page

	Given auto straight through processing has been enabled new schema
	
Examples:
	|juror_number1	|juror_number2	|pool_number|last_name 			|postcode 	|email				|
	|045200172		|045200173		|452300156 	|LNAMEONEFIVEFOUR 	|CH1 2AN	|ab@automation.com	|
	