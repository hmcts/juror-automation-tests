Feature: Welsh_3rd_ST_EmailCheck

@RegressionWelsh @JDB-3487 
Scenario Outline: Check that email fields for 3rd party Welsh are correct
	Given I am on the welsh version of "Public" "juror-test01"
	Given the juror numbers have not been processed
		| part_no 	| pool_no 	| owner |
		| <part_no> |<pool_no>	| 400 	|
	
	And "<part_no>" has "LNAME" as "<last_name>" 
	And "<part_no>" has "RET_DATE" as "5 mondays time"
	And "<part_no>" has "NEXT_DATE" as "5 mondays time"
	And "<part_no>" has "ZIP" as "<postcode>"
	
	And I set the radio button to "Rwy'n ymateb ar ran rhywun arall"
	And I press the "Parhau" button
	
	#Juror Log In
	
	When I set "Rhif rheithiwr" to "<part_no>"
	When I set "Cyfenw" to "<last_name>"
	When I set "Cod post Rheithiwr" to "<postcode>"
	And I press the "Parhau" button
    Then I see "Beth yw eich enw?" on the page
	
	#3rd Party Name JDB-3380 and JDB-3365
	
	When I see "Eich Manylion" on the page
	When I set "Enw cyntaf" to "FirstNameA"
	And I set "Cyfenw" to "LastNameB"
	And I press the "Parhau" button
	Then I see "Eich perthynas â'r unigolyn" on the page
	
	#Relationship to juror JDB-3368 and JDB-3366
	
	When I see "Eich Manylion" on the page
	And I set "Sut ydych chi'n adnabod yr unigolyn rydych yn ymateb ar ei ran?" to "Friend"
	And I press the "Parhau" button
	Then I see "Eich manylion cyswllt" on the page
	
	#3rd Party Contact JDB-3379 and JDB-3367
	
	When I see "Eich Manylion" on the page
	And I check the "Dros y ffôn (rhifau yn y DU yn unig)" checkbox
	And I set "Prif rif ffôn" to "0207 821 1818"
	And I check the "Trwy e-bost" checkbox
	And I set "Nodwch gyfeiriad e-bost" to "email@outlook.com"
	And I set "Nodwch gyfeiriad e-bost eto" to "email@outlook.com"
	
	And I do not see "bostt" on the page
	And I press the "Parhau" button

Examples:
	|part_no		|last_name			|postcode	|email 		|pool_no   |
	|641500280		|LNAMETWOEIGHTZERO	|CH1 2AN	|a@eeee.com	|415170601 |
