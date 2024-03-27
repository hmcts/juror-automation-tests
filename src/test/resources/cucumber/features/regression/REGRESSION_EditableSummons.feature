Feature: Regression - Editable Summons


#	Edit links/buttons disabled
@RegressionSingle @JDB-5048 
Scenario Outline: 
	Given I am on "Public" "juror-test01"
	Given the juror numbers have not been processed
		|part_no 	|pool_no 	|owner 	|
		|<part_no> 	|<pool_no>	|400 	|

	#Set part_no pool to be urgent
	Given "<juror_number>" has "RET_DATE" as "2 mondays time"
	And "<juror_number>" has "NEXT_DATE" as "2 mondays time"

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
	
	Then I see "Since they turned 13, has their main address been in the UK, Channel Islands or Isle of Man for any period of at least 5 years?" on the page
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

	Given I am on "Bureau" "juror-test01"
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
	
	Then I click on the "Logs" link
	Then I click on the "Call log" link

	#add call log
	
	And I press the "Log a call" button
	And I see "Log a call" on the page
	And I see "<last_name>" on the page
	And I see "/<part_no>/call-log" in the URL
	And I set text area with "id" of "callNotes" to "Some notes in the call notes field 1"
	And I press the "Save" button
	Then I see "Call log" on the page
	And I see "Some notes in the call notes field 1" on the page
	
	#check I can enter special characters
	
	And I press the "Log a call" button
	And I set text area with "id" of "callNotes" to "Some-one 0% £300 & * ! @ + [] her's ?'"
	And I press the "Save" button
	And I see "Some-one 0% £300 & * ! @ + [] her's ?'" on the page
	
	#check I can enter 2000 chars
	
	And I press the "Log a call" button
	And I set text area with "id" of "callNotes" to "These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are tThese are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are t"
	And I see "You have 0 characters remaining" on the page
	And I press the "Save" button
	And I see "These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are tThese are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are t" on the page
	
	#check I cannot enter >2000 chars
	
	And I press the "Log a call" button
	And I set text area with "id" of "callNotes" to "Phese are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are tThese are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details"
	And I see "You have 10 characters too many" on the page
	And I press the "Save" button
	And I see "There is a problem" on the page
	And I see "Call notes must be 2000 characters or fewer" on the page
	
	#check I cannot leave notes empty
	
	And I set text area with "id" of "callNotes" to ""
	And I press the "Save" button
	And I see "There is a problem" on the page
	And I see "Provide some notes from the call" on the page
	
	#click cancel
	
	Then I click on the "Cancel" link
	And I see "These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are tThese are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are t" on the page
	And I see "Some-one 0% £300 & * ! @ + [] her's ?'" on the page
	And I see "Some notes in the call notes field 1" on the page
	
	#check the response is now allocated to CPASS
	
	And I click on the "Search" link
	And I set "Juror number" to "<juror_number>"
	And I press the "Search" button
	Then I see "CPASS" in the same row as "<juror_number>"
	
	#check call notes are still there
	
	When I click on "<juror_number>" in the same row as "<juror_number>"
	When I click on the "Logs" link
	When I click on the "Call log" link
	And I see "These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are tThese are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are t" on the page
	And I see "Some-one 0% £300 & * ! @ + [] her's ?'" on the page
	And I see "Some notes in the call notes field 1" on the page
		
	Then I see "Process reply" on the page
	And I see "More actions" on the page
	Then I press the "More actions" button
	And I click on the "Mark as 'Awaiting information'" link
	When I set the radio button to "Awaiting juror"
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
	
	Then I click on the "Logs" link
	
	And I see link with text "Add or Edit"
	
	Then I click on the "Call log" link
	
	And I press the "Log a call" button
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
	
	Then I click on the "Logs" link
	
	And I see link with text "Add or Edit"
	
	Then I click on the "Call log" link
	
	And I press the "Log a call" button
	Then I click on the "Cancel" link
	
Examples:
	|part_no	|pool_no	|last_name		|postcode	| email |
	|645100999	|451170401	|LNAMETWOSIXZERO|CH1 2AN	|a@a.com|
	
