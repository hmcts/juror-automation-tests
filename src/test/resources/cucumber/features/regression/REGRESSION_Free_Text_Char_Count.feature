Feature: Free Text Char Count

@RegressionWelsh @NewSchemaConverted
Scenario Outline: Welsh_3rd_Char_Counts

	Given I am on the welsh version of "Public" "test"

	Given a bureau owned pool is created with jurors
		| court |juror_number  | pool_number	| att_date_weeks_in_future	| owner |
		| 452   |<juror_number>| <pool_number>	| 5				            | 400	|
		
	And juror "<juror_number>" has "LAST_NAME" as "<last_name>" new schema
	And juror "<juror_number>" has "POSTCODE" as "<postcode>" new schema

	And I set the radio button to "Rwy'n ymateb ar ran rhywun arall"
	And I press the "Parhau" button
	Then I see "Ei fanylion rheithiwr" on the page
	
	When I set "Rhif rheithiwr" to "<juror_number>"
	When I set "Cyfenw" to "<last_name>"
	When I set "Cod post Rheithiwr" to "<postcode>"
	And I press the "Parhau" button

	Then I see "Eich Manylion" on the page
	
	When I set "Enw cyntaf" to "FirstNamea"
	And I set "Cyfenw" to "LastNameb"
	And I press the "Parhau" button
	
	And I set "Sut ydych chi" to "Friend"
	And I press the "Parhau" button
	
	And I check the "Dros y ffôn (rhifau yn y DU yn unig)" checkbox
	And I set "Prif rif ffôn" to "02078211818"
	And I check the "Trwy e" checkbox
	When I set input field with "id" of "emailAddress" to "<email>"
	When I set input field with "id" of "emailAddressConfirmation" to "<email>"
	And I press the "Parhau" button
	Then I see "Pam ydych chi'n ymateb ar ran yr unigolyn arall?" on the page
	
	When I set the radio button to "Nid yw'r unigolyn yn gallu ymateb dros ei hun"
	And I press the "Parhau" button
	Then I see "A yw'r enw sydd gennym ar ei gyfer yn gywir?" on the page
	
	When I set the radio button to "Ydy"
	
	When I press the "Parhau" button
	Then I see "Ei gyfeiriad ef yw hwn?" on the page
	
	When I set the radio button to "Ie"
	
	When I press the "Parhau" button
	Then I see "Nodwch ddyddiad geni'r unigolyn rydych chi'n ymateb ar ei ran" on the page
	
	When I set "Diwrnod" to "27"
	And I set "Mis" to "04"
	And I set "Blwyddyn" to "1978"
	And I press the "Parhau" button
	
	Then I see "Efallai bydd yn rhaid inni gysylltu â'r unigolyn i ofyn rhagor o gwestiynau neu roi rhagor o wybodaeth iddynt am eu gwasanaeth rheithgor" on the page

	When I set the radio button to "Defnyddio'r rhif ffôn rydych eisoes wedi'i ddarparu i gysylltu â chi"
	And I set the radio button to "Defnyddio'r cyfeiriad e-bost rydych eisoes wedi'i ddarparu i gysylltu â chi"
	And I press the "Parhau" button
	
	#JDB-3107
	Then I see "Cadarnhau a yw'r unigolyn yn gymwys i wasanaethu ar reithgor" on the page
	And I press the "Parhau" button
	
	#Residency
	And I set the radio button to "Naddo"
	And I see "You have 1000 characters remaining" on the page
	And I set "Rhowch fanylion" to "These are the details."
	And I see "You have 978 characters remaining" on the page
	And I set "Rhowch fanylion" to "These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are t"
	And I see "You have 0 characters remaining" on the page
	And I press the "Parhau" button
	
	#CJS
	And I set the radio button to "Ydy"
	Then I see "Dewiswch unrhyw sefydliadau y mae'r unigolyn rydych yn ymateb ar ei ran wedi gweithio iddynt." on the page
	
	And I check the "Arall" checkbox
	
	And I see "You have 1000 characters remaining" on the page
	And I set "Pa ran arall o’r System Cyfiawnder Troseddol?" to "These are the details."
	And I see "You have 978 characters remaining" on the page
	And I set "Pa ran arall o’r System Cyfiawnder Troseddol?" to "These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are t"
	And I see "You have 0 characters remaining" on the page
	
	And I press the "Parhau" button
	
	#Bail
	And I set the radio button to "Ydy"
	And I see "You have 1000 characters remaining" on the page
	And I set "Rhowch fanylion" to "These are the details."
	And I see "You have 978 characters remaining" on the page
	And I set "Rhowch fanylion" to "These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are t"
	And I see "You have 0 characters remaining" on the page
	And I press the "Parhau" button
	
	#Criminal Convictions
	And I see "A yw'r unigolyn wedi'i gael yn euog o drosedd?" on the page
	And I set the radio button to "Ydy"
	And I see "You have 1000 characters remaining" on the page
	And I set text area with "id" of "convictedDetails" to "These are the details."
	And I see "You have 978 characters remaining" on the page
	And I set text area with "id" of "convictedDetails" to "These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are t"
	And I see "You have 0 characters remaining" on the page
	And I press the "Parhau" button
	
	#Mental Health
	Then I see "A ydi'r person yr ydych yn ymateb ar ei ran yn cael ei gadw, ei warchod neu ei drin o dan y Ddeddf Iechyd Meddwl?" on the page
	And I set the radio button to "Ie"
	And I see "You have 1000 characters remaining" on the page
	And I set "Eglurwch sut y maent yn cael eu cadw dan glo, sut ofal maent yn ei gael neu sut maent yn cael eu trin o dan y Ddeddf Iechyd Meddwl" to "These are the details."
	And I see "You have 978 characters remaining" on the page
	And I set "Eglurwch sut y maent yn cael eu cadw dan glo, sut ofal maent yn ei gael neu sut maent yn cael eu trin o dan y Ddeddf Iechyd Meddwl" to "These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are t"
	And I see "You have 0 characters remaining" on the page
	And I press the "Parhau" button
	
	Then I see "A wnaed penderfyniad nad oes gan y person yr ydych yn ymateb ar ei ran y 'gallu meddyliol'?" on the page
	When I set the radio button to "Ie"
	And I see "You have 1000 characters remaining" on the page
	And I set "Eglurwch yn gryno pam y penderfynwyd nad oes ganddynt alluedd meddyliol" to "These are the details."
	And I see "You have 978 characters remaining" on the page
	And I set "Eglurwch yn gryno pam y penderfynwyd nad oes ganddynt alluedd meddyliol" to "These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are t"
	And I see "You have 0 characters remaining" on the page
	And I press the "Parhau" button
	
	#Can you attend
	And I set the radio button to "Nac ydi, rhaid newid y dyddiad"
	And I press the "Parhau" button
	
	And I see "You have 1000 characters remaining" on the page
	When I set text area with "id" of "deferralReason" to "These are the details."
	And I see "You have 978 characters remaining" on the page
	When I set text area with "id" of "deferralReason" to "These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are t"
	And I see "You have 0 characters remaining" on the page
	
	And I click on the "Cliciwch i fynd yn ôl" link
	
	And I set the radio button to "Nac ydi, ni all yr unigolyn wasanaethu ar reithgor a rhaid esgusodi"
	And I press the "Parhau" button
	
	And I see "You have 1000 characters remaining" on the page
	When I set text area with "id" of "excusalReason" to "These are the details."
	And I see "You have 978 characters remaining" on the page
	When I set text area with "id" of "excusalReason" to "These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are t"
	And I see "You have 0 characters remaining" on the page
	
	And I click on the "Cliciwch i fynd yn ôl" link
	
	And I set the radio button to "Ydi, mae'r unigolyn"
	And I press the "Parhau" button

	#Special Reqs
	Then I see "A fydd yr unigolyn rydych yn ymateb ar ei ran angen cymorth pan fydd yn y llys?" on the page
	
	And I set the radio button to "Oes"
	
	And I check the "Arall" checkbox
	
	And I see "You have 1000 characters remaining" on the page
	And I set "Rhowch fanylion os gwelwch yn dda" to "These are the details."
	And I see "You have 978 characters remaining" on the page
	And I set "Rhowch fanylion os gwelwch yn dda" to "These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are t"
	And I see "You have 0 characters remaining" on the page
	
	And I see "You have 1000 characters remaining" on the page
	And I set "Rhowch wybod inni am unrhyw drefniadau arbennig neu gymorth bydd yr unigolyn rydych yn ymateb ar ei ran ei angen wrth iddo wasanaethu ar reithgor" to "These are the details."
	And I see "You have 978 characters remaining" on the page
	And I set "Rhowch wybod inni am unrhyw drefniadau arbennig neu gymorth bydd yr unigolyn rydych yn ymateb ar ei ran ei angen wrth iddo wasanaethu ar reithgor" to "These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are t"
	And I see "You have 0 characters remaining" on the page
	
	When I press the "Parhau" button
	
	Then I see "Gwiriwch eich ymatebion nawr" on the page
	And I see "A oes gan yr unigolyn anabledd neu nam sy'n golygu bydd angen cymorth neu gyfleusterau ychwanegol arnynt yn yr adeilad llys lle byddant yn cyflawni’r gwasanaeth rheithgor?" on the page

	Then I check the "wybodaeth rwyf wedi ei rhoi am yr unigolyn rwyf yn ymateb ar ei ran yn gywir." checkbox
	When I press the "Cyflwyno" button
	
	Then I see "Rydych wedi cwblhau'r broses ymateb" on the page
	And I see "Rydych wedi cwblhau'r broses ymateb" on the page
	Then I see "<juror_number>" on the page
	
