Feature: Expenses_JDB-4372

@expenses @JDB-4372
Scenario Outline: expensesJDB-4372
	
	Given I am on expenses on "expenses" "juror-test01"
	
	And I press the "Start now" button
	
	#loseincome
	Then I choose the "Yes" radio button
	When I press the "Continue" button
	
	#earnmorethan
	Then I choose the "Yes" radio button
	When I press the "Continue" button
	
	#otherexpenses
	Then I choose the "Yes" radio button
	When I press the "Continue" button
	
	#dailyexpenses
	Then I set "£ each day" to "<expenses>"	
	When I press the "Continue" button
	
	#traveltypes
	When I check the "Motorcycle" checkbox
	When I press the "Continue" button
	
	#page content
	
	Then I see "Check what you can claim for jury service" on the page
	And I see "Total miles you'll travel each day by motorcycle" on the page
	And I see "Miles each day" on the page
	
	#footer
	
	And I see "All content is available under the Open Government Licence v3.0, except where otherwise stated" on the page
	And I see "Cookies" on the page
	And I do not see "Privacy policy" on the page
	
	#Back link
	
	And I click on the "Back" link
	Then I see "How will you travel to the court?" on the page
	When I press the "Continue" button
	
	#errors if Continue pressed with no input
	
	When I press the "Continue" button
    And under the "There is a problem" heading I see "Enter how many miles you'll travel by motorcycle each day"
	Then I see "Enter how many miles you'll travel by motorcycle each day" under the label "Miles each day"
	
	#input values
	
	When I set "Miles each day" to "Not many"
	When I press the "Continue" button
	
    And under the "There is a problem" heading I see "Enter how many miles you'll travel by motorcycle each day"
	Then I see "Enter how many miles you'll travel by motorcycle each day" under the label "Miles each day"

	Then I set "Miles each day" to "10..00"
	When I press the "Continue" button

    And under the "There is a problem" heading I see "Enter how many miles you'll travel by motorcycle each day"
	Then I see "Enter how many miles you'll travel by motorcycle each day" under the label "Miles each day"
	
	Then I set "Miles each day" to ",00"
	When I press the "Continue" button

    And under the "There is a problem" heading I see "Enter how many miles you'll travel by motorcycle each day"
	Then I see "Enter how many miles you'll travel by motorcycle each day" under the label "Miles each day"

	Then I set "Miles each day" to "£10"
	When I press the "Continue" button

    And under the "There is a problem" heading I see "Enter how many miles you'll travel by motorcycle each day"
	Then I see "Enter how many miles you'll travel by motorcycle each day" under the label "Miles each day"
	
	Then I set "Miles each day" to "<10"
	When I press the "Continue" button

    And under the "There is a problem" heading I see "Enter how many miles you'll travel by motorcycle each day"
	Then I see "Enter how many miles you'll travel by motorcycle each day" under the label "Miles each day"

	Then I set "Miles each day" to "10,"
	When I press the "Continue" button

    And under the "There is a problem" heading I see "Enter how many miles you'll travel by motorcycle each day"
	Then I see "Enter how many miles you'll travel by motorcycle each day" under the label "Miles each day"
	
	Then I set "Miles each day" to ".00"
	When I press the "Continue" button

    And under the "There is a problem" heading I see "Enter how many miles you'll travel by motorcycle each day"
	Then I see "Enter how many miles you'll travel by motorcycle each day" under the label "Miles each day"
	
	#allowed
	
	Then I set "Miles each day" to "10/12"
	When I press the "Continue" button
	
	And under the "There is a problem" heading I see "Enter how many miles you'll travel by motorcycle each day"
	Then I see "Enter how many miles you'll travel by motorcycle each day" under the label "Miles each day"
	
	Then I set "Miles each day" to "0"
	When I press the "Continue" button
	
	#payforparking?
	Then I choose the "No" radio button
	When I press the "Continue" button
	
	When I click on the "Change" link in the same row as "Miles by motorcycle each day"
	
	Then I set "Miles each day" to "1000000.00"
	When I press the "Continue" button

	When I click on the "Change" link in the same row as "Miles by motorcycle each day"
	
	Then I set "Miles each day" to "10,00"
	When I press the "Continue" button
	
	And under the "There is a problem" heading I see "Enter how many miles you'll travel by motorcycle each day"
	Then I see "Enter how many miles you'll travel by motorcycle each day" under the label "Miles each day"
	
	Then I set "Miles each day" to "10-00"
	When I press the "Continue" button
	
	And under the "There is a problem" heading I see "Enter how many miles you'll travel by motorcycle each day"
	Then I see "Enter how many miles you'll travel by motorcycle each day" under the label "Miles each day"
	
	Then I set "Miles each day" to "10 00"
	When I press the "Continue" button
	
	And under the "There is a problem" heading I see "Enter how many miles you'll travel by motorcycle each day"
	Then I see "Enter how many miles you'll travel by motorcycle each day" under the label "Miles each day"
	
	Then I set "Miles each day" to "10 "
	When I press the "Continue" button

	When I click on the "Change" link in the same row as "Miles by motorcycle each day"
	
	Then I set "Miles each day" to " 10"
	When I press the "Continue" button

	When I click on the "Change" link in the same row as "Miles by motorcycle each day"
	
	Then I set "Miles each day" to "10.2"
	When I press the "Continue" button

	#continue
	
	When I press the "Continue" button
	Then I see "You should be able to claim" on the page

Examples:
	|earnings	|expenses	|canClaim	|upperClaim	|earningsAndExpenses|publicTransport|carMiles	|carExpenses|motorbikeMiles	|motorbikeExpenses	|bikeMiles|bikeExpenses	|totalTravel|totalClaim	|
	|20.00		|14.55		|14.55		|64.95		|14.55				|20.99			|1			|0.31		|1				|0.31				|2	      |0.19			|21.80		|42.06		|

	