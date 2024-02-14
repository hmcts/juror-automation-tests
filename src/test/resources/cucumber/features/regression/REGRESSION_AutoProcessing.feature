Feature: Regression Test AUTOPROCESSING

@Regression @JDB-3516 @JDB-3747 
Scenario Outline: submit responses which are auto processed
	Given I am on "Public" "test"
	Given the juror numbers have not been processed
		| part_no 			| pool_no 	| owner |
		| <part_no> 		|415170401	| 400 	|
		| <part_no_two> 	|415170401	| 400 	|
		| <part_no_three> 	|415170401	| 400 	|
		| <part_no_four> 	|415170401	| 400 	|
	
	And "<part_no>" has "LNAME" as "<last_name>" 
	And "<part_no>" has "RET_DATE" as "5 mondays time"
	And "<part_no>" has "NEXT_DATE" as "5 mondays time"
	And "<part_no>" has "ZIP" as "<postcode>"
	
	#Auto Processed 1st ST
	
	Then I see "Reply to a jury summons" on the page
	
	And I set the radio button to "I am replying for myself"
	And I press the "Continue" button
	And I set "9-digit juror number" to "<part_no>"
	And I set "Juror last name" to "<last_name>"
	And I set "Juror postcode" to "<postcode>"
	And I press the "Continue" button
	Then on the page I see
		| text	|
		| Your details |
		| Is the name we have for you correct?	|

	And I do not see any links on the page that open to a new page without an alt text
	And I set the radio button to "Yes"
	And I press the "Continue" button
	Then on the page I see
		| text	|
		| Is this your address? |
	And I do not see any links on the page that open to a new page without an alt text
	And I set the radio button to "Yes"
	When I press the "Continue" button
	
	Then on the page I see
		| text	|
		|Your details|
		|What is your phone number?|
		|Please provide a UK phone number that we can use to reach you between 9am and 5pm, Monday to Friday.|
		|Main phone|
		|Another phone (optional)|

	#JDB-3351

	When I set "Main phone" to "02078211818"
	And I press the "Continue" button
	And I do not see any links on the page that open to a new page without an alt text
	
	Then on the page I see
		| text	|
		| Your details |
		| What is your email address? |
		| Enter your email address |
		| Enter your email address again |
	
	When I set "Enter your email address" to "test@gmail.com"
	When I set "Enter your email address again" to "test@gmail.com"
	And I press the "Continue" button
	And I do not see any links on the page that open to a new page without an alt text
	
	#JDB-3350

	Then on the page I see
		| text	|
		| Your details	|
		| What is your date of birth?	|
		| For example, 15 03 1982 |
		| Help with date of birth |
	
	When I set "Day" to "01"
	And I set "Month" to "01"
	And I set "Year" to "1990"
	And I press the "Continue" button
	And I do not see any links on the page that open to a new page without an alt text
	
	#Qualify for jury service JDB-3372
	
	Then I see "Confirm you're eligible for jury service" on the page
	When I press the "Continue" button
	
	#JDB-3373
	
	Then I see "Since you turned 13, has your main address been in the UK, Channel Islands or Isle of Man for any period of at least 5 years?" on the page
	And I do not see any links on the page that open to a new page without an alt text
	
	#Residency JDB-3378
	
	When I see "Eligibility" on the page
	And I set the radio button to "Yes"
	And I press the "Continue" button
	
	#CJS no
	
	Then I see "Have you worked in the criminal justice system in the last 5 years?" on the page
	And I do not see any links on the page that open to a new page without an alt text
	When I set the radio button to "No"
	And I press the "Continue" button
	
	#JDB-3371
	
	Then I see "Are you currently on bail for a criminal offence?" on the page
	And I do not see any links on the page that open to a new page without an alt text
	
	#Bail JDB-3377
	
	When I see "Eligibility" on the page
	And I set the radio button to "No"
	And I press the "Continue" button
	
	#JDB-3370
	
	Then I see "Have you been found guilty of a criminal offence?" on the page
	And I do not see any links on the page that open to a new page without an alt text
	
	#Convictions JDB-3376
	
	When I see "Eligibility" on the page
	When I set the radio button to "No"
	And I press the "Continue" button
	
	#Mental Health Sectioned JDB-3363 JDB-3353
	
	Then I see "Are you being detained, looked after or treated under the Mental Health Act?" on the page
	And I do not see any links on the page that open to a new page without an alt text
	When I see "Eligibility" on the page
	And I set the radio button to "No"
	And I press the "Continue" button
	
	#Mental Health Capacity JDB-3364
	
	Then I see "Has it been decided that you 'lack mental capacity'?" on the page
	And I do not see any links on the page that open to a new page without an alt text
	When I see "Eligibility" on the page
	And I set the radio button to "No"
	And I press the "Continue" button
	
	#I can attend
	
	Then I see "Check your start date" on the page
	And I do not see any links on the page that open to a new page without an alt text
	And I see "Yes, I can start on" on the page
	And I set the radio button to "Yes, I can start on"
	And  I press the "Continue" button	
	
	#RA no
	
	Then I see "Will you need help when you're at the court?" on the page
	When I set the radio button to "No"
	And I press the "Continue" button
	And I do not see any links on the page that open to a new page without an alt text
	When I check the "The information I have given is true to the best of my knowledge" checkbox
	
	#Enable auto processing
		
	Given auto straight through processing has been enabled
	
	And I press the "Submit" button
	
	#Disable auto processing
	
	Given auto straight through processing has been disabled
	And I do not see any links on the page that open to a new page without an alt text
	
	#Auto Processed Deceased
	
	Given I am on "Public" "test"
	
	And "<part_no_two>" has "LNAME" as "<last_name>" 
	And "<part_no_two>" has "RET_DATE" as "5 mondays time"
	And "<part_no_two>" has "NEXT_DATE" as "5 mondays time"
	And "<part_no_two>" has "ZIP" as "<postcode>"
	
	And I set the radio button to "I am replying for someone else"
	And I press the "Continue" button
	And I do not see any links on the page that open to a new page without an alt text
	When I set "9-digit juror number" to "<part_no_two>"
	When I set "Juror last name" to "<last_name>"
	When I set "Juror postcode" to "<postcode>"
	And I press the "Continue" button

	When I set "First name" to "FirstNamea"
	And I set "Last name" to "LastNameb"
	And I do not see any links on the page that open to a new page without an alt text
	When I press the "Continue" button

	And I set "How do you know the person you're replying for?" to "Friend"

	When I press the "Continue" button
	And I do not see any links on the page that open to a new page without an alt text
	And I check the "By phone (UK Numbers only)" checkbox
	And I set "Main phone" to "02078211818"
	And I check the "By email" checkbox
	When I set "Enter your email address" to "<email>"
	When I set "Enter your email address again" to "<email>"
	
	And I press the "Continue" button
	And I do not see any links on the page that open to a new page without an alt text
	When I set the radio button to "The person has died"
	
	And I press the "Continue" button
	And I see "steps/confirm-information/tp" in the URL
	And I do not see any links on the page that open to a new page without an alt text
	Then I check the "The answers I have given for the person I'm replying for are true as far as I know." checkbox
	
	#Enable auto processing
		
	Given auto straight through processing has been enabled
	
	And I press the "Submit" button
	And I do not see any links on the page that open to a new page without an alt text
	
	#Disable auto processing
	
	Given auto straight through processing has been disabled
	
	#Auto Processed Underage
	
	Given I am on "Public" "test"
		
	And "<part_no_three>" has "LNAME" as "<last_name>" 
	And "<part_no_three>" has "RET_DATE" as "5 mondays time"
	And "<part_no_three>" has "NEXT_DATE" as "5 mondays time"
	And "<part_no_three>" has "ZIP" as "<postcode>"
	
	And I set the radio button to "I am replying for myself"
	And I press the "Continue" button
	And I do not see any links on the page that open to a new page without an alt text
	When I set "9-digit juror number" to "<part_no_three>"
	When I set "Juror last name" to "<last_name>"
	When I set "Juror postcode" to "<postcode>"
	And I press the "Continue" button
	
	And I set the radio button to "Yes"
	And I press the "Continue" button
	
	And I set the radio button to "Yes"
	And I press the "Continue" button
	
	When I set "Main phone" to "02078211818"
	And I press the "Continue" button
	Then I see "What is your email address?" on the page
	
	When I set "Enter your email address" to "email@outlook.com"
	And I set "Enter your email address again" to "email@outlook.com"
	And I press the "Continue" button
	And I do not see any links on the page that open to a new page without an alt text
	
	#On DoB Screen, underage
	
	When I set "Day" to "27"
	And I set "Month" to "04"
	And I set "Year" to "2006"
	
	#Moving past DoB Section
	
	And I press the "Continue" button
	
	And I set the radio button to "Yes"
	And I press the "Continue" button
	
	And I do not see any links on the page that open to a new page without an alt text
	
	Then I check the "The information I have given is true to the best of my knowledge" checkbox
	
	#Enable auto processing
		
	Given auto straight through processing has been enabled
	
	And I press the "Submit" button
	
	#Disable auto processing
	
	Given auto straight through processing has been disabled

	#Auto Processing overage	
		
	Given I am on "Public" "test"
		
	And "<part_no_four>" has "LNAME" as "<last_name>" 
	And "<part_no_four>" has "RET_DATE" as "5 mondays time"
	And "<part_no_four>" has "NEXT_DATE" as "5 mondays time"
	And "<part_no_four>" has "ZIP" as "<postcode>"
	
	And I set the radio button to "I am replying for myself"
	And I press the "Continue" button
	
	When I set "9-digit juror number" to "<part_no_four>"
	When I set "Juror last name" to "<last_name>"
	When I set "Juror postcode" to "<postcode>"
	And I press the "Continue" button
	
	And I see "Is the name we have for you correct?" on the page
	And I set the radio button to "Yes"
	When I press the "Continue" button
	
	And I see "Is this your address?" on the page
	And I set the radio button to "Yes"
	When I press the "Continue" button
	
	When I set "Main phone" to "02078211818"
	And I press the "Continue" button
	Then I see "What is your email address?" on the page
	
	When I set "Enter your email address" to "email@outlook.com"
	And I set "Enter your email address again" to "email@outlook.com"
	And I press the "Continue" button
	
	#On DoB Screen
	
	When I set "Day" to "27"
	And I set "Month" to "04"
	And I set "Year" to "1900"
	
	#Moving past DoB Section
	
	And I press the "Continue" button

	Then I set the radio button to "Yes"
	
	And I press the "Continue" button
	
	Then I check the "The information I have given is true to the best of my knowledge" checkbox
	
	#Enable auto processing
		
	Given auto straight through processing has been enabled
	
	And I press the "Submit" button
	
	#Disable auto processing
	
	Given auto straight through processing has been disabled

	Given I am on "Bureau" "test"
	And I log in
	
	When I click on the "Search" link
	And I set "Juror's pool number" to "<pool_no>"
	And I press the "Search" button

	Then I see "COMPLETED" in the same row as "<part_no>"
	And I see "AUTO" in the same row as "<part_no>"
	Then I see "COMPLETED" in the same row as "<part_no_two>"
	And I see "AUTO" in the same row as "<part_no_two>"
	Then I see "COMPLETED" in the same row as "<part_no_three>"
	And I see "AUTO" in the same row as "<part_no_three>"
	Then I see "COMPLETED" in the same row as "<part_no_four>"
	And I see "AUTO" in the same row as "<part_no_four>"
	
	Then on "JUROR" . "POOL" I see "RESPONDED" is "Y" where "part_no" is "<part_no>"
	Then on "JUROR" . "POOL" I see "USER_EDTQ" is "AUTO" where "part_no" is "<part_no>"
	
	#JDB-3453
	
	Then on "JUROR" . "POOL" I see "WELSH" is null where "part_no" is "<part_no>" and "owner" is "400"
	Then on "JUROR" . "POOL" I see "RESPONDED" is "Y" where "part_no" is "<part_no_two>"
	Then on "JUROR" . "POOL" I see "USER_EDTQ" is "AUTO" where "part_no" is "<part_no_two>"
	
	#JDB-3453
	
	Then on "JUROR" . "POOL" I see "WELSH" is null where "part_no" is "<part_no_two>" and "owner" is "400"
	Then on "JUROR" . "POOL" I see "RESPONDED" is "Y" where "part_no" is "<part_no_three>"
	Then on "JUROR" . "POOL" I see "USER_EDTQ" is "AUTO" where "part_no" is "<part_no_three>"
	
	#JDB-3453
	
	Then on "JUROR" . "POOL" I see "WELSH" is null where "part_no" is "<part_no_three>" and "owner" is "400"
	Then on "JUROR" . "POOL" I see "RESPONDED" is "Y" where "part_no" is "<part_no_four>"
	Then on "JUROR" . "POOL" I see "USER_EDTQ" is "AUTO" where "part_no" is "<part_no_four>"
	
	#JDB-3453
	
	Then on "JUROR" . "POOL" I see "WELSH" is null where "part_no" is "<part_no_four>" and "owner" is "400"
	
	# finish test with auto processing enabled
	
	Given auto straight through processing has been enabled
	
