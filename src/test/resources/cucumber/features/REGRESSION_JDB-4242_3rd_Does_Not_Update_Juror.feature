Feature: Regression JDB-4242 3rd Party Details Do Not Update Legacy Juror

@Regression 
Scenario Outline: English 3rd Party Deceased
	Given I am on "Public" "test"
	Given auto straight through processing has been enabled
	Given the juror numbers have not been processed
		|part_no 	|pool_no 	|owner 	|
		|<part_no> 	|<pool_no>	| 400 	|
	
	And "<part_no>" has "LNAME" as "<last_name>" 
	And "<part_no>" has "RET_DATE" as "5 mondays time"
	And "<part_no>" has "NEXT_DATE" as "5 mondays time"
	And "<part_no>" has "ZIP" as "<postcode>"
	
	And I have submitted a third party English deceased response
	|part_no	|pool_number|last_name		|postcode	|email 	|
	|<part_no>	|<pool_no>	| <last_name>	|<postcode>	|<email>|
	
	Then on "JUROR" . "POOL" I see "RESPONDED" is "Y" where "PART_NO" is "<part_no>"
	Then on "JUROR" . "POOL" I see "H_EMAIL" is null where "PART_NO" is "<part_no>"
	Then on "JUROR" . "POOL" I see "M_PHONE" is null where "PART_NO" is "<part_no>"
	Then on "JUROR" . "POOL" I see "H_PHONE" is null where "PART_NO" is "<part_no>"
	Then on "JUROR" . "POOL" I see "W_PHONE" is null where "PART_NO" is "<part_no>"
	Then on "JUROR" . "POOL" I see "EXC_CODE" is "D" where "PART_NO" is "<part_no>"

Examples:
	|part_no	|last_name			|postcode	|email         	  |pool_no	|
	|641500268	|LNAMETWOSIXEIGHT	|CH1 2AN	|email@outlook.com|415170401|
	
@Features
Scenario Outline: English 3rd Party Excused - contact details same as 3rd party

	#moved to Features 02-01-24 return to Regression

	Given I am on "Public" "test"
	Given the juror numbers have not been processed
		|part_no 	|pool_no 	|owner	|
		|<part_no> 	|<pool_no>	|400 	|
	
	And "<part_no>" has "LNAME" as "<last_name>" 
	And "<part_no>" has "RET_DATE" as "5 mondays time"
	And "<part_no>" has "NEXT_DATE" as "5 mondays time"
	And "<part_no>" has "ZIP" as "<postcode>"
	
	And I have submitted a third party English excusal response
	|part_no	|pool_number|last_name		|postcode	|email 	|
	|<part_no>	|<pool_no>	|<last_name>	|<postcode>	|<email>|
	
	Given I am on "Bureau" "test"
	And I log in as "SYSTEM"
	
	When I click on the "Search" link
	And I set "Juror number" to "<part_no>"
	And I press the "Search" button
	And I click on "<part_no>" in the same row as "<part_no>"
	Then I see "Summoned" on the page
	
	#process in Bureau as Excused
	
	When I select "Excusal" from Process reply
	Then I select "D - DECEASED" from the "Reason for the excusal request" dropdown
	And I set the radio button to "Accept excusal request"
	And I press the "Confirm" button
	Then I see "COMPLETED" on the page
	
	Then on "JUROR" . "POOL" I see "RESPONDED" is "Y" where "PART_NO" is "<part_no>"
	Then on "JUROR" . "POOL" I see "H_EMAIL" is null where "PART_NO" is "<part_no>"
	Then on "JUROR" . "POOL" I see "M_PHONE" is null where "PART_NO" is "<part_no>"
	Then on "JUROR" . "POOL" I see "H_PHONE" is null where "PART_NO" is "<part_no>"
	Then on "JUROR" . "POOL" I see "W_PHONE" is null where "PART_NO" is "<part_no>"

Examples:
	|part_no	|last_name			|postcode	|email         	  |pool_no	|
	|644200433	|LNAMEFOURTHREETHREE|NN1 3HQ	|email@outlook.com|442170401|