#	Edit links/buttons disabled
@JDB-3644 
Scenario Outline: jdb-3644
	Given I am on "Public" "bau-test"
	Given the juror numbers have not been processed
		| part_no 	| pool_no 	| owner |
		| <part_no> |<pool_no>	| 400 	|
		
	#Set part_no pool to be urgent
	Given "<juror_number>" has "RET_DATE" as "2 mondays time"
	And "<juror_number>" has "NEXT_DATE" as "2 mondays time"

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
	
	Then I see "Since they turned 13, has their main address been in the UK, Channel Islands or Isle of Man for any period of at least 5 years?" on the page
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

	Given I am on "Bureau" "bau-test"
	And I log in as "CPASS"
	
	When I click on the "Search" link
	And I set "Juror number" to "<juror_number>"
	And I press the "Search" button
	And I click on "<juror_number>" in the same row as "<juror_number>"
	And I click on the "Change" link
	And I set "Title (optional)" to ""
	And I set "First name" to ""
	And I set "Last name" to ""
	And I set "Address line 1" to ""
	And I set "Street Address" to ""
	And I set "Town or city" to ""
	And I set "County" to ""
	And I set "Postcode" to ""
	And I set "Day" to ""
	And I set "Month" to ""
	And I set "Year" to ""
	And I set "Main phone number" to ""
	And I set "Another phone" to ""
	And I set "Edit email address" to ""
	And I set "Confirm email address" to ""
		
	And I set "First name" to "" for "thirdParty"
	And I set "Last name" to "" for "thirdParty"
	And I set input field with "id" of "relationship" to ""
	And I set "Main phone" to "" for "thirdParty"
	And I set "Another phone" to "" for "thirdParty"
	And I set "Edit email address" to "" for "thirdParty"
	And I set "Confirm email address" to ""
	And I click on the "Save" link

	Then I see "Please provide the first name" on the page
	And I see "Please provide the last name" on the page
	And I see "Please provide the first line of the address" on the page
	And I see "Please provide the Town or City" on the page
	And I see "Please provide the postcode" on the page
	And I see "Please enter the day the person was born" on the page
	And I see "Please enter the month the person was born" on the page
	And I see "Please enter the year the person was born" on the page
	And I see "Please enter the main phone number" on the page
	And I see "Please enter the email address" on the page
	And I see "Please enter the third party first name" on the page
	And I see "Please enter the third party last name" on the page
	And I see "Please enter the third party relationship to person summoned" on the page
	
	### QC Step 3 done
	When I set "First name" to "" for "thirdParty"
	When I click on the "Cancel" link
	Then I see "<last_name>" in the same row as "Name"
	
	When I click on the "Change" link
	And I set "Main phone number" to "0111111123123a"
	And I click on the "Save" link
	Then I see "Please check the main phone" on the page
	
	## QC Step 4 Done
	When I set "Main phone number" to "01111123123"
	And I click on the "Save" link
	And I see "Please give a reason for the change to this summons reply" on the page
	And I set "Please give a reason for the change to this summons reply" to "testNotesAB_TwoOnEditableC"
	And I click link with ID "changeLogCancelButton"
	And I set "Main phone" to "01111123123a"
	And I click on the "Save" link
	Then I see "Please check the third party main phone number" on the page
	
	## QC Step 5 Done
	When I set "Main phone" to "01111123123"
	When I set "Edit email address" to "editableSummonsregressionJURORContactEmail.comm"
	And I click on the "Save" link
	Then I see "Please check the email address" on the page
	
	## QC Step 6 Done
	When I set "Edit email address" to "editableSummons@regressionJURORContactEmail.com"
	When I set "Edit email address" to "editableSummonsregression.com" for "thirdParty"
	And I click on the "Save" link
	Then I see "Please check the email address" on the page
	When I set "Main phone" to "1111123123" for "thirdParty"

	When I click on the "Cancel" link
	And I see "Change" on the page
	And I click on the "Change" link
	And I see "Cancel" on the page
	And I see "Save" on the page
	And I click on the "Save" link
	And I set "Please give a reason for the change to this summons reply" to "testNotesAB_TwoOnEditableC"
	And I click link with ID "changeLogSaveButton"
	
	When I click on the "Eligibility" link
	Then I see "Residency" on the page
	And I see "Mental health" on the page
	And I see "Bail" on the page
	
	When I click on the "Change" link
	And on Bureau I see "Since you turned 13, has your main address been in the UK, Channel Islands or Isle of Man for any period of at least 5 years?" under "Residency"
	And I choose the "No" radio button under "Residency"
	And I choose the "Yes" radio button under "Mental health"
	And I choose the "Yes" radio button under "Bail"
	And I choose the "Yes" radio button under "Convictions"
	And I click link with ID "eligibilitySaveButton"
	
	Then I see "Please give details about the person's residency" on the page
	And I see "Please give details about the Mental Health and Capacity acts" on the page
	And I see "Please give details about the person's bail" on the page
	And I see "Please give details about the person's criminal offence" on the page
	
	When I choose the "Yes" radio button under "Residency"
	Then I do not see "Please give details about the person's residency" on the page
	
	And I choose the "No" radio button under "Mental health"
	And I do not see "Please give details about the Mental Health and Capacity acts" on the page
		
	And I choose the "No" radio button under "Bail"
	And I do not see "Please give details about the person's bail" on the page
	
	And I choose the "No" radio button under "Convictions"
	And I see "Have you been found guilty of a criminal offence" on the page
	And I do not see "Provide details" on the page
	
	And I choose the "No" radio button under "Residency"
	And I see "Please give details about the person's residency" on the page
	And I set text area with "id" of "residencyDetails" to "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede mollis pretium. Integer tincidunt. Cras dapibus. Vivamus elementum semper nisi. Aenean vulputate eleifend tellus. Aenean leo ligula, porttitor eu, consequat vitae, eleifend ac, enim. Aliquam lorem ante, dapibus in, viverra quis, feugiat a, tellus. Phasellus viverra nulla ut metus varius laoreet. Quisque rutrum. Aenean imperdiet. Etiam ultricies nisi vel augue. Curabitur ullamcorper ultricies nisi. Nam eget dui. Etiam rhoncus. Maecenas tempus, tellus eget condimentum rhoncus, sem quam semper libero, sit amet adipiscing sem neque sed ipsum. Naaaaaa"
	Then "Provide details" is "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede mollis pretium. Integer tincidunt. Cras dapibus. Vivamus elementum semper nisi. Aenean vulputate eleifend tellus. Aenean leo ligula, porttitor eu, consequat vitae, eleifend ac, enim. Aliquam lorem ante, dapibus in, viverra quis, feugiat a, tellus. Phasellus viverra nulla ut metus varius laoreet. Quisque rutrum. Aenean imperdiet. Etiam ultricies nisi vel augue. Curabitur ullamcorper ultricies nisi. Nam eget dui. Etiam rhoncus. Maecenas tempus, tellus eget condimentum rhoncus, sem quam semper libero, sit amet adipiscing sem neque sed ipsum. N"
	
	And I click link with ID "eligibilitySaveButton"
	And I see "Please give a reason for the change to this summons reply" on the page
	And I set "Please give a reason for the change to this summons reply" to "testNotesABC"
	And I click link with ID "changeLogSaveButton"
	Then I see "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede mollis pretium. Integer tincidunt. Cras dapibus. Vivamus elementum semper nisi. Aenean vulputate eleifend tellus. Aenean leo ligula, porttitor eu, consequat vitae, eleifend ac, enim. Aliquam lorem ante, dapibus in, viverra quis, feugiat a, tellus. Phasellus viverra nulla ut metus varius laoreet. Quisque rutrum. Aenean imperdiet. Etiam ultricies nisi vel augue. Curabitur ullamcorper ultricies nisi. Nam eget dui. Etiam rhoncus. Maecenas tempus, tellus eget condimentum rhoncus, sem quam semper libero, sit amet adipiscing sem neque sed ipsum. N" on the page
	
	###  QC step 11 done

	When I click on the "Deferral or excusal" link
	Then I see "Deferral or excusal" on the page
	
	When I click on the "Change" link
	Then I see "Save" on the page
	Then I see "Cancel" on the page
	And I set the radio button to "I need to change the date of my jury service"
	
	Then I see "Deferral reason" on the page
	And I set text area with "id" of "deferralReason" to "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede mollis pretium. Integer tincidunt. Cras dapibus. Vivamus elementum semper nisi. Aenean vulputate eleifend tellus. Aenean leo ligula, porttitor eu, consequat vitae, eleifend ac, enim. Aliquam lorem ante, dapibus in, viverra quis, feugiat a, tellus. Phasellus viverra nulla ut metus varius laoreet. Quisque rutrum. Aenean imperdiet. Etiam ultricies nisi vel augue. Curabitur ullamcorper ultricies nisi. Nam eget dui. Etiam rhoncus. Maecenas tempus, tellus eget condimentum rhoncus, sem quam semper libero, sit amet adipiscing sem neque sed ipsum. N"
	Then "deferralReason" is "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede mollis pretium. Integer tincidunt. Cras dapibus. Vivamus elementum semper nisi. Aenean vulputate eleifend tellus. Aenean leo ligula, porttitor eu, consequat vitae, eleifend ac, enim. Aliquam lorem ante, dapibus in, viverra quis, feugiat a, tellus. Phasellus viverra nulla ut metus varius laoreet. Quisque rutrum. Aenean imperdiet. Etiam ultricies nisi vel augue. Curabitur ullamcorper ultricies nisi. Nam eget dui. Etiam rhoncus. Maecenas tempus, tellus eget condimentum rhoncus, sem quam semper libero, sit amet adipiscing sem neque sed ipsum. N"
	
	And I set input field with "id" of "declineDates" to "Yes"
	And I set text area with "id" of "excusalReason" to "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede mollis pretium. Integer tincidunt. Cras dapibus. Vivamus elementum semper nisi. Aenean vulputate eleifend tellus. Aenean leo ligula, porttitor eu, consequat vitae, eleifend ac, enim. Aliquam lorem ante, dapibus in, viverra quis, feugiat a, tellus. Phasellus viverra nulla ut metus varius laoreet. Quisque rutrum. Aenean imperdiet. Etiam ultricies nisi vel augue. Curabitur ullamcorper ultricies nisi. Nam eget dui. Etiam rhoncus. Maecenas tempus, tellus eget condimentum rhoncus, sem quam semper libero, sit amet adipiscing sem neque sed ipsum. Naaaa"
	Then "excusalReason" is "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede mollis pretium. Integer tincidunt. Cras dapibus. Vivamus elementum semper nisi. Aenean vulputate eleifend tellus. Aenean leo ligula, porttitor eu, consequat vitae, eleifend ac, enim. Aliquam lorem ante, dapibus in, viverra quis, feugiat a, tellus. Phasellus viverra nulla ut metus varius laoreet. Quisque rutrum. Aenean imperdiet. Etiam ultricies nisi vel augue. Curabitur ullamcorper ultricies nisi. Nam eget dui. Etiam rhoncus. Maecenas tempus, tellus eget condimentum rhoncus, sem quam semper libero, sit amet adipiscing sem neque sed ipsum. N"
	
	When I click on the "Cancel" link
	Then I see "Date of jury service confirmed" in the same row as "Deferral or excusal"
	
	## QC Step 15 Done
	
	When I click on the "CJS employment" link
	Then I see "N/A" in the same row as "CJS employment"
	
	When I click on the "Change" link
	And I choose the "Yes" radio button under "CJS Employment"
	And I see "Organisations" on the page
	And I check the "Police service" checkbox
	And I check the "HM Prison Service" checkbox
	And I check the "the National Crime Agency" checkbox
	And I check the "the Judiciary" checkbox
	And I check the "HMCTS" checkbox
	And I set input field with "id" of "cjsEmployer-other" to "Yes"
	And I click link with ID "cjsEmploymentSaveButton"
	Then I see "Details of police service employmnet" on the page
	And I see "Please give details of where and when the person worked for the police" on the page
	And I see "Details of HM Prison Service employment" on the page
	And I see "Please give details of where and when the person worked for HM Prison Service" on the page
	And I see "Details of other CJS employment" on the page
	And I see "Please give details of where and when the person has worked for another Criminal Justice System employer" on the page
	
	And I set text area with "id" of "cjsPoliceDetails" to "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede mollis pretium. Integer tincidunt. Cras dapibus. Vivamus elementum semper nisi. Aenean vulputate eleifend tellus. Aenean leo ligula, porttitor eu, consequat vitae, eleifend ac, enim. Aliquam lorem ante, dapibus in, viverra quis, feugiat a, tellus. Phasellus viverra nulla ut metus varius laoreet. Quisque rutrum. Aenean imperdiet. Etiam ultricies nisi vel augue. Curabitur ullamcorper ultricies nisi. Nam eget dui. Etiam rhoncus. Maecenas tempus, tellus eget condimentum rhoncus, sem quam semper libero, sit amet adipiscing sem neque sed ipsum. Naaaaaa"
	Then "cjsPoliceDetails" is "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede mollis pretium. Integer tincidunt. Cras dapibus. Vivamus elementum semper nisi. Aenean vulputate eleifend tellus. Aenean leo ligula, porttitor eu, consequat vitae, eleifend ac, enim. Aliquam lorem ante, dapibus in, viverra quis, feugiat a, tellus. Phasellus viverra nulla ut metus varius laoreet. Quisque rutrum. Aenean imperdiet. Etiam ultricies nisi vel augue. Curabitur ullamcorper ultricies nisi. Nam eget dui. Etiam rhoncus. Maecenas tempus, tellus eget condimentum rhoncus, sem quam semper libero, sit amet adipiscing sem neque sed ipsum. N"
	
	And I set text area with "id" of "cjsPrisonDetails" to "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede mollis pretium. Integer tincidunt. Cras dapibus. Vivamus elementum semper nisi. Aenean vulputate eleifend tellus. Aenean leo ligula, porttitor eu, consequat vitae, eleifend ac, enim. Aliquam lorem ante, dapibus in, viverra quis, feugiat a, tellus. Phasellus viverra nulla ut metus varius laoreet. Quisque rutrum. Aenean imperdiet. Etiam ultricies nisi vel augue. Curabitur ullamcorper ultricies nisi. Nam eget dui. Etiam rhoncus. Maecenas tempus, tellus eget condimentum rhoncus, sem quam semper libero, sit amet adipiscing sem neque sed ipsum. Naaaaaa"
	Then "cjsPrisonDetails" is "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede mollis pretium. Integer tincidunt. Cras dapibus. Vivamus elementum semper nisi. Aenean vulputate eleifend tellus. Aenean leo ligula, porttitor eu, consequat vitae, eleifend ac, enim. Aliquam lorem ante, dapibus in, viverra quis, feugiat a, tellus. Phasellus viverra nulla ut metus varius laoreet. Quisque rutrum. Aenean imperdiet. Etiam ultricies nisi vel augue. Curabitur ullamcorper ultricies nisi. Nam eget dui. Etiam rhoncus. Maecenas tempus, tellus eget condimentum rhoncus, sem quam semper libero, sit amet adipiscing sem neque sed ipsum. N"
	
	And I set text area with "id" of "cjsEmployerDetails" to "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede mollis pretium. Integer tincidunt. Cras dapibus. Vivamus elementum semper nisi. Aenean vulputate eleifend tellus. Aenean leo ligula, porttitor eu, consequat vitae, eleifend ac, enim. Aliquam lorem ante, dapibus in, viverra quis, feugiat a, tellus. Phasellus viverra nulla ut metus varius laoreet. Quisque rutrum. Aenean imperdiet. Etiam ultricies nisi vel augue. Curabitur ullamcorper ultricies nisi. Nam eget dui. Etiam rhoncus. Maecenas tempus, tellus eget condimentum rhoncus, sem quam semper libero, sit amet adipiscing sem neque sed ipsum. Naaaaaa"
	Then "cjsEmployerDetails" is "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede mollis pretium. Integer tincidunt. Cras dapibus. Vivamus elementum semper nisi. Aenean vulputate eleifend tellus. Aenean leo ligula, porttitor eu, consequat vitae, eleifend ac, enim. Aliquam lorem ante, dapibus in, viverra quis, feugiat a, tellus. Phasellus viverra nulla ut metus varius laoreet. Quisque rutrum. Aenean imperdiet. Etiam ultricies nisi vel augue. Curabitur ullamcorper ultricies nisi. Nam eget dui. Etiam rhoncus. Maecenas tempus, tellus eget condimentum rhoncus, sem quam semper libero, sit amet adipiscing sem neque sed ipsum. N"
	
	And I click link with ID "cjsEmploymentSaveButton"
	And I set "Please give a reason for the change to this summons reply" to "CJSEmployeeChangeNotes"
	And I click link with ID "changeLogSaveButton"
	Then I see "Police service" in the same row as "CJS employment"
	
	When I click on the "Reasonable adjustments" link
	Then I see text "N/A" in the same row as "Disability or impairment"
	Then I see text "N/A" in the same row as "Special arrangements or help the juror needs"
	
	When I click on the "Change" link
	And I check the "Limited mobility" checkbox
	And I check the "Hearing impairment" checkbox
	And I check the "Diabetes" checkbox
	And I check the "Severe sight impairment" checkbox
	And I check the "Learning disability" checkbox
	And I set input field with "id" of "assistanceType-other" to "Yes"
	And I click link with ID "reasonableAdjustmentsSaveButton"
	Then I see "Please give details of the disability or impairment for the person you're replying for" on the page
	
	When I set "Details of other disability or impairment" to "Lorem ipsum d"
