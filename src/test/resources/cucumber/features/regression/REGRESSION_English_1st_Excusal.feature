Feature: Regression English_1st_Excusal

@Regression @NewSchemaConverted
Scenario Outline: English 1st Party Excusal Accepted

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
	When I choose the "Yes" radio button
	
	#Check Name
	When I press the "Continue" button
	Then I see "Is this your address?" on the page
	When I choose the "Yes" radio button
	
	#Check Address
	And I press the "Continue" button
	Then I see "What is your phone number?" on the page
	
	#Phone Details
	When I set "Main phone" to "0207 821 1818"
	And I press the "Continue" button
	Then I see "What is your email address?" on the page
	
	#Email
	When I set "Enter your email address" to "<email>"
	And I set "Enter your email address again" to "<email>"
	And I press the "Continue" button
	Then I see "What is your date of birth?" on the page
	
	#DoB
	When I press the "Continue" button
	Then I see "There is a problem" on the page
	When I set "Day" to "27"
	And I set "Month" to "04"
	And I set "Year" to "1981"
	And I press the "Continue" button
	Then I see "Confirm you're eligible for jury service" on the page
	
	When I press the "Continue" button
	
	#Residency
	Then I see "Since you turned 13, has your main address been in the UK, Channel Islands or Isle of Man for any period of at least 5 years?" on the page
	When I choose the "Yes" radio button
	And I press the "Continue" button
	
	#CJS
	Then I see "Have you worked in the criminal justice system in the last 5 years?" on the page
	When I choose the "No" radio button
	And I press the "Continue" button
	
	#Bail
	When I choose the "No" radio button
	And I press the "Continue" button
	
	#Convictions
	Then I see "Have you been found guilty of a criminal offence?" on the page
	When I choose the "No" radio button
	And I press the "Continue" button
	
	#Mental Health part 1
	Then I see "Are you being detained, looked after or treated under the Mental Health Act?" on the page
	When I choose the "No" radio button
	And I press the "Continue" button
	
	#Mental Health part 2
	When I choose the "No" radio button
	And I press the "Continue" button
	
	#Confirm Date of Jury
	Then I see "Check your start date" on the page
	When I set the radio button to "No, I cannot do jury service and need to be excused" 
	And I press the "Continue" button
	
	#Excusal Reason
	And I see "steps/confirm-date/excusal" in the URL
	Then I see "Why do you need to be excused from jury service?" on the page
	When I see "Explain why you cannot do jury service in the next 12 months." on the page
	And I see "You do not need to attach or gather evidence before your summons deadline." on the page
	And I see "We'll contact you later if we need this." on the page
	
	And I press the "Continue" button
	Then I see "Enter reason why you cannot do jury service in the next 12 months" on the page
	
	Then I set text area with "id" of "excusalReason" to "Excuse me please"
	And I click on the "Will I need to provide evidence soon?" link
	And I see "If we need evidence, we'll contact you separately to tell you." on the page
	And I see "For example, if you're too ill to do jury service, we might ask you to provide a medical certificate from an appropriate regulated healthcare professional, such as a doctor, nurse, physiotherapist, pharmacist or occupational therapist." on the page
	And I see "You will be given time to gather any evidence so do not need to worry about trying to get this now." on the page
	And I see "You should wait until we've told you what evidence we need, if any." on the page

	And I press the "Continue" button
	
	#RA
	Then I see "Will you need help when" on the page
	When I choose the "No" radio button
	And I press the "Continue" button
	Then I see "Check your answers now" on the page
	
	#Check Your Answers Now
	Then I see "Why do you need to be excused from jury service?" on the page
	When I check the "The information" checkbox
	And I press the "Submit" button
	And I see "You have completed your reply" on the page
	
	Then I click on the "Download a copy of your summons reply HTML (15KB)" link
	And I see "Why do you need to be excused from jury service?" on the page
	
	Given I am on "Bureau" "test"
	And I log in as "MODTESTBUREAU"
	And I click on the "Search" link
	And I set "Juror number" to "<juror_number>"
	And I press the "Search" button
	And I click on "<juror_number>" in the same row as "<juror_number>"
	And I click on the "Deferral or excusal" link
	
	Then I see "Excuse me please" on the page
	
	When I click on the "Search" link
	And I set "Juror number" to "<juror_number>"
	And I press the "Search" button
	Then I see "<juror_number>" on the page
	
	And I click link with ID "selectAllLink"
	And I press the "Send to..." button
	And I set input field with "id" of "sendToOfficer" to "CPASS"
	And I press the "Send" button
	And I press the "Send" button
	Then I see "Your work" on the page
	
	Then I click on the "Sign out" link
	When I log in as "CPASS"
	Then I see "<juror_number>" on the page
	Then I see "<juror_number>" has reply type indicator "EXCUSAL"
	And I click on "<juror_number>" in the same row as "<juror_number>"
	
	And I press the "Process reply" button
	And I choose the "Excusal - grant or refuse" radio button
	And I press the "Continue" button
	And I select "D - DECEASED" from the "Reason for excusal request" dropdown

	And I choose the "Grant excusal" radio button
	And the radio button "Grant excusal" is "selected"
	And the radio button "Refuse excusal" is "unselected"
	And I choose the "Refuse excusal" radio button
	And the radio button "Refuse excusal" is "selected"
	And the radio button "Grant excusal" is "unselected"
	And I click on the "Cancel" link
	
	And I press the "Process reply" button
	And I choose the "Excusal - grant or refuse" radio button
	And I press the "Continue" button
	And I select "D - DECEASED" from the "Reason for excusal request" dropdown
	And I choose the "Grant excusal" radio button
	And I press the "Continue" button
	And I see the juror record updated banner containing "Excusal granted (deceased)"
	
