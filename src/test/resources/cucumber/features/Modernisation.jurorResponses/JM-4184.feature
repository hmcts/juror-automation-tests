Feature: JM-4184 - The system shall allow the jury officer to process a summons reply that has been returned late

  @JurorTransformationMulti
  Scenario Outline: Process summons reply that has been returned late (Disqualify)
    Given I am on "Bureau" "test"

    Given the juror numbers have not been processed new schema
      |part_no     | pool_no   | owner |
      |<part_no>   | <pool_no> | 400   |

    And "<part_no>" has "NEXT_DATE" as "5 mondays time" new schema

    #log on and search for juror
    And I log in as "<user>"

    Then a new pool is inserted for where record has transferred to the court new schema
      |part_no    | pool_no   | owner |
      |<part_no>  | <pool_no> | 415   |

    When the user searches for juror record "<part_no>" from the global search bar
    And I record a happy path paper summons response
    And I click on the "No, skip and process later" link

    When the user searches for juror record "<part_no>" from the global search bar
    Then I click the summons reply tab
    And I click on the view summons reply link
    And I see "Juror’s service start date has passed" on the page
    And I press the "Process reply" button
    And I set the radio button to "Disqualify"
    And I press the "Continue" button
    And I set the radio button to "R - Residency"
    And I press the "Continue" button
    When the user searches for juror record "<part_no>" from the global search bar
    Then I click the summons reply tab
    And I click on the view summons reply link
    And I see the reply status has updated to "COMPLETED"

    Examples:
      |user			|part_no  |pool_no  |
      |MODTESTCOURT |141500908|415230902|


  @JurorTransformationMulti @NewSchemaConverted
  Scenario Outline: Process summons reply that has been returned late (Deferral)
    Given I am on "Bureau" "test"

    Given the juror numbers have not been processed new schema
      |part_no     | pool_no   | owner |
      |<part_no>   | <pool_no> | 400   |

    Then a new pool is inserted for where record has transferred to the court new schema
      |part_no    | pool_no   | owner |
      |<part_no>  | <pool_no> | 415   |

    And "<part_no>" has "NEXT_DATE" as "5 mondays time" new schema

    #log on and search for juror
    And I log in as "<user>"

    When the user searches for juror record "<part_no>" from the global search bar
    Then I record a happy path deferral paper summons response

    When the user searches for juror record "<part_no>" from the global search bar

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
    Then I set the "alternate" choice to "-12" Mondays in the future
    And I press the "Continue" button

    Then I see "There are no active pools for this date" on the page
    And I press the "Put in deferral maintenance" button

 #view summons response
    When the user searches for juror record "<part_no>" from the global search bar
    And I click on the "Summons reply" link
    And I click on the "View summons reply" link
    And I see the reply status has updated to "COMPLETED"

    Examples:
      |user			|part_no  |pool_no  |
      |MODTESTCOURT |141500455|415230902|


  @JurorTransformationMulti @NewSchemaConverted
  Scenario Outline: Process summons reply that has been returned late (Excusal)
    Given I am on "Bureau" "test"

    Given the juror numbers have not been processed new schema
      |part_no     | pool_no   | owner |
      |<part_no>   | <pool_no> | 400   |

    Then a new pool is inserted for where record has transferred to the court new schema
      |part_no    | pool_no   | owner |
      |<part_no>  | <pool_no> | 415   |

    And "<part_no>" has "NEXT_DATE" as "5 mondays time" new schema

    #log on and search for juror
    And I log in as "<user>"

    When the user searches for juror record "<part_no>" from the global search bar
    And I record an excusal request paper summons response

    When the user searches for juror record "<part_no>" from the global search bar

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
    When the user searches for juror record "<part_no>" from the global search bar
    And I click on the "Summons reply" link
    And I click on the "View summons reply" link
    And I see the reply status has updated to "COMPLETED"

    Examples:
      |user			|part_no  |pool_no  |
      |MODTESTCOURT |141500533|415230902|

    #postpone and reassign scenarios are mentioned in the ticket as 'yet to be affirmed', if those scenarios are implemented in a new ticket i will update this script