Feature: Regression English_ReplyTypesIndicator

#this test contains scenarios that test the reply types indicator which do not already exist in other scripts

@Regression @replytypes 
Scenario Outline: English 1st Party + Juror Details Change
	
	Given I am on "Public" "test"
	Given the juror numbers have not been processed
		| part_no 	| pool_no 	| owner |
		| <part_no> |<pool_no>	| 400 	|
		
	And "<part_no>" has "LNAME" as "<last_name>"
	And "<part_no>" has "RET_DATE" as "5 mondays time"
	And "<part_no>" has "NEXT_DATE" as "5 mondays time"
	And "<part_no>" has "ZIP" as "<postcode>"
	
	And I set the radio button to "I am replying for myself"

	And I press the "Continue" button

	And I see "Your juror details" on the page

	When I set "9-digit juror number" to "<part_no>"
	And I set "Juror last name" to "<last_name>"
	And I set "Juror postcode" to "<postcode>"
	And I press the "Continue" button

	And I set the radio button to "No"
	And I press the "Continue" button
	And I set "First name" to "Joe"
	And I set "Last name" to "Blogs"
	
	And I press the "Continue" button

	And I set the radio button to "No"
	When I press the "Continue" button
	And I set "Address line 1" to "99 The Road"
	And I set "Town or city" to "Town"
	
	When I press the "Continue" button

	When I set "Main phone" to "02078211818"
	And I press the "Continue" button
	
	When I set "Enter your email address" to "e@mail.com"
	When I set "Enter your email address again" to "e@mail.com"

	And I press the "Continue" button

	When I set "Day" to "01"
	And I set "Month" to "01"
	And I set "Year" to "1990"
	And I press the "Continue" button

	#Qualify for jury service
	
	#JDB-4636
	
	When I press the "Continue" button

	#Residency
	
	And I set the radio button to "Yes"
	And I press the "Continue" button
	
	#CJS

	When I set the radio button to "No"
	And I press the "Continue" button
	
	#Bail

	When I set the radio button to "No"
	And I press the "Continue" button
	
	#Convictions
	
	When I set the radio button to "No"
	And I press the "Continue" button
		
	#Mental Health Sectioned

	And I set the radio button to "No"
	And I press the "Continue" button
	
	#Mental Health Capacity
	
	And I set the radio button to "No"
	And I press the "Continue" button
	
	#I can attend

	And I set the radio button to "Yes, I can start on"
	And  I press the "Continue" button

	#RA no

	When I set the radio button to "No"
	And I press the "Continue" button
	
	#Check your answers
	
	And I check the "The information I have given is true to the best of my knowledge" checkbox
	And I press the "Submit" button
	Then I see "We have sent you an email to say you have replied to your jury summons." on the page
	And I see "Download a copy of your summons reply PDF (65KB)" on the page
	Then I click on the "Download a copy of your summons reply HTML (15KB)" link
	And I see "You answered the eligibility questions" on the page
	
	Given I am on "Bureau" "test"
	And I log in
	
	When I click on the "Search" link
	And I set "Juror number" to "<part_no>"
	And I press the "Search" button
	Then I see "<part_no>" on the page
	
	And I click link with ID "selectAllLink"
	And I press the "Send to..." button
	And I set input field with "id" of "sendToOfficer" to "CPASS"
	And I press the "Send" button
	And I press the "Send" button
	Then I see "Your work" on the page
	
	Then I click on the "Sign out" link
	When I log in as "CPASS"
	Then I see "<part_no>" on the page
	Then I see "<part_no>" has reply type indicator "NEEDS REVIEW"
	
	When I click on "<part_no>" in the same row as "<part_no>"
	And I see "NEEDS REVIEW" on the page
	
Examples:
	|part_no	|last_name	|postcode	|email 		|pool_no	|
	|645100925	|DOE		|SW1H 9AJ	|a@eeee.com	|451170401	|
	

@RegressionSingle @replytypes
Scenario Outline: English 1st Party + RA

	Given I am on "Public" "test"
	Given the juror numbers have not been processed
		| part_no 	| pool_no 	| owner |
		| <part_no> |<pool_no>	| 400 	|
	
	And "<part_no>" has "LNAME" as "<last_name>" 
	And "<part_no>" has "FNAME" as "FNAMESEVENONETHREE"
	And "<part_no>" has "RET_DATE" as "5 mondays time"
	And "<part_no>" has "NEXT_DATE" as "5 mondays time"
	And "<part_no>" has "Address" as "855 STREET NAME"
	And "<part_no>" has "Address4" as "LONDON"
	And "<part_no>" has "ZIP" as "<postcode>"
	
	Then I see "Reply to a jury summons" on the page
	
	And I set the radio button to "I am replying for myself"
	And I press the "Continue" button
	Then I see "Your juror details" on the page
	
	When I set "9-digit juror number" to "<part_no>"
	When I set "Juror last name" to "<last_name>"
	When I set "Juror postcode" to "<postcode>"
	And I press the "Continue" button
	
	Then I see "Is the name we have for you correct?" on the page
	And I set the radio button to "Yes"
	And I press the "Continue" button
	
	And I set the radio button to "Yes"
	And I press the "Continue" button
	
	When I set "Main phone" to "02078211818"
	And I press the "Continue" button

	When I set "Enter your email address" to "<email>"
	When I set "Enter your email address again" to "<email>"
	And I press the "Continue" button
	
	When I set "Day" to "27"
	And I set "Month" to "04"
	And I set "Year" to "1981"
	And I press the "Continue" button
	
	Then I see "Confirm you're eligible for jury service" on the page
	
	And I press the "Continue" button
	
	Then I see "Since you turned 13, has your main address been in the UK, Channel Islands or Isle of Man for any period of at least 5 years?" on the page
	And I set the radio button to "Yes"
	And I press the "Continue" button
	
	Then I see "Have you worked in the criminal justice system in the last 5 years?" on the page
	When I set the radio button to "No"
	And I press the "Continue" button
	
	And I see "Are you currently on bail for a criminal offence?" on the page
	When I set the radio button to "No"
	And I press the "Continue" button
	
	Then I see "Have you been found guilty of a criminal offence?" on the page
	When I set the radio button to "No"
	And I press the "Continue" button
	
	And I see "Are you being detained, looked after or treated under the Mental Health Act?" on the page
	When I set the radio button to "No"
	And I press the "Continue" button
	
	Then I see "Has it been decided that you 'lack mental capacity'?" on the page
	When I set the radio button to "No"
	And I press the "Continue" button
	
	#deferral
	
	When I set the radio button to "No, I need to change the date"
	And I press the "Continue" button

	When I set text area with "id" of "deferralReason" to "Deferral Reason"
	And I press the "Continue" button
	
	When I set the "First" single date field to a Monday "6" weeks in the future
	When I set the "Second" single date field to a Monday "7" weeks in the future
	When I set the "Third" single date field to a Monday "8" weeks in the future
	
	And I press the "Continue" button
	
	#check dates screen
	
	And I set the radio button to "Yes"
	And I press the "Continue" button

	Then I see "Will you need help when you're at the court?" on the page
	Then I see "Do you have a disability or impairment that means you’ll need extra support or facilities in the court building where you are doing your Jury Service?" on the page
	When I set the radio button to "Yes"
	Then I check the "Diabetes" checkbox
	And I press the "Continue" button
	Then I see "Check your answers now" on the page
	
	Then I check the "The information I have given is true to the best of my knowledge" checkbox
	
	When I press the "Submit" button
	
	Then I see "You have completed your reply" on the page
	Then I see "<part_no>" on the page
	
	Then on "JUROR_DIGITAL" . "JUROR_RESPONSE" I see "PROCESSING_STATUS" is "TODO" where "JUROR_NUMBER" is "<part_no>"
	Then on "JUROR_DIGITAL" . "JUROR_RESPONSE" I see "PROCESSING_COMPLETE" is "N" where "JUROR_NUMBER" is "<part_no>"
	
	Given I am on "Bureau" "test"
	And I log in
	
	When I click on the "Search" link
	And I set "Juror number" to "<part_no>"
	And I press the "Search" button
	Then I see "<part_no>" on the page
	
	And I click link with ID "selectAllLink"
	And I press the "Send to..." button
	And I set input field with "id" of "sendToOfficer" to "CPASS"
	And I press the "Send" button
	And I press the "Send" button
	Then I see "Your work" on the page
	
	Then I click on the "Sign out" link
	When I log in as "CPASS"
	Then I see "<part_no>" on the page
	Then I see "<part_no>" has reply type indicator "DEFERRAL"
	
	When I click on "<part_no>" in the same row as "<part_no>"
	And I see "DEFERRAL" on the page
	
Examples:
	|part_no	|pool_no	|last_name			|postcode	|email 		| 
	|645200610	|452170401	|LNAMESIXONEZERO	|SY2 6LU	|e@eeee.com	|
	
@Regression @replytypes 
Scenario Outline: English 1st Party + Residency

	Given I am on "Public" "test"
	Given the juror numbers have not been processed
		| part_no 	| pool_no 	| owner |
		| <part_no> |<pool_no>	| 400 	|
	
	And "<part_no>" has "LNAME" as "<last_name>" 
	And "<part_no>" has "FNAME" as "FNAMESEVENONETHREE"
	And "<part_no>" has "RET_DATE" as "5 mondays time"
	And "<part_no>" has "NEXT_DATE" as "5 mondays time"
	And "<part_no>" has "Address" as "855 STREET NAME"
	And "<part_no>" has "Address4" as "LONDON"
	And "<part_no>" has "ZIP" as "<postcode>"
	
	Then I see "Reply to a jury summons" on the page
	
	And I set the radio button to "I am replying for myself"
	And I press the "Continue" button
	Then I see "Your juror details" on the page
	
	When I set "9-digit juror number" to "<part_no>"
	When I set "Juror last name" to "<last_name>"
	When I set "Juror postcode" to "<postcode>"
	And I press the "Continue" button
	
	Then I see "Is the name we have for you correct?" on the page
	And I set the radio button to "Yes"
	And I press the "Continue" button
	
	And I set the radio button to "Yes"
	And I press the "Continue" button
	
	When I set "Main phone" to "02078211818"
	And I press the "Continue" button

	When I set "Enter your email address" to "<email>"
	When I set "Enter your email address again" to "<email>"
	And I press the "Continue" button
	
	When I set "Day" to "27"
	And I set "Month" to "04"
	And I set "Year" to "1981"
	And I press the "Continue" button
	
	Then I see "Confirm you're eligible for jury service" on the page
	
	And I press the "Continue" button
	
	Then I see "Since you turned 13, has your main address been in the UK, Channel Islands or Isle of Man for any period of at least 5 years?" on the page
	And I set the radio button to "No"
	And I set "Provide details" to "some reasons"
	And I press the "Continue" button
	
	Then I see "Have you worked in the criminal justice system in the last 5 years?" on the page
	When I set the radio button to "No"
	And I press the "Continue" button
	
	And I see "Are you currently on bail for a criminal offence?" on the page
	When I set the radio button to "No"
	And I press the "Continue" button
	
	Then I see "Have you been found guilty of a criminal offence?" on the page
	When I set the radio button to "No"
	And I press the "Continue" button
	
	And I see "Are you being detained, looked after or treated under the Mental Health Act?" on the page
	When I set the radio button to "No"
	And I press the "Continue" button
	
	Then I see "Has it been decided that you 'lack mental capacity'?" on the page
	When I set the radio button to "No"
	And I press the "Continue" button
	
	#Straight through
	
	When I set the radio button to "Yes"
	And I press the "Continue" button
	
	Then I see "Will you need help when you're at the court?" on the page
	Then I see "Do you have a disability or impairment that means you’ll need extra support or facilities in the court building where you are doing your Jury Service?" on the page
	When I set the radio button to "No"
	And I press the "Continue" button
	
	Then I see "Check your answers now" on the page
	Then I check the "The information I have given is true to the best of my knowledge" checkbox
	When I press the "Submit" button
	
	Then I see "You have completed your reply" on the page
	Then I see "<part_no>" on the page
	
	Then on "JUROR_DIGITAL" . "JUROR_RESPONSE" I see "PROCESSING_STATUS" is "TODO" where "JUROR_NUMBER" is "<part_no>"
	Then on "JUROR_DIGITAL" . "JUROR_RESPONSE" I see "PROCESSING_COMPLETE" is "N" where "JUROR_NUMBER" is "<part_no>"
	
	Given I am on "Bureau" "test"
	And I log in
	
	When I click on the "Search" link
	And I set "Juror number" to "<part_no>"
	And I press the "Search" button
	Then I see "<part_no>" on the page
	
	And I click link with ID "selectAllLink"
	And I press the "Send to..." button
	And I set input field with "id" of "sendToOfficer" to "CPASS"
	And I press the "Send" button
	And I press the "Send" button
	Then I see "Your work" on the page
	
	Then I click on the "Sign out" link
	When I log in as "CPASS"
	Then I see "<part_no>" on the page
	Then I see "<part_no>" has reply type indicator "INELIGIBLE"
	
	When I click on "<part_no>" in the same row as "<part_no>"
	And I see "INELIGIBLE" on the page
	
