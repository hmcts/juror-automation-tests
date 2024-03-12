Feature: JDB-4172

#//check data
#select * from juror.print_files where part_no in ('741500438','741500586','645700112','645700090')
#select * from pool where part_no in ('741500438','741500586','645700112','645700090')
#select * from unique_pool where pool_no='415181001'
#select * from form_attr where form_type like '5224%'
#select * from juror_digital.juror_response where juror_number in ('741500438','741500586','645700112','645700090')

#//delete data
#delete from juror.print_files where extracted_flag is null and part_no in ('741500438','741500586','645700112','645700090');
#delete from juror.print_files where extracted_flag ='Y' and part_no in ('741500438','741500586','645700112','645700090')
#delete from juror.pool where pool_no ='415181001' and owner <>'400'
#delete from juror.pool where pool_no ='457170401' and owner <>'400'
#update unique_pool set read_only='N' where pool_no='415181001' and owner='400'
#update unique_pool set read_only='Y' where pool_no='415181001' and owner='415'
#update unique_pool set read_only='N' where pool_no='457170401' and owner='400'
#update unique_pool set read_only='Y' where pool_no='457170401' and owner='457'

#//create letters
#INSERT into print_files (printfile_name, creation_date, form_type, detail_rec,extracted_flag,part_no,digital_comms)
#select to_char(sysdate,'YYYYMMDDHH24MMSS')||decode(upper(p.welsh),'Y','C',NULL,'E','E'),
#sysdate,
#decode(upper(p.welsh),'Y','5224AC',NULL,'5224A','5224A'), -- using flag on record in pool table
#rpad(to_char((sysdate+2),'DD FMMONTH YYYY'),18,' ')
#	|| cc.loc_code
#	|| decode(DECODE(upper(p.welsh),'Y','W',NULL,'E','E'),
#	      'W', RPAD(upper(cc.loc_name),40),
#		  'E', decode(cc.loc_code,'626',RPAD(upper(cc.loc_name),59), RPAD('The Crown Court at '||upper(cc.loc_name),59)))
#	|| upper('Jury Central Summoning Bureau           The Court Service                  Freepost Lon 19669                 Pocock Street                      London                             SE1 0YG                                                                         0845 3555567            ')
#	|| RPAD(Rtrim(to_char(p.next_date,'DAY')) || ' ' 
#	|| to_char(p.next_date,'DD')		   || ' ' 
#  || Rtrim(to_char(p.next_date,'MONTH')) ||', '
#	|| to_char(p.next_date,'YYYY'),32,' ')
#	|| Rpad(decode(u.attend_time,
#                        null,
#                        nvl(decode(sign(instr(cc.loc_attend_time,'AM')),0,cc.loc_attend_time||'AM',cc.loc_attend_time),'9.00 AM'),
#                        to_char(u.attend_time,'hh:miAM')),
#                     8,' ')
#	|| RPAD(NVL(p.title,' '),10,' ') || RPAD(NVL(p.fname,' '),20,' ') || RPAD(NVL(p.lname,' '),20,' ')
#  || RPAD(RPAD(NVL(p.address,' '),35) || RPAD(p.address2,35) || RPAD(p.address3,35) || RPAD(p.address4,35) || RPAD(p.address5,35) || RPAD(p.address6,35)
#  || RPAD(p.zip,10),220)
#  || RPAD(NVL(p.part_no,' '),9,' ')
#	|| upper('Jury Manager                  '),
#null,p.part_no,'N'
#FROM  pool p, unique_pool u, court_location cc
#WHERE p.pool_no = u.pool_no
# AND  p.owner = '400'
# AND	u.owner = '400'
# AND	cc.loc_code = u.loc_code
#and p.part_no in ('741500438','741500586','645700112','645700090'); 

#run cron job

#transfer pool

#run cron job



@comms @conf_lett
Scenario Outline: 1st Party English ST, answers in English
	Given I am on "Public" "juror-test01"
	Given I have cleared down the juror digital database
	Given the juror numbers have not been processed
	|part_no	|pool_no 	|Owner 	|
	|<part_no>	|<pool_no> 	|400	|
	Given auto straight through processing has been enabled
	And "<juror_number>" has "RET_DATE" as "1 mondays time"
	And "<juror_number>" has "NEXT_DATE" as "1 mondays time"
	And I have submitted a first party English straight through response
	|part_no	|pool_number| last_name		|postcode	| email |
	|<part_no>	|<pool_no>	| <last_name>	|<postcode>	|<email>|

	Given I am on "Bureau" "juror-test01"	
	And I log in as "SYSTEM"
	
	When I click on the "Search" link
	And I set "Juror number" to "<juror_number>"
	And I press the "Search" button
	And I click on "<juror_number>" in the same row as "<juror_number>"
	
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
	
	Then on "JUROR" . "PRINT_FILES" I see "FORM_TYPE" is "5224A" where "PART_NO" is "<juror_number>"
	Then on "JUROR" . "PRINT_FILES" I see "DIGITAL_COMMS" is "Y" where "PART_NO" is "<juror_number>"
	Then on "JUROR" . "POOL" I see "NOTIFICATIONS" is null where "PART_NO" is "<juror_number>"
	
Examples:
|part_no		|pool_no 	|last_name 				|postcode 	|email					|
|741500438		|415181001 	|LNAMEFOURTHREEEIGHT	|CH1 2AN	|e@mail.com	|

