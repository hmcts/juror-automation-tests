Feature: Expenses_Welsh_JDB-4341

@expenses @JDB-4341
Scenario: expensesJDB-4341 Parking - how much Welsh
	
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
	
	#footer
	
	And I see "All content is available under the Open Government Licence v3.0, except where otherwise stated" on the page
	And I see "Cwcis" on the page
	And I do not see "Polisi preifatrwydd" on the page
	
	#Back link
	
	And I click on the "Cliciwch i fynd yn ôl" link
	Then I see "Sut byddwch yn teithio i'r llys?" on the page
	When I press the "Parhau" button
	
	#page text
	
	And I see "Gwiriwch beth allwch chi ei hawlio ar gyfer gwasanaethu ar reithgor" on the page
	Then I see "A fydd rhaid i chi dalu costau parcio?" on the page

	#none selected by default
	
	And the radio button "Bydd" is "unselected"
	And the radio button "Na fydd" is "unselected"
	
	#errors if Continue pressed with none selected
	
	When I press the "Parhau" button

    And under the "Mae problem" heading I see "Dewiswch bydd neu na fydd"
	Then I see "Dewiswch bydd neu na fydd" on the page
	
	#Select Yes
	
	Then I set the radio button to "Bydd"
	Then the radio button "Bydd" is "selected"
	Then the radio button "Na fydd" is "unselected"

	#Select No
	
	Then I set the radio button to "Na fydd"
	Then the radio button "Na fydd" is "selected"
	Then the radio button "Bydd" is "unselected"
	
	#continue
	
	When I press the "Parhau" button
	Then I see "Gwiriwch eich atebion" on the page

