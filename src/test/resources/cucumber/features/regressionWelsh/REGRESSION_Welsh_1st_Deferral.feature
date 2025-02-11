Feature: Regression Welsh_1st_Deferral

@RegressionWelsh
Scenario Outline: Welsh 1st Party Deferral

	Given I am on the welsh version of "Public" "ithc"

	Given a bureau owned pool is created with jurors
		| court |juror_number  | pool_number	| att_date_weeks_in_future	| owner |
		| 457   |<juror_number>| <pool_number>	| 5				            | 400	|

	And juror "<juror_number>" has "LAST_NAME" as "<last_name>" new schema
	And juror "<juror_number>" has "POSTCODE" as "<postcode>" new schema

	And I do not see any links on the page that open to a new page without an alt text
	And I set the radio button to "n ymateb dros fy hun"
	And I press the "Parhau" button
	Then I see "Eich manylion rheithiwr" on the page
	And I do not see any links on the page that open to a new page without an alt text
	
	When I set "Rhif rheithiwr" to "<juror_number>"
	When I set "Cyfenw" to "<last_name>"
	When I set "Cod post Rheithiwr" to "<postcode>"
	And I press the "Parhau" button
	Then I see "A yw'r enw sydd gennym ar eich cyfer chi yn gywir?" on the page
	
	#Juror's details
	And I set the radio button to "Ydy"
	When I press the "Parhau" button
	Then I see "Eich cyfeiriad chi yw hwn?" on the page
	And I do not see any links on the page that open to a new page without an alt text
	
	#Juror's address
	And I set the radio button to "Ie"
	When I press the "Parhau" button
	Then I see "Beth yw eich rhif ffôn?" on the page
	And I do not see any links on the page that open to a new page without an alt text
	
	#Juror's phone
	And I see "Darparwch rif ffôn yn y DU y gallwn ei ddefnyddio i gysylltu â chi rhwng 9am a 5pm, dydd Llun i ddydd Gwener." on the page
	When I set "Prif rif ffôn" to "02078211818"
	And I press the "Parhau" button
	Then I see "Beth yw eich cyfeiriad e-bost?" on the page
	And I do not see any links on the page that open to a new page without an alt text
	
	#Juror's email
	When I see "Pam fod arnom angen eich cyfeiriad e-bost?" on the page
	And I set "Nodwch eich cyfeiriad e-bost" to "email@outlook.com"
	And I set "Nodwch eich cyfeiriad e-bost eto" to "email@outlook.com"
	And I press the "Parhau" button
	Then I see "Beth yw eich dyddiad geni?" on the page
	And I do not see any links on the page that open to a new page without an alt text
	
	#DoB
	And I see "Cymorth gyda'ch dyddiad geni" on the page
	When I set "Diwrnod" to "27"
	And I set "Mis" to "04"
	And I set "Blwyddyn" to "1978"
	And I press the "Parhau" button
	Then I see "Cadarnhau a ydych yn gymwys i wasanaethu ar reithgor" on the page
	And I do not see any links on the page that open to a new page without an alt text
	
	#Do you qualify for jury service?
	When I press the "Parhau" button
	
	#Residency
	Then I see "Ers i chi droi'n 13 oed, a yw eich prif gyfeiriad wedi bod yn y DU, Ynysoedd y Sianel neu Ynys Manaw am unrhyw gyfnod o 5 mlynedd o leiaf?" on the page
	And I do not see any links on the page that open to a new page without an alt text
	And I set the radio button to "Do"
	And I press the "Parhau" button
	And I do not see any links on the page that open to a new page without an alt text

	#CJS
	Then I see "A ydych chi wedi gweithio yn y system cyfiawnder troseddol yn y 5 mlynedd diwethaf?" on the page
	And I do not see any links on the page that open to a new page without an alt text
	And I set the radio button to "Nac ydw"
	And I press the "Parhau" button
	And I do not see any links on the page that open to a new page without an alt text
	
	#Bail
	And I see "Ydych chi ar fechnïaeth ar hyn o bryd am gyflawni trosedd?" on the page
	And I set the radio button to "Nac ydw"
	And I press the "Parhau" button
	And I do not see any links on the page that open to a new page without an alt text

	#Criminal convictions
	And I see "Ydych chi wedi'ch cael yn euog o drosedd?" on the page
	And I set the radio button to "Naddo"
	And I press the "Parhau" button
	And I do not see any links on the page that open to a new page without an alt text
	
	#Mental health sectioned
	And I see "Ydych chi'n cael eich cadw, yn cael eich gwarchod neu eich trin o dan y Ddeddf Galluedd Meddyliol?" on the page
	And I set the radio button to "Na"
	And I press the "Parhau" button
	And I do not see any links on the page that open to a new page without an alt text
	
	#Mental health capacity
	And I see "A benderfynwyd nad oes gennych y gallu meddyliol?" on the page
	And I set the radio button to "Na"
	And I press the "Parhau" button
	And I do not see any links on the page that open to a new page without an alt text
	
	#Can you attend
	And I see "Gwiriwch eich dyddiad dechrau" on the page
	And I see "Rydych wedi cael gwŷs i ddechrau gwasanaeth rheithgor ar" on the page
	And I see "Ydych chi'n gallu dechrau gwasanaeth rheithgor ar y dyddiad hwn?" on the page
	And I see "Ydw, rydw i'n gallu dechrau ar" on the page
	And I see "Nac ydw, hoffwn newid y dyddiad" on the page
	And I see "Nac ydw, ni allaf wasanaethu ar reithgor a hoffwn gael fy esgusodi" on the page
	
	And I click on the "A fydd angen i mi wasanaethu'n hirach na phythefnos?" link
	And I see "Dim ond pythefnos y mae angen i'r rhan fwyaf o bobl wasanaethu ar reithgor." on the page
	And I see "Efallai y bydd y llys yn gofyn i chi wasanaethu am fwy o amser pan fyddwch yn cyrraedd y llys." on the page
	And I see "Os nad ydych yn gallu gwasanaethu am fwy na phythefnos, gallwch drafod hyn gyda rheolwr y rheithgor yn y llys." on the page
	
	And I click on the "Beth os oes problem yn nes at yr amser ac nid wyf yn gallu gwasanaethu?" link
	Then I see "Rhaid i chi gysylltu â ni bryd hynny i roi gwybod i ni." on the page
	
	And I press the "Parhau" button
	And I see "Dewiswch os ydych yn gallu dechrau eich gwasanaeth rheithgor ar y dyddiad hwn ai peidio" on the page
	
	When I set the radio button to "Nac ydw, hoffwn newid y dyddiad"
	And I press the "Parhau" button
	And I do not see any links on the page that open to a new page without an alt text

	And I see "steps/confirm-date/deferral-reason" in the URL
	Then I see "Dywedwch wrthym pam fod angen dyddiad arall arnoch i wneud eich gwasanaeth rheithgor" on the page
	And I see "Mae'n rhaid i chi gael rheswm da dros newid dyddiad, er enghraifft:" on the page
	And I see "gwyliau wedi'i drefnu" on the page
	And I see "llawdriniaeth" on the page
	And I see "arholiad" on the page
	And I see "nid yw eich cyflogwr yn fodlon rhoi amser i ffwrdd o'r gwaith i chi" on the page
	And I see "Dim ond unwaith y gallwch newid y dyddiad." on the page
	And I do not see any links on the page that open to a new page without an alt text
	
	#Deferral Reason
	And I press the "Parhau" button
	And I see "Nodwch y rheswm dros fod angen dyddiad arall ar gyfer eich gwasanaeth rheithgor" on the page
	
	When I set text area with "id" of "deferralReason" to "Large amount of text here Large amount of text here Large amount of text here Large amount of text here Large amount of text here Large amount of text here Large amount of text here Large amount of text here Large amount of text here Large amount of text here Large amount of text here Large amount of text here Large amount of text here Large amount of text here Large amount of text here Large amount of text here Large amount of text here Large amount of text here Large amount of text here Large amount of text here Large amount of text here Large amount of text here Large amount of text here Large amount of text here Large amount of text here Large amount of text here Large amount of text here Large amount of text here Large amount of text here Large amount of text here Large amount of text here Large amount of text here Large amount of text here Large amount of text here Large amount of text here Large amount of text here Large amount of text here Large amount of text here Large amount of text here "
	And I see "Mae gennych 14 nod yn ormod" on the page
	
	And I press the "Parhau" button
	And I see "Os gwelwch yn dda, sicrhewch fod hyd y rheswm yn llai na 1000 o nodau" on the page
	
	When I set text area with "id" of "deferralReason" to "askForAnotherDateReasonWhy"
	And I press the "Parhau" button
	And I do not see any links on the page that open to a new page without an alt text

	And I see "steps/confirm-date/deferral-dates" in the URL
	Then I see "Dewiswch 3 dydd Llun pan allwch ddechrau gwasanaeth rheithgor" on the page
	And I see "Rhaid i'r rhain fod rhwng" on the page
	And I see "Rhaid i chi fod ar gael i wasanaethu am o leiaf pythefnos" on the page
	And I see "Dewis cyntaf" on the page
	And I see "Ail ddewis" on the page
	And I see "Trydydd dewis" on the page
	
	#help text
	And I click on the "A fydd angen i mi wasanaethu'n hirach na phythefnos?" link
	And I see "Dim ond pythefnos y mae angen i'r rhan fwyaf o bobl wasanaethu ar reithgor." on the page
	And I see "Efallai y bydd y llys yn gofyn i chi wasanaethu am fwy o amser pan fyddwch yn cyrraedd y llys." on the page
	And I see "Os nad ydych yn gallu gwasanaethu am fwy na phythefnos, gallwch drafod hyn gyda rheolwr y rheithgor yn y llys." on the page
	Then I click on the "Beth os oes problem yn nes at yr amser ac nid wyf yn gallu gwasanaethu?" link
	Then I see "Rhaid i chi gysylltu â ni bryd hynny i roi gwybod i ni." on the page
	And I do not see any links on the page that open to a new page without an alt text
	
	When I set the "First" single date field to a Monday "6" weeks in the future
	When I set the "Second" single date field to a Monday "7" weeks in the future
	When I set the "Third" single date field to a Monday "8" weeks in the future
	And I press the "Parhau" button
	
	And on the page I see
	|text|
	|Gwiriwch eich dyddiadau|
	|Dyddiadau y gallwch ddechrau gwasanaeth rheithgor|
	|Nid oes angen i chi ddweud wrthym yr holl ddyddiadau eraill rydych ar gael.|
	|Byddwn yn dewis un o'r 3 dyddiad sydd orau gennych.|
	|Os na allwn ddefnyddio un o'r dyddiadau hyn am unrhyw reswm, byddwn yn cysylltu â chi.|
	|Ydych chi am fwrw ymlaen â'r dyddiadau hyn?|
	
	Then I set the radio button to "Ydw"
	And I press the "Parhau" button
	
	#Special Requirements
	And I set the radio button to "Nac oes"
	When I press the "Parhau" button
	And I do not see any links on the page that open to a new page without an alt text
	
	#Check your answers page
	Then I see "Gwiriwch eich ymatebion nawr" on the page
	
	And on the page I see
	|text|
	|Bu ichi ymateb i'r dyddiad arfaethedig ar gyfer eich gwasanaeth rheithgor|
	|Dywedwch wrthym pam fod angen dyddiad arall arnoch i wneud eich gwasanaeth rheithgor|
	|Rwyf angen newid dyddiad fy ngwasanaeth rheithgor|
	|askForAnotherDateReasonWhy|
	|Dewiswch 3 dydd Llun pan allwch ddechrau gwasanaeth rheithgor|
	|Dewis cyntaf|
	|Ail ddewis|
	|Trydydd dewis|

	And I do not see any links on the page that open to a new page without an alt text
	
	Then I check the "Mae'r wybodaeth a roddais uchod yn wir hyd eithaf fy ngwybodaeth." checkbox
	When I press the "Cyflwyno" button
	And I do not see any links on the page that open to a new page without an alt text
	
	Then I see "Rydych wedi cwblhau'r broses ymateb" on the page
	Then I see "<juror_number>" on the page
	And I do not see any links on the page that open to a new page without an alt text

	And I see "Byddwn yn ysgrifennu atoch yn y 7 diwrnod nesaf i roi gwybod ichi os gallwch newid dyddiad eich gwasanaeth rheithgor." on the page
	And I see "Yna, o leiaf bythefnos cyn i'ch gwasanaeth rheithgor ddechrau, byddwn yn anfon y canlynol atoch:" on the page
	And I do not see any links on the page that open to a new page without an alt text
	
	And I click on the "Lawrlwythwch gopi o'ch ymateb i'r wŷs HTML" link
	
	And on the page I see
	|text|
	|Bu ichi ymateb i’r dyddiad arfaethedig ar gyfer y gwasanaeth rheithgor|
	|Dywedwch wrthym pam fod angen dyddiad arall arnoch i wneud eich gwasanaeth rheithgor|
	|Rwyf angen newid dyddiad fy ngwasanaeth rheithgor|
	|askForAnotherDateReasonWhy|
	|Dewiswch 3 dydd Llun pan allwch ddechrau gwasanaeth rheithgor|
	|Dewis cyntaf|
	|Ail ddewis|
	|Trydydd dewis|
	
	Then I press the "back" button on my browser
	And I see "Lawrlwythwch gopi o'ch ymateb i'r wŷs HTML" on the page	
	
