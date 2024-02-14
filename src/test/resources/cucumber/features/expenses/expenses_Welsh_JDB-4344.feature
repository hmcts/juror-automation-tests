Feature: Expenses_Welsh_JDB-4344

@expenses @JDB-4344 
Scenario: expenses-Welsh-JDB-4344 
	
	Given I am on the welsh version of "expenses" "juror-test01"
	
	Then I see "Gwiriwch beth allwch chi ei hawlio ar gyfer gwasanaethu ar reithgor" on the page
	
	And I press the "Cychwyn arni" button
		
	Then I set the radio button to "Byddaf"
	When I press the "Parhau" button
	Then I set the radio button to "Nac ydw"
	When I press the "Parhau" button
	Then I set "£ y dydd" to "25"
	When I press the "Parhau" button
	Then I set the radio button to "Bydd"
	When I press the "Parhau" button
	Then I set "£ y dydd" to "10"	
	When I press the "Parhau" button
	When I check the "Beic" checkbox
	When I check the "Car" checkbox
	When I check the "Beic modur" checkbox
	When I check the "Trafnidiaeth gyhoeddus" checkbox
	When I check the "Cerdded" checkbox
	When I press the "Parhau" button
	Then I set "Milltiroedd y dydd" to "2"	
	When I press the "Parhau" button
	Then I set "Milltiroedd y dydd" to "2"	
	When I press the "Parhau" button
	Then I set "Milltiroedd y dydd" to "2"	
	When I press the "Parhau" button
	Then I set the radio button to "Bydd"
	When I press the "Parhau" button
	When I press the "Parhau" button
	Then I set "Cost eich holl docynnau mewn £ fesul dydd" to "20"	
	When I press the "Parhau" button
	
	#page text

	Then I see "Gwiriwch eich atebion" on the page
	
	#footer
	
	And I see "All content is available under the Open Government Licence v3.0, except where otherwise stated" on the page
	And I see "Cwcis" on the page
	And I do not see "Polisi preifatrwydd" on the page
	
	#change lose income
	
	
    And I see "Gwiriwch eich atebion" on the page
    And I see "Colli enillion" on the page
    
	
	          	                 
	And I click on the "Newid" link in the same row as "A fyddwch yn colli incwm?"
	
	And I set the radio button to "Na fyddaf"
	When I press the "Parhau" button
	Then I see "Gwiriwch eich atebion" on the page
#	And I see text "Na fyddaf" in the same row as "A fyddwch yn colli incwm?"
	
	And I click on the "Newid" link in the same row as "A fyddwch yn colli incwm?"
	
	And I set the radio button to "Byddaf"
	When I press the "Parhau" button
	And I set the radio button to "Nac ydw"
	When I press the "Parhau" button
	Then I set "£ y dydd" to "25"	
	When I press the "Parhau" button
	Then I see "Gwiriwch eich atebio" on the page
#	And I see text "Ydw" in the same row as "A fyddwch yn colli incwm?"
	
	#change how much do you earn
	
#	And I see text "Nac ydw" in the same row as "A ydych yn ennill mwy na £64.95 y dydd?"
#	And I see text "25.00" in the same row as "Faint ydych chi'n ennill fesul dydd?"
	And I click on the "Newid" link in the same row as "Faint ydych chi'n ennill fesul dydd?"
	
	And I set "£ y dydd" to "30"
	When I press the "Parhau" button
	Then I see "Gwiriwch eich atebion" on the page
#	And I see text "30.00" in the same row as "Faint ydych chi'n ennill fesul dydd?"
	
	#change extra costs
	
	And I see "Treuliau eraill" on the page
#	And I see text "Ydw" in the same row as "A oes gennych gostau ychwanegol na fyddai'n codi fel arfer?"
	And I click on the "Newid" link in the same row as "A oes gennych gostau ychwanegol na fyddai'n codi fel arfer?"
	
	And I set the radio button to "Na fydd"
	When I press the "Parhau" button
	Then I see "Gwiriwch eich atebion" on the page
#	And I see text "No" in the same row as "A oes gennych gostau ychwanegol na fyddai'n codi fel arfer?"
	
	#change travel types
	
	And I see "Teithio" on the page
#	And I see text "Beic ,Car,Beic modur ,Trafnidiaeth gyhoeddus ,Cerdded " in the same row as "Sut byddwch yn teithio i'r llys?"
	And I click on the "Newid" link in the same row as "Sut byddwch yn teithio i'r llys?"
	
	And I uncheck the "Cerdded" checkbox
	When I press the "Parhau" button
	Then I see "Gwiriwch eich atebion" on the page
#	And I see text "Beic ,Car,Beic modur ,Trafnidiaeth gyhoeddus" in the same row as "Sut byddwch yn teithio i'r llys?"
	
	#change bicycle miles
	
#	And I see text "2 Milltiroedd " in the same row as "Milltiroedd ar feic fesul dydd"
	And I click on the "Newid" link in the same row as "Milltiroedd ar feic fesul dydd"
	
	And I set "Milltiroedd y dydd" to "5"
	When I press the "Parhau" button
	Then I see "Gwiriwch eich atebion" on the page
#	And I see text "5 Milltiroedd" in the same row as "Milltiroedd ar feic fesul dydd"
	
	#change car miles
	
#	And I see text "2 Milltiroedd" in the same row as "Milltiroedd mewn car fesul dydd"
	And I click on the "Newid" link in the same row as "Milltiroedd mewn car fesul dydd"
	
	And I set "Milltiroedd y dydd" to "5"
	When I press the "Parhau" button
	Then I see "Gwiriwch eich atebion" on the page
#	And I see text "5 Milltiroedd" in the same row as "Milltiroedd mewn car fesul dydd"
	
	#change motorcycle miles
	
#	And I see text "2 Milltiroedd" in the same row as "Milltiroedd ar feic modur fesul dydd"
	And I click on the "Newid" link in the same row as "Milltiroedd ar feic modur fesul dydd"
	
	And I set "Milltiroedd y dydd" to "5"
	When I press the "Parhau" button
	Then I see "Gwiriwch eich atebion" on the page
#	And I see text "5 Milltiroedd" in the same row as "Milltiroedd ar feic modur fesul dydd"

	#change public transport miles
	
#	And I see text "20.00" in the same row as "Costau trafnidiaeth gyhoeddus fesul dydd"
	And I click on the "Newid" link in the same row as "Cyfanswm cost trafnidiaeth gyhoeddus fesul dydd"
	                                                    
	And I set "Cost eich holl docynnau mewn £ fesul dydd" to "25"
	When I press the "Parhau" button
	Then I see "Gwiriwch eich atebion" on the page
#	And I see text "25.00" in the same row as "Costau trafnidiaeth gyhoeddus fesul dydd"
	
	When I press the "Parhau" button
	Then I see "Dylech fod yn gallu hawlio" on the page
	And I see "Cychwyn eto" on the page
