Feature: Bureau Auto Allocation of Responses

#	Test commented out as bureau edit links disabled
#@RegressionSingle @JDB-3761 
Scenario Outline: 1. Edit Juror Details on PENDING ALLOCATION
	Given I am on "Public" "juror-test02"
	Given auto straight through processing has been disabled new schema
	Given the juror numbers have not been processed
		| part_no 	| pool_no 	| owner |
		| <part_no> |457170401	| 400 	|
	
	# Set part_no pool to not be urgent
	
	Given "<juror_number>" has "RET_DATE" as "5 mondays time"

	And juror "<juror_number>" has "LAST_NAME" as "<last_name>" new schema
	And juror "<juror_number>" has "POSTCODE" as "<postcode>" new schema
	
	# Submit response in pool
	
	Given I have submitted a first party English straight through response
		| part_no	|pool_number| last_name		|postcode	| email |
		|<part_no>	|<pool_no>	| <last_name>	|CH1 2AN	|a@a.com|

	Given I am on "Bureau" "juror-test02"
	And I log in as "CPASS"
	
	#check response is pending allocation
	
	And I click on the "Search" link
	And I set "Juror number" to "<juror_number>"
	And I press the "Search" button
	Then I see "TO DO" in the same row as "<juror_number>"
	
	#edit Juror's name
	
	When I click on "<juror_number>" in the same row as "<juror_number>"
	Then I see "Process reply" on the page
	When I click on the "Change" link
	And I set "First name" to "Bob"
	When I click on the "Save" link
	And I set "Please give a reason for the change to this summons reply" to "Some notes here"
	And I click link with ID "changeLogSaveButton"
	
	#check the response is now allocated to CPASS
	
	And I click on the "Search" link
	And I set "Juror number" to "<juror_number>"
	And I press the "Search" button
	Then I see "CPASS" in the same row as "<juror_number>"

Examples:
	|part_no	|pool_no 	|last_name 			|postcode 	|
	|645700182	|457170401 	|LNAMEONEFIVEFOUR 	|CH1 2AN	|

#	Test commented out as bureau edit links disabled
#@RegressionSingle @JDB-3761 
Scenario Outline: 2. Edit Eligibility on PENDING ALLOCATION response
	Given I am on "Public" "juror-test02"
	Given auto straight through processing has been disabled new schema
	Given the juror numbers have not been processed
		|part_no 		|pool_no 	|owner 	|
		|<part_no_one> 	|457170401	|400 	|
	
	# Set part_no pool to not be urgent
	
	Given "<part_no_one>" has "RET_DATE" as "5 mondays time"
	And "<part_no_one>" has "NEXT_DATE" as "5 mondays time"
	And "<part_no_one>" has "LNAME" as "<last_name>"
	And "<part_no_one>" has "ZIP" as "<postcode>"
	
	# Submit response in pool
	
	Given I have submitted a first party English straight through response
		| part_no		|pool_number| last_name		|postcode	| email |
		|<part_no_one>	|<pool_no>	| <last_name>	|CH1 2AN	|a@a.com|

	Given I am on "Bureau" "juror-test02"
	And I log in as "CPASS"
	
	#check response is pending allocation
	
	And I click on the "Search" link
	And I set "Juror number" to "<part_no_one>"
	And I press the "Search" button
	Then I see "TO DO" in the same row as "<part_no_one>"
	
	#edit Juror's eligibility
	
	When I click on "<part_no_one>" in the same row as "<part_no_one>"
	Then I see "Process reply" on the page
	When I click on the "Eligibility" link
	When I click on the "Change" link
	And I choose the "No" radio button under "Residency"
	And I set "Provide details" to "Details"
	When I click on the "Save" link
	And I set "Please give a reason for the change to this summons reply" to "Some reasons for change"
	And I click link with ID "changeLogSaveButton"
	
	#check the response is now allocated to CPASS
	
	And I click on the "Search" link
	And I set "Juror number" to "<part_no_one>"
	And I press the "Search" button
	Then I see "CPASS" in the same row as "<part_no_one>"

	# re-enable auto processing
	
	Given auto straight through processing has been enabled new schema
	
Examples:
	|part_no_one|part_no_three	|pool_no 	|last_name 			|postcode 	|
	|645700115	|645700802		|457170401 	|LNAMEONEFIVEFOUR 	|CH1 2AN	|