Examples:
	| juror_number	| last_name			| postcode	| email 		| pool_number	|
	| 045200105		| LNAMENINEZEROZERO	| SY2 6LU	| a@eeee.com	| 452300104		|


@Regression @NewSchemaConverted
Scenario Outline: English_3rd_Char_Counts_and_warnings

	Given I am on "Public" "test"

	Given a bureau owned pool is created with jurors
		| court |juror_number  | pool_number	| att_date_weeks_in_future	| owner |
		| 452   |<juror_number>| <pool_number>	| 5				            | 400	|
		
	And juror "<juror_number>" has "LAST_NAME" as "<last_name>" new schema
	And juror "<juror_number>" has "POSTCODE" as "<postcode>" new schema
	
	And I set the radio button to "I am replying for someone else"
	And I press the "Continue" button
	Then I see "Their juror details" on the page
	
	When I set "9-digit juror number" to "<juror_number>"
	When I set "Juror last name" to "<last_name>"
	When I set "Juror postcode" to "<postcode>"
	And I press the "Continue" button
	Then I see "What is your name?" on the page
	
	#3rd Party Name
	When I set "First name" to "FirstNamea"
	And I set "Last name" to "LastNameb"
	And I press the "Continue" button
	Then I see "Your relationship to the person" on the page
	
	#Relationship to juror
	When I set "How do you know the person you're replying for?" to "Friend"
	And I press the "Continue" button
	Then I see "Your contact information" on the page
	
	#3rd Party Contact
	When I see "Your Details" on the page
	When I check the "By phone (UK Numbers only)" checkbox
	And I set "Main phone" to "0207 821 1818"
	And I check the "By email" checkbox
	And I set "Enter your email address" to "<email>"
	And I set "Enter your email address again" to "<email>"
	And I press the "Continue" button
	Then I see "Why are you replying for the other person?" on the page
	
	#Why are you replying for juror
	When I set the radio button to "The person is not here"
	And I press the "Continue" button
	
	#Check juror name
	Then I see "Is the name we have for them correct?" on the page
	When I choose the "Yes" radio button
	And I press the "Continue" button
	
	#Check juror address
	Then I see "Is this their address?" on the page
	When I choose the "Yes" radio button
	And I press the "Continue" button
	
	Then I see "Give the date of birth for the person you're replying for" on the page
	
	#DoB
	When I see "Juror Details" on the page
	And I set "Day" to "27"
	And I set "Month" to "04"
	And I set "Year" to "1981"
	And I press the "Continue" button
	Then I see "We might need to get in touch with the person to ask them more questions or give them information about their jury service" on the page
	
	#Contacting the juror
	When I see "Juror Details" on the page
	And I set the radio button to "Use the phone number that you have already given to contact you"
	And I set the radio button to "Use the email address that you have already given to contact you"
	And I press the "Continue" button
	
	#Does the person you're answering for qualify for jury service?
	Then I see "Confirm if the person is eligible for jury service" on the page
	And I press the "Continue" button
	
	#Eligibility questions
	#residency
	And I choose the "No" radio button
	
	And I see "You have 1,000 characters remaining" on the page
	And I set "Provide details about where the person you are answering for has lived since their 13th birthday" to "These are the details."
	And I see "You have 978 characters remaining" on the page
	And I set "Provide details" to "These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are t"
	And I see "You have 0 characters remaining" on the page
	And I press "back_space" in "Provide details"
	And I press "back_space" in "Provide details"
	And I see "You have 2 characters remaining" on the page
	Then I press "enter" in "Provide details"
	And I append text area with "id" of "livedConsecutiveDetails" with "These"

	And I press the "Continue" button
	And I see "Details about where the person you are answering for has lived since their 13th birthday must be fewer characters" on the page
	
	And I set "Provide details" to "These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are t"
	And I see "You have 0 characters remaining" on the page
	And I press the "Continue" button
	
	#CJS Emp
	And I choose the "Yes" radio button
	And I check the "Other" checkbox
	
	And I see "You have 1,000 characters remaining" on the page
	And I set "Which other part of the Criminal Justice System?" to "These are the details."
	And I see "You have 978 characters remaining" on the page
	And I set "Which other part of the Criminal Justice System?" to "These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are t"
	And I see "You have 0 characters remaining" on the page
	And I press "back_space" in "Which other part of the Criminal Justice System?"
	And I press "back_space" in "Which other part of the Criminal Justice System?"
	And I see "You have 2 characters remaining" on the page
	
	Then I press "enter" in "Which other part of the Criminal Justice System?"
	And I append text area with "id" of "cjsEmployerDetails" with "These"

	And I press the "Continue" button
	And I see "Details of where and when the person has worked for another Criminal Justice System employer must be fewer characters" on the page
	
	And I set "Which other part of the Criminal Justice System?" to "These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are t"
	And I see "You have 0 characters remaining" on the page
	
	And I press the "Continue" button
	
	#bail
	And I choose the "Yes" radio button
	
	And I see "You have 1,000 characters remaining" on the page
	And I set "Provide details about the person's bail and criminal offence" to "These are the details."
	And I see "You have 978 characters remaining" on the page
	And I set "Provide details about the person's bail and criminal offence" to "These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are t"
	And I see "You have 0 characters remaining" on the page
	And I press "back_space" in "Provide details about the person's bail and criminal offence"
	And I press "back_space" in "Provide details about the person's bail and criminal offence"
	And I see "You have 2 characters remaining" on the page
	
	Then I press "enter" in "Provide details about the person's bail and criminal offence"
	And I append text area with "id" of "onBailDetails" with "These"

	And I press the "Continue" button
	And I see "Details about the person's bail and criminal offence must be fewer characters" on the page
	
	And I set "Provide details" to "These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are t"
	And I see "You have 0 characters remaining" on the page
	
	And I press the "Continue" button

	#criminaloffence
	And I choose the "Yes" radio button
	
	And I see "You have 1,000 characters remaining" on the page
	And I set text area with "id" of "convictedDetails" to "These are the details."
	And I see "You have 978 characters remaining" on the page
	And I set text area with "id" of "convictedDetails" to "These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are t"
	And I see "You have 0 characters remaining" on the page
	And I set text area with "id" of "convictedDetails" to "These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are"
	And I see "You have 2 characters remaining" on the page
	
	Then I press "enter" in "Provide details"
	And I append text area with "id" of "convictedDetails" with "These"

	And I press the "Continue" button
	And I see "Details about the person's criminal offence must be fewer characters" on the page
	
	And I set text area with "id" of "convictedDetails" to "These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are t"
	And I see "You have 0 characters remaining" on the page
	
	And I press the "Continue" button
	
	#mentalhealth1
	And I choose the "Yes" radio button
	
	And I see "You have 1,000 characters remaining" on the page
	And I set "Provide details about how they're being detained, looked after or treated under the Mental Health Act" to "These are the details."
	And I see "You have 978 characters remaining" on the page
	And I set "Provide details about how they're being detained, looked after or treated under the Mental Health Act" to "These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are t"
	And I see "You have 0 characters remaining" on the page
	And I set "Provide details about how they're being detained, looked after or treated under the Mental Health Act" to "These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are"
	And I see "You have 2 characters remaining" on the page
	
	Then I press "enter" in "Provide details about how they're being detained, looked after or treated under the Mental Health Act"
	And I append text area with "id" of "mentalHealthSectionedDetails" with "These"

	And I press the "Continue" button
	And I see "Details details about how they're being detained, looked after or treated under the Mental Health Act must be fewer characters" on the page
	And I set "Provide details about how they're being detained, looked after or treated under the Mental Health Act" to "These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are t"
	And I see "You have 0 characters remaining" on the page

	And I press the "Continue" button
	
	#mentalhealth2
	And I choose the "Yes" radio button
	
	And I see "You have 1,000 characters remaining" on the page
	And I set "Provide brief details about why it was decided they lack mental capacity" to "These are the details."
	And I see "You have 978 characters remaining" on the page
	And I set "Provide brief details about why it was decided they lack mental capacity" to "These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are t"
	And I see "You have 0 characters remaining" on the page
	And I set "Provide brief details about why it was decided they lack mental capacity" to "These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are"
	And I see "You have 2 characters remaining" on the page
	
	Then I press "enter" in "Provide details"
	And I append text area with "id" of "mentalHealthCapacityDetails" with "These"

	And I press the "Continue" button
	And I see "Details about why it was decided they lack mental capacity must be fewer characters" on the page
	
	And I set "Provide brief details about why it was decided they lack mental capacity" to "These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are t"
	And I see "You have 0 characters remaining" on the page
	
	And I press the "Continue" button
	
	#excusal
	And I set the radio button to "No, they cannot do"
	And I press the "Continue" button
	
	And I see "You have 1,000 characters remaining" on the page
	And I set text area with "id" of "excusalReason" to "These are the details."
	And I see "You have 978 characters remaining" on the page
	And I set text area with "id" of "excusalReason" to "These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are t"
	And I see "You have 0 characters remaining" on the page
	
	And I see "Explain why they cannot do jury service in the next 12 months." on the page
	And I see "You do not need to attach or gather evidence before their summons deadline." on the page
	And I see "We'll get in touch later if we need this." on the page
	And I set text area with "id" of "excusalReason" to "These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are"
	And I see "You have 2 characters remaining" on the page
	
	Then I press "enter" in "Explain why they cannot do jury service in the next 12 months."
	And I append text area with "id" of "excusalReason" with "These"

	And I press the "Continue" button
	And I see "The reason for asking for the person to be excused from jury service must be fewer characters" on the page
	
	And I set text area with "id" of "excusalReason" to "These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are t"
	And I see "You have 0 characters remaining" on the page
	
	And I press the "Continue" button
	
	#deferral
	Then I click on the "Back" link
	Then I click on the "Back" link
	
	And I set the radio button to "No, we need to change the date"
	And I press the "Continue" button
	
	And I see "You have 1,000 characters remaining" on the page
	And I set text area with "id" of "deferralReason" to "These are the details."
	And I see "You have 978 characters remaining" on the page
	And I set text area with "id" of "deferralReason" to "These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are t"
	And I see "You have 0 characters remaining" on the page

	And I append text area with "id" of "deferralReason" with "These"

	And I press the "Continue" button
	And I see "The reason for asking for a later date for the person's jury service must be fewer characters" on the page
	
	And I set text area with "id" of "deferralReason" to "These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are t"
	And I see "You have 0 characters remaining" on the page
	
	And I press the "Continue" button
	
	Then I click on the "Back" link
	Then I click on the "Back" link
	
	Then I set the radio button to "Yes, they can start on"
	And I press the "Continue" button

	#Help in court
	And I choose the "Yes" radio button
	And I check the "Other" checkbox
	
	And I see "You have 1,000 characters remaining" on the page
	And I set "Provide details" to "These are the details."
	And I see "You have 978 characters remaining" on the page
	And I set "Provide details" to "These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are t"
	And I see "You have 0 characters remaining" on the page
	And I set "Provide details" to "These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are"
	And I see "You have 2 characters remaining" on the page
	
	Then I press "enter" in "Provide details"
	And I append text area with "id" of "assistanceTypeDetails" with "These"

	And I press the "Continue" button
	And I see "The details of the person's disability or impairment must be fewer characters" on the page
	
	And I set "Provide details" to "These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are t"
	And I see "You have 0 characters remaining" on the page
	
	And I press the "Continue" button

	#Check your answers
	Then I check the "The answers I have given for the person I'm replying for are true as far as I know." checkbox

	When I press the "Submit" button
	
	Then I see "You have completed your reply" on the page
	
