Feature: JM-252 JM-4302 Court user create new pools

  @JurorTransformationMulti @NewSchemaConverted
  Scenario Outline: Happy Path Test to create a new pool of jurors as court user with 1 court
    Given I am on "Bureau" "test"
    And I log in as "<user>"

    When I navigate to the pool request screen

    When I press the "Create pool" button
    And I set the radio button to "Request new pool"
    And I press the "Continue" button

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
      | type           | Court          |
      | court          | <displayCourt> |
      | jurorsRequired | <noJurors>     |

    Examples:
      | user         | courtType | courtTypeFull | displayCourt | noJurors | courtCode |
      | MODTESTCOURT | Crown     | Crown court   | Chester      | 100      | 415       |
      | MODTESTCOURT | Civil     | Civil court   | Chester      | 100      | 415       |
      | MODTESTCOURT | High      | High court    | Chester      | 100      | 415       |

  @JurorTransformationMulti @NewSchemaConverted
  Scenario Outline: JM-4681 Happy Path Test to create a new 'court only' pool as court officer
    Given I am on "Bureau" "test"
    And I log in as "<user>"

    When I navigate to the pool request screen

    When I press the "Create pool" button
    And I set the radio button to "Create pool for court use only"
    And I press the "Continue" button

    #check page content
    And on the page I see
      | text                             |
      | Create a pool for court use only |
      | Court name                       |
      | <displayCourt>                   |
      | Service start date               |
      | Pool type                        |
      | Crown court                      |
      | High court                       |
      | Civil court                      |

    #complete new pool fields
    Then I set "Service start date" to "5 mondays time"
    And I set the radio button to "<courtTypeFull>"
    Then I press the "Continue" button

    #check pool request
    Then I see "Check pool details" on the page
    And I see "<displayCourt> (<courtCode>)" on the page
    And I see "<courtTypeFull>" on the page

    # Can submit the new pool request
    When I press the "Create active pool" button
    Then I see "New pool" on the page
    And I see "Active pools" on the page
    When I click the link for the successfully created court only pool
    Then I see "Pool record" on the page
    And I see "ACTIVE" on the page
    And I see "There are no results to display" on the page

    Examples:
      | user         | courtTypeFull | displayCourt | courtCode |
      | MODTESTCOURT | Crown court   | Chester      | 415       |
      | MODTESTCOURT | Civil court   | Chester      | 415       |

  @JurorTransformationMulti @NewSchemaConverted
  Scenario Outline: Happy Path Test to create a new pool of jurors as court user with >1 court
    Given I am on "Bureau" "test"

    And I log in as "<user>"

    When I navigate to the pool request screen

    When I press the "Create pool" button
    And I set the radio button to "Request new pool"
    And I press the "Continue" button

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
      | type           | Court          |
      | court          | <displayCourt> |
      | jurorsRequired | <noJurors>     |

    When I press the "Create pool" button
    And I set the radio button to "Request new pool"
    And I press the "Continue" button

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

    Then I click the change link for the court deferrals
    Then I change the number of court deferrals to "0"

    Then I set the radio button to "<courtType>"
    And I set "Number of jurors required in total" to "150"
    Then I press the "Continue" button

    Then I click on the "Change" link
    Then I click the change link for the chosen court
    # check that user cannot see courts outside of jurisdiction
    Then I set input field with "ID" of "courtNameOrLocation" to "420"
    And I do not see "Doncaster (420)" on the page
    Then I set input field with "ID" of "courtNameOrLocation" to "767"
    Then I click on the "Knutsford (767)" link
    Then I press the "Continue" button

    Then I set the radio button to "<courtType>"
    And I set "Number of jurors required in total" to "150"

    When I save the changes to the pool request
    Then I save the new pool request
    Then I should be taken to the pool summary page
    And I click on the "Service start date" link

    And I should see the newly created pool request
      | type           | Court     |
      | court          | Knutsford |
      | jurorsRequired | 150       |

    Examples:
      | user     | courtType | displayCourt | noJurors | courtCode | courtTypeFull |
      | MODTESTCOURT | Crown     | Chester      | 150      | 415       | Crown court   |
      | MODTESTCOURT | Civil     | Chester      | 150      | 415       | Civil court   |
      | MODTESTCOURT | High      | Chester      | 150      | 415       | High court    |


  @JurorTransformationMulti @NewSchemaConverted
  Scenario Outline: Happy Path Test to create a new pool with 0 jurors
    Given I am on "Bureau" "test"
    And I log in as "<user>"

    When I navigate to the pool request screen

    When I press the "Create pool" button
    And I set the radio button to "Request new pool"
    And I press the "Continue" button

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
      | type           | Court          |
      | court          | <displayCourt> |
      | jurorsRequired | 0              |

    Examples:
      | user         | courtType | courtTypeFull | courtCode | displayCourt | noJurors |
      | MODTESTCOURT | Crown     | Crown court   | 415       | Chester      | 0        |
      | MODTESTCOURT | Civil     | Civil court   | 415       | Chester      | 0        |
      | MODTESTCOURT | High      | High court    | 415       | Chester      | 0        |
