Feature: JM-3721 Awaiting Translation

@JurorTransformationMulti
Scenario Outline: JM-3721 As Court User, set Paper Response status as Awaiting Translation

	Given I am on "Bureau" "ithc"

	Given a bureau owned pool is created with jurors
		| court | juror_number  	    | pool_number	    | att_date_weeks_in_future	| owner |
		| 457   | <juror_number> 	    | <pool_number>     | 7				            | 400	|

	Then a new pool is inserted for where record has transferred to the court new schema
		| part_no   	| pool_no   	| owner |
		| <juror_number>| <pool_number> | 457   |

	And I log in as "<user>" selecting court "457"

	And the user searches for juror record "<juror_number>" from the global search bar

	#record paper summons response
	And I click the Enter summons reply button
	Then the juror details form is displayed

	#juror details + welsh
	When I fill in all of the juror details for the summons reply
	Then I select that the juror wants communications in Welsh
	And I click continue on the juror summons reply page

	#eligibility
	Then the juror summons reply eligibility page is displayed
	When I answer the juror summons reply eligibility questions
	And I click continue on the juror summons reply page

	#can attend on date
	Then the juror summons reply types page is displayed
	When I select that the juror can serve on the summons date
	And I click continue on the juror summons reply page

	#cjs
	Then the juror summons reply CJS employment page is displayed
	When I select that the juror has not worked in the criminal justice system
	And I click continue on the juror summons reply page

	#reasonable adjustments
	Then the juror summons reply reasonable adjustments page is displayed
	When I select that the juror does not need adjustments
	And I click continue on the juror summons reply page

	#confirm/sign
	Then the juror summons reply Signature page is displayed
	When I select that the summons reply has been signed
	And I click done on the juror summons reply page
	And I click on the "No, skip and process later" link
	Then the view summons reply page is displayed

	And I see the reply status has updated to "To Do"

	#check DB
#	Then on "JUROR_MOD" . "PAPER_RESPONSE" I see "WELSH" is "Y" where "JUROR_NUMBER" is "<juror_number>"

	#now mark as awaiting translation
	And I press the "Mark as awaiting information" button
	Then I see "Who are you waiting for information from?" on the page
	And I mark this reply as awaiting information from "Translation unit"
	Then I press the "Confirm" button
	And I see the reply status has updated to "Awaiting Translation"

	And I click on the "Sign out" link

	Examples:
		| user    | juror_number| pool_number   |
		| SWANSEA | 045700121 	| 457300221 	|

	@JurorTransformationMulti
	Scenario Outline: JM-3721 As Court User, set Paper Response status as Awaiting Translation - errors and warnings

	Given I am on "Bureau" "ithc"

	Given a bureau owned pool is created with jurors
			| court | juror_number  	    | pool_number	    | att_date_weeks_in_future	| owner |
			| 457   | <juror_number> 	    | <pool_number>     | 7				            | 400	|

	Then a new pool is inserted for where record has transferred to the court new schema
			| part_no   		| pool_no   	| owner |
			| <juror_number> 	| <pool_number> | 457   |

	And I log in as "<user>" selecting court "457"

	#view the record
	And the user searches for juror record "<juror_number>" from the global search bar

	#record paper summons response
	And I click the Enter summons reply button
	Then the juror details form is displayed

	#juror details + welsh
	When I fill in all of the juror details for the summons reply
	Then I select that the juror wants communications in Welsh
	And I click continue on the juror summons reply page

	#eligibility
	Then the juror summons reply eligibility page is displayed
	When I answer the juror summons reply eligibility questions
	And I click continue on the juror summons reply page

	#can attend on date
	Then the juror summons reply types page is displayed
	When I select that the juror can serve on the summons date
	And I click continue on the juror summons reply page

	#cjs
	Then the juror summons reply CJS employment page is displayed
	When I select that the juror has not worked in the criminal justice system
	And I click continue on the juror summons reply page

	#reasonable adjustments
	Then the juror summons reply reasonable adjustments page is displayed
	When I select that the juror does not need adjustments
	And I click continue on the juror summons reply page

	#confirm/sign
	Then the juror summons reply Signature page is displayed
	When I select that the summons reply has been signed
	And I click done on the juror summons reply page
	And I click on the "No, skip and process later" link
	Then the view summons reply page is displayed

	And I see the reply status has updated to "To Do"

	#check DB
