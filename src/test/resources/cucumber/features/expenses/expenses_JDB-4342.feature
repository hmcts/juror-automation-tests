Feature: Expenses_JDB-4342

@expenses @JDB-4342 
Scenario: expensesJDB-4342 will parking costs be paid

	Given I am on expenses on "expenses" "juror-test01"
	
	And I press the "Start now" button
	
	Then I set the radio button to "No"
	When I press the "Continue" button
	Then I set the radio button to "Yes"
	When I press the "Continue" button
	Then I set "£" to "1000,00"	
	When I press the "Continue" button
	When I check the "Car" checkbox
	When I press the "Continue" button
	Then I set "Miles each day" to "10.2"
	When I press the "Continue" button
	Then I set the radio button to "Yes"
	When I press the "Continue" button
	
	Then I see "Check what you can claim for jury service" on the page
	
	#footer
	
	And I see "All content is available under the Open Government Licence v3.0, except where otherwise stated" on the page
	And I see "Cookies" on the page
	And I do not see "Privacy policy" on the page
	
	#Back link
	
	And I click on the "Back" link
	Then I see "Will you need to pay for parking?" on the page
	When I press the "Continue" button
	
	#page text
	
	And I see "Check what you can claim for jury service" on the page
	Then I see "Claiming for parking" on the page
	And I see "Not all courts will pay for parking. There may be a maximum amount that a court will pay per day. Check with the court for permission before you claim for parking." on the page

	#continue
	
	When I press the "Continue" button
	Then I see "Check your answers" on the page
	
