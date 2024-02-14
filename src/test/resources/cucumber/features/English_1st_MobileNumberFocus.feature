Feature: 1st_Straight Spaces in Phone number

@JDB-2988 @JDB-3373 @RegressionSingle 
Scenario Outline: 
#	Given I am on "Public" "juror-test02"
	Given I am on "Public" "bau-test"
	
	Given auto straight through processing has been disabled
	
	Given the juror numbers have not been processed
		| part_no 	| pool_no 	| owner |
		| <part_no> |<pool_no>	| 400 	|
		
	
	And "<part_no>" has "LNAME" as "<last_name>" 
	And "<part_no>" has "RET_DATE" as "5 mondays time"
	And "<part_no>" has "NEXT_DATE" as "5 mondays time"
	And "<part_no>" has "ZIP" as "<postcode>"
	
	Then I see "Reply to a jury summons" on the page
	
	And I set the radio button to "I am replying for myself"
	And I press the "Continue" button
	Then I see "Your juror details" on the page
	
	When I set "9-digit juror number" to "<part_no>"
	When I set "Juror last name" to "<last_name>"
	When I set "Juror postcode" to "<postcode>"
	And I press the "Continue" button
	
	#Moving past Name Section
	
	When I set the radio button to "Yes"
	And I press the "Continue" button
	Then I see "Is this your address?" on the page
	When I set the radio button to "Yes"
	When I press the "Continue" button
	
	
	#JDB-2988	

	When I set "Main phone" to "0207 8211 818"
	When I set "Another phone (optional)" to "0207 1111 111"
	And I press the "Continue" button 
	When I set "Enter your email address" to "<email>"
	When I set "Enter your email address again" to "<email>"
	And I press the "Continue" button

	#On DoB Screen
	
	Then I see "date of birth" on the page
	
	When I set "Day" to "27"
	And I set "Month" to "04"
	And I set "Year" to "1990"
	And I press the "Continue" button
	
	Then I see "Confirm you're eligible for jury service" on the page
	
	When I press the "Continue" button
	
	#JDB-3373
	
	Then I see "Since you turned 13, has your main address been in the UK, Channel Islands or Isle of Man for any period of at least 5 years?" on the page
	
	#Residency JDB-3378
	
	When I see "Eligibility" on the page
	And I set the radio button to "Yes"
	And I press the "Continue" button

	#CJS no
	
	Then I see "Have you worked in the criminal justice system in the last 5 years?" on the page
	When I set the radio button to "No"
	And I press the "Continue" button
	
	#JDB-3371
	
	Then I see "Are you currently on bail for a criminal offence?" on the page
	
	#Bail JDB-3377
	
	When I see "Eligibility" on the page
	And I set the radio button to "No"
	And I press the "Continue" button
	
	#JDB-3370
	
	Then I see "Have you been found guilty of a criminal offence?" on the page
	
	#Convictions JDB-3376
	
	When I see "Eligibility" on the page
	When I set the radio button to "No"
	And I press the "Continue" button
	
	#Mental Health Sectioned JDB-3363
	
	Then I see "Are you being detained, looked after or treated under the Mental Health Act?" on the page	
	When I see "Eligibility" on the page
	And I set the radio button to "No"
	And I press the "Continue" button
	
	#Mental Health Capacity JDB-3364
	
	Then I see "Has it been decided that you 'lack mental capacity'?" on the page
	When I see "Eligibility" on the page
	And I set the radio button to "No"
	And I press the "Continue" button
	
	Then I see "Check your start date" on the page
	
	#I can attend
	
	And I see "Yes, I can start on" on the page
	And I set the radio button to "Yes, I can start on"
	And  I press the "Continue" button
	
	#RA no
	
	Then I see "Will you need help when you're at the court?" on the page
	When I set the radio button to "No"
	And I press the "Continue" button
	Then I see "Check your answers now" on the page
	Then I see "0207 8211 818" on the page
	And I see "0207 1111 111" on the page
	
	When I click on the "Change" link in the same row as "Main phone"
	Then "Main phone" is "0207 8211 818"
	And "Another phone (optional)" is "0207 1111 111"
	
	When I set "Another phone (optional)" to "0207 1111 112"
	And I press the "Continue" button
	When I click on the "Change" link in the same row as "Another phone (optional)"
	Then "Another phone (optional)" is "0207 1111 112"
	
	When I press the "Continue" button
	
	And I check the "The information" checkbox
	And I press the "Submit" button
	Then I see "You have completed your reply" on the page
	
	Given auto straight through processing has been enabled
	
#	When I have completed the response for
#		| part_no 	|
#		| <part_no>|
#	Then I see "COMPLETED" on the page
	
	Given I am on "Bureau" "bau-test"
	When I log in as "CPASS"
	
	When I click on the "Search" link
	And I set "Juror number" to "<part_no>"
	And I press the "Search" button
	Then I see "<part_no>" on the page
	And I click on "<part_no>" in the same row as "<part_no>"

	And I press the "Process reply" button
	And I click on the "Excusal" link
	Then I select "D - DECEASED" from the "Reason for the excusal request" dropdown
	And I set the radio button to "Accept excusal request"
	And I press the "Confirm" button
	And I see "Excused" on the page
	And I see "COMPLETED" on the page
	
	Then on "JUROR" . "POOL" I see "H_PHONE" is "0207 8211 818" where "PART_NO" is "<part_no>"
	Then on "JUROR" . "POOL" I see "W_PHONE" is "0207 1111 112" where "PART_NO" is "<part_no>"
	
Examples:
	|part_no		|last_name			|postcode	| email 	| pool_no	|
	|645700360		|LNAMETHREESIXZERO	|SA1 4PF	|a@eeee.com	| 457170401	|