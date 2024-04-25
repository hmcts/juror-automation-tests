Feature: Regression English_1st_Deferral

@Regression @NewSchemaConverted
Scenario Outline: English 1st Party Deferral

	Given I am on "Public" "test"

	Given a bureau owned pool is created with jurors
		| court |juror_number  | pool_number	| att_date_weeks_in_future	| owner |
		| 452   |<juror_number>| <pool_number>	| 5				            | 400	|
	
	And juror "<juror_number>" has "LAST_NAME" as "<last_name>" new schema
	And juror "<juror_number>" has "FIRST_NAME" as "FNAMESEVENONETHREE" new schema
	And juror "<juror_number>" has "ADDRESS_LINE_1" as "855 STREET NAME" new schema
	And juror "<juror_number>" has "ADDRESS_LINE_4" as "LONDON" new schema
	And juror "<juror_number>" has "POSTCODE" as "<postcode>" new schema

	And I have deleted all holidays new schema
	
	Then I see "Reply to a jury summons" on the page
	
	And I set the radio button to "I am replying for myself"
	And I press the "Continue" button
	Then I see "Your juror details" on the page
	
	When I set "9-digit juror number" to "<juror_number>"
	When I set "Juror last name" to "<last_name>"
	When I set "Juror postcode" to "<postcode>"
	And I press the "Continue" button
	
	Then I see "Is the name we have for you correct?" on the page
	And I choose the "Yes" radio button
	And I press the "Continue" button
	
	And I choose the "Yes" radio button
	And I press the "Continue" button
	
	When I set "Main phone" to "02078211818"
	And I press the "Continue" button

	When I set "Enter your email address" to "<email>"
	When I set "Enter your email address again" to "<email>"
	And I press the "Continue" button
	
	When I set the date of birth to a Monday "-1560" weeks in the future
	And I press the "Continue" button
	
	Then I see "Confirm you're eligible for jury service" on the page
	
	And I press the "Continue" button
	
	Then I see "Since you turned 13, has your main address been in the UK, Channel Islands or Isle of Man for any period of at least 5 years?" on the page
	And I choose the "Yes" radio button
	And I press the "Continue" button
	
	Then I see "Have you worked in the criminal justice system in the last 5 years?" on the page
	Then I see "Have you worked in the criminal justice system in the last 5 years?" on the page
	When I choose the "No" radio button
	And I press the "Continue" button
	
	Then I see "bail" on the page
	And I see "Are you currently on bail for a criminal offence?" on the page
	When I choose the "No" radio button
	And I press the "Continue" button
	
	Then I see "Have you been found guilty of a criminal offence?" on the page
	When I choose the "No" radio button
	And I press the "Continue" button
	
	Then I see "Mental Health" on the page
	And I see "Are you being detained, looked after or treated under the Mental Health Act?" on the page
	When I choose the "No" radio button
	And I press the "Continue" button
	
	Then I see "Has it been decided that you 'lack mental capacity'?" on the page
	When I choose the "No" radio button
	And I press the "Continue" button
	
	#New deferrals
	
	Then I see "Check your start date" on the page
	And I see "You are summoned to start jury service on" on the page
	And I see "Can you start jury service on this date?" on the page
	And I see "Yes, I can start on" on the page
	And I see "and serve for at least 2 weeks" on the page
	And I see "No, I need to change the date" on the page
	And I see "No, I cannot do jury service and need to be excused" on the page
	
	When I set the radio button to "No, I need to change the date"
	And I press the "Continue" button
	
	And I see "steps/confirm-date/deferral-reason" in the URL
	And I see "Tell us why you need another date for your jury service" on the page
	And I see "You must have a good reason for changing, for example:" on the page
	And I see "a booked holiday" on the page
	And I see "an operation" on the page
	And I see "an exam" on the page
	And I see "your employer will not give you time off work" on the page
	When I set text area with "id" of "deferralReason" to "Deferral Reason"
	And I press the "Continue" button
	
	And I see "steps/confirm-date/deferral-dates" in the URL
	Then I see "Choose 3 Mondays when you can start jury service" on the page
	And I see "These must be between" on the page
	And I see "You must be available to serve at least 2 weeks." on the page

	When I set the "First" single date field to a Monday "16" weeks in the future
	When I set the "Second" single date field to a Monday "17" weeks in the future
	When I set the "Third" single date field to a Monday "18" weeks in the future
	
	And I press the "Continue" button
	
	#check dates screen
	
	And I see "Check your dates" on the page
	And I see "Dates you can start jury service" on the page
	
	And I validate the "First" deferral date is "16" weeks in the future
	And I validate the "Second" deferral date is "17" weeks in the future
	And I validate the "Third" deferral date is "18" weeks in the future
	
	And I see "You do not need to tell us all other dates you're available." on the page
	And I see "We'll choose one of your 3 dates." on the page
	And I see "In the unlikely event that we cannot use one of these dates, we'll contact you." on the page
	And I see "Do you want to proceed with these dates?" on the page
	
	#check hint text
	
	And I click on the "Will I need to serve longer than 2 weeks?" link
	And I see "Most jurors only need to serve 2 weeks." on the page
	And I see "You may be asked to serve for longer when you arrive at court." on the page
	And I see "If you cannot serve for more than 2 weeks, you'll be able to discuss this with the jury manager at court." on the page
	
	And I click on the "What if there's a problem nearer the time and I cannot serve?" link
	And I see "You must contact us at that time to let us know." on the page
	
	And I click on the "Will I need to serve longer than 2 weeks?" link
	And I do not see "Most jurors only need to serve 2 weeks." on the page
	And I do not see "You may be asked to serve for longer when you arrive at court." on the page
	And I do not see "If you cannot serve for more than 2 weeks, you'll be able to discuss this with the jury manager at court." on the page
	
	And I click on the "What if there's a problem nearer the time and I cannot serve?" link
	And I do not see "You must contact us at that time to let us know." on the page

	And I choose the "Yes" radio button
	And I press the "Continue" button

	Then I see "Will you need help when you're at the court?" on the page
	Then I see "Do you have a disability or impairment that means you’ll need extra support or facilities in the court building where you are doing your Jury Service?" on the page
	When I choose the "No" radio button
	And I press the "Continue" button
	Then I see "Check your answers now" on the page
	
	When I click on the "Change" link in the same row as "Email"
	And I set "Enter your email address" to "abc@abc.com"
	And I press the "Continue" button
	Then I see "Enter your email address and check that it matches the one in the first field" on the page
	When I set "Enter your email address" to "<email>"
	And I press the "Continue" button
	
	And on the page I see
	|text|
	|Choose 3 Mondays when you can start jury service|
	|First choice|
	|Second choice|
	|Third choice|

	And I validate the "First" deferral date is "16" weeks in the future
	And I validate the "Second" deferral date is "17" weeks in the future
	And I validate the "Third" deferral date is "18" weeks in the future

	Then I check the "The information I have given is true to the best of my knowledge" checkbox
	
	When I press the "Submit" button
	
	Then I see "You have completed your reply" on the page
	Then I see "<juror_number>" on the page
	
	Then I see "You have completed your reply" on the page
	Then I see "If we get in touch with you, you may need to give your juror number. It's also on the letter we sent you." on the page
	Then I see "We have sent you an email to say you have replied to your jury summons." on the page
	Then I see "Download a copy of your summons reply" on the page
	Then I see "We'll write to you within the next 7 days to let you know if you can change the date of your jury service." on the page
	Then I see "Then, at least 2 weeks before your jury service starts, we'll send you:" on the page
	And I see "a letter confirming the date of your jury service" on the page
	And I see "an information pack about being a juror and the court you're going to" on the page
	And I see "Get ready for your jury service" on the page
	And I see "The information below is also in the email that we have sent you." on the page
	And I see "You can watch this video on YouTube about what happens when you're a juror, so you know what to expect. The video takes 13 minutes to watch." on the page
	And I see "Learn more about your jury service. You can read the rules about discussing the trial and find out how to claim expenses." on the page
	And I see "Calculate what expenses and allowances you can claim." on the page
	And I do not see "Your Guide to Jury Service (PDF 85KB)" on the page
	And I see "What did you think of this service? (Takes 30 seconds)" on the page
	
	Then on "JUROR_MOD" . "JUROR_RESPONSE" I see "PROCESSING_STATUS" is "TODO" where "JUROR_NUMBER" is "<juror_number>"
	Then on "JUROR_MOD" . "JUROR_RESPONSE" I see "PROCESSING_COMPLETE" is "N" where "JUROR_NUMBER" is "<juror_number>"
	
	Then I click on the "Download a copy of your summons reply HTML (15KB)" link
	And I see "You have said that you need to change the date of your jury service." on the page
	And I see "We'll write to you within the next 7 days to let you know if you can change the date of your jury service." on the page
	And I see "I need to change the date of my jury service" on the page
	And I see "Tell us why you need another date for your jury service" on the page
	And I see "Deferral Reason" on the page
	And I see "Choose 3 Mondays when you can start jury service" on the page
	And I see "First choice" on the page
	And I see "Second choice" on the page
	And I see "Third choice" on the page
	And I validate the "First" deferral date is "16" weeks in the future
	And I validate the "Second" deferral date is "17" weeks in the future
	And I validate the "Third" deferral date is "18" weeks in the future
	
	Given I am on "Bureau" "btest"
	And I log in as "MODTESTBUREAU"
	
	When I click on the "Search" link
	And I set "Juror number" to "<juror_number>"
	And I press the "Search" button
	Then I see "<juror_number>" on the page
	
	And I click link with ID "selectAllLink"
	And I press the "Send to..." button
	And I set input field with "id" of "sendToOfficer" to "CPASS"
	And I press the "Send" button
	And I press the "Send" button
	Then I see "Your work" on the page
	
	Then I click on the "Sign out" link
	When I log in as "CPASS"
	Then I see "<juror_number>" on the page
	Then I see "<juror_number>" has reply type indicator "DEFERRAL"

	When I click on "<juror_number>" in the same row as "<juror_number>"
	
	And I see "Juror details" on the page
	
	When I select "Deferral request" from Process reply
	
	And I select "O - OTHER" from the "Reason for the deferral request" dropdown
	And I select the first deferral choice

	And I press the "Continue" button
	
	Then I see the juror record updated banner containing "Deferral granted (other)"
	
	Then on "JUROR_MOD" . "JUROR_RESPONSE" I see "PROCESSING_STATUS" is "CLOSED" where "JUROR_NUMBER" is "<juror_number>"
	Then on "JUROR_MOD" . "JUROR_RESPONSE" I see "PROCESSING_COMPLETE" is "Y" where "JUROR_NUMBER" is "<juror_number>"
	
	Then on "JUROR_MOD" . "JUROR" I see "H_PHONE" is "02078211818" where "JUROR_NUMBER" is "<juror_number>"
	Then on "JUROR_MOD" . "JUROR" I see "H_EMAIL" is "<email>" where "JUROR_NUMBER" is "<juror_number>"
	
	#JDB-3453
	
	Then on "JUROR_MOD" . "JUROR" I see "WELSH" is null where "JUROR_NUMBER" is "<juror_number>"
	
Examples:
	|juror_number	|pool_number|last_name			|postcode	|email 		|
	|045200014		|452300010	|LNAMEFIVETWOZERO	|SY2 6LU	|e@eeee.com	|
	
