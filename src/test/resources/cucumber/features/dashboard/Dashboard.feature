Feature: Dashboard

@dashboard 
Scenario Outline: Dashboard - Summons Sent and responded and not responded a

	Given I am on "Public" "test"

	Given a bureau owned pool is created with jurors
		| court |juror_number    | pool_number		| att_date_weeks_in_future	| owner |
		| 452   |<juror_number1> | <pool_number1>	| 2				            | 400	|
		| 452   |<juror_number7> | <pool_number1>	| 2				            | 400	|
		| 452   |<juror_number13>| <pool_number1>	| 2				            | 400	|
		| 452   |<juror_number14>| <pool_number1>	| 2				            | 400	|
		| 452   |<juror_number17>| <pool_number1>	| 2				            | 400	|

	Given a bureau owned pool is created with jurors
		| court |juror_number    | pool_number		| att_date_weeks_in_future	| owner |
		| 452   |<juror_number2> | <pool_number2>	| 5				            | 400	|
		| 452   |<juror_number3> | <pool_number2>	| 5				            | 400	|
		| 452   |<juror_number4> | <pool_number2>	| 5				            | 400	|
		| 452   |<juror_number5> | <pool_number2>	| 5				            | 400	|
		| 452   |<juror_number6> | <pool_number2>	| 5				            | 400	|
		| 452   |<juror_number8> | <pool_number2>	| 5				            | 400	|
		| 452   |<juror_number9> | <pool_number2>	| 5				            | 400	|
		| 452   |<juror_number10>| <pool_number2>	| 5				            | 400	|
		| 452   |<juror_number11>| <pool_number2>	| 5				            | 400	|
		| 452   |<juror_number12>| <pool_number2>	| 5				            | 400	|
		| 452   |<juror_number15>| <pool_number2>	| 5				            | 400	|
		| 452   |<juror_number16>| <pool_number2>	| 5				            | 400	|

	Given the dashboard tables have been cleared

	#Set juror name and postcode
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
	And juror "<juror_number6>" has "LAST_NAME" as "<last_name>" new schema
	And juror "<juror_number6>" has "POSTCODE" as "<postcode>" new schema
	And juror "<juror_number7>" has "LAST_NAME" as "<last_name>" new schema
	And juror "<juror_number7>" has "POSTCODE" as "<postcode>" new schema
	And juror "<juror_number8>" has "LAST_NAME" as "<last_name>" new schema
	And juror "<juror_number8>" has "POSTCODE" as "<postcode>" new schema
	And juror "<juror_number9>" has "LAST_NAME" as "<last_name>" new schema
	And juror "<juror_number9>" has "POSTCODE" as "<postcode>" new schema
	And juror "<juror_number10>" has "LAST_NAME" as "<last_name>" new schema
	And juror "<juror_number10>" has "POSTCODE" as "<postcode>" new schema
	And juror "<juror_number11>" has "LAST_NAME" as "<last_name>" new schema
	And juror "<juror_number11>" has "POSTCODE" as "<postcode>" new schema
	And juror "<juror_number12>" has "LAST_NAME" as "<last_name>" new schema
	And juror "<juror_number12>" has "POSTCODE" as "<postcode>" new schema
	And juror "<juror_number13>" has "LAST_NAME" as "<last_name>" new schema
	And juror "<juror_number13>" has "POSTCODE" as "<postcode>" new schema
	And juror "<juror_number14>" has "LAST_NAME" as "<last_name>" new schema
	And juror "<juror_number14>" has "POSTCODE" as "<postcode>" new schema
	And juror "<juror_number15>" has "LAST_NAME" as "<last_name>" new schema
	And juror "<juror_number15>" has "POSTCODE" as "<postcode>" new schema
	And juror "<juror_number16>" has "LAST_NAME" as "<last_name>" new schema
	And juror "<juror_number16>" has "POSTCODE" as "<postcode>" new schema
	And juror "<juror_number17>" has "LAST_NAME" as "<last_name>" new schema
	And juror "<juror_number17>" has "POSTCODE" as "<postcode>" new schema

	#Insert an RSUM row in PART_HIST
	Given an RSUM row is generated for juror "<juror_number1>" in pool "<pool_number1>" new schema
	Given an RSUM row is generated for juror "<juror_number2>" in pool "<pool_number2>" new schema
	Given an RSUM row is generated for juror "<juror_number3>" in pool "<pool_number2>" new schema
	Given an RSUM row is generated for juror "<juror_number4>" in pool "<pool_number2>" new schema
	Given an RSUM row is generated for juror "<juror_number5>" in pool "<pool_number2>" new schema
	Given an RSUM row is generated for juror "<juror_number6>" in pool "<pool_number2>" new schema
	Given an RSUM row is generated for juror "<juror_number7>" in pool "<pool_number1>" new schema
	Given an RSUM row is generated for juror "<juror_number8>" in pool "<pool_number2>" new schema
	Given an RSUM row is generated for juror "<juror_number9>" in pool "<pool_number2>" new schema
	Given an RSUM row is generated for juror "<juror_number10>" in pool "<pool_number2>" new schema
	Given an RSUM row is generated for juror "<juror_number11>" in pool "<pool_number2>" new schema
	Given an RSUM row is generated for juror "<juror_number12>" in pool "<pool_number2>" new schema
	Given an RSUM row is generated for juror "<juror_number13>" in pool "<pool_number1>" new schema
	Given an RSUM row is generated for juror "<juror_number14>" in pool "<pool_number1>" new schema
	Given an RSUM row is generated for juror "<juror_number15>" in pool "<pool_number2>" new schema
	Given an RSUM row is generated for juror "<juror_number16>" in pool "<pool_number2>" new schema
	Given an RSUM row is generated for juror "<juror_number17>" in pool "<pool_number1>" new schema

	#Set summons date
	And "<juror_number1>" has "JUROR_HISTORY" . "DATE_CREATED" as "-22 mondays time" where "HISTORY_CODE" is "RSUM" new schema
	And "<juror_number2>" has "JUROR_HISTORY" . "DATE_CREATED" as "-22 mondays time" where "HISTORY_CODE" is "RSUM" new schema
	And "<juror_number3>" has "JUROR_HISTORY" . "DATE_CREATED" as "-22 mondays time" where "HISTORY_CODE" is "RSUM" new schema
	And "<juror_number4>" has "JUROR_HISTORY" . "DATE_CREATED" as "-22 mondays time" where "HISTORY_CODE" is "RSUM" new schema
	And "<juror_number5>" has "JUROR_HISTORY" . "DATE_CREATED" as "-22 mondays time" where "HISTORY_CODE" is "RSUM" new schema
	And "<juror_number6>" has "JUROR_HISTORY" . "DATE_CREATED" as "-22 mondays time" where "HISTORY_CODE" is "RSUM" new schema
	And "<juror_number13>" has "JUROR_HISTORY" . "DATE_CREATED" as "-22 mondays time" where "HISTORY_CODE" is "RSUM" new schema
	And "<juror_number16>" has "JUROR_HISTORY" . "DATE_CREATED" as "-22 mondays time" where "HISTORY_CODE" is "RSUM" new schema

	And "<juror_number7>" has "JUROR_HISTORY" . "DATE_CREATED" as "-18 mondays time" where "HISTORY_CODE" is "RSUM" new schema
	And "<juror_number8>" has "JUROR_HISTORY" . "DATE_CREATED" as "-18 mondays time" where "HISTORY_CODE" is "RSUM" new schema
	And "<juror_number9>" has "JUROR_HISTORY" . "DATE_CREATED" as "-18 mondays time" where "HISTORY_CODE" is "RSUM" new schema
	And "<juror_number10>" has "JUROR_HISTORY" . "DATE_CREATED" as "-18 mondays time" where "HISTORY_CODE" is "RSUM" new schema
	And "<juror_number11>" has "JUROR_HISTORY" . "DATE_CREATED" as "-18 mondays time" where "HISTORY_CODE" is "RSUM" new schema
	And "<juror_number12>" has "JUROR_HISTORY" . "DATE_CREATED" as "-18 mondays time" where "HISTORY_CODE" is "RSUM" new schema
	And "<juror_number14>" has "JUROR_HISTORY" . "DATE_CREATED" as "-18 mondays time" where "HISTORY_CODE" is "RSUM" new schema
	And "<juror_number15>" has "JUROR_HISTORY" . "DATE_CREATED" as "-18 mondays time" where "HISTORY_CODE" is "RSUM" new schema
	And "<juror_number17>" has "JUROR_HISTORY" . "DATE_CREATED" as "-18 mondays time" where "HISTORY_CODE" is "RSUM" new schema

