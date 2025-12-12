Feature: RA_CharCounters_AllPaths

@Regression
Scenario Outline: English 1st RA Char Counter

	Given I am on "Public" "ithc"

	Given a bureau owned pool is created with jurors
		| court |juror_number  | pool_number	| att_date_weeks_in_future	| owner |
		| 452   |<juror_number>| <pool_number>	| 5				            | 400	|
		
	And juror "<juror_number>" has "LAST_NAME" as "<last_name>" new schema
	And juror "<juror_number>" has "POSTCODE" as "<postcode>" new schema
	
	Then I see "Reply to a jury summons" on the page
	
	Then I see "Are you replying for yourself or for someone else?" on the page
	
	When I set the radio button to "I am replying for myself"
	And I press the "Continue" button
	Then I see "Your juror details" on the page
	
	#Juror Log In
	When I set "9-digit juror number" to "<juror_number>"
	When I set "Juror last name" to "<last_name>"
	When I set "Juror postcode" to "<postcode>"
	And I press the "Continue" button
	Then I see "Is the name we have for you correct?" on the page
	When I choose the "Yes" radio button
	
	#Check name
	When I press the "Continue" button
	Then I see "Is this your address?" on the page
	When I choose the "Yes" radio button
	
	#Check address
	When I press the "Continue" button
	Then I see "What is your phone number?" on the page
	
	#Phone details
	When I set "Main phone" to "0207 821 1818"
	And I press the "Continue" button
	Then I see "What is your email address?" on the page
	
	#Email details
	When I set "Enter your email address" to "email@outlook.com"
	And I set "Enter your email address again" to "email@outlook.com"
	And I press the "Continue" button
	Then I see "What is your date of birth?" on the page
	
	#DoB
	When I set "Day" to "27"
	And I set "Month" to "04"
	And I set "Year" to "1981"
	And I press the "Continue" button
	
	Then I see "Confirm you're eligible for jury service" on the page
	
	When I press the "Continue" button
	
	#Residency Yes
	Then I see "Since you turned 13, has your main address been in the UK, Channel Islands or Isle of Man for any period of at least 5 years?" on the page
	When I choose the "Yes" radio button
	And I press the "Continue" button
	
	#CJS no
	Then I see "Have you worked in the criminal justice system in the last 5 years?" on the page
	When I choose the "No" radio button
	And I press the "Continue" button
	
	#Bail no
	Then I see "Are you currently on bail for a criminal offence?" on the page
	When I choose the "No" radio button
	And I press the "Continue" button
	
	#Convictions no
	Then I see "Have you been found guilty of a criminal offence?" on the page
	When I choose the "No" radio button
	And I press the "Continue" button
	
	#Mental health part 1 no
	Then I see "Are you being detained, looked after or treated under the Mental Health Act?" on the page
	When I choose the "No" radio button
	And I press the "Continue" button
	
	#Mental health part 2 no
	Then I see "Has it been decided that you 'lack mental capacity'?" on the page
	When I choose the "No" radio button
	And I press the "Continue" button
	
	#I can attend
	Then I see "Check your start date" on the page
	And I see "Yes, I can start on" on the page
	And I set the radio button to "Yes, I can start on"
	And  I press the "Continue" button
	
	#RA no
	Then I see "Will you need help when you're at the court?" on the page
	When I choose the "Yes" radio button

	When I check the "Other" checkbox
	And I set "Provide details" to "Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful te"
	
	And I press the "Continue" button
	Then I see "Check your answers now" on the page
	
	#Check Your Answers
#	When I see text "Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful te" in the same row as "Do you have a disability or impairment that means you'll need extra support or facilities in the court building where you are doing your Jury Service?"
#	And I see text "Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful te" in the same row as "Please tell us about any special arrangements or help you need while you're doing jury service"
	
	When I check the "The information I have given is true to the best of my knowledge" checkbox
	And I press the "Submit" button
	Then I see "We have sent you an email to say you have replied to your jury summons." on the page
	
Examples:
	| juror_number	| last_name	| postcode	| email           	| pool_number	|
	| 045200183		| DOE		| SW1H 9AJ	| email@outlook.com	| 452300168		|
	
