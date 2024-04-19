Feature: Bureau Process Options

@RegressionSingle
Scenario Outline: Cycle through process options

	Given I am on "Public" "test"
	Given auto straight through processing has been disabled new schema
	Given the juror numbers have not been processed
		|part_no 	|pool_no 	|owner	|
		|<part_no> 	|<pool_no>	|400 	|
	
	Given "<juror_number>" has "RET_DATE" as "5 mondays time"

	
	# Submit response in pool
	
	Given I have submitted a first party English straight through response
		|part_no	|pool_number|last_name		|postcode	|email 	|
		|<part_no>	|<pool_no>	|<last_name>	|<postcode>	|a@a.com|
	
	Given I am on "Bureau" "test"
	And I log in as "MODTESTBUREAU"

	When I click on the "Assign Replies" link
	And I assign all the New Replies to "ARAMIS1"
	
	Given I am on "Bureau" "test"
	And I log in as "ARAMIS1"
	And I click on the "Search" link
	And I set "Juror's pool number" to "<pool_no>"
	And I press the "Search" button
	
	When I click on "<juror_number>" in the same row as "<juror_number>"

	#process options as team member where record assigned to me
	
	And I do not see "Download as a PDF" on the page
	And I do not see "Mark as 'Awaiting information'" on the page
	And I do not see "Send to a colleague..." on the page
	
	Then I press the "More actions" button
	
	And I see link with text "Download as a PDF"
	And I see link with text "Mark as 'Awaiting information'"
	And I see link with text "Send to a colleague..."
	
	Then I click on the "Mark as 'Awaiting information'" link
	And I see "Awaiting juror" on the page
	And I see "Awaiting court reply" on the page
	And I see "Awaiting translation" on the page
	
	Then I click on the "Cancel" link
	
	Then I press the "More actions" button
	Then I click on the "Send to a colleague..." link
	And I see "Select an officer to send to" on the page
	Then I click on the "Cancel" link
	
	Then I do not see "PDF sent to court" on the page
	Then I press the "Process reply" button
	Then I see link with text "Responded"
	Then I see link with text "Deferral"
	Then I see link with text "Excusal"
	Then I see link with text "Disqualified"
	
	Then I click on the "Responded" link
	And I see "Mark juror as 'responded'" on the page
	Then I click on the "Cancel" link
	
	Then I press the "Process reply" button
	Then I click on the "Deferral" link
	And I see "Accept deferral" on the page
	Then I click on the "Cancel" link
	
	Then I press the "Process reply" button
	Then I click on the "Excusal" link
	And I see "Accept excusal request" on the page
	Then I click on the "Cancel" link
	
	Then I press the "Process reply" button
	Then I click on the "Disqualified" link
	And I see "Select why the juror is disqualified" on the page
	Then I click on the "Cancel" link

	#re-enable auto processing
	
	Given auto straight through processing has been enabled new schema

Examples:
	|part_no		|pool_no 	|last_name 			|postcode 	|
	|645200289		|452170401 	|LNAMETWOEIGHTNINE	|SY2 6LU	|
	
@RegressionSingle @NewSchemaConverted
Scenario Outline: Send to court process options

	Given I am on "Public" "test"

	Given auto straight through processing has been disabled new schema

	#super urgent pool owned by court
	Given a bureau owned pool is created with jurors
		| court |juror_number  | pool_number	| att_date_weeks_in_future	| owner |
		| 452   |<juror_number>| <pool_number>	| 1				            | 400	|

	Given a new pool is inserted for where record has transferred to the court new schema
		|part_no             | pool_no           | owner |
		|<juror_number>      | <pool_number>     | 452   |

	And juror "<juror_number>" has "LAST_NAME" as "<last_name>" new schema
	And juror "<juror_number>" has "POSTCODE" as "<postcode>" new schema
	
	# Submit response
	Given I have submitted a first party English straight through response
		|part_no		|pool_number	|last_name		|postcode	|email 	|
		|<juror_number>	|<pool_number>	|<last_name>	|<postcode>	|a@a.com|
	
	Given I am on "Bureau" "test"
	And I log in as "MODTESTBUREAU"

	When I click on the "Assign Replies" link
	And I assign all the New Replies to "ARAMIS1"
	
	Given I am on "Bureau" "test"
	And I log in as "ARAMIS1"
	And I click on the "Search" link
	And I set "Juror's pool number" to "<pool_number>"
	And I press the "Search" button
	
	When I click on "<juror_number>" in the same row as "<juror_number>"

	And I do not see "Download as a PDF" on the page
	Then I press the "More actions" button
	And I see link with text "Download as a PDF"
	Then I press the "More actions" button
	
	Then I do not see "PDF sent to court" on the page
	Then I press the "More actions" button
	Then I click on the "Download as a PDF" link
	And I switch to the new window
	And I see "<juror_number>/download-pdf" in the URL

	#re-enable auto processing
	
	Given auto straight through processing has been enabled new schema

