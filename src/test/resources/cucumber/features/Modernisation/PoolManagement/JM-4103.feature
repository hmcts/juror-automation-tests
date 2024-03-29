Feature: JM-4103

  @JurorTransformationWIP @NewSchemaConverted @JM-5841
  Scenario Outline: Transfer a juror to another court as a jury officer - Pool Record - Bulk

    Given I am on "Bureau" "test"

    When a bureau owned pool is created with jurors
      | court |juror_number     | pool_number	  | att_date_weeks_in_future  | owner |
      | 415   | <juror_number_1>| <pool_number>   | 5                         | 400   |
      | 415   | <juror_number_2>| <pool_number>   | 5                         | 400   |
      | 415   | <juror_number_3>| <pool_number>   | 5                         | 400   |
      | 415   | <juror_number_4>| <pool_number>   | 5                         | 400   |

    Then a new pool is inserted for where record has transferred to the court new schema
      |part_no          | pool_no       | owner |
      |<juror_number_1> | <pool_number> | 415   |
      |<juror_number_2> | <pool_number> | 415   |
      |<juror_number_3> | <pool_number> | 415   |
      |<juror_number_4> | <pool_number> | 415   |

    And I log in as "<user>"

    When I navigate to the pool request screen
    And I click on active pools
    And I click on the "At court" link
    When I navigate to the active pool "<pool_number>" overview
    And I select the checkbox in the same row as "<juror_number_1>" in pool table
    And I select the checkbox in the same row as "<juror_number_2>" in pool table
    And I select the checkbox in the same row as "<juror_number_3>" in pool table
    And I select the checkbox in the same row as "<juror_number_4>" in pool table
    And I see "4 of 4 selected" on the page

    #transfer
    And I press the "Transfer" button
    Then I see "Select a court to transfer to" on the page
    And I set "Enter a court name or location code" to "767"
    And I set the "Change the service start date for this pool" single date field to a Monday "5" weeks in the future
    And I press the "Continue" button
    And I see "Transfer to Knutsford" on the page
    And I press the "Continue" button
    And I see "4 jurors transferred" on the page

    Given I am on "Bureau" "test"
    And I log in as "MODTESTBUREAU"
    When the user searches for juror record "<juror_number_1>" from the global search bar
    And I click on "<juror_number_1>" in the same row as "Knutsford"
    And I see the juror status has updated to "Responded"

    When the user searches for juror record "<juror_number_2>" from the global search bar
    And I click on "<juror_number_2>" in the same row as "Knutsford"
    And I see the juror status has updated to "Responded"

    When the user searches for juror record "<juror_number_3>" from the global search bar
    And I click on "<juror_number_3>" in the same row as "Knutsford"
    And I see the juror status has updated to "Responded"

    When the user searches for juror record "<juror_number_4>" from the global search bar
    And I click on "<juror_number_4>" in the same row as "Knutsford"
    And I see the juror status has updated to "Responded"

    Examples:
      | user         | pool_number  | juror_number_1  | juror_number_2  | juror_number_3  | juror_number_4  |
      | MODTESTCOURT | 415171002    | 641500205       | 641500858       | 641500865       | 641500754       |


  @JurorTransformationWIP @NewSchemaConverted @JM-5923
  Scenario Outline: Transfer a juror to another court as a jury officer - Pool Record - Single

    Given I am on "Bureau" "test"

    Given the juror numbers have not been processed new schema
      | part_no   | pool_no 	| owner |
      | <part_no> |<pool_no>	| 400 	|

    Then a new pool is inserted for where record has transferred to the court new schema
      |part_no    | pool_no   | owner |
      |<part_no>  | <pool_no> | 415   |

    And I log in as "<user>"

    When I navigate to the pool request screen
    And I click on active pools
    And I click on the "At court" link
    When I navigate to the active pool "415171002" overview
    And I select the checkbox in the same row as "<juror_number>" in pool table
    And I see "1 of selected" on the page

    #transfer
    And I press the "Transfer" button
    Then I see "Select a court to transfer to" on the page
    And I set "Enter a court name or location code" to "767"
    And I set the "Change the service start date for this pool" single date field to a Monday "5" weeks in the future
    And I press the "Continue" button
    And I see "Transfer to Knutsford" on the page
    And I press the "Continue" button
    And I see "1 juror transferred" on the page

    Given I am on "Bureau" "test"
    And I log in as "MODTESTBUREAU"
    When the user searches for juror record "<part_no>" from the global search bar
    And I click on "<part_no>" in the same row as "Knutsford"
    And I see the juror status has updated to "Responded"


    Examples:
      | user         | pool_no   | part_no  |
      | MODTESTCOURT | 415171002 | 641500454|


  @JurorTransformationWIP @JM-5923 @NewSchemaConverted
  Scenario Outline: Transfer a juror to another court as a jury officer - Pool Record - Select All

    Given I am on "Bureau" "test"

    Given the juror numbers have not been processed new schema
      | part_no     | pool_no 	| owner |
      | <part_no>   |<pool_no>	| 400 	|
      |<part_no_2>  | <pool_no> | 400   |
      |<part_no_3>  | <pool_no> | 400   |

    And "<part_no_2>" has "NEXT_DATE" as "5 mondays time" new schema
    And "<part_no_3>" has "NEXT_DATE" as "5 mondays time" new schema

    Then a new pool is inserted for where record has transferred to the court new schema
      |part_no      | pool_no     | owner   |
      |<part_no>    | <pool_no>   | 415     |
      |<part_no_2>  | <pool_no>   | 415     |
      |<part_no_3>  | <pool_no>   | 415     |

    And I log in as "<user>"

    When I navigate to the pool request screen
    And I click on active pools
    And I click on the "Search" link
    And I set "Pool number" to "415180901"
    And I press the "Continue" button
    And I check the select all checkbox

    #transfer
    And I press the "Transfer" button
    Then I see "Select a court to transfer to" on the page
    And I set "Enter a court name or location code" to "767"
    And I set the "Change the service start date for this pool" single date field to a Monday "20" weeks in the future
    And I press the "Continue" button
    And I press the "Continue and move remaining jurors" button

    #checking juror has been transferred
    Given I am on "Bureau" "postgres"
    And I log in as "MODTESTBUREAU"
    When the user searches for juror record "<part_no>" from the global search bar
    And I click on "<part_no>" in the same row as "Knutsford"
    And I see the juror status has updated to "Responded"
    And I see the court name on the juror record screen is "The Crown Court At Chichester"

    Examples:
      | user         | pool_no   | part_no  | part_no_2 |part_no_3  |
      | MODTESTCOURT | 415180901 | 641500279| 641500939 | 641500851 |