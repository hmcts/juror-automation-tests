Feature: Regression Test AUTOPROCESSING

@Features @NewSchemaConverted @JDB-6701
Scenario Outline: submit responses which are auto processed

#	return to @Regression when bug fixed

	Given I am on "Public" "test"

	Given a bureau owned pool is created with jurors
		| court | juror_number  	| pool_number	| att_date_weeks_in_future	| owner |
		| 415	| <juror_number1> 	| <pool_number> | 5				            | 400	|
		| 415	| <juror_number2> 	| <pool_number> | 5				            | 400	|
		| 415	| <juror_number3> 	| <pool_number> | 5				            | 400	|
		| 415	| <juror_number4> 	| <pool_number> | 5				            | 400	|

	And juror "<juror_number1>" has "LAST_NAME" as "<last_name>" new schema
	And juror "<juror_number1>" has "POSTCODE" as "<postcode>" new schema

	And juror "<juror_number2>" has "LAST_NAME" as "<last_name>" new schema
	And juror "<juror_number2>" has "POSTCODE" as "<postcode>" new schema

	And juror "<juror_number3>" has "LAST_NAME" as "<last_name>" new schema
	And juror "<juror_number3>" has "POSTCODE" as "<postcode>" new schema

	And juror "<juror_number4>" has "LAST_NAME" as "<last_name>" new schema
	And juror "<juror_number4>" has "POSTCODE" as "<postcode>" new schema

	#Auto Processed 1st ST

	Then I see "Reply to a jury summons" on the page

	And I set the radio button to "I am replying for myself"
	And I press the "Continue" button
	And I set "9-digit juror number" to "<juror_number1>"
	And I set "Juror last name" to "<last_name>"
	And I set "Juror postcode" to "<postcode>"
	And I press the "Continue" button
	Then on the page I see
		| text	|
		| Your details |
		| Is the name we have for you correct?	|

	And I do not see any links on the page that open to a new page without an alt text
	And I choose the "Yes" radio button
	And I press the "Continue" button
	Then on the page I see
		| text	|
		| Is this your address? |
	And I do not see any links on the page that open to a new page without an alt text
	And I choose the "Yes" radio button
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
	And I choose the "Yes" radio button
	And I press the "Continue" button

	#CJS no
	Then I see "Have you worked in the criminal justice system in the last 5 years?" on the page
	And I do not see any links on the page that open to a new page without an alt text
	When I choose the "No" radio button
	And I press the "Continue" button

	#JDB-3371
	Then I see "Are you currently on bail for a criminal offence?" on the page
	And I do not see any links on the page that open to a new page without an alt text

	#Bail JDB-3377
	When I see "Eligibility" on the page
	And I choose the "No" radio button
	And I press the "Continue" button

	#JDB-3370
	Then I see "Have you been found guilty of a criminal offence?" on the page
	And I do not see any links on the page that open to a new page without an alt text

	#Convictions JDB-3376
	When I see "Eligibility" on the page
	When I choose the "No" radio button
	And I press the "Continue" button

	#Mental Health Sectioned JDB-3363 JDB-3353
	Then I see "Are you being detained, looked after or treated under the Mental Health Act?" on the page
	And I do not see any links on the page that open to a new page without an alt text
	When I see "Eligibility" on the page
	And I choose the "No" radio button
	And I press the "Continue" button

	#Mental Health Capacity JDB-3364
	Then I see "Has it been decided that you 'lack mental capacity'?" on the page
	And I do not see any links on the page that open to a new page without an alt text
	When I see "Eligibility" on the page
	And I choose the "No" radio button
	And I press the "Continue" button

	#I can attend
	Then I see "Check your start date" on the page
	And I do not see any links on the page that open to a new page without an alt text
	And I see "Yes, I can start on" on the page
	And I set the radio button to "Yes, I can start on"
	And  I press the "Continue" button

	#RA no
	Then I see "Will you need help when you're at the court?" on the page
	When I choose the "No" radio button
	And I press the "Continue" button
	And I do not see any links on the page that open to a new page without an alt text
	When I check the "The information I have given is true to the best of my knowledge" checkbox

	#Enable auto processing
	Given auto straight through processing has been enabled new schema

	And I press the "Submit" button

	#Disable auto processing
	Given auto straight through processing has been disabled new schema
	And I do not see any links on the page that open to a new page without an alt text

	#Auto Processed Deceased
	Given I am on "Public" "test"

	And juror "<juror_number2>" has "LAST_NAME" as "<last_name>" new schema
	And juror "<juror_number2>" has "POSTCODE" as "<postcode>" new schema

	And I set the radio button to "I am replying for someone else"
	And I press the "Continue" button
	And I do not see any links on the page that open to a new page without an alt text
	When I set "9-digit juror number" to "<juror_number2>"
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
	Given auto straight through processing has been enabled new schema

	And I press the "Submit" button
	And I do not see any links on the page that open to a new page without an alt text

	#Disable auto processing
	Given auto straight through processing has been disabled new schema

	#Auto Processed Underage
	Given I am on "Public" "test"

	And "<juror_number3>" has "LAST_NAME" as "<last_name>"
	And "<juror_number3>" has "POSTCODE" as "<postcode>"

	And I set the radio button to "I am replying for myself"
	And I press the "Continue" button
	And I do not see any links on the page that open to a new page without an alt text
	When I set "9-digit juror number" to "<juror_number3>"
	When I set "Juror last name" to "<last_name>"
	When I set "Juror postcode" to "<postcode>"
	And I press the "Continue" button

	And I choose the "Yes" radio button
	And I press the "Continue" button

	And I choose the "Yes" radio button
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
	And I set "Year" to "2016"

	#Moving past DoB Section
	And I press the "Continue" button

	And I choose the "Yes" radio button
	And I press the "Continue" button

	And I do not see any links on the page that open to a new page without an alt text

	Then I check the "The information I have given is true to the best of my knowledge" checkbox

	#Enable auto processing
	Given auto straight through processing has been enabled new schema

	And I press the "Submit" button

	#Disable auto processing
	Given auto straight through processing has been disabled new schema

	#Auto Processing overage
	Given I am on "Public" "test"

	And juror "<juror_number4>" has "LAST_NAME" as "<last_name>" new schema
	And juror "<juror_number4>" has "POSTCODE" as "<postcode>" new schema

	And I set the radio button to "I am replying for myself"
	And I press the "Continue" button

	When I set "9-digit juror number" to "<juror_number4>"
	When I set "Juror last name" to "<last_name>"
	When I set "Juror postcode" to "<postcode>"
	And I press the "Continue" button

	And I see "Is the name we have for you correct?" on the page
	And I choose the "Yes" radio button
	When I press the "Continue" button

	And I see "Is this your address?" on the page
	And I choose the "Yes" radio button
	When I press the "Continue" button

	When I set "Main phone" to "02078211818"
	And I press the "Continue" button
	Then I see "What is your email address?" on the page

	When I set "Enter your email address" to "<email>"
	And I set "Enter your email address again" to "<email>"
	And I press the "Continue" button

	#On DoB Screen
	When I set "Day" to "27"
	And I set "Month" to "04"
	And I set "Year" to "1900"

	#Moving past DoB Section
	And I press the "Continue" button

	Then I choose the "Yes" radio button

	And I press the "Continue" button

	Then I check the "The information I have given is true to the best of my knowledge" checkbox

	#Enable auto processing
	Given auto straight through processing has been enabled new schema

	And I press the "Submit" button

	#Disable auto processing
	Given auto straight through processing has been disabled new schema

	Given I am on "Bureau" "test"
	And I log in as "MODTESTBUREAU"
	
	When I click on the "Search" link
	And I set "Juror's pool number" to "<pool_number>"
	And I press the "Search" button

	Then I see "Completed" in the same row as "<juror_number1>"
	And I see "AUTO" in the same row as "<juror_number1>"
	Then I see "Completed" in the same row as "<juror_number2>"
	And I see "AUTO" in the same row as "<juror_number2>"
	Then I see "Completed" in the same row as "<juror_number3>"
	And I see "AUTO" in the same row as "<juror_number3>"
	Then I see "Completed" in the same row as "<juror_number4>"
	And I see "AUTO" in the same row as "<juror_number4>"
	
	Then on "JUROR" . "POOL" I see "RESPONDED" is "Y" where "juror_number" is "<juror_number1>"
	Then on "JUROR" . "POOL" I see "USER_EDTQ" is "AUTO" where "juror_number" is "<juror_number1>"
	
	#JDB-3453
	
	Then on "JUROR_MOD" . "JUROR" I see "WELSH" is null where "juror_number" is "<juror_number1>"
	Then on "JUROR_MOD" . "JUROR" I see "RESPONDED" is "Y" where "juror_number" is "<juror_number2>"
	Then on "JUROR_MOD" . "JUROR" I see "USER_EDTQ" is "AUTO" where "juror_number" is "<juror_number2>"
	
	#JDB-3453
	
	Then on "JUROR_MOD" . "JUROR" I see "WELSH" is null where "juror_number" is "<juror_number2>" and "owner" is "400"
	Then on "JUROR_MOD" . "JUROR" I see "RESPONDED" is "Y" where "juror_number" is "<juror_number3>"
	Then on "JUROR_MOD" . "JUROR" I see "USER_EDTQ" is "AUTO" where "juror_number" is "<juror_number3>"
	
	#JDB-3453
	
	Then on "JUROR_MOD" . "JUROR" I see "WELSH" is null where "juror_number" is "<juror_number3>" and "owner" is "400"
	Then on "JUROR_MOD" . "JUROR" I see "RESPONDED" is "Y" where "juror_number" is "<juror_number4>"
	Then on "JUROR_MOD" . "JUROR" I see "USER_EDTQ" is "AUTO" where "juror_number" is "<juror_number4>"
	
	#JDB-3453
	
	Then on "JUROR_MOD" . "JUROR" I see "WELSH" is null where "juror_number" is "<juror_number4>"
	
	# finish test with auto processing enabled
	
	Given auto straight through processing has been enabled new schema
	
