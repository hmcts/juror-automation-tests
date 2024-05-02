Feature: Bureau Functionality - NEW


@RegressionSingle 
Scenario Outline: Your Work 
	Given I am on "Public" "test"
	Given auto straight through processing has been disabled new schema
	Given the juror numbers have not been processed
		|part_no 			|pool_no 	|owner	|
		|<part_no> 			|457170501	|400 	|
		|<part_no_two> 		|457170501	|400 	|
		|<part_no_three> 	|457170501	|400 	|
		|<part_no_four> 	|457170501	|400 	|

	# Using Staff Member CPASS

	# Set part_no pool to not be urgent

	Given "<juror_number>" has "RET_DATE" as "5 mondays time"

	And juror "<juror_number>" has "LAST_NAME" as "<last_name>" new schema
	And juror "<juror_number>" has "POSTCODE" as "<postcode>" new schema

	# Submit response in pool

	Given I have submitted a first party English straight through response
		|part_no	|pool_number|last_name	|postcode	|email 	|
		|<part_no>	|<pool_no>	|<last_name>|CH1 2AN	|a@a.com|

	#update response to have been received 6 days ago

	Given the "DATE_RECEIVED" for juror "<juror_number>" is set to "-2 mondays time"

	# Set part_no pool to be urgent

	Given "<part_no_two>" has "RET_DATE" as "3 mondays time"
	And "<part_no_two>" has "NEXT_DATE" as "3 mondays time"
	And "<part_no_two>" has "LNAME" as "<last_name_two>"
	And "<part_no_two>" has "ZIP" as "<postcode>"

	# Submit response in pool

	Given I have submitted a first party English straight through response
		|part_no		|pool_number|last_name		|postcode	| email |
		|<part_no_two>	|<pool_no>	|<last_name_two>|CH1 2AN	|a@a.com|

	# Set part_no pool to be super urgent

	Given "<part_no_three>" has "RET_DATE" as "2 mondays time"
	And "<part_no_three>" has "NEXT_DATE" as "2 mondays time"
	And "<part_no_three>" has "LNAME" as "<last_name_three>"
	And "<part_no_three>" has "ZIP" as "<postcode>"

	# Submit response in pool

	Given I have submitted a first party English straight through response
		|part_no		|pool_number|last_name			|postcode	|email 	|
		|<part_no_three>|<pool_no>	|<last_name_three>	|CH1 2AN	|a@a.com|

	Given "<part_no_three>" has "READ_ONLY" as "Y"
	Then the "URGENT" for juror "<part_no_three>" is set to "N"
	Then the "SUPER_URGENT" for juror "<part_no_three>" is set to "Y"

	# Submit response in pool

	Given "<part_no_four>" has "RET_DATE" as "5 mondays time"
	And "<part_no_four>" has "NEXT_DATE" as "5 mondays time"
	And "<part_no_four>" has "LNAME" as "<last_name_four>"
	And "<part_no_four>" has "ZIP" as "<postcode>"

	Given I have submitted a first party English straight through response
		|part_no		|pool_number|last_name			|postcode	|email 	|
		|<part_no_four>	|<pool_no>	|<last_name_four>	|CH1 2AN	|a@a.com|

	Given I am on "Bureau" "test"
	And I log in

	When I click on the "Assign Replies" link
	And I assign all the New Replies to "ARAMIS1"
	And I do not see any links on the page that open to a new page without an alt text

	Given I am on "Bureau" "test"
	And I log in as "ARAMIS1"
	And I see "Manage replies to jury summons" on the page
	And I see "Your work" on the page
	And I see link with text "ARAMIS1"
	And I see link with text "Sign out"
	And I see link with text "To do"
	And I see link with text "Awaiting information"
	And I see link with text "Completed"
	And I see link with text "Your work"
	And I see link with text "Search"
	And I see "/inbox" in the URL
	
	Then I see "<juror_number>" on the page
