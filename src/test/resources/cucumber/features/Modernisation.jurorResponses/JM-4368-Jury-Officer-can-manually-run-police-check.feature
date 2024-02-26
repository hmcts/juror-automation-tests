Feature: JM-4368 Jury Officer Can Manually Run a Police Check

  @JurorTransformationMulti
  Scenario Outline: Manually run police check - presence of link - not checked

    Given I am on "Bureau" "test"

    Given I log in as "MODTESTCOURT"

    Given the juror numbers have not been processed new schema
      |part_no   | pool_no   | owner |
      |<part_no> | <pool_no> | 400   |


    And "<part_no>" has "NEXT_DATE" as "5 mondays time" new schema

    Then a new pool is inserted for where record has transferred to the court new schema
      |part_no   | pool_no   | owner |
      |<part_no> | <pool_no> | 415   |

    And I search for juror "<part_no>"
    And I see the police check value is "Not checked"
    And I see the link to run a police check
    When I click the link to run a police check
    And I see "Run a police check on this juror" on the page
    And I see the button to run a police check

    Examples:
      | part_no		| pool_no	|
      |641500364	|415170402	|

  @JurorTransformationMulti
  Scenario Outline: Manually run police check - presence of link - there was a problem

    Given I am on "Bureau" "test"

    Given I log in as "MODTESTCOURT"

    Given the juror numbers have not been processed new schema
      |part_no   | pool_no   | owner |
      |<part_no> | <pool_no> | 400   |


    And "<part_no>" has "NEXT_DATE" as "5 mondays time" new schema

    Then a new pool is inserted for where record has transferred to the court new schema
      |part_no   | pool_no   | owner |
      |<part_no> | <pool_no> | 415   |

#    Given I set Police Check to "P" and Phoenix Checked to "U" for "<part_no>"
    Given I set Police Check to "<police_check_value>" for "<part_no>" new schema
    And I search for juror "<part_no>"
    And I see the police check value is "<police_check_status>"
    And I do not see the link to run a police check

    Examples:
      | part_no   | pool_no   | police_check_value               | police_check_status                |
      | 641500381 | 415170402 | UNCHECKED_MAX_RETRIES_EXCEEDED   | Not checked - there was a problem. |
      | 641500381 | 415170402 | ERROR_RETRY_OTHER_ERROR_CODE     | In progress                        |
      | 641500381 | 415170402 | ERROR_RETRY_UNEXPECTED_EXCEPTION | In progress                        |

  @JurorTransformationMulti
  Scenario Outline: Manually run police check - presence of link - failed
    Given I am on "Bureau" "test"
    Given I log in as "MODTESTCOURT"

    Given the juror numbers have not been processed new schema
      | part_no   | pool_no   | owner |
      | <part_no> | <pool_no> | 400   |


    And "<part_no>" has "NEXT_DATE" as "5 mondays time" new schema

    Then a new pool is inserted for where record has transferred to the court new schema
      |part_no   | pool_no   | owner |
      |<part_no> | <pool_no> | 415   |

#    Given I set Police Check to "F" and Phoenix Checked to "C" for "<part_no>"
    Given I set Police Check to "INELIGIBLE" for "<part_no>" new schema
    And I search for juror "<part_no>"
    And I see the police check value is "Failed"
    And I do not see the link to run a police check

    Examples:
      | part_no		| pool_no	|
      |641500390	|415170402	|

  @JurorTransformationMulti
  Scenario Outline: Manually run police check - presence of link - passed

    Given I am on "Bureau" "test"

    Given I log in as "MODTESTCOURT"

    Given the juror numbers have not been processed new schema
      |part_no   | pool_no   | owner |
      |<part_no> | <pool_no> | 400   |


    And "<part_no>" has "NEXT_DATE" as "5 mondays time" new schema

    Then a new pool is inserted for where record has transferred to the court new schema
      |part_no   | pool_no   | owner |
      |<part_no> | <pool_no> | 415   |

#    Given I set Police Check to "P" and Phoenix Checked to "C" for "<part_no>"
    Given I set Police Check to "ELIGIBLE" for "<part_no>" new schema
    And I search for juror "<part_no>"
    And I see the police check value is "Passed"
    And I do not see the link to run a police check

    Examples:
      | part_no		| pool_no	|
      |641500402	|415170402	|

  @JurorTransformationWIP @Not_Implemented_In_Backend
  Scenario Outline: Manually run police check - police check runs NOT IMPLEMENTED IN BACKEND
    Given I am on "Bureau" "test"

    Given the juror numbers have not been processed new schema
      |part_no   | pool_no   | owner |
      |<part_no> | <pool_no> | 400   |


    And "<part_no>" has "NEXT_DATE" as "5 mondays time" new schema

    Then a new pool is inserted for where record has transferred to the court new schema
      | part_no   | pool_no   | owner |
      | <part_no> | <pool_no> | 415   |

    Given I log in as "MODTESTCOURT"

    Given I set Police Check to "NOT_CHECKED" for "<part_no>" new schema
    And I search for juror "<part_no>"
    And I record a happy path paper summons response and process now
    And I search for juror "<part_no>"
    And I see the police check value is "Not checked"
    And I see the link to run a police check
    When I click the link to run a police check
    And I see "Run a police check on this juror" on the page
#  NOT IMPLEMENTED IN BACKEND
    And I see the button to run a police check
    And I click the button to run a police check
    And I see the police check value is not "Not checked"

    Examples:
      | part_no   | pool_no   |
      |641500405	|415170402	|
