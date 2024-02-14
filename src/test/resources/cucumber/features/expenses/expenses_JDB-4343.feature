Feature: Expenses_JDB-4343
	
@expenses @JDB-4343
Scenario: expensesJDB-4343 How much pay for travel
	
	Given I am on expenses on "expenses" "juror-test01"
	
	And I press the "Start now" button
	
	Then I set the radio button to "No"
	When I press the "Continue" button
	Then I set the radio button to "Yes"
	When I press the "Continue" button
	Then I set "£" to "1000,00"	
	When I press the "Continue" button
	When I check the "Public transport" checkbox
	When I press the "Continue" button
	
	Then I see "Check what you can claim for jury service" on the page
	And I see "Total cost of public transport each day" on the page
	
	#footer
	
	And I see "All content is available under the Open Government Licence v3.0, except where otherwise stated" on the page
	And I see "Cookies" on the page
	And I do not see "Privacy policy" on the page
	
	#Back link
	
	And I click on the "Back" link
	Then I see "How will you travel to the court?" on the page
	When I press the "Continue" button
	
	#page text
	
	And I see "Check what you can claim for jury service" on the page
	Then I see "Total cost of public transport each day" on the page
	Then I click on the "I have a season ticket that I can use" link
	And I see "If you've got an existing season ticket for travel, you cannot claim any part of this back because it is not an extra cost you'll need to pay." on the page
	And I see "If you do not have any extra public transport costs to claim, enter £0." on the page
  	And I see "Cost of all your tickets in £ each day" on the page

	#errors if Continue pressed with no input
	
	When I press the "Continue" button

    And under the "There is a problem" heading I see "Enter the cost of all your tickets each day"
	Then I see "Enter the cost of all your tickets each day" under the label "Cost of all your tickets in £ each day"

    #input values
	
	When I set "Cost of all your tickets in £ each day" to "Not many"
	When I press the "Continue" button

    And under the "There is a problem" heading I see "Enter the cost of all your tickets each day"
	Then I see "Enter the cost of all your tickets each day" under the label "Cost of all your tickets in £ each day"
	
	When I set "Cost of all your tickets in £ each day" to "10..00"
	When I press the "Continue" button
	
	And under the "There is a problem" heading I see "Enter the cost of all your tickets each day"
	Then I see "Enter the cost of all your tickets each day" under the label "Cost of all your tickets in £ each day"
	
	When I set "Cost of all your tickets in £ each day" to "10.00"
	When I press the "Continue" button

    And I click on the "Change" link in the same row as "Cost of public transport each day"
    And "Cost of all your tickets in £ each day" is "10.00" 
    
	When I set "Cost of all your tickets in £ each day" to "10,"
	Then I press the "Continue" button
	
	When I click on the "Change" link in the same row as "Cost of public transport each day"
	Then I set "Cost of all your tickets in £ each day" to ",00"
    When I press the "Continue" button

	When I click on the "Change" link in the same row as "Cost of public transport each day"
	Then I set "Cost of all your tickets in £ each day" to ".00"
	When I press the "Continue" button

	And under the "There is a problem" heading I see "Enter the cost of all your tickets each day"
	Then I see "Enter the cost of all your tickets each day" under the label "Cost of all your tickets in £ each day"
	
	Then I set "Cost of all your tickets in £ each day" to "<10"
	When I press the "Continue" button
	
	And under the "There is a problem" heading I see "Enter the cost of all your tickets each day"
	Then I see "Enter the cost of all your tickets each day" under the label "Cost of all your tickets in £ each day"

	Then I set "Cost of all your tickets in £ each day" to "10.2"
	When I press the "Continue" button
	And I see "Check your answers" on the page
	And I see text "10.2" in the same row as "Cost of public transport each day"
	
	When I click on the "Change" link in the same row as "Cost of public transport each day"
	
	Then I set "Cost of all your tickets in £ each day" to " 10"
	When I press the "Continue" button
	And I see "Check your answers" on the page
	And I see text "10" in the same row as "Cost of public transport each day"
	
	When I click on the "Change" link in the same row as "Cost of public transport each day"
	
	Then I set "Cost of all your tickets in £ each day" to "10 "
	When I press the "Continue" button
	And I see "Check your answers" on the page
	And I see text "10" in the same row as "Cost of public transport each day"
	
	When I click on the "Change" link in the same row as "Cost of public transport each day"
	
	Then I set "Cost of all your tickets in £ each day" to "10 00"
	When I press the "Continue" button
	
	And under the "There is a problem" heading I see "Enter the cost of all your tickets each day"
	Then I see "Enter the cost of all your tickets each day" under the label "Cost of all your tickets in £ each day"
	
	When I press the "Continue" button
	
	And I see "Check your answers" on the page
	And I see text "10.00" in the same row as "Cost of public transport each day"
	
	When I click on the "Change" link in the same row as "Cost of public transport each day"
	
	Then I set "Cost of all your tickets in £ each day" to "10/12"
	When I press the "Continue" button
	
	And under the "There is a problem" heading I see "Enter the cost of all your tickets each day"
	Then I see "Enter the cost of all your tickets each day" under the label "Cost of all your tickets in £ each day"
	
	When I press the "Continue" button
	And I see "Check your answers" on the page
	And I see text "10.00" in the same row as "Cost of public transport each day"
	
	When I click on the "Change" link in the same row as "Cost of public transport each day"

	When I set "Cost of all your tickets in £ each day" to "10-00"
	When I press the "Continue" button
	
	And under the "There is a problem" heading I see "Enter the cost of all your tickets each day"
	Then I see "Enter the cost of all your tickets each day" under the label "Cost of all your tickets in £ each day"
	
	When I set "Cost of all your tickets in £ each day" to "10.00"
	When I press the "Continue" button
	
	And I see "Check your answers" on the page
	And I see text "£10.00" in the same row as "Cost of public transport each day"
	
	When I click on the "Change" link in the same row as "Cost of public transport each day"
	
	When I set "Cost of all your tickets in £ each day" to "1000000.00"
	When I press the "Continue" button
	And I see "Check your answers" on the page
	And I see text "1000000.00" in the same row as "Cost of public transport each day"

	When I click on the "Change" link in the same row as "Cost of public transport each day"
	
	Then I set "Cost of all your tickets in £ each day" to "£10"
	When I press the "Continue" button
	And I see "Check your answers" on the page
	And I see text "10" in the same row as "Cost of public transport each day"
	
	When I click on the "Change" link in the same row as "Cost of public transport each day"
	
	Then I set "Cost of all your tickets in £ each day" to "10,00"
	When I press the "Continue" button
	And I see "Check your answers" on the page
	And I see text "1000.00" in the same row as "Cost of public transport each day"
	
	When I click on the "Change" link in the same row as "Cost of public transport each day"
	
	Then I set "Cost of all your tickets in £ each day" to "0"
	When I press the "Continue" button
	And I see "Check your answers" on the page
	And I see text "0" in the same row as "Cost of public transport each day"