#	And on Bureau I see "<juror_number>" under "High priority"
	And I see "<juror_number>" is flagged as overdue
	And I see "LNAMEONE" in the same row as "<juror_number>"
	And I see "SWANSEA" in the same row as "<juror_number>"
	
	Then I see "<part_no_two>" on the page
	Then I see "URGENT" icon in the same row as "<part_no_two>"
	And I see "LNAMETWO" in the same row as "<part_no_two>"
	And I see "SWANSEA" in the same row as "<part_no_two>"
	
	Then I see "<part_no_three>" on the page
	And I see "SEND TO COURT" icon in the same row as "<part_no_three>"
	And I see "LNAMETHREE" in the same row as "<part_no_three>"
	And I see "SWANSEA" in the same row as "<part_no_three>"
	
	Then I see "<part_no_four>" on the page
	And I see "LNAMEFOUR" in the same row as "<part_no_four>"
	And I see "SWANSEA" in the same row as "<part_no_four>"

	When I click on "<juror_number>" in the same row as "<juror_number>"
	Then I see "Record status" on the page
	And I see "OVERDUE" on the page

	Then I press the "More actions" button
	And I click on the "Mark as awaiting information" link
	And I see "Awaiting juror" on the page
	And I set the radio button to "Awaiting juror"
	
	Then I press the "Confirm" button

	Then I see "AWAITING JUROR" on the page
	
	Then I press the "More actions" button	
	Then I click on the "Mark as awaiting information" link
	When I set the radio button to "Awaiting court reply"
	And I press the "Confirm" button
	Then I see "AWAITING COURT REPLY" on the page
	When I click on the "Your work" link
	Then I do not see "<juror_number>" on the page
	When I click on the "Awaiting information" link
	And I see "/pending" in the URL
	Then I see "<juror_number>" on the page
	Then I see "AWAITING COURT REPLY" in the same row as "<juror_number>"
	And I see "<juror_number>" is flagged as overdue
	
	When I click on the "To do" link
	When I click on "<part_no_two>" in the same row as "<part_no_two>"
	Then I see "Record status" on the page
	And I see "URGENT" on the page
	Then I press the "More actions" button	
	Then I click on the "Mark as awaiting information" link
	And I see "Awaiting court reply" on the page
	When I set the radio button to "Awaiting court reply"
	And I press the "Confirm" button
	Then I see "AWAITING COURT REPLY" on the page
	When I click on the "Your work" link
	Then I do not see "<part_no_two>" on the page
	When I click on the "Awaiting information" link
	And I see "/pending" in the URL
	Then I see "<part_no_two>" on the page
	Then I see "AWAITING COURT REPLY" in the same row as "<part_no_two>"
	Then I see "URGENT" icon in the same row as "<part_no_two>"
	
	When I click on the "Your work" link

	When I click on the "To do" link
	And I see "SEND TO COURT" icon in the same row as "<part_no_three>"
	When I click on "<part_no_three>" in the same row as "<part_no_three>"
	And I see "SEND TO COURT" on the page
	
	When I click on the "Your work" link
	Then I see "<part_no_four>" on the page
	Then I see link with text "<part_no_four>"
	When I click on "<part_no_four>" in the same row as "<part_no_four>"
	Then I see "Record status" on the page
	Then I press the "More actions" button	
	Then I click on the "Mark as awaiting information" link
	Then I see "Who is the bureau waiting for information from?" on the page
	When I set the radio button to "Awaiting court reply"
	And I press the "Confirm" button
	Then I see "AWAITING COURT REPLY" on the page
	When I click on the "Your work" link
	Then I do not see "<part_no_four>" on the page
	When I click on the "Awaiting information" link
	Then I see "<part_no_four>" on the page
	Then I see "AWAITING COURT REPLY" in the same row as "<part_no_four>"

	#send to court

	When I click on the "To do" link
	When I click on "<part_no_three>" in the same row as "<part_no_three>"
	And I do not see "edit" on the page
	When I press the "More actions" button
	When I click on the "Download as a PDF" link

	When I click on the "Your work" link
	Then I see "<part_no_three>" on the page
	When I click on the "Completed" link
	And I see "/completed" in the URL
	Then I do not see "<part_no_three>" on the page
	
	#complete
	
	When I click on the "Awaiting information" link
	When I click on "<juror_number>" in the same row as "<juror_number>"
	When I select "Mark as responded" from Process reply
	And I check the "Mark juror as 'responded'" checkbox
	And I press the "Confirm" button
	Then I see "COMPLETED" on the page
	And I do not see "OVERDUE" on the page
	When I click on the "Your work" link
	And I do not see "<juror_number>" on the page
	When I click on the "Completed" link
	Then I see "<juror_number>" on the page
	
	When I click on the "Awaiting information" link
	When I click on "<part_no_two>" in the same row as "<part_no_two>"
	When I select "Mark as responded" from Process reply
	And I check the "Mark juror as 'responded'" checkbox
	And I press the "Confirm" button
	Then I see "COMPLETED" on the page
	And I do not see "URGENT" on the page
	When I click on the "Your work" link
	When I click on the "Awaiting information" link
	And I do not see "<part_no_two>" on the page
	When I click on the "Completed" link
	Then I see "<part_no_two>" on the page
	
	When I click on the "Awaiting information" link
	When I click on "<part_no_four>" in the same row as "<part_no_four>"
	When I select "Mark as responded" from Process reply
	And I check the "Mark juror as 'responded'" checkbox
	And I press the "Confirm" button
	Then I see "COMPLETED" on the page
	When I click on the "Your work" link
	When I click on the "Awaiting information" link
	And I do not see "<part_no_four>" on the page
	When I click on the "Completed" link
	Then I see "<part_no_four>" on the page

	Given auto straight through processing has been enabled new schema
	
Examples:
	|part_no		|part_no_two	|part_no_three	|part_no_four	|pool_no 	|last_name 	|last_name_two	|last_name_three	|last_name_four	|postcode 	|
	|645700184		|645700878		|645700884		|645700585		|457170501 	|LNAMEONE	|LNAMETWO 		|LNAMETHREE			|LNAMEFOUR		|CH1 2AN	|

@RegressionSingle 
Scenario Outline: Edit Response
	Given I am on "Public" "test"
	Given auto straight through processing has been disabled new schema
	Given the juror numbers have not been processed
		|part_no 			|pool_no 	|owner	|
		|<part_no> 			|457170501	|400 	|
		|<part_no_two> 		|457170501	|400 	|
		|<part_no_three> 	|457170501	|400 	|
	
	# Using Staff Member CPASS
	
	# Set part_no pool to not be urgent
	
	Given "<juror_number>" has "RET_DATE" as "5 mondays time"

	And juror "<juror_number>" has "LAST_NAME" as "<last_name>" new schema
	And juror "<juror_number>" has "POSTCODE" as "<postcode>" new schema
	
	# Submit response in pool
	
	Given I have submitted a first party English straight through response
		|part_no	|pool_number|last_name	|postcode	|email 	|
		|<part_no>	|<pool_no>	|<last_name>|CH1 2AN	|a@a.com|

	# Set part_no pool to be urgent
	
	Given "<part_no_two>" has "RET_DATE" as "3 mondays time"
	And "<part_no_two>" has "NEXT_DATE" as "3 mondays time"
	And "<part_no_two>" has "LNAME" as "<last_name_two>"
	And "<part_no_two>" has "ZIP" as "<postcode>"
	
	# Submit response in pool
	
	Given I have submitted a first party English straight through response
		|part_no		|pool_number|last_name		|postcode	| email |
		|<part_no_two>	|<pool_no>	|<last_name_two>|CH1 2AN	|a@a.com|

	# Set part_no pool to be super urgent
	
	Given "<part_no_three>" has "RET_DATE" as "2 mondays time"
	And "<part_no_three>" has "NEXT_DATE" as "2 mondays time"
	And "<part_no_three>" has "LNAME" as "<last_name_three>"
	And "<part_no_three>" has "ZIP" as "<postcode>"
	
	# Submit response in pool
	
	Given I have submitted a first party English straight through response
		|part_no		|pool_number|last_name			|postcode	|email 	|
		|<part_no_three>|<pool_no>	|<last_name_three>	|CH1 2AN	|a@a.com|
		
	Given "<part_no_three>" has "READ_ONLY" as "Y"
	Then the "URGENT" for juror "<part_no_three>" is set to "N"
	Then the "SUPER_URGENT" for juror "<part_no_three>" is set to "Y"
	
	Given I am on "Bureau" "test"
	And I log in	

	When I click on the "Assign Replies" link
	And I assign all the New Replies to "ARAMIS1"
	And I do not see any links on the page that open to a new page without an alt text

	Given I am on "Bureau" "test"
	And I log in as "ARAMIS1"
	
	And on the page I see
	|text|
	|Your work|
	|To do|
	|<part_no>|
	|<part_no_two>|
	|<part_no_three>|
	
	And I click on the "<juror_number>" link
	
	And on the page I see
	|text|
	|<last_name>|
	|Reply status|
	|Reply type|
	|Juror number|
	|<part_no>|
	|Record status|
	|Summoned|
	|Reply received|
	|Pool number|
	|<pool_no>|
	|Court start date|
	|Court name|
	|SWANSEA|
	|Juror's reply|
	|Logs|
	
	Then I click on the "Back" link
	And I see "Your work" on the page
	
	Given auto straight through processing has been enabled new schema
	
