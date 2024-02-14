Feature: Bureau - launch darkly negative test

	@Regression
	Scenario Outline: Test Lead cannot see MOD functionality E2E

	  	#your work page
		Given I am on "Bureau" "test"
		And the juror numbers have not been processed
			| part_no 		| pool_no 	| owner |
			| <part_no> 	|<pool_no>	| 400 	|

	    #set up some responses
		#non-urgent
		And "<part_no>" has "LNAME" as "<last_name>"
		And "<part_no>" has "ZIP" as "<postcode>"
		And "<part_no>" has "RET_DATE" as "5 mondays time"
		And "<part_no>" has "NEXT_DATE" as "5 mondays time"

		Given I am on "Public" "test"
		And I have submitted a first party Welsh ineligibilty response
			|part_no	|pool_number|last_name		|postcode	|email 	|
			|<part_no>	|<pool_no>	| <last_name>	|<postcode>	|<email>|

		Given I am on "Bureau" "test"
		And I log in as "<user>"

		#your work

		#see juror digital functionality
		And I see "Your work" on the page
		And I see link with text "<user>"
		And I see link with text "Sign out"
		And I see link with text "To do"
		And I see link with text "Awaiting information"
		And I see link with text "Completed"
		And I see link with text "Your work"
		And I see link with text "Search"
		And I see link with text "Assign Replies"
		And I see link with text "Manage team"

		#do not see modernisation functionality
		And I do not see "Summons replies" on the page
		And I do not see link with text "Apps"
		And I do not see "Applications" on the page
		And I do not see link with text "Pool management"
		And I do not see link with text "Juror management"
		And I do not see link with text "Trial management"
		And I do not see link with text "Administration"
		And I do not see link with text "Summons management"
		And I do not see link with text "Expense management"
		And I do not see link with text "Reporting"
		And I do not see "Search for a juror record" on the page
		And I do not see "Search for a juror record by using their juror record number or using a barcode scan" on the page
		When I check the search juror button is not visible
		When I check the Apps button is not visible

		#try navigating to modernisation pages - pool-management
		And I see "/inbox" in the URL
		Given I navigate to "/pool-management" URL
		And I see "Page not found" on the page
		And I see "If you entered a web address please check it was correct." on the page
		Given I navigate to "/inbox" URL

		#try navigating to modernisation pages - summons-management
		And I see "/inbox" in the URL
		Given I navigate to "/summons-management" URL
		And I see "Page not found" on the page
		And I see "If you entered a web address please check it was correct." on the page
		Given I navigate to "/inbox" URL

		#try navigating to modernisation pages - trial-management
		And I see "/inbox" in the URL
		Given I navigate to "/trial-management" URL
		And I see "Page not found" on the page
		And I see "If you entered a web address please check it was correct." on the page
		Given I navigate to "/inbox" URL

		#try navigating to modernisation pages - juror-management
		And I see "/inbox" in the URL
		Given I navigate to "/juror-management" URL
		And I see "Page not found" on the page
		And I see "If you entered a web address please check it was correct." on the page
		Given I navigate to "/inbox" URL

		#try navigating to modernisation pages - expense-management
		And I see "/inbox" in the URL
		Given I navigate to "/expense-management" URL
		And I see "Page not found" on the page
		And I see "If you entered a web address please check it was correct." on the page
		Given I navigate to "/inbox" URL

		#try navigating to modernisation pages - reporting
		And I see "/inbox" in the URL
		Given I navigate to "/reporting" URL
		And I see "Page not found" on the page
		And I see "If you entered a web address please check it was correct." on the page
		Given I navigate to "/inbox" URL

		#try navigating to modernisation pages - administration
		And I see "/inbox" in the URL
		Given I navigate to "/administration" URL
		And I see "Page not found" on the page
		And I see "If you entered a web address please check it was correct." on the page
		Given I navigate to "/inbox" URL

		#Search page
		And I click on the "Search" link

		#I can see juror digital functionality
		And I see "Search" on the page
		And I see "Juror number" on the page
		And I see "Juror's last name" on the page
		And I see "Juror's pool number" on the page
		And I see "Advanced search" on the page

		#I do not see modernisation functionality
		And I do not see link with text "Apps"
		And I do not see "Applications" on the page
		And I do not see link with text "Pool management"
		And I do not see link with text "Juror management"
		And I do not see link with text "Trial management"
		And I do not see link with text "Administration"
		And I do not see link with text "Summons management"
		And I do not see link with text "Expense management"
		And I do not see link with text "Reporting"
		And I do not see "Search for a juror record" on the page
		And I do not see "Search for a juror record by using their juror record number or using a barcode scan" on the page
		When I check the search juror button is not visible
		When I check the Apps button is not visible

		#Assign Replies
		And I click on the "Assign Replies" link

		#can see juror digital functionality
		And I see "Assign Replies" on the page
		And I see "Send to court" backlog count label on the page
		And I see "Send to court" replies to assign count label on the page
		And I see "Send to court" assigned to staff count label on the page

		#cant see modernisation functionality
		And I do not see link with text "Apps"
		And I do not see "Applications" on the page
		And I do not see link with text "Pool management"
		And I do not see link with text "Juror management"
		And I do not see link with text "Trial management"
		And I do not see link with text "Administration"
		And I do not see link with text "Summons management"
		And I do not see link with text "Expense management"
		And I do not see link with text "Reporting"
		When I check the search juror button is not visible
		When I check the Apps button is not visible

		#summons response details

		#Search page
		And I click on the "Search" link
		And I set "Juror number" to "<part_no>"
		And I press the "Search" button

		#view page
		When I click on "<part_no>" in the same row as "<part_no>"
		And I do not see "SUMMONS REPLY" on the page
		And I do not see link with text "View juror"
		And I do not see "Service start date" on the page

		#check reasonable adjustments
		Then I click on the "Reasonable adjustments" link
		And I do not see link with text "Check court can accommodate"

		#respond summons
		When I select "Responded" from Process reply
		And I do not see "Deferral request" on the page
		And I do not see "Excusal - grant or refuse" on the page
		And I do not see "Disqualify" on the page
		And I check the "Mark juror as 'responded'" checkbox
		And I press the "Confirm" button
		Then I see "COMPLETED" on the page
		And I check the processed success banner is not visible

		#Manage team
		And I click on the "Manage team" link

		#can see JD functionality
		And I see "Manage team" on the page
		And I do not see link with text "Apps"
		And I do not see "Applications" on the page
		And I do not see link with text "Pool management"
		And I do not see link with text "Juror management"
		And I do not see link with text "Trial management"
		And I do not see link with text "Administration"
		And I do not see link with text "Summons management"
		And I do not see link with text "Expense management"
		And I do not see link with text "Reporting"
		When I check the search juror button is not visible
		When I check the Apps button is not visible

		Examples:
			|user   |part_no	|pool_no 	|last_name 	|postcode 	|email				|
			|SYSTEM |645200143	|452170401 	|LNAME		|NN1 3HQ	|email@outlook.com	|

	@Regression
	Scenario Outline: Test Lead cannot see MOD pool management link
		Given I am on "Bureau" "test"
		And I log in as "<user>"
		And I do not see link with text "Pool management"

		And I click on the "Sign out" link

		And I log in as "<user>"
		And I do not see link with text "Juror management"

		And I click on the "Sign out" link

		And I log in as "<user>"
		And I do not see link with text "Trial management"

		And I click on the "Sign out" link

		And I log in as "<user>"
		And I do not see link with text "Administration"

		And I click on the "Sign out" link

		And I log in as "<user>"
		And I do not see link with text "Summons management"

		And I click on the "Sign out" link

		And I log in as "<user>"
		And I do not see link with text "Expense management"

		And I click on the "Sign out" link

		And I log in as "<user>"
		And I do not see link with text "Reporting"

		And I click on the "Sign out" link

		And I log in as "<user>"
		When I check the search juror button is not visible

		And I click on the "Sign out" link

		And I log in as "<user>"
		#try navigating to modernisation pages - pool-management
		And I see "/inbox" in the URL
		Given I navigate to "/pool-management" URL
		And I see "Page not found" on the page
		And I see "If you entered a web address please check it was correct." on the page

		And I click on the "Sign out" link

		And I log in as "<user>"
		#try navigating to modernisation pages - summons-management
		And I see "/inbox" in the URL
		Given I navigate to "/summons-management" URL
		And I see "Page not found" on the page
		And I see "If you entered a web address please check it was correct." on the page

		And I click on the "Sign out" link

		And I log in as "<user>"
		#try navigating to modernisation pages - trial-management
		And I see "/inbox" in the URL
		Given I navigate to "/trial-management" URL
		And I see "Page not found" on the page
		And I see "If you entered a web address please check it was correct." on the page

		And I click on the "Sign out" link

		And I log in as "<user>"
		#try navigating to modernisation pages - juror-management
		And I see "/inbox" in the URL
		Given I navigate to "/juror-management" URL
		And I see "Page not found" on the page
		And I see "If you entered a web address please check it was correct." on the page

		And I click on the "Sign out" link

		And I log in as "<user>"
		#try navigating to modernisation pages - expense-management
		And I see "/inbox" in the URL
		Given I navigate to "/expense-management" URL
		And I see "Page not found" on the page
		And I see "If you entered a web address please check it was correct." on the page

		And I click on the "Sign out" link

		And I log in as "<user>"
		#try navigating to modernisation pages - reporting
		And I see "/inbox" in the URL
		Given I navigate to "/reporting" URL
		And I see "Page not found" on the page
		And I see "If you entered a web address please check it was correct." on the page

		And I click on the "Sign out" link

		And I log in as "<user>"
		#try navigating to modernisation pages - administration
		And I see "/inbox" in the URL
		Given I navigate to "/administration" URL
		And I see "Page not found" on the page
		And I see "If you entered a web address please check it was correct." on the page

		And I click on the "Sign out" link

		And I log in as "<user>"
		#Assign Replies
		And I click on the "Assign Replies" link
		#can see juror digital functionality
		And I see "Send to court" backlog count label on the page

		And I click on the "Sign out" link

		And I log in as "<user>"
		#Assign Replies
		And I click on the "Assign Replies" link
		#can see juror digital functionality
		And I see "Send to court" replies to assign count label on the page

		And I click on the "Sign out" link

		And I log in as "<user>"
		#Assign Replies
		And I click on the "Assign Replies" link
		#can see juror digital functionality
		And I see "Send to court" assigned to staff count label on the page

	Examples:
			|user   |
			|SYSTEM |

	@Regression
	Scenario Outline: I do not see "SUMMONS REPLY" on the page
		Given I am on "Public" "test"
		And the juror numbers have not been processed
			| part_no 		| pool_no 	| owner |
			| <part_no> 	|<pool_no>	| 400 	|

	    #set up some responses
		#non-urgent
		And "<part_no>" has "LNAME" as "<last_name>"
		And "<part_no>" has "ZIP" as "<postcode>"
		And "<part_no>" has "RET_DATE" as "5 mondays time"
		And "<part_no>" has "NEXT_DATE" as "5 mondays time"

		Given I am on "Public" "test"
		And I have submitted a first party English ineligibilty response
			|part_no	|pool_number|last_name		|postcode	|email 	|
			|<part_no>	|<pool_no>	| <last_name>	|<postcode>	|<email>|

		Given I am on "Bureau" "test"
		And I log in as "<user>"

		#summons response details

		#Search page
		And I click on the "Search" link
		And I set "Juror number" to "<part_no>"
		And I press the "Search" button

		#view page
		When I click on "<part_no>" in the same row as "<part_no>"
		And I do not see "SUMMONS REPLY" on the page

		Examples:
			|user   |part_no	|pool_no 	|last_name 	|postcode 	|email				|
			|SYSTEM |645200163	|452170401 	|LNAME		|NN1 3HQ	|email@outlook.com	|

	@Regression
	Scenario Outline: And I do not see link with text "View juror"
		Given I am on "Public" "test"

		And the juror numbers have not been processed
			| part_no 		| pool_no 	| owner |
			| <part_no> 	|<pool_no>	| 400 	|

	    #set up some responses
		#non-urgent
		And "<part_no>" has "LNAME" as "<last_name>"
		And "<part_no>" has "ZIP" as "<postcode>"
		And "<part_no>" has "RET_DATE" as "5 mondays time"
		And "<part_no>" has "NEXT_DATE" as "5 mondays time"

		Given I am on "Public" "test"
		And I have submitted a first party English ineligibilty response
			|part_no	|pool_number|last_name		|postcode	|email 	|
			|<part_no>	|<pool_no>	| <last_name>	|<postcode>	|<email>|

		Given I am on "Bureau" "test"
		And I log in as "<user>"

		#summons response details

		#Search page
		And I click on the "Search" link
		And I set "Juror number" to "<part_no>"
		And I press the "Search" button

		#view page
		When I click on "<part_no>" in the same row as "<part_no>"
		And I do not see link with text "View juror"

		Examples:
			|user   |part_no	|pool_no 	|last_name 	|postcode 	|email				|
			|SYSTEM |645200184	|452170401 	|LNAME		|NN1 3HQ	|email@outlook.com	|

	@Regression
	Scenario Outline: And I do not see "Service start date" on the page
		Given I am on "Public" "test"

		And the juror numbers have not been processed
			| part_no 		| pool_no 	| owner |
			| <part_no> 	|<pool_no>	| 400 	|

	    #set up some responses
		#non-urgent
		And "<part_no>" has "LNAME" as "<last_name>"
		And "<part_no>" has "ZIP" as "<postcode>"
		And "<part_no>" has "RET_DATE" as "5 mondays time"
		And "<part_no>" has "NEXT_DATE" as "5 mondays time"

		Given I am on "Public" "test"
		And I have submitted a first party English ineligibilty response
			|part_no	|pool_number|last_name		|postcode	|email 	|
			|<part_no>	|<pool_no>	| <last_name>	|<postcode>	|<email>|

		Given I am on "Bureau" "test"
		And I log in as "<user>"

		#summons response details

		#Search page
		And I click on the "Search" link
		And I set "Juror number" to "<part_no>"
		And I press the "Search" button

		#view page
		When I click on "<part_no>" in the same row as "<part_no>"
		And I do not see "Service start date" on the page

		Examples:
			|user   |part_no	|pool_no 	|last_name 	|postcode 	|email				|
			|SYSTEM |645200410	|452170401 	|LNAME		|NN1 3HQ	|email@outlook.com	|

	@Regression
	Scenario Outline: And I do not see link with text "Check court can accommodate"
		Given I am on "Public" "test"

		And the juror numbers have not been processed
			| part_no 		| pool_no 	| owner |
			| <part_no> 	|<pool_no>	| 400 	|

	    #set up some responses
		#non-urgent
		And "<part_no>" has "LNAME" as "<last_name>"
		And "<part_no>" has "ZIP" as "<postcode>"
		And "<part_no>" has "RET_DATE" as "5 mondays time"
		And "<part_no>" has "NEXT_DATE" as "5 mondays time"

		Given I am on "Public" "test"
		And I have submitted a first party English ineligibilty response
			|part_no	|pool_number|last_name		|postcode	|email 	|
			|<part_no>	|<pool_no>	| <last_name>	|<postcode>	|<email>|

		Given I am on "Bureau" "test"
		And I log in as "<user>"

		#summons response details

		#Search page
		And I click on the "Search" link
		And I set "Juror number" to "<part_no>"
		And I press the "Search" button

		#view page
		When I click on "<part_no>" in the same row as "<part_no>"

		#check reasonable adjustments
		Then I click on the "Reasonable adjustments" link
		And I do not see link with text "Check court can accommodate"

		Examples:
			|user   |part_no	|pool_no 	|last_name 	|postcode 	|email				|
			|SYSTEM |645200415	|452170401 	|LNAME		|NN1 3HQ	|email@outlook.com	|

	@Regression
	Scenario Outline: And I check the processed success banner is not visible
		Given I am on "Public" "test"
		And pool no "<pool_no>" is reset to pending allocation
		And I have cleared down the juror digital database
		And the juror numbers have not been processed
			| part_no 		| pool_no 	| owner |
			| <part_no> 	|<pool_no>	| 400 	|

	    #set up some responses
		#non-urgent
		And "<part_no>" has "LNAME" as "<last_name>"
		And "<part_no>" has "ZIP" as "<postcode>"
		And "<part_no>" has "RET_DATE" as "5 mondays time"
		And "<part_no>" has "NEXT_DATE" as "5 mondays time"

		Given I am on "Public" "test"
		And I have submitted a first party English ineligibilty response
			|part_no	|pool_number|last_name		|postcode	|email 	|
			|<part_no>	|<pool_no>	| <last_name>	|<postcode>	|<email>|

		Given I am on "Bureau" "test"
		And I log in as "<user>"

		#summons response details

		#Search page
		And I click on the "Search" link
		And I set "Juror number" to "<part_no>"
		And I press the "Search" button

		#view page
		When I click on "<part_no>" in the same row as "<part_no>"

		#respond summons
		When I respond the juror response in Juror Digital
		And I check the processed success banner is not visible

		Examples:
			|user   |part_no	|pool_no 	|last_name 	|postcode 	|email				|
			|SYSTEM |645200019	|452170401 	|LNAME		|NN1 3HQ	|email@outlook.com	|

	@Regression
	Scenario Outline: Member of Test Team cannot see MOD functionality E2E

		Given I am on "Bureau" "test"

		And the juror numbers have not been processed
			| part_no 		| pool_no 	| owner |
			| <part_no> 	|<pool_no>	| 400 	|

	    #set up some responses
		#non-urgent
		And "<part_no>" has "LNAME" as "<last_name>"
		And "<part_no>" has "ZIP" as "<postcode>"
		And "<part_no>" has "RET_DATE" as "5 mondays time"
		And "<part_no>" has "NEXT_DATE" as "5 mondays time"

		Given I am on "Public" "test"
		And I have submitted a first party English ineligibilty response
			|part_no	|pool_number|last_name		|postcode	|email 	|
			|<part_no>	|<pool_no>	| <last_name>	|<postcode>	|<email>|

		Given I am on "Bureau" "test"
		And I log in as "<user>"

		#your work

		#see juror digital functionality
		And I see "Your work" on the page
		And I see link with text "<user>"
		And I see link with text "Sign out"
		And I see link with text "To do"
		And I see link with text "Awaiting information"
		And I see link with text "Completed"
		And I see link with text "Your work"
		And I see link with text "Search"

		#do not see modernisation functionality
		And I do not see "Summons replies" on the page
		And I do not see link with text "Apps"
		And I do not see "Applications" on the page
		And I do not see link with text "Pool management"
		And I do not see link with text "Juror management"
		And I do not see link with text "Trial management"
		And I do not see link with text "Administration"
		And I do not see link with text "Summons management"
		And I do not see link with text "Expense management"
		And I do not see link with text "Reporting"
		When I check the search juror button is not visible
		When I check the Apps button is not visible

		#try navigating to modernisation pages
		And I see "/inbox" in the URL
		Given I navigate to "/pool-management" URL
		And I see "Page not found" on the page
		And I see "If you entered a web address please check it was correct." on the page
		Given I navigate to "/inbox" URL

		#try navigating to modernisation pages - summons-management
		And I see "/inbox" in the URL
		Given I navigate to "/summons-management" URL
		And I see "Page not found" on the page
		And I see "If you entered a web address please check it was correct." on the page
		Given I navigate to "/inbox" URL

		#try navigating to modernisation pages - trial-management
		And I see "/inbox" in the URL
		Given I navigate to "/trial-management" URL
		And I see "Page not found" on the page
		And I see "If you entered a web address please check it was correct." on the page
		Given I navigate to "/inbox" URL

		#try navigating to modernisation pages - juror-management
		And I see "/inbox" in the URL
		Given I navigate to "/juror-management" URL
		And I see "Page not found" on the page
		And I see "If you entered a web address please check it was correct." on the page
		Given I navigate to "/inbox" URL

		#try navigating to modernisation pages - expense-management
		And I see "/inbox" in the URL
		Given I navigate to "/expense-management" URL
		And I see "Page not found" on the page
		And I see "If you entered a web address please check it was correct." on the page
		Given I navigate to "/inbox" URL

		#try navigating to modernisation pages - reporting
		And I see "/inbox" in the URL
		Given I navigate to "/reporting" URL
		And I see "Page not found" on the page
		And I see "If you entered a web address please check it was correct." on the page
		Given I navigate to "/inbox" URL

		#try navigating to modernisation pages - administration
		And I see "/inbox" in the URL
		Given I navigate to "/administration" URL
		And I see "Page not found" on the page
		And I see "If you entered a web address please check it was correct." on the page
		Given I navigate to "/inbox" URL

		#Search page
		And I click on the "Search" link

		#I can see juror digital functionality
		And I see "Search" on the page
		And I see "Juror number" on the page
		And I see "Juror's last name" on the page
		And I see "Juror's pool number" on the page
		And I do not see "Advanced search" on the page

		And I set "Juror number" to "<part_no>"
		And I press the "Search" button

		#summons response details

		#view page
		When I click on "<part_no>" in the same row as "<part_no>"
		And I do not see "SUMMONS REPLY" on the page
		And I do not see link with text "View juror"
		And I do not see "Service start date" on the page

		#I do not see modernisation functionality
		And I do not see link with text "Apps"
		And I do not see "Applications" on the page
		And I do not see link with text "Pool management"
		And I do not see link with text "Juror management"
		And I do not see link with text "Trial management"
		And I do not see link with text "Administration"
		And I do not see link with text "Summons management"
		And I do not see link with text "Expense management"
		And I do not see link with text "Reporting"
		When I check the search juror button is not visible
		When I check the Apps button is not visible

		Examples:
			|user  	|part_no	|pool_no 	|last_name 	|postcode 	|email				|
			|ARAMIS1|645200030	|452170401 	|LNAME		|NN1 3HQ	|email@outlook.com	|
