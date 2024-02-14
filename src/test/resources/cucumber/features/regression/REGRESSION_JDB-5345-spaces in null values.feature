Feature: JDB-5345 null values are not saved as spaces

@Features
Scenario Outline: 1st Party English null values are not saved as spaces

	#moved to Features 02-02-24 move back to Regression

	Given I am on "Bureau" "test"
	Given the juror numbers have not been processed
		|part_no 	|pool_no 	|owner	|
		|<part_no> 	|<pool_no>	|400 	|

	Given there is only a bureau copy of the record for juror "<part_no>"
	
	# Set part_no pool to not be urgent
	Given "<part_no>" has "RET_DATE" as "5 mondays time"
	And "<part_no>" has "NEXT_DATE" as "5 mondays time"
	And "<part_no>" has "LNAME" as "<last_name>"
	And "<part_no>" has "ZIP" as "<postcode>"
	
	# Submit response in pool
	Given I have submitted a first party English straight through response
		|part_no	|pool_number|last_name	|postcode	|email 	|
		|<part_no>	|<pool_no>	|<last_name>|<postcode>	|a@a.com|

	Then I see "You have completed your reply" on the page

	Then on "JUROR" . "POOL" I see "TITLE" is null where "PART_NO" is "<part_no>"
	Then on "JUROR" . "POOL" I see "ADDRESS3" is null where "PART_NO" is "<part_no>"
	Then on "JUROR" . "POOL" I see "ADDRESS5" is null where "PART_NO" is "<part_no>"
	Then on "JUROR" . "POOL" I see "ADDRESS6" is null where "PART_NO" is "<part_no>"
	Then on "JUROR" . "POOL" I see "H_PHONE" is null where "PART_NO" is "<part_no>"
	Then on "JUROR" . "POOL" I see "W_PHONE" is null where "PART_NO" is "<part_no>"
	Then on "JUROR" . "POOL" I see "W_PH_LOCAL" is null where "PART_NO" is "<part_no>"
	Then on "JUROR" . "POOL" I see "TIMES_SEL" is null where "PART_NO" is "<part_no>"
	Then on "JUROR" . "POOL" I see "TRIAL_NO" is null where "PART_NO" is "<part_no>"
	Then on "JUROR" . "POOL" I see "JUROR_NO" is null where "PART_NO" is "<part_no>"
	Then on "JUROR" . "POOL" I see "DEF_DATE" is null where "PART_NO" is "<part_no>"
	Then on "JUROR" . "POOL" I see "DATE_EXCUS" is null where "PART_NO" is "<part_no>"
	Then on "JUROR" . "POOL" I see "EXC_CODE" is null where "PART_NO" is "<part_no>"
	Then on "JUROR" . "POOL" I see "ACC_EXC" is null where "PART_NO" is "<part_no>"
	Then on "JUROR" . "POOL" I see "DATE_DISQ" is null where "PART_NO" is "<part_no>"
	Then on "JUROR" . "POOL" I see "DISQ_CODE" is null where "PART_NO" is "<part_no>"
	Then on "JUROR" . "POOL" I see "MILEAGE" is null where "PART_NO" is "<part_no>"
	Then on "JUROR" . "POOL" I see "LOCATION" is null where "PART_NO" is "<part_no>"
	Then on "JUROR" . "POOL" I see "NOTES" is null where "PART_NO" is "<part_no>"
	Then on "JUROR" . "POOL" I see "NO_ATTENDANCES" is null where "PART_NO" is "<part_no>"
	Then on "JUROR" . "POOL" I see "NO_DEF_POS" is null where "PART_NO" is "<part_no>"
	Then on "JUROR" . "POOL" I see "NO_ATTENDED" is null where "PART_NO" is "<part_no>"
	Then on "JUROR" . "POOL" I see "NO_FTA" is null where "PART_NO" is "<part_no>"
	Then on "JUROR" . "POOL" I see "NO_AWOL" is null where "PART_NO" is "<part_no>"
	Then on "JUROR" . "POOL" I see "EDIT_TAG" is null where "PART_NO" is "<part_no>"
	Then on "JUROR" . "POOL" I see "PERM_DISQUAL" is null where "PART_NO" is "<part_no>"
	Then on "JUROR" . "POOL" I see "PAY_COUNTY_EMP" is null where "PART_NO" is "<part_no>"
	Then on "JUROR" . "POOL" I see "PAY_EXPENSES" is null where "PART_NO" is "<part_no>"
	Then on "JUROR" . "POOL" I see "SPEC_NEED" is null where "PART_NO" is "<part_no>"
	Then on "JUROR" . "POOL" I see "SPEC_NEED_MSG" is null where "PART_NO" is "<part_no>"
	Then on "JUROR" . "POOL" I see "SMART_CARD" is null where "PART_NO" is "<part_no>"
	Then on "JUROR" . "POOL" I see "AMT_SPENT" is null where "PART_NO" is "<part_no>"
	Then on "JUROR" . "POOL" I see "COMPLETION_FLAG" is null where "PART_NO" is "<part_no>"
	Then on "JUROR" . "POOL" I see "SORT_CODE" is null where "PART_NO" is "<part_no>"
	Then on "JUROR" . "POOL" I see "BANK_ACCT_NAME" is null where "PART_NO" is "<part_no>"
	Then on "JUROR" . "POOL" I see "BANK_ACCT_NO" is null where "PART_NO" is "<part_no>"
	Then on "JUROR" . "POOL" I see "BLDG_SOC_ROLL_NO" is null where "PART_NO" is "<part_no>"
	Then on "JUROR" . "POOL" I see "WAS_DEFERRED" is null where "PART_NO" is "<part_no>"
	Then on "JUROR" . "POOL" I see "ID_CHECKED" is null where "PART_NO" is "<part_no>"
	Then on "JUROR" . "POOL" I see "POSTPONE" is null where "PART_NO" is "<part_no>"
	Then on "JUROR" . "POOL" I see "WELSH" is null where "PART_NO" is "<part_no>"
	Then on "JUROR" . "POOL" I see "PAID_CASH" is null where "PART_NO" is "<part_no>"
	Then on "JUROR" . "POOL" I see "TRAVEL_TIME" is null where "PART_NO" is "<part_no>"
	Then on "JUROR" . "POOL" I see "SCAN_CODE" is null where "PART_NO" is "<part_no>"
	Then on "JUROR" . "POOL" I see "FINANCIAL_LOSS" is null where "PART_NO" is "<part_no>"
	Then on "JUROR" . "POOL" I see "POLICE_CHECK" is null where "PART_NO" is "<part_no>"
	Then on "JUROR" . "POOL" I see "SUMMONS_FILE" is null where "PART_NO" is "<part_no>"
	Then on "JUROR" . "POOL" I see "REMINDER_SENT" is null where "PART_NO" is "<part_no>"
	Then on "JUROR" . "POOL" I see "PHOENIX_CHECKED" is null where "PART_NO" is "<part_no>"
	Then on "JUROR" . "POOL" I see "CONTACT_PREFERENCE" is null where "PART_NO" is "<part_no>"
	Then on "JUROR" . "POOL" I see "SERVICE_COMP_COMMS_STATUS" is null where "PART_NO" is "<part_no>"
	Then on "JUROR" . "POOL" I see "TRANSFER_DATE" is null where "PART_NO" is "<part_no>"
	Then on "JUROR_DIGITAL" . "JUROR_RESPONSE" I see "PROCESSING_STATUS" is "CLOSED" where "JUROR_NUMBER" is "<part_no>"
	
