Feature: Dashboard

@dashboard 
Scenario Outline: Dashboard - Summons Sent and responded and not responded

	Given I am on "Public" "juror-test01"
	Given the juror numbers have not been processed
		|part_no 	|pool_no 	|owner 	|
		|<part_no1> |<pool_no>	|400 	|
		|<part_no2> |<pool_no>	|400 	|
		|<part_no3> |<pool_no>	|400 	|
		|<part_no4> |<pool_no>	|400 	|
		|<part_no5> |<pool_no>	|400 	|
		|<part_no6> |<pool_no>	|400 	|
		|<part_no7> |<pool_no>	|400 	|
		|<part_no8> |<pool_no>	|400 	|
		|<part_no9> |<pool_no>	|400 	|
		|<part_no10> |<pool_no>	|400 	|
		|<part_no11> |<pool_no>	|400 	|
		|<part_no12> |<pool_no>	|400 	|
		|<part_no13> |<pool_no>	|400 	|
		|<part_no14> |<pool_no>	|400 	|
		|<part_no15> |<pool_no>	|400 	|
		|<part_no16> |<pool_no>	|400 	|
		|<part_no17> |<pool_no2>|400 	|
		
	Given the dashboard tables have been cleared
		
	#Set juror name and postcode
	And "<part_no1>" has "LNAME" as "<last_name>"
	And "<part_no1>" has "ZIP" as "<postcode>"
	And "<part_no2>" has "LNAME" as "<last_name>"
	And "<part_no2>" has "ZIP" as "<postcode>"
	And "<part_no3>" has "LNAME" as "<last_name>"
	And "<part_no3>" has "ZIP" as "<postcode>"
	And "<part_no4>" has "LNAME" as "<last_name>"
	And "<part_no4>" has "ZIP" as "<postcode>"
	And "<part_no5>" has "LNAME" as "<last_name>"
	And "<part_no5>" has "ZIP" as "<postcode>"
	And "<part_no6>" has "LNAME" as "<last_name>"
	And "<part_no6>" has "ZIP" as "<postcode>"
	And "<part_no7>" has "LNAME" as "<last_name>"
	And "<part_no7>" has "ZIP" as "<postcode>"
	And "<part_no8>" has "LNAME" as "<last_name>"
	And "<part_no8>" has "ZIP" as "<postcode>"
	And "<part_no9>" has "LNAME" as "<last_name>"
	And "<part_no9>" has "ZIP" as "<postcode>"
	And "<part_no10>" has "LNAME" as "<last_name>"
	And "<part_no10>" has "ZIP" as "<postcode>"
	And "<part_no11>" has "LNAME" as "<last_name>"
	And "<part_no11>" has "ZIP" as "<postcode>"
	And "<part_no12>" has "LNAME" as "<last_name>"
	And "<part_no12>" has "ZIP" as "<postcode>"
	And "<part_no13>" has "LNAME" as "<last_name>"
	And "<part_no13>" has "ZIP" as "<postcode>"
	And "<part_no14>" has "LNAME" as "<last_name>"
	And "<part_no14>" has "ZIP" as "<postcode>"
	And "<part_no15>" has "LNAME" as "<last_name>"
	And "<part_no15>" has "ZIP" as "<postcode>"
	And "<part_no16>" has "LNAME" as "<last_name>"
	And "<part_no16>" has "ZIP" as "<postcode>"
