Feature: Regression HTML Response Summary

@Regression
Scenario Outline: English_Max_Chars HTML Response Summary

	Given I am on "Public" "test"

	Given a bureau owned pool is created with jurors
		| court |juror_number  | pool_number	| att_date_weeks_in_future	| owner |
		| 452   |<juror_number>| <pool_number>	| 5				            | 400	|
		
	And juror "<juror_number>" has "LAST_NAME" as "<last_name>" new schema
	And juror "<juror_number>" has "FIRST_NAME" as "<first_name>" new schema
	And juror "<juror_number>" has "POSTCODE" as "<postcode>" new schema
	
	And I set the radio button to "I am replying for myself"
	And I press the "Continue" button
	Then I see "Your juror details" on the page
	
	When I set "9-digit juror number" to "<juror_number>"
	And I set "Juror last name" to "<last_name>"
	And I set "Juror postcode" to "<postcode>"
	And I press the "Continue" button
	Then I see "Is the name we have for you correct?" on the page
	When I choose the "Yes" radio button

	#name
	And I choose the "Yes" radio button
	When I press the "Continue" button
	
	#address
	Then I see "Is this your address?" on the page
	And I choose the "Yes" radio button
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

	#DOB
	Then I see "What is your date of birth?" on the page
	When I set the date of birth to a Monday "-1500" weeks in the future
	
	And I press the "Continue" button

	#Qualify for jury service
	Then I see "Confirm you're eligible for jury service" on the page
	When I press the "Continue" button
	
	#Residency
	Then I see "Since you turned 13, has your main address been in the UK, Channel Islands or Isle of Man for any period of at least 5 years?" on the page
	And I choose the "No" radio button
	And I set "Provide details about where you have lived since your 13th birthday" to "These are the details.These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are th"
	And I press the "Continue" button
	
	#CJS
	When I choose the "Yes" radio button
	And I check the "Other" checkbox
	And I set "Which other part of the Criminal Justice System?" to "These are the details.These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are th"
	And I press the "Continue" button
	
	#Bail
	And I choose the "Yes" radio button
	And I set "Provide details about your bail and criminal offence" to "These are the details.These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are th"
	And I press the "Continue" button
	
	#Convictions
	When I choose the "Yes" radio button
	And I set text area with "id" of "convictedDetails" to "These are the details.These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are th"
	And I press the "Continue" button
	
	#Mental Health Sectioned
	And I choose the "Yes" radio button
	And I set "Provide details about how you're being detained, looked after or treated under the Mental Health Act" to "These are the details.These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are th"
	And I press the "Continue" button 
	
	#Mental Health Capacity
	And I choose the "Yes" radio button
	And I set "Provide brief details about why it was decided you lack mental capacity" to "These are the details.These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are th"
	And I press the "Continue" button
	
	#I can attend
	And I see "Yes, I can start on" on the page
	And  I press the "Continue" button
	
	#confirm dates
	And I choose the "Yes" radio button
	And I press the "Continue" button
	
	#RA no
	When I choose the "Yes" radio button
	And I check the "Diabetes" checkbox
	And I set "Tell us about any special arrangements or help you need while you're doing jury service." to "These are the details.These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are th"
	And I press the "Continue" button
	Then I see "Check your answers now" on the page
	
	#Check your answers
	When I check the "The information I have given is true to the best of my knowledge" checkbox
	And I press the "Submit" button
	Then I see "We have sent you an email to say you have replied to your jury summons." on the page
	
	And I see "Download a copy of your summons reply HTML" on the page
	And I click on the "Download a copy of your summons reply HTML" link
	
	And I see "Copy of your jury summons reply" on the page
	And I see "<last_name>" in the same row as "Name"
	And I see "<juror_number>" in the same row as "Juror number"
	And I see "Your jury summons details" on the page
	And I see "THE CROWN COURT AT SHREWSBURY" in the same row as "Court"
	And I see "You have said that you can do jury service on the date shown." on the page
	And I see "What happens next" on the page
	And I see "Your answers mean that you might not be able to do jury service." on the page
	And I see "We will now check your answers. Then we'll write to you in the next 7 days to let you know if you must or must not do jury service" on the page
	And I see "We may also get in touch to talk about the help you need so you can do jury service." on the page
	And I see "If you are able to do jury service, at least 2 weeks before it starts we'll send you" on the page
	And I see "a letter confirming the date of your jury service" on the page
	And I see "an information pack about being a juror and the court you're going to" on the page
	And I see "How you replied" on the page
	And I see "You gave us these juror details" on the page
	And I see "<first_name> <last_name>" on the page
	And I see "02078211818" in the same row as "Main phone:"
	And I see "<email>" in the same row as "Email:"
	And I see "You answered the eligibility questions" on the page
	And I see "These are the details.These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are th" in the same row as "Since you turned 13, has your main address been in the UK, Channel Islands or Isle of Man for any period of at least 5 years?"
	And I see "These are the details.These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are th" in the same row as "Are you being detained, looked after or treated under the Mental Health Act?"
	And I see "These are the details.These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are th" in the same row as "Has it been decided that you 'lack mental capacity'?"
	And I see "These are the details.These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are th" in the same row as "Are you currently on bail for a criminal offence?"
	And I see "These are the details.These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are th" in the same row as "Have you been found guilty of a criminal offence?"
	And I see "You responded to the proposed date of your jury service" on the page
	And I see "I can do jury service on the date shown" in the same row as "Confirm the date of your jury service"
	And I see "Have you worked in the criminal justice system in the last 5 years?" on the page
	And I see "These are the details.These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are th" in the same row as "Have you worked in the criminal justice system in the last 5 years?"
	And I see "You told us about any help you'll need in court" on the page
	And I see "Yes" in the same row as "Do you have a disability or impairment that means you'll need extra support or facilities in the court building where you are doing your jury service?"
	And I see "These are the details.These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are th" in the same row as "Please tell us about any special arrangements or help you need while you're doing jury service."
	And I see "Getting ready for jury service" on the page
	And I see "The GOV.UK website has information to help you prepare for your jury service." on the page
	And I see "Visit https://www.gov.uk/jury-service to learn about:" on the page
	And I see "Taking time off work" on the page
	And I see "Discussing the trial" on the page
	And I see "What you can claim" on the page
	And I see "How to claim expenses" on the page
	And I see "Questions about jury service" on the page
	And I see "Contacting the Jury Central Summoning Bureau" on the page
	And I see "If you have any questions about your jury service, call the Jury Central Summoning Bureau." on the page
	And I see "Jury Central Summoning Bureau" on the page
	And I see "jurysummoning@justice.gov.uk" on the page
	And I see "Telephone: 0300 456 1024" on the page
	And I see "Monday to Thursday 9am to 5pm" on the page
	And I see "Friday 9am to 3pm" on the page
	And I see "Find out about call charges" on the page
	
	Then I press the "back" button on my browser
	Then I see "You have completed your reply" on the page
	And I see "Download a copy of your summons reply HTML" on the page	
	
