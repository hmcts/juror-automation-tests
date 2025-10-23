Feature: Court responded jurors to receive confirmation pack

  @JurorTransformation
  Scenario Outline: Court responded juror receives conf pack - bilingual

    Given I am on "Bureau" "ithc"

    Given a bureau owned pool is created with jurors
      | court |juror_number        | pool_number	  | att_date_weeks_in_future	| owner |
      | 457   |<juror_number01>    | <pool_number01>  | 1				            | 400	|

    Then a new pool is inserted for where record has transferred to the court new schema
      |part_no                 | pool_no          | owner |
      |<juror_number01>        | <pool_number01>  | 457   |

    #log on and search for juror
    And I log in as "SWANSEA" selecting court "457"

    #respond juror
    Then the user searches for juror record "<juror_number01>" from the global search bar
    And I record a happy path paper summons response and process now

    #record welsh communication preference
    And I click on the "<juror_number01>" link
    And I click on the "Juror details" link
    And I see "Juror details" on the page
    And I click on the "Add or change" link
    And I see "Tick box if juror should get communications in Welsh (optional)" on the page
    And I check the "Yes, send Welsh language communications" checkbox
    And I press the "Save" button
    And I see "Yes" in the same row as "Welsh language"
    And I click on the "Overview" link

    #run check 1
    And I see "police check" on the page
    And I click on the "Run a police check" link
    And I see "Run a police check on this juror" on the page
    And I press the "Run police check" button
    And I see "Not Checked" on the page

    #refresh page
    When I refresh the page
    And I see "Passed" on the page

    Then I check that a bilingual confirmation letter has been generated for juror "<juror_number01>" new schema

    Examples:
      | juror_number01  | pool_number01 |
      | 045798031       | 457980930     |

  @JurorTransformation
  Scenario Outline: Court responded juror receives conf pack - english at welsh court

    Given I am on "Bureau" "ithc"

    Given a bureau owned pool is created with jurors
      | court |juror_number        | pool_number	  | att_date_weeks_in_future	| owner |
      | 457   |<juror_number01>    | <pool_number01>  | 1				            | 400	|

    Then a new pool is inserted for where record has transferred to the court new schema
      |part_no                 | pool_no          | owner |
      |<juror_number01>        | <pool_number01>  | 457   |

    #log on and search for juror
    And I log in as "SWANSEA" selecting court "457"

    #respond juror
    Then the user searches for juror record "<juror_number01>" from the global search bar
    And I record a happy path paper summons response and process now
    And I click on the "<juror_number01>" link

    #run check 1
    And I see "police check" on the page
    And I click on the "Run a police check" link
    And I see "Run a police check on this juror" on the page
    And I press the "Run police check" button
    And I see "Not Checked" on the page

    #refresh page
    When I refresh the page
    And I see "Passed" on the page

    Then I check that a confirmation letter has been generated for juror "<juror_number01>" new schema

    Examples:
      | juror_number01  | pool_number01 |
      | 045798032       | 457980932     |

  @JurorTransformation
  Scenario Outline: Court responded juror receives conf pack

    Given I am on "Bureau" "ithc"

    Given a bureau owned pool is created with jurors
      | court |juror_number        | pool_number	  | att_date_weeks_in_future	| owner |
      | 415   |<juror_number01>    | <pool_number01>  | 1				            | 400	|

    Then a new pool is inserted for where record has transferred to the court new schema
      |part_no                 | pool_no          | owner |
      |<juror_number01>        | <pool_number01>  | 415   |

    #log on and search for juror
    And I log in as "MODTESTCOURT" selecting court "415"

    #respond juror
    Then the user searches for juror record "<juror_number01>" from the global search bar
    And I record a happy path paper summons response and process now
    And I click on the "<juror_number01>" link

    #run check 1
    And I click on the "Run a police check" link
    And I see "Run a police check on this juror" on the page
    And I press the "Run police check" button
    And I see "Not Checked" on the page

    #refresh page
    When I refresh the page
    And I see "Passed" on the page

    Then I check that a confirmation letter has been generated for juror "<juror_number01>" new schema

    Examples:
      | juror_number01  | pool_number01 |
      | 041598031       | 415980930     |

  @JurorTransformation
  Scenario Outline: Court responded juror does not receive conf pack when return date equals police check passed date

    Given I am on "Bureau" "ithc"

    Given a bureau owned pool is created with jurors
      | court |juror_number        | pool_number	  | att_date_weeks_in_future	| owner |
      | 415   |<juror_number01>    | <pool_number01>  | 0				            | 400	|

    Then a new pool is inserted for where record has transferred to the court new schema
      |part_no                 | pool_no          | owner |
      |<juror_number01>        | <pool_number01>  | 415   |

    #log on and search for juror
    And I log in as "MODTESTCOURT" selecting court "415"

    #respond juror
    Then the user searches for juror record "<juror_number01>" from the global search bar
    And I record a happy path paper summons response and process now
    And I click on the "<juror_number01>" link

    #run check 1
    And I click on the "Run a police check" link
    And I see "Run a police check on this juror" on the page
    And I press the "Run police check" button
    And I see "Not Checked" on the page

    #refresh page
    When I refresh the page
    And I see "Passed" on the page

    Then I check that a confirmation letter has not been generated for juror "<juror_number01>" new schema

    Examples:
      | juror_number01  | pool_number01 |
      | 041598032       | 415980932     |

  @JurorTransformation
  Scenario Outline: Court responded juror does not receive conf pack when return date before police check passed date

    Given I am on "Bureau" "ithc"

    Given a bureau owned pool is created with jurors
      | court |juror_number        | pool_number	  | att_date_weeks_in_future	| owner |
      | 415   |<juror_number01>    | <pool_number01>  | -1				            | 400	|

    Then a new pool is inserted for where record has transferred to the court new schema
      |part_no                 | pool_no          | owner |
      |<juror_number01>        | <pool_number01>  | 415   |

    #log on and search for juror
    And I log in as "MODTESTCOURT" selecting court "415"

    #respond juror
    Then the user searches for juror record "<juror_number01>" from the global search bar
    And I record a happy path paper summons response and process now
    And I click on the "<juror_number01>" link

    #run check 1
    And I click on the "Run a police check" link
    And I see "Run a police check on this juror" on the page
    And I press the "Run police check" button
    And I see "Not Checked" on the page

    #refresh page
    When I refresh the page
    And I see "Passed" on the page

    Then I check that a confirmation letter has not been generated for juror "<juror_number01>" new schema

    Examples:
      | juror_number01  | pool_number01 |
      | 041598033       | 415980933     |

  @JurorTransformation
  Scenario Outline: Court responded juror does not receive conf pack when responded date before police check passed date

    Given I am on "Bureau" "ithc"

    Given a bureau owned pool is created with jurors
      | court |juror_number        | pool_number	  | att_date_weeks_in_future	| owner |
      | 415   |<juror_number01>    | <pool_number01>  | 1				            | 400	|

    Then a new pool is inserted for where record has transferred to the court new schema
      |part_no                 | pool_no          | owner |
      |<juror_number01>        | <pool_number01>  | 415   |

    #log on and search for juror
    And I log in as "MODTESTCOURT" selecting court "415"

    #respond juror
    Then the user searches for juror record "<juror_number01>" from the global search bar
    And I record a happy path paper summons response and process now
    Then the "date_received" for juror "<juror_number01>" is set to "-1 mondays time" new schema
    Then the "completed_at" for juror "<juror_number01>" is set to "-1 mondays time" new schema
    Given "<juror_number01>" has "JUROR_HISTORY" . "DATE_CREATED" as "-1 mondays time" where "HISTORY_CODE" is "RESP" new schema
    And I click on the "<juror_number01>" link

    #run check 1
    And I click on the "Run a police check" link
    And I see "Run a police check on this juror" on the page
    And I press the "Run police check" button
    And I see "Not Checked" on the page

    #refresh page
    When I refresh the page
    And I see "Passed" on the page

    Then I check that a confirmation letter has not been generated for juror "<juror_number01>" new schema

    Examples:
      | juror_number01  | pool_number01 |
      | 041598033       | 415980933     |

  @JurorTransformation
  Scenario Outline: Court responded juror does not receive conf pack when police check fails

    Given I am on "Bureau" "ithc"

    Given a bureau owned pool is created with jurors
      | court |juror_number        | pool_number	  | att_date_weeks_in_future	| owner |
      | 415   |<juror_number01>    | <pool_number01>  | 1				            | 400	|

    Then a new pool is inserted for where record has transferred to the court new schema
      |part_no                 | pool_no          | owner |
      |<juror_number01>        | <pool_number01>  | 415   |

    And juror "<juror_number01>" has "FIRST_NAME" as "ARUN" new schema
    And juror "<juror_number01>" has "LAST_NAME" as "PATTANI" new schema
    And juror "<juror_number01>" has "POSTCODE" as "B68ZX" new schema

    #log on and search for juror
    And I log in as "MODTESTCOURT" selecting court "415"

    #respond juror
    Then the user searches for juror record "<juror_number01>" from the global search bar
    And I record a happy path paper summons response and process now
    And juror "<juror_number01>" has "DOB" as "1971-08-13 00:00:00.000" new schema

    And I click on the "<juror_number01>" link

    #run check 1
    And I click on the "Run a police check" link
    And I see "Run a police check on this juror" on the page
    And I press the "Run police check" button
    And I see "Not Checked" on the page

    #refresh page
    When I refresh the page
    And I see "Failed" on the page

    Then I check that a confirmation letter has not been generated for juror "<juror_number01>" new schema

    Examples:
      | juror_number01  | pool_number01 |
      | 223456719       | 415240701     |