@Regression @NewSchemaConverted
Scenario Outline: English 1st Party Deferral - do not accept dates

	Given I am on "Public" "test"

	Given a bureau owned pool is created with jurors
		| court |juror_number  | pool_number	| att_date_weeks_in_future	| owner |
		| 452   |<juror_number>| <pool_number>	| 5				            | 400	|
	
	And juror "<juror_number>" has "LAST_NAME" as "<last_name>" new schema
	And juror "<juror_number>" has "ADDRESS_LINE_1" as "855 STREET NAME" new schema
	And juror "<juror_number>" has "ADDRESS_LINE_4" as "LONDON" new schema
	And juror "<juror_number>" has "POSTCODE" as "<postcode>" new schema
	And I have deleted all holidays new schema
	
	Then I see "Reply to a jury summons" on the page
	
	And I set the radio button to "I am replying for myself"
	And I press the "Continue" button
	Then I see "Your juror details" on the page
	
	When I set "9-digit juror number" to "<juror_number>"
	When I set "Juror last name" to "<last_name>"
	When I set "Juror postcode" to "<postcode>"
	And I press the "Continue" button
	
	Then I see "Is the name we have for you correct?" on the page
	And I choose the "Yes" radio button
	
	When I press the "Continue" button
	
	And I choose the "Yes" radio button
	And I press the "Continue" button
	
	Then I see "What is your phone number?" on the page
	When I set "Main phone" to "02078211818"
	And I press the "Continue" button
	
	Then I see "What is your email address?" on the page
	When I set "Enter your email address" to "<email>"
	When I set "Enter your email address again" to "<email>"
	And I press the "Continue" button
	
	Then I see "What is your date of birth" on the page
	
	When I set the date of birth to a Monday "-1560" weeks in the future
	And I press the "Continue" button
	
	Then I see "Confirm you're eligible for jury service" on the page
	
	And I press the "Continue" button
	
	Then I see "Since you turned 13, has your main address been in the UK, Channel Islands or Isle of Man for any period of at least 5 years?" on the page
	And I choose the "Yes" radio button
	And I press the "Continue" button
	
	Then I see "Have you worked in the criminal justice system in the last 5 years?" on the page
	Then I see "Have you worked in the criminal justice system in the last 5 years?" on the page
	When I choose the "No" radio button
	And I press the "Continue" button
	
	Then I see "bail" on the page
	And I see "Are you currently on bail for a criminal offence?" on the page
	When I choose the "No" radio button
	And I press the "Continue" button
	
	Then I see "Have you been found guilty of a criminal offence?" on the page
	When I choose the "No" radio button
	And I press the "Continue" button
	
	Then I see "Mental Health" on the page
	And I see "Are you being detained, looked after or treated under the Mental Health Act?" on the page
	When I choose the "No" radio button
	And I press the "Continue" button
	
	Then I see "Has it been decided that you 'lack mental capacity'?" on the page
	When I choose the "No" radio button
	And I press the "Continue" button
	
	#New deferrals
	
	#select deferral
	
	Then I see "Check your start date" on the page
	And I see "You are summoned to start jury service on" on the page
	And I see "Can you start jury service on this date?" on the page
	And I see "Yes, I can start on" on the page
	And I see "and serve for at least 2 weeks" on the page
	And I see "No, I need to change the date" on the page
	And I see "No, I cannot do jury service and need to be excused" on the page
	
	When I set the radio button to "No, I need to change the date"
	And I press the "Continue" button
	
	#enter reason
	
	And I see "steps/confirm-date/deferral-reason" in the URL
	And I see "Tell us why you need another date for your jury service" on the page
	And I see "You must have a good reason for changing, for example:" on the page
	And I see "a booked holiday" on the page
	And I see "an operation" on the page
	And I see "an exam" on the page
	And I see "your employer will not give you time off work" on the page
	When I set text area with "id" of "deferralReason" to "Deferral Reason"
	And I press the "Continue" button
	
	#input def dates
	
	And I see "steps/confirm-date/deferral-dates" in the URL
	Then I see "Choose 3 Mondays when you can start jury service" on the page
	And I see "These must be between" on the page
	And I see "You must be available to serve at least 2 weeks." on the page

	When I set the "First" single date field to a Monday "17" weeks in the future
	When I set the "Second" single date field to a Monday "18" weeks in the future
	When I set the "Third" single date field to a Monday "19" weeks in the future
	
	And I press the "Continue" button
	
	#check def dates
	
	And I see "Check your dates" on the page
	And I see "Dates you can start jury service" on the page
	And I validate the "First" deferral date is "17" weeks in the future
	And I validate the "Second" deferral date is "18" weeks in the future
	And I validate the "Third" deferral date is "19" weeks in the future

	
	And I see "You do not need to tell us all other dates you're available." on the page
	And I see "We'll choose one of your 3 dates." on the page
	And I see "In the unlikely event that we cannot use one of these dates, we'll contact you." on the page
	And I see "Do you want to proceed with these dates?" on the page
	
	#check hint text
	
	And I click on the "Will I need to serve longer than 2 weeks?" link
	And I see "Most jurors only need to serve 2 weeks." on the page
	And I see "You may be asked to serve for longer when you arrive at court." on the page
	And I see "If you cannot serve for more than 2 weeks, you'll be able to discuss this with the jury manager at court." on the page
	
	And I click on the "What if there's a problem nearer the time and I cannot serve?" link
	And I see "You must contact us at that time to let us know." on the page
	
	And I click on the "Will I need to serve longer than 2 weeks?" link
	And I do not see "Most jurors only need to serve 2 weeks." on the page
	And I do not see "You may be asked to serve for longer when you arrive at court." on the page
	And I do not see "If you cannot serve for more than 2 weeks, you'll be able to discuss this with the jury manager at court." on the page
	
	And I click on the "What if there's a problem nearer the time and I cannot serve?" link
	And I do not see "You must contact us at that time to let us know." on the page
	
	#do not accept dates
	
	And I choose the "No" radio button
	And I press the "Continue" button

	#change dates
	
	And I see "steps/confirm-date/deferral-dates" in the URL
	When I set the "First" single date field to a Monday "20" weeks in the future
	
	And I press the "Continue" button
	
	#accept dates
	
	And I see "Check your dates" on the page
	And I see "Dates you can start jury service" on the page
	And I validate the "First" deferral date is "20" weeks in the future
	And I validate the "Second" deferral date is "18" weeks in the future
	And I validate the "Third" deferral date is "19" weeks in the future
	
	And I choose the "Yes" radio button
	And I press the "Continue" button
	
	#help in court
	
	Then I see "Will you need help when you're at the court?" on the page
	Then I see "Do you have a disability or impairment that means you’ll need extra support or facilities in the court building where you are doing your Jury Service?" on the page
	When I choose the "No" radio button
	And I press the "Continue" button
	Then I see "Check your answers now" on the page
	
	When I click on the "Change" link in the same row as "Email"
	And I set "Enter your email address" to "abc@abc.com"
	And I press the "Continue" button
	Then I see "Enter your email address and check that it matches the one in the first field" on the page
	When I set "Enter your email address" to "<email>"
	And I press the "Continue" button
	
	Then I see text "Yes" in the same row as "Since you turned 13, has your main address been in the UK, Channel Islands or Isle of Man for any period of at least 5 years?"
	And I validate the "First" deferral date is "20" weeks in the future
	And I validate the "Second" deferral date is "18" weeks in the future
	And I validate the "Third" deferral date is "19" weeks in the future
	
	Then I check the "The information I have given is true to the best of my knowledge" checkbox
	
	When I press the "Submit" button
	
	Then I see "You have completed your reply" on the page
	Then I see "<juror_number>" on the page
	
	Then I see "You have completed your reply" on the page
	Then I see "If we get in touch with you, you may need to give your juror number. It's also on the letter we sent you." on the page
	Then I see "We have sent you an email to say you have replied to your jury summons." on the page
	Then I see "Download a copy of your summons reply" on the page
	Then I see "We'll write to you within the next 7 days to let you know if you can change the date of your jury service." on the page
	Then I see "Then, at least 2 weeks before your jury service starts, we'll send you:" on the page
	And I see "a letter confirming the date of your jury service" on the page
	And I see "an information pack about being a juror and the court you're going to" on the page
	And I see "Get ready for your jury service" on the page
	And I see "The information below is also in the email that we have sent you." on the page
	And I see "You can watch this video on YouTube about what happens when you're a juror, so you know what to expect. The video takes 13 minutes to watch." on the page
	And I see "Learn more about your jury service. You can read the rules about discussing the trial and find out how to claim expenses." on the page
	And I see "Calculate what expenses and allowances you can claim." on the page
	And I do not see "Your Guide to Jury Service (PDF 85KB)" on the page
	And I see "What did you think of this service? (Takes 30 seconds)" on the page
	
	Then I click on the "Download a copy of your summons reply HTML (15KB)" link
	And I see "You have said that you need to change the date of your jury service." on the page
	And I see "We'll write to you within the next 7 days to let you know if you can change the date of your jury service." on the page
	And I see "I need to change the date of my jury service" on the page
	And I see "Tell us why you need another date for your jury service" on the page
	And I see "Deferral Reason" on the page
	And I see "Choose 3 Mondays when you can start jury service" on the page
	And I see "First choice" on the page
	And I see "Second choice" on the page
	And I see "Third choice" on the page
	And I validate the "First" deferral date is "20" weeks in the future
	And I validate the "Second" deferral date is "18" weeks in the future
	And I validate the "Third" deferral date is "19" weeks in the future
	
	Then on "JUROR_MOD" . "JUROR_RESPONSE" I see "PROCESSING_STATUS" is "TODO" where "JUROR_NUMBER" is "<juror_number>"
	Then on "JUROR_MOD" . "JUROR_RESPONSE" I see "PROCESSING_COMPLETE" is "N" where "JUROR_NUMBER" is "<juror_number>"
	
	Given I am on "Bureau" "test"
	And I log in as "MODTESTBUREAU"
	
	When I click on the "Search" link
	And I set "Juror number" to "<juror_number>"
	And I press the "Search" button
	
	When I click on "<juror_number>" in the same row as "<juror_number>"
	
	And I see "Juror details" on the page
	
	When I select "Deferral" from Process reply
	
	And I select "O - OTHER" from the "Reason for the deferral request" dropdown
	And I select the first deferral choice
	
	And I press the "Continue" button
	Then I see the juror record updated banner containing "Deferral granted (other)"
	
	Then on "JUROR_MOD" . "JUROR_RESPONSE" I see "PROCESSING_STATUS" is "CLOSED" where "JUROR_NUMBER" is "<juror_number>"
	Then on "JUROR_MOD" . "JUROR_RESPONSE" I see "PROCESSING_COMPLETE" is "Y" where "JUROR_NUMBER" is "<juror_number>"
	
	Then on "JUROR_MOD" . "JUROR" I see "H_PHONE" is "02078211818" where "JUROR_NUMBER" is "<juror_number>"
	Then on "JUROR_MOD" . "JUROR" I see "H_EMAIL" is "<email>" where "JUROR_NUMBER" is "<juror_number>"
	
	#JDB-3453
	
	Then on "JUROR_MOD" . "JUROR" I see "WELSH" is null where "JUROR_NUMBER" is "<juror_number>"
	
	Examples:
	|juror_number	|pool_number|last_name			|postcode	|email 		|
	|045200015		|452300011	|LNAMESEVENONETHREE	|SW1H 9AJ	|e@eeee.com	|
	
@RegressionSingle @NewSchemaConverted
Scenario Outline: 1st English Deferral (Duplicate?)

	Given I am on "Public" "test"

	Given a bureau owned pool is created with jurors
		| court |juror_number  | pool_number	| att_date_weeks_in_future	| owner |
		| 452   |<juror_number>| <pool_number>	| 5				            | 400	|
		
	And juror "<juror_number>" has "LAST_NAME" as "<last_name>" new schema
	And juror "<juror_number>" has "POSTCODE" as "<postcode>" new schema
	And I have deleted all holidays new schema
	
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
	And I choose the "Yes" radio button
	
	#Check Name
	When I press the "Continue" button
	Then I see "Is this your address?" on the page
	And I choose the "Yes" radio button
	
	#Check Address
	And I press the "Continue" button
	Then I see "What is your phone number?" on the page
	
	#Phone Details
	When I set "Main phone" to "0207 821 1818"
	And I press the "Continue" button
	Then I see "What is your email address?" on the page
	
	#Email
	When I set "Enter your email address" to "<email>"
	And I set "Enter your email address again" to "<email>"
	And I press the "Continue" button
	Then I see "What is your date of birth?" on the page
	
	#DoB
	When I set the date of birth to a Monday "-1560" weeks in the future
	And I press the "Continue" button
	Then I see "Confirm you're eligible for jury service" on the page
	
	When I press the "Continue" button
	
	#Residency
	Then I see "Since you turned 13, has your main address been in the UK, Channel Islands or Isle of Man for any period of at least 5 years?" on the page
	When I choose the "Yes" radio button
	And I press the "Continue" button
	
	#CJS
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
	
	#New deferrals
	Then I see "Check your start date" on the page
	And I see "You are summoned to start jury service on" on the page
	And I see "Can you start jury service on this date?" on the page
	And I see "Yes, I can start on" on the page
	And I see "and serve for at least 2 weeks" on the page
	And I see "No, I need to change the date" on the page
	And I see "No, I cannot do jury service and need to be excused" on the page
	
	When I set the radio button to "No, I need to change the date"
	And I press the "Continue" button
	
	#reason
	And I see "steps/confirm-date/deferral-reason" in the URL
	And I see "Tell us why you need another date for your jury service" on the page
	And I see "You must have a good reason for changing, for example:" on the page
	And I see "a booked holiday" on the page
	And I see "an operation" on the page
	And I see "an exam" on the page
	And I see "your employer will not give you time off work" on the page
	When I set text area with "id" of "deferralReason" to "Deferral Reason"
	And I press the "Continue" button
	
	#dates
	And I see "steps/confirm-date/deferral-dates" in the URL
	Then I see "Choose 3 Mondays when you can start jury service" on the page
	And I see "These must be between" on the page
	And I see "You must be available to serve at least 2 weeks." on the page

	When I set the "First" single date field to a Monday "19" weeks in the future
	When I set the "Second" single date field to a Monday "20" weeks in the future
	When I set the "Third" single date field to a Monday "21" weeks in the future

	And I press the "Continue" button
	
	#check dates
	And I see "Check your dates" on the page
	And I see "Dates you can start jury service" on the page
	And I validate the "First" deferral date is "19" weeks in the future
	And I validate the "Second" deferral date is "20" weeks in the future
	And I validate the "Third" deferral date is "21" weeks in the future
	
	And I choose the "Yes" radio button
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
	
	Given I am on "Bureau" "test"
	And I log in as "MODTESTBUREAU"
	And I click on the "Search" link
	And I set "Juror number" to "<juror_number>"
	And I press the "Search" button
	And I click on "<juror_number>" in the same row as "<juror_number>"
	And I click on the "Deferral or excusal" link
	
	Then I see "Deferral Reason" on the page
	
Examples:
	| juror_number	| last_name				| postcode	| email           	| pool_number	|
	| 045200016		| LNAMESEVENFIVETHREE	| CH1 2AN	| email@outlook.com	| 452300012		|
	
@Regression @NewSchemaConverted
Scenario Outline: 1st English Deferral with Bureau Check

	Given I am on "Public" "test"

	Given a bureau owned pool is created with jurors
		| court |juror_number  | pool_number	| att_date_weeks_in_future	| owner |
		| 452   |<juror_number>| <pool_number>	| 5				            | 400	|
	
	And juror "<juror_number>" has "LAST_NAME" as "<last_name>" new schema
	And juror "<juror_number>" has "POSTCODE" as "<postcode>" new schema
	And I have deleted all holidays new schema
	
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
	And I choose the "Yes" radio button
	
	#Check Name
	When I press the "Continue" button
	Then I see "Is this your address?" on the page
	And I choose the "Yes" radio button
	
	#Check Address
	And I press the "Continue" button
	Then I see "What is your phone number?" on the page
	
	#Phone Details
	When I set "Main phone" to "0207 821 1818"
	And I press the "Continue" button
	Then I see "What is your email address?" on the page
	
	#Email
	When I set "Enter your email address" to "<email>"
	And I set "Enter your email address again" to "<email>"
	And I press the "Continue" button
	Then I see "What is your date of birth?" on the page
	
	#DoB
	When I set the date of birth to a Monday "-1560" weeks in the future
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
	
	#New deferrals
	Then I see "Check your start date" on the page
	And I see "You are summoned to start jury service on" on the page
	And I see "Can you start jury service on this date?" on the page
	And I see "Yes, I can start on" on the page
	And I see "and serve for at least 2 weeks" on the page
	And I see "No, I need to change the date" on the page
	And I see "No, I cannot do jury service and need to be excused" on the page
	
	When I set the radio button to "No, I need to change the date"
	And I press the "Continue" button
	
	#reason
	And I see "steps/confirm-date/deferral-reason" in the URL
	And I see "Tell us why you need another date for your jury service" on the page
	And I see "You must have a good reason for changing, for example:" on the page
	And I see "a booked holiday" on the page
	And I see "an operation" on the page
	And I see "an exam" on the page
	And I see "your employer will not give you time off work" on the page
	When I set text area with "id" of "deferralReason" to "Deferral Reason"
	And I press the "Continue" button
	
	#choose dates
	And I see "steps/confirm-date/deferral-dates" in the URL
	Then I see "Choose 3 Mondays when you can start jury service" on the page
	And I see "These must be between" on the page
	And I see "You must be available to serve at least 2 weeks." on the page

	When I set the "First" single date field to a Monday "9" weeks in the future
	When I set the "Second" single date field to a Monday "10" weeks in the future
	When I set the "Third" single date field to a Monday "11" weeks in the future

	And I press the "Continue" button
	
	#confirm dates
	And I see "steps/confirm-date/deferral-check" in the URL
	And I see "Check your dates" on the page
	And I see "Dates you can start jury service" on the page
	And I validate the "First" deferral date is "9" weeks in the future
	And I validate the "Second" deferral date is "10" weeks in the future
	And I validate the "Third" deferral date is "11" weeks in the future

	And I choose the "Yes" radio button
	And I press the "Continue" button
	
	Then I see "Will you need help when" on the page
	When I choose the "No" radio button
	And I press the "Continue" button
	
	Then I see "Check your answers now" on the page
	
	When I check the "The information" checkbox
	And I press the "Submit" button
	And I see "You have completed your reply" on the page
	
	Given I am on "Bureau" "bau-test"
	And I log in as "MODTESTBUREAU"
	And I click on the "Search" link
	And I set "Juror number" to "<juror_number>"
	And I press the "Search" button
	And I click on "<juror_number>" in the same row as "<juror_number>"
	And I click on the "Deferral or excusal" link
	
	Then I see "Deferral Reason" on the page
	
	Then I see "First choice" on the page
	Then I see "Second choice" on the page
	Then I see "Third choice" on the page
	And I validate the "First" deferral date is "9" weeks in the future
	And I validate the "Second" deferral date is "10" weeks in the future
	And I validate the "Third" deferral date is "11" weeks in the future
	
	When I select "Deferral" from Process reply
	When I select "S - RECENTLY SERVED" from the "Reason for the deferral request" dropdown
	And I select the first deferral choice
	
	And I press the "Continue" button
	And I see the juror record updated banner containing "Deferral granted (recently served)"

Examples:
	|juror_number	|last_name	|postcode	|email           	|pool_number|
	|045200017		|LNAME21	|CH1 2AN	|email@outlook.com	|452300013	|
	