#	And "<part_no17>" has "LNAME" as "<last_name>"
#	And "<part_no17>" has "ZIP" as "<postcode>"
	
	#Insert an RSUM row in PART_HIST
	Given an RSUM row is generated for juror "<part_no1>" in pool "<pool_no>"
	Given an RSUM row is generated for juror "<part_no2>" in pool "<pool_no>"
	Given an RSUM row is generated for juror "<part_no3>" in pool "<pool_no>"
	Given an RSUM row is generated for juror "<part_no4>" in pool "<pool_no>"
	Given an RSUM row is generated for juror "<part_no5>" in pool "<pool_no>"
	Given an RSUM row is generated for juror "<part_no6>" in pool "<pool_no>"
	Given an RSUM row is generated for juror "<part_no7>" in pool "<pool_no>"
	Given an RSUM row is generated for juror "<part_no8>" in pool "<pool_no>"
	Given an RSUM row is generated for juror "<part_no9>" in pool "<pool_no>"
	Given an RSUM row is generated for juror "<part_no10>" in pool "<pool_no>"
	Given an RSUM row is generated for juror "<part_no11>" in pool "<pool_no>"
	Given an RSUM row is generated for juror "<part_no12>" in pool "<pool_no>"
	Given an RSUM row is generated for juror "<part_no13>" in pool "<pool_no>"
	Given an RSUM row is generated for juror "<part_no14>" in pool "<pool_no>"
	Given an RSUM row is generated for juror "<part_no15>" in pool "<pool_no>"
	Given an RSUM row is generated for juror "<part_no16>" in pool "<pool_no>"
#	Given an RSUM row is generated for juror "<part_no17>" in pool "<pool_no2>"
	
	#Set summons date
	And "<part_no1>" has "PART_HIST" . "DATE_PART" as "-22 mondays time" where "HISTORY_CODE" is "RSUM"
	And "<part_no2>" has "PART_HIST" . "DATE_PART" as "-22 mondays time" where "HISTORY_CODE" is "RSUM"
	And "<part_no3>" has "PART_HIST" . "DATE_PART" as "-22 mondays time" where "HISTORY_CODE" is "RSUM"
	And "<part_no4>" has "PART_HIST" . "DATE_PART" as "-22 mondays time" where "HISTORY_CODE" is "RSUM"
	And "<part_no5>" has "PART_HIST" . "DATE_PART" as "-22 mondays time" where "HISTORY_CODE" is "RSUM"
	And "<part_no6>" has "PART_HIST" . "DATE_PART" as "-22 mondays time" where "HISTORY_CODE" is "RSUM"
	And "<part_no13>" has "PART_HIST" . "DATE_PART" as "-22 mondays time" where "HISTORY_CODE" is "RSUM"
	And "<part_no7>" has "PART_HIST" . "DATE_PART" as "-18 mondays time" where "HISTORY_CODE" is "RSUM"
	And "<part_no8>" has "PART_HIST" . "DATE_PART" as "-18 mondays time" where "HISTORY_CODE" is "RSUM"
	And "<part_no9>" has "PART_HIST" . "DATE_PART" as "-18 mondays time" where "HISTORY_CODE" is "RSUM"
	And "<part_no10>" has "PART_HIST" . "DATE_PART" as "-18 mondays time" where "HISTORY_CODE" is "RSUM"
	And "<part_no11>" has "PART_HIST" . "DATE_PART" as "-18 mondays time" where "HISTORY_CODE" is "RSUM"
	And "<part_no12>" has "PART_HIST" . "DATE_PART" as "-18 mondays time" where "HISTORY_CODE" is "RSUM"
	And "<part_no14>" has "PART_HIST" . "DATE_PART" as "-18 mondays time" where "HISTORY_CODE" is "RSUM"
	And "<part_no15>" has "PART_HIST" . "DATE_PART" as "-18 mondays time" where "HISTORY_CODE" is "RSUM"
	And "<part_no16>" has "PART_HIST" . "DATE_PART" as "-22 mondays time" where "HISTORY_CODE" is "RSUM"