Examples:
	|part_no		|part_no_two	|part_no_three	|part_no_four	|pool_no 	|last_name 	|postcode	|email		|
	|641500607		|641500327		|641500339		|641500376 		|415170401	|LNAME 		|CH1 2AN	|e@mail.com	|

@Regression @JDB-3679 
Scenario Outline: Check that when name is changed, the response is NOT auto processed
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
	And I set "9-digit juror number" to "<part_no>"
	And I set "Juror last name" to "<last_name>"
	And I set "Juror postcode" to "<postcode>"
	And I press the "Continue" button
	Then I see "Is the name we have for you correct?" on the page
		
	And I set the radio button to "No"
	And I press the "Continue" button
	And I set "Title" to "Mrs"
	And I set "First name" to "FirstNameChanged"
	And I set "Last name" to "LastNameChanged"
	And I press the "Continue" button
	Then I see "Is this your address?" on the page
	And I set the radio button to "Yes"

	When I press the "Continue" button
	Then on the page I see
		| text	|
		|Your details|
		|What is your phone number?|
		|Please provide a UK phone number that we can use to reach you between 9am and 5pm, Monday to Friday.|
		|Main phone|
		|Another phone (optional)|

	When I set "Main phone" to "02078211818"
	And I press the "Continue" button

	Then on the page I see
		| text	|
		| Your details |
		| What is your email address? |
		| Enter your email address |
		| Enter your email address again |

	When I set "Enter your email address" to "email@outlook.com"
	When I set "Enter your email address again" to "email@outlook.com"
	And I press the "Continue" button

	Then on the page I see
		| text	|
		| Your details	|
		| What is your date of birth?	|
		| For example, 15 03 1982 |
		| Help with date of birth |
	
	When I set "Day" to "01"
	And I set "Month" to "01"
	And I set "Year" to "1990"
	And I press the "Continue" button

	#Qualify for jury service
	
	Then I see "Confirm you're eligible for jury service" on the page
	When I press the "Continue" button
	
	#Residency
	
	Then I see "Since you turned 13, has your main address been in the UK, Channel Islands or Isle of Man for any period of at least 5 years?" on the page
	When I see "Eligibility" on the page
	And I set the radio button to "Yes"
	And I press the "Continue" button
	
	#CJS no
	
	Then I see "Have you worked in the criminal justice system in the last 5 years?" on the page
	When I set the radio button to "No"
	And I press the "Continue" button
	
	#Bail
	
	Then I see "Are you currently on bail for a criminal offence?" on the page
	When I see "Eligibility" on the page
	And I set the radio button to "No"
	And I press the "Continue" button
	
	#Convictions
	
	Then I see "Have you been found guilty of a criminal offence?" on the page
	When I see "Eligibility" on the page
	When I set the radio button to "No"
	And I press the "Continue" button
	
	#Mental Health Sectioned
	
	Then I see "Are you being detained, looked after or treated under the Mental Health Act?" on the page
	When I see "Eligibility" on the page
	And I set the radio button to "No"
	And I press the "Continue" button
	
	#Mental Health Capacity
	
	Then I see "Has it been decided that you 'lack mental capacity'?" on the page
	When I see "Eligibility" on the page
	And I set the radio button to "No"
	And I press the "Continue" button
	
	#I can attend
	
	Then I see "Check your start date" on the page
	And I see "Yes, I can start on" on the page
	And I set the radio button to "Yes, I can start on"
	And  I press the "Continue" button
	
	#RA no
	
	Then I see "Will you need help when you're at the court?" on the page
	When I set the radio button to "No"
	And I press the "Continue" button
	
	#Check Your Answers
	
	Then I see "Check your answers now" on the page
	When I check the "The information I have given is true to the best of my knowledge" checkbox
	And I press the "Submit" button
	Then I see "We have sent you an email to say you have replied to your jury summons." on the page
	
	#Bureau
	
	Given I am on "Bureau" "juror-test02"
	When I log in
	And I click on the "Search" link
	And I set "Juror number" to "<part_no>"
	And I press the "Search" button
	Then I see "<part_no>" in the same row as "TO DO"
	
	#check DB
	
	Then on "JUROR_DIGITAL" . "JUROR_RESPONSE" I see "STAFF_LOGIN" is null where "JUROR_NUMBER" is "<part_no>"
	Then on "JUROR_DIGITAL" . "JUROR_RESPONSE" I see "STAFF_ASSIGNMENT_DATE" is null where "JUROR_NUMBER" is "<part_no>"
	
