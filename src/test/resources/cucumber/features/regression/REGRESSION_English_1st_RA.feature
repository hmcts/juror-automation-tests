Feature: Regression English_1st_RA

@Regression @JDB-3608 
Scenario Outline: English 1st Party RA

	Given I am on "Public" "juror-test02"
	Given the juror numbers have not been processed
		| part_no 	| pool_no 	| owner |
		| <part_no> |<pool_no>	| 400 	|

	And "<part_no>" has "LNAME" as "<last_name>"
	And "<part_no>" has "RET_DATE" as "4 mondays time"
	And "<part_no>" has "NEXT_DATE" as "4 mondays time"
	And "<part_no>" has "Address4" as "LONDON"
	And "<part_no>" has "ZIP" as "<postcode>"
	
	#Reply to jury summons

	Then I see "Reply to a jury summons" on the page
	
	And I set the radio button to "I am replying for myself"
	And I press the "Continue" button
	Then I see "Your juror details" on the page
	
	When I set "9-digit juror number" to "<part_no>"
	When I set "Juror last name" to "<last_name>"
	When I set "Juror postcode" to "<postcode>"
	And I press the "Continue" button
	
	#name
	
	Then I see "Is the name we have for you correct?" on the page
	When I set the radio button to "Yes"
	And I press the "Continue" button
	
	#address
	
	Then I see "Is this your address?" on the page
	When I set the radio button to "Yes"
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
	
	#dob
	
	Then I see "What is your date of birth?" on the page
	When I set "Day" to "27"
	And I set "Month" to "04"
	And I set "Year" to "1981"
	And I press the "Continue" button
	
	#qualifying
	
	Then I see "Confirm you're eligible for jury service" on the page
	And I press the "Continue" button
	
	#residency
	
	Then I see "Since you turned 13, has your main address" on the page
	When I set the radio button to "Yes"
	And I press the "Continue" button
	
	#CJS
	
	Then I see "Have you worked in the criminal justice system in the last 5 years?" on the page
	When I set the radio button to "No"
	And I press the "Continue" button
	
	#bail
	
	Then I see "Are you currently on bail" on the page
	When I set the radio button to "No"
	And I press the "Continue" button
	
	#crim offence
	
	Then I see "Have you been found guilty of a criminal offence" on the page
	When I set the radio button to "No"
	And I press the "Continue" button
	
	#MHQ1
	
	Then I see "Are you being detained, looked after or treated under the Mental Health Act?" on the page
	When I set the radio button to "No"
	And I press the "Continue" button
	
	#MHQ2
	
	Then I see "Has it been decided that you 'lack mental capacity'?" on the page
	When I set the radio button to "No"
	And I press the "Continue" button
	
	#confirm date
	
	Then I see "Check your start date" on the page
	And I see "Yes, I can start on" on the page
	And I set the radio button to "Yes, I can start on"
	And I press the "Continue" button
	
	#Help in Court
	#3608
	
	Then I see "Will you need help when you're at the court?" on the page
	When I set the radio button to "Yes"
	And I press the "Continue" button
	Then I see "Select if you have limited mobility, a hearing impairment, diabetes, a severe sight impairment or other disability or impairment" on the page
	Then I check the "Diabetes" checkbox
	And I press the "Continue" button
		
	#Check Answers
	
	Then I see "Check your answers now" on the page
	
	Then I check the "The information I have given is true to the best of my knowledge" checkbox
	
	When I press the "Submit" button

	#Confirmation
	
	Then I see "You have completed your reply" on the page
	
Examples:
	| part_no		|pool_no	|last_name				|postcode	| email | 
	|641500991		|415170601	|LNAMENINENINEONE		|CH1 2AN	|e@eeee.com|
	