#	And "<part_no17>" has "PART_HIST" . "DATE_PART" as "-18 mondays time" where "HISTORY_CODE" is "RSUM"
	
	#Set ret_date in the future to allow response to work
	Given "<part_no1>" has "RET_DATE" as "2 mondays time"
	And "<part_no1>" has "NEXT_DATE" as "2 mondays time"
	Given "<part_no3>" has "RET_DATE" as "5 mondays time"
	And "<part_no3>" has "NEXT_DATE" as "5 mondays time"
	Given "<part_no5>" has "RET_DATE" as "5 mondays time"
	And "<part_no5>" has "NEXT_DATE" as "5 mondays time"
	Given "<part_no6>" has "RET_DATE" as "5 mondays time"
	And "<part_no6>" has "NEXT_DATE" as "5 mondays time"
	Given "<part_no7>" has "RET_DATE" as "2 mondays time"
	And "<part_no7>" has "NEXT_DATE" as "2 mondays time"
	Given "<part_no9>" has "RET_DATE" as "5 mondays time"
	And "<part_no9>" has "NEXT_DATE" as "5 mondays time"
	Given "<part_no11>" has "RET_DATE" as "5 mondays time"
	And "<part_no11>" has "NEXT_DATE" as "5 mondays time"
	Given "<part_no12>" has "RET_DATE" as "5 mondays time"
	And "<part_no12>" has "NEXT_DATE" as "5 mondays time"
	Given "<part_no13>" has "RET_DATE" as "2 mondays time"
	And "<part_no13>" has "NEXT_DATE" as "2 mondays time"
	Given "<part_no14>" has "RET_DATE" as "2 mondays time"
	And "<part_no14>" has "NEXT_DATE" as "2 mondays time"
	Given "<part_no16>" has "RET_DATE" as "5 mondays time"
	And "<part_no16>" has "NEXT_DATE" as "5 mondays time"
#	Given "<part_no17>" has "RET_DATE" as "2 mondays time"
#	And "<part_no17>" has "NEXT_DATE" as "2 mondays time"
	
	# Submit response in juror digital
	Given auto straight through processing has been enabled new schema
	Given I have submitted a first party English straight through response
		|part_no	|pool_number	|last_name		|postcode	|email 	|
		|<part_no1>	|<pool_no>		|<last_name>	|<postcode>	|<email>|
		|<part_no3>	|<pool_no>		|<last_name>	|<postcode>	|<email>|
		|<part_no7>	|<pool_no>		|<last_name>	|<postcode>	|<email>|
		|<part_no9>	|<pool_no>		|<last_name>	|<postcode>	|<email>|
		|<part_no13>|<pool_no>		|<last_name>	|<postcode>	|<email>|
		|<part_no14>|<pool_no>		|<last_name>	|<postcode>	|<email>|
		|<part_no16>|<pool_no>		|<last_name>	|<postcode>	|<email>|
