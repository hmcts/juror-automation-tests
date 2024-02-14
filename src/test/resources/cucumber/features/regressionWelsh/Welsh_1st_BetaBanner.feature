Feature: Welsh_1st_BetaBanner

# Beta banner removed 27-07-20

@RegressionWelsh @JDB-3522 @JDB-4570 
Scenario Outline: Welsh 1st Party Beta Banner Check
	Given I am on the welsh version of "Public" "bau-test"
	Given the juror numbers have not been processed
		| part_no 	| pool_no 	| owner |
		| <part_no> |<pool_no>	| 400 	|
		
	And "<part_no>" has "LNAME" as "<last_name>" 
	And "<part_no>" has "RET_DATE" as "5 mondays time"
	And "<part_no>" has "NEXT_DATE" as "5 mondays time"
	And "<part_no>" has "ZIP" as "<postcode>"

	Then I see "A ydych yn ymateb dros eich hun neu ar ran rhywun arall?" on the page
	
	And I set the radio button to "n ymateb dros fy hun"
	And I do not see "Gwasanaeth newydd yw hwn – bydd eich adborth yn ein helpu i’w wella" on the page
	And I press the "Parhau" button
	Then I see "Eich manylion rheithiwr" on the page
	And I see "Gallwch ddod o hyd i'ch rhif rheithiwr ar eich llythyr gwŷs rheithgor." on the page
	
	#Login
	
	When I do not see "Gwasanaeth newydd yw hwn – bydd eich adborth yn ein helpu i’w wella" on the page
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
	And I do not see "Gwasanaeth newydd yw hwn – bydd eich adborth yn ein helpu i’w wella" on the page
	And I click on the "Beth sy'n digwydd os rwyf wedi newid fy enw?" link
	
	And I see "Os yw eich enw chi wedi newid, byddwn yn cysylltu â chi i wirio hynny. Efallai y byddwn yn gofyn am dystysgrif briodas, tystysgrif partneriaeth sifil neu weithred newid enw." on the page
	And I press the "Parhau" button
	
	Then on the page I see
		| text	|
		| Eich Manylion |
		| Eich cyfeiriad chi yw hwn? |
		
	And I do not see "Gwasanaeth newydd yw hwn – bydd eich adborth yn ein helpu i’w wella" on the page
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
	And I do not see "Gwasanaeth newydd yw hwn – bydd eich adborth yn ein helpu i’w wella" on the page
	And I press the "Parhau" button

	Then on the page I see
		| text|
		| Eich Manylion |
		| Beth yw eich cyfeiriad e-bost? |
		| Pam fod arnom angen eich cyfeiriad e-bost? |
	
	When I set "Nodwch eich cyfeiriad e-bost" to "email@outlook.com"
	And I set "Nodwch eich cyfeiriad e-bost eto" to "email@outlook.com"
	And I do not see "Gwasanaeth newydd yw hwn – bydd eich adborth yn ein helpu i’w wella" on the page
	And I press the "Parhau" button

	Then on the page I see
		| text	|
		| Eich Manylion	|
		| Beth yw eich dyddiad geni? |
		| Cymorth gyda'ch dyddiad geni |
	
	When I set "Diwrnod" to "27"
	And I set "Mis" to "04"
	And I set "Blwyddyn" to "1978"
	And I do not see "Gwasanaeth newydd yw hwn – bydd eich adborth yn ein helpu i’w wella" on the page
	And I press the "Parhau" button
	
	#Qualify for jury service
	
	Then I see "Cadarnhau a ydych yn gymwys i wasanaethu ar reithgor" on the page
	
	And I do not see "Gwasanaeth newydd yw hwn – bydd eich adborth yn ein helpu i’w wella" on the page
	
	When I press the "Parhau" button
	
	#Residency
	
	Then I see "Ers i chi droi'n 13 oed, a yw eich prif gyfeiriad wedi bod yn y DU, Ynysoedd y Sianel neu Ynys Manaw am unrhyw gyfnod o 5 mlynedd o leiaf?" on the page
	When I see "Cymhwysedd" on the page
	And I do not see "Gwasanaeth newydd yw hwn – bydd eich adborth yn ein helpu i’w wella" on the page
	And I set the radio button to "Naddo"
	And I set the radio button to "Do"
	And I press the "Parhau" button
	
	#CJS
	
	Then I see "A ydych chi wedi gweithio yn y system cyfiawnder troseddol yn y 5 mlynedd diwethaf?" on the page
	When I do not see "Gwasanaeth newydd yw hwn – bydd eich adborth yn ein helpu i’w wella" on the page
	And I set the radio button to "Nac ydw"
	And I press the "Parhau" button
	
	#Bail
	
	Then I see "Ydych chi ar fechnïaeth ar hyn o bryd am gyflawni trosedd?" on the page
	When I see "Cymhwysedd" on the page
	And I do not see "Gwasanaeth newydd yw hwn – bydd eich adborth yn ein helpu i’w wella" on the page
	And I set the radio button to "Nac ydw"
	And I press the "Parhau" button
	
	#Convictions
	
	Then I see "Ydych chi wedi'ch cael yn euog o drosedd?" on the page
	When I see "Cymhwysedd" on the page
	And I see "Dim ond os cawsoch ddedfryd o garchar, gorchymyn cymunedol neu ddedfryd o garchar ohiriedig y mae hyn yn berthnasol." on the page
	When I set the radio button to "Naddo"
	And I press the "Parhau" button
	
	#Mental Health Sectioned
	
	Then I see "Ydych chi'n cael eich cadw, yn cael eich gwarchod neu eich trin o dan y Ddeddf Galluedd Meddyliol?" on the page
	When I see "Cymhwysedd" on the page
	And I do not see "Gwasanaeth newydd yw hwn – bydd eich adborth yn ein helpu i’w wella" on the page
	And I set the radio button to "Na"
	And I press the "Parhau" button
	
	#Mental Health Capacity
	
	Then I see "A benderfynwyd nad oes gennych y gallu meddyliol?" on the page
	When I see "Cymhwysedd" on the page
	And I do not see "Gwasanaeth newydd yw hwn – bydd eich adborth yn ein helpu i’w wella" on the page
	And I set the radio button to "Na"
	And I press the "Parhau" button
	
	#Confirm attendance	

	Then I see "Gwiriwch eich dyddiad dechrau" on the page

	
	And I do not see "Gwasanaeth newydd yw hwn – bydd eich adborth yn ein helpu i’w wella" on the page
	And I set the radio button to "Ydw, rydw i'n gallu dechrau"
	And I press the "Parhau" button
	
	#RA
	
	Then I see "A fyddech chi angen cymorth pan fyddwch yn y llys?" on the page
	When I do not see "Gwasanaeth newydd yw hwn – bydd eich adborth yn ein helpu i’w wella" on the page
	And I set the radio button to "Nac oes"
	And I press the "Parhau" button
	
	#Check Your Answers Now
	
	And I see "Gwiriwch eich ymatebion nawr" on the page
	When I do not see "Gwasanaeth newydd yw hwn – bydd eich adborth yn ein helpu i’w wella" on the page
	When I click on the "Newid" link in the same row as "Cadarnhewch ddyddiad eich gwasanaeth rheithgor"
	Then I see "Gwiriwch eich dyddiad dechrau" on the page
	
	#Confirm Date of Jury Service
	
	When I set the radio button to "Nac ydw, hoffwn newid y dyddiad"
	And I press the "Parhau" button
	Then I see "Dywedwch wrthym pam fod angen dyddiad arall arnoch i wneud eich gwasanaeth rheithgor" on the page
	
	#Deferral Reason
	
	When I do not see "Gwasanaeth newydd yw hwn – bydd eich adborth yn ein helpu i’w wella" on the page
	And I set text area with "id" of "deferralReason" to "Defer me please"
	And I press the "Parhau" button
	Then I see "Dewiswch 3 dydd Llun pan allwch ddechrau gwasanaeth rheithgor" on the page
	
	#Deferral Dates
	
	When I do not see "Gwasanaeth newydd yw hwn – bydd eich adborth yn ein helpu i’w wella" on the page
	When I set the "First" single date field to a Monday "6" weeks in the future
	When I set the "Second" single date field to a Monday "7" weeks in the future
	When I set the "Third" single date field to a Monday "8" weeks in the future
	And I press the "Parhau" button
	
	#confirm
	
	And I set the radio button to "Ydw"
	And I press the "Parhau" button
	
	Then I see "Gwiriwch eich ymatebion nawr" on the page
	
	#Check Your Answers Now
	
	When I click on the "Newid" link in the same row as "Cadarnhewch ddyddiad eich gwasanaeth rheithgor"
	Then I see "Gwiriwch eich dyddiad dechrau" on the page
	
	#Confirm Date of Jury Service
	
	When I set the radio button to "Nac ydw, ni allaf wasanaethu ar reithgor a hoffwn gael fy esgusodi"
	And I press the "Parhau" button
	Then I see "Pam fod angen ichi gael eich esgusodi rhag gwasanaethu ar reithgor?" on the page
	
	#Excusal Reason
	
	When I do not see "Gwasanaeth newydd yw hwn – bydd eich adborth yn ein helpu i’w wella" on the page
	And I set text area with "id" of "excusalReason" to "Excuse me please"
	And I press the "Parhau" button
	Then I see "Gwiriwch eich ymatebion nawr" on the page
	
	#Check Your Answers Now
	
	When I check the "Mae'r wybodaeth a roddais uchod yn wir hyd eithaf fy ngwybodaeth." checkbox
	And I press the "Cyflwyno" button
	Then I see "Rydym wedi anfon neges e-bost atoch i gadarnhau eich bod wedi ymateb i’ch gwŷs rheithgor." on the page
	And I do not see "Gwasanaeth newydd yw hwn – bydd eich adborth yn ein helpu i’w wella" on the page
	
Examples:
	|part_no		|last_name	|postcode	|email 		| pool_no	|
	|641500830		|DOE		|SW1H 9AJ	|b@eeee.com	| 415170401	|