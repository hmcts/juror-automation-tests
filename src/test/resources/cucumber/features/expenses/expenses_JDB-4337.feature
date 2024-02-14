Feature: Expenses_JDB-4337

@expenses @JDB-4337
Scenario: expensesJDB-4337 Value of Additional Expenses
	
	Given I am on expenses on "expenses" "juror-test01"
	
	And I press the "Start now" button

	Then I set the radio button to "No"
	When I press the "Continue" button
	Then I set the radio button to "Yes"
	When I press the "Continue" button
	
	#footer
	
	And I see "All content is available under the Open Government Licence v3.0, except where otherwise stated" on the page
	And I see "Cookies" on the page
	And I do not see "Privacy policy" on the page
	
	#Back link
	
	And I click on the "Back" link
	Then I see "Will doing jury service mean you have extra costs that you wouldn't normally have?" on the page
	And the radio button "Yes" is "selected"
	When I press the "Continue" button
	
	#page text
	
	Then I see "Check what you can claim for jury service" on the page
	And I see "What will the total be for these extra costs each day?" on the page
	And I see "You'll need to provide evidence of these costs when making a claim. These might include invoices or a copy of your child's birth certificate. A full list of evidence needed is on the claim form." on the page
	And I see "£ each day" on the page
	
	#errors if Continue pressed with no input
	
	When I press the "Continue" button
	Then I see "Enter the total value of these extra costs each day" on the page
	
	#input values
	
	When I set "£" to "Not Much"
	And I press the "Continue" button
	And under the "There is a problem" heading I see "Enter the total value of these extra costs each day"
	Then I see "Enter the total value of these extra costs each day" under the label "£ each day"
		
	Then I set "£" to "1000..00"
	And I press the "Continue" button
	
	And under the "There is a problem" heading I see "Enter the total value of these extra costs each day"
	Then I see "Enter the total value of these extra costs each day" under the label "£ each day"
	
	Then I set "£ each day" to "1000,"
	And I press the "Continue" button
	
	#Back link
	
	And I click on the "Back" link
	When I press the "Continue" button
	Then "£ each day" is "1000.00" 
	
	Then I set "£" to ",000"
	And I press the "Continue" button
	
	#Back link
	
	And I click on the "Back" link
	When I press the "Continue" button
	Then "£ each day" is "0.00"
	
	Then I set "£" to ".000"
	And I press the "Continue" button
	
	#Back link
	
	And I click on the "Back" link
	When I press the "Continue" button
	Then "£ each day" is "0.00"
	
	Then I set "£" to "<1000"
	And I press the "Continue" button
	And under the "There is a problem" heading I see "Enter the total value of these extra costs each day"
	Then I see "Enter the total value of these extra costs each day" under the label "£ each day"
	
	Then I set "£" to "100/200"
	And I press the "Continue" button
	
	And under the "There is a problem" heading I see "Enter the total value of these extra costs each day"
	Then I see "Enter the total value of these extra costs each day" under the label "£ each day"
	
	Then I set "£" to "£1000"
	And I press the "Continue" button
	
	#Back link
	
	And I click on the "Back" link
	When I press the "Continue" button
	Then "£ each day" is "1000.00"
	
	Then I set "£" to "$1000"
	And I press the "Continue" button
	And under the "There is a problem" heading I see "Enter the total value of these extra costs each day"
	Then I see "Enter the total value of these extra costs each day" under the label "£ each day"
	
	Then I set "£" to "1,500.00"
	And I press the "Continue" button
	
	#Back link
	
	And I click on the "Back" link
	When I press the "Continue" button
	Then "£ each day" is "1500.00"
	
	Then I set "£" to "1000000.00"
	And I press the "Continue" button
	
	#Back link
	
	And I click on the "Back" link
	When I press the "Continue" button
	Then "£ each day" is "1000000.00"
	
	Then I set "£" to " 1000"
	And I press the "Continue" button
	
	#Back link
	
	And I click on the "Back" link
	When I press the "Continue" button
	Then "£ each day" is "1000.00"
	
	Then I set "£" to "1000 00"
	And I press the "Continue" button
	
	#Back link
	
	And I click on the "Back" link
	When I press the "Continue" button
	Then "£ each day" is "1000.00"
	
	Then I set "£" to "1000 "
	And I press the "Continue" button
	
	#Back link
	
	And I click on the "Back" link
	When I press the "Continue" button
	Then "£ each day" is "1000.00"
	
	#it allows this
	
	Then I set "£" to "100-00"
	And I press the "Continue" button
	
	And under the "There is a problem" heading I see "Enter the total value of these extra costs each day"
	Then I see "Enter the total value of these extra costs each day" under the label "£ each day"
	
	Then I set "£" to "1000,00"
	And I press the "Continue" button
	
	#Back link
	
	And I click on the "Back" link
	When I press the "Continue" button
	Then "£ each day" is "100000.00"
	
	#continue
	
	When I press the "Continue" button
	Then I see "How will you travel to the court?" on the page

