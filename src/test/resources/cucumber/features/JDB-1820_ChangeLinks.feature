Feature: JDB-1820 Change links

@Regression @JDB-1820
Scenario Outline: Testing all change links on Check your answers screen
	Given I am on "Public" "bau-test"
	
	Given the juror numbers have not been processed
		| part_no 	| pool_no 	| owner |
		| <part_no> |<pool_no>	| 400 	|
	
	And "<part_no>" has "LNAME" as "<last_name>" 
	And "<part_no>" has "RET_DATE" as "5 mondays time"
	And "<part_no>" has "NEXT_DATE" as "5 mondays time"
	And "<part_no>" has "ZIP" as "<postcode>"
	
	Then I see "Reply to a jury summons" on the page
	
	And I set the radio button to "I am replying for myself"
	And I press the "Continue" button
	Then I see "Your juror details" on the page
	
	#Juror Log In
	
	When I set "9-digit juror number" to "<part_no>"
	When I set "Juror last name" to "<last_name>"
	When I set "Juror postcode" to "<postcode>"
	And I press the "Continue" button
	Then I see "Is the name we have for you correct?" on the page
	And I set the radio button to "Yes"
	
	#Check name
	
	When I press the "Continue" button
	Then I see "Is this your address?" on the page
	And I set the radio button to "Yes"
	
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
	
	#Residency Yes
	
	Then I see "Since you turned 13, has your main address been in the UK, Channel Islands or Isle of Man for any period of at least 5 years?" on the page
	When I set the radio button to "Yes"
	And I press the "Continue" button
	
	#CJS no
	
	Then I see "Have you worked in the criminal justice system in the last 5 years?" on the page
	When I set the radio button to "No"
	And I press the "Continue" button
	
	#Bail no
	
	Then I see "Are you currently on bail for a criminal offence?" on the page
	When I set the radio button to "No"
	And I press the "Continue" button
	
	#Convictions no
	
	Then I see "Have you been found guilty of a criminal offence?" on the page
	When I set the radio button to "No"
	And I press the "Continue" button
	
	#Mental health part 1 no
	
	Then I see "Are you being detained, looked after or treated under the Mental Health Act?" on the page
	When I set the radio button to "No"
	And I press the "Continue" button
	
	#Mental health part 2 no
	
	Then I see "Has it been decided that you 'lack mental capacity'?" on the page
	When I set the radio button to "No"
	And I press the "Continue" button
	
	#I can attend
	
	Then I see "Check your start date" on the page
	And I see "Yes, I can start on" on the page
	And I set the radio button to "Yes, I can start on"
	And  I press the "Continue" button
	
	#RA no
	
	Then I see "Will you need help when you're at the court?" on the page
	When I set the radio button to "No"
	And I press the "Continue" button
	Then I see "Check your answers now" on the page
	
	#Check your answers

	When I click on the "Change" link in the same row as "Name"
	And I set "First name" to "FirstNameA"
	And I set "Last name" to "LastNameB"
	And I press the "Continue" button
	Then I see text "FirstNameA LastNameB" in the same row as "Name"
	
	When I click on the "Change" link in the same row as "Address"
	Then I see "What is your address?" on the page
	And I set "Address line 1" to "123 STREET NAME"
	And I set "Town or city" to "ChangedTown"
	And I press the "Continue" button
	Then I see text "123 STREET NAME, ANYTOWN, ChangedTown, CH1 2AN" in the same row as "Address"
	
	When I click on the "Change" link in the same row as "Main phone"
	Then I see "What is your phone number?" on the page
	When I set "Main phone" to "0207 821 2727"
	And I set "Another phone (optional)" to "0207 821 4545"
	And I press the "Continue" button
	Then I see text "0207 821 2727" in the same row as "Main phone"
	And I see text "0207 821 4545" in the same row as "Another phone (optional)"
	
	When I click on the "Change" link in the same row as "Email"
	Then I see "What is your email address?" on the page
	When I set "Enter your email address" to "emailchanged@outlook.com"
	And I set "Enter your email address again" to "emailchanged@outlook.com"
	And I press the "Continue" button
	Then I see text "emailchanged@outlook.com" in the same row as "Email"
	
	When I click on the "Change" link in the same row as "Date of birth"
	Then I see "What is your date of birth?" on the page
	When I set "Day" to "18"
	And I set "Month" to "09"
	And I set "Year" to "1972"
	And I press the "Continue" button
	Then I see text "18 September 1972" in the same row as "Date of birth"
	
	When I click on the "Change" link in the same row as "Since you turned 13, has your main address been in the UK, Channel Islands or Isle of Man for any period of at least 5 years?"
	Then I see "Since you turned 13, has your main address been in the UK, Channel Islands or Isle of Man for any period of at least 5 years?" on the page
	When I set the radio button to "No"
	And I set "Provide details" to "Residency information"
	And I press the "Continue" button
	Then I see text "No - Residency information" in the same row as "Since you turned 13, has your main address been in the UK, Channel Islands or Isle of Man for any period of at least 5 years?"

	When I click on the "Change" link in the same row as "Are you being detained, looked after or treated under the Mental Health Act?"
	Then I see "Are you being detained, looked after or treated under the Mental Health Act?" on the page
	When I set the radio button to "Yes"
	And I set "Provide details" to "I am sectioned and detained"
	And I press the "Continue" button
	Then I see text "Yes - I am sectioned and detained" in the same row as "Are you being detained, looked after or treated under the Mental Health Act?"

	When I click on the "Change" link in the same row as "Has it been decided that you 'lack mental capacity'?"
	Then I see "Has it been decided that you 'lack mental capacity'?" on the page
	When I set the radio button to "Yes"
	And I set "Provide brief details about why it was decided you lack mental capacity" to "I lack capacity"
	And I press the "Continue" button
	Then I see text "Yes - I lack capacity" in the same row as "Has it been decided that you 'lack mental capacity'?"
	
	When I click on the "Change" link in the same row as "Are you currently on bail for a criminal offence?"
	Then I see "Are you currently on bail for a criminal offence?" on the page
	When I set the radio button to "Yes"
	And I set "Provide details" to "I am on bail for crimes"
	And I press the "Continue" button
	Then I see text "Yes - I am on bail for crimes" in the same row as "Are you currently on bail for a criminal offence?"
	
	When I click on the "Change" link in the same row as "Have you been convicted of a criminal offence and been given a sentence?"
	Then I see "Have you been found guilty of a criminal offence?" on the page
	When I set the radio button to "Yes"
	And I set text area with "id" of "convictedDetails" to "I am a convicted criminal"
	And I press the "Continue" button
	Then I see text "Yes - I am a convicted criminal" in the same row as "Have you been convicted of a criminal offence and been given a sentence?"

	When I click on the "Change" link in the same row as "Confirm the date of your jury service"
	Then I see "Check your start date" on the page
	When I set the radio button to "No, I cannot do jury service and need to be excused"
	And I press the "Continue" button
	Then I see "Why do you need to be excused from jury service?" on the page
	When I set text area with "id" of "excusalReason" to "Excuse me from jury service"
	And I press the "Continue" button
	Then I see text "Excuse me from jury service" in the same row as "Say why you need to be excused from jury service"
	
	When I click on the "Change" link in the same row as "Have you worked in the criminal justice system in the last 5 years?"
	Then I see "Have you worked in the criminal justice system in the last 5 years?" on the page
	When I set the radio button to "Yes"
	And I check the "Police service" checkbox
	And I set "Which police service?" to "London Met Police"
	And I press the "Continue" button
	Then I see text "London Met Police" in the same row as "Have you worked in the criminal justice system in the last 5 years?"

	When I click on the "Change" link in the same row as "Do you have a disability or impairment that means you'll need extra support or facilities in the court building where you are doing your Jury Service?"
	Then I see "Will you need help when you're at the court?" on the page
	When I set the radio button to "Yes"
	And I check the "Limited mobility" checkbox
	And I set "Tell us about any special arrangements or help you need while you're doing jury service." to "Wheelchair user"
	And I press the "Continue" button
	Then I see text "Limited mobility" in the same row as "Do you have a disability or impairment that means you'll need extra support or facilities in the court building where you are doing your Jury Service?"
	Then I see text "Wheelchair user" in the same row as "Tell us about any special arrangements or help you need while you're doing jury service"

	When I check the "The information I have given is true to the best of my knowledge" checkbox
	And I press the "Submit" button
	
#When I press the "Submit" button
	
	Then I see "We may get in touch to talk about the help you need so you can do jury service." on the page
	
Examples:
	|part_no		|last_name			|postcode	|email           	|pool_no  |
	|741500124		|LNAMEONETWOFOUR	|CH1 2AN	|email@outlook.com	|415180803|
	
