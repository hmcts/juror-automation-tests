Feature: JM-666

  @JurorTransformationMulti @NewSchemaConverted
  Scenario Outline: Test to search for crown court pool by pool number
    Given I am on "Bureau" "test"

    Given the juror numbers have not been processed new schema
      |part_no   | pool_no   | owner |
      |<part_no> | <pool_no> | 400   |

    And I log in as "MODTESTCOURT"

    And a new pool is inserted which is owned by the court and includes a deferred juror new schema
      |owner   | pool_no   | part_no    | no_weeks   |
      |<court> | <pool_no> | <part_no>  | <no_weeks> |

    And I navigate to the pool search screen
    When I enter the pool number "<pool_no>" on the pool search screen
    And I search for the pool
    Then the pool is displayed

    Examples:
      |part_no	|pool_no	|court|no_weeks|
      |241599991|415999991	|415  |10      |

  @JurorTransformationMulti @NewSchemaConverted
  Scenario Outline: Test to search for pool by pool number with matching location code
    Given I am on "Bureau" "test"

    Given the juror numbers have not been processed new schema
      |part_no   | pool_no   | owner |
      |<part_no> | <pool_no> | 400   |

    And I log in as "MODTESTCOURT"

    And a new pool is inserted which is owned by the court and includes a deferred juror new schema
      |owner   | pool_no   | part_no    | no_weeks   |
      |<court> | <pool_no> | <part_no>  | <no_weeks> |

    And I navigate to the pool search screen
    When I enter the pool number "<pool_no>" on the pool search screen
    And I enter a location code of "<court>" for the pool search
    And I search for the pool
    Then the pool is displayed

    Examples:
      |part_no	|pool_no	|court|no_weeks|
      |241599992|415999992	|415  |10      |

  @JurorTransformation @NewSchemaConverted
  Scenario: Test to search for pool by pool number with matching pool status
    Given I am on "Bureau" "test"
    Given the new pool for court "415" is deleted new schema
    And I log in as "MODTESTCOURT"
    And a new completed pool is inserted for court "415" new schema
    And I navigate to the pool search screen
    When I enter the pool number "415111111" on the pool search screen
    And I expand the pool search advanced search criteria
    And I select the Completed option in the advanced pool search section
    And I search for the pool
    Then the pool is displayed

    Given the new pool for court "415" is deleted new schema

  @JurorTransformationMulti @NewSchemaConverted
  Scenario Outline: Test to search for pool by pool number with matching pool stage
    Given I am on "Bureau" "test"

    Given the juror numbers have not been processed new schema
      |part_no   | pool_no   | owner |
      |<part_no> | <pool_no> | 400   |

    And I log in as "MODTESTCOURT"

    And a new pool is inserted which is owned by the court and includes a deferred juror new schema
      |owner   | pool_no   | part_no    | no_weeks   |
      |<court> | <pool_no> | <part_no>  | <no_weeks> |

    And I navigate to the pool search screen
    When I enter the pool number "<pool_no>" on the pool search screen
    And I expand the pool search advanced search criteria
    And I select the At Court option in the advanced pool search section
    And I search for the pool
    Then the pool is displayed

    Examples:
      |part_no	|pool_no	|court|no_weeks|
      |641500600|415171109	|415  |10      |

  @JurorTransformationMulti @NewSchemaConverted
  Scenario Outline: Test to search for a pool by pool number with matching pool type - Crown Court
    Given I am on "Bureau" "test"

    Given the juror numbers have not been processed new schema
      |part_no   | pool_no   | owner |
      |<part_no> | <pool_no> | 400   |

    And I log in as "MODTESTCOURT"

    And a new pool is inserted which is owned by the court and includes a deferred juror new schema
      |owner   | pool_no   | part_no    | no_weeks   |
      |<court> | <pool_no> | <part_no>  | <no_weeks> |

    And I navigate to the pool search screen
    When I enter the pool number "<pool_no>" on the pool search screen
    And I expand the pool search advanced search criteria
    And I select the Crown Court option in the advanced pool search section
    And I search for the pool
    Then the pool is displayed

    Examples:
      |part_no	|pool_no	|court|no_weeks|
      |241599994|415999994	|415  |10      |

  @JurorTransformation @NewSchemaConverted
  Scenario: Creating a pool and searching for it using pool number and advanced search - Civil Court
    Given I am on "Bureau" "test"

    And I log in as "MODTESTBUREAU"

    #delete pool
    Given the new pool for court "415" is deleted new schema

    #Can see the pool request courts table tabs and fields
    When I navigate to the pool request screen

    When I press the "Create pool" button
    And I set the radio button to "Request new pool"
    And I press the "Continue" button
    Then I see "Select a court for this pool" on the page

    #select court
    Then I set input field with "ID" of "courtNameOrLocation" to "CHESTER"
    Then I click on the "Chester (415)" link
    Then I press the "Continue" button

    #complete new pool fields
    Then I set the radio button to "Civil"
    And I set "Number of jurors required in total" to "150"
    Then I press the "Continue" button

    #check pool number
    And I see the pool number of the pool

    #Request Pool
    And I submit the pool request

    #Search for Pool
    And I navigate to the pool search screen
    When I enter the pool number of the pool I have just created on the pool search screen
    And I expand the pool search advanced search criteria
    And I select the Civil Court option in the advanced pool search section
    And I search for the pool
    Then the pool is displayed

    Given the new pool for court "415" is deleted

  @JurorTransformationMulti @NewSchemaConverted
  Scenario Outline: Test to search for pool by pool number with non matching date
    Given I am on "Bureau" "test"

    Given the juror numbers have not been processed new schema
      |part_no   | pool_no   | owner |
      |<part_no> | <pool_no> | 400   |

    And I log in as "MODTESTCOURT"

    And a new pool is inserted which is owned by the court and includes a deferred juror new schema
      |owner   | pool_no   | part_no    | no_weeks   |
      |<court> | <pool_no> | <part_no>  | <no_weeks> |

    And I navigate to the pool search screen
    When I enter the pool number "<pool_no>" on the pool search screen
    And I set input field with "id" of "serviceStartDate" to "25/10/2022"
    And I search for the pool
    Then I see "There are no matching results" on the page

    Examples:
      |part_no	|pool_no	|court|no_weeks|
      |241599995|415999995	|415  |10      |

  @JurorTransformationMulti @NewSchemaConverted
  Scenario Outline: Test to search for pool by pool number with non matching location code
    Given I am on "Bureau" "test"

    Given the juror numbers have not been processed new schema
      |part_no   | pool_no   | owner |
      |<part_no> | <pool_no> | 400   |

    And I log in as "MODTESTCOURT"

    And a new pool is inserted which is owned by the court and includes a deferred juror new schema
      |owner   | pool_no   | part_no    | no_weeks   |
      |<court> | <pool_no> | <part_no>  | <no_weeks> |

    And I navigate to the pool search screen
    When I enter the pool number "<pool_no>" on the pool search screen
    And I enter a location code of "416" for the pool search
    And I search for the pool
    Then I see "There are no matching results" on the page

    Examples:
      |part_no	|pool_no	|court|no_weeks|
      |241599996|415999996	|415  |10      |

  @JurorTransformationMulti @NewSchemaConverted
  Scenario Outline: Test to search for pool by pool number with non matching pool status
    Given I am on "Bureau" "test"

    Given the juror numbers have not been processed new schema
      |part_no   | pool_no   | owner |
      |<part_no> | <pool_no> | 400   |

    And I log in as "MODTESTCOURT"

    And a new pool is inserted which is owned by the court and includes a deferred juror new schema
      |owner   | pool_no   | part_no    | no_weeks   |
      |<court> | <pool_no> | <part_no>  | <no_weeks> |

    And I navigate to the pool search screen
    When I enter the pool number "<pool_no>" on the pool search screen
    And I expand the pool search advanced search criteria
    And I select the Requested option in the advanced pool search section
    And I search for the pool
    Then I see "There are no matching results" on the page

    Examples:
      |part_no	|pool_no	|court|no_weeks|
      |241599997|415999997	|415  |10      |

  @JurorTransformationMulti @NewSchemaConverted
  Scenario Outline: Test to search for pool by pool number with non matching pool stage
    Given I am on "Bureau" "test"

    Given the juror numbers have not been processed new schema
      |part_no   | pool_no   | owner |
      |<part_no> | <pool_no> | 400   |

    And I log in as "MODTESTCOURT"

    And a new pool is inserted which is owned by the court and includes a deferred juror new schema
      |owner   | pool_no   | part_no    | no_weeks   |
      |<court> | <pool_no> | <part_no>  | <no_weeks> |

    And I navigate to the pool search screen
    When I enter the pool number "<pool_no>" on the pool search screen
    And I expand the pool search advanced search criteria
    And I select the With the Bureau option in the advanced pool search section
    And I search for the pool
    Then I see "There are no matching results" on the page

    Examples:
      |part_no	|pool_no	|court|no_weeks|
      |241599998|415999998	|415  |10      |

  @JurorTransformationMulti @NewSchemaConverted
  Scenario Outline: Test to search for pool by pool number with non matching pool type
    Given I am on "Bureau" "test"

    Given the juror numbers have not been processed new schema
      |part_no   | pool_no   | owner |
      |<part_no> | <pool_no> | 400   |

    And I log in as "MODTESTCOURT"

    And a new pool is inserted which is owned by the court and includes a deferred juror new schema
      |owner   | pool_no   | part_no    | no_weeks   |
      |<court> | <pool_no> | <part_no>  | <no_weeks> |

    And I navigate to the pool search screen
    When I enter the pool number "<pool_no>" on the pool search screen
    And I expand the pool search advanced search criteria
    And I select the High Court option in the advanced pool search section
    And I search for the pool
    Then I see "There are no matching results" on the page

    Examples:
      |part_no	|pool_no	|court|no_weeks|
      |241599998|415999998	|415  |10      |

  @JurorTransformationMulti @NewSchemaConverted
  Scenario Outline: Test to check previous advanced search criteria is retained
    Given I am on "Bureau" "test"

    Given the juror numbers have not been processed new schema
      |part_no   | pool_no   | owner |
      | <part_no>   | <pool_no>   | 400   |
      | <part_no_2> | <pool_no_2> | 400   |

    And I log in as "MODTESTCOURT"

    And a new pool is inserted which is owned by the court and includes a deferred juror new schema
      |owner   | pool_no   | part_no    | no_weeks   |
      | <court> | <pool_no>   | <part_no>   | <no_weeks> |
      | <court> | <pool_no_2> | <part_no_2> | <no_weeks> |

    And I navigate to the pool search screen
    When I enter a location code of "<court>" for the pool search
    And I expand the pool search advanced search criteria
    And I select all the tick boxes in the advanced search section
    And I search for the pool
    Then the pool search results are found
    And I expand the pool search advanced search criteria
    And all the tick boxes in the advanced search section are still selected

    Examples:
      | part_no   | pool_no   | part_no_2 | pool_no_2 | court | no_weeks |
      | 241599909 | 415999909 | 641500407 | 415170601 | 415   | 10       |