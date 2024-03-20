Feature: Regression Test JDB-3845

#CJS Question

@RegressionWelsh @NewSchemaConverted
Scenario Outline: Welsh_3rd_CJS

	Given I am on the welsh version of "Public" "test"

	Given a bureau owned pool is created with jurors
		| court |juror_number  | pool_number	| att_date_weeks_in_future	| owner |
		| 457   |<juror_number>| <pool_number>	| 5				            | 400	|
		
	And juror "<juror_number>" has "LAST_NAME" as "<last_name>" new schema
	And juror "<juror_number>" has "POSTCODE" as "<postcode>" new schema
	
	And I set the radio button to "Rwy'n ymateb ar ran rhywun arall"
	And I press the "Parhau" button
	
	When I set "Rhif rheithiwr" to "<juror_number>"
	When I set "Cyfenw" to "<last_name>"
	When I set "Cod post Rheithiwr" to "<postcode>"
	And I press the "Parhau" button
	
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
	
	When I set the radio button to "Nid yw'r unigolyn yn gallu ymateb dros ei hun"
	And I press the "Parhau" button
	
	Then I set the radio button to "Ydy"
	And I press the "Parhau" button
	
	Then I set the radio button to "Ie"
	And I press the "Parhau" button
	
	When I set "Diwrnod" to "27"
	And I set "Mis" to "04"

	And I set "Blwyddyn" to "1978"
	And I press the "Parhau" button
	
	When I set the radio button to "Defnyddio'r rhif ffôn rydych eisoes wedi'i ddarparu i gysylltu â chi"
	And I set the radio button to "Defnyddio'r cyfeiriad e-bost rydych eisoes wedi'i ddarparu i gysylltu â chi"
	And I press the "Parhau" button
	
	And I press the "Parhau" button
	
#Residency
	And I set the radio button to "Do"
	And I press the "Parhau" button
	
#CJS
	And I set the radio button to "Ydy"
	Then I see "Dewiswch unrhyw sefydliadau y mae'r unigolyn rydych yn ymateb ar ei ran wedi gweithio iddynt." on the page
	And I check the "Yr heddlu" checkbox
	And I set "Pa heddlu?" to "London Police service"
	And I check the "Gwasanaeth Carchardai EM" checkbox
	And I set "Pa ran o Wasanaeth Carchardai EM?" to "London Prison Service"
	And I check the "Y Farnwriaeth" checkbox
	And I check the "Yr Asiantaeth Troseddu Cenedlaethol" checkbox
	And I check the "Gwasanaeth Llysoedd a Thribiwnlysoedd EM" checkbox
	And I check the "Arall" checkbox
	And I set "Pa ran arall o’r System Cyfiawnder Troseddol?" to "Other part CJS"
	And I press the "Parhau" button

#Bail
	And I set the radio button to "Nac ydy"
	And I press the "Parhau" button
	
#Criminal Convictions
	And I see "A yw'r unigolyn wedi'i gael yn euog o drosedd?" on the page
	And I set the radio button to "Nac ydy"
	And I press the "Parhau" button
	
#Mental Health
	Then I see "A ydi'r person yr ydych yn ymateb ar ei ran yn cael ei gadw, ei warchod neu ei drin o dan y Ddeddf Iechyd Meddwl?" on the page
	And I set the radio button to "Na"
	And I press the "Parhau" button
	
	Then I see "A wnaed penderfyniad nad oes gan y person yr ydych yn ymateb ar ei ran y 'gallu meddyliol'?" on the page
	When I set the radio button to "Na"
	And I press the "Parhau" button

#Can you attend
	And I set the radio button to "Ydi, mae'r unigolyn yn gallu dechrau"
	And I press the "Parhau" button

	#Special Reqs
	Then I see "A fydd yr unigolyn rydych yn ymateb ar ei ran angen cymorth pan fydd yn y llys?" on the page
	
	And I set the radio button to "Nac oes"

	When I press the "Parhau" button

	#check answers
	And I see text "Ydy" in the same row as "person yr ydych yn ymateb ar ei ran wedi gweithio yn y system cyfiawnder troseddol yn y 5 mlynedd diwethaf?"
	And I see text "Yr heddlu" in the same row as "person yr ydych yn ymateb ar ei ran wedi gweithio yn y system cyfiawnder troseddol yn y 5 mlynedd diwethaf?"
	And I see text "London Police service" in the same row as "person yr ydych yn ymateb ar ei ran wedi gweithio yn y system cyfiawnder troseddol yn y 5 mlynedd diwethaf?"
	And I see text "Gwasanaeth Carchardai EM" in the same row as "person yr ydych yn ymateb ar ei ran wedi gweithio yn y system cyfiawnder troseddol yn y 5 mlynedd diwethaf?"
	And I see text "London Prison Service" in the same row as "person yr ydych yn ymateb ar ei ran wedi gweithio yn y system cyfiawnder troseddol yn y 5 mlynedd diwethaf?"
	And I see text "Yr Asiantaeth Troseddu Cenedlaethol" in the same row as "person yr ydych yn ymateb ar ei ran wedi gweithio yn y system cyfiawnder troseddol yn y 5 mlynedd diwethaf?"
	And I see text "Y Farnwriaeth" in the same row as "person yr ydych yn ymateb ar ei ran wedi gweithio yn y system cyfiawnder troseddol yn y 5 mlynedd diwethaf?"
	And I see text "Gwasanaeth Llysoedd a Thribiwnlysoedd EM" in the same row as "person yr ydych yn ymateb ar ei ran wedi gweithio yn y system cyfiawnder troseddol yn y 5 mlynedd diwethaf?"
	And I see text "Arall" in the same row as "person yr ydych yn ymateb ar ei ran wedi gweithio yn y system cyfiawnder troseddol yn y 5 mlynedd diwethaf?"
	And I see text "Other part CJS" in the same row as "person yr ydych yn ymateb ar ei ran wedi gweithio yn y system cyfiawnder troseddol yn y 5 mlynedd diwethaf?"
	
	Then I check the "wybodaeth rwyf wedi ei rhoi am yr unigolyn rwyf yn ymateb ar ei ran yn gywir." checkbox
	
	When I press the "Cyflwyno" button
	
	Then I see "Rydych wedi cwblhau'r broses ymateb" on the page
	Then I see "<juror_number>" on the page
	
