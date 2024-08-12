Feature: JM-3995 JM-4302

  @JurorTransformationMulti @NewSchemaConverted
  Scenario Outline: Transfer a juror to another court - Juror Record - Happy Path

    Given I am on "Bureau" "ithc"

    Given juror_pool records are cleared down for "<juror_number>"

    Given a bureau owned pool is created with jurors
      | court | juror_number  	    | pool_number	    | att_date_weeks_in_future	| owner |
      | 415   | <juror_number> 	    | <pool_number>     | 7				            | 400	|

    And I log in as "<user>"

    Given a new pool is inserted for where record has transferred to the court new schema
      |part_no        | pool_no       | owner |
      |<juror_number> | <pool_number> | 415   |

    And I update juror "<juror_number>" to have a status of "Responded"

    When the user searches for juror record "<juror_number>" from the global search bar
    And I click on the pool number link on Juror Record
    And I check the juror "<juror_number>" checkbox
    And I press the "Transfer" button
    And I see "Select a court to transfer to" on the page
    And I set "Enter a court name or location code" to "774"
    And I set the "Service start date for transfer" date to a Monday "4" weeks in the future
    And I press the "Continue" button
    Then I see "Transfer to Welshpool (774)" on the page
    When I press the "Continue" button
    When the user searches for juror record "<juror_number>" from the global search bar
    And I see the juror status on the juror record screen has updated to "Transferred"

    Given I am on "Bureau" "test"
    And I log in as "MODTESTBUREAU"

    #see 2 records, one transferred and one original
    When the user searches for juror record "<juror_number>" from the global search bar
    And I see "Chester" in the same row as "<juror_number>"
    And I see "Welshpool" in the same row as "<juror_number>"



    Examples:
      | user         | juror_number | pool_number |
      | MODTESTCOURT | 041500164    | 415300263   |

  @JurorTransformationMulti @NewSchemaConverted
  Scenario Outline: Transfer a juror to another court - Juror Record - Validation and Errors

    Given I am on "Bureau" "ithc"

    Given juror_pool records are cleared down for "<juror_number>"

    Given a bureau owned pool is created with jurors
      | court | juror_number  	    | pool_number	    | att_date_weeks_in_future	| owner |
      | 415   | <juror_number> 	    | <pool_number>     | 7				            | 400	|

    And I log in as "<user>"

    Given a new pool is inserted for where record has transferred to the court new schema
      |part_no        | pool_no       | owner |
      |<juror_number> | <pool_number> | 415   |

    And I update juror "<juror_number>" to have a status of "Responded"

    When the user searches for juror record "<juror_number>" from the global search bar
    And I click on the pool number link on Juror Record
    And I check the juror "<juror_number>" checkbox
    And I press the "Transfer" button
    And I see "Select a court to transfer to" on the page
    
    And I press the "Continue" button
    And I see error "Enter a court name or location code to transfer to"
    And I see error "Enter a transfer date in the correct format, for example, 31/01/2023"
    
    And I set "Enter a court name or location code" to "774"
    And I set the "Service start date for transfer" date to a Monday "4" weeks in the future
    And I press the "Continue" button

    Then I see "Transfer to Welshpool (774)" on the page
    When I click on the "Cancel" link
    And I see "<pool_number>" on the page


    Examples:
      | user         | juror_number | pool_number |
      | MODTESTCOURT | 041500163    | 415300262   |


  @JurorTransformationMulti @NewSchemaConverted
  Scenario Outline: JM-4302 - Transfer a juror to another court - Non-Satellite courts

    Given I am on "Bureau" "ithc"

    Given a bureau owned pool is created with jurors
      | court | juror_number  	    | pool_number	    | att_date_weeks_in_future	| owner |
      | 415   | <juror_number> 	    | <pool_number>     | 7				            | 400	|

    And I log in as "<user>"

    Given a new pool is inserted for where record has transferred to the court new schema
      |part_no        | pool_no       | owner |
      |<juror_number> | <pool_number> | 415   |

    And I update juror "<juror_number>" to have a status of "Responded"

    When the user searches for juror record "<juror_number>" from the global search bar
    And I click on the pool number link on Juror Record
    And I check the juror "<juror_number>" checkbox
    And I press the "Transfer" button

    #check satellite court selections
   # When I set the court or location to "415"
   # And I see "Chester (415)" in the dropdown box
    When I set the court or location to "774"
    And I see "Welshpool (774)" in the dropdown box

    #check NON-SATELLITE court selections
    When I set the court or location to "420"
    And I see "Doncaster (420)" in the dropdown box

    When I set the court or location to "794"
    And I see "Wimbledon (794)" in the dropdown box

    When I set the court or location to "430"
    And I see "Leicester (430)" in the dropdown box

    When I set the court or location to "756"
    And I see "Carmarthen (756)" in the dropdown box

    When I set the court or location to "799"
    And I see "Hove (799)" in the dropdown box

    When I set the court or location to "412"
    And I click on the "Carlisle (412)" link

    And I set the "Service start date for transfer" date to a Monday "4" weeks in the future
    And I press the "Continue" button

    Then I see "Transfer to Carlisle (412)" on the page
    When I press the "Continue" button

    When the user searches for juror record "<juror_number>" from the global search bar
    And I see the juror status on the juror record screen has updated to "Transferred"

    Given I am on "Bureau" "test"
    And I log in as "MODTESTBUREAU"

    #see 2 records, one transferred and one original
    When the user searches for juror record "<juror_number>" from the global search bar
    And I see "Chester" in the same row as "<juror_number>"
    And I see "Carlisle" in the same row as "<juror_number>"

    Examples:
      | user         | juror_number | pool_number|
      | MODTESTCOURT | 041500162    | 415300261  |