Examples:
	|part_no		|part_no_two	|part_no_three	|pool_no 	|last_name 		|last_name_two	|last_name_three	|postcode 	|
	|645700184		|645700878		|645700884		|457170501 	|LNAMESTANDARD	|LNAMEURGENT 	|LNAMESUPERURGENT	|CH1 2AN	|

@RegressionSingle 
Scenario Outline: Search as Team Member
	Given I am on "Public" "test"
	Given "ARAMIS1" has court 9 set as "457"
	Given auto straight through processing has been disabled new schema
	Given the juror numbers have not been processed
		|part_no 			|pool_no 	|owner	|
		|<part_no> 			|457170501	|400 	|
		|<part_no_two> 		|457170501	|400 	|
		|<part_no_three> 	|457170501	|400 	|
	
	# Using Staff Member CPASS
	
	# Set part_no pool to not be urgent
	
	Given "<juror_number>" has "RET_DATE" as "5 mondays time"

	And juror "<juror_number>" has "LAST_NAME" as "<last_name>" new schema
	And juror "<juror_number>" has "POSTCODE" as "<postcode>" new schema
	
	# Submit response in pool
	
	Given I have submitted a first party English straight through response
		|part_no	|pool_number|last_name	|postcode	|email 	|
		|<part_no>	|<pool_no>	|<last_name>|CH1 2AN	|a@a.com|

	# Set part_no pool to be urgent
	
	Given "<part_no_two>" has "RET_DATE" as "3 mondays time"
	And "<part_no_two>" has "NEXT_DATE" as "3 mondays time"
	And "<part_no_two>" has "LNAME" as "<last_name_two>"
	And "<part_no_two>" has "ZIP" as "<postcode>"
	
	# Submit response in pool
	
	Given I have submitted a first party English straight through response
		|part_no		|pool_number|last_name		|postcode	| email |
		|<part_no_two>	|<pool_no>	|<last_name_two>|CH1 2AN	|a@a.com|

	# Set part_no pool to be super urgent
	
	Given "<part_no_three>" has "RET_DATE" as "2 mondays time"
	And "<part_no_three>" has "NEXT_DATE" as "2 mondays time"
	And "<part_no_three>" has "LNAME" as "<last_name_three>"
	And "<part_no_three>" has "ZIP" as "<postcode>"
	
	# Submit response in pool
	
	Given I have submitted a first party English straight through response
		|part_no		|pool_number|last_name			|postcode	|email 	|
		|<part_no_three>|<pool_no>	|<last_name_three>	|CH1 2AN	|a@a.com|
		
	Given "<part_no_three>" has "READ_ONLY" as "Y"
	Then the "URGENT" for juror "<part_no_three>" is set to "N"
	Then the "SUPER_URGENT" for juror "<part_no_three>" is set to "Y"
	
	Given I am on "Bureau" "test"
	And I log in	

	When I click on the "Assign Replies" link
	And I assign all the New Replies to "ARAMIS1"
	And I do not see any links on the page that open to a new page without an alt text
	
	# Go to New Replies count
	# Set the team members allocation count, set others to 0 and click send

	Given I am on "Bureau" "test"
	And I log in as "ARAMIS1"
	And I see "Manage replies to jury summons" on the page
	And I see "Your work" on the page
	And I see link with text "ARAMIS1"
	And I see link with text "Sign out"
	And I see link with text "To do"
	And I see link with text "Awaiting information"
	And I see link with text "Completed"
	And I see link with text "Your work"
	And I see link with text "Search"
	And I see "/inbox" in the URL
	
	And I click on the "Search" link
	And I see "Search" on the page
	And I see "/search" in the URL
	And I see "Juror number" on the page
	And I see "Juror's last name" on the page
	And I see "Juror's pool number" on the page
	
	And I press the "Search" button
	And I see "Enter a juror number, a juror's last name or a juror's pool number to search" on the page
	
	And I do not see "Filters" on the page
	And I do not see "Alerts" on the page
	And I do not see "Urgent" on the page
	And I do not see "Status" on the page
	And I do not see "To do" on the page
	And I do not see "Awaiting court reply" on the page
	And I do not see "Awaiting juror reply" on the page
	And I do not see "Awaiting translation" on the page
	And I do not see "Completed" on the page
	And I do not see "Officer assigned" on the page
	
	And I press the "Search" button
	Then I see "Enter a juror number, a juror's last name or a juror's pool number to search" on the page
	
	And I click on the "Clear search" link
	Then I do not see "Enter a juror number, a juror's last name or a juror's pool number to search" on the page
	
	And I set "Juror number" to "letters"
	Then "Juror number" is ""
	
	And I set "Juror's last name" to "NORESULTS"
	Then "Juror's last name" is "NORESULTS"
	
	And I set "Juror's pool number" to "letters"
	Then "Juror's pool number" is ""

	#no results
	
	Then I press the "Search" button
	And I see "0 results for " on the page
	And I see "No responses were found that match your search criteria." on the page
	
	#one result - search on name
	
	Then I click on the "Clear search" link
	And I set "Juror's last name" to "<last_name>"
	Then "Juror's last name" is "<last_name>"
	
	Then I press the "Search" button
	And I see "1 results for " on the page
	And I see "<last_name>" in the same row as "<juror_number>"
	
	#three results - search on pool no
	
	Then I click on the "Clear search" link
	Then I do not see "<juror_number>" on the page
	
	And I set "Juror's pool number" to "<pool_no>"
	Then "Juror's pool number" is "<pool_no>"
	
	Then I press the "Search" button
	And I see "results for " on the page
	And I see "<last_name>" in the same row as "<juror_number>"
	And I see "<last_name_two>" in the same row as "<part_no_two>"
	And I see "<last_name_three>" in the same row as "<part_no_three>"
	
	Then I see "Urgent" icon in the same row as "<part_no_two>"
	Then I see "Send to court" icon in the same row as "<part_no_three>"
	
	#search on juror number
	
	Then I click on the "Clear search" link
	And I set "Juror number" to "<juror_number>"
	Then I press the "Search" button
	And I see "results for " on the page
	And I see "<last_name>" in the same row as "<juror_number>"
	And I see "<pool_no>" in the same row as "<juror_number>"
	And I see "ARAMIS1" in the same row as "<juror_number>"
	And I see "TO DO" on the page
	
	Given auto straight through processing has been enabled new schema
	
