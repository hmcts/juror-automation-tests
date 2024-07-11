Feature: Welsh_LogOn_Content

@RegressionWelsh @JDB-3081 @JDB-3077 @JDB-3080 
Scenario Outline:
	Given I am on the welsh version of "Public" "test"

	Given a bureau owned pool is created with jurors
		| court | juror_number  	    | pool_number	    | att_date_weeks_in_future	| owner |
		| 415   | <juror_number> 	    | <pool_number>     | 5				            | 400	|

	And juror "<juror_number>" has "POSTCODE" as "<postcode>" new schema

	And I set the radio button to "Rwy'n ymateb ar ran rhywun arall"
	And I press the "Parhau" button
	Then I see "Ei fanylion rheithiwr" on the page
	
	When I click on the "Nid oes gennyf rif rheithiwr" link
	Then I see "Bradford" on the page
	And I do not see "Pocock" on the page
	
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
	And I set the radio button to "Ydy"
	When I press the "Parhau" button
	Then I see "Ei gyfeiriad ef yw hwn?" on the page
	And I set the radio button to "Ie"
	When I press the "Parhau" button
	
	When I set "Diwrnod" to "27"
	And I set "Mis" to "04"
	
#I want to set the year dynamically to current year - 16

	And I set "Blwyddyn" to "2008"
	And I press the "Parhau" button
	
	Then I see "Cadarnhewch ddyddiad geni" on the page
	And I see "unigolyn oedd 27 Ebrill 2008" on the page
	And I see "r dyddiad geni yn gywir?" on the page
	
	Then I set the radio button to "Na"
	And I press the "Parhau" button
	
	And I set "Diwrnod" to "02"
	And I set "Mis" to "04"

	And I press the "Parhau" button
	
	Then I set the radio button to "Ie"
	And I press the "Parhau" button
	
	Then I see "Gwiriwch eich ymatebion nawr" on the page
	And I see text "2 Ebrill 2008" in the same row as "Dyddiad geni"
	
	Then I check the "Hyd gwn i, mae'r wybodaeth rwyf wedi ei rhoi am yr unigolyn rwyf yn ymateb ar ei ran yn gywir." checkbox
	When I press the "Cyflwyno" button
	
	Then I see "Rydych wedi cwblhau'r broses ymateb" on the page
	Then I see "Rydych wedi cwblhau'r broses ymateb" on the page
	Then I see "<juror_number>" on the page

	Examples:
		|juror_number	|last_name			|postcode	     |email 		|pool_number	|
		|041592771	    |lname	            |CH2 2AA	     |e@mail.com	|415355402	    |