Examples:
	| juror_number	| last_name		| postcode	| email           	| pool_number	|
	| 045200051		| LNAMETWOTWOSIX| CH1 2AN	| email@outlook.com	| 452300050		|

@Regression @NewSchemaConverted
Scenario Outline: English 1st Party Excusal Refused

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
	When I choose the "Yes" radio button
	
	#Check Name
	When I press the "Continue" button
	Then I see "Is this your address?" on the page
	When I choose the "Yes" radio button
	
	#Check Address
	And I press the "Continue" button
	Then I see "What is your phone number?" on the page
	
	#Phone Details
	When I set "Main phone" to "0207 821 1818"
	And I press the "Continue" button
	Then I see "What is your email address?" on the page
	
	#Email
	When I set "Enter your email address" to "<email>"
	And I set "Enter your email address again" to "<email>"
	And I press the "Continue" button
	Then I see "What is your date of birth?" on the page
	
	#DoB
	When I press the "Continue" button
	Then I see "There is a problem" on the page
	When I set "Day" to "27"
	And I set "Month" to "04"
	And I set "Year" to "1981"
	And I press the "Continue" button
	Then I see "Confirm you're eligible for jury service" on the page
	
	When I press the "Continue" button
	
	#Residency
	Then I see "Since you turned 13, has your main address been in the UK, Channel Islands or Isle of Man for any period of at least 5 years?" on the page
	When I choose the "Yes" radio button
	And I press the "Continue" button
	
	#CJS
	Then I see "Have you worked in the criminal justice system in the last 5 years?" on the page
	When I choose the "No" radio button
	And I press the "Continue" button
	
	#Bail
	When I choose the "No" radio button
	And I press the "Continue" button
	
	#Convictions
	Then I see "Have you been found guilty of a criminal offence?" on the page
	When I choose the "No" radio button
	And I press the "Continue" button
	
	#Mental Health part 1
	Then I see "Are you being detained, looked after or treated under the Mental Health Act?" on the page
	When I choose the "No" radio button
	And I press the "Continue" button
	
	#Mental Health part 2
	When I choose the "No" radio button
	And I press the "Continue" button
	
	#Confirm Date of Jury
	Then I see "Check your start date" on the page
	When I set the radio button to "No, I cannot do jury service and need to be excused" 
	And I press the "Continue" button
	
	#Excusal Reason
	And I see "steps/confirm-date/excusal" in the URL
	Then I see "Why do you need to be excused from jury service?" on the page
	When I see "Explain why you cannot do jury service in the next 12 months." on the page
	And I see "You do not need to attach or gather evidence before your summons deadline." on the page
	And I see "We'll contact you later if we need this." on the page
	And I click on the "Will I need to provide evidence soon?" link
	And I see "If we need evidence, we'll contact you separately to tell you." on the page
	And I see "For example, if you're too ill to do jury service, we might ask you to provide a medical certificate from an appropriate regulated healthcare professional, such as a doctor, nurse, physiotherapist, pharmacist or occupational therapist." on the page
	And I see "You will be given time to gather any evidence so do not need to worry about trying to get this now." on the page
	And I see "You should wait until we've told you what evidence we need, if any." on the page
	Then I set text area with "id" of "excusalReason" to "Excuse me please"
	And I press the "Continue" button

	#RA
	Then I see "Will you need help when" on the page
	When I choose the "No" radio button
	And I press the "Continue" button
	Then I see "Check your answers now" on the page
	
	#Check Your Answers Now
	When I check the "The information" checkbox
	And I press the "Submit" button
	And I see "You have completed your reply" on the page
	
	Given I am on "Bureau" "test"
	And I log in as "MODTESTBUREAU"
	And I click on the "Search" link
	And I set "Juror number" to "<juror_number>"
	And I press the "Search" button
	And I click on "<juror_number>" in the same row as "<juror_number>"
	And I click on the "Deferral or excusal" link
	
	Then I see "Excuse me please" on the page
	
	And I press the "Process reply" button
	And I choose the "Excusal - grant or refuse" radio button
	And I press the "Continue" button
	Then I select "M - MEDICAL" from the "Reason for excusal request" dropdown
	And I choose the "Refuse excusal" radio button
	And the radio button "Refuse excusal" is "selected"
	And the radio button "Grant excusal" is "unselected"

	And I press the "Continue" button
	And I see the juror record updated banner containing "Excusal refused (medical)"
	
