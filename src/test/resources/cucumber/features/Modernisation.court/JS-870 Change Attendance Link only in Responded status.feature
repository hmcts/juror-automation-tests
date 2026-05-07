Feature: JS-870 Change Attendance Link only available in Responded status

  @JurorTransformationMulti
  Scenario Outline: Change Attendance Link only available in Responded status

    Given I am on "Bureau" "<environment>"

    When a bureau owned pool is created with jurors
      | court | juror_number  	    | pool_number	    | att_date_weeks_in_future	| owner |
      | 415   | <juror_number_1>    | <pool_number>     | 5				            | 400	|

    Then a new pool is inserted for where record has transferred to the court new schema
      | part_no              | pool_no            | owner |
      | <juror_number_1>     | <pool_number>      | 415   |

    And I log in as "<user>"

    And I search for juror "<juror_number_1>"
    Then I see "Summoned" on the page
    And I do not see Change Attendance link on Overview tab

    And I update juror "<juror_number_1>" to have a status of "Responded"
    And I refresh the page
    And I see Change Attendance link on Overview tab

    And I update juror "<juror_number_1>" to have a status of "Deferred"
    And I refresh the page
    And I do not see Change Attendance link on Overview tab

    And I update juror "<juror_number_1>" to have a status of "Excused"
    And I refresh the page
    And I do not see Change Attendance link on Overview tab

    And I update juror "<juror_number_1>" to have a status of "Panel"
    And I refresh the page
    And I do not see Change Attendance link on Overview tab

    And I update juror "<juror_number_1>" to have a status of "Juror"
    And I refresh the page
    And I do not see Change Attendance link on Overview tab

    And I update juror "<juror_number_1>" to have a status of "Disqualified"
    And I refresh the page
    And I do not see Change Attendance link on Overview tab

    And I update juror "<juror_number_1>" to have a status of "FailedToAttend"
    And I refresh the page
    And I do not see Change Attendance link on Overview tab

    And I update juror "<juror_number_1>" to have a status of "Completed"
    And I refresh the page
    And I do not see Change Attendance link on Overview tab

    And I update juror "<juror_number_1>" to have a status of "Transferred"
    And I refresh the page
    And I do not see Change Attendance link on Overview tab

    Examples:
      | user         | juror_number_1 | pool_number   | environment |
      | MODTESTCOURT | 041566735      | 415835634     | test        |
