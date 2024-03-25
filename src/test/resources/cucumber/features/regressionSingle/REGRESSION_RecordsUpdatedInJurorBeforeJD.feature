Feature: JDB-3198

#currently fails due to JDB-3761 which is coming in sprint 14

@RegressionSingle @JDB-3198
Scenario Outline: Can Complete Record when juror.pool.status=1 (summoned)
	
	Given I am on "Public" "juror-test02"
	Given the juror numbers have not been processed
		|part_no 		|pool_no 	|owner 	|
		|<part_no_one> 	|<pool_no>	|400 	|
	
	#Set part_no pool to be urgent
	Given "<part_no_one>" has "RET_DATE" as "3 mondays time"
	And "<part_no_one>" has "NEXT_DATE" as "3 mondays time"
	And "<part_no_one>" has "LNAME" as "<last_name>"
	And "<part_no_one>" has "ZIP" as "<postcode>"
	
	# Submit response in pool
	Given I have submitted a first party English straight through response
		|part_no			|pool_number	|last_name		|postcode	|email 	|
		|<part_no_one>		|<pool_no>		|<last_name>	|<postcode>	|<email>|
		
	Given I am on "Bureau" "juror-test02" 	
	And I log in as "CPASS"
	
	When I click on the "Search" link
	And I set "Juror number" to "<part_no_one>"
	And I press the "Search" button
	And I click on "<part_no_one>" in the same row as "<part_no_one>"
	
	#check status = summoned
	
	Then I see "Summoned" on the page
	
	When I select "Mark as responded" from Process reply
	And I check the "Mark juror as 'responded'" checkbox
	And I press the "Confirm" button
	
	#now check status = responded
	
	Then I see "Responded" on the page
	And I see "COMPLETED" on the page
	Then on "JUROR_MOD" . "JUROR_RESPONSE" I see "PROCESSING_STATUS" is "CLOSED" where "JUROR_NUMBER" is "<part_no_one>"
	Then on "JUROR_MOD" . "JUROR_RESPONSE" I see "PROCESSING_COMPLETE" is "Y" where "JUROR_NUMBER" is "<part_no_one>"
	
	#check record is now in "completed today"
	
	When I click on the "Your work" link
	Then I click on the "Completed" link
	Then I see "<part_no_one>" on the page
		
Examples:
	|part_no_one|pool_no	|last_name	|postcode	|email 	|
	|645100458	|451170401	|DOE		|SW1H 9AJ	|a@a.com|
	
@RegressionSingle @JDB-3198 @JDB-3732 
Scenario Outline: Cannot Complete Record when juror.pool.status=2 (Responded)
	
	Given I am on "Public" "juror-test01"
	Given the juror numbers have not been processed
		|part_no 		|pool_no 	|owner 	|
		|<part_no_two> 	|<pool_no>	|400 	|
	
	#Set part_no pool to be urgent
	Given "<part_no_two>" has "RET_DATE" as "3 mondays time"
	And "<part_no_two>" has "NEXT_DATE" as "3 mondays time"
	And "<part_no_two>" has "LNAME" as "<last_name>"
	And "<part_no_two>" has "ZIP" as "<postcode>"
	And "<part_no_two>" has "DOB" as "01-JAN-1977"
	
	# Submit response in pool
	Given I have submitted a first party English straight through response
		|part_no		|pool_number|last_name		|postcode	|email 	|
		|<part_no_two>	|<pool_no>	|<last_name>	|<postcode>	|<email>|
		
	#update JUROR to responded
	Given "<part_no_two>" has "RESPONDED" as "Y"
	Given "<part_no_two>" has "STATUS" as "2"
	
	Given I am on "Bureau" "juror-test01" 	
	And I log in as "CPASS"
	
	When I click on the "Search" link
	And I set "Juror number" to "<part_no_two>"
	And I press the "Search" button
	And I click on "<part_no_two>" in the same row as "<part_no_two>"
	
	#check I get a warning that the record is completed
	
	Then I see "Response Completed" on the page
	Then I see "This response has already been processed in Juror, please check the details are correct" on the page
	
	#ok message
	
	And I press the "Ok" button
	
	#check status on screen
	
	Then I see "Responded" on the page
	And I see "COMPLETED" on the page
	Then on "JUROR_MOD" . "JUROR_RESPONSE" I see "PROCESSING_STATUS" is "CLOSED" where "JUROR_NUMBER" is "<part_no_two>"
	Then on "JUROR_MOD" . "JUROR_RESPONSE" I see "PROCESSING_COMPLETE" is "Y" where "JUROR_NUMBER" is "<part_no_two>"
	
	#check record is now in "completed today"
	
	When I click on the "Your work" link
	Then I click on the "Completed" link
	Then I see "<part_no_two>" on the page
	
