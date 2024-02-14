Feature: Regression Welsh Cookie Policy

@RegressionWelsh @JDB-4533 
Scenario Outline: Welsh Cookie Policy
	Given I am on the welsh version of "Public" "bau-test"
	Given the juror numbers have not been processed
		| part_no 	| pool_no 	| owner |
		| <part_no> |<pool_no>	| 400 	|
		
	And "<part_no>" has "LNAME" as "<last_name>" 
	And "<part_no>" has "ZIP" as "<postcode>"
	And "<part_no>" has "RET_DATE" as "5 mondays time"
	And "<part_no>" has "NEXT_DATE" as "5 mondays time"
	
	#Cookies Policy
	
	And I click on the "Cwcis" link
	
	#Opens new tab
	
	And on the page I see
	|text|
	|Cwcis|
	|Ffeiliau a gedwir ar eich ffôn, eich tabled neu'ch cyfrifiadur pan fyddwch chi'n ymweld â gwefan yw cwcis.|
	|Rydym yn defnyddio cwcis i storio gwybodaeth am sut rydych yn defnyddio gwefan GOV.UK, megis y tudalennau yr ydych yn ymweld â hwy.|
	|Gosodiadau cwcis|
	|Rydym yn defnyddio 2 fath o gwcis. Gallwch ddewis pa gwcis yr ydych yn hapus inni eu defnyddio.|
	|Cwcis sy'n mesur y defnydd a wneir o wefan|
	|Rydym yn defnyddio Google Analytics i fesur sut rydych yn defnyddio'r wefan fel y gallwn ei gwella yn seiliedig ar anghenion defnyddwyr. Nid ydym yn caniatáu i Google ddefnyddio neu rannu'r data am sut rydych yn defnyddio'r wefan hon.|	
    |Mae Google Analytics yn gosod cwcis sy'n storio gwybodaeth gyffredinol am:|
    |sut y daethoch i'r wefan hon|
    |y tudalennau rydych chi'n ymweld â nhw ar GOV.UK a gwasanaethau digidol y Llywodraeth, a pha mor hir rydych chi'n ei dreulio ar bob tudalen|
    |beth rydych chi'n clicio arno tra byddwch yn ymweld â'r wefan|
    |Cwcis hanfodol yn unig|
    |Mae'r cwcis hanfodol hyn yn gwneud pethau fel cofio lle'r oeddech wedi cyrraedd wrth lenwi ffurflen (er enghraifft cais am drwydded)|
    |Mae'r cwcis hanfodol hyn yn gwneud pethau fel cofio lle'r oeddech wedi cyrraedd wrth lenwi ffurflen (er enghraifft cais am drwydded)|
    
    And the radio button "Derbyn cwcis" is "selected"
    And the radio button "Peidio" is "unselected"
	
	And I click on the "Sut rydym yn defnyddio cwcis" link
				
	Then I see "Mesur defnydd o’r wefan (Google Analytics)" on the page
	
	Then I see "Mae meddalwedd Google Analytics yn casglu gwybodaeth am sut byddwch yn defnyddio'r wefan. Rydym yn gwneud hyn i helpu sicrhau bod y wefan yn cwrdd ag anghenion y defnyddwyr ac i’n helpu ni i wneud gwelliannau." on the page
	Then I see "Mae Google Analytics yn gallu casglu gwybodaeth am eich demograffig, megis eich oedran, eich rhyw, eich lleoliad â’ch dewis iaith." on the page
	Then I see "Mae’r adroddiadau yn rhoi gwybodaeth i ni am y ddyfais rydych yn ei ddefnyddio i gael mynediad at y wefan, pa borwr rydych yn ei ddefnyddio, a fersiwn y system weithredu sy'n cael ei defnyddio. Mae hyn yn ein cynorthwyo i sicrhau bod y wefan yn gweithio i bawb." on the page
            
	Then I see "Yn benodol, rydym yn cofnodi sawl gwaith y mae ein dogfennau PDF yn cael eu lawrlwytho, sawl gwaith y mae defnyddwyr yn gadael y wefan trwy glicio ar ddolenni allanol, a’r nifer o bobl sy’n clicio ar y dolenni 'Rhagor o wybodaeth' sydd wedi'u rhestru wrth ymyl rhai o’r cwestiynau ar ein gwefan." on the page

    And I see "Mae’r holl ddata rydym yn eu casglu yn ddienw, ac nid oes gennym fynediad at unrhyw ddata all eich adnabod yn bersonol." on the page 
	        
	And I see "Rydym yn defnyddio’r wybodaeth hon i wella'r gwasanaeth a'n perfformiad yn ogystal â chynnal dadansoddi pellach" on the page
		
	Then I see "Mae’r cwcis canlynol yn cael eu defnyddio:" on the page
	
	And I see "Enw" in the same row as "Diben"
	And I see "Diben" in the same row as "Enw"
	
	Then I see "Mae’r rhain yn ein helpu i weld sut yr ydych chi’n defnyddio GOV.UK er mwyn gwella’r wefan" in the same row as "_gat"
	And I see "2 flynedd" in the same row as "_ga"
	Then I see "24 awr" in the same row as "_gid"
	
	And I see "Daw i ben" in the same row as "Enw"
	
	Then I see "1 munud" in the same row as "_gat"
	Then I see "Mae’r rhain yn ein helpu i weld sut yr ydych chi’n defnyddio GOV.UK er mwyn gwella’r wefan" in the same row as "_ga"
	Then I see "Mae’r rhain yn ein helpu i weld sut yr ydych chi’n defnyddio GOV.UK er mwyn gwella’r wefan" in the same row as "_gid"
	
	And I see "Gallwch chi ddewis peidio derbyn cwcis Google Analytics." on the page
	Then I click on the "ddewis peidio derbyn cwcis Google Analytics." link
	Then I see "cookie-settings" in the URL
	Then I press the "back" button on my browser
	
	And I see "Sesiynau" on the page 
	And I see "Mae cwci yn cael ei osod i gofnodi eich gweithgaredd yn ystod y sesiwn." on the page

	Then I see "Enw" in the same row as "Diben"
	
	Then I see "Nodi p’un a ydych wedi mewngofnodi ai peidio" in the same row as "sessionID"
	Then I see "Fe’i defnyddir i’ch cyfeirio’n ôl at yr un gweinyddwr ar gyfer pob cais" in the same row as "ApplicationGatewayAffinity"
	
	Then I see "Diben" in the same row as "Enw"
	
	Then I see "Daw i ben" in the same row as "Enw"
	And I see "Pan fyddwch chi’n cau’ch porwr" in the same row as "sessionID"
	And I see "Pan fyddwch chi’n cau’ch porwr" in the same row as "ApplicationGatewayAffinity"

    Then I see "Ein harolwg adborth" on the page
    Then I see "Rydym yn defnyddio SmartSurvey i alluogi defnyddwyr y gwasanaeth i roi adborth am eu profiadau ar ddefnyddio’r gwasanaeth." on the page
    Then I see "Ceir rhagor o fanylion am bolisi diogelwch a chyfrinachedd SmartSurvey yn:" on the page
    
    Then I click on the "https://www.smartsurvey.co.uk/security" link
    And I see "www.smartsurvey.co.uk/security" in the URL
    Then I press the "back" button on my browser
    
	Then I see "Byddwn yn defnyddio canlyniadau’r ymatebion i’r arolwg i roi gwybodaeth inni am eich profiad o ddefnyddio'r gwasanaeth, bydd hyn yn ein galluogi i ystyried sut allwn wella'r gwasanaeth ymhellach." on the page
	
	Then I see "Mae’r holl ddata rydym yn eu casglu yn ddienw, ac nid oes gennym fynediad at unrhyw ddata all eich adnabod yn bersonol." on the page
	Then I see "Os byddwch yn cymryd rhan, bydd SmartSurvey yn cadw rhagor o gwcis ar eich cyfrifiadur i ddilyn eich cynnydd trwy'r arolwg. Mae SmartSurvey yn cael ei ddefnyddio i gasglu’r ymatebion i’r arolwg. Os byddwch yn cymryd rhan, bydd SmartSurvey yn cadw rhagor o gwcis ar eich cyfrifiadur i ddilyn eich cynnydd trwy'r arolwg. Ceir gwybodaeth am sut mae SmartSurvey yn defnyddio Cwcis yn:" on the page	
	Then I click on the "https://www.smartsurvey.co.uk/how-we-use-cookies" link
	And I see "/how-we-use-cookies" in the URL
	Then I press the "back" button on my browser
	
	#Translations not arrived yet
   
    #Then I see "Change your settings" on the page 
    #Then I see "You can change which cookies you're happy for us to use" on the page
    #Then I click on the "change which cookies you're happy for us to use" link
    #Then I press the "back" button on my browser
    
