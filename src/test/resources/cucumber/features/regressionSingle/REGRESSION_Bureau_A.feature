Feature: Bureau A Test
	
@RegressionSingle @NewSchemaConverted
Scenario Outline: Lift from QC Script for Bureau A Functionality

	Given I am on "Public" "test"

	Given a bureau owned pool is created with jurors
		| court | juror_number  		| pool_number		| att_date_weeks_in_future	| owner |
		| 452   | <juror_number_one>	| <pool_number_one>	| 5				            | 400	|

	Given a bureau owned pool is created with jurors
		| court | juror_number  		| pool_number		| att_date_weeks_in_future	| owner |
		| 452   | <juror_number_two>	| <pool_number_two>	| 3				            | 400	|

	Given a bureau owned pool is created with jurors
		| court | juror_number  		| pool_number			| att_date_weeks_in_future	| owner |
		| 452   | <juror_number_three>	| <pool_number_three>	| 2				            | 400	|

	And juror "<juror_number_one>" has "LAST_NAME" as "<last_name>" new schema
	And juror "<juror_number_one>" has "POSTCODE" as "<postcode>" new schema
	And juror "<juror_number_two>" has "LAST_NAME" as "<last_name>" new schema
	And juror "<juror_number_two>" has "POSTCODE" as "<postcode>" new schema
	And juror "<juror_number_three>" has "LAST_NAME" as "<last_name>" new schema
	And juror "<juror_number_three>" has "POSTCODE" as "<postcode>" new schema

	Given auto straight through processing has been disabled new schema

	# Submit response in pool
	Given I have submitted a first party English straight through response
		|part_no			|pool_number		|last_name	|postcode	|email 	|
		|<juror_number_one>	|<pool_number_one>	|<last_name>|CH1 2AN	|a@a.com|

	# Submit response in pool
	Given I have submitted a first party English straight through response
		|part_no			|pool_number		|last_name	|postcode	| email |
		|<juror_number_two>	|<pool_number_two>	|<last_name>|CH1 2AN	|a@a.com|

	# Submit response in pool
	Given I have submitted a first party English straight through response
		|part_no				|pool_number			|last_name		|postcode	|email 	|
		|<juror_number_three>	|<pool_number_three>	|<last_name>	|CH1 2AN	|a@a.com|

	#re-enable auto processing
	Given auto straight through processing has been enabled new schema

	Given I am on "Bureau" "test"
	And I log in as "MODTESTBUREAU"
	And I do not see any links on the page that open to a new page without an alt text

	When I click on the "Assign Replies" link
	And I assign all the New Replies to "ARAMIS1"
	And I do not see any links on the page that open to a new page without an alt text
	And I click on the "Sign out" link

	Given I am on "Bureau" "test"
	And I log in as "ARAMIS1"
	And I click on the "Search" link
	And I set "Juror's pool number" to "<pool_number_three>"
	And I press the "Search" button

	When I click on "<juror_number_three>" in the same row as "<juror_number_three>"
	And I see "URGENT" on the page

	And I click on the "Search" link
	And I set "Juror's pool number" to "<pool_number_two>"
	And I press the "Search" button

	When I click on "<juror_number_two>" in the same row as "<juror_number_two>"
	And I see "URGENT" on the page

	And I click on the "Search" link
	And I set "Juror's pool number" to "<pool_number_one>"
	And I press the "Search" button

	When I click on "<juror_number_one>" in the same row as "<juror_number_one>"
	Then I see "Reply status" on the page
	Then I press the "More actions" button
	And I click on the "Mark as awaiting information" link
	Then I see "Mark this reply as awaiting information" on the page
	
	#check error message
	And I press the "Confirm" button
	And I see "Select whether you’re waiting for information from either the juror, court or translation unit" on the page
	
	#check cancel
	Then I click on the "Cancel" link
	
	#now mark as awaiting info
	Then I press the "More actions" button
	And I click on the "Mark as awaiting information" link
	Then I see "Mark this reply as awaiting information" on the page
	When I choose the "Court" radio button
	And I press the "Confirm" button

	And I click on the "Your work" link
	When I click on the "Awaiting information" link
	Then I see "Awaiting court reply" in the same row as "<juror_number_one>"

	And I click on the "Search" link
	And I set "Juror's pool number" to "<pool_number_two>"
	And I press the "Search" button

	And I see "<juror_number_two>" on the page
	When I click on "<juror_number_two>" in the same row as "<juror_number_two>"
	Then I see "Reply status" on the page
	Then I press the "More actions" button
	And I click on the "Mark as awaiting information" link
	Then I see "Mark this reply as awaiting information" on the page
	When I choose the "Court" radio button
	And I press the "Confirm" button
	Then I see "Awaiting court reply" on the page
	And I click on the "Your work" link
	When I click on the "Awaiting information" link
	Then I see "Awaiting court reply" in the same row as "<juror_number_two>"

	And I click on the "Search" link
	And I set "Juror's pool number" to "<pool_number_three>"
	And I press the "Search" button

	When I click on "<juror_number_three>" in the same row as "<juror_number_three>"
	
	Then I see "Reply status" on the page
	And I do not see "Edit" on the page
	And I do not see "edit" on the page
	And I press the "More actions" button
	When I click on the "Download as a PDF" link

	And I see "<juror_number_three>" on the page
	Then I do not see "Completed" on the page

	When I click on the "Back" link
		
	Given the date received for the juror response "<juror_number_one>" is set to 6 working days before the current date
	Given the date received for the juror response "<juror_number_two>" is set to 6 working days before the current date
	
	And I click on the "Sign out" link
	
	Given I am on "Bureau" "test"

	And I log in as "ARAMIS1"
	And I see "Awaiting information" on the page
	And I click on the "Awaiting information" link
	And I do not see any links on the page that open to a new page without an alt text
	And I do not see "OVERDUE" on the page

