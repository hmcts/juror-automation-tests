Feature: Bureau Functionality - NEW


@RegressionSingle @NewSchemaConverted
Scenario Outline: Your Work

	Given I am on "Public" "test"

	Given a bureau owned pool is created with jurors
		| court | juror_number  		| pool_number		| att_date_weeks_in_future	| owner |
		| 452   | <juror_number_one>	| <pool_number_one>	| 5				            | 400	|
		| 452   | <juror_number_four>	| <pool_number_one>	| 5				            | 400	|

	Given a bureau owned pool is created with jurors
		| court | juror_number  		| pool_number		| att_date_weeks_in_future	| owner |
		| 452   | <juror_number_two>	| <pool_number_two>	| 3				            | 400	|

	Given a bureau owned pool is created with jurors
		| court | juror_number  		| pool_number			| att_date_weeks_in_future	| owner |
		| 452   | <juror_number_three>	| <pool_number_three>	| 2				            | 400	|

	Given a new pool is inserted for where record has transferred to the court new schema
		| part_no             	| pool_no           	| owner |
		| <juror_number_three>	| <pool_number_three>   | 452   |

	And juror "<juror_number_one>" has "LAST_NAME" as "<last_name_one>" new schema
	And juror "<juror_number_one>" has "POSTCODE" as "<postcode>" new schema
	And juror "<juror_number_two>" has "LAST_NAME" as "<last_name_two>" new schema
	And juror "<juror_number_two>" has "POSTCODE" as "<postcode>" new schema
	And juror "<juror_number_three>" has "LAST_NAME" as "<last_name_three>" new schema
	And juror "<juror_number_three>" has "POSTCODE" as "<postcode>" new schema
	And juror "<juror_number_four>" has "LAST_NAME" as "<last_name_four>" new schema
	And juror "<juror_number_four>" has "POSTCODE" as "<postcode>" new schema

	Given auto straight through processing has been disabled new schema

	# Submit response in pool
	Given I have submitted a first party English straight through response
		| part_no				| pool_number		| last_name			| postcode	| email 	|
		| <juror_number_one>	| <pool_number_one>	| <last_name_one>	| CH1 2AN	| a@a.com	|

	#update response to have been received 6 days ago
	Given the "DATE_RECEIVED" for juror "<juror_number_one>" is set to "-2 mondays time" new schema

	Given I am on "Public" "test"

	# Submit response in pool
	Given I have submitted a first party English straight through response
		| part_no				| pool_number		| last_name			| postcode	| email 	|
		| <juror_number_two>	| <pool_number_two>	| <last_name_two>	| CH1 2AN	| a@a.com	|

	Given I am on "Public" "test"

	# Submit response in pool
	Given I have submitted a first party English straight through response
		| part_no				| pool_number			| last_name			| postcode	| email 	|
		| <juror_number_three>	| <pool_number_three>	| <last_name_three>	| CH1 2AN	| a@a.com	|

	Given I am on "Public" "test"

	Given I have submitted a first party English straight through response
		| part_no				| pool_number		| last_name			| postcode	| email 	|
		| <juror_number_four>	| <pool_number_one>	| <last_name_four>	| CH1 2AN	| a@a.com	|

	Given auto straight through processing has been enabled new schema

	Given I am on "Bureau" "test"
	And I log in as "CPASS"

	When I click on the "Assign Replies" link
	And I assign all the New Replies to "ARAMIS1"
	And I do not see any links on the page that open to a new page without an alt text

	Given I am on "Bureau" "test"
	And I log in as "ARAMIS1"
	And I see "Summons replies" on the page
	And I see "Your work" on the page
	And I see link with text "Sign out"
	And I see link with text "To do"
	And I see link with text "Awaiting information"
	And I see link with text "Completed"
	And I see link with text "Your work"
	And I see link with text "Search"
	And I see "/inbox" in the URL

	Then I see "<juror_number_one>" on the page
	And I do not see "OVERDUE" on the page
	And I see "LNAMEONE" in the same row as "<juror_number_one>"
	And I see "SHREWSBURY" in the same row as "<juror_number_one>"

	Then I see "<juror_number_two>" on the page
	Then I see "URGENT" icon in the same row as "<juror_number_two>"
	And I see "LNAMETWO" in the same row as "<juror_number_two>"
	And I see "SHREWSBURY" in the same row as "<juror_number_two>"

	#this will only be seen by the court now
	Then I do not see "<juror_number_three>" on the page

	Then I see "<juror_number_four>" on the page
	And I see "LNAMEFOUR" in the same row as "<juror_number_four>"
	And I see "SHREWSBURY" in the same row as "<juror_number_four>"

	When I click on "<juror_number_one>" in the same row as "<juror_number_one>"
	Then I see "Reply status" on the page
	And I do not see "OVERDUE" on the page

	Then I press the "More actions" button
	And I click on the "Mark as awaiting information" link
	And I see "Juror" on the page
	And I choose the "Juror" radio button

	Then I press the "Confirm" button

	Then I see "AWAITING JUROR" on the page

	Then I press the "More actions" button
	Then I click on the "Mark as awaiting information" link
	When I choose the "Court" radio button
	And I press the "Confirm" button
	Then I see "AWAITING COURT REPLY" on the page
	When I click on the "Your work" link
	Then I do not see "<juror_number_one>" on the page
	When I click on the "Awaiting information" link
	And I see "/pending" in the URL
	Then I see "<juror_number_one>" on the page
	Then I see "AWAITING COURT REPLY" in the same row as "<juror_number_one>"
	And I do not see "OVERDUE" on the page

	When I click on the "To do" link
	When I click on "<juror_number_two>" in the same row as "<juror_number_two>"
	Then I see "Reply status" on the page
	And I see "URGENT" on the page
	Then I press the "More actions" button
	Then I click on the "Mark as awaiting information" link
	When I choose the "Court" radio button
	And I press the "Confirm" button
	Then I see "AWAITING COURT REPLY" on the page
	When I click on the "Your work" link
	Then I do not see "<juror_number_two>" on the page
	When I click on the "Awaiting information" link
	And I see "/pending" in the URL
	Then I see "<juror_number_two>" on the page
	Then I see "AWAITING COURT REPLY" in the same row as "<juror_number_two>"
	Then I see "URGENT" icon in the same row as "<juror_number_two>"

	When I click on the "Your work" link

	When I click on the "To do" link

	#this will only be seen by the court now
	And I do not see "<juror_number_three>" on the page

	When I click on the "Your work" link
	Then I see "<juror_number_four>" on the page
	Then I see link with text "<juror_number_four>"
	When I click on "<juror_number_four>" in the same row as "<juror_number_four>"
	Then I see "Reply status" on the page
	Then I press the "More actions" button
	Then I click on the "Mark as awaiting information" link
	When I check the "Court" checkbox
	And I press the "Confirm" button
	Then I see "AWAITING COURT REPLY" on the page
	When I click on the "Your work" link
	Then I do not see "<juror_number_four>" on the page
	When I click on the "Awaiting information" link
	Then I see "<juror_number_four>" on the page
	Then I see "AWAITING COURT REPLY" in the same row as "<juror_number_four>"

	#complete
	When I click on the "Awaiting information" link
	When I click on "<juror_number_one>" in the same row as "<juror_number_one>"
	And I select Process reply
	And I choose the "Mark as responded" radio button
	And I press the "Continue" button
	And I check the "Mark juror as 'responded'" checkbox
	And I press the "Confirm" button
	Then I see the juror record updated banner containing "Responded"
	And I do not see "OVERDUE" on the page
	When I click on the "Your work" link
	And I see the juror record updated banner containing "Responded"
	When I click on the "Completed" link
	Then I see "<juror_number_one>" on the page

	When I click on the "Awaiting information" link
	When I click on "<juror_number_two>" in the same row as "<juror_number_two>"
	When I select "Mark as responded" from Process reply
	And I check the "Mark juror as 'responded'" checkbox
	And I press the "Confirm" button
	And I see the juror record updated banner containing "Responded"
	When I click on the "Your work" link
	When I click on the "Awaiting information" link
	And I do not see "<juror_number_two>" on the page
	When I click on the "Completed" link
	Then I see "<juror_number_two>" on the page

	When I click on the "Awaiting information" link
	When I click on "<juror_number_four>" in the same row as "<juror_number_four>"
	When I select "Mark as responded" from Process reply
	And I check the "Mark juror as 'responded'" checkbox
	And I press the "Confirm" button
	And I see the juror record updated banner containing "Responded"
	When I click on the "Your work" link
	When I click on the "Awaiting information" link
	And I do not see "<juror_number_four>" on the page
	When I click on the "Completed" link
	Then I see "<juror_number_four>" on the page

	Given I am on "Bureau" "test"
	And I log in as "SHREWSBURY"

	#this will only be seen by the court now
	And I search for juror "<juror_number_three>"
	And I click on the "Summons reply" link
	And I click on the "View summons reply" link
	And I see "URGENT" on the page
	And I select Process reply
	And I choose the "Mark as responded" radio button
	And I press the "Continue" button
	And I check the "Mark juror as 'responded'" checkbox
	And I press the "Confirm" button

	And I search for juror "<juror_number_three>"
	Then I see the juror status has updated to "Responded"
	And I click on the "Summons reply" link
	Then I see "COMPLETED" on the page