#	Test commented out as bureau edit links disabled
#@RegressionSingle @JDB-3761 
Scenario Outline: 3. Edit Deferral on PENDING ALLOCATION response
	Given I am on "Public" "juror-test02"
	Given auto straight through processing has been disabled new schema
	Given the juror numbers have not been processed
		|part_no 		|pool_no 	|owner 	|
		|<part_no_two> 	|457170401	|400 	|
	
	# Set part_no pool to not be urgent
	
	Given "<part_no_two>" has "RET_DATE" as "5 mondays time"
	And "<part_no_two>" has "NEXT_DATE" as "5 mondays time"
	And "<part_no_two>" has "LNAME" as "<last_name>"
	And "<part_no_two>" has "ZIP" as "<postcode>"
	
	#Submit a deferral request response in pool
	
	Then I see "Reply to a jury summons" on the page
	
	And I set the radio button to "I am replying for myself"
	And I press the "Continue" button
	Then I see "Your juror details" on the page
	When I set "9-digit juror number" to "<part_no_two>"
	When I set "Juror last name" to "<last_name>"
	When I set "Juror postcode" to "<postcode>"
	And I press the "Continue" button
	
	Then I see "Is the name we have for you correct?" on the page
	And I choose the "Yes" radio button
	When I press the "Continue" button
	
	Then I see "<postcode>" on the page
	And I choose the "Yes" radio button
	And I press the "Continue" button
	
	Then I see "What is your phone number?" on the page
	When I set "Main phone" to "02078211818"
	And I press the "Continue" button
	
	Then I see "What is your email address?" on the page
	When I set "Enter your email address" to "<email>"
	When I set "Enter your email address again" to "<email>"
	And I press the "Continue" button
	
	Then I see "What is your date of birth" on the page
	When I set "Day" to "27"
	And I set "Month" to "04"
	And I set "Year" to "1981"
	And I press the "Continue" button
	
	Then I see "Confirm you're eligible for jury service" on the page
	And I press the "Continue" button
	
	Then I see "Since you turned 13, has your main address been in the UK, Channel Islands or Isle of Man for any period of at least 5 years?" on the page
	When I choose the "Yes" radio button
	And I press the "Continue" button
	
	Then I see "Have you worked in the criminal justice system in the last 5 years?" on the page
	Then I see "Have you worked in the criminal justice system in the last 5 years?" on the page
	When I choose the "No" radio button
	And I press the "Continue" button
	
	And I see "Are you currently on bail for a criminal offence?" on the page
	When I choose the "No" radio button
	And I press the "Continue" button
	
	Then I see "Have you been found guilty of a criminal offence?" on the page
	When I choose the "No" radio button
	And I press the "Continue" button
	
	Then I see "Mental Health" on the page
	And I see "Are you being detained, looked after or treated under the Mental Health Act?" on the page
	When I choose the "No" radio button
	And I press the "Continue" button
	
	Then I see "Has it been decided that you 'lack mental capacity'?" on the page
	When I choose the "No" radio button
	And I press the "Continue" button
	
	And I see "No, I need to change the date" on the page
	And I set the radio button to "No, I need to change the date"
	And I press the "Continue" button
	
	#deferral
	
	And I see "Tell us why you need another date for your jury service" on the page
	When I set text area with "id" of "deferralReason" to "TestDeferralData"
	And I press the "Continue" button
	Then I see "Choose 3 Mondays when you can start jury service" on the page
	When I set the "First" single date field to a Monday "6" weeks in the future
	When I set the "Second" single date field to a Monday "7" weeks in the future
	When I set the "Third" single date field to a Monday "8" weeks in the future
	And I press the "Continue" button
	
	And I choose the "Yes" radio button
	And I press the "Continue" button
	
	Then I see "Will you need help when you're at the court?" on the page
	Then I see "Do you have a disability or impairment that means you’ll need extra support or facilities in the court building where you are doing your Jury Service?" on the page	
	When I choose the "No" radio button
	When I press the "Continue" button
	
	Then I see "Check your answers now" on the page	
	Then I check the "The information I have given is true to the best of my knowledge" checkbox
	When I press the "Submit" button
	Then I see "You have completed your reply" on the page
	Then I see "<part_no_two>" on the page
	
	#log on to bureau as CPASS

	Given I am on "Bureau" "bau-test"
	And I log in as "CPASS"
	
	#check response is pending allocation
	
	And I click on the "Search" link
	And I set "Juror number" to "<part_no_two>"
	And I press the "Search" button
	Then I see "TO DO" in the same row as "<part_no_two>"
	
	#edit Juror's deferral
	
	When I click on "<part_no_two>" in the same row as "<part_no_two>"
	Then I see "Process reply" on the page
	When I click on the "Deferral or excusal" link
	When I click on the "Change" link
	And I set the radio button to "I can do jury service on the date shown"
	When I click on the "Save" link
	And I set "Please give a reason for the change to this summons reply" to "Some reasons for change"
	And I click link with ID "changeLogSaveButton"
	
	#check the response is now allocated to CPASS
	
	And I click on the "Search" link
	And I set "Juror number" to "<part_no_two>"
	And I press the "Search" button
	Then I see "CPASS" in the same row as "<part_no_two>"
	
	# re-enable auto processing
	
	Given auto straight through processing has been enabled new schema