Examples:
	| juror_number	| last_name	| postcode	| email 		| pool_number	|
	| 045700014		| DOE		| SW1H 9AJ	| a@eeee.com	| 457300014		|

@RegressionWelsh @NewSchemaConverted
Scenario Outline: Welsh_1st_CJS

	Given I am on the welsh version of "Public" "test"

	Given a bureau owned pool is created with jurors
		| court |juror_number  | pool_number	| att_date_weeks_in_future	| owner |
		| 452   |<juror_number>| <pool_number>	| 5				            | 400	|
	
	And juror "<juror_number>" has "LAST_NAME" as "<last_name>" new schema
	And juror "<juror_number>" has "POSTCODE" as "<postcode>" new schema

	And I set the radio button to "n ymateb dros fy hun"
	And I press the "Parhau" button
	Then I see "Eich manylion rheithiwr" on the page
	
	When I set "Rhif rheithiwr" to "<juror_number>"
	When I set "Cyfenw" to "<last_name>"
	When I set "Cod post Rheithiwr" to "<postcode>"
	And I press the "Parhau" button
	Then I see "A yw'r enw sydd gennym ar eich cyfer chi yn gywir?" on the page
	
#Juror's details
	And I set the radio button to "Ydy"
	When I press the "Parhau" button
	Then I see "Eich cyfeiriad chi yw hwn?" on the page
	
#Juror's address
	And I see "A fydd eich cyfeiriad chi yn newid yn fuan?" on the page
	And I set the radio button to "Ie"
	When I press the "Parhau" button
	Then I see "Beth yw eich rhif ffôn?" on the page
	
#Juror's phone
	And I see "Darparwch rif ffôn yn y DU y gallwn ei ddefnyddio i gysylltu â chi rhwng 9am a 5pm, dydd Llun i ddydd Gwener." on the page
	When I set "Prif rif ffôn" to "02078211818"
	And I press the "Parhau" button
	Then I see "Beth yw eich cyfeiriad e-bost?" on the page
	
#Juror's email
	When I see "Pam fod arnom angen eich cyfeiriad e-bost?" on the page
	And I set "Nodwch eich cyfeiriad e-bost" to "<email>"
	And I set "Nodwch eich cyfeiriad e-bost eto" to "<email>"
	And I press the "Parhau" button
	Then I see "Beth yw eich dyddiad geni?" on the page
	
#DoB
	And I see "Cymorth gyda'ch dyddiad geni" on the page
	When I set "Diwrnod" to "27"
	And I set "Mis" to "04"
	And I set "Blwyddyn" to "1978"
	And I press the "Parhau" button
	Then I see "Cadarnhau a ydych yn gymwys i wasanaethu ar reithgor" on the page
	
#Do you qualify for jury service?
	When I press the "Parhau" button

#Residency
	Then I see "Ers i chi droi'n 13 oed, a yw eich prif gyfeiriad wedi bod yn y DU, Ynysoedd y Sianel neu Ynys Manaw am unrhyw gyfnod o 5 mlynedd o leiaf?" on the page
	And I set the radio button to "Naddo"
	And I set the radio button to "Do"
	And I press the "Parhau" button

#CJS
	And I set the radio button to "Ydw"
	And I check the "Yr heddlu" checkbox
	And I set "Pa heddlu?" to "London Met Police Force"
	And I check the "Gwasanaeth Carchardai EM" checkbox
	And I set "Pa ran o Wasanaeth Carchardai EM?" to "Wandsworth Prison"
	And I check the "Yr Asiantaeth Troseddu Cenedlaethol" checkbox
	And I check the "Y Farnwriaeth" checkbox
	And I check the "Gwasanaeth Llysoedd a Thribiwnlysoedd EM" checkbox
	And I check the "Arall" checkbox
	And I set "Pa ran arall o’r System Cyfiawnder Troseddol?" to "Another part of the CJS"
	And I press the "Parhau" button

#Bail (Yes and no will be tested)
	And I set the radio button to "Ydw"
	And I see "Nac ydw" on the page
	And I set "Rhowch fanylion" to "I am on bail for crimes"
	And I press the "Parhau" button
	
#Convictions
	And I set the radio button to "Naddo"
	And I press the "Parhau" button
		
#Mental health sectioned
	And I set the radio button to "Ie"
	And I set "Eglurwch sut yr ydych yn cael eich cadw dan glo, sut ofal ydych yn ei gael neu sut yr ydych yn cael eich trin o dan y Ddeddf Iechyd Meddwl" to "I am sectioned"
	And I press the "Parhau" button
	
#Mental health capacity
	And I set the radio button to "Ie"
	And I set "Eglurwch yn gryno pam y penderfynwyd nad oes gennych alluedd meddyliol" to "I lack capacity"
	And I press the "Parhau" button
	
#Can you attend
	And I set the radio button to "Ydw, rydw i'n gallu dechrau"
	And I press the "Parhau" button
	
#Special Requirements
	And I set the radio button to "Nac oes"
	When I press the "Parhau" button
	
