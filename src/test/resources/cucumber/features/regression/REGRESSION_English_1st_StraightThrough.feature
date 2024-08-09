Feature: Regression English_1st_StraightThrough

@Regression @NewSchemaConverted
Scenario Outline: English 1st Party Straight Through
	
	Given I am on "Public" "test"

	Given a bureau owned pool is created with jurors
		| court |juror_number  | pool_number	| att_date_weeks_in_future	| owner |
		| 452   |<juror_number>| <pool_number>	| 5				            | 400	|
		
	And juror "<juror_number>" has "LAST_NAME" as "<last_name>" new schema
	And juror "<juror_number>" has "POSTCODE" as "<postcode>" new schema
	
	Given auto straight through processing has been enabled new schema
	
	And I set the radio button to "I am replying for myself"
	And I see "You can still ask a family member or a person you trust to help you understand or reply." on the page
	And I do not see "Beta" on the page
	And I see "Give feedback (opens in a new window or tab)" on the page
	And I see "Accessibility statement" on the page
	And I click on the "What if I need help replying?" link
	And I see "You can ask a family member, friend or carer to help you. They can reply for you or help you to do it yourself. You may be able to get help with using a computer at your local library. If you need more help, call 0300 456 1024." on the page
	
	And I press the "Continue" button
	And I see "steps/login" in the URL
	And I see "Your juror details" on the page
	And I see "You can find your juror number on your jury summons letter." on the page
	And I click on the "I do not have a juror number" link
	Then I see "jurysummoning@justice.gov.uk" on the page
	And I see "If you do not have a juror number, please contact:" on the page
	
	When I set "9-digit juror number" to "<juror_number>"
	And I set "Juror last name" to "<last_name>"
	And I set "Juror postcode" to "<postcode>"
	And I press the "Continue" button
	Then on the page I see
		| text	|
		| Your details |
		| Is the name we have for you correct? |
	
	And I see "steps/your-details/name" in the URL
	And I do not see "Beta" on the page
	And I see "Give feedback (opens in a new window or tab)" on the page
	And I choose the "Yes" radio button
	
	And I press the "Continue" button
	Then on the page I see
		| text	|
		| Is this your address? |

	And I see "steps/your-details/address" in the URL
	And I do not see "Beta" on the page
	And I see "Give feedback (opens in a new window or tab)" on the page
	And I choose the "Yes" radio button
	
	When I press the "Continue" button
	
	Then on the page I see
		| text	|
		|Your details|
		|What is your phone number?|
		|Please provide a UK phone number that we can use to reach you between 9am and 5pm, Monday to Friday.|
		|Main phone|
		|Another phone (optional)|
	
	And I see "steps/your-details/phone" in the URL
	And I do not see "Beta" on the page
	And I see "Give feedback (opens in a new window or tab)" on the page
	When I press the "Continue" button
	Then on the page I see
		|text	|
		|There is a problem|
		|Enter your main phone number|

	When I set "Main phone" to "02078211818"
	And I do not see "Beta" on the page
	And I see "Give feedback (opens in a new window or tab)" on the page
	And I press the "Continue" button

	Then on the page I see
		| text	|
		| Your details |
		| What is your email address? |
		| Enter your email address |
		| Enter your email address again |

	And I see "steps/your-details/email" in the URL
	And I do not see "Beta" on the page
	And I see "Give feedback (opens in a new window or tab)" on the page
	When I press the "Continue" button
	Then on the page I see
		| text |
		| Your details |
		| Enter your email address |
	
	When I set "Enter your email address" to "<email>"
	And I press the "Continue" button
	Then I see "Enter your email address and check that it matches the one in the first field" on the page
	When I set "Enter your email address again" to "<email>"
	And I click on the "Why do we need your email address?" link
	And I see "We'll use your email address to send you information and reminders about your jury service." on the page
	And I press the "Continue" button

	Then on the page I see
		| text	|
		| Your details	|
		| What is your date of birth?	|
		| For example, 15 03 1982 |
		| Help with date of birth |
	
	And I see "steps/your-details/date-of-birth" in the URL
	And I do not see "Beta" on the page
	And I see "Give feedback (opens in a new window or tab)" on the page
	When I set "Day" to "01"
	And I set "Month" to "01"
	And I set "Year" to "1990"
	And I press the "Continue" button

	#Qualify for jury service
	#JDB-4636
	And I see "steps/qualify" in the URL
	Then I see "Confirm you're eligible for jury service" on the page
	And I do not see "Qualifying for jury service" on the page
	And I see "Your answers in this next section will help us check if you can do jury service or not." on the page
	And I see "You must answer these questions even if you:" on the page
	And I see "think you’re not eligible" on the page
	And I see "want to be excused" on the page
	And I see "You can ask for an excusal after this section, if needed." on the page
	And I do not see "Beta" on the page
	And I see "Give feedback (opens in a new window or tab)" on the page
	When I press the "Continue" button
	Then I see "Since you turned 13, has your main address been in the UK, Channel Islands or Isle of Man for any period of at least 5 years?" on the page
	
	#Residency
	And I see "Since you turned 13, has your main address been in the UK, Channel Islands or Isle of Man for any period of at least 5 years?" on the page
	And I see "steps/qualify/residency" in the URL
	And I do not see "Qualifying for jury service" on the page
	When I see "Eligibility" on the page
	And I do not see "Beta" on the page
	And I see "Give feedback (opens in a new window or tab)" on the page
	And I click on the "Need help answering this?" link
	And I see "You must contact us to get advice on your specific situation." on the page
	And I choose the "Yes" radio button
	And I press the "Continue" button
	
	#CJS no
	Then I see "Have you worked in the criminal justice system in the last 5 years?" on the page
	And I see "steps/qualify/cjs-employed" in the URL
	And I do not see "Beta" on the page
	When I see "Eligibility" on the page
	And I do not see "Qualifying for jury service" on the page
	And I see "Give feedback (opens in a new window or tab)" on the page
	When I choose the "No" radio button
	And I click on the "Why do we ask this?" link
	And I click on the "Back" link
	And I see "Since you turned 13, has your main address been in the UK, Channel Islands or Isle of Man for any period of at least 5 years?" on the page
	And the radio button "Yes" is "Selected"
	And I press the "Continue" button
	Then I see "Have you worked in the criminal justice system in the last 5 years?" on the page
	When I choose the "No" radio button
	And I press the "Continue" button
	
	#Bail
	And I see "steps/qualify/bail" in the URL
	And I see "Are you currently on bail for a criminal offence?" on the page
	And I see "If you're on bail in criminal proceedings, you cannot do jury service." on the page
	And I do not see "Qualifying for jury service" on the page
	And I see "Eligibility" on the page
	And I do not see "Beta" on the page
	And I see "Give feedback (opens in a new window or tab)" on the page
	And I click on the "Back" link
	And I see "Have you worked in the criminal justice system in the last 5 years?" on the page
	And the radio button "No" is "Selected"
	And I press the "Continue" button
	Then I see "Are you currently on bail for a criminal offence?" on the page
	When I choose the "No" radio button
	And I press the "Continue" button
	
	#Convictions
	And I see "steps/qualify/convictions" in the URL
	And I see "Have you been found guilty of a criminal offence?" on the page
	And I do not see "Qualifying for jury service" on the page
	When I see "Eligibility" on the page
	And I do not see "Beta" on the page
	And I see "Give feedback (opens in a new window or tab)" on the page
	And I click on the "Back" link
	And I see "Are you currently on bail for a criminal offence?" on the page
	And the radio button "No" is "Selected"
	And I press the "Continue" button
	And I see "Have you been found guilty of a criminal offence?" on the page
	When I choose the "No" radio button
	And I press the "Continue" button
		
	#Mental Health Sectioned
	And I see "steps/qualify/mental-health-sectioned" in the URL
	And I see "Are you being detained, looked after or treated under the Mental Health Act?" on the page
	And I do not see "Qualifying for jury service" on the page
	When I see "Eligibility" on the page
	And I do not see "Beta" on the page
	And I see "Give feedback (opens in a new window or tab)" on the page
	And I click on the "Back" link
	And I see "Have you been found guilty of a criminal offence?" on the page
	And the radio button "No" is "Selected"
	And I press the "Continue" button
	And I see "Are you being detained, looked after or treated under the Mental Health Act?" on the page
	And I choose the "No" radio button
	And I press the "Continue" button
	
	#Mental Health Capacity
	And I see "steps/qualify/mental-health-capacity" in the URL
	Then I see "Has it been decided that you 'lack mental capacity'?" on the page
	And I do not see "Qualifying for jury service" on the page
	When I see "Eligibility" on the page
	And I do not see "Beta" on the page
	And I see "Give feedback (opens in a new window or tab)" on the page
	And I click on the "Back" link
	And I see "Are you being detained, looked after or treated under the Mental Health Act?" on the page
	And the radio button "No" is "Selected"
	And I press the "Continue" button
	And I see "Has it been decided that you 'lack mental capacity'?" on the page
	And I choose the "No" radio button
	And I press the "Continue" button
	Then I see "Check your start date" on the page
	And I do not see "Eligibility" on the page
	
	#I can attend
	And I do not see "Beta" on the page
	And I see "Give feedback (opens in a new window or tab)" on the page
	And I see "10:00am" on the page
	And I set the radio button to "Yes, I can start on"
	And  I press the "Continue" button

	#RA no
	Then I see "Will you need help when you're at the court?" on the page
	And I do not see "Beta" on the page
	And I see "Give feedback (opens in a new window or tab)" on the page
	And I click on the "Back" link
	Then I see "Check your start date" on the page
	And the radio button "Yes, I can start on" is "Selected"
	And I press the "Continue" button
	Then I see "Will you need help when you're at the court?" on the page
	When I choose the "No" radio button
	And I press the "Continue" button
	Then I see "Check your answers now" on the page
	
	#Check your answers
	And I see "You answered the eligibility questions" on the page
	And I do not see "Beta" on the page
	And I see "Give feedback (opens in a new window or tab)" on the page
	When I see text "No" in the same row as "Are you being detained, looked after or treated under the Mental Health Act?"
	And I see text "No" in the same row as "Has it been decided that you 'lack mental capacity'?"
	And I see "I understand that the answers I have given may be checked and that I may be prosecuted if I have given false information on purpose." on the page
	And I check the "The information I have given is true to the best of my knowledge" checkbox
	And I press the "Submit" button
	Then I see "We have sent you an email to say you have replied to your jury summons." on the page
	And I see "Download a copy of your summons reply PDF (65KB)" on the page
	Then I click on the "Download a copy of your summons reply HTML (15KB)" link
	And I see "You answered the eligibility questions" on the page
	
	Given I am on "Bureau" "test"
	And I log in as "MODTESTBUREAU"
	
	When I click on the "Search" link
	And I set "Juror number" to "<juror_number>"
	And I press the "Search" button
	Then I see "<juror_number>" on the page

	Then I see "<juror_number>" has reply type indicator "Completed"
	
