Feature: 1st_Straight Spaces in Phone number

@RegressionSingle @NewSchemaConverted
Scenario Outline: 1st_Straight Spaces in Phone number

	Given I am on "Public" "test"

	Given a bureau owned pool is created with jurors
		| court | juror_number  	| pool_number	| att_date_weeks_in_future	| owner |
		| 452   | <juror_number>	| <pool_number>	| 5			            	| 400	|

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

	#Moving past Name Section
	When I choose the "Yes" radio button
	And I press the "Continue" button
	Then I see "Is this your address?" on the page
	When I choose the "Yes" radio button
	When I press the "Continue" button

	When I set "Main phone" to "0207 8211 818"
	When I set "Another phone (optional)" to "0207 1111 111"
	And I press the "Continue" button
	When I set "Enter your email address" to "<email>"
	When I set "Enter your email address again" to "<email>"
	And I press the "Continue" button

	#On DoB Screen
	Then I see "date of birth" on the page

	When I set "Day" to "27"
	And I set "Month" to "04"
	And I set "Year" to "1990"
	And I press the "Continue" button

	Then I see "Confirm you're eligible for jury service" on the page

	When I press the "Continue" button

	Then I see "Since you turned 13, has your main address been in the UK, Channel Islands or Isle of Man for any period of at least 5 years?" on the page

	#Residency
	When I see "Eligibility" on the page
	And I choose the "Yes" radio button
	And I press the "Continue" button

	#CJS no
	Then I see "Have you worked in the criminal justice system in the last 5 years?" on the page
	When I choose the "No" radio button
	And I press the "Continue" button

	Then I see "Are you currently on bail for a criminal offence?" on the page

	#Bail
	When I see "Eligibility" on the page
	And I choose the "No" radio button
	And I press the "Continue" button

	Then I see "Have you been found guilty of a criminal offence?" on the page

	#Convictions
	When I see "Eligibility" on the page
	When I choose the "No" radio button
	And I press the "Continue" button

	#Mental Health Sectioned
	Then I see "Are you being detained, looked after or treated under the Mental Health Act?" on the page
	When I see "Eligibility" on the page
	And I choose the "No" radio button
	And I press the "Continue" button

	#Mental Health Capacity
	Then I see "Has it been decided that you 'lack mental capacity'?" on the page
	When I see "Eligibility" on the page
	And I choose the "No" radio button
	And I press the "Continue" button

	Then I see "Check your start date" on the page

	#I can attend
	And I see "Yes, I can start on" on the page
	And I set the radio button to "Yes, I can start on"
	And  I press the "Continue" button

	#RA no
	Then I see "Will you need help when you're at the court?" on the page
	When I choose the "No" radio button
	And I press the "Continue" button
	Then I see "Check your answers now" on the page
	Then I see "0207 8211 818" on the page
	And I see "0207 1111 111" on the page

	When I click on the "Change" link in the same row as "Main phone"
	Then "Main phone" is "0207 8211 818"
	And "Another phone (optional)" is "0207 1111 111"

	When I set "Another phone (optional)" to "0207 1111 112"
	And I press the "Continue" button
	When I click on the "Change" link in the same row as "Another phone (optional)"
	Then "Another phone (optional)" is "0207 1111 112"

	When I press the "Continue" button

	And I check the "The information" checkbox

	Given auto straight through processing has been disabled new schema

	And I press the "Submit" button
	Then I see "You have completed your reply" on the page

	Given auto straight through processing has been enabled new schema

	Given I am on "Bureau" "test"
	When I log in as "CPASS"
	
	When I click on the "Search" link
	And I set "Juror number" to "<juror_number>"
	And I press the "Search" button
	Then I see "<juror_number>" on the page
	And I click on "<juror_number>" in the same row as "<juror_number>"

	##mark juror as deceased
	And I press the "Process reply" button
	And I choose the "Excusal - grant or refuse" radio button
	And I press the "Continue" button
	And I select "D - DECEASED" from the "Reason for excusal request" dropdown
	And I choose the "Grant excusal" radio button
	And I press the "Continue" button
	Then I see the juror record updated banner containing "Excusal granted (deceased)"
	And I click on the "<juror_number>" link
	And I click on the "Summons reply" link
	And I see "Excusal granted (deceased)" on the page
	And I see "COMPLETED" on the page
	
	Then on "JUROR_MOD" . "JUROR" I see "H_PHONE" is "0207 8211 818" where "JUROR_NUMBER" is "<juror_number>"
	Then on "JUROR_MOD" . "JUROR" I see "W_PHONE" is "0207 1111 112" where "JUROR_NUMBER" is "<juror_number>"
	
Examples:
	| juror_number	| last_name			| postcode	| email 	| pool_number	|
	| 045200254		|LNAMETHREESIXZERO	|SA1 4PF	|a@eeee.com	| 452300231		|