@comms @conf_lett
Scenario Outline: 1st Party English ST, answers in Welsh
	Given I am on "Public" "juror-test01"
	Given I have cleared down the juror digital database
	Given the juror numbers have not been processed
	|part_no	|pool_no 	|Owner 	|
	|<part_no>	|<pool_no> 	|400	|
	Given auto straight through processing has been enabled
	And "<juror_number>" has "RET_DATE" as "1 mondays time"
	And "<juror_number>" has "NEXT_DATE" as "1 mondays time"
	And I have submitted a first party Welsh straight through response
	|part_no	|pool_number|last_name		|postcode	|email |
	|<part_no>	|<pool_no>	|<last_name>	|<postcode>	|<email>|
	
#	And I have submitted a first party English straight through response
#	| part_no		|pool_number| last_name		|postcode	| email |
#	|<part_no>		|<pool_no>	| <last_name>	|<postcode>	|<email>|

	#Currently an issue with 4 weeks and urgents JDB-4010 (ONLY ON FRIDAY)

	Given I am on "Bureau" "juror-test01"	
	And I log in as "SYSTEM"
	
	When I click on the "Search" link
	And I set "Juror number" to "<juror_number>"
	And I press the "Search" button
	And I click on "<juror_number>" in the same row as "<juror_number>"

##	#process in Bureau as Responded
#	When I select "Responded" from Process reply
#	And I check the "Mark juror as 'responded'" checkbox
#	And I press the "Confirm" button
#	Then I see "Completed" on the page
	
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
|741500586		|415181001 	|LNAMEFIVEEIGHTSIX		|CH1 2AN	|e@mail.com	|

@comms @conf_lettx
Scenario Outline: 1st Party Welsh ST, answers in Welsh
	Given I am on "Public" "juror-test01"
	Given I have cleared down the juror digital database
	Given the juror numbers have not been processed
	|part_no		|pool_no 	|Owner 		|
	|<part_no>		|<pool_no>	|400		|
	Given auto straight through processing has been enabled
	And "<juror_number>" has "RET_DATE" as "1 mondays time"
	And "<juror_number>" has "NEXT_DATE" as "1 mondays time"
	And I have submitted a first party Welsh straight through response
	|part_no	|pool_number|last_name	|postcode	|email |
	|<part_no>	|<pool_no>	|<last_name>|<postcode>	|<email>|

#	And I have submitted a first party English straight through response
#	| part_no		|pool_number| last_name		|postcode	| email |
#	|<part_no>		|<pool_no>	| <last_name>	|<postcode>	|<email>|
	
	Given I am on "Bureau" "juror-test01"	
	And I log in as "SYSTEM"
	
	When I click on the "Search" link
	And I set "Juror number" to "<juror_number>"
	And I press the "Search" button
	And I click on "<juror_number>" in the same row as "<juror_number>"

#	#process in Bureau as Responded
#	When I select "Responded" from Process reply
	And I check the "Mark juror as 'responded'" checkbox
	And I press the "Confirm" button
#	Then I see "Completed" on the page
	
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
|645700090		|457170401 	|LNAMENINEZERO			|SA1 4PF	|e@mail.com	|

@comms @conf_lett
Scenario Outline: 1st Party Welsh ST, answers in English
	Given I am on "Public" "juror-test01"
	Given I have cleared down the juror digital database
	Given the juror numbers have not been processed
	|part_no		|pool_no 	|Owner 		|
	|<part_no>		|<pool_no> 	|400		|
	Given auto straight through processing has been enabled
	And "<juror_number>" has "RET_DATE" as "1 mondays time"
	And "<juror_number>" has "NEXT_DATE" as "1 mondays time"
#	And I have submitted a first party Welsh straight through response
#	| part_no		|pool_number| last_name		|postcode	| email |
#	|<part_no>		|<pool_no>	| <last_name>	|<postcode>	|<email>|

	And I have submitted a first party English straight through response
	|part_no	|pool_number|last_name	|postcode	|email |
	|<part_no>	|<pool_no>	|<last_name>|<postcode>	|<email>|

	#Currently an issue with 4 weeks and urgents JDB-4010 (ONLY ON FRIDAY)

	Given I am on "Bureau" "juror-test01"	
	And I log in as "SYSTEM"
	
	When I click on the "Search" link
	And I set "Juror number" to "<juror_number>"
	And I press the "Search" button
	And I click on "<juror_number>" in the same row as "<juror_number>"
#	Then I see "Summoned" on the page
#	And I see "Urgent" on the page
#	
#	#process in Bureau as Responded
#	When I select "Responded" from Process reply
#	And I check the "Mark juror as 'responded'" checkbox
#	And I press the "Confirm" button
#	Then I see "Completed" on the page
	
	#DB checks (Do PNC PASS)
	And "<juror_number>" has "POLICE_CHECK" as "P"
	And "<juror_number>" has "PHOENIX_CHECKED" as "C"
	
	#conf letter generated
#	Given a confirmation letter is generated for juror "<juror_number>"
		
#	Then on "JUROR" . "PRINT_FILES" I see "FORM_TYPE" is "5224A" where "PART_NO" is "<juror_number>"
#	Then on "JUROR" . "PRINT_FILES" I see "DIGITAL_COMMS" is "Y" where "PART_NO" is "<juror_number>"
#	Then on "JUROR" . "POOL" I see "NOTIFICATIONS" is null where "PART_NO" is "<juror_number>"
	
Examples:
|part_no		|pool_no 	|last_name 		|postcode 	|email					|
|645700112		|457170401 	|LNAMEONEONETWO	|SA1 4PF	|e@mail.com	|