Examples:
	|part_no		|part_no_two	|part_no_three	|pool_no 	|last_name 		|last_name_two	|last_name_three	|postcode 	|
	|645700184		|645700878		|645700884		|457170501 	|LNAMESTANDARD	|LNAMEURGENT 	|LNAMESUPERURGENT	|CH1 2AN	|

@RegressionSingle 
Scenario Outline: Search as Team Leader
	Given I am on "Public" "test"
	Given auto straight through processing has been disabled new schema
	Given the juror numbers have not been processed
		|part_no 			|pool_no 	|owner	|
		|<part_no> 			|457170501	|400 	|
		|<part_no_two> 		|457170501	|400 	|
		|<part_no_three> 	|457170501	|400 	|
	
	# Set part_no pool to not be urgent
	
	Given "<juror_number>" has "RET_DATE" as "5 mondays time"

	And juror "<juror_number>" has "LAST_NAME" as "<last_name>" new schema
	And juror "<juror_number>" has "POSTCODE" as "<postcode>" new schema
	
	# Submit response in pool
	
	Given I have submitted a first party English straight through response
		|part_no	|pool_number|last_name	|postcode	|email 	|
		|<part_no>	|<pool_no>	|<last_name>|CH1 2AN	|a@a.com|

	# Set part_no pool to be urgent
	
	Given "<part_no_two>" has "RET_DATE" as "3 mondays time"
	And "<part_no_two>" has "NEXT_DATE" as "3 mondays time"
	And "<part_no_two>" has "LNAME" as "<last_name_two>"
	And "<part_no_two>" has "ZIP" as "<postcode>"
	
	# Submit response in pool
	
	Given I have submitted a first party English straight through response
		|part_no		|pool_number|last_name		|postcode	| email |
		|<part_no_two>	|<pool_no>	|<last_name_two>|CH1 2AN	|a@a.com|

	# Set part_no pool to be super urgent
	
	Given "<part_no_three>" has "RET_DATE" as "2 mondays time"
	And "<part_no_three>" has "NEXT_DATE" as "2 mondays time"
	And "<part_no_three>" has "LNAME" as "<last_name_three>"
	And "<part_no_three>" has "ZIP" as "<postcode>"
	
	# Submit response in pool
	
	Given I have submitted a first party English straight through response
		|part_no		|pool_number|last_name			|postcode	|email 	|
		|<part_no_three>|<pool_no>	|<last_name_three>	|CH1 2AN	|a@a.com|
		
	Given "<part_no_three>" has "READ_ONLY" as "Y"
	Then the "URGENT" for juror "<part_no_three>" is set to "N"
	Then the "SUPER_URGENT" for juror "<part_no_three>" is set to "Y"
	
	#assign to CPASS

	Given I am on "Bureau" "test"
	And I log in	

	When I click on the "Assign Replies" link
	And I assign all the New Replies to "ARAMIS1"
	And I do not see any links on the page that open to a new page without an alt text

	And I see "Manage replies to jury summons" on the page
	And I click on the "Your work" link
	And I see link with text "MODTESTBUREAU"
	And I see link with text "Sign out"
	And I see link with text "To do"
	And I see link with text "Awaiting information"
	And I see link with text "Completed"
	And I see link with text "Your work"
	And I see link with text "Search"
	And I see "/inbox" in the URL
	
	And I click on the "Search" link
	And I see "Search" on the page
	And I see "/search" in the URL
	And I see "Juror number" on the page
	And I see "Juror's last name" on the page
	And I see "Juror's pool number" on the page
	And I see "Advanced search" on the page
	
	And I press the "Search" button
	Then I see "Enter a juror number, a juror's last name, a juror's pool number or advanced criteria to search" on the page

	And I do not see "Alerts" on the page
	And I do not see "Urgent" on the page
	And I do not see "Status" on the page
	And I do not see "To do" on the page
	And I do not see "Awaiting court reply" on the page
	And I do not see "Awaiting juror reply" on the page
	And I do not see "Awaiting translation" on the page
	And I do not see "Completed" on the page
	
	And I click on the "Advanced search" link
	And I see "Officer assigned" on the page
	And I see "Alerts" on the page
	And I see "Urgent" on the page
	And I see "Status" on the page
	And I see "To do" on the page
	And I see "Awaiting court reply" on the page
	And I see "Awaiting juror reply" on the page
	And I see "Awaiting translation" on the page
	And I see "Completed" on the page
	
	And I set "Juror number" to "letters"
	Then "Juror number" is ""
	
	And I set "Juror's last name" to "NORESULTS"
	Then "Juror's last name" is "NORESULTS"
	
	And I set "Juror's pool number" to "letters"
	Then "Juror's pool number" is ""

	#no results
	
	Then I press the "Search" button
	And I see "0 results for " on the page
	And I see "No responses were found that match your search criteria." on the page
	
	#one result
	
	Then I click on the "Clear search" link
	Then I do not see "NORESULTS" on the page
	And I set "Juror's last name" to "LNAMESTANDARD"
	Then "Juror's last name" is "LNAMESTANDARD"
	
	Then I press the "Search" button
	And I see "results for " on the page
	And I see "LNAMESTANDARD" in the same row as "<juror_number>"
	
	#name appears if it's just 1
	
	And I press the "Select all" button
	And I press the "Send to..." button
	And I see "Send this reply to a colleague" on the page
	And I see "LNAMESTANDARD" on the page
	And I see "Cancel" on the page
	And I click on the "Cancel" link
		
	#three results
	
	Then I click on the "Clear search" link
	Then I do not see "<juror_number>" on the page
	And I do not see "<last_name>" on the page
	And I set "Juror's pool number" to "457170501"
	Then "Juror's pool number" is "457170501"
	
	Then I press the "Search" button

	And I see "LNAMESTANDARD" in the same row as "<juror_number>"
	And I see "LNAMEURGENT" in the same row as "<part_no_two>"
	And I see "LNAMESUPERURGENT" in the same row as "<part_no_three>"
	
	#names do not appear
	
	And I press the "Select all" button
	And I press the "Send to..." button
	And I see "Send 3 replies to a colleague" on the page
	And I do not see "LNAMESTANDARD" on the page
	And I do not see "LNAMEURGENT" on the page
	And I do not see "LNAMESUPERURGENT" on the page
	And I see "Cancel" on the page
	And I click on the "Cancel" link
	
	#more than 250 results
	
	Then I click on the "Clear search" link
	And I click on the "Advanced search" link
	And I check the "closed" checkbox
	Then I press the "Search" button
	And I see "250 results for " on the page
	And I see "The specified search resulted in more than 250 results. This list only shows the oldest 250." on the page
	
	#search on a specific user
	
	Then I click on the "Clear search" link
	And I click on the "Advanced search" link
	And I select "ARAMIS1" from the "Officer assigned" dropdown
	Then I press the "Search" button
	And I see "results for " on the page
	
	#search on urgent
	
	Then I click on the "Clear search" link
	And I click on the "Advanced search" link
	And I check the "urgentsOnly" checkbox
	And I select "ARAMIS1" from the "Officer assigned" dropdown
	Then I press the "Search" button
	And I do not see "LNAMESTANDARD" on the page
	And I see "LNAMEURGENT" in the same row as "<part_no_two>"
	And I see "LNAMESUPERURGENT" in the same row as "<part_no_three>"
	
	#allocate from search results
	
	And I press the "Select all" button
	And I press the "Unselect all" button
	And I press the "Select all" button
	Then I see "results for" on the page
	And I press the "Send to..." button
	And I see "Cancel" on the page
	And I click on the "Cancel" link
	
	And I click link with ID "deselectAllLink"
	
	And I click link with ID "selectAllLink"
	Then I press the "Send to..." button
	Then I see "Select an officer" on the page
	And I set input field with "id" of "sendToOfficer" to "MODTESTBUREAU"
	And I press the "Send" button
	And I press the "Send" button
	Then I see "Your work" on the page
	And I see "Your work" on the page
	
	#check responses have moved
	
	And I click on the "Search" link
	And I click on the "Advanced search" link
	Then I click on the "Clear search" link
	And I click on the "Advanced search" link
	And I select "ARAMIS1" from the "Officer assigned" dropdown
	Then I press the "Search" button
	And I see "results for " on the page
	Then I press the "Select all" button
	Then I press the "Unselect all" button
	
	And I click on the "Advanced search" link
	Then I see "results for “ARAMIS1”" on the page
	And I select "MODTESTBUREAU" from the "Officer assigned" dropdown
	Then I press the "Search" button
	And I do not see "LNAMESTANDARD" on the page
	And I see "LNAMEURGENT" in the same row as "<part_no_two>"
	And I see "LNAMESUPERURGENT" in the same row as "<part_no_three>"
	
	Given auto straight through processing has been enabled new schema
	