Examples:
	| juror_number_one	| juror_number_two	| juror_number_three	| juror_number_four	| pool_number_one 	| pool_number_two | pool_number_three | last_name_one 	| last_name_two	| last_name_three	| last_name_four| postcode 	|
	| 045200234			| 045200235			| 045200236				| 045200237			| 452300214 		| 452300215	      | 452300216         | LNAMEONE		| LNAMETWO 		| LNAMETHREE		| LNAMEFOUR		| CH1 2AN	|

@RegressionSingle @NewSchemaConverted
Scenario Outline: Edit Response

	Given I am on "Public" "test"

	Given auto straight through processing has been disabled new schema

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

	And juror "<juror_number_two>" has "LAST_NAME" as "<last_name_two>" new schema
	And juror "<juror_number_two>" has "POSTCODE" as "<postcode>" new schema

	And juror "<juror_number_three>" has "LAST_NAME" as "<last_name_three>" new schema
	And juror "<juror_number_three>" has "POSTCODE" as "<postcode>" new schema
	
	# Submit response in pool
	Given I have submitted a first party English straight through response
		| part_no			| pool_number		| last_name		| postcode	| email 	|
		| <juror_number_one>| <pool_number_one>	| <last_name>	| CH1 2AN	| a@a.com	|

	Given I have submitted a first party English straight through response
		| part_no				| pool_number		| last_name			| postcode	| email |
		| <juror_number_two>	| <pool_number_two>	| <last_name_two>	| CH1 2AN	| a@a.com|

	Given I have submitted a first party English straight through response
		| part_no				| pool_number			| last_name			| postcode	| email 	|
		| <juror_number_three>	| <pool_number_three>	| <last_name_three>	| CH1 2AN	| a@a.com	|
	
	Given I am on "Bureau" "test"
	And I log in as "MODTESTBUREAU"

	When I click on the "Assign Replies" link
	And I assign all the New Replies to "ARAMIS1"
	And I do not see any links on the page that open to a new page without an alt text

	Given I am on "Bureau" "test"
	And I log in as "ARAMIS1"
	
	And on the page I see
	|text|
	|Your work|
	|To do|
	|<juror_number_one>|
	|<juror_number_two>|
	|<juror_number_three>|
	
	And I click on the "<juror_number_one>" link
	
	And on the page I see
	|text|
	|<last_name>|
	|Reply status|
	|Reply type|
	|Juror number|
	|<juror_number_one>|
	|Juror status|
	|Summoned|
	|Reply received|
	|Pool number|
	|<pool_number_one>|
	|Service start date|
	|Court name|
	|Shrewsbury|
	|Juror's reply|
	|Notes and logs|
	
	Then I click on the "Back" link
	And I see "Your work" on the page
	
	Given auto straight through processing has been enabled new schema
	