@comms @withdraw_lett
Scenario Outline: 1st Party English ST, responds in English
	Given I am on "Public" "juror-test01"
	Given I have cleared down the juror digital database
	Given the juror numbers have not been processed
	|part_no	|pool_no 	|Owner 	|
	|<part_no>	|<pool_no> 	|400	|
	Given auto straight through processing has been enabled
	And "<juror_number>" has "RET_DATE" as "2 mondays time"
	And "<juror_number>" has "NEXT_DATE" as "2 mondays time"
	And I have submitted a first party English straight through response
	| part_no		|pool_number| last_name		|postcode	| email |
	|<part_no>		|<pool_no>	| <last_name>	|<postcode>	|<email>|
	
	Given I am on "Bureau" "juror-test01"	
	And I log in as "SYSTEM"
	
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
#	Given a disqualified letter is generated for juror "<juror_number>"
	
#	Then on "JUROR" . "PRINT_FILES" I see "FORM_TYPE" is "5224" where "PART_NO" is "<juror_number>"
#	Then on "JUROR" . "PRINT_FILES" I see "DIGITAL_COMMS" is "Y" where "PART_NO" is "<juror_number>"
#	Then on "JUROR" . "POOL" I see "NOTIFICATIONS" is null where "PART_NO" is "<juror_number>"
	
Examples:
|part_no		|pool_no 	|last_name 				|postcode 	|email					|
|741500438		|415181001 	|LNAMEFOURTHREEEIGHT	|CH1 2AN	|e@mail.com	|

@comms @withdraw_lett
Scenario Outline: 1st Party Welsh Age Disqualified, responds in Welsh
	Given I am on "Public" "juror-test01"
	Given I have cleared down the juror digital database
	Given the juror numbers have not been processed
	|part_no	|pool_no 	|Owner 		|
	|<part_no>	|<pool_no>	|400		|
	Given auto straight through processing has been enabled
	And "<juror_number>" has "RET_DATE" as "4 mondays time"
	And "<juror_number>" has "NEXT_DATE" as "4 mondays time"
	And I have submitted a first party Welsh underage response
	|part_no	|pool_number|last_name	|postcode	|email |
	|<part_no>	|<pool_no>	|<last_name>|<postcode>	|<email>|
	
#	And I have submitted a first party English underage response
#	| part_no		|pool_number| last_name		|postcode	| email |
#	|<part_no>		|<pool_no>	| <last_name>	|<postcode>	|<email>|

	Given I am on "Bureau" "juror-test01"	
	And I log in as "SYSTEM"
	
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
|part_no	|pool_no 	|last_name 		|postcode 	|email					|
|645700090	|457170401 	|LNAMENINEZERO	|SA1 4PF	|e@mail.com	|

@comms @withdraw_lett
Scenario Outline: 1st Party English ST, responds in Welsh
	Given I am on "Public" "juror-test01"
	Given I have cleared down the juror digital database
	Given the juror numbers have not been processed
	|part_no	|pool_no 	|Owner 	|
	|<part_no>	|<pool_no> 	|400	|
	Given auto straight through processing has been enabled
	And "<juror_number>" has "RET_DATE" as "2 mondays time"
	And "<juror_number>" has "NEXT_DATE" as "2 mondays time"
	And I have submitted a first party Welsh straight through response
	|part_no	|pool_number|last_name	|postcode	| email |
	|<part_no>	|<pool_no>	|<last_name>|<postcode>	|<email>|
	
	Given I am on "Bureau" "juror-test01"	
	And I log in as "SYSTEM"
	
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
#	Given a disqualified letter is generated for juror "<juror_number>"
	
#	Then on "JUROR" . "PRINT_FILES" I see "FORM_TYPE" is "5224" where "PART_NO" is "<juror_number>"
#	Then on "JUROR" . "PRINT_FILES" I see "DIGITAL_COMMS" is "Y" where "PART_NO" is "<juror_number>"
#	Then on "JUROR" . "POOL" I see "NOTIFICATIONS" is null where "PART_NO" is "<juror_number>"
	
Examples:
|part_no	|pool_no 	|last_name 			|postcode 	|email					|
|741500586	|415181001 	|LNAMEFIVEEIGHTSIX	|CH1 2AN	|e@mail.com	|

@comms @withdraw_lett
Scenario Outline: 1st Party Welsh Age Disqualified, responds in English
	Given I am on "Public" "juror-test01"
	Given I have cleared down the juror digital database
	Given the juror numbers have not been processed
	|part_no	|pool_no 	|Owner 	|
	|<part_no>	|<pool_no>	|400	|
	Given auto straight through processing has been enabled
	And "<juror_number>" has "RET_DATE" as "4 mondays time"
	And "<juror_number>" has "NEXT_DATE" as "4 mondays time"
#	And I have submitted a first party Welsh underage response
#	|part_no	|pool_number|last_name	|postcode	|email |
#	|<part_no>	|<pool_no>	|<last_name>|<postcode>	|<email>|
	
	And I have submitted a first party English underage response
	| part_no		|pool_number| last_name		|postcode	| email |
	|<part_no>		|<pool_no>	| <last_name>	|<postcode>	|<email>|

	Given I am on "Bureau" "juror-test01"	
	And I log in as "SYSTEM"
	
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
|part_no	|pool_no 	|last_name 		|postcode 	|email				|
|645700112	|457170401 	|LNAMEONEONETWO	|SA1 4PF	|e@mail.com|

@comms @refuse_excuse_lett
Scenario Outline: 1st Party Welsh Excusal refused, juror replies in English
	Given I am on "Public" "juror-test01"
	Given I have cleared down the juror digital database
	Given the juror numbers have not been processed
	|part_no	|pool_no 	|Owner 	|
	|<part_no>	|<pool_no> 	|400	|
	Given auto straight through processing has been enabled
	And "<juror_number>" has "RET_DATE" as "4 mondays time"
	And "<juror_number>" has "NEXT_DATE" as "4 mondays time"
