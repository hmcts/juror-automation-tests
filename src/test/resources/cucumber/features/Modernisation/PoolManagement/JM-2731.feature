Feature: JM-2731

  @JurorTransformationMulti
  Scenario Outline: Test to search pool records as bureau

    Given I am on "Bureau" "demo"

    Given a bureau owned pool is created with jurors
      | court |juror_number  	| pool_number	| att_date_weeks_in_future	| owner |
      | 415   |<juror_number> 	| <pool_number> | 5				            | 400	|

    Then a new pool is inserted for where record has transferred to the court new schema
      | part_no        | pool_no       | owner |
      | <juror_number> | <pool_number> | 415   |

    And I log in as "<user>"

    When the user searches for juror record "<juror_number>" from the global search bar
    Then the juror record is displayed with the following fields new schema
      | Juror number     | <juror_number>                |
      | Juror status     | Summoned                      |
      | Pool number      | <pool_number>                 |
      | Court start date |                               |
      | Court name       | The Crown Court At Chester    |

    Examples:
      | user          | juror_number | pool_number |
      | MODTESTBUREAU | 011000002    | 010000002   |


  @JurorTransformationMulti
  Scenario Outline: Test to search pool records as court

    Given I am on "Bureau" "demo"

    Given a bureau owned pool is created with jurors
      | court | juror_number  	| pool_number	| att_date_weeks_in_future	| owner |
      | 415   | <juror_number> 	| <pool_number> | 5				            | 400	|

    Then a new pool is inserted for where record has transferred to the court new schema
      | part_no        | pool_no       | owner |
      | <juror_number> | <pool_number> | 415   |

    And I log in as "<user>"

    When the user searches for juror record "<juror_number>" from the global search bar
    Then the juror record is displayed with the following fields new schema
      | Juror number     | <juror_number>                |
      | Juror status     | Summoned                      |
      | Pool number      | <pool_number>                 |
      | Court start date |                               |
      | Court name       | The Crown Court At Chester    |

    Examples:
      | user          | juror_number  | pool_number  |
      | MODTESTBUREAU | 011000003     | 010000003    |


  @JurorTransformation
  Scenario: Test to search non-existent pool record as bureau

    Given I am on "Bureau" "demo"

    And I log in as "MODTESTBUREAU"
    When the user enters an incorrect juror record number
    Then an error message is displayed explaining that there are no matching results

  @JurorTransformation
  Scenario: Test to search non-existent pool record as court

    Given I am on "Bureau" "demo"

    And I log in as "MODTESTCOURT"
    When the user enters an incorrect juror record number
    Then an error message is displayed explaining that there are no matching results