Examples:
	| juror_number	| last_name			| postcode	| email           	| pool_number	|
	| 045200052		| LNAMEEIGHTONETWO	| SY2 6LU	| email@outlook.com	| 452300051		|

@Features @NewSchemaConverted
Scenario Outline: English 1st Party Excusal Super Urgent

	#move back to @Regression when we work out how to get Jankins to focus on new window

	Given I am on "Public" "test"

	Given a bureau owned pool is created with jurors
		| court |juror_number  | pool_number	| att_date_weeks_in_future	| owner |
		| 452   |<juror_number>| <pool_number>	| 1				            | 400	|

	Then a new pool is inserted for where record has transferred to the court new schema
		|part_no         | pool_no       | owner |
		|<juror_number>  | <pool_number> | 452   |
	
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
	When I choose the "Yes" radio button
	
	#Check Name
	When I press the "Continue" button
	Then I see "Is this your address?" on the page
	When I choose the "Yes" radio button
	
	#Check Address
	And I press the "Continue" button
	Then I see "What is your phone number?" on the page
	
	#Phone Details
	When I set "Main phone" to "0207 821 1818"
	And I press the "Continue" button
	Then I see "What is your email address?" on the page
	
	#Email
	When I set "Enter your email address" to "<email>"
	And I set "Enter your email address again" to "<email>"
	And I press the "Continue" button
	Then I see "What is your date of birth?" on the page
	
	#DoB
	When I press the "Continue" button
	Then I see "There is a problem" on the page
	When I set "Day" to "27"
	And I set "Month" to "04"
	And I set "Year" to "1981"
	And I press the "Continue" button
	Then I see "Confirm you're eligible for jury service" on the page
	
	When I press the "Continue" button
	
	#Residency
	Then I see "Since you turned 13, has your main address been in the UK, Channel Islands or Isle of Man for any period of at least 5 years?" on the page
	When I choose the "Yes" radio button
	And I press the "Continue" button
	
	#CJS
	Then I see "Have you worked in the criminal justice system in the last 5 years?" on the page
	When I choose the "No" radio button
	And I press the "Continue" button
	
	#Bail
	When I choose the "No" radio button
	And I press the "Continue" button
	
	#Convictions
	Then I see "Have you been found guilty of a criminal offence?" on the page
	When I choose the "No" radio button
	And I press the "Continue" button
	
	#Mental Health part 1
	Then I see "Are you being detained, looked after or treated under the Mental Health Act?" on the page
	When I choose the "No" radio button
	And I press the "Continue" button
	
	#Mental Health part 2
	When I choose the "No" radio button
	And I press the "Continue" button
	
	#Confirm Date of Jury
	Then I see "Check your start date" on the page
	When I set the radio button to "No, I cannot do jury service and need to be excused"
	And I press the "Continue" button
	
	#Excusal Reason
	And I see "steps/confirm-date/excusal" in the URL
	Then I see "Why do you need to be excused from jury service?" on the page
	When I see "Explain why you cannot do jury service in the next 12 months." on the page
	And I see "You do not need to attach or gather evidence before your summons deadline." on the page
	And I see "We'll contact you later if we need this." on the page
	And I click on the "Will I need to provide evidence soon?" link
	And I see "If we need evidence, we'll contact you separately to tell you." on the page
	And I see "For example, if you're too ill to do jury service, we might ask you to provide a medical certificate from an appropriate regulated healthcare professional, such as a doctor, nurse, physiotherapist, pharmacist or occupational therapist." on the page
	And I see "You will be given time to gather any evidence so do not need to worry about trying to get this now." on the page
	And I see "You should wait until we've told you what evidence we need, if any." on the page
	Then I set text area with "id" of "excusalReason" to "Excuse me please"
	And I press the "Continue" button
	
	#RA
	Then I see "Will you need help when" on the page
	When I choose the "No" radio button
	And I press the "Continue" button
	Then I see "Check your answers now" on the page
	
	#Check Your Answers Now
	When I check the "The information" checkbox
	And I press the "Submit" button
	And I see "You have completed your reply" on the page
	
	Given I am on "Bureau" "test"
	When I log in as "CPASS"
	
	When I click on the "Search" link
	And I set "Juror number" to "<juror_number>"
	And I press the "Search" button
	Then I see "<juror_number>" on the page
	And I click on "<juror_number>" in the same row as "<juror_number>"

	And I press the "More actions" button
	And I click on the "Download as a PDF" link
