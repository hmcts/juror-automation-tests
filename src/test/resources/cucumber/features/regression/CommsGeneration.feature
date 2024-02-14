Feature: Comms Generation

@COMMSGENERATION
Scenario Outline: Create data for comms generation

	Given I am on "Public" "juror-test02"
	Given I have cleared down the juror digital database
	Given the juror numbers have not been processed
	|part_no		|pool_no 	|Owner 		|
#	|<part_no1>		|<pool_no> 	|400		|
#	|<part_no2>		|<pool_no> 	|400		|
	|<part_no3>		|<pool_no> 	|400		|
	Given auto straight through processing has been enabled
#	And "<part_no1>" has "RET_DATE" as "5 mondays time"
#	And "<part_no1>" has "NEXT_DATE" as "5 mondays time"
#	And "<part_no1>" has "LNAME" as "<last_name>"
#	And "<part_no1>" has "ZIP" as "<postcode>"
#	And "<part_no2>" has "RET_DATE" as "5 mondays time"
#	And "<part_no2>" has "NEXT_DATE" as "5 mondays time"
#	And "<part_no2>" has "LNAME" as "<last_name>"
#	And "<part_no2>" has "ZIP" as "<postcode>"
	And "<part_no3>" has "RET_DATE" as "1 mondays time"
	And "<part_no3>" has "NEXT_DATE" as "1 mondays time"
	And "<part_no3>" has "LNAME" as "<last_name>"
	And "<part_no3>" has "ZIP" as "<postcode>"
	And I have submitted a first party English straight through response
	|part_no		|pool_number|last_name		|postcode	| email |
#	|<part_no1>		|<pool_no>	|<last_name>	|<postcode>	|<email>|
	|<part_no3>		|<pool_no>	|<last_name>	|<postcode>	|<email>|
#	And I have submitted a first party English excusal response
#	|part_no		|pool_number|last_name		|postcode	| email |
#	|<part_no2>		|<pool_no>	|<last_name>	|<postcode>	|<email>|
	
	Given I am on "Bureau" "juror-test02"	
	And I log in as "SYSTEM"
	
#	When I click on the "Search" link
#	And I set "Juror number" to "<part_no1>"
#	And I press the "Search" button
#	And I click on "<part_no1>" in the same row as "<part_no1>"
#	Then I see "Responded" on the page
#	
#	When I click on the "Search" link
#	And I set "Juror number" to "<part_no2>"
#	And I press the "Search" button
#	And I click on "<part_no2>" in the same row as "<part_no2>"
#	When I select "Excusal" from Process reply
#	And I check the "Accept excusal" checkbox
#	And I select "OTHER" from the "Reason for excusal request" dropdown
#	And I press the "Mark as completed" button
	
	#DB checks (Do PNC PASS)
	And "<part_no1>" has "POLICE_CHECK" as "P"
	And "<part_no1>" has "PHOENIX_CHECKED" as "C"
	And "<part_no2>" has "POLICE_CHECK" as "P"
	And "<part_no2>" has "PHOENIX_CHECKED" as "C"
	
#	And "<part_no1>" has "READ_ONLY" as "Y"
#	And "<part_no2>" has "READ_ONLY" as "Y"
	And "<part_no3>" has "READ_ONLY" as "Y"
#	And the "super_urgent" for juror "<part_no3>" is set to "Y"
#	And the "urgent" for juror "<part_no3>" is set to "N"
	
#	When I click on the "Search" link
#	And I set "Juror number" to "<part_no3>"
#	And I press the "Search" button
#	And I click on "<part_no3>" in the same row as "<part_no3>"
#	When I select "PDF sent to court..." from Process reply
#	And I check the "PDF sent to court" checkbox
#	And I press the "Confirm" button

Examples:
|part_no1	|part_no2	|part_no3	|pool_no 	|last_name 				|postcode 	|email					|
|741500438	|741500613	|841500351	|415181001 	|LNAMEFOURTHREEEIGHT	|CH1 2AN	|danielle.bach@cgi.com	|

@COMMSGENERATION
Scenario Outline: Create data for JDB-4706

	Given I am on "Public" "juror-test01"
	Given I have cleared down the juror digital database
	Given the juror numbers have not been processed
	|part_no		|pool_no 	|Owner 		|