@Regression @NewSchemaConverted
Scenario Outline: 1st English Back Button Logic with Deferral Reason Screen

	Given I am on "Public" "test"

	Given a bureau owned pool is created with jurors
		| court |juror_number  | pool_number	| att_date_weeks_in_future	| owner |
		| 452   |<juror_number>| <pool_number>	| 5				            | 400	|
		
	And juror "<juror_number>" has "LAST_NAME" as "<last_name>" new schema
	And juror "<juror_number>" has "POSTCODE" as "<postcode>" new schema
	And I have deleted all holidays new schema
	
	Then I see "Reply to a jury summons" on the page
	
	And I set the radio button to "I am replying for myself"
	And I press the "Continue" button
	And I set "9-digit juror number" to "<juror_number>"
	And I set "Juror last name" to "<last_name>"
	And I set "Juror postcode" to "<postcode>"
	And I press the "Continue" button
	Then on the page I see
		| text	|
		| Your details |
		| Is the name we have for you correct? |
	
	And I choose the "Yes" radio button
	And I press the "Continue" button
	Then on the page I see
		| text	|
		| Is this your address?|

	And I choose the "Yes" radio button
	When I press the "Continue" button
	
	Then on the page I see
		| text	|
		|Your details|
		|What is your phone number?|
		|Please provide a UK phone number that we can use to reach you between 9am and 5pm, Monday to Friday.|
		|Main phone|
		|Another phone (optional)|
	
	When I press the "Continue" button
	Then on the page I see
		|text	|
		|There is a problem|
		|Enter your main phone number|

	When I set "Main phone" to "02078211818"
	And I press the "Continue" button

	Then on the page I see
		| text	|
		| Your details |
		| What is your email address? |
		| Enter your email address |
		| Enter your email address again |

	When I press the "Continue" button
	Then on the page I see
		| text |
		| Your details |
		| Enter your email address |
	
	When I set "Enter your email address" to "<email>"
	And I press the "Continue" button
	Then I see "Enter your email address and check that it matches the one in the first field" on the page
	When I set "Enter your email address again" to "<email>"
	And I press the "Continue" button

	Then on the page I see
		| text	|
		| Your details	|
		| What is your date of birth?	|
		| For example, 15 03 1982 |
		| Help with date of birth |
	
	When I set the date of birth to a Monday "-1560" weeks in the future
	And I press the "Continue" button

	#Qualify for jury service
	Then I see "Confirm you're eligible for jury service" on the page
	When I press the "Continue" button
	
	#Residency
	Then I see "Since you turned 13, has your main address been in the UK, Channel Islands or Isle of Man for any period of at least 5 years?" on the page
	When I see "Eligibility" on the page
	And I choose the "Yes" radio button
	And I press the "Continue" button
	
	#CJS no
	Then I see "Have you worked in the criminal justice system in the last 5 years?" on the page
	When I choose the "No" radio button
	And I press the "Continue" button
	
	#Bail
	Then I see "Are you currently on bail for a criminal offence?" on the page
	When I see "Eligibility" on the page
	And I choose the "No" radio button
	And I press the "Continue" button
	
	#Convictions
	Then I see "Have you been found guilty of a criminal offence?" on the page
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
	
	#I can attend
	Then I see "Check your start date" on the page
	When I set the radio button to "Yes, I can start on"
	And  I press the "Continue" button
	
	#RA no
	Then I see "Will you need help when you're at the court?" on the page
	When I choose the "No" radio button
	And I press the "Continue" button
	
	#Check Your Answers (Covers Scenarios 1 and 2)
	Then I see "Check your answers now" on the page
	When I click on the "Change" link in the same row as "Confirm the date of your jury service"
	
	#New deferrals
	Then I see "Check your start date" on the page
	And I see "You are summoned to start jury service on" on the page
	And I see "Can you start jury service on this date?" on the page
	And I see "Yes, I can start on" on the page
	And I see "and serve for at least 2 weeks" on the page
	And I see "No, I need to change the date" on the page
	And I see "No, I cannot do jury service and need to be excused" on the page
	
	When I set the radio button to "No, I need to change the date"
	And I press the "Continue" button
	
	#deferral reason
	And I see "steps/confirm-date/deferral-reason" in the URL
	And I see "Tell us why you need another date for your jury service" on the page
	And I see "You must have a good reason for changing, for example:" on the page
	And I see "a booked holiday" on the page
	And I see "an operation" on the page
	And I see "an exam" on the page
	And I see "your employer will not give you time off work" on the page
	When I set text area with "id" of "deferralReason" to "Deferral Reason"
	And I press the "Continue" button
	
	#enter dates
	When I set the "First" single date field to a Monday "9" weeks in the future
	When I set the "Second" single date field to a Monday "10" weeks in the future
	When I set the "Third" single date field to a Monday "11" weeks in the future
	And I press the "Continue" button
	
	#Confirm Date of Jury Service
	And I see "Check your dates" on the page
	When I choose the "Yes" radio button
	
	#back link
	When I click on the "Back" link
	Then I see "Choose 3 Mondays when you can start jury service" on the page
	
	#back link
	When I click on the "Back" link
	
	When I see "I need to change the date" on the page
	
	#Check Your Answers
	When I click on the "Change" link in the same row as "Confirm the date of your jury service"
	
	#New deferrals
	Then I see "Check your start date" on the page
	And I see "You are summoned to start jury service on" on the page
	And I see "Can you start jury service on this date?" on the page
	And I see "Yes, I can start on" on the page
	And I see "and serve for at least 2 weeks" on the page
	And I see "No, I need to change the date" on the page
	And I see "No, I cannot do jury service and need to be excused" on the page
	
	When I set the radio button to "No, I need to change the date"
	And I press the "Continue" button
	
	Then I see "Check your answers now" on the page
	
	#Check Your Answers
	When I click on the "Change" link in the same row as "Tell us why you need another date for your jury service"
	When I set text area with "id" of "deferralReason" to ""
	And I press the "Continue" button
	Then I see "Enter your reason for needing another date for jury service" on the page
	When I click on the "Back" link	
	
	#Check Your Answers (to confirm scenario 3 passes)
	Then I see "Check your answers now" on the page
	And I see "Deferral Reason" on the page
	And I validate the "First" deferral date is "9" weeks in the future
	And I validate the "Second" deferral date is "10" weeks in the future
	And I validate the "Third" deferral date is "11" weeks in the future

	When I check the "The information I have given is true to the best of my knowledge" checkbox
	And I press the "Submit" button
	Then I see "We have sent you an email to say you have replied to your jury summons." on the page
	
Examples:
	| juror_number	| last_name		| postcode	| email 	| pool_number	|
	| 045200018		| LNAMENINETWO	| CH1 2AN	| a@eeee.com| 452300014		|

@Regression @NewSchemaConverted
Scenario Outline: 1st English Back Button Logic with Deferral Dates Screen

	Given I am on "Public" "test"

	Given a bureau owned pool is created with jurors
		| court |juror_number  | pool_number	| att_date_weeks_in_future	| owner |
		| 452   |<juror_number>| <pool_number>	| 5				            | 400	|
		
	And juror "<juror_number>" has "LAST_NAME" as "<last_name>" new schema
	And juror "<juror_number>" has "POSTCODE" as "<postcode>" new schema
	And I have deleted all holidays new schema
	
	Then I see "Reply to a jury summons" on the page
	
	And I set the radio button to "I am replying for myself"
	And I press the "Continue" button
	And I set "9-digit juror number" to "<juror_number>"
	And I set "Juror last name" to "<last_name>"
	And I set "Juror postcode" to "<postcode>"
	And I press the "Continue" button
	Then on the page I see
		| text	|
		| Your details |
		| Is the name we have for you correct? |
	
	And I choose the "Yes" radio button
	And I press the "Continue" button
	
	Then on the page I see
		| text	|
		| Is this your address? |

	And I choose the "Yes" radio button
	And I press the "Continue" button
	
	Then on the page I see
		| text	|
		|Your details|
		|What is your phone number?|
		|Please provide a UK phone number that we can use to reach you between 9am and 5pm, Monday to Friday.|
		|Main phone|
		|Another phone (optional)|
	
	When I press the "Continue" button
	Then on the page I see
		| text	|
		| There is a problem|
		|Enter your main phone number|

	When I set "Main phone" to "02078211818"
	And I press the "Continue" button

	Then on the page I see
		| text	|
		| Your details |
		| What is your email address? |
		| Enter your email address |
		| Enter your email address again |

	When I press the "Continue" button
	Then on the page I see
		| text |
		| Your details |
		| Enter your email address |
	
	When I set "Enter your email address" to "test@gmail.com"
	And I press the "Continue" button
	Then I see "Enter your email address and check that it matches the one in the first field" on the page
	When I set "Enter your email address again" to "test@gmail.com"
	And I press the "Continue" button

	Then on the page I see
		| text	|
		| Your details	|
		| What is your date of birth?	|
		| For example, 15 03 1982 |
		| Help with date of birth |
	
	When I set the date of birth to a Monday "-1560" weeks in the future
	And I press the "Continue" button

	#Qualify for jury service
	Then I see "Confirm you're eligible for jury service" on the page
	When I press the "Continue" button

	#Residency
	Then I see "Since you turned 13, has your main address been in the UK, Channel Islands or Isle of Man for any period of at least 5 years?" on the page
	When I see "Eligibility" on the page
	And I choose the "Yes" radio button
	And I press the "Continue" button
	
	#CJS no
	Then I see "Have you worked in the criminal justice system in the last 5 years?" on the page
	When I choose the "No" radio button
	And I press the "Continue" button
	
	#Bail
	Then I see "Are you currently on bail for a criminal offence?" on the page
	When I see "Eligibility" on the page
	And I choose the "No" radio button
	And I press the "Continue" button
	
	#Convictions
	Then I see "Have you been found guilty of a criminal offence?" on the page
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
	
	#I can attend
	Then I see "Check your start date" on the page
	When I set the radio button to "Yes, I can start on"
	And  I press the "Continue" button
	
	#RA no
	Then I see "Will you need help when you're at the court?" on the page
	When I choose the "No" radio button
	Then the radio button "No" is "selected"
	And I press the "Continue" button
	
	#Check Your Answers (Covers Scenario 1)
	Then I see "Check your answers now" on the page
	When I click on the "Change" link in the same row as "Confirm the date of your jury service"
	
	#New deferrals
	Then I see "Check your start date" on the page
	And I see "You are summoned to start jury service on" on the page
	And I see "Can you start jury service on this date?" on the page
	And I see "Yes, I can start on" on the page
	And I see "and serve for at least 2 weeks" on the page
	And I see "No, I need to change the date" on the page
	And I see "No, I cannot do jury service and need to be excused" on the page
	
	When I set the radio button to "No, I need to change the date"
	And I press the "Continue" button
	
	And I see "steps/confirm-date/deferral-reason" in the URL
	And I see "Tell us why you need another date for your jury service" on the page
	And I see "You must have a good reason for changing, for example:" on the page
	And I see "a booked holiday" on the page
	And I see "an operation" on the page
	And I see "an exam" on the page
	And I see "your employer will not give you time off work" on the page
	When I set text area with "id" of "deferralReason" to "Deferral Reason"
	When I press the "Continue" button
	
	#Deferral Dates
	When I press the "Continue" button
	And I see "Enter the first Monday you'd prefer to start jury service" on the page
	And I see "Enter the second Monday you'd prefer to start jury service" on the page
	And I see "Enter the third Monday you'd prefer to start jury service" on the page

	When I set the "First" single date field to a Monday "9" weeks in the future
	When I set the "Second" single date field to a Monday "10" weeks in the future
	When I set the "Third" single date field to a Monday "11" weeks in the future

	And I press the "Continue" button
	
	#confirm dates
	And I see "steps/confirm-date/deferral-check" in the URL
	And I see "Check your dates" on the page
	And I see "Dates you can start jury service" on the page
	And I validate the "First" deferral date is "9" weeks in the future
	And I validate the "Second" deferral date is "10" weeks in the future
	And I validate the "Third" deferral date is "11" weeks in the future
	
	And I choose the "Yes" radio button
	And I press the "Continue" button
	
	Then I see "Check your answers now" on the page
	And I see text "I need to change the date of my jury service" in the same row as "Confirm the date of your jury service"
	
	#Check Your Answers (Scenario 2)
	When I click on the "Change" link in the same row as "Confirm the date of your jury service"
	
	#New deferrals
	Then I see "Check your start date" on the page
	And I see "You are summoned to start jury service on" on the page
	And I see "Can you start jury service on this date?" on the page
	And I see "Yes, I can start on" on the page
	And I see "and serve for at least 2 weeks" on the page
	And I see "No, I need to change the date" on the page
	And I see "No, I cannot do jury service and need to be excused" on the page
	
	When I set the radio button to "Yes, I can start on"
	And I press the "Continue" button
	
	Then I see "Check your answers now" on the page
	
	#Check Your Answers
	And I see text "I can do jury service on the date shown" in the same row as "Confirm the date of your jury service"
	When I click on the "Change" link in the same row as "Confirm the date of your jury service"

	And I click on the "Back" link	
	Then I see "Check your answers now" on the page
	
	When I click on the "Change" link in the same row as "Confirm the date of your jury service"
	
	When I set the radio button to "No, I need to change the date"
	And I press the "Continue" button
	
	When I set text area with "id" of "deferralReason" to "Deferral Reason"
	When I press the "Continue" button
	
	When I set the "First" single date field to a Monday "6" weeks in the future
	When I set the "Second" single date field to a Monday "7" weeks in the future
	When I set the "Third" single date field to a Monday "8" weeks in the future
	And I press the "Continue" button
	
	And I choose the "Yes" radio button
	And I press the "Continue" button
	
	Then I see "Check your answers now" on the page
	
	#Check Your Answers (Submit)
	When I check the "The information I have given is true to the best of my knowledge" checkbox
	And I press the "Submit" button
	Then I see "We have sent you an email to say you have replied to your jury summons." on the page
	
Examples:
	| juror_number	| last_name	| postcode	| pool_number|
	| 045200019		| DOE		| SW1H 9AJ	| 452300015	|