Examples:
	| juror_number	| pool_number	| first_name| last_name	| postcode	| email 		|
	| 045200110		| 452300109		| John		| Doe		| SW1H 9AJ	| a@eeee.com	|

@Regression
Scenario Outline: English 1st Party Excusal HTML Response Summary

	Given I am on "Public" "test"

	Given a bureau owned pool is created with jurors
		| court |juror_number  | pool_number	| att_date_weeks_in_future	| owner |
		| 452   |<juror_number>| <pool_number>	| 5				            | 400	|
	
	And juror "<juror_number>" has "LAST_NAME" as "<last_name>" new schema
	And juror "<juror_number>" has "FIRST_NAME" as "<first_name>" new schema
	And juror "<juror_number>" has "ADDRESS_LINE_4" as "LONDON" new schema
	And juror "<juror_number>" has "POSTCODE" as "<postcode>" new schema
	
	And I set the radio button to "I am replying for myself"
	And I press the "Continue" button
	
	When I set "9-digit juror number" to "<juror_number>"
	When I set "Juror last name" to "<last_name>"
	When I set "Juror postcode" to "<postcode>"
	And I press the "Continue" button

	And I choose the "Yes" radio button
	And I press the "Continue" button
	
	And I choose the "Yes" radio button
	And I press the "Continue" button
	
	When I set "Main phone" to "02078211818"
	And I press the "Continue" button

	When I set "Enter your email address" to "<email>"
	When I set "Enter your email address again" to "<email>"
	And I press the "Continue" button
	
	When I set "Day" to "27"
	And I set "Month" to "04"
	And I set "Year" to "1981"
	And I press the "Continue" button
	And I press the "Continue" button
	Then I see "Since you turned 13, has your main address been in the UK, Channel Islands or Isle of Man for any period of at least 5 years?" on the page
	And I choose the "Yes" radio button
	And I press the "Continue" button
	When I choose the "No" radio button
	And I press the "Continue" button
	When I choose the "No" radio button
	And I press the "Continue" button
	When I choose the "No" radio button
	And I press the "Continue" button
	When I choose the "No" radio button
	And I press the "Continue" button
	When I choose the "No" radio button
	And I press the "Continue" button
	When I set the radio button to "No, I cannot do jury service and need to be excused"
	And I press the "Continue" button
	
	When I set text area with "id" of "excusalReason" to "Excuse me please"
	And I press the "Continue" button
	
	When I choose the "No" radio button
	And I press the "Continue" button

	Then I check the "The information I have given is true to the best of my knowledge" checkbox
	
	When I press the "Submit" button
	
	Then I see "You have completed your reply" on the page
	And I see "Download a copy of your summons reply HTML" on the page
	And I click on the "Download a copy of your summons reply HTML" link
	
	And I see "Copy of your jury summons reply" on the page
	And I see "<last_name>" in the same row as "Name"
	And I see "<juror_number>" in the same row as "Juror number"
	And I see "Your jury summons details" on the page
	And I see "THE CROWN COURT AT SHREWSBURY" in the same row as "Court"
	And I see "You have said that you cannot do jury service and would like to be excused." on the page
	And I see "What happens next" on the page
	And I see "We'll write to you within the next 7 days to let you know if you must do jury service or if you can be excused." on the page
	And I see "If you must do jury service, at least 2 weeks before it starts we'll send you:" on the page
	And I see "a letter confirming the date of your jury service" on the page
	And I see "an information pack about being a juror and the court you're going to" on the page
	And I see "How you replied" on the page
	And I see "You gave us these juror details" on the page
	And I see "<first_name> <last_name>" on the page
	And I see "27 April 1981" in the same row as "Date of Birth:"
	And I see "02078211818" in the same row as "Main phone:"
	And I see "<email>" in the same row as "Email:"
	And I see "You answered the eligibility questions" on the page
	And I see "Yes" in the same row as "Since you turned 13, has your main address been in the UK, Channel Islands or Isle of Man for any period of at least 5 years?"
	And I see "No" in the same row as "Are you being detained, looked after or treated under the Mental Health Act?"
	And I see "No" in the same row as "Has it been decided that you 'lack mental capacity'?"
	And I see "No" in the same row as "Are you currently on bail for a criminal offence?"
	And I see "No" in the same row as "Have you been found guilty of a criminal offence?"
	And I see "You responded to the proposed date of your jury service" on the page
	And I see "I cannot do jury service and would like to be excused" in the same row as "Confirm the date of your jury service"
	And I see "Because you asked to be excused from jury service, you told us" on the page
	And I see "Excuse me please" in the same row as "Why do you need to be excused from jury service?"
	And I see "No" in the same row as "Have you worked in the criminal justice system in the last 5 years?"
	And I see "You told us about any help you'll need in court" on the page
	And I see "No" in the same row as "Do you have a disability or impairment that means you'll need extra support or facilities in the court building where you are doing your jury service?"
	And I do not see "Please tell us about any special arrangements or help you need while you're doing jury service." on the page
	And I see "Getting ready for jury service" on the page
	And I see "The GOV.UK website has information to help you prepare for your jury service." on the page
	And I see "Visit https://www.gov.uk/jury-service to learn about:" on the page
	And I see "Taking time off work" on the page
	And I see "Discussing the trial" on the page
	And I see "What you can claim" on the page
	And I see "How to claim expenses" on the page
	And I see "Questions about jury service" on the page
	And I see "Contacting the Jury Central Summoning Bureau" on the page
	And I see "If you have any questions about your jury service, call the Jury Central Summoning Bureau." on the page
	And I see "Jury Central Summoning Bureau" on the page
	And I see "jurysummoning@justice.gov.uk" on the page
	And I see "Telephone: 0300 456 1024" on the page
	And I see "Monday to Thursday 9am to 5pm" on the page
	And I see "Friday 9am to 3pm" on the page
	And I see "Find out about call charges" on the page
	
	Then I press the "back" button on my browser
	Then I see "You have completed your reply" on the page
	And I see "Download a copy of your summons reply HTML" on the page	
	
