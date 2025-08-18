Feature: JM-2486

  @JurorTransformationWIP
  Scenario Outline: Work Allocation - modernisation - happy path

    #this test needs to stay in single threaded as it checks assignment counts which will be more dynamic in the multi threaded execution

    Given I am on "Bureau" "test"
    And pool no "<pool_number>" is reset to pending allocation new schema

    Given a bureau owned pool is created with jurors
      | court |juror_number   | pool_number	 | att_date_weeks_in_future| owner |
      | 452	  |<juror_number4>| <pool_number>| 5				       | 400   |
      | 452	  |<juror_number5>| <pool_number>| 5				       | 400   |
      | 452	  |<juror_number6>| <pool_number>| 5				       | 400   |

#	set up some responses
#	non-urgent
    And juror "<juror_number4>" has "LAST_NAME" as "<last_name>" new schema
    And juror "<juror_number4>" has "POSTCODE" as "<postcode>" new schema

	#urgent
    And juror "<juror_number5>" has "LAST_NAME" as "<last_name>" new schema
    And juror "<juror_number5>" has "POSTCODE" as "<postcode>" new schema

	#super urgent
    And juror "<juror_number6>" has "LAST_NAME" as "<last_name>" new schema
    And juror "<juror_number6>" has "POSTCODE" as "<postcode>" new schema
#    And "<juror_number6>" is not active new schema

    Given I am on "Public" "test"
    And auto straight through processing has been disabled new schema
    And I have submitted a first party English straight through response
      | part_no			    |pool_number  | last_name	|postcode	| email |
      |<juror_number4>		|<pool_number>| <last_name>	|<postcode>	|<email>|
      |<juror_number5>		|<pool_number>| <last_name>	|<postcode>	|<email>|
      |<juror_number6>		|<pool_number>| <last_name>	|<postcode>	|<email>|

    #log on as Team Lead
    Given I am on "Bureau" "test"
    And I log in as "<user>"

    #assign replies check page content
    Then I click on the "Assign Replies" link
    And I see "Assign replies" on the page
    And I see "Number of replies in the backlog" on the page
    And I see "How many replies do you want to assign to each officer you select?" on the page
    And I see "Select the officers you want to assign these replies to" on the page

    #check team leads not in results grid
    And I do not see "MODTESTBUREAU" in the staff results grid
    And I do not see "MODTESTBUREAU" in the staff results grid

    #check responses counts are displayed
    Then I see "2" in the same row as "total" in Backlog box
    Then I see "1" in the same row as "standard" in Backlog box

    #check cpass doesnt have any assigned as yet
    And "ARAMIS1-standard" assigned replies count is "0"
    And "ARAMIS1-send" assigned replies count is "0"
    And "ARAMIS1-total" assigned replies count is "0"

    #assign the responses
    Then I set how many "Urgent" replies I want to assign to "1"
    Then I set how many "Standard" replies I want to assign to "1"
    And I check the "ARAMIS1" checkbox
    When I press the "Assign replies" button

    #check results of assignment
    And "ARAMIS1-standard" assigned replies count is "1"
    And "ARAMIS1-send" assigned replies count is "1"
    And "ARAMIS1-total" assigned replies count is "2"

    #check totals
    And "total-standard" assigned replies count is "1"
    And "total-urgent" assigned replies count is "1"
    And "total-all" assigned replies count is "2"

    #check select all/deselect all function
    Then I press the "Select all" button
    And "ARAMIS1" is checked
    Then I press the "Unselect all" button
    And "ARAMIS1" is unchecked

    And auto straight through processing has been enabled new schema

    Examples:
      |juror_number4|juror_number5|juror_number6|pool_number|last_name 	|postcode 	|email				|user          |
      |045200001	|045200002	  |045200003	|452300001 	|LNAME		|NN1 3HQ	|email@outlook.com	|MODTESTBUREAU |

  @JurorTransformationWIP
  Scenario Outline: Work Allocation - modernisation - errors and warnings

    #this test needs to stay in single threaded as it checks assignment counts which will be more dynamic in the multi threaded execution

    Given I am on "Bureau" "test"
    And pool no "<pool_number>" is reset to pending allocation new schema

    Given a bureau owned pool is created with jurors
      | court |juror_number   | pool_number	 | att_date_weeks_in_future| owner |
      | 452	  |<juror_number4>| <pool_number>| 5				       | 400   |
      | 452	  |<juror_number5>| <pool_number>| 5				       | 400   |
      | 452	  |<juror_number6>| <pool_number>| 5				       | 400   |

