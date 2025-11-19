Feature: As a court officer I want to reinstate a jury for active trial

  @JurorTransformationMulti
  Scenario Outline: Reinstate Jury

    Given I am on "Bureau" "ithc"
#
    Given a bureau owned pool is created with jurors
      | court | juror_number     | pool_number     | att_date_weeks_in_future | owner |
      | 415   | <juror_number01> | <pool_number01> | 0                        | 400   |
      | 415   | <juror_number02> | <pool_number01> | 0                        | 400   |
      | 415   | <juror_number03> | <pool_number01> | 0                        | 400   |
      | 415   | <juror_number04> | <pool_number01> | 0                        | 400   |
      | 415   | <juror_number05> | <pool_number01> | 0                        | 400   |
      | 415   | <juror_number06> | <pool_number01> | 0                        | 400   |
      | 415   | <juror_number07> | <pool_number01> | 0                        | 400   |
      | 415   | <juror_number08> | <pool_number01> | 0                        | 400   |
      | 415   | <juror_number09> | <pool_number01> | 0                        | 400   |
      | 415   | <juror_number10> | <pool_number01> | 0                        | 400   |
      | 415   | <juror_number11> | <pool_number01> | 0                        | 400   |
      | 415   | <juror_number12> | <pool_number01> | 0                        | 400   |
      | 415   | <juror_number13> | <pool_number01> | 0                        | 400   |
      | 415   | <juror_number14> | <pool_number01> | 0                        | 400   |
      | 415   | <juror_number15> | <pool_number01> | 0                        | 400   |
      | 415   | <juror_number16> | <pool_number01> | 0                        | 400   |

    Then a new pool is inserted for where record has transferred to the court new schema
      | part_no          | pool_no         | owner |
      | <juror_number01> | <pool_number01> | 415   |
      | <juror_number02> | <pool_number01> | 415   |
      | <juror_number03> | <pool_number01> | 415   |
      | <juror_number04> | <pool_number01> | 415   |
      | <juror_number05> | <pool_number01> | 415   |
      | <juror_number06> | <pool_number01> | 415   |
      | <juror_number07> | <pool_number01> | 415   |
      | <juror_number08> | <pool_number01> | 415   |
      | <juror_number09> | <pool_number01> | 415   |
      | <juror_number10> | <pool_number01> | 415   |
      | <juror_number11> | <pool_number01> | 415   |
      | <juror_number12> | <pool_number01> | 415   |
      | <juror_number13> | <pool_number01> | 415   |
      | <juror_number14> | <pool_number01> | 415   |
      | <juror_number15> | <pool_number01> | 415   |
      | <juror_number16> | <pool_number01> | 415   |

    Given I set pool "<pool_number01>" loc_code to be "767"

    Given I delete trial "T202511111" and associated records

    #log on and search for juror
    And I log in as "MODTESTCOURT" selecting court "767"

    #respond jurors
    And I update juror "<juror_number01>" to have a status of responded in order to record attendance
    And I update juror "<juror_number02>" to have a status of responded in order to record attendance
    And I update juror "<juror_number03>" to have a status of responded in order to record attendance
    And I update juror "<juror_number04>" to have a status of responded in order to record attendance
    And I update juror "<juror_number05>" to have a status of responded in order to record attendance
    And I update juror "<juror_number06>" to have a status of responded in order to record attendance
    And I update juror "<juror_number07>" to have a status of responded in order to record attendance
    And I update juror "<juror_number08>" to have a status of responded in order to record attendance
    And I update juror "<juror_number09>" to have a status of responded in order to record attendance
    And I update juror "<juror_number10>" to have a status of responded in order to record attendance
    And I update juror "<juror_number11>" to have a status of responded in order to record attendance
    And I update juror "<juror_number12>" to have a status of responded in order to record attendance
    And I update juror "<juror_number13>" to have a status of responded in order to record attendance
    And I update juror "<juror_number14>" to have a status of responded in order to record attendance
    And I update juror "<juror_number15>" to have a status of responded in order to record attendance
    And I update juror "<juror_number16>" to have a status of responded in order to record attendance

    #check in jurors to put on a trial
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

    And I input juror "<juror_number02>" to be checked in
    And I press the "Check in juror" button
    And I see "<juror_number02>" on the page

    And I input juror "<juror_number03>" to be checked in
    And I press the "Check in juror" button
    And I see "<juror_number03>" on the page

    And I input juror "<juror_number04>" to be checked in
    And I press the "Check in juror" button
    And I see "<juror_number04>" on the page

    And I input juror "<juror_number05>" to be checked in
    And I press the "Check in juror" button
    And I see "<juror_number05>" on the page

    And I input juror "<juror_number06>" to be checked in
    And I press the "Check in juror" button
    And I see "<juror_number06>" on the page

    And I input juror "<juror_number07>" to be checked in
    And I press the "Check in juror" button
    And I see "<juror_number07>" on the page

    And I input juror "<juror_number08>" to be checked in
    And I press the "Check in juror" button
    And I see "<juror_number08>" on the page

    And I input juror "<juror_number09>" to be checked in
    And I press the "Check in juror" button
    And I see "<juror_number09>" on the page

    And I input juror "<juror_number10>" to be checked in
    And I press the "Check in juror" button
    And I see "<juror_number10>" on the page

    And I input juror "<juror_number11>" to be checked in
    And I press the "Check in juror" button
    And I see "<juror_number11>" on the page

    And I input juror "<juror_number12>" to be checked in
    And I press the "Check in juror" button
    And I see "<juror_number12>" on the page

    And I input juror "<juror_number13>" to be checked in
    And I press the "Check in juror" button
    And I see "<juror_number13>" on the page

    And I input juror "<juror_number14>" to be checked in
    And I press the "Check in juror" button
    And I see "<juror_number14>" on the page

    And I input juror "<juror_number15>" to be checked in
    And I press the "Check in juror" button
    And I see "<juror_number14>" on the page

    And I input juror "<juror_number16>" to be checked in
    And I press the "Check in juror" button
    And I see "<juror_number14>" on the page

    #Create trial
    And I press the "Apps" button
    And I click on the "Trial management" link

    And I press the "Create a trial" button
    And I see "Create a trial" on the page

    And I set "Case number" to "T202511111"
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

    And I see "T202511111" on the page
    And I press the "Generate panel" button
    And I see "Generate a panel" on the page
    And I see "Which jurors do you want to generate a panel from?" on the page
    And I set the radio button to "All available jurors"
    And I set "Number of jurors needed on this panel" to "16"
    And I press the "Continue" button

    And I select the Select all checkbox on the trial
    And I press the "Empanel jury" button
    And I set input field with "id" of "numberOfJurors" to "14"
    And I press the "Continue" button
    And I select the radio button with name "<juror_number15>" and value "unused"
    And I select the radio button with name "<juror_number16>" and value "challenged"
    And I press the "Confirm and empanel jury" button

    #return jury
    And I select the Select all checkbox on the trial
    And I press the "Return jury" button
    And I see "How do you want to return the jurors you selected?" on the page
    And I set the radio button to "Return and confirm attendance"
    And I press the "Continue" button
    And I see "Confirm attendance" on the page

    #check in on confirm attendance
    And I set juror check in hour to "9" on confirm attendance
    And I set juror check in minute to "20" on confirm attendance
    And I click on the am radio button for juror check in on confirm attendance

    #check out on confirm attendance
    And I set juror check out hour to "2" on confirm attendance
    And I set juror check out minute to "30" on confirm attendance
    And I click on the pm radio button for juror check out on confirm attendance

    And I press the "Continue" button
    And I see "Return jurors and confirm attendance" on the page

    #return juror
    And I press the "Return" button

    #do not end trial
    And I choose the "No" radio button
    And I press the "Continue" button
    And I see "14 jurors returned" on the page

    #reinstate jury
    When I press the "Reinstate jury" button
    Then I see "You can reinstate jurors who were previously on this trial." on the page
    And I see "0 of 14 selected" on the page
    And I check the select all checkbox
    And I press the "Reinstate" button
    Then I see "14 jurors reinstated" on the page
    And I see "Juror" in the same row as "<juror_number01>"
    And I see "Juror" in the same row as "<juror_number02>"
    And I see "Juror" in the same row as "<juror_number03>"
    And I see "Juror" in the same row as "<juror_number04>"
    And I see "Juror" in the same row as "<juror_number05>"
    And I see "Juror" in the same row as "<juror_number06>"
    And I see "Juror" in the same row as "<juror_number07>"
    And I see "Juror" in the same row as "<juror_number08>"
    And I see "Juror" in the same row as "<juror_number09>"
    And I see "Juror" in the same row as "<juror_number10>"
    And I see "Juror" in the same row as "<juror_number11>"
    And I see "Juror" in the same row as "<juror_number12>"
    And I see "Juror" in the same row as "<juror_number13>"
    And I see "Juror" in the same row as "<juror_number14>"
    And I do not see "<juror_number15>" on the page
    And I do not see "<juror_number16>" on the page

    Then on "JUROR_MOD" . "JUROR_POOL" I see "STATUS" is "4" where "JUROR_NUMBER" is "<juror_number01>"
    Then on "JUROR_MOD" . "JUROR_POOL" I see "STATUS" is "4" where "JUROR_NUMBER" is "<juror_number02>"
    Then on "JUROR_MOD" . "JUROR_POOL" I see "STATUS" is "4" where "JUROR_NUMBER" is "<juror_number03>"
    Then on "JUROR_MOD" . "JUROR_POOL" I see "STATUS" is "4" where "JUROR_NUMBER" is "<juror_number04>"
    Then on "JUROR_MOD" . "JUROR_POOL" I see "STATUS" is "4" where "JUROR_NUMBER" is "<juror_number05>"
    Then on "JUROR_MOD" . "JUROR_POOL" I see "STATUS" is "4" where "JUROR_NUMBER" is "<juror_number06>"
    Then on "JUROR_MOD" . "JUROR_POOL" I see "STATUS" is "4" where "JUROR_NUMBER" is "<juror_number07>"
    Then on "JUROR_MOD" . "JUROR_POOL" I see "STATUS" is "4" where "JUROR_NUMBER" is "<juror_number08>"
    Then on "JUROR_MOD" . "JUROR_POOL" I see "STATUS" is "4" where "JUROR_NUMBER" is "<juror_number09>"
    Then on "JUROR_MOD" . "JUROR_POOL" I see "STATUS" is "4" where "JUROR_NUMBER" is "<juror_number10>"
    Then on "JUROR_MOD" . "JUROR_POOL" I see "STATUS" is "4" where "JUROR_NUMBER" is "<juror_number11>"
    Then on "JUROR_MOD" . "JUROR_POOL" I see "STATUS" is "4" where "JUROR_NUMBER" is "<juror_number12>"
    Then on "JUROR_MOD" . "JUROR_POOL" I see "STATUS" is "4" where "JUROR_NUMBER" is "<juror_number13>"
    Then on "JUROR_MOD" . "JUROR_POOL" I see "STATUS" is "4" where "JUROR_NUMBER" is "<juror_number14>"
    Then on "JUROR_MOD" . "JUROR_POOL" I see "STATUS" is "2" where "JUROR_NUMBER" is "<juror_number15>"
    Then on "JUROR_MOD" . "JUROR_POOL" I see "STATUS" is "2" where "JUROR_NUMBER" is "<juror_number16>"

    Examples:
      | juror_number01 | juror_number02 | juror_number03 | juror_number04 | juror_number05 | juror_number06 | juror_number07 | juror_number08 | juror_number09 | juror_number10 | juror_number11 | juror_number12 | juror_number13| juror_number14 | juror_number15 | juror_number16 | pool_number01 |
      | 076798031      | 076798032      | 076798033      | 076798034      | 076798035      | 076798036      | 076798037      | 076798038      | 076798039      | 076798040      | 076798041      | 076798042      | 076798043     | 076798044      | 076798045      | 076798046      | 767980915      |