Examples:
	| juror_number	| pool_number	| first_name| last_name	| postcode	| email 		|
	| 045200111		| 452300110		| John		| Doe		| SW1H 9AJ	| a@eeee.com	|

@Regression
Scenario Outline: English 1st Party Deferral HTML Response Summary

	Given I am on "Public" "ithc"

	Given a bureau owned pool is created with jurors
		| court |juror_number  | pool_number	| att_date_weeks_in_future	| owner |
		| 452   |<juror_number>| <pool_number>	| 5				            | 400	|
	
	And juror "<juror_number>" has "LAST_NAME" as "<last_name>" new schema
	And juror "<juror_number>" has "FIRST_NAME" as "<first_name>" new schema
	And juror "<juror_number>" has "ADDRESS_LINE_4" as "LONDON" new schema
	And juror "<juror_number>" has "POSTCODE" as "<postcode>" new schema
	
	And I set the radio button to "I am replying for myself"
	And I press the "Continue" button
	
	When I set "9-digit juror number" to "<juror_number>"
	When I set "Juror last name" to "<last_name>"
	When I set "Juror postcode" to "<postcode>"
	And I press the "Continue" button

	And I choose the "Yes" radio button
	And I press the "Continue" button
	
	And I choose the "Yes" radio button
	And I press the "Continue" button
	
	When I set "Main phone" to "02078211818"
	And I press the "Continue" button

	When I set "Enter your email address" to "<email>"
	When I set "Enter your email address again" to "<email>"
	And I press the "Continue" button
	
	When I set "Day" to "27"
	And I set "Month" to "04"
	And I set "Year" to "1981"
	And I press the "Continue" button
	And I press the "Continue" button
	Then I see "Since you turned 13, has your main address been in the UK, Channel Islands or Isle of Man for any period of at least 5 years?" on the page
	And I choose the "Yes" radio button
	And I press the "Continue" button
	When I choose the "No" radio button
	And I press the "Continue" button
	When I choose the "No" radio button
	And I press the "Continue" button
	When I choose the "No" radio button
	And I press the "Continue" button
	When I choose the "No" radio button
	And I press the "Continue" button
	When I choose the "No" radio button
	And I press the "Continue" button
	And I see "No, I need to change the date" on the page
	When I set the radio button to "No, I need to change the date"
	And I press the "Continue" button
	
	When I set text area with "id" of "deferralReason" to "Deferral Reason"
	And I press the "Continue" button
	
	When I set the "First" single date field to a Monday "6" weeks in the future
	When I set the "Second" single date field to a Monday "7" weeks in the future
	When I set the "Third" single date field to a Monday "8" weeks in the future

	And I press the "Continue" button
	
	#confirm dates
	
	And I choose the "Yes" radio button
	And I press the "Continue" button
	
	#help in court
	When I choose the "No" radio button
	And I press the "Continue" button

	Then I check the "The information I have given is true to the best of my knowledge" checkbox
	
	When I press the "Submit" button
	
	#JDB-4553
	Then I see "at least 2 weeks before your jury service starts, we'll send you:" on the page
	
	Then I see "You have completed your reply" on the page
	And I see "Download a copy of your summons reply HTML" on the page
	And I click on the "Download a copy of your summons reply HTML" link
	
	And I see "Copy of your jury summons reply" on the page
	And I see "<last_name>" in the same row as "Name"
	And I see "<juror_number>" in the same row as "Juror number"
	And I see "Your jury summons details" on the page
	And I see "THE CROWN COURT AT SHREWSBURY" in the same row as "Court"
	And I see "You have said that you need to change the date of your jury service." on the page
	And I see "What happens next" on the page
	And I see "We'll write to you within the next 7 days to let you know if you can change the date of your jury service." on the page
	And I see "Then, at least 2 weeks before your jury service starts, we'll send you:" on the page
	And I see "a letter confirming the date of your jury service" on the page
	And I see "an information pack about being a juror and the court you're going to" on the page
	And I see "How you replied" on the page
	And I see "You gave us these juror details" on the page
	And I see "<first_name> <last_name>" on the page
	And I see "27 April 1981" in the same row as "Date of Birth:"
	And I see "02078211818" in the same row as "Main phone:"
	And I see "<email>" in the same row as "Email:"
	And I see "You answered the eligibility questions" on the page
	And I see "Yes" in the same row as "Since you turned 13, has your main address been in the UK, Channel Islands or Isle of Man for any period of at least 5 years?"
	And I see "No" in the same row as "Are you being detained, looked after or treated under the Mental Health Act?"
	And I see "No" in the same row as "Has it been decided that you 'lack mental capacity'?"
	And I see "No" in the same row as "Are you currently on bail for a criminal offence?"
	And I see "No" in the same row as "Have you been found guilty of a criminal offence?"
	And I see "You responded to the proposed date of your jury service" on the page
	And I see "I need to change the date of my jury service" in the same row as "Confirm the date of your jury service"
	And I see "No" in the same row as "Have you worked in the criminal justice system in the last 5 years?"
	And I see "You told us about any help you'll need in court" on the page
	And I see "No" in the same row as "Do you have a disability or impairment that means you'll need extra support or facilities in the court building where you are doing your jury service?"
	And I do not see "Please tell us about any special arrangements or help you need while you're doing jury service." on the page
	And I see "Getting ready for jury service" on the page
	And I see "The GOV.UK website has information to help you prepare for your jury service." on the page
	And I see "Visit https://www.gov.uk/jury-service to learn about:" on the page
	And I see "Taking time off work" on the page
	And I see "Discussing the trial" on the page
	And I see "What you can claim" on the page
	And I see "How to claim expenses" on the page
	And I see "Questions about jury service" on the page
	And I see "Contacting the Jury Central Summoning Bureau" on the page
	And I see "If you have any questions about your jury service, call the Jury Central Summoning Bureau." on the page
	And I see "Jury Central Summoning Bureau" on the page
	And I see "jurysummoning@justice.gov.uk" on the page
	And I see "Telephone: 0300 456 1024" on the page
	And I see "Monday to Thursday 9am to 5pm" on the page
	And I see "Friday 9am to 3pm" on the page
	And I see "Find out about call charges" on the page
	
	Then I press the "back" button on my browser
	Then I see "You have completed your reply" on the page
	And I see "Download a copy of your summons reply HTML" on the page	
	