Examples:
	| juror_number_one	| juror_number_two	| juror_number_three	| pool_number_one 	| pool_number_two | pool_number_three 	| last_name 	| last_name_two	| last_name_three	| postcode 	|
	| 045200245			| 045200246			| 045200247				| 452300222 		| 452300223 	  | 452300224           | LNAMESTANDARD	| LNAMEURGENT 	| LNAMESUPERURGENT	| CH1 2AN	|

@RegressionSingle @NewSchemaConverted
Scenario Outline: Search as Team Member

	Given I am on "Public" "test"

	Given "ARAMIS1" has court 9 set as "457"

	Given a bureau owned pool is created with jurors
		| court | juror_number  		| pool_number		| att_date_weeks_in_future	| owner |
		| 457   | <juror_number_one>	| <pool_number_one>	| 5			            	| 400	|

	Given a bureau owned pool is created with jurors
		| court | juror_number  		| pool_number		| att_date_weeks_in_future	| owner |
		| 457   | <juror_number_two>	| <pool_number_two>	| 3			            	| 400	|

	Given a bureau owned pool is created with jurors
		| court | juror_number  		| pool_number			| att_date_weeks_in_future	| owner |
		| 457   | <juror_number_three>	| <pool_number_three>	| 2			            	| 400	|

	And juror "<juror_number_one>" has "LAST_NAME" as "<last_name>" new schema
	And juror "<juror_number_one>" has "POSTCODE" as "<postcode>" new schema
	And juror "<juror_number_two>" has "LAST_NAME" as "<last_name_two>" new schema
	And juror "<juror_number_two>" has "POSTCODE" as "<postcode>" new schema
	And juror "<juror_number_three>" has "LAST_NAME" as "<last_name_three>" new schema
	And juror "<juror_number_three>" has "POSTCODE" as "<postcode>" new schema

	Given auto straight through processing has been disabled new schema

	# Submit response in pool
	Given I have submitted a first party English straight through response
		|part_no			|pool_number		|last_name	|postcode	|email 	|
		|<juror_number_one>	|<pool_number_one>	|<last_name>|CH1 2AN	|a@a.com|

	# Submit response in pool
	Given I have submitted a first party English straight through response
		|part_no			|pool_number		|last_name		|postcode	| email |
		|<juror_number_two>	|<pool_number_two>	|<last_name_two>|CH1 2AN	|a@a.com|

	# Submit response in pool
	Given I have submitted a first party English straight through response
		|part_no				|pool_number			|last_name			|postcode	|email 	|
		|<juror_number_three>	|<pool_number_three>	|<last_name_three>	|CH1 2AN	|a@a.com|

	Given auto straight through processing has been enabled new schema

	Given I am on "Bureau" "test"
	And I log in as "MODTESTBUREAU"

	When I click on the "Assign Replies" link
	And I assign all the New Replies to "ARAMIS1"
	And I do not see any links on the page that open to a new page without an alt text

	Given I am on "Bureau" "test"
	And I log in as "ARAMIS1"
	And I see "Summons replies" on the page
	And I see "Your work" on the page
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
	And I see "There are no matching results." on the page
	
	#one result - search on name
	Then I click on the "Clear search" link
	And I set "Juror's last name" to "<last_name>"
	Then "Juror's last name" is "<last_name>"
	
	Then I press the "Search" button
	And I see "results for "LNAMESTANDARD"" on the page
	And I see "<juror_number_one>" on the page
	
	#three results - search on pool no
	Then I click on the "Clear search" link
	Then I do not see "<juror_number>" on the page
	
	And I set "Juror's pool number" to "<pool_number_one>"
	Then "Juror's pool number" is "<pool_number_one>"
	
	Then I press the "Search" button
	And I see "results for " on the page
	And I see "<juror_number_one>" on the page

	And I set "Juror's pool number" to "<pool_number_two>"
	Then "Juror's pool number" is "<pool_number_two>"

	Then I press the "Search" button
	And I see "results for " on the page
	And I see "<juror_number_two>" on the page

	And I set "Juror's pool number" to "<pool_number_three>"
	Then "Juror's pool number" is "<pool_number_three>"

	Then I press the "Search" button
	And I see "results for " on the page
	And I see "<juror_number_three>" on the page

	#search on juror number
	Then I click on the "Clear search" link
	And I set "Juror number" to "<juror_number_one>"
	Then I press the "Search" button
	And I see "results for " on the page
	And I see "<juror_number_one>" on the page
	And I see "<pool_number_one>" in the same row as "<juror_number_one>"
	And I see "ARAMIS1" in the same row as "<juror_number_one>"
	And I see "TO DO" on the page
	
