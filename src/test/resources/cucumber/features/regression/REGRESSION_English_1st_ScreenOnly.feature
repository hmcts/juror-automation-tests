 Feature: English_1st_ScreenOnly

@Regression @NewSchemaConverted
Scenario Outline: English 1st Screen Only

	Given I am on "Public" "test"

	Then the page title is "Reply to a jury summons - GOV.UK"

	Given a bureau owned pool is created with jurors
		| court |juror_number  | pool_number	| att_date_weeks_in_future	| owner |
		| 452   |<juror_number>| <pool_number>	| 5				            | 400	|
		
	And juror "<juror_number>" has "LAST_NAME" as "<last_name>" new schema
	And juror "<juror_number>" has "POSTCODE" as "<postcode>" new schema
	
	Then I see "Reply to a jury summons" on the page
	
	And I set the radio button to "I am replying for myself"
	And I press the "Continue" button
	And I set "9-digit juror number" to "<juror_number>"
	And I set "Juror last name" to "<last_name>"
	And I set "Juror postcode" to "<postcode>"
	And I press the "Continue" button
	
	#JDB-3358
	Then on the page I see
		| text	|
		| Your details |
		| Is the name we have for you correct? |
	
	And I choose the "No" radio button
	And I press the "Continue" button
	
	And I set "First name" to ""
	And I set "Last name" to ""
	And I press the "Continue" button
	
	Then on the page I see
		| text	|
		| Enter your first name	|
		| Enter your last name 	|
		
	When I set "First name" to "FirstNameA"
	And I set "Last name" to "LastNameB"
	And I press the "Continue" button
	
	#JDB-3359 and JDB-3355
	Then on the page I see
		| text	|
		| Your details |
		| Is this your address? |
	
	And I choose the "Yes" radio button
	And I press the "Continue" button
	
	#JDB-3361
	Then on the page I see
		| text	|
		|Your details|
		|What is your phone number?|
		|Please provide a UK phone number that we can use to reach you between 9am and 5pm, Monday to Friday.|
		|Main phone|
		|Another phone (optional)|
	
	When I set "Main phone" to "0207 821 1818"
	And I press the "Continue" button
	Then I see "What is your email address?" on the page
	
	When I click on the "Why do we need your email address?" link
	Then I see "We'll use your email address to send you information and reminders about your jury service." on the page
	And I set "Enter your email address" to "<email>"
	And I set "Enter your email address again" to "<email>"
	And I press the "Continue" button

	#JDB-3350 and JDB-3360
	Then on the page I see
		| text	|
		| Your details |
		| What is your date of birth? |
		| For example, 15 03 1982 |
		| Help with date of birth |
	
	When I press the "Continue" button
	Then on the page I see
		| text	|
		| There is a problem	|
		| Enter the day you were born |	
		| Your details	|
		| What is your date of birth?	|
		| For example, 15 03 1982 |
		| Help with date of birth |
	
	When I set "Day" to "01"
	And I set "Month" to "01"
	
	#JDB-3418 Checking age 18 works
	And I set "Year" to "2000"
	And I press the "Continue" button
	Then I see "Confirm you're eligible for jury service" on the page
	
Examples:
	| juror_number	| last_name		| postcode	| email 		| pool_number  	|
	| 045200067		| LNAMEEIGHTFOUR| CH1 2AN	| a@eeee.com	| 452300066		|