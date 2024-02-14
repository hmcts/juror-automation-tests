Feature: JM-3671 Navigation

  @JurorTransformationMulti @NewSchemaConverted
  Scenario Outline: Coroners pool change pool details
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
      | text                     |
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

    #Change request details
    Then I click on the change coroners pool request details link
    And I see "Create a coroner court pool" on the page
    Then I set input field with "ID" of "courtNameOrLocation" to "452"
    Then I click on the "Shrewsbury (452)" link
    And I set input field with "ID" of "jurorsRequested" to "200"
    Then I press the "Continue" button

    And I see "Who requested this pool?" on the page
    Then I press the "Continue" button

    #Change requested by
    Then I click on the change coroners pool requested By link
    And I see date requested on coroner pool request is today
    And I set "Name" to "New Name"
    And I set "Email" to "new@email.com"
    And I set "Phone (optional)" to "07111111111"
    And I set the Coroners pool requested on date to a Monday "10" weeks in the future

    Then I press the "Continue" button

    And I should see the details of the coroner's court pool summary
      | courtName              | Shrewsbury     |
      | totalJurorsRequired    | 200            |
      | requestedByName        | New Name       |
      | requestedByEmail       | new@email.com  |
      | requestedByPhone       | 07111111111    |

    # Can submit the new coroners pool request

    When I press the "Create pool" button

    Then I should see the coroner's court pool
      | court          | Shrewsbury     |
      | courtCode      | 452            |
      | poolType       | Coroner’s court|
      | jurorsAdded    | 0              |
      | jurorsRequired | 200            |
      | rowsOfCitizens | 0              |

    Examples:
      | user	      | selectedCourt | courtCode | displayCourt | noJurors | name   | phone       | email      |
      | MODTESTBUREAU | CHESTER       | 415       | Chester      | 150      | A Name | 07888888888 | e@mail.com |
