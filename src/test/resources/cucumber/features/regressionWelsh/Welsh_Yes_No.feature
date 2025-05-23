Feature: Welsh_Yes_No

@RegressionWelsh @JDB-3085 @JDB-3089 @JDB-3091 
Scenario Outline: Welsh_Yes_No
	Given I am on the welsh version of "Public" "test"

	Given a bureau owned pool is created with jurors
		| court | juror_number   | pool_number   | att_date_weeks_in_future | owner |
		| 457   | <juror_number> | <pool_number> | 5                        | 400   |

	And juror "<juror_number>" has "LAST_NAME" as "<last_name>" new schema
	And juror "<juror_number>" has "POSTCODE" as "<postcode>" new schema

	And I set the radio button to "n ymateb dros fy hun"
	And I press the "Parhau" button
	Then I see "Eich manylion rheithiwr" on the page
	
	When I set "Rhif rheithiwr" to "<juror_number>"
	When I set "Cyfenw" to "<last_name>"
	When I set "Cod post Rheithiwr" to "<postcode>"
	And I press the "Parhau" button

	Then I see "Eich Manylion" on the page
	
	#Juror's details
	Then I see "A yw'r enw sydd gennym ar eich cyfer chi yn gywir?" on the page
	And I set the radio button to "Ydy"
	When I press the "Parhau" button
	Then I see "Eich cyfeiriad chi yw hwn?" on the page
	And I set the radio button to "Ie"
	When I press the "Parhau" button
	
	When I set "Prif rif ffôn" to "02078211818"
	And I press the "Parhau" button
	
	When I set input field with "id" of "emailAddress" to "<email>"
	When I set input field with "id" of "emailAddressConfirmation" to "<email>"
	And I press the "Parhau" button
	
	When I set "Diwrnod" to "27"
	And I set "Mis" to "04"
	
	#I want to set the year dynamically to current year - 40
	And I set "Blwyddyn" to "1978"
	And I press the "Parhau" button

	#do you qualify for jury service?
	And I press the "Parhau" button

	And I set the radio button to "Do"
	And I press the "Parhau" button

	#CJS
	And I set the radio button to "Nac ydw"
	And I set the radio button to "Ydw"
	And I see "Dewiswch unrhyw sefydliadau rydych wedi gweithio iddynt." on the page
	And I set the radio button to "Nac ydw"
	And I press the "Parhau" button
	
	# Bail
	And I set the radio button to "Nac ydw"
	And I press the "Parhau" button
	
	And I set the radio button to "Naddo"
	And I press the "Parhau" button
	
	#mental health
	Then I see "Ydych chi'n cael eich cadw, yn cael eich gwarchod neu eich trin o dan y Ddeddf Galluedd Meddyliol?" on the page
	And I set the radio button to "Na"
	And I set the radio button to "Ie"
	And I see "Eglurwch sut yr ydych yn cael eich cadw dan glo, sut ofal ydych yn ei gael neu sut yr ydych yn cael eich trin o dan y Ddeddf Iechyd Meddwl" on the page
	And I set the radio button to "Na"
	And I press the "Parhau" button
	Then I see "A benderfynwyd nad oes gennych y gallu meddyliol?" on the page
	
	When I set the radio button to "Na"
	And I press the "Parhau" button
	
	#can you attend, select excusal
	And I set the radio button to "Nac ydw, ni allaf wasanaethu ar reithgor a hoffwn gael fy esgusodi"
	And I press the "Parhau" button
	
	#reasons for excusal
	And I set text area with "id" of "excusalReason" to "reasons for excusal request"
	And I press the "Parhau" button
	
	#Special Reqs
	And I set the radio button to "Nac oes"
	When I press the "Parhau" button
	
	#Check your answers page
	Then I see "Gwiriwch eich ymatebion nawr" on the page
	
	Then I check the "Mae'r wybodaeth a roddais uchod yn wir hyd eithaf fy ngwybodaeth." checkbox
	When I press the "Cyflwyno" button
	
	Then I see "Rydych wedi cwblhau'r broses ymateb" on the page
	Then I see "Rydych wedi cwblhau'r broses ymateb" on the page
	Then I see "<juror_number>" on the page
	
Examples:
	| juror_number	| last_name			| postcode	| email 	| pool_number	|
	| 845701661		| LNAMESIXSIXZERO	| CH1 2AN	| a@eeee.com| 457181001		|