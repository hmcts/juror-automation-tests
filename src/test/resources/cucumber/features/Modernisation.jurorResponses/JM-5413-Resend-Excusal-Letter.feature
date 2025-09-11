Feature: JM-5413-5415 - Resend excusal granted letter for Bureau and Jury users

  @JurorTransformationMulti
  Scenario Outline:As a bureau officer test a Excused juror can resend a granted letter by searching via juror number

    Given I am on "Bureau" "ithc"

    When a bureau owned pool is created with jurors
      | court | juror_number  | pool_number   | att_date_weeks_in_future   | owner  |
      | 415   | <juror_number>| <pool_number> | 5                          | 400    |

    And I log in as "<user>"
    And the user searches for juror record "<juror_number>" from the global search bar
    And I record an excusal request paper summons response
    And the user searches for juror record "<juror_number>" from the global search bar
    And I click on the "Summons reply" link
    And I click on the "View summons reply" link
    And I press the "Process reply" button

    #select refuse excusal
    And I set the radio button to "Excusal - grant or refuse"
    Then I press the "Continue" button
    And I select "O - OTHER" from the "Reason for excusal request" dropdown
    And I set the radio button to "Grant excusal"
    And I press the "Continue" button

    And the user searches for juror record "<juror_number>" from the global search bar
    And I see the juror status has updated to "Excused"

    And I ensure juror "<juror_number>" has an excusal code set

    And I press the "Apps" button
    When I click on the "Documents" link
    And I click on the "Excusal granted letters" link
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
    And I click on the "Excusal granted letters" link
    And I set the radio button to "Juror"
    And I set "Enter juror number" to "<juror_number>"
    And I press the "Search" button
    And I see the printed letter for juror number "<juror_number>" in the letters table
    And I see "Excusal granted letters" on the page
    And I check the "<juror_number>" checkbox
    And I press the "Resend excusal granted letter" button
    And I see "1 document sent for printing" on the page

    Examples:
      | juror_number  | pool_number | user          |
      |  041529011    | 415980685   | MODTESTBUREAU |

  @JurorTransformationMulti
  Scenario Outline:As a bureau officer verify a excused juror letter in printing stage can delete

    Given I am on "Bureau" "ithc"
    And I log in as "<user>"
    When a bureau owned pool is created with jurors
      | court | juror_number  | pool_number   | att_date_weeks_in_future    | owner |
      | 415   | <juror_number>| <pool_number> | 5                           | 400   |

    And the user searches for juror record "<juror_number>" from the global search bar
    And I record an excusal request paper summons response
    And the user searches for juror record "<juror_number>" from the global search bar
    And I click on the "Summons reply" link
    And I click on the "View summons reply" link
    And I press the "Process reply" button

    And I set the radio button to "Excusal - grant or refuse"
    Then I press the "Continue" button
    And I select "O - OTHER" from the "Reason for excusal request" dropdown
    And I set the radio button to "Grant excusal"
    And I press the "Continue" button

    And the user searches for juror record "<juror_number>" from the global search bar
    And I see the juror status has updated to "Excused"

    And I ensure juror "<juror_number>" has an excusal code set

     #delete a pending document
    And I press the "Apps" button
    And I click on the "Documents" link
    And I click on the "Excusal granted letters" link
    And I set the radio button to "Juror"
    When I set "Enter juror number" to "<juror_number>"
    And I press the "Search" button
    Then I see "Pending" on the page
    And I see "Change" on the page
    And I click on the "Delete" link
    And I see "1 pending document deleted" on the page

    Examples:
      | juror_number  | pool_number | user          |
      |  041529012    | 415980685   | MODTESTBUREAU |


  @JurorTransformationMulti
  Scenario Outline: Excusal granted letter - via pool Number happy path bulk

    Given I am on "Bureau" "demo"
    And I log in as "<user>"

    When a bureau owned pool is created with jurors
      | court   | juror_number    | pool_number     | att_date_weeks_in_future  | owner |
      | 415     | <juror_number>  | <pool_number>   | 5                         | 400   |
      | 415     | <juror_number_2>| <pool_number>   | 5                         | 400   |
      | 415     | <juror_number_3>| <pool_number>   | 5                         | 400   |

    #record response for first juror
    And the user searches for juror record "<juror_number>" from the global search bar
    And I record an excusal request paper summons response
    And the user searches for juror record "<juror_number>" from the global search bar
    And I click on the "Summons reply" link
    And I click on the "View summons reply" link
    And I press the "Process reply" button

    And I set the radio button to "Excusal - grant or refuse"
    Then I press the "Continue" button
    And I select "O - OTHER" from the "Reason for excusal request" dropdown
    And I set the radio button to "Grant excusal"
    And I press the "Continue" button
    And the user searches for juror record "<juror_number>" from the global search bar
    And I see the juror status has updated to "Excused"
    And I ensure juror "<juror_number>" has an excusal code set

    #record response for second juror
    And the user searches for juror record "<juror_number_2>" from the global search bar
    And I record an excusal request paper summons response
    And the user searches for juror record "<juror_number_2>" from the global search bar
    And I click on the "Summons reply" link
    And I click on the "View summons reply" link
    And I press the "Process reply" button

    And I set the radio button to "Excusal - grant or refuse"
    Then I press the "Continue" button
    And I select "O - OTHER" from the "Reason for excusal request" dropdown
    And I set the radio button to "Grant excusal"
    And I press the "Continue" button
    And the user searches for juror record "<juror_number_2>" from the global search bar
    And I see the juror status has updated to "Excused"
    And I ensure juror "<juror_number_2>" has an excusal code set

     #record response for third juror
    And the user searches for juror record "<juror_number_3>" from the global search bar
    And I record an excusal request paper summons response
    And the user searches for juror record "<juror_number_3>" from the global search bar
    And I click on the "Summons reply" link
    And I click on the "View summons reply" link
    And I press the "Process reply" button

    And I set the radio button to "Excusal - grant or refuse"
    Then I press the "Continue" button
    And I select "O - OTHER" from the "Reason for excusal request" dropdown
    And I set the radio button to "Grant excusal"
    And I press the "Continue" button
    And the user searches for juror record "<juror_number_3>" from the global search bar
    And I see the juror status has updated to "Excused"
    And I ensure juror "<juror_number_3>" has an excusal code set

  #search via pool  number and resend letter for all jurors
    When I press the "Apps" button
    And I click on the "Documents" link
    And I click on the "Excusal granted letters" link
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
    And I click on the "Excusal granted letters" link
    And I set the radio button to "Pool"
    And I set "Enter pool number" to "<pool_number>"
    And I press the "Search" button

    And I see the printed letter for juror number "<juror_number>" in the letters table
    And I see the printed letter for juror number "<juror_number_2>" in the letters table
    And I see the printed letter for juror number "<juror_number_3>" in the letters table
    And I see "Excusal granted letters" on the page
    And I check the "<juror_number>" checkbox
    And I check the "<juror_number_2>" checkbox
    And I check the "<juror_number_3>" checkbox
    And I press the "Resend excusal granted letter" button
    And I see "3 documents sent for printing" on the page

    Examples:
      | juror_number | juror_number_2 | juror_number_3 | pool_number | user          |
      | 041529056    | 041529057      | 041529058      | 415980676   | MODTESTBUREAU |


  @JurorTransformationMulti
  Scenario Outline:As a bureau officer test a excused juror can resend a granted letter by searching via Pool number - unhappy path

    Given I am on "Bureau" "demo"
    And I log in as "<user>"
    When a bureau owned pool is created with jurors
      | court   | juror_number    | pool_number     | att_date_weeks_in_future  | owner |
      | 415     | <juror_number>  | <pool_number>   | 5                         | 400   |
      | 415     | <juror_number_1>| <pool_number>   | 5                         | 400   |

    #record response for first juror
    And the user searches for juror record "<juror_number>" from the global search bar
    And I record an excusal request paper summons response
    And the user searches for juror record "<juror_number>" from the global search bar
    And I click on the "Summons reply" link
    And I click on the "View summons reply" link
    And I press the "Process reply" button

    And I set the radio button to "Excusal - grant or refuse"
    Then I press the "Continue" button
    And I select "O - OTHER" from the "Reason for excusal request" dropdown
    And I set the radio button to "Grant excusal"
    And I press the "Continue" button
    And the user searches for juror record "<juror_number>" from the global search bar
    And I see the juror status has updated to "Excused"
    And I ensure juror "<juror_number>" has an excusal code set

    #record response for second juror
    And the user searches for juror record "<juror_number_1>" from the global search bar
    And I record an excusal request paper summons response
    And the user searches for juror record "<juror_number_1>" from the global search bar
    And I click on the "Summons reply" link
    And I click on the "View summons reply" link
    And I press the "Process reply" button

    And I set the radio button to "Excusal - grant or refuse"
    Then I press the "Continue" button
    And I select "O - OTHER" from the "Reason for excusal request" dropdown
    And I set the radio button to "Grant excusal"
    And I press the "Continue" button
    And the user searches for juror record "<juror_number_1>" from the global search bar
    And I see the juror status has updated to "Excused"
    And I ensure juror "<juror_number_1>" has an excusal code set

    #search via pool  number and resend letter for first excused juror
    When I press the "Apps" button
    And I click on the "Documents" link
    And I click on the "Excusal granted letters" link
    And I press the "Search" button
    Then I see error "Select whether you want to search by juror or pool"
    And I set the radio button to "Pool"
    And I set "Enter pool number" to "<pool_number>"
    And I press the "Search" button
    And I see "Pending" on the page
    And I see "Change" on the page
    And I update juror "<juror_number>" to change the status of printed in order to resend letter
    And I press the "Apps" button
    And I click on the "Documents" link
    And I click on the "Excusal granted letters" link
    And I set the radio button to "Pool"
    And I set "Enter pool number" to "<pool_number>"
    And I press the "Search" button
    And I see the printed letter for juror number "<juror_number>" in the letters table
    And I see "Excusal granted letters" on the page
    And I check the "<juror_number>" checkbox
    And I press the "Resend excusal granted letter" button
    And I see "1 document sent for printing" on the page

    #change juror status to deceased
    And the user searches for juror record "<juror_number_1>" from the global search bar
    And I press the "Update juror record" button
    And I set the radio button to "Mark as deceased"
    And I set "Comments to record in the juror’s history" to "Juror has passed"
    And I press the "Continue" button
    And I see "Juror record updated: Deceased" on the page

    And I press the "Apps" button
    When I click on the "Documents" link
    And I click on the "Excusal granted letters" link
    And I set the radio button to "Pool"
    And I set "Enter pool number" to "<pool_number>"
    And I press the "Search" button
    Then I see "<juror_number>" in the same row as "Excused"
    And I see "<juror_number_1>" in the same row as "Deceased"

    Examples:
      | juror_number| juror_number_1  | pool_number | user          |
      |  041529013  | 041529034       | 415980685   | MODTESTBUREAU |


  @JurorTransformationMulti
  Scenario Outline:Verify as a bureau user can view letters queued for printing and can delete it

    Given I am on "Bureau" "ithc"

    When a bureau owned pool is created with jurors
      | court   | juror_number  | pool_number     | att_date_weeks_in_future  | owner |
      | 415     | <juror_number>| <pool_number>   | 5                         | 400   |

    And I log in as "<user>"
    And the user searches for juror record "<juror_number>" from the global search bar
    And I record an excusal request paper summons response
    And the user searches for juror record "<juror_number>" from the global search bar
    And I click on the "Summons reply" link
    And I click on the "View summons reply" link
    And I press the "Process reply" button

    And I set the radio button to "Excusal - grant or refuse"
    Then I press the "Continue" button
    And I select "O - OTHER" from the "Reason for excusal request" dropdown
    And I set the radio button to "Grant excusal"
    And I press the "Continue" button

    And the user searches for juror record "<juror_number>" from the global search bar
    And I see the juror status has updated to "Excused"
    And I ensure juror "<juror_number>" has an excusal code set

   #navigate to documents and verify the printing message
    And I press the "Apps" button
    And I click on the "Documents" link
    And I click on the "Excusal granted letters" link
    When I set the radio button to "Show all letters queued for printing"
    And I press the "Search" button
    Then I see "041529015" on the page
    And I see "Change" on the page

    When I click on "Delete" in the same row as "<juror_number>"
    Then I see "1 pending document deleted" on the page

    Examples:
      | juror_number  |  pool_number  | user          |
      |  041529015    |415980685      | MODTESTBUREAU |


  @JurorTransformation
  Scenario Outline: As a jury officer I want to print a excusal granted letter for juror

    Given I am on "Bureau" "ithc"
    When a bureau owned pool is created with jurors
      | court |juror_number  	    | pool_number	    | att_date_weeks_in_future	| owner |
      | 415   | <juror_number>| <pool_number>           | 5                          | 400  |

    Then a new pool is inserted for where record has transferred to the court new schema
      |part_no              | pool_no           | owner |
     | <juror_number>       | <pool_number>     | 415   |

    And I log in as "<user>"
    And I update the bureau transfer date of the juror "<juror_number>"
    And the user searches for juror record "<juror_number>" from the global search bar
    And I record an excusal request paper summons response

    #view response and grant excusal
    And the user searches for juror record "<juror_number>" from the global search bar
    And I click on the "Summons reply" link
    And I click on the "View summons reply" link
    And I press the "Process reply" button

    And I set the radio button to "Excusal - grant or refuse"
    Then I press the "Continue" button
    And I select "O - OTHER" from the "Reason for excusal request" dropdown
    And I set the radio button to "Grant excusal"
    And I press the "Continue" button
    And I see "Do you want to print an excusal granted letter?" on the page
    And I choose the "Yes" radio button
    And I press the "Continue" button

    Given I am on "Bureau" "ithc"
    And I log in as "<user>"
    And I press the "Apps" button
    And I click on the "Documents" link
    And I click on the "Excusal granted letters" link
    And I set the radio button to "Juror number"
    And I set "Enter juror number" to "<juror_number>"
    And I check the "Include printed" checkbox
    And I press the "Search" button
    And I see the printed letter for juror number "<juror_number>" in the letters table


    Examples:
      | juror_number  | pool_number | user      |
      |  041529016    | 415980685   | MODCOURT  |


  @JurorTransformationMulti
  Scenario Outline:As a jury officer test a Excused juror can resend a granted letter by searching via pool number

    Given I am on "Bureau" "ithc"

    When a bureau owned pool is created with jurors
      | court |juror_number   | pool_number	    | att_date_weeks_in_future	| owner |
      | 415   | <juror_number>| <pool_number>   | 5                         | 400   |

    Then a new pool is inserted for where record has transferred to the court new schema
      |part_no        | pool_no           | owner |
      | <juror_number>| <pool_number>     | 415   |

    And I log in as "<user>"
    And the user searches for juror record "<juror_number>" from the global search bar
    And I record an excusal request paper summons response
    And the user searches for juror record "<juror_number>" from the global search bar
    And I click on the "Summons reply" link
    And I click on the "View summons reply" link
    And I press the "Process reply" button

    And I set the radio button to "Excusal - grant or refuse"
    Then I press the "Continue" button
    And I select "O - OTHER" from the "Reason for excusal request" dropdown
    And I set the radio button to "Grant excusal"
    And I press the "Continue" button
    And I see "Do you want to print an excusal granted letter?" on the page
    And I choose the "No" radio button
    And I press the "Continue" button

    And the user searches for juror record "<juror_number>" from the global search bar
    And I see the juror status has updated to "Excused"

    When I press the "Apps" button
    And I click on the "Documents" link
    And I click on the "Excusal granted letters" link
    And I press the "Search" button
    Then I see error "Select whether you want to search by juror or pool"
    And I see "juror" on the page
    And I see "Pool" on the page
    And I see "Include printed" on the page
    And I see "Search" on the page
    And I set the radio button to "Pool"
    And I press the "Search" button
    And I see error "Enter pool number"
    When I set "Enter pool number" to "<pool_number>"
    And I check the "Include printed" checkbox
    And I press the "Search" button
    Then I see "Change" on the page
    And I see "Print excusal granted letter" on the page
    When I check the "<juror_number>" checkbox
    And I press the "Print excusal granted letter" button
    Then I see "/documents/excusal-granted/letters-list" in the URL

    Examples:
      | juror_number  | pool_number | user          |
      |  041529017    | 415980685   | MODTESTCOURT  |