Examples:
	| juror_number_one	| juror_number_two	| juror_number_three	| pool_number_one 	| pool_number_two| pool_number_three| last_name 	| last_name_two	| last_name_three	| postcode 	|
	| 045700030			| 045700031			| 045700032				| 457300030 		| 457300031      | 457300032		| LNAMESTANDARD	| LNAMEURGENT 	| LNAMESUPERURGENT	| CH1 2AN	|

@Features @NewSchemaConverted @JM-7282
Scenario Outline: Search as Team Leader

	#return to @RegressionSingle when defect fixed

	Given I am on "Public" "test"

	Given auto straight through processing has been disabled new schema

	Given a bureau owned pool is created with jurors
		| court | juror_number  		| pool_number		| att_date_weeks_in_future	| owner |
		| 457   | <juror_number_one>	| <pool_number_one>	| 5			            	| 400	|

	Given a bureau owned pool is created with jurors
		| court | juror_number  		| pool_number		| att_date_weeks_in_future	| owner |
		| 457   | <juror_number_two>	| <pool_number_two>	| 3			            	| 400	|

	Given a bureau owned pool is created with jurors
		| court | juror_number  		| pool_number			| att_date_weeks_in_future	| owner |
		| 457   | <juror_number_three>	| <pool_number_three>	| 2			            	| 400	|

	And juror "<juror_number_one>" has "LAST_NAME" as "<last_name>" new schema
	And juror "<juror_number_one>" has "POSTCODE" as "<postcode>" new schema
	And juror "<juror_number_two>" has "LAST_NAME" as "<last_name_two>" new schema
	And juror "<juror_number_two>" has "POSTCODE" as "<postcode>" new schema
	And juror "<juror_number_three>" has "LAST_NAME" as "<last_name_three>" new schema
	And juror "<juror_number_three>" has "POSTCODE" as "<postcode>" new schema

	Given auto straight through processing has been disabled new schema

	# Submit response in pool
	Given I have submitted a first party English straight through response
		|part_no			|pool_number		|last_name	|postcode	|email 	|
		|<juror_number_one>	|<pool_number_one>	|<last_name>|CH1 2AN	|a@a.com|

	# Submit response in pool
	Given I have submitted a first party English straight through response
		|part_no			|pool_number		|last_name		|postcode	| email |
		|<juror_number_two>	|<pool_number_two>	|<last_name_two>|CH1 2AN	|a@a.com|

	# Submit response in pool
	Given I have submitted a first party English straight through response
		|part_no				|pool_number			|last_name			|postcode	|email 	|
		|<juror_number_three>	|<pool_number_three>	|<last_name_three>	|CH1 2AN	|a@a.com|

	Given auto straight through processing has been enabled new schema

	#assign to CPASS

	Given I am on "Bureau" "test"
	And I log in as "MODTESTBUREAU"

	When I click on the "Assign Replies" link
	And I assign all the New Replies to "ARAMIS1"
	And I do not see any links on the page that open to a new page without an alt text

	And I see "Summons replies" on the page
	And I click on the "Your work" link
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
	And I see "Select an officer assigned" on the page
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
	And I see "There are no matching results." on the page
	
	#one result
	Then I click on the "Clear search" link
	Then I do not see "NORESULTS" on the page
	And I set "Juror's last name" to "LNAMESTANDARD"
	Then "Juror's last name" is "LNAMESTANDARD"
	
	Then I press the "Search" button
	And I see "results for " on the page
	And I see "<juror_number_one>" on the page
	
	#name appears if it's just 1
	And I press the "Select all" button
	And I press the "Send to..." button
	And I see "replies to a colleague" on the page
	And I see "Select an officer to send to" on the page
	And I see "Cancel" on the page
	And I click on the "Cancel" link
		
	#three results
	Then I click on the "Clear search" link
	Then I do not see "<juror_number_one>" on the page
	And I do not see "<last_name>" on the page
	And I set "Juror's pool number" to "<pool_number_one>"
	Then "Juror's pool number" is "<pool_number_one>"
	
	Then I press the "Search" button

	And I see "<juror_number_one>" on the page
	
	#names do not appear
	And I press the "Select all" button
	And I press the "Send to..." button
	And I see "Send this reply to a colleague" on the page

	And I see "LNAMESTANDARD" on the page
	And I do not see "LNAMEURGENT" on the page
	And I do not see "LNAMESUPERURGENT" on the page

	And I see "Cancel" on the page
	And I click on the "Cancel" link
	
	#more than 250 results
	Then I click on the "Clear search" link
	And I click on the "Advanced search" link
	And I check the "Completed" checkbox
	Then I press the "Search" button
	And I see "100 results for " on the page
	And I see "The specified search resulted in more than 100 results. This list only shows the oldest 100." on the page
	
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
	And I see "LNAMEURGENT" in the same row as "<juror_number_two>"
	And I see "LNAMESUPERURGENT" in the same row as "<juror_number_three>"
	
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
	And I see "LNAMEURGENT" in the same row as "<juror_number_two>"
	And I see "LNAMESUPERURGENT" in the same row as "<juror_number_three>"
	
