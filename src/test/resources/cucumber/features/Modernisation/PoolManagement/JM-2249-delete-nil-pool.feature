  Feature: JM-2249

  @JurorTransformationWIP @NewSchemaConverted @JM-5347
  Scenario: Happy Path to delete a nil pool of jurors

    Given I am on "Bureau" "test"

    And I log in as "MODTESTBUREAU"

    When I navigate to the pool request screen

    When I press the "Create pool" button
    And I set the radio button to "Nil pool"
    And I press the "Continue" button
    Then I see "Select a court for this pool" on the page

    #select court

    Then I set input field with "ID" of "courtNameOrLocation" to "CHESTER"
    Then I click on the "Chester (415)" link
    Then I press the "Continue" button

    #check page content

    And on the page I see
      | text|
      |Request a new pool|
      |Court name or location code|
      |Chester                    |
      |Attendance date            |
      |Pool type                  |
      |Crown court                |
      |High court                 |
      |Civil court                |
      |Number of jurors required in total|
      |Number of court deferrals to include in this pool|

    And I see the attendance date of the pool

    #complete new pool fields
    Then I click the change link for the court deferrals
    And I change the number of court deferrals to "0"

    Then I set the radio button to "Crown"
    And I set "Number of jurors required in total" to "0"
    Then I press the "Continue" button

    #check pool request

    Then I see "Check your pool request" on the page

    And I should see the details of the pool
      | courtName              | Chester (415)                 |
      | poolType               | Crown court                   |
      | totalJurorsRequired    | 0                             |
      | numberOfDeferrals      | 0                             |
      | additionalJurors       | 0                             |

    # Can submit the new pool request

    When I save the new pool request
    Then I should be taken to the pool summary page

    And I should see the newly created pool request
      | court          | Chester        |
      | jurorsRequired |                |

    # Opening pool request overview

    When I click on the pool number
    Then the system will display non-editable information on the nil pool summary screen
      | court          | Chester        |
      | courtCode      | 415            |
    And I see "This is a nil pool created by the court. No jurors have been requested." on the page
    And I do not see the nil pool status
    And I do not see "Additional requirements" on the page

    # Deleting pool request

    When I click the delete pool request button
    Then I am asked if I'm sure I want to delete
    When I click the confirm deletion button
    Then a message is displayed on the pool requests page informing me that the pool has been deleted
    And the pool is no longer visible

  @JurorTransformationWIP @NewSchemaConverted @JM-5347
  Scenario: Cancel deletion of nil pool

    Given I am on "Bureau" "test"

    And I log in as "MODTESTBUREAU"

    When I navigate to the pool request screen

    When I press the "Create pool" button
    And I set the radio button to "Nil pool"
    And I press the "Continue" button
    Then I see "Select a court for this pool" on the page

    #select court

    Then I set input field with "ID" of "courtNameOrLocation" to "CHESTER"
    Then I click on the "Chester (415)" link
    Then I press the "Continue" button

    #check page content

    And on the page I see
      | text|
      |Request a new pool|
      |Court name or location code|
      |Chester                    |
      |Attendance date            |
      |Pool type                  |
      |Crown court                |
      |High court                 |
      |Civil court                |
      |Number of jurors required in total|
      |Number of court deferrals to include in this pool|

    And I see the attendance date of the pool

    #complete new pool fields
    Then I click the change link for the court deferrals
    And I change the number of court deferrals to "0"

    Then I set the radio button to "Crown"
    And I set "Number of jurors required in total" to "0"
    Then I press the "Continue" button

    #check pool request

    Then I see "Check your pool request" on the page

    And I should see the details of the pool
      | courtName              | Chester (415)                 |
      | poolType               | Crown court                   |
      | totalJurorsRequired    | 0                             |
      | numberOfDeferrals      | 0                             |
      | additionalJurors       | 0                             |

    # Can submit the new pool request

    When I save the new pool request
    Then I should be taken to the pool summary page

    And I should see the newly created pool request
      | court          | Chester        |
      | jurorsRequired |                |

    # Opening pool request overview

    When I click on the pool number
    Then the system will display non-editable information on the nil pool summary screen
      | court          | Chester        |
      | courtCode      | 415            |
    And I see "This is a nil pool created by the court. No jurors have been requested." on the page
    And I do not see the nil pool status
    And I do not see "Additional requirements" on the page

    # Deleting pool request

    When I click the delete pool request button
    Then I am asked if I'm sure I want to delete
    When I click the cancel deletion link
    Then the system will display non-editable information on the nil pool summary screen
      | court          | Chester        |
      | courtCode      | 415            |