Examples:
	|part_no	|last_name	|postcode	| email 			| pool_no	|
	|641500878	|DOE		|SW1H 9AJ	|email@outlook.com	|415170401	|
	
@Regression @JDB-3679 
Scenario Outline: Check that when address is changed, the response is NOT auto processed
	Given I am on "Public" "juror-test02"
	Given the juror numbers have not been processed
		| part_no 	| pool_no 	| owner |
		| <part_no> |<pool_no>	| 400 	|
		
	And "<part_no>" has "LNAME" as "<last_name>" 
	And "<part_no>" has "RET_DATE" as "5 mondays time"
	And "<part_no>" has "NEXT_DATE" as "5 mondays time"
	And "<part_no>" has "ADDRESS" as "1 ORIGINAL LANE"
	And "<part_no>" has "ZIP" as "<postcode>"
	
	Then I see "Reply to a jury summons" on the page
	
	And I set the radio button to "I am replying for myself"
	And I press the "Continue" button
	And I set "9-digit juror number" to "<part_no>"
	And I set "Juror last name" to "<last_name>"
	And I set "Juror postcode" to "<postcode>"
	And I press the "Continue" button
	Then I see "Is the name we have for you correct?" on the page
	And I set the radio button to "Yes"
		
	When I press the "Continue" button
	Then I see "Is this your address?" on the page

	And I set the radio button to "No"
	When I press the "Continue" button
	
	And I set "Address line 1" to "123 CHANGED ADDRESS"
	And I press the "Continue" button
	Then on the page I see
		| text	|
		|Your details|
		|What is your phone number?|
		|Please provide a UK phone number that we can use to reach you between 9am and 5pm, Monday to Friday.|
		|Main phone|
		|Another phone (optional)|

	When I set "Main phone" to "02078211818"
	And I press the "Continue" button

	Then on the page I see
		| text	|
		| Your details |
		| What is your email address? |
		| Enter your email address |
		| Enter your email address again |

	When I set "Enter your email address" to "email@outlook.com"
	When I set "Enter your email address again" to "email@outlook.com"
	And I press the "Continue" button

	Then on the page I see
		| text	|
		| Your details	|
		| What is your date of birth?	|
		| For example, 15 03 1982 |
		| Help with date of birth |
	
	When I set "Day" to "01"
	And I set "Month" to "01"
	And I set "Year" to "1990"
	And I press the "Continue" button

	#Qualify for jury service
	
	Then I see "Confirm you're eligible for jury service" on the page
	When I press the "Continue" button
	
	#Residency
	
	Then I see "Since you turned 13, has your main address been in the UK, Channel Islands or Isle of Man for any period of at least 5 years?" on the page
	When I see "Eligibility" on the page
	And I set the radio button to "Yes"
	And I press the "Continue" button
	
	#CJS no
	
	Then I see "Have you worked in the criminal justice system in the last 5 years?" on the page
	When I set the radio button to "No"
	And I press the "Continue" button
	
	#Bail
	
	Then I see "Are you currently on bail for a criminal offence?" on the page
	When I see "Eligibility" on the page
	And I set the radio button to "No"
	And I press the "Continue" button
	
	#Convictions
	
	Then I see "Have you been found guilty of a criminal offence?" on the page
	When I see "Eligibility" on the page
	When I set the radio button to "No"
	And I press the "Continue" button
	
	#Mental Health Sectioned
	
	Then I see "Are you being detained, looked after or treated under the Mental Health Act?" on the page
	When I see "Eligibility" on the page
	And I set the radio button to "No"
	And I press the "Continue" button
	
	#Mental Health Capacity
	
	Then I see "Has it been decided that you 'lack mental capacity'?" on the page
	When I see "Eligibility" on the page
	And I set the radio button to "No"
	And I press the "Continue" button
	
	#I can attend
	
	Then I see "Check your start date" on the page
	And I see "Yes, I can start on" on the page
	And I set the radio button to "Yes, I can start on"
	And  I press the "Continue" button
	
	#RA no
	
	Then I see "Will you need help when you're at the court?" on the page
	When I set the radio button to "No"
	And I press the "Continue" button
	
	#Check Your Answers
	
	Then I see "Check your answers now" on the page
	When I check the "The information I have given is true to the best of my knowledge" checkbox
	And I press the "Submit" button
	Then I see "We have sent you an email to say you have replied to your jury summons." on the page
	
	#Bureau
	
	Given I am on "Bureau" "juror-test02"
	When I log in
	And I click on the "Search" link
	And I set "Juror number" to "<part_no>"
	And I press the "Search" button
	Then I see "<part_no>" in the same row as "TO DO"

	#check DB
	
	Then on "JUROR_DIGITAL" . "JUROR_RESPONSE" I see "STAFF_LOGIN" is null where "JUROR_NUMBER" is "<part_no>"
	Then on "JUROR_DIGITAL" . "JUROR_RESPONSE" I see "STAFF_ASSIGNMENT_DATE" is null where "JUROR_NUMBER" is "<part_no>"
	
Examples:
	|part_no	|last_name	|postcode	|email 				|pool_no	|
	|641500886	|DOE		|SW1H 9AJ	|email@outlook.com	|415170401	|

