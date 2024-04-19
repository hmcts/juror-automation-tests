Feature: Regression JDB-4242 3rd Party Details Do Not Update Legacy Juror

@Regression @NewSchemaConverted
Scenario Outline: English 3rd Party Deceased

	Given I am on "Public" "test"

	Given auto straight through processing has been enabled new schema

	Given a bureau owned pool is created with jurors
		| court |juror_number  | pool_number	| att_date_weeks_in_future	| owner |
		| 452   |<juror_number>| <pool_number>	| 5				            | 400	|
	
	And juror "<juror_number>" has "LAST_NAME" as "<last_name>" new schema
	And juror "<juror_number>" has "POSTCODE" as "<postcode>" new schema
	
	And I have submitted a third party English deceased response
	| part_no			| pool_number	| last_name		| postcode		| email 	|
	| <juror_number>	| <pool_number>	| <last_name>	| <postcode>	| <email>	|
	
	Then on "JUROR_MOD" . "JUROR" I see "RESPONDED" is "Y" where "JUROR_NUMBER" is "<juror_number>"
	Then on "JUROR_MOD" . "JUROR" I see "H_EMAIL" is null where "JUROR_NUMBER" is "<juror_number>"
	Then on "JUROR_MOD" . "JUROR" I see "M_PHONE" is null where "JUROR_NUMBER" is "<juror_number>"
	Then on "JUROR_MOD" . "JUROR" I see "H_PHONE" is null where "JUROR_NUMBER" is "<juror_number>"
	Then on "JUROR_MOD" . "JUROR" I see "W_PHONE" is null where "JUROR_NUMBER" is "<juror_number>"
	Then on "JUROR_MOD" . "JUROR" I see "EXCUSAL_CODE" is "D" where "JUROR_NUMBER" is "<juror_number>"

Examples:
	| juror_number	| last_name			| postcode	| email          	| pool_number	|
	| 045200193		| LNAMETWOSIXEIGHT	| CH1 2AN	| email@outlook.com	| 452300178		|
	
@Features @NewSchemaConverted
Scenario Outline: English 3rd Party Excused - contact details same as 3rd party

	#moved to Features 02-01-24 return to Regression

	Given I am on "Public" "test"

	Given a bureau owned pool is created with jurors
		| court |juror_number  | pool_number	| att_date_weeks_in_future	| owner |
		| 452   |<juror_number>| <pool_number>	| 5				            | 400	|
	
	And juror "<juror_number>" has "LAST_NAME" as "<last_name>" new schema
	And juror "<juror_number>" has "POSTCODE" as "<postcode>" new schema
	
	And I have submitted a third party English excusal response
	| part_no		| pool_number	| last_name		| postcode	| email 	|
	| <juror_number>| <pool_number>	| <last_name>	| <postcode>| <email>	|
	
	Given I am on "Bureau" "test"
	And I log in as "MODTESTBUREAU"
	
	When I click on the "Search" link
	And I set "Juror number" to "<juror_number>"
	And I press the "Search" button
	And I click on "<juror_number>" in the same row as "<juror_number>"
	Then I see "Summoned" on the page
	
	#process in Bureau as Excused
	When I select "Excusal" from Process reply
	Then I select "O - OTHER" from the "Reason for excusal request" dropdown
	And I set the radio button to "Grant excusal"
	And I press the "Continue" button
	Then I see the juror record updated banner containing "Excusal granted (other)"
	
	Then on "JUROR_MOD" . "JUROR" I see "RESPONDED" is "Y" where "JUROR_NUMBER" is "<juror_number>"
	Then on "JUROR_MOD" . "JUROR" I see "H_EMAIL" is null where "JUROR_NUMBER" is "<juror_number>"
	Then on "JUROR_MOD" . "JUROR" I see "M_PHONE" is null where "JUROR_NUMBER" is "<juror_number>"
	Then on "JUROR_MOD" . "JUROR" I see "H_PHONE" is null where "JUROR_NUMBER" is "<juror_number>"
	Then on "JUROR_MOD" . "JUROR" I see "W_PHONE" is null where "JUROR_NUMBER" is "<juror_number>"

Examples:
	| juror_number	| last_name				| postcode	| email         	| pool_number	|
	| 045200194		| LNAMEFOURTHREETHREE	| NN1 3HQ	| email@outlook.com	| 452300179		|

