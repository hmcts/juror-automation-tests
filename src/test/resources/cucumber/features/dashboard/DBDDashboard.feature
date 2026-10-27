Feature: DBD Dashboard

@dashboard @Regression
Scenario: DBD Dashboard
	Given I am on "bureau" "ithc"

	And I log in as "SYSTEMADMIN"
	
	And I click on the "Digital by default dashboard" link

	Then I see "/digital-by-default/dashboard" in the URL
	And I see "Performance dashboard" on the page
	And I see "* At the last data refresh, this cohort was summoned within the last 6 weeks. Its response rate may still increase because of the lag between jurors being summoned and responding." on the page

	And I see "View data by" on the page
	Then I see "Select time range A" on the page
	Then I see "Choose a preset period or enter a custom date range." on the page

	And the radio button "Preset period" is "selected"
	And the radio button "Custom date range" is "unselected"

	And I see "Data comparison" on the page
	And I do not see "Select time range B" on the page
	
	When I check the "Compare with another time period" checkbox
	Then I see "Select time range B" on the page

	When I uncheck the "Compare with another time period" checkbox
	Then I do not see "Select time range B" on the page

	When I select "All courts" from the "View data by" dropdown
	And I select "Last 12 months" from the "Time period" dropdown
	And I press "Submit" button

	Then I see "Response rates by month jurors were summoned" on the page
	And I see "Total responses by court" on the page
	And I see "Response type by court" on the page
	And I see "Response times by court" on the page
	And I see "Age demographics by court" on the page
