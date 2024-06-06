Feature: Regression Welsh_1st_ErrorChecks

@RegressionWelsh @NewSchemaConverted
Scenario Outline: Welsh_1st_ErrorChecks - status is Undeliverable

	Given I am on "Bureau" "test"

	Given a bureau owned pool is created with jurors
		| court |juror_number  | pool_number	| att_date_weeks_in_future	| owner |
		| 457   |<juror_number>| <pool_number>	| 5				            | 400	|

	And juror "<juror_number>" has "LAST_NAME" as "<last_name>" new schema
	And juror "<juror_number>" has "POSTCODE" as "<postcode>" new schema

	And I log in as "MODTESTBUREAU"
	And I search for juror "<juror_number>"
	And I press the "Update juror record" button
	And I choose the "Mark summons as undeliverable" radio button
	And I press the "Continue" button
	Then I see the juror record updated banner containing "Summons undeliverable"

  	Given I am on the welsh version of "Public" "test"

	When I set the radio button to "n ymateb dros fy hun"
	And I press the "Parhau" button
	
	When I press the "Parhau" button
	Then I see "Nodwch eich rhif rheithiwr 9 digid - gallwch ddod o hyd iddo ar eich llythyr gwŷs rheithgor" on the page
	And I see "Rhaid i chi nodi eich enw olaf yn union fel y mae'n ymddangos ar eich llythyr gwŷs rheithgor, hyd yn oed os yw'n anghywir" on the page
	And I see "Rhaid i chi nodi eich cod post yn union fel y mae'n ymddangos ar eich llythyr gwŷs rheithgor, hyd yn oed os yw'n anghywir" on the page
	
	Then I click on the "Problemau wrth nodi eich manylion?" link
	And I see "Os ydych wedi gwirio'ch manylion a’ch bod dal methu parhau, gallwch gysylltu â ni." on the page
	And I see "Swyddfa Ganolog Gwysio Rheithgor" on the page
	And I see "jurysummoning@justice.gov.uk" on the page
	And I see "Rhif ffôn: 0300 456 1024" on the page
	And I see "Llinell Gymraeg: 0300 303 5173" on the page
	And I see "Dydd Llun i Ddydd Iau 9am – 5pm" on the page
	And I see "Dydd Gwener 9am – 3pm" on the page
	And I see "Canfod mwy am gostau galwadau" on the page
	
	#Juror Log In
	When I set "Rhif rheithiwr – 9 digid" to "<juror_number>"
	When I set "Cyfenw'r Rheithiwr" to "<last_name>"
	When I set "Cod post Rheithiwr" to "<postcode>"
	And I press the "Parhau" button

	And I see "Mae ein cofnodion yn dangos eich bod eisoes wedi ymateb i'r wŷs rheithgor hon" on the page
	And I see "Os ydych eisiau dweud wrthym am newidiadau neu os ydym wedi gofyn am ragor o wybodaeth gennych, mae angen ichi gysylltu â ni ar e-bost, dros y ffôn neu lythyr." on the page
	And I see "Swyddfa Ganolog Gwysio Rheithgor" on the page
	And I see "jurysummoning@justice.gov.uk" on the page
	And I see "Rhif ffôn: 0300 456 1024" on the page
	And I see "Llinell Gymraeg: 0300 303 5173" on the page
	And I see "Dydd Llun i Ddydd Iau 9am – 5pm" on the page
	And I see "Dydd Gwener 9am – 3pm" on the page
	And I see "Canfod mwy am gostau galwadau" on the page

	And I see "Swyddfa Ganolog Gwysio Rheithgor" on the page
	And I see "Phoenix House" on the page
	And I see "Rushton Avenue" on the page
	And I see "Bradford" on the page
	And I see "BD3 7BH" on the page

	And I see "Ni allwch ddefnyddio'r gwasanaeth digidol hwn i roi gwybodaeth ychwanegol i ni." on the page
	
	Examples:
	| juror_number	| last_name	| postcode	| pool_number	|
	| 045700044		| DOE	 	| SW1H 9AJ	| 457300044		|

