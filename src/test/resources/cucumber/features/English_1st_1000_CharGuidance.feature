Feature: English_1st_1000_CharGuidance

@Regression @NewSchemaConverted
Scenario Outline: English 1st Party - Character count warning should be on all applicable pages

	Given I am on "Public" "test"

	Given a bureau owned pool is created with jurors
		| court |juror_number  | pool_number	| att_date_weeks_in_future	| owner |
		| 452   |<juror_number>| <pool_number>	| 5				            | 400	|
	
	And juror "<juror_number>" has "LAST_NAME" as "<last_name>" new schema
	And juror "<juror_number>" has "POSTCODE" as "<postcode>" new schema
	
	Then I see "Reply to a jury summons" on the page
	
	And the page title is "Are you replying for yourself or for someone else? - Reply to a jury summons - GOV.UK"
	
	Then I see "Are you replying for yourself or for someone else?" on the page
	
	When I set the radio button to "I am replying for myself"
	And I press the "Continue" button
	Then I see "Your juror details" on the page
	
	#Juror Log In
	When I set "9-digit juror number" to "<juror_number>"
	When I set "Juror last name" to "<last_name>"
	When I set "Juror postcode" to "<postcode>"
	And I press the "Continue" button
	Then I see "Is the name we have for you correct?" on the page
	And I choose the "Yes" radio button
	
	#Check name
	When I press the "Continue" button
	Then I see "Is this your address?" on the page
	And I choose the "Yes" radio button
	
	#Check address
	When I press the "Continue" button
	Then I see "What is your phone number?" on the page
	
	#Phone details
	When I set "Main phone" to "0207 821 1818"
	And I press the "Continue" button
	Then I see "What is your email address?" on the page
	
	#Email details
	When I set "Enter your email address" to "<email>"
	And I set "Enter your email address again" to "<email>"
	And I press the "Continue" button
	Then I see "What is your date of birth?" on the page
	
	#DoB
	When I set "Day" to "27"
	And I set "Month" to "04"
	And I set "Year" to "1981"
	And I press the "Continue" button
	
	Then I see "Confirm you're eligible for jury service" on the page
	
	When I press the "Continue" button
	
	#Residency JDB-3620
	Then I see "Since you turned 13, has your main address been in the UK, Channel Islands or Isle of Man for any period of at least 5 years?" on the page
	When I choose the "No" radio button
	And I see "You have 1,000 characters remaining" on the page
	And I set "Provide details" to "Not a resident"
	And I press the "Continue" button	
		
	#CJS no JDB-3625
	Then I see "Have you worked in the criminal justice system in the last 5 years?" on the page
	When I choose the "Yes" radio button
	And I check the "Other" checkbox
	And I see "You have 1,000 characters remaining" on the page
	And I set "Which other part of the Criminal Justice System?" to "Other CJS part"
	And I press the "Continue" button
	
	#Bail JDB-3623
	When I choose the "Yes" radio button
	And I see "You have 1,000 characters remaining" on the page
	And I set "Provide details" to "I am bailed"
	And I press the "Continue" button
	
	#Convictions JDB-3624
	Then I see "Have you been found guilty of a criminal offence?" on the page
	When I choose the "Yes" radio button
	And I see "You have 1,000 characters remaining" on the page
	And I set text area with "id" of "convictedDetails" to "I am convicted"
	And I press the "Continue" button
	
	#Mental health part 1 JDB-3621
	Then I see "Are you being detained, looked after or treated under the Mental Health Act?" on the page
	When I choose the "Yes" radio button
	And I see "You have 1,000 characters remaining" on the page
	And I set "Provide details" to "I am sectioned"
	And I press the "Continue" button
	
	#Mental health part 2 JDB-3622
	Then I see "Has it been decided that you 'lack mental capacity'?" on the page
	When I choose the "Yes" radio button
	And I see "You have 1,000 characters remaining" on the page
	And I set "Provide brief details about why it was decided you lack mental capacity" to "I lack capacity"
	And I press the "Continue" button
	
	#I can attend
	Then I see "Check your start date" on the page
	And I see "Yes, I can start on" on the page
	And I set the radio button to "Yes, I can start on"
	And  I press the "Continue" button
	
	#RA no JDB-3627 and JDB-3628
	Then I see "Will you need help when you're at the court?" on the page
	When I choose the "Yes" radio button
	And I see "You have 1,000 characters remaining" on the page
	And I set "Tell us about any special arrangements or help you need while you're doing jury service (optional)" to "Wheelchair user"
	When I check the "Other" checkbox
	And I set "Provide details" to "Other RA stuff"
	And I press the "Continue" button
	Then I see "Check your answers now" on the page
	
	#Check Your Answers
	When I click on the "Change" link in the same row as "Confirm the date of your jury service"
	Then I see "Check your start date" on the page
	
	And I see "No, I need to change the date" on the page
	And I set the radio button to "No, I need to change the date"
	And I press the "Continue" button
	Then I see "Tell us why you need another date for your jury service" on the page
	
	#Deferral Reason JDB-3626
	When I see "You have 1,000 characters remaining" on the page
	And I set text area with "id" of "deferralReason" to "Defer me please"
	And I press the "Continue" button
	Then I see "Choose 3 Mondays when you can start jury service" on the page
	
	#Deferral Dates
	When I set the "First" single date field to a Monday "6" weeks in the future
	When I set the "Second" single date field to a Monday "7" weeks in the future
	When I set the "Third" single date field to a Monday "8" weeks in the future
	
	And I press the "Continue" button
	
	#confirm
	When I choose the "Yes" radio button
	And I press the "Continue" button
	
	Then I see "Check your answers now" on the page
	
	#Check Your Answers
	When I click on the "Change" link in the same row as "Confirm the date of your jury service"
	Then I see "Check your start date" on the page
	
	When I set the radio button to "No, I cannot do jury service and need to be excused"
	And I press the "Continue" button
	Then I see "Why do you need to be excused from jury service?" on the page
	
	#Excusal Reason JDB-3618
	When I see "You have 1,000 characters remaining" on the page
	And I see "Explain why you cannot do jury service in the next 12 months." on the page
	And I see "You do not need to attach or gather evidence before your summons deadline." on the page
	And I see "We'll contact you later if we need this." on the page
	And I set text area with "id" of "excusalReason" to "Excuse me please"
	And I press the "Continue" button
	Then I see "Check your answers now" on the page
	
	#When I press the "Submit" button
	When I check the "The information I have given is true to the best of my knowledge" checkbox
	And I press the "Submit" button
	Then I see "We have sent you an email to say you have replied to your jury summons." on the page
	
Examples:
	| juror_number	| last_name	| postcode	| email           	| pool_number	|
	| 045200171		| DOE		| SW1H 9AJ	| email@outlook.com	| 452300156		|