#Check your answers page
	And I see text "Ydw" in the same row as "A ydych chi wedi gweithio yn y system cyfiawnder troseddol yn y 5 mlynedd diwethaf?"
	And I see text "Yr heddlu" in the same row as "A ydych chi wedi gweithio yn y system cyfiawnder troseddol yn y 5 mlynedd diwethaf?"
	And I see text "London Met Police Force" in the same row as "A ydych chi wedi gweithio yn y system cyfiawnder troseddol yn y 5 mlynedd diwethaf?"
	And I see text "Gwasanaeth Carchardai EM" in the same row as "A ydych chi wedi gweithio yn y system cyfiawnder troseddol yn y 5 mlynedd diwethaf?"
	And I see text "Wandsworth Prison" in the same row as "A ydych chi wedi gweithio yn y system cyfiawnder troseddol yn y 5 mlynedd diwethaf?"
	And I see text "Yr Asiantaeth Troseddu Cenedlaethol" in the same row as "A ydych chi wedi gweithio yn y system cyfiawnder troseddol yn y 5 mlynedd diwethaf?"
	And I see text "Y Farnwriaeth" in the same row as "A ydych chi wedi gweithio yn y system cyfiawnder troseddol yn y 5 mlynedd diwethaf?"
	And I see text "Gwasanaeth Llysoedd a Thribiwnlysoedd EM" in the same row as "A ydych chi wedi gweithio yn y system cyfiawnder troseddol yn y 5 mlynedd diwethaf?"
	And I see text "Arall" in the same row as "A ydych chi wedi gweithio yn y system cyfiawnder troseddol yn y 5 mlynedd diwethaf?"
	And I see text "Another part of the CJS" in the same row as "A ydych chi wedi gweithio yn y system cyfiawnder troseddol yn y 5 mlynedd diwethaf?"
	
	Then I check the "Mae'r wybodaeth a roddais uchod yn wir hyd eithaf fy ngwybodaeth." checkbox
	When I press the "Cyflwyno" button
	
	Then I see "Rydych wedi cwblhau'r broses ymateb" on the page
	Then I see "<juror_number>" on the page
	
Examples:
	| juror_number	| last_name	| postcode	| email 		| pool_number	|
	| 045700015		| DOE		| SW1H 9AJ	| a@eeee.com	| 457300015		|

@Regression @NewSchemaConverted
Scenario Outline: English_3rd party_CJS

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
	When I see "Your Details" on the page

	When I set "How do you know the person you're replying for?" to "Friend"
	And I press the "Continue" button
	Then I see "Your contact information" on the page
	
	#3rd Party Contact
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
	When I set the radio button to "Yes"
	And I press the "Continue" button
	
	#Check juror address
	Then I see "Is this their address?" on the page
	When I set the radio button to "Yes"
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
	And I set the radio button to "Yes"
	And I press the "Continue" button
	
	#CJS Emp
	And I set the radio button to "Yes"
	And I check the "Police service" checkbox
	And I set "Which police service?" to "London Met Police Force"
	And I check the "HM Prison Service" checkbox
	And I set "Which part of HM Prison Service" to "Wandsworth Prison"
	And I check the "the National Crime Agency" checkbox
	And I check the "the Judiciary" checkbox
	And I check the "HM Courts & Tribunal Service" checkbox
	And I check the "Other" checkbox
	And I set "Which other part of the Criminal Justice System?" to "Another part of the CJS"
	And I press the "Continue" button
	
	And I set the radio button to "No"
	And I press the "Continue" button
	And I set the radio button to "No"
	And I press the "Continue" button
	And I set the radio button to "No"
	And I press the "Continue" button
	And I set the radio button to "No"
	And I press the "Continue" button
	
	Then I set the radio button to "Yes, they can start on"
	And I press the "Continue" button

	#Help in court
	And I set the radio button to "No"
	And I press the "Continue" button

	#Check your answers
	And I see text "Yes" in the same row as "Have you worked in the criminal justice system in the last 5 years?"
	And I see text "Police service" in the same row as "Have you worked in the criminal justice system in the last 5 years?"
	And I see text "London Met Police Force" in the same row as "Have you worked in the criminal justice system in the last 5 years?"
	And I see text "HM Prison Service" in the same row as "Have you worked in the criminal justice system in the last 5 years?"
	And I see text "Wandsworth Prison" in the same row as "Have you worked in the criminal justice system in the last 5 years?"
	And I see text "the National Crime Agency" in the same row as "Have you worked in the criminal justice system in the last 5 years?"
	And I see text "the Judiciary" in the same row as "Have you worked in the criminal justice system in the last 5 years?"
	And I see text "HM Courts & Tribunal Service" in the same row as "Have you worked in the criminal justice system in the last 5 years?"
	And I see text "Other" in the same row as "Have you worked in the criminal justice system in the last 5 years?"
	And I see text "Another part of the CJS" in the same row as "Have you worked in the criminal justice system in the last 5 years?"

	Then I check the "The answers I have given for the person I'm replying for are true as far as I know." checkbox

	When I press the "Submit" button
	
	#JDB-3031
	#JDB-3704
	Then I see "You have completed your reply" on the page
	Then I see "If we get in touch with them, they may need to give their juror number. It's also on the letter we sent them." on the page
	Then I see "We have sent an email to say you have replied to this jury summons." on the page
	Then I see "Download a copy of your summons reply" on the page
	And I see "a letter confirming the date of their jury service" on the page
	And I see "an information pack about being a juror and the court they're going to" on the page
	And I see "Getting ready for jury service" on the page
	And I see "The information below is also in the email that we have sent." on the page
	And I see "You or the person you've replied for, can watch this video on YouTube about what happens when you're a juror, so they know what to expect. The video takes 13 minutes to watch." on the page
	And I see "Learn more about jury service. You can read the rules about discussing the trial and find out how to claim expenses." on the page
	And I do not see "Your Guide to Jury Service (PDF 85KB)" on the page
	And I see "What did you think of this service? (Takes 30 seconds)" on the page
	