@Features
Scenario Outline: English 3rd Party Deferred - contact details same as 3rd party

	#moved to Features 02-01-24 return to Regression

	Given I am on "Public" "test"
	Given the juror numbers have not been processed
		|part_no 	|pool_no 	|owner	|
		|<part_no> 	|<pool_no>	|400 	|

	And "<part_no>" has "LNAME" as "<last_name>"
	And "<part_no>" has "RET_DATE" as "6 mondays time"
	And "<part_no>" has "NEXT_DATE" as "6 mondays time"
	And "<part_no>" has "ZIP" as "<postcode>"

	And I have submitted a third party English deferral response
	|part_no		|pool_number|last_name		|postcode	|email 	|
	|<part_no>		|<pool_no>	|<last_name>	|<postcode>	|<email>|

	Given I am on "Bureau" "test"
	And I log in as "SYSTEM"
	
	When I click on the "Search" link
	And I set "Juror number" to "<part_no>"
	And I press the "Search" button
	And I click on "<part_no>" in the same row as "<part_no>"
	
	When I select "Deferral" from Process reply
	
	And I select "O - OTHER" from the "Reason for the deferral request" dropdown
	And I set the radio button to "Accept deferral"
	And I select deferral date "14" weeks in the future
	
	And I press the "Confirm" button
	Then I see "COMPLETED" on the page
	
	Then on "JUROR" . "POOL" I see "RESPONDED" is "Y" where "PART_NO" is "<part_no>"
	Then on "JUROR" . "POOL" I see "H_EMAIL" is null where "PART_NO" is "<part_no>"
	Then on "JUROR" . "POOL" I see "M_PHONE" is null where "PART_NO" is "<part_no>"
	Then on "JUROR" . "POOL" I see "H_PHONE" is null where "PART_NO" is "<part_no>"
	Then on "JUROR" . "POOL" I see "W_PHONE" is null where "PART_NO" is "<part_no>"

Examples:
	|part_no	|last_name			|postcode	|email         	  |pool_no	|
	|644200674	|LNAMESIXSEVENFOUR	|NN1 3HQ	|email@outlook.com|442170401|

@Features
Scenario Outline: English 3rd Party ST - contact details same as 3rd party

	#moved to Features 02-01-24 return to Regression

	Given I am on "Public" "test"
	Given the juror numbers have not been processed
		|part_no 	|pool_no 	|owner|
		|<part_no> 	|<pool_no>	|400 |
	
	And "<part_no>" has "LNAME" as "<last_name>" 
	And "<part_no>" has "RET_DATE" as "5 mondays time"
	And "<part_no>" has "NEXT_DATE" as "5 mondays time"
	And "<part_no>" has "ZIP" as "<postcode>"
	
	And I have submitted a third party English straight through response
	|part_no		|pool_number|last_name		|postcode	|email |
	|<part_no>		|<pool_no>	| <last_name>	|<postcode>	|<email>|
	
	Given I am on "Bureau" "test"
	And I log in as "SYSTEM"
	
	When I click on the "Search" link
	And I set "Juror number" to "<part_no>"
	And I press the "Search" button
	And I click on "<part_no>" in the same row as "<part_no>"
	
	When I select "Responded" from Process reply
	And I check the "Mark juror as 'responded'" checkbox
	And I press the "Confirm" button
	Then I see "COMPLETED" on the page
	And I see "Responded" on the page
	
	Then on "JUROR" . "POOL" I see "RESPONDED" is "Y" where "PART_NO" is "<part_no>"
	Then on "JUROR" . "POOL" I see "H_EMAIL" is null where "PART_NO" is "<part_no>"
	Then on "JUROR" . "POOL" I see "M_PHONE" is null where "PART_NO" is "<part_no>"
	Then on "JUROR" . "POOL" I see "H_PHONE" is null where "PART_NO" is "<part_no>"
	Then on "JUROR" . "POOL" I see "W_PHONE" is null where "PART_NO" is "<part_no>"

Examples:
	|part_no	|last_name			|postcode	|email         	  |pool_no	|
	|644200674	|LNAMESIXSEVENFOUR	|NN1 3HQ	|email@outlook.com|442170401|
	
@Features
Scenario Outline: English 3rd Party Disqualified - contact details same as 3rd party

	#moved to Features 02-01-24 return to Regression

	Given I am on "Public" "test"
	Given the juror numbers have not been processed
		|part_no 	|pool_no 	|owner	|
		|<part_no> 	|<pool_no>	|400 	|
	
	And "<part_no>" has "LNAME" as "<last_name>" 
	And "<part_no>" has "RET_DATE" as "5 mondays time"
	And "<part_no>" has "NEXT_DATE" as "5 mondays time"
	And "<part_no>" has "ZIP" as "<postcode>"
	
	And I have submitted a third party English ineligibilty response
	|part_no	|pool_number|last_name		|postcode	|email 	|
	|<part_no>	|<pool_no>	|<last_name>	|<postcode>	|<email>|
	
	Given I am on "Bureau" "test"
	And I log in as "SYSTEM"
	
	When I click on the "Search" link
	And I set "Juror number" to "<part_no>"
	And I press the "Search" button
	And I click on "<part_no>" in the same row as "<part_no>"
	
	When I select "Disqualified" from Process reply
	
	#check error message
	
	And I press the "Confirm" button
	And I see "Select the reason that the juror is disqualified" on the page
	
	When I set the radio button to "M - Suffering From a Mental Disorder"
	And I press the "Confirm" button
	Then I see "COMPLETED" on the page
	
	Then on "JUROR" . "POOL" I see "RESPONDED" is "Y" where "PART_NO" is "<part_no>"
	Then on "JUROR" . "POOL" I see "H_EMAIL" is null where "PART_NO" is "<part_no>"
	Then on "JUROR" . "POOL" I see "M_PHONE" is null where "PART_NO" is "<part_no>"
	Then on "JUROR" . "POOL" I see "H_PHONE" is null where "PART_NO" is "<part_no>"
	Then on "JUROR" . "POOL" I see "W_PHONE" is null where "PART_NO" is "<part_no>"

