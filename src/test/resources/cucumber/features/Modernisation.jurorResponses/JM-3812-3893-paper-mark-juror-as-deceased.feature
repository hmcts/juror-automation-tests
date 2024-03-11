Feature: JM-3812 JM-3893

  @JurorTransformationMulti @NewSchemaConverted
  Scenario Outline: Test to mark juror as deceased for a paper record
    Given I am on "Bureau" "test"

    Given the juror numbers have not been processed new schema
      |part_no   | pool_no   | owner |
      |<part_no> | <pool_no> | 400   |

    And I log in as "<user>"
    And I search for juror "<part_no>"
    And I click the update juror record button
    And I select the mark as deceased radio button

    And I add a comment of "Test Comment" to be recorded in the jurors history
    Then I click continue on the update juror record screen
    And I see the juror record updated banner containing "Deceased"
    And I see the juror status on the juror record screen has updated to "Deceased"

    Examples:
      |user			|part_no    |pool_no  |
      |MODTESTBUREAU|641500236  |415170402|

  @JurorTransformationMulti @NewSchemaConverted
  Scenario Outline: Test to mark juror as deceased for a paper record - Validation
    Given I am on "Bureau" "test"

    Given the juror numbers have not been processed new schema
      |part_no   | pool_no   | owner |
      |<part_no> | <pool_no> | 400   |

    And I log in as "<user>"

    And I search for juror "<juror_number>"
    And I click the update juror record button
    And I select the mark as deceased radio button
    Then I click continue on the update juror record screen
    And I see "Enter comments to record in the juror’s history" in the error banner

    Examples:
      |user			|part_no    |pool_no  |
      |MODTESTBUREAU|641500432  |415170402|

  @JurorTransformationWIP @JM-5469 @NewSchemaConverted
  Scenario Outline: Test to mark juror as deceased for a paper record - Summons reply updated
    Given I am on "Bureau" "test"

    Given the juror numbers have not been processed new schema
      |part_no   | pool_no   | owner |
      |<part_no> | <pool_no> | 400   |

    And juror "<juror_number>" has "FIRST_NAME" as "<fname>" new schema
    And juror "<juror_number>" has "LAST_NAME" as "<lname>" new schema
    And juror "<juror_number>" has "TITLE" as "<title>" new schema

    And I log in as "<user>"

    And I search for juror "<juror_number>"
    Then I record a happy path paper summons response
    Then I see "Do you want to process this summons reply as responded now?" on the page
    When I click on the "No, skip and process later" link
    And I click the process reply button
    Then I mark the reply as responded
    And I click continue on the juror summons reply page
    And I click the checkbox to mark the reply as responded
    And I confirm I want to mark the reply as responded
    And I see "Summons reply for <part_no> <title> <fname> <lname> successfully processed: Responded" in the response banner
    Then I click the link for the juror record
    And I click the update juror record button
    And I select the mark as deceased radio button
    #fails due to JM-4919
    And I add a comment of "Test Comment" to be recorded in the jurors history
    Then I click continue on the update juror record screen
    And I see the juror record updated banner containing "Deceased"
    And I see the juror status on the juror record screen has updated to "Deceased"
    When I navigate to the paper summons reply
    Then I see the juror status has updated to "Deceased"

    Examples:
      |user			|part_no    |pool_no  |title|fname            |lname|
      |MODTESTBUREAU|641500451  |415170402|Mr   |FNAMEFOURFIVEONE |LNAMEFOURFIVEONE|
