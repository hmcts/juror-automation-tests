Feature: JM-5070 As a jury officer I need to be able to change a jurors attendance date - 4362 As a Jury officer I need to be able to confirm a jurors attendance

  @JurorTransformationMulti @NewSchemaConverted
  Scenario Outline: Happy Path Test to create a new pool of jurors and change a jurors attendance date

    Given I am on "Bureau" "test"

    When a bureau owned pool is created with jurors
      | court |juror_number  	    | pool_number	    | att_date_weeks_in_future	| owner |
      | 415   |<juror_number_1>     | <pool_number>     | 5				            | 400	|
      | 415   |<juror_number_2> 	| <pool_number>     | 5				            | 400	|
      | 415   |<juror_number_3> 	| <pool_number>     | 5				            | 400	|

    Then a new pool is inserted for where record has transferred to the court new schema
      |part_no              | pool_no            | owner |
      |<juror_number_1>     | <pool_number>      | 415   |
      |<juror_number_2>     | <pool_number>      | 415   |
      |<juror_number_3>     | <pool_number>      | 415   |

    And I update juror "<juror_number_1>" to have a status of "Responded"
    And I update juror "<juror_number_2>" to have a status of "Responded"
    And I update juror "<juror_number_3>" to have a status of "Responded"

    And I log in as "<user>"
    And I press the "Apps" button
    And I click on the "Pool management" link
    And I click on the "Search" link

    And I set "Pool number" to "<pool_number>"
    And I press the "Continue" button
    And I check the juror "<juror_number_1>" checkbox
    And I check the juror "<juror_number_2>" checkbox
    And I check the juror "<juror_number_3>" checkbox

    And I press the "Change next due at court" button
    And I see "Enter date next due at court" on the page
    And I set the "Next due date" date to a Monday "4" weeks in the future
    And I press the "Continue" button
    And I see "3 jurors will be next due to attend on:" on the page
    And I press the "Continue" button
    And I see the banner for next due at court date
    And I see "3 jurors next due at court on" on the page


    Examples:
      |user         |juror_number_1 | juror_number_2 | juror_number_3    | pool_number   |
      |MODTESTCOURT |041566732      | 041566733      | 041566734         | 415835633     |


  @JurorTransformation @newSchemaConverted
  Scenario Outline: Happy Path Test to create a new pool of jurors and confirm jurors attendance date

    #needs to go into single threaded
    Given I am on "Bureau" "test"
    When a bureau owned pool is created with jurors
      | court |juror_number  	    | pool_number	    | att_date_weeks_in_future	| owner |
      | 415   |<juror_number_1>     | <pool_number>     | 5				            | 400	|
      | 415   |<juror_number_2> 	| <pool_number>     | 5				            | 400	|

    Then a new pool is inserted for where record has transferred to the court new schema
      |part_no              | pool_no           | owner |
      |<juror_number_1>     | <pool_number>     | 415   |
      |<juror_number_2>     | <pool_number>      | 415   |

    And I Confirm all the data in the record attendance table is cleared
    And I update juror "<juror_number_1>" to have a status of responded in order to record attendance
    And I update juror "<juror_number_2>" to have a status of responded in order to record attendance
    And I log in as "<user>"
    And I press the "Apps" button
    And I click on the "Juror management" link
    When I click on the "Record attendance" link
    Then I see "Record attendance" on the page
    And I see "UNCONFIRMED" on the page
    And I see "Check in" on the page
    And I see "Check out" on the page
    When I check the "Check in" checkbox
    And I set the radio button to "Check in"
    And I set "Hour" to "09"
    And I set "Minute" to "00"
    And I set the radio button to "am"
    And I input juror "<juror_number_1>" to be checked in
    And I press the "Check in juror" button
    Then I see "9:00am" in the same row as "<juror_number_1>"

    #Tap 'Record time’ from jurors search results
    When I click on "Record time" in the same row as "<juror_number_1>"
    And I set "Hour" to "08"
    And I set "Minute" to "00"
    And I select the checkout radio button to "pm"
    And I click on "Record time" in the same row as "<juror_number_1>"
    Then I see "<juror_number_1>" in the same row as "8:00pm"
    And I am able to see and interact with the Record attendance tabs and fields

   #Tap check out for single juror using record button
    When I check the "Check in" checkbox
    And I set the radio button to "Check in"
    And I set "Hour" to "09"
    And I set "Minute" to "00"
    And I set the radio button to "am"
    And I input juror "<juror_number_2>" to be checked in
    And I press the "Check in juror" button
    Then I see "9:00am" in the same row as "<juror_number_2>"

    #Tap 'Record time’ from jurors search results
    When I click on "Record time" in the same row as "<juror_number_2>"
    Then I see "<juror_number_2>" in the same row as "8:00pm"

   #  change button to change the check in and check out time of a juror
    When I click on "Change" in the same row as "<juror_number_1>"
    And I set "Hour" to "11"
    And I set "Minute" to "30"
    And I set the radio button to "am"
    And I set "check out" "Hour" to "7"
    And I set "check out" "Minute" to "00"
    And I select the checkout radio button to "pm"
    And I press the "Save changes" button
    Then I see "11:30am" in the same row as "<juror_number_1>"
    And I see "7:00pm" in the same row as "<juror_number_1>"
    #confirm all attendences
    When I press the "Confirm attendance" button
    And I press the "Confirm attendance list is correct" button
    Then I see "CONFIRMED" on the page

    Examples:
      |user			|juror_number_1 | juror_number_2  |      pool_number   |
      |MODTESTCOURT |041530007      | 041530008        | 415300301        |

  @JurorTransformation @newSchemaConverted
  Scenario Outline: Happy Path Test to create a new pool of jurors and check out all jurors

    #needs to go into single threaded
    Given I am on "Bureau" "test"
    When a bureau owned pool is created with jurors
      | court |juror_number  	    | pool_number	    | att_date_weeks_in_future	| owner |
      | 415   |<juror_number_1>     | <pool_number>     | 5				            | 400	|
      | 415   |<juror_number_2> 	| <pool_number>     | 5				            | 400	|
      | 415   |<juror_number_3> 	| <pool_number>     | 5				            | 400	|

    Then a new pool is inserted for where record has transferred to the court new schema
      |part_no              | pool_no           | owner |
      |<juror_number_1>     | <pool_number>     | 415   |
      |<juror_number_2>     | <pool_number>      | 415   |
      |<juror_number_3>     | <pool_number>      | 415   |

    And I Confirm all the data in the record attendance table is cleared
    And I update juror "<juror_number_1>" to have a status of responded in order to record attendance
    And I update juror "<juror_number_2>" to have a status of responded in order to record attendance
    And I update juror "<juror_number_3>" to have a status of responded in order to record attendance
    And I log in as "<user>"
    And I press the "Apps" button
    And I click on the "Juror management" link
    And I click on the "Record attendance" link
    Then I see "Record attendance" on the page
    And I see "UNCONFIRMED" on the page
    And I see "Check in" on the page
    And I see "Check out" on the page
    When I check the "Check in" checkbox
    And I set the radio button to "Check in"
    And I set "Hour" to "09"
    And I set "Minute" to "00"
    And I set the radio button to "am"
    And I input juror "<juror_number_1>" to be checked in
    And I press the "Check in juror" button
    Then I see "9:00am" in the same row as "<juror_number_1>"

   #Tap check in  for secound juror
    When I check the "Check in" checkbox
    And I set the radio button to "Check in"
    And I set "Hour" to "09"
    And I set "Minute" to "00"
    And I set the radio button to "am"
    And I input juror "<juror_number_2>" to be checked in
    And I press the "Check in juror" button
    Then I see "9:00am" in the same row as "<juror_number_2>"

     #Tap check in for third juror
    When I check the "Check in" checkbox
    And I set the radio button to "Check in"
    And I set "Hour" to "09"
    And I set "Minute" to "00"
    And I set the radio button to "am"
    And I input juror "<juror_number_3>" to be checked in
    And I press the "Check in juror" button
    Then I see "9:00am" in the same row as "<juror_number_3>"

   # press checkout all jurors
    When I set the radio button to "Check out"
    And I set "Hour" to "10"
    And I set "Minute" to "00"
    And I select the checkout radio button to "pm"
    And I press the "Check out all jurors" button
    Then I see "<juror_number_1>" in the same row as "10:00pm"
    And I see "<juror_number_2>" in the same row as "10:00pm"
    And I see "<juror_number_3>" in the same row as "10:00pm"

    Examples:
      |user			|juror_number_1 | juror_number_2  |   juror_number_3 |    pool_number   |
      |MODTESTCOURT |041530015      | 041530016        |041530017        |  415300301      |


  @JurorTransformation @newSchemaConverted
  Scenario Outline: create a new pool of jurors and verify attendance date for panel members

    Given I am on "Bureau" "test"
    When a bureau owned pool is created with jurors
      | court |juror_number  	    | pool_number	    | att_date_weeks_in_future	| owner |
      | 415   |<juror_number_1>     | <pool_number>     | 5				            | 400	|
      | 415   |<juror_number_2> 	| <pool_number>     | 5				            | 400	|
      | 415   |<juror_number_3> 	| <pool_number>     | 5				            | 400	|

    Then a new pool is inserted for where record has transferred to the court new schema
      |part_no              | pool_no           | owner |
      |<juror_number_1>     | <pool_number>     | 415   |
      |<juror_number_2>     | <pool_number>      | 415   |
      |<juror_number_3>     | <pool_number>      | 415   |

    And I Confirm all the data in the record attendance table is cleared
    And I update juror "<juror_number_1>" to have a status of responded in order to record attendance
    And I update juror "<juror_number_2>" to have a status of responded in order to record attendance
    And I update juror "<juror_number_3>" to have a status of Panel in order to record attendance
    And I log in as "<user>"
    And I press the "Apps" button
    And I click on the "Juror management" link
    When I click on the "Record attendance" link
    Then I see "Record attendance" on the page
    And I see "UNCONFIRMED" on the page
    And I see "Check in" on the page
    And I see "Check out" on the page
    When I check the "Check in" checkbox
    And I set the radio button to "Check in"
    And I set "Hour" to "09"
    And I set "Minute" to "00"
    And I set the radio button to "am"
    And I input juror "<juror_number_1>" to be checked in
    And I press the "Check in juror" button
    Then I see "9:00am" in the same row as "<juror_number_1>"
    #tap check out 1sd juror in responded
    And I set the radio button to "Check out"
    And I set "Hour" to "4"
    And I set "Minute" to "00"
    And I select the checkout radio button to "pm"
    And I input juror "<juror_number_1>" to be checked out
    When I press the "Check out juror" button
    Then I see "4:00pm" in the same row as "<juror_number_1>"

    When I check the "Check in" checkbox
    And I set the radio button to "Check in"
    And I set "Hour" to "09"
    And I set "Minute" to "00"
    And I set the radio button to "am"
    And I input juror "<juror_number_2>" to be checked in
    And I press the "Check in juror" button
    Then I see "9:00am" in the same row as "<juror_number_2>"
    #tap check out 2nd juror in responded  status
    When I set the radio button to "Check out"
    And I set "Hour" to "5"
    And I set "Minute" to "00"
    And I select the checkout radio button to "pm"
    And I input juror "<juror_number_2>" to be checked out
    And I press the "Check out juror" button
    Then I see "5:00pm" in the same row as "<juror_number_2>"

     #Tap check in and check out for third juror in panel status
    When I check the "Check in" checkbox
    And I set the radio button to "Check in"
    And I set "Hour" to "09"
    And I set "Minute" to "00"
    And I set the radio button to "am"
    And I input juror "<juror_number_3>" to be checked in
    And I press the "Check in juror" button
    Then I see "9:00am" in the same row as "<juror_number_3>"

   # press checkout  for panel juror
    When I set the radio button to "Check out"
    And I set "Hour" to "11"
    And I set "Minute" to "00"
    And I select the checkout radio button to "pm"
    And I input juror "<juror_number_3>" to be checked out
    And I press the "Check out all jurors" button
    Then I see "Do you want to check out panelled jurors too" on the page
    And I see "Check out panelled jurors" on the page
    And I press the "Check out panelled jurors" button
    And I see "11:00pm" in the same row as "<juror_number_3>"

    Examples:
      |user			|juror_number_1 | juror_number_2  |   juror_number_3 |    pool_number   |
      |MODTESTCOURT |041530015      | 041530016        |041530019        |  415300301      |
