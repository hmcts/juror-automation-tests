Feature: English_1st_SkipMainContent

@Regression @NewSchemaConverted
Scenario Outline: English 1st Party Straight Through with Skip to Main Content Checks

	Given I am on "Public" "test"

	Given a bureau owned pool is created with jurors
		| court |juror_number  | pool_number	| att_date_weeks_in_future	| owner |
		| 452   |<juror_number>| <pool_number>	| 5				            | 400	|

	And juror "<juror_number>" has "LAST_NAME" as "<last_name>" new schema
	And juror "<juror_number>" has "FIRST_NAME" as "FNAMESEVENONETHREE" new schema
	And juror "<juror_number>" has "ADDRESS_LINE_1" as "855 STREET NAME" new schema
	And juror "<juror_number>" has "ADDRESS_LINE_4" as "LONDON" new schema
	And juror "<juror_number>" has "POSTCODE" as "<postcode>" new schema
	
	#JDB-3357 Skip to main content check
	#Reply to jury summons
	When I hit the tab key
	Then I see "Skip to main content" on the page
	And I do not see any links on the page that open to a new page without an alt text
	When I click on the "Skip to main content" link
	Then I see "Reply to a jury summons" on the page
	
	#JDB-3357 Skip to main content check
	Then I hit the tab key
	Then I see "Skip to main content" on the page
	Then I click on the "Skip to main content" link
	Then I see "Are you replying for yourself or for someone else?" on the page
	
	And I set the radio button to "I am replying for myself"
	And I press the "Continue" button
	And I do not see any links on the page that open to a new page without an alt text
	
	#JDB-3357 Skip to main content check
	Then I hit the tab key
	Then I see "Skip to main content" on the page
	Then I click on the "Skip to main content" link
	Then I see "Your juror details" on the page
	
	When I set "9-digit juror number" to "<juror_number>"
	When I set "Juror last name" to "<last_name>"
	When I set "Juror postcode" to "<postcode>"
	And I press the "Continue" button
	And I do not see any links on the page that open to a new page without an alt text
	
	#JDB-3357 Skip to main content check
	Then I hit the tab key
	Then I see "Skip to main content" on the page
	Then I click on the "Skip to main content" link
	Then I see "Is the name we have for you correct?" on the page
	When I set the radio button to "Yes"
	
	And I press the "Continue" button
	And I do not see any links on the page that open to a new page without an alt text
	
	#JDB-3357 Skip to main content check
	Then I hit the tab key
	Then I see "Skip to main content" on the page
	Then I click on the "Skip to main content" link
	Then I see "Is this your address?" on the page
	When I set the radio button to "Yes"
	
	And I press the "Continue" button
	And I do not see any links on the page that open to a new page without an alt text
	
	#JDB-3357 Skip to main content check
	Then I hit the tab key
	Then I see "Skip to main content" on the page
	Then I click on the "Skip to main content" link
	Then I see "What is your phone number?" on the page
	
	When I set "Main phone" to "02078211818"
	And I press the "Continue" button
	And I do not see any links on the page that open to a new page without an alt text
	
	#JDB-3357 Skip to main content check
	Then I hit the tab key
	Then I see "Skip to main content" on the page
	Then I click on the "Skip to main content" link
	Then I see "What is your email address?" on the page
	
	When I set "Enter your email address" to "<email>"
	When I set "Enter your email address again" to "<email>"
	And I press the "Continue" button
	And I do not see any links on the page that open to a new page without an alt text
	
	#JDB-3357 Skip to main content check
	Then I hit the tab key
	Then I see "Skip to main content" on the page
	Then I click on the "Skip to main content" link
	Then I see "What is your date of birth?" on the page
	
	When I set "Day" to "27"
	And I set "Month" to "04"
	And I set "Year" to "1981"
	And I press the "Continue" button
	And I do not see any links on the page that open to a new page without an alt text
	
	#JDB-3357 Skip to main content check
	Then I hit the tab key
	Then I see "Skip to main content" on the page
	Then I click on the "Skip to main content" link
	Then I see "Confirm you're eligible for jury service" on the page

	And I press the "Continue" button
	And I do not see any links on the page that open to a new page without an alt text
	
	#JDB-3357 Skip to main content check
	Then I hit the tab key
	Then I see "Skip to main content" on the page
	Then I click on the "Skip to main content" link
	Then I see "Since you turned 13," on the page
	
	When I set the radio button to "Yes"
	And I press the "Continue" button
	And I do not see any links on the page that open to a new page without an alt text
	
	#JDB-3357 Skip to main content check
	Then I hit the tab key
	Then I see "Skip to main content" on the page
	Then I click on the "Skip to main content" link
	Then I see "Have you worked in the criminal justice system in the last 5 years?" on the page
	
	When I set the radio button to "No"
	And I press the "Continue" button
	And I do not see any links on the page that open to a new page without an alt text
	
	#JDB-3357 Skip to main content check
	Then I hit the tab key
	Then I see "Skip to main content" on the page
	Then I click on the "Skip to main content" link
	Then I see "Are you currently on bail" on the page
	
	When I set the radio button to "No"
	And I press the "Continue" button
	And I do not see any links on the page that open to a new page without an alt text
	
	#JDB-3357 Skip to main content check
	Then I hit the tab key
	Then I see "Skip to main content" on the page
	Then I click on the "Skip to main content" link
	Then I see "Have you been found guilty of a criminal offence" on the page
	
	When I set the radio button to "No"
	And I press the "Continue" button
	And I do not see any links on the page that open to a new page without an alt text
	
	#JDB-3357 Skip to main content check
	Then I hit the tab key
	Then I see "Skip to main content" on the page
	Then I click on the "Skip to main content" link
	Then I see "Are you being detained, looked after or treated under the Mental Health Act?" on the page
	
	When I set the radio button to "No"
	And I press the "Continue" button
	And I do not see any links on the page that open to a new page without an alt text
	
	#JDB-3357 Skip to main content check
	Then I hit the tab key
	Then I see "Skip to main content" on the page
	Then I click on the "Skip to main content" link
	Then I see "Has it been decided that you 'lack mental capacity'?" on the page
	
	When I set the radio button to "No"
	And I press the "Continue" button
	And I do not see any links on the page that open to a new page without an alt text
	
	#JDB-3357 Skip to main content check
	Then I hit the tab key
	Then I see "Skip to main content" on the page
	Then I click on the "Skip to main content" link
	Then I see "Check your start date" on the page
	
	And I see "Yes, I can start on" on the page
	And I set the radio button to "Yes, I can start on"
	And I press the "Continue" button
	And I do not see any links on the page that open to a new page without an alt text
	
	#JDB-3357 Skip to main content check
	Then I hit the tab key
	Then I see "Skip to main content" on the page
	Then I click on the "Skip to main content" link
	Then I see "Will you need help when you're at the court?" on the page
	
	When I set the radio button to "No"
	And I press the "Continue" button
	And I do not see any links on the page that open to a new page without an alt text
	
	#JDB-3357 Skip to main content check
	Then I hit the tab key
	Then I see "Skip to main content" on the page
	Then I click on the "Skip to main content" link
	Then I see "Check your answers now" on the page
	
	Then I check the "The information I have given is true to the best of my knowledge" checkbox
	
	When I press the "Submit" button
	And I do not see any links on the page that open to a new page without an alt text

	#JDB-3357 Skip to main content check
	Then I hit the tab key
	Then I see "Skip to main content" on the page
	Then I click on the "Skip to main content" link
	Then I see "You have completed your reply" on the page
	And I do not see any links on the page that open to a new page without an alt text

Examples:
	| juror_number	|pool_number|last_name	|postcode	| email 	|
	| 045200068		|452300067	|LNAME1081	|CH1 2AN	|e@eeee.com	|