#	And I have submitted a first party Welsh excusal response
#	| part_no		|pool_number| last_name		|postcode	| email |
#	|<part_no>		|<pool_no>	| <last_name>	|<postcode>	|<email>|

	And I have submitted a first party English excusal response
	|part_no	|pool_number|last_name	|postcode	| email |
	|<part_no>	|<pool_no>	|<last_name>|<postcode>	|<email>|

	Given I am on "Bureau" "juror-test01"	
	And I log in as "SYSTEM"
	
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
|645700112	|457170401 	|LNAMEONEONETWO	|SA1 4PF	|e@mail.com	|

@comms @refuse_excuse_lett
Scenario Outline: 1st Party Welsh Excusal refused, juror replies in Welsh
	Given I am on "Public" "juror-test01"
	Given I have cleared down the juror digital database
	Given the juror numbers have not been processed
	|part_no	|pool_no 	|Owner 	|
	|<part_no>	|<pool_no> 	|400	|
	Given auto straight through processing has been enabled
	And "<juror_number>" has "RET_DATE" as "4 mondays time"
	And "<juror_number>" has "NEXT_DATE" as "4 mondays time"
	And I have submitted a first party Welsh excusal response
	|part_no	|pool_number|last_name	|postcode	| email |
	|<part_no>	|<pool_no>	|<last_name>|<postcode>	|<email>|

#	And I have submitted a first party English excusal response
#	|part_no	|pool_number|last_name	|postcode	| email |
#	|<part_no>	|<pool_no>	|<last_name>|<postcode>	|<email>|

	Given I am on "Bureau" "juror-test01"	
	And I log in as "SYSTEM"
	
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
|645700090	|457170401 	|LNAMENINEZERO	|SA1 4PF	|e@mail.com	|

@comms @refuse_excuse_lett
Scenario Outline: 1st Party English Excusal refused, juror replies in Welsh
	Given I am on "Public" "juror-test01"
	Given I have cleared down the juror digital database
	Given the juror numbers have not been processed
	|part_no	|pool_no 	|Owner 	|
	|<part_no>	|<pool_no> 	|400	|
	Given auto straight through processing has been enabled
	And "<juror_number>" has "RET_DATE" as "4 mondays time"
	And "<juror_number>" has "NEXT_DATE" as "4 mondays time"
	And I have submitted a first party Welsh excusal response
	|part_no	|pool_number|last_name	|postcode	| email |
	|<part_no>	|<pool_no>	|<last_name>|<postcode>	|<email>|

#	And I have submitted a first party English excusal response
#	|part_no	|pool_number|last_name	|postcode	| email |
#	|<part_no>	|<pool_no>	|<last_name>|<postcode>	|<email>|

	Given I am on "Bureau" "juror-test01"	
	And I log in as "SYSTEM"
	
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
|741500586	|415181001 	|LNAMEFIVEEIGHTSIX	|CH1 2AN	|e@mail.com	|

@comms @refuse_excuse_lett
Scenario Outline: 1st Party English Excusal refused, juror replies in English
	Given I am on "Public" "juror-test01"
	Given I have cleared down the juror digital database
	Given the juror numbers have not been processed
	|part_no	|pool_no 	|Owner 	|
	|<part_no>	|<pool_no> 	|400	|
	Given auto straight through processing has been enabled
	And "<juror_number>" has "RET_DATE" as "4 mondays time"
	And "<juror_number>" has "NEXT_DATE" as "4 mondays time"
#	And I have submitted a first party Welsh excusal response
#	|part_no	|pool_number|last_name	|postcode	| email |
#	|<part_no>	|<pool_no>	|<last_name>|<postcode>	|<email>|

	And I have submitted a first party English excusal response
	|part_no	|pool_number|last_name	|postcode	| email |
	|<part_no>	|<pool_no>	|<last_name>|<postcode>	|<email>|

	Given I am on "Bureau" "juror-test01"	
	And I log in as "SYSTEM"
	
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
|part_no	|pool_no 	|last_name 				|postcode 	|email					|
|741500438	|415181001 	|LNAMEFOURTHREEEIGHT	|CH1 2AN	|e@mail.com	|

@comms @excusal_lett
Scenario Outline: 1st Party English Excusal accepted, juror responds in English
	Given I am on "Public" "juror-test01"
	Given I have cleared down the juror digital database
	Given the juror numbers have not been processed
	|part_no	|pool_no 	|Owner 	|
	|<part_no>	|<pool_no> 	|400	|
	Given auto straight through processing has been enabled
	And "<juror_number>" has "RET_DATE" as "4 mondays time"
	And "<juror_number>" has "NEXT_DATE" as "4 mondays time"
	And I have submitted a first party English excusal response
	|part_no	|pool_number|last_name	|postcode	|email |
	|<part_no>	|<pool_no>	|<last_name>|<postcode>	|<email>|

	Given I am on "Bureau" "juror-test01"	
	And I log in as "SYSTEM"
	
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
|part_no	|pool_no 	|last_name 			|postcode 	|email					|
|741500438	|415181001 	|LNAMEFOURTHREEEIGHT|CH1 2AN	|e@mail.com	|

