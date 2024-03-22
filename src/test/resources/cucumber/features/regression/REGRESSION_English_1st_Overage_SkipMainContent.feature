Feature: Regression English_1st_Overage_SkipMainContent

@Regression @NewSchemaConverted
Scenario Outline: English 1st Overage Skip to Main Content Check

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
	When I click on the "Skip to main content" link
	Then I see "Reply to a jury summons" on the page
	
	#JDB-3357 Skip to main content check
	Then I hit the tab key
	Then I see "Skip to main content" on the page
	Then I click on the "Skip to main content" link
	Then I see "Are you replying for yourself or for someone else?" on the page
	
	And I set the radio button to "I am replying for myself"
	And I press the "Continue" button
	
	#JDB-3357 Skip to main content check
	Then I hit the tab key
	Then I see "Skip to main content" on the page
	Then I click on the "Skip to main content" link
	Then I see "Your juror details" on the page
	
	When I set "9-digit juror number" to "<juror_number>"
	When I set "Juror last name" to "<last_name>"
	When I set "Juror postcode" to "<postcode>"
	And I press the "Continue" button
	
	#JDB-3357 Skip to main content check
	Then I hit the tab key
	Then I see "Skip to main content" on the page
	Then I click on the "Skip to main content" link
	Then I see "Is the name we have for you correct?" on the page
	When I set the radio button to "Yes"
	
	And I press the "Continue" button
	
	#JDB-3357 Skip to main content check
	Then I hit the tab key
	Then I see "Skip to main content" on the page
	Then I click on the "Skip to main content" link
	Then I see "Is this your address?" on the page
	When I set the radio button to "Yes"
	
	And I press the "Continue" button
	
	#JDB-3357 Skip to main content check
	Then I hit the tab key
	Then I see "Skip to main content" on the page
	Then I click on the "Skip to main content" link
	Then I see "What is your phone number?" on the page
	
	When I set "Main phone" to "02078211818"
	And I press the "Continue" button
	
	#JDB-3357 Skip to main content check
	Then I hit the tab key
	Then I see "Skip to main content" on the page
	Then I click on the "Skip to main content" link
	Then I see "What is your email address?" on the page
	
	When I set "Enter your email address" to "<email>"
	When I set "Enter your email address again" to "<email>"
	And I press the "Continue" button
	
	#JDB-3357 Skip to main content check
	Then I hit the tab key
	Then I see "Skip to main content" on the page
	Then I click on the "Skip to main content" link
	Then I see "What is your date of birth?" on the page
	
	When I set "Day" to "27"
	And I set "Month" to "04"
	And I set "Year" to "1937"
	And I press the "Continue" button
	
	#JDB-3357 Skip to main content check and JDB-3985
	Then I hit the tab key
	Then I see "Skip to main content" on the page
	Then I click on the "Skip to main content" link
	And I see "steps/your-details/confirm" in the URL
	Then I see "Confirm your date of birth" on the page
	
	Then I set the radio button to "No"
	And I press the "Continue" button
	
	And I set "Year" to "1950"
	And I press the "Continue" button
	Then I see "Confirm you're eligible for jury service" on the page
	When I click on the "Back" link
	Then I see "What is your date of birth?" on the page
	
	When I set "Day" to "27"
	And I set "Month" to "04"
	And I set "Year" to "1937"
	And I press the "Continue" button
	Then I see "Confirm your date of birth" on the page
	
	And I press the "Continue" button
	Then I see "There is a problem" on the page
	And I see "Tell us if your date of birth is correct" on the page
	
	Then I set the radio button to "Yes"
	
	When I press the "Continue" button
	Then I see "Check your answers now" on the page
	
	#JDB-3357 Skip to main content check
	Then I hit the tab key
	Then I see "Skip to main content" on the page
	Then I click on the "Skip to main content" link
	Then I see "Check your answers now" on the page
	
	When I click on the "Change" link in the same row as "Date of birth"
	And I set "Year" to "1937"
	And I press the "Continue" button
	And I see "Confirm your date of birth" on the page
	And I set the radio button to "Yes"
	And I press the "Continue" button
	And I see "Check your answers now" on the page
	
	Then I check the "The information I have given is true to the best of my knowledge" checkbox
	
	When I press the "Submit" button

	#JDB-3357 Skip to main content check
	Then I hit the tab key
	Then I see "Skip to main content" on the page
	Then I click on the "Skip to main content" link
	Then I see "You have completed your reply" on the page

	Given I am on "Bureau" "test"
	And I log in as "MODTESTBUREAU"
	
	When I click on the "Search" link
	And I set "Juror number" to "<juror_number>"
	And I press the "Search" button
	Then I see "<juror_number>" on the page

	Then I see "<juror_number>" has reply type indicator "Completed"
	
Examples:
	| juror_number	| pool_number	|last_name	|postcode	|email 		|
	| 045200066		| 452300065		|DOE		|SW1H 9AJ	|e@eeee.com	|