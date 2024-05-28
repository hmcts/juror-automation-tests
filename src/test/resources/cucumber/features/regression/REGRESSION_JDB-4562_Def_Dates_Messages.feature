Feature: Regression JDB-4562 Defferal Dates Messages

@Regression @NewSchemaConverted
Scenario Outline: English 1st Party Deferral Dates Messages

	Given I am on "Public" "test"

	Given a bureau owned pool is created with jurors
		| court |juror_number  | pool_number	| att_date_weeks_in_future	| owner |
		| 452   |<juror_number>| <pool_number>	| 5				            | 400	|
	
	And juror "<juror_number>" has "LAST_NAME" as "<last_name>" new schema
	And juror "<juror_number>" has "FIRST_NAME" as "<first_name>" new schema
	And juror "<juror_number>" has "ADDRESS_LINE_4" as "LONDON" new schema
	And juror "<juror_number>" has "POSTCODE" as "<postcode>" new schema
	
	And I set the radio button to "I am replying for myself"
	And I press the "Continue" button
	
	When I set "9-digit juror number" to "<juror_number>"
	When I set "Juror last name" to "<last_name>"
	When I set "Juror postcode" to "<postcode>"
	And I press the "Continue" button

	And I choose the "Yes" radio button
	And I press the "Continue" button
	
	And I choose the "Yes" radio button
	And I press the "Continue" button
	
	When I set "Main phone" to "02078211818"
	And I press the "Continue" button

	When I set "Enter your email address" to "<email>"
	When I set "Enter your email address again" to "<email>"
	And I press the "Continue" button
	
	When I set "Day" to "27"
	And I set "Month" to "04"
	And I set "Year" to "1981"
	And I press the "Continue" button
	And I press the "Continue" button
	Then I see "Since you turned 13, has your main address been in the UK, Channel Islands or Isle of Man for any period of at least 5 years?" on the page
	And I choose the "Yes" radio button
	And I press the "Continue" button
	When I choose the "No" radio button
	And I press the "Continue" button
	When I choose the "No" radio button
	And I press the "Continue" button
	When I choose the "No" radio button
	And I press the "Continue" button
	When I choose the "No" radio button
	And I press the "Continue" button
	When I choose the "No" radio button
	And I press the "Continue" button

	And I see "No, I need to change the date" on the page
	And I set the radio button to "No, I need to change the date"
	And I press the "Continue" button
	
	And I see "Tell us why you need another date for your jury service" on the page
	When I set text area with "id" of "deferralReason" to "Deferral Reason"
	And I press the "Continue" button
	
	And I press the "Continue" button
	
	And on the page I see
	|text|
	|Enter the first Monday you'd prefer to start jury service|
	|Enter the second Monday you'd prefer to start jury service|
	|Enter the third Monday you'd prefer to start jury service|
	
	When I set the "First" single date field to a Monday "6" weeks in the future
	When I set the "Second" single date field to a Monday "7" weeks in the future
	When I set the "Third" single date field to a Monday "100" weeks in the future

	And I press the "Continue" button
	
#	JDB-4562
	And I see "Your third choice must be a Monday between" on the page
	
	When I set the "First" single date field to a Monday "13" weeks in the future
	When I set the "Second" single date field to a Monday "14" weeks in the future
	When I set the "Third" single date field to a Monday "15" weeks in the future

	And I press the "Continue" button
	
	#confirm date
	When I choose the "Yes" radio button
	And I press the "Continue" button
	
	#help in court
	When I choose the "No" radio button
	And I press the "Continue" button
	
	When I click on the "Change" link in the same row as "Choose 3 Mondays when you can start jury service"

	When I set the "First" single date field to a Monday "6" weeks in the future
	When I set the "Second" single date field to a Monday "7" weeks in the future
	When I set the "Third" single date field to a Monday "8" weeks in the future

	And I press the "Continue" button

	#confirm dates
	When I choose the "Yes" radio button
	And I press the "Continue" button

	Then I check the "The information I have given is true to the best of my knowledge" checkbox
	
	When I press the "Submit" button
	
	Then I see "You have completed your reply" on the page	
	