Examples:
	| juror_number	| last_name				| postcode	| email         	| pool_number	|
	| 045200106		| LNAMEEIGHTEIGHTTHREE	| SY2 6LU	| email@outlook.com	| 452300105		|
	
@Regression @NewSchemaConverted
Scenario Outline: English_Special_Chars

	Given I am on "Public" "test"

	Given a bureau owned pool is created with jurors
		| court |juror_number  | pool_number	| att_date_weeks_in_future	| owner |
		| 452   |<juror_number>| <pool_number>	| 5				            | 400	|
		
	And juror "<juror_number>" has "LAST_NAME" as "<last_name>" new schema
	And juror "<juror_number>" has "POSTCODE" as "<postcode>" new schema
	
	And I set the radio button to "I am replying for myself"
	And I press the "Continue" button
	Then I see "Your juror details" on the page
	
	When I set "9-digit juror number" to "<juror_number>"
	And I set "Juror last name" to "<last_name>"
	And I set "Juror postcode" to "<postcode>"
	And I press the "Continue" button
	Then I see "Is the name we have for you correct?" on the page
	When I choose the "Yes" radio button

	#name
	And I choose the "Yes" radio button
	When I press the "Continue" button
	
	#address
	Then I see "Is this your address?" on the page
	
	And I choose the "Yes" radio button
	And I press the "Continue" button
	
	#phone
	Then I see "What is your phone number?" on the page
	When I set "Main phone" to "02078211818"
	And I press the "Continue" button

	#email
	Then I see "What is your email address?" on the page
	When I set "Enter your email address" to "<email>"
	When I set "Enter your email address again" to "<email>"
	And I press the "Continue" button

	#DOB
	Then I see "What is your date of birth?" on the page
	When I set "Day" to "27"
	And I set "Month" to "04"
	And I set "Year" to "1981"
	And I press the "Continue" button

	#Qualify for jury service
	Then I see "Confirm you're eligible for jury service" on the page
	When I press the "Continue" button
	
	#Residency
	Then I see "Since you turned 13, has your main address been in the UK, Channel Islands or Isle of Man for any period of at least 5 years?" on the page
	And I choose the "No" radio button
	
	And I see "You have 1,000 characters remaining" on the page
	And I set "Provide details about where you have lived since your 13th birthday" to "1234567890"
	And I see "You have 990 characters remaining" on the page
	And I press the "Continue" button
	Then I click on the "Back" link
	
	Then "Provide details about where you have lived since your 13th birthday" is "1234567890"
	When I set "Provide details about where you have lived since your 13th birthday" to "££££££££££"
	And I see "You have 990 characters remaining" on the page
	And I press the "Continue" button
	Then I click on the "Back" link
	
	Then "Provide details about where you have lived since your 13th birthday" is "££££££££££"
	And I set "Provide details about where you have lived since your 13th birthday" to "@@@@@@@@@@"
	And I see "You have 990 characters remaining" on the page
	And I press the "Continue" button
	Then I click on the "Back" link
	
	Then "Provide details about where you have lived since your 13th birthday" is "@@@@@@@@@@"
	And I set "Provide details about where you have lived since your 13th birthday" to "!$%^&*()-+"
	And I see "You have 990 characters remaining" on the page
	And I press the "Continue" button
	Then I click on the "Back" link
	
	Then "Provide details about where you have lived since your 13th birthday" is "!$%^&*()-+"
	And I set "Provide details about where you have lived since your 13th birthday" to "{[]:;'@?>¬"
	And I see "You have 990 characters remaining" on the page
	And I press the "Continue" button
	Then I click on the "Back" link
	
	Then "Provide details about where you have lived since your 13th birthday" is "{[]:;'@?>¬"
	And I set "Provide details about where you have lived since your 13th birthday" to "</\|_=.,</\|_=.,</\|_=.,</\|_=.,</\|_=.,</\|_=.,</\|_=.,</\|_=.,</\|_=.,</\|_=.,</\|_=.,</\|_=.,</\|_=.,</\|_=.,</\|_=.,</\|_=.,</\|_=.,</\|_=.,</\|_=.,</\|_=.,</\|_=.,</\|_=.,</\|_=.,</\|_=.,</\|_=.,</\|_=.,</\|_=.,</\|_=.,</\|_=.,</\|_=.,</\|_=.,</\|_=.,</\|_=.,</\|_=.,</\|_=.,</\|_=.,</\|_=.,</\|_=.,</\|_=.,</\|_=.,</\|_=.,</\|_=.,</\|_=.,</\|_=.,</\|_=.,</\|_=.,</\|_=.,</\|_=.,</\|_=.,</\|_=.,</\|_=.,</\|_=.,</\|_=.,</\|_=.,</\|_=.,</\|_=.,</\|_=.,</\|_=.,</\|_=.,</\|_=.,</\|_=.,</\|_=.,</\|_=.,</\|_=.,</\|_=.,</\|_=.,</\|_=.,</\|_=.,</\|_=.,</\|_=.,</\|_=.,</\|_=.,</\|_=.,</\|_=.,</\|_=.,</\|_=.,</\|_=.,</\|_=.,</\|_=.,</\|_=.,</\|_=.,</\|_=.,</\|_=.,</\|_=.,</\|_=.,</\|_=.,</\|_=.,</\|_=.,</\|_=.,</\|_=.,</\|_=.,</\|_=.,</\|_=.,</\|_=.,</\|_=.,</\|_=.,</\|_=.,</\|_=.,</\|_=.,</\|_=.,</\|_=.,</\|_=.,</\|_=.,</\|_=.,</\|_=.,</\|_=.,</\|_=.,</\|_=.,</\|_=.,</\|_=.,</\|_=.,</\|_=.,</\|_=.,</\|_=.,</\|_=.,</\|_=.,</\|_=.,</\|_=.,</\|_=.,</\|_=.,</\|_=.,</\|_=.,</\|_=.,</\|_=.,</\|_=.,"
	And I see "You have 0 characters remaining" on the page
	And I press the "Continue" button
	Then I click on the "Back" link
	
	Then "Provide details about where you have lived since your 13th birthday" is "</\|_=.,</\|_=.,</\|_=.,</\|_=.,</\|_=.,</\|_=.,</\|_=.,</\|_=.,</\|_=.,</\|_=.,</\|_=.,</\|_=.,</\|_=.,</\|_=.,</\|_=.,</\|_=.,</\|_=.,</\|_=.,</\|_=.,</\|_=.,</\|_=.,</\|_=.,</\|_=.,</\|_=.,</\|_=.,</\|_=.,</\|_=.,</\|_=.,</\|_=.,</\|_=.,</\|_=.,</\|_=.,</\|_=.,</\|_=.,</\|_=.,</\|_=.,</\|_=.,</\|_=.,</\|_=.,</\|_=.,</\|_=.,</\|_=.,</\|_=.,</\|_=.,</\|_=.,</\|_=.,</\|_=.,</\|_=.,</\|_=.,</\|_=.,</\|_=.,</\|_=.,</\|_=.,</\|_=.,</\|_=.,</\|_=.,</\|_=.,</\|_=.,</\|_=.,</\|_=.,</\|_=.,</\|_=.,</\|_=.,</\|_=.,</\|_=.,</\|_=.,</\|_=.,</\|_=.,</\|_=.,</\|_=.,</\|_=.,</\|_=.,</\|_=.,</\|_=.,</\|_=.,</\|_=.,</\|_=.,</\|_=.,</\|_=.,</\|_=.,</\|_=.,</\|_=.,</\|_=.,</\|_=.,</\|_=.,</\|_=.,</\|_=.,</\|_=.,</\|_=.,</\|_=.,</\|_=.,</\|_=.,</\|_=.,</\|_=.,</\|_=.,</\|_=.,</\|_=.,</\|_=.,</\|_=.,</\|_=.,</\|_=.,</\|_=.,</\|_=.,</\|_=.,</\|_=.,</\|_=.,</\|_=.,</\|_=.,</\|_=.,</\|_=.,</\|_=.,</\|_=.,</\|_=.,</\|_=.,</\|_=.,</\|_=.,</\|_=.,</\|_=.,</\|_=.,</\|_=.,</\|_=.,</\|_=.,</\|_=.,</\|_=.,</\|_=.,"
	And I set "Provide details about where you have lived since your 13th birthday" to "áéíóúüôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâôâ"
	And I see "You have 0 characters remaining" on the page
	And I press "back_space" in "Provide details"
	And I see "You have 1 character remaining" on the page
	And I press the "Continue" button
	Then I click on the "Back" link
	
	And I see "You have 1 character remaining" on the page
	And I set "Provide details about where you have lived since your 13th birthday" to "These are the details.These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are th"
	And I see "You have 0 characters remaining" on the page
	And I press "back_space" in "Provide details"
	And I see "You have 1 character remaining" on the page
	And I press the "Continue" button
	Then I click on the "Back" link
	
	And I see "You have 1 character remaining" on the page
	And I set "Provide details about where you have lived since your 13th birthday" to "These are the details."
	And I press "enter" in "Provide details about where you have lived since your 13th birthday"
	And I see "You have 977 characters remaining" on the page
	And I append text area with "id" of "livedConsecutiveDetails" with "These are the details.These are the details. These are the details. These are the details. These are the details. These are the details. These are the details."
	And I see "You have 818 characters remaining" on the page
	And I press "enter" in "Provide details about where you have lived since your 13th birthday"
	And I append text area with "id" of "livedConsecutiveDetails" with "These are the details.These are the details. These are the details. These are the details. These are the details. These are the details. These are the details."
	And I see "You have 658 characters remaining" on the page
	And I press "enter" in "Provide details about where you have lived since your 13th birthday"
	And I append text area with "id" of "livedConsecutiveDetails" with "These are the details.These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details.These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details."
	And I see "You have 62 characters remaining" on the page
	And I press "enter" in "Provide details about where you have lived since your 13th birthday"
	And I append text area with "id" of "livedConsecutiveDetails" with "These are the details. These are the details. These are the d"
	And I see "You have 0 characters remaining" on the page
	And I press the "Continue" button
	
	Then I see "Details about where you have lived since your 13th birthday must be fewer characters" on the page
	And I see "There is a problem" on the page
	
	And I set "Provide details about where you have lived since your 13th birthday" to "These are the details."
	And I see "You have 978 characters remaining" on the page
	And I press the "Continue" button
	
	Then I click on the "Back" link
	And I see "You have 978 characters remaining" on the page

	And I press the "Continue" button
	
	#CJS no
	Then I see "Have you worked in the criminal justice system in the last 5 years?" on the page
	When I choose the "No" radio button
	And I press the "Continue" button
	
	#Bail
	Then I see "Are you currently on bail for a criminal offence?" on the page
	When I see "Eligibility" on the page
	And I choose the "No" radio button
	And I press the "Continue" button
	
	#Convictions
	Then I see "Have you been found guilty of a criminal offence?" on the page
	When I see "Eligibility" on the page
	When I choose the "No" radio button
	And I press the "Continue" button
	
	#Mental Health Sectioned
	Then I see "Are you being detained, looked after or treated under the Mental Health Act?" on the page
	When I see "Eligibility" on the page
	And I choose the "No" radio button
	And I press the "Continue" button
	
	#Mental Health Capacity
	Then I see "Has it been decided that you 'lack mental capacity'?" on the page
	When I see "Eligibility" on the page
	And I choose the "No" radio button
	And I press the "Continue" button
	
	#I can attend
	Then I see "Check your start date" on the page
	And I see "Yes, I can start on" on the page
	And I set the radio button to "Yes, I can start on"
	And  I press the "Continue" button
	
	#RA no
	Then I see "Will you need help when you're at the court?" on the page
	When I choose the "No" radio button
	And I press the "Continue" button
	Then I see "Check your answers now" on the page
	
	#Check your answers
	When I check the "The information I have given is true to the best of my knowledge" checkbox
	And I press the "Submit" button
	Then I see "We have sent you an email to say you have replied to your jury summons." on the page
	