Examples:
	|part_no	|pool_no	|last_name			|postcode	|email 		| 
	|645200637	|452170401	|LNAMESIXTHREESEVEN	|SY2 6LU	|e@eeee.com	|

@Regression @replytypes 
Scenario Outline: English 1st Party + Bail

	Given I am on "Public" "test"
	Given the juror numbers have not been processed
		| part_no 	| pool_no 	| owner |
		| <part_no> |<pool_no>	| 400 	|
	
	And "<part_no>" has "LNAME" as "<last_name>" 
	And "<part_no>" has "FNAME" as "FNAMESEVENONETHREE"
	And "<part_no>" has "RET_DATE" as "5 mondays time"
	And "<part_no>" has "NEXT_DATE" as "5 mondays time"
	And "<part_no>" has "Address" as "855 STREET NAME"
	And "<part_no>" has "Address4" as "LONDON"
	And "<part_no>" has "ZIP" as "<postcode>"
	
	Then I see "Reply to a jury summons" on the page
	
	And I set the radio button to "I am replying for myself"
	And I press the "Continue" button
	Then I see "Your juror details" on the page
	
	When I set "9-digit juror number" to "<part_no>"
	When I set "Juror last name" to "<last_name>"
	When I set "Juror postcode" to "<postcode>"
	And I press the "Continue" button
	
	Then I see "Is the name we have for you correct?" on the page
	And I set the radio button to "Yes"
	And I press the "Continue" button
	
	And I set the radio button to "Yes"
	And I press the "Continue" button
	
	When I set "Main phone" to "02078211818"
	And I press the "Continue" button

	When I set "Enter your email address" to "<email>"
	When I set "Enter your email address again" to "<email>"
	And I press the "Continue" button
	
	When I set "Day" to "27"
	And I set "Month" to "04"
	And I set "Year" to "1981"
	And I press the "Continue" button
	
	Then I see "Confirm you're eligible for jury service" on the page
	
	And I press the "Continue" button
	
	Then I see "Since you turned 13, has your main address been in the UK, Channel Islands or Isle of Man for any period of at least 5 years?" on the page
	And I set the radio button to "Yes"
	And I press the "Continue" button
	
	Then I see "Have you worked in the criminal justice system in the last 5 years?" on the page
	When I set the radio button to "No"
	And I press the "Continue" button
	
	And I see "Are you currently on bail for a criminal offence?" on the page
	When I set the radio button to "Yes"
	Then I set "Provide details about your bail and criminal offence" to "some details"
	And I press the "Continue" button
	
	Then I see "Have you been found guilty of a criminal offence?" on the page
	When I set the radio button to "No"
	And I press the "Continue" button
	
	And I see "Are you being detained, looked after or treated under the Mental Health Act?" on the page
	When I set the radio button to "No"
	And I press the "Continue" button
	
	Then I see "Has it been decided that you 'lack mental capacity'?" on the page
	When I set the radio button to "No"
	And I press the "Continue" button
	
	#Straight through
	
	When I set the radio button to "Yes"
	And I press the "Continue" button
	
	Then I see "Will you need help when you're at the court?" on the page
	Then I see "Do you have a disability or impairment that means you’ll need extra support or facilities in the court building where you are doing your Jury Service?" on the page
	When I set the radio button to "No"
	And I press the "Continue" button
	
	Then I see "Check your answers now" on the page
	Then I check the "The information I have given is true to the best of my knowledge" checkbox
	When I press the "Submit" button
	
	Then I see "You have completed your reply" on the page
	Then I see "<part_no>" on the page
	
	Then on "JUROR_DIGITAL" . "JUROR_RESPONSE" I see "PROCESSING_STATUS" is "TODO" where "JUROR_NUMBER" is "<part_no>"
	Then on "JUROR_DIGITAL" . "JUROR_RESPONSE" I see "PROCESSING_COMPLETE" is "N" where "JUROR_NUMBER" is "<part_no>"
	
	Given I am on "Bureau" "test"
	And I log in
	
	When I click on the "Search" link
	And I set "Juror number" to "<part_no>"
	And I press the "Search" button
	Then I see "<part_no>" on the page
	
	And I click link with ID "selectAllLink"
	And I press the "Send to..." button
	And I set input field with "id" of "sendToOfficer" to "CPASS"
	And I press the "Send" button
	And I press the "Send" button
	Then I see "Your work" on the page
	
	Then I click on the "Sign out" link
	When I log in as "CPASS"
	Then I see "<part_no>" on the page
	Then I see "<part_no>" has reply type indicator "INELIGIBLE"
	
	When I click on "<part_no>" in the same row as "<part_no>"
	And I see "INELIGIBLE" on the page
	
Examples:
	|part_no	|pool_no	|last_name			|postcode	|email 		| 
	|645200637	|452170401	|LNAMESIXTHREESEVEN	|SY2 6LU	|e@eeee.com	|

@Features
Scenario Outline: English 3rd Party + Convictions

	#moved into features 02-01-24 to return to Regression

	Given I am on "Public" "test"
	Given the juror numbers have not been processed
		| part_no 	| pool_no 	| owner |
		| <part_no> |<pool_no>	| 400 	|
		
	And "<part_no>" has "LNAME" as "<last_name>" 
	And "<part_no>" has "RET_DATE" as "5 mondays time"
	And "<part_no>" has "NEXT_DATE" as "5 mondays time"
	And "<part_no>" has "ZIP" as "<postcode>"

	And I set the radio button to "I am replying for someone else"
	And I press the "Continue" button
	
	#Juror Log In
	
	When I set "9-digit juror number" to "<part_no>"
	When I set "Juror last name" to "<last_name>"
	When I set "Juror postcode" to "<postcode>"
	And I press the "Continue" button
	
	#3rd Party Name
	
	When I set "First name" to "FirstNameA"
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
	
	#Why are you replying for the person?
	
	When I set the radio button to "The person is not here"
	And I press the "Continue" button
	
	#Check juror name

	And I set the radio button to "Yes"
	And I press the "Continue" button
	
	#Check juror address

	And I set the radio button to "Yes"
	And I press the "Continue" button
	
	#DoB
	
	And I set "Day" to "01"
	And I set "Month" to "01"
	And I set "Year" to "1980"
	And I press the "Continue" button

	#Contacting the juror

	And I set the radio button to "Use the phone number that you have already given to contact you"
	And I set the radio button to "Use the email address that you have already given to contact you"
	And I press the "Continue" button
	
	#Qualify for jury service

	And I press the "Continue" button
	
	#Residency

	And I set the radio button to "Yes"
	And I press the "Continue" button
	
	#CJS
	When I set the radio button to "No"
	And I press the "Continue" button
	
	#Bail

	And I set the radio button to "No"
	And I press the "Continue" button
	
	#Convictions

	When I set the radio button to "Yes"
	And I set text area with "id" of "convictedDetails" to "I am a convicted criminal"
	And I press the "Continue" button
	
	#Mental Health Sectioned

	And I set the radio button to "No"
	And I press the "Continue" button
	
	#Mental Health Capacity

	And I set the radio button to "No"
	And I press the "Continue" button
	
	#Confirm Date of Jury

	When I set the radio button to "Yes"   
	And I press the "Continue" button
	
	#RA

	When I set the radio button to "No"
	And I press the "Continue" button
	
	#Check Your Answers
	
	When I check the "The answers I have given for the person I'm replying for are true as far as I know" checkbox
	And I press the "Submit" button
	And I see "You have completed your reply" on the page
	
	Given I am on "Bureau" "test"
	And I log in
	
	When I click on the "Search" link
	And I set "Juror number" to "<part_no>"
	And I press the "Search" button
	Then I see "<part_no>" on the page
	
	And I click link with ID "selectAllLink"
	And I press the "Send to..." button
	And I set input field with "id" of "sendToOfficer" to "CPASS"
	And I press the "Send" button
	And I press the "Send" button
	Then I see "Your work" on the page
	
	Then I click on the "Sign out" link
	When I log in as "CPASS"
	Then I see "<part_no>" on the page
	Then I see "<part_no>" has reply type indicator "INELIGIBLE"
	
	When I click on "<part_no>" in the same row as "<part_no>"
	And I see "INELIGIBLE" on the page
	
Examples:
	|part_no	|last_name			|postcode	|email       	    |pool_no	|
	|645200694	|LNAMESIXNINEFOUR	|SY2 6LU	|email@outlook.com	|452170401	|
	
@Regression @replytypes 
Scenario Outline: English 3rd Party + Residency
	Given I am on "Public" "test"
	Given the juror numbers have not been processed
		| part_no 	| pool_no 	| owner |
		| <part_no> |<pool_no>	| 400 	|
		
	And "<part_no>" has "LNAME" as "<last_name>" 
	And "<part_no>" has "RET_DATE" as "5 mondays time"
	And "<part_no>" has "NEXT_DATE" as "5 mondays time"
	And "<part_no>" has "ZIP" as "<postcode>"

	And I set the radio button to "I am replying for someone else"
	And I press the "Continue" button
	
	#Juror Log In
	
	When I set "9-digit juror number" to "<part_no>"
	When I set "Juror last name" to "<last_name>"
	When I set "Juror postcode" to "<postcode>"
	And I press the "Continue" button
	
	#3rd Party Name
	
	When I set "First name" to "FirstNameA"
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
	
	#Why are you replying for the person?
	
	When I set the radio button to "The person is not here"
	And I press the "Continue" button
	
	#Check juror name

	And I set the radio button to "Yes"
	And I press the "Continue" button
	
	#Check juror address

	And I set the radio button to "Yes"
	And I press the "Continue" button
	
	#DoB
	
	And I set "Day" to "01"
	And I set "Month" to "01"
	And I set "Year" to "1980"
	And I press the "Continue" button

	#Contacting the juror

	And I set the radio button to "Use the phone number that you have already given to contact you"
	And I set the radio button to "Use the email address that you have already given to contact you"
	And I press the "Continue" button
	
	#Qualify for jury service

	And I press the "Continue" button
	
	#Residency

	And I set the radio button to "No"
	And I set "Provide details about where the person you are answering for has lived since their 13th birthday" to "some details"
	And I press the "Continue" button
	
	#CJS
	When I set the radio button to "No"
	And I press the "Continue" button
	
	#Bail

	And I set the radio button to "No"
	And I press the "Continue" button
	
	#Convictions

	When I set the radio button to "No"
	And I press the "Continue" button
	
	#Mental Health Sectioned

	And I set the radio button to "No"
	And I press the "Continue" button
	
	#Mental Health Capacity

	And I set the radio button to "No"
	And I press the "Continue" button
	
	#Confirm Date of Jury

	When I set the radio button to "Yes"   
	And I press the "Continue" button
	
	#RA

	When I set the radio button to "No"
	And I press the "Continue" button
	
	#Check Your Answers
	
	When I check the "The answers I have given for the person I'm replying for are true as far as I know" checkbox
	And I press the "Submit" button
	And I see "You have completed your reply" on the page
	
	Given I am on "Bureau" "test"
	And I log in
	
	When I click on the "Search" link
	And I set "Juror number" to "<part_no>"
	And I press the "Search" button
	Then I see "<part_no>" on the page
	
	And I click link with ID "selectAllLink"
	And I press the "Send to..." button
	And I set input field with "id" of "sendToOfficer" to "CPASS"
	And I press the "Send" button
	And I press the "Send" button
	Then I see "Your work" on the page
	
	Then I click on the "Sign out" link
	When I log in as "CPASS"
	Then I see "<part_no>" on the page
	Then I see "<part_no>" has reply type indicator "INELIGIBLE"
	
	When I click on "<part_no>" in the same row as "<part_no>"
	And I see "INELIGIBLE" on the page
	
