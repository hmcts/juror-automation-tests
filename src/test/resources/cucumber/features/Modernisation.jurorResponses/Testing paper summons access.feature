Feature: JM-4079 Testing paper summons access

  @JurorTransformation @NewSchemaConverted
  Scenario Outline: Test to manually enter paper summons as COURT user when record belongs to COURT

    Given I am on "Bureau" "test"

    Given the juror numbers have not been processed new schema
      |part_no   | pool_no   | owner |
      |<part_no> | <pool_no> | 400   |

    And "<part_no>" has "NEXT_DATE" as "-2 mondays time" new schema
    And pool "<pool_no>" has attendance date as "-2 mondays time" new schema

    Given a new pool is inserted for where record has transferred to the court new schema
      |part_no   | pool_no   | owner |
      |<part_no> | <pool_no> | 415   |

    And I log in as "MODTESTCOURT"

    #navigate to juror record
    When the user searches for juror record "<part_no>" from the global search bar

    #record happy path paper summons
    And I record a happy path paper summons response

    #skip straight through processing
    Then I see "Do you want to process this summons reply as responded now?" on the page
    Then I see "The juror’s answers mean this is a straight-through reply. So you can process it as responded now, or return later." on the page
    When I click on the "No, skip and process later" link

    #validate results
    And I see the reply "status" on the response is "TO DO"
    And I see the reply "type" on the response is "NEEDS REVIEW"
    And I see "Juror’s service start date has passed - process as a priority." in the response banner
    And I see Reply Method is "Paper"
    And I see the process reply button

    Examples:
      |part_no	|pool_no	|
      |641500919|415170402	|

  @JurorTransformationMulti @NewSchemaConverted
  Scenario Outline: Test that you cant enter paper summons as BUREAU user when record belongs to COURT

    Given I am on "Bureau" "test"
    Given the juror numbers have not been processed new schema
      |part_no   | pool_no   | owner |
      |<part_no> | <pool_no> | 400   |


    And "<part_no>" has "NEXT_DATE" as "2 mondays time" new schema

    Given a new pool is inserted for where record has transferred to the court new schema
      |part_no   | pool_no   | owner |
      |<part_no> | <pool_no> | 415   |

    And I log in as "MODTESTBUREAU"

    #navigate to juror record
    When the user searches for juror record "<part_no>" from the global search bar

    #record summons button not available
    Then the Enter summons reply button is not visible

    Examples:
      |part_no	|pool_no	|
      |641500946|415170402	|