#	And I switch to the new window
	And I focus page to the new tab
	And I see "<juror_number>/download-pdf" in the URL
	
Examples:
	| juror_number	| last_name			| postcode	| email           	| pool_number	|
	| 045200053		| LNAMEONEFOURSEVEN | SY2 6LU	| email@outlook.com	| 452300052		|
	
@Regression @NewSchemaConverted
Scenario Outline: English 1st Party Excusal error messages

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
	When I choose the "Yes" radio button

	#Check Name
	When I press the "Continue" button
	Then I see "Is this your address?" on the page
	When I choose the "Yes" radio button

	#Check Address
	And I press the "Continue" button
	Then I see "What is your phone number?" on the page

	#Phone Details
	When I set "Main phone" to "0207 821 1818"
	And I press the "Continue" button
	Then I see "What is your email address?" on the page

	#Email
	When I set "Enter your email address" to "<email>"
	And I set "Enter your email address again" to "<email>"
	And I press the "Continue" button
	Then I see "What is your date of birth?" on the page

	#DoB
	When I set "Day" to "27"
	And I set "Month" to "04"
	And I set "Year" to "1981"
	And I press the "Continue" button
	Then I see "Confirm you're eligible for jury service" on the page

	When I press the "Continue" button

	#Residency
	Then I see "Since you turned 13, has your main address been in the UK, Channel Islands or Isle of Man for any period of at least 5 years?" on the page
	When I choose the "Yes" radio button
	And I press the "Continue" button

	#CJS
	Then I see "Have you worked in the criminal justice system in the last 5 years?" on the page
	When I choose the "No" radio button
	And I press the "Continue" button

	#Bail
	When I choose the "No" radio button
	And I press the "Continue" button

	#Convictions
	Then I see "Have you been found guilty of a criminal offence?" on the page
	When I choose the "No" radio button
	And I press the "Continue" button

	#Mental Health part 1
	Then I see "Are you being detained, looked after or treated under the Mental Health Act?" on the page
	When I choose the "No" radio button
	And I press the "Continue" button

	#Mental Health part 2
	When I choose the "No" radio button
	And I press the "Continue" button

	#Confirm Date of Jury
	Then I see "Check your start date" on the page
	When I set the radio button to "No, I cannot do jury service and need to be excused"
	And I press the "Continue" button

	#Excusal Reason
	And I see "steps/confirm-date/excusal" in the URL
	Then I see "Why do you need to be excused from jury service?" on the page
	When I see "Explain why you cannot do jury service in the next 12 months." on the page
	And I see "You do not need to attach or gather evidence before your summons deadline." on the page
	And I see "We'll contact you later if we need this." on the page
	And I click on the "Will I need to provide evidence soon?" link
	And I see "If we need evidence, we'll contact you separately to tell you." on the page
	And I see "For example, if you're too ill to do jury service, we might ask you to provide a medical certificate from an appropriate regulated healthcare professional, such as a doctor, nurse, physiotherapist, pharmacist or occupational therapist." on the page
	And I see "You will be given time to gather any evidence so do not need to worry about trying to get this now." on the page
	And I see "You should wait until we've told you what evidence we need, if any." on the page
	Then I set text area with "id" of "excusalReason" to "Excuse me please"
	And I press the "Continue" button

	#RA
	Then I see "Will you need help when" on the page
	When I choose the "No" radio button
	And I press the "Continue" button
	Then I see "Check your answers now" on the page

	#Check Your Answers Now
	When I check the "The information" checkbox
	And I press the "Submit" button
	And I see "You have completed your reply" on the page

	Given I am on "Bureau" "test"
	And I log in as "MODTESTBUREAU"
	And I click on the "Search" link
	And I set "Juror number" to "<juror_number>"
	And I press the "Search" button
	And I click on "<juror_number>" in the same row as "<juror_number>"
	And I click on the "Deferral or excusal" link
	
	Then I see "Excuse me please" on the page
	
	And I press the "Process reply" button

	# error when dont select anything
	And I press the "Continue" button
	Then I see "There is a problem" on the page
	
	And I see "Please select a response process type" on the page

	And I choose the "Excusal - grant or refuse" radio button
	And I press the "Continue" button
	
	# error when I dont select a decision
	And I press the "Continue" button
	And I see "Select the juror’s reason for requesting this excusal" on the page
	And I see "Select whether you want to grant or refuse an excusal for this juror" on the page

	Then I select "M - MEDICAL" from the "Reason for excusal request" dropdown
	And I press the "Continue" button
	
	Then I see "There is a problem" on the page
	And I see "Select whether you want to grant or refuse an excusal for this juror" on the page

	# error when I dont select a reason
	And I choose the "Grant excusal" radio button
	And I select "Select a reason..." from the "Reason for excusal request" dropdown
	
	And I press the "Continue" button
	Then I see "There is a problem" on the page
	And I see "Select the juror’s reason for requesting this excusal" on the page

	# select both and process
	Then I select "M - MEDICAL" from the "Reason for excusal request" dropdown
	And I choose the "Grant excusal" radio button
	And I press the "Continue" button
	
	And I see the juror record updated banner containing "Excusal granted (medical)"
	
