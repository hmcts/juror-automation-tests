Feature: Welsh_3rd_BetaBanner

# Beta banner has been removed 27-07-20

@RegressionWelsh @JDB-3522 @JDB-4570 
Scenario Outline: Welsh 3rd Party Beta Banner Check
	Given I am on the welsh version of "Public" "bau-test"
	Given the juror numbers have not been processed
		| part_no 	| pool_no 	| owner |
		| <part_no> |<pool_no>	| 400 	|
	
	And juror "<juror_number>" has "LAST_NAME" as "<last_name>" new schema


	And juror "<juror_number>" has "POSTCODE" as "<postcode>" new schema

	Then I see "A ydych yn ymateb dros eich hun neu ar ran rhywun arall?" on the page
	
	And I set the radio button to "Rwy'n ymateb ar ran rhywun arall"
	And I do not see "Gwasanaeth newydd yw hwn – bydd eich adborth yn ein helpu i’w wella" on the page
	And I press the "Parhau" button	
	
	#Juror Log In
	
	When I do not see "Gwasanaeth newydd yw hwn – bydd eich adborth yn ein helpu i’w wella" on the page
	When I set "Rhif rheithiwr" to "<juror_number>"
	When I set "Cyfenw" to "<last_name>"
	When I set "Cod post Rheithiwr" to "<postcode>"
	And I press the "Parhau" button
    Then I see "Beth yw eich enw?" on the page
	
	#3rd Party Name
	
	When I see "Eich Manylion" on the page
	And I do not see "Gwasanaeth newydd yw hwn – bydd eich adborth yn ein helpu i’w wella" on the page
	And I set "Enw cyntaf" to "FirstNameA"
	And I set "Cyfenw" to "LastNameB"
	And I press the "Parhau" button
	Then I see "Eich perthynas â'r unigolyn" on the page
	
	#Relationship to juror
	
	When I see "Eich Manylion" on the page
	And I do not see "Gwasanaeth newydd yw hwn – bydd eich adborth yn ein helpu i’w wella" on the page
	And I set "Sut ydych chi'n adnabod yr unigolyn rydych yn ymateb ar ei ran?" to "Friend"
	And I press the "Parhau" button
	Then I see "Eich manylion cyswllt" on the page
	
	#3rd Party Contact
	
	When I see "Eich Manylion" on the page
	And I do not see "Gwasanaeth newydd yw hwn – bydd eich adborth yn ein helpu i’w wella" on the page
	And I check the "Dros y ffôn (rhifau yn y DU yn unig)" checkbox
	And I set "Prif rif ffôn" to "0207 821 1818"
	And I check the "Trwy e-bost" checkbox
	And I set "Nodwch gyfeiriad e-bost" to "email@outlook.com"
	And I set "Nodwch gyfeiriad e-bost eto" to "email@outlook.com"
	And I press the "Parhau" button
	
	#Why are you replying?
	
	Then I see "Pam ydych chi'n ymateb ar ran yr unigolyn arall?" on the page
	And I do not see "Pam ydych chi'n ymateb?" on the page
	And I do not see "Gwasanaeth newydd yw hwn – bydd eich adborth yn ein helpu i’w wella" on the page
	When I set the radio button to "Nid yw'r unigolyn yma"
	And I press the "Parhau" button
	Then I see "A yw'r enw sydd gennym ar ei gyfer yn gywir?" on the page
	
	#Check juror name
	
	When I see "Manylion y Rheithiwr" on the page
	And I do not see "Gwasanaeth newydd yw hwn – bydd eich adborth yn ein helpu i’w wella" on the page
	When I set the radio button to "Ydy"
	And I press the "Parhau" button
	Then I see "Ei gyfeiriad ef yw hwn?" on the page
	
	#Check juror address
	
	When I see "Manylion y Rheithiwr" on the page
	And I do not see "Gwasanaeth newydd yw hwn – bydd eich adborth yn ein helpu i’w wella" on the page
	When I set the radio button to "Ie"
	And I press the "Parhau" button
	Then I see "Nodwch ddyddiad geni'r unigolyn rydych chi'n ymateb ar ei ran" on the page
	
	#DoB JDB-3369
	
	When I see "Manylion y Rheithiwr" on the page
	And I do not see "Gwasanaeth newydd yw hwn – bydd eich adborth yn ein helpu i’w wella" on the page
	And I set "Diwrnod" to "27"
	And I set "Mis" to "04"
	And I set "Blwyddyn" to "1981"
	And I press the "Parhau" button
	Then I see "Efallai bydd yn rhaid inni gysylltu â'r unigolyn i ofyn rhagor o gwestiynau neu roi rhagor o wybodaeth iddynt am eu gwasanaeth rheithgor" on the page
	
	#Contacting the juror
	
	When I see "Manylion y Rheithiwr" on the page
	And I do not see "Gwasanaeth newydd yw hwn – bydd eich adborth yn ein helpu i’w wella" on the page
	And I set the radio button to "Defnyddio'r rhif ffôn rydych eisoes wedi'i ddarparu i gysylltu â chi"
	
	#Checking field
	
	And I set the radio button to "Rhoi cyfeiriad e-bost gwahanol ar gyfer y rheithiwr"
	And I see "Nodwch gyfeiriad e-bost" on the page
	
	And I set the radio button to "Defnyddio'r cyfeiriad e-bost rydych eisoes wedi'i ddarparu i gysylltu â chi"
	And I press the "Parhau" button

	#Qualify for jury service
	
	When I see "Cadarnhau a yw'r unigolyn yn gymwys i wasanaethu ar reithgor" on the page
	And I do not see "Gwasanaeth newydd yw hwn – bydd eich adborth yn ein helpu i’w wella" on the page
	And I press the "Parhau" button
	
	#Residency
	
	Then I see "Ers iddynt droi'n 13 oed, a yw eu prif gyfeiriad wedi bod yn y DU, Ynysoedd y Sianel neu Ynys Manaw am unrhyw gyfnod o 5 mlynedd o leiaf?" on the page
	When I see "Cymhwysedd" on the page
	And I do not see "Gwasanaeth newydd yw hwn – bydd eich adborth yn ein helpu i’w wella" on the page
	And I set the radio button to "Do"
	And I press the "Parhau" button
	
	#CJS no
	
	Then I see "A yw'r person yr ydych yn ymateb ar ei ran wedi gweithio yn y system cyfiawnder troseddol yn y 5 mlynedd diwethaf?" on the page
	When I set the radio button to "Nac ydy"
	And I do not see "Gwasanaeth newydd yw hwn – bydd eich adborth yn ein helpu i’w wella" on the page
	And I press the "Parhau" button
	
	#Bail
	
	Then I see "A yw'r unigolyn ar fechnïaeth ar hyn o bryd am gyflawni trosedd?" on the page
	When I see "Cymhwysedd" on the page
	And I do not see "Gwasanaeth newydd yw hwn – bydd eich adborth yn ein helpu i’w wella" on the page
	And I set the radio button to "Nac ydy"
	And I press the "Parhau" button
	
	#Convictions
	
	Then I see "A yw'r unigolyn wedi'i gael yn euog o drosedd?" on the page
	When I see "Cymhwysedd" on the page
	And I do not see "Gwasanaeth newydd yw hwn – bydd eich adborth yn ein helpu i’w wella" on the page
	And I click on the "Canllawiau mewn perthynas â gwasanaethu ar reithgor os oes gennych euogfarn" link
	And on the page I see
	|text|
	|gorchymyn adsefydlu cymunedol|
	|gorchymyn cosb gymunedol|
	|gorchymyn cosb ac adsefydlu cymunedol|
	|gorchymyn trin a phrofi am gyffuriau|
	|gorchymyn ymatal rhag cymryd cyffuriau|
	|Ni allant ychwaith wasanaethu ar reithgor os ydynt, yn ystod y 10 mlynedd diwethaf, wedi cael:|
	When I set the radio button to "Nac ydy"
	And I press the "Parhau" button
	
	#Mental Health Sectioned
	
	Then I see "A ydi'r person yr ydych yn ymateb ar ei ran yn cael ei gadw, ei warchod neu ei drin o dan y Ddeddf Iechyd Meddwl?" on the page
	When I see "Cymhwysedd" on the page
	And I do not see "Gwasanaeth newydd yw hwn – bydd eich adborth yn ein helpu i’w wella" on the page
	And I set the radio button to "Na"
	And I press the "Parhau" button
	
	#Mental Health Capacity
	
	Then I see "A wnaed penderfyniad nad oes gan y person yr ydych yn ymateb ar ei ran y 'gallu meddyliol'?" on the page
	When I see "Cymhwysedd" on the page
	And I do not see "Gwasanaeth newydd yw hwn – bydd eich adborth yn ein helpu i’w wella" on the page
	And I set the radio button to "Na"
	And I press the "Parhau" button
	
	#Confirm Date of Jury Service
	
	Then I see "Gwiriwch eich dyddiad dechrau" on the page
	When I set the radio button to "Ydi, mae'r unigolyn yn gallu dechrau"
	And I do not see "Gwasanaeth newydd yw hwn – bydd eich adborth yn ein helpu i’w wella" on the page
	And  I press the "Parhau" button
	
	#RA no
	
	Then I see "A fydd yr unigolyn rydych yn ymateb ar ei ran angen cymorth pan fydd yn y llys?" on the page
	When I set the radio button to "Nac oes"
	And I do not see "Gwasanaeth newydd yw hwn – bydd eich adborth yn ein helpu i’w wella" on the page
	And I press the "Parhau" button
	
	#Check your answers
	
	Then I see "Gwiriwch eich ymatebion nawr" on the page
	When I do not see "Gwasanaeth newydd yw hwn – bydd eich adborth yn ein helpu i’w wella" on the page
	And I click on the "Newid" link in the same row as "Cadarnhewch ddyddiad ei wasanaeth rheithgor"
	Then I see "Gwiriwch eich dyddiad dechrau" on the page
	
	#Confirm Date of Jury Service
	
	When I set the radio button to "Nac ydi, rhaid newid y dyddiad"
	And I press the "Parhau" button
	Then I see "Dywedwch wrthym pam fod angen dyddiad arall arnynt ar gyfer y gwasanaeth rheithgor" on the page
	
	#Deferral Reason
	
	When I do not see "Gwasanaeth newydd yw hwn – bydd eich adborth yn ein helpu i’w wella" on the page
	And I set text area with "id" of "deferralReason" to "Defer them please"
	And I press the "Parhau" button
	Then I see "Dewiswch 3 dydd Llun pan allant ddechrau gwasanaeth rheithgor" on the page
	
	#Deferral Dates
	
	When I do not see "Gwasanaeth newydd yw hwn – bydd eich adborth yn ein helpu i’w wella" on the page
	When I set the "First" single date field to a Monday "6" weeks in the future
	When I set the "Second" single date field to a Monday "7" weeks in the future
	When I set the "Third" single date field to a Monday "8" weeks in the future
	
	And I press the "Parhau" button
	
	And I set the radio button to "Ydw"
	And I press the "Parhau" button
	
	Then I see "Gwiriwch eich ymatebion nawr" on the page
	
	#Check Your Answers Now
	
	When I click on the "Newid" link in the same row as "Cadarnhewch ddyddiad ei wasanaeth rheithgor"
	Then I see "Gwiriwch eich dyddiad dechrau" on the page
	
	#Confirm Date of Jury Service
	
	When I set the radio button to "Nac ydi, ni all yr unigolyn wasanaethu ar reithgor a rhaid esgusodi"
	And I press the "Parhau" button
	Then I see "Pam fod angen iddo gael ei esgusodi rhag gwasanaethu ar reithgor?" on the page
	
	#Excusal Reason
	
	When I do not see "Gwasanaeth newydd yw hwn – bydd eich adborth yn ein helpu i’w wella" on the page
	And I set text area with "id" of "excusalReason" to "Excuse them please"
	And I press the "Parhau" button
	Then I see "Gwiriwch eich ymatebion nawr" on the page
	
	When I check the "Hyd gwn i, mae'r wybodaeth rwyf wedi ei rhoi am yr unigolyn rwyf yn ymateb ar ei ran yn gywir." checkbox
	And I press the "Cyflwyno" button
	
	#When I press the "Submit" button
	
	Then I see "Rydym wedi anfon e-bost i ddweud eich bod wedi ymateb i'r wŷs hon." on the page
	And I do not see "Gwasanaeth newydd yw hwn – bydd eich adborth yn ein helpu i’w wella" on the page
	
Examples:
	|part_no	|last_name	|postcode	|email 		|pool_no	|
	|841500099	|LNAME99	|CH1 2AN	|a@eeee.com	|415181001	|