Examples:
	|part_no	|last_name			|postcode	|email         	  |pool_no	|
	|644200449	|LNAMEFOURFOURNINE	|NN1 3HQ	|email@outlook.com|442170401|
	
@Regression 
Scenario Outline: English 3rd Party Super Urgent - contact details same as 3rd party
	Given I am on "Public" "test"
	Given the juror numbers have not been processed
		|part_no 	|pool_no 	|owner	|
		|<part_no> 	|<pool_no>	|400 	|
	
	And "<part_no>" has "LNAME" as "<last_name>" 
	And "<part_no>" has "RET_DATE" as "2 mondays time"
	And "<part_no>" has "NEXT_DATE" as "2 mondays time"
	And "<part_no>" has "ZIP" as "<postcode>"
	And "<part_no>" has "READ_ONLY" as "Y"
	
	And I have submitted a third party English straight through response
	|part_no	|pool_number|last_name		|postcode	|email 	|
	|<part_no>	|<pool_no>	|<last_name>	|<postcode>	|<email>|
	
	Given I am on "Bureau" "test"
	And I log in as "SYSTEM"
	
	When I click on the "Search" link
	And I set "Juror number" to "<part_no>"
	And I press the "Search" button
	And I click on "<part_no>" in the same row as "<part_no>"
	
	Then I press the "Process reply" button
	Then I click on the "PDF sent to court..." link
	When I check the "PDF sent to court" checkbox
	And I press the "Confirm" button
	Then I see "COMPLETED" on the page
	
	Then on "JUROR" . "POOL" I see "H_EMAIL" is null where "PART_NO" is "<part_no>"
	Then on "JUROR" . "POOL" I see "M_PHONE" is null where "PART_NO" is "<part_no>"
	Then on "JUROR" . "POOL" I see "H_PHONE" is null where "PART_NO" is "<part_no>"
	Then on "JUROR" . "POOL" I see "W_PHONE" is null where "PART_NO" is "<part_no>"

Examples:
	|part_no	|last_name			|postcode	|email         	  |pool_no	|
	|644200450	|LNAMEFOURFIVEZERO	|NN1 3HQ	|email@outlook.com|442170401|
	
@Features
Scenario Outline: English 3rd Party Welsh - contact details different for juror

	#moved to Features 02-01-24 return to RegressionWelsh

	Given I am on the welsh version of "Public" "test"
	Given the juror numbers have not been processed
		|part_no 	|pool_no 	|owner	|
		|<part_no> 	|<pool_no>	|400 	|
	
	And "<part_no>" has "LNAME" as "<last_name>" 
	And "<part_no>" has "RET_DATE" as "5 mondays time"
	And "<part_no>" has "NEXT_DATE" as "5 mondays time"
	And "<part_no>" has "ZIP" as "<postcode>"
	
	And I set the radio button to "Rwy'n ymateb ar ran rhywun arall"
	And I press the "Parhau" button	
	
	#Juror Log In
	
	When I click on the "Nid oes gennyf rif rheithiwr ar gyfer yr unigolyn" link
	Then I see "Rhif ffôn: 0300 456 1024" on the page
	And I see "Llinell Gymraeg: 0300 303 5173" on the page
	
	When I set "Rhif rheithiwr" to "<part_no>"
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

	#Residency JDB-3811 and JDB-3910
	
	And I set the radio button to "Do"
	And I press the "Parhau" button

	#CJS no JDB-3822
	
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
	
	#Mental Health Capacity JDB-3813

	And I set the radio button to "Na"
	And I press the "Parhau" button

	#The person can attend
	
	When I set the radio button to "Ydi, mae'r unigolyn yn gallu dechrau"
	
	And  I press the "Parhau" button
	
	#RA no JDB-3815
	
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
	And I log in as "SYSTEM"
	
	When I click on the "Search" link
	And I set "Juror number" to "<part_no>"
	And I press the "Search" button
	And I click on "<part_no>" in the same row as "<part_no>"
	
	When I select "Responded" from Process reply
	And I check the "Mark juror as 'responded'" checkbox
	And I press the "Confirm" button
	Then I see "COMPLETED" on the page
	And I see "Responded" on the page
	
	Then on "JUROR" . "POOL" I see "RESPONDED" is "Y" where "PART_NO" is "<part_no>"
	Then on "JUROR" . "POOL" I see "H_EMAIL" is null where "PART_NO" is "<part_no>"
	Then on "JUROR" . "POOL" I see "M_PHONE" is null where "PART_NO" is "<part_no>"
	Then on "JUROR" . "POOL" I see "H_PHONE" is null where "PART_NO" is "<part_no>"
	Then on "JUROR" . "POOL" I see "W_PHONE" is null where "PART_NO" is "<part_no>"