Examples:
	|part_no	|last_name			|postcode	|email       	    |pool_no	|
	|645200720	|LNAMESEVENTWOZERO	|SY2 6LU	|email@outlook.com	|452170401	|

@Regression @replytypes 
Scenario Outline: English 3rd Party + Bail
	Given I am on "Public" "test"
	Given the juror numbers have not been processed
		| part_no 	| pool_no 	| owner |
		| <part_no> |<pool_no>	| 400 	|
		
	And "<part_no>" has "LNAME" as "<last_name>" 
	And "<part_no>" has "RET_DATE" as "5 mondays time"
	And "<part_no>" has "NEXT_DATE" as "5 mondays time"
	And "<part_no>" has "ZIP" as "<postcode>"

	And I set the radio button to "I am replying for someone else"
	And I press the "Continue" button
	
	#Juror Log In
	
	When I set "9-digit juror number" to "<part_no>"
	When I set "Juror last name" to "<last_name>"
	When I set "Juror postcode" to "<postcode>"
	And I press the "Continue" button
	
	#3rd Party Name
	
	When I set "First name" to "FirstNameA"
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
	
	#Why are you replying for the person?
	
	When I set the radio button to "The person is not here"
	And I press the "Continue" button
	
	#Check juror name

	And I set the radio button to "Yes"
	And I press the "Continue" button
	
	#Check juror address

	And I set the radio button to "Yes"
	And I press the "Continue" button
	
	#DoB
	
	And I set "Day" to "01"
	And I set "Month" to "01"
	And I set "Year" to "1980"
	And I press the "Continue" button

	#Contacting the juror

	And I set the radio button to "Use the phone number that you have already given to contact you"
	And I set the radio button to "Use the email address that you have already given to contact you"
	And I press the "Continue" button
	
	#Qualify for jury service

	And I press the "Continue" button
	
	#Residency

	And I set the radio button to "Yes"
	And I press the "Continue" button
	
	#CJS
	When I set the radio button to "No"
	And I press the "Continue" button
	
	#Bail

	And I set the radio button to "Yes"
	And I set "Provide details about the person's bail and criminal offence" to "some details"
	And I press the "Continue" button
	
	#Convictions

	When I set the radio button to "No"
	And I press the "Continue" button
	
	#Mental Health Sectioned

	And I set the radio button to "No"
	And I press the "Continue" button
	
	#Mental Health Capacity

	And I set the radio button to "No"
	And I press the "Continue" button
	
	#Confirm Date of Jury

	When I set the radio button to "Yes"   
	And I press the "Continue" button
	
	#RA

	When I set the radio button to "No"
	And I press the "Continue" button
	
	#Check Your Answers
	
	When I check the "The answers I have given for the person I'm replying for are true as far as I know" checkbox
	And I press the "Submit" button
	And I see "You have completed your reply" on the page
	
	Given I am on "Bureau" "test"
	And I log in
	
	When I click on the "Search" link
	And I set "Juror number" to "<part_no>"
	And I press the "Search" button
	Then I see "<part_no>" on the page
	
	And I click link with ID "selectAllLink"
	And I press the "Send to..." button
	And I set input field with "id" of "sendToOfficer" to "CPASS"
	And I press the "Send" button
	And I press the "Send" button
	Then I see "Your work" on the page
	
	Then I click on the "Sign out" link
	When I log in as "CPASS"
	Then I see "<part_no>" on the page
	Then I see "<part_no>" has reply type indicator "INELIGIBLE"
	
	When I click on "<part_no>" in the same row as "<part_no>"
	And I see "INELIGIBLE" on the page
	
Examples:
	|part_no	|last_name				|postcode	|email       	    |pool_no	|
	|645200743	|LNAMESEVENFOURTHREE	|SY2 6LU	|email@outlook.com	|452170401	|

@Regression @replytypes 
Scenario Outline: English 3rd Party + Mental Health
	Given I am on "Public" "test"
	Given the juror numbers have not been processed
		| part_no 	| pool_no 	| owner |
		| <part_no> |<pool_no>	| 400 	|
		
	And "<part_no>" has "LNAME" as "<last_name>" 
	And "<part_no>" has "RET_DATE" as "5 mondays time"
	And "<part_no>" has "NEXT_DATE" as "5 mondays time"
	And "<part_no>" has "ZIP" as "<postcode>"

	And I set the radio button to "I am replying for someone else"
	And I press the "Continue" button
	
	#Juror Log In
	
	When I set "9-digit juror number" to "<part_no>"
	When I set "Juror last name" to "<last_name>"
	When I set "Juror postcode" to "<postcode>"
	And I press the "Continue" button
	
	#3rd Party Name
	
	When I set "First name" to "FirstNameA"
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
	
	#Why are you replying for the person?
	
	When I set the radio button to "The person is not here"
	And I press the "Continue" button
	
	#Check juror name

	And I set the radio button to "Yes"
	And I press the "Continue" button
	
	#Check juror address

	And I set the radio button to "Yes"
	And I press the "Continue" button
	
	#DoB
	
	And I set "Day" to "01"
	And I set "Month" to "01"
	And I set "Year" to "1980"
	And I press the "Continue" button

	#Contacting the juror

	And I set the radio button to "Use the phone number that you have already given to contact you"
	And I set the radio button to "Use the email address that you have already given to contact you"
	And I press the "Continue" button
	
	#Qualify for jury service

	And I press the "Continue" button
	
	#Residency

	And I set the radio button to "Yes"
	And I press the "Continue" button
	
	#CJS
	When I set the radio button to "No"
	And I press the "Continue" button
	
	#Bail

	And I set the radio button to "No"
	And I press the "Continue" button
	
	#Convictions

	When I set the radio button to "No"
	And I press the "Continue" button
	
	#Mental Health Sectioned

	And I set the radio button to "Yes"
	And I set "Provide details about how they're being detained, looked after or treated under the Mental Health Act" to "some details"
	And I press the "Continue" button
	
	#Mental Health Capacity

	And I set the radio button to "Yes"
	And I set "Provide brief details about why it was decided they lack mental capacity" to "some details"
	And I press the "Continue" button
	
	#Confirm Date of Jury

	When I set the radio button to "Yes"   
	And I press the "Continue" button
	
	#RA

	When I set the radio button to "No"
	And I press the "Continue" button
	
	#Check Your Answers
	
	When I check the "The answers I have given for the person I'm replying for are true as far as I know" checkbox
	And I press the "Submit" button
	And I see "You have completed your reply" on the page
	
	Given I am on "Bureau" "test"
	And I log in
	
	When I click on the "Search" link
	And I set "Juror number" to "<part_no>"
	And I press the "Search" button
	Then I see "<part_no>" on the page
	
	And I click link with ID "selectAllLink"
	And I press the "Send to..." button
	And I set input field with "id" of "sendToOfficer" to "CPASS"
	And I press the "Send" button
	And I press the "Send" button
	Then I see "Your work" on the page
	
	Then I click on the "Sign out" link
	When I log in as "CPASS"
	Then I see "<part_no>" on the page
	Then I see "<part_no>" has reply type indicator "INELIGIBLE"
	
	When I click on "<part_no>" in the same row as "<part_no>"
	And I see "INELIGIBLE" on the page
	
Examples:
	|part_no	|last_name				|postcode	|email       	    |pool_no	|
	|645200748	|LNAMESEVENFOUREIGHT   	|SY2 6LU	|email@outlook.com	|452170401	|
	
@Features
Scenario Outline: Multiple reply types

	#moved into Features 03-01-24 to return to Regression

	Given I am on "Public" "test"

	Given auto straight through processing has been enabled
	Given the juror numbers have not been processed
		|part_no 			|pool_no 		|owner 	|
		|<part_no> 			|<pool_no>		|400 	|
		|<part_no_two> 		|<pool_no>		|400 	|
		|<part_no_three>	|<pool_no>		|400 	|
		|<part_no_four>		|<pool_no>		|400 	|
		|<part_no_five> 	|<pool_no>		|400 	|
		|<part_no_six> 		|<pool_no>		|400 	|
		|<part_no_seven>	|<pool_no_two>	|400 	|
		|<part_no_eight>	|<pool_no>		|400 	|
		|<part_no_nine>		|<pool_no_three>|400 	|
		|<part_no_ten>		|<pool_no>		|400 	|
		|<part_no_eleven>	|<pool_no>		|400 	|

	And "<part_no>" has "LNAME" as "<last_name>"
	And "<part_no>" has "RET_DATE" as "5 mondays time"
	And "<part_no>" has "NEXT_DATE" as "5 mondays time"
	And "<part_no>" has "ZIP" as "<postcode>"

	And "<part_no_two>" has "LNAME" as "<last_name>"
	And "<part_no_two>" has "RET_DATE" as "5 mondays time"
	And "<part_no_two>" has "NEXT_DATE" as "5 mondays time"
	And "<part_no_two>" has "ZIP" as "<postcode>"

	And "<part_no_three>" has "LNAME" as "<last_name>"
	And "<part_no_three>" has "RET_DATE" as "5 mondays time"
	And "<part_no_three>" has "NEXT_DATE" as "5 mondays time"
	And "<part_no_three>" has "ZIP" as "<postcode>"

	And "<part_no_four>" has "LNAME" as "<last_name>"
	And "<part_no_four>" has "RET_DATE" as "5 mondays time"
	And "<part_no_four>" has "NEXT_DATE" as "5 mondays time"
	And "<part_no_four>" has "ZIP" as "<postcode>"

	And "<part_no_five>" has "LNAME" as "<last_name>"
	And "<part_no_five>" has "RET_DATE" as "5 mondays time"
	And "<part_no_five>" has "NEXT_DATE" as "5 mondays time"
	And "<part_no_five>" has "ZIP" as "<postcode>"

	And "<part_no_six>" has "LNAME" as "<last_name>"
	And "<part_no_six>" has "RET_DATE" as "5 mondays time"
	And "<part_no_six>" has "NEXT_DATE" as "5 mondays time"
	And "<part_no_six>" has "ZIP" as "<postcode>"

	And "<part_no_seven>" has "LNAME" as "<last_name>"
	And "<part_no_seven>" has "RET_DATE" as "5 mondays time"
	And "<part_no_seven>" has "NEXT_DATE" as "5 mondays time"
	And "<part_no_seven>" has "ZIP" as "<postcode>"

	And "<part_no_eight>" has "LNAME" as "<last_name>"
	And "<part_no_eight>" has "RET_DATE" as "5 mondays time"
	And "<part_no_eight>" has "NEXT_DATE" as "5 mondays time"
	And "<part_no_eight>" has "ZIP" as "<postcode>"

	And "<part_no_nine>" has "LNAME" as "<last_name>"
	And "<part_no_nine>" has "RET_DATE" as "5 mondays time"
	And "<part_no_nine>" has "NEXT_DATE" as "5 mondays time"
	And "<part_no_nine>" has "ZIP" as "<postcode>"

	And "<part_no_ten>" has "LNAME" as "<last_name>"
	And "<part_no_ten>" has "RET_DATE" as "5 mondays time"
	And "<part_no_ten>" has "NEXT_DATE" as "5 mondays time"
	And "<part_no_ten>" has "ZIP" as "<postcode>"

	And "<part_no_eleven>" has "LNAME" as "<last_name>"
	And "<part_no_eleven>" has "RET_DATE" as "5 mondays time"
	And "<part_no_eleven>" has "NEXT_DATE" as "5 mondays time"
	And "<part_no_eleven>" has "ZIP" as "<postcode>"

	#RESPONSE 1
	#3rd party MH