@RegressionWelsh @NewSchemaConverted
Scenario Outline: Welsh_1st_ErrorChecks - Court date is in the past

	Given I am on the welsh version of "Public" "test"

	Given a bureau owned pool is created with jurors
		| court |juror_number  | pool_number	| att_date_weeks_in_future	| owner |
		| 457   |<juror_number>| <pool_number>| -1				                | 400	|

	Given a new pool is inserted for where record has transferred to the court new schema
		|part_no         | pool_no       | owner |
		|<juror_number>  | <pool_number> | 457   |

	And juror "<juror_number>" has "LAST_NAME" as "<last_name>" new schema
	And juror "<juror_number>" has "POSTCODE" as "<postcode>" new schema

	When I set the radio button to "n ymateb dros fy hun"
	And I press the "Parhau" button
	
	#Juror Log In
	When I set "Rhif rheithiwr – 9 digid" to "<juror_number>"
	When I set "Cyfenw'r Rheithiwr" to "<last_name>"
	When I set "Cod post Rheithiwr" to "<postcode>"
	And I press the "Parhau" button
	Then I see "Ni allwch gwblhau'r ymateb i wŷs hon ar-lein mwyach" on the page
	Then I see "Mae hyn oherwydd bod dyddiad y wŷs wedi mynd heibio. Rhaid i chi gysylltu â ni dros y ffôn neu drwy e-bost." on the page
	
	Examples:
	| juror_number	| last_name	| postcode	| pool_number	|
	| 045700045		  | DOE		    | SW1H 9AJ	| 457300045		|
	