@Regression
Scenario Outline: English 3rd RA Char Counter

	Given I am on "Public" "ithc"

	Given a bureau owned pool is created with jurors
		| court |juror_number  | pool_number	| att_date_weeks_in_future	| owner |
		| 452   |<juror_number>| <pool_number>	| 5				            | 400	|
		
	And juror "<juror_number>" has "LAST_NAME" as "<last_name>" new schema
	And juror "<juror_number>" has "POSTCODE" as "<postcode>" new schema
	
	Then I see "Reply to a jury summons" on the page
	
	Then I see "Are you replying for yourself or for someone else?" on the page
	
	When I set the radio button to "I am replying for someone else"
	And I press the "Continue" button
	Then I see "Their juror details" on the page
	
	#Juror Log In
	When I set "9-digit juror number" to "<juror_number>"
	When I set "Juror last name" to "<last_name>"
	When I set "Juror postcode" to "<postcode>"
	And I press the "Continue" button
	Then I see "What is your name?" on the page
	
	#3rd Party Name
	When I see "Your Details" on the page
	When I set "First name" to "FirstNameA"
	And I set "Last name" to "LastNameB"
	And I press the "Continue" button
	Then I see "Your relationship to the person" on the page
	
	#Relationship to juror
	When I see "Your Details" on the page
	And I set "How do you know the person you're replying for?" to "Friend"
	And I press the "Continue" button
	Then I see "Your contact information" on the page
	
	#3rd Party Contact
	When I see "Your Details" on the page
	And I check the "By phone (UK Numbers only)" checkbox
	And I set "Main phone" to "0207 821 1818"
	And I check the "By email" checkbox
	And I set "Enter your email address" to "email@outlook.com"
	And I set "Enter your email address again" to "email@outlook.com"
	And I press the "Continue" button
	
	#JDB-3455 Why are you replying title
	Then I see "Why are you replying for the other person?" on the page
	And I do not see "Why are you replying?" on the page
	
	#Why are you replying for the person?
	When I set the radio button to "The person is not here"
	And I press the "Continue" button

	Then I see "Is the name we have for them correct?" on the page
	When I choose the "Yes" radio button
	And I press the "Continue" button
	Then I see "Is this their address?" on the page
	When I choose the "Yes" radio button
	And I press the "Continue" button
	
	Then I see "Give the date of birth for the person you're replying for" on the page
	
	#DoB
	When I see "Juror Details" on the page
	And I set "Day" to "01"
	And I set "Month" to "01"
	
	#JDB-3418 Checking age 18 works
	And I set "Year" to "2000"
	And I press the "Continue" button
	Then I see "We might need to get in touch with the person to ask them more questions or give them information about their jury service" on the page
	
	#Contacting the juror
	When I see "Juror Details" on the page
	And I set the radio button to "Use the phone number that you have already given to contact you"
	And I set the radio button to "Use the email address that you have already given to contact you"
	And I press the "Continue" button
	
	#Qualify for jury service
	When I see "Confirm if the person is eligible for jury service" on the page
	And I press the "Continue" button
	
	#JDB-3373
	Then I see "Since they turned 13, has their main address been in the UK, Channel Islands or Isle of Man for any period of at least 5 years?" on the page
	
	#Residency
	When I see "Eligibility" on the page
	And I choose the "Yes" radio button
	And I press the "Continue" button
	
	#CJS no
	Then I see "Has the person you're replying for worked in the criminal justice system in the last 5 years?" on the page
	When I choose the "No" radio button
	And I press the "Continue" button
	
	#JDB-3371
	Then I see "Is the person currently on bail for a criminal offence?" on the page
	
	#Bail
	When I see "Eligibility" on the page
	And I choose the "No" radio button
	And I press the "Continue" button
	
	#JDB-3370
	Then I see "Has the person been found guilty of a criminal offence?" on the page
	
	#Convictions
	When I see "Eligibility" on the page
	When I choose the "No" radio button
	And I press the "Continue" button
	
	#Mental Health Sectioned
	Then I see "Is the person you're replying for being detained, looked after or treated under the Mental Health Act?" on the page
	When I see "Eligibility" on the page
	And I choose the "No" radio button
	And I press the "Continue" button
	
	#Mental Health Capacity
	Then I see "Has it been decided that the person you're replying for 'lacks mental capacity'?" on the page
	When I see "Eligibility" on the page
	And I choose the "No" radio button
	And I press the "Continue" button
	
	#The person can attend
	Then I see "Check your start date" on the page
	Then I set the radio button to "Yes, they can start on"
	And  I press the "Continue" button
	
	#RA no
	Then I see "Will the person you're replying for need help when they're at the court?" on the page
	When I choose the "Yes" radio button
	And I set "Tell us about any special arrangements or help the person you're answering for needs while they're doing jury service." to "Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here and this should cut."

	When I check the "Other" checkbox
	And I set "Provide details" to "Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here and this should cut."
	
	And I press the "Continue" button
	Then I see "Check your answers now" on the page
	
	#Check Your Answers
	
