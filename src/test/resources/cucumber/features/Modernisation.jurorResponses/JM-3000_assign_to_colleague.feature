Feature: JM-3000 Assign to a colleague

@JurorTransformation
Scenario Outline: JM-3000 Assign Reply Happy Path

	#this test needs to stay in single threaded as it checks backlog counts which will be more dynamic in the multi threaded execution

	Given I am on "Bureau" "test"

	And pool no "<pool_no>" is reset to pending allocation
	And I have cleared down the juror digital database
	Given the juror numbers have not been processed new schema
		| part_no 			| pool_no 	| owner |
		| <part_no> 		|<pool_no>	| 400 	|

	Given auto straight through processing has been enabled

	And juror "<juror_number>" has "LAST_NAME" as "<last_name>" new schema
	And juror "<juror_number>" has "POSTCODE" as "<postcode>" new schema

	Given I have submitted a first party English ineligibilty response
		| part_no			|pool_number	| last_name			|postcode		| email 	|details	|
		|<part_no>			|<pool_no>		| <last_name>		|<postcode>		|<email>	|<details>	|

	Given I am on "Bureau" "test"
	And I log in as "<user>"
	And I click on the "Assign Replies" link

	#check responses counts are displayed
	Then I see "1" in the same row as "total" in Backlog box
	Then I see "1" in the same row as "standard" in Backlog box

	#Assign the new replies to CPASS
	Then I set how many "Standard" replies I want to assign to "1"
	When I check the "ARAMIS" checkbox
	When I press the "Assign replies" button

	#view the assigned record
	When I click on the "Search" link
	And I set "Juror number" to "<juror_number>"
	And I press the "Search" button

	#Check it's assigned to CPASS
	When I click on "<juror_number>" in the same row as "<juror_number>"
	And I am on the modernisation version of View Summons Reply
	And I see assigned to is "ARAMIS"

	#now reassign to SYSTEM
	Then I press the "More actions" button
	And I click on the "Send to a colleague" link

	#check page content
	Then I see "Send this reply to a colleague" on the page
	And I see Reply from "<first_name> <last_name>"
	Then I click on the Select an officer to send to input field
	Then I see "ARAMIS" on the page

	#assign to SYSTEM
	And I set input field with "id" of "sendToOfficer" to "MODTESTBUREAU"
	And I press the "Send" button
	And I press the "Send" button

	#view the assigned record
	When I click on the "Search" link
	And I set "Juror number" to "<juror_number>"
	And I press the "Search" button

	#Check it's assigned to SYSTEM
	When I click on "<juror_number>" in the same row as "<juror_number>"
	And I am on the modernisation version of View Summons Reply
	And I see assigned to is "MODTESTBUREAU"

	And I click on the "Sign out" link

Examples:
	|part_no 	|user			|pool_no	|first_name |last_name		|postcode	|email				|details	|
	|641500613	|MODTESTBUREAU	|415170401	|JOHN		|LNAMEEIGHTFOUR	|CH1 2AN	|email@bureauA.com	|12345abcde	|

	@JurorTransformation
	Scenario Outline: JM-3000 Assign Reply Errors Warnings Validations

		#this test needs to stay in single threaded as it checks backlog counts which will be more dynamic in the multi threaded execution

		Given I am on "Bureau" "test"

		And pool no "<pool_no>" is reset to pending allocation
		And I have cleared down the juror digital database
		Given the juror numbers have not been processed new schema
			| part_no 			| pool_no 	| owner |
			| <part_no> 		|<pool_no>	| 400 	|
			| <part_no_two> 	|<pool_no>	| 400 	|

		Given auto straight through processing has been enabled

		And juror "<juror_number>" has "LAST_NAME" as "<last_name>" new schema
		And juror "<juror_number>" has "POSTCODE" as "<postcode>" new schema

		And "<part_no_two>" has "RET_DATE" as "5 mondays time"
		And "<part_no_two>" has "NEXT_DATE" as "5 mondays time"
		And "<part_no_two>" has "LNAME" as "<last_name_two>"
		And "<part_no_two>" has "ZIP" as "<postcode>"

		Given I have submitted a first party English ineligibilty response
			| part_no			|pool_number	| last_name			|postcode		| email 	|details	|
			|<part_no>			|<pool_no>		| <last_name>		|<postcode>		|<email>	|<details>	|

		Given I have submitted a first party English straight through response
			| part_no			|pool_number	| last_name			|postcode		| email 	|details	|
			|<part_no_two>		|<pool_no>		| <last_name_two>	|<postcode>		|<email>	|<details>	|

		Given I am on "Bureau" "test"
		And I log in as "<user>"
		And I click on the "Assign Replies" link

	#check responses counts are displayed
		Then I see "1" in the same row as "total" in Backlog box
		Then I see "1" in the same row as "standard" in Backlog box

	#Assign the new replies to CPASS
		Then I set how many "Standard" replies I want to assign to "1"
		When I check the "ARAMIS1" checkbox
		When I press the "Assign replies" button

	#view the assigned record
		When I click on the "Search" link
		And I set "Juror number" to "<juror_number>"
		And I press the "Search" button

	#Check it's assigned to CPASS
		When I click on "<juror_number>" in the same row as "<juror_number>"
		And I am on the modernisation version of View Summons Reply
		And I see assigned to is "ARAMIS1"

	#now reassign
		Then I press the "More actions" button
		And I click on the "Send to a colleague" link

	#check page content
		Then I see "Send this reply to a colleague" on the page
		And I see Reply from "<first_name> <last_name>"

	#send with no assignee
		And I press the "Send" button
		Then I see error "Select an officer to send this reply to"

	#send with invalid assignee - bob
		And I set input field with "id" of "sendToOfficer" to "bob"
		And I see "No results found" on the page
		And I press the "Send" button
		And I press the "Send" button
		Then I see error "Select an officer to send this reply to"

	#send with invalid assignee - 1234
		And I set input field with "id" of "sendToOfficer" to "bob"
		And I see "No results found" on the page
		And I press the "Send" button
		And I press the "Send" button
		Then I see error "Select an officer to send this reply to"

		Then I click on the Select an officer to send to input field
		Then I see "ARAMIS" on the page
		Then I see "MODTESTBUREAU" on the page
		Then I see "MODTESTBUREAU" on the page
		Then I see "ARAMIS1" on the page
		Then I see "Return to unassigned replies" on the page
		#should not see this court user - raised ticket 3955
#		And I do not see "MODTESTCOURT" on the page

	#click cancel to return to response
		Then I click on the "Cancel" link
		Then I click on the "Cancel" link
		And I am on the modernisation version of View Summons Reply
		And I see assigned to is "ARAMIS1"

		#check I cannot reassign a closed response
		When I click on the "Search" link
		And I set "Juror number" to "<part_no_two>"
		And I press the "Search" button

	#Check it's assigned to CPASS
		When I click on "<part_no_two>" in the same row as "<part_no_two>"
		And I am on the modernisation version of View Summons Reply
		Then I press the "More actions" button
		And I do not see link with text "Send to a colleague"
		And I see assigned to is "AUTO"

		And I click on the "Sign out" link

		Examples:
			|user			|pool_no	|part_no 	|part_no_two 	|first_name |last_name	|last_name_two |postcode |email				|details	|
			|MODTESTBUREAU	|415170401	|641500613	|641500616 		|JOHN		|LNAMEONE	|LNAMETWO      |CH1 2AN	 |email@bureauA.com	|12345abcde	|

	