Examples:
	| juror_number	| last_name			| postcode	| email          	| pool_number	|
	| 045200107		| LNAMEEIGHTZEROFIVE| SA1 4PF	| email@outlook.com	| 452300106		|
	
@Regression @NewSchemaConverted
Scenario Outline: English_1st_Char_Counts_and_warnings

	Given I am on "Public" "test"

	Given a bureau owned pool is created with jurors
		| court |juror_number  | pool_number	| att_date_weeks_in_future	| owner |
		| 452   |<juror_number>| <pool_number>	| 5				            | 400	|
		
	And juror "<juror_number>" has "LAST_NAME" as "<last_name>" new schema
	And juror "<juror_number>" has "POSTCODE" as "<postcode>" new schema
	
	And I set the radio button to "I am replying for myself"
	And I press the "Continue" button
	
	When I set "9-digit juror number" to "<juror_number>"
	When I set "Juror last name" to "<last_name>"
	When I set "Juror postcode" to "<postcode>"
	And I press the "Continue" button
	
	#name
	Then I see "Is the name we have for you correct?" on the page
	When I choose the "Yes" radio button
	And I press the "Continue" button
	
	#address
	Then I see "Is this your address?" on the page
	When I choose the "Yes" radio button
	And I press the "Continue" button
	
	#phone
	Then I see "What is your phone number?" on the page
	And I set "Main phone" to "01211234444"
	And I set "Another phone (optional)" to "07111111111"
	And I press the "Continue" button
	
	#email
	Then I see "What is your email address?" on the page
	And I set "Enter your email address" to "<email>"
	And I set "Enter your email address again" to "<email>"
	And I press the "Continue" button
		
	Then I see "What is your date of birth?" on the page
	
	#DoB
	And I set "Day" to "27"
	And I set "Month" to "04"
	And I set "Year" to "1981"
	And I press the "Continue" button
	
	#Eligibility questions
	And I press the "Continue" button
	
	#residency
	And I choose the "No" radio button
	
	And I see "You have 1,000 characters remaining" on the page
	And I set "Provide details about where you have lived since your 13th birthday" to "These are the details."
	And I see "You have 978 characters remaining" on the page
	And I set "Provide details about where you have lived since your 13th birthday" to "These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are t"
	And I see "You have 0 characters remaining" on the page
	And I press "back_space" in "Provide details about where you have lived since your 13th birthday"
	And I press "back_space" in "Provide details about where you have lived since your 13th birthday"
	And I see "You have 2 characters remaining" on the page
	Then I press "enter" in "Provide details about where you have lived since your 13th birthday"
	And I append text area with "id" of "livedConsecutiveDetails" with "These"

	And I press the "Continue" button
	And I see "Details about where you have lived since your 13th birthday must be fewer characters" on the page
	
	And I set "Provide details about where you have lived since your 13th birthday" to "These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are t"
	And I see "You have 0 characters remaining" on the page
	And I press the "Continue" button
	
	#CJS Emp
	And I choose the "Yes" radio button
	And I check the "Other" checkbox
	
	And I see "You have 1,000 characters remaining" on the page
	And I set "Which other part of the Criminal Justice System?" to "These are the details."
	And I see "You have 978 characters remaining" on the page
	And I set "Which other part of the Criminal Justice System?" to "These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are t"
	And I see "You have 0 characters remaining" on the page
	And I press "back_space" in "Which other part of the Criminal Justice System?"
	And I press "back_space" in "Which other part of the Criminal Justice System?"
	And I see "You have 2 characters remaining" on the page
	
	Then I press "enter" in "Which other part of the Criminal Justice System?"
	And I append text area with "id" of "cjsEmployerDetails" with "These"

	And I press the "Continue" button
	And I see "Details of where and when you have worked for another Criminal Justice System employer must be fewer characters" on the page
	
	And I set "Which other part of the Criminal Justice System?" to "These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are t"
	And I see "You have 0 characters remaining" on the page
	
	And I press the "Continue" button
	
	#bail
	And I choose the "Yes" radio button
	
	And I see "You have 1,000 characters remaining" on the page
	And I set "Provide details about your bail and criminal offence" to "These are the details."
	And I see "You have 978 characters remaining" on the page
	And I set "Provide details about your bail and criminal offence" to "These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are t"
	And I see "You have 0 characters remaining" on the page
	And I press "back_space" in "Provide details about your bail and criminal offence"
	And I press "back_space" in "Provide details about your bail and criminal offence"
	And I see "You have 2 characters remaining" on the page
	
	Then I press "enter" in "Provide details about your bail and criminal offence"
	And I append text area with "id" of "onBailDetails" with "These"

	And I press the "Continue" button
	And I see "Details about your bail and criminal offence must be fewer characters" on the page
	
	And I set "Provide details about your bail and criminal offence" to "These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are t"
	And I see "You have 0 characters remaining" on the page
	
	And I press the "Continue" button

	#criminaloffence
	And I choose the "Yes" radio button
	
	And I see "You have 1,000 characters remaining" on the page
	And I set text area with "id" of "convictedDetails" to "These are the details."
	And I see "You have 978 characters remaining" on the page
	And I set text area with "id" of "convictedDetails" to "These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are t"
	And I see "You have 0 characters remaining" on the page
	And I set text area with "id" of "convictedDetails" to "These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are"
	And I see "You have 2 characters remaining" on the page
	
	Then I press "enter" in "Provide details"
	And I append text area with "id" of "convictedDetails" with "These"

	And I press the "Continue" button
	And I see "Details about your criminal offence must be fewer characters" on the page
	
	And I set text area with "id" of "convictedDetails" to "These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are t"
	And I see "You have 0 characters remaining" on the page
	
	And I press the "Continue" button
	
	#mentalhealth1
	And I choose the "Yes" radio button
	
	And I see "You have 1,000 characters remaining" on the page
	And I set "Provide details" to "These are the details."
	And I see "You have 978 characters remaining" on the page
	And I set "Provide details" to "These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are t"
	And I see "You have 0 characters remaining" on the page
	And I set "Provide details" to "These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are"
	
	And I see "You have 2 characters remaining" on the page
	