#	|<part_no1>		|<pool_no> 	|400		|
#	|<part_no2>		|<pool_no> 	|400		|
#	|<part_no3>		|<pool_no> 	|400		|
#	|<part_no4>		|<pool_no> 	|400		|
	|<part_no5>		|<pool_no2> |400		|

	Given auto straight through processing has been enabled
	
#	And "<part_no1>" has "RET_DATE" as "5 mondays time"
#	And "<part_no1>" has "NEXT_DATE" as "5 mondays time"
#	And "<part_no1>" has "LNAME" as "<last_name>"
#	And "<part_no1>" has "ZIP" as "<postcode>"
#	And "<part_no2>" has "RET_DATE" as "5 mondays time"
#	And "<part_no2>" has "NEXT_DATE" as "5 mondays time"
#	And "<part_no2>" has "LNAME" as "<last_name>"
#	And "<part_no2>" has "ZIP" as "<postcode>"
#	And "<part_no3>" has "RET_DATE" as "5 mondays time"
#	And "<part_no3>" has "NEXT_DATE" as "5 mondays time"
#	And "<part_no3>" has "LNAME" as "<last_name>"
#	And "<part_no3>" has "ZIP" as "<postcode>"
#	And "<part_no4>" has "RET_DATE" as "5 mondays time"
#	And "<part_no4>" has "NEXT_DATE" as "5 mondays time"
#	And "<part_no4>" has "LNAME" as "<last_name>"
#	And "<part_no4>" has "ZIP" as "<postcode>"
	And "<part_no5>" has "RET_DATE" as "5 mondays time"
	And "<part_no5>" has "NEXT_DATE" as "5 mondays time"
	And "<part_no5>" has "LNAME" as "<last_name>"
	And "<part_no5>" has "ZIP" as "<postcode>"

#	And I have submitted a first party English straight through response
#	|part_no		|pool_number|last_name		|postcode	|email 	|
#	|<part_no1>		|<pool_no>	|<last_name>	|<postcode>	|<email>|
#	|<part_no2>		|<pool_no>	|<last_name>	|<postcode>	|<email>|
#	|<part_no3>		|<pool_no>	|<last_name>	|<postcode>	|<email>|
#	|<part_no4>		|<pool_no>	|<last_name>	|<postcode>	|<email>|
#	
	And I have submitted a first party Welsh straight through response
	|part_no		|pool_number|last_name		|postcode	|email 	|
	|<part_no5>		|<pool_no2>	|<last_name>	|<postcode>	|<email>|
#	
#	Given I am on "Bureau" "juror-test01"	
#	And I log in as "SYSTEM"
#	
#	When I click on the "Search" link
#	And I set "Juror number" to "<part_no1>"
#	And I press the "Search" button
#	And I click on "<part_no1>" in the same row as "<part_no1>"
#	Then I see "Responded" on the page
#	
#	When I click on the "Search" link
#	And I set "Juror number" to "<part_no2>"
#	And I press the "Search" button
#	And I click on "<part_no2>" in the same row as "<part_no2>"
#	Then I see "Responded" on the page
#	
#	When I click on the "Search" link
#	And I set "Juror number" to "<part_no3>"
#	And I press the "Search" button
#	And I click on "<part_no3>" in the same row as "<part_no3>"
#	Then I see "Responded" on the page
#
#	When I click on the "Search" link
#	And I set "Juror number" to "<part_no4>"
#	And I press the "Search" button
#	And I click on "<part_no4>" in the same row as "<part_no4>"
#	Then I see "Responded" on the page
	
	#DB checks (Do PNC PASS)
#	And "<part_no1>" has "POLICE_CHECK" as "P"
#	And "<part_no1>" has "PHOENIX_CHECKED" as "C"
#	And "<part_no2>" has "POLICE_CHECK" as "P"
#	And "<part_no2>" has "PHOENIX_CHECKED" as "C"
#	And "<part_no3>" has "POLICE_CHECK" as "P"
#	And "<part_no3>" has "PHOENIX_CHECKED" as "C"
#	And "<part_no4>" has "POLICE_CHECK" as "P"
#	And "<part_no4>" has "PHOENIX_CHECKED" as "C"
	And "<part_no5>" has "POLICE_CHECK" as "P"
	And "<part_no5>" has "PHOENIX_CHECKED" as "C"
	
