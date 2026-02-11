Feature: JDB-1820 - Happy Path

@Regression
Scenario Outline: JDB-1820 - Happy Path

	Given I am on "Public" "ithc"

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
	When I choose the "Yes" radio button
	
	#Check name
	When I press the "Continue" button
	Then I see "Is this your address?" on the page
	Then I see "Will your address change soon?" on the page
	
	#JDB-4125
	And I click on the "Will your address change soon?" link
	Then I see "If your address will change soon, give us your current address. This is so we can still contact you." on the page
	Then I see "After you've moved, contact the jury central summoning bureau by calling 0300 456 1024, and give them your new address." on the page
	Then I see "If you are moving away from the area where you currently live, we may change the location of your jury service." on the page
	When I choose the "Yes" radio button
	
	#Check address
	When I press the "Continue" button
	
	Then I see "What is your phone number?" on the page
	
	#Phone details
	When I set "Main phone" to "0207 821 1818"
	And I press the "Continue" button
	Then I see "What is your email address?" on the page
	
	#Email details
	When I set "Enter your email address" to "email@outlook.com"
	And I set "Enter your email address again" to "email@outlook.com"
	And I press the "Continue" button

	#DoB
	Then I see "What is your date of birth?" on the page
	When I set "Day" to "27"
	And I set "Month" to "04"
	And I set "Year" to "1981"
	And I press the "Continue" button
	
	Then I see "Confirm you're eligible for jury service" on the page
	
	When I press the "Continue" button
	Then I see "Have you lived in the UK, Channel Islands or Isle of Man for more than five consecutive years, since your 13th birthday?" on the page
	
	#Residency Yes
	When I choose the "Yes" radio button
	And I press the "Continue" button
	
	#CJS no
	Then I see "Have you worked in the criminal justice system in the last 5 years?" on the page
	When I choose the "No" radio button
	And I press the "Continue" button
	
	#Bail no
	Then I see "Are you currently on bail for a criminal offence?" on the page
	When I choose the "No" radio button
	And I press the "Continue" button
	
	#Convictions no
	Then I see "Have you been found guilty of a criminal offence?" on the page
	When I choose the "No" radio button
	And I press the "Continue" button
	
	#Mental health part 1 no
	Then I see "Are you being detained, looked after or treated under the Mental Health Act?" on the page
	When I choose the "No" radio button
	And I press the "Continue" button
	
	#Mental health part 2 no
	Then I see "Has it been decided that you 'lack mental capacity'?" on the page
	When I choose the "No" radio button
	And I press the "Continue" button
	
	#I can attend
	Then I see "Check your start date" on the page
	And I see "Yes, I can start on" on the page
	And I set the radio button to "Yes, I can start on"
	And  I press the "Continue" button
	
	#RA no
	Then I see "Will you need help when you're at the court?" on the page
	When I choose the "No" radio button
	And I press the "Continue" button
	Then I see "Check your answers now" on the page
	
	#Check your answers
	When I check the "The information I have given is true to the best of my knowledge" checkbox
	And I press the "Submit" button
	
	#When I press the "Submit" button
	Then I see "We have sent you an email to say you have replied to your jury summons." on the page
	
Examples:
	| juror_number	| last_name			| postcode	| email           	| pool_number	|
	| 045200180		| LNAMETWOSIXZERO	| CH1 2AN	| email@outlook.com	| 452300165		|