Feature: Expenses_JDB-4345_JDB-4348

@expenses @JDB-4345 @JDB-4348 
Scenario Outline: expensesJDB-4345_RoundUp
	
	Given I am on expenses on "expenses" "test"
	
	And I press the "Start now" button
	
	#loseincome
	Then I choose the "Yes" radio button
	When I press the "Continue" button
	
	#earnmorethan
	Then I choose the "No" radio button
	When I press the "Continue" button
	
	#dailyearnings
	Then I set "£ each day" to "<earnings>"	
	When I press the "Continue" button
	
	#otherexpenses
	Then I choose the "Yes" radio button
	When I press the "Continue" button
	
	#dailyexpenses
	Then I set "£ each day" to "<expenses>"	
	When I press the "Continue" button
	
	#traveltypes
	When I check the "Bicycle" checkbox
	When I check the "Car" checkbox
	When I check the "Motorcycle" checkbox
	When I check the "Public transport" checkbox
	When I check the "Walking" checkbox
	When I press the "Continue" button
	
	#setbikemiles
	Then I set "Miles each day" to "<bikeMiles>"	
	When I press the "Continue" button
	
	#setcarmiles
	Then I set "Miles each day" to "<carMiles>"	
	When I press the "Continue" button
	
	#setmotorbikemiles
	Then I set "Miles each day" to "<motorbikeMiles>"	
	When I press the "Continue" button
	
	#payforparking?
	Then I choose the "Yes" radio button
	When I press the "Continue" button
	
	#cantclaimforparking
	When I press the "Continue" button
	
	#publictransportcosts
	Then I set "Cost of all your tickets in £ each day" to "<publicTransport>"	
	When I press the "Continue" button
	
	#checkyouranswers
	When I press the "Continue" button
	
	#pagetext
	
	Then I see "Check what you can claim for jury service" on the page
	Then I see "You should be able to claim" on the page
	
	And I see "£<totalClaim> per day" on the page
	
	Then I see "This is assuming:" on the page 
	Then I see "the details you have entered are correct" on the page
	Then I see "your jury service lasts up to 10 days" on the page 
	Then I see "each day you will be at court for at least 4 hours" on the page 
	
	Then I see "How we calculated this" on the page 
	
	And under the "How we calculated this" heading I see "Loss of earnings and other expenses"
	
	Then I see "You can claim £<canClaim> for each day you'll lose income or have extra costs from doing jury service" on the page
	
	Then I click on the "How have my loss of earnings and expenses been calculated?" link
	
	And on Expenses I see "<earnings> each day" under "Loss of earnings"
	
	And on Expenses I see "<expenses> each day" under "Other expenses"
	
	And on Expenses I see "<earningsAndExpenses> each day" under "Total"
	
	And on Expenses I see "£<canClaim> is the maximum amount that you can claim per day within the first 10 days of jury service. For days shorter than 4 hours this is reduced to £32.47" under "Total"
	
	And under the "How we calculated this" heading I see "Travel"
	
	Then I see "You can claim £<totalTravel> for each day you travel to court" on the page 
	
	Then I click on the "How have my travel expenses been calculated?" link
	
	And on Expenses I see "<carMiles> miles at 31.4p per mile = <carExpenses>" under "Car mileage"
	
	And on Expenses I see "<motorbikeMiles> miles at 31.4p per mile = <motorbikeExpenses>" under "Motorcycle mileage"
	
	And on Expenses I see "<bikeMiles> miles at 31.4p per mile = <bikeExpenses>" under "Bicycle mileage"
	
	And on Expenses I see "<publicTransport> each day" under "Travel tickets"

	Then on Expenses I see "<totalTravel> each day" under "Total"
	
	And I see "This does not include parking costs because you'll need to check with the court first if they will pay for your parking." on the page
	And I see "Once your jury service has started, if you offer to bring other jurors to court in your car, you can claim an additional 4.2p per mile for the first passenger, and another 3.2p per mile for every other passenger." on the page
	
	Then I see "Food and drink" on the page 

	And I see "You can claim £5.71 each day, even if you bring in your own food and drink" on the page
	
	And I see "For more information about how expenses are calculated and how changes in your jury service can affect the amount you can claim, read what you can claim" on the page
	
   #footer
	
	And I see "All content is available under the Open Government Licence v3.0, except where otherwise stated" on the page
	And I see "Cookies" on the page
	And I do not see "Privacy policy" on the page
	
	#back link
	
	Then I click on the "Back" link
	And I see "Check your answers" on the page
	When I press the "Continue" button
	
	Then I click on the "what you can claim" link
	And I see "www.gov.uk/jury-service" in the URL
	
	Then I press the "back" button on my browser
	
	Then I click on the "'Find a Court or Tribunal' service" link
	And I see "find-court-tribunal.service.gov.uk" in the URL
	
	Then I press the "back" button on my browser

	Then I click on the "Start again" link
	And I see "Will you lose any income while doing jury service?" on the page