#	And "<part_no1>" has "READ_ONLY" as "Y"
#	And "<part_no2>" has "READ_ONLY" as "Y"
#	And "<part_no3>" has "READ_ONLY" as "Y"
#	And "<part_no4>" has "READ_ONLY" as "Y"
	And "<part_no5>" has "READ_ONLY" as "Y"

#	And the "super_urgent" for juror "<part_no1>" is set to "Y"
#	And the "urgent" for juror "<part_no1>" is set to "N"
#	And the "super_urgent" for juror "<part_no2>" is set to "Y"
#	And the "urgent" for juror "<part_no2>" is set to "N"
#	And the "super_urgent" for juror "<part_no3>" is set to "Y"
#	And the "urgent" for juror "<part_no3>" is set to "N"
#	And the "super_urgent" for juror "<part_no4>" is set to "Y"
#	And the "urgent" for juror "<part_no4>" is set to "N"
	And the "super_urgent" for juror "<part_no5>" is set to "Y"
	And the "urgent" for juror "<part_no5>" is set to "N"
	
#	And "<part_no2>" has "M_PHONE" as ""
#	And "<part_no3>" has "H_EMAIL" as ""
#	And the "EMAIL" for juror "<part_no3>" is set to ""
#	And "<part_no4>" has "M_PHONE" as ""
#	And "<part_no4>" has "H_EMAIL" as ""
	
	Given I have cleared down the juror digital database

Examples:
|part_no1	|part_no2	|part_no3	|part_no4	|part_no5	|pool_no 	|pool_no2	|last_name 				|postcode 	|email					|
|741500438	|741500613	|841500351	|741500626	|645700790	|415181001 	|457170501	|LNAMEFOURTHREEEIGHT	|CH1 2AN	|danielle.bach@cgi.com	|

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

@COMMSGENERATION 
Scenario Outline: Create data for JDB-4709

	Given I am on "Public" "juror-test01"
	Given I have cleared down the juror digital database
	Given the juror numbers have not been processed
	|part_no		|pool_no 	|Owner 		|
	|<part_no1>		|<pool_no> 	|400		|
#	|<part_no2>		|<pool_no> 	|400		|
#	|<part_no3>		|<pool_no> 	|400		|
#	|<part_no4>		|<pool_no> 	|400		|
#	|<part_no5>		|<pool_no2> |400		|

	Given auto straight through processing has been enabled
	
	And "<part_no1>" has "RET_DATE" as "1 mondays time"
	And "<part_no1>" has "NEXT_DATE" as "1 mondays time"
	And "<part_no1>" has "LNAME" as "<last_name>"
	And "<part_no1>" has "ZIP" as "<postcode>"
#	And "<part_no2>" has "RET_DATE" as "5 mondays time"
#	And "<part_no2>" has "NEXT_DATE" as "5 mondays time"
#	And "<part_no2>" has "LNAME" as "<last_name>"
#	And "<part_no2>" has "ZIP" as "<postcode>"
#	And "<part_no3>" has "RET_DATE" as "5 mondays time"
#	And "<part_no3>" has "NEXT_DATE" as "5 mondays time"
#	And "<part_no3>" has "LNAME" as "<last_name>"
#	And "<part_no3>" has "ZIP" as "<postcode>"
#	And "<part_no4>" has "RET_DATE" as "5 mondays time"
#	And "<part_no4>" has "NEXT_DATE" as "5 mondays time"
#	And "<part_no4>" has "LNAME" as "<last_name>"
#	And "<part_no4>" has "ZIP" as "<postcode>"
#	And "<part_no5>" has "RET_DATE" as "5 mondays time"
#	And "<part_no5>" has "NEXT_DATE" as "5 mondays time"
#	And "<part_no5>" has "LNAME" as "<last_name>"
#	And "<part_no5>" has "ZIP" as "<postcode>"

	And I have submitted a first party English straight through response
	|part_no		|pool_number|last_name		|postcode	|email 	|
	|<part_no1>		|<pool_no>	|<last_name>	|<postcode>	|<email>|
