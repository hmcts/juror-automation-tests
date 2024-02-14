Feature: English_1st_Deferral_SkipMainContent

@Regression @JDB-3357 
Scenario Outline: English 1st Deferral Skip to Main Content Check

	Given I am on "Public" "bau-test"
	Given the juror numbers have not been processed
		| part_no 	| pool_no 	| owner |
		| <part_no> |<pool_no>	| 400 	|

	And "<part_no>" has "LNAME" as "<last_name>" 
	And "<part_no>" has "FNAME" as "FNAMESEVENONETHREE"
	And "<part_no>" has "RET_DATE" as "5 mondays time"
	And "<part_no>" has "NEXT_DATE" as "5 mondays time"
	And "<part_no>" has "Address" as "855 STREET NAME"
	And "<part_no>" has "Address4" as "LONDON"
	And "<part_no>" has "ZIP" as "<postcode>"
	
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
	
	When I set "9-digit juror number" to "<part_no>"
	When I set "Juror last name" to "<last_name>"
	When I set "Juror postcode" to "<postcode>"
	And I press the "Continue" button
	
	#JDB-3357 Skip to main content check

	Then I hit the tab key
	Then I see "Skip to main content" on the page
	Then I click on the "Skip to main content" link
	Then I see "Is the name we have for you correct?" on the page
	And I set the radio button to "Yes"
	
	And I press the "Continue" button
	
	#JDB-3357 Skip to main content check

	Then I hit the tab key
	Then I see "Skip to main content" on the page
	Then I click on the "Skip to main content" link
	Then I see "Is this your address?" on the page
	And I set the radio button to "Yes"
	
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
	And I set "Year" to "1981"
	And I press the "Continue" button
	
	#JDB-3357 Skip to main content check

	Then I hit the tab key
	Then I see "Skip to main content" on the page
	Then I click on the "Skip to main content" link
	Then I see "Confirm you're eligible for jury service" on the page

	And I press the "Continue" button
	
	#JDB-3357 Skip to main content check

	Then I hit the tab key
	Then I see "Skip to main content" on the page
	Then I click on the "Skip to main content" link
	Then I see "Since you turned 13," on the page
	
	When I set the radio button to "Yes"
	And I press the "Continue" button
	
	#CJS
	
	#JDB-3357 Skip to main content check

	Then I hit the tab key
	Then I see "Skip to main content" on the page
	Then I click on the "Skip to main content" link
	Then I see "Have you worked in the criminal justice system in the last 5 years?" on the page
	
	When I set the radio button to "No"
	And I press the "Continue" button
	
	#JDB-3357 Skip to main content check

	Then I hit the tab key
	Then I see "Skip to main content" on the page
	Then I click on the "Skip to main content" link
	Then I see "Are you currently on bail" on the page
	
	When I set the radio button to "No"
	And I press the "Continue" button
	
	#JDB-3357 Skip to main content check

	Then I hit the tab key
	Then I see "Skip to main content" on the page
	Then I click on the "Skip to main content" link
	Then I see "Have you been found guilty of a criminal offence" on the page
	
	When I set the radio button to "No"
	And I press the "Continue" button
	
	#JDB-3357 Skip to main content check

	Then I hit the tab key
	Then I see "Skip to main content" on the page
	Then I click on the "Skip to main content" link
	Then I see "Are you being detained, looked after or treated under the Mental Health Act?" on the page
	
	When I set the radio button to "No"
	And I press the "Continue" button
	
	#JDB-3357 Skip to main content check

	Then I hit the tab key
	Then I see "Skip to main content" on the page
	Then I click on the "Skip to main content" link
	Then I see "Has it been decided that you 'lack mental capacity'?" on the page
	
	When I set the radio button to "No"
	And I press the "Continue" button
	
	#JDB-3357 Skip to main content check

	Then I hit the tab key
	Then I see "Skip to main content" on the page
	Then I click on the "Skip to main content" link
	Then I see "Check your start date" on the page
	
	When I set the radio button to "No, I need to change the date"
	And I press the "Continue" button
	
	#JDB-3357 Skip to main content check

	Then I hit the tab key
	Then I see "Skip to main content" on the page
	Then I click on the "Skip to main content" link
	Then I see "Tell us why you need another date for your jury service" on the page
	
	When I set text area with "id" of "deferralReason" to "ReasonWhy"
	And I press the "Continue" button
	
	#JDB-3357 Skip to main content check

	Then I hit the tab key
	Then I see "Skip to main content" on the page
	Then I click on the "Skip to main content" link
	Then I see "Choose 3 Mondays when you can start jury service" on the page

	When I set the "First" single date field to a Monday "6" weeks in the future
	When I set the "Second" single date field to a Monday "7" weeks in the future
	When I set the "Third" single date field to a Monday "8" weeks in the future
	And I press the "Continue" button
	
	Then I hit the tab key
	Then I see "Skip to main content" on the page
	Then I click on the "Skip to main content" link
	And I see "Check your dates" on the page
	
	And I set the radio button to "Yes"
	And I press the "Continue" button
	
	#JDB-3357 Skip to main content check

	Then I hit the tab key
	Then I see "Skip to main content" on the page
	Then I click on the "Skip to main content" link
	Then I see "Will you need help when you're at the court?" on the page
	
	When I set the radio button to "No"
	And I press the "Continue" button
	
	#JDB-3357 Skip to main content check

	Then I hit the tab key
	Then I see "Skip to main content" on the page
	Then I click on the "Skip to main content" link
	Then I see "Check your answers now" on the page
	
	Then I check the "The information I have given is true to the best of my knowledge" checkbox
	
	When I press the "Submit" button

	#JDB-3357 Skip to main content check

	Then I hit the tab key
	Then I see "Skip to main content" on the page
	Then I click on the "Skip to main content" link
	Then I see "You have completed your reply" on the page

Examples:
	|part_no		|pool_no	|last_name	|postcode	|email 		| 
	|841500197		|415181001	|LNAME197	|CH1 2AN	|e@eeee.com	|