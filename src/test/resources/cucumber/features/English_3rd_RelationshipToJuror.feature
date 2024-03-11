Feature: 3rd English Relationship Validation Error

@Regression @NewSchemaConverted
Scenario Outline: 3rd English Relationship Validation Error

	Given I am on "Public" "test"

	Given a bureau owned pool is created with jurors
		| court |juror_number  | pool_number	| att_date_weeks_in_future	| owner |
		| 452   |<juror_number>| <pool_number>	| 5				            | 400	|
	
	And juror "<juror_number>" has "LAST_NAME" as "<last_name>" new schema
	And juror "<juror_number>" has "POSTCODE" as "<postcode>" new schema
	
	Then I see "Reply to a jury summons" on the page

	And I set the radio button to "I am replying for someone else"
	And I press the "Continue" button
	Then I see "Their juror details" on the page
	
	When I set "9-digit juror number" to "<juror_number>"
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
	| juror_number	| last_name			| postcode	| pool_number	|
	| 045200178		| LNAMEFOURTWOZERO	| CH1 2AN	| 452300163		|