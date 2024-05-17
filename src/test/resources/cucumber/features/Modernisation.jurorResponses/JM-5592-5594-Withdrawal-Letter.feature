Feature: JM-5592-5594 - Resend withdrawal letter for Bureau and Jury users

  @JurorTransformationMulti @NewSchemaConverted
  Scenario Outline: Resend Withdrawal letter as a bureau officer

    Given I am on "Bureau" "test"

    When a bureau owned pool is created with jurors
      | court | juror_number  | pool_number     | att_date_weeks_in_future   | owner |
      | 415     | <juror_number>| <pool_number> | 5                          | 400  |

    And I log in as "<user>"
    And the user searches for juror record "<juror_number>" from the global search bar
    Then I press the "Enter summons reply" button
    And I see "Juror details" on the page
    And I enter a date of birth in the summons reply that will make the juror too young
    And I press the "Continue" button
    And I see "Check the date of birth" on the page
    And I see "Is their date of birth correct?" on the page
    And I press the "Yes - disqualify juror" button

    And the user searches for juror record "<juror_number>" from the global search bar
    And I see the juror status has updated to "Disqualified"

    And I press the "Apps" button
    When I click on the "Documents" link
    And I click on the "Withdrawal letters" link
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
    Then I update juror "<juror_number>" to change the status of printed in order to resend letter
    And I click on the "Withdrawal letters" link
    And I set the radio button to "Juror"
    And I set "Enter juror number" to "<juror_number>"
    And I press the "Search" button
    And I see the printed letter for juror number "<juror_number>" in the letters table
    And I see "Age" in the same row as "<juror_number>"
    And I see "Withdrawal letters" on the page
    And I check the "<juror_number>" checkbox
    And I press the "Resend withdrawal letter" button
    And I see "1 document sent for printing" on the page

    Examples:
      | juror_number  | pool_number | user          |
      |  041549591    | 415999185   | MODTESTBUREAU |

  @JurorTransformationMulti @NewSchemaConverted
  Scenario Outline: Delete a Withdrawal letter which is still pending as a bureau officer

    Given I am on "Bureau" "test"
    And I log in as "<user>"
    When a bureau owned pool is created with jurors
      | court | juror_number  | pool_number     | att_date_weeks_in_future   | owner |
      | 415     | <juror_number>| <pool_number> | 5                       | 400  |


    And the user searches for juror record "<juror_number>" from the global search bar
    Then I press the "Enter summons reply" button
    And I see "Juror details" on the page
    And I enter a date of birth in the summons reply that will make the juror too young
    And I press the "Continue" button
    And I see "Check the date of birth" on the page
    And I see "Is their date of birth correct?" on the page
    And I press the "Yes - disqualify juror" button

    And the user searches for juror record "<juror_number>" from the global search bar
    And I see the juror status has updated to "Disqualified"

     #delete a pending document
    And I press the "Apps" button
    And I click on the "Documents" link
    And I click on the "Withdrawal letters" link
    And I set the radio button to "Juror"
    When I set "Enter juror number" to "<juror_number>"
    And I press the "Search" button
    Then I see "Pending" on the page
    And I see "Change" on the page
    And I click on the "Delete" link
    And I see "1 pending document deleted" on the page

    Examples:
      | juror_number  | pool_number | user          |
      |  041549592    | 415999185   | MODTESTBUREAU |


  @JurorTransformationMulti @NewSchemaConverted
  Scenario Outline: Withdrawal letter - via pool Number happy path bulk

    Given I am on "Bureau" "test"
    And I log in as "<user>"
    When a bureau owned pool is created with jurors
      | court   | juror_number  | pool_number     | att_date_weeks_in_future    | owner |
      | 415     | <juror_number>| <pool_number>   | 5                           | 400  |
      | 415     | <juror_number_2>| <pool_number>   | 5                         | 400  |
      | 415     | <juror_number_3>| <pool_number>   | 5                         | 400  |

    #disqualify first juror
    And the user searches for juror record "<juror_number>" from the global search bar
    Then I press the "Enter summons reply" button
    And I see "Juror details" on the page
    And I enter a date of birth in the summons reply that will make the juror too young
    And I press the "Continue" button
    And I see "Check the date of birth" on the page
    And I see "Is their date of birth correct?" on the page
    And I press the "Yes - disqualify juror" button

    And the user searches for juror record "<juror_number>" from the global search bar
    And I see the juror status has updated to "Disqualified"

    #disqualify second juror
    And the user searches for juror record "<juror_number_2>" from the global search bar
    Then I press the "Enter summons reply" button
    And I see "Juror details" on the page
    And I enter a date of birth in the summons reply that will make the juror too young
    And I press the "Continue" button
    And I see "Check the date of birth" on the page
    And I see "Is their date of birth correct?" on the page
    And I press the "Yes - disqualify juror" button

    And the user searches for juror record "<juror_number_2>" from the global search bar
    And I see the juror status has updated to "Disqualified"

     #disqualify third juror
    And the user searches for juror record "<juror_number_3>" from the global search bar
    Then I press the "Enter summons reply" button
    And I see "Juror details" on the page
    And I enter a date of birth in the summons reply that will make the juror too young
    And I press the "Continue" button
    And I see "Check the date of birth" on the page
    And I see "Is their date of birth correct?" on the page
    And I press the "Yes - disqualify juror" button

    And the user searches for juror record "<juror_number_3>" from the global search bar
    And I see the juror status has updated to "Disqualified"

  #search via pool  number and resend letter for all jurors
    When I press the "Apps" button
    And I click on the "Documents" link
    And I click on the "Withdrawal letters" link
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
    And I click on the "Withdrawal letters" link
    And I set the radio button to "Pool"
    And I set "Enter pool number" to "<pool_number>"
    And I press the "Search" button

    And I see the printed letter for juror number "<juror_number>" in the letters table
    And I see the printed letter for juror number "<juror_number_2>" in the letters table
    And I see the printed letter for juror number "<juror_number_3>" in the letters table
    And I see "Withdrawal letters" on the page
    And I check the "<juror_number>" checkbox
    And I check the "<juror_number_2>" checkbox
    And I check the "<juror_number_3>" checkbox
    And I press the "Resend withdrawal letter" button
    And I see "3 documents sent for printing" on the page

    Examples:
      | juror_number  |juror_number_2 |juror_number_3 |pool_number | user          |
      |  041549594    | 041549595     |041549596      |415999186   | MODTESTBUREAU |

  @JurorTransformationWIP @NewSchemaConverted @JM-7316
  Scenario Outline:Verify as a bureau user can view letters queued for printing and can delete it

    Given I am on "Bureau" "test"

    When a bureau owned pool is created with jurors
      | court   | juror_number  | pool_number     | att_date_weeks_in_future   | owner |
      | 415     | <juror_number>| <pool_number>   | 5                       | 400  |

    And I log in as "<user>"

    #disqualify first juror
    And the user searches for juror record "<juror_number>" from the global search bar
    Then I press the "Enter summons reply" button
    And I see "Juror details" on the page
    And I enter a date of birth in the summons reply that will make the juror too young
    And I press the "Continue" button
    And I see "Check the date of birth" on the page
    And I see "Is their date of birth correct?" on the page
    And I press the "Yes - disqualify juror" button

    And the user searches for juror record "<juror_number>" from the global search bar
    And I see the juror status has updated to "Disqualified"

   #navigate to documents and verify the printing message
    And I press the "Apps" button
    And I click on the "Documents" link
    And I click on the "Withdrawal letters" link
    When I set the radio button to "Show all letters queued for printing"
    And I press the "Search" button

    Then I see "<juror_number>" on the page
    And I see "Change" on the page
    When I click on "Delete" in the same row as "<juror_number>"
    And I see "1 pending document deleted" on the page

    Examples:
      | juror_number  |  pool_number | user          |
      |  041549597     |415980685   | MODTESTBUREAU |


  @JurorTransformationWIP @NewSchemaConverted @JM-6572
  Scenario Outline: As a jury officer I want to print a withdrawal letter for juror

    Given I am on "Bureau" "test"
    When a bureau owned pool is created with jurors
      | court |juror_number  	    | pool_number	    | att_date_weeks_in_future	| owner |
      | 415   | <juror_number>| <pool_number>           | 5                          | 400  |

    Then a new pool is inserted for where record has transferred to the court new schema
      |part_no              | pool_no           | owner |
     | <juror_number>       | <pool_number>     | 415   |

    And I log in as "<user>"
    And the user searches for juror record "<juror_number>" from the global search bar
    Then I press the "Enter summons reply" button
    And I see "Juror details" on the page
    And I enter a date of birth in the summons reply that will make the juror too young
    And I press the "Continue" button
    And I see "Check the date of birth" on the page
    And I see "Is their date of birth correct?" on the page
    And I press the "Yes - disqualify juror" button

    And I see "Do you want to print an withdrawal letter?" on the page
    And I choose the "Yes" radio button
    And I press the "Continue" button
    #will fail here because of JM-6572

    Examples:
      | juror_number  | pool_number | user          |
      |  041549598    | 415980685   | MODTESTCOURT  |


  @JurorTransformationWIP @NewSchemaConverted @JM-6572
  Scenario Outline: As a jury officer re-print a withdrawl letter from the letter screen

    Given I am on "Bureau" "test"

    When a bureau owned pool is created with jurors
      | court |juror_number   | pool_number	    | att_date_weeks_in_future	| owner |
      | 415   | <juror_number>| <pool_number>   | 5                         | 400   |

    Then a new pool is inserted for where record has transferred to the court new schema
      |part_no        | pool_no           | owner |
      | <juror_number>| <pool_number>     | 415   |

    And I log in as "<user>"

   #disqualify first juror
    And the user searches for juror record "<juror_number>" from the global search bar
    Then I press the "Enter summons reply" button
    And I see "Juror details" on the page
    And I enter a date of birth in the summons reply that will make the juror too young
    And I press the "Continue" button
    And I see "Check the date of birth" on the page
    And I see "Is their date of birth correct?" on the page
    And I press the "Yes - disqualify juror" button
    #will fail here because of JM-6572



    Examples:
      | juror_number  | pool_number | user          |
      |  041549599    | 415980685   | MODTESTCOURT  |