@Features @NewSchemaConverted
Scenario Outline: English 3rd Party Deferred - contact details same as 3rd party

	#moved to Features 02-01-24 return to Regression

	Given I am on "Public" "test"

	Given a bureau owned pool is created with jurors
		| court |juror_number  | pool_number	| att_date_weeks_in_future	| owner |
		| 452   |<juror_number>| <pool_number>	| 6				            | 400	|

	And juror "<juror_number>" has "LAST_NAME" as "<last_name>" new schema
	And juror "<juror_number>" has "POSTCODE" as "<postcode>" new schema

	And I have submitted a third party English deferral response
	| part_no		| pool_number	| last_name		| postcode	| email 	|
	| <juror_number>| <pool_number>	| <last_name>	| <postcode>| <email>	|

	Given I am on "Bureau" "test"
	And I log in as "MODTESTBUREAU"
	
	When I click on the "Search" link
	And I set "Juror number" to "<juror_number>"
	And I press the "Search" button
	And I click on "<juror_number>" in the same row as "<juror_number>"
	
	When I select "Deferral" from Process reply
	
	And I select "O - OTHER" from the "Reason for the deferral request" dropdown
	And I select the first deferral choice

	And I press the "Continue" button
	And I see the juror record updated banner containing "Deferral granted (other)"
	
	Then on "JUROR_MOD" . "JUROR" I see "RESPONDED" is "Y" where "JUROR_NUMBER" is "<juror_number>"
	Then on "JUROR_MOD" . "JUROR" I see "H_EMAIL" is null where "JUROR_NUMBER" is "<juror_number>"
	Then on "JUROR_MOD" . "JUROR" I see "M_PHONE" is null where "JUROR_NUMBER" is "<juror_number>"
	Then on "JUROR_MOD" . "JUROR" I see "H_PHONE" is null where "JUROR_NUMBER" is "<juror_number>"
	Then on "JUROR_MOD" . "JUROR" I see "W_PHONE" is null where "JUROR_NUMBER" is "<juror_number>"

Examples:
	| juror_number	| last_name			| postcode	| email         	| pool_number	|
	| 045200195		| LNAMESIXSEVENFOUR	| NN1 3HQ	| email@outlook.com	| 452300180		|

@Features @NewSchemaConverted
Scenario Outline: English 3rd Party ST - contact details same as 3rd party

	#moved to Features 02-01-24 return to Regression

	Given I am on "Public" "test"

	Given a bureau owned pool is created with jurors
		| court |juror_number  | pool_number	| att_date_weeks_in_future	| owner |
		| 452   |<juror_number>| <pool_number>	| 5				            | 400	|
	
	And juror "<juror_number>" has "LAST_NAME" as "<last_name>" new schema
	And juror "<juror_number>" has "POSTCODE" as "<postcode>" new schema
	
	And I have submitted a third party English straight through response
	| part_no		| pool_number	| last_name		| postcode	| email 	|
	| <juror_number>| <pool_number>	| <last_name>	| <postcode>| <email>	|
	
	Given I am on "Bureau" "test"
	And I log in as "MODTESTBUREAU"
	
	When I click on the "Search" link
	And I set "Juror number" to "<juror_number>"
	And I press the "Search" button
	And I click on "<juror_number>" in the same row as "<juror_number>"
	
	When I select "Mark as responded" from Process reply
	And I check the "Mark juror as 'responded'" checkbox
	And I press the "Confirm" button
	Then I see the juror record updated banner containing "Responded"
	
	Then on "JUROR_MOD" . "JUROR" I see "RESPONDED" is "Y" where "JUROR_NUMBER" is "<juror_number>"
	Then on "JUROR_MOD" . "JUROR" I see "H_EMAIL" is null where "JUROR_NUMBER" is "<juror_number>"
	Then on "JUROR_MOD" . "JUROR" I see "M_PHONE" is null where "JUROR_NUMBER" is "<juror_number>"
	Then on "JUROR_MOD" . "JUROR" I see "H_PHONE" is null where "JUROR_NUMBER" is "<juror_number>"
	Then on "JUROR_MOD" . "JUROR" I see "W_PHONE" is null where "JUROR_NUMBER" is "<juror_number>"

Examples:
	| juror_number	| last_name			| postcode	| email         	| pool_number	|
	| 045200196		| LNAMESIXSEVENFOUR	| NN1 3HQ	| email@outlook.com	| 452300181		|
	
