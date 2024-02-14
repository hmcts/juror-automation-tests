Feature: JM-3368 Super Urgent Paper Response Court

	@JurorTransformationWIP @NewSchemaConverted @5471
	Scenario Outline: JM-3368 As Court User, record super urgent UNHAPPY PATH Paper Response

		Given I am on "bureau" "test"
		Given the juror numbers have not been processed new schema
			|part_no   | pool_no   | owner |
			|<part_no> | <pool_no> | 400   |

		Then a new pool is inserted for where record has transferred to the court new schema
			|part_no   | pool_no   | owner |
			|<part_no> | <pool_no> | 415   |


		And "<part_no>" has "NEXT_DATE" as "1 mondays time" new schema

		And I log in as "<user>"

		When the user searches for juror record "<part_no>" from the global search bar

		#record unhappy path paper summons
		And I record an unhappy path paper summons response

		And I see the reply "status" on the response is "TO DO"
		And I see the reply "type" on the response is "INELIGIBLE"
		And I see the super urgent flag
		And I see "Summons reply is missing essential information - reply cannot be processed until this information is entered." in the response banner

		And I click on the "Sign out" link

		Examples:
			|user			|part_no	|pool_no	|
			|MODTESTCOURT	|641500412	|415170402	|
