Feature: Welsh_1st_CJS_Checks

@RegressionWelsh @JDB-3873 
Scenario Outline: Welsh 1st Party CJS buttons, Other and Check Answers checks
	Given I am on the welsh version of "Public" "juror-test02"
	Given the juror numbers have not been processed
		| part_no 	| pool_no 	| owner |
		| <part_no> |<pool_no>	| 400 	|
		
	And juror "<juror_number>" has "LAST_NAME" as "<last_name>" new schema


	And juror "<juror_number>" has "POSTCODE" as "<postcode>" new schema
	
	And I set the radio button to "n ymateb dros fy hun"
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
	And I press the "Parhau" button
	
	Then on the page I see
		| text	|
		| Eich Manylion |
		| A yw'r enw sydd gennym ar eich cyfer chi yn gywir? |
		
	And I set the radio button to "Nac ydy"
	And I press the "Parhau" button
	And I set "Enw cyntaf" to "FirstNameA"
	And I set "Cyfenw" to "LastNameB"
	And I click on the "Beth sy'n digwydd os rwyf wedi newid fy enw?" link
	
	And I see "Os yw eich enw chi wedi newid, byddwn yn cysylltu â chi i wirio hynny. Efallai y byddwn yn gofyn am dystysgrif briodas, tystysgrif partneriaeth sifil neu weithred newid enw." on the page
	And I press the "Parhau" button
	
	Then on the page I see
		| text	|
		| Eich Manylion |
		| Eich cyfeiriad chi yw hwn? |
		
	And I do not see "Gwiriwch fod eich enw a'r cyfeiriad yn gywir" on the page	
	And I set the radio button to "Ie"
	And I press the "Parhau" button
	
	Then on the page I see
		| text	|
		| Eich Manylion |
		| Beth yw eich rhif ffôn? |
		| Darparwch rif ffôn yn y DU y gallwn ei ddefnyddio i gysylltu â chi rhwng 9am a 5pm, dydd Llun i ddydd Gwener. |
		| Prif rif ffôn |
		| Rhif ffôn arall (dewisol) |
	
	When I set "Prif rif ffôn" to "0207 821 1818"
	And I press the "Parhau" button

	Then on the page I see
		| text|
		| Eich Manylion |
		| Beth yw eich cyfeiriad e-bost? |
		| Pam fod arnom angen eich cyfeiriad e-bost? |
	
	When I see "Pam fod arnom angen eich cyfeiriad e-bost?" on the page
	And I set "Nodwch eich cyfeiriad e-bost" to "email@outlook.com"
	And I set "Nodwch eich cyfeiriad e-bost eto" to "email@outlook.com"
	And I press the "Parhau" button

	Then on the page I see
		| text	|
		| Eich Manylion	|
		| Beth yw eich dyddiad geni? |
		| Cymorth gyda'ch dyddiad geni |
	
	When I click on the "Cymorth gyda'ch dyddiad geni" link
	Then I see "Mae angen i chi ddweud wrthym beth yw eich dyddiad geni er mwyn i ni wirio os ydych o'r oedran priodol i wasanaethu ar reithgor." on the page
	And I do not see "Nodwch ddyddiad geni'r unigolyn er mwyn i ni wirioos ydynt o'r oedran priodol i wasanaethu ar reithgor." on the page
	
	Then I see "Rhif ffôn: 0300 456 1024" on the page
	And I see "Llinell Gymraeg: 0300 303 5173" on the page
	
	When I set "Diwrnod" to "27"
	And I set "Mis" to "04"
	And I set "Blwyddyn" to "1978"
	And I press the "Parhau" button
	
	#Qualify for jury service
	
	Then I see "Cadarnhau a ydych yn gymwys i wasanaethu ar reithgor" on the page
	
	When I press the "Parhau" button
	
	#Residency
	
	Then I see "Ers i chi droi'n 13 oed, a yw eich prif gyfeiriad wedi bod yn y DU, Ynysoedd y Sianel neu Ynys Manaw am unrhyw gyfnod o 5 mlynedd o leiaf?" on the page
	When I click on the "A ydych angen cymorth i ateb hyn?" link
	Then I see "Rhif ffôn: 0300 456 1024" on the page
	And I see "Llinell Gymraeg: 0300 303 5173" on the page
	When I click on the "Cliciwch i fynd yn ôl" link
	
	And I see "yn meddwl nad ydych yn gymwys" on the page
	And I press the "Parhau" button
	
	#CJS JDB-3873
	
	Then I see "Ers i chi droi'n 13 oed, a yw eich prif gyfeiriad wedi bod yn y DU, Ynysoedd y Sianel neu Ynys Manaw am unrhyw gyfnod o 5 mlynedd o leiaf?" on the page
	When I set the radio button to "Do"
	
	And I press the "Parhau" button
	When I set the radio button to "Ydw"
	
	And I check the "Arall" checkbox
	And I set "Pa ran arall o’r System Cyfiawnder Troseddol?" to "Other CJS Info"
	And I press the "Parhau" button
	
	#Bail
	
	Then I see "Ydych chi ar fechnïaeth ar hyn o bryd am gyflawni trosedd?" on the page
	When I see "Cymhwysedd" on the page
	And I set the radio button to "Nac ydw"
	And I press the "Parhau" button
	
	#Convictions
	
	Then I see "Ydych chi wedi'ch cael yn euog o drosedd?" on the page
	When I see "Cymhwysedd" on the page
	And I see "Dim ond os cawsoch ddedfryd o garchar, gorchymyn cymunedol neu ddedfryd o garchar ohiriedig y mae hyn yn berthnasol." on the page

	When I set the radio button to "Naddo"
	And I press the "Parhau" button
	
	#Mental Health Sectioned
	
	Then I see "Ydych chi'n cael eich cadw, yn cael eich gwarchod neu eich trin o dan y Ddeddf Galluedd Meddyliol?" on the page
	When I see "Cymhwysedd" on the page
	And I set the radio button to "Na"
	And I press the "Parhau" button
	
	#Mental Health Capacity
	
	Then I see "A benderfynwyd nad oes gennych y gallu meddyliol?" on the page
	When I see "Cymhwysedd" on the page

	And I see "Ie" on the page
	And I see "Na" on the page
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
	And I see "Rhif ffôn: 0300 456 1024" on the page
	And I see "Llinell Gymraeg: 0300 303 5173" on the page
	And I press the "Parhau" button
	
	#Check your answers
	
	And I see "Gwiriwch eich ymatebion nawr" on the page
	When I see text "Ydw" in the same row as "A ydych chi wedi gweithio yn y system cyfiawnder troseddol yn y 5 mlynedd diwethaf?"
	And I see text "Arall" in the same row as "A ydych chi wedi gweithio yn y system cyfiawnder troseddol yn y 5 mlynedd diwethaf?"
	And I see text "Other CJS Info" in the same row as "A ydych chi wedi gweithio yn y system cyfiawnder troseddol yn y 5 mlynedd diwethaf?"
	
	And I check the "Mae'r wybodaeth a roddais uchod yn wir hyd eithaf fy ngwybodaeth." checkbox
	And I press the "Cyflwyno" button
	
	Then I see "O leiaf 2 wythnos cyn ichi ddechrau gwasanaethu ar reithgor, byddwn yn anfon y canlynol atoch:" on the page
	Then I do not see "Yna, o leiaf pythefnos cyn i’r gwasanaeth rheithgor ddechrau byddwn yn anfon y dogfennau canlynol atoch:" on the page
	Then I see "Gallwch wylio fideo am beth sy'n digwydd wrth fod yn rheithiwr ar YouTube, fel eich bod yn gwybod beth i'w ddisgwyl. Mae'r fideo'n para 13 munud." on the page
	
Examples:
	|part_no		|last_name		|postcode	|email 		|pool_no	|
	|641500777		|DOE			|SW1H 9AJ	|b@eeee.com	|415170401	|