Examples:
	| juror_number 	| last_name	| postcode	| email           	| pool_number	|
	| 045200120		| DOE		| SW1H 9AJ	| email@outlook.com	| 452300119		|

@Regression @NewSchemaConverted
Scenario Outline: English_1st Party_CJS_A
	
	Given I am on "Public" "test"

	Given a bureau owned pool is created with jurors
		| court |juror_number  | pool_number	| att_date_weeks_in_future	| owner |
		| 452   |<juror_number>| <pool_number>	| 5				            | 400	|
		
	And juror "<juror_number>" has "LAST_NAME" as "<last_name>" new schema
	And juror "<juror_number>" has "POSTCODE" as "<postcode>" new schema

	And I set the radio button to "I am replying for myself"

	And I press the "Continue" button
	
	When I set "9-digit juror number" to "<juror_number>"
	And I set "Juror last name" to "<last_name>"
	And I set "Juror postcode" to "<postcode>"
	And I press the "Continue" button

	And I set the radio button to "Yes"
	
	And I press the "Continue" button

	And I set the radio button to "Yes"
	
	When I press the "Continue" button

	When I set "Main phone" to "02078211818"
	And I press the "Continue" button
	
	When I set "Enter your email address" to "<email>"

	When I set "Enter your email address again" to "<email>"

	And I press the "Continue" button

	When I set "Day" to "01"
	And I set "Month" to "01"
	And I set "Year" to "1990"
	And I press the "Continue" button

	#Qualify for jury service
	When I press the "Continue" button

	#Residency
	And I set the radio button to "Yes"
	And I press the "Continue" button
	
	#CJS Emp
	Then I see "Have you worked in the criminal justice system in the last 5 years?" on the page
	And I set the radio button to "Yes"
	And I check the "Police service" checkbox
	And I set "Which police service?" to "London Met Police Force"
	And I check the "HM Prison Service" checkbox
	And I set "Which part of HM Prison Service" to "Wandsworth Prison"
	And I check the "the National Crime Agency" checkbox
	And I check the "the Judiciary" checkbox
	And I check the "HM Courts & Tribunal Service" checkbox
	And I check the "Other" checkbox
	And I set "Which other part of the Criminal Justice System?" to "Another part of the CJS"
	And I press the "Continue" button
	
	#Bail
	And I set the radio button to "No"
	And I press the "Continue" button
	
	#Convictions
	When I set the radio button to "No"
	And I press the "Continue" button
	
	#Mental Health Sectioned
	And I set the radio button to "No"
	And I press the "Continue" button
	
	#Mental Health Capacity
	And I set the radio button to "No"
	And I press the "Continue" button
	
	#I can attend
	And I see "Yes, I can start on" on the page
	And I set the radio button to "Yes, I can start on"
	And  I press the "Continue" button

	#Help in court
	And I set the radio button to "No"
	And I press the "Continue" button

	#Check your answers
	And I see text "Yes" in the same row as "Have you worked in the criminal justice system in the last 5 years?"
	And I see text "Police service" in the same row as "Have you worked in the criminal justice system in the last 5 years?"
	And I see text "London Met Police Force" in the same row as "Have you worked in the criminal justice system in the last 5 years?"
	And I see text "HM Prison Service" in the same row as "Have you worked in the criminal justice system in the last 5 years?"
	And I see text "Wandsworth Prison" in the same row as "Have you worked in the criminal justice system in the last 5 years?"
	And I see text "the National Crime Agency" in the same row as "Have you worked in the criminal justice system in the last 5 years?"
	And I see text "the Judiciary" in the same row as "Have you worked in the criminal justice system in the last 5 years?"
	And I see text "HM Courts & Tribunal Service" in the same row as "Have you worked in the criminal justice system in the last 5 years?"
	And I see text "Other" in the same row as "Have you worked in the criminal justice system in the last 5 years?"
	And I see text "Another part of the CJS" in the same row as "Have you worked in the criminal justice system in the last 5 years?"
	
	And I check the "The information I have given is true to the best of my knowledge" checkbox
	And I press the "Submit" button
	Then I see "We have sent you an email to say you have replied to your jury summons." on the page

	Given I am on "Bureau" "test"
	And I log in as "MODTESTBUREAU"

	When I click on the "Search" link
	And I set "Juror number" to "<juror_number>"
	And I press the "Search" button
	And I click on "<juror_number>" in the same row as "<juror_number>"
	
	Then I click on the "CJS employment" link
	Then I see "Police Force" on the page
	And I see "London Met Police Force" on the page
	And I see "HM Prison Service" on the page
	And I see "Wandsworth Prison" on the page
	And I see "National Crime Agency" on the page
	And I see "Judiciary" on the page
	And I see "HMCTS" on the page
	And I see "Other" on the page
	And I see "Another part of the CJS" on the page
	
	#taken out edit functions on bureau
	