Examples:
	| juror_number	| pool_number	| first_name| last_name	| postcode	| email 		|
	| 045200126		| 452300125		| John		| Doe		| SW1H 9AJ	| a@eeee.com	|
	
@RegressionWelsh @NewSchemaConverted
Scenario Outline: Welsh 1st Party Deferral Dates Messaged

	Given I am on the welsh version of "Public" "test"

	Given a bureau owned pool is created with jurors
		| court |juror_number  | pool_number	| att_date_weeks_in_future	| owner |
		| 457   |<juror_number>| <pool_number>	| 5				            | 400	|
	
	And juror "<juror_number>" has "LAST_NAME" as "<last_name>" new schema
	And juror "<juror_number>" has "POSTCODE" as "<postcode>" new schema
	
	And I set the radio button to "n ymateb dros fy hun"
	And I press the "Parhau" button
	Then I see "Eich manylion rheithiwr" on the page
	
	When I set "Rhif rheithiwr" to "<juror_number>"
	When I set "Cyfenw" to "<last_name>"
	When I set "Cod post Rheithiwr" to "<postcode>"
	And I press the "Parhau" button
	
	#Juror's details
	And I set the radio button to "Ydy"
	When I press the "Parhau" button
	
	#Juror's address
	And I set the radio button to "Ie"
	When I press the "Parhau" button
	
	#Juror's phone
	When I set "Prif rif ffôn" to "02078211818"
	And I press the "Parhau" button
	
	#Juror's email
	And I set "Nodwch eich cyfeiriad e-bost" to "<email>"
	And I set "Nodwch eich cyfeiriad e-bost eto" to "<email>"
	And I press the "Parhau" button
	
	#DoB and JDB-3409
	When I set "Diwrnod" to "27"
	And I set "Mis" to "04"
	And I set "Blwyddyn" to "1978"
	And I press the "Parhau" button
	
	#Do you qualify for jury service?
	When I press the "Parhau" button

	#Residency
	And I set the radio button to "Do"
	And I press the "Parhau" button

	#CJS
	And I set the radio button to "Nac ydw"
	And I press the "Parhau" button
	
	#Bail
	And I set the radio button to "Nac ydw"
	And I press the "Parhau" button
	
	#Criminal convictions
	And I set the radio button to "Naddo"
	And I press the "Parhau" button
	
	#Mental health sectioned
	And I set the radio button to "Na"
	And I press the "Parhau" button
	
	#Mental health capacity
	And I set the radio button to "Na"
	And I press the "Parhau" button
	
	#Can you attend
	When I set the radio button to "Nac ydw, hoffwn newid y dyddiad"
	And I press the "Parhau" button
	
	#JDB-3448 and JDB-3503
	Then I see "Dywedwch wrthym pam fod angen dyddiad arall arnoch i wneud eich gwasanaeth rheithgor" on the page
	
	#Deferral Reason
	When I set text area with "id" of "deferralReason" to "askForAnotherDateReasonWhy"
	And I press the "Parhau" button
	
	When I set the "First" single date field to a Monday "6" weeks in the future
	When I set the "Second" single date field to a Monday "7" weeks in the future
	When I set the "Third" single date field to a Monday "100" weeks in the future

	And I press the "Parhau" button
	
	#JDB-4562
	Then I see "Rhaid i'ch trydydd dewis fod yn ddydd Llun rhwng" on the page
	
	When I set the "First" single date field to a Monday "6" weeks in the future
	When I set the "Second" single date field to a Monday "7" weeks in the future
	When I set the "Third" single date field to a Monday "8" weeks in the future
	
	And I press the "Parhau" button
	
	And I set the radio button to "Ydw"
	When I press the "Parhau" button
	
	#Special Requirements
	And I set the radio button to "Nac oes"
	When I press the "Parhau" button
	
	#Check your answers page
	Then I see "Gwiriwch eich ymatebion nawr" on the page
	And I see text "askForAnotherDateReasonWhy" in the same row as "Eglurwch pam eich bod angen newid dyddiad eich gwasanaeth rheithgor"
	
	Then I check the "Mae'r wybodaeth a roddais uchod yn wir hyd eithaf fy ngwybodaeth." checkbox
	When I press the "Cyflwyno" button
	
	Then I see "Rydych wedi cwblhau'r broses ymateb" on the page
	Then I see "Rydych wedi cwblhau'r broses ymateb" on the page
	Then I see "<juror_number>" on the page
	
	#JDB-3071
	And I see "Byddwn yn ysgrifennu atoch yn y 7 diwrnod nesaf i roi gwybod ichi os gallwch newid dyddiad eich gwasanaeth rheithgor." on the page
	And I see "Yna, o leiaf bythefnos cyn i'ch gwasanaeth rheithgor ddechrau, byddwn yn anfon y canlynol atoch:" on the page
	