Examples:
	|earnings	|expenses	|canClaim	|earningsAndExpenses|publicTransport|carMiles	|carExpenses|motorbikeMiles	|motorbikeExpenses	|bikeMiles|bikeExpenses	|totalTravel|totalClaim	|
#noroundup
	|43.83		|54.22		|64.95		|98.05				|20.15			|2.5		|0.79		|2.5			|0.79				|2.5      |0.24			|21.97		|92.63		|
#backendroundupwithdecplaces
	|29.87		|57.00		|64.95		|86.87				|20.99			|2.8		|0.88		|2.8			|0.88				|2.9      |0.28			|23.03		|93.69		|
#backendroundupwholenumbers
	|29			|57			|64.95		|86					|21				|1			|0.31		|1				|0.31				|2	      |0.19			|21.81		|92.47		|
#earningsandinputexpensestotallessthan64.95
	|20			|14.50		|34.50		|34.50				|21				|1			|0.31		|1				|0.31				|2	      |0.19			|21.81		|62.02		|
#displaysearningsandexpenses30
	|20			|10			|30.00		|30					|21				|1			|0.31		|1				|0.31				|2	      |0.19			|21.81		|57.52		|
#displaystravel21.80
	|20			|14.50		|34.50		|34.50				|20.99			|1			|0.31		|1				|0.31				|2	      |0.19			|21.80		|62.01		|
	