Examples:
	|juror_number	|last_name			|postcode	|email 		|pool_number|
	|045200069		|LNAMETHREEFOURNINE	|SY2 6LU	|a@eeee.com	|452300068	|
	

@Regression @NewSchemaConverted
Scenario Outline: English 1st Party Straight Through Change Links
	
	Given I am on "Public" "test"

	Given a bureau owned pool is created with jurors
		| court |juror_number  | pool_number	| att_date_weeks_in_future	| owner |
		| 452   |<juror_number>| <pool_number>	| 5				            | 400	|
		
	And juror "<juror_number>" has "LAST_NAME" as "<last_name>" new schema
	And juror "<juror_number>" has "POSTCODE" as "<postcode>" new schema

	And I set the radio button to "I am replying for myself"

	And I press the "Continue" button

	When I set "9-digit juror number" to "<juror_number>"
	And I set "Juror last name" to "<last_name>"
	And I set "Juror postcode" to "<postcode>"
	And I press the "Continue" button

	And I choose the "Yes" radio button
	
	And I press the "Continue" button

	And I choose the "Yes" radio button
	
	When I press the "Continue" button

	When I set "Main phone" to "02078211818"

	And I press the "Continue" button
	
	When I set "Enter your email address" to "<email>"
	When I set "Enter your email address again" to "<email>"

	And I press the "Continue" button

	When I set "Day" to "01"
	And I set "Month" to "01"
	And I set "Year" to "1990"
	And I press the "Continue" button

	#Qualify for jury service
	#JDB-4636
	Then I see "Confirm you're eligible for jury service" on the page
	And I do not see "Qualifying for jury service" on the page
	And I see "Your answers in this next section will help us check if you can do jury service or not." on the page
	And I see "You must answer these questions even if you:" on the page
	And I see "think you’re not eligible" on the page
	And I see "want to be excused" on the page
	And I see "You can ask for an excusal after this section, if needed." on the page

	When I press the "Continue" button

	#Residency
	And I see "Since you turned 13, has your main address been in the UK, Channel Islands or Isle of Man for any period of at least 5 years?" on the page
	And I see "steps/qualify/residency" in the URL
	And I do not see "Qualifying for jury service" on the page
	When I see "Eligibility" on the page

	And I choose the "Yes" radio button
	And I press the "Continue" button
	
	#CJS no
	Then I see "Have you worked in the criminal justice system in the last 5 years?" on the page
	And I see "steps/qualify/cjs-employed" in the URL
	When I see "Eligibility" on the page
	And I do not see "Qualifying for jury service" on the page
	
	When I choose the "No" radio button
	And I press the "Continue" button
	
	#Bail
	And I see "steps/qualify/bail" in the URL
	And I see "Are you currently on bail for a criminal offence?" on the page
	And I do not see "Qualifying for jury service" on the page
	And I see "Eligibility" on the page

	When I choose the "No" radio button
	And I press the "Continue" button
	
	#Convictions
	And I see "steps/qualify/convictions" in the URL
	And I see "Have you been found guilty of a criminal offence?" on the page
	And I do not see "Qualifying for jury service" on the page
	When I see "Eligibility" on the page

	When I choose the "No" radio button
	And I press the "Continue" button
		
	#Mental Health Sectioned
	And I see "steps/qualify/mental-health-sectioned" in the URL
	And I see "Are you being detained, looked after or treated under the Mental Health Act?" on the page
	And I do not see "Qualifying for jury service" on the page
	When I see "Eligibility" on the page

	And I choose the "No" radio button
	And I press the "Continue" button
	
	#Mental Health Capacity
	And I see "steps/qualify/mental-health-capacity" in the URL
	Then I see "Has it been decided that you 'lack mental capacity'?" on the page
	And I do not see "Qualifying for jury service" on the page
	When I see "Eligibility" on the page

	And I choose the "No" radio button
	And I press the "Continue" button
	
	#I can attend
	Then I see "Check your start date" on the page
	And I do not see "Eligibility" on the page

	And I see "Yes, I can start on" on the page
	And I set the radio button to "Yes, I can start on"
	And  I press the "Continue" button

	#RA no
	Then I see "Will you need help when you're at the court?" on the page

	When I choose the "No" radio button
	And I press the "Continue" button
	
	#Check your answers
	Then I see "Check your answers now" on the page
	And I see "You answered the eligibility questions" on the page
	
	#change links
	When I click on the "Change" link in the same row as "Since you turned 13, has your main address been in the UK, Channel Islands or Isle of Man for any period of at least 5 years?"
	Then I see "Since you turned 13, has your main address been in the UK, Channel Islands or Isle of Man for any period of at least 5 years?" on the page
	When I see "Eligibility" on the page
	When I choose the "No" radio button
	And I set "Provide details" to "Residency information"
	And I press the "Continue" button
	Then I see text "No - Residency information" in the same row as "Since you turned 13, has your main address been in the UK, Channel Islands or Isle of Man for any period of at least 5 years?"

	When I click on the "Change" link in the same row as "Have you worked in the criminal justice system in the last 5 years?"
	Then I see "Have you worked in the criminal justice system in the last 5 years?" on the page
	When I see "Eligibility" on the page
	When I choose the "Yes" radio button
	And I check the "Police service" checkbox
	And I set "Which police service?" to "London Met Police"
	And I press the "Continue" button
	Then I see text "London Met Police" in the same row as "Have you worked in the criminal justice system in the last 5 years?"
	
	When I click on the "Change" link in the same row as "Are you being detained, looked after or treated under the Mental Health Act?"
	Then I see "Are you being detained, looked after or treated under the Mental Health Act?" on the page
	When I see "Eligibility" on the page
	When I choose the "Yes" radio button
	And I set "Provide details" to "I am sectioned and detained"
	And I press the "Continue" button
	Then I see text "Yes - I am sectioned and detained" in the same row as "Are you being detained, looked after or treated under the Mental Health Act?"

	When I click on the "Change" link in the same row as "Has it been decided that you 'lack mental capacity'?"
	Then I see "Has it been decided that you 'lack mental capacity'?" on the page
	When I see "Eligibility" on the page
	When I choose the "Yes" radio button
	And I set "Provide brief details about why it was decided you lack mental capacity" to "I lack capacity"
	And I press the "Continue" button
	Then I see text "Yes - I lack capacity" in the same row as "Has it been decided that you 'lack mental capacity'?"
	
	When I click on the "Change" link in the same row as "Are you currently on bail for a criminal offence?"
	Then I see "Are you currently on bail for a criminal offence?" on the page
	When I see "Eligibility" on the page
	When I choose the "Yes" radio button
	And I set "Provide details" to "I am on bail for crimes"
	And I press the "Continue" button
	Then I see text "Yes - I am on bail for crimes" in the same row as "Are you currently on bail for a criminal offence?"
	
	When I click on the "Change" link in the same row as "Have you been convicted of a criminal offence and been given a sentence?"
	Then I see "Have you been found guilty of a criminal offence?" on the page
	When I see "Eligibility" on the page
	When I choose the "Yes" radio button
	And I set text area with "id" of "convictedDetails" to "I am a convicted criminal"
	And I press the "Continue" button
	Then I see text "Yes - I am a convicted criminal" in the same row as "Have you been convicted of a criminal offence and been given a sentence?"

	#submit
	And I check the "The information I have given is true to the best of my knowledge" checkbox
	And I press the "Submit" button

	Then I click on the "Download a copy of your summons reply HTML (15KB)" link
	And I see "You answered the eligibility questions" on the page
	