#		|<part_no17>|<pool_no2>		|<last_name>	|<postcode>	|<email>|
	
	Given I have submitted a first party Welsh straight through response
		|part_no	|pool_number	|last_name		|postcode	|email 	|
		|<part_no5>	|<pool_no>		|<last_name>	|<postcode>	|<email>|
		|<part_no11>|<pool_no>		|<last_name>	|<postcode>	|<email>|
	
	Given I have submitted a third party English straight through response
		|part_no	|pool_number	|last_name		|postcode	|email 	|
		|<part_no6>	|<pool_no>		|<last_name>	|<postcode>	|<email>|
		|<part_no12>|<pool_no>		|<last_name>	|<postcode>	|<email>|

	#Process as responded
	Given I am on "Bureau" "juror-test01"
	And I log in as "MODTESTBUREAU"
	
	When I click on the "Search" link
	And I set "Juror number" to "<part_no1>"
	And I press the "Search" button
	And I click on "<part_no1>" in the same row as "<part_no1>"
	When I select "Responded" from Process reply
	And I check the "Mark juror as 'responded'" checkbox
	And I press the "Confirm" button
	Then I see "Completed" on the page
	
	When I click on the "Search" link
	And I set "Juror number" to "<part_no6>"
	And I press the "Search" button
	And I click on "<part_no6>" in the same row as "<part_no6>"
	When I select "Responded" from Process reply
	And I check the "Mark juror as 'responded'" checkbox
	And I press the "Confirm" button
	Then I see "Completed" on the page
	
	When I click on the "Search" link
	And I set "Juror number" to "<part_no7>"
	And I press the "Search" button
	And I click on "<part_no7>" in the same row as "<part_no7>"
	When I select "Responded" from Process reply
	And I check the "Mark juror as 'responded'" checkbox
	And I press the "Confirm" button
	Then I see "Completed" on the page
	
	When I click on the "Search" link
	And I set "Juror number" to "<part_no12>"
	And I press the "Search" button
	And I click on "<part_no12>" in the same row as "<part_no12>"
	When I select "Responded" from Process reply
	And I check the "Mark juror as 'responded'" checkbox
	And I press the "Confirm" button
	Then I see "Completed" on the page
	
	#Insert a RESP row in PART_HIST
	Given an RESP row is generated for juror "<part_no4>" in pool "<pool_no>"
	Given an RESP row is generated for juror "<part_no10>" in pool "<pool_no>"
	
	#update the resp date
	And "<part_no1>" has "PART_HIST" . "DATE_PART" as "-21 mondays time" where "HISTORY_CODE" is "RESP"
	And "<part_no1>" has "PART_HIST" . "USER_ID" as "CPASS" where "HISTORY_CODE" is "RESP"
	And "<part_no3>" has "PART_HIST" . "DATE_PART" as "-20 mondays time" where "HISTORY_CODE" is "RESP"
	And "<part_no3>" has "PART_HIST" . "USER_ID" as "CPASS" where "HISTORY_CODE" is "RESP"
	And "<part_no4>" has "PART_HIST" . "DATE_PART" as "-20 mondays time" where "HISTORY_CODE" is "RESP"
	And "<part_no4>" has "PART_HIST" . "USER_ID" as "CPASS" where "HISTORY_CODE" is "RESP"
	And "<part_no5>" has "PART_HIST" . "DATE_PART" as "-19 mondays time" where "HISTORY_CODE" is "RESP"
	And "<part_no5>" has "PART_HIST" . "USER_ID" as "CPASS" where "HISTORY_CODE" is "RESP"
	And "<part_no6>" has "PART_HIST" . "DATE_PART" as "-18 mondays time" where "HISTORY_CODE" is "RESP"
	And "<part_no6>" has "PART_HIST" . "USER_ID" as "CPASS" where "HISTORY_CODE" is "RESP"
	And "<part_no7>" has "PART_HIST" . "DATE_PART" as "-17 mondays time" where "HISTORY_CODE" is "RESP"
	And "<part_no7>" has "PART_HIST" . "USER_ID" as "CPASS" where "HISTORY_CODE" is "RESP"
	And "<part_no9>" has "PART_HIST" . "DATE_PART" as "-16 mondays time" where "HISTORY_CODE" is "RESP"
	And "<part_no9>" has "PART_HIST" . "USER_ID" as "CPASS" where "HISTORY_CODE" is "RESP"
	And "<part_no10>" has "PART_HIST" . "DATE_PART" as "-16 mondays time" where "HISTORY_CODE" is "RESP"
	And "<part_no10>" has "PART_HIST" . "USER_ID" as "CPASS" where "HISTORY_CODE" is "RESP"
	And "<part_no11>" has "PART_HIST" . "DATE_PART" as "-15 mondays time" where "HISTORY_CODE" is "RESP"
	And "<part_no11>" has "PART_HIST" . "USER_ID" as "CPASS" where "HISTORY_CODE" is "RESP"
	And "<part_no12>" has "PART_HIST" . "DATE_PART" as "-14 mondays time" where "HISTORY_CODE" is "RESP"
	And "<part_no12>" has "PART_HIST" . "USER_ID" as "CPASS" where "HISTORY_CODE" is "RESP"
	And "<part_no13>" has "PART_HIST" . "DATE_PART" as "-18 mondays time" where "HISTORY_CODE" is "RESP"
	And "<part_no13>" has "PART_HIST" . "USER_ID" as "CPASS" where "HISTORY_CODE" is "RESP"
	And "<part_no14>" has "PART_HIST" . "DATE_PART" as "-14 mondays time" where "HISTORY_CODE" is "RESP"
	And "<part_no14>" has "PART_HIST" . "USER_ID" as "CPASS" where "HISTORY_CODE" is "RESP"
	And "<part_no16>" has "PART_HIST" . "DATE_PART" as "-20 mondays time" where "HISTORY_CODE" is "RESP"
	And "<part_no16>" has "PART_HIST" . "USER_ID" as "AUTO" where "HISTORY_CODE" is "RESP"