@Features @NewSchemaConverted
Scenario Outline: English 3rd Party Disqualified - contact details same as 3rd party

	#moved to Features 02-01-24 return to Regression

	Given I am on "Public" "test"

	Given a bureau owned pool is created with jurors
		| court |juror_number  | pool_number	| att_date_weeks_in_future	| owner |
		| 452   |<juror_number>| <pool_number>	| 5				            | 400	|
	
	And juror "<juror_number>" has "LAST_NAME" as "<last_name>" new schema
	And juror "<juror_number>" has "POSTCODE" as "<postcode>" new schema
	
	And I have submitted a third party English ineligibilty response
	| part_no		| pool_number	| last_name		| postcode	| email 	|
	| <juror_number>| <pool_number>	| <last_name>	| <postcode>| <email>	|
	
	Given I am on "Bureau" "test"
	And I log in as "MODTESTBUREAU"
	
	When I click on the "Search" link
	And I set "Juror number" to "<juror_number>"
	And I press the "Search" button
	And I click on "<juror_number>" in the same row as "<juror_number>"
	
	When I select "Disqualify" from Process reply
	
	#check error message
	And I press the "Continue" button
	And I see "Select the reason why you're disqualifying this juror" on the page
	
	And I choose the "N - Mental Capacity Act" radio button
	And I press the "Continue" button
	Then I see the juror record updated banner containing "Disqualified (Mental Capacity Act)"

	Then on "JUROR_MOD" . "JUROR" I see "RESPONDED" is "Y" where "JUROR_NUMBER" is "<juror_number>"
	Then on "JUROR_MOD" . "JUROR" I see "H_EMAIL" is null where "JUROR_NUMBER" is "<juror_number>"
	Then on "JUROR_MOD" . "JUROR" I see "M_PHONE" is null where "JUROR_NUMBER" is "<juror_number>"
	Then on "JUROR_MOD" . "JUROR" I see "H_PHONE" is null where "JUROR_NUMBER" is "<juror_number>"
	Then on "JUROR_MOD" . "JUROR" I see "W_PHONE" is null where "JUROR_NUMBER" is "<juror_number>"

Examples:
	| juror_number	| last_name			| postcode	| email         	| pool_number	|
	| 452300182		| LNAMEFOURFOURNINE	| NN1 3HQ	| email@outlook.com	| 045200197		|
	
@Regression @NewSchemaConverted
Scenario Outline: English 3rd Party Super Urgent - contact details same as 3rd party

	Given I am on "Public" "test"

	Given a bureau owned pool is created with jurors
		| court |juror_number  | pool_number	| att_date_weeks_in_future	| owner |
		| 452   |<juror_number>| <pool_number>	| 1				            | 400	|

	Given a new pool is inserted for where record has transferred to the court new schema
		|part_no             | pool_no           | owner |
		|<juror_number>      | <pool_number>     | 452   |
	
	And juror "<juror_number>" has "LAST_NAME" as "<last_name>" new schema
	And juror "<juror_number>" has "POSTCODE" as "<postcode>" new schema
	
	And I have submitted a third party English straight through response
	| part_no		| pool_number	| last_name		| postcode	| email 	|
	| <juror_number>| <pool_number>	| <last_name>	| <postcode>| <email>	|
	
	Given I am on "Bureau" "test"
	And I log in as "MODTESTBUREAU"
	
	When I click on the "Search" link
	And I set "Juror number" to "<juror_number>"
	And I press the "Search" button
	And I click on "<juror_number>" in the same row as "<juror_number>"
	
	Then I press the "More actions" button
	Then I click on the "Download as a PDF" link
	And I switch to the new window
	And I see "<juror_number>/download-pdf" in the URL

Examples:
	| juror_number	| last_name			| postcode	| email         	| pool_number	|
	| 045200198		| LNAMEFOURFIVEZERO	| NN1 3HQ	| email@outlook.com	| 452300183		|
	
