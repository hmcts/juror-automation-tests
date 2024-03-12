Feature: JM-3721 Awaiting Translation

@JurorTransformationMulti @NewSchemaConverted
Scenario Outline: JM-3721 As Court User, set Paper Response status as Awaiting Translation

	Given I am on "Bureau" "test"

	Given the juror numbers have not been processed new schema
		|part_no   | pool_no   | owner |
		|<part_no> | <pool_no> | 400   |


	And "<juror_number>" has "NEXT_DATE" as "7 mondays time" new schema

	Then a new pool is inserted for where record has transferred to the court new schema
		|part_no   | pool_no   | owner |
		|<part_no> | <pool_no> | 415   |

	And I log in as "<user>"

	#view the record
	Then I set "Search for a juror record" to "<juror_number>"
	When I press the "Search" button
	And I am on the court Juror Record for juror "<juror_number>"

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

	And I see the reply status has updated to "TO DO"

	#check DB
#	Then on "JUROR_MOD" . "PAPER_RESPONSE" I see "WELSH" is "Y" where "JUROR_NUMBER" is "<juror_number>"

	#now mark as awaiting translation
	And I click the More Actions button
	And I click Awaiting Information
	Then I see "Who are you waiting for information from?" on the page
	And I mark this reply as awaiting information from "Translation unit"
	Then I press the "Confirm" button
	And I see the reply status has updated to "AWAITING TRANSLATION"

	And I click on the "Sign out" link

	Examples:
		| user          | part_no   | pool_no   |
		| MODTESTCOURT | 641500685 | 415170501 |

	@JurorTransformationMulti @NewSchemaConverted
	Scenario Outline: JM-3721 As Court User, set Paper Response status as Awaiting Translation - errors and warnings

		Given I am on "Bureau" "test"

		Given the juror numbers have not been processed new schema
			|part_no   | pool_no   | owner |
			|<part_no> | <pool_no> | 400   |


		And "<juror_number>" has "NEXT_DATE" as "7 mondays time" new schema

		Then a new pool is inserted for where record has transferred to the court new schema
			|part_no   | pool_no   | owner |
			|<part_no> | <pool_no> | 415   |

		And I log in as "<user>"

	#view the record
		Then I set "Search for a juror record" to "<juror_number>"
		When I press the "Search" button
		And I am on the court Juror Record for juror "<juror_number>"

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

	And I see the reply status has updated to "TO DO"

	#check DB
#	Then on "JUROR_MOD" . "PAPER_RESPONSE" I see "WELSH" is "Y" where "JUROR_NUMBER" is "<juror_number>"

	#now mark as awaiting translation
	And I click the More Actions button
	And I click Awaiting Information
	Then I see "Who are you waiting for information from?" on the page

	#errors and warnings
	Then I press the "Confirm" button
	And I see "re waiting for information from either the juror, court or translation unit" on the page

	And I mark this reply as awaiting information from "Translation unit"
	Then I press the "Confirm" button
	And I see the reply status has updated to "AWAITING TRANSLATION"

	And I click on the "Sign out" link

		Examples:
			| user          | part_no   | pool_no   |
			| MODTESTCOURT | 641500687 | 415170402  |

	@JurorTransformationMulti @NewSchemaConverted
	Scenario Outline: JM-3721 As Court User, set Paper Response status as Awaiting Translation - navigation

		Given I am on "Bureau" "test"

		Given the juror numbers have not been processed new schema
			|part_no   | pool_no   | owner |
			|<part_no> | <pool_no> | 400   |


		And "<juror_number>" has "NEXT_DATE" as "7 mondays time" new schema

		Then a new pool is inserted for where record has transferred to the court new schema
			|part_no   | pool_no   | owner |
			|<part_no> | <pool_no> | 415   |

		And I log in as "<user>"

	#view the record
		Then I set "Search for a juror record" to "<juror_number>"
		When I press the "Search" button
		And I am on the court Juror Record for juror "<juror_number>"

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

		And I see the reply status has updated to "TO DO"

	#check DB
#	Then on "JUROR_MOD" . "PAPER_RESPONSE" I see "WELSH" is "Y" where "JUROR_NUMBER" is "<juror_number>"

	#now mark as awaiting translation
		And I click the More Actions button
		And I click Awaiting Information
		Then I see "Who are you waiting for information from?" on the page

	#navigation - cancel
		Then I click on the "Cancel" link
		Then the view summons reply page is displayed

	#now mark as awaiting translation
		And I click the More Actions button
		And I click Awaiting Information
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
		And I see the reply status has updated to "AWAITING TRANSLATION"

		And I click on the "Sign out" link

		Examples:
			| user          | part_no   | pool_no   |
			| MODTESTCOURT | 641500695 | 415170402  |