Examples:
	|part_no_two|pool_no 	|last_name 			|postcode 	|email		|
	|645700802	|457170401 	|LNAMEONEFIVEFOUR 	|CH1 2AN	|e@mail.com	|

#	Test commented out as bureau edit links disabled
#@RegressionSingle @JDB-3761 
Scenario Outline: 4. Edit Excusal on PENDING ALLOCATION response
	Given I am on "Public" "juror-test02"
	Given auto straight through processing has been disabled new schema
	Given the juror numbers have not been processed
		|part_no 		|pool_no 	|owner 	|
		|<part_no_three>|457170401	|400 	|
	
	# Set part_no pool to not be urgent
	
	Given "<part_no_three>" has "RET_DATE" as "5 mondays time"
	And "<part_no_three>" has "NEXT_DATE" as "5 mondays time"
	And "<part_no_three>" has "LNAME" as "<last_name>"
	And "<part_no_three>" has "ZIP" as "<postcode>"
	
	#Submit an excusal request response in pool
	
	Given I am on "Public" "juror-test02"
	Then I see "Reply to a jury summons" on the page
	
	And I set the radio button to "I am replying for myself"
	And I press the "Continue" button
	
	Then I see "Your juror details" on the page
	When I set "9-digit juror number" to "<part_no_three>"
	When I set "Juror last name" to "<last_name>"
	When I set "Juror postcode" to "<postcode>"
	And I press the "Continue" button
	
	Then I see "Is the name we have for you correct?" on the page
	And I choose the "Yes" radio button
	When I press the "Continue" button
	
	Then I see "Is this your address?" on the page
	And I choose the "Yes" radio button
	And I press the "Continue" button
	
	Then I see "What is your phone number?" on the page
	When I set "Main phone" to "0207 821 1818"
	And I press the "Continue" button
	
	Then I see "What is your email address?" on the page
	When I set "Enter your email address" to "<email>"
	And I set "Enter your email address again" to "<email>"
	And I press the "Continue" button
	
	Then I see "What is your date of birth?" on the page
	When I set "Day" to "27"
	And I set "Month" to "04"
	And I set "Year" to "1981"
	And I press the "Continue" button
	
	Then I see "Confirm you're eligible for jury service" on the page
	When I press the "Continue" button
	
	Then I see "Since you turned 13, has your main address been in the UK, Channel Islands or Isle of Man for any period of at least 5 years?" on the page
	When I choose the "Yes" radio button
	And I press the "Continue" button
	
	Then I see "Have you worked in the criminal justice system in the last 5 years?" on the page
	When I choose the "No" radio button
	And I press the "Continue" button
	
	When I choose the "No" radio button
	And I press the "Continue" button
	
	Then I see "Have you been found guilty of a criminal offence?" on the page
	When I choose the "No" radio button
	And I press the "Continue" button
	
	Then I see "Are you being detained, looked after or treated under the Mental Health Act?" on the page
	When I choose the "No" radio button
	And I press the "Continue" button
	
	When I choose the "No" radio button
	And I press the "Continue" button
	
	Then I see "Check your start date" on the page
	
	#excusal
	
	When I set the radio button to "No, I cannot do jury service and need to be excused" 
	And I press the "Continue" button
	Then I see "Why do you need to be excused from jury service?" on the page
	When I set text area with "id" of "excusalReason" to "Excuse me please"
	And I press the "Continue" button
	
	Then I see "Will you need help when" on the page
	When I choose the "No" radio button
	And I press the "Continue" button
	
	Then I see "Check your answers now" on the page
	When I check the "The information" checkbox
	And I press the "Submit" button
	And I see "You have completed your reply" on the page
	
	#log on to bureau as CPASS

	Given I am on "Bureau" "juror-test02"
	And I log in as "CPASS"
	
	#check response is pending allocation
	
	And I click on the "Search" link
	And I set "Juror number" to "<part_no_three>"
	And I press the "Search" button
	Then I see "TO DO" in the same row as "<part_no_three>"
	
	#edit Juror's excusal
	
	When I click on "<part_no_three>" in the same row as "<part_no_three>"
	Then I see "Process reply" on the page
	When I click on the "Deferral or excusal" link
	When I click on the "Change" link
	And I set the radio button to "I can do jury service on the date shown"
	When I click on the "Save" link
	And I set "Please give a reason for the change to this summons reply" to "Some reasons for change"
	And I click link with ID "changeLogSaveButton"
	
	#check the response is now allocated to CPASS
	
	And I click on the "Search" link
	And I set "Juror number" to "<part_no_three>"
	And I press the "Search" button
	Then I see "CPASS" in the same row as "<part_no_three>"
	
	# re-enable auto processing
	
	Given auto straight through processing has been enabled new schema
	