@comms @excusal_lett
Scenario Outline: 1st Party English Excusal accepted, juror responds in Welsh
	Given I am on "Public" "juror-test01"
	Given I have cleared down the juror digital database
	Given the juror numbers have not been processed
	|part_no	|pool_no 	|Owner 	|
	|<part_no>	|<pool_no> 	|400	|
	Given auto straight through processing has been enabled
	And "<juror_number>" has "RET_DATE" as "4 mondays time"
	And "<juror_number>" has "NEXT_DATE" as "4 mondays time"
	And I have submitted a first party Welsh excusal response
	|part_no	|pool_number|last_name	|postcode	|email |
	|<part_no>	|<pool_no>	|<last_name>|<postcode>	|<email>|

	Given I am on "Bureau" "juror-test01"	
	And I log in as "SYSTEM"
	
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
|part_no	|pool_no 	|last_name 			|postcode 	|email					|
|741500586	|415181001 	|LNAMEFIVEEIGHTSIX	|CH1 2AN	|e@mail.com	|

@comms @excusal_lett
Scenario Outline: 1st Party English Welsh accepted, juror responds in Welsh
	Given I am on "Public" "juror-test01"
	Given I have cleared down the juror digital database
	Given the juror numbers have not been processed
	|part_no	|pool_no 	|Owner 	|
	|<part_no>	|<pool_no> 	|400	|
	Given auto straight through processing has been enabled
	And "<juror_number>" has "RET_DATE" as "4 mondays time"
	And "<juror_number>" has "NEXT_DATE" as "4 mondays time"
	And I have submitted a first party Welsh excusal response
	|part_no	|pool_number|last_name	|postcode	|email |
	|<part_no>	|<pool_no>	|<last_name>|<postcode>	|<email>|

	Given I am on "Bureau" "juror-test01"	
	And I log in as "SYSTEM"
	
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
|part_no	|pool_no 	|last_name 		|postcode 	|email					|
|645700090	|457170401 	|LNAMENINEZERO	|SA1 4PF	|e@mail.com	|

@comms @excusal_lett
Scenario Outline: 1st Party English Welsh accepted, juror responds in English
	Given I am on "Public" "juror-test01"
	Given I have cleared down the juror digital database
	Given the juror numbers have not been processed
	|part_no	|pool_no 	|Owner 	|
	|<part_no>	|<pool_no> 	|400	|
	Given auto straight through processing has been enabled
	And "<juror_number>" has "RET_DATE" as "4 mondays time"
	And "<juror_number>" has "NEXT_DATE" as "4 mondays time"
	And I have submitted a first party English excusal response
	|part_no	|pool_number|last_name	|postcode	|email |
	|<part_no>	|<pool_no>	|<last_name>|<postcode>	|<email>|

	Given I am on "Bureau" "juror-test01"	
	And I log in as "SYSTEM"
	
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
|part_no	|pool_no 	|last_name 		|postcode 	|email					|
|645700112	|457170401 	|LNAMEONEONETWO	|SA1 4PF	|e@mail.com	|

@comms @deferral_refused_lett
Scenario Outline: 1st Party English Deferral refused, answers in welsh
	Given I am on "Public" "juror-test01"
	Given I have cleared down the juror digital database
	Given the juror numbers have not been processed
	|part_no	|pool_no 	|Owner 	|
	|<part_no>	|<pool_no> 	|400	|
	Given auto straight through processing has been enabled
	And "<juror_number>" has "RET_DATE" as "4 mondays time"
	And "<juror_number>" has "NEXT_DATE" as "4 mondays time"
	And I have submitted a first party Welsh deferral response
	| part_no		|pool_number| last_name		|postcode	| email |
	|<part_no>		|<pool_no>	| <last_name>	|<postcode>	|<email>|

	Given I am on "Bureau" "juror-test01"	
	And I log in as "SYSTEM"
	
	When I click on the "Search" link
	And I set "Juror number" to "<juror_number>"
	And I press the "Search" button
	And I click on "<juror_number>" in the same row as "<juror_number>"
	Then I see "Summoned" on the page
	
	#process in Bureau as Refuse Def
	When I select "Deferral" from Process reply
	And I set the radio button to "Refuse deferral"
	And I select "O - OTHER" from the "Reason for deferral request" dropdown
	And I press the "Mark as completed" button
	Then I see "Completed" on the page
	
	#DB checks (Do PNC PASS)
	And "<juror_number>" has "POLICE_CHECK" as "P"
	And "<juror_number>" has "PHOENIX_CHECKED" as "C"
	
#	Then on "JUROR" . "PRINT_FILES" I see "FORM_TYPE" is "5224A" where "PART_NO" is "<juror_number>"
#	Then on "JUROR" . "PRINT_FILES" I see "DIGITAL_COMMS" is "Y" where "PART_NO" is "<juror_number>"
#	Then on "JUROR" . "POOL" I see "NOTIFICATIONS" is null where "PART_NO" is "<juror_number>"
	
Examples:
|part_no	|pool_no 	|last_name 			|postcode 	|email					|
|741500586	|415181001 	|LNAMEFIVEEIGHTSIX	|CH1 2AN	|e@mail.com	|

