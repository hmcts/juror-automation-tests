Feature: Bureau D Test
	
@Regression_Single
Scenario Outline: Bureau D script
	No colour checking! For Red etc

	Given I am on "Public" "juror-test01"
	And pool no "<pool_no>" is reset to pending allocation
	And I have cleared down the juror digital database
	Given the juror numbers have not been processed
		| part_no 	| pool_no 	| owner |
		| <part_no> |<pool_no>	| 400 	|
	
	And auto straight through processing has been enabled
	
	Given "<part_no>" has "RET_DATE" as "5 mondays time"
	And "<part_no>" has "NEXT_DATE" as "5 mondays time"
	And "<part_no>" has "LNAME" as "<last_name>" 
	#And "<part_no>" has "FNAME" as "FNAMEEIGHTFIVEFIVE"
	#And "<part_no>" has "Address" as "855 STREET NAME"
	#And "<part_no>" has "Address2" as "ANYTOWN"
	#And "<part_no>" has "Address3" as ""
	#And "<part_no>" has "Address4" as "LONDON"
	And "<part_no>" has "ZIP" as "<postcode>"
	
	Given I have submitted a first party English ineligibilty response
		|part_no			|pool_number	|last_name			|postcode		|email 		|details	|
		|<part_no>			|<pool_no>		|<last_name>		|<postcode>		|<email>	|<details>	|
	
	
	Given I am on "Bureau" "juror-test01"
	When I log in
	And I click on the "Assign Replies" link
#	And I press the "Send" button
#	Then I see "Please check the form" on the page
#	And I see "The overall capacity must be less than or equal to the backlog total." on the page
#	And I see "Please reduce the capacity allocated to the individual Bureau officers so this is true." on the page
	
	And I see "1" in the same row as "Non urgent" in Backlog box
	And I set input field with "name" of "allocateNonUrgent" to "1"
	When I check the "ARAMIS1" checkbox
	And I press the "Send" button
	
	When I click on the "Search" link
	And I set "Juror number" to "<part_no>"
	And I press the "Search" button
	Then I see "1 results for" on the page
	
	Then I see "<part_no>" in the same row as "ARAMIS1"
	And I see "<part_no>" in the same row as "To do"
	And I see "To do" in the same row as "ARAMIS1"
	
	
Examples:
	| part_no 	| pool_no 	|last_name		|postcode	|email				|details	|
	|641500217	|415171111	|LNAMEEIGHTFOUR	|CH1 2AN	|email@bureauA.com	|12345abcde	|
	