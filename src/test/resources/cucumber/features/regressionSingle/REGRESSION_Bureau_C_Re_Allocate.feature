Feature: Bureau C Test
	
@Features @NewSchemaConverted @JM-7246
Scenario Outline: Bureau C script

	#return to @RegressionSingle wqhen defect fixed

	Given I am on "Bureau" "test"

	Given a bureau owned pool is created with jurors
		| court | juror_number  			| pool_number	| att_date_weeks_in_future	| owner |
		| 452   | <juror_number_one>		| <pool_number>	| 6				            | 400	|
		| 452   | <juror_number_two>		| <pool_number>	| 6				            | 400	|
		| 452   | <juror_number_three>		| <pool_number>	| 6				            | 400	|

	And juror "<juror_number_one>" has "LAST_NAME" as "<last_name>" new schema
	And juror "<juror_number_one>" has "POSTCODE" as "<postcode>" new schema

	And juror "<juror_number_two>" has "LAST_NAME" as "<last_name>" new schema
	And juror "<juror_number_two>" has "POSTCODE" as "<postcode>" new schema

	And juror "<juror_number_three>" has "LAST_NAME" as "<last_name>" new schema
	And juror "<juror_number_three>" has "POSTCODE" as "<postcode>" new schema

	Given auto straight through processing has been enabled new schema

	Given I have submitted a first party English ineligibilty response
		| part_no				| pool_number	| last_name			|postcode		| email 	|details	|
		| <juror_number_one>	| <pool_number>	| <last_name>		|<postcode>		|<email>	|<details>	|
		| <juror_number_two>	| <pool_number>	| <last_name>		|<postcode>		|<email>	|<details>	|
		| <juror_number_three>	| <pool_number>	| <last_name>		|<postcode>		|<email>	|<details>	|

	Given I am on "Bureau" "test"
	
	When I log in as "CPASS"
	And I click on the "Assign Replies" link

	And I assign all the New Replies to "ARAMIS1"
	
	When I click on the "Search" link
	And I set "Juror number" to "<juror_number_one>"
	And I press the "Search" button
	
	And I press the "Select all" button
	And I press the "Send to..." button
	And I set input field with "id" of "sendToOfficer" to "CPASS"
	And I press the "Send" button
	And I press the "Send" button
	Then I click on the "Your work" link
	Then I see "<juror_number_one>" in the same row as "<juror_number_one>"
	When I click on the "To do" link
	
	# Proves that I have sent from Backlog to SYSTEM/Logged in USer
	
	When I click on "<juror_number_one>" in the same row as "<juror_number_one>"
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
	And I set "Juror number" to "<juror_number_one>"
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
	Then I see "<juror_number_one>" on the page

	When I click on "<juror_number_one>" in the same row as "<juror_number_one>"
	Then I press the "More actions" button
	And I click on the "Send to a colleague" link
	And I set input field with "id" of "sendToOfficer" to "MODTESTBUREAU"
	And I press the "Send" button
	And I press the "Send" button
	Then I see "Your work" on the page
	Then I do not see "<juror_number_one>" on the page
	
	And I click on the "Sign out" link

	Given I am on "Bureau" "test"
	And I log in as "MODTESTBUREAU"
	Then I see "<juror_number_one>" on the page
	
	When I click on the "Search" link
	And I set "Juror's pool number" to "<pool_number>"
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
	Then I see "<juror_number_one>" on the page
	Then I see "<juror_number_two>" on the page
	Then I see "<juror_number_three>" on the page
	
	And I click on the "Sign out" link
	
	Given I am on "Bureau" "test"
	And I log in as "MODTESTBUREAU"
	When I click on the "Search" link
	And I set "Juror's pool number" to "<pool_number>"

	#JM-7246
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
	Then I do not see "<juror_number_one>" on the page
	Then I do not see "<juror_number_two>" on the page
	Then I do not see "<juror_number_three>" on the page

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
	| juror_number_one 	| juror_number_two	| juror_number_three	| pool_number	| last_name			| postcode	| email				| details		|
	| 045200242			| 045200243			| 045200244			| 452300221		| LNAMEEIGHTFOUR	| CH1 2AN	| email@bureauA.com	| 12345abcde	|
	