#	 Submit response in juror digital
	Given auto straight through processing has been enabled new schema
	Given I have submitted a first party English straight through response
		|part_no			|pool_number	|last_name		|postcode	|email 	|
		|<juror_number1>	|<pool_number1>	|<last_name>	|<postcode>	|<email>|
		|<juror_number3>	|<pool_number2>	|<last_name>	|<postcode>	|<email>|
		|<juror_number7>	|<pool_number1>	|<last_name>	|<postcode>	|<email>|
		|<juror_number9>	|<pool_number2>	|<last_name>	|<postcode>	|<email>|
		|<juror_number13>	|<pool_number1>	|<last_name>	|<postcode>	|<email>|
		|<juror_number14>	|<pool_number1>	|<last_name>	|<postcode>	|<email>|
		|<juror_number16>	|<pool_number2>	|<last_name>	|<postcode>	|<email>|
		|<juror_number17>	|<pool_number1>	|<last_name>	|<postcode>	|<email>|

	Given I have submitted a first party Welsh straight through response
		|part_no			|pool_number	|last_name		|postcode	|email 	|
		|<juror_number5>	|<pool_number2>	|<last_name>	|<postcode>	|<email>|
		|<juror_number11>	|<pool_number2>	|<last_name>	|<postcode>	|<email>|

	Given I have submitted a third party English straight through response
		|part_no			|pool_number	|last_name		|postcode	|email 	|
		|<juror_number6>	|<pool_number2>	|<last_name>	|<postcode>	|<email>|
		|<juror_number12>	|<pool_number2>	|<last_name>	|<postcode>	|<email>|

	#Process as responded
	Given I am on "Bureau" "test"
	And I log in as "MODTESTBUREAU"

	When I click on the "Search" link
	And I set "Juror number" to "<juror_number1>"
	And I press the "Search" button
	And I click on "<juror_number1>" in the same row as "<juror_number1>"
	When I select "Mark as responded" from Process reply
	And I check the "Mark juror as 'responded'" checkbox
	And I press the "Confirm" button
	Then I see "Completed" on the page

	When I click on the "Search" link
	And I set "Juror number" to "<juror_number6>"
	And I press the "Search" button
	And I click on "<juror_number6>" in the same row as "<juror_number6>"
	When I select "Mark as responded" from Process reply
	And I check the "Mark juror as 'responded'" checkbox
	And I press the "Confirm" button
	Then I see "Completed" on the page

	When I click on the "Search" link
	And I set "Juror number" to "<juror_number7>"
	And I press the "Search" button
	And I click on "<juror_number7>" in the same row as "<juror_number7>"
	When I select "Mark as responded" from Process reply
	And I check the "Mark juror as 'responded'" checkbox
	And I press the "Confirm" button
	Then I see "Completed" on the page

	When I click on the "Search" link
	And I set "Juror number" to "<juror_number12>"
	And I press the "Search" button
	And I click on "<juror_number12>" in the same row as "<juror_number12>"
	When I select "Mark as responded" from Process reply
	And I check the "Mark juror as 'responded'" checkbox
	And I press the "Confirm" button
	Then I see "Completed" on the page

	#Insert a RESP row in PART_HIST
	Given an RESP row is generated for juror "<juror_number4>" in pool "<pool_number1>"
	Given an RESP row is generated for juror "<juror_number10>" in pool "<pool_number1>"

	#update the resp date
	And "<juror_number1>" has "JUROR_HISTORY" . "DATE_CREATED" as "-21 mondays time" where "HISTORY_CODE" is "RESP" new schema
	And "<juror_number1>" has "JUROR_HISTORY" . "USER_ID" as "CPASS" where "HISTORY_CODE" is "RESP" new schema
	And "<juror_number3>" has "JUROR_HISTORY" . "DATE_CREATED" as "-20 mondays time" where "HISTORY_CODE" is "RESP" new schema
	And "<juror_number3>" has "JUROR_HISTORY" . "USER_ID" as "CPASS" where "HISTORY_CODE" is "RESP" new schema
	And "<juror_number4>" has "JUROR_HISTORY" . "DATE_CREATED" as "-20 mondays time" where "HISTORY_CODE" is "RESP" new schema
	And "<juror_number4>" has "JUROR_HISTORY" . "USER_ID" as "CPASS" where "HISTORY_CODE" is "RESP" new schema
	And "<juror_number5>" has "JUROR_HISTORY" . "DATE_CREATED" as "-19 mondays time" where "HISTORY_CODE" is "RESP" new schema
	And "<juror_number5>" has "JUROR_HISTORY" . "USER_ID" as "CPASS" where "HISTORY_CODE" is "RESP" new schema
	And "<juror_number6>" has "JUROR_HISTORY" . "DATE_CREATED" as "-18 mondays time" where "HISTORY_CODE" is "RESP" new schema
	And "<juror_number6>" has "JUROR_HISTORY" . "USER_ID" as "CPASS" where "HISTORY_CODE" is "RESP" new schema
	And "<juror_number7>" has "JUROR_HISTORY" . "DATE_CREATED" as "-17 mondays time" where "HISTORY_CODE" is "RESP" new schema
	And "<juror_number7>" has "JUROR_HISTORY" . "USER_ID" as "CPASS" where "HISTORY_CODE" is "RESP" new schema
	And "<juror_number9>" has "JUROR_HISTORY" . "DATE_CREATED" as "-16 mondays time" where "HISTORY_CODE" is "RESP" new schema
	And "<juror_number9>" has "JUROR_HISTORY" . "USER_ID" as "CPASS" where "HISTORY_CODE" is "RESP" new schema
	And "<juror_number10>" has "JUROR_HISTORY" . "DATE_CREATED" as "-16 mondays time" where "HISTORY_CODE" is "RESP" new schema
	And "<juror_number10>" has "JUROR_HISTORY" . "USER_ID" as "CPASS" where "HISTORY_CODE" is "RESP" new schema
	And "<juror_number11>" has "JUROR_HISTORY" . "DATE_CREATED" as "-15 mondays time" where "HISTORY_CODE" is "RESP" new schema
	And "<juror_number11>" has "JUROR_HISTORY" . "USER_ID" as "CPASS" where "HISTORY_CODE" is "RESP" new schema
	And "<juror_number12>" has "JUROR_HISTORY" . "DATE_CREATED" as "-14 mondays time" where "HISTORY_CODE" is "RESP" new schema
	And "<juror_number12>" has "JUROR_HISTORY" . "USER_ID" as "CPASS" where "HISTORY_CODE" is "RESP" new schema
	And "<juror_number13>" has "JUROR_HISTORY" . "DATE_CREATED" as "-18 mondays time" where "HISTORY_CODE" is "RESP" new schema
	And "<juror_number13>" has "JUROR_HISTORY" . "USER_ID" as "CPASS" where "HISTORY_CODE" is "RESP" new schema
	And "<juror_number14>" has "JUROR_HISTORY" . "DATE_CREATED" as "-14 mondays time" where "HISTORY_CODE" is "RESP" new schema
	And "<juror_number14>" has "JUROR_HISTORY" . "USER_ID" as "CPASS" where "HISTORY_CODE" is "RESP" new schema
	And "<juror_number16>" has "JUROR_HISTORY" . "DATE_CREATED" as "-20 mondays time" where "HISTORY_CODE" is "RESP" new schema
	And "<juror_number16>" has "JUROR_HISTORY" . "USER_ID" as "AUTO" where "HISTORY_CODE" is "RESP" new schema
	And "<juror_number17>" has "JUROR_HISTORY" . "DATE_CREATED" as "-14 mondays time" where "HISTORY_CODE" is "RESP" new schema
	And "<juror_number17>" has "JUROR_HISTORY" . "USER_ID" as "CPASS" where "HISTORY_CODE" is "RESP" new schema

