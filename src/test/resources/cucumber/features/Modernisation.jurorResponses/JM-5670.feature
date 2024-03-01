Feature:JM-5670

@JurorTransformationMulti
Scenario Outline: Postpone a juror to another court as a Bureau officer - Bulk flow happy path
    Given I am on "Bureau" "test"

    Given a bureau owned pool is created with jurors
      | court |juror_number  	    | pool_number	    | att_date_weeks_in_future	| owner |
      | 415   |<juror_number> 	    | <pool_number>     | 5				            | 400	|
      | 415   |<juror_number_2> 	| <pool_number>     | 5				            | 400	|
      | 415   |<juror_number_3> 	| <pool_number>     | 5				            | 400	|
      | 415   |<juror_number_4> 	| <pool_number>     | 5				            | 400	|

    And I log in as "<user>"
    And I press the "Apps" button
    And I click on the "Pool management" link
    And I click on the "Search" link
    And I set "Pool number" to "<pool_number>"
    And I press the "Continue" button
    And I check the select all checkbox on pool overview as bureau user

    And I press the "Postpone" button
    And I set the "Postpone service start date" date to a Monday "38" weeks in the future
    And I press the "Continue" button
    And I see "There are no active pools for this date" on the page
    And I press the "Put in deferral maintenance" button
    And I see "4 jurors postponed to deferral maintenance" on the page


    Examples:
      |user			 |juror_number  | juror_number_2  | juror_number_3  |juror_number_4  |pool_number  |
      |MODTESTBUREAU |041520019     | 041520120       |041520121       |041520122       |415300801     |


    @JurorTransformationMulti
    Scenario Outline: Postpone a juror to another court as a Bureau officer - Ineligible due to age - Bulk flow
        Given I am on "Bureau" "test"

        Given a bureau owned pool is created with jurors
            | court |juror_number  	    | pool_number	    | att_date_weeks_in_future	| owner |
            | 415   |<juror_number>     | <pool_number>     | 5		     		        | 400	|
            | 415   |<juror_number_2> 	| <pool_number>     | 5				            | 400	|
            | 415   |<juror_number_3> 	| <pool_number>     | 5				            | 400	|

        And I log in as "<user>"
        And I press the "Apps" button
        And I click on the "Pool management" link
        And I click on the "Search" link
        And I set "Pool number" to "<pool_number>"
        And I press the "Continue" button
        And I check the juror "<juror_number>" checkbox
        And I click on "<juror_number>" in the same row as "<juror_number>"
        And I click on the "Juror details" link
        And I click on the "Add or change" link
        And I change a date of birth of a juror that will make more than 75 years
        Then I press the "Save" button
        And I press the "Apps" button
        And I click on the "Pool management" link
        And I click on the "Search" link
        And I set "Pool number" to "<pool_number>"
        And I press the "Continue" button
        And I check the juror "<juror_number_2>" checkbox
        And I click on "<juror_number_2>" in the same row as "<juror_number_2>"
        And I click on the "Juror details" link
        And I click on the "Add or change" link
        And I change a date of birth of a juror that will make more than 75 years
        Then I press the "Save" button
        And I press the "Apps" button
        And I click on the "Pool management" link
        And I click on the "Search" link
        And I set "Pool number" to "<pool_number>"
        And I press the "Continue" button
        And I check the select all checkbox on pool overview as bureau user
        And I press the "Postpone" button
        And I set the "Postpone service start date" date to a Monday "38" weeks in the future
        And I press the "Continue" button
        And I see "There are no active pools for this date" on the page
        And I press the "Put in deferral maintenance" button
        Then I verify reassign error message with the text "The following jurors cannot be moved because they'll be 76 years old by the new date and no longer eligible for jury service."
        And I press the "Continue and move remaining jurors" button
        And I see "1 juror postponed to deferral maintenance" on the page

        Examples:
            |user		   |juror_number  | juror_number_2  |juror_number_3   | pool_number  |
            |MODTESTBUREAU |041534789     | 041534788       |041534787        |415300701     |

    @JurorTransformationMulti
    Scenario Outline: Postpone a juror to another court as a Bureau officer - Ineligible due to status - Bulk flow
        Given I am on "Bureau" "test"

        Given a bureau owned pool is created with jurors
            | court |juror_number  	    | pool_number	    | att_date_weeks_in_future	| owner |
            | 415   |<juror_number>     | <pool_number>     | 5		     		        | 400	|
            | 415   |<juror_number_2> 	| <pool_number>     | 5				            | 400	|
            | 415   |<juror_number_3> 	| <pool_number>     | 5				            | 400	|

        And I update juror "<juror_number_2>" to have a status of "Excused"
        And I update juror "<juror_number_3>" to have a status of "Deferred"

        And I log in as "<user>"
        And I press the "Apps" button
        And I click on the "Pool management" link
        And I click on the "Search" link
        And I set "Pool number" to "<pool_number>"
        And I press the "Continue" button
        And I press the "Postpone" button
        And I see error "Select at least one juror"
        And I check the select all checkbox on pool overview as bureau user
        And I press the "Postpone" button
        And I set the "Postpone service start date" date to a Monday "38" weeks in the future
        And I press the "Continue" button
        And I see "There are no active pools for this date" on the page
        And I press the "Put in deferral maintenance" button
        And I see "Cannot be moved due to juror status" on the page
        Then I verify reassign error message with the text "You can only move jurors with a responded or summoned status. The following jurors have a different status and cannot be moved."
        And I press the "Continue and move remaining jurors" button
        And I see "1 juror postponed to deferral maintenance" on the page

        Examples:
            |user		   |juror_number  | juror_number_2  |juror_number_3   | pool_number  |
            |MODTESTBUREAU |041520789     | 041520769       |041520779         |415200601    |