Examples:
	| juror_number	| pool_number	| first_name| last_name	| postcode	| email 		|
	| 045200112		| 452300111		| John		| Doe		| SW1H 9AJ	| a@eeee.com	|
	
@RegressionWelsh
Scenario Outline: Welsh 1st Party Straight Through (welsh court)

	Given I am on the welsh version of "Public" "test"

	Given a bureau owned pool is created with jurors
		| court |juror_number  | pool_number	| att_date_weeks_in_future	| owner |
		| 452   |<juror_number>| <pool_number>	| 5				            | 400	|

	And juror "<juror_number>" has "LAST_NAME" as "<last_name>" new schema
	And juror "<juror_number>" has "FIRST_NAME" as "<first_name>" new schema
	And juror "<juror_number>" has "POSTCODE" as "<postcode>" new schema

	And I set the radio button to "n ymateb dros fy hun"
	And I press the "Parhau" button
	Then I see "Eich manylion rheithiwr" on the page

	When I set "Rhif rheithiwr" to "<juror_number>"
	When I set "Cyfenw" to "<last_name>"
	When I set "Cod post Rheithiwr" to "<postcode>"
	And I press the "Parhau" button
	
	#Check Your Name
	And I set the radio button to "Ydy"
	And I press the "Parhau" button

	#Address
	And I set the radio button to "Ie"
	When I press the "Parhau" button
	
	#Phone
	When I set "Prif rif ffôn" to "0207 821 1818"
	And I press the "Parhau" button
	
	#Email
	And I set "Nodwch eich cyfeiriad e-bost" to "<email>"
	And I set "Nodwch eich cyfeiriad e-bost eto" to "<email>"
	And I press the "Parhau" button
	
	#DoB
	When I set "Diwrnod" to "27"
	And I set "Mis" to "04"
	And I set "Blwyddyn" to "1978"
	And I press the "Parhau" button
	
	#Qualify for jury service
	When I press the "Parhau" button

	#Residency
	And I set the radio button to "Do"
	And I press the "Parhau" button

	#CJS
	When I set the radio button to "Nac ydw"
	And I press the "Parhau" button
	
	#Bail
	And I set the radio button to "Nac ydw"
	And I press the "Parhau" button
	
	#Convictions
	When I set the radio button to "Naddo"
	And I press the "Parhau" button
	
	#Mental Health Sectioned
	And I set the radio button to "Na"
	And I press the "Parhau" button
	
	#Mental Health Capacity
	And I set the radio button to "Na"
	And I press the "Parhau" button
	
	#Confirm attendance
	When I set the radio button to "Ydw, rydw i'n gallu dechrau"
	And I press the "Parhau" button
	
	#RA
	When I set the radio button to "Nac oes"
	And I press the "Parhau" button

	#submit
	And I check the "Mae'r wybodaeth a roddais uchod yn wir hyd eithaf fy ngwybodaeth." checkbox
	And I press the "Cyflwyno" button
	
	And I see "Lawrlwythwch gopi o'ch ymateb i'r wŷs HTML" on the page
	And I click on the "Lawrlwythwch gopi o'ch ymateb i'r wŷs HTML" link
	
	And I see "Copi o’ch ymateb i wŷs rheithgor" on the page
	And I see "<last_name>" in the same row as "Enw"
	And I see "<juror_number>" in the same row as "Rhif rheithiwr"
	And I see "Manylion eich gwŷs rheithgor" on the page
	And I see "THE CROWN COURT AT SHREWSBURY" in the same row as "Llys"
	And I see "Rydych wedi dweud eich bod yn gallu gwasanaethu ar reithgor ar y dyddiad a nodir" on the page
	And I see "Beth fydd yn digwydd nesaf?" on the page
	And I see "O leiaf 2 wythnos cyn ichi ddechrau gwasanaethu ar reithgor, byddwn yn anfon y canlynol atoch:" on the page
	And I see "llythyr yn cadarnhau dyddiad eich gwasanaeth rheithgor" on the page
	And I see "pecyn gwybodaeth am fod yn rheithiwr a'r llys byddwch yn mynd iddo" on the page
	And I see "Sut wnaethoch ymateb" on the page
	And I see "Bu i chi roi’r manylion rheithiwr a ganlyn" on the page
	And I see "<first_name> <last_name>" in the same row as "Enw"
	And I see "27 Ebrill 1978" in the same row as "Dyddiad Geni:"
	And I see "0207 821 1818" in the same row as "Prif rif ffôn:"
	And I see "<email>" in the same row as "E-bost:"
	And I see "Mi wnaethoch ateb y cwestiynau cymhwysedd" on the page
	And I see "Do" in the same row as "Ers i chi droi'n 13 oed, a yw eich prif gyfeiriad wedi bod yn y DU, Ynysoedd y Sianel neu Ynys Manaw am unrhyw gyfnod o 5 mlynedd o leiaf?"
	And I see "Nac ydw" in the same row as "A ydych chi wedi gweithio yn y system cyfiawnder troseddol yn y 5 mlynedd diwethaf?"
	And I see "Na" in the same row as "Ydych chi'n cael eich cadw, yn cael eich gwarchod neu eich trin o dan y Ddeddf Galluedd Meddyliol?"
	And I see "Nac ydw" in the same row as "Ydych chi ar fechnïaeth ar hyn o bryd am gyflawni trosedd?"
	And I see "Naddo" in the same row as "Ydych chi wedi'ch cael yn euog o drosedd?"
	And I see "Gallaf wasanaethu ar reithgor ar y dyddiad a nodir" on the page
	And I see "Bu ichi ddweud wrthym am unrhyw gymorth y byddwch ei angen yn y llys" on the page
	And I see "Nac oes" in the same row as "A oes gennych anabledd neu nam sy’n golygu bydd angen cymorth neu gyfleusterau ychwanegol arnoch yn yr adeilad llys ble fyddwch yn cyflawni eich gwasanaeth rheithgor?"
	And I see "Paratoi ar gyfer eich gwasanaeth rheithgor" on the page
	And I see "Mae gan wefan GOV.UK wybodaeth i’ch helpu chi baratoi ar gyfer eich gwasanaeth rheithgor" on the page
	And I see "Ewch i https://www.gov.uk/jury-service i ddysgu am:" on the page
	And I see "Cymryd amser i ffwrdd o’r gwaith" on the page
	And I see "Trafod y treial" on the page
	And I see "Sut i hawlio treuliau" on the page
	And I see "Cwestiynau am wasanaeth rheithgor" on the page
	And I see "Cysylltu gyda Swyddfa Ganolog Gwysio Rheithgor" on the page
	And I see "Os oes gennych unrhyw gwestiynau am eich gwasanaeth rheithgor, ffoniwch Swyddfa Ganolog Gwysio Rheithgor" on the page
	And I see "Swyddfa Ganolog Gwysio Rheithgor" on the page
	And I see "jurysummoning@justice.gov.uk" on the page
	And I see "Rhif ffôn: 0300 456 1024" on the page
	And I see "Llinell Gymraeg: 0300 303 5173" on the page
	And I see "Dydd Llun i ddydd Iau, 9am tan 5pm" on the page
	And I see "Dydd Gwener, 9am tan 3pm" on the page
	And I see "Canfod mwy am gostau galwadau" on the page
	
	Then I press the "back" button on my browser
	And I see "Lawrlwythwch gopi o'ch ymateb i'r wŷs HTML" on the page	
	
