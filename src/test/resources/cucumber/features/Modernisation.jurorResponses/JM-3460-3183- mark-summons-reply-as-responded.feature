Feature: JM-3460 JM-3183

  @JurorTransformationMulti @NewSchemaConverted
  Scenario Outline: Mark Paper Summons Reply As Responded
    Given I am on "Bureau" "test"
    And I log in as "<user>"

    Given a bureau owned pool is created with jurors
      | court | juror_number  	    | pool_number	    | att_date_weeks_in_future	| owner |
      | 415   | <juror_number> 	    | <pool_number>     | 7				            | 400	|

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
      | user          | juror_number  | pool_number   |
      | MODTESTBUREAU | 041500140     | 415300240     |

  @JurorTransformationMulti @NewSchemaConverted
  Scenario Outline: Cancel Marking Paper Summons Reply As Responded
    Given I am on "Bureau" "test"
    And I log in as "<user>"

    Given a bureau owned pool is created with jurors
      | court | juror_number  	    | pool_number	    | att_date_weeks_in_future	| owner |
      | 415   | <juror_number> 	    | <pool_number>     | 7				            | 400	|

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
    And I click no, to process the summons reply later
    Then the view summons reply page is displayed
    And I click the process reply button
    Then I mark the reply as responded
    And I click continue on the juror summons reply page
    Then I click the cancel link
    And I see the juror status on the juror record screen is "Summoned"

    Examples:
      | user          | juror_number  | pool_number   |
      | MODTESTBUREAU | 041500141     | 415300241     |

  @JurorTransformationMulti @NewSchemaConverted
  Scenario Outline: Mark Paper Summons Reply As Responded - Mark As Responded Validation
    Given I am on "Bureau" "test"
    And I log in as "<user>"

    Given a bureau owned pool is created with jurors
      | court | juror_number  	    | pool_number	    | att_date_weeks_in_future	| owner |
      | 415   | <juror_number> 	    | <pool_number>     | 7				            | 400	|

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
    And I click no, to process the summons reply later
    Then the view summons reply page is displayed
    And I click the process reply button
    Then I mark the reply as responded
    And I click continue on the juror summons reply page
    And I confirm I want to mark the reply as responded
    And there is an error message with the text "Confirm that the reply can be marked as 'responded'"

    Examples:
      | user          | juror_number  | pool_number   |
      | MODTESTBUREAU | 041500142     | 415300242     |

  @JurorTransformationMulti @NewSchemaConverted
  Scenario Outline: Mark Paper Summons Reply As Responded - Confirm Mark As Responded validation
    Given I am on "Bureau" "test"
    And I log in as "<user>"

    Given a bureau owned pool is created with jurors
      | court | juror_number  	    | pool_number	    | att_date_weeks_in_future	| owner |
      | 415   | <juror_number> 	    | <pool_number>     | 7				            | 400	|

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
    And I click no, to process the summons reply later
    Then the view summons reply page is displayed
    And I click the process reply button
    And I click continue on the juror summons reply page
    And there is an error message with the text "Please select a response process type"

    Examples:
      | user          | juror_number  | pool_number   |
      | MODTESTBUREAU | 041500143     | 415300243     |