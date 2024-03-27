Feature: Expenses_JDB-4341

@expenses @JDB-4341
Scenario: expensesJDB-4341 Parking - how much
	
	Given I am on expenses on "expenses" "juror-test01"
	
	And I press the "Start now" button
	
	Then I choose the "No" radio button
	When I press the "Continue" button
	Then I choose the "Yes" radio button
	When I press the "Continue" button
	Then I set "£" to "1000.00"	
	When I press the "Continue" button
	When I check the "Car" checkbox
	When I press the "Continue" button
	Then I set "Miles each day" to "10.2"
	When I press the "Continue" button
	
	#footer
	
	And I see "All content is available under the Open Government Licence v3.0, except where otherwise stated" on the page
	And I see "Cookies" on the page
	And I do not see "Privacy policy" on the page
	
	#Back link
	
	And I click on the "Back" link
	Then I see "How will you travel to the court" on the page
	When I press the "Continue" button
	
	#page text
	
	And I see "Check what you can claim for jury service" on the page
	Then I see "Will you need to pay for parking?" on the page

	#none selected by default
	
	And the radio button "Yes" is "unselected"
	And the radio button "No" is "unselected"
	
	#errors if Continue pressed with none selected
	
	When I press the "Continue" button

    And under the "There is a problem" heading I see "Please select yes or no"
	Then I see "Please select yes or no" on the page
	
	#Select Yes
	
	Then I choose the "Yes" radio button
	Then the radio button "Yes" is "selected"
	Then the radio button "No" is "unselected"

	#Select No
	
	Then I choose the "No" radio button
	Then the radio button "No" is "selected"
	Then the radio button "Yes" is "unselected"
	
	#continue
	
	When I press the "Continue" button
	Then I see "Check your answers" on the page