Examples:
	| juror_number_one	| juror_number_two	| juror_number_three	| pool_number_one 	| pool_number_two| pool_number_three| last_name 	| last_name_two	| last_name_three	| postcode 	|
	| 045700033			| 045700034			| 045700035				| 457300033 		| 457300034      | 457300035 		| LNAMESTANDARD	| LNAMEURGENT 	| LNAMESUPERURGENT	| CH1 2AN	|

@RegressionSingle @NewSchemaConverted
Scenario: Work Allocation Fields and Labels Checks

	Given I am on "Bureau" "test"

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

	And I assign all the New Replies to "ARAMIS1"

	Then I see "0" in the same row as "total" in Backlog box
	Then I see "0" in the same row as "send" in Backlog box
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
	
	And I press the "Select all" button
	Then "ARAMIS1" is checked
	And "TeamPickListUser" is checked
	And "AutomationStaffMemberTWO" is checked

	And I press the "Unselect all" button
	Then "ARAMIS1" is unchecked
	And "TeamPickListUser" is unchecked
	And "AutomationStaffMemberTWO" is unchecked

@RegressionSingle @NewSchemaConverted
Scenario Outline: Work Allocation

#	Given I am on "Bureau" "test"
#
#	Given a bureau owned pool is created with jurors
#		| court | juror_number  	| pool_number		| att_date_weeks_in_future	| owner |
#		| 452   | <juror_number_one>| <pool_number_one>	| 5				            | 400	|
#
#	Given a bureau owned pool is created with jurors
#		| court | juror_number  	| pool_number		| att_date_weeks_in_future	| owner |
#		| 452   | <juror_number_two>| <pool_number_two>	| 3				            | 400	|
#
#	Given a bureau owned pool is created with jurors
#		| court | juror_number  		| pool_number			| att_date_weeks_in_future	| owner |
#		| 452   | <juror_number_three>	| <pool_number_three>	| 2				            | 400	|
#
#	And juror "<juror_number_one>" has "LAST_NAME" as "<last_name>" new schema
#	And juror "<juror_number_one>" has "POSTCODE" as "<postcode>" new schema
#
#	And juror "<juror_number_two>" has "LAST_NAME" as "<last_name>" new schema
#	And juror "<juror_number_two>" has "POSTCODE" as "<postcode>" new schema
#
#	And juror "<juror_number_three>" has "LAST_NAME" as "<last_name>" new schema
#	And juror "<juror_number_three>" has "POSTCODE" as "<postcode>" new schema

	Given I am on "Bureau" "test"
	And I log in as "MODTESTBUREAU"
	
	And I click on the "Assign Replies" link
	
	And I press the "Assign replies" button
	Then I see "There is a problem" on the page
	And I see "Enter how many replies you want to assign to each selected officer - you must enter a number in at least one box" on the page
	And I see "Select at least 1 officer to assign replies to" on the page
	
	And I set input field with "name" of "allocateNonUrgent" to "12345"
	And I set input field with "name" of "allocateUrgent" to "12345"

	And I press the "Assign replies" button
	Then I see "There is a problem" on the page
	And I see "Select at least 1 officer to assign replies to" on the page
	
	And I set input field with "name" of "allocateNonUrgent" to ""
	And I set input field with "name" of "allocateUrgent" to ""
	
	And I check the "ARAMIS1" checkbox

	And I press the "Assign replies" button
	Then I see "There is a problem" on the page
	And I see "Enter how many replies you want to assign to each selected officer - you must enter a number in at least one box" on the page
	
	And I set input field with "name" of "allocateNonUrgent" to "12345"
	And I set input field with "name" of "allocateUrgent" to "12345"
	
	And I check the "ARAMIS1" checkbox
	When I press the "Assign replies" button
	And "ARAMIS1-standard" assigned replies count is "0"
	And "ARAMIS1-urgent" assigned replies count is "0"
	And "ARAMIS1-send" assigned replies count is "0"
	And "ARAMIS1-total" assigned replies count is "0"
	
	#submit responses with auto-processing disabled
	
	Given I am on "Public" "test"
	And auto straight through processing has been disabled new schema
	And I have submitted a first party English straight through response
	| part_no				| pool_number			| last_name		| postcode		| email 	|
	| <juror_number_one>	| <pool_number_one>		| <last_name>	| <postcode>	| <email>	|
	| <juror_number_two>	| <pool_number_two>		| <last_name>	| <postcode>	| <email>	|
	| <juror_number_three>	| <pool_number_three>	| <last_name>	| <postcode>	| <email>	|
	
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

	Then I see "1" in the same row as "send" in Backlog box
		
	And I see "" in "allocateNonUrgent" Allocate Replies box
	And I see "" in "allocateUrgent" Allocate Replies box
	And I see "" in "allocateSuperUrgent" Allocate Replies box
	And the "Assign replies" button is disabled
	Then on "JUROR_MOD" . "JUROR_RESPONSE" I see "STAFF_LOGIN" is "ARAMIS1" where "JUROR_NUMBER" is "<juror_number_one>"

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

	Then I see "0" in the same row as "send" in Backlog box
	Then I see "0" in the same row as "standard" in Backlog box

	And I see "" in "allocateNonUrgent" Allocate Replies box
	And I see "" in "allocateUrgent" Allocate Replies box
	And I see "" in "allocateSuperUrgent" Allocate Replies box
	And the "Assign replies" button is disabled
	Then on "JUROR_MOD" . "JUROR_RESPONSE" I see "STAFF_LOGIN" is "ARAMIS1" where "JUROR_NUMBER" is "<juror_number_two>"
	
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

	Then I see "0" in the same row as "send" in Backlog box
	Then I see "0" in the same row as "standard" in Backlog box
	And I see "" in "allocateNonUrgent" Allocate Replies box
	And I see "" in "allocateUrgent" Allocate Replies box
	And I see "" in "allocateSuperUrgent" Allocate Replies box
	And the "Assign replies" button is disabled
	Then on "JUROR_MOD" . "JUROR_RESPONSE" I see "STAFF_LOGIN" is "ARAMIS1" where "JUROR_NUMBER" is "<juror_number_three>"
	And auto straight through processing has been enabled new schema
	
