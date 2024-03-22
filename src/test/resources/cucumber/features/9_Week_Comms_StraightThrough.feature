Feature: 9_Week_Comms_StraightThrough

@comms 
Scenario Outline: 1st Party English ST, 5 weeks in advance, PNC pass
	Given I am on "Public" "juror-test01"
	Given I have cleared down the juror digital database
	Given the juror numbers have not been processed
	|part_no		|pool_no 	|Owner 		|
	|741500438		|415181001 	|400		|
	Given auto straight through processing has been enabled new schema
	And "<juror_number>" has "RET_DATE" as "2 mondays time"
	And "<juror_number>" has "NEXT_DATE" as "2 mondays time"
	And I have submitted a first party English straight through response
	| part_no		|pool_number| last_name		|postcode	| email |
	|<part_no>		|<pool_no>	| <last_name>	|<postcode>	|<email>|

	Given I am on "Bureau" "juror-test01"	
	And I log in as "MODTESTBUREAU"
	
	When I click on the "Search" link
	And I set "Juror number" to "<juror_number>"
	And I press the "Search" button
	And I click on "<juror_number>" in the same row as "<juror_number>"
	Then I see "Responded" on the page
	
	#DB checks (Do PNC PASS)
	And "<juror_number>" has "POLICE_CHECK" as "P"
	And "<juror_number>" has "PHOENIX_CHECKED" as "C"
	
	#conf letter generated
#	Given a confirmation letter is generated for juror "<juror_number>"
	
#	Then on "JUROR" . "PRINT_FILES" I see "FORM_TYPE" is "5224A" where "PART_NO" is "<juror_number>"
#	Then on "JUROR" . "PRINT_FILES" I see "DIGITAL_COMMS" is "Y" where "PART_NO" is "<juror_number>"
#	Then on "JUROR" . "POOL" I see "NOTIFICATIONS" is null where "PART_NO" is "<juror_number>"
	
Examples:
|part_no		|pool_no 	|last_name 				|postcode 	|email					|
|741500438		|415181001 	|LNAMEFOURTHREEEIGHT	|CH1 2AN	|osman.salah@cgi.com	|

@comms
Scenario Outline: 1st Party English ST, 3 weeks in advance, PNC fail
	Given I am on "Public" "juror-test01"
	Given I have cleared down the juror digital database
	Given the juror numbers have not been processed
	|part_no		|pool_no 	|Owner 		|
	|741500543		|415181001 	|400		|
	Given auto straight through processing has been enabled new schema
	And "<juror_number>" has "RET_DATE" as "3 mondays time"
	And "<juror_number>" has "NEXT_DATE" as "3 mondays time"
	And I have submitted a first party English straight through response
	| part_no		|pool_number| last_name		|postcode	| email |
	|<part_no>		|<pool_no>	| <last_name>	|<postcode>	|<email>|
	
	Given I am on "Bureau" "juror-test01"	
	And I log in as "MODTESTBUREAU"
	
	When I click on the "Search" link
	And I set "Juror number" to "<juror_number>"
	And I press the "Search" button
	And I click on "<juror_number>" in the same row as "<juror_number>"
	Then I see "Summoned" on the page
	
	#process in Bureau as Responded
	When I select "Responded" from Process reply
	And I check the "Mark juror as 'responded'" checkbox
	And I press the "Confirm" button
	Then I see "Completed" on the page
	
	#DB checks (Do PNC PASS)
	And "<juror_number>" has "POLICE_CHECK" as "F"
	And "<juror_number>" has "PHOENIX_CHECKED" as "C"
	
	#record is auto disqualified
	And "<juror_number>" has "DATE_DISQ" as "01-JUL-19"
	And "<juror_number>" has "DISQ_CODE" as "E"
	And "<juror_number>" has "STATUS" as "6"
	And "<juror_number>" has "NEXT_DATE" as ""
	
	#conf letter generated
	Given a disqualified letter is generated for juror "<juror_number>"
	
#	Then on "JUROR" . "PRINT_FILES" I see "FORM_TYPE" is "5224" where "PART_NO" is "<juror_number>"
#	Then on "JUROR" . "PRINT_FILES" I see "DIGITAL_COMMS" is "Y" where "PART_NO" is "<juror_number>"
#	Then on "JUROR" . "POOL" I see "NOTIFICATIONS" is null where "PART_NO" is "<juror_number>"
	
Examples:
|part_no		|pool_no 	|last_name 				|postcode 	|email					|
|741500543		|415181001 	|LNAMEFIVEFOURTHREE		|CH1 2AN	|e@mail.com	|

@comms 
Scenario Outline: 1st Party English ST, 4 weeks in advance, PNC pass
	Given I am on "Public" "juror-test01"
	Given I have cleared down the juror digital database
	Given the juror numbers have not been processed
	|part_no		|pool_no 	|Owner 		|
	|741500586		|415181001 	|400		|
	Given auto straight through processing has been enabled new schema
	And "<juror_number>" has "RET_DATE" as "2 mondays time"
	And "<juror_number>" has "NEXT_DATE" as "2 mondays time"
	And I have submitted a first party Welsh straight through response
	| part_no		|pool_number| last_name		|postcode	| email |
	|<part_no>		|<pool_no>	| <last_name>	|<postcode>	|<email>|
	
#	And I have submitted a first party English straight through response
#	| part_no		|pool_number| last_name		|postcode	| email |
#	|<part_no>		|<pool_no>	| <last_name>	|<postcode>	|<email>|

	#Currently an issue with 4 weeks and urgents JDB-4010 (ONLY ON FRIDAY)

	Given I am on "Bureau" "juror-test01"	
	And I log in as "MODTESTBUREAU"
	
	When I click on the "Search" link
	And I set "Juror number" to "<juror_number>"
	And I press the "Search" button
	And I click on "<juror_number>" in the same row as "<juror_number>"
#	Then I see "Responded" on the page
#	Then I see "Summoned" on the page
#	
#	#process in Bureau as Responded
	When I select "Responded" from Process reply
	And I check the "Mark juror as 'responded'" checkbox
	And I press the "Confirm" button
	Then I see "Completed" on the page
	
	#DB checks (Do PNC PASS)
	And "<juror_number>" has "POLICE_CHECK" as "P"
	And "<juror_number>" has "PHOENIX_CHECKED" as "C"
	
	#conf letter generated
#	Given a confirmation letter is generated for juror "<juror_number>"
	
#	Then on "JUROR" . "PRINT_FILES" I see "FORM_TYPE" is "5224A" where "PART_NO" is "<juror_number>"
#	Then on "JUROR" . "PRINT_FILES" I see "DIGITAL_COMMS" is "Y" where "PART_NO" is "<juror_number>"
#	Then on "JUROR" . "POOL" I see "NOTIFICATIONS" is null where "PART_NO" is "<juror_number>"
	
Examples:
|part_no		|pool_no 	|last_name 				|postcode 	|email					|
|741500586		|415181001 	|LNAMEFIVEEIGHTSIX		|CH1 2AN	|osman.salah@cgi.com	|

@comms
Scenario Outline: 1st Party English ST, 3 weeks in advance, PNC pass
	Given I am on "Public" "juror-test01"
	Given I have cleared down the juror digital database
	Given the juror numbers have not been processed
	|part_no		|pool_no 	|Owner 		|
	|741500654		|415181001 	|400		|
	Given auto straight through processing has been enabled new schema
	And "<juror_number>" has "RET_DATE" as "3 mondays time"
	And "<juror_number>" has "NEXT_DATE" as "3 mondays time"
	And I have submitted a first party English straight through response
	| part_no		|pool_number| last_name		|postcode	| email |
	|<part_no>		|<pool_no>	| <last_name>	|<postcode>	|<email>|

	Given I am on "Bureau" "juror-test01"	
	And I log in as "MODTESTBUREAU"
	
	When I click on the "Search" link
	And I set "Juror number" to "<juror_number>"
	And I press the "Search" button
	And I click on "<juror_number>" in the same row as "<juror_number>"
	Then I see "Summoned" on the page
	And I see "Urgent" on the page
	
	#process in Bureau as Responded
	When I select "Responded" from Process reply
	And I check the "Mark juror as 'responded'" checkbox
	And I press the "Confirm" button
	Then I see "Completed" on the page
	
	#DB checks (Do PNC PASS)
	And "<juror_number>" has "POLICE_CHECK" as "P"
	And "<juror_number>" has "PHOENIX_CHECKED" as "C"
	
	#conf letter generated
	Given a confirmation letter is generated for juror "<juror_number>"
		
#	Then on "JUROR" . "PRINT_FILES" I see "FORM_TYPE" is "5224A" where "PART_NO" is "<juror_number>"
#	Then on "JUROR" . "PRINT_FILES" I see "DIGITAL_COMMS" is "Y" where "PART_NO" is "<juror_number>"
#	Then on "JUROR" . "POOL" I see "NOTIFICATIONS" is null where "PART_NO" is "<juror_number>"
	
Examples:
|part_no		|pool_no 	|last_name 				|postcode 	|email					|
|741500654		|415181001 	|LNAMESIXFIVEFOUR		|CH1 2AN	|e@mail.com	|

@comms
Scenario Outline: 1st Party English ST, 2 weeks in advance, PNC pass
	Given I am on "Public" "juror-test01"
	Given I have cleared down the juror digital database
	Given the juror numbers have not been processed
	|part_no		|pool_no 	|Owner 		|
	|741500057		|415181001 	|400		|
	Given auto straight through processing has been enabled new schema
	And "<juror_number>" has "RET_DATE" as "2 mondays time"
	And "<juror_number>" has "NEXT_DATE" as "2 mondays time"
	And I have submitted a first party English straight through response
	| part_no		|pool_number| last_name		|postcode	| email |
	|<part_no>		|<pool_no>	| <last_name>	|<postcode>	|<email>|

	Given I am on "Bureau" "juror-test01"	
	And I log in as "MODTESTBUREAU"
	
	When I click on the "Search" link
	And I set "Juror number" to "<juror_number>"
	And I press the "Search" button
	And I click on "<juror_number>" in the same row as "<juror_number>"
	Then I see "Summoned" on the page
	And I see "Urgent" on the page
	
	#process in Bureau as Responded
	When I select "Responded" from Process reply
	And I check the "Mark juror as 'responded'" checkbox
	And I press the "Confirm" button
	Then I see "Completed" on the page
	
	#DB checks (Do PNC PASS)
	And "<juror_number>" has "POLICE_CHECK" as "P"
	And "<juror_number>" has "PHOENIX_CHECKED" as "C"
	
	#conf letter generated
	Given a confirmation letter is generated for juror "<juror_number>"
	
#	Then on "JUROR" . "PRINT_FILES" I see "FORM_TYPE" is "5224A" where "PART_NO" is "<juror_number>"
#	Then on "JUROR" . "PRINT_FILES" I see "DIGITAL_COMMS" is "Y" where "PART_NO" is "<juror_number>"
#	Then on "JUROR" . "POOL" I see "NOTIFICATIONS" is null where "PART_NO" is "<juror_number>"
	
Examples:
|part_no		|pool_no 	|last_name 				|postcode 	|email					|
|741500057		|415181001 	|LNAMEFIVESEVEN			|CH1 2AN	|e@mail.com	|

@comms
Scenario Outline: 1st Party English ST, 2 weeks in advance, PNC fail
	Given I am on "Public" "juror-test01"
	Given I have cleared down the juror digital database
	Given the juror numbers have not been processed
	|part_no		|pool_no 	|Owner 		|
	|741500065		|415181001 	|400		|
	Given auto straight through processing has been enabled new schema
	And "<juror_number>" has "RET_DATE" as "2 mondays time"
	And "<juror_number>" has "NEXT_DATE" as "2 mondays time"
	And I have submitted a first party English straight through response
	| part_no		|pool_number| last_name		|postcode	| email |
	|<part_no>		|<pool_no>	| <last_name>	|<postcode>	|<email>|

	Given I am on "Bureau" "juror-test01"	
	And I log in as "MODTESTBUREAU"
	
	When I click on the "Search" link
	And I set "Juror number" to "<juror_number>"
	And I press the "Search" button
	And I click on "<juror_number>" in the same row as "<juror_number>"
	Then I see "Summoned" on the page
	And I see "Urgent" on the page
	
	#DB checks (Do PNC FAIL)
	
	Then on "JUROR" . "PRINT_FILES" I see "FORM_TYPE" is "5224" where "PART_NO" is "<juror_number>"
	Then on "JUROR" . "PRINT_FILES" I see "DIGITAL_COMMS" is "Y" where "PART_NO" is "<juror_number>"
	Then on "JUROR" . "POOL" I see "NOTIFICATIONS" is null where "PART_NO" is "<juror_number>"
	
Examples:
|part_no		|pool_no 	|last_name 				|postcode 	|email					|
|741500065		|415181001 	|LNAMESIXFIVE			|CH1 2AN	|e@mail.com|

@comms
Scenario Outline: 1st Party English ST, 1 week in advance, PNC pass
	Given I am on "Public" "juror-test01"
	Given I have cleared down the juror digital database
	Given the juror numbers have not been processed
	|part_no		|pool_no 	|Owner 		|
	|<part_no>		|<pool_no> 	|400		|
	Given auto straight through processing has been enabled new schema
	And "<juror_number>" has "RET_DATE" as "1 mondays time"
	And "<juror_number>" has "NEXT_DATE" as "1 mondays time"
	And "<juror_number>" has "READ_ONLY" as "Y"
	And I have submitted a first party English straight through response
	| part_no		|pool_number| last_name		|postcode	| email |
	|<part_no>		|<pool_no>	| <last_name>	|<postcode>	|<email>|

	Given I am on "Bureau" "juror-test01"	
	And I log in as "MODTESTBUREAU"
	
	When I click on the "Search" link
	And I set "Juror number" to "<juror_number>"
	And I press the "Search" button
	And I click on "<juror_number>" in the same row as "<juror_number>"
#	Then I see "Summoned" on the page
	And I see "Send to court" on the page
	
	#Check email and SMS as well as Notifications
	
	#Then on "JUROR" . "PRINT_FILES" I see "FORM_TYPE" is "5224A" where "PART_NO" is "<juror_number>"
	#Then on "JUROR" . "PRINT_FILES" I see "DIGITAL_COMMS" is "Y" where "PART_NO" is "<juror_number>"
	#Then on "JUROR" . "POOL" I see "NOTIFICATIONS" is null where "PART_NO" is "<juror_number>"
	
Examples:
|part_no		|pool_no 	|last_name 				|postcode 	|email					|
|741500833		|415181001 	|LNAMEEIGHTTHREETHREE	|CH1 2AN	|e@mail.com	|

@comms
Scenario Outline: 1st Party English ST, 1 day in advance, PNC pass
	Given I am on "Public" "juror-test01"
	Given I have cleared down the juror digital database
	Given the juror numbers have not been processed
	|part_no		|pool_no 	|Owner 		|
	|741500514		|415181001 	|400		|
	Given auto straight through processing has been enabled new schema
	And "<juror_number>" has "RET_DATE" as "1 days time"
	And "<juror_number>" has "NEXT_DATE" as "1 days time"
	And "<juror_number>" has "READ_ONLY" as "Y"
	And I have submitted a first party English straight through response
	| part_no		|pool_number| last_name		|postcode	| email |
	|<part_no>		|<pool_no>	| <last_name>	|<postcode>	|<email>|

	Given I am on "Bureau" "juror-test01"	
	And I log in as "MODTESTBUREAU"
	
	When I click on the "Search" link
	And I set "Juror number" to "<juror_number>"
	And I press the "Search" button
	And I click on "<juror_number>" in the same row as "<juror_number>"
	Then I see "Summoned" on the page
	And I see "Send to court" on the page
	
	#DB checks (Do PNC N/A)
	
	Then on "JUROR" . "PRINT_FILES" I see "FORM_TYPE" is "5224A" where "PART_NO" is "<juror_number>"
	Then on "JUROR" . "PRINT_FILES" I see "DIGITAL_COMMS" is "Y" where "PART_NO" is "<juror_number>"
	Then on "JUROR" . "POOL" I see "NOTIFICATIONS" is null where "PART_NO" is "<juror_number>"
	
Examples:
|part_no		|pool_no 	|last_name 				|postcode 	|email					|
|741500514		|415181001 	|LNAMEFIVEONEFOUR		|CH1 2AN	|e@mail.com	|

@comms 
Scenario Outline: 1st Party Welsh ST, 5 weeks in advance, PNC pass
	Given I am on "Public" "juror-test01"
	Given I have cleared down the juror digital database
	Given the juror numbers have not been processed
	|part_no		|pool_no 	|Owner 		|
	|<part_no>		|<pool_no>	|400		|
	Given auto straight through processing has been enabled new schema
	And "<juror_number>" has "RET_DATE" as "2 mondays time"
	And "<juror_number>" has "NEXT_DATE" as "2 mondays time"
	And I have submitted a first party Welsh straight through response
	| part_no		|pool_number| last_name		|postcode	| email |
	|<part_no>		|<pool_no>	| <last_name>	|<postcode>	|<email>|

#	And I have submitted a first party English straight through response
#	| part_no		|pool_number| last_name		|postcode	| email |
#	|<part_no>		|<pool_no>	| <last_name>	|<postcode>	|<email>|
	
	Given I am on "Bureau" "juror-test01"	
	And I log in as "MODTESTBUREAU"
	
	When I click on the "Search" link
	And I set "Juror number" to "<juror_number>"
	And I press the "Search" button
	And I click on "<juror_number>" in the same row as "<juror_number>"
#	Then I see "Responded" on the page
	
	#DB checks (Do PNC PASS)
	And "<juror_number>" has "POLICE_CHECK" as "P"
	And "<juror_number>" has "PHOENIX_CHECKED" as "C"
	
	#conf letter generated
#	Given a confirmation letter is generated for juror "<juror_number>"
	
