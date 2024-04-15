Feature: Work Allocation Regression

@Regression @NewSchemaConverted
Scenario Outline: Check that Urgent ST is not auto assigned

	Given I am on "Public" "test"

	Given a bureau owned pool is created with jurors
		| court | juror_number  | pool_number	| att_date_weeks_in_future	| owner |
		| 452   | <juror_number>| <pool_number>	| 3				            | 400	|
		
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
	When I choose the "Yes" radio button
	
	#Check Name
	When I press the "Continue" button
	Then I see "Is this your address?" on the page
	When I choose the "Yes" radio button
	
	#Check Address
	And I press the "Continue" button
	Then I see "What is your phone number?" on the page
	
	#Phone Details
	When I set "Main phone" to "0207 821 1818"
	And I press the "Continue" button
	Then I see "What is your email address?" on the page
	
	#Email
	When I set "Enter your email address" to "email@outlook.com"
	And I set "Enter your email address again" to "email@outlook.com"
	And I press the "Continue" button
	Then I see "What is your date of birth?" on the page
	
	#DoB
	When I press the "Continue" button
	When I set "Day" to "27"
	And I set "Month" to "04"
	And I set "Year" to "1981"
	And I press the "Continue" button
	Then I see "Confirm you're eligible for jury service" on the page
	
	When I press the "Continue" button
	
	#Residency
	Then I see "Since you turned 13, has your main address been in the UK, Channel Islands or Isle of Man for any period of at least 5 years?" on the page
	When I choose the "Yes" radio button
	And I press the "Continue" button
	
	#CJS
	Then I see "Have you worked in the criminal justice system in the last 5 years?" on the page
	When I choose the "No" radio button
	And I press the "Continue" button
	
	#Bail
	When I choose the "No" radio button
	And I press the "Continue" button
	
	#Convictions
	Then I see "Have you been found guilty of a criminal offence?" on the page
	When I choose the "No" radio button
	And I press the "Continue" button
	
	#Mental Health part 1
	Then I see "Are you being detained, looked after or treated under the Mental Health Act?" on the page
	When I choose the "No" radio button
	And I press the "Continue" button
	
	#Mental Health part 2
	When I choose the "No" radio button
	And I press the "Continue" button
	
	# Confirm Date of Jury
	Then I see "Check your start date" on the page
	When I set the radio button to "No, I cannot do jury service and need to be excused" 
	And I press the "Continue" button
	
	#Excusal Reason
	Then I see "Why do you need to be excused from jury service?" on the page
	When I set text area with "id" of "excusalReason" to "££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££"
	And I press the "Continue" button
	
	#RA
	Then I see "Will you need help when" on the page
	When I choose the "No" radio button
	And I press the "Continue" button
	
	#Check Your Answers Now
	Then I see "Check your answers now" on the page
	When I check the "The information" checkbox
	And I press the "Submit" button
	And I see "You have completed your reply" on the page
	
	#Bureau
	Given I am on "Bureau" "test"
	And I log in as "MODTESTBUREAU"
	And I click on the "Search" link
	And I set "Juror number" to "<juror_number>"
	And I press the "Search" button
	Then I see "TO DO" in the same row as "<juror_number>"
	When I click on "<juror_number>" in the same row as "<juror_number>"
	Then I see "URGENT" on the page
	
	Then on "JUROR_MOD" . "JUROR_RESPONSE" I see "STAFF_LOGIN" is null where "JUROR_NUMBER" is "<juror_number>"
	Then on "JUROR_MOD" . "JUROR_RESPONSE" I see "STAFF_ASSIGNMENT_DATE" is null where "JUROR_NUMBER" is "<juror_number>"
	
	#JDB-3744
	Then on "JUROR_MOD" . "JUROR_RESPONSE" I see "URGENT" is "Y" where "JUROR_NUMBER" is "<juror_number>"
	Then on "JUROR_MOD" . "JUROR_RESPONSE" I see "SUPER_URGENT" is "N" where "JUROR_NUMBER" is "<juror_number>"
	
Examples:
	| juror_number	| last_name			| postcode	| email           	| pool_number	|
	| 045200207		| LNAMESIXEIGHTTHREE| CH1 2AN	| email@outlook.com	| 452300192		|
	
