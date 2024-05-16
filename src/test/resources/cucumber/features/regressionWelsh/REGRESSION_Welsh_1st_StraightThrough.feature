Feature: Regression Welsh_1st_StraightThrough

@RegressionWelsh @NewSchemaConverted
Scenario Outline: Welsh 1st Party Straight Through (english court)

	Given I am on the welsh version of "Public" "test"

	Given a bureau owned pool is created with jurors
		| court |juror_number  | pool_number	| att_date_weeks_in_future	| owner |
		| 452   |<juror_number>| <pool_number>	| 5				            | 400	|

	And juror "<juror_number>" has "LAST_NAME" as "<last_name>" new schema
	And juror "<juror_number>" has "POSTCODE" as "<postcode>" new schema

	Then I see "Beth ddylwn ei wneud os oes angen cymorth arnaf i ymateb?" on the page
	And I click on the "Beth ddylwn ei wneud os oes angen cymorth arnaf i ymateb?" link
	And I see "Gallwch ofyn i aelod o'ch teulu, ffrind neu ofalydd i'ch helpu." on the page
	And I see "Gallant ymateb ar eich rhan neu'ch cynorthwyo i ymateb dros eich hun" on the page
	And I see "Mae'n bosib y gallech gael cymorth gyda defnyddio cyfrifiadur yn eich llyfrgell leol" on the page
	And I see "Os oes angen rhagor o gymorth arnoch, gallwch ein ffonio ar:" on the page
	And I see "Rhif ffôn: 0300 456 1024" on the page
	And I see "Llinell Gymraeg: 0300 303 5173" on the page
	And I set the radio button to "n ymateb dros fy hun"
	And I press the "Parhau" button
	Then I see "Eich manylion rheithiwr" on the page
	
	#Login
	And I see "steps/login" in the URL
	When I click on the "Nid oes gennyf rif rheithiwr" link
	Then I see "Gallwch ddod o hyd i'ch rhif rheithiwr ar eich llythyr gwŷs rheithgor." on the page

	And I see "Rhif ffôn: 0300 456 1024" on the page
	And I see "Llinell Gymraeg: 0300 303 5173" on the page
	
	And I see "Rhowch eich enw olaf fel y mae wedi'i nodi ar y llythyr gwŷs rheithgor, hyd yn oed os yw'n anghywir. Gallwch ei newid nes ymlaen." on the page
	
	And I see "Rhowch eich cod post fel y mae wedi'i nodi ar y llythyr gwŷs rheithgor, hyd yn oed os yw'n anghywir. Gallwch ei newid nes ymlaen." on the page
	
	When I set "Rhif rheithiwr" to "<juror_number>"
	When I set "Cyfenw" to "<last_name>"
	When I set "Cod post Rheithiwr" to "<postcode>"
	And I press the "Parhau" button
	
	#Check Your Name
	And I see "steps/your-details/name" in the URL
	And I set the radio button to "Ydy"
	And I press the "Parhau" button
	
	#Check Your Address
	And I see "steps/your-details/address" in the URL
	Then on the page I see
		| text	|
		| Eich Manylion |
		| Eich cyfeiriad chi yw hwn? |
		
	And I set the radio button to "Ie"
	And I do not see "Gwiriwch fod eich enw a'r cyfeiriad yn gywir" on the page	
	When I press the "Parhau" button
	
	#Phone
	And I see "steps/your-details/phone" in the URL
	Then on the page I see
		| text	|
		| Eich Manylion |
		| Beth yw eich rhif ffôn? |
		| Darparwch rif ffôn yn y DU y gallwn ei ddefnyddio i gysylltu â chi rhwng 9am a 5pm, dydd Llun i ddydd Gwener. |
		| Prif rif ffôn |
		| Rhif ffôn arall (dewisol) |
	
	When I set "Prif rif ffôn" to "0207 821 1818"
	And I press the "Parhau" button
	
	#Email
	And I see "steps/your-details/email" in the URL
	Then on the page I see
		| text|
		| Eich Manylion |
		| Beth yw eich cyfeiriad e-bost? |
		| Pam fod arnom angen eich cyfeiriad e-bost? |

	When I see "Pam fod arnom angen eich cyfeiriad e-bost?" on the page
	And I set "Nodwch eich cyfeiriad e-bost" to "<email>"
	And I set "Nodwch eich cyfeiriad e-bost eto" to "<email>"
	And I press the "Parhau" button
	
	#DoB
	And I see "steps/your-details/date-of-birth" in the URL
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
	And I press the "Parhau" button
	
	#Qualify for jury service
	And I see "steps/qualify" in the URL
	Then I see "Cadarnhau a ydych yn gymwys i wasanaethu ar reithgor" on the page
	And I see "Bydd eich atebion yn yr adran nesaf yn ein helpu i wirio a ydych yn gallu gwasanaethu ar reithgor ai peidio." on the page
	And I see "Rhaid ichi ateb y cwestiynau hyd yn oed os ydych:" on the page
	And I see "yn meddwl nad ydych yn gymwys" on the page
	And I see "eisiau cael eich esgusodi" on the page
	And I see "Gallwch ofyn i gael eich esgusodi ar ôl yr adran hon, os bydd angen." on the page
	When I press the "Parhau" button
	Then I see "Ers i chi droi'n 13 oed, a yw eich prif gyfeiriad wedi bod yn y DU, Ynysoedd y Sianel neu Ynys Manaw am unrhyw gyfnod o 5 mlynedd o leiaf?" on the page
	
	#Residency
	And I see "steps/qualify/residency" in the URL
	And I see "Cymhwysedd" on the page
	When I click on the "A ydych angen cymorth i ateb hyn?" link
	Then I see "I fod yn gymwys ar gyfer gwasanaeth rheithgor, rhaid bod eich prif gyfeiriad wedi bod yn un o'r canlynol am unrhyw gyfnod o 5 mlynedd o leiaf:" on the page
	
	And I do not see "Cymhwyso ar gyfer gwasanaeth rheithgor" on the page
	And I set the radio button to "Naddo"
	And I set the radio button to "Do"
	And I press the "Parhau" button
	
	#CJS
	And I see "steps/qualify/cjs-employed" in the URL
	And I see "Cymhwysedd" on the page
	And I do not see "Cymhwyso ar gyfer gwasanaeth rheithgor" on the page
	Then I see "A ydych chi wedi gweithio yn y system cyfiawnder troseddol yn y 5 mlynedd diwethaf?" on the page
	When I set the radio button to "Nac ydw"
	And I press the "Parhau" button
	
	#Bail
	And I see "steps/qualify/bail" in the URL
	Then I see "Ydych chi ar fechnïaeth ar hyn o bryd am gyflawni trosedd?" on the page
	And I see "Cymhwysedd" on the page
	And I do not see "Cymhwyso ar gyfer gwasanaeth rheithgor" on the page
	And I set the radio button to "Nac ydw"
	And I press the "Parhau" button
	
	#Convictions
	And I see "steps/qualify/convictions" in the URL
	Then I see "Ydych chi wedi'ch cael yn euog o drosedd?" on the page
	And I see "Cymhwysedd" on the page
	And I do not see "Cymhwyso ar gyfer gwasanaeth rheithgor" on the page
	And I see "Dim ond os cawsoch ddedfryd o garchar, gorchymyn cymunedol neu ddedfryd o garchar ohiriedig y mae hyn yn berthnasol." on the page
	When I click on the "Canllawiau mewn perthynas â gwasanaethu ar reithgor os oes gennych euogfarn" link

	And I see "dedfryd o garchar neu gadw yn y ddalfa am 5 mlynedd neu fwy" on the page
	And I see "dedfryd o garchar ar gyfer diogelu'r cyhoedd neu gadw yn y ddalfa er mwyn diogelu'r cyhoedd" on the page
	And I see "dedfryd o garchar, y ddalfa neu gadw yn y ddalfa am oes" on the page
	And I see "dedfryd estynedig o dan un o adrannau 226A, 226B, 227 neu 228 Deddf Cyfiawnder Troseddol 2003, (gan gynnwys dedfryd o'r fath a osodwyd o ganlyniad i adran 219A, 220, 221A neu 222 Deddf y Lluoedd Arfog 2006) neu adran 210A Deddf Gweithdrefn Droseddol (Yr Alban) 1995" on the page
	And I see "cadw hyd mynno Ei Fawrhydi neu hyd mynno'r Ysgrifennydd Gwladol" on the page

	When I set the radio button to "Naddo"
	And I press the "Parhau" button
	
	#Mental Health Sectioned
	And I see "steps/qualify/mental-health-sectioned" in the URL
	Then I see "Ydych chi'n cael eich cadw, yn cael eich gwarchod neu eich trin o dan y Ddeddf Galluedd Meddyliol?" on the page
	And I see "Cymhwysedd" on the page
	
	And I do not see "Cymhwyso ar gyfer gwasanaeth rheithgor" on the page
	And I set the radio button to "Na"
	And I press the "Parhau" button
	Then I see "A benderfynwyd nad oes gennych y gallu meddyliol?" on the page
	
	#Mental Health Capacity
	And I see "steps/qualify/mental-health-capacity" in the URL
	And I see "Cymhwysedd" on the page
	And I do not see "Cymhwyso ar gyfer gwasanaeth rheithgor" on the page
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
	And I press the "Parhau" button		
	
	#Confirm attendance
	Then I see "Gwiriwch eich dyddiad dechrau" on the page
	
	When I set the radio button to "Ydw, rydw i'n gallu dechrau"
	
	And I press the "Parhau" button
	
	#RA
	Then I see "A fyddech chi angen cymorth pan fyddwch yn y llys?" on the page
	When I set the radio button to "Nac oes"
	And I click on the "Pam ein bod yn gofyn am hyn?" link
	And I see "Os ydych yn pryderu am unrhyw beth arall ynghylch y gwasanaeth rheithgor o ran eich nam neu anabledd, yna cysylltwch â ni. Neu gallwch ofyn i rywun arall ffonio ar eich rhan." on the page
	And I see "Rhif ffôn: 0300 456 1024" on the page
	And I see "Llinell Gymraeg: 0300 303 5173" on the page
	And I press the "Parhau" button
	And I see "Gwiriwch eich ymatebion nawr" on the page
	
	#Check your answers
	When I see "Ydych chi'n cael eich cadw, yn cael eich gwarchod neu eich trin o dan y Ddeddf Galluedd Meddyliol?" on the page
	And I see "A benderfynwyd nad oes gennych y gallu meddyliol?" on the page
	And I see "Bu ichi ymateb i'r dyddiad arfaethedig ar gyfer eich gwasanaeth rheithgor" on the page
	Then I see text "Ie" in the same row as "A benderfynwyd nad oes gennych y gallu meddyliol?"
	And I see "Cadarnhewch ddyddiad eich gwasanaeth rheithgor" on the page
	
	#change MH capacity to No
	Then I click on the "Newid" link in the same row as "A benderfynwyd nad oes gennych y gallu meddyliol?"
	And I see "Cymhwysedd" on the page
	And I do not see "Cymhwyso ar gyfer gwasanaeth rheithgor" on the page
	And I set the radio button to "Na"
	And I press the "Parhau" button
	When I see "Ydych chi'n cael eich cadw, yn cael eich gwarchod neu eich trin o dan y Ddeddf Galluedd Meddyliol?" on the page
	Then I see text "Na" in the same row as "A benderfynwyd nad oes gennych y gallu meddyliol?"
	And I see "Rwy'n deall efallai y bydd yr atebion a roddais yn cael eu gwirio a gellir fy erlyn os wyf wedi rhoi unrhyw wybodaeth y gwn ei bod yn anwir." on the page
	
	#submit
	And I see "Gallwch gael eich barnu'n euog a chael dirwy o hyd at £1000 os byddwch yn darparu gwybodaeth anwireddus i osgoi gwasanaethu ar reithgor. Mae hyn hefyd yn berthnasol os byddwch yn methu â darparu'r wybodaeth yr ydym ei hangen i benderfynu a ydych yn gymwys i wasanaethu ar reithgor ai peidio." on the page
	And I check the "Mae'r wybodaeth a roddais uchod yn wir hyd eithaf fy ngwybodaeth." checkbox
	And I press the "Cyflwyno" button
	
	Then I see "O leiaf 2 wythnos cyn ichi ddechrau gwasanaethu ar reithgor, byddwn yn anfon y canlynol atoch:" on the page
	Then I do not see "Yna, o leiaf pythefnos cyn i’r gwasanaeth rheithgor ddechrau byddwn yn anfon y dogfennau canlynol atoch:" on the page
	Then I see "Gallwch wylio fideo am beth sy'n digwydd wrth fod yn rheithiwr ar YouTube, fel eich bod yn gwybod beth i'w ddisgwyl. Mae'r fideo'n para 13 munud." on the page

	And I see "Lawrlwythwch gopi o'ch ymateb i'r wŷs HTML (15KB)" on the page
	Then I click on the "HTML (15KB)" link
	And I see "Mi wnaethoch ateb y cwestiynau cymhwysedd" on the page
	
	#Bureau
	Given I am on "Bureau" "test"
	And I log in as "MODTESTBUREAU"
	
	When I click on the "Search" link
	And I set "Juror number" to "<juror_number>"
	And I press the "Search" button
	
	When I click on "<juror_number>" in the same row as "<juror_number>"
	
	Then I see "COMPLETED" on the page
	
	Then on "JUROR_MOD" . "JUROR_RESPONSE" I see "PROCESSING_STATUS" is "CLOSED" where "JUROR_NUMBER" is "<juror_number>"
	Then on "JUROR_MOD" . "JUROR_RESPONSE" I see "PROCESSING_COMPLETE" is "Y" where "JUROR_NUMBER" is "<juror_number>"

	Then on "JUROR_MOD" . "JUROR" I see "WELSH" is null where "juror_number" is "<juror_number>"
	
