Feature: As a Bureau officer I want to re send a request further info letter

  @JurorTransformationMulti
  Scenario Outline: As a bureau officer I want to send a request further info letter - via juror

    Given I am on "Bureau" "test"
    And I log in as "<user>"

    When a bureau owned pool is created with jurors
      | court | juror_number   | pool_number   | att_date_weeks_in_future | owner |
      | 415   | <juror_number> | <pool_number> | 5                        | 400   |

    And the user searches for juror record "<juror_number>" from the global search bar
    And I clear down the bulk print data table for Juror "<juror_number>"
      #record paper summons response

    And I record a paper summons response with reasonable adjustment of "C - Caring Responsibilities"

    And the user searches for juror record "<juror_number>" from the global search bar
    And I click on the "Summons reply" link
    And I click on the "View summons reply" link
    And I press the "More actions" button
    And I press the "Request juror info by post" button
    
    And I check the "Does the juror have a disability or impairment that means they’ll need extra support or facilities at court?" checkbox
    And I press the "Continue" button
    And I see "A letter will be automatically sent to the juror requesting the missing information" on the page
    And I press the "Done" button
    And I see the reply status has updated to "Awaiting juror info"

    And I press the "Apps" button
    When I click on the "Documents" link
    And I click on the "Requests for further information" link
    Then I see "Juror" on the page
    And I see "Pool" on the page
    And I see "Show all letters queued for printing" on the page
    When I press the "Search" button
    Then I see error "Select whether you want to search by juror or pool"
    And I set the radio button to "Juror"
    And I press the "Search" button
    And I see error "Enter juror number"
    And I set "Enter juror number" to "<juror_number>"
    And I press the "Search" button
    And I see "Pending" on the page
    And I see "Change" on the page
    And I see "<juror_number>" on the page
    And I update juror "<juror_number>" to change the status of printed in order to resend letter

    And I press the "Apps" button
    And I click on the "Documents" link
    And I click on the "Requests for further information" link
    And I set the radio button to "Juror"
    And I set "Enter juror number" to "<juror_number>"
    And I press the "Search" button

    #see printed date as todays date
    And I see the date "0" weeks from now in the same row as "<juror_number>"


    Examples:
      | juror_number | pool_number | user          |
      | 041571143    | 415302812   | MODTESTBUREAU |

  @JurorTransformationMulti @NewSchemaConverted
  Scenario Outline: Verify as bureau officer I can delete a request further info letter in a pending state

    Given I am on "Bureau" "test"
    And I log in as "<user>"

    When a bureau owned pool is created with jurors
      | court | juror_number   | pool_number   | att_date_weeks_in_future | owner |
      | 415   | <juror_number> | <pool_number> | 5                        | 400   |

    And the user searches for juror record "<juror_number>" from the global search bar
    And I clear down the bulk print data table for Juror "<juror_number>"
      #record paper summons response

    And I record a paper summons response with reasonable adjustment of "C - Caring Responsibilities"

    And the user searches for juror record "<juror_number>" from the global search bar
    And I click on the "Summons reply" link
    And I click on the "View summons reply" link
    And I press the "More actions" button
    And I press the "Request juror info by post" button

    And I check the "Does the juror have a disability or impairment that means they’ll need extra support or facilities at court?" checkbox
    And I press the "Continue" button
    And I see "A letter will be automatically sent to the juror requesting the missing information" on the page
    And I press the "Done" button
    And I see the reply status has updated to "Awaiting juror info"

    And I press the "Apps" button
    When I click on the "Documents" link
    And I click on the "Requests for further information" link
    Then I see "Juror" on the page
    And I see "Pool" on the page
    And I see "Show all letters queued for printing" on the page
    When I press the "Search" button
    Then I see error "Select whether you want to search by juror or pool"
    And I set the radio button to "Juror"
    And I press the "Search" button
    And I see error "Enter juror number"
    And I set "Enter juror number" to "<juror_number>"
    And I press the "Search" button
    And I see "Pending" on the page
    And I see "Change" on the page
    And I see "<juror_number>" on the page
    When I click on the "Delete" link
    Then I see "1 pending document deleted" on the page

    Examples:
      | juror_number | pool_number | user          |
      | 041571144    | 415302813   | MODTESTBUREAU |


  @JurorTransformationMulti @NewSchemaConverted
  Scenario Outline: As a bureau officer I want to send a request further info letter - via pool

    Given I am on "Bureau" "test"
    And I log in as "<user>"

    When a bureau owned pool is created with jurors
      | court | juror_number   | pool_number   | att_date_weeks_in_future | owner |
      | 415   | <juror_number> | <pool_number> | 5                        | 400   |

    And the user searches for juror record "<juror_number>" from the global search bar
    And I clear down the bulk print data table for Juror "<juror_number>"
      #record paper summons response

    And I record a paper summons response with reasonable adjustment of "C - Caring Responsibilities"

    And the user searches for juror record "<juror_number>" from the global search bar
    And I click on the "Summons reply" link
    And I click on the "View summons reply" link
    And I press the "More actions" button
    And I press the "Request juror info by post" button

    And I check the "Does the juror have a disability or impairment that means they’ll need extra support or facilities at court?" checkbox
    And I press the "Continue" button
    And I see "A letter will be automatically sent to the juror requesting the missing information" on the page
    And I press the "Done" button
    And I see the reply status has updated to "Awaiting juror info"

    And I press the "Apps" button
    When I click on the "Documents" link
    And I click on the "Requests for further information" link
    When I press the "Search" button
    Then I see error "Select whether you want to search by juror or pool"

    And I set the radio button to "Juror"
    And I press the "Search" button
    And I see error "Enter juror number"
    And I set "Enter juror number" to "<juror_number>"
    And I press the "Search" button
    And I see "<juror_number>" on the page
    And I update juror "<juror_number>" to change the status of printed in order to resend letter

    And I press the "Apps" button
    And I click on the "Documents" link
    And I click on the "Requests for further information" link

    And I set the radio button to "Pool"
    And I press the "Search" button
    And I see error "Enter pool number"
    And I set "Enter pool number" to "<pool_number>"
    And I press the "Search" button
    And I see "<juror_number>" on the page
    And I update juror "<juror_number>" to change the status of printed in order to resend letter

    And I press the "Apps" button
    And I click on the "Documents" link
    And I click on the "Requests for further information" link
    And I set the radio button to "Pool"
    When I set "Enter pool number" to "<pool_number>"
    And I press the "Search" button

    #see printed date as todays date
    And I see the date "0" weeks from now in the same row as "<juror_number>"


    Examples:
      | juror_number | pool_number | user          |
      | 041571146    | 415305832   | MODTESTBUREAU |


  @JurorTransformationMulti @NewSchemaConverted
  Scenario Outline: Verify as bureau officer I can delete a request further info letter in a pending state - show all letters

    Given I am on "Bureau" "test"
    And I log in as "<user>"

    When a bureau owned pool is created with jurors
      | court | juror_number   | pool_number   | att_date_weeks_in_future | owner |
      | 415   | <juror_number> | <pool_number> | 5                        | 400   |

    And the user searches for juror record "<juror_number>" from the global search bar
    And I clear down the bulk print data table for Juror "<juror_number>"
      #record paper summons response

    And I record a paper summons response with reasonable adjustment of "C - Caring Responsibilities"

    And the user searches for juror record "<juror_number>" from the global search bar
    And I click on the "Summons reply" link
    And I click on the "View summons reply" link
    And I press the "More actions" button
    And I press the "Request juror info by post" button

    And I check the "Does the juror have a disability or impairment that means they’ll need extra support or facilities at court?" checkbox
    And I press the "Continue" button
    And I see "A letter will be automatically sent to the juror requesting the missing information" on the page
    And I press the "Done" button
    And I see the reply status has updated to "Awaiting juror info"

    And I press the "Apps" button
    When I click on the "Documents" link
    And I click on the "Requests for further information" link
    When I set the radio button to "Show all letters queued for printing"

    And I press the "Search" button
    Then I see "<juror_number>" on the page
    And I see "Change" on the page
    When I click on "Delete" in the same row as "<juror_number>"
    Then I see "1 pending document deleted" on the page

    Examples:
      | juror_number | pool_number | user          |
      | 041571193    | 415397812   | MODTESTBUREAU |



