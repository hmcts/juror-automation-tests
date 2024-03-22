Feature: Mod_252

@Modernisation
Scenario Outline: Confirm_DoB_ErrorValidation
	Given I am on "Public" "bau-test"
	Given the juror numbers have not been processed
		|part_no 	|pool_no 	|owner 	|
		|<part_no> 	|<pool_no>	|400 	|
	
	And juror "<juror_number>" has "LAST_NAME" as "<last_name>" new schema


	And juror "<juror_number>" has "POSTCODE" as "<postcode>" new schema
	
	Then I see "Reply to a jury summons" on the page
	
	And I set the radio button to "I am replying for myself"
	And I press the "Continue" button
	Then I see "Your juror details" on the page
	
	When I set "9-digit juror number" to "<juror_number>"
	When I set "Juror last name" to "<last_name>"
	When I set "Juror postcode" to "<postcode>"
	And I press the "Continue" button
	Then I see "Is the name we have for you correct?" on the page
	And I choose the "Yes" radio button
	
	#Moving past Name Section
	
	When I press the "Continue" button
	Then I see "Is this your address?" on the page
	And I choose the "Yes" radio button
	
	When I press the "Continue" button
	Then I see "What is your phone number?" on the page
	
	When I set "Main phone" to "02078211818"
	And I press the "Continue" button
	Then I see "What is your email address?" on the page
	
	When I set "Enter your email address" to "email@outlook.com"
	And I set "Enter your email address again" to "email@outlook.com"
	And I press the "Continue" button
	
	#On DoB Screen
	
	Then I see "What is your date of birth?" on the page
	
	When I set "Day" to "27"
	And I set "Month" to "04"
	And I set "Year" to "2005"
	
	#Moving past DoB Section
	
	And I press the "Continue" button
	Then I see "Is your date of birth correct?" on the page
	
	And I choose the "No" radio button
	And I press the "Continue" button
	
	And I set "Day" to ""
	And I set "Month" to ""
	And I set "Year" to ""
	And I press the "Continue" button
	Then I see "There is a problem" on the page
	Then I see "Enter the day you were born" on the page
	And I do not see "Enter the month you were born" on the page
	And I do not see "Enter the year you were born" on the page
	
Examples:
	|part_no	|last_name	|postcode	|email 				|pool_no	|
	|641500106	|DOE		|SW1H 9AJ	|email@outlook.com	|415170401	|