Examples:
	| juror_number	| pool_number	| first_name| last_name	| postcode	| email 		|
	| 045200113		| 452300112		| John		| Doe		| SW1H 9AJ	| a@eeee.com	|

@Regression
Scenario Outline: English 3rd Party Deferral HTML Response summary

	Given I am on "Public" "ithc"

	Given a bureau owned pool is created with jurors
		| court |juror_number  | pool_number	| att_date_weeks_in_future	| owner |
		| 452   |<juror_number>| <pool_number>	| 5				            | 400	|
		
	And juror "<juror_number>" has "LAST_NAME" as "<last_name>" new schema
	And juror "<juror_number>" has "FIRST_NAME" as "<first_name>" new schema
	And juror "<juror_number>" has "POSTCODE" as "<postcode>" new schema
	
	And I set the radio button to "I am replying for someone else"
	And I press the "Continue" button
	
	#Juror Log In
	When I set "9-digit juror number" to "<juror_number>"
	When I set "Juror last name" to "<last_name>"
	When I set "Juror postcode" to "<postcode>"
	And I press the "Continue" button
	
	#3rd Party Name
	When I see "Your Details" on the page
	When I set "First name" to "FirstNameA"
	And I set "Last name" to "LastNameB"
	And I press the "Continue" button
	
	#Relationship to juror
	And I set "How do you know the person you're replying for?" to "Friend"
	And I press the "Continue" button
	
	#3rd Party Contact
	And I check the "By phone (UK Numbers only)" checkbox
	And I set "Main phone" to "0207 821 1818"
	And I check the "By email" checkbox
	And I set "Enter your email address" to "<email>"
	And I set "Enter your email address again" to "<email>"
	And I press the "Continue" button
	
	#Why are you replying title
	When I set the radio button to "The person is not here"
	And I press the "Continue" button
	
	#Check juror name
	And I choose the "Yes" radio button
	And I press the "Continue" button
	
	#Check juror address
	And I choose the "Yes" radio button
	And I press the "Continue" button
	
	#DoB
	And I set "Day" to "01"
	And I set "Month" to "01"
	And I set "Year" to "1988"
	And I press the "Continue" button

	#Contacting the juror
	And I set the radio button to "Use the phone number that you have already given to contact you"
	And I set the radio button to "Use the email address that you have already given to contact you"
	And I press the "Continue" button

	#Qualify for jury service
	And I press the "Continue" button

	#Residency
	And I choose the "Yes" radio button
	And I press the "Continue" button

	# Have you ever worked
	When I choose the "No" radio button
	And I press the "Continue" button
	
	#Bail
	And I choose the "No" radio button
	And I press the "Continue" button
	
	#Convictions
	And I choose the "No" radio button
	And I press the "Continue" button
	
	#Mental Health Sectioned
	And I choose the "No" radio button
	And I press the "Continue" button
	
	#Mental Health Capacity
	And I choose the "No" radio button
	And I press the "Continue" button
	
	#Confirm Date of Jury
	When I set the radio button to "No, we need to change the date" 
	And I press the "Continue" button
	
	#Deferral Reason
	When I set text area with "id" of "deferralReason" to "Deferral Reason"
	And I press the "Continue" button
	
	#JDB-3445 Deferral Date Screen Layout
	When I set the "First" single date field to a Monday "6" weeks in the future
	When I set the "Second" single date field to a Monday "7" weeks in the future
	When I set the "Third" single date field to a Monday "8" weeks in the future

	And I press the "Continue" button

	#confirm dates
	When I choose the "Yes" radio button
	And I press the "Continue" button
	
	#help in court
	When I choose the "No" radio button
	And I press the "Continue" button
	
	Then I see "Check your answers now" on the page
	
	When I check the "The answers I have given for the person I'm replying for are true as far as I know" checkbox
	And I press the "Submit" button
	
	Then I see "You have completed your reply" on the page
	And I see "Download a copy of your summons reply HTML" on the page
	And I click on the "Download a copy of your summons reply HTML" link
	
	And I see "Copy of your jury summons reply" on the page
	And I see "<last_name>" in the same row as "Name"
	And I see "<juror_number>" in the same row as "Juror number"
	And I see "Your jury summons details" on the page
	And I see "THE CROWN COURT AT SHREWSBURY" in the same row as "Court"
	And I see "You have said that you need to change the date of your jury service." on the page
	And I see "What happens next" on the page
	And I see "We'll write to you within the next 7 days to let you know if you can change the date of your jury service." on the page
	And I see "Then, at least 2 weeks before your jury service starts, we'll send you:" on the page
	And I see "a letter confirming the date of your jury service" on the page
	And I see "an information pack about being a juror and the court you're going to" on the page
	
	And I see "How you replied" on the page
	And I see "You gave us these details about the person you're replying for" on the page
	And I see "<first_name> <last_name>" on the page
	And I see "1 January 1988" in the same row as "Date of Birth:"
	
	And I see "You're replying for another person called for jury service. You told us this about yourself" on the page
	And I see "FirstNameA LastNameB" in the same row as "Your name:"
	And I see "Friend" in the same row as "Your relationship to the summoned:"
	And I see "0207 821 1818" in the same row as "Your main phone number:"
	And I see "<email>" in the same row as "Your email address:"
	And I see "The person is not here" in the same row as "Your reason for replying on behalf of the juror:"
	
	And I see "You answered the eligibility questions for the person you're replying for" on the page
	And I see "Yes" in the same row as "Since they turned 13, has their main address been in the UK, Channel Islands or Isle of Man for any period of at least 5 years?"
	And I see "No" in the same row as "Is the person you're replying for being detained, looked after or treated under the Mental Health Act?"
	And I see "No" in the same row as "Has it been decided that the person you're replying for 'lacks mental capacity'?"
	And I see "No" in the same row as "Is the person currently on bail for a criminal offence?"
	And I see "No" in the same row as "Has the person been found guilty of a criminal offence?"
	
	And I see "You responded to the proposed date of the jury service" on the page
	And I see "I need to change the date of jury service for the person I'm answering for" in the same row as "Confirm the date of their jury service"
	
	And I see "As you asked for the person to do jury service on a different date you told us" on the page
	And I see "Deferral Reason" on the page
	
	And I see "No" in the same row as "Has the person you're replying for worked in the criminal justice system in the last 5 years?"
	
	And I see "You told us about any help the person you're replying for needs in court" on the page
	And I see "No" in the same row as "Does the person have a disability or impairment that means they'll need extra support or facilities in the court building where they are doing jury service?"
	And I do not see "Please tell us about any special arrangements or help the person you're answering for needs while they're doing jury service." on the page
	
	And I see "Getting ready for jury service" on the page
	And I see "The GOV.UK website has information to help you prepare for your jury service." on the page
	And I see "Visit https://www.gov.uk/jury-service to learn about:" on the page
	And I see "Taking time off work" on the page
	And I see "Discussing the trial" on the page
	And I see "What you can claim" on the page
	And I see "How to claim expenses" on the page
	And I see "Questions about jury service" on the page
	
	And I see "Contacting the Jury Central Summoning Bureau" on the page
	And I see "If you have any questions about your jury service, call the Jury Central Summoning Bureau." on the page
	And I see "jurysummoning@justice.gov.uk" on the page
	And I see "Telephone: 0300 456 1024" on the page
	And I see "Monday to Thursday 9am to 5pm" on the page
	And I see "Friday 9am to 3pm" on the page
	And I see "Find out about call charges" on the page

	Then I press the "back" button on my browser
	Then I see "You have completed your reply" on the page
	And I see "Download a copy of your summons reply HTML" on the page	
	
