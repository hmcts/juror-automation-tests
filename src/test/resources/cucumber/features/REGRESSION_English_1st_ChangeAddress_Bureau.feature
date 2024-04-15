Feature: Regression English_1st_ChangeAddress_Bureau

@Regression @NewSchemaConverted
Scenario Outline: Change postcode - old postcode in >1 loc_code SHOWS CHANGE COURT
	
	#2. Change postcode - old postcode in >1 loc_code
	#SY2 - CH1
	#SY2=LOC_CODE 452 and 774
	#CH1=LOC_CODE 415

	Given I am on "Public" "test"

	Given a bureau owned pool is created with jurors
		| court |juror_number  | pool_number	| att_date_weeks_in_future	| owner |
		| 452   |<juror_number>| <pool_number>	| 5				            | 400	|
		
	And juror "<juror_number>" has "LAST_NAME" as "<last_name>" new schema
	And juror "<juror_number>" has "POSTCODE" as "<postcode>" new schema
	
	Then I see "Reply to a jury summons" on the page
	
	And I set the radio button to "I am replying for myself"
	And I press the "Continue" button
	And I set "9-digit juror number" to "<juror_number>"
	And I set "Juror last name" to "<last_name>"
	And I set "Juror postcode" to "<postcode>"
	And I press the "Continue" button

	#name
	And I choose the "Yes" radio button
	And I press the "Continue" button
	
	#address
	Then I see "Is this your address?" on the page
	And I choose the "No" radio button
	And I press the "Continue" button
	And I set "Postcode" to "CH1 2AN"
	And I press the "Continue" button
	
	#phone
	Then I see "What is your phone number?" on the page
	When I set "Main phone" to "02078211818"
	And I press the "Continue" button

	#email
	Then I see "What is your email address?" on the page
	When I set "Enter your email address" to "<email>"
	When I set "Enter your email address again" to "<email>"
	And I press the "Continue" button

	#DOB
	Then I see "What is your date of birth?" on the page
	When I set "Day" to "27"
	And I set "Month" to "04"
	And I set "Year" to "1981"
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
	
	#Check your answers
	Then I see "Check your answers now" on the page
	When I check the "The information I have given is true to the best of my knowledge" checkbox
	And I press the "Submit" button
	Then I see "We have sent you an email to say you have replied to your jury summons." on the page
	
	#bureau
	Given I am on "Bureau" "test"
	When I log in as "MODTESTBUREAU"
	And I click on the "Search" link
	And I set "Juror number" to "<juror_number>"
	And I press the "Search" button
	Then I see "results for “<juror_number>”" on the page
	
	#JDB-3629
	When I click on "<juror_number>" in the same row as "<juror_number>"
	Then I see "CH1 2AN" on the page
	And I see "Change Court" on the page
	
Examples:
	| juror_number	| last_name	| postcode	| email 		| pool_number	|
	| 045200185		| DOE		| SY2 6LU	| a@eeee.com	| 452300170		|
	
@Features @NewSchemaConverted
Scenario Outline: Change Postcode but same loc_code CHANGE COURT FLAG NOT SHOWN

	#moved to Features 02-01-24 return to Regression
	
	#5. Change Postcode but same loc_code
	#SA1 - SA2
	#SA1=LOC_CODE 457
	#SA2=LOC_CODE 457

	Given I am on "Public" "test"

	Given a bureau owned pool is created with jurors
		| court |juror_number  | pool_number	| att_date_weeks_in_future	| owner |
		| 452   |<juror_number>| <pool_number>	| 5				            | 400	|
		
	And juror "<juror_number>" has "LAST_NAME" as "<last_name>" new schema
	And juror "<juror_number>" has "POSTCODE" as "<postcode>" new schema
	
	Then I see "Reply to a jury summons" on the page
	
	And I set the radio button to "I am replying for myself"
	And I press the "Continue" button
	And I set "9-digit juror number" to "<juror_number>"
	And I set "Juror last name" to "<last_name>"
	And I set "Juror postcode" to "<postcode>"
	And I press the "Continue" button

	#name
	When I choose the "Yes" radio button
	And I press the "Continue" button
	
	#address
	Then I see "Is this your address?" on the page
	When I choose the "No" radio button
	And I press the "Continue" button
	
	And I set "Postcode" to "SA2 2AN"
	And I press the "Continue" button
	
	#phone
	Then I see "What is your phone number?" on the page
	When I set "Main phone" to "02078211818"
	And I press the "Continue" button

	#email
	Then I see "What is your email address?" on the page
	When I set "Enter your email address" to "<email>"
	When I set "Enter your email address again" to "<email>"
	And I press the "Continue" button

	#DOB
	Then I see "What is your date of birth?" on the page
	When I set "Day" to "27"
	And I set "Month" to "04"
	And I set "Year" to "1981"
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
	
	#Check your answers
	Then I see "Check your answers now" on the page
	When I check the "The information I have given is true to the best of my knowledge" checkbox
	And I press the "Submit" button
	Then I see "We have sent you an email to say you have replied to your jury summons." on the page
	
	#bureau
	Given I am on "Bureau" "test"
	When I log in as "MODTESTBUREAU"
	And I click on the "Search" link
	And I set "Juror number" to "<juror_number>"
	And I press the "Search" button
	Then I see "results for “<juror_number>”" on the page
	
	#JDB-3629
	When I click on "<juror_number>" in the same row as "<juror_number>"
	Then I see "SA2 2AN" on the page
	And I do not see "Change Court" on the page
	
