Feature: JM-5417-5586 - Resend excusal refused letter for Bureau and Jury users

  @JurorTransformationWIP
  Scenario Outline: Excusal refused letter - via juror number

    #return to MULTI once defect JS-618 fixed

    Given I am on "Bureau" "ithc"

    When a bureau owned pool is created with jurors
      | court | juror_number  | pool_number     | att_date_weeks_in_future   | owner |
      | 415     | <juror_number>| <pool_number> | 5                          | 400  |

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
    And I set the radio button to "Refuse excusal"
    And I press the "Continue" button

    #return to juror record - status will be responded due to refusal
    When the user searches for juror record "<juror_number>" from the global search bar
    Then I see the juror's status on the juror record screen is "Summoned"

    And I press the "Apps" button
    When I click on the "Documents" link
    And I click on the "Excusal refused letters" link
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
    And I click on the "Excusal refused letters" link
    And I set the radio button to "Juror"
    And I set "Enter juror number" to "<juror_number>"
    And I press the "Search" button

    #will fail here because of JM-6314
    And I see the printed letter for juror number "<juror_number>" in the letters table
    And I see "Excusal refused letters" on the page
    And I check the "<juror_number>" checkbox
    And I press the "Resend excusal refused letter" button
    And I see "1 document sent for printing" on the page

    Examples:
      | juror_number  | pool_number | user          |
      |  041529018    | 415980686   | MODTESTBUREAU |

  @JurorTransformationWIP
  Scenario Outline: Delete pending excusal refused letter as a bureau officer

    #return to MULTI once defect JS-618 fixed

    Given I am on "Bureau" "ithc"

    And I log in as "<user>"
    When a bureau owned pool is created with jurors
      | court | juror_number  | pool_number     | att_date_weeks_in_future   | owner |
      | 415     | <juror_number>| <pool_number> | 5                       | 400  |

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
    And I set the radio button to "Refuse excusal"
    And I press the "Continue" button

    #return to juror record - status will be responded due to refusal
    When the user searches for juror record "<juror_number>" from the global search bar
    Then I see the juror's status on the juror record screen is "Summoned"

    #delete a pending document
    And I press the "Apps" button
    And I click on the "Documents" link
    And I click on the "Excusal refused letters" link
    And I set the radio button to "Juror"
    When I set "Enter juror number" to "<juror_number>"
    And I press the "Search" button

    #will fail here because of JM-6314
    Then I see "Pending" on the page
    And I see "Change" on the page
    And I click on the "Delete" link
    And I see "1 pending document deleted" on the page

    Examples:
      | juror_number  | pool_number | user          |
      |  041529019    | 415980686   | MODTESTBUREAU |


  @JurorTransformationWIP
  Scenario Outline: Excusal refused letter - via pool Number happy path bulk

    #return to MULTI once defect JS-618 fixed

    Given I am on "Bureau" "ithc"

    And I log in as "<user>"

    When a bureau owned pool is created with jurors
      | court   | juror_number  | pool_number     | att_date_weeks_in_future  | owner |
      | 415     | <juror_number>| <pool_number>   | 5                         | 400  |
      | 415     | <juror_number_2>| <pool_number> | 5                         | 400  |
      | 415     | <juror_number_3>| <pool_number> | 5                         | 400  |

    #record response for first juror
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
    And I set the radio button to "Refuse excusal"
    And I press the "Continue" button

    #return to juror record - status will be summoned (JS-376)
    When the user searches for juror record "<juror_number>" from the global search bar
    And I see the juror status has updated to "Summoned"
    #record response for second juror
    And the user searches for juror record "<juror_number_2>" from the global search bar
    And I record an excusal request paper summons response
    And the user searches for juror record "<juror_number_2>" from the global search bar
    And I click on the "Summons reply" link
    And I click on the "View summons reply" link
    And I press the "Process reply" button

    #select refuse excusal
    And I set the radio button to "Excusal - grant or refuse"
    Then I press the "Continue" button
    And I select "O - OTHER" from the "Reason for excusal request" dropdown
    And I set the radio button to "Refuse excusal"
    And I press the "Continue" button

    #return to juror record - status will be responded due to refusal
    When the user searches for juror record "<juror_number_2>" from the global search bar
    And I see "<juror_number_2>" on the page
    Then I see the juror's status on the juror record screen is "Summoned"

    #record response for third juror
    And the user searches for juror record "<juror_number_3>" from the global search bar
    And I record an excusal request paper summons response
    And the user searches for juror record "<juror_number_3>" from the global search bar
    And I click on the "Summons reply" link
    And I click on the "View summons reply" link
    And I press the "Process reply" button

    #select refuse excusal
    And I set the radio button to "Excusal - grant or refuse"
    Then I press the "Continue" button
    And I select "O - OTHER" from the "Reason for excusal request" dropdown
    And I set the radio button to "Refuse excusal"
    And I press the "Continue" button

    #return to juror record - status will be responded due to refusal
    When the user searches for juror record "<juror_number_3>" from the global search bar
    Then I see the juror's status on the juror record screen is "Summoned"

    #search via pool  number and resend letter for all jurors
    When I press the "Apps" button
    And I click on the "Documents" link
    And I click on the "Excusal refused letters" link
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
    And I click on the "Excusal refused letters" link
    And I set the radio button to "Pool"
    And I set "Enter pool number" to "<pool_number>"
    And I press the "Search" button

    #will fail here because of JM-6314
    And I see the printed letter for juror number "<juror_number>" in the letters table
    And I see the printed letter for juror number "<juror_number_2>" in the letters table
    And I see the printed letter for juror number "<juror_number_3>" in the letters table
    And I see "Excusal refused letters" on the page
    And I check the "<juror_number>" checkbox
    And I check the "<juror_number_2>" checkbox
    And I check the "<juror_number_3>" checkbox
    And I press the "Resend excusal refused letter" button
    And I see "3 documents sent for printing" on the page

    Examples:
      | juror_number  |juror_number_2 |juror_number_3 |pool_number | user          |
      |  041529024    | 041529040     |041529041      |415980686   | MODTESTBUREAU |


  @JurorTransformationWIP
  Scenario Outline: As a Bureau officer view all the letters queued for printing and delete

    #return to MULTI once defect JS-618 fixed

    Given I am on "Bureau" "ithc"

    When a bureau owned pool is created with jurors
      | court   | juror_number  | pool_number     | att_date_weeks_in_future   | owner |
      | 415     | <juror_number>| <pool_number>   | 5                       | 400  |

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
    And I set the radio button to "Refuse excusal"
    And I press the "Continue" button

    #return to juror record - status will be responded due to refusal
    When the user searches for juror record "<juror_number>" from the global search bar
    Then I see the juror's status on the juror record screen is "Summoned"

    #navigate to documents and verify the printing message
    And I press the "Apps" button
    And I click on the "Documents" link
    And I click on the "Excusal refused letters" link
    When I set the radio button to "Show all letters queued for printing"
    And I press the "Search" button

    Then I see "<juror_number>" on the page
    And I see "Change" on the page
    When I click on "Delete" in the same row as "<juror_number>"
    And I see "1 pending document deleted" on the page

    Examples:
      | juror_number  |  pool_number | user          |
      |  041586222     |415980686   | MODTESTBUREAU |


  @JurorTransformationWIP
  Scenario Outline:As a jury officer test a Excused juror can resend a refused letter by searching via juror number

    # return to MULTI once defect JS-618 fixed

    Given I am on "Bureau" "ithc"

    When a bureau owned pool is created with jurors
      | court | juror_number   | pool_number	    | att_date_weeks_in_future	| owner |
      | 415   | <juror_number> | <pool_number>      | 5                         | 400   |

    Then a new pool is inserted for where record has transferred to the court new schema
     | part_no              | pool_no           | owner |
     | <juror_number>       | <pool_number>     | 415   |

    And I log in as "<user>"

    And I update the bureau transfer date of the juror "<juror_number>"

    #record response
    And the user searches for juror record "<juror_number>" from the global search bar
    And I record an excusal request paper summons response

    #view response and grant excusal
    And the user searches for juror record "<juror_number>" from the global search bar
    And I click on the "Summons reply" link
    And I click on the "View summons reply" link
    And I press the "Process reply" button

    #select refuse excusal
    And I set the radio button to "Excusal - grant or refuse"
    Then I press the "Continue" button
    And I select "O - OTHER" from the "Reason for excusal request" dropdown
    And I set the radio button to "Refuse excusal"
    And I press the "Continue" button
    And I see "Do you want to print an excusal refused letter?" on the page
    And I choose the "No" radio button
    And I press the "Continue" button

    #return to juror record - status will be responded due to refusal
    When the user searches for juror record "<juror_number>" from the global search bar
    Then I see the juror's status on the juror record screen is "Summoned"

    And I press the "Apps" button
    When I click on the "Documents" link
    And I click on the "Excusal refused letters" link
    And I press the "Search" button
    Then I see error "Select whether you want to search by juror or pool"
    And I see "juror" on the page
    And I see "Pool" on the page
    And I see "Include printed" on the page
    And I see "Search" on the page
    And I set the radio button to "Juror"
    And I check the "Include printed" checkbox
    And I press the "Search" button
    And I see error "Enter juror number"
    When I set "Enter juror number" to "<juror_number>"
    And I press the "Search" button

    #will fail here because of JM-8200
    And I see "Print excusal refused letter" on the page
    And I see the printed letter for juror number "<juror_number>" in the letters table

    Examples:
      | juror_number  | pool_number | user         |
      | 041586214     | 415982987   | MODTESTCOURT |

  @JurorTransformationMulti
  Scenario Outline:As a jury officer test a Excused juror can resend a refused letter by searching via pool number

    Given I am on "Bureau" "ithc"

    When a bureau owned pool is created with jurors
      | court | juror_number  | pool_number	    | att_date_weeks_in_future	| owner |
      | 415   | <juror_number>| <pool_number>   | 5                          | 400  |

    Then a new pool is inserted for where record has transferred to the court new schema
      | part_no         | pool_no         | owner |
      | <juror_number>  | <pool_number>   | 415   |

    And I log in as "<user>"

    And I update the bureau transfer date of the juror "<juror_number>"
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
    And I set the radio button to "Refuse excusal"
    And I press the "Continue" button
    And I see "Do you want to print an excusal refused letter?" on the page
    And I choose the "Yes" radio button
    And I press the "Continue" button

    And I press the "Apps" button
    When I click on the "Documents" link
    And I click on the "Excusal refused letters" link
    And I press the "Search" button
    Then I see error "Select whether you want to search by juror or pool"
    And I see "juror" on the page
    And I see "Pool" on the page
    And I see "Include printed" on the page
    And I see "Search" on the page
    And I set the radio button to "Pool"
    And I check the "Include printed" checkbox
    And I press the "Search" button
    And I see error "Enter pool number"
    When I set "Enter pool number" to "<pool_number>"
    And I press the "Search" button

    And I see "Print excusal refused letter" on the page
    And I see the printed letter for juror number "<juror_number>" in the letters table

    Examples:
      | juror_number  | pool_number | user         |
      | 041586213     | 415982987   | MODTESTCOURT |