Feature: Expenses_JDB-4340
	
@expenses @JDB-4340
Scenario: expensesJDB-4340 How many miles - car

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
	
	#footer
	
	And I see the Gov licence description on the page
	And I see "Cookies" on the page
	And I do not see "Privacy policy" on the page
	
	#Back link
	
	And I click on the "Back" link
	Then I see "?" on the page
	When I press the "Continue" button
	
	#page text
	
	And I see "Check what you can claim for jury service" on the page
	Then I see "Total miles you'll travel each day by car" on the page
	And I see "Miles each day" on the page
	
	#errors if Continue pressed with no input
	
	When I press the "Continue" button
    And under the "There is a problem" heading I see "Enter how many miles you'll travel by car each day"
	Then I see "Enter how many miles you'll travel by car each day" under the label "Miles each day"
	
	#input values
	
	When I set "Miles each day" to "Not many"
	When I press the "Continue" button
	
    And under the "There is a problem" heading I see "Enter how many miles you'll travel by car each day"
	Then I see "Enter how many miles you'll travel by car each day" under the label "Miles each day"

	Then I set "Miles each day" to "10..00"
	When I press the "Continue" button

    And under the "There is a problem" heading I see "Enter how many miles you'll travel by car each day"
	Then I see "Enter how many miles you'll travel by car each day" under the label "Miles each day"
	
	Then I set "Miles each day" to ",00"
	When I press the "Continue" button

    And under the "There is a problem" heading I see "Enter how many miles you'll travel by car each day"
	Then I see "Enter how many miles you'll travel by car each day" under the label "Miles each day"

	Then I set "Miles each day" to "£10"
	When I press the "Continue" button

    And under the "There is a problem" heading I see "Enter how many miles you'll travel by car each day"
	Then I see "Enter how many miles you'll travel by car each day" under the label "Miles each day"
	
	Then I set "Miles each day" to "<10"
	When I press the "Continue" button

    And under the "There is a problem" heading I see "Enter how many miles you'll travel by car each day"
	Then I see "Enter how many miles you'll travel by car each day" under the label "Miles each day"

	Then I set "Miles each day" to "10,"
	When I press the "Continue" button

    And under the "There is a problem" heading I see "Enter how many miles you'll travel by car each day"
	Then I see "Enter how many miles you'll travel by car each day" under the label "Miles each day"
	
	Then I set "Miles each day" to ".00"
	When I press the "Continue" button

    And under the "There is a problem" heading I see "Enter how many miles you'll travel by car each day"
	Then I see "Enter how many miles you'll travel by car each day" under the label "Miles each day"
	
	#allowed
	
	Then I set "Miles each day" to "10/12"
	When I press the "Continue" button
	
	And under the "There is a problem" heading I see "Enter how many miles you'll travel by car each day"
	Then I see "Enter how many miles you'll travel by car each day" under the label "Miles each day"
	
	Then I set "Miles each day" to "0"
	When I press the "Continue" button
	
	#payforparking?
	Then I choose the "No" radio button
	When I press the "Continue" button
	
	When I click on the "Change" link in the same row as "Miles by car each day"
	
	Then I set "Miles each day" to "1000000.00"
	When I press the "Continue" button
	
	When I click on the "Change" link in the same row as "Miles by car each day"
	
	Then I set "Miles each day" to "10,00"
	When I press the "Continue" button
	
	And under the "There is a problem" heading I see "Enter how many miles you'll travel by car each day"
	Then I see "Enter how many miles you'll travel by car each day" under the label "Miles each day"
	
	Then I set "Miles each day" to "10-00"
	When I press the "Continue" button
	
	And under the "There is a problem" heading I see "Enter how many miles you'll travel by car each day"
	Then I see "Enter how many miles you'll travel by car each day" under the label "Miles each day"
	
	Then I set "Miles each day" to "10 00"
	When I press the "Continue" button
	
	And under the "There is a problem" heading I see "Enter how many miles you'll travel by car each day"
	Then I see "Enter how many miles you'll travel by car each day" under the label "Miles each day"
	
	Then I set "Miles each day" to "10 "
	When I press the "Continue" button

	When I click on the "Change" link in the same row as "Miles by car each day"
	
	Then I set "Miles each day" to " 10"
	When I press the "Continue" button

	When I click on the "Change" link in the same row as "Miles by car each day"
	
	Then I set "Miles each day" to "10.2"
	When I press the "Continue" button

	#continue
	
	When I press the "Continue" button
	Then I see "You should be able to claim" on the page
	