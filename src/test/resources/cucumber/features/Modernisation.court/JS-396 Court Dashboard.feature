Feature: As a court officer I want to have a dashboard on the juror application so I can manage my court more effectively

  Scenario Outline: As a court officer I want to have a dashboard on the juror application so I can manage my court more effectively

    Given I am on "Bureau" "demo"

    Given a bureau owned pool is created with jurors
      | court |juror_number        | pool_number	  | att_date_weeks_in_future	| owner |
      | 457   |<juror_number01>    | <pool_number01>  | 0				            | 400	|
      | 457   |<juror_number02>    | <pool_number01>  | 0				            | 400	|
      | 457   |<juror_number03>    | <pool_number01>  | 0				            | 400	|
      | 457   |<juror_number04>    | <pool_number01>  | 0				            | 400	|
      | 457   |<juror_number05>    | <pool_number01>  | 0				            | 400	|

    Given a bureau owned pool is created with jurors
      | court |juror_number        | pool_number	  | att_date_weeks_in_future	| owner |
      | 457   |<juror_number06>    | <pool_number02>  | 0				            | 400	|
      | 457   |<juror_number07>    | <pool_number02>  | 0				            | 400	|
      | 457   |<juror_number08>    | <pool_number02>  | 0				            | 400	|
      | 457   |<juror_number09>    | <pool_number02>  | 0				            | 400	|
      | 457   |<juror_number10>    | <pool_number02>  | 0				            | 400	|

    Given a bureau owned pool is created with jurors
      | court |juror_number        | pool_number	  | att_date_weeks_in_future	| owner |
      | 457   |<juror_number11>    | <pool_number03>  | 0				            | 400	|
      | 457   |<juror_number12>    | <pool_number03>  | 0				            | 400	|
      | 457   |<juror_number13>    | <pool_number03>  | 0				            | 400	|
      | 457   |<juror_number14>    | <pool_number03>  | 0				            | 400	|
      | 457   |<juror_number15>    | <pool_number03>  | 0				            | 400	|

    Given a bureau owned pool is created with jurors
      | court |juror_number        | pool_number	  | att_date_weeks_in_future	| owner |
      | 457   |<juror_number16>    | <pool_number04>  | 0				            | 400	|
      | 457   |<juror_number17>    | <pool_number04>  | 0				            | 400	|
      | 457   |<juror_number18>    | <pool_number04>  | 0				            | 400	|
      | 457   |<juror_number19>    | <pool_number04>  | 0				            | 400	|
      | 457   |<juror_number20>    | <pool_number04>  | 0				            | 400	|

    Given a bureau owned pool is created with jurors
      | court |juror_number        | pool_number	  | att_date_weeks_in_future	| owner |
      | 457   |<juror_number21>    | <pool_number05>  | -1				            | 400	|

    Then a new pool is inserted for where record has transferred to the court new schema
      |part_no                 | pool_no          | owner |
      |<juror_number01>        | <pool_number01>  | 457   |
      |<juror_number02>        | <pool_number01>  | 457   |
      |<juror_number03>        | <pool_number01>  | 457   |
      |<juror_number04>        | <pool_number01>  | 457   |
      |<juror_number05>        | <pool_number01>  | 457   |

    Then a new pool is inserted for where record has transferred to the court new schema
      |part_no                 | pool_no          | owner |
      |<juror_number06>        | <pool_number02>  | 457   |
      |<juror_number07>        | <pool_number02>  | 457   |
      |<juror_number08>        | <pool_number02>  | 457   |
      |<juror_number09>        | <pool_number02>  | 457   |
      |<juror_number10>        | <pool_number02>  | 457   |

    Then a new pool is inserted for where record has transferred to the court new schema
      |part_no                 | pool_no          | owner |
      |<juror_number11>        | <pool_number03>  | 457   |
      |<juror_number12>        | <pool_number03>  | 457   |
      |<juror_number13>        | <pool_number03>  | 457   |
      |<juror_number14>        | <pool_number03>  | 457   |
      |<juror_number15>        | <pool_number03>  | 457   |

    Then a new pool is inserted for where record has transferred to the court new schema
      |part_no                 | pool_no          | owner |
      |<juror_number16>        | <pool_number04>  | 457   |
      |<juror_number17>        | <pool_number04>  | 457   |
      |<juror_number18>        | <pool_number04>  | 457   |
      |<juror_number19>        | <pool_number04>  | 457   |
      |<juror_number20>        | <pool_number04>  | 457   |

    Then a new pool is inserted for where record has transferred to the court new schema
      |part_no                 | pool_no          | owner |
      |<juror_number21>        | <pool_number05>  | 457   |

    Given I delete trial "T202544321" and associated records
    Given I delete trial "T202544457" and associated records

    #log on and search for juror
    And I log in as "SWANSEA" selecting court "457"

