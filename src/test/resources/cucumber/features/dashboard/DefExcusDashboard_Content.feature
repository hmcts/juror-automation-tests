Feature: Deferral and Excusal Dashboard

@dashboard 
Scenario: Dashboard - Content
	Given I am on "defexcusdash" "juror-test02"
	
	And I see "Juror Deferrals & Excusals" on the page
	And I see "This dashboard displays information on juror deferrals and excusals." on the page
	And I see "Configure Report" on the page
	
	Then I see "Deferrals/Excusals" on the page
	Then I see "Bureau/Court" on the page
	Then I see "Calendar Year" on the page
	Then I see "Financial Year" on the page
	Then I see "From" on the page
	Then I see "To" on the page
	Then I see "Reasons:" on the page
	
	When I select "All" from the "deferralExcusal" dropdown on the Dashboard
	When I select "All" from the "bureauCourt" dropdown on the Dashboard
	
	When I select "2020" from the "calYear" dropdown on the Dashboard
	When I select "2020/21" from the "finYear" dropdown on the Dashboard
	
	And I press the "Select all" button
	And I press the "Select none" button
	
	And I press the "Submit" button

	And I see "Deferrals/Excusals by Bureau/Court: 01-04-2020 to 31-03-2021" on the page
	
@dashboard 
Scenario: Dashboard - Vary parameters
	Given I am on "defexcusdash" "juror-test02"
	
	And I see "Juror Deferrals & Excusals" on the page
	
	#Deferrals/Excusals

	When I select "Deferrals" from the "deferralExcusal" dropdown on the Dashboard
	When I select "Excusals" from the "deferralExcusal" dropdown on the Dashboard
	When I select "All" from the "deferralExcusal" dropdown on the Dashboard
	
	#Bureau/Court
	
	When I select "Bureau" from the "bureauCourt" dropdown on the Dashboard
	When I select "Court" from the "bureauCourt" dropdown on the Dashboard
	When I select "All" from the "bureauCourt" dropdown on the Dashboard
	
	#Calendar Year
	
	When I select "2015" from the "calYear" dropdown on the Dashboard
	When I select "2016" from the "calYear" dropdown on the Dashboard
	When I select "2017" from the "calYear" dropdown on the Dashboard
	When I select "2018" from the "calYear" dropdown on the Dashboard
	When I select "2019" from the "calYear" dropdown on the Dashboard
	When I select "2020" from the "calYear" dropdown on the Dashboard
	When I select "2021" from the "calYear" dropdown on the Dashboard
	
	#Financial Year
	
	When I select "2015/16" from the "finYear" dropdown on the Dashboard
	When I select "2016/17" from the "finYear" dropdown on the Dashboard
	When I select "2017/18" from the "finYear" dropdown on the Dashboard
	When I select "2018/19" from the "finYear" dropdown on the Dashboard
	When I select "2019/20" from the "finYear" dropdown on the Dashboard
	When I select "2020/21" from the "finYear" dropdown on the Dashboard
	When I select "2021/22" from the "finYear" dropdown on the Dashboard
	
	#manually set date fields
	
	When I set input field with "id" of "startDate" to "99/01/2019"
	And I set input field with "id" of "endDate" to "99/12/2019"
	
	And I press the "Submit" button
	
	When I set input field with "id" of "startDate" to "01/01/2019"
	And I set input field with "id" of "endDate" to "31/12/2019"
	
	#Reasons
	
	And I press the "Select all" button
	Then "Deceased" is checked
	Then "Recently Served" is checked
	Then "The Forces" is checked
	Then "Postponement Of Service" is checked
	Then "Religious Reasons" is checked
	Then "Child Care" is checked
	Then "Work Related" is checked
	Then "Medical" is checked
	Then "Travelling Difficulties" is checked
	Then "Moved From Area" is checked
	Then "Other" is checked
	Then "Student" is checked
	Then "Language Difficulties" is checked
	Then "Holiday" is checked
	Then "Carer" is checked
	Then "Works In Administration Of Justice" is checked
	Then "Mental Health" is checked
	Then "Excuse By Bureau, Too Many Jurors" is checked
	
	And I press the "Select none" button
	Then "Deceased" is unchecked
	Then "Recently Served" is unchecked
	Then "The Forces" is unchecked
	Then "Postponement Of Service" is unchecked
	Then "Religious Reasons" is unchecked
	Then "Child Care" is unchecked
	Then "Work Related" is unchecked
	Then "Medical" is unchecked
	Then "Travelling Difficulties" is unchecked
	Then "Moved From Area" is unchecked
	Then "Other" is unchecked
	Then "Student" is unchecked
	Then "Language Difficulties" is unchecked
	Then "Holiday" is unchecked
	Then "Carer" is unchecked
	Then "Works In Administration Of Justice" is unchecked
	Then "Mental Health" is unchecked
	Then "Excuse By Bureau, Too Many Jurors" is unchecked
	
	#Check count for Excusals/Deferrals with reason Deceased cal year 2020
#	
#	When I select "2020" from the "calYear" dropdown on the Dashboard
#	When I select "All" from the "deferralExcusal" dropdown on the Dashboard
#	When I select "All" from the "bureauCourt" dropdown on the Dashboard
#	And I check the "Deceased" checkbox
#	And I press the "Submit" button
#	
#	And I see "Deferrals/Excusals by Bureau/Court: 01-01-2020 to 31-12-2020" on the page
#	And I see "Deceased (1986)" on the page
#	
#	#Check count for Excusals with reason Deceased cal year 2020
#	
#	When I select "Excusals" from the "deferralExcusal" dropdown on the Dashboard
#	And I press the "Submit" button
#	And I see "Excusals by Bureau/Court: 01-01-2020 to 31-12-2020" on the page
#	And I see "Deceased (1985)" on the page
#	
#	#Check count for Deferrals with reason Deceased cal year 2020
#	
#	When I select "Deferrals" from the "deferralExcusal" dropdown on the Dashboard
#	And I press the "Submit" button
#	And I see "Deferrals by Bureau/Court: 01-01-2020 to 31-12-2020" on the page
#	And I see "Deceased (1)" on the page