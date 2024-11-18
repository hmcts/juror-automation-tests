Feature: Regression English_1st_RA

@Regression
Scenario Outline: English 1st Party RA

	Given I am on "Public" "ithc"

	Given a bureau owned pool is created with jurors
		| court |juror_number  | pool_number	| att_date_weeks_in_future	| owner |
		| 452   |<juror_number>| <pool_number>	| 4				            | 400	|

	And juror "<juror_number>" has "LAST_NAME" as "<last_name>" new schema
	And juror "<juror_number>" has "ADDRESS_LINE_4" as "LONDON" new schema
	And juror "<juror_number>" has "POSTCODE" as "<postcode>" new schema
	
	#Reply to jury summons
	Then I see "Reply to a jury summons" on the page
	
	And I set the radio button to "I am replying for myself"
	And I press the "Continue" button
	Then I see "Your juror details" on the page
	
	When I set "9-digit juror number" to "<juror_number>"
	When I set "Juror last name" to "<last_name>"
	When I set "Juror postcode" to "<postcode>"
	And I press the "Continue" button
	
	#name
	Then I see "Is the name we have for you correct?" on the page
	When I choose the "Yes" radio button
	And I press the "Continue" button
	
	#address
	Then I see "Is this your address?" on the page
	When I choose the "Yes" radio button
	And I press the "Continue" button
	
	#phone
	Then I see "What is your phone number?" on the page
	When I set "Main phone" to "02078211818"
	And I press the "Continue" button
	
	#email
	Then I see "What is your email address?" on the page
	When I set "Enter your email address" to "<email>"
	When I set "Enter your email address again" to "<email>"
	And I press the "Continue" button
	
	#dob
	Then I see "What is your date of birth?" on the page
	When I set "Day" to "27"
	And I set "Month" to "04"
	And I set "Year" to "1981"
	And I press the "Continue" button
	
	#qualifying
	Then I see "Confirm you're eligible for jury service" on the page
	And I press the "Continue" button
	
	#residency
	Then I see "Since you turned 13, has your main address" on the page
	When I choose the "Yes" radio button
	And I press the "Continue" button
	
	#CJS
	Then I see "Have you worked in the criminal justice system in the last 5 years?" on the page
	When I choose the "No" radio button
	And I press the "Continue" button
	
	#bail
	Then I see "Are you currently on bail" on the page
	When I choose the "No" radio button
	And I press the "Continue" button
	
	#crim offence
	Then I see "Have you been found guilty of a criminal offence" on the page
	When I choose the "No" radio button
	And I press the "Continue" button
	
	#MHQ1
	Then I see "Are you being detained, looked after or treated under the Mental Health Act?" on the page
	When I choose the "No" radio button
	And I press the "Continue" button
	
	#MHQ2
	Then I see "Has it been decided that you 'lack mental capacity'?" on the page
	When I choose the "No" radio button
	And I press the "Continue" button
	
	#confirm date
	Then I see "Check your start date" on the page
	And I see "Yes, I can start on" on the page
	And I set the radio button to "Yes, I can start on"
	And I press the "Continue" button
	
	#Help in Court
	#3608
	Then I see "Will you need help when you're at the court?" on the page
	When I choose the "Yes" radio button
	And I press the "Continue" button
	Then I see "Select if you have limited mobility, a hearing impairment, diabetes, a severe sight impairment or other disability or impairment" on the page
	Then I check the "Diabetes" checkbox
	And I press the "Continue" button
		
	#Check Answers
	Then I see "Check your answers now" on the page
	
	Then I check the "The information I have given is true to the best of my knowledge" checkbox
	
	When I press the "Submit" button

	#Confirmation
	Then I see "You have completed your reply" on the page
	
Examples:
	| juror_number	| pool_number	| last_name				| postcode	| email 	|
	| 045200062		| 452300061		| LNAMENINENINEONE		| CH1 2AN	| e@eeee.com|
	
