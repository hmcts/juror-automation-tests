Feature: Regression Welsh_3rd_ProblemCheck

@RegressionWelsh @JDB-3460 @JDB-3516 
Scenario Outline: Welsh_3rd_ProblemCheck

	Given I am on the welsh version of "Public" "test"

	Given a bureau owned pool is created with jurors
		| court | juror_number  	    | pool_number	    | att_date_weeks_in_future	| owner |
		| 415   | <juror_number> 	    | <pool_number>     | 5				            | 400	|

	And juror "<juror_number>" has "POSTCODE" as "<postcode>" new schema

	And I do not see any links on the page that open to a new page without an alt text
	Then I see "A ydych yn ymateb dros eich hun neu ar ran rhywun arall?" on the page
	
	When I press the "Parhau" button
	Then I see "Mae problem" on the page
	When I set the radio button to "Rwy'n ymateb ar ran rhywun arall"
	And I press the "Parhau" button
	And I do not see any links on the page that open to a new page without an alt text
	Then I see "Ei fanylion rheithiwr" on the page
	
	When I press the "Parhau" button
	Then I see "Mae problem" on the page
	When I set "Rhif rheithiwr" to "<juror_number>"
	And I set "Cyfenw" to "<last_name>"
	And I set "Cod post Rheithiwr" to "<postcode>"
	And I press the "Parhau" button
	Then I see "Beth yw eich enw?" on the page
	
	When I press the "Parhau" button
	Then I see "Mae problem" on the page
	When I set "Enw cyntaf" to "FirstName"
	And I do not see any links on the page that open to a new page without an alt text
	And I set "Cyfenw" to "LastName"
	And I press the "Parhau" button
	Then I see "Eich perthynas â'r unigolyn" on the page
	
	When I press the "Parhau" button
	Then I see "Mae problem" on the page
	When I set "Sut ydych chi'n adnabod yr unigolyn rydych yn ymateb ar ei ran?" to "Friend"
	And I press the "Parhau" button
	Then I see "Eich manylion cyswllt" on the page
	
	When I press the "Parhau" button
	Then I see "Mae problem" on the page
	When I check the "Dros y ffôn (rhifau yn y DU yn unig)" checkbox
	And I set "Prif rif ffôn" to "02078211818"
	And I do not see any links on the page that open to a new page without an alt text
	And I check the "Trwy e-bost" checkbox
	And I set "Nodwch gyfeiriad e-bost" to "email@outlook.com"
	And I set "Nodwch gyfeiriad e-bost eto" to "email@outlook.com"
	And I press the "Parhau" button
	Then I see "Pam ydych chi'n ymateb ar ran yr unigolyn arall?" on the page
	
	When I press the "Parhau" button
	Then I see "Mae problem" on the page
	When I set the radio button to "Nid yw'r unigolyn yma"
	And I press the "Parhau" button
	And I do not see any links on the page that open to a new page without an alt text
	Then I see "A yw'r enw sydd gennym ar ei gyfer yn gywir?" on the page
	
	When I set the radio button to "Nac ydy"
	And I press the "Parhau" button
	And I set "Enw cyntaf" to ""
	And I set "Cyfenw" to ""
	When I press the "Parhau" button
	Then I see "Mae problem" on the page
	When I set "Enw cyntaf" to "JurorFirstName"
	And I set "Cyfenw" to "JurorLastName"
	And I do not see any links on the page that open to a new page without an alt text
	And I press the "Parhau" button
	Then I see "Ei gyfeiriad ef yw hwn?" on the page
	
	When I set the radio button to "Na"
	And I press the "Parhau" button
	And I set "Cod post" to ""
	And I do not see any links on the page that open to a new page without an alt text
	When I press the "Parhau" button
	And I do not see any links on the page that open to a new page without an alt text
	Then I see "Mae problem" on the page
	When I set "Cod post" to "<postcode>"
	And I press the "Parhau" button
	Then I see "Nodwch ddyddiad geni'r unigolyn rydych chi'n ymateb ar ei ran" on the page
	
	When I press the "Parhau" button
	Then I see "Mae problem" on the page
	When I set "Diwrnod" to "27"
	And I set "Mis" to "04"
	And I set "Blwyddyn" to "1981"
	And I do not see any links on the page that open to a new page without an alt text
	And I press the "Parhau" button
	Then I see "Efallai bydd yn rhaid inni gysylltu â'r unigolyn i ofyn rhagor o gwestiynau neu roi rhagor o wybodaeth iddynt am eu gwasanaeth rheithgor" on the page
	And I do not see any links on the page that open to a new page without an alt text
	When I press the "Parhau" button
	Then I see "Mae problem" on the page
	When I set the radio button to "Defnyddio'r rhif ffôn rydych eisoes wedi'i ddarparu i gysylltu â chi"
	And I set the radio button to "Defnyddio'r cyfeiriad e-bost rydych eisoes wedi'i ddarparu i gysylltu â chi"
	And I do not see any links on the page that open to a new page without an alt text
	And I press the "Parhau" button
	
	Then I see "Cadarnhau a yw'r unigolyn yn gymwys i wasanaethu ar reithgor" on the page
	And I press the "Parhau" button
	
	Then I see "Ers iddynt droi'n 13 oed, a yw eu prif gyfeiriad wedi bod yn y DU, Ynysoedd y Sianel neu Ynys Manaw am unrhyw gyfnod o 5 mlynedd o leiaf?" on the page
	When I press the "Parhau" button
	Then I see "Mae problem" on the page
	And I do not see any links on the page that open to a new page without an alt text
	When I set the radio button to "Do"
	And I press the "Parhau" button
	
	Then I see "A yw'r person yr ydych yn ymateb ar ei ran wedi gweithio yn y system cyfiawnder troseddol yn y 5 mlynedd diwethaf?" on the page
	When I press the "Parhau" button
	And I do not see any links on the page that open to a new page without an alt text
	Then I see "Mae problem" on the page
	When I set the radio button to "Nac ydy"
	And I press the "Parhau" button
	
	Then I see "A yw'r unigolyn ar fechnïaeth ar hyn o bryd am gyflawni trosedd?" on the page
	When I press the "Parhau" button
	Then I see "Mae problem" on the page
	When I set the radio button to "Nac ydy"
	And I press the "Parhau" button
	And I do not see any links on the page that open to a new page without an alt text
	Then I see "A yw'r unigolyn wedi'i gael yn euog o drosedd?" on the page
	And I do not see any links on the page that open to a new page without an alt text
	When I press the "Parhau" button
	Then I see "Mae problem" on the page
	When I set the radio button to "Nac ydy"
	And I press the "Parhau" button
	
	Then I see "A ydi'r person yr ydych yn ymateb ar ei ran yn cael ei gadw, ei warchod neu ei drin o dan y Ddeddf Iechyd Meddwl?" on the page
	When I press the "Parhau" button
	Then I see "Mae problem" on the page
	And I do not see any links on the page that open to a new page without an alt text
	When I set the radio button to "Na"
	And I press the "Parhau" button

	Then I see "A wnaed penderfyniad nad oes gan y person yr ydych yn ymateb ar ei ran y 'gallu meddyliol'?" on the page
	When I press the "Parhau" button
	Then I see "Mae problem" on the page
	And I do not see any links on the page that open to a new page without an alt text
	When I set the radio button to "Na"
	And I press the "Parhau" button
	
	Then I see "Gwiriwch eich dyddiad dechrau" on the page
	And I do not see any links on the page that open to a new page without an alt text
	When I press the "Parhau" button
	Then I see "Mae problem" on the page
	When I set the radio button to "Ydi, mae'r unigolyn yn gallu dechrau"
	And I press the "Parhau" button
	
	Then I see "A fydd yr unigolyn rydych yn ymateb ar ei ran angen cymorth pan fydd yn y llys?" on the page
	When I press the "Parhau" button
	Then I see "Mae problem" on the page
	When I set the radio button to "Nac oes"
	And I press the "Parhau" button
	
	Then I see "Gwiriwch eich ymatebion nawr" on the page
	
	When I press the "Cyflwyno" button
	And I do not see any links on the page that open to a new page without an alt text
	Then I see "Mae problem" on the page
	When I click on the "Newid" link in the same row as "Cadarnhewch ddyddiad ei wasanaeth rheithgor"
	Then I see "Gwiriwch eich dyddiad dechrau" on the page
	
	When I set the radio button to "Nac ydi, rhaid newid y dyddiad"
	And I press the "Parhau" button
	Then I see "Dywedwch wrthym pam fod angen dyddiad arall arnynt ar gyfer y gwasanaeth rheithgor" on the page
	
	When I press the "Parhau" button
	And I do not see any links on the page that open to a new page without an alt text
	Then I see "Mae problem" on the page
	When I set text area with "id" of "deferralReason" to "Deferral reason please"
	And I press the "Parhau" button
	Then I see "Dewiswch 3 dydd Llun pan allant ddechrau gwasanaeth rheithgor" on the page
	
	When I press the "Parhau" button
	And I do not see any links on the page that open to a new page without an alt text
	Then I see "Mae problem" on the page
	When I set the "First" single date field to a Monday "6" weeks in the future
	When I set the "Second" single date field to a Monday "7" weeks in the future
	When I set the "Third" single date field to a Monday "8" weeks in the future
	And I press the "Parhau" button
	
	#confirm
	
	And I set the radio button to "Ydw"
	And I press the "Parhau" button
	
	Then I see "Gwiriwch eich ymatebion nawr" on the page
	
	When I click on the "Newid" link in the same row as "Cadarnhewch ddyddiad ei wasanaeth rheithgor"
	Then I see "Gwiriwch eich dyddiad dechrau" on the page
	
	When I set the radio button to "Nac ydi, ni all yr unigolyn wasanaethu ar reithgor a rhaid esgusodi"
	And I press the "Parhau" button
	And I do not see any links on the page that open to a new page without an alt text
	Then I see "Eglurwch pam na all wasanaethu ar reithgor yn ystod y 12 mis nesaf." on the page
	Then I see "Nid oes angen ichi atodi na chasglu tystiolaeth cyn dyddiad terfyn yr wŷs." on the page
	Then I see "Byddwn yn cysylltu yn nes ymlaen os bydd angen hynny." on the page
	
	When I press the "Parhau" button
	And I do not see any links on the page that open to a new page without an alt text
	Then I see "Mae problem" on the page
	And I see "Rhowch y rheswm pam na all wasanaethu ar reithgor yn ystod y 12 mis nesaf" on the page
	When I set text area with "id" of "excusalReason" to "Excuse me please"
	And I press the "Parhau" button
	Then I see "Gwiriwch eich ymatebion nawr" on the page
	
	And I do not see any links on the page that open to a new page without an alt text
	Then I check the "wybodaeth rwyf wedi ei rhoi am yr unigolyn rwyf yn ymateb ar ei ran yn gywir." checkbox
	And I press the "Cyflwyno" button
	Then I see "Rydych wedi cwblhau'r broses ymateb" on the page
	And I see "<juror_number>" on the page

	Examples:
		|juror_number	|last_name			|postcode	     |email 		|pool_number	|
		|041592773	    |lname	            |CH2 2AA	     |e@mail.com	|415355404	    |