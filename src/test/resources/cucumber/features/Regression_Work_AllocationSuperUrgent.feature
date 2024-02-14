Feature: Work Allocation Regression

@Regression @JDB-3747 @JDB-3744 
Scenario Outline: Check that Urgent ST is not auto assigned
	Given I am on "Public" "bau-test"
	Given the juror numbers have not been processed
		| part_no 	| pool_no 	| owner |
		| <part_no> |<pool_no>	| 400 	|
		
	And "<part_no>" has "LNAME" as "<last_name>" 
	And "<part_no>" has "RET_DATE" as "3 mondays time"
	And "<part_no>" has "NEXT_DATE" as "3 mondays time"
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
	When I set the radio button to "Yes"
	
	#Check Name
	
	When I press the "Continue" button
	Then I see "Is this your address?" on the page
	When I set the radio button to "Yes"
	
	#Check Address
	
	And I press the "Continue" button
	Then I see "What is your phone number?" on the page
	
	#Phone Details
	
	When I set "Main phone" to "0207 821 1818"
	And I press the "Continue" button
	Then I see "What is your email address?" on the page
	
	#Email
	
	When I set "Enter your email address" to "email@outlook.com"
	And I set "Enter your email address again" to "email@outlook.com"
	And I press the "Continue" button
	Then I see "What is your date of birth?" on the page
	
	#DoB
	
	When I press the "Continue" button
	When I set "Day" to "27"
	And I set "Month" to "04"
	And I set "Year" to "1981"
	And I press the "Continue" button
	Then I see "Confirm you're eligible for jury service" on the page
	
	When I press the "Continue" button
	
	#Residency
	
	Then I see "Since you turned 13, has your main address been in the UK, Channel Islands or Isle of Man for any period of at least 5 years?" on the page
	When I set the radio button to "Yes"
	And I press the "Continue" button
	
	#CJS
	
	Then I see "Have you worked in the criminal justice system in the last 5 years?" on the page
	When I set the radio button to "No"
	And I press the "Continue" button
	
	#Bail
	
	When I set the radio button to "No"
	And I press the "Continue" button
	
	#Convictions
	
	Then I see "Have you been found guilty of a criminal offence?" on the page
	When I set the radio button to "No"
	And I press the "Continue" button
	
	#Mental Health part 1
	
	Then I see "Are you being detained, looked after or treated under the Mental Health Act?" on the page
	When I set the radio button to "No"
	And I press the "Continue" button
	
	#Mental Health part 2
	
	When I set the radio button to "No"
	And I press the "Continue" button
	
	# Confirm Date of Jury
	
	Then I see "Check your start date" on the page
	When I set the radio button to "No, I cannot do jury service and need to be excused" 
	And I press the "Continue" button
	
	#Excusal Reason
	
	Then I see "Why do you need to be excused from jury service?" on the page
	When I set text area with "id" of "excusalReason" to "££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££"
	And I press the "Continue" button
	
	#RA
	
	Then I see "Will you need help when" on the page
	When I set the radio button to "No"
	And I press the "Continue" button
	
	#Check Your Answers Now
	
	Then I see "Check your answers now" on the page
	When I check the "The information" checkbox
	And I press the "Submit" button
	And I see "You have completed your reply" on the page
	
	#Bureau
	
	Given I am on "Bureau" "bau-test"
	And I log in
	And I click on the "Search" link
	And I set "Juror number" to "<part_no>"
	And I press the "Search" button
	Then I see "TO DO" in the same row as "<part_no>"
	When I click on "<part_no>" in the same row as "<part_no>"
	Then I see "URGENT" on the page
	
	Then on "JUROR_DIGITAL" . "JUROR_RESPONSE" I see "STAFF_LOGIN" is null where "JUROR_NUMBER" is "<part_no>"
	Then on "JUROR_DIGITAL" . "JUROR_RESPONSE" I see "STAFF_ASSIGNMENT_DATE" is null where "JUROR_NUMBER" is "<part_no>"
	
	#JDB-3744
	
	Then on "JUROR_DIGITAL" . "JUROR_RESPONSE" I see "URGENT" is "Y" where "JUROR_NUMBER" is "<part_no>"
	Then on "JUROR_DIGITAL" . "JUROR_RESPONSE" I see "SUPER_URGENT" is "N" where "JUROR_NUMBER" is "<part_no>"
	
Examples:
	|part_no	|last_name			|postcode	|email           	|pool_no	|
	|641500683	|LNAMESIXEIGHTTHREE	|CH1 2AN	|email@outlook.com	|415170601	|
	
