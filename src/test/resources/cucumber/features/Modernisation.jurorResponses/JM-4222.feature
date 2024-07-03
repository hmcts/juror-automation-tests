Feature: JM-4222

  @JurorTransformationMulti @NewSchemaConverted
  Scenario Outline: As a Bureau when I reassign a juror the optic reference should be copied over to the new record

    Given I am on "Bureau" "test"

    And I log in as "<user>"

    Given a bureau owned pool is created with jurors
      | court |juror_number  | pool_number  | att_date_weeks_in_future | owner |
      | 452   |<juror_number>| <pool_number>| 5                         | 400  |

    When the user searches for juror record "<juror_number>" from the global search bar

    And I record a paper summons response with reasonable adjustment of "C - Caring Responsibilities"

    And I click the juror details adjustments tab
    When I press the "Check court can accommodate" button
    Then I am on the check can accommodate screen

    #for this to work in Jenkins, we need a later version of Selenium which includes the setPermissions method and would allow this to work. Commenting out for now
    #When I press the "Copy juror information" button
    When I enter the optic reference number "12345678"
    And I press the "Save" button
    And I click the juror details adjustments tab
    And I see "12345678" in the same row as "Optic reference"

    #process response
    When the user searches for juror record "<juror_number>" from the global search bar

    Then I click on the Summons Reply tab
    Then I click on the view summons reply link
    Then I click the process reply button
    Then I mark the reply as responded
    And I press the "Continue" button
    Then I click the checkbox to mark the reply as responded
    And I press the "Confirm" button

    #reassign juror
    When the user searches for juror record "<juror_number>" from the global search bar
    When I click the update juror record button
    And I click the reassign to another pool radio button
    And I press the "Continue" button
    Then I see "Active pools at Shrewsbury (452)" on the page
    And I see "Choose a pool to reassign to" on the page
    And I see the reassign active pools table
    And I select one of the active pools available
    And I press the "Continue" button
    And I check optic reference in the database for juror "<juror_number>" is "12345678" new schema

    #check optic reference has been copied
    #JM-4742 currently causing this to fail
    And I click on the "Summons reply" link
    And I click on the "View summons reply" link
    And I select the reasonable adjustments tab from the summons reply page
    And I see "12345678" in the same row as "Optic reference"

    #check juror record for optic reference
    When the user searches for juror record "<juror_number>" from the global search bar
    And I see "Additional requirements" on the page
    And I see "12345678" in the same row as "Optic reference"
    And I see "Reasonable adjustments reasons" on the page

    Examples:
      | user          | juror_number | pool_number |
      | MODTESTBUREAU | 045200023    | 452300019   |

  @JurorTransformationMulti @NewSchemaConverted
  Scenario Outline: As a Bureau I should be able to see the optic reference on a juror record and summons reply as a standard juror

    Given I am on "Bureau" "test"

    And I log in as "<user>"

    Given a bureau owned pool is created with jurors
      | court |juror_number  | pool_number  | att_date_weeks_in_future | owner |
      | 452   |<juror_number>| <pool_number>| 5                         | 400  |

    When the user searches for juror record "<juror_number>" from the global search bar
    And I record a paper summons response with reasonable adjustment of "C - Caring Responsibilities"

    And I select the reasonable adjustments tab from the summons reply page
    And I do not see "Optic reference" on the page
    When I press the "Check court can accommodate" button
    Then I am on the check can accommodate screen

    #for this to work in Jenkins, we need a later version of Selenium which includes the setPermissions method and would allow this to work. Commenting out for now
    #When I press the "Copy juror information" button
    When I enter the optic reference number "12345678"
    And I press the "Save" button
    And I click the juror details adjustments tab
    And I see "12345678" in the same row as "Optic reference"

    #check juror record for optic reference
    When the user searches for juror record "<juror_number>" from the global search bar
    And I see "Additional requirements" on the page
    And I see "12345678" in the same row as "Optic reference"
    And I see "Reasonable adjustments reasons" on the page

    Examples:
      | juror_number  | pool_number | user          |
      | 045200021     | 452300020   | MODTESTBUREAU |

  @JurorTransformationMulti @NewSchemaConverted
  Scenario Outline: As a Bureau when I postpone a juror the optic reference should be copied over to the new record

    Given I am on "Bureau" "test"

    And I log in as "<user>"

    Given a bureau owned pool is created with jurors
      | court |juror_number  | pool_number  | att_date_weeks_in_future | owner |
      | 452   |<juror_number>| <pool_number>| 5                         | 400  |

    When the user searches for juror record "<juror_number>" from the global search bar

    And I record a paper summons response with reasonable adjustment of "C - Caring Responsibilities"
    And I select the reasonable adjustments tab from the summons reply page
    When I press the "Check court can accommodate" button
    Then I am on the check can accommodate screen

    #for this to work in Jenkins, we need a later version of Selenium which includes the setPermissions method and would allow this to work. Commenting out for now
    #When I press the "Copy juror information" button
    When I enter the optic reference number "12345678"
    And I press the "Save" button

    When the user searches for juror record "<juror_number>" from the global search bar
    And I click the update juror record button
    And I set the radio button to "Postpone service start date"
    And I click continue on the update juror record screen
    And I enter a date "45" mondays in the future for the new service start date
    When I click continue on the postponement page
    Then I see "There are no active pools for this date" on the page
    When I press the "Put in deferral maintenance" button
    Then I see "Juror record updated: Postponed" on the page

    When the user searches for juror record "<juror_number>" from the global search bar
    And I click on the Summons Reply tab
    And I click on the "View summons reply" link
    And I select the reasonable adjustments tab from the summons reply page
    And I see "12345678" in the same row as "Optic reference"

    #check juror record for optic reference
    When the user searches for juror record "<juror_number>" from the global search bar
    And I see "Additional requirements" on the page
    And I see "12345678" in the same row as "Optic reference"
    And I see "Reasonable adjustments reasons" on the page

    Examples:
      | juror_number  | pool_number | user          |
      | 045200022     | 452300021   | MODTESTBUREAU |


  @JurorTransformationMulti @NewSchemaConverted
  Scenario Outline: As a Bureau when I defer a juror the optic reference should be copied over to the new record

    Given I am on "Bureau" "test"

    And I log in as "<user>"

    Given a bureau owned pool is created with jurors
      | court | juror_number  | pool_number   | att_date_weeks_in_future   | owner |
      | 452   | <juror_number>| <pool_number> | 5                       | 400  |

    When the user searches for juror record "<juror_number>" from the global search bar

    #record paper summons response
    And I click the Enter summons reply button
    Then the juror details form is displayed

    #juror details
    When I fill in all of the juror details for the summons reply
    And I click continue on the juror summons reply page

    #eligibility
    Then the juror summons reply eligibility page is displayed
    When I answer the juror summons reply eligibility questions
    And I click continue on the juror summons reply page

    #can attend on date
    Then the juror summons reply types page is displayed
    When I set the radio button to "Deferral request"
    And I click continue on the juror summons reply page

    #cjs
    Then the juror summons reply CJS employment page is displayed
    When I select that the juror has not worked in the criminal justice system
    And I click continue on the juror summons reply page

    #reasonable adjustments
    Then the juror summons reply reasonable adjustments page is displayed
    When I select that the juror does need adjustments
    And I select "C - Caring Responsibilities" from the adjustments reason dropdown
    And I set "What help does the juror need at court?" to "Childcare"
    And I click continue on the juror summons reply page

    #confirm/sign
    Then the juror summons reply Signature page is displayed
    When I select that the summons reply has been signed
    And I click done on the juror summons reply page

    And I see the reply "status" on the response is "TO DO"
    And I see the reply "type" on the response is "DEFERRAL"
    And I select the reasonable adjustments tab from the summons reply page
    When I press the "Check court can accommodate" button
    Then I am on the check can accommodate screen

    #for this to work in Jenkins, we need a later version of Selenium which includes the setPermissions method and would allow this to work. Commenting out for now
    #When I press the "Copy juror information" button
    When I enter the optic reference number "12345678"
    And I press the "Save" button

    When the user searches for juror record "<juror_number>" from the global search bar
    And I click the update juror record button
    And I set the radio button to "Deferral - grant or refuse"
    Then I click continue on the update juror record screen
    And I select "O - OTHER" from the "Reason for the deferral request" dropdown
    And I set the radio button to "Grant deferral"
    Then I select to Choose a different date
    Then I set the "new" choice to "51" Mondays in the future
    And I press the "Continue" button
    And I see "Deferral granted (other)" on the page

    When the user searches for juror record "<juror_number>" from the global search bar
    And I click on the Summons Reply tab
    And I click on the "View summons reply" link
    And I select the reasonable adjustments tab from the summons reply page
    And I see "12345678" in the same row as "Optic reference"

    #check juror record for optic reference
    When the user searches for juror record "<juror_number>" from the global search bar
    And I see "Additional requirements" on the page
    And I see "12345678" in the same row as "Optic reference"

    Examples:
      | juror_number  | pool_number | user          |
      | 045200023     | 452300022   | MODTESTBUREAU |

  @JurorTransformationWIP @NewSchemaConverted @JM-6998
  Scenario Outline: As a Jury officer when I reassign a juror the optic reference should be copied over to the new record

    Given I am on "Bureau" "test"

    And I log in as "<user>"

    Given a bureau owned pool is created with jurors
      | court | juror_number  | pool_number   | att_date_weeks_in_future   | owner |
      | 415   | <juror_number>| <pool_number> | 5                       | 400  |
      | 415   | <juror_number_1>| <pool_number_1> | 5                       | 400  |

    Then a new pool is inserted for where record has transferred to the court new schema
      |part_no        | pool_no       | owner |
      |<juror_number> | <pool_number> | 415   |
      |<juror_number_1> | <pool_number_1> | 415   |

    And I update juror "<juror_number_1>" to have a status of responded in order to record attendance
    When the user searches for juror record "<juror_number>" from the global search bar

    And I record a paper summons response with reasonable adjustment of "C - Caring Responsibilities"
    When the user searches for juror record "<juror_number>" from the global search bar
    Then I click on the Summons Reply tab
    Then I click on the view summons reply link
    And I click the juror details adjustments tab
    When I press the "Check court can accommodate" button
    Then I am on the check can accommodate screen

    #for this to work in Jenkins, we need a later version of Selenium which includes the setPermissions method and would allow this to work. Commenting out for now
    #When I press the "Copy juror information" button
    When I enter the optic reference number "12345678"
    And I press the "Save" button
    And I click the juror details adjustments tab
    And I see "12345678" in the same row as "Optic reference"

    #process response
    When the user searches for juror record "<juror_number>" from the global search bar
    Then I click on the Summons Reply tab
    Then I click on the view summons reply link
    Then I click the process reply button
    Then I mark the reply as responded
    And I press the "Continue" button
    Then I click the checkbox to mark the reply as responded
    And I press the "Confirm" button

    #reassign juror
    When the user searches for juror record "<juror_number>" from the global search bar
    And I click on the pool number link on Juror Record
    And I check the juror "<juror_number>" checkbox
    And I press the "Reassign" button
    And I select one of the active pools available
    And I press the "Continue" button
    And I see "1 jurors reassigned to pool" on the page
    And I check optic reference in the database for juror "<juror_number>" is "12345678" new schema


    When the user searches for juror record "<juror_number>" from the global search bar
    And I click on the "Summons reply" link
    And I click on the "View summons reply" link
    And I click on the "Reasonable adjustments" link
    And I see "12345678" in the same row as "Optic reference"

    #check juror record for optic reference
    When the user searches for juror record "<juror_number>" from the global search bar
    And I see "Additional requirements" on the page
    And I see "12345678" in the same row as "Optic reference"
    And I see "Reasonable adjustments reasons" on the page

    Examples:
      | user         | juror_number  | pool_number |juror_number_1|pool_number_1|
      | MODTESTCOURT | 041500049     | 415300139   |041500050     |415300140  |


  @JurorTransformationWIP @NewSchemaConverted @JM-7236
  Scenario Outline: As a jury officer officer when I transfer a juror the optic reference should be copied over to the new record
    Given I am on "Bureau" "test"

    Given a bureau owned pool is created with jurors
      | court | juror_number  | pool_number  | att_date_weeks_in_future    | owner |
      | 415   | <juror_number>| <pool_number>| 5                    | 400  |

    #respond juror as bureau user
    And I log in as "MODTESTBUREAU"
    When the user searches for juror record "<juror_number>" from the global search bar
    And I record a paper summons response with reasonable adjustment of "C - Caring Responsibilities"
    And I click the juror details adjustments tab
    When I press the "Check court can accommodate" button
    Then I am on the check can accommodate screen

    #for this to work in Jenkins, we need a later version of Selenium which includes the setPermissions method and would allow this to work. Commenting out for now
    #When I press the "Copy juror information" button
    When I enter the optic reference number "12345678"
    And I press the "Save" button
    And I click the juror details adjustments tab
    And I see "12345678" in the same row as "Optic reference"

    Given I am on "Bureau" "test"
    And I log in as "<user>"

    #transfer to court
    Then a new pool is inserted for where record has transferred to the court new schema
      |part_no        | pool_no       | owner |
      |<juror_number> | <pool_number> | 415   |

    When the user searches for juror record "<juror_number>" from the global search bar
    And I click on the Summons Reply tab
    And I click on the "View summons reply" link
    And I click on the "Reasonable adjustments" link
    And I see "12345678" in the same row as "Optic reference"
    And I see "Reasonable adjustments reasons" on the page
    Then I click the process reply button
    Then I mark the reply as responded
    And I press the "Continue" button
    Then I click the checkbox to mark the reply as responded
    And I press the "Confirm" button


    When the user searches for juror record "<juror_number>" from the global search bar
    And I click on the pool number link on Juror Record
    And I check the juror "<juror_number>" checkbox
    And I press the "Transfer" button
    And I see "Select a court to transfer to" on the page
    And I set "Enter a court name or location code" to "774"
    And I set the "Service start date for transfer" date to a Monday "4" weeks in the future
    And I press the "Continue" button
    Then I see "Transfer to Welshpool (774)" on the page
    When I press the "Continue" button
    When the user searches for juror record "<juror_number>" from the global search bar
    And I see the juror status on the juror record screen has updated to "Transferred"

    When the user searches for juror record "<juror_number>" from the global search bar
    And I click the summons reply tab
    And I click on the "View summons reply" link
    And I click on the "Reasonable adjustments" link
    And I see "12345678" in the same row as "Optic reference"

    Given I am on "Bureau" "test"
    And I log in as "MODTESTBUREAU"

    #check juror record for optic reference
    When the user searches for juror record "<juror_number>" from the global search bar
    And I click on "<juror_number>" in the same row as "Welshpool"
    And I see "Additional requirements" on the page
    And I see "12345678" in the same row as "Optic reference"
    And I see "Reasonable adjustments reasons" on the page

    Examples:
      | user         | juror_number | pool_number  |
      | MODTESTCOURT | 041503352    | 415300140    |


  @JurorTransformationMulti @NewSchemaConverted
  Scenario Outline: As a Jury Officer I should be able to see the optic reference on a juror record and summons reply as a standard juror

    Given I am on "Bureau" "test"
    And I log in as "<user>"

    Given a bureau owned pool is created with jurors
      | court | juror_number  | pool_number   | att_date_weeks_in_future   | owner |
      | 415   | <juror_number>| <pool_number> | 5                       | 400  |

    Then a new pool is inserted for where record has transferred to the court new schema
      |part_no        | pool_no       | owner |
      |<juror_number> | <pool_number> | 415   |

    When the user searches for juror record "<juror_number>" from the global search bar

    And I record a paper summons response with reasonable adjustment of "C - Caring Responsibilities"
    And I click on the "Reasonable adjustments" link
    And I do not see "Optic reference" on the page
    When I press the "Check court can accommodate" button
    Then I am on the check can accommodate screen

    #for this to work in Jenkins, we need a later version of Selenium which includes the setPermissions method and would allow this to work. Commenting out for now
    #When I press the "Copy juror information" button
    When I enter the optic reference number "12345678"
    And I press the "Save" button
    And I click the juror details adjustments tab
    And I see "12345678" in the same row as "Optic reference"

    #check juror record for optic reference
    When the user searches for juror record "<juror_number>" from the global search bar
    And I see "Additional requirements" on the page
    And I see "12345678" in the same row as "Optic reference"
    And I see "Reasonable adjustments reasons" on the page

    Examples:
      | juror_number | pool_number| user         |
      | 041500051    | 415300141  | MODTESTCOURT |

  @JurorTransformationMulti @NewSchemaConverted
  Scenario Outline: As a Jury officer when I postpone a juror the optic reference should be copied over to the new record

    Given I am on "Bureau" "test"

    And I log in as "<user>"

    Given a bureau owned pool is created with jurors
      | court | juror_number  | pool_number   | att_date_weeks_in_future   | owner |
      | 415   | <juror_number>| <pool_number> | 5                       | 400  |

    Then a new pool is inserted for where record has transferred to the court new schema
      | part_no        | pool_no      | owner |
      | <juror_number> | <pool_number>| 415   |

    When the user searches for juror record "<juror_number>" from the global search bar
    And I record a paper summons response with reasonable adjustment of "C - Caring Responsibilities"
    And I click on the "Reasonable adjustments" link
    When I press the "Check court can accommodate" button
    Then I am on the check can accommodate screen

    #for this to work in Jenkins, we need a later version of Selenium which includes the setPermissions method and would allow this to work. Commenting out for now
    #When I press the "Copy juror information" button
    When I enter the optic reference number "12345678"
    And I press the "Save" button

    When the user searches for juror record "<juror_number>" from the global search bar
    And I click the update juror record button
    And I set the radio button to "Postpone service start date"
    And I click continue on the update juror record screen
    And I enter a date "45" mondays in the future for the new service start date
    When I click continue on the postponement page
    Then I see "There are no active pools for this date" on the page
    When I press the "Put in deferral maintenance" button
    Then I see "Do you want to print a postponement letter?" on the page
    And I choose the "No" radio button
    And I press the "Continue" button
    Then I see "Juror record updated: Postponed" on the page

    When the user searches for juror record "<juror_number>" from the global search bar
    And I click on the Summons Reply tab
    And I click on the "View summons reply" link
    And I click on the "Reasonable adjustments" link
    And I see "12345678" in the same row as "Optic reference"

    #check juror record for optic reference
    When the user searches for juror record "<juror_number>" from the global search bar
    And I see "Additional requirements" on the page
    And I see "12345678" in the same row as "Optic reference"
    And I see "Reasonable adjustments reasons" on the page

    Examples:
      | juror_number  | pool_number   | user         |
      | 041500048     | 415300138     | MODTESTCOURT |


  @JurorTransformationMulti @NewSchemaConverted
  Scenario Outline: As a Jury officer when I defer a juror the optic reference should be copied over to the new record

    Given I am on "Bureau" "test"

    And I log in as "<user>"

    Given a bureau owned pool is created with jurors
      | court | juror_number  | pool_number   | att_date_weeks_in_future   | owner |
      | 415   | <juror_number>| <pool_number> | 5                       | 400  |

    Then a new pool is inserted for where record has transferred to the court new schema
      |part_no        | pool_no       | owner |
      |<juror_number> | <pool_number> | 415   |

    When the user searches for juror record "<juror_number>" from the global search bar

    #record paper summons response
    And I click the Enter summons reply button
    Then the juror details form is displayed

    #juror details
    When I fill in all of the juror details for the summons reply
    And I click continue on the juror summons reply page

    #eligibility
    Then the juror summons reply eligibility page is displayed
    When I answer the juror summons reply eligibility questions
    And I click continue on the juror summons reply page

    #can attend on date
    Then the juror summons reply types page is displayed
    When I set the radio button to "Deferral request"
    And I click continue on the juror summons reply page

    #cjs
    Then the juror summons reply CJS employment page is displayed
    When I select that the juror has not worked in the criminal justice system
    And I click continue on the juror summons reply page

    #reasonable adjustments
    Then the juror summons reply reasonable adjustments page is displayed
    When I select that the juror does need adjustments
    And I select "C - Caring Responsibilities" from the adjustments reason dropdown
    And I set "What help does the juror need at court?" to "Childcare"
    And I click continue on the juror summons reply page

    #confirm/sign
    Then the juror summons reply Signature page is displayed
    When I select that the summons reply has been signed
    And I click done on the juror summons reply page

    And I see the reply "status" on the response is "TO DO"
    And I see the reply "type" on the response is "DEFERRAL"
    And I click on the "Reasonable adjustments" link
    When I press the "Check court can accommodate" button
    Then I am on the check can accommodate screen

    #for this to work in Jenkins, we need a later version of Selenium which includes the setPermissions method and would allow this to work. Commenting out for now
    #When I press the "Copy juror information" button
    When I enter the optic reference number "12345678"
    And I press the "Save" button

    When the user searches for juror record "<juror_number>" from the global search bar
    And I click the update juror record button
    And I set the radio button to "Deferral - grant or refuse"
    Then I click continue on the update juror record screen
    And I select "O - OTHER" from the "Reason for the deferral request" dropdown
    And I set the radio button to "Grant deferral"
    Then I select to Choose a different date
    Then I set the "new" choice to "51" Mondays in the future
    And I press the "Continue" button
    Then I see "Do you want to print a deferral granted letter?" on the page
    And I choose the "No" radio button
    And I press the "Continue" button
    And I see "Deferral granted (other)" on the page

    When the user searches for juror record "<juror_number>" from the global search bar
    And I click on the Summons Reply tab
    And I click on the "View summons reply" link
    And I click on the "Reasonable adjustments" link
    And I see "12345678" in the same row as "Optic reference"

    #check juror record for optic reference
    When the user searches for juror record "<juror_number>" from the global search bar
    And I see "Additional requirements" on the page
    And I see "12345678" in the same row as "Optic reference"

    Examples:
      | juror_number  | pool_number | user         |
      | 041500052     | 415300142   | MODTESTCOURT |

