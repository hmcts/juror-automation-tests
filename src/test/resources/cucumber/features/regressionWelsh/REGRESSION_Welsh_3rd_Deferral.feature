Feature: Regression Welsh_3rd_Deferral

@RegressionWelsh
Scenario Outline: Welsh 3rd Party Deferral

	Given I am on the welsh version of "Public" "ithc"

	Given a bureau owned pool is created with jurors
		| court | juror_number  	| pool_number	| att_date_weeks_in_future	| owner |
		| 457   | <juror_number>	| <pool_number>	| 5				            | 400	|

	And juror "<juror_number>" has "LAST_NAME" as "<last_name>" new schema
	And juror "<juror_number>" has "POSTCODE" as "<postcode>" new schema

	And I see "Rwy'n ymateb ar ran rhywun arall" on the page
	And I see "Rwy'n ymateb dros fy hun" on the page
	And I set the radio button to "Rwy'n ymateb ar ran rhywun arall"
	And I press the "Parhau" button
	Then I see "Ei fanylion rheithiwr" on the page
	
	When I set "Rhif rheithiwr" to "<juror_number>"
	When I set "Cyfenw" to "<last_name>"
	When I set "Cod post Rheithiwr" to "<postcode>"
	And I press the "Parhau" button
	
	#3rd Party Name
    When I see "Eich Manylion" on the page
    When I set "Enw cyntaf" to "FirstNameA"
    And I set "Cyfenw" to "LastNameB"
    And I press the "Parhau" button

	Then I see "Eich perthynas â'r unigolyn" on the page

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
	And I press the "Parhau" button
	Then I see "Pam ydych chi'n ymateb ar ran yr unigolyn arall?" on the page
	
	#Why replying
	When I set the radio button to "Nid yw'r unigolyn yma"
	And I press the "Parhau" button
	Then I see "A yw'r enw sydd gennym ar ei gyfer yn gywir?" on the page

	#Juror's Name
	When I set the radio button to "Ydy"
	And I press the "Parhau" button
	Then I see "Ei gyfeiriad ef yw hwn?" on the page
	
	#Check juror address
	When I set the radio button to "Ie"
	And I press the "Parhau" button
	Then I see "Nodwch ddyddiad geni'r unigolyn rydych chi'n ymateb ar ei ran" on the page
	
	#Juror's DOB
	And I set "Diwrnod" to "01"
	And I set "Mis" to "01"
	And I set "Blwyddyn" to "1990"
	And I press the "Parhau" button

	#Checking field
	When I set the radio button to "Defnyddio'r rhif ffôn rydych eisoes wedi'i ddarparu i gysylltu â chi"
	And I set the radio button to "Rhoi cyfeiriad e-bost gwahanol ar gyfer y rheithiwr"
	And I see "Nodwch gyfeiriad e-bost" on the page
	
	And I set the radio button to "Defnyddio'r cyfeiriad e-bost rydych eisoes wedi'i ddarparu i gysylltu â chi"
	And I press the "Parhau" button

	#Qualify for jury service
	When I see "Cadarnhau a yw'r unigolyn yn gymwys i wasanaethu ar reithgor" on the page
	And I press the "Parhau" button
	
	#Residency
	Then I see "Ers iddynt droi'n 13 oed, a yw eu prif gyfeiriad wedi bod yn y DU, Ynysoedd y Sianel neu Ynys Manaw am unrhyw gyfnod o 5 mlynedd o leiaf?" on the page
	When I see "Cymhwysedd" on the page
	And I set the radio button to "Do"
	And I press the "Parhau" button
	
	#CJS
	Then I see "A yw'r person yr ydych yn ymateb ar ei ran wedi gweithio yn y system cyfiawnder troseddol yn y 5 mlynedd diwethaf?" on the page
	When I set the radio button to "Nac ydy"
	And I press the "Parhau" button
	
	#Bail
	Then I see "A yw'r unigolyn ar fechnïaeth ar hyn o bryd am gyflawni trosedd?" on the page
	When I see "Cymhwysedd" on the page
	And I set the radio button to "Nac ydy"
	And I press the "Parhau" button
	
	#Convictions
	Then I see "A yw'r unigolyn wedi'i gael yn euog o drosedd?" on the page
	When I see "Cymhwysedd" on the page
	And I set the radio button to "Nac ydy"
	And I press the "Parhau" button
	
	#Mental Health Sectioned
	Then I see "A ydi'r person yr ydych yn ymateb ar ei ran yn cael ei gadw, ei warchod neu ei drin o dan y Ddeddf Iechyd Meddwl?" on the page
	When I see "Cymhwysedd" on the page
	And I set the radio button to "Na"
	And I press the "Parhau" button
	
	#Mental Health Capacity
	Then I see "A wnaed penderfyniad nad oes gan y person yr ydych yn ymateb ar ei ran y 'gallu meddyliol'?" on the page
	When I see "Cymhwysedd" on the page
	And I set the radio button to "Na"
	And I press the "Parhau" button
	
	#can you attend
	Then I see "Ydi'r unigolyn yn gallu dechrau gwasanaeth rheithgor ar y dyddiad hwn?" on the page

	When I click on the "A fydd angen i'r unigolyn wasanaethu am fwy na phythefnos?" link
	Then I see "Dim ond pythefnos y mae angen i'r rhan fwyaf o bobl wasanaethu ar reithgor." on the page
	And I see "Efallai y bydd y llys yn gofyn iddynt wasanaethu am fwy o amser pan fyddant yn cyrraedd y llys." on the page
	And I see "Os nad ydynt yn gallu gwasanaethu am fwy na phythefnos, gallant drafod hyn gyda rheolwr y rheithgor yn y llys." on the page

	When I click on the "Beth os oes problem yn nes at yr amser ac nid ydynt yn gallu gwasanaethu?" link
	Then I see "Rhaid i chi neu nhw gysylltu â ni bryd hynny i roi gwybod i ni." on the page

	And I press the "Parhau" button
	Then I see "Dewiswch os ydi'r unigolyn yn gallu dechrau gwasanaeth rheithgor ar y dyddiad hwn ai peidio" on the page

	When I set the radio button to "Nac ydi, rhaid newid y dyddiad"
	And I press the "Parhau" button

	Then I see "Mae'n rhaid iddynt gael rheswm da dros newid dyddiad, er enghraifft" on the page
	
	#Reasons for Deferral Request
	And I see "steps/confirm-date/deferral-reason/tp" in the URL
	
	And I press the "Parhau" button
	Then I see "Nodwch eu rheswm dros fod angen dyddiad arall ar gyfer eu gwasanaeth rheithgor" on the page
	
	When I set text area with "id" of "deferralReason" to "Large amount of text here Large amount of text here Large amount of text here Large amount of text here Large amount of text here Large amount of text here Large amount of text here Large amount of text here Large amount of text here Large amount of text here Large amount of text here Large amount of text here Large amount of text here Large amount of text here Large amount of text here Large amount of text here Large amount of text here Large amount of text here Large amount of text here Large amount of text here Large amount of text here Large amount of text here Large amount of text here Large amount of text here Large amount of text here Large amount of text here Large amount of text here Large amount of text here Large amount of text here Large amount of text here Large amount of text here Large amount of text here Large amount of text here Large amount of text here Large amount of text here Large amount of text here Large amount of text here Large amount of text here Large amount of text here "
	And I see "Mae gennych 14 nod yn ormod" on the page
	
	And I press the "Parhau" button
	And I see "Os gwelwch yn dda, sicrhewch fod hyd y rheswm yn llai na 1000 o nodau" on the page
	
	When I set text area with "id" of "deferralReason" to "Reasons for deferral request"
	And I press the "Parhau" button
	Then I see "Dewiswch 3 dydd Llun pan allant ddechrau gwasanaeth rheithgor" on the page
	
	#Deferral Date Screen Layout
	And I see "steps/confirm-date/deferral-dates/tp" in the URL
	
	When I set the "First" single date field to a Monday "6" weeks in the future
	When I set the "Second" single date field to a Monday "7" weeks in the future
	When I set the "Third" single date field to a Monday "8" weeks in the future
	And I press the "Parhau" button
	
	#confirm dates
	When I set the radio button to "Ydw"
	And I press the "Parhau" button
	
	#Special Reqs
	Then I see "A fydd yr unigolyn rydych yn ymateb ar ei ran angen cymorth pan fydd yn y llys?" on the page
	When I set the radio button to "Nac oes"
	When I press the "Parhau" button
	
	#Check your answers page
	And on the page I see
	|text|
	|Gwiriwch eich ymatebion nawr|
	|Bu ichi ymateb i'r dyddiad arfaethedig ar gyfer y gwasanaeth rheithgor|
	|Dywedwch wrthym pam fod angen dyddiad arall arnynt ar gyfer y gwasanaeth rheithgo|
	|Rydw i angen newid dyddiad y gwasanaeth rheithgor ar gyfer yr unigolyn rwy'n ymateb ar ei ran|
	|Reasons for deferral request|
	|Dewiswch 3 dydd Llun pan allant ddechrau gwasanaeth rheithgor|
	|Dewis cyntaf|
	|Ail ddewis|
	|Trydydd dewis|

	Then I check the "wybodaeth rwyf wedi ei rhoi am yr unigolyn rwyf yn ymateb ar ei ran yn gywir." checkbox
	When I press the "Cyflwyno" button

	Then I see "Rydych wedi cwblhau'r broses ymateb" on the page
	Then I see "<juror_number>" on the page

	And I see "Byddwn yn ysgrifennu at yr unigolyn rydych wedi ymateb ar ei ran yn y 7 diwrnod nesaf i roi gwybod iddynt os gallant newid dyddiad eu gwasanaeth rheithgor." on the page
	And I see "Yna, o leiaf bythefnos cyn i'w gwasanaeth rheithgor ddechrau, byddwn yn anfon y canlynol atynt:" on the page

	Given I am on "Bureau" "ithc"
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
    Given I am on "Bureau" "test"
	And I log in as "ARAMIS1"
	Then I see "<juror_number>" on the page
	Then I see "<juror_number>" has reply type indicator "Deferral"

