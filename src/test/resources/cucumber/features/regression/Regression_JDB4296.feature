Feature: JDB-4296

@JDB-4296 @Regression 
Scenario Outline: JDB-4296
	Given I am on "Public" "juror-test02"
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
	
	#Juror Log In
	
	When I set "9-digit juror number" to "<part_no>"
	When I set "Juror last name" to "<last_name>"
	When I set "Juror postcode" to "<postcode>"
	And I press the "Continue" button
	Then I see "Is the name we have for you correct?" on the page
	When I set the radio button to "Yes"
	
	#Name
	
	And I press the "Continue" button
	Then I see "Is this your address?" on the page
	When I set the radio button to "Yes"
	
	#Address
	
	And I press the "Continue" button
	Then I see "What is your phone number?" on the page
	
	#Phone Details
	
	When I set "Main phone" to "0207 821 1818"
	And I press the "Continue" button
	
	#Email
	
	When I set "Enter your email address" to "email@outlook.com"
	And I set "Enter your email address again" to "email@outlook.com"
	And I press the "Continue" button
	
	#DoB
	
	Then I see "What is your date of birth?" on the page
	When I set "Day" to "27"
	And I set "Month" to "04"
	And I set "Year" to "1981"
	And I press the "Continue" button
	Then I see "Confirm you're eligible for jury service" on the page
	
	When I press the "Continue" button
	
	#Residency
	
	Then I see "Since you turned 13, has your main address been in the UK, Channel Islands or Isle of Man for any period of at least 5 years?" on the page
	When I set the radio button to "Yes"
	And I press the "Continue" button
	
	#now start clicking Back
	
	Then I see "Have you worked" on the page
	When I click on the "Back" link
	Then I see "Since you turned 13, has your main address been in the UK, Channel Islands or Isle of Man for any period of at least 5 years?" on the page
	When I click on the "Back" link
	Then I see "Confirm you're eligible for jury service" on the page
	When I click on the "Back" link
	
	#change DOB to make juror over age
	
	Then I see "What is your date of birth?" on the page
	When I set "Day" to "27"
	And I set "Month" to "04"
	And I set "Year" to "1901"
	And I press the "Continue" button
	Then I see "Confirm your date of birth" on the page
	And I set the radio button to "Yes"
	When I press the "Continue" button 
	
	#Submit
	
	And I see "Check your answers now" on the page
	Then I check the "The information I have given is true to the best of my knowledge" checkbox
	When I press the "Submit" button
	
Examples:
	|part_no		|last_name	|postcode	|email           	|pool_no	|
	|645100483		|DOE		|SW1H 9AJ	|email@outlook.com	|451170401	|