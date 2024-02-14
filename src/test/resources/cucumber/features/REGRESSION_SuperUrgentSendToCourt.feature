Feature: JDB-3759 SuperUrgentSendToCourt

#A response is submitted after pool is transferred to court
#submit a response where read_only='n' and ret_date/next_date is in 1 week
#reg test urgents are still calculated as before
#A response is submitted then transferred to court before being processed in JD -not applicable see JDB-3901 (test manually)
#cover status 11 Awaiting Information (test manually)
#cover assigned/unassigned (test manually with prev test)
#read_only turns to Y before response is U or SU (test manually)

@Regression @JDB-3759 
Scenario Outline: A response is submitted after pool is transferred to court
	
	Given I am on "Public" "bau-test"
	Given the juror numbers have not been processed
		|part_no 	|pool_no 	|owner 	|
		|<part_no> 	|<pool_no>	|400 	|
	
	#Set part_no pool to be 1 monday from now, and transferred to the court
	Given "<part_no>" has "RET_DATE" as "2 mondays time"
	And "<part_no>" has "NEXT_DATE" as "2 mondays time"
	And "<part_no>" has "LNAME" as "<last_name>"
	And "<part_no>" has "ZIP" as "<postcode>"
	And "<part_no>" has "READ_ONLY" as "Y"
	
#	# Attempt to submit response
#	And I set the radio button to "I am replying for myself"
#	And I press the "Continue" button
#	
#	When I set "9-digit juror number" to "<part_no>"
#	When I set "Juror last name" to "<last_name>"
#	When I set "Juror postcode" to "<postcode>"
#	And I press the "Continue" button
#	
#	Then I see "The court date for your jury summons has passed. You cannot reply using this service." on the page
	
	Given I have submitted a first party English straight through response
		|part_no	|pool_number	|last_name		|postcode	|email 	|
		|<part_no>	|<pool_no>		|<last_name>	|<postcode>	|<email>|

	#check status
	
	Then on "JUROR_DIGITAL" . "JUROR_RESPONSE" I see "URGENT" is "N" where "JUROR_NUMBER" is "<part_no>"
	Then on "JUROR_DIGITAL" . "JUROR_RESPONSE" I see "SUPER_URGENT" is "Y" where "JUROR_NUMBER" is "<part_no>"
	
	Given I am on "Bureau" "bau-test" 	
	And I log in as "CPASS"
	
	When I click on the "Search" link
	And I set "Juror number" to "<part_no>"
	And I press the "Search" button
	And I click on "<part_no>" in the same row as "<part_no>"
	
	#check status = summoned
	
	And I see "Summoned" on the page
	And I see "SEND TO COURT" on the page
	
	When I select "PDF sent to court..." from Process reply
	And I check the "PDF sent to court" checkbox
	And I press the "Confirm" button
	
	#now check status
	
	And I see "Summoned" on the page
	And I see "COMPLETED" on the page
	Then on "JUROR_DIGITAL" . "JUROR_RESPONSE" I see "URGENT" is "N" where "JUROR_NUMBER" is "<part_no>"
	Then on "JUROR_DIGITAL" . "JUROR_RESPONSE" I see "SUPER_URGENT" is "Y" where "JUROR_NUMBER" is "<part_no>"
		
Examples:
	|part_no	|pool_no	|last_name			|postcode	|email 					|
	|644200865	|442170401	|LNAMEEIGHTSIXFIVE	|NN1 3HQ	|danielle.bach@cgi.com	|
	