Examples:
	|part_no_two|pool_no	|last_name			|postcode	|email	|
	|645100454	|451170401	|LNAMETWOSIXZERO	|CH1 2AN	|a@a.com|
	
@RegressionSingle @JDB-3198 @JDB-3732 
Scenario Outline: Cannot Complete Record when juror.pool.status=5 (Excused)
	
	Given I am on "Public" "juror-test02"
	Given the juror numbers have not been processed
		|part_no 			|pool_no 	|owner 	|
		|<part_no_three> 	|<pool_no>	|400 	|
	
	#Set part_no pool to be urgent
	
	Given "<part_no_three>" has "RET_DATE" as "3 mondays time"
	And "<part_no_three>" has "NEXT_DATE" as "3 mondays time"
	And "<part_no_three>" has "LNAME" as "<last_name>"
	And "<part_no_three>" has "ZIP" as "<postcode>"
	And "<part_no_three>" has "DOB" as "01-JAN-1977"
	
	# Submit response in pool
	Given I have submitted a first party English straight through response
		|part_no			|pool_number	|last_name		|postcode	|email 	|
		|<part_no_three>	|<pool_no>		|<last_name>	|<postcode>	|<email>|
		
	#update JUROR to excused
	
	Given "<part_no_three>" has "RESPONDED" as "Y"
	And "<part_no_three>" has "STATUS" as "5"
	And "<part_no_three>" has "DATE_EXCUS" as "01-JAN-2019"
	And "<part_no_three>" has "EXC_CODE" as "D"
	And "<part_no_three>" has "USER_EDTQ" as "CPASS"
	
	Given I am on "Bureau" "juror-test02" 	
	And I log in as "CPASS"
	
	When I click on the "Search" link
	And I set "Juror number" to "<part_no_three>"
	And I press the "Search" button
	And I click on "<part_no_three>" in the same row as "<part_no_three>"
	
	#check I get a warning that the record is completed
	
	Then I see "Response Completed" on the page
	Then I see "This response has already been processed in Juror, please check the details are correct" on the page
	
	#ok message
	
	And I press the "Ok" button
	
	#check status on screen

 	Then I see "Excused" on the page
	And I see "COMPLETED" on the page
	Then on "JUROR_MOD" . "JUROR_RESPONSE" I see "PROCESSING_STATUS" is "CLOSED" where "JUROR_NUMBER" is "<part_no_three>"
	Then on "JUROR_MOD" . "JUROR_RESPONSE" I see "PROCESSING_COMPLETE" is "Y" where "JUROR_NUMBER" is "<part_no_three>"
	
	#check record is now in "completed today"
	
	When I click on the "Your work" link
	Then I click on the "Completed" link
	Then I see "<part_no_three>" on the page
	
Examples:
	|part_no_three	|pool_no	|last_name			|postcode	|email	|
	|645100746		|451170401	|LNAMETWOSIXZERO	|CH1 2AN	|a@a.com|
	
