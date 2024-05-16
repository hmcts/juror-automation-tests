Feature: Regression Welsh_1st_Underage

@RegressionWelsh @JDB-3072 @JDB-3080 @JDB-3411 @JDB-3886 @JDB-3790 
Scenario Outline: Welsh 1st Party Underage
	Given I am on the welsh version of "Public" "bau-test" 
	Given the juror numbers have not been processed
		| part_no 	| pool_no 	| owner |
		| <part_no> |<pool_no>	| 400 	|
		
	And juror "<juror_number>" has "LAST_NAME" as "<last_name>" new schema


	And juror "<juror_number>" has "POSTCODE" as "<postcode>" new schema

    And I see "A ydych yn ymateb dros eich hun neu ar ran rhywun arall?" on the page 
	And I set the radio button to "n ymateb dros fy hun"
	And I press the "Parhau" button
	Then I see "Eich manylion rheithiwr" on the page
	
	When I set "Rhif rheithiwr" to "<juror_number>"
	When I set "Cyfenw" to "<last_name>"
	When I set "Cod post Rheithiwr" to "<postcode>"
	And I press the "Parhau" button
	
	#JDB-3358
	
	Then I see "A yw'r enw sydd gennym ar eich cyfer chi yn gywir?" on the page
		
	And I set the radio button to "Nac ydy"
	And I press the "Parhau" button
	And I set "Enw cyntaf" to "FirstNameA"
	And I set "Cyfenw" to "LastNameB"
	And I press the "Parhau" button
	
	#JDB-3359 and JDB-3355
	
	Then on the page I see
		| text	|
		| Eich Manylion |
		| Eich cyfeiriad chi yw hwn? |
	
	And I set the radio button to "Ie"
	When I press the "Parhau" button
	Then I see "Beth yw eich rhif ffôn?" on the page
	
	When I set "Prif rif ffôn" to "02078211818"
	And I press the "Parhau" button
	Then I see "Beth yw eich cyfeiriad e-bost?" on the page
	
	When I set "Nodwch eich cyfeiriad e-bost" to "email@outlook.com"
	And I set "Nodwch eich cyfeiriad e-bost eto" to "email@outlook.com"
	And I press the "Parhau" button
	
	Then I see "Beth yw eich dyddiad geni?" on the page
	
	When I set "Diwrnod" to "27"
	And I set "Mis" to "04"
	#I want to set the year dynamically to current year - 16

	And I set "Blwyddyn" to "2006"
	And I press the "Parhau" button
	Then I see "Cadarnhewch y dyddiad geni" on the page
	
	And I see "steps/your-details/confirm" in the URL
	And I see "Bu ichi ddweud mai eich dyddiad geni oedd 27 Ebrill 2006." on the page
	And I see "A yw eich dyddiad geni yn gywir?" on the page
	
	#check error message
	
	And I press the "Parhau" button
	Then I see "Dywedwch wrthym os yw eich dyddiad geni yn gywir" on the page
	
	Then I set the radio button to "Na"
	And I press the "Parhau" button
	
	And I see "Er enghraifft, 15 03 1982" on the page
	And I set "Diwrnod" to "02"
	And I set "Mis" to "02"
	And I press the "Parhau" button
	
	Then I set the radio button to "Ie"
	And I press the "Parhau" button
	
	Then I see "Gwiriwch eich ymatebion nawr" on the page
	And I see text "2 Chwefror 2006" in the same row as "Dyddiad geni"

	Then I check the "wybodaeth a roddais uchod yn wir hyd eithaf fy ngwybodaeth." checkbox
	When I press the "Cyflwyno" button
	
	Then I see "Rydych wedi cwblhau'r broses ymateb" on the page
	Then I see "Rydych wedi cwblhau" on the page
	Then I see "<juror_number>" on the page
	
Examples:
	|part_no		|last_name			|postcode	|email 		|pool_no	|
	|741500874		|LNAMEEIGHTSEVENFOUR|CH1 2AN	|b@eeee.com	|415181001	|
	
@RegressionWelsh @NewSchemaConverted
Scenario Outline: Welsh 1st Underage with Error Check

	Given I am on the welsh version of "Public" "test"

	Given a bureau owned pool is created with jurors
		| court |juror_number  | pool_number	| att_date_weeks_in_future	| owner |
		| 457   |<juror_number>| <pool_number>	| 5				            | 400	|

	And juror "<juror_number>" has "LAST_NAME" as "<last_name>" new schema
	And juror "<juror_number>" has "POSTCODE" as "<postcode>" new schema
	
	And I choose the "n ymateb dros fy hun" radio button
	And I press the "Parhau" button
	Then I see "Eich manylion rheithiwr" on the page
	
	When I set "Rhif rheithiwr" to "<juror_number>"
	When I set "Cyfenw" to "<last_name>"
	When I set "Cod post Rheithiwr" to "<postcode>"
	And I press the "Parhau" button

	Then on the page I see
		| text	|
		| Eich Manylion |
		| A yw'r enw sydd gennym ar eich cyfer chi yn gywir? |
		
	And I choose the "Nac ydy" radio button
	And I press the "Parhau" button
	And I set "Enw cyntaf" to "FirstNameA"
	And I set "Cyfenw" to "LastNameB"
	And I press the "Parhau" button

	Then on the page I see
		| text	|
		| Eich Manylion |
		| Eich cyfeiriad chi yw hwn? |
	
	And I choose the "Ie" radio button
	When I press the "Parhau" button
	Then I see "Beth yw eich rhif ffôn?" on the page
	
	When I set "Prif rif ffôn" to "02078211818"
	And I press the "Parhau" button
	Then I see "Beth yw eich cyfeiriad e-bost?" on the page
	
	When I set "Nodwch eich cyfeiriad e-bost" to "email@outlook.com"
	And I set "Nodwch eich cyfeiriad e-bost eto" to "email@outlook.com"
	And I press the "Parhau" button
	Then I see "Beth yw eich dyddiad geni?" on the page

	And I set the date of birth to a Monday "-800" weeks in the future

	And I press the "Parhau" button
	Then I see "Cadarnhewch y dyddiad geni" on the page

	And I see "A yw eich dyddiad geni yn gywir?" on the page
	
	And I set the radio button to "Na"
	And I press the "Parhau" button
	
	And I set "Diwrnod" to ""
	And I set "Mis" to ""
	And I set "Blwyddyn" to ""
	And I press the "Parhau" button
	And I see "Nodwch y diwrnod y cawsoch eich geni" on the page
	And I do not see "Nodwch y mis y cawsoch eich geni" on the page
	And I do not see "Nodwch y flwyddyn y cawsoch eich geni" on the page
	
	And I set "Diwrnod" to "27"
	And I set "Mis" to "04"
	And I set "Blwyddyn" to "198a"
	And I press the "Parhau" button
	And I see "Rhowch y flwyddyn y cawsoch eich geni fel rhif 4 digid. Er enghraifft, 1982" on the page

	And I set the date of birth to a Monday "-800" weeks in the future
	And I press the "Parhau" button
	
	And I choose the "Ie" radio button
	And I press the "Parhau" button
	
	Then I see "Gwiriwch eich ymatebion nawr" on the page
	And I see text "2 Chwefror 2006" in the same row as "Dyddiad geni"

Examples:
	| juror_number	| last_name	| postcode	| pool_number	|
	| 045700058		| DOE		| CH1 2AN	| 457300058		|
	