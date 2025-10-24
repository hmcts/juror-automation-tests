Feature: As a court officer I want to have a dashboard on the juror application so I can manage my court more effectively

  @JurorTransformationMulti
  Scenario: Court Dashboard - labels and links check
    
    Given I am on "Bureau" "ithc"

    And I log in as "MODTESTCOURT" selecting court "415"
    
    And I see "homepage/dashboard" in the URL
    And I see "Notifications" on the page
    And I see "Attendance" on the page
    And I see "Admin" on the page
    And I see "Today" on the page
    And I see "Last 7 days" on the page
    And I see "Next 7 days" on the page
    And I see "Total due to attend" on the page
    And I see "Jurors with reasonable adjustments" on the page
    And I see "Unconfirmed attendances" on the page
    And I see "Jurors on call" on the page
    And I see "Date monthly utilisation report last run" on the page
    And I see "Last run monthly utilisation percentage" on the page
    
    And I see link with text "Persons attending - Summary"
    And I click on the "Persons attending - Summary" link
    Then I see "persons-attending-detail" in the URL
    And I see "Persons attending (detailed)" on the page
    And I press the "back" button on my browser

    And I see link with text "Reasonable adjustments report"
    And I click on the "Reasonable adjustments report" link
    Then I see "reasonable-adjustment-and-cje" in the URL
    And I see "Reasonable adjustment and CJE report" on the page
    And I press the "back" button on my browser

    And I see link with text "Unconfirmed attendance report"
    And I click on the "Unconfirmed attendance report" link
    Then I see "unconfirmed-attendance" in the URL
    And I see "Unconfirmed attendance report" on the page
    And I press the "back" button on my browser

    And I see link with text "Record attendance"
    And I click on the "Record attendance" link
    Then I see "juror-management/attendance" in the URL
    And I see "Record attendance" on the page
    And I press the "back" button on my browser

    And I see link with text "Unpaid attendances"
    And I click on the "Unpaid attendances" link
    Then I see "unpaid-attendance" in the URL
    And I see "Unpaid Attendance" on the page
    And I press the "back" button on my browser

    And I see link with text "Oldest unpaid attendance"

    And I see link with text "Prepare monthly utilisation report"
    And I click on the "Prepare monthly utilisation report" link
    Then I see "reporting/monthly-utilisation/prepare" in the URL
    And I see "Prepare monthly wastage and utilisation report" on the page
    And I press the "back" button on my browser

    And I see "homepage/dashboard" in the URL

  @JurorTransformation
  Scenario Outline: As a court officer I want to have a dashboard on the juror application so I can manage my court more effectively

    Given I am on "Bureau" "ithc"

    Given a bureau owned pool is created with jurors
      | court |juror_number        | pool_number	  | att_date_weeks_in_future	| owner |
      | 415   |<juror_number01>    | <pool_number01>  | 0				            | 400	|
      | 415   |<juror_number02>    | <pool_number01>  | 0				            | 400	|
      | 415   |<juror_number03>    | <pool_number01>  | 0				            | 400	|
      | 415   |<juror_number04>    | <pool_number01>  | 0				            | 400	|
      | 415   |<juror_number05>    | <pool_number01>  | 0				            | 400	|

    Given a bureau owned pool is created with jurors
      | court |juror_number        | pool_number	  | att_date_weeks_in_future	| owner |
      | 415   |<juror_number06>    | <pool_number02>  | 0				            | 400	|
      | 415   |<juror_number07>    | <pool_number02>  | 0				            | 400	|
      | 415   |<juror_number08>    | <pool_number02>  | 0				            | 400	|
      | 415   |<juror_number09>    | <pool_number02>  | 0				            | 400	|
      | 415   |<juror_number10>    | <pool_number02>  | 0				            | 400	|

    Given a bureau owned pool is created with jurors
      | court |juror_number        | pool_number	  | att_date_weeks_in_future	| owner |
      | 415   |<juror_number11>    | <pool_number03>  | 0				            | 400	|
      | 415   |<juror_number12>    | <pool_number03>  | 0				            | 400	|
      | 415   |<juror_number13>    | <pool_number03>  | 0				            | 400	|
      | 415   |<juror_number14>    | <pool_number03>  | 0				            | 400	|
      | 415   |<juror_number15>    | <pool_number03>  | 0				            | 400	|

    Given a bureau owned pool is created with jurors
      | court |juror_number        | pool_number	  | att_date_weeks_in_future	| owner |
      | 415   |<juror_number16>    | <pool_number04>  | 0				            | 400	|
      | 415   |<juror_number17>    | <pool_number04>  | 0				            | 400	|
      | 415   |<juror_number18>    | <pool_number04>  | 0				            | 400	|
      | 415   |<juror_number19>    | <pool_number04>  | 0				            | 400	|
      | 415   |<juror_number20>    | <pool_number04>  | 0				            | 400	|

    Given a bureau owned pool is created with jurors
      | court |juror_number        | pool_number	  | att_date_weeks_in_future	| owner |
      | 415   |<juror_number21>    | <pool_number05>  | -1				            | 400	|

    Then a new pool is inserted for where record has transferred to the court new schema
      |part_no                 | pool_no          | owner |
      |<juror_number01>        | <pool_number01>  | 415   |
      |<juror_number02>        | <pool_number01>  | 415   |
      |<juror_number03>        | <pool_number01>  | 415   |
      |<juror_number04>        | <pool_number01>  | 415   |
      |<juror_number05>        | <pool_number01>  | 415   |

    Then a new pool is inserted for where record has transferred to the court new schema
      |part_no                 | pool_no          | owner |
      |<juror_number06>        | <pool_number02>  | 415   |
      |<juror_number07>        | <pool_number02>  | 415   |
      |<juror_number08>        | <pool_number02>  | 415   |
      |<juror_number09>        | <pool_number02>  | 415   |
      |<juror_number10>        | <pool_number02>  | 415   |

    Then a new pool is inserted for where record has transferred to the court new schema
      |part_no                 | pool_no          | owner |
      |<juror_number11>        | <pool_number03>  | 415   |
      |<juror_number12>        | <pool_number03>  | 415   |
      |<juror_number13>        | <pool_number03>  | 415   |
      |<juror_number14>        | <pool_number03>  | 415   |
      |<juror_number15>        | <pool_number03>  | 415   |

    Then a new pool is inserted for where record has transferred to the court new schema
      |part_no                 | pool_no          | owner |
      |<juror_number16>        | <pool_number04>  | 415   |
      |<juror_number17>        | <pool_number04>  | 415   |
      |<juror_number18>        | <pool_number04>  | 415   |
      |<juror_number19>        | <pool_number04>  | 415   |
      |<juror_number20>        | <pool_number04>  | 415   |

    Then a new pool is inserted for where record has transferred to the court new schema
      |part_no                 | pool_no          | owner |
      |<juror_number21>        | <pool_number05>  | 415   |

    Given I set pool "<pool_number01>" loc_code to be "767"
    Given I set pool "<pool_number02>" loc_code to be "767"
    Given I set pool "<pool_number03>" loc_code to be "767"
    Given I set pool "<pool_number04>" loc_code to be "767"
    Given I set pool "<pool_number05>" loc_code to be "767"

    Given I delete trial "T202544321" and associated records
    Given I delete trial "T202544457" and associated records
    Given I delete utilisation reports for court "767"

    #log on and search for juror
    And I log in as "MODTESTCOURT" selecting court "767"

    #respond jurors 1-3 of each pool and process
    Then the user searches for juror record "<juror_number01>" from the global search bar
    And I record a happy path paper summons response and process now
    Then the user searches for juror record "<juror_number01>" from the global search bar
    And I click on the "Juror details" link
    And I click on the "Add or change" link
    When I select the yes radio button from the Additional Requirements Juror details
    And I see "Select a reason" on the page
    When I select "D - Allergies" from the "Select a reason" dropdown
    And I set "What help does this juror need at court" to "Nutritional Guidance"
    And I press the "Save" button

    Then the user searches for juror record "<juror_number02>" from the global search bar
    And I record a happy path paper summons response and process now

    Then the user searches for juror record "<juror_number03>" from the global search bar
    And I record a happy path paper summons response and process now

    Then the user searches for juror record "<juror_number06>" from the global search bar
    And I record a happy path paper summons response and process now

    Then the user searches for juror record "<juror_number07>" from the global search bar
    And I record a happy path paper summons response and process now

    Then the user searches for juror record "<juror_number08>" from the global search bar
    And I record a happy path paper summons response and process now

    Then the user searches for juror record "<juror_number11>" from the global search bar
    And I record a happy path paper summons response and process now

    Then the user searches for juror record "<juror_number12>" from the global search bar
    And I record a happy path paper summons response and process now

    Then the user searches for juror record "<juror_number13>" from the global search bar
    And I record a happy path paper summons response and process now

    Then the user searches for juror record "<juror_number16>" from the global search bar
    And I record a happy path paper summons response and process now

    Then the user searches for juror record "<juror_number17>" from the global search bar
    And I record a happy path paper summons response and process now

    Then the user searches for juror record "<juror_number18>" from the global search bar
    And I record a happy path paper summons response and process now

    Then the user searches for juror record "<juror_number21>" from the global search bar
    And I record a happy path paper summons response and process now

    #respond 4th of each pool and do not process
    Then the user searches for juror record "<juror_number04>" from the global search bar
    And I record a happy path paper summons response
    And I click on the "No," link

    Then the user searches for juror record "<juror_number09>" from the global search bar
    And I record a happy path paper summons response
    And I click on the "No," link

    Then the user searches for juror record "<juror_number14>" from the global search bar
    And I record a happy path paper summons response
    And I click on the "No," link

    Then the user searches for juror record "<juror_number19>" from the global search bar
    And I record a happy path paper summons response
    And I click on the "No," link

    #dont respond 5th juror of each pool

    #check in 1st juror of each pool to put on a trial
    And I press the "Apps" button
    And I click on the "Juror management" link
    And I click on the "Record attendance" link
    And I set the radio button to "Check in"
    And I set "Hour" to "09"
    And I set "Minute" to "00"
    And I set the radio button to "am"

    And I input juror "<juror_number01>" to be checked in
    And I press the "Check in juror" button
    And I see "<juror_number01>" on the page
    And I input juror "<juror_number06>" to be checked in
    And I press the "Check in juror" button
    And I see "<juror_number06>" on the page

    #Create trial
    And I press the "Apps" button
    And I click on the "Trial management" link

    And I press the "Create a trial" button
    And I see "Create a trial" on the page

    And I set "Case number" to "T202544457"
    And I set the radio button to "Criminal"
    And I see "Defendants" on the page
    Then I set the radio button to "Civil"
    And I see "Respondents" on the page
    And I set the radio button to "Criminal"
    And I set "Defendants" to "Defendant"
    And I set the "Start date for Trial" date to a Monday "0" weeks in the future

    And I set "Judge" to "PATRICIA H AITKEN"
    And I set the radio button to "Knutsford"
    And I set "Courtroom" to "JURY ASSEMBLY ROOM"
    And I press the "Create trial" button

    And I press the "Generate panel" button
    And I see "Generate a panel" on the page
    And I see "Which jurors do you want to generate a panel from?" on the page
    And I set the radio button to "All available jurors"
    And I set "Number of jurors needed on this panel" to "2"
    And I press the "Continue" button

    And I select the Select all checkbox on the trial
    And I press the "Empanel jury" button
    And I set input field with "id" of "numberOfJurors" to "2"
    And I press the "Continue" button
    And I press the "Confirm and empanel jury" button

    #check in more jurors and put on panel
    And I press the "Apps" button
    And I click on the "Juror management" link
    And I click on the "Record attendance" link
    And I set the radio button to "Check in"
    And I set "Hour" to "09"
    And I set "Minute" to "00"
    And I set the radio button to "am"

    And I input juror "<juror_number11>" to be checked in
    And I press the "Check in juror" button
    And I see "<juror_number11>" on the page
    And I input juror "<juror_number16>" to be checked in
    And I press the "Check in juror" button
    And I see "<juror_number16>" on the page

    #add them to trial panel
    And I press the "Apps" button
    And I click on the "Trial management" link
    And I click on the "T202544457" link
    And I press the "Add panel members" button
    And I choose the "All available jurors" radio button
    And I set "Number of extra jurors needed on this panel" to "2"
    And I press the "Continue" button

    #check in other jurors
    And I press the "Apps" button
    And I click on the "Juror management" link
    And I click on the "Record attendance" link
    And I set the radio button to "Check in"
    And I set "Hour" to "09"
    And I set "Minute" to "00"
    And I see "Check out" on the page
    And I set the radio button to "am"

    And I input juror "<juror_number02>" to be checked in
    And I press the "Check in juror" button
    And I see "<juror_number02>" on the page

    And I input juror "<juror_number03>" to be checked in
    And I press the "Check in juror" button
    And I see "<juror_number03>" on the page

    And I input juror "<juror_number07>" to be checked in
    And I press the "Check in juror" button
    And I see "<juror_number07>" on the page

    And I input juror "<juror_number12>" to be checked in
    And I press the "Check in juror" button
    And I see "<juror_number12>" on the page

    And I input juror "<juror_number17>" to be checked in
    And I press the "Check in juror" button
    And I see "<juror_number17>" on the page

    And I set the radio button to "Check out"
    And I set "Hour" to "4"
    And I set "Minute" to "00"
    And I select the checkout radio button to "pm"
    And I input juror "<juror_number03>" to be checked out
    And I press the "Check out juror" button
    And I see "<juror_number03>" on the page

    And I see "attendance" on the page
    And I click on the previous attendance day link "4" amount of times
    And I set the radio button to "Check in"
    And I set "Hour" to "09"
    And I set "Minute" to "00"
    And I set the radio button to "am"

    And I input juror "<juror_number21>" to be checked in
    And I press the "Check in juror" button

    And I see "<juror_number21>" on the page
    And I set the radio button to "Check out"
    And I set "Hour" to "4"
    And I set "Minute" to "00"
    And I select the checkout radio button to "pm"
    And I input juror "<juror_number21>" to be checked out
    And I press the "Check out juror" button
    And I see "<juror_number21>" on the page

    When I press the "Confirm attendance" button
    And I press the "Confirm attendance list is correct" button

    #search for pool and set a juror to on call
    And I press the "Apps" button
    And I click on the "Pool management" link
    And I click on the "Search" link
    And I set "Pool number" to "<pool_number05>"
    And I press the "Continue" button
    Then I see "<juror_number21>" on the page
    And I check the "<juror_number21>" checkbox
    And I press the "On call" button
    And I press the "Place juror(s) on call" button
    And I see "On Call" in the same row as "<juror_number21>"

    #I record an expense for a juror
    And I press the "Apps" button
    And I click on the "Juror management" link
    And I click on the "Unpaid attendance" link
    And I see "<juror_number21>" on the page
    And I click on "View expenses" in the same row as "<juror_number21>"
    And I click link with ID "expenseDateLink"
    And I see "Loss of earnings or benefits" on the page
    When I set "Loss of earnings or benefits" to "20"
    And I press the "Save and back to all days" button
    And I press the "Save and back to all days" button
    And I see "Total in draft" on the page

    When I click on the "HMCTS Juror" link

    Then total expected today donut displays "13"
    And on the dashboard the total "Checked-in" today matches "4"
    And on the dashboard the total "Checked-out" today matches "1"
    And on the dashboard the total "On trials" today matches "4"
    And on the dashboard the total "Not checked-in" today matches "4"

    Then total expected in the last 7 days donut displays "6"
    And on the dashboard the total "Expected" in the last 7 days matches "6"
    And on the dashboard the total "Attended" in the last 7 days matches "1"
    And on the dashboard the total "On trials" in the last 7 days matches "0"
    And on the dashboard the total "Absent" in the last 7 days matches "0"

    And on the dashboard the total due to attend matches "9"
    And on the dashboard the total with reasonable adjustments matches "1"
    And on the dashboard the total unconfirmed attendances matches "9"
    And on the dashboard the total on call matches "1"
    And on the dashboard the total unpaid attendances matches "1"
    And on the dashboard the oldest unpaid attendance is "4" days old

    And on the dashboard the date monthly utilisation report last run matches "-"
    And on the dashboard the Last run monthly utilisation percentage matches "-"

    Examples:
      | juror_number01  | juror_number02  | juror_number03  | juror_number04  | juror_number05  | juror_number06  | juror_number07  | juror_number08  | juror_number09  | juror_number10  | juror_number11  | juror_number12  | juror_number13  | juror_number14  | juror_number15  | juror_number16  | juror_number17  | juror_number18  | juror_number19  | juror_number20  | juror_number21  | pool_number01 | pool_number02 | pool_number03 | pool_number04 | pool_number05 |
      | 076798010       | 076798011       | 076798012       | 076798013       | 076798014       | 076798015       | 076798016       | 076798017       | 076798018       | 076798019       | 076798020       | 076798021       | 076798022       | 076798023       | 076798024       | 076798025       | 076798026       | 076798027       | 076798028       | 076798029       | 076798030       | 767980910     | 767980911     | 767980912     | 767980913     | 767980914     |