#	Given I am on "Public" "test"
	Given I am on "Public" "test"

	And I set the radio button to "I am replying for someone else"
	And I press the "Continue" button

	#Juror Log In

	When I set "9-digit juror number" to "<part_no>"
	When I set "Juror last name" to "<last_name>"
	When I set "Juror postcode" to "<postcode>"
	And I press the "Continue" button

	#3rd Party Name

	When I set "First name" to "FirstNameA"
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

	#Why are you replying for the person?

	When I set the radio button to "The person is not here"
	And I press the "Continue" button

	#Check juror name

	And I set the radio button to "Yes"
	And I press the "Continue" button

	#Check juror address

	And I set the radio button to "Yes"
	And I press the "Continue" button

	#DoB

	And I set "Day" to "01"
	And I set "Month" to "01"
	And I set "Year" to "1980"
	And I press the "Continue" button

	#Contacting the juror

	And I set the radio button to "Use the phone number that you have already given to contact you"
	And I set the radio button to "Use the email address that you have already given to contact you"
	And I press the "Continue" button

	#Qualify for jury service

	And I press the "Continue" button

	#Residency

	And I set the radio button to "Yes"
	And I press the "Continue" button

	#CJS
	When I set the radio button to "No"
	And I press the "Continue" button

	#Bail

	And I set the radio button to "No"
	And I press the "Continue" button

	#Convictions

	When I set the radio button to "No"
	And I press the "Continue" button

	#Mental Health Sectioned

	And I set the radio button to "Yes"
	And I set "Provide details about how they're being detained, looked after or treated under the Mental Health Act" to "some details"
	And I press the "Continue" button

	#Mental Health Capacity

	And I set the radio button to "Yes"
	And I set "Provide brief details about why it was decided they lack mental capacity" to "some details"
	And I press the "Continue" button

	#Confirm Date of Jury

	When I set the radio button to "Yes"
	And I press the "Continue" button

	#RA

	When I set the radio button to "No"
	And I press the "Continue" button

	#Check Your Answers

	When I check the "The answers I have given for the person I'm replying for are true as far as I know" checkbox
	And I press the "Submit" button
	And I see "You have completed your reply" on the page

	#RESPONSE 2
	#3rd party bail

#	Given I am on "Public" "test"
	Given I am on "Public" "test"

	And I set the radio button to "I am replying for someone else"
	And I press the "Continue" button

	#Juror Log In

	When I set "9-digit juror number" to "<part_no_two>"
	When I set "Juror last name" to "<last_name>"
	When I set "Juror postcode" to "<postcode>"
	And I press the "Continue" button

	#3rd Party Name

	When I set "First name" to "FirstNameA"
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

	#Why are you replying for the person?

	When I set the radio button to "The person is not here"
	And I press the "Continue" button

	#Check juror name

	And I set the radio button to "Yes"
	And I press the "Continue" button

	#Check juror address

	And I set the radio button to "Yes"
	And I press the "Continue" button

	#DoB

	And I set "Day" to "01"
	And I set "Month" to "01"
	And I set "Year" to "1980"
	And I press the "Continue" button

	#Contacting the juror

	And I set the radio button to "Use the phone number that you have already given to contact you"
	And I set the radio button to "Use the email address that you have already given to contact you"
	And I press the "Continue" button

	#Qualify for jury service

	And I press the "Continue" button

	#Residency

	And I set the radio button to "Yes"
	And I press the "Continue" button

	#CJS
	When I set the radio button to "No"
	And I press the "Continue" button

	#Bail

	And I set the radio button to "Yes"
	And I set "Provide details about the person's bail and criminal offence" to "some details"
	And I press the "Continue" button

	#Convictions

	When I set the radio button to "No"
	And I press the "Continue" button

	#Mental Health Sectioned

	And I set the radio button to "No"
	And I press the "Continue" button

	#Mental Health Capacity

	And I set the radio button to "No"
	And I press the "Continue" button

	#Confirm Date of Jury

	When I set the radio button to "Yes"
	And I press the "Continue" button

	#RA

	When I set the radio button to "No"
	And I press the "Continue" button

	#Check Your Answers

	When I check the "The answers I have given for the person I'm replying for are true as far as I know" checkbox
	And I press the "Submit" button
	And I see "You have completed your reply" on the page

	#RESPONSE 3
	#3rd party residency

#	Given I am on "Public" "test"
	Given I am on "Public" "test"

	And I set the radio button to "I am replying for someone else"
	And I press the "Continue" button

	#Juror Log In

	When I set "9-digit juror number" to "<part_no_three>"
	When I set "Juror last name" to "<last_name>"
	When I set "Juror postcode" to "<postcode>"
	And I press the "Continue" button

	#3rd Party Name

	When I set "First name" to "FirstNameA"
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

	#Why are you replying for the person?

	When I set the radio button to "The person is not here"
	And I press the "Continue" button

	#Check juror name

	And I set the radio button to "Yes"
	And I press the "Continue" button

	#Check juror address

	And I set the radio button to "Yes"
	And I press the "Continue" button

	#DoB

	And I set "Day" to "01"
	And I set "Month" to "01"
	And I set "Year" to "1980"
	And I press the "Continue" button

	#Contacting the juror

	And I set the radio button to "Use the phone number that you have already given to contact you"
	And I set the radio button to "Use the email address that you have already given to contact you"
	And I press the "Continue" button

	#Qualify for jury service

	And I press the "Continue" button

	#Residency

	And I set the radio button to "No"
	And I set "Provide details about where the person you are answering for has lived since their 13th birthday" to "some details"
	And I press the "Continue" button

	#CJS
	When I set the radio button to "No"
	And I press the "Continue" button

	#Bail

	And I set the radio button to "No"
	And I press the "Continue" button

	#Convictions

	When I set the radio button to "No"
	And I press the "Continue" button

	#Mental Health Sectioned

	And I set the radio button to "No"
	And I press the "Continue" button

	#Mental Health Capacity

	And I set the radio button to "No"
	And I press the "Continue" button

	#Confirm Date of Jury

	When I set the radio button to "Yes"
	And I press the "Continue" button

	#RA

	When I set the radio button to "No"
	And I press the "Continue" button

	#Check Your Answers

	When I check the "The answers I have given for the person I'm replying for are true as far as I know" checkbox
	And I press the "Submit" button
	And I see "You have completed your reply" on the page

	#RESPONSE 4
	#3rd party convictions

#	Given I am on "Public" "test"
	Given I am on "Public" "test"

	And I set the radio button to "I am replying for someone else"
	And I press the "Continue" button

	#Juror Log In

	When I set "9-digit juror number" to "<part_no_four>"
	When I set "Juror last name" to "<last_name>"
	When I set "Juror postcode" to "<postcode>"
	And I press the "Continue" button

	#3rd Party Name

	When I set "First name" to "FirstNameA"
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

	#Why are you replying for the person?

	When I set the radio button to "The person is not here"
	And I press the "Continue" button

	#Check juror name

	And I set the radio button to "Yes"
	And I press the "Continue" button

	#Check juror address

	And I set the radio button to "Yes"
	And I press the "Continue" button

	#DoB

	And I set "Day" to "01"
	And I set "Month" to "01"
	And I set "Year" to "1980"
	And I press the "Continue" button

	#Contacting the juror

	And I set the radio button to "Use the phone number that you have already given to contact you"
	And I set the radio button to "Use the email address that you have already given to contact you"
	And I press the "Continue" button

	#Qualify for jury service

	And I press the "Continue" button

	#Residency

	And I set the radio button to "Yes"
	And I press the "Continue" button

	#CJS
	When I set the radio button to "No"
	And I press the "Continue" button

	#Bail

	And I set the radio button to "No"
	And I press the "Continue" button

	#Convictions

	When I set the radio button to "Yes"
	And I set text area with "id" of "convictedDetails" to "I am a convicted criminal"
	And I press the "Continue" button

	#Mental Health Sectioned

	And I set the radio button to "No"
	And I press the "Continue" button

	#Mental Health Capacity

	And I set the radio button to "No"
	And I press the "Continue" button

	#Confirm Date of Jury

	When I set the radio button to "Yes"
	And I press the "Continue" button

	#RA

	When I set the radio button to "No"
	And I press the "Continue" button

	#Check Your Answers

	When I check the "The answers I have given for the person I'm replying for are true as far as I know" checkbox
	And I press the "Submit" button
	And I see "You have completed your reply" on the page

	#RESPONSE 5
	#1st bail

#	Given I am on "Public" "test"
	Given I am on "Public" "test"

	And I set the radio button to "I am replying for myself"
	And I press the "Continue" button
	Then I see "Your juror details" on the page

	When I set "9-digit juror number" to "<part_no_five>"
	When I set "Juror last name" to "<last_name>"
	When I set "Juror postcode" to "<postcode>"
	And I press the "Continue" button

	Then I see "Is the name we have for you correct?" on the page
	And I set the radio button to "Yes"
	And I press the "Continue" button

	And I set the radio button to "Yes"
	And I press the "Continue" button

	When I set "Main phone" to "02078211818"
	And I press the "Continue" button

	When I set "Enter your email address" to "<email>"
	When I set "Enter your email address again" to "<email>"
	And I press the "Continue" button

	When I set "Day" to "27"
	And I set "Month" to "04"
	And I set "Year" to "1981"
	And I press the "Continue" button

	Then I see "Confirm you're eligible for jury service" on the page

	And I press the "Continue" button

	Then I see "Since you turned 13, has your main address been in the UK, Channel Islands or Isle of Man for any period of at least 5 years?" on the page
	And I set the radio button to "Yes"
	And I press the "Continue" button

	Then I see "Have you worked in the criminal justice system in the last 5 years?" on the page
	When I set the radio button to "No"
	And I press the "Continue" button

	And I see "Are you currently on bail for a criminal offence?" on the page
	When I set the radio button to "Yes"
	Then I set "Provide details about your bail and criminal offence" to "some details"
	And I press the "Continue" button

	Then I see "Have you been found guilty of a criminal offence?" on the page
	When I set the radio button to "No"
	And I press the "Continue" button

	And I see "Are you being detained, looked after or treated under the Mental Health Act?" on the page
	When I set the radio button to "No"
	And I press the "Continue" button

	Then I see "Has it been decided that you 'lack mental capacity'?" on the page
	When I set the radio button to "No"
	And I press the "Continue" button

	#Straight through

	When I set the radio button to "Yes"
	And I press the "Continue" button

	Then I see "Will you need help when you're at the court?" on the page
	Then I see "Do you have a disability or impairment that means you’ll need extra support or facilities in the court building where you are doing your Jury Service?" on the page
	When I set the radio button to "No"
	And I press the "Continue" button

	Then I see "Check your answers now" on the page
	Then I check the "The information I have given is true to the best of my knowledge" checkbox
	When I press the "Submit" button

	Then I see "You have completed your reply" on the page
	Then I see "<part_no_five>" on the page

	#RESPONSE 6
	#1st residency

#	Given I am on "Public" "test"
	Given I am on "Public" "test"

	And I set the radio button to "I am replying for myself"
	And I press the "Continue" button
	Then I see "Your juror details" on the page

	When I set "9-digit juror number" to "<part_no_six>"
	When I set "Juror last name" to "<last_name>"
	When I set "Juror postcode" to "<postcode>"
	And I press the "Continue" button

	Then I see "Is the name we have for you correct?" on the page
	And I set the radio button to "Yes"
	And I press the "Continue" button

	And I set the radio button to "Yes"
	And I press the "Continue" button

	When I set "Main phone" to "02078211818"
	And I press the "Continue" button

	When I set "Enter your email address" to "<email>"
	When I set "Enter your email address again" to "<email>"
	And I press the "Continue" button

	When I set "Day" to "27"
	And I set "Month" to "04"
	And I set "Year" to "1981"
	And I press the "Continue" button

	Then I see "Confirm you're eligible for jury service" on the page

	And I press the "Continue" button

	Then I see "Since you turned 13, has your main address been in the UK, Channel Islands or Isle of Man for any period of at least 5 years?" on the page
	And I set the radio button to "No"
	And I set "Provide details" to "some reasons"
	And I press the "Continue" button

	Then I see "Have you worked in the criminal justice system in the last 5 years?" on the page
	When I set the radio button to "No"
	And I press the "Continue" button

	And I see "Are you currently on bail for a criminal offence?" on the page
	When I set the radio button to "No"
	And I press the "Continue" button

	Then I see "Have you been found guilty of a criminal offence?" on the page
	When I set the radio button to "No"
	And I press the "Continue" button

	And I see "Are you being detained, looked after or treated under the Mental Health Act?" on the page
	When I set the radio button to "No"
	And I press the "Continue" button

	Then I see "Has it been decided that you 'lack mental capacity'?" on the page
	When I set the radio button to "No"
	And I press the "Continue" button

	#Straight through

	When I set the radio button to "Yes"
	And I press the "Continue" button

	Then I see "Will you need help when you're at the court?" on the page
	Then I see "Do you have a disability or impairment that means you’ll need extra support or facilities in the court building where you are doing your Jury Service?" on the page
	When I set the radio button to "No"
	And I press the "Continue" button

	Then I see "Check your answers now" on the page
	Then I check the "The information I have given is true to the best of my knowledge" checkbox
	When I press the "Submit" button

	Then I see "You have completed your reply" on the page
	Then I see "<part_no_six>" on the page

	#RESPONSE 7
	#1st details change

