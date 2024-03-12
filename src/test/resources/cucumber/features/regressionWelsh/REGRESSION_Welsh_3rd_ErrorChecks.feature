Feature: Regression Welsh_3rd_ErrorChecks

@RegressionWelsh @JDB-3348 @JDB-3525 @JDB-3526 @JDB-3502 @JDB-3524 @JDB-3564 @JDB-3589 @JDB-3588 @JDB-3668 @JDB-3669 @JDB-3670 @JDB-3671 
@JDB-3672 @JDB-3711 @JDB-3715 @JDB-3825 @JDB-3881 
Scenario Outline: Welsh_3rd_ErrorChecks
	Given I am on the welsh version of "Public" "test"
	Given the juror numbers have not been processed
		| part_no 	| pool_no 	| owner |
		| <part_no> |<pool_no>	| 400 	|
	
	And juror "<juror_number>" has "LAST_NAME" as "<last_name>" new schema


	And juror "<juror_number>" has "POSTCODE" as "<postcode>" new schema

	Then I see "A ydych yn ymateb dros eich hun neu ar ran rhywun arall?" on the page
	
	When I press the "Parhau" button
	Then I see "Mae problem" on the page
	And I see "Dewiswch a ydych yn ymateb dros eich hun neu ar ran rhywun arall" on the page
	When I set the radio button to "Rwy'n ymateb ar ran rhywun arall"
	And I press the "Parhau" button
	Then I see "Ei fanylion rheithiwr" on the page

	When I press the "Parhau" button
	Then I see "Nodwch eu rhif rheithiwr 9 digid - gallwch ddod o hyd iddo ar eu llythyr gwŷs rheithgor" on the page
	And I see "Rhaid i chi nodi eu henw olaf yn union fel y mae'n ymddangos ar eu llythyr gwŷs rheithgor, hyd yn oed os yw'n anghywir" on the page
	And I see "Rhaid i chi nodi eu cod post yn union fel y mae'n ymddangos ar eu llythyr gwŷs rheithgor, hyd yn oed os yw'n anghywir" on the page
	
	Then I click on the "Problemau wrth nodi eu manylion?" link
	And I see "Os ydych wedi gwirio eu manylion a’ch bod dal methu parhau, gallwch gysylltu â ni." on the page
	And I see "Swyddfa Ganolog Gwysio Rheithgor" on the page
	And I see "jurysummoning@justice.gov.uk" on the page
	And I see "Rhif ffôn: 0300 456 1024" on the page
	And I see "Llinell Gymraeg: 0300 303 5173" on the page
	And I see "Dydd Llun i Ddydd Iau 9am – 5pm" on the page
	And I see "Dydd Gwener 9am – 3pm" on the page
	And I see "Canfod mwy am gostau galwadau" on the page
	
	#Juror Log In (Find out how to trigger all messages)
	
	When I set "Rhif rheithiwr – 9 digid" to "<juror_number>"
	When I set "Cyfenw'r Rheithiwr" to "<last_name>"
	When I set "Cod post Rheithiwr" to "<postcode>"
	And I press the "Parhau" button
	Then I see "Beth yw eich enw?" on the page
	
	#Third Party Name
	
	When I press the "Parhau" button
	Then I see "Mae problem" on the page
	And I see "Nodwch eich enw cyntaf" on the page
	And I see "Nodwch eich cyfenw" on the page
	When I set "Enw cyntaf" to "FirstName"
	And I set "Cyfenw" to "LastName"
	And I press the "Parhau" button
	Then I see "Eich perthynas â'r unigolyn" on the page
	
	#Third Party Relationship
	
	When I press the "Parhau" button
	Then I see "Mae problem" on the page
	And I see "Nodwch sut ydych chi'n adnabod yr unigolyn sydd wedi cael gwŷs i wasanaethu ar reithgor" on the page
	When I set "Sut ydych chi'n adnabod yr unigolyn rydych yn ymateb ar ei ran?" to "Friend"
	And I press the "Parhau" button
	Then I see "Eich manylion cyswllt" on the page
	
	#3rd Party Contact
	
	When I press the "Parhau" button
	Then I see "Mae problem" on the page
	And I see "Dewiswch sut yr hoffech i ni gysylltu â chi" on the page
	
	When I check the "Dros y ffôn (rhifau yn y DU yn unig)" checkbox
	And I check the "Trwy e-bost" checkbox
	And I press the "Parhau" button
	Then I see "Mae problem" on the page
	And I see "Nodwch eich prif rif ffôn" on the page
	And I see "Nodwch eich cyfeiriad e-bost" on the page
	And I see "Nodwch eich cyfeiriad e-bost a gwiriwch ei fod yr un fath â'r un rydych eisoes wedi'i roi" on the page
	
	When I set "Prif rif ffôn" to "02078211818"
	And I set "Nodwch gyfeiriad e-bost" to "email@outlook.com"
	And I set "Nodwch gyfeiriad e-bost eto" to "Mismatched@outlook.com"
	And I press the "Parhau" button
	Then I see "Mae problem" on the page
	And I see "Nodwch eich cyfeiriad e-bost a gwiriwch ei fod yr un fath â'r un rydych eisoes wedi'i roi" on the page
	
	When I set "Nodwch gyfeiriad e-bost" to "email@outlook.com"
	And I set "Nodwch gyfeiriad e-bost eto" to "email@outlook.com"
	And I press the "Parhau" button
	Then I see "Pam ydych chi'n ymateb ar ran yr unigolyn arall?" on the page
	
	#Why Replying
	
	When I press the "Parhau" button
	Then I see "Mae problem" on the page
	And I see "Dywedwch wrthym pam ydych chi'n ymateb ar ran yr unigolyn a enwir ar y wŷs rheithgor" on the page
	
	When I set the radio button to "Arall"
	And I press the "Parhau" button
	Then I see "Mae problem" on the page
	
	And I see "Rhowch fanylion" on the page
	
	When I set the radio button to "Nid yw'r unigolyn yma"
	And I press the "Parhau" button
	Then I see "A yw'r enw sydd gennym ar ei gyfer yn gywir?" on the page
	
	#Check Juror Name
	#JDB-4281
	#JDB-4125

	When I set the radio button to "Na"
	And I press the "Parhau" button
	And I set "Enw cyntaf" to ""
	And I set "Cyfenw" to ""
	And I press the "Parhau" button
	Then I see "Mae problem" on the page
	And I see "Nodwch enw cyntaf yr unigolyn" on the page
	And I see "Nodwch gyfenw'r unigolyn" on the page

	When I set "Enw cyntaf" to "JurorFirstName"
	And I set "Cyfenw" to "JurorLastName"
	And I press the "Parhau" button
	Then I see "Ei gyfeiriad ef yw hwn?" on the page
	And I click on the "A fydd ei gyfeiriad yn newid yn fuan?" link
	And I see "Os bydd ei gyfeiriad yn newid yn fuan, nodwch ei gyfeiriad presennol, er mwyn i ni allu cysylltu ag ef." on the page
	And I see "Os ydyw yn symud o'r ardal lle mae'n byw ar hyn o bryd, mae'n bosibl y byddwn yn newid lleoliad ei wasanaeth rheithgor." on the page
	
	#Check address JDB-3526
	
	When I set the radio button to "Na"
	And I press the "Parhau" button
	And I set "Cod post" to ""
	And I set "Tref neu ddinas" to ""
	And I press the "Parhau" button
	Then I see "Mae problem" on the page
	And I see "Nodwch y dref neu'r ddinas" on the page
	And I see "Nodwch y cod post" on the page
	
	#Checking Invalids check with Jorge
	
	And I set input field with "id" of "addressTown" to "|||"
