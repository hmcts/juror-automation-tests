Feature: Regression Welsh Cookie Policy

@RegressionWelsh @NewSchemaConverted
Scenario Outline: Welsh Cookie Policy

	Given I am on the welsh version of "Public" "test"

	Given a bureau owned pool is created with jurors
		| court | juror_number  	| pool_number	| att_date_weeks_in_future	| owner |
		| 457   | <juror_number>	| <pool_number>	| 5				            | 400	|
		
	And juror "<juror_number>" has "LAST_NAME" as "<last_name>" new schema
	And juror "<juror_number>" has "POSTCODE" as "<postcode>" new schema
	
	#Cookies Policy
	And I click on the "Cwcis" link
	
	#Opens new tab
	And on the page I see
	|text|
	|Cwcis|
	|Ffeiliau bach sy'n cael eu cadw ar eich ffôn, tabled neu gyfrifiadur pan fyddwch yn ymweld â gwefan yw cwcis.|
	|Rydym yn defnyddio cwcis i wneud i'r gwasanaeth 'Ymateb i wŷs rheithgor' weithio ac i gasglu gwybodaeth am sut rydych chi'n defnyddio ein gwasanaeth.|
	|Cwcis hanfodol|
	|Mae cwcis hanfodol yn cadw'ch gwybodaeth yn ddiogel wrth i chi ddefnyddio'r gwasanaeth 'Ymateb i wŷs rheithgor'. Nid oes rhaid inni ofyn am ganiatâd i'w defnyddio.|
	|Cwcis dadansoddol (dewisol)|
	|Gyda'ch caniatâd chi, rydym yn defnyddio cwcis Google Analytics i gasglu data am sut rydych chi'n defnyddio'r gwasanaeth hwn ac maent yn ein helpu i'w wella.|
    |Mae Google Analytics yn storio gwybodaeth ddienw am:|
    |sut y daethoch o hyd i'r gwasanaeth|
    |y tudalennau rydych chi'n ymweld â nhw ar y gwasanaeth hwn a pha mor hir rydych chi'n ei dreulio arnyn nhw|
    |unrhyw wallau a welwch wrth ddefnyddio'r gwasanaeth hwn|
    |Nid yw'n casglu gwybodaeth am eich enw na lle'r ydych chi'n byw.|
    |Rydym hefyd yn defnyddio cwcis Dynatrace i fesur pa mor dda y mae'r gwasanaeth hwn yn perfformio gyda defnyddwyr a thracio gwallau.|
    |Nid ydym yn caniatáu i Google na Dynatrace ddefnyddio neu rannu ein data dadansoddol gydag unrhyw un.|
    
    And the radio button "Oes" is "selected"
    And the radio button "Nac oes" is "unselected"
    
Examples:
	| juror_number	| last_name	| postcode	| pool_number	|
	| 045700076		| LastNameB	| SW1H 9AJ	| 457300076		|


