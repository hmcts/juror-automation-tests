Feature: Expenses_Welsh_JDB-4327

@JDB-4327 @expenses
Scenario: expensesJDB-4327 Welsh Start Page
	
	Given I am on the Welsh version of expenses on "expenses" "juror-test01"
	
	Then I see "Gwiriwch beth allwch chi ei hawlio ar gyfer gwasanaethu ar reithgor" on the page
	And I see "Defnyddiwch yr adnodd hwn i gyfrifo beth allwch chi ei hawlio am wasanaethu ar reithgor am 10 diwrnod." on the page
	And I see "Mae'r adnodd hwn:" on the page
	And I see "yn rhoi amcangyfrif ichi o'r hyn y gallwch ei hawlio" on the page
	And I see "er gwybodaeth ichi yn unig" on the page
	And I see "ni fydd yn anfon hawliad / eich manylion i'r llys" on the page
	And I see "Bydd rhaid ichi wneud hawliad trwy lenwi ffurflen bapur ar ddiwrnod olaf eich gwasanaeth rheithgor." on the page
	And I see "Cyn ichi ddechrau" on the page
	And I see "Byddwch angen manylion am:" on the page
	And I see "eich incwm" on the page
	And I see "y swm rydych yn rhagweld y byddwch yn ei wario i deithio i'r llys" on the page
	And I see "treuliau eraill fel costau gofal plant neu gostau gofalu am rywun arall" on the page

	And I see "All content is available under the Open Government Licence v3.0, except where otherwise stated" on the page
	Then I press the "Cychwyn arni" button
	Then I see "A fyddwch yn colli unrhyw incwm wrth ichi wasanaethu ar reithgor?" on the page