Examples:
	| juror_number	| pool_number	| first_name| last_name	| postcode	| email 		|
	| 045200114		| 452300113		| John		| Doe		| SW1H 9AJ	| a@eeee.com	|
	
@Regression
Scenario Outline: English 1st Party Overage HTML Response Summary

	Given I am on "Public" "ithc"

	Given a bureau owned pool is created with jurors
		| court |juror_number  | pool_number	| att_date_weeks_in_future	| owner |
		| 452   |<juror_number>| <pool_number>	| 5				            | 400	|
		
	And juror "<juror_number>" has "LAST_NAME" as "<last_name>" new schema
	And juror "<juror_number>" has "FIRST_NAME" as "<first_name>" new schema
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
	When I choose the "Yes" radio button
	
	#Moving past Name Section
	When I press the "Continue" button
	Then I see "Is this your address?" on the page
	When I choose the "Yes" radio button
	
	When I press the "Continue" button
	Then I see "What is your phone number?" on the page
	
	When I set "Main phone" to "02078211818"
	And I press the "Continue" button
	Then I see "What is your email address?" on the page
	
	When I set "Enter your email address" to "<email>"
	And I set "Enter your email address again" to "<email>"
	And I press the "Continue" button
	
	#On DoB Screen
	Then I see "What is your date of birth?" on the page
	
	When I set "Day" to "27"
	And I set "Month" to "04"
	And I set "Year" to "1940"
	
	#Moving past DoB Section
	And I press the "Continue" button
	Then I see "Is your date of birth correct?" on the page
	
	Then I choose the "Yes" radio button

	And I press the "Continue" button
	Then I see "Check your answers now" on the page
	And I see text "27 April 1940" in the same row as "Date of birth"

	Then I check the "The information I have given is true to the best of my knowledge" checkbox
	When I press the "Submit" button
	
	Then I see "You have completed your reply" on the page
	Then I see "<juror_number>" on the page
	
	#HTML Response Summary
	Then I see "You have completed your reply" on the page
	And I see "Download a copy of your summons reply HTML" on the page
	And I click on the "Download a copy of your summons reply HTML" link
	
	And I see "Copy of your jury summons reply" on the page
	And I see "<last_name>" in the same row as "Name"
	And I see "<juror_number>" in the same row as "Juror number"
	And I see "Your jury summons details" on the page
	And I see "THE CROWN COURT AT SHREWSBURY" in the same row as "Court"
	And I see "Your age makes you ineligible to do jury service." on the page
	And I see "What happens next" on the page
	And I see "By law, jurors must be aged 18 to 75. You do not have to do jury service because you are younger than 18 or older than 75." on the page
	And I see "We'll write to confirm that you do not have to do jury service." on the page
	And I see "You do not need to do anything else." on the page
	
	And I see "How you replied" on the page
	And I see "You gave us these juror details" on the page
	And I see "<first_name> <last_name>" on the page
	And I see "27 April 1940" in the same row as "Date of Birth:"
	And I see "02078211818" in the same row as "Main phone:"
	And I see "<email>" in the same row as "Email:"
	
	And I do not see "Getting ready for jury service" on the page
	And I do not see "Taking time off work" on the page
	And I see "Contacting the Jury Central Summoning Bureau" on the page
	And I see "If you have any questions about this, call the Jury Central Summoning Bureau." on the page
	
	Then I press the "back" button on my browser
	Then I see "You have completed your reply" on the page
	And I see "Download a copy of your summons reply HTML" on the page	
	
Examples:
	| juror_number	| pool_number	| first_name| last_name	| postcode	| email 		|
	| 045200115		| 452300114		| John		| Doe		| SW1H 9AJ	| a@eeee.com	|

