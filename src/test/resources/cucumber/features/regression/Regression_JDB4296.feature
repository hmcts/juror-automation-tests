Feature: JDB-4296

@Regression @NewSchemaConverted
Scenario Outline: JDB-4296

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
	When I set the radio button to "Yes"
	
	#Name
	And I press the "Continue" button
	Then I see "Is this your address?" on the page
	When I set the radio button to "Yes"
	
	#Address
	And I press the "Continue" button
	Then I see "What is your phone number?" on the page
	
	#Phone Details
	When I set "Main phone" to "0207 821 1818"
	And I press the "Continue" button
	
	#Email
	When I set "Enter your email address" to "<email>"
	And I set "Enter your email address again" to "<email>"
	And I press the "Continue" button
	
	#DoB
	Then I see "What is your date of birth?" on the page
	When I set "Day" to "27"
	And I set "Month" to "04"
	And I set "Year" to "1981"
	And I press the "Continue" button
	Then I see "Confirm you're eligible for jury service" on the page
	
	When I press the "Continue" button
	
	#Residency
	Then I see "Since you turned 13, has your main address been in the UK, Channel Islands or Isle of Man for any period of at least 5 years?" on the page
	When I set the radio button to "Yes"
	And I press the "Continue" button
	
	#now start clicking Back
	Then I see "Have you worked" on the page
	When I click on the "Back" link
	Then I see "Since you turned 13, has your main address been in the UK, Channel Islands or Isle of Man for any period of at least 5 years?" on the page
	When I click on the "Back" link
	Then I see "Confirm you're eligible for jury service" on the page
	When I click on the "Back" link
	
	#change DOB to make juror over age
	Then I see "What is your date of birth?" on the page
	When I set "Day" to "27"
	And I set "Month" to "04"
	And I set "Year" to "1901"
	And I press the "Continue" button
	Then I see "Confirm your date of birth" on the page
	And I set the radio button to "Yes"
	When I press the "Continue" button 
	
	#Submit
	And I see "Check your answers now" on the page
	Then I check the "The information I have given is true to the best of my knowledge" checkbox
	When I press the "Submit" button
	
Examples:
	| juror_number	| last_name	| postcode	| email           	| pool_number |
	| 045200119		| DOE		| SW1H 9AJ	| email@outlook.com	| 452300118	  |