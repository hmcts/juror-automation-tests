Feature: JM-4186

  @JurorTransformationMulti
  Scenario Outline: Straight through paper summons reply - Happy Path

    Given I am on "Bureau" "test"

    Given the juror numbers have not been processed new schema
      |part_no   | pool_no   | owner  |
      |<part_no> | <pool_no> | 400    |

    And I log in as "<user>"

    And the user searches for juror record "<part_no>" from the global search bar
    Then I am on the Juror Record for juror "<part_no>"
    And I click the Enter summons reply button
    Then the juror details form is displayed
    And I enter a date of birth that will make the juror between 18 and 75
    When I click continue on the juror summons reply page
    Then the juror summons reply eligibility page is displayed
    When I answer the juror summons reply eligibility questions
    And I click continue on the juror summons reply page
    Then the juror summons reply types page is displayed
    When I set the radio button to "Can serve on date shown in summons"
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

    #Process straight through
    Then I see "Do you want to process this summons reply as responded now?" on the page
    Then I see "The juror’s answers mean this is a straight-through reply. So you can process it as responded now, or return later." on the page
    When I press the "Yes, process now" button
    Then I see "Your work" on the page
    And I see "Summons reply for <part_no> FNAMESEVENONEFIVE LNAMESEVENONEFIVE successfully processed: Responded" on the page

    And I click on the "<part_no>" link
    Then I see the Juror Record tag
    And the Enter summons reply button is not visible

    Examples:
      |part_no	|pool_no   |user         |
      |641500715|415170402 |MODTESTBUREAU|

  @JurorTransformationMulti
  Scenario Outline: Straight through paper summons reply - null criteria

    Given I am on "Bureau" "test"

    Given the juror numbers have not been processed new schema
      |part_no   | pool_no   | owner  |
      |<part_no> | <pool_no> | 400    |

    And "<part_no>" has "NEXT_DATE" as "7 mondays time"

    And I log in as "<user>"

    And the user searches for juror record "<part_no>" from the global search bar
    Then I am on the Juror Record for juror "<part_no>"
    And I click the Enter summons reply button
    Then the juror details form is displayed
    And I enter a date of birth that will make the juror between 18 and 75
    When I click continue on the juror summons reply page
    Then the juror summons reply eligibility page is displayed

    #leave eligibility questions unanswered
    And I click continue on the juror summons reply page
    Then the juror summons reply types page is displayed
    When I set the radio button to "Can serve on date shown in summons"
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

#    Ordinarily process straight through appears here
    Then I do not see "Do you want to process this summons reply as responded now?" on the page
    Then I do not see "The juror’s answers mean this is a straight-through reply. So you can process it as responded now, or return later." on the page

    Examples:
      |part_no	|pool_no   |user         |
      |641500281|415170501 |MODTESTBUREAU|