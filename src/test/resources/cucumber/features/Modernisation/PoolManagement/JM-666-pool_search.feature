Feature: JM-666

  @JurorTransformationMulti @NewSchemaConverted
  Scenario Outline: Test to search for crown court pool by pool number
    Given I am on "Bureau" "test"

    Given a bureau owned pool is created with jurors
      | court | juror_number      | pool_number	    | att_date_weeks_in_future	| owner |
      | 415   | <juror_number>    | <pool_number>   | 5				            | 400	|

    And I log in as "MODTESTCOURT"

    And a new pool is inserted which is owned by the court and includes a deferred juror new schema
      | owner   | pool_no       | part_no         | no_weeks   |
      | 415     | <pool_number> | <juror_number>  | <no_weeks> |

    And I navigate to the pool search screen
    When I enter the pool number "<pool_number>" on the pool search screen
    And I search for the pool
    Then the pool is displayed

    Examples:
      | juror_number  | pool_number	| no_weeks|
      | 041500067     | 415300157	| 5      |

  @JurorTransformationMulti @NewSchemaConverted
  Scenario Outline: Test to search for pool by pool number with matching location code
    Given I am on "Bureau" "test"

    Given a bureau owned pool is created with jurors
      | court | juror_number      | pool_number	    | att_date_weeks_in_future	| owner |
      | 415   | <juror_number>    | <pool_number>   | 5				            | 400	|

    And I log in as "MODTESTCOURT"

    And a new pool is inserted which is owned by the court and includes a deferred juror new schema
      | owner | pool_no       | part_no         | no_weeks   |
      | 415   | <pool_number> | <juror_number>  | <no_weeks> |

    And I navigate to the pool search screen
    When I enter the pool number "<pool_number>" on the pool search screen
    And I enter a location code of "415" for the pool search
    And I search for the pool
    Then the pool is displayed

    Examples:
      | juror_number| pool_number | no_weeks|
      | 041500068   | 415300158	  |10       |

  @JurorTransformation @NewSchemaConverted
  Scenario: Test to search for pool by pool number with matching pool status
    Given I am on "Bureau" "test"
    Given the new pool for court "415" is deleted new schema
    And I log in as "MODTESTBUREAU"
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

    Given a bureau owned pool is created with jurors
      | court | juror_number      | pool_number	    | att_date_weeks_in_future	| owner |
      | 415   | <juror_number>    | <pool_number>   | 5				            | 400	|

    And I log in as "MODTESTCOURT"

    And a new pool is inserted which is owned by the court and includes a deferred juror new schema
      | owner | pool_no       | part_no         | no_weeks   |
      | 415   | <pool_number> | <juror_number>  | <no_weeks> |

    And I navigate to the pool search screen
    When I enter the pool number "<pool_number>" on the pool search screen
    And I expand the pool search advanced search criteria
    And I select the At Court option in the advanced pool search section
    And I search for the pool
    Then the pool is displayed

    Examples:
      | juror_number  | pool_number	| no_weeks|
      | 041500069     | 415300159	| 10      |

  @JurorTransformationMulti @NewSchemaConverted
  Scenario Outline: Test to search for a pool by pool number with matching pool type - Crown Court
    Given I am on "Bureau" "test"

    Given a bureau owned pool is created with jurors
      | court | juror_number      | pool_number	    | att_date_weeks_in_future	| owner |
      | 415   | <juror_number>    | <pool_number>   | 5				            | 400	|

    And I log in as "MODTESTCOURT"

    And a new pool is inserted which is owned by the court and includes a deferred juror new schema
      | owner | pool_no       | part_no         | no_weeks   |
      | 415   | <pool_number> | <juror_number>  | <no_weeks> |

    And I navigate to the pool search screen
    When I enter the pool number "<pool_number>" on the pool search screen
    And I expand the pool search advanced search criteria
    And I select the Crown Court option in the advanced pool search section
    And I search for the pool
    Then the pool is displayed

    Examples:
      | juror_number  | pool_number	| no_weeks|
      | 041500070     | 415300160	| 10      |

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

    Given a bureau owned pool is created with jurors
      | court | juror_number      | pool_number	    | att_date_weeks_in_future	| owner |
      | 415   | <juror_number>    | <pool_number>   | 5				            | 400	|

    And I log in as "MODTESTCOURT"

    And a new pool is inserted which is owned by the court and includes a deferred juror new schema
      | owner | pool_no       | part_no         | no_weeks   |
      | 415   | <pool_number> | <juror_number>  | <no_weeks> |

    And I navigate to the pool search screen
    When I enter the pool number "<pool_number>" on the pool search screen
    And I set input field with "id" of "serviceStartDate" to "25/10/2022"
    And I search for the pool
    Then I see "There are no matching results" on the page

    Examples:
      | juror_number  | pool_number | no_weeks|
      | 041500071     | 415300161	| 10      |

  @JurorTransformationMulti @NewSchemaConverted
  Scenario Outline: Test to search for pool by pool number with non matching location code
    Given I am on "Bureau" "test"

    Given a bureau owned pool is created with jurors
      | court | juror_number      | pool_number	    | att_date_weeks_in_future	| owner |
      | 415   | <juror_number>    | <pool_number>   | 5				            | 400	|

    And I log in as "MODTESTCOURT"

    And a new pool is inserted which is owned by the court and includes a deferred juror new schema
      | owner | pool_no       | part_no         | no_weeks   |
      | 415   | <pool_number> | <juror_number>  | <no_weeks> |

    And I navigate to the pool search screen
    When I enter the pool number "<pool_number>" on the pool search screen
    And I enter a location code of "767" for the pool search
    And I search for the pool
    Then I see "There are no matching results" on the page

    Examples:
      | juror_number  | pool_number	| no_weeks|
      | 041500072     | 415300162	| 10      |

  @JurorTransformationMulti @NewSchemaConverted
  Scenario Outline: Test to search for pool by pool number with non matching pool status
    Given I am on "Bureau" "test"

    Given a bureau owned pool is created with jurors
      | court | juror_number      | pool_number	    | att_date_weeks_in_future	| owner |
      | 415   | <juror_number>    | <pool_number>   | 5				            | 400	|

    And I log in as "MODTESTCOURT"

    And a new pool is inserted which is owned by the court and includes a deferred juror new schema
      | owner   | pool_no       | part_no         | no_weeks   |
      | 415     | <pool_number> | <juror_number>  | <no_weeks> |

    And I navigate to the pool search screen
    When I enter the pool number "<pool_number>" on the pool search screen
    And I expand the pool search advanced search criteria
    And I select the Requested option in the advanced pool search section
    And I search for the pool
    Then I see "There are no matching results" on the page

    Examples:
      | juror_number	| pool_number	| no_weeks|
      | 041500073       | 415300163	    | 10      |

  @JurorTransformationMulti @NewSchemaConverted
  Scenario Outline: Test to search for pool by pool number with non matching pool stage
    Given I am on "Bureau" "test"

    Given a bureau owned pool is created with jurors
      | court | juror_number      | pool_number	    | att_date_weeks_in_future	| owner |
      | 415   | <juror_number>    | <pool_number>   | 5				            | 400	|

    And I log in as "MODTESTCOURT"

    And a new pool is inserted which is owned by the court and includes a deferred juror new schema
      | owner   | pool_no       | part_no         | no_weeks   |
      | 415     | <pool_number> | <juror_number>  | <no_weeks> |

    And I navigate to the pool search screen
    When I enter the pool number "<pool_number>" on the pool search screen
    And I expand the pool search advanced search criteria
    And I select the With the Bureau option in the advanced pool search section
    And I search for the pool
    Then I see "There are no matching results" on the page

    Examples:
      | juror_number  | pool_number	|no_weeks|
      | 041500074     | 415300164	|10      |

  @JurorTransformationMulti @NewSchemaConverted
  Scenario Outline: Test to search for pool by pool number with non matching pool type
    Given I am on "Bureau" "test"

    Given a bureau owned pool is created with jurors
      | court | juror_number      | pool_number	    | att_date_weeks_in_future	| owner |
      | 415   | <juror_number>    | <pool_number>   | 5				            | 400	|

    And I log in as "MODTESTCOURT"

    And a new pool is inserted which is owned by the court and includes a deferred juror new schema
      | owner   | pool_no       | part_no         | no_weeks   |
      | 415     | <pool_number> | <juror_number>  | <no_weeks> |

    And I navigate to the pool search screen
    When I enter the pool number "<pool_number>" on the pool search screen
    And I expand the pool search advanced search criteria
    And I select the High Court option in the advanced pool search section
    And I search for the pool
    Then I see "There are no matching results" on the page

    Examples:
      | juror_number| pool_number | no_weeks|
      | 041500075   | 415300165	  | 10      |

  @JurorTransformationMulti @NewSchemaConverted
  Scenario Outline: Test to check previous advanced search criteria is retained
    Given I am on "Bureau" "test"

    Given a bureau owned pool is created with jurors
      | court | juror_number       | pool_number	 | att_date_weeks_in_future	| owner |
      | 415   | <juror_number1>    | <pool_number1>  | 5				        | 400	|

    Given a bureau owned pool is created with jurors
      | court | juror_number       | pool_number	 | att_date_weeks_in_future	| owner |
      | 415   | <juror_number2>    | <pool_number2>  | 5				        | 400	|

    And I log in as "MODTESTCOURT"

    And a new pool is inserted which is owned by the court and includes a deferred juror new schema
      | owner | pool_no         | part_no         | no_weeks   |
      | 415   | <pool_number1>  | <juror_number1> | <no_weeks> |
      | 415   | <pool_number2>  | <juror_number2> | <no_weeks> |

    And I navigate to the pool search screen
    When I enter a location code of "415" for the pool search
    And I expand the pool search advanced search criteria
    And I select all the tick boxes in the advanced search section
    And I search for the pool
    Then the pool search results are found
    And I expand the pool search advanced search criteria
    And all the tick boxes in the advanced search section are still selected

    Examples:
      | juror_number1   | pool_number1   | juror_number2 | pool_number2 | no_weeks |
      | 041500076       | 415300166      | 041500077     | 415300167    | 10       |