#	When I see text "Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here and this should cut." in the same row as "Does the person have a disability or impairment that means they'll need extra support or facilities in the court building where they are doing jury service?"
#	And I see text "Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here and this should cut." in the same row as "Please tell us about any special arrangements or help the person you're answering for needs while they're doing jury service"
	And I check the "The answers I have given for the person I'm replying for are true as far as I know." checkbox
	And I press the "Submit" button
	
	Then I see "We have sent an email to say you have replied to this jury summons." on the page
	
Examples:
	| juror_number	| last_name	| postcode	| email            | pool_number|
	| 045200184		| DOE		| SW1H 9AJ	| email@outlook.com| 452300169 	|
	
@RegressionWelsh
Scenario Outline: Welsh 1st RA Char Counter

	Given I am on the welsh version of "Public" "demo"

	Given a bureau owned pool is created with jurors
		| court |juror_number  | pool_number	| att_date_weeks_in_future	| owner |
		| 457   |<juror_number>| <pool_number>	| 5				            | 400	|
	
	And juror "<juror_number>" has "LAST_NAME" as "<last_name>" new schema
	And juror "<juror_number>" has "POSTCODE" as "<postcode>" new schema
	
	And I set the radio button to "n ymateb dros fy hun"
	And I press the "Parhau" button
	Then I see "Eich manylion rheithiwr" on the page
	And I see "Gallwch ddod o hyd i'ch rhif rheithiwr ar eich llythyr gwŷs rheithgor." on the page

	When I set "Rhif rheithiwr" to "<juror_number>"
	When I set "Cyfenw" to "<last_name>"
	When I set "Cod post Rheithiwr" to "<postcode>"
	And I press the "Parhau" button
	
	#JDB-3358 and JDB-3463
	Then on the page I see
		| text	|
		| Eich Manylion |
		| A yw'r enw sydd gennym ar eich cyfer chi yn gywir? |
		
	And I set the radio button to "Nac ydy"
	And I press the "Parhau" button
	And I set "Enw cyntaf" to "FirstNameA"
	And I set "Cyfenw" to "LastNameB"
	And I click on the "Beth sy'n digwydd os rwyf wedi newid fy enw?" link
	
	#JDB-3464
	And I see "Os yw eich enw chi wedi newid, byddwn yn cysylltu â chi i wirio hynny. Efallai y byddwn yn gofyn am dystysgrif briodas, tystysgrif partneriaeth sifil neu weithred newid enw." on the page
	And I press the "Parhau" button
	
	#JDB-3359, JDB-3355 and JDB-3465
	Then on the page I see
		| text	|
		| Eich Manylion |
		| Eich cyfeiriad chi yw hwn? |

	And I set the radio button to "Ie"	
	When I press the "Parhau" button
	
	#JDB-3361
	Then on the page I see
		| text	|
		| Eich Manylion |
		| Beth yw eich rhif ffôn? |
		| Darparwch rif ffôn yn y DU y gallwn ei ddefnyddio i gysylltu â chi rhwng 9am a 5pm, dydd Llun i ddydd Gwener. |
		| Prif rif ffôn |
		| Rhif ffôn arall (dewisol) |
	
	When I set "Prif rif ffôn" to "0207 821 1818"
	And I press the "Parhau" button
	
	#JDB-3352 and JDB-3362
	Then on the page I see
		| text|
		| Eich Manylion |
		| Beth yw eich cyfeiriad e-bost? |
		| Pam fod arnom angen eich cyfeiriad e-bost? |
	
	#JDB-3456
	When I set "Nodwch eich cyfeiriad e-bost" to "email@outlook.com"
	And I set "Nodwch eich cyfeiriad e-bost eto" to "email@outlook.com"
	And I press the "Parhau" button
	
	#JDB-3350 and JDB-3360
	Then on the page I see
		| text	|
		| Eich Manylion	|
		| Beth yw eich dyddiad geni? |
		| Cymorth gyda'ch dyddiad geni |
	
	When I set "Diwrnod" to "27"
	And I set "Mis" to "04"
	And I set "Blwyddyn" to "1978"
	And I press the "Parhau" button
	
	#Qualify for jury service JDB-3372 and JDB-3420
	Then I see "Cadarnhau a ydych yn gymwys i wasanaethu ar reithgor" on the page
	
	When I press the "Parhau" button
	
	#JDB-3373
	Then I see "Ers i chi droi'n 13 oed, a yw eich prif gyfeiriad wedi bod yn y DU, Ynysoedd y Sianel neu Ynys Manaw am unrhyw gyfnod o 5 mlynedd o leiaf?" on the page
	
	#Residency JDB-3378 JDB-3389
	When I see "Cymhwysedd" on the page
	And I set the radio button to "Naddo"
	And I set the radio button to "Do"
	And I press the "Parhau" button
	
	#CJS
	And I set the radio button to "Nac ydw"
	And I press the "Parhau" button
	
	#JDB-3371 and JDB-3506
	Then I see "Ydych chi ar fechnïaeth ar hyn o bryd am gyflawni trosedd?" on the page
	
	#Bail JDB-3377
	When I see "Cymhwysedd" on the page
	And I set the radio button to "Nac ydw"
	And I press the "Parhau" button
	
	#JDB-3370 and JDB-3468
	Then I see "Ydych chi wedi'ch cael yn euog o drosedd?" on the page
	
	#Convictions JDB-3376 and JDB-3469
	When I see "Cymhwysedd" on the page
	When I set the radio button to "Naddo"
	And I press the "Parhau" button
	
	#Mental Health Sectioned JDB-3363
	Then I see "Ydych chi'n cael eich cadw, yn cael eich gwarchod neu eich trin o dan y Ddeddf Galluedd Meddyliol?" on the page
	When I see "Cymhwysedd" on the page
	And I set the radio button to "Na"
	And I press the "Parhau" button
	
	#Mental Health Capacity JDB-3364 JDB-3354
	Then I see "A benderfynwyd nad oes gennych y gallu meddyliol?" on the page
	When I see "Cymhwysedd" on the page
	And I set the radio button to "Na"
	And I press the "Parhau" button
	
	#JDB-3087
	Then I see "Gwiriwch eich dyddiad dechrau" on the page
	
	#Confirm attendance
	And I set the radio button to "Ydw, rydw i'n gallu dechrau"
	And I press the "Parhau" button
	
	#RA
	And I set the radio button to "Oes"
	And I set "Rhowch wybod inni am unrhyw drefniadau arbennig bydd arnoch angen wrth ichi wasanaethu ar reithgor" to "Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here and this should cut."

	When I check the "Arall" checkbox
	And I set "Rhowch fanylion os gwelwch yn dda" to "Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here and this should cut."
		
	And I press the "Parhau" button
	Then I see "Gwiriwch eich ymatebion nawr" on the page
	
	#Check Your Answers
	When I see text "Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here and this should cut." in the same row as "A oes gennych anabledd neu nam sy'n golygu bydd angen cymorth neu gyfleusterau ychwanegol arnoch yn yr adeilad llys ble fyddwch yn cyflawni eich gwasanaeth rheithgor?"
	And I see text "Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here and this should cut." in the same row as "Rhowch wybod inni am unrhyw drefniadau arbennig bydd arnoch angen wrth ichi wasanaethu ar reithgor."
	
	#When I press the "Submit" button
	When I check the "Mae'r wybodaeth a roddais uchod yn wir hyd eithaf fy ngwybodaeth." checkbox
	And I press the "Cyflwyno" button
	Then I see "Rydym wedi anfon neges e-bost atoch i gadarnhau eich bod wedi ymateb i’ch gwŷs rheithgor." on the page
	
