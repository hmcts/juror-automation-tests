Feature: 1st English Confirm Date of Service Back Link

@Regression @NewSchemaConverted
Scenario Outline: Checking there is a back link on the Confirm date of jury service screen

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
	
	#Juror Log In
	When I set "9-digit juror number" to "<juror_number>"
	When I set "Juror last name" to "<last_name>"
	When I set "Juror postcode" to "<postcode>"
	And I press the "Continue" button
	Then I see "Is the name we have for you correct?" on the page
	And I choose the "No" radio button
	And I press the "Continue" button
	
	#Check Name
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
	And I choose the "Yes" radio button
	When I press the "Continue" button
	Then I see "Is this your address?" on the page
	And I choose the "No" radio button
	And I press the "Continue" button
	
	#Check Address
	Then I set "Address line 1" to ""
	And I set "Town or city" to ""
	And I set "County (optional)" to ""
	And I set "Postcode" to ""
	And I press the "Continue" button
	
	Then I see "Provide the town or city you live in" on the page

	Then I see "Enter your postcode" on the page
	When I set "Address line 1" to "123 Street"
	And I set "Address line 2 (optional)" to "Line 2"
	And I set "Address line 3 (optional)" to "Line 3"
	And I set "Town or city" to "London"
	And I set "County (optional)" to "County"
	And I set "Postcode" to "CH1 2AN"
	And I press the "Continue" button
	Then I see "What is your phone number?" on the page
	When I click on the "Back" link
	Then I see "123 Street" on the page
	And I see "London" on the page
	And I see "CH1 2AN" on the page
	And I choose the "Yes" radio button
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
	When I set "Enter your email address" to "<email>"
	And I set "Enter your email address again" to "<email>"
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
	
	When I press the "Continue" button
	
	#Residency
	Then I see "Have you lived in the UK, Channel Islands or Isle of Man for more than five consecutive years, since your 13th birthday?" on the page
	When I press the "Continue" button
	Then I see "Select yes if your main address has been in the UK, Channel Islands or Isle of Man for any period of at least 5 years, since you turned 13" on the page
	When I choose the "No" radio button
	And I press the "Continue" button
	Then I see "Provide details about where you have lived since your 13th birthday" on the page
	When I choose the "Yes" radio button
	And I press the "Continue" button
	
	Then I see "Have you worked in the criminal justice system in the last 5 years?" on the page
	When I click on the "Back" link
	Then I see "Have you lived in the UK, Channel Islands or Isle of Man for more than five consecutive years, since your 13th birthday?" on the page
	And I press the "Continue" button
	
	#CJS no
	Then I see "Have you worked in the criminal justice system in the last 5 years?" on the page
	When I choose the "No" radio button
	And I click on the "Back" link
	And I see "Have you lived in the UK, Channel Islands or Isle of Man for more than five consecutive years, since your 13th birthday?" on the page
	And the radio button "Yes" is "Selected"
	And I press the "Continue" button
	Then I see "Have you worked in the criminal justice system in the last 5 years?" on the page
	When I choose the "No" radio button
	And I press the "Continue" button
	
	#Bail
	Then I see "Are you currently on bail for a criminal offence?" on the page
	When I press the "Continue" button
	Then I see "Select yes if you are currently on bail for a criminal offence" on the page
	When I choose the "Yes" radio button
	And I press the "Continue" button
	Then I see "Provide details about your bail and criminal offence" on the page
	When I choose the "No" radio button
	And I press the "Continue" button
	Then I see "Have you been found guilty of a criminal offence?" on the page
	When I click on the "Back" link
	Then I see "Are you currently on bail for a criminal offence?" on the page
	When I press the "Continue" button 
	
	#Convictions
	Then I see "Have you been found guilty of a criminal offence?" on the page
	When I press the "Continue" button
	Then I see "Select yes if you have been found guilty of a criminal offence" on the page
	When I choose the "Yes" radio button
	And I press the "Continue" button
	And I see "Provide details about your criminal offence" on the page
	When I choose the "No" radio button
	And I press the "Continue" button
	Then I see "Are you being detained, looked after or treated under the Mental Health Act?" on the page
	When I click on the "Back" link
	Then I see "Have you been found guilty of a criminal offence?" on the page
	When I press the "Continue" button 
	
	#Mental Health part 1
	Then I see "Are you being detained, looked after or treated under the Mental Health Act?" on the page
	When I press the "Continue" button
	Then I see "Select yes if you're being detained, looked after or treated under the Mental Health Act" on the page
	When I choose the "Yes" radio button
	And I press the "Continue" button
	Then I see "Provide details about how you're being detained, looked after or treated under the Mental Health Act" on the page
	When I choose the "No" radio button
	And I press the "Continue" button
	Then I see "Has it been decided that you 'lack mental capacity'?" on the page
	When I click on the "Back" link
	Then I see "Are you being detained, looked after or treated under the Mental Health Act?" on the page
	When I press the "Continue" button
	
	#Mental Health part 2
	Then I see "Has it been decided that you 'lack mental capacity'?" on the page
	When I press the "Continue" button
	Then I see "Select yes if it's been decided that you 'lack mental capacity'" on the page
	When I choose the "Yes" radio button
	And I press the "Continue" button
	Then I see "Provide brief details about why it was decided you lack mental capacity" on the page
	When I choose the "No" radio button
	And I press the "Continue" button
	Then I see "Check your start date" on the page
	When I click on the "Back" link
	Then I see "Has it been decided that you 'lack mental capacity'?" on the page
	When I press the "Continue" button
	
	Then I see "Check your start date" on the page
	
