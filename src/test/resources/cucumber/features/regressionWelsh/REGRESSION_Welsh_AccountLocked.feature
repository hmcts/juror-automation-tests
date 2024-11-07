Feature: Regression_Welsh_AccountLocked

@RegressionWelsh
Scenario Outline: 1st Party Account Locked Welsh

	Given I am on the welsh version of "Public" "ithc"

	Given a bureau owned pool is created with jurors
		| court | juror_number  	| pool_number	| att_date_weeks_in_future	| owner |
		| 457   | <juror_number>	| <pool_number>	| 5			            	| 400	|

	And juror "<juror_number>" has "LAST_NAME" as "<last_name>" new schema
	And juror "<juror_number>" has "POSTCODE" as "<postcode>" new schema

#replying for myself
	And I set the radio button to "n ymateb dros fy hun"
	And I press the "Parhau" button
	And I do not see any links on the page that open to a new page without an alt text

#log on attempt #1
	When I set "Rhif rheithiwr" to "<juror_number>"
	And I set "Cyfenw" to "Smith"
	And I set "Cod post Rheithiwr" to "SW17 7SR"
	And I press the "Parhau" button
	Then I see "Nid yw'r cyfuniad o’ch enw, cod post a rhif rheithiwr wedi’u hadnabod" on the page
	
#log on attempt #2
	When I set "Rhif rheithiwr" to "<juror_number>"
	And I set "Cyfenw" to "Smith"
	And I set "Cod post Rheithiwr" to "SW17 7SR"
	And I press the "Parhau" button
	Then I see "Nid yw'r cyfuniad o’ch enw, cod post a rhif rheithiwr wedi’u hadnabod" on the page
	
#log on attempt #3
	When I set "Rhif rheithiwr" to "<juror_number>"
	And I set "Cyfenw" to "Smith"
	And I set "Cod post Rheithiwr" to "SW17 7SR"
	And I press the "Parhau" button
	Then I see "Nid yw'r cyfuniad o’ch enw, cod post a rhif rheithiwr wedi’u hadnabod" on the page
	
#log on attempt #4
	When I set "Rhif rheithiwr" to "<juror_number>"
	And I set "Cyfenw" to "Smith"
	And I set "Cod post Rheithiwr" to "SW17 7SR"
	And I press the "Parhau" button
	And I do not see any links on the page that open to a new page without an alt text

#@JM-8228
	Then I see "Rydych wedi ceisio mewngofnodi gormod o weithiau" on the page
	And I see "Mae eich ymateb i wŷs bellach wedi'i gloi. Rhowch gynnig arall arni mewn 30 munud." on the page
	And I see "Rhowch eich enw a'ch cod post yn union fel y dangosir ar eich llythyr gwŷs, hyd yn oed os ydynt yn anghywir. Gallwch eu cywiro yn ddiweddarach." on the page
	And I see "Os ydych chi'n dal i gael problemau, cysylltwch â ni." on the page

Examples:
	| juror_number	| last_name	| postcode	| pool_number	|
	| 045700060		| LNAME1977	| CH1 2AN	| 457300060		|

@RegressionWelsh
Scenario Outline: 3rd Party Account Locked Welsh

	Given I am on the welsh version of "Public" "ithc"

	Given a bureau owned pool is created with jurors
		| court | juror_number  	| pool_number	| att_date_weeks_in_future	| owner |
		| 457   | <juror_number>	| <pool_number>	| 5			            	| 400	|
	
	And juror "<juror_number>" has "LAST_NAME" as "<last_name>" new schema
	And juror "<juror_number>" has "POSTCODE" as "<postcode>" new schema

	And I set the radio button to "Rwy'n ymateb ar ran rhywun arall"
	And I press the "Parhau" button
	And I do not see any links on the page that open to a new page without an alt text

#log on attempt #1
	When I set "Rhif rheithiwr" to "<juror_number>"
	When I set "Cyfenw" to "Smith"
	When I set "Cod post Rheithiwr" to "SW17 7SR"
	And I press the "Parhau" button
	Then I see "Nid yw'r cyfuniad o’r enw, cod post a rhif rheithiwr yn gyfarwydd." on the page
	And I do not see any links on the page that open to a new page without an alt text
	
#log on attempt #2
	When I set "Rhif rheithiwr" to "<juror_number>"
	When I set "Cyfenw" to "Smith"
	When I set "Cod post Rheithiwr" to "SW17 7SR"
	And I press the "Parhau" button
	Then I see "Nid yw'r cyfuniad o’r enw, cod post a rhif rheithiwr yn gyfarwydd." on the page
	And I do not see any links on the page that open to a new page without an alt text
	
#log on attempt #3
	When I set "Rhif rheithiwr" to "<juror_number>"
	When I set "Cyfenw" to "Smith"
	When I set "Cod post Rheithiwr" to "SW17 7SR"
	And I press the "Parhau" button
	Then I see "Nid yw'r cyfuniad o’r enw, cod post a rhif rheithiwr yn gyfarwydd." on the page
	And I do not see any links on the page that open to a new page without an alt text
	
#log on attempt #4
	When I set "Rhif rheithiwr" to "<juror_number>"
	When I set "Cyfenw" to "Smith"
	When I set "Cod post Rheithiwr" to "SW17 7SR"
	And I press the "Parhau" button
	And I do not see any links on the page that open to a new page without an alt text

#@JM-8228
	Then I see "Rydych wedi ceisio mewngofnodi gormod o weithiau" on the page
	And I see "Mae'r ymateb i wŷs bellach wedi’i gloi. Rhowch gynnig arall arni mewn 30 munud." on the page
	And I see "Rhowch enw a chod post yr unigolyn yn union fel y dangosir ar ei lythyr gwŷs, hyd yn oed os ydynt yn anghywir. Gallwch eu cywiro yn ddiweddarach." on the page
	And I see "Os ydych chi'n dal i gael problemau, cysylltwch â ni." on the page

Examples:
	| juror_number	| last_name	| postcode	| pool_number	|
	| 045700061		| LNAME1970	| CH1 2AN	| 457300061		|