#	Then I click on the "Change" link
#	And I see "CJS employment" on the page
#	And the radio button "Yes" is "selected"
#	And "Police Force" is checked
#	And I see "London Met Police Force" on the page
#	And "HM Prison Service" is checked
#	And I see "Wandsworth Prison" on the page
#	And "the National Crime Agency" is checked
#	And "the Judiciary" is checked
#	And "HMCTS" is checked
#	And "Other" is unchecked
#	And I see "Another part of the CJS" on the page
#	
#	And I set the radio button to "No" under "CJS Employment"
#	And I do not see "London Met Police Force" on the page
#	And I do not see "Wandsworth Prison" on the page
#	And I do not see "Another part of the CJS" on the page
#	
#	And I set the radio button to "Yes" under "CJS Employment"
#	And I see "CJS Employment" on the page
#	And the radio button "Yes" is "selected"
#	And "Police Force" is checked
#	And I see "London Met Police Force" on the page
#	And "HM Prison Service" is checked
#	And I see "Wandsworth Prison" on the page
#	And "the National Crime Agency" is checked
#	And "the Judiciary" is checked
#	And "HMCTS" is checked
##	And "Other" is checked
#	And I see "Another part of the CJS" on the page
#	
#	And I click link with ID "cjsEmploymentSaveButton"
#	And I see "Please give a reason for the change to this summons reply" on the page
#	And I set "Please give a reason for the change to this summons reply" to "CJSEmployeeChangeNotes"
#
#	And I click link with ID "changeLogSaveButton"
#	Then I see "Police Force" on the page
#	And I see "London Met Police Force" on the page
#	And I see "HM Prison Service" on the page
#	And I see "Wandsworth Prison" on the page
#	And I see "National Crime Agency" on the page
#	And I see "Judiciary" on the page
#	And I see "HMCTS" on the page
#	And I see "Other" on the page
#	And I see "Another part of the CJS" on the page
	
	When I select "Responded" from Process reply
	And I check the "Mark juror as 'responded'" checkbox
	And I press the "Confirm" button
	Then I see "COMPLETED" on the page
	And I see "Responded" on the page
	
Examples:
	| juror_number	| last_name	| postcode	| email 	| pool_number	|
	| 045200121		| DOE		| SW1H 9AJ	| a@eeee.com| 452300120		|

@Regression @NewSchemaConverted
Scenario Outline: English_1st Party_CJS
	
	Given I am on "Public" "test"

	Given a bureau owned pool is created with jurors
		| court |juror_number  | pool_number	| att_date_weeks_in_future	| owner |
		| 452   |<juror_number>| <pool_number>	| 5				            | 400	|
		
	And juror "<juror_number>" has "LAST_NAME" as "<last_name>" new schema
	And juror "<juror_number>" has "POSTCODE" as "<postcode>" new schema

	And I set the radio button to "I am replying for myself"

	And I press the "Continue" button
	
	When I set "9-digit juror number" to "<juror_number>"
	And I set "Juror last name" to "<last_name>"
	And I set "Juror postcode" to "<postcode>"
	And I press the "Continue" button

	And I set the radio button to "Yes"
	
	And I press the "Continue" button

	And I set the radio button to "Yes"
	
	When I press the "Continue" button

	When I set "Main phone" to "02078211818"
	And I press the "Continue" button
	
	When I set "Enter your email address" to "<email>"

	When I set "Enter your email address again" to "<email>"

	And I press the "Continue" button

	When I set "Day" to "01"
	And I set "Month" to "01"
	And I set "Year" to "1990"
	And I press the "Continue" button

	#Qualify for jury service
	When I press the "Continue" button

	#Residency
	And I set the radio button to "Yes"
	And I press the "Continue" button
	
	#CJS Emp
	Then I see "Have you worked in the criminal justice system in the last 5 years?" on the page
	And I set the radio button to "Yes"
	And I check the "Police service" checkbox
	And I set "Which police service?" to "London Met Police Force"
	And I check the "HM Prison Service" checkbox
	And I set "Which part of HM Prison Service" to "Wandsworth Prison"
	And I check the "the National Crime Agency" checkbox
	And I check the "the Judiciary" checkbox
	And I check the "HM Courts & Tribunal Service" checkbox
	And I check the "Other" checkbox
	And I set "Which other part of the Criminal Justice System?" to "Another part of the CJS"
	And I press the "Continue" button
	
	#Bail
	And I set the radio button to "No"
	And I press the "Continue" button
	
	#Convictions
	When I set the radio button to "No"
	And I press the "Continue" button
	
	#Mental Health Sectioned
	And I set the radio button to "No"
	And I press the "Continue" button
	
	#Mental Health Capacity
	And I set the radio button to "No"
	And I press the "Continue" button
	
	#I can attend
	And I see "Yes, I can start on" on the page
	And I set the radio button to "Yes, I can start on"
	And  I press the "Continue" button

	#Help in court
	And I set the radio button to "No"
	And I press the "Continue" button

	#Check your answers
	And I see text "Yes" in the same row as "Have you worked in the criminal justice system in the last 5 years?"
	And I see text "Police service" in the same row as "Have you worked in the criminal justice system in the last 5 years?"
	And I see text "London Met Police Force" in the same row as "Have you worked in the criminal justice system in the last 5 years?"
	And I see text "HM Prison Service" in the same row as "Have you worked in the criminal justice system in the last 5 years?"
	And I see text "Wandsworth Prison" in the same row as "Have you worked in the criminal justice system in the last 5 years?"
	And I see text "the National Crime Agency" in the same row as "Have you worked in the criminal justice system in the last 5 years?"
	And I see text "the Judiciary" in the same row as "Have you worked in the criminal justice system in the last 5 years?"
	And I see text "HM Courts & Tribunal Service" in the same row as "Have you worked in the criminal justice system in the last 5 years?"
	And I see text "Other" in the same row as "Have you worked in the criminal justice system in the last 5 years?"
	And I see text "Another part of the CJS" in the same row as "Have you worked in the criminal justice system in the last 5 years?"
	
	And I check the "The information I have given is true to the best of my knowledge" checkbox
	And I press the "Submit" button
	Then I see "We have sent you an email to say you have replied to your jury summons." on the page
	
Examples:
	| juror_number	| last_name	| postcode	| email 		| pool_number	|
	| 045200122		| DOE		| SW1H 9AJ	| a@eeee.com	| 452300121		|