Examples:
	| juror_number	| last_name			| postcode	| email           	| pool_number|
	| 045200054		| LNAMEEIGHTONEFOUR	| SY2 6LU	| email@outlook.com	| 452300053	 |
	
@Regression @NewSchemaConverted
Scenario Outline: English 1st Party Excusal Reason Special Character (£) check

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
	
	#Check Name
	When I choose the "No" radio button
	When I press the "Continue" button
	And I set "First name" to "Joe"
	And I set "Last name" to "Blogs"
	And I press the "Continue" button
	
	#Check Address
	Then I see "Is this your address?" on the page
	When I choose the "Yes" radio button
	
	And I press the "Continue" button
	Then I see "What is your phone number?" on the page
	
	#Phone Details
	When I set "Main phone" to "0207 821 1818"
	And I press the "Continue" button
	Then I see "What is your email address?" on the page
	
	#Email
	When I set "Enter your email address" to "<email>"
	And I set "Enter your email address again" to "<email>"
	And I press the "Continue" button
	Then I see "What is your date of birth?" on the page
	
	#DoB
	When I press the "Continue" button
	Then I see "There is a problem" on the page
	When I set "Day" to "27"
	And I set "Month" to "04"
	And I set "Year" to "1981"
	And I press the "Continue" button
	Then I see "Confirm you're eligible for jury service" on the page
	
	When I press the "Continue" button
	
	#Residency
	Then I see "Since you turned 13, has your main address been in the UK, Channel Islands or Isle of Man for any period of at least 5 years?" on the page
	When I choose the "Yes" radio button
	And I press the "Continue" button
	
	#CJS
	Then I see "Have you worked in the criminal justice system in the last 5 years?" on the page
	When I choose the "No" radio button
	And I press the "Continue" button
	
	#Bail
	When I choose the "No" radio button
	And I press the "Continue" button
	
	#Convictions
	Then I see "Have you been found guilty of a criminal offence?" on the page
	When I choose the "No" radio button
	And I press the "Continue" button
	
	#Mental Health part 1
	Then I see "Are you being detained, looked after or treated under the Mental Health Act?" on the page
	When I choose the "No" radio button
	And I press the "Continue" button
	
	#Mental Health part 2
	When I choose the "No" radio button
	And I press the "Continue" button
	
	#Confirm Date of Jury
	Then I see "Check your start date" on the page
	When I set the radio button to "No, I cannot do jury service and need to be excused" 
	And I press the "Continue" button
	
	#Excusal Reason
	Then I see "Why do you need to be excused from jury service?" on the page
	Then I set text area with "id" of "excusalReason" to "Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here£ Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here£ Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here£ Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here£ Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here£ Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here£ Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here££ that is 1000"
	And I press the "Continue" button
	
	Then I see "Will you need help when" on the page
	When I choose the "No" radio button
	And I press the "Continue" button
	Then I see "Check your answers now" on the page
	
	#Check Your Answers Now
	When I check the "The information" checkbox
	And I press the "Submit" button
	And I see "You have completed your reply" on the page
	
	#check Bureau
	Given I am on "Bureau" "test"
	And I log in as "MODTESTBUREAU"
	
	When I click on the "Search" link
	And I set "Juror number" to "<juror_number>"
	And I press the "Search" button
	Then I see "<juror_number>" on the page
	
	And I click link with ID "selectAllLink"
	And I press the "Send to..." button
	And I set input field with "id" of "sendToOfficer" to "CPASS"
	And I press the "Send" button
	And I press the "Send" button
	Then I see "Your work" on the page
	
	Then I click on the "Sign out" link
	When I log in as "CPASS"
	Then I see "<juror_number>" on the page
	Then I see "<juror_number>" has reply type indicator "EXCUSAL"
	And I click on "<juror_number>" in the same row as "<juror_number>"
	And I click on the "Deferral or excusal" link
	
	Then I see "Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here£ Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here£ Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here£ Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here£ Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here£ Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here£ Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here££ that is 1000" on the page
	