#	When I set "Details of other disability or impairment" to "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede mollis pretium. Integer tincidunt. Cras dapibus. Vivamus elementum semper nisi. Aenean vulputate eleifend tellus. Aenean leo ligula, porttitor eu, consequat vitae, eleifend ac, enim. Aliquam lorem ante, dapibus in, viverra quis, feugiat a, tellus. Phasellus viverra nulla ut metus varius laoreet. Quisque rutrum. Aenean imperdiet. Etiam ultricies nisi vel augue. Curabitur ullamcorper ultricies nisi. Nam eget dui. Etiam rhoncus. Maecenas tempus, tellus eget condimentum rhoncus, sem quam semper libero, sit amet adipiscing sem neque sed ipsum. Naaaaaa"
#	Then "Details of other disability or impairment" is "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede mollis pretium. Integer tincidunt. Cras dapibus. Vivamus elementum semper nisi. Aenean vulputate eleifend tellus. Aenean leo ligula, porttitor eu, consequat vitae, eleifend ac, enim. Aliquam lorem ante, dapibus in, viverra quis, feugiat a, tellus. Phasellus viverra nulla ut metus varius laoreet. Quisque rutrum. Aenean imperdiet. Etiam ultricies nisi vel augue. Curabitur ullamcorper ultricies nisi. Nam eget dui. Etiam rhoncus. Maecenas tempus, tellus eget condimentum rhoncus, sem quam semper libero, sit amet adipiscing sem neque sed ipsum. N"
	
	And I click link with ID "reasonableAdjustmentsSaveButton"
	And I set "Please give a reason for the change to this summons reply" to "resonableAdjustmentsNote"
	And I click link with ID "changeLogSaveButton"
	Then I see "HEARING IMPAIRMENT" on the page
	Then I see "DIABETIC" on the page
	Then I see "LIMITED MOBILITY" on the page
	Then I see "OTHER" on the page
	Then I see "READING" on the page
	Then I see "VISUAL IMPAIRMENT" on the page
	
	Then on "JUROR_MOD" . "JUROR_RESPONSE" I see "PHONE_NUMBER" is "0333333339" where "JUROR_NUMBER" is "<juror_number>"
	Then on "JUROR" . "POOL" I see "H_PHONE" is "" where "PART_NUMBER" is "<juror_number>"
	
	When I select "Mark as responded" from Process reply
	And I check the "Mark juror as 'responded'" checkbox
	And I press the "Confirm" button
	Then I see "COMPLETED" on the page
	Then on "JUROR_MOD" . "JUROR_RESPONSE" I see "PHONE_NUMBER" is "0333333339" where "JUROR_NUMBER" is "<juror_number>"
	Then on "JUROR" . "POOL" I see "H_PHONE" is "0333333339" where "PART_NUMBER" is "<juror_number>"
	
Examples:
	|part_no	|pool_no	|last_name		|postcode	| email |
	|645100999	|451170401	|LNAMETWOSIXZERO|CH1 2AN	|a@a.com|
	