Examples:
	|part_no		|pool_no 	|last_name 	|postcode 	|
	|641500761		|415171001 	|LNAMEONE	|CH1 2AN	|

@Features
Scenario Outline: 3rd Party English null values are not saved as spaces

	#moved to Features 02-02-24 move back to Regression

	Given I am on "Bureau" "test"
	Given the juror numbers have not been processed
		|part_no 	|pool_no 	|owner	|
		|<part_no> 	|<pool_no>	|400 	|

	Given there is only a bureau copy of the record for juror "<part_no>"

# Set part_no pool to not be urgent
	Given "<part_no>" has "RET_DATE" as "5 mondays time"
	And "<part_no>" has "NEXT_DATE" as "5 mondays time"
	And "<part_no>" has "LNAME" as "<last_name>"
	And "<part_no>" has "ZIP" as "<postcode>"

# Submit response in pool
	Given I have submitted a third party English straight through response
		|part_no	|pool_number|last_name	|postcode	|email 	|
		|<part_no>	|<pool_no>	|<last_name>|<postcode>	|a@a.com|

#respond the response
	Given I am on "Bureau" "test"
	When I log in as "SYSTEM"
	And I click on the "Search" link
	And I set "Juror's pool number" to "<pool_no>"
	And I press the "Search" button
	Then I see "<part_no>" in the same row as "<part_no>"
	When I click on "<part_no>" in the same row as "<part_no>"
	When I select "Responded" from Process reply
	And I check the "Mark juror as 'responded'" checkbox
	And I press the "Confirm" button
	Then I see "COMPLETED" on the page

	Then on "JUROR_DIGITAL" . "JUROR_RESPONSE" I see "PROCESSING_STATUS" is "CLOSED" where "JUROR_NUMBER" is "<part_no>"
	Then on "JUROR" . "POOL" I see "TITLE" is null where "PART_NO" is "<part_no>"
	Then on "JUROR" . "POOL" I see "ADDRESS3" is null where "PART_NO" is "<part_no>"
	Then on "JUROR" . "POOL" I see "ADDRESS5" is null where "PART_NO" is "<part_no>"
	Then on "JUROR" . "POOL" I see "ADDRESS6" is null where "PART_NO" is "<part_no>"
	Then on "JUROR" . "POOL" I see "H_PHONE" is null where "PART_NO" is "<part_no>"
	Then on "JUROR" . "POOL" I see "W_PHONE" is null where "PART_NO" is "<part_no>"
	Then on "JUROR" . "POOL" I see "W_PH_LOCAL" is null where "PART_NO" is "<part_no>"
	Then on "JUROR" . "POOL" I see "TIMES_SEL" is null where "PART_NO" is "<part_no>"
	Then on "JUROR" . "POOL" I see "TRIAL_NO" is null where "PART_NO" is "<part_no>"
	Then on "JUROR" . "POOL" I see "JUROR_NO" is null where "PART_NO" is "<part_no>"
	Then on "JUROR" . "POOL" I see "DEF_DATE" is null where "PART_NO" is "<part_no>"
	Then on "JUROR" . "POOL" I see "DATE_EXCUS" is null where "PART_NO" is "<part_no>"
	Then on "JUROR" . "POOL" I see "EXC_CODE" is null where "PART_NO" is "<part_no>"
	Then on "JUROR" . "POOL" I see "ACC_EXC" is null where "PART_NO" is "<part_no>"
	Then on "JUROR" . "POOL" I see "DATE_DISQ" is null where "PART_NO" is "<part_no>"
	Then on "JUROR" . "POOL" I see "DISQ_CODE" is null where "PART_NO" is "<part_no>"
	Then on "JUROR" . "POOL" I see "MILEAGE" is null where "PART_NO" is "<part_no>"
	Then on "JUROR" . "POOL" I see "LOCATION" is null where "PART_NO" is "<part_no>"
	Then on "JUROR" . "POOL" I see "NOTES" is null where "PART_NO" is "<part_no>"
	Then on "JUROR" . "POOL" I see "NO_ATTENDANCES" is null where "PART_NO" is "<part_no>"
	Then on "JUROR" . "POOL" I see "NO_DEF_POS" is null where "PART_NO" is "<part_no>"
	Then on "JUROR" . "POOL" I see "NO_ATTENDED" is null where "PART_NO" is "<part_no>"
	Then on "JUROR" . "POOL" I see "NO_FTA" is null where "PART_NO" is "<part_no>"
	Then on "JUROR" . "POOL" I see "NO_AWOL" is null where "PART_NO" is "<part_no>"
	Then on "JUROR" . "POOL" I see "EDIT_TAG" is null where "PART_NO" is "<part_no>"
	Then on "JUROR" . "POOL" I see "PERM_DISQUAL" is null where "PART_NO" is "<part_no>"
	Then on "JUROR" . "POOL" I see "PAY_COUNTY_EMP" is null where "PART_NO" is "<part_no>"
	Then on "JUROR" . "POOL" I see "PAY_EXPENSES" is null where "PART_NO" is "<part_no>"
	Then on "JUROR" . "POOL" I see "SPEC_NEED" is null where "PART_NO" is "<part_no>"
	Then on "JUROR" . "POOL" I see "SPEC_NEED_MSG" is null where "PART_NO" is "<part_no>"
	Then on "JUROR" . "POOL" I see "SMART_CARD" is null where "PART_NO" is "<part_no>"
	Then on "JUROR" . "POOL" I see "AMT_SPENT" is null where "PART_NO" is "<part_no>"
	Then on "JUROR" . "POOL" I see "COMPLETION_FLAG" is null where "PART_NO" is "<part_no>"
	Then on "JUROR" . "POOL" I see "SORT_CODE" is null where "PART_NO" is "<part_no>"
	Then on "JUROR" . "POOL" I see "BANK_ACCT_NAME" is null where "PART_NO" is "<part_no>"
	Then on "JUROR" . "POOL" I see "BANK_ACCT_NO" is null where "PART_NO" is "<part_no>"
	Then on "JUROR" . "POOL" I see "BLDG_SOC_ROLL_NO" is null where "PART_NO" is "<part_no>"
	Then on "JUROR" . "POOL" I see "WAS_DEFERRED" is null where "PART_NO" is "<part_no>"
	Then on "JUROR" . "POOL" I see "ID_CHECKED" is null where "PART_NO" is "<part_no>"
	Then on "JUROR" . "POOL" I see "POSTPONE" is null where "PART_NO" is "<part_no>"
	Then on "JUROR" . "POOL" I see "WELSH" is null where "PART_NO" is "<part_no>"
	Then on "JUROR" . "POOL" I see "PAID_CASH" is null where "PART_NO" is "<part_no>"
	Then on "JUROR" . "POOL" I see "TRAVEL_TIME" is null where "PART_NO" is "<part_no>"
	Then on "JUROR" . "POOL" I see "SCAN_CODE" is null where "PART_NO" is "<part_no>"
	Then on "JUROR" . "POOL" I see "FINANCIAL_LOSS" is null where "PART_NO" is "<part_no>"
	Then on "JUROR" . "POOL" I see "POLICE_CHECK" is null where "PART_NO" is "<part_no>"
	Then on "JUROR" . "POOL" I see "SUMMONS_FILE" is null where "PART_NO" is "<part_no>"
	Then on "JUROR" . "POOL" I see "REMINDER_SENT" is null where "PART_NO" is "<part_no>"
	Then on "JUROR" . "POOL" I see "PHOENIX_CHECKED" is null where "PART_NO" is "<part_no>"
	Then on "JUROR" . "POOL" I see "CONTACT_PREFERENCE" is null where "PART_NO" is "<part_no>"
	Then on "JUROR" . "POOL" I see "SERVICE_COMP_COMMS_STATUS" is null where "PART_NO" is "<part_no>"
	Then on "JUROR" . "POOL" I see "TRANSFER_DATE" is null where "PART_NO" is "<part_no>"

	Examples:
		|part_no		|pool_no 	|last_name 	|postcode 	|
		|645200055		|452170401 	|LNAMEONE	|CH1 2AN	|
