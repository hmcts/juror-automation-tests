Feature: JM-252 Bureau user create new pools

  @JurorTransformationMulti @newSchemaConverted
  Scenario Outline: Happy Path Test to create a new pool of jurors to be summoned for jury duty
    Given I am on "Bureau" "test"
    And I log in as "<user>"
    When I navigate to the pool request screen

    When I press the "Create pool" button
    And I set the radio button to "Request new pool"
    And I press the "Continue" button
    Then I see "Select a court for this pool" on the page

    #select court

    Then I set input field with "ID" of "courtNameOrLocation" to "<selectedCourt>"
    And I select the "<displayCourt> (<courtCode>)" court selection link
    Then I press the "Continue" button

    #check page content

    And on the page I see
      | text                                              |
      | Request a new pool                                |
      | Court name or location code                       |
      | <displayCourt>                                    |
      | Attendance date                                   |
      | Pool type                                         |
      | Crown court                                       |
      | High court                                        |
      | Civil court                                       |
      | Number of jurors required in total                |
      | Number of court deferrals to include in this pool |

    And I see the attendance date of the pool

    #complete new pool fields
    Then I click the change link for the court deferrals
    Then I change the number of court deferrals to "0"

    Then I set the radio button to "<courtType>"
    And I set "Number of jurors required in total" to "<noJurors>"
    Then I press the "Continue" button

    #check pool request

    Then I see "Check your pool request" on the page

    And I should see the details of the pool
      | courtName           | <displayCourt> (<courtCode>) |
      | poolType            | <courtTypeFull>              |
      | totalJurorsRequired | <noJurors>                   |
      | numberOfDeferrals   | 0                            |
      | additionalJurors    | <noJurors>                   |

    # Can submit the new pool request

    When I save the new pool request
    Then I should be taken to the pool summary page
    And I click on the "Service start date" link

    And I should see the newly created pool request
      | type           | Bureau         |
      | court          | <displayCourt> |
      | jurorsRequired | <noJurors>     |

    When I navigate to summons management

    Then I am taken to summons management

    Examples:
      | user          | selectedCourt | courtType | courtTypeFull | courtCode | displayCourt | noJurors |
      | MODTESTBUREAU | CHESTER       | Crown     | Crown court   | 415       | Chester      | 150      |
      | MODTESTBUREAU | CHESTER       | Civil     | Civil court   | 415       | Chester      | 150      |
      | MODTESTBUREAU | CHESTER       | High      | High court    | 415       | Chester      | 150      |

  @JurorTransformationMulti @NewSchemaConverted
  Scenario Outline: Happy Path Test to create a new pool with 0 jurors
    Given I am on "Bureau" "test"
    And I log in as "<user>"

    When I navigate to the pool request screen

    When I press the "Create pool" button
    And I set the radio button to "Request new pool"
    And I press the "Continue" button
    Then I see "Select a court for this pool" on the page

    #select court

    Then I set input field with "ID" of "courtNameOrLocation" to "<selectedCourt>"
    And I select the "<displayCourt> (<courtCode>)" court selection link
    Then I press the "Continue" button

    #check page content

    And on the page I see
      | text                                              |
      | Request a new pool                                |
      | Court name or location code                       |
      | <displayCourt>                                    |
      | Attendance date                                   |
      | Pool type                                         |
      | Crown court                                       |
      | High court                                        |
      | Civil court                                       |
      | Number of jurors required in total                |
      | Number of court deferrals to include in this pool |

    And I see the attendance date of the pool

    #complete new pool fields
    Then I click the change link for the court deferrals
    Then I change the number of court deferrals to "0"

    Then I set the radio button to "<courtType>"
    And I set "Number of jurors required in total" to "<noJurors>"
    Then I press the "Continue" button

    #check pool request

    Then I see "Check your pool request" on the page

    And I should see the details of the pool
      | courtName           | <displayCourt> (<courtCode>) |
      | poolType            | <courtTypeFull>              |
      | totalJurorsRequired | 0                            |
      | numberOfDeferrals   | 0                            |
      | additionalJurors    | <noJurors>                   |

    # Can submit the new pool request

    When I save the new pool request
    Then I should be taken to the pool summary page
    And I click on the "Service start date" link

    And I should see the newly created pool request
      | type           | Bureau         |
      | court          | <displayCourt> |
      | jurorsRequired | 0              |

    Examples:
      | user          |  | selectedCourt | courtType   | courtTypeFull | courtCode | displayCourt | noJurors |
      | MODTESTBUREAU |  | CHESTER       | Crown court | Crown court   | 415       | Chester      | 0        |
      | MODTESTBUREAU |  | CHESTER       | Civil court | Civil court   | 415       | Chester      | 0        |
      | MODTESTBUREAU |  | CHESTER       | High court  | High court    | 415       | Chester      | 0        |

  @JurorTransformation @NewSchemaConverted
  Scenario Outline: Happy Path Test to create a new pool and change pool_no
    Given I am on "Bureau" "test"
    Given new pool requests are deleted
    And I log in as "<user>"

    When I navigate to the pool request screen

    When I press the "Create pool" button
    And I set the radio button to "Request new pool"
    And I press the "Continue" button
    Then I see "Select a court for this pool" on the page

    #select court

    Then I set input field with "ID" of "courtNameOrLocation" to "<selectedCourt>"
    And I select the "<displayCourt> (<courtCode>)" court selection link
    Then I press the "Continue" button

    #check page content

    And on the page I see
      | text                                              |
      | Request a new pool                                |
      | Court name or location code                       |
      | <displayCourt>                                    |
      | Attendance date                                   |
      | Pool type                                         |
      | Crown court                                       |
      | High court                                        |
      | Civil court                                       |
      | Number of jurors required in total                |
      | Number of court deferrals to include in this pool |

    And I see the attendance date of the pool
    And I do not see "Attendance time" on the page

    #complete new pool fields
    Then I click the change link for the court deferrals
    Then I change the number of court deferrals to "0"

    Then I set the radio button to "<courtType>"
    And I set "Number of jurors required in total" to "<noJurors>"
    Then I press the "Continue" button

    #check pool request

    Then I see "Check your pool request" on the page

    And I should see the details of the pool
      | courtName           | <displayCourt> (<courtCode>) |
      | poolType            | <courtTypeFull>              |
      | totalJurorsRequired | <noJurors>                   |
      | numberOfDeferrals   | 0                            |
      | additionalJurors    | <noJurors>                   |

    #Change pool no

    Then I click the change link for the pool number
    And I see "Change pool number" on the page
    And I enter a pool number that is the current pool number plus 1

# Can submit the new pool request

    When I save the new pool request
    Then I should be taken to the pool summary page
    And I click on the "Service start date" link

    And I should see the newly created pool request
      | type           | Bureau         |
      | court          | <displayCourt> |
      | jurorsRequired | 0              |

    And I navigate to the pool search screen
    When I enter the pool number of the pool I have just created on the pool search screen
    And I press the "Continue" button

    When I click the delete pool request button
    When I click the confirm deletion button
    Then a message is displayed on the pool requests page informing me that the pool has been deleted
    And the pool is no longer visible

    Examples:
      | user          | selectedCourt | courtType | courtTypeFull | courtCode | displayCourt | noJurors |
      | MODTESTBUREAU | CHESTER       | Crown     | Crown court   | 415       | Chester      | 0        |
      | MODTESTBUREAU | CHESTER       | Civil     | Civil court   | 415       | Chester      | 0        |
      | MODTESTBUREAU | CHESTER       | High      | High court    | 415       | Chester      | 0        |