@comms @deferral_refused_lett
Scenario Outline: 1st Party English Deferral refused, answers in english
	Given I am on "Public" "juror-test01"
	Given I have cleared down the juror digital database
	Given the juror numbers have not been processed
	|part_no	|pool_no 	|Owner 	|
	|<part_no>	|<pool_no> 	|400	|
	Given auto straight through processing has been enabled
	And "<juror_number>" has "RET_DATE" as "4 mondays time"
	And "<juror_number>" has "NEXT_DATE" as "4 mondays time"
	And I have submitted a first party English deferral response
	| part_no		|pool_number| last_name		|postcode	| email |
	|<part_no>		|<pool_no>	| <last_name>	|<postcode>	|<email>|

	Given I am on "Bureau" "juror-test01"	
	And I log in as "SYSTEM"
	
	When I click on the "Search" link
	And I set "Juror number" to "<juror_number>"
	And I press the "Search" button
	And I click on "<juror_number>" in the same row as "<juror_number>"
	Then I see "Summoned" on the page

	#process in Bureau as Refuse Def
	When I select "Deferral" from Process reply
	And I set the radio button to "Refuse deferral"
	And I select "O - OTHER" from the "Reason for deferral request" dropdown
	And I press the "Mark as completed" button
	Then I see "Completed" on the page
	
	#DB checks (Do PNC PASS)
	And "<juror_number>" has "POLICE_CHECK" as "P"
	And "<juror_number>" has "PHOENIX_CHECKED" as "C"
	
#	Then on "JUROR" . "PRINT_FILES" I see "FORM_TYPE" is "5224A" where "PART_NO" is "<juror_number>"
#	Then on "JUROR" . "PRINT_FILES" I see "DIGITAL_COMMS" is "Y" where "PART_NO" is "<juror_number>"
#	Then on "JUROR" . "POOL" I see "NOTIFICATIONS" is null where "PART_NO" is "<juror_number>"
	
Examples:
|part_no	|pool_no 	|last_name 			|postcode 	|email					|
|741500438	|415181001 	|LNAMEFOURTHREEEIGHT|CH1 2AN	|e@mail.com	|

@comms @deferral_refused_lett
Scenario Outline: 1st Party Welsh Deferral refused, answers in english
	Given I am on "Public" "juror-test01"
	Given I have cleared down the juror digital database
	Given the juror numbers have not been processed
	|part_no	|pool_no 	|Owner 	|
	|<part_no>	|<pool_no> 	|400	|
	Given auto straight through processing has been enabled
	And "<juror_number>" has "RET_DATE" as "4 mondays time"
	And "<juror_number>" has "NEXT_DATE" as "4 mondays time"
	And I have submitted a first party English deferral response
	| part_no		|pool_number| last_name		|postcode	| email |
	|<part_no>		|<pool_no>	| <last_name>	|<postcode>	|<email>|

	Given I am on "Bureau" "juror-test01"	
	And I log in as "SYSTEM"
	
	When I click on the "Search" link
	And I set "Juror number" to "<juror_number>"
	And I press the "Search" button
	And I click on "<juror_number>" in the same row as "<juror_number>"
	Then I see "Summoned" on the page
	
	#process in Bureau as Refuse Def
	When I select "Deferral" from Process reply
	And I set the radio button to "Refuse deferral"
	And I select "O - OTHER" from the "Reason for deferral request" dropdown
	And I press the "Mark as completed" button
	Then I see "Completed" on the page
	
	#DB checks (Do PNC PASS)
	And "<juror_number>" has "POLICE_CHECK" as "P"
	And "<juror_number>" has "PHOENIX_CHECKED" as "C"
	
#	Then on "JUROR" . "PRINT_FILES" I see "FORM_TYPE" is "5224A" where "PART_NO" is "<juror_number>"
#	Then on "JUROR" . "PRINT_FILES" I see "DIGITAL_COMMS" is "Y" where "PART_NO" is "<juror_number>"
#	Then on "JUROR" . "POOL" I see "NOTIFICATIONS" is null where "PART_NO" is "<juror_number>"
	
Examples:
|part_no	|pool_no 	|last_name 			|postcode 	|email					|
|645700112	|457170401 	|LNAMEONEONETWO		|SA1 4PF	|e@mail.com	|

@comms @deferral_refused_lett
Scenario Outline: 1st Party Welsh Deferral refused, answers in welsh
	Given I am on "Public" "juror-test01"
	Given I have cleared down the juror digital database
	Given the juror numbers have not been processed
	|part_no	|pool_no 	|Owner 	|
	|<part_no>	|<pool_no> 	|400	|
	Given auto straight through processing has been enabled
	And "<juror_number>" has "RET_DATE" as "4 mondays time"
	And "<juror_number>" has "NEXT_DATE" as "4 mondays time"
	And I have submitted a first party Welsh deferral response
	| part_no		|pool_number| last_name		|postcode	| email |
	|<part_no>		|<pool_no>	| <last_name>	|<postcode>	|<email>|

	Given I am on "Bureau" "juror-test01"	
	And I log in as "SYSTEM"
	
	When I click on the "Search" link
	And I set "Juror number" to "<juror_number>"
	And I press the "Search" button
	And I click on "<juror_number>" in the same row as "<juror_number>"
	Then I see "Summoned" on the page
	
	#process in Bureau as Refuse Def
	When I select "Deferral" from Process reply
	And I set the radio button to "Refuse deferral"
	And I select "O - OTHER" from the "Reason for deferral request" dropdown
	And I press the "Mark as completed" button
	Then I see "Completed" on the page
	
	#DB checks (Do PNC PASS)
	And "<juror_number>" has "POLICE_CHECK" as "P"
	And "<juror_number>" has "PHOENIX_CHECKED" as "C"
	
#	Then on "JUROR" . "PRINT_FILES" I see "FORM_TYPE" is "5224A" where "PART_NO" is "<juror_number>"
#	Then on "JUROR" . "PRINT_FILES" I see "DIGITAL_COMMS" is "Y" where "PART_NO" is "<juror_number>"
#	Then on "JUROR" . "POOL" I see "NOTIFICATIONS" is null where "PART_NO" is "<juror_number>"
	
Examples:
|part_no	|pool_no 	|last_name 		|postcode 	|email					|
|645700090	|457170401 	|LNAMENINEZERO	|SA1 4PF	|e@mail.com	|