Examples:
	|juror_number1	|juror_number2	|juror_number3	|juror_number4	|pool_number|last_name 	|postcode	|email		|
	|641500607		|641500327		|641500339		|641500376 		|415170401	|LNAME 		|CH1 2AN	|e@mail.com	|

@Regression
Scenario Outline: Check that when name is changed, the response is NOT auto processed

	Given I am on "Public" "ithc"

	Given a bureau owned pool is created with jurors
		| court | juror_number  | pool_number	| att_date_weeks_in_future	| owner |
		| 452   | <juror_number>| <pool_number>	| 5				            | 400	|
		
	And juror "<juror_number>" has "LAST_NAME" as "<last_name>" new schema
	And juror "<juror_number>" has "POSTCODE" as "<postcode>" new schema
	
	Then I see "Reply to a jury summons" on the page
	
	And I set the radio button to "I am replying for myself"
	And I press the "Continue" button
	And I set "9-digit juror number" to "<juror_number>"
	And I set "Juror last name" to "<last_name>"
	And I set "Juror postcode" to "<postcode>"
	And I press the "Continue" button
	Then I see "Is the name we have for you correct?" on the page
		
	And I choose the "No" radio button
	And I press the "Continue" button
	And I set "Title" to "Mrs"
	And I set "First name" to "FirstNameChanged"
	And I set "Last name" to "LastNameChanged"
	And I press the "Continue" button
	Then I see "Is this your address?" on the page
	And I choose the "Yes" radio button

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
	And I choose the "Yes" radio button
	And I press the "Continue" button
	
	#CJS no
	Then I see "Have you worked in the criminal justice system in the last 5 years?" on the page
	When I choose the "No" radio button
	And I press the "Continue" button
	
	#Bail
	Then I see "Are you currently on bail for a criminal offence?" on the page
	When I see "Eligibility" on the page
	And I choose the "No" radio button
	And I press the "Continue" button
	
	#Convictions
	Then I see "Have you been found guilty of a criminal offence?" on the page
	When I see "Eligibility" on the page
	When I choose the "No" radio button
	And I press the "Continue" button
	
	#Mental Health Sectioned
	Then I see "Are you being detained, looked after or treated under the Mental Health Act?" on the page
	When I see "Eligibility" on the page
	And I choose the "No" radio button
	And I press the "Continue" button
	
	#Mental Health Capacity
	Then I see "Has it been decided that you 'lack mental capacity'?" on the page
	When I see "Eligibility" on the page
	And I choose the "No" radio button
	And I press the "Continue" button
	
	#I can attend
	Then I see "Check your start date" on the page
	And I see "Yes, I can start on" on the page
	And I set the radio button to "Yes, I can start on"
	And  I press the "Continue" button
	
	#RA no
	Then I see "Will you need help when you're at the court?" on the page
	When I choose the "No" radio button
	And I press the "Continue" button
	
	#Check Your Answers
	Then I see "Check your answers now" on the page
	When I check the "The information I have given is true to the best of my knowledge" checkbox
	And I press the "Submit" button
	Then I see "We have sent you an email to say you have replied to your jury summons." on the page
	
	#Bureau
	Given I am on "Bureau" "ithc"
	When I log in as "MODTESTBUREAU"
	And I click on the "Search" link
	And I set "Juror number" to "<juror_number>"
	And I press the "Search" button
	Then I see "<juror_number>" in the same row as "To do"
	
	#check DB
	
	Then on "JUROR_MOD" . "JUROR_RESPONSE" I see "STAFF_LOGIN" is null where "JUROR_NUMBER" is "<juror_number>"
	Then on "JUROR_MOD" . "JUROR_RESPONSE" I see "STAFF_ASSIGNMENT_DATE" is null where "JUROR_NUMBER" is "<juror_number>"
	
