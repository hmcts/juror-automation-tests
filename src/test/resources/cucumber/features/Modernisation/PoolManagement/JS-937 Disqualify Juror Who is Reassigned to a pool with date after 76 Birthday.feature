Feature: JS-937 As an officer I want to be able to disqualify a juror that is too old when deferring

  @JurorTransformationMulti @Court
  Scenario Outline: Court User disqualify a juror that is too old when reassigning to a new pool via juror record

    Given I am on "Bureau" "<environment>"

    Given a bureau owned pool is created with jurors
      | court | juror_number  	  | pool_number	    | att_date_weeks_in_future	    | owner |
      | 415   | <juror_number_1>  | <pool_number>   | 5			                    | 400	|

    Then a new pool is inserted for where record has transferred to the court new schema
      | part_no               | pool_no          | owner |
      | <juror_number_1>      | <pool_number>    | 415   |

    Given a bureau owned pool is created with jurors
      | court | juror_number  	  | pool_number	    | att_date_weeks_in_future	    | owner |
      | 415   | <juror_number_2>  | <pool_number_2> | 40			                | 400	|

    Then a new pool is inserted for where record has transferred to the court new schema
      | part_no               | pool_no          | owner |
      | <juror_number_2>      | <pool_number_2>  | 415   |

    And I log in as "<user>"
    
    And I search for juror "<juror_number_1>"
    
    And I record a happy path paper summons response and process now
    And I click on the "<juror_number_1>" link
    And I click on the "Juror details" link
    And I click on the "Add or change" link
    And I see "Date of birth" on the page
    And I set the "Date of birth" single date field to a Monday "-3950" weeks in the future
    And I press the "Save" button

    When I press the "Update juror record" button
    And I set the radio button to "Reassign to another pool"
    And I press the "Continue" button
    And I choose the "<pool_number_2>" radio button
    And I press the "Continue" button

    Then I see "Check the juror's age" on the page
    And I see "You entered the new service start date as" on the page
    And I see "The juror's date of birth is" on the page
    And I see "This means they will be 76 years old on their new service start date and are not eligible for jury service." on the page
    And I see "Do you want to disqualify this juror?" on the page
    And I see link with text "No - change service start date"

    When I click on the "No - change service start date" link
    Then I see "Choose a pool to reassign to" on the page
    When I click on the "Cancel" link
    Then I see "juror-management/record/<juror_number_1>/overview" in the URL

    When I press the "Update juror record" button
    And I set the radio button to "Reassign to another pool"
    And I press the "Continue" button
    And I choose the "<pool_number_2>" radio button
    And I press the "Continue" button

    Then I see "Check the juror's age" on the page
    And I see "You entered the new service start date as" on the page
    And I see "The juror's date of birth is" on the page
    And I see "This means they will be 76 years old on their new service start date and are not eligible for jury service." on the page
    And I see "Do you want to disqualify this juror?" on the page
    And I see link with text "No - change service start date"

    When I press the "Yes - disqualify juror" button
    Then I see "Do you want to print a disqualification letter?" on the page
    And I set the radio button to "Yes"
    And I press the "Continue" button
    Then I see the juror record updated banner containing "Disqualified"
    And I see the juror status has updated to "Disqualified"

    When I click on the "Summons reply" link
    Then I see "Disqualified (age)" in the same row as "Processing outcome"

    When I click on the "Attendance" link
    Then I see "-" in the same row as "Next due at court"

    When I click on the "History" link
    Then I see "Juror disqualification" on the page
    And I see "Disqualified code - A" on the page

    Examples:
      | user         | juror_number_1 | pool_number | juror_number_2  | pool_number_2 | environment |
      | MODTESTCOURT | 041588783      | 415388683   | 041588784       | 415388684     | test        |

  @JurorTransformationMulti @Court
  Scenario Outline: Court User disqualify a juror that is too old when reassigning to a new pool - no letter

    Given I am on "Bureau" "<environment>"

    Given a bureau owned pool is created with jurors
      | court | juror_number  	  | pool_number	    | att_date_weeks_in_future	    | owner |
      | 415   | <juror_number_1>  | <pool_number>   | 5			                    | 400	|

    Then a new pool is inserted for where record has transferred to the court new schema
      | part_no               | pool_no          | owner |
      | <juror_number_1>      | <pool_number>    | 415   |

    Given a bureau owned pool is created with jurors
      | court | juror_number  	  | pool_number	    | att_date_weeks_in_future	    | owner |
      | 415   | <juror_number_2>  | <pool_number_2> | 40			                | 400	|

    Then a new pool is inserted for where record has transferred to the court new schema
      | part_no               | pool_no          | owner |
      | <juror_number_2>      | <pool_number_2>  | 415   |

    And I log in as "<user>"

    And I search for juror "<juror_number_1>"

    And I record a happy path paper summons response and process now
    And I click on the "<juror_number_1>" link
    And I click on the "Juror details" link
    And I click on the "Add or change" link
    And I see "Date of birth" on the page
    And I set the "Date of birth" single date field to a Monday "-3950" weeks in the future
    And I press the "Save" button

    When I press the "Update juror record" button
    And I set the radio button to "Reassign to another pool"
    And I press the "Continue" button
    And I choose the "<pool_number_2>" radio button
    And I press the "Continue" button

    Then I see "Check the juror's age" on the page
    And I see "You entered the new service start date as" on the page
    And I see "The juror's date of birth is" on the page
    And I see "This means they will be 76 years old on their new service start date and are not eligible for jury service." on the page
    And I see "Do you want to disqualify this juror?" on the page
    And I see link with text "No - change service start date"

    When I click on the "No - change service start date" link
    Then I see "Choose a pool to reassign to" on the page
    When I click on the "Cancel" link
    Then I see "juror-management/record/<juror_number_1>/overview" in the URL

    When I press the "Update juror record" button
    And I set the radio button to "Reassign to another pool"
    And I press the "Continue" button
    And I choose the "<pool_number_2>" radio button
    And I press the "Continue" button

    Then I see "Check the juror's age" on the page
    And I see "You entered the new service start date as" on the page
    And I see "The juror's date of birth is" on the page
    And I see "This means they will be 76 years old on their new service start date and are not eligible for jury service." on the page
    And I see "Do you want to disqualify this juror?" on the page
    And I see link with text "No - change service start date"

    When I press the "Yes - disqualify juror" button
    Then I see "Do you want to print a disqualification letter?" on the page
    And I set the radio button to "No"
    And I press the "Continue" button
    Then I see the juror record updated banner containing "Disqualified"
    And I see the juror status has updated to "Disqualified"

    When I click on the "Summons reply" link
    Then I see "Disqualified (age)" in the same row as "Processing outcome"

    When I click on the "Attendance" link
    Then I see "-" in the same row as "Next due at court"

    When I click on the "History" link
    Then I see "Juror disqualification" on the page
    And I see "Disqualified code - A" on the page

    Examples:
      | user         | juror_number_1 | pool_number | juror_number_2 | pool_number_2  | environment |
      | MODTESTCOURT | 041588785      | 415388685   | 041588786      | 415388686      | test        |

  @JurorTransformationMulti @Bureau
  Scenario Outline: Bureau User disqualify a juror that is too old when reassigning to a new pool via juror record

    Given I am on "Bureau" "<environment>"

    Given a bureau owned pool is created with jurors
      | court | juror_number  	  | pool_number	    | att_date_weeks_in_future	    | owner |
      | 415   | <juror_number_1>  | <pool_number>   | 5			                    | 400	|

    Given a bureau owned pool is created with jurors
      | court | juror_number  	  | pool_number	    | att_date_weeks_in_future	    | owner |
      | 415   | <juror_number_2>  | <pool_number_2> | 40		                    | 400	|

    And I log in as "<user>"

    And I search for juror "<juror_number_1>"

    And I record a happy path paper summons response and process now
    And I click on the "<juror_number_1>" link
    And I click on the "Juror details" link
    And I click on the "Add or change" link
    And I see "Date of birth" on the page
    And I set the "Date of birth" single date field to a Monday "-3950" weeks in the future
    And I press the "Save" button

    When I press the "Update juror record" button
    And I set the radio button to "Reassign to another pool"
    And I press the "Continue" button
    And I choose the "<pool_number_2>" radio button
    And I press the "Continue" button

    Then I see "Check the juror's age" on the page
    And I see "You entered the new service start date as" on the page
    And I see "The juror's date of birth is" on the page
    And I see "This means they will be 76 years old on their new service start date and are not eligible for jury service." on the page
    And I see "Do you want to disqualify this juror?" on the page
    And I see link with text "No - change service start date"

    When I click on the "No - change service start date" link
    Then I see "Choose a pool to reassign to" on the page
    When I click on the "Cancel" link
    Then I see "juror-management/record/<juror_number_1>/overview" in the URL

    When I press the "Update juror record" button
    And I set the radio button to "Reassign to another pool"
    And I press the "Continue" button
    And I choose the "<pool_number_2>" radio button
    And I press the "Continue" button

    Then I see "Check the juror's age" on the page
    And I see "You entered the new service start date as" on the page
    And I see "The juror's date of birth is" on the page
    And I see "This means they will be 76 years old on their new service start date and are not eligible for jury service." on the page
    And I see "Do you want to disqualify this juror?" on the page
    And I see link with text "No - change service start date"

    When I press the "Yes - disqualify juror" button
    Then I see the juror record updated banner containing "Disqualified"
    And I see the juror status has updated to "Disqualified"

    When I click on the "Summons reply" link
    Then I see "Disqualified (age)" in the same row as "Processing outcome"

    When I click on the "Attendance" link
    Then I see "-" in the same row as "Next due at court"

    When I click on the "History" link
    Then I see "Juror disqualification" on the page
    And I see "Disqualified code - A" on the page

    Examples:
      | user          | juror_number_1 | pool_number | juror_number_2 | pool_number_2 | environment |
      | MODTESTBUREAU | 041588787      | 415388687   | 041588788      | 415388688     | test        |

  @JurorTransformationMulti @Bureau
  Scenario Outline: Bureau User disqualify a juror that is too old when bulk reassigning from deferral maintenance

    Given I am on "Bureau" "<environment>"

    Given a bureau owned pool is created with jurors
      | court | juror_number  	  | pool_number	    | att_date_weeks_in_future	    | owner |
      | 416   | <juror_number_1>  | <pool_number>   | 5			                    | 400	|
      | 416   | <juror_number_3>  | <pool_number>   | 5			                    | 400	|

    Given a bureau owned pool is created with jurors
      | court | juror_number  	  | pool_number	    | att_date_weeks_in_future	    | owner |
      | 415   | <juror_number_2>  | <pool_number_2> | 40		                    | 400	|

    And juror "<juror_number_1>" has "LAST_NAME" as "TESTABC" new schema
    And juror "<juror_number_2>" has "LAST_NAME" as "TESTABC" new schema
    And juror "<juror_number_3>" has "LAST_NAME" as "TESTABC" new schema

    And I log in as "<user>"

    And I search for juror "<juror_number_1>"

    And I record a happy path paper summons response and process now

    When I search for juror "<juror_number_1>"
    When I press the "Update juror record" button
    And I set the radio button to "Deferral - grant or refuse"
    And I press the "Continue" button
    And I select "A - MOVED FROM AREA" from the "Reason for the deferral request" dropdown
    And I set the radio button to "Grant deferral"
    And I set the radio button to "Other"
    And I set "Deferral date" to "30 mondays time"
    And I press the "Continue" button

    And I search for juror "<juror_number_3>"

    And I record a happy path paper summons response and process now

    When I search for juror "<juror_number_3>"
    When I press the "Update juror record" button
    And I set the radio button to "Deferral - grant or refuse"
    And I press the "Continue" button
    And I select "A - MOVED FROM AREA" from the "Reason for the deferral request" dropdown
    And I set the radio button to "Grant deferral"
    And I set the radio button to "Other"
    And I set "Deferral date" to "30 mondays time"
    And I press the "Continue" button

    When I search for juror "<juror_number_1>"
    And I click on the "Juror details" link
    And I click on the "Add or change" link
    And I see "Date of birth" on the page
    And I set the "Date of birth" single date field to a Monday "-3950" weeks in the future
    And I press the "Save" button
    Then I see "You may need to reassign this juror to a different court" on the page
    And I choose the "Leave as Guildford Sitting At Chichester (416)" radio button
    And I press the "Continue" button

    And I press the "Apps" button
    And I click on the "Pool management" link
    And I click on the "Deferral maintenance" link
    And I see "Deferral maintenance" on the page
    And I set "Enter court name or location code" to "416"
    And I click on the "Guildford Sitting At Chichester (416)" link
    And I press the "Find" button

    And I press the "Show filter" button
    And I set "Date deferred to" to "30 mondays time"
    And I set "Last name" to "TESTABC"
    And I press the "Apply filters" button

    Then I see "<juror_number_1>" on the page
    And I see "<juror_number_3>" on the page

    Then I check the select all checkbox
    And I press the "Move to another court" button
    And I see "Select a court to move the selected jurors to" on the page
    And I set "Enter a court name or location code" to "415"
    Then I click on the "Chester (415)" link
    Then I press the "Continue" button

    And I choose the "<pool_number_2>" radio button
    And I press the "Continue" button

    Then I do not see "<juror_number_3>" on the page
    And I see "1 juror successfully moved to Chester (415) and remain deferred" on the page
    And I see "Not deferred due to age" on the page
    And I see "<juror_number_1>" on the page
    And I see "These jurors would be 76 or over on the new date. They have not been deferred." on the page
    And I see "<juror_number_1>" in the same row as "76"

    And I see link with text "Cancel and return to deferral maintenance"

    When I press the "Disqualify jurors" button
    Then I see "1 juror successfully moved to Chester (415) and remain deferred. 1 juror disqualified due to age." on the page

    When I search for juror "<juror_number_1>"
    And I see the juror status has updated to "Disqualified"

    When I click on the "Summons reply" link
    Then I see "Disqualified (age)" in the same row as "Processing outcome"

    When I click on the "Attendance" link
    Then I see "-" in the same row as "Next due at court"

    When I click on the "History" link
    Then I see "Juror disqualification" on the page
    And I see "Disqualified code - A" on the page

    When I search for juror "<juror_number_3>"
    And I see "<juror_number_3>" on the page
    And I see the juror status has updated to "Deferred"

    Examples:
      | user          | juror_number_1 | pool_number | juror_number_2 | juror_number_3| pool_number_2 | environment |
      | MODTESTBUREAU | 041688789      | 416388689   | 041688790      | 041688791     | 416388690     | test        |

  @JurorTransformationMulti @Bureau
  Scenario Outline: Bureau User disqualify a juror that is too old when bulk reassigning from pool overview

    Given I am on "Bureau" "<environment>"

    Given a bureau owned pool is created with jurors
      | court | juror_number  	  | pool_number	    | att_date_weeks_in_future	    | owner |
      | 416   | <juror_number_1>  | <pool_number>   | 5			                    | 400	|
      | 416   | <juror_number_3>  | <pool_number>   | 5			                    | 400	|

    Given a bureau owned pool is created with jurors
      | court | juror_number  	  | pool_number	    | att_date_weeks_in_future	    | owner |
      | 416   | <juror_number_2>  | <pool_number_2> | 40		                    | 400	|

    And juror "<juror_number_1>" has "LAST_NAME" as "TESTABC" new schema
    And juror "<juror_number_2>" has "LAST_NAME" as "TESTABC" new schema
    And juror "<juror_number_3>" has "LAST_NAME" as "TESTABC" new schema

    And I log in as "<user>"

    And I search for juror "<juror_number_1>"

    And I record a happy path paper summons response and process now

    And I search for juror "<juror_number_3>"

    And I record a happy path paper summons response and process now

    When I search for juror "<juror_number_1>"
    And I click on the "Juror details" link
    And I click on the "Add or change" link
    And I see "Date of birth" on the page
    And I set the "Date of birth" single date field to a Monday "-3950" weeks in the future
    And I press the "Save" button
    Then I see "You may need to reassign this juror to a different court" on the page
    And I choose the "Leave as Guildford Sitting At Chichester (416)" radio button
    And I press the "Continue" button

    And I press the "Apps" button
    And I click on the "Pool management" link
    And I click on the "Search" link
    And I set "Pool number" to "<pool_number>"
    And I press the "Continue" button

    Then I check the select all checkbox
    And I press the "Reassign" button
    And I choose the "<pool_number_2>" radio button
    And I press the "Continue" button

    Then I do not see "<juror_number_3>" on the page
    And I see "Not reassigned due to age" on the page
    And I see "These jurors would be 76 or over on the new date. They have not been reassigned." on the page
    And I see "<juror_number_1>" on the page
    And I see "<juror_number_1>" in the same row as "76"

    And I see link with text "Cancel and return to pool overview"

    When I press the "Disqualify jurors" button
    Then I see "1 juror disqualified due to age." on the page

    When I click on the "<juror_number_1>" link
    And I see the juror status has updated to "Disqualified"

    When I click on the "Summons reply" link
    Then I see "Disqualified (age)" in the same row as "Processing outcome"

    When I click on the "Attendance" link
    Then I see "-" in the same row as "Next due at court"

    When I click on the "History" link
    Then I see "Juror disqualification" on the page
    And I see "Disqualified code - A" on the page

    When I search for juror "<juror_number_3>"
    And I see "<juror_number_3>" on the page
    And I see "<pool_number_2>" on the page

    Examples:
      | user          | juror_number_1 | pool_number | juror_number_2 | juror_number_3| pool_number_2 | environment |
      | MODTESTBUREAU | 041688792      | 416388692   | 041688793      | 041688793     | 416388694     | test        |

  @JurorTransformationMulti @Court
  Scenario Outline: Bureau User disqualify a juror that is too old when changing catchment area via juror record

    Given I am on "Bureau" "<environment>"

    Given a bureau owned pool is created with jurors
      | court | juror_number  	  | pool_number	    | att_date_weeks_in_future	    | owner |
      | 415   | <juror_number_1>  | <pool_number>   | 5			                    | 400	|

    Given a bureau owned pool is created with jurors
      | court | juror_number  	  | pool_number	    | att_date_weeks_in_future	    | owner |
      | 407   | <juror_number_2>  | <pool_number_2> | 40		                    | 400	|

    And I log in as "<user>"

    And I search for juror "<juror_number_1>"

    And I record a happy path paper summons response and process now

    And juror "<juror_number_1>" has "DOB" as "-3950 mondays time" new schema

    And I click on the "<juror_number_1>" link
    And I click on the "Juror details" link
    And I click on the "Add or change" link
    And I click on the "Change" link in the same row as "Address"
    And I set "Postcode" to "PO19 7AA"
    And I press the "Review Edit" button

    And I see "Juror details" on the page
    And I press the "Save" button

    Then I see "You may need to reassign this juror to a different court" on the page
    And I choose the "Select a different court" radio button
    And I set "Court name or location code" to "407"
    Then I click on the "Dorchester (407)" link
    Then I press the "Continue" button

    Then I see "Choose a pool to reassign to" on the page
    And I choose the "<pool_number_2>" radio button
    Then I press the "Continue" button

    Then I see "Check the juror's age" on the page
    And I see "You entered the new service start date as" on the page
    And I see "The juror's date of birth is" on the page
    And I see "This means they will be 76 years old on their new service start date and are not eligible for jury service." on the page
    And I see "Do you want to disqualify this juror?" on the page
    And I see link with text "No - change service start date"

    When I click on the "No - change service start date" link
    Then I see "Choose a pool to reassign to" on the page
    When I click on the "Cancel" link

    And I click on the "Juror details" link
    And I click on the "Add or change" link
    And I click on the "Change" link in the same row as "Address"
    And I set "Postcode" to "PO19 7AA"
    And I press the "Review Edit" button

    And I see "Juror details" on the page
    And I press the "Save" button

    Then I see "You may need to reassign this juror to a different court" on the page
    And I choose the "Select a different court" radio button
    And I set "Court name or location code" to "407"
    Then I click on the "Dorchester (407)" link
    Then I press the "Continue" button

    Then I see "Choose a pool to reassign to" on the page
    And I choose the "<pool_number_2>" radio button
    Then I press the "Continue" button

    Then I see "Check the juror's age" on the page
    And I see "You entered the new service start date as" on the page
    And I see "The juror's date of birth is" on the page
    And I see "This means they will be 76 years old on their new service start date and are not eligible for jury service." on the page
    And I see "Do you want to disqualify this juror?" on the page
    And I see link with text "No - change service start date"

    When I press the "Yes - disqualify juror" button
    Then I see the juror record updated banner containing "Disqualified"
    And I see the juror status has updated to "Disqualified"

    When I click on the "Summons reply" link
    Then I see "Disqualified (age)" in the same row as "Processing outcome"

    When I click on the "Attendance" link
    Then I see "-" in the same row as "Next due at court"

    When I click on the "History" link
    Then I see "Juror disqualification" on the page
    And I see "Disqualified code - A" on the page

    Examples:
      | user          | juror_number_1 | pool_number | juror_number_2 | pool_number_2 | environment |
      | MODTESTBUREAU | 041588791      | 415388691   | 041588792      | 415388692     | test        |