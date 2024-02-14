Feature: Bureau A Test
	
@RegressionSingle
Scenario Outline: Lift from QC Script for Bureau A Functionality
	Given I am on "Public" "test"
	Given auto straight through processing has been disabled
	Given the juror numbers have not been processed
		|part_no 			|pool_no 	|owner	|
		|<part_no> 			|457170501	|400 	|
		|<part_no_two> 		|457170501	|400 	|
		|<part_no_three> 	|457170501	|400 	|
	
	# Set part_no pool to not be urgent
	
	Given "<part_no>" has "RET_DATE" as "5 mondays time"
	And "<part_no>" has "NEXT_DATE" as "5 mondays time"
	And "<part_no>" has "LNAME" as "<last_name>"
	And "<part_no>" has "ZIP" as "<postcode>"
	
	# Submit response in pool
	
	Given I have submitted a first party English straight through response
		|part_no	|pool_number|last_name	|postcode	|email 	|
		|<part_no>	|<pool_no>	|<last_name>|CH1 2AN	|a@a.com|

	# Set part_no pool to be urgent
	
	Given "<part_no_two>" has "RET_DATE" as "3 mondays time"
	And "<part_no_two>" has "NEXT_DATE" as "3 mondays time"
	And "<part_no_two>" has "LNAME" as "<last_name>"
	And "<part_no_two>" has "ZIP" as "<postcode>"
	
	# Submit response in pool
	
	Given I have submitted a first party English straight through response
		|part_no		|pool_number|last_name	|postcode	| email |
		|<part_no_two>	|<pool_no>	|<last_name>|CH1 2AN	|a@a.com|

	# Set part_no pool to be super urgent
	
	Given "<part_no_three>" has "RET_DATE" as "2 mondays time"
	And "<part_no_three>" has "NEXT_DATE" as "2 mondays time"
	And "<part_no_three>" has "LNAME" as "<last_name>"
	And "<part_no_three>" has "ZIP" as "<postcode>"
	
	# Submit response in pool
	
	Given I have submitted a first party English straight through response
		|part_no		|pool_number|last_name		|postcode	|email 	|
		|<part_no_three>|<pool_no>	|<last_name>	|CH1 2AN	|a@a.com|
		
	Given "<part_no_three>" has "READ_ONLY" as "Y"
	Then the "URGENT" for juror "<part_no_three>" is set to "N"
	Then the "SUPER_URGENT" for juror "<part_no_three>" is set to "Y"
	
	Given I am on "Bureau" "bau-test2"
	And I log in	
	And I do not see any links on the page that open to a new page without an alt text
	
	When I click on the "Assign Replies" link
	And I assign all the New Replies to "ARAMIS1"
	And I do not see any links on the page that open to a new page without an alt text
	And I click on the "Sign out" link
	
	Given I am on "Bureau" "test"
	And I log in as "ARAMIS1"
	And I click on the "Search" link
	And I set "Juror's pool number" to "<pool_no>"
	And I press the "Search" button

	Then I see "Urgent" icon in the same row as "<part_no_two>"
	And I see "Send to court" icon in the same row as "<part_no_three>"
	
	When I click on "<part_no>" in the same row as "<part_no>"
	Then I see "Record status" on the page
	Then I press the "More actions" button
	And I click on the "Mark as 'Awaiting information" link
	Then I see "Mark this reply as awaiting information" on the page
	
	#check error message
	
	And I press the "Confirm" button
	And I see "Select who the bureau is waiting for a reply from" on the page
	
	#check cancel
	
	Then I click on the "Cancel" link
	
	#now mark as awaiting info
	
	Then I press the "More actions" button
	And I click on the "Mark as 'Awaiting information" link
	Then I see "Mark this reply as awaiting information" on the page
	When I set the radio button to "Awaiting court reply"
	And I press the "Confirm" button
	
	When I click on the "Back" link
	Then I see "AWAITING COURT REPLY" in the same row as "<part_no>"
	
	And I see "<part_no_two>" on the page
	When I click on "<part_no_two>" in the same row as "<part_no_two>"
	Then I see "Record status" on the page
	Then I press the "More actions" button
	And I click on the "Mark as 'Awaiting information'" link
	Then I see "Mark this reply as awaiting information" on the page
	When I set the radio button to "Awaiting court reply"
	And I press the "Confirm" button
	Then I see "AWAITING COURT REPLY" on the page
	When I click on the "Back" link
	Then I see "AWAITING COURT REPLY" in the same row as "<part_no_two>"
	
	When I click on "<part_no_three>" in the same row as "<part_no_three>"
	
	Then I see "Record status" on the page
	And I do not see "Edit" on the page
	And I do not see "edit" on the page
	When I select "PDF sent to court..." from Process reply
	
	When I check the "PDF sent to court" checkbox
	And I press the "Confirm" button
	And I see "<part_no_three>" on the page
	Then I see "COMPLETED" on the page
	
	Then on "JUROR_DIGITAL" . "JUROR_RESPONSE" I see "PROCESSING_COMPLETE" is "Y" where "JUROR_NUMBER" is "<part_no_three>"
	Then on "JUROR_DIGITAL" . "JUROR_RESPONSE" I see "PROCESSING_STATUS" is "CLOSED" where "JUROR_NUMBER" is "<part_no_three>"
	Then on "JUROR_DIGITAL" . "JUROR_RESPONSE" I see "SUPER_URGENT" is "Y" where "JUROR_NUMBER" is "<part_no_three>"
	
	Then on "JUROR" . "pool" I see "RESPONDED" is "N" where "part_no" is "<part_no_three>" and "OWNER" is "400"

	When I click on the "Back" link
		
	Given the date received for the juror response "<part_no>" is set to 6 working days before the current date
	Given the date received for the juror response "<part_no_two>" is set to 6 working days before the current date
	#Given the date received for the juror response "<part_no_three>" is set to 6 working days before the current date
	
	And I click on the "Sign out" link
	
	Given I am on "Bureau" "test"
	And I see "Username" on the page
	And I log in as "ARAMIS1"
	And I see "Awaiting information" on the page
	And I click on the "Awaiting information" link
	And I do not see any links on the page that open to a new page without an alt text
	And I see "<part_no>" is flagged as overdue
	And I see "<part_no_two>" is flagged as overdue
	
	#Then I see "Overdue" icon in the same row as "<part_no_three>"

	#re-enable auto processing
	
	Given auto straight through processing has been enabled

