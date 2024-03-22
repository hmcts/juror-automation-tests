Feature: JM-5965 - Certificate of Exemption

  @JurorTransformation @NewSchemaConverted
  Scenario Outline:As a jury officer I want to print a certification of exemption letter for a juror in a trial

    Given I am on "Bureau" "test"
    When a bureau owned pool is created with jurors
      | court |juror_number  	    | pool_number	    | att_date_weeks_in_future	| owner |
      | 415   | <juror_number>| <pool_number>           | 5                          | 400  |

    Then a new pool is inserted for where record has transferred to the court new schema
      |part_no              | pool_no           | owner |
     | <juror_number>       | <pool_number>     | 415   |

    And I Confirm all the data in the record attendance table is cleared
    And a new trial is inserted with the trial number "<trial_number>"
    And I log in as "<user>"

    And I update juror "<juror_number>" to have a status of responded in order to record attendance

     #check in juror
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

    And I press the "Apps" button
    And I click on the "Trial management" link
    And I click on the trial number "<trial_number>"

    And I press the "Generate panel" button
    And I see "Generate a panel" on the page
    And I see "Which jurors do you want to generate a panel from?" on the page
    And I set the radio button to "All available jurors"
    And I set "Number of jurors needed on this panel" to "1"
    And I press the "Continue" button

    And I press the "Apps" button
    And I click on the "Documents" link
    And I click on the "Certificate of exemption" link
    And I see "Certificate of exemption" on the page
    Then I press the "Continue" button
    And I see "Select a trial that relates to this exemption" in the error banner
    And I set the radio button to "<trial_number>"
    Then I press the "Continue" button
    
    And I see "Exemption details" on the page
    And I see "How long should the jurors be exempt from jury service?" on the page
    Then I press the "Continue" button
    And I see error "Select a time period to exempt jurors"
    And I set the radio button to "Specific period of time"
    Then I press the "Continue" button
    And I see error "Enter how many years the jurors should be exempt for"

    Then I set "How many years?" to "2"
    And I press the "Continue" button
    And I see "Certificates of exemption" on the page
    Then I check the juror "<juror_number>" checkbox
    And I press the "Print certificate of exemption" button
    And I see "juror.staging.apps.hmcts.net/documents/certificate-of-exemption-list/EXEMPTIONCERT2?durationType=specific&durationYears=2" in the URL

    Examples:
      | juror_number  | pool_number | user          | trial_number           |
      |  041556217    | 415912387   | MODTESTCOURT  | EXEMPTIONCERT2         |

  @JurorTransformation @NewSchemaConverted
  Scenario Outline:As a jury officer I want to print a certification of exemption letter for a juror in a trial - indefinitely

    Given I am on "Bureau" "test"
    When a bureau owned pool is created with jurors
      | court |juror_number  	    | pool_number	    | att_date_weeks_in_future	| owner |
      | 415   | <juror_number>| <pool_number>           | 5                          | 400  |

    Then a new pool is inserted for where record has transferred to the court new schema
      |part_no              | pool_no           | owner |
      | <juror_number>       | <pool_number>     | 415   |

    And I Confirm all the data in the record attendance table is cleared
    And a new trial is inserted with the trial number "<trial_number>"
    And I log in as "<user>"

    And I update juror "<juror_number>" to have a status of responded in order to record attendance


   #check in juror
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

    And I press the "Apps" button
    And I click on the "Trial management" link
    And I click on the trial number "<trial_number>"

    And I press the "Generate panel" button
    And I see "Generate a panel" on the page
    And I see "Which jurors do you want to generate a panel from?" on the page
    And I set the radio button to "All available jurors"
    And I set "Number of jurors needed on this panel" to "1"
    And I press the "Continue" button

    And I press the "Apps" button
    And I click on the "Documents" link
    And I click on the "Certificate of exemption" link
    And I see "Certificate of exemption" on the page
    Then I press the "Continue" button
    And I see "Select a trial that relates to this exemption" in the error banner
    And I set the radio button to "<trial_number>"
    Then I press the "Continue" button

    And I see "Exemption details" on the page
    And I see "How long should the jurors be exempt from jury service?" on the page
    Then I press the "Continue" button
    And I see error "Select a time period to exempt jurors"
    And I set the radio button to "Indefinitely"
    Then I press the "Continue" button
    And I see "Certificates of exemption" on the page
    Then I check the juror "<juror_number>" checkbox
    And I press the "Print certificate of exemption" button
    And I see "juror.staging.apps.hmcts.net/documents/certificate-of-exemption-list/EXEMPTION2?durationType=indefinitely" in the URL

    Examples:
      | juror_number  | pool_number | user          | trial_number       |
      |  041556317    | 415912387   | MODTESTCOURT  | EXEMPTION2         |