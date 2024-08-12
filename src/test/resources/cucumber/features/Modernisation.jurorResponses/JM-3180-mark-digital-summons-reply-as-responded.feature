Feature: JM-3180

  @JurorTransformation @NewSchemaConverted
  Scenario Outline: Mark Digital Summons Reply As Responded

    Given I am on "Public" "ithc"

    Given a bureau owned pool is created with jurors
      | court | juror_number  	    | pool_number	    | att_date_weeks_in_future	| owner |
      | 415   | <juror_number> 	    | <pool_number>     | 5				            | 400	|

    And juror "<juror_number>" has "TITLE" as "Mr" new schema
    And juror "<juror_number>" has "FIRST_NAME" as "FNAME" new schema
    And juror "<juror_number>" has "LAST_NAME" as "LNAME" new schema

    And I submit a digital response with reasonable adjustment
      | part_no	         | pool_number  | last_name	| postcode	| email  | adjustmentNeededCap     | details                       |
      | <juror_number>   | <pool_number>| LNAME  	| CH2 2AA	| <email>| <adjustmentNeededCap>   | Reasonable adjustment detail  |

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
    When the user searches for juror record "<juror_number>" from the global search bar
    And I see the juror status on the juror record screen has updated to "Responded"

    Examples:
      | user          | juror_number| pool_number | email     | adjustmentNeeded   | adjustmentFullCaps    | adjustmentFull          | adjustmentNeededCap|
      | MODTESTBUREAU | 041500134   | 415300234   | e@mail.com| limited mobility   | L - LIMITED MOBILITY  | L - Limited mobility    | Limited mobility   |

  @JurorTransformation @NewSchemaConverted
  Scenario Outline: Cancel Marking Digital Summons Reply As Responded
    Given I am on "Public" "test"

    Given a bureau owned pool is created with jurors
      | court | juror_number  	    | pool_number	    | att_date_weeks_in_future	| owner |
      | 415   | <juror_number> 	    | <pool_number>     | 5				            | 400	|

    And juror "<juror_number>" has "TITLE" as "Mr" new schema
    And juror "<juror_number>" has "FIRST_NAME" as "FNAME" new schema
    And juror "<juror_number>" has "LAST_NAME" as "LNAME" new schema

    And I submit a digital response with reasonable adjustment
      |part_no	      |pool_number  |last_name	|postcode	|email 	|adjustmentNeededCap  |details                       |
      |<juror_number> |<pool_number>|LNAME  	|CH2 2AA	|<email>|<adjustmentNeededCap>|Reasonable adjustment detail  |

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
      | user          | juror_number| pool_number | email     | adjustmentNeeded   | adjustmentFullCaps    | adjustmentFull          | adjustmentNeededCap|
      | MODTESTBUREAU | 041500135   | 415300235   | e@mail.com| limited mobility   | L - LIMITED MOBILITY  | L - Limited mobility    | Limited mobility   |

  @JurorTransformation @NewSchemaConverted
  Scenario Outline: Mark Digital Summons Reply As Responded - Mark As Responded Validation
    Given I am on "Public" "test"

    Given a bureau owned pool is created with jurors
      | court | juror_number  	    | pool_number	    | att_date_weeks_in_future	| owner |
      | 415   | <juror_number> 	    | <pool_number>     | 5				            | 400	|

    And juror "<juror_number>" has "TITLE" as "Mr" new schema
    And juror "<juror_number>" has "FIRST_NAME" as "FNAME" new schema
    And juror "<juror_number>" has "LAST_NAME" as "LNAME" new schema

    And I submit a digital response with reasonable adjustment
      |part_no	      |pool_number  |last_name	|postcode	|email 	|adjustmentNeededCap  |details                       |
      |<juror_number> |<pool_number>|LNAME  	|CH2 2AA	|<email>|<adjustmentNeededCap>|Reasonable adjustment detail  |

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
      | user          | juror_number  | pool_number   | email     | adjustmentNeeded   | adjustmentFullCaps    | adjustmentFull          | adjustmentNeededCap|
      | MODTESTBUREAU | 041500136     | 415300236     | e@mail.com| limited mobility   | L - LIMITED MOBILITY  | L - Limited mobility    | Limited mobility   |

  @JurorTransformation @NewSchemaConverted
  Scenario Outline: Mark Digital Summons Reply As Responded - Confirm Mark As Responded validation

    Given I am on "Public" "test"

    Given a bureau owned pool is created with jurors
      | court | juror_number  	    | pool_number	    | att_date_weeks_in_future	| owner |
      | 415   | <juror_number> 	    | <pool_number>     | 5				            | 400	|

    And juror "<juror_number>" has "TITLE" as "Mr" new schema
    And juror "<juror_number>" has "FNAME" as "FNAME" new schema
    And juror "<juror_number>" has "LNAME" as "LNAME" new schema

    And I submit a digital response with reasonable adjustment
      |part_no	      |pool_number  |last_name	|postcode	|email 	|adjustmentNeededCap  |details                       |
      |<juror_number> |<pool_number>|LNAME  	|CH2 2AA	|<email>|<adjustmentNeededCap>|Reasonable adjustment detail  |

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
      | user          | juror_number  | pool_number | email     | adjustmentNeeded   | adjustmentFullCaps    | adjustmentFull          | adjustmentNeededCap|
      | MODTESTBUREAU | 041500137     | 415300237   | e@mail.com| limited mobility   | L - LIMITED MOBILITY  | L - Limited mobility    | Limited mobility   |