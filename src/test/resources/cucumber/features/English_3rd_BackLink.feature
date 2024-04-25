Feature: English 3rd BackLink

@Regression @NewSchemaConverted
Scenario Outline: Back and forward navigation all screens for 3rd Party

	Given I am on "Public" "test"

	Given a bureau owned pool is created with jurors
		| court |juror_number  | pool_number	| att_date_weeks_in_future	| owner |
		| 452   |<juror_number>| <pool_number>	| 5				            | 400	|
	
	And juror "<juror_number>" has "LAST_NAME" as "<last_name>" new schema
	And juror "<juror_number>" has "POSTCODE" as "<postcode>" new schema
	
	Then I see "Reply to a jury summons" on the page
	
	And I set the radio button to "I am replying for someone else"
	Then the radio button "I am replying for someone else" is "selected"
	And I press the "Continue" button
	Then I see "Their juror details" on the page
	
	#Juror Log In
	When I set "9-digit juror number" to "<juror_number>"
	When I set "Juror last name" to "<last_name>"
	When I set "Juror postcode" to "<postcode>"
	And I press the "Continue" button
	Then I see "What is your name?" on the page
	When I click on the "Back" link
	Then I see "Their juror details" on the page
	When I set "9-digit juror number" to "<juror_number>"
	And I set "Juror last name" to "<last_name>"
	And I set "Juror postcode" to "<postcode>"
	And I press the "Continue" button
	Then I see "What is your name?" on the page
	
	#3rd Party Name
	When I set "First name" to "FirstNameA"
	And I set "Last name" to "LastNameB"
	And I press the "Continue" button
	Then I see "Your relationship to the person" on the page
	When I click on the "Back" link
	Then I see "What is your name?" on the page
	Then "First name" is "FirstNameA"
	Then "Last name" is "LastNameB"
	And I press the "Continue" button
	Then I see "Your relationship to the person" on the page
	
	#3rd Party Relationship
	When I set "How do you know the person you're replying for?" to "Friend"
	And I press the "Continue" button
	Then I see "Your contact information" on the page
	When I click on the "Back" link
	Then I see "Your relationship to the person" on the page
	Then "How do you know the person you're replying for?" is "Friend"
	And I press the "Continue" button
	Then I see "Your contact information" on the page
	
	#3rd Party Contact
	When I check the "By phone (UK Numbers only)" checkbox
	And I check the "By email" checkbox
	And I set "Main phone" to "0207 821 1818"
	And I set "Enter your email address" to "<email>"
	And I set "Enter your email address again" to "<email>"
	And I press the "Continue" button
	Then I see "Why are you replying for the other person?" on the page
	When I click on the "Back" link
	Then I see "Your contact information" on the page
	And "Main phone" is "0207 821 1818"
	And "Enter your email address" is "email@outlook.com"
	When I press the "Continue" button
	Then I see "Why are you replying for the other person?" on the page
	
	#Why are you replying
	When I set the radio button to "The person is not here"
	And I press the "Continue" button
	Then I see "Is the name we have for them correct?" on the page
	When I click on the "Back" link
	Then I see "Why are you replying for the other person?" on the page
	And I see "They might be travelling, in hospital or away for more than a few days for some other reason" on the page
	When I press the "Continue" button
	Then I see "Is the name we have for them correct?" on the page
	
	#Check juror name
	When I see "fname" on the page
	And I see "LNAME132" on the page
	When I choose the "Yes" radio button
	And I press the "Continue" button
	Then I see "Is this their address?" on the page
	When I click on the "Back" link
	Then I see "Is the name we have for them correct?" on the page
	When I choose the "Yes" radio button
	When I press the "Continue" button
	Then I see "Is this their address?" on the page
	
	#Check juror address
	When I see "CH1 2AN" on the page
	When I choose the "Yes" radio button
	When I press the "Continue" button
	Then I see "Give the date of birth for the person you're replying for" on the page
	When I click on the "back" link
	Then I see "Is this their address?" on the page
	When I choose the "Yes" radio button
	When I press the "Continue" button
	Then I see "Give the date of birth for the person you're replying for" on the page
	
	#Juror DoB
	When I set "Day" to "27"
	And I set "Month" to "04"
	And I set "Year" to "1981"
	And I press the "Continue" button
	Then I see "We might need to get in touch with the person to ask them more questions or give them information about their jury service" on the page
	When I click on the "back" link
	Then I see "Give the date of birth for the person you're replying for" on the page
	And I see "Help with date of birth" on the page
	When I press the "Continue" button
	Then I see "We might need to get in touch with the person to ask them more questions or give them information about their jury service" on the page
	
	#Contacting the juror
	When I see "Tell us how we can get in touch with the person you're replying for. Or we can use your contact information, if you're going to carry on acting for them." on the page
	And I see "Give phone numbers that we can use to call you or the juror between 9am and 5pm, Monday to Friday." on the page
	When I set the radio button to "Use the phone number that you have already given to contact you"
	When I set the radio button to "Use the email address that you have already given to contact you"
	And I press the "Continue" button
	Then I see "Confirm if the person is eligible for jury service" on the page
	When I click on the "Back" link
	Then I see "Tell us how we can get in touch with the person you're replying for. Or we can use your contact information, if you're going to carry on acting for them." on the page
	When I press the "Continue" button
	Then I see "Confirm if the person is eligible for jury service" on the page
	
	#Qualifying for service
	When I press the "Continue" button
	Then I see "Since they turned 13, has their main address been in the UK, Channel Islands or Isle of Man for any period of at least 5 years?" on the page
	When I click on the "Back" link
	Then I see "Confirm if the person is eligible for jury service" on the page
	When I press the "Continue" button
	Then I see "Since they turned 13, has their main address been in the UK, Channel Islands or Isle of Man for any period of at least 5 years?" on the page
	
	#Residency
	When I choose the "Yes" radio button
	And I press the "Continue" button
	Then I see "Has the person you're replying for worked in the criminal justice system in the last 5 years?" on the page
	When I click on the "Back" link
	Then I see "Since they turned 13, has their main address been in the UK, Channel Islands or Isle of Man for any period of at least 5 years?" on the page
	And I press the "Continue" button
	
	#CJS
	Then I see "Has the person you're replying for worked in the criminal justice system in the last 5 years?" on the page
	When I choose the "No" radio button
	And I press the "Continue" button
	Then I see "Is the person currently on bail for a criminal offence?" on the page
	When I click on the "Back" link
	Then I see "Has the person you're replying for worked in the criminal justice system in the last 5 years?" on the page
	When I press the "Continue" button
	
	#Bail
	Then I see "Is the person currently on bail for a criminal offence?" on the page
	When I choose the "No" radio button
	And I press the "Continue" button
	Then I see "Has the person been found guilty of a criminal offence?" on the page
	When I click on the "Back" link
	Then I see "Is the person currently on bail for a criminal offence?" on the page
	When I press the "Continue" button 
	
	#Convictions
	Then I see "Has the person been found guilty of a criminal offence?" on the page
	When I choose the "No" radio button
	And I press the "Continue" button
	Then I see "Is the person you're replying for being detained, looked after or treated under the Mental Health Act?" on the page
	When I click on the "Back" link
	Then I see "Has the person been found guilty of a criminal offence?" on the page
	When I press the "Continue" button 
	Then I see "Is the person you're replying for being detained, looked after or treated under the Mental Health Act?" on the page
	
	#Mental Health part 1
	Then I see "Is the person you're replying for being detained, looked after or treated under the Mental Health Act?" on the page
	When I choose the "No" radio button
	And I press the "Continue" button
	Then I see "Has it been decided that the person you're replying for 'lacks mental capacity'?" on the page
	When I click on the "Back" link
	Then I see "Is the person you're replying for being detained, looked after or treated under the Mental Health Act?" on the page
	When I press the "Continue" button
	
	#Mental Health part 2
	Then I see "Has it been decided that the person you're replying for 'lacks mental capacity'?" on the page
	When I choose the "No" radio button
	And I press the "Continue" button
	Then I see "Check your start date" on the page
	When I click on the "Back" link
	Then I see "Has it been decided that the person you're replying for 'lacks mental capacity'?" on the page
	When I press the "Continue" button
	
	#Confirm date of service
	Then I set the radio button to "Yes, they can start on"
	And  I press the "Continue" button
	Then I see "Will the person you're replying for need help when they're at the court?" on the page
	When I click on the "Back" link
	Then I see "Check your start date" on the page
	When I press the "Continue" button 
	
	#RA
	Then I see "Will the person you're replying for need help when they're at the court?" on the page
	When I choose the "No" radio button
	And I press the "Continue" button
	Then I see "Check your answers now" on the page
	
	#Check your answers
	When I check the "The answers I have given for the person I'm replying for are true as far as I know." checkbox
	
	And I press the "Submit" button

	And I see "You have completed your reply" on the page
	And I see "We have sent an email to say you have replied to this jury summons." on the page
	
Examples:
	| juror_number	| last_name	| postcode	| email           	| pool_number	|
	| 045200176		| LNAME132	| CH1 2AN	| email@outlook.com	| 452300161		|