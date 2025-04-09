Feature: JDB-3198

@RegressionSingle
Scenario Outline: Can Set Juror Record to responded while response is TODO
	
	Given I am on "Public" "ithc"

	Given a bureau owned pool is created with jurors
		| court |juror_number  | pool_number	| att_date_weeks_in_future	| owner |
		| 452   |<juror_number>| <pool_number>	| 3				            | 400	|

	And juror "<juror_number>" has "LAST_NAME" as "<last_name>" new schema
	And juror "<juror_number>" has "POSTCODE" as "<postcode>" new schema
	And juror "<juror_number>" has "DOB" as "1971-08-13 00:00:00.000" new schema

	# Submit response in pool
	Given I have submitted a first party English ineligibilty response
		|part_no			|pool_number	|last_name		|postcode	|email 	|
		|<juror_number>		|<pool_number>	|<last_name>	|<postcode>	|<email>|

	Given I am on "Bureau" "ithc"
	And I log in as "CPASS"

	And I search for juror "<juror_number>"
	And I click the update juror record button
	And I choose the "Mark as responded" radio button
	And I press the "Continue" button
	And I check the "Mark juror as 'responded'" checkbox
	And I press the "Confirm" button

	And I click on the "Summons reply" link
	Then I see "Completed" on the page
	And I see "Responded" on the page

	And I click on the "Juror details" link
	And I see "Fname Changed" on the page

	Then on "JUROR_MOD" . "JUROR_RESPONSE" I see "PROCESSING_STATUS" is "CLOSED" where "JUROR_NUMBER" is "<juror_number>"
	Then on "JUROR_MOD" . "JUROR_RESPONSE" I see "PROCESSING_COMPLETE" is "Y" where "JUROR_NUMBER" is "<juror_number>"
	Then on "JUROR_MOD" . "JUROR_RESPONSE" I see "LAST_NAME" is "Changed" where "JUROR_NUMBER" is "<juror_number>"

	#check record is now in "completed today"
	When I click on the "Apps" link
	And I click on the "Summons management" link
	Then I click on the "Completed" link
	Then I see "<juror_number>" on the page

Examples:
	| juror_number	| pool_number	| last_name	| postcode	| email 	|
	| 045200252		| 452300229		| DOE		| SW1H 9AJ	| a@a.com	|
	
@RegressionSingle
Scenario Outline: Can Set Juror Record to Excused while response is TODO
	
	Given I am on "Public" "ithc"

	Given a bureau owned pool is created with jurors
		| court | juror_number  | pool_number	| att_date_weeks_in_future	| owner |
		| 452   | <juror_number>| <pool_number>	| 3				            | 400	|

	And juror "<juror_number>" has "LAST_NAME" as "<last_name>" new schema
	And juror "<juror_number>" has "POSTCODE" as "<postcode>" new schema
	And juror "<juror_number>" has "DOB" as "1971-08-13 00:00:00.000" new schema
	
	# Submit response in pool
	Given I have submitted a first party English ineligibilty response
		| part_no			| pool_number	| last_name		| postcode		| email 	|
		| <juror_number>	| <pool_number>	| <last_name>	| <postcode>	| <email>	|
	
	Given I am on "Bureau" "ithc"
	And I log in as "CPASS"

	##excuse juror
	When the user searches for juror record "<juror_number>" from the global search bar
	And I press the "Update juror record" button
	And I choose the "Excusal - grant or refuse" radio button
	And I press the "Continue" button
	And I select "I - ILL" from the "Reason for excusal request" dropdown
	And I choose the "Grant excusal" radio button
	And I press the "Continue" button
	Then I see the juror record updated banner containing "Excusal granted (ill)"
	
	#check that the response has been completed
	When I click on the "Summons reply" link
	Then I see "Completed" on the page
	And I see "Excusal granted (ill)" on the page

	And I click on the "Juror details" link
	And I see "Fname Changed" on the page

	Then on "JUROR_MOD" . "JUROR_RESPONSE" I see "PROCESSING_STATUS" is "CLOSED" where "JUROR_NUMBER" is "<juror_number>"
	Then on "JUROR_MOD" . "JUROR_RESPONSE" I see "PROCESSING_COMPLETE" is "Y" where "JUROR_NUMBER" is "<juror_number>"
	Then on "JUROR_MOD" . "JUROR_RESPONSE" I see "LAST_NAME" is "Changed" where "JUROR_NUMBER" is "<juror_number>"
	
	#check record is now in "completed today"
	When I click on the "Apps" link
	And I click on the "Summons management" link
	Then I click on the "Completed" link
	Then I see "<juror_number>" on the page
	
Examples:
	| juror_number	| pool_number	| last_name			| postcode	| email		|
	| 045200255		| 452300232		| LNAMETWOSIXZERO	| CH1 2AN	| a@a.com	|
	
