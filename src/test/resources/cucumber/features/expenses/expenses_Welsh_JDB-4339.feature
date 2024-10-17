Feature: Expenses_Welsh_JDB-4339

@expenses @JDB-4339
Scenario: expensesJDB-4339 How many miles - bicycle Welsh
	
	Given I am on the Welsh version of expenses on "expenses" "juror-test01"
	
	Then I press the "Cychwyn arni" button
	
	Then I set the radio button to "Na fyddaf"
	When I press the "Parhau" button
	Then I set the radio button to "Bydd"
	When I press the "Parhau" button
	Then I set "£" to "1000.00"	
	When I press the "Parhau" button
	When I check the "Beic" checkbox
	When I press the "Parhau" button
	
	#footer
	
	And I see the Gov licence description on the page
	And I see "Cwcis" on the page
	And I do not see "Polisi preifatrwydd" on the page
	
	#Back link
	
	And I click on the "Cliciwch i fynd yn ôl" link
	Then I see "Sut byddwch yn teithio i'r llys?" on the page
	When I press the "Parhau" button
	
	#page text
	
	And I see "Gwiriwch beth allwch chi ei hawlio ar gyfer gwasanaethu ar reithgor" on the page
	Then I see "Cyfanswm y milltiroedd rydych yn teithio ar feic fesul dydd" on the page
	And I see "Milltiroedd y dydd" on the page
	
	#errors if Continue pressed with no input
	
	When I press the "Parhau" button
    And under the "Mae problem" heading I see "Nodwch faint o filltiroedd rydych yn teithio ar feic fesul dydd"
	Then I see "Nodwch faint o filltiroedd rydych yn teithio ar feic fesul dydd " under the label "Milltiroedd y dydd"
	
	#input values
	
	When I set "Milltiroedd y dydd" to "Not many"
	When I press the "Parhau" button
	
    And under the "Mae problem" heading I see "Gwiriwch faint o filltiroedd rydych yn teithio ar feic fesul dydd"
	Then I see "Gwiriwch faint o filltiroedd rydych yn teithio ar feic fesul dydd" under the label "Milltiroedd y dydd"

	Then I set "Milltiroedd y dydd" to "10..00"
	When I press the "Parhau" button

    And under the "Mae problem" heading I see "Gwiriwch faint o filltiroedd rydych yn teithio ar feic fesul dydd"
	Then I see "Gwiriwch faint o filltiroedd rydych yn teithio ar feic fesul dydd" under the label "Milltiroedd y dydd"
	
	Then I set "Milltiroedd y dydd" to ",00"
	When I press the "Parhau" button

    And under the "Mae problem" heading I see "Gwiriwch faint o filltiroedd rydych yn teithio ar feic fesul dydd"
	Then I see "Gwiriwch faint o filltiroedd rydych yn teithio ar feic fesul dydd" under the label "Milltiroedd y dydd"

	Then I set "Milltiroedd y dydd" to "£10"
	When I press the "Parhau" button

    And under the "Mae problem" heading I see "Gwiriwch faint o filltiroedd rydych yn teithio ar feic fesul dydd"
	Then I see "Gwiriwch faint o filltiroedd rydych yn teithio ar feic fesul dydd" under the label "Milltiroedd y dydd"
	
	Then I set "Milltiroedd y dydd" to "<10"
	When I press the "Parhau" button

    And under the "Ma problem" heading I see "Gwiriwch faint o filltiroedd rydych yn teithio ar feic fesul dydd"
	Then I see "Gwiriwch faint o filltiroedd rydych yn teithio ar feic fesul dydd" under the label "Milltiroedd y dydd"

	Then I set "Milltiroedd y dydd" to "10,"
	When I press the "Parhau" button

    And under the "Mae problem" heading I see "Gwiriwch faint o filltiroedd rydych yn teithio ar feic fesul dydd"
	Then I see "Gwiriwch faint o filltiroedd rydych yn teithio ar feic fesul dydd" under the label "Milltiroedd y dydd"
	
	Then I set "Milltiroedd y dydd" to ".00"
	When I press the "Parhau" button

    And under the "Mae problem" heading I see "Gwiriwch faint o filltiroedd rydych yn teithio ar feic fesul dydd"
	Then I see "Gwiriwch faint o filltiroedd rydych yn teithio ar feic fesul dydd" under the label "Milltiroedd y dydd"
	
	#allowed
	
	Then I set "Milltiroedd y dydd" to "10/12"
	When I press the "Parhau" button
	And under the "Mae problem" heading I see "Gwiriwch faint o filltiroedd rydych yn teithio ar feic fesul dydd"
	Then I see "Gwiriwch faint o filltiroedd rydych yn teithio ar feic fesul dydd" under the label "Milltiroedd y dydd"
	
	Then I set "Milltiroedd y dydd" to "0"
	When I press the "Parhau" button
	When I click on the "Newid" link in the same row as "Milltiroedd ar feic fesul dydd"
	
	Then I set "Milltiroedd y dydd" to "1000000.00"
	When I press the "Parhau" button
	When I click on the "Newid" link in the same row as "Milltiroedd ar feic fesul dydd"
	
	Then I set "Milltiroedd y dydd" to "10,00"
	When I press the "Parhau" button
	And under the "Mae problem" heading I see "Gwiriwch faint o filltiroedd rydych yn teithio ar feic fesul dydd"
	Then I see "Gwiriwch faint o filltiroedd rydych yn teithio ar feic fesul dydd" under the label "Milltiroedd y dydd"
	
	Then I set "Milltiroedd y dydd" to "10-00"
	When I press the "Parhau" button
 	And under the "Mae problem" heading I see "Gwiriwch faint o filltiroedd rydych yn teithio ar feic fesul dydd"
	Then I see "Gwiriwch faint o filltiroedd rydych yn teithio ar feic fesul dydd" under the label "Milltiroedd y dydd"
	
	Then I set "Milltiroedd y dydd" to "10 00"
	When I press the "Parhau" button
	And under the "Mae problem" heading I see "Gwiriwch faint o filltiroedd rydych yn teithio ar feic fesul dydd"
	Then I see "Gwiriwch faint o filltiroedd rydych yn teithio ar feic fesul dydd" under the label "Milltiroedd y dydd"
	
	Then I set "Milltiroedd y dydd" to "10 "
	When I press the "Parhau" button
	When I click on the "Newid" link in the same row as "Milltiroedd ar feic fesul dydd"
	
	Then I set "Milltiroedd y dydd" to " 10"
	When I press the "Parhau" button
	When I click on the "Newid" link in the same row as "Milltiroedd ar feic fesul dydd"
	
	Then I set "Milltiroedd y dydd" to "10.2"
	When I press the "Parhau" button
	
	#continue
	
	When I press the "Parhau" button
	Then I see "Dylech fod yn gallu hawlio" on the page
	
	