Examples:
	| juror_number	| last_name	| postcode	| email           	| pool_number	|
	| 045200172		| LNAME21	| CH1 2AN	| email@outlook.com	| 452300157		|
	
	
@Regression @NewSchemaConverted
Scenario Outline: No Error TypeError: Cannot read property details of undefined when clicking Back

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
	
	#Juror Log In
	When I set "9-digit juror number" to "<juror_number>"
	When I set "Juror last name" to "<last_name>"
	When I set "Juror postcode" to "<postcode>"
	And I press the "Continue" button
	Then I see "Is the name we have for you correct?" on the page
	And I choose the "No" radio button
	And I press the "Continue" button
	
	#change Name
	Then I set "Title (optional)" to "Prof"
	Then I set "First name" to "John"
	And I set "Last name" to "James"
	And I press the "Continue" button

	#change address
	Then I see "Is this your address?" on the page
	And I choose the "No" radio button
	And I press the "Continue" button
	Then I set "Address line 1" to "1"
	And I set "Town or city" to "2"
	And I set "Postcode" to "SW1H 9AG"
	And I press the "Continue" button
	
	#Phone Details
	Then I see "What is your phone number?" on the page
	When I set "Main phone" to "0207 821 1818"
	And I press the "Continue" button
	
	#email
	Then I see "What is your email address?" on the page
	When I set "Enter your email address" to "<email>"
	And I set "Enter your email address again" to "<email>"
	And I press the "Continue" button
	
	#dob
	Then I see "What is your date of birth?" on the page
	When I set "Day" to "01"
	And I set "Month" to "01"
	And I set "Year" to "1990"
	And I press the "Continue" button
	
	#qualifying
	Then I see "Confirm you're eligible for jury service" on the page
	And I press the "Continue" button

	#residency
	Then I see "Have you lived in the UK, Channel Islands or Isle of Man for more than five consecutive years, since your 13th birthday?" on the page
	
	#back
	When I click on the "Back" link
	Then I see "Confirm you're eligible for jury service" on the page
	When I click on the "Back" link
	Then I see "What is your date of birth?" on the page
	When I set "Day" to "01"
	And I set "Month" to "01"
	And I set "Year" to "1900"
	And I press the "Continue" button
	Then I see "Is your date of birth correct?" on the page
	And I choose the "Yes" radio button
	And I press the "Continue" button
	Then I see "Check your answers now" on the page
	And I do not see "TypeError: Cannot read property 'details' of undefined" on the page
	
	Examples:
	| juror_number	| last_name	| postcode	| email           	| pool_number	|
	| 045200173		| DOE		| SW1H 9AJ	| email@outlook.com	| 452300158		|