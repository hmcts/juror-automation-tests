Feature: Welsh_LogOn_Content

@RegressionWelsh @JDB-3081 @JDB-3077 @JDB-3080 
Scenario Outline: 
	Given I am on the welsh version of "Public" "bau-test"
	Given the juror numbers have not been processed
		| part_no 	| pool_no 	| owner |
		| <part_no> |<pool_no>	| 400 	|
	
	And "<part_no>" has "LNAME" as "<last_name>" 
	And "<part_no>" has "RET_DATE" as "5 mondays time"
	And "<part_no>" has "NEXT_DATE" as "5 mondays time"
	And "<part_no>" has "ZIP" as "<postcode>"

	And I set the radio button to "Rwy'n ymateb ar ran rhywun arall"
	And I press the "Parhau" button
	Then I see "Ei fanylion rheithiwr" on the page
	
	When I click on the "Nid oes gennyf rif rheithiwr" link
	Then I see "Bradford" on the page
	And I do not see "Pocock" on the page
	
	When I set "Rhif rheithiwr" to "<part_no>"
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

	And I set "Blwyddyn" to "2006"
	And I press the "Parhau" button
	
	Then I see "Cadarnhewch ddyddiad geni" on the page
	And I see "unigolyn oedd 27 Ebrill 2006" on the page
	And I see "r dyddiad geni yn gywir?" on the page
	
	Then I set the radio button to "Na"
	And I press the "Parhau" button
	
	And I set "Diwrnod" to "02"
	And I set "Mis" to "04"

	And I press the "Parhau" button
	
	Then I set the radio button to "Ie"
	And I press the "Parhau" button
	
	Then I see "Gwiriwch eich ymatebion nawr" on the page
	And I see text "2 Ebrill 2006" in the same row as "Dyddiad geni"
	
	Then I check the "Hyd gwn i, mae'r wybodaeth rwyf wedi ei rhoi am yr unigolyn rwyf yn ymateb ar ei ran yn gywir." checkbox
	When I press the "Cyflwyno" button
	
	Then I see "Rydych wedi cwblhau'r broses ymateb" on the page
	Then I see "Rydych wedi cwblhau'r broses ymateb" on the page
	Then I see "<part_no>" on the page
	
Examples:
	| part_no		|last_name		|postcode	| email 	| pool_no	|
	|841500146		|LNAME146		|CH1 2AN	|a@eeee.com	|415181001	|