Examples:
	|juror_number	|pool_number|last_name 			|postcode 	|
	|045200230		|452300210 	|LNAMETWOEIGHTNINE	|SY2 6LU	|

@RegressionSingle
Scenario Outline: Urgent process options

	Given I am on "Public" "test"
	Given auto straight through processing has been disabled new schema
	Given the juror numbers have not been processed
		|part_no 	|pool_no 	|owner	|
		|<part_no> 	|<pool_no>	|400 	|
	
	# Set part_no pool to be urgent
	
	Given "<juror_number>" has "RET_DATE" as "2 mondays time"
	And "<juror_number>" has "NEXT_DATE" as "2 mondays time"
	
	# Submit response in pool
	
	Given I have submitted a first party English straight through response
		|part_no	|pool_number|last_name		|postcode	|email 	|
		|<part_no>	|<pool_no>	|<last_name>	|<postcode>	|a@a.com|
		
	Given I am on "Bureau" "test"
	And I log in as "ARAMIS1"
	And I click on the "Search" link
	And I set "Juror's pool number" to "<pool_no>"
	And I press the "Search" button
	
	When I click on "<juror_number>" in the same row as "<juror_number>"

	# cannot assign to anyone as response not allocated to me
	
	And I do not see "Download as a PDF" on the page
	And I do not see "Mark as 'Awaiting information'" on the page
	And I do not see "Send to a colleague..." on the page
	Then I press the "More actions" button
	And I see "Download as a PDF" on the page
	And I see "Mark as 'Awaiting information'" on the page
	And I do not see "Send to a colleague..." on the page

	# allocate to me
	
	Given I am on "Bureau" "test"
	And I log in as "MODTESTBUREAU"
	
	When I click on the "Assign Replies" link
	And I assign all the New Replies to "ARAMIS1"
	
	# now I can allocate to someone else
	
	Given I am on "Bureau" "test"
	And I log in as "ARAMIS1"
	And I click on the "Search" link
	And I set "Juror's pool number" to "<pool_no>"
	And I press the "Search" button
	
	When I click on "<juror_number>" in the same row as "<juror_number>"

	And I do not see "Download as a PDF" on the page
	And I do not see "Mark as 'Awaiting information'" on the page
	And I do not see "Send to a colleague..." on the page
	Then I press the "More actions" button
	And I see "Download as a PDF" on the page
	And I see "Mark as 'Awaiting information'" on the page
	And I see "Send to a colleague..." on the page
	
	Then I press the "More actions" button
	Then I press the "Process reply" button
	Then I see "Responded" on the page
	Then I see "Deferral" on the page
	Then I see "Excusal" on the page
	Then I see "Disqualified" on the page
	Then I click on the "Responded" link
	
	And I check the "Mark juror as 'responded'" checkbox
	And I press the "Confirm" button

	Then I see "COMPLETED" on the page

	#re-enable auto processing
	
	Given auto straight through processing has been enabled new schema

Examples:
	|part_no		|pool_no 	|last_name 			|postcode 	|
	|645200289		|452170401 	|LNAMETWOEIGHTNINE	|SY2 6LU	|

@RegressionSingle
Scenario Outline: Closed process options

	Given I am on "Public" "test"
	Given auto straight through processing has been enabled new schema
	Given the juror numbers have not been processed
		|part_no 	|pool_no 	|owner	|
		|<part_no> 	|<pool_no>	|400 	|
	
	Given "<juror_number>" has "RET_DATE" as "5 mondays time"

	
	# Submit response in pool
	
	Given I have submitted a first party English straight through response
		|part_no	|pool_number|last_name		|postcode	|email 	|
		|<part_no>	|<pool_no>	|<last_name>	|<postcode>	|a@a.com|
	
	Given I am on "Bureau" "test"
	And I log in as "MODTESTBUREAU"

	And I click on the "Search" link
	And I set "Juror's pool number" to "<pool_no>"
	And I press the "Search" button
	
	When I click on "<juror_number>" in the same row as "<juror_number>"

	Then I press the "More actions" button
	And I see link with text "Download as a PDF"
	And I do not see "Mark as 'Awaiting information" on the page
	And I do not see "Send to a colleague..." on the page
	
	Then the "Process reply" button is disabled
	Then I do not see "PDF sent to court" on the page

	Then I see "COMPLETED" on the page

Examples:
	|part_no		|pool_no 	|last_name 			|postcode 	|
	|645200289		|452170401 	|LNAMETWOEIGHTNINE	|SY2 6LU	|