#	And "<part_no17>" has "PART_HIST" . "DATE_PART" as "-14 mondays time" where "HISTORY_CODE" is "RESP"
#	And "<part_no17>" has "PART_HIST" . "USER_ID" as "CPASS" where "HISTORY_CODE" is "RESP"

#	#Insert a PUND row in PART_HIST (undelivered)
	Given an PUND row is generated for juror "<part_no15>" in pool "<pool_no>"
	
	#update the PUND date (undelivered)
	And "<part_no15>" has "PART_HIST" . "DATE_PART" as "-17 mondays time" where "HISTORY_CODE" is "PUND"
	
	#update status to 9 (undelivered)
	Given "<part_no15>" has "STATUS" as "9"
	
	#Set ret_date to be in the past
	Given "<part_no1>" has "RET_DATE" as "-11 mondays time"
	And "<part_no1>" has "NEXT_DATE" as "-11 mondays time"
	Given "<part_no2>" has "RET_DATE" as "-11 mondays time"
	And "<part_no2>" has "NEXT_DATE" as "-11 mondays time"
	Given "<part_no3>" has "RET_DATE" as "-11 mondays time"
	And "<part_no3>" has "NEXT_DATE" as "-11 mondays time"
	Given "<part_no4>" has "RET_DATE" as "-11 mondays time"
	And "<part_no4>" has "NEXT_DATE" as "-11 mondays time"
	Given "<part_no5>" has "RET_DATE" as "-11 mondays time"
	And "<part_no5>" has "NEXT_DATE" as "-11 mondays time"
	Given "<part_no6>" has "RET_DATE" as "-11 mondays time"
	And "<part_no6>" has "NEXT_DATE" as "-11 mondays time"
	Given "<part_no7>" has "RET_DATE" as "-7 mondays time"
	And "<part_no7>" has "NEXT_DATE" as "-7 mondays time"
	Given "<part_no8>" has "RET_DATE" as "-7 mondays time"
	And "<part_no8>" has "NEXT_DATE" as "-7 mondays time"
	Given "<part_no9>" has "RET_DATE" as "-7 mondays time"
	And "<part_no9>" has "NEXT_DATE" as "-7 mondays time"
	Given "<part_no10>" has "RET_DATE" as "-7 mondays time"
	And "<part_no10>" has "NEXT_DATE" as "-7 mondays time"
	Given "<part_no11>" has "RET_DATE" as "-7 mondays time"
	And "<part_no11>" has "NEXT_DATE" as "-7 mondays time"
	Given "<part_no12>" has "RET_DATE" as "-7 mondays time"
	And "<part_no12>" has "NEXT_DATE" as "-7 mondays time"
	Given "<part_no13>" has "RET_DATE" as "-11 mondays time"
	And "<part_no13>" has "NEXT_DATE" as "-11 mondays time"
	Given "<part_no14>" has "RET_DATE" as "-7 mondays time"
	And "<part_no14>" has "NEXT_DATE" as "-7 mondays time"
	Given "<part_no16>" has "RET_DATE" as "-11 mondays time"
	And "<part_no16>" has "NEXT_DATE" as "-11 mondays time"
