Feature: Regression English_1st_Overage_SkipMainContent

@Regression @replytypes @JDB-3357 @JDB-3985 
Scenario Outline: English 1st Overage Skip to Main Content Check

	Given I am on "Public" "test"
	Given the juror numbers have not been processed
		| part_no 	| pool_no 	| owner |
		| <part_no> |<pool_no>	| 400 	|

	And "<part_no>" has "LNAME" as "<last_name>" 
	And "<part_no>" has "FNAME" as "FNAMESEVENONETHREE"
	And "<part_no>" has "RET_DATE" as "5 mondays time"
	And "<part_no>" has "NEXT_DATE" as "5 mondays time"
	#And "<part_no>" has "FNAME" as "FNAMEEIGHTFIVEFIVE"
	And "<part_no>" has "Address" as "855 STREET NAME"
	#And "<part_no>" has "Address2" as "ANYTOWN"
	#And "<part_no>" has "Address3" as ""
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
	And I log in
	
	When I click on the "Search" link
	And I set "Juror number" to "<part_no>"
	And I press the "Search" button
	Then I see "<part_no>" on the page

	Then I see "<part_no>" has reply type indicator "COMPLETED"
	
	
Examples:
	|part_no	|pool_no	|last_name	|postcode	|email 		| 
	|641500417	|415170401	|DOE		|SW1H 9AJ	|e@eeee.com	|