Feature: Regression English_3rd_ErrorChecks

@Regression
Scenario Outline: English_3rd_ErrorChecks

	Given I am on "Public" "demo"

	Given a bureau owned pool is created with jurors
		| court |juror_number  | pool_number	| att_date_weeks_in_future	| owner |
		| 452   |<juror_number>| <pool_number>	| 5				            | 400	|
	
	And juror "<juror_number>" has "LAST_NAME" as "<last_name>" new schema
	And juror "<juror_number>" has "POSTCODE" as "<postcode>" new schema
	
	Then I see "Reply to a jury summons" on the page
	
	Then I see "Are you replying for yourself or for someone else?" on the page
	
	When I press the "Continue" button
	Then I see "There is a problem" on the page
	And I see "Select if you are replying for yourself or for someone else" on the page
	When I set the radio button to "I am replying for someone else"
	And I press the "Continue" button
	Then I see "Their juror details" on the page
	
	When I press the "Continue" button
	Then I see "Enter their 9-digit juror number - you can find it on their jury summons letter" on the page
	And I see "You must enter their last name exactly as it's printed on their jury summons letter, even if it's wrong" on the page
	And I see "You must enter their postcode exactly as it's printed on their jury summons letter, even if it's wrong" on the page
	
	Then I click on the "Problems entering their details?" link
	And I see "If you've checked their details and still cannot continue, you can contact us." on the page
	And I see "Jury Central Summoning Bureau" on the page
	And I see "jurysummoning@justice.gov.uk" on the page
	And I see "Telephone: 0300 456 1024" on the page
	And I see "Monday to Thursday 9am to 5pm" on the page
	And I see "Friday 9am to 3pm" on the page
	And I see "Find out about call charges" on the page
	
	#Juror Log In (Find out how to trigger all messages)
	When I set "9-digit juror number" to "<juror_number>"
	When I set "Juror last name" to "<last_name>"
	When I set "Juror postcode" to "<postcode>"
	And I press the "Continue" button
	Then I see "What is your name?" on the page
	
	#Third Party Name
	When I press the "Continue" button
	Then I see "There is a problem" on the page
	And I see "Enter your first name" on the page
	And I see "Enter your last name" on the page
	When I set "First name" to "FirstName"
	And I set "Last name" to "LastName"
	And I press the "Continue" button
	Then I see "Your relationship to the person" on the page
	
	#Third Party Relationship
	When I press the "Continue" button
	Then I see "There is a problem" on the page
	And I see "Enter your relationship to the person summoned" on the page
	When I set "How do you know the person you're replying for?" to "Friend"
	And I press the "Continue" button
	Then I see "Your contact information" on the page
	
	#3rd Party Contact
	When I press the "Continue" button
	Then I see "There is a problem" on the page
	And I see "Choose a way for us to contact you" on the page
	
	When I check the "By phone (UK Numbers only)" checkbox
	And I check the "By email" checkbox
	And I press the "Continue" button
	Then I see "There is a problem" on the page
	And I see "Enter your main phone number" on the page
	And I see "Enter your email address" on the page
	
	And I see "Enter your email address and check that it matches the other one you have provided" on the page
	
	When I set "Main phone" to "02078211818"
	And I set "Enter your email address" to "email@outlook.com"
	And I set "Enter your email address again" to "Mismatched@outlook.com"
	And I press the "Continue" button
	Then I see "There is a problem" on the page
	And I see "Enter your email address" on the page
	And I see "Enter your email address and check that it matches the other one you have provided" on the page
	
	#new
	And I set "Enter your email address" to "<email>"
	And I set "Enter your email address again" to "<email>"
	
	#main starts with non 0
	When I set "Main phone" to "1207 821 1818"
	When I press the "Continue" button
	Then I see "There is a problem" on the page
	And I see "Enter your main phone number using digits only, no letters or special characters" on the page
	
	#main includes a letter
	When I set "Main phone" to "H207 821 1818"
	When I press the "Continue" button
	Then I see "There is a problem" on the page
	And I see "Enter your main phone number using digits only, no letters or special characters" on the page
	
	#main has all spaces
	When I set "Main phone" to "           "
	When I press the "Continue" button
	Then I see "There is a problem" on the page
	And I see "Enter your main phone number" on the page
	
	#main starts 01 and is followed by spaces
	When I set "Main phone" to "01         "
	When I press the "Continue" button
	Then I see "There is a problem" on the page
	And I see "Enter your main phone number using digits only, no letters or special characters" on the page
	
	#main has hyphens
	When I set "Main phone" to "0121-333-4444"
	Then I see "There is a problem" on the page
	And I see "Enter your main phone number using digits only, no letters or special characters" on the page
	
	#main has commas
	When I set "Main phone" to "0121,333,4444"
	Then I see "There is a problem" on the page
	And I see "Enter your main phone number using digits only, no letters or special characters" on the page
	
	#main begins 07 but only has 10 digits
	When I set "Main phone" to "0711111111"
	Then I see "There is a problem" on the page
	And I see "Enter your main phone number using digits only, no letters or special characters" on the page
	
	#main begins 01 but only has 9 digits
	When I set "Main phone" to "011111111"
	Then I see "There is a problem" on the page
	And I see "Enter your main phone number using digits only, no letters or special characters" on the page
	
	#main has too many spaces
	When I set "Main phone" to "01  21  123 444"
	When I press the "Continue" button
	Then I see "Why are you replying for the other person?" on the page
	And I click on the "Back" link
	
	#main prefixed with a space
	When I set "Main phone" to " 0121123444"
	When I press the "Continue" button
	Then I see "Why are you replying for the other person?" on the page
	And I click on the "Back" link
	
	#other starts with non 0
	When I set "Another phone (optional)" to "1207 821 1818"
	When I press the "Continue" button
	Then I see "There is a problem" on the page
	And I see "Enter your other phone number using digits only, no letters or special characters" on the page
	
	#other includes a letter
	When I set "Another phone (optional)" to "H207 821 1818"
	When I press the "Continue" button
	Then I see "There is a problem" on the page
	And I see "Enter your other phone number using digits only, no letters or special characters" on the page
		
	#other starts 01 and is followed by spaces
	When I set "Another phone (optional)" to "01         "
	When I press the "Continue" button
	Then I see "There is a problem" on the page
	And I see "Enter your other phone number using digits only, no letters or special characters" on the page
	
	#other has hyphens
	When I set "Another phone (optional)" to "0121-333-4444"
	Then I see "There is a problem" on the page
	And I see "Enter your other phone number using digits only, no letters or special characters" on the page
	
	#other has commas
	When I set "Another phone (optional)" to "0121,333,4444"
	Then I see "There is a problem" on the page
	And I see "Enter your other phone number using digits only, no letters or special characters" on the page
	
	#other begins 07 but only has 10 digits
	When I set "Another phone (optional)" to "0711111111"
	Then I see "There is a problem" on the page
	And I see "Enter your other phone number using digits only, no letters or special characters" on the page
	
	#other begins 01 but only has 9 digits
	When I set "Another phone (optional)" to "011111111"
	Then I see "There is a problem" on the page
	And I see "Enter your other phone number using digits only, no letters or special characters" on the page
	
	#other has too many spaces
	When I set "Another phone (optional)" to "01  21  123 444"
	When I press the "Continue" button
	Then I see "Why are you replying for the other person?" on the page
	And I click on the "Back" link
	
	#other prefixed with a space
	When I set "Another phone (optional)" to " 0121123444"
	When I press the "Continue" button
	Then I see "Why are you replying for the other person?" on the page
	And I click on the "Back" link
	
	#both invalid
	When I set "Main phone" to "011111111"
	When I set "Another phone (optional)" to "011111111"
	When I press the "Continue" button
	Then I see "There is a problem" on the page
	And I see "Enter your main phone number using digits only, no letters or special characters" on the page
	And I see "Enter your other phone number using digits only, no letters or special characters" on the page

	When I set "Main phone" to "0207 821 1818"
	When I set "Another phone (optional)" to ""
	
	#end new
	And I press the "Continue" button
	Then I see "Why are you replying for the other person?" on the page
	
	#Why Replying
	When I press the "Continue" button
	Then I see "There is a problem" on the page
	And I see "Tell us why you're replying for the person named on the jury summons" on the page
	
	When I set the radio button to "Other"
	And I press the "Continue" button
	Then I see "There is a problem" on the page
	And I see "Provide details about why you are replying for the other person" on the page
	
	When I set the radio button to "The person is not here"
	And I press the "Continue" button
	
	Then I see "Is the name we have for them correct?" on the page
	
	And I press the "Continue" button
	And I see "You need to tell us if we have the correct name for them" on the page
	
	#Check Juror Name
	#JDB-4281
	#JDB-4125
	When I choose the "No" radio button
	And I press the "Continue" button
	And I set "First name" to ""
	And I set "Last name" to ""
	And I press the "Continue" button
	Then I see "There is a problem" on the page
	And I see "Enter the person's first name" on the page
	And I see "Enter the person's last name" on the page
	When I set "First name" to "JurorFirstName"
	And I set "Last name" to "JurorLastName"
	And I press the "Continue" button
	Then I see "Is this their address?" on the page
	
	#Check address
	When I choose the "No" radio button
	And I press the "Continue" button
	And I set "Address line 1" to ""
	And I set "Town or city" to ""
	And I set "Postcode" to ""
	And I press the "Continue" button
	Then I see "There is a problem" on the page
	
	And I see "Provide the town or city" on the page
	And I see "Provide the first line of the address" on the page
	And I see "Enter the postcode" on the page
	
	When I set "Address line 1" to "|||"
	And I set "Town or city" to "|||"
	And I set "County" to "|||"
	And I set "Postcode" to "|||"
	And I press the "Continue" button
	Then I see "There is a problem" on the page

	And I see "Check the town or city" on the page
	And I see "Check the first line of the address" on the page
	And I see "Check the county" on the page
	And I see "Check the postcode" on the page
	When I set "Address line 1" to "123 ADDRESS LINE ONE"
	And I set "Town or city" to "London"
	And I set "County" to ""
	And I set "Postcode" to "CH1 2AN"
	And I press the "Continue" button
	Then I see "Give the date of birth for the person you're replying for" on the page
	
	#Juror DoB
	When I press the "Continue" button
	Then I see "There is a problem" on the page
	
	#JDB-4502
	And I see "Enter the day the person was born" on the page
	And I do not see "Enter the month the person was born" on the page
	And I do not see "Enter the year the person was born" on the page

	#only day is set
	When I set "Day" to "27"
	When I press the "Continue" button
	Then I see "There is a problem" on the page
	And I see "Enter the month the person was born" on the page
	
	#day and month are set
	And I set "Month" to "04"
	When I press the "Continue" button
	Then I see "There is a problem" on the page
	And I see "Enter the year the person was born" on the page
	
	#only year is set
	When I set "Day" to ""
	And I set "Month" to ""
	And I set "Year" to "1988"
	When I press the "Continue" button
	Then I see "There is a problem" on the page
	And I see "Enter the day the person was born" on the page
	And I do not see "Enter the month the person was born" on the page
	And I do not see "Enter the year the person was born" on the page
	
	When I set the date of birth to a Monday "-1500" weeks in the future
	And I press the "Continue" button
	Then I see "We might need to get in touch with the person to ask them more questions or give them information about their jury service" on the page
	
	#Contacting the Juror
	When I press the "Continue" button
	Then I see "There is a problem" on the page
	And I see "Select a phone number for us to use to contact you or the juror" on the page
	And I see "Select an email address for us to use to contact you or the juror" on the page

	When I set the radio button to "Give a different phone number for the juror"
	And I set the radio button to "Give a different email address for the juror"
	And I press the "Continue" button
	Then I see "There is a problem" on the page
	And I see "Enter their main phone number" on the page
	And I see "Enter their email address" on the page

	#JDB-3502 and JDB-3504 - only warns about email not phone
	And I press the "Continue" button

	Then I see "Enter their main phone number" on the page
	And I see "Enter their email address" on the page
	
	When I set "Main phone number" to "02078211818"
	And I set "Enter email address" to "email@outlook.com"
	And I set "Enter the email address again" to "mismatch@outlook.com"
	And I press the "Continue" button
	Then I see "Enter their email address and check that it matches the other one you have provided" on the page

	And I set "Enter email address" to "<email>"
	And I set "Enter the email address again" to "<email>"
	When I set "Main phone number" to ""
	And I set "Another phone number" to ""
	
	#main starts with non 0
	When I set "Main phone" to "1207 821 1818"
	When I press the "Continue" button
	Then I see "There is a problem" on the page
	And I see "Enter their main phone number using digits only, no letters or special characters" on the page
	
	#main includes a letter
	When I set "Main phone" to "H207 821 1818"
	When I press the "Continue" button
	Then I see "There is a problem" on the page
	And I see "Enter their main phone number using digits only, no letters or special characters" on the page
	
	#main has all spaces
	When I set "Main phone" to "           "
	When I press the "Continue" button
	Then I see "There is a problem" on the page
	And I see "Enter their main phone number" on the page
	
	#main starts 01 and is followed by spaces
	When I set "Main phone" to "01         "
	When I press the "Continue" button
	Then I see "There is a problem" on the page
	And I see "Enter their main phone number using digits only, no letters or special characters" on the page
	
	#main has hyphens
	When I set "Main phone" to "0121-333-4444"
	Then I see "There is a problem" on the page
	And I see "Enter their main phone number using digits only, no letters or special characters" on the page
	
	#main has commas
	When I set "Main phone" to "0121,333,4444"
	Then I see "There is a problem" on the page
	And I see "Enter their main phone number using digits only, no letters or special characters" on the page
	
	#main begins 07 but only has 10 digits
	When I set "Main phone" to "0711111111"
	Then I see "There is a problem" on the page
	And I see "Enter their main phone number using digits only, no letters or special characters" on the page
	
	#main begins 01 but only has 9 digits
	When I set "Main phone" to "011111111"
	Then I see "There is a problem" on the page
	And I see "Enter their main phone number using digits only, no letters or special characters" on the page
	
	#main has too many spaces
	When I set "Main phone" to "01  21  123 444"
	When I press the "Continue" button
	Then I see "Confirm if the person is eligible for jury service" on the page
	And I click on the "Back" link
	
	#main prefixed with a space
	When I set "Main phone" to " 0121123444"
	When I press the "Continue" button
	Then I see "Confirm if the person is eligible for jury service" on the page
	And I click on the "Back" link
	
	#other starts with non 0
	When I set "Another phone number (optional)" to "1207 821 1818"
	When I press the "Continue" button
	Then I see "There is a problem" on the page
	And I see "Enter their other phone number using digits only, no letters or special characters" on the page
	
	#other includes a letter
	When I set "Another phone number (optional)" to "H207 821 1818"
	When I press the "Continue" button
	Then I see "There is a problem" on the page
	And I see "Enter their other phone number using digits only, no letters or special characters" on the page
		
	#other starts 01 and is followed by spaces
	When I set "Another phone number (optional)" to "01         "
	When I press the "Continue" button
	Then I see "There is a problem" on the page
	And I see "Enter their other phone number using digits only, no letters or special characters" on the page
	
	#other has hyphens
	When I set "Another phone number (optional)" to "0121-333-4444"
	Then I see "There is a problem" on the page
	And I see "Enter their other phone number using digits only, no letters or special characters" on the page
	
	#other has commas
	When I set "Another phone number (optional)" to "0121,333,4444"
	Then I see "There is a problem" on the page
	And I see "Enter their other phone number using digits only, no letters or special characters" on the page
	
	#other begins 07 but only has 10 digits
	When I set "Another phone number (optional)" to "0711111111"
	Then I see "There is a problem" on the page
	And I see "Enter their other phone number using digits only, no letters or special characters" on the page
	
	#other begins 01 but only has 9 digits
	When I set "Another phone number (optional)" to "011111111"
	Then I see "There is a problem" on the page
	And I see "Enter their other phone number using digits only, no letters or special characters" on the page
	
	#other has too many spaces
	When I set "Another phone number (optional)" to "01  21  123 444"
	When I press the "Continue" button
	Then I see "Confirm if the person is eligible for jury service" on the page
	And I click on the "Back" link
	
	#other prefixed with a space
	When I set "Another phone number (optional)" to " 0121123444"
	When I press the "Continue" button
	Then I see "Confirm if the person is eligible for jury service" on the page
	And I click on the "Back" link
	
	#both invalid
	When I set "Main phone" to "011111111"
	When I set "Another phone number (optional)" to "011111111"
	When I press the "Continue" button
	Then I see "There is a problem" on the page
	And I see "Enter their other phone number using digits only, no letters or special characters" on the page
	And I see "Enter their other phone number using digits only, no letters or special characters" on the page
	
	When I set the radio button to "Use the phone number that you have already given to contact you"
	And I set the radio button to "Use the email address that you have already given to contact you"
	And I press the "Continue" button
	
	#Eligibility
	Then I see "Confirm if the person is eligible for jury service" on the page
	
	When I press the "Continue" button
	
	#Residency Yes
	Then I see "Since they turned 13, has their main address been in the UK, Channel Islands or Isle of Man for any period of at least 5 years?" on the page
	When I press the "Continue" button
	Then I see "There is a problem" on the page
	And I see error "Select yes if their main address has been in the UK, Channel Islands or Isle of Man for any period of at least 5 years, since they turned 13"
	When I choose the "No" radio button
	And I see "Provide details about where the person you are answering for has lived since their 13th birthday" on the page
	And I press the "Continue" button
	Then I see "There is a problem" on the page
	And I see error "Provide details about where the person you are answering for has lived since their 13th birthday"
	
	When I choose the "Yes" radio button
	And I press the "Continue" button
	
	#CJS no
	Then I see "Has the person you're replying for worked in the criminal justice system in the last 5 years?" on the page
	When I press the "Continue" button
	Then I see "There is a problem" on the page
	And I see error "Select whether the person you're replying for has worked in the criminal justice system in the last 5 years"
	When I choose the "Yes" radio button
	Then I see "Choose any organisations the person you're replying for has worked for" on the page
	And I press the "Continue" button
	Then I see error "Tick any organisations the person worked for directly (not as a third party or subcontractor)"
	
	When I check the "Police service" checkbox
	Then I see "Which police service?" on the page
	And I check the "HM Prison Service" checkbox
	Then I see "Which part of HM Prison Service?" on the page
	And I check the "Other" checkbox
	And I see "Which other part of the Criminal Justice System?" on the page
	And I press the "Continue" button
	Then I see error "Give details of where and when the person worked for the police service"
	Then I see error "Give details of where and when the person worked for HM Prison Service"
	Then I see error "Give details of where and when the person has worked for another Criminal Justice System employer"
	
	When I choose the "No" radio button
	And I press the "Continue" button
	
	#Bail no
	Then I see "Is the person currently on bail for a criminal offence?" on the page
	When I press the "Continue" button
	Then I see "There is a problem" on the page
	And I see error "Select yes if the person is currently on bail for a criminal offence"
	
	When I choose the "Yes" radio button
	Then I see "Provide details about the person's bail and criminal offence" on the page
	And I press the "Continue" button
	Then I see "There is a problem" on the page
	And I see error "Provide details about the person's bail and criminal offence"
	
	When I choose the "No" radio button
	And I press the "Continue" button
	
	#Convictions no
	Then I see "Has the person been found guilty of a criminal offence?" on the page
	When I press the "Continue" button
	Then I see "There is a problem" on the page
	And I see error "Select yes if the person has been found guilty of a criminal offence"
	
	When I choose the "Yes" radio button
	Then I see "Provide details about the person's criminal offence" on the page
	And I press the "Continue" button
	Then I see "There is a problem" on the page
	And I see error "Provide details about the person's criminal offence"
	
	When I choose the "No" radio button
	And I press the "Continue" button
	
	#Mental health part 1 no
	Then I see "Is the person you're replying for being detained, looked after or treated under the Mental Health Act?" on the page
	When I press the "Continue" button
	Then I see "There is a problem" on the page
	And I see error "Select yes if the person you're replying for is being detained, looked after or treated under the Mental Health Act"
	
	When I choose the "Yes" radio button
	Then I see "Provide details about how they're being detained, looked after or treated under the Mental Health Act" on the page
	And I press the "Continue" button
	Then I see "There is a problem" on the page
	And I see error "Provide details about how they're being detained, looked after or treated under the Mental Health Act"
	
	When I choose the "No" radio button
	And I press the "Continue" button
	
	#Mental health part 2 no
	Then I see "Has it been decided that the person you're replying for 'lacks mental capacity'?" on the page
	When I press the "Continue" button
	Then I see "There is a problem" on the page
	And I see error "Select yes if it's been decided that the person you're replying for 'lacks mental capacity'"
	
	When I choose the "Yes" radio button
	Then I see "Provide brief details about why it was decided they lack mental capacity" on the page
	And I press the "Continue" button
	Then I see "There is a problem" on the page
	Then I see error "Provide brief details about why it was decided they lack mental capacity"
	
	When I choose the "No" radio button
	And I press the "Continue" button
	
	#I can attend
	Then I see "Check your start date" on the page
	When I press the "Continue" button
	And I see "There is a problem" on the page
	And I see "Select whether the person can start jury service on this date" on the page
	
	Then I set the radio button to "Yes, they can start on"
	And  I press the "Continue" button
	
	#RA no
	Then I see "Will the person you're replying for need help when they're at the court?" on the page
	When I press the "Continue" button
	Then I see "There is a problem" on the page
	And I see "Select yes if the person you are answering for will need help when they're at court" on the page
	
	When I choose the "Yes" radio button
	And I press the "Continue" button
	
	#JDB-3638
	Then I see "Select if they have limited mobility, a hearing impairment, diabetes, a severe sight impairment or other disability or impairment" on the page
	
	When I check the "Other" checkbox
	And I press the "Continue" button
	Then I see "There is a problem" on the page

	When I choose the "No" radio button
	And I press the "Continue" button
	
	#Check Your Answers
	Then I see "Check your answers now" on the page
	Then I see "Has it been decided that the person you're replying for 'lacks mental capacity'?" on the page
	Then I see "Is the person you're replying for being detained, looked after or treated under the Mental Health Act?" on the page
	
	When I press the "Submit" button
	Then I see "There is a problem" on the page
	Then I see "Confirm that this information is correct before submitting this summons reply" on the page
	
	When I click on the "Change" link in the same row as "Confirm the date of their jury service"
	Then I see "Check your start date" on the page
	
	#deferral
	When I set the radio button to "No, we need to change the date"
	And I press the "Continue" button
	Then I see "Tell us why they need another date for their jury service" on the page
	
	#Deferral Reason
	When I press the "Continue" button
	Then I see "There is a problem" on the page
	And I see "Enter their reason for needing another date for jury service" on the page
	
	When I set text area with "id" of "deferralReason" to "askForAnotherDateReasonWhy"
	And I press the "Continue" button
	Then I see "Choose 3 Mondays when they can start jury service" on the page
	
	#Deferral Dates JDB-3524
	When I press the "Continue" button
	
	Then on the page I see
	|text|
	|There is a problem|
	|Enter the first Monday they'd prefer to start jury service|
	|Enter the second Monday they'd prefer to start jury service|
	|Enter the third Monday they'd prefer to start jury service|
	
	When I set the "First" single date field to a Monday "6" weeks in the future
	When I set the "Second" single date field to a Monday "10" weeks in the future
	When I set the "Third" single date field to a Monday "10" weeks in the future

	And I press the "Continue" button
	Then I see "There is a problem" on the page
	And I see "Enter a date that's different to the other choices" on the page
	
	When I set the "First" single date field to a Monday "100" weeks in the future
	When I set the "Second" single date field to a Monday "101" weeks in the future
	When I set the "Third" single date field to a Monday "102" weeks in the future
	And I press the "Continue" button
	Then I see "There is a problem" on the page
	And I see "Their first choice must be a Monday between" on the page
	And I see "Their second choice must be a Monday between" on the page
	And I see "Their third choice must be a Monday between" on the page
	
	When I set the "First" single date field to a Monday "6" weeks in the future
	When I set the "Second" single date field to a Monday "7" weeks in the future
	When I set the "Third" single date field to a Monday "8" weeks in the future
	And I press the "Continue" button
	
	#confirm
	And I choose the "Yes" radio button
	And I press the "Continue" button
	
	Then I see "Check your answers now" on the page
	
	#Check Your Answers
	When I click on the "Change" link in the same row as "Confirm the date of their jury service"
	Then I see "Check your start date" on the page
	
	When I set the radio button to "No, they cannot do"  
	And I press the "Continue" button
	Then I see "Why do they need to be excused from jury service?" on the page
	
	#Excusal Reason
	When I press the "Continue" button
	Then I see "There is a problem" on the page
	And I see "Enter reason why they cannot do jury service in the next 12 months" on the page
	
	When I set text area with "name" of "excusalReason" to "Excuse them please"
	And I press the "Continue" button
	Then I see "Check your answers now" on the page
	
	#When I press the "Submit" button
	When I check the "The answers I have given for the person I'm replying for are true as far as I know." checkbox
	And I press the "Submit" button
	Then I see "We have sent an email to say you have replied to this jury summons." on the page
	
Examples:
	| juror_number	| last_name			| postcode	| email           	| pool_number	|
	| 045200088		| LNAMENINEEIGHTTWO	| CH1 2AN	| email@outlook.com	| 452300087		|