@RegressionSingle @JDB-3198 @JDB-3732 
Scenario Outline: Cannot Complete Record when juror.pool.status=6 (Disqualified)
	
	Given I am on "Public" "juror-test02"
	Given the juror numbers have not been processed
		|part_no 		|pool_no 	|owner 	|
		|<part_no_four>	|<pool_no>	|400 	|
	
	#Set part_no pool to be urgent
	Given "<part_no_four>" has "RET_DATE" as "2 mondays time"
	And "<part_no_four>" has "NEXT_DATE" as "2 mondays time"
	And "<part_no_four>" has "LNAME" as "<last_name>"
	And "<part_no_four>" has "ZIP" as "<postcode>"
	And "<part_no_four>" has "DOB" as "01-JAN-1977"
	
	# Submit response in pool
	Given I have submitted a first party English straight through response
		|part_no		|pool_number	|last_name		|postcode	|email 	|
		|<part_no_four>	|<pool_no>		|<last_name>	|<postcode>	|<email>|
		
	#update JUROR to disq
	Given "<part_no_four>" has "RESPONDED" as "Y"
	And "<part_no_four>" has "STATUS" as "6"
	
	Given I am on "Bureau" "juror-test02" 	
	And I log in as "CPASS"
	
	When I click on the "Search" link
	And I set "Juror number" to "<part_no_four>"
	And I press the "Search" button
	And I click on "<part_no_four>" in the same row as "<part_no_four>"
	
	#check I get a warning that the record is completed
	
	Then I see "Response Completed" on the page
	Then I see "This response has already been processed in Juror, please check the details are correct" on the page
	
	#ok message
	
	And I press the "Ok" button
	
	#check status on screen
	
	Then I see "Disqualified" on the page
	And I see "COMPLETED" on the page
	Then on "JUROR_MOD" . "JUROR_RESPONSE" I see "PROCESSING_STATUS" is "CLOSED" where "JUROR_NUMBER" is "<part_no_four>"
	Then on "JUROR_MOD" . "JUROR_RESPONSE" I see "PROCESSING_COMPLETE" is "Y" where "JUROR_NUMBER" is "<part_no_four>"
	
	#check record is now in "completed today"
	
	When I click on the "Your work" link
	Then I click on the "Completed" link
	Then I see "<part_no_four>" on the page
	
Examples:
	|part_no_four	|pool_no	|last_name			|postcode	|email	|
	|645100572		|451170401	|LNAMETWOSIXZERO	|CH1 2AN	|a@a.com|

@RegressionSingle @JDB-3198 @JDB-3732 
Scenario Outline: Cannot Complete Record when juror.pool.status=7 (Deferred)
	
	Given I am on "Public" "juror-test02"
	Given the juror numbers have not been processed
		|part_no 		|pool_no 	|owner 	|
		|<part_no_five>	|<pool_no>	|400 	|
	
	#Set part_no pool to be urgent
	Given "<part_no_five>" has "RET_DATE" as "2 mondays time"
	And "<part_no_five>" has "NEXT_DATE" as "2 mondays time"
	And "<part_no_five>" has "LNAME" as "<last_name>"
	And "<part_no_five>" has "ZIP" as "<postcode>"
	And "<part_no_five>" has "DOB" as "01-JAN-1977"
	
	# Submit response in pool
	Given I have submitted a first party English straight through response
		|part_no			|pool_number	|last_name		|postcode	|email 	|
		|<part_no_five>		|<pool_no>		|<last_name>	|<postcode>	|<email>|
		
	#update JUROR to deferred
	Given "<part_no_five>" has "RESPONDED" as "Y"
	And "<part_no_five>" has "STATUS" as "7"
	
	Given I am on "Bureau" "juror-test02" 	
	And I log in as "CPASS"
	
	When I click on the "Search" link
	And I set "Juror number" to "<part_no_five>"
	And I press the "Search" button
	And I click on "<part_no_five>" in the same row as "<part_no_five>"
	
	#check I get a warning that the record is completed
	
	Then I see "Response Completed" on the page
	Then I see "This response has already been processed in Juror, please check the details are correct" on the page
	
	#ok message
	
	And I press the "Ok" button

	Then I see "Deferred" on the page
	And I see "COMPLETED" on the page
	Then on "JUROR_MOD" . "JUROR_RESPONSE" I see "PROCESSING_STATUS" is "CLOSED" where "JUROR_NUMBER" is "<part_no_five>"
	Then on "JUROR_MOD" . "JUROR_RESPONSE" I see "PROCESSING_COMPLETE" is "Y" where "JUROR_NUMBER" is "<part_no_five>"
	
	#check record is now in "completed today"
	
	When I click on the "Your work" link
	Then I click on the "Completed" link
	Then I see "<part_no_five>" on the page
	
