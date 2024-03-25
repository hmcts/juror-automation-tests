Feature: Expenses_JDB-4338

@expenses @JDB-4338 
Scenario: expensesJDB-4338 Travel to Court
	
	Given I am on expenses on "expenses" "juror-test02"
	
	And I press the "Start now" button	
	
	Then I choose the "No" radio button
	When I press the "Continue" button
	Then I choose the "Yes" radio button
	When I press the "Continue" button
	Then I set "£" to "1000,00"	
	When I press the "Continue" button
	
	#footer
	
	And I see "All content is available under the Open Government Licence v3.0, except where otherwise stated" on the page
	And I see "Cookies" on the page
	And I do not see "Privacy policy" on the page
	
	#Back link
	
	And I click on the "Back" link
	Then I see "Will doing jury service mean you have extra costs that you wouldn't normally have?" on the page
	When I press the "Continue" button
	When I press the "Continue" button
	
	#page text
	
	Then I see "Check what you can claim for jury service" on the page
	Then I see "How will you travel to the court?" on the page
	And I see "Select all that apply. For example, you may need to drive to a station before taking public transport" on the page
	Then I click on the "Taxis" link
	And I see "You cannot usually claim for taxis. If you have no alternative apart from taking a taxi to court, contact the court to discuss this." on the page
	
	#errors if Continue pressed with no input
	
	When I press the "Continue" button

    And under the "There is a problem" heading I see "Please select at least one method of getting to the court"
	Then I see "Please select at least one method of getting to the court" on the page
	
	#check all boxes
	
	When I check the "Bicycle" checkbox
	When I check the "Car" checkbox
	When I check the "Motorcycle" checkbox
	When I check the "Public transport" checkbox
	When I check the "Walking" checkbox
	Then "Bicycle" is checked
	Then "Car" is checked
	Then "Motorcycle" is checked
	Then "Public transport" is checked
	Then "Walking" is checked
	
	#uncheck all boxes
	
	When I uncheck the "Bicycle" checkbox
	When I uncheck the "Car" checkbox
	When I uncheck the "Motorcycle" checkbox
	When I uncheck the "Public transport" checkbox
	When I uncheck the "Walking" checkbox
	Then "Bicycle" is unchecked
	Then "Car" is unchecked
	Then "Motorcycle" is unchecked
	Then "Public transport" is unchecked
	Then "Walking" is unchecked
	
	#check 2 boxes
	When I check the "Walking" checkbox
	When I check the "Public transport" checkbox
	
	#continue
	
	When I press the "Continue" button
	Then I see "Total cost of public transport each day" on the page