@RegressionSingle
Scenario Outline: Can Set Juror Record to Disqualified while response is TODO
	
	Given I am on "Public" "ithc"

	Given a bureau owned pool is created with jurors
		| court | juror_number  | pool_number	| att_date_weeks_in_future	| owner |
		| 452   | <juror_number>| <pool_number>	| 2				            | 400	|

	And juror "<juror_number>" has "LAST_NAME" as "<last_name>" new schema
	And juror "<juror_number>" has "POSTCODE" as "<postcode>" new schema
	And juror "<juror_number>" has "DOB" as "1971-08-13 00:00:00.000" new schema

	# Submit response in pool
	Given I have submitted a first party English ineligibilty response
		| part_no			| pool_number	| last_name		| postcode		| email 	|
		| <juror_number>	| <pool_number>	| <last_name>	| <postcode>	| <email>	|
	
	Given I am on "Bureau" "ithc"
	And I log in as "CPASS"
	
	##disqualify juror
	When the user searches for juror record "<juror_number>" from the global search bar
	And I press the "Update juror record" button
	And I choose the "Disqualify juror" radio button
	And I press the "Continue" button
	And I choose the "A - Age" radio button
	And I press the "Continue" button
	Then I see the juror record updated banner containing "Disqualified"

	#check that the response has been completed
	When I click on the "Summons reply" link
	Then I see "Completed" on the page
	And I see "Disqualified" on the page

	And I click on the "Juror details" link
	And I see "Fname Changed" on the page

	Then on "JUROR_MOD" . "JUROR_RESPONSE" I see "PROCESSING_STATUS" is "CLOSED" where "JUROR_NUMBER" is "<juror_number>"
	Then on "JUROR_MOD" . "JUROR_RESPONSE" I see "PROCESSING_COMPLETE" is "Y" where "JUROR_NUMBER" is "<juror_number>"
	Then on "JUROR_MOD" . "JUROR_RESPONSE" I see "LAST_NAME" is "Changed" where "JUROR_NUMBER" is "<juror_number>"
	
	#check record is now in "completed today"
	When I click on the "Apps" link
	And I click on the "Summons management" link
	Then I click on the "Completed" link
	Then I see "<juror_number>" on the page
	
Examples:
	| juror_number	| pool_number	| last_name			| postcode	| email		|
	| 045200256		| 452300233		| LNAMETWOSIXZERO	| CH1 2AN	| a@a.com	|

@RegressionSingle
Scenario Outline: Cannot Set Juror Record to Deferred while response is TODO

	Given I am on "Public" "demo"

	Given a bureau owned pool is created with jurors
		| court | juror_number  | pool_number	| att_date_weeks_in_future	| owner |
		| 452   | <juror_number>| <pool_number>	| 2				            | 400	|

	And juror "<juror_number>" has "LAST_NAME" as "<last_name>" new schema
	And juror "<juror_number>" has "POSTCODE" as "<postcode>" new schema

	# Submit response in pool
	Given I have submitted a first party English ineligibilty response
		| part_no			| pool_number	| last_name		| postcode		| email 	|
		| <juror_number>	| <pool_number>	| <last_name>	| <postcode>	| <email>	|

	Given I am on "Bureau" "demo"
	And I log in as "CPASS"

	##defer juror
	When the user searches for juror record "<juror_number>" from the global search bar
	And I press the "Update juror record" button
	And I do not see "Deferral - grant or refuse" on the page

Examples:
	| juror_number	| pool_number	| last_name			| postcode	| email		|
	| 045200257		| 452300234		| LNAMETWOSIXZERO	| CH1 2AN	| a@a.com	|

@RegressionSingle
Scenario Outline: Cannot Set Juror Record to Postponed while response is TODO

	Given I am on "Public" "demo"

	Given a bureau owned pool is created with jurors
		| court | juror_number  | pool_number	| att_date_weeks_in_future	| owner |
		| 452   | <juror_number>| <pool_number>	| 2				            | 400	|

	And juror "<juror_number>" has "LAST_NAME" as "<last_name>" new schema
	And juror "<juror_number>" has "POSTCODE" as "<postcode>" new schema

	# Submit response in pool
	Given I have submitted a first party English ineligibilty response
		| part_no			| pool_number	| last_name		| postcode		| email 	|
		| <juror_number>	| <pool_number>	| <last_name>	| <postcode>	| <email>	|

	Given I am on "Bureau" "demo"
	And I log in as "CPASS"

	#cannot postpose juror
	When the user searches for juror record "<juror_number>" from the global search bar
	And I press the "Update juror record" button
	And I do not see "Postpone service start date" on the page

	Examples:
		| juror_number	| pool_number	| last_name			| postcode	| email		|
		| 045200258		| 452300235		| LNAMETWOSIXZERO	| CH1 2AN	| a@a.com	|

