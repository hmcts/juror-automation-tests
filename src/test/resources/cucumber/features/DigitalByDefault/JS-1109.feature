Feature: JS-1109

  @JurorTransformation
  Scenario Outline: As a bureau officer I want to be able to see the paper packs I have sent

    Given I am on "Bureau" "<environment>"

    Given a bureau owned pool is created with jurors
      | court |juror_number   | pool_number	    | att_date_weeks_in_future	| owner |
      | 431   |<juror_number> | <pool_number>	| 5				            | 400	|
      | 431   |<juror_number2>| <pool_number>	| 5				            | 400	|

    Given I update "<juror_number>" to set them up for digital by default
    Given I update "<juror_number2>" to set them up for digital by default
    And juror "<juror_number>" has "LAST_NAME" as "PAPERPACKS" new schema
    And juror "<juror_number>" has "POSTCODE" as "CH2 2AA" new schema

    And I log in as "MODTESTBUREAU"

    And I search for juror "<juror_number>"
    And I see "Juror is part of the digital by default pilot" on the page

    #change communication preference to paper
    And I click on the "Juror details" link
    And I see "Digital" in the same row as "Communication preference"
    And I see "-" in the same row as "Date of birth"
    And I click on the "Add or change" link
    And the radio button "Digital" is "selected"
    And I check the "Paper" checkbox
    And I press the "Save" button
    And I check the "Leave as Lewes (431)" checkbox
    And I press the "Continue" button

    #send paper summons pack
    And I see "Do you want to send a paper summons pack to the juror?" on the page
    And I check the "Yes" checkbox
    And I press the "Continue" button
    And I see "Paper" in the same row as "Communication preference"

    #check history
    And I click on the "History" link
    Then I see "Response Pack" on the page

    #do the same for juror2
    And I search for juror "<juror_number2>"
    And I see "Juror is part of the digital by default pilot" on the page

    #change communication preference to paper
    And I click on the "Juror details" link
    And I see "Digital" in the same row as "Communication preference"
    And I see "-" in the same row as "Date of birth"
    And I click on the "Add or change" link
    And the radio button "Digital" is "selected"
    And I check the "Paper" checkbox
    And I press the "Save" button
    And I check the "Leave as Lewes (431)" checkbox
    And I press the "Continue" button

    #send paper summons pack
    And I see "Do you want to send a paper summons pack to the juror?" on the page
    And I check the "Yes" checkbox
    And I press the "Continue" button
    And I see "Paper" in the same row as "Communication preference"

    #check pending response pack
    When I press the "Apps" button
    And I click on the "Documents" link
    Then I see link with text "Paper packs sent"
    
    When I click on the "Paper packs sent" link
    Then I see "Paper packs sent" on the page

    #view all pending paper packs
    When I choose the "Show all letters queued for printing" radio button
    And I press the "Search" button
    Then I see "Showing results for 'all letters'" on the page
    And I see "Pending" in the same row as "<juror_number>"
    And I click on the "Change" link
    Then I see "Paper packs sent" on the page

    #search by last name
    When I choose the "Juror name" radio button
    And I set "Enter juror name" to "PAPERPACKS"
    And I press the "Search" button
    Then I see "Showing results for 'PAPERPACKS'" on the page
    And I see "Pending" in the same row as "<juror_number>"
    And I click on the "Change" link
    Then I see "Paper packs sent" on the page

    #search by pool number
    When I choose the "Pool" radio button
    And I set "Enter pool number" to "<pool_number>"
    And I press the "Search" button
    Then I see "Showing results for '<pool_number>'" on the page
    And I see "Pending" in the same row as "<juror_number>"
    And I click on the "Change" link
    Then I see "Paper packs sent" on the page

    #search by postcode
    When I choose the "Juror postcode" radio button
    And I set "Enter juror postcode" to "CH2 2AA"
    And I press the "Search" button
    Then I see "Showing results for 'CH2 2AA'" on the page
    And I see "Pending" in the same row as "<juror_number>"
    And I click on the "Change" link
    Then I see "Paper packs sent" on the page

    #search by juror number
    When I choose the "Juror number" radio button
    And I set "Enter juror number" to "<juror_number>"
    And I press the "Search" button
    Then I see "Showing results for '<juror_number>'" on the page
    And I see "<juror_number>" on the page
    And I see "Pending" in the same row as "<juror_number>"

    #update letter for juror1 to sent
    And I update the letter for "<juror_number>" to set the status to sent

    #requery juror
    When I click on the "Change" link
    Then I see "Paper packs sent" on the page
    When I choose the "Juror number" radio button
    And I set "Enter juror number" to "<juror_number>"
    And I press the "Search" button
    Then I see "Showing results for '<juror_number>'" on the page
    And I see "<juror_number>" on the page
    When I check the checkbox in the same row as "<juror_number>"
    And I press the "Resend paper packs" button
    Then I see "1 document sent for printing" on the page

    #requery and see pending and sent documents
    When I press the "Apps" button
    And I click on the "Documents" link
    Then I see link with text "Paper packs sent"
    When I click on the "Paper packs sent" link
    Then I see "Paper packs sent" on the page

    When I choose the "Juror number" radio button
    And I set "Enter juror number" to "<juror_number>"
    And I press the "Search" button
    Then I see "Showing results for '<juror_number>'" on the page

    #update letter for juror2 to sent
    And I update the letter for "<juror_number2>" to set the status to sent

    #search by pool number
    And I click on the "Change" link
    Then I see "Paper packs sent" on the page
    When I choose the "Pool" radio button
    And I set "Enter pool number" to "<pool_number>"
    And I press the "Search" button
    Then I see "Showing results for '<pool_number>'" on the page
    And I see "Pending" in the same row as "<juror_number>"
    And I see "CH2 2AA" in the same row as "<juror_number2>"

    #update letter for juror to sent
    And I update the letter for "<juror_number>" to set the status to sent

    #send multiple
    When I check the checkbox in the same row as "<juror_number>"
    And I check the checkbox in the same row as "<juror_number2>"
    And I press the "Resend paper packs" button
    Then I see "2 documents sent for printing" on the page

    Examples:
      | juror_number	| juror_number2	| pool_number	| environment   |
      | 043100200		| 043100201		| 431309171     | ithc          |
