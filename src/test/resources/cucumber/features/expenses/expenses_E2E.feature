Feature: ExpensesE2E

#expensesFullClaimE2E
#expensesNoExpensesE2E
#expensesEarnLess64E2E
#expensesPartialClaimE2E
#expensesChangeAnswersE2E
#expensesStraightThrough
#expensesNavigationTravelTypes

@expenses
Scenario: expensesFullClaimE2E
	
	Given I am on expenses on "expenses" "juror-test01"
	
	And I press the "Start now" button
	
	#loseincome
	Then I see "Will you lose any income while doing jury service?" on the page
	And I set the radio button to "Yes"
	When I press the "Continue" button
	
	#earnings
	Then I see "Do you earn more than £64.95 each day on the days you work?" on the page
	And I set the radio button to "No"
	When I press the "Continue" button

	#earningsamount
	Then I set "£ each day" to "25"	
	When I press the "Continue" button
	
	#extracosts
	Then I see "Will doing jury service mean you have extra costs that you wouldn't normally have?" on the page
	And I set the radio button to "Yes"
	When I press the "Continue" button
	
	#extracostsamount
	Then I see "What will the total be for these extra costs each day?" on the page
	And I set "£" to "30"
	When I press the "Continue" button
	
	#traveltypes
	Then I see "How will you travel to the court?" on the page
	And I check the "Bicycle" checkbox
	And I check the "Car" checkbox
	And I check the "Motorcycle" checkbox
	And I check the "Public transport" checkbox
	And I check the "Walking" checkbox
	When I press the "Continue" button
	
	#setbikemiles
	And I set "Miles each day" to "2"
	When I press the "Continue" button
	
	#setcarmiles
	And I set "Miles each day" to "2"
	When I press the "Continue" button
	
	#setmotorbikemiles
	And I set "Miles each day" to "2"
	When I press the "Continue" button
	
	#parking
	Then I see "Will you need to pay for parking?" on the page
	And I set the radio button to "Yes"
	When I press the "Continue" button
	
	#cantclaimforparking
	Then I see "Claiming for parking" on the page
	When I press the "Continue" button
	
	#publictransportcost
	Then I set "Cost of all your tickets in £ each day" to "20.99"
	When I press the "Continue" button
	
	#checkyouranswers
	Then I see "Check your answers" on the page
	And I see text "£30.00" in the same row as "Total value of extra costs"
	When I press the "Continue" button
	
	#totals	
	Then I see "You should be able to claim" on the page
	And I see "Start again" on the page
		
@expenses
Scenario: expensesNoExpensesE2E

	Given I am on expenses on "expenses" "juror-test01"
	
	And I press the "Start now" button
	
	Then I see "Will you lose any income while doing jury service?" on the page
	And I set the radio button to "No"
	When I press the "Continue" button
	
	Then I see "Will doing jury service mean you have extra costs that you wouldn't normally have?" on the page
	And I set the radio button to "No"
	When I press the "Continue" button
	
	Then I see "How will you travel to the court?" on the page
	And I check the "Walking" checkbox
	When I press the "Continue" button
	
	Then I see "Check your answers" on the page
	When I press the "Continue" button
	
	Then I see "You should be able to claim" on the page
	Then I see "£5.71 per day" on the page
	And I see "Start again" on the page

@expenses
Scenario: expensesEarnLess64E2E
	
	Given I am on expenses on "expenses" "juror-test01"
	Then I see "Check what you can claim for jury service" on the page
	
	#see if it runs now
	
	And I press the "Start now" button
	
	Then I see "Will you lose any income while doing jury service?" on the page
	And I set the radio button to "Yes"
	When I press the "Continue" button

	Then I see "Do you earn more than £64.95 each day on the days you work?" on the page
	And I set the radio button to "No"
	When I press the "Continue" button

	Then I see "How much do you earn each day?" on the page
	Then I set "£ each day" to "25"	
	When I press the "Continue" button

	Then I see "Will doing jury service mean you have extra costs that you wouldn't normally have?" on the page
	And I set the radio button to "No"
	When I press the "Continue" button

	Then I see "How will you travel to the court?" on the page
	And I check the "Public transport" checkbox
	When I press the "Continue" button

	Then I see "Total cost of public transport each day" on the page
	Then I set "Cost of all your tickets in £ each day" to "20.99"
	When I press the "Continue" button
	
	Then I see "Check your answers" on the page
	When I press the "Continue" button
	
	Then I see "You should be able to claim" on the page
	And I see "£51.70" on the page
	And I see "Start again" on the page

