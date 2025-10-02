Feature: JS-290

  @JurorTransformationMulti
  Scenario Outline: Deferral letter - jurors address is updated while letter is pending (paper response)

    Given I am on "Bureau" "ithc"

    When a bureau owned pool is created with jurors
      | court | juror_number  | pool_number   | att_date_weeks_in_future   | owner  |
      | 415   | <juror_number>| <pool_number> | 5                          | 400    |

    And I log in as "<user>"

    And the user searches for juror record "<juror_number>" from the global search bar
    And I record a happy path deferral paper summons response

    Then I click the process reply button
    Then I set the radio button to "Deferral request"
    And I click continue on the process reply page
    And I set the "first" choice to "5" Mondays in the future
    And I set the "second" choice to "7" Mondays in the future
    And I set the "third" choice to "9" Mondays in the future
    And I click continue on the process reply page
    And I select "O - OTHER" from the "Reason for the deferral request" dropdown
    And I choose the "Choose a different date" radio button
    Then I set the "alternate" choice to "35" Mondays in the future
    And I press the "Continue" button
    And I press the "Put in deferral maintenance" button
    And I verify the banner message "Deferral granted" on the page

    And I verify address "<juror_address>" exists in print record for juror "<juror_number>"
    And I verify address "NEW UPDATED ADDRESS" does not exist in print record for juror "<juror_number>"

    And the user searches for juror record "<juror_number>" from the global search bar
    When I click on the "Juror details" link
    When I click on the "Add or change" link
    When I press change juror change address button
    And I set "Town or city" to "NEW UPDATED ADDRESS"
    And I press the "Review Edit" button
    And I press the "Save" button
    And I see "<juror_number>" on the page

    And I verify address "NEW UPDATED ADDRESS" exists in print record for juror "<juror_number>"
    And I verify address "<juror_address>" does not exist in print record for juror "<juror_number>"

    Examples:
      | juror_number  | pool_number | user          | juror_address     |
      |  041573613    | 415984413   | MODTESTBUREAU | ADDRESS LINE FOUR |

  @JurorTransformationMulti
  Scenario Outline: Deferral letter - jurors address is updated while letter is pending (digital response)

    Given I am on "Public" "ithc"

    When a bureau owned pool is created with jurors
      | court | juror_number  | pool_number   | att_date_weeks_in_future   | owner  |
      | 415   | <juror_number>| <pool_number> | 5                          | 400    |

    And juror "<juror_number>" has "LAST_NAME" as "<last_name>" new schema
    And juror "<juror_number>" has "POSTCODE" as "<postcode>" new schema

    And I have submitted a first party English deferral response
      | part_no	        | pool_number   | last_name		| postcode	| email   |
      | <juror_number>  | <pool_number>	| <last_name>	| <postcode>| <email> |

    Given I am on "Bureau" "ithc"

    And I log in as "<user>"

    And the user searches for juror record "<juror_number>" from the global search bar

    And I click on the "Summons reply" link
    And I click on the "View summons reply" link
    Then I click the process reply button
    Then I set the radio button to "Deferral request"
    And I click continue on the process reply page

    And I select "O - OTHER" from the "Reason for the deferral request" dropdown
    And I choose the "Choose a different date" radio button
    Then I set the "alternate" choice to "35" Mondays in the future
    And I press the "Continue" button
    And I press the "Put in deferral maintenance" button
    And I verify the banner message "Deferral granted" on the page

    And I verify address "<juror_address>" exists in print record for juror "<juror_number>"
    And I verify address "NEW UPDATED ADDRESS" does not exist in print record for juror "<juror_number>"

    And the user searches for juror record "<juror_number>" from the global search bar
    When I click on the "Juror details" link
    When I click on the "Add or change" link
    When I press change juror change address button
    And I set "Town or city" to "NEW UPDATED ADDRESS"
    And I press the "Review Edit" button
    And I press the "Save" button
    And I see "<juror_number>" on the page

    And I verify address "NEW UPDATED ADDRESS" exists in print record for juror "<juror_number>"
    And I verify address "<juror_address>" does not exist in print record for juror "<juror_number>"

    Examples:
      | juror_number  | pool_number | user          | juror_address     | last_name | postcode  | email       |
      |  041573615    | 415984415   | MODTESTBUREAU | ADDRESS LINE FOUR | JONES     | CH2 2AA   | e@mail.com  |

  @JurorTransformationWIP
  Scenario Outline: Withdrawal letter - jurors address is updated while letter is pending

    #this will fail due to JS-541 - put back in multi when fixed

    Given I am on "Bureau" "ithc"

    When a bureau owned pool is created with jurors
      | court | juror_number  | pool_number   | att_date_weeks_in_future   | owner |
      | 415   | <juror_number>| <pool_number> | 5                          | 400   |

    And I log in as "<user>"
    And the user searches for juror record "<juror_number>" from the global search bar
    Then I press the "Enter summons reply" button
    And I see "Juror details" on the page
    And I enter a date of birth in the summons reply that will make the juror too young
    And I press the "Continue" button
    And I see "Check the date of birth" on the page
    And I see "Is their date of birth correct?" on the page
    And I click on the "Yes" link

    And the user searches for juror record "<juror_number>" from the global search bar
    And I see the juror status has updated to "Disqualified"

    And I verify address "<juror_address>" exists in print record for juror "<juror_number>"
    And I verify address "NEW UPDATED ADDRESS" does not exist in print record for juror "<juror_number>"

    When I click on the "Juror details" link
    When I click on the "Add or change" link
    When I press change juror change address button
    And I set "Town or city" to "NEW UPDATED ADDRESS"
    And I press the "Review Edit" button
    And I press the "Save" button
    And I see "<juror_number>" on the page

    And I verify address "NEW UPDATED ADDRESS" exists in print record for juror "<juror_number>"
    And I verify address "<juror_address>" does not exist in print record for juror "<juror_number>"

    Examples:
      | juror_number | pool_number | user          | juror_address     |
      | 041573614    | 415984414   | MODTESTBUREAU | ADDRESS LINE FOUR |

  @JurorTransformationMulti
  Scenario Outline: Deferral letter - jurors address is NOT updated on extracted letters

    Given I am on "Bureau" "ithc"

    When a bureau owned pool is created with jurors
      | court | juror_number  | pool_number   | att_date_weeks_in_future   | owner  |
      | 415   | <juror_number>| <pool_number> | 5                          | 400    |

    And I log in as "<user>"

    And the user searches for juror record "<juror_number>" from the global search bar
    And I record a happy path deferral paper summons response

    Then I click the process reply button
    Then I set the radio button to "Deferral request"
    And I click continue on the process reply page
    And I set the "first" choice to "5" Mondays in the future
    And I set the "second" choice to "7" Mondays in the future
    And I set the "third" choice to "9" Mondays in the future
    And I click continue on the process reply page
    And I select "O - OTHER" from the "Reason for the deferral request" dropdown
    And I choose the "Choose a different date" radio button
    Then I set the "alternate" choice to "35" Mondays in the future
    And I press the "Continue" button
    And I press the "Put in deferral maintenance" button
    And I verify the banner message "Deferral granted" on the page

    And I update juror "<juror_number>" to change the status of printed in order to resend letter

    And I verify address "<juror_address>" exists in print record for juror "<juror_number>"
    And I verify address "NEW UPDATED ADDRESS" does not exist in print record for juror "<juror_number>"

    And the user searches for juror record "<juror_number>" from the global search bar
    When I click on the "Juror details" link
    When I click on the "Add or change" link
    When I press change juror change address button
    And I set "Town or city" to "NEW UPDATED ADDRESS"
    And I press the "Review Edit" button
    And I press the "Save" button
    And I see "<juror_number>" on the page

    And I verify address "NEW UPDATED ADDRESS" does not exist in print record for juror "<juror_number>"
    And I verify address "<juror_address>" exists in print record for juror "<juror_number>"

    Examples:
      | juror_number  | pool_number | user          | juror_address     |
      |  041573616    | 415984416   | MODTESTBUREAU | ADDRESS LINE FOUR |