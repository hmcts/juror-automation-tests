Feature: JM-3812 JM-3893

  @JurorTransformationMulti @NewSchemaConverted
  Scenario Outline: Test to mark juror as deceased for a paper record
    Given I am on "Bureau" "test"

    Given a bureau owned pool is created with jurors
      | court |juror_number  | pool_number	| att_date_weeks_in_future	| owner |
      | 452   |<juror_number>| <pool_number>	| 5				            | 400	|

    And I log in as "<user>"
    And I search for juror "<juror_number>"
    And I click the update juror record button
    And I select the mark as deceased radio button

    And I add a comment of "Test Comment" to be recorded in the jurors history
    Then I click continue on the update juror record screen
    And I see the juror record updated banner containing "Deceased"
    And I see the juror status on the juror record screen has updated to "Deceased"

    Examples:
      |user			|juror_number    |pool_number  |
      |MODTESTBUREAU|041540005  |415300405|

  @JurorTransformationMulti @NewSchemaConverted
  Scenario Outline: Test to mark juror as deceased for a paper record - Validation
    Given I am on "Bureau" "test"

    Given a bureau owned pool is created with jurors
      | court | juror_number  	    | pool_number	    | att_date_weeks_in_future	| owner |
      | 415   | <juror_number> 	    | <pool_number>     | 7				            | 400	|

    And I log in as "<user>"

    And I search for juror "<juror_number>"
    And I click the update juror record button
    And I select the mark as deceased radio button
    Then I click continue on the update juror record screen
    And I see "Enter comments to record in the juror’s history" in the error banner

    Examples:
      |user			|juror_number    |pool_number  |
      |MODTESTBUREAU|041540008  |415300408|

  @JurorTransformationWIP @JM-5469 @NewSchemaConverted
  Scenario Outline: Test to mark juror as deceased for a paper record - Summons reply updated
    Given I am on "Bureau" "test"

    Given a bureau owned pool is created with jurors
      | court |juror_number  	    | pool_number	    | att_date_weeks_in_future	| owner |
      | 415   |<juror_number> 	    | <pool_number>     | 5				            | 400	|

    And I log in as "<user>"

    When the user searches for juror record "<juror_number>" from the global search bar
    Then I record a happy path paper summons response
    Then I see "Do you want to process this summons reply as responded now?" on the page
    When I click on the "No, skip and process later" link

    And I click the process reply button
    Then I mark the reply as responded
    And I click continue on the juror summons reply page
    And I click the checkbox to mark the reply as responded
    And I confirm I want to mark the reply as responded

    When the user searches for juror record "<juror_number>" from the global search bar
    And I click the update juror record button
    And I set the radio button to "Mark as deceased"
    And I set "Comments to record in the juror’s history" to "Test Comment"
    And I press the "Continue" button
    And I see the juror record updated banner containing "Deceased"
    And I see the juror status on the juror record screen has updated to "Deceased"
    And I click on the "Summons reply" link
    And I see "Excusal granted (deceased)" in the same row as "Processing outcome"

    Examples:
      |user			|juror_number    |pool_number  |
      |MODTESTBUREAU|041526633       |415300477    |