Examples:
	| juror_number	| last_name	| postcode	| email 			| pool_number	|
	| 045200212		| DOE		| SW1H 9AJ	| email@outlook.com	| 452300197		|
	
@Regression @NewSchemaConverted
Scenario Outline: Check that when address is changed, the response is NOT auto processed

	Given I am on "Public" "test"

	Given a bureau owned pool is created with jurors
		| court | juror_number  | pool_number	| att_date_weeks_in_future	| owner |
		| 452   | <juror_number>| <pool_number>	| 5				            | 400	|
		
	And juror "<juror_number>" has "LAST_NAME" as "<last_name>" new schema
	And juror "<juror_number>" has "ADDRESS_LINE_1" as "1 ORIGINAL LANE" new schema
	And juror "<juror_number>" has "POSTCODE" as "<postcode>" new schema
	
	Then I see "Reply to a jury summons" on the page
	
	And I set the radio button to "I am replying for myself"
	And I press the "Continue" button
	And I set "9-digit juror number" to "<juror_number>"
	And I set "Juror last name" to "<last_name>"
	And I set "Juror postcode" to "<postcode>"
	And I press the "Continue" button
	Then I see "Is the name we have for you correct?" on the page
	And I choose the "Yes" radio button
		
	When I press the "Continue" button
	Then I see "Is this your address?" on the page

	And I choose the "No" radio button
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
	And I choose the "Yes" radio button
	And I press the "Continue" button
	
	#CJS no
	Then I see "Have you worked in the criminal justice system in the last 5 years?" on the page
	When I choose the "No" radio button
	And I press the "Continue" button
	
	#Bail
	Then I see "Are you currently on bail for a criminal offence?" on the page
	When I see "Eligibility" on the page
	And I choose the "No" radio button
	And I press the "Continue" button
	
	#Convictions
	Then I see "Have you been found guilty of a criminal offence?" on the page
	When I see "Eligibility" on the page
	When I choose the "No" radio button
	And I press the "Continue" button
	
	#Mental Health Sectioned
	Then I see "Are you being detained, looked after or treated under the Mental Health Act?" on the page
	When I see "Eligibility" on the page
	And I choose the "No" radio button
	And I press the "Continue" button
	
	#Mental Health Capacity
	Then I see "Has it been decided that you 'lack mental capacity'?" on the page
	When I see "Eligibility" on the page
	And I choose the "No" radio button
	And I press the "Continue" button
	
	#I can attend
	Then I see "Check your start date" on the page
	And I see "Yes, I can start on" on the page
	And I set the radio button to "Yes, I can start on"
	And  I press the "Continue" button
	
	#RA no
	Then I see "Will you need help when you're at the court?" on the page
	When I choose the "No" radio button
	And I press the "Continue" button
	
	#Check Your Answers
	Then I see "Check your answers now" on the page
	When I check the "The information I have given is true to the best of my knowledge" checkbox
	And I press the "Submit" button
	Then I see "We have sent you an email to say you have replied to your jury summons." on the page
	
	#Bureau
	Given I am on "Bureau" "test"
	When I log in as "MODTESTBUREAU"
	And I click on the "Search" link
	And I set "Juror number" to "<juror_number>"
	And I press the "Search" button
	Then I see "<juror_number>" in the same row as "To do"

	#check DB
	Then on "JUROR_MOD" . "JUROR_RESPONSE" I see "STAFF_LOGIN" is null where "JUROR_NUMBER" is "<juror_number>"
	Then on "JUROR_MOD" . "JUROR_RESPONSE" I see "STAFF_ASSIGNMENT_DATE" is null where "JUROR_NUMBER" is "<juror_number>"
	
Examples:
	| juror_number	| last_name	| postcode	| email 			| pool_number	|
	| 045200213		| DOE		| SW1H 9AJ	| email@outlook.com	| 452300198		|