@expenses
Scenario: expensesPartialClaimE2E

	Given I am on expenses on "expenses" "juror-test01"
	Then I see "Check what you can claim for jury service" on the page
	
	And I press the "Start now" button

	Then I see "Will you lose any income while doing jury service?" on the page
	And I set the radio button to "No"
	When I press the "Continue" button

	Then I see "Will doing jury service mean you have extra costs that you wouldn't normally have?" on the page
	And I set the radio button to "Yes"
	When I press the "Continue" button
	
	Then I see "What will the total be for these extra costs each day?" on the page
	And I set "£" to "30"
	When I press the "Continue" button

	Then I see "How will you travel to the court?" on the page
	And I check the "Car" checkbox
	When I press the "Continue" button

	Then I see "Total miles you'll travel each day by car" on the page
	And I set "Miles" to "2"
	When I press the "Continue" button

	Then I see "Will you need to pay for parking?" on the page
	And I set the radio button to "Yes"
	When I press the "Continue" button

	Then I see "Claiming for parking" on the page
	When I press the "Continue" button
	
	Then I see "Check your answers" on the page
	When I press the "Continue" button

	Then I see "You should be able to claim" on the page
	And I see "Start again" on the page

@expenses
Scenario: expensesChangeAnswersE2E

	Given I am on expenses on "expenses" "juror-test01"
	Then I see "Check what you can claim for jury service" on the page
	
	And I press the "Start now" button

	Then I see "Will you lose any income while doing jury service?" on the page
	And I set the radio button to "Yes"
	When I press the "Continue" button
	
	Then I see "Do you earn more than £64.95 each day on the days you work?" on the page
	And I set the radio button to "Yes"
	When I press the "Continue" button

	Then I see "Will doing jury service mean you have extra costs that you wouldn't normally have?" on the page
	And I set the radio button to "Yes"
	When I press the "Continue" button

	Then I see "What will the total be for these extra costs each day?" on the page
	And I set "£" to "30"
	When I press the "Continue" button

	Then I see "How will you travel to the court?" on the page
	And I check the "Bicycle" checkbox
	And I check the "Car" checkbox
	And I check the "Motorcycle" checkbox
	And I check the "Public transport" checkbox
	And I check the "Walking" checkbox
	When I press the "Continue" button

	Then I see "Total miles you'll cycle each day" on the page
	And I set "Miles" to "2"
	When I press the "Continue" button
	Then I see "Total miles you'll travel each day by car" on the page
	And I set "Miles" to "2"
	When I press the "Continue" button
	Then I see "Total miles you'll travel each day by motorcycle" on the page
	And I set "Miles" to "2"
	When I press the "Continue" button
	Then I see "Will you need to pay for parking?" on the page
	And I set the radio button to "Yes"
	When I press the "Continue" button

	Then I see "Claiming for parking" on the page
	When I press the "Continue" button

	Then I see "Total cost of public transport each day" on the page
	And I set input field with "id" of "publicTransportAmount" to "20"
	When I press the "Continue" button

	Then I see "Check your answers" on the page
	And I see text "Yes" in the same row as "Will you lose income?"
	And I click on the "Change" link in the same row as "Will you lose income?"

	And I set the radio button to "No"
	When I press the "Continue" button
	Then I see "Check your answers" on the page
	And I see text "No" in the same row as "Will you lose income?"

	And I see text "Yes" in the same row as "Extra costs you wouldn't normally have?"
	And I click on the "Change" link in the same row as "Extra costs you wouldn't normally have?"

	And I set the radio button to "No"
	When I press the "Continue" button
	Then I see "Check your answers" on the page
	And I see text "No" in the same row as "Extra costs you wouldn't normally have?"

	And I see text "Bicycle,Car,Motorcycle,Public transport,Walking" in the same row as "How will you travel to court?"
	And I click on the "Change" link in the same row as "How will you travel to court?"

	And I uncheck the "Walking" checkbox
	When I press the "Continue" button
	Then I see "Check your answers" on the page
	And I see text "Bicycle,Car,Motorcycle,Public transport" in the same row as "How will you travel to court?"

	And I see text "2 miles" in the same row as "Miles by bicycle each day"
	And I click on the "Change" link in the same row as "Miles by bicycle each day"
	
	And I set "Miles each day" to "5"
	When I press the "Continue" button
	Then I see "Check your answers" on the page
	And I see text "5 miles" in the same row as "Miles by bicycle each day"

	And I see text "2 miles" in the same row as "Miles by car each day"
	And I click on the "Change" link in the same row as "Miles by car each day"
	
	And I set "Miles each day" to "5"
	When I press the "Continue" button
	Then I see "Check your answers" on the page
	And I see text "5 miles" in the same row as "Miles by car each day"
	
	And I see text "2 miles" in the same row as "Miles by motorcycle each day"
	And I click on the "Change" link in the same row as "Miles by motorcycle each day"
	
	And I set "Miles each day" to "5"
	When I press the "Continue" button
	Then I see "Check your answers" on the page
	And I see text "5 miles" in the same row as "Miles by motorcycle each day"
	
	And I see text "2" in the same row as "Cost of public transport each day"
	And I click on the "Change" link in the same row as "Cost of public transport each day"
	
	And I set "£ each day" to "5"
	When I press the "Continue" button
	Then I see "Check your answers" on the page
	And I see text "5.00" in the same row as "Cost of public transport each day"
	When I press the "Continue" button
	
	Then I see "You should be able to claim" on the page
	And I see "Start again" on the page

