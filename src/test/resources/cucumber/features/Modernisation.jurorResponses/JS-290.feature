Feature: JS-290

  @JurorTransformationMulti
  Scenario Outline: Excusal refused letter - check jurors address matches that in bulk print table

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

    #return to juror record - status will be summoned as per JS-376
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

    And I see the printed letter for juror number "<juror_number>" in the letters table
    And I see "Excusal refused letters" on the page
    And I check the "<juror_number>" checkbox
    And I press the "Resend excusal refused letter" button
    And I see "1 document sent for printing" on the page
    And I verify address "<juror_address>" exists in print record for juror "<juror_number>"

    Examples:
      | juror_number  | pool_number | user          | juror_address     |
      |  041573611    | 415984412   | MODTESTBUREAU | ADDRESS LINE FOUR |

  @JurorTransformationMulti
  Scenario Outline: Excusal refused letter - when responded

    Given I am on "Bureau" "demo"

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

    #return to juror record - status will be summoned as per JS-376
    When the user searches for juror record "<juror_number>" from the global search bar
    Then I see the juror's status on the juror record screen is "Summoned"

    And I press the "Update juror record" button
    And I choose the "Mark as responded" radio button
    And I press the "Continue" button
    And I check the "Mark juror as 'responded'" checkbox
    And I press the "Confirm" button
    Then I see "Responded" on the page

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

    And I see the printed letter for juror number "<juror_number>" in the letters table
    And I see "Excusal refused letters" on the page
    And I check the "<juror_number>" checkbox
    And I press the "Resend excusal refused letter" button
    And I see "1 document sent for printing" on the page
    And I verify address "<juror_address>" exists in print record for juror "<juror_number>"

    Examples:
      | juror_number  | pool_number | user          | juror_address     |
      |  041573617    | 415984417   | MODTESTBUREAU | ADDRESS LINE FOUR |

  @JurorTransformationMulti
  Scenario Outline: Resend Withdrawal letter as a bureau officer - check jurors address matches that in bulk print table

    Given I am on "Bureau" "ithc"

    When a bureau owned pool is created with jurors
      | court | juror_number  | pool_number   | att_date_weeks_in_future   | owner |
      | 415   | <juror_number>| <pool_number> | 5                          | 400   |

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
    And I verify address "<juror_address>" exists in print record for juror "<juror_number>"

    Examples:
      | juror_number | pool_number | user          | juror_address     |
      | 041573612    | 415984412   | MODTESTBUREAU | ADDRESS LINE FOUR |