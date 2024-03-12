Feature: Regression Welsh Accessibility Statement

@RegressionWelsh @JDB-4546 
Scenario: Welsh Accessibility Statement
	
	Given I am on the welsh version of "Public" "bau-test"

  	#Accessibility Statement

   	And I click on the "Datganiad hygyrchedd" link
   	And I switch to the new window

   	And I see "Datganiad hygyrchedd ar gyfer y gwasanaeth Ymateb i Wŷs Rheithg" on the page
   	And I see "Datganiad hygyrchedd ar gyfer y gwasanaeth Ymateb i Wŷs Rheithgor yn" on the page
   	And I click on the "gov.uk/reply-jury-summons" link
   	And I see "reply-jury-summons" in the URL
   	Then I press the "back" button on my browser
   
   	And I see "Mae'r wefan hon yn cael ei chynnal gan Wasanaeth Llysoedd a Thribiwnlysoedd EF (GLlTEF). Rydym eisiau i gynifer o bobl â phosibl allu defnyddio'r wefan hon. Er enghraifft, mae hynny'n golygu y dylech allu:" on the page
   	And I see "newid lliwiau, lefelau cyferbyniad a ffontiau" on the page
   	And I see "gwneud y testun hyd at 300% yn fwy heb iddo ddiflannu oddi ar y sgrin" on the page
   	And I see "defnyddio'r rhan fwyaf o'r wefan gan ddefnyddio bysellfwrdd yn unig" on the page
   	And I see "defnyddio'r rhan fwyaf o'r wefan gan ddefnyddio meddalwedd adnabod llais" on the page
   	And I see "gwrando ar y rhan fwyaf o'r testun ar y wefan gan ddefnyddio darllenydd sgrin (gan gynnwys y fersiynau diweddaraf o JAWS, NVDA a VoiceOver)" on the page
   	And I see "Rydym hefyd wedi sicrhau ein bod wedi defnyddio iaith syml." on the page
   	And I see "roi cyngor ichi ar sut i wneud eich dyfais yn haws i'w defnyddio os oes gennych anabledd." on the page
   	And I click on the "AbilityNet" link
   	And I see "abilitynet" in the URL
   	Then I press the "back" button on my browser
   
   	Then I see "Pa mor hygyrch yw'r wefan hon?" on the page
   	And I see "Mae'r wefan hon wedi cael ei harchwilio'n annibynnol ar gyfer hygyrchedd ac nid ydym yn ymwybodol o unrhyw rannau o'r wefan hon nad ydynt yn gwbl hygyrch." on the page
   	And I see "Riportio problemau hygyrchedd gyda'r wefan hon" on the page
  	Then I see "Rydym bob amser yn ceisio gwella hygyrchedd y wefan hon. Os ydych yn dod o hyd i unrhyw broblemau nad ydynt wedi'u rhestru ar y dudalen hon neu'n credu nad ydym yn bodloni gofynion hygyrchedd:" on the page
   
   	Then I see "anfonwch e-bost i jurysummoning@justice.gov.uk" on the page
   	Then I see "ffoniwch 0300 303 5173" on the page
   	Then I see "neu ysgrifennwch atom yn:" on the page
   	Then I see "Jury Central Summoning Bureau" on the page
   	Then I see "Phoenix House" on the page
   	Then I see "Rushton Avenue" on the page
   	Then I see "Bradford" on the page
   	Then I see "BD3 7BH" on the page
   
   	Then I see "Y Weithdrefn Orfodi" on the page
   	Then I see "Y Comisiwn Cydraddoldeb a Hawliau Dynol (EHRC) sy’n gyfrifol am orfodi Rheoliadau Hygyrchedd Cyrff y Sector Cyhoeddus (Gwefannau ac Apiau Ffonau Symudol) (Rhif 2) 2018 (y 'rheoliadau hygyrchedd'). Os nad ydych yn hapus â'r ffordd rydym yn ymateb i'ch cwyn," on the page
   	And I click on the "cysylltwch â'r Gwasanaeth Cynghori a Chefnogi Cydraddoldeb (EASS)" link
   	And I see "equalityadvisoryservice" in the URL
   	Then I press the "back" button on my browser
   
   	Then I see "Cysylltu â ni drwy e-bost neu dros y ffôn" on the page
   	And I see "Gallwch gysylltu â'n tîm gwasanaeth cwsmeriaid yn y Swyddfa Ganolog Gwysio Rheithgor drwy:" on the page
   And I see "anfon e-bost i jurysummoning@justice.gov.uk" on the page
   	And I see "ffonio 0300 303 5173" on the page
   
   	Then I see "Gwybodaeth dechnegol am hygyrchedd y wefan hon" on the page
   	Then I see "Mae GLlTEM wedi ymrwymo i sicrhau bod y wefan yn hygyrch, yn unol â Rheoliadau Hygyrchedd Cyrff y Sector Cyhoeddus (Gwefannau ac Apiau Ffonau Symudol) (Rhif 2) 2018." on the page
   
   	Then I see "Statws Cydymffurfio" on the page
   	Then I see "Mae'r wefan hon yn cydymffurfio'n llwyr â Chanllawiau Hygyrchedd Cynnwys y We fersiwn 2.1 safon AA." on the page	
   	And I click on the "Chanllawiau Hygyrchedd Cynnwys y We fersiwn 2.1" link
   	And I see "WCAG21" in the URL
   	Then I press the "back" button on my browser
   
   	And I see "Paratoi'r datganiad hygyrchedd hwn" on the page
   	And I see "Paratowyd y datganiad hwn ar y 27 Awst 2020. Fe'i adolygwyd ddiwethaf ar y 14 Mehefin 2023." on the page
   	And I see "Cafodd y wefan hon ei phrofi diwethaf ar yr 8 Mehefin 2023. Cynhaliwyd y prawf gan Digital Accessibility Centre Ltd." on the page
    And I see "Os oes angen copi o'r adroddiad prawf hygyrchedd llawn arnoch cysylltwch â Andrew Singleton Bisby." on the page