@Regression
Scenario Outline: English 3rd Deceased HTML Response Summary

	Given I am on "Public" "test"

	Given a bureau owned pool is created with jurors
		| court |juror_number  | pool_number	| att_date_weeks_in_future	| owner |
		| 452   |<juror_number>| <pool_number>	| 5				            | 400	|

	And juror "<juror_number>" has "LAST_NAME" as "<last_name>" new schema
	And juror "<juror_number>" has "ADDRESS_LINE_4" as "LONDON" new schema
	And juror "<juror_number>" has "POSTCODE" as "<postcode>" new schema
	
	#Reply to jury summons
	Then I see "Reply to a jury summons" on the page

	And I set the radio button to "I am replying for someone else"
	And I press the "Continue" button
	Then I see "Their juror details" on the page
	
	#Login
	When I set "9-digit juror number" to "<juror_number>"
	When I set "Juror last name" to "<last_name>"
	When I set "Juror postcode" to "<postcode>"
	And I press the "Continue" button
	Then I see "What is your name?" on the page
	
	#3rd Party Name
	When I set "First name" to "FirstName"
	And I set "Last name" to "LastName"
	And I press the "Continue" button
	
	#Relationship to Juror
	When I set "How do you know the person you're replying for?" to "Friend"
	And I press the "Continue" button
	
	#3rd Party Contact
	When I check the "By phone (UK Numbers only)" checkbox
	And I check the "By email" checkbox
	And I set "Main phone" to "02078211818"
	And I set "Enter your email address" to "<email>"
	And I set "Enter your email address again" to "<email>"
	And I press the "Continue" button
	
	#Why Are You Replying
	When I set the radio button to "The person has died"
	And I press the "Continue" button
	
	#Check Your Answers Now
	When I check the "The answers I have given for the person I'm replying for are true as far as I know" checkbox
	And I press the "Submit" button
	Then I see "You have completed your reply" on the page
	
	#HTML Response Summary
	Then I see "You have completed your reply" on the page
	And I see "Download a copy of your summons reply HTML" on the page
	And I click on the "Download a copy of your summons reply HTML" link
	
	And I see "Copy of your jury summons reply" on the page
	And I see "<last_name>" in the same row as "Name"
	And I see "<juror_number>" in the same row as "Juror number"
	And I see "Your jury summons details" on the page
	And I see "THE CROWN COURT AT SHREWSBURY" in the same row as "Court"
	And I see "You have said that the person summoned is deceased." on the page
	And I see "What happens next" on the page
	And I see "You do not need to do anything else." on the page
	And I see "We're sorry for any distress" on the page
	And I see "Jurors are selected at random from the electoral roll. This is not always completely up to date. That's why we sent a jury summons to this person. We do apologise for this and hope it has not caused too much distress." on the page
	
	And I do not see "How you replied" on the page
	And I do not see "Getting ready for jury service" on the page
	And I do not see "Taking time off work" on the page
	And I do not see "Discussing the trial" on the page
	And I see "Contacting the Jury Central Summoning Bureau" on the page
	And I see "If you have any questions about this, call the Jury Central Summoning Bureau." on the page
	And I see "jurysummoning@justice.gov.uk" on the page
	And I see "Telephone: 0300 456 1024" on the page
	And I see "Monday to Thursday 9am to 5pm" on the page
	And I see "Friday 9am to 3pm" on the page
	And I see "Find out about call charges" on the page
	
	Then I press the "back" button on my browser
	Then I see "You have completed your reply" on the page
	And I see "Download a copy of your summons reply HTML" on the page	

Examples:
	| juror_number	| pool_number| last_name| postcode	| email 		|
	| 045200116		| 452300115	 | DOE		| SW1H 9AJ	| e@eeee.com	|

@Regression
Scenario Outline: English 1st ST HTML Check

	Given I am on "Public" "test"

	Given a bureau owned pool is created with jurors
		| court |juror_number  | pool_number	| att_date_weeks_in_future	| owner |
		| 452   |<juror_number>| <pool_number>	| 5				            | 400	|

	And juror "<juror_number>" has "LAST_NAME" as "<last_name>" new schema
	And juror "<juror_number>" has "FIRST_NAME" as "<first_name>" new schema
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
	When I choose the "No" radio button
	And I press the "Continue" button
		
	#Check Answers
	Then I see "Check your answers now" on the page
	
	Then I check the "The information I have given is true to the best of my knowledge" checkbox
	
	When I press the "Submit" button

	#Confirmation
	Then I see "You have completed your reply" on the page
	And I see "Download a copy of your summons reply HTML" on the page
	And I click on the "Download a copy of your summons reply HTML" link
	
	And I see "Copy of your jury summons reply" on the page
	And I see "<last_name>" in the same row as "Name"
	And I see "<juror_number>" in the same row as "Juror number"
	And I see "Your jury summons details" on the page
	And I see "THE CROWN COURT AT SHREWSBURY" in the same row as "Court"
	And I see "You have said that you can do jury service on the date shown." on the page
	And I see "What happens next" on the page
	And I see "At least 2 weeks before your jury service starts, we'll send you:" on the page
	And I see "a letter confirming the date of your jury service" on the page
	And I see "an information pack about being a juror and the court you're going to" on the page
	And I see "How you replied" on the page
	And I see "You gave us these juror details" on the page
	And I see "<first_name> <last_name>" on the page
	And I see "27 April 1981" in the same row as "Date of Birth:"
	And I see "02078211818" in the same row as "Main phone:"
	And I see "<email>" in the same row as "Email:"
	And I see "You answered the eligibility questions" on the page
	And I see "Yes" in the same row as "Since you turned 13, has your main address been in the UK, Channel Islands or Isle of Man for any period of at least 5 years?"
	And I see "No" in the same row as "Are you being detained, looked after or treated under the Mental Health Act?"
	And I see "No" in the same row as "Has it been decided that you 'lack mental capacity'?"
	And I see "No" in the same row as "Are you currently on bail for a criminal offence?"
	And I see "No" in the same row as "Have you been found guilty of a criminal offence?"
	And I see "You responded to the proposed date of your jury service" on the page
	And I see "I can do jury service on the date shown" in the same row as "Confirm the date of your jury service"
	And I see "No" in the same row as "Have you worked in the criminal justice system in the last 5 years?"
	And I see "You told us about any help you'll need in court" on the page
	And I see "No" in the same row as "Do you have a disability or impairment that means you'll need extra support or facilities in the court building where you are doing your jury service?"
	And I do not see "Please tell us about any special arrangements or help you need while you're doing jury service." on the page
	And I see "Getting ready for jury service" on the page
	And I see "The GOV.UK website has information to help you prepare for your jury service." on the page
	And I see "Visit https://www.gov.uk/jury-service to learn about:" on the page
	And I see "Taking time off work" on the page
	And I see "Discussing the trial" on the page
	And I see "What you can claim" on the page
	And I see "How to claim expenses" on the page
	And I see "Questions about jury service" on the page
	And I see "Contacting the Jury Central Summoning Bureau" on the page
	And I see "If you have any questions about your jury service, call the Jury Central Summoning Bureau." on the page
	
	Then I press the "back" button on my browser
	Then I see "You have completed your reply" on the page
	And I see "Download a copy of your summons reply HTML" on the page	
	
