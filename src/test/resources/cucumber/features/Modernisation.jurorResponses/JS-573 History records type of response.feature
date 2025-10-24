Feature: JS-573 History records type of response

@JurorTransformationMulti
Scenario Outline: History records type of response

	Given I am on "Public" "ithc"

	Given a bureau owned pool is created with jurors
		| court | juror_number  	| pool_number	| att_date_weeks_in_future	| owner |
		| 415	| <juror_number1> 	| <pool_number> | 5				            | 400	|
		| 415	| <juror_number2> 	| <pool_number> | 5				            | 400	|
		| 415	| <juror_number3> 	| <pool_number> | 5				            | 400	|

	And juror "<juror_number1>" has "LAST_NAME" as "<last_name>" new schema
	And juror "<juror_number1>" has "POSTCODE" as "<postcode>" new schema

	And juror "<juror_number2>" has "LAST_NAME" as "<last_name>" new schema
	And juror "<juror_number2>" has "POSTCODE" as "<postcode>" new schema

	And juror "<juror_number3>" has "LAST_NAME" as "<last_name>" new schema
	And juror "<juror_number3>" has "POSTCODE" as "<postcode>" new schema

	#DIGITAL Auto Processed 1st ST
	Given I have submitted a first party English straight through response
		|part_no			|pool_number	|last_name		|postcode	|email 	|
		|<juror_number1>	|<pool_number>	|<last_name>	|<postcode>	|<email>|

	#DIGITAL deferral response TO DO
	Given I have submitted a first party English deferral response
		|part_no	      	|pool_number   	|last_name		|postcode	|email   |
		|<juror_number2>  	|<pool_number>	|<last_name>	|<postcode>	|<email> |

	Given I am on "Bureau" "ithc"
	When I log in as "MODTESTBUREAU"

	#PAPER response processed
	Then the user searches for juror record "<juror_number3>" from the global search bar
	And I record a happy path paper summons response and process now
	
	Then on "JUROR_MOD" . "JUROR_HISTORY" I see "OTHER_INFORMATION" is "Digital" where "juror_number" is "<juror_number1>"
	Then on "JUROR_MOD" . "JUROR_HISTORY" I see "OTHER_INFORMATION" is "Digital" where "juror_number" is "<juror_number2>"
	Then on "JUROR_MOD" . "JUROR_HISTORY" I see "OTHER_INFORMATION" is "Paper" where "juror_number" is "<juror_number3>"
	
Examples:
	|juror_number1	|juror_number2	|juror_number3	|pool_number|last_name 	|postcode	|email		|
	|641500608		|641500609		|641500610		|415260401	|LNAME 		|CH1 2AN	|e@mail.com	|
