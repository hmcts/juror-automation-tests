Feature: Regression English_1st_EmailError

@JDB-3408 @Regression
Scenario Outline: Checking email error validation

	Given I am on "Public" "test"

	Given a bureau owned pool is created with jurors
		| court |juror_number  | pool_number	| att_date_weeks_in_future	| owner |
		| 452   |<juror_number>| <pool_number>	| 5				            | 400	|

	And juror "<juror_number>" has "LAST_NAME" as "<last_name>" new schema
	And juror "<juror_number>" has "POSTCODE" as "<postcode>" new schema

	Then I see "Reply to a jury summons" on the page
	
	And I set the radio button to "I am replying for myself"
	And I press the "Continue" button
	Then I see "Your juror details" on the page
	
	#Juror Log In
	When I set "9-digit juror number" to "<juror_number>"
	When I set "Juror last name" to "<last_name>"
	When I set "Juror postcode" to "<postcode>"
	And I press the "Continue" button
	Then I see "Is the name we have for you correct?" on the page
	
	#Check Name
	And I choose the "No" radio button
	And I press the "Continue" button
	Then I set "First name" to ""
	And I set "Last name" to ""
	And I press the "Continue" button
	Then I see "Enter your first name" on the page
	Then I see "Enter your last name" on the page
	When I set "First name" to "FirstNamea"
	And I set "Last name" to "LastNameb"
	And I press the "Continue" button
	Then I see "Is this your address?" on the page
	When I click on the "Back" link
	Then I see "FirstNamea" on the page
	And I see "LastNameb" on the page
	And I choose the "Yes" radio button
	When I press the "Continue" button
	Then I see "Is this your address?" on the page
	
	#Check Address
	And I choose the "No" radio button
	When I press the "Continue" button
	Then I set "Address line 1" to ""
	And I set "Town or city" to ""
	And I set "County (optional)" to ""
	And I set "Postcode" to ""
	And I press the "Continue" button
	
	Then I see "Provide the town or city you live in" on the page
	Then I see "Enter your postcode" on the page
	When I set "Address line 1" to "123 Street"
	And I set "Town or city" to "London"
	And I set "County (optional)" to "County"
	And I set "Postcode" to "CH1 2AN"
	
	And I press the "Continue" button

	Then I see "What is your phone number?" on the page
	When I click on the "Back" link
	Then I see "123 Street" on the page
	And I see "London" on the page
	And I see "CH1 2AN" on the page
	And I choose the "Yes" radio button
	And I press the "Continue" button

	Then I see "What is your phone number?" on the page
	
	#When I press the "Continue" button
	When I press the "Continue" button
	Then I see "Enter your main phone number" on the page
	When I set "Main phone" to "0207 821 1818"
	And I press the "Continue" button
	
	#Phone Details
	Then I see "What is your email address?" on the page
	When I click on the "Back" link
	Then I see "What is your phone number?" on the page
	And I press the "Continue" button
	Then I see "What is your email address?" on the page

	#Email
	When I press the "Continue" button
	Then I see "Enter your email address" on the page
	
	#Error happened here
	And I see "Enter your email address and check that it matches the one in the first field" on the page
	When I set "Enter your email address" to "<email>"
	And I set "Enter your email address again" to "<email>"
	And I press the "Continue" button
	Then I see "What is your date of birth?" on the page
	When I click on the "Back" link
	Then I see "What is your email address?" on the page
	And I press the "Continue" button
	
	Then I see "What is your date of birth?" on the page
	When I set "Day" to "27"
	And I set "Month" to "04"
	And I set "Year" to "1981"
	And I press the "Continue" button
	Then I see "Confirm you're eligible for jury service" on the page
	
Examples:
	| juror_number	| last_name			| postcode	| email            | pool_number| owner |
	| 045200044		| LNAMESIXSIXZERO	| CH1 2AN	| email@outlook.com| 452300043	| 400 	|