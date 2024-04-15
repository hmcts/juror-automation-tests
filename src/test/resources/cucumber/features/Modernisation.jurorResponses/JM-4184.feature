Feature: JM-4184 - The system shall allow the jury officer to process a summons reply that has been returned late

  @JurorTransformationMulti @NewSchemaConverted
  Scenario Outline: Process summons reply that has been returned late (Disqualify)
    Given I am on "Bureau" "test"

    Given a bureau owned pool is created with jurors
      | court  |juror_number  	| pool_number	   | att_date_weeks_in_future	| owner |
      | 415    |<juror_number>  | <pool_number>    | -1				            | 400	|

    #log on and search for juror
    And I log in as "<user>"

    Then a new pool is inserted for where record has transferred to the court new schema
      |part_no         | pool_no       | owner |
      |<juror_number>  | <pool_number> | 415   |

    When the user searches for juror record "<juror_number>" from the global search bar
    And I record a happy path paper summons response
    And I click on the "No, skip and process later" link

    When the user searches for juror record "<juror_number>" from the global search bar
    Then I click the summons reply tab
    And I click on the view summons reply link
    And I see "Juror’s service start date has passed" on the page
    And I press the "Process reply" button
    And I set the radio button to "Disqualify"
    And I press the "Continue" button
    And I set the radio button to "R - Residency"
    And I press the "Continue" button
    When the user searches for juror record "<juror_number>" from the global search bar
    Then I click the summons reply tab
    And I click on the view summons reply link
    And I see the reply status has updated to "COMPLETED"

    Examples:
      | user		  | juror_number  | pool_number  |
      | MODTESTCOURT  | 041500064     | 415300154    |


  @JurorTransformationMulti @NewSchemaConverted
  Scenario Outline: Process summons reply that has been returned late (Deferral)
    Given I am on "Bureau" "test"

    Given a bureau owned pool is created with jurors
      | court  |juror_number  	| pool_number	   | att_date_weeks_in_future	| owner |
      | 415    |<juror_number>  | <pool_number>    | -1				            | 400	|

    Then a new pool is inserted for where record has transferred to the court new schema
      | part_no         | pool_no       | owner |
      | <juror_number>  | <pool_number> | 415   |

    #log on and search for juror
    And I log in as "<user>"

    When the user searches for juror record "<juror_number>" from the global search bar
    Then I record a happy path deferral paper summons response

    When the user searches for juror record "<juror_number>" from the global search bar

    Then I click the summons reply tab
    And I click on the view summons reply link
    And I see "Juror’s service start date has passed" on the page

    And I press the "Process reply" button
    And I set the radio button to "Defer juror"
    And I press the "Continue" button

    Then I set the "first" choice to "11" Mondays in the future
    Then I set the "second" choice to "12" Mondays in the future
    Then I set the "third" choice to "13" Mondays in the future
    And I click continue on the process reply page

    Then I select "O - OTHER" from the "Reason for the deferral request" dropdown
    Then I set the radio button to "Choose a different date"
    Then I set the "alternate" choice to "1" Mondays in the future
    And I press the "Continue" button

    Then I select one of the active pools available
    And I press the "Continue" button

 #view summons response
    When the user searches for juror record "<juror_number>" from the global search bar
    And I click on the "Summons reply" link
    And I click on the "View summons reply" link
    And I see the reply status has updated to "COMPLETED"

    Examples:
      | user		  | juror_number| pool_number |
      | MODTESTCOURT  | 041500065   | 415300155   |


  @JurorTransformationMulti @NewSchemaConverted
  Scenario Outline: Process summons reply that has been returned late (Excusal)
    Given I am on "Bureau" "test"

    Given a bureau owned pool is created with jurors
      | court  |juror_number  	| pool_number	   | att_date_weeks_in_future	| owner |
      | 415    |<juror_number>  | <pool_number>    | -1				            | 400	|

    Then a new pool is inserted for where record has transferred to the court new schema
      |part_no        | pool_no       | owner |
      |<juror_number> | <pool_number> | 415   |

    #log on and search for juror
    And I log in as "<user>"

    When the user searches for juror record "<juror_number>" from the global search bar
    And I record an excusal request paper summons response

    When the user searches for juror record "<juror_number>" from the global search bar

    Then I click the summons reply tab
    And I click on the view summons reply link
    And I see "Juror’s service start date has passed" on the page

    And I press the "Process reply" button
    And I press the "Continue" button
    And I see error "Please select a response process type"

    #select refuse excusal
    And I set the radio button to "Excusal - grant or refuse"
    Then I press the "Continue" button
    And I select "O - OTHER" from the "Reason for excusal request" dropdown
    And I set the radio button to "Grant excusal"
    And I press the "Continue" button

    #view summons response
    When the user searches for juror record "<juror_number>" from the global search bar
    And I click on the "Summons reply" link
    And I click on the "View summons reply" link
    And I see the reply status has updated to "COMPLETED"

    Examples:
      | user		  | juror_number  | pool_number  |
      | MODTESTCOURT  | 041500066     | 415300156    |

  @JurorTransformationMulti @NewSchemaConverted
  Scenario Outline: Process summons reply that has been returned late (Postponed)
    Given I am on "Bureau" "test"

    Given a bureau owned pool is created with jurors
      | court  |juror_number  	| pool_number	   | att_date_weeks_in_future	| owner |
      | 415    |<juror_number>  | <pool_number>    | -1				            | 400	|

    Then a new pool is inserted for where record has transferred to the court new schema
      |part_no        | pool_no       | owner |
      |<juror_number> | <pool_number> | 415   |

    #log on and search for juror
    And I log in as "<user>"

    When the user searches for juror record "<juror_number>" from the global search bar
    And I record a paper summons response with reasonable adjustment of "C - Caring Responsibilities"

    When the user searches for juror record "<juror_number>" from the global search bar

    Then I click the summons reply tab
    And I click on the view summons reply link
    And I see "Juror’s service start date has passed" on the page

    And I press the "Process reply" button
    And I press the "Continue" button
    And I see error "Please select a response process type"

    #select postpone
    And I set the radio button to "Postpone"
    Then I press the "Continue" button
    And I see "Enter a new service start date" on the page
    And I set the "Postpone service start date" date to a Monday "43" weeks in the future
    Then I press the "Continue" button
    And I see "There are no active pools for this date" on the page
    And I press the "Put in deferral maintenance" button
    And I see "Do you want to print a postponement letter?" on the page
    And I set the radio button to "No"
    Then I press the "Continue" button
    And I see "Juror record updated: Postponed" on the page
    And I see the juror status has updated to "Deferred"

    Examples:
      | user		  | juror_number  | pool_number  |
      | MODTESTCOURT  | 041516913     | 415308241    |


  @JurorTransformationMulti @NewSchemaConverted @JM-6998
  Scenario Outline: Process summons reply that has been returned late (Reassign)
    Given I am on "Bureau" "test"

    Given a bureau owned pool is created with jurors
      | court  |juror_number  	| pool_number	   | att_date_weeks_in_future	| owner |
      | 415    |<juror_number>  | <pool_number>    | -4				            | 400	|

    Then a new pool is inserted for where record has transferred to the court new schema
      |part_no        | pool_no       | owner |
      |<juror_number> | <pool_number> | 415   |

    #log on and search for juror
    And I log in as "<user>"

    When the user searches for juror record "<juror_number>" from the global search bar
    And I record a paper summons response with reasonable adjustment of "C - Caring Responsibilities"
    When the user searches for juror record "<juror_number>" from the global search bar

    Then I click the summons reply tab
    And I click on the "View summons reply" link
    And I see "Juror’s service start date has passed" on the page

    And I press the "Process reply" button
    And I press the "Continue" button
    And I see error "Please select a response process type"

    #select postpone
    And I set the radio button to "Re-assign to an active pool"
    Then I press the "Continue" button
    And I see "Choose a pool to reassign to" on the page
    And I select one of the active pools available
    And I press the "Continue" button
    And I see "Juror record updated: Reassigned to pool" on the page


    Examples:
      | user		  | juror_number  | pool_number  |
      | MODTESTCOURT  | 041518965     | 415308241    |