#	Given "<part_no17>" has "RET_DATE" as "-7 mondays time"
	And "<part_no17>" has "NEXT_DATE" as "-7 mondays time"
	And "<part_no1>" has "UNIQUE_POOL" . "RETURN_DATE" as "-11 mondays time" where "POOL_NO" is "<pool_no>"
	And "<part_no1>" has "UNIQUE_POOL" . "NEXT_DATE" as "-11 mondays time" where "POOL_NO" is "<pool_no>"
	And "<part_no2>" has "UNIQUE_POOL" . "RETURN_DATE" as "-11 mondays time" where "POOL_NO" is "<pool_no>"
	And "<part_no2>" has "UNIQUE_POOL" . "NEXT_DATE" as "-11 mondays time" where "POOL_NO" is "<pool_no>"
	And "<part_no3>" has "UNIQUE_POOL" . "RETURN_DATE" as "-11 mondays time" where "POOL_NO" is "<pool_no>"
	And "<part_no3>" has "UNIQUE_POOL" . "NEXT_DATE" as "-11 mondays time" where "POOL_NO" is "<pool_no>"
	And "<part_no4>" has "UNIQUE_POOL" . "RETURN_DATE" as "-11 mondays time" where "POOL_NO" is "<pool_no>"
	And "<part_no4>" has "UNIQUE_POOL" . "NEXT_DATE" as "-11 mondays time" where "POOL_NO" is "<pool_no>"
	And "<part_no5>" has "UNIQUE_POOL" . "RETURN_DATE" as "-11 mondays time" where "POOL_NO" is "<pool_no>"
	And "<part_no5>" has "UNIQUE_POOL" . "NEXT_DATE" as "-11 mondays time" where "POOL_NO" is "<pool_no>"
	And "<part_no6>" has "UNIQUE_POOL" . "RETURN_DATE" as "-11 mondays time" where "POOL_NO" is "<pool_no>"
	And "<part_no6>" has "UNIQUE_POOL" . "NEXT_DATE" as "-11 mondays time" where "POOL_NO" is "<pool_no>"
	And "<part_no7>" has "UNIQUE_POOL" . "RETURN_DATE" as "-7 mondays time" where "POOL_NO" is "<pool_no>"
	And "<part_no7>" has "UNIQUE_POOL" . "NEXT_DATE" as "-7 mondays time" where "POOL_NO" is "<pool_no>"
	And "<part_no8>" has "UNIQUE_POOL" . "RETURN_DATE" as "-7 mondays time" where "POOL_NO" is "<pool_no>"
	And "<part_no8>" has "UNIQUE_POOL" . "NEXT_DATE" as "-7 mondays time" where "POOL_NO" is "<pool_no>"
	And "<part_no9>" has "UNIQUE_POOL" . "RETURN_DATE" as "-7 mondays time" where "POOL_NO" is "<pool_no>"
	And "<part_no9>" has "UNIQUE_POOL" . "NEXT_DATE" as "-7 mondays time" where "POOL_NO" is "<pool_no>"
	And "<part_no10>" has "UNIQUE_POOL" . "RETURN_DATE" as "-7 mondays time" where "POOL_NO" is "<pool_no>"
	And "<part_no10>" has "UNIQUE_POOL" . "NEXT_DATE" as "-7 mondays time" where "POOL_NO" is "<pool_no>"
	And "<part_no11>" has "UNIQUE_POOL" . "RETURN_DATE" as "-7 mondays time" where "POOL_NO" is "<pool_no>"
	And "<part_no11>" has "UNIQUE_POOL" . "NEXT_DATE" as "-7 mondays time" where "POOL_NO" is "<pool_no>"
	And "<part_no12>" has "UNIQUE_POOL" . "RETURN_DATE" as "-7 mondays time" where "POOL_NO" is "<pool_no>"
	And "<part_no12>" has "UNIQUE_POOL" . "NEXT_DATE" as "-7 mondays time" where "POOL_NO" is "<pool_no>"
	And "<part_no13>" has "UNIQUE_POOL" . "RETURN_DATE" as "-11 mondays time" where "POOL_NO" is "<pool_no>"
	And "<part_no13>" has "UNIQUE_POOL" . "NEXT_DATE" as "-11 mondays time" where "POOL_NO" is "<pool_no>"
	And "<part_no14>" has "UNIQUE_POOL" . "RETURN_DATE" as "-7 mondays time" where "POOL_NO" is "<pool_no>"
	And "<part_no14>" has "UNIQUE_POOL" . "NEXT_DATE" as "-7 mondays time" where "POOL_NO" is "<pool_no>"
	And "<part_no16>" has "UNIQUE_POOL" . "RETURN_DATE" as "-7 mondays time" where "POOL_NO" is "<pool_no>"
	And "<part_no16>" has "UNIQUE_POOL" . "NEXT_DATE" as "-7 mondays time" where "POOL_NO" is "<pool_no>"