@Regression @NewSchemaConverted
Scenario Outline: Check that when Address2 is changed from (null), the response is not auto processed

	Given I am on "Public" "test"

	Given a bureau owned pool is created with jurors
		| court | juror_number  | pool_number	| att_date_weeks_in_future	| owner |
		| 452   | <juror_number>| <pool_number>	| 5				            | 400	|
		
	And juror "<juror_number>" has "LAST_NAME" as "<last_name>" new schema
	And juror "<juror_number>" has "POSTCODE" as "<postcode>" new schema
	And "<juror_number>" has "ADDRESS_LINE_2" as ""
	Then I see "Reply to a jury summons" on the page
	
	And I set the radio button to "I am replying for myself"
	And I press the "Continue" button
	And I set "9-digit juror number" to "<juror_number>"
	And I set "Juror last name" to "<last_name>"
	And I set "Juror postcode" to "<postcode>"
	And I press the "Continue" button
	Then I see "Is the name we have for you correct?" on the page
	And I choose the "Yes" radio button
		
	When I press the "Continue" button
	Then I see "Is this your address?" on the page
	And I choose the "No" radio button
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
	And I choose the "Yes" radio button
	And I press the "Continue" button
	
	#CJS no
	Then I see "Have you worked in the criminal justice system in the last 5 years?" on the page
	When I choose the "No" radio button
	And I press the "Continue" button
	
	#Bail
	Then I see "Are you currently on bail for a criminal offence?" on the page
	When I see "Eligibility" on the page
	And I choose the "No" radio button
	And I press the "Continue" button
	
	#Convictions
	Then I see "Have you been found guilty of a criminal offence?" on the page
	When I see "Eligibility" on the page
	When I choose the "No" radio button
	And I press the "Continue" button
	
	#Mental Health Sectioned
	Then I see "Are you being detained, looked after or treated under the Mental Health Act?" on the page
	When I see "Eligibility" on the page
	And I choose the "No" radio button
	And I press the "Continue" button
	
	#Mental Health Capacity
	Then I see "Has it been decided that you 'lack mental capacity'?" on the page
	When I see "Eligibility" on the page
	And I choose the "No" radio button
	And I press the "Continue" button
	
	#I can attend
	Then I see "Check your start date" on the page
	And I see "Yes, I can start on" on the page
	And I set the radio button to "Yes, I can start on"
	And  I press the "Continue" button
	
	#RA no
	Then I see "Will you need help when you're at the court?" on the page
	When I choose the "No" radio button
	And I press the "Continue" button
	
	#Check Your Answers
	Then I see "Check your answers now" on the page
	When I check the "The information I have given is true to the best of my knowledge" checkbox
	And I press the "Submit" button
	Then I see "We have sent you an email to say you have replied to your jury summons." on the page
	
	#Bureau
	Given I am on "Bureau" "test"
	When I log in as "MODTESTBUREAU"
	And I click on the "Search" link
	And I set "Juror number" to "<juror_number>"
	And I press the "Search" button
	And I see "<juror_number>" in the same row as "To do"
	And I click on "<juror_number>" in the same row as "<juror_number>"
	Then I see "Juror details" on the page
	And I see "Summoned" on the page
	And I see "Second Address Line" on the page

	#check DB
	Then on "JUROR_MOD" . "JUROR_RESPONSE" I see "STAFF_LOGIN" is null where "JUROR_NUMBER" is "<juror_number>"
	Then on "JUROR_MOD" . "JUROR_RESPONSE" I see "STAFF_ASSIGNMENT_DATE" is null where "JUROR_NUMBER" is "<juror_number>"
	
Examples:
	| juror_number	| last_name		| postcode	| email 			| pool_number	|
	| 045200214		| LNAMENINEFIVE	| SA1 4PF	| email@outlook.com	| 452300199		|
	
@Regression
Scenario Outline: Check that when Address3 is changed from (null), the response is not auto processed

	Given I am on "Public" "test"

	Given a bureau owned pool is created with jurors
		| court | juror_number  | pool_number	| att_date_weeks_in_future	| owner |
		| 452   | <juror_number>| <pool_number>	| 5				            | 400	|
		
	And juror "<juror_number>" has "LAST_NAME" as "<last_name>" new schema
	And juror "<juror_number>" has "POSTCODE" as "<postcode>" new schema
	And juror "<juror_number>" has "ADDRESS_LINE_3" as "" new schema
	
	Then I see "Reply to a jury summons" on the page

	And I set the radio button to "I am replying for myself"
	And I press the "Continue" button
	And I set "9-digit juror number" to "<juror_number>"
	And I set "Juror last name" to "<last_name>"
	And I set "Juror postcode" to "<postcode>"
	And I press the "Continue" button
	Then I see "Is the name we have for you correct?" on the page
	And I choose the "Yes" radio button
		
	When I press the "Continue" button
	Then I see "Is this your address?" on the page
	And I choose the "No" radio button
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
	And I choose the "Yes" radio button
	And I press the "Continue" button
	
	#CJS no
	Then I see "Have you worked in the criminal justice system in the last 5 years?" on the page
	When I choose the "No" radio button
	And I press the "Continue" button
	
	#Bail
	Then I see "Are you currently on bail for a criminal offence?" on the page
	When I see "Eligibility" on the page
	And I choose the "No" radio button
	And I press the "Continue" button
	
	#Convictions
	Then I see "Have you been found guilty of a criminal offence?" on the page
	When I see "Eligibility" on the page
	When I choose the "No" radio button
	And I press the "Continue" button
	
	#Mental Health Sectioned
	Then I see "Are you being detained, looked after or treated under the Mental Health Act?" on the page
	When I see "Eligibility" on the page
	And I choose the "No" radio button
	And I press the "Continue" button
	
	#Mental Health Capacity
	Then I see "Has it been decided that you 'lack mental capacity'?" on the page
	When I see "Eligibility" on the page
	And I choose the "No" radio button
	And I press the "Continue" button
	
	#I can attend
	Then I see "Check your start date" on the page
	And I see "Yes, I can start on" on the page
	And I set the radio button to "Yes, I can start on"
	And  I press the "Continue" button
	
	#RA no
	Then I see "Will you need help when you're at the court?" on the page
	When I choose the "No" radio button
	And I press the "Continue" button
	
	#Check Your Answers
	Then I see "Check your answers now" on the page
	When I check the "The information I have given is true to the best of my knowledge" checkbox
	And I press the "Submit" button
	Then I see "We have sent you an email to say you have replied to your jury summons." on the page
	
	#Bureau
	Given I am on "Bureau" "test"
	When I log in as "MODTESTBUREAU"
	And I click on the "Search" link
	And I set "Juror number" to "<juror_number>"
	And I press the "Search" button
	And I see "<juror_number>" in the same row as "To do"
	And I click on "<juror_number>" in the same row as "<juror_number>"
	Then I see "Juror details" on the page
	And I see "Summoned" on the page
	And I see "Third Address Line" on the page

	#check DB
	Then on "JUROR_MOD" . "JUROR_RESPONSE" I see "STAFF_LOGIN" is null where "JUROR_NUMBER" is "<juror_number>"
	Then on "JUROR_MOD" . "JUROR_RESPONSE" I see "STAFF_ASSIGNMENT_DATE" is null where "JUROR_NUMBER" is "<juror_number>"
	