#	#Insert a PUND row in PART_HIST (undelivered)
	Given an PUND row is generated for juror "<juror_number15>" in pool "<pool_number1>" new schema

	#update the PUND date (undelivered)
	And "<juror_number15>" has "JUROR_HISTORY" . "DATE_CREATED" as "-17 mondays time" where "HISTORY_CODE" is "PUND" new schema

	#update status to 9 (undelivered)
	Given "<juror_number15>" has "STATUS" as "9" new schema

	#Set ret_date to be in the past
	Given pool "<pool_number1>" has attendance date as "-11 mondays time" new schema
	Given pool "<pool_number2>" has attendance date as "-7 mondays time" new schema

	#set received date to be in the past
	Given the "date_received" for juror "<juror_number1>" is set to "-21 mondays time" new schema
	Given the "date_received" for juror "<juror_number3>" is set to "-20 mondays time" new schema
	Given the "date_received" for juror "<juror_number5>" is set to "-19 mondays time" new schema
	Given the "date_received" for juror "<juror_number6>" is set to "-18 mondays time" new schema
	Given the "date_received" for juror "<juror_number7>" is set to "-17 mondays time" new schema
	Given the "date_received" for juror "<juror_number9>" is set to "-16 mondays time" new schema
	Given the "date_received" for juror "<juror_number11>" is set to "-15 mondays time" new schema
	Given the "date_received" for juror "<juror_number12>" is set to "-14 mondays time" new schema
	Given the "date_received" for juror "<juror_number13>" is set to "-13 mondays time" new schema
	Given the "date_received" for juror "<juror_number14>" is set to "-12 mondays time" new schema
	Given the "date_received" for juror "<juror_number16>" is set to "-20 mondays time" new schema
	Given the "date_received" for juror "<juror_number17>" is set to "-12 mondays time" new schema
	
	#set completed detail to be in the past
	Given the "completed_at" for juror "<juror_number1>" is set to "-21 mondays time" new schema
	Given the "staff_assignment_date" for juror "<juror_number1>" is set to "-21 mondays time" new schema
	Given the "completed_at" for juror "<juror_number3>" is set to "-20 mondays time" new schema
	Given the "staff_assignment_date" for juror "<juror_number3>" is set to "-20 mondays time" new schema
	Given the "completed_at" for juror "<juror_number5>" is set to "-19 mondays time" new schema
	Given the "staff_assignment_date" for juror "<juror_number5>" is set to "-19 mondays time" new schema
	Given the "completed_at" for juror "<juror_number6>" is set to "-18 mondays time" new schema
	Given the "staff_assignment_date" for juror "<juror_number6>" is set to "-18 mondays time" new schema
	Given the "completed_at" for juror "<juror_number7>" is set to "-17 mondays time" new schema
	Given the "staff_assignment_date" for juror "<juror_number7>" is set to "-17 mondays time" new schema
	Given the "completed_at" for juror "<juror_number9>" is set to "-16 mondays time" new schema
	Given the "staff_assignment_date" for juror "<juror_number9>" is set to "-16 mondays time" new schema
	Given the "completed_at" for juror "<juror_number11>" is set to "-15 mondays time" new schema
	Given the "staff_assignment_date" for juror "<juror_number11>" is set to "-15 mondays time" new schema
	Given the "completed_at" for juror "<juror_number12>" is set to "-14 mondays time" new schema
	Given the "staff_assignment_date" for juror "<juror_number12>" is set to "-14 mondays time" new schema
	Given the "completed_at" for juror "<juror_number16>" is set to "-20 mondays time" new schema
	Given the "staff_assignment_date" for juror "<juror_number16>" is set to "-20 mondays time" new schema
	Given the "completed_at" for juror "<juror_number17>" is set to "-14 mondays time" new schema
	Given the "staff_assignment_date" for juror "<juror_number17>" is set to "-14 mondays time" new schema

