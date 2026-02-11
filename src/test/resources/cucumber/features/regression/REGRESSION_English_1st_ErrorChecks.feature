Feature: Regression English_1st_ErrorChecks

@Regression
Scenario Outline: English 1st ErrorChecks - status is Undeliverable

	Given I am on "Bureau" "ithc"

	Given a bureau owned pool is created with jurors
		| court |juror_number  | pool_number	| att_date_weeks_in_future	| owner |
		| 452   |<juror_number>| <pool_number>	| 5				            | 400	|

	And juror "<juror_number>" has "LAST_NAME" as "<last_name>" new schema
	And juror "<juror_number>" has "POSTCODE" as "<postcode>" new schema

	And I log in as "MODTESTBUREAU"
	And I search for juror "<juror_number>"
	And I press the "Update juror record" button
	And I choose the "Mark summons as undeliverable" radio button
	And I press the "Continue" button
	Then I see the juror record updated banner containing "Summons undeliverable"

	Given I am on "Public" "ithc"

	Then I see "Reply to a jury summons" on the page
	Then I see "Are you replying for yourself or for someone else?" on the page

	When I set the radio button to "I am replying for myself"
	And I press the "Continue" button
	
	Then I see "Your juror details" on the page
	When I press the "Continue" button
	Then I see "Enter your 9-digit juror number - you can find it on your jury summons letter" on the page
	And I see "You must enter your last name exactly as it's printed on your jury summons letter, even if it's wrong" on the page
	And I see "You must enter your postcode exactly as it's printed on your jury summons letter, even if it's wrong" on the page
	Then I click on the "Problems entering your details?" link
	And I see "If you've checked your details and still cannot continue, you can contact us." on the page
	And I see "Jury Central Summoning Bureau" on the page
	And I see "jurysummoning@justice.gov.uk" on the page
	And I see "Telephone: 0300 456 1024" on the page
	And I see "Monday to Thursday 9am to 5pm" on the page
	And I see "Friday 9am to 3pm" on the page
	And I see "Find out about call charges" on the page

	#Juror Log In
	When I set "9-digit juror number" to "<juror_number>"
	And I set "Juror last name" to "<last_name>"
	And I set "Juror postcode" to "<postcode>"
	And I press the "Continue" button

	And I see "Our records show you've already replied to this jury summons" on the page
	And I see "If you want to tell us about changes or we've asked you for more information, you need to contact us by email, telephone or letter." on the page
	And I see "Jury Central Summoning Bureau" on the page
	And I see "jurysummoning@justice.gov.uk" on the page
	And I see "Telephone: 0300 456 1024" on the page
	And I see "Monday to Thursday 9am to 5pm" on the page
	And I see "Friday 9am to 3pm" on the page
	And I see "Find out about call charges" on the page

	And I see "Jury Central Summoning Bureau" on the page
	And I see "Phoenix House" on the page
	And I see "Rushton Avenue" on the page
	And I see "Bradford" on the page
	And I see "BD3 7BH" on the page

	And I see "You cannot tell us extra information through this digital service." on the page
	
	Examples:
	|juror_number	|last_name	|postcode   |pool_number|
	|045200045		|DOE		|SW1H 9AJ	|452300044	|

@Regression
Scenario Outline: English_1st_ErrorChecks - Court date is in the past

	Given I am on "Public" "ithc"

	Given a bureau owned pool is created with jurors
		| court |juror_number  | pool_number	| att_date_weeks_in_future	| owner |
		| 452   |<juror_number>| <pool_number>	| -1			            | 400	|
		
	And juror "<juror_number>" has "LAST_NAME" as "<last_name>" new schema
	And juror "<juror_number>" has "POSTCODE" as "<postcode>" new schema
	
	Then I see "Reply to a jury summons" on the page
	
	Then I see "Are you replying for yourself or for someone else?" on the page

	When I set the radio button to "I am replying for myself"
	And I press the "Continue" button
	Then I see "Your juror details" on the page
	
	#Juror Log In
	When I set "9-digit juror number" to "<juror_number>"
	When I set "Juror last name" to "<last_name>"
	When I set "Juror postcode" to "<postcode>"
	And I press the "Continue" button
	Then I see "You can no longer complete this summons reply online" on the page
	Then I see "This is because the summons date has passed. You must contact us by phone or email." on the page
	And I see "/steps/login/summons-date" in the URL
	
	Examples:
	|juror_number	|last_name	|postcode	|pool_number|
	|045200046		|DOE		|SW1H 9AJ	|452300045	|
	