#	Then I press "enter" in "Provide details"
#	And I append text area with "id" of "mentalHealthSectionedDetails" with "These"
#
#	And I press the "Continue" button
#	And I see "Details about how you are detained, or likely to be detained, under the Mental Health Act 1983 must be fewer characters" on the page
#
#	And I set "Provide details" to "These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are t"
#	And I see "You have 0 characters remaining" on the page
#
	And I press the "Continue" button
	
	#mentalhealth2
	And I choose the "Yes" radio button
	
	And I see "You have 1,000 characters remaining" on the page
	And I set "Provide brief details about why it was decided you lack mental capacity" to "These are the details."
	And I see "You have 978 characters remaining" on the page
	And I set "Provide brief details about why it was decided you lack mental capacity" to "These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are t"
	And I see "You have 0 characters remaining" on the page
	And I set "Provide brief details about why it was decided you lack mental capacity" to "These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are"
	And I see "You have 2 characters remaining" on the page
	
#	Then I press "enter" in "Provide details"
#	And I append text area with "id" of "mentalHealthCapacityDetails" with "These"
#
#	And I press the "Continue" button
#	And I see "Details about how you lack capacity as stated in the Mental Capacity Act 2005 must be fewer characters" on the page
#	
#	And I set "Provide details" to "These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are t"
#	And I see "You have 0 characters remaining" on the page
	
	And I press the "Continue" button
	
	#excusal
	And I set the radio button to "No, I cannot do jury service and need to be excused"
	And I press the "Continue" button
	
	And I see "You have 1,000 characters remaining" on the page
	And I set text area with "id" of "excusalReason" to "These are the details."
	And I see "You have 978 characters remaining" on the page
	And I set text area with "id" of "excusalReason" to "These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are t"
	And I see "You have 0 characters remaining" on the page
	And I set text area with "id" of "excusalReason" to "These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are"
	And I see "You have 2 characters remaining" on the page
	