#	set up some responses
#	non-urgent
    And juror "<juror_number4>" has "LAST_NAME" as "<last_name>" new schema
    And juror "<juror_number4>" has "POSTCODE" as "<postcode>" new schema

	#urgent
    And juror "<juror_number5>" has "LAST_NAME" as "<last_name>" new schema
    And juror "<juror_number5>" has "POSTCODE" as "<postcode>" new schema

	#super urgent
    And juror "<juror_number6>" has "LAST_NAME" as "<last_name>" new schema
    And juror "<juror_number6>" has "POSTCODE" as "<postcode>" new schema

    Given I am on "Public" "postgres"
    And auto straight through processing has been disabled new schema
    And I have submitted a first party English straight through response
      | part_no			    | pool_number  | last_name	| postcode	| email  |
      | <juror_number4>		| <pool_number>| <last_name>| <postcode>| <email>|
      | <juror_number5>		| <pool_number>| <last_name>| <postcode>| <email>|
      | <juror_number6>		| <pool_number>| <last_name>| <postcode>| <email>|

    #log on as Team Lead
    Given I am on "Bureau" "test"
    And I log in as "<user>"

    #assign replies check page content
    Then I click on the "Assign Replies" link
    And I see "Assign replies" on the page
    And I see "Number of replies in the backlog" on the page
    And I see "How many replies do you want to assign to each officer you select?" on the page
    And I see "Select the officers you want to assign these replies to" on the page

    #check team leads not in results grid
    And I do not see "MODTESTBUREAU" in the staff results grid
    And I do not see "MODTESTBUREAU" in the staff results grid

    #check responses counts are displayed
    Then I see "2" in the same row as "total" in Backlog box
    Then I see "1" in the same row as "standard" in Backlog box


    #invalid input - assign with no selections made
    When I press the "Assign replies" button
    Then I see error "Enter how many replies you want to assign to each selected officer - you must enter a number in at least one box"
    And I see error "Select at least 1 officer to assign replies to"

    #invalid input - assign with only team member selected
    And I check the "ARAMIS1" checkbox
    When I press the "Assign replies" button
    And I see error "Enter how many replies you want to assign to each selected officer - you must enter a number in at least one box"

    #invalid input - assign without team member selected
    And I uncheck the "ARAMIS1" checkbox
    Then I set how many "Urgent" replies I want to assign to "1"
    Then I set how many "Standard" replies I want to assign to "1"
    When I press the "Assign replies" button
    And I see error "Select at least 1 officer to assign replies to"

    #invalid input - assign more than is available
    Then I set how many "Urgent" replies I want to assign to "100"
    Then I set how many "Standard" replies I want to assign to "100"
    And I check the "ARAMIS1" checkbox
    When I press the "Assign replies" button

    #check results of assignment
    And "ARAMIS1-standard" assigned replies count is "1"
    And "ARAMIS1-send" assigned replies count is "1"
    And "ARAMIS1-total" assigned replies count is "2"

    And auto straight through processing has been enabled new schema

    Examples:
      |juror_number4|juror_number5	|juror_number6	|pool_number|last_name 	|postcode 	|email				|user          |
      |045200004	|045200005	    |045200006		|452300002 	|LNAME		|NN1 3HQ	|email@outlook.com	|MODTESTBUREAU |

  @JurorTransformation
  Scenario Outline: Work Allocation - only shows TO DO in urgent and standard counts

    #this test needs to stay in single threaded as it checks assignment counts which will be more dynamic in the multi threaded execution

    Given I am on "Bureau" "demo"
    And paper responses are deleted new schema

    Given a bureau owned pool is created with jurors
      | court |juror_number   | pool_number	 | att_date_weeks_in_future| owner |
      | 452	  |<juror_number1>| <pool_number>| 5				       | 400   |
      | 452	  |<juror_number2>| <pool_number>| 2				       | 400   |
      | 452	  |<juror_number3>| <pool_number>| 5				       | 400   |
      | 452	  |<juror_number4>| <pool_number>| 5				       | 400   |

