Feature: Regression Welsh_1st_RA

@RegressionWelsh @JDB-3608 
Scenario Outline: Welsh_1st_RA

	Given I am on the welsh version of "Public" "juror-test02"
	Given the juror numbers have not been processed
		| part_no 	| pool_no 	| owner |
		| <part_no> |<pool_no>	| 400 	|
		
	And juror "<juror_number>" has "LAST_NAME" as "<last_name>" new schema


	And juror "<juror_number>" has "ADDRESS_LINE_4" as "LONDON"
	And juror "<juror_number>" has "POSTCODE" as "<postcode>" new schema
	
	Then I see "A ydych yn ymateb dros eich hun neu ar ran rhywun arall?" on the page
	And I set the radio button to "n ymateb dros fy hun"
	And I press the "Parhau" button
	
	Then I see "Eich manylion rheithiwr" on the page
	
	When I set "Rhif rheithiwr – 9 digid" to "<juror_number>"
	When I set "Cyfenw'r Rheithiwr" to "<last_name>"
	When I set "Cod post Rheithiwr" to "<postcode>"
	And I press the "Parhau" button
	
	#name
	
	Then I see "A yw'r enw sydd gennym ar eich cyfer chi yn gywir?" on the page
	And I set the radio button to "Ydy"
	And I press the "Parhau" button
	
	#address
	
	Then I see "Eich cyfeiriad chi yw hwn?" on the page
	And I set the radio button to "Ie"
	And I press the "Parhau" button
	
	#phone
	
	Then I see "Beth yw eich rhif ffôn?" on the page
	When I set "Prif rif ffôn" to "02078211818"
	And I press the "Parhau" button
	
	#email
	
	Then I see "Beth yw eich cyfeiriad e-bost?" on the page
	When I set "Nodwch eich cyfeiriad e-bost" to "<email>"
	When I set "Nodwch eich cyfeiriad e-bost eto" to "<email>"
	And I press the "Parhau" button
	
	#dob
	
	Then I see "Beth yw eich dyddiad geni?" on the page
	When I set "Diwrnod" to "27"
	And I set "Mis" to "04"
	And I set "Blwyddyn" to "1981"
	And I press the "Parhau" button
	
	#eligibility
	
	Then I see "Cadarnhau a ydych yn gymwys i wasanaethu ar reithgor" on the page
	And I press the "Parhau" button
	
	#residency
	
	Then I see "Ers i chi droi'n 13 oed, a yw eich prif gyfeiriad wedi bod yn y DU, Ynysoedd y Sianel neu Ynys Manaw am unrhyw gyfnod o 5 mlynedd o leiaf?" on the page
	When I set the radio button to "Do"
	And I press the "Parhau" button
	
	#CJS
	
	Then I see "A ydych chi wedi gweithio yn y system cyfiawnder troseddol yn y 5 mlynedd diwethaf?" on the page
	When I set the radio button to "Nac ydw"
	And I press the "Parhau" button
	
	#bail
	
	Then I see "Ydych chi ar fechnïaeth ar hyn o bryd am gyflawni trosedd?" on the page
	When I set the radio button to "Nac ydw"
	And I press the "Parhau" button
	
	#crim offence
	
	Then I see "Ydych chi wedi'ch cael yn euog o drosedd?" on the page
	When I set the radio button to "Naddo"
	And I press the "Parhau" button
	
	#MHQ1
	
	Then I see "Ydych chi'n cael eich cadw, yn cael eich gwarchod neu eich trin o dan y Ddeddf Galluedd Meddyliol?" on the page
	When I set the radio button to "Na"
	And I press the "Parhau" button
	
	#MHQ2
	
	Then I see "A benderfynwyd nad oes gennych y gallu meddyliol?" on the page
	When I set the radio button to "Na"
	And I press the "Parhau" button
	
	#Confirm Date
	
	Then I see "Gwiriwch eich dyddiad dechrau" on the page
	When I set the radio button to "Ydw, rydw i'n gallu dechrau"
	And I press the "Parhau" button
	
	#Support in Court
	#3608
	
	Then I see "A fyddech chi angen cymorth pan fyddwch yn y llys?" on the page
	When I set the radio button to "Oes"
	And I press the "Parhau" button
	Then I see "Dewiswch os oes gennych symudedd cyfyngedig, nam ar y clyw, clefyd siwgr, nam difrifol ar eich golwg neu anabledd neu nam o fath arall" on the page
	When I check the "Symudedd cyfyngedig" checkbox
	And I press the "Parhau" button
	Then I see "Gwiriwch eich ymatebion nawr" on the page
	
	#Check Answers
	
	Then I check the "Mae'r wybodaeth a roddais uchod yn wir hyd eithaf fy ngwybodaeth" checkbox
	When I press the "Cyflwyno" button

	#Confirmation
	
	Then I see "Rydych wedi cwblhau'r broses ymateb" on the page
	
Examples:
	|part_no		|pool_no	|last_name			|postcode	|email | 
	|641500159		|415170402	|LNAMEONEFIVENINE	|CH1 2AN	|e@eeee.com|