Examples:
	| juror_number	| last_name	| postcode	| email           	| pool_number	|
	| 045700027		| DOE		| SW1H 9AJ	| email@outlook.com	| 457300027		|

@RegressionWelsh
	Scenario Outline: Welsh 3rd RA Char Counter

	Given I am on the welsh version of "Public" "ithc"

	Given a bureau owned pool is created with jurors
		| court |juror_number  | pool_number	| att_date_weeks_in_future	| owner |
		| 457   |<juror_number>| <pool_number>	| 5				            | 400	|
		
	And juror "<juror_number>" has "LAST_NAME" as "<last_name>" new schema
	And juror "<juror_number>" has "POSTCODE" as "<postcode>" new schema
	
	And I set the radio button to "Rwy'n ymateb ar ran rhywun arall"
	And I press the "Parhau" button	
	
	#Juror Log In
	When I set "Rhif rheithiwr" to "<juror_number>"
	When I set "Cyfenw" to "<last_name>"
	When I set "Cod post Rheithiwr" to "<postcode>"
	And I press the "Parhau" button
    Then I see "Beth yw eich enw?" on the page
	
	#3rd Party Name
	When I see "Eich Manylion" on the page
	When I set "Enw cyntaf" to "FirstNameA"
	And I set "Cyfenw" to "LastNameB"
	And I press the "Parhau" button
	Then I see "Eich perthynas â'r unigolyn" on the page
	
	#Relationship to juror
	When I see "Eich Manylion" on the page
	And I set "Sut ydych chi'n adnabod yr unigolyn rydych yn ymateb ar ei ran?" to "Friend"
	And I press the "Parhau" button
	Then I see "Eich manylion cyswllt" on the page
	
	#3rd Party Contact
	When I see "Eich Manylion" on the page
	And I check the "Dros y ffôn (rhifau yn y DU yn unig)" checkbox
	And I set "Prif rif ffôn" to "0207 821 1818"
	And I check the "Trwy e-bost" checkbox
	And I set "Nodwch gyfeiriad e-bost" to "email@outlook.com"
	And I set "Nodwch gyfeiriad e-bost eto" to "email@outlook.com"
	And I press the "Parhau" button
	
	#Why are you replying title
	Then I see "Pam ydych chi'n ymateb ar ran yr unigolyn arall?" on the page
	And I do not see "Pam ydych chi'n ymateb?" on the page
	
	#Why are you replying for juror
	When I set the radio button to "Nid yw'r unigolyn yma"
	And I press the "Parhau" button
	Then I see "A yw'r enw sydd gennym ar ei gyfer yn gywir?" on the page
	
	#Check juror name
	When I see "Manylion y Rheithiwr" on the page
	And I set the radio button to "Ydy"
	And I press the "Parhau" button
	
	#JDB-3462
	Then I see "Ei gyfeiriad ef yw hwn?" on the page
	
	#Check juror address
	When I see "Manylion y Rheithiwr" on the page
	And I set the radio button to "Ie"
	And I press the "Parhau" button
	
	#JDB-3461
	Then I see "Nodwch ddyddiad geni'r unigolyn rydych chi'n ymateb ar ei ran" on the page
	
	#DoB
	When I see "Manylion y Rheithiwr" on the page
	And I set "Diwrnod" to "27"
	And I set "Mis" to "04"
	And I set "Blwyddyn" to "1981"
	And I press the "Parhau" button
	Then I see "Efallai bydd yn rhaid inni gysylltu â'r unigolyn i ofyn rhagor o gwestiynau neu roi rhagor o wybodaeth iddynt am eu gwasanaeth rheithgor" on the page

	#Contacting the juror
	When I see "Manylion y Rheithiwr" on the page
	And I set the radio button to "Defnyddio'r rhif ffôn rydych eisoes wedi'i ddarparu i gysylltu â chi"
	
	#Checking field
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
	
	#CJS no
	Then I see "A yw'r person yr ydych yn ymateb ar ei ran wedi gweithio yn y system cyfiawnder troseddol yn y 5 mlynedd diwethaf?" on the page
	When I set the radio button to "Nac ydy"
	And I press the "Parhau" button
	
	#JDB-3371
	Then I see "A yw'r unigolyn ar fechnïaeth ar hyn o bryd am gyflawni trosedd?" on the page
	
	#Bail
	When I see "Cymhwysedd" on the page
	And I set the radio button to "Nac ydy"
	And I press the "Parhau" button
	
	#JDB-3370
	Then I see "A yw'r unigolyn wedi'i gael yn euog o drosedd?" on the page
	
	#Convictions
	When I see "Cymhwysedd" on the page
	And I click on the "Canllawiau mewn perthynas â gwasanaethu ar reithgor os oes gennych euogfarn" link
	Then I see "Gallant wasanaethu ar reithgor os ydynt:" on the page
	
	#JDB-3472 and JDB-3471 checking conviction/guidance text
	When I see "Ni allant ychwaith wasanaethu ar reithgor os ydynt, yn ystod y 10 mlynedd diwethaf, wedi cael:" on the page
	Then I see "A yw'r unigolyn wedi'i gael yn euog o drosedd?" on the page
	When I set the radio button to "Na"
	And I press the "Parhau" button
	
	#Mental Health Sectioned
	Then I see "A ydi'r person yr ydych yn ymateb ar ei ran yn cael ei gadw, ei warchod neu ei drin o dan y Ddeddf Iechyd Meddwl?" on the page
	When I see "Cymhwysedd" on the page
	And I set the radio button to "Na"
	And I press the "Parhau" button
	
	#JDB-3467
	Then I see "A wnaed penderfyniad nad oes gan y person yr ydych yn ymateb ar ei ran y 'gallu meddyliol'?" on the page
	
	#Mental Health Capacity
	When I see "Cymhwysedd" on the page
	And I set the radio button to "Na"
	And I press the "Parhau" button
	
	Then I see "Gwiriwch eich dyddiad dechrau" on the page

	#The person can attend
	When I set the radio button to "Ydi, mae'r unigolyn yn gallu dechrau"
	And  I press the "Parhau" button
	
	#RA no
	Then I see "A fydd yr unigolyn rydych yn ymateb ar ei ran angen cymorth pan fydd yn y llys?" on the page
	When I set the radio button to "Oes"
	And I set "Rhowch wybod inni am unrhyw drefniadau arbennig neu gymorth bydd yr unigolyn rydych yn ymateb ar ei ran ei angen wrth iddo wasanaethu ar reithgor" to "Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here and this should cut."
	
	When I check the "Arall" checkbox
	And I set "Rhowch fanylion os gwelwch yn dda" to "Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here and this should cut."
	
	And I press the "Parhau" button
	Then I see "Gwiriwch eich ymatebion nawr" on the page
	
	#Check Your Answers
#	When I see text "Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here and this should cut." in the same row as "A oes gan yr unigolyn anabledd neu nam sy'n golygu bydd angen cymorth neu gyfleusterau ychwanegol arnynt yn yr adeilad llys lle byddant yn cyflawni'r gwasanaeth rheithgor?"
#	And I see text "Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here Insert meaningful text here and this should cut." in the same row as "Rhowch wybod inni am unrhyw drefniadau arbennig neu gymorth bydd yr unigolyn rydych yn ymateb ar ei ran ei angen wrth iddynt wasanaethu ar reithgor."
	And I check the "Hyd gwn i, mae'r wybodaeth rwyf wedi ei rhoi am yr unigolyn rwyf yn ymateb ar ei ran yn gywir." checkbox
	And I press the "Cyflwyno" button
	
	Then I see "Os byddwn yn cysylltu â nhw, efallai bydd angen iddynt ddarparu eu rhif rheithiwr. Mae'r rhif hefyd ar y llythyr bu inni anfon atynt." on the page
	
Examples:
	| juror_number	| last_name	| postcode	| email 	| pool_number	|
	| 045700028		| DOE		| SW1H 9AJ	| a@eeee.com| 457300028		|