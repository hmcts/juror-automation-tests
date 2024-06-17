Feature: Environment Smoke Tests - Public

@SmokeTest 
Scenario: 
	Given I am on "Public" "test"
	Given PCQs has been disabled new schema
	Then I see "Reply to a jury summons" on the page
	
	And I set the radio button to "I am replying for myself"
	And I press the "Continue" button
	Then I see "Your juror details" on the page

	When I set "9-digit juror number" to ""
	And I set "Juror last name" to ""
	And I set "Juror postcode" to ""
	
	When I press the "Continue" button
	Then I see "Enter your 9-digit juror number - you can find it on your jury summons letter" on the page
	And I see "Enter your last name" on the page
	And I see "Enter your postcode" on the page

	When I set "9-digit juror number" to ""
	And I set "Juror last name" to ""
	And I set "Juror postcode" to ""

	When I set "9-digit juror number" to "123456789"
	And I press the "Continue" button
	Then I do not see "Enter your 9-digit" on the page

	And I see "Enter your last name" on the page
	And I see "Enter your postcode" on the page
	
	
	
	
	
	
	
	
