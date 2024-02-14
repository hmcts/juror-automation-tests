Feature: Expenses_Welsh_JDB-4343
	
@expenses @JDB-4343
Scenario: expensesJDB-4343 How much pay for travel Welsh
	
	Given I am on the Welsh version of expenses on "expenses" "juror-test01"
	
	Then I press the "Cychwyn arni" button
	
	Then I set the radio button to "Na fyddaf"
	When I press the "Parhau" button
	Then I set the radio button to "Bydd"
	When I press the "Parhau" button
	Then I set "£" to "1000,00"	
	When I press the "Parhau" button
	When I check the "Trafnidiaeth gyhoeddus" checkbox
	When I press the "Parhau" button
	
	Then I see "Gwiriwch beth allwch chi ei hawlio ar gyfer gwasanaethu ar reithgor" on the page
	And I see "Cyfanswm cost trafnidiaeth gyhoeddus fesul dydd" on the page
	
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
	Then I see "Cyfanswm cost trafnidiaeth gyhoeddus fesul dydd" on the page
	Then I click on the "Mae gen i docyn tymor y gallaf ei ddefnyddio" link
	And I see "Os oes gennych docyn tymor ar gyfer teithio yn barod, ni allwch hawlio ar gyfer unrhyw ran o'r gost hwn oherwydd nid yw'n gost ychwanegol y mae'n rhaid ichi ei dalu." on the page
	And I see "Os nad oes gennych unrhyw gostau trafnidiaeth gyhoeddus ychwanegol i'w hawlio, nodwch £0." on the page
  	And I see "Cost eich holl docynnau mewn £ fesul dydd" on the page

	#errors if Continue pressed with no input
	
	When I press the "Parhau" button

    And under the "Mae problem" heading I see "Nodwch gost eich holl docynnau fesul dydd"
	Then I see "Nodwch gost eich holl docynnau fesul dydd" under the label "Cost eich holl docynnau mewn £ fesul dydd"

    #input values
	
	When I set "Cost eich holl docynnau mewn £ fesul dydd" to "Not many"
	When I press the "Parhau" button

    And under the "Mae problem" heading I see "Gwiriwch gost eich holl docynnau fesul dydd"
	Then I see "Nodwch gost eich holl docynnau fesul dydd" under the label "Cost eich holl docynnau mewn £ fesul dydd"
	
	When I set "Cost eich holl docynnau mewn £ fesul dydd" to "10..00"
	When I press the "Parhau" button
	
	And under the "Mae problem" heading I see "Gwiriwch gost eich holl docynnau fesul dyd"
	Then I see "Nodwch gost eich holl docynnau fesul dydd" under the label "Cost eich holl docynnau mewn £ fesul dydd"
	
	When I set "Cost eich holl docynnau mewn £ fesul dydd" to "10.00"
	When I press the "Parhau" button

    And I click on the "Newid" link in the same row as "Cyfanswm cost trafnidiaeth gyhoeddus fesul dydd"
    And "Cost eich holl docynnau mewn £ fesul dydd" is "10.00" 
    
	When I set "Cost eich holl docynnau mewn £ fesul dydd" to "10,"
	Then I press the "Parhau" button
	
	When I click on the "Newid" link in the same row as "Cyfanswm cost trafnidiaeth gyhoeddus fesul dydd"
	Then I set "Cost eich holl docynnau mewn £ fesul dydd" to ",00"
    When I press the "Parhau" button

	When I click on the "Newid" link in the same row as "Cyfanswm cost trafnidiaeth gyhoeddus fesul dydd"
	Then I set "Cost eich holl docynnau mewn £ fesul dydd" to ".00"
	When I press the "Parhau" button

	And under the "Mae problem" heading I see "Gwiriwch gost eich holl docynnau fesul dyd"
	Then I see "Nodwch gost eich holl docynnau fesul dydd" under the label "Cost eich holl docynnau mewn £ fesul dydd"
	
	Then I set "Cost eich holl docynnau mewn £ fesul dydd" to "<10"
	When I press the "Parhau" button
	
	And under the "Mae problem" heading I see "Gwiriwch gost eich holl docynnau fesul dyd"
	Then I see "Cyfanswm cost trafnidiaeth gyhoeddus fesul dydd" under the label "Cost eich holl docynnau mewn £ fesul dydd"

	Then I set "Cost eich holl docynnau mewn £ fesul dydd" to "10.2"
	When I press the "Parhau" button
	And I see "Gwiriwch eich atebion" on the page
	And I see text "10.2" in the same row as "Cyfanswm cost trafnidiaeth gyhoeddus fesul dydd"
	
	When I click on the "Newid" link in the same row as "Cyfanswm cost trafnidiaeth gyhoeddus fesul dydd"
	
	Then I set "Cost eich holl docynnau mewn £ fesul dydd" to " 10"
	When I press the "Parhau" button
	And I see "Gwiriwch eich atebion" on the page
	And I see text "10" in the same row as "Cyfanswm cost trafnidiaeth gyhoeddus fesul dydd"
	
	When I click on the "Newid" link in the same row as "Cyfanswm cost trafnidiaeth gyhoeddus fesul dydd"
	
	Then I set "Cost eich holl docynnau mewn £ fesul dydd" to "10 "
	When I press the "Parhau" button
	And I see "Gwiriwch eich atebion" on the page
	And I see text "10" in the same row as "Cyfanswm cost trafnidiaeth gyhoeddus fesul dydd"
	
	When I click on the "Newid" link in the same row as "Cyfanswm cost trafnidiaeth gyhoeddus fesul dydd"
	
	Then I set "Cost eich holl docynnau mewn £ fesul dydd" to "10 00"
	When I press the "Parhau" button
	
	And under the "Mae problem" heading I see "Gwiriwch gost eich holl docynnau fesul dyd"
	Then I see "Nodwch gost eich holl docynnau fesul dydd" under the label "Cost eich holl docynnau mewn £ fesul dydd"
	
	When I press the "Parhau" button
	
	And I see "Gwiriwch eich atebion" on the page
	And I see text "10.00" in the same row as "Cyfanswm cost trafnidiaeth gyhoeddus fesul dydd"
	
	When I click on the "Newid" link in the same row as "Cyfanswm cost trafnidiaeth gyhoeddus fesul dydd"
	
	Then I set "Cost eich holl docynnau mewn £ fesul dydd" to "10/12"
	When I press the "Parhau" button
	
	And under the "Mae problem" heading I see "Gwiriwch gost eich holl docynnau fesul dyd"
	Then I see "Nodwch gost eich holl docynnau fesul dydd" under the label "Cost eich holl docynnau mewn £ fesul dydd"
	
	When I press the "Parhau" button
	And I see "Gwiriwch eich atebion" on the page
	And I see text "10.00" in the same row as "Cyfanswm cost trafnidiaeth gyhoeddus fesul dydd"
	
	When I click on the "Newid" link in the same row as "Cyfanswm cost trafnidiaeth gyhoeddus fesul dydd"

	When I set "Cost eich holl docynnau mewn £ fesul dydd" to "10-00"
	When I press the "Parhau" button
	
	And under the "Mae problem" heading I see "Gwiriwch gost eich holl docynnau fesul dyd"
	Then I see "Nodwch gost eich holl docynnau fesul dydd" under the label "Cost eich holl docynnau mewn £ fesul dydd"
	
	When I set "Cost eich holl docynnau mewn £ fesul dydd" to "10.00"
	When I press the "Parhau" button
	
	And I see "Gwiriwch eich atebion" on the page
	And I see text "£10.00" in the same row as "Cyfanswm cost trafnidiaeth gyhoeddus fesul dydd"
	
	When I click on the "Newid" link in the same row as "Cyfanswm cost trafnidiaeth gyhoeddus fesul dydd"
	
	When I set "Cost eich holl docynnau mewn £ fesul dydd" to "1000000.00"
	When I press the "Parhau" button
	And I see "Gwiriwch eich atebion" on the page
	And I see text "1000000.00" in the same row as "Cyfanswm cost trafnidiaeth gyhoeddus fesul dydd"

	When I click on the "Newid" link in the same row as "Cyfanswm cost trafnidiaeth gyhoeddus fesul dydd"
	
	Then I set "Cost eich holl docynnau mewn £ fesul dydd" to "£10"
	When I press the "Parhau" button
	And I see "Gwiriwch eich atebion" on the page
	And I see text "10" in the same row as "Cyfanswm cost trafnidiaeth gyhoeddus fesul dydd"
	
	When I click on the "Newid" link in the same row as "Cyfanswm cost trafnidiaeth gyhoeddus fesul dydd"
	
	Then I set "Cost eich holl docynnau mewn £ fesul dydd" to "10,00"
	When I press the "Parhau" button
	And I see "Gwiriwch eich atebion" on the page
	And I see text "1000.00" in the same row as "Cyfanswm cost trafnidiaeth gyhoeddus fesul dydd"
	
	When I click on the "Newid" link in the same row as "Cyfanswm cost trafnidiaeth gyhoeddus fesul dydd"
	
	Then I set "Cost eich holl docynnau mewn £ fesul dydd" to "0"
	When I press the "Parhau" button
	And I see "Gwiriwch eich atebion" on the page
	And I see text "0" in the same row as "Cyfanswm cost trafnidiaeth gyhoeddus fesul dydd"

