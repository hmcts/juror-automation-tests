Feature: Comms Generation

@COMMSGENERATION @NewSchemaConverted
Scenario Outline: Create data for comms generation

	Given I am on "Public" "test"

	Given a bureau owned pool is created with jurors
		| court 	|juror_number  		| pool_number	 | att_date_weeks_in_future	| owner |
		| <court> 	|<juror_number1> 	| <pool_number1> | 5				        | 400	|
		| <court> 	|<juror_number2> 	| <pool_number1> | 5				        | 400	|

	Given a bureau owned pool is created with jurors
		| court 	|juror_number  		| pool_number	| att_date_weeks_in_future	| owner |
		| <court> 	|<juror_number3> 	| <pool_number2>| 1				            | 400	|

	Given auto straight through processing has been enabled new schema

	And "<juror_number1>" has "LNAME" as "<last_name>"
	And "<juror_number1>" has "ZIP" as "<postcode>"

	And "<juror_number2>" has "LNAME" as "<last_name>"
	And "<juror_number2>" has "ZIP" as "<postcode>"

	And "<juror_number3>" has "LNAME" as "<last_name>"
	And "<juror_number3>" has "ZIP" as "<postcode>"

	And I have submitted a first party English straight through response
	|part_no		|pool_number	|last_name		|postcode	| email |
	|<juror_number1>|<pool_number>	|<last_name>	|<postcode>	|<email>|
	|<juror_number3>|<pool_number>	|<last_name>	|<postcode>	|<email>|

	And I have submitted a first party English excusal response
	|part_no		|pool_number	|last_name		|postcode	| email |
	|<juror_number2>|<pool_number>	|<last_name>	|<postcode>	|<email>|

	Given I am on "Bureau" "test"
	And I log in as "MODTESTBUREAU"
	
	When I click on the "Search" link
	And I set "Juror number" to "<juror_number1>"
	And I press the "Search" button
	And I click on "<juror_number1>" in the same row as "<juror_number1>"
	Then I see "Responded" on the page

	When I click on the "Search" link
	And I set "Juror number" to "<juror_number2>"
	And I press the "Search" button
	And I click on "<juror_number2>" in the same row as "<juror_number2>"
	When I select "Excusal" from Process reply
	And I check the "Accept excusal" checkbox
	And I select "OTHER" from the "Reason for excusal request" dropdown
	And I press the "Mark as completed" button
	
	#DB checks (Do PNC PASS)
	And juror "<juror_number1>" has "POLICE_CHECK" as "P" new schema
	And juror "<juror_number1>" has "PHOENIX_CHECKED" as "C" new schema
	And juror "<juror_number2>" has "POLICE_CHECK" as "P" new schema
	And juror "<juror_number2>" has "PHOENIX_CHECKED" as "C" new schema
	
	And "<juror_number1>" has "READ_ONLY" as "Y" new schema
	And "<juror_number2>" has "READ_ONLY" as "Y" new schema
	And "<juror_number3>" has "READ_ONLY" as "Y" new schema
	And the "super_urgent" for juror "<juror_number3>" is set to "Y" new schema
	And the "urgent" for juror "<juror_number3>" is set to "N" new schema
	
	When I click on the "Search" link
	And I set "Juror number" to "<juror_number3>"
	And I press the "Search" button
	And I click on "<juror_number3>" in the same row as "<juror_number3>"
	When I select "PDF sent to court..." from Process reply
	And I check the "PDF sent to court" checkbox
	And I press the "Confirm" button

Examples:
|juror_number1	|juror_number2	|juror_number3	|pool_number1	|pool_number2 |last_name 			|postcode 	|email					| court	|
|041500016		|041500017		|041500018		|415300114 		|415300115    |LNAMEFOURTHREEEIGHT	|CH1 2AN	|e@mail.com	| 415	|