@expenses
Scenario: expensesStraightThrough

	Given I am on expenses on "expenses" "juror-test01"
	
	Then I see "Check what you can claim for jury service" on the page
	
	And I press the "Start now" button

	Then I see "Will you lose any income while doing jury service?" on the page
	And I set the radio button to "Yes"
	When I press the "Continue" button

	Then I see "Do you earn more than £64.95 each day on the days you work?" on the page
	And I set the radio button to "Yes"
	When I press the "Continue" button

	Then I see "Will doing jury service mean you have extra costs that you wouldn't normally have?" on the page
	And I set the radio button to "Yes"
	When I press the "Continue" button

	Then I see "What will the total be for these extra costs each day?" on the page
	And I set "£" to "30"
	When I press the "Continue" button

	Then I see "How will you travel to the court?" on the page
	And I check the "Bicycle" checkbox
	And I check the "Car" checkbox
	And I check the "Motorcycle" checkbox
	And I check the "Public transport" checkbox
	And I check the "Walking" checkbox
	When I press the "Continue" button

	Then I see "Total miles you'll cycle each day" on the page
	And I set "Miles" to "2"
	When I press the "Continue" button
	Then I see "Total miles you'll travel each day by car" on the page
	And I set "Miles" to "2"
	When I press the "Continue" button
	Then I see "Total miles you'll travel each day by motorcycle" on the page
	And I set "Miles" to "2"
	When I press the "Continue" button
	Then I see "Will you need to pay for parking?" on the page
	And I set the radio button to "Yes"
	When I press the "Continue" button

	Then I see "Claiming for parking" on the page
	When I press the "Continue" button

	Then I see "Total cost of public transport each day" on the page
	And I set input field with "id" of "publicTransportAmount" to "20"
	When I press the "Continue" button

	Then I see "Check your answers" on the page
	And I see text "Yes" in the same row as "Will you lose income?"
	And I see text "Yes" in the same row as "Do you earn more than "
	And I see text "Yes" in the same row as "Extra costs you wouldn't normally have?"
	And I see text "£30.00" in the same row as "Total value of extra costs"
	And I see text "Bicycle,Car,Motorcycle,Public transport,Walking" in the same row as "How will you travel to court?"
	And I see text "2 miles" in the same row as "Miles by bicycle each day"
	And I see text "2 miles" in the same row as "Miles by car each day"
	And I see text "2 miles" in the same row as "Miles by motorcycle each day"
	And I see text "£20.00" in the same row as "Cost of public transport each day"
	
	When I press the "Continue" button
	
	Then I see "You should be able to claim" on the page
	And I see "Start again" on the page