#   	Then I see "Gallwch ddarllen adroddiad llawn y prawf hygyrchedd yma." on the page
#   	And I click on the "ddarllen adroddiad llawn y prawf hygyrchedd yma" link
#   	And I see "accessibility-statement/report" in the URL
#   	Then I press the "back" button on my browser
	
@RegressionWelsh @JDB-4546  
Scenario Outline: Welsh 1st Party - Accessibility Statement on each page

	Given I am on the welsh version of "Public" "juror-test02"
	Given the juror numbers have not been processed
		| part_no 	| pool_no 	| owner |
		| <part_no> |<pool_no>	| 400 	|
		
	And juror "<juror_number>" has "LAST_NAME" as "<last_name>" new schema
	And juror "<juror_number>" has "POSTCODE" as "<postcode>" new schema



	And I set the radio button to "n ymateb dros fy hun"
	And I press the "Parhau" button
	Then I see "Eich manylion rheithiwr" on the page
	And I see link with text "Datganiad hygyrchedd"
	
	#Login JDB-3808
	
	When I click on the "Nid oes gennyf rif rheithiwr" link
	Then I see "Gallwch ddod o hyd i'ch rhif rheithiwr ar eich llythyr gwŷs rheithgor." on the page
	And I see link with text "Datganiad hygyrchedd"
	
	#JDB-3939
	
	And I see "Rhif ffôn: 0300 456 1024" on the page
	And I see "Llinell Gymraeg: 0300 303 5173" on the page
	
	And I see "Rhowch eich enw olaf fel y mae wedi'i nodi ar y llythyr gwŷs rheithgor, hyd yn oed os yw'n anghywir. Gallwch ei newid nes ymlaen." on the page
			  
	And I see "Rhowch eich cod post fel y mae wedi'i nodi ar y llythyr gwŷs rheithgor, hyd yn oed os yw'n anghywir. Gallwch ei newid nes ymlaen." on the page
	
	When I set "Rhif rheithiwr" to "<juror_number>"
	When I set "Cyfenw" to "<last_name>"
	When I set "Cod post Rheithiwr" to "<postcode>"
	And I press the "Parhau" button
	
	#Check Your Name
	
	And I see link with text "Datganiad hygyrchedd"	
	And I set the radio button to "Nac ydy"
	And I press the "Parhau" button
	
	Then I set "Enw cyntaf" to "FirstNameA"
	And I set "Cyfenw" to "LastNameB"
	And I click on the "Beth sy'n digwydd os rwyf wedi newid fy enw?" link
	And I see "Os yw eich enw chi wedi newid, byddwn yn cysylltu â chi i wirio hynny. Efallai y byddwn yn gofyn am dystysgrif briodas, tystysgrif partneriaeth sifil neu weithred newid enw." on the page
	And I press the "Parhau" button
	And I see link with text "Datganiad hygyrchedd"
	
	#Check Your Address JDB-3809
	
	Then on the page I see
		| text	|
		| Eich Manylion |
		| Eich cyfeiriad chi yw hwn? |
		
	And I set the radio button to "Ie"
	And I do not see "Gwiriwch fod eich enw a'r cyfeiriad yn gywir" on the page	
	When I press the "Parhau" button
	And I see link with text "Datganiad hygyrchedd"
	
	#Phone
	
	Then on the page I see
		| text	|
		| Eich Manylion |
		| Beth yw eich rhif ffôn? |
		| Prif rif ffôn |
		| Rhif ffôn arall (dewisol) |
	
	When I set "Prif rif ffôn" to "0207 821 1818"
	And I press the "Parhau" button
	And I see link with text "Datganiad hygyrchedd"
	
	#Email

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
	And I see link with text "Datganiad hygyrchedd"
	
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
	And I see link with text "Datganiad hygyrchedd"
	
	#Qualify for jury service
	
	Then I see "Cadarnhau a ydych yn gymwys i wasanaethu ar reithgor" on the page
	When I press the "Parhau" button
	And I see link with text "Datganiad hygyrchedd"
	
	#Residency JDB-3909
	
	Then I see "Ers i chi droi'n 13 oed, a yw eich prif gyfeiriad wedi bod yn y DU, Ynysoedd y Sianel neu Ynys Manaw am unrhyw gyfnod o 5 mlynedd o leiaf?" on the page
	When I click on the "A ydych angen cymorth i ateb hyn?" link
	Then I see "Rhaid i chi gysylltu â ni i gael cyngor ar eich sefyllfa benodol." on the page
	And I see "Rhif ffôn: 0300 456 1024" on the page
	And I see "Llinell Gymraeg: 0300 303 5173" on the page
	
	And I see "Cymhwysedd" on the page
	And I set the radio button to "Naddo"
	And I set the radio button to "Do"
	And I press the "Parhau" button
	And I see link with text "Datganiad hygyrchedd"
	
	#CJS JDB-3873
	
	Then I see "A ydych chi wedi gweithio yn y system cyfiawnder troseddol yn y 5 mlynedd diwethaf?" on the page
	When I set the radio button to "Nac ydw"
	And I press the "Parhau" button
	And I see link with text "Datganiad hygyrchedd"
	
	#Bail
	
	Then I see "Ydych chi ar fechnïaeth ar hyn o bryd am gyflawni trosedd?" on the page
	When I see "Cymhwysedd" on the page
	And I set the radio button to "Nac ydw"
	And I press the "Parhau" button
	And I see link with text "Datganiad hygyrchedd"
	
	#Convictions JDB-3814
	
	Then I see "Ydych chi wedi'ch cael yn euog o drosedd?" on the page
	When I see "Cymhwysedd" on the page
	When I click on the "Canllawiau mewn perthynas â gwasanaethu ar reithgor os oes gennych euogfarn" link
