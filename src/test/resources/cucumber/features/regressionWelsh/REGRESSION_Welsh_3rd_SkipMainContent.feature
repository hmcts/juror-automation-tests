Feature: Welsh_3rd_SkipMainContent

@RegressionWelsh @NewSchemaConverted
Scenario Outline: Welsh 3rd Party Straight Through with Skip to Main Content Checks

	Given I am on the welsh version of "Public" "test"

	Given a bureau owned pool is created with jurors
		| court |juror_number  | pool_number	| att_date_weeks_in_future	| owner |
		| 457   |<juror_number>| <pool_number>	| 5				            | 400	|

	And juror "<juror_number>" has "LAST_NAME" as "<last_name>" new schema
	And juror "<juror_number>" has "POSTCODE" as "<postcode>" new schema
	
	#Skip to main content check
	#Reply to jury summons
	When I hit the tab key
	Then I see "Ymlaen i'r prif gynnwys" on the page
	When I click on the "Ymlaen i'r prif gynnwys" link
	Then I see "Ymateb i wŷs rheithgor" on the page
	
	#Skip to main content check
	Then I hit the tab key
	Then I see "Ymlaen i'r prif gynnwys" on the page
	Then I click on the "Ymlaen i'r prif gynnwys" link
	Then I see "A ydych yn ymateb dros eich hun neu ar ran rhywun arall?" on the page
	
	And I set the radio button to "Rwy'n ymateb ar ran rhywun arall"
	And I press the "Parhau" button
	
	#Skip to main content check
	Then I hit the tab key
	Then I see "Ymlaen i'r prif gynnwys" on the page
	Then I click on the "Ymlaen i'r prif gynnwys" link
	Then I see "Ei fanylion rheithiwr" on the page
	
	When I set "Rhif rheithiwr – 9 digid" to "<juror_number>"
	When I set "Cyfenw'r Rheithiwr" to "<last_name>"
	When I set "Cod post Rheithiwr" to "<postcode>"
	And I press the "Parhau" button
	
	#Skip to main content check
	Then I hit the tab key
	Then I see "Ymlaen i'r prif gynnwys" on the page
	Then I click on the "Ymlaen i'r prif gynnwys" link
	Then I see "Beth yw eich enw?" on the page
	
	When I set "Enw cyntaf" to "FirstNameA"
	And I set "Cyfenw" to "LastNameB"
	And I press the "Parhau" button
	
	#Skip to main content check
	Then I hit the tab key
	Then I see "Ymlaen i'r prif gynnwys" on the page
	Then I click on the "Ymlaen i'r prif gynnwys" link
	Then I see "Eich perthynas â'r unigolyn" on the page
	
	When I set "Sut ydych chi'n adnabod yr unigolyn rydych yn ymateb ar ei ran?" to "Friend"
	And I press the "Parhau" button
	
	#Skip to main content check
	Then I hit the tab key
	Then I see "Ymlaen i'r prif gynnwys" on the page
	Then I click on the "Ymlaen i'r prif gynnwys" link
	Then I see "Eich manylion cyswllt" on the page
	
	When I check the "Dros y ffôn (rhifau yn y DU yn unig)" checkbox
	And I check the "Trwy e-bost" checkbox
	And I set "Prif rif ffôn" to "0207 821 1818"
	And I set "Nodwch gyfeiriad e-bost" to "email@outlook.com"
	And I set "Nodwch gyfeiriad e-bost eto" to "email@outlook.com"
	And I press the "Parhau" button
	
	#Skip to main content check
	Then I hit the tab key
	Then I see "Ymlaen i'r prif gynnwys" on the page
	Then I click on the "Ymlaen i'r prif gynnwys" link
	Then I see "Pam ydych chi'n ymateb ar ran yr unigolyn arall?" on the page
	
	And I set the radio button to "Nid yw'r unigolyn yma"
	And I press the "Parhau" button
	
	#Skip to main content check
	Then I hit the tab key
	Then I see "Ymlaen i'r prif gynnwys" on the page
	Then I click on the "Ymlaen i'r prif gynnwys" link
	Then I see "A yw'r enw sydd gennym ar ei gyfer yn gywir?" on the page
	And I set the radio button to "Ydy"
	And I press the "Parhau" button

	#Skip to main content check
	Then I hit the tab key
	Then I see "Ymlaen i'r prif gynnwys" on the page
	Then I click on the "Ymlaen i'r prif gynnwys" link
	Then I see "Ei gyfeiriad ef yw hwn?" on the page
	And I set the radio button to "Ie"
	And I press the "Parhau" button
	
	#Skip to main content check
	Then I hit the tab key
	Then I see "Ymlaen i'r prif gynnwys" on the page
	Then I click on the "Ymlaen i'r prif gynnwys" link
	Then I see "Nodwch ddyddiad geni'r unigolyn rydych chi'n ymateb ar ei ran" on the page
	
	When I set "Diwrnod" to "27"
	And I set "Mis" to "04"
	And I set "Blwyddyn" to "1981"
	And I press the "Parhau" button
	
	#Skip to main content check
	Then I hit the tab key
	Then I see "Ymlaen i'r prif gynnwys" on the page
	Then I click on the "Ymlaen i'r prif gynnwys" link
	Then I see "Efallai bydd yn rhaid inni gysylltu â'r unigolyn i ofyn rhagor o gwestiynau neu roi rhagor o wybodaeth iddynt am eu gwasanaeth rheithgor" on the page
	
	When I set the radio button to "Defnyddio'r rhif ffôn rydych eisoes wedi'i ddarparu i gysylltu â chi"
	When I set the radio button to "Defnyddio'r cyfeiriad e-bost rydych eisoes wedi'i ddarparu i gysylltu â chi"
	And I press the "Parhau" button
	
	#Skip to main content check
	Then I hit the tab key
	Then I see "Ymlaen i'r prif gynnwys" on the page
	Then I click on the "Ymlaen i'r prif gynnwys" link
	Then I see "Cadarnhau a yw'r unigolyn yn gymwys i wasanaethu ar reithgor" on the page

	And I press the "Parhau" button
	
	#Skip to main content check
	Then I hit the tab key
	Then I see "Ymlaen i'r prif gynnwys" on the page
	Then I click on the "Ymlaen i'r prif gynnwys" link
	Then I see "Ers iddynt droi'n 13 oed, a yw eu prif gyfeiriad wedi bod yn y DU, Ynysoedd y Sianel neu Ynys Manaw am unrhyw gyfnod o 5 mlynedd o leiaf?" on the page
	
	When I set the radio button to "Do"
	And I press the "Parhau" button
	
	#Skip to main content check
	Then I hit the tab key
	Then I see "Ymlaen i'r prif gynnwys" on the page
	Then I click on the "Ymlaen i'r prif gynnwys" link
	Then I see "A yw'r person yr ydych yn ymateb ar ei ran wedi gweithio yn y system cyfiawnder troseddol yn y 5 mlynedd diwethaf?" on the page
	
	When I set the radio button to "Nac ydy"
	And I press the "Parhau" button	
	
	#Skip to main content check
	Then I hit the tab key
	Then I see "Ymlaen i'r prif gynnwys" on the page
	Then I click on the "Ymlaen i'r prif gynnwys" link
	Then I see "A yw'r unigolyn ar fechnïaeth ar hyn o bryd am gyflawni trosedd?" on the page
	
	When I set the radio button to "Nac ydy"
	And I press the "Parhau" button
	
	#Skip to main content check
	Then I hit the tab key
	Then I see "Ymlaen i'r prif gynnwys" on the page
	Then I click on the "Ymlaen i'r prif gynnwys" link
	Then I see "A yw'r unigolyn wedi'i gael yn euog o drosedd?" on the page
	
	When I set the radio button to "Nac ydy"
	And I press the "Parhau" button
	
	#Skip to main content check
	Then I hit the tab key
	Then I see "Ymlaen i'r prif gynnwys" on the page
	Then I click on the "Ymlaen i'r prif gynnwys" link
	Then I see "A ydi'r person yr ydych yn ymateb ar ei ran yn cael ei gadw, ei warchod neu ei drin o dan y Ddeddf Iechyd Meddwl?" on the page
	
	When I set the radio button to "Na"
	And I press the "Parhau" button
	
	#Skip to main content check
	Then I hit the tab key
	Then I see "Ymlaen i'r prif gynnwys" on the page
	Then I click on the "Ymlaen i'r prif gynnwys" link
	Then I see "A wnaed penderfyniad nad oes gan y person yr ydych yn ymateb ar ei ran y 'gallu meddyliol'?" on the page
	
	When I set the radio button to "Na"
	And I press the "Parhau" button
	
	#Skip to main content check
	Then I hit the tab key
	Then I see "Ymlaen i'r prif gynnwys" on the page
	Then I click on the "Ymlaen i'r prif gynnwys" link
	Then I see "Gwiriwch eich dyddiad dechrau" on the page
	
	When I set the radio button to "Ydi, mae'r unigolyn yn gallu dechrau"
	And I press the "Parhau" button
	
	#Skip to main content check
	Then I hit the tab key
	Then I see "Ymlaen i'r prif gynnwys" on the page
	Then I click on the "Ymlaen i'r prif gynnwys" link
	Then I see "A fydd yr unigolyn rydych yn ymateb ar ei ran angen cymorth pan fydd yn y llys?" on the page
	
	When I set the radio button to "Nac oes"
	And I press the "Parhau" button
	
	#Skip to main content check
	Then I hit the tab key
	Then I see "Ymlaen i'r prif gynnwys" on the page
	Then I click on the "Ymlaen i'r prif gynnwys" link
	Then I see "Gwiriwch eich ymatebion nawr" on the page
	
	Then I check the "Hyd gwn i, mae'r wybodaeth rwyf wedi ei rhoi am yr unigolyn rwyf yn ymateb ar ei ran yn gywir." checkbox
	
	When I press the "Cyflwyno" button

	#Skip to main content check
	Then I hit the tab key
	Then I see "Ymlaen i'r prif gynnwys" on the page
	Then I click on the "Ymlaen i'r prif gynnwys" link
	Then I see "Rydych wedi cwblhau'r broses ymateb" on the page
	
	Then I see "Gallwch chi, neu'r unigolyn rydych wedi ymateb ar ei ran, wylio fideo am beth sy'n digwydd wrth fod yn rheithiwr ar YouTube, fel eu bod yn gwybod beth i'w ddisgwyl. Mae'r fideo'n para 13 munud." on the page

Examples:
	| juror_number	| pool_number	| last_name	| postcode	|
	| 045700051		| 457300051		| DOE		| SW1H 9AJ	|