@RegressionSingle
Scenario Outline: Reasonable adjustments (DIABETES) to automatically update Juror db
	
	Given I am on "Public" "ithc"

	Given a bureau owned pool is created with jurors
		| court |juror_number  | pool_number	| att_date_weeks_in_future	| owner |
		| 452   |<juror_number>| <pool_number>	| 5				            | 400	|

	And juror "<juror_number>" has "LAST_NAME" as "<last_name>" new schema
	And juror "<juror_number>" has "ADDRESS_LINE_4" as "LONDON" new schema
	And juror "<juror_number>" has "POSTCODE" as "<postcode>" new schema
	
	#Reply to jury summons
	Then I see "Reply to a jury summons" on the page

	And I set the radio button to "I am replying for myself"
	And I press the "Continue" button
	Then I see "Your juror details" on the page
	
	When I set "9-digit juror number" to "<juror_number>"
	When I set "Juror last name" to "<last_name>"
	When I set "Juror postcode" to "<postcode>"
	And I press the "Continue" button
	
	#name
	Then I see "Is the name we have for you correct?" on the page
	When I choose the "Yes" radio button
	And I press the "Continue" button
	
	#address
	Then I see "Is this your address?" on the page
	When I choose the "Yes" radio button
	And I press the "Continue" button
	
	#phone
	Then I see "What is your phone number?" on the page
	When I set "Main phone" to "02078211818"
	And I press the "Continue" button
	
	#email
	Then I see "What is your email address?" on the page
	When I set "Enter your email address" to "<email>"
	When I set "Enter your email address again" to "<email>"
	And I press the "Continue" button
	
	#dob
	Then I see "What is your date of birth?" on the page
	When I set "Day" to "27"
	And I set "Month" to "04"
	And I set "Year" to "1981"
	And I press the "Continue" button
	
	#qualifying
	Then I see "Confirm you're eligible for jury service" on the page
	And I press the "Continue" button
	
	#residency
	Then I see "Since you turned 13, has your main address" on the page
	When I choose the "Yes" radio button
	And I press the "Continue" button
	
	#CJS
	Then I see "Have you worked in the criminal justice system in the last 5 years?" on the page
	When I choose the "No" radio button
	And I press the "Continue" button
	
	#bail
	Then I see "Are you currently on bail" on the page
	When I choose the "No" radio button
	And I press the "Continue" button
	
	#crim offence
	Then I see "Have you been found guilty of a criminal offence" on the page
	When I choose the "No" radio button
	And I press the "Continue" button
	
	#MHQ1
	Then I see "Are you being detained, looked after or treated under the Mental Health Act?" on the page
	When I choose the "No" radio button
	And I press the "Continue" button
	
	#MHQ2
	Then I see "Has it been decided that you 'lack mental capacity'?" on the page
	When I choose the "No" radio button
	And I press the "Continue" button
	
	#confirm date
	Then I see "Check your start date" on the page
	And I see "Yes, I can start on" on the page
	And I set the radio button to "Yes, I can start on"
	And I press the "Continue" button
	
	#Help in Court
	Then I see "Will you need help when you're at the court?" on the page
	When I choose the "Yes" radio button
	Then I check the "Diabetes" checkbox
	And I see "Tell us about any special arrangements or help you need while you're doing jury service." on the page
	Then I set "Tell us about any special arrangements or help you need while you're doing jury service." to "Special Need is DIABETES"
	And I press the "Continue" button
		
	#Check Answers
	Then I see "Check your answers now" on the page
	
	Then I check the "The information I have given is true to the best of my knowledge" checkbox
	
	When I press the "Submit" button

	#Confirmation
	Then I see "You have completed your reply" on the page
	
	Given I am on "Bureau" "ithc"
	And I log in as "CPASS"
	
	When I click on the "Search" link
	And I set "Juror number" to "<juror_number>"
	And I press the "Search" button
	And I click on "<juror_number>" in the same row as "<juror_number>"
	
	#process response
	When I select "Mark as responded" from Process reply
	And I check the "Mark juror as 'responded'" checkbox
	And I press the "Confirm" button
	
	#check db
	And I search for juror "<juror_number>"
	And I click on the "Summons reply" link
	Then I see "Responded" on the page
	And I see "Completed" on the page
	Then on "JUROR_MOD" . "JUROR_REASONABLE_ADJUSTMENT" I see "REASONABLE_ADJUSTMENT" is "I" where "JUROR_NUMBER" is "<juror_number>"

Examples:
	| juror_number	| pool_number	| last_name			| postcode	| email 		|
	| 045200063		| 452300062		| LNAMENINENINEONE	| CH1 2AN	| e@eeee.com	|
	
