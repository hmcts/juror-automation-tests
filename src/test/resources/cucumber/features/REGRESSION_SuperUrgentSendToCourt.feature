Feature: JDB-3759 SuperUrgentSendToCourt

#A response is submitted after pool is transferred to court
#submit a response where read_only='n' and ret_date/next_date is in 1 week
#reg test urgents are still calculated as before
#A response is submitted then transferred to court before being processed in JD -not applicable see JDB-3901 (test manually)
#cover status 11 Awaiting Information (test manually)
#cover assigned/unassigned (test manually with prev test)
#read_only turns to Y before response is U or SU (test manually)

@Regression @NewSchemaConverted
Scenario Outline: A response is submitted after pool is transferred to court

	Given I am on "Public" "test"

	Given a bureau owned pool is created with jurors
		| court |juror_number  | pool_number	| att_date_weeks_in_future	| owner |
		| 452   |<juror_number>| <pool_number>	| -1			            | 400	|

	Given a new pool is inserted for where record has transferred to the court new schema
		| part_no        | pool_no       | owner |
		| <juror_number> | <pool_number> | 452   |

	And juror "<juror_number>" has "LAST_NAME" as "<last_name>" new schema
	And juror "<juror_number>" has "POSTCODE" as "<postcode>" new schema
	
	# Attempt to submit response
	And I set the radio button to "I am replying for myself"
	And I press the "Continue" button

	When I set "9-digit juror number" to "<juror_number>"
	When I set "Juror last name" to "<last_name>"
	When I set "Juror postcode" to "<postcode>"
	And I press the "Continue" button

	Then I see "You can no longer complete this summons reply online" on the page
	Then I see "This is because the summons date has passed. You must contact us by phone or email." on the page
	And I see "/steps/login/summons-date" in the URL

	Given a bureau owned pool is created with jurors
		| court |juror_number  | pool_number	| att_date_weeks_in_future	| owner |
		| 452   |<juror_number>| <pool_number>	| 1			            	| 400	|

	Given a new pool is inserted for where record has transferred to the court new schema
		| part_no        | pool_no       | owner |
		| <juror_number> | <pool_number> | 452   |

	And juror "<juror_number>" has "LAST_NAME" as "<last_name>" new schema
	And juror "<juror_number>" has "POSTCODE" as "<postcode>" new schema

	Given I have submitted a first party English straight through response
		| part_no		| pool_number	| last_name		| postcode	| email 	|
		| <juror_number>| <pool_number>	| <last_name>	| <postcode>| <email>	|

	#check status
	Then on "JUROR_MOD" . "JUROR_RESPONSE" I see "URGENT" is "N" where "JUROR_NUMBER" is "<juror_number>"
	Then on "JUROR_MOD" . "JUROR_RESPONSE" I see "SUPER_URGENT" is "Y" where "JUROR_NUMBER" is "<juror_number>"

	Given I am on "Bureau" "test"
	And I log in as "CPASS"

	When I click on the "Search" link
	And I set "Juror number" to "<juror_number>"
	And I press the "Search" button
	And I click on "<juror_number>" in the same row as "<juror_number>"

	#check status = summoned
	And I see "Summoned" on the page

	And I press the "More actions" button
	And I click on the "Download as a PDF" link
	And I switch to the new window
	And I see "<juror_number>/download-pdf" in the URL

Examples:
	| juror_number	| pool_number	| last_name			| postcode	| email 		|
	| 045200202		| 452300187		| LNAMEEIGHTSIXFIVE	| NN1 3HQ	| e@mail.com	|
	
