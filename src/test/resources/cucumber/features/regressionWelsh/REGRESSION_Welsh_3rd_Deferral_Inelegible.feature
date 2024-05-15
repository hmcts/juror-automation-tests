Feature: Regression Welsh_3rd_Deferral_Inelegible

@Features @NewSchemaConverted @JM-7065
Scenario Outline: Welsh 3rd Party Deferral + Inelegible

	#return to @RegressionWelsh when defect fixed
	Given I am on the welsh version of "Public" "test"

	Given a bureau owned pool is created with jurors
		| court |juror_number  | pool_number	| att_date_weeks_in_future	| owner |
		| 457   |<juror_number>| <pool_number>	| 3				            | 400	|

	And juror "<juror_number>" has "LAST_NAME" as "<last_name>" new schema
	And juror "<juror_number>" has "POSTCODE" as "<postcode>" new schema

	And I see "Rwy'n ymateb ar ran rhywun arall" on the page
	And I see "Rwy'n ymateb dros fy hun" on the page
	And I set the radio button to "Rwy'n ymateb ar ran rhywun arall"
	And I press the "Parhau" button
	Then I see "Ei fanylion rheithiwr" on the page
	And I do not see any links on the page that open to a new page without an alt text

	When I set "Rhif rheithiwr" to "<juror_number>"
	When I set "Cyfenw" to "<last_name>"
	When I set "Cod post Rheithiwr" to "<postcode>"
	And I do not see any links on the page that open to a new page without an alt text
	And I press the "Parhau" button

	#3rd Party Name
	When I see "Eich Manylion" on the page
	When I set "Enw cyntaf" to "FirstNameA"
	And I set "Cyfenw" to "LastNameB"
	And I press the "Parhau" button
	Then I see "Eich perthynas â'r unigolyn" on the page
	And I do not see any links on the page that open to a new page without an alt text

	#3rd Party Relationship
	When I see "Eich Manylion" on the page
	And I set "Sut ydych chi'n adnabod yr unigolyn rydych yn ymateb ar ei ran?" to "Relationship"
	And I press the "Parhau" button

	#3rd party Contact
	When I see "Eich manylion cyswllt" on the page
	And I check the "Dros y ffôn (rhifau yn y DU yn unig)" checkbox
	And I set "Prif rif ffôn" to "0207 821 1818"
	And I check the "Trwy e-bost" checkbox
	And I set "Nodwch gyfeiriad e-bost" to "email@outlook.com"
	And I set "Nodwch gyfeiriad e-bost eto" to "email@outlook.com"
	And I do not see any links on the page that open to a new page without an alt text
	And I press the "Parhau" button
	Then I see "Pam ydych chi'n ymateb ar ran yr unigolyn arall?" on the page
	And I do not see any links on the page that open to a new page without an alt text

	#Why replying
	When I set the radio button to "Nid yw'r unigolyn yma"
	And I do not see any links on the page that open to a new page without an alt text
	And I press the "Parhau" button
	Then I see "A yw'r enw sydd gennym ar ei gyfer yn gywir?" on the page
	And I do not see any links on the page that open to a new page without an alt text

	#Juror's Name
	When I see "Manylion y Rheithiwr" on the page
	When I set the radio button to "Ydy"
	And I press the "Parhau" button
	Then I see "Ei gyfeiriad ef yw hwn?" on the page

	#Check juror address
	When I see "Manylion y Rheithiwr" on the page
	And I do not see any links on the page that open to a new page without an alt text
	When I set the radio button to "Ie"
	And I press the "Parhau" button
	Then I see "Nodwch ddyddiad geni'r unigolyn rydych chi'n ymateb ar ei ran" on the page
	And I do not see any links on the page that open to a new page without an alt text

	#Juror's DOB
	And I set "Diwrnod" to "01"
	And I set "Mis" to "01"
	And I set "Blwyddyn" to "1990"
	And I press the "Parhau" button

	When I set the radio button to "Defnyddio'r rhif ffôn rydych eisoes wedi'i ddarparu i gysylltu â chi"
	And I set the radio button to "Rhoi cyfeiriad e-bost gwahanol ar gyfer y rheithiwr"
	And I see "Nodwch gyfeiriad e-bost" on the page

	And I set the radio button to "Defnyddio'r cyfeiriad e-bost rydych eisoes wedi'i ddarparu i gysylltu â chi"
	And I press the "Parhau" button

	#Qualify for jury service
	Then I see "Cadarnhau a yw'r unigolyn yn gymwys i wasanaethu ar reithgor" on the page
	And I press the "Parhau" button

	#Residency
	Then I see "Ers iddynt droi'n 13 oed, a yw eu prif gyfeiriad wedi bod yn y DU, Ynysoedd y Sianel neu Ynys Manaw am unrhyw gyfnod o 5 mlynedd o leiaf?" on the page
	When I see "Cymhwysedd" on the page
	And I set the radio button to "Naddo"
	And I set "Rhowch fanylion" to "Not a resident"
	And I press the "Parhau" button

	#CJS
	Then I see "A yw'r person yr ydych yn ymateb ar ei ran wedi gweithio yn y system cyfiawnder troseddol yn y 5 mlynedd diwethaf?" on the page
	When I set the radio button to "Nac ydy"
	And I press the "Parhau" button

	#Bail
	Then I see "A yw'r unigolyn ar fechnïaeth ar hyn o bryd am gyflawni trosedd?" on the page
	When I see "Cymhwysedd" on the page
	And I set the radio button to "Ydy"
	And I set "Rhowch fanylion" to "Bailed"
	And I press the "Parhau" button

	#Convictions
	Then I see "A yw'r unigolyn wedi'i gael yn euog o drosedd?" on the page
	When I see "Cymhwysedd" on the page
	And I set the radio button to "Ydy"
	And I set text area with "id" of "convictedDetails" to "Convicted"
	And I press the "Parhau" button

	#Mental Health Sectioned
	Then I see "A ydi'r person yr ydych yn ymateb ar ei ran yn cael ei gadw, ei warchod neu ei drin o dan y Ddeddf Iechyd Meddwl?" on the page
	When I see "Cymhwysedd" on the page
	And I set the radio button to "Ie"
	And I set "Eglurwch sut y maent yn cael eu cadw dan glo, sut ofal maent yn ei gael neu sut maent yn cael eu trin o dan y Ddeddf Iechyd Meddwl" to "Sectioned"
	And I press the "Parhau" button

	#Mental Health Capacity
	Then I see "A wnaed penderfyniad nad oes gan y person yr ydych yn ymateb ar ei ran y 'gallu meddyliol'?" on the page
	When I see "Cymhwysedd" on the page
	And I set the radio button to "Ie"
	And I set "Eglurwch yn gryno pam y penderfynwyd nad oes ganddynt alluedd meddyliol" to "Lacks capacity"
	And I press the "Parhau" button

	#can you attend
	Then I see "Gwiriwch eich dyddiad dechrau" on the page
	When I set the radio button to "Nac ydi, rhaid newid y dyddiad"
	And I press the "Parhau" button

	Then I see "Dywedwch wrthym pam fod angen dyddiad arall arnynt ar gyfer y gwasanaeth rheithgor" on the page

	#Reasons for Deferral Request
	When I set text area with "id" of "deferralReason" to "Reasons for deferral request"
	And I press the "Parhau" button
	Then I see "Dewiswch 3 dydd Llun pan allant ddechrau gwasanaeth rheithgor" on the page

	When I set the "First" single date field to a Monday "6" weeks in the future
	When I set the "Second" single date field to a Monday "7" weeks in the future
	When I set the "Third" single date field to a Monday "8" weeks in the future

	And I press the "Parhau" button

	#confirm dates
	When I set the radio button to "Ydw"
	When I press the "Parhau" button

	#Special Reqs
	Then I see "A fydd yr unigolyn rydych yn ymateb ar ei ran angen cymorth pan fydd yn y llys?" on the page
	When I set the radio button to "Nac oes"
	When I press the "Parhau" button

	#Check your answers page
	Then I see "Gwiriwch eich ymatebion nawr" on the page

	Then I check the "wybodaeth rwyf wedi ei rhoi am yr unigolyn rwyf yn ymateb ar ei ran yn gywir." checkbox
	When I press the "Cyflwyno" button

	Then I see "Rydych wedi cwblhau'r broses ymateb" on the page
	Then I see "<juror_number>" on the page

	And I see "Byddwn nawr yn gwirio'ch atebion. Mae eich atebion yn golygu efallai na all yr unigolyn rydych wedi ymateb ar ei ran wasanaethu ar reithgor." on the page

	Given I am on "Bureau" "test"
	And I log in as "MODTESTBUREAU"

	When I click on the "Search" link
	And I set "Juror number" to "<juror_number>"
	And I press the "Search" button
	Then I see "<juror_number>" on the page

	And I click link with ID "selectAllLink"
	And I press the "Send to..." button
	And I set input field with "id" of "sendToOfficer" to "ARAMIS1"
	And I press the "Send" button
	And I press the "Send" button
	Then I see "Your work" on the page

	Then I click on the "Sign out" link
	And I log in as "ARAMIS1"
	Then I see "<juror_number>" on the page

	#JM-7065
	Then I see "<juror_number>" has reply type indicator "NEEDS REVIEW"

Examples:
	| juror_number	| last_name	| postcode	| pool_number	|
	| 045700054		| DOE		| SW1H 9AJ	| 457300054		|