Examples:
	| juror_number	| last_name			| postcode	| email 	| pool_number	|
	| 045200070		| LNAMEONEONENINE	| CH1 2AN	| a@eeee.com| 452300069		|

@Regression @NewSchemaConverted
Scenario Outline: English 1st Party Straight Through Navigate Back
	
	Given I am on "Public" "test"

	Given a bureau owned pool is created with jurors
		| court |juror_number  | pool_number	| att_date_weeks_in_future	| owner |
		| 452   |<juror_number>| <pool_number>	| 5				            | 400	|
		
	And juror "<juror_number>" has "LAST_NAME" as "<last_name>" new schema
	And juror "<juror_number>" has "POSTCODE" as "<postcode>" new schema

	And I set the radio button to "I am replying for myself"

	And I press the "Continue" button

	When I set "9-digit juror number" to "<juror_number>"
	And I set "Juror last name" to "<last_name>"
	And I set "Juror postcode" to "<postcode>"
	And I press the "Continue" button

	And I choose the "Yes" radio button
	
	And I press the "Continue" button

	And I choose the "Yes" radio button
	
	When I press the "Continue" button

	When I set "Main phone" to "02078211818"

	And I press the "Continue" button
	
	When I set "Enter your email address" to "<email>"
	When I set "Enter your email address again" to "<email>"

	And I press the "Continue" button

	When I set "Day" to "01"
	And I set "Month" to "01"
	And I set "Year" to "1990"
	And I press the "Continue" button

	#Qualify for jury service
	#JDB-4636
	Then I see "Confirm you're eligible for jury service" on the page
	And I do not see "Qualifying for jury service" on the page
	And I see "Your answers in this next section will help us check if you can do jury service or not." on the page
	And I see "You must answer these questions even if you:" on the page
	And I see "think you’re not eligible" on the page
	And I see "want to be excused" on the page
	And I see "You can ask for an excusal after this section, if needed." on the page

	When I press the "Continue" button

	#Residency
	And I see "Since you turned 13, has your main address been in the UK, Channel Islands or Isle of Man for any period of at least 5 years?" on the page
	And I see "steps/qualify/residency" in the URL
	And I do not see "Qualifying for jury service" on the page
	When I see "Eligibility" on the page

	And I choose the "Yes" radio button
	And I press the "Continue" button
	
	#CJS no
	Then I see "Have you worked in the criminal justice system in the last 5 years?" on the page
	And I see "steps/qualify/cjs-employed" in the URL
	When I see "Eligibility" on the page
	And I do not see "Qualifying for jury service" on the page
	
	When I choose the "No" radio button
	And I press the "Continue" button
	
	#Bail
	And I see "steps/qualify/bail" in the URL
	And I see "Are you currently on bail for a criminal offence?" on the page
	And I do not see "Qualifying for jury service" on the page
	And I see "Eligibility" on the page

	When I choose the "No" radio button
	And I press the "Continue" button
	
	#Convictions
	And I see "steps/qualify/convictions" in the URL
	And I see "Have you been found guilty of a criminal offence?" on the page
	And I do not see "Qualifying for jury service" on the page
	When I see "Eligibility" on the page

	When I choose the "No" radio button
	And I press the "Continue" button
		
	#Mental Health Sectioned
	And I see "steps/qualify/mental-health-sectioned" in the URL
	And I see "Are you being detained, looked after or treated under the Mental Health Act?" on the page
	And I do not see "Qualifying for jury service" on the page
	When I see "Eligibility" on the page

	And I choose the "No" radio button
	And I press the "Continue" button
	
	#Mental Health Capacity
	And I see "steps/qualify/mental-health-capacity" in the URL
	Then I see "Has it been decided that you 'lack mental capacity'?" on the page
	And I do not see "Qualifying for jury service" on the page
	When I see "Eligibility" on the page

	And I choose the "No" radio button
	And I press the "Continue" button
	
	Then I see "Check your start date" on the page

	#navigate back
	And I click on the "Back" link
	Then I see "Has it been decided that you 'lack mental capacity'?" on the page
	And the radio button "No" is "Selected"
	
	And I click on the "Back" link
	Then I see "Are you being detained, looked after or treated under the Mental Health Act?" on the page
	And the radio button "No" is "Selected"
	
	And I click on the "Back" link
	Then I see "Have you been found guilty of a criminal offence?" on the page
	And the radio button "No" is "Selected"
	
	And I click on the "Back" link
	Then I see "Are you currently on bail for a criminal offence?" on the page
	And the radio button "No" is "Selected"
	
	And I click on the "Back" link
	Then I see "Have you worked in the criminal justice system in the last 5 years?" on the page
	And the radio button "No" is "Selected"
	
	And I click on the "Back" link
	Then I see "Since you turned 13, has your main address been in the UK, Channel Islands or Isle of Man for any period of at least 5 years?" on the page
	And the radio button "Yes" is "Selected"
	
	#navigate forward
	And I press the "Continue" button
	
	Then I see "Have you worked in the criminal justice system in the last 5 years?" on the page
	And the radio button "No" is "Selected"
	
	And I press the "Continue" button
	
	Then I see "Are you currently on bail for a criminal offence?" on the page
	And the radio button "No" is "Selected"
	
	And I press the "Continue" button
	
	Then I see "Have you been found guilty of a criminal offence?" on the page
	And the radio button "No" is "Selected"
	
	And I press the "Continue" button
	
	Then I see "Are you being detained, looked after or treated under the Mental Health Act?" on the page
	And the radio button "No" is "Selected"
	
	And I press the "Continue" button
	
	Then I see "Has it been decided that you 'lack mental capacity'?" on the page
	And the radio button "No" is "Selected"
	
	
	And I press the "Continue" button
	
	#I can attend
	Then I see "Check your start date" on the page
	And I do not see "Eligibility" on the page

	And I see "Yes, I can start on" on the page
	And I set the radio button to "Yes, I can start on"
	And I press the "Continue" button

	#RA no
	Then I see "Will you need help when you're at the court?" on the page

	When I choose the "No" radio button
	
	And I press the "Continue" button
	
	#Check your answers
	Then I see "Check your answers now" on the page
	And I see "You answered the eligibility questions" on the page
	
	#submit
	And I check the "The information I have given is true to the best of my knowledge" checkbox
	And I press the "Submit" button

	Then I click on the "Download a copy of your summons reply HTML (15KB)" link
	And I see "You answered the eligibility questions" on the page
	