@RegressionWelsh @NewSchemaConverted
Scenario Outline: English 3rd Party Welsh - contact details different for juror

	Given I am on the welsh version of "Public" "test"

	Given a bureau owned pool is created with jurors
		| court |juror_number  | pool_number	| att_date_weeks_in_future	| owner |
		| 457   |<juror_number>| <pool_number>	| 5				            | 400	|
	
	And juror "<juror_number>" has "LAST_NAME" as "<last_name>" new schema
	And juror "<juror_number>" has "POSTCODE" as "<postcode>" new schema
	
	And I set the radio button to "Rwy'n ymateb ar ran rhywun arall"
	And I press the "Parhau" button	
	
	#Juror Log In
	When I click on the "Nid oes gennyf rif rheithiwr ar gyfer yr unigolyn" link
	Then I see "Rhif ffôn: 0300 456 1024" on the page
	And I see "Llinell Gymraeg: 0300 303 5173" on the page
	
	When I set "Rhif rheithiwr" to "<juror_number>"
	When I set "Cyfenw" to "<last_name>"
	When I set "Cod post Rheithiwr" to "<postcode>"
	And I press the "Parhau" button
    Then I see "Beth yw eich enw?" on the page
	
	#3rd Party Name
	When I see "Eich Manylion" on the page
	When I set "Enw cyntaf" to "FirstNameA"
	And I set "Cyfenw" to "LastNameB"
	And I press the "Parhau" button
	Then I see "Eich perthynas â'r unigolyn" on the page
	
	#Relationship to juror
	When I see "Eich Manylion" on the page
	And I set "Sut ydych chi'n adnabod yr unigolyn rydych yn ymateb ar ei ran?" to "Friend"
	And I press the "Parhau" button
	Then I see "Eich manylion cyswllt" on the page
	
	#3rd Party Contact
	When I see "Eich Manylion" on the page
	And I check the "Dros y ffôn (rhifau yn y DU yn unig)" checkbox
	And I see "Darparwch rif ffôn yn y DU y gallwn ei ddefnyddio i gysylltu â chi rhwng 9am a 5pm, dydd Llun i ddydd Gwener." on the page
	And I set "Prif rif ffôn" to "0207 821 1818"
	And I check the "Trwy e-bost" checkbox
	And I set "Nodwch gyfeiriad e-bost" to "email@outlook.com"
	And I set "Nodwch gyfeiriad e-bost eto" to "email@outlook.com"
	And I click on the "Os ydych yn byw dramor" link
	And I see "Os ydych yn byw dramor ar hyn o bryd a heb rif ffôn y DU, byddwn angen cysylltu â chi drwy ddefnyddio cyfeiriad e-bost." on the page
	And I press the "Parhau" button
	
	#Why are you replying title
	Then I see "Pam ydych chi'n ymateb ar ran yr unigolyn arall?" on the page
	And I do not see "Pam ydych chi'n ymateb?" on the page
	When I set the radio button to "Nid yw'r unigolyn yma"
	And I see "Efallai ei fod yn teithio, yn yr ysbyty, neu i ffwrdd am fwy nag ychydig ddyddiau am reswm arall." on the page
	And I see "Nid yw'r unigolyn yn gallu ymateb dros ei hun" on the page
	And I see "Nid yw'r unigolyn â'r gallu i ymateb drosto'i hun. Efallai bod hyn oherwydd bod ganddo anabledd neu nam." on the page
	And I press the "Parhau" button
	Then I see "A yw'r enw sydd gennym ar ei gyfer yn gywir?" on the page
	
	#Check juror name
	When I see "A yw'r enw sydd gennym ar ei gyfer yn gywir?" on the page
	When I set the radio button to "Ydy"
	And I press the "Parhau" button
	Then I see "Ei gyfeiriad ef yw hwn?" on the page
	
	#Check juror address
	When I set the radio button to "Ie"
	And I press the "Parhau" button
	Then I see "Nodwch ddyddiad geni'r unigolyn rydych chi'n ymateb ar ei ran" on the page
	
	#DoB
	When I click on the "Cymorth gyda'ch dyddiad geni" link
	Then I see "Os oes arnoch angen cymorth, ffoniwch ni ar:" on the page
	And I see "Rhif ffôn: 0300 456 1024" on the page
	And I see "Llinell Gymraeg: 0300 303 5173" on the page
	
	And I see "Er enghraifft, 15 03 1982" on the page
	And I set "Diwrnod" to "27"
	And I set "Mis" to "04"
	And I set "Blwyddyn" to "1981"
	And I press the "Parhau" button
	Then I see "Efallai bydd yn rhaid inni gysylltu â'r unigolyn i ofyn rhagor o gwestiynau neu roi rhagor o wybodaeth iddynt am eu gwasanaeth rheithgor" on the page
	
	#Contacting the juror
	And I see "Nodwch rifau ffôn y gallwn eu defnyddio i gysylltu â chi rhwng 9am a 5pm, dydd Llun i ddydd Gwener." on the page
	
	And I set the radio button to "Rhoi rhif ffôn gwahanol ar gyfer y rheithiwr"
	And I set "Prif rif ffôn" to "07999999999"
	
	And I set the radio button to "Rhoi cyfeiriad e-bost gwahanol ar gyfer y rheithiwr"
	And I set "Nodwch y cyfeiriad e-bost" to "different@email.com"
	And I set "Nodwch y cyfeiriad e-bost unwaith eto" to "different@email.com"

	And I press the "Parhau" button
	Then I see "Bydd eich atebion yn yr adran nesaf yn ein helpu i wirio a yw'r unigolyn yr ydych yn ateb ar ei ran yn gallu gwasanaethu ar reithgor ai peidio." on the page

	#Qualify for jury service
	And I press the "Parhau" button

	#Residency
	And I set the radio button to "Do"
	And I press the "Parhau" button

	#CJS no
	And I set the radio button to "Nac ydy"
	And I press the "Parhau" button
	
	#Bail
	And I set the radio button to "Nac ydy"
	And I press the "Parhau" button
	
	#Convictions
	When I set the radio button to "Nac ydy"
	And I press the "Parhau" button

	#Mental Health Sectioned
	And I set the radio button to "Na"
	And I press the "Parhau" button
	
	#Mental Health Capacity
	And I set the radio button to "Na"
	And I press the "Parhau" button

	#The person can attend
	When I set the radio button to "Ydi, mae'r unigolyn yn gallu dechrau"
	
	And  I press the "Parhau" button
	
	#RA no
	When I set the radio button to "Nac oes"
	And I click on the "Pam ein bod yn gofyn am hyn?" link
	And I see "Os ydych yn pryderu am unrhyw beth arall ynghylch y gwasanaeth rheithgor o ran nam neu anabledd sydd gan yr unigolyn rydych yn ymateb ar ei ran, yna cysylltwch â ni." on the page
	And I see "Rhif ffôn: 0300 456 1024" on the page
	And I see "Llinell Gymraeg: 0300 303 5173" on the page
	And I press the "Parhau" button
	Then I see "Gwiriwch eich ymatebion nawr" on the page
	
	#Check your answers
	When I see "A ydi'r person yr ydych yn ymateb ar ei ran yn cael ei gadw, ei warchod neu ei drin o dan y Ddeddf Iechyd Meddwl?" on the page
	And I check the "Hyd gwn i, mae'r wybodaeth rwyf wedi ei rhoi am yr unigolyn rwyf yn ymateb ar ei ran yn gywir." checkbox
	And I press the "Cyflwyno" button
	Then I see "Os byddwn yn cysylltu â nhw, efallai bydd angen iddynt ddarparu eu rhif rheithiwr. Mae'r rhif hefyd ar y llythyr bu inni anfon atynt." on the page
	
	#Bureau process reply
	Given I am on "Bureau" "test"
	And I log in as "MODTESTBUREAU"
	
	When I click on the "Search" link
	And I set "Juror number" to "<juror_number>"
	And I press the "Search" button
	And I click on "<juror_number>" in the same row as "<juror_number>"
	
	When I select "Mark as responded" from Process reply
	And I check the "Mark juror as 'responded'" checkbox
	And I press the "Confirm" button
	Then I see the juror record updated banner containing "Responded"
	
	Then on "JUROR_MOD" . "JUROR" I see "RESPONDED" is "Y" where "JUROR_NUMBER" is "<juror_number>"
	Then on "JUROR_MOD" . "JUROR" I see "H_EMAIL" is null where "JUROR_NUMBER" is "<juror_number>"
	Then on "JUROR_MOD" . "JUROR" I see "M_PHONE" is null where "JUROR_NUMBER" is "<juror_number>"
	Then on "JUROR_MOD" . "JUROR" I see "H_PHONE" is null where "JUROR_NUMBER" is "<juror_number>"
	Then on "JUROR_MOD" . "JUROR" I see "W_PHONE" is null where "JUROR_NUMBER" is "<juror_number>"