Examples:
	|part_no		|part_no_two	|part_no_three	|pool_no 	|last_name 		|last_name_two	|last_name_three	|postcode 	|
	|645700184		|645700878		|645700884		|457170501 	|LNAMESTANDARD	|LNAMEURGENT 	|LNAMESUPERURGENT	|CH1 2AN	|

@Regression @JDB-3743 
Scenario Outline: Work Allocation Fields and Labels Checks

	Given I am on "Bureau" "test"
#	And pool no "<pool_no>" is reset to pending allocation
	And I have cleared down the juror digital database
	When I log in as "MODTESTBUREAU"
	And I click on the "Assign Replies" link
	
	Then I see "Number of replies in the backlog" on the page
	And I see "How many replies do you want to assign to each officer you select?" on the page
	And I see "Select the officers you want to assign these replies to" on the page
	And I see "Officers and replies they’re currently assigned" on the page
	And I see "Total currently assigned" on the page
	And I see "Assign Replies" on the page
	
	And on Bureau I see "Total" under "Number of replies in the backlog"
	And on Bureau I see "Standard" under "Number of replies in the backlog"
	And on Bureau I see "Urgent" under "Number of replies in the backlog"
	And on Bureau I see "Send to court" under "Number of replies in the backlog"

	Then I see "0" in the same row as "total" in Backlog box

	Then I see "0" in the same row as "urgent" in Backlog box
	Then I see "0" in the same row as "standard" in Backlog box

	And on Bureau I see "Standard" under "How many replies do you want to assign to each officer you select?"
	And on Bureau I see "Urgent" under "How many replies do you want to assign to each officer you select?"
	And on Bureau I see "Send to court" under "How many replies do you want to assign to each officer you select?"

	#AC8, AC9 and AC10
	
	And I set input field with "name" of "allocateNonUrgent" to "abcdefghijklmnopqrstuvwxyz"
	Then I see "" in "allocateNonUrgent" Allocate Replies box
	And I set input field with "name" of "allocateNonUrgent" to "-1"
	Then I see "1" in "allocateNonUrgent" Allocate Replies box
	And I set input field with "name" of "allocateNonUrgent" to "1.1"
	Then I see "11" in "allocateNonUrgent" Allocate Replies box
	And I set input field with "name" of "allocateNonUrgent" to "1234567890"
	Then I see "12345" in "allocateNonUrgent" Allocate Replies box
	And I set input field with "name" of "allocateNonUrgent" to ""
	
	And I set input field with "name" of "allocateUrgent" to "abcdefghijklmnopqrstuvwxyz"
	Then I see "" in "allocateUrgent" Allocate Replies box
	And I set input field with "name" of "allocateUrgent" to "-1"
	Then I see "1" in "allocateUrgent" Allocate Replies box
	And I set input field with "name" of "allocateUrgent" to "1.1"
	Then I see "11" in "allocateUrgent" Allocate Replies box
	And I set input field with "name" of "allocateUrgent" to "1234567890"
	Then I see "12345" in "allocateUrgent" Allocate Replies box
	And I set input field with "name" of "allocateUrgent" to ""
	
	And I set input field with "name" of "allocateSuperUrgent" to "abcdefghijklmnopqrstuvwxyz"
	Then I see "" in "allocateSuperUrgent" Allocate Replies box
	And I set input field with "name" of "allocateSuperUrgent" to "-1"
	Then I see "1" in "allocateSuperUrgent" Allocate Replies box
	And I set input field with "name" of "allocateSuperUrgent" to "1.1"
	Then I see "11" in "allocateSuperUrgent" Allocate Replies box
	And I set input field with "name" of "allocateSuperUrgent" to "1234567890"
	Then I see "12345" in "allocateSuperUrgent" Allocate Replies box
	And I set input field with "name" of "allocateSuperUrgent" to ""
	
	And the "Assign replies" button is disabled
	
	And I check the "Select all" checkbox
	Then "ARAMIS1" is checked
	And "Team Pick List User" is checked
	And "AutomationStaffMemberTWO" is checked
	
	When I uncheck the "Select all" checkbox
	Then "ARAMIS1" is unchecked
	And "Team Pick List User" is unchecked
	And "AutomationStaffMemberTWO" is unchecked

