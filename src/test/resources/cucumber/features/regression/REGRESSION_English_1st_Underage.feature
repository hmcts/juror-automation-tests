Feature: Regression English_1st_Underage

@Regression @NewSchemaConverted
Scenario Outline: English 1st Party Underage
	Given I am on "Public" "test"

	Given a bureau owned pool is created with jurors
		| court |juror_number  | pool_number	| att_date_weeks_in_future	| owner |
		| 452   |<juror_number>| <pool_number>	| 5				            | 400	|
	
	And juror "<juror_number>" has "LAST_NAME" as "<last_name>" new schema
	And juror "<juror_number>" has "POSTCODE" as "<postcode>" new schema
	
	Then I see "Reply to a jury summons" on the page
	
	And I set the radio button to "I am replying for myself"
	And I press the "Continue" button
	Then I see "Your juror details" on the page
	
	When I set "9-digit juror number" to "<juror_number>"
	When I set "Juror last name" to "<last_name>"
	When I set "Juror postcode" to "<postcode>"
	And I press the "Continue" button
	Then I see "Is the name we have for you correct?" on the page
	When I choose the "Yes" radio button
	
	#Moving past Name Section
	When I press the "Continue" button
	Then I see "Is this your address?" on the page
	When I choose the "Yes" radio button
	
	When I press the "Continue" button
	Then I see "What is your phone number?" on the page
	
	When I set "Main phone" to "02078211818"
	And I press the "Continue" button
	Then I see "What is your email address?" on the page
	
	When I set "Enter your email address" to "<email>"
	And I set "Enter your email address again" to "<email>"
	And I press the "Continue" button
	
	#On DoB Screen
	Then I see "What is your date of birth?" on the page
	
	When I set "Day" to "27"
	And I set "Month" to "04"
	And I set "Year" to "2006"
	
	#Moving past DoB Section
	And I press the "Continue" button
	Then I see "Is your date of birth correct?" on the page
	
	#And "Is your date of birth correct?" text is bold
	And I see "steps/your-details/confirm" in the URL
	
	#new change DOB
	And I press the "Continue" button
	Then I see "There is a problem" on the page
	And I see "Tell us if your date of birth is correct" on the page
	
	Then I choose the "No" radio button
	And I press the "Continue" button
	
	#On DoB Screen
	Then I see "What is your date of birth?" on the page
	
	When I set "Day" to ""
	And I set "Month" to ""
	And I set "Year" to ""
	When I press the "Continue" button
	Then I see "There is a problem" on the page
	
	#JDB-4502
	And I see "Enter the day you were born" on the page
	And I do not see "Enter the month you were born" on the page
	And I do not see "Enter the year you were born" on the page

	#only day is set
	When I set "Day" to "27"
	When I press the "Continue" button
	Then I see "There is a problem" on the page
	And I see "Enter the month you were born" on the page
	
	#day and month are set
	And I set "Month" to "04"
	When I press the "Continue" button
	Then I see "There is a problem" on the page
	And I see "Enter the year you were born" on the page
	
	#only year is set
	When I set "Day" to ""
	And I set "Month" to ""
	And I set "Year" to "1988"
	When I press the "Continue" button
	Then I see "There is a problem" on the page
	And I see "Enter the day you were born" on the page
	And I do not see "Enter the month you were born" on the page
	And I do not see "Enter the year you were born" on the page
	
	When I set "Day" to "27"
	And I set "Month" to "04"
	And I set "Year" to "198a"
	And I press the "Continue" button
	Then I see "There is a problem" on the page
	And I see "Enter the year you were born as a 4 digit number. For example, 1982" on the page
	
	When I set "Day" to "27"
	And I set "Month" to "04"
	And I set "Year" to "2006"
	
	And I press the "Continue" button

	#confirm DOB
	Then I choose the "Yes" radio button
	And I press the "Continue" button
	
	Then I see "Check your answers now" on the page
	And I see text "27 April 2006" in the same row as "Date of birth"

	Then I check the "The information I have given is true to the best of my knowledge" checkbox
	When I press the "Submit" button
	
	Then I see "You have completed your reply" on the page
	Then I see "<juror_number>" on the page
	
	Given I am on "Bureau" "test"
	And I log in as "MODTESTBUREAU"
	
	When I click on the "Search" link
	And I set "Juror number" to "<juror_number>"
	And I press the "Search" button
	Then I see "<juror_number>" on the page

	Then I see "<juror_number>" has reply type indicator "Completed"
	
Examples:
	| juror_number	| last_name			| postcode	| email 		| pool_number	|
	| 045200076		| LNAMEFIVEFIVEZERO	| CH1 2AN	| a@eeee.com	| 452300075		|
	