Examples:
	|part_no_three	|pool_no 	|last_name 			|postcode 	|email		|
	|645700802		|457170401 	|LNAMEONEFIVEFOUR 	|CH1 2AN	|e@mail.com	|
	
#	Test commented out as bureau edit links disabled
#@RegressionSingle @JDB-3761 
Scenario Outline: 5. Edit CJS Employment on PENDING ALLOCATION response
	Given I am on "Public" "juror-test02"
	Given auto straight through processing has been disabled new schema
	Given the juror numbers have not been processed
		| part_no 		| pool_no 	| owner |
		| <part_no_four>|457170401	| 400 	|
	
	# Set part_no pool to not be urgent
	
	Given "<part_no_four>" has "RET_DATE" as "5 mondays time"
	And "<part_no_four>" has "NEXT_DATE" as "5 mondays time"
	And "<part_no_four>" has "LNAME" as "<last_name>"
	And "<part_no_four>" has "ZIP" as "<postcode>"
	
	# Submit response in pool
	
	Given I have submitted a first party English straight through response
		|part_no		|pool_number|last_name		|postcode	|email 	|
		|<part_no_four>	|<pool_no>	|<last_name>	|CH1 2AN	|a@a.com|

	Given I am on "Bureau" "juror-test02"
	And I log in as "CPASS"
	
	#check response is pending allocation
	
	And I click on the "Search" link
	And I set "Juror number" to "<part_no_four>"
	And I press the "Search" button
	Then I see "TO DO" in the same row as "<part_no_four>"
	
	#edit Juror's CJS emp
	
	When I click on "<part_no_four>" in the same row as "<part_no_four>"
	Then I see "Process reply" on the page
	When I click on the "CJS employment" link
	When I click on the "Change" link
	And I choose the "Yes" radio button under "CJS Employment"
	And I check the "National Crime Agency" checkbox
	And I click on the "Save" link
	And I set "Please give a reason for the change to this summons reply" to "Some reasons for change"
	And I click link with ID "changeLogSaveButton"
	
	#check the response is now allocated to CPASS
	
	And I click on the "Search" link
	And I set "Juror number" to "<part_no_four>"
	And I press the "Search" button
	Then I see "CPASS" in the same row as "<part_no_four>"

	# re-enable auto processing 
	
	Given auto straight through processing has been enabled new schema
	
Examples:
	|part_no_four	|pool_no 	|last_name 			|postcode 	|
	|645700129		|457170401 	|LNAMEONEFIVEFOUR 	|CH1 2AN	|