Examples:
	| juror_number	| last_name			| postcode	| email 	| pool_number	|
	| 045200071		| LNAMEONEONENINE	| CH1 2AN	| a@eeee.com| 452300070		|


	@Features @PCQ @NewSchemaConverted
	Scenario Outline: English 1st Party PCQ - decline to answer

		Given I am on "Public" "test"

		Given a bureau owned pool is created with jurors
			| court |juror_number  | pool_number	| att_date_weeks_in_future	| owner |
			| 452   |<juror_number>| <pool_number>	| 5				            | 400	|

		And juror "<juror_number>" has "LAST_NAME" as "<last_name>" new schema
		And juror "<juror_number>" has "POSTCODE" as "<postcode>" new schema

		Given auto straight through processing has been enabled new schema

		And I set the radio button to "I am replying for myself"
		And I press the "Continue" button
		When I set "9-digit juror number" to "<juror_number>"
		And I set "Juror last name" to "<last_name>"
		And I set "Juror postcode" to "<postcode>"
		And I press the "Continue" button

		#name
		And I choose the "Yes" radio button
		And I press the "Continue" button

		#address
		And I choose the "Yes" radio button
		When I press the "Continue" button

		#phone
		When I set "Main phone" to "02078211818"
		When I press the "Continue" button

		#email
		When I set "Enter your email address" to "<email>"
		When I set "Enter your email address again" to "<email>"
		And I press the "Continue" button

		#dob
		When I set "Day" to "01"
		And I set "Month" to "01"
		And I set "Year" to "1990"
		And I press the "Continue" button

		#Qualify for jury service
		When I press the "Continue" button

		#Residency
		And I choose the "Yes" radio button
		And I press the "Continue" button

		#CJS no
		When I choose the "No" radio button
		And I press the "Continue" button

		#Bail
		When I choose the "No" radio button
		And I press the "Continue" button

		#Convictions
		When I choose the "No" radio button
		And I press the "Continue" button

		#Mental Health Sectioned
		And I choose the "No" radio button
		And I press the "Continue" button

		#Mental Health Capacity
		And I choose the "No" radio button
		And I press the "Continue" button

		#I can attend
		And I set the radio button to "Yes, I can start on"
		And  I press the "Continue" button

		#RA no
		When I choose the "No" radio button
		Given PCQs has been enabled new schema
		And I press the "Continue" button
		Given PCQs has been disabled new schema

		#PCQ
		Then on the page I see
			| text	|
			| Equality and diversity questions |
			| These are optional questions about you |
			| Your answers won't affect your Jury Summons Reply |
			| Your answers will help us check we are treating people fairly and equally |
			| Find out how we use this information in our privacy policy |

	 	#Decline to answer
		Then I press the "I don" button

		#Check your answers
		Then I see "Check your answers" on the page
		And I check the "The information I have given is true to the best of my knowledge" checkbox
		And I press the "Submit" button
		Then I see "We have sent you an email to say you have replied to your jury summons." on the page
		And I see "Download a copy of your summons reply PDF (65KB)" on the page

		Examples:
			| juror_number	| last_name			| postcode	| email 		| pool_number	|
			| 045200072		| LNAMETHREEFOURNINE| SY2 6LU	| a@eeee.com	| 452300071		|

	@Features @PCQ @NewSchemaConverted
	Scenario Outline: English 1st Party PCQ - answer questions

		Given I am on "Public" "test"

		Given a bureau owned pool is created with jurors
			| court |juror_number  | pool_number	| att_date_weeks_in_future	| owner |
			| 452   |<juror_number>| <pool_number>	| 5				            | 400	|

		And juror "<juror_number>" has "LAST_NAME" as "<last_name>" new schema
		And juror "<juror_number>" has "POSTCODE" as "<postcode>" new schema

		Given auto straight through processing has been enabled new schema

		And I set the radio button to "I am replying for myself"
		And I press the "Continue" button
		When I set "9-digit juror number" to "<juror_number>"
		And I set "Juror last name" to "<last_name>"
		And I set "Juror postcode" to "<postcode>"
		And I press the "Continue" button

		#name
		And I choose the "Yes" radio button
		And I press the "Continue" button

		#address
		And I choose the "Yes" radio button
		When I press the "Continue" button

		#phone
		When I set "Main phone" to "02078211818"
		When I press the "Continue" button

		#email
		When I set "Enter your email address" to "<email>"
		When I set "Enter your email address again" to "<email>"
		And I press the "Continue" button

		#dob
		When I set "Day" to "01"
		And I set "Month" to "01"
		And I set "Year" to "1990"
		And I press the "Continue" button

		#Qualify for jury service
		When I press the "Continue" button

		#Residency
		And I choose the "Yes" radio button
		And I press the "Continue" button

		#CJS no
		When I choose the "No" radio button
		And I press the "Continue" button

		#Bail
		When I choose the "No" radio button
		And I press the "Continue" button

		#Convictions
		When I choose the "No" radio button
		And I press the "Continue" button

		#Mental Health Sectioned
		And I choose the "No" radio button
		And I press the "Continue" button

		#Mental Health Capacity
		And I choose the "No" radio button
		And I press the "Continue" button

		#I can attend
		And I set the radio button to "Yes, I can start on"
		And  I press the "Continue" button

		#RA no
		When I choose the "No" radio button
		Given PCQs has been enabled new schema
		And I press the "Continue" button
		Given PCQs has been disabled new schema

		#PCQ
		Then on the page I see
			|text|
			|Equality and diversity questions|
			|These are optional questions about you|
			|Your answers won't affect your Jury Summons Reply|
			|Your answers will help us check we are treating people fairly and equally|
			|Find out how we use this information in our privacy policy|

		Then I press the "Continue to the questions" button

		Then I see "What is your main language?" on the page
		And I press the "Continue" button

		Then I see "What is your sex?" on the page
		And I press the "Continue" button

		Then I see "Is your gender the same as the sex you were registered at birth?" on the page
		And I press the "Continue" button

		Then I see "Which of the following best describes how you think of yourself?" on the page
		And I press the "Continue" button

		Then I see "Are you married or in a legally registered civil partnership?" on the page
		And I press the "Continue" button

		Then I see "What is your ethnic group?" on the page
		And I press the "Continue" button

		Then I see "What is your religion?" on the page
		And I press the "Continue" button

		Then I see "Do you have any physical or mental health conditions or illnesses lasting or expected to last 12 months or more?" on the page
		And I press the "Continue" button

		Then I see "Are you pregnant or have you been pregnant in the last year?" on the page
		And I press the "Continue" button

		Then I see "You have answered the equality questions" on the page
		And I see "The next steps are to check your Jury Summons Reply details." on the page
		And I press the "Continue to the next steps" button

		Then I see "Check your answers" on the page

		When I click on the "Change" link in the same row as "Do you have a disability or impairment that means you'll need extra support or facilities in the court building where you are doing your Jury Service?"
		Then I choose the "No" radio button
		And I press the "Continue" button

	#do not see pcqs again
		Then I see "Check your answers" on the page

	#Check your answers
		And I check the "The information I have given is true to the best of my knowledge" checkbox
		And I press the "Submit" button
		Then I see "We have sent you an email to say you have replied to your jury summons." on the page
		And I see "Download a copy of your summons reply PDF (65KB)" on the page

		Examples:
			| juror_number	| last_name			| postcode	| email 	| pool_number	|
			| 045200073		| LNAMETHREEFOURNINE| SY2 6LU	| a@eeee.com| 452300072		|

	@Features @PCQ @NewSchemaConverted
	Scenario Outline: English 1st Party PCQ - cancel out of questions

		Given I am on "Public" "test"

		Given a bureau owned pool is created with jurors
			| court |juror_number  | pool_number	| att_date_weeks_in_future	| owner |
			| 452   |<juror_number>| <pool_number>	| 5				            | 400	|

		And juror "<juror_number>" has "LAST_NAME" as "<last_name>" new schema
		And juror "<juror_number>" has "POSTCODE" as "<postcode>" new schema

		Given auto straight through processing has been enabled new schema

		And I set the radio button to "I am replying for myself"
		And I press the "Continue" button
		When I set "9-digit juror number" to "<juror_number>"
		And I set "Juror last name" to "<last_name>"
		And I set "Juror postcode" to "<postcode>"
		And I press the "Continue" button

		#name
		And I choose the "Yes" radio button
		And I press the "Continue" button

		#address
		And I choose the "Yes" radio button
		When I press the "Continue" button

		#phone
		When I set "Main phone" to "02078211818"
		When I press the "Continue" button

		#email
		When I set "Enter your email address" to "<email>"
		When I set "Enter your email address again" to "<email>"
		And I press the "Continue" button

		#dob
		When I set "Day" to "01"
		And I set "Month" to "01"
		And I set "Year" to "1990"
		And I press the "Continue" button

		#Qualify for jury service
		When I press the "Continue" button

		#Residency
		And I choose the "Yes" radio button
		And I press the "Continue" button

		#CJS no
		When I choose the "No" radio button
		And I press the "Continue" button

		#Bail
		When I choose the "No" radio button
		And I press the "Continue" button

		#Convictions
		When I choose the "No" radio button
		And I press the "Continue" button

		#Mental Health Sectioned
		And I choose the "No" radio button
		And I press the "Continue" button

		#Mental Health Capacity
		And I choose the "No" radio button
		And I press the "Continue" button

		#I can attend
		And I set the radio button to "Yes, I can start on"
		And  I press the "Continue" button

		#RA no
		When I choose the "No" radio button
		Given PCQs has been enabled new schema
		And I press the "Continue" button
		Given PCQs has been disabled new schema
		
		#PCQ
		Then on the page I see
			|text|
			|Equality and diversity questions|
			|These are optional questions about you|
			|Your answers won't affect your Jury Summons Reply|
			|Your answers will help us check we are treating people fairly and equally|
			|Find out how we use this information in our privacy policy|

		Then I press the "Continue to the questions" button

		Then I see "What is your main language?" on the page

		Then I click on the "Back" link

		Then I see "Equality and diversity questions" on the page

		Then I press the "I don" button

		#Check your answers
		Then I see "Check your answers" on the page
		And I check the "The information I have given is true to the best of my knowledge" checkbox
		And I press the "Submit" button
		Then I see "We have sent you an email to say you have replied to your jury summons." on the page
		And I see "Download a copy of your summons reply PDF (65KB)" on the page

		Examples:
			| juror_number	| last_name			| postcode	| email 		| pool_number	|
			| 045200074		| LNAMETHREEFOURNINE| SY2 6LU	| a@eeee.com	| 452300073		|

	@RegressionSingle @PCQ @NewSchemaConverted
	Scenario Outline: English 3rd Party PCQ - questions do not appear

		Given I am on "Public" "test"

		Given a bureau owned pool is created with jurors
			| court |juror_number  | pool_number	| att_date_weeks_in_future	| owner |
			| 452   |<juror_number>| <pool_number>	| 5				            | 400	|

		And juror "<juror_number>" has "LAST_NAME" as "<last_name>" new schema
		And juror "<juror_number>" has "POSTCODE" as "<postcode>" new schema

		Given auto straight through processing has been enabled new schema

		And I set the radio button to "I am replying for someone else"
		And I press the "Continue" button

	#Juror Log In
		When I set "9-digit juror number" to "<juror_number>"
		When I set "Juror last name" to "<last_name>"
		When I set "Juror postcode" to "<postcode>"
		And I press the "Continue" button

	#3rd Party Name
		And I set "First name" to "FirstNameB"
		And I set "Last name" to "LastNameB"
		And I press the "Continue" button

	#Relationship to juror
		And I set "How do you know the person you're replying for?" to "Friend"
		And I press the "Continue" button

	#3rd Party Contact
		And I check the "By phone (UK Numbers only)" checkbox
		And I set "Main phone" to "0207 821 1818"
		And I check the "By email" checkbox
		And I set "Enter your email address" to "email@outlook.com"
		And I set "Enter your email address again" to "email@outlook.com"
		And I press the "Continue" button

	#Why Replying
		When I set the radio button to "The person is not here"
		And I press the "Continue" button

	#Check juror name
		And I choose the "Yes" radio button
		And I press the "Continue" button

	#Check juror address
		And I choose the "Yes" radio button
		And I press the "Continue" button

	#DoB
		And I set "Day" to "01"
		And I set "Month" to "01"
		And I set "Year" to "2000"
		And I press the "Continue" button

	#Contacting the juror
		And I set the radio button to "Use the phone number that you have already given to contact you"
		And I set the radio button to "Use the email address that you have already given to contact you"
		And I press the "Continue" button

	#Qualify for jury service
		When I press the "Continue" button

	#Residency
		And I choose the "Yes" radio button
		And I press the "Continue" button

	#CJS no
		When I choose the "No" radio button
		And I press the "Continue" button

	#Bail
		When I choose the "No" radio button
		And I press the "Continue" button

	#Convictions
		When I choose the "No" radio button
		And I press the "Continue" button

	#Mental Health Sectioned
		And I choose the "No" radio button
		And I press the "Continue" button

	#Mental Health Capacity
		And I choose the "No" radio button
		And I press the "Continue" button

	#The person can attend
		Then I set the radio button to "Yes, they can start on"
		And  I press the "Continue" button

	#RA no
		When I choose the "No" radio button
		Given PCQs has been enabled new schema
		And I press the "Continue" button
		Given PCQs has been disabled new schema

	#Check your answers
		Then I see "Check your answers now" on the page
		And I see "steps/confirm-information/tp" in the URL
		And I see "You answered the eligibility questions for the person you're replying for" on the page

		When I check the "The answers I have given for the person I'm replying for are true as far as I know." checkbox
		And I press the "Submit" button

	#When I press the "Submit" button
		And I see "steps/confirmation/tp" in the URL
		And I see "Give feedback (opens in a new window or tab)" on the page
		Then I see "We have sent an email to say you have replied to this jury summons." on the page
		And I see "Download a copy of your summons reply PDF (65KB)" on the page

		Examples:
			|juror_number	|last_name			|postcode	|email 		|pool_number|
			|645200349		|LNAMETHREEFOURNINE	|SY2 6LU	|a@eeee.com	|452170401	|

	@Features @PCQ @NewSchemaConverted
	Scenario Outline: Welsh 1st Party PCQ - answer questions

		Given I am on the welsh version of "Public" "test"

		Given auto straight through processing has been enabled new schema

		Given a bureau owned pool is created with jurors
			| court | juror_number  | pool_number	| att_date_weeks_in_future	| owner |
			| 457   | <juror_number>| <pool_number>	| 5				            | 400	|

		And juror "<juror_number>" has "LAST_NAME" as "<last_name>" new schema
		And juror "<juror_number>" has "POSTCODE" as "<postcode>" new schema

		And I set the radio button to "n ymateb dros fy hun"
		And I press the "Parhau" button

	#Login
		When I set "Rhif rheithiwr" to "<juror_number>"
		When I set "Cyfenw" to "<last_name>"
		When I set "Cod post Rheithiwr" to "<postcode>"
		And I press the "Parhau" button

	#Check Your Name
		And I set the radio button to "Ydy"
		And I press the "Parhau" button

	#Check Your Address
		And I set the radio button to "Ie"
		When I press the "Parhau" button

	#Phone
		When I set "Prif rif ffôn" to "0207 821 1818"
		And I press the "Parhau" button

	#Email
		And I set "Nodwch eich cyfeiriad e-bost" to "<email>"
		And I set "Nodwch eich cyfeiriad e-bost eto" to "<email>"
		And I press the "Parhau" button

	#DoB
		When I set "Diwrnod" to "27"
		And I set "Mis" to "04"
		And I set "Blwyddyn" to "1978"
		And I press the "Parhau" button

	#Qualify for jury service
		When I press the "Parhau" button

	#Residency
		And I set the radio button to "Do"
		And I press the "Parhau" button

	#CJS
		When I set the radio button to "Nac ydw"
		And I press the "Parhau" button

	#Bail
		And I set the radio button to "Nac ydw"
		And I press the "Parhau" button

	#Convictions
		When I set the radio button to "Naddo"
		And I press the "Parhau" button

	#Mental Health Sectioned
		And I set the radio button to "Na"
		And I press the "Parhau" button
		Then I see "A benderfynwyd nad oes gennych y gallu meddyliol?" on the page

	#Mental Health Capacity
		And I set the radio button to "Na"
		And I press the "Parhau" button

	#Confirm attendance
		When I set the radio button to "n gallu dechrau"
		And I press the "Parhau" button

	#RA
		When I set the radio button to "Nac oes"
		Given PCQs has been enabled new schema
		And I press the "Parhau" button
		Given PCQs has been disabled new schema

		#PCQ
		Then on the page I see
			|text|
			|Cwestiynau am Gydraddoldeb ac Amrywiaeth|
			|Cwestiynau dewisol amdanoch chi yw’r rhain|
			|Ni fydd eich atebion yn effeithio ar eich Ymateb i’r Wŷs Reithgor|
			|Bydd eich atebion yn ein helpu i wneud yn siŵr ein bod yn trin pobl yn deg ac yn gyfartal|
			|Gallwch ddarganfod sut rydym yn defnyddio’r wybodaeth hon yn ein polisi preifatrwydd.|

		Then I press the "Ymlaen i" button

		Then I see "Beth yw eich iaith gyntaf?" on the page
		And I press the "Parhau" button

		Then I see "Beth yw eich rhyw?" on the page
		And I press the "Parhau" button

		Then I see "A yw eich rhywedd yr un fath â’r rhyw pan gawsoch eich geni?" on the page
		And I press the "Parhau" button

		Then I see "Pa un o'r canlynol sy'n disgrifio orau sut yr ydych yn meddwl amdanoch chi’ch hun?" on the page
		And I press the "Parhau" button

		Then I see "Ydych chi wedi priodi/mewn partneriaeth sifil a gofrestrwyd yn gyfreithiol?" on the page
		And I press the "Parhau" button

		Then I see "Beth yw eich grŵp ethnig?" on the page
		And I press the "Parhau" button

		Then I see "Beth yw eich crefydd?" on the page
		And I press the "Parhau" button

		Then I see "A oes gennych unrhyw gyflwr neu salwch corfforol neu iechyd meddwl sydd wedi para neu sy’n debygol o bara 12 mis neu fwy?" on the page
		And I press the "Parhau" button

		Then I see "A ydych chi’n feichiog neu wedi rhoi genedigaeth yn y flwyddyn ddiwethaf?" on the page
		And I press the "Parhau" button

		Then I see "Rydych wedi ateb y cwestiynau am gydraddoldeb" on the page
		And I see "Y cam nesaf yw gwirio manylion eich Ymateb i’r Wŷs Reithgor." on the page

		And I press the "Symud ymlaen" button

	#Check your answers
		And I see "Gwiriwch eich ymatebion nawr" on the page

	#submit
		And I check the "Mae'r wybodaeth a roddais uchod yn wir hyd eithaf fy ngwybodaeth." checkbox
		And I press the "Cyflwyno" button

		Then I see "O leiaf 2 wythnos cyn ichi ddechrau gwasanaethu ar reithgor, byddwn yn anfon y canlynol atoch:" on the page
		Then I do not see "Yna, o leiaf pythefnos cyn i’r gwasanaeth rheithgor ddechrau byddwn yn anfon y dogfennau canlynol atoch:" on the page
		Then I see "Gallwch wylio fideo am beth sy'n digwydd wrth fod yn rheithiwr ar YouTube, fel eich bod yn gwybod beth i'w ddisgwyl. Mae'r fideo'n para 13 munud." on the page

		And I see "Lawrlwythwch gopi o'ch ymateb i'r wŷs HTML (15KB)" on the page
		Then I click on the "HTML (15KB)" link
		And I see "Mi wnaethoch ateb y cwestiynau cymhwysedd" on the page

		Examples:
			| juror_number	| last_name	| postcode	| email 		| pool_number	|
			| 045700029		| LastNameB	| CH1 2AN	| e@mail.com	| 457300029		|