@expenses @JDB-4345 @JDB-4348
Scenario Outline: expensesJDB-4345_earnings>64.95andexpenses=0
	
	Given I am on expenses on "expenses" "juror-test01"
	
	And I press the "Start now" button
	
	#loseincome
	Then I choose the "Yes" radio button
	When I press the "Continue" button
	
	#earnmorethan
	Then I choose the "No" radio button
	When I press the "Continue" button
	
	#dailyearnings
	Then I set "£ each day" to "<earnings>"	
	When I press the "Continue" button
	
	#otherexpenses
	Then I choose the "Yes" radio button
	When I press the "Continue" button
	
	#dailyexpenses
	Then I set "£ each day" to "<expenses>"	
	When I press the "Continue" button
	
	#traveltypes
	When I check the "Bicycle" checkbox
	When I check the "Car" checkbox
	When I check the "Motorcycle" checkbox
	When I check the "Public transport" checkbox
	When I check the "Walking" checkbox
	When I press the "Continue" button
	
	#setbikemiles
	Then I set "Miles each day" to "<bikeMiles>"	
	When I press the "Continue" button
	
	#setcarmiles
	Then I set "Miles each day" to "<carMiles>"	
	When I press the "Continue" button
	
	#setmotorbikemiles
	Then I set "Miles each day" to "<motorbikeMiles>"	
	When I press the "Continue" button
	
	#payforparking?
	Then I choose the "Yes" radio button
	When I press the "Continue" button
	
	#cantclaimforparking
	When I press the "Continue" button
	
	#publictransportcosts
	Then I set "Cost of all your tickets in £ each day" to "<publicTransport>"	
	When I press the "Continue" button
	
	#checkyouranswers
	When I press the "Continue" button
	
	#pagetext
	
	Then I see "You should be able to claim" on the page
	
	And I see "£<totalClaim> per day" on the page
	
	Then I see "This is assuming:" on the page 
	Then I see "the details you have entered are correct" on the page
	Then I see "your jury service lasts up to 10 days" on the page 
	Then I see "each day you will be at court for at least 4 hours" on the page 
	
	Then I see "How we calculated this" on the page 
	
	And under the "How we calculated this" heading I see "Loss of earnings and other expenses"
	
	Then I see "You can claim £<canClaim> for each day you'll lose income or have extra costs from doing jury service" on the page 
	
	Then I click on the "How have my loss of earnings and expenses been calculated?" link
	
	And on Expenses I see "<earnings> each day" under "Loss of earnings"
	
	And under the "How we calculated this" heading I do not see "Other expenses"
	
	And on Expenses I see "<earningsAndExpenses> each day" under "Total"
	
	And I see "£64.95 is the maximum amount that you can claim per day within the first 10 days of jury service. For days shorter than 4 hours this is reduced to £32.47" on the page
	
	Then I do not see "Travel" on the page 
	
	Then I do not see link with text "How have my travel expenses been calculated?"
	
	And I do not see "Car mileage" on the page
	
	And I do not see "Motorcycle mileage" on the page
	
	And I do not see "Bicycle mileage" on the page
	
	And I do not see "Travel tickets" on the page

	Then I do not see "£<totalTravel> each day" on the page
	
	And I do not see "This does not include parking costs because you'll need to check with the court first if they will pay for your parking." on the page
	And I do not see "Once your jury service has started, if you offer to bring other jurors to court in your car, you can claim an additional 4.2p per mile for the first passenger, and another 3.2p per mile for every other passenger." on the page
	
	Then I see "Food and drink" on the page 

	And I see "You can claim £5.71 each day, even if you bring in your own food and drink" on the page
	
	And I see "For more information about how expenses are calculated and how changes in your jury service can affect the amount you can claim, read what you can claim" on the page
	
   	#footer
	
	And I see "All content is available under the Open Government Licence v3.0, except where otherwise stated" on the page
	And I see "Cookies" on the page
	And I do not see "Privacy policy" on the page
	
	Then I click on the "what you can claim" link
	And I see "www.gov.uk/jury-service" in the URL
	
	Then I press the "back" button on my browser
	
	Then I click on the "'Find a Court or Tribunal' service" link
	And I see "find-court-tribunal.service.gov.uk" in the URL
	
	Then I press the "back" button on my browser

	Then I click on the "Start again" link
	And I see "Will you lose any income while doing jury service?" on the page

Examples:
	|earnings	|expenses	|canClaim	|earningsAndExpenses|publicTransport|carMiles	|carExpenses|motorbikeMiles	|motorbikeExpenses	|bikeMiles|bikeExpenses	|totalTravel|totalClaim	|
#earnings>64.95andexpenses=0	
	|70.00		|0.00		|64.95		|70.00				|0				|0			|0			|0				|0					|0		  |0			|0			|70.66		|


