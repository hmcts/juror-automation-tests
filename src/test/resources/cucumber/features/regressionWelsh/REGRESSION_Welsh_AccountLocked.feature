Feature: Regression_Welsh_AccountLocked

@RegressionWelsh @NewSchemaConverted
Scenario Outline: 1st Party Account Locked

	Given I am on the welsh version of "Public" "test"

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

	Then I see "Am resymau diogelwch, mae eich cyfrif wedi'i gloi oherwydd ymdrechion mewngofnodi lluosog ac ni allwch ateb ar-lein bellach. Cysylltwch â Chanolfan Atgyfeirio Canolog y Rheithgor am fwy o wybodaeth - mae ein manylion isod yn yr adran 'Nid oes gennyf rif rheithgor'." on the page
	
Examples:
	| juror_number	| last_name	| postcode	| pool_number	|
	| 045700060		| LNAME1977	| CH1 2AN	| 457300060		|

@RegressionWelsh @NewSchemaConverted
Scenario Outline: 3rd Party Account Locked

	Given I am on the welsh version of "Public" "test"

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

	Then I see "Mae’r cyfrif hwn wedi cael ei gloi am resymau diogelwch oherwydd sawl ymgais aflwyddiannus i fewngofnodi. Ni allwch mwyach ymateb ar-lein. Os gwelwch yn dda, cysylltwch ȃ Swyddfa Ganolog Gwysio Rheithgor i gael rhagor o wybodaeth – mae ein manylion isod yn yr adran ‘nid oes gen i rif rheithiwr’." on the page
	And I do not see any links on the page that open to a new page without an alt text

Examples:
	| juror_number	| last_name	| postcode	| pool_number	|
	| 045700061		| LNAME1970	| CH1 2AN	| 457300061		|