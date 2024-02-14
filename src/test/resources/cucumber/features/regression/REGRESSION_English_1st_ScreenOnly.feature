 Feature: English_1st_ScreenOnly

@Regression @JDB-3349 @JDB-3350 @JDB-3358 @JDB-3359 @JDB-3360 @JDB-3361 @JDB-3362 @JDB-3373 @JDB-3378 @JDB-3363 @JDB-3364 @JDB-3371 @JDB-3377
@JDB-3370 @JDB-3376 @JDB-3355 @JDB-3372 @JDB-3418
Scenario Outline: English 1st Screen Only
	Given I am on "Public" "juror-test02"
	Then the page title is "Reply to a jury summons - GOV.UK"
	
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
	And I set "9-digit juror number" to "<part_no>"
	And I set "Juror last name" to "<last_name>"
	And I set "Juror postcode" to "<postcode>"
	And I press the "Continue" button
	
	#JDB-3358
	
	Then on the page I see
		| text	|
		| Your details |
		| Is the name we have for you correct? |
	
	And I set the radio button to "No"
	And I press the "Continue" button
	
	And I set "First name" to ""
	And I set "Last name" to ""
	And I press the "Continue" button
	
	Then on the page I see
		| text	|
		| Enter your first name	|
		| Enter your last name 	|
		
	When I set "First name" to "FirstNameA"
	And I set "Last name" to "LastNameB"
	And I press the "Continue" button
	
	#JDB-3359 and JDB-3355
	
	Then on the page I see
		| text	|
		| Your details |
		| Is this your address? |
	
	And I set the radio button to "Yes"
	And I press the "Continue" button
	
	#JDB-3361
	
	Then on the page I see
		| text	|
		|Your details|
		|What is your phone number?|
		|Please provide a UK phone number that we can use to reach you between 9am and 5pm, Monday to Friday.|
		|Main phone|
		|Another phone (optional)|
	
	When I set "Main phone" to "0207 821 1818"
	And I press the "Continue" button
	Then I see "What is your email address?" on the page
	
	When I click on the "Why do we need your email address?" link
	Then I see "We'll use your email address to send you information and reminders about your jury service." on the page
	And I set "Enter your email address" to "email@outlook.com"
	And I set "Enter your email address again" to "email@outlook.com"
	And I press the "Continue" button

	#JDB-3350 and JDB-3360

	Then on the page I see
		| text	|
		| Your details |
		| What is your date of birth? |
		| For example, 15 03 1982 |
		| Help with date of birth |
	
	When I press the "Continue" button
	Then on the page I see
		| text	|
		| There is a problem	|
		| Enter the day you were born |	
		| Your details	|
		| What is your date of birth?	|
		| For example, 15 03 1982 |
		| Help with date of birth |
	
	When I set "Day" to "01"
	And I set "Month" to "01"
	
	#JDB-3418 Checking age 18 works
	
	And I set "Year" to "2000"
	And I press the "Continue" button
	Then I see "Confirm you're eligible for jury service" on the page
	
Examples:
	| part_no		|last_name		|postcode	|email 		| pool_no |
	|841501663		|LNAMEEIGHTFOUR	|CH1 2AN	|a@eeee.com	|415181001|