#	Then on "JUROR" . "PRINT_FILES" I see "FORM_TYPE" is "5224A" where "PART_NO" is "<juror_number>"
#	Then on "JUROR" . "PRINT_FILES" I see "DIGITAL_COMMS" is "Y" where "PART_NO" is "<juror_number>"
#	Then on "JUROR" . "POOL" I see "NOTIFICATIONS" is null where "PART_NO" is "<juror_number>"
	
Examples:
|part_no		|pool_no 	|last_name 				|postcode 	|email					|
|645700090		|457170401 	|LNAMENINEZERO			|SA1 4PF	|osman.salah@cgi.com	|

@comms
Scenario Outline: 1st Party Welsh ST, 4 weeks in advance, PNC pass
	Given I am on "Public" "juror-test01"
	Given I have cleared down the juror digital database
	Given the juror numbers have not been processed
	|part_no		|pool_no 	|Owner 		|
	|645700112		|457170401 	|400		|
	Given auto straight through processing has been enabled new schema
	And "<juror_number>" has "RET_DATE" as "4 mondays time"
	And "<juror_number>" has "NEXT_DATE" as "4 mondays time"
#	And I have submitted a first party Welsh straight through response
#	| part_no		|pool_number| last_name		|postcode	| email |
#	|<part_no>		|<pool_no>	| <last_name>	|<postcode>	|<email>|

	And I have submitted a first party English straight through response
	| part_no		|pool_number| last_name		|postcode	| email |
	|<part_no>		|<pool_no>	| <last_name>	|<postcode>	|<email>|

	#Currently an issue with 4 weeks and urgents JDB-4010 (ONLY ON FRIDAY)

	Given I am on "Bureau" "juror-test01"	
	And I log in as "MODTESTBUREAU"
	
	When I click on the "Search" link
	And I set "Juror number" to "<juror_number>"
	And I press the "Search" button
	And I click on "<juror_number>" in the same row as "<juror_number>"
	Then I see "Summoned" on the page
	And I see "Urgent" on the page
	
	#process in Bureau as Responded
	When I select "Responded" from Process reply
	And I check the "Mark juror as 'responded'" checkbox
	And I press the "Confirm" button
	Then I see "Completed" on the page
	
	#DB checks (Do PNC PASS)
	And "<juror_number>" has "POLICE_CHECK" as "P"
	And "<juror_number>" has "PHOENIX_CHECKED" as "C"
	
	#conf letter generated
	Given a confirmation letter is generated for juror "<juror_number>"
		
#	Then on "JUROR" . "PRINT_FILES" I see "FORM_TYPE" is "5224A" where "PART_NO" is "<juror_number>"
#	Then on "JUROR" . "PRINT_FILES" I see "DIGITAL_COMMS" is "Y" where "PART_NO" is "<juror_number>"
#	Then on "JUROR" . "POOL" I see "NOTIFICATIONS" is null where "PART_NO" is "<juror_number>"
	
Examples:
|part_no		|pool_no 	|last_name 			|postcode 	|email				|
|645700112		|457170401 	|LNAMEONEONETWO		|SA1 4PF	|e@mail.com	|

@comms
Scenario Outline: 1st Party Welsh ST, 3 weeks in advance, PNC pass
	Given I am on "Public" "juror-test01"
	Given I have cleared down the juror digital database
	Given the juror numbers have not been processed
	|part_no		|pool_no 	|Owner 		|
	|645700142		|457170401 	|400		|
	Given auto straight through processing has been enabled new schema
	And "<juror_number>" has "RET_DATE" as "3 mondays time"
	And "<juror_number>" has "NEXT_DATE" as "3 mondays time"
	And I have submitted a first party Welsh straight through response
	| part_no		|pool_number| last_name		|postcode	| email |
	|<part_no>		|<pool_no>	| <last_name>	|<postcode>	|<email>|

	Given I am on "Bureau" "juror-test01"	
	And I log in as "MODTESTBUREAU"
	
	When I click on the "Search" link
	And I set "Juror number" to "<juror_number>"
	And I press the "Search" button
	And I click on "<juror_number>" in the same row as "<juror_number>"
	Then I see "Summoned" on the page
	And I see "Urgent" on the page
	
	#process in Bureau as Responded
	When I select "Responded" from Process reply
	And I check the "Mark juror as 'responded'" checkbox
	And I press the "Confirm" button
	Then I see "Completed" on the page
	
	#DB checks (Do PNC PASS)
	And "<juror_number>" has "POLICE_CHECK" as "P"
	And "<juror_number>" has "PHOENIX_CHECKED" as "C"
	
	#conf letter generated
	Given a confirmation letter is generated for juror "<juror_number>"
		
#	Then on "JUROR" . "PRINT_FILES" I see "FORM_TYPE" is "5224A" where "PART_NO" is "<juror_number>"
#	Then on "JUROR" . "PRINT_FILES" I see "DIGITAL_COMMS" is "Y" where "PART_NO" is "<juror_number>"
#	Then on "JUROR" . "POOL" I see "NOTIFICATIONS" is null where "PART_NO" is "<juror_number>"
	
Examples:
|part_no		|pool_no 	|last_name 				|postcode 	|email				|
|645700142		|457170401 	|LNAMEONEFOURTWO		|SA1 4PF	|e@mail.com	|

@comms
Scenario Outline: 1st Party Welsh ST, 2 weeks in advance, PNC pass
	Given I am on "Public" "juror-test01"
	Given I have cleared down the juror digital database
	Given the juror numbers have not been processed
	|part_no		|pool_no 	|Owner 		|
	|<part_no>		|<pool_no> 	|400		|
	Given auto straight through processing has been enabled new schema
	And "<juror_number>" has "RET_DATE" as "2 mondays time"
	And "<juror_number>" has "NEXT_DATE" as "2 mondays time"
	And I have submitted a first party Welsh straight through response
	| part_no		|pool_number| last_name		|postcode	| email |
	|<part_no>		|<pool_no>	| <last_name>	|<postcode>	|<email>|
	
#	And I have submitted a first party English straight through response
#	| part_no		|pool_number| last_name		|postcode	| email |
#	|<part_no>		|<pool_no>	| <last_name>	|<postcode>	|<email>|

	Given I am on "Bureau" "juror-test01"	
	And I log in as "MODTESTBUREAU"
	
	When I click on the "Search" link
	And I set "Juror number" to "<juror_number>"
	And I press the "Search" button
	And I click on "<juror_number>" in the same row as "<juror_number>"
	Then I see "Summoned" on the page
	And I see "Urgent" on the page
	
	#process in Bureau as Responded
	When I select "Responded" from Process reply
	And I check the "Mark juror as 'responded'" checkbox
	And I press the "Confirm" button
	Then I see "Completed" on the page
	
	#DB checks (Do PNC PASS)
	And "<juror_number>" has "POLICE_CHECK" as "P"
	And "<juror_number>" has "PHOENIX_CHECKED" as "C"
	
	#conf letter generated
	Given a confirmation letter is generated for juror "<juror_number>"
	
#	Then on "JUROR" . "PRINT_FILES" I see "FORM_TYPE" is "5224A" where "PART_NO" is "<juror_number>"
#	Then on "JUROR" . "PRINT_FILES" I see "DIGITAL_COMMS" is "Y" where "PART_NO" is "<juror_number>"
#	Then on "JUROR" . "POOL" I see "NOTIFICATIONS" is null where "PART_NO" is "<juror_number>"
	
Examples:
|part_no		|pool_no 	|last_name 				|postcode 	|email				|
|645700174		|457170401 	|LNAMEONESEVENFOUR		|SA1 4PF	|e@mail.com	|

@comms
Scenario Outline: 1st Party Welsh ST, 1 week in advance, PNC pass
	Given I am on "Public" "juror-test01"
	Given I have cleared down the juror digital database
	Given the juror numbers have not been processed
	|part_no		|pool_no 	|Owner 		|
	|645700937		|457170401 	|400		|
	Given auto straight through processing has been enabled new schema
	And "<juror_number>" has "RET_DATE" as "1 mondays time"
	And "<juror_number>" has "NEXT_DATE" as "1 mondays time"
	And "<juror_number>" has "READ_ONLY" as "Y"
	And I have submitted a first party Welsh straight through response
	| part_no		|pool_number| last_name		|postcode	| email |
	|<part_no>		|<pool_no>	| <last_name>	|<postcode>	|<email>|
	
#	And I have submitted a first party English straight through response
#	| part_no		|pool_number| last_name		|postcode	| email |
#	|<part_no>		|<pool_no>	| <last_name>	|<postcode>	|<email>|

	Given I am on "Bureau" "juror-test01"	
	And I log in as "MODTESTBUREAU"
	
	When I click on the "Search" link
	And I set "Juror number" to "<juror_number>"
	And I press the "Search" button
	And I click on "<juror_number>" in the same row as "<juror_number>"
	Then I see "Summoned" on the page
	And I see "Send to court" on the page
	
	#DB checks (Do PNC PASS)
	
#	Then on "JUROR" . "PRINT_FILES" I see "FORM_TYPE" is "5224A" where "PART_NO" is "<juror_number>"
#	Then on "JUROR" . "PRINT_FILES" I see "DIGITAL_COMMS" is "Y" where "PART_NO" is "<juror_number>"
#	Then on "JUROR" . "POOL" I see "NOTIFICATIONS" is null where "PART_NO" is "<juror_number>"
	
Examples:
|part_no		|pool_no 	|last_name 				|postcode 	|email					|
|645700937		|457170401 	|LNAMENINETHREESEVEN	|SA1 4PF	|e@mail.com	|

@comms
Scenario Outline: 1st Party Welsh ST, 1 day in advance, PNC pass
	Given I am on "Public" "juror-test01"
	Given I have cleared down the juror digital database
	Given the juror numbers have not been processed
	|part_no		|pool_no 	|Owner 		|
	|841501931		|415181001 	|400		|
	Given auto straight through processing has been enabled new schema
	And "<juror_number>" has "RET_DATE" as "1 days time"
	And "<juror_number>" has "NEXT_DATE" as "1 days time"
	And "<juror_number>" has "READ_ONLY" as "Y"
	And I have submitted a first party Welsh straight through response
	| part_no		|pool_number| last_name		|postcode	| email |
	|<part_no>		|<pool_no>	| <last_name>	|<postcode>	|<email>|

	Given I am on "Bureau" "juror-test01"	
	And I log in as "MODTESTBUREAU"
	
	When I click on the "Search" link
	And I set "Juror number" to "<juror_number>"
	And I press the "Search" button
	And I click on "<juror_number>" in the same row as "<juror_number>"
	Then I see "Summoned" on the page
	And I see "Send to court" on the page
	
	#DB checks (Do PNC N/A)
	
	Then on "JUROR" . "PRINT_FILES" I see "FORM_TYPE" is "5224A" where "PART_NO" is "<juror_number>"
	Then on "JUROR" . "PRINT_FILES" I see "DIGITAL_COMMS" is "Y" where "PART_NO" is "<juror_number>"
	Then on "JUROR" . "POOL" I see "NOTIFICATIONS" is null where "PART_NO" is "<juror_number>"
	
Examples:
|part_no		|pool_no 	|last_name 				|postcode 	|email					|
|841501931		|415181001 	|LNAME1931				|CH1 2AN	|e@mail.com	|

 @comms
Scenario Outline: 1st Party Deferral accepted, 5 weeks in advance, PNC pass
	Given I am on "Public" "juror-test01"
	Given I have cleared down the juror digital database
	Given the juror numbers have not been processed
	|part_no		|pool_no 	|Owner 		|
	|741500528		|415181001 	|400		|
	Given auto straight through processing has been enabled new schema


	And I have submitted a first party English deferral response
	| part_no		|pool_number| last_name		|postcode	| email |
	|<part_no>		|<pool_no>	| <last_name>	|<postcode>	|<email>|

	Given I am on "Bureau" "juror-test01"	
	And I log in as "MODTESTBUREAU"
	
	When I click on the "Search" link
	And I set "Juror number" to "<juror_number>"
	And I press the "Search" button
	And I click on "<juror_number>" in the same row as "<juror_number>"
	Then I see "Summoned" on the page
	
	When I select "Deferral" from Process reply
	And I set the radio button to "Accept deferral"
	Then I see "Defer until" on the page
	
	When I set "Defer until" to "{7 mondays time}"
	And I select "O - OTHER" from the "Reason for deferral request" dropdown
	And I press the "Mark as completed" button
	Then I see "Completed" on the page
	
	#DB checks (Do PNC PASS)
	And "<juror_number>" has "POLICE_CHECK" as "P"
	And "<juror_number>" has "PHOENIX_CHECKED" as "C"
	
	#deferral letter generated
	Given a deferral letter is generated for juror "<juror_number>"
	
#	Then on "JUROR" . "PRINT_FILES" I see "FORM_TYPE" is "5224A" where "PART_NO" is "<juror_number>"
#	Then on "JUROR" . "PRINT_FILES" I see "DIGITAL_COMMS" is "Y" where "PART_NO" is "<juror_number>"
#	Then on "JUROR" . "POOL" I see "NOTIFICATIONS" is null where "PART_NO" is "<juror_number>"
	
Examples:
|part_no		|pool_no 	|last_name 			|postcode 	|email					|
|741500528		|415181001 	|LNAMEFIVETWOEIGHT	|CH1 2AN	|e@mail.com	|

@comms 
Scenario Outline: 1st Party Deferral refused, 5 weeks in advance, PNC pass
	Given I am on "Public" "juror-test01"
	Given I have cleared down the juror digital database
	Given the juror numbers have not been processed
	|part_no		|pool_no 	|Owner 		|
	|741500533		|415181001 	|400		|
	Given auto straight through processing has been enabled new schema
	And "<juror_number>" has "RET_DATE" as "4 mondays time"
	And "<juror_number>" has "NEXT_DATE" as "4 mondays time"
	And I have submitted a first party English deferral response
	| part_no		|pool_number| last_name		|postcode	| email |
	|<part_no>		|<pool_no>	| <last_name>	|<postcode>	|<email>|

	Given I am on "Bureau" "juror-test01"	
	And I log in as "MODTESTBUREAU"
	
	When I click on the "Search" link
	And I set "Juror number" to "<juror_number>"
	And I press the "Search" button
	And I click on "<juror_number>" in the same row as "<juror_number>"
	Then I see "Summoned" on the page
	
	When I select "Deferral" from Process reply
	And I set the radio button to "Refuse deferral"

	And I select "O - OTHER" from the "Reason for deferral request" dropdown
	And I press the "Mark as completed" button
	Then I see "Completed" on the page
	
	#DB checks (Do PNC PASS)
	And "<juror_number>" has "POLICE_CHECK" as "P"
	And "<juror_number>" has "PHOENIX_CHECKED" as "C"
	
	#def denied and conformation letter generated
#	Given a confirmation letter is generated for juror "<juror_number>"
#	Given a deferral denied letter is generated for juror "<juror_number>"
	
#	Then on "JUROR" . "PRINT_FILES" I see "FORM_TYPE" is "5224A" where "PART_NO" is "<juror_number>"
#	Then on "JUROR" . "PRINT_FILES" I see "DIGITAL_COMMS" is "Y" where "PART_NO" is "<juror_number>"
#	Then on "JUROR" . "POOL" I see "NOTIFICATIONS" is null where "PART_NO" is "<juror_number>"
	
Examples:
|part_no		|pool_no 	|last_name 				|postcode 	|email					|
|741500533		|415181001 	|LNAMEFIVETHREETHREE	|CH1 2AN	|osman.salah@cgi.com	|

@comms 
Scenario Outline: 1st Party Deferral accepted, 4 weeks in advance, PNC pass
	Given I am on "Public" "juror-test01"
	Given I have cleared down the juror digital database
	Given the juror numbers have not been processed
	|part_no		|pool_no 	|Owner 		|
	|741500558		|415181001 	|400		|
	Given auto straight through processing has been enabled new schema
	And "<juror_number>" has "RET_DATE" as "4 mondays time"
	And "<juror_number>" has "NEXT_DATE" as "4 mondays time"
	And I have submitted a first party English deferral response
	| part_no		|pool_number| last_name		|postcode	| email |
	|<part_no>		|<pool_no>	| <last_name>	|<postcode>	|<email>|

	#Currently an issue with 4 weeks and urgents JDB-4010 (ONLY ON FRIDAY)

	Given I am on "Bureau" "juror-test01"	
	And I log in as "MODTESTBUREAU"
	
	When I click on the "Search" link
	And I set "Juror number" to "<juror_number>"
	And I press the "Search" button
	And I click on "<juror_number>" in the same row as "<juror_number>"
	Then I see "Summoned" on the page
	
	When I select "Deferral" from Process reply
	And I set the radio button to "Accept deferral"
	Then I see "Defer until" on the page
	
	When I set "Defer until" to "{7 mondays time}"
	And I select "O - OTHER" from the "Reason for deferral request" dropdown
	And I press the "Mark as completed" button
	Then I see "Completed" on the page
	
	#DB checks (Do PNC PASS)
	And "<juror_number>" has "POLICE_CHECK" as "P"
	And "<juror_number>" has "PHOENIX_CHECKED" as "C"
	
	#deferral letter generated
	Given a deferral letter is generated for juror "<juror_number>"
	
#	Then on "JUROR" . "PRINT_FILES" I see "FORM_TYPE" is "5224A" where "PART_NO" is "<juror_number>"
#	Then on "JUROR" . "PRINT_FILES" I see "DIGITAL_COMMS" is "Y" where "PART_NO" is "<juror_number>"
#	Then on "JUROR" . "POOL" I see "NOTIFICATIONS" is null where "PART_NO" is "<juror_number>"
	
Examples:
|part_no		|pool_no 	|last_name 			|postcode 	|email					|
|741500558		|415181001 	|LNAMEFIVEFIVEEIGHT	|CH1 2AN	|e@mail.com	|

