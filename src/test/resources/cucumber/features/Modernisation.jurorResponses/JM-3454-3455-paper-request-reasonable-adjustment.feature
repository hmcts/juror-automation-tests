Feature: JM-3457 and JM-3456 - Paper Response

  @JurorTransformationMulti @NewSchemaConverted
  Scenario Outline: Happy path test to check juror reasonable adjustment - paper
    Given I am on "Bureau" "test"

    Given a bureau owned pool is created with jurors
      | court  |juror_number  	| pool_number	   | att_date_weeks_in_future	| owner |
      | 452    |<juror_number>  | <pool_number>    | 5				            | 400	|

    And I log in as "<user>"

    When the user searches for juror record "<juror_number>" from the global search bar
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
    And I set "What help does the juror need at court?" to "Childcare"

    And I click continue on the juror summons reply page

    #confirm/sign
    Then the juror summons reply Signature page is displayed
    When I select that the summons reply has been signed
    And I click done on the juror summons reply page

    When the user searches for juror record "<juror_number>" from the global search bar
    And I click the summons reply tab
    When I click on the view summons reply link
    And I click the juror details adjustments tab

    Then I see the adjustments status is "Attention\\n<jurorAdjustmentFull>\\n<jurorAdjustmentNeeded>"
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
      | jurorName             | fname lname                 |
      | jurorNumber           | <juror_number>              |
      | jurorMainPhone        | 0777777777                  |
      | jurorEmail            | test@test.com               |
      | jurorAdjustmentReason | <jurorAdjustmentFull>       |
      | jurorAdjustment       | <jurorAdjustmentNeeded>     |

    And on the page I see
      | text|
      |Optic ticket number              |
      |Enter Optic reference            |
      |This will be an 8 digit number - for example, 37540739|

    #for this to work in Jenkins, we need a later version of Selenium which includes the setPermissions method and would allow this to work. Commenting out for now
#    When I press the "Copy juror information" button

#    Currently a bug, nothing is copied to clipboard following button press JM-4173
#    Then I can paste the following information "Juror information\\n\\nName: Rev Eleanor Milne\\nJuror number: 111111006\\nMain phone: 44135101-1110\\nEmail: Milne0@email.com\\n\\nDisabilities or impairments\\nType: <jurorAdjustmentFull>\\nDetail: <jurorAdjustmentNeeded>"

    When I enter the optic reference number "12345678"
    And I press the "Save" button

    When I click the juror details adjustments tab
    Then I see the adjustments status is "Attention\\n<jurorAdjustmentFull>\\n<jurorAdjustmentNeeded>"
    And The newly created optic reference "12345678" is displayed

    And I see the reply status has updated to "AWAITING COURT REPLY"

    Examples:
      | user          | juror_number  | pool_number | jurorAdjustmentNeeded | jurorAdjustmentFull          |
      | MODTESTBUREAU | 045200008     | 452300004   | Childcare             | C - Childcare problems       |

