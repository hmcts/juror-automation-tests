Feature: Regression Welsh_1st_StraightThrough

@RegressionWelsh @JDB-3087 @JDB-3095 @JDB-3096 @JDB-3099 @JDB-3358 @JDB-3359 @JDB-3350 @JDB-3360 @JDB-3361 @JDB-3352
@JDB-3362 @JDB-3373 @JDB-3378 @JDB-3363 @JDB-3364 @JDB-3371 @JDB-3377 @JDB-3370 @JDB-3376 @JDB-3355 @JDB-3372 @JDB-3409 @JDB-3420 @JDB-3453 
@JDB-3473 @JDB-3469 @JDB-3468 @JDB-3465 @JDB-3464 @JDB-3463 @JDB-3456 @JDB-3375 @JDB-3506 @JDB-3807 @JDB-3808 @JDB-3809 @JDB-3810 @JDB-3811
@JDB-3812 @JDB-3813 @JDB-3814 @JDB-3815 @JDB-3818 @JDB-3820 @JDB-3821 @JDB-3873 @JDB-3833 @JDB-3863 @JDB-3880 @JDB-3905 @JDB-3906 @JDB-3939
@JDB-3908 @JDB-3909 @JDB-3911 @JDB-3914 @JDB-2237 @JDB-3790 @JDB-4089 @JDB-4249 
Scenario Outline: Welsh 1st Party Straight Through (english court)
	Given I am on the welsh version of "Public" "bau-test"
	Given auto straight through processing has been enabled
	Given the juror numbers have not been processed
		| part_no 	| pool_no 	| owner |
		| <part_no> |<pool_no>	| 400 	|
		
	And "<part_no>" has "LNAME" as "<last_name>" 
	And "<part_no>" has "ZIP" as "<postcode>"
	And "<part_no>" has "RET_DATE" as "5 mondays time"
	And "<part_no>" has "NEXT_DATE" as "5 mondays time"

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
	
	#Login JDB-3808
	
	And I see "steps/login" in the URL
	When I click on the "Nid oes gennyf rif rheithiwr" link
	Then I see "Gallwch ddod o hyd i'ch rhif rheithiwr ar eich llythyr gwŷs rheithgor." on the page
	
	#JDB-3939
	
	And I see "Rhif ffôn: 0300 456 1024" on the page
	And I see "Llinell Gymraeg: 0300 303 5173" on the page
	
	And I see "Rhowch eich enw olaf fel y mae wedi'i nodi ar y llythyr gwŷs rheithgor, hyd yn oed os yw'n anghywir. Gallwch ei newid nes ymlaen." on the page
	
	And I see "Rhowch eich cod post fel y mae wedi'i nodi ar y llythyr gwŷs rheithgor, hyd yn oed os yw'n anghywir. Gallwch ei newid nes ymlaen." on the page
	
	When I set "Rhif rheithiwr" to "<part_no>"
	When I set "Cyfenw" to "<last_name>"
	When I set "Cod post Rheithiwr" to "<postcode>"
	And I press the "Parhau" button
	
	#Check Your Name
	
	And I see "steps/your-details/name" in the URL
	And I set the radio button to "Nac ydy"
	And I press the "Parhau" button
	
	Then I set "Enw cyntaf" to "FirstNameA"
	And I set "Cyfenw" to "LastNameB"
	And I click on the "Beth sy'n digwydd os rwyf wedi newid fy enw?" link
	And I see "Os yw eich enw chi wedi newid, byddwn yn cysylltu â chi i wirio hynny. Efallai y byddwn yn gofyn am dystysgrif briodas, tystysgrif partneriaeth sifil neu weithred newid enw." on the page
	And I press the "Parhau" button
	
	#Check Your Address JDB-3809
	
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
	
	#JDB-3820
	
	When I see "Pam fod arnom angen eich cyfeiriad e-bost?" on the page
	And I set "Nodwch eich cyfeiriad e-bost" to "<email>"
	And I set "Nodwch eich cyfeiriad e-bost eto" to "<email>"
	And I press the "Parhau" button
	
	#DoB JDB-3810
	
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
	
	#Residency JDB-3909
	
	And I see "steps/qualify/residency" in the URL
	And I see "Cymhwysedd" on the page
	When I click on the "A ydych angen cymorth i ateb hyn?" link
	Then I see "I fod yn gymwys ar gyfer gwasanaeth rheithgor, rhaid bod eich prif gyfeiriad wedi bod yn un o'r canlynol am unrhyw gyfnod o 5 mlynedd o leiaf:" on the page
	
	And I do not see "Cymhwyso ar gyfer gwasanaeth rheithgor" on the page
	And I set the radio button to "Naddo"
	And I set the radio button to "Do"
	And I press the "Parhau" button
	
	#CJS JDB-3873
	
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
	
	#Convictions JDB-3814
	
	And I see "steps/qualify/convictions" in the URL
	Then I see "Ydych chi wedi'ch cael yn euog o drosedd?" on the page
	And I see "Cymhwysedd" on the page
	And I do not see "Cymhwyso ar gyfer gwasanaeth rheithgor" on the page
	And I see "Dim ond os cawsoch ddedfryd o garchar, gorchymyn cymunedol neu ddedfryd o garchar ohiriedig y mae hyn yn berthnasol." on the page
	When I click on the "Canllawiau mewn perthynas â gwasanaethu ar reithgor os oes gennych euogfarn" link
	
	#JDB-4552
	
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
	
	#Mental Health Capacity JDB-3812 and JDB-3813 JDB-3880 JDB-4552
	
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
	
	#RA JDB-3815
	
	Then I see "A fyddech chi angen cymorth pan fyddwch yn y llys?" on the page
	When I set the radio button to "Nac oes"
	And I click on the "Pam ein bod yn gofyn am hyn?" link
	And I see "Os ydych yn pryderu am unrhyw beth arall ynghylch y gwasanaeth rheithgor o ran eich nam neu anabledd, yna cysylltwch â ni. Neu gallwch ofyn i rywun arall ffonio ar eich rhan." on the page
	And I see "Rhif ffôn: 0300 456 1024" on the page
	And I see "Llinell Gymraeg: 0300 303 5173" on the page
	And I press the "Parhau" button
	And I see "Gwiriwch eich ymatebion nawr" on the page
	
	#Check your answers JDB-3818 and JDB-3880
	
	When I see "Ydych chi'n cael eich cadw, yn cael eich gwarchod neu eich trin o dan y Ddeddf Galluedd Meddyliol?" on the page
	And I see "A benderfynwyd nad oes gennych y gallu meddyliol?" on the page
	And I see "Bu ichi ymateb i'r dyddiad arfaethedig ar gyfer eich gwasanaeth rheithgor" on the page
	Then I see text "Ie" in the same row as "A benderfynwyd nad oes gennych y gallu meddyliol?"
	And I see "Cadarnhewch ddyddiad eich gwasanaeth rheithgor" on the page
	
	#change MH capacity to No JDB-3880
	
	Then I click on the "Newid" link in the same row as "A benderfynwyd nad oes gennych y gallu meddyliol?"
	And I see "Cymhwysedd" on the page
	And I do not see "Cymhwyso ar gyfer gwasanaeth rheithgor" on the page
	And I set the radio button to "Na"
	And I press the "Parhau" button
	When I see "Ydych chi'n cael eich cadw, yn cael eich gwarchod neu eich trin o dan y Ddeddf Galluedd Meddyliol?" on the page
	Then I see text "Na" in the same row as "A benderfynwyd nad oes gennych y gallu meddyliol?"
	And I see "Rwy'n deall efallai y bydd yr atebion a roddais yn cael eu gwirio a gellir fy erlyn os wyf wedi rhoi unrhyw wybodaeth y gwn ei bod yn anwir." on the page
	
	#submit
	
	# JDB-4552
	
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
	
	Given I am on "Bureau" "bau-test"
	And I log in as "SYSTEM"
	
	When I click on the "Search" link
	And I set "Juror number" to "<part_no>"
	And I press the "Search" button
	
	When I click on "<part_no>" in the same row as "<part_no>"
	
	Then I see "COMPLETED" on the page
	
	Then on "JUROR_DIGITAL" . "JUROR_RESPONSE" I see "PROCESSING_STATUS" is "CLOSED" where "JUROR_NUMBER" is "<part_no>"
	Then on "JUROR_DIGITAL" . "JUROR_RESPONSE" I see "PROCESSING_COMPLETE" is "Y" where "JUROR_NUMBER" is "<part_no>"
	
	#JDB-3453
	
	Then on "JUROR" . "POOL" I see "WELSH" is null where "part_no" is "<part_no>"
	