@COMMSGENERATION @NewSchemaConverted
Scenario Outline: Create data for JDB-4706

	Given I am on "Public" "test"

	Given a bureau owned pool is created with jurors
		| court 	|juror_number  		| pool_number	 | att_date_weeks_in_future	| owner |
		| <court> 	|<juror_number1> 	| <pool_number1> | 5				        | 400	|
		| <court> 	|<juror_number2> 	| <pool_number1> | 5				        | 400	|
		| <court> 	|<juror_number3> 	| <pool_number1> | 5				        | 400	|
		| <court> 	|<juror_number4> 	| <pool_number1> | 5				        | 400	|

	Given a bureau owned pool is created with jurors
		| court 	|juror_number  		| pool_number	| att_date_weeks_in_future	| owner |
		| <court> 	|<juror_number5> 	| <pool_number2>| 5				            | 400	|

	Given auto straight through processing has been enabled new schema

	And juror "<juror_number1>" has "LAST_NAME" as "<last_name>" new schema
	And juror "<juror_number1>" has "POSTCODE" as "<postcode>" new schema

	And juror "<juror_number2>" has "LAST_NAME" as "<last_name>" new schema
	And juror "<juror_number2>" has "POSTCODE" as "<postcode>" new schema

	And juror "<juror_number3>" has "LAST_LNAME" as "<last_name>" new schema
	And juror "<juror_number3>" has "POSTCODE" as "<postcode>" new schema

	And juror "<juror_number4>" has "LAST_LNAME" as "<last_name>" new schema
	And juror "<juror_number4>" has "POSTCODE" as "<postcode>" new schema

	And juror "<juror_number5>" has "LAST_LNAME" as "<last_name>" new schema
	And juror "<juror_number5>" has "POSTCODE" as "<postcode>" new schema

	And I have submitted a first party English straight through response
	|part_no		|pool_number	|last_name		|postcode	|email 	|
	|<juror_number1>|<pool_number1>	|<last_name>	|<postcode>	|<email>|
	|<juror_number2>|<pool_number1>	|<last_name>	|<postcode>	|<email>|
	|<juror_number3>|<pool_number1>	|<last_name>	|<postcode>	|<email>|
	|<juror_number4>|<pool_number1>	|<last_name>	|<postcode>	|<email>|

	And I have submitted a first party Welsh straight through response
	|part_no		|pool_number	|last_name		|postcode	|email 	|
	|<juror_number5>|<pool_number2>	|<last_name>	|<postcode>	|<email>|

	Given I am on "Bureau" "test"
	And I log in with "MODTESTBUREAU" and "Password1!"

	When I click on the "Search" link
	And I set "Juror number" to "<juror_number1>"
	And I press the "Search" button
	And I click on "<juror_number1>" in the same row as "<juror_number1>"
	Then I see "Responded" on the page

	When I click on the "Search" link
	And I set "Juror number" to "<juror_number2>"
	And I press the "Search" button
	And I click on "<juror_number2>" in the same row as "<juror_number2>"
	Then I see "Responded" on the page

	When I click on the "Search" link
	And I set "Juror number" to "<juror_number3>"
	And I press the "Search" button
	And I click on "<juror_number3>" in the same row as "<juror_number3>"
	Then I see "Responded" on the page

	When I click on the "Search" link
	And I set "Juror number" to "<juror_number4>"
	And I press the "Search" button
	And I click on "<juror_number4>" in the same row as "<juror_number4>"
	Then I see "Responded" on the page
	
	#DB checks (Do PNC PASS)
	And juror "<juror_number1>" has "POLICE_CHECK" as "P" new schema
	And juror "<juror_number1>" has "PHOENIX_CHECKED" as "C" new schema
	And juror "<juror_number2>" has "POLICE_CHECK" as "P" new schema
	And juror "<juror_number2>" has "PHOENIX_CHECKED" as "C" new schema
	And juror "<juror_number3>" has "POLICE_CHECK" as "P" new schema
	And juror "<juror_number3>" has "PHOENIX_CHECKED" as "C" new schema
	And juror "<juror_number4>" has "POLICE_CHECK" as "P" new schema
	And juror "<juror_number4>" has "PHOENIX_CHECKED" as "C" new schema
	And juror "<juror_number5>" has "POLICE_CHECK" as "P" new schema
	And juror "<juror_number5>" has "PHOENIX_CHECKED" as "C" new schema
	
	And "<juror_number1>" has "READ_ONLY" as "Y" new schema
	And "<juror_number2>" has "READ_ONLY" as "Y" new schema
	And "<juror_number3>" has "READ_ONLY" as "Y" new schema
	And "<juror_number4>" has "READ_ONLY" as "Y" new schema
	And "<juror_number5>" has "READ_ONLY" as "Y" new schema

	And the "super_urgent" for juror "<juror_number1>" is set to "Y" new schema
	And the "urgent" for juror "<juror_number1>" is set to "N" new schema
	And the "super_urgent" for juror "<juror_number2>" is set to "Y" new schema
	And the "urgent" for juror "<juror_number2>" is set to "N" new schema
	And the "super_urgent" for juror "<juror_number3>" is set to "Y" new schema
	And the "urgent" for juror "<juror_number3>" is set to "N" new schema
	And the "super_urgent" for juror "<juror_number4>" is set to "Y" new schema
	And the "urgent" for juror "<juror_number4>" is set to "N" new schema
	And the "super_urgent" for juror "<juror_number5>" is set to "Y" new schema
	And the "urgent" for juror "<juror_number5>" is set to "N" new schema
	
	And juror "<juror_number2>" has "M_PHONE" as "" new schema
	And juror "<juror_number3>" has "H_EMAIL" as "" new schema
	And the "EMAIL" for juror "<juror_number3>" is set to "" new schema
	And juror "<juror_number4>" has "M_PHONE" as "" new schema
	And juror "<juror_number4>" has "H_EMAIL" as "" new schema
	
	Given I have cleared down the juror digital database

