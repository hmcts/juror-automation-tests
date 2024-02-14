Feature: JM-3671

  @JurorTransformationMulti @NewSchemaConverted
  Scenario Outline: Happy Path Test to create a coroner's pool
    Given I am on "Bureau" "test"
    Given coroners pools older than today have been cleared down new schema
    And I log in as "<user>"

    When I navigate to the pool request screen

    When I select to create a coroner's pool
    Then I see "Create a coroner court pool" on the page

    #select court
    Then I set input field with "ID" of "courtNameOrLocation" to "<selectedCourt>"
    Then I click on the "<displayCourt> (<courtCode>)" link
    And I set input field with "ID" of "jurorsRequested" to "<noJurors>"
    Then I press the "Continue" button

    #check page content
    And on the page I see
      | text|
      |Who requested this pool?  |
      |Email                     |
      |Phone (optional)          |
      |Date requested            |

    And I see date requested on coroner pool request is today

    And I set "Name" to "<name>"
    And I set "Email" to "<email>"
    And I set "Phone (optional)" to "<phone>"

    Then I press the "Continue" button

    And I should see the details of the coroner's court pool summary
      | courtName              | <displayCourt>     |
      | totalJurorsRequired    | <noJurors>         |
      | requestedByName        | <name>             |
      | requestedByEmail       | <email>            |
      | requestedByPhone       | <phone>            |

    # Can submit the new coroners pool request
    When I press the "Create pool" button

    #export pool button not visible until jurors added
    And the Export pool button is not visible

    Examples:
      | user	      | selectedCourt | courtCode | displayCourt | noJurors | name   | phone       | email      |
      | MODTESTBUREAU | CHESTER       | 415       | Chester      | 150      | A Name | 07888888888 | e@mail.com |

  @JurorTransformationMulti
  Scenario Outline: Happy Path Test to add jurors to a coroner's pool from another catchment area
    Given I am on "Bureau" "test"

    And I log in as "<user>"
    When I navigate to the pool request screen

    When I select to create a coroner's pool
    Then I see "Create a coroner court pool" on the page

    #select court
    Then I set input field with "ID" of "courtNameOrLocation" to "<selectedCourt>"
    Then I click on the "<displayCourt> (<courtCode>)" link
    And I set input field with "ID" of "jurorsRequested" to "<noJurors>"
    Then I press the "Continue" button

    #check page content
    And on the page I see
      | text|
      |Who requested this pool?  |
      |Email                     |
      |Phone (optional)          |
      |Date requested            |

    And I see date requested on coroner pool request is today

    And I set "Name" to "<name>"
    And I set "Email" to "<email>"
    And I set "Phone (optional)" to "<phone>"

    Then I press the "Continue" button

    And I should see the details of the coroner's court pool summary
      | courtName              | <displayCourt>     |
      | totalJurorsRequired    | <noJurors>         |
      | requestedByName        | <name>             |
      | requestedByEmail       | <email>            |
      | requestedByPhone       | <phone>            |

    # Can submit the new coroners pool request
    When I press the "Create pool" button

    Then I should see the coroner's court pool
      | court          | <displayCourt> |
      | courtCode      | <courtCode>    |
      | poolType       | Coroner’s court|
      | jurorsAdded    | 0              |
      | jurorsRequired | <noJurors>     |
      | rowsOfCitizens | 0              |

    #add jurors to the pool
    Then I press the "Add jurors" button
    And I see "Add a court catchment area" on the page
    And I see "<displayCourt>" on the page

    Then I press the "Continue" button
    And I see "Enter the number of citizens to include from each postcode area" on the page
    And I see "The number of citizens available in each postcode area is shown in brackets." on the page
    And I see "CH1 (" on the page
    And I see "CH2 (" on the page
    Then I set "CH1 (" to "100"
    And I set "CH2 (" to "50"

    And I press the "Add citizens" button

    Then I should see the coroner's court pool
      | court          | <displayCourt> |
      | courtCode      | <courtCode>    |
      | poolType       | Coroner’s court|
      | jurorsAdded    | 150            |
      | jurorsRequired | <noJurors>     |
      | rowsOfCitizens | 150            |
    Then I click on the "s court contact details" link

    And coroners court contact details are
      | name  | <name>  |
      | email | <email> |
      | phone | <phone> |

    #add more jurors
    Then I press the "Add jurors" button
    And I see "Add a court catchment area" on the page
    And I see "<displayCourt>" on the page

    Then I click on the "Change" link
    Then I see "Change the court catchment area" on the page
    Then I set input field with "ID" of "courtNameOrLocation" to "457"
    Then I click on the "Swansea (457)" link
    Then I press the "Continue" button

    Then I see "Add a court catchment area" on the page
    Then I press the "Continue" button
    Then I see "Enter the number of citizens to include from each postcode area" on the page
    And I see "SA1 (" on the page

    Then I set "SA1 (" to "30"

    And I press the "Add citizens" button

    #will fail due to outstanding bug JM-5375

    Then I should see the coroner's court pool
      | court          | <displayCourt> |
      | courtCode      | <courtCode>    |
      | poolType       | Coroner’s court|
      | jurorsAdded    | 180            |
      | jurorsRequired | <noJurors>     |
      | rowsOfCitizens | 180            |

    Then I am able to see the coroners pool juror headers
    And I see pool status is "Active"

    #export
    Then I press the "Export pool" button

    Examples:
      | user	      | selectedCourt | courtCode | displayCourt | noJurors | name   | phone       | email      |
      | MODTESTBUREAU | CHESTER       | 415       | Chester      | 180      | A Name | 07888888888 | e@mail.com |