#	Then I press "enter" in "Please Explain why you cannot do jury service in the next 12 months. You do not need to attach or gather evidence before your summons deadline. We'll contact you later if we need this."
#	And I append text area with "id" of "excusalReason" with "These"
#
#	And I press the "Continue" button
#	And I see "Your reason for asking to be excused from jury service must be fewer characters" on the page
#	
#	And I set text area with "id" of "excusalReason" to "These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are t"
#	And I see "You have 0 characters remaining" on the page
	
	And I press the "Continue" button
	
	#deferral
	Then I click on the "Back" link
	Then I click on the "Back" link
	
	And I set the radio button to "No, I need to change the date"
	And I press the "Continue" button
	
	And I see "You have 1,000 characters remaining" on the page
	And I set text area with "id" of "deferralReason" to "These are the details."
	And I see "You have 978 characters remaining" on the page
	And I set text area with "id" of "deferralReason" to "These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the"

	And I press the "Continue" button
	And I see "Your reason for asking for a later date for your jury service must be fewer characters" on the page
	
	And I set text area with "id" of "deferralReason" to "These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are t"
	And I see "You have 0 characters remaining" on the page
	
	And I press the "Continue" button
	
	Then I click on the "Back" link
	Then I click on the "Back" link
	
	And I see "Yes, I can start on" on the page
	And I set the radio button to "Yes, I can start on"
	And I press the "Continue" button
	
	#Help in court
	And I choose the "Yes" radio button
	And I check the "Other" checkbox
	
	And I see "You have 1,000 characters remaining" on the page
	And I set "Provide details" to "These are the details."
	And I see "You have 978 characters remaining" on the page
	And I set "Provide details" to "These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are t"
	And I see "You have 0 characters remaining" on the page
	And I set "Provide details" to "These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are"
	And I see "You have 2 characters remaining" on the page
	