@Regression @JDB-4084 
Scenario Outline: Check that when Address2 is changed from (null), the response is not auto processed
	Given I am on "Public" "juror-test02"
	Given the juror numbers have not been processed
		| part_no 	| pool_no 	| owner |
		| <part_no> |<pool_no>	| 400 	|
		
	And "<part_no>" has "LNAME" as "<last_name>" 
	And "<part_no>" has "RET_DATE" as "5 mondays time"
	And "<part_no>" has "NEXT_DATE" as "5 mondays time"
	And "<part_no>" has "ZIP" as "<postcode>"
	And "<part_no>" has "Address2" as ""
	
	Then I see "Reply to a jury summons" on the page
	
	And I set the radio button to "I am replying for myself"
	And I press the "Continue" button
	And I set "9-digit juror number" to "<part_no>"
	And I set "Juror last name" to "<last_name>"
	And I set "Juror postcode" to "<postcode>"
	And I press the "Continue" button
	Then I see "Is the name we have for you correct?" on the page
	And I set the radio button to "Yes"
		
	When I press the "Continue" button
	Then I see "Is this your address?" on the page
	And I set the radio button to "No"
	When I press the "Continue" button
	
	And I set input field with "id" of "addressLineTwo" to "Second Address Line"
	And I press the "Continue" button
	Then on the page I see
		| text	|
		|Your details|
		|What is your phone number?|
		|Please provide a UK phone number that we can use to reach you between 9am and 5pm, Monday to Friday.|
		|Main phone|
		|Another phone (optional)|

	When I set "Main phone" to "02078211818"
	And I press the "Continue" button

	Then on the page I see
		| text	|
		| Your details |
		| What is your email address? |
		| Enter your email address |
		| Enter your email address again |

	When I set "Enter your email address" to "email@outlook.com"
	When I set "Enter your email address again" to "email@outlook.com"
	And I press the "Continue" button

	Then on the page I see
		| text	|
		| Your details	|
		| What is your date of birth?	|
		| For example, 15 03 1982 |
		| Help with date of birth |
	
	When I set "Day" to "01"
	And I set "Month" to "01"
	And I set "Year" to "1990"
	And I press the "Continue" button

	#Qualify for jury service
	
	Then I see "Confirm you're eligible for jury service" on the page
	When I press the "Continue" button
	
	#Residency
	
	Then I see "Since you turned 13, has your main address been in the UK, Channel Islands or Isle of Man for any period of at least 5 years?" on the page
	When I see "Eligibility" on the page
	And I set the radio button to "Yes"
	And I press the "Continue" button
	
	#CJS no
	
	Then I see "Have you worked in the criminal justice system in the last 5 years?" on the page
	When I set the radio button to "No"
	And I press the "Continue" button
	
	#Bail
	
	Then I see "Are you currently on bail for a criminal offence?" on the page
	When I see "Eligibility" on the page
	And I set the radio button to "No"
	And I press the "Continue" button
	
	#Convictions
	
	Then I see "Have you been found guilty of a criminal offence?" on the page
	When I see "Eligibility" on the page
	When I set the radio button to "No"
	And I press the "Continue" button
	
	#Mental Health Sectioned
	
	Then I see "Are you being detained, looked after or treated under the Mental Health Act?" on the page
	When I see "Eligibility" on the page
	And I set the radio button to "No"
	And I press the "Continue" button
	
	#Mental Health Capacity
	
	Then I see "Has it been decided that you 'lack mental capacity'?" on the page
	When I see "Eligibility" on the page
	And I set the radio button to "No"
	And I press the "Continue" button
	
	#I can attend
	
	Then I see "Check your start date" on the page
	And I see "Yes, I can start on" on the page
	And I set the radio button to "Yes, I can start on"
	And  I press the "Continue" button
	
	#RA no
	
	Then I see "Will you need help when you're at the court?" on the page
	When I set the radio button to "No"
	And I press the "Continue" button
	
	#Check Your Answers
	
	Then I see "Check your answers now" on the page
	When I check the "The information I have given is true to the best of my knowledge" checkbox
	And I press the "Submit" button
	Then I see "We have sent you an email to say you have replied to your jury summons." on the page
	
	#Bureau
	
	Given I am on "Bureau" "juror-test01"
	When I log in
	And I click on the "Search" link
	And I set "Juror number" to "<part_no>"
	And I press the "Search" button
	And I see "<part_no>" in the same row as "TO DO"
	And I click on "<part_no>" in the same row as "<part_no>"
	Then I see "Juror details" on the page
	And I see "Summoned" on the page
	And I see "Second Address Line" on the page

	#check DB
	
	Then on "JUROR_DIGITAL" . "JUROR_RESPONSE" I see "STAFF_LOGIN" is null where "JUROR_NUMBER" is "<part_no>"
	Then on "JUROR_DIGITAL" . "JUROR_RESPONSE" I see "STAFF_ASSIGNMENT_DATE" is null where "JUROR_NUMBER" is "<part_no>"
	
Examples:
	|part_no	|last_name		|postcode	|email 				|pool_no	|
	|645700095	|LNAMENINEFIVE	|SA1 4PF	|email@outlook.com	|457170401	|
	
@Regression @JDB-4084 
Scenario Outline: Check that when Address3 is changed from (null), the response is not auto processed
	Given I am on "Public" "juror-test02"
	Given the juror numbers have not been processed
		| part_no 	| pool_no 	| owner |
		| <part_no> |<pool_no>	| 400 	|
		
	And "<part_no>" has "LNAME" as "<last_name>" 
	And "<part_no>" has "RET_DATE" as "5 mondays time"
	And "<part_no>" has "NEXT_DATE" as "5 mondays time"
	And "<part_no>" has "ZIP" as "<postcode>"
	And "<part_no>" has "Address3" as ""
	
	Then I see "Reply to a jury summons" on the page
	
	
	And I set the radio button to "I am replying for myself"
	And I press the "Continue" button
	And I set "9-digit juror number" to "<part_no>"
	And I set "Juror last name" to "<last_name>"
	And I set "Juror postcode" to "<postcode>"
	And I press the "Continue" button
	Then I see "Is the name we have for you correct?" on the page
	And I set the radio button to "Yes"
		
	When I press the "Continue" button
	Then I see "Is this your address?" on the page
	And I set the radio button to "No"
	When I press the "Continue" button
	
	And I set input field with "id" of "addressLineThree" to "Third Address Line"
	And I press the "Continue" button
	Then on the page I see
		| text	|
		|Your details|
		|What is your phone number?|
		|Please provide a UK phone number that we can use to reach you between 9am and 5pm, Monday to Friday.|
		|Main phone|
		|Another phone (optional)|

	When I set "Main phone" to "02078211818"
	And I press the "Continue" button

	Then on the page I see
		| text	|
		| Your details |
		| What is your email address? |
		| Enter your email address |
		| Enter your email address again |

	When I set "Enter your email address" to "email@outlook.com"
	When I set "Enter your email address again" to "email@outlook.com"
	And I press the "Continue" button

	Then on the page I see
		| text	|
		| Your details	|
		| What is your date of birth?	|
		| For example, 15 03 1982 |
		| Help with date of birth |
	
	When I set "Day" to "01"
	And I set "Month" to "01"
	And I set "Year" to "1990"
	And I press the "Continue" button

	#Qualify for jury service
	
	Then I see "Confirm you're eligible for jury service" on the page
	When I press the "Continue" button
	
	#Residency
	
	Then I see "Since you turned 13, has your main address been in the UK, Channel Islands or Isle of Man for any period of at least 5 years?" on the page
	When I see "Eligibility" on the page
	And I set the radio button to "Yes"
	And I press the "Continue" button
	
	#CJS no
	
	Then I see "Have you worked in the criminal justice system in the last 5 years?" on the page
	When I set the radio button to "No"
	And I press the "Continue" button
	
	#Bail
	
	Then I see "Are you currently on bail for a criminal offence?" on the page
	When I see "Eligibility" on the page
	And I set the radio button to "No"
	And I press the "Continue" button
	
	#Convictions
	
	Then I see "Have you been found guilty of a criminal offence?" on the page
	When I see "Eligibility" on the page
	When I set the radio button to "No"
	And I press the "Continue" button
	
	#Mental Health Sectioned
	
	Then I see "Are you being detained, looked after or treated under the Mental Health Act?" on the page
	When I see "Eligibility" on the page
	And I set the radio button to "No"
	And I press the "Continue" button
	
	#Mental Health Capacity
	
	Then I see "Has it been decided that you 'lack mental capacity'?" on the page
	When I see "Eligibility" on the page
	And I set the radio button to "No"
	And I press the "Continue" button
	
	#I can attend
	
	Then I see "Check your start date" on the page
	And I see "Yes, I can start on" on the page
	And I set the radio button to "Yes, I can start on"
	And  I press the "Continue" button
	
	#RA no
	
	Then I see "Will you need help when you're at the court?" on the page
	When I set the radio button to "No"
	And I press the "Continue" button
	
	#Check Your Answers
	
	Then I see "Check your answers now" on the page
	When I check the "The information I have given is true to the best of my knowledge" checkbox
	And I press the "Submit" button
	Then I see "We have sent you an email to say you have replied to your jury summons." on the page
	
	#Bureau
	
	Given I am on "Bureau" "juror-test02"
	When I log in
	And I click on the "Search" link
	And I set "Juror number" to "<part_no>"
	And I press the "Search" button
	And I see "<part_no>" in the same row as "TO DO"
	And I click on "<part_no>" in the same row as "<part_no>"
	Then I see "Juror details" on the page
	And I see "Summoned" on the page
	And I see "Third Address Line" on the page

	#check DB
	
	Then on "JUROR_DIGITAL" . "JUROR_RESPONSE" I see "STAFF_LOGIN" is null where "JUROR_NUMBER" is "<part_no>"
	Then on "JUROR_DIGITAL" . "JUROR_RESPONSE" I see "STAFF_ASSIGNMENT_DATE" is null where "JUROR_NUMBER" is "<part_no>"
	
