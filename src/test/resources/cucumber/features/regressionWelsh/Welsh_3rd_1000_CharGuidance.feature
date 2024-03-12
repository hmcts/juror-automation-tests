Feature: Welsh_3rd_1000_CharGuidance

@RegressionWelsh @JDB-3634 @JDB-3618 @JDB-3620 @JDB-3621 @JDB-3622 @JDB-3623 @JDB-3624 @JDB-3625 @JDB-3626 @JDB-3627 @JDB-3628 
@JDB-3653 
Scenario Outline: Welsh 3rd Party - Character count warning should be on all applicable pages
	Given I am on the welsh version of "Public" "bau-test"
	Given the juror numbers have not been processed
		| part_no 	| pool_no 	| owner |
		| <part_no> |<pool_no>	| 400 	|
	
	And juror "<juror_number>" has "LAST_NAME" as "<last_name>" new schema


	And juror "<juror_number>" has "POSTCODE" as "<postcode>" new schema

	And I set the radio button to "Rwy'n ymateb ar ran rhywun arall"
	And I press the "Parhau" button	
	
	#Juror Log In
	
	When I set "Rhif rheithiwr" to "<juror_number>"
	When I set "Cyfenw" to "<last_name>"
	When I set "Cod post Rheithiwr" to "<postcode>"
	And I press the "Parhau" button
    Then I see "Beth yw eich enw?" on the page
	
	#3rd Party Name
	
	When I see "Eich Manylion" on the page
	When I set "Enw cyntaf" to "FirstNameA"
	And I set "Cyfenw" to "LastNameB"
	And I press the "Parhau" button
	Then I see "Eich perthynas â'r unigolyn" on the page
	
	#Relationship to juror
	
	When I see "Eich Manylion" on the page
	And I set "Sut ydych chi'n adnabod yr unigolyn rydych yn ymateb ar ei ran?" to "Friend"
	And I press the "Parhau" button
	Then I see "Eich manylion cyswllt" on the page
	
	#3rd Party Contact
	
	When I see "Eich Manylion" on the page
	And I check the "Dros y ffôn (rhifau yn y DU yn unig)" checkbox
	And I set "Prif rif ffôn" to "0207 821 1818"
	And I check the "Trwy e-bost" checkbox
	And I set "Nodwch gyfeiriad e-bost" to "email@outlook.com"
	And I set "Nodwch gyfeiriad e-bost eto" to "email@outlook.com"
	And I press the "Parhau" button
	Then I see "Pam ydych chi'n ymateb ar ran yr unigolyn arall?" on the page
	And I do not see "Pam ydych chi'n ymateb?" on the page
	
	#Why are you replying for the person? JDB-3634
	
	When I set the radio button to "Arall"
	
	And I see "You have 100 characters remaining" on the page
	And I set the radio button to "Nid yw'r unigolyn yma"
	And I press the "Parhau" button
	Then I see "A yw'r enw sydd gennym ar ei gyfer yn gywir?" on the page
	
	#Check juror name
	
	When I see "Manylion y Rheithiwr" on the page
	When I set the radio button to "Ydy"
	And I press the "Parhau" button
	Then I see "Ei gyfeiriad ef yw hwn?" on the page
	
	#Check juror address
	
	When I see "Manylion y Rheithiwr" on the page
	When I set the radio button to "Ie"
	And I press the "Parhau" button
	Then I see "Nodwch ddyddiad geni'r unigolyn rydych chi'n ymateb ar ei ran" on the page
	
	#DoB
	
	When I see "Manylion y Rheithiwr" on the page
	And I set "Diwrnod" to "27"
	And I set "Mis" to "04"
	And I set "Blwyddyn" to "1981"
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

	#Qualify for jury service
	
	When I see "Cadarnhau a yw'r unigolyn yn gymwys i wasanaethu ar reithgor" on the page
	And I press the "Parhau" button
	
	#Residency JDB-3620
	
	Then I see "Ers iddynt droi'n 13 oed, a yw eu prif gyfeiriad wedi bod yn y DU, Ynysoedd y Sianel neu Ynys Manaw am unrhyw gyfnod o 5 mlynedd o leiaf?" on the page
	When I see "Cymhwysedd" on the page
	And I set the radio button to "Naddo"
	
	And I see "You have 1000 characters remaining" on the page
	And I set "Rhowch fanylion" to "Not a resident"
	And I press the "Parhau" button
	
	#CJS JDB-3625
	
	Then I see "A yw'r person yr ydych yn ymateb ar ei ran wedi gweithio yn y system cyfiawnder troseddol yn y 5 mlynedd diwethaf?" on the page
	When I set the radio button to "Ydy"
	And I check the "Arall" checkbox

	And I see "You have 1000 characters remaining" on the page
	And I set "Pa ran arall o’r System Cyfiawnder Troseddol?" to "Other CJS part"
	And I press the "Parhau" button
	
	#Bail JDB-3623
	
	Then I see "A yw'r unigolyn ar fechnïaeth ar hyn o bryd am gyflawni trosedd?" on the page
	When I see "Cymhwysedd" on the page
	And I set the radio button to "Ydy"
	
	And I see "You have 1000 characters remaining" on the page
	And I set "Rhowch fanylion" to "Person on bail"
	And I press the "Parhau" button
	
	#Convictions JDB-3624
	
	Then I see "A yw'r unigolyn wedi'i gael yn euog o drosedd?" on the page
	When I see "Cymhwysedd" on the page
	And I set the radio button to "Ydy"

	And I see "You have 1000 characters remaining" on the page
	And I set text area with "id" of "convictedDetails" to "Person is convicted"
	And I press the "Parhau" button
	
	#Mental Health Sectioned JDB-3621
	
	Then I see "A ydi'r person yr ydych yn ymateb ar ei ran yn cael ei gadw, ei warchod neu ei drin o dan y Ddeddf Iechyd Meddwl?" on the page
	When I see "Cymhwysedd" on the page
	And I set the radio button to "Ie"
	
	And I see "You have 1000 characters remaining" on the page
	And I set "Eglurwch sut y maent yn cael eu cadw dan glo, sut ofal maent yn ei gael neu sut maent yn cael eu trin o dan y Ddeddf Iechyd" to "Person is sectioned"
	And I press the "Parhau" button
	
	#JDB-3467
	
	Then I see "A wnaed penderfyniad nad oes gan y person yr ydych yn ymateb ar ei ran y 'gallu meddyliol'?" on the page
	
	#Mental Health Capacity JDB-3622
	
	When I see "Cymhwysedd" on the page
	And I set the radio button to "Ie"
	
	And I see "You have 1000 characters remaining" on the page
	And I set "Eglurwch yn gryno pam y penderfynwyd nad oes ganddynt alluedd meddyliol" to "Person lacks capacity"
	And I press the "Parhau" button

	#The person can attend
	
	Then I see "Gwiriwch eich dyddiad dechrau" on the page
	When I set the radio button to "Ydi, mae'r unigolyn yn gallu dechrau"
	And  I press the "Parhau" button
	
	#RA JDB-3627 and JDB-3628
	
	Then I see "A fydd yr unigolyn rydych yn ymateb ar ei ran angen cymorth pan fydd yn y llys?" on the page
	When I set the radio button to "Oes"
	
	And I see "You have 1000 characters remaining" on the page
	And I set "Rhowch wybod inni am unrhyw drefniadau arbennig neu gymorth bydd yr unigolyn rydych yn ymateb ar ei ran ei angen wrth iddo wasanaethu ar reithgor." to "Wheelchair user"
	When I check the "Arall" checkbox
	And I set "Rhowch fanylion os gwelwch yn dda" to "Other RA stuff"
	And I press the "Parhau" button
	
	#Check your answers
	
	Then I see "Gwiriwch eich ymatebion nawr" on the page
	When I click on the "Newid" link in the same row as "Cadarnhewch ddyddiad ei wasanaeth rheithgor"
	Then I see "Gwiriwch eich dyddiad dechrau" on the page
	
	When I set the radio button to "Nac ydi, rhaid newid y dyddiad"
	And I press the "Parhau" button
	Then I see "Dywedwch wrthym pam fod angen dyddiad arall arnynt ar gyfer y gwasanaeth rheithgor" on the page
	
	#Deferral Reason JDB-3626
	
	When I see "You have 1000 characters remaining" on the page
	And I set text area with "id" of "deferralReason" to "Defer them please"
	And I press the "Parhau" button
	Then I see "Dewiswch 3 dydd Llun pan allant ddechrau gwasanaeth rheithgor" on the page
	
	#Deferral Dates
	
	When I set the "First" single date field to a Monday "6" weeks in the future
	When I set the "Second" single date field to a Monday "7" weeks in the future
	When I set the "Third" single date field to a Monday "8" weeks in the future
	And I press the "Parhau" button
	
	#confirm dates
	
	And I set the radio button to "Ydw"
	And I press the "Parhau" button
	
	Then I see "Gwiriwch eich ymatebion nawr" on the page
	
	#Check Your Answers
	
	When I click on the "Newid" link in the same row as "Cadarnhewch ddyddiad ei wasanaeth rheithgor"
	Then I see "Gwiriwch eich dyddiad dechrau" on the page
	
	When I set the radio button to "Nac ydi, ni all yr unigolyn wasanaethu ar reithgor a rhaid esgusodi"
	And I press the "Parhau" button
	Then I see "Pam fod angen iddo gael ei esgusodi rhag gwasanaethu ar reithgor?" on the page
	
	#Excusal Reason JDB-3618
	
	When I see "You have 1000 characters remaining" on the page
	And I set text area with "id" of "excusalReason" to "Excuse them please"
	And I press the "Parhau" button
	Then I see "Gwiriwch eich ymatebion nawr" on the page
	
	#When I press the "Submit" button
	
	When I check the "Hyd gwn i, mae'r wybodaeth rwyf wedi ei rhoi am yr unigolyn rwyf yn ymateb ar ei ran yn gywir." checkbox
	And I press the "Cyflwyno" button
	Then I see "Os byddwn yn cysylltu â nhw, efallai bydd angen iddynt ddarparu eu rhif rheithiwr. Mae'r rhif hefyd ar y llythyr bu inni anfon atynt." on the page
	
Examples:
	|part_no	|last_name	|postcode	|email 		|pool_no	|
	|641500884	|DOE		|SW1H 9AJ	|a@eeee.com	|415170401	|