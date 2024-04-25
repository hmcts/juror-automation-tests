Feature: JM-4958, JM-4954, JM-4955 As a jury officer i need to be able to complete a jurors service

  @JurorTransformationMulti @NewSchemaConverted
  Scenario Outline: Complete Service as a jury officer - Bulk flow

    Given I am on "Bureau" "test"

    Given a bureau owned pool is created with jurors
      | court |juror_number  	| pool_number	| att_date_weeks_in_future	| owner |
      | 415   |<juror_number1> 	| <pool_number> | 5				            | 400	|
      | 415   |<juror_number2> 	| <pool_number> | 5				            | 400	|

    Then a new pool is inserted for where record has transferred to the court new schema
      |part_no        | pool_no       | owner |
      |<juror_number1>| <pool_number> | 415   |
      |<juror_number2>| <pool_number> | 415   |

    #log on and search for juror
    And I log in as "<user>"
    When the user searches for juror record "<juror_number1>" from the global search bar

    #record paper summons for juror and set to responded
    Then I record a happy path paper summons response
    And I click on the "No, skip and process later" link
    And I click the process reply button
    Then I mark the reply as responded
    And I click continue on the juror summons reply page
    And I click the checkbox to mark the reply as responded
    And I confirm I want to mark the reply as responded

    When the user searches for juror record "<juror_number2>" from the global search bar
    Then I record a happy path paper summons response
    And I click on the "No, skip and process later" link
    And I click the process reply button
    Then I mark the reply as responded
    And I click continue on the juror summons reply page
    And I click the checkbox to mark the reply as responded
    And I confirm I want to mark the reply as responded

    #view pool record, select juror and complete
    When the user searches for juror record "<juror_number1>" from the global search bar
    And I click on the pool number link on Juror Record
    And I check the select all checkbox on pool overview
    And I press the "Complete service" button
    And I set the "Completion date" single date field to a Monday "17" weeks in the future
    And I press the "Complete service" button
    And I see "Service completed for 2 jurors" on the page

    #view summons response
    When the user searches for juror record "<juror_number1>" from the global search bar
    And I click on the "Summons reply" link
    And I click on the "View summons reply" link
    And I see the reply status has updated to "COMPLETED"

    When the user searches for juror record "<juror_number2>" from the global search bar
    And I click on the "Summons reply" link
    And I click on the "View summons reply" link
    And I see the juror status on the juror record screen is "Completed"

    Examples:
      |user			|juror_number1|juror_number2|pool_number|
      |MODTESTCOURT |041500036    |041500037    |415300127  |


  @JurorTransformationMulti @NewSchemaConverted
  Scenario Outline: Complete Service as a jury officer - Bulk flow - Unhappy Path
    Given I am on "Bureau" "test"

    Given a bureau owned pool is created with jurors
      | court |juror_number  	| pool_number	| att_date_weeks_in_future	| owner |
      | 415   |<juror_number1> 	| <pool_number> | 5				            | 400	|
      | 415   |<juror_number2> 	| <pool_number> | 5				            | 400	|

    Then a new pool is inserted for where record has transferred to the court new schema
      |part_no        | pool_no   | owner |
      |<juror_number1>| <pool_number> | 415   |
      |<juror_number2>| <pool_number> | 415   |

    #log on and search for juror
    And I log in as "<user>"
    When the user searches for juror record "<juror_number1>" from the global search bar

    #record paper summons for both jurors and set to responded
    Then I record a happy path paper summons response
    And I click on the "No, skip and process later" link
    And I click the process reply button
    Then I mark the reply as responded
    And I click continue on the juror summons reply page
    And I click the checkbox to mark the reply as responded
    And I confirm I want to mark the reply as responded

    #view pool record, select juror and complete
    When the user searches for juror record "<juror_number1>" from the global search bar
    And I click on the pool number link on Juror Record
    And I check the select all checkbox on pool overview
    And I press the "Complete service" button
    And I press the "Complete service" button

   #attempt complete service of ineligible juror/complete service for eligible juror
    And I see "Juror number <juror_number2> is not in a valid state to complete service" on the page
    And I see "Summoned" in the same row as "<juror_number2>"
    And I refresh the page
    And I check the juror "<juror_number1>" checkbox

    And I press the "Complete service" button
    And I set the "Completion date" single date field to a Monday "17" weeks in the future
    And I press the "Complete service" button
    And I see "Service completed for 1 juror" on the page

    #view summons response
    When the user searches for juror record "<juror_number1>" from the global search bar
    And I click on the "Summons reply" link
    And I click on the "View summons reply" link
    And I see the juror status on the juror record screen is "Completed"

    Examples:
      |user			|juror_number1|juror_number2|pool_number |
      |MODTESTCOURT |041500038    |041500039    |415300128   |

  @JurorTransformationMulti @NewSchemaConverted
  Scenario Outline: Complete Service as a jury officer - Individual flow

    Given I am on "Bureau" "test"

    Given a bureau owned pool is created with jurors
      | court |juror_number  	| pool_number	| att_date_weeks_in_future	| owner |
      | 415   |<juror_number> 	| <pool_number> | 5				            | 400	|

    Then a new pool is inserted for where record has transferred to the court new schema
      |part_no         | pool_no       | owner |
      |<juror_number>  | <pool_number> | 415   |

    #log on and search for juror
    And I log in as "<user>"
    When the user searches for juror record "<juror_number>" from the global search bar

    #record paper summons for juror and set to responded
    Then I record a happy path paper summons response
    And I click on the "No, skip and process later" link
    And I click the process reply button
    Then I mark the reply as responded
    And I click continue on the juror summons reply page
    And I click the checkbox to mark the reply as responded
    And I confirm I want to mark the reply as responded

    #view juror and complete
    When the user searches for juror record "<juror_number>" from the global search bar
    And I click the update juror record button
    And I set the radio button to "Complete service"
    And I click continue on the update juror record screen
    And I set the "Completion date" single date field to a Monday "17" weeks in the future
    And I press the "Complete service" button
    Then I see "Juror's service completed" on the page
    And I see the juror status on the juror record screen is "Completed"

    Examples:
      |user			|juror_number  |pool_number |
      |MODTESTCOURT |041500044     |415300134   |


  @JurorTransformationMulti
  Scenario Outline: Complete Service as a jury officer - Individual flow - Unhappy Path (juror not marked responded)
    Given I am on "Bureau" "test"

    Given a bureau owned pool is created with jurors
      | court |juror_number  	| pool_number	| att_date_weeks_in_future	| owner |
      | 415   |<juror_number> 	| <pool_number> | 5				            | 400	|

    Then a new pool is inserted for where record has transferred to the court new schema
      | part_no         | pool_no       | owner |
      | <juror_number>  | <pool_number> | 415   |

    #log on and search for juror
    And I log in as "<user>"
    When the user searches for juror record "<juror_number>" from the global search bar

    #record paper summons for juror and do not set to responded
    Then I record a happy path paper summons response
    And I click on the "No, skip and process later" link


    #view juror and complete
    When the user searches for juror record "<juror_number>" from the global search bar
    And I click the update juror record button
    And I set the radio button to "Complete service"
    And I click continue on the update juror record screen
    And I set the "Completion date" single date field to a Monday "17" weeks in the future
    And I press the "Complete service" button
    # Assuming error is same as for bulk process as it doesn't appear in design files
    Then I see "Juror number <juror_number> is not in a valid state to complete service" on the page

    Examples:
      |user			|juror_number  |pool_number  |
      |MODTESTCOURT |415300135     |041500045    |

  @JurorTransformationMulti
  Scenario Outline: Uncomplete Service as an SJO
    Given I am on "Bureau" "test"

    Given a bureau owned pool is created with jurors
      | court |juror_number  	| pool_number	| att_date_weeks_in_future	| owner |
      | 415   |<juror_number> 	| <pool_number> | 5				            | 400	|

    Then a new pool is inserted for where record has transferred to the court new schema
      |part_no         | pool_no       | owner |
      |<juror_number>  | <pool_number> | 415   |

    #log on and search for juror
    And I log in as "<user>"
    When the user searches for juror record "<juror_number>" from the global search bar

    #record paper summons for juror and set to responded
    Then I record a happy path paper summons response
    And I click on the "No, skip and process later" link
    And I click the process reply button
    Then I mark the reply as responded
    And I click continue on the juror summons reply page
    And I click the checkbox to mark the reply as responded
    And I confirm I want to mark the reply as responded

    #view juror and complete
    When the user searches for juror record "<juror_number>" from the global search bar
    And I click the update juror record button
    And I set the radio button to "Complete service"
    And I click continue on the update juror record screen
    And I set the "Completion date" single date field to a Monday "17" weeks in the future
    And I press the "Complete service" button
    Then I see "Juror's service completed" on the page
    And I see the juror status on the juror record screen is "Completed"
    Given I am on "Bureau" "test"

    # Log in as SJO and uncomplete
    And I log in as "SJOUSER"
    And I see senior jury officer notification banner
    And I press the "Apps" button
    And I click on the "SJO Tasks" link
    And I set the radio button to "Juror Number"
    And I set "Enter juror number" to "<juror_number>"
    And I press the "Continue" button
    And I set the first checkbox on the Uncomplete Service page
    And I press the "Uncomplete juror" button
    And I see "Their juror status will revert to 'Responded' and they must continue their jury service." on the page
    And I press the "Uncomplete service" button
    And I see "Service uncompleted for 1 juror." on the page
    When I search for juror "<juror_number>"
    When the user searches for juror record "<juror_number>" from the global search bar
    Then I see the juror status on the juror record screen is "Responded"


    Examples:
      |user			|juror_number  |pool_number  |
      |MODTESTCOURT |041540003     |415300403    |