Examples:
	| juror_number	| last_name	| postcode	| email 		| pool_number	|
	| 045200186		| DOE		| SA1 4EE	| a@eeee.com	| 452300171		|
	
@Regression @NewSchemaConverted
Scenario Outline: Change postcode - different loc_code SHOWS CHANGE COURT
	
	#6. Change postcode - different loc_code
	#WV1 - WA1
	#WV1=LOC_CODE 421
	#WA1=LOC_CODE 462

	Given I am on "Public" "test"

	Given a bureau owned pool is created with jurors
		| court |juror_number  | pool_number	| att_date_weeks_in_future	| owner |
		| 452   |<juror_number>| <pool_number>	| 5				            | 400	|
		
	And juror "<juror_number>" has "LAST_NAME" as "<last_name>" new schema
	And juror "<juror_number>" has "POSTCODE" as "<postcode>" new schema
	
	Then I see "Reply to a jury summons" on the page
	
	And I set the radio button to "I am replying for myself"
	And I press the "Continue" button
	And I set "9-digit juror number" to "<juror_number>"
	And I set "Juror last name" to "<last_name>"
	And I set "Juror postcode" to "<postcode>"
	And I press the "Continue" button

	#name
	And I choose the "Yes" radio button
	And I press the "Continue" button
	
	#address
	Then I see "Is this your address?" on the page
	
	And I choose the "No" radio button
	And I press the "Continue" button
	
	And I set "Postcode" to "WV1 2AN"
	And I press the "Continue" button
	
	#phone
	Then I see "What is your phone number?" on the page
	When I set "Main phone" to "02078211818"
	And I press the "Continue" button

	#email
	Then I see "What is your email address?" on the page
	When I set "Enter your email address" to "<email>"
	When I set "Enter your email address again" to "<email>"
	And I press the "Continue" button

	#DOB
	Then I see "What is your date of birth?" on the page
	When I set "Day" to "27"
	And I set "Month" to "04"
	And I set "Year" to "1981"
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
	
	#Check your answers
	Then I see "Check your answers now" on the page
	When I check the "The information I have given is true to the best of my knowledge" checkbox
	And I press the "Submit" button
	Then I see "We have sent you an email to say you have replied to your jury summons." on the page
	
	#bureau
	Given I am on "Bureau" "test"
	When I log in as "MODTESTBUREAU"
	And I click on the "Search" link
	And I set "Juror number" to "<juror_number>"
	And I press the "Search" button
	Then I see "results for “<juror_number>”" on the page
	
	#JDB-3629
	When I click on "<juror_number>" in the same row as "<juror_number>"
	Then I see "WV1 2AN" on the page
	And I see "Change Court" on the page
	
Examples:
	| juror_number	| last_name	| postcode	| email 		| pool_number	|
	| 045200187		| DOE		| CH1 6LU	| a@eeee.com	| 452300172		|
	
