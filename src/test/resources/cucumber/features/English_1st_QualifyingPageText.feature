Feature: 1st English Qualify Page Text

@JDB-3420 @Regression
Scenario Outline: Checking page text for Eligibility page
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
	
	#Check Name
	#JDB-4218
	#JDB-4125
	
	And I set the radio button to "No"
	And I press the "Continue" button
	Then I see "What is your name?" on the page
	
	Then I set "First name" to ""
	And I set "Last name" to ""
	And I press the "Continue" button
	Then I see "Enter your first name" on the page
	Then I see "Enter your last name" on the page
	When I set "First name" to "FirstNamea"
	And I set "Last name" to "LastNameb"
	And I press the "Continue" button
	Then I see "Is this your address?" on the page
	When I click on the "Back" link
	Then I see "FirstNamea" on the page
	And I see "LastNameb" on the page
	
	#should this happen?
	
	And I set the radio button to "Yes"
	
	When I press the "Continue" button
	Then I see "Is this your address?" on the page
	
	#Check Address
	
	And I set the radio button to "No"
	And I press the "Continue" button
	
	Then I set "Address line 1" to ""
	And I set "Town or city" to ""
	And I set "County (optional)" to ""
	And I set "Postcode" to ""
	And I press the "Continue" button
	
	Then I see "Provide the town or city you live in" on the page
	Then I see "Enter your postcode" on the page
	When I set "Address line 1" to "123 Street"
	And I set "Town or city" to "London"
	And I set "County (optional)" to "County"
	And I set "Postcode" to "CH1 2AN"
	And I press the "Continue" button
	Then I see "What is your phone number?" on the page
	When I click on the "Back" link
	Then I see "123 Street" on the page
	And I see "London" on the page
	And I see "CH1 2AN" on the page
	
	#should this happen?
	
	And I set the radio button to "Yes"
	
	And I press the "Continue" button
	Then I see "What is your phone number?" on the page
	
	#Phone Details
	
	When I press the "Continue" button
	Then I see "Enter your main phone number" on the page
	When I set "Main phone" to "0207 821 1818"
	And I press the "Continue" button
	Then I see "What is your email address?" on the page
	When I click on the "Back" link
	Then I see "What is your phone number?" on the page
	And I press the "Continue" button
	Then I see "What is your email address?" on the page
	
	#Email
	
	When I press the "Continue" button
	Then I see "Enter your email address" on the page
	When I set "Enter your email address" to "email@outlook.com"
	And I set "Enter your email address again" to "email@outlook.com"
	And I press the "Continue" button
	Then I see "What is your date of birth?" on the page
	When I click on the "Back" link
	Then I see "What is your email address?" on the page
	And I press the "Continue" button
	Then I see "What is your date of birth?" on the page
	
	#DoB
	
	When I press the "Continue" button
	Then I see "There is a problem" on the page
	Then I see "Enter the day you were born" on the page
	When I set "Day" to "27"
	And I set "Month" to "04"
	And I set "Year" to "1981"
	And I press the "Continue" button
	Then I see "Confirm you're eligible for jury service" on the page
	When I click on the "Back" link
	Then I see "What is your date of birth?" on the page
	And I press the "Continue" button
	Then I see "Confirm you're eligible for jury service" on the page
	
	And I see "Your answers in this next section will help us check if you can do jury service or not." on the page
	And I see "You must answer these questions even if you:" on the page
	And I see "think you’re not eligible" on the page
	And I see "want to be excused" on the page
	And I see "You can ask for an excusal after this section, if needed." on the page
	
Examples:
	|part_no	|last_name	|postcode	|email           	|pool_no	|
	|641500610	|DOE		|SW1H 9AJ	|email@outlook.com	|415170401	|
	
