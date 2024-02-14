Feature: Expenses_Welsh_JDB-4374
	
@expenses @JDB-4374 
Scenario: expenses_Welsh_JDB-4374
	
	Given I am on the welsh version of "expenses" "juror-test01"
	
	#navigate to expenses page
	
	And I press the "Cychwyn arni" button
	
	#loseincome
	
	Then I set the radio button to "Byddaf"
	When I press the "Parhau" button
	
	#earnmorethan
	
	Then I see "Gwiriwch beth allwch chi ei hawlio ar gyfer gwasanaethu ar reithgor" on the page
	And I see "A ydych yn ennill mwy na £64.95 y dydd ar y dyddiau pan fyddwch yn gweithio?" on the page
	And I see "Os ydych yn ennill symiau gwahanol o arian ar ddyddiau gwahanol, defnyddiwch y swm mwyaf i ganfod beth yw'r uchafswm y gallwch ei hawlio." on the page
	
	#none selected by default
	
	And the radio button "Ydw" is "unselected"
	And the radio button "Nac ydw" is "unselected"
	
	#errors if Continue pressed with none selected
	
	When I press the "Parhau" button
	Then I see "Dewiswch ydw neu nac ydw" on the page	
	
	#Select Yes
	
	Then I set the radio button to "Ydw"
	Then the radio button "Ydw" is "selected"
	Then the radio button "Nac ydw" is "unselected"

	#Select No
	
	Then I set the radio button to "Nac ydw"
	Then the radio button "Nac ydw" is "selected"
	Then the radio button "Ydw" is "unselected"
	
	#footer
	
	And I see "All content is available under the Open Government Licence v3.0, except where otherwise stated" on the page
	And I see "Cwcis" on the page
	And I do not see "Polisi preifatrwydd" on the page
	
	#Back link
	
	Then I click on the "Cliciwch i fynd yn ôl" link
	And I see "A fyddwch yn colli unrhyw incwm wrth ichi wasanaethu ar reithgor?" on the page 

	Then I see "Parhau" on the page
	