Examples:
	|part_no	|last_name			|postcode	|email 				|pool_no	|
	|644200430	|LNAMEFOURTHREEZERO	|NN1 3HQ	|email@outlook.com	|442170401	|
	
@Regression @JDB-4084 
Scenario Outline: Check that when Address4 is changed from (null), the response is not auto processed
	Given I am on "Public" "juror-test02"
	Given the juror numbers have not been processed
		| part_no 	| pool_no 	| owner |
		| <part_no> |<pool_no>	| 400 	|
		
	And "<part_no>" has "LNAME" as "<last_name>" 
	And "<part_no>" has "RET_DATE" as "5 mondays time"
	And "<part_no>" has "NEXT_DATE" as "5 mondays time"
	And "<part_no>" has "ZIP" as "<postcode>"
	And "<part_no>" has "Address4" as ""
	
	Then I see "Reply to a jury summons" on the page
	
	And I set the radio button to "I am replying for myself"
	And I press the "Continue" button
	And I set "9-digit juror number" to "<part_no>"
	And I set "Juror last name" to "<last_name>"
	And I set "Juror postcode" to "<postcode>"
	And I press the "Continue" button
	Then I see "Is the name we have for you correct?" on the page
	And I set the radio button to "Yes"

	When I press the "Continue" button
	Then I see "Is this your address?" on the page
	And I set the radio button to "No"
	And I press the "Continue" button
	
	And I set "Town or city" to "NewTown"
	And I press the "Continue" button
	Then on the page I see
		| text	|
		|Your details|
		|What is your phone number?|
		|Please provide a UK phone number that we can use to reach you between 9am and 5pm, Monday to Friday.|
		|Main phone|
		|Another phone (optional)|

	When I set "Main phone" to "02078211818"
	And I press the "Continue" button

	Then on the page I see
		| text	|
		| Your details |
		| What is your email address? |
		| Enter your email address |
		| Enter your email address again |

	When I set "Enter your email address" to "email@outlook.com"
	When I set "Enter your email address again" to "email@outlook.com"
	And I press the "Continue" button

	Then on the page I see
		| text	|
		| Your details	|
		| What is your date of birth?	|
		| For example, 15 03 1982 |
		| Help with date of birth |
	
	When I set "Day" to "01"
	And I set "Month" to "01"
	And I set "Year" to "1990"
	And I press the "Continue" button

	#Qualify for jury service
	
	Then I see "Confirm you're eligible for jury service" on the page
	When I press the "Continue" button
	
	#Residency
	
	Then I see "Since you turned 13, has your main address been in the UK, Channel Islands or Isle of Man for any period of at least 5 years?" on the page
	When I see "Eligibility" on the page
	And I set the radio button to "Yes"
	And I press the "Continue" button
	
	#CJS no
	
	Then I see "Have you worked in the criminal justice system in the last 5 years?" on the page
	When I set the radio button to "No"
	And I press the "Continue" button
	
	#Bail
	
	Then I see "Are you currently on bail for a criminal offence?" on the page
	When I see "Eligibility" on the page
	And I set the radio button to "No"
	And I press the "Continue" button
	
	#Convictions
	
	Then I see "Have you been found guilty of a criminal offence?" on the page
	When I see "Eligibility" on the page
	When I set the radio button to "No"
	And I press the "Continue" button
	
	#Mental Health Sectioned
	
	Then I see "Are you being detained, looked after or treated under the Mental Health Act?" on the page
	When I see "Eligibility" on the page
	And I set the radio button to "No"
	And I press the "Continue" button
	
	#Mental Health Capacity
	
	Then I see "Has it been decided that you 'lack mental capacity'?" on the page
	When I see "Eligibility" on the page
	And I set the radio button to "No"
	And I press the "Continue" button
	
	#I can attend
	
	Then I see "Check your start date" on the page
	And I see "Yes, I can start on" on the page
	And I set the radio button to "Yes, I can start on"
	And  I press the "Continue" button
	
	#RA no
	
	Then I see "Will you need help when you're at the court?" on the page
	When I set the radio button to "No"
	And I press the "Continue" button
	
	#Check Your Answers
	
	Then I see "Check your answers now" on the page
	When I check the "The information I have given is true to the best of my knowledge" checkbox
	And I press the "Submit" button
	
	Then I see "We have sent you an email to say you have replied to your jury summons." on the page
	
	#Bureau
	
	Given I am on "Bureau" "juror-test02"
	When I log in
	And I click on the "Search" link
	And I set "Juror number" to "<part_no>"
	And I press the "Search" button
	And I see "<part_no>" in the same row as "TO DO"
	And I click on "<part_no>" in the same row as "<part_no>"
	Then I see "Juror details" on the page
	And I see "Summoned" on the page
	And I see "NewTown" on the page

	#check DB
	
	Then on "JUROR_DIGITAL" . "JUROR_RESPONSE" I see "STAFF_LOGIN" is null where "JUROR_NUMBER" is "<part_no>"
	Then on "JUROR_DIGITAL" . "JUROR_RESPONSE" I see "STAFF_ASSIGNMENT_DATE" is null where "JUROR_NUMBER" is "<part_no>"
	
Examples:
	|part_no	|last_name			|postcode	|email 				|pool_no	|
	|645700118	|LNAMEONEONEEIGHT	|SA1 4PF	|email@outlook.com	|457170401	|
	