@comms
Scenario Outline: 1st Party Deferral refused, 4 weeks in advance, PNC pass
	Given I am on "Public" "juror-test01"
	Given I have cleared down the juror digital database
	Given the juror numbers have not been processed
	|part_no		|pool_no 	|Owner 		|
	|741500580		|415181001 	|400		|
	Given auto straight through processing has been enabled new schema
	And "<juror_number>" has "RET_DATE" as "4 mondays time"
	And "<juror_number>" has "NEXT_DATE" as "4 mondays time"
	And I have submitted a first party English deferral response
	| part_no		|pool_number| last_name		|postcode	| email |
	|<part_no>		|<pool_no>	| <last_name>	|<postcode>	|<email>|

	#Currently an issue with 4 weeks and urgents JDB-4010 (ONLY ON FRIDAY)

	Given I am on "Bureau" "juror-test01"	
	And I log in as "MODTESTBUREAU"
	
	When I click on the "Search" link
	And I set "Juror number" to "<juror_number>"
	And I press the "Search" button
	And I click on "<juror_number>" in the same row as "<juror_number>"
	Then I see "Summoned" on the page
	And I see "Urgent" on the page
	
	#DB checks (Do PNC PASS)
	
	Then on "JUROR" . "PRINT_FILES" I see "FORM_TYPE" is "5224A" where "PART_NO" is "<juror_number>"
	Then on "JUROR" . "PRINT_FILES" I see "DIGITAL_COMMS" is "Y" where "PART_NO" is "<juror_number>"
	Then on "JUROR" . "POOL" I see "NOTIFICATIONS" is null where "PART_NO" is "<juror_number>"
	
Examples:
|part_no		|pool_no 	|last_name 			|postcode 	|email					|
|741500580		|415181001 	|LNAMEFIVEEIGHTZERO	|CH1 2AN	|e@mail.com	|

@comms
Scenario Outline: 1st Party Deferral accepted, 3 weeks in advance, PNC pass
	Given I am on "Public" "juror-test01"
	Given I have cleared down the juror digital database
	Given the juror numbers have not been processed
	|part_no		|pool_no 	|Owner 		|
	|741500614		|415181001 	|400		|
	Given auto straight through processing has been enabled new schema
	And "<juror_number>" has "RET_DATE" as "3 mondays time"
	And "<juror_number>" has "NEXT_DATE" as "3 mondays time"
	And I have submitted a first party English deferral response
	| part_no		|pool_number| last_name		|postcode	| email |
	|<part_no>		|<pool_no>	| <last_name>	|<postcode>	|<email>|

	Given I am on "Bureau" "juror-test01"	
	And I log in as "MODTESTBUREAU"
	
	When I click on the "Search" link
	And I set "Juror number" to "<juror_number>"
	And I press the "Search" button
	And I click on "<juror_number>" in the same row as "<juror_number>"
	Then I see "Summoned" on the page
	And I see "Urgent" on the page
	
	When I select "Deferral" from Process reply
	And I set the radio button to "Accept deferral"
	Then I see "Defer until" on the page
	
	When I set "Defer until" to "{7 mondays time}"
	And I select "O - OTHER" from the "Reason for deferral request" dropdown
	And I press the "Mark as completed" button
	Then I see "Completed" on the page
	
	#DB checks (Do PNC PASS)
	And "<juror_number>" has "POLICE_CHECK" as "P"
	And "<juror_number>" has "PHOENIX_CHECKED" as "C"
	
	#deferral letter generated
	Given a deferral letter is generated for juror "<juror_number>"
	
#	Then on "JUROR" . "PRINT_FILES" I see "FORM_TYPE" is "5224A" where "PART_NO" is "<juror_number>"
#	Then on "JUROR" . "PRINT_FILES" I see "DIGITAL_COMMS" is "Y" where "PART_NO" is "<juror_number>"
#	Then on "JUROR" . "POOL" I see "NOTIFICATIONS" is null where "PART_NO" is "<juror_number>"
	
Examples:
|part_no		|pool_no 	|last_name 			|postcode 	|email					|
|741500614		|415181001 	|LNAMESIXONEFOUR	|CH1 2AN	|e@mail.com	|

@comms
Scenario Outline: 1st Party Deferral refused, 3 weeks in advance, PNC pass
	Given I am on "Public" "juror-test01"
	Given I have cleared down the juror digital database
	Given the juror numbers have not been processed
	|part_no		|pool_no 	|Owner 		|
	|741500627		|415181001 	|400		|
	Given auto straight through processing has been enabled new schema
	And "<juror_number>" has "RET_DATE" as "3 mondays time"
	And "<juror_number>" has "NEXT_DATE" as "3 mondays time"
	And I have submitted a first party English deferral response
	| part_no		|pool_number| last_name		|postcode	| email |
	|<part_no>		|<pool_no>	| <last_name>	|<postcode>	|<email>|

	Given I am on "Bureau" "juror-test01"	
	And I log in as "MODTESTBUREAU"
	
	When I click on the "Search" link
	And I set "Juror number" to "<juror_number>"
	And I press the "Search" button
	And I click on "<juror_number>" in the same row as "<juror_number>"
	Then I see "Summoned" on the page
	And I see "Urgent" on the page
	
	#DB checks (Do PNC PASS)
	
	Then on "JUROR" . "PRINT_FILES" I see "FORM_TYPE" is "5224A" where "PART_NO" is "<juror_number>"
	Then on "JUROR" . "PRINT_FILES" I see "DIGITAL_COMMS" is "Y" where "PART_NO" is "<juror_number>"
	Then on "JUROR" . "POOL" I see "NOTIFICATIONS" is null where "PART_NO" is "<juror_number>"
	
Examples:
|part_no		|pool_no 	|last_name 			|postcode 	|email					|
|741500627		|415181001 	|LNAMESIXTWOSEVEN	|CH1 2AN	|e@mail.com	|

@comms
Scenario Outline: 1st Party Deferral accepted, 2 weeks in advance, PNC pass
	Given I am on "Public" "juror-test01"
	Given I have cleared down the juror digital database
	Given the juror numbers have not been processed
	|part_no		|pool_no 	|Owner 		|
	|741500657		|415181001 	|400		|
	Given auto straight through processing has been enabled new schema
	And "<juror_number>" has "RET_DATE" as "2 mondays time"
	And "<juror_number>" has "NEXT_DATE" as "2 mondays time"
	And I have submitted a first party English deferral response
	| part_no		|pool_number| last_name		|postcode	| email |
	|<part_no>		|<pool_no>	| <last_name>	|<postcode>	|<email>|

	Given I am on "Bureau" "juror-test01"	
	And I log in as "MODTESTBUREAU"
	
	When I click on the "Search" link
	And I set "Juror number" to "<juror_number>"
	And I press the "Search" button
	And I click on "<juror_number>" in the same row as "<juror_number>"
	Then I see "Summoned" on the page
	And I see "Urgent" on the page
	
	When I select "Deferral" from Process reply
	And I set the radio button to "Accept deferral"
	Then I see "Defer until" on the page
	
	When I set "Defer until" to "{7 mondays time}"
	And I select "O - OTHER" from the "Reason for deferral request" dropdown
	And I press the "Mark as completed" button
	Then I see "Completed" on the page
	
	#DB checks (Do PNC PASS)
	And "<juror_number>" has "POLICE_CHECK" as "P"
	And "<juror_number>" has "PHOENIX_CHECKED" as "C"
	
	#deferral letter generated
	Given a deferral letter is generated for juror "<juror_number>"
	
#	Then on "JUROR" . "PRINT_FILES" I see "FORM_TYPE" is "5224A" where "PART_NO" is "<juror_number>"
#	Then on "JUROR" . "PRINT_FILES" I see "DIGITAL_COMMS" is "Y" where "PART_NO" is "<juror_number>"
#	Then on "JUROR" . "POOL" I see "NOTIFICATIONS" is null where "PART_NO" is "<juror_number>"
	
Examples:
|part_no		|pool_no 	|last_name 			|postcode 	|email					|
|741500657		|415181001 	|LNAMESIXFIVESEVEN	|CH1 2AN	|e@mail.com	|

@comms
Scenario Outline: 1st Party Deferral refused, 2 weeks in advance, PNC pass
	Given I am on "Public" "juror-test01"
	Given I have cleared down the juror digital database
	Given the juror numbers have not been processed
	|part_no		|pool_no 	|Owner 		|
	|741500674		|415181001 	|400		|
	Given auto straight through processing has been enabled new schema
	And "<juror_number>" has "RET_DATE" as "2 mondays time"
	And "<juror_number>" has "NEXT_DATE" as "2 mondays time"
	And I have submitted a first party English deferral response
	| part_no		|pool_number| last_name		|postcode	| email |
	|<part_no>		|<pool_no>	| <last_name>	|<postcode>	|<email>|

	Given I am on "Bureau" "juror-test01"	
	And I log in as "MODTESTBUREAU"
	
	When I click on the "Search" link
	And I set "Juror number" to "<juror_number>"
	And I press the "Search" button
	And I click on "<juror_number>" in the same row as "<juror_number>"
	Then I see "Summoned" on the page
	And I see "Urgent" on the page
	
	#DB checks (Do PNC PASS)
	
	Then on "JUROR" . "PRINT_FILES" I see "FORM_TYPE" is "5224A" where "PART_NO" is "<juror_number>"
	Then on "JUROR" . "PRINT_FILES" I see "DIGITAL_COMMS" is "Y" where "PART_NO" is "<juror_number>"
	Then on "JUROR" . "POOL" I see "NOTIFICATIONS" is null where "PART_NO" is "<juror_number>"
	
Examples:
|part_no		|pool_no 	|last_name 			|postcode 	|email					|
|741500674		|415181001 	|LNAMESIXSEVENFOUR	|CH1 2AN	|e@mail.com	|

@comms
Scenario Outline: 1st Party Deferral accepted, 1 week in advance, PNC pass
	Given I am on "Public" "juror-test01"
	Given I have cleared down the juror digital database
	Given the juror numbers have not been processed
	|part_no		|pool_no 	|Owner 		|
	|741500779		|415181001 	|400		|
	Given auto straight through processing has been enabled new schema
	And "<juror_number>" has "RET_DATE" as "1 mondays time"
	And "<juror_number>" has "NEXT_DATE" as "1 mondays time"
	And "<juror_number>" has "READ_ONLY" as "Y"
	And I have submitted a first party English deferral response
	| part_no		|pool_number| last_name		|postcode	| email |
	|<part_no>		|<pool_no>	| <last_name>	|<postcode>	|<email>|

	Given I am on "Bureau" "juror-test01"	
	And I log in as "MODTESTBUREAU"
	
	When I click on the "Search" link
	And I set "Juror number" to "<juror_number>"
	And I press the "Search" button
	And I click on "<juror_number>" in the same row as "<juror_number>"
	Then I see "Summoned" on the page
	And I see "Send to court" on the page
	
	#DB checks (Do PNC PASS)
	
	Then on "JUROR" . "PRINT_FILES" I see "FORM_TYPE" is "5224A" where "PART_NO" is "<juror_number>"
	Then on "JUROR" . "PRINT_FILES" I see "DIGITAL_COMMS" is "Y" where "PART_NO" is "<juror_number>"
	Then on "JUROR" . "POOL" I see "NOTIFICATIONS" is null where "PART_NO" is "<juror_number>"
	
Examples:
|part_no		|pool_no 	|last_name 				|postcode 	|email					|
|741500779		|415181001 	|LNAMESEVENSEVENNINE	|CH1 2AN	|e@mail.com	|

@comms
Scenario Outline: 1st Party Deferral refused, 1 week in advance, PNC pass
	Given I am on "Public" "juror-test01"
	Given I have cleared down the juror digital database
	Given the juror numbers have not been processed
	|part_no		|pool_no 	|Owner 		|
	|741500790		|415181001 	|400		|
	Given auto straight through processing has been enabled new schema
	And "<juror_number>" has "RET_DATE" as "1 mondays time"
	And "<juror_number>" has "NEXT_DATE" as "1 mondays time"
	And "<juror_number>" has "READ_ONLY" as "Y"
	And I have submitted a first party English deferral response
	| part_no		|pool_number| last_name		|postcode	| email |
	|<part_no>		|<pool_no>	| <last_name>	|<postcode>	|<email>|

	Given I am on "Bureau" "juror-test01"	
	And I log in as "MODTESTBUREAU"
	
	When I click on the "Search" link
	And I set "Juror number" to "<juror_number>"
	And I press the "Search" button
	And I click on "<juror_number>" in the same row as "<juror_number>"
	Then I see "Summoned" on the page
	And I see "Send to court" on the page
	
	#DB checks (Do PNC PASS)
	
	Then on "JUROR" . "PRINT_FILES" I see "FORM_TYPE" is "5224A" where "PART_NO" is "<juror_number>"
	Then on "JUROR" . "PRINT_FILES" I see "DIGITAL_COMMS" is "Y" where "PART_NO" is "<juror_number>"
	Then on "JUROR" . "POOL" I see "NOTIFICATIONS" is null where "PART_NO" is "<juror_number>"
	
Examples:
|part_no		|pool_no 	|last_name 			|postcode 	|email					|
|741500790		|415181001 	|LNAMESEVENNINEZERO	|CH1 2AN	|e@mail.com	|

@comms
Scenario Outline: 1st Party Excusal accepted, 5 weeks in advance, PNC pass
	Given I am on "Public" "juror-test01"
	Given I have cleared down the juror digital database
	Given the juror numbers have not been processed
	|part_no		|pool_no 	|Owner 		|
	|741500795		|415181001 	|400		|
	Given auto straight through processing has been enabled new schema


	And I have submitted a first party English excusal response
	| part_no		|pool_number| last_name		|postcode	| email |
	|<part_no>		|<pool_no>	| <last_name>	|<postcode>	|<email>|

	Given I am on "Bureau" "juror-test01"	
	And I log in as "MODTESTBUREAU"
	
	When I click on the "Search" link
	And I set "Juror number" to "<juror_number>"
	And I press the "Search" button
	And I click on "<juror_number>" in the same row as "<juror_number>"
	Then I see "Summoned" on the page
	
	#process in Bureau as Excused
	When I select "Excusal" from Process reply
	And I set the radio button to "Accept excusal"
	And I select "OTHER" from the "Reason for excusal request" dropdown
	And I press the "Mark as completed" button
	Then I see "Completed" on the page
	
	#DB checks (Do PNC PASS)
	And "<juror_number>" has "POLICE_CHECK" as "P"
	And "<juror_number>" has "PHOENIX_CHECKED" as "C"
	
	#excusal letter generated
	Given an excusal letter is generated for juror "<juror_number>"
	
#	Then on "JUROR" . "PRINT_FILES" I see "FORM_TYPE" is "5224A" where "PART_NO" is "<juror_number>"
#	Then on "JUROR" . "PRINT_FILES" I see "DIGITAL_COMMS" is "Y" where "PART_NO" is "<juror_number>"
#	Then on "JUROR" . "POOL" I see "NOTIFICATIONS" is null where "PART_NO" is "<juror_number>"
	
Examples:
|part_no		|pool_no 	|last_name 			|postcode 	|email					|
|741500795		|415181001 	|LNAMESEVENNINEFIVE	|CH1 2AN	|e@mail.com	|

@comms 
Scenario Outline: 1st Party Excusal refused, 5 weeks in advance, PNC pass
	Given I am on "Public" "juror-test01"
	Given I have cleared down the juror digital database
	Given the juror numbers have not been processed
	|part_no		|pool_no 	|Owner 		|
	|741500827		|415181001  |400		|
	Given auto straight through processing has been enabled new schema
	And "<juror_number>" has "RET_DATE" as "3 mondays time"
	And "<juror_number>" has "NEXT_DATE" as "3 mondays time"
	And I have submitted a first party English excusal response
	| part_no		|pool_number| last_name		|postcode	| email |
	|<part_no>		|<pool_no>	| <last_name>	|<postcode>	|<email>|

	Given I am on "Bureau" "juror-test01"	
	And I log in as "MODTESTBUREAU"
	
	When I click on the "Search" link
	And I set "Juror number" to "<juror_number>"
	And I press the "Search" button
	And I click on "<juror_number>" in the same row as "<juror_number>"
	Then I see "Summoned" on the page
	
	#process in Bureau as Excused
	When I select "Excusal" from Process reply
	And I set the radio button to "Refuse excusal"
	And I select "OTHER" from the "Reason for excusal request" dropdown
	And I press the "Mark as completed" button
	Then I see "Completed" on the page
	
	#DB checks (Do PNC PASS)
	And "<juror_number>" has "POLICE_CHECK" as "P"
	And "<juror_number>" has "PHOENIX_CHECKED" as "C"
	
	#refuse excusal letter generated
	Given an excusal denied letter is generated for juror "<juror_number>"
	Given a confirmation letter is generated for juror "<juror_number>"
	
#	Then on "JUROR" . "PRINT_FILES" I see "FORM_TYPE" is "5224A" where "PART_NO" is "<juror_number>"
#	Then on "JUROR" . "PRINT_FILES" I see "DIGITAL_COMMS" is "Y" where "PART_NO" is "<juror_number>"
#	Then on "JUROR" . "POOL" I see "NOTIFICATIONS" is null where "PART_NO" is "<juror_number>"
	
Examples:
|part_no		|pool_no 	|last_name 				|postcode 	|email					|
|741500827		|415181001 	|LNAMEEIGHTTWOSEVEN		|CH1 2AN	|e@mail.com	|

