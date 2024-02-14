Feature: 3rd English Relationship Validation Error

@JDB-3440 @Regression
Scenario Outline: 
	Given I am on "Public" "juror-test01"
	
	Given the juror numbers have not been processed
		| part_no 	| pool_no 	| owner |
		| <part_no> |<pool_no>	| 400 	|
		
	
	And "<part_no>" has "LNAME" as "<last_name>" 
	And "<part_no>" has "RET_DATE" as "5 mondays time"
	And "<part_no>" has "NEXT_DATE" as "5 mondays time"
	And "<part_no>" has "ZIP" as "<postcode>"
	
	Then I see "Reply to a jury summons" on the page
	
	
	And I set the radio button to "I am replying for someone else"
	And I press the "Continue" button
	Then I see "Their juror details" on the page
	
	When I set "9-digit juror number" to "<part_no>"
	When I set "Juror last name" to "<last_name>"
	When I set "Juror postcode" to "<postcode>"
	And I press the "Continue" button
	Then I see "What is your name?" on the page
	
	#3rd Party Name
	
	When I press the "Continue" button
	Then I see "Enter your first name" on the page
	And I see "Enter your last name" on the page
	When I set "First name" to "FirstNamea"
	And I set "Last name" to "LastNameb"
	And I press the "Continue" button
	Then I see "Your relationship to the person" on the page
	
	#Relationship to juror
	
	When I see "Your Details" on the page
	And I press the "Continue" button
	Then I see "Enter your relationship to the person summoned" on the page 
	And I see "Enter your relationship to the person summoned" on the page
	When I set "How do you know the person you're replying for?" to "Friend"
	And I press the "Continue" button
	Then I see "Your contact information" on the page
	
	
Examples:
	| part_no		|last_name			|postcode	| email           |pool_no	|
	|741500420		|LNAMEFOURTWOZERO	|CH1 2AN	|email@outlook.com|415181001|
	