#	And I set "Tref neu ddinas" to "|||"

	And I set input field with "id" of "addressCounty" to "|||"
#	And I set "Sir (dewisol)" to "|||"

	And I set input field with "id" of "addressPostcode" to "|||"
#	And I set "Cod post" to "|||"

	And I press the "Parhau" button
	Then I see "Mae problem" on the page
	And I see "Gwiriwch y dref neu'r ddinas" on the page
	And I see "Gwiriwch y sir" on the page
	And I see "Gwiriwch y cod post" on the page
	And I set "Tref neu ddinas" to "London"
	And I set "Sir (dewisol)" to ""
	And I set "Cod post" to "CH1 2AN"
	And I press the "Parhau" button
	Then I see "Nodwch ddyddiad geni'r unigolyn rydych chi'n ymateb ar ei ran" on the page
	
	#Juror DoB
	
	When I press the "Parhau" button
	Then I see "Mae problem" on the page
	And I see "Nodwch y diwrnod gafodd yr unigolyn ei eni" on the page

	And I set input field with "id" of "dobDay" to "27"
#	When I set "Diwrnod" to "27"

	And I set input field with "id" of "dobMonth" to "04"
#	And I set "Mis" to "04"

	And I set input field with "id" of "dobYear" to "198a"
#	And I set "Blwyddyn" to "198a"

	And I press the "Parhau" button
	Then I see "Mae problem" on the page
	And I see "Rhowch y flwyddyn y ganwyd yr unigolyn fel rhif 4 digid. Er enghraifft, 1982" on the page
	
	And I set input field with "id" of "dobDay" to "27"