@Regression
Scenario Outline: Reasonable adjustments (OTHER) to automatically update Juror db
	
	Given I am on "Public" "ithc"

	Given a bureau owned pool is created with jurors
		| court |juror_number  | pool_number	| att_date_weeks_in_future	| owner |
		| 452   |<juror_number>| <pool_number>	| 5				            | 400	|

	And juror "<juror_number>" has "LAST_NAME" as "<last_name>" new schema
	And juror "<juror_number>" has "ADDRESS_LINE_4" as "LONDON" new schema
	And juror "<juror_number>" has "POSTCODE" as "<postcode>" new schema
	
	#Reply to jury summons
	Then I see "Reply to a jury summons" on the page

	And I set the radio button to "I am replying for myself"
	And I press the "Continue" button
	Then I see "Your juror details" on the page
	
	When I set "9-digit juror number" to "<juror_number>"
	When I set "Juror last name" to "<last_name>"
	When I set "Juror postcode" to "<postcode>"
	And I press the "Continue" button
	
	#name
	Then I see "Is the name we have for you correct?" on the page
	When I choose the "Yes" radio button
	And I press the "Continue" button
	
	#address
	Then I see "Is this your address?" on the page
	When I choose the "Yes" radio button
	And I press the "Continue" button
	
	#phone
	Then I see "What is your phone number?" on the page
	When I set "Main phone" to "02078211818"
	And I press the "Continue" button
	
	#email
	Then I see "What is your email address?" on the page
	When I set "Enter your email address" to "<email>"
	When I set "Enter your email address again" to "<email>"
	And I press the "Continue" button
	
	#dob
	Then I see "What is your date of birth?" on the page
	When I set "Day" to "27"
	And I set "Month" to "04"
	And I set "Year" to "1981"
	And I press the "Continue" button
	
	#qualifying
	Then I see "Confirm you're eligible for jury service" on the page
	And I press the "Continue" button
	
	#residency
	Then I see "Since you turned 13, has your main address" on the page
	When I choose the "Yes" radio button
	And I press the "Continue" button
	
	#CJS
	Then I see "Have you worked in the criminal justice system in the last 5 years?" on the page
	When I choose the "No" radio button
	And I press the "Continue" button
	
	#bail
	Then I see "Are you currently on bail" on the page
	When I choose the "No" radio button
	And I press the "Continue" button
	
	#crim offence
	Then I see "Have you been found guilty of a criminal offence" on the page
	When I choose the "No" radio button
	And I press the "Continue" button
	
	#MHQ1
	Then I see "Are you being detained, looked after or treated under the Mental Health Act?" on the page
	When I choose the "No" radio button
	And I press the "Continue" button
	
	#MHQ2
	Then I see "Has it been decided that you 'lack mental capacity'?" on the page
	When I choose the "No" radio button
	And I press the "Continue" button
	
	#confirm date
	Then I see "Check your start date" on the page
	And I see "Yes, I can start on" on the page
	And I set the radio button to "Yes, I can start on"
	And I press the "Continue" button
	
	#Help in Court
	Then I see "Will you need help when you're at the court?" on the page
	When I choose the "Yes" radio button
	Then I check the "Other" checkbox
	Then I set "Provide details" to "Some further details"
	Then I see "Tell us about any special arrangements or help you need while you're doing jury service." on the page
	Then I set "Tell us about any special arrangements or help you need while you're doing jury service." to "Special Need is OTHER"
	And I press the "Continue" button
		
	#Check Answers
	Then I see "Check your answers now" on the page
	
	Then I check the "The information I have given is true to the best of my knowledge" checkbox
	
	When I press the "Submit" button

	#Confirmation
	Then I see "You have completed your reply" on the page
	
	Given I am on "Bureau" "ithc"
	And I log in as "CPASS"

	When I click on the "Search" link
	And I set "Juror number" to "<juror_number>"
	And I press the "Search" button
	And I click on "<juror_number>" in the same row as "<juror_number>"
	
	#process response
	When I select "Mark as responded" from Process reply
	And I check the "Mark juror as 'responded'" checkbox
	And I press the "Confirm" button
	
	#check db
	Then I see the juror record updated banner containing "Responded"

	Then on "JUROR_MOD" . "JUROR_REASONABLE_ADJUSTMENT" I see "REASONABLE_ADJUSTMENT" is "O" where "JUROR_NUMBER" is "<juror_number>"

Examples:
	| juror_number	| pool_number	| last_name			| postcode	| email 		|
	| 045200064		| 452300063		| LNAMENINENINEONE	| CH1 2AN	| e@eeee.com	|