@RegressionSingle @JDB-3132 
Scenario Outline: Reasonable adjustments (DIABETES) to automatically update Juror db
	
	Given I am on "Public" "juror-test02"
	Given the juror numbers have not been processed
		|part_no 	| pool_no 	| owner |
		|<part_no> 	|<pool_no>	| 400 	|

	And "<part_no>" has "LNAME" as "<last_name>" 
	And "<part_no>" has "RET_DATE" as "5 mondays time"
	And "<part_no>" has "NEXT_DATE" as "5 mondays time"
	And "<part_no>" has "Address4" as "LONDON"
	And "<part_no>" has "ZIP" as "<postcode>"
	
	#Reply to jury summons

	Then I see "Reply to a jury summons" on the page

	And I set the radio button to "I am replying for myself"
	And I press the "Continue" button
	Then I see "Your juror details" on the page
	
	When I set "9-digit juror number" to "<part_no>"
	When I set "Juror last name" to "<last_name>"
	When I set "Juror postcode" to "<postcode>"
	And I press the "Continue" button
	
	#name
	
	Then I see "Is the name we have for you correct?" on the page
	When I set the radio button to "Yes"
	And I press the "Continue" button
	
	#address
	
	Then I see "Is this your address?" on the page
	When I set the radio button to "Yes"
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
	
	#dob
	
	Then I see "What is your date of birth?" on the page
	When I set "Day" to "27"
	And I set "Month" to "04"
	And I set "Year" to "1981"
	And I press the "Continue" button
	
	#qualifying
	
	Then I see "Confirm you're eligible for jury service" on the page
	And I press the "Continue" button
	
	#residency
	
	Then I see "Since you turned 13, has your main address" on the page
	When I set the radio button to "Yes"
	And I press the "Continue" button
	
	#CJS
	
	Then I see "Have you worked in the criminal justice system in the last 5 years?" on the page
	When I set the radio button to "No"
	And I press the "Continue" button
	
	#bail
	
	Then I see "Are you currently on bail" on the page
	When I set the radio button to "No"
	And I press the "Continue" button
	
	#crim offence
	
	Then I see "Have you been found guilty of a criminal offence" on the page
	When I set the radio button to "No"
	And I press the "Continue" button
	
	#MHQ1
	
	Then I see "Are you being detained, looked after or treated under the Mental Health Act?" on the page
	When I set the radio button to "No"
	And I press the "Continue" button
	
	#MHQ2
	
	Then I see "Has it been decided that you 'lack mental capacity'?" on the page
	When I set the radio button to "No"
	And I press the "Continue" button
	
	#confirm date
	
	Then I see "Check your start date" on the page
	And I see "Yes, I can start on" on the page
	And I set the radio button to "Yes, I can start on"
	And I press the "Continue" button
	
	#Help in Court
	
	Then I see "Will you need help when you're at the court?" on the page
	When I set the radio button to "Yes"
	Then I check the "Diabetes" checkbox
	And I see "Tell us about any special arrangements or help you need while you're doing jury service." on the page
	Then I set "Tell us about any special arrangements or help you need while you're doing jury service." to "Special Need is DIABETES"
	And I press the "Continue" button
		
	#Check Answers
	
	Then I see "Check your answers now" on the page
	
	Then I check the "The information I have given is true to the best of my knowledge" checkbox
	
	When I press the "Submit" button

	#Confirmation
	
	Then I see "You have completed your reply" on the page
	
	Given I am on "Bureau" "juror-test02" 	
	And I log in as "CPASS"
	
	When I click on the "Search" link
	And I set "Juror number" to "<part_no>"
	And I press the "Search" button
	And I click on "<part_no>" in the same row as "<part_no>"
	
	#process response
	
	When I select "Responded" from Process reply
	And I check the "Mark juror as 'responded'" checkbox
	And I press the "Confirm" button
	
	#check db
	
	And I see "644200859" on the page
	Then I see "Responded" on the page
	And I see "COMPLETED" on the page
	Then on "JUROR" . "POOL" I see "SPEC_NEED" is "I" where "PART_NO" is "<part_no>"

Examples:
	|part_no	|pool_no	|last_name			|postcode	|email 		| 
	|644200859	|442170401	|LNAMENINENINEONE	|CH1 2AN	|e@eeee.com	|
	
