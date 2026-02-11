Feature: Regression - Editable Summons

@Regression
Scenario Outline: edit links and buttons disabled

	Given I am on "Public" "ithc"

	Given a bureau owned pool is created with jurors
		| court |juror_number  | pool_number	| att_date_weeks_in_future	| owner |
		| 452   |<juror_number>| <pool_number>	| 2				            | 400	|

	And juror "<juror_number>" has "LAST_NAME" as "<last_name>" new schema
	And juror "<juror_number>" has "POSTCODE" as "<postcode>" new schema

	Then I see "Reply to a jury summons" on the page

	And I set the radio button to "I am replying for someone else"
	And I press the "Continue" button
	Then I see "Their juror details" on the page

	When I set "9-digit juror number" to "<juror_number>"
	When I set "Juror last name" to "<last_name>"
	When I set "Juror postcode" to "<postcode>"
	And I press the "Continue" button
	Then I see "Your Details" on the page

	When I set "First name" to "regrFirstName"
	And I set "Last name" to "regrLastName"
	And I press the "Continue" button
	And I set "How do you know the person you're replying for?" to "friend"
	And I press the "Continue" button
	And I check the "By phone (UK Numbers only)" checkbox
	And I check the "By email" checkbox
	And I set "Main phone" to "01111111119"
	And I set "Another phone (optional)" to "0222222229"
	And I set "Enter your email address" to "editableSummons@regression.com"
	And I set "Enter your email address again" to "editableSummons@regression.com"
	And I press the "Continue" button
	And I set the radio button to "The person is not here"
	And I press the "Continue" button
	Then I see "Is the name we have for them correct?" on the page
	And I choose the "Yes" radio button

	When I press the "Continue" button
	Then I see "Is this their address?" on the page
	And I choose the "Yes" radio button

	When I press the "Continue" button
	And I set "Day" to "01"
	And I set "Month" to "01"
	And I set "Year" to "1990"
	And I press the "Continue" button
	And I set the radio button to "Give a different phone number for the juror"
	And I set "Main phone number" to "0333333339"
	And I set "Another phone number (optional)" to "04444444449"
	And I set the radio button to "Give a different email address for the juror"
	And I set "Enter email address" to "editableSummons@regressionJURORContactEmail.com"
	And I set "Enter the email address again" to "editableSummons@regressionJURORContactEmail.com"
	And I press the "Continue" button

	Then I see "Confirm if the person is eligible for jury service" on the page
	When I press the "Continue" button

	Then I see "Have they lived in the UK, Channel Islands or Isle of Man for more than five consecutive years, since their 13th birthday?" on the page
	When I choose the "Yes" radio button
	And I press the "Continue" button

	Then I see "Has the person you're replying for worked in the criminal justice system in the last 5 years?" on the page
	When I choose the "No" radio button
	And I press the "Continue" button

	Then I see "Is the person currently on bail for a criminal offence?" on the page
	When I choose the "No" radio button
	And I press the "Continue" button

	Then I see "Has the person been found guilty of a criminal offence?" on the page
	When I choose the "No" radio button
	And I press the "Continue" button

	Then I see "Is the person you're replying for being detained, looked after or treated under the Mental Health Act?" on the page
	When I choose the "No" radio button
	And I press the "Continue" button

	Then I see "Has it been decided that the person you're replying for 'lacks mental capacity'?" on the page
	When I choose the "No" radio button
	And I press the "Continue" button

	Then I set the radio button to "Yes, they can start on"
	And I press the "Continue" button

	When I choose the "No" radio button
	When I press the "Continue" button
	Then I see "Check your answers now" on the page

	When I check the "The answers I have given for the person I'm replying for are true as far as I know." checkbox
	And I press the "Submit" button

	Then I see "You have completed your reply" on the page
	Then I see "<juror_number>" on the page

	Then on "JUROR_MOD" . "JUROR_RESPONSE" I see "PROCESSING_STATUS" is "TODO" where "JUROR_NUMBER" is "<juror_number>"
	Then on "JUROR_MOD" . "JUROR_RESPONSE" I see "PROCESSING_COMPLETE" is "N" where "JUROR_NUMBER" is "<juror_number>"

	Given I am on "Bureau" "ithc"
	And I log in as "CPASS"
	
	When I click on the "Search" link
	And I set "Juror number" to "<juror_number>"
	And I press the "Search" button
	And I click on "<juror_number>" in the same row as "<juror_number>"
	
	And I do not see link with text "edit"
	And I do not see link with text "Edit"
	And I do not see link with text "change"
	And I do not see link with text "Change"
	
	Then I click on the "Eligibility" link
	
	And I do not see link with text "edit"
	And I do not see link with text "Edit"
	And I do not see link with text "change"
	And I do not see link with text "Change"
	
	Then I click on the "Deferral or excusal" link

	And I do not see link with text "edit"
	And I do not see link with text "Edit"
	And I do not see link with text "change"
	And I do not see link with text "Change"
	
	Then I click on the "CJS employment" link
	
	And I do not see link with text "edit"
	And I do not see link with text "Edit"
	And I do not see link with text "change"
	And I do not see link with text "Change"
	
	Then I click on the "Reasonable adjustments" link
	
	And I do not see link with text "edit"
	And I do not see link with text "Edit"
	And I do not see link with text "change"
	And I do not see link with text "Change"
	
	Then I click on the "Juror details" link
	
	And I do not see link with text "edit"
	And I do not see link with text "Edit"
	And I do not see link with text "change"
	And I do not see link with text "Change"
	
	Then I click on the "Notes" link
	Then I click on the "Contact log" link

	#add call log
	And I click on the "Log new contact" link
	And I see "Log contact" on the page
	And I select "Discuss Deferral" from the "Select the type of enquiry made" dropdown
	And I choose the "No" radio button
	And I set text area with "id" of "notes" to "Some notes in the call notes field 1"
	And I press the "Save" button
	Then I click on the "Contact log" link
	Then I see "Contact log" on the page
	And I see "Some notes in the call notes field 1" on the page
	
	#check I can enter special characters
	And I click on the "Log new contact" link
	And I select "Discuss Deferral" from the "Select the type of enquiry made" dropdown
	And I choose the "No" radio button
	And I set text area with "id" of "notes" to "Some-one 0% £300 & * ! @ + [] her's ?'"
	And I press the "Save" button
	Then I click on the "Contact log" link
	And I see "Some-one 0% £300 & * ! @ + [] her's ?'" on the page
	
	#check I can enter 2000 chars
	And I click on the "Log new contact" link
	And I select "Discuss Deferral" from the "Select the type of enquiry made" dropdown
	And I choose the "No" radio button
	And I set text area with "id" of "notes" to "These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are tThese are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are t"
	And I see "You have 0 characters remaining" on the page
	And I press the "Save" button
	Then I click on the "Contact log" link
	And I see "These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are tThese are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are t" on the page
	
	#check I cannot enter >2000 chars
	And I click on the "Log new contact" link
	And I select "Discuss Deferral" from the "Select the type of enquiry made" dropdown
	And I choose the "No" radio button
	And I set text area with "id" of "notes" to "Phese are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are tThese are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details"
	And I see "You have 10 characters too many" on the page
	And I press the "Save" button
	And I see "There is a problem" on the page
	And I see "The notes provided are too long" on the page
	
	#check I cannot leave notes empty
	And I set text area with "id" of "notes" to ""
	And I press the "Save" button
	And I see "There is a problem" on the page
	And I see "Please enter the contact-log notes" on the page
	
	#click cancel
	Then I click on the "Cancel" link
	And I click on the "Contact log" link
	And I see "These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are tThese are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are t" on the page
	And I see "Some-one 0% £300 & * ! @ + [] her's ?'" on the page
	And I see "Some notes in the call notes field 1" on the page
	
	#check the response is now allocated to CPASS
	And I click on the "Search" link
	And I set "Juror number" to "<juror_number>"
	And I press the "Search" button
	
	#check call notes are still there
	When I click on "<juror_number>" in the same row as "<juror_number>"
	When I click on the "Notes and logs" link
	When I click on the "Contact log" link
	And I see "These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are tThese are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are t" on the page
	And I see "Some-one 0% £300 & * ! @ + [] her's ?'" on the page
	And I see "Some notes in the call notes field 1" on the page
		
	Then I see "Process reply" on the page
	And I see "More actions" on the page
	Then I press the "More actions" button
	And I click on the "Mark as awaiting information" link
	When I set the radio button to "Juror"
	And I press the "Confirm" button
	
	Then I click on the "Your work" link
	Then I click on the "Awaiting information" link
	
	And I click on "<juror_number>" in the same row as "<juror_number>"
	
	And I do not see link with text "edit"
	And I do not see link with text "Edit"
	And I do not see link with text "change"
	And I do not see link with text "Change"
	
	Then I click on the "Eligibility" link
	
	And I do not see link with text "edit"
	And I do not see link with text "Edit"
	And I do not see link with text "change"
	And I do not see link with text "Change"
	
	Then I click on the "Deferral or excusal" link

	And I do not see link with text "edit"
	And I do not see link with text "Edit"
	And I do not see link with text "change"
	And I do not see link with text "Change"
	
	Then I click on the "CJS employment" link
	
	And I do not see link with text "edit"
	And I do not see link with text "Edit"
	And I do not see link with text "change"
	And I do not see link with text "Change"
	
	Then I click on the "Reasonable adjustments" link
	
	And I do not see link with text "edit"
	And I do not see link with text "Edit"
	And I do not see link with text "change"
	And I do not see link with text "Change"
	
	Then I click on the "Juror details" link
	
	And I do not see link with text "edit"
	And I do not see link with text "Edit"
	And I do not see link with text "change"
	And I do not see link with text "Change"
	
	Then I click on the "Notes and logs" link
	
	Then I click on the "Contact log" link
	
	And I click on the "Log new contact" link
	Then I click on the "Cancel" link
	
	Then I see "Process reply" on the page
	When I select "Mark as responded" from Process reply
	And I check the "Mark juror as 'responded'" checkbox
	And I press the "Confirm" button
	
	Then I click on the "Your work" link
	Then I click on the "Completed" link
	
	And I click on "<juror_number>" in the same row as "<juror_number>"
	
	And I do not see link with text "edit"
	And I do not see link with text "Edit"
	And I do not see link with text "change"
	And I do not see link with text "Change"
	
	Then I click on the "Eligibility" link
	
	And I do not see link with text "edit"
	And I do not see link with text "Edit"
	And I do not see link with text "change"
	And I do not see link with text "Change"
	
	Then I click on the "Deferral or excusal" link

	And I do not see link with text "edit"
	And I do not see link with text "Edit"
	And I do not see link with text "change"
	And I do not see link with text "Change"
	
	Then I click on the "CJS employment" link
	
	And I do not see link with text "edit"
	And I do not see link with text "Edit"
	And I do not see link with text "change"
	And I do not see link with text "Change"
	
	Then I click on the "Reasonable adjustments" link
	
	And I do not see link with text "edit"
	And I do not see link with text "Edit"
	And I do not see link with text "change"
	And I do not see link with text "Change"
	
	Then I click on the "Juror details" link
	
	And I do not see link with text "edit"
	And I do not see link with text "Edit"
	And I do not see link with text "change"
	And I do not see link with text "Change"
	
	Then I click on the "Notes and logs" link
	
	Then I click on the "Contact log" link
	
	And I click on the "Log new contact" link
	Then I click on the "Cancel" link
	
Examples:
	| juror_number	| pool_number	| last_name			| postcode	|
	| 045200173		| 452300157		| LNAMETWOSIXZERO	| CH1 2AN	|