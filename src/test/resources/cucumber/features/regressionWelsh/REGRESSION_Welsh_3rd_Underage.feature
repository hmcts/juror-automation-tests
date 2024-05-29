Feature: Regression Welsh_3rd_Underage

@RegressionWelsh @NewSchemaConverted
Scenario Outline: Welsh 3rd Party Underage

	Given I am on the welsh version of "Public" "test"

	Given a bureau owned pool is created with jurors
		| court | juror_number  	| pool_number	| att_date_weeks_in_future	| owner |
		| 457   | <juror_number>	| <pool_number>	| 5			            	| 400	|
		
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
	
	And I set the radio button to "Nid yw'r unigolyn yn gallu ymateb dros ei hun"
	And I press the "Parhau" button
	Then I see "A yw'r enw sydd gennym ar ei gyfer yn gywir?" on the page
	
	#Check Juror Name
	And I set the radio button to "Ydy"
	When I press the "Parhau" button
	Then I see "Ei gyfeiriad ef yw hwn?" on the page
	
	#Check Juror Address
	And I set the radio button to "Ie"
	When I press the "Parhau" button
	Then I see "Nodwch ddyddiad geni'r unigolyn rydych chi'n ymateb ar ei ran" on the page
	
	#DoB
	When I set the date of birth to a Monday "-900" weeks in the future
	And I press the "Parhau" button
	Then I see "Cadarnhewch ddyddiad geni'r unigolyn rydych chi'n ymateb ar ei ran" on the page

	And I see "steps/your-details/confirm/tp" in the URL
	And I see "Cadarnhewch ddyddiad geni'r unigolyn rydych chi'n ymateb ar ei ran" on the page
	And I see "A yw'r dyddiad geni yn gywir?" on the page
	
	And I press the "Parhau" button
	Then I see "Dywedwch wrthym os yw ei ddyddiad geni yn gywir" on the page
	
	And I set the radio button to "Na"
	And I press the "Parhau" button

	And I see "Er enghraifft, 15 03 1982" on the page
	And I set "Diwrnod" to "02"
	And I set "Mis" to "02"
	And I press the "Parhau" button
	
	Then I set the radio button to "Ie"
	And I press the "Parhau" button

	Then I see "Gwiriwch eich ymatebion nawr" on the page
	Then I check the "Hyd gwn i, mae'r wybodaeth rwyf wedi ei rhoi am yr unigolyn rwyf yn ymateb ar ei ran yn gywir." checkbox
	When I press the "Cyflwyno" button
	
	Then I see "Rydych wedi cwblhau'r broses ymateb" on the page
	Then I see "Rydych wedi cwblhau" on the page
	Then I see "<juror_number>" on the page
	
Examples:
	| juror_number	| last_name				| postcode	| email 		| pool_number	|
	| 045700068		| LNAMEEIGHTSIXEIGHT	| CH1 2AN	| b@eeee.com	| 457300068		|