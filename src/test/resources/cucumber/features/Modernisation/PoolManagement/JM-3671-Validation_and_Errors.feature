Feature: JM-3671 Validation and Errors

  @JurorTransformation
  Scenario Outline: Coroners court warning - no court or jurors requested entered
    Given I am on "Bureau" "test"

    And I log in as "<user>"

    When I navigate to the pool request screen

    When I select to create a coroner's pool
    Then I see "Create a coroner court pool" on the page

    #click continue with no input

    Then I press the "Continue" button

    #check warning

    And I see error "Court name or location is missing"
    And I see "The number of jurors you can request must be a number between 30 and 250" on the page

    Examples:
      | user	      |
      | MODTESTBUREAU |

  @JurorTransformation
  Scenario Outline: Coroners court warning - invalid court
    Given I am on "Bureau" "test"

    And I log in as "<user>"

    When I navigate to the pool request screen

    When I select to create a coroner's pool
    Then I see "Create a coroner court pool" on the page

    #select court only and continue

    Then I set input field with "ID" of "courtNameOrLocation" to "<selectedCourt>"
    And I select the "<displayCourt> (<courtCode>)" court selection link
    Then I press the "Continue" button

    Then I press the "Continue" button

    #check warning

    And I see error "The number of jurors you can request must be a number between 30 and 250"

    #select number of jurors only and continue

    Then I set input field with "ID" of "courtNameOrLocation" to ""
    And I set input field with "ID" of "jurorsRequested" to "100"
    Then I press the "Continue" button

    #check warning

    And I see error "Court name or location is missing"

    #invalid court

    Then I set input field with "ID" of "courtNameOrLocation" to "the moon"
    When I press the "Continue" button
    And I see error "This court does not exist. Please enter a name or code of an existing court"

    Then I set input field with "ID" of "courtNameOrLocation" to ""

    Then I set input field with "ID" of "courtNameOrLocation" to "41"
    When I press the "Continue" button
    And I see error "This court does not exist. Please enter a name or code of an existing court"

    Examples:
      | user	      | selectedCourt | courtCode | displayCourt |
      | MODTESTBUREAU | CHESTER       | 415       | Chester      |

  @JurorTransformation
  Scenario Outline: Coroners court warning - invalid number of jurors
    Given I am on "Bureau" "test"

    And I log in as "<user>"

    When I navigate to the pool request screen

    When I select to create a coroner's pool
    Then I see "Create a coroner court pool" on the page

    #select court

    Then I set input field with "ID" of "courtNameOrLocation" to "<selectedCourt>"
    And I select the "<displayCourt> (<courtCode>)" court selection link

    #enter invalid number of jurors - negative

    And I set input field with "ID" of "jurorsRequested" to "-1"
    Then I press the "Continue" button
    Then I see "The number of jurors you can request must be a number between 30 and 250" on the page

    #enter invalid number of jurors - <30

    And I set input field with "ID" of "jurorsRequested" to "29"
    Then I press the "Continue" button
    Then I see "The number of jurors you can request must be a number between 30 and 250" on the page

    #enter invalid number of jurors - >250

    And I set input field with "ID" of "jurorsRequested" to "251"
    Then I press the "Continue" button
    Then I see "The number of jurors you can request must be a number between 30 and 250" on the page

    #enter invalid number of jurors - >250

    And I set input field with "ID" of "jurorsRequested" to "9999"
    Then I press the "Continue" button
    Then I see "The number of jurors you can request must be a number between 30 and 250" on the page


    Examples:
      | user	      | selectedCourt | courtCode | displayCourt |
      | MODTESTBUREAU | CHESTER       | 415       | Chester      |

  @JurorTransformation
  Scenario Outline: Coroners court warning - invalid requested by details
    Given I am on "Bureau" "test"

    And I log in as "<user>"

    When I navigate to the pool request screen

    When I select to create a coroner's pool
    Then I see "Create a coroner court pool" on the page

    #select court

    Then I set input field with "ID" of "courtNameOrLocation" to "<selectedCourt>"
    And I select the "<displayCourt> (<courtCode>)" court selection link
    And I set input field with "ID" of "jurorsRequested" to "150"
    Then I press the "Continue" button

    #check page content

    And on the page I see
      | text|
      |Who requested this pool?  |
      |Email                     |
      |Phone (optional)          |
      |Date requested            |

    And I see date requested on coroner pool request is today

    #continue with no input

    Then I set "Date requested" to ""
    Then I press the "Continue" button

    And I see error "Enter the name of the person who requested the pool"
    And I see "Enter the email address for the person who requested the pool" on the page
    And I see "Enter the date the pool was requested" on the page

    #continue with invalid inputs

    And I set "Name" to "aabbccnnmmmmaahhsskkeerroorrppeemmggssyywwii"
    And I set "Email" to "blah"
    And I set "Phone (optional)" to "numbers only"
    Then I set "Date requested" to "00/00/00"

    Then I press the "Continue" button

    And I see error "The name cannot be longer than 35 characters"
    And I see "Enter a valid email address for the person who requested the pool" on the page
    And I see "Enter a valid phone number for the person who requested the pool" on the page
    And I see "Enter a valid requested date for this pool - DD/MM/YYYY" on the page

    Examples:
      | user	      | selectedCourt | courtCode | displayCourt |
      | MODTESTBUREAU | CHESTER       | 415       | Chester      |

  @JurorTransformation
  Scenario Outline: Coroners court warning - requested on date cannot be date in the past
    Given I am on "Bureau" "test"

    And I log in as "<user>"

    When I navigate to the pool request screen

    When I select to create a coroner's pool
    Then I see "Create a coroner court pool" on the page

    #select court
    Then I set input field with "ID" of "courtNameOrLocation" to "<selectedCourt>"
    And I select the "<displayCourt> (<courtCode>)" court selection link
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

    #input valid contact details
    And I set "Name" to "<name>"
    And I set "Email" to "<email>"
    And I set "Phone (optional)" to "<phone>"

    #continue with past date
    And I set the Coroners pool requested on date to a Monday "-10" weeks in the future
    Then I press the "Continue" button
    And I see error "Requested date must be in the future"

    Examples:
      | user	      | selectedCourt | courtCode | displayCourt | noJurors | name   | phone       | email      |
      | MODTESTBUREAU | CHESTER       | 415       | Chester      | 150      | A Name | 07888888888 | e@mail.com |

  @JurorTransformation @NewSchemaConverted
  Scenario Outline: Coroners court warning - invalid input on add jurors
    Given I am on "Bureau" "test"
    Given coroners pools older than today have been cleared down new schema
    Given voters for court "415" have been updated to postcode "CH2 2AN" new schema
    And I log in as "<user>"

    When I navigate to the pool request screen

    When I select to create a coroner's pool
    Then I see "Create a coroner court pool" on the page

    #select court

    Then I set input field with "ID" of "courtNameOrLocation" to "<selectedCourt>"
    And I select the "<displayCourt> (<courtCode>)" court selection link
    And I set input field with "ID" of "jurorsRequested" to "150"
    Then I press the "Continue" button

    #check page content

    And on the page I see
      | text|
      |Who requested this pool?  |
      |Email                     |
      |Phone (optional)          |
      |Date requested            |

    And I see date requested on coroner pool request is today

    #valid inputs

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

    #add with no citizens added

    And I press the "Add citizens" button

    And I see "Please enter the amount of citizens you need from each postcode below" on the page

    #add more than 250

    Then I set "CH1 (" to "51"
    And I set "CH2 (" to "200"

    And I press the "Add citizens" button

    And I see "You cannot enter more than 250 citizens in total across all postcodes" on the page

    #add more than is available in the postcode

    Then I set first postcode field to more than is available

    And I press the "Add citizens" button

    And I see error "The number of citizens you can enter for postcode CH1 must be "

    #add more than has been requested which is valid

    Then I set "CH1 (" to "141"
    And I set "CH2 (" to "10"

    And I press the "Add citizens" button

    Then I should see the coroner's court pool
      | court          | <displayCourt> |
      | courtCode      | <courtCode>    |
      | poolType       | Coroner’s court|
      | jurorsAdded    | 151            |
      | jurorsRequired | <noJurors>     |
      | rowsOfCitizens | 151            |

    Examples:
      | user	      | selectedCourt | courtCode | displayCourt | noJurors | name   | email      | phone       |
      | MODTESTBUREAU | CHESTER       | 415       | Chester      | 150      | A Name | e@mail.com | 07889999999 |

  @JurorTransformation @NewSchemaConverted
  Scenario Outline: Coroners court warning - no voters available
    Given I am on "Bureau" "test"
    Given coroners pools older than today have been cleared down new schema

    And I log in as "<user>"

    When I navigate to the pool request screen

    When I select to create a coroner's pool
    Then I see "Create a coroner court pool" on the page

    #select court

    Then I set input field with "ID" of "courtNameOrLocation" to "<courtCode>"
    And I select the "<displayCourt> (<courtCode>)" court selection link
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

    #valid inputs

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

    # add jurors to the pool

    Then I press the "Add jurors" button
    And I see "Add a court catchment area" on the page
    And I see "<displayCourt>" on the page

    Then I press the "Continue" button

    And I see "Enter the number of citizens to include from each postcode area" on the page
    And I see "No jurors on this catchment area." on the page

    Then I click on the "Cancel" link

    Then I should see the coroner's court pool
      | court          | <displayCourt> |
      | courtCode      | <courtCode>    |
      | poolType       | Coroner’s court|
      | jurorsAdded    | 0              |
      | jurorsRequired | <noJurors>     |
      | rowsOfCitizens | 0              |

    Examples:
      | user	      | courtCode | displayCourt | noJurors | name   | phone       | email      |
      | MODTESTBUREAU | 423       | Exeter       | 150      | A Name | 07888888888 | e@mail.com |
