Feature: ExpensesJDB-4374
	
@expenses @JDB-4374
Scenario: expensesJDB-4374
	
	Given I am on expenses on "expenses" "juror-test01"
	
	#navigate to expenses page
	
	And I press the "Start now" button
	
	#loseincome
	Then I choose the "Yes" radio button
	When I press the "Continue" button
	
	#earnmorethan
	Then I see "Check what you can claim for jury service" on the page
	And I see "Do you earn more than £64.95 each day on the days you work?" on the page
	And I see "If you earn a different amount on different days, use the largest amount to find out the maximum that you can claim." on the page
	
	#none selected by default
	
	And the radio button "Yes" is "unselected"
	And the radio button "No" is "unselected"
	
	#errors if Continue pressed with none selected
	
	When I press the "Continue" button
	Then I see "Please select yes or no" on the page	
	
	#Select Yes
	
	Then I choose the "Yes" radio button
	Then the radio button "Yes" is "selected"
	Then the radio button "No" is "unselected"

	#Select No
	
	Then I choose the "No" radio button
	Then the radio button "No" is "selected"
	Then the radio button "Yes" is "unselected"
	
	#footer
	
	And I see "All content is available under the Open Government Licence v3.0, except where otherwise stated" on the page
	And I see "Cookies" on the page
	And I do not see "Privacy policy" on the page
	
	#Back link
	
	Then I click on the "Back" link
	And I see "Will you lose any income while doing jury service?" on the page 

	Then I see "Continue" on the page
	
