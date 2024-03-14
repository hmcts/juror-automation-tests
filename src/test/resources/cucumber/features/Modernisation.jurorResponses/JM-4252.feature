Feature: JM-4252

  @JurorTransformationMulti @NewSchemaConverted
  Scenario Outline: JM-4252 - The system shall stop Bureau officer from editing a juror when it has transferred to the court

    Given I am on "Bureau" "postgres"

    And I log in as "<user>"

    Given a bureau owned pool is created with jurors
      | court | juror_number  	    | pool_number	    | att_date_weeks_in_future	| owner |
      | 415   | <juror_number> 	    | <pool_number>     | 1				            | 400	|

    Then a new pool is inserted for where record has transferred to the court new schema
      |part_no   	  | pool_no   	  | owner |
      |<juror_number> | <pool_number> | 415   |

    When the user searches for juror record "<juror_number>" from the global search bar

    And I click on the "Juror details" link
    And I do not see "Add or change" on the page

    Examples:
      | juror_number| pool_number | user          |
      | 041500124   | 415300224	  | MODTESTBUREAU |