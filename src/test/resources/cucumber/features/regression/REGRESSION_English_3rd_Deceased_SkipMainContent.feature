Feature: Regression English_3rd_Deceased_SkipMainContent

#TO DO: WELSH 3rd DECEASED

@Regression @JDB-3357 
Scenario Outline: English 3rd Deceased Skip to Main Content Check
	Given I am on "Public" "juror-test02"
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
	
	And I set the radio button to "I am replying for someone else"
	And I press the "Continue" button
	
	#JDB-3357 Skip to main content check

	Then I hit the tab key
	Then I see "Skip to main content" on the page
	Then I click on the "Skip to main content" link
	Then I see "Their juror details" on the page
	
	When I set "9-digit juror number" to "<part_no>"
	When I set "Juror last name" to "<last_name>"
	When I set "Juror postcode" to "<postcode>"
	And I press the "Continue" button
	
	#JDB-3357 Skip to main content check

	Then I hit the tab key
	Then I see "Skip to main content" on the page
	Then I click on the "Skip to main content" link
	Then I see "What is your name?" on the page
	
	And I press the "Continue" button
	
	#JDB-3357 Skip to main content check

	Then I hit the tab key
	Then I see "Skip to main content" on the page
	Then I click on the "Skip to main content" link
	Then I see "Enter your first name" on the page
	
	When I set "First name" to "FirstName"
	And I set "Last name" to "LastName"
	And I press the "Continue" button
	
	#JDB-3357 Skip to main content check

	Then I hit the tab key
	Then I see "Skip to main content" on the page
	Then I click on the "Skip to main content" link
	Then I see "Your relationship to the person" on the page
	
	When I set "How do you know the person you're replying for?" to "Friend"
	And I press the "Continue" button
	
	#JDB-3357 Skip to main content check

	Then I hit the tab key
	Then I see "Skip to main content" on the page
	Then I click on the "Skip to main content" link
	Then I see "Your contact information" on the page
	
	When I check the "By phone (UK Numbers only)" checkbox
	And I check the "By email" checkbox
	And I set "Main phone" to "02078211818"
	And I set "Enter your email address" to "email@outlook.com"
	And I set "Enter your email address again" to "email@outlook.com"
	And I press the "Continue" button
	
	#JDB-3357 Skip to main content check

	Then I hit the tab key
	Then I see "Skip to main content" on the page
	Then I click on the "Skip to main content" link
	Then I see "Why are you replying for the other person?" on the page
	
	When I set the radio button to "The person has died"
	And I press the "Continue" button
	
	#JDB-3357 Skip to main content check

	Then I hit the tab key
	Then I see "Skip to main content" on the page
	Then I click on the "Skip to main content" link
	Then I see "Check your answers now" on the page
	
	Then I check the "The answers I have given for the person I'm replying for are true as far as I know" checkbox
	
	When I press the "Submit" button

	#JDB-3357 Skip to main content check

	Then I hit the tab key
	Then I see "Skip to main content" on the page
	Then I click on the "Skip to main content" link
	Then I see "You have" on the page

Examples:
	|part_no		|pool_no	|last_name		|postcode	|email 		| 
	|641500401		|415170401	|DOE			|SW1H 9AJ	|e@eeee.com	|
