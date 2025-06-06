Feature: JDB-3635

@Regression
Scenario Outline: Checking that TP is visible in all 3rd Party browser URLs after 3rd party specific screens

	Given I am on "Public" "ithc"

	Given a bureau owned pool is created with jurors
		| court |juror_number  | pool_number	| att_date_weeks_in_future	| owner |
		| 452   |<juror_number>| <pool_number>	| 5				            | 400	|
		
	And juror "<juror_number>" has "LAST_NAME" as "<last_name>" new schema
	And juror "<juror_number>" has "POSTCODE" as "<postcode>" new schema
	
	Then I see "Reply to a jury summons" on the page
	
	And I set the radio button to "I am replying for someone else"
	And I press the "Continue" button
	Then I see "Their juror details" on the page
	
	#Juror Log In
	When I see "/tp" in the URL
	When I set "9-digit juror number" to "<juror_number>"
	When I set "Juror last name" to "<last_name>"
	When I set "Juror postcode" to "<postcode>"
	And I press the "Continue" button
	Then I see "What is your name?" on the page
	
	#3rd Party Name
	When I see "Your Details" on the page
	When I set "First name" to "FirstNameA"
	And I set "Last name" to "LastNameB"
	And I press the "Continue" button
	Then I see "Your relationship to the person" on the page
	
	#Relationship to juror
	When I see "Your Details" on the page
	And I set "How do you know the person you're replying for?" to "Friend"
	And I press the "Continue" button
	Then I see "Your contact information" on the page
	
	#3rd Party Contact
	When I see "Your Details" on the page
	And I check the "By phone (UK Numbers only)" checkbox
	And I set "Main phone" to "0207 821 1818"
	And I check the "By email" checkbox
	And I set "Enter your email address" to "email@outlook.com"
	And I set "Enter your email address again" to "email@outlook.com"
	And I press the "Continue" button
	
	#Why are you replying title
	Then I see "Why are you replying for the other person?" on the page
	And I do not see "Why are you replying?" on the page
	
	#Why are you replying for the person?
	When I set the radio button to "The person is not here"
	And I press the "Continue" button
	
	Then I see "Is the name we have for them correct?" on the page
	When I choose the "Yes" radio button
	And I press the "Continue" button
	Then I see "Is this their address?" on the page
	When I choose the "Yes" radio button
	And I press the "Continue" button
	And I press the "Continue" button
	Then I see "Give the date of birth for the person you're replying for" on the page
	
	#DoB
	When I see "Juror Details" on the page
	And I set "Day" to "01"
	And I set "Month" to "01"
	And I set "Year" to "2000"
	And I press the "Continue" button
	Then I see "We might need to get in touch with the person to ask them more questions or give them information about their jury service" on the page
	
	#Contacting the juror
	When I see "Juror Details" on the page
	And I set the radio button to "Use the phone number that you have already given to contact you"
	And I set the radio button to "Use the email address that you have already given to contact you"
	And I press the "Continue" button
	
	#Qualify for jury service
	When I see "Confirm if the person is eligible for jury service" on the page
	And I see "/tp" in the URL
	And I press the "Continue" button
	Then I see "Since they turned 13, has their main address been in the UK, Channel Islands or Isle of Man for any period of at least 5 years?" on the page
	
	#Residency
	When I see "Eligibility" on the page
	And I see "/tp" in the URL
	And I choose the "Yes" radio button
	And I press the "Continue" button
	
	#CJS no
	Then I see "Has the person you're replying for worked in the criminal justice system in the last 5 years?" on the page
	When I choose the "No" radio button
	And I see "/tp" in the URL
	And I press the "Continue" button
	
	#Bail
	Then I see "Is the person currently on bail for a criminal offence?" on the page
	When I see "Eligibility" on the page
	And I see "/tp" in the URL
	And I choose the "No" radio button
	And I press the "Continue" button
	
	#Convictions
	Then I see "Has the person been found guilty of a criminal offence?" on the page
	When I see "Eligibility" on the page
	And I see "/tp" in the URL
	When I choose the "No" radio button
	And I press the "Continue" button

	#Mental Health Sectioned
	Then I see "Is the person you're replying for being detained, looked after or treated under the Mental Health Act?" on the page
	When I see "Eligibility" on the page
	And I see "/tp" in the URL
	And I choose the "No" radio button
	And I press the "Continue" button
	
	#Mental Health Capacity
	Then I see "Has it been decided that the person you're replying for 'lacks mental capacity'?" on the page
	When I see "Eligibility" on the page
	And I see "/tp" in the URL
	And I choose the "No" radio button
	And I press the "Continue" button
	
	#The person can attend
	Then I see "Check your start date" on the page
	Then I set the radio button to "Yes, they can start on"
	And I see "/tp" in the URL
	And  I press the "Continue" button
	
	#RA no
	Then I see "Will the person you're replying for need help when they're at the court?" on the page
	When I choose the "No" radio button
	And I see "/tp" in the URL
	And I press the "Continue" button
	
	#Check your answers
	Then I see "Check your answers now" on the page
	When I see "/tp" in the URL
	And I click on the "Change" link in the same row as "Confirm the date of their jury service"
	Then I see "Check your start date" on the page
	And I see "/tp" in the URL
	When I set the radio button to "No, we need to change the date"
	And I press the "Continue" button
	Then I see "Tell us why they need another date for their jury service" on the page
	
	#Deferral Reason
	When I see "/tp" in the URL
	And I set text area with "id" of "deferralReason" to "Defer me please"
	And I press the "Continue" button
	Then I see "Choose 3 Mondays when they can start jury service" on the page
	
	#Deferral Dates
	When I see "/tp" in the URL
	When I set the "First" single date field to a Monday "6" weeks in the future
	When I set the "Second" single date field to a Monday "7" weeks in the future
	When I set the "Third" single date field to a Monday "8" weeks in the future
	
	And I press the "Continue" button

	And I see "/tp" in the URL
	
	#confirm
	And I choose the "Yes" radio button
	And I press the "Continue" button
	
	#Check your answers now
	And I click on the "Change" link in the same row as "Confirm the date of their jury service"
	Then I see "Check your start date" on the page
	And I see "/tp" in the URL
	When I set the radio button to "No, they cannot do"  
	And I press the "Continue" button
	Then I see "Why do they need to be excused from jury service?" on the page
	
	#Excusal Reason
	When I see "/tp" in the URL
	And I set text area with "id" of "excusalReason" to "Excuse me please"
	And I press the "Continue" button
	Then I see "Check your answers now" on the page
	
	#Check your answers now
	And I click on the "Change" link in the same row as "Confirm the date of their jury service"
	Then I see "Check your start date" on the page
	And I see "/tp" in the URL
	Then I set the radio button to "Yes, they can start on"
	And I press the "Continue" button
	Then I see "Check your answers now" on the page
	
	When I check the "The answers I have given for the person I'm replying for are true as far as I know." checkbox
	And I press the "Submit" button
	
	#When I press the "Submit" button
	Then I see "We have sent an email to say you have replied to this jury summons." on the page
	And I see "/tp" in the URL
	
Examples:
	| juror_number	| last_name	| postcode	| email           	| pool_number	|
	| 045200182		| DOE		| SW1H 9AJ	| email@outlook.com	| 452300167		|