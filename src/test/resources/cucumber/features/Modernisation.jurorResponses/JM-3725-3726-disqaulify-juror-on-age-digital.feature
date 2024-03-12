Feature: JM-3725 JM-3726

  @JurorTransformationWIP @JurorDigitalNotConverted
  Scenario Outline: test to disqualify juror - too old - digital

    #this test will fail until juror digital app is converted over to new schema

    Given I am on "Public" "test"

    Given the juror numbers have not been processed new schema
      |part_no   | pool_no   | owner |
      |<part_no> | <pool_no> | 400   |




    And I record a digital response for a juror that is too old
      |jurorNumber   | <part_no>   |
      |jurorLname    | <l_name>    |
      |jurorPostcode | <zip>       |

    Given I am on "Bureau" "test"

    Given I log in as "MODTESTBUREAU"

    When the user searches for juror record "<juror_number>" from the global search bar
    Then I see the juror status on the juror record screen is "Disqualified"
    And I click the summons reply tab
    And I click on the "View summons reply" link
    And I see the reply "type" on the response is "AUTO PROCESSED"
    And I see the juror status has updated to "Disqualified"
    And I see the reply "status" on the response is "COMPLETED"

    Examples:
      |part_no	|l_name	               |zip	     |pool_no	|
      |641500840|L'NAMEEIGHTFOUR-ZERO  |CH1 2AN  |415170402 |

  @JurorTransformationWIP @JurorDigitalNotConverted
  Scenario Outline: test to disqualify juror - too young - digital

    #this test will fail until juror digital app is converted over to new schema

    Given I am on "Public" "test"

    Given the juror numbers have not been processed new schema
      |part_no   | pool_no   | owner |
      |<part_no> | <pool_no> | 400   |




    And I record a digital response for a juror that is too young
      |jurorNumber   | <part_no>   |
      |jurorLname    | <l_name>    |
      |jurorPostcode | <zip>       |

    Given I am on "Bureau" "test"

    Given I log in as "MODTESTBUREAU"

    When the user searches for juror record "<juror_number>" from the global search bar
    Then I see the juror status on the juror record screen is "Disqualified"
    And I click the summons reply tab
    And I click on the "View summons reply" link
    And I see the reply "type" on the response is "AUTO PROCESSED"
    And I see the juror status has updated to "Disqualified"
    And I see the reply "status" on the response is "COMPLETED"

    Examples:
      |part_no	|l_name	              |zip	   |pool_no	 |
      |641500834|LNAMEEIGHTTHREEFOUR  |CH1 2AN |415170402|

  @JurorTransformationWIP @JurorDigitalNotConverted
  Scenario Outline: test to disqualify juror - incorrect date provided - change date - digital

    #this test will fail until juror digital app is converted over to new schema

    Given I am on "Public" "test"

    Given the juror numbers have not been processed new schema
      |part_no   | pool_no   | owner |
      |<part_no> | <pool_no> | 400   |




    And I record a digital response for a juror that provides an incorrect DoB and corrects it
      |jurorNumber   | <part_no>|
      |jurorLname    | <l_name> |
      |jurorPostcode | <zip>    |

    Given I am on "Bureau" "test"

    Given I log in as "MODTESTBUREAU"

    When the user searches for juror record "<juror_number>" from the global search bar
    Then I see the juror status on the juror record screen is "Responded"
    And I click the summons reply tab
    And I click on the "View summons reply" link
    And I see the reply "type" on the response is "AUTO PROCESSED"
    And I see the juror status has updated to "Responded"
    And I see the reply "status" on the response is "COMPLETED"

    Examples:
      |part_no	|l_name	       |zip	     |pool_no   |
      |641500064|LNAMESIXFOUR  |CH1 2AN  |415170402 |