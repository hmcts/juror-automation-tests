Feature: Expenses_Welsh_JDB-4372

@expenses @JDB-4372 
Scenario Outline: expenses_Welsh_JDB-4372
	
	Given I am on the welsh version of "expenses" "ithc"
	
	And I press the "Cychwyn arni" button
	
	#loseincome
	Then I set the radio button to "Byddaf"
	When I press the "Parhau" button
	
	#earnmorethan
	Then I set the radio button to "Ydw"
	When I press the "Parhau" button
	
	#otherexpenses
	Then I set the radio button to "Bydd"
	When I press the "Parhau" button
	
	#dailyexpenses
	Then I set "£ y dydd" to "<expenses>"	
	When I press the "Parhau" button
	
	#traveltypes
	When I check the "Beic modur" checkbox
	When I press the "Parhau" button
	
	#page content
	
	Then I see "Gwiriwch beth allwch chi ei hawlio ar gyfer gwasanaethu ar reithgor" on the page
	And I see "Cyfanswm y milltiroedd rydych yn teithio ar feic modur fesul dydd" on the page
	And I see "Milltiroedd y dydd" on the page
	
	#footer
	
	And I see the Gov licence description on the page
	And I see "Cwcis" on the page
	And I do not see "Polisi preifatrwydd" on the page
	
	#Back link
	
	And I click on the "Cliciwch i fynd yn ôl" link
	Then I see "Sut byddwch yn teithio i'r llys?" on the page
	When I press the "Parhau" button
	
	#errors if Continue pressed with no input
	
	When I press the "Parhau" button
    And under the "There is a problem" heading I see "Nodwch faint o filltiroedd rydych yn teithio ar feic modur fesul dydd"
	Then I see "Nodwch faint o filltiroedd rydych yn teithio ar feic modur fesul dydd" under the label "Milltiroedd y dydd"
	
	#input values
	
	When I set "Milltiroedd y dydd" to "Not many"
	When I press the "Parhau" button
	
    And under the "There is a problem" heading I see "Gwiriwch faint o filltiroedd rydych yn teithio ar feic modur fesul dydd"
	Then I see "Gwiriwch faint o filltiroedd rydych yn teithio ar feic modur fesul dydd" under the label "Milltiroedd y dydd"

	Then I set "Milltiroedd y dydd" to "10..00"
	When I press the "Parhau" button

    And under the "There is a problem" heading I see "Gwiriwch faint o filltiroedd rydych yn teithio ar feic modur fesul dydd"
	Then I see "Gwiriwch faint o filltiroedd rydych yn teithio ar feic modur fesul dydd" under the label "Milltiroedd y dydd"
	
	Then I set "Milltiroedd y dydd" to ",00"
	When I press the "Parhau" button

    And under the "There is a problem" heading I see "Gwiriwch faint o filltiroedd rydych yn teithio ar feic modur fesul dydd"
	Then I see "Gwiriwch faint o filltiroedd rydych yn teithio ar feic modur fesul dydd" under the label "Milltiroedd y dydd"

	Then I set "Milltiroedd y dydd" to "£10"
	When I press the "Parhau" button

    And under the "There is a problem" heading I see "Gwiriwch faint o filltiroedd rydych yn teithio ar feic modur fesul dydd"
	Then I see "Gwiriwch faint o filltiroedd rydych yn teithio ar feic modur fesul dydd" under the label "Milltiroedd y dydd"
	
	Then I set "Milltiroedd y dydd" to "<10"
	When I press the "Parhau" button

    And under the "There is a problem" heading I see "Gwiriwch faint o filltiroedd rydych yn teithio ar feic modur fesul dydd"
	Then I see "Gwiriwch faint o filltiroedd rydych yn teithio ar feic modur fesul dydd" under the label "Milltiroedd y dydd"

	Then I set "Milltiroedd y dydd" to "10,"
	When I press the "Parhau" button

    And under the "There is a problem" heading I see "Gwiriwch faint o filltiroedd rydych yn teithio ar feic modur fesul dydd"
	Then I see "Gwiriwch faint o filltiroedd rydych yn teithio ar feic modur fesul dydd" under the label "Milltiroedd y dydd"
	
	Then I set "Milltiroedd y dydd" to ".00"
	When I press the "Parhau" button

    And under the "There is a problem" heading I see "Gwiriwch faint o filltiroedd rydych yn teithio ar feic modur fesul dydd"
	Then I see "Gwiriwch faint o filltiroedd rydych yn teithio ar feic modur fesul dydd" under the label "Milltiroedd y dydd"
	
	#allowed
	
	Then I set "Milltiroedd y dydd" to "10/12"
	When I press the "Parhau" button
	
	And under the "There is a problem" heading I see "Gwiriwch faint o filltiroedd rydych yn teithio ar feic modur fesul dydd"
	Then I see "Gwiriwch faint o filltiroedd rydych yn teithio ar feic modur fesul dydd" under the label "Milltiroedd y dydd"
	
	Then I set "Milltiroedd y dydd" to "0"
	When I press the "Parhau" button

	#payforparking?
	Then I set the radio button to "Na fydd"
	When I press the "Parhau" button
	
	When I click on the "Newid" link in the same row as "Milltiroedd ar feic modur fesul dydd"
  	                                                
  
	Then I set "Milltiroedd y dydd" to "1000000.00"
	When I press the "Parhau" button

	When I click on the "Newid" link in the same row as "Milltiroedd ar feic modur fesul dydd"
	
	Then I set "Milltiroedd y dydd" to "10,00"
	When I press the "Parhau" button
	
	And under the "There is a problem" heading I see "Gwiriwch faint o filltiroedd rydych yn teithio ar feic modur fesul dydd"
	Then I see "Gwiriwch faint o filltiroedd rydych yn teithio ar feic modur fesul dydd" under the label "Milltiroedd y dydd"
	
	Then I set "Milltiroedd y dydd" to "10-00"
	When I press the "Parhau" button
	
	And under the "There is a problem" heading I see "Gwiriwch faint o filltiroedd rydych yn teithio ar feic modur fesul dydd"
	Then I see "Gwiriwch faint o filltiroedd rydych yn teithio ar feic modur fesul dydd" under the label "Milltiroedd y dydd"
	
	Then I set "Milltiroedd y dydd" to "10 00"
	When I press the "Parhau" button
	
	And under the "There is a problem" heading I see "Gwiriwch faint o filltiroedd rydych yn teithio ar feic modur fesul dydd"
	Then I see "Gwiriwch faint o filltiroedd rydych yn teithio ar feic modur fesul dydd" under the label "Milltiroedd y dydd"
	
	Then I set "Milltiroedd y dydd" to "10 "
	When I press the "Parhau" button

	When I click on the "Newid " link in the same row as "Milltiroedd ar feic modur fesul dydd"
	
	Then I set "Milltiroedd y dydd" to " 10"
	When I press the "Parhau" button

	When I click on the "Newid " link in the same row as "Milltiroedd ar feic modur fesul dydd"
	
	Then I set "Milltiroedd y dydd" to "10.2"
	When I press the "Parhau" button

	#continue
	
	When I press the "Parhau" button
	Then I see "Dylech fod yn gallu hawlio" on the page


Examples:
	|earnings	|expenses	|canClaim	|upperClaim	|earningsAndExpenses|publicTransport|carMiles	|carExpenses|motorbikeMiles	|motorbikeExpenses	|bikeMiles|bikeExpenses	|totalTravel|totalClaim	|
	|20.00		|14.55		|14.55		|64.95		|14.55				|20.99			|1			|0.31		|1				|0.31				|2	      |0.19			|21.80		|42.06		|

	