@Regression @NewSchemaConverted
Scenario Outline: Change postcode - new postcode in >1 loc_code SHOWS CHANGE COURT
	
	#1. Change postcode - new postcode in >1 loc_code
	#CH1 - CH2
	#CH1=LOC_CODE 415
	#CH2=LOC_CODE 415 and 715

	Given I am on "Public" "test"

	Given a bureau owned pool is created with jurors
		| court |juror_number  | pool_number	| att_date_weeks_in_future	| owner |
		| 452   |<juror_number>| <pool_number>	| 5				            | 400	|
		
	And juror "<juror_number>" has "LAST_NAME" as "<last_name>" new schema
	And juror "<juror_number>" has "POSTCODE" as "<postcode>" new schema
	
	Then I see "Reply to a jury summons" on the page
	
	And I set the radio button to "I am replying for myself"
	And I press the "Continue" button
	And I set "9-digit juror number" to "<juror_number>"
	And I set "Juror last name" to "<last_name>"
	And I set "Juror postcode" to "<postcode>"
	And I press the "Continue" button

	#name
	And I choose the "Yes" radio button
	And I press the "Continue" button
	
	#address
	Then I see "Is this your address?" on the page
	
	And I choose the "No" radio button
	And I press the "Continue" button
	
	And I set "Postcode" to "CH2 2AN"
	And I press the "Continue" button
	
	#phone
	Then I see "What is your phone number?" on the page
	When I set "Main phone" to "02078211818"
	And I press the "Continue" button

	#email
	Then I see "What is your email address?" on the page
	When I set "Enter your email address" to "<email>"
	When I set "Enter your email address again" to "<email>"
	And I press the "Continue" button

	#DOB
	Then I see "What is your date of birth?" on the page
	When I set "Day" to "27"
	And I set "Month" to "04"
	And I set "Year" to "1981"
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
	
	#Check your answers
	Then I see "Check your answers now" on the page
	When I check the "The information I have given is true to the best of my knowledge" checkbox
	And I press the "Submit" button
	Then I see "We have sent you an email to say you have replied to your jury summons." on the page
	
	#bureau
	Given I am on "Bureau" "test"
	When I log in as "MODTESTBUREAU"
	And I click on the "Search" link
	And I set "Juror number" to "<juror_number>"
	And I press the "Search" button
	Then I see "results for “<juror_number>”" on the page
	
	#JDB-3629
	When I click on "<juror_number>" in the same row as "<juror_number>"
	Then I see "CH2 2AN" on the page
	And I do not see "Change Court" on the page
	
Examples:
	| juror_number	| last_name	| postcode	| email 		| pool_number	|
	| 045200188		| DOE		| CH1 6LU	| a@eeee.com	| 452300173		|
	
@Regression @NewSchemaConverted
Scenario Outline: Change postcode - new postcode not in court_catchment_area SHOWS CHANGE COURT
	
	#3. Change postcode - new postcode not in court_catchment_area
	#CH1 - SW1H
	#CH1=LOC_CODE 415
	#SW1H not in court_catchment_area

	Given I am on "Public" "test"

	Given a bureau owned pool is created with jurors
		| court |juror_number  | pool_number	| att_date_weeks_in_future	| owner |
		| 452   |<juror_number>| <pool_number>	| 5				            | 400	|
		
	And juror "<juror_number>" has "LAST_NAME" as "<last_name>" new schema
	And juror "<juror_number>" has "POSTCODE" as "<postcode>" new schema
	
	Then I see "Reply to a jury summons" on the page
	
	And I set the radio button to "I am replying for myself"
	And I press the "Continue" button
	And I set "9-digit juror number" to "<juror_number>"
	And I set "Juror last name" to "<last_name>"
	And I set "Juror postcode" to "<postcode>"
	And I press the "Continue" button

	#name
	And I choose the "Yes" radio button
	And I press the "Continue" button
	
	#address
	Then I see "Is this your address?" on the page
	
	And I choose the "No" radio button
	And I press the "Continue" button
	
	And I set "Postcode" to "SW1H 2AN"
	And I press the "Continue" button
	
	#phone
	Then I see "What is your phone number?" on the page
	When I set "Main phone" to "02078211818"
	And I press the "Continue" button

	#email
	Then I see "What is your email address?" on the page
	When I set "Enter your email address" to "<email>"
	When I set "Enter your email address again" to "<email>"
	And I press the "Continue" button

	#DOB
	Then I see "What is your date of birth?" on the page
	When I set "Day" to "27"
	And I set "Month" to "04"
	And I set "Year" to "1981"
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
	
	#Check your answers
	Then I see "Check your answers now" on the page
	When I check the "The information I have given is true to the best of my knowledge" checkbox
	And I press the "Submit" button
	Then I see "We have sent you an email to say you have replied to your jury summons." on the page
	
	#bureau
	Given I am on "Bureau" "test"
	When I log in as "MODTESTBUREAU"
	And I click on the "Search" link
	And I set "Juror number" to "<juror_number>"
	And I press the "Search" button
	Then I see "results for "<juror_number>"" on the page
	
	#JDB-3629
	When I click on "<juror_number>" in the same row as "<juror_number>"
	Then I see "SW1H 2AN" on the page
	And I see "Juror's address is outside the catchment area of the court they were summoned to" on the page
	
