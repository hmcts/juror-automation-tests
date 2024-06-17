Feature: JM-4082

  @JurorTransformationMulti @NewSchemaConverted
  Scenario Outline: End to End test to check juror reasonable adjustment - Paper Response

    Given I am on "Bureau" "test"

    And I log in as "<user>"

    Given a bureau owned pool is created with jurors
      | court |juror_number  	    | pool_number	    | att_date_weeks_in_future	| owner |
      | 452   |<juror_number> 	    | <pool_number>     | 5				            | 400	|

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
    When I set the radio button to "Can serve on date shown in summons"
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

    And I click the juror details adjustments tab
    When I press the "Check court can accommodate" button
    Then I am on the check can accommodate screen

    And on the page I see
      | text|
      |How to ask the court if they can accommodate reasonable adjustments for this juror|
      |Create a ticket in Optic                                                          |
      |Copy and paste the juror information below into the Optic ticket                  |
      |Submit the Optic ticket                                                           |
      |Enter the Optic reference number here and save                                    |

    And I see the following juror information on the check can accommodate screen
      | jurorName             | fname lname            |
      | jurorNumber           | <juror_number>         |
      | jurorMainPhone        | 077777777777             |
      | jurorEmail            | test@test.com          |
      | jurorAdjustmentReason | <jurorAdjustmentFull>  |
      | jurorAdjustment       | <jurorAdjustmentNeeded>|

    And on the page I see
      | text|
      |Optic ticket number              |
      |Enter Optic reference            |
      |This will be an 8 digit number - for example, 37540739|

    #for this to work in Jenkins, we need a later version of Selenium which includes the setPermissions method and would allow this to work. Commenting out for now
#    When I press the "Copy juror information" button
  #  When I enter the optic reference number "12345678"
    And I press the "Save" button

    #   Check Missing Optic reference Number error
    Then I see "Please add an optic reference" on the page
    And I see "Optic reference is missing" on the page

#   Check Optic reference number less than 8 characters error
    When I enter the optic reference number "123456"
    And I press the "Save" button
    Then I see "Enter the Optic reference as an 8 digit number - you cannot enter letters or special characters" on the page

#   Check Optic reference number more than 8 characters error
    When I enter the optic reference number "123456789"
    And I press the "Save" button
    Then I see "Enter the Optic reference as an 8 digit number - you cannot enter letters or special characters" on the page

#   Check Optic reference number with special characters or letters error
    When I enter the optic reference number "123abc!"
    And I press the "Save" button
    Then I see "Enter the Optic reference as an 8 digit number - you cannot enter letters or special characters" on the page

    When I enter the optic reference number "12345678"
    And I press the "Save" button
    And I click the juror details adjustments tab
    And I see "12345678" in the same row as "Optic reference"
    Examples:
      | user          | juror_number   | pool_number   | jurorAdjustmentNeeded   | jurorAdjustmentFull          |
      | MODTESTBUREAU | 045200012      | 452300008     | Childcare               |C - Caring Responsibilities   |