#	And "<part_no17>" has "UNIQUE_POOL" . "RETURN_DATE" as "-11 mondays time" where "POOL_NO" is "<pool_no2>"
#	And "<part_no17>" has "UNIQUE_POOL" . "NEXT_DATE" as "-11 mondays time" where "POOL_NO" is "<pool_no2>"

	#set received date to be in the past
	Given the "date_received" for juror "<part_no1>" is set to "-21 mondays time"
	Given the "date_received" for juror "<part_no3>" is set to "-20 mondays time"
	Given the "date_received" for juror "<part_no5>" is set to "-19 mondays time"
	Given the "date_received" for juror "<part_no6>" is set to "-18 mondays time"
	Given the "date_received" for juror "<part_no7>" is set to "-17 mondays time"
	Given the "date_received" for juror "<part_no9>" is set to "-16 mondays time"
	Given the "date_received" for juror "<part_no11>" is set to "-15 mondays time"
	Given the "date_received" for juror "<part_no12>" is set to "-14 mondays time"
	Given the "date_received" for juror "<part_no13>" is set to "-13 mondays time"
	Given the "date_received" for juror "<part_no14>" is set to "-12 mondays time"
	Given the "date_received" for juror "<part_no16>" is set to "-20 mondays time"	
#	Given the "date_received" for juror "<part_no17>" is set to "-12 mondays time"
	
	#set completed detail to be in the past
	Given the "completed_at" for juror "<part_no1>" is set to "-21 mondays time"
	Given the "staff_assignment_date" for juror "<part_no1>" is set to "-21 mondays time"
	Given the "completed_at" for juror "<part_no3>" is set to "-20 mondays time"
	Given the "staff_assignment_date" for juror "<part_no3>" is set to "-20 mondays time"
	Given the "completed_at" for juror "<part_no5>" is set to "-19 mondays time"
	Given the "staff_assignment_date" for juror "<part_no5>" is set to "-19 mondays time"
	Given the "completed_at" for juror "<part_no6>" is set to "-18 mondays time"
	Given the "staff_assignment_date" for juror "<part_no6>" is set to "-18 mondays time"
	Given the "completed_at" for juror "<part_no7>" is set to "-17 mondays time"
	Given the "staff_assignment_date" for juror "<part_no7>" is set to "-17 mondays time"
	Given the "completed_at" for juror "<part_no9>" is set to "-16 mondays time"
	Given the "staff_assignment_date" for juror "<part_no9>" is set to "-16 mondays time"
	Given the "completed_at" for juror "<part_no11>" is set to "-15 mondays time"
	Given the "staff_assignment_date" for juror "<part_no11>" is set to "-15 mondays time"
	Given the "completed_at" for juror "<part_no12>" is set to "-14 mondays time"
	Given the "staff_assignment_date" for juror "<part_no12>" is set to "-14 mondays time"
	Given the "completed_at" for juror "<part_no16>" is set to "-20 mondays time"
	Given the "staff_assignment_date" for juror "<part_no16>" is set to "-20 mondays time"
#	Given the "completed_at" for juror "<part_no17>" is set to "-14 mondays time"
#	Given the "staff_assignment_date" for juror "<part_no17>" is set to "-14 mondays time"

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
	|part_no1	|part_no2	|part_no3	|part_no4	|part_no5	|part_no6	|part_no7	|part_no8	|part_no9	|part_no10	|part_no11	|part_no12	|part_no13	|part_no14	|part_no15	|part_no16	|pool_no	|part_no17	|pool_no2	|email 			|last_name	|postcode	|
	|645700161	|645700475	|645700578	|645700305	|645700634	|645700351	|645700989	|645700437	|645700508	|645700328	|645700776	|645700531	|645700639	|645700736	|645700470	|645700813	|457170401	|641500616	|415170401	|d.bach@cgi.com	|LNAME		|SA1 4PF	|
	
@dashboard 
Scenario: Dashboard - Summons Sent and responded and not responded
	Given I am on "Dashboard" "juror-test01"
	
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
