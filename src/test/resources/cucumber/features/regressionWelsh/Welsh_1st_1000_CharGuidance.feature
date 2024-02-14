Feature: Welsh_1st_1000_CharGuidance

@RegressionWelsh  @JDB-3618 @JDB-3620 @JDB-3621 @JDB-3622 @JDB-3623 @JDB-3624 @JDB-3625 @JDB-3626 @JDB-3627 @JDB-3628 @JDB-3653 
Scenario Outline: Welsh 1st Party - Character count warning should be on all applicable pages
	Given I am on the welsh version of "Public" "bau-test"
	Given the juror numbers have not been processed
		| part_no 	| pool_no 	| owner |
		| <part_no> |<pool_no>	| 400 	|
		
	And "<part_no>" has "LNAME" as "<last_name>" 
	And "<part_no>" has "RET_DATE" as "5 mondays time"
	And "<part_no>" has "NEXT_DATE" as "5 mondays time"
	And "<part_no>" has "ZIP" as "<postcode>"

	And I set the radio button to "n ymateb dros fy hun"
	And I press the "Parhau" button
	Then I see "Eich manylion rheithiwr" on the page
	And I see "Gallwch ddod o hyd i'ch rhif rheithiwr ar eich llythyr gwŷs rheithgor." on the page
	
	When I set "Rhif rheithiwr" to "<part_no>"
	When I set "Cyfenw" to "<last_name>"
	When I set "Cod post Rheithiwr" to "<postcode>"
	And I press the "Parhau" button
	
	Then on the page I see
		| text	|
		| Eich Manylion |
		| A yw'r enw sydd gennym ar eich cyfer chi yn gywir? |
		
	And I set the radio button to "Nac ydy"
	And I press the "Parhau" button
	And I set "Enw cyntaf" to "FirstNameA"
	And I set "Cyfenw" to "LastNameB"
	And I click on the "Beth sy'n digwydd os rwyf wedi newid fy enw?" link
	And I see "Os yw eich enw chi wedi newid, byddwn yn cysylltu â chi i wirio hynny. Efallai y byddwn yn gofyn am dystysgrif briodas, tystysgrif partneriaeth sifil neu weithred newid enw." on the page
	And I press the "Parhau" button
	
	Then on the page I see
		| text	|
		| Eich Manylion |
		| Eich cyfeiriad chi yw hwn? |
		
	And I set the radio button to "Ie"
	When I press the "Parhau" button
	
	Then on the page I see
		| text	|
		| Eich Manylion |
		| Beth yw eich rhif ffôn? |
		| Darparwch rif ffôn yn y DU y gallwn ei ddefnyddio i gysylltu â chi rhwng 9am a 5pm, dydd Llun i ddydd Gwener. |
		| Prif rif ffôn |
		| Rhif ffôn arall (dewisol) |
	
	When I set "Prif rif ffôn" to "0207 821 1818"
	And I press the "Parhau" button

	Then on the page I see
		| text|
		| Eich Manylion |
		| Beth yw eich cyfeiriad e-bost? |
		| Pam fod arnom angen eich cyfeiriad e-bost? |
	
	When I set "Nodwch eich cyfeiriad e-bost" to "email@outlook.com"
	And I set "Nodwch eich cyfeiriad e-bost eto" to "email@outlook.com"
	And I press the "Parhau" button

	Then on the page I see
		| text	|
		| Eich Manylion	|
		| Beth yw eich dyddiad geni? |
		| Cymorth gyda'ch dyddiad geni |
	
	When I set "Diwrnod" to "27"
	And I set "Mis" to "04"
	And I set "Blwyddyn" to "1978"
	And I press the "Parhau" button
	
	#Qualify for jury service
	
	Then I see "Cadarnhau a ydych yn gymwys i wasanaethu ar reithgor" on the page
	When I press the "Parhau" button
	
	#Residency JDB-3620
	
	Then I see "Ers i chi droi'n 13 oed, a yw eich prif gyfeiriad wedi bod yn y DU, Ynysoedd y Sianel neu Ynys Manaw am unrhyw gyfnod o 5 mlynedd o leiaf?" on the page
	When I set the radio button to "Naddo"
	
	And I see "You have 1000 characters remaining" on the page
	And I set "Rhowch fanylion" to "Not a resident"
	And I press the "Parhau" button
	
	#CJS no JDB-3625
	
	Then I see "A ydych chi wedi gweithio yn y system cyfiawnder troseddol yn y 5 mlynedd diwethaf?" on the page
	When I set the radio button to "Ydw"
	And I check the "Arall" checkbox

	And I see "You have 1000 characters remaining" on the page
	And I set "Pa ran arall o’r System Cyfiawnder Troseddol?" to "Other CJS part"
	And I press the "Parhau" button
	
	#Bail JDB-3623
	
	Then I see "Ydych chi ar fechnïaeth ar hyn o bryd am gyflawni trosedd?" on the page

	When I set the radio button to "Ydw"
	
	And I see "You have 1000 characters remaining" on the page
	And I set "Rhowch fanylion" to "I am bailed"
	And I press the "Parhau" button
	
	#Convictions JDB-3624
	
	Then I see "Ydych chi wedi'ch cael yn euog o drosedd?" on the page
	When I set the radio button to "Do"
	
	And I see "You have 1000 characters remaining" on the page
	And I set text area with "id" of "convictedDetails" to "I am convicted"
	And I press the "Parhau" button
	
	#Mental health part 1 JDB-3621
	
	Then I see "Ydych chi'n cael eich cadw, yn cael eich gwarchod neu eich trin o dan y Ddeddf Galluedd Meddyliol?" on the page
	When I set the radio button to "Ie"
	
	And I see "You have 1000 characters remaining" on the page
	And I set "Eglurwch sut yr ydych yn cael eich cadw dan glo, sut ofal ydych yn ei gael neu sut yr ydych yn cael eich trin o dan y Ddeddf Iechyd Meddwl" to "I am sectioned"
	And I press the "Parhau" button
	
	#Mental health part 2 JDB-3622
	
	Then I see "A benderfynwyd nad oes gennych y gallu meddyliol?" on the page
	When I set the radio button to "Ie"
	
	And I see "You have 1000 characters remaining" on the page
	And I set "Eglurwch yn gryno pam y penderfynwyd nad oes gennych alluedd meddyliol" to "I lack capacity"
	And I press the "Parhau" button
	
	#I can attend
	
	Then I see "Gwiriwch eich dyddiad dechrau" on the page
	When I set the radio button to "Ydw, rydw i'n gallu dechrau"
	And  I press the "Parhau" button
	
	#RA no JDB-3627 and JDB-3628
	
	Then I see "A fyddech chi angen cymorth pan fyddwch yn y llys?" on the page
	When I set the radio button to "Oes"
	
	And I see "You have 1000 characters remaining" on the page
	And I set "Rhowch wybod inni am unrhyw drefniadau arbennig bydd arnoch angen wrth ichi wasanaethu ar reithgor." to "Wheelchair user"
	When I check the "Arall" checkbox
	And I set "Rhowch fanylion os gwelwch yn dda" to "Other RA stuff"
	And I press the "Parhau" button
	
	#Check Your Answers
	
	Then I see "Gwiriwch eich ymatebion nawr" on the page
	When I click on the "Newid" link in the same row as "Cadarnhewch ddyddiad eich gwasanaeth rheithgor"
	Then I see "Gwiriwch eich dyddiad dechrau" on the page
	
	When I set the radio button to "Nac ydw, hoffwn newid y dyddiad"
	And I press the "Parhau" button
	Then I see "Dywedwch wrthym pam fod angen dyddiad arall arnoch i wneud eich gwasanaeth rheithgor" on the page
	
	#Deferral Reason JDB-3626
	
	When I see "You have 1000 characters remaining" on the page
	And I set text area with "id" of "deferralReason" to "Defer me please"
	And I press the "Parhau" button
	Then I see "Dewiswch 3 dydd Llun pan allwch ddechrau gwasanaeth rheithgor" on the page
	
	#Deferral Dates
	
	When I set the "First" single date field to a Monday "6" weeks in the future
	When I set the "Second" single date field to a Monday "7" weeks in the future
	When I set the "Third" single date field to a Monday "8" weeks in the future
	
	And I press the "Parhau" button
	
	#confirm
	
	And I set the radio button to "Ydw"
	And I press the "Parhau" button
	
	Then I see "Gwiriwch eich ymatebion nawr" on the page
	
	#Check Your Answers
	
	When I click on the "Newid" link in the same row as "Cadarnhewch ddyddiad eich gwasanaeth rheithgor"
	Then I see "Gwiriwch eich dyddiad dechrau" on the page
	
	When I set the radio button to "Nac ydw, ni allaf wasanaethu ar reithgor a hoffwn gael fy esgusodi"
	And I press the "Parhau" button
	Then I see "Pam fod angen ichi gael eich esgusodi rhag gwasanaethu ar reithgor?" on the page
	
	#Excusal Reason JDB-3618

	When I see "You have 1000 characters remaining" on the page
	And I set text area with "id" of "excusalReason" to "Excuse me please"
	And I press the "Parhau" button
	Then I see "Gwiriwch eich ymatebion nawr" on the page
	
	#When I press the "Submit" button
	
	When I check the "Mae'r wybodaeth a roddais uchod yn wir hyd eithaf fy ngwybodaeth." checkbox
	And I press the "Cyflwyno" button
	Then I see "Rydym wedi anfon neges e-bost atoch i gadarnhau eich bod wedi ymateb i’ch gwŷs rheithgor." on the page
	
	Examples:
	|part_no	|last_name	|postcode	|email           	|pool_no	|
	|641500030	|DOE		|SW1H 9AJ	|email@outlook.com	|415170401	|