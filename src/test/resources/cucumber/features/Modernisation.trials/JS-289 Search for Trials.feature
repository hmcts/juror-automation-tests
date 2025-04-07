Feature: JS-289 Search for Trials

  @JurorTransformation
  Scenario Outline: Test to search pool records as bureau officer

    Given I am on "Bureau" "demo"

    And I delete trial "TRIAL1" and associated records
    And I delete trial "TRIAL2" and associated records
    And I delete trial "ALTERNATE3" and associated records
    And I delete trial "WELSH4" and associated records

    And I log in as "<user>"

    #create a trial 1
    And I press the "Apps" button
    And I click on the "Trial management" link
    And I press the "Create a trial" button
    And I set "Case number" to "TRIAL1"
    Then I set the radio button to "Criminal"
    And I set "Defendants" to "Defendent One"
    And I set "Start date" to "today"

    And I set "Judge" to "PATRICIA H AITKEN"
    And I choose the "Chester" radio button
    And I set "Courtroom" to "JURY ASSEMBLY ROOM"
    And I press the "Create trial" button

    #create a trial 2
    And I press the "Apps" button
    And I click on the "Trial management" link
    And I press the "Create a trial" button
    And I set "Case number" to "TRIAL2"
    Then I set the radio button to "Criminal"
    And I set "Defendants" to "Defendent One"
    And I set "Start date" to "today"

    And I set "Judge" to "PATRICIA H AITKEN"
    And I choose the "Chester" radio button
    And I set "Courtroom" to "JURY ASSEMBLY ROOM"
    And I press the "Create trial" button

    #create a trial 3
    And I press the "Apps" button
    And I click on the "Trial management" link
    And I press the "Create a trial" button
    And I set "Case number" to "ALTERNATE3"
    Then I set the radio button to "Criminal"
    And I set "Defendants" to "Defendent One"
    And I set "Start date" to "today"

    And I set "Judge" to "PATRICIA H AITKEN"
    And I choose the "Chester" radio button
    And I set "Courtroom" to "JURY ASSEMBLY ROOM"
    And I press the "Create trial" button

    #I can see the trials Ive created
    And I press the "Apps" button
    And I click on the "Trial management" link
    Then I see "ALTERNATE3" on the page
    And I see "TRIAL2" on the page
    And I see "TRIAL1" on the page

    #log in as 457 user
    Given I am on "Bureau" "demo"
    And I log in as "SWANSEA" selecting court "457"

    #create a trial 4
    And I press the "Apps" button
    And I click on the "Trial management" link
    And I press the "Create a trial" button
    And I set "Case number" to "WELSH4"
    Then I set the radio button to "Criminal"
    And I set "Defendants" to "Defendent One"
    And I set "Start date" to "today"

    And I set "Judge" to "JOHN"
    And I set "Courtroom" to "JURY ASSEMBLY ROOM"
    And I press the "Create trial" button

    #I can see the trials Ive created
    And I press the "Apps" button
    And I click on the "Trial management" link
    Then I see "WELSH4" on the page
    And I do not see "ALTERNATE3" on the page
    And I do not see "TRIAL2" on the page
    And I do not see "TRIAL1" on the page

    #search on exact name, taken to trial details
    And I search for trial number "WELSH4"
    Then I see "/trials/WELSH4/457/detail" in the URL
    And I see "WELSH4" on the page

    And I press the "Apps" button
    And I click on the "Trial management" link

    #search on partial
    And I search for trial number "WELSH"
    And I see "/trials?isActive=true&trialNumber=WELSH" in the URL
    And I see "WELSH4" on the page

    And I do not see "ALTERNATE3" on the page
    And I do not see "TRIAL2" on the page
    And I do not see "TRIAL1" on the page

    #search on trials I dont have access to
    And I search for trial number "TRIAL"
    And I see "/trials?isActive=true&trialNumber=TRIAL" in the URL

    And I do not see "WELSH4" on the page
    And I do not see "ALTERNATE3" on the page
    And I do not see "TRIAL2" on the page
    And I do not see "TRIAL1" on the page

    #Search for a string > 16 chars
    And I search for trial number "AAAAAAAAAAAAAAAAAAAAAAAAAAAABBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPP"
    Then I see error "Trial number must be 16 characters or less"
    
    #search for a string in lower case
    And I search for trial number "welsh"
    And I see error "Enter a trial number using uppercase letters only"

    #search for a string including special chars
    And I search for trial number "welsh-4"
    And I see error "Enter a trial number using uppercase letters only"

    #log in as 415 user
    Given I am on "Bureau" "ithc"
    And I log in as "<user>"

    #I can see the trials Ive created
    And I press the "Apps" button
    And I click on the "Trial management" link

    And I see "ALTERNATE3" on the page
    And I see "TRIAL2" on the page
    And I see "TRIAL1" on the page
    Then I do not see "WELSH4" on the page

    #search on exact name, taken to trial details
    And I search for trial number "TRIAL1"
    Then I see "/trials/TRIAL1/415/detail" in the URL
    And I see "TRIAL1" on the page

    And I press the "Apps" button
    And I click on the "Trial management" link

    #search on partial
    And I search for trial number "TRIAL"
    And I see "/trials?isActive=true&trialNumber=TRIAL" in the URL
    And I see "TRIAL1" on the page
    And I see "TRIAL2" on the page
    And I do not see "ALTERNATE3" on the page
    And I do not see "WELSH4" on the page
    
    #clear search
    When I click on the "Clear search" link
    And I see "TRIAL1" on the page
    And I see "TRIAL2" on the page
    And I see "ALTERNATE3" on the page
    And I do not see "WELSH4" on the page

    Examples:
      | user          |
      | MODTESTCOURT  |