@comms @postpone_lett
Scenario Outline: 1st Party Welsh Postponement, responds in English
	Given I am on "Public" "juror-test01"
	Given I have cleared down the juror digital database
	Given the juror numbers have not been processed
	|part_no	|pool_no 	|Owner 		|
	|<part_no>	|<pool_no>	|400		|
	Given auto straight through processing has been enabled
	And "<juror_number>" has "RET_DATE" as "4 mondays time"
	And "<juror_number>" has "NEXT_DATE" as "4 mondays time"
#	And I have submitted a first party Welsh ineligibilty response
#	| part_no		|pool_number| last_name		|postcode	| email |
#	|<part_no>		|<pool_no>	| <last_name>	|<postcode>	|<email>|

	And I have submitted a first party English ineligibilty response
	| part_no		|pool_number| last_name		|postcode	| email |
	|<part_no>		|<pool_no>	| <last_name>	|<postcode>	|<email>|

	Given I am on "Bureau" "juror-test01"	
	And I log in as "SYSTEM"
	
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
#	Given a postponement letter is generated for juror "<juror_number>"
	
#	Then on "JUROR" . "PRINT_FILES" I see "FORM_TYPE" is "5224A" where "PART_NO" is "<juror_number>"
#	Then on "JUROR" . "PRINT_FILES" I see "DIGITAL_COMMS" is "Y" where "PART_NO" is "<juror_number>"
#	Then on "JUROR" . "POOL" I see "NOTIFICATIONS" is null where "PART_NO" is "<juror_number>"
	
Examples:
|part_no	|pool_no 	|last_name 			|postcode 	|email					|
|645700112	|457170401 	|LNAMEONEONETWO		|SA1 4PF	|e@mail.com	|

@comms @postpone_lett
Scenario Outline: 1st Party Welsh Postponement, responds in Welsh
	Given I am on "Public" "juror-test01"
	Given I have cleared down the juror digital database
	Given the juror numbers have not been processed
	|part_no	|pool_no 	|Owner 		|
	|<part_no>	|<pool_no>	|400		|
	Given auto straight through processing has been enabled
	And "<juror_number>" has "RET_DATE" as "4 mondays time"
	And "<juror_number>" has "NEXT_DATE" as "4 mondays time"
	And I have submitted a first party Welsh ineligibilty response
	| part_no		|pool_number| last_name		|postcode	| email |
	|<part_no>		|<pool_no>	| <last_name>	|<postcode>	|<email>|

#	And I have submitted a first party English ineligibilty response
#	| part_no		|pool_number| last_name		|postcode	| email |
#	|<part_no>		|<pool_no>	| <last_name>	|<postcode>	|<email>|

	Given I am on "Bureau" "juror-test01"	
	And I log in as "SYSTEM"
	
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
#	Given a postponement letter is generated for juror "<juror_number>"
	
#	Then on "JUROR" . "PRINT_FILES" I see "FORM_TYPE" is "5224A" where "PART_NO" is "<juror_number>"
#	Then on "JUROR" . "PRINT_FILES" I see "DIGITAL_COMMS" is "Y" where "PART_NO" is "<juror_number>"
#	Then on "JUROR" . "POOL" I see "NOTIFICATIONS" is null where "PART_NO" is "<juror_number>"
	
Examples:
|part_no	|pool_no 	|last_name 		|postcode 	|email					|
|645700090	|457170401 	|LNAMENINEZERO	|SA1 4PF	|e@mail.com	|

@comms @postpone_lett
Scenario Outline: 1st Party English Postponement, responds in English
	Given I am on "Public" "juror-test01"
	Given I have cleared down the juror digital database
	Given the juror numbers have not been processed
	|part_no	|pool_no 	|Owner 		|
	|<part_no>	|<pool_no>	|400		|
	Given auto straight through processing has been enabled
	And "<juror_number>" has "RET_DATE" as "4 mondays time"
	And "<juror_number>" has "NEXT_DATE" as "4 mondays time"
#	And I have submitted a first party Welsh ineligibilty response
#	| part_no		|pool_number| last_name		|postcode	| email |
#	|<part_no>		|<pool_no>	| <last_name>	|<postcode>	|<email>|

	And I have submitted a first party English ineligibilty response
	| part_no		|pool_number| last_name		|postcode	| email |
	|<part_no>		|<pool_no>	| <last_name>	|<postcode>	|<email>|

	Given I am on "Bureau" "juror-test01"	
	And I log in as "SYSTEM"
	
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
#	Given a postponement letter is generated for juror "<juror_number>"
	
#	Then on "JUROR" . "PRINT_FILES" I see "FORM_TYPE" is "5224A" where "PART_NO" is "<juror_number>"
#	Then on "JUROR" . "PRINT_FILES" I see "DIGITAL_COMMS" is "Y" where "PART_NO" is "<juror_number>"
#	Then on "JUROR" . "POOL" I see "NOTIFICATIONS" is null where "PART_NO" is "<juror_number>"
	
Examples:
|part_no	|pool_no 	|last_name 			|postcode 	|email					|
|741500438	|415181001 	|LNAMEFOURTHREEEIGHT|CH1 2AN	|e@mail.com	|

@comms @postpone_lett
Scenario Outline: 1st Party English Postponement, responds in Welsh
	Given I am on "Public" "juror-test01"
	Given I have cleared down the juror digital database
	Given the juror numbers have not been processed
	|part_no	|pool_no 	|Owner 		|
	|<part_no>	|<pool_no>	|400		|
	Given auto straight through processing has been enabled
	And "<juror_number>" has "RET_DATE" as "4 mondays time"
	And "<juror_number>" has "NEXT_DATE" as "4 mondays time"
	And I have submitted a first party Welsh ineligibilty response
	| part_no		|pool_number| last_name		|postcode	| email |
	|<part_no>		|<pool_no>	| <last_name>	|<postcode>	|<email>|

