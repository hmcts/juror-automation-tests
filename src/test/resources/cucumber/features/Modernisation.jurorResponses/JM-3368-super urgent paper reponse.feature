Feature: JM-3368 Super Urgent Paper Response Court

	@JurorTransformationMulti
	Scenario Outline: JM-3368 As Court User, record urgent UNHAPPY PATH Paper Response

		Given I am on "bureau" "ithc"
		Given a bureau owned pool is created with jurors
			| court | juror_number  	| pool_number	    | att_date_weeks_in_future	| owner |
			| 415   | <juror_number> 	| <pool_number>     | 1				            | 400	|

		Then a new pool is inserted for where record has transferred to the court new schema
			|part_no              | pool_no           | owner |
			|<juror_number>       | <pool_number>     | 415   |

		And "<juror_number>" has "NEXT_DATE" as "1 mondays time" new schema

		And I log in as "<user>"

		When the user searches for juror record "<juror_number>" from the global search bar

		#record unhappy path paper summons
#record paper summons response
		And I click the Enter summons reply button
		Then the juror details form is displayed

    #juror details
		When I fill in all of the juror details for the summons reply
		And I click continue on the juror summons reply page

    #eligibility
		And I click continue on the juror summons reply page

    #can attend on date
		And I click continue on the juror summons reply page

   #cjs
		And I click continue on the juror summons reply page

#reasonable adjustments
		Then the juror summons reply reasonable adjustments page is displayed
		When I select that the juror does need adjustments
		And I select "C - Caring Responsibilities" from the adjustments reason dropdown
		And I set "What help does the juror need at court?" to "Reasonable adjustments reasons"

		And I click continue on the juror summons reply page

#confirm/sign
		Then the juror summons reply Signature page is displayed
		And I set the radio button to "No"
		And I click done on the juror summons reply page

		And I see the reply "status" on the response is "To Do"
		And I see the reply "type" on the response is "Ineligible"
		And I do not see "URGENT" on the page
		And I see "Summons reply is missing essential information - reply cannot be processed until this information is entered." in the response banner

		And I click on the "Sign out" link

		Examples:
			|user			|juror_number	|pool_number	|
			|MODTESTCOURT	|045200829	    |415170488	    |
