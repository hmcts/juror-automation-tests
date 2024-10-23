Feature: Expenses_JDB-4376
	
@expenses @JDB-4376
Scenario: expensesJDB-4376
	
	Given I am on expenses on "expenses" "juror-test01"

    And I press the "Start now" button
	
	Then I see "Will you lose any income while doing jury service?" on the page
	And I choose the "No" radio button
	When I press the "Continue" button
	
	Then I see "Check what you can claim for jury service" on the page
	
	Then I see "Will doing jury service mean you have extra costs that you wouldn't normally have?" on the page
 
	And I click on the "Claiming Expenses for childcare or care of elderly or vulnerable adults" link
	And I see "You can claim for extra costs you incur for childcare or the care of an elderly or vulnerable adult during your jury service" on the page
	    
	Then I see "You cannot claim back costs that you'd normally pay for" on the page 

	And I see "you work and usually use a childminder, you cannot claim this childcare cost for the days you'd normally work" on the page 

	Then I see "If someone takes annual leave to look after your child" on the page
	And I see "You cannot claim their salary back because their employer will normally pay them during their annual leave" on the page 
	
	Then I see "If friends or family provide care and charge you for this" on the page
	Then I see "You can claim up to £2.50 per hour, per child or adult towards this cost." on the page 
	Then I see "You can claim this for up to 8 hours for each day at court" on the page 
	And I see "This person must provide a letter to the court with their full details, days and times they've cared for your child or any adult before the expenses will be paid." on the page 
	
	#footer
	
	And I see the Gov licence description on the page
	And I see "Cookies" on the page
	And I do not see "Privacy policy" on the page
	
	#back link
	
	Then I click on the "Back" link
	And I see "Will doing jury service mean you have extra costs that you wouldn't normally have?" on the page
	And I choose the "No" radio button
	When I press the "Continue" button
	And I see "How will you travel to the court?" on the page