Examples:
	|part_no	|last_name	|postcode	|email 		|pool_no	|
	|841501049	|LastNameB	|CH1 2AN	|e@mail.com	|415181001	|

@RegressionWelsh 
Scenario Outline: Welsh 1st Party Straight Through (welsh court)
	Given I am on the welsh version of "Public" "bau-test"
	Given the juror numbers have not been processed
		| part_no 	| pool_no 	| owner |
		| <part_no> |<pool_no>	| 400 	|

	And "<part_no>" has "LNAME" as "<last_name>" 
	And "<part_no>" has "ZIP" as "<postcode>"
	And "<part_no>" has "RET_DATE" as "5 mondays time"
	And "<part_no>" has "NEXT_DATE" as "5 mondays time"
	
	And I set the radio button to "n ymateb dros fy hun"
	And I press the "Parhau" button
	Then I see "Eich manylion rheithiwr" on the page
	
	#Login JDB-3808
	
	When I click on the "Nid oes gennyf rif rheithiwr" link
	Then I see "Gallwch ddod o hyd i'ch rhif rheithiwr ar eich llythyr gwŷs rheithgor." on the page
	
	#JDB-3939
	
	And I see "Rhif ffôn: 0300 456 1024" on the page
	And I see "Llinell Gymraeg: 0300 303 5173" on the page
	
	And I see "Rhowch eich enw olaf fel y mae wedi'i nodi ar y llythyr gwŷs rheithgor, hyd yn oed os yw'n anghywir. Gallwch ei newid nes ymlaen." on the page
	
	And I see "Rhowch eich cod post fel y mae wedi'i nodi ar y llythyr gwŷs rheithgor, hyd yn oed os yw'n anghywir. Gallwch ei newid nes ymlaen." on the page
	
	When I set "Rhif rheithiwr" to "<part_no>"
	When I set "Cyfenw" to "<last_name>"
	When I set "Cod post Rheithiwr" to "<postcode>"
	And I press the "Parhau" button
	
	#Check Your Name
		
	And I set the radio button to "Nac ydy"
	And I press the "Parhau" button
	
	Then I set "Enw cyntaf" to "FirstNameA"
	And I set "Cyfenw" to "LastNameB"
	And I click on the "Beth sy'n digwydd os rwyf wedi newid fy enw?" link
	And I see "Os yw eich enw chi wedi newid, byddwn yn cysylltu â chi i wirio hynny. Efallai y byddwn yn gofyn am dystysgrif briodas, tystysgrif partneriaeth sifil neu weithred newid enw." on the page
	And I press the "Parhau" button
	
	#Check Your Address JDB-3809
	
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
	
	#JDB-3820
	
	When I see "Pam fod arnom angen eich cyfeiriad e-bost?" on the page
	And I set "Nodwch eich cyfeiriad e-bost" to "email@outlook.com"
	And I set "Nodwch eich cyfeiriad e-bost eto" to "email@outlook.com"
	And I press the "Parhau" button
	
	#DoB JDB-3810

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
	
	#Residency JDB-3909
	
	Then I see "Ers i chi droi'n 13 oed, a yw eich prif gyfeiriad wedi bod yn y DU, Ynysoedd y Sianel neu Ynys Manaw am unrhyw gyfnod o 5 mlynedd o leiaf?" on the page
	When I click on the "A ydych angen cymorth i ateb hyn?" link