@Regression @NewSchemaConverted
Scenario Outline: English 1st Party Underage with Error Check
	Given I am on "Public" "test"

	Given a bureau owned pool is created with jurors
		| court |juror_number  | pool_number	| att_date_weeks_in_future	| owner |
		| 452   |<juror_number>| <pool_number>	| 5				            | 400	|
	
	And juror "<juror_number>" has "LAST_NAME" as "<last_name>" new schema
	And juror "<juror_number>" has "POSTCODE" as "<postcode>" new schema
	
	Then I see "Reply to a jury summons" on the page
	
	And I set the radio button to "I am replying for myself"
	And I press the "Continue" button
	Then I see "Your juror details" on the page
	
	When I set "9-digit juror number" to "<juror_number>"
	When I set "Juror last name" to "<last_name>"
	When I set "Juror postcode" to "<postcode>"
	And I press the "Continue" button
	Then I see "Is the name we have for you correct?" on the page
	When I choose the "Yes" radio button
	
	#Moving past Name Section
	And I press the "Continue" button
	Then I see "Is this your address?" on the page
	When I choose the "Yes" radio button
	
	When I press the "Continue" button
	Then I see "What is your phone number?" on the page
	
	When I set "Main phone" to "02078211818"
	And I press the "Continue" button
	Then I see "What is your email address?" on the page
	
	When I set "Enter your email address" to "<email>"
	And I set "Enter your email address again" to "<email>"
	And I press the "Continue" button
	
	#On DoB Screen
	Then I see "What is your date of birth?" on the page

	#set dob to make them underage
	And I set the date of birth to a Monday "-884" weeks in the future
	
	#Moving past DoB Section and JDB-3417
	And I press the "Continue" button
	Then I see "Is your date of birth correct?" on the page
	
	And I choose the "Yes" radio button
	And I press the "Continue" button

	And I click on the "Change" link in the same row as "Date of birth"

	#set dob to make them underage
	And I set the date of birth to a Monday "-884" weeks in the future

	And I press the "Continue" button
	
	Then I see "Is your date of birth correct?" on the page
	
	And I choose the "No" radio button
	And I press the "Continue" button
	
	And I set "Day" to ""
	And I set "Month" to ""
	And I set "Year" to ""
	And I press the "Continue" button
	Then on the page I see 
		| text	|
		| There is a problem|
		| Enter the day you were born |
			
	When I set "Day" to "27"
	And I set "Month" to "04"
	And I set "Year" to "198a"
	And I press the "Continue" button
	Then I see "Enter the year you were born as a 4 digit number. For example, 1982" on the page

	#set dob to make them underage
	And I set the date of birth to a Monday "-884" weeks in the future
	And I press the "Continue" button
	
	And I choose the "Yes" radio button
	And I press the "Continue" button
	
	Then I see "Check your answers now" on the page

	Then I check the "The information I have given is true to the best of my knowledge" checkbox
	When I press the "Submit" button
	
	Then I see "You have completed your reply" on the page
	And I see "Your age means you cannot do jury service" on the page
	Then I see "<juror_number>" on the page
	
Examples:
	| juror_number	| last_name	| postcode	| pool_number	|
	| 045200077		| LNAME403	| CH1 2AN	| 452300076		|
	
@Regression @NewSchemaConverted
Scenario Outline: English 1st Party Underage with Back Check
	Given I am on "Public" "test"

	Given a bureau owned pool is created with jurors
		| court |juror_number  | pool_number	| att_date_weeks_in_future	| owner |
		| 452   |<juror_number>| <pool_number>	| 5				            | 400	|
		
	And juror "<juror_number>" has "LAST_NAME" as "<last_name>" new schema
	And juror "<juror_number>" has "POSTCODE" as "<postcode>" new schema
	
	Then I see "Reply to a jury summons" on the page
	
	And I set the radio button to "I am replying for myself"
	And I press the "Continue" button
	Then I see "Your juror details" on the page
	
	When I set "9-digit juror number" to "<juror_number>"
	When I set "Juror last name" to "<last_name>"
	When I set "Juror postcode" to "<postcode>"
	And I press the "Continue" button
	Then I see "Is the name we have for you correct?" on the page
	When I choose the "Yes" radio button
	
	#Moving past Name Section
	When I press the "Continue" button
	Then I see "Is this your address?" on the page
	When I choose the "Yes" radio button
	
	When I press the "Continue" button
	Then I see "What is your phone number?" on the page
	
	When I set "Main phone" to "02078211818"
	And I press the "Continue" button
	Then I see "What is your email address?" on the page
	
	When I set "Enter your email address" to "<email>"
	And I set "Enter your email address again" to "<email>"
	And I press the "Continue" button
	
	#On DoB Screen
	Then I see "What is your date of birth?" on the page

	#set dob to make them underage
	And I set the date of birth to a Monday "-884" weeks in the future
	
	#Moving past DoB Section
	And I press the "Continue" button
	Then I see "Is your date of birth correct?" on the page

	And on the page I see
		| text	|
		| Confirm your date of birth |
		| You said your date of birth was  |
		| This makes you  |
		| years old. |
		| Is your date of birth correct? |
		
	When I click on the "Back" link
	And I set the date of birth to a Monday "-884" weeks in the future
	And I press the "Continue" button
	
	Then I see "Is your date of birth correct?" on the page
	
	And I choose the "No" radio button
	Then I press the "Continue" button
	
	And I set "Day" to ""
	And I set "Month" to ""
	And I set "Year" to ""
	And I press the "Continue" button
	Then on the page I see 
		| text	|
		| There is a problem|
		| Enter the day you were born |

	And I set the date of birth to a Monday "-884" weeks in the future
	And I press the "Continue" button
	
	And I choose the "Yes" radio button
	Then I press the "Continue" button
	
	Then I see "Check your answers now" on the page
	Then I check the "The information I have given is true to the best of my knowledge" checkbox
	When I press the "Submit" button

	Then I see "You have completed your reply" on the page
	And I see "Your age means you cannot do jury service" on the page
	Then I see "<juror_number>" on the page
	
Examples:
	| juror_number	| last_name			| postcode	| pool_number	|
	| 045200078		| LNAMEONEFOURONE	| CH1 2AN	| 452300077		|