@Regression @JDB-4084 
Scenario Outline: Check that when Address5 is changed from (null), the response is not auto processed
	Given I am on "Public" "juror-test02"
	Given the juror numbers have not been processed
		| part_no 	| pool_no 	| owner |
		| <part_no> |<pool_no>	| 400 	|
		
	And "<part_no>" has "LNAME" as "<last_name>" 
	And "<part_no>" has "RET_DATE" as "5 mondays time"
	And "<part_no>" has "NEXT_DATE" as "5 mondays time"
	And "<part_no>" has "ZIP" as "<postcode>"
	And "<part_no>" has "Address5" as ""
	
	Then I see "Reply to a jury summons" on the page
	
	And I set the radio button to "I am replying for myself"
	And I press the "Continue" button
	And I set "9-digit juror number" to "<part_no>"
	And I set "Juror last name" to "<last_name>"
	And I set "Juror postcode" to "<postcode>"
	And I press the "Continue" button
	Then I see "Is the name we have for you correct?" on the page
	And I set the radio button to "Yes"
		
	When I press the "Continue" button
	Then I see "Is this your address?" on the page
	And I set the radio button to "No"

	And I press the "Continue" button
	And I set "County (optional)" to "NewCounty"
	And I press the "Continue" button
	Then on the page I see
		| text	|
		|Your details|
		|What is your phone number?|
		|Please provide a UK phone number that we can use to reach you between 9am and 5pm, Monday to Friday.|
		|Main phone|
		|Another phone (optional)|

	When I set "Main phone" to "02078211818"
	And I press the "Continue" button

	Then on the page I see
		| text	|
		| Your details |
		| What is your email address? |
		| Enter your email address |
		| Enter your email address again |

	When I set "Enter your email address" to "email@outlook.com"
	When I set "Enter your email address again" to "email@outlook.com"
	And I press the "Continue" button

	Then on the page I see
		| text	|
		| Your details	|
		| What is your date of birth?	|
		| For example, 15 03 1982 |
		| Help with date of birth |
	
	When I set "Day" to "01"
	And I set "Month" to "01"
	And I set "Year" to "1990"
	And I press the "Continue" button

	#Qualify for jury service
	
	Then I see "Confirm you're eligible for jury service" on the page
	When I press the "Continue" button
	
	#Residency
	
	Then I see "Since you turned 13, has your main address been in the UK, Channel Islands or Isle of Man for any period of at least 5 years?" on the page
	When I see "Eligibility" on the page
	And I set the radio button to "Yes"
	And I press the "Continue" button
	
	#CJS no
	
	Then I see "Have you worked in the criminal justice system in the last 5 years?" on the page
	When I set the radio button to "No"
	And I press the "Continue" button
	
	#Bail
	
	Then I see "Are you currently on bail for a criminal offence?" on the page
	When I see "Eligibility" on the page
	And I set the radio button to "No"
	And I press the "Continue" button
	
	#Convictions
	
	Then I see "Have you been found guilty of a criminal offence?" on the page
	When I see "Eligibility" on the page
	When I set the radio button to "No"
	And I press the "Continue" button
	
	#Mental Health Sectioned
	
	Then I see "Are you being detained, looked after or treated under the Mental Health Act?" on the page
	When I see "Eligibility" on the page
	And I set the radio button to "No"
	And I press the "Continue" button
	
	#Mental Health Capacity
	
	Then I see "Has it been decided that you 'lack mental capacity'?" on the page
	When I see "Eligibility" on the page
	And I set the radio button to "No"
	And I press the "Continue" button
	
	#I can attend
	
	Then I see "Check your start date" on the page
	And I see "Yes, I can start on" on the page
	And I set the radio button to "Yes, I can start on"
	And  I press the "Continue" button
	
	#RA no
	
	Then I see "Will you need help when you're at the court?" on the page
	When I set the radio button to "No"
	And I press the "Continue" button
	
	#Check Your Answers
	
	Then I see "Check your answers now" on the page
	When I check the "The information I have given is true to the best of my knowledge" checkbox
	And I press the "Submit" button
	Then I see "We have sent you an email to say you have replied to your jury summons." on the page
	
	#Bureau
	
	Given I am on "Bureau" "juror-test02"
	When I log in
	And I click on the "Search" link
	And I set "Juror number" to "<part_no>"
	And I press the "Search" button
	And I see "<part_no>" in the same row as "TO DO"
	And I click on "<part_no>" in the same row as "<part_no>"
	Then I see "Juror details" on the page
	And I see "Summoned" on the page
	And I see "NewCounty" on the page

	#check DB
	
	Then on "JUROR_DIGITAL" . "JUROR_RESPONSE" I see "STAFF_LOGIN" is null where "JUROR_NUMBER" is "<part_no>"
	Then on "JUROR_DIGITAL" . "JUROR_RESPONSE" I see "STAFF_ASSIGNMENT_DATE" is null where "JUROR_NUMBER" is "<part_no>"
	
Examples:
	|part_no	|last_name	|postcode	|email 				|pool_no	|
	|644200902	|LNAMENINEZEROTWO	|NN1 3HQ	|email@outlook.com	|442170401	|
	
@Regression @JDB-4084
Scenario Outline: Check that when Address2 is changed from string value, the response is not auto processed
	Given I am on "Public" "juror-test02"
	Given the juror numbers have not been processed
		| part_no 	| pool_no 	| owner |
		| <part_no> |<pool_no>	| 400 	|
		
	And "<part_no>" has "LNAME" as "<last_name>" 
	And "<part_no>" has "RET_DATE" as "5 mondays time"
	And "<part_no>" has "NEXT_DATE" as "5 mondays time"
	And "<part_no>" has "ZIP" as "<postcode>"
	And "<part_no>" has "Address2" as "Second Address Line"
	
	Then I see "Reply to a jury summons" on the page

	And I set the radio button to "I am replying for myself"
	And I press the "Continue" button
	And I set "9-digit juror number" to "<part_no>"
	And I set "Juror last name" to "<last_name>"
	And I set "Juror postcode" to "<postcode>"
	And I press the "Continue" button
	Then I see "Is the name we have for you correct?" on the page
	And I set the radio button to "Yes"
		
	When I press the "Continue" button
	Then I see "Is this your address?" on the page
	And I set the radio button to "No"

	When I press the "Continue" button
	And I set input field with "id" of "addressLineTwo" to "Second Address Line CHANGED"
	And I press the "Continue" button
	Then on the page I see
		| text	|
		|Your details|
		|What is your phone number?|
		|Please provide a UK phone number that we can use to reach you between 9am and 5pm, Monday to Friday.|
		|Main phone|
		|Another phone (optional)|

	When I set "Main phone" to "02078211818"
	And I press the "Continue" button

	Then on the page I see
		| text	|
		| Your details |
		| What is your email address? |
		| Enter your email address |
		| Enter your email address again |

	When I set "Enter your email address" to "email@outlook.com"
	When I set "Enter your email address again" to "email@outlook.com"
	And I press the "Continue" button

	Then on the page I see
		| text	|
		| Your details	|
		| What is your date of birth?	|
		| For example, 15 03 1982 |
		| Help with date of birth |
	
	When I set "Day" to "01"
	And I set "Month" to "01"
	And I set "Year" to "1990"
	And I press the "Continue" button

	#Qualify for jury service
	
	Then I see "Confirm you're eligible for jury service" on the page
	When I press the "Continue" button
	
	#Residency
	
	Then I see "Since you turned 13, has your main address been in the UK, Channel Islands or Isle of Man for any period of at least 5 years?" on the page
	When I see "Eligibility" on the page
	And I set the radio button to "Yes"
	And I press the "Continue" button
	
	#CJS no
	
	Then I see "Have you worked in the criminal justice system in the last 5 years?" on the page
	When I set the radio button to "No"
	And I press the "Continue" button
	
	#Bail
	
	Then I see "Are you currently on bail for a criminal offence?" on the page
	When I see "Eligibility" on the page
	And I set the radio button to "No"
	And I press the "Continue" button
	
	#Convictions
	
	Then I see "Have you been found guilty of a criminal offence?" on the page
	When I see "Eligibility" on the page
	When I set the radio button to "No"
	And I press the "Continue" button
	
	#Mental Health Sectioned
	
	Then I see "Are you being detained, looked after or treated under the Mental Health Act?" on the page
	When I see "Eligibility" on the page
	And I set the radio button to "No"
	And I press the "Continue" button
	
	#Mental Health Capacity
	
	Then I see "Has it been decided that you 'lack mental capacity'?" on the page
	When I see "Eligibility" on the page
	And I set the radio button to "No"
	And I press the "Continue" button
	
	#I can attend
	
	Then I see "Check your start date" on the page
	And I see "Yes, I can start on" on the page
	And I set the radio button to "Yes, I can start on"
	And  I press the "Continue" button
	
	#RA no
	
	Then I see "Will you need help when you're at the court?" on the page
	When I set the radio button to "No"
	And I press the "Continue" button
	
	#Check Your Answers
	
	Then I see "Check your answers now" on the page
	When I check the "The information I have given is true to the best of my knowledge" checkbox
	And I press the "Submit" button
	Then I see "We have sent you an email to say you have replied to your jury summons." on the page
	
	#Bureau
	
	Given I am on "Bureau" "juror-test02"
	When I log in
	And I click on the "Search" link
	And I set "Juror number" to "<part_no>"
	And I press the "Search" button
	And I see "<part_no>" in the same row as "TO DO"
	And I click on "<part_no>" in the same row as "<part_no>"
	Then I see "Juror details" on the page
	And I see "Summoned" on the page
	And I see "Second Address Line CHANGED" on the page

	#check DB
	
	Then on "JUROR_DIGITAL" . "JUROR_RESPONSE" I see "STAFF_LOGIN" is null where "JUROR_NUMBER" is "<part_no>"
	Then on "JUROR_DIGITAL" . "JUROR_RESPONSE" I see "STAFF_ASSIGNMENT_DATE" is null where "JUROR_NUMBER" is "<part_no>"
	