Examples:
	| juror_number	| last_name	| postcode	| email 		| pool_number	|
	| 045200189		| DOE		| CH1 6LU	| a@eeee.com	| 452300174		|
	
@Regression @NewSchemaConverted
Scenario Outline: Change postcode - old postcode not in court_catchment_area DOES NOT SHOW CHANGE COURT
	
	#4. Change postcode - old postcode not in court_catchment_area
	#SW1H - CH1
	#SW1H not in court_catchment_area
	#CH1=LOC_CODE 415

	Given I am on "Public" "test"

	Given a bureau owned pool is created with jurors
		| court |juror_number  | pool_number	| att_date_weeks_in_future	| owner |
		| 452   |<juror_number>| <pool_number>	| 5				            | 400	|
		
	And juror "<juror_number>" has "LAST_NAME" as "<last_name>" new schema
	And juror "<juror_number>" has "POSTCODE" as "<postcode>" new schema
	
	Then I see "Reply to a jury summons" on the page
	
	And I set the radio button to "I am replying for myself"
	And I press the "Continue" button
	And I set "9-digit juror number" to "<juror_number>"
	And I set "Juror last name" to "<last_name>"
	And I set "Juror postcode" to "<postcode>"
	And I press the "Continue" button

	#name
	And I choose the "Yes" radio button
	And I press the "Continue" button
	
	#address
	Then I see "Is this your address?" on the page
	
	And I choose the "No" radio button
	And I press the "Continue" button
	
	And I set "Postcode" to "CH1 2AN"
	And I press the "Continue" button
	
	#phone
	Then I see "What is your phone number?" on the page
	When I set "Main phone" to "02078211818"
	And I press the "Continue" button

	#email
	Then I see "What is your email address?" on the page
	When I set "Enter your email address" to "<email>"
	When I set "Enter your email address again" to "<email>"
	And I press the "Continue" button

	#DOB
	Then I see "What is your date of birth?" on the page
	When I set "Day" to "27"
	And I set "Month" to "04"
	And I set "Year" to "1981"
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
	
	#Check your answers
	Then I see "Check your answers now" on the page
	When I check the "The information I have given is true to the best of my knowledge" checkbox
	And I press the "Submit" button
	Then I see "We have sent you an email to say you have replied to your jury summons." on the page
	
	#bureau
	Given I am on "Bureau" "bau-test"
	When I log in as "MODTESTBUREAU"
	And I click on the "Search" link
	And I set "Juror number" to "<juror_number>"
	And I press the "Search" button
	Then I see "results for “<juror_number>”" on the page
	
	#JDB-3629
	When I click on "<juror_number>" in the same row as "<juror_number>"
	Then I see "CH1 2AN" on the page
	And I do not see "Change Court" on the page
	
Examples:
	| juror_number	| last_name	| postcode	| email 		| pool_number	|
	| 045200190		| DOE		| SW1H 6LU	| a@eeee.com	| 452300175		|
	
