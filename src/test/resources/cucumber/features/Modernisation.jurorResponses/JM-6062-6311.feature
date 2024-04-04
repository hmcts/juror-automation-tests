Feature: JM-6062 - As a jury officer, I want to set default expenses in the system

  Scenario Outline: Set default expenses happy path

    Given I am on "Bureau" "test"
    When a bureau owned pool is created with jurors
      | court |juror_number         | pool_number      | att_date_weeks_in_future | owner |
      | 415   |<juror_number_1>     | <pool_number>     | 4                      | 400  |

    Then a new pool is inserted for where record has transferred to the court new schema
      |part_no              | pool_no           | owner |
      |<juror_number_1>     | <pool_number>     | 415   |

    And I Confirm all the data in the record attendance table is cleared
    And I log in as "<user>"

    #set juror as responded
    And I update juror "<juror_number_1>" to have a status of responded in order to record attendance

    #Error Check Tests
    When I search for juror "<juror_number_1>"
    And I click on the "Expenses" link
    And I press change default expenses button
    Then I see "Set Default Expenses" on the page

    When I set financial loss field to "100"
    And I set travel time hours field to "1"
    And I set travel time minutes field to "24"
    And I set mileage to "30"
    And I click food and drink radio button
    And I set smart card field to "1234567"
    And I click apply to all drafts checkbox

    And I press the "Save default expenses" button
    Then I see "£100.00" in the same row as "Loss of earnings or benefits per day"
    And I see "1 hour 24 minutes" in the same row as "Travel time"
    And I see "30 miles" in the same row as "Miles travelled"
    And I see "1234567" in the same row as "Smartcard number"
    And I see "-" in the same row as "Total smartcard spend"

    Examples:
      |user       |juror_number_1 |    pool_number   |
      |MODTESTCOURT |041610006      | 416100301        |

  Scenario Outline: Set default expenses Error Check

    Given I am on "Bureau" "test"
    When a bureau owned pool is created with jurors
      | court |juror_number         | pool_number      | att_date_weeks_in_future | owner |
      | 415   |<juror_number_1>     | <pool_number>     | 4                      | 400  |

    Then a new pool is inserted for where record has transferred to the court new schema
      |part_no              | pool_no           | owner |
      |<juror_number_1>     | <pool_number>     | 415   |

    And I Confirm all the data in the record attendance table is cleared
    And I log in as "<user>"

    #set juror as responded
    And I update juror "<juror_number_1>" to have a status of responded in order to record attendance

    #Error Check Tests
    When I search for juror "<juror_number_1>"
    And I click on the "Expenses" link
    And I press change default expenses button
    Then I see "Set Default Expenses" on the page

    When I set financial loss field to "1000001"
    And I set travel time minutes field to "60"
    And I set mileage to "1000001"
    And I set smart card field to "123456789012345678901"
    And I press the "Save default expenses" button
    Then I see error "Loss of earnings or benefits per day must be less than £1,000,000"
    And I see error "Smartcard number must be 20 characters or fewer"
    And I see error "Miles travelled must be less than 1,000,000"
    And I see error "Enter minutes between 0 and 59"

    When I set financial loss field to "-1"
    And I set travel time hours field to "24"
    And I set travel time minutes field to ""
    And I set mileage to "-1"
    And I press the "Save default expenses" button
    Then I see error "Loss of earnings or benefits per day must not be negative"
    And I see error "Miles travelled must not be negative"
    And I see error "Travel time should not be greater than a day"

    Examples:
      |user       |juror_number_1 |    pool_number   |
      |MODTESTCOURT |041610005      | 416100301        |

  Scenario Outline: Set smartcard happy path

    Given I am on "Bureau" "test"
    When a bureau owned pool is created with jurors
      | court |juror_number         | pool_number      | att_date_weeks_in_future | owner |
      | 415   |<juror_number_1>     | <pool_number>     | 4                      | 400  |

    Then a new pool is inserted for where record has transferred to the court new schema
      |part_no              | pool_no           | owner |
      |<juror_number_1>     | <pool_number>     | 415   |

    And I Confirm all the data in the record attendance table is cleared
    And I log in as "<user>"

    #set juror as responded
    And I update juror "<juror_number_1>" to have a status of responded in order to record attendance

    #Set default expenses
    When I search for juror "<juror_number_1>"
    And I click on the "Expenses" link
    And I press change default expenses button
    Then I see "Set Default Expenses" on the page

    When I set financial loss field to "50"
    And I set smart card field to "1234567"
    And I press the "Save default expenses" button
    Then I see "£50.00" in the same row as "Loss of earnings or benefits per day"

    #Checking smartspend total is correct and spread across selected days
    When I click on view draft expenses link
    And I click the add non-attendance day button
    And I set non-attendance date to "5" weeks in the future
    And I press confirm non-attendance day button
    And I click the add non-attendance day button
    And I set non-attendance date to "6" weeks in the future
    And I press confirm non-attendance day button
    And I click the check all expenses checkbox
    And I click the add smartcard spend button
    And I set smart card amount field to "97"
    And I click the add smartcard spend submit button
    Then I see "Totals" in the same row as "(£97.00)"
    # Test JM-6066 as part of this test
    And I see the expense date "5" weeks from now in the same row as "£1.50"
    And I click the expense date "5" weeks from now in the same row as "£1.50"
    And I set "Loss of earnings or benefits" to "100"
    And I set "Other costs" to "100"
    And I set "Description of other costs" to "description"
    Then I do not see "Financial loss (capped)" on the page
    And I click on the "Recalculate totals." link
    And I see "Financial loss (capped)" on the page

    Examples:
      |user       |juror_number_1 |    pool_number   |
      |MODTESTCOURT |041610007      | 416100301        |

  Scenario Outline: Set smartcard error check path

    Given I am on "Bureau" "test"
    When a bureau owned pool is created with jurors
      | court |juror_number         | pool_number      | att_date_weeks_in_future | owner |
      | 415   |<juror_number_1>     | <pool_number>     | 4                      | 400  |

    Then a new pool is inserted for where record has transferred to the court new schema
      |part_no              | pool_no           | owner |
      |<juror_number_1>     | <pool_number>     | 415   |

    And I Confirm all the data in the record attendance table is cleared
    And I log in as "<user>"

    #set juror as responded
    And I update juror "<juror_number_1>" to have a status of responded in order to record attendance

    #set defaylt expenses
    When I search for juror "<juror_number_1>"
    And I click on the "Expenses" link
    And I press change default expenses button
    And I set financial loss field to "50"
    And I set smart card field to "1234567"
    And I press the "Save default expenses" button
    Then I see "£50.00" in the same row as "Loss of earnings or benefits per day"

    #Check for error when no day selected for smartspend
    When I click on view draft expenses link
    And I click the add non-attendance day button
    And I set non-attendance date to "5" weeks in the future
    And I press confirm non-attendance day button
    And I click the add non-attendance day button
    And I set non-attendance date to "6" weeks in the future
    And I press confirm non-attendance day button
    And I click the add smartcard spend button
    Then I see error "Select at least one"

    #Check for errors on smartcard spend page
    When I click the check all expenses checkbox
    And I click the add smartcard spend button
    And I set smart card amount field to "101"
    And I click the add smartcard spend submit button
    Then I see error "Total expenses cannot be less than £0. For Day"

    When I set smart card amount field to "test"
    And I click the add smartcard spend submit button
    Then I see error "Smartcard spend can only include numbers and a decimal point"

    When I set smart card amount field to "-1"
    And I click the add smartcard spend submit button
    Then I see error "Smartcard spend can only be 0 or more"

    Examples:
      |user       |juror_number_1 |    pool_number   |
      |MODTESTCOURT |041610008      | 416100301        |