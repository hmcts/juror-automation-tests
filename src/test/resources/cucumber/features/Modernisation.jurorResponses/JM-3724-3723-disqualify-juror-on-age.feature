Feature: JM-3724 JM-3723

  @JurorTransformation @NewSchemaConverted
  Scenario Outline: test to disqualify juror - too old
    Given I am on "Bureau" "test"

    And I log in as "<user>"

    Given the juror numbers have not been processed new schema
      |part_no   | pool_no   | owner |
      |<part_no> | <pool_no> | 400   |


    And "<juror_number>" has "NEXT_DATE" as "7 mondays time" new schema

    When the user searches for juror record "<juror_number>" from the global search bar
    And I click the Enter summons reply button
    Then the juror details form is displayed
    And I enter a date of birth in the summons reply that will make the juror too old
    And I click continue on the juror summons reply page
    And I see "Check the date of birth" on the page
    And I am asked if the date of birth is correct
    Then I click yes to disqualify the juror
    And I see "successfully processed: Disqualified (age)" on the page

    Examples:
      | user          | part_no   | pool_no   |
      | MODTESTBUREAU | 641500820 | 415170501 |


  @JurorTransformationMulti @NewSchemaConverted
  Scenario Outline: test to disqualify juror - too young
    Given I am on "Bureau" "test"

    And I log in as "<user>"

    Given the juror numbers have not been processed new schema
      |part_no   | pool_no   | owner |
      |<part_no> | <pool_no> | 400   |


    And "<juror_number>" has "NEXT_DATE" as "7 mondays time" new schema

    When the user searches for juror record "<juror_number>" from the global search bar
    And I click the Enter summons reply button
    Then the juror details form is displayed
    And I enter a date of birth in the summons reply that will make the juror too young
    And I click continue on the juror summons reply page
    And I see "Check the date of birth" on the page
    And I am asked if the date of birth is correct
    And I click yes to disqualify the juror
    And I see "successfully processed: Disqualified (age)" on the page

    Examples:
      | user          | part_no   | pool_no   |
      | MODTESTBUREAU | 641500826 | 415170501 |


  @JurorTransformationMulti @NewSchemaConverted
  Scenario Outline: test to disqualify juror - incorrect date provided - change date
    Given I am on "Bureau" "test"

    And I log in as "<user>"

    Given the juror numbers have not been processed new schema
      |part_no   | pool_no   | owner |
      |<part_no> | <pool_no> | 400   |


    And "<juror_number>" has "NEXT_DATE" as "7 mondays time" new schema

    When the user searches for juror record "<juror_number>" from the global search bar
    And I click the Enter summons reply button
    Then the juror details form is displayed
    And I enter a date of birth in the summons reply that will make the juror too old
    And I click continue on the juror summons reply page
    And I see "Check the date of birth" on the page
    And I am asked if the date of birth is correct
    Then I click no to change the date of birth to the correct date
    Then the juror details form is displayed
    And I enter a date of birth that will make the juror between 18 and 75
    And I click continue on the juror summons reply page
    And I do not see "Check the date of birth" on the page

    Examples:
      | user          | part_no   | pool_no   |
      | MODTESTBUREAU | 641500828 | 415170501 |