Examples:
	|part_no	|last_name	|postcode	|email 				|pool_no	|
	|645100538	|DOE		|SW1H 9AJ	|email@outlook.com	|451170401	|
	
@Regression
Scenario Outline: Check that when Address3 is changed from string value, the response is not auto processed
	Given I am on "Public" "test"
	Given the juror numbers have not been processed
		| part_no 	| pool_no 	| owner |
		| <part_no> |<pool_no>	| 400 	|
		
	And "<part_no>" has "LNAME" as "<last_name>" 
	And "<part_no>" has "RET_DATE" as "5 mondays time"
	And "<part_no>" has "NEXT_DATE" as "5 mondays time"
	And "<part_no>" has "ZIP" as "<postcode>"
	And "<part_no>" has "Address3" as "Third Address Line"
	
	Then I see "Reply to a jury summons" on the page
	
	And I set the radio button to "I am replying for myself"
	And I press the "Continue" button
	And I set "9-digit juror number" to "<part_no>"
	And I set "Juror last name" to "<last_name>"
	And I set "Juror postcode" to "<postcode>"
	And I press the "Continue" button
	Then I see "Is the name we have for you correct?" on the page
	And I set the radio button to "Yes"
		
	When I press the "Continue" button
	Then I see "Is this your address?" on the page
	And I set the radio button to "No"
	When I press the "Continue" button

	And I set input field with "id" of "addressLineThree" to "Third Address Line CHANGED"
	And I press the "Continue" button
	Then on the page I see
		| text	|
		|Your details|
		|What is your phone number?|
		|Please provide a UK phone number that we can use to reach you between 9am and 5pm, Monday to Friday.|
		|Main phone|
		|Another phone (optional)|

	When I set "Main phone" to "02078211818"
	And I press the "Continue" button

	Then on the page I see
		| text	|
		| Your details |
		| What is your email address? |
		| Enter your email address |
		| Enter your email address again |

	When I set "Enter your email address" to "email@outlook.com"
	When I set "Enter your email address again" to "email@outlook.com"
	And I press the "Continue" button

	Then on the page I see
		| text	|
		| Your details	|
		| What is your date of birth?	|
		| For example, 15 03 1982 |
		| Help with date of birth |
	
	When I set "Day" to "01"
	And I set "Month" to "01"
	And I set "Year" to "1990"
	And I press the "Continue" button

	#Qualify for jury service
	
	Then I see "Confirm you're eligible for jury service" on the page
	When I press the "Continue" button
	
	#Residency
	
	Then I see "Since you turned 13, has your main address been in the UK, Channel Islands or Isle of Man for any period of at least 5 years?" on the page
	When I see "Eligibility" on the page
	And I set the radio button to "Yes"
	And I press the "Continue" button
	
	#CJS no
	
	Then I see "Have you worked in the criminal justice system in the last 5 years?" on the page
	When I set the radio button to "No"
	And I press the "Continue" button
	
	#Bail
	
	Then I see "Are you currently on bail for a criminal offence?" on the page
	When I see "Eligibility" on the page
	And I set the radio button to "No"
	And I press the "Continue" button
	
	#Convictions
	
	Then I see "Have you been found guilty of a criminal offence?" on the page
	When I see "Eligibility" on the page
	When I set the radio button to "No"
	And I press the "Continue" button
	
	#Mental Health Sectioned
	
	Then I see "Are you being detained, looked after or treated under the Mental Health Act?" on the page
	When I see "Eligibility" on the page
	And I set the radio button to "No"
	And I press the "Continue" button
	
	#Mental Health Capacity
	
	Then I see "Has it been decided that you 'lack mental capacity'?" on the page
	When I see "Eligibility" on the page
	And I set the radio button to "No"
	And I press the "Continue" button
	
	#I can attend
	
	Then I see "Check your start date" on the page
	And I see "Yes, I can start on" on the page
	And I set the radio button to "Yes, I can start on"
	And  I press the "Continue" button
	
	#RA no
	
	Then I see "Will you need help when you're at the court?" on the page
	When I set the radio button to "No"
	And I press the "Continue" button
	
	#Check Your Answers
	
	Then I see "Check your answers now" on the page
	When I check the "The information I have given is true to the best of my knowledge" checkbox
	And I press the "Submit" button
	Then I see "We have sent you an email to say you have replied to your jury summons." on the page
	
	#Bureau
	
	Given I am on "Bureau" "test"
	When I log in
	And I click on the "Search" link
	And I set "Juror number" to "<part_no>"
	And I press the "Search" button
	And I see "<part_no>" in the same row as "TO DO"
	And I click on "<part_no>" in the same row as "<part_no>"
	Then I see "Juror details" on the page
	And I see "Summoned" on the page
	And I see "Third Address Line CHANGED" on the page

	#check DB
	
	Then on "JUROR_DIGITAL" . "JUROR_RESPONSE" I see "STAFF_LOGIN" is null where "JUROR_NUMBER" is "<part_no>"
	Then on "JUROR_DIGITAL" . "JUROR_RESPONSE" I see "STAFF_ASSIGNMENT_DATE" is null where "JUROR_NUMBER" is "<part_no>"
	
Examples:
	|part_no	|last_name				|postcode	|email 				|pool_no	|
	|641500953	|LNAMENINEFIVETHREE		|CH1 2AN	|email@outlook.com	|415170402	|
	
