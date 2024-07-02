Feature: JM-2895

  @JurorTransformationMulti @NewSchemaConverted
  Scenario Outline: Test to manually enter urgent paper summons reply as a jury officer - happy path
    Given I am on "Bureau" "ithc"

    Given a bureau owned pool is created with jurors
      | court |juror_number  	| pool_number	| att_date_weeks_in_future	| owner |
      | 415   |<juror_number> 	| <pool_number> | 1				            | 400	|

    Then a new pool is inserted for where record has transferred to the court new schema
      |part_no        | pool_no       | owner |
      |<juror_number> | <pool_number> | 415   |

    And I log in as "<user>"

    #navigate to juror record
    When the user searches for juror record "<juror_number>" from the global search bar

    #record happy path paper summons
    And I record a happy path paper summons response
    #skip straight through processing
    Then I see "Do you want to process this summons reply as responded now?" on the page
    When I click on the "No, skip and process later" link

    #validate results
    Then the view summons reply page is displayed
    And I see the reply "status" on the response is "TO DO"
    And I see the reply "type" on the response is "NEEDS REVIEW"
    And I do not see "URGENT" on the page
    And I see Reply Method is "Paper"
    And I see the process reply button

    Examples:
      |juror_number	|pool_number|user         |
      |041500010	|415300108	|MODTESTCOURT |

  @JurorTransformationMulti @NewSchemaConverted
  Scenario Outline: Test to manually enter urgent paper summons reply as jury officer - juror details validation
    Given I am on "Bureau" "ithc"

    Given a bureau owned pool is created with jurors
      | court |juror_number  	| pool_number	| att_date_weeks_in_future	| owner |
      | 415   |<juror_number> 	| <pool_number> | 1				            | 400	|

    Then a new pool is inserted for where record has transferred to the court new schema
      |part_no        | pool_no       | owner |
      |<juror_number> | <pool_number> | 415   |

    And I log in as "<user>"
    And a new pool is inserted for court "415" new schema
    When the user searches for juror record "<juror_number>" from the global search bar
    And I click the Enter summons reply button
    Then the juror details form is displayed
    When I enter a juror details phone number of "Test"
    And I enter a juror details email of "Test@Test"
    And I click continue on the juror summons reply page
    Then an error is displayed on the juror summons reply page saying "Enter a UK telephone number"
    And an error is displayed on the juror summons reply page saying "Enter a valid email address"

    Examples:
      |juror_number	|pool_number|user         |
      |041500011	|415300109	|MODTESTCOURT |

  @JurorTransformationMulti @NewSchemaConverted
  Scenario Outline: Test to manually enter urgent summons reply as jury officer - change name and address
    Given I am on "Bureau" "ithc"

    Given a bureau owned pool is created with jurors
      | court |juror_number  	| pool_number	| att_date_weeks_in_future	| owner |
      | 415   |<juror_number> 	| <pool_number> | 1				            | 400	|

    Then a new pool is inserted for where record has transferred to the court new schema
      |part_no        | pool_no       | owner |
      |<juror_number> | <pool_number> | 415   |

    And I log in as "<user>"

    When the user searches for juror record "<juror_number>" from the global search bar
    And I click the Enter summons reply button
    Then the juror details form is displayed
    When I fill in all of the juror details for the summons reply
    And I click the change name link on the juror details reply page
    And I enter a first name of "Test" on the juror summons reply change name page
    And I click save on the juror details change page

    When I click the change address link on the juror details reply page
    And I enter an address line 1 of "1 Test Street" on the juror summons reply change address page
    And I click save on the juror details change page
    Then I see a name of "Test" on the juror details reply page
    And I see an address of "1 Test Street" on the juror details reply page

    Examples:
      |juror_number	|pool_number  |user         |
      |041500012	|415300110	  |MODTESTCOURT |

  @JurorTransformationMulti @NewSchemaConverted
  Scenario Outline: Test to manually enter urgent summons reply as jury officer - too many characters
    Given I am on "Bureau" "test"

    Given a bureau owned pool is created with jurors
      | court |juror_number  	| pool_number	| att_date_weeks_in_future	| owner |
      | 415   |<juror_number> 	| <pool_number> | 1				            | 400	|

    Then a new pool is inserted for where record has transferred to the court new schema
      |part_no        | pool_no       | owner |
      |<juror_number> | <pool_number> | 415   |

    And I log in as "<user>"

    When the user searches for juror record "<juror_number>" from the global search bar
    And I click the Enter summons reply button
    Then the juror details form is displayed
    When I fill in all of the juror details for the summons reply
    And I click continue on the juror summons reply page
    Then the juror summons reply eligibility page is displayed
    When I answer the juror summons reply eligibility questions
    And I click continue on the juror summons reply page
    Then the juror summons reply types page is displayed
    When I select that the juror can serve on the summons date
    And I click continue on the juror summons reply page
    Then the juror summons reply CJS employment page is displayed
    When I select that the juror has worked for the police force
    And I enter over 2000 characters in the Which police force? text box
    And I click continue on the juror summons reply page
    Then an error is displayed on the juror summons reply page saying "Police force details must be 2000 characters or less"

    Examples:
      |juror_number	|pool_number  |user         |
      |041500013	|415300111	  |MODTESTCOURT |