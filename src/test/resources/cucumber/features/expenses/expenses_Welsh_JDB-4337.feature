Feature: Expenses_Welsh_JDB-4337

@expenses @JDB-4337
Scenario: expensesJDB-4337 Value of Additional Expenses Welsh
	
	Given I am on the Welsh version of expenses on "expenses" "ithc"
	
	Then I press the "Cychwyn arni" button

	Then I set the radio button to "Na fyddaf"
	When I press the "Parhau" button
	Then I set the radio button to "Bydd"
	When I press the "Parhau" button
	
	#footer
	
	And I see the Gov licence description on the page
	And I see "Cwcis" on the page
	And I do not see "Polisi preifatrwydd" on the page
	
	#Back link
	
	And I click on the "Cliciwch i fynd yn ôl" link
	Then I see "A fydd gwasanaethu ar reithgor yn golygu y bydd gennych gostau ychwanegol na fyddai'n codi fel arfer?" on the page
	And the radio button "Bydd" is "selected"
	When I press the "Parhau" button
	
	#page text
	
	Then I see "Gwiriwch beth allwch chi ei hawlio ar gyfer gwasanaethu ar reithgor" on the page
	And I see "Beth fyddai cyfanswm y costau ychwanegol hyn fesul dydd?" on the page
	And I see "Bydd arnoch angen darparu tystiolaeth o'r costau hyn wrth wneud hawliad. Gallai'r rhain gynnwys anfonebau neu gopi o dystysgrif geni eich plentyn. Ceir rhestr lawn o'r dystiolaeth sydd ei hangen ar y ffurflen hawlio." on the page
	And I see "£ y dydd" on the page
	
	#errors if Continue pressed with no input
	
	When I press the "Parhau" button
	Then I see "Nodwch gyfanswm y costau ychwanegol hyn fesul dydd" on the page
	
	#input values
	
	When I set "£" to "Not Much"
	And I press the "Parhau" button
	And under the "Mae problem" heading I see "Gwiriwch gyfanswm y costau ychwanegol hyn fesul dydd"
	Then I see "Gwiriwch gyfanswm y costau ychwanegol hyn fesul dydd" under the label "£ y dydd"
		
	Then I set "£" to "1000..00"
	And I press the "Parhau" button
	
	And under the "Mae problem" heading I see "Gwiriwch gyfanswm y costau ychwanegol hyn fesul dydd"
	Then I see "Gwiriwch gyfanswm y costau ychwanegol hyn fesul dydd" under the label "£ y dydd"
	
	Then I set "£ y dydd" to "1000,"
	And I press the "Parhau" button
	
	#Back link
	
	And I click on the "Cliciwch i fynd yn ôl" link
	When I press the "Parhau" button
	Then "£ y dydd" is "1000.00" 
	
	Then I set "£" to ",000"
	And I press the "Parhau" button
	
	#Back link
	
	And I click on the "Cliciwch i fynd yn ôl" link
	When I press the "Parhau" button
	Then "£ y dydd" is "0.00"
	
	Then I set "£" to ".000"
	And I press the "Parhau" button
	
	#Back link
	
	And I click on the "Cliciwch i fynd yn ôl" link
	When I press the "Parhau" button
	Then "£ y dydd" is "0.00"
	
	Then I set "£" to "<1000"
	And I press the "Parhau" button
	And under the "Mae problem" heading I see "Gwiriwch gyfanswm y costau ychwanegol hyn fesul dydd"
	Then I see "Gwiriwch gyfanswm y costau ychwanegol hyn fesul dydd" under the label "£ y dydd"
	
	Then I set "£" to "100/200"
	And I press the "Parhau" button
	
	And under the "Mae problem" heading I see "Gwiriwch gyfanswm y costau ychwanegol hyn fesul dydd"
	Then I see "Gwiriwch gyfanswm y costau ychwanegol hyn fesul dydd" under the label "£ y dydd"
	
	Then I set "£" to "£1000"
	And I press the "Parhau" button
	
	#Back link
	
	And I click on the "Cliciwch i fynd yn ôl" link
	When I press the "Parhau" button
	Then "£ y dydd" is "1000.00"
	
	Then I set "£" to "$1000"
	And I press the "Parhau" button
	And under the "Mae problem" heading I see "Gwiriwch gyfanswm y costau ychwanegol hyn fesul dydd"
	Then I see "Gwiriwch gyfanswm y costau ychwanegol hyn fesul dydd" under the label "£ y dydd"
	
	Then I set "£" to "1,500.00"
	And I press the "Parhau" button
	
	#Back link
	
	And I click on the "Cliciwch i fynd yn ôl" link
	When I press the "Parhau" button
	Then "£ y dydd" is "1500.00"
	
	Then I set "£" to "1000000.00"
	And I press the "Parhau" button
	
	#Back link
	
	And I click on the "Cliciwch i fynd yn ôl" link
	When I press the "Parhau" button
	Then "£ y dydd" is "1000000.00"
	
	Then I set "£" to " 1000"
	And I press the "Parhau" button
	
	#Back link
	
	And I click on the "Cliciwch i fynd yn ôl" link
	When I press the "Parhau" button
	Then "£ y dydd" is "1000.00"
	
	Then I set "£" to "1000 00"
	And I press the "Parhau" button
	
	#Back link
	
	And I click on the "Cliciwch i fynd yn ôl" link
	When I press the "Parhau" button
	Then "£ y dydd" is "1000.00"
	
	Then I set "£" to "1000 "
	And I press the "Parhau" button
	
	#Back link
	
	And I click on the "Cliciwch i fynd yn ôl" link
	When I press the "Parhau" button
	Then "£ y dydd" is "1000.00"
	
	#it allows this
	
	Then I set "£" to "100-00"
	And I press the "Parhau" button
	
	And under the "Mae problem" heading I see "Gwiriwch gyfanswm y costau ychwanegol hyn fesul dydd"
	Then I see "Gwiriwch gyfanswm y costau ychwanegol hyn fesul dydd" under the label "£ y dydd"
	
	Then I set "£" to "1000,00"
	And I press the "Parhau" button
	
	#Back link
	
	And I click on the "Cliciwch i fynd yn ôl" link
	When I press the "Parhau" button
	Then "£ y dydd" is "100000.00"
	
	#continue
	
	When I press the "Parhau" button
	Then I see "Sut byddwch yn teithio i'r llys?" on the page