#	Given I am on "Public" "test"
	Given I am on "Public" "test"

	And I set the radio button to "I am replying for myself"

	And I press the "Continue" button

	And I see "Your juror details" on the page

	When I set "9-digit juror number" to "<part_no_seven>"
	And I set "Juror last name" to "<last_name>"
	And I set "Juror postcode" to "<postcode>"
	And I press the "Continue" button

	And I set the radio button to "No"
	And I press the "Continue" button
	And I set "First name" to "Joe"
	And I set "Last name" to "Blogs"

	And I press the "Continue" button

	And I set the radio button to "No"
	When I press the "Continue" button
	And I set "Address line 1" to "99 The Road"
	And I set "Town or city" to "Town"

	When I press the "Continue" button

	When I set "Main phone" to "02078211818"
	And I press the "Continue" button

	When I set "Enter your email address" to "e@mail.com"
	When I set "Enter your email address again" to "e@mail.com"

	And I press the "Continue" button

	When I set "Day" to "01"
	And I set "Month" to "01"
	And I set "Year" to "1990"
	And I press the "Continue" button

	#Qualify for jury service

	#JDB-4636

	When I press the "Continue" button

	#Residency

	And I set the radio button to "Yes"
	And I press the "Continue" button

	#CJS

	When I set the radio button to "No"
	And I press the "Continue" button

	#Bail

	When I set the radio button to "No"
	And I press the "Continue" button

	#Convictions

	When I set the radio button to "No"
	And I press the "Continue" button

	#Mental Health Sectioned

	And I set the radio button to "No"
	And I press the "Continue" button

	#Mental Health Capacity

	And I set the radio button to "No"
	And I press the "Continue" button

	#I can attend

	And I set the radio button to "Yes, I can start on"
	And  I press the "Continue" button

	#RA no

	When I set the radio button to "No"
	And I press the "Continue" button

	#Check your answers

	Then I see "Check your answers now" on the page
	Then I check the "The information I have given is true to the best of my knowledge" checkbox
	When I press the "Submit" button

	Then I see "You have completed your reply" on the page
	Then I see "<part_no_seven>" on the page

	#RESPONSE 8
	#1st deferral

#	Given I am on "Public" "test"
	Given I am on "Public" "test"

	Then I see "Reply to a jury summons" on the page

	And I set the radio button to "I am replying for myself"
	And I press the "Continue" button
	Then I see "Your juror details" on the page

	When I set "9-digit juror number" to "<part_no_eight>"
	When I set "Juror last name" to "<last_name>"
	When I set "Juror postcode" to "<postcode>"
	And I press the "Continue" button

	Then I see "Is the name we have for you correct?" on the page
	And I set the radio button to "Yes"
	And I press the "Continue" button

	And I set the radio button to "Yes"
	And I press the "Continue" button

	When I set "Main phone" to "02078211818"
	And I press the "Continue" button

	When I set "Enter your email address" to "<email>"
	When I set "Enter your email address again" to "<email>"
	And I press the "Continue" button

	When I set "Day" to "27"
	And I set "Month" to "04"
	And I set "Year" to "1981"
	And I press the "Continue" button

	Then I see "Confirm you're eligible for jury service" on the page

	And I press the "Continue" button

	Then I see "Since you turned 13, has your main address been in the UK, Channel Islands or Isle of Man for any period of at least 5 years?" on the page
	And I set the radio button to "Yes"
	And I press the "Continue" button

	Then I see "Have you worked in the criminal justice system in the last 5 years?" on the page
	When I set the radio button to "No"
	And I press the "Continue" button

	And I see "Are you currently on bail for a criminal offence?" on the page
	When I set the radio button to "No"
	And I press the "Continue" button

	Then I see "Have you been found guilty of a criminal offence?" on the page
	When I set the radio button to "No"
	And I press the "Continue" button

	And I see "Are you being detained, looked after or treated under the Mental Health Act?" on the page
	When I set the radio button to "No"
	And I press the "Continue" button

	Then I see "Has it been decided that you 'lack mental capacity'?" on the page
	When I set the radio button to "No"
	And I press the "Continue" button

	#deferral

	When I set the radio button to "No, I need to change the date"
	And I press the "Continue" button

	When I set text area with "id" of "deferralReason" to "Deferral Reason"
	And I press the "Continue" button

	When I set the "First" single date field to a Monday "6" weeks in the future
	When I set the "Second" single date field to a Monday "7" weeks in the future
	When I set the "Third" single date field to a Monday "8" weeks in the future

	And I press the "Continue" button

	#check dates screen

	And I set the radio button to "Yes"
	And I press the "Continue" button

	Then I see "Will you need help when you're at the court?" on the page
	Then I see "Do you have a disability or impairment that means you’ll need extra support or facilities in the court building where you are doing your Jury Service?" on the page
	When I set the radio button to "Yes"
	Then I check the "Diabetes" checkbox
	And I press the "Continue" button
	Then I see "Check your answers now" on the page

	Then I check the "The information I have given is true to the best of my knowledge" checkbox

	When I press the "Submit" button

	Then I see "You have completed your reply" on the page
	Then I see "<part_no_eight>" on the page

	#RESPONSE 9
	#1st excusal

	Given I am on "Public" "test"

	Then I see "Reply to a jury summons" on the page

	And I set the radio button to "I am replying for myself"
	And I press the "Continue" button
	Then I see "Your juror details" on the page

	#Juror Log In

	When I set "9-digit juror number" to "<part_no_nine>"
	When I set "Juror last name" to "<last_name>"
	When I set "Juror postcode" to "<postcode>"
	And I press the "Continue" button

	#Check Name

	When I set the radio button to "Yes"
	When I press the "Continue" button

	#Check Address

	When I set the radio button to "Yes"
	And I press the "Continue" button

	#Phone Details

	When I set "Main phone" to "0207 821 1818"
	And I press the "Continue" button

	#Email

	When I set "Enter your email address" to "email@outlook.com"
	And I set "Enter your email address again" to "email@outlook.com"
	And I press the "Continue" button

	#DoB

	When I set "Day" to "27"
	And I set "Month" to "04"
	And I set "Year" to "1981"
	And I press the "Continue" button

	When I press the "Continue" button

	#Residency

	When I set the radio button to "Yes"
	And I press the "Continue" button

	#CJS

	When I set the radio button to "No"
	And I press the "Continue" button

	#Bail

	When I set the radio button to "No"
	And I press the "Continue" button

	#Convictions

	When I set the radio button to "No"
	And I press the "Continue" button

	#Mental Health part 1

	When I set the radio button to "No"
	And I press the "Continue" button

	#Mental Health part 2

	When I set the radio button to "No"
	And I press the "Continue" button

	#Confirm Date of Jury

	When I set the radio button to "No, I cannot do jury service and need to be excused"
	And I press the "Continue" button

	#Excusal Reason

	When I set text area with "id" of "excusalReason" to "Excuse me please"
	And I press the "Continue" button

	#RA

	When I set the radio button to "No"
	And I press the "Continue" button

	#Check Your Answers Now

	When I check the "The information" checkbox
	And I press the "Submit" button
	And I see "You have completed your reply" on the page

	#RESPONSE 10
	#3rd Deceased

	Given I am on "Public" "test"

	And I have submitted a third party English deceased response
	|part_no		|pool_number|last_name		|postcode	|email 	|
	|<part_no_ten>	|<pool_no>	|<last_name>	|<postcode>	|<email>|

	#RESPONSE 11
	#auto processed

	Given I am on "Public" "test"

	And I have submitted a first party English straight through response
	|part_no			|pool_number|last_name		|postcode	|email 	|
	|<part_no_eleven>	|<pool_no>	|<last_name>	|<postcode>	|<email>|

	Given I am on "Bureau" "test"

	When I log in as "SYSTEM"
	
	When I click on the "Search" link
	And I set "Juror's pool number" to "<pool_no>"
	And I press the "Search" button
	And I see "<part_no>" on the page
	
	And I click link with ID "selectAllLink"
	And I press the "Send to..." button
	And I set input field with "id" of "sendToOfficer" to "ARAMIS1"
	And I press the "Send" button
	And I press the "Send" button
	Then I see "Your work" on the page
	
	Then I click on the "Search" link
	
	And I set "Juror's pool number" to "<pool_no_two>"
	And I press the "Search" button
	
	And I see "<part_no_seven>" on the page
	And I click link with ID "selectAllLink"
	And I press the "Send to..." button
	And I set input field with "id" of "sendToOfficer" to "ARAMIS1"
	And I press the "Send" button
	And I press the "Send" button
	Then I see "Your work" on the page
	
	Then I click on the "Search" link
	
	And I set "Juror's pool number" to "<pool_no_three>"
	And I press the "Search" button
	
	And I see "<part_no_nine>" on the page
	And I click link with ID "selectAllLink"
	And I press the "Send to..." button
	And I set input field with "id" of "sendToOfficer" to "ARAMIS1"
	And I press the "Send" button
	And I press the "Send" button
	Then I see "Your work" on the page
	
	Then I click on the "Sign out" link
	
	Given I am on "Bureau" "test"
	
	And I log in as "ARAMIS1"

	Then I see "<part_no>" has reply type indicator "INELIGIBLE"
	Then I see "<part_no_two>" has reply type indicator "INELIGIBLE"
	Then I see "<part_no_three>" has reply type indicator "INELIGIBLE"
	Then I see "<part_no_four>" has reply type indicator "INELIGIBLE"
	Then I see "<part_no_five>" has reply type indicator "INELIGIBLE"
	Then I see "<part_no_six>" has reply type indicator "INELIGIBLE"
	Then I see "<part_no_seven>" has reply type indicator "NEEDS REVIEW"
	Then I see "<part_no_eight>" has reply type indicator "DEFERRAL"
	Then I see "<part_no_nine>" has reply type indicator "EXCUSAL"
	
	When I click on "<part_no>" in the same row as "<part_no>"
	And I see "INELIGIBLE" on the page
	
	Then I press the "Process reply" button
	Then I click on the "Responded" link
	And I check the "Mark juror as 'responded'" checkbox
	And I press the "Confirm" button
	Then I see "COMPLETED" on the page
	
	And I click on the "Your work" link
	
	Then I see "<part_no_two>" on the page
	When I click on "<part_no_two>" in the same row as "<part_no_two>"
	And I see "INELIGIBLE" on the page
	
	Then I press the "Process reply" button
	Then I click on the "Responded" link
	And I check the "Mark juror as 'responded'" checkbox
	And I press the "Confirm" button
	Then I see "COMPLETED" on the page
	
	And I click on the "Your work" link
	
	Then I see "<part_no_three>" on the page
	When I click on "<part_no_three>" in the same row as "<part_no_three>"
	And I see "INELIGIBLE" on the page
	
	Then I press the "Process reply" button
	Then I click on the "Responded" link
	And I check the "Mark juror as 'responded'" checkbox
	And I press the "Confirm" button
	Then I see "COMPLETED" on the page
	
	And I click on the "Your work" link
	
	Then I see "<part_no_four>" on the page
	When I click on "<part_no_four>" in the same row as "<part_no_four>"
	And I see "INELIGIBLE" on the page
	
	Then I press the "Process reply" button
	Then I click on the "Responded" link
	And I check the "Mark juror as 'responded'" checkbox
	And I press the "Confirm" button
	Then I see "COMPLETED" on the page
	
	And I click on the "Your work" link
	
	Then I see "<part_no_five>" on the page
	When I click on "<part_no_five>" in the same row as "<part_no_five>"
	And I see "INELIGIBLE" on the page
	
	Then I press the "Process reply" button
	Then I click on the "Responded" link
	And I check the "Mark juror as 'responded'" checkbox
	And I press the "Confirm" button
	Then I see "COMPLETED" on the page
	
	And I click on the "Your work" link
	
	Then I see "<part_no_six>" on the page
	When I click on "<part_no_six>" in the same row as "<part_no_six>"
	And I see "INELIGIBLE" on the page
	
	Then I press the "Process reply" button
	Then I click on the "Responded" link
	And I check the "Mark juror as 'responded'" checkbox
	And I press the "Confirm" button
	Then I see "COMPLETED" on the page
	
	And I click on the "Your work" link
	
	Then I see "<part_no_seven>" on the page
	When I click on "<part_no_seven>" in the same row as "<part_no_seven>"
	And I see "NEEDS REVIEW" on the page
	
	Then I press the "Process reply" button
	Then I click on the "Responded" link
	And I check the "Mark juror as 'responded'" checkbox
	And I press the "Confirm" button
	Then I see "COMPLETED" on the page
	
	And I click on the "Your work" link
	
	Then I see "<part_no_eight>" on the page
	When I click on "<part_no_eight>" in the same row as "<part_no_eight>"
	And I see "DEFERRAL" on the page
	
	Then I press the "Process reply" button
	Then I click on the "Responded" link
	And I check the "Mark juror as 'responded'" checkbox
	And I press the "Confirm" button
	Then I see "COMPLETED" on the page
	
	And I click on the "Your work" link
	
	Then I see "<part_no_nine>" on the page
	When I click on "<part_no_nine>" in the same row as "<part_no_nine>"
	And I see "EXCUSAL" on the page
	
	Then I press the "Process reply" button
	Then I click on the "Responded" link
	And I check the "Mark juror as 'responded'" checkbox
	And I press the "Confirm" button
	Then I see "COMPLETED" on the page
	
	And I click on the "Your work" link
	
	And I click on the "Search" link
	And I set "Juror number" to "<part_no_ten>"
	And I press the "Search" button
	
	When I click on "<part_no_ten>" in the same row as "<part_no_ten>"
	And I see "DECEASED" on the page
	