@Regression @NewSchemaConverted
Scenario Outline: English 1st Party Deferral - Validation and Errors

	Given I am on "Public" "test"

	Given a bureau owned pool is created with jurors
		| court |juror_number  | pool_number	| att_date_weeks_in_future	| owner |
		| 452   |<juror_number>| <pool_number>	| 5				            | 400	|
	
	And juror "<juror_number>" has "LAST_NAME" as "<last_name>" new schema
	And juror "<juror_number>" has "FIRST_NAME" as "FNAMESEVENONETHREE" new schema
	And juror "<juror_number>" has "ADDRESS_LINE_1" as "855 STREET NAME" new schema
	And juror "<juror_number>" has "ADDRESS_LINE_4" as "LONDON" new schema
	And juror "<juror_number>" has "POSTCODE" as "<postcode>" new schema
	And I have deleted all holidays new schema
	
	Then I see "Reply to a jury summons" on the page
	
	And I set the radio button to "I am replying for myself"
	And I press the "Continue" button
	Then I see "Your juror details" on the page
	
	When I set "9-digit juror number" to "<juror_number>"
	When I set "Juror last name" to "<last_name>"
	When I set "Juror postcode" to "<postcode>"
	And I press the "Continue" button
	
	Then I see "Is the name we have for you correct?" on the page
	And I choose the "Yes" radio button
	And I press the "Continue" button
	
	When I press the "Continue" button
	And I choose the "Yes" radio button
	And I press the "Continue" button

	When I set "Main phone" to "02078211818"
	And I press the "Continue" button

	When I set "Enter your email address" to "<email>"
	When I set "Enter your email address again" to "<email>"
	And I press the "Continue" button
	
	And I set the date of birth to a Monday "-1560" weeks in the future
	And I press the "Continue" button
	
	And I press the "Continue" button
	
	Then I see "Since you turned 13, has your main address been in the UK, Channel Islands or Isle of Man for any period of at least 5 years?" on the page
	And I choose the "Yes" radio button
	And I press the "Continue" button
	
	Then I see "Have you worked in the criminal justice system in the last 5 years?" on the page
	Then I see "Have you worked in the criminal justice system in the last 5 years?" on the page
	When I choose the "No" radio button
	And I press the "Continue" button
	
	Then I see "bail" on the page
	And I see "Are you currently on bail for a criminal offence?" on the page
	When I choose the "No" radio button
	And I press the "Continue" button
	
	Then I see "Have you been found guilty of a criminal offence?" on the page
	When I choose the "No" radio button
	And I press the "Continue" button
	
	Then I see "Mental Health" on the page
	And I see "Are you being detained, looked after or treated under the Mental Health Act?" on the page
	When I choose the "No" radio button
	And I press the "Continue" button
	
	Then I see "Has it been decided that you 'lack mental capacity'?" on the page
	When I choose the "No" radio button
	And I press the "Continue" button
	
	#New deferrals
	Then I see "Check your start date" on the page
	And I see "You are summoned to start jury service on" on the page
	And I see "Can you start jury service on this date?" on the page
	
	#check errors
	And I press the "Continue" button
	And I see "There is a problem" on the page
	And I see "Select whether you can start jury service on this date" on the page
	
	#check hint text
	Then I click on the "Will I need to serve longer than 2 weeks?" link
	And I see "Most jurors only need to serve 2 weeks." on the page
	And I see "You may be asked to serve for longer when you arrive at court." on the page
	And I see "If you cannot serve for more than 2 weeks, you'll be able to discuss this with the jury manager at court." on the page
	
	Then I click on the "What if there's a problem nearer the time and I cannot serve?" link
	And I see "You must contact us at that time to let us know." on the page
	
	#collapse hint text
	Then I click on the "Will I need to serve longer than 2 weeks?" link
	And I do not see "Most jurors only need to serve 2 weeks." on the page
	And I do not see "You may be asked to serve for longer when you arrive at court." on the page
	And I do not see "If you cannot serve for more than 2 weeks, you'll be able to discuss this with the jury manager at court." on the page

	Then I click on the "What if there's a problem nearer the time and I cannot serve?" link
	And I do not see "You must contact us at that time to let us know." on the page

	#select deferral
	When I set the radio button to "No, I need to change the date"
	And I press the "Continue" button
	
	#deferral reason
	#check hint text
	And I see "steps/confirm-date/deferral-reason" in the URL
	And I see "Tell us why you need another date for your jury service" on the page
	
	And I press the "Continue" button
	And I see "There is a problem" on the page
	And I see "Enter your reason for needing another date for jury service" on the page
	
	When I set text area with "id" of "deferralReason" to "Large amount of text here Large amount of text here Large amount of text here Large amount of text here Large amount of text here Large amount of text here Large amount of text here Large amount of text here Large amount of text here Large amount of text here Large amount of text here Large amount of text here Large amount of text here Large amount of text here Large amount of text here Large amount of text here Large amount of text here Large amount of text here Large amount of text here Large amount of text here Large amount of text here Large amount of text here Large amount of text here Large amount of text here Large amount of text here Large amount of text here Large amount of text here Large amount of text here Large amount of text here Large amount of text here Large amount of text here Large amount of text here Large amount of text here Large amount of text here Large amount of text here Large amount of text here Large amount of text here Large amount of text here Large amount of text here "
	And I see "You have 14 characters too many" on the page
	
	And I press the "Continue" button
	And I see "There is a problem" on the page
	And I see "Your reason for asking for a later date for your jury service must be fewer characters" on the page
	
	When I set text area with "id" of "deferralReason" to "Deferral Reason"
	And I press the "Continue" button
	
	And I see "steps/confirm-date/deferral-dates" in the URL
	Then I see "Choose 3 Mondays when you can start jury service" on the page
	And I see "These must be between" on the page
	And I see "You must be available to serve at least 2 weeks." on the page
	
	#check hint text
	And I click on the "Will I need to serve longer than 2 weeks?" link
	And I see "Most jurors only need to serve 2 weeks." on the page
	And I see "You may be asked to serve for longer when you arrive at court." on the page
	And I see "If you cannot serve for more than 2 weeks, you'll be able to discuss this with the jury manager at court." on the page
	
	And I click on the "What if there's a problem nearer the time and I cannot serve?" link
	And I see "You must contact us at that time to let us know." on the page
	
	And I click on the "Will I need to serve longer than 2 weeks?" link
	And I do not see "Most jurors only need to serve 2 weeks." on the page
	And I do not see "You may be asked to serve for longer when you arrive at court." on the page
	And I do not see "If you cannot serve for more than 2 weeks, you'll be able to discuss this with the jury manager at court." on the page
	
	And I click on the "What if there's a problem nearer the time and I cannot serve?" link
	And I do not see "You must contact us at that time to let us know." on the page
	
	#check inputting invalid values in
	And I press the "Continue" button
	And I see "There is a problem" on the page
	And I see "Enter the first Monday you'd prefer to start jury service" on the page
	And I see "Enter the second Monday you'd prefer to start jury service" on the page
	And I see "Enter the third Monday you'd prefer to start jury service" on the page
	
	When I set input field with "id" of "deferDate1" to "aa"
	When I set input field with "id" of "deferDate2" to "aa"
	When I set input field with "id" of "deferDate3" to "aa"

	And I press the "Continue" button
	And I see "There is a problem" on the page
	And I see "Enter the first Monday you'd prefer to start jury service" on the page
	And I see "Enter the second Monday you'd prefer to start jury service" on the page
	And I see "Enter the third Monday you'd prefer to start jury service" on the page
	
	When I set input field with "id" of "deferDate1" to "99"
	When I set input field with "id" of "deferDate2" to "99"
	When I set input field with "id" of "deferDate3" to "99"

	And I press the "Continue" button
	
	And I see "There is a problem" on the page
	And I see "Enter the first Monday you'd prefer to start jury service" on the page
	And I see "Enter the second Monday you'd prefer to start jury service" on the page
	And I see "Enter the third Monday you'd prefer to start jury service" on the page
	
	When I set input field with "id" of "deferDate1" to "1111"
	When I set input field with "id" of "deferDate2" to "1111"
	When I set input field with "id" of "deferDate3" to "1111"

	And I press the "Continue" button
	
	And I see "There is a problem" on the page
	And I see "Enter the first Monday you'd prefer to start jury service" on the page
	And I see "Enter the second Monday you'd prefer to start jury service" on the page
	And I see "Enter the third Monday you'd prefer to start jury service" on the page
	
	When I set input field with "id" of "deferDate1" to "!"
	When I set input field with "id" of "deferDate2" to "!"
	When I set input field with "id" of "deferDate3" to "!"

	And I press the "Continue" button
	
	And I see "There is a problem" on the page
	And I see "Enter the first Monday you'd prefer to start jury service" on the page
	And I see "Enter the second Monday you'd prefer to start jury service" on the page
	And I see "Enter the third Monday you'd prefer to start jury service" on the page
	
	When I set the "First" single date field to a Monday "9" weeks in the future
	When I set the "Second" single date field to a Monday "10" weeks in the future
	When I set the "Third" single date field to a Monday "10" weeks in the future
	And I press the "Continue" button
	
	And I see "There is a problem" on the page
	And I see "Enter a date that's different to your other choices" on the page
	
	When I set the "First" single date field to a Monday "9" weeks in the future
	When I set the "Second" single date field to a Monday "10" weeks in the future
	When I set the "Third" single date field to a Monday "11" weeks in the future
	And I press the "Continue" button

	#confirm dates
	And I see "steps/confirm-date/deferral-check" in the URL
	And I see "Check your dates" on the page
	And I see "Dates you can start jury service" on the page
	
	And I validate the "First" deferral date is "9" weeks in the future
	And I validate the "Second" deferral date is "10" weeks in the future
	And I validate the "Third" deferral date is "11" weeks in the future
	
	#check hint text
	And I click on the "Will I need to serve longer than 2 weeks?" link
	Then on the page I see
	| text	|
	|Most jurors only need to serve 2 weeks.|
	|You may be asked to serve for longer when you arrive at court.|
	|If you cannot serve for more than 2 weeks, you'll be able to discuss this with the jury manager at court.|
	
	And I click on the "What if there's a problem nearer the time and I cannot serve?" link
	And I see "You must contact us at that time to let us know." on the page
	
	And I click on the "Will I need to serve longer than 2 weeks?" link
	Then on the page I do not see
	| text	|
	|Most jurors only need to serve 2 weeks.|
	|You may be asked to serve for longer when you arrive at court.|
	|If you cannot serve for more than 2 weeks, you'll be able to discuss this with the jury manager at court.|
	
	And I click on the "What if there's a problem nearer the time and I cannot serve?" link
	And I do not see "You must contact us at that time to let us know." on the page
	
	And I press the "Continue" button
	And I see "There is a problem" on the page
	And I see "Confirm whether you want to proceed with these dates" on the page
	
	And I choose the "Yes" radio button
	And I press the "Continue" button

	#help in court
	Then I see "Will you need help when you're at the court?" on the page
	When I choose the "No" radio button
	And I press the "Continue" button
	
	#check answers
	Then I see "Check your answers now" on the page
	
	Then on the page I see
	| text	|
	|Choose 3 Mondays when you can start jury service|
	|First choice|
	|Second choice|
	|Third choice|

	And I validate the "First" deferral date is "9" weeks in the future
	And I validate the "Second" deferral date is "10" weeks in the future
	And I validate the "Third" deferral date is "11" weeks in the future

	Then I check the "The information I have given is true to the best of my knowledge" checkbox
	
	When I press the "Submit" button
	
	Then I see "You have completed your reply" on the page
	Then I see "<juror_number>" on the page
	
	Then I see "You have completed your reply" on the page
	
	Then on "JUROR_MOD" . "JUROR_RESPONSE" I see "PROCESSING_STATUS" is "TODO" where "JUROR_NUMBER" is "<juror_number>"
	Then on "JUROR_MOD" . "JUROR_RESPONSE" I see "PROCESSING_COMPLETE" is "N" where "JUROR_NUMBER" is "<juror_number>"
	
Examples:
	| juror_number	| pool_number	| last_name			| postcode	| email 		|
	| 045200020		| 452300016		| LNAMESEVENONETHREE| SW1H 9AJ	| e@eeee.com	|
	
@RegressionSingle @NewSchemaConverted
Scenario Outline: English 1st Party Deferral - date 1 selected is a BH

	Given I am on "Public" "test"

	Given a bureau owned pool is created with jurors
		| court |juror_number  | pool_number	| att_date_weeks_in_future	| owner |
		| 452   |<juror_number>| <pool_number>	| 5				            | 400	|
	
	And juror "<juror_number>" has "LAST_NAME" as "<last_name>" new schema
	And juror "<juror_number>" has "FIRST_NAME" as "FNAMESEVENONETHREE" new schema
	And juror "<juror_number>" has "ADDRESS_LINE_1" as "855 STREET NAME" new schema
	And juror "<juror_number>" has "ADDRESS_LINE_4" as "LONDON" new schema
	And juror "<juror_number>" has "POSTCODE" as "<postcode>" new schema
	And I have deleted all holidays new schema
	
	Then I see "Reply to a jury summons" on the page
	
	And I set the radio button to "I am replying for myself"
	And I press the "Continue" button
	Then I see "Your juror details" on the page
	
	When I set "9-digit juror number" to "<juror_number>"
	When I set "Juror last name" to "<last_name>"
	When I set "Juror postcode" to "<postcode>"
	And I press the "Continue" button
	
	#name
	And I choose the "Yes" radio button
	And I press the "Continue" button
	
	#address
	And I choose the "Yes" radio button
	And I press the "Continue" button
	
	#phone
	When I set "Main phone" to "02078211818"
	And I press the "Continue" button
	
	#email
	When I set "Enter your email address" to "<email>"
	When I set "Enter your email address again" to "<email>"
	And I press the "Continue" button
	
	#dob
	And I set the date of birth to a Monday "-1560" weeks in the future
	And I press the "Continue" button
	
	Then I see "Confirm you're eligible for jury service" on the page
	
	And I press the "Continue" button
	
	Then I see "Since you turned 13, has your main address been in the UK, Channel Islands or Isle of Man for any period of at least 5 years?" on the page
	And I choose the "Yes" radio button

	And I press the "Continue" button
	
	Then I see "Have you worked in the criminal justice system in the last 5 years?" on the page
	Then I see "Have you worked in the criminal justice system in the last 5 years?" on the page
	When I choose the "No" radio button
	And I press the "Continue" button
	
	Then I see "bail" on the page
	And I see "Are you currently on bail for a criminal offence?" on the page
	When I choose the "No" radio button
	And I press the "Continue" button
	
	Then I see "Have you been found guilty of a criminal offence?" on the page
	When I choose the "No" radio button
	And I press the "Continue" button
	
	Then I see "Mental Health" on the page
	And I see "Are you being detained, looked after or treated under the Mental Health Act?" on the page
	When I choose the "No" radio button
	And I press the "Continue" button
	
	Then I see "Has it been decided that you 'lack mental capacity'?" on the page
	When I choose the "No" radio button
	And I press the "Continue" button
	
	#New deferrals
	Then I see "Check your start date" on the page
	
	When I set the radio button to "No, I need to change the date"
	And I press the "Continue" button

	When I set text area with "id" of "deferralReason" to "Deferral Reason"
	And I press the "Continue" button

	And I create a bank holiday "8" Mondays in the future for court/bureau "400" new schema

	When I set the "First" single date field to a Monday "8" weeks in the future
	When I set the "Second" single date field to a Monday "9" weeks in the future
	When I set the "Third" single date field to a Monday "10" weeks in the future
	
	And I press the "Continue" button
	
	#confirm dates screen
	And I see "Check your dates" on the page
	And I see "Dates you can start jury service" on the page

	And I validate the "First" deferral date is "8" weeks in the future
	And I validate the "Second" deferral date is "9" weeks in the future
	And I validate the "Third" deferral date is "10" weeks in the future
	
	When I choose the "Yes" radio button
	And I press the "Continue" button
	
	#Bank Holiday
	Then I see "At least one of the Mondays you selected is a bank holiday" on the page
	And I see "You've selected at least one Monday that's a UK bank holiday." on the page
	And I see "If we choose this as your start date, your jury service will start on the Tuesday at the earliest." on the page
	And I see "We'll send you confirmation of your start date." on the page
	And I press the "Continue" button

	#help in court
	Then I see "Will you need help when you're at the court?" on the page
	Then I see "Do you have a disability or impairment that means you’ll need extra support or facilities in the court building where you are doing your Jury Service?" on the page
	When I choose the "No" radio button
	And I press the "Continue" button
	Then I see "Check your answers now" on the page
	
	When I click on the "Change" link in the same row as "Email"
	And I set "Enter your email address" to "abc@abc.com"
	And I press the "Continue" button
	Then I see "Enter your email address and check that it matches the one in the first field" on the page
	When I set "Enter your email address" to "<email>"
	And I press the "Continue" button
	
	Then on the page I see
	| text	|
	|Choose 3 Mondays when you can start jury service|
	|First choice|
	|Second choice|
	|Third choice|
	And I validate the "First" deferral date is "8" weeks in the future
	And I validate the "Second" deferral date is "9" weeks in the future
	And I validate the "Third" deferral date is "10" weeks in the future
	
	Then I check the "The information I have given is true to the best of my knowledge" checkbox
	
	When I press the "Submit" button
	
	Then I see "You have completed your reply" on the page
	Then I see "<juror_number>" on the page
	
	Then on the page I see
	| text	|
	|You have completed your reply|
	|If we get in touch with you, you may need to give your juror number. It's also on the letter we sent you.|
	|We have sent you an email to say you have replied to your jury summons.|
	|Download a copy of your summons reply|
	|We'll write to you within the next 7 days to let you know if you can change the date of your jury service.|
	|Then, at least 2 weeks before your jury service starts, we'll send you:|
	|a letter confirming the date of your jury service|
	|an information pack about being a juror and the court you're going to|
	|Get ready for your jury service|
	|The information below is also in the email that we have sent you.|
	|You can watch this video on YouTube about what happens when you're a juror, so you know what to expect. The video takes 13 minutes to watch.|
	|Learn more about your jury service. You can read the rules about discussing the trial and find out how to claim expenses.|
	|Calculate what expenses and allowances you can claim.|
	|What did you think of this service? (Takes 30 seconds)|
	
	And I do not see "Your Guide to Jury Service (PDF 85KB)" on the page
	
	Then on "JUROR_MOD" . "JUROR_RESPONSE" I see "PROCESSING_STATUS" is "TODO" where "JUROR_NUMBER" is "<juror_number>"
	Then on "JUROR_MOD" . "JUROR_RESPONSE" I see "PROCESSING_COMPLETE" is "N" where "JUROR_NUMBER" is "<juror_number>"
	
	Then I click on the "Download a copy of your summons reply HTML (15KB)" link
	And on the page I see
	|text|
	|You have said that you need to change the date of your jury service.|
	|We'll write to you within the next 7 days to let you know if you can change the date of your jury service.|
	|I need to change the date of my jury service|
	|Tell us why you need another date for your jury service|
	|Deferral Reason|
	|Choose 3 Mondays when you can start jury service|
	|First choice|
	|Second choice|
	|Third choice|
	And I validate the "First" deferral date is "8" weeks in the future
	And I validate the "Second" deferral date is "9" weeks in the future
	And I validate the "Third" deferral date is "10" weeks in the future
	
	Given I am on "Bureau" "test"
	And I log in as "MODTESTBUREAU"
	
	When I click on the "Search" link
	And I set "Juror number" to "<juror_number>"
	And I press the "Search" button
	
	When I click on "<juror_number>" in the same row as "<juror_number>"
	
	And I see "Juror details" on the page
	
	When I select "Deferral" from Process reply
	
	And I select "O - OTHER" from the "Reason for the deferral request" dropdown
	And I select the first deferral choice
	
	And I press the "Continue" button
	Then I see the juror record updated banner containing "Deferral granted (other)"
	
	Then on "JUROR_MOD" . "JUROR_RESPONSE" I see "PROCESSING_STATUS" is "CLOSED" where "JUROR_NUMBER" is "<juror_number>"
	Then on "JUROR_MOD" . "JUROR_RESPONSE" I see "PROCESSING_COMPLETE" is "Y" where "JUROR_NUMBER" is "<juror_number>"
	
	Then on "JUROR_MOD" . "JUROR" I see "H_PHONE" is "02078211818" where "JUROR_NUMBER" is "<juror_number>"
	Then on "JUROR_MOD" . "JUROR" I see "H_EMAIL" is "<email>" where "JUROR_NUMBER" is "<juror_number>"
	
	#JDB-3453
	
	Then on "JUROR_MOD" . "JUROR" I see "WELSH" is null where "JUROR_NUMBER" is "<juror_number>"
	And I delete bank holiday
	
