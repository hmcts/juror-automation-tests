Feature: JM-6163 - As a Jury Officer, I need to add a non-attendance day for a juror, so that they can be paid loss of earnings/benefits for this day

  @JurorTransformation @NewSchemaConverted
  Scenario Outline: Happy path add non-attendance day

    Given I am on "Bureau" "test"
    When a bureau owned pool is created with jurors
      | court |juror_number  	    | pool_number	    | att_date_weeks_in_future	| owner |
      | 415   |<juror_number_1>     | <pool_number>     | 4				            | 400	|

    Then a new pool is inserted for where record has transferred to the court new schema
      |part_no              | pool_no           | owner |
      |<juror_number_1>     | <pool_number>     | 415   |

    And I Confirm all the data in the record attendance table is cleared
    And I log in as "<user>"
     #set juror as responded
    And I update juror "<juror_number_1>" to have a status of responded in order to record attendance

    #Happy path add non attendance day
    When I search for juror "<juror_number_1>"
    And I click on the "Attendance" link
    And I press non-attendance day button
    And I set non-attendance date to "5" weeks in the future
    And I press confirm non-attendance day button
    Then I see the date "5" weeks from now in the same row as "Non-attendance day"

    Examples:
      |user			|juror_number_1 |    pool_number   |
      |MODTESTCOURT |041510001      | 415100301        |

  @JurorTransformation @NewSchemaConverted
  Scenario Outline: unhappy path add non-attendance day with error checks

    Given I am on "Bureau" "test"
    When a bureau owned pool is created with jurors
      | court |juror_number  	    | pool_number	    | att_date_weeks_in_future	| owner |
      | 415   |<juror_number_1>     | <pool_number>     | 4				            | 400	|

    Then a new pool is inserted for where record has transferred to the court new schema
      |part_no              | pool_no           | owner |
      |<juror_number_1>     | <pool_number>     | 415   |

    And I Confirm all the data in the record attendance table is cleared
    And I log in as "<user>"

    #set juror as responded
    And I update juror "<juror_number_1>" to have a status of responded in order to record attendance

    #Error Check Tests
    When I search for juror "<juror_number_1>"
    And I click on the "Attendance" link
    And I press non-attendance day button
    And I press confirm non-attendance day button
    Then I see "Enter a date for the non-attendance day" in the error banner

    When I set non-attendance date to "2" weeks in the future
    And I press confirm non-attendance day button
    Then I see "Non-attendance date cannot be before the juror’s service start date." in the error banner

    When I set non-attendance date to "notadate"
    And I press confirm non-attendance day button
    Then I see "Non-attendance date must only include numbers" in the error banner

    When I set non-attendance date to "24/5/26"
    And I press confirm non-attendance day button
    Then I see "Enter a non-attendance date in the correct format, for example, 31/01/2023" in the error banner

    When I set non-attendance date to "32/01/2023"
    And I press confirm non-attendance day button
    Then I see "Please enter a valid date for the non-attendance day" in the error banner

    When I click on the "Cancel" link
    And I press non-attendance day button
    And I set non-attendance date to "5" weeks in the future
    And I press confirm non-attendance day button
    Then I see the date "5" weeks from now in the same row as "Non-attendance day"

    And I press non-attendance day button
    And I set non-attendance date to "5" weeks in the future
    And I press confirm non-attendance day button
    Then I see "You cannot mark this date as a non-attendance day because it's already been recorded as an attendance day." in the error banner

    Examples:
      |user			|juror_number_1 |    pool_number   |
      |MODTESTCOURT |041510002      | 415100302        |