#	And I click on the "Back" link
	
	And I click on the "Search" link
	And I set "Juror number" to "<part_no_eleven>"
	And I press the "Search" button
	And I see "<part_no_eleven>" on the page
	
	When I click on "<part_no_eleven>" in the same row as "<part_no_eleven>"
	And I see "AUTO PROCESSED" on the page
	
	Then I click on the "Your work" link
	Then I click on the "Completed" link
	
	When I click on "<part_no>" in the same row as "<part_no>"
	And I see "INELIGIBLE" on the page

	And I click on the "Back" link
	
	When I click on "<part_no_two>" in the same row as "<part_no_two>"
	And I see "INELIGIBLE" on the page
	
	And I click on the "Back" link
	
	When I click on "<part_no_three>" in the same row as "<part_no_three>"
	And I see "INELIGIBLE" on the page
	
	And I click on the "Back" link
	
	When I click on "<part_no_four>" in the same row as "<part_no_four>"
	And I see "INELIGIBLE" on the page
	
	And I click on the "Back" link
	
	When I click on "<part_no_five>" in the same row as "<part_no_five>"
	And I see "INELIGIBLE" on the page
	
	And I click on the "Back" link
	
	When I click on "<part_no_six>" in the same row as "<part_no_six>"
	And I see "INELIGIBLE" on the page
	
	And I click on the "Back" link
	
	When I click on "<part_no_seven>" in the same row as "<part_no_seven>"
	And I see "NEEDS REVIEW" on the page
	
	And I click on the "Back" link
	
	When I click on "<part_no_eight>" in the same row as "<part_no_eight>"
	And I see "DEFERRAL" on the page
	
	And I click on the "Back" link
	
	When I click on "<part_no_nine>" in the same row as "<part_no_nine>"
	And I see "EXCUSAL" on the page
	
Examples:
	|part_no	|part_no_two	|part_no_three	|part_no_four	|part_no_five	|part_no_six	|part_no_seven	|part_no_eight	|part_no_nine	|part_no_ten|part_no_eleven	|last_name	|postcode	|email       	    |pool_no	|pool_no_two|pool_no_three	|
	|645200748	|645200743		|645200720		|645200694		|645200637		|645200884		|645100925		|645200610		|641500226		|645200130	|645200784		|LNAME  	|SY2 6LU	|email@outlook.com	|452170401	|451170401	|415170401		|
	

