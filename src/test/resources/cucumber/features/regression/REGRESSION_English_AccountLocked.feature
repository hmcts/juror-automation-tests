Feature: Regression_English_AccountLocked

@Regression @Sprint01 @Account_Locked @JDB-2678 @JDB-3516 @JDB-3667
Scenario Outline: 1st Party Account Locked
	Given I am on "Public" "juror-test01"
	
	Given the juror numbers have not been processed
		| part_no 	| pool_no 	| owner |
		| <part_no> |<pool_no>	| 400 	|
		
	
	And "<part_no>" has "LNAME" as "<last_name>" 
	And "<part_no>" has "RET_DATE" as "5 mondays time"
	And "<part_no>" has "NEXT_DATE" as "5 mondays time"
	And "<part_no>" has "ZIP" as "<postcode>"

#1st_English	

	Then I see "Reply to a jury summons" on the page
	
#start now	

	
	And I do not see any links on the page that open to a new page without an alt text
	
#replying for myself

	And I set the radio button to "I am replying for myself"
	And I press the "Continue" button
	And I do not see any links on the page that open to a new page without an alt text

#log on attempt #1	

	When I set "9-digit juror number" to "<part_no>"
	When I set "Juror last name" to "Smith"
	When I set "Juror postcode" to "SW17 7SR"
	And I press the "Continue" button	
	Then I see "Your combination of name, postcode and Juror number are not recognised." on the page
	
#log on attempt #2

	When I set "9-digit juror number" to "<part_no>"
	When I set "Juror last name" to "Smith"
	When I set "Juror postcode" to "SW17 7SR"
	And I press the "Continue" button	
	Then I see "Your combination of name, postcode and Juror number are not recognised." on the page
	
#log on attempt #3

	When I set "9-digit juror number" to "<part_no>"
	When I set "Juror last name" to "Smith"
	When I set "Juror postcode" to "SW17 7SR"
	And I press the "Continue" button	
	Then I see "Your combination of name, postcode and Juror number are not recognised." on the page
	
#log on attempt #4

	When I set "9-digit juror number" to "<part_no>"
	When I set "Juror last name" to "Smith"
	When I set "Juror postcode" to "SW17 7SR"
	And I press the "Continue" button	
	And I do not see any links on the page that open to a new page without an alt text
	
#@JDB-2678

	Then I see "For security reasons, your account has been locked due to multiple failed login attempts and you can no longer reply online. Please contact the Jury Central Summoning Bureau for more information - our details are below in the 'I do not have a juror number' section." on the page
	
Examples:
	|part_no		|last_name			|postcode	|email 		| pool_no	|
	|841501129		|LNAME1129			|CH1 2AN	|b@eeee.com	| 415181001	|

@Regression @Account_Locked @JDB-2678 @JDB-3667
Scenario Outline: 3rd Party Account Locked
	Given I am on "Public" "juror-test01"
	Given the juror numbers have not been processed
		| part_no 	| pool_no 	| owner |
		| <part_no> |<pool_no>	| 400 	|
	
	And "<part_no>" has "LNAME" as "<last_name>" 
	And "<part_no>" has "RET_DATE" as "5 mondays time"
	And "<part_no>" has "NEXT_DATE" as "5 mondays time"
	And "<part_no>" has "ZIP" as "<postcode>"

	
	Then I see "Reply to a jury summons" on the page
	And I do not see any links on the page that open to a new page without an alt text
	
	And I do not see any links on the page that open to a new page without an alt text

	And I set the radio button to "I am replying for someone else"
	And I press the "Continue" button
	And I do not see any links on the page that open to a new page without an alt text

#log on attempt #1	

	When I set "9-digit juror number" to "<part_no>"
	When I set "Juror last name" to "Smith"
	When I set "Juror postcode" to "SW17 7SR"
	And I press the "Continue" button	
	Then I see "The combination of name, postcode and Juror number are not recognised." on the page
	And I do not see any links on the page that open to a new page without an alt text
	
#log on attempt #2

	When I set "9-digit juror number" to "<part_no>"
	When I set "Juror last name" to "Smith"
	When I set "Juror postcode" to "SW17 7SR"
	And I press the "Continue" button	
	Then I see "The combination of name, postcode and Juror number are not recognised." on the page
	And I do not see any links on the page that open to a new page without an alt text
	
#log on attempt #3

	When I set "9-digit juror number" to "<part_no>"
	When I set "Juror last name" to "Smith"
	When I set "Juror postcode" to "SW17 7SR"
	And I press the "Continue" button	
	Then I see "The combination of name, postcode and Juror number are not recognised." on the page
	And I do not see any links on the page that open to a new page without an alt text
	
#log on attempt #4

	When I set "9-digit juror number" to "<part_no>"
	When I set "Juror last name" to "Smith"
	When I set "Juror postcode" to "SW17 7SR"
	And I press the "Continue" button	
	And I do not see any links on the page that open to a new page without an alt text
	
#@JDB-2678
#JDB-3667

	Then I see "For security reasons, this account has been locked due to multiple failed login attempts and you can no longer reply online. Please contact the Jury Central Summoning Bureau for more information - our details are below in the 'I do not have a juror number' section." on the page
	And I do not see any links on the page that open to a new page without an alt text
Examples:
	|part_no		|last_name			|postcode	|email 		| pool_no	|
	|741500461		|LNAMEFOURSIXONE	|CH1 2AN	|b@eeee.com	| 415181001	|