#	Test commented out as bureau edit links disabled
#@RegressionSingle @JDB-3761 
Scenario Outline: 6. Edit Reasonable Adjustments on PENDING ALLOCATION response
	Given I am on "Public" "juror-test02"
	Given auto straight through processing has been disabled new schema
	Given the juror numbers have not been processed
		| part_no 		| pool_no 	| owner |
		| <part_no_five>|457170401	| 400 	|
	
	# Set part_no pool to not be urgent
	
	Given "<part_no_five>" has "RET_DATE" as "5 mondays time"
	And "<part_no_five>" has "NEXT_DATE" as "5 mondays time"
	And "<part_no_five>" has "LNAME" as "<last_name>"
	And "<part_no_five>" has "ZIP" as "<postcode>"
	
	# Submit response in pool
	
	Then I see "Reply to a jury summons" on the page
	
	And I set the radio button to "I am replying for myself"
	And I press the "Continue" button
	Then I see "Your juror details" on the page
	
	When I set "9-digit juror number" to "<part_no_five>"
	When I set "Juror last name" to "<last_name>"
	When I set "Juror postcode" to "<postcode>"
	And I press the "Continue" button
	
	#name
	
	Then I see "Is the name we have for you correct?" on the page
	And I choose the "Yes" radio button
	And I press the "Continue" button
	
	#address
	
	Then I see "Is this your address?" on the page
	And I choose the "Yes" radio button
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
	When I choose the "Yes" radio button
	And I press the "Continue" button
	
	#CJS
	
	Then I see "Have you worked in the criminal justice system in the last 5 years?" on the page
	When I choose the "No" radio button
	And I press the "Continue" button
	
	#bail
	
	Then I see "Are you currently on bail" on the page
	When I choose the "No" radio button
	And I press the "Continue" button
	
	#crim offence
	
	Then I see "Have you been found guilty of a criminal offence" on the page
	When I choose the "No" radio button
	And I press the "Continue" button
	
	#MHQ1
	
	Then I see "Are you being detained, looked after or treated under the Mental Health Act?" on the page
	When I choose the "No" radio button
	And I press the "Continue" button
	
	#MHQ2
	
	Then I see "Has it been decided that you 'lack mental capacity'?" on the page
	When I choose the "No" radio button
	And I press the "Continue" button
	
	#confirm date
	
	Then I see "Check your start date" on the page
	And I see "Yes, I can start on" on the page
	And I set the radio button to "Yes, I can start on" 
	And I press the "Continue" button
	
	#Help in Court
	
	Then I see "Will you need help when you're at the court?" on the page
	When I choose the "Yes" radio button
	Then I check the "Diabetes" checkbox
	And I press the "Continue" button
		
	#Check Answers
	
	Then I see "Check your answers now" on the page
	Then I check the "The information I have given is true to the best of my knowledge" checkbox
	When I press the "Submit" button

	#Confirmation
	
	And I see "You have completed your reply" on the page
	
	Given I am on "Bureau" "juror-test02"
	And I log in as "CPASS"
	
	#check response is pending allocation
	
	And I click on the "Search" link
	And I set "Juror number" to "<part_no_five>"
	And I press the "Search" button
	Then I see "TO DO" in the same row as "<part_no_five>"
	
	#edit Juror's reasonable adjustments
	
	When I click on "<part_no_five>" in the same row as "<part_no_five>"
	Then I see "Process reply" on the page
	When I click on the "Reasonable adjustments" link
	When I click on the "Change" link
	And I check the "Limited mobility" checkbox
	When I click on the "Save" link
	And I set "Please give a reason for the change to this summons reply" to "Some reasons for change"
	And I click link with ID "changeLogSaveButton"
	
	#check the response is now allocated to CPASS
	
	And I click on the "Search" link
	And I set "Juror number" to "<part_no_five>"
	And I press the "Search" button
	Then I see "CPASS" in the same row as "<part_no_five>"
	
	# re-enable auto processing
	
	Given auto straight through processing has been enabled new schema

Examples:
	|part_no_five	|pool_no 	|last_name 			|postcode 	|email		|
	|645700224		|457170401 	|LNAMEONEFIVEFOUR 	|CH1 2AN	|e@mail.com	|

