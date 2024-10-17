Feature: Expenses_Welsh_JDB-4336

@expenses @JDB-4336
Scenario: expensesJDB-4336 Additional Expenses Welsh
	
	Given I am on the Welsh version of expenses on "expenses" "juror-test01"
	
	Then I press the "Cychwyn arni" button
	
	Then I set the radio button to "Na fyddaf"
	When I press the "Parhau" button
		
	Then I see "Gwiriwch beth allwch chi ei hawlio ar gyfer gwasanaethu ar reithgor" on the page
	
	#footer
	
	And I see the Gov licence description on the page
	
	#page text
	
	Then I see "A fydd gwasanaethu ar reithgor yn golygu y bydd gennych gostau ychwanegol na fyddai'n codi fel arfer?" on the page
	And  I see "Cofiwch gynnwys costau gofal plant neu gostau gofal ar gyfer oedolyn hŷn neu oedolyn bregus. Gallwch ond hawlio am y costau ychwanegol sy'n codi wrth ichi wasanaethu ar reithgor ac nid y costau y byddech yn talu amdanynt fel arfer." on the page
	
	And I see "Peidiwch â chynnwys costau teithio. Byddwn yn gofyn ichi am y costau hynny yn hwyrach ymlaen." on the page
	And I see "Hawlio Treuliau ar gyfer gofal plant neu gofal ar gyfer oedolion hŷn / bregus" on the page
	         
	When I press the "Parhau" button
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
	Then I see "Sut byddwch yn teithio i'r llys?" on the page