#	When I set "Diwrnod" to "27"

	And I set input field with "id" of "dobMonth" to "04"
#	And I set "Mis" to "04"

	And I set input field with "id" of "dobYear" to "1981"
#	And I set "Blwyddyn" to "1981"
	And I press the "Parhau" button
	Then I see "Efallai bydd yn rhaid inni gysylltu â'r unigolyn i ofyn rhagor o gwestiynau neu roi rhagor o wybodaeth iddynt am eu gwasanaeth rheithgor" on the page
	
	#Contacting the Juror
	
	When I press the "Parhau" button
	Then I see "Mae problem" on the page
	And I see "Dewiswch rif ffôn cyswllt i ni ei ddefnyddio i gysylltu â chi neu'r rheithiwr" on the page
	And I see "Dewiswch gyfeiriad e-bost i ni ei ddefnyddio i gysylltu â chi neu’r rheithiwr" on the page
		
	When I set the radio button to "Rhoi rhif ffôn gwahanol ar gyfer y rheithiwr"
	And I set the radio button to "Rhoi cyfeiriad e-bost gwahanol ar gyfer y rheithiwr"
	And I press the "Parhau" button
	Then I see "Mae problem" on the page
	
	And I see "Nodwch y prif rif ffôn" on the page
	And I see "Nodwch gyfeiriad e-bost cyswllt" on the page

	When I set "Prif rif ffôn" to "|||"
	And I set "Rhif ffôn arall (dewisol)" to "|||"
	And I set "Nodwch y cyfeiriad e-bost" to "|||"
	And I set "Nodwch y cyfeiriad e-bost unwaith eto" to "|||"
	And I press the "Parhau" button
	Then I see "Gwiriwch y prif rif ffôn" on the page
	And I see "Gwiriwch y rhif ffôn arall" on the page
	And I see "Gwiriwch y cyfeiriad e-bost" on the page
	
	When I set "Prif rif ffôn" to "02078211818"
	And I set "Nodwch y cyfeiriad e-bost" to "email@outlook.com"
	And I set "Nodwch y cyfeiriad e-bost unwaith eto" to "mismatch@outlook.com"
	And I press the "Parhau" button
	Then I see "Gwiriwch y rhif ffôn arall" on the page
	Then I see "Nodwch gyfeiriad e-bost a gwiriwch eich fod yr un fath â beth sydd yn y blwch cyntaf" on the page
	
	When I set the radio button to "Defnyddio'r rhif ffôn rydych eisoes wedi'i ddarparu i gysylltu â chi"
	And I set the radio button to "Defnyddio'r cyfeiriad e-bost rydych eisoes wedi'i ddarparu i gysylltu â chi"
	And I press the "Parhau" button
	
	#Eligibility
	
	Then I see "Cadarnhau a yw'r unigolyn yn gymwys i wasanaethu ar reithgor" on the page
	When I press the "Parhau" button
	
	#Residency Yes
	
	Then I see "Ers iddynt droi'n 13 oed, a yw eu prif gyfeiriad wedi bod yn y DU, Ynysoedd y Sianel neu Ynys Manaw am unrhyw gyfnod o 5 mlynedd o leiaf?" on the page
	When I press the "Parhau" button
	Then I see "Mae problem" on the page
	And I see "Dewiswch ydy os yw eu prif gyfeiriad wedi bod yn y DU, Ynysoedd y Sianel neu Ynys Manaw am unrhyw gyfnod o 5 mlynedd o leiaf, ers iddynt droi'n 13 oed" on the page
	When I set the radio button to "Naddo"
	And I press the "Parhau" button
	Then I see "Mae problem" on the page
	And I see "Rhowch fanylion am ble mae'r unigolyn rydych yn ymateb ar ei ran wedi byw ers ei ben-blwydd/ei phen-blwydd yn 13 mlwydd oed" on the page
	
	When I set the radio button to "Do"
	And I press the "Parhau" button
	
	#CJS no
	
	Then I see "A yw'r person yr ydych yn ymateb ar ei ran wedi gweithio yn y system cyfiawnder troseddol yn y 5 mlynedd diwethaf?" on the page
	When I press the "Parhau" button
	Then I see "Mae problem" on the page
	And I see "Dewiswch a yw'r unigolyn rydych yn ateb ar ei ran wedi gweithio yn y system cyfiawnder drosoeddol yn ystod y 5 mlynedd diwethaf" on the page
	
	When I set the radio button to "Ydy"
	And I press the "Parhau" button
	
	#JDB-3525 AND JDB-3881 test, should NOT allow to progress straight to RA
	
	Then I see "Ticiwch unrhyw sefydliadau mae'r unigolyn wedi gweithio iddynt yn uniongyrchol (nid fel trydydd parti neu is-gontractwr)" on the page
	
	When I check the "Yr heddlu" checkbox
	And I check the "Gwasanaeth Carchardai EM" checkbox
	And I check the "Arall" checkbox
	And I press the "Parhau" button
	Then I see "Rhowch fanylion am ble a phryd roedd yr unigolyn yn gweithio i'r Heddlu" on the page
	Then I see "Rhowch fanylion am pryd a lle maent wedi gweithio mewn rhan arall o'r system cyfiawnder troseddol" on the page
	And I see "Rhowch fanylion am pryd a lle maent wedi gweithio mewn rhan arall o'r system cyfiawnder troseddol" on the page
	
	And I uncheck the "Arall" checkbox
	And I uncheck the "Yr heddlu" checkbox
	And I uncheck the "Gwasanaeth Carchardai EM" checkbox
	When I set the radio button to "Nac ydy"
	And I press the "Parhau" button
	
	#Bail no

	Then I see "A yw'r unigolyn ar fechnïaeth ar hyn o bryd am gyflawni trosedd?" on the page
	When I press the "Parhau" button
	Then I see "Mae problem" on the page
	And I see "Dewiswch 'Ydy' os yw'r unigolyn ar fechnïaeth am gyflawni trosedd" on the page
	
	When I set the radio button to "Ydy"
	And I press the "Parhau" button
	Then I see "Mae problem" on the page
	Then I see "Rhowch fanylion am fechnïaeth a throsedd yr unigolyn" on the page
	
	When I set the radio button to "Nac yd"
	And I press the "Parhau" button
	
	#Convictions no
	
	Then I see "A yw'r unigolyn wedi'i gael yn euog o drosedd?" on the page
	When I press the "Parhau" button
	Then I see "Mae problem" on the page
	And I see "Dewiswch 'Ydy' os yw'r unigolyn wedi'i gael yn euog o gyflawni trosedd" on the page
	
	When I set the radio button to "Ydy"
	And I press the "Parhau" button
	Then I see "Mae problem" on the page
	And I see "Rhowch fanylion am drosedd yr unigolyn" on the page
	
	When I set the radio button to "Nac ydy"
	And I press the "Parhau" button
	
	#Mental health part 1 no
	
	Then I see "A ydi'r person yr ydych yn ymateb ar ei ran yn cael ei gadw, ei warchod neu ei drin o dan y Ddeddf Iechyd Meddwl?" on the page
	When I press the "Parhau" button
	Then I see "Mae problem" on the page
	And I see "Dewiswch 'ie' os yw'r person yr ydych yn ymateb ar ei ran yn cael ei gadw, ei warchod neu ei drin o dan y Ddeddf Iechyd Meddwl" on the page
	
	When I set the radio button to "Ie"
	And I press the "Parhau" button
	Then I see "Mae problem" on the page
	And I see "Eglurwch sut y maent yn cael eu cadw dan glo, sut ofal maent yn ei gael neu sut maent yn cael eu trin o dan y Ddeddf Iechyd Meddwl" on the page
	
	When I set the radio button to "Na"
	And I press the "Parhau" button
	
	#Mental health part 2 no
	
	Then I see "A wnaed penderfyniad nad oes gan y person yr ydych yn ymateb ar ei ran y 'gallu meddyliol'?" on the page
	When I press the "Parhau" button
	Then I see "Mae problem" on the page
	And I see "Dewiswch ie os penderfynwyd nad oes gan y person yr ydych yn eiriol drosto y 'gallu meddyliol'" on the page
	
	When I set the radio button to "Ie"
	And I press the "Parhau" button
	Then I see "Mae problem" on the page
	And I see error "Eglurwch yn gryno pam y penderfynwyd nad oes ganddynt alluedd meddyliol"
	
	When I set the radio button to "Na"
	And I press the "Parhau" button
	
	#I can attend
	
	Then I see "Gwiriwch eich dyddiad dechrau" on the page
	When I press the "Parhau" button
	Then I see "Mae problem" on the page
	And I see "Gwiriwch eich dyddiad dechrau" on the page
	
	When I set the radio button to "Ydi, mae'r unigolyn yn gallu dechrau ar"
	And  I press the "Parhau" button
	
	#RA no
	
	Then I see "A fydd yr unigolyn rydych yn ymateb ar ei ran angen cymorth pan fydd yn y llys?" on the page
	When I press the "Parhau" button
	Then I see "Mae problem" on the page

	And I see "Dewiswch 'Oes' os bydd yr unigolyn rydych yn ymateb ar ei ran angen cymorth pan fydd yn y llys" on the page
	
	When I set the radio button to "Oes"
	And I press the "Parhau" button
	Then I see "Mae problem" on the page
	And I see "Dewiswch os oes ganddynt symudedd cyfyngedig, nam ar y clyw, clefyd siwgr, nam difrifol ar eu golwg neu anabledd neu nam o fath arall" on the page
	
	When I check the "Arall" checkbox
	And I press the "Parhau" button
	Then I see "Mae problem" on the page
	And I see "Rhowch fanylion os gwelwch yn dda" on the page
	
	When I set the radio button to "Nac oes"
	And I press the "Parhau" button
	Then I see "Gwiriwch eich ymatebion nawr" on the page
	
	#Check Your Answers
	
	When I press the "Cyflwyno" button
	Then I see "Mae problem" on the page
	Then I see "Cadarnhewch fod eich gwybodaeth yn gywir cyn ichi anfon eich ymateb" on the page
	
	When I click on the "Newid" link in the same row as "Cadarnhewch ddyddiad ei wasanaeth rheithgor"
	Then I see "Gwiriwch eich dyddiad dechrau" on the page
	When I set the radio button to "Nac ydi, rhaid newid y dyddiad"
	And I press the "Parhau" button
	Then I see "Dywedwch wrthym pam fod angen dyddiad arall arnynt ar gyfer y gwasanaeth rheithgor" on the page
	
	#Deferral Reason
	
	When I press the "Parhau" button
	Then I see "Mae problem" on the page
	And I see "Nodwch eu rheswm dros fod angen dyddiad arall ar gyfer eu gwasanaeth rheithgor" on the page
	
	When I set text area with "id" of "deferralReason" to "Defer them please"
	And I press the "Parhau" button
	Then I see "Dewiswch 3 dydd Llun pan allant ddechrau gwasanaeth rheithgor" on the page
	
	#Deferral Dates JDB-3524
	
	When I press the "Parhau" button
	Then I see "Mae problem" on the page
	And I see "Rhowch y dydd Llun cyntaf y byddai'n well ganddynt ddechrau gwasanaeth rheithgor" on the page
	And I see "Rhowch yr ail ddydd Llun y byddai'n well ganddynt ddechrau gwasanaeth rheithgor" on the page
	And I see "Rhowch y trydydd dydd Llun y byddai'n well ganddynt ddechrau gwasanaeth rheithgor" on the page
	
	When I set the "First" single date field to a Monday "6" weeks in the future
	When I set the "Second" single date field to a Monday "10" weeks in the future
	When I set the "Third" single date field to a Monday "10" weeks in the future
	And I press the "Parhau" button
	Then I see "Mae problem" on the page
	And I see "Rhowch ddyddiad sy'n wahanol i'r dewisiadau eraill" on the page
	
	When I set the "First" single date field to a Monday "100" weeks in the future
	When I set the "Second" single date field to a Monday "101" weeks in the future
	When I set the "Third" single date field to a Monday "102" weeks in the future
	And I press the "Parhau" button
	Then I see "Mae problem" on the page

	And I see "Rhaid i'w dewis cyntaf fod yn ddydd Llun rhwng" on the page
	And I see "Rhaid i'w hail ddewis fod yn ddydd Llun rhwng" on the page
	And I see "Rhaid i'w trydydd dewis fod yn ddydd Llun rhwng" on the page
	
	When I set the "First" single date field to a Monday "12" weeks in the future
	When I set the "Second" single date field to a Monday "13" weeks in the future
	When I set the "Third" single date field to a Monday "14" weeks in the future
	And I press the "Parhau" button
	
	And on the page I see
	|text|
	|Gwirio dyddiadau| 
	|Dyddiadau y gallant ddechrau gwasanaeth rheithgor|
	|Nid oes angen i chi ddweud wrthym yr holl ddyddiadau eraill y maent ar gael.|
	|Byddwn yn dewis un o'r 3 dyddiad hyn.|
	|Ydych chi am fwrw ymlaen â'r dyddiadau hyn?|
	
	When I set the radio button to "Ydw"
	And I press the "Parhau" button
	
	#Check Your Answers
	
	Then I see "Gwiriwch eich ymatebion nawr" on the page
	
	When I click on the "Newid" link in the same row as "Cadarnhewch ddyddiad ei wasanaeth rheithgor"
	Then I see "Gwiriwch eich dyddiad dechrau" on the page
	
	When I set the radio button to "Nac ydi, ni all yr unigolyn wasanaethu ar reithgor a rhaid esgusodi"
	And I press the "Parhau" button
	Then I see "Pam fod angen iddo gael ei esgusodi rhag gwasanaethu ar reithgor?" on the page
	
	#Excusal Reason
	
	When I press the "Parhau" button
	Then I see "Mae problem" on the page
	And I see "Rhowch y rheswm pam na all wasanaethu ar reithgor yn ystod y 12 mis nesaf" on the page
	
	When I set text area with "id" of "excusalReason" to "Excuse them please"
	And I press the "Parhau" button
	Then I see "Gwiriwch eich ymatebion nawr" on the page
	
	#When I press the "Submit" button
	
	When I check the "Hyd gwn i, mae'r wybodaeth rwyf wedi ei rhoi am yr unigolyn rwyf yn ymateb ar ei ran yn gywir." checkbox
	And I press the "Cyflwyno" button
	Then I see "Rydym wedi anfon e-bost i ddweud eich bod wedi ymateb i'r wŷs hon." on the page
	
Examples:
	|part_no		|last_name	|postcode	|pool_no	|
	|641500795		|DOE		|SW1H 9AJ	|415170401	|