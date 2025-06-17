Feature: As a Bureau Officer I need to search for a juror summon reply so that I can locate their details for processing or management

  @JurorTransformationMulti @NewSchemaConverted
  Scenario Outline: Search summons replies happy path

    Given I am on "Bureau" "test"

    Given a bureau owned pool is created with jurors
      | court |juror_number    | pool_number  | att_date_weeks_in_future| owner |
      | 452   |<juror_number>  | <pool_number>| 5				        | 400	|

    #log on and search for juror
    And I log in as "<user>"

    #Completed summons response
    When the user searches for juror record "<juror_number>" from the global search bar
    And I record a happy path paper summons response and process now

    #Verify happy path completed search
    When I click on the "Search" link
    And I see "Search" on the page
    And I enter pool number "<pool_number>"
    And I click the search button
    Then I see "<juror_number>" on the page
    And I see "Completed" in the same row as "<juror_number>"

    Examples:
      |juror_number |pool_number  |user          |
      |045200048    |452300047 	  |MODTESTBUREAU |

  Scenario Outline: Search summons reply unhappy path and error check

    Given I am on "Bureau" "test"

    Given a bureau owned pool is created with jurors
      | court |juror_number    | pool_number  | att_date_weeks_in_future| owner |
      | 452   |<juror_number>  | <pool_number>| 5				        | 400	|

    #log on and search for juror
    And I log in as "<user>"

    #Verify blank search error message
    When I click on the "Search" link
    And I see "Search" on the page
    And I click the search button
    Then I see error "Enter a juror number, a juror's last name, a juror's pool number or advanced criteria to search"

    #Verify boundary error
    When I enter pool number "12345678"
    And I enter juror number "12345678"
    And I click the search button
    Then I see error "Juror number must be 9 characters"
    And I see error "Pool number must be 9 characters"

    #Verify no matching result message
    When I enter pool number "9"
    And I enter juror number "9"
    And I click the search button
    Then I see "There are no matching results." on the page

    Examples:
      |juror_number |pool_number  |user          |
      |123456789    |123456789 	  |MODTESTBUREAU |

  @JurorTransformationMulti @NewSchemaConverted
  Scenario Outline: Summons replies advanced search - Assigned officer, ToDo and Completed

    Given I am on "Bureau" "test"

    Given a bureau owned pool is created with jurors
      | court |juror_number    | pool_number  | att_date_weeks_in_future| owner |
      | 452   |<juror_number>  | <pool_number>| 5				        | 400	|
      | 452   |<juror_number2>  | <pool_number>| 5				        | 400	|

    #log on and search for juror
    And I log in as "<user>"

    #Completed summons response
    When the user searches for juror record "<juror_number>" from the global search bar
    And I record a happy path paper summons response
    And I press the "Yes, process now" button

    #To Do summons response
    When the user searches for juror record "<juror_number2>" from the global search bar
    And I record a happy path paper summons response
    And I click on the "No, skip and process later" link

    #Verify Assigned officer search
    When I click on the "Search" link
    And I see "Search" on the page
    And I expand the summons replies search advanced search criteria
    And I enter pool number "<pool_number>"
    And I see "Select an officer assigned" on the page
    And I enter assigned officer "<user>"
    And I click the search button
    Then I see "<user>" in the same row as "<juror_number>"

    #Verify completed search filter
    When I click on the "Clear search" link
    And I expand the summons replies search advanced search criteria
    And I check the Completed Checkbox
    And I enter juror number "<juror_number>"
    And I click the search button
    Then I see "Completed" in the same row as "<juror_number>"

    #Verify To Do search filter
    When I click on the "Clear search" link
    And I expand the summons replies search advanced search criteria
    And I check the ToDo Checkbox
    And I enter juror number "<juror_number2>"
    And I click the search button
    Then I see "To do" in the same row as "<juror_number2>"

    Examples:
      |juror_number |juror_number2  |pool_number  |user          |
      |045200049    |045200050      |452300048 	  |MODTESTBUREAU |


  @JurorTransformationMulti
  Scenario Outline: Summons replies advanced search - Awaiting replies and Translation

    Given I am on "Bureau" "ithc"

    Given a bureau owned pool is created with jurors
      | court |juror_number    | pool_number  | att_date_weeks_in_future| owner |
      | 452   |<juror_number>  | <pool_number>| 5				        | 400	|
      | 452   |<juror_number2>  | <pool_number>| 5				        | 400	|
      | 452   |<juror_number3>  | <pool_number>| 5				        | 400	|

    #log on
    And I log in as "<user>"

    #Set juror status to Awaiting translation
    When the user searches for juror record "<juror_number>" from the global search bar
    And I record a happy path paper summons response
    And I click on the "No, skip and process later" link
    And I click the More Actions button
    And I click on the "Mark as awaiting information" link
    Then I see "Who are you waiting for information from?" on the page
    And I mark this reply as awaiting information from "Translation unit"
    Then I press the "Confirm" button
    And I see the reply status has updated to "Awaiting Translation"

    #Set juror status to Awaiting Court Reply
    When the user searches for juror record "<juror_number2>" from the global search bar
    And I record a happy path paper summons response
    And I click on the "No, skip and process later" link
    And I click the More Actions button
    And I click on the "Mark as awaiting information" link
    Then I see "Who are you waiting for information from?" on the page
    And I mark this reply as awaiting information from "Court"
    Then I press the "Confirm" button
    And I see the reply status has updated to "Awaiting court reply"

    #Set juror status to Awaiting Court Reply
    When the user searches for juror record "<juror_number3>" from the global search bar
    And I record a happy path paper summons response
    And I click on the "No, skip and process later" link
    And I click the More Actions button
    And I click on the "Mark as awaiting information" link
    Then I see "Who are you waiting for information from?" on the page
    And I mark this reply as awaiting information from "Juror"
    Then I press the "Confirm" button
    And I see the reply status has updated to "Awaiting juror info"

    #Verify await translation filter and search
    When I click on the "Search" link
    And I see "Search" on the page
    And I click on the "Clear search" link
    And I expand the summons replies search advanced search criteria
    And I check the Awaiting Translation Checkbox
    And I enter juror number "<juror_number>"
    And I click the search button
    Then I see "Awaiting translation" in the same row as "<juror_number>"

    #Verify await court reply filter and search
    When I click on the "Clear search" link
    And I expand the summons replies search advanced search criteria
    And I check the Awaiting Court Reply Checkbox
    And I enter juror number "<juror_number2>"
    And I click the search button
    Then I see "Awaiting court reply" in the same row as "<juror_number2>"

    #Verify await juror reply filter and search
    When I click on the "Clear search" link
    And I expand the summons replies search advanced search criteria
    And I check the Awaiting Juror Reply Checkbox
    And I enter juror number "<juror_number3>"
    And I click the search button
    Then I see "Awaiting juror reply" in the same row as "<juror_number3>"

    Examples:
      |juror_number |juror_number2 |juror_number3 |pool_number    |user          |
      |045200051    |045200052    |045200053      |452300048 	  |MODTESTBUREAU |

  Scenario Outline: Summons replies with urgent flag

    Given I am on "Bureau" "test"

    Given a bureau owned pool is created with jurors
      | court |juror_number    | pool_number  | att_date_weeks_in_future| owner |
      | 452   |<juror_number>  | <pool_number>| 5				        | 400	|

    #Changing service date to trigger urgent flag
    And "<juror_number>" has "NEXT_DATE" as "-2 mondays time" new schema
    And pool "<pool_number>" has attendance date as "-2 mondays time" new schema

    #log on and search for juror
    And I log in as "<user>"

    #Completed summons response
    When the user searches for juror record "<juror_number>" from the global search bar
    And I record a happy path paper summons response
    And I click on the "No, skip and process later" link

    #Verify urgent search
    When I click on the "Search" link
    And I see "Search" on the page
    And I expand the summons replies search advanced search criteria
    And I check the urgent checkbox
    And I enter juror number "<juror_number>"
    And I click the search button
    Then I see "To do" in the same row as "<juror_number>"
    And I see "1 results for "<juror_number>", "is urgent"" on the page

    Examples:
      |juror_number |pool_number  |user          |
      |045200054    |452300047 	  |MODTESTBUREAU |