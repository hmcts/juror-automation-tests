Feature: Regression Welsh_3rd_Excusal

@RegressionWelsh @JDB-3044 @JDB-3609 @JDB-3612 @JDB-3653 @JDB-3826 @JDB-3869 
Scenario Outline: Welsh 3rd Party Excusal
	Given I am on the welsh version of "Public" "juror-test02"
	Given the juror numbers have not been processed
		| part_no 	| pool_no 	| owner |
		| <part_no> |<pool_no>	| 400 	|

	And "<part_no>" has "LNAME" as "<last_name>" 
	And "<part_no>" has "RET_DATE" as "5 mondays time"
	And "<part_no>" has "NEXT_DATE" as "5 mondays time"
	And "<part_no>" has "ZIP" as "<postcode>"

	And I set the radio button to "Rwy'n ymateb ar ran rhywun arall"
	And I press the "Parhau" button

	#JDB-3869 test

	Then I see "Ei fanylion rheithiwr" on the page
	And I see "Gallwch ddod o hyd i'r rhif rheithiwr ar y llythyr gwŷs rheithgor." on the page
	And I see "Rhowch enw olaf yr unigolyn fel y mae wedi'i nodi ar eu llythyr gwŷs rheithgor, hyd yn oed os yw'n anghywir. Gallwch ei newid nes ymlaen." on the page
	And I see "Rhowch eu cod post fel y mae wedi'i nodi ar eu llythyr gwŷs rheithgor, hyd yn oed os yw'n anghywir. Gallwch ei newid nes ymlaen." on the page
	When I set "Rhif rheithiwr" to "<part_no>"
	When I set "Cyfenw" to "<last_name>"
	When I set "Cod post Rheithiwr" to "<postcode>"
	And I press the "Parhau" button

	#3rd Party Name

	Then I see "Eich Manylion" on the page
	When I set "Enw cyntaf" to "FirstNamea"
	And I set "Cyfenw" to "LastNameb"
	And I press the "Parhau" button
	Then I see "Eich perthynas â'r unigolyn" on the page
	
	#Relationship to Juror
	
	When I set "Sut ydych chi'n adnabod yr unigolyn rydych yn ymateb ar ei ran?" to "Friend"
	And I press the "Parhau" button
	Then I see "Eich manylion cyswllt" on the page
	
	#3rd Party Contact
	
	When I check the "Dros y ffôn (rhifau yn y DU yn unig)" checkbox
	And I set "Prif rif ffôn" to "02078211818"
	And I check the "Trwy e-bost" checkbox
	And I set "Nodwch gyfeiriad e-bost" to "email@outlook.com"
	When I set "Nodwch gyfeiriad e-bost eto" to "email@outlook.com"
	And I press the "Parhau" button
	Then I see "Pam ydych chi'n ymateb ar ran yr unigolyn arall?" on the page

	#Why are you replying

	And I see "Nid yw'r unigolyn yn gallu ymateb dros ei hun" on the page
	And I see "Nid yw'r unigolyn â'r gallu i ymateb drosto'i hun. Efallai bod hyn oherwydd bod ganddo anabledd neu nam." on the page
	
	And I set the radio button to "Nid yw'r unigolyn yn gallu ymateb dros ei hun"
	And I press the "Parhau" button
	Then I see "A yw'r enw sydd gennym ar ei gyfer yn gywir?" on the page
	
	#Check Juror's Name JDB-3826
	
	And I set the radio button to "Na"
	And I press the "Parhau" button
	When I click on the "Beth fydd yn digwydd os ydyw wedi newid ei enw?" link
	And I see "Os yw ei enw wedi newid, byddwn yn cysylltu â chi i wirio hynny. Efallai y byddwn yn gofyn am dystysgrif briodas, tystysgrif partneriaeth sifil neu weithred newid enw." on the page
	And I press the "Parhau" button
	Then I see "Ei gyfeiriad ef yw hwn?" on the page
	
	#Check Juror's Address
	
	And I set the radio button to "Na"
	And I press the "Parhau" button
	When I click on the "Beth fydd yn digwydd os ydyw wedi newid ei gyfeiriad?" link
	And I see "Os yw ei gyfeiriad wedi newid, efallai y byddwn yn gallu symud ei wasanaeth rheithgor i Lys yn nes at ei gyfeiriad newydd." on the page
	And I see "Byddwn yn cysylltu ag ef yn ddiweddarach ynglŷn â hyn. Parhewch i ddefnyddio'r ffurflen ar-lein ar hyn o bryd." on the page
	And I press the "Parhau" button
	Then I see "Nodwch ddyddiad geni'r unigolyn rydych chi'n ymateb ar ei ran" on the page
	
	#DoB
	
	When I click on the "Cymorth gyda'ch dyddiad geni" link
	And I see "Nodwch ddyddiad geni'r unigolyn er mwyn i ni wirio os ydynt o'r oedran priodol i wasanaethu ar reithgor." on the page
	And I see "Os nad yw'r unigolyn yn gwybod ei union ddyddiad geni, defnyddiwch yr un maent yn ei nodi ar ddogfennau swyddogol megis pasbort neu drwydded yrru." on the page
	And I see "Os na allwch roi dyddiad geni ar gyfer yr unigolyn, efallai y bydd yn rhaid ichi anfon copïau o ddogfennau adnabod drwy'r post. Bydd yn rhaid i chi ymateb i'r wŷs gan ddefnyddio'r ffurflen a anfonwyd drwy'r post yn hytrach nag ar-lein. Os oes arnoch angen cymorth, ffoniwch ni ar:" on the page
	And I see "Rhif ffôn: 0300 456 1024" on the page
	And I see "Llinell Gymraeg: 0300 303 5173" on the page
	And I set "Diwrnod" to "27"
	And I set "Mis" to "04"
	
	#I want to set the year dynamically to current year - 40

	And I set "Blwyddyn" to "1978"
	And I press the "Parhau" button
	
	Then I see "Efallai bydd yn rhaid inni gysylltu â'r unigolyn i ofyn rhagor o gwestiynau neu roi rhagor o wybodaeth iddynt am eu gwasanaeth rheithgor" on the page

	#Contacting the juror
	
	When I see "Manylion y Rheithiwr" on the page
	And I set the radio button to "Defnyddio'r rhif ffôn rydych eisoes wedi'i ddarparu i gysylltu â chi"
	
	#Checking field
	
	And I set the radio button to "Rhoi cyfeiriad e-bost gwahanol ar gyfer y rheithiwr"
	And I see "Nodwch gyfeiriad e-bost" on the page
	
	And I set the radio button to "Defnyddio'r cyfeiriad e-bost rydych eisoes wedi'i ddarparu i gysylltu â chi"
	And I press the "Parhau" button
	Then I see "Cadarnhau a yw'r unigolyn yn gymwys i wasanaethu ar reithgor" on the page
	
	When I press the "Parhau" button
	And I set the radio button to "Do"
	And I press the "Parhau" button
	And I set the radio button to "Nac ydy"
	And I press the "Parhau" button
	And I set the radio button to "Nac ydy"
	And I press the "Parhau" button
	And I set the radio button to "Nac ydy"
	And I press the "Parhau" button
	And I set the radio button to "Na"
	And I press the "Parhau" button
	And I set the radio button to "Na"
	And I press the "Parhau" button
	Then I see "Gwiriwch eich dyddiad dechrau" on the page
	
	#Can you attend, select excusal
	
	And I set the radio button to "Nac ydi, ni all yr unigolyn wasanaethu ar reithgor a rhaid esgusodi"
	And I press the "Parhau" button
	
	#Reason for excusal JDB-3653

	And I see "steps/confirm-date/excusal/tp" in the URL
	Then I see "Pam fod angen iddo gael ei esgusodi rhag gwasanaethu ar reithgor?" on the page
	And I see "Eglurwch pam na all wasanaethu ar reithgor yn ystod y 12 mis nesaf." on the page
	And I see "Nid oes angen ichi atodi na chasglu tystiolaeth cyn dyddiad terfyn yr wŷs." on the page
	And I see "Byddwn yn cysylltu yn nes ymlaen os bydd angen hynny." on the page
	
	And I click on the "A fydd angen inni ddarparu tystiolaeth yn fuan?" link
	And I see "Os bydd angen tystiolaeth arnom, byddwn yn cysylltu â chi eto i ddweud wrthych." on the page
	And I see "Er enghraifft, os yw'n rhy wael i wasanaethu ar reithgor, efallai y byddwn yn gofyn am lythyr doctor." on the page
	And I see "Bydd yn cael amser i gasglu unrhyw dystiolaeth felly peidiwch â phoeni am geisio ei chasglu ar hyn o bryd." on the page
	And I see "Arhoswch nes byddwn wedi dweud wrthych pa dystiolaeth yr ydym ei hangen, os o gwbl." on the page

	And I press the "Parhau" button
	Then I see "Rhowch y rheswm pam na all wasanaethu ar reithgor yn ystod y 12 mis nesaf" on the page
	
	When I set text area with "id" of "excusalReason" to "Excusal reason"
	And I press the "Parhau" button
	
	#RA

	And I set the radio button to "Nac oes"
	When I press the "Parhau" button
	
	#Check Your Answers

	Then I see "Gwiriwch eich ymatebion nawr" on the page
	
	And I see "Pam fod angen iddo gael ei esgusodi rhag gwasanaethu ar reithgor?" on the page
	
	Then I check the "wybodaeth rwyf wedi ei rhoi am yr unigolyn rwyf yn ymateb ar ei ran yn gywir." checkbox
	When I press the "Cyflwyno" button
	
	Then I see "Rydych wedi cwblhau'r broses ymateb" on the page
	Then I see "Rydych wedi cwblhau'r broses ymateb" on the page
	Then I see "<part_no>" on the page
	
	#JDB-3612
	
	And I see "Beth fydd yn digwydd nesaf" on the page
	And I see "Byddwn yn ysgrifennu at yr unigolyn rydych wedi ymateb ar ei ran yn y 7 diwrnod nesaf i roi gwybod iddynt os oes rhaid iddynt wasanaethu ar reithgor neu os gallant gael eu hesgusodi." on the page
	And I see "Os oes rhaid iddynt wasanaethu ar reithgor, byddwn yn anfon y canlynol atynt o leiaf bythefnos cyn iddo ddechrau:" on the page
	And I see "llythyr yn cadarnhau dyddiad y gwasanaeth rheithgor" on the page
	And I see "pecyn gwybodaeth am fod yn rheithiwr a'r llys byddant yn mynd iddo" on the page
	
	#JDB-3609
	
	And I see "Gallwch chi, neu'r unigolyn rydych wedi ymateb ar ei ran, wylio fideo am beth sy'n digwydd wrth fod yn rheithiwr ar YouTube, fel eu bod yn gwybod beth i'w ddisgwyl. Mae'r fideo'n para 13 munud." on the page
	And I see "Rhagor o wybodaeth am wasanaethu ar reithgor. Gallwch darllenwch y rheolau ynghylch trafod y treial a chanfod sut i hawlio am gostau." on the page
	And I see "Chyfrifo pa dreuliau a lwfansau y gallwch eu hawlio." on the page
	And I do not see "Eich Canllaw i'r Gwasanaeth Rheithgor (PDF 85KB)" on the page
	And I see "Beth yw eich barn am y gwasanaeth hwn? (30 eiliad o'ch amser)" on the page
	
	Then I click on the "Lawrlwythwch gopi o'ch ymateb i'r wŷs HTML (15KB)" link
	And I see "Pam fod angen iddo gael ei esgusodi rhag gwasanaethu ar reithgor?" on the page
	
Examples:
	|part_no	|last_name		|postcode	|email 		|pool_no	|
	|641500336	|LNAMESIXSIXZERO|CH1 2AN	|a@eeee.com	|415170601	|