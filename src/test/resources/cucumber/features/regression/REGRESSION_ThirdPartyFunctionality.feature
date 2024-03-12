Feature: Third Party Functionality Regression Script

@Regression @NewSchemaConverted
Scenario Outline: Third Party Functionality Regression
	Given I am on "Public" "test"

	Given a bureau owned pool is created with jurors
		| court |juror_number  | pool_number	| att_date_weeks_in_future	| owner |
		| 452   |<juror_number>| <pool_number>	| 5				            | 400	|

	And juror "<juror_number>" has "LAST_NAME" as "<last_name>" new schema
	And juror "<juror_number>" has "ADDRESS_LINE_1" as "<address>" new schema
	And juror "<juror_number>" has "POSTCODE" as "<postcode>" new schema

	Then I see "Reply to a jury summons" on the page
	
	And I set the radio button to "I am replying for someone else"
	And I press the "Continue" button
	Then I see "Their juror details" on the page
	
	When I set "9-digit juror number" to "<juror_number>"
	When I set "Juror last name" to "<last_name>"
	When I set "Juror postcode" to "<postcode>"
	And I press the "Continue" button
	Then I see "Your Details" on the page
	
	When I press the "Continue" button
	Then I see "Enter your first name" on the page
	And I see "Enter your first name" on the page
	And I see "Enter your last name" on the page
	
	When I set "First name" to "FirstNamea"
	And I set "Last name" to "LastNameb"
	
	When I press the "Continue" button
	
	And I see "Your relationship to the person" on the page
	And I set "How do you know the person you're replying for?" to "Friend"

	When I press the "Continue" button
	
	And I see "Your contact information" on the page
	And I see "How would you like us to get in touch, if we need to?" on the page
	
	And I check the "By phone (UK Numbers only)" checkbox
	And I set "Main phone" to "02078211818"
	And I check the "By email" checkbox
	When I set "Enter your email address" to "<email>"
	When I set "Enter your email address again" to "<email>"
	
	And I press the "Continue" button
	
	Then I see "Why are you replying for the other person?" on the page
	When I set the radio button to "The person has died"
	
	And I press the "Continue" button
	
	Then I see "Check your answers now" on the page
	And I see "It's important to check that all the information is right before you send this reply for the person who was summoned to jury service." on the page
	And I see "You're replying for another person summoned for jury service. You told us this about yourself" on the page
	And I see text "FirstNamea" in the same row as "Your name"
	And I see text "LastNameb" in the same row as "Your name"
	And I see text "Friend" in the same row as "Your relationship to the summoned"
	And I see text "02078211818" in the same row as "Your main phone number"
	And I see text "<email>" in the same row as "Your email address"
	And I see text "The person has died" in the same row as "Your reason for replying on behalf of the juror"
	When I click on the "Change" link in the same row as "Your name"
	Then I see "Your Details" on the page
	
	When I set "First name" to "FirstNameAChanged"
	And I set "Last name" to "LastNameBChanged"
	And I press the "Continue" button
	Then I see "Check your answers now" on the page
	
	And I see "It's important to check that all the information is right before you send this reply for the person who was summoned to jury service." on the page
	And I see "You're replying for another person summoned for jury service. You told us this about yourself" on the page
	And I see text "FirstNameAChanged" in the same row as "Your name"
	And I see text "LastNameBChanged" in the same row as "Your name"
	
	Then I check the "The answers I have given for the person I'm replying for are true as far as I know." checkbox
	Given auto straight through processing has been disabled
	When I press the "Submit" button
	
	Then I see "You have completed your reply" on the page
	Then I see "<juror_number>" on the page
	
	Then on "JUROR_MOD" . "JUROR_RESPONSE" I see "PROCESSING_STATUS" is "TODO" where "JUROR_NUMBER" is "<juror_number>"
	#Continue from Step 17
	
	Given I am on "Bureau" "test"
	And I log in
	Then I see "To do" on the page
	Then I see "Your work" on the page
	Then I see "Search" on the page
	Then I see "Assign Replies" on the page
	Then I see "Manage team" on the page
	
	When I click on the "Assign Replies" link
	
	Given I am on "Bureau" "test"
	And I log in as "CPASS"
	
	When I click on the "Search" link
	And I set "Juror number" to "<juror_number>"
	And I press the "Search" button
	
	When I click on "<juror_number>" in the same row as "<juror_number>"
	Then I see "LastNameB" on the page
	And I see "Juror details" on the page
	
	Then I see "FirstNameAChanged" in the same row as "Third party name"
	Then I see "<address>" in the same row as "Address"
	
	When I select "Deferral" from Process reply
	
	And I select "O - OTHER" from the "Reason for the deferral request" dropdown
	And I set the radio button to "Accept deferral"
	And I set the radio button to "Other"

	When I set the "Deferral" single date field to a Monday "10" weeks in the future
	
	And I press the "Confirm" button
	Then I see "COMPLETED" on the page
	
	Then on "JUROR_MOD" . "JUROR_RESPONSE" I see "PROCESSING_STATUS" is "CLOSED" where "JUROR_NUMBER" is "<juror_number>"
	Then on "JUROR_MOD" . "JUROR_RESPONSE" I see "PROCESSING_COMPLETE" is "Y" where "JUROR_NUMBER" is "<juror_number>"
	
	Then on "JUROR_MOD" . "POOL" I see "STATUS" is "7" where "JUROR_NUMBER" is "<juror_number>"
	Then on "JUROR_MOD" . "JUROR_HISTORY" I see "HISTORY_CODE" is "PDEF" where "JUROR_NUMBER" is "<juror_number>"
	Then on "JUROR_MOD" . "JUROR_HISTORY" I see "HISTORY_CODE" is "RESP" where "JUROR_NUMBER" is "<juror_number>"
	
	# re-enable auto processing
	Given auto straight through processing has been enabled
	
Examples:
	| juror_number	| pool_number	| last_name			| postcode	| email           	| address 			|
	| 045200169		| 452300154		| LNAMEONEFIVESEVEN	| CH1 2AN	| email@outlook.com	| 157 STREET NAME	|