Examples:
	| juror_number	| last_name			| postcode	| email 			| pool_number	|
	| 045200215		| LNAMEFOURTHREEZERO| NN1 3HQ	| email@outlook.com	| 452300200		|
	
@Regression @NewSchemaConverted
Scenario Outline: Check that when Address4 is changed from (null), the response is not auto processed

	Given I am on "Public" "test"

	Given a bureau owned pool is created with jurors
		| court | juror_number  | pool_number	| att_date_weeks_in_future	| owner |
		| 452   | <juror_number>| <pool_number>	| 5				            | 400	|
		
	And juror "<juror_number>" has "LAST_NAME" as "<last_name>" new schema
	And juror "<juror_number>" has "POSTCODE" as "<postcode>" new schema
	And juror "<juror_number>" has "ADDRESS_LINE_4" as "" new schema
	
	Then I see "Reply to a jury summons" on the page
	
	And I set the radio button to "I am replying for myself"
	And I press the "Continue" button
	And I set "9-digit juror number" to "<juror_number>"
	And I set "Juror last name" to "<last_name>"
	And I set "Juror postcode" to "<postcode>"
	And I press the "Continue" button
	Then I see "Is the name we have for you correct?" on the page
	And I choose the "Yes" radio button

	When I press the "Continue" button
	Then I see "Is this your address?" on the page
	And I choose the "No" radio button
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
	And I choose the "Yes" radio button
	And I press the "Continue" button
	
	#CJS no
	Then I see "Have you worked in the criminal justice system in the last 5 years?" on the page
	When I choose the "No" radio button
	And I press the "Continue" button
	
	#Bail
	Then I see "Are you currently on bail for a criminal offence?" on the page
	When I see "Eligibility" on the page
	And I choose the "No" radio button
	And I press the "Continue" button
	
	#Convictions
	Then I see "Have you been found guilty of a criminal offence?" on the page
	When I see "Eligibility" on the page
	When I choose the "No" radio button
	And I press the "Continue" button
	
	#Mental Health Sectioned
	Then I see "Are you being detained, looked after or treated under the Mental Health Act?" on the page
	When I see "Eligibility" on the page
	And I choose the "No" radio button
	And I press the "Continue" button
	
	#Mental Health Capacity
	Then I see "Has it been decided that you 'lack mental capacity'?" on the page
	When I see "Eligibility" on the page
	And I choose the "No" radio button
	And I press the "Continue" button
	
	#I can attend
	Then I see "Check your start date" on the page
	And I see "Yes, I can start on" on the page
	And I set the radio button to "Yes, I can start on"
	And  I press the "Continue" button
	
	#RA no
	Then I see "Will you need help when you're at the court?" on the page
	When I choose the "No" radio button
	And I press the "Continue" button
	
	#Check Your Answers
	Then I see "Check your answers now" on the page
	When I check the "The information I have given is true to the best of my knowledge" checkbox
	And I press the "Submit" button
	
	Then I see "We have sent you an email to say you have replied to your jury summons." on the page
	
	#Bureau
	Given I am on "Bureau" "test"
	When I log in as "MODTESTBUREAU"
	And I click on the "Search" link
	And I set "Juror number" to "<juror_number>"
	And I press the "Search" button
	And I see "<juror_number>" in the same row as "To do"
	And I click on "<juror_number>" in the same row as "<juror_number>"
	Then I see "Juror details" on the page
	And I see "Summoned" on the page
	And I see "NewTown" on the page

	#check DB
	Then on "JUROR_MOD" . "JUROR_RESPONSE" I see "STAFF_LOGIN" is null where "JUROR_NUMBER" is "<juror_number>"
	Then on "JUROR_MOD" . "JUROR_RESPONSE" I see "STAFF_ASSIGNMENT_DATE" is null where "JUROR_NUMBER" is "<juror_number>"
	
Examples:
	| juror_number	| last_name			| postcode	| email 			| pool_number	|
	| 045200216		| LNAMEONEONEEIGHT	| SA1 4PF	| email@outlook.com	| 452300201		|
	