@Regression @NewSchemaConverted
Scenario Outline: Check that Super Urgent ST is not auto assigned

	Given I am on "Public" "test"

	Given a bureau owned pool is created with jurors
		| court | juror_number  | pool_number	| att_date_weeks_in_future	| owner |
		| 452   | <juror_number>| <pool_number>	| 1				            | 400	|

	Given a new pool is inserted for where record has transferred to the court new schema
		| part_no         | pool_no       | owner |
		| <juror_number>  | <pool_number> | 452   |
	
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
	When I choose the "Yes" radio button
	
	#Check Name
	When I press the "Continue" button
	Then I see "Is this your address?" on the page
	When I choose the "Yes" radio button
	
	#Check Address
	And I press the "Continue" button
	Then I see "What is your phone number?" on the page
	
	#Phone Details
	When I set "Main phone" to "0207 821 1818"
	And I press the "Continue" button
	Then I see "What is your email address?" on the page
	
	#Email
	When I set "Enter your email address" to "email@outlook.com"
	And I set "Enter your email address again" to "email@outlook.com"
	And I press the "Continue" button
	Then I see "What is your date of birth?" on the page
	
	#DoB
	When I press the "Continue" button
	Then I see "Enter the day you were born" on the page
	And I do not see "Enter the month you were born" on the page
	And I do not see "Enter the year you were born" on the page
	When I set "Day" to "27"
	And I set "Month" to "04"
	And I set "Year" to "1981"
	And I press the "Continue" button
	Then I see "eligible for jury service" on the page
	
	When I press the "Continue" button
	Then I see "Since you turned 13, has your main address been in the UK, Channel Islands or Isle of Man for any period of at least 5 years?" on the page
	
	#Residency
	When I choose the "Yes" radio button
	And I press the "Continue" button
	
	#CJS
	Then I see "Have you worked in the criminal justice system in the last 5 years?" on the page
	When I choose the "No" radio button
	And I press the "Continue" button
	
	#Bail
	When I choose the "No" radio button
	And I press the "Continue" button
	Then I see "Have you been found guilty of a criminal offence?" on the page
	
	#Convictions
	When I choose the "No" radio button
	And I press the "Continue" button
	
	Then I see "Are you being detained, looked after or treated under the Mental Health Act?" on the page
	
	#Mental Health part 1
	When I choose the "No" radio button
	And I press the "Continue" button
	
	#Mental Health part 2
	When I choose the "No" radio button
	And I press the "Continue" button
	
	Then I see "Check your start date" on the page
	
	# Confirm Date of Jury
	When I set the radio button to "No, I cannot do jury service and need to be excused" 
	And I press the "Continue" button
	
	#Excusal Reason
	Then I see "Why do you need to be excused from jury service?" on the page
	When I set text area with "id" of "excusalReason" to "££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££"
	And I press the "Continue" button
	
	#RA
	Then I see "Will you need help when" on the page
	When I choose the "No" radio button
	And I press the "Continue" button
	Then I see "Check your answers now" on the page
	
	#Check Your Answers Now
	When I check the "The information" checkbox
	And I press the "Submit" button
	And I see "You have completed your reply" on the page
	
	#Bureau
	Given I am on "Bureau" "test"
	And I log in as "MODTESTBUREAU"
	And I click on the "Search" link
	And I set "Juror number" to "<juror_number>"
	And I press the "Search" button
	Then I see "To do" in the same row as "<juror_number>"
	When I click on "<juror_number>" in the same row as "<juror_number>"
	Then I see "SEND TO COURT" on the page
	
	Then on "JUROR_MOD" . "JUROR_RESPONSE" I see "STAFF_LOGIN" is null where "JUROR_NUMBER" is "<juror_number>"
	Then on "JUROR_MOD" . "JUROR_RESPONSE" I see "STAFF_ASSIGNMENT_DATE" is null where "JUROR_NUMBER" is "<juror_number>"

	Then on "JUROR_MOD" . "JUROR_RESPONSE" I see "URGENT" is "N" where "JUROR_NUMBER" is "<juror_number>"
	Then on "JUROR_MOD" . "JUROR_RESPONSE" I see "SUPER_URGENT" is "Y" where "JUROR_NUMBER" is "<juror_number>"
	
Examples:
	| juror_number	| last_name			| postcode	| email          	| pool_number	|
	| 045200208		| LNAMESEVENONEONE	| CH1 2AN	| email@outlook.com	| 452300193		|