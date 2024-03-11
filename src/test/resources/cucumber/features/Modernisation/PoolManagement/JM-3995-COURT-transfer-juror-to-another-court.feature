Feature: JM-3995 JM-4302

  @JurorTransformationWIP @NewSchemaConverted @JM-5902
  Scenario Outline: Transfer a juror to another court - Juror Record - Happy Path

    Given I am on "Bureau" "test"

    Given juror_pool records are cleared down for "<juror_number>"

    Given the juror numbers have not been processed new schema
      |part_no   | pool_no   | owner |
      |<part_no> | <pool_no> | 400   |

    And "<juror_number>" has "NEXT_DATE" as "7 mondays time" new schema

    And I log in as "<user>"

    Given a new pool is inserted for where record has transferred to the court new schema
      |part_no   | pool_no   | owner |
      |<part_no> | <pool_no> | 415   |

    When the user searches for juror record "<juror_number>" from the global search bar

    #record happy path paper summons
    And I record a happy path paper summons response

    #skip straight through processing
    Then I see "Do you want to process this summons reply as responded now?" on the page
    Then I see "The juror’s answers mean this is a straight-through reply. So you can process it as responded now, or return later." on the page
    When I press the "Yes, process now" button

    When the user searches for juror record "<juror_number>" from the global search bar
    And I click the update juror record button
    And I click the transfer to another pool radio button
    And I press the "Continue" button

    Then I am on the select a court to transfer to page

    #select court and attendance date
    #ensure multiple courts are visible for transfer
    When I set input field with "ID" of "courtNameOrLocation" to "420"
    And I click on the "Doncaster (420)" link
    When I set input field with "ID" of "courtNameOrLocation" to "465"
    And I click on the "Winchester (465)" link
    When I set input field with "ID" of "courtNameOrLocation" to "774"
    And I click on the "Welshpool (774)" link
    And I set attendance date to "4" Mondays in the future
    And I press the "Continue" button

    Then I see "Transfer to Welshpool (774)" on the page
    When I press the "Continue" button

    Then I am on the Juror Record for juror "<juror_number>"
    And I see the juror status on the juror record screen has updated to "Transferred"
    And I see "Juror record updated: juror transferred to Welshpool (774)" on the page

    #Welshpool (774) is a SATELLITE court, so court user can see both juror records
    When I search for juror "<juror_number>"
    Then a second juror record is shown in the search results for "<juror_number>"
    When I click the juror record search link for court name "Welshpool"

    Then I am on the Juror Record for juror "<juror_number>"
    And I see the juror's status on the juror record screen is "Responded"
    And I see the court name on the juror record screen is "The Crown Court At Welshpool"

    Examples:
      | user          | part_no   | pool_no   |
      | MODTESTCOURT | 641500139 | 415171103 |

  @JurorTransformationWIP @NewSchemaConverted @JM-5902
  Scenario Outline: Transfer a juror to another court - Juror Record - Validation and Errors

    Given I am on "Bureau" "test"

    Given the juror numbers have not been processed new schema
      |part_no   | pool_no   | owner |
      |<part_no> | <pool_no> | 400   |

    And "<juror_number>" has "NEXT_DATE" as "7 mondays time" new schema
    And pool "<pool_no>" has attendance date as "7 mondays time" new schema

    And I log in as "<user>"

    Given a new pool is inserted for where record has transferred to the court new schema
      |part_no   | pool_no   | owner |
      |<part_no> | <pool_no> | 415   |

    When the user searches for juror record "<juror_number>" from the global search bar

    #record happy path paper summons
    And I record a happy path paper summons response

    #skip straight through processing
    Then I see "Do you want to process this summons reply as responded now?" on the page
    And I see "The juror’s answers mean this is a straight-through reply. So you can process it as responded now, or return later." on the page
    When I press the "Yes, process now" button

    When the user searches for juror record "<juror_number>" from the global search bar

    And I click the update juror record button

    #do not select transfer juror
    And I press the "Continue" button
    Then I see "Select how you want to update the juror record" on the page

    And I click the transfer to another pool radio button
    And I press the "Continue" button

    Then I am on the select a court to transfer to page

    #do not select court or attendance date
    When I press the "Continue" button
    Then I see "Enter a court name or location" on the page
    And I see "Enter a service start date" on the page

    #select court
    When I set input field with "ID" of "courtNameOrLocation" to "774"
    And I click on the "Welshpool (774)" link

    #input an invalid date
    And I set attendance date to a date that doesn't exist
    And I press the "Continue" button
    Then I see "Enter a real start date" on the page

    #input a date prior to original service start date
    When I set input field with "ID" of "courtNameOrLocation" to "774"
    And I click on the "Welshpool (774)" link
    And I set attendance date to "-5" Mondays in the future
    And I press the "Continue" button
    Then I see "You cannot enter a date that’s earlier than the original service start date" on the page

    #select court and valid attendance date
    When I set input field with "ID" of "courtNameOrLocation" to "774"
    And I click on the "Welshpool (774)" link
    And I set attendance date to "4" Mondays in the future
    And I press the "Continue" button

    Then I see "Transfer to Welshpool (774)" on the page
    When I click on the "Cancel" link
    Then I am on the Juror Record for juror "<juror_number>"

    Examples:
      | user          | part_no   | pool_no   |
      | MODTESTCOURT | 641500215 | 415171103  |


  @JurorTransformationMulti @NewSchemaConverted
  Scenario Outline: JM-4302 - Transfer a juror to another court - Non-Satellite courts

    Given I am on "Bureau" "test"

    Given the juror numbers have not been processed new schema
      |part_no   | pool_no   | owner |
      |<part_no> | <pool_no> | 400   |

    And "<juror_number>" has "NEXT_DATE" as "7 mondays time" new schema

    And I log in as "<user>"

    Given a new pool is inserted for where record has transferred to the court new schema
      |part_no   | pool_no   | owner |
      |<part_no> | <pool_no> | 415   |

    When the user searches for juror record "<juror_number>" from the global search bar

    #record happy path paper summons
    And I record a happy path paper summons response

    #skip straight through processing
    Then I see "Do you want to process this summons reply as responded now?" on the page
    Then I see "The juror’s answers mean this is a straight-through reply. So you can process it as responded now, or return later." on the page
    When I click on the "No, skip and process later" link

    #cannot transfer when status is summoned
    When I click on the "View juror's record" link
    And I click the update juror record button
    And I do not see "Transfer to another court" on the page
    And I click on the "Cancel" link

    #process response
    Then I click on the "Summons reply" link
    And I click on the "View summons reply" link
    And I click the process reply button
    And I mark the reply as responded
    And I press the "Continue" button
    And I click the checkbox to mark the reply as responded
    And I press the "Confirm" button

    #now transfer
    When the user searches for juror record "<juror_number>" from the global search bar

    And I click the update juror record button

    And I click the transfer to another pool radio button
    And I press the "Continue" button

    Then I am on the select a court to transfer to page

    #check satellite court selections
    When I set the court or location to "415"
    And I see "Chester (415)" in the dropdown box
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

    And I set attendance date to "4" Mondays in the future
    And I press the "Continue" button

    Then I see "Transfer to Carlisle (412)" on the page
    When I press the "Continue" button

    Then I am on the Juror Record for juror "<juror_number>"
    And I see the juror status on the juror record screen has updated to "Transferred"
    And I see "Juror record updated: juror transferred to Carlisle (412)" on the page

    Examples:
      | user         | part_no   | pool_no   |
      | MODTESTCOURT | 641500859 | 415171103  |