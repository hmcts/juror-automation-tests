Feature: Regression_English_AccountLocked

@Regression @NewSchemaConverted
Scenario Outline: 1st Party Account Locked

	Given I am on "Public" "test"

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
	
#@JDB-2678
	Then I see "For security reasons, your account has been locked due to multiple failed login attempts and you can no longer reply online. Please contact the Jury Central Summoning Bureau for more information - our details are below in the 'I do not have a juror number' section." on the page
	
Examples:
	| juror_number	| last_name	| postcode	| pool_number	|
	| 045200095		| LNAME1129	| CH1 2AN	| 452300094		|

@Regression @NewSchemaConverted
Scenario Outline: 3rd Party Account Locked

	Given I am on "Public" "test"

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
	
#@JDB-2678
#JDB-3667
	Then I see "For security reasons, this account has been locked due to multiple failed login attempts and you can no longer reply online. Please contact the Jury Central Summoning Bureau for more information - our details are below in the 'I do not have a juror number' section." on the page
	And I do not see any links on the page that open to a new page without an alt text

Examples:
	| juror_number	| last_name			| postcode	| pool_no	|
	| 045200096		| LNAMEFOURSIXONE	| CH1 2AN	| 452300095	|