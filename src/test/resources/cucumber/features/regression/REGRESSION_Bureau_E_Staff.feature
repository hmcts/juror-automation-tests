Feature: Bureau E Test

@Regression @NewSchemaConverted
Scenario: Bureau E Test

	Given I am on "Bureau" "test"

	And I log in
	And staff with name "AutomationStaffMemberONE" does not exist
	And staff with name "AutomationStaffMemberTWO" does not exist
	And staff with name "AutomationStaffMembe" does not exist
	
	When I click on the "Manage team" link
	And I press the "Add a new team member" button
	And I set "Name" to "AutomationStaffMemberONE"
	And I set "Username" to "AutomationStaffMembe"
	And the radio button "No" is "selected"
	And I press the "Save" button
	
	Then I see "AutomationStaffMemberONE" on the page
	
	And I press the "Add a new team member" button
	And I press the "Save" button
	Then I see "Please provide a name for the new staff member" on the page
	And I see "Please enter the staff member Juror application user name" on the page
	
	When I click on the "Manage team" link
	Then I see "Manage team" on the page
	And I see "AutomationStaffMemberONE" on the page
	
	When I click on "AutomationStaffMemberONE" in the same row as "AutomationStaffMemberONE"
	Then "Name" is "AutomationStaffMemberONE"
	And I cannot set "Username" to "abc"
	
	When I set "Name" to "AutomationStaffMemberTWO"
	And I set the radio button to "Active"
	And I press the "Save" button
	Then I do not see "AutomationStaffMemberONE" on the page
	And I see "AutomationStaffMemberTWO" on the page
	
	#defect 2637 -teamID is nulled
	When I click on "AutomationStaffMemberTWO" in the same row as "AutomationStaffMemberTWO"
	
@JDB-2928 @JDB-2637 
Scenario: Bureau Team Picklist Name Change
	Given I am on "Bureau" "test"
	Given test team is deleted
	And I log in
	
	When I click on the "Manage team" link
	And I press the "Add a new team member" button
	And I set "Name" to "Team Pick List User"
	And I set "Username" to "TeamPickListUser"
	And I press the "Save" button
	
	Then I see "Team Pick List User" on the page