@expenses @JDB-4345 @JDB-4348
Scenario Outline: expensesJDB-4345_0earningsandexpenses>or<64.95
	
	Given I am on expenses on "expenses" "juror-test01"
	
	And I press the "Start now" button
	
	#loseincome
	Then I choose the "Yes" radio button
	When I press the "Continue" button
	
	#earnmorethan
	Then I choose the "No" radio button
	When I press the "Continue" button
	
	#dailyearnings
	Then I set "£ each day" to "<earnings>"	
	When I press the "Continue" button
	
	#otherexpenses
	Then I choose the "Yes" radio button
	When I press the "Continue" button
	
	#dailyexpenses
	Then I set "£ each day" to "<expenses>"	
	When I press the "Continue" button
	
	#traveltypes
	When I check the "Bicycle" checkbox
	When I check the "Car" checkbox
	When I check the "Motorcycle" checkbox
	When I check the "Public transport" checkbox
	When I check the "Walking" checkbox
	When I press the "Continue" button
	
	#setbikemiles
	Then I set "Miles each day" to "<bikeMiles>"	
	When I press the "Continue" button
	
	#setcarmiles
	Then I set "Miles each day" to "<carMiles>"	
	When I press the "Continue" button
	
	#setmotorbikemiles
	Then I set "Miles each day" to "<motorbikeMiles>"	
	When I press the "Continue" button
	
	#payforparking?
	Then I choose the "Yes" radio button
	When I press the "Continue" button
	
	#cantclaimforparking
	When I press the "Continue" button
	
	#publictransportcosts
	Then I set "Cost of all your tickets in £ each day" to "<publicTransport>"	
	When I press the "Continue" button
	
	#checkyouranswers
	When I press the "Continue" button
	
	#pagetext
	
	Then I see "You should be able to claim" on the page
	
	And I see "£<totalClaim> per day" on the page
	
	Then I see "This is assuming:" on the page 
	Then I see "the details you have entered are correct" on the page
	Then I see "your jury service lasts up to 10 days" on the page 
	Then I see "each day you will be at court for at least 4 hours" on the page 
	
	And under the "How we calculated this" heading I see "Loss of earnings and other expenses"
	
	Then I see "You can claim £<canClaim> for each day you'll lose income or have extra costs from doing jury service" on the page 
	
	Then I click on the "How have my loss of earnings and expenses been calculated?" link
	
	And under the "How we calculated this" heading I do not see "<earnings> each day"
	
	And on Expenses I see "<expenses> each day" under "Other expenses"
	
	And on Expenses I see "<earningsAndExpenses> each day" under "Total"
	
	And I see "£<upperClaim> is the maximum amount that you can claim per day within the first 10 days of jury service. For days shorter than 4 hours this is reduced to £32.47" on the page
	
	Then I see "You can claim £<totalTravel> for each day you travel to court" on the page 
	
	Then I click on the "How have my travel expenses been calculated?" link
	
	And on Expenses I see "<carMiles> miles at 31.4p per mile = <carExpenses>" under "Car mileage"
	
	And on Expenses I see "<motorbikeMiles> miles at 31.4p per mile = <motorbikeExpenses>" under "Motorcycle mileage"
	
	And on Expenses I see "<bikeMiles> miles at 31.4p per mile = <bikeExpenses>" under "Bicycle mileage"
	
	And on Expenses I see "<publicTransport> each day" under "Travel tickets"

	Then on Expenses I see "<totalTravel> each day" under "Total"
	
	And I see "This does not include parking costs because you'll need to check with the court first if they will pay for your parking." on the page
	And I see "Once your jury service has started, if you offer to bring other jurors to court in your car, you can claim an additional 4.2p per mile for the first passenger, and another 3.2p per mile for every other passenger." on the page
	
	Then I see "Food and drink" on the page 

	And I see "You can claim £5.71 each day, even if you bring in your own food and drink" on the page
	
	And I see "For more information about how expenses are calculated and how changes in your jury service can affect the amount you can claim, read what you can claim" on the page
	
   #footer
	
	And I see "All content is available under the Open Government Licence v3.0, except where otherwise stated" on the page
	And I see "Cookies" on the page
	And I do not see "Privacy policy" on the page
	
	Then I click on the "what you can claim" link
	And I see "www.gov.uk/jury-service" in the URL
	
	Then I press the "back" button on my browser
	
	Then I click on the "'Find a Court or Tribunal' service" link
	And I see "find-court-tribunal.service.gov.uk" in the URL
	
	Then I press the "back" button on my browser

	Then I click on the "Start again" link
	And I see "Will you lose any income while doing jury service?" on the page

Examples:
	|earnings	|expenses	|canClaim	|upperClaim	|earningsAndExpenses|publicTransport|carMiles	|carExpenses|motorbikeMiles	|motorbikeExpenses	|bikeMiles|bikeExpenses	|totalTravel|totalClaim	|
#earnings0expenses<64.95
	|0.00		|14.55		|14.55		|64.95		|14.55				|20.99			|1			|0.31		|1				|0.31				|2	      |0.19			|21.80		|42.06		|
#earnings0andexpenses>64.94
	|0.00		|70.55		|64.95		|64.95		|70.55				|20.99			|1			|0.31		|1				|0.31				|2	      |0.19			|21.80		|92.46		|
