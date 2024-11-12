Feature: JM-3457 and JM-3456 - Digital Response

  @JurorTransformationWIP
  Scenario Outline: Happy path test to check juror reasonable adjustment digital

    Given I am on "Public" "ithc"

    Given a bureau owned pool is created with jurors
      | court | juror_number  	    | pool_number	    | att_date_weeks_in_future	| owner |
      | 415   | <juror_number> 	    | <pool_number>     | 5				            | 400	|

    And juror "<juror_number>" has "TITLE" as "Mr" new schema
    And juror "<juror_number>" has "FNAME" as "FNAME" new schema
    And juror "<juror_number>" has "LNAME" as "LNAME" new schema

    And I submit a digital response with reasonable adjustment
      | part_no	       | pool_number    | last_name	| postcode	| email   | adjustmentNeededCap  | details             |
      | <juror_number> | <pool_number>	| LNAME  	| CH2 2AA	| <email> | <adjustmentNeededCap>| <adjustmentNeeded>  |

    Given I am on "Bureau" "ithc"

    And I log in as "MODTESTBUREAU"

    When the user searches for juror record "<juror_number>" from the global search bar
    And I click the summons reply tab
    When I click on the view summons reply link
    And I click the juror details adjustments tab

    Then I see the adjustments status is "Attention\\n<adjustmentFullCaps>\\n<adjustmentNeeded>"

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
      | jurorName             | Mr FNAME LNAME        |
      | jurorNumber           | <juror_number>        |
      | jurorMainPhone        | 01234561234           |
      | jurorEmail            | <email>               |
      | jurorAdjustmentReason | <adjustmentFull>      |
      | jurorAdjustment       | <adjustmentNeeded>    |

    And on the page I see
      | text|
      |Optic ticket number              |
      |Enter Optic reference            |
      |This will be an 8 digit number - for example, 37540739|

    #for this to work in Jenkins, we need a later version of Selenium which includes the setPermissions method and would allow this to work. Commenting out for now
#    When I press the "Copy juror information" button

#    Currently a bug, nothing is copied to clipboard following button press
#    Then I can paste the following information "Juror information\\n\\nName: Rev Eleanor Milne\\nJuror number: 111111003\\nMain phone: 44135101-1110\\nEmail: Milne0@email.com\\n\\nDisabilities or impairments\\nType: <jurorAdjustmentFull>\\nDetail: <jurorAdjustmentNeeded>"

    When I enter the optic reference number "12345678"
    And I press the "Save" button

    When I click the juror details adjustments tab

    Then I see the adjustments status is "Attention\\n<adjustmentFullCaps>\\n<adjustmentNeeded>"
    And The newly created optic reference "12345678" is displayed

    And I see the reply status has updated to "Awaiting court reply"

    Examples:
      | juror_number  | pool_number   | email     | adjustmentNeeded   | adjustmentFullCaps    | adjustmentFull          | adjustmentNeededCap    |
      | 041500138     | 415300238     | e@mail.com| limited mobility   | L - LIMITED MOBILITY  | L - Limited mobility    | Limited mobility       |
      | 041500138     | 415300238     | e@mail.com| vision impairment  | V - VISUAL IMPAIRMENT | V - Visual impairment   | Severe sight impairment|
      | 041500138     | 415300238     | e@mail.com| hearing loss       | H - HEARING LOSS      | H - Hearing loss        | Hearing loss           |


  @JurorTransformationWIP
  Scenario Outline: Errors and warnings on check court can accommodate digital

    Given I am on "Public" "ithc"

    Given a bureau owned pool is created with jurors
      | court | juror_number  	    | pool_number	    | att_date_weeks_in_future	| owner |
      | 415   | <juror_number> 	    | <pool_number>     | 5				            | 400	|

    And I submit a digital response with reasonable adjustment
      | part_no	       | pool_number    | last_name	| postcode	| email   | adjustmentNeededCap     | details             |
      | <juror_number> | <pool_number>	| lname  	| CH2 2AA	| <email> | <adjustmentNeededCap>   | <adjustmentNeeded>  |

    Given I am on "Bureau" "ithc"
    And I log in as "<user>"

    When the user searches for juror record "<juror_number>" from the global search bar
    And I click the summons reply tab
    When I click on the view summons reply link
    And I click the juror details adjustments tab
    Then I see the adjustments status is "Attention\\n<adjustmentFullCaps>\\n<adjustmentNeeded>"
    When I press the "Check court can accommodate" button
    Then I am on the check can accommodate screen

    When I press the "Save" button

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

    When I click on the "Cancel" link

    And I click the juror details adjustments tab
    Then I see the adjustments status is "Attention\\n<adjustmentFullCaps>\\n<adjustmentNeeded>"
    And I see the reply status has updated to "TO DO"

    Examples:
      | user          | juror_number  | pool_number   | email      | adjustmentNeededCap | adjustmentFullCaps   | adjustmentNeeded             |
      | MODTESTBUREAU | 041500139     | 415300239     | e@mail.com | Limited mobility    | L - LIMITED MOBILITY | Reasonable adjustment detail |