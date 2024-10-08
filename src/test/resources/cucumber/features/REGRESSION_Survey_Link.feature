Feature: Regression Survey_Link

@Regression
Scenario Outline: Survey Link 1st Party Eng
	
	Given I am on "Public" "test"

	Given a bureau owned pool is created with jurors
		| court | juror_number  | pool_number	| att_date_weeks_in_future	| owner |
		| 452   | <juror_number>| <pool_number>	| 5				            | 400	|
		
	And juror "<juror_number>" has "LAST_NAME" as "<last_name>" new schema
	And juror "<juror_number>" has "POSTCODE" as "<postcode>" new schema
	
	And I set the radio button to "I am replying for myself"
	And I press the "Continue" button
	
	When I set "9-digit juror number" to "<juror_number>"
	And I set "Juror last name" to "<last_name>"
	And I set "Juror postcode" to "<postcode>"
	And I press the "Continue" button
	
	#name
	Then I see "Is the name we have for you correct?" on the page
	
	And I see "Give feedback (opens in a new window or tab)" on the page
	And I click on the "Give feedback (opens in a new window or tab)" link
	And I switch to the new window
#	Then I see "Were you able to do what you needed to do today?" on the page
	And I see "https://www.smartsurvey.co.uk/s/DL1RCF/" in the URL

Examples:
	| juror_number	| last_name			| postcode	| pool_number	|
	| 045200205		| LNAMEONEONENINE	| CH1 2AN	| 452300190		|
	
@Regression
Scenario Outline: Survey Link 3rd Party Eng
	
	Given I am on "Public" "ithc"

	Given a bureau owned pool is created with jurors
		| court | juror_number  | pool_number	| att_date_weeks_in_future	| owner |
		| 452   | <juror_number>| <pool_number>	| 5				            | 400	|
		
	And juror "<juror_number>" has "LAST_NAME" as "<last_name>" new schema
	And juror "<juror_number>" has "POSTCODE" as "<postcode>" new schema
	
	And I set the radio button to "I am replying for someone else"
	And I press the "Continue" button
	Then I see "Their juror details" on the page
	
	When I set "9-digit juror number" to "<juror_number>"
	When I set "Juror last name" to "<last_name>"
	When I set "Juror postcode" to "<postcode>"
	And I press the "Continue" button
	Then I see "What is your name?" on the page
	
	And I see "Give feedback (opens in a new window or tab)" on the page
	And I click on the "Give feedback (opens in a new window or tab)" link
	And I switch to the new window
	Then I see "Were you able to do what you needed to do today?" on the page
	And I see "https://www.smartsurvey.co.uk/s/DL1RCF/" in the URL
	
Examples:
	| juror_number	| last_name			| postcode	| pool_number	|
	| 045200206		| LNAMEONEONENINE	| CH1 2AN	| 452300191		|
	
@RegressionWelsh
Scenario Outline: Survey Link 1st Party Welsh
	
	Given I am on the welsh version of "Public" "test"

	Given a bureau owned pool is created with jurors
		| court |juror_number  | pool_number	| att_date_weeks_in_future	| owner |
		| 457   |<juror_number>| <pool_number>	| 5				            | 400	|

	And juror "<juror_number>" has "LAST_NAME" as "<last_name>" new schema
	And juror "<juror_number>" has "POSTCODE" as "<postcode>" new schema

	And I set the radio button to "n ymateb dros fy hun"
	And I press the "Parhau" button
	Then I see "Eich manylion rheithiwr" on the page
	
	When I set "Rhif rheithiwr" to "<juror_number>"
	When I set "Cyfenw" to "<last_name>"
	When I set "Cod post Rheithiwr" to "<postcode>"
	And I press the "Parhau" button
	Then I see "A yw'r enw sydd gennym ar eich cyfer chi yn gywir?" on the page
	
	And I see "Give feedback (opens in a new window or tab)" on the page
	And I click on the "Give feedback (opens in a new window or tab)" link
	And I focus page to the new tab
	Then I see "Were you able to do what you needed to do today?" on the page
	And I see "https://www.smartsurvey.co.uk/s/DL1RCF/" in the URL
	
Examples:
	| juror_number	| last_name			| postcode	| pool_number	|
	| 045700039		| LNAMEONEONENINE	| CH1 2AN	| 457300039		|

@RegressionWelsh
Scenario Outline: Survey Link 3rd Party Welsh
	
	Given I am on the welsh version of "Public" "ithc"

	Given a bureau owned pool is created with jurors
		| court |juror_number  | pool_number	| att_date_weeks_in_future	| owner |
		| 457   |<juror_number>| <pool_number>	| 5				            | 400	|

	And juror "<juror_number>" has "LAST_NAME" as "<last_name>" new schema
	And juror "<juror_number>" has "POSTCODE" as "<postcode>" new schema
	
	And I set the radio button to "Rwy'n ymateb ar ran rhywun arall"
	And I press the "Parhau" button
	
	When I set "Rhif rheithiwr" to "<juror_number>"
	When I set "Cyfenw" to "<last_name>"
	When I set "Cod post Rheithiwr" to "<postcode>"
	And I press the "Parhau" button
	
	And I see "Give feedback (opens in a new window or tab)" on the page
	And I click on the "Give feedback (opens in a new window or tab)" link
	And I switch to the new window
	Then I see "Were you able to do what you needed to do today?" on the page
	And I see "https://www.smartsurvey.co.uk/s/DL1RCF/" in the URL
	
Examples:
	| juror_number	| last_name			| postcode	| pool_number	|
	| 045700038		| LNAMEONEONENINE	| CH1 2AN	| 457300038		|