@RegressionWelsh
Scenario Outline: Welsh 1st Party Cookies Policy on each Page
	Given I am on the welsh version of "Public" "test"

	Given a bureau owned pool is created with jurors
		| court | juror_number  	    | pool_number	    | att_date_weeks_in_future	| owner |
		| 415   | <juror_number> 	    | <pool_number>     | 5				            | 400	|

	And juror "<juror_number>" has "POSTCODE" as "<postcode>" new schema

	And I set the radio button to "n ymateb dros fy hun"
	And I see link with text "Cwcis" 
	And I press the "Parhau" button
	
	Then I see "Eich manylion rheithiwr" on the page
	When I click on the "Nid oes gennyf rif rheithiwr" link
	Then I see "Gallwch ddod o hyd i'ch rhif rheithiwr ar eich llythyr gwŷs rheithgor." on the page
	
	And I see "Rhif ffôn: 0300 456 1024" on the page
	And I see "Llinell Gymraeg: 0300 303 5173" on the page
	
	And I see "Rhowch eich enw olaf fel y mae wedi'i nodi ar y llythyr gwŷs rheithgor, hyd yn oed os yw'n anghywir. Gallwch ei newid nes ymlaen." on the page
	
	And I see "Rhowch eich cod post fel y mae wedi'i nodi ar y llythyr gwŷs rheithgor, hyd yn oed os yw'n anghywir. Gallwch ei newid nes ymlaen." on the page
	
	When I set "Rhif rheithiwr" to "<juror_number>"
	When I set "Cyfenw" to "<last_name>"
	When I set "Cod post Rheithiwr" to "<postcode>"
	And I see link with text "Cwcis" 
	And I press the "Parhau" button
	
	And I set the radio button to "Nac ydy"
	And I see link with text "Cwcis" 
	And I press the "Parhau" button
	
	Then I set "Enw cyntaf" to "FirstNameA"
	And I set "Cyfenw" to "LastNameB"
	And I click on the "Beth sy'n digwydd os rwyf wedi newid fy enw?" link
	And I see "Os yw eich enw chi wedi newid, byddwn yn cysylltu â chi i wirio hynny. Efallai y byddwn yn gofyn am dystysgrif briodas, tystysgrif partneriaeth sifil neu weithred newid enw." on the page
	And I see link with text "Cwcis" 
	And I press the "Parhau" button

	Then on the page I see
		| text	|
		| Eich Manylion |
		| Eich cyfeiriad chi yw hwn? |
		
	And I set the radio button to "Ie"
	And I do not see "Gwiriwch fod eich enw a'r cyfeiriad yn gywir" on the page	
	And I see link with text "Cwcis" 
	When I press the "Parhau" button
	
	Then on the page I see
		| text	|
		| Eich Manylion |
		| Beth yw eich rhif ffôn? |
		| Darparwch rif ffôn yn y DU y gallwn ei ddefnyddio i gysylltu â chi rhwng 9am a 5pm, dydd Llun i ddydd Gwener. |
		| Prif rif ffôn |
		| Rhif ffôn arall (dewisol) |
	
	When I set "Prif rif ffôn" to "0207 821 1818"
	And I see link with text "Cwcis" 
	And I press the "Parhau" button
	
	Then on the page I see
		| text|
		| Eich Manylion |
		| Beth yw eich cyfeiriad e-bost? |
		| Pam fod arnom angen eich cyfeiriad e-bost? |
	
	When I see "Pam fod arnom angen eich cyfeiriad e-bost?" on the page
	And I set "Nodwch eich cyfeiriad e-bost" to "<email>"
	And I set "Nodwch eich cyfeiriad e-bost eto" to "<email>"
	And I see link with text "Cwcis" 
	And I press the "Parhau" button

	Then on the page I see
		| text	|
		| Eich Manylion	|
		| Beth yw eich dyddiad geni? |
		| Cymorth gyda'ch dyddiad geni |
		| Er enghraifft, 15 03 1982 |
	
	When I click on the "Cymorth gyda'ch dyddiad geni" link
	Then I see "Mae angen i chi ddweud wrthym beth yw eich dyddiad geni er mwyn i ni wirio os ydych o'r oedran priodol i wasanaethu ar reithgor." on the page
	And I do not see "Nodwch ddyddiad geni'r unigolyn er mwyn i ni wirioos ydynt o'r oedran priodol i wasanaethu ar reithgor." on the page
	
	Then I see "Ffoniwch ni ar:" on the page
	And I see "Rhif ffôn: 0300 456 1024" on the page
	And I see "Llinell Gymraeg: 0300 303 5173" on the page
	And I see "os oes arnoch angen cyngor am hyn." on the page
	
	When I set "Diwrnod" to "27"
	And I set "Mis" to "04"
	And I set "Blwyddyn" to "1978"
	And I see link with text "Cwcis" 
	And I press the "Parhau" button
	
	Then I see "Cadarnhau a ydych yn gymwys i wasanaethu ar reithgor" on the page
	And I see link with text "Cwcis" 
	
	When I press the "Parhau" button
	
	#Residency JDB-3909
	
	Then I see "Ers i chi droi'n 13 oed, a yw eich prif gyfeiriad wedi bod yn y DU, Ynysoedd y Sianel neu Ynys Manaw am unrhyw gyfnod o 5 mlynedd o leiaf?" on the page
	When I click on the "A ydych angen cymorth i ateb hyn?" link
	Then I see "Rhaid i chi gysylltu â ni i gael cyngor ar eich sefyllfa benodol." on the page
	And I see "Rhif ffôn: 0300 456 1024" on the page
	And I see "Llinell Gymraeg: 0300 303 5173" on the page
	
	And I see "Cymhwysedd" on the page
	And I set the radio button to "Naddo"
	And I set the radio button to "Do"
	And I see link with text "Cwcis" 
	
	And I press the "Parhau" button
	
	#CJS JDB-3873
	
	Then I see "A ydych chi wedi gweithio yn y system cyfiawnder troseddol yn y 5 mlynedd diwethaf?" on the page
	And I do not see any links on the page that open to a new page without an alt text
	When I set the radio button to "Nac ydw"
	And I see link with text "Cwcis" 
	And I press the "Parhau" button
	
	#Bail
	
	Then I see "Ydych chi ar fechnïaeth ar hyn o bryd am gyflawni trosedd?" on the page
	When I see "Cymhwysedd" on the page
	And I set the radio button to "Nac ydw"
	And I see link with text "Cwcis" 
	And I press the "Parhau" button
	
	#Convictions JDB-3814
	
	Then I see "Ydych chi wedi'ch cael yn euog o drosedd?" on the page
	When I see "Cymhwysedd" on the page
	And I see "Dim ond os cawsoch ddedfryd o garchar, gorchymyn cymunedol neu ddedfryd o garchar ohiriedig y mae hyn yn berthnasol." on the page
	When I click on the "Canllawiau mewn perthynas â gwasanaethu ar reithgor os oes gennych euogfarn" link
	And I see "dedfryd o garchar neu gadw yn y ddalfa am 5 mlynedd neu fwy" on the page
	
	#JDB-4552
	
	And I see "dedfryd o garchar neu gadw yn y ddalfa am 5 mlynedd neu fwy" on the page
	And I see "dedfryd o garchar ar gyfer diogelu'r cyhoedd neu gadw yn y ddalfa er mwyn diogelu'r cyhoedd" on the page
	And I see "dedfryd o garchar, y ddalfa neu gadw yn y ddalfa am oes" on the page
	And I see "dedfryd estynedig o dan un o adrannau 226A, 226B, 227 neu 228 Deddf Cyfiawnder Troseddol 2003, (gan gynnwys dedfryd o'r fath a osodwyd o ganlyniad i adran 219A, 220, 221A neu 222 Deddf y Lluoedd Arfog 2006) neu adran 210A Deddf Gweithdrefn Droseddol (Yr Alban) 1995" on the page
	And I see "cadw hyd mynno Ei Fawrhydi neu hyd mynno'r Ysgrifennydd Gwladol" on the page
	And I see "Ni allwch ychwaith wasanaethu ar reithgor os ydych wedi cael un o'r dedfrydau troseddol hyn yn ystod y 10 mlynedd diwethaf:" on the page
	And I do not see "carchar er mwyn diogelu’n cyhoedd neu gael eich cadw’n gaethiwed er mwyn diogelu’r cyhoedd" on the page
	When I set the radio button to "Naddo"
	And I see link with text "Cwcis" 
	And I press the "Parhau" button
	
	#Mental Health Sectioned
	
	Then I see "Ydych chi'n cael eich cadw, yn cael eich gwarchod neu eich trin o dan y Ddeddf Galluedd Meddyliol?" on the page
	When I see "Cymhwysedd" on the page
	And I set the radio button to "Na"
	And I see link with text "Cwcis" 
	And I press the "Parhau" button
	
	#Mental Health Capacity JDB-3812 and JDB-3813 JDB-3880 JDB-4552
	
	Then I see "A benderfynwyd nad oes gennych y gallu meddyliol?" on the page
	When I see "Cymhwysedd" on the page
	And I click on the "Angen help i ateb hwn?" link
	And I see "Os nad oes y gallu meddyliol gan rywun, dydyn nhw ddim yn gallu:" on the page
	And I see "gwneud eu penderfyniadau eu hunain" on the page
	And I see "deall a chadw gwybodaeth" on the page
	And I see "cyfathrebu meddyliau a phenderfyniadau i bobl eraill" on the page
	And I see "Ardystiwyd rhai pobl yn feddygol o dan Ddeddf Galluedd Meddyliol 1983 nad oes ganddynt y gallu meddyliol oherwydd damwain neu anaf." on the page
	And I see "Efallai bod yn rhaid penodi rhywun arall i wneud penderfyniadau ar eu rhan." on the page
	And I see "Os nad oes gan rywun y gallu meddyliol, ni allant wasanaethu ar reithgor." on the page
	
	And I see "Ie" on the page
	And I see "Na" on the page
	And I set the radio button to "Ie"
	And I set "Eglurwch yn gryno pam y penderfynwyd nad oes gennych alluedd meddyliol" to "Reasons for capacity"
	And I see link with text "Cwcis" 
	And I press the "Parhau" button
	
	#Confirm attendance	

	When I set the radio button to "Nac ydw, hoffwn newid y dyddiad"
	And I press the "Parhau" button
	And I do not see any links on the page that open to a new page without an alt text

	And I see link with text "Cwcis" 
	Then I see "Dywedwch wrthym pam fod angen dyddiad arall arnoch i wneud eich gwasanaeth rheithgor" on the page
	And I do not see any links on the page that open to a new page without an alt text
	
	When I set text area with "id" of "deferralReason" to "askForAnotherDateReasonWhy"
	And I press the "Parhau" button
	And I do not see any links on the page that open to a new page without an alt text

    And I see link with text "Cwcis" 

	When I set the "First" single date field to a Monday "6" weeks in the future
	When I set the "Second" single date field to a Monday "7" weeks in the future
	When I set the "Third" single date field to a Monday "8" weeks in the future
	And I press the "Parhau" button
	
	And I set the radio button to "Ydw"
	And I press the "Parhau" button
	
	#RA JDB-3815
	
	Then I see "A fyddech chi angen cymorth pan fyddwch yn y llys?" on the page
	When I set the radio button to "Nac oes"
	And I click on the "Pam ein bod yn gofyn am hyn?" link
	And I see "Os ydych yn pryderu am unrhyw beth arall ynghylch y gwasanaeth rheithgor o ran eich nam neu anabledd, yna cysylltwch â ni. Neu gallwch ofyn i rywun arall ffonio ar eich rhan." on the page
	And I see "Rhif ffôn: 0300 456 1024" on the page
	And I see "Llinell Gymraeg: 0300 303 5173" on the page
	And I see link with text "Cwcis" 
	And I press the "Parhau" button
	And I see "Gwiriwch eich ymatebion nawr" on the page
	And I see link with text "Cwcis" 
	