#	Then on "JUROR_MOD" . "PAPER_RESPONSE" I see "WELSH" is "Y" where "JUROR_NUMBER" is "<juror_number>"

	#now mark as awaiting translation
	And I click the More Actions button
#	And I click on the "Mark as awaiting information" link
	Then I see "Who are you waiting for information from?" on the page

	#errors and warnings
	Then I press the "Confirm" button
	And I see "re waiting for information from either the juror, court or translation unit" on the page

	And I mark this reply as awaiting information from "Translation unit"
	Then I press the "Confirm" button
	And I see the reply status has updated to "Awaiting Translation"
	
	When I click on the "View juror's record" link
	When I click on the "Juror details" link
	Then I see "Yes" in the same row as "Welsh language"
	When I click on the "Add or change" link
	Then I see "Tick box if juror should get communications in Welsh (optional)" on the page
	And "Yes, send Welsh language communications" is checked

	Examples:
		| user      | juror_number  | pool_number   |
		| SWANSEA 	| 045700120 	| 457300220  	|

	@JurorTransformationMulti
	Scenario Outline: JM-3721 As Court User, set Paper Response status as Awaiting Translation - navigation

		Given I am on "Bureau" "ithc"

		Given a bureau owned pool is created with jurors
			| court | juror_number  	    | pool_number	    | att_date_weeks_in_future	| owner |
			| 457   | <juror_number> 	    | <pool_number>     | 7				            | 400	|

		Then a new pool is inserted for where record has transferred to the court new schema
			| part_no   	 | pool_no   	 | owner |
			| <juror_number> | <pool_number> | 457   |

		And I log in as "<user>" selecting court "457"

	#view the record
		And the user searches for juror record "<juror_number>" from the global search bar

	#record paper summons response
		And I click the Enter summons reply button
		Then the juror details form is displayed

	#juror details + welsh
		When I fill in all of the juror details for the summons reply
		Then I select that the juror wants communications in Welsh
		And I click continue on the juror summons reply page

	#eligibility
		Then the juror summons reply eligibility page is displayed
		When I answer the juror summons reply eligibility questions
		And I click continue on the juror summons reply page

	#can attend on date
		Then the juror summons reply types page is displayed
		When I select that the juror can serve on the summons date
		And I click continue on the juror summons reply page

	#cjs
		Then the juror summons reply CJS employment page is displayed
		When I select that the juror has not worked in the criminal justice system
		And I click continue on the juror summons reply page

	#reasonable adjustments
		Then the juror summons reply reasonable adjustments page is displayed
		When I select that the juror does not need adjustments
		And I click continue on the juror summons reply page

	#confirm/sign
		Then the juror summons reply Signature page is displayed
		When I select that the summons reply has been signed
		And I click done on the juror summons reply page
		And I click on the "No, skip and process later" link
		Then the view summons reply page is displayed

		And I see the reply status has updated to "To Do"

	#check DB
#	Then on "JUROR_MOD" . "PAPER_RESPONSE" I see "WELSH" is "Y" where "JUROR_NUMBER" is "<juror_number>"

	#now mark as awaiting translation
		And I click the More Actions button
		Then I see "Who are you waiting for information from?" on the page

	#navigation - cancel
		Then I click on the "Cancel" link
		Then the view summons reply page is displayed

	#now mark as awaiting translation
		And I click the More Actions button
		Then I see "Who are you waiting for information from?" on the page

	#navigation - select different buttons
		And I mark this reply as awaiting information from "Translation unit"
		Then the radio button "Translation unit" is "selected"
		And the radio button "Court" is "unselected"
		And the radio button "Juror" is "unselected"

		And I mark this reply as awaiting information from "Court"
		Then the radio button "Translation unit" is "unselected"
		And the radio button "Court" is "selected"
		And the radio button "Juror" is "unselected"

		And I mark this reply as awaiting information from "Juror"
		Then the radio button "Translation unit" is "unselected"
		And the radio button "Court" is "unselected"
		And the radio button "Juror" is "selected"

		And I mark this reply as awaiting information from "Translation unit"
		Then I press the "Confirm" button
		And I see the reply status has updated to "Awaiting Translation"

		Examples:
			| user    | juror_number   	| pool_number   |
			| SWANSEA | 045700122 		| 457300222  	|