Examples:
	| juror_number	| last_name			| postcode	| pool_number	|
	| 045700073		| LNAMESIXSIXZERO	| CH1 2AN	| 457300073		|

  @RegressionSingle
  Scenario Outline: Welsh 3rd Party Deferral - Bank Holiday

    Given I am on the welsh version of "Public" "ithc"

    Given a bureau owned pool is created with jurors
      | court | juror_number   | pool_number   | att_date_weeks_in_future | owner |
      | 452   | <juror_number> | <pool_number> | 5                        | 400   |

    And juror "<juror_number>" has "LAST_NAME" as "<last_name>" new schema
    And juror "<juror_number>" has "POSTCODE" as "<postcode>" new schema

    And I see "Rwy'n ymateb ar ran rhywun arall" on the page
    And I see "Rwy'n ymateb dros fy hun" on the page
    And I set the radio button to "Rwy'n ymateb ar ran rhywun arall"
    And I press the "Parhau" button
    Then I see "Ei fanylion rheithiwr" on the page

    When I set "Rhif rheithiwr" to "<juror_number>"
    When I set "Cyfenw" to "<last_name>"
    When I set "Cod post Rheithiwr" to "<postcode>"
    And I press the "Parhau" button

	#3rd Party Name
    When I see "Eich Manylion" on the page
    When I set "Enw cyntaf" to "FirstNameA"
    And I set "Cyfenw" to "LastNameB"
    And I press the "Parhau" button
    Then I see "Eich perthynas â'r unigolyn" on the page

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
    And I press the "Parhau" button
    Then I see "Pam ydych chi'n ymateb ar ran yr unigolyn arall?" on the page

	#Why replying
    When I set the radio button to "Nid yw'r unigolyn yma"
    And I press the "Parhau" button
    Then I see "A yw'r enw sydd gennym ar ei gyfer yn gywir?" on the page

	#Juror's Name
    When I set the radio button to "Ydy"
    And I press the "Parhau" button
    Then I see "Ei gyfeiriad ef yw hwn?" on the page

	#Check juror address
    When I set the radio button to "Ie"
    And I press the "Parhau" button
    Then I see "Nodwch ddyddiad geni'r unigolyn rydych chi'n ymateb ar ei ran" on the page

	#Juror's DOB
    And I set "Diwrnod" to "01"
    And I set "Mis" to "01"
    And I set "Blwyddyn" to "1990"
    And I press the "Parhau" button

	#Checking field JDB-3106
    When I set the radio button to "Defnyddio'r rhif ffôn rydych eisoes wedi'i ddarparu i gysylltu â chi"
    And I set the radio button to "Rhoi cyfeiriad e-bost gwahanol ar gyfer y rheithiwr"
    And I see "Nodwch gyfeiriad e-bost" on the page

    And I set the radio button to "Defnyddio'r cyfeiriad e-bost rydych eisoes wedi'i ddarparu i gysylltu â chi"
    And I press the "Parhau" button

	#Qualify for jury service JDB-3107
    When I see "Cadarnhau a yw'r unigolyn yn gymwys i wasanaethu ar reithgor" on the page
    And I press the "Parhau" button

	#Residency
    Then I see "Ers iddynt droi'n 13 oed, a yw eu prif gyfeiriad wedi bod yn y DU, Ynysoedd y Sianel neu Ynys Manaw am unrhyw gyfnod o 5 mlynedd o leiaf?" on the page
    When I see "Cymhwysedd" on the page
    And I set the radio button to "Do"
    And I press the "Parhau" button

	#CJS
    Then I see "A yw'r person yr ydych yn ymateb ar ei ran wedi gweithio yn y system cyfiawnder troseddol yn y 5 mlynedd diwethaf?" on the page
    When I set the radio button to "Nac ydy"
    And I press the "Parhau" button

	#Bail
    Then I see "A yw'r unigolyn ar fechnïaeth ar hyn o bryd am gyflawni trosedd?" on the page
    When I see "Cymhwysedd" on the page
    And I set the radio button to "Nac ydy"
    And I press the "Parhau" button

	#Convictions
    Then I see "A yw'r unigolyn wedi'i gael yn euog o drosedd?" on the page
    When I see "Cymhwysedd" on the page
    And I set the radio button to "Nac ydy"
    And I press the "Parhau" button

	#Mental Health Sectioned
    Then I see "A ydi'r person yr ydych yn ymateb ar ei ran yn cael ei gadw, ei warchod neu ei drin o dan y Ddeddf Iechyd Meddwl?" on the page
    When I see "Cymhwysedd" on the page
    And I set the radio button to "Na"
    And I press the "Parhau" button

	#Mental Health Capacity
    Then I see "A wnaed penderfyniad nad oes gan y person yr ydych yn ymateb ar ei ran y 'gallu meddyliol'?" on the page
    When I see "Cymhwysedd" on the page
    And I set the radio button to "Na"
    And I press the "Parhau" button

	#can you attend
    Then I see "Ydi'r unigolyn yn gallu dechrau gwasanaeth rheithgor ar y dyddiad hwn?" on the page

    When I click on the "A fydd angen i'r unigolyn wasanaethu am fwy na phythefnos?" link
    Then I see "Dim ond pythefnos y mae angen i'r rhan fwyaf o bobl wasanaethu ar reithgor." on the page
    And I see "Efallai y bydd y llys yn gofyn iddynt wasanaethu am fwy o amser pan fyddant yn cyrraedd y llys." on the page
    And I see "Os nad ydynt yn gallu gwasanaethu am fwy na phythefnos, gallant drafod hyn gyda rheolwr y rheithgor yn y llys." on the page

    When I click on the "Beth os oes problem yn nes at yr amser ac nid ydynt yn gallu gwasanaethu?" link
    Then I see "Rhaid i chi neu nhw gysylltu â ni bryd hynny i roi gwybod i ni." on the page

    And I press the "Parhau" button
    Then I see "Dewiswch os ydi'r unigolyn yn gallu dechrau gwasanaeth rheithgor ar y dyddiad hwn ai peidio" on the page

    When I set the radio button to "Nac ydi, rhaid newid y dyddiad"
    And I press the "Parhau" button

	#JDB-3448 and JDB-3503
    Then I see "Mae'n rhaid iddynt gael rheswm da dros newid dyddiad, er enghraifft" on the page

	#Reasons for Deferral Request
    And I see "steps/confirm-date/deferral-reason/tp" in the URL

    And I press the "Parhau" button
    Then I see "Nodwch eu rheswm dros fod angen dyddiad arall ar gyfer eu gwasanaeth rheithgor" on the page

    When I set text area with "id" of "deferralReason" to "Large amount of text here Large amount of text here Large amount of text here Large amount of text here Large amount of text here Large amount of text here Large amount of text here Large amount of text here Large amount of text here Large amount of text here Large amount of text here Large amount of text here Large amount of text here Large amount of text here Large amount of text here Large amount of text here Large amount of text here Large amount of text here Large amount of text here Large amount of text here Large amount of text here Large amount of text here Large amount of text here Large amount of text here Large amount of text here Large amount of text here Large amount of text here Large amount of text here Large amount of text here Large amount of text here Large amount of text here Large amount of text here Large amount of text here Large amount of text here Large amount of text here Large amount of text here Large amount of text here Large amount of text here Large amount of text here "
    And I see "Mae gennych 14 nod yn ormod" on the page

    And I press the "Parhau" button
    And I see "Os gwelwch yn dda, sicrhewch fod hyd y rheswm yn llai na 1000 o nodau" on the page

    When I set text area with "id" of "deferralReason" to "Reasons for deferral request"
    And I press the "Parhau" button
    Then I see "Dewiswch 3 dydd Llun pan allant ddechrau gwasanaeth rheithgor" on the page

	#JDB-3445 Deferral Date Screen Layout
    And I see "steps/confirm-date/deferral-dates/tp" in the URL

    And I create a bank holiday "6" Mondays in the future for court/bureau "400" new schema

    When I set the "First" single date field to a Monday "6" weeks in the future
    When I set the "Second" single date field to a Monday "7" weeks in the future
    When I set the "Third" single date field to a Monday "8" weeks in the future
    And I press the "Parhau" button

	#confirm dates
    When I set the radio button to "Ydw"
    And I press the "Parhau" button

	#Bank holiday
    And on the page I see
      | text                                                                                                                            |
      | Mae o leiaf un dydd Llun a ddewiswyd gennych yn ŵyl banc                                                                        |
      | Rydych chi wedi dewis o leiaf un dydd Llun sy'n ŵyl banc yn y DU.                                                               |
      | Os byddwn yn dewis hwn fel eu dyddiad dechrau, bydd eu gwasanaeth rheithgor yn dechrau ar y dydd Mawrth canlynol ar y cynharaf. |
      | Byddwn yn anfon cadarnhad o'r dyddiad dechrau maes o law.                                                                       |

    And I press the "Parhau" button

	#Special Reqs
    Then I see "A fydd yr unigolyn rydych yn ymateb ar ei ran angen cymorth pan fydd yn y llys?" on the page
    When I set the radio button to "Nac oes"
    When I press the "Parhau" button

	#Check your answers page
    Then I see "Gwiriwch eich ymatebion nawr" on the page

    Then I check the "wybodaeth rwyf wedi ei rhoi am yr unigolyn rwyf yn ymateb ar ei ran yn gywir." checkbox
    When I press the "Cyflwyno" button

    Then I see "Rydych wedi cwblhau'r broses ymateb" on the page
    Then I see "Rydych wedi cwblhau'r broses ymateb" on the page
    Then I see "<juror_number>" on the page

    And I see "Byddwn yn ysgrifennu at yr unigolyn rydych wedi ymateb ar ei ran yn y 7 diwrnod nesaf i roi gwybod iddynt os gallant newid dyddiad eu gwasanaeth rheithgor." on the page
    And I see "Yna, o leiaf bythefnos cyn i'w gwasanaeth rheithgor ddechrau, byddwn yn anfon y canlynol atynt:" on the page

    And I click on the "Lawrlwythwch gopi o'ch ymateb i'r wŷs HTML" link

    And on the page I see
      | text                                                                               |
      | Bu ichi ymateb i’r dyddiad arfaethedig ar gyfer y gwasanaeth rheithgor             |
      | Dywedwch wrthym pam fod angen dyddiad arall arnynt ar gyfer y gwasanaeth rheithgor |
      | Rydw i angen newid dyddiad y gwasanaeth rheithgor                                  |
      | Reasons for deferral request                                                       |
      | Dewiswch 3 dydd Llun pan allant ddechrau gwasanaeth rheithgor                      |
      | Dewis cyntaf                                                                       |
      | Ail ddewis                                                                         |
      | Trydydd dewis                                                                      |

    And I delete bank holiday new schema

    Examples:
      | juror_number | last_name       | postcode | pool_number |
      | 045200248    | LNAMESIXSIXZERO | SW1H 9AJ | 452300225   |