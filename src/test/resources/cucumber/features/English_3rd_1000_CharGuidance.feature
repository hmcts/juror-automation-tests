Feature: English_3rd_1000_CharGuidance

@Regression @JDB-3634 @JDB-3618 @JDB-3620 @JDB-3621 @JDB-3622 @JDB-3623 @JDB-3624 @JDB-3625 @JDB-3626 @JDB-3627 @JDB-3628 
Scenario Outline: English 3rd Party - Character count warning should be on all applicable pages
	Given I am on "Public" "bau-test"
	Given the juror numbers have not been processed
		| part_no 	| pool_no 	| owner |
		| <part_no> |<pool_no>	| 400 	|
	
	And "<part_no>" has "LNAME" as "<last_name>" 
	And "<part_no>" has "RET_DATE" as "5 mondays time"
	And "<part_no>" has "NEXT_DATE" as "5 mondays time"
	And "<part_no>" has "ZIP" as "<postcode>"
	
	Then I see "Reply to a jury summons" on the page
	
	Then I see "Are you replying for yourself or for someone else?" on the page
	
	When I set the radio button to "I am replying for someone else"
	And I press the "Continue" button
	Then I see "Their juror details" on the page
	
	#Juror Log In
	
	When I set "9-digit juror number" to "<part_no>"
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
	
	#JDB-3455 Why are you replying title
	
	Then I see "Why are you replying for the other person?" on the page
	And I do not see "Why are you replying?" on the page
	
	#Why are you replying for the person? JDB-3634
	
	When I set the radio button to "Other"
	And I see "You have 100 characters remaining" on the page
	And I set the radio button to "The person is not here"
	And I press the "Continue" button
	
	Then I see "Is the name we have for them correct?" on the page
	When I set the radio button to "Yes"
	And I press the "Continue" button
	Then I see "Is this their address?" on the page
	When I set the radio button to "Yes"
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
	And I press the "Continue" button
	Then I see "Since they turned 13, has their main address been in the UK, Channel Islands or Isle of Man for any period of at least 5 years?" on the page
	
	#Residency JDB-3620
	
	When I set the radio button to "No"
	And I see "You have 1,000 characters remaining" on the page
	And I set "Provide details" to "They're not a resident"
	And I press the "Continue" button
	
	#CJS no JDB-3625
	
	Then I see "Has the person you're replying for worked in the criminal justice system in the last 5 years?" on the page
	When I set the radio button to "Yes"
	And I check the "Other" checkbox
	And I see "You have 1,000 characters remaining" on the page
	And I set "Which other part of the Criminal Justice System?" to "Other CJS part"
	And I press the "Continue" button

	#Bail JDB-3623
	
	Then I see "Is the person currently on bail for a criminal offence?" on the page
	When I set the radio button to "Yes"
	And I see "You have 1,000 characters remaining" on the page
	And I set "Provide details" to "They are bailed"
	And I press the "Continue" button
	
	#Convictions JDB-3624
	
	Then I see "Has the person been found guilty of a criminal offence?" on the page
	When I set the radio button to "Yes"
	And I see "You have 1,000 characters remaining" on the page
	And I set text area with "id" of "convictedDetails" to "They are convicted"
	And I press the "Continue" button
	
	#Mental health part 1 JDB-3621
	
	Then I see "Is the person you're replying for being detained, looked after or treated under the Mental Health Act?" on the page
	When I set the radio button to "Yes"
	And I see "You have 1,000 characters remaining" on the page
	And I set "Provide details" to "They are sectioned"
	And I press the "Continue" button
	
	#Mental health part 2 JDB-3622
	
	Then I see "Has it been decided that the person you're replying for 'lacks mental capacity'?" on the page
	When I set the radio button to "Yes"
	And I see "You have 1,000 characters remaining" on the page
	And I set "Provide brief details about why it was decided they lack mental capacity" to "They lack capacity"
	And I press the "Continue" button
	
	#I can attend
	
	Then I see "Check your start date" on the page
	Then I set the radio button to "Yes, they can start on"
	And  I press the "Continue" button
	
	#RA no JDB-3627 and JDB-3628
	
	Then I see "Will the person you're replying for need help when they're at the court?" on the page
	When I set the radio button to "Yes"
	And I see "You have 1,000 characters remaining" on the page
	And I set "Tell us about any special arrangements or help the person you're answering for needs while they're doing jury service." to "Wheelchair user"
	When I check the "Other" checkbox
	And I set "Provide details" to "Other RA stuff"
	And I press the "Continue" button
	Then I see "Check your answers now" on the page
	
	#Check Your Answers
	
	When I click on the "Change" link in the same row as "Confirm the date of their jury service"
	Then I see "Check your start date" on the page
	
	When I set the radio button to "No, we need to change the date"
	And I press the "Continue" button
	Then I see "Tell us why they need another date for their jury service" on the page
	
	#Deferral Reason JDB-3626
	
	When I see "You have 1,000 characters remaining" on the page
	And I set text area with "id" of "deferralReason" to "Defer them please"
	And I press the "Continue" button
	Then I see "Choose 3 Mondays when they can start jury service" on the page
	
	#Deferral Dates
	
	When I set the "First" single date field to a Monday "6" weeks in the future
	When I set the "Second" single date field to a Monday "7" weeks in the future
	When I set the "Third" single date field to a Monday "8" weeks in the future
	
	And I press the "Continue" button
	
	#confirm
	
	Then I set the radio button to "Yes"
	And I press the "Continue" button
	
	Then I see "Check your answers now" on the page
	
	#Check Your Answers
	
	When I click on the "Change" link in the same row as "Confirm the date of their jury service"
	Then I see "Check your start date" on the page
	
	When I set the radio button to "No, they cannot do"  
	And I press the "Continue" button
	Then I see "Why do they need to be excused from jury service?" on the page
	
	#Excusal Reason JDB-3618
	
	When I see "You have 1,000 characters remaining" on the page
	And I set text area with "id" of "excusalReason" to "Excuse them please"
	
	And I press the "Continue" button
	Then I see "Check your answers now" on the page
	
	#When I press the "Submit" button
	
	When I check the "The answers I have given for the person I'm replying for are true as far as I know." checkbox
	And I press the "Submit" button
	Then I see "We have sent an email to say you have replied to this jury summons." on the page
	
Examples:
	|part_no	|last_name	|postcode	|email          	|pool_no	|
	|641500025	|DOE		|SW1H 9AJ	|email@outlook.com	|415170401	|