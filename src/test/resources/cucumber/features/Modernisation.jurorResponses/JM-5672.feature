Feature:JM-5672-As a jury officer I need to be able to bulk postpone

@JurorTransformationMulti
Scenario Outline: Postpone a juror to another court as a Jury officer - Bulk flow happy path

    Given I am on "Bureau" "test"
    Given a bureau owned pool is created with jurors
      | court |juror_number  	    | pool_number	    | att_date_weeks_in_future	| owner |
      | 415   |<juror_number_1> 	| <pool_number>     | 5				            | 400	|
      | 415   |<juror_number_2> 	| <pool_number>     | 5				            | 400	|
      | 415   |<juror_number_3> 	| <pool_number>     | 5				            | 400	|
      | 415   |<juror_number_4> 	| <pool_number>     | 5				            | 400	|

    And "<pool_number>" has "NEXT_DATE" as "5 mondays time" new schema
    Then a new pool is inserted for where record has transferred to the court new schema
        |part_no               | pool_no          | owner |
        |<juror_number_1>        | <pool_number>    | 415   |
        |<juror_number_2>        | <pool_number>    | 415   |
        |<juror_number_3>        | <pool_number>    | 415   |
        |<juror_number_4>        | <pool_number>    | 415   |

    And I log in as "<user>"
    And I press the "Apps" button
    And I click on the "Pool management" link
    And I click on the "Search" link
    And I set "Pool number" to "<pool_number>"
    And I press the "Continue" button
    And I see "Jurors in this pool" on the page
    And I check the select all checkbox on pool overview as court user
    And I press the "Postpone" button
    When I set the "Enter a new service start date" date to a Monday "38" weeks in the future
    And I press the "Continue" button
    Then I see "There are no active pools for this date" on the page
    And I press the "Put in deferral maintenance" button
    And I see "4 jurors postponed to deferral maintenance" on the page

    Examples:
      |user			 |juror_number_1  | juror_number_2  | juror_number_3  |juror_number_4  |pool_number  |
      |MODTESTCOURT  |041520045       | 041520046         |041520047      |041520048       |415300712    |


    @JurorTransformationMulti
    Scenario Outline: Postpone a juror to another court as a jury officer - Bulk flow Unhappy path

        Given I am on "Bureau" "test"
        Given a bureau owned pool is created with jurors
            | court |juror_number  	    | pool_number	    | att_date_weeks_in_future	| owner |
            | 415   |<juror_number_1> 	| <pool_number>     | 5				            | 400	|
            | 415   |<juror_number_2> 	| <pool_number>     | 5				            | 400	|
            | 415   |<juror_number_3> 	| <pool_number>     | 5				            | 400	|
            | 415   |<juror_number_4> 	| <pool_number>     | 5				            | 400	|

        And "<pool_number>" has "NEXT_DATE" as "5 mondays time" new schema
        Then a new pool is inserted for where record has transferred to the court new schema
            |part_no               | pool_no          | owner |
            |<juror_number_1>        | <pool_number>    | 415   |
            |<juror_number_2>        | <pool_number>    | 415   |
            |<juror_number_3>        | <pool_number>    | 415   |
            |<juror_number_4>        | <pool_number>    | 415   |

        And I update juror "<juror_number_2>" to have a have a date of birth which is ineligible for postponement
        And I log in as "<user>"
        And I press the "Apps" button
        And I click on the "Pool management" link
        And I click on the "Search" link
        And I set "Pool number" to "<pool_number>"
        And I press the "Continue" button
        And I press the "Postpone" button
        And I see error "Select at least one juror"
        And I check the select all checkbox on pool overview as court user
        And I press the "Postpone" button
        When I set the "Enter a new service start date" date to a Monday "38" weeks in the future
        And I press the "Continue" button
        Then I see "There are no active pools for this date" on the page
        And I press the "Put in deferral maintenance" button
        And I see "You cannot move some of these jurors" on the page
        And I press the "Continue and move remaining jurors" button
        And I see "3 jurors postponed to deferral maintenance" on the page

        Examples:
            |user			 |juror_number_1  | juror_number_2  | juror_number_3  |juror_number_4  |pool_number  |
            |MODTESTCOURT  |041520029       | 041520030         |041520031       |041520032       |415300714    |

    @JurorTransformation
    Scenario Outline: Postpone a juror to another court as a Jury officer - Bulk flow UNHAPPY PATH
        Given I am on "Bureau" "test"

        Given a bureau owned pool is created with jurors
            | court |juror_number  	    | pool_number	    | att_date_weeks_in_future	| owner |
            | 415   |<juror_number_1>     | <pool_number> | 5				                | 400	|
            | 415   |<juror_number_2> 	| <pool_number>     | 5				            | 400	|
            | 415   |<juror_number_3> 	| <pool_number>     | 5				            | 400	|

        Then a new pool is inserted for where record has transferred to the court new schema
            |part_no               | pool_no           | owner |
            |<juror_number_1>       | <pool_number>      | 415   |
            |<juror_number_2>     | <pool_number>      | 415   |
            |<juror_number_3>     | <pool_number>      | 415   |

        And I Confirm all the data in the record attendance table is cleared
        And a new trial is inserted with the trial number "<trial_number>"
        And I update juror "<juror_number_1>" to have a have a date of birth which is ineligible for postponement
        And I update juror "<juror_number_2>" to have a status of responded in order to record attendance
        And I log in as "<user>"
        And I press the "Apps" button
        And I click on the "Juror management" link
        And I click on the "Record attendance" link
        And I set the radio button to "Check in"

        And I set "Hour" to "09"
        And I set "Minute" to "00"
        And I set the radio button to "am"
        And I input juror "<juror_number_2>" to be checked in
        And I press the "Check in juror" button
        And I see "<juror_number_2>" in the same row as "9:00am"

        And I press the "Apps" button
        And I click on the "Trial management" link
        And I click on the "<trial_number>" link

        And I press the "Generate panel" button
        And I set the radio button to "All available jurors"
        And I set "Number of jurors needed on this panel" to "1"
        And I press the "Continue" button
        And I see "<juror_number_2>" in the same row as "Panel"

        #attempt to postpone jurors who cannot be postponed
        And I press the "Apps" button
        And I click on the "Pool management" link
        And I click on the "Search" link
        And I set "Pool number" to "<pool_number>"
        And I press the "Continue" button
        And I check the juror "<juror_number_1>" checkbox
        And I check the juror "<juror_number_2>" checkbox
        And I check the juror "<juror_number_3>" checkbox
        And I press the "Postpone" button
        And I set the "Postpone service start date" date to a Monday "38" weeks in the future
        And I press the "Continue" button
        And I see "There are no active pools for this date" on the page
        And I press the "Put in deferral maintenance" button
        And I see "You cannot move some of these jurors" on the page
        And I see "You can only move jurors with a responded or summoned status. The following jurors have a different status and cannot be moved." on the page
        And I see juror "<juror_number_1>" in the jurors cannot be moved table
        And I see juror "<juror_number_2>" in the jurors cannot be moved table
        And I click on the "Cancel and go back" link
        And I check the juror "<juror_number_3>" checkbox
        And I press the "Postpone" button
        When I set the "Postpone service start date" date to a Monday "38" weeks in the future
        And I press the "Continue" button
        Then I see "There are no active pools for this date" on the page
        And I press the "Put in deferral maintenance" button
        And I see "1 juror postponed to deferral maintenance" on the page

        Examples:
            |user			 |juror_number_1  | juror_number_2  |juror_number_3    | pool_number   | trial_number    |
            |MODTESTCOURT     |041520222     | 041520223       |041520224         |415300718      | TESTINGTRIAL2024|

    @JurorTransformationMulti
    Scenario Outline: Postpone a juror having age more than 75 to another court as a Jury officer - Bulk flow happy path
        Given I am on "Bureau" "test"
        Given a bureau owned pool is created with jurors
            | court |juror_number       | pool_number      | att_date_weeks_in_future | owner |
            | 415   |<juror_number_1>     | <pool_number>     | 5                      | 400  |
            | 415   |<juror_number_2>   | <pool_number>     | 5                         | 400  |
            | 415   |<juror_number_3>   | <pool_number>     | 5                         | 400  |

        Then a new pool is inserted for where record has transferred to the court new schema
            |part_no               | pool_no           | owner |
            |<juror_number_1>       | <pool_number>      | 415   |
            |<juror_number_2>     | <pool_number>      | 415   |
            |<juror_number_3>     | <pool_number>      | 415   |

        And I log in as "<user>"
        And I press the "Apps" button
        And I click on the "Pool management" link
        And I click on the "Search" link
        And I set "Pool number" to "<pool_number>"
        And I press the "Continue" button
        And I click on "<juror_number_1>" in the same row as "<juror_number_1>"
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
        And I check the juror "<juror_number_3>" checkbox
        And I click on "<juror_number_3>" in the same row as "<juror_number_3>"
        And I click on the "Juror details" link
        And I click on the "Add or change" link
        And I change a date of birth of a juror that will make more than 75 years
        Then I press the "Save" button
        And I press the "Apps" button
        And I click on the "Pool management" link
        And I click on the "Search" link
        And I set "Pool number" to "<pool_number>"
        And I press the "Continue" button
        And I check the select all checkbox on pool overview as court user
        And I press the "Postpone" button
        When I set the "Enter a new service start date" date to a Monday "38" weeks in the future
        And I press the "Continue" button
        Then I see "There are no active pools for this date" on the page
        When I press the "Put in deferral maintenance" button
        Then I verify reassign error message with the text "The following jurors cannot be moved because they'll be 76 years old by the new date and no longer eligible for jury service."

        Examples:
            |user          |juror_number_1  | juror_number_2  | juror_number_3  |  pool_number  |
            |MODTESTCOURT  |041520045     | 041520046    |041520047          |  415300709    |


    @JurorTransformationMulti
    Scenario Outline: Postpone a juror having different status and verify the message
        Given I am on "Bureau" "test"
        And I Confirm all the data in the record attendance table is cleared
        Given a bureau owned pool is created with jurors
            | court |juror_number       | pool_number      | att_date_weeks_in_future | owner |
            | 415   |<juror_number_1>     | <pool_number>     | 5                      | 400  |
            | 415   |<juror_number_2>   | <pool_number>     | 5                         | 400  |
            | 415   |<juror_number_3>   | <pool_number>     | 5                         | 400  |

        Then a new pool is inserted for where record has transferred to the court new schema
            |part_no               | pool_no           | owner |
            |<juror_number_1>       | <pool_number>      | 415   |
            |<juror_number_2>     | <pool_number>      | 415   |
            |<juror_number_3>     | <pool_number>      | 415   |
        And  I update juror "<juror_number_1>" to have a status of "Excused"
        And  I update juror "<juror_number_2>" to have a status of "Deferred"
        And I log in as "<user>"
        And I press the "Apps" button
        And I click on the "Pool management" link
        And I click on the "Search" link
        And I set "Pool number" to "<pool_number>"
        And I press the "Continue" button
        And I check the select all checkbox on pool overview as court user
        And I press the "Postpone" button
        When I set the "Enter a new service start date" date to a Monday "38" weeks in the future
        And I press the "Continue" button
        Then I see "There are no active pools for this date" on the page
        And I press the "Put in deferral maintenance" button
        And I see "Cannot be moved due to juror status" on the page

        Examples:
            |user          |juror_number_1  | juror_number_2  | juror_number_3  |  pool_number  |
            |MODTESTCOURT   |041520050     | 041520051    |041520052         |  415300710    |


    @JurorTransformationWIP @JM-6146
    Scenario Outline: Postpone a juror having different status by filtering selective jurors using radio button
        Given I am on "Bureau" "test"
        And I Confirm all the data in the record attendance table is cleared
        When a bureau owned pool is created with jurors
            | court |juror_number       | pool_number      | att_date_weeks_in_future | owner |
            | 415   |<juror_number_1>     | <pool_number>     | 5                      | 400  |
            | 415   |<juror_number_2>   | <pool_number>     | 5                         | 400  |
            | 415   |<juror_number_3>   | <pool_number>     | 5                         | 400  |
            | 415   |<juror_number_4>   | <pool_number>     | 5                         | 400  |

        Then a new pool is inserted for where record has transferred to the court new schema
            |part_no               | pool_no           | owner |
            |<juror_number_1>       | <pool_number>      | 415   |
            |<juror_number_2>     | <pool_number>      | 415   |
            |<juror_number_3>     | <pool_number>      | 415   |
            |<juror_number_4>     | <pool_number>      | 415   |
        And  I update juror "<juror_number_1>" to have a status of "Panel"
        And  I update juror "<juror_number_2>" to have a status of "Responded"
        And  I update juror "<juror_number_3>" to have a status of "Juror"
        And  I update juror "<juror_number_4>" to have a status of "Deferred"
        And I log in as "<user>"
        And I press the "Apps" button
        And I click on the "Pool management" link
        And I click on the "Search" link
        And I set "Pool number" to "<pool_number>"
        And I press the "Continue" button
        #Below step will fail due to JM-6146
        And I check the "Responded, panelled and juror only" checkbox
        And I press the "Postpone" button
        When I set the "Enter a new service start date" date to a Monday "38" weeks in the future
        And I press the "Continue" button
        Then I see "There are no active pools for this date" on the page
        And I press the "Put in deferral maintenance" button
        And I see "Cannot be moved due to juror status" on the page

        Examples:
            |user          |juror_number_1  | juror_number_2  | juror_number_3  | juror_number_4| pool_number  |
            |MODTESTCOURT  |041520058     | 041520059    |041520060       |    041520061             |415300711    |