#	Then I press "enter" in "Provide details"
#	And I append text area with "id" of "assistanceTypeDetails" with "These"
#
#	And I press the "Continue" button
#	And I see "The details of your disability or impairment must be fewer characters" on the page
#	
#	And I set "Provide details" to "These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are t"
#	And I see "You have 0 characters remaining" on the page
	
	And I press the "Continue" button

	#Check your answers
	Then I check the "The information I have given is true to the best of my knowledge" checkbox

	When I press the "Submit" button
	
	Then I see "You have completed your reply" on the page
	
Examples:
	| juror_number	| last_name			| postcode	| email           	| pool_number	|
	| 045200108		| LNAMENINETWOTWO	| SY2 6LU	| email@outlook.com	| 452300107		|
	
@Regression @NewSchemaConverted
Scenario Outline: English_1st_Char_Counts_YesToNo

	Given I am on "Public" "test"

	Given a bureau owned pool is created with jurors
		| court |juror_number  | pool_number	| att_date_weeks_in_future	| owner |
		| 452   |<juror_number>| <pool_number>	| 5				            | 400	|
		
	And juror "<juror_number>" has "LAST_NAME" as "<last_name>" new schema
	And juror "<juror_number>" has "POSTCODE" as "<postcode>" new schema
	
	And I set the radio button to "I am replying for myself"
	And I press the "Continue" button
	
	When I set "9-digit juror number" to "<juror_number>"
	When I set "Juror last name" to "<last_name>"
	When I set "Juror postcode" to "<postcode>"
	And I press the "Continue" button
	
	#name
	Then I see "Is the name we have for you correct?" on the page
	When I choose the "Yes" radio button
	And I press the "Continue" button
	
	#address
	Then I see "Is this your address?" on the page
	When I choose the "Yes" radio button
	And I press the "Continue" button
	
	#phone
	Then I see "What is your phone number?" on the page
	And I set "Main phone" to "01211234444"
	And I set "Another phone (optional)" to "07111111111"
	And I press the "Continue" button
	
	#email
	Then I see "What is your email address?" on the page
	And I set "Enter your email address" to "<email>"
	And I set "Enter your email address again" to "<email>"
	And I press the "Continue" button
		
	Then I see "What is your date of birth?" on the page
	
	#DoB
	And I set "Day" to "27"
	And I set "Month" to "04"
	And I set "Year" to "1981"
	And I press the "Continue" button
	
	#Eligibility questions
	And I press the "Continue" button
	
	#residency
	And I choose the "No" radio button
	
	And I see "You have 1,000 characters remaining" on the page
	And I set "Provide details" to "These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are t"
	And I see "You have 0 characters remaining" on the page

	And I choose the "Yes" radio button
	And I do not see "You have 0 characters remaining" on the page
	
	And I choose the "No" radio button
	And I see "You have 0 characters remaining" on the page

	And I choose the "Yes" radio button
	
	And I press the "Continue" button
	
	#CJS Emp
	And I choose the "Yes" radio button
	And I check the "Other" checkbox
	
	And I see "You have 1,000 characters remaining" on the page
	And I set "Which other part of the Criminal Justice System?" to "These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are t"
	And I see "You have 0 characters remaining" on the page
	
	And I choose the "No" radio button
	And I do not see "You have 0 characters remaining" on the page
	
	And I choose the "Yes" radio button
	And I see "You have 0 characters remaining" on the page

	And I choose the "No" radio button
	
	And I press the "Continue" button
	
	#bail
	And I choose the "Yes" radio button
	
	And I see "You have 1,000 characters remaining" on the page
	And I set "Provide details" to "These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are t"
	And I see "You have 0 characters remaining" on the page

	And I choose the "No" radio button
	And I do not see "You have 0 characters remaining" on the page
	
	And I choose the "Yes" radio button
	And I see "You have 0 characters remaining" on the page

	And I choose the "No" radio button
	
	And I press the "Continue" button

	#criminaloffence
	And I choose the "Yes" radio button
	
	And I see "You have 1,000 characters remaining" on the page
	And I set text area with "id" of "convictedDetails" to "These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are t"
	And I see "You have 0 characters remaining" on the page

	And I choose the "No" radio button
	And I do not see "You have 0 characters remaining" on the page
	
