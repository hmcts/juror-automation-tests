Feature: JM-3180

  @JurorTransformationWIP @NewSchemaConverted @JurorDigitalNotConverted
  Scenario Outline: Mark Digital Summons Reply As Responded

    Given I am on "Public" "test"

    Given the juror numbers have not been processed new schema
      | part_no   | pool_no 	| owner |
      | <part_no> |<pool_no>	| 400 	|



    And juror "<juror_number>" has "TITLE" as "Mr" new schema
    And juror "<juror_number>" has "FIRST_NAME" as "FNAME" new schema
    And juror "<juror_number>" has "LAST_NAME" as "LNAME" new schema

    And I submit a digital response with reasonable adjustment
      |part_no	  |pool_number  |last_name	|postcode	|email 	|adjustmentNeededCap  |details                       |
      |<part_no>  |<pool_no>	|LNAME  	|CH1 2AN	|<email>|<adjustmentNeededCap>|Reasonable adjustment detail  |

    Given I am on "Bureau" "test"
    And I log in as "<user>"

    When the user searches for juror record "<juror_number>" from the global search bar
    Then I click the summons reply tab
    And I click on the view summons reply link
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
      | user          | part_no   | pool_no   | email     | adjustmentNeeded   | adjustmentFullCaps    | adjustmentFull          | adjustmentNeededCap|
      | MODTESTBUREAU | 641500477 | 415170501 | e@mail.com| limited mobility   | L - LIMITED MOBILITY  | L - Limited mobility    | Limited mobility   |

  @JurorTransformationWIP @NewSchemaConverted @JurorDigitalNotConverted
  Scenario Outline: Cancel Marking Digital Summons Reply As Responded
    Given I am on "Public" "test"

    Given the juror numbers have not been processed new schema
      | part_no   | pool_no 	| owner |
      | <part_no> |<pool_no>	| 400 	|



    And juror "<juror_number>" has "TITLE" as "Mr" new schema
    And juror "<juror_number>" has "FIRST_NAME" as "FNAME" new schema
    And juror "<juror_number>" has "LAST_NAME" as "LNAME" new schema

    And I submit a digital response with reasonable adjustment
      |part_no	  |pool_number  |last_name	|postcode	|email 	|adjustmentNeededCap  |details                       |
      |<part_no>  |<pool_no>	|LNAME  	|CH1 2AN	|<email>|<adjustmentNeededCap>|Reasonable adjustment detail  |

    Given I am on "Bureau" "test"
    And I log in as "<user>"

    When the user searches for juror record "<juror_number>" from the global search bar
    Then I click the summons reply tab
    And I click on the view summons reply link
    Then the view summons reply page is displayed
    And I click the process reply button
    Then I mark the reply as responded
    And I click continue on the juror summons reply page
    Then I click the cancel link
    And I see the juror status on the juror record screen is "Summoned"

    Examples:
      | user          | part_no   | pool_no   | email     | adjustmentNeeded   | adjustmentFullCaps    | adjustmentFull          | adjustmentNeededCap|
      | MODTESTBUREAU | 641500158 | 415170501 | e@mail.com| limited mobility   | L - LIMITED MOBILITY  | L - Limited mobility    | Limited mobility   |

  @JurorTransformationWIP @NewSchemaConverted @JurorDigitalNotConverted
  Scenario Outline: Mark Digital Summons Reply As Responded - Mark As Responded Validation
    Given I am on "Public" "test"

    Given the juror numbers have not been processed new schema
      | part_no   | pool_no 	| owner |
      | <part_no> |<pool_no>	| 400 	|



    And juror "<juror_number>" has "TITLE" as "Mr" new schema
    And juror "<juror_number>" has "FIRST_NAME" as "FNAME" new schema
    And juror "<juror_number>" has "LAST_NAME" as "LNAME" new schema

    And I submit a digital response with reasonable adjustment
      |part_no	  |pool_number  |last_name	|postcode	|email 	|adjustmentNeededCap  |details                       |
      |<part_no>  |<pool_no>	|LNAME  	|CH1 2AN	|<email>|<adjustmentNeededCap>|Reasonable adjustment detail  |

    Given I am on "Bureau" "test"
    And I log in as "<user>"

    When the user searches for juror record "<juror_number>" from the global search bar
    Then I click the summons reply tab
    And I click on the view summons reply link
    Then the view summons reply page is displayed
    And I click the process reply button
    Then I mark the reply as responded
    And I click continue on the juror summons reply page
    And I confirm I want to mark the reply as responded
    And there is an error message with the text "Confirm that the reply can be marked as 'responded'"

    Examples:
      | user          | part_no   | pool_no   | email     | adjustmentNeeded   | adjustmentFullCaps    | adjustmentFull          | adjustmentNeededCap|
      | MODTESTBUREAU | 641500384 | 415170501 | e@mail.com| limited mobility   | L - LIMITED MOBILITY  | L - Limited mobility    | Limited mobility   |

  @JurorTransformationWIP @NewSchemaConverted @JurorDigitalNotConverted
  Scenario Outline: Mark Digital Summons Reply As Responded - Confirm Mark As Responded validation

    Given I am on "Public" "test"

    Given the juror numbers have not been processed new schema
      | part_no   | pool_no 	| owner |
      | <part_no> |<pool_no>	| 400 	|



    And juror "<juror_number>" has "TITLE" as "Mr" new schema
    And juror "<juror_number>" has "FNAME" as "FNAME" new schema
    And juror "<juror_number>" has "LNAME" as "LNAME" new schema

    And I submit a digital response with reasonable adjustment
      |part_no	  |pool_number  |last_name	|postcode	|email 	|adjustmentNeededCap  |details                       |
      |<part_no>  |<pool_no>	|LNAME  	|CH1 2AN	|<email>|<adjustmentNeededCap>|Reasonable adjustment detail  |

    Given I am on "Bureau" "test"
    And I log in as "<user>"

    When the user searches for juror record "<juror_number>" from the global search bar
    Then I click the summons reply tab
    And I click on the view summons reply link
    Then the view summons reply page is displayed
    And I click the process reply button
    And I click continue on the juror summons reply page
    And there is an error message with the text "Please select a response process type"

    Examples:
      | user          | part_no   | pool_no   | email     | adjustmentNeeded   | adjustmentFullCaps    | adjustmentFull          | adjustmentNeededCap|
      | MODTESTBUREAU | 641500146 | 415170501 | e@mail.com| limited mobility   | L - LIMITED MOBILITY  | L - Limited mobility    | Limited mobility   |