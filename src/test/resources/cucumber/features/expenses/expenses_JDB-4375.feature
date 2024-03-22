Feature: Expenses_JDB-4375
	
@expenses @JDB-4375
Scenario: expensesJDB-4375
	
	Given I am on expenses on "expenses" "juror-test01"

	And I press the "Start now" button
	
	#loseincome
	Then I choose the "Yes" radio button
	When I press the "Continue" button
	
	#earnmorethan
	Then I choose the "No" radio button
	When I press the "Continue" button

	#Back link
	
	And I click on the "Back" link
	Then I see "Do you earn more than £64.95 each day on the days you work?" on the page
	When I press the "Continue" button
	
	#footer
	
	And I see "All content is available under the Open Government Licence v3.0, except where otherwise stated" on the page
	And I see "Cookies" on the page
	And I do not see "Privacy policy" on the page
	
	#page content
	
	Then I see "Check what you can claim for jury service" on the page
	
	Then I see "How much do you earn each day?" on the page 
	And I see "Enter the amount you receive from all employment, self employment or as a company director, each day" on the page 
	
	Then I see "£ each day" on the page 
	
	Then I see "Continue" on the page
	And I click on the "Where can I find this information?" link
	And I see "You can find this on your payslip, P60 or tax return. It will be shown as 'Net Pay'." on the page
	
	#errors if Continue pressed with no input
	
	When I press the "Continue" button

    And under the "There is a problem" heading I see "Enter how much you earn each day"
	Then I see "Enter how much you earn each day" under the label "£ each day"

    #input values
	
	When I set "£ each day" to "Not much"
	When I press the "Continue" button

    And under the "There is a problem" heading I see "Enter how much you earn each day"
	Then I see "Enter how much you earn each day" under the label "£ each day"
	
	When I set "£ each day" to "10..00"
	When I press the "Continue" button
	
	And under the "There is a problem" heading I see "Enter how much you earn each day"
	Then I see "Enter how much you earn each day" under the label "£ each day"
    
	When I set "£ each day" to "10,"
	Then I press the "Continue" button
	
	And I click on the "Back" link
	When I press the "Continue" button
	When I press the "Continue" button

	Then I set "£ each day" to ",00"
    When I press the "Continue" button

	And I click on the "Back" link
	When I press the "Continue" button
	When I press the "Continue" button
	
	Then I set "£ each day" to ".00"
	When I press the "Continue" button
	
	And under the "There is a problem" heading I see "Enter how much you earn each day"
	Then I see "Enter how much you earn each day" under the label "£ each day"

	Then I set "£ each day" to "<10"
	When I press the "Continue" button
	
	And under the "There is a problem" heading I see "Enter how much you earn each day"
	Then I see "Enter how much you earn each day" under the label "£ each day"

	Then I set "£ each day" to "10.2"
	When I press the "Continue" button
	And I click on the "Back" link
	When I press the "Continue" button
	When I press the "Continue" button
	
	Then I set "£ each day" to " 10"
	When I press the "Continue" button
	And I click on the "Back" link
	When I press the "Continue" button
	When I press the "Continue" button
	
	And "£ each day" is "10.00"
	Then I set "£ each day" to "10 "
	When I press the "Continue" button
	And I click on the "Back" link
	When I press the "Continue" button
	When I press the "Continue" button
	
	And "£ each day" is "10.00"
	Then I set "£ each day" to "10 00"
	When I press the "Continue" button
	
	And under the "There is a problem" heading I see "Enter how much you earn each day"
	Then I see "Enter how much you earn each day" under the label "£ each day"
	
	Then I set "£ each day" to "10/12"
	When I press the "Continue" button
	
	And under the "There is a problem" heading I see "Enter how much you earn each day"
	Then I see "Enter how much you earn each day" under the label "£ each day"
	
	When I set "£ each day" to "10-00"
	When I press the "Continue" button
	
	And under the "There is a problem" heading I see "Enter how much you earn each day"
	Then I see "Enter how much you earn each day" under the label "£ each day"
	
	When I set "£ each day" to "1000000.00"
	When I press the "Continue" button
	And I click on the "Back" link
	When I press the "Continue" button
	When I press the "Continue" button
	
	And "£ each day" is "1000000.00"
	Then I set "£ each day" to "£10"
	When I press the "Continue" button
	And I click on the "Back" link
	When I press the "Continue" button
	When I press the "Continue" button
	
	Then I set "£ each day" to "10,00"
	When I press the "Continue" button
	And I click on the "Back" link
	When I press the "Continue" button
	When I press the "Continue" button
	
	Then I set "£ each day" to "0"
	When I press the "Continue" button
	And I click on the "Back" link
	When I press the "Continue" button
	When I press the "Continue" button
	And "£ each day" is "0.00"

	