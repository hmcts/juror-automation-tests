Feature: English_3rd_SkipMainContent

@Regression @NewSchemaConverted
Scenario Outline: English 3rd Party Straight Through with Skip to Main Content Checks
	
	Given I am on "Public" "test"

	Then the page language is "en"

	Given a bureau owned pool is created with jurors
		| court |juror_number  | pool_number	| att_date_weeks_in_future	| owner |
		| 452   |<juror_number>| <pool_number>	| 5				            | 400	|

	And juror "<juror_number>" has "LAST_NAME" as "<last_name>" new schema
	And juror "<juror_number>" has "FIRST_NAME" as "FNAMESEVENONETHREE" new schema
	And juror "<juror_number>" has "ADDRESS_LINE_4" as "LONDON" new schema
	And juror "<juror_number>" has "POSTCODE" as "<postcode>" new schema
	
	#JDB-3357 Skip to main content check
	#Reply to jury summons
	When I hit the tab key
	Then I see "Skip to main content" on the page
	Then the page language is "en"
	When I click on the "Skip to main content" link
	Then I see "Reply to a jury summons" on the page
	Then the page language is "en"
	
	#JDB-3357 Skip to main content check
	Then I hit the tab key
	Then I see "Skip to main content" on the page
	Then the page language is "en"
	Then I click on the "Skip to main content" link
	Then I see "Are you replying for yourself or for someone else?" on the page
	
	And I set the radio button to "I am replying for someone else"
	And I press the "Continue" button
	
	#JDB-3357 Skip to main content check
	Then I hit the tab key
	Then I see "Skip to main content" on the page
	Then the page language is "en"
	Then I click on the "Skip to main content" link
	Then I see "Their juror details" on the page
	
	When I set "9-digit juror number" to "<juror_number>"
	When I set "Juror last name" to "<last_name>"
	When I set "Juror postcode" to "<postcode>"
	And I press the "Continue" button
	
	#JDB-3357 Skip to main content check
	Then I hit the tab key
	Then I see "Skip to main content" on the page
	Then the page language is "en"
	Then I click on the "Skip to main content" link
	Then I see "What is your name?" on the page
	
	When I set "First name" to "FirstNameA"
	And I set "Last name" to "LastNameB"
	And I press the "Continue" button
	
	#JDB-3357 Skip to main content check
	Then I hit the tab key
	Then I see "Skip to main content" on the page
	Then the page language is "en"
	Then I click on the "Skip to main content" link
	Then I see "Your relationship to the person" on the page
	
	When I set "How do you know the person you're replying for?" to "Friend"
	And I press the "Continue" button
	
	#JDB-3357 Skip to main content check
	Then I hit the tab key
	Then I see "Skip to main content" on the page
	Then the page language is "en"
	Then I click on the "Skip to main content" link
	Then I see "Your contact information" on the page
	
	When I check the "By phone (UK Numbers only)" checkbox
	And I check the "By email" checkbox
	And I set "Main phone" to "0207 821 1818"
	And I set "Enter your email address" to "<email>"
	And I set "Enter your email address again" to "<email>"
	And I press the "Continue" button
	
	#JDB-3357 Skip to main content check
	Then I hit the tab key
	Then I see "Skip to main content" on the page
	Then the page language is "en"
	Then I click on the "Skip to main content" link
	Then I see "Why are you replying for the other person?" on the page
	
	And I set the radio button to "The person is not here"
	And I press the "Continue" button
	
	#JDB-3357 Skip to main content check
	Then I hit the tab key
	Then I see "Skip to main content" on the page
	Then the page language is "en"
	Then I click on the "Skip to main content" link
	Then I see "Is the name we have for them correct?" on the page
	And I set the radio button to "Yes"
	
	And I press the "Continue" button

	#JDB-3357 Skip to main content check
	Then I hit the tab key
	Then I see "Skip to main content" on the page
	Then the page language is "en"
	Then I click on the "Skip to main content" link
	Then I see "Is this their address?" on the page
	And I set the radio button to "Yes"
	
	And I press the "Continue" button
	
	#JDB-3357 Skip to main content check
	Then I hit the tab key
	Then I see "Skip to main content" on the page
	Then the page language is "en"
	Then I click on the "Skip to main content" link
	Then I see "Give the date of birth for the person you're replying for" on the page
	
	When I set "Day" to "27"
	And I set "Month" to "04"
	And I set "Year" to "1981"
	And I press the "Continue" button
	
	#JDB-3357 Skip to main content check
	Then I hit the tab key
	Then I see "Skip to main content" on the page
	Then the page language is "en"
	Then I click on the "Skip to main content" link
	Then I see "We might need to get in touch" on the page
	
	When I set the radio button to "Use the phone number that you have already given to contact you"
	When I set the radio button to "Use the email address that you have already given to contact you"
	And I press the "Continue" button

	#JDB-3357 Skip to main content check
	Then I see "Confirm if the person is eligible for jury service" on the page

	Then I hit the tab key
	Then I see "Skip to main content" on the page
	Then the page language is "en"
	Then I click on the "Skip to main content" link
	Then I see "Confirm if the person is eligible for jury service" on the page

	And I press the "Continue" button
	
	#JDB-3357 Skip to main content check
	Then I hit the tab key
	Then I see "Skip to main content" on the page
	Then the page language is "en"
	Then I click on the "Skip to main content" link
	Then I see "Since they turned 13," on the page
	
	When I set the radio button to "Yes"
	And I press the "Continue" button
	
	#JDB-3357 Skip to main content check
	Then I hit the tab key
	Then I see "Skip to main content" on the page
	Then the page language is "en"
	Then I click on the "Skip to main content" link
	Then I see "Has the person you're replying for worked in the criminal justice system in the last 5 years?" on the page
	
	When I set the radio button to "No"
	And I press the "Continue" button
	
	#JDB-3357 Skip to main content check
	Then I hit the tab key
	Then I see "Skip to main content" on the page
	Then the page language is "en"
	Then I click on the "Skip to main content" link
	Then I see "Is the person currently on bail" on the page
	
	When I set the radio button to "No"
	And I press the "Continue" button
	
	#JDB-3357 Skip to main content check
	Then I hit the tab key
	Then I see "Skip to main content" on the page
	Then the page language is "en"
	Then I click on the "Skip to main content" link
	Then I see "Has the person been found guilty of a criminal offence?" on the page
	
	When I set the radio button to "No"
	And I press the "Continue" button
	
	#JDB-3357 Skip to main content check
	Then I hit the tab key
	Then I see "Skip to main content" on the page
	Then the page language is "en"
	Then I click on the "Skip to main content" link
	Then I see "Is the person you're replying for being detained" on the page
	
	When I set the radio button to "No"
	And I press the "Continue" button
	
	#JDB-3357 Skip to main content check
	Then I hit the tab key
	Then I see "Skip to main content" on the page
	Then the page language is "en"
	Then I click on the "Skip to main content" link
	Then I see "Has it been decided that the person you're replying for 'lacks mental capacity'?" on the page
	
	When I set the radio button to "No"
	And I press the "Continue" button
	
	#JDB-3357 Skip to main content check
	Then I hit the tab key
	Then I see "Skip to main content" on the page
	Then the page language is "en"
	Then I click on the "Skip to main content" link
	Then I see "Check your start date" on the page
	
	Then I set the radio button to "Yes, they can start on"
	And I press the "Continue" button
	
	#JDB-3357 Skip to main content check
	Then I hit the tab key
	Then I see "Skip to main content" on the page
	Then the page language is "en"
	Then I click on the "Skip to main content" link
	Then I see "Will the person you're replying for need help when they're at the court?" on the page
	
	When I set the radio button to "No"
	And I press the "Continue" button
	
	#JDB-3357 Skip to main content check
	Then I hit the tab key
	Then I see "Skip to main content" on the page
	Then the page language is "en"
	Then I click on the "Skip to main content" link
	Then I see "Check your answers now" on the page
	
	Then I check the "The answers I have given for the person I'm replying for are true as far as I know." checkbox
	
	When I press the "Submit" button

	#JDB-3357 Skip to main content check
	Then I hit the tab key
	Then I see "Skip to main content" on the page
	Then the page language is "en"
	Then I click on the "Skip to main content" link
	Then I see "You have completed your reply" on the page

Examples:
	| juror_number	| pool_number	| last_name	| postcode	| email 		|
	| 045200090		| 452300089		| DOE		| SW1H 9AJ	| e@eeee.com	|