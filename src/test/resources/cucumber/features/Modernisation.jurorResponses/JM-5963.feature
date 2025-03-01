Feature: JM-5963 - As a jury I need to be able to print a certificate of attendance

  @JurorTransformationMulti
  Scenario Outline: As a court officer I want to print a certificate of exemption

    Given I am on "Bureau" "ithc"

    Given a bureau owned pool is created with jurors
      | court |juror_number  	| pool_number	| att_date_weeks_in_future	| owner |
      | 415   |<juror_number> 	| <pool_number> | 5				            | 400	|

    Then a new pool is inserted for where record has transferred to the court new schema
      |part_no          | pool_no       | owner |
      |<juror_number>   | <pool_number> | 415   |

    And I update juror "<juror_number>" to have a status of responded in order to record attendance
    And I Confirm all the data in the record attendance table is cleared
    And I log in as "<user>"

    #check in jurors
    And I press the "Apps" button
    And I click on the "Juror management" link
    And I click on the "Record attendance" link
    And I set the radio button to "Check in"
    And I set "Hour" to "09"
    And I set "Minute" to "00"
    And I set the radio button to "am"
    And I input juror "<juror_number>" to be checked in
    And I press the "Check in juror" button
    And I see "<juror_number>" in the same row as "9:00am"
    And I set the radio button to "Check out"
    And I set "Hour" to "4"
    And I set "Minute" to "00"
    And I select the checkout radio button to "pm"
    And I input juror "<juror_number>" to be checked out
    And I press the "Check out juror" button

    And I press the "Apps" button
    And I click on the "Documents" link
    And I click on the "Certificate of attendance" link
    And I set the radio button to "Juror"
    And I set "Enter juror number" to "<juror_number>"
    And I press the "Search" button

    And I see "Certificates of attendance" on the page
    And I check the "<juror_number>" checkbox
    And I press the "Print certificate of attendance" button
    And I see "/documents/certificate-attendance/letters-list?documentSearchBy=juror_number&jurorNumber=041587205" in the URL

    Examples:
      |user			| juror_number | pool_number  |
      |MODTESTCOURT | 041587205    | 415320579    |


  @JurorTransformation
  Scenario Outline: As a court officer I want to print a certificate of exemption - previously printed

    Given I am on "Bureau" "ithc"

    Given a bureau owned pool is created with jurors
      | court |juror_number     | pool_number	    | att_date_weeks_in_future	| owner |
      | 415   |<juror_number>   | <pool_number>     | 5				            | 400	|

    Then a new pool is inserted for where record has transferred to the court new schema
      |part_no          | pool_no           | owner |
      |<juror_number>   | <pool_number>     | 415   |

    And I update juror "<juror_number>" to have a status of responded in order to record attendance
    And I Confirm all the data in the record attendance table is cleared
    And I update the bureau transfer date of the juror "<juror_number>"
    And I log in as "<user>"

    #check in jurors
    And I press the "Apps" button
    And I click on the "Juror management" link
    And I click on the "Record attendance" link
    And I set the radio button to "Check in"
    And I set "Hour" to "09"
    And I set "Minute" to "00"
    And I set the radio button to "am"
    And I input juror "<juror_number>" to be checked in
    And I press the "Check in juror" button
    And I see "<juror_number>" in the same row as "9:00am"

    And I press the "Confirm attendance" button

    And I see "Some jurors have not been checked out" on the page
    And I set "Hour" to "4"
    And I set "Minute" to "00"
    And I set the radio button to "pm"
    And I press the "Continue" button

    And I see "Confirm attendance list" on the page
    And I press the "Confirm attendance list is correct" button

    And I press the "Apps" button
    And I click on the "Documents" link
    And I click on the "Certificate of attendance" link
    And I set the radio button to "Juror"
    And I set "Enter juror number" to "<juror_number>"
    And I press the "Search" button

    And I see "Certificates of attendance" on the page
    And I check the juror "<juror_number>" checkbox
    And I press the "Print certificate of attendance" button

    And I press the "Apps" button
    And I click on the "Documents" link
    And I click on the "Certificate of attendance" link
    And I set the radio button to "Juror"
    And I set "Enter juror number" to "<juror_number>"
    And I press the "Search" button
    And I see "Certificates of attendance" on the page
    And I see "Showing results for '<juror_number>" on the page

    Examples:
      |user			| juror_number | pool_number |
      |MODTESTCOURT | 041587403    | 415322579   |