Examples:
	| juror_number	| last_name			| postcode	| email 	| pool_number	|
	| 045700017		| LNAMENINENINESEVEN| SW1H 9AJ	| a@eeee.com| 457300017		|

@Regression @NewSchemaConverted
Scenario Outline: English 3rd Party Deferral Dates Messages

	Given I am on "Public" "test"

	Given a bureau owned pool is created with jurors
		| court |juror_number  | pool_number	| att_date_weeks_in_future	| owner |
		| 452   |<juror_number>| <pool_number>	| 5				            | 400	|
		
	And juror "<juror_number>" has "LAST_NAME" as "<last_name>" new schema
	And juror "<juror_number>" has "FIRST_NAME" as "<first_name>" new schema
	And juror "<juror_number>" has "POSTCODE" as "<postcode>" new schema
	
	And I set the radio button to "I am replying for someone else"
	And I press the "Continue" button
	
	#Juror Log In
	When I set "9-digit juror number" to "<juror_number>"
	When I set "Juror last name" to "<last_name>"
	When I set "Juror postcode" to "<postcode>"
	And I press the "Continue" button
	
	#3rd Party Name
	When I see "Your Details" on the page
	When I set "First name" to "FirstNameA"
	And I set "Last name" to "LastNameB"
	And I press the "Continue" button
	
	#Relationship to juror
	And I set "How do you know the person you're replying for?" to "Friend"
	And I press the "Continue" button
	
	#3rd Party Contact
	And I check the "By phone (UK Numbers only)" checkbox
	And I set "Main phone" to "0207 821 1818"
	And I check the "By email" checkbox
	And I set "Enter your email address" to "<email>"
	And I set "Enter your email address again" to "<email>"
	And I press the "Continue" button
	
	#Why are you replying title
	When I set the radio button to "The person is not here"
	And I press the "Continue" button
	
	#Check juror name
	And I choose the "Yes" radio button
	And I press the "Continue" button
	
	#Check juror address
	And I choose the "Yes" radio button
	And I press the "Continue" button
	
	#DoB
	And I set "Day" to "01"
	And I set "Month" to "01"
	And I set "Year" to "1988"
	And I press the "Continue" button

	#Contacting the juror
	And I set the radio button to "Use the phone number that you have already given to contact you"
	And I set the radio button to "Use the email address that you have already given to contact you"
	And I press the "Continue" button

	#Qualify for jury service
	And I press the "Continue" button

	#Residency
	And I choose the "Yes" radio button
	And I press the "Continue" button

	#Have you ever worked
	When I choose the "No" radio button
	And I press the "Continue" button
	
	#Bail
	And I choose the "No" radio button
	And I press the "Continue" button
	
	#Convictions
	And I choose the "No" radio button
	And I press the "Continue" button
	
	#Mental Health Sectioned
	And I choose the "No" radio button
	And I press the "Continue" button
	
	#Mental Health Capacity
	And I choose the "No" radio button
	And I press the "Continue" button
	
	#Confirm Date of Jury
	When I set the radio button to "No, we need to change the date" 
	And I press the "Continue" button
	
	#Deferral Reason
	When I set text area with "id" of "deferralReason" to "askForAnotherDateReasonWhy"
	And I press the "Continue" button
	
	#JDB-3445 Deferral Date Screen Layout
	When I set the "First" single date field to a Monday "6" weeks in the future
	When I set the "Second" single date field to a Monday "7" weeks in the future
	When I set the "Third" single date field to a Monday "100" weeks in the future

	And I press the "Continue" button
	
	#JDB-4562
	Then I see "Their third choice must be a Monday between" on the page
	
	When I set the "First" single date field to a Monday "6" weeks in the future
	When I set the "Second" single date field to a Monday "7" weeks in the future
	When I set the "Third" single date field to a Monday "8" weeks in the future

	And I press the "Continue" button

	When I choose the "Yes" radio button
	And I press the "Continue" button
	
	When I choose the "No" radio button
	And I press the "Continue" button
	
	Then I see "Check your answers now" on the page
	
	When I click on the "Change" link in the same row as "Give us 3 dates the person you're replying for could start jury service during the next 12 months"
	And I press the "Continue" button
	
	When I choose the "Yes" radio button
	And I press the "Continue" button
	
	When I check the "The answers I have given for the person I'm replying for are true as far as I know" checkbox
	And I press the "Submit" button
	
	Then I see "You have completed your reply" on the page
	