Examples:
	| juror_number	| last_name	| postcode	| email           	| pool_number|
	| 045200055		| DOE		| CH1 2AN	| email@outlook.com	| 452300054	 |
	
@Regression @NewSchemaConverted
Scenario Outline: 1st English Back Button Logic with Excusal Reason Screen

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
	Then on the page I see
		|text|
		|Your details|
		|Is the name we have for you correct?|
	
	And I choose the "Yes" radio button
	And I press the "Continue" button
	Then on the page I see
		|text|
		|Is this your address?|

	And I choose the "Yes" radio button
	When I press the "Continue" button
	
	Then on the page I see
		|text|
		|Your details|
		|What is your phone number?|
		|Please provide a UK phone number that we can use to reach you between 9am and 5pm, Monday to Friday.|
		|Main phone|
		|Another phone (optional)|
	
	When I press the "Continue" button
	Then on the page I see
		|text|
		|There is a problem|
		|Enter your main phone number|

	When I set "Main phone" to "02078211818"
	And I press the "Continue" button

	Then on the page I see
		|text|
		|Your details|
		|What is your email address?|
		|Enter your email address|
		|Enter your email address again|

	When I press the "Continue" button
	Then on the page I see
		|text|
		|Your details|
		|Enter your email address|
	
	When I set "Enter your email address" to "test@gmail.com"
	And I press the "Continue" button
	Then I see "Enter your email address and check that it matches the one in the first field" on the page
	When I set "Enter your email address again" to "test@gmail.com"
	And I press the "Continue" button

	Then on the page I see
		|text|
		|Your details|
		|What is your date of birth?|
		|For example, 15 03 1982|
		|Help with date of birth|
	
	When I set "Day" to "01"
	And I set "Month" to "01"
	And I set "Year" to "1990"
	And I press the "Continue" button

	#Qualify for jury service
	Then I see "Confirm you're eligible for jury service" on the page
	When I press the "Continue" button

	When I see "Since you turned 13, has your main address been in the UK, Channel Islands or Isle of Man for any period of at least 5 years?" on the page
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
	Then I see "Check your answers now" on the page
	
	#Check Your Answers (Covers Scenarios 1 and 2)
	When I click on the "Change" link in the same row as "Confirm the date of your jury service"
	Then I see "Check your start date" on the page
	
	#Confirm Date of Jury Service
	When I set the radio button to "No, I cannot do jury service and need to be excused"
	And I press the "Continue" button
	Then I see "Why do you need to be excused from jury service?" on the page
	
	#Excusal Reason
	When I press the "Continue" button
	Then I see "Enter reason why you cannot do jury service in the next 12 months" on the page
	When I click on the "Back" link
	Then I see "Check your start date" on the page
	
	#Confirm Date of Jury Service
	And I see "Yes, I can start on" on the page
	And I set the radio button to "Yes, I can start on"
	And I press the "Continue" button
	Then I see "Check your answers now" on the page
	When I click on the "Change" link in the same row as "Confirm the date of your jury service"
	Then I see "Check your start date" on the page
	When I set the radio button to "No, I cannot do jury service and need to be excused"
	And I press the "Continue" button
	Then I see "Why do you need to be excused from jury service?" on the page
	
	#Excusal Reason
	When I click on the "Back" link
	Then I see "Check your start date" on the page
	When I click on the "Back" link
	Then I see "Check your answers now" on the page
	
	#Check Your Answers (to confirm screnario 1 and 2 pass)
	When I see text "I can do jury service on the date shown" in the same row as "Confirm the date of your jury service"
	
	#Check Your Answers (Covers Scenario 3)
	When I click on the "Change" link in the same row as "Confirm the date of your jury service"
	Then I see "Check your start date" on the page
	
	#Confirm Date of Jury Service
	When I set the radio button to "No, I cannot do jury service and need to be excused"
	And I press the "Continue" button
	Then I see "Why do you need to be excused from jury service?" on the page
	
	#Excusal Reason
	When I set text area with "id" of "excusalReason" to "Excuse me please"
	And I press the "Continue" button
	Then I see "Check your answers now" on the page
	
	#Check Your Answers
	When I click on the "Change" link in the same row as "Say why you need to be excused from jury service"
	When I set text area with "id" of "excusalReason" to ""
	And I press the "Continue" button
	Then I see "Enter reason why you cannot do jury service in the next 12 months" on the page
	When I click on the "Back" link	
	
	#Check Your Answers (to confirm scenario 3 passes)
	Then I see "Check your answers now" on the page
	And I see "Excuse me please" on the page
	When I check the "The information I have given is true to the best of my knowledge" checkbox
	And I press the "Submit" button
	Then I see "We have sent you an email to say you have replied to your jury summons." on the page
	