@RegressionWelsh @NewSchemaConverted
Scenario Outline: Welsh_1st_ErrorChecks
		
	Given I am on the welsh version of "Public" "test"

	Given a bureau owned pool is created with jurors
		| court |juror_number  | pool_number	| att_date_weeks_in_future	| owner |
		| 457   |<juror_number>| <pool_number>	| 5				        	| 400	|

	And juror "<juror_number>" has "LAST_NAME" as "<last_name>" new schema
	And juror "<juror_number>" has "POSTCODE" as "<postcode>" new schema

	And I set the radio button to "n ymateb dros fy hun"
	And I press the "Parhau" button
	
	When I set "Rhif rheithiwr – 9 digid" to "<juror_number>"
	When I set "Cyfenw'r Rheithiwr" to "<last_name>"
	When I set "Cod post Rheithiwr" to "<postcode>"
	And I press the "Parhau" button
	Then I see "A yw'r enw sydd gennym ar eich cyfer chi yn gywir?" on the page

	#Check name
	And I set the radio button to "Nac ydy"
	And I press the "Parhau" button
	
	And I set "Enw cyntaf" to ""
	And I set "Cyfenw" to ""
	And I press the "Parhau" button
	Then I see "Mae problem" on the page
	And I see "Nodwch eich enw cyntaf" on the page
	And I see "Nodwch eich cyfenw" on the page
	When I set "Enw cyntaf" to "FirstName"
	And I set "Cyfenw" to "LastName"
	And I press the "Parhau" button
	Then I see "Eich cyfeiriad chi yw hwn?" on the page
	
	#Check address
	And I set the radio button to "Na"
	And I press the "Parhau" button
	And I set "Llinell Cyfeiriad 1" to ""
	And I set "Tref neu ddinas" to ""
	And I set "Cod post" to ""
	And I press the "Parhau" button
	Then I see "Mae problem" on the page

	And I see "Nodwch linell gyntaf eich cyfeiriad" on the page
	And I see "Nodwch y dref neu'r ddinas lle rydych yn byw" on the page
	And I see "Nodwch eich cod post" on the page
	
	#Checking Invalids check with Jorge
	When I set "Llinell Cyfeiriad 1" to "|||"
	And I set "Tref neu ddinas" to "|||"
	And I set "Sir (dewisol)" to "|||"
	And I set "Cod post" to "|||"
	And I press the "Parhau" button
	Then I see "Mae problem" on the page

	And I see "Gwiriwch linell gyntaf eich cyfeiriad" on the page
	And I see "Gwiriwch y dref neu'r ddinas lle rydych yn byw" on the page
	And I see "Gwiriwch eich sir" on the page
	And I see "Gwiriwch eich cod post" on the page
	When I set "Llinell Cyfeiriad 1" to "123 ADDRESS LINE ONE"
	When I set "Llinell Cyfeiriad 2" to "123 ADDRESS LINE TWO"
	When I set "Llinell Cyfeiriad 3" to "123 ADDRESS LINE THREE"
	And I set "Tref neu ddinas" to "London"
	And I set "Sir (dewisol)" to ""
	And I set "Cod post" to "CH1 2AN"
	And I press the "Parhau" button
	Then I see "Beth yw eich rhif ffôn?" on the page
	
	#Phone details
	When I press the "Parhau" button
	Then I see "Mae problem" on the page
	When I set "Prif rif ffôn" to "0207 821 1818"
	And I press the "Parhau" button
	Then I see "Beth yw eich cyfeiriad e-bost?" on the page
	
	#Email details
	When I press the "Parhau" button
	Then I see "Mae problem" on the page
	And I see "Nodwch eich cyfeiriad e-bost" on the page
	And I see "Nodwch eich cyfeiriad e-bost a gwiriwch eich fod yr un fath â beth sydd yn y blwch cyntaf" on the page
	
	When I set "Nodwch eich cyfeiriad e-bost" to "email@outlook.com"
	And I press the "Parhau" button
	Then I see "Nodwch eich cyfeiriad e-bost a gwiriwch eich fod yr un fath â beth sydd yn y blwch cyntaf" on the page
	
	When I set "Nodwch eich cyfeiriad e-bost" to "email@outlook.com"
	And I set "Nodwch eich cyfeiriad e-bost eto" to "email@outlook.com"
	And I press the "Parhau" button
	Then I see "Beth yw eich dyddiad geni?" on the page
	
	#DoB
	When I press the "Parhau" button
	Then I see "Mae problem" on the page

	And I see "Nodwch y diwrnod y cawsoch eich geni" on the page
	And I do not see "Nodwch y mis y cawsoch eich geni" on the page
	And I do not see "Nodwch y flwyddyn y cawsoch eich geni" on the page
	
	When I set "Diwrnod" to "27"
	And I set "Mis" to "04"
	And I set "Blwyddyn" to "198a"
	And I press the "Parhau" button
	Then I see "Mae problem" on the page

	And I see "Rhowch y flwyddyn y cawsoch eich geni fel rhif 4 digid. Er enghraifft, 1982" on the page
	
	When I set "Diwrnod" to "27"
	And I set "Mis" to "04"
	And I set "Blwyddyn" to "1981"
	And I press the "Parhau" button
	
	Then I see "Cadarnhau a ydych yn gymwys i wasanaethu ar reithgor" on the page
	
	When I press the "Parhau" button
	
	#Residency Yes
	Then I see "Ers i chi droi'n 13 oed, a yw eich prif gyfeiriad wedi bod yn y DU, Ynysoedd y Sianel neu Ynys Manaw am unrhyw gyfnod o 5 mlynedd o leiaf?" on the page
	When I press the "Parhau" button
	Then I see "Mae problem" on the page
	And I see error "Dewiswch do os yw eich prif gyfeiriad wedi bod yn y DU, Ynysoedd y Sianel neu Ynys Manaw am unrhyw gyfnod o 5 mlynedd o leiaf, ers i chi droi'n 13 oed"
	When I set the radio button to "Naddo"
	Then I see "Rhowch fanylion am ble rydych wedi byw ers eich pen-blwydd yn 13 mlwydd oed" on the page
	And I press the "Parhau" button
	Then I see "Mae problem" on the page

	And I see error "Rhowch fanylion am ble rydych wedi byw ers eich pen-blwydd yn 13 mlwydd oed"
	
	When I set the radio button to "Do"
	And I press the "Parhau" button

	#CJS
	Then I see "A ydych chi wedi gweithio yn y system cyfiawnder troseddol yn y 5 mlynedd diwethaf?" on the page
	When I press the "Parhau" button
	Then I see "Mae problem" on the page
	And I see error "Dewiswch a ydych wedi gweithio yn y system cyfiawnder troseddol yn ystod y 5 mlynedd diwethaf"
	
	When I set the radio button to "Ydw"
	Then I see "Dewiswch unrhyw sefydliadau rydych wedi gweithio iddynt." on the page
	And I press the "Parhau" button

	Then I see error "Ticiwch unrhyw sefydliadau rydych wedi gweithio iddynt yn uniongyrchol (nid fel trydydd parti neu is-gontractwr)"
	
	When I check the "Yr heddlu" checkbox
	Then I see "Pa heddlu?" on the page
	And I check the "Gwasanaeth Carchardai EM" checkbox
	Then I see "Pa ran o Wasanaeth Carchardai EM?" on the page
	And I check the "Arall" checkbox
	Then I see "Pa ran arall o’r System Cyfiawnder Troseddol?" on the page
	And I press the "Parhau" button
	Then I see error "Rhowch fanylion am ble a phryd roeddech yn gweithio i'r Heddlu"
	Then I see error "Rhowch fanylion am ble a phryd roeddech yn gweithio i Wasanaeth Carchardai EM"
	Then I see error "Rhowch fanylion am pryd a lle rydych wedi gweithio mewn rhan arall o'r system cyfiawnder troseddol"
	
	Then I uncheck the "Yr heddlu" checkbox
	Then I uncheck the "Gwasanaeth Carchardai EM" checkbox
	Then I uncheck the "Arall" checkbox
	
	When I set the radio button to "Nac ydw"
	And I press the "Parhau" button
	
	#Bail no
	Then I see "Ydych chi ar fechnïaeth ar hyn o bryd am gyflawni trosedd?" on the page
	When I press the "Parhau" button
	Then I see "Mae problem" on the page
	And I see error "Dewiswch Do os ydych ar fechnïaeth ar hyn o bryd am gyflawni trosedd"

	When I set the radio button to "Ydw"
	Then I see "Rhowch fanylion am eich mechnïaeth a'ch trosedd" on the page
	And I press the "Parhau" button
	Then I see "Mae problem" on the page
	Then I see error "Rhowch fanylion am eich mechnïaeth"
	
	When I set the radio button to "Nac ydw"
	And I press the "Parhau" button
	
	#Convictions no
	Then I see "Ydych chi wedi'ch cael yn euog o drosedd?" on the page
	When I press the "Parhau" button
	Then I see "Mae problem" on the page
	And I see error "Dewiswch 'Do' os cawsoch eich cael yn euog o drosedd"
	When I set the radio button to "Do"
	Then I see "Rhowch fanylion am eich trosedd" on the page
	And I press the "Parhau" button
	Then I see "Mae problem" on the page
	And I see error "Rhowch fanylion am eich trosedd"
	
	When I set the radio button to "Naddo"
	And I press the "Parhau" button
	
	#Mental health part 1 no
	Then I see "Ydych chi'n cael eich cadw, yn cael eich gwarchod neu eich trin o dan y Ddeddf Galluedd Meddyliol?" on the page
	When I press the "Parhau" button
	Then I see "Mae problem" on the page
	And I see error "Dewisiwch 'ie' os ydych yn cael eich cadw, eich gwarchod neu eich trin o dan Ddeddf Iechyd Meddwl"
	
	When I set the radio button to "Ie"
	Then I see "Eglurwch sut yr ydych yn cael eich cadw dan glo, sut ofal ydych yn ei gael neu sut yr ydych yn cael eich trin o dan y Ddeddf Iechyd Meddwl" on the page
	And I press the "Parhau" button
	Then I see "Mae problem" on the page
    And I see error "Eglurwch sut yr ydych yn cael eich cadw dan glo, sut ofal ydych yn ei gael neu sut yr ydych yn cael eich trin o dan y Ddeddf Iechyd Meddwl"
	
	When I set the radio button to "Na"
	And I press the "Parhau" button
	
	#Mental health part 2 no
	Then I see "A benderfynwyd nad oes gennych y gallu meddyliol?" on the page
	When I press the "Parhau" button
	Then I see "Mae problem" on the page
	And I see error "Dewiswch 'ie' os penderfyniwyd nad oes gennych y 'gallu meddyliol'"
	
	When I set the radio button to "Ie"
	Then I see "Eglurwch yn gryno pam y penderfynwyd nad oes gennych alluedd meddyliol" on the page
	And I press the "Parhau" button
	Then I see "Mae problem" on the page
	Then I see error "Eglurwch yn gryno pam y penderfynwyd nad oes gennych alluedd meddyliol"
	
	When I set the radio button to "Na"
	And I press the "Parhau" button
	
	#I can attend
	Then I see "Gwiriwch eich dyddiad dechrau" on the page
	
	When I press the "Parhau" button
	Then I see "Mae problem" on the page
	And I see "Gwiriwch eich dyddiad dechrau" on the page
	
	When I set the radio button to "Ydw, rydw i'n gallu dechrau"
	And  I press the "Parhau" button
	
	#RA no
	Then I see "A fyddech chi angen cymorth pan fyddwch yn y llys?" on the page
	When I press the "Parhau" button
	Then I see "Mae problem" on the page
	
	And I see "Dewiswch 'Oes' os byddwch chi angen cymorth pan fyddwch yn y llys" on the page
	
	When I set the radio button to "Oes"
	And I press the "Parhau" button
	Then I see "Mae problem" on the page
	
	And I see "Dewiswch os oes gennych symudedd cyfyngedig, nam ar y clyw, clefyd siwgr, nam difrifol ar eich golwg neu anabledd neu nam o fath arall" on the page
	
	When I check the "Arall" checkbox
	And I press the "Parhau" button
	Then I see "Mae problem" on the page
	And I see "Rhowch fanylion os gwelwch yn dda" on the page
	
	When I set the radio button to "Nac oes"
	And I press the "Parhau" button
	Then I see "Gwiriwch eich ymatebion nawr" on the page
	
	#Check Your Answers
	When I press the "Cyflwyno" button
	Then I see "Mae problem" on the page
	Then I see "Cadarnhewch fod eich gwybodaeth yn gywir cyn ichi anfon eich ymateb" on the page
	
	When I click on the "Newid" link in the same row as "Cadarnhewch ddyddiad eich gwasanaeth rheithgor"
	Then I see "Gwiriwch eich dyddiad dechrau" on the page
	
	When I set the radio button to "Nac ydw, hoffwn newid y dyddiad"
	And I press the "Parhau" button
	Then I see "Dywedwch wrthym pam fod angen dyddiad arall arnoch i wneud eich gwasanaeth rheithgor" on the page
	
	#Deferral Reason
	When I press the "Parhau" button
	Then I see "Mae problem" on the page
	And I see "Dywedwch wrthym pam fod angen dyddiad arall arnoch i wneud eich gwasanaeth rheithgor" on the page
	
	When I set text area with "id" of "deferralReason" to "Defer me please"
	And I press the "Parhau" button
	Then I see "Dewiswch 3 dydd Llun pan allwch ddechrau gwasanaeth rheithgor" on the page
	
	#Deferral Dates
	When I press the "Parhau" button
	Then I see "Mae problem" on the page
	And I see "Rhowch y dydd Llun cyntaf y byddai'n well gennych ddechrau gwasanaeth rheithgor" on the page
	And I see "Rhowch yr ail ddewis o ddydd Llun y byddai'n well gennych ddechrau gwasanaeth rheithgor" on the page
	And I see "Rhowch y trydydd dewis o ddydd Llun y byddai'n well gennych ddechrau gwasanaeth rheithgor" on the page
	
	When I set the "First" single date field to a Monday "16" weeks in the future
	When I set the "Second" single date field to a Monday "16" weeks in the future
	When I set the "Third" single date field to a Monday "18" weeks in the future
	And I press the "Parhau" button
	
	Then I see "Mae problem" on the page
	And I see "Nodwch ddyddiad sy'n wahanol i'ch dewisiadau eraill" on the page
	
	When I set the "First" single date field to a Monday "100" weeks in the future
	When I set the "Second" single date field to a Monday "101" weeks in the future
	When I set the "Third" single date field to a Monday "102" weeks in the future
	And I press the "Parhau" button
	Then I see "Mae problem" on the page
	
	And I see "Rhaid i'ch dewis cyntaf fod yn ddydd Llun rhwng" on the page
	And I see "Rhaid i'ch ail ddewis fod yn ddydd Llun rhwng" on the page
	And I see "Rhaid i'ch trydydd dewis fod yn ddydd Llun rhwng" on the page

	When I set the "First" single date field to a Monday "16" weeks in the future
	When I set the "Second" single date field to a Monday "17" weeks in the future
	When I set the "Third" single date field to a Monday "18" weeks in the future
	And I press the "Parhau" button
	
	And I set the radio button to "Ydw"
	And I press the "Parhau" button
	
	Then I see "Gwiriwch eich ymatebion nawr" on the page
	
	#Check Your Answers
	When I click on the "Newid" link in the same row as "Cadarnhewch ddyddiad eich gwasanaeth rheithgor"
	Then I see "Gwiriwch eich dyddiad dechrau" on the page
	
	When I set the radio button to "Nac ydw, ni allaf wasanaethu ar reithgor a hoffwn gael fy esgusodi"
	And I press the "Parhau" button
	Then I see "Pam fod angen ichi gael eich esgusodi rhag gwasanaethu ar reithgor?" on the page
	
	#Excusal Reason
	When I press the "Parhau" button
	Then I see "Mae problem" on the page
	And I see "Eglurwch pam na allwch chi wasanaethu ar reithgor yn ystod y 12 mis nesaf" on the page
	
	When I set text area with "id" of "excusalReason" to "Excuse me please"
	And I press the "Parhau" button
	Then I see "Gwiriwch eich ymatebion nawr" on the page
	
	#When I press the "Submit" button
	When I check the "Mae'r wybodaeth a roddais uchod yn wir hyd eithaf fy ngwybodaeth." checkbox
	And I press the "Cyflwyno" button
	Then I see "Rydym wedi anfon neges e-bost atoch i gadarnhau eich bod wedi ymateb i’ch gwŷs rheithgor." on the page
	
