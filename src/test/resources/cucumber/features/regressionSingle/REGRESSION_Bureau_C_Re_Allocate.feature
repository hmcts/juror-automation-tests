Feature: Bureau C Test
	
@RegressionSingle 
Scenario Outline: Bureau C script

	Given I am on "Bureau" "test"

	And pool no "<pool_no>" is reset to pending allocation
	And I have cleared down the juror digital database
	Given the juror numbers have not been processed
		| part_no 			| pool_no 	| owner |
		| <part_no> 		|<pool_no>	| 400 	|
		| <part_no_two> 	|<pool_no>	| 400 	|
		| <part_no_three> 	|<pool_no>	| 400 	|
	
	Given auto straight through processing has been enabled new schema
	
	And "<juror_number>" has "RET_DATE" as "6 mondays time"
	And "<juror_number>" has "NEXT_DATE" as "6 mondays time"
	And juror "<juror_number>" has "LAST_NAME" as "<last_name>" new schema
	And juror "<juror_number>" has "POSTCODE" as "<postcode>" new schema
	
	And "<part_no_two>" has "RET_DATE" as "6 mondays time"
	And "<part_no_two>" has "NEXT_DATE" as "6 mondays time"
	And "<part_no_two>" has "LNAME" as "<last_name>" 
	And "<part_no_two>" has "ZIP" as "<postcode>"
	
	And "<part_no_three>" has "RET_DATE" as "6 mondays time"
	And "<part_no_three>" has "NEXT_DATE" as "6 mondays time"
	And "<part_no_three>" has "LNAME" as "<last_name>" 
	And "<part_no_three>" has "ZIP" as "<postcode>"

	Given I have submitted a first party English ineligibilty response
		| part_no			|pool_number	| last_name			|postcode		| email 	|details	|
		|<part_no>			|<pool_no>		| <last_name>		|<postcode>		|<email>	|<details>	|
		|<part_no_two>		|<pool_no>		| <last_name>		|<postcode>		|<email>	|<details>	|
		|<part_no_three>	|<pool_no>		| <last_name>		|<postcode>		|<email>	|<details>	|
		
	Given I am on "Bureau" "test"
	
	When I log in
	And I click on the "Assign Replies" link
	
	#And I see "3" in the same row as "Non urgent" in Backlog box
	And I set input field with "name" of "allocateNonUrgent" to "3"
	When I check the "ARAMIS1" checkbox
	And I press the "Assign replies" button
	
	When I click on the "Search" link
	And I set "Juror number" to "<juror_number>"
	And I press the "Search" button
	
	And I press the "Select all" button
	And I press the "Send to..." button
	And I set input field with "id" of "sendToOfficer" to "MODTESTBUREAU"
	And I press the "Send" button
	And I press the "Send" button
	Then I see "Your work" on the page
	Then I see "<juror_number>" in the same row as "<juror_number>"
	When I click on the "To do" link
	
	# Proves that I have sent from Backlog to SYSTEM/Logged in USer
	
	When I click on "<juror_number>" in the same row as "<juror_number>"
	Then I press the "More actions" button
	And I click on the "Send to a colleague" link
	
	#check error if no name input
	
	Then I see "to a colleague" on the page
	And I press the "Send" button
	And I see "Select an officer to send this reply to" on the page
	
	And I set input field with "id" of "sendToOfficer" to "ARAMIS1"
	And I press the "Send" button
	And I press the "Send" button
	Then I see "Your work" on the page
	Then I see "To do" on the page
	Then I do not see "<juror_number>" on the page
	
	When I click on the "Search" link
	And I set "Juror number" to "<juror_number>"
	And I press the "Search" button
	And I press the "Select all" button
	And I press the "Send to" button
	And I set input field with "id" of "sendToOfficer" to "ARAMIS1"
	And I press the "Send" button
	And I press the "Send" button
	Then I see "Your work" on the page
	
	And I click on the "Sign out" link

	Given I am on "Bureau" "test"
	And I log in as "ARAMIS1"
	Then I see "<juror_number>" on the page

	When I click on "<juror_number>" in the same row as "<juror_number>"
	Then I press the "More actions" button
	And I click on the "Send to a colleague" link
	And I set input field with "id" of "sendToOfficer" to "MODTESTBUREAU"
	And I press the "Send" button
	And I press the "Send" button
	Then I see "Your work" on the page
	Then I do not see "<juror_number>" on the page
	
	And I click on the "Sign out" link

	Given I am on "Bureau" "test"
	And I log in
	Then I see "<juror_number>" on the page
	
	When I click on the "Search" link
	And I set "Juror's pool number" to "<pool_no>"
	And I press the "Search" button
	And I click on the "Select all" link
	And I press the "Send to..." button
	And I set input field with "id" of "sendToOfficer" to "ARAMIS1"
	And I press the "Send" button
	And I press the "Send" button
	Then I see "Your work" on the page
	
	And I click on the "Sign out" link

	Given I am on "Bureau" "test"
	And I log in as "ARAMIS1"
	Then I see "<juror_number>" on the page
	Then I see "<part_no_two>" on the page
	Then I see "<part_no_three>" on the page
	
	And I click on the "Sign out" link
	
	Given I am on "Bureau" "test"
	And I log in
	When I click on the "Search" link
	And I set "Juror's pool number" to "<pool>"
	And I click on the "Advanced search" link
	And I check the "To do" checkbox
	And I press the "Search" button
	And I press the "Select all" button
	And I press the "Send to" button
	And I set input field with "id" of "sendToOfficer" to "Return to unass"
	And I press the "Send" button
	And I press the "Send" button
	Then I see "Your work" on the page
	
	And I click on the "Sign out" link

	Given I am on "Bureau" "test"
	And I log in as "CPASS"
	Then I do not see "<juror_number>" on the page
	Then I do not see "<part_no_two>" on the page
	Then I do not see "<part_no_three>" on the page
	
	
	
	#And I send to Backlog
	
	## New Replies cannot be assigned to the backlog if they are assigned to the current user
	
	
#Expected Result
#Step 1	
#Search for a response which is in the backlog (New Replies), and assign it to a team member
#Response assigned.
#Step 2	
#Select a response from your Team Leader's To Do list, and assign it to New Replies
#Response sent to New Replies.
#Step 3	
#Select a response from the backlog (New Replies), and assign it to another team member
#Response reassigned to another team member successfully.
#Step 4	
#Select a response from your To Do list and assign to your team leader
#Response assigned to team leader.
#Step 5	
#Logged in as a Team Leader Do a search which returns multiple responses, Select All and reassign to another team member
#Multiple responses assigned to team member.
#Step 6	
#Do a search which returns multiple responses, Select All and reassign to backlog

	
Examples:
	|part_no 	|part_no_two|part_no_three	|pool_no	|last_name		|postcode	|email				|details	|
	|641500613	|641500616	|641500618		|415170401	|LNAMEEIGHTFOUR	|CH1 2AN	|email@bureauA.com	|12345abcde	|
	