@comms 
Scenario Outline: 1st Party Excusal accepted, 4 weeks in advance, PNC pass
	Given I am on "Public" "juror-test01"
	Given I have cleared down the juror digital database
	Given the juror numbers have not been processed
	|part_no		|pool_no 	|Owner 		|
	|741500520		|415181001 	|400		|
	Given auto straight through processing has been enabled new schema
	And "<juror_number>" has "RET_DATE" as "4 mondays time"
	And "<juror_number>" has "NEXT_DATE" as "4 mondays time"
	And I have submitted a first party English excusal response
	| part_no		|pool_number| last_name		|postcode	| email |
	|<part_no>		|<pool_no>	| <last_name>	|<postcode>	|<email>|

	#Currently an issue with 4 weeks and urgents JDB-4010 (ONLY ON FRIDAY)

	Given I am on "Bureau" "juror-test01"	
	And I log in as "MODTESTBUREAU"
	
	When I click on the "Search" link
	And I set "Juror number" to "<juror_number>"
	And I press the "Search" button
	And I click on "<juror_number>" in the same row as "<juror_number>"
	Then I see "Summoned" on the page
	
	#process in Bureau as Excused
	When I select "Excusal" from Process reply
	And I set the radio button to "Accept excusal"
	And I select "OTHER" from the "Reason for excusal request" dropdown
	And I press the "Mark as completed" button
	Then I see "Completed" on the page
	
	#DB checks (Do PNC PASS)
	And "<juror_number>" has "POLICE_CHECK" as "P"
	And "<juror_number>" has "PHOENIX_CHECKED" as "C"
	
	#excusal letter generated
	Given an excusal letter is generated for juror "<juror_number>"
	
#	Then on "JUROR" . "PRINT_FILES" I see "FORM_TYPE" is "5224A" where "PART_NO" is "<juror_number>"
#	Then on "JUROR" . "PRINT_FILES" I see "DIGITAL_COMMS" is "Y" where "PART_NO" is "<juror_number>"
#	Then on "JUROR" . "POOL" I see "NOTIFICATIONS" is null where "PART_NO" is "<juror_number>"
	
Examples:
|part_no		|pool_no 	|last_name 			|postcode 	|email				|
|741500520		|415181001 	|LNAMEFIVETWOZERO	|CH1 2AN	|e@mail.com	|

@comms 
Scenario Outline: 1st Party Excusal refused, 4 weeks in advance, PNC pass
	Given I am on "Public" "juror-test01"
	Given I have cleared down the juror digital database
	Given the juror numbers have not been processed
	|part_no		|pool_no 	|Owner 		|
	|<part_no>		|<pool_no> 	|400		|
	Given auto straight through processing has been enabled new schema
	And "<juror_number>" has "RET_DATE" as "4 mondays time"
	And "<juror_number>" has "NEXT_DATE" as "4 mondays time"
	And I have submitted a first party English excusal response
	| part_no		|pool_number| last_name		|postcode	| email |
	|<part_no>		|<pool_no>	| <last_name>	|<postcode>	|<email>|

	#Currently an issue with 4 weeks and urgents JDB-4010 (ONLY ON FRIDAY)

	Given I am on "Bureau" "juror-test01"	
	And I log in as "MODTESTBUREAU"
	
	When I click on the "Search" link
	And I set "Juror number" to "<juror_number>"
	And I press the "Search" button
	And I click on "<juror_number>" in the same row as "<juror_number>"
	Then I see "Summoned" on the page
	And I see "Urgent" on the page
	
	#DB checks (Do PNC PASS)
	
#	Then on "JUROR" . "PRINT_FILES" I see "FORM_TYPE" is "5224A" where "PART_NO" is "<juror_number>"
#	Then on "JUROR" . "PRINT_FILES" I see "DIGITAL_COMMS" is "Y" where "PART_NO" is "<juror_number>"
#	Then on "JUROR" . "POOL" I see "NOTIFICATIONS" is null where "PART_NO" is "<juror_number>"
	
Examples:
|part_no		|pool_no 	|last_name 			|postcode 	|email					|
|741500701		|415181001 	|LNAMESEVENZEROONE	|CH1 2AN	|e@mail.com	|

@comms 
Scenario Outline: 1st Party Excusal accepted, 3 weeks in advance, PNC pass
	Given I am on "Public" "juror-test01"
	Given I have cleared down the juror digital database
	Given the juror numbers have not been processed
	|part_no		|pool_no 	|Owner 		|
	|741500473		|415181001 	|400		|
	Given auto straight through processing has been enabled new schema
	And "<juror_number>" has "RET_DATE" as "3 mondays time"
	And "<juror_number>" has "NEXT_DATE" as "3 mondays time"
	And I have submitted a first party English excusal response
	| part_no		|pool_number| last_name		|postcode	| email |
	|<part_no>		|<pool_no>	| <last_name>	|<postcode>	|<email>|

	Given I am on "Bureau" "juror-test01"	
	And I log in as "MODTESTBUREAU"
	
	When I click on the "Search" link
	And I set "Juror number" to "<juror_number>"
	And I press the "Search" button
	And I click on "<juror_number>" in the same row as "<juror_number>"
	Then I see "Summoned" on the page
	And I see "Urgent" on the page
	
	#process in Bureau as Excused
	When I select "Excusal" from Process reply
	And I set the radio button to "Accept excusal"
	And I select "OTHER" from the "Reason for excusal request" dropdown
	And I press the "Mark as completed" button
	Then I see "Completed" on the page
	
	#DB checks (Do PNC PASS)
	And "<juror_number>" has "POLICE_CHECK" as "P"
	And "<juror_number>" has "PHOENIX_CHECKED" as "C"
	
	#excusal letter generated
	Given an excusal letter is generated for juror "<juror_number>"
	
#	Then on "JUROR" . "PRINT_FILES" I see "FORM_TYPE" is "5224A" where "PART_NO" is "<juror_number>"
#	Then on "JUROR" . "PRINT_FILES" I see "DIGITAL_COMMS" is "Y" where "PART_NO" is "<juror_number>"
#	Then on "JUROR" . "POOL" I see "NOTIFICATIONS" is null where "PART_NO" is "<juror_number>"
	
Examples:
|part_no		|pool_no 	|last_name 				|postcode 	|email					|
|741500473		|415181001 	|LNAMEFOURSEVENTHREE	|CH1 2AN	|e@mail.com	|

@comms
Scenario Outline: 1st Party Excusal refused, 3 weeks in advance, PNC pass
	Given I am on "Public" "juror-test01"
	Given I have cleared down the juror digital database
	Given the juror numbers have not been processed
	|part_no		|pool_no 	|Owner 		|
	|841500029		|415181001 	|400		|
	Given auto straight through processing has been enabled new schema
	And "<juror_number>" has "RET_DATE" as "3 mondays time"
	And "<juror_number>" has "NEXT_DATE" as "3 mondays time"
	And I have submitted a first party English excusal response
	| part_no		|pool_number| last_name		|postcode	| email |
	|<part_no>		|<pool_no>	| <last_name>	|<postcode>	|<email>|

	Given I am on "Bureau" "juror-test01"	
	And I log in as "MODTESTBUREAU"
	
	When I click on the "Search" link
	And I set "Juror number" to "<juror_number>"
	And I press the "Search" button
	And I click on "<juror_number>" in the same row as "<juror_number>"
	Then I see "Summoned" on the page
	And I see "Urgent" on the page
	
	#DB checks (Do PNC PASS)
	
	Then on "JUROR" . "PRINT_FILES" I see "FORM_TYPE" is "5224A" where "PART_NO" is "<juror_number>"
	Then on "JUROR" . "PRINT_FILES" I see "DIGITAL_COMMS" is "Y" where "PART_NO" is "<juror_number>"
	Then on "JUROR" . "POOL" I see "NOTIFICATIONS" is null where "PART_NO" is "<juror_number>"
	
Examples:
|part_no		|pool_no 	|last_name 	|postcode 	|email					|
|841500029		|415181001 	|LNAME29	|CH1 2AN	|e@mail.com	|

@comms
Scenario Outline: 1st Party Excusal accepted, 2 weeks in advance, PNC pass
	Given I am on "Public" "juror-test01"
	Given I have cleared down the juror digital database
	Given the juror numbers have not been processed
	|part_no		|pool_no 	|Owner 		|
	|841500034		|415181001 	|400		|
	Given auto straight through processing has been enabled new schema
	And "<juror_number>" has "RET_DATE" as "2 mondays time"
	And "<juror_number>" has "NEXT_DATE" as "2 mondays time"
	And I have submitted a first party English excusal response
	| part_no		|pool_number| last_name		|postcode	| email |
	|<part_no>		|<pool_no>	| <last_name>	|<postcode>	|<email>|

	Given I am on "Bureau" "juror-test01"	
	And I log in as "MODTESTBUREAU"
	
	When I click on the "Search" link
	And I set "Juror number" to "<juror_number>"
	And I press the "Search" button
	And I click on "<juror_number>" in the same row as "<juror_number>"
	Then I see "Summoned" on the page
	And I see "Urgent" on the page
	
	#process in Bureau as Excused
	When I select "Excusal" from Process reply
	And I set the radio button to "Accept excusal"
	And I select "OTHER" from the "Reason for excusal request" dropdown
	And I press the "Mark as completed" button
	Then I see "Completed" on the page
	
	#DB checks (Do PNC PASS)
	And "<juror_number>" has "POLICE_CHECK" as "P"
	And "<juror_number>" has "PHOENIX_CHECKED" as "C"
	
	#excusal letter generated
	Given an excusal letter is generated for juror "<juror_number>"
	
#	Then on "JUROR" . "PRINT_FILES" I see "FORM_TYPE" is "5224A" where "PART_NO" is "<juror_number>"
#	Then on "JUROR" . "PRINT_FILES" I see "DIGITAL_COMMS" is "Y" where "PART_NO" is "<juror_number>"
#	Then on "JUROR" . "POOL" I see "NOTIFICATIONS" is null where "PART_NO" is "<juror_number>"
	
Examples:
|part_no		|pool_no 	|last_name 	|postcode 	|email					|
|841500034		|415181001 	|LNAME34	|CH1 2AN	|e@mail.com	|

@comms
Scenario Outline: 1st Party Excusal refused, 2 weeks in advance, PNC pass
	Given I am on "Public" "juror-test01"
	Given I have cleared down the juror digital database
	Given the juror numbers have not been processed
	|part_no		|pool_no 	|Owner 		|
	|841500038		|415181001 	|400		|
	Given auto straight through processing has been enabled new schema
	And "<juror_number>" has "RET_DATE" as "2 mondays time"
	And "<juror_number>" has "NEXT_DATE" as "2 mondays time"
	And I have submitted a first party English excusal response
	| part_no		|pool_number| last_name		|postcode	| email |
	|<part_no>		|<pool_no>	| <last_name>	|<postcode>	|<email>|

	Given I am on "Bureau" "juror-test01"	
	And I log in as "MODTESTBUREAU"
	
	When I click on the "Search" link
	And I set "Juror number" to "<juror_number>"
	And I press the "Search" button
	And I click on "<juror_number>" in the same row as "<juror_number>"
	Then I see "Summoned" on the page
	And I see "Urgent" on the page
	
	#DB checks (Do PNC PASS)
	
	Then on "JUROR" . "PRINT_FILES" I see "FORM_TYPE" is "5224A" where "PART_NO" is "<juror_number>"
	Then on "JUROR" . "PRINT_FILES" I see "DIGITAL_COMMS" is "Y" where "PART_NO" is "<juror_number>"
	Then on "JUROR" . "POOL" I see "NOTIFICATIONS" is null where "PART_NO" is "<juror_number>"
	
Examples:
|part_no		|pool_no 	|last_name 	|postcode 	|email					|
|841500038		|415181001 	|LNAME38	|CH1 2AN	|e@mail.com	|

@comms
Scenario Outline: 1st Party Excusal accepted, 1 week in advance, PNC pass
	Given I am on "Public" "juror-test01"
	Given I have cleared down the juror digital database
	Given the juror numbers have not been processed
	|part_no		|pool_no 	|Owner 		|
	|841501637		|415181001 	|400		|
	Given auto straight through processing has been enabled new schema
	And "<juror_number>" has "RET_DATE" as "1 mondays time"
	And "<juror_number>" has "NEXT_DATE" as "1 mondays time"
	And "<juror_number>" has "READ_ONLY" as "Y"
	And I have submitted a first party English excusal response
	| part_no		|pool_number| last_name		|postcode	| email |
	|<part_no>		|<pool_no>	| <last_name>	|<postcode>	|<email>|

	Given I am on "Bureau" "juror-test01"	
	And I log in as "MODTESTBUREAU"
	
	When I click on the "Search" link
	And I set "Juror number" to "<juror_number>"
	And I press the "Search" button
	And I click on "<juror_number>" in the same row as "<juror_number>"
	Then I see "Summoned" on the page
	And I see "Send to court" on the page
	
	#DB checks (Do PNC PASS)
	
	Then on "JUROR" . "PRINT_FILES" I see "FORM_TYPE" is "5224A" where "PART_NO" is "<juror_number>"
	Then on "JUROR" . "PRINT_FILES" I see "DIGITAL_COMMS" is "Y" where "PART_NO" is "<juror_number>"
	Then on "JUROR" . "POOL" I see "NOTIFICATIONS" is null where "PART_NO" is "<juror_number>"
	
Examples:
|part_no		|pool_no 	|last_name 	|postcode 	|email					|
|841501637		|415181001 	|LNAME1637	|CH1 2AN	|e@mail.com	|

@comms 
Scenario Outline: 1st Party Excusal refused, 1 week in advance, PNC pass
	Given I am on "Public" "juror-test01"
	Given I have cleared down the juror digital database
	Given the juror numbers have not been processed
	|part_no		|pool_no 	|Owner 		|
	|841501641		|415181001 	|400		|
	Given auto straight through processing has been enabled new schema
	And "<juror_number>" has "RET_DATE" as "1 mondays time"
	And "<juror_number>" has "NEXT_DATE" as "1 mondays time"
	And "<juror_number>" has "READ_ONLY" as "Y"
	And I have submitted a first party English excusal response
	| part_no		|pool_number| last_name		|postcode	| email |
	|<part_no>		|<pool_no>	| <last_name>	|<postcode>	|<email>|

	Given I am on "Bureau" "juror-test01"	
	And I log in as "MODTESTBUREAU"
	
	When I click on the "Search" link
	And I set "Juror number" to "<juror_number>"
	And I press the "Search" button
	And I click on "<juror_number>" in the same row as "<juror_number>"
#	Then I see "Summoned" on the page
	And I see "Send to court" on the page
	
	#DB checks (Do PNC PASS)
	
#	Then on "JUROR" . "PRINT_FILES" I see "FORM_TYPE" is "5224A" where "PART_NO" is "<juror_number>"
#	Then on "JUROR" . "PRINT_FILES" I see "DIGITAL_COMMS" is "Y" where "PART_NO" is "<juror_number>"
#	Then on "JUROR" . "POOL" I see "NOTIFICATIONS" is null where "PART_NO" is "<juror_number>"
	
Examples:
|part_no		|pool_no 	|last_name 	|postcode 	|email					|
|841501641		|415181001 	|LNAME1641	|CH1 2AN	|e@mail.com	|

@comms
Scenario Outline: 1st Party Disqualify, 5 weeks in advance, PNC n/a
	Given I am on "Public" "juror-test01"
	Given I have cleared down the juror digital database
	Given the juror numbers have not been processed
	|part_no		|pool_no 	|Owner 		|
	|841501651		|415181001 	|400		|
	Given auto straight through processing has been enabled new schema


	And I have submitted a first party English ineligibilty response
	| part_no		|pool_number| last_name		|postcode	| email |
	|<part_no>		|<pool_no>	| <last_name>	|<postcode>	|<email>|
	
	Then I see "You have completed your reply" on the page
	Then I see "If we get in touch with you, you may need to give your juror number. It's also on the letter we sent you." on the page
	Then I see "We have sent you an email to say you have replied to your jury summons." on the page
	Then I see "Download a copy of your summons reply" on the page
	Then I see "What happens next" on the page
	Then I see "We'll now check your answers. Your answers might mean that you are not able to do jury service." on the page
	Then I see "We'll write to you in the next 7 days to let you know if you are able to do jury service." on the page
	Then I see "If you can do jury service, at least 2 weeks before it starts we’ll send you:" on the page
	Then I see "a letter confirming the date of your jury service" on the page
	Then I see "an information pack about being a juror and the court you're going to" on the page
	Then I see "Get ready for your jury service" on the page
	Then I see "The information below is also in the email that we have sent you." on the page
	Then I see "You can watch this video on YouTube about what happens when you're a juror, so you know what to expect. The video takes 13 minutes to watch." on the page
	Then I see "Learn more about your jury service. You can read the rules about discussing the trial and find out how to claim expenses." on the page
	Then I do not see "Your Guide to Jury Service (PDF 85KB)" on the page
	Then I see "What did you think of this service? (Takes 30 seconds)" on the page

	Given I am on "Bureau" "juror-test01"	
	And I log in as "MODTESTBUREAU"
	
	When I click on the "Search" link
	And I set "Juror number" to "<juror_number>"
	And I press the "Search" button
	And I click on "<juror_number>" in the same row as "<juror_number>"
	Then I see "Summoned" on the page
	
	When I select "Disqualified" from Process reply
	When I set the radio button to "M - Suffering From a Mental Disorder"
	And I press the "Mark as completed" button
	Then I see "Completed" on the page
	
	#disqualify letter generated
	Given a disqualified letter is generated for juror "<juror_number>"
	
#	Then on "JUROR" . "PRINT_FILES" I see "FORM_TYPE" is "5224A" where "PART_NO" is "<juror_number>"
#	Then on "JUROR" . "PRINT_FILES" I see "DIGITAL_COMMS" is "Y" where "PART_NO" is "<juror_number>"
#	Then on "JUROR" . "POOL" I see "NOTIFICATIONS" is null where "PART_NO" is "<juror_number>"
	
Examples:
|part_no		|pool_no 	|last_name 			|postcode 	|email				|
|841501651		|415181001 	|LNAME1651			|CH1 2AN	|e@mail.com	|