#	Then I see "NI ALLWCH" on the page
#	And "NI ALLWCH" text is bold
	And I see "dedfryd o garchar neu gadw yn y ddalfa am 5 mlynedd neu fwy" on the page
	And I see "dedfryd o garchar ar gyfer diogelu'r cyhoedd neu gadw yn y ddalfa er mwyn diogelu'r cyhoedd" on the page
	When I set the radio button to "Naddo"
	And I press the "Parhau" button
	And I see link with text "Datganiad hygyrchedd"
	
	#Mental Health Sectioned
	
	Then I see "Ydych chi'n cael eich cadw, yn cael eich gwarchod neu eich trin o dan y Ddeddf Galluedd Meddyliol?" on the page
	When I see "Cymhwysedd" on the page
	And I set the radio button to "Na"
	And I press the "Parhau" button
	And I see link with text "Datganiad hygyrchedd"
	
	#Mental Health Capacity JDB-3812 and JDB-3813 JDB-3880
	
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
	And I press the "Parhau" button
	And I see link with text "Datganiad hygyrchedd"
	
	#Confirm attendance	

	Then I see "Gwiriwch eich dyddiad dechrau" on the page
	
	When I set the radio button to "Ydw, rydw i'n gallu dechrau"
	
	
	And I press the "Parhau" button
	And I see link with text "Datganiad hygyrchedd"
	
	#RA JDB-3815
	
	Then I see "A fyddech chi angen cymorth pan fyddwch yn y llys?" on the page
	When I set the radio button to "Nac oes"
	And I click on the "Pam ein bod yn gofyn am hyn?" link
	And I see "Os ydych yn pryderu am unrhyw beth arall ynghylch y gwasanaeth rheithgor o ran eich nam neu anabledd, yna cysylltwch â ni. Neu gallwch ofyn i rywun arall ffonio ar eich rhan." on the page
	And I see "Rhif ffôn: 0300 456 1024" on the page
	And I see "Llinell Gymraeg: 0300 303 5173" on the page
	And I press the "Parhau" button
	And I see link with text "Datganiad hygyrchedd"
	And I see "Gwiriwch eich ymatebion nawr" on the page
	
	#Check your answers JDB-3818 and JDB-3880
	
	When I see "Ydych chi'n cael eich cadw, yn cael eich gwarchod neu eich trin o dan y Ddeddf Galluedd Meddyliol?" on the page
	And I see "A benderfynwyd nad oes gennych y gallu meddyliol?" on the page
	And I see "Bu ichi ymateb i'r dyddiad arfaethedig ar gyfer eich gwasanaeth rheithgor" on the page
	Then I see text "Ie" in the same row as "A benderfynwyd nad oes gennych y gallu meddyliol?"
	And I see "Cadarnhewch ddyddiad eich gwasanaeth rheithgor" on the page
	
	#change MH capacity to No JDB-3880
	
	Then I click on the "Newid" link in the same row as "A benderfynwyd nad oes gennych y gallu meddyliol?"
	When I see "Cymhwysedd" on the page
	And I set the radio button to "Na"
	And I press the "Parhau" button
	And I see link with text "Datganiad hygyrchedd"
	When I see "Ydych chi'n cael eich cadw, yn cael eich gwarchod neu eich trin o dan y Ddeddf Galluedd Meddyliol?" on the page
	Then I see text "Na" in the same row as "A benderfynwyd nad oes gennych y gallu meddyliol?"
	And I see "Rwy'n deall efallai y bydd yr atebion a roddais yn cael eu gwirio a gellir fy erlyn os wyf wedi rhoi unrhyw wybodaeth y gwn ei bod yn anwir." on the page
	
	#submit
	
	And I check the "Mae'r wybodaeth a roddais uchod yn wir hyd eithaf fy ngwybodaeth." checkbox
	And I press the "Cyflwyno" button
	And I see link with text "Datganiad hygyrchedd"
	
	Then I see "O leiaf 2 wythnos cyn ichi ddechrau gwasanaethu ar reithgor, byddwn yn anfon y canlynol atoch:" on the page
	Then I do not see "Yna, o leiaf pythefnos cyn i’r gwasanaeth rheithgor ddechrau byddwn yn anfon y dogfennau canlynol atoch:" on the page
	Then I see "Gallwch wylio fideo am beth sy'n digwydd wrth fod yn rheithiwr ar YouTube, fel eich bod yn gwybod beth i'w ddisgwyl. Mae'r fideo'n para 13 munud." on the page