@Regression @NewSchemaConverted
Scenario Outline: Change Postcode but same loc_code CHANGE COURT FLAG NOT SHOWN two
	
	#5a. Change Postcode but same loc_code
	#NN1 - NN3
	#NN1=LOC_CODE 442
	#NN3=LOC_CODE 442

	Given I am on "Public" "test"

	Given a bureau owned pool is created with jurors
		| court |juror_number  | pool_number	| att_date_weeks_in_future	| owner |
		| 452   |<juror_number>| <pool_number>	| 5				            | 400	|
		
	And juror "<juror_number>" has "LAST_NAME" as "<last_name>" new schema
	And juror "<juror_number>" has "POSTCODE" as "<postcode>" new schema
	
	Then I see "Reply to a jury summons" on the page
	
	And I set the radio button to "I am replying for myself"
	And I press the "Continue" button
	And I set "9-digit juror number" to "<juror_number>"
	And I set "Juror last name" to "<last_name>"
	And I set "Juror postcode" to "<postcode>"
	And I press the "Continue" button

	#name
	And I choose the "Yes" radio button
	And I press the "Continue" button
	
	#address
	Then I see "Is this your address?" on the page
	
	And I choose the "No" radio button
	And I press the "Continue" button

	And I set "Postcode" to "NN3 2AN"
	And I press the "Continue" button
	
	#phone
	Then I see "What is your phone number?" on the page
	When I set "Main phone" to "02078211818"
	And I press the "Continue" button

	#email
	Then I see "What is your email address?" on the page
	When I set "Enter your email address" to "<email>"
	When I set "Enter your email address again" to "<email>"
	And I press the "Continue" button

	#DOB
	Then I see "What is your date of birth?" on the page
	When I set "Day" to "27"
	And I set "Month" to "04"
	And I set "Year" to "1981"
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
	
	#Check your answers
	Then I see "Check your answers now" on the page
	When I check the "The information I have given is true to the best of my knowledge" checkbox
	And I press the "Submit" button
	Then I see "We have sent you an email to say you have replied to your jury summons." on the page
	
	#bureau
	Given I am on "Bureau" "bau-test"
	When I log in as "MODTESTBUREAU"
	And I click on the "Search" link
	And I set "Juror number" to "<juror_number>"
	And I press the "Search" button
	Then I see "results for “<juror_number>”" on the page
	
	#JDB-3629
	When I click on "<juror_number>" in the same row as "<juror_number>"
	Then I see "NN3 2AN" on the page
	And I do not see "Change Court" on the page
	
Examples:
	| juror_number	| last_name	| postcode	| email 		| pool_number	|
	| 045200191		| DOE		| NN1 4EE	| a@eeee.com	| 452300176		|
	
@Regression @NewSchemaConverted
Scenario Outline: Record displays Change Court, Bureau officer updates postcode and flag is removed

	#7. Change postcode - different loc_code
	#WV1 - WA1
	#WV1=LOC_CODE 421
	#WA1=LOC_CODE 462
	
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
	And I set "Juror last name" to "<last_name>"
	And I set "Juror postcode" to "<postcode>"
	And I press the "Continue" button
	Then I see "Is the name we have for you correct?" on the page
	When I choose the "Yes" radio button

	#name
	And I choose the "Yes" radio button
	When I press the "Continue" button
	
	#address
	Then I see "Is this your address?" on the page
	
	And I choose the "No" radio button
	And I press the "Continue" button
	
	And I set "Postcode" to "WA1 2AN"
	And I press the "Continue" button
	
	#phone
	Then I see "What is your phone number?" on the page
	When I set "Main phone" to "02078211818"
	And I press the "Continue" button

	#email
	Then I see "What is your email address?" on the page
	When I set "Enter your email address" to "<email>"
	When I set "Enter your email address again" to "<email>"
	And I press the "Continue" button

	#DOB
	Then I see "What is your date of birth?" on the page
	When I set "Day" to "27"
	And I set "Month" to "04"
	And I set "Year" to "1981"
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
	
	#Check your answers
	Then I see "Check your answers now" on the page
	When I check the "The information I have given is true to the best of my knowledge" checkbox
	And I press the "Submit" button
	Then I see "We have sent you an email to say you have replied to your jury summons." on the page
	
	#bureau
	Given I am on "Bureau" "test"
	When I log in as "MODTESTBUREAU"
	And I click on the "Search" link
	And I set "Juror number" to "<juror_number>"
	And I press the "Search" button
	Then I see "results for “<juror_number>”" on the page
	
	#JDB-3629
	When I click on "<juror_number>" in the same row as "<juror_number>"
	Then I see "WA1 2AN" on the page
	And I see "Change Court" on the page
	
	#update postcode
	And I click on the "Change" link
	And I set "Postcode" to "WV1 4PP"
	And I press the "Save" button
	And I set "Please give a reason for the change to this summons reply" to "testNotesABC"
	And I click link with ID "changeLogSaveButton"
	Then I see "WV1 4PP" on the page
	And I do not see "Change Court" on the page
	
Examples:
	| juror_number	| last_name		| postcode	| email 		| pool_number	|
	| 045200192		| LNAMESIXSEVEN	| SY2 6LU	| a@eeee.com	| 452300177		|