@Regression @JDB-4084 
Scenario Outline: Check that when Address4 is changed from string value, the response is not auto processed
	Given I am on "Public" "juror-test02"
	Given the juror numbers have not been processed
		| part_no 	| pool_no 	| owner |
		| <part_no> |<pool_no>	| 400 	|
		
	And "<part_no>" has "LNAME" as "<last_name>" 
	And "<part_no>" has "RET_DATE" as "5 mondays time"
	And "<part_no>" has "NEXT_DATE" as "5 mondays time"
	And "<part_no>" has "ZIP" as "<postcode>"
	And "<part_no>" has "Address4" as "NewTown"
	
	Then I see "Reply to a jury summons" on the page
	
	And I set the radio button to "I am replying for myself"
	And I press the "Continue" button
	And I set "9-digit juror number" to "<part_no>"
	And I set "Juror last name" to "<last_name>"
	And I set "Juror postcode" to "<postcode>"
	And I press the "Continue" button
	Then I see "Is the name we have for you correct?" on the page
	And I set the radio button to "Yes"
		
	When I press the "Continue" button
	Then I see "Is this your address?" on the page
	And I set the radio button to "No"

	When I press the "Continue" button
	And I set "Town or city" to "NewTownCHANGED"
	And I press the "Continue" button
	Then on the page I see
		| text	|
		|Your details|
		|What is your phone number?|
		|Please provide a UK phone number that we can use to reach you between 9am and 5pm, Monday to Friday.|
		|Main phone|
		|Another phone (optional)|

	When I set "Main phone" to "02078211818"
	And I press the "Continue" button

	Then on the page I see
		| text	|
		| Your details |
		| What is your email address? |
		| Enter your email address |
		| Enter your email address again |

	When I set "Enter your email address" to "email@outlook.com"
	When I set "Enter your email address again" to "email@outlook.com"
	And I press the "Continue" button

	Then on the page I see
		| text	|
		| Your details	|
		| What is your date of birth?	|
		| For example, 15 03 1982 |
		| Help with date of birth |
	
	When I set "Day" to "01"
	And I set "Month" to "01"
	And I set "Year" to "1990"
	And I press the "Continue" button

	#Qualify for jury service
	
	Then I see "Confirm you're eligible for jury service" on the page
	When I press the "Continue" button
	
	#Residency
	
	Then I see "Since you turned 13, has your main address been in the UK, Channel Islands or Isle of Man for any period of at least 5 years?" on the page
	When I see "Eligibility" on the page
	And I set the radio button to "Yes"
	And I press the "Continue" button
	
	#CJS no
	
	Then I see "Have you worked in the criminal justice system in the last 5 years?" on the page
	When I set the radio button to "No"
	And I press the "Continue" button
	
	#Bail
	
	Then I see "Are you currently on bail for a criminal offence?" on the page
	When I see "Eligibility" on the page
	And I set the radio button to "No"
	And I press the "Continue" button
	
	#Convictions
	
	Then I see "Have you been found guilty of a criminal offence?" on the page
	When I see "Eligibility" on the page
	When I set the radio button to "No"
	And I press the "Continue" button
	
	#Mental Health Sectioned
	
	Then I see "Are you being detained, looked after or treated under the Mental Health Act?" on the page
	When I see "Eligibility" on the page
	And I set the radio button to "No"
	And I press the "Continue" button
	
	#Mental Health Capacity
	
	Then I see "Has it been decided that you 'lack mental capacity'?" on the page
	When I see "Eligibility" on the page
	And I set the radio button to "No"
	And I press the "Continue" button
	
	#I can attend
	
	Then I see "Check your start date" on the page
	And I see "Yes, I can start on" on the page
	And I set the radio button to "Yes, I can start on"
	And  I press the "Continue" button
	
	#RA no
	
	Then I see "Will you need help when you're at the court?" on the page
	When I set the radio button to "No"
	And I press the "Continue" button
	
	#Check Your Answers
	
	Then I see "Check your answers now" on the page
	When I check the "The information I have given is true to the best of my knowledge" checkbox
	And I press the "Submit" button
	Then I see "We have sent you an email to say you have replied to your jury summons." on the page
	
	#Bureau
	
	Given I am on "Bureau" "juror-test02"
	When I log in
	And I click on the "Search" link
	And I set "Juror number" to "<part_no>"
	And I press the "Search" button
	And I see "<part_no>" in the same row as "TO DO"
	And I click on "<part_no>" in the same row as "<part_no>"
	Then I see "Juror details" on the page
	And I see "Summoned" on the page
	And I see "NewTownCHANGED" on the page

	#check DB
	
	Then on "JUROR_DIGITAL" . "JUROR_RESPONSE" I see "STAFF_LOGIN" is null where "JUROR_NUMBER" is "<part_no>"
	Then on "JUROR_DIGITAL" . "JUROR_RESPONSE" I see "STAFF_ASSIGNMENT_DATE" is null where "JUROR_NUMBER" is "<part_no>"
	
Examples:
	|part_no	|last_name	|postcode	|email 				|pool_no	|
	|641500429	|DOE		|SY2 6LU	|email@outlook.com	|415170401	|
	
@Regression @JDB-4084
Scenario Outline: Check that when Address5 is changed from string value, the response is not auto processed
	Given I am on "Public" "juror-test02"
	Given the juror numbers have not been processed
		| part_no 	| pool_no 	| owner |
		| <part_no> |<pool_no>	| 400 	|
		
	And "<part_no>" has "LNAME" as "<last_name>" 
	And "<part_no>" has "RET_DATE" as "5 mondays time"
	And "<part_no>" has "NEXT_DATE" as "5 mondays time"
	And "<part_no>" has "ZIP" as "<postcode>"
	And "<part_no>" has "Address5" as "NewCounty"
	
	Then I see "Reply to a jury summons" on the page
	
	And I set the radio button to "I am replying for myself"
	And I press the "Continue" button
	And I set "9-digit juror number" to "<part_no>"
	And I set "Juror last name" to "<last_name>"
	And I set "Juror postcode" to "<postcode>"
	And I press the "Continue" button
	Then I see "Is the name we have for you correct?" on the page
	And I set the radio button to "Yes"
		
	When I press the "Continue" button
	Then I see "Is this your address?" on the page
	And I set the radio button to "No"
	When I press the "Continue" button

	And I set "County (optional)" to "NewCountyCHANGED"
	And I press the "Continue" button
	Then on the page I see
		| text	|
		|Your details|
		|What is your phone number?|
		|Please provide a UK phone number that we can use to reach you between 9am and 5pm, Monday to Friday.|
		|Main phone|
		|Another phone (optional)|

	When I set "Main phone" to "02078211818"
	And I press the "Continue" button

	Then on the page I see
		| text	|
		| Your details |
		| What is your email address? |
		| Enter your email address |
		| Enter your email address again |

	When I set "Enter your email address" to "email@outlook.com"
	When I set "Enter your email address again" to "email@outlook.com"
	And I press the "Continue" button

	Then on the page I see
		| text	|
		| Your details	|
		| What is your date of birth?	|
		| For example, 15 03 1982 |
		| Help with date of birth |
	
	When I set "Day" to "01"
	And I set "Month" to "01"
	And I set "Year" to "1990"
	And I press the "Continue" button

	#Qualify for jury service
	
	Then I see "Confirm you're eligible for jury service" on the page
	When I press the "Continue" button
	
	#Residency
	
	Then I see "Since you turned 13, has your main address been in the UK, Channel Islands or Isle of Man for any period of at least 5 years?" on the page
	When I see "Eligibility" on the page
	And I set the radio button to "Yes"
	And I press the "Continue" button
	
	#CJS no
	
	Then I see "Have you worked in the criminal justice system in the last 5 years?" on the page
	When I set the radio button to "No"
	And I press the "Continue" button
	
	#Bail
	
	Then I see "Are you currently on bail for a criminal offence?" on the page
	When I see "Eligibility" on the page
	And I set the radio button to "No"
	And I press the "Continue" button
	
	#Convictions
	
	Then I see "Have you been found guilty of a criminal offence?" on the page
	When I see "Eligibility" on the page
	When I set the radio button to "No"
	And I press the "Continue" button
	
	#Mental Health Sectioned
	
	Then I see "Are you being detained, looked after or treated under the Mental Health Act?" on the page
	When I see "Eligibility" on the page
	And I set the radio button to "No"
	And I press the "Continue" button
	
	#Mental Health Capacity
	
	Then I see "Has it been decided that you 'lack mental capacity'?" on the page
	When I see "Eligibility" on the page
	And I set the radio button to "No"
	And I press the "Continue" button
	
	#I can attend
	
	Then I see "Check your start date" on the page
	And I see "Yes, I can start on" on the page
	And I set the radio button to "Yes, I can start on"
	And  I press the "Continue" button
	
	#RA no
	
	Then I see "Will you need help when you're at the court?" on the page
	When I set the radio button to "No"
	And I press the "Continue" button
	
	#Check Your Answers
	
	Then I see "Check your answers now" on the page
	When I check the "The information I have given is true to the best of my knowledge" checkbox
	And I press the "Submit" button
	Then I see "We have sent you an email to say you have replied to your jury summons." on the page
	
	#Bureau
	
	Given I am on "Bureau" "juror-test02"
	When I log in
	And I click on the "Search" link
	And I set "Juror number" to "<part_no>"
	And I press the "Search" button
	And I see "<part_no>" in the same row as "TO DO"
	And I click on "<part_no>" in the same row as "<part_no>"
	Then I see "Juror details" on the page
	And I see "Summoned" on the page
	And I see "NewCountyCHANGED" on the page

	#check DB
	
	Then on "JUROR_DIGITAL" . "JUROR_RESPONSE" I see "STAFF_LOGIN" is null where "JUROR_NUMBER" is "<part_no>"
	Then on "JUROR_DIGITAL" . "JUROR_RESPONSE" I see "STAFF_ASSIGNMENT_DATE" is null where "JUROR_NUMBER" is "<part_no>"
	
Examples:
	|part_no	|last_name	|postcode	|email 				|pool_no	|
	|641500766	|DOE		|NN1 4EE	|email@outlook.com	|415170401	|