Examples:
	| juror_number_one	| juror_number_two	| juror_number_three	| pool_number_one	| pool_number_two 	| pool_number_three| last_name | postcode 	| email				|
	| 045200266			| 045200267			| 045200268				| 452300244	        | 452300245			| 452300246        | LNAME		| NN1 3HQ	| email@outlook.com	|

@RegressionSingle @NewSchemaConverted
Scenario Outline: Work Allocation - AUTO are not counted

	Given I am on "Bureau" "test"

	And I log in as "MODTESTBUREAU"
	And I click on the "Assign Replies" link
	And I assign all the New Replies to "MODTESTBUREAU"

	Given a bureau owned pool is created with jurors
		| court |juror_number  | pool_number	| att_date_weeks_in_future	| owner |
		| 452   |<juror_number>| <pool_number>	| 5				            | 400	|

	And juror "<juror_number>" has "LAST_NAME" as "<last_name>" new schema
	And juror "<juror_number>" has "POSTCODE" as "<postcode>" new schema

	Given I am on "Public" "test"

	And auto straight through processing has been enabled new schema

	And I have submitted a first party English straight through response
	| part_no		|pool_number	| last_name		|postcode	| email |
	|<juror_number>	|<pool_number>	| <last_name>	|<postcode>	|<email>|

	Then on "JUROR_MOD" . "JUROR_RESPONSE" I see "STAFF_LOGIN" is "AUTO" where "JUROR_NUMBER" is "<juror_number>" new schema

	Given I am on "Bureau" "test"
	When I log in as "MODTESTBUREAU"
	And I click on the "Assign Replies" link
	
	And I do not see "AUTO" on the page
	
	#check counts

	Then I see "0" in the same row as "total" in Backlog box
	Then I see "0" in the same row as "send" in Backlog box
	Then I see "0" in the same row as "standard" in Backlog box
	
	And "total-all" assigned replies count is "0" 	
	And "total-standard" assigned replies count is "0" 
	And "total-urgent" assigned replies count is "0"
	And "total-send" assigned replies count is "0"
	