@Regression @JDB-3132 
Scenario Outline: Reasonable adjustments (OTHER) to automatically update Juror db
	
	Given I am on "Public" "juror-test02"
	Given the juror numbers have not been processed
		|part_no 	| pool_no 	| owner |
		|<part_no> 	|<pool_no>	| 400 	|

	And "<part_no>" has "LNAME" as "<last_name>" 
	And "<part_no>" has "RET_DATE" as "5 mondays time"
	And "<part_no>" has "NEXT_DATE" as "5 mondays time"
	And "<part_no>" has "Address4" as "LONDON"
	And "<part_no>" has "ZIP" as "<postcode>"
	
	#Reply to jury summons

	Then I see "Reply to a jury summons" on the page

	And I set the radio button to "I am replying for myself"
	And I press the "Continue" button
	Then I see "Your juror details" on the page
	
	When I set "9-digit juror number" to "<part_no>"
	When I set "Juror last name" to "<last_name>"
	When I set "Juror postcode" to "<postcode>"
	And I press the "Continue" button
	
	#name
	
	Then I see "Is the name we have for you correct?" on the page
	When I set the radio button to "Yes"
	And I press the "Continue" button
	
	#address
	
	Then I see "Is this your address?" on the page
	When I set the radio button to "Yes"
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
	
	#dob
	
	Then I see "What is your date of birth?" on the page
	When I set "Day" to "27"
	And I set "Month" to "04"
	And I set "Year" to "1981"
	And I press the "Continue" button
	
	#qualifying
	
	Then I see "Confirm you're eligible for jury service" on the page
	And I press the "Continue" button
	
	#residency
	
	Then I see "Since you turned 13, has your main address" on the page
	When I set the radio button to "Yes"
	And I press the "Continue" button
	
	#CJS
	
	Then I see "Have you worked in the criminal justice system in the last 5 years?" on the page
	When I set the radio button to "No"
	And I press the "Continue" button
	
	#bail
	
	Then I see "Are you currently on bail" on the page
	When I set the radio button to "No"
	And I press the "Continue" button
	
	#crim offence
	
	Then I see "Have you been found guilty of a criminal offence" on the page
	When I set the radio button to "No"
	And I press the "Continue" button
	
	#MHQ1
	
	Then I see "Are you being detained, looked after or treated under the Mental Health Act?" on the page
	When I set the radio button to "No"
	And I press the "Continue" button
	
	#MHQ2
	
	Then I see "Has it been decided that you 'lack mental capacity'?" on the page
	When I set the radio button to "No"
	And I press the "Continue" button
	
	#confirm date
	
	Then I see "Check your start date" on the page
	And I see "Yes, I can start on" on the page
	And I set the radio button to "Yes, I can start on"
	And I press the "Continue" button
	
	#Help in Court
	
	Then I see "Will you need help when you're at the court?" on the page
	When I set the radio button to "Yes"
	Then I check the "Other" checkbox
	Then I set "Provide details" to "Some further details"
	Then I see "Tell us about any special arrangements or help you need while you're doing jury service." on the page
	Then I set "Tell us about any special arrangements or help you need while you're doing jury service." to "Special Need is OTHER"
	And I press the "Continue" button
		
	#Check Answers
	
	Then I see "Check your answers now" on the page
	
	Then I check the "The information I have given is true to the best of my knowledge" checkbox
	
	When I press the "Submit" button

	#Confirmation
	
	Then I see "You have completed your reply" on the page
	
	Given I am on "Bureau" "juror-test-02" 	
	And I log in as "CPASS"
	
	When I click on the "Search" link
	And I set "Juror number" to "<part_no>"
	And I press the "Search" button
	And I click on "<part_no>" in the same row as "<part_no>"
	
	#process response
	
	When I select "Responded" from Process reply
	And I check the "Mark juror as 'responded'" checkbox
	And I press the "Confirm" button
	
	#check db
	
	Then I see "Responded" on the page
	And I see "COMPLETED" on the page
	Then on "JUROR" . "POOL" I see "SPEC_NEED" is "O" where "PART_NO" is "<part_no>"

Examples:
	|part_no	|pool_no	|last_name			|postcode	|email 		| 
	|645700100	|457170401	|LNAMENINENINEONE	|CH1 2AN	|e@eeee.com	|