@comms
Scenario Outline: 1st Party Ineligible, 2 weeks in advance, PNC n/a
	Given I am on "Public" "juror-test01"
	Given I have cleared down the juror digital database
	Given the juror numbers have not been processed
	|part_no		|pool_no 	|Owner 		|
	|841501672		|415181001 	|400		|
	Given auto straight through processing has been enabled new schema
	And "<juror_number>" has "RET_DATE" as "2 mondays time"
	And "<juror_number>" has "NEXT_DATE" as "2 mondays time"
	And I have submitted a first party English ineligibilty response
	| part_no		|pool_number| last_name		|postcode	| email |
	|<part_no>		|<pool_no>	| <last_name>	|<postcode>	|<email>|

	Given I am on "Bureau" "juror-test01"	
	And I log in as "MODTESTBUREAU"
	
	When I click on the "Search" link
	And I set "Juror number" to "<juror_number>"
	And I press the "Search" button
	And I click on "<juror_number>" in the same row as "<juror_number>"
	Then I see "Summoned" on the page
	And I see "Urgent" on the page
	
	#DB checks (Do PNC N/A)
	
	Then on "JUROR" . "PRINT_FILES" I see "FORM_TYPE" is "5224A" where "PART_NO" is "<juror_number>"
	Then on "JUROR" . "PRINT_FILES" I see "DIGITAL_COMMS" is "Y" where "PART_NO" is "<juror_number>"
	Then on "JUROR" . "POOL" I see "NOTIFICATIONS" is null where "PART_NO" is "<juror_number>"
	
Examples:
|part_no		|pool_no 	|last_name 			|postcode 	|email					|
|841501672		|415181001 	|LNAME1672			|CH1 2AN	|e@mail.com	|

@comms
Scenario Outline: 1st Party Ineligible, 1 week in advance, PNC n/a
	Given I am on "Public" "juror-test01"
	Given I have cleared down the juror digital database
	Given the juror numbers have not been processed
	|part_no		|pool_no 	|Owner 		|
	|841501673		|415181001 	|400		|
	Given auto straight through processing has been enabled new schema
	And "<juror_number>" has "RET_DATE" as "1 mondays time"
	And "<juror_number>" has "NEXT_DATE" as "1 mondays time"
	And "<juror_number>" has "READ_ONLY" as "Y"
	And I have submitted a first party English ineligibilty response
	| part_no		|pool_number| last_name		|postcode	| email |
	|<part_no>		|<pool_no>	| <last_name>	|<postcode>	|<email>|

	Given I am on "Bureau" "juror-test01"	
	And I log in as "MODTESTBUREAU"
	
	When I click on the "Search" link
	And I set "Juror number" to "<juror_number>"
	And I press the "Search" button
	And I click on "<juror_number>" in the same row as "<juror_number>"
	Then I see "Summoned" on the page
	And I see "Send to court" on the page
	
	#DB checks (Do PNC N/A)
	
	Then on "JUROR" . "PRINT_FILES" I see "FORM_TYPE" is "5224A" where "PART_NO" is "<juror_number>"
	Then on "JUROR" . "PRINT_FILES" I see "DIGITAL_COMMS" is "Y" where "PART_NO" is "<juror_number>"
	Then on "JUROR" . "POOL" I see "NOTIFICATIONS" is null where "PART_NO" is "<juror_number>"
	
Examples:
|part_no		|pool_no 	|last_name 			|postcode 	|email					|
|841501673		|415181001 	|LNAME1673			|CH1 2AN	|e@mail.com	|

@comms 
Scenario Outline: 3rd Party Deceased, 5 weeks in advance, PNC n/a
	Given I am on "Public" "juror-test01"
	Given I have cleared down the juror digital database
	Given the juror numbers have not been processed
	|part_no		|pool_no 	|Owner 		|
	|645100496		|451170401 	|400		|
	Given auto straight through processing has been enabled new schema


	And I have submitted a third party English deceased response
	| part_no		|pool_number| last_name		|postcode	| email |
	|<part_no>		|<pool_no>	| <last_name>	|<postcode>	|<email>|

	Given I am on "Bureau" "juror-test01"	
	And I log in as "MODTESTBUREAU"
	
	When I click on the "Search" link
	And I set "Juror number" to "<juror_number>"
	And I press the "Search" button
	And I click on "<juror_number>" in the same row as "<juror_number>"
	Then "Record status" is "Excused"
	
	#DB checks (Do PNC N/A)
	
#	Then on "JUROR" . "PRINT_FILES" I see "FORM_TYPE" is "5224A" where "PART_NO" is "<juror_number>"
#	Then on "JUROR" . "PRINT_FILES" I see "DIGITAL_COMMS" is "Y" where "PART_NO" is "<juror_number>"
#	Then on "JUROR" . "POOL" I see "NOTIFICATIONS" is null where "PART_NO" is "<juror_number>"
	
Examples:
|part_no		|pool_no 	|last_name 		|postcode 	|email					|
|645100496		|451170401 	|DOE			|SW1H 9AJ	|e@mail.com	|

@comms
Scenario Outline: 3rd Party Welsh Deceased, 5 weeks in advance, PNC n/a
	Given I am on "Public" "juror-test01"
	Given I have cleared down the juror digital database
	Given the juror numbers have not been processed
	|part_no		|pool_no 	|Owner 		|
	|645700230		|457170401 	|400		|
	Given auto straight through processing has been enabled new schema


	And I have submitted a third party Welsh deceased response
	| part_no		|pool_number| last_name		|postcode	| email |
	|<part_no>		|<pool_no>	| <last_name>	|<postcode>	|<email>|
	
#	And I have submitted a third party English deceased response
#	| part_no		|pool_number| last_name		|postcode	| email |
#	|<part_no>		|<pool_no>	| <last_name>	|<postcode>	|<email>|

	Given I am on "Bureau" "juror-test01"	
	And I log in as "MODTESTBUREAU"
	
	When I click on the "Search" link
	And I set "Juror number" to "<juror_number>"
	And I press the "Search" button
	And I click on "<juror_number>" in the same row as "<juror_number>"
	Then "Record status" is "Excused"
	
	#DB checks (Do PNC N/A)
	
#	Then on "JUROR" . "PRINT_FILES" I see "FORM_TYPE" is "5224A" where "PART_NO" is "<juror_number>"
#	Then on "JUROR" . "PRINT_FILES" I see "DIGITAL_COMMS" is "Y" where "PART_NO" is "<juror_number>"
#	Then on "JUROR" . "POOL" I see "NOTIFICATIONS" is null where "PART_NO" is "<juror_number>"
	
Examples:
|part_no		|pool_no 	|last_name 			|postcode 	|email					|
|645700230		|457170401 	|LNAMETWOTHREEZERO	|SA1 4PF	|e@mail.com	|

@comms
Scenario Outline: 3rd Party Deceased, 2 weeks in advance, PNC n/a
	Given I am on "Public" "juror-test01"
	Given I have cleared down the juror digital database
	Given the juror numbers have not been processed
	|part_no		|pool_no 	|Owner 		|
	|841501691		|415181001 	|400		|
	Given auto straight through processing has been enabled new schema
	And "<juror_number>" has "RET_DATE" as "2 mondays time"
	And "<juror_number>" has "NEXT_DATE" as "2 mondays time"
	And I have submitted a first party English ineligibilty response
	| part_no		|pool_number| last_name		|postcode	| email |
	|<part_no>		|<pool_no>	| <last_name>	|<postcode>	|<email>|

	Given I am on "Bureau" "juror-test01"	
	And I log in as "MODTESTBUREAU"
	
	When I click on the "Search" link
	And I set "Juror number" to "<juror_number>"
	And I press the "Search" button
	And I click on "<juror_number>" in the same row as "<juror_number>"
	Then I see "Summoned" on the page
	And I see "Urgent" on the page
	
	#DB checks (Do PNC N/A)
	
	Then on "JUROR" . "PRINT_FILES" I see "FORM_TYPE" is "5224A" where "PART_NO" is "<juror_number>"
	Then on "JUROR" . "PRINT_FILES" I see "DIGITAL_COMMS" is "Y" where "PART_NO" is "<juror_number>"
	Then on "JUROR" . "POOL" I see "NOTIFICATIONS" is null where "PART_NO" is "<juror_number>"
	
Examples:
|part_no		|pool_no 	|last_name 			|postcode 	|email					|
|841501691		|415181001 	|LNAME1691			|CH1 2AN	|e@mail.com	|

@comms
Scenario Outline: 1st Party Ineligible, 1 week in advance, PNC n/a
	Given I am on "Public" "juror-test01"
	Given I have cleared down the juror digital database
	Given the juror numbers have not been processed
	|part_no		|pool_no 	|Owner 		|
	|<part_no>		|<pool_no> 	|400		|
	Given auto straight through processing has been enabled new schema
	And "<juror_number>" has "RET_DATE" as "1 mondays time"
	And "<juror_number>" has "NEXT_DATE" as "1 mondays time"
	And "<juror_number>" has "READ_ONLY" as "Y"
	And I have submitted a third party English ineligibilty response
	| part_no		|pool_number| last_name		|postcode	| email |
	|<part_no>		|<pool_no>	| <last_name>	|<postcode>	|<email>|

	Given I am on "Bureau" "juror-test01"	
	And I log in as "MODTESTBUREAU"
	
	When I click on the "Search" link
	And I set "Juror number" to "<juror_number>"
	And I press the "Search" button
	And I click on "<juror_number>" in the same row as "<juror_number>"
#	Then I see "Summoned" on the page
	And I see "Send to court" on the page
	
	#DB checks (Do PNC N/A)
	
#	Then on "JUROR" . "PRINT_FILES" I see "FORM_TYPE" is "5224A" where "PART_NO" is "<juror_number>"
#	Then on "JUROR" . "PRINT_FILES" I see "DIGITAL_COMMS" is "Y" where "PART_NO" is "<juror_number>"
#	Then on "JUROR" . "POOL" I see "NOTIFICATIONS" is null where "PART_NO" is "<juror_number>"
	
Examples:
|part_no		|pool_no 	|last_name 			|postcode 	|email					|
|841501692		|415181001 	|LNAME1692			|CH1 2AN	|e@mail.com	|

@comms
Scenario Outline: 1st Party English Age Disqualified, 5 weeks in advance, PNC n/a
	Given I am on "Public" "juror-test01"
	Given I have cleared down the juror digital database
	Given the juror numbers have not been processed
	|part_no		|pool_no 	|Owner 		|
	|841501936		|415181001 	|400		|
	Given auto straight through processing has been enabled new schema


	And I have submitted a first party English underage response
	| part_no		|pool_number| last_name		|postcode	| email |
	|<part_no>		|<pool_no>	| <last_name>	|<postcode>	|<email>|

	Given I am on "Bureau" "juror-test01"	
	And I log in as "MODTESTBUREAU"
	
	When I click on the "Search" link
	And I set "Juror number" to "<juror_number>"
	And I press the "Search" button
	And I click on "<juror_number>" in the same row as "<juror_number>"
	Then "Record status" is "Disqualified"
	
	#DB checks (Do PNC N/A)
	
#	Then on "JUROR" . "PRINT_FILES" I see "FORM_TYPE" is "5224A" where "PART_NO" is "<juror_number>"
#	Then on "JUROR" . "PRINT_FILES" I see "DIGITAL_COMMS" is "Y" where "PART_NO" is "<juror_number>"
#	Then on "JUROR" . "POOL" I see "NOTIFICATIONS" is null where "PART_NO" is "<juror_number>"
	
Examples:
|part_no		|pool_no 	|last_name 	|postcode 	|email					|
|841501936		|415181001 	|LNAME1936	|CH1 2AN	|e@mail.com	|

@comms 
Scenario Outline: 3rd Party English Age Disqualified, 5 weeks in advance, PNC n/a
	Given I am on "Public" "juror-test01"
	Given I have cleared down the juror digital database
	Given the juror numbers have not been processed
	|part_no		|pool_no 	|Owner 		|
	|841501948		|415181001 	|400		|
	Given auto straight through processing has been enabled new schema


	And I have submitted a third party English overage response
	| part_no		|pool_number| last_name		|postcode	| email |
	|<part_no>		|<pool_no>	| <last_name>	|<postcode>	|<email>|

	Given I am on "Bureau" "juror-test01"	
	And I log in as "MODTESTBUREAU"
	
	When I click on the "Search" link
	And I set "Juror number" to "<juror_number>"
	And I press the "Search" button
	And I click on "<juror_number>" in the same row as "<juror_number>"
	Then I see "Summoned" on the page
	
	#DB checks (Do PNC N/A)
#	
#	Then on "JUROR" . "PRINT_FILES" I see "FORM_TYPE" is "5224A" where "PART_NO" is "<juror_number>"
#	Then on "JUROR" . "PRINT_FILES" I see "DIGITAL_COMMS" is "Y" where "PART_NO" is "<juror_number>"
#	Then on "JUROR" . "POOL" I see "NOTIFICATIONS" is null where "PART_NO" is "<juror_number>"
	
Examples:
|part_no		|pool_no 	|last_name 	|postcode 	|email					|
|841501948		|415181001 	|LNAME1948	|CH1 2AN	|e@mail.com	|

@comms 
Scenario Outline: 1st Party Welsh Age Disqualified, 5 weeks in advance, PNC n/a
	Given I am on "Public" "juror-test01"
	Given I have cleared down the juror digital database
	Given the juror numbers have not been processed
	|part_no		|pool_no 	|Owner 		|
	|841501955		|415181001 	|400		|
	Given auto straight through processing has been enabled new schema


	And I have submitted a first party Welsh underage response
	| part_no		|pool_number| last_name		|postcode	| email |
	|<part_no>		|<pool_no>	| <last_name>	|<postcode>	|<email>|
	
#	And I have submitted a first party English underage response
#	| part_no		|pool_number| last_name		|postcode	| email |
#	|<part_no>		|<pool_no>	| <last_name>	|<postcode>	|<email>|

	Given I am on "Bureau" "juror-test01"	
	And I log in as "MODTESTBUREAU"
	
	When I click on the "Search" link
	And I set "Juror number" to "<juror_number>"
	And I press the "Search" button
	And I click on "<juror_number>" in the same row as "<juror_number>"
	Then "Record status" is "Disqualified"
	
	#DB checks (Do PNC N/A)
	
#	Then on "JUROR" . "PRINT_FILES" I see "FORM_TYPE" is "5224A" where "PART_NO" is "<juror_number>"
#	Then on "JUROR" . "PRINT_FILES" I see "DIGITAL_COMMS" is "Y" where "PART_NO" is "<juror_number>"
#	Then on "JUROR" . "POOL" I see "NOTIFICATIONS" is null where "PART_NO" is "<juror_number>"
	
Examples:
|part_no		|pool_no 	|last_name 	|postcode 	|email					|
|841501955		|415181001 	|LNAME1955	|CH1 2AN	|e@mail.com	|

@comms 
Scenario Outline: 3rd Party Welsh Age Disqualified, 5 weeks in advance, PNC n/a
	Given I am on "Public" "juror-test01"
	Given I have cleared down the juror digital database
	Given the juror numbers have not been processed
	|part_no		|pool_no 	|Owner 		|
	|841501948		|415181001 	|400		|
	Given auto straight through processing has been enabled new schema


	And I have submitted a third party Welsh overage response
	| part_no		|pool_number| last_name		|postcode	| email |
	|<part_no>		|<pool_no>	| <last_name>	|<postcode>	|<email>|

#	And I have submitted a third party English overage response
#	| part_no		|pool_number| last_name		|postcode	| email |
#	|<part_no>		|<pool_no>	| <last_name>	|<postcode>	|<email>|

	Given I am on "Bureau" "juror-test01"	
	And I log in as "MODTESTBUREAU"
	
	When I click on the "Search" link
	And I set "Juror number" to "<juror_number>"
	And I press the "Search" button
	And I click on "<juror_number>" in the same row as "<juror_number>"
	Then I see "Summoned" on the page
	
	#DB checks (Do PNC N/A)
	
#	Then on "JUROR" . "PRINT_FILES" I see "FORM_TYPE" is "5224A" where "PART_NO" is "<juror_number>"
#	Then on "JUROR" . "PRINT_FILES" I see "DIGITAL_COMMS" is "Y" where "PART_NO" is "<juror_number>"
#	Then on "JUROR" . "POOL" I see "NOTIFICATIONS" is null where "PART_NO" is "<juror_number>"
	
Examples:
|part_no		|pool_no 	|last_name 	|postcode 	|email					|
|841501963		|415181001 	|LNAME1963	|CH1 2AN	|e@mail.com	|

@comms
Scenario Outline: 1st Party Postponement, 5 weeks in advance, PNC pass, creation_date=(SYSDATE-1)
	Given I am on "Public" "juror-test01"
	Given I have cleared down the juror digital database
	Given the juror numbers have not been processed
	|part_no		|pool_no 	|Owner 		|
	|641500490		|415170401 	|400		|
	Given auto straight through processing has been enabled new schema


	And I have submitted a first party English ineligibilty response
	| part_no		|pool_number| last_name		|postcode	| email |
	|<part_no>		|<pool_no>	| <last_name>	|<postcode>	|<email>|

	Given I am on "Bureau" "juror-test01"	
	And I log in as "MODTESTBUREAU"
	
	When I click on the "Search" link
	And I set "Juror number" to "<juror_number>"
	And I press the "Search" button
	And I click on "<juror_number>" in the same row as "<juror_number>"
	Then I see "Summoned" on the page
	
	When I select "Deferral" from Process reply
	And I set the radio button to "Accept deferral"
	Then I see "Defer until" on the page
	
	When I set "Defer until" to "{7 mondays time}"
	And I select "P - POSTPONEMENT OF SERVICE" from the "Reason for deferral request" dropdown
	And I press the "Mark as completed" button
	Then I see "Completed" on the page
	
	#DB checks (Do PNC PASS)
	And "<juror_number>" has "POLICE_CHECK" as "P"
	And "<juror_number>" has "PHOENIX_CHECKED" as "C"
	
	#postponse letter generated
	Given a postponement letter is generated for juror "<juror_number>"
	
