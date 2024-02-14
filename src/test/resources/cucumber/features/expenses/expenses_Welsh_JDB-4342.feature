Feature: Expenses_Welsh_JDB-4342

@expenses @JDB-4342
Scenario: expensesJDB-4342 will parking costs be paid Welsh

	Given I am on the Welsh version of expenses on "expenses" "juror-test01"
	
	Then I press the "Cychwyn arni" button
	
	Then I set the radio button to "Na fyddaf"
	When I press the "Parhau" button
	Then I set the radio button to "Bydd"
	When I press the "Parhau" button
	Then I set "£" to "1000,00"	
	When I press the "Parhau" button
	When I check the "Car" checkbox
	When I press the "Parhau" button
	Then I set "Milltiroedd y dydd" to "10.2"
	When I press the "Parhau" button
	Then I set the radio button to "Bydd"
	When I press the "Parhau" button
	
	And I see "Hawlio costau parcio" on the page
	And I see "Ni fydd pob llys yn talu am gostau parcio. Gall fod uchafswm y bydd y llys yn talu fesul dydd. Cysylltwch â'r llys i gael caniatâd cyn gwneud hawliad am gostau parcio." on the page
	When I press the "Parhau" button
	
	Then I see "Gwiriwch beth allwch chi ei hawlio ar gyfer gwasanaethu ar reithgor" on the page
	
	#footer
	
	And I see "All content is available under the Open Government Licence v3.0, except where otherwise stated" on the page
	And I see "Cwcis" on the page
	And I do not see "Polisi preifatrwydd" on the page
	
	#continue
	
	When I press the "Parhau" button
	Then I see "Cychwyn eto" on the page
	