@Regression @JDB-3747 @JDB-3744 
Scenario Outline: Check that Super Urgent ST is not auto assigned
	Given I am on "Public" "juror-test02"
	Given the juror numbers have not been processed
		| part_no 	| pool_no 	| owner |
		| <part_no> |<pool_no>	| 400 	|
	
	And "<part_no>" has "LNAME" as "<last_name>" 
	And "<part_no>" has "RET_DATE" as "2 mondays time"
	And "<part_no>" has "NEXT_DATE" as "2 mondays time"
	And "<part_no>" has "ZIP" as "<postcode>"
	And "<part_no>" has "READ_ONLY" as "Y"
	
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
	When I set the radio button to "Yes"
	
	#Check Name
	
	When I press the "Continue" button
	Then I see "Is this your address?" on the page
	When I set the radio button to "Yes"
	
	#Check Address
	
	And I press the "Continue" button
	Then I see "What is your phone number?" on the page
	
	#Phone Details
	
	When I set "Main phone" to "0207 821 1818"
	And I press the "Continue" button
	Then I see "What is your email address?" on the page
	
	#Email
	
	When I set "Enter your email address" to "email@outlook.com"
	And I set "Enter your email address again" to "email@outlook.com"
	And I press the "Continue" button
	Then I see "What is your date of birth?" on the page
	
	#DoB
	
	When I press the "Continue" button
	Then I see "Enter the day you were born" on the page
	And I do not see "Enter the month you were born" on the page
	And I do not see "Enter the year you were born" on the page
	When I set "Day" to "27"
	And I set "Month" to "04"
	And I set "Year" to "1981"
	And I press the "Continue" button
	Then I see "eligible for jury service" on the page
	
	When I press the "Continue" button
	Then I see "Since you turned 13, has your main address been in the UK, Channel Islands or Isle of Man for any period of at least 5 years?" on the page
	
	#Residency
	
	When I set the radio button to "Yes"
	And I press the "Continue" button
	
	#CJS
	
	Then I see "Have you worked in the criminal justice system in the last 5 years?" on the page
	When I set the radio button to "No"
	And I press the "Continue" button
	
	#Bail
	
	When I set the radio button to "No"
	And I press the "Continue" button
	Then I see "Have you been found guilty of a criminal offence?" on the page
	
	#Convictions
	
	When I set the radio button to "No"
	And I press the "Continue" button
	
	Then I see "Are you being detained, looked after or treated under the Mental Health Act?" on the page
	
	#Mental Health part 1
	
	When I set the radio button to "No"
	And I press the "Continue" button
	
	#Mental Health part 2
	
	When I set the radio button to "No"
	And I press the "Continue" button
	
	Then I see "Check your start date" on the page
	
	# Confirm Date of Jury
	
	When I set the radio button to "No, I cannot do jury service and need to be excused" 
	And I press the "Continue" button
	
	#Excusal Reason
	
	Then I see "Why do you need to be excused from jury service?" on the page
	When I set text area with "id" of "excusalReason" to "££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££"
	And I press the "Continue" button
	
	#RA
	
	Then I see "Will you need help when" on the page
	When I set the radio button to "No"
	And I press the "Continue" button
	Then I see "Check your answers now" on the page
	
	#Check Your Answers Now
	
	When I check the "The information" checkbox
	And I press the "Submit" button
	And I see "You have completed your reply" on the page
	
	#Bureau
	
	Given I am on "Bureau" "juror-test02"
	And I log in
	And I click on the "Search" link
	And I set "Juror number" to "<part_no>"
	And I press the "Search" button
	Then I see "TO DO" in the same row as "<part_no>"
	When I click on "<part_no>" in the same row as "<part_no>"
	Then I see "SEND TO COURT" on the page
	
	Then on "JUROR_DIGITAL" . "JUROR_RESPONSE" I see "STAFF_LOGIN" is null where "JUROR_NUMBER" is "<part_no>"
	Then on "JUROR_DIGITAL" . "JUROR_RESPONSE" I see "STAFF_ASSIGNMENT_DATE" is null where "JUROR_NUMBER" is "<part_no>"
	
	#JDB-3744
	
	Then on "JUROR_DIGITAL" . "JUROR_RESPONSE" I see "URGENT" is "N" where "JUROR_NUMBER" is "<part_no>"
	Then on "JUROR_DIGITAL" . "JUROR_RESPONSE" I see "SUPER_URGENT" is "Y" where "JUROR_NUMBER" is "<part_no>"
	
Examples:
	|part_no	|last_name			|postcode	|email          	|pool_no	|
	|641500711	|LNAMESEVENONEONE	|CH1 2AN	|email@outlook.com	|415170601	|