Feature: Welsh_3rd_MoreJurorDetails

@RegressionWelsh @JDB-3424 @JDB-3423 @JDB-3422 
Scenario Outline: 
	Given I am on the welsh version of "Public" "juror-test02"
	Given the juror numbers have not been processed
		|part_no 	|pool_no 	|owner 	|
		|<part_no> 	|<pool_no>	|400 	|

	And "<part_no>" has "LNAME" as "<last_name>" 
	And "<part_no>" has "RET_DATE" as "5 mondays time"
	And "<part_no>" has "NEXT_DATE" as "5 mondays time"
	And "<part_no>" has "ZIP" as "<postcode>"

	And I set the radio button to "Rwy'n ymateb ar ran rhywun arall"
	And I press the "Parhau" button
	Then I see "Ei fanylion rheithiwr" on the page
	
	#Juror Log In
	
	When I set "Rhif rheithiwr – 9 digid" to "<part_no>"
	When I set "Cyfenw'r Rheithiwr" to "<last_name>"
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
	And I press the "Parhau" button
	Then I see "Pam ydych chi'n ymateb ar ran yr unigolyn arall?" on the page
	
	#Why are you replying for the person? Fails below due to '
	
	When I set the radio button to "Nid yw'r unigolyn yma"
	And I press the "Parhau" button
	Then I see "A yw'r enw sydd gennym ar ei gyfer yn gywir?" on the page
	
	#Check juror name JDB-3369 and JDB-3422
	
	When I see "Manylion y Rheithiwr" on the page
	And I set the radio button to "Nac ydy"
	And I press the "Parhau" button
	And I click on the "Beth fydd yn digwydd os ydyw wedi newid ei enw?" link
	Then I see "Os yw ei enw wedi newid, byddwn yn cysylltu â chi i wirio hynny. Efallai y byddwn yn gofyn am dystysgrif briodas, tystysgrif partneriaeth sifil neu weithred newid enw." on the page
	And I press the "Parhau" button
	Then I see "Ei gyfeiriad ef yw hwn?" on the page
	
	#Check juror address JDB-3369 and JDB-3424
	
	When I see "Manylion y Rheithiwr" on the page
	And I set the radio button to "Ie"
	And I press the "Parhau" button
	Then I see "Nodwch ddyddiad geni'r unigolyn rydych chi'n ymateb ar ei ran" on the page
	
	#DoB JDB-3369 and JDB-3423
	
	When I see "Manylion y Rheithiwr" on the page
	And I set "Diwrnod" to "27"
	And I set "Mis" to "04"
	And I set "Blwyddyn" to "1981"
	And I press the "Parhau" button
	Then I see "Efallai bydd yn rhaid inni gysylltu â'r unigolyn i ofyn rhagor o gwestiynau neu roi rhagor o wybodaeth iddynt am eu gwasanaeth rheithgor" on the page
	
	#Contacting the juror JDB-3369
	
	When I see "Manylion y Rheithiwr" on the page
	And I set the radio button to "Defnyddio'r rhif ffôn rydych eisoes wedi'i ddarparu i gysylltu â chi"
	And I set the radio button to "Defnyddio'r cyfeiriad e-bost rydych eisoes wedi'i ddarparu i gysylltu â chi"
	And I press the "Parhau" button
	Then I see "Cadarnhau a yw'r unigolyn yn gymwys i wasanaethu ar reithgor" on the page
	
	
Examples:
	|part_no	|last_name		|postcode	|email           	|pool_no	|
	|645200075	|LNAMESEVENFIVE	|SY2 6LU	|email@outlook.com	|452170401	|
	