@RegressionSingle
Scenario Outline: Can Set Juror Record to Reassigned while response is TODO

	Given I am on "Public" "ithc"

	Given a bureau owned pool is created with jurors
		| court | juror_number  | pool_number	| att_date_weeks_in_future	| owner |
		| 452   | <juror_number>| <pool_number>	| 2				            | 400	|

	And juror "<juror_number>" has "LAST_NAME" as "<last_name>" new schema
	And juror "<juror_number>" has "POSTCODE" as "<postcode>" new schema
	And juror "<juror_number>" has "DOB" as "1971-08-13 00:00:00.000" new schema

	# Submit response in pool
	Given I have submitted a first party English ineligibilty response
		| part_no			| pool_number	|last_name		|postcode	|email 	|
		| <juror_number>	| <pool_number>	|<last_name>	|<postcode>	|<email>|

	Given I am on "Bureau" "ithc"
	And I log in as "CPASS"

	##reassign juror
	When the user searches for juror record "<juror_number>" from the global search bar
	And I press the "Update juror record" button
	And I choose the "Reassign to another pool" radio button
	And I press the "Continue" button
	And I select one of the active pools available
	And I press the "Continue" button
	Then I see "Reassigned to pool" on the page

	#check that the response has been completed
	When I click on the "Summons reply" link

	#JM-6706
	Then I see "To Do" on the page

	Then on "JUROR_MOD" . "JUROR_RESPONSE" I see "PROCESSING_STATUS" is "TODO" where "JUROR_NUMBER" is "<juror_number>"
	Then on "JUROR_MOD" . "JUROR_RESPONSE" I see "PROCESSING_COMPLETE" is "N" where "JUROR_NUMBER" is "<juror_number>"
	Then on "JUROR_MOD" . "JUROR_RESPONSE" I see "LAST_NAME" is "Changed" where "JUROR_NUMBER" is "<juror_number>"

	#check record is now in "completed today"
	When I click on the "Apps" link
	And I click on the "Summons management" link
	Then I click on the "Completed" link
	Then I do not see "<juror_number>" on the page

	Examples:
		| juror_number	| pool_number	| last_name			| postcode	| email		|
		| 045200259		| 452300236		| LNAMETWOSIXZERO	| CH1 2AN	| a@a.com	|

@RegressionSingle
Scenario Outline: Can Set Juror Record to Deceased while response is TODO

	Given I am on "Public" "ithc"

	Given a bureau owned pool is created with jurors
		| court | juror_number  | pool_number	| att_date_weeks_in_future	| owner |
		| 452   | <juror_number>| <pool_number>	| 2				            | 400	|

	And juror "<juror_number>" has "LAST_NAME" as "<last_name>" new schema
	And juror "<juror_number>" has "POSTCODE" as "<postcode>" new schema

	# Submit response in pool
	Given I have submitted a first party English ineligibilty response
		|part_no		|pool_number	|last_name		|postcode	|email 	|
		|<juror_number>	|<pool_number>	|<last_name>	|<postcode>	|<email>|

	Given I am on "Bureau" "ithc"
	And I log in as "CPASS"

	##mark juror as deceased
	When the user searches for juror record "<juror_number>" from the global search bar
	And I press the "Update juror record" button
	And I choose the "Mark as deceased" radio button
	And I set "Comments to record in the juror’s history" to "some notes here"
	And I press the "Continue" button
	Then I see the juror record updated banner containing "Deceased"

	#check that the response has been completed
	When I click on the "Summons reply" link
	Then I see "Completed" on the page
	And I see "Excusal granted (deceased)" on the page

	Then on "JUROR_MOD" . "JUROR_RESPONSE" I see "PROCESSING_STATUS" is "CLOSED" where "JUROR_NUMBER" is "<juror_number>"
	Then on "JUROR_MOD" . "JUROR_RESPONSE" I see "PROCESSING_COMPLETE" is "Y" where "JUROR_NUMBER" is "<juror_number>"
	Then on "JUROR_MOD" . "JUROR_RESPONSE" I see "LAST_NAME" is "Changed" where "JUROR_NUMBER" is "<juror_number>"

	Examples:
		| juror_number	| pool_number	| last_name			| postcode	| email		|
		| 045200260		| 452300237		| LNAMETWOSIXZERO	| CH1 2AN	| a@a.com	|

@RegressionSingle
Scenario Outline: Can Set Juror Record to undelivered while response is TODO

	Given I am on "Public" "ithc"

	Given a bureau owned pool is created with jurors
		| court |juror_number  | pool_number	| att_date_weeks_in_future	| owner |
		| 452   |<juror_number>| <pool_number>	| 3				            | 400	|

	And juror "<juror_number>" has "LAST_NAME" as "<last_name>" new schema
	And juror "<juror_number>" has "POSTCODE" as "<postcode>" new schema

	# Submit response in pool
	Given I have submitted a first party English ineligibilty response
		| part_no			| pool_number	| last_name		| postcode		| email 	|
		| <juror_number>	| <pool_number>	| <last_name>	| <postcode>	| <email>	|

	Given I am on "Bureau" "ithc"
	And I log in as "CPASS"

	And I search for juror "<juror_number>"
	And I click the update juror record button
	And I choose the "Mark summons as undeliverable" radio button
	And I press the "Continue" button
	And I see the juror record updated banner containing "Summons undeliverable"

	And I click on the "Summons reply" link
	Then I see "Summons not received" on the page

	Then on "JUROR_MOD" . "JUROR_RESPONSE" I see "LAST_NAME" is "Changed" where "JUROR_NUMBER" is "<juror_number>"

	Examples:
		| juror_number	| pool_number	| last_name	| postcode	| email 	|
		| 045200260		| 452300237		| DOE		| SW1H 9AJ	| a@a.com	|