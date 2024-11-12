Feature: JDB-5345 null values are not saved as spaces

@Features @NewSchemaConverted
Scenario Outline: 1st Party English null values are not saved as spaces

	#moved to Features 02-02-24 move back to Regression

	Given I am on "Bureau" "test"

	Given a bureau owned pool is created with jurors
		| court |juror_number  | pool_number	| att_date_weeks_in_future	| owner |
		| 452   |<juror_number>| <pool_number>	| 5				            | 400	|

	Given there is only a bureau copy of the record for juror "<juror_number>"
	
	# Set part_no pool to not be urgent
	And juror "<juror_number>" has "LAST_NAME" as "<last_name>" new schema
	And juror "<juror_number>" has "POSTCODE" as "<postcode>" new schema
	
	# Submit response in pool
	Given I have submitted a first party English straight through response
		| part_no		| pool_number	| last_name		| postcode	| email 	|
		| <juror_number>| <pool_number>	| <last_name>	| <postcode>| a@a.com	|

	Then I see "You have completed your reply" on the page

	Then on "JUROR_MOD" . "JUROR" I see "TITLE" is null where "JUROR_NUMBER" is "<juror_number>"
	Then on "JUROR_MOD" . "JUROR" I see "ADDRESS3" is null where "JUROR_NUMBER" is "<juror_number>"
	Then on "JUROR_MOD" . "JUROR" I see "ADDRESS5" is null where "JUROR_NUMBER" is "<juror_number>"
	Then on "JUROR_MOD" . "JUROR" I see "ADDRESS6" is null where "JUROR_NUMBER" is "<juror_number>"
	Then on "JUROR_MOD" . "JUROR" I see "H_PHONE" is null where "JUROR_NUMBER" is "<juror_number>"
	Then on "JUROR_MOD" . "JUROR" I see "W_PHONE" is null where "JUROR_NUMBER" is "<juror_number>"
	Then on "JUROR_MOD" . "JUROR" I see "W_PH_LOCAL" is null where "JUROR_NUMBER" is "<juror_number>"
	Then on "JUROR_MOD" . "JUROR" I see "TIMES_SEL" is null where "JUROR_NUMBER" is "<juror_number>"
	Then on "JUROR_MOD" . "JUROR" I see "TRIAL_NO" is null where "JUROR_NUMBER" is "<juror_number>"
	Then on "JUROR_MOD" . "JUROR" I see "JUROR_NO" is null where "JUROR_NUMBER" is "<juror_number>"
	Then on "JUROR_MOD" . "JUROR" I see "DEF_DATE" is null where "JUROR_NUMBER" is "<juror_number>"
	Then on "JUROR_MOD" . "JUROR" I see "DATE_EXCUS" is null where "JUROR_NUMBER" is "<juror_number>"
	Then on "JUROR_MOD" . "JUROR" I see "EXC_CODE" is null where "JUROR_NUMBER" is "<juror_number>"
	Then on "JUROR_MOD" . "JUROR" I see "ACC_EXC" is null where "JUROR_NUMBER" is "<juror_number>"
	Then on "JUROR_MOD" . "JUROR" I see "DATE_DISQ" is null where "JUROR_NUMBER" is "<juror_number>"
	Then on "JUROR_MOD" . "JUROR" I see "DISQ_CODE" is null where "JUROR_NUMBER" is "<juror_number>"
	Then on "JUROR_MOD" . "JUROR" I see "MILEAGE" is null where "JUROR_NUMBER" is "<juror_number>"
	Then on "JUROR_MOD" . "JUROR" I see "LOCATION" is null where "JUROR_NUMBER" is "<juror_number>"
	Then on "JUROR_MOD" . "JUROR" I see "NOTES" is null where "JUROR_NUMBER" is "<juror_number>"
	Then on "JUROR_MOD" . "JUROR" I see "NO_ATTENDANCES" is null where "JUROR_NUMBER" is "<juror_number>"
	Then on "JUROR_MOD" . "JUROR" I see "NO_DEF_POS" is null where "JUROR_NUMBER" is "<juror_number>"
	Then on "JUROR_MOD" . "JUROR" I see "NO_ATTENDED" is null where "JUROR_NUMBER" is "<juror_number>"
	Then on "JUROR_MOD" . "JUROR" I see "NO_FTA" is null where "JUROR_NUMBER" is "<juror_number>"
	Then on "JUROR_MOD" . "JUROR" I see "NO_AWOL" is null where "JUROR_NUMBER" is "<juror_number>"
	Then on "JUROR_MOD" . "JUROR" I see "EDIT_TAG" is null where "JUROR_NUMBER" is "<juror_number>"
	Then on "JUROR_MOD" . "JUROR" I see "PERM_DISQUAL" is null where "JUROR_NUMBER" is "<juror_number>"
	Then on "JUROR_MOD" . "JUROR" I see "PAY_COUNTY_EMP" is null where "JUROR_NUMBER" is "<juror_number>"
	Then on "JUROR_MOD" . "JUROR" I see "PAY_EXPENSES" is null where "JUROR_NUMBER" is "<juror_number>"
	Then on "JUROR_MOD" . "JUROR" I see "SPEC_NEED" is null where "JUROR_NUMBER" is "<juror_number>"
	Then on "JUROR_MOD" . "JUROR" I see "SPEC_NEED_MSG" is null where "JUROR_NUMBER" is "<juror_number>"
	Then on "JUROR_MOD" . "JUROR" I see "SMART_CARD" is null where "JUROR_NUMBER" is "<juror_number>"
	Then on "JUROR_MOD" . "JUROR" I see "AMT_SPENT" is null where "JUROR_NUMBER" is "<juror_number>"
	Then on "JUROR_MOD" . "JUROR" I see "COMPLETION_FLAG" is null where "JUROR_NUMBER" is "<juror_number>"
	Then on "JUROR_MOD" . "JUROR" I see "SORT_CODE" is null where "JUROR_NUMBER" is "<juror_number>"
	Then on "JUROR_MOD" . "JUROR" I see "BANK_ACCT_NAME" is null where "JUROR_NUMBER" is "<juror_number>"
	Then on "JUROR_MOD" . "JUROR" I see "BANK_ACCT_NO" is null where "JUROR_NUMBER" is "<juror_number>"
	Then on "JUROR_MOD" . "JUROR" I see "BLDG_SOC_ROLL_NO" is null where "JUROR_NUMBER" is "<juror_number>"
	Then on "JUROR_MOD" . "JUROR" I see "WAS_DEFERRED" is null where "JUROR_NUMBER" is "<juror_number>"
	Then on "JUROR_MOD" . "JUROR" I see "ID_CHECKED" is null where "JUROR_NUMBER" is "<juror_number>"
	Then on "JUROR_MOD" . "JUROR" I see "POSTPONE" is null where "JUROR_NUMBER" is "<juror_number>"
	Then on "JUROR_MOD" . "JUROR" I see "WELSH" is null where "JUROR_NUMBER" is "<juror_number>"
	Then on "JUROR_MOD" . "JUROR" I see "PAID_CASH" is null where "JUROR_NUMBER" is "<juror_number>"
	Then on "JUROR_MOD" . "JUROR" I see "TRAVEL_TIME" is null where "JUROR_NUMBER" is "<juror_number>"
	Then on "JUROR_MOD" . "JUROR" I see "SCAN_CODE" is null where "JUROR_NUMBER" is "<juror_number>"
	Then on "JUROR_MOD" . "JUROR" I see "FINANCIAL_LOSS" is null where "JUROR_NUMBER" is "<juror_number>"
	Then on "JUROR_MOD" . "JUROR" I see "POLICE_CHECK" is null where "JUROR_NUMBER" is "<juror_number>"
	Then on "JUROR_MOD" . "JUROR" I see "SUMMONS_FILE" is null where "JUROR_NUMBER" is "<juror_number>"
	Then on "JUROR_MOD" . "JUROR" I see "REMINDER_SENT" is null where "JUROR_NUMBER" is "<juror_number>"
	Then on "JUROR_MOD" . "JUROR" I see "PHOENIX_CHECKED" is null where "JUROR_NUMBER" is "<juror_number>"
	Then on "JUROR_MOD" . "JUROR" I see "CONTACT_PREFERENCE" is null where "JUROR_NUMBER" is "<juror_number>"
	Then on "JUROR_MOD" . "JUROR" I see "SERVICE_COMP_COMMS_STATUS" is null where "JUROR_NUMBER" is "<juror_number>"
	Then on "JUROR_MOD" . "JUROR" I see "TRANSFER_DATE" is null where "JUROR_NUMBER" is "<juror_number>"
	Then on "JUROR_MOD" . "JUROR_RESPONSE" I see "PROCESSING_STATUS" is "CLOSED" where "JUROR_NUMBER" is "<juror_number>"
	