Examples:
	| juror_number	| pool_number 	| last_name | postcode 	| email				|
	| 045200251		| 452300228 	| LNAME		| NN1 3HQ	| email@outlook.com	|


@Features @NewSchemaConverted @JM-7276
Scenario: Manage Team

	#return to @RegressionSingle when defect fixed

	Given I am on "Bureau" "test"
	And I log in as "MODTESTBUREAU"
	And staff with name "New Name" does not exist
	And I see "Summons replies" on the page
	And I see "Your work" on the page
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
	And I see "/users" in the URL
	And I see "Users" on the page
	And I see "Name" on the page
	And I see "Manager" on the page
	And I see "Status" on the page
	And I see "No" in the same row as "ARAMIS1"
	And I see "Yes" in the same row as "MODTESTBUREAU"
	Then I see "Active" in the same row as "ARAMIS1"
	
	# Inactive hidden by default
	And I do not see "Inactive" on the page
	And I do not see "LEVEL1" on the page
	And the radio button "Active users" is "Selected"
	Then I choose the "All users" radio button
	Then I see "Inactive" in the same row as "AutomationStaffTWO"
	Then I choose the "Active users" radio button
	And I do not see "Inactive" on the page
	And I do not see "AutomationStaffTWO" on the page
	Then I choose the "All users" radio button
	Then I click on the "System codes" link
	And I click on the "Users" link
	And the radio button "Active users" is "Selected"

	And I click on the "Sign out" link
	And I log in as "SYSTEMADMIN"
	
	#add team member
	Then I press the "Create a new user" button
	And I see "Select user type" on the page
	And I see "/create-user/type" in the URL
	
	#error check when fields not completed
	Then I press the "Continue" button
	And I see "Select a user type" on the page

	And I choose the "Bureau" radio button
	Then I press the "Continue" button

	#successfully add user
	And I set "Full name" to "New Name"
	And I set "Email" to "newname@email.com"

	Then I press the "Continue" button
	Then I see "Check new user details" on the page
	And I see "Bureau" in the same row as "User type"
	And I see "New Name" in the same row as "Full name"
	And I see "newname@email" in the same row as "Email"
	And I see "-" in the same row as "Extra permissions"
	And I press the "Create user" button
	Then I see "New user created" on the page
	
	#set team member to manager
	Then I press the "Edit user" button
	And "Full name" is "New Name"

	And I see "/edit-user/newname" in the URL
	And I check the "Manager" checkbox
	And the radio button "Active" is "selected"

	Then I press the "Save changes" button
	And I see "Bureau" in the same row as "User type"
	And I see "New Name" in the same row as "Full name"
	And I see "newname@email" in the same row as "Email"
	And I see "Manager" in the same row as "Extra permissions"
	
	#edit user's name
	Then I press the "Edit user" button
	And "Full name" is "New Name"

	And I see "/edit-user/newname" in the URL
	And I set "Full name" to "Updated New Name"
	And the radio button "Active" is "selected"

	Then I press the "Save changes" button
	And I see "Bureau" in the same row as "User type"
	And I see "Updated New Name" in the same row as "Full name"
	And I see "newname@email" in the same row as "Email"
	And I see "Manager" in the same row as "Extra permissions"
	
	#set team leader as inactive
	Then I press the "Edit user" button
	And "Full name" is "New Name"

	And I see "/edit-user/newname" in the URL
	And I choose the "Inactive" radio button
	And the radio button "Active" is "unselected"

	Then I press the "Save changes" button
	And I see "Bureau" in the same row as "User type"
	And I see "Updated New Name" in the same row as "Full name"
	And I see "newname@email" in the same row as "Email"
	And I see "Manager" in the same row as "Extra permissions"
	And I see "INACTIVE" on the page
	
	#attempt to add duplicate
	When I click on the "Back to users" link
	Then I press the "Create a new user" button

	And I choose the "Bureau" radio button
	Then I press the "Continue" button

	And I set "Full name" to "Updated New Name"
	And I set "Email" to "newname@email.com"

	Then I press the "Continue" button

	And I see "Email address already in use" on the page
	
	#attempt to deactivate when user has assigned responses