@Regression @NewSchemaConverted
Scenario Outline: English_1st Party_CJS_Change Selection
	
	Given I am on "Public" "test"

	Given a bureau owned pool is created with jurors
		| court |juror_number  | pool_number	| att_date_weeks_in_future	| owner |
		| 452   |<juror_number>| <pool_number>	| 5				            | 400	|
		
	And juror "<juror_number>" has "LAST_NAME" as "<last_name>" new schema
	And juror "<juror_number>" has "POSTCODE" as "<postcode>" new schema

	And I set the radio button to "I am replying for myself"

	And I press the "Continue" button
	
	When I set "9-digit juror number" to "<juror_number>"
	And I set "Juror last name" to "<last_name>"
	And I set "Juror postcode" to "<postcode>"
	And I press the "Continue" button

	And I set the radio button to "Yes"
	
	And I press the "Continue" button

	And I set the radio button to "Yes"
	
	When I press the "Continue" button

	When I set "Main phone" to "02078211818"
	And I press the "Continue" button
	
	When I set "Enter your email address" to "e@mail.com"

	When I set "Enter your email address again" to "e@mail.com"

	And I press the "Continue" button

	When I set "Day" to "01"
	And I set "Month" to "01"
	And I set "Year" to "1990"
	And I press the "Continue" button

	#Qualify for jury service
	When I press the "Continue" button

	#Residency
	And I set the radio button to "Yes"
	And I press the "Continue" button
	
	#CJS Emp No
	Then I see "Have you worked in the criminal justice system in the last 5 years?" on the page
	And I set the radio button to "No"
	And  I press the "Continue" button
	
	And I click on the "Back" link

	Then the radio button "No" is "selected"
	And I do not see "the Judiciary" on the page
	And I do not see "HM Courts & Tribunal Service" on the page
	
	And I set the radio button to "Yes"
	And I check the "Police service" checkbox
	And I set "Which police service?" to "London Met Police Force"
	And I check the "HM Prison Service" checkbox
	And I set "Which part of HM Prison Service" to "Wandsworth Prison"
	And I check the "the National Crime Agency" checkbox
	And I check the "the Judiciary" checkbox
	And I check the "HM Courts & Tribunal Service" checkbox
	And I check the "Other" checkbox
	And I set "Which other part of the Criminal Justice System?" to "Another part of the CJS"
	
	Then I set the radio button to "No"
	And I do not see "the Judiciary" on the page
	And I do not see "HM Courts & Tribunal Service" on the page
	
	Then I set the radio button to "Yes"
	Then the radio button "Yes" is "selected"
	And "Police service" is checked
	And "Which police service?" is "London Met Police Force"
	And "HM Prison Service" is checked
	And "Which part of HM Prison Service" is "Wandsworth Prison"
	And "the National Crime Agency" is checked
	And "the Judiciary" is checked
	And "HM Courts & Tribunal Service" is checked
	And "Other" is checked
	And "Which other part of the Criminal Justice System?" is "Another part of the CJS"
	
	And I press the "Continue" button
	
	#Bail
	And I set the radio button to "No"
	And I press the "Continue" button
	
	#Convictions
	When I set the radio button to "No"
	And I press the "Continue" button
	
	#Mental Health Sectioned
	And I set the radio button to "No"
	And I press the "Continue" button
	
	#Mental Health Capacity
	And I set the radio button to "No"
	And I press the "Continue" button
	
	#I can attend
	And I see "Yes, I can start on" on the page
	And I set the radio button to "Yes, I can start on"
	And  I press the "Continue" button
	
	#Help in court
	And I set the radio button to "No"
	And I press the "Continue" button

	#Check your answers
	And I see text "Yes" in the same row as "Have you worked in the criminal justice system in the last 5 years?"
	And I see text "Police service" in the same row as "Have you worked in the criminal justice system in the last 5 years?"
	And I see text "London Met Police Force" in the same row as "Have you worked in the criminal justice system in the last 5 years?"
	And I see text "HM Prison Service" in the same row as "Have you worked in the criminal justice system in the last 5 years?"
	And I see text "Wandsworth Prison" in the same row as "Have you worked in the criminal justice system in the last 5 years?"
	And I see text "the National Crime Agency" in the same row as "Have you worked in the criminal justice system in the last 5 years?"
	And I see text "the Judiciary" in the same row as "Have you worked in the criminal justice system in the last 5 years?"
	And I see text "HM Courts & Tribunal Service" in the same row as "Have you worked in the criminal justice system in the last 5 years?"
	And I see text "Other" in the same row as "Have you worked in the criminal justice system in the last 5 years?"
	And I see text "Another part of the CJS" in the same row as "Have you worked in the criminal justice system in the last 5 years?"
	
	#change CJS answers
	When I click on the "Change" link in the same row as "Have you worked in the criminal justice system in the last 5 years?"
	Then the radio button "Yes" is "selected"
	And "Police service" is checked
	And "Which police service?" is "London Met Police Force"
	And "HM Prison Service" is checked
	And "Which part of HM Prison Service" is "Wandsworth Prison"
	And "the National Crime Agency" is checked
	And "the Judiciary" is checked
	And "HM Courts & Tribunal Service" is checked
	And "Other" is checked
	And "Which other part of the Criminal Justice System?" is "Another part of the CJS"
	
	And I set the radio button to "No"
	And I press the "Continue" button

	#Check your answers
	And I see text "No" in the same row as "Have you worked in the criminal justice system in the last 5 years?"

	And I check the "The information I have given is true to the best of my knowledge" checkbox
	And I press the "Submit" button
	Then I see "We have sent you an email to say you have replied to your jury summons." on the page
	
Examples:
	| juror_number	| last_name	| postcode	| email 	| pool_number	|
	| 045200123		| DOE		| SW1H 9AJ	| a@eeee.com| 452300122		|