Examples:
	| juror_number	| pool_number	| first_name| last_name	| postcode	| email 		|
	| 045200128		| 452300127		| John		| Doe		| SW1H 9AJ	| a@eeee.com	|

@RegressionWelsh @NewSchemaConverted
Scenario Outline: Welsh 3rd Party Deferral Dates Messages

	Given I am on the welsh version of "Public" "test"

	Given a bureau owned pool is created with jurors
		| court |juror_number  | pool_number	| att_date_weeks_in_future	| owner |
		| 457   |<juror_number>| <pool_number>	| 5				            | 400	|
	
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
	Then I see "Gwiriwch eich dyddiad dechrau" on the page
	When I set the radio button to "Nac ydi, rhaid newid y dyddiad"
	And I press the "Parhau" button
	
	#JDB-3448 and JDB-3503
	Then I see "Dywedwch wrthym pam fod angen dyddiad arall arnynt ar gyfer y gwasanaeth rheithgor" on the page
	
	#Reasons for Deferral Request
	When I set text area with "id" of "deferralReason" to "Reasons for deferral request"
	And I press the "Parhau" button
	Then I see "Dewiswch 3 dydd Llun pan allant ddechrau gwasanaeth rheithgor" on the page

	When I set the "First" single date field to a Monday "6" weeks in the future
	When I set the "Second" single date field to a Monday "7" weeks in the future
	When I set the "Third" single date field to a Monday "100" weeks in the future

	And I press the "Parhau" button

	Then I see "Rhaid i'w trydydd dewis fod yn ddydd Llun rhwng" on the page
	
	When I set the "First" single date field to a Monday "6" weeks in the future
	When I set the "Second" single date field to a Monday "7" weeks in the future
	When I set the "Third" single date field to a Monday "8" weeks in the future

	And I press the "Parhau" button
	
	When I set the radio button to "Ydw"
	When I press the "Parhau" button
	
	#Special Reqs
	Then I see "A fydd yr unigolyn rydych yn ymateb ar ei ran angen cymorth pan fydd yn y llys?" on the page
	When I set the radio button to "Nac oes"
	When I press the "Parhau" button
	
	#Check your answers page
	Then I see "Gwiriwch eich ymatebion nawr" on the page
	
	Then I check the "wybodaeth rwyf wedi ei rhoi am yr unigolyn rwyf yn ymateb ar ei ran yn gywir." checkbox
	When I press the "Cyflwyno" button
	
	Then I see "Rydych wedi cwblhau'r broses ymateb" on the page
	Then I see "<juror_number>" on the page
	
	#JDB-3071
	And I see "Byddwn yn ysgrifennu at yr unigolyn rydych wedi ymateb ar ei ran yn y 7 diwrnod nesaf i roi gwybod iddynt os gallant newid dyddiad eu gwasanaeth rheithgor." on the page
	And I see "Yna, o leiaf bythefnos cyn i'w gwasanaeth rheithgor ddechrau, byddwn yn anfon y canlynol atynt:" on the page
	
Examples:
	| juror_number	| last_name			| postcode	| email 		| pool_number	|
	| 045700018		| LNAMESIXSIXZERO	| SW1H 9AJ	| a@eeee.com	| 457300018		|