Examples:
	| juror_number	| pool_number	| last_name			| postcode	| email 		|
	| 041500054		| 415300144		| LNAMESEVENONETHREE| SW1H 9AJ	| e@eeee.com	|
	
@RegressionSingle @NewSchemaConverted
Scenario Outline: English 1st Party Deferral - date 2 selected is a BH

	Given I am on "Public" "test"

	Given a bureau owned pool is created with jurors
		| court |juror_number  | pool_number	| att_date_weeks_in_future	| owner |
		| 452   |<juror_number>| <pool_number>	| 5				            | 400	|

	And juror "<juror_number>" has "LAST_NAME" as "<last_name>" new schema
	And juror "<juror_number>" has "FIRST_NAME" as "FNAMESEVENONETHREE" new schema

	And juror "<juror_number>" has "ADDRESS_LINE_1" as "855 STREET NAME" new schema
	And juror "<juror_number>" has "ADDRESS_LINE_4" as "LONDON" new schema
	And juror "<juror_number>" has "POSTCODE" as "<postcode>" new schema
	And I have deleted all holidays new schema
	
	Then I see "Reply to a jury summons" on the page
	
	And I set the radio button to "I am replying for myself"
	And I press the "Continue" button
	Then I see "Your juror details" on the page
	
	When I set "9-digit juror number" to "<juror_number>"
	When I set "Juror last name" to "<last_name>"
	When I set "Juror postcode" to "<postcode>"
	And I press the "Continue" button
	
	#name
	And I choose the "Yes" radio button
	And I press the "Continue" button
	
	#address
	And I choose the "Yes" radio button
	And I press the "Continue" button
	
	#phone
	When I set "Main phone" to "02078211818"
	And I press the "Continue" button
	
	#email
	When I set "Enter your email address" to "<email>"
	When I set "Enter your email address again" to "<email>"
	And I press the "Continue" button
	
	#dob
	And I set the date of birth to a Monday "-1560" weeks in the future
	And I press the "Continue" button
	
	Then I see "Confirm you're eligible for jury service" on the page
	
	And I press the "Continue" button
	
	Then I see "Since you turned 13, has your main address been in the UK, Channel Islands or Isle of Man for any period of at least 5 years?" on the page
	And I choose the "Yes" radio button

	And I press the "Continue" button
	
	Then I see "Have you worked in the criminal justice system in the last 5 years?" on the page
	Then I see "Have you worked in the criminal justice system in the last 5 years?" on the page
	When I choose the "No" radio button
	And I press the "Continue" button
	
	Then I see "bail" on the page
	And I see "Are you currently on bail for a criminal offence?" on the page
	When I choose the "No" radio button
	And I press the "Continue" button
	
	Then I see "Have you been found guilty of a criminal offence?" on the page
	When I choose the "No" radio button
	And I press the "Continue" button
	
	Then I see "Mental Health" on the page
	And I see "Are you being detained, looked after or treated under the Mental Health Act?" on the page
	When I choose the "No" radio button
	And I press the "Continue" button
	
	Then I see "Has it been decided that you 'lack mental capacity'?" on the page
	When I choose the "No" radio button
	And I press the "Continue" button
	
	#New deferrals
	Then I see "Check your start date" on the page
	
	When I set the radio button to "No, I need to change the date"
	And I press the "Continue" button

	When I set text area with "id" of "deferralReason" to "Deferral Reason"
	And I press the "Continue" button

	And I create a bank holiday "10" Mondays in the future for court/bureau "400" new schema

	When I set the "First" single date field to a Monday "9" weeks in the future
	When I set the "Second" single date field to a Monday "10" weeks in the future
	When I set the "Third" single date field to a Monday "11" weeks in the future
	
	And I press the "Continue" button
	
	#confirm dates screen
	Then on the page I see
	|text|
	|Check your dates|
	|Dates you can start jury service|
	And I validate the "First" deferral date is "9" weeks in the future
	And I validate the "Second" deferral date is "10" weeks in the future
	And I validate the "Third" deferral date is "11" weeks in the future

	When I choose the "Yes" radio button
	And I press the "Continue" button
	
	#Bank Holiday
	Then on the page I see
	|text|
	|At least one of the Mondays you selected is a bank holiday|
	|You've selected at least one Monday that's a UK bank holiday.|
	|If we choose this as your start date, your jury service will start on the Tuesday at the earliest.|
	|We'll send you confirmation of your start date.|
	And I press the "Continue" button

	#help in court
	Then I see "Will you need help when you're at the court?" on the page
	When I choose the "No" radio button
	And I press the "Continue" button
	Then I see "Check your answers now" on the page
	
	Then on the page I see
	| text	|
	|Choose 3 Mondays when you can start jury service|
	|First choice|
	|Second choice|
	|Third choice|
	And I validate the "First" deferral date is "9" weeks in the future
	And I validate the "Second" deferral date is "10" weeks in the future
	And I validate the "Third" deferral date is "11" weeks in the future
	
	Then I check the "The information I have given is true to the best of my knowledge" checkbox
	
	When I press the "Submit" button
	
	Then I see "You have completed your reply" on the page
	Then I see "<juror_number>" on the page
	
	Then on the page I see
	| text	|
	|You have completed your reply|
	|If we get in touch with you, you may need to give your juror number. It's also on the letter we sent you.|
	|We have sent you an email to say you have replied to your jury summons.|
	|Download a copy of your summons reply|
	|We'll write to you within the next 7 days to let you know if you can change the date of your jury service.|
	|Then, at least 2 weeks before your jury service starts, we'll send you:|
	|a letter confirming the date of your jury service|
	|an information pack about being a juror and the court you're going to|
	|Get ready for your jury service|
	|The information below is also in the email that we have sent you.|
	|You can watch this video on YouTube about what happens when you're a juror, so you know what to expect. The video takes 13 minutes to watch.|
	|Learn more about your jury service. You can read the rules about discussing the trial and find out how to claim expenses.|
	|Calculate what expenses and allowances you can claim.|
	|What did you think of this service? (Takes 30 seconds)|
	
	And I do not see "Your Guide to Jury Service (PDF 85KB)" on the page
	
	Then on "JUROR_MOD" . "JUROR_RESPONSE" I see "PROCESSING_STATUS" is "TODO" where "JUROR_NUMBER" is "<juror_number>"
	Then on "JUROR_MOD" . "JUROR_RESPONSE" I see "PROCESSING_COMPLETE" is "N" where "JUROR_NUMBER" is "<juror_number>"
	
	Then I click on the "Download a copy of your summons reply HTML (15KB)" link
	And on the page I see
	|text|
	|You have said that you need to change the date of your jury service.|
	|We'll write to you within the next 7 days to let you know if you can change the date of your jury service.|
	|I need to change the date of my jury service|
	|Tell us why you need another date for your jury service|
	|Deferral Reason|
	|Choose 3 Mondays when you can start jury service|
	|First choice|
	|Second choice|
	|Third choice|
	And I validate the "First" deferral date is "9" weeks in the future
	And I validate the "Second" deferral date is "10" weeks in the future
	And I validate the "Third" deferral date is "11" weeks in the future
	
	Given I am on "Bureau" "test"
	And I log in as "MODTESTBUREAU"
	
	When I click on the "Search" link
	And I set "Juror number" to "<juror_number>"
	And I press the "Search" button
	
	When I click on "<juror_number>" in the same row as "<juror_number>"
	
	And I see "Juror details" on the page
	
	When I select "Deferral" from Process reply
	
	And I select "O - OTHER" from the "Reason for the deferral request" dropdown
	And I select the first deferral choice
	
	And I press the "Continue" button
	Then I see the juror record updated banner containing "Deferral granted (other)"
	
	Then on "JUROR_MOD" . "JUROR_RESPONSE" I see "PROCESSING_STATUS" is "CLOSED" where "JUROR_NUMBER" is "<juror_number>"
	Then on "JUROR_MOD" . "JUROR_RESPONSE" I see "PROCESSING_COMPLETE" is "Y" where "JUROR_NUMBER" is "<juror_number>"
	
	Then on "JUROR_MOD" . "JUROR" I see "H_PHONE" is "02078211818" where "JUROR_NUMBER" is "<juror_number>"
	Then on "JUROR_MOD" . "JUROR" I see "H_EMAIL" is "<email>" where "JUROR_NUMBER" is "<juror_number>"
	
	#JDB-3453
	
	Then on "JUROR_MOD" . "JUROR" I see "WELSH" is null where "JUROR_NUMBER" is "<juror_number>"
	And I delete bank holiday new schema

Examples:
	|juror_number	|pool_number|last_name			|postcode	|email 		|
	|045200035		|452300034	|LNAMESEVENONETHREE	|CH1 2AN	|e@eeee.com	|
	
@RegressionSingle @JDNewSchemaConverted
Scenario Outline: English 1st Party Deferral - date 3 selected is a BH

	Given I am on "Public" "test"

	Given a bureau owned pool is created with jurors
		| court |juror_number  | pool_number	| att_date_weeks_in_future	| owner |
		| 452   |<juror_number>| <pool_number>	| 5				            | 400	|
	
	And juror "<juror_number>" has "LAST_NAME" as "<last_name>" new schema
	And juror "<juror_number>" has "FIRST_NAME" as "FNAMESEVENONETHREE" new schema

	And juror "<juror_number>" has "ADDRESS_LINE_1" as "855 STREET NAME" new schema
	And juror "<juror_number>" has "ADDRESS_LINE_4" as "LONDON" new schema
	And juror "<juror_number>" has "POSTCODE" as "<postcode>" new schema
	And I have deleted all holidays new schema
	
	Then I see "Reply to a jury summons" on the page
	
	And I set the radio button to "I am replying for myself"
	And I press the "Continue" button
	Then I see "Your juror details" on the page
	
	When I set "9-digit juror number" to "<juror_number>"
	When I set "Juror last name" to "<last_name>"
	When I set "Juror postcode" to "<postcode>"
	And I press the "Continue" button
	
	#name
	And I choose the "Yes" radio button
	And I press the "Continue" button
	
	#address
	And I choose the "Yes" radio button
	And I press the "Continue" button
	
	#phone
	When I set "Main phone" to "02078211818"
	And I press the "Continue" button
	
	#email
	When I set "Enter your email address" to "<email>"
	When I set "Enter your email address again" to "<email>"
	And I press the "Continue" button
	
	#dob
	And I set the date of birth to a Monday "-1560" weeks in the future
	And I press the "Continue" button
	
	Then I see "Confirm you're eligible for jury service" on the page
	
	And I press the "Continue" button
	
	Then I see "Since you turned 13, has your main address been in the UK, Channel Islands or Isle of Man for any period of at least 5 years?" on the page
	And I choose the "Yes" radio button

	And I press the "Continue" button
	
	Then I see "Have you worked in the criminal justice system in the last 5 years?" on the page
	Then I see "Have you worked in the criminal justice system in the last 5 years?" on the page
	When I choose the "No" radio button
	And I press the "Continue" button
	
	Then I see "bail" on the page
	And I see "Are you currently on bail for a criminal offence?" on the page
	When I choose the "No" radio button
	And I press the "Continue" button
	
	Then I see "Have you been found guilty of a criminal offence?" on the page
	When I choose the "No" radio button
	And I press the "Continue" button
	
	Then I see "Mental Health" on the page
	And I see "Are you being detained, looked after or treated under the Mental Health Act?" on the page
	When I choose the "No" radio button
	And I press the "Continue" button
	
	Then I see "Has it been decided that you 'lack mental capacity'?" on the page
	When I choose the "No" radio button
	And I press the "Continue" button
	
	#New deferrals
	Then I see "Check your start date" on the page
	
	When I set the radio button to "No, I need to change the date"
	And I press the "Continue" button

	When I set text area with "id" of "deferralReason" to "Deferral Reason"
	And I press the "Continue" button

	And I create a bank holiday "11" Mondays in the future for court/bureau "400" new schema

	When I set the "First" single date field to a Monday "9" weeks in the future
	When I set the "Second" single date field to a Monday "10" weeks in the future
	When I set the "Third" single date field to a Monday "11" weeks in the future
	
	And I press the "Continue" button
	
	#confirm dates screen
	Then on the page I see
	|text|
	|Check your dates|
	|Dates you can start jury service|
	And I validate the "First" deferral date is "9" weeks in the future
	And I validate the "Second" deferral date is "10" weeks in the future
	And I validate the "Third" deferral date is "11" weeks in the future
	
	When I choose the "Yes" radio button
	And I press the "Continue" button
	
	#Bank Holiday
	Then on the page I see
	|text|
	|At least one of the Mondays you selected is a bank holiday|
	|You've selected at least one Monday that's a UK bank holiday.|
	|If we choose this as your start date, your jury service will start on the Tuesday at the earliest.|
	|We'll send you confirmation of your start date.|
	
	And I press the "Continue" button

	#help in court
	Then I see "Will you need help when you're at the court?" on the page
	When I choose the "No" radio button
	And I press the "Continue" button
	Then I see "Check your answers now" on the page
	
	Then on the page I see
	| text	|
	|Choose 3 Mondays when you can start jury service|
	|First choice|
	|Second choice|
	|Third choice|
	And I validate the "First" deferral date is "9" weeks in the future
	And I validate the "Second" deferral date is "10" weeks in the future
	And I validate the "Third" deferral date is "11" weeks in the future
	
	Then I check the "The information I have given is true to the best of my knowledge" checkbox
	
	When I press the "Submit" button
	
	Then I see "You have completed your reply" on the page
	Then I see "<juror_number>" on the page
	
	Then on the page I see
	| text	|
	|You have completed your reply|
	|If we get in touch with you, you may need to give your juror number. It's also on the letter we sent you.|
	|We have sent you an email to say you have replied to your jury summons.|
	|Download a copy of your summons reply|
	|We'll write to you within the next 7 days to let you know if you can change the date of your jury service.|
	|Then, at least 2 weeks before your jury service starts, we'll send you:|
	|a letter confirming the date of your jury service|
	|an information pack about being a juror and the court you're going to|
	|Get ready for your jury service|
	|The information below is also in the email that we have sent you.|
	|You can watch this video on YouTube about what happens when you're a juror, so you know what to expect. The video takes 13 minutes to watch.|
	|Learn more about your jury service. You can read the rules about discussing the trial and find out how to claim expenses.|
	|Calculate what expenses and allowances you can claim.|
	|What did you think of this service? (Takes 30 seconds)|
	
	And I do not see "Your Guide to Jury Service (PDF 85KB)" on the page
	
	Then on "JUROR_MOD" . "JUROR_RESPONSE" I see "PROCESSING_STATUS" is "TODO" where "JUROR_NUMBER" is "<juror_number>"
	Then on "JUROR_MOD" . "JUROR_RESPONSE" I see "PROCESSING_COMPLETE" is "N" where "JUROR_NUMBER" is "<juror_number>"
	
	Then I click on the "Download a copy of your summons reply HTML (15KB)" link
	And on the page I see
	|text|
	|You have said that you need to change the date of your jury service.|
	|We'll write to you within the next 7 days to let you know if you can change the date of your jury service.|
	|I need to change the date of my jury service|
	|Tell us why you need another date for your jury service|
	|Deferral Reason|
	|Choose 3 Mondays when you can start jury service|
	|First choice|
	|Second choice|
	|Third choice|
	And I validate the "First" deferral date is "9" weeks in the future
	And I validate the "Second" deferral date is "10" weeks in the future
	And I validate the "Third" deferral date is "11" weeks in the future
	
	Given I am on "Bureau" "test"
	And I log in as "MODTESTBUREAU"
	
	When I click on the "Search" link
	And I set "Juror number" to "<juror_number>"
	And I press the "Search" button
	
	When I click on "<juror_number>" in the same row as "<juror_number>"
	
	And I see "Juror details" on the page
	
	When I select "Deferral" from Process reply
	
	And I select "O - OTHER" from the "Reason for the deferral request" dropdown
	And I select the first deferral choice
	
	And I press the "Continue" button
	Then I see the juror record updated banner containing "Deferral granted (other)"
	
	Then on "JUROR_MOD" . "JUROR_RESPONSE" I see "PROCESSING_STATUS" is "CLOSED" where "JUROR_NUMBER" is "<juror_number>"
	Then on "JUROR_MOD" . "JUROR_RESPONSE" I see "PROCESSING_COMPLETE" is "Y" where "JUROR_NUMBER" is "<juror_number>"
	
	Then on "JUROR_MOD" . "JUROR" I see "H_PHONE" is "02078211818" where "JUROR_NUMBER" is "<juror_number>"
	Then on "JUROR_MOD" . "JUROR" I see "H_EMAIL" is "<email>" where "JUROR_NUMBER" is "<juror_number>"
	Then on "JUROR_MOD" . "JUROR" I see "WELSH" is null where "JUROR_NUMBER" is "<juror_number>"

	And I delete bank holiday new schema