@RegressionSingle @JDB-3761 
Scenario Outline: 7. Edit Notes and Logs on PENDING ALLOCATION response

	Given I am on "Public" "juror-test02"
	Given auto straight through processing has been disabled new schema
	Given the juror numbers have not been processed
		|part_no 		|pool_no 	|owner 	|
		|<part_no_six> 	|457170401	|400 	|
	
	# Set part_no pool to not be urgent
	
	Given "<part_no_six>" has "RET_DATE" as "5 mondays time"
	And "<part_no_six>" has "NEXT_DATE" as "5 mondays time"
	And "<part_no_six>" has "LNAME" as "<last_name>"
	And "<part_no_six>" has "ZIP" as "<postcode>"
	
	# Submit response in pool
	
	Given I have submitted a first party English straight through response
		| part_no		|pool_number| last_name		|postcode	| email |
		|<part_no_six>	|<pool_no>	| <last_name>	|CH1 2AN	|a@a.com|

	Given I am on "Bureau" "juror-test02"
	And I log in as "CPASS"
	
	#check response is pending allocation
	
	And I click on the "Search" link
	And I set "Juror number" to "<part_no_six>"
	And I press the "Search" button
	Then I see "TO DO" in the same row as "<part_no_six>"
	
	#add notes
	
	When I click on "<part_no_six>" in the same row as "<part_no_six>"
	Then I see "Process reply" on the page
	When I click on the "Logs" link
	And I click on the "Add or Edit" link
	And I see "Notes" on the page
	And I see "<last_name>" on the page
	And I see "/<part_no_six>/notes/edit" in the URL
	And I set text area with "id" of "notes" to "Some notes in the notes field"
	And I press the "Save" button
	Then I see "Notes" on the page
	And "notes" is "Some notes in the notes field"
	
	#edit notes
	
	And I click on the "Add or Edit" link
	And I append text area with "id" of "notes" with " and some more notes"
	And I press the "Save" button
	Then I see "Notes" on the page
	And "notes" is "Some notes in the notes field and some more notes"
	
	#check I can enter special characters
	
	And I click on the "Add or Edit" link
	And I set text area with "id" of "notes" to "Some-one 0% £300 & * ! @ + [] her's ?'"
	And I press the "Save" button
	And "notes" is "Some-one 0% £300 & * ! @ + [] her's ?'"
	
	#check I can enter 2000 chars
	
	And I click on the "Add or Edit" link
	And I set text area with "id" of "notes" to "These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are tThese are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are t"
	And I see "You have 0 characters remaining" on the page
	And I press the "Save" button
	And "notes" is "These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are tThese are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are t"
	
	#check I cannot enter >2000 chars
	
	And I click on the "Add or Edit" link
	And I set text area with "id" of "notes" to "These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are tThese are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details"
	And I see "You have 10 characters too many" on the page
	And I press the "Save" button
	And I see "There is a problem" on the page
	And I see "Notes must be 2000 characters or fewer" on the page
	And I press "back_space" in "Notes"
	And I press "back_space" in "Notes"
	And I press "back_space" in "Notes"
	And I press "back_space" in "Notes"
	And I press "back_space" in "Notes"
	And I press "back_space" in "Notes"
	And I press "back_space" in "Notes"
	And I press "back_space" in "Notes"
	And I press "back_space" in "Notes"
	And I press "back_space" in "Notes"
	And I see "You have 0 characters remaining" on the page
	And I press the "Save" button
	And "notes" is "These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are tThese are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are t"
	
	#check I cannot leave notes empty
	
	And I click on the "Add or Edit" link
	And I set text area with "id" of "notes" to ""
	And I press the "Save" button
	And I see "There is a problem" on the page
	And I see "Enter notes text" on the page
	
	#click cancel
	
	Then I click on the "Cancel" link
	And "notes" is "These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are tThese are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are t"
	
	#check the response is now allocated to CPASS
	
	And I click on the "Search" link
	And I set "Juror number" to "<part_no_six>"
	And I press the "Search" button
	Then I see "CPASS" in the same row as "<part_no_six>"
	
	#check notes are still there
	
	When I click on "<part_no_six>" in the same row as "<part_no_six>"
	When I click on the "Logs" link
	And "notes" is "These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are tThese are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are t"

	# re-enable auto processing
	
	Given auto straight through processing has been enabled new schema

Examples:
	|part_no_six|pool_no 	|last_name 			|postcode 	|e@mail		|
	|645700267	|457170401 	|LNAMEONEFIVEFOUR 	|CH1 2AN	|e@mail.com	|
	
