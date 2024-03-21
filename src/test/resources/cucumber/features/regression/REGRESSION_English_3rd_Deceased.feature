Feature: Regression English_3rd_Deceased

#TO DO: WELSH 3rd DECEASED

@Regression @NewSchemaConverted
Scenario Outline: English 3rd Deceased
	Given I am on "Public" "test"

	Given a bureau owned pool is created with jurors
		| court |juror_number  | pool_number	| att_date_weeks_in_future	| owner |
		| 452   |<juror_number>| <pool_number>	| 5				            | 400	|

	And juror "<juror_number>" has "LAST_NAME" as "<last_name>" new schema
	And juror "<juror_number>" has "FIRST_NAME" as "FNAMESEVENONETHREE" new schema
	And juror "<juror_number>" has "ADDRESS_LINE_1" as "855 STREET NAME" new schema
	And juror "<juror_number>" has "ADDRESS_LINE_4" as "LONDON" new schema
	And juror "<juror_number>" has "POSTCODE" as "<postcode>" new schema
	
	#Reply to jury summons
	Then I see "Reply to a jury summons" on the page
	
	Then I see "Are you replying for yourself or for someone else?" on the page
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
	Then I see "Your relationship to the person" on the page
	
	#Relationship to Juror
	When I set "How do you know the person you're replying for?" to "Friend"
	And I press the "Continue" button
	Then I see "Your contact information" on the page
	
	#3rd Party Contact
	When I check the "By phone (UK Numbers only)" checkbox
	And I check the "By email" checkbox
	And I set "Main phone" to "02078211818"
	And I set "Enter your email address" to "<email>"
	And I set "Enter your email address again" to "<email>"
	And I press the "Continue" button
	Then I see "Why are you replying for the other person?" on the page
	
	#Why Are You Replying
	When I set the radio button to "The person has died"
	And I press the "Continue" button
	Then I see "Check your answers now" on the page
	
	#Check Your Answers Now
	When I check the "The answers I have given for the person I'm replying for are true as far as I know" checkbox
	And I press the "Submit" button
	Then I see "You have completed your reply" on the page
	And I see "We have sent an email to say you have replied to this jury summons." on the page
	And I see "Download a copy of your summons reply" on the page
	And I see "You do not need to do anything else" on the page
	And I see "Jurors are selected at random from the electoral roll. This is not always completely up to date. That's why we sent a jury summons to this person. We do apologise for this and hope it has not caused too much distress." on the page

	Given I am on "Bureau" "test"
#	And I log in
	And I log in as "MODTESTBUREAU"
	When I click on the "Search" link
	And I set "Juror number" to "<juror_number>"
	And I press the "Search" button
	Then I see "<juror_number>" on the page

	Then I see "<juror_number>" has reply type indicator "COMPLETED"
	
Examples:
	| juror_number	| pool_number| last_name| postcode	| email 	|
	| 045200079		| 452300078	 | DOE		| SW1H 9AJ	| e@eeee.com|