Examples:
	| juror_number	| last_name	| postcode	| email 		| pool_number|
	| 045200056		| DOE		| SW1H 9AJ	| a@eeee.com	| 452300055	 |

@Regression @NewSchemaConverted
Scenario Outline: Checking excusal text on Check Your Answers Now page

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
	When I choose the "Yes" radio button
	
	#Check Name
	When I press the "Continue" button
	Then I see "Is this your address?" on the page
	When I choose the "Yes" radio button
	
	#Check Address
	And I press the "Continue" button
	Then I see "What is your phone number?" on the page
	
	#Phone Details
	When I set "Main phone" to "0207 821 1818"
	And I press the "Continue" button
	Then I see "What is your email address?" on the page
	
	#Email
	When I set "Enter your email address" to "<email>"
	And I set "Enter your email address again" to "<email>"
	And I press the "Continue" button
	Then I see "What is your date of birth?" on the page
	
	#DoB
	When I press the "Continue" button
	Then I see "There is a problem" on the page
	When I set "Day" to "27"
	And I set "Month" to "04"
	And I set "Year" to "1981"
	And I press the "Continue" button
	Then I see "Confirm you're eligible for jury service" on the page
	
	When I press the "Continue" button
	
	#Residency
	Then I see "Since you turned 13, has your main address been in the UK, Channel Islands or Isle of Man for any period of at least 5 years?" on the page
	When I choose the "Yes" radio button
	And I press the "Continue" button
	
	#CJS
	Then I see "Have you worked in the criminal justice system in the last 5 years?" on the page
	When I choose the "No" radio button
	And I press the "Continue" button
	
	#Bail
	When I choose the "No" radio button
	And I press the "Continue" button
	
	#Convictions
	Then I see "Have you been found guilty of a criminal offence?" on the page
	When I choose the "No" radio button
	And I press the "Continue" button
	
	#Mental Health part 1
	Then I see "Are you being detained, looked after or treated under the Mental Health Act?" on the page
	When I choose the "No" radio button
	And I press the "Continue" button
	
	#Mental Health part 2
	When I choose the "No" radio button
	And I press the "Continue" button
	
	#Confirm Date of Jury
	Then I see "Check your start date" on the page
	When I set the radio button to "No, I cannot do jury service and need to be excused" 
	And I press the "Continue" button
	
	#Excusal Reason
	Then I see "Why do you need to be excused from jury service?" on the page
	When I set text area with "id" of "excusalReason" to "Excuse me please"
	And I press the "Continue" button
	
	#RA
	Then I see "Will you need help when" on the page
	When I choose the "No" radio button
	And I press the "Continue" button
	Then I see "Check your answers now" on the page
	
	#Check Your Answers Now
	When I see "Why do you need to be excused from jury service?" on the page
	And I check the "The information" checkbox
	And I press the "Submit" button
	And I see "You have completed your reply" on the page
	