Examples:
	|part_no	|last_name			|postcode	|email         	  |pool_no	|
	|644200675	|LNAMESIXSEVENFIVE	|NN1 3HQ	|email@outlook.com|442170401|

@Features
Scenario Outline: English 3rd Party Straight Through - Juror already has contact details

	#moved to Features 02-01-24 return to Regression

	Given I am on "Public" "test"
	Given the juror numbers have not been processed
		|part_no 	|pool_no 	|owner	|
		|<part_no> 	|<pool_no>	|400 	|
	
	And "<part_no>" has "LNAME" as "<last_name>" 
	And "<part_no>" has "RET_DATE" as "5 mondays time"
	And "<part_no>" has "NEXT_DATE" as "5 mondays time"
	And "<part_no>" has "ZIP" as "<postcode>"
	And "<part_no>" has "H_EMAIL" as "eeeee@mail.com"
	And "<part_no>" has "H_PHONE" as "11111111111"
	And "<part_no>" has "W_PHONE" as "22222222222"
	And "<part_no>" has "M_PHONE" as "33333333333"
	
	And I have submitted a third party English straight through response
	|part_no	|pool_number|last_name		|postcode	|email 	|
	|<part_no>	|<pool_no>	|<last_name>	|<postcode>	|<email>|
	
	#Bureau process reply
	
	Given I am on "Bureau" "test"
	And I log in as "SYSTEM"
	
	When I click on the "Search" link
	And I set "Juror number" to "<part_no>"
	And I press the "Search" button
	And I click on "<part_no>" in the same row as "<part_no>"
	
	When I select "Responded" from Process reply
	And I check the "Mark juror as 'responded'" checkbox
	And I press the "Confirm" button
	Then I see "COMPLETED" on the page
	And I see "Responded" on the page
	
	Then on "JUROR" . "POOL" I see "RESPONDED" is "Y" where "PART_NO" is "<part_no>"
	Then on "JUROR" . "POOL" I see "H_EMAIL" is "eeeee@mail.com" where "PART_NO" is "<part_no>"
	Then on "JUROR" . "POOL" I see "M_PHONE" is "33333333333" where "PART_NO" is "<part_no>"
	Then on "JUROR" . "POOL" I see "H_PHONE" is "11111111111" where "PART_NO" is "<part_no>"
	Then on "JUROR" . "POOL" I see "W_PHONE" is null where "PART_NO" is "<part_no>"

Examples:
	|part_no	|last_name			|postcode	|email         	  |pool_no	|
	|645200786	|LNAMESEVENEIGHTSIX	|SY2 6LU	|email@outlook.com|452170401|

@Features
Scenario Outline: English 1st Party Straight Through - regression - contact details populated to Juror

	#moved to Features 02-01-24 return to Regression

	Given I am on "Public" "test"
	Given the juror numbers have not been processed
		|part_no 	|pool_no 	|owner	|
		|<part_no> 	|<pool_no>	|400 	|
		
	And auto straight through processing has been enabled
	
	And "<part_no>" has "LNAME" as "<last_name>" 
	And "<part_no>" has "RET_DATE" as "5 mondays time"
	And "<part_no>" has "NEXT_DATE" as "5 mondays time"
	And "<part_no>" has "ZIP" as "<postcode>"
	
	And I have submitted a first party English straight through response
	|part_no		|pool_number|last_name		|postcode	|email 	|
	|<part_no>		|<pool_no>	|<last_name>	|<postcode>	|<email>|
	
	Then on "JUROR" . "POOL" I see "RESPONDED" is "Y" where "PART_NO" is "<part_no>"
	Then on "JUROR" . "POOL" I see "H_EMAIL" is "email@outlook.com" where "PART_NO" is "<part_no>"
	Then on "JUROR" . "POOL" I see "M_PHONE" is "07551179225" where "PART_NO" is "<part_no>"
	Then on "JUROR" . "POOL" I see "H_PHONE" is null where "PART_NO" is "<part_no>"
	Then on "JUROR" . "POOL" I see "W_PHONE" is null where "PART_NO" is "<part_no>"

Examples:
	|part_no	|last_name			|postcode	|email         	  |pool_no	|
	|644200706	|LNAMESEVENZEROSIX	|NN1 3HQ	|email@outlook.com|442170401|