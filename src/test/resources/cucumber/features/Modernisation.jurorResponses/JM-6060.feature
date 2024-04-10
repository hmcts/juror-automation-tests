Feature: JM-6060 - As a jury officer, I want to be able to add or change juror's bank details

  @JurorTransformation @NewSchemaConverted
  Scenario Outline: Change juror bank details happy path

    Given I am on "Bureau" "test"
    When a bureau owned pool is created with jurors
      | court |juror_number         | pool_number      | att_date_weeks_in_future | owner |
      | 415   |<juror_number>     | <pool_number>       | 5                      | 400  |

    Then a new pool is inserted for where record has transferred to the court new schema
      |part_no              | pool_no           | owner |
      |<juror_number>     | <pool_number>     | 415   |

    And I Confirm all the data in the record attendance table is cleared
    And I log in as "<user>"

    #set juror as responded
    And I update juror "<juror_number>" to have a status of responded in order to record attendance

    #check in jurors
    And I press the "Apps" button
    And I click on the "Juror management" link

    #Set valid note
    When the user searches for juror record "<juror_number>" from the global search bar
    And I click on the "Expenses" link
    And I see "Daily expenses" on the page
    And I press change juror bank details button
    And I press Add or Change internal note button
    And I set "Add a note" to "This is a test note"
    And I press the "Save" button
    Then I see "This is a test note" on the page

    #Set valid address
    When I press change juror change address button
    And I set "Address line 1" to "Line 1"
    And I set "Address line 2 (optional)" to "Line 2"
    And I set "Address line 3 (optional)" to "Line 3"
    And I set "Town or city" to "Town"
    And I set "County (optional)" to "County"
    And I set "Postcode" to "CH2 2AB"
    And I press the "Save" button
    Then I see "Line 1" on the page
    And I see "Line 2" on the page
    And I see "Line 3" on the page
    And I see "Town" on the page
    And I see "County" on the page
    And I see "CH2 2AB" on the page

    #Set valid account details and save
    When I set "Account number" to "12345678"
    And I set "Sort code" to "123456"
    And I set "Account holder's name" to "Account Holder"
    And I press the "Save" button
    Then I see "12345678" on the page
    And I see "12345678" in the same row as "Account number"
    And I see "12-34-56" in the same row as "Sort code"
    And I see "Account Holder" in the same row as "Account holder's name"

    Examples:
      |user       |juror_number |   pool_number   |
      |MODTESTCOURT |041536765    | 415360585       |

  Scenario Outline: Change juror bank details error check

    Given I am on "Bureau" "test"
    When a bureau owned pool is created with jurors
      | court |juror_number         | pool_number      | att_date_weeks_in_future | owner |
      | 415   |<juror_number>     | <pool_number>       | 5                      | 400  |

    Then a new pool is inserted for where record has transferred to the court new schema
      |part_no              | pool_no           | owner |
      |<juror_number>     | <pool_number>     | 415   |

    And I Confirm all the data in the record attendance table is cleared
    And I log in as "<user>"

    #set juror as responded
    And I update juror "<juror_number>" to have a status of responded in order to record attendance

    #check in jurors
    And I press the "Apps" button
    And I click on the "Juror management" link

    #Bank detail notes error check
    When the user searches for juror record "<juror_number>" from the global search bar
    And I click on the "Expenses" link
    And I see "Daily expenses" on the page
    And I press change juror bank details button
    And I press Add or Change internal note button
    And I set "Add a note" to "This note is 2001 characters long. This note is 2001 characters long This note is 2001 characters long. This note is 2001 characters long This note is 2001 characters long. This note is 2001 characters long This note is 2001 characters long. This note is 2001 characters long This note is 2001 characters long. This note is 2001 characters long This note is 2001 characters long. This note is 2001 characters long This note is 2001 characters long. This note is 2001 characters long This note is 2001 characters long. This note is 2001 characters long This note is 2001 characters long. This note is 2001 characters long This note is 2001 characters long. This note is 2001 characters long This note is 2001 characters long. This note is 2001 characters long This note is 2001 characters long. This note is 2001 characters long This note is 2001 characters long. This note is 2001 characters long This note is 2001 characters long. This note is 2001 characters long This note is 2001 characters long. This note is 2001 characters long This note is 2001 characters long. This note is 2001 characters long This note is 2001 characters long. This note is 2001 characters long This note is 2001 characters long. This note is 2001 characters long This note is 2001 characters long. This note is 2001 characters long This note is 2001 characters long. This note is 2001 characters long This note is 2001 characters long. This note is 2001 characters long This note is 2001 characters long. This note is 2001 characters long This note is 2001 characters long. This note is 2001 characters long This note is 2001 characters long. This note is 2001 characters long This note is 2001 characters long. This note is 2001 characters long This note is 2001 characters long. This note is 2001 characters long This note is 2001 characters long. This note is 2001 characters long This note is 2001 characters long. This note is 2001 characters long This note is 2001 characters long. This note is 2001 characters long."
    And I press the "Save" button
    Then I see error "The notes provided are too long"
    And I see "You have 1 character too many" on the page
    When I set "Add a note" to "This note is 2000 characters long. This note is 2000 characters long This note is 2000 characters long. This note is 2000 characters long. This note is 2000 characters long This note is 2000 characters long. This note is 2000 characters long. This note is 2000 characters long This note is 2000 characters long. This note is 2000 characters long. This note is 2000 characters long This note is 2000 characters long. This note is 2000 characters long. This note is 2000 characters long This note is 2000 characters long. This note is 2000 characters long. This note is 2000 characters long This note is 2000 characters long. This note is 2000 characters long. This note is 2000 characters long This note is 2000 characters long. This note is 2000 characters long. This note is 2000 characters long This note is 2000 characters long. This note is 2000 characters long. This note is 2000 characters long This note is 2000 characters long. This note is 2000 characters long. This note is 2000 characters long This note is 2000 characters long. This note is 2000 characters long. This note is 2000 characters long This note is 2000 characters long. This note is 2000 characters long. This note is 2000 characters long This note is 2000 characters long. This note is 2000 characters long. This note is 2000 characters long This note is 2000 characters long. This note is 2000 characters long. This note is 2000 characters long This note is 2000 characters long. This note is 2000 characters long. This note is 2000 characters long This note is 2000 characters long. This note is 2000 characters long. This note is 2000 characters long This note is 2000 characters long. This note is 2000 characters long. This note is 2000 characters long This note is 2000 characters long. This note is 2000 characters long. This note is 2000 characters long This note is 2000 characters long. This note is 2000 characters long. This note is 2000 characters long This note is 2000 characters long. This note is 2000 charac"
    And I see "You have 0 characters remaining" on the page
    And I press the "Save" button
    Then I see "These can only be seen by internal staff at HMCTS. The public cannot request to view them." on the page
    And I see "This note is 2000 characters long. This note is 2000 characters long This note is 2000 characters long. This note is 2000 characters long. This note is 2000 characters long This note is 2000 characters long. This note is 2000 characters long. This note is 2000 characters long This note is 2000 characters long. This note is 2000 characters long. This note is 2000 characters long This note is 2000 characters long. This note is 2000 characters long. This note is 2000 characters long This note is 2000 characters long. This note is 2000 characters long. This note is 2000 characters long This note is 2000 characters long. This note is 2000 characters long. This note is 2000 characters long This note is 2000 characters long. This note is 2000 characters long. This note is 2000 characters long This note is 2000 characters long. This note is 2000 characters long. This note is 2000 characters long This note is 2000 characters long. This note is 2000 characters long. This note is 2000 characters long This note is 2000 characters long. This note is 2000 characters long. This note is 2000 characters long This note is 2000 characters long. This note is 2000 characters long. This note is 2000 characters long This note is 2000 characters long. This note is 2000 characters long. This note is 2000 characters long This note is 2000 characters long. This note is 2000 characters long. This note is 2000 characters long This note is 2000 characters long. This note is 2000 characters long. This note is 2000 characters long This note is 2000 characters long. This note is 2000 characters long. This note is 2000 characters long This note is 2000 characters long. This note is 2000 characters long. This note is 2000 characters long This note is 2000 characters long. This note is 2000 characters long. This note is 2000 characters long This note is 2000 characters long. This note is 2000 characters long. This note is 2000 characters long This note is 2000 characters long. This note is 2000 charac" on the page

    #Address fields error checks
    When I press change juror change address button
    And I set "Address line 1" to ""
    And I set "Town or city" to ""
    And I set "Postcode" to ""
    And I press the "Save" button
    Then I see error "Please provide the first line of the address"
    And I see error "Please provide the Town or City"
    And I see error "Please provide the postcode"

    When I set "Address line 1" to "thisisareallylongstringandshoulderror"
    And I set "Address line 2 (optional)" to "thisisareallylongstringandshoulderror"
    And I set "Address line 3 (optional)" to "thisisareallylongstringandshoulderror"
    And I set "Town or city" to "thisisareallylongstringandshoulderror"
    And I set "County (optional)" to "thisisareallylongstringandshoulderror"
    And I set "Postcode" to "thisisareallylongstringandshoulderror"
    And I press the "Save" button
    Then I see error "Please check the second line of the address"
    And I see error "Please check the third line of the address"
    And I see error "Please check the Town or City"
    And I see error "Please check the county"
    And I see error "Please check the postcode"
    And I see error "Please check the first line of the address"

    When I set "Address line 1" to "Line 1"
    And I set "Address line 2 (optional)" to "Line 2"
    And I set "Address line 3 (optional)" to "Line 3"
    And I set "Town or city" to "Town"
    And I set "County (optional)" to "County"
    And I set "Postcode" to "CH2 2AB"
    And I press the "Save" button
    Then I see "Line 1" on the page
    And I see "Line 2" on the page
    And I see "Line 3" on the page
    And I see "Town" on the page
    And I see "County" on the page
    And I see "CH2 2AB" on the page

    #Bank details error checks
    When I press the "Save" button
    Then I see error "Enter an account number"
    And I see error "Enter an sort code"
    And I see error "Enter the account holder's name"
    When I set "Account number" to "123456789"
    And I set "Sort code" to "1234567"
    And I set "Account holder's name" to "Thisisaninvalidname"
    And I press the "Save" button
    Then I see error "Account number must be 8 numbers"
    And I see error "Sort code must be 6 digits"
    And I see error "Account holder's name must be 18 characters or fewer"

    Examples:
      |user       |juror_number |   pool_number   |
      |MODTESTCOURT |041536766    | 415360585       |