Examples:
	|part_no_five	|pool_no	|last_name			|postcode	|email	|
	|645100747		|451170401	|LNAMETWOSIXZERO	|CH1 2AN	|a@a.com|

@RegressionSingle @JDB-3198 
Scenario Outline: Cannot Complete Record when juror.pool.status=11 (Awaiting info)
	
	Given I am on "Public" "juror-test01"
	Given the juror numbers have not been processed
		|part_no 		|pool_no 	|owner 	|
		|<part_no_six>	|<pool_no>	|400 	|
	
	#Set part_no pool to be urgent
	
	Given "<part_no_six>" has "RET_DATE" as "2 mondays time"
	And "<part_no_six>" has "NEXT_DATE" as "2 mondays time"
	And "<part_no_six>" has "LNAME" as "<last_name>"
	And "<part_no_six>" has "ZIP" as "<postcode>"
	And "<part_no_six>" has "DOB" as "01-JAN-1977"
	
	# Submit response in pool
	
	Given I have submitted a first party English straight through response
		|part_no		|pool_number	|last_name		|postcode	|email 	|
		|<part_no_six>	|<pool_no>		|<last_name>	|<postcode>	|<email>|
		
	#update JUROR to awaiting info
	
	Given "<part_no_six>" has "RESPONDED" as "Y"
	And "<part_no_six>" has "STATUS" as "11"
	
	Given I am on "Bureau" "juror-test01" 	
	And I log in as "CPASS"
	
	When I click on the "Search" link
	And I set "Juror number" to "<part_no_six>"
	And I press the "Search" button
	And I click on "<part_no_six>" in the same row as "<part_no_six>"
	
	#check I get a warning that the record is awaiting* in legacy juror
	
	Then I see "The status of this reply was changed in the Juror app to 'Awaiting information'. Select below the party that the bureau is waiting on information from." on the page
	And I see "You cannot access this juror record until the status has been updated." on the page
	And I see "Who is the bureau waiting for information from?" on the page
	
	#error when nothing selected 
	
	And I press the "Confirm" button
	Then I see "Select who the bureau is waiting for a reply from" on the page

	#select a status
	
	Then I set the radio button to "Awaiting court reply"
	Then I set the radio button to "Awaiting translation"
	Then I set the radio button to "Awaiting juror"
	
	#back
	
	And I click on the "Back" link
	
	#re-search
	
	When I click on the "Search" link
	And I set "Juror number" to "<part_no_six>"
	And I press the "Search" button
	Then I see "1 results for “<part_no_six>”" on the page
	
	#select again
	
	And I click on "<part_no_six>" in the same row as "<part_no_six>"
	
	#check I get a warning that the record is awaiting* in legacy juror
	
	Then I see "The status of this reply was changed in the Juror app to 'Awaiting information'. Select below the party that the bureau is waiting on information from." on the page
	And I see "You cannot access this juror record until the status has been updated." on the page
	And I see "Who is the bureau waiting for information from?" on the page
	
	#select a status
	
	Then I set the radio button to "Awaiting juror"
	
	#ok message
	
	And I press the "Confirm" button
	
	#check status = awaiting info

	And I see "AWAITING JUROR" on the page
	Then on "JUROR_MOD" . "JUROR_RESPONSE" I see "PROCESSING_STATUS" is "AWAITING_CONTACT" where "JUROR_NUMBER" is "<part_no_six>"
	Then on "JUROR_MOD" . "JUROR_RESPONSE" I see "PROCESSING_COMPLETE" is "N" where "JUROR_NUMBER" is "<part_no_six>"

Examples:
	|part_no_six	|pool_no	|last_name			|postcode	|email	|
	|645100718		|451170401	|LNAMETWOSIXZERO	|CH1 2AN	|a@a.com|

