Feature: JM-3000 Assign to a colleague

@JurorTransformation @NewSchemaConverted
Scenario Outline: JM-3000 Assign Reply Happy Path

	#this test needs to stay in single threaded as it checks backlog counts which will be more dynamic in the multi threaded execution

	Given I am on "Bureau" "test"
	Given a bureau owned pool is created with jurors
		| court | juror_number   | pool_number   | att_date_weeks_in_future | owner |
		| 415   | <juror_number> | <pool_number> | 5                        | 400   |

	Given auto straight through processing has been enabled new schema

	Given I have submitted a first party English ineligibilty response
		| part_no        | pool_number   | last_name   | postcode   | email   | details   |
		| <juror_number> | <pool_number> | <last_name> | <postcode> | <email> | <details> |

	Given I am on "Bureau" "test"
	And I log in as "<user>"
	And I click on the "Assign Replies" link
	And I assign all the New Replies to "ARAMIS1"

	#view the assigned record
	When I click on the "Search" link
	And I set "Juror number" to "<juror_number>"
	And I press the "Search" button

	#Check it's assigned to ARAMIS1
	When I click on "<juror_number>" in the same row as "<juror_number>"
	And I am on the modernisation version of View Summons Reply
	And I see assigned to is "ARAMIS1"

	#now reassign to SYSTEM
	Then I press the "More actions" button
	And I click on the "Send to a colleague" link

	#check page content
	Then I see "Send this reply to a colleague" on the page
	And I see Reply from "<first_name> Changed"
	Then I click on the Select an officer to send to input field
	Then I see "ARAMIS1" on the page

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
	| juror_number | user          | pool_number | first_name | last_name | postcode | email             | details    |
	| 641500613    | MODTESTBUREAU | 415170401   | fname      | lname     | CH2 2AA  | email@bureauA.com | 12345abcde |

	@JurorTransformation @NewSchemaConverted
	Scenario Outline: JM-3000 Assign Reply Errors Warnings Validations

		#this test needs to stay in single threaded as it checks backlog counts which will be more dynamic in the multi threaded execution

		Given I am on "Bureau" "test"
		Given a bureau owned pool is created with jurors
			| court | juror_number       | pool_number   | att_date_weeks_in_future | owner |
			| 415   | <juror_number>     | <pool_number> | 5                        | 400   |
			| 415   | <juror_number_two> | <pool_number> | 5                        | 400   |


		Given auto straight through processing has been enabled new schema

		Given I have submitted a first party English ineligibilty response
			| part_no        | pool_number   | last_name   | postcode   | email   | details   |
			| <juror_number> | <pool_number> | <last_name> | <postcode> | <email> | <details> |

		Given I have submitted a first party English straight through response
			| part_no            | pool_number   | last_name       | postcode   | email   | details   |
			| <juror_number_two> | <pool_number> | <last_name_two> | <postcode> | <email> | <details> |

		Given I am on "Bureau" "test"
		And I log in as "<user>"
		And I click on the "Assign Replies" link

		And I assign all the New Replies to "ARAMIS1"

	#view the assigned record
		When I click on the "Search" link
		And I set "Juror number" to "<juror_number>"
		And I press the "Search" button

	#Check it's assigned to ARAMIS1
		When I click on "<juror_number>" in the same row as "<juror_number>"
		And I am on the modernisation version of View Summons Reply
		And I see assigned to is "ARAMIS1"

	#now reassign
		Then I press the "More actions" button
		And I click on the "Send to a colleague" link

	#check page content
		Then I see "Send this reply to a colleague" on the page
		And I see Reply from "<first_name> Changed"

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
		And I set "Juror number" to "<juror_number_two>"
		And I press the "Search" button

	#Check it's assigned to CPASS
		When I click on "<juror_number_two>" in the same row as "<juror_number_two>"
		And I am on the modernisation version of View Summons Reply
		Then I press the "More actions" button
		And I do not see link with text "Send to a colleague"
		And I see assigned to is "AUTO"

		And I click on the "Sign out" link

		Examples:
			| user          | pool_number | juror_number | juror_number_two | first_name | last_name | last_name_two | postcode | email             | details    |
			| MODTESTBUREAU | 415170401   | 641500613    | 641500616        | fname      | lname     | lname         | CH2 2AA  | email@bureauA.com | 12345abcde |

	