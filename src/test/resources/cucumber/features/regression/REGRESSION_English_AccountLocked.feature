Feature: Regression_English_AccountLocked

@Regression
Scenario Outline: 1st Party Account Locked

	Given I am on "Public" "ithc"

	Given a bureau owned pool is created with jurors
		| court |juror_number  | pool_number	| att_date_weeks_in_future	| owner |
		| 452   |<juror_number>| <pool_number>	| 5				            | 400	|

	And juror "<juror_number>" has "LAST_NAME" as "<last_name>" new schema
	And juror "<juror_number>" has "POSTCODE" as "<postcode>" new schema

#1st_English
	Then I see "Reply to a jury summons" on the page
	
#start now
	And I do not see any links on the page that open to a new page without an alt text
	
#replying for myself
	And I set the radio button to "I am replying for myself"
	And I press the "Continue" button
	And I do not see any links on the page that open to a new page without an alt text

#log on attempt #1
	When I set "9-digit juror number" to "<juror_number>"
	When I set "Juror last name" to "Smith"
	When I set "Juror postcode" to "SW17 7SR"
	And I press the "Continue" button	
	Then I see "Your combination of name, postcode and Juror number are not recognised." on the page
	
#log on attempt #2
	When I set "9-digit juror number" to "<juror_number>"
	When I set "Juror last name" to "Smith"
	When I set "Juror postcode" to "SW18 9QT"
	And I press the "Continue" button	
	Then I see "Your combination of name, postcode and Juror number are not recognised." on the page
	
#log on attempt #3
	When I set "9-digit juror number" to "<juror_number>"
	When I set "Juror last name" to "Smith"
	When I set "Juror postcode" to "SW18 9QT"
	And I press the "Continue" button	
	Then I see "Your combination of name, postcode and Juror number are not recognised." on the page
	
#log on attempt #4
	When I set "9-digit juror number" to "<juror_number>"
	When I set "Juror last name" to "Smith"
	When I set "Juror postcode" to "SW18 9QT"
	And I press the "Continue" button	
	And I do not see any links on the page that open to a new page without an alt text
	
#@JM-8228
	Then I see "You've tried to sign in too many times" on the page
	And I see "Your summons reply is now locked. Try again in 30 minutes." on the page
	And I see "Enter your name and postcode exactly as shown on your summons letter, even if they're incorrect. You can correct them later." on the page
	And I see "If you still have problems, contact us." on the page
	
Examples:
	| juror_number	| last_name	| postcode	| pool_number	|
	| 045200095		| LNAME1129	| CH1 2AN	| 452300094		|

@Regression
Scenario Outline: 3rd Party Account Locked

	Given I am on "Public" "ithc"

	Given a bureau owned pool is created with jurors
		| court |juror_number  | pool_number	| att_date_weeks_in_future	| owner |
		| 452   |<juror_number>| <pool_number>	| 5				            | 400	|

	And juror "<juror_number>" has "LAST_NAME" as "<last_name>" new schema
	And juror "<juror_number>" has "POSTCODE" as "<postcode>" new schema

	Then I see "Reply to a jury summons" on the page
	And I do not see any links on the page that open to a new page without an alt text
	
	And I do not see any links on the page that open to a new page without an alt text

	And I set the radio button to "I am replying for someone else"
	And I press the "Continue" button
	And I do not see any links on the page that open to a new page without an alt text

#log on attempt #1
	When I set "9-digit juror number" to "<juror_number>"
	When I set "Juror last name" to "Smith"
	When I set "Juror postcode" to "SW18 9QT"
	And I press the "Continue" button	
	Then I see "The combination of name, postcode and Juror number are not recognised." on the page
	And I do not see any links on the page that open to a new page without an alt text
	
#log on attempt #2
	When I set "9-digit juror number" to "<juror_number>"
	When I set "Juror last name" to "Smith"
	When I set "Juror postcode" to "SW18 9QT"
	And I press the "Continue" button	
	Then I see "The combination of name, postcode and Juror number are not recognised." on the page
	And I do not see any links on the page that open to a new page without an alt text
	
#log on attempt #3
	When I set "9-digit juror number" to "<juror_number>"
	When I set "Juror last name" to "Smith"
	When I set "Juror postcode" to "SW18 9QT"
	And I press the "Continue" button	
	Then I see "The combination of name, postcode and Juror number are not recognised." on the page
	And I do not see any links on the page that open to a new page without an alt text
	
#log on attempt #4
	When I set "9-digit juror number" to "<juror_number>"
	When I set "Juror last name" to "Smith"
	When I set "Juror postcode" to "SW18 9QT"
	And I press the "Continue" button	
	And I do not see any links on the page that open to a new page without an alt text
	
#@JM-8228
	Then I see "You've tried to sign in too many times" on the page
	And I see "The summons reply is now locked. Try again in 30 minutes." on the page
	And I see "Enter the person's name and postcode exactly as shown on their summons letter, even if they're incorrect. You can correct them later." on the page
	And I see "If you still have problems, contact us." on the page

Examples:
	| juror_number	| last_name			| postcode	| pool_number	|
	| 045200096		| LNAMEFOURSIXONE	| CH1 2AN	| 452300095		|