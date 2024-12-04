Feature: JM-251

	@JurorTransformationMulti
	Scenario Outline: Test to create a new pool of jurors to be summoned for jury duty as a bureau officer

	Given I am on "Bureau" "demo"

	Given a bureau owned pool is created with jurors
		| court 	| juror_number  	| pool_number	| att_date_weeks_in_future	| owner |
		| <court> 	| <juror_number> 	| <pool_number> | 5				            | 400	|

	Given I log in as "<user>"

	And I navigate to the pool request screen
	And I create a "<poolType>" court pool request for court "<court>" with "0" deferral

	Then I can see the newly created pool

	Given a deferral is inserted for an existing juror new schema
		| owner | pool_no   	| part_no    		| no_weeks| loc_code |
		| 400	| <pool_number> | <juror_number>  	| 9       | <court>  |

	When I select the pool that I have just created to move to the pool summary page
	Then the system will display non-editable information on the pool summary screen
		|jurorsRequested   |10		|
		|jurorsConfirmed   |0		|
		|jurorsSummoned	   |0		|
		|currentPoolSize   |0 /10	|
		|courtName		   |Chester	|
		|courtLocationCode |<court>	|
		|courtStartDate	   |		|

	And the pool summary donut displays
		|summoned		|0	|
		|required		|10|
		|confirmed		|0	|
		|unavailable	|0	|
		|notResponded	|0	|
		|surplus		|0	|

	And I see the pool status is REQUESTED

	# Can move to the summon citizens for pool screen
	And I press the "Summon jurors" button
	Then I should see the editable and non-editable information on the summon citizens for pool screen
		|jurorsRequested	|10	|
		|jurorsRequired		|9	|
		|courtCatchmentArea |<court>|
		|deferrals			|1		|

	#error if no value entered
	And I press the "Create pool and summon citizens" button
	Then I see "Enter the number of citizens to summon" on the page

	# Can see an error if the amount of citizens summoned is more than allowed
	When I set the number of users I want to summon to "5000"
	Then I should see an error stating the amount of citizens summoned is more than allowed

	# Can successfully submit a pool request
	When I set the number of users I want to summon to "9"

	#retrive pool
	When I click on the "Search" link
	When I search for pool number

	And I see the pool status is ACTIVE

	And the pool summary donut displays
		|summoned	  |10	|
		|required	  |10	|
		|confirmed	  |1	|
		|unavailable  |0	|
		|notResponded |9	|
		|surplus	  |0	|

	Examples:
		| user			| poolType | court | juror_number 	| pool_number  	|
		| MODTESTBUREAU	| Crown    | 415   | 041500014 		| 415300112		|

	@JurorTransformationMulti @NewSchemaConverted
	Scenario Outline: Test to create a new pool of jurors to be summoned for jury duty as a court officer
		Given I am on "Bureau" "test"

		And I log in as "<user>"

		And I navigate to the pool request screen

		And I create a "<poolType>" court pool request
		Then I can see the newly created pool

		When I select the pool that I have just created to move to the pool summary page

		Then the system will display non-editable information on the court version of the pool summary screen
			|jurorsRequested	|150		|
			|jurorsNeeded		|150		|
			|courtDeferralsUsed	|0			|
			|courtName			|Chester	|
			|courtLocationCode	|415		|
			|courtStartDate		|			|
		And I do not see "Jurors requested from Bureau" on the page

		And I see the pool status is REQUESTED

		And the Summon citizens button is not visible

		Examples:
			|user			|poolType |
			|MODTESTCOURT	|Crown    |