Examples:
|juror_number1	|juror_number2	|juror_number3	|juror_number4	|juror_number5	|pool_number1 	|pool_number2	|last_name 				|postcode 	|email					| court	|
|041500019		|041500020		|041500021		|041500022		|041500023		|415300116 		|415300117		|LNAMEFOURTHREEEIGHT	|CH1 2AN	|e@mail.com	| 415   |

#Now run cron job

#SCENARIOS - SEND_EMAIL_OR_SMS=1
#juror1 - email and mobile recorded
#juror2 - email only recorded
#juror3 - mobile only recorded
#juror4 - no email and no mobile
#juror5 - WELSH email and mobile recorded

#RESULTS
#juror1 - email only
#juror2 - email only
#juror3 - sms only
#juror4 - no comms
#juror5 - WELSH email only

#SCENARIOS - SEND_EMAIL_OR_SMS=NULL
#juror1 - email and mobile recorded
#juror2 - email only recorded
#juror3 - mobile only recorded
#juror4 - no email and no mobile
#juror5 - WELSH email and mobile recorded

#RESULTS
#juror1 - email and SMS
#juror2 - email only
#juror3 - sms only
#juror4 - no comms
#juror5 - WELSH email and SMS

@COMMSGENERATION @NewSchemaConverted
Scenario Outline: Create data for JDB-4709

	Given I am on "Public" "test"

	Given auto straight through processing has been enabled new schema

	Given a bureau owned pool is created with jurors
		| court 	|juror_number  		| pool_number	 | att_date_weeks_in_future	| owner |
		| <court> 	|<juror_number1> 	| <pool_number1> | 5				        | 400	|
		| <court> 	|<juror_number2> 	| <pool_number1> | 5				        | 400	|
		| <court> 	|<juror_number3> 	| <pool_number1> | 5				        | 400	|
		| <court> 	|<juror_number4> 	| <pool_number1> | 5				        | 400	|

	Given a bureau owned pool is created with jurors
		| court 	|juror_number  		| pool_number	| att_date_weeks_in_future	| owner |
		| <court> 	|<juror_number5> 	| <pool_number2>| 1				            | 400	|

	And juror "<juror_number1>" has "LAST_NAME" as "<last_name>" new schema
	And juror "<juror_number1>" has "POSTCODE" as "<postcode>" new schema

	And juror "<juror_number2>" has "LAST_NAME" as "<last_name>" new schema
	And juror "<juror_number2>" has "POSTCODE" as "<postcode>" new schema

	And juror "<juror_number3>" has "LAST_NAME" as "<last_name>" new schema
	And juror "<juror_number3>" has "POSTCODE" as "<postcode>" new schema

	And juror "<juror_number4>" has "LAST_NAME" as "<last_name>" new schema
	And juror "<juror_number4>" has "POSTCODE" as "<postcode>" new schema

	And juror "<juror_number5>" has "LAST_NAME" as "<last_name>" new schema
	And juror "<juror_number5>" has "POSTCODE" as "<postcode>" new schema

	And I have submitted a first party English straight through response
	|part_no		|pool_number	|last_name		|postcode	|email 	|
	|<juror_number1>|<pool_number1>	|<last_name>	|<postcode>	|<email>|
	|<juror_number2>|<pool_number1>	|<last_name>	|<postcode>	|<email>|
	|<juror_number3>|<pool_number1>	|<last_name>	|<postcode>	|<email>|
	|<juror_number4>|<pool_number1>	|<last_name>	|<postcode>	|<email>|

	And I have submitted a first party Welsh straight through response
	|part_no		|pool_number	|last_name		|postcode	|email 	|
	|<juror_number5>|<pool_number2>	|<last_name>	|<postcode>	|<email>|

	Given I am on "Bureau" "test"
	And I log in with "MODTESTBUREAU" and "Password1!"

	When I click on the "Search" link
	And I set "Juror number" to "<juror_number1>"
	And I press the "Search" button
	And I click on "<juror_number1>" in the same row as "<juror_number1>"
	Then I see "Responded" on the page

	When I click on the "Search" link
	And I set "Juror number" to "<juror_number2>"
	And I press the "Search" button
	And I click on "<juror_number2>" in the same row as "<juror_number2>"
	Then I see "Responded" on the page

	When I click on the "Search" link
	And I set "Juror number" to "<juror_number3>"
	And I press the "Search" button
	And I click on "<juror_number3>" in the same row as "<juror_number3>"
	Then I see "Responded" on the page

	When I click on the "Search" link
	And I set "Juror number" to "<juror_number4>"
	And I press the "Search" button
	And I click on "<juror_number4>" in the same row as "<juror_number4>"
	Then I see "Responded" on the page
	
	#DB checks (Do PNC PASS)
	And juror "<juror_number1>" has "POLICE_CHECK" as "P" new schema
	And juror "<juror_number1>" has "PHOENIX_CHECKED" as "C" new schema
	And juror "<juror_number2>" has "POLICE_CHECK" as "P" new schema
	And juror "<juror_number2>" has "PHOENIX_CHECKED" as "C" new schema
	And juror "<juror_number3>" has "POLICE_CHECK" as "P" new schema
	And juror "<juror_number3>" has "PHOENIX_CHECKED" as "C" new schema
	And juror "<juror_number4>" has "POLICE_CHECK" as "P" new schema
	And juror "<juror_number4>" has "PHOENIX_CHECKED" as "C" new schema
	And juror "<juror_number5>" has "POLICE_CHECK" as "P" new schema
	And juror "<juror_number5>" has "PHOENIX_CHECKED" as "C" new schema
	
	And "<juror_number1>" has "READ_ONLY" as "Y" new schema
	And "<juror_number2>" has "READ_ONLY" as "Y" new schema
	And "<juror_number3>" has "READ_ONLY" as "Y" new schema
	And "<juror_number4>" has "READ_ONLY" as "Y" new schema
	And "<juror_number5>" has "READ_ONLY" as "Y" new schema

	And juror "<juror_number1>" has "COMPLETION_FLAG" as "Y" new schema
	And juror "<juror_number1>" has "COMPLETION_DATE" as "17-02-2021 10:00" new schema

	And the "super_urgent" for juror "<juror_number1>" is set to "Y" new schema
	And the "urgent" for juror "<juror_number1>" is set to "N" new schema
	And the "super_urgent" for juror "<juror_number2>" is set to "Y" new schema
	And the "urgent" for juror "<juror_number2>" is set to "N" new schema
	And the "super_urgent" for juror "<juror_number3>" is set to "Y" new schema
	And the "urgent" for juror "<juror_number3>" is set to "N" new schema
	And the "super_urgent" for juror "<juror_number4>" is set to "Y" new schema
	And the "urgent" for juror "<juror_number4>" is set to "N" new schema
	And the "super_urgent" for juror "<juror_number5>" is set to "Y" new schema
	And the "urgent" for juror "<juror_number5>" is set to "N" new schema
	
	And juror "<juror_number3>" has "M_PHONE" as "" new schema
	And juror "<juror_number3>" has "H_EMAIL" as "" new schema
	And the "EMAIL" for juror "<part_no3>" is set to "" new schema
	And juror "<juror_number4>" has "M_PHONE" as "" new schema
	And juror "<juror_number4>" has "H_EMAIL" as "" new schema


Examples:
|juror_number1	|juror_number2	|juror_number3	|juror_number4	|juror_number5	|pool_number1 	|pool_number2	|last_name 				|postcode 	|email					| court	|
|041500024		|041500025		|041500026		|041500027		|041500028		|415300118 		|415300119		|LNAMEFOURTHREEEIGHT	|CH1 2AN	|e@mail.com	| 415   |

#Now run cron job