@Regression @JDB-3759 
Scenario Outline: Regression test that Urgents still calculated correctly 
	
	Given I am on "Public" "bau-test"
	Given the juror numbers have not been processed
		|part_no 		|pool_no 	|owner 	|
		|<part_no_one>	|<pool_no>	|400 	|
	
	#Set part_no pool to be 3 mondays from now
	Given "<part_no_one>" has "RET_DATE" as "3 mondays time"
	And "<part_no_one>" has "NEXT_DATE" as "3 mondays time"
	And "<part_no_one>" has "LNAME" as "<last_name>"
	And "<part_no_one>" has "ZIP" as "<postcode>"
	And "<part_no_one>" has "READ_ONLY" as "N"
	
	# Submit response in pool
	Given I have submitted a first party English straight through response
		|part_no		|pool_number	|last_name		|postcode	|email 	|
		|<part_no_one>	|<pool_no>		|<last_name>	|<postcode>	|<email>|

	#check status
	
	Then on "JUROR_DIGITAL" . "JUROR_RESPONSE" I see "URGENT" is "Y" where "JUROR_NUMBER" is "<part_no_one>"
	Then on "JUROR_DIGITAL" . "JUROR_RESPONSE" I see "SUPER_URGENT" is "N" where "JUROR_NUMBER" is "<part_no_one>"
	
	Given I am on "Bureau" "bau-test" 	
	And I log in as "CPASS"
	
	When I click on the "Search" link
	And I set "Juror number" to "<part_no_one>"
	And I press the "Search" button
	And I click on "<part_no_one>" in the same row as "<part_no_one>"
	
	#check status = summoned
	
	Then I see "Summoned" on the page
	And I see "URGENT" on the page
	
	When I select "Responded" from Process reply
	And I check the "Mark juror as 'responded'" checkbox
	And I press the "Confirm" button
	
	#now check status
	
	And I do not see "URGENT" on the page
	Then I see "Responded" on the page
	And I see "COMPLETED" on the page
	Then on "JUROR_DIGITAL" . "JUROR_RESPONSE" I see "URGENT" is "Y" where "JUROR_NUMBER" is "<part_no_one>"
	Then on "JUROR_DIGITAL" . "JUROR_RESPONSE" I see "SUPER_URGENT" is "N" where "JUROR_NUMBER" is "<part_no_one>"
	
Examples:
	|part_no_one	|pool_no	|last_name			|postcode	|email 	|
	|644200914		|442170401	|LNAMENINEONEFOUR	|SY2 6LU	|a@a.com|
	
@RegressionWelsh @JDB-3759 
Scenario Outline: Test that a response with ret_date in 1 week and read_only='N' is not flagged super urgent
	
	Given I am on the welsh version of "Public" "bau-test"
	Given the juror numbers have not been processed
		|part_no 	|pool_no 	|owner 	|
		|<part_no> 	|<pool_no>	|400 	|
	
	#Set part_no pool to be 1 monday from now
	Given "<part_no>" has "RET_DATE" as "1 mondays time"
	And "<part_no>" has "NEXT_DATE" as "1 mondays time"
	And "<part_no>" has "LNAME" as "<last_name>"
	And "<part_no>" has "ZIP" as "<postcode>"
	
#	# Attempt to submit response
#	And I set the radio button to "n ymateb dros fy hun"
#	And I press the "Parhau" button
#	Then I see "Eich manylion rheithiwr" on the page
#	
#	When I set "Rhif rheithiwr" to "<part_no>"
#	When I set "Cyfenw" to "<last_name>"
#	When I set "Cod post Rheithiwr" to "<postcode>"
#	And I press the "Parhau" button
#	
#	Then I see "Mae'r dyddiad ar gyfer eich gwŷs rheithgor wedi mynd heibio. Ni allwch ymateb drwy ddefnyddio'r gwasanaeth hwn." on the page
	
	Given I have submitted a first party Welsh straight through response
		|part_no	|pool_number	|last_name		|postcode	|email 	|
		|<part_no>	|<pool_no>		|<last_name>	|<postcode>	|<email>|

	#check status
#
#	Then on "JUROR_DIGITAL" . "JUROR_RESPONSE" I see "URGENT" is "Y" where "JUROR_NUMBER" is "<part_no>"
#	Then on "JUROR_DIGITAL" . "JUROR_RESPONSE" I see "SUPER_URGENT" is "N" where "JUROR_NUMBER" is "<part_no>"
#
#	Given I am on "Bureau" "juror-test01"
#	And I log in as "CPASS"
#
#	When I click on the "Search" link
#	And I set "Juror number" to "<part_no>"
#	And I press the "Search" button
#	And I click on "<part_no>" in the same row as "<part_no>"
#
#	#check status = summoned
#
#	Then I see "Summoned" on the page
#	And I do not see "SEND TO COURT" on the page
#
#	When I select "Responded" from Process reply
#	And I check the "Mark juror as 'responded'" checkbox
#	And I press the "Confirm" button
#
#	#now check status
#
#	Then I see "Responded" on the page
#	And I see "COMPLETED" on the page
#	Then on "JUROR_DIGITAL" . "JUROR_RESPONSE" I see "URGENT" is "Y" where "JUROR_NUMBER" is "<part_no>"
#	Then on "JUROR_DIGITAL" . "JUROR_RESPONSE" I see "SUPER_URGENT" is "N" where "JUROR_NUMBER" is "<part_no>"
		
Examples:
	|part_no	|pool_no	|last_name			|postcode	|email 		|
	|645700161	|457170401	|LNAMEONESIXONE		|SA1 4PF	|e@mail.com	|
	