Examples:
	| juror_number	| pool_number 	| last_name | postcode 	|
	| 045200129		| 452300128 	| LNAMEONE	| CH1 2AN	|

@Features @NewSchemaConverted
Scenario Outline: 3rd Party English null values are not saved as spaces

	#moved to Features 02-02-24 move back to Regression

	Given I am on "Bureau" "test"

	Given a bureau owned pool is created with jurors
		| court |juror_number  | pool_number	| att_date_weeks_in_future	| owner |
		| 452   |<juror_number>| <pool_number>	| 5				            | 400	|

# Set part_no pool to not be urgent
	And juror "<juror_number>" has "LAST_NAME" as "<last_name>" new schema
	And juror "<juror_number>" has "POSTCODE" as "<postcode>" new schema

# Submit response in pool
	Given I have submitted a third party English straight through response
		| part_no		| pool_number	| last_name		| postcode	| email 	|
		| <juror_number>| <pool_number>	| <last_name>	| <postcode>| a@a.com	|

#respond the response
	Given I am on "Bureau" "test"
	When I log in as "MODTESTBUREAU"
	And I click on the "Search" link
	And I set "Juror's pool number" to "<pool_number>"
	And I press the "Search" button
	Then I see "<juror_number>" in the same row as "<juror_number>"
	When I click on "<juror_number>" in the same row as "<juror_number>"
	When I select "Mark as responded" from Process reply
	And I check the "Mark juror as 'responded'" checkbox
	And I press the "Confirm" button
	Then I see "Completed" on the page

	Then on "JUROR_MOD" . "JUROR_RESPONSE" I see "PROCESSING_STATUS" is "CLOSED" where "JUROR_NUMBER" is "<juror_number>"
	Then on "JUROR_MOD" . "JUROR" I see "TITLE" is null where "JUROR_NUMBER" is "<juror_number>"
	Then on "JUROR_MOD" . "JUROR" I see "ADDRESS3" is null where "JUROR_NUMBER" is "<juror_number>"
	Then on "JUROR_MOD" . "JUROR" I see "ADDRESS5" is null where "JUROR_NUMBER" is "<juror_number>"
	Then on "JUROR_MOD" . "JUROR" I see "ADDRESS6" is null where "JUROR_NUMBER" is "<juror_number>"
	Then on "JUROR_MOD" . "JUROR" I see "H_PHONE" is null where "JUROR_NUMBER" is "<juror_number>"
	Then on "JUROR_MOD" . "JUROR" I see "W_PHONE" is null where "JUROR_NUMBER" is "<juror_number>"
	Then on "JUROR_MOD" . "JUROR" I see "W_PH_LOCAL" is null where "JUROR_NUMBER" is "<juror_number>"
	Then on "JUROR_MOD" . "JUROR" I see "TIMES_SEL" is null where "JUROR_NUMBER" is "<juror_number>"
	Then on "JUROR_MOD" . "JUROR" I see "TRIAL_NO" is null where "JUROR_NUMBER" is "<juror_number>"
	Then on "JUROR_MOD" . "JUROR" I see "JUROR_NO" is null where "JUROR_NUMBER" is "<juror_number>"
	Then on "JUROR_MOD" . "JUROR" I see "DEF_DATE" is null where "JUROR_NUMBER" is "<juror_number>"
	Then on "JUROR_MOD" . "JUROR" I see "DATE_EXCUS" is null where "JUROR_NUMBER" is "<juror_number>"
	Then on "JUROR_MOD" . "JUROR" I see "EXC_CODE" is null where "JUROR_NUMBER" is "<juror_number>"
	Then on "JUROR_MOD" . "JUROR" I see "ACC_EXC" is null where "JUROR_NUMBER" is "<juror_number>"
	Then on "JUROR_MOD" . "JUROR" I see "DATE_DISQ" is null where "JUROR_NUMBER" is "<juror_number>"
	Then on "JUROR_MOD" . "JUROR" I see "DISQ_CODE" is null where "JUROR_NUMBER" is "<juror_number>"
	Then on "JUROR_MOD" . "JUROR" I see "MILEAGE" is null where "JUROR_NUMBER" is "<juror_number>"
	Then on "JUROR_MOD" . "JUROR" I see "LOCATION" is null where "JUROR_NUMBER" is "<juror_number>"
	Then on "JUROR_MOD" . "JUROR" I see "NOTES" is null where "JUROR_NUMBER" is "<juror_number>"
	Then on "JUROR_MOD" . "JUROR" I see "NO_ATTENDANCES" is null where "JUROR_NUMBER" is "<juror_number>"
	Then on "JUROR_MOD" . "JUROR" I see "NO_DEF_POS" is null where "JUROR_NUMBER" is "<juror_number>"
	Then on "JUROR_MOD" . "JUROR" I see "NO_ATTENDED" is null where "JUROR_NUMBER" is "<juror_number>"
	Then on "JUROR_MOD" . "JUROR" I see "NO_FTA" is null where "JUROR_NUMBER" is "<juror_number>"
	Then on "JUROR_MOD" . "JUROR" I see "NO_AWOL" is null where "JUROR_NUMBER" is "<juror_number>"
	Then on "JUROR_MOD" . "JUROR" I see "EDIT_TAG" is null where "JUROR_NUMBER" is "<juror_number>"
	Then on "JUROR_MOD" . "JUROR" I see "PERM_DISQUAL" is null where "JUROR_NUMBER" is "<juror_number>"
	Then on "JUROR_MOD" . "JUROR" I see "PAY_COUNTY_EMP" is null where "JUROR_NUMBER" is "<juror_number>"
	Then on "JUROR_MOD" . "JUROR" I see "PAY_EXPENSES" is null where "JUROR_NUMBER" is "<juror_number>"
	Then on "JUROR_MOD" . "JUROR" I see "SPEC_NEED" is null where "JUROR_NUMBER" is "<juror_number>"
	Then on "JUROR_MOD" . "JUROR" I see "SPEC_NEED_MSG" is null where "JUROR_NUMBER" is "<juror_number>"
	Then on "JUROR_MOD" . "JUROR" I see "SMART_CARD" is null where "JUROR_NUMBER" is "<juror_number>"
	Then on "JUROR_MOD" . "JUROR" I see "AMT_SPENT" is null where "JUROR_NUMBER" is "<juror_number>"
	Then on "JUROR_MOD" . "JUROR" I see "COMPLETION_FLAG" is null where "JUROR_NUMBER" is "<juror_number>"
	Then on "JUROR_MOD" . "JUROR" I see "SORT_CODE" is null where "JUROR_NUMBER" is "<juror_number>"
	Then on "JUROR_MOD" . "JUROR" I see "BANK_ACCT_NAME" is null where "JUROR_NUMBER" is "<juror_number>"
	Then on "JUROR_MOD" . "JUROR" I see "BANK_ACCT_NO" is null where "JUROR_NUMBER" is "<juror_number>"
	Then on "JUROR_MOD" . "JUROR" I see "BLDG_SOC_ROLL_NO" is null where "JUROR_NUMBER" is "<juror_number>"
	Then on "JUROR_MOD" . "JUROR" I see "WAS_DEFERRED" is null where "JUROR_NUMBER" is "<juror_number>"
	Then on "JUROR_MOD" . "JUROR" I see "ID_CHECKED" is null where "JUROR_NUMBER" is "<juror_number>"
	Then on "JUROR_MOD" . "JUROR" I see "POSTPONE" is null where "JUROR_NUMBER" is "<juror_number>"
	Then on "JUROR_MOD" . "JUROR" I see "WELSH" is null where "JUROR_NUMBER" is "<juror_number>"
	Then on "JUROR_MOD" . "JUROR" I see "PAID_CASH" is null where "JUROR_NUMBER" is "<juror_number>"
	Then on "JUROR_MOD" . "JUROR" I see "TRAVEL_TIME" is null where "JUROR_NUMBER" is "<juror_number>"
	Then on "JUROR_MOD" . "JUROR" I see "SCAN_CODE" is null where "JUROR_NUMBER" is "<juror_number>"
	Then on "JUROR_MOD" . "JUROR" I see "FINANCIAL_LOSS" is null where "JUROR_NUMBER" is "<juror_number>"
	Then on "JUROR_MOD" . "JUROR" I see "POLICE_CHECK" is null where "JUROR_NUMBER" is "<juror_number>"
	Then on "JUROR_MOD" . "JUROR" I see "SUMMONS_FILE" is null where "JUROR_NUMBER" is "<juror_number>"
	Then on "JUROR_MOD" . "JUROR" I see "REMINDER_SENT" is null where "JUROR_NUMBER" is "<juror_number>"
	Then on "JUROR_MOD" . "JUROR" I see "PHOENIX_CHECKED" is null where "JUROR_NUMBER" is "<juror_number>"
	Then on "JUROR_MOD" . "JUROR" I see "CONTACT_PREFERENCE" is null where "JUROR_NUMBER" is "<juror_number>"
	Then on "JUROR_MOD" . "JUROR" I see "SERVICE_COMP_COMMS_STATUS" is null where "JUROR_NUMBER" is "<juror_number>"
	Then on "JUROR_MOD" . "JUROR" I see "TRANSFER_DATE" is null where "JUROR_NUMBER" is "<juror_number>"

	Examples:
		| juror_number	| pool_number 	| last_name | postcode 	|
		| 045200130		| 452300129 	| LNAMEONE	| CH1 2AN	|