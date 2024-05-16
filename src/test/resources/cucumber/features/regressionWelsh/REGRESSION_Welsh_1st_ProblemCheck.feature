Feature: Regression Welsh_1st_ProblemCheck

@RegressionWelsh @NewSchemaConverted
Scenario Outline: Welsh_1st_ProblemCheck
		
	Given I am on the welsh version of "Public" "test"

	Given a bureau owned pool is created with jurors
		| court |juror_number  		| pool_number		| att_date_weeks_in_future	| owner |
		| 457   |<juror_number>		| <pool_number>		| 5				            | 400	|

	And juror "<juror_number>" has "LAST_NAME" as "<last_name>" new schema
	And juror "<juror_number>" has "POSTCODE" as "<postcode>" new schema

	Then I see "A ydych yn ymateb dros eich hun neu ar ran rhywun arall?" on the page
	
	When I press the "Parhau" button
	Then I see "Mae problem" on the page
	When I set the radio button to "n ymateb dros fy hun"
	And I press the "Parhau" button
	
	Then I see "Eich manylion rheithiwr" on the page
	
	When I press the "Parhau" button
	Then I see "Mae problem" on the page
	When I set "Rhif rheithiwr" to "<juror_number>"
	And I set "Cyfenw" to "<last_name>"
	And I set "Cod post Rheithiwr" to "<postcode>"
	And I press the "Parhau" button

	Then I see "A yw'r enw sydd gennym ar eich cyfer chi yn gywir?" on the page
	When I set the radio button to "Nac ydy"
	And I press the "Parhau" button
	
	Then I see "Beth yw eich enw?" on the page
	And I set "Enw cyntaf" to ""
	And I set "Cyfenw" to ""
	And I press the "Parhau" button
	Then I see "Mae problem" on the page
	When I set "Enw cyntaf" to "FirstName"
	And I set "Cyfenw" to "LastName"
	And I press the "Parhau" button
	
	Then I see "Eich cyfeiriad chi yw hwn?" on the page
	Then I see "A fydd eich cyfeiriad chi yn newid yn fuan?" on the page
	And I click on the "A fydd eich cyfeiriad chi yn newid yn fuan?" link
	Then I see "Os bydd eich cyfeiriad yn newid yn fuan, nodwch eich cyfeiriad presennol, er mwyn i ni allu cysylltu â chi." on the page
	Then I see "Ar ôl i chi symud, cysylltwch â'r swyddfa wysio rheithgorau ganolog trwy ffonio 0300 456 1024, a rhoi eich cyfeiriad newydd iddynt." on the page
	Then I see "Os ydych yn symud o'r ardal lle'r ydych yn byw ar hyn o bryd, mae'n bosibl y byddwn yn newid lleoliad eich gwasanaeth rheithgor." on the page
	When I set the radio button to "Na"
	And I press the "Parhau" button

	And I set "Llinell Cyfeiriad 1" to ""
	And I press the "Parhau" button
	Then I see "Mae problem" on the page
	When I set "Llinell Cyfeiriad 1" to "123 ADDRESS LINE ONE"
	And I press the "Parhau" button
	Then I see "Beth yw eich rhif ffôn?" on the page
	
	When I press the "Parhau" button
	Then I see "Mae problem" on the page
	When I set "Prif rif ffôn" to "02078211818"
	And I press the "Parhau" button
	Then I see "Beth yw eich cyfeiriad e-bost?" on the page
	
	When I press the "Parhau" button
	Then I see "Mae problem" on the page
	When I set "Nodwch eich cyfeiriad e-bost" to "email@outlook.com"
	And I set "Nodwch eich cyfeiriad e-bost eto" to "email@outlook.com"
	And I press the "Parhau" button
	Then I see "Beth yw eich dyddiad geni?" on the page
	
	When I press the "Parhau" button
	Then I see "Mae problem" on the page
	When I set "Diwrnod" to "27"
	And I set "Mis" to "04"
	And I set "Blwyddyn" to "1981"
	And I press the "Parhau" button
	Then I see "Cadarnhau a ydych yn gymwys i wasanaethu ar reithgor" on the page
	
	When I press the "Parhau" button
	Then I see "Ers i chi droi'n 13 oed, a yw eich prif gyfeiriad wedi bod yn y DU, Ynysoedd y Sianel neu Ynys Manaw am unrhyw gyfnod o 5 mlynedd o leiaf?" on the page
	
	When I press the "Parhau" button
	Then I see "Mae problem" on the page
	When I set the radio button to "Do"
	And I press the "Parhau" button
	
	Then I see "A ydych chi wedi gweithio yn y system cyfiawnder troseddol yn y 5 mlynedd diwethaf?" on the page
	When I press the "Parhau" button
	Then I see "Mae problem" on the page
	When I set the radio button to "Nac ydw"
	And I press the "Parhau" button
	
	Then I see "Ydych chi ar fechnïaeth ar hyn o bryd am gyflawni trosedd?" on the page
	When I press the "Parhau" button
	Then I see "Mae problem" on the page
	When I set the radio button to "Nac ydw"
	And I press the "Parhau" button
	
	Then I see "Ydych chi wedi'ch cael yn euog o drosedd?" on the page
	When I press the "Parhau" button
	Then I see "Mae problem" on the page
	When I set the radio button to "Naddo"
	And I press the "Parhau" button
	
	Then I see "Ydych chi'n cael eich cadw, yn cael eich gwarchod neu eich trin o dan y Ddeddf Galluedd Meddyliol?" on the page
	When I press the "Parhau" button
	Then I see "Mae problem" on the page
	When I set the radio button to "Na"
	And I press the "Parhau" button
	
	Then I see "A benderfynwyd nad oes gennych y gallu meddyliol?" on the page
	When I press the "Parhau" button
	Then I see "Mae problem" on the page
	When I set the radio button to "Na"
	And I press the "Parhau" button
	
	Then I see "Gwiriwch eich dyddiad dechrau" on the page
	When I press the "Parhau" button
	Then I see "Mae problem" on the page
	When I set the radio button to "Ydw, rydw i'n gallu dechrau"
	And I press the "Parhau" button
	
	Then I see "A fyddech chi angen cymorth pan fyddwch yn y llys?" on the page
	When I press the "Parhau" button
	Then I see "Mae problem" on the page
	When I set the radio button to "Nac oes"
	And I press the "Parhau" button
	Then I see "Gwiriwch eich ymatebion nawr" on the page
	
	When I press the "Cyflwyno" button
	Then I see "Mae problem" on the page
	When I click on the "Newid" link in the same row as "Cadarnhewch ddyddiad eich gwasanaeth rheithgor"
	Then I see "Gwiriwch eich dyddiad dechrau" on the page
	
	When I set the radio button to "Nac ydw, hoffwn newid y dyddiad"
	And I press the "Parhau" button
	Then I see "Dywedwch wrthym pam fod angen dyddiad arall arnoch i wneud eich gwasanaeth rheithgor" on the page
	
	When I press the "Parhau" button
	Then I see "Mae problem" on the page
	When I set text area with "id" of "deferralReason" to "Deferral reason please"
	And I press the "Parhau" button

	When I press the "Parhau" button
	Then I see "Mae problem" on the page
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
	
	When I click on the "Newid" link in the same row as "Cadarnhewch ddyddiad eich gwasanaeth rheithgor"
	Then I see "Gwiriwch eich dyddiad dechrau" on the page
	
	When I set the radio button to "Nac ydw, ni allaf wasanaethu ar reithgor a hoffwn gael fy esgusodi"
	And I press the "Parhau" button
	Then I see "Pam fod angen ichi gael eich esgusodi rhag gwasanaethu ar reithgor?" on the page
	
	When I press the "Parhau" button
	Then I see "Mae problem" on the page
	When I set text area with "id" of "excusalReason" to "Excuse me please"
	And I press the "Parhau" button
	Then I see "Gwiriwch eich ymatebion nawr" on the page
	
	When I check the "Mae'r wybodaeth a roddais uchod yn wir hyd eithaf fy ngwybodaeth." checkbox
	And I press the "Cyflwyno" button
	Then I see "Rydych wedi cwblhau'r broses ymateb" on the page
	And I see "<juror_number>" on the page
	
Examples:
	| juror_number	| last_name				| postcode	| pool_number	|
	| 045700057		| LNAMESEVENNINENINE	| CH1 2AN	| 457300057		|