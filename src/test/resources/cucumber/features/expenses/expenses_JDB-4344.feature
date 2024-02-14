Feature: Expenses_JDB-4344

@expenses @JDB-4344 
Scenario: expenses-JDB-4344 
	
	Given I am on expenses on "expenses" "juror-test01"
	
	Then I see "Check what you can claim for jury service" on the page
	
	And I press the "Start now" button
		
	Then I set the radio button to "Yes"
	When I press the "Continue" button
	Then I set the radio button to "No"
	When I press the "Continue" button
	Then I set "£ each day" to "25"
	When I press the "Continue" button
	Then I set the radio button to "Yes"
	When I press the "Continue" button
	Then I set "£ each day" to "10"	
	When I press the "Continue" button
	When I check the "Bicycle" checkbox
	When I check the "Car" checkbox
	When I check the "Motorcycle" checkbox
	When I check the "Public transport" checkbox
	When I check the "Walking" checkbox
	When I press the "Continue" button
	Then I set "Miles each day" to "2"	
	When I press the "Continue" button
	Then I set "Miles each day" to "2"	
	When I press the "Continue" button
	Then I set "Miles each day" to "2"	
	When I press the "Continue" button
	Then I set the radio button to "Yes"
	When I press the "Continue" button
	When I press the "Continue" button
	Then I set "Cost of all your tickets in £ each day" to "20"	
	When I press the "Continue" button
	
	#page text

	Then I see "Check your answers" on the page
	
	#footer
	
	And I see "All content is available under the Open Government Licence v3.0, except where otherwise stated" on the page
	And I see "Cookies" on the page
	And I do not see "Privacy policy" on the page
	
	#change lose income
	
	And I see "Loss of earnings" on the page
	And I see text "Yes" in the same row as "Will you lose income?"
	And I click on the "Change" link in the same row as "Will you lose income?"
	
	And I set the radio button to "No"
	When I press the "Continue" button
	Then I see "Check your answers" on the page
	And I see text "No" in the same row as "Will you lose income?"
	
	And I click on the "Change" link in the same row as "Will you lose income?"
	
	And I set the radio button to "Yes"
	When I press the "Continue" button
	And I set the radio button to "No"
	When I press the "Continue" button
	Then I set "£ each day" to "25"	
	When I press the "Continue" button
	Then I see "Check your answers" on the page
	And I see text "Yes" in the same row as "Will you lose income?"
	
	#change how much do you earn
	
	And I see text "No" in the same row as "Do you earn more than "
	And I see text "25.00" in the same row as "How much do you earn each day?"
	And I click on the "Change" link in the same row as "How much do you earn each day?"
	
	And I set "£ each day" to "30"
	When I press the "Continue" button
	Then I see "Check your answers" on the page
	And I see text "30.00" in the same row as "How much do you earn each day?"
	
	#change extra costs
	
	And I see "Other expenses" on the page
	And I see text "Yes" in the same row as "Extra costs you wouldn't normally have?"
	And I click on the "Change" link in the same row as "Extra costs you wouldn't normally have?"
	
	And I set the radio button to "No"
	When I press the "Continue" button
	Then I see "Check your answers" on the page
	And I see text "No" in the same row as "Extra costs you wouldn't normally have?"
	
	#change travel types
	
	And I see "Travel" on the page
	And I see text "Bicycle,Car,Motorcycle,Public transport,Walking" in the same row as "How will you travel to court?"
	And I click on the "Change" link in the same row as "How will you travel to court?"
	
	And I uncheck the "Walking" checkbox
	When I press the "Continue" button
	Then I see "Check your answers" on the page
	And I see text "Bicycle,Car,Motorcycle,Public transport" in the same row as "How will you travel to court?"
	
	#change bicycle miles
	
	And I see text "2 miles" in the same row as "Miles by bicycle each day"
	And I click on the "Change" link in the same row as "Miles by bicycle each day"
	
	And I set "Miles each day" to "5"
	When I press the "Continue" button
	Then I see "Check your answers" on the page
	And I see text "5 miles" in the same row as "Miles by bicycle each day"
	
	#change car miles
	
	And I see text "2 miles" in the same row as "Miles by car each day"
	And I click on the "Change" link in the same row as "Miles by car each day"
	
	And I set "Miles each day" to "5"
	When I press the "Continue" button
	Then I see "Check your answers" on the page
	And I see text "5 miles" in the same row as "Miles by car each day"
	
	#change motorcycle miles
	
	And I see text "2 miles" in the same row as "Miles by motorcycle each day"
	And I click on the "Change" link in the same row as "Miles by motorcycle each day"
	
	And I set "Miles each day" to "5"
	When I press the "Continue" button
	Then I see "Check your answers" on the page
	And I see text "5 miles" in the same row as "Miles by motorcycle each day"

	#change public transport miles
	
	And I see text "20.00" in the same row as "Cost of public transport each day"
	And I click on the "Change" link in the same row as "Cost of public transport each day"
	
	And I set "Cost of all your tickets in £ each day" to "25"
	When I press the "Continue" button
	Then I see "Check your answers" on the page
	And I see text "25.00" in the same row as "Cost of public transport each day"
	
	When I press the "Continue" button
	Then I see "You should be able to claim" on the page
	And I see "Start again" on the page