Examples:
##feb dates
#part_no1 is digital responded
#part_no2 is not responded
#part_no3 is auto responded
#part_no4 is responded by post
#part_no5 is digital responded Welsh
#part_no6 is 3rd party
#part_no13 is unprocessed
##march dates
#part_no7 is digital responded
#part_no8 is not responded
#part_no9 is auto responded
#part_no10 is responded by post
#part_no11 is digital responded Welsh
#part_no12 is 3rd party
#part_no14 is unprocessed
#part_no15 is undelivered
	|juror_number1	|juror_number2	|juror_number3	|juror_number4	|juror_number5	|juror_number6	|juror_number7	|juror_number8	|juror_number9	|juror_number10	|juror_number11	|juror_number12	|juror_number13	|juror_number14	|juror_number15	|juror_number16	|juror_number17	|pool_number1	|pool_number2	|email 			|last_name	|postcode	|
	|645200161		|645200475		|645200578		|645200305		|645200634		|645200351		|645200989		|645200437		|645200508		|645200328		|645200776		|645200531		|645200639		|645200736		|645200470		|645200813		|645200616		|452200401		|452200402		|e.mail@cgi.com	|LNAME		|SA1 4PF	|
	
@dashboard @JDB-5560
Scenario: Dashboard - Summons Sent and responded and not responded b
	Given I am on "Dashboard" "test"
	
	#clear values
	
	When I select "" from the "startMonth" dropdown on the Dashboard
	When I select "" from the "endMonth" dropdown on the Dashboard
	When I select "" from the "startYear" dropdown on the Dashboard
	When I select "" from the "endYear" dropdown on the Dashboard

	#no date values

	And I press the "Submit" button
	Then I see "Enter the start month" on the page
	Then I see "Enter the start year" on the page
	Then I see "Enter the end month" on the page
	Then I see "Enter the end year" on the page

	#JDB-5560
	#only start values
	
	When I select "January" from the "startMonth" dropdown on the Dashboard
	When I select "2020" from the "startYear" dropdown on the Dashboard
	When I select "" from the "endMonth" dropdown on the Dashboard
	When I select "" from the "endYear" dropdown on the Dashboard
	
	And I press the "Submit" button
	
	Then I see "Enter the end month" on the page
	Then I see "Enter the end year" on the page
	
	#only end values

	When I select "" from the "startMonth" dropdown on the Dashboard
	When I select "" from the "startYear" dropdown on the Dashboard
	When I select "January" from the "endMonth" dropdown on the Dashboard
	When I select "2020" from the "endYear" dropdown on the Dashboard
	
	And I press the "Submit" button
	
	Then I see "Enter the start month" on the page
	Then I see "Enter the start year" on the page
	
	#start and end values the same
	
	When I select "May" from the "startMonth" dropdown on the Dashboard
	When I select "May" from the "endMonth" dropdown on the Dashboard
	When I select "2020" from the "startYear" dropdown on the Dashboard
	When I select "2020" from the "endYear" dropdown on the Dashboard
	
	And I press the "Submit" button
	Then I see "Showing data from May 2020 to May 2020" on the page
	
	#start value after end value
	
	When I select "April" from the "startMonth" dropdown on the Dashboard
	When I select "2020" from the "startYear" dropdown on the Dashboard
	When I select "January" from the "endMonth" dropdown on the Dashboard
	When I select "2020" from the "endYear" dropdown on the Dashboard
	
	And I press the "Submit" button
	
	Then I see "Check the end date is later than the start date" on the page
	
	#end value before start value
	
	When I select "January" from the "endMonth" dropdown on the Dashboard
	When I select "2020" from the "endYear" dropdown on the Dashboard
	When I select "April" from the "startMonth" dropdown on the Dashboard
	When I select "2020" from the "startYear" dropdown on the Dashboard

	And I press the "Submit" button
	
	Then I see "Check the end date is later than the start date" on the page