Examples:
	|part_no		|part_no_two	|part_no_three	|pool_no 	|last_name 			|postcode 	|
	|645700184		|645700878		|645700884		|457170501 	|LNAMEONEFIVEFOUR 	|CH1 2AN	|
	

@RegressionSingle 
Scenario Outline: Bureau A script, steps 24 onwards
	Given I am on "Public" "bau-test"
	Given the juror numbers have not been processed
		| part_no 	| pool_no 	| owner |
		| <part_no> |457170501	| 400 	|
	
	Given "<part_no>" has "RET_DATE" as "5 mondays time"
	And "<part_no>" has "NEXT_DATE" as "5 mondays time"
	And "<part_no>" has "LNAME" as "<last_name>" 
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
	Then I see "Your details" on the page
	
	And I set the radio button to "No"
	And I press the "Continue" button
	
	And I set "First name" to "FIRSTNAMECHANGED"
	And I set "Last name" to "LASTNAMECHANGED"
	And I set "Title" to "TITLEA"
	And I press the "Continue" button
	Then I see "Is this your address?" on the page
	
	And I set the radio button to "No"
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
	And I set the radio button to "No"
	And I set "Provide details" to "residencyTestData"
	And I press the "Continue" button
	
	Then I see "Have you worked in the criminal justice system in the last 5 years?" on the page
	When I set the radio button to "Yes"
	And I check the "Police service" checkbox
	And I set "Which police service" to "policeForceTestData"
	And I press the "Continue" button
	
	Then I see "Are you currently on bail for a criminal offence?" on the page
	When I set the radio button to "Yes"
	And I set "Provide details about your bail and criminal offence" to "bailTestData"
	And I press the "Continue" button
	
	Then I see "Have you been found guilty of a criminal offence?" on the page
	When I set the radio button to "No"
	And I press the "Continue" button
	
	Then I see "Mental Health" on the page
	When I set the radio button to "Yes"
	And I set "Provide details about how you're being detained, looked after or treated under the Mental Health Act" to "mentalHealthTestData"
	And I press the "Continue" button
	
	Then I see "Has it been decided that you 'lack mental capacity'?" on the page
	And I set the radio button to "Yes"
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
	
	And I set the radio button to "Yes"
	And I press the "Continue" button
	
	Then I see "Will you need help" on the page
	When I set the radio button to "Yes"
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
    
	Given I am on "Bureau" "bau-test"
	And I log in
	And I click on the "Search" link
	And I set "Juror number" to "<part_no>"
	And I press the "Search" button
	Then I see "1 results for" on the page
	
	When I click on "<part_no>" in the same row as "<part_no>"
	And I see "<last_name>" on the page
	And I see "FIRSTNAMECHANGED" on the page
	And I see "LASTNAMECHANGED" on the page
	And I see "TITLE" on the page
	And I see "BUILDINGCHANGED" on the page
	And I see "01/01/1990" on the page
	And I see "<email>" on the page
	And I see "INELIGIBLE" on the page
	
	When I click on the "Eligibility" link
	Then I see "Attention" in the same row as "Residency"
	Then I see "residencyTestData" in the same row as "Residency"
	Then I see "Attention" in the same row as "Mental health"
	Then I see "mentalHealthTestData" in the same row as "Mental health"
	Then I see "Attention" in the same row as "Bail"
	Then I see "bailTestData" in the same row as "Bail"
	
	When I click on the "Deferral or excusal" link
	Then I see "Deferral or excusal" in the same row as "Deferral request"
	Then I see "Deferral or excusal" in the same row as "unableToAttendAndDeferring"
	Then I see "Available dates" on the page
	
	When I click on the "CJS employment" link
	Then I see "Police Force" in the same row as "CJS employment"
	And I see "policeForceTestData" in the same row as "CJS employment"
	
	When I click on the "Reasonable adjustments" link
	Then I see "Disability or impairment" on the page
	Then I see "LIMITED MOBILITY" on the page
	Then I see "HEARING IMPAIRMENT" on the page
	Then I see "DIABETIC" on the page
	Then I see "VISUAL IMPAIRMENT" on the page
	Then I see "READING" on the page
	And I see "arrangementsTestData" in the same row as "Special arrangements or help the juror needs"
	
	And I see "TO DO" on the page
	
	Then I press the "More actions" button
	And I click on the "Mark as 'Awaiting information'" link
	And I set the radio button to "Awaiting court reply"
	And I press the "Confirm" button
	Then I see "AWAITING COURT REPLY" on the page
	
	Given I am on "Bureau" "bau-test"
	And I log in
	And I click on the "Search" link
	And I set "Juror number" to "<part_no>"
	And I press the "Search" button
	Then I see "1 results for" on the page
	When I click on "<part_no>" in the same row as "<part_no>"
	
	#JDB-1677
	
	Then I see "Main Phone" on the page
	And I see "Another Phone" on the page
	
	When I select "Responded" from Process reply
	And I check the "Mark juror as 'responded'" checkbox
	And I press the "Confirm" button
	Then I see "COMPLETED" on the page
	And I see "Responded" on the page
	
	## To do
	
	#select * from pool where part_no='<juror number>'
	#JUROR.POOL is updated with a DOB, EMAIL, PHONE
	
	
	#select * from part_hist where part_no='<juror number>'
	#JUROR.PART_HIST is updated with a PDET row
	
	
	#select * from part_amendments where part_no='<juror number>'
	#JUROR.PART_AMENDMENTS is updated with a row indicating DOB change
	
Examples:
	|part_no 	|last_name		|postcode	|email				|
	|645700930	|LNAMEEIGHTFOUR	|CH1 2AN	|email@bureauA.com	|
	