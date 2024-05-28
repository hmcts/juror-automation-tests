Feature: WelshCharChecks

@RegressionWelsh @NewSchemaConverted
Scenario Outline: WelshCharChecksTest

	Given I am on the welsh version of "Public" "test"

	Given a bureau owned pool is created with jurors
		| court | juror_number  	| pool_number	| att_date_weeks_in_future	| owner |
		| 457   | <juror_number>	| <pool_number>	| 5			            	| 400	|
		
	And juror "<juror_number>" has "LAST_NAME" as "<last_name>" new schema
	And juror "<juror_number>" has "POSTCODE" as "<postcode>" new schema
	
	And I set the radio button to "n ymateb dros fy hun"
	And I press the "Parhau" button
	And I set "Rhif rheithiwr – 9 digid" to "<juror_number>"
	And I set "Cyfenw'r Rheithiwr" to "<last_name>"
	And I set "Cod post Rheithiwr" to "<postcode>"
	And I see "Rhowch eich enw olaf fel y mae wedi'i nodi ar y llythyr gwŷs rheithgor, hyd yn oed os yw'n anghywir. Gallwch ei newid nes ymlaen." on the page

	And I see "Gallwch ddod o hyd i'ch rhif rheithiwr ar eich llythyr gwŷs rheithgor." on the page
	And I press the "Parhau" button
	
	And I see "A yw'r enw sydd gennym ar eich cyfer chi yn gywir?" on the page
	And I set the radio button to "Nac ydy"
	And I press the "Parhau" button
	And I click on the "Beth sy'n digwydd os rwyf wedi newid fy enw?" link
	And I see "Os yw eich enw chi wedi newid, byddwn yn cysylltu â chi i wirio hynny. Efallai y byddwn yn gofyn am dystysgrif briodas, tystysgrif partneriaeth sifil neu weithred newid enw." on the page
	And I press the "Parhau" button
	And I see "Eich cyfeiriad chi yw hwn?" on the page
	And I set the radio button to "Ie"
	And I press the "Parhau" button
	And I set "Prif rif ffôn" to "01111112221"
	And I set "Rhif ffôn arall (dewisol)" to "0111112223"
	And I press the "Parhau" button
	And I set input field with "id" of "emailAddress" to "email@1.com"
	And I set input field with "id" of "emailAddressConfirmation" to "email@1.com"
	And I press the "Parhau" button
	
	And I set "Diwrnod" to "01"
	And I set "Mis" to "01"
	And I set "Blwyddyn" to "1990"
	
	And I press the "Parhau" button
	
	#eligibility
	And I see "Cadarnhau a ydych yn gymwys i wasanaethu ar reithgor" on the page
	And I press the "Parhau" button
	
	#residency
	And I see "Cymhwysedd" on the page
	And I set the radio button to "Do"
	And I press the "Parhau" button

	#cjs
	And I see "A ydych chi wedi gweithio yn y system cyfiawnder troseddol yn y 5 mlynedd diwethaf?" on the page
	And I see "Mae hyn yn cynnwys gweithio i'r heddlu, Gwasanaeth Carchardai EM, yr Asiantaeth Troseddu Cenedlaethol, y farnwriaeth, GLlTEM neu unrhyw ran arall o'r system cyfiawnder troseddol" on the page
	
	And I set the radio button to "Nac ydw"
	And I press the "Parhau" button
	
	#bail
	And I set the radio button to "Nac ydw"
	And I press the "Parhau" button
	
	#convictions
	And I set the radio button to "Naddo"
	And I press the "Parhau" button
	
	#mental health
	And I see "Ydych chi'n cael eich cadw, yn cael eich gwarchod neu eich trin o dan y Ddeddf Galluedd Meddyliol?" on the page
	And I set the radio button to "Na"
	And I press the "Parhau" button
	
	And I see "A benderfynwyd nad oes gennych y gallu meddyliol?" on the page
	And I set the radio button to "Na"
	And I press the "Parhau" button

	And I see "Gwiriwch eich dyddiad dechrau" on the page
	And I see "Rydych wedi cael gwŷs i ddechrau gwasanaeth rheithgor ar" on the page
	And I set the radio button to "Ydw, rydw i'n gallu dechrau"
	And I set the radio button to "Nac ydw, hoffwn newid y dyddiad"
	And I set the radio button to "Nac ydw, ni allaf wasanaethu ar reithgor a hoffwn gael fy esgusodi"
	And I press the "Parhau" button
	
	And I see "Pam fod angen ichi gael eich esgusodi rhag gwasanaethu ar reithgor?" on the page
	And I see "Eglurwch pam na allwch chi wasanaethu ar reithgor yn ystod y 12 mis nesaf." on the page
	And I see "Nid oes angen ichi atodi na chasglu tystiolaeth cyn dyddiad terfyn eich gwŷs." on the page
	And I see "Byddwn yn cysylltu â chi yn nes ymlaen os bydd angen hynny." on the page
	
	And I set text area with "id" of "excusalReason" to "testA"
	And I press the "Parhau" button
	
	And I see "A fyddech chi angen cymorth pan fyddwch yn y llys?" on the page
	And I see "A oes gennych anabledd neu nam sy’n golygu bydd angen cymorth neu gyfleusterau ychwanegol arnoch yn yr adeilad llys ble fyddwch yn cyflawni eich gwasanaeth rheithgor?" on the page
	And I set the radio button to "Nac oes"
	And I press the "Parhau" button
	And I see "Gwiriwch eich ymatebion nawr" on the page
	And I see "Mae’n bwysig eich bod yn gwirio bod yr holl wybodaeth yn gywir cyn i chi anfon eich ymateb." on the page
	And I see "Bu i chi roi’r manylion rheithiwr a ganlyn" on the page
	And I see "Ers i chi droi'n 13 oed, a yw eich prif gyfeiriad wedi bod yn y DU, Ynysoedd y Sianel neu Ynys Manaw am unrhyw gyfnod o 5 mlynedd o leiaf?" on the page
	And I see "Ydych chi'n cael eich cadw, yn cael eich gwarchod neu eich trin o dan y Ddeddf Galluedd Meddyliol?" on the page
	And I see "A benderfynwyd nad oes gennych y gallu meddyliol?" on the page
	And I see "Ydych chi ar fechnïaeth ar hyn o bryd am gyflawni trosedd?" on the page
	And I see "Ydych chi wedi'ch cael yn euog o drosedd?" on the page
	
	And I see "Na allaf wasanaethu ar reithgor a hoffwn gael fy esgusodi." on the page
	And I see "Gan eich bod wedi gofyn am gael eich esgusodi rhag gwasanaethu ar reithgor, bu ichi ddweud" on the page
	And I see "Pam fod angen ichi gael eich esgusodi rhag gwasanaethu ar reithgor?" on the page
	And I see "A ydych chi wedi gweithio yn y system cyfiawnder troseddol yn y 5 mlynedd diwethaf?" on the page

	Examples:
		| juror_number	| pool_number 	| last_name 	| postcode 	|
		| 045700067		| 457300067 	| LNAMEUPDATE	| NN1 3HQ	|