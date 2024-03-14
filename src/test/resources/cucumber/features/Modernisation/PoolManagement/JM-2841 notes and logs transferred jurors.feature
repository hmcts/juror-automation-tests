Feature: JM-2841 Notes and Logs for Transferred Jurors

  @JurorTransformationWIP @JM-5161
  Scenario Outline: Court Transferred Juror retains Notes and Call logs
    Given I am on "Bureau" "test"

    #reset data to summoned state
    Given a bureau owned pool is created with jurors
      | court |juror_number  	| pool_number	| att_date_weeks_in_future	| owner |
      | 415   |<juror_number> 	| <pool_number> | 5				            | 400	|

    And I log in as "MODTESTBUREAU"
    When the user searches for juror record "<juror_number>" from the global search bar
    And I record a happy path paper summons response and process now

    #insert a court owned record and update bureau owned record to show it has transferred to the court
    Then a new pool is inserted for where record has transferred to the court new schema
      |part_no        | pool_no       | owner |
      |<juror_number> | <pool_number> | 415   |

    #log in as Court user and search for juror
    Given I am on "Bureau" "test"
    And I log in as "<user>"
    When the user searches for juror record "<juror_number>" from the global search bar

    #record Notes on 415 record
    And I record notes "Notes for juror"
    Then I see "Notes for juror" on the page

    #JM-5994
    #record call log on 415 record
    And I record call log "Phone inquiry from juror"
    Then I see "Phone inquiry from juror" on the page

    #transfer juror to 407
    And I click the update juror record button
    And I click the transfer to another pool radio button
    And I press the "Continue" button

    #select court and attendance date
    When I set input field with "ID" of "courtNameOrLocation" to "407"
    And I click on the "Dorchester (407)" link
    And I set attendance date to "5" Mondays in the future
    And I press the "Continue" button

    Then I see "Transfer to Dorchester (407)" on the page
    When I press the "Continue" button

    When the user searches for juror record "<juror_number>" from the global search bar
    Then I see "Chester" on the page

    #log on as Bureau user
    Given I am on "Bureau" "test"
    And I log in as "MODTESTBUREAU"
    When the user searches for juror record "<juror_number>" from the global search bar

    Then I see "<juror_number>" in the same row as "Dorchester"
    And I see "<juror_number>" in the same row as "Chester"

    #search for juror at new pool 407
    When I click on "<juror_number>" in the same row as "Dorchester"

    And I see "407" on the page
    And I see "Dorchester" on the page

    Then I click on the "Notes" link
    Then I see "Notes for juror" on the page

    Then I click on the "Contact log" link
    Then I see "Phone inquiry from juror" on the page

    #@JM-5992
    #add a new note to Dorchester juror record
    And I record notes "Notes for Dorchester owned juror record"
    Then I see "Notes for Dorchester owned juror record" on the page

    #record call log to Dorchester juror record
    And I record call log "Phone inquiry from Dorchester owned record"
    Then I see "Phone inquiry from Dorchester owned record" on the page
    Then I do not see "Phone inquiry from juror" on the page

    #log on as 415 court user
    Given I am on "Bureau" "test"
    And I log in as "<user>"

    #search for juror at original pool 415
    And I search for juror "<juror_number>"
    Then I see "Chester" on the page

    Then I click on the "Notes" link
    Then I see "Notes for Dorchester owned juror record" on the page

    Then I click on the "Contact log" link
    Then I see "Phone inquiry from juror" on the page
    Then I do not see "Phone inquiry from Dorchester owned record" on the page

    #transfer juror
    And I click the update juror record button
    And I click the transfer to another pool radio button
    And I press the "Continue" button

    #select court and attendance date
    When I set input field with "ID" of "courtNameOrLocation" to "457"
    And I click on the "Swansea Crown Court (457)" link
    And I set attendance date to "5" Mondays in the future
    And I press the "Continue" button

    Then I see "Transfer to Swansea Crown Court (457)" on the page
    When I press the "Continue" button

    #search for juror at new pool
    And I search for juror "<juror_number>"
    When I click on "<juror_number>" in the same row as "Swansea"

    Then I click on the "Notes" link
    #fails due to JM-5161
    And I see "457" on the page
    Then I see "Notes for juror" on the page

    Then I click on the "Contact log" link
    Then I see "Phone inquiry from juror" on the page

    #add a new note to Swansea juror record
    And I record notes "Notes for Swansea owned juror record"
    Then I see "Notes for Swansea owned juror record" on the page

    #record call log to Swansea juror record
    And I record call log "Phone inquiry from Swansea owned record"
    Then I see "Phone inquiry from Swansea owned record" on the page
    Then I do not see "Phone inquiry from juror" on the page
    Then I do not see "Phone inquiry from Dorchester owned record" on the page

    #search for juror at original pool
    And I search for juror "<juror_number>"
    When I click on "<juror_number>" in the same row as "Chester"

    Then I click on the "Notes" link
    Then I see "Notes for Swansea owned juror record" on the page

    Then I click on the "Contact log" link
    Then I see "Phone inquiry from juror" on the page
    Then I do not see "Phone inquiry from Dorchester owned record" on the page
    Then I do not see "Phone inquiry from Swansea owned record" on the page

    Examples:
      | user	      | juror_number  | pool_number |
      | MODTESTCOURT  | 041500040     | 415300129   |