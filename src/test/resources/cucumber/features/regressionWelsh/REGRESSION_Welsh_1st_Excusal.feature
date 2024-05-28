Feature: Regression Welsh_1st_Excusal

@RegressionWelsh @NewSchemaConverted
Scenario Outline: Welsh 1st Party Excusal

	Given I am on the welsh version of "Public" "test"

	Given a bureau owned pool is created with jurors
		| court | juror_number  	| pool_number	| att_date_weeks_in_future	| owner |
		| 457   | <juror_number>	| <pool_number>	| 5			            	| 400	|

		
	And juror "<juror_number>" has "LAST_NAME" as "<last_name>" new schema
	And juror "<juror_number>" has "POSTCODE" as "<postcode>" new schema
   
    And I do not see any links on the page that open to a new page without an alt text
	And I set the radio button to "n ymateb dros fy hun"
	And I press the "Parhau" button
	Then I see "Eich manylion rheithiwr" on the page
	
	When I set "Rhif rheithiwr" to "<juror_number>"
	When I set "Cyfenw" to "<last_name>"
	When I set "Cod post Rheithiwr" to "<postcode>"
	And I press the "Parhau" button
	Then I see "A yw'r enw sydd gennym ar eich cyfer chi yn gywir?" on the page
	
	#Juror's details
	And I set the radio button to "Ydy"
	When I press the "Parhau" button
	Then I see "Eich cyfeiriad chi yw hwn?" on the page
	
	#Juror's address
	And I set the radio button to "Ie"
	When I press the "Parhau" button
	Then I see "Beth yw eich rhif ffôn?" on the page
	
	#Juror's phone
	And I see "Darparwch rif ffôn yn y DU y gallwn ei ddefnyddio i gysylltu â chi rhwng 9am a 5pm, dydd Llun i ddydd Gwener." on the page
	When I set "Prif rif ffôn" to "02078211818"
	And I press the "Parhau" button
	Then I see "Beth yw eich cyfeiriad e-bost?" on the page
	
	#Juror's email
	When I see "Pam fod arnom angen eich cyfeiriad e-bost?" on the page
	And I set "Nodwch eich cyfeiriad e-bost" to "email@outlook.com"
	And I set "Nodwch eich cyfeiriad e-bost eto" to "email@outlook.com"
	And I press the "Parhau" button
	Then I see "Beth yw eich dyddiad geni?" on the page
	
	#DoB
	And I see "Cymorth gyda'ch dyddiad geni" on the page
	When I set "Diwrnod" to "27"
	And I set "Mis" to "04"
	And I set "Blwyddyn" to "1978"
	And I press the "Parhau" button
	
	#Do you qualify for jury service?
	Then I see "Cadarnhau a ydych yn gymwys i wasanaethu ar reithgor" on the page
	When I press the "Parhau" button

	#Residency
	Then I see "Ers i chi droi'n 13 oed, a yw eich prif gyfeiriad wedi bod yn y DU, Ynysoedd y Sianel neu Ynys Manaw am unrhyw gyfnod o 5 mlynedd o leiaf?" on the page
	And I set the radio button to "Do"
	And I press the "Parhau" button

	#CJS
	Then I see "A ydych chi wedi gweithio yn y system cyfiawnder troseddol yn y 5 mlynedd diwethaf?" on the page
	And I set the radio button to "Nac ydw"
	And I press the "Parhau" button
	
	#Bail
	And I set the radio button to "Nac ydw"
	And I press the "Parhau" button

	#Criminal convictions
	And I set the radio button to "Naddo"
	And I press the "Parhau" button
	
	#Mental health sectioned
	And I set the radio button to "Na"
	And I press the "Parhau" button
	
	#Mental health capacity
	And I set the radio button to "Na"
	And I press the "Parhau" button
	
	#Can you attend, select excusal
	And I set the radio button to "Nac ydw, ni allaf wasanaethu ar reithgor a hoffwn gael fy esgusodi"
	And I press the "Parhau" button
	
	#Reason for excusal
	And I see "steps/confirm-date/excusal" in the URL
	Then I see "Pam fod angen ichi gael eich esgusodi rhag gwasanaethu ar reithgor?" on the page
	And I see "Eglurwch pam na allwch chi wasanaethu ar reithgor yn ystod y 12 mis nesaf." on the page
	And I see "Nid oes angen ichi atodi na chasglu tystiolaeth cyn dyddiad terfyn eich gwŷs." on the page
	And I see "Byddwn yn cysylltu â chi yn nes ymlaen os bydd angen hynny." on the page
	And I click on the "A fydd angen imi ddarparu tystiolaeth yn fuan?" link
	And I see "Os oes angen tystiolaeth arnom, byddwn yn cysylltu â chi ar wahân i ddweud wrthych." on the page
	And I see "Er enghraifft, os ydych chi'n rhy sâl i wasanaethu ar reithgor, efallai y byddwn yn gofyn i chi ddarparu tystysgrif feddygol gan weithiwr gofal iechyd proffesiynol rheoledig priodol, fel meddyg, nyrs, ffisiotherapydd, fferyllydd neu therapydd galwedigaethol." on the page
	And I see "Byddwch yn cael amser i gasglu unrhyw dystiolaeth, felly nid oes angen i chi boeni am geisio ei chael yn awr." on the page
	And I see "Dylech aros nes ein bod wedi dweud wrthych pa dystiolaeth sydd ei hangen arnom, os o gwbl." on the page
	And I do not see "Pa dystiolaeth y bydd rhaid i mi o bosib ei gyflwyno?" on the page
	
	And I press the "Parhau" button
	Then I see "Rhowch y rheswm pam na allwch wasanaethu ar reithgor yn ystod y 12 mis nesaf" on the page
	
	When I set text area with "id" of "excusalReason" to "reasons for excusal request"
	And I press the "Parhau" button
	
	#Special Requirements
	And I set the radio button to "Nac oes"
	When I press the "Parhau" button
	
	#Check your answers page
	Then I see "Gwiriwch eich ymatebion nawr" on the page
	And I see text "reasons for excusal request" in the same row as "Eglurwch pam na allwch chi wasanaethu ar reithgor yn ystod y 12 mis nesaf"
	And I see "Pam fod angen ichi gael eich esgusodi rhag gwasanaethu ar reithgor?" on the page
	
	Then I check the "Mae'r wybodaeth a roddais uchod yn wir hyd eithaf fy ngwybodaeth." checkbox
	When I press the "Cyflwyno" button
	
	Then I see "Rydych wedi cwblhau'r broses ymateb" on the page
	Then I see "Rydych wedi cwblhau'r broses ymateb" on the page
	Then I see "<juror_number>" on the page
	
	Then I click on the "Lawrlwythwch gopi o'ch ymateb i'r wŷs HTML (15KB)" link
	And I see "Pam fod angen ichi gael eich esgusodi rhag gwasanaethu ar reithgor?" on the page
	
Examples:
	| juror_number	| last_name	| postcode	| pool_number 	|
	| 045700059		| LNAME1327	|CH1 2AN	| 457300059		|