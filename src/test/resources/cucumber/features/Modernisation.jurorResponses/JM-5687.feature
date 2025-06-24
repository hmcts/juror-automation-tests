Feature: JM-5687 - Resend Confirmation letter

  @JurorTransformationMulti @NewSchemaConverted
  Scenario Outline:As a bureau officer test a juror can resend a Confirmation letter by searching via juror number

    Given I am on "Bureau" "test"

    When a bureau owned pool is created with jurors
      | court | juror_number  | pool_number     | att_date_weeks_in_future   | owner |
      | 415     | <juror_number>| <pool_number> | 5                          | 400  |

    And I log in as "<user>"
    
    Then a confirmation letter inserted for juror "<juror_number>"
    When the user searches for juror record "<juror_number>" from the global search bar
    And I record a happy path paper summons response
    And I click on the "No, skip and process later" link
    When the user searches for juror record "<juror_number>" from the global search bar
    Then I click the summons reply tab
    And I click on the view summons reply link
    And I press the "Process reply" button
    And I see "How do you want to process this reply?" on the page
    And I set the radio button to "Mark as responded"
    And I press the "Continue" button
    And I see "Mark as responded" on the page
    And I check the "Mark juror as 'responded'" checkbox
    And I press the "Confirm" button
    When the user searches for juror record "<juror_number>" from the global search bar
    And I see the juror status has updated to "Responded"

    And I press the "Apps" button
    When I click on the "Documents" link
    And I click on the "Confirmation letters" link
    And I press the "Search" button
    Then I see error "Select whether you want to search by juror or pool"
    And I set the radio button to "Juror"
    And I press the "Search" button
    And I see error "Enter juror number"
    And I set "Enter juror number" to "<juror_number>"
    And I press the "Search" button
    And I see "Pending" in the same row as "<juror_number>"
    And I press the "Apps" button
    When I click on the "Documents" link
    And I update juror "<juror_number>" to change the status of printed in order to resend letter
    And I click on the "Confirmation letters" link
    And I set the radio button to "Juror"
    And I set "Enter juror number" to "<juror_number>"
    And I press the "Search" button
    And I see "Confirmation letters" on the page
    And I check the "<juror_number>" checkbox
    And I press the "Resend confirmation letter" button
    And I see "1 document sent for printing" on the page

    Examples:
      | juror_number  | pool_number | user          |
      |  041540013    | 415300413   | MODTESTBUREAU |

  @JurorTransformationMulti @NewSchemaConverted
  Scenario Outline:As a bureau officer can delete a confirmation letter while its pending

    Given I am on "Bureau" "test"
    And I log in as "<user>"
    When a bureau owned pool is created with jurors
      | court | juror_number  | pool_number     | att_date_weeks_in_future   | owner |
      | 415     | <juror_number>| <pool_number> | 5                       | 400  |

    Then a confirmation letter inserted for juror "<juror_number>"
    When the user searches for juror record "<juror_number>" from the global search bar
    And I record a happy path paper summons response
    And I click on the "No, skip and process later" link
    When the user searches for juror record "<juror_number>" from the global search bar
    And I click the summons reply tab
    And I click on the view summons reply link
    And I press the "Process reply" button
    And I see "How do you want to process this reply?" on the page
    And I set the radio button to "Mark as responded"
    And I press the "Continue" button
    And I see "Mark as responded" on the page
    And I check the "Mark juror as 'responded'" checkbox
    And I press the "Confirm" button
    When the user searches for juror record "<juror_number>" from the global search bar
    And I see the juror status has updated to "Responded"

    And I press the "Apps" button
    When I click on the "Documents" link
    And I click on the "Confirmation letters" link
    And I press the "Search" button
    Then I see error "Select whether you want to search by juror or pool"
    And I set the radio button to "Juror"
    And I press the "Search" button
    And I see error "Enter juror number"
    And I set "Enter juror number" to "<juror_number>"
    And I press the "Search" button
    And I see "Pending" in the same row as "<juror_number>"
    And I see "Change" on the page
    And I click on the "Delete" link
    And I see "1 pending document deleted" on the page

    Examples:
      | juror_number  | pool_number | user          |
      |  041540014    | 415300414   | MODTESTBUREAU |


  @JurorTransformationMulti
  Scenario Outline: Confirmation letter - via pool Number happy path bulk

    Given I am on "Bureau" "ithc"

    And I log in as "<user>"

    When a bureau owned pool is created with jurors
      | court   | juror_number  | pool_number     | att_date_weeks_in_future    | owner |
      | 415     | <juror_number>| <pool_number>   | 5                           | 400  |
      | 415     | <juror_number_2>| <pool_number>   | 5                         | 400  |
      | 415     | <juror_number_3>| <pool_number>   | 5                         | 400  |

    And I update service start date to 4 Mondays from now for pool number "<pool_number>"
    Then a confirmation letter inserted for juror "<juror_number>"
    When the user searches for juror record "<juror_number>" from the global search bar
    And I record a happy path paper summons response
    And I click on the "No, skip and process later" link
    When the user searches for juror record "<juror_number>" from the global search bar
    And I click the summons reply tab
    And I click on the view summons reply link
    And I press the "Process reply" button
    And I see "How do you want to process this reply?" on the page
    And I set the radio button to "Mark as responded"
    And I press the "Continue" button
    And I see "Mark as responded" on the page
    And I check the "Mark juror as 'responded'" checkbox
    And I press the "Confirm" button
    When the user searches for juror record "<juror_number>" from the global search bar
    And I see the juror status has updated to "Responded"

    Then a confirmation letter inserted for juror "<juror_number_2>"
    When the user searches for juror record "<juror_number_2>" from the global search bar
    And I record a happy path paper summons response
    And I click on the "No, skip and process later" link
    When the user searches for juror record "<juror_number_2>" from the global search bar
    And I click the summons reply tab
    And I click on the view summons reply link
    And I press the "Process reply" button
    And I see "How do you want to process this reply?" on the page
    And I set the radio button to "Mark as responded"
    And I press the "Continue" button
    And I see "Mark as responded" on the page
    And I check the "Mark juror as 'responded'" checkbox
    And I press the "Confirm" button
    When the user searches for juror record "<juror_number_2>" from the global search bar
    And I see the juror status has updated to "Responded"

    Then a confirmation letter inserted for juror "<juror_number_3>"
    When the user searches for juror record "<juror_number_3>" from the global search bar
    And I record a happy path paper summons response
    And I click on the "No, skip and process later" link
    When the user searches for juror record "<juror_number_3>" from the global search bar
    And I click the summons reply tab
    And I click on the view summons reply link
    And I press the "Process reply" button
    And I see "How do you want to process this reply?" on the page
    And I set the radio button to "Mark as responded"
    And I press the "Continue" button
    And I see "Mark as responded" on the page
    And I check the "Mark juror as 'responded'" checkbox
    And I press the "Confirm" button
    When the user searches for juror record "<juror_number_3>" from the global search bar
    And I see the juror status has updated to "Responded"

  #search via pool  number and resend letter for all jurors
    When I press the "Apps" button
    And I click on the "Documents" link
    And I click on the "Confirmation letters" link
    And I press the "Search" button
    Then I see error "Select whether you want to search by juror or pool"
    And I set the radio button to "Pool"
    And I set "Enter pool number" to "<pool_number>"
    And I press the "Search" button
    And I see "Pending" on the page
    And I see "Change" on the page
    And I update juror "<juror_number>" to change the status of printed in order to resend letter
    And I update juror "<juror_number_2>" to change the status of printed in order to resend letter
    And I update juror "<juror_number_3>" to change the status of printed in order to resend letter

    And I press the "Apps" button
    And I click on the "Documents" link
    And I click on the "Confirmation letters" link
    And I set the radio button to "Pool"
    And I set "Enter pool number" to "<pool_number>"
    And I press the "Search" button
    
    And I see "Confirmation letters" on the page
    And I check the "<juror_number>" checkbox
    And I check the "<juror_number_2>" checkbox
    And I check the "<juror_number_3>" checkbox
    And I press the "Resend confirmation letter" button
    And I see "3 documents sent for printing" on the page

    Examples:
      | juror_number  |juror_number_2 |juror_number_3 |pool_number | user          |
      |  041588978    | 041588979     |041588980      |415981286   | MODTESTBUREAU |


  @JurorTransformationMulti @NewSchemaConverted
  Scenario Outline:Verify as a bureau user can view confirmation letters queued for printing and can delete it

    Given I am on "Bureau" "test"

    When a bureau owned pool is created with jurors
      | court   | juror_number  | pool_number     | att_date_weeks_in_future   | owner |
      | 415     | <juror_number>| <pool_number>   | 5                       | 400  |

    And I update service start date to 4 Mondays from now for pool number "<pool_number>"

    And I log in as "<user>"
    Then a confirmation letter inserted for juror "<juror_number>"
    When the user searches for juror record "<juror_number>" from the global search bar
    And I record a happy path paper summons response
    And I click on the "No, skip and process later" link
    When the user searches for juror record "<juror_number>" from the global search bar
    And I click the summons reply tab
    And I click on the view summons reply link
    And I press the "Process reply" button
    And I see "How do you want to process this reply?" on the page
    And I set the radio button to "Mark as responded"
    And I press the "Continue" button
    And I see "Mark as responded" on the page
    And I check the "Mark juror as 'responded'" checkbox
    And I press the "Confirm" button
    When the user searches for juror record "<juror_number>" from the global search bar
    And I see the juror status has updated to "Responded"

   #navigate to documents and verify the printing message
    And I press the "Apps" button
    And I click on the "Documents" link
    And I click on the "Confirmation letters" link
    When I set the radio button to "Show all letters queued for printing"
    And I press the "Search" button

    Then I see "<juror_number>" on the page
    And I see "Change" on the page
    When I click on "Delete" in the same row as "<juror_number>"
    And I see "1 pending document deleted" on the page

    Examples:
      | juror_number  |  pool_number | user          |
      |  041588983    |415981289     | MODTESTBUREAU |