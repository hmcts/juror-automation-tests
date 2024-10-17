Feature: Expenses_WelshJDB-4338

@expenses @JDB-4338 
Scenario: expensesJDB-4338 Travel to Court Welsh
	
	Given I am on the Welsh version of expenses on "expenses" "juror-test01"
	
	Then I press the "Cychwyn arni" button
	
	Then I set the radio button to "Na fyddaf"
	When I press the "Parhau" button
	Then I set the radio button to "Bydd"
	When I press the "Parhau" button
	Then I set "£" to "1000,00"	
	When I press the "Parhau" button
	
	#footer
	
	And I see the Gov licence description on the page
	And I see "Cwcis" on the page
	And I do not see "Polisi preifatrwydd" on the page
	
	#Back link
	
	And I click on the "Cliciwch i fynd yn ôl" link
	Then I see "A fydd gwasanaethu ar reithgor yn golygu y bydd gennych gostau ychwanegol na fyddai'n codi fel arfer?" on the page
	When I press the "Parhau" button
	When I press the "Parhau" button
	
	#page text
	
	Then I see "Gwiriwch beth allwch chi ei hawlio ar gyfer gwasanaethu ar reithgor" on the page
	Then I see "Sut byddwch yn teithio i'r llys?" on the page
	And I see "Dewiswch bob un sy'n berthnasol. Er enghraifft, efallai y byddwch angen gyrru i orsaf cyn defnyddio trafnidiaeth gyhoeddus." on the page
	Then I click on the "Tacsis" link
	And I see "Fel arfer, ni allwch hawlio costau tacsi. Os nad oes gennych unrhyw ddewis arall oni bai am gael tacsi i ddod i'r llys, cysylltwch â'r llys i drafod hyn." on the page
	
	#errors if Continue pressed with no input
	
	When I press the "Parhau" button

    And under the "There is a problem" heading I see "Dewiswch o leiaf un dull ar gyfer teithio i'r llys"
	Then I see "Dewiswch o leiaf un dull ar gyfer teithio i'r llys" on the page
	
	#check all boxes
	
	When I check the "Beic" checkbox
	When I check the "Car" checkbox
	When I check the "Beic modur" checkbox
	When I check the "Trafnidiaeth gyhoeddus" checkbox
	When I check the "Cerdded" checkbox
	Then "Beic" is checked
	Then "Car" is checked
	Then "Beic modur" is checked
	Then "Trafnidiaeth gyhoeddus" is checked
	Then "Cerdded" is checked
	
	#uncheck all boxes
	
	When I uncheck the "Beic" checkbox
	When I uncheck the "Car" checkbox
	When I uncheck the "Beic modur" checkbox
	When I uncheck the "Trafnidiaeth gyhoeddus" checkbox
	When I uncheck the "Cerdded" checkbox
	Then "Beic" is unchecked
	Then "Car" is unchecked
	Then "Beic modur" is unchecked
	Then "Trafnidiaeth gyhoeddus" is unchecked
	Then "Cerdded" is unchecked
	
	#check 2 boxes
	When I check the "Cerdded" checkbox
	When I check the "Trafnidiaeth gyhoeddus" checkbox
	
	#continue
	
	When I press the "Parhau" button
	Then I see "Cyfanswm cost trafnidiaeth gyhoeddus fesul dydd" on the page