#	Then on "JUROR" . "PRINT_FILES" I see "FORM_TYPE" is "5224A" where "PART_NO" is "<juror_number>"
#	Then on "JUROR" . "PRINT_FILES" I see "DIGITAL_COMMS" is "Y" where "PART_NO" is "<juror_number>"
#	Then on "JUROR" . "POOL" I see "NOTIFICATIONS" is null where "PART_NO" is "<juror_number>"
	
Examples:
|part_no		|pool_no 	|last_name 	|postcode 	|email					|
|641500490		|415170401 	|DOE		|SW1H 9AJ	|e@mail.com	|

@comms
Scenario Outline: 1st Party Postponement, 5 weeks in advance, PNC pass, creation_date=(SYSDATE-3)
	Given I am on "Public" "juror-test01"
	Given I have cleared down the juror digital database
	Given the juror numbers have not been processed
	|part_no		|pool_no 	|Owner 		|
	|644200857		|442170401	|400		|
	Given auto straight through processing has been enabled new schema


	And I have submitted a first party English ineligibilty response
	| part_no		|pool_number| last_name		|postcode	| email |
	|<part_no>		|<pool_no>	| <last_name>	|<postcode>	|<email>|

	Given I am on "Bureau" "juror-test01"	
	And I log in as "MODTESTBUREAU"
	
	When I click on the "Search" link
	And I set "Juror number" to "<juror_number>"
	And I press the "Search" button
	And I click on "<juror_number>" in the same row as "<juror_number>"
	Then I see "Summoned" on the page
	
	When I select "Deferral" from Process reply
	And I set the radio button to "Accept deferral"
	Then I see "Defer until" on the page
	
	When I set "Defer until" to "{7 mondays time}"
	And I select "P - POSTPONEMENT OF SERVICE" from the "Reason for deferral request" dropdown
	And I press the "Mark as completed" button
	Then I see "Completed" on the page
	
	#DB checks (Do PNC PASS)
	And "<juror_number>" has "POLICE_CHECK" as "P"
	And "<juror_number>" has "PHOENIX_CHECKED" as "C"
	
	#postponse letter generated
	Given a postponement letter is generated for juror "<juror_number>"
	
#	Then on "JUROR" . "PRINT_FILES" I see "FORM_TYPE" is "5224A" where "PART_NO" is "<juror_number>"
#	Then on "JUROR" . "PRINT_FILES" I see "DIGITAL_COMMS" is "Y" where "PART_NO" is "<juror_number>"
#	Then on "JUROR" . "POOL" I see "NOTIFICATIONS" is null where "PART_NO" is "<juror_number>"
	
Examples:
|part_no		|pool_no 	|last_name 				|postcode 	|email					|
|644200857		|442170401 	|LNAMEEIGHTFIVESEVEN	|NN1 3HQ	|e@mail.com	|

@comms
Scenario Outline: 1st Party Postponement, 5 weeks in advance, PNC pass, creation_date=(SYSDATE-4)
	Given I am on "Public" "juror-test01"
	Given I have cleared down the juror digital database
	Given the juror numbers have not been processed
	|part_no		|pool_no 	|Owner 		|
	|644200858		|442170401	|400		|
	Given auto straight through processing has been enabled new schema


	And I have submitted a first party English ineligibilty response
	| part_no		|pool_number| last_name		|postcode	| email |
	|<part_no>		|<pool_no>	| <last_name>	|<postcode>	|<email>|

	Given I am on "Bureau" "juror-test01"	
	And I log in as "MODTESTBUREAU"
	
	When I click on the "Search" link
	And I set "Juror number" to "<juror_number>"
	And I press the "Search" button
	And I click on "<juror_number>" in the same row as "<juror_number>"
	Then I see "Summoned" on the page
	
	When I select "Deferral" from Process reply
	And I set the radio button to "Accept deferral"
	Then I see "Defer until" on the page
	
	When I set "Defer until" to "{7 mondays time}"
	And I select "P - POSTPONEMENT OF SERVICE" from the "Reason for deferral request" dropdown
	And I press the "Mark as completed" button
	Then I see "Completed" on the page
	
	#DB checks (Do PNC PASS)
	And "<juror_number>" has "POLICE_CHECK" as "P"
	And "<juror_number>" has "PHOENIX_CHECKED" as "C"
	
	#postponse letter generated
	Given a postponement letter is generated for juror "<juror_number>"
	
#	Then on "JUROR" . "PRINT_FILES" I see "FORM_TYPE" is "5224A" where "PART_NO" is "<juror_number>"
#	Then on "JUROR" . "PRINT_FILES" I see "DIGITAL_COMMS" is "Y" where "PART_NO" is "<juror_number>"
#	Then on "JUROR" . "POOL" I see "NOTIFICATIONS" is null where "PART_NO" is "<juror_number>"
	
Examples:
|part_no		|pool_no 	|last_name 				|postcode 	|email					|
|644200858		|442170401	|L'NAMEEIGHTFIV-EIGHT	|NN1 3HQ	|e@mail.com	|


@comm
Scenario Outline: 1st Party paper response with no email, 5 weeks in advance, PNC pass
	Given I am on "Public" "juror-test01"
	Given I have cleared down the juror digital database
	Given the juror numbers have not been processed
	|part_no		|pool_no 	|Owner 		|
	|644200896		|442170401 	|400		|
	Given auto straight through processing has been enabled new schema


	And "<juror_number>" has "RESPONDED" as "Y"
	And "<juror_number>" has "STATUS" as "2"
	
	#DB checks (Do PNC PASS)
	And "<juror_number>" has "POLICE_CHECK" as "P"
	And "<juror_number>" has "PHOENIX_CHECKED" as "C"
	
	#postponse letter generated
	Given a confirmation letter is generated for juror "<juror_number>"
	
#	Then on "JUROR" . "PRINT_FILES" I see "FORM_TYPE" is "5224A" where "PART_NO" is "<juror_number>"
#	Then on "JUROR" . "PRINT_FILES" I see "DIGITAL_COMMS" is "Y" where "PART_NO" is "<juror_number>"
#	Then on "JUROR" . "POOL" I see "NOTIFICATIONS" is null where "PART_NO" is "<juror_number>"
	
Examples:
|part_no		|pool_no 	|last_name 	|postcode 	|email				|
|644200896		|442170401 	|DOE		|NN1 3HQ	|e@mail.com	|

@comm 
Scenario Outline: 1st Party paper response with email, 5 weeks in advance, PNC pass
	Given I am on "Public" "juror-test01"
	Given I have cleared down the juror digital database
	Given the juror numbers have not been processed
	|part_no		|pool_no 	|Owner 		|
	|644200960		|442170401 	|400		|
	Given auto straight through processing has been enabled new schema


	And "<juror_number>" has "RESPONDED" as "Y"
	And "<juror_number>" has "STATUS" as "2"
	And "<juror_number>" has "H_EMAIL" as "e@mail.com"
	
	#DB checks (Do PNC PASS)
	And "<juror_number>" has "POLICE_CHECK" as "P"
	And "<juror_number>" has "PHOENIX_CHECKED" as "C"
	
	#postponse letter generated
	Given a confirmation letter is generated for juror "<juror_number>"
	
#	Then on "JUROR" . "PRINT_FILES" I see "FORM_TYPE" is "5224A" where "PART_NO" is "<juror_number>"
#	Then on "JUROR" . "PRINT_FILES" I see "DIGITAL_COMMS" is "Y" where "PART_NO" is "<juror_number>"
#	Then on "JUROR" . "POOL" I see "NOTIFICATIONS" is null where "PART_NO" is "<juror_number>"
	
Examples:
|part_no		|pool_no 	|last_name 	|postcode 	|email					|
|644200960		|442170401 	|DOE		|NN1 3HQ	|e@mail.com	|

@comms
Scenario Outline: 1st Party English ST, 5 weeks in advance, PNC pass, invalid email
	Given I am on "Public" "juror-test01"
	Given I have cleared down the juror digital database
	Given the juror numbers have not been processed
	|part_no		|pool_no 	|Owner 		|
	|644200977		|442170401 	|400		|
	Given auto straight through processing has been enabled new schema


	And I have submitted a first party English straight through response
	| part_no		|pool_number| last_name		|postcode	| email |
	|<part_no>		|<pool_no>	| <last_name>	|<postcode>	|<email>|

	Given I am on "Bureau" "juror-test01"	
	And I log in as "MODTESTBUREAU"
	
	When I click on the "Search" link
	And I set "Juror number" to "<juror_number>"
	And I press the "Search" button
	And I click on "<juror_number>" in the same row as "<juror_number>"
	Then I see "Responded" on the page
	
	#DB checks (Do PNC PASS)
	And "<juror_number>" has "POLICE_CHECK" as "P"
	And "<juror_number>" has "PHOENIX_CHECKED" as "C"
	
	#conf letter generated
	Given a confirmation letter is generated for juror "<juror_number>"
	
#	Then on "JUROR" . "PRINT_FILES" I see "FORM_TYPE" is "5224A" where "PART_NO" is "<juror_number>"
#	Then on "JUROR" . "PRINT_FILES" I see "DIGITAL_COMMS" is "Y" where "PART_NO" is "<juror_number>"
#	Then on "JUROR" . "POOL" I see "NOTIFICATIONS" is null where "PART_NO" is "<juror_number>"
	
Examples:
|part_no		|pool_no 	|last_name 				|postcode 	|email				|
|644200977		|442170401	|LNAMENINESEVENSEVEN	|NN1 3HQ	|blahdiblah@cgi.com	|

@comms
Scenario Outline: English 3rd Party Straight Through, 2 weeks in advance, PNC pass, juror's email selected as contact
	Given I am on "Public" "juror-test01"
	Given I have cleared down the juror digital database
	Given the juror numbers have not been processed
		| part_no 	| pool_no 	| owner |
		| <part_no> |<pool_no>	| 400 	|
	Given auto straight through processing has been enabled new schema
	And "<juror_number>" has "RET_DATE" as "1 mondays time"
	And "<juror_number>" has "NEXT_DATE" as "1 mondays time"
	And "<juror_number>" has "READ_ONLY" as "Y"

	Then I see "Reply to a jury summons" on the page
	
	
	And I set the radio button to "I am replying for someone else"
	And I press the "Continue" button
	
	#Juror Log In
	
	When I set "9-digit juror number" to "<juror_number>"
	When I set "Juror last name" to "<last_name>"
	When I set "Juror postcode" to "<postcode>"
	And I press the "Continue" button

	#3rd Party Name
	
	When I set "First name" to "FirstNameA"
	And I set "Last name" to "LastNameB"
	And I press the "Continue" button
	Then I see "Your relationship to the person" on the page
	
	#Relationship to juror
	
	And I set "How do you know the person you're replying for?" to "Friend"
	And I press the "Continue" button
	Then I see "Your contact information" on the page
	
	#3rd Party Contact
	
	And I check the "By phone (UK Numbers only)" checkbox
	And I see "Please provide a UK phone number that we can use to reach you between 9am and 5pm, Monday to Friday." on the page
	And I set "Main phone" to "0207 821 1818"
	And I check the "By email" checkbox
	And I set "Enter your email address" to "somebody@cgi.com"
	And I set "Enter your email address again" to "somebody@cgi.com"
	And I press the "Continue" button
	
	Then I see "Why are you replying for the other person?" on the page
	When I set the radio button to "The person is not here"
	And I press the "Continue" button
	
	#Check juror name
	
	Then I see "Is the name we have for them correct?" on the page
	When I choose the "Yes" radio button
	And I press the "Continue" button
	Then I see "Is this their address?" on the page
	When I choose the "Yes" radio button
	And I press the "Continue" button
	
	#DoB
	
	And I set "Day" to "01"
	And I set "Month" to "01"
	And I set "Year" to "1977"
	And I press the "Continue" button

	#Contacting the juror
	
	When I see "Juror Details" on the page
	And I see "Please give phone numbers that we can use to call you or the juror between 9am and 5pm, Monday to Friday." on the page
	And I set the radio button to "Use the phone number that you have already given to contact you"
	And I set the radio button to "Give a different email address for the juror"
	And I set "Enter email address" to "e@mail.com"
	And I set "Enter the email address again" to "e@mail.com"
	
	And I press the "Continue" button
	Then I see "Your answers in this section might mean the person cannot do jury service. But even if you think they cannot, we still need you to fill in the rest of the online form. We need the rest of the information you give us so we can be sure whether the person can do jury service or not." on the page
	
	#Qualify for jury service
	
	And I press the "Continue" button

	#Residency
	
	And I choose the "Yes" radio button
	And I press the "Continue" button

	#Mental Health Sectioned
	
	And I choose the "No" radio button
	And I press the "Continue" button
	
	#Mental Health Capacity
	
	And I choose the "No" radio button
	And I press the "Continue" button
	
	#Bail
	
	And I choose the "No" radio button
	And I press the "Continue" button
	
	#Convictions
	
	When I choose the "No" radio button
	And I press the "Continue" button
	
	#The person can attend
	
	Then I set the radio button to "Yes, they can start on"
	And  I press the "Continue" button
	
	#CJS no
	
	When I choose the "No" radio button
	And I press the "Continue" button
	
	#RA no
	
	When I choose the "No" radio button
	And I press the "Continue" button
	
	#Check your answers

	When I check the "The answers I have given for the person I'm replying for are true as far as I know." checkbox
	And I press the "Submit" button
	
	#process in bureau digital
	
	Given I am on "Bureau" "juror-test01"	
	And I log in as "MODTESTBUREAU"
	
	When I click on the "Search" link
	And I set "Juror number" to "<juror_number>"
	And I press the "Search" button
	And I click on "<juror_number>" in the same row as "<juror_number>"
	Then I see "Summoned" on the page
	
	#process in Bureau as Responded
	When I select "Responded" from Process reply
	And I check the "Mark juror as 'responded'" checkbox
	And I press the "Confirm" button
	Then I see "Completed" on the page
	
	#DB checks (Do PNC PASS)
	And "<juror_number>" has "POLICE_CHECK" as "P"
	And "<juror_number>" has "PHOENIX_CHECKED" as "C"
	
	#conf letter generated
	Given a confirmation letter is generated for juror "<juror_number>"
		
Examples:
	| part_no	|last_name			|postcode	| email           |pool_no	|
	|644200953	|LNAMENINEFIVETHREE	|NN1 3HQ	|email@outlook.com|442170401|

@comms @DBTESTA
Scenario Outline: 3rd Party English ST, 5 weeks in advance, PNC pass
	Given I am on "Public" "juror-test01"
	Given I have cleared down the juror digital database
	Given the juror numbers have not been processed
	|part_no		|pool_no 	|Owner 		|
	|<part_no>		|<pool_no> 	|400		|
	Given auto straight through processing has been enabled new schema
	And "<juror_number>" has "RET_DATE" as "1 mondays time"
	And "<juror_number>" has "NEXT_DATE" as "1 mondays time"
	And "<juror_number>" has "READ_ONLY" as "Y"
	
	And I have submitted a third party English straight through response
	| part_no		|pool_number| last_name		|postcode	| email |
	|<part_no>		|<pool_no>	| <last_name>	|<postcode>	|<email>|

	Given I am on "Bureau" "juror-test01"	
	And I log in as "MODTESTBUREAU"
	
	When I click on the "Search" link
	And I set "Juror number" to "<juror_number>"
	And I press the "Search" button
	And I click on "<juror_number>" in the same row as "<juror_number>"
	Then I see "Summoned" on the page
	
	#process in Bureau as Responded
	When I select "Responded" from Process reply
	And I check the "Mark juror as 'responded'" checkbox
	And I press the "Confirm" button
	Then I see "Completed" on the page
	
	#DB checks (Do PNC PASS)
	And "<juror_number>" has "POLICE_CHECK" as "P"
	And "<juror_number>" has "PHOENIX_CHECKED" as "C"
	
	#conf letter generated
	Given a confirmation letter is generated for juror "<juror_number>"
	
#	Then on "JUROR" . "PRINT_FILES" I see "FORM_TYPE" is "5224A" where "PART_NO" is "<juror_number>"
#	Then on "JUROR" . "PRINT_FILES" I see "DIGITAL_COMMS" is "Y" where "PART_NO" is "<juror_number>"
#	Then on "JUROR" . "POOL" I see "NOTIFICATIONS" is null where "PART_NO" is "<juror_number>"
	
Examples:
|part_no		|pool_no 	|last_name 	|postcode 	|email					|
|641500778		|415170401 	|DOE		|SW1H 9AJ	|e@mail.com	|

@comms
Scenario Outline: 3rd Party Welsh ST, 5 weeks in advance, PNC pass
	Given I am on "Public" "juror-test01"
	Given I have cleared down the juror digital database
	Given the juror numbers have not been processed
	|part_no	|pool_no 	|Owner 		|
	|<part_no>	|<pool_no> 	|400		|
	Given auto straight through processing has been enabled new schema
	And "<juror_number>" has "RET_DATE" as "3 mondays time"
	And "<juror_number>" has "NEXT_DATE" as "3 mondays time"
#	And "<juror_number>" has "READ_ONLY" as "Y"
#	And I have submitted a third party Welsh straight through response
#	| part_no		|pool_number| last_name		|postcode	| email |
#	|<part_no>		|<pool_no>	| <last_name>	|<postcode>	|<email>|
	
	And I have submitted a third party English straight through response
	| part_no		|pool_number| last_name		|postcode	| email |
	|<part_no>		|<pool_no>	| <last_name>	|<postcode>	|<email>|

	Given I am on "Bureau" "juror-test01"	
	And I log in as "MODTESTBUREAU"
	
	When I click on the "Search" link
	And I set "Juror number" to "<juror_number>"
	And I press the "Search" button
	And I click on "<juror_number>" in the same row as "<juror_number>"