Examples:
	|pool_no 	|
	|442170401 	|

@RegressionSingle
Scenario Outline: Work Allocation

	Given I am on "Bureau" "test"
	And pool no "<pool_no>" is reset to pending allocation
	And I have cleared down the juror digital database
	And the juror numbers have not been processed
		| part_no 			| pool_no 	| owner |
		| <part_no_four> 	|<pool_no>	| 400 	|
		| <part_no_five> 	|<pool_no>	| 400 	|
		| <part_no_six>		|<pool_no>	| 400 	|
	
	#set up some responses
	
	#non-urgent
	
	And "<part_no_four>" has "LNAME" as "<last_name>"
	And "<part_no_four>" has "ZIP" as "<postcode>"
	And "<part_no_four>" has "RET_DATE" as "5 mondays time"
	And "<part_no_four>" has "NEXT_DATE" as "5 mondays time"
	
	#urgent
	
	And "<part_no_five>" has "LNAME" as "<last_name>"
	And "<part_no_five>" has "ZIP" as "<postcode>"
	And "<part_no_five>" has "RET_DATE" as "3 mondays time"
	And "<part_no_five>" has "NEXT_DATE" as "3 mondays time"
	
	#super urgent
	
	And "<part_no_six>" has "LNAME" as "<last_name>" 
	And "<part_no_six>" has "ZIP" as "<postcode>"
	And "<part_no_six>" has "RET_DATE" as "1 mondays time"
	And "<part_no_six>" has "NEXT_DATE" as "1 mondays time"
	And "<part_no_six>" has "READ_ONLY" as "Y"

	Given I am on "Bureau" "test"
	And I log in
	And I click on the "Assign Replies" link
	
	And the "Assign replies" button is disabled
	
	And I set input field with "name" of "allocateNonUrgent" to "12345"
	And I set input field with "name" of "allocateUrgent" to "12345"
	And I set input field with "name" of "allocateSuperUrgent" to "12345"
	
	And the "Assign replies" button is disabled
	
	And I set input field with "name" of "allocateNonUrgent" to ""
	And I set input field with "name" of "allocateUrgent" to ""
	And I set input field with "name" of "allocateSuperUrgent" to ""
	
	And I check the "ARAMIS1" checkbox
	
	And the "Assign replies" button is disabled
	
	#AC13
	
	And I set input field with "name" of "allocateNonUrgent" to "12345"
	And I set input field with "name" of "allocateUrgent" to "12345"
	And I set input field with "name" of "allocateSuperUrgent" to "12345"
	
	And I uncheck the "ARAMIS1" checkbox
	When I press the "Assign replies" button
	And "ARAMIS1-standard" assigned replies count is "0"
	And "ARAMIS1-urgent" assigned replies count is "0"
	And "ARAMIS1-send" assigned replies count is "0"
	And "ARAMIS1-total" assigned replies count is "0"
	
	#submit responses with auto-processing disabled
	
	Given I am on "Public" "test"
	And auto straight through processing has been disabled new schema
	And I have submitted a first party English straight through response
	| part_no			|pool_number| last_name		|postcode	| email |
	|<part_no_four>		|<pool_no>	| <last_name>	|<postcode>	|<email>|
	|<part_no_five>		|<pool_no>	| <last_name>	|<postcode>	|<email>|
	|<part_no_six>		|<pool_no>	| <last_name>	|<postcode>	|<email>|
	
	Given I am on "Bureau" "test"
	When I log in
	And I click on the "Assign Replies" link
	
	#Allocate the non-urgent to CPASS
	
	And I set input field with "name" of "allocateNonUrgent" to "1"
	And the "Assign replies" button is disabled
	And I check the "ARAMIS1" checkbox
	And I press the "Assign replies" button
	And "ARAMIS1-standard" assigned replies count is "1"
	And "ARAMIS1-urgent" assigned replies count is "0"
	And "ARAMIS1-send" assigned replies count is "0"
	And "ARAMIS1-total" assigned replies count is "1"
	
	Then I see "2" in the same row as "total" in Backlog box
	Then I see "0" in the same row as "standard" in Backlog box	

	Then I see "1" in the same row as "urgent" in Backlog box	
		
	And I see "" in "allocateNonUrgent" Allocate Replies box
	And I see "" in "allocateUrgent" Allocate Replies box
	And I see "" in "allocateSuperUrgent" Allocate Replies box
	And the "Assign replies" button is disabled
	Then on "JUROR_MOD" . "JUROR_RESPONSE" I see "STAFF_LOGIN" is "ARAMIS1" where "JUROR_NUMBER" is "<part_no_four>"

	#Allocate the urgent to CPASS
	
	And I set input field with "name" of "allocateUrgent" to "1"
	And the "Assign replies" button is disabled
	When I check the "ARAMIS1" checkbox
	And I press the "Assign replies" button
	And "ARAMIS1-standard" assigned replies count is "1"
	And "ARAMIS1-urgent" assigned replies count is "1"
	And "ARAMIS1-send" assigned replies count is "0"
	And "ARAMIS1-total" assigned replies count is "2"
	
	Then I see "1" in the same row as "total" in Backlog box

	Then I see "0" in the same row as "urgent" in Backlog box
	Then I see "0" in the same row as "standard" in Backlog box

	And I see "" in "allocateNonUrgent" Allocate Replies box
	And I see "" in "allocateUrgent" Allocate Replies box
	And I see "" in "allocateSuperUrgent" Allocate Replies box
	And the "Assign replies" button is disabled
	Then on "JUROR_MOD" . "JUROR_RESPONSE" I see "STAFF_LOGIN" is "ARAMIS1" where "JUROR_NUMBER" is "<part_no_five>"
	
	#Allocate the super-urgent to CPASS
	
	And I set input field with "name" of "allocateSuperUrgent" to "1"
	And the "Assign replies" button is disabled
	When I check the "ARAMIS1" checkbox
	And I press the "Assign replies" button
	And "ARAMIS1-standard" assigned replies count is "1"
	And "ARAMIS1-urgent" assigned replies count is "1"
	And "ARAMIS1-send" assigned replies count is "1"
	And "ARAMIS1-total" assigned replies count is "3"
	Then I see "0" in the same row as "total" in Backlog box

	Then I see "0" in the same row as "urgent" in Backlog box
	Then I see "0" in the same row as "standard" in Backlog box
	And I see "" in "allocateNonUrgent" Allocate Replies box
	And I see "" in "allocateUrgent" Allocate Replies box
	And I see "" in "allocateSuperUrgent" Allocate Replies box
	And the "Assign replies" button is disabled
	Then on "JUROR_MOD" . "JUROR_RESPONSE" I see "STAFF_LOGIN" is "ARAMIS1" where "JUROR_NUMBER" is "<part_no_six>"
	And auto straight through processing has been enabled new schema
	