@Features
Scenario Outline: Multiple reply types in Awaiting Information

	#moved into Features 02-01-24 return to RegressionSingle

	Given I am on "Public" "test"
	Given auto straight through processing has been enabled
	Given the juror numbers have not been processed
		|part_no 			|pool_no 		|owner 	|
		|<part_no> 			|<pool_no>		|400 	|
		|<part_no_two> 		|<pool_no>		|400 	|
		|<part_no_three>	|<pool_no>		|400 	|
		|<part_no_four>		|<pool_no>		|400 	|
		|<part_no_five> 	|<pool_no>		|400 	|
		|<part_no_six> 		|<pool_no>		|400 	|
		|<part_no_seven>	|<pool_no_two>	|400 	|
		|<part_no_eight>	|<pool_no>		|400 	|
		|<part_no_nine>		|<pool_no_three>|400 	|

	And "<part_no>" has "LNAME" as "<last_name>"
	And "<part_no>" has "RET_DATE" as "5 mondays time"
	And "<part_no>" has "NEXT_DATE" as "5 mondays time"
	And "<part_no>" has "ZIP" as "<postcode>"

	And "<part_no_two>" has "LNAME" as "<last_name>"
	And "<part_no_two>" has "RET_DATE" as "5 mondays time"
	And "<part_no_two>" has "NEXT_DATE" as "5 mondays time"
	And "<part_no_two>" has "ZIP" as "<postcode>"

	And "<part_no_three>" has "LNAME" as "<last_name>"
	And "<part_no_three>" has "RET_DATE" as "5 mondays time"
	And "<part_no_three>" has "NEXT_DATE" as "5 mondays time"
	And "<part_no_three>" has "ZIP" as "<postcode>"

	And "<part_no_four>" has "LNAME" as "<last_name>"
	And "<part_no_four>" has "RET_DATE" as "5 mondays time"
	And "<part_no_four>" has "NEXT_DATE" as "5 mondays time"
	And "<part_no_four>" has "ZIP" as "<postcode>"

	And "<part_no_five>" has "LNAME" as "<last_name>"
	And "<part_no_five>" has "RET_DATE" as "5 mondays time"
	And "<part_no_five>" has "NEXT_DATE" as "5 mondays time"
	And "<part_no_five>" has "ZIP" as "<postcode>"

	And "<part_no_six>" has "LNAME" as "<last_name>"
	And "<part_no_six>" has "RET_DATE" as "5 mondays time"
	And "<part_no_six>" has "NEXT_DATE" as "5 mondays time"
	And "<part_no_six>" has "ZIP" as "<postcode>"

	And "<part_no_seven>" has "LNAME" as "<last_name>"
	And "<part_no_seven>" has "RET_DATE" as "5 mondays time"
	And "<part_no_seven>" has "NEXT_DATE" as "5 mondays time"
	And "<part_no_seven>" has "ZIP" as "<postcode>"

	And "<part_no_eight>" has "LNAME" as "<last_name>"
	And "<part_no_eight>" has "RET_DATE" as "5 mondays time"
	And "<part_no_eight>" has "NEXT_DATE" as "5 mondays time"
	And "<part_no_eight>" has "ZIP" as "<postcode>"

	And "<part_no_nine>" has "LNAME" as "<last_name>"
	And "<part_no_nine>" has "RET_DATE" as "5 mondays time"
	And "<part_no_nine>" has "NEXT_DATE" as "5 mondays time"
	And "<part_no_nine>" has "ZIP" as "<postcode>"

	#RESPONSE 1
	#3rd party MH

	Given I am on "Public" "test"

	And I set the radio button to "I am replying for someone else"
	And I press the "Continue" button

	#Juror Log In

	When I set "9-digit juror number" to "<part_no>"
	When I set "Juror last name" to "<last_name>"
	When I set "Juror postcode" to "<postcode>"
	And I press the "Continue" button

	#3rd Party Name

	When I set "First name" to "FirstNameA"
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

	#Why are you replying for the person?

	When I set the radio button to "The person is not here"
	And I press the "Continue" button

	#Check juror name

	And I set the radio button to "Yes"
	And I press the "Continue" button

	#Check juror address

	And I set the radio button to "Yes"
	And I press the "Continue" button

	#DoB

	And I set "Day" to "01"
	And I set "Month" to "01"
	And I set "Year" to "1980"
	And I press the "Continue" button

	#Contacting the juror

	And I set the radio button to "Use the phone number that you have already given to contact you"
	And I set the radio button to "Use the email address that you have already given to contact you"
	And I press the "Continue" button

	#Qualify for jury service

	And I press the "Continue" button

	#Residency

	And I set the radio button to "Yes"
	And I press the "Continue" button

	#CJS
	When I set the radio button to "No"
	And I press the "Continue" button

	#Bail

	And I set the radio button to "No"
	And I press the "Continue" button

	#Convictions

	When I set the radio button to "No"
	And I press the "Continue" button

	#Mental Health Sectioned

	And I set the radio button to "Yes"
	And I set "Provide details about how they're being detained, looked after or treated under the Mental Health Act" to "some details"
	And I press the "Continue" button

	#Mental Health Capacity

	And I set the radio button to "Yes"
	And I set "Provide brief details about why it was decided they lack mental capacity" to "some details"
	And I press the "Continue" button

	#Confirm Date of Jury

	When I set the radio button to "Yes"
	And I press the "Continue" button

	#RA

	When I set the radio button to "No"
	And I press the "Continue" button

	#Check Your Answers

	When I check the "The answers I have given for the person I'm replying for are true as far as I know" checkbox
	And I press the "Submit" button
	And I see "You have completed your reply" on the page

	#RESPONSE 2
	#3rd party bail

	Given I am on "Public" "test"

	And I set the radio button to "I am replying for someone else"
	And I press the "Continue" button

	#Juror Log In

	When I set "9-digit juror number" to "<part_no_two>"
	When I set "Juror last name" to "<last_name>"
	When I set "Juror postcode" to "<postcode>"
	And I press the "Continue" button

	#3rd Party Name

	When I set "First name" to "FirstNameA"
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

	#Why are you replying for the person?

	When I set the radio button to "The person is not here"
	And I press the "Continue" button

	#Check juror name

	And I set the radio button to "Yes"
	And I press the "Continue" button

	#Check juror address

	And I set the radio button to "Yes"
	And I press the "Continue" button

	#DoB

	And I set "Day" to "01"
	And I set "Month" to "01"
	And I set "Year" to "1980"
	And I press the "Continue" button

	#Contacting the juror

	And I set the radio button to "Use the phone number that you have already given to contact you"
	And I set the radio button to "Use the email address that you have already given to contact you"
	And I press the "Continue" button

	#Qualify for jury service

	And I press the "Continue" button

	#Residency

	And I set the radio button to "Yes"
	And I press the "Continue" button

	#CJS
	When I set the radio button to "No"
	And I press the "Continue" button

	#Bail

	And I set the radio button to "Yes"
	And I set "Provide details about the person's bail and criminal offence" to "some details"
	And I press the "Continue" button

	#Convictions

	When I set the radio button to "No"
	And I press the "Continue" button

	#Mental Health Sectioned

	And I set the radio button to "No"
	And I press the "Continue" button

	#Mental Health Capacity

	And I set the radio button to "No"
	And I press the "Continue" button

	#Confirm Date of Jury

	When I set the radio button to "Yes"
	And I press the "Continue" button

	#RA

	When I set the radio button to "No"
	And I press the "Continue" button

	#Check Your Answers

	When I check the "The answers I have given for the person I'm replying for are true as far as I know" checkbox
	And I press the "Submit" button
	And I see "You have completed your reply" on the page

	#RESPONSE 3
	#3rd party residency

	Given I am on "Public" "test"
	And I set the radio button to "I am replying for someone else"
	And I press the "Continue" button

	#Juror Log In

	When I set "9-digit juror number" to "<part_no_three>"
	When I set "Juror last name" to "<last_name>"
	When I set "Juror postcode" to "<postcode>"
	And I press the "Continue" button

	#3rd Party Name

	When I set "First name" to "FirstNameA"
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

	#Why are you replying for the person?

	When I set the radio button to "The person is not here"
	And I press the "Continue" button

	#Check juror name

	And I set the radio button to "Yes"
	And I press the "Continue" button

	#Check juror address

	And I set the radio button to "Yes"
	And I press the "Continue" button

	#DoB

	And I set "Day" to "01"
	And I set "Month" to "01"
	And I set "Year" to "1980"
	And I press the "Continue" button

	#Contacting the juror

	And I set the radio button to "Use the phone number that you have already given to contact you"
	And I set the radio button to "Use the email address that you have already given to contact you"
	And I press the "Continue" button

	#Qualify for jury service

	And I press the "Continue" button

	#Residency

	And I set the radio button to "No"
	And I set "Provide details about where the person you are answering for has lived since their 13th birthday" to "some details"
	And I press the "Continue" button

	#CJS
	When I set the radio button to "No"
	And I press the "Continue" button

	#Bail

	And I set the radio button to "No"
	And I press the "Continue" button

	#Convictions

	When I set the radio button to "No"
	And I press the "Continue" button

	#Mental Health Sectioned

	And I set the radio button to "No"
	And I press the "Continue" button

	#Mental Health Capacity

	And I set the radio button to "No"
	And I press the "Continue" button

	#Confirm Date of Jury

	When I set the radio button to "Yes"
	And I press the "Continue" button

	#RA

	When I set the radio button to "No"
	And I press the "Continue" button

	#Check Your Answers

	When I check the "The answers I have given for the person I'm replying for are true as far as I know" checkbox
	And I press the "Submit" button
	And I see "You have completed your reply" on the page

	#RESPONSE 4
	#3rd party convictions

	Given I am on "Public" "test"
	And I set the radio button to "I am replying for someone else"
	And I press the "Continue" button

	#Juror Log In

	When I set "9-digit juror number" to "<part_no_four>"
	When I set "Juror last name" to "<last_name>"
	When I set "Juror postcode" to "<postcode>"
	And I press the "Continue" button

	#3rd Party Name

	When I set "First name" to "FirstNameA"
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

	#Why are you replying for the person?

	When I set the radio button to "The person is not here"
	And I press the "Continue" button

	#Check juror name

	And I set the radio button to "Yes"
	And I press the "Continue" button

	#Check juror address

	And I set the radio button to "Yes"
	And I press the "Continue" button

	#DoB

	When I set the date of birth to a Monday "-2950" weeks in the future
	And I press the "Continue" button

	#Contacting the juror

	And I set the radio button to "Use the phone number that you have already given to contact you"
	And I set the radio button to "Use the email address that you have already given to contact you"
	And I press the "Continue" button

	#Qualify for jury service

	And I press the "Continue" button

	#Residency

	And I set the radio button to "Yes"
	And I press the "Continue" button

	#CJS
	When I set the radio button to "No"
	And I press the "Continue" button

	#Bail

	And I set the radio button to "No"
	And I press the "Continue" button

	#Convictions

	When I set the radio button to "Yes"
	And I set text area with "id" of "convictedDetails" to "I am a convicted criminal"
	And I press the "Continue" button

	#Mental Health Sectioned

	And I set the radio button to "No"
	And I press the "Continue" button

	#Mental Health Capacity

	And I set the radio button to "No"
	And I press the "Continue" button

	#Confirm Date of Jury

	When I set the radio button to "Yes"
	And I press the "Continue" button

	#RA

	When I set the radio button to "No"
	And I press the "Continue" button

	#Check Your Answers

	When I check the "The answers I have given for the person I'm replying for are true as far as I know" checkbox
	And I press the "Submit" button
	And I see "You have completed your reply" on the page

	#RESPONSE 5
	#1st bail

	Given I am on "Public" "test"

	And I set the radio button to "I am replying for myself"
	And I press the "Continue" button
	Then I see "Your juror details" on the page

	When I set "9-digit juror number" to "<part_no_five>"
	When I set "Juror last name" to "<last_name>"
	When I set "Juror postcode" to "<postcode>"
	And I press the "Continue" button

	Then I see "Is the name we have for you correct?" on the page
	And I set the radio button to "Yes"
	And I press the "Continue" button

	And I set the radio button to "Yes"
	And I press the "Continue" button

	When I set "Main phone" to "02078211818"
	And I press the "Continue" button

	When I set "Enter your email address" to "<email>"
	When I set "Enter your email address again" to "<email>"
	And I press the "Continue" button

	When I set "Day" to "27"
	And I set "Month" to "04"
	And I set "Year" to "1981"
	And I press the "Continue" button

	Then I see "Confirm you're eligible for jury service" on the page

	And I press the "Continue" button

	Then I see "Since you turned 13, has your main address been in the UK, Channel Islands or Isle of Man for any period of at least 5 years?" on the page
	And I set the radio button to "Yes"
	And I press the "Continue" button

	Then I see "Have you worked in the criminal justice system in the last 5 years?" on the page
	When I set the radio button to "No"
	And I press the "Continue" button

	And I see "Are you currently on bail for a criminal offence?" on the page
	When I set the radio button to "Yes"
	Then I set "Provide details about your bail and criminal offence" to "some details"
	And I press the "Continue" button

	Then I see "Have you been found guilty of a criminal offence?" on the page
	When I set the radio button to "No"
	And I press the "Continue" button

	And I see "Are you being detained, looked after or treated under the Mental Health Act?" on the page
	When I set the radio button to "No"
	And I press the "Continue" button

	Then I see "Has it been decided that you 'lack mental capacity'?" on the page
	When I set the radio button to "No"
	And I press the "Continue" button

	#Straight through

	When I set the radio button to "Yes"
	And I press the "Continue" button

	Then I see "Will you need help when you're at the court?" on the page
	Then I see "Do you have a disability or impairment that means you’ll need extra support or facilities in the court building where you are doing your Jury Service?" on the page
	When I set the radio button to "No"
	And I press the "Continue" button

	Then I see "Check your answers now" on the page
	Then I check the "The information I have given is true to the best of my knowledge" checkbox
	When I press the "Submit" button

	Then I see "You have completed your reply" on the page
	Then I see "<part_no_five>" on the page

	#RESPONSE 6
	#1st residency

	Given I am on "Public" "test"

	And I set the radio button to "I am replying for myself"
	And I press the "Continue" button
	Then I see "Your juror details" on the page

	When I set "9-digit juror number" to "<part_no_six>"
	When I set "Juror last name" to "<last_name>"
	When I set "Juror postcode" to "<postcode>"
	And I press the "Continue" button

	Then I see "Is the name we have for you correct?" on the page
	And I set the radio button to "Yes"
	And I press the "Continue" button

	And I set the radio button to "Yes"
	And I press the "Continue" button

	When I set "Main phone" to "02078211818"
	And I press the "Continue" button

	When I set "Enter your email address" to "<email>"
	When I set "Enter your email address again" to "<email>"
	And I press the "Continue" button

	When I set "Day" to "27"
	And I set "Month" to "04"
	And I set "Year" to "1981"
	And I press the "Continue" button

	Then I see "Confirm you're eligible for jury service" on the page

	And I press the "Continue" button

	Then I see "Since you turned 13, has your main address been in the UK, Channel Islands or Isle of Man for any period of at least 5 years?" on the page
	And I set the radio button to "No"
	And I set "Provide details" to "some reasons"
	And I press the "Continue" button

	Then I see "Have you worked in the criminal justice system in the last 5 years?" on the page
	When I set the radio button to "No"
	And I press the "Continue" button

	And I see "Are you currently on bail for a criminal offence?" on the page
	When I set the radio button to "No"
	And I press the "Continue" button

	Then I see "Have you been found guilty of a criminal offence?" on the page
	When I set the radio button to "No"
	And I press the "Continue" button

	And I see "Are you being detained, looked after or treated under the Mental Health Act?" on the page
	When I set the radio button to "No"
	And I press the "Continue" button

	Then I see "Has it been decided that you 'lack mental capacity'?" on the page
	When I set the radio button to "No"
	And I press the "Continue" button

	#Straight through

	When I set the radio button to "Yes"
	And I press the "Continue" button

	Then I see "Will you need help when you're at the court?" on the page
	Then I see "Do you have a disability or impairment that means you’ll need extra support or facilities in the court building where you are doing your Jury Service?" on the page
	When I set the radio button to "No"
	And I press the "Continue" button

	Then I see "Check your answers now" on the page
	Then I check the "The information I have given is true to the best of my knowledge" checkbox
	When I press the "Submit" button

	Then I see "You have completed your reply" on the page
	Then I see "<part_no_six>" on the page

	#RESPONSE 7
	#1st details change

	Given I am on "Public" "test"

	And I set the radio button to "I am replying for myself"

	And I press the "Continue" button

	And I see "Your juror details" on the page

	When I set "9-digit juror number" to "<part_no_seven>"
	And I set "Juror last name" to "<last_name>"
	And I set "Juror postcode" to "<postcode>"
	And I press the "Continue" button

	And I set the radio button to "No"
	And I press the "Continue" button
	And I set "First name" to "Joe"
	And I set "Last name" to "Blogs"

	And I press the "Continue" button

	And I set the radio button to "No"
	When I press the "Continue" button
	And I set "Address line 1" to "99 The Road"
	And I set "Town or city" to "Town"

	When I press the "Continue" button

	When I set "Main phone" to "02078211818"
	And I press the "Continue" button

	When I set "Enter your email address" to "e@mail.com"
	When I set "Enter your email address again" to "e@mail.com"

	And I press the "Continue" button

	When I set "Day" to "01"
	And I set "Month" to "01"
	And I set "Year" to "1990"
	And I press the "Continue" button

	#Qualify for jury service

	#JDB-4636

	When I press the "Continue" button

	#Residency

	And I set the radio button to "Yes"
	And I press the "Continue" button

	#CJS

	When I set the radio button to "No"
	And I press the "Continue" button

	#Bail

	When I set the radio button to "No"
	And I press the "Continue" button

	#Convictions

	When I set the radio button to "No"
	And I press the "Continue" button

	#Mental Health Sectioned

	And I set the radio button to "No"
	And I press the "Continue" button

	#Mental Health Capacity

	And I set the radio button to "No"
	And I press the "Continue" button

	#I can attend

	And I set the radio button to "Yes, I can start on"
	And  I press the "Continue" button

	#RA no

	When I set the radio button to "No"
	And I press the "Continue" button

	#Check your answers

	Then I see "Check your answers now" on the page
	Then I check the "The information I have given is true to the best of my knowledge" checkbox
	When I press the "Submit" button

	Then I see "You have completed your reply" on the page
	Then I see "<part_no_seven>" on the page

	#RESPONSE 8
	#1st deferral

	Given I am on "Public" "test"

	Then I see "Reply to a jury summons" on the page

	And I set the radio button to "I am replying for myself"
	And I press the "Continue" button
	Then I see "Your juror details" on the page

	When I set "9-digit juror number" to "<part_no_eight>"
	When I set "Juror last name" to "<last_name>"
	When I set "Juror postcode" to "<postcode>"
	And I press the "Continue" button

	Then I see "Is the name we have for you correct?" on the page
	And I set the radio button to "Yes"
	And I press the "Continue" button

	And I set the radio button to "Yes"
	And I press the "Continue" button

	When I set "Main phone" to "02078211818"
	And I press the "Continue" button

	When I set "Enter your email address" to "<email>"
	When I set "Enter your email address again" to "<email>"
	And I press the "Continue" button

	When I set "Day" to "27"
	And I set "Month" to "04"
	And I set "Year" to "1981"
	And I press the "Continue" button

	Then I see "Confirm you're eligible for jury service" on the page

	And I press the "Continue" button

	Then I see "Since you turned 13, has your main address been in the UK, Channel Islands or Isle of Man for any period of at least 5 years?" on the page
	And I set the radio button to "Yes"
	And I press the "Continue" button

	Then I see "Have you worked in the criminal justice system in the last 5 years?" on the page
	When I set the radio button to "No"
	And I press the "Continue" button

	And I see "Are you currently on bail for a criminal offence?" on the page
	When I set the radio button to "No"
	And I press the "Continue" button

	Then I see "Have you been found guilty of a criminal offence?" on the page
	When I set the radio button to "No"
	And I press the "Continue" button

	And I see "Are you being detained, looked after or treated under the Mental Health Act?" on the page
	When I set the radio button to "No"
	And I press the "Continue" button

	Then I see "Has it been decided that you 'lack mental capacity'?" on the page
	When I set the radio button to "No"
	And I press the "Continue" button

	#deferral

	When I set the radio button to "No, I need to change the date"
	And I press the "Continue" button

	When I set text area with "id" of "deferralReason" to "Deferral Reason"
	And I press the "Continue" button

	When I set the "First" single date field to a Monday "14" weeks in the future
	When I set the "Second" single date field to a Monday "13" weeks in the future
	When I set the "Third" single date field to a Monday "12" weeks in the future

	And I press the "Continue" button

	#check dates screen

	And I set the radio button to "Yes"
	And I press the "Continue" button

	Then I see "Will you need help when you're at the court?" on the page
	Then I see "Do you have a disability or impairment that means you’ll need extra support or facilities in the court building where you are doing your Jury Service?" on the page
	When I set the radio button to "Yes"
	Then I check the "Diabetes" checkbox
	And I press the "Continue" button
	Then I see "Check your answers now" on the page

	Then I check the "The information I have given is true to the best of my knowledge" checkbox

	When I press the "Submit" button

	Then I see "You have completed your reply" on the page
	Then I see "<part_no_eight>" on the page

	#RESPONSE 9
	#1st excusal

	Given I am on "Public" "test"

	Then I see "Reply to a jury summons" on the page

	And I set the radio button to "I am replying for myself"
	And I press the "Continue" button
	Then I see "Your juror details" on the page

	#Juror Log In

	When I set "9-digit juror number" to "<part_no_nine>"
	When I set "Juror last name" to "<last_name>"
	When I set "Juror postcode" to "<postcode>"
	And I press the "Continue" button

	#Check Name

	When I set the radio button to "Yes"
	When I press the "Continue" button

	#Check Address

	When I set the radio button to "Yes"
	And I press the "Continue" button

	#Phone Details

	When I set "Main phone" to "0207 821 1818"
	And I press the "Continue" button

	#Email

	When I set "Enter your email address" to "email@outlook.com"
	And I set "Enter your email address again" to "email@outlook.com"
	And I press the "Continue" button

	#DoB

	When I set "Day" to "27"
	And I set "Month" to "04"
	And I set "Year" to "1981"
	And I press the "Continue" button

	When I press the "Continue" button

	#Residency

	When I set the radio button to "Yes"
	And I press the "Continue" button

	#CJS

	When I set the radio button to "No"
	And I press the "Continue" button

	#Bail

	When I set the radio button to "No"
	And I press the "Continue" button

	#Convictions

	When I set the radio button to "No"
	And I press the "Continue" button

	#Mental Health part 1

	When I set the radio button to "No"
	And I press the "Continue" button

	#Mental Health part 2

	When I set the radio button to "No"
	And I press the "Continue" button

	#Confirm Date of Jury

	When I set the radio button to "No, I cannot do jury service and need to be excused"
	And I press the "Continue" button

	#Excusal Reason

	When I set text area with "id" of "excusalReason" to "Excuse me please"
	And I press the "Continue" button

	#RA

	When I set the radio button to "No"
	And I press the "Continue" button

	#Check Your Answers Now

	When I check the "The information" checkbox
	And I press the "Submit" button
	And I see "You have completed your reply" on the page

	#BUREAU
	
	Given I am on "Bureau" "test"
	And I log in
	
	When I click on the "Search" link
	And I set "Juror's pool number" to "<pool_no>"
	And I press the "Search" button
	And I see "<part_no>" on the page
	
	And I click link with ID "selectAllLink"
	And I press the "Send to..." button
	And I set input field with "id" of "sendToOfficer" to "CPASS"
	And I press the "Send" button
	And I press the "Send" button
	Then I see "Your work" on the page
	
	Then I click on the "Search" link
	
	And I set "Juror's pool number" to "<pool_no_two>"
	And I press the "Search" button
	
	And I see "<part_no_seven>" on the page
	And I click link with ID "selectAllLink"
	And I press the "Send to..." button
	And I set input field with "id" of "sendToOfficer" to "CPASS"
	And I press the "Send" button
	And I press the "Send" button
	Then I see "Your work" on the page
	
	Then I click on the "Search" link
	
	And I set "Juror's pool number" to "<pool_no_three>"
	And I press the "Search" button
	
	And I see "<part_no_nine>" on the page
	And I click link with ID "selectAllLink"
	And I press the "Send to..." button
	And I set input field with "id" of "sendToOfficer" to "CPASS"
	And I press the "Send" button
	And I press the "Send" button
	Then I see "Your work" on the page
	
	Then I click on the "Sign out" link
	
	Given I am on "Bureau" "test"
	When I log in as "CPASS"

	#Then I take a screenshot
	
	Then I see "<part_no>" has reply type indicator "INELIGIBLE"
	Then I see "<part_no_two>" has reply type indicator "INELIGIBLE"
	Then I see "<part_no_three>" has reply type indicator "INELIGIBLE"
	Then I see "<part_no_four>" has reply type indicator "INELIGIBLE"
	Then I see "<part_no_five>" has reply type indicator "INELIGIBLE"
	Then I see "<part_no_six>" has reply type indicator "INELIGIBLE"
	Then I see "<part_no_seven>" has reply type indicator "NEEDS REVIEW"
	Then I see "<part_no_eight>" has reply type indicator "DEFERRAL"
	Then I see "<part_no_nine>" has reply type indicator "EXCUSAL"
	
	When I click on "<part_no>" in the same row as "<part_no>"
	
	#Then I take a screenshot
	
	And I see "INELIGIBLE" on the page
	
	Then I press the "More actions" button
	Then I click on the "Mark as 'Awaiting information'" link
	And I set the radio button to "Awaiting juror"
	And I press the "Confirm" button
	Then I see "AWAITING JUROR REPLY" on the page
	
	And I click on the "Your work" link
	
	Then I see "<part_no_two>" on the page
	When I click on "<part_no_two>" in the same row as "<part_no_two>"
	
	#Then I take a screenshot
	
	And I see "INELIGIBLE" on the page
	
	Then I press the "More actions" button
	Then I click on the "Mark as 'Awaiting information'" link
	And I set the radio button to "Awaiting juror"
	And I press the "Confirm" button
	Then I see "AWAITING JUROR REPLY" on the page
	
	And I click on the "Your work" link
	
	Then I see "<part_no_three>" on the page
	When I click on "<part_no_three>" in the same row as "<part_no_three>"
	
	#Then I take a screenshot
	
	And I see "INELIGIBLE" on the page
	
	Then I press the "More actions" button
	Then I click on the "Mark as 'Awaiting information'" link
	And I set the radio button to "Awaiting juror"
	And I press the "Confirm" button
	Then I see "AWAITING JUROR REPLY" on the page
	
	And I click on the "Your work" link
	
	Then I see "<part_no_four>" on the page
	When I click on "<part_no_four>" in the same row as "<part_no_four>"
	
	#Then I take a screenshot
	
	And I see "INELIGIBLE" on the page
	
	Then I press the "More actions" button
	Then I click on the "Mark as 'Awaiting information'" link
	And I set the radio button to "Awaiting juror"
	And I press the "Confirm" button
	Then I see "AWAITING JUROR REPLY" on the page
	
	And I click on the "Your work" link
	
	Then I see "<part_no_five>" on the page
	When I click on "<part_no_five>" in the same row as "<part_no_five>"
	
	#Then I take a screenshot
	
	And I see "INELIGIBLE" on the page
	
	Then I press the "More actions" button
	Then I click on the "Mark as 'Awaiting information'" link
	And I set the radio button to "Awaiting juror"
	And I press the "Confirm" button
	Then I see "AWAITING JUROR REPLY" on the page
	
	And I click on the "Your work" link
	
	Then I see "<part_no_six>" on the page
	When I click on "<part_no_six>" in the same row as "<part_no_six>"
	
	#Then I take a screenshot
	
	And I see "INELIGIBLE" on the page
	
	Then I press the "More actions" button
	Then I click on the "Mark as 'Awaiting information'" link
	And I set the radio button to "Awaiting juror"
	And I press the "Confirm" button
	Then I see "AWAITING JUROR REPLY" on the page
	
	And I click on the "Your work" link
	
	Then I see "<part_no_seven>" on the page
	When I click on "<part_no_seven>" in the same row as "<part_no_seven>"
	
	#Then I take a screenshot
	
	And I see "NEEDS REVIEW" on the page
	
	Then I press the "More actions" button
	Then I click on the "Mark as 'Awaiting information'" link
	And I set the radio button to "Awaiting juror"
	And I press the "Confirm" button
	Then I see "AWAITING JUROR REPLY" on the page
	
	And I click on the "Your work" link
	
	Then I see "<part_no_eight>" on the page
	When I click on "<part_no_eight>" in the same row as "<part_no_eight>"
	
	#Then I take a screenshot
	
	And I see "DEFERRAL" on the page
	
	Then I press the "More actions" button
	Then I click on the "Mark as 'Awaiting information'" link
	And I set the radio button to "Awaiting juror"
	And I press the "Confirm" button
	Then I see "AWAITING JUROR REPLY" on the page
	
	And I click on the "Your work" link
	
	Then I see "<part_no_nine>" on the page
	When I click on "<part_no_nine>" in the same row as "<part_no_nine>"
	
	#Then I take a screenshot
	
	And I see "EXCUSAL" on the page
	
	Then I press the "More actions" button
	Then I click on the "Mark as 'Awaiting information'" link
	And I set the radio button to "Awaiting juror"
	And I press the "Confirm" button
	Then I see "AWAITING JUROR REPLY" on the page
	
	Then I click on the "Your work" link
	Then I click on the "Awaiting information" link
	
	When I click on "<part_no>" in the same row as "<part_no>"
	
	#Then I take a screenshot
	
	And I see "NEEDS REVIEW" on the page
	
	And I click on the "Back" link
	
	When I click on "<part_no_two>" in the same row as "<part_no_two>"
	
	#Then I take a screenshot
	
	And I see "NEEDS REVIEW" on the page
	
	And I click on the "Back" link
	
	When I click on "<part_no_three>" in the same row as "<part_no_three>"
	
	#Then I take a screenshot
	
	And I see "NEEDS REVIEW" on the page
	
	And I click on the "Back" link
	
	When I click on "<part_no_four>" in the same row as "<part_no_four>"
	
	#Then I take a screenshot
	
	And I see "NEEDS REVIEW" on the page
	
	And I click on the "Back" link
	
	When I click on "<part_no_five>" in the same row as "<part_no_five>"
	
	#Then I take a screenshot
	
	And I see "NEEDS REVIEW" on the page
	
	And I click on the "Back" link
	
	When I click on "<part_no_six>" in the same row as "<part_no_six>"
	
	#Then I take a screenshot
	
	And I see "NEEDS REVIEW" on the page
	
	And I click on the "Back" link
	
	When I click on "<part_no_seven>" in the same row as "<part_no_seven>"
	
	#Then I take a screenshot
	
	And I see "NEEDS REVIEW" on the page
	
	And I click on the "Back" link
	
	When I click on "<part_no_eight>" in the same row as "<part_no_eight>"
	
	#Then I take a screenshot
	
	And I see "NEEDS REVIEW" on the page
	
	And I click on the "Back" link
	
	When I click on "<part_no_nine>" in the same row as "<part_no_nine>"
	
	#Then I take a screenshot
	
	And I see "NEEDS REVIEW" on the page
	
Examples:
	|part_no	|part_no_two	|part_no_three	|part_no_four	|part_no_five	|part_no_six	|part_no_seven	|part_no_eight	|part_no_nine	|part_no_ten|part_no_eleven	|last_name	|postcode	|email       	    |pool_no	|pool_no_two|pool_no_three	|
	|645200748	|645200743		|645200720		|645200694		|645200637		|645200884		|645100925		|645200610		|641500226		|645200130	|645200784		|LNAME  	|SY2 6LU	|email@outlook.com	|452170401	|451170401	|415170401		|
	