@Regression
Scenario Outline: English_1st_ErrorChecks

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
	When I set the radio button to "I am replying for myself"
	And I press the "Continue" button
	Then I see "Your juror details" on the page
	
	#Juror Log In (Find out how to trigger all messages)
	When I set "9-digit juror number" to "<juror_number>"
	When I set "Juror last name" to "<last_name>"
	When I set "Juror postcode" to "<postcode>"
	And I press the "Continue" button
	Then I see "Is the name we have for you correct?" on the page
	
	#Check name
	When I press the "Continue" button
	And I see "You need to tell us if we have the correct name for you" on the page
	
	When I choose the "No" radio button
	When I press the "Continue" button
	And I set "First name" to ""
	And I set "Last name" to ""
	And I press the "Continue" button
	Then I see "There is a problem" on the page
	And I see "Enter your first name" on the page
	And I see "Enter your last name" on the page
	When I set "First name" to "FirstName"
	And I set "Last name" to "LastName"
	And I press the "Continue" button
	Then I see "Is this your address?" on the page
	
	#Check address
	When I choose the "No" radio button
	When I press the "Continue" button
	And I set "Address line 1" to ""
	And I set "Town or city" to ""
	And I set "Postcode" to ""
	And I press the "Continue" button
	Then I see "There is a problem" on the page

	And I see "Provide the town or city you live in" on the page
	And I see "Provide the first line of your address" on the page
	And I see "Enter your postcode" on the page
	
	#Checking Invalids check with Jorge
	When I set "Address line 1" to "|||"
	And I set "Town or city" to "|||"
	And I set "County" to "|||"
	And I set "Postcode" to "|||"
	And I press the "Continue" button

	Then I see "There is a problem" on the page
	Then I see "Check the first line of your address" on the page
	And I see "Check the town or city you live in" on the page
	Then I see "Check your county" on the page
	And I see "Check your postcode" on the page
	
	When I set "Address line 1" to "123 ADDRESS LINE ONE"
	And I set "Town or city" to "London"
	And I set "County" to ""
	And I set "Postcode" to "CH1 2AN"
	And I press the "Continue" button
	Then I see "What is your phone number?" on the page
	
	#Phone details
	When I press the "Continue" button
	Then I see "There is a problem" on the page
	And I see "Enter your main phone number" on the page
	
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
	Then I see "What is your email address?" on the page
	And I click on the "Back" link
	
	#main prefixed with a space
	When I set "Main phone" to " 0121123444"
	When I press the "Continue" button
	Then I see "What is your email address?" on the page
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
	Then I see "What is your email address?" on the page
	And I click on the "Back" link
	
	#other prefixed with a space
	When I set "Another phone (optional)" to " 0121123444"
	When I press the "Continue" button
	Then I see "What is your email address?" on the page
	And I click on the "Back" link
	
	#both invalid
	When I set "Main phone" to "011111111"
	When I set "Another phone (optional)" to "011111111"
	When I press the "Continue" button
	Then I see "There is a problem" on the page
	And I see "Enter your other phone number using digits only, no letters or special characters" on the page
	And I see "Enter your other phone number using digits only, no letters or special characters" on the page

	When I set "Main phone" to "0207 821 1818"
	When I set "Another phone (optional)" to ""
	And I press the "Continue" button
	Then I see "What is your email address?" on the page
	
	#Email details
	When I press the "Continue" button
	Then I see "There is a problem" on the page
	And I see "Enter your email address" on the page

	When I set "Enter your email address" to "email@outlook.com"
	And I press the "Continue" button
	Then I see "Enter your email address and check that it matches the one in the first field" on the page
	
	When I set "Enter your email address" to "<email>"
	And I set "Enter your email address again" to "<email>"
	And I press the "Continue" button
	Then I see "What is your date of birth?" on the page
	
	#DoB
	When I press the "Continue" button
	Then I see "There is a problem" on the page
	
	#JDB-4502
	And I see "Enter the day you were born" on the page
	And I do not see "Enter the month you were born" on the page
	And I do not see "Enter the year you were born" on the page

	#only day is set
	When I set "Day" to "27"
	When I press the "Continue" button
	Then I see "There is a problem" on the page
	And I see "Enter the month you were born" on the page
	
	#day and month are set
	And I set "Month" to "04"
	When I press the "Continue" button
	Then I see "There is a problem" on the page
	And I see "Enter the year you were born" on the page
	
	#only year is set
	When I set "Day" to ""
	And I set "Month" to ""
	And I set "Year" to "1988"
	When I press the "Continue" button
	Then I see "There is a problem" on the page
	And I see "Enter the day you were born" on the page
	And I do not see "Enter the month you were born" on the page
	And I do not see "Enter the year you were born" on the page
	
	When I set "Day" to "27"
	And I set "Month" to "04"
	And I set "Year" to "198a"
	And I press the "Continue" button
	Then I see "There is a problem" on the page
	And I see "Enter the year you were born as a 4 digit number. For example, 1982" on the page
	
	When I set the date of birth to a Monday "-1500" weeks in the future
	And I press the "Continue" button
	
	Then I see "Confirm you're eligible for jury service" on the page
	
	When I press the "Continue" button
	
	#Residency Yes
	Then I see "Have you lived in the UK, Channel Islands or Isle of Man for more than five consecutive years, since your 13th birthday?" on the page
	When I press the "Continue" button
	Then I see "There is a problem" on the page
	And I see "Select yes if your main address has been in the UK, Channel Islands or Isle of Man for any period of at least 5 years, since you turned 13" on the page

	When I choose the "No" radio button
	And I see "Provide details about where you have lived since your 13th birthday" on the page
	And I press the "Continue" button
	Then I see "There is a problem" on the page
	Then I see error "Provide details about where you have lived since your 13th birthday"
	And I see "Provide details about where you have lived since your 13th birthday" on the page
	
	When I choose the "Yes" radio button
	And I press the "Continue" button
	
	#CJS no
	Then I see "Have you worked in the criminal justice system in the last 5 years?" on the page
	When I press the "Continue" button
	Then I see "There is a problem" on the page
	And I see error "Select whether you've worked in the criminal justice system in the last 5 years"
	When I choose the "Yes" radio button
	And I see "Choose any organisations you have worked for" on the page
	And I press the "Continue" button
	Then I see error "Tick any organisations you worked for directly (not as a third party or subcontractor)"
	
	When I check the "Police service" checkbox
	And I see "Which police service?" on the page
	And I check the "HM Prison Service" checkbox
	And I see "Which part of HM Prison Service?" on the page
	And I check the "Other" checkbox
	And I see "Which other part of the Criminal Justice System?" on the page
	And I press the "Continue" button
	Then I see error "Give details of where and when you have worked for the police service"
	Then I see "Give details of where and when you have worked for HM Prison Service" on the page
	Then I see error "Give details of where and when you have worked for another Criminal Justice System employer"
	
	When I choose the "No" radio button
	And I press the "Continue" button
	
	#Bail no
	Then I see "Are you currently on bail for a criminal offence?" on the page
	When I press the "Continue" button
	Then I see "There is a problem" on the page
	And I see error "Select yes if you are currently on bail for a criminal offence"
	
	When I choose the "Yes" radio button
	Then I see "Provide details about your bail and criminal offence" on the page
	And I press the "Continue" button
	Then I see "There is a problem" on the page
	And I see error "Provide details about your bail and criminal offence"
	
	When I choose the "No" radio button
	And I press the "Continue" button
	
	#Convictions no
	Then I see "Have you been found guilty of a criminal offence?" on the page
	When I press the "Continue" button
	Then I see "There is a problem" on the page
	And I see error "Select yes if you have been found guilty of a criminal offence"
	
	When I choose the "Yes" radio button
	Then I see "Provide details about your criminal offence" on the page
	And I press the "Continue" button
	Then I see "There is a problem" on the page
	And I see error "Provide details about your criminal offence"
		
	When I choose the "No" radio button
	And I press the "Continue" button
	
	#Mental health part 1 no
	Then I see "Are you being detained, looked after or treated under the Mental Health Act?" on the page
	When I press the "Continue" button
	Then I see "There is a problem" on the page
	And I see error "Select yes if you're being detained, looked after or treated under the Mental Health Act"
	
	When I choose the "Yes" radio button
	Then I see "Provide details about how you're being detained, looked after or treated under the Mental Health Act" on the page
	And I press the "Continue" button
	Then I see "There is a problem" on the page
	And I see error "Provide details about how you're being detained, looked after or treated under the Mental Health Act"
	
	When I choose the "No" radio button
	And I press the "Continue" button
	
	#Mental health part 2 no
	Then I see "Has it been decided that you 'lack mental capacity'?" on the page
	And I see "This means, legally, you cannot make decisions for yourself." on the page
	When I press the "Continue" button
	Then I see "There is a problem" on the page
	And I see error "Select yes if it's been decided that you 'lack mental capacity'"

	When I choose the "Yes" radio button
	Then I see "Provide brief details about why it was decided you lack mental capacity" on the page
	And I press the "Continue" button
	Then I see "There is a problem" on the page
	And I see error "Provide brief details about why it was decided you lack mental capacity"
	
	When I choose the "No" radio button
	And I press the "Continue" button
	
	#I can attend
	Then I see "Check your start date" on the page
	When I press the "Continue" button
	Then I see "There is a problem" on the page
	And I see "Select whether you can start jury service on this date" on the page
	
	When I set the radio button to "Yes, I can start on"
	And  I press the "Continue" button
	
	#RA no
	Then I see "Will you need help when you're at the court?" on the page
	When I press the "Continue" button
	Then I see "There is a problem" on the page
	And I see "Select yes if you will need help when you're at court" on the page
	
	When I choose the "Yes" radio button
	And I press the "Continue" button
	Then I see "There is a problem" on the page
	
	#JDB-3638
	And I see "Select if you have limited mobility, a hearing impairment, diabetes, a severe sight impairment or other disability or impairment" on the page
	
	When I check the "Other" checkbox
	And I press the "Continue" button
	Then I see "There is a problem" on the page
	And I see "Give details of your disability or impairment" on the page
	
	When I choose the "No" radio button
	And I press the "Continue" button
	
	#Check Your Answers
	Then I see "Check your answers now" on the page
	When I press the "Submit" button
	Then I see "There is a problem" on the page
	Then I see "Confirm that this information is correct before submitting this summons reply" on the page
	
	When I click on the "Change" link in the same row as "Confirm the date of your jury service"
	Then I see "Check your start date" on the page
	
	When I set the radio button to "No, I need to change the date"
	And I press the "Continue" button
	Then I see "Tell us why you need another date for your jury service" on the page
	
	#Deferral Reason
	When I press the "Continue" button
	Then I see "There is a problem" on the page
	And I see "Enter your reason for needing another date for jury service" on the page
	
	When I set text area with "id" of "deferralReason" to "Defer me please"
	And I press the "Continue" button
	Then I see "Choose 3 Mondays when you can start jury service" on the page
	
	#Deferral Dates
	When I press the "Continue" button
	Then I see "There is a problem" on the page
	And I see "Enter the first Monday you'd prefer to start jury service" on the page
	And I see "Enter the second Monday you'd prefer to start jury service" on the page
	And I see "Enter the third Monday you'd prefer to start jury service" on the page

	#invalid input
	When I set "First choice" to "12 July"
	When I set "Second choice" to "13 July"
	When I set "Third choice" to "14 July"

	When I press the "Continue" button
	Then I see "There is a problem" on the page
	And I see "Enter the first Monday you'd prefer to start jury service using the dd/mm/yyyy format" on the page
	And I see "Enter the second Monday you'd prefer to start jury service using the dd/mm/yyyy format" on the page
	And I see "Enter the third Monday you'd prefer to start jury service using the dd/mm/yyyy format" on the page

	#same choice
	When I set the "First" single date field to a Monday "6" weeks in the future
	When I set the "Second" single date field to a Monday "10" weeks in the future
	When I set the "Third" single date field to a Monday "10" weeks in the future

	And I press the "Continue" button

	Then I see "There is a problem" on the page
	And I see "Enter a date that's different to your other choices" on the page
	
	When I set the "First" single date field to a Monday "100" weeks in the future
	When I set the "Second" single date field to a Monday "101" weeks in the future
	When I set the "Third" single date field to a Monday "102" weeks in the future

	And I press the "Continue" button
	
	Then I see "There is a problem" on the page
	And I see "Your first choice must be a Monday between" on the page
	And I see "Your second choice must be a Monday between" on the page
	And I see "Your third choice must be a Monday between" on the page

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
	
	And I press the "Continue" button
	And I see "There is a problem" on the page
	And I see "Confirm whether you want to proceed with these dates" on the page
	
	And I choose the "Yes" radio button
	And I press the "Continue" button
	
	Then I see "Check your answers now" on the page
	
	#Check Your Answers
	When I click on the "Change" link in the same row as "Confirm the date of your jury service"
	Then I see "Check your start date" on the page
	
	When I set the radio button to "No, I cannot do jury service and need to be excused"
	And I press the "Continue" button
	Then I see "Why do you need to be excused from jury service?" on the page
	
	#Excusal Reason
	When I press the "Continue" button
	Then I see "There is a problem" on the page
	And I see "Enter reason why you cannot do jury service in the next 12 months" on the page
	
	When I set text area with "id" of "excusalReason" to "Excuse me please"
	And I press the "Continue" button
	Then I see "Check your answers now" on the page
	
	#When I press the "Submit" button
	When I check the "The information I have given is true to the best of my knowledge" checkbox
	And I press the "Submit" button
	Then I see "We have sent you an email to say you have replied to your jury summons." on the page
	
