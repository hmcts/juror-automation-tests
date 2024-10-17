Feature: Expenses_JDB-4327

@JDB-4327 @expenses
Scenario: expensesJDB-4327 Start Page
	
	Given I am on expenses on "expenses" "juror-test01"
	
	Then I see "Check what you can claim for jury service" on the page
	And I see "Use this calculator to work out what you can claim for doing 10 days of jury service." on the page
	And I see "This calculator:" on the page
	And I see "will give you an estimate of what you can claim" on the page
	And I see "is for your information only" on the page
	And I see "does not send a claim or your details to the courts" on the page
	And I see "You'll need to make your actual expenses claim by filling in a paper form at the end of your jury service." on the page
	And I see "Before you start" on the page
	And I see "You will need details about:" on the page
	And I see "your income" on the page
	And I see "you expect to spend travelling to court" on the page
	And I see "other expenses such as childcare or carer costs" on the page
#	And I see "is also available in Welsh (Cymraeg)" on the page

#	When I click on the "Welsh (Cymraeg)" link
#	Then I see "Welsh title" on the page
	And I see the Gov licence description on the page
	Then I press the "Start now" button
	Then I see "Will you lose any income while doing jury service?" on the page
