Feature: JM-3460 JM-3183

  @JurorTransformationMulti @NewSchemaConverted
  Scenario Outline: Mark Paper Summons Reply As Responded
    Given I am on "Bureau" "test"
    And I log in as "<user>"

    Given the juror numbers have not been processed new schema
      |part_no   | pool_no   | owner |
      |<part_no> | <pool_no> | 400   |


    And "<part_no>" has "NEXT_DATE" as "7 mondays time" new schema
    And pool "<pool_no>" has attendance date as "7 mondays time" new schema

    When the user searches for juror record "<part_no>" from the global search bar
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
    And I click no, to process the summons reply later
    Then the view summons reply page is displayed
    And I click the process reply button
    Then I mark the reply as responded
    And I click continue on the juror summons reply page
    And I click the checkbox to mark the reply as responded
    And I confirm I want to mark the reply as responded
    And I see the juror record updated banner containing "Responded"
    Then I click the link for the juror record
    And I see the juror status on the juror record screen has updated to "Responded"

    Examples:
      | user          | part_no   | pool_no   |
      | MODTESTBUREAU | 641500972 | 415170501 |

  @JurorTransformationMulti @NewSchemaConverted
  Scenario Outline: Cancel Marking Paper Summons Reply As Responded
    Given I am on "Bureau" "test"
    And I log in as "<user>"

    Given the juror numbers have not been processed new schema
      |part_no   | pool_no   | owner |
      |<part_no> | <pool_no> | 400   |


    And "<part_no>" has "NEXT_DATE" as "7 mondays time" new schema
    And pool "<pool_no>" has attendance date as "7 mondays time" new schema

    When the user searches for juror record "<part_no>" from the global search bar
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
    And I click no, to process the summons reply later
    Then the view summons reply page is displayed
    And I click the process reply button
    Then I mark the reply as responded
    And I click continue on the juror summons reply page
    Then I click the cancel link
    And I see the juror status on the juror record screen is "Summoned"

    Examples:
      | user          | part_no   | pool_no   |
      | MODTESTBUREAU | 641500981 | 415170501 |

  @JurorTransformationMulti @NewSchemaConverted
  Scenario Outline: Mark Paper Summons Reply As Responded - Mark As Responded Validation
    Given I am on "Bureau" "test"
    And I log in as "<user>"

    Given the juror numbers have not been processed new schema
      |part_no   | pool_no   | owner |
      |<part_no> | <pool_no> | 400   |


    And "<part_no>" has "NEXT_DATE" as "7 mondays time" new schema
    And pool "<pool_no>" has attendance date as "7 mondays time" new schema

    When the user searches for juror record "<part_no>" from the global search bar
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
    And I click no, to process the summons reply later
    Then the view summons reply page is displayed
    And I click the process reply button
    Then I mark the reply as responded
    And I click continue on the juror summons reply page
    And I confirm I want to mark the reply as responded
    And there is an error message with the text "Confirm that the reply can be marked as 'responded'"

    Examples:
      | user          | part_no   | pool_no   |
      | MODTESTBUREAU | 641500985 | 415170501 |

  @JurorTransformationMulti @NewSchemaConverted
  Scenario Outline: Mark Paper Summons Reply As Responded - Confirm Mark As Responded validation
    Given I am on "Bureau" "test"
    And I log in as "<user>"

    Given the juror numbers have not been processed new schema
      |part_no   | pool_no   | owner |
      |<part_no> | <pool_no> | 400   |


    And "<part_no>" has "NEXT_DATE" as "7 mondays time" new schema
    And pool "<pool_no>" has attendance date as "7 mondays time" new schema

    When the user searches for juror record "<part_no>" from the global search bar
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
    And I click no, to process the summons reply later
    Then the view summons reply page is displayed
    And I click the process reply button
    And I click continue on the juror summons reply page
    And there is an error message with the text "Please select a response process type"

    Examples:
      | user          | part_no   | pool_no   |
      | MODTESTBUREAU | 641500987 | 415170501 |