Examples:
	|juror_number	|last_name			|postcode	|email           	|pool_number|
	|045200047		|LNAMENINEFOURTWO	|CH1 2AN	|email@outlook.com	|452300046	|
	
@Regression
Scenario Outline: Checking that there is in-line error message for Responder Type screen

	Given I am on "Public" "ithc"

	Given a bureau owned pool is created with jurors
		| court |juror_number  | pool_number	| att_date_weeks_in_future	| owner |
		| 452   |<juror_number>| <pool_number>	| 5				            | 400	|
		
	And juror "<juror_number>" has "LAST_NAME" as "<last_name>" new schema
	And juror "<juror_number>" has "POSTCODE" as "<postcode>" new schema
	
	Then I see "Reply to a jury summons" on the page
	
	Then I see "Are you replying for yourself or for someone else?" on the page
	
	When I press the "Continue" button
	Then I see "There is a problem" on the page
	
	#need a welsh version too
	And I see "Select if you are replying for yourself or for someone else" on the page
	
Examples:
	| juror_number	| last_name		 | postcode	| pool_number	|
	| 045200048		| LNAMESIXEIGHTONE| CH1 2AN	| 452300047		|
	
@Regression
Scenario Outline: English response completed in Legacy and login attempted on Digital

	#return to @Regression once defect fixed

	Given I am on "Bureau" "ithc"

	Given a bureau owned pool is created with jurors
		| court |juror_number  | pool_number	| att_date_weeks_in_future	| owner |
		| 452   |<juror_number>| <pool_number>	| 5				            | 400	|

	And juror "<juror_number>" has "LAST_NAME" as "<last_name>" new schema
	And juror "<juror_number>" has "POSTCODE" as "<postcode>" new schema

	And I log in as "MODTESTBUREAU"
	And I search for juror "<juror_number>"

	And I record a happy path paper summons response and process now

	Given I am on "Public" "ithc"

	Then I see "Reply to a jury summons" on the page
	
	Then I see "Are you replying for yourself or for someone else?" on the page
	
	When I set the radio button to "I am replying for myself"
	And I press the "Continue" button
	Then I see "Your juror details" on the page
	
	When I set "9-digit juror number" to "<juror_number>"
	And I set "Juror last name" to "<last_name>"
	And I set "Juror postcode" to "<postcode>"
	And I press the "Continue" button

	And I see "Our records show you've already replied to this jury summons" on the page
	And I see "If you want to tell us about changes or we've asked you for more information, you need to contact us by email, telephone or letter." on the page
	And I see "Jury Central Summoning Bureau" on the page
	And I see "jurysummoning@justice.gov.uk" on the page
	And I see "Telephone: 0300 456 1024" on the page
	And I see "Monday to Thursday 9am to 5pm" on the page
	And I see "Friday 9am to 3pm" on the page
	And I see "Find out about call charges" on the page

	And I see "Jury Central Summoning Bureau" on the page
	And I see "Phoenix House" on the page
	And I see "Rushton Avenue" on the page
	And I see "Bradford" on the page
	And I see "BD3 7BH" on the page

	And I see "You cannot tell us extra information through this digital service." on the page

