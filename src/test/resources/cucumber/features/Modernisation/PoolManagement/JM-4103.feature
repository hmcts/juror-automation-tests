Feature: JM-4103

  @JurorTransformationMulti @NewSchemaConverted
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

    And I update juror "<juror_number_1>" to have a status of "Responded"
    And I update juror "<juror_number_2>" to have a status of "Responded"
    And I update juror "<juror_number_3>" to have a status of "Responded"
    And I update juror "<juror_number_4>" to have a status of "Responded"

    When I navigate to the pool request screen
    And I click on active pools
    And I click on the "At court" link
    When I navigate to the active pool "<pool_number>" overview
    And I select the checkbox in the same row as "<juror_number_1>" in pool table
    And I select the checkbox in the same row as "<juror_number_2>" in pool table
    And I select the checkbox in the same row as "<juror_number_3>" in pool table
    And I select the checkbox in the same row as "<juror_number_4>" in pool table

    #transfer
    And I press the "Transfer" button
    Then I see "Select a court to transfer to" on the page
    And I set "Enter a court name or location code" to "416"
    And I set the "Change the service start date for this pool" single date field to a Monday "5" weeks in the future
    And I press the "Continue" button
    And I see "Transfer to Lewes Sitting At Chichester" on the page
    And I press the "Continue" button
    And I see "4 jurors transferred" on the page

    Given I am on "Bureau" "test"
    And I log in as "MODTESTBUREAU"
    When the user searches for juror record "<juror_number_1>" from the global search bar
    And I click on "<juror_number_1>" in the same row as "Lewes Sitting At Chichester"
    And I see the juror status has updated to "Responded"

    When the user searches for juror record "<juror_number_2>" from the global search bar
    And I click on "<juror_number_2>" in the same row as "Lewes Sitting At Chichester"
    And I see the juror status has updated to "Responded"

    When the user searches for juror record "<juror_number_3>" from the global search bar
    And I click on "<juror_number_3>" in the same row as "Lewes Sitting At Chichester"
    And I see the juror status has updated to "Responded"

    When the user searches for juror record "<juror_number_4>" from the global search bar
    And I click on "<juror_number_4>" in the same row as "Lewes Sitting At Chichester"
    And I see the juror status has updated to "Responded"

    Examples:
      | user         | pool_number  | juror_number_1  | juror_number_2  | juror_number_3  | juror_number_4  |
      | MODTESTCOURT | 415171002    | 641500205       | 641500858       | 641500865       | 641500754       |


  @JurorTransformationMulti @NewSchemaConverted
  Scenario Outline: Transfer a juror to another court as a jury officer - Pool Record - Single

    Given I am on "Bureau" "test"

    When a bureau owned pool is created with jurors
      | court |juror_number     | pool_number	  | att_date_weeks_in_future  | owner |
      | 415   | <juror_number>| <pool_number>   | 5                         | 400   |

    Then a new pool is inserted for where record has transferred to the court new schema
      |part_no          | pool_no       | owner |
      |<juror_number> | <pool_number> | 415   |

    And I log in as "<user>"

    When I navigate to the pool request screen
    And I click on active pools
    And I click on the "At court" link
    When I navigate to the active pool "<pool_number>" overview
    And I select the checkbox in the same row as "<juror_number>" in pool table

    #transfer
    And I press the "Transfer" button
    Then I see "Select a court to transfer to" on the page
    And I set "Enter a court name or location code" to "416"
    And I set the "Change the service start date for this pool" single date field to a Monday "5" weeks in the future
    And I press the "Continue" button
    And I see "Transfer to Lewes Sitting At Chichester" on the page
    And I press the "Continue" button
    And I see "1 juror transferred to Lewes Sitting At Chichester" on the page

    Given I am on "Bureau" "test"
    And I log in as "MODTESTBUREAU"
    When the user searches for juror record "<juror_number>" from the global search bar
    And I click on "<juror_number>" in the same row as "Lewes Sitting At Chichester"
    And I see the juror status has updated to "Responded"


    Examples:
      | user         | pool_number   | juror_number  |
      | MODTESTCOURT | 415171002     | 641500454    |


  @JurorTransformationMulti
  Scenario Outline: Transfer a juror to another court as a jury officer - Pool Record - Select All

    Given I am on "Bureau" "ithc"

    When a bureau owned pool is created with jurors
      | court |juror_number     | pool_number	  | att_date_weeks_in_future  | owner |
      | 415   | <juror_number_1>| <pool_number>   | 5                         | 400   |
      | 415   | <juror_number_2>| <pool_number>   | 5                         | 400   |
      | 415   | <juror_number_3>| <pool_number>   | 5                         | 400   |

    Then a new pool is inserted for where record has transferred to the court new schema
      | part_no          | pool_no       | owner |
      | <juror_number_1> | <pool_number> | 415   |
      | <juror_number_2> | <pool_number> | 415   |
      | <juror_number_3> | <pool_number> | 415   |

    And I log in as "<user>"

    And I update juror "<juror_number_1>" to have a status of "Responded"
    And I update juror "<juror_number_2>" to have a status of "Responded"
    And I update juror "<juror_number_3>" to have a status of "Responded"

    When I navigate to the pool request screen
    And I click on active pools
    And I click on the "At court" link
    When I navigate to the active pool "<pool_number>" overview
    And I check the select all checkbox on pool overview as court user

    #transfer
    And I press the "Transfer" button
    Then I see "Select a court to transfer to" on the page
    And I set "Enter a court name or location code" to "416"
    Then I click on the "Lewes Sitting At Chichester (416)" link
    And I set the "Change the service start date for this pool" single date field to a Monday "5" weeks in the future
    And I press the "Continue" button
    And I see "Transfer to Lewes Sitting At Chichester" on the page
    And I press the "Continue" button
    And I see "3 jurors transferred" on the page

    Given I am on "Bureau" "ithc"
    And I log in as "MODTESTBUREAU"
    When the user searches for juror record "<juror_number_1>" from the global search bar
    And I click on "<juror_number_1>" in the same row as "Lewes Sitting At Chichester"
    And I see the juror status has updated to "Responded"

    When the user searches for juror record "<juror_number_2>" from the global search bar
    And I click on "<juror_number_2>" in the same row as "Lewes Sitting At Chichester"
    And I see the juror status has updated to "Responded"

    When the user searches for juror record "<juror_number_3>" from the global search bar
    And I click on "<juror_number_3>" in the same row as "Lewes Sitting At Chichester"
    And I see the juror status has updated to "Responded"

    Examples:
      | user         | pool_number   | juror_number_1  | juror_number_2 | juror_number_3  |
      | MODTESTCOURT | 415180901     | 641500279       |  641500939     | 641500851       |