@Regression @NewSchemaConverted
Scenario Outline: English_1st Party_CJS_Errors
	
	Given I am on "Public" "test"

	Given a bureau owned pool is created with jurors
		| court |juror_number  | pool_number	| att_date_weeks_in_future	| owner |
		| 452   |<juror_number>| <pool_number>	| 5				            | 400	|
		
	And juror "<juror_number>" has "LAST_NAME" as "<last_name>" new schema
	And juror "<juror_number>" has "POSTCODE" as "<postcode>" new schema

	And I set the radio button to "I am replying for myself"

	And I press the "Continue" button
	
	When I set "9-digit juror number" to "<juror_number>"
	And I set "Juror last name" to "<last_name>"
	And I set "Juror postcode" to "<postcode>"
	And I press the "Continue" button

	And I set the radio button to "Yes"
	
	And I press the "Continue" button

	And I set the radio button to "Yes"
	
	When I press the "Continue" button

	When I set "Main phone" to "02078211818"
	And I press the "Continue" button
	
	When I set "Enter your email address" to "<email>"

	When I set "Enter your email address again" to "<email>"

	And I press the "Continue" button

	When I set "Day" to "01"
	And I set "Month" to "01"
	And I set "Year" to "1990"
	And I press the "Continue" button

	#Qualify for jury service
	When I press the "Continue" button

	#Residency
	And I set the radio button to "Yes"
	And I press the "Continue" button
	
	#CJS Emp no selection errors
	Then I see "Have you worked in the criminal justice system in the last 5 years?" on the page
	And I press the "Continue" button
	And I see "There is a problem" on the page
	And I see "Select whether you've worked in the criminal justice system in the last 5 years" on the page
	
	#CJS Emp Yes but so selection errors
	And I set the radio button to "Yes"
	And I press the "Continue" button
	And I see "There is a problem" on the page
	And I see "Tick any organisations you worked for directly (not as a third party or subcontractor)" on the page
	
	And I check the "Police service" checkbox
	And I check the "HM Prison Service" checkbox
	And I check the "the National Crime Agency" checkbox
	And I check the "the Judiciary" checkbox
	And I check the "HM Courts & Tribunal Service" checkbox
	And I check the "Other" checkbox
	
	#CJS Emp selction but no description errors
	And I press the "Continue" button
	And I see "There is a problem" on the page
	And I see "Give details of where and when you have worked for the police service" on the page
	And I see "Give details of where and when you have worked for HM Prison Service" on the page
	And I see "Give details of where and when you have worked for another Criminal Justice System employer" on the page
	
	And I set "Which police service?" to "London Met Police Force"
	And I set "Which part of HM Prison Service" to "Wandsworth Prison"
	And I set "Which other part of the Criminal Justice System?" to "Another part of the CJS"
	
	And I press the "Continue" button
	Then I click on the "Back" link
	
	#De-select
	And I uncheck the "Police service" checkbox
	Then I do not see "Which police service?" on the page
	And I uncheck the "HM Prison Service" checkbox
	Then I do not see "Which part of HM Prison Service" on the page
	And I uncheck the "the National Crime Agency" checkbox
	And I uncheck the "the Judiciary" checkbox
	And I uncheck the "HM Courts & Tribunal Service" checkbox
	And I uncheck the "Other" checkbox
	Then I do not see "Which other part of the Criminal Justice System?" on the page
	
	#errors
	And I press the "Continue" button
	And I see "There is a problem" on the page
	And I see "Tick any organisations you worked for directly (not as a third party or subcontractor)" on the page
	
	Then I set the radio button to "No"
	And I do not see "the Judiciary" on the page
	And I do not see "HM Courts & Tribunal Service" on the page
	
	And I press the "Continue" button
	
	#Bail
	And I set the radio button to "No"
	And I press the "Continue" button
	
	#Convictions
	When I set the radio button to "No"
	And I press the "Continue" button
	
	#Mental Health Sectioned
	And I set the radio button to "No"
	And I press the "Continue" button
	
	#Mental Health Capacity
	And I set the radio button to "No"
	And I press the "Continue" button
	
	#I can attend
	And I see "Yes, I can start on" on the page
	And I set the radio button to "Yes, I can start on"
	And I press the "Continue" button
	
	#Help in court
	And I set the radio button to "No"
	And I press the "Continue" button

	#Check your answers
	And I see text "No" in the same row as "Have you worked in the criminal justice system in the last 5 years?"
	
	And I check the "The information I have given is true to the best of my knowledge" checkbox
	And I press the "Submit" button
	Then I see "We have sent you an email to say you have replied to your jury summons." on the page
	
Examples:
	| juror_number	| last_name	| postcode	| email 		| pool_number	|
	| 045200124		| DOE		| SW1H 9AJ	| a@eeee.com	| 452300123		|

@RegressionWelsh @NewSchemaConverted
Scenario Outline: Welsh_1st_CJS_Errors

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
	Then I see "A yw'r enw sydd gennym ar eich cyfer chi yn gywir?" on the page
	
#Juror's details
	And I set the radio button to "Ydy"
	When I press the "Parhau" button
	Then I see "Eich cyfeiriad chi yw hwn?" on the page
	
#Juror's address
	And I see "A fydd eich cyfeiriad chi yn newid yn fuan?" on the page
	And I set the radio button to "Ie"
	When I press the "Parhau" button
	Then I see "Beth yw eich rhif ffôn?" on the page
	
#Juror's phone
	And I see "Darparwch rif ffôn yn y DU y gallwn ei ddefnyddio i gysylltu â chi rhwng 9am a 5pm, dydd Llun i ddydd Gwener." on the page
	When I set "Prif rif ffôn" to "02078211818"
	And I press the "Parhau" button
	Then I see "Beth yw eich cyfeiriad e-bost?" on the page
	
#Juror's email
	When I see "Pam fod arnom angen eich cyfeiriad e-bost?" on the page
	And I set "Nodwch eich cyfeiriad e-bost" to "<email>"
	And I set "Nodwch eich cyfeiriad e-bost eto" to "<email>"
	And I press the "Parhau" button
	Then I see "Beth yw eich dyddiad geni?" on the page
	