Examples:
	|juror_number	|pool_number|last_name			|postcode	|email 		|
	|045200036		|452300035	|LNAMESEVENONETHREE	|SW1H 9AJ	|e@eeee.com	|
	
@RegressionSingle @NewSchemaConverted
Scenario Outline: English 1st Party Deferral - >1 date selected is a BH

	Given I am on "Public" "test"

	Given a bureau owned pool is created with jurors
		| court |juror_number  | pool_number	| att_date_weeks_in_future	| owner |
		| 452   |<juror_number>| <pool_number>	| 5				            | 400	|
	
	And juror "<juror_number>" has "LAST_NAME" as "<last_name>" new schema
	And juror "<juror_number>" has "FIRST_NAME" as "FNAMESEVENONETHREE" new schema
	And juror "<juror_number>" has "ADDRESS_LINE_1" as "855 STREET NAME" new schema
	And juror "<juror_number>" has "ADDRESS_LINE_4" as "LONDON" new schema
	And juror "<juror_number>" has "POSTCODE" as "<postcode>" new schema

	And I have deleted all holidays new schema
	
	Then I see "Reply to a jury summons" on the page
	
	And I set the radio button to "I am replying for myself"
	And I press the "Continue" button
	Then I see "Your juror details" on the page
	
	When I set "9-digit juror number" to "<juror_number>"
	When I set "Juror last name" to "<last_name>"
	When I set "Juror postcode" to "<postcode>"
	And I press the "Continue" button
	
	#name
	And I choose the "Yes" radio button
	And I press the "Continue" button
	
	#address
	And I choose the "Yes" radio button
	And I press the "Continue" button
	
	#phone
	When I set "Main phone" to "02078211818"
	And I press the "Continue" button
	
	#email
	When I set "Enter your email address" to "<email>"
	When I set "Enter your email address again" to "<email>"
	And I press the "Continue" button
	
	#dob
	And I set the date of birth to a Monday "-1560" weeks in the future
	And I press the "Continue" button
	
	Then I see "Confirm you're eligible for jury service" on the page
	
	And I press the "Continue" button
	
	Then I see "Since you turned 13, has your main address been in the UK, Channel Islands or Isle of Man for any period of at least 5 years?" on the page
	And I choose the "Yes" radio button

	And I press the "Continue" button
	
	Then I see "Have you worked in the criminal justice system in the last 5 years?" on the page
	Then I see "Have you worked in the criminal justice system in the last 5 years?" on the page
	When I choose the "No" radio button
	And I press the "Continue" button
	
	Then I see "bail" on the page
	And I see "Are you currently on bail for a criminal offence?" on the page
	When I choose the "No" radio button
	And I press the "Continue" button
	
	Then I see "Have you been found guilty of a criminal offence?" on the page
	When I choose the "No" radio button
	And I press the "Continue" button
	
	Then I see "Mental Health" on the page
	And I see "Are you being detained, looked after or treated under the Mental Health Act?" on the page
	When I choose the "No" radio button
	And I press the "Continue" button
	
	Then I see "Has it been decided that you 'lack mental capacity'?" on the page
	When I choose the "No" radio button
	And I press the "Continue" button
	
	#New deferrals
	Then I see "Check your start date" on the page
	
	When I set the radio button to "No, I need to change the date"
	And I press the "Continue" button

	When I set text area with "id" of "deferralReason" to "Deferral Reason"
	And I press the "Continue" button

	And I create a bank holiday "10" Mondays in the future for court/bureau "400" new schema

	When I set the "First" single date field to a Monday "9" weeks in the future
	When I set the "Second" single date field to a Monday "10" weeks in the future
	When I set the "Third" single date field to a Monday "11" weeks in the future
	
	And I press the "Continue" button
	
	#confirm dates screen
	Then on the page I see
	|text|
	|Check your dates|
	|Dates you can start jury service|

	And I validate the "First" deferral date is "9" weeks in the future
	And I validate the "Second" deferral date is "10" weeks in the future
	And I validate the "Third" deferral date is "11" weeks in the future
	
	When I choose the "Yes" radio button
	And I press the "Continue" button
	
	#Bank Holiday
	Then on the page I see
	|text|
	|At least one of the Mondays you selected is a bank holiday|
	|You've selected at least one Monday that's a UK bank holiday.|
	|If we choose this as your start date, your jury service will start on the Tuesday at the earliest.|
	|We'll send you confirmation of your start date.|
	And I press the "Continue" button

	#help in court
	Then I see "Will you need help when you're at the court?" on the page
	When I choose the "No" radio button
	And I press the "Continue" button
	Then I see "Check your answers now" on the page
	
	Then on the page I see
	| text	|
	|Choose 3 Mondays when you can start jury service|
	|First choice|
	|Second choice|
	|Third choice|

	And I validate the "First" deferral date is "9" weeks in the future
	And I validate the "Second" deferral date is "10" weeks in the future
	And I validate the "Third" deferral date is "11" weeks in the future
	
	Then I check the "The information I have given is true to the best of my knowledge" checkbox
	
	When I press the "Submit" button
	
	Then I see "You have completed your reply" on the page
	Then I see "<juror_number>" on the page
	
	Then on the page I see
	| text	|
	|You have completed your reply|
	|If we get in touch with you, you may need to give your juror number. It's also on the letter we sent you.|
	|We have sent you an email to say you have replied to your jury summons.|
	|Download a copy of your summons reply|
	|We'll write to you within the next 7 days to let you know if you can change the date of your jury service.|
	|Then, at least 2 weeks before your jury service starts, we'll send you:|
	|a letter confirming the date of your jury service|
	|an information pack about being a juror and the court you're going to|
	|Get ready for your jury service|
	|The information below is also in the email that we have sent you.|
	|You can watch this video on YouTube about what happens when you're a juror, so you know what to expect. The video takes 13 minutes to watch.|
	|Learn more about your jury service. You can read the rules about discussing the trial and find out how to claim expenses.|
	|Calculate what expenses and allowances you can claim.|
	|What did you think of this service? (Takes 30 seconds)|
	
	And I do not see "Your Guide to Jury Service (PDF 85KB)" on the page
	
	Then on "JUROR_MOD" . "JUROR_RESPONSE" I see "PROCESSING_STATUS" is "TODO" where "JUROR_NUMBER" is "<juror_number>"
	Then on "JUROR_MOD" . "JUROR_RESPONSE" I see "PROCESSING_COMPLETE" is "N" where "JUROR_NUMBER" is "<juror_number>"
	
	Then I click on the "Download a copy of your summons reply HTML (15KB)" link
	And on the page I see
	|text|
	|You have said that you need to change the date of your jury service.|
	|We'll write to you within the next 7 days to let you know if you can change the date of your jury service.|
	|I need to change the date of my jury service|
	|Tell us why you need another date for your jury service|
	|Deferral Reason|
	|Choose 3 Mondays when you can start jury service|
	|First choice|
	|Second choice|
	|Third choice|

	And I validate the "First" deferral date is "9" weeks in the future
	And I validate the "Second" deferral date is "10" weeks in the future
	And I validate the "Third" deferral date is "11" weeks in the future
	
	Given I am on "Bureau" "test"
	And I log in as "MODTESTBUREAU"
	
	When I click on the "Search" link
	And I set "Juror number" to "<juror_number>"
	And I press the "Search" button
	
	When I click on "<juror_number>" in the same row as "<juror_number>"
	
	And I see "Juror details" on the page
	
	When I select "Deferral" from Process reply
	
	And I select "O - OTHER" from the "Reason for the deferral request" dropdown
	And I select the first deferral choice

	And I press the "Continue" button
	Then I see the juror record updated banner containing "Deferral granted (other)"
	
	Then on "JUROR_MOD" . "JUROR_RESPONSE" I see "PROCESSING_STATUS" is "CLOSED" where "JUROR_NUMBER" is "<juror_number>"
	Then on "JUROR_MOD" . "JUROR_RESPONSE" I see "PROCESSING_COMPLETE" is "Y" where "JUROR_NUMBER" is "<juror_number>"
	
	Then on "JUROR_MOD" . "JUROR" I see "H_PHONE" is "02078211818" where "JUROR_NUMBER" is "<juror_number>"
	Then on "JUROR_MOD" . "JUROR" I see "H_EMAIL" is "<email>" where "JUROR_NUMBER" is "<juror_number>"
	
	#JDB-3453
	Then on "JUROR_MOD" . "JUROR" I see "WELSH" is null where "JUROR_NUMBER" is "<juror_number>"
	Then I delete bank holiday new schema

Examples:
	|juror_number	|pool_number	|last_name			|postcode	|email 		|
	|045200037		|452300036		|LNAMESEVENONETHREE	|SW1H 9AJ	|e@eeee.com	|
	