@RegressionSingle @JDB-3198 
Scenario Outline: Cannot Complete Record when juror.pool.status=2 and processing status=AWAITING*
	
	Given I am on "Public" "juror-test02"
	Given the juror numbers have not been processed
		|part_no 		|pool_no 	|owner 	|
		|<part_no_seven>|<pool_no>	|400 	|
	
	#Set part_no pool to be urgent
	
	Given "<part_no_seven>" has "RET_DATE" as "2 mondays time"
	And "<part_no_seven>" has "NEXT_DATE" as "2 mondays time"
	And "<part_no_seven>" has "LNAME" as "<last_name>"
	And "<part_no_seven>" has "ZIP" as "<postcode>"
	And "<part_no_seven>" has "DOB" as "01-JAN-1977"
	
	# Submit response in pool
	
	Given I have submitted a first party English straight through response
		|part_no			|pool_number	|last_name		|postcode	|email 	|
		|<part_no_seven>	|<pool_no>		|<last_name>	|<postcode>	|<email>|
	
	#update JUROR DIGITAL to awaiting information
	
	Given I am on "Bureau" "juror-test02" 	
	And I log in as "CPASS"
	
	When I click on the "Search" link
	And I set "Juror number" to "<part_no_seven>"
	And I press the "Search" button
	And I click on "<part_no_seven>" in the same row as "<part_no_seven>"
	Then I press the "More actions" button
	And I click on the "Mark as 'Awaiting information" link
	And I set the radio button to "Awaiting juror"
	
	#update JUROR to responded
	
	Given "<part_no_seven>" has "RESPONDED" as "Y"
	And "<part_no_seven>" has "STATUS" as "2"
	
	Given I am on "Bureau" "juror-test02" 	
	And I log in as "CPASS"
	
	When I click on the "Search" link
	And I set "Juror number" to "<part_no_seven>"
	And I press the "Search" button
	And I click on "<part_no_seven>" in the same row as "<part_no_seven>"
	
	#check I get a warning that the record is completed
	
	Then I see "Response Completed" on the page
	Then I see "This response has already been processed in Juror, please check the details are correct" on the page
	
	#ok message
	
	And I press the "Ok" button

	Then I see "Responded" on the page
	And I see "COMPLETED" on the page
	Then on "JUROR_MOD" . "JUROR_RESPONSE" I see "PROCESSING_STATUS" is "CLOSED" where "JUROR_NUMBER" is "<part_no_seven>"
	Then on "JUROR_MOD" . "JUROR_RESPONSE" I see "PROCESSING_COMPLETE" is "Y" where "JUROR_NUMBER" is "<part_no_seven>"
	
	#check record is now in "completed today"
	
	When I click on the "Your work" link
	Then I click on the "Completed" link
	Then I see "<part_no_seven>" on the page
	
Examples:
	|part_no_seven	|pool_no	|last_name			|postcode	|email	|
	|645100075		|451170401	|LNAMETWOSIXZERO	|CH1 2AN	|a@a.com|