Examples:
	|part_no_four	|part_no_five	|part_no_six	|pool_no 	|last_name 	|postcode 	|email				|
	|644200456		|644200458		|644200811		|442170401 	|LNAME		|NN1 3HQ	|email@outlook.com	|

@RegressionSingle 
Scenario Outline: Work Allocation - AUTO are not counted

Given I am on "Bureau" "test"
	And pool no "<pool_no>" is reset to pending allocation
	And I have cleared down the juror digital database
	And the juror numbers have not been processed
		| part_no 			| pool_no 	| owner |
		| <part_no_seven> 	|<pool_no>	| 400 	|
	
	#set up some a response
	
	#non-urgent
	
	And "<part_no_seven>" has "LNAME" as "<last_name>"
	And "<part_no_seven>" has "ZIP" as "<postcode>"
	And "<part_no_seven>" has "RET_DATE" as "5 mondays time"
	And "<part_no_seven>" has "NEXT_DATE" as "5 mondays time"
	
	#submit response with auto-processing enabled
	
	Given I am on "Public" "test"
	And auto straight through processing has been enabled new schema
	And I have submitted a first party English straight through response
	| part_no		|pool_number| last_name		|postcode	| email |
	|<part_no_seven>|<pool_no>	| <last_name>	|<postcode>	|<email>|
	
	Then on "JUROR_MOD" . "JUROR_RESPONSE" I see "STAFF_LOGIN" is "AUTO" where "JUROR_NUMBER" is "<part_no_seven>"
	
	Given I am on "Bureau" "test"
	When I log in
	And I click on the "Assign Replies" link
	
	And I do not see "AUTO" on the page
	
	#check counts

	Then I see "0" in the same row as "total" in Backlog box

	Then I see "0" in the same row as "urgent" in Backlog box
	Then I see "0" in the same row as "standard" in Backlog box
	
	And "total-all" assigned replies count is "0" 	
	And "total-standard" assigned replies count is "0" 
	And "total-urgent" assigned replies count is "0"
	And "total-send" assigned replies count is "0"
	
Examples:
	|part_no_seven	|pool_no 	|last_name 	|postcode 	|email				|
	|644200477		|442170401 	|LNAME		|NN1 3HQ	|email@outlook.com	|