Examples:
	| juror_number_one	| juror_number_two	| juror_number_three	| pool_number_one 	| pool_number_two	| pool_number_three	| last_name 		| postcode 	|
	| 045200238			| 045200239			| 045200240				| 452300217 		| 452300218			| 452300219	        | LNAMEONEFIVEFOUR 	| CH1 2AN	|
	

@RegressionSingle @NewSchemaConverted
Scenario Outline: Bureau A script, steps 24 onwards

	Given I am on "Public" "test"

	Given a bureau owned pool is created with jurors
		| court | juror_number  	| pool_number	| att_date_weeks_in_future	| owner |
		| 452   | <juror_number>	| <pool_number>	| 5				            | 400	|

	And juror "<juror_number>" has "LAST_NAME" as "<last_name>" new schema
	And juror "<juror_number>" has "POSTCODE" as "<postcode>" new schema

	Then I see "Reply to a jury summons" on the page
	And I set the radio button to "I am replying for myself"
	And I press the "Continue" button
	Then I see "Your juror details" on the page

	When I set "9-digit juror number" to "<juror_number>"
	When I set "Juror last name" to "<last_name>"
	When I set "Juror postcode" to "<postcode>"
	And I press the "Continue" button
	Then I see "Your details" on the page

	And I choose the "No" radio button
	And I press the "Continue" button

	And I set "First name" to "FIRSTNAMECHANGED"
	And I set "Last name" to "LASTNAMECHANGED"
	And I set "Title" to "TITLEA"
	And I press the "Continue" button
	Then I see "Is this your address?" on the page

	And I choose the "No" radio button
	And I press the "Continue" button

	And I set "Address line 1" to "BUILDINGCHANGED"
	And I press the "Continue" button

	Then I see "What is your phone number?" on the page
	When I set "Main phone" to "01211112222"
	And I press the "Continue" button

	And I set "Enter your email address" to "<email>"
	And I set "Enter your email address again" to "<email>"
	And I press the "Continue" button
	Then I see "What is your date of birth?" on the page

	When I set "Day" to "01"
	And I set "Month" to "01"
	And I set "Year" to "1990"
	And I press the "Continue" button
	Then I see "Confirm you're eligible for jury service" on the page

	When I press the "Continue" button
	And I choose the "No" radio button
	And I set "Provide details" to "residencyTestData"
	And I press the "Continue" button

	Then I see "Have you worked in the criminal justice system in the last 5 years?" on the page
	When I choose the "Yes" radio button
	And I check the "Police service" checkbox
	And I set "Which police service" to "policeForceTestData"
	And I press the "Continue" button

	Then I see "Are you currently on bail for a criminal offence?" on the page
	When I choose the "Yes" radio button
	And I set "Provide details about your bail and criminal offence" to "bailTestData"
	And I press the "Continue" button

	Then I see "Have you been found guilty of a criminal offence?" on the page
	When I choose the "No" radio button
	And I press the "Continue" button

	Then I see "Mental Health" on the page
	When I choose the "Yes" radio button
	And I set "Provide details about how you're being detained, looked after or treated under the Mental Health Act" to "mentalHealthTestData"
	And I press the "Continue" button

	Then I see "Has it been decided that you 'lack mental capacity'?" on the page
	And I choose the "Yes" radio button
	And I set "Provide brief details about why it was decided you lack mental capacity" to "mentalHealthCapacityTestData"
	And I press the "Continue" button

	And I see "No, I need to change the date" on the page
	And I set the radio button to "No, I need to change the date"
	And I press the "Continue" button
	And I set text area with "id" of "deferralReason" to "unableToAttendAndDeferring"
	And I press the "Continue" button
	Then I see "Choose 3 Mondays" on the page

	When I set the "First" single date field to a Monday "6" weeks in the future
	When I set the "Second" single date field to a Monday "7" weeks in the future
	When I set the "Third" single date field to a Monday "8" weeks in the future

	And I press the "Continue" button

	And I choose the "Yes" radio button
	And I press the "Continue" button

	Then I see "Will you need help" on the page
	When I choose the "Yes" radio button
	And I check the "Limited mobility" checkbox
	And I check the "Hearing impairment" checkbox
	And I check the "Diabetes" checkbox
	And I check the "Severe sight impairment" checkbox
	And I check the "Learning disability" checkbox
	And I set "Tell us about any special arrangements or help yo" to "arrangementsTestData"
	And I press the "Continue" button

	And I check the "The information" checkbox
	And I press the "Submit" button
	Then I see "You have completed your reply" on the page

	Given I am on "Bureau" "test"
	And I log in as "MODTESTBUREAU"
	And I click on the "Search" link
	And I set "Juror number" to "<juror_number>"
	And I press the "Search" button
	Then I see "1 results for" on the page
	
	When I click on "<juror_number>" in the same row as "<juror_number>"
	And I see "<last_name>" on the page
	And I see "FIRSTNAMECHANGED" on the page
	And I see "LASTNAMECHANGED" on the page
	And I see "TITLE" on the page
	And I see "BUILDINGCHANGED" on the page
	And I see "01 Jan 1990" on the page
	And I see "<email>" on the page
	And I see "Ineligible" on the page
	
	When I click on the "Eligibility" link
	Then "Residency" is marked as requiring attention
	Then I see "residencyTestData" on the page
	Then "Mental health act" is marked as requiring attention
	Then I see "mentalHealthTestData" on the page
	Then "Bail" is marked as requiring attention
	Then I see "bailTestData" on the page
	
	When I click on the "Deferral or excusal" link
	Then I see "unableToAttendAndDeferring" on the page
	Then I see "Available dates" on the page
	
	When I click on the "CJS employment" link
	Then I see "Police Force" on the page
	And I see "policeForceTestData" on the page
	
	When I click on the "Reasonable adjustments" link
	Then I see "Reason and adjustments needed" on the page
	Then I see "LIMITED MOBILITY" on the page
	Then I see "HEARING LOSS" on the page
	Then I see "DIABETIC" on the page
	Then I see "VISUAL IMPAIRMENT" on the page
	Then I see "READING" on the page
	And I see "arrangementsTestData" on the page
	
	And I see "TO DO" on the page
	
	Then I press the "More actions" button
	And I click on the "Mark as awaiting information" link
	And I choose the "Court" radio button
	And I press the "Confirm" button
	Then I see "Awaiting court reply" on the page
	
	Given I am on "Bureau" "test"
	And I log in as "MODTESTBUREAU"
	And I click on the "Search" link
	And I set "Juror number" to "<juror_number>"
	And I press the "Search" button
	Then I see "1 results for" on the page
	When I click on "<juror_number>" in the same row as "<juror_number>"
	
	Then I see "Main Phone" on the page
	And I see "Alternative phone" on the page
	
	When I select "Mark as responded" from Process reply
	And I check the "Mark juror as 'responded'" checkbox
	And I press the "Confirm" button
	And I see the juror record updated banner containing "Responded"
	
Examples:
	| juror_number 	| pool_number	| last_name		| postcode	| email				|
	| 045200241		| 452300220		|LNAMEEIGHTFOUR	| CH1 2AN	| email@bureauA.com	|
	