Feature: JS-904 As an officer I want to be able to disqualify a juror that is too old when deferring

  @JurorTransformation @Court
  Scenario Outline: Court User disqualify a juror that is too old when deferring

    Given I am on "Bureau" "<environment>"

    Then I clear down pool and jurors in pool "415388672" via the database
    Then I clear down pool and jurors in pool "415388673" via the database
    Then I clear down pool and jurors in pool "415388674" via the database
    Then I clear down pool and jurors in pool "415388675" via the database
    Then I clear down pool and jurors in pool "415388676" via the database
    Then I clear down pool and jurors in pool "415388678" via the database
    Then I clear down pool and jurors in pool "415388680" via the database
    Then I clear down pool and jurors in pool "416388673" via the database
    Then I clear down pool and jurors in pool "415388681" via the database
    Then I clear down pool and jurors in pool "415388684" via the database
    Then I clear down pool and jurors in pool "415388686" via the database
    Then I clear down pool and jurors in pool "415388688" via the database
    Then I clear down pool and jurors in pool "416388690" via the database

    Given a bureau owned pool is created with jurors
      | court | juror_number  	  | pool_number	    | att_date_weeks_in_future	    | owner |
      | 415   | <juror_number_1>  | <pool_number>   | 5			                    | 400	|

    Then a new pool is inserted for where record has transferred to the court new schema
      | part_no               | pool_no          | owner |
      | <juror_number_1>      | <pool_number>    | 415   |

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
    And I set the radio button to "Deferral - grant or refuse"
    And I press the "Continue" button
    And I select "A - MOVED FROM AREA" from the "Reason for the deferral request" dropdown
    And I set the radio button to "Grant deferral"
    And I set the radio button to "Other"
    And I set "Deferral date" to "40 mondays time"
    And I press the "Continue" button

    Then I see "Check the juror's age" on the page
    And I see "You entered the new service start date as" on the page
    And I see "The juror's date of birth is" on the page
    And I see "This means they will be 76 years old on their new service start date and are not eligible for jury service." on the page
    And I see "Do you want to disqualify this juror?" on the page
    And I see link with text "No - change service start date"

    When I click on the "No - change service start date" link
    Then I see "Grant or refuse a deferral" on the page
    When I click on the "Cancel" link
    Then I see "juror-management/record/<juror_number_1>/overview" in the URL

    When I press the "Update juror record" button
    And I set the radio button to "Deferral - grant or refuse"
    And I press the "Continue" button
    And I select "A - MOVED FROM AREA" from the "Reason for the deferral request" dropdown
    And I set the radio button to "Grant deferral"
    And I set the radio button to "Other"
    And I set "Deferral date" to "40 mondays time"
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

    Then I clear down pool and jurors in pool "<pool_number>" via the database

    Examples:
      | user         | juror_number_1 | pool_number | environment |
      | MODTESTCOURT | 041588771      | 415388672   | ithc        |

  @JurorTransformation @Court
  Scenario Outline: Court User disqualify a juror that is too old when deferring - no letter

    Given I am on "Bureau" "<environment>"

    Then I clear down pool and jurors in pool "415388672" via the database
    Then I clear down pool and jurors in pool "415388673" via the database
    Then I clear down pool and jurors in pool "415388674" via the database
    Then I clear down pool and jurors in pool "415388675" via the database
    Then I clear down pool and jurors in pool "415388676" via the database
    Then I clear down pool and jurors in pool "415388678" via the database
    Then I clear down pool and jurors in pool "415388680" via the database
    Then I clear down pool and jurors in pool "416388673" via the database
    Then I clear down pool and jurors in pool "415388681" via the database
    Then I clear down pool and jurors in pool "415388684" via the database
    Then I clear down pool and jurors in pool "415388686" via the database
    Then I clear down pool and jurors in pool "415388688" via the database
    Then I clear down pool and jurors in pool "416388690" via the database

    Given a bureau owned pool is created with jurors
      | court | juror_number  	  | pool_number	    | att_date_weeks_in_future	    | owner |
      | 415   | <juror_number_1>  | <pool_number>   | 5			                    | 400	|

    Then a new pool is inserted for where record has transferred to the court new schema
      | part_no               | pool_no          | owner |
      | <juror_number_1>      | <pool_number>    | 415   |

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
    And I set the radio button to "Deferral - grant or refuse"
    And I press the "Continue" button
    And I select "A - MOVED FROM AREA" from the "Reason for the deferral request" dropdown
    And I set the radio button to "Grant deferral"
    And I set the radio button to "Other"
    And I set "Deferral date" to "50 mondays time"
    And I press the "Continue" button

    Then I see "Check the juror's age" on the page
    And I see "You entered the new service start date as" on the page
    And I see "The juror's date of birth is" on the page
    And I see "This means they will be 76 years old on their new service start date and are not eligible for jury service." on the page
    And I see "Do you want to disqualify this juror?" on the page
    And I see link with text "No - change service start date"

    When I click on the "No - change service start date" link
    Then I see "Grant or refuse a deferral" on the page
    When I click on the "Cancel" link
    Then I see "juror-management/record/<juror_number_1>/overview" in the URL

    When I press the "Update juror record" button
    And I set the radio button to "Deferral - grant or refuse"
    And I press the "Continue" button
    And I select "A - MOVED FROM AREA" from the "Reason for the deferral request" dropdown
    And I set the radio button to "Grant deferral"
    And I set the radio button to "Other"
    And I set "Deferral date" to "50 mondays time"
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

    Then I clear down pool and jurors in pool "<pool_number>" via the database

    Examples:
      | user         | juror_number_1 | pool_number | environment |
      | MODTESTCOURT | 041588777      | 415388674   | ithc        |

  @JurorTransformation @Bureau
  Scenario Outline: Bureau User disqualify a juror that is too old when deferring

    Given I am on "Bureau" "<environment>"

    Then I clear down pool and jurors in pool "415388672" via the database
    Then I clear down pool and jurors in pool "415388673" via the database
    Then I clear down pool and jurors in pool "415388674" via the database
    Then I clear down pool and jurors in pool "415388675" via the database
    Then I clear down pool and jurors in pool "415388676" via the database
    Then I clear down pool and jurors in pool "415388678" via the database
    Then I clear down pool and jurors in pool "415388680" via the database
    Then I clear down pool and jurors in pool "416388673" via the database
    Then I clear down pool and jurors in pool "415388681" via the database
    Then I clear down pool and jurors in pool "415388684" via the database
    Then I clear down pool and jurors in pool "415388686" via the database
    Then I clear down pool and jurors in pool "415388688" via the database
    Then I clear down pool and jurors in pool "416388690" via the database

    Given a bureau owned pool is created with jurors
      | court | juror_number  	  | pool_number	    | att_date_weeks_in_future	    | owner |
      | 415   | <juror_number_1>  | <pool_number>   | 5			                    | 400	|

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
    And I set the radio button to "Deferral - grant or refuse"
    And I press the "Continue" button
    And I select "A - MOVED FROM AREA" from the "Reason for the deferral request" dropdown
    And I set the radio button to "Grant deferral"
    And I set the radio button to "Other"
    And I set "Deferral date" to "40 mondays time"
    And I press the "Continue" button

    Then I see "Check the juror's age" on the page
    And I see "You entered the new service start date as" on the page
    And I see "The juror's date of birth is" on the page
    And I see "This means they will be 76 years old on their new service start date and are not eligible for jury service." on the page
    And I see "Do you want to disqualify this juror?" on the page
    And I see link with text "No - change service start date"

    When I click on the "No - change service start date" link
    Then I see "Grant or refuse a deferral" on the page
    When I click on the "Cancel" link
    Then I see "juror-management/record/<juror_number_1>/overview" in the URL

    When I press the "Update juror record" button
    And I set the radio button to "Deferral - grant or refuse"
    And I press the "Continue" button
    And I select "A - MOVED FROM AREA" from the "Reason for the deferral request" dropdown
    And I set the radio button to "Grant deferral"
    And I set the radio button to "Other"
    And I set "Deferral date" to "40 mondays time"
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

    Then I clear down pool and jurors in pool "<pool_number>" via the database

    Examples:
      | user          | juror_number_1 | pool_number | environment |
      | MODTESTBUREAU | 041588772      | 415388673   | ithc        |

  @JurorTransformation @Court
  Scenario Outline: Court User disqualify a juror that is too old when deferring from summons reply

    Given I am on "Bureau" "<environment>"

    Then I clear down pool and jurors in pool "415388672" via the database
    Then I clear down pool and jurors in pool "415388673" via the database
    Then I clear down pool and jurors in pool "415388674" via the database
    Then I clear down pool and jurors in pool "415388675" via the database
    Then I clear down pool and jurors in pool "415388676" via the database
    Then I clear down pool and jurors in pool "415388678" via the database
    Then I clear down pool and jurors in pool "415388680" via the database
    Then I clear down pool and jurors in pool "416388673" via the database
    Then I clear down pool and jurors in pool "415388681" via the database
    Then I clear down pool and jurors in pool "415388684" via the database
    Then I clear down pool and jurors in pool "415388686" via the database
    Then I clear down pool and jurors in pool "415388688" via the database
    Then I clear down pool and jurors in pool "416388690" via the database

    Given a bureau owned pool is created with jurors
      | court | juror_number  	  | pool_number	    | att_date_weeks_in_future	    | owner |
      | 415   | <juror_number_1>  | <pool_number>   | 5			                    | 400	|

    Then a new pool is inserted for where record has transferred to the court new schema
      | part_no               | pool_no          | owner |
      | <juror_number_1>      | <pool_number>    | 415   |

    And I log in as "<user>"

    And I search for juror "<juror_number_1>"

    And I record a happy path paper summons response
    And I click on the "No, skip and process later" link
    And I click on the "Add or change" link
    And I see "Date of birth" on the page
    And I set the "Date of birth" single date field to a Monday "-3950" weeks in the future
    And I press the "Continue" button

    When I press the "Process reply" button
    And I set the radio button to "Deferral request"
    And I press the "Continue" button
    And I set "First choice" to "40 mondays time"
    And I set "Second choice" to "41 mondays time"
    And I set "Third choice" to "42 mondays time"
    And I press the "Continue" button

    And I select "A - MOVED FROM AREA" from the "Reason for the deferral request" dropdown
    And I set the radio button to "Choose a different date"
    And I set "Date to defer to" to "43 mondays time"
    And I press the "Continue" button

    Then I see "There are no active pools for this date" on the page
    And I press the "Put in deferral maintenance" button

    Then I see "Check the juror's age" on the page
    And I see "You entered the new service start date as" on the page
    And I see "The juror's date of birth is" on the page
    And I see "This means they will be 76 years old on their new service start date and are not eligible for jury service." on the page
    And I see "Do you want to disqualify this juror?" on the page
    And I see link with text "No - change service start date"

    When I click on the "No - change service start date" link
    Then I see "Defer this juror" on the page
    When I click on the "Cancel" link
    Then I see "summons-replies/response/<juror_number_1>/paper" in the URL

    When I press the "Process reply" button
    And I set the radio button to "Deferral request"
    And I press the "Continue" button
    And I set "First choice" to "40 mondays time"
    And I set "Second choice" to "41 mondays time"
    And I set "Third choice" to "42 mondays time"
    And I press the "Continue" button

    And I select "A - MOVED FROM AREA" from the "Reason for the deferral request" dropdown
    And I set the radio button to "Choose a different date"
    And I set "Date to defer to" to "43 mondays time"
    And I press the "Continue" button

    Then I see "There are no active pools for this date" on the page
    And I press the "Put in deferral maintenance" button

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
    Then I see "Summons reply for <juror_number_1> fname lname successfully processed: Disqualified (Age)" on the page
    
    When I click on the "<juror_number_1>" link
    And I see the juror status has updated to "Disqualified"

    When I click on the "Summons reply" link
    Then I see "Disqualified (age)" in the same row as "Processing outcome"

    When I click on the "Attendance" link
    Then I see "-" in the same row as "Next due at court"

    When I click on the "History" link
    Then I see "Juror disqualification" on the page
    And I see "Disqualified code - A" on the page

    Then I clear down pool and jurors in pool "<pool_number>" via the database

    Examples:
      | user         | juror_number_1 | pool_number | environment |
      | MODTESTCOURT | 041588780      | 415388678   | ithc        |

  @JurorTransformation @Court
  Scenario Outline: Court User disqualify a juror that is too old when deferring from summons reply - no letter

    Given I am on "Bureau" "<environment>"

    Then I clear down pool and jurors in pool "415388672" via the database
    Then I clear down pool and jurors in pool "415388673" via the database
    Then I clear down pool and jurors in pool "415388674" via the database
    Then I clear down pool and jurors in pool "415388675" via the database
    Then I clear down pool and jurors in pool "415388676" via the database
    Then I clear down pool and jurors in pool "415388678" via the database
    Then I clear down pool and jurors in pool "415388680" via the database
    Then I clear down pool and jurors in pool "416388673" via the database
    Then I clear down pool and jurors in pool "415388681" via the database
    Then I clear down pool and jurors in pool "415388684" via the database
    Then I clear down pool and jurors in pool "415388686" via the database
    Then I clear down pool and jurors in pool "415388688" via the database
    Then I clear down pool and jurors in pool "416388690" via the database

    Given a bureau owned pool is created with jurors
      | court | juror_number  	  | pool_number	    | att_date_weeks_in_future	    | owner |
      | 415   | <juror_number_1>  | <pool_number>   | 5			                    | 400	|

    Then a new pool is inserted for where record has transferred to the court new schema
      | part_no               | pool_no          | owner |
      | <juror_number_1>      | <pool_number>    | 415   |

    And I log in as "<user>"

    And I search for juror "<juror_number_1>"

    And I record a happy path paper summons response
    And I click on the "No, skip and process later" link
    And I click on the "Add or change" link
    And I see "Date of birth" on the page
    And I set the "Date of birth" single date field to a Monday "-3950" weeks in the future
    And I press the "Continue" button

    When I press the "Process reply" button
    And I set the radio button to "Deferral request"
    And I press the "Continue" button
    And I set "First choice" to "40 mondays time"
    And I set "Second choice" to "41 mondays time"
    And I set "Third choice" to "42 mondays time"
    And I press the "Continue" button

    And I select "A - MOVED FROM AREA" from the "Reason for the deferral request" dropdown
    And I set the radio button to "Choose a different date"
    And I set "Date to defer to" to "43 mondays time"
    And I press the "Continue" button

    Then I see "There are no active pools for this date" on the page
    And I press the "Put in deferral maintenance" button

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
    Then I see "Summons reply for <juror_number_1> fname lname successfully processed: Disqualified (Age)" on the page

    When I click on the "<juror_number_1>" link
    And I see the juror status has updated to "Disqualified"

    When I click on the "Summons reply" link
    Then I see "Disqualified (age)" in the same row as "Processing outcome"

    When I click on the "Attendance" link
    Then I see "-" in the same row as "Next due at court"

    When I click on the "History" link
    Then I see "Juror disqualification" on the page
    And I see "Disqualified code - A" on the page

    Then I clear down pool and jurors in pool "<pool_number>" via the database

    Examples:
      | user         | juror_number_1 | pool_number | environment |
      | MODTESTCOURT | 041588779      | 415388675   | ithc        |

  @JurorTransformation @Bureau
  Scenario Outline: Bureau User disqualify a juror that is too old when deferring from summons reply

    Given I am on "Bureau" "<environment>"

    Then I clear down pool and jurors in pool "415388672" via the database
    Then I clear down pool and jurors in pool "415388673" via the database
    Then I clear down pool and jurors in pool "415388674" via the database
    Then I clear down pool and jurors in pool "415388675" via the database
    Then I clear down pool and jurors in pool "415388676" via the database
    Then I clear down pool and jurors in pool "415388678" via the database
    Then I clear down pool and jurors in pool "415388680" via the database
    Then I clear down pool and jurors in pool "416388673" via the database
    Then I clear down pool and jurors in pool "415388681" via the database
    Then I clear down pool and jurors in pool "415388684" via the database
    Then I clear down pool and jurors in pool "415388686" via the database
    Then I clear down pool and jurors in pool "415388688" via the database
    Then I clear down pool and jurors in pool "416388690" via the database

    Given a bureau owned pool is created with jurors
      | court | juror_number  	  | pool_number	    | att_date_weeks_in_future	    | owner |
      | 415   | <juror_number_1>  | <pool_number>   | 5			                    | 400	|

    And I log in as "<user>"

    And I search for juror "<juror_number_1>"

    And I record a happy path paper summons response
    And I click on the "No, skip and process later" link
    And I click on the "Add or change" link
    And I see "Date of birth" on the page
    And I set the "Date of birth" single date field to a Monday "-3950" weeks in the future
    And I press the "Continue" button

    When I press the "Process reply" button
    And I set the radio button to "Deferral request"
    And I press the "Continue" button
    And I set "First choice" to "40 mondays time"
    And I set "Second choice" to "41 mondays time"
    And I set "Third choice" to "42 mondays time"
    And I press the "Continue" button

    And I select "A - MOVED FROM AREA" from the "Reason for the deferral request" dropdown
    And I set the radio button to "Choose a different date"
    And I set "Date to defer to" to "43 mondays time"
    And I press the "Continue" button

    Then I see "There are no active pools for this date" on the page
    And I press the "Put in deferral maintenance" button

    Then I see "Check the juror's age" on the page
    And I see "You entered the new service start date as" on the page
    And I see "The juror's date of birth is" on the page
    And I see "This means they will be 76 years old on their new service start date and are not eligible for jury service." on the page
    And I see "Do you want to disqualify this juror?" on the page
    And I see link with text "No - change service start date"

    When I click on the "No - change service start date" link
    Then I see "Defer this juror" on the page
    When I click on the "Cancel" link
    Then I see "summons-replies/response/<juror_number_1>/paper" in the URL

    When I press the "Process reply" button
    And I set the radio button to "Deferral request"
    And I press the "Continue" button
    And I set "First choice" to "40 mondays time"
    And I set "Second choice" to "41 mondays time"
    And I set "Third choice" to "42 mondays time"
    And I press the "Continue" button

    And I select "A - MOVED FROM AREA" from the "Reason for the deferral request" dropdown
    And I set the radio button to "Choose a different date"
    And I set "Date to defer to" to "43 mondays time"
    And I press the "Continue" button

    Then I see "There are no active pools for this date" on the page
    And I press the "Put in deferral maintenance" button

    Then I see "Check the juror's age" on the page
    And I see "You entered the new service start date as" on the page
    And I see "The juror's date of birth is" on the page
    And I see "This means they will be 76 years old on their new service start date and are not eligible for jury service." on the page
    And I see "Do you want to disqualify this juror?" on the page
    And I see link with text "No - change service start date"

    When I press the "Yes - disqualify juror" button
    Then I see the summons reply disqualification success message
    And I see the juror status has updated to "Disqualified"

    When I click on the "View juror's record" link
    And I click on the "Summons reply" link
    Then I see "Disqualified (age)" in the same row as "Processing outcome"

    When I click on the "Attendance" link
    Then I see "-" in the same row as "Next due at court"

    When I click on the "History" link
    Then I see "Juror disqualification" on the page
    And I see "Disqualified code - A" on the page

    Then I clear down pool and jurors in pool "<pool_number>" via the database

    Examples:
      | user          | juror_number_1 | pool_number | environment |
      | MODTESTBUREAU | 041588778      | 415388676   | ithc        |

  @JurorTransformation @Court
  Scenario Outline: Court User disqualify a juror that is too old when postponing

    Given I am on "Bureau" "<environment>"

    Then I clear down pool and jurors in pool "415388672" via the database
    Then I clear down pool and jurors in pool "415388673" via the database
    Then I clear down pool and jurors in pool "415388674" via the database
    Then I clear down pool and jurors in pool "415388675" via the database
    Then I clear down pool and jurors in pool "415388676" via the database
    Then I clear down pool and jurors in pool "415388678" via the database
    Then I clear down pool and jurors in pool "415388680" via the database
    Then I clear down pool and jurors in pool "416388673" via the database
    Then I clear down pool and jurors in pool "415388681" via the database
    Then I clear down pool and jurors in pool "415388684" via the database
    Then I clear down pool and jurors in pool "415388686" via the database
    Then I clear down pool and jurors in pool "415388688" via the database
    Then I clear down pool and jurors in pool "416388690" via the database

    Given a bureau owned pool is created with jurors
      | court | juror_number  	  | pool_number	    | att_date_weeks_in_future	    | owner |
      | 415   | <juror_number_1>  | <pool_number>   | 5			                    | 400	|

    Then a new pool is inserted for where record has transferred to the court new schema
      | part_no               | pool_no          | owner |
      | <juror_number_1>      | <pool_number>    | 415   |

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
    And I set the radio button to "Postpone service start date"
    And I press the "Continue" button
    When I set the "Enter a new service start date" date to a Monday "40" weeks in the future
    And I press the "Continue" button

    Then I see "There are no active pools for this date" on the page
    And I press the "Put in deferral maintenance" button

    Then I see "Check the juror's age" on the page
    And I see "You entered the new service start date as" on the page
    And I see "The juror's date of birth is" on the page
    And I see "This means they will be 76 years old on their new service start date and are not eligible for jury service." on the page
    And I see "Do you want to disqualify this juror?" on the page
    And I see link with text "No - change service start date"

    And I click on the "No - change service start date" link
    Then I see "Enter a new service start date" on the page
    And I click on the "Cancel" link

    When I press the "Update juror record" button
    And I set the radio button to "Postpone service start date"
    And I press the "Continue" button
    When I set the "Enter a new service start date" date to a Monday "40" weeks in the future
    And I press the "Continue" button

    Then I see "There are no active pools for this date" on the page
    And I press the "Put in deferral maintenance" button

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

    Then I clear down pool and jurors in pool "<pool_number>" via the database

    Examples:
      | user         | juror_number_1 | pool_number | environment |
      | MODTESTCOURT | 041588782      | 415388681   | ithc        |

  @JurorTransformation @Bureau
  Scenario Outline: Bureau User disqualify a juror that is too old when postponing

    Given I am on "Bureau" "<environment>"

    Then I clear down pool and jurors in pool "415388672" via the database
    Then I clear down pool and jurors in pool "415388673" via the database
    Then I clear down pool and jurors in pool "415388674" via the database
    Then I clear down pool and jurors in pool "415388675" via the database
    Then I clear down pool and jurors in pool "415388676" via the database
    Then I clear down pool and jurors in pool "415388678" via the database
    Then I clear down pool and jurors in pool "415388680" via the database
    Then I clear down pool and jurors in pool "416388673" via the database
    Then I clear down pool and jurors in pool "415388681" via the database
    Then I clear down pool and jurors in pool "415388684" via the database
    Then I clear down pool and jurors in pool "415388686" via the database
    Then I clear down pool and jurors in pool "415388688" via the database
    Then I clear down pool and jurors in pool "416388690" via the database

    Given a bureau owned pool is created with jurors
      | court | juror_number  	  | pool_number	    | att_date_weeks_in_future	    | owner |
      | 415   | <juror_number_1>  | <pool_number>   | 5			                    | 400	|

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
    And I set the radio button to "Postpone service start date"
    And I press the "Continue" button
    When I set the "Enter a new service start date" date to a Monday "50" weeks in the future
    And I press the "Continue" button

    Then I see "There are no active pools for this date" on the page
    And I press the "Put in deferral maintenance" button

    Then I see "Check the juror's age" on the page
    And I see "You entered the new service start date as" on the page
    And I see "The juror's date of birth is" on the page
    And I see "This means they will be 76 years old on their new service start date and are not eligible for jury service." on the page
    And I see "Do you want to disqualify this juror?" on the page
    And I see link with text "No - change service start date"

    When I click on the "No - change service start date" link
    Then I see "Enter a new service start date" on the page
    When I click on the "Cancel" link

    When I press the "Update juror record" button
    And I set the radio button to "Postpone service start date"
    And I press the "Continue" button
    When I set the "Enter a new service start date" date to a Monday "50" weeks in the future
    And I press the "Continue" button

    Then I see "There are no active pools for this date" on the page
    And I press the "Put in deferral maintenance" button

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

    Then I clear down pool and jurors in pool "<pool_number>" via the database

    Examples:
      | user          | juror_number_1 | pool_number | environment |
      | MODTESTBUREAU | 041588781      | 415388680   | ithc        |

  @JurorTransformation @Bureau
  Scenario Outline: Bureau User disqualify a juror that is too old when bulk postponing from deferral maintenance

    Given I am on "Bureau" "<environment>"

    Then I clear down pool and jurors in pool "415388672" via the database
    Then I clear down pool and jurors in pool "415388673" via the database
    Then I clear down pool and jurors in pool "415388674" via the database
    Then I clear down pool and jurors in pool "415388675" via the database
    Then I clear down pool and jurors in pool "415388676" via the database
    Then I clear down pool and jurors in pool "415388678" via the database
    Then I clear down pool and jurors in pool "415388680" via the database
    Then I clear down pool and jurors in pool "416388673" via the database
    Then I clear down pool and jurors in pool "415388681" via the database
    Then I clear down pool and jurors in pool "415388684" via the database
    Then I clear down pool and jurors in pool "415388686" via the database
    Then I clear down pool and jurors in pool "415388688" via the database
    Then I clear down pool and jurors in pool "416388690" via the database

    Given a bureau owned pool is created with jurors
      | court | juror_number  	  | pool_number	    | att_date_weeks_in_future	    | owner |
      | 416   | <juror_number_1>  | <pool_number>   | 5			                    | 400	|

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
    Then I see "<juror_number_1>" on the page

    Then I check the select all checkbox
    And I press the "Postpone" button

    When I set the "Enter a new service start date" date to a Monday "50" weeks in the future
    And I press the "Continue" button

    Then I see "There are no active pools for this date" on the page
    And I press the "Put in deferral maintenance" button

    Then I see "Not postponed due to age" on the page
    And I see "These jurors would be 76 or over on the new date. They have not been postponed." on the page
    And I see link with text "Cancel and return to deferral maintenance"

    When I click on the "Cancel and return to deferral maintenance" link
    Then I see "Deferral maintenance" on the page

    And I press the "Postpone" button

    Then I see "Enter a new service start date" on the page
    When I set the "Enter a new service start date" date to a Monday "40" weeks in the future
    And I press the "Continue" button

    Then I see "There are no active pools for this date" on the page
    And I press the "Put in deferral maintenance" button

    Then I see "Not postponed due to age" on the page
    And I see "These jurors would be 76 or over on the new date. They have not been postponed." on the page
    And I see link with text "Cancel and return to deferral maintenance"

    When I press the "Disqualify jurors" button
    Then I see "1 juror disqualified due to age." on the page

    When I search for juror "<juror_number_1>"
    And I see the juror status has updated to "Disqualified"

    When I click on the "Summons reply" link
    Then I see "Disqualified (age)" in the same row as "Processing outcome"

    When I click on the "Attendance" link
    Then I see "-" in the same row as "Next due at court"

    When I click on the "History" link
    Then I see "Juror disqualification" on the page
    And I see "Disqualified code - A" on the page

    Then I clear down pool and jurors in pool "<pool_number>" via the database

    Examples:
      | user          | juror_number_1 | pool_number | environment |
      | MODTESTBUREAU | 041688772      | 416388673   | ithc        |