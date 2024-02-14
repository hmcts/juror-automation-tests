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


  @JurorTransformationWIP @JM-4932 @JM-5471 @NewSchemaConverted
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
    And I record an unhappy path paper summons response

    #fails due to defect JM-4932
    Then I see the following summons reply details under the juror details tab
      | jurorName      | New\nChanged fname Changed lname                       |
      | jurorAddress   | Changed address line 1\nAddress Line Four\n<postcode>  |
      | jurorDob       | 18 Jul 1976 (Juror will be 47 years old)     |
      | jurorMainPhone | 0777777777                                   |
      | jurorAltPhone  | 0777777771                                   |
      | jurorEmail     | test@test.com                                |
    And I see a previous name of "Previous\\nFirstname Lastname"

    Examples:
      |juror_number	|pool_number|postcode 	|user          |
      |045200029    |452300028  |CH1 2AN	|MODTESTBUREAU |

  @JurorTransformationWIP @NewSchemaConverted @JM-5471
  Scenario Outline: Test to view paper summons reply with CJS and reasonable adjustments

    Given I am on "Bureau" "test"

    Given a bureau owned pool is created with jurors
      | court |juror_number    | pool_number  | att_date_weeks_in_future| owner |
      | 452   |<juror_number>  | <pool_number>| 5				        | 400	|

    #log on as bureau user
    And I log in as "<user>"

    #search for and review paper summons
    When the user searches for juror record "<juror_number>" from the global search bar

    #fails due to JM-5471
    #record paper summons
    And I record an unhappy path paper summons response

    When I click the juror details deferral tab
    Then I see the deferral status is "Attention\\nDeferral request"
    When I click the juror details CJS tab
    Then I see the CJS status is "Attention\\nPolice Force\\nWest Midlands Police"
    When I click the juror details adjustments tab
    Then I see the adjustments status is "Attention\\nC - Childcare problems\\nReasonable adjustments reasons"
    When I click the juror details signature tab
    Then I see the signature status is "Required"

    Examples:
      |juror_number	|pool_number|user          |
      |045200030    |452300029 	|MODTESTBUREAU |