Examples:
	|juror_number	|last_name			|postcode	     |email 		|pool_number	|
	|041592778	    |lname	            |CH2 2AA	     |e@mail.com	|415355408	|
	
@RegressionWelsh @JDB-4533 
Scenario Outline: Welsh 3rd Party Cookies Policy on each page
	Given I am on the welsh version of "Public" "test"

	Given a bureau owned pool is created with jurors
		| court | juror_number  	    | pool_number	    | att_date_weeks_in_future	| owner |
		| 415   | <juror_number> 	    | <pool_number>     | 5				            | 400	|

	And juror "<juror_number>" has "POSTCODE" as "<postcode>" new schema

	And I set the radio button to "Rwy'n ymateb ar ran rhywun arall"
	And I see link with text "Cwcis" 
	And I press the "Parhau" button	
	
	#Juror Log In JDB-3808 and JDB-3940
	
	When I click on the "Nid oes gennyf rif rheithiwr ar gyfer yr unigolyn" link
	Then I see "Rhif ffôn: 0300 456 1024" on the page
	And I see "Llinell Gymraeg: 0300 303 5173" on the page
	
	When I set "Rhif rheithiwr" to "<juror_number>"
	When I set "Cyfenw" to "<last_name>"
	When I set "Cod post Rheithiwr" to "<postcode>"
	And I see link with text "Cwcis" 
	And I press the "Parhau" button
    Then I see "Beth yw eich enw?" on the page
	
	#3rd Party Name
	
	When I see "Eich Manylion" on the page
	When I set "Enw cyntaf" to "FirstNameA"
	And I set "Cyfenw" to "LastNameB"
	And I see link with text "Cwcis" 
	And I press the "Parhau" button
	Then I see "Eich perthynas â'r unigolyn" on the page
	
	#Relationship to juror
	
	When I see "Eich Manylion" on the page
	And I set "Sut ydych chi'n adnabod yr unigolyn rydych yn ymateb ar ei ran?" to "Friend"
	And I see link with text "Cwcis" 
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
	And I see link with text "Cwcis" 
	And I press the "Parhau" button
	
	#Why are you replying title
	
	Then I see "Pam ydych chi'n ymateb ar ran yr unigolyn arall?" on the page
	And I do not see "Pam ydych chi'n ymateb?" on the page
	When I set the radio button to "Nid yw'r unigolyn yma"
	And I see "Efallai ei fod yn teithio, yn yr ysbyty, neu i ffwrdd am fwy nag ychydig ddyddiau am reswm arall." on the page
	And I see "Nid yw'r unigolyn yn gallu ymateb dros ei hun" on the page
	And I see "Nid yw'r unigolyn â'r gallu i ymateb drosto'i hun. Efallai bod hyn oherwydd bod ganddo anabledd neu nam." on the page
	And I see link with text "Cwcis" 
	And I press the "Parhau" button
	Then I see "A yw'r enw sydd gennym ar ei gyfer yn gywir?" on the page
	
	#Check juror name
	
	When I see "Manylion y Rheithiwr" on the page
	And I set the radio button to "Ydy"
	And I see link with text "Cwcis" 
	When I press the "Parhau" button
	
	#Check juror address
	
	And I see link with text "Cwcis" 
	And I set the radio button to "Ie"
	When I press the "Parhau" button
	
	#DoB JDB-3810
	
	When I click on the "Cymorth gyda'ch dyddiad geni" link
	Then I see "Os oes arnoch angen cymorth, ffoniwch ni ar:" on the page
	And I see "Rhif ffôn: 0300 456 1024" on the page
	And I see "Llinell Gymraeg: 0300 303 5173" on the page
	
	When I see "Manylion y Rheithiwr" on the page
	And I see "Er enghraifft, 15 03 1982" on the page
	And I set "Diwrnod" to "27"
	And I set "Mis" to "04"
	And I set "Blwyddyn" to "1981"
	And I see link with text "Cwcis" 
	And I press the "Parhau" button
	Then I see "Efallai bydd yn rhaid inni gysylltu â'r unigolyn i ofyn rhagor o gwestiynau neu roi rhagor o wybodaeth iddynt am eu gwasanaeth rheithgor" on the page
	
	#Contacting the juror
	
	When I see "Manylion y Rheithiwr" on the page
	And I see "Nodwch rifau ffôn y gallwn eu defnyddio i gysylltu â chi rhwng 9am a 5pm, dydd Llun i ddydd Gwener." on the page
	And I set the radio button to "Defnyddio'r rhif ffôn rydych eisoes wedi'i ddarparu i gysylltu â chi"
	
	#Checking field JDB-3824
	
	And I set the radio button to "Rhoi cyfeiriad e-bost gwahanol ar gyfer y rheithiwr"
	And I see "Nodwch gyfeiriad e-bost" on the page
	
	And I set the radio button to "Defnyddio'r cyfeiriad e-bost rydych eisoes wedi'i ddarparu i gysylltu â chi"
	And I see link with text "Cwcis" 
	And I press the "Parhau" button

	#Qualify for jury service
	
	When I see "Cadarnhau a yw'r unigolyn yn gymwys i wasanaethu ar reithgor" on the page
	And I see link with text "Cwcis" 
	And I press the "Parhau" button
	         
	#Residency JDB-3811 and JDB-3910
	
	Then I see "Ers iddynt droi'n 13 oed, a yw eu prif gyfeiriad wedi bod yn y DU, Ynysoedd y Sianel neu Ynys Manaw am unrhyw gyfnod o 5 mlynedd o leiaf?" on the page
	When I click on the "A ydych angen cymorth i ateb hyn?" link
	Then I see "Rhif ffôn: 0300 456 1024" on the page
	And I see "Llinell Gymraeg: 0300 303 5173" on the page
	
	When I see "Cymhwysedd" on the page
	And I set the radio button to "Do"
	And I see link with text "Cwcis" 
	And I press the "Parhau" button
	
	#CJS no JDB-3822
	
	Then I see "A yw'r person yr ydych yn ymateb ar ei ran wedi gweithio yn y system cyfiawnder troseddol yn y 5 mlynedd diwethaf?" on the page
	When I set the radio button to "Ydy"
	And I set the radio button to "Nac ydy"
	And I see link with text "Cwcis" 
	And I press the "Parhau" button
	
	#Bail
	
	Then I see "A yw'r unigolyn ar fechnïaeth ar hyn o bryd am gyflawni trosedd?" on the page
	When I see "Cymhwysedd" on the page
	And I set the radio button to "Nac ydy"
	And I see link with text "Cwcis" 
	And I press the "Parhau" button
	
	#Convictions
	
	Then I see "A yw'r unigolyn wedi'i gael yn euog o drosedd?" on the page
	When I see "Cymhwysedd" on the page
	And I click on the "Canllawiau mewn perthynas â gwasanaethu ar reithgor os oes gennych euogfarn" link
	
	# JDB-4552
	
	And I see "dedfryd o garchar neu gadw yn y ddalfa am 5 mlynedd neu fwy" on the page
	And I see "dedfryd o garchar ar gyfer diogelu'r cyhoedd neu gadw yn y ddalfa er mwyn diogelu'r cyhoedd" on the page
	And I see "dedfryd o garchar, y ddalfa neu gadw yn y ddalfa am oes" on the page
	And I see "dedfryd estynedig o dan un o adrannau 226A, 226B, 227 neu 228 Deddf Cyfiawnder Troseddol 2003, (gan gynnwys dedfryd o'r fath a osodwyd o ganlyniad i adran 219A, 220, 221A neu 222 Deddf y Lluoedd Arfog 2006) neu adran 210A Deddf Gweithdrefn Droseddol (Yr Alban) 1995" on the page
	And I see "cadw hyd mynno Ei Fawrhydi neu hyd mynno'r Ysgrifennydd Gwladol" on the page
	And I see "Ni allant ychwaith wasanaethu ar reithgor os ydynt, yn ystod y 10 mlynedd diwethaf, wedi cael:" on the page
	When I set the radio button to "Nac ydy"
	And I see link with text "Cwcis" 
	And I press the "Parhau" button
	
	#Mental Health Sectioned
	
	Then I see "A ydi'r person yr ydych yn ymateb ar ei ran yn cael ei gadw, ei warchod neu ei drin o dan y Ddeddf Iechyd Meddwl?" on the page
	When I see "Cymhwysedd" on the page
	And I set the radio button to "Na"
	And I see link with text "Cwcis" 
	And I press the "Parhau" button
	
	#Mental Health Capacity JDB-3813
	
	Then I see "A wnaed penderfyniad nad oes gan y person yr ydych yn ymateb ar ei ran y 'gallu meddyliol'?" on the page
	When I see "Cymhwysedd" on the page
	And I click on the "Angen help i ateb hwn?" link
	
	# JDB-4552
	
	And I see "Os nad oes y gallu meddyliol gan rywun, dydyn nhw ddim yn gallu:" on the page
	And I see "gwneud eu penderfyniadau eu hunain" on the page
	And I see "deall a chadw gwybodaeth" on the page
	And I see "cyfathrebu meddyliau a phenderfyniadau i bobl eraill" on the page
	And I see "Ardystiwyd rhai pobl yn feddygol o dan Ddeddf Galluedd Meddyliol 1983 nad oes ganddynt y gallu meddyliol oherwydd damwain neu anaf." on the page
	And I see "Efallai bod yn rhaid penodi rhywun arall i wneud penderfyniadau ar eu rhan." on the page
	When I set the radio button to "Na"
	And I see link with text "Cwcis" 
	And I press the "Parhau" button
	
	Then I see "Gwiriwch eich dyddiad dechrau" on the page
    And I see link with text "Cwcis" 
	
	When I set the radio button to "Nac ydi, rhaid newid y dyddiad"
	And I press the "Parhau" button
	
	#JDB-3448 and JDB-3503
	
	Then I see "Dywedwch wrthym pam fod angen dyddiad arall arnynt ar gyfer y gwasanaeth rheithgor" on the page
	And I see link with text "Cwcis"

	When I set text area with "id" of "deferralReason" to "Reasons for deferral request"
	And I press the "Parhau" button
	Then I see "Dewiswch 3 dydd Llun pan allant ddechrau gwasanaeth rheithgor" on the page
	And I see link with text "Cwcis"

	When I set the "First" single date field to a Monday "6" weeks in the future
	When I set the "Second" single date field to a Monday "7" weeks in the future
	When I set the "Third" single date field to a Monday "8" weeks in the future
	And I press the "Parhau" button
	
	And I set the radio button to "Ydw"
	And I press the "Parhau" button
	
	#RA no JDB-3815
	
	Then I see "A fydd yr unigolyn rydych yn ymateb ar ei ran angen cymorth pan fydd yn y llys?" on the page
	When I set the radio button to "Nac oes"
	And I click on the "Pam ein bod yn gofyn am hyn?" link
	And I see "Os ydych yn pryderu am unrhyw beth arall ynghylch y gwasanaeth rheithgor o ran nam neu anabledd sydd gan yr unigolyn rydych yn ymateb ar ei ran, yna cysylltwch â ni." on the page
	And I see "Rhif ffôn: 0300 456 1024" on the page
	And I see "Llinell Gymraeg: 0300 303 5173" on the page
	And I see link with text "Cwcis" 
	And I press the "Parhau" button 

    #Check your answers
	
	Then I see "Gwiriwch eich ymatebion nawr" on the page
	And I see link with text "Cwcis"
	When I see "A ydi'r person yr ydych yn ymateb ar ei ran yn cael ei gadw, ei warchod neu ei drin o dan y Ddeddf Iechyd Meddwl?" on the page
	And I see "A wnaed penderfyniad nad oes gan y person yr ydych yn ymateb ar ei ran y 'gallu meddyliol'?" on the page
	And I see "A yw'r unigolyn wedi'i gael yn euog o drosedd?" on the page
	And I see "Rwy'n deall efallai y bydd yr atebion a roddais yn cael eu gwirio a gellir fy erlyn os wyf wedi rhoi unrhyw wybodaeth y gwn ei bod yn anwir yn fwriadol." on the page

	And I see "Efallai y cewch eich euogfarnu ac y cewch ddirwy o hyd at £1000 os byddwch yn rhoi gwybodaeth ffug ar gyfer yr unigolyn a gafodd wŷs i osgoi gwasanaethu ar reithgor." on the page
	And I see "Mae hyn hefyd yn berthnasol os byddwch yn methu â rhoi'r wybodaeth sydd ei hangen arnom i benderfynu a yw'r unigolyn sydd wedi cael gwŷs yn gymwys i wasanaethu ar reithgor." on the page
	And I check the "Hyd gwn i, mae'r wybodaeth rwyf wedi ei rhoi am yr unigolyn rwyf yn ymateb ar ei ran yn gywir." checkbox
	And I press the "Cyflwyno" button
	Then I see "Os byddwn yn cysylltu â nhw, efallai bydd angen iddynt ddarparu eu rhif rheithiwr. Mae'r rhif hefyd ar y llythyr bu inni anfon atynt." on the page

	Examples:
		|juror_number	|last_name			|postcode	     |email 		|pool_number	|
		|041592765	    |lname	            |CH2 2AA	     |e@mail.com	|415355407	    |
	