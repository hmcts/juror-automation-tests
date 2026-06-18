Feature: JS-934 - As a officer I want to be able to select what address to send a letter to if the juror has 1 on the juror record and the summons reply

  @JurorTransformationMulti @Bureau
  Scenario Outline: Use address on juror record when refusing excusal request if addresses do not match

    Given I am on "Bureau" "<environment>"

    When a bureau owned pool is created with jurors
      | court | juror_number  | pool_number     | att_date_weeks_in_future   | owner |
      | 415     | <juror_number>| <pool_number> | 5                          | 400  |

    And I log in as "<user>"
    And the user searches for juror record "<juror_number>" from the global search bar
    And I record an excusal request paper summons response
    And the user searches for juror record "<juror_number>" from the global search bar
    
    #change address
    And I click on the "Juror details" link
    And I click on the "Add or change" link

    And I click on change address link on the juror record
    And I set "Address line 1" to "25 CHANGED ADDRESS"
    And I set "Town or city" to "LONDONNNNN"
    And I press the "Review Edit" button
    And I set "Date of birth" to "02/03/1990"
    And I press the "Save" button

    And the user searches for juror record "<juror_number>" from the global search bar
    And I click on the "Summons reply" link
    And I click on the "View summons reply" link
    And I select the Deferral or Excusal tab from the summons reply page

    And I see "Letter received before this reply was processed" on the page
    And I see "The juror record address and the summons reply address are different. If the excusal is refused, the officer will choose where the refusal letter is sent." on the page

    And I press the "Process reply" button

    #select refuse excusal
    And I set the radio button to "Excusal - grant or refuse"
    Then I press the "Continue" button
    And I select "O - OTHER" from the "Reason for excusal request" dropdown
    And I set the radio button to "Refuse excusal"
    And I press the "Continue" button

    And I see "Addresses do not match. The juror sent a letter before the summons reply was processed." on the page
    And I click the use juror record address radio button
    And I press the "Continue" button
    And I see "Summons reply" on the page

    #check bulk print for address
    And I verify bulk print data detail_rec contains "25 CHANGED ADDRESS" for juror "<juror_number>"
    And I verify bulk print data detail_rec contains "LONDONNNNN" for juror "<juror_number>"

    Examples:
      | juror_number  | pool_number | user          | environment |
      |  041599886    | 415980529   | MODTESTBUREAU | test        |

  @JurorTransformationMulti
  Scenario Outline: Use address on summons reply when refusing excusal request if addresses do not match

    Given I am on "Bureau" "test"

    When a bureau owned pool is created with jurors
      | court | juror_number  | pool_number     | att_date_weeks_in_future   | owner |
      | 415     | <juror_number>| <pool_number> | 5                          | 400  |

    And I log in as "<user>"
    And the user searches for juror record "<juror_number>" from the global search bar
    And I record an excusal request paper summons response
    And the user searches for juror record "<juror_number>" from the global search bar

    #change address
    And I click on the "Juror details" link
    And I click on the "Add or change" link

    And I click on change address link on the juror record
    And I set "Address line 1" to "776 CHANGED ADDRESS"
    And I press the "Review Edit" button
    And I set "Date of birth" to "02/03/1990"
    And I press the "Save" button

    And the user searches for juror record "<juror_number>" from the global search bar
    And I click on the "Summons reply" link
    And I click on the "View summons reply" link
    And I select the Deferral or Excusal tab from the summons reply page

    And I see "Letter received before this reply was processed" on the page
    And I see "The juror record address and the summons reply address are different. If the excusal is refused, the officer will choose where the refusal letter is sent." on the page

    And I press the "Process reply" button

    #select refuse excusal
    And I set the radio button to "Excusal - grant or refuse"
    Then I press the "Continue" button
    And I select "O - OTHER" from the "Reason for excusal request" dropdown
    And I set the radio button to "Refuse excusal"
    And I press the "Continue" button

    And I see "Addresses do not match. The juror sent a letter before the summons reply was processed." on the page
    And I click the summons reply address radio button
    And I press the "Continue" button
    And I see "Summons reply" on the page

    #check bulk print for address
    And I verify bulk print data detail_rec contains "ADDRESS" for juror "<juror_number>"
    And I verify bulk print data detail_rec contains "ADDRESS LINE FOUR" for juror "<juror_number>"



    Examples:
      | juror_number  | pool_number | user          |
      |  041599888    | 415980519   | MODTESTBUREAU |
    