@expenses
Scenario: expensesNavigationTravelTypes
	
	Given I am on expenses on "expenses" "juror-test01"
	
	And I press the "Start now" button

	And I set the radio button to "Yes"
	When I press the "Continue" button

	And I set the radio button to "Yes"
	When I press the "Continue" button

	And I set the radio button to "Yes"
	When I press the "Continue" button

	And I set "£" to "30"
	When I press the "Continue" button

	And I check the "Bicycle" checkbox
	And I check the "Car" checkbox
	And I check the "Motorcycle" checkbox
	And I check the "Public transport" checkbox
	And I check the "Walking" checkbox
	When I press the "Continue" button

	And I set "Miles" to "2"
	When I press the "Continue" button
	And I set "Miles" to "2"
	When I press the "Continue" button
	And I set "Miles" to "2"
	When I press the "Continue" button
	And I set the radio button to "No"
	When I press the "Continue" button
	
	And I see "Total cost of public transport each day" on the page

	#Back link
	
	And I click on the "Back" link
	
	#change travel types
	
	And I see "How will you travel to the court?" on the page
	And I uncheck the "Bicycle" checkbox
	And I press the "Continue" button
	
	And I see "Total cost of public transport each day" on the page
	
	#Back link
	
	And I click on the "Back" link
	
	#change travel types
	
	And I see "How will you travel to the court?" on the page
	And I uncheck the "Car" checkbox
	And I press the "Continue" button
	
	And I see "Total cost of public transport each day" on the page
	
	#Back link
	
	And I click on the "Back" link
	
	#change travel types
	
	And I see "How will you travel to the court?" on the page
	And I uncheck the "Motorcycle" checkbox
	And I press the "Continue" button
	
	And I see "Total cost of public transport each day" on the page
	
	#Back link
	
	And I click on the "Back" link
	
	#change travel types
	
	And I see "How will you travel to the court?" on the page
	And I uncheck the "Walking" checkbox
	And I press the "Continue" button
	
	And I see "Total cost of public transport each day" on the page
	
	#Back link
	
	And I click on the "Back" link
	
	#change travel types
	
	And I see "How will you travel to the court?" on the page
	And I check the "Walking" checkbox
	And I uncheck the "Public transport" checkbox
	And I press the "Continue" button
	
	Then I see "Check your answers" on the page
	
	When I press the "Continue" button
	
	Then I see "You should be able to claim" on the page
	And I see "Start again" on the page
	
@expenses
Scenario: expensesParkingPage
	
	Given I am on expenses on "expenses" "juror-test01"
	
	And I press the "Start now" button
	
	And I set the radio button to "Yes"
	When I press the "Continue" button
	
	And I set the radio button to "Yes"
	When I press the "Continue" button
	
	And I set the radio button to "No"
	When I press the "Continue" button

	And I check the "Car" checkbox
	And I check the "Motorcycle" checkbox
	When I press the "Continue" button

	And I set "Miles" to "2"
	When I press the "Continue" button
	And I set "Miles" to "2"
	When I press the "Continue" button
	And I see "Will you need to pay for parking?" on the page
	And I set the radio button to "Yes"
	When I press the "Continue" button

	And I see "Claiming for parking" on the page

	#parking

	And I see "Not all courts will pay for parking. There may be a maximum amount that a court will pay per day. Check with the court for permission before you claim for parking." on the page
	
	And I click on the "Back" link
	
	And I see "Will you need to pay for parking?" on the page
	
	When I press the "Continue" button
	And I see "Claiming for parking" on the page
	
@expenses
Scenario: expenses survey link
	
	Given I am on expenses on "expenses" "bau-test"
	
	And I press the "Start now" button
	
	#loseincome
	Then I see "Will you lose any income while doing jury service?" on the page

	And I see "Give feedback (opens in a new window or tab)" on the page
	And I click on the "Give feedback (opens in a new window or tab)" link
	And I switch to the new window
	Then I see "Were you able to do what you needed to do today?" on the page
	And I see "https://www.smartsurvey.co.uk/s/FO8HDU/" in the URL