Examples:
	| juror_number	| last_name			| postcode	| pool_number	|
	| 045200049		| LNAMETWOSEVENSIX	| CH1 2AN	| 452300048 	|

	@Regression
	Scenario Outline: English Already Replied info page

		Given I am on "Public" "ithc"

		Given a bureau owned pool is created with jurors
			| court |juror_number  | pool_number	| att_date_weeks_in_future	| owner |
			| 452   |<juror_number>| <pool_number>	| 5				            | 400	|

		And juror "<juror_number>" has "LAST_NAME" as "<last_name>" new schema
		And juror "<juror_number>" has "POSTCODE" as "<postcode>" new schema

		And I have submitted a first party English straight through response
			| part_no			| pool_number	| last_name		| postcode	| email 	|
			| <juror_number>	| <pool_number>	| <last_name>	| <postcode>| <email>	|

		Given I am on "Public" "ithc"

		Then I see "Reply to a jury summons" on the page

		Then I see "Are you replying for yourself or for someone else?" on the page

		When I set the radio button to "I am replying for myself"
		And I press the "Continue" button
		And I see "steps/login" in the URL

		When I set "9-digit juror number" to "<juror_number>"
		And I set "Juror last name" to "<last_name>"
		And I set "Juror postcode" to "<postcode>"
		And I press the "Continue" button

		And I see "Our records show you've already replied to this jury summons" on the page
		And I see "If you want to tell us about changes or we've asked you for more information, you need to contact us by email, telephone or letter." on the page
		And I see "Jury Central Summoning Bureau" on the page
		And I see "jurysummoning@justice.gov.uk" on the page
		And I see "Telephone: 0300 456 1024" on the page
		And I see "Monday to Thursday 9am to 5pm" on the page
		And I see "Friday 9am to 3pm" on the page
		And I see "Find out about call charges" on the page

		And I see "Jury Central Summoning Bureau" on the page
		And I see "Phoenix House" on the page
		And I see "Rushton Avenue" on the page
		And I see "Bradford" on the page
		And I see "BD3 7BH" on the page
		
		And I see "You cannot tell us extra information through this digital service." on the page

		Examples:
			| juror_number	| last_name	       | postcode   | pool_number	| email 		|
			| 045200050	 	| LNAMESIXSEVENSIX | SW1H 9AJ   | 452300049		| e@mail.com 	|