#	set up some responses
    And juror "<juror_number1>" has "LAST_NAME" as "<last_name>" new schema
    And juror "<juror_number1>" has "POSTCODE" as "<postcode>" new schema

    And juror "<juror_number2>" has "LAST_NAME" as "<last_name>" new schema
    And juror "<juror_number2>" has "POSTCODE" as "<postcode>" new schema

    And juror "<juror_number3>" has "LAST_NAME" as "<last_name>" new schema
    And juror "<juror_number3>" has "POSTCODE" as "<postcode>" new schema

    And juror "<juror_number4>" has "LAST_NAME" as "<last_name>" new schema
    And juror "<juror_number4>" has "POSTCODE" as "<postcode>" new schema

    Given I am on "Public" "demo"

    And auto straight through processing has been disabled new schema

    And I have submitted a first party English straight through response
      | part_no			    | pool_number  | last_name	| postcode	| email  |
      | <juror_number1>		| <pool_number>| <last_name>| <postcode>| <email>|
      | <juror_number2>		| <pool_number>| <last_name>| <postcode>| <email>|
      | <juror_number3>		| <pool_number>| <last_name>| <postcode>| <email>|

    #log on as Team Lead
    Given I am on "Bureau" "demo"
    And I log in as "<user>"

    #paper response is not counted in Assign Replies
    When the user searches for juror record "<juror_number4>" from the global search bar
    And I record a happy path paper summons response
    And I click on the "No, skip and process later" link

    #assign replies check page content
    Then I click on the "Assign Replies" link
    And I see "Assign replies" on the page

    #check responses counts are displayed
    Then I see "3" in the same row as "total" in Backlog box
    Then I see "2" in the same row as "standard" in Backlog box
    Then I see "1" in the same row as "send" in Backlog box

    When the user searches for juror record "<juror_number1>" from the global search bar
    And I click on the "Summons reply" link
    And I click on the "View summons reply" link
    And I click the More Actions button
    And I click on the "Mark as awaiting information" link
    Then I see "Who are you waiting for information from?" on the page
    And I mark this reply as awaiting information from "Juror"
    Then I press the "Confirm" button
    And I do not see "Select whether you’re waiting for information from either the juror, court or translation unit" on the page
    And I do not see "The summons reply has been updated by another user" on the page
    And I see the reply status has updated to "Awaiting juror info"

    When the user searches for juror record "<juror_number2>" from the global search bar
    And I click on the "Summons reply" link
    And I click on the "View summons reply" link
    And I click the More Actions button
    And I click on the "Mark as awaiting information" link
    Then I see "Who are you waiting for information from?" on the page
    And I mark this reply as awaiting information from "Court"
    Then I press the "Confirm" button
    And I do not see "Select whether you’re waiting for information from either the juror, court or translation unit" on the page
    And I do not see "The summons reply has been updated by another user" on the page
    And I see the reply status has updated to "Awaiting court reply"

    When the user searches for juror record "<juror_number3>" from the global search bar
    And I click on the "Summons reply" link
    And I click on the "View summons reply" link
    And I click the More Actions button
    And I click on the "Mark as awaiting information" link
    Then I see "Who are you waiting for information from?" on the page
    And I mark this reply as awaiting information from "Translation unit"
    Then I press the "Confirm" button
    And I do not see "Select whether you’re waiting for information from either the juror, court or translation unit" on the page
    And I do not see "The summons reply has been updated by another user" on the page
    And I see the reply status has updated to "Awaiting translation"

    When the user searches for juror record "<juror_number4>" from the global search bar
    And I click on the "Summons reply" link
    And I click on the "View summons reply" link
    And I click the More Actions button
    And I click on the "Mark as awaiting information" link
    Then I see "Who are you waiting for information from?" on the page
    And I mark this reply as awaiting information from "Translation unit"
    Then I press the "Confirm" button
    And I do not see "Select whether you’re waiting for information from either the juror, court or translation unit" on the page
    And I do not see "The summons reply has been updated by another user" on the page
    And I see the reply status has updated to "Awaiting Translation"

    #assign replies check page content
    Then I click on the "Assign Replies" link
    And I see "Assign replies" on the page

    #check responses counts are displayed
    Then I see "0" in the same row as "total" in Backlog box
    Then I see "0" in the same row as "standard" in Backlog box
    Then I see "0" in the same row as "send" in Backlog box

    Then a new pool is inserted for where record has transferred to the court new schema
      | part_no   	    | pool_no   	| owner |
      | <juror_number1> | <pool_number> | 452   |
      | <juror_number2> | <pool_number> | 452   |

    #assign replies check page content
    Then I click on the "Assign Replies" link
    And I see "Assign replies" on the page

    #check responses counts are displayed
    Then I see "0" in the same row as "total" in Backlog box
    Then I see "0" in the same row as "standard" in Backlog box
    Then I see "0" in the same row as "send" in Backlog box

    And auto straight through processing has been enabled new schema

    Examples:
      |juror_number1|juror_number2	|juror_number3	|juror_number4	|pool_number|last_name 	|postcode 	|email				|user          |
      |045200010	|045200011	    |045200013	    |045200025 	    |452600003 	|LNAME		|NN1 3HQ	|email@outlook.com	|MODTESTBUREAU |