#DoB
	And I see "Cymorth gyda'ch dyddiad geni" on the page
	When I set "Diwrnod" to "27"
	And I set "Mis" to "04"
	And I set "Blwyddyn" to "1978"
	And I press the "Parhau" button
	Then I see "Cadarnhau a ydych yn gymwys i wasanaethu ar reithgor" on the page
	
#Do you qualify for jury service?
	When I press the "Parhau" button
	Then I see "Ers i chi droi'n 13 oed, a yw eich prif gyfeiriad wedi bod yn y DU, Ynysoedd y Sianel neu Ynys Manaw am unrhyw gyfnod o 5 mlynedd o leiaf?" on the page

#Residency
	And I set the radio button to "Naddo"
	And I set the radio button to "Do"
	And I press the "Parhau" button

#CJS
#CJS Emp no selection errors
	And I press the "Parhau" button
	And I see "Mae problem" on the page
	And I see "Dewiswch a ydych wedi gweithio yn y system cyfiawnder troseddol yn ystod y 5 mlynedd diwethaf" on the page

#CJS Emp Yes but so selection errors
	And I set the radio button to "Ydw"
	And I press the "Parhau" button
	And I see "Mae problem" on the page
	And I see "Ticiwch unrhyw sefydliadau rydych wedi gweithio iddynt yn uniongyrchol (nid fel trydydd parti neu is-gontractwr)" on the page
	
	And I check the "Yr heddlu" checkbox
	And I check the "Gwasanaeth Carchardai EM" checkbox
	And I check the "Yr Asiantaeth Troseddu Cenedlaethol" checkbox
	And I check the "Y Farnwriaeth" checkbox
	And I check the "Gwasanaeth Llysoedd a Thribiwnlysoedd EM" checkbox
	And I check the "Arall" checkbox
	
	#CJS Emp selction but no description errors
	And I press the "Parhau" button

	And I see "Mae problem" on the page
	
	And I see "Rhowch fanylion am ble a phryd roeddech yn gweithio i'r Heddlu" on the page
	And I see "Rhowch fanylion am ble a phryd roeddech yn gweithio i Wasanaeth Carchardai EM" on the page
	And I see "Rhowch fanylion am pryd a lle rydych wedi gweithio mewn rhan arall o'r system cyfiawnder troseddol" on the page   
	And I set "Pa heddlu?" to "London Met Police Force"
	And I set "Pa ran o Wasanaeth Carchardai EM?" to "Wandsworth Prison"
	And I set "Pa ran arall o’r System Cyfiawnder Troseddol?" to "Another part of the CJS"
	
	And I press the "Parhau" button
	Then I click on the "Cliciwch i fynd yn ôl" link

	#De-select
	And I uncheck the "Yr heddlu" checkbox
	Then I do not see "Pa heddlu?" on the page
	And I uncheck the "Gwasanaeth Carchardai EM" checkbox
	Then I do not see "Pa ran o Wasanaeth Carchardai EM?" on the page
	And I uncheck the "Yr Asiantaeth Troseddu Cenedlaethol" checkbox
	And I uncheck the "Y Farnwriaeth" checkbox
	And I uncheck the "Gwasanaeth Llysoedd a Thribiwnlysoedd EM" checkbox
	And I uncheck the "Arall" checkbox
	Then I do not see "Pa ran arall o’r System Cyfiawnder Troseddol?" on the page
	
	#errors
	And I press the "Parhau" button
	And I see "Mae problem" on the page
	And I see "Ticiwch unrhyw sefydliadau rydych wedi gweithio iddynt yn uniongyrchol (nid fel trydydd parti neu is-gontractwr)" on the page
	
	Then I set the radio button to "Nac ydw"
	And I do not see "Y Farnwriaeth" on the page
	And I do not see "Gwasanaeth Llysoedd a Thribiwnlysoedd EM" on the page
	
	And I press the "Parhau" button

#Bail
	And I set the radio button to "Ydw"
	And I see "Nac ydw" on the page
	And I set "Rhowch fanylion" to "I am on bail for crimes"
	And I press the "Parhau" button
	
#Convictions
	And I set the radio button to "Naddo"
	And I press the "Parhau" button
	
#Mental health sectioned
	And I set the radio button to "Ie"
	And I set "Eglurwch sut yr ydych yn cael eich cadw dan glo, sut ofal ydych yn ei gael neu sut yr ydych yn cael eich trin o dan y Ddeddf Iechyd Meddwl" to "I am sectioned"
	And I press the "Parhau" button
	
#Mental health capacity
	And I set the radio button to "Ie"
	And I set "Eglurwch yn gryno pam y penderfynwyd nad oes gennych alluedd meddyliol" to "I lack capacity"
	And I press the "Parhau" button
	
#Can you attend
	And I set the radio button to "Ydw, rydw i'n gallu dechrau"
	And I press the "Parhau" button
	
#Special Requirements
	And I set the radio button to "Nac oes"
	When I press the "Parhau" button
	
#Check your answers page
	And I see text "Nac ydw" in the same row as "A ydych chi wedi gweithio yn y system cyfiawnder troseddol yn y 5 mlynedd diwethaf?"

	Then I check the "Mae'r wybodaeth a roddais uchod yn wir hyd eithaf fy ngwybodaeth." checkbox
	When I press the "Cyflwyno" button
	
	Then I see "Rydych wedi cwblhau'r broses ymateb" on the page
	Then I see "<juror_number>" on the page
	
Examples:
	| juror_number	| last_name	|  postcode	| email 		| pool_number	|
	| 045700016		| DOE		| SW1H 9AJ	| a@eeee.com	| 457300016		|