Examples:
	|part_no	|last_name	|postcode	|pool_no	|
	|641500567	|LastNameB	|SW1H 9AJ	|415170401	|


@RegressionWelsh @JDB-4533 
Scenario Outline: Welsh 1st Party Cookies Polciy on each Page
	Given I am on the welsh version of "Public" "test"
	Given the juror numbers have not been processed
		| part_no 	| pool_no 	| owner |
		| <part_no> |<pool_no>	| 400 	|
		
	And "<part_no>" has "LNAME" as "<last_name>" 
	And "<part_no>" has "ZIP" as "<postcode>"
	And "<part_no>" has "RET_DATE" as "5 mondays time"
	And "<part_no>" has "NEXT_DATE" as "5 mondays time"

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
	
	When I set "Rhif rheithiwr" to "<part_no>"
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
	|part_no	|last_name			|postcode	|email 		|pool_no	|
	|641500227	|LNAMETWOTWOSEVEN	|CH1 2AN	|e@mail.com	|415170402	|
	
@RegressionWelsh @JDB-4533 
Scenario Outline: Welsh 3rd Party Cookies Policy on each page
	Given I am on the welsh version of "Public" "test"
	Given the juror numbers have not been processed
		| part_no 	| pool_no 	| owner |
		| <part_no> |<pool_no>	| 400 	|
	
	And "<part_no>" has "LNAME" as "<last_name>" 
	And "<part_no>" has "RET_DATE" as "5 mondays time"
	And "<part_no>" has "NEXT_DATE" as "5 mondays time"
	And "<part_no>" has "ZIP" as "<postcode>"

	And I set the radio button to "Rwy'n ymateb ar ran rhywun arall"
	And I see link with text "Cwcis" 
	And I press the "Parhau" button	
	
	#Juror Log In JDB-3808 and JDB-3940
	
	When I click on the "Nid oes gennyf rif rheithiwr ar gyfer yr unigolyn" link
	Then I see "Rhif ffôn: 0300 456 1024" on the page
	And I see "Llinell Gymraeg: 0300 303 5173" on the page
	
	When I set "Rhif rheithiwr" to "<part_no>"
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
	|part_no		|last_name			|postcode	|pool_no	|
	|641500184		|LNAMEONEEIGHTFOUR	|CH1 2AN	|415170402	|
	