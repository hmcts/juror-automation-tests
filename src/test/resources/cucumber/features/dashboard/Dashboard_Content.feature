Feature: Dashboard

@dashboard @ostest
Scenario: Dashboard - Content
	Given I am on "Dashboard" "juror-test01"
	
	And I see "Reply to a jury summons" on the page
	And I see "This dashboard shows information about how the Reply to a jury summons service is currently performing." on the page
	And I see "These figures are valid from July 2018 when the service launched." on the page
	
	Then I see "Total summonses sent" on the page
	Then I see "Number of online replies" on the page
	Then I see "Digital take-up" on the page
	
	And I see link with text "contact the product manager"
	Then I see "These figures are since August 2019 when more detailed reporting was implemented. If you require data before August 2019 please contact the product manager, Janet Healey." on the page
	Then I see "Select a monthly date range" on the page
	
	When I select "January" from the "startMonth" dropdown on the Dashboard
	When I select "2020" from the "startYear" dropdown on the Dashboard
	
	When I select "December" from the "endMonth" dropdown on the Dashboard
	When I select "2020" from the "endYear" dropdown on the Dashboard
	
	And I press the "Submit" button

	Then I see "Number of summonses sent" on the page
	And I see "Replied" on the page
	And I see "Not replied" on the page
	
	And I see "How did the citizen respond?" on the page
	Then I see "Online (Total)" on the page
	Then I see "Online (Welsh)" on the page
	And I see "By post" on the page
	#Then I see "*This is the number of summons replies that have been returned by citizens but are either waiting to be processed by jury summonsing officers or have been received late and processed by the court." on the page

	Then I see "Who replied to the summons online?" on the page
	And I see "Juror" on the page
	And I see "Third party" on the page
	Then I see "How many online replies were automatically processed?" on the page
	And I see "Automatically processed" on the page
	Then I see "When were replies received?" on the page


	Then I see "Levels of citizen satisfaction" on the page
	And I see "Percentage of citizens completing a feedback form" on the page
	And I see "Percentage of citizens 'Very satisfied or satisfied'" on the page
	
	And I see "Very satisfied" on the page
	And I see "Satisfied" on the page
	And I see "Neither satisfied or dissatisfied" on the page
	And I see "Dissatisfied" on the page
	And I see "Very dissatisfied" on the page
            	
	
	
	
	