Examples:
	| juror_number	| last_name			| postcode	| pool_number	|
	| 045700052		| LNAMENINENINESEVEN| CH1 2AN	| 457300052		|

@RegressionSingle
Scenario Outline: Welsh 1st Party Deferral - bank holiday

	Given I am on the welsh version of "Public" "ithc"

	Given a bureau owned pool is created with jurors
		| court | juror_number  | pool_number	| att_date_weeks_in_future	| owner |
		| 457   | <juror_number>| <pool_number>	| 5			            	| 400	|

	And juror "<juror_number>" has "LAST_NAME" as "<last_name>" new schema
	And juror "<juror_number>" has "POSTCODE" as "<postcode>" new schema

	And I do not see any links on the page that open to a new page without an alt text
	And I set the radio button to "n ymateb dros fy hun"
	And I press the "Parhau" button
	Then I see "Eich manylion rheithiwr" on the page
	And I do not see any links on the page that open to a new page without an alt text
	
	When I set "Rhif rheithiwr" to "<juror_number>"
	When I set "Cyfenw" to "<last_name>"
	When I set "Cod post Rheithiwr" to "<postcode>"
	And I press the "Parhau" button
	Then I see "A yw'r enw sydd gennym ar eich cyfer chi yn gywir?" on the page
	
	#Juror's details
	And I set the radio button to "Ydy"
	When I press the "Parhau" button
	Then I see "Eich cyfeiriad chi yw hwn?" on the page
	And I do not see any links on the page that open to a new page without an alt text
	
	#Juror's address
	And I set the radio button to "Ie"
	When I press the "Parhau" button
	Then I see "Beth yw eich rhif ffôn?" on the page
	And I do not see any links on the page that open to a new page without an alt text
	
	#Juror's phone
	And I see "Darparwch rif ffôn yn y DU y gallwn ei ddefnyddio i gysylltu â chi rhwng 9am a 5pm, dydd Llun i ddydd Gwener." on the page
	When I set "Prif rif ffôn" to "02078211818"
	And I press the "Parhau" button
	Then I see "Beth yw eich cyfeiriad e-bost?" on the page
	And I do not see any links on the page that open to a new page without an alt text
	
	#Juror's email
	When I see "Pam fod arnom angen eich cyfeiriad e-bost?" on the page
	And I set "Nodwch eich cyfeiriad e-bost" to "<email>"
	And I set "Nodwch eich cyfeiriad e-bost eto" to "<email>"
	And I press the "Parhau" button
	Then I see "Beth yw eich dyddiad geni?" on the page
	And I do not see any links on the page that open to a new page without an alt text
	
	#DoB and JDB-3409
	And I see "Cymorth gyda'ch dyddiad geni" on the page
	When I set "Diwrnod" to "27"
	And I set "Mis" to "04"
	And I set "Blwyddyn" to "1978"
	And I press the "Parhau" button
	Then I see "Cadarnhau a ydych yn gymwys i wasanaethu ar reithgor" on the page
	And I do not see any links on the page that open to a new page without an alt text
	
	#Do you qualify for jury service?
	When I press the "Parhau" button
	
	#Residency
	Then I see "Ers i chi droi'n 13 oed, a yw eich prif gyfeiriad wedi bod yn y DU, Ynysoedd y Sianel neu Ynys Manaw am unrhyw gyfnod o 5 mlynedd o leiaf?" on the page
	And I do not see any links on the page that open to a new page without an alt text
	And I set the radio button to "Do"
	And I press the "Parhau" button
	And I do not see any links on the page that open to a new page without an alt text

	#CJS
	Then I see "A ydych chi wedi gweithio yn y system cyfiawnder troseddol yn y 5 mlynedd diwethaf?" on the page
	And I do not see any links on the page that open to a new page without an alt text
	And I set the radio button to "Nac ydw"
	And I press the "Parhau" button
	And I do not see any links on the page that open to a new page without an alt text
	
	#Bail
	And I set the radio button to "Nac ydw"
	And I press the "Parhau" button
	And I do not see any links on the page that open to a new page without an alt text

	#Criminal convictions
	And I set the radio button to "Naddo"
	And I press the "Parhau" button
	And I do not see any links on the page that open to a new page without an alt text
	
	#Mental health sectioned
	And I set the radio button to "Na"
	And I press the "Parhau" button
	And I do not see any links on the page that open to a new page without an alt text
	
	#Mental health capacity
	And I set the radio button to "Na"
	And I press the "Parhau" button
	And I do not see any links on the page that open to a new page without an alt text

	#Can you attend
	And I see "Gwiriwch eich dyddiad dechrau" on the page
	And I see "Rydych wedi cael gwŷs i ddechrau gwasanaeth rheithgor ar" on the page
	And I see "Ydych chi'n gallu dechrau gwasanaeth rheithgor ar y dyddiad hwn?" on the page
	And I see "Ydw, rydw i'n gallu dechrau ar" on the page
	And I see "Nac ydw, hoffwn newid y dyddiad" on the page
	And I see "Nac ydw, ni allaf wasanaethu ar reithgor a hoffwn gael fy esgusodi" on the page
	
	And I click on the "A fydd angen i mi wasanaethu'n hirach na phythefnos?" link
	And I see "Dim ond pythefnos y mae angen i'r rhan fwyaf o bobl wasanaethu ar reithgor." on the page
	And I see "Efallai y bydd y llys yn gofyn i chi wasanaethu am fwy o amser pan fyddwch yn cyrraedd y llys." on the page
	And I see "Os nad ydych yn gallu gwasanaethu am fwy na phythefnos, gallwch drafod hyn gyda rheolwr y rheithgor yn y llys." on the page
	
	And I click on the "Beth os oes problem yn nes at yr amser ac nid wyf yn gallu gwasanaethu?" link
	Then I see "Rhaid i chi gysylltu â ni bryd hynny i roi gwybod i ni." on the page
	
	And I press the "Parhau" button
	And I see "Dewiswch os ydych yn gallu dechrau eich gwasanaeth rheithgor ar y dyddiad hwn ai peidio" on the page
	
	When I set the radio button to "Nac ydw, hoffwn newid y dyddiad"
	And I press the "Parhau" button
	And I do not see any links on the page that open to a new page without an alt text
	
	#JDB-3448 and JDB-3503
	And I see "steps/confirm-date/deferral-reason" in the URL
	Then I see "Dywedwch wrthym pam fod angen dyddiad arall arnoch i wneud eich gwasanaeth rheithgor" on the page
	And I see "Mae'n rhaid i chi gael rheswm da dros newid dyddiad, er enghraifft:" on the page
	And I see "gwyliau wedi'i drefnu" on the page
	And I see "llawdriniaeth" on the page
	And I see "arholiad" on the page
	And I see "nid yw eich cyflogwr yn fodlon rhoi amser i ffwrdd o'r gwaith i chi" on the page
	And I see "Dim ond unwaith y gallwch newid y dyddiad." on the page
	And I do not see any links on the page that open to a new page without an alt text
	
	#Deferral Reason
	And I press the "Parhau" button
	And I see "Nodwch y rheswm dros fod angen dyddiad arall ar gyfer eich gwasanaeth rheithgor" on the page
	
	When I set text area with "id" of "deferralReason" to "Large amount of text here Large amount of text here Large amount of text here Large amount of text here Large amount of text here Large amount of text here Large amount of text here Large amount of text here Large amount of text here Large amount of text here Large amount of text here Large amount of text here Large amount of text here Large amount of text here Large amount of text here Large amount of text here Large amount of text here Large amount of text here Large amount of text here Large amount of text here Large amount of text here Large amount of text here Large amount of text here Large amount of text here Large amount of text here Large amount of text here Large amount of text here Large amount of text here Large amount of text here Large amount of text here Large amount of text here Large amount of text here Large amount of text here Large amount of text here Large amount of text here Large amount of text here Large amount of text here Large amount of text here Large amount of text here "
	And I see "Mae gennych 14 nod yn ormod" on the page
	
	And I press the "Parhau" button
	And I see "Os gwelwch yn dda, sicrhewch fod hyd y rheswm yn llai na 1000 o nodau" on the page
	
	When I set text area with "id" of "deferralReason" to "askForAnotherDateReasonWhy"
	And I press the "Parhau" button
	And I do not see any links on the page that open to a new page without an alt text

	And I see "steps/confirm-date/deferral-dates" in the URL
	Then I see "Dewiswch 3 dydd Llun pan allwch ddechrau gwasanaeth rheithgor" on the page
	And I see "Rhaid i'r rhain fod rhwng" on the page
	And I see "Rhaid i chi fod ar gael i wasanaethu am o leiaf pythefnos" on the page
	And I see "Dewis cyntaf" on the page
	And I see "Ail ddewis" on the page
	And I see "Trydydd dewis" on the page
	
	#help text
	And I click on the "A fydd angen i mi wasanaethu'n hirach na phythefnos?" link
	And I see "Dim ond pythefnos y mae angen i'r rhan fwyaf o bobl wasanaethu ar reithgor." on the page
	And I see "Efallai y bydd y llys yn gofyn i chi wasanaethu am fwy o amser pan fyddwch yn cyrraedd y llys." on the page
	And I see "Os nad ydych yn gallu gwasanaethu am fwy na phythefnos, gallwch drafod hyn gyda rheolwr y rheithgor yn y llys." on the page
	Then I click on the "Beth os oes problem yn nes at yr amser ac nid wyf yn gallu gwasanaethu?" link
	Then I see "Rhaid i chi gysylltu â ni bryd hynny i roi gwybod i ni." on the page
	And I do not see any links on the page that open to a new page without an alt text

	Then I create a bank holiday "8" Mondays in the future for court/bureau "400" new schema

	When I set the "First" single date field to a Monday "6" weeks in the future
	When I set the "Second" single date field to a Monday "7" weeks in the future
	When I set the "Third" single date field to a Monday "8" weeks in the future

	And I press the "Parhau" button
	
	And on the page I see
	|text|
	|Gwiriwch eich dyddiadau|
	|Dyddiadau y gallwch ddechrau gwasanaeth rheithgor|
	|Nid oes angen i chi ddweud wrthym yr holl ddyddiadau eraill rydych ar gael.|
	|Byddwn yn dewis un o'r 3 dyddiad sydd orau gennych.|
	|Os na allwn ddefnyddio un o'r dyddiadau hyn am unrhyw reswm, byddwn yn cysylltu â chi.|
	|Ydych chi am fwrw ymlaen â'r dyddiadau hyn?|
	
	Then I set the radio button to "Ydw"
	And I press the "Parhau" button
		
	#Bank holiday
	And on the page I see
	|text|
	|Mae o leiaf un dydd Llun a ddewiswyd gennych yn ŵyl banc|
	|Rydych chi wedi dewis o leiaf un dydd Llun sy'n ŵyl banc yn y DU.|
	|Os byddwn yn dewis hwn fel eich dyddiad dechrau, bydd eich gwasanaeth rheithgor yn dechrau ar y dydd Mawrth canlynol ar y cynharaf|
	|Byddwn yn anfon cadarnhad atoch o'ch dyddiad dechrau maes o law.|
	
	And I press the "Parhau" button
	
	#Special Requirements
	And I set the radio button to "Nac oes"
	When I press the "Parhau" button
	And I do not see any links on the page that open to a new page without an alt text
	
	#Check your answers page
	Then I see "Gwiriwch eich ymatebion nawr" on the page
	And I see text "askForAnotherDateReasonWhy" in the same row as "Eglurwch pam eich bod angen newid dyddiad eich gwasanaeth rheithgor"
	And I do not see any links on the page that open to a new page without an alt text
	
	Then I check the "Mae'r wybodaeth a roddais uchod yn wir hyd eithaf fy ngwybodaeth." checkbox
	When I press the "Cyflwyno" button
	And I do not see any links on the page that open to a new page without an alt text
	
	Then I see "Rydych wedi cwblhau'r broses ymateb" on the page
	Then I see "<juror_number>" on the page
	And I do not see any links on the page that open to a new page without an alt text
	
	#JDB-3071
	And I see "Byddwn yn ysgrifennu atoch yn y 7 diwrnod nesaf i roi gwybod ichi os gallwch newid dyddiad eich gwasanaeth rheithgor." on the page
	And I see "Yna, o leiaf bythefnos cyn i'ch gwasanaeth rheithgor ddechrau, byddwn yn anfon y canlynol atoch:" on the page
	And I do not see any links on the page that open to a new page without an alt text

	And I delete bank holiday new schema

Examples:
	| juror_number	| last_name	| postcode	| email 		| pool_number 	|
	| 045700053		| LNAME4823	| SW1H 9AJ	| a@eeee.com	| 457300053		|
