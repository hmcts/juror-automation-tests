Feature: JM-4252

  @JurorTransformationMulti @NewSchemaConverted
  Scenario Outline: JM-4252 - The system shall stop Bureau officer from editing a juror when it has transferred to the court

    Given I am on "Bureau" "postgres"

    And I log in as "<user>"

    Given the juror numbers have not been processed new schema
      |part_no   | pool_no   | owner |
      |<part_no> | <pool_no> | 400   |


    And "<juror_number>" has "NEXT_DATE" as "1 mondays time" new schema

    Then a new pool is inserted for where record has transferred to the court new schema
      |part_no   | pool_no   | owner |
      |<part_no> | <pool_no> | 415   |

    When the user searches for juror record "<juror_number>" from the global search bar

    And I click on the "Juror details" link
    And I do not see "Add or change" on the page


    Examples:
      |part_no	|pool_no	| user          |
      |541500827|415240404	| MODTESTBUREAU |
