Feature: JM-3460 JM-3183

  @JurorTransformationMulti @NewSchemaConverted
  Scenario Outline: Process reply for juror with different catchment area to original summons
    Given I am on "Bureau" "demo"
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
    And I click on the "Add or change" link
    And I click on the "Change" link
    And I set "Postcode" to "SY2 6LU"
    And I press the "Review Edit" button
    And I press the "Continue" button
    
    And I see "Juror's address is outside the catchment area of the court they were summoned to" on the page
    And I click the process reply button
    Then I mark the reply as responded
    And I click continue on the juror summons reply page

    And I see "You may need to reassign this juror to a different court before you can finish processing this reply" on the page
    And I set the radio button to "Shrewsbury (452)"
    And I press the "Continue" button
    And I select one of the active pools available
    And I press the "Continue" button
    
    And I click the checkbox to mark the reply as responded
    And I confirm I want to mark the reply as responded
    And I see the juror record updated banner containing "Responded"
    When the user searches for juror record "<juror_number>" from the global search bar
    And I see the juror status on the juror record screen has updated to "Responded"
    And I see the court name on the juror record screen is "The Crown Court At Shrewsbury"

    Examples:
      | user          | juror_number  | pool_number   |
      | MODTESTBUREAU | 041568274     | 415388613     |