Examples:
	| juror_number	| last_name	| postcode	| email 		| pool_number	|
	| 045200265		| LastNameB	| CH1 2AN	| e@mail.com	| 452300242		|

@RegressionWelsh @NewSchemaConverted
Scenario Outline: Welsh 1st Party Straight Through (welsh court)

	Given I am on the welsh version of "Public" "test"

	Given a bureau owned pool is created with jurors
		| court |juror_number  | pool_number	| att_date_weeks_in_future	| owner |
		| 457   |<juror_number>| <pool_number>	| 5				            | 400	|

	And juror "<juror_number>" has "LAST_NAME" as "<last_name>" new schema
	And juror "<juror_number>" has "POSTCODE" as "<postcode>" new schema

	And I set the radio button to "n ymateb dros fy hun"
	And I press the "Parhau" button
	Then I see "Eich manylion rheithiwr" on the page

	#Login
	When I click on the "Nid oes gennyf rif rheithiwr" link
	Then I see "Gallwch ddod o hyd i'ch rhif rheithiwr ar eich llythyr gwŷs rheithgor." on the page

	And I see "Rhif ffôn: 0300 456 1024" on the page
	And I see "Llinell Gymraeg: 0300 303 5173" on the page

	And I see "Rhowch eich enw olaf fel y mae wedi'i nodi ar y llythyr gwŷs rheithgor, hyd yn oed os yw'n anghywir. Gallwch ei newid nes ymlaen." on the page

	And I see "Rhowch eich cod post fel y mae wedi'i nodi ar y llythyr gwŷs rheithgor, hyd yn oed os yw'n anghywir. Gallwch ei newid nes ymlaen." on the page

	When I set "Rhif rheithiwr" to "<juror_number>"
	When I set "Cyfenw" to "<last_name>"
	When I set "Cod post Rheithiwr" to "<postcode>"
	And I press the "Parhau" button

	#Check Your Name
	And I set the radio button to "Ydy"
	And I press the "Parhau" button

	#Check Your Address
	Then on the page I see
		| text	|
		| Eich Manylion |
		| Eich cyfeiriad chi yw hwn? |

	And I set the radio button to "Ie"
	And I do not see "Gwiriwch fod eich enw a'r cyfeiriad yn gywir" on the page
	When I press the "Parhau" button

	#Phone
	Then on the page I see
		| text	|
		| Eich Manylion |
		| Beth yw eich rhif ffôn? |
		| Darparwch rif ffôn yn y DU y gallwn ei ddefnyddio i gysylltu â chi rhwng 9am a 5pm, dydd Llun i ddydd Gwener. |
		| Prif rif ffôn |
		| Rhif ffôn arall (dewisol) |

	When I set "Prif rif ffôn" to "0207 821 1818"
	And I press the "Parhau" button

	#Email
	Then on the page I see
		| text|
		| Eich Manylion |
		| Beth yw eich cyfeiriad e-bost? |
		| Pam fod arnom angen eich cyfeiriad e-bost? |

	When I see "Pam fod arnom angen eich cyfeiriad e-bost?" on the page
	And I set "Nodwch eich cyfeiriad e-bost" to "email@outlook.com"
	And I set "Nodwch eich cyfeiriad e-bost eto" to "email@outlook.com"
	And I press the "Parhau" button

	#DoB
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
	And I press the "Parhau" button

	#Eligible for jury service
	Then I see "Cadarnhau a ydych yn gymwys i wasanaethu ar reithgor" on the page
	When I press the "Parhau" button

	#Residency
	Then I see "Ers i chi droi'n 13 oed, a yw eich prif gyfeiriad wedi bod yn y DU, Ynysoedd y Sianel neu Ynys Manaw am unrhyw gyfnod o 5 mlynedd o leiaf?" on the page
	When I click on the "A ydych angen cymorth i ateb hyn?" link

	And I see "Rhif ffôn: 0300 456 1024" on the page
	And I see "Llinell Gymraeg: 0300 303 5173" on the page

	And I see "Cymhwysedd" on the page
	And I set the radio button to "Naddo"
	And I set the radio button to "Do"
	And I press the "Parhau" button

	#CJS
	And I see "Cymhwysedd" on the page
	Then I see "A ydych chi wedi gweithio yn y system cyfiawnder troseddol yn y 5 mlynedd diwethaf?" on the page
	When I set the radio button to "Nac ydw"
	And I press the "Parhau" button

	#Convictions
	Then I see "Ydych chi ar fechnïaeth ar hyn o bryd am gyflawni trosedd?" on the page

	When I see "Cymhwysedd" on the page

	And I see "Os ydych ar fechnïaeth mewn achos troseddol, ni allwch wasanaethu ar reithgor." on the page
	And I click on the "Cliciwch i fynd yn ôl" link
	When I set the radio button to "Nac ydw"
	And I press the "Parhau" button

	#Bail
	Then I see "Ydych chi ar fechnïaeth ar hyn o bryd am gyflawni trosedd?" on the page
	When I see "Cymhwysedd" on the page
	And I set the radio button to "Nac ydw"
	And I press the "Parhau" button

	#Mental Health Sectioned
	When I see "Cymhwysedd" on the page
	And I set the radio button to "Naddo"
	And I press the "Parhau" button
	Then I see "Ydych chi'n cael eich cadw, yn cael eich gwarchod neu eich trin o dan y Ddeddf Galluedd Meddyliol?" on the page

	#Mental Health Capacity
	When I see "Cymhwysedd" on the page
	And I click on the "Angen help i ateb hwn?" link
	And I see "Ni allwch fod ar reithgor os ydi un o'r datganiadau hyn yn berthnasol i chi." on the page

	And I see "Ie" on the page
	And I see "Na" on the page
	And I set the radio button to "Ie"
	And I set "Eglurwch sut yr ydych yn cael eich cadw dan glo, sut ofal ydych yn ei gael neu sut yr ydych yn cael eich trin o dan y Ddeddf Iechyd Meddwl" to "Reasons for sectioned"

	And I press the "Parhau" button

	Then I see "A benderfynwyd nad oes gennych y gallu meddyliol?" on the page
	And I set the radio button to "Na"
	And I press the "Parhau" button

	#Confirm attendance
	Then I see "Gwiriwch eich dyddiad dechrau" on the page

	When I set the radio button to "Ydw, rydw i'n gallu dechrau"


	And I press the "Parhau" button

	#RA
	Then I see "A fyddech chi angen cymorth pan fyddwch yn y llys?" on the page
	When I set the radio button to "Nac oes"
	And I click on the "Pam ein bod yn gofyn am hyn?" link
	And I see "Os ydych yn pryderu am unrhyw beth arall ynghylch y gwasanaeth rheithgor o ran eich nam neu anabledd, yna cysylltwch â ni. Neu gallwch ofyn i rywun arall ffonio ar eich rhan." on the page
	And I see "Rhif ffôn: 0300 456 1024" on the page
	And I see "Llinell Gymraeg: 0300 303 5173" on the page
	And I press the "Parhau" button
	And I see "Gwiriwch eich ymatebion nawr" on the page

	#Check your answers
	When I see "Ydych chi'n cael eich cadw, yn cael eich gwarchod neu eich trin o dan y Ddeddf Galluedd Meddyliol?" on the page
	And I see "A benderfynwyd nad oes gennych y gallu meddyliol?" on the page
	And I see "Bu ichi ymateb i'r dyddiad arfaethedig ar gyfer eich gwasanaeth rheithgor" on the page
	Then I see text "Ie" in the same row as "Ydych chi'n cael eich cadw, yn cael eich gwarchod neu eich trin o dan y Ddeddf Galluedd Meddyliol?"
	And I see "Cadarnhewch ddyddiad eich gwasanaeth rheithgor" on the page

	#change MH capacity to No
	Then I click on the "Newid" link in the same row as "Ydych chi'n cael eich cadw, yn cael eich gwarchod neu eich trin o dan y Ddeddf Galluedd Meddyliol?"
	When I see "Cymhwysedd" on the page
	And I set the radio button to "Na"
	And I press the "Parhau" button
	When I see "Ydych chi'n cael eich cadw, yn cael eich gwarchod neu eich trin o dan y Ddeddf Galluedd Meddyliol?" on the page
	Then I see text "Na" in the same row as "Ydych chi'n cael eich cadw, yn cael eich gwarchod neu eich trin o dan y Ddeddf Galluedd Meddyliol?"
	And I see "Rwy'n deall efallai y bydd yr atebion a roddais yn cael eu gwirio a gellir fy erlyn os wyf wedi rhoi unrhyw wybodaeth y gwn ei bod yn anwir." on the page

	#submit
	And I check the "Mae'r wybodaeth a roddais uchod yn wir hyd eithaf fy ngwybodaeth." checkbox
	And I press the "Cyflwyno" button

	Then I see "O leiaf 2 wythnos cyn ichi ddechrau gwasanaethu ar reithgor, byddwn yn anfon y canlynol atoch:" on the page
	Then I do not see "Yna, o leiaf pythefnos cyn i’r gwasanaeth rheithgor ddechrau byddwn yn anfon y dogfennau canlynol atoch:" on the page
	Then I see "Gallwch wylio fideo am beth sy'n digwydd wrth fod yn rheithiwr ar YouTube, fel eich bod yn gwybod beth i'w ddisgwyl. Mae'r fideo'n para 13 munud." on the page

	#Bureau
	Given I am on "Bureau" "test"
	And I log in as "MODTESTBUREAU"
	
	When I click on the "Search" link
	And I set "Juror number" to "<juror_number>"
	And I press the "Search" button
	
	When I click on "<juror_number>" in the same row as "<juror_number>"

	And I see "COMPLETED" on the page
	
	Then on "JUROR_MOD" . "JUROR_RESPONSE" I see "PROCESSING_STATUS" is "CLOSED" where "JUROR_NUMBER" is "<juror_number>"
	Then on "JUROR_MOD" . "JUROR_RESPONSE" I see "PROCESSING_COMPLETE" is "Y" where "JUROR_NUMBER" is "<juror_number>"

	Then on "JUROR_MOD" . "JUROR" I see "WELSH" is "Y" where "juror_number" is "<juror_number>"
	
Examples:
	| juror_number	| last_name	| postcode	| pool_number	|
	| 045700056		| LastNameB	| SA1 4PF	| 457300056		|