@Featues @NewSchemaConverted @JM-6728
Scenario Outline: Results grid updates when status changes are made

	#return to @RegressionSingle when defect fixed

	Given I am on "Bureau" "test"

	Given a bureau owned pool is created with jurors
		| court | juror_number  | pool_number	| att_date_weeks_in_future	| owner |
		| 452   | <juror_number>| <pool_number>	| 5				            | 400	|

	# Set part_no pool to not be urgent
	And juror "<juror_number>" has "LAST_NAME" as "<last_name>" new schema
	And juror "<juror_number>" has "POSTCODE" as "<postcode>" new schema

	#turn off auto processing
	Given auto straight through processing has been disabled new schema

	# Submit response in pool
	Given I have submitted a first party English straight through response
		|part_no		|pool_number	|last_name	|postcode	|email 	|
		|<juror_number>	|<pool_number>	|<last_name>|<postcode>	|a@a.com|

	#turn on auto processing
	Given auto straight through processing has been enabled new schema

	Given I am on "Bureau" "test"
	When I log in as "MODTESTBUREAU"
	
	Then I click on the "Search" link
	And I set "Juror's pool number" to "<pool_number>"
	And I press the "Search" button
	
	#record notes
	When I click on "<juror_number>" in the same row as "<juror_number>"
	When I click on the "Notes and logs" link
	And I click on the "Notes" link
	And I click on the "Add or change" link
	And I set text area with "id" of "notes" to "Some notes here"
	And I press the "Save" button

	#should this have been assigned to the user who added notes??
	When I click on the "Back" link
	Then I see "<juror_number>" on the page

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
	| juror_number	| pool_number 	| last_name 	| postcode 	|
	| 045200250		| 452300227 	| LNAMEUPDATE	| NN1 3HQ	|