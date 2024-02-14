Feature: Regression_Welsh_AccountLocked

@RegressionWelsh @JDB-2678 @JDB-3516 @JDB-3667
Scenario Outline: 1st Party Account Locked
	Given I am on the welsh version of "Public" "juror-test01"
	
	Given the juror numbers have not been processed
		| part_no 	| pool_no 	| owner |
		| <part_no> |<pool_no>	| 400 	|
		
	
#	And "<part_no>" has "LNAME" as "<last_name>" 
#	And "<part_no>" has "RET_DATE" as "5 mondays time"
#	And "<part_no>" has "NEXT_DATE" as "5 mondays time"
#	And "<part_no>" has "ZIP" as "<postcode>"
#
##1st_English	
#
#	Then I see "Reply to a jury summons" on the page
#		When I click on the "Welsh (Cymraeg)" link
#	
#	
##start now	
#
#	When I press the "Dechrau nawr" button
#	And I do not see any links on the page that open to a new page without an alt text
	
#replying for myself

	And I set the radio button to "n ymateb dros fy hun"
	And I press the "Parhau" button
	And I do not see any links on the page that open to a new page without an alt text

#log on attempt #1	

	When I set "Rhif rheithiwr" to "<part_no>"
	And I set "Cyfenw" to "Smith"
	And I set "Cod post Rheithiwr" to "SW17 7SR"
	And I press the "Parhau" button
	Then I see "Nid yw'r cyfuniad o’ch enw, cod post a rhif rheithiwr wedi’u hadnabod" on the page
	
#log on attempt #2

	When I set "Rhif rheithiwr" to "<part_no>"
	And I set "Cyfenw" to "Smith"
	And I set "Cod post Rheithiwr" to "SW17 7SR"
	And I press the "Parhau" button
	Then I see "Nid yw'r cyfuniad o’ch enw, cod post a rhif rheithiwr wedi’u hadnabod" on the page
	
#log on attempt #3

	When I set "Rhif rheithiwr" to "<part_no>"
	And I set "Cyfenw" to "Smith"
	And I set "Cod post Rheithiwr" to "SW17 7SR"
	And I press the "Parhau" button
	Then I see "Nid yw'r cyfuniad o’ch enw, cod post a rhif rheithiwr wedi’u hadnabod" on the page
	
#log on attempt #4

	When I set "Rhif rheithiwr" to "<part_no>"
	And I set "Cyfenw" to "Smith"
	And I set "Cod post Rheithiwr" to "SW17 7SR"
	And I press the "Parhau" button
	And I do not see any links on the page that open to a new page without an alt text
	
#@JDB-2678

	Then I see "Am resymau diogelwch, mae eich cyfrif wedi'i gloi oherwydd ymdrechion mewngofnodi lluosog ac ni allwch ateb ar-lein bellach. Cysylltwch â Chanolfan Atgyfeirio Canolog y Rheithgor am fwy o wybodaeth - mae ein manylion isod yn yr adran 'Nid oes gennyf rif rheithgor'." on the page
	
Examples:
	|part_no		|last_name			|postcode	|email 		| pool_no	|
	|841501977		|LNAME1977			|CH1 2AN	|b@eeee.com	| 415181001	|

@RegressionWelsh @JDB-2678 @JDB-3667
Scenario Outline: 3rd Party Account Locked
	Given I am on the welsh version of "Public" "juror-test01"
	Given the juror numbers have not been processed
		| part_no 	| pool_no 	| owner |
		| <part_no> |<pool_no>	| 400 	|
	
	And "<part_no>" has "LNAME" as "<last_name>" 
	And "<part_no>" has "RET_DATE" as "5 mondays time"
	And "<part_no>" has "NEXT_DATE" as "5 mondays time"
	And "<part_no>" has "ZIP" as "<postcode>"

	
#	Then I see "Reply to a jury summons" on the page
#	When I click on the "Welsh (Cymraeg)" link
#	
#	And I do not see any links on the page that open to a new page without an alt text
#	When I press the "Dechrau nawr" button
#	And I do not see any links on the page that open to a new page without an alt text

	And I set the radio button to "Rwy'n ymateb ar ran rhywun arall"
	And I press the "Parhau" button
	And I do not see any links on the page that open to a new page without an alt text

#log on attempt #1	

	When I set "Rhif rheithiwr" to "<part_no>"
	When I set "Cyfenw" to "Smith"
	When I set "Cod post Rheithiwr" to "SW17 7SR"
	And I press the "Parhau" button
	Then I see "Nid yw'r cyfuniad o’r enw, cod post a rhif rheithiwr yn gyfarwydd." on the page
	And I do not see any links on the page that open to a new page without an alt text
	
#log on attempt #2

	When I set "Rhif rheithiwr" to "<part_no>"
	When I set "Cyfenw" to "Smith"
	When I set "Cod post Rheithiwr" to "SW17 7SR"
	And I press the "Parhau" button
	Then I see "Nid yw'r cyfuniad o’r enw, cod post a rhif rheithiwr yn gyfarwydd." on the page
	And I do not see any links on the page that open to a new page without an alt text
	
#log on attempt #3

	When I set "Rhif rheithiwr" to "<part_no>"
	When I set "Cyfenw" to "Smith"
	When I set "Cod post Rheithiwr" to "SW17 7SR"
	And I press the "Parhau" button
	Then I see "Nid yw'r cyfuniad o’r enw, cod post a rhif rheithiwr yn gyfarwydd." on the page
	And I do not see any links on the page that open to a new page without an alt text
	
#log on attempt #4

	When I set "Rhif rheithiwr" to "<part_no>"
	When I set "Cyfenw" to "Smith"
	When I set "Cod post Rheithiwr" to "SW17 7SR"
	And I press the "Parhau" button
	And I do not see any links on the page that open to a new page without an alt text
	
#@JDB-2678
#JDB-3667

	Then I see "Mae’r cyfrif hwn wedi cael ei gloi am resymau diogelwch oherwydd sawl ymgais aflwyddiannus i fewngofnodi. Ni allwch mwyach ymateb ar-lein. Os gwelwch yn dda, cysylltwch ȃ Swyddfa Ganolog Gwysio Rheithgor i gael rhagor o wybodaeth – mae ein manylion isod yn yr adran ‘nid oes gen i rif rheithiwr’." on the page
	And I do not see any links on the page that open to a new page without an alt text
Examples:
	|part_no		|last_name	|postcode	|email 		| pool_no	|
	|841501970		|LNAME1970	|CH1 2AN	|b@eeee.com	| 415181001	|