#	Then I see "Summoned" on the page
	
	#process in Bureau as Responded
	When I select "Responded" from Process reply
	And I check the "Mark juror as 'responded'" checkbox
	And I press the "Confirm" button
	Then I see "Completed" on the page
	
	#DB checks (Do PNC PASS)
	And "<juror_number>" has "POLICE_CHECK" as "P"
	And "<juror_number>" has "PHOENIX_CHECKED" as "C"
	
	#conf letter generated
	Given a confirmation letter is generated for juror "<juror_number>"
	
#	Then on "JUROR" . "PRINT_FILES" I see "FORM_TYPE" is "5224A" where "PART_NO" is "<juror_number>"
#	Then on "JUROR" . "PRINT_FILES" I see "DIGITAL_COMMS" is "Y" where "PART_NO" is "<juror_number>"
#	Then on "JUROR" . "POOL" I see "NOTIFICATIONS" is null where "PART_NO" is "<juror_number>"
	
Examples:
|part_no	|pool_no 	|last_name 				|postcode 	|email					|
|645700478	|457170401 	|LNAMEFOURSEVENEIGHT	|SA1 4PF	|e@mail.com	|

@comms
Scenario Outline: 1st Party Welsh Excusal accepted, 5 weeks in advance, PNC pass
	Given I am on the welsh version of "Public" "juror-test01"
	Given I have cleared down the juror digital database
	Given the juror numbers have not been processed
	|part_no		|pool_no 	|Owner 		|
	|645700291		|457170401	|400		|
	Given auto straight through processing has been enabled new schema


	And I have submitted a first party Welsh excusal response
	| part_no		|pool_number| last_name		|postcode	| email |
	|<part_no>		|<pool_no>	| <last_name>	|<postcode>	|<email>|

#	And I have submitted a first party English excusal response
#	| part_no		|pool_number| last_name		|postcode	| email |
#	|<part_no>		|<pool_no>	| <last_name>	|<postcode>	|<email>|
	
	Given I am on "Bureau" "juror-test01"	
	And I log in as "MODTESTBUREAU"
	
	When I click on the "Search" link
	And I set "Juror number" to "<juror_number>"
	And I press the "Search" button
	And I click on "<juror_number>" in the same row as "<juror_number>"
	Then I see "Summoned" on the page
	
	#process in Bureau as Excused
	When I select "Excusal" from Process reply
	And I set the radio button to "Accept excusal"
	And I select "OTHER" from the "Reason for excusal request" dropdown
	And I press the "Mark as completed" button
	Then I see "Completed" on the page
	
	#DB checks (Do PNC PASS)
	And "<juror_number>" has "POLICE_CHECK" as "P"
	And "<juror_number>" has "PHOENIX_CHECKED" as "C"
	
	#excusal letter generated
#	Given an excusal letter is generated for juror "<juror_number>"
	
#	Then on "JUROR" . "PRINT_FILES" I see "FORM_TYPE" is "5224A" where "PART_NO" is "<juror_number>"
#	Then on "JUROR" . "PRINT_FILES" I see "DIGITAL_COMMS" is "Y" where "PART_NO" is "<juror_number>"
#	Then on "JUROR" . "POOL" I see "NOTIFICATIONS" is null where "PART_NO" is "<juror_number>"
	
Examples:
|part_no		|pool_no 	|last_name 			|postcode 	|email					|
|645700291		|457170401 	|LNAMETWONINEONE	|SA1 4PF	|osman.salah@cgi.com	|

@comms 
Scenario Outline: 3rd Party English Excusal accepted, 5 weeks in advance, PNC pass
	Given I am on "Public" "juror-test01"
	Given I have cleared down the juror digital database
	Given the juror numbers have not been processed
	|part_no	|pool_no 	|Owner 		|
	|644200976	|442170401 	|400		|
	Given auto straight through processing has been enabled new schema


	And I have submitted a third party English excusal response
	| part_no		|pool_number| last_name		|postcode	| email |
	|<part_no>		|<pool_no>	| <last_name>	|<postcode>	|<email>|

	Given I am on "Bureau" "juror-test01"	
	And I log in as "MODTESTBUREAU"
	
	When I click on the "Search" link
	And I set "Juror number" to "<juror_number>"
	And I press the "Search" button
	And I click on "<juror_number>" in the same row as "<juror_number>"
	Then I see "Summoned" on the page
	
	#process in Bureau as Excused
	When I select "Excusal" from Process reply
	And I set the radio button to "Accept excusal"
	And I select "OTHER" from the "Reason for excusal request" dropdown
	And I press the "Mark as completed" button
	Then I see "Completed" on the page
	
	#DB checks (Do PNC PASS)
	And "<juror_number>" has "POLICE_CHECK" as "P"
	And "<juror_number>" has "PHOENIX_CHECKED" as "C"
	
	#conf letter generated
	Given an excusal letter is generated for juror "<juror_number>"
	
#	Then on "JUROR" . "PRINT_FILES" I see "FORM_TYPE" is "5224A" where "PART_NO" is "<juror_number>"
#	Then on "JUROR" . "PRINT_FILES" I see "DIGITAL_COMMS" is "Y" where "PART_NO" is "<juror_number>"
#	Then on "JUROR" . "POOL" I see "NOTIFICATIONS" is null where "PART_NO" is "<juror_number>"
	
Examples:
|part_no	|pool_no 	|last_name 			|postcode 	|email					|
|644200976	|442170401	|LNAMENINESEVENSIX	|NN1 3HQ	|e@mail.com	|

@comms 
Scenario Outline: 3rd Party Welsh Excusal accepted, 5 weeks in advance, PNC pass
	Given I am on "Public" "juror-test01"
	Given I have cleared down the juror digital database
	Given the juror numbers have not been processed
	|part_no	|pool_no 	|Owner 		|
	|645700183	|457170401 	|400		|
	Given auto straight through processing has been enabled new schema


	And I have submitted a third party Welsh excusal response
	| part_no		|pool_number| last_name		|postcode	| email |
	|<part_no>		|<pool_no>	| <last_name>	|<postcode>	|<email>|

#	And I have submitted a third party English excusal response
#	| part_no		|pool_number| last_name		|postcode	| email |
#	|<part_no>		|<pool_no>	| <last_name>	|<postcode>	|<email>|
	
	Given I am on "Bureau" "juror-test01"	
	And I log in as "MODTESTBUREAU"
	
	When I click on the "Search" link
	And I set "Juror number" to "<juror_number>"
	And I press the "Search" button
	And I click on "<juror_number>" in the same row as "<juror_number>"
	Then I see "Summoned" on the page
	
	#process in Bureau as Excused
	When I select "Excusal" from Process reply
	And I set the radio button to "Accept excusal"
	And I select "OTHER" from the "Reason for excusal request" dropdown
	And I press the "Mark as completed" button
	Then I see "Completed" on the page
	
	#DB checks (Do PNC PASS)
	And "<juror_number>" has "POLICE_CHECK" as "P"
	And "<juror_number>" has "PHOENIX_CHECKED" as "C"
	
	#conf letter generated
	Given an excusal letter is generated for juror "<juror_number>"
	
#	Then on "JUROR" . "PRINT_FILES" I see "FORM_TYPE" is "5224A" where "PART_NO" is "<juror_number>"
#	Then on "JUROR" . "PRINT_FILES" I see "DIGITAL_COMMS" is "Y" where "PART_NO" is "<juror_number>"
#	Then on "JUROR" . "POOL" I see "NOTIFICATIONS" is null where "PART_NO" is "<juror_number>"
	
Examples:
|part_no	|pool_no 	|last_name 			|postcode 	|email					|
|645700183	|457170401	|LNAMEONEEIGHTTHREE	|SA1 4PF	|e@mail.com	|

@comms
Scenario Outline: 1st Party Welsh Deferral accepted, 5 weeks in advance, PNC pass
	Given I am on "Public" "juror-test01"
	Given I have cleared down the juror digital database
	Given the juror numbers have not been processed
	|part_no		|pool_no 	|Owner 		|
	|<part_no>		|<pool_no> 	|400		|
	Given auto straight through processing has been enabled new schema


#	And I have submitted a first party Welsh deferral response
#	| part_no		|pool_number| last_name		|postcode	| email |
#	|<part_no>		|<pool_no>	| <last_name>	|<postcode>	|<email>|
	
	And I have submitted a first party English deferral response
	| part_no		|pool_number| last_name		|postcode	| email |
	|<part_no>		|<pool_no>	| <last_name>	|<postcode>	|<email>|

	Given I am on "Bureau" "juror-test01"	
	And I log in as "MODTESTBUREAU"
	
	When I click on the "Search" link
	And I set "Juror number" to "<juror_number>"
	And I press the "Search" button
	And I click on "<juror_number>" in the same row as "<juror_number>"
	Then I see "Summoned" on the page
	
	When I select "Deferral" from Process reply
	And I set the radio button to "Accept deferral"
	Then I see "Defer until" on the page
	
	When I set "Defer until" to "{7 mondays time}"
	And I select "O - OTHER" from the "Reason for deferral request" dropdown
	And I press the "Mark as completed" button
	Then I see "Completed" on the page
	
	#DB checks (Do PNC PASS)
	And "<juror_number>" has "POLICE_CHECK" as "P"
	And "<juror_number>" has "PHOENIX_CHECKED" as "C"
	
	#deferral letter generated
#	Given a deferral letter is generated for juror "<juror_number>"
	
#	Then on "JUROR" . "PRINT_FILES" I see "FORM_TYPE" is "5224A" where "PART_NO" is "<juror_number>"
#	Then on "JUROR" . "PRINT_FILES" I see "DIGITAL_COMMS" is "Y" where "PART_NO" is "<juror_number>"
#	Then on "JUROR" . "POOL" I see "NOTIFICATIONS" is null where "PART_NO" is "<juror_number>"
	
Examples:
|part_no		|pool_no 	|last_name 			|postcode 	|email					|
|645700195		|457170401	|LNAMEONENINEFIVE	|SA1 4PF	|osman.salah@cgi.com	|

@comms
Scenario Outline: 3rd Party English Deferral accepted, 5 weeks in advance, PNC pass
	Given I am on "Public" "juror-test01"
	Given I have cleared down the juror digital database
	Given the juror numbers have not been processed
	|part_no	|pool_no 	|Owner 		|
	|641500631	|415170401 	|400		|
	Given auto straight through processing has been enabled new schema


	And I have submitted a third party English deferral response
	| part_no		|pool_number| last_name		|postcode	| email |
	|<part_no>		|<pool_no>	| <last_name>	|<postcode>	|<email>|

	Given I am on "Bureau" "juror-test01"	
	And I log in as "MODTESTBUREAU"
	
	When I click on the "Search" link
	And I set "Juror number" to "<juror_number>"
	And I press the "Search" button
	And I click on "<juror_number>" in the same row as "<juror_number>"
	Then I see "Summoned" on the page
	
	When I select "Deferral" from Process reply
	And I set the radio button to "Accept deferral"
	Then I see "Defer until" on the page
	
	When I set "Defer until" to "{7 mondays time}"
	And I select "O - OTHER" from the "Reason for deferral request" dropdown
	And I press the "Mark as completed" button
	Then I see "Completed" on the page
	
	#DB checks (Do PNC PASS)
	And "<juror_number>" has "POLICE_CHECK" as "P"
	And "<juror_number>" has "PHOENIX_CHECKED" as "C"
	
	#deferral letter generated
	Given a deferral letter is generated for juror "<juror_number>"
	
#	Then on "JUROR" . "PRINT_FILES" I see "FORM_TYPE" is "5224A" where "PART_NO" is "<juror_number>"
#	Then on "JUROR" . "PRINT_FILES" I see "DIGITAL_COMMS" is "Y" where "PART_NO" is "<juror_number>"
#	Then on "JUROR" . "POOL" I see "NOTIFICATIONS" is null where "PART_NO" is "<juror_number>"
	
Examples:
|part_no	|pool_no 	|last_name 	|postcode 	|email					|
|641500631	|415170401	|DOE		|SW1H 9AJ	|e@mail.com	|

@comms 
Scenario Outline: 3rd Party Welsh Deferral accepted, 5 weeks in advance, PNC pass
	Given I am on "Public" "juror-test01"
	Given I have cleared down the juror digital database
	Given the juror numbers have not been processed
	|part_no	|pool_no 	|Owner 		|
	|645700247	|457170401 	|400		|
	Given auto straight through processing has been enabled new schema


	And I have submitted a third party Welsh deferral response
	| part_no		|pool_number| last_name		|postcode	| email |
	|<part_no>		|<pool_no>	| <last_name>	|<postcode>	|<email>|
	
#	And I have submitted a first party English deferral response
#	| part_no		|pool_number| last_name		|postcode	| email |
#	|<part_no>		|<pool_no>	| <last_name>	|<postcode>	|<email>|

	Given I am on "Bureau" "juror-test01"	
	And I log in as "MODTESTBUREAU"
	
	When I click on the "Search" link
	And I set "Juror number" to "<juror_number>"
	And I press the "Search" button
	And I click on "<juror_number>" in the same row as "<juror_number>"
	Then I see "Summoned" on the page
	
	When I select "Deferral" from Process reply
	And I set the radio button to "Accept deferral"
	Then I see "Defer until" on the page
	
	When I set "Defer until" to "{7 mondays time}"
	And I select "O - OTHER" from the "Reason for deferral request" dropdown
	And I press the "Mark as completed" button
	Then I see "Completed" on the page
	
	#DB checks (Do PNC PASS)
	And "<juror_number>" has "POLICE_CHECK" as "P"
	And "<juror_number>" has "PHOENIX_CHECKED" as "C"
	
	#deferral letter generated
	Given a deferral letter is generated for juror "<juror_number>"
	
#	Then on "JUROR" . "PRINT_FILES" I see "FORM_TYPE" is "5224A" where "PART_NO" is "<juror_number>"
#	Then on "JUROR" . "PRINT_FILES" I see "DIGITAL_COMMS" is "Y" where "PART_NO" is "<juror_number>"
#	Then on "JUROR" . "POOL" I see "NOTIFICATIONS" is null where "PART_NO" is "<juror_number>"
	
Examples:
|part_no	|pool_no 	|last_name 			|postcode 	|email					|
|645700247	|457170401	|LNAMETWOFOURSEVEN	|SA1 4PF	|e@mail.com	|

@comms 
Scenario Outline: 1st Party Welsh Excusal refused, 5 weeks in advance, PNC pass
	Given I am on "Public" "juror-test01"
	Given I have cleared down the juror digital database
	Given the juror numbers have not been processed
	|part_no	|pool_no 	|Owner 		|
	|645700261	|457170401 	|400		|
	Given auto straight through processing has been enabled new schema
	And "<juror_number>" has "RET_DATE" as "3 mondays time"
	And "<juror_number>" has "NEXT_DATE" as "3 mondays time"
#	And I have submitted a first party Welsh excusal response
#	| part_no		|pool_number| last_name		|postcode	| email |
#	|<part_no>		|<pool_no>	| <last_name>	|<postcode>	|<email>|

	And I have submitted a first party English excusal response
	| part_no		|pool_number| last_name		|postcode	| email |
	|<part_no>		|<pool_no>	| <last_name>	|<postcode>	|<email>|

	Given I am on "Bureau" "juror-test01"	
	And I log in as "MODTESTBUREAU"
	
	When I click on the "Search" link
	And I set "Juror number" to "<juror_number>"
	And I press the "Search" button
	And I click on "<juror_number>" in the same row as "<juror_number>"
#	Then I see "Summoned" on the page
	
	#process in Bureau as Refuse Excuse
	When I select "Excusal" from Process reply
	And I set the radio button to "Refuse excusal"
	And I select "OTHER" from the "Reason for excusal request" dropdown
	And I press the "Mark as completed" button
	Then I see "Completed" on the page
	
	#DB checks (Do PNC PASS)
	And "<juror_number>" has "POLICE_CHECK" as "P"
	And "<juror_number>" has "PHOENIX_CHECKED" as "C"
	
	#refuse excusal letter generated
	Given an excusal denied letter is generated for juror "<juror_number>"
	Given a confirmation letter is generated for juror "<juror_number>"
	
#	Then on "JUROR" . "PRINT_FILES" I see "FORM_TYPE" is "5224A" where "PART_NO" is "<juror_number>"
#	Then on "JUROR" . "PRINT_FILES" I see "DIGITAL_COMMS" is "Y" where "PART_NO" is "<juror_number>"
#	Then on "JUROR" . "POOL" I see "NOTIFICATIONS" is null where "PART_NO" is "<juror_number>"
	
Examples:
|part_no	|pool_no 	|last_name 		|postcode 	|email					|
|645700261	|457170401 	|LNAMETWOSIXONE	|SA1 4PF	|e@mail.com	|

@comms
Scenario Outline: 3rd Party Excusal refused, 5 weeks in advance, PNC pass
	Given I am on "Public" "juror-test01"
	Given I have cleared down the juror digital database
	Given the juror numbers have not been processed
	|part_no	|pool_no 	|Owner 		|
	|<part_no>	|<pool_no> 	|400		|
	Given auto straight through processing has been enabled new schema
	And "<juror_number>" has "RET_DATE" as "3 mondays time"
	And "<juror_number>" has "NEXT_DATE" as "3 mondays time"
	And I have submitted a third party English excusal response
	| part_no		|pool_number| last_name		|postcode	| email |
	|<part_no>		|<pool_no>	| <last_name>	|<postcode>	|<email>|

	Given I am on "Bureau" "juror-test01"	
	And I log in as "MODTESTBUREAU"
	
	When I click on the "Search" link
	And I set "Juror number" to "<juror_number>"
	And I press the "Search" button
	And I click on "<juror_number>" in the same row as "<juror_number>"
	Then I see "Summoned" on the page
	
	#process in Bureau as Refuse Excuse
	When I select "Excusal" from Process reply
	And I set the radio button to "Refuse excusal"
	And I select "OTHER" from the "Reason for excusal request" dropdown
	And I press the "Mark as completed" button
	Then I see "Completed" on the page
	
	#DB checks (Do PNC PASS)
	And "<juror_number>" has "POLICE_CHECK" as "P"
	And "<juror_number>" has "PHOENIX_CHECKED" as "C"
	
	#refuse excusal letter generated
	Given an excusal denied letter is generated for juror "<juror_number>"
	Given a confirmation letter is generated for juror "<juror_number>"
	
