Feature: Expenses_Welsh_JDB-4375
	
@expenses @JDB-4375 
Scenario: expenses_Welsh_JDB-4375
	
	Given I am on the welsh version of "expenses" "juror-test01"

	And I press the "Cychwyn arni" button
	
	#loseincome
	Then I set the radio button to "Byddaf"
	When I press the "Parhau" button
	
	#earnmorethan
	Then I set the radio button to "Nac ydw"
	When I press the "Parhau" button

	#Back link
	
	And I click on the "Cliciwch i fynd yn ôl" link
	Then I see "A ydych yn ennill mwy na £64.95 y dydd ar y dyddiau pan fyddwch yn gweithio?" on the page
	When I press the "Parhau" button
	
	#footer
	
	And I see "All content is available under the Open Government Licence v3.0, except where otherwise stated" on the page
	And I see "Cwcis" on the page
	And I do not see "Polisi preifatrwydd" on the page
	
	#page content
	
	Then I see "Gwiriwch beth allwch chi ei hawlio ar gyfer gwasanaethu ar reithgor" on the page
	
	Then I see "Faint o arian ydych chi'n ennill bob dydd?" on the page 
	And I see "Nodwch gyfanswm yr arian yr ydych yn ei ennill ar gyfer unrhyw gyflogaeth, hunangyflogaeth neu fel cyfarwyddwr cwmni pob dydd. Dylai hyn fod y swm rydych yn ei gael ar ôl talu treth, a elwir hefyd yn Gyflog Net." on the page 
	
	Then I see "£ y dydd" on the page 
	
	Then I see "Parhau" on the page
	And I click on the "Lle galla i ddod o hyd i'r wybodaeth hon?" link
	And I see "Gallwch ddod o hyd iddi ar eich taflen gyflog, P60 neu'ch ffurflen dreth. Bydd yn ymddangos fel 'Net Pay." on the page
	
	#errors if Continue pressed with no input
	
	When I press the "Parhau" button

    And under the "Mae problem" heading I see "Nodwch faint rydych yn ei ennill bob dydd"
	Then I see "Nodwch faint rydych yn ei ennill bob dydd" under the label "£ y dydd"

    #input values
	
	When I set "£ y dydd" to "Not much"
	When I press the "Parhau" button

    And under the "Mae problem" heading I see "Gwiriwch faint rydych yn ei ennill bob dydd"
	Then I see "Gwiriwch faint rydych yn ei ennill bob dydd" under the label "£ y dydd"
	
	When I set "£ y dydd" to "10..00"
	When I press the "Parhau" button
	
	And under the "Mae problem" heading I see "Gwiriwch faint rydych yn ei ennill bob dydd"
	Then I see "Gwiriwch faint rydych yn ei ennill bob dydd" under the label "£ y dydd"
    
	When I set "£ y dydd" to "10,"
	Then I press the "Parhau" button
	
	And I click on the "Cliciwch i fynd yn ôl" link
	When I press the "Parhau" button
	When I press the "Parhau" button

	Then I set "£ y dydd" to ",00"
    When I press the "Parhau" button

	And I click on the "Cliciwch i fynd yn ôl" link
	When I press the "Parhau" button
	When I press the "Parhau" button
	
	Then I set "£ y dydd" to ".00"
	When I press the "Parhau" button
	
	And under the "Mae problem" heading I see "Gwiriwch faint rydych yn ei ennill bob dydd"
	Then I see "Gwiriwch faint rydych yn ei ennill bob dydd" under the label "£ y dydd"

	Then I set "£ y dydd" to "<10"
	When I press the "Parhau" button
	
	And under the "Mae problem" heading I see "Gwiriwch faint rydych yn ei ennill bob dydd"
	Then I see "Gwiriwch faint rydych yn ei ennill bob dydd" under the label "£ y dydd"

	Then I set "£ y dydd" to "10.2"
	When I press the "Parhau" button
	And I click on the "Cliciwch i fynd yn ôl" link
	When I press the "Parhau" button
	When I press the "Parhau" button
	
	Then I set "£ y dydd" to " 10"
	When I press the "Parhau" button
	And I click on the "Cliciwch i fynd yn ôl" link
	When I press the "Parhau" button
	When I press the "Parhau" button
	
	And "£ y dydd" is "10.00"
	Then I set "£ y dydd" to "10 "
	When I press the "Parhau" button
	And I click on the "Cliciwch i fynd yn ôl" link
	When I press the "Parhau" button
	When I press the "Parhau" button
	
	And "£ y dydd" is "10.00"
	Then I set "£ y dydd" to "10 00"
	When I press the "Parhau" button
	
	And under the "Mae problem" heading I see "Gwiriwch faint rydych yn ei ennill bob dydd"
	Then I see "Gwiriwch faint rydych yn ei ennill bob dydd" under the label "£ y dydd"
	
	Then I set "£ y dydd" to "10/12"
	When I press the "Parhau" button
	
	And under the "Mae problem" heading I see "Gwiriwch faint rydych yn ei ennill bob dydd"
	Then I see "Gwiriwch faint rydych yn ei ennill bob dydd" under the label "£ y dydd"
	
	When I set "£ y dydd" to "10-00"
	When I press the "Parhau" button
	
	And under the "Mae problem" heading I see "Gwiriwch faint rydych yn ei ennill bob dydd"
	Then I see "Gwiriwch faint rydych yn ei ennill bob dydd" under the label "£ y dydd"
	
	When I set "£ y dydd" to "1000000.00"
	When I press the "Parhau" button
	And I click on the "Cliciwch i fynd yn ôl" link
	When I press the "Parhau" button
	When I press the "Parhau" button
	
	And "£ y dydd" is "1000000.00"
	Then I set "£ y dydd" to "£10"
	When I press the "Parhau" button
	And I click on the "Cliciwch i fynd yn ôl" link
	When I press the "Parhau" button
	When I press the "Parhau" button
	
	Then I set "£ y dydd" to "10,00"
	When I press the "Parhau" button
	And I click on the "Cliciwch i fynd yn ôl" link
	When I press the "Parhau" button
	When I press the "Parhau" button
	
	Then I set "£ y dydd" to "0"
	When I press the "Parhau" button
	And I click on the "Cliciwch i fynd yn ôl" link
	When I press the "Parhau" button
	When I press the "Parhau" button
	And "£ y dydd" is "0.00"

	