Examples:
	| juror_number	| last_name	| postcode	| email           	| pool_number|
	| 045200057		| DOE		| SW1H 9AJ	| email@outlook.com	| 452300056	 |

@Regression @NewSchemaConverted
Scenario Outline: English 1st Party Excusal Reason Special Character 1000 x (£) check

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
	When I choose the "Yes" radio button
	
	#Check Name
	When I press the "Continue" button
	Then I see "Is this your address?" on the page
	When I choose the "Yes" radio button
	
	#Check Address
	And I press the "Continue" button
	Then I see "What is your phone number?" on the page
	
	#Phone Details
	When I set "Main phone" to "0207 821 1818"
	And I press the "Continue" button
	Then I see "What is your email address?" on the page
	
	#Email
	When I set "Enter your email address" to "<email>"
	And I set "Enter your email address again" to "<email>"
	And I press the "Continue" button
	Then I see "What is your date of birth?" on the page
	
	#DoB
	When I press the "Continue" button
	Then I see "There is a problem" on the page
	When I set "Day" to "27"
	And I set "Month" to "04"
	And I set "Year" to "1981"
	And I press the "Continue" button
	Then I see "Confirm you're eligible for jury service" on the page
	
	When I press the "Continue" button
	
	#Residency
	Then I see "Since you turned 13, has your main address been in the UK, Channel Islands or Isle of Man for any period of at least 5 years?" on the page
	When I choose the "Yes" radio button
	And I press the "Continue" button
	
	#CJS
	Then I see "Have you worked in the criminal justice system in the last 5 years?" on the page
	When I choose the "No" radio button
	And I press the "Continue" button
	
	#Bail
	When I choose the "No" radio button
	And I press the "Continue" button
	
	#Convictions
	Then I see "Have you been found guilty of a criminal offence?" on the page
	When I choose the "No" radio button
	And I press the "Continue" button
	
	#Mental Health part 1
	Then I see "Are you being detained, looked after or treated under the Mental Health Act?" on the page
	When I choose the "No" radio button
	And I press the "Continue" button
	
	#Mental Health part 2
	When I choose the "No" radio button
	And I press the "Continue" button
	
	#Confirm Date of Jury
	Then I see "Check your start date" on the page
	When I set the radio button to "No, I cannot do jury service and need to be excused" 
	And I press the "Continue" button
	
	#Excusal Reason
	Then I see "Why do you need to be excused from jury service?" on the page
	When I set text area with "id" of "excusalReason" to "££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££"
	And I press the "Continue" button
	
	#RA
	Then I see "Will you need help when" on the page
	When I choose the "No" radio button
	And I press the "Continue" button
	Then I see "Check your answers now" on the page
	
	#Check Your Answers Now
	When I check the "The information" checkbox
	And I press the "Submit" button
	And I see "You have completed your reply" on the page
	
	Given I am on "Bureau" "test"
	And I log in as "MODTESTBUREAU"
	And I click on the "Search" link
	And I set "Juror number" to "<juror_number>"
	And I press the "Search" button
	And I click on "<juror_number>" in the same row as "<juror_number>"
	And I click on the "Deferral or excusal" link
	
	Then I see "££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££" on the page
	
Examples:
	| juror_number	|last_name	|postcode	|email           	|pool_number|
	| 045200058		|DOE		|SW1H 9AJ	|email@outlook.com	|452300057	|