Examples:
	|part_no	|pool_no	|last_name			|postcode	|email 		| 
	|645200713	|452170401	|LNAMESEVENONETHREE	|SY2 6LU	|e@eeee.com	|
	

@RegressionWelsh @JDB-4546 
Scenario Outline: Welsh 3rd Party - Accessibility statement on each page
	Given I am on the welsh version of "Public" "juror-test02"
	Given the juror numbers have not been processed
		| part_no 	| pool_no 	| owner |
		| <part_no> |<pool_no>	| 400 	|
	
	And juror "<juror_number>" has "LAST_NAME" as "<last_name>" new schema


	And juror "<juror_number>" has "POSTCODE" as "<postcode>" new schema
	
	And I see link with text "Datganiad hygyrchedd"
	And I set the radio button to "Rwy'n ymateb ar ran rhywun arall"
	And I press the "Parhau" button
	And I see link with text "Datganiad hygyrchedd"
	
	#Juror Log In JDB-3808 and JDB-3940
	
	When I click on the "Nid oes gennyf rif rheithiwr ar gyfer yr unigolyn" link
	Then I see "Rhif ffôn: 0300 456 1024" on the page
	And I see "Llinell Gymraeg: 0300 303 5173" on the page
	
	When I set "Rhif rheithiwr" to "<juror_number>"
	When I set "Cyfenw" to "<last_name>"
	When I set "Cod post Rheithiwr" to "<postcode>"
	And I press the "Parhau" button
	And I see link with text "Datganiad hygyrchedd"
    Then I see "Beth yw eich enw?" on the page
	
	#3rd Party Name
	
	When I see "Eich Manylion" on the page
	When I set "Enw cyntaf" to "FirstNameA"
	And I set "Cyfenw" to "LastNameB"
	And I press the "Parhau" button
	And I see link with text "Datganiad hygyrchedd"
	Then I see "Eich perthynas â'r unigolyn" on the page
	
	#Relationship to juror
	
	When I see "Eich Manylion" on the page
	And I set "Sut ydych chi'n adnabod yr unigolyn rydych yn ymateb ar ei ran?" to "Friend"
	And I press the "Parhau" button
	And I see link with text "Datganiad hygyrchedd"
	Then I see "Eich manylion cyswllt" on the page
	
	#3rd Party Contact
	
	When I see "Eich Manylion" on the page
	And I check the "Dros y ffôn (rhifau yn y DU yn unig)" checkbox
	And I set "Prif rif ffôn" to "0207 821 1818"
	And I check the "Trwy e-bost" checkbox
	And I set "Nodwch gyfeiriad e-bost" to "email@outlook.com"
	And I set "Nodwch gyfeiriad e-bost eto" to "email@outlook.com"
	And I click on the "Os ydych yn byw dramor" link
	And I see "Os ydych yn byw dramor ar hyn o bryd a heb rif ffôn y DU, byddwn angen cysylltu â chi drwy ddefnyddio cyfeiriad e-bost." on the page
	And I press the "Parhau" button
	And I see link with text "Datganiad hygyrchedd"
	
	#Why are you replying title
	
	Then I see "Pam ydych chi'n ymateb ar ran yr unigolyn arall?" on the page
	And I do not see "Pam ydych chi'n ymateb?" on the page
	When I set the radio button to "Nid yw'r unigolyn yma"
	And I see "Efallai ei fod yn teithio, yn yr ysbyty, neu i ffwrdd am fwy nag ychydig ddyddiau am reswm arall." on the page
	And I see "Nid yw'r unigolyn yn gallu ymateb dros ei hun" on the page
	And I see "Nid yw'r unigolyn â'r gallu i ymateb drosto'i hun. Efallai bod hyn oherwydd bod ganddo anabledd neu nam." on the page
	And I press the "Parhau" button
	And I see link with text "Datganiad hygyrchedd"
	Then I see "A yw'r enw sydd gennym ar ei gyfer yn gywir?" on the page
	
	#Check juror name
	
	When I see "Manylion y Rheithiwr" on the page
	And I set the radio button to "Ydy"
	When I press the "Parhau" button
	And I see link with text "Datganiad hygyrchedd"
	
	#Check juror address
	
	And I set the radio button to "Ie"
	When I press the "Parhau" button
	And I see link with text "Datganiad hygyrchedd"
	
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
	And I press the "Parhau" button
	And I see link with text "Datganiad hygyrchedd"
	Then I see "Efallai bydd yn rhaid inni gysylltu â'r unigolyn i ofyn rhagor o gwestiynau neu roi rhagor o wybodaeth iddynt am eu gwasanaeth rheithgor" on the page
	
	#Contacting the juror
	
	When I see "Manylion y Rheithiwr" on the page
	And I set the radio button to "Defnyddio'r rhif ffôn rydych eisoes wedi'i ddarparu i gysylltu â chi"
	
	#Checking field JDB-3824
	
	And I set the radio button to "Rhoi cyfeiriad e-bost gwahanol ar gyfer y rheithiwr"
	And I see "Nodwch gyfeiriad e-bost" on the page
	
	And I set the radio button to "Defnyddio'r cyfeiriad e-bost rydych eisoes wedi'i ddarparu i gysylltu â chi"
	And I press the "Parhau" button
	And I see link with text "Datganiad hygyrchedd"

	#Qualify for jury service
	
	When I see "Cadarnhau a yw'r unigolyn yn gymwys i wasanaethu ar reithgor" on the page
	And I press the "Parhau" button
	And I see link with text "Datganiad hygyrchedd"
	
	#Residency JDB-3811 and JDB-3910
	
	Then I see "Ers iddynt droi'n 13 oed, a yw eu prif gyfeiriad wedi bod yn y DU, Ynysoedd y Sianel neu Ynys Manaw am unrhyw gyfnod o 5 mlynedd o leiaf?" on the page
	When I click on the "A ydych angen cymorth i ateb hyn?" link
	Then I see "Rhaid i chi gysylltu â ni i gael cyngor ar eu sefyllfa benodol." on the page
	Then I see "Rhif ffôn: 0300 456 1024" on the page
	And I see "Llinell Gymraeg: 0300 303 5173" on the page

	And I set the radio button to "Do"
	And I press the "Parhau" button
	And I see link with text "Datganiad hygyrchedd"
	
	#CJS no JDB-3822
	
	Then I see "A yw'r person yr ydych yn ymateb ar ei ran wedi gweithio yn y system cyfiawnder troseddol yn y 5 mlynedd diwethaf?" on the page
	When I set the radio button to "Ydy"
	And I set the radio button to "Nac ydy"
	And I press the "Parhau" button
	And I see link with text "Datganiad hygyrchedd"
	
	#Bail
	
	Then I see "A yw'r unigolyn ar fechnïaeth ar hyn o bryd am gyflawni trosedd?" on the page	
	When I see "Cymhwysedd" on the page
	And I set the radio button to "Nac ydy"
	And I press the "Parhau" button
	And I see link with text "Datganiad hygyrchedd"
	
	#Convictions
	
	Then I see "A yw'r unigolyn wedi'i gael yn euog o drosedd?" on the page
	When I see "Cymhwysedd" on the page
	And I click on the "Canllawiau mewn perthynas â gwasanaethu ar reithgor os oes gennych euogfarn" link
	Then I see "Pryd y gallant wasanaethu ar reithgor" on the page
	And I see "Dim ond os rhoddwyd dedfryd o garchar, gorchymyn cymunedol neu ddedfryd o garchar ohiriedig y mae hyn yn berthnasol." on the page
	When I set the radio button to "Nac ydy"
	And I press the "Parhau" button
	And I see link with text "Datganiad hygyrchedd"
	
	#Mental Health Sectioned
	
	Then I see "A ydi'r person yr ydych yn ymateb ar ei ran yn cael ei gadw, ei warchod neu ei drin o dan y Ddeddf Iechyd Meddwl?" on the page
	When I see "Cymhwysedd" on the page
	And I set the radio button to "Na"
	And I press the "Parhau" button
	And I see link with text "Datganiad hygyrchedd"
	
	#Mental Health Capacity JDB-3813
	
	Then I see "A wnaed penderfyniad nad oes gan y person yr ydych yn ymateb ar ei ran y 'gallu meddyliol'?" on the page
	When I see "Cymhwysedd" on the page
	And I click on the "Angen help i ateb hwn?" link
	And I see "Os nad oes gan rywun y gallu meddyliol, ni allant wasanaethu ar reithgor." on the page

	And I set the radio button to "Na"
	And I press the "Parhau" button
	And I see link with text "Datganiad hygyrchedd"

	#The person can attend
	
	Then I see "Gwiriwch eich dyddiad dechrau" on the page
	When I set the radio button to "Ydi, mae'r unigolyn yn gallu dechrau"

	And  I press the "Parhau" button
	And I see link with text "Datganiad hygyrchedd"
	
	#RA no JDB-3815
	
	Then I see "A fydd yr unigolyn rydych yn ymateb ar ei ran angen cymorth pan fydd yn y llys?" on the page
	When I set the radio button to "Nac oes"
	And I click on the "Pam ein bod yn gofyn am hyn?" link
	And I see "Os ydych yn pryderu am unrhyw beth arall ynghylch y gwasanaeth rheithgor o ran nam neu anabledd sydd gan yr unigolyn rydych yn ymateb ar ei ran, yna cysylltwch â ni." on the page
	And I see "Rhif ffôn: 0300 456 1024" on the page
	And I see "Llinell Gymraeg: 0300 303 5173" on the page
	And I press the "Parhau" button
	And I see link with text "Datganiad hygyrchedd"
	
	#Check your answers
	
	Then I see "Gwiriwch eich ymatebion nawr" on the page
	When I check the "Hyd gwn i, mae'r wybodaeth rwyf wedi ei rhoi am yr unigolyn rwyf yn ymateb ar ei ran yn gywir." checkbox
	And I press the "Cyflwyno" button
	And I see link with text "Datganiad hygyrchedd"

Examples:
	|part_no	|last_name			|postcode	|email           	|pool_no	|
	|641500676	|LNAMESIXSEVENSIX	|CH1 2AN	|email@outlook.com	|415170401	|
	