@RegressionSingle @JDB-3198 @JDB-3732 
Scenario Outline: Cannot Complete Record when juror.pool.status=2 (Responded) and record is pending allocation
	
	Given I am on "Public" "juror-test02"
	Given the juror numbers have not been processed
		|part_no 		|pool_no 	|owner 	|
		|<part_no_eight>|<pool_no>	|400 	|
	
	#Set part_no pool to be not urgent
	Given "<part_no_eight>" has "RET_DATE" as "5 mondays time"
	And "<part_no_eight>" has "NEXT_DATE" as "5 mondays time"
	And "<part_no_eight>" has "LNAME" as "<last_name>"
	And "<part_no_eight>" has "ZIP" as "<postcode>"
	And "<part_no_eight>" has "DOB" as "01-JAN-1977"
	
	Then I see "Reply to a jury summons" on the page
	
	
	Then I see "Are you replying for yourself or for someone else?" on the page
	
	When I set the radio button to "I am replying for myself"
	And I press the "Continue" button
	Then I see "Your juror details" on the page
	
	#Juror Log In
	
	When I set "9-digit juror number" to "<part_no_eight>"
	When I set "Juror last name" to "<last_name>"
	When I set "Juror postcode" to "<postcode>"
	And I press the "Continue" button
	Then I see "Is the name we have for you correct?" on the page
	When I choose the "Yes" radio button
	
	#Check name
	
	When I press the "Continue" button
	Then I see "Is this your address?" on the page
	When I choose the "Yes" radio button
	
	#Check address
	
	When I press the "Continue" button
	Then I see "What is your phone number?" on the page
	
	#Phone details
	
	When I set "Main phone" to "0207 821 1818"
	And I press the "Continue" button
	Then I see "What is your email address?" on the page
	
	#Email details
	
	When I set "Enter your email address" to "email@outlook.com"
	And I set "Enter your email address again" to "email@outlook.com"
	And I press the "Continue" button
	Then I see "What is your date of birth?" on the page
	
	#DoB
	
	When I set "Day" to "27"
	And I set "Month" to "04"
	And I set "Year" to "1981"
	And I press the "Continue" button
	
	Then I see "Confirm you're eligible for jury service" on the page
	
	When I press the "Continue" button
	Then I see "Since you turned 13, has your main address been in the UK, Channel Islands or Isle of Man for any period of at least 5 years?" on the page
	
	#Residency
	
	When I choose the "No" radio button
	And I set "Provide details" to "Not a resident"
	And I press the "Continue" button
	
	#CJS 
	
	When I choose the "No" radio button
	And I press the "Continue" button
	
	#Bail
	
	When I choose the "No" radio button
	And I press the "Continue" button
	
	#Convictions
	
	When I choose the "No" radio button
	And I press the "Continue" button
	
	#Mental health part 1
	
	When I choose the "No" radio button
	And I press the "Continue" button
	
	#Mental health part 2
	
	When I choose the "No" radio button
	And I press the "Continue" button
	
	#I can attend
	
	And I see "Yes, I can start on" on the page
	And I set the radio button to "Yes, I can start on"
	And  I press the "Continue" button
	
	#RA 
	
	When I choose the "No" radio button
	And I press the "Continue" button
	
	#Check Your Answers

	Then I see "Check your answers now" on the page
		
	#When I press the "Submit" button
	
	When I check the "The information I have given is true to the best of my knowledge" checkbox
	And I press the "Submit" button
	Then I see "We have sent you an email to say you have replied to your jury summons." on the page
		
	#update JUROR to responded
	Given "<part_no_eight>" has "RESPONDED" as "Y"
	Given "<part_no_eight>" has "STATUS" as "2"
	
	Given I am on "Bureau" "juror-test02" 	
	And I log in as "CPASS"
	
	When I click on the "Search" link
	And I set "Juror number" to "<part_no_eight>"
	And I press the "Search" button
	And I click on "<part_no_eight>" in the same row as "<part_no_eight>"
	
	#check I get a warning that the record is completed
	
	Then I see "Response Completed" on the page
	Then I see "This response has already been processed in Juror, please check the details are correct" on the page
	
	#ok message
	
	And I press the "Ok" button
	
	#check status on screen
	
	Then I see "Responded" on the page
	And I see "COMPLETED" on the page
	Then on "JUROR_MOD" . "JUROR_RESPONSE" I see "PROCESSING_STATUS" is "CLOSED" where "JUROR_NUMBER" is "<part_no_eight>"
	Then on "JUROR_MOD" . "JUROR_RESPONSE" I see "PROCESSING_COMPLETE" is "Y" where "JUROR_NUMBER" is "<part_no_eight>"
	
	#check record is now in "completed today"
	
	When I click on the "Your work" link
	Then I click on the "Completed" link
	Then I see "<part_no_eight>" on the page
	
Examples:
	|part_no_eight	|pool_no	|last_name			|postcode	|email	|
	|645700901		|457170401	|LNAMENINEZEROONE	|CH1 2AN	|a@a.com|