#	Then I see "Gwiriwch hyn gyda ni trwy ffonio:" on the page
	And I see "Rhif ffôn: 0300 456 1024" on the page
	And I see "Llinell Gymraeg: 0300 303 5173" on the page
#	When I click on the "Cliciwch i fynd yn ôl" link
	
	And I see "Cymhwysedd" on the page
	And I set the radio button to "Naddo"
	And I set the radio button to "Do"
	And I press the "Parhau" button
	
	#CJS JDB-3873
	
	And I see "Cymhwysedd" on the page
	Then I see "A ydych chi wedi gweithio yn y system cyfiawnder troseddol yn y 5 mlynedd diwethaf?" on the page
	When I set the radio button to "Nac ydw"
	And I press the "Parhau" button
	
	#Convictions JDB-3814
	
	Then I see "Ydych chi ar fechnïaeth ar hyn o bryd am gyflawni trosedd?" on the page

	When I see "Cymhwysedd" on the page
#	When I click on the "Rhagor o wybodaeth" link

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
	
	#Mental Health Capacity JDB-3812 and JDB-3813 JDB-3880
	
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
	
	#RA JDB-3815
	
	Then I see "A fyddech chi angen cymorth pan fyddwch yn y llys?" on the page
	When I set the radio button to "Nac oes"
	And I click on the "Pam ein bod yn gofyn am hyn?" link
	And I see "Os ydych yn pryderu am unrhyw beth arall ynghylch y gwasanaeth rheithgor o ran eich nam neu anabledd, yna cysylltwch â ni. Neu gallwch ofyn i rywun arall ffonio ar eich rhan." on the page
	And I see "Rhif ffôn: 0300 456 1024" on the page
	And I see "Llinell Gymraeg: 0300 303 5173" on the page
	And I press the "Parhau" button
	And I see "Gwiriwch eich ymatebion nawr" on the page
	
	#Check your answers JDB-3818 and JDB-3880
	
	When I see "Ydych chi'n cael eich cadw, yn cael eich gwarchod neu eich trin o dan y Ddeddf Galluedd Meddyliol?" on the page
	And I see "A benderfynwyd nad oes gennych y gallu meddyliol?" on the page
	And I see "Bu ichi ymateb i'r dyddiad arfaethedig ar gyfer eich gwasanaeth rheithgor" on the page
	Then I see text "Ie" in the same row as "Ydych chi'n cael eich cadw, yn cael eich gwarchod neu eich trin o dan y Ddeddf Galluedd Meddyliol?"
	And I see "Cadarnhewch ddyddiad eich gwasanaeth rheithgor" on the page
	
	#change MH capacity to No JDB-3880
	
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
	
	Given I am on "Bureau" "bau-test"
	And I log in as "SYSTEM"
	
	When I click on the "Search" link
	And I set "Juror number" to "<part_no>"
	And I press the "Search" button
	
	When I click on "<part_no>" in the same row as "<part_no>"
	
#	When I select "Responded" from Process reply
#	And I set the radio button to "Accept juror as responded"
#
#	And I press the "Mark as completed" button
	And I see "COMPLETED" on the page
	
	Then on "JUROR_DIGITAL" . "JUROR_RESPONSE" I see "PROCESSING_STATUS" is "CLOSED" where "JUROR_NUMBER" is "<part_no>"
	Then on "JUROR_DIGITAL" . "JUROR_RESPONSE" I see "PROCESSING_COMPLETE" is "Y" where "JUROR_NUMBER" is "<part_no>"
	
	#JDB-3453
	
	Then on "JUROR" . "POOL" I see "WELSH" is "Y" where "part_no" is "<part_no>"
	
Examples:
	|part_no	|last_name	|postcode	|email 		| pool_no	|
	|645700813	|LastNameB	|SA1 4PF	|b@eeee.com	| 457170401	|