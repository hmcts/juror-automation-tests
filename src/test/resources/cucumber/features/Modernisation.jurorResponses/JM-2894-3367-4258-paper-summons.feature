Feature: JM-2894 JM 3367

  @JurorTransformationMulti @NewSchemaConverted
  Scenario Outline: Test to manually enter summons reply as bureau - happy path
    Given I am on "Bureau" "test"

    Given a bureau owned pool is created with jurors
      | court |juror_number  | pool_number	| att_date_weeks_in_future	| owner |
      | 452	  |<juror_number>| <pool_number>| 5				            | 400	|

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
    When I select that the juror has not worked in the criminal justice system
    And I click continue on the juror summons reply page
    Then the juror summons reply reasonable adjustments page is displayed
    When I select that the juror does not need adjustments
    And I click continue on the juror summons reply page
    Then the juror summons reply Signature page is displayed
    When I select that the summons reply has been signed
    And I click done on the juror summons reply page
    Then the view summons reply page is displayed

    Examples:
      |juror_number |pool_number  |user         |
      |045200031    |452300030    |MODTESTBUREAU|

  @JurorTransformationMulti @NewSchemaConverted
  Scenario Outline: Test to manually enter summons reply as bureau - juror details validation

    Given I am on "Bureau" "test"

    Given a bureau owned pool is created with jurors
      | court |juror_number  | pool_number	| att_date_weeks_in_future	| owner |
      | 452	  |<juror_number>| <pool_number>| 5				            | 400	|

    And I log in as "<user>"
    When the user searches for juror record "<juror_number>" from the global search bar
    And I click the Enter summons reply button
    Then the juror details form is displayed
    When I enter a juror details phone number of "Test"
    And I enter a juror details email of "Test@Test"
    And I click continue on the juror summons reply page
    Then an error is displayed on the juror summons reply page saying "Enter a valid main phone number"
    And an error is displayed on the juror summons reply page saying "Enter a valid email address"

    Examples:
      | juror_number | pool_number  | user         |
      | 045200032    | 452300031    | MODTESTBUREAU|


  @JurorTransformationMulti @NewSchemaConverted
  Scenario Outline: Test to manually enter summons reply as bureau - change name and address
    Given I am on "Bureau" "test"

    Given a bureau owned pool is created with jurors
      | court |juror_number  | pool_number	| att_date_weeks_in_future	| owner |
      | 452	  |<juror_number>| <pool_number>| 5				            | 400	|

    And juror "<juror_number>" has "POSTCODE" as "CH1 2AA" new schema

    And I log in as "<user>"
    And I search for juror "<juror_number>"
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
    | juror_number | pool_number  | user         |
    | 045200033    | 452300032    | MODTESTBUREAU|


  @JurorTransformationMulti @NewSchemaConverted
  Scenario Outline: Test to manually enter summons reply as bureau - too many characters

    Given I am on "Bureau" "test"

    Given a bureau owned pool is created with jurors
      | court |juror_number  | pool_number	| att_date_weeks_in_future	| owner |
      | 452	  |<juror_number>| <pool_number>| 5				            | 400	|

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
      | juror_number | pool_number | user          |
      | 641500628    | 452300033   | MODTESTBUREAU |

  Scenario Outline: Test to manually enter summons reply as bureau - change address to address outside catchment
    Given I am on "Bureau" "test"

    Given a bureau owned pool is created with jurors
      | court | juror_number   | pool_number   | att_date_weeks_in_future | owner |
      | 415   | <juror_number> | <pool_number> | 5                        | 400   |

    And juror "<juror_number>" has "POSTCODE" as "CH1 2AA" new schema

    And I log in as "<user>"
    And I navigate to the pool request screen
    And I create an active "civil" court pool request for court "457", "14" Mondays in the future
    And I search for juror "<juror_number>"
    And I click the Enter summons reply button
    Then the juror details form is displayed
    When I click the change address link on the juror details reply page
    When I set "Postcode" to "<new_postcode>"
    And I press the "Save" button
    When I fill in all of the juror details for the summons reply
    And I click continue on the juror summons reply page
    Then the juror summons reply eligibility page is displayed
    When I answer the juror summons reply eligibility questions
    And I click continue on the juror summons reply page
    Then the juror summons reply types page is displayed
    When I select that the juror can serve on the summons date
    And I click continue on the juror summons reply page
    Then the juror summons reply CJS employment page is displayed
    When I select that the juror has not worked in the criminal justice system
    And I click continue on the juror summons reply page
    Then the juror summons reply reasonable adjustments page is displayed
    When I select that the juror does not need adjustments
    And I click continue on the juror summons reply page
    Then the juror summons reply Signature page is displayed
    When I select that the summons reply has been signed
    And I click done on the juror summons reply page
    Then I see "Juror's address is outside the catchment area of the court they were summoned to" on the page
    And I press the "Process reply" button
    And I see "How do you want to process this reply?" on the page
    And I set the radio button to "Mark as responded"
    And I press the "Continue" button
    And I see "You may need to reassign this juror to a different court before you can finish processing this reply" on the page
    And I set the radio button to "Swansea Crown Court (457)"
    And I press the "Continue" button
    And I see "Choose a pool to reassign to" on the page
    And I see the reassign active pools table
    And I select one of the active pools available
    And I press the "Continue" button
    And I check the "Mark juror as 'responded'" checkbox
    And I press the "Confirm" button
    And I see "Summons reply for <juror_number> fname lname successfully processed: Responded" on the page
    And I search for juror "<juror_number>"
    And the juror record court name has updated to "Swansea"

    Examples:
      | juror_number | pool_number | user          | new_postcode |
      | 041540001    | 415300401   | MODTESTBUREAU | SA1 2TW      |

  Scenario Outline: Test to manually enter summons reply as bureau - change address don't change court
    Given I am on "Bureau" "test"

    Given a bureau owned pool is created with jurors
      | court | juror_number   | pool_number   | att_date_weeks_in_future | owner |
      | 415   | <juror_number> | <pool_number> | 5                        | 400   |

    And juror "<juror_number>" has "POSTCODE" as "CH1 2AA" new schema

    And I log in as "<user>"
    And I navigate to the pool request screen
    And I create an active "civil" court pool request for court "457", "14" Mondays in the future
    And I search for juror "<juror_number>"
    And I click the Enter summons reply button
    Then the juror details form is displayed
    When I click the change address link on the juror details reply page
    When I set "Postcode" to "<new_postcode>"
    And I press the "Save" button
    When I fill in all of the juror details for the summons reply
    And I click continue on the juror summons reply page
    Then the juror summons reply eligibility page is displayed
    When I answer the juror summons reply eligibility questions
    And I click continue on the juror summons reply page
    Then the juror summons reply types page is displayed
    When I select that the juror can serve on the summons date
    And I click continue on the juror summons reply page
    Then the juror summons reply CJS employment page is displayed
    When I select that the juror has not worked in the criminal justice system
    And I click continue on the juror summons reply page
    Then the juror summons reply reasonable adjustments page is displayed
    When I select that the juror does not need adjustments
    And I click continue on the juror summons reply page
    Then the juror summons reply Signature page is displayed
    When I select that the summons reply has been signed
    And I click done on the juror summons reply page
    Then I see "Juror's address is outside the catchment area of the court they were summoned to" on the page
    And I press the "Process reply" button
    And I see "How do you want to process this reply?" on the page
    And I set the radio button to "Mark as responded"
    And I press the "Continue" button
    And I see "You may need to reassign this juror to a different court before you can finish processing this reply" on the page
    And I set the radio button to "Leave as Chester (415)"
    And I press the "Continue" button
    And I check the "Mark juror as 'responded'" checkbox
    And I press the "Confirm" button
    And I see "Summons reply for <juror_number> fname lname successfully processed: Responded" on the page
    And I search for juror "<juror_number>"
    And the juror record court name has updated to "The Crown Court At Chester"

    Examples:
      | juror_number | pool_number | user          | new_postcode |
      | 041540002    | 415300402   | MODTESTBUREAU | SA1 2TW      |


  Scenario Outline: Test to manually enter summons reply as bureau - change address move to other court
    Given I am on "Bureau" "test"

    Given a bureau owned pool is created with jurors
      | court | juror_number   | pool_number   | att_date_weeks_in_future | owner |
      | 415   | <juror_number> | <pool_number> | 5                        | 400   |

    And juror "<juror_number>" has "POSTCODE" as "CH1 2AA" new schema

    And I log in as "<user>"
    And I navigate to the pool request screen
    And I create an active "civil" court pool request for court "457", "14" Mondays in the future
    And I search for juror "<juror_number>"
    And I click the Enter summons reply button
    Then the juror details form is displayed
    When I click the change address link on the juror details reply page
    When I set "Postcode" to "<new_postcode>"
    And I press the "Save" button
    When I fill in all of the juror details for the summons reply
    And I click continue on the juror summons reply page
    Then the juror summons reply eligibility page is displayed
    When I answer the juror summons reply eligibility questions
    And I click continue on the juror summons reply page
    Then the juror summons reply types page is displayed
    When I select that the juror can serve on the summons date
    And I click continue on the juror summons reply page
    Then the juror summons reply CJS employment page is displayed
    When I select that the juror has not worked in the criminal justice system
    And I click continue on the juror summons reply page
    Then the juror summons reply reasonable adjustments page is displayed
    When I select that the juror does not need adjustments
    And I click continue on the juror summons reply page
    Then the juror summons reply Signature page is displayed
    When I select that the summons reply has been signed
    And I click done on the juror summons reply page
    Then I see "Juror's address is outside the catchment area of the court they were summoned to" on the page
    And I press the "Process reply" button
    And I see "How do you want to process this reply?" on the page
    And I set the radio button to "Mark as responded"
    And I press the "Continue" button
    And I see "You may need to reassign this juror to a different court before you can finish processing this reply" on the page
    And I see "Leeds" on the page
    And I set the radio button to "Select a different court"
    And I set "Court name or location code" to "457"
    Then I click on the "Swansea Crown Court (457)" link
    And I press the "Continue" button
    And I see "Choose a pool to reassign to" on the page
    And I see the reassign active pools table
    And I select one of the active pools available
    And I press the "Continue" button
    And I check the "Mark juror as 'responded'" checkbox
    And I press the "Confirm" button
    And I see "Summons reply for <juror_number> fname lname successfully processed: Responded" on the page
    And I search for juror "<juror_number>"
    And the juror record court name has updated to "Swansea"

    Examples:
      | juror_number | pool_number | user          | new_postcode |
      | 041540003    | 415300403   | MODTESTBUREAU | LS1 2TW      |

