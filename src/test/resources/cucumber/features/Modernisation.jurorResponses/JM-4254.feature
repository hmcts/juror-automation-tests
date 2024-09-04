Feature: JM-4254 Record proof of name change

  @JurorTransformationMulti @NewSchemaConverted
  Scenario Outline: The system shall allow a bureau officer to record a proof of change of name no summons

    Given I am on "Bureau" "test"

    Given a bureau owned pool is created with jurors
      | court |juror_number  	| pool_number	| att_date_weeks_in_future	| owner |
      | 415   |<juror_number> 	| <pool_number> | 5				            | 400	|

    And I log in as "<user>"

    When the user searches for juror record "<juror_number>" from the global search bar

    And I click on the "Juror details" link
    And I click on the "Add or change" link

    And I click on the "Fix error in current name" link

    #name longer than 20 characters
    And I set "First name" to "FnameTestertttttttttttttt"
    And I set "Last name" to "LnameTestinggggggggggggggg"
    And I press the "Review Edit" button
    And I see error "Please check the first name"
    And I see error "Please check the last name"

    #special characters
    And I set "First name" to "FnameTester&#@!?%"
    And I set "Last name" to "FnameTester&#@!?%"
    And I press the "Review Edit" button
    And I click on the "Cancel" link
    And I click on the "Add or change" link
    And I click on the "Enter a new name" link
    And I see "Enter a new name" on the page
    And I see "This new name will only become their legal name on their juror record after:" on the page
    And I see "When you enter a new name here, it will overwrite any previous pending name." on the page
    And I press the "Review Edit" button

    And I see error "Please provide the first name"
    And I see error "Please provide the last name"

    And I set "First name" to "FnameTester"
    And I set "Last name" to "LnameTesting"
    And I press the "Review Edit" button

    And I see "Pending approval" on the page
    And I enter a date of birth that will make the juror between 18 and 75
    And I see the juror's new name "Fnametester Lnametesting" is pending approval
    And I press the "Save" button

    And I see "Pending approval" on the page
    And I see "Fnametester Lnametesting" on the page

    Examples:
      | juror_number | pool_number | user         |
      | 041500007    | 415300105   | MODTESTBUREAU|

  @JurorTransformationMulti
  Scenario Outline: The system shall allow a bureau officer to record a proof of change of name

    Given I am on "Bureau" "test"

    Given a bureau owned pool is created with jurors
      | court |juror_number  	| pool_number	| att_date_weeks_in_future	| owner |
      | 415   |<juror_number> 	| <pool_number> | 5				            | 400	|

    And I log in as "<user>"

    When the user searches for juror record "<juror_number>" from the global search bar
    And I record a happy path paper summons response and process now
    When the user searches for juror record "<juror_number>" from the global search bar

    And I click on the "Juror details" link
    And I click on the "Add or change" link

    And I click on the "Fix error in current name" link

    #name longer than 20 characters
    And I set "First name" to "FnameTestertttttttttttttt"
    And I set "Last name" to "LnameTestinggggggggggggggg"
    And I press the "Review Edit" button
    And I see error "Please check the first name"
    And I see error "Please check the last name"

    #special characters
    And I set "First name" to "FnameTester&#@!?%"
    And I set "Last name" to "FnameTester&#@!?%"
    And I press the "Review Edit" button
    And I click on the "Cancel" link
    And I click on the "Add or change" link
    And I click on the "Enter a new name" link
    And I see "Enter a new name" on the page
    And I see "This new name will only become their legal name on their juror record after:" on the page
    And I see "When you enter a new name here, it will overwrite any previous pending name." on the page
    And I press the "Review Edit" button

    And I see error "Please provide the first name"
    And I see error "Please provide the last name"

    And I set "First name" to "FnameTester"
    And I set "Last name" to "LnameTesting"
    And I press the "Review Edit" button

    And I see "Pending approval" on the page
    And I enter a date of birth that will make the juror between 18 and 75
    And I see the juror's new name "Fnametester Lnametesting" is pending approval
    And I press the "Save" button

    And I see "Pending approval" on the page
    And I see "Fnametester Lnametesting" on the page

    Examples:
      | juror_number | pool_number | user         |
      | 041500008    | 415300106   | MODTESTBUREAU|


  @JurorTransformationMulti @NewSchemaConverted
  Scenario Outline: The system shall allow a bureau officer to record a proof of change of name. Change name while recording paper summons

    Given I am on "Bureau" "test"

    Given a bureau owned pool is created with jurors
      | court |juror_number  	| pool_number	| att_date_weeks_in_future	| owner |
      | 415   |<juror_number> 	| <pool_number> | 5				            | 400	|

    And I log in as "<user>"

    When the user searches for juror record "<juror_number>" from the global search bar

    And I click the Enter summons reply button
    And I click on the "Enter a new name" link
    And I see "Enter a new name" on the page
    And I see "This new name will only become their legal name on their juror record after:" on the page
    And I see "When you enter a new name here, it will overwrite any previous pending name." on the page
    And I set "First name" to "FnameTester"
    And I set "Last name" to "LnameTesting"
    And I press the "Review Edit" button
    And I see "Pending approval" on the page
    And I see the juror's new name "Fnametester Lnametesting" is pending approval

    #juror details
    When I fill in all of the juror details for the summons reply
    And I click continue on the juror summons reply page

    #eligibility
    Then the juror summons reply eligibility page is displayed
    When I answer the juror summons reply eligibility questions
    And I click continue on the juror summons reply page

    #can attend on date
    Then the juror summons reply types page is displayed
    When I set the radio button to "Can serve on date shown in summons"
    And I click continue on the juror summons reply page

    #cjs
    Then the juror summons reply CJS employment page is displayed
    When I select that the juror has not worked in the criminal justice system
    And I click continue on the juror summons reply page

    #reasonable adjustments
    Then the juror summons reply reasonable adjustments page is displayed
    When I select that the juror does not need adjustments
    And I click continue on the juror summons reply page

    #confirm/sign
    Then the juror summons reply Signature page is displayed
    When I select that the summons reply has been signed
    And I click done on the juror summons reply page

    And I see "Pending" on the page
    And I see "FnameTester LnameTesting" on the page

    Examples:
      |juror_number |pool_number  |user           |
      |011000001    |010000001    | MODTESTBUREAU |