#	And I choose the "Yes" radio button
#	And I see "You have 1,000 characters remaining" on the page
#
#	And I choose the "No" radio button
	
	And I press the "Continue" button
	
	#mentalhealth1
	And I choose the "Yes" radio button
	
	And I see "You have 1,000 characters remaining" on the page
	And I set "Provide details about how you're being detained, looked after or treated under the Mental Health Act" to "These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are t"
	And I see "You have 0 characters remaining" on the page

	And I press the "Continue" button
	
	And I choose the "No" radio button
	
	#mentalhealth2
	And I choose the "Yes" radio button
	
	And I see "You have 1,000 characters remaining" on the page
	And I set "Provide brief details about why it was decided you lack mental capacity" to "These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are t"
	And I see "You have 0 characters remaining" on the page

	And I choose the "No" radio button
	And I do not see "You have 0 characters remaining" on the page
	
#	And I choose the "Yes" radio button
#	And I see "You have 1,000 characters remaining" on the page
#
#	And I choose the "No" radio button
	
	And I press the "Continue" button
	
	#candojuryservice
	And I see "Yes, I can start on" on the page
	And I set the radio button to "Yes, I can start on"
	And I press the "Continue" button

	#Help in court
	And I choose the "Yes" radio button
	And I check the "Other" checkbox
	
	And I see "You have 1,000 characters remaining" on the page
	And I set "Provide details" to "These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are t"
	And I see "You have 0 characters remaining" on the page
	
#	And I choose the "No" radio button
#	And I do not see "You have 0 characters remaining" on the page
#	
#	And I choose the "Yes" radio button
#	And I see "You have 0 characters remaining" on the page
#
#	And I choose the "No" radio button
	
	And I press the "Continue" button

	#Check your answers
	Then I check the "The information I have given is true to the best of my knowledge" checkbox

	When I press the "Submit" button
	
	Then I see "You have completed your reply" on the page
	
Examples:
	| juror_number	| last_name			| postcode	| email           	| pool_number	|
	| 045200109		| LNAMENINETWOSEVEN	| SY2 6LU	| email@outlook.com	| 452300108		|