@Regression @NewSchemaConverted
Scenario Outline: Check that when Address5 is changed from (null), the response is not auto processed

	Given I am on "Public" "test"

	Given a bureau owned pool is created with jurors
		| court | juror_number  | pool_number	| att_date_weeks_in_future	| owner |
		| 452   | <juror_number>| <pool_number>	| 5				            | 400	|
		
	And juror "<juror_number>" has "LAST_NAME" as "<last_name>" new schema
	And juror "<juror_number>" has "POSTCODE" as "<postcode>" new schema
	And juror "<juror_number>" has "ADDRESS_LINE_5" as "" new schema
	
	Then I see "Reply to a jury summons" on the page
	
	And I set the radio button to "I am replying for myself"
	And I press the "Continue" button
	And I set "9-digit juror number" to "<juror_number>"
	And I set "Juror last name" to "<last_name>"
	And I set "Juror postcode" to "<postcode>"
	And I press the "Continue" button
	Then I see "Is the name we have for you correct?" on the page
	And I choose the "Yes" radio button
		
	When I press the "Continue" button
	Then I see "Is this your address?" on the page
	And I choose the "No" radio button

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
	And I choose the "Yes" radio button
	And I press the "Continue" button
	
	#CJS no
	Then I see "Have you worked in the criminal justice system in the last 5 years?" on the page
	When I choose the "No" radio button
	And I press the "Continue" button
	
	#Bail
	Then I see "Are you currently on bail for a criminal offence?" on the page
	When I see "Eligibility" on the page
	And I choose the "No" radio button
	And I press the "Continue" button
	
	#Convictions
	Then I see "Have you been found guilty of a criminal offence?" on the page
	When I see "Eligibility" on the page
	When I choose the "No" radio button
	And I press the "Continue" button
	
	#Mental Health Sectioned
	Then I see "Are you being detained, looked after or treated under the Mental Health Act?" on the page
	When I see "Eligibility" on the page
	And I choose the "No" radio button
	And I press the "Continue" button
	
	#Mental Health Capacity
	Then I see "Has it been decided that you 'lack mental capacity'?" on the page
	When I see "Eligibility" on the page
	And I choose the "No" radio button
	And I press the "Continue" button
	
	#I can attend
	Then I see "Check your start date" on the page
	And I see "Yes, I can start on" on the page
	And I set the radio button to "Yes, I can start on"
	And  I press the "Continue" button
	
	#RA no
	Then I see "Will you need help when you're at the court?" on the page
	When I choose the "No" radio button
	And I press the "Continue" button
	
	#Check Your Answers
	Then I see "Check your answers now" on the page
	When I check the "The information I have given is true to the best of my knowledge" checkbox
	And I press the "Submit" button
	Then I see "We have sent you an email to say you have replied to your jury summons." on the page
	
	#Bureau
	Given I am on "Bureau" "test"
	When I log in as "MODTESTBUREAU"
	And I click on the "Search" link
	And I set "Juror number" to "<juror_number>"
	And I press the "Search" button
	And I see "<juror_number>" in the same row as "To do"
	And I click on "<juror_number>" in the same row as "<juror_number>"
	Then I see "Juror details" on the page
	And I see "Summoned" on the page
	And I see "NewCounty" on the page

	#check DB
	Then on "JUROR_MOD" . "JUROR_RESPONSE" I see "STAFF_LOGIN" is null where "JUROR_NUMBER" is "<juror_number>"
	Then on "JUROR_MOD" . "JUROR_RESPONSE" I see "STAFF_ASSIGNMENT_DATE" is null where "JUROR_NUMBER" is "<juror_number>"
	
Examples:
	| juror_number	| last_name			| postcode	| email 			| pool_number	|
	| 045200217		| LNAMENINEZEROTWO	| NN1 3HQ	| email@outlook.com	| 452300202		|
	
@Regression @NewSchemaConverted
Scenario Outline: Check that when Address2 is changed from string value, the response is not auto processed

	Given I am on "Public" "test"

	Given a bureau owned pool is created with jurors
		| court | juror_number  | pool_number	| att_date_weeks_in_future	| owner |
		| 452   | <juror_number>| <pool_number>	| 5				            | 400	|
		
	And juror "<juror_number>" has "LAST_NAME" as "<last_name>" new schema
	And juror "<juror_number>" has "POSTCODE" as "<postcode>" new schema
	And juror "<juror_number>" has "Address2" as "Second Address Line" new schema
	
	Then I see "Reply to a jury summons" on the page

	And I set the radio button to "I am replying for myself"
	And I press the "Continue" button
	And I set "9-digit juror number" to "<juror_number>"
	And I set "Juror last name" to "<last_name>"
	And I set "Juror postcode" to "<postcode>"
	And I press the "Continue" button
	Then I see "Is the name we have for you correct?" on the page
	And I choose the "Yes" radio button
		
	When I press the "Continue" button
	Then I see "Is this your address?" on the page
	And I choose the "No" radio button

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
	And I choose the "Yes" radio button
	And I press the "Continue" button
	
	#CJS no
	Then I see "Have you worked in the criminal justice system in the last 5 years?" on the page
	When I choose the "No" radio button
	And I press the "Continue" button
	
	#Bail
	Then I see "Are you currently on bail for a criminal offence?" on the page
	When I see "Eligibility" on the page
	And I choose the "No" radio button
	And I press the "Continue" button
	
	#Convictions
	Then I see "Have you been found guilty of a criminal offence?" on the page
	When I see "Eligibility" on the page
	When I choose the "No" radio button
	And I press the "Continue" button
	
	#Mental Health Sectioned
	Then I see "Are you being detained, looked after or treated under the Mental Health Act?" on the page
	When I see "Eligibility" on the page
	And I choose the "No" radio button
	And I press the "Continue" button
	
	#Mental Health Capacity
	Then I see "Has it been decided that you 'lack mental capacity'?" on the page
	When I see "Eligibility" on the page
	And I choose the "No" radio button
	And I press the "Continue" button
	
	#I can attend
	Then I see "Check your start date" on the page
	And I see "Yes, I can start on" on the page
	And I set the radio button to "Yes, I can start on"
	And  I press the "Continue" button
	
	#RA no
	Then I see "Will you need help when you're at the court?" on the page
	When I choose the "No" radio button
	And I press the "Continue" button
	
	#Check Your Answers
	Then I see "Check your answers now" on the page
	When I check the "The information I have given is true to the best of my knowledge" checkbox
	And I press the "Submit" button
	Then I see "We have sent you an email to say you have replied to your jury summons." on the page
	
	#Bureau
	Given I am on "Bureau" "test"
	When I log in as "MODTESTBUREAU"
	And I click on the "Search" link
	And I set "Juror number" to "<juror_number>"
	And I press the "Search" button
	And I see "<juror_number>" in the same row as "To do"
	And I click on "<juror_number>" in the same row as "<juror_number>"
	Then I see "Juror details" on the page
	And I see "Summoned" on the page
	And I see "Second Address Line CHANGED" on the page

	#check DB
	Then on "JUROR_MOD" . "JUROR_RESPONSE" I see "STAFF_LOGIN" is null where "JUROR_NUMBER" is "<juror_number>"
	Then on "JUROR_MOD" . "JUROR_RESPONSE" I see "STAFF_ASSIGNMENT_DATE" is null where "JUROR_NUMBER" is "<juror_number>"
	
