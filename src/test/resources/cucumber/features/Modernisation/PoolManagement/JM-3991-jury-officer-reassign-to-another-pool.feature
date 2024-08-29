Feature: JM-3991 Reassign Juror as Court User

  @JurorTransformationMulti @NewSchemaConverted
  Scenario Outline: Reassign a juror to a pool court - Jury User

    Given I am on "Bureau" "test"

    Given a bureau owned pool is created with jurors
      | court | juror_number  	| pool_number	| att_date_weeks_in_future	| owner |
      | 415	  | <juror_number1> | <pool_number1>| 5				            | 400	|

    Given a bureau owned pool is created with jurors
      | court | juror_number  	| pool_number	| att_date_weeks_in_future	| owner |
      | 415	  | <juror_number2> | <pool_number2>| 5				            | 400	|

    #respond juror as bureau user
    And I log in as "MODTESTBUREAU"

    When the user searches for juror record "<juror_number1>" from the global search bar
    And I record a paper summons response with reasonable adjustment of "C - Caring Responsibilities"
    And I select Process reply
    And I mark the reply as responded
    And I press the "Continue" button
    And I click the checkbox to mark the reply as responded
    And I press the "Confirm" button
    And I see the juror status has updated to "Responded"

    When the user searches for juror record "<juror_number2>" from the global search bar
    And I record a paper summons response with reasonable adjustment of "C - Caring Responsibilities"
    And I select Process reply
    And I mark the reply as responded
    And I press the "Continue" button
    And I click the checkbox to mark the reply as responded
    And I press the "Confirm" button
    Then I verify summons reply banner processed by user "MODTESTBUREAU" and status "Responded"

    Given a new pool is inserted for where record has transferred to the court new schema
      |part_no         | pool_no        | owner |
      |<juror_number1> | <pool_number1> | 415   |
      |<juror_number2> | <pool_number2> | 415   |

    #log on as court
    Given I am on "Bureau" "test"
    And I log in as "<user>"

    When I navigate to the pool request screen
    And I click on active pools
    And I click on the "At court" link
    When I navigate to the active pool "<pool_number1>" overview
    And I click on the "<juror_number1>" link

    #Reassign from juror record
    When I click the update juror record button
    And I click the reassign to another pool radio button
    And I press the "Continue" button
    And I see the reassign active pools table
    When I select pool "<pool_number2>" from the active pools table
    And I press the "Continue" button
    Then I see "Reassigned to pool <pool_number2>" on the page
    And the juror record pool number has updated to "<pool_number2>"

    Examples:
      |juror_number1|pool_number1 |juror_number2|pool_number2  |user         |
      |041500041    |415300131    |041500042    |415300132     |MODTESTCOURT |