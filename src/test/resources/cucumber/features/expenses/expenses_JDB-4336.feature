Feature: Expenses_JDB-4336

@expenses @JDB-4336
Scenario: expensesJDB-4336 Additional Expenses
	
	Given I am on expenses on "expenses" "juror-test01"
	
	And I press the "Start now" button
	
	Then I set the radio button to "No"
	When I press the "Continue" button
		
	Then I see "Check what you can claim for jury service" on the page
	
	#footer
	
	And I see "All content is available under the Open Government Licence v3.0, except where otherwise stated" on the page
	
	#page text
	
	Then I see "Will doing jury service mean you have extra costs that you wouldn't normally have?" on the page
	And  I see "Include costs for childcare or care for an elderly or vulnerable adult. You can only claim for extra costs incurred by doing jury service and not costs that you’d normally pay for." on the page
	
	And I see "Do not include travel costs. We'll ask you for those later" on the page
	And I see "Claiming Expenses for childcare or care of elderly or vulnerable adults" on the page
	         
	When I press the "Continue" button
	Then I see "Please select yes or no" on the page	
	
	#Select Yes
	
	Then I set the radio button to "Yes"
	Then the radio button "Yes" is "selected"
	Then the radio button "No" is "unselected"

	#Select No
	
	Then I set the radio button to "No"
	Then the radio button "No" is "selected"
	Then the radio button "Yes" is "unselected"
	
	#continue
	
	When I press the "Continue" button
	Then I see "How will you travel to the court?" on the page