@Regression @NewSchemaConverted
Scenario Outline: Regression test that Urgents still calculated correctly 
	
	Given I am on "Public" "test"

	Given a bureau owned pool is created with jurors
		| court | juror_number  | pool_number	| att_date_weeks_in_future	| owner |
		| 452   | <juror_number>| <pool_number>	| 3				            | 400	|
	
	#Set part_no pool to be 3 mondays from now
	And juror "<juror_number>" has "LAST_NAME" as "<last_name>" new schema
	And juror "<juror_number>" has "POSTCODE" as "<postcode>" new schema

	# Submit response in pool
	Given I have submitted a first party English straight through response
		| part_no		| pool_number	| last_name		| postcode	| email 	|
		| <juror_number>| <pool_number>	| <last_name>	| <postcode>| <email>	|

	#check status
	Then on "JUROR_MOD" . "JUROR_RESPONSE" I see "URGENT" is "Y" where "JUROR_NUMBER" is "<juror_number>"
	Then on "JUROR_MOD" . "JUROR_RESPONSE" I see "SUPER_URGENT" is "N" where "JUROR_NUMBER" is "<juror_number>"
	
	Given I am on "Bureau" "test"
	And I log in as "CPASS"
	
	When I click on the "Search" link
	And I set "Juror number" to "<juror_number>"
	And I press the "Search" button
	And I click on "<juror_number>" in the same row as "<juror_number>"
	
	#check status = summoned
	Then I see "Summoned" on the page
	And I see "URGENT" on the page
	
	When I select "Mark as responded" from Process reply
	And I check the "Mark juror as 'responded'" checkbox
	And I press the "Confirm" button
	
	#now check status
	And I do not see "URGENT" on the page
	Then I see "Responded" on the page
	And I see the juror record updated banner containing "Responded"
	Then on "JUROR_MOD" . "JUROR_RESPONSE" I see "URGENT" is "Y" where "JUROR_NUMBER" is "<juror_number>"
	Then on "JUROR_MOD" . "JUROR_RESPONSE" I see "SUPER_URGENT" is "N" where "JUROR_NUMBER" is "<juror_number>"
	
Examples:
	| juror_number	| pool_number	| last_name			| postcode	| email 	|
	| 045200203		| 452300188		| LNAMENINEONEFOUR	| SY2 6LU	| a@a.com	|
	
@RegressionWelsh @NewSchemaConverted
Scenario Outline: Test that a response with ret_date in 1 week and read_only='N' is not flagged super urgent
	
	Given I am on the welsh version of "Public" "test"

	Given a bureau owned pool is created with jurors
		| court | juror_number  | pool_number	| att_date_weeks_in_future	| owner |
		| 452   | <juror_number>| <pool_number>	| 1				            | 400	|

	And juror "<juror_number>" has "LAST_NAME" as "<last_name>" new schema
	And juror "<juror_number>" has "POSTCODE" as "<postcode>" new schema
	
#	# Attempt to submit response
#	And I set the radio button to "n ymateb dros fy hun"
#	And I press the "Parhau" button
#	Then I see "Eich manylion rheithiwr" on the page
#	
#	When I set "Rhif rheithiwr" to "<juror_number>"
#	When I set "Cyfenw" to "<last_name>"
#	When I set "Cod post Rheithiwr" to "<postcode>"
#	And I press the "Parhau" button
#	
#	Then I see "Mae'r dyddiad ar gyfer eich gwŷs rheithgor wedi mynd heibio. Ni allwch ymateb drwy ddefnyddio'r gwasanaeth hwn." on the page
	
	Given I have submitted a first party Welsh straight through response
		| part_no		| pool_number	| last_name		| postcode	| email 	|
		| <juror_number>| <pool_number>	| <last_name>	| <postcode>| <email>	|

	#check status
#
#	Then on "JUROR_MOD" . "JUROR_RESPONSE" I see "URGENT" is "Y" where "JUROR_NUMBER" is "<juror_number>"
#	Then on "JUROR_MOD" . "JUROR_RESPONSE" I see "SUPER_URGENT" is "N" where "JUROR_NUMBER" is "<juror_number>"
#
#	Given I am on "Bureau" "juror-test01"
#	And I log in as "CPASS"
#
#	When I click on the "Search" link
#	And I set "Juror number" to "<juror_number>"
#	And I press the "Search" button
#	And I click on "<juror_number>" in the same row as "<juror_number>"
#
#	#check status = summoned
#
#	Then I see "Summoned" on the page
#	And I do not see "SEND TO COURT" on the page
#
#	When I select "Mark as responded" from Process reply
#	And I check the "Mark juror as 'responded'" checkbox
#	And I press the "Confirm" button
#
#	#now check status
#
#	Then I see "Responded" on the page
#	And I see "COMPLETED" on the page
#	Then on "JUROR_MOD" . "JUROR_RESPONSE" I see "URGENT" is "Y" where "JUROR_NUMBER" is "<juror_number>"
#	Then on "JUROR_MOD" . "JUROR_RESPONSE" I see "SUPER_URGENT" is "N" where "JUROR_NUMBER" is "<juror_number>"
		
Examples:
	| juror_number	| pool_number	| last_name			| postcode	| email 		|
	| 045200204		| 452300189		| LNAMEONESIXONE	| SA1 4PF	| e@mail.com	|