@Regression @JDB-3132 
Scenario Outline: Reasonable adjustments (MULTIPLE) to automatically update Juror db
	
	Given I am on "Public" "juror-test02"
	Given the juror numbers have not been processed
		|part_no 	| pool_no 	| owner |
		|<part_no> 	|<pool_no>	| 400 	|

	And "<part_no>" has "LNAME" as "<last_name>" 
	And "<part_no>" has "RET_DATE" as "5 mondays time"
	And "<part_no>" has "NEXT_DATE" as "5 mondays time"
	And "<part_no>" has "Address4" as "LONDON"
	And "<part_no>" has "ZIP" as "<postcode>"
	
	#Reply to jury summons

	Then I see "Reply to a jury summons" on the page

	And I set the radio button to "I am replying for myself"
	And I press the "Continue" button
	Then I see "Your juror details" on the page
	
	When I set "9-digit juror number" to "<part_no>"
	When I set "Juror last name" to "<last_name>"
	When I set "Juror postcode" to "<postcode>"
	And I press the "Continue" button
	
	#name
	
	Then I see "Is the name we have for you correct?" on the page
	When I set the radio button to "Yes"
	And I press the "Continue" button
	
	#address
	
	Then I see "Is this your address?" on the page
	When I set the radio button to "Yes"
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
	
	#dob
	
	Then I see "What is your date of birth?" on the page
	When I set "Day" to "27"
	And I set "Month" to "04"
	And I set "Year" to "1981"
	And I press the "Continue" button
	
	#qualifying
	
	Then I see "Confirm you're eligible for jury service" on the page
	And I press the "Continue" button
	
	#residency
	
	Then I see "Since you turned 13, has your main address" on the page
	When I set the radio button to "Yes"
	And I press the "Continue" button
	
	#CJS
	
	Then I see "Have you worked in the criminal justice system in the last 5 years?" on the page
	When I set the radio button to "No"
	And I press the "Continue" button
	
	#bail
	
	Then I see "Are you currently on bail" on the page
	When I set the radio button to "No"
	And I press the "Continue" button
	
	#crim offence
	
	Then I see "Have you been found guilty of a criminal offence" on the page
	When I set the radio button to "No"
	And I press the "Continue" button
	
	#MHQ1
	
	Then I see "Are you being detained, looked after or treated under the Mental Health Act?" on the page
	When I set the radio button to "No"
	And I press the "Continue" button
	
	#MHQ2
	
	Then I see "Has it been decided that you 'lack mental capacity'?" on the page
	When I set the radio button to "No"
	And I press the "Continue" button
	
	#confirm date
	
	Then I see "Check your start date" on the page
	And I see "Yes, I can start on" on the page
	And I set the radio button to "Yes, I can start on"
	And I press the "Continue" button
	
	#Help in Court
	
	Then I see "Will you need help when you're at the court?" on the page
	When I set the radio button to "Yes"
	Then I check the "Other" checkbox
	Then I set "Provide details" to "Some further details"
	Then I check the "Limited mobility" checkbox
	Then I set "Tell us about any special arrangements or help you need while you're doing jury service" to "Special Need is OTHER and LIMITED MOBILITY"
	And I press the "Continue" button
		
	#Check Answers
	
	Then I see "Check your answers now" on the page
	
	Then I check the "The information I have given is true to the best of my knowledge" checkbox
	
	When I press the "Submit" button

	#Confirmation
	
	Then I see "You have completed your reply" on the page
	
	Given I am on "Bureau" "juror-test02" 	
	And I log in as "CPASS"
	
	When I click on the "Search" link
	And I set "Juror number" to "<part_no>"
	And I press the "Search" button
	And I click on "<part_no>" in the same row as "<part_no>"
	
	#process response
	
	When I select "Responded" from Process reply
	And I check the "Mark juror as 'responded'" checkbox
	And I press the "Confirm" button
	
	#check db
	
	Then I see "Responded" on the page
	And I see "COMPLETED" on the page
	Then on "JUROR" . "POOL" I see "SPEC_NEED" is "M" where "PART_NO" is "<part_no>"

Examples:
	|part_no	|pool_no	|last_name			|postcode	|email 		| 
	|644200911	|442170401	|LNAMENINENINEONE	|CH1 2AN	|e@eeee.com	|