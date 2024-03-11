Feature: 3rd_Party_ContactingJuror

@Regression
Scenario Outline: English check that result cannot be processed without phone number for juror
	Given I am on "Public" "test"

	Given a bureau owned pool is created with jurors
		| court 	|juror_number  		| pool_number	| att_date_weeks_in_future	| owner |
		| <court> 	|<juror_number> 	| <pool_number> | 5				            | 400	|
	
	And juror "<juror_number>" has "LAST_NAME" as "<last_name>" new schema
	And juror "<juror_number>" has "POSTCODE" as "<postcode>" new schema
	
	Then I see "Reply to a jury summons" on the page
	
	And I set the radio button to "I am replying for someone else"
	And I press the "Continue" button
	Then I see "Their juror details" on the page
	
	#Juror Log In
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
	Then I see "Why are you replying for the other person?" on the page
	
	#Why are you replying for the person?
	When I set the radio button to "The person is not here"
	And I press the "Continue" button
	Then I see "Is the name we have for them correct?" on the page
	When I set the radio button to "No"
	And I press the "Continue" button
	
	When I click on the "What happens if they have changed their name?" link
	Then I see "If their name has changed we will contact them to check this. We might ask for a marriage, civil partnership or deed poll certificate." on the page
	
	#Check juror name
	When I see "Juror Details" on the page
	And I press the "Continue" button
	Then I see "Is this their address?" on the page
	When I set the radio button to "Yes"
	
	#Check juror address
	When I see "Juror Details" on the page
	And I press the "Continue" button
	Then I see "Give the date of birth for the person you're replying for" on the page
	
	#DoB
	When I see "Juror Details" on the page
	And I click on the "Help with date of birth" link
	Then on the page I see
		| text|
		|You need to tell us the person's date of birth so we can check they are a suitable age to be on a jury.|
		|If the person does not know their exact date of birth, use the one they put on official documents like their passport or driving licence.|
		|If you cannot provide a date of birth for the person, you’ll have to send us copies of identity documents through the post. You need to reply to the summons using the form we sent by post instead of online. Ring us on 0300 456 1024 if you need advice about this.|

	And I set the date of birth to a Monday "-1500" weeks in the future

	And I press the "Continue" button
	Then I see "We might need to get in touch with the person to ask them more questions or give them information about their jury service" on the page
	
	#Contacting the juror JDB-3504
	
	When I see "Juror Details" on the page
	And I set the radio button to "Give a different phone number for the juror"
	And I set the radio button to "Give a different email address for the juror"
	And I press the "Continue" button
	Then I see "Enter their main phone number" on the page
	And I see "Enter their email address" on the page

	When I set "Enter email address" to "<email>"
	And I set "Enter the email address again" to "<email>"
	Then "Enter email address" is "<email>"
	Then "Enter the email address again" is "<email>"
	And I press the "Continue" button
	Then I see "Enter their main phone number" on the page
	Then "Enter email address" is "<email>"
	Then "Enter the email address again" is "<email>"
	
	When I set "Main phone number" to "02078214545"
	And I press the "Continue" button
	Then I see "Confirm if the person is eligible for jury service" on the page
	
Examples:
	| juror_number	| last_name	| postcode	| email           	| pool_number| court	|
	| 041500015		| DOE		| SW1H 9AJ	| email@outlook.com	| 415300113  | 415      |
	