Examples:
	| juror_number	| last_name			| postcode	| email         	| pool_number	|
	| 045700199		| LNAMESIXSEVENFIVE	| NN1 3HQ	| email@outlook.com	| 457300184		|

@Features @NewSchemaConverted
Scenario Outline: English 3rd Party Straight Through - Juror already has contact details

	#moved to Features 02-01-24 return to Regression

	Given I am on "Public" "test"

	Given a bureau owned pool is created with jurors
		| court |juror_number  | pool_number	| att_date_weeks_in_future	| owner |
		| 457   |<juror_number>| <pool_number>	| 5				            | 400	|
	
	And juror "<juror_number>" has "LAST_NAME" as "<last_name>" new schema
	And juror "<juror_number>" has "POSTCODE" as "<postcode>" new schema
	And juror "<juror_number>" has "H_EMAIL" as "eeeee@mail.com" new schema
	And juror "<juror_number>" has "H_PHONE" as "11111111111" new schema
	And juror "<juror_number>" has "W_PHONE" as "22222222222" new schema
	And juror "<juror_number>" has "M_PHONE" as "33333333333" new schema
	
	And I have submitted a third party English straight through response
	| part_no			| pool_number	| last_name		| postcode	| email 	|
	| <juror_number>	| <pool_number>	| <last_name>	| <postcode>| <email>	|
	
	#Bureau process reply
	Given I am on "Bureau" "test"
	And I log in as "MODTESTBUREAU"
	
	When I click on the "Search" link
	And I set "Juror number" to "<juror_number>"
	And I press the "Search" button
	And I click on "<juror_number>" in the same row as "<juror_number>"
	
	When I select "Mark as responded" from Process reply
	And I check the "Mark juror as 'responded'" checkbox
	And I press the "Confirm" button
	Then I see the juror record updated banner containing "Responded"
	
	Then on "JUROR_MOD" . "JUROR" I see "RESPONDED" is "Y" where "JUROR_NUMBER" is "<juror_number>"
	Then on "JUROR_MOD" . "JUROR" I see "H_EMAIL" is "eeeee@mail.com" where "JUROR_NUMBER" is "<juror_number>"
	Then on "JUROR_MOD" . "JUROR" I see "M_PHONE" is "33333333333" where "JUROR_NUMBER" is "<juror_number>"
	Then on "JUROR_MOD" . "JUROR" I see "H_PHONE" is "11111111111" where "JUROR_NUMBER" is "<juror_number>"
	Then on "JUROR_MOD" . "JUROR" I see "W_PHONE" is null where "JUROR_NUMBER" is "<juror_number>"