@Regression
Scenario Outline: Reasonable adjustments (MULTIPLE) to automatically update Juror db
	
	Given I am on "Public" "ithc"

	Given a bureau owned pool is created with jurors
		| court |juror_number  | pool_number	| att_date_weeks_in_future	| owner |
		| 452   |<juror_number>| <pool_number>	| 5				            | 400	|

	And juror "<juror_number>" has "LAST_NAME" as "<last_name>" new schema
	And juror "<juror_number>" has "ADDRESS_LINE_4" as "LONDON" new schema
	And juror "<juror_number>" has "POSTCODE" as "<postcode>" new schema
	
	#Reply to jury summons
	Then I see "Reply to a jury summons" on the page

	And I set the radio button to "I am replying for myself"
	And I press the "Continue" button
	Then I see "Your juror details" on the page
	
	When I set "9-digit juror number" to "<juror_number>"
	When I set "Juror last name" to "<last_name>"
	When I set "Juror postcode" to "<postcode>"
	And I press the "Continue" button
	
	#name
	Then I see "Is the name we have for you correct?" on the page
	When I choose the "Yes" radio button
	And I press the "Continue" button
	
	#address
	Then I see "Is this your address?" on the page
	When I choose the "Yes" radio button
	And I press the "Continue" button
	
	#phone
	Then I see "What is your phone number?" on the page
	When I set "Main phone" to "02078211818"
	And I press the "Continue" button
	
	#email
	Then I see "What is your email address?" on the page
	When I set "Enter your email address" to "<email>"
	When I set "Enter your email address again" to "<email>"
	And I press the "Continue" button
	
	#dob
	Then I see "What is your date of birth?" on the page
	When I set "Day" to "27"
	And I set "Month" to "04"
	And I set "Year" to "1981"
	And I press the "Continue" button
	
	#qualifying
	Then I see "Confirm you're eligible for jury service" on the page
	And I press the "Continue" button
	
	#residency
	Then I see "Since you turned 13, has your main address" on the page
	When I choose the "Yes" radio button
	And I press the "Continue" button
	
	#CJS
	Then I see "Have you worked in the criminal justice system in the last 5 years?" on the page
	When I choose the "No" radio button
	And I press the "Continue" button
	
	#bail
	Then I see "Are you currently on bail" on the page
	When I choose the "No" radio button
	And I press the "Continue" button
	
	#crim offence
	Then I see "Have you been found guilty of a criminal offence" on the page
	When I choose the "No" radio button
	And I press the "Continue" button
	
	#MHQ1
	Then I see "Are you being detained, looked after or treated under the Mental Health Act?" on the page
	When I choose the "No" radio button
	And I press the "Continue" button
	
	#MHQ2
	Then I see "Has it been decided that you 'lack mental capacity'?" on the page
	When I choose the "No" radio button
	And I press the "Continue" button
	
	#confirm date
	Then I see "Check your start date" on the page
	And I see "Yes, I can start on" on the page
	And I set the radio button to "Yes, I can start on"
	And I press the "Continue" button
	
	#Help in Court
	Then I see "Will you need help when you're at the court?" on the page
	When I choose the "Yes" radio button
	Then I check the "Other" checkbox
	Then I set "Provide details" to "Some further details"
	Then I check the "Limited mobility" checkbox
	Then I set "Tell us about any special arrangements or help you need while you're doing jury service" to "Special Need is OTHER and LIMITED MOBILITY"
	And I press the "Continue" button
		
	#Check Answers
	Then I see "Check your answers now" on the page
	
	Then I check the "The information I have given is true to the best of my knowledge" checkbox
	
	When I press the "Submit" button

	#Confirmation
	Then I see "You have completed your reply" on the page
	
	Given I am on "Bureau" "ithc"
	And I log in as "CPASS"

	When I click on the "Search" link
	And I set "Juror number" to "<juror_number>"
	And I press the "Search" button
	And I click on "<juror_number>" in the same row as "<juror_number>"
	
	#process response
	When I select "Mark as responded" from Process reply
	And I check the "Mark juror as 'responded'" checkbox
	And I press the "Confirm" button

	#check db
	Then I see the juror record updated banner containing "Responded"
	Then on "JUROR_MOD" . "JUROR" I see "REASONABLE_ADJ_CODE" is "M" where "JUROR_NUMBER" is "<juror_number>"

Examples:
	| juror_number	| pool_number	| last_name			| postcode	| email 		|
	| 045200065		| 452300064		| LNAMENINENINEONE	| CH1 2AN	| e@eeee.com	|