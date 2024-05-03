Feature: JM-252_Navigation

  @JurorTransformation @NewSchemaConverted
  Scenario Outline: Navigating back and forth and changing inputs

    Given I am on "Bureau" "test"

    #INSERT NEW POOL WITH DEFERRALS
    Given the new pool for court "457" is deleted new schema
    Given the new pool for court "415" is deleted new schema
    Given a new pool is inserted for court "415" with a deferral date "15" Mondays in the future new schema

    #log in
    And I log in as "<user>"

    #request a pool
    When I navigate to the pool request screen
    Then I press the "Create pool" button
    And I set the radio button to "Request new pool"
    And I press the "Continue" button
    Then I see "Select a court for this pool" on the page

    #select court and change
    Then I set input field with "ID" of "courtNameOrLocation" to "BURY"
    And I see "Bury St Edmunds (754)" on the page
    Then I click on the "Bury St Edmunds" link
    Then I clear field with id "courtNameOrLocation"
    Then I set input field with "ID" of "courtNameOrLocation" to "457"
    And I see "Swansea Crown Court (457)" on the page
    Then I click on the "Swansea" link

    # cancel
    Then I click on the "Cancel" link
    Then I see "Pool requests" on the page
    And I see "Filter by court name or location code" on the page

    # reselect create new pool
    Then I press the "Create pool" button
    And I set the radio button to "Request new pool"
    And I press the "Continue" button
    Then I set input field with "ID" of "courtNameOrLocation" to "457"
    Then I click on the "Swansea" link
    Then I press the "Continue" button

    #check page content
    And on the page I see
      | text                                              |
      | Request a new pool                                |
      | Court name or location code                       |
      | Swansea Crown Court                               |
      | Attendance date                                   |
      | Pool type                                         |
      | Crown court                                       |
      | High court                                        |
      | Civil court                                       |
      | Number of jurors required in total                |
      | Number of court deferrals to include in this pool |

    #CHANGE COURT
    Then  I click the change link for the chosen court
    And I see "Select a court for this pool" on the page
    Then I set input field with "ID" of "courtNameOrLocation" to "<displayCourt>"
    And I click on the "<displayCourt> (<courtCode>)" link
    And I press the "Continue" button

    #CHANGE ATTENDANCE DATE
    Then I click the change link for the attendance date
    And I see "Change the service start date for this pool" on the page
    And I set the "Change the service start date for this pool" date to a Monday "15" weeks in the future
    And I press the "Change" button

    #complete new pool fields
    Then I set the radio button to "High court"
    And I set "Number of jurors required in total" to "150"

    #SELECT TO CHANGE NUMBER OF DEFERRALS
    Then I click the change link for the court deferrals
    And I see "Number of court deferrals to include in this pool" on the page
    Then I change the number of court deferrals to "1"

    #REMOVE THIS WHEN FIXED - shouldnt have to re-enter pool type and number of jurors
    #complete new pool fields
    Then I set the radio button to "High court"
    And I set "Number of jurors required in total" to "150"

    Then I press the "Continue" button

    And I should see the details of the pool with a bank holiday date
      | courtName           | <displayCourt> (<courtCode>) |
      | poolType            | High court                   |
      | totalJurorsRequired | 150                          |
      | numberOfDeferrals   | 1                            |
      | additionalJurors    | 149                          |

    #change
    Then I click the change button for the check pool request page

    #Change pool type
    When I change the pool type to "Crown"

    #Change # jurors required
    When I set the number of jurors to "50"
    When I click the request pool button
    Then I should be taken to the check pool request page

    And I should see the details of the pool with a bank holiday date
      | courtName           | <displayCourt> (<courtCode>) |
      | poolType            | <courtTypeFull>              |
      | totalJurorsRequired | 50                           |
      | numberOfDeferrals   | 1                            |
      | additionalJurors    | 49                           |

    #Can submit the new pool request
    When I save the new pool request
    Then I should be taken to the pool summary page
    And I click on the "Service start date" link

    And I should see the newly created pool request
      | type           | Bureau         |
      | court          | <displayCourt> |
      | jurorsRequired | 49             |

    Given the new pool for court "415" is deleted
    Given the new pool for court "457" is deleted

    Examples:
      | user          | courtCode | displayCourt | courtTypeFull |
      | MODTESTBUREAU | 415       | Chester      | Crown court   |

  @JurorTransformation @NewSchemaConverted
  Scenario Outline: Create pools for different courts and apply filters
    Given I am on "Bureau" "test"

    And I log in as "<user>"

    When I navigate to the pool request screen

    When I press the "Create pool" button
    And I set the radio button to "Request new pool"
    And I press the "Continue" button
    Then I see "Select a court for this pool" on the page

    #select court
    Then I set input field with "ID" of "courtNameOrLocation" to "415"
    Then I click on the "Chester (415)" link
    Then I press the "Continue" button

    Then I set the radio button to "<courtType>"
    And I set "Number of jurors required in total" to "150"

    #SELECT TO CHANGE NUMBER OF DEFERRALS
    Then I click the change link for the court deferrals
    And I see "Number of court deferrals to include in this pool" on the page
    Then I change the number of court deferrals to "0"

    Then I set the radio button to "<courtType>"
    And I set "Number of jurors required in total" to "150"

    Then I press the "Continue" button

    When I save the new pool request
    Then I should be taken to the pool summary page
    And I click on the "Service start date" link

    And I should see the newly created pool request
      | type           | Bureau  |
      | court          | Chester |
      | jurorsRequired | 150     |

    When I press the "Create pool" button
    And I set the radio button to "Request new pool"
    And I press the "Continue" button
    Then I see "Select a court for this pool" on the page

    #select court

    Then I set input field with "ID" of "courtNameOrLocation" to "457"
    Then I click on the "Swansea Crown Court (457)" link
    Then I press the "Continue" button

    Then I set the radio button to "<courtType>"
    And I set "Number of jurors required in total" to "150"
    Then I press the "Continue" button

    When I save the new pool request
    Then I should be taken to the pool summary page
    And I click on the "Service start date" link

    And I should see the newly created pool request
      | type           | Bureau              |
      | court          | Swansea Crown Court |
      | jurorsRequired | 150                 |

    Then I set input field with "ID" of "courtNameOrLocation" to "415"
    Then I click on the "Chester (415)" link
    Then I press the "Filter" button
    Then only records from "Chester" are displayed

    Then I click on the "Clear filter" link

    Then I see "Chester" on the page
    And I see "Swansea" on the page

    Then I set input field with "ID" of "courtNameOrLocation" to "457"
    Then I click on the "Swansea Crown Court (457)" link
    Then I press the "Filter" button
    Then only records from "Swansea" are displayed

    Then I click on the "Clear filter" link

    Then I set input field with "ID" of "courtNameOrLocation" to "Chester"
    Then I click on the "Chester (415)" link
    Then I press the "Filter" button
    Then only records from "Chester" are displayed

    Then I click on the "Clear filter" link

    Then I see "Chester" on the page
    And I see "Swansea" on the page

    Then I set input field with "ID" of "courtNameOrLocation" to "Swansea"
    Then I click on the "Swansea Crown Court (457)" link
    Then I press the "Filter" button
    Then only records from "Swansea" are displayed

    Examples:
      | user          | courtType |
      | MODTESTBUREAU | Crown     |

  @JurorTransformation @NewSchemaConverted
  Scenario Outline: Create pool and change pool number
    Given I am on "Bureau" "test"
    Given new pool requests are deleted

    And I log in as "<user>"

    When I navigate to the pool request screen

    When I press the "Create pool" button
    And I set the radio button to "Request new pool"
    And I press the "Continue" button
    Then I see "Select a court for this pool" on the page

    #select court
    Then I set input field with "ID" of "courtNameOrLocation" to "415"
    Then I click on the "Chester (415)" link
    Then I press the "Continue" button

    Then I set the radio button to "<courtType>"
    And I set "Number of jurors required in total" to "150"

    #SELECT TO CHANGE NUMBER OF DEFERRALS
    Then I click the change link for the court deferrals
    And I see "Number of court deferrals to include in this pool" on the page
    Then I change the number of court deferrals to "0"

    Then I set the radio button to "<courtType>"
    And I set "Number of jurors required in total" to "150"

    Then I press the "Continue" button

    Then I click the change link for the pool number
    Then I click on the "Cancel" link

    When I save the new pool request
    Then I should be taken to the pool summary page
    And I click on the "Service start date" link

    And I should see the newly created pool request
      | type           | Bureau  |
      | court          | Chester |
      | jurorsRequired | 150     |

    Examples:
      | user          | courtType |
      | MODTESTBUREAU | Crown     |