Examples:
	| juror_number	| last_name	| postcode	| email 			| pool_number	|
	| 045200218		| DOE		| SW1H 9AJ	| email@outlook.com	| 452300203		|
	
@Regression @NewSchemaConverted
Scenario Outline: Check that when Address3 is changed from string value, the response is not auto processed

	Given I am on "Public" "test"

	Given a bureau owned pool is created with jurors
		| court | juror_number  | pool_number	| att_date_weeks_in_future	| owner |
		| 452   | <juror_number>| <pool_number>	| 5				            | 400	|
		
	And juror "<juror_number>" has "LAST_NAME" as "<last_name>" new schema
	And juror "<juror_number>" has "POSTCODE" as "<postcode>" new schema
	And juror "<juror_number>" has "ADDRES_LINE_3" as "Third Address Line" new schema
	
	Then I see "Reply to a jury summons" on the page
	
	And I set the radio button to "I am replying for myself"
	And I press the "Continue" button
	And I set "9-digit juror number" to "<juror_number>"
	And I set "Juror last name" to "<last_name>"
	And I set "Juror postcode" to "<postcode>"
	And I press the "Continue" button
	Then I see "Is the name we have for you correct?" on the page
	And I choose the "Yes" radio button
		
	When I press the "Continue" button
	Then I see "Is this your address?" on the page
	And I choose the "No" radio button
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
	And I choose the "Yes" radio button
	And I press the "Continue" button
	
	#CJS no
	Then I see "Have you worked in the criminal justice system in the last 5 years?" on the page
	When I choose the "No" radio button
	And I press the "Continue" button
	
	#Bail
	Then I see "Are you currently on bail for a criminal offence?" on the page
	When I see "Eligibility" on the page
	And I choose the "No" radio button
	And I press the "Continue" button
	
	#Convictions
	Then I see "Have you been found guilty of a criminal offence?" on the page
	When I see "Eligibility" on the page
	When I choose the "No" radio button
	And I press the "Continue" button
	
	#Mental Health Sectioned
	Then I see "Are you being detained, looked after or treated under the Mental Health Act?" on the page
	When I see "Eligibility" on the page
	And I choose the "No" radio button
	And I press the "Continue" button
	
	#Mental Health Capacity
	Then I see "Has it been decided that you 'lack mental capacity'?" on the page
	When I see "Eligibility" on the page
	And I choose the "No" radio button
	And I press the "Continue" button
	
	#I can attend
	Then I see "Check your start date" on the page
	And I see "Yes, I can start on" on the page
	And I set the radio button to "Yes, I can start on"
	And  I press the "Continue" button
	
	#RA no
	Then I see "Will you need help when you're at the court?" on the page
	When I choose the "No" radio button
	And I press the "Continue" button
	
	#Check Your Answers
	Then I see "Check your answers now" on the page
	When I check the "The information I have given is true to the best of my knowledge" checkbox
	And I press the "Submit" button
	Then I see "We have sent you an email to say you have replied to your jury summons." on the page
	
	#Bureau
	Given I am on "Bureau" "test"
	When I log in as "MODTESTBUREAU"
	And I click on the "Search" link
	And I set "Juror number" to "<juror_number>"
	And I press the "Search" button
	And I see "<juror_number>" in the same row as "To do"
	And I click on "<juror_number>" in the same row as "<juror_number>"
	Then I see "Juror details" on the page
	And I see "Summoned" on the page
	And I see "Third Address Line CHANGED" on the page

	#check DB
	Then on "JUROR_MOD" . "JUROR_RESPONSE" I see "STAFF_LOGIN" is null where "JUROR_NUMBER" is "<juror_number>"
	Then on "JUROR_MOD" . "JUROR_RESPONSE" I see "STAFF_ASSIGNMENT_DATE" is null where "JUROR_NUMBER" is "<juror_number>"
	
Examples:
	| juror_number	| last_name				| postcode	| email 			| pool_number	|
	| 045200219		| LNAMENINEFIVETHREE	| CH1 2AN	| email@outlook.com	| 452300204		|
	
