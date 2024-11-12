Feature: JM-4079 Testing paper summons access

  @JurorTransformation @NewSchemaConverted
  Scenario Outline: Test to manually enter paper summons as COURT user when record belongs to COURT

    Given I am on "Bureau" "test"

    Given a bureau owned pool is created with jurors
      | court | juror_number   | pool_number   | att_date_weeks_in_future | owner |
      | 415   | <juror_number> | <pool_number> | -2                       | 400   |


    Given a new pool is inserted for where record has transferred to the court new schema
      | part_no        | pool_no       | owner |
      | <juror_number> | <pool_number> | 415   |

    And I log in as "MODTESTCOURT"

    #navigate to juror record
    When the user searches for juror record "<juror_number>" from the global search bar

    #record happy path paper summons
    And I record a happy path paper summons response

    #skip straight through processing
    Then I see "Do you want to process this summons reply as responded now?" on the page
    Then I see "The juror’s answers mean this is a straight-through reply. So you can process it as responded now, or return later." on the page
    When I click on the "No, skip and process later" link

    #validate results
    And I see the reply "status" on the response "To Do"
    And I see the reply "type" on the response is "Needs review"
    And I see "Juror’s service start date has passed - process as a priority." in the response banner
    And I see Reply Method is "Paper"
    And I see the process reply button

    Examples:
      | juror_number | pool_number |
      | 041540014    | 415300414   |

  @JurorTransformationMulti @NewSchemaConverted
  Scenario Outline: Test that you cant enter paper summons as BUREAU user when record belongs to COURT

    Given I am on "Bureau" "test"
    Given a bureau owned pool is created with jurors
      | court | juror_number  	    | pool_number	    | att_date_weeks_in_future	| owner |
      | 415   | <juror_number> 	    | <pool_number>     | 7				            | 400	|


    And "<juror_number>" has "NEXT_DATE" as "2 mondays time" new schema

    Given a new pool is inserted for where record has transferred to the court new schema
      |part_no   | pool_no   | owner |
      |<juror_number> | <pool_number> | 415   |

    And I log in as "MODTESTBUREAU"

    #navigate to juror record
    When the user searches for juror record "<juror_number>" from the global search bar

    #record summons button not available
    Then the Enter summons reply button is not visible

    Examples:
      |juror_number	|pool_number	|
      |041540006|415300406	|