#	|<part_no2>		|<pool_no>	|<last_name>	|<postcode>	|<email>|
#	|<part_no3>		|<pool_no>	|<last_name>	|<postcode>	|<email>|
#	|<part_no4>		|<pool_no>	|<last_name>	|<postcode>	|<email>|
#	
#	And I have submitted a first party Welsh straight through response
#	|part_no		|pool_number|last_name		|postcode	|email 	|
#	|<part_no5>		|<pool_no2>	|<last_name>	|<postcode>	|<email>|
#	
#	Given I am on "Bureau" "juror-test01"	
#	And I log in as "SYSTEM"
#	
#	When I click on the "Search" link
#	And I set "Juror number" to "<part_no1>"
#	And I press the "Search" button
#	And I click on "<part_no1>" in the same row as "<part_no1>"
#	Then I see "Responded" on the page
#	
#	When I click on the "Search" link
#	And I set "Juror number" to "<part_no2>"
#	And I press the "Search" button
#	And I click on "<part_no2>" in the same row as "<part_no2>"
#	Then I see "Responded" on the page
#	
#	When I click on the "Search" link
#	And I set "Juror number" to "<part_no3>"
#	And I press the "Search" button
#	And I click on "<part_no3>" in the same row as "<part_no3>"
#	Then I see "Responded" on the page
#
#	When I click on the "Search" link
#	And I set "Juror number" to "<part_no4>"
#	And I press the "Search" button
#	And I click on "<part_no4>" in the same row as "<part_no4>"
#	Then I see "Responded" on the page
	
	#DB checks (Do PNC PASS)
#	And "<part_no1>" has "POLICE_CHECK" as "P"
#	And "<part_no1>" has "PHOENIX_CHECKED" as "C"
#	And "<part_no2>" has "POLICE_CHECK" as "P"
#	And "<part_no2>" has "PHOENIX_CHECKED" as "C"
#	And "<part_no3>" has "POLICE_CHECK" as "P"
#	And "<part_no3>" has "PHOENIX_CHECKED" as "C"
#	And "<part_no4>" has "POLICE_CHECK" as "P"
#	And "<part_no4>" has "PHOENIX_CHECKED" as "C"
#	And "<part_no5>" has "POLICE_CHECK" as "P"
#	And "<part_no5>" has "PHOENIX_CHECKED" as "C"
	
	And "<part_no1>" has "READ_ONLY" as "Y"
#	And "<part_no2>" has "READ_ONLY" as "Y"
#	And "<part_no3>" has "READ_ONLY" as "Y"
#	And "<part_no4>" has "READ_ONLY" as "Y"
#	And "<part_no5>" has "READ_ONLY" as "Y"

	And "<part_no1>" has "COMPLETION_FLAG" as "Y"
	And "<part_no1>" has "COMPLETION_DATE" as "17-02-2021 10:00"

#	And the "super_urgent" for juror "<part_no1>" is set to "Y"
#	And the "urgent" for juror "<part_no1>" is set to "N"
#	And the "super_urgent" for juror "<part_no2>" is set to "Y"
#	And the "urgent" for juror "<part_no2>" is set to "N"
#	And the "super_urgent" for juror "<part_no3>" is set to "Y"
#	And the "urgent" for juror "<part_no3>" is set to "N"
#	And the "super_urgent" for juror "<part_no4>" is set to "Y"
#	And the "urgent" for juror "<part_no4>" is set to "N"
#	And the "super_urgent" for juror "<part_no5>" is set to "Y"
#	And the "urgent" for juror "<part_no5>" is set to "N"
	
#	And "<part_no2>" has "M_PHONE" as ""
#	And "<part_no3>" has "H_EMAIL" as ""
#	And the "EMAIL" for juror "<part_no3>" is set to ""
#	And "<part_no4>" has "M_PHONE" as ""
#	And "<part_no4>" has "H_EMAIL" as ""
	
#	Given I have cleared down the juror digital database

Examples:
|part_no1	|part_no2	|part_no3	|part_no4	|part_no5	|pool_no 	|pool_no2	|last_name 				|postcode 	|email					|
|641500353	|741500613	|841500351	|741500626	|645700790	|415170402 	|457170501	|LNAMEFOURTHREEEIGHT	|CH1 2AN	|danielle.bach@cgi.com	|

#Now run cron job