@Regression @NewSchemaConverted
Scenario Outline: Check that when Address4 is changed from string value, the response is not auto processed

	Given I am on "Public" "test"

	Given a bureau owned pool is created with jurors
		| court | juror_number  | pool_number	| att_date_weeks_in_future	| owner |
		| 452   | <juror_number>| <pool_number>	| 5				            | 400	|
		
	And juror "<juror_number>" has "LAST_NAME" as "<last_name>" new schema
	And juror "<juror_number>" has "POSTCODE" as "<postcode>" new schema
	And juror "<juror_number>" has "ADDRESS_LINE_4" as "NewTown" new schema
	
	Then I see "Reply to a jury summons" on the page
	
	And I set the radio button to "I am replying for myself"
	And I press the "Continue" button
	And I set "9-digit juror number" to "<juror_number>"
	And I set "Juror last name" to "<last_name>"
	And I set "Juror postcode" to "<postcode>"
	And I press the "Continue" button
	Then I see "Is the name we have for you correct?" on the page
	And I choose the "Yes" radio button
		
	When I press the "Continue" button
	Then I see "Is this your address?" on the page
	And I choose the "No" radio button

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
	And I choose the "Yes" radio button
	And I press the "Continue" button
	
	#CJS no
	Then I see "Have you worked in the criminal justice system in the last 5 years?" on the page
	When I choose the "No" radio button
	And I press the "Continue" button
	
	#Bail
	Then I see "Are you currently on bail for a criminal offence?" on the page
	When I see "Eligibility" on the page
	And I choose the "No" radio button
	And I press the "Continue" button
	
	#Convictions
	Then I see "Have you been found guilty of a criminal offence?" on the page
	When I see "Eligibility" on the page
	When I choose the "No" radio button
	And I press the "Continue" button
	
	#Mental Health Sectioned
	Then I see "Are you being detained, looked after or treated under the Mental Health Act?" on the page
	When I see "Eligibility" on the page
	And I choose the "No" radio button
	And I press the "Continue" button
	
	#Mental Health Capacity
	Then I see "Has it been decided that you 'lack mental capacity'?" on the page
	When I see "Eligibility" on the page
	And I choose the "No" radio button
	And I press the "Continue" button
	
	#I can attend
	Then I see "Check your start date" on the page
	And I see "Yes, I can start on" on the page
	And I set the radio button to "Yes, I can start on"
	And  I press the "Continue" button
	
	#RA no
	Then I see "Will you need help when you're at the court?" on the page
	When I choose the "No" radio button
	And I press the "Continue" button
	
	#Check Your Answers
	Then I see "Check your answers now" on the page
	When I check the "The information I have given is true to the best of my knowledge" checkbox
	And I press the "Submit" button
	Then I see "We have sent you an email to say you have replied to your jury summons." on the page
	
	#Bureau
	Given I am on "Bureau" "test"
	When I log in as "MODTESTBUREAU"
	And I click on the "Search" link
	And I set "Juror number" to "<juror_number>"
	And I press the "Search" button
	And I see "<juror_number>" in the same row as "To do"
	And I click on "<juror_number>" in the same row as "<juror_number>"
	Then I see "Juror details" on the page
	And I see "Summoned" on the page
	And I see "NewTownCHANGED" on the page

	#check DB
	Then on "JUROR_MOD" . "JUROR_RESPONSE" I see "STAFF_LOGIN" is null where "JUROR_NUMBER" is "<juror_number>"
	Then on "JUROR_MOD" . "JUROR_RESPONSE" I see "STAFF_ASSIGNMENT_DATE" is null where "JUROR_NUMBER" is "<juror_number>"
	
Examples:
	| juror_number	| last_name	| postcode	| email 			| pool_number	|
	| 045200220		| DOE		| SY2 6LU	| email@outlook.com	| 452300205		|
	
@Regression @NewSchemaConverted
Scenario Outline: Check that when Address5 is changed from string value, the response is not auto processed

	Given I am on "Public" "test"

	Given a bureau owned pool is created with jurors
		| court | juror_number  | pool_number	| att_date_weeks_in_future	| owner |
		| 452   | <juror_number>| <pool_number>	| 5				            | 400	|
		
	And juror "<juror_number>" has "LAST_NAME" as "<last_name>" new schema
	And juror "<juror_number>" has "POSTCODE" as "<postcode>" new schema
	And juror "<juror_number>" has "ADDRESS_LINE_5" as "NewCounty" new schema
	
	Then I see "Reply to a jury summons" on the page
	
	And I set the radio button to "I am replying for myself"
	And I press the "Continue" button
	And I set "9-digit juror number" to "<juror_number>"
	And I set "Juror last name" to "<last_name>"
	And I set "Juror postcode" to "<postcode>"
	And I press the "Continue" button
	Then I see "Is the name we have for you correct?" on the page
	And I choose the "Yes" radio button
		
	When I press the "Continue" button
	Then I see "Is this your address?" on the page
	And I choose the "No" radio button
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
	And I choose the "Yes" radio button
	And I press the "Continue" button
	
	#CJS no
	Then I see "Have you worked in the criminal justice system in the last 5 years?" on the page
	When I choose the "No" radio button
	And I press the "Continue" button
	
	#Bail
	Then I see "Are you currently on bail for a criminal offence?" on the page
	When I see "Eligibility" on the page
	And I choose the "No" radio button
	And I press the "Continue" button
	
	#Convictions
	Then I see "Have you been found guilty of a criminal offence?" on the page
	When I see "Eligibility" on the page
	When I choose the "No" radio button
	And I press the "Continue" button
	
	#Mental Health Sectioned
	Then I see "Are you being detained, looked after or treated under the Mental Health Act?" on the page
	When I see "Eligibility" on the page
	And I choose the "No" radio button
	And I press the "Continue" button
	
	#Mental Health Capacity
	Then I see "Has it been decided that you 'lack mental capacity'?" on the page
	When I see "Eligibility" on the page
	And I choose the "No" radio button
	And I press the "Continue" button
	
	#I can attend
	Then I see "Check your start date" on the page
	And I see "Yes, I can start on" on the page
	And I set the radio button to "Yes, I can start on"
	And  I press the "Continue" button
	
	#RA no
	Then I see "Will you need help when you're at the court?" on the page
	When I choose the "No" radio button
	And I press the "Continue" button
	
	#Check Your Answers
	Then I see "Check your answers now" on the page
	When I check the "The information I have given is true to the best of my knowledge" checkbox
	And I press the "Submit" button
	Then I see "We have sent you an email to say you have replied to your jury summons." on the page
	
	#Bureau
	Given I am on "Bureau" "test"
	When I log in as "MODTESTBUREAU"
	And I click on the "Search" link
	And I set "Juror number" to "<juror_number>"
	And I press the "Search" button
	And I see "<juror_number>" in the same row as "To do"
	And I click on "<juror_number>" in the same row as "<juror_number>"
	Then I see "Juror details" on the page
	And I see "Summoned" on the page
	And I see "NewCountyCHANGED" on the page

	#check DB
	Then on "JUROR_MOD" . "JUROR_RESPONSE" I see "STAFF_LOGIN" is null where "JUROR_NUMBER" is "<juror_number>"
	Then on "JUROR_MOD" . "JUROR_RESPONSE" I see "STAFF_ASSIGNMENT_DATE" is null where "JUROR_NUMBER" is "<juror_number>"
	
Examples:
	| juror_number	| last_name	| postcode	| email 			| pool_number	|
	| 045200221		| DOE		| NN1 4EE	| email@outlook.com	| 452300206		|