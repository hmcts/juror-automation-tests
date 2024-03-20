Feature: Environment Smoke Tests - Bureau

@SmokeTest @SmokeTest_Bureau @pod 
Scenario: 
	Given I am on "Bureau" "test"
	Given PCQs has been disabled
	And I have deleted all holidays new schema

	And I see "Sign in" on the page
	And I log in as "MODTESTBUREAU"
	Then I see "To do" on the page
	
	Then I click on the "Search" link
	And I see "Advanced search" on the page
	When I click on the "Advanced search" link
	And I check the Urgent checkbox on Search screen

	And I press the "Search" button

	And I see "results for "is urgent"" on the page
	
	When I click on "041" in the same row as "MODTESTBUREAU"
	And I see "Juror details" on the page

	
	
	
	
	
	
	
	
	