@RegressionSingle @JDB-3761 
Scenario Outline: 8. Set to Awaiting Response on PENDING ALLOCATION response
	Given I am on "Public" "juror-test01"
	Given auto straight through processing has been disabled new schema
	Given the juror numbers have not been processed
		| part_no 			| pool_no 	| owner |
		| <part_no_seven> 	|457170401	| 400 	|
	
	# Set part_no pool to not be urgent
	
	Given "<part_no_seven>" has "RET_DATE" as "5 mondays time"
	And "<part_no_seven>" has "NEXT_DATE" as "5 mondays time"
	And "<part_no_seven>" has "LNAME" as "<last_name>"
	And "<part_no_seven>" has "ZIP" as "<postcode>"
	
	# Submit response in pool
	
	Given I have submitted a first party English straight through response
		| part_no			|pool_number| last_name		|postcode	| email |
		|<part_no_seven>	|<pool_no>	| <last_name>	|CH1 2AN	|a@a.com|

	Given I am on "Bureau" "juror-test01"
	And I log in as "CPASS"
	
	#check response is pending allocation
	
	And I click on the "Search" link
	And I set "Juror number" to "<part_no_seven>"
	And I press the "Search" button
	Then I see "TO DO" in the same row as "<part_no_seven>"
	
	#set response to awaiting information
	
	When I click on "<part_no_seven>" in the same row as "<part_no_seven>"
	Then I see "Process reply" on the page
	Then I press the "More actions" button
	And I click on the "Mark as awaiting information" link
	When I set the radio button to "Awaiting juror"
	And I press the "Confirm" button
	
	#check the response is now allocated to CPASS
	
	And I click on the "Search" link
	And I set "Juror number" to "<part_no_seven>"
	And I press the "Search" button
	Then I see "CPASS" in the same row as "<part_no_seven>"

	# re-enable auto processing
	
	Given auto straight through processing has been enabled new schema
	
Examples:
	|part_no_seven	|pool_no 	|last_name 			|postcode 	|
	|645700135		|457170401 	|LNAMEONEFIVEFOUR 	|CH1 2AN	|

@RegressionSingle @JDB-3761 
Scenario Outline: 9. Complete a PENDING ALLOCATION response
	Given I am on "Public" "juror-test02"
	Given auto straight through processing has been disabled new schema
	Given the juror numbers have not been processed
		| part_no 			| pool_no 	| owner |
		| <part_no_eight> 	|457170401	| 400 	|
	
	# Set part_no pool to not be urgent
	
	Given "<part_no_eight>" has "RET_DATE" as "5 mondays time"
	And "<part_no_eight>" has "NEXT_DATE" as "5 mondays time"
	And "<part_no_eight>" has "LNAME" as "<last_name>"
	And "<part_no_eight>" has "ZIP" as "<postcode>"
	
	# Submit response in pool
	
	Given I have submitted a first party English straight through response
		| part_no			|pool_number| last_name		|postcode	| email |
		|<part_no_eight>	|<pool_no>	| <last_name>	|CH1 2AN	|a@a.com|

	Given I am on "Bureau" "juror-test02"
	And I log in as "CPASS"
	
	#check response is pending allocation
	
	And I click on the "Search" link
	And I set "Juror number" to "<part_no_eight>"
	And I press the "Search" button
	Then I see "TO DO" in the same row as "<part_no_eight>"
	
	#set response to responded
	
	When I click on "<part_no_eight>" in the same row as "<part_no_eight>"
	Then I see "Process reply" on the page
	When I select "Mark as responded" from Process reply
	And I check the "Mark juror as 'responded'" checkbox
	And I press the "Confirm" button
	
	#check the response is now allocated to CPASS
	
	And I click on the "Search" link
	And I press the "Search" button
	Then I see "CPASS" in the same row as "<part_no_eight>"
	
	# re-enable auto processing
	
	Given auto straight through processing has been enabled new schema

Examples:
	|part_no_eight	|pool_no 	|last_name 			|postcode 	|
	|645700136		|457170401 	|LNAMEONEFIVEFOUR 	|CH1 2AN	|
	