#	And I have submitted a first party English ineligibilty response
#	| part_no		|pool_number| last_name		|postcode	| email |
#	|<part_no>		|<pool_no>	| <last_name>	|<postcode>	|<email>|

	Given I am on "Bureau" "juror-test01"	
	And I log in as "SYSTEM"
	
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
#	Given a postponement letter is generated for juror "<juror_number>"
	
#	Then on "JUROR" . "PRINT_FILES" I see "FORM_TYPE" is "5224A" where "PART_NO" is "<juror_number>"
#	Then on "JUROR" . "PRINT_FILES" I see "DIGITAL_COMMS" is "Y" where "PART_NO" is "<juror_number>"
#	Then on "JUROR" . "POOL" I see "NOTIFICATIONS" is null where "PART_NO" is "<juror_number>"
	
Examples:
|part_no	|pool_no 	|last_name 			|postcode 	|email					|
|741500586	|415181001 	|LNAMEFIVEEIGHTSIX	|CH1 2AN	|e@mail.com	|

@comms @defer_lett
Scenario Outline: 1st Party Welsh Deferral accepted, responds in Welsh
	Given I am on "Public" "juror-test01"
	Given I have cleared down the juror digital database
	Given the juror numbers have not been processed
	|part_no		|pool_no 	|Owner 		|
	|<part_no>		|<pool_no> 	|400		|
	Given auto straight through processing has been enabled


	And I have submitted a first party Welsh deferral response
	| part_no		|pool_number| last_name		|postcode	| email |
	|<part_no>		|<pool_no>	| <last_name>	|<postcode>	|<email>|
	
#	And I have submitted a first party English deferral response
#	| part_no		|pool_number| last_name		|postcode	| email |
#	|<part_no>		|<pool_no>	| <last_name>	|<postcode>	|<email>|

	Given I am on "Bureau" "juror-test01"	
	And I log in as "SYSTEM"
	
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
|part_no	|pool_no 	|last_name 		|postcode 	|email					|
|645700090	|457170401 	|LNAMENINEZERO	|SA1 4PF	|e@mail.com	|

@comms @defer_lett
Scenario Outline: 1st Party Welsh Deferral accepted, responds in English
	Given I am on "Public" "juror-test01"
	Given I have cleared down the juror digital database
	Given the juror numbers have not been processed
	|part_no		|pool_no 	|Owner 		|
	|<part_no>		|<pool_no> 	|400		|
	Given auto straight through processing has been enabled


#	And I have submitted a first party Welsh deferral response
#	| part_no		|pool_number| last_name		|postcode	| email |
#	|<part_no>		|<pool_no>	| <last_name>	|<postcode>	|<email>|
	
	And I have submitted a first party English deferral response
	| part_no		|pool_number| last_name		|postcode	| email |
	|<part_no>		|<pool_no>	| <last_name>	|<postcode>	|<email>|

	Given I am on "Bureau" "juror-test01"	
	And I log in as "SYSTEM"
	
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
|part_no	|pool_no 	|last_name 		|postcode 	|email					|
|645700112	|457170401 	|LNAMEONEONETWO	|SA1 4PF	|e@mail.com	|

@comms @defer_lett
Scenario Outline: 1st Party English Deferral accepted, responds in English
	Given I am on "Public" "juror-test01"
	Given I have cleared down the juror digital database
	Given the juror numbers have not been processed
	|part_no		|pool_no 	|Owner 		|
	|<part_no>		|<pool_no> 	|400		|
	Given auto straight through processing has been enabled


#	And I have submitted a first party Welsh deferral response
#	| part_no		|pool_number| last_name		|postcode	| email |
#	|<part_no>		|<pool_no>	| <last_name>	|<postcode>	|<email>|
	
	And I have submitted a first party English deferral response
	| part_no		|pool_number| last_name		|postcode	| email |
	|<part_no>		|<pool_no>	| <last_name>	|<postcode>	|<email>|

	Given I am on "Bureau" "juror-test01"	
	And I log in as "SYSTEM"
	
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
|part_no	|pool_no 	|last_name 			|postcode 	|email					|
|741500438	|415181001 	|LNAMEFOURTHREEEIGHT|CH1 2AN	|e@mail.com	|

@comms @defer_lett
Scenario Outline: 1st Party English Deferral accepted, responds in Welsh
	Given I am on "Public" "juror-test01"
	Given I have cleared down the juror digital database
	Given the juror numbers have not been processed
	|part_no		|pool_no 	|Owner 		|
	|<part_no>		|<pool_no> 	|400		|
	Given auto straight through processing has been enabled


	And I have submitted a first party Welsh deferral response
	| part_no		|pool_number| last_name		|postcode	| email |
	|<part_no>		|<pool_no>	| <last_name>	|<postcode>	|<email>|
	
#	And I have submitted a first party English deferral response
#	| part_no		|pool_number| last_name		|postcode	| email |
#	|<part_no>		|<pool_no>	| <last_name>	|<postcode>	|<email>|

	Given I am on "Bureau" "juror-test01"	
	And I log in as "SYSTEM"
	
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
|part_no	|pool_no 	|last_name 			|postcode 	|email					|
|741500586	|415181001 	|LNAMEFIVEEIGHTSIX	|CH1 2AN	|e@mail.com	|