Examples:
	| juror_number	| last_name			| postcode	| email         	| pool_number	|
	| 045200200		| LNAMESEVENEIGHTSIX| SY2 6LU	| email@outlook.com	| 452300185		|

@Features @NewSchemaConverted
Scenario Outline: English 1st Party Straight Through - regression - contact details populated to Juror

	#moved to Features 02-01-24 return to Regression

	Given I am on "Public" "test"

	Given a bureau owned pool is created with jurors
		| court |juror_number  | pool_number	| att_date_weeks_in_future	| owner |
		| 457   |<juror_number>| <pool_number>	| 5				            | 400	|
		
	And auto straight through processing has been enabled new schema
	
	And juror "<juror_number>" has "LAST_NAME" as "<last_name>" new schema
	And juror "<juror_number>" has "POSTCODE" as "<postcode>" new schema
	
	And I have submitted a first party English straight through response
	| part_no		 	| pool_number	| last_name		| postcode	| email 	|
	| <juror_number>	| <pool_number>	| <last_name>	| <postcode>| <email>	|
	
	Then on "JUROR_MOD" . "JUROR" I see "RESPONDED" is "Y" where "JUROR_NUMBER" is "<juror_number>"
	Then on "JUROR_MOD" . "JUROR" I see "H_EMAIL" is "email@outlook.com" where "JUROR_NUMBER" is "<juror_number>"
	Then on "JUROR_MOD" . "JUROR" I see "M_PHONE" is "07551179225" where "JUROR_NUMBER" is "<juror_number>"
	Then on "JUROR_MOD" . "JUROR" I see "H_PHONE" is null where "JUROR_NUMBER" is "<juror_number>"
	Then on "JUROR_MOD" . "JUROR" I see "W_PHONE" is null where "JUROR_NUMBER" is "<juror_number>"

Examples:
	| juror_number	| last_name			| postcode	| email         	| pool_number	|
	| 045200201		| LNAMESEVENZEROSIX	| NN1 3HQ	| email@outlook.com	| 452300186		|