Examples:
	| juror_number	| pool_number	| first_name| last_name	| postcode	| email 		|
	| 045200117		| 452300116		| JOHN		| DOE		| SW1H 9AJ	| e@eeee.com	|

@Regression
Scenario Outline: English 1st Ineligible HTML Check

	Given I am on "Public" "test"

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
	When I choose the "No" radio button
	And I press the "Continue" button
	And I set "First name" to "<first_name>"
	And I set "Last name" to "<last_name>"
	And I press the "Continue" button
	
	#address
	Then I see "Is this your address?" on the page
	When I choose the "Yes" radio button
	And I press the "Continue" button
	
	#phone
	Then I see "What is your phone number?" on the page
	When I set "Main phone" to "02078211818"
	And I set "Another phone" to "09999999999"
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
	
	And I choose the "No" radio button
	And I set "Provide details about where you have lived since your 13th birthday" to "Residency"
	And I press the "Continue" button	
	And I choose the "Yes" radio button
	And I check the "Police service" checkbox
	And I set "Which police service?" to "London Police Service"
	And I press the "Continue" button
	And I choose the "Yes" radio button
	And I set "Provide details about your bail and criminal offence" to "Bail"
	And I press the "Continue" button
	And I choose the "Yes" radio button
	When I set text area with "id" of "convictedDetails" to "Criminal Convictions"
	And I press the "Continue" button
	And I choose the "Yes" radio button
	And I set "Provide details about how you're being detained, looked after or treated under the Mental Health Act" to "Mental Health Sectioned"
	And I press the "Continue" button
	And I choose the "Yes" radio button
	And I set "Provide brief details about why it was decided you lack mental capacity" to "Mental Health Capacity"
	And I press the "Continue" button
	
	#confirm date
	And I see "No, I need to change the date" on the page
	When I set the radio button to "No, I need to change the date"
	And I press the "Continue" button
	
	When I set text area with "id" of "deferralReason" to "Deferral Reason"
	And I press the "Continue" button
	
	When I set the "First" single date field to a Monday "9" weeks in the future
	When I set the "Second" single date field to a Monday "10" weeks in the future
	When I set the "Third" single date field to a Monday "11" weeks in the future

	And I press the "Continue" button
	
	#confirm
	And I choose the "Yes" radio button
	And I press the "Continue" button
	
	#Help in court
	And I choose the "Yes" radio button
	And I check the "Diabetes" checkbox
	Then I set "Tell us about any special arrangements or help you need while you're doing jury service." to "Special Need is DIABETES"
	And I press the "Continue" button
		
	#Check Answers
	Then I see "Check your answers now" on the page
	
	Then I check the "The information I have given is true to the best of my knowledge" checkbox
	
	When I press the "Submit" button

	#Confirmation
	Then I see "You have completed your reply" on the page
	And I see "Download a copy of your summons reply HTML" on the page
	And I click on the "Download a copy of your summons reply HTML" link
	And I see "Copy of your jury summons reply" on the page
	And I see "<last_name>" in the same row as "Name"
	And I see "<juror_number>" in the same row as "Juror number"
	And I see "Your jury summons details" on the page
	And I see "THE CROWN COURT AT SHREWSBURY" in the same row as "Court"
	And I see "You have said that you need to change the date of your jury service." on the page
	And I see "What happens next?" on the page
	And I see "Your answers mean that you might not be able to do jury service. We will now check your answers." on the page
	And I see "We may also get in touch to talk about the help you need so you can do jury service, and whether you are able to be excused." on the page
	And I see "We'll be in touch within the next 7 days." on the page
	And I see "If you are able to do jury service, at least 2 weeks before it starts we'll send you" on the page
	And I see "a letter confirming the date of your jury service" on the page
	And I see "an information pack about being a juror and the court you're going to" on the page
	And I see "How you replied" on the page
	And I see "You gave us these juror details" on the page
	And I see "<first_name> <last_name>" on the page
	And I see "27 April 1981" in the same row as "Date of Birth:"
	And I see "02078211818" in the same row as "Main phone:"
	And I see "09999999999" in the same row as "Another phone (optional):"
	And I see "<email>" in the same row as "Email:"
	And I see "You answered the eligibility questions" on the page
	And I see "No" in the same row as "Since you turned 13, has your main address been in the UK, Channel Islands or Isle of Man for any period of at least 5 years?"
	And I see "Yes" in the same row as "Are you being detained, looked after or treated under the Mental Health Act?"
	And I see "Yes" in the same row as "Has it been decided that you 'lack mental capacity'?"
	And I see "Yes" in the same row as "Are you currently on bail for a criminal offence?"
	And I see "Yes" in the same row as "Have you been found guilty of a criminal offence?"
	And I see "You responded to the proposed date of your jury service" on the page
	And I see "I need to change the date of my jury service" in the same row as "Confirm the date of your jury service"
	And I see "Deferral Reason" on the page
	And I see "Yes" in the same row as "Have you worked in the criminal justice system in the last 5 years?"
	And I see "You told us about any help you'll need in court" on the page
	And I see "Yes" in the same row as "Do you have a disability or impairment that means you'll need extra support or facilities in the court building where you are doing your jury service?"
	And I see "Special Need is DIABETES" in the same row as "Please tell us about any special arrangements or help you need while you're doing jury service."
	And I see "Getting ready for jury service" on the page
	And I see "The GOV.UK website has information to help you prepare for your jury service." on the page
	And I see "Visit https://www.gov.uk/jury-service to learn about:" on the page
	And I see "Taking time off work" on the page
	And I see "Discussing the trial" on the page
	And I see "What you can claim" on the page
	And I see "How to claim expenses" on the page
	And I see "Questions about jury service" on the page
	And I see "Contacting the Jury Central Summoning Bureau" on the page
	And I see "If you have any questions about your jury service, call the Jury Central Summoning Bureau." on the page
	
	Then I press the "back" button on my browser
	Then I see "You have completed your reply" on the page
	And I see "Download a copy of your summons reply HTML" on the page	
	
Examples:
	| juror_number	| pool_number	| first_name	| last_name	| postcode	| email 		|
	| 045200118		| 452300117		| Sarah-Louise	| DOE		| SW1H 9AJ	| e@eeee.com	|