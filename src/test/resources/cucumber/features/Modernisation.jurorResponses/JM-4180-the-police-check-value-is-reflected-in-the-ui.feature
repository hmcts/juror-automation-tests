Feature: JM-4180 DB values reflected on UI

  @JurorTransformationMulti @NewSchemaConverted
  Scenario Outline: Test to check UI is correct when Police Check passes

    Given I am on "Bureau" "test"

    Given a bureau owned pool is created with jurors
      | court | juror_number  	    | pool_number	    | att_date_weeks_in_future	| owner |
      | 452   | <juror_number> 	    | <pool_number>     | 5				            | 400	|

    And juror "<juror_number>" has "LAST_NAME" as "<last_name>" new schema
    And juror "<juror_number>" has "POSTCODE" as "<postcode>" new schema

    And I log in as "MODTESTBUREAU"
    When I set Police Check to "ELIGIBLE" for "<juror_number>" new schema
    And the user searches for the juror record from the global search bar
    Then I see "<juror_number>" on the page
    And I see police check has updated to "Passed"
    Examples:
      | juror_number| pool_number   | last_name | postcode |
      | 045200131   | 452300130     | LNAME     | ML10 6AD |


  @JurorTransformationMulti @NewSchemaConverted
  Scenario Outline: Test to check UI is correct when Police Check passes but Phoenix check fails

    Given I am on "Bureau" "test"

    Given a bureau owned pool is created with jurors
      | court | juror_number  	    | pool_number	    | att_date_weeks_in_future	| owner |
      | 452   | <juror_number> 	    | <pool_number>     | 5				            | 400	|

    And juror "<juror_number>" has "LAST_NAME" as "<last_name>" new schema
    And juror "<juror_number>" has "POSTCODE" as "<postcode>" new schema

    And I log in as "MODTESTBUREAU"
    When I set Police Check to "INSUFFICIENT_INFORMATION" for "<juror_number>" new schema
    And the user searches for the juror record from the global search bar
    Then I see "<juror_number>" on the page
    And I see police check has updated to "Not Checked"

    Examples:
      | juror_number | pool_number  | last_name | postcode |
      | 045200132    | 452300131    | Lname     | ML10 6AD |


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
    And I see police check has updated to "In Progress"

    Examples:
      | juror_number  | pool_number |
      | 041500043     | 415300133   |

  @JurorTransformationMulti @NewSchemaConverted
  Scenario Outline: Test to check UI is correct when Police Check hasn't been done

    Given I am on "Bureau" "test"

    Given a bureau owned pool is created with jurors
      | court | juror_number    | pool_number  | att_date_weeks_in_future	| owner |
      | 452	  | <juror_number>  | <pool_number>| 5				            | 400	|

    And juror "<juror_number>" has "LAST_NAME" as "<last_name>" new schema
    And juror "<juror_number>" has "POSTCODE" as "<postcode>" new schema

    And I log in as "MODTESTBUREAU"
#    When I set Police Check to "" and Phoenix Checked to "" for "<part_no>"
    When I set Police Check to "" for "<juror_number>" new schema
    And the user searches for the juror record from the global search bar
    Then I see "<juror_number>" on the page
    And I see police check has updated to "Not Checked"

    Examples:
      | juror_number  | pool_number   | last_name | postcode |
      | 045200134     | 452300133     | Lname     | ML10 6AD |