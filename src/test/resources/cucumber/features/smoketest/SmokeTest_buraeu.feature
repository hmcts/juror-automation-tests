Feature: Environment Smoke Tests - Bureau

@SmokeTest @SmokeTest_Bureau @pod 
Scenario: 
	Given I am on "Bureau" "test"
	Given PCQs has been disabled new schema
	And I have deleted all holidays new schema

	And I see "Sign in" on the page
	And I log in as "MODTESTBUREAU"
	Then I see "To do" on the page

	And I select the global search
	And I see "Advanced juror search" on the page
	When I click on the "Advanced juror search" link
	And I set "Juror name" to "DOE"

	And I press the "Search" button

	And I select the first juror in the search results
	And I see "Juror details" on the page

	
	
	
	
	
	
	
	
	