Examples:
	| juror_number	| last_name				| postcode  | pool_number	|
	| 045700046		| LNAMENINENINEEIGHT	| CH1 2AN	| 457300046		|
	
@RegressionWelsh @NewSchemaConverted
Scenario Outline: Welsh response completed in Juror and login attempted on Digital

Given I am on "Bureau" "test"

Given a bureau owned pool is created with jurors
		| court |juror_number  | pool_number	| att_date_weeks_in_future	| owner |
		| 457   |<juror_number>| <pool_number>| 5				                  | 400	|

	And juror "<juror_number>" has "LAST_NAME" as "<last_name>" new schema
	And juror "<juror_number>" has "POSTCODE" as "<postcode>" new schema

	And I log in as "MODTESTBUREAU"

	And I search for juror "<juror_number>"
	And I click on the "Juror details" link
	And I click on the "Add or change" link
	And I change the jurors date of birth
	And I press the "Save" button
	And I click the update juror record button
	And I choose the "Mark as responded" radio button
	And I press the "Continue" button
	And I check the "Mark juror as 'responded'" checkbox
	And I press the "Confirm" button

	Given I am on the welsh version of "Public" "test"

	Then I see "A ydych yn ymateb dros eich hun neu ar ran rhywun arall?" on the page
	
	When I set the radio button to "n ymateb dros fy hun"
	And I press the "Parhau" button
	Then I see "Eich manylion rheithiwr" on the page
	
	When I set "Rhif rheithiwr – 9 digid" to "<juror_number>"
	And I set "Cyfenw'r Rheithiwr" to "<last_name>"
	And I set "Cod post Rheithiwr" to "<postcode>"
	And I press the "Parhau" button

	And I see "Mae ein cofnodion yn dangos eich bod eisoes wedi ymateb i'r wŷs rheithgor hon" on the page
	And I see "Os ydych eisiau dweud wrthym am newidiadau neu os ydym wedi gofyn am ragor o wybodaeth gennych, mae angen ichi gysylltu â ni ar e-bost, dros y ffôn neu lythyr." on the page
	And I see "Swyddfa Ganolog Gwysio Rheithgor" on the page
	And I see "jurysummoning@justice.gov.uk" on the page
	And I see "Rhif ffôn: 0300 456 1024" on the page
	And I see "Llinell Gymraeg: 0300 303 5173" on the page
	And I see "Dydd Llun i Ddydd Iau 9am – 5pm" on the page
	And I see "Dydd Gwener 9am – 3pm" on the page
	And I see "Canfod mwy am gostau galwadau" on the page

	And I see "Swyddfa Ganolog Gwysio Rheithgor" on the page
	And I see "Phoenix House" on the page
	And I see "Rushton Avenue" on the page
	And I see "Bradford" on the page
	And I see "BD3 7BH" on the page

	And I see "Ni allwch ddefnyddio'r gwasanaeth digidol hwn i roi gwybodaeth ychwanegol i ni." on the page
	
