Feature: Bureau E Test

@Regression @NewSchemaConverted
Scenario: Bureau E Test

	Given I am on "Bureau" "test"

	And staff with name "AutomationStaff1" does not exist new schema
	And staff with name "AutomationStaff2" does not exist new schema

	And I log in as "SYSTEMADMIN"

	And I see "administration/users" in the URL

	And I press the "Create new user" button

	And I press the "Continue" button
	Then I see "Select a user type" on the page

	And I choose the "Bureau" radio button
	And I press the "Continue" button

	And I press the "Continue" button

	Then I see "Enter the user's full name" on the page
	And I see "Enter the user's email" on the page

	And I click on the "Cancel" link

	And I press the "Create new user" button

	And I choose the "Bureau" radio button
	And I press the "Continue" button

	And I set "Full name" to "AutomationStaffMemberONE"
	And I set "Email" to "AutomationStaff1@email.com"
	And "Manager" is unchecked
	And I press the "Continue" button
	And I press the "Create user" button

	And I click on the "Back to users" link

	Then I see "AutomationStaffMemberONE" on the page

	When I click on "AutomationStaffMemberONE" in the same row as "AutomationStaffMemberONE"
	Then I see "AutomationStaffMemberONE" in the same row as "Full name"
	Then I see "AutomationStaff1@email.com" in the same row as "Email"
	Then I see "Bureau" in the same row as "User type"

	And I press the "Edit user" button

	When I set "Full name" to "AutomationStaffMemberTWO"
	And I set "Email" to "AutomationStaff2@email.com"
	And the radio button "Active" is "selected"
	And I press the "Save changes" button

	Then I do not see "AutomationStaffMemberONE" on the page
	And I see "AutomationStaffMemberTWO" on the page

	And I click on the "Back to users" link

	Then I do not see "AutomationStaffMemberONE" on the page
	And I see "AutomationStaffMemberTWO" on the page

@JDB-2928 @JDB-2637
Scenario: Bureau Team Picklist Name Change
	Given I am on "Bureau" "test"
	Given test team is deleted
	And I log in as "MODTESTBUREAU"

	When I click on the "Manage team" link
	And I press the "Add a new team member" button
	And I set "Name" to "Team Pick List User"
	And I set "Username" to "TeamPickListUser"
	And I press the "Save" button

	Then I see "Team Pick List User" on the page