#	Then on "JUROR" . "PRINT_FILES" I see "FORM_TYPE" is "5224A" where "PART_NO" is "<juror_number>"
#	Then on "JUROR" . "PRINT_FILES" I see "DIGITAL_COMMS" is "Y" where "PART_NO" is "<juror_number>"
#	Then on "JUROR" . "POOL" I see "NOTIFICATIONS" is null where "PART_NO" is "<juror_number>"
	
Examples:
|part_no	|pool_no 	|last_name 	|postcode 	|email					|
|641500786	|415170401 	|DOE		|SW1H 9AJ	|e@mail.com	|

@comms
Scenario Outline: 3rd Party Welsh Excusal refused, 5 weeks in advance, PNC pass
	Given I am on "Public" "juror-test01"
	Given I have cleared down the juror digital database
	Given the juror numbers have not been processed
	|part_no	|pool_no 	|Owner 		|
	|645700185	|457170401	|400		|
	Given auto straight through processing has been enabled new schema
	And "<juror_number>" has "RET_DATE" as "3 mondays time"
	And "<juror_number>" has "NEXT_DATE" as "3 mondays time"
#	And I have submitted a third party Welsh excusal response
#	| part_no		|pool_number| last_name		|postcode	| email |
#	|<part_no>		|<pool_no>	| <last_name>	|<postcode>	|<email>|
	
	And I have submitted a third party English excusal response
	| part_no		|pool_number| last_name		|postcode	| email |
	|<part_no>		|<pool_no>	| <last_name>	|<postcode>	|<email>|

	Given I am on "Bureau" "juror-test01"	
	And I log in as "MODTESTBUREAU"
	
	When I click on the "Search" link
	And I set "Juror number" to "<juror_number>"
	And I press the "Search" button
	And I click on "<juror_number>" in the same row as "<juror_number>"
#	Then I see "Summoned" on the page
	
	#process in Bureau as Refuse Excuse
	When I select "Excusal" from Process reply
	And I set the radio button to "Refuse excusal"
	And I select "OTHER" from the "Reason for excusal request" dropdown
	And I press the "Mark as completed" button
	Then I see "Completed" on the page
	
	#DB checks (Do PNC PASS)
	And "<juror_number>" has "POLICE_CHECK" as "P"
	And "<juror_number>" has "PHOENIX_CHECKED" as "C"
	
	#refuse excusal letter generated
	Given an excusal denied letter is generated for juror "<juror_number>"
	Given a confirmation letter is generated for juror "<juror_number>"
	
#	Then on "JUROR" . "PRINT_FILES" I see "FORM_TYPE" is "5224A" where "PART_NO" is "<juror_number>"
#	Then on "JUROR" . "PRINT_FILES" I see "DIGITAL_COMMS" is "Y" where "PART_NO" is "<juror_number>"
#	Then on "JUROR" . "POOL" I see "NOTIFICATIONS" is null where "PART_NO" is "<juror_number>"
	
Examples:
|part_no	|pool_no 	|last_name 			|postcode 	|email					|
|645700185	|457170401	|LNAMEONEEIGHTFIVE	|SA1 4PF	|e@mail.com	|

@comms
Scenario Outline: 1st Party Welsh Deferral refused, 5 weeks in advance, PNC pass
	Given I am on "Public" "juror-test01"
	Given I have cleared down the juror digital database
	Given the juror numbers have not been processed
	|part_no		|pool_no 	|Owner 		|
	|645700237		|457170401 	|400		|
	Given auto straight through processing has been enabled new schema
	And "<juror_number>" has "RET_DATE" as "3 mondays time"
	And "<juror_number>" has "NEXT_DATE" as "3 mondays time"
#	And I have submitted a first party Welsh deferral response
#	| part_no		|pool_number| last_name		|postcode	| email |
#	|<part_no>		|<pool_no>	| <last_name>	|<postcode>	|<email>|

	And I have submitted a first party English deferral response
	| part_no		|pool_number| last_name		|postcode	| email |
	|<part_no>		|<pool_no>	| <last_name>	|<postcode>	|<email>|

	Given I am on "Bureau" "juror-test01"	
	And I log in as "MODTESTBUREAU"
	
	When I click on the "Search" link
	And I set "Juror number" to "<juror_number>"
	And I press the "Search" button
	And I click on "<juror_number>" in the same row as "<juror_number>"
#	Then I see "Summoned" on the page
	
	When I select "Deferral" from Process reply
	And I set the radio button to "Refuse deferral"

	And I select "O - OTHER" from the "Reason for deferral request" dropdown
	And I press the "Mark as completed" button
	Then I see "Completed" on the page
	
	#DB checks (Do PNC PASS)
	And "<juror_number>" has "POLICE_CHECK" as "P"
	And "<juror_number>" has "PHOENIX_CHECKED" as "C"
	
	#def denied and conformation letter generated
	Given a confirmation letter is generated for juror "<juror_number>"
	Given a deferral denied letter is generated for juror "<juror_number>"
	
#	Then on "JUROR" . "PRINT_FILES" I see "FORM_TYPE" is "5224A" where "PART_NO" is "<juror_number>"
#	Then on "JUROR" . "PRINT_FILES" I see "DIGITAL_COMMS" is "Y" where "PART_NO" is "<juror_number>"
#	Then on "JUROR" . "POOL" I see "NOTIFICATIONS" is null where "PART_NO" is "<juror_number>"
	
Examples:
|part_no		|pool_no 	|last_name 			|postcode 	|email					|
|645700237		|457170401	|LNAMETWOTHREESEVEN	|SA1 4PF	|e@mail.com	|

@comms
Scenario Outline: 3rd Party Deferral refused, 5 weeks in advance, PNC pass
	Given I am on "Public" "juror-test01"
	Given I have cleared down the juror digital database
	Given the juror numbers have not been processed
	|part_no	|pool_no 	|Owner 		|
	|<part_no>	|<pool_no> 	|400		|
	Given auto straight through processing has been enabled new schema
	And "<juror_number>" has "RET_DATE" as "3 mondays time"
	And "<juror_number>" has "NEXT_DATE" as "3 mondays time"
	And I have submitted a third party English deferral response
	| part_no		|pool_number| last_name		|postcode	| email |
	|<part_no>		|<pool_no>	| <last_name>	|<postcode>	|<email>|

	Given I am on "Bureau" "juror-test01"	
	And I log in as "MODTESTBUREAU"
	
	When I click on the "Search" link
	And I set "Juror number" to "<juror_number>"
	And I press the "Search" button
	And I click on "<juror_number>" in the same row as "<juror_number>"
	Then I see "Summoned" on the page
	
	When I select "Deferral" from Process reply
	And I set the radio button to "Refuse deferral"

	And I select "O - OTHER" from the "Reason for deferral request" dropdown
	And I press the "Mark as completed" button
	Then I see "Completed" on the page
	
	#DB checks (Do PNC PASS)
	And "<juror_number>" has "POLICE_CHECK" as "P"
	And "<juror_number>" has "PHOENIX_CHECKED" as "C"
	
	#def denied and conformation letter generated
	Given a confirmation letter is generated for juror "<juror_number>"
	Given a deferral denied letter is generated for juror "<juror_number>"
	
#	Then on "JUROR" . "PRINT_FILES" I see "FORM_TYPE" is "5224A" where "PART_NO" is "<juror_number>"
#	Then on "JUROR" . "PRINT_FILES" I see "DIGITAL_COMMS" is "Y" where "PART_NO" is "<juror_number>"
#	Then on "JUROR" . "POOL" I see "NOTIFICATIONS" is null where "PART_NO" is "<juror_number>"
	
Examples:
|part_no	|pool_no 	|last_name 			|postcode 	|email					|
|645200891	|452170401	|LNAMEEIGHTNINEONE	|SY2 6LU	|e@mail.com	|

@comms 
Scenario Outline: 3rd Party Welsh Deferral refused, 5 weeks in advance, PNC pass
	Given I am on "Public" "juror-test01"
	Given I have cleared down the juror digital database
	Given the juror numbers have not been processed
	|part_no	|pool_no 	|Owner 		|
	|645700246	|457170401	|400		|
	Given auto straight through processing has been enabled new schema
	And "<juror_number>" has "RET_DATE" as "3 mondays time"
	And "<juror_number>" has "NEXT_DATE" as "3 mondays time"
#	And I have submitted a third party Welsh deferral response
#	| part_no		|pool_number| last_name		|postcode	| email |
#	|<part_no>		|<pool_no>	| <last_name>	|<postcode>	|<email>|

	And I have submitted a third party English deferral response
	| part_no		|pool_number| last_name		|postcode	| email |
	|<part_no>		|<pool_no>	| <last_name>	|<postcode>	|<email>|

	Given I am on "Bureau" "juror-test01"	
	And I log in as "MODTESTBUREAU"
	
	When I click on the "Search" link
	And I set "Juror number" to "<juror_number>"
	And I press the "Search" button
	And I click on "<juror_number>" in the same row as "<juror_number>"
#	Then I see "Summoned" on the page
	
	When I select "Deferral" from Process reply
	And I set the radio button to "Refuse deferral"

	And I select "O - OTHER" from the "Reason for deferral request" dropdown
	And I press the "Mark as completed" button
	Then I see "Completed" on the page
	
	#DB checks (Do PNC PASS)
	And "<juror_number>" has "POLICE_CHECK" as "P"
	And "<juror_number>" has "PHOENIX_CHECKED" as "C"
	
	#def denied and conformation letter generated
	Given a confirmation letter is generated for juror "<juror_number>"
	Given a deferral denied letter is generated for juror "<juror_number>"
	
#	Then on "JUROR" . "PRINT_FILES" I see "FORM_TYPE" is "5224A" where "PART_NO" is "<juror_number>"
#	Then on "JUROR" . "PRINT_FILES" I see "DIGITAL_COMMS" is "Y" where "PART_NO" is "<juror_number>"
#	Then on "JUROR" . "POOL" I see "NOTIFICATIONS" is null where "PART_NO" is "<juror_number>"
	
Examples:
|part_no	|pool_no 	|last_name 			|postcode 	|email					|
|645700246	|457170401	|LNAMETWOFOURSIX	|SY2 6LU	|e@mail.com	|

@comms
Scenario Outline: 3rd Party Welsh Postponement, 5 weeks in advance, PNC pass
	Given I am on "Public" "juror-test01"
	Given I have cleared down the juror digital database
	Given the juror numbers have not been processed
	|part_no		|pool_no 	|Owner 		|
	|645700260		|457170401	|400		|
	Given auto straight through processing has been enabled new schema


	And I have submitted a third party Welsh ineligibilty response
	| part_no		|pool_number| last_name		|postcode	| email |
	|<part_no>		|<pool_no>	| <last_name>	|<postcode>	|<email>|

#	And I have submitted a third party English ineligibilty response
#	| part_no		|pool_number| last_name		|postcode	| email |
#	|<part_no>		|<pool_no>	| <last_name>	|<postcode>	|<email>|

	Given I am on "Bureau" "juror-test01"	
	And I log in as "MODTESTBUREAU"
	
	When I click on the "Search" link
	And I set "Juror number" to "<juror_number>"
	And I press the "Search" button
	And I click on "<juror_number>" in the same row as "<juror_number>"
	Then I see "Summoned" on the page
	
	When I select "Deferral" from Process reply
	And I set the radio button to "Accept deferral"
	Then I see "Defer until" on the page
	
	When I set "Defer until" to "{7 mondays time}"
	And I select "P - POSTPONEMENT OF SERVICE" from the "Reason for deferral request" dropdown
	And I press the "Mark as completed" button
	Then I see "Completed" on the page
	
	#DB checks (Do PNC PASS)
	And "<juror_number>" has "POLICE_CHECK" as "P"
	And "<juror_number>" has "PHOENIX_CHECKED" as "C"
	
	#postponse letter generated
	Given a postponement letter is generated for juror "<juror_number>"
	
#	Then on "JUROR" . "PRINT_FILES" I see "FORM_TYPE" is "5224A" where "PART_NO" is "<juror_number>"
#	Then on "JUROR" . "PRINT_FILES" I see "DIGITAL_COMMS" is "Y" where "PART_NO" is "<juror_number>"
#	Then on "JUROR" . "POOL" I see "NOTIFICATIONS" is null where "PART_NO" is "<juror_number>"
	
Examples:
|part_no		|pool_no 	|last_name 			|postcode 	|email					|
|645700260		|457170401	|LNAMETWOSIXZERO	|SA1 4PF	|e@mail.com	|

@comms 
Scenario Outline: 1st Party Welsh Postponement, 5 weeks in advance, PNC pass
	Given I am on "Public" "juror-test01"
	Given I have cleared down the juror digital database
	Given the juror numbers have not been processed
	|part_no	|pool_no 	|Owner 		|
	|645700786	|457170401	|400		|
	Given auto straight through processing has been enabled new schema


	And I have submitted a first party Welsh ineligibilty response
	| part_no		|pool_number| last_name		|postcode	| email |
	|<part_no>		|<pool_no>	| <last_name>	|<postcode>	|<email>|

#	And I have submitted a first party English ineligibilty response
#	| part_no		|pool_number| last_name		|postcode	| email |
#	|<part_no>		|<pool_no>	| <last_name>	|<postcode>	|<email>|

	Given I am on "Bureau" "juror-test01"	
	And I log in as "MODTESTBUREAU"
	
	When I click on the "Search" link
	And I set "Juror number" to "<juror_number>"
	And I press the "Search" button
	And I click on "<juror_number>" in the same row as "<juror_number>"
	Then I see "Summoned" on the page
	
	When I select "Deferral" from Process reply
	And I set the radio button to "Accept deferral"
	Then I see "Defer until" on the page
	
	When I set "Defer until" to "{7 mondays time}"
	And I select "P - POSTPONEMENT OF SERVICE" from the "Reason for deferral request" dropdown
	And I press the "Mark as completed" button
	Then I see "Completed" on the page
	
	#DB checks (Do PNC PASS)
	And "<juror_number>" has "POLICE_CHECK" as "P"
	And "<juror_number>" has "PHOENIX_CHECKED" as "C"
	
	#postponse letter generated
	Given a postponement letter is generated for juror "<juror_number>"
	
#	Then on "JUROR" . "PRINT_FILES" I see "FORM_TYPE" is "5224A" where "PART_NO" is "<juror_number>"
#	Then on "JUROR" . "PRINT_FILES" I see "DIGITAL_COMMS" is "Y" where "PART_NO" is "<juror_number>"
#	Then on "JUROR" . "POOL" I see "NOTIFICATIONS" is null where "PART_NO" is "<juror_number>"
	
Examples:
|part_no	|pool_no 	|last_name 			|postcode 	|email					|
|645700786	|457170401	|LNAMESEVENEIGHTSIX	|SA1 4PF	|e@mail.com	|


@comms
Scenario Outline: 3rd Party Postponement, 5 weeks in advance, PNC pass
	Given I am on "Public" "juror-test01"
	Given I have cleared down the juror digital database
	Given the juror numbers have not been processed
	|part_no		|pool_no 	|Owner 		|
	|<part_no>		|<pool_no>	|400		|
	Given auto straight through processing has been enabled new schema
	And "<juror_number>" has "RET_DATE" as "1 mondays time"
	And "<juror_number>" has "NEXT_DATE" as "1 mondays time"
	And "<juror_number>" has "READ_ONLY" as "Y"
	And I have submitted a third party English ineligibilty response
	| part_no		|pool_number| last_name		|postcode	| email |
	|<part_no>		|<pool_no>	| <last_name>	|<postcode>	|<email>|

#	Given I am on "Bureau" "juror-test01"	
#	And I log in as "MODTESTBUREAU"
#	
#	When I click on the "Search" link
#	And I set "Juror number" to "<juror_number>"
#	And I press the "Search" button
#	And I click on "<juror_number>" in the same row as "<juror_number>"
#	Then I see "Summoned" on the page
#	
#	When I select "Deferral" from Process reply
#	And I set the radio button to "Accept deferral"
#	Then I see "Defer until" on the page
#	
#	When I set "Defer until" to "{7 mondays time}"
#	And I select "P - POSTPONEMENT OF SERVICE" from the "Reason for deferral request" dropdown
#	And I press the "Mark as completed" button
#	Then I see "Completed" on the page
#	
#	#DB checks (Do PNC PASS)
#	And "<juror_number>" has "POLICE_CHECK" as "P"
#	And "<juror_number>" has "PHOENIX_CHECKED" as "C"
#	
#	#postponse letter generated
#	Given a postponement letter is generated for juror "<juror_number>"
#	
#	Then on "JUROR" . "PRINT_FILES" I see "FORM_TYPE" is "5224A" where "PART_NO" is "<juror_number>"
#	Then on "JUROR" . "PRINT_FILES" I see "DIGITAL_COMMS" is "Y" where "PART_NO" is "<juror_number>"
#	Then on "JUROR" . "POOL" I see "NOTIFICATIONS" is null where "PART_NO" is "<juror_number>"
	
Examples:
|part_no		|pool_no 	|last_name 	|postcode 	|email					|
|645100592		|451170401	|DOE		|SW1H 9AJ	|e@mail.com	|