Examples:
	| juror_number	| pool_number | last_name	| postcode |
	| 045700047		| 457300047   |DOE			| SW1H 9AJ |

@RegressionWelsh @NewSchemaConverted
Scenario Outline: Welsh Already Replied info page

	Given I am on the welsh version of "Public" "test"

	Given a bureau owned pool is created with jurors
		| court |juror_number  | pool_number	| att_date_weeks_in_future	| owner |
		| 457   |<juror_number>| <pool_number>	| 5				            | 400	|

	And juror "<juror_number>" has "LAST_NAME" as "<last_name>" new schema
	And juror "<juror_number>" has "POSTCODE" as "<postcode>" new schema

	And I have submitted a first party Welsh ineligibilty response
		| part_no		| pool_number	| last_name		| postcode	| email 	|
		| <juror_number>| <pool_number>	| <last_name>	| <postcode>| <email>	|

	Given I am on the welsh version of "Public" "test"

	Then I see "A ydych yn ymateb dros eich hun neu ar ran rhywun arall?" on the page

	When I set the radio button to "n ymateb dros fy hun"
	And I press the "Parhau" button

	When I set "Rhif rheithiwr – 9 digid" to "<juror_number>"
	And I set "Cyfenw'r Rheithiwr" to "<last_name>"
	And I set "Cod post Rheithiwr" to "<postcode>"
	And I press the "Parhau" button

	And I see "Mae ein cofnodion yn dangos eich bod eisoes wedi ymateb i'r wŷs rheithgor hon" on the page
	And I see "Os ydych eisiau dweud wrthym am newidiadau neu os ydym wedi gofyn am ragor o wybodaeth gennych, mae angen ichi gysylltu â ni ar e-bost, dros y ffôn neu lythyr." on the page
	And I see "Swyddfa Ganolog Gwysio Rheithgor" on the page
	And I see "jurysummoning@justice.gov.uk" on the page
	And I see "Rhif ffôn: 0300 456 1024" on the page
	And I see "Llinell Gymraeg: 0300 303 5173" on the page
	And I see "Dydd Llun i Ddydd Iau 9am – 5pm" on the page
	And I see "Dydd Gwener 9am – 3pm" on the page
	And I see "Canfod mwy am gostau galwadau" on the page

	And I see "Swyddfa Ganolog Gwysio Rheithgor" on the page
	And I see "Phoenix House" on the page
	And I see "Rushton Avenue" on the page
	And I see "Bradford" on the page
	And I see "BD3 7BH" on the page

	And I see "Ni allwch ddefnyddio'r gwasanaeth digidol hwn i roi gwybodaeth ychwanegol i ni." on the page

	Examples:
		| juror_number	| last_name	      	| postcode   | pool_number	| email 		|
		| 045700048		| LNAMESIXSEVENSIX 	| SW1H 9AJ   | 457300048	| e@mail.com 	|