@RegressionSingle @NewSchemaConverted
Scenario Outline: English 1st Party Deferral - Navigate back from BH page

	Given I am on "Public" "test"

	Given a bureau owned pool is created with jurors
		| court |juror_number  | pool_number	| att_date_weeks_in_future	| owner |
		| 452   |<juror_number>| <pool_number>	| 5				            | 400	|
	
	And juror "<juror_number>" has "LAST_NAME" as "<last_name>" new schema
	And juror "<juror_number>" has "FIRST_NAME" as "FNAMESEVENONETHREE" new schema
	And juror "<juror_number>" has "ADDRESS_LINE_1" as "855 STREET NAME" new schema
	And juror "<juror_number>" has "ADDRESS_LINE_4" as "LONDON" new schema
	And juror "<juror_number>" has "POSTCODE" as "<postcode>" new schema
	And I have deleted all holidays new schema
	
	Then I see "Reply to a jury summons" on the page
	
	And I set the radio button to "I am replying for myself"
	And I press the "Continue" button
	Then I see "Your juror details" on the page
	
	When I set "9-digit juror number" to "<juror_number>"
	When I set "Juror last name" to "<last_name>"
	When I set "Juror postcode" to "<postcode>"
	And I press the "Continue" button
	
	#name
	And I choose the "Yes" radio button
	And I press the "Continue" button
	
	#address
	And I choose the "Yes" radio button
	And I press the "Continue" button
	
	#phone
	When I set "Main phone" to "02078211818"
	And I press the "Continue" button
	
	#email
	When I set "Enter your email address" to "<email>"
	When I set "Enter your email address again" to "<email>"
	And I press the "Continue" button
	
	#dob
	And I set the date of birth to a Monday "-1560" weeks in the future
	And I press the "Continue" button
	
	Then I see "Confirm you're eligible for jury service" on the page
	
	And I press the "Continue" button
	
	Then I see "Since you turned 13, has your main address been in the UK, Channel Islands or Isle of Man for any period of at least 5 years?" on the page
	And I choose the "Yes" radio button

	And I press the "Continue" button
	
	Then I see "Have you worked in the criminal justice system in the last 5 years?" on the page
	Then I see "Have you worked in the criminal justice system in the last 5 years?" on the page
	When I choose the "No" radio button
	And I press the "Continue" button
	
	Then I see "bail" on the page
	And I see "Are you currently on bail for a criminal offence?" on the page
	When I choose the "No" radio button
	And I press the "Continue" button
	
	Then I see "Have you been found guilty of a criminal offence?" on the page
	When I choose the "No" radio button
	And I press the "Continue" button
	
	Then I see "Mental Health" on the page
	And I see "Are you being detained, looked after or treated under the Mental Health Act?" on the page
	When I choose the "No" radio button
	And I press the "Continue" button
	
	Then I see "Has it been decided that you 'lack mental capacity'?" on the page
	When I choose the "No" radio button
	And I press the "Continue" button
	
	#New deferrals
	Then I see "Check your start date" on the page
	
	When I set the radio button to "No, I need to change the date"
	And I press the "Continue" button

	When I set text area with "id" of "deferralReason" to "Deferral Reason"
	And I press the "Continue" button

	Then I create a bank holiday "11" Mondays in the future for court/bureau "400" new schema

	When I set the "First" single date field to a Monday "9" weeks in the future
	When I set the "Second" single date field to a Monday "10" weeks in the future
	When I set the "Third" single date field to a Monday "11" weeks in the future

	And I press the "Continue" button
	
	#confirm dates screen
	Then on the page I see
	|text|
	|Check your dates|
	|Dates you can start jury service|

	And I validate the "First" deferral date is "9" weeks in the future
	And I validate the "Second" deferral date is "10" weeks in the future
	And I validate the "Third" deferral date is "11" weeks in the future
	
	When I choose the "Yes" radio button
	And I press the "Continue" button
	
	#Bank Holiday
	Then on the page I see
	|text|
	|At least one of the Mondays you selected is a bank holiday|
	|You've selected at least one Monday that's a UK bank holiday.|
	|If we choose this as your start date, your jury service will start on the Tuesday at the earliest.|
	|We'll send you confirmation of your start date.|
	
	And I press the "Continue" button

	#back link
	And I click on the "Back" link
	And I see "At least one of the Mondays you selected is a bank holiday" on the page
	
	#back link
	And I click on the "Back" link
	And I see "Check your dates" on the page
	
	#back link
	When I click on the "Back" link
	Then I see "Choose 3 Mondays when you can start jury service" on the page
	
	#back link
	When I click on the "Back" link
	Then I see "Tell us why you need another date for your jury service" on the page
	
	#back link
	When I click on the "Back" link
	Then I see "Check your start date" on the page
	
	#no i need to change date
	And the radio button "No, I need to change the date" is "selected"
	And I press the "Continue" button
	
	#reason
	Then I see "Tell us why you need another date for your jury service" on the page
	When I set text area with "id" of "deferralReason" to "Deferral Reason"
	And I press the "Continue" button
	
	#choose dates
	Then I see "Choose 3 Mondays when you can start jury service" on the page
	
	When I set the "First" single date field to a Monday "6" weeks in the future
	When I set the "Second" single date field to a Monday "7" weeks in the future
	When I set the "Third" single date field to a Monday "11" weeks in the future
	
	And I press the "Continue" button
	
	#confirm dates
	And I see "Check your dates" on the page
	And I choose the "Yes" radio button
	And I press the "Continue" button
	
	#BH page
	And I see "At least one of the Mondays you selected is a bank holiday" on the page
	And I press the "Continue" button
		
	#help in court
	Then I see "Will you need help when you're at the court?" on the page
	When I choose the "No" radio button
	And I press the "Continue" button
	Then I see "Check your answers now" on the page
	
	Then on the page I see
	| text	|
	|Choose 3 Mondays when you can start jury service|
	|First choice|
	|Second choice|
	|Third choice|
	And I validate the "First" deferral date is "6" weeks in the future
	And I validate the "Second" deferral date is "7" weeks in the future
	And I validate the "Third" deferral date is "11" weeks in the future
	
	Then I check the "The information I have given is true to the best of my knowledge" checkbox
	
	When I press the "Submit" button
	
	Then I see "You have completed your reply" on the page
	Then I see "<juror_number>" on the page
	
	Then on the page I see
	| text	|
	|You have completed your reply|
	|If we get in touch with you, you may need to give your juror number. It's also on the letter we sent you.|
	|We have sent you an email to say you have replied to your jury summons.|
	|Download a copy of your summons reply|
	|We'll write to you within the next 7 days to let you know if you can change the date of your jury service.|
	|Then, at least 2 weeks before your jury service starts, we'll send you:|
	|a letter confirming the date of your jury service|
	|an information pack about being a juror and the court you're going to|
	|Get ready for your jury service|
	|The information below is also in the email that we have sent you.|
	|You can watch this video on YouTube about what happens when you're a juror, so you know what to expect. The video takes 13 minutes to watch.|
	|Learn more about your jury service. You can read the rules about discussing the trial and find out how to claim expenses.|
	|Calculate what expenses and allowances you can claim.|
	|What did you think of this service? (Takes 30 seconds)|
	
	And I do not see "Your Guide to Jury Service (PDF 85KB)" on the page
	
	Then on "JUROR_MOD" . "JUROR_RESPONSE" I see "PROCESSING_STATUS" is "TODO" where "JUROR_NUMBER" is "<juror_number>"
	Then on "JUROR_MOD" . "JUROR_RESPONSE" I see "PROCESSING_COMPLETE" is "N" where "JUROR_NUMBER" is "<juror_number>"
	
	Then I click on the "Download a copy of your summons reply HTML (15KB)" link
	And on the page I see
	|text|
	|You have said that you need to change the date of your jury service.|
	|We'll write to you within the next 7 days to let you know if you can change the date of your jury service.|
	|I need to change the date of my jury service|
	|Tell us why you need another date for your jury service|
	|Deferral Reason|
	|Choose 3 Mondays when you can start jury service|
	|First choice|
	|Second choice|
	|Third choice|
	And I validate the "First" deferral date is "6" weeks in the future
	And I validate the "Second" deferral date is "7" weeks in the future
	And I validate the "Third" deferral date is "11" weeks in the future
	
	Given I am on "Bureau" "test"
	And I log in as "MODTESTBUREAU"
	
	When I click on the "Search" link
	And I set "Juror number" to "<juror_number>"
	And I press the "Search" button
	
	When I click on "<juror_number>" in the same row as "<juror_number>"
	
	And I see "Juror details" on the page
	
	When I select "Deferral" from Process reply
	
	And I select "O - OTHER" from the "Reason for the deferral request" dropdown
	And I select the first deferral choice
	
	And I press the "Continue" button
	Then I see the juror record updated banner containing "Deferral granted (other)"
	
	Then on "JUROR_MOD" . "JUROR_RESPONSE" I see "PROCESSING_STATUS" is "CLOSED" where "JUROR_NUMBER" is "<juror_number>"
	Then on "JUROR_MOD" . "JUROR_RESPONSE" I see "PROCESSING_COMPLETE" is "Y" where "JUROR_NUMBER" is "<juror_number>"
	
	Then on "JUROR_MOD" . "JUROR" I see "H_PHONE" is "02078211818" where "JUROR_NUMBER" is "<juror_number>"
	Then on "JUROR_MOD" . "JUROR" I see "H_EMAIL" is "<email>" where "JUROR_NUMBER" is "<juror_number>"
	
	#JDB-3453
	Then on "JUROR_MOD" . "JUROR" I see "WELSH" is null where "JUROR_NUMBER" is "<juror_number>"
	And I delete bank holiday new schema

Examples:
	|juror_number	|pool_number	|last_name			|postcode	|email 		|
	|045200038		|452300037		|LNAMESEVENONETHREE	|WV1 4EE	|e@eeee.com	|

@RegressionSingle @NewSchemaConverted
Scenario Outline: English 1st Party Deferral - selected date makes juror >76

	Given I am on "Public" "test"

	Given a bureau owned pool is created with jurors
		| court |juror_number  | pool_number	| att_date_weeks_in_future	| owner |
		| 452   |<juror_number>| <pool_number>	| 5				            | 400	|
	
	And juror "<juror_number>" has "LAST_NAME" as "<last_name>" new schema
	And juror "<juror_number>" has "FIRST_NAME" as "FNAMESEVENONETHREE" new schema

	And juror "<juror_number>" has "ADDRESS_LINE_1" as "855 STREET NAME" new schema
	And juror "<juror_number>" has "ADDRESS_LINE_4" as "LONDON" new schema
	And juror "<juror_number>" has "POSTCODE" as "<postcode>" new schema
	And I have deleted all holidays new schema
	
	Then I see "Reply to a jury summons" on the page
	
	And I set the radio button to "I am replying for myself"
	And I press the "Continue" button
	Then I see "Your juror details" on the page
	
	When I set "9-digit juror number" to "<juror_number>"
	When I set "Juror last name" to "<last_name>"
	When I set "Juror postcode" to "<postcode>"
	And I press the "Continue" button
	
	Then I see "Is the name we have for you correct?" on the page
	And I choose the "Yes" radio button
	And I press the "Continue" button
	
	And I choose the "Yes" radio button
	And I press the "Continue" button
	
	When I set "Main phone" to "02078211818"
	And I press the "Continue" button

	When I set "Enter your email address" to "<email>"
	When I set "Enter your email address again" to "<email>"
	And I press the "Continue" button

	#I set DOB to make them 75
	When I set the date of birth to a Monday "-3950" weeks in the future
	
	And I press the "Continue" button
	
	Then I see "Confirm you're eligible for jury service" on the page
	
	And I press the "Continue" button
	
	Then I see "Since you turned 13, has your main address been in the UK, Channel Islands or Isle of Man for any period of at least 5 years?" on the page
	And I choose the "Yes" radio button
	And I press the "Continue" button
	
	Then I see "Have you worked in the criminal justice system in the last 5 years?" on the page
	Then I see "Have you worked in the criminal justice system in the last 5 years?" on the page
	When I choose the "No" radio button
	And I press the "Continue" button
	
	Then I see "bail" on the page
	And I see "Are you currently on bail for a criminal offence?" on the page
	When I choose the "No" radio button
	And I press the "Continue" button
	
	Then I see "Have you been found guilty of a criminal offence?" on the page
	When I choose the "No" radio button
	And I press the "Continue" button
	
	Then I see "Mental Health" on the page
	And I see "Are you being detained, looked after or treated under the Mental Health Act?" on the page
	When I choose the "No" radio button
	And I press the "Continue" button
	
	Then I see "Has it been decided that you 'lack mental capacity'?" on the page
	When I choose the "No" radio button
	And I press the "Continue" button
	
	#New deferrals
	Then I see "Check your start date" on the page
	When I set the radio button to "No, I need to change the date"
	And I press the "Continue" button
	
	And I see "Tell us why you need another date for your jury service" on the page
	When I set text area with "id" of "deferralReason" to "Deferral Reason"
	And I press the "Continue" button
	
	Then I see "Choose 3 Mondays when you can start jury service" on the page

	When I set the "First" single date field to a Monday "46" weeks in the future
	When I set the "Second" single date field to a Monday "7" weeks in the future
	When I set the "Third" single date field to a Monday "8" weeks in the future
	
	And I press the "Continue" button
	
	Then on the page I see
	|text|
	|There is a problem|
	|Give another date, you will be older than 76 on this date and would not qualify for jury service|
	
	When I set the "First" single date field to a Monday "9" weeks in the future
	When I set the "Second" single date field to a Monday "10" weeks in the future
	When I set the "Third" single date field to a Monday "11" weeks in the future
	
	And I press the "Continue" button
	
	#check dates screen
	And I see "Check your dates" on the page
	And I see "Dates you can start jury service" on the page
	And I validate the "First" deferral date is "9" weeks in the future
	And I validate the "Second" deferral date is "10" weeks in the future
	And I validate the "Third" deferral date is "11" weeks in the future
	
	And I see "You do not need to tell us all other dates you're available." on the page
	And I see "We'll choose one of your 3 dates." on the page
	And I see "In the unlikely event that we cannot use one of these dates, we'll contact you." on the page
	And I see "Do you want to proceed with these dates?" on the page
	
	#check hint text
	And I click on the "Will I need to serve longer than 2 weeks?" link
	And I see "Most jurors only need to serve 2 weeks." on the page
	And I see "You may be asked to serve for longer when you arrive at court." on the page
	And I see "If you cannot serve for more than 2 weeks, you'll be able to discuss this with the jury manager at court." on the page
	
	And I click on the "What if there's a problem nearer the time and I cannot serve?" link
	And I see "You must contact us at that time to let us know." on the page
	
	And I click on the "Will I need to serve longer than 2 weeks?" link
	And I do not see "Most jurors only need to serve 2 weeks." on the page
	And I do not see "You may be asked to serve for longer when you arrive at court." on the page
	And I do not see "If you cannot serve for more than 2 weeks, you'll be able to discuss this with the jury manager at court." on the page
	
	And I click on the "What if there's a problem nearer the time and I cannot serve?" link
	And I do not see "You must contact us at that time to let us know." on the page
	
	And I choose the "Yes" radio button
	And I press the "Continue" button

	Then I see "Will you need help when you're at the court?" on the page
	Then I see "Do you have a disability or impairment that means you’ll need extra support or facilities in the court building where you are doing your Jury Service?" on the page
	When I choose the "No" radio button
	And I press the "Continue" button
	Then I see "Check your answers now" on the page
	
	When I click on the "Change" link in the same row as "Email"
	And I set "Enter your email address" to "abc@abc.com"
	And I press the "Continue" button
	Then I see "Enter your email address and check that it matches the one in the first field" on the page
	When I set "Enter your email address" to "<email>"
	And I press the "Continue" button
	
	And I see "Choose 3 Mondays when you can start jury service" on the page
	And I see "First choice" on the page
	And I see "Second choice" on the page
	And I see "Third choice" on the page
	And I validate the "First" deferral date is "9" weeks in the future
	And I validate the "Second" deferral date is "10" weeks in the future
	And I validate the "Third" deferral date is "11" weeks in the future

	Then I check the "The information I have given is true to the best of my knowledge" checkbox
	
	When I press the "Submit" button
	
	Then I see "You have completed your reply" on the page
	Then I see "<juror_number>" on the page
	
	Then I see "You have completed your reply" on the page
	Then I see "If we get in touch with you, you may need to give your juror number. It's also on the letter we sent you." on the page
	Then I see "We have sent you an email to say you have replied to your jury summons." on the page
	Then I see "Download a copy of your summons reply" on the page
	Then I see "We'll write to you within the next 7 days to let you know if you can change the date of your jury service." on the page
	Then I see "Then, at least 2 weeks before your jury service starts, we'll send you:" on the page
	And I see "a letter confirming the date of your jury service" on the page
	And I see "an information pack about being a juror and the court you're going to" on the page
	And I see "Get ready for your jury service" on the page
	And I see "The information below is also in the email that we have sent you." on the page
	And I see "You can watch this video on YouTube about what happens when you're a juror, so you know what to expect. The video takes 13 minutes to watch." on the page
	And I see "Learn more about your jury service. You can read the rules about discussing the trial and find out how to claim expenses." on the page
	And I see "Calculate what expenses and allowances you can claim." on the page
	And I do not see "Your Guide to Jury Service (PDF 85KB)" on the page
	And I see "What did you think of this service? (Takes 30 seconds)" on the page
	
	Then on "JUROR_MOD" . "JUROR_RESPONSE" I see "PROCESSING_STATUS" is "TODO" where "JUROR_NUMBER" is "<juror_number>"
	Then on "JUROR_MOD" . "JUROR_RESPONSE" I see "PROCESSING_COMPLETE" is "N" where "JUROR_NUMBER" is "<juror_number>"
	
	Then I click on the "Download a copy of your summons reply HTML (15KB)" link
	And I see "You have said that you need to change the date of your jury service." on the page
	And I see "We'll write to you within the next 7 days to let you know if you can change the date of your jury service." on the page
	And I see "I need to change the date of my jury service" on the page
	And I see "Tell us why you need another date for your jury service" on the page
	And I see "Deferral Reason" on the page
	And I see "Choose 3 Mondays when you can start jury service" on the page
	And I see "First choice" on the page
	And I see "Second choice" on the page
	And I see "Third choice" on the page
	And I validate the "First" deferral date is "9" weeks in the future
	And I validate the "Second" deferral date is "10" weeks in the future
	And I validate the "Third" deferral date is "11" weeks in the future
	
	Given I am on "Bureau" "test"
	And I log in as "MODTESTBUREAU"
	
	When I click on the "Search" link
	And I set "Juror number" to "<juror_number>"
	And I press the "Search" button
	
	When I click on "<juror_number>" in the same row as "<juror_number>"
	
	And I see "Juror details" on the page
	
	When I select "Deferral" from Process reply
	
	And I select "O - OTHER" from the "Reason for the deferral request" dropdown
	And I select the first deferral choice
	
	And I press the "Continue" button
	Then I see the juror record updated banner containing "Deferral granted (other)"
	
	Then on "JUROR_MOD" . "JUROR_RESPONSE" I see "PROCESSING_STATUS" is "CLOSED" where "JUROR_NUMBER" is "<juror_number>"
	Then on "JUROR_MOD" . "JUROR_RESPONSE" I see "PROCESSING_COMPLETE" is "Y" where "JUROR_NUMBER" is "<juror_number>"
	
	Then on "JUROR_MOD" . "JUROR" I see "H_PHONE" is "02078211818" where "JUROR_NUMBER" is "<juror_number>"
	Then on "JUROR_MOD" . "JUROR" I see "H_EMAIL" is "<email>" where "JUROR_NUMBER" is "<juror_number>"
	
	#JDB-3453
	
	Then on "JUROR_MOD" . "JUROR" I see "WELSH" is null where "JUROR_NUMBER" is "<juror_number>"
	
