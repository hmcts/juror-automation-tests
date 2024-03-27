Feature: Expenses_JDB-4373
	
@expenses @JDB-4373
Scenario: expensesJDB-4373

	Given I am on expenses on "expenses" "juror-test01"
	
	And I press the "Start now" button
	
	#page content
	
	Then I see "Check what you can claim for jury service" on the page
	Then I see "Will you lose any income while doing jury service?" on the page 
	And I see "This means income from an employer or self-employment. Benefits like Jobseeker's Allowance will not be affected unless you do more than 8 weeks of jury service" on the page 
	Then I click on the "My employer has told me they will pay me and then claim the money back from the court" link
	Then I see "Expenses and loss of earnings can only be reimbursed to the juror if they've suffered financial loss as a direct result of doing jury service. The court will not pay compensation to third parties like employers. If your employer will pay you, then you cannot make a claim for loss of earnings." on the page
	
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

	And I do not see link with text "Back"