Feature: JM-4180 DB values reflected on UI

  @JurorTransformationMulti @NewSchemaConverted
  Scenario Outline: Test to check UI is correct when Police Check passes
    Given I am on "Bureau" "test"
    Given the juror numbers have not been processed new schema
      | part_no  | pool_no  | owner |
      | <part_no> |<pool_no> | 400  |

    And juror "<part_no>" has "LAST_NAME" as "<last_name>" new schema

    And "<part_no>" has "NEXT_DATE" as "5 mondays time" new schema
    And juror "<part_no>" has "POSTCODE" as "<postcode>" new schema

    And I log in as "MODTESTBUREAU"
    When I set Police Check to "ELIGIBLE" for "<part_no>" new schema
    And the user searches for the juror record from the global search bar
    Then I see "<part_no>" on the page
    And I see police check has updated to "Passed"
    Examples:
      | part_no | pool_no | last_name | postcode |
      |641500899|415170402| LNAME     |ML10 6AD  |


  @JurorTransformationMulti @NewSchemaConverted
  Scenario Outline: Test to check UI is correct when Police Check passes but Phoenix check fails
    Given I am on "Bureau" "test"
    Given the juror numbers have not been processed new schema
      | part_no  | pool_no  | owner |
      | <part_no> |<pool_no> | 400  |

    And juror "<part_no>" has "LAST_NAME" as "<last_name>" new schema

    And "<part_no>" has "NEXT_DATE" as "5 mondays time" new schema
    And juror "<part_no>" has "POSTCODE" as "<postcode>" new schema

    And I log in as "MODTESTBUREAU"
    When I set Police Check to "INSUFFICIENT_INFORMATION" for "<part_no>" new schema
    And the user searches for the juror record from the global search bar
    Then I see "<part_no>" on the page
    And I see police check has updated to "Not checked"

    Examples:
      | part_no | pool_no | last_name | postcode |
      |641500902|415170402| Lname     |ML10 6AD  |

  @JurorTransformationWIP @JM-5790
  Scenario Outline: Test to check UI is correct when Police Check fails
    Given I am on "Bureau" "test"
    Given the juror numbers have not been processed new schema
      | part_no   | pool_no   | owner |
      | <part_no> | <pool_no> | 400   |

    And juror "<part_no>" has "LAST_NAME" as "<last_name>" new schema

    And "<part_no>" has "NEXT_DATE" as "5 mondays time" new schema
    And juror "<part_no>" has "POSTCODE" as "<postcode>" new schema

    And I log in as "MODTESTBUREAU"
#    When I set Police Check to "F" and Phoenix Checked to "C" for "<part_no>"
    When I set Police Check to "F" for "<part_no>" new schema
    And the user searches for the juror record from the global search bar
    Then I see "<part_no>" on the page
    And I see police check has updated to "Failed"
    Examples:
      | part_no   | pool_no   | last_name | postcode |
      | 641500905 | 415170402 | Lname     | ML10 6AD |

  @JurorTransformationMulti @NewSchemaConverted
  Scenario Outline: Test to check UI is correct when Police Check is in progress
    Given I am on "Bureau" "test"

    Given a bureau owned pool is created with jurors
      | court | juror_number    | pool_number  | att_date_weeks_in_future	| owner |
      | 415	  | <juror_number>  | <pool_number>| 5				            | 400	|

    And I log in as "MODTESTBUREAU"
#    When I set Police Check to "E" and Phoenix Checked to "" for "<part_no>"
    When I set Police Check to "IN_PROGRESS" for "<juror_number>" new schema
    And the user searches for the juror record from the global search bar
    Then I see "<juror_number>" on the page
    And I see police check has updated to "In progress"
    Examples:
      | juror_number  | pool_number |
      | 041500043     | 415300133   |

  @JurorTransformationMulti
  Scenario Outline: Test to check UI is correct when Police Check hasn't been done
    Given I am on "Bureau" "test"
    Given the juror numbers have not been processed new schema
      | part_no   | pool_no   | owner |
      | <part_no> | <pool_no> | 400   |

    And juror "<part_no>" has "LAST_NAME" as "<last_name>" new schema

    And "<part_no>" has "NEXT_DATE" as "5 mondays time" new schema
    And juror "<part_no>" has "POSTCODE" as "<postcode>" new schema

    And I log in as "MODTESTBUREAU"
#    When I set Police Check to "" and Phoenix Checked to "" for "<part_no>"
    When I set Police Check to "" for "<part_no>" new schema
    And the user searches for the juror record from the global search bar
    Then I see "<part_no>" on the page
    And I see police check has updated to "Not checked"
    Examples:
      | part_no   | pool_no   | last_name | postcode |
      | 641500168 | 415170402 | Lname     | ML10 6AD |