Examples:
	|juror_number	|pool_number|last_name			|postcode	|email 		|
	|045200039		|452300038	|LNAMESEVENONETHREE	|SW1H 9AJ	|e@eeee.com	|

@Features @NewSchemaConverted @JM-7131
Scenario Outline: English 1st Party Deferral + Bail + Name change

	#return to @Regression when defect fixed

	Given I am on "Public" "test"

	Given a bureau owned pool is created with jurors
		| court |juror_number  | pool_number	| att_date_weeks_in_future	| owner |
		| 452   |<juror_number>| <pool_number>	| 5				            | 400	|
	
	And juror "<juror_number>" has "LAST_NAME" as "<last_name>" new schema
	And juror "<juror_number>" has "FIRST_NAME" as "FNAMESEVENONETHREE" new schema
	And juror "<juror_number>" has "ADDRESS_LINE_1" as "855 STREET NAME" new schema
	And juror "<juror_number>" has "ADDRESS_LINE_4" as "LONDON" new schema
	And juror "<juror_number>" has "POSTCODE" as "<postcode>" new schema
	And I have deleted all holidays new schema
	
	Then I see "Reply to a jury summons" on the page
	
	And I set the radio button to "I am replying for myself"
	And I press the "Continue" button
	Then I see "Your juror details" on the page
	
	When I set "9-digit juror number" to "<juror_number>"
	When I set "Juror last name" to "<last_name>"
	When I set "Juror postcode" to "<postcode>"
	And I press the "Continue" button
	
	Then I see "Is the name we have for you correct?" on the page
	And I choose the "No" radio button
	When I press the "Continue" button
	And I set "First name" to "Joe"
	And I set "Last name" to "Blogs"
	And I press the "Continue" button
	
	And I choose the "Yes" radio button
	And I press the "Continue" button
	
	When I set "Main phone" to "02078211818"
	And I press the "Continue" button

	When I set "Enter your email address" to "<email>"
	When I set "Enter your email address again" to "<email>"
	And I press the "Continue" button
	
	And I set the date of birth to a Monday "-1560" weeks in the future
	And I press the "Continue" button
	
	Then I see "Confirm you're eligible for jury service" on the page
	
	And I press the "Continue" button
	
	Then I see "Since you turned 13, has your main address been in the UK, Channel Islands or Isle of Man for any period of at least 5 years?" on the page
	And I choose the "Yes" radio button
	And I press the "Continue" button
	
	Then I see "Have you worked in the criminal justice system in the last 5 years?" on the page
	Then I see "Have you worked in the criminal justice system in the last 5 years?" on the page
	When I choose the "No" radio button
	And I press the "Continue" button
	
	Then I see "bail" on the page
	And I see "Are you currently on bail for a criminal offence?" on the page
	When I choose the "Yes" radio button
	And I set "Provide details" to "I am on bail for crimes"
	And I press the "Continue" button
	
	Then I see "Have you been found guilty of a criminal offence?" on the page
	When I choose the "No" radio button
	And I press the "Continue" button
	
	Then I see "Mental Health" on the page
	And I see "Are you being detained, looked after or treated under the Mental Health Act?" on the page
	When I choose the "No" radio button
	And I press the "Continue" button
	
	Then I see "Has it been decided that you 'lack mental capacity'?" on the page
	When I choose the "No" radio button
	And I press the "Continue" button
	
	#New deferrals
	Then I see "Check your start date" on the page
	And I see "You are summoned to start jury service on" on the page
	And I see "Can you start jury service on this date?" on the page
	And I see "Yes, I can start on" on the page
	And I see "and serve for at least 2 weeks" on the page
	And I see "No, I need to change the date" on the page
	And I see "No, I cannot do jury service and need to be excused" on the page
	
	When I set the radio button to "No, I need to change the date"
	And I press the "Continue" button
	
	And I see "steps/confirm-date/deferral-reason" in the URL
	And I see "Tell us why you need another date for your jury service" on the page
	And I see "You must have a good reason for changing, for example:" on the page
	And I see "a booked holiday" on the page
	And I see "an operation" on the page
	And I see "an exam" on the page
	And I see "your employer will not give you time off work" on the page
	When I set text area with "id" of "deferralReason" to "Deferral Reason"
	And I press the "Continue" button
	
	And I see "steps/confirm-date/deferral-dates" in the URL
	Then I see "Choose 3 Mondays when you can start jury service" on the page
	And I see "These must be between" on the page
	And I see "You must be available to serve at least 2 weeks." on the page
	
	When I set the "First" single date field to a Monday "6" weeks in the future
	When I set the "Second" single date field to a Monday "7" weeks in the future
	When I set the "Third" single date field to a Monday "8" weeks in the future
	
	And I press the "Continue" button
	
	#check dates screen
	And I see "Check your dates" on the page
	And I see "Dates you can start jury service" on the page
	And I validate the "First" deferral date is "6" weeks in the future
	And I validate the "Second" deferral date is "7" weeks in the future
	And I validate the "Third" deferral date is "8" weeks in the future
	
	And I see "You do not need to tell us all other dates you're available." on the page
	And I see "We'll choose one of your 3 dates." on the page
	And I see "In the unlikely event that we cannot use one of these dates, we'll contact you." on the page
	And I see "Do you want to proceed with these dates?" on the page
	
	#check hint text
	And I click on the "Will I need to serve longer than 2 weeks?" link
	And I see "Most jurors only need to serve 2 weeks." on the page
	And I see "You may be asked to serve for longer when you arrive at court." on the page
	And I see "If you cannot serve for more than 2 weeks, you'll be able to discuss this with the jury manager at court." on the page
	
	And I click on the "What if there's a problem nearer the time and I cannot serve?" link
	And I see "You must contact us at that time to let us know." on the page
	
	And I click on the "Will I need to serve longer than 2 weeks?" link
	And I do not see "Most jurors only need to serve 2 weeks." on the page
	And I do not see "You may be asked to serve for longer when you arrive at court." on the page
	And I do not see "If you cannot serve for more than 2 weeks, you'll be able to discuss this with the jury manager at court." on the page
	
	And I click on the "What if there's a problem nearer the time and I cannot serve?" link
	And I do not see "You must contact us at that time to let us know." on the page

	And I choose the "Yes" radio button
	And I press the "Continue" button

	Then I see "Will you need help when you're at the court?" on the page
	Then I see "Do you have a disability or impairment that means you’ll need extra support or facilities in the court building where you are doing your Jury Service?" on the page
	When I choose the "No" radio button
	And I press the "Continue" button
	Then I see "Check your answers now" on the page
	
	When I click on the "Change" link in the same row as "Email"
	And I set "Enter your email address" to "abc@abc.com"
	And I press the "Continue" button
	Then I see "Enter your email address and check that it matches the one in the first field" on the page
	When I set "Enter your email address" to "<email>"
	And I press the "Continue" button
	
	And on the page I see
	|text|
	|Choose 3 Mondays when you can start jury service|
	|First choice|
	|Second choice|
	|Third choice|
	And I validate the "First" deferral date is "6" weeks in the future
	And I validate the "Second" deferral date is "7" weeks in the future
	And I validate the "Third" deferral date is "8" weeks in the future

	Then I check the "The information I have given is true to the best of my knowledge" checkbox
	
	When I press the "Submit" button
	
	Then I see "You have completed your reply" on the page
	Then I see "<juror_number>" on the page
	
	Then I see "You have completed your reply" on the page
	
	Then on "JUROR_MOD" . "JUROR_RESPONSE" I see "PROCESSING_STATUS" is "TODO" where "JUROR_NUMBER" is "<juror_number>"
	Then on "JUROR_MOD" . "JUROR_RESPONSE" I see "PROCESSING_COMPLETE" is "N" where "JUROR_NUMBER" is "<juror_number>"
	
	Then I click on the "Download a copy of your summons reply HTML (15KB)" link
	And I see "You have said that you need to change the date of your jury service." on the page
	And I see "First choice" on the page
	And I see "Second choice" on the page
	And I see "Third choice" on the page
	And I validate the "First" deferral date is "6" weeks in the future
	And I validate the "Second" deferral date is "7" weeks in the future
	And I validate the "Third" deferral date is "8" weeks in the future
	
	Given I am on "Bureau" "test"
	And I log in as "MODTESTBUREAU"
	
	When I click on the "Search" link
	And I set "Juror number" to "<juror_number>"
	And I press the "Search" button
	Then I see "<juror_number>" on the page
	
	And I click link with ID "selectAllLink"
	And I press the "Send to..." button
	And I set input field with "id" of "sendToOfficer" to "CPASS"
	And I press the "Send" button
	And I press the "Send" button
	Then I see "Your work" on the page
	
	Then I click on the "Sign out" link
	When I log in as "CPASS"
	Then I see "<juror_number>" on the page
	Then I see "<juror_number>" has reply type indicator "INELIGIBLE"

Examples:
	|juror_number	|pool_number|last_name			|postcode	|email 		|
	|045200040		|452300039	|LNAMESEVENONETHREE	|SY2 6LU	|e@eeee.com	|

@Regression @NewSchemaConverted
Scenario Outline: English 1st Party Deferral - NEW PAGE

	Given I am on "Public" "test"

	Given a bureau owned pool is created with jurors
		| court |juror_number  | pool_number	| att_date_weeks_in_future	| owner |
		| 452   |<juror_number>| <pool_number>	| 5				            | 400	|

	And juror "<juror_number>" has "LAST_NAME" as "<last_name>" new schema
	And juror "<juror_number>" has "FIRST_NAME" as "FNAMESEVENONETHREE" new schema
	And juror "<juror_number>" has "ADDRESS_LINE_1" as "855 STREET NAME" new schema
	And juror "<juror_number>" has "ADDRESS_LINE_4" as "LONDON" new schema
	And juror "<juror_number>" has "POSTCODE" as "<postcode>" new schema
#	And I have deleted all holidays new schema

	Then I see "Reply to a jury summons" on the page

	And I set the radio button to "I am replying for myself"
	And I press the "Continue" button
	Then I see "Your juror details" on the page

	When I set "9-digit juror number" to "<juror_number>"
	When I set "Juror last name" to "<last_name>"
	When I set "Juror postcode" to "<postcode>"
	And I press the "Continue" button

	Then I see "Is the name we have for you correct?" on the page
	And I choose the "Yes" radio button
	And I press the "Continue" button

	And I choose the "Yes" radio button
	And I press the "Continue" button

	When I set "Main phone" to "02078211818"
	And I press the "Continue" button

	When I set "Enter your email address" to "<email>"
	When I set "Enter your email address again" to "<email>"
	And I press the "Continue" button

	When I set the date of birth to a Monday "-1560" weeks in the future
	And I press the "Continue" button

	Then I see "Confirm you're eligible for jury service" on the page

	And I press the "Continue" button

	Then I see "Since you turned 13, has your main address been in the UK, Channel Islands or Isle of Man for any period of at least 5 years?" on the page
	And I choose the "Yes" radio button
	And I press the "Continue" button

	Then I see "Have you worked in the criminal justice system in the last 5 years?" on the page
	When I choose the "No" radio button
	And I press the "Continue" button

	Then I see "bail" on the page
	And I see "Are you currently on bail for a criminal offence?" on the page
	When I choose the "No" radio button
	And I press the "Continue" button

	Then I see "Have you been found guilty of a criminal offence?" on the page
	When I choose the "No" radio button
	And I press the "Continue" button

	Then I see "Mental Health" on the page
	And I see "Are you being detained, looked after or treated under the Mental Health Act?" on the page
	When I choose the "No" radio button
	And I press the "Continue" button

	Then I see "Has it been decided that you 'lack mental capacity'?" on the page
	When I choose the "No" radio button
	And I press the "Continue" button

	#New deferrals
	Then I see "Check your start date" on the page
	When I set the radio button to "No, I need to change the date"
	And I press the "Continue" button

	When I set text area with "id" of "deferralReason" to "Deferral Reason"
	And I press the "Continue" button

	When I set the "First" single date field to a Monday "6" weeks in the future
	When I set the "Second" single date field to a Monday "7" weeks in the future
	When I set the "Third" single date field to a Monday "8" weeks in the future

	And I press the "Continue" button

	#check dates screen
	And I see "Dates you can start jury service" on the page
	And I validate the "First" deferral date is "6" weeks in the future
	And I validate the "Second" deferral date is "7" weeks in the future
	And I validate the "Third" deferral date is "8" weeks in the future

	And I choose the "Yes" radio button
	And I press the "Continue" button

	Then I see "Will you need help when you're at the court?" on the page
	When I choose the "No" radio button
	And I press the "Continue" button

	Then I see "Check your answers now" on the page

	And on the page I see
	|text|
	|Choose 3 Mondays when you can start jury service|
	|First choice|
	|Second choice|
	|Third choice|
	And I validate the "First" deferral date is "6" weeks in the future
	And I validate the "Second" deferral date is "7" weeks in the future
	And I validate the "Third" deferral date is "8" weeks in the future

	Then I check the "The information I have given is true to the best of my knowledge" checkbox

	When I press the "Submit" button

	Then I see "You have completed your reply" on the page
	Then I see "<juror_number>" on the page
	
	Given I am on "Bureau" "test"
	And I log in as "MODTESTBUREAU"

	When I click on the "Search" link
	And I set "Juror number" to "<juror_number>"
	And I press the "Search" button
	Then I see "<juror_number>" on the page

	And I click link with ID "selectAllLink"
	And I press the "Send to..." button
	And I set input field with "id" of "sendToOfficer" to "CPASS"
	And I press the "Send" button
	And I press the "Send" button
	Then I see "Your work" on the page

	Then I click on the "Sign out" link
	When I log in as "CPASS"
	Then I see "<juror_number>" on the page
	Then I see "<juror_number>" has reply type indicator "DEFERRAL"

	When I click on "<juror_number>" in the same row as "<juror_number>"
	
	And I see "Juror details" on the page
	
	When I select "Deferral" from Process reply
	
	#continue with nothing selected
	And I press the "Continue" button
	And I see "There is a problem" on the page
	And I see "Select a reason for the deferral request" on the page
	And I see "Select a date to defer to" on the page
	
	#continue with only decision selected
	And I select "O - OTHER" from the "Reason for the deferral request" dropdown
	And I press the "Continue" button
	And I see "There is a problem" on the page
	And I see "Select a date to defer to" on the page

	#continue with only reason Accept and Other selected
	And I choose the "Choose a different date" radio button
	And I press the "Continue" button
	And I see "There is a problem" on the page
	And I see "Enter a date to defer this juror to" on the page
	
	#date validation - cant be silly value
	When I set input field with "id" of "deferralDate" to "1111/1111/1111"

	And I press the "Continue" button
	And I see "There is a problem" on the page
	And I see "Enter a date to defer to in the correct format, for example, 31/01/2023" on the page
	
	#date validation - cant be > 12 mos in the future
	When I set input field with "id" of "deferralDate" to "01/01/2050"
	
	And I press the "Continue" button
	And I see "There is a problem" on the page
	And I see "Date cannot be more than 12 months after the original summons date" on the page
	
	#select the radio buttons
	And I select the first deferral choice
	And I choose the "Choose a different date" radio button
	
	#can input the same date as one of the radio buttons
	When I set the "Deferral" single date field to a Monday "10" weeks in the future
	
	And I select "O - OTHER" from the "Reason for the deferral request" dropdown
	And I press the "Continue" button
	And I press the "Put in deferral maintenance" button
	Then I see the juror record updated banner containing "Deferral granted (other)"
	
Examples:
	|juror_number	|pool_number|last_name			|postcode	|email 		|
	|045200041		|452300040	|LNAMEFIVETWOZERO	|SW1H 9AJ	|e@eeee.com	|