#    #respond jurors 1-3 of each pool and process
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
    And I input juror "<juror_number06>" to be checked in
    And I press the "Check in juror" button

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

#    And I set "Judge" to "PATRICIA H AITKEN"
    And I set "Judge" to "JOHN"
#    And I set the radio button to "Swanswea"
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
    And I input juror "<juror_number16>" to be checked in
    And I press the "Check in juror" button

    #add them to trial panel
    And I press the "Apps" button
    And I click on the "Trial management" link
    And I click on the "T202544457" link
    And I press the "Add panel members" button
    And I choose the "All available jurors" radio button
    And I set "Number of extra jurors needed on this panel" to "2"
    And I press the "Continue" button

#    #check in other jurors
    And I press the "Apps" button
    And I click on the "Juror management" link
    And I click on the "Record attendance" link
    And I set the radio button to "Check in"
    And I set "Hour" to "09"
    And I set "Minute" to "00"
    And I set the radio button to "am"

    And I input juror "<juror_number02>" to be checked in
    And I press the "Check in juror" button

    And I input juror "<juror_number03>" to be checked in
    And I press the "Check in juror" button

    And I input juror "<juror_number07>" to be checked in
    And I press the "Check in juror" button

    And I input juror "<juror_number12>" to be checked in
    And I press the "Check in juror" button

    And I input juror "<juror_number17>" to be checked in
    And I press the "Check in juror" button

    And I set the radio button to "Check out"
    And I set "Hour" to "4"
    And I set "Minute" to "00"
    And I set the radio button to "pm"
    And I input juror "<juror_number03>" to be checked out
    And I press the "Check out juror" button

    And I click on the previous attendance day link "2" amount of times
    And I set the radio button to "Check in"
    And I set "Hour" to "09"
    And I set "Minute" to "00"
    And I set the radio button to "am"

    And I input juror "<juror_number21>" to be checked in
    And I press the "Check in juror" button

    And I set the radio button to "Check out"
    And I set "Hour" to "4"
    And I set "Minute" to "00"
    And I see "pm" on the page
    And I set the radio button to "pm"
    And I input juror "<juror_number21>" to be checked out
    And I press the "Check out juror" button

    When I press the "Confirm attendance" button
    And I press the "Confirm attendance list is correct" button

    Examples:
      | juror_number01  | juror_number02  | juror_number03  | juror_number04  | juror_number05  | juror_number06  | juror_number07  | juror_number08  | juror_number09  | juror_number10  | juror_number11  | juror_number12  | juror_number13  | juror_number14  | juror_number15  | juror_number16  | juror_number17  | juror_number18  | juror_number19  | juror_number20  | juror_number21  | pool_number01 | pool_number02 | pool_number03 | pool_number04 | pool_number05 |
      | 045798010       | 045798011       | 045798012       | 045798013       | 045798014       | 045798015       | 045798016       | 045798017       | 045798018       | 045798019       | 045798020       | 045798021       | 045798022       | 045798023       | 045798024       | 045798025       | 045798026       | 045798027       | 045798028       | 045798029       | 045798030       | 457980910     | 457980911     | 457980912     | 457980913     | 457980914     |
