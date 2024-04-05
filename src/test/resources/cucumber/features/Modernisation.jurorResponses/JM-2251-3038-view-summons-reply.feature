Feature: JM-2251 JM-3038

  @JurorTransformationMulti @NewSchemaConverted
  Scenario Outline: Test to view paper summons reply
    Given I am on "Bureau" "test"

    #reset data to summoned state
    Given a bureau owned pool is created with jurors
      | court |juror_number    | pool_number  | att_date_weeks_in_future| owner |
      | 452   |<juror_number>  | <pool_number>| 5				        | 400	|

    And juror "<juror_number>" has "FIRST_NAME" as "FNAMENINENINESIX" new schema
    And juror "<juror_number>" has "LAST_NAME" as "<last_name>" new schema
    And juror "<juror_number>" has "POSTCODE" as "<postcode>" new schema

    #log on as bureau user
    And I log in as "<user>"

    #search for and review paper summons
    When the user searches for juror record "<juror_number>" from the global search bar

    #record paper summons
    And I record a happy path paper summons response

    Then I see "Do you want to process this summons reply as responded now?" on the page
    When I click on the "No, skip and process later" link

    When the user searches for juror record "<juror_number>" from the global search bar
    Then the view summons reply page is displayed

    And I click on the "Summons reply" link
    And I click on the "View summons reply" link
    And I see "SUMMONS REPLY" on the page

    Then I see the following summons reply details under the juror details tab
      | jurorName      | FNAMENINENINESIX <last_name>               |
      | jurorAddress   | address\nAddress Line Four\n<postcode> |
      | jurorDob       | 18 Jul 1976 (Juror will be 47 years old)     |
      | jurorMainPhone | 0777777777                                   |
      | jurorAltPhone  | 0777777771                                   |
      | jurorEmail     | test@test.com                                |

    #eligibility
    When I click the juror details eligibility tab
    Then I see the following summons reply details under the eligibility tab
      | jurorResidency   | Pass |
      | jurorMha         | Pass |
      | jurorMca         | Pass |
      | jurorBail        | Pass |
      | jurorConvictions | Pass |

    #deferral
    When I click the juror details deferral tab
    Then I see the deferral status is "None requested"

    #cjs
    When I click the juror details CJS tab
    Then I see the CJS status is "N/A"

    #reasonable adjustments
    When I click the juror details adjustments tab
    Then I see the adjustments status is "N/A"

    #signature
    When I click the juror details signature tab
    Then I see the signature status is "Yes"

    Examples:
      |juror_number |pool_number  |last_name 	      |postcode |user          |
      |045200028    |452300027 	  |LNAMENINENINESIX   |CH1 2AN	|MODTESTBUREAU |


  @JurorTransformationMulti @NewSchemaConverted
  Scenario Outline: Test to view paper summons reply with name change

    Given I am on "Bureau" "test"

    Given a bureau owned pool is created with jurors
      | court |juror_number    | pool_number  | att_date_weeks_in_future| owner |
      | 452   |<juror_number>  | <pool_number>| 5				        | 400	|

    And juror "<juror_number>" has "LAST_NAME" as "Lastname" new schema
    And juror "<juror_number>" has "FIRST_NAME" as "Firstname" new schema
    And juror "<juror_number>" has "ADDRESS_LINE_1" as "570 STREET NAME" new schema
    And juror "<juror_number>" has "POSTCODE" as "<postcode>" new schema

    #log on as bureau user
    And I log in as "<user>"

    #search for and review paper summons
    When the user searches for juror record "<juror_number>" from the global search bar

    #record paper summons
    And I record a paper summons response with reasonable adjustment of "C - Caring Responsibilities"

    Then I see the following summons reply details under the juror details tab
      | jurorName      | Firstname Lastname                           |
      | jurorAddress   | 570 STREET NAME\nAddress Line Four\n<postcode>  |
      | jurorDob       | 18 Jul 1976 (Juror will be 47 years old)     |
      | jurorMainPhone | 0777777777                                   |
      | jurorAltPhone  | 0777777771                                   |
      | jurorEmail     | test@test.com                                |

    Examples:
      |juror_number	|pool_number|postcode 	|user          |
      |045200029    |452300028  |CH1 2AN	|MODTESTBUREAU |

  @JurorTransformationMulti @NewSchemaConverted
  Scenario Outline: Test to view paper summons reply with CJS and reasonable adjustments

    Given I am on "Bureau" "test"

    Given a bureau owned pool is created with jurors
      | court |juror_number    | pool_number  | att_date_weeks_in_future| owner |
      | 452   |<juror_number>  | <pool_number>| 5				        | 400	|

    #log on as bureau user
    And I log in as "<user>"


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
    When I set the radio button to "Deferral request"
    And I click continue on the juror summons reply page

   #cjs
    Then the juror summons reply CJS employment page is displayed
    And I set the radio button to "Yes"
    And I check the "Police force" checkbox
    And I set "Which police force?" to "West Midlands Police"
    And I click continue on the juror summons reply page

#reasonable adjustments
    Then the juror summons reply reasonable adjustments page is displayed
    When I select that the juror does need adjustments
    And I select "C - Caring Responsibilities" from the adjustments reason dropdown
    And I set "What help does the juror need at court?" to "Reasonable adjustments reasons"

    And I click continue on the juror summons reply page

#confirm/sign
    Then the juror summons reply Signature page is displayed
    And I set the radio button to "No"
    And I click done on the juror summons reply page


    When I click the juror details deferral tab
    Then I see the deferral status is "Attention\\nDeferral request"
    When I click the juror details CJS tab
    Then I see the CJS status is "Attention\\nPolice Force\\nWest Midlands Police"
    When I click the juror details adjustments tab
    Then I see the adjustments status is "Attention\\nC - Caring Responsibilities\\nReasonable adjustments reasons"
    When I click the juror details signature tab
    Then I see the signature status is "Required"

    Examples:
      |juror_number	|pool_number|user          |
      |045200030    |452300029 	|MODTESTBUREAU |