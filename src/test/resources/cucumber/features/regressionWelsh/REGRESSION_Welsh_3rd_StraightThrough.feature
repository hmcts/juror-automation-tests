Feature: Regression Welsh_3rd_StraightThrough

@RegressionWelsh @NewSchemaConverted
Scenario Outline: Welsh 3rd Party Straight Through

	Given I am on the welsh version of "Public" "test"

	Given a bureau owned pool is created with jurors
		| court |juror_number  | pool_number	| att_date_weeks_in_future	| owner |
		| 457   |<juror_number>| <pool_number>	| 3				            | 400	|

	And juror "<juror_number>" has "LAST_NAME" as "<last_name>" new schema
	And juror "<juror_number>" has "POSTCODE" as "<postcode>" new schema

	And I set the radio button to "Rwy'n ymateb ar ran rhywun arall"
	And I press the "Parhau" button	
	
	#Juror Log In
	And I see "steps/login/tp" in the URL
	When I click on the "Nid oes gennyf rif rheithiwr ar gyfer yr unigolyn" link
	Then I see "Rhif ffôn: 0300 456 1024" on the page
	And I see "Llinell Gymraeg: 0300 303 5173" on the page
	
	When I set "Rhif rheithiwr" to "<juror_number>"
	When I set "Cyfenw" to "<last_name>"
	When I set "Cod post Rheithiwr" to "<postcode>"
	And I press the "Parhau" button
    Then I see "Beth yw eich enw?" on the page
	
	#3rd Party Name
	And I see "branches/third-party-details/name" in the URL
	When I see "Eich Manylion" on the page
	When I set "Enw cyntaf" to "FirstNameA"
	And I set "Cyfenw" to "LastNameB"
	And I press the "Parhau" button
	Then I see "Eich perthynas â'r unigolyn" on the page
	
	#Relationship to juror
	And I see "branches/third-party-details/relationship" in the URL
	When I see "Eich Manylion" on the page
	And I set "Sut ydych chi'n adnabod yr unigolyn rydych yn ymateb ar ei ran?" to "Friend"
	And I press the "Parhau" button
	Then I see "Eich manylion cyswllt" on the page
	
	#3rd Party Contact
	And I see "branches/third-party-details/contact" in the URL
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
	And I see "branches/third-party-reason" in the URL
	Then I see "Pam ydych chi'n ymateb ar ran yr unigolyn arall?" on the page
	And I do not see "Pam ydych chi'n ymateb?" on the page
	When I set the radio button to "Nid yw'r unigolyn yma"
	And I see "Efallai ei fod yn teithio, yn yr ysbyty, neu i ffwrdd am fwy nag ychydig ddyddiau am reswm arall." on the page
	And I see "Nid yw'r unigolyn yn gallu ymateb dros ei hun" on the page
	And I see "Nid yw'r unigolyn â'r gallu i ymateb drosto'i hun. Efallai bod hyn oherwydd bod ganddo anabledd neu nam." on the page
	And I press the "Parhau" button
	Then I see "A yw'r enw sydd gennym ar ei gyfer yn gywir?" on the page
	
	#Check juror name
	And I see "branches/third-party-personal-details/name" in the URL
	When I see "Manylion y Rheithiwr" on the page
	And I set the radio button to "Ydy"
	When I press the "Parhau" button
	
	#Check juror address
	And I see "branches/third-party-personal-details/address" in the URL
	And I set the radio button to "Ie"
	When I press the "Parhau" button
	
	#DoB
	And I see "branches/third-party-personal-details/date-of-birth" in the URL
	When I click on the "Cymorth gyda'ch dyddiad geni" link
	Then I see "Os oes arnoch angen cymorth, ffoniwch ni ar:" on the page
	And I see "Rhif ffôn: 0300 456 1024" on the page
	And I see "Llinell Gymraeg: 0300 303 5173" on the page
	
	When I see "Manylion y Rheithiwr" on the page
	And I see "Er enghraifft, 15 03 1982" on the page
	And I set "Diwrnod" to "27"
	And I set "Mis" to "04"
	And I set "Blwyddyn" to "1981"
	And I press the "Parhau" button
	Then I see "Efallai bydd yn rhaid inni gysylltu â'r unigolyn i ofyn rhagor o gwestiynau neu roi rhagor o wybodaeth iddynt am eu gwasanaeth rheithgor" on the page
	
	#Contacting the juror
	And I see "branches/third-party-contact-details" in the URL
	When I see "Manylion y Rheithiwr" on the page
	And I see "Nodwch rifau ffôn y gallwn eu defnyddio i gysylltu â chi rhwng 9am a 5pm, dydd Llun i ddydd Gwener." on the page
	And I set the radio button to "Defnyddio'r rhif ffôn rydych eisoes wedi'i ddarparu i gysylltu â chi"
	
	#Checking field
	And I set the radio button to "Rhoi cyfeiriad e-bost gwahanol ar gyfer y rheithiwr"
	And I see "Nodwch gyfeiriad e-bost" on the page
	
	And I set the radio button to "Defnyddio'r cyfeiriad e-bost rydych eisoes wedi'i ddarparu i gysylltu â chi"
	And I press the "Parhau" button
	
	#Qualify for jury service
	And I see "steps/qualify/tp" in the URL
	Then I see "Cadarnhau a yw'r unigolyn yn gymwys i wasanaethu ar reithgor" on the page
	And I press the "Parhau" button
	
	#Residency
	And I see "steps/qualify/residency/tp" in the URL
	Then I see "A ydynt wedi byw yn y Deyrnas Unedig, Ynysoedd y Sianel neu Ynys Manaw am gyfnod parhaus o bum mlynedd neu fwy ers eu pen-blwydd yn 13 oed?" on the page
	When I click on the "A ydych angen cymorth i ateb hyn?" link
	Then I see "Rhaid i chi gysylltu â ni i gael cyngor ar eu sefyllfa benodol." on the page
	Then I see "Rhif ffôn: 0300 456 1024" on the page
	And I see "Llinell Gymraeg: 0300 303 5173" on the page
	When I click on the "Cliciwch i fynd yn ôl" link
	
	And I press the "Parhau" button
	
	When I set the radio button to "Do"
	And I press the "Parhau" button
	
	#CJS
	And I see "steps/qualify/cjs-employed/tp" in the URL
	Then I see "A yw'r person yr ydych yn ymateb ar ei ran wedi gweithio yn y system cyfiawnder troseddol yn y 5 mlynedd diwethaf?" on the page
	When I set the radio button to "Ydy"
	And I set the radio button to "Nac ydy"
	And I press the "Parhau" button
	
	#Bail
	And I see "steps/qualify/bail/tp" in the URL
	When I see "Cymhwysedd" on the page
	And I set the radio button to "Nac ydy"
	And I press the "Parhau" button
	Then I see "A yw'r unigolyn wedi'i gael yn euog o drosedd?" on the page
	
	#Convictions
	And I see "steps/qualify/convictions/tp" in the URL
	When I see "Cymhwysedd" on the page
	And I click on the "Canllawiau mewn perthynas â gwasanaethu ar reithgor os oes gennych euogfarn" link

	And I see "dedfryd o garchar neu gadw yn y ddalfa am 5 mlynedd neu fwy" on the page
	And I see "dedfryd o garchar ar gyfer diogelu'r cyhoedd neu gadw yn y ddalfa er mwyn diogelu'r cyhoedd" on the page
	And I see "dedfryd o garchar, y ddalfa neu gadw yn y ddalfa am oes" on the page
	And I see "dedfryd estynedig o dan un o adrannau 226A, 226B, 227 neu 228 Deddf Cyfiawnder Troseddol 2003, (gan gynnwys dedfryd o'r fath a osodwyd o" on the page
	And I see "cadw hyd mynno Ei Fawrhydi neu hyd mynno'r Ysgrifennydd Gwladol" on the page
	And I see "Ni allant ychwaith wasanaethu ar reithgor os ydynt wedi cael un o'r dedfrydau troseddol hyn yn ystod y 10 mlynedd diwethaf:" on the page
	And I see "gwnaethant wasanaethu unrhyw ran o ddedfryd o garchar neu gadw yn y ddalfa" on the page
	And I see "cawsant ddedfryd o garchar ohiriedig neu orchymyn atal dros dro ar gyfer cadw yn y ddalfa" on the page
	And I see "Ni allant ychwaith wasanaethu ar reithgor os ydynt, yn ystod y 10 mlynedd diwethaf yng Nghymru a Lloegr, wedi cael gorchymyn cymunedol, gan gynnwys unrhyw un o'r canlynol:" on the page
	Then I see "gorchymyn adsefydlu cymunedol" on the page
	Then I see "gorchymyn cosb gymunedol" on the page
	Then I see "gorchymyn cosb ac adsefydlu cymunedol" on the page
	Then I see "gorchymyn trin a phrofi am gyffuriau" on the page
	Then I see "gorchymyn ymatal rhag cymryd cyffuriau" on the page
	Then I see "Ni allant ychwaith wasanaethu ar reithgor os ydynt, yn ystod y 10 mlynedd diwethaf, wedi cael:" on the page

	When I set the radio button to "Nac ydy"
	And I press the "Parhau" button
	
	#Mental Health Sectioned
	And I see "steps/qualify/mental-health-sectioned/tp" in the URL
	Then I see "A ydi'r person yr ydych yn ymateb ar ei ran yn cael ei gadw, ei warchod neu ei drin o dan y Ddeddf Iechyd Meddwl?" on the page
	When I see "Cymhwysedd" on the page
	And I set the radio button to "Na"
	And I press the "Parhau" button
	Then I see "A wnaed penderfyniad nad oes gan y person yr ydych yn ymateb ar ei ran y 'gallu meddyliol'?" on the page
	
	#Mental Health Capacity
	And I see "steps/qualify/mental-health-capacity/tp" in the URL
	When I see "Cymhwysedd" on the page

	And I set the radio button to "Na"
	And I press the "Parhau" button

	#The person can attend
	And I see "steps/confirm-date/tp" in the URL
	Then I see "Gwiriwch eich dyddiad dechrau" on the page
	When I set the radio button to "Ydi, mae'r unigolyn yn gallu dechrau"
	
	And  I press the "Parhau" button
	
	#RA
	And I see "steps/assistance/tp" in the URL
	Then I see "A fydd yr unigolyn rydych yn ymateb ar ei ran angen cymorth pan fydd yn y llys?" on the page
	When I set the radio button to "Nac oes"
	And I click on the "Pam ein bod yn gofyn am hyn?" link
	And I see "Os ydych yn pryderu am unrhyw beth arall ynghylch y gwasanaeth rheithgor o ran nam neu anabledd sydd gan yr unigolyn rydych yn ymateb ar ei ran, yna cysylltwch â ni." on the page
	And I see "Rhif ffôn: 0300 456 1024" on the page
	And I see "Llinell Gymraeg: 0300 303 5173" on the page
	And I press the "Parhau" button
	Then I see "Gwiriwch eich ymatebion nawr" on the page
	
	#Check your answers
	And I see "steps/confirm-information/tp" in the URL
	And I see "Mi wnaethoch ateb y cwestiynau cymhwysedd ar gyfer yr unigolyn yr ydych yn ymateb ar ei ran" on the page
	When I see "A ydi'r person yr ydych yn ymateb ar ei ran yn cael ei gadw, ei warchod neu ei drin o dan y Ddeddf Iechyd Meddwl?" on the page
	And I see "A wnaed penderfyniad nad oes gan y person yr ydych yn ymateb ar ei ran y 'gallu meddyliol'?" on the page
	And I see "A yw'r unigolyn wedi'i gael yn euog o drosedd?" on the page
	And I see "Rwy'n deall efallai y bydd yr atebion a roddais yn cael eu gwirio a gellir fy erlyn os wyf wedi rhoi unrhyw wybodaeth y gwn ei bod yn anwir yn fwriadol." on the page
	And I see "Efallai y cewch eich euogfarnu ac y cewch ddirwy o hyd at £1000 os byddwch yn rhoi gwybodaeth ffug ar gyfer yr unigolyn a gafodd wŷs i osgoi gwasanaethu ar reithgor. Mae hyn hefyd yn berthnasol os byddwch yn methu â rhoi'r wybodaeth sydd ei hangen arnom i benderfynu a yw'r unigolyn sydd wedi cael gwŷs yn gymwys i wasanaethu ar reithgor." on the page
	And I check the "Hyd gwn i, mae'r wybodaeth rwyf wedi ei rhoi am yr unigolyn rwyf yn ymateb ar ei ran yn gywir." checkbox
	And I press the "Cyflwyno" button
	
	And I see "steps/confirmation/tp" in the URL
	Then I see "Os byddwn yn cysylltu â nhw, efallai bydd angen iddynt ddarparu eu rhif rheithiwr. Mae'r rhif hefyd ar y llythyr bu inni anfon atynt." on the page
	And I see "Lawrlwythwch gopi o'ch ymateb i'r wŷs HTML (15KB)" on the page
	Then I click on the "HTML (15KB)" link
	And I see "Mi wnaethoch ateb y cwestiynau cymhwysedd" on the page
	
Examples:
	| juror_number	| last_name			| postcode	| pool_number	|
	| 045700055		| LNAMETWOSIXZERO	| CH1 2AN	| 457300055		|