@RegressionSingle 
Scenario: Manage Team

	Given I am on "Bureau" "test"
	And I log in
	And staff with name "New Name" does not exist
	And I see "Manage replies to jury summons" on the page
	And I see "Your work" on the page
	And I see link with text "MODTESTBUREAU"
	And I see link with text "Sign out"
	And I see link with text "To do"
	And I see link with text "Awaiting information"
	And I see link with text "Completed"
	And I see link with text "Your work"
	And I see link with text "Search"
	And I see link with text "Assign Replies"
	And I see link with text "Manage team"
	And I see "/inbox" in the URL
	
	And I click on the "Manage team" link
	And I see "/staff" in the URL
	And I see "Manage team" on the page
	And I see "Staff name" on the page
	And I see "Team leader" on the page
	And I see "Status" on the page
	And I see "-" in the same row as "ARAMIS1"
	And I see "Team leader" in the same row as "MODTESTBUREAU"
	Then I see "ACTIVE" in the same row as "ARAMIS1"
	
	# Inactive hidden by default
	
	And I do not see "INACTIVE" on the page
	And I do not see "LEVEL1" on the page
	And the radio button "Show active team members only" is "Selected"
	Then I set the radio button to "Show all team members" 
	Then I see "INACTIVE" in the same row as "AutomationStaffTWO"
	Then I set the radio button to "Show active team members only" 
	And I do not see "INACTIVE" on the page
	And I do not see "AutomationStaffTWO" on the page
	Then I set the radio button to "Show all team members" 
	Then I click on the "Your work" link
	And I click on the "Manage team" link
	And the radio button "Show all team members" is "Selected"
	
	#add team member
	
	Then I press the "Add a new team member" button
	And I see "Add a new team member" on the page
	And I see "/create" in the URL
	
	#error check when fields not completed
	
	Then I press the "Save" button
	And I see "Please provide a name for the new staff member" on the page
	And I see "Please enter the staff member Juror application user name" on the page
	
	#successfully add user
	
	And I set "Name" to "New Name"
	And I set "Username" to "NEWUSER"
	And the radio button "No" is "selected"
	And I choose the "Yes" radio button
	
	Then I press the "Save" button
	And I see "Manage team" on the page
	Then I see "ACTIVE" in the same row as "New Name"
	Then I see "Team leader" in the same row as "New Name"
	
	#set team member to team leader
	
	Then I click on the "New Name" link
	And "Name" is "New Name"
	And "Username" is "NEWUSER"
	And I see "/NEWUSER" in the URL
	And the radio button "No" is "selected"
	Then I choose the "Yes" radio button
	Then I press the "Save" button
	And I see "Manage team" on the page
	Then I see "ACTIVE" in the same row as "New Name"
	Then I see "Team leader" in the same row as "New Name"
	
	#edit user's name
	
	Then I click on the "New Name" link
	And "Name" is "New Name"
	And "Username" is "NEWUSER"
	And I see "/NEWUSER" in the URL
	#fails due to JDB-5504
	And the radio button "Yes" is "selected"
	And the radio button "Active" is "selected"
	Then I set "Name" to "Updated New Name"
	Then I press the "Save" button
	And I see "Manage team" on the page
	Then I see "ACTIVE" in the same row as "Updated New Name"
	
	#set team leader as inactive
	
	Then I click on the "Updated New Name" link
	And "Name" is "Updated New Name"
	And "Username" is "NEWUSER"
	And I see "/NEWUSER" in the URL
	And the radio button "Yes" is "selected"
	And I set the radio button to "Inactive"
	And the radio button "Inactive" is "selected"
	Then I press the "Save" button
	And I see "Manage team" on the page
	Then I see "INACTIVE" in the same row as "Updated New Name"
	
	#attempt to re-activate user who is not known in heritage
	
	Then I click on the "Updated New Name" link
	And "Name" is "Updated New Name"
	And "Username" is "NEWUSER"
	And I see "/NEWUSER" in the URL
	And the radio button "Yes" is "selected"
	And the radio button "Inactive" is "selected"
	Then I set the radio button to "Active"
	Then I press the "Save" button
	And I see "There is a problem" on the page
	And I see "The staff profile you are trying to activate has been made inactive in the Juror application. Please reactivate in Juror and then try again." on the page
	Then I click on the "Cancel" link
	And I see "Manage team" on the page
	
	#attempt to add duplicate
	
	Then I press the "Add a new team member" button
	And I see "Add a new team member" on the page
	And I set "Name" to "New Name"
	And I set "Username" to "NEWUSER"
	And the radio button "Yes" is "selected"
	Then I press the "Save" button
	And I see "There is a problem" on the page
	And I see "This Juror username has already been allocated to Updated New Name" on the page
	
	#attempt to deactivate when user has assigned responses

@RegressionSingle 
Scenario Outline: Results grid updates when status changes are made
	Given I am on "Bureau" "test"
		
	Given the juror numbers have not been processed
		|part_no 			|pool_no 	|owner	|
		|<part_no> 			|<pool_no>	|400 	|

	# Set part_no pool to not be urgent
	
	Given "<juror_number>" has "RET_DATE" as "5 mondays time"

	And juror "<juror_number>" has "LAST_NAME" as "<last_name>" new schema
	And juror "<juror_number>" has "POSTCODE" as "<postcode>" new schema
	
	#turn off auto processing
	
	Given auto straight through processing has been disabled new schema
	
	# Submit response in pool
	
	Given I have submitted a first party English straight through response
		|part_no	|pool_number|last_name	|postcode	|email 	|
		|<part_no>	|<pool_no>	|<last_name>|<postcode>	|a@a.com|
	
	Given I am on "Bureau" "test"
	When I log in
	
	Then I click on the "Search" link
	And I set "Juror's pool number" to "<pool_no>"
	And I press the "Search" button
	
	#record notes
	
	When I click on "<juror_number>" in the same row as "<juror_number>"
	When I click on the "Logs" link
	And I click on the "Notes" link
	And I click on the "Add or Edit" link
	And I set text area with "id" of "notes" to "Some notes here"
	And I press the "Save" button
	
	When I click on the "Back" link
	Then I see "MODTESTBUREAU" in the same row as "<last_name>"
	
	
	#now reassign
	
	And I press the "Select all" button
	And I press the "Send to..." button
	And I set input field with "id" of "sendToOfficer" to "ARAMIS1"
	And I press the "Send" button
	And I press the "Send" button
	
	Then I see "ARAMIS1" in the same row as "<last_name>"
	
	#now mark as awaiting info
	
	When I click on "<juror_number>" in the same row as "<juror_number>"
	Then I see "Record status" on the page
	Then I press the "More actions" button
	And I click on the "Mark as 'Awaiting information" link
	Then I see "Mark this reply as awaiting information" on the page
	When I set the radio button to "Awaiting court reply"
	And I press the "Confirm" button
	
	When I click on the "Back" link
	Then I see "AWAITING COURT REPLY" in the same row as "<juror_number>"
	
	#now mark as responded
	
	When I click on "<juror_number>" in the same row as "<juror_number>"
	Then I see "Record status" on the page
	When I select "Mark as responded" from Process reply
	And I check the "Mark juror as 'responded'" checkbox
	And I press the "Confirm" button
	Then I see "COMPLETED" on the page
	And I see "Responded" on the page
	
	When I click on the "Back" link
	Then I see "COMPLETED" in the same row as "<juror_number>"
	
	
Examples:
	|part_no	|pool_no 	|last_name 	|postcode 	|email				|
	|644200477	|442170401 	|LNAMEUPDATE|NN1 3HQ	|email@outlook.com	|