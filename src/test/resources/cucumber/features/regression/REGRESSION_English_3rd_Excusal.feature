Feature: Regression English_3rd_Excusal

@Regression @replytypes @JDB-3378 @JDB-3373 @JDB-3371 @JDB-3377 @JDB-3370 @JDB-3376 @JDB-3363 @JDB-3364 @JDB-3372 @JDB-3380 @JDB-3379 @JDB-3368 @JDB-3369 
@JDB-3365 @JDB-3366 @JDB-3367 @JDB-3418 @JDB-3455 @JDB-3420 @JDB-3447 @JDB-3653 
Scenario Outline: English 3rd Party Excusal
	Given I am on "Public" "juror-test02"
	Given the juror numbers have not been processed
		| part_no 	| pool_no 	| owner |
		| <part_no> |<pool_no>	| 400 	|
		
	And "<part_no>" has "LNAME" as "<last_name>" 
	And "<part_no>" has "RET_DATE" as "5 mondays time"
	And "<part_no>" has "NEXT_DATE" as "5 mondays time"
	And "<part_no>" has "ZIP" as "<postcode>"
	
	Then I see "Reply to a jury summons" on the page

	And I set the radio button to "I am replying for someone else"
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
	
	#Why are you replying for the person?
	
	When I set the radio button to "The person is not here"
	And I press the "Continue" button
	Then I see "Is the name we have for them correct?" on the page
	
	#Check juror name
	
	When I see "Juror Details" on the page
#	And I set the radio button to "No"
#	And I press the "Continue" button
#	And I set "First name" to "Joe"
#	And I set "Last name" to "Blogs"
	And I set the radio button to "Yes"
	And I press the "Continue" button
	Then I see "Is this their address?" on the page
	
	#Check juror address
	
	When I see "Juror Details" on the page
	And I set the radio button to "Yes"
	And I press the "Continue" button
	Then I see "Give the date of birth for the person you're replying for" on the page
	
	#DoB
	
	When I see "Juror Details" on the page
	And I set "Day" to "01"
	And I set "Month" to "01"
	
	#JDB-3418 Checking age 18 works
	
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
	
	#Residency
	
	Then I see "Since they turned 13, has their main address been in the UK, Channel Islands or Isle of Man for any period of at least 5 years?" on the page
	When I see "Eligibility" on the page
	And I set the radio button to "Yes"
	And I press the "Continue" button
	
	#CJS
	
	Then I see "Has the person you're replying for worked in the criminal justice system in the last 5 years?" on the page
	When I set the radio button to "No"
	And I press the "Continue" button
	
	#Bail
	
	Then I see "Is the person currently on bail for a criminal offence?" on the page
	When I see "Eligibility" on the page
	And I set the radio button to "No"
	And I press the "Continue" button
	
	#Convictions
	
	Then I see "Has the person been found guilty of a criminal offence?" on the page
	When I see "Eligibility" on the page
	When I set the radio button to "No"
	And I press the "Continue" button
	
	#Mental Health Sectioned
	
	Then I see "Is the person you're replying for being detained, looked after or treated under the Mental Health Act?" on the page
	When I see "Eligibility" on the page
	And I set the radio button to "No"
	And I press the "Continue" button
	
	#Mental Health Capacity
	
	Then I see "Has it been decided that the person you're replying for 'lacks mental capacity'?" on the page
	When I see "Eligibility" on the page
	And I set the radio button to "No"
	And I press the "Continue" button
	
	#Confirm Date of Jury
	
	Then I see "Check your start date" on the page
	When I set the radio button to "No, they cannot do"   
	And I press the "Continue" button
	
	#Excusal Reason JDB-3653
	
	And I see "steps/confirm-date/excusal/tp" in the URL
	Then I see "Why do they need to be excused from jury service?" on the page
	And I see "Explain why they cannot do jury service in the next 12 months." on the page
	And I see "You do not need to attach or gather evidence before their summons deadline." on the page
	And I see "We'll get in touch later if we need this." on the page
	And I click on the "Will we need to provide evidence soon?" link
	And I see "If we need evidence, we'll contact you separately to tell you." on the page
	And I see "For example, if they're too ill for jury service, we might ask for a letter from their doctor." on the page
	And I see "They'll be given time to gather any evidence so do not worry about trying to gather this now." on the page
	And I see "Wait until we've told you what evidence we need, if any." on the page
	
	And I press the "Continue" button
	Then I see "Enter reason why they cannot do jury service in the next 12 months" on the page
	
	And I set text area with "id" of "excusalReason" to "Excuse them please"
	And I press the "Continue" button
	
	#RA
	
	Then I see "Will the person you're replying for need help when they're at the court?" on the page
	When I set the radio button to "Yes"
	And I set "Tell us about any special arrangements or help the person you're answering for needs while they're doing jury service." to "Wheelchair user"
	When I check the "Other" checkbox
	And I set "Provide details" to "Other RA stuff"
	And I press the "Continue" button
	
#	When I set the radio button to "No"
#	And I press the "Continue" button
	
	#Check Your Answers
	
	Then I see "Check your answers now" on the page
	
	When I check the "The answers I have given for the person I'm replying for are true as far as I know" checkbox
	And I press the "Submit" button
	And I see "You have completed your reply" on the page
	
	Given I am on "Bureau" "juror-test02"
	And I log in
	
	When I click on the "Search" link
	And I set "Juror number" to "<part_no>"
	And I press the "Search" button
	Then I see "<part_no>" on the page
	
	And I click link with ID "selectAllLink"
	And I press the "Send to..." button
	And I set input field with "id" of "sendToOfficer" to "CPASS"
	And I press the "Send" button
	And I press the "Send" button
	Then I see "Your work" on the page
	
	Then I click on the "Sign out" link
	When I log in as "CPASS"
	Then I see "<part_no>" on the page
	Then I see "<part_no>" has reply type indicator "EXCUSAL"
	
	
Examples:
	|part_no	|last_name			|postcode	|email       	    |pool_no	|
	|641500268	|LNAMETWOSIXEIGHT	|CH1 2AN	|email@outlook.com	|415170401	|