#	Test commented out as bureau edit links disabled
#@RegressionSingle @JDB-3761 
Scenario Outline: 10. test that editing an allocated response doesnt auto allocate to me
	Given I am on "Public" "juror-test02"
	Given auto straight through processing has been disabled new schema
	Given the juror numbers have not been processed
		| part_no 			| pool_no 	| owner |
		| <part_no_nine> 	|457170401	| 400 	|
	
	# Set part_no pool to not be urgent
	
	Given "<part_no_nine>" has "RET_DATE" as "5 mondays time"
	And "<part_no_nine>" has "NEXT_DATE" as "5 mondays time"
	And "<part_no_nine>" has "LNAME" as "<last_name>"
	And "<part_no_nine>" has "ZIP" as "<postcode>"
	
	# Submit response in pool
	
	Given I have submitted a first party English straight through response
		|part_no		|pool_number|last_name		|postcode	|email 	|
		|<part_no_nine>	|<pool_no>	|<last_name>	|CH1 2AN	|a@a.com|

	Given I am on "Bureau" "juror-test02"
	And I log in as "CPASS"
	
	#check response is pending allocation
	
	And I click on the "Search" link
	And I set "Juror number" to "<part_no_nine>"
	And I press the "Search" button
	Then I see "TO DO" in the same row as "<part_no_nine>"
	
	#set response to awaiting information
	
	When I click on "<part_no_nine>" in the same row as "<part_no_nine>"
	Then I see "Process reply" on the page
	When I select "Awaiting information" from Process reply
	When I set the radio button to "Awaiting juror"
	And I press the "Update reply status" button
	
	#check the response is now allocated to CPASS
	
	And I click on the "Search" link
	And I set "Juror number" to "<part_no_nine>"
	And I press the "Search" button
	Then I see "CPASS" in the same row as "<part_no_nine>"
	
	#check SYSTEM can update record and it's not allocated to them

	Given I am on "Bureau" "juror-test02"
	And I log in as "MODTESTBUREAU"
	
	And I click on the "Search" link
	And I set "Juror number" to "<part_no_nine>"
	And I press the "Search" button
	Then I see "CPASS" in the same row as "<part_no_nine>"
	
	When I click on "<part_no_nine>" in the same row as "<part_no_nine>"
	Then I see "Process reply" on the page
	When I click on the "Change" link
	And I set "First name" to "Bob"
	When I click on the "Save" link
	And I set "Please give a reason for the change to this summons reply" to "Some reasons for change"
	And I click link with ID "changeLogSaveButton"
	
	#check the response is still allocated to CPASS
	
	And I click on the "Search" link
	And I set "Juror number" to "<part_no_nine>"
	And I press the "Search" button
	Then I see "CPASS" in the same row as "<part_no_nine>"
	
	# re enable auto processing
	
	Given auto straight through processing has been enabled new schema

Examples:
	|part_no_nine	|pool_no 	|last_name 			|postcode 	|
	|645700138		|457170401 	|LNAMEONEFIVEFOUR 	|CH1 2AN	|

@RegressionSingle @JDB-3761
Scenario Outline: 11. Complete a PENDING ALLOCATION response that has been processed in Juror DB before Juror Digital
	
	Given I am on "Public" "juror-test02"
	Given auto straight through processing has been enabled new schema
	Given the juror numbers have not been processed
		|part_no 		|pool_no 	|owner 	|
		|<part_no_ten> 	|<pool_no>	|400 	|
	
	#Set part_no pool to be urgent
	Given "<part_no_ten>" has "RET_DATE" as "3 mondays time"
	And "<part_no_ten>" has "NEXT_DATE" as "3 mondays time"
	And "<part_no_ten>" has "LNAME" as "<last_name>"
	And "<part_no_ten>" has "ZIP" as "<postcode>"
	And "<part_no_ten>" has "DOB" as "01-JAN-1977"
	
	# Submit response in pool
	
	Given I have submitted a first party English straight through response
		|part_no		|pool_number|last_name	|postcode	|email 	|
		|<part_no_ten>	|<pool_no>	|<last_name>|<postcode>	|<email>|
		
	#update JUROR to responded
	Given "<part_no_ten>" has "RESPONDED" as "Y"
	Given "<part_no_ten>" has "STATUS" as "2"
	
	Given I am on "Bureau" "juror-test02" 	
	And I log in as "CPASS"
	
	When I click on the "Search" link
	And I set "Juror number" to "<part_no_ten>"
	And I press the "Search" button
	And I click on "<part_no_ten>" in the same row as "<part_no_ten>"
	
	#check I get a warning that the record is completed
	
	Then I see "Response Completed" on the page
	Then I see "This response has already been processed in Juror, please check the details are correct" on the page
	
	#ok message
	
	And I press the "Ok" button
	
	#check status on screen
	
	Then I see "Responded" on the page
	And I see "COMPLETED" on the page
	Then on "JUROR_MOD" . "JUROR_RESPONSE" I see "PROCESSING_STATUS" is "CLOSED" where "JUROR_NUMBER" is "<part_no_ten>"
	Then on "JUROR_MOD" . "JUROR_RESPONSE" I see "PROCESSING_COMPLETE" is "Y" where "JUROR_NUMBER" is "<part_no_ten>"
	
	#check record is now in "completed today"
	
	When I click on the "Your work" link
	Then I click on the "Completed" link
	Then I see "<part_no_ten>" on the page
	
Examples:
	|part_no_ten|pool_no	|last_name		|postcode	|email	|
	|645700296	|457170401	|LNAMETWOSIXZERO|CH1 2AN	|a@a.com|
	