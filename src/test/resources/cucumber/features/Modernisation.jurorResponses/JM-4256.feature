Feature: JM-4256 Record proof of name change for a jury officer

  @JurorTransformationWIP @NewSchemaConverted @JM-5469
  Scenario Outline: The system shall allow a jury officer to record a proof of change of name and accept name change

    Given I am on "Bureau" "test"
    Given the juror numbers have not been processed new schema
      | part_no   | pool_no 	| owner |
      | <part_no> |<pool_no>	| 400 	|


    And "<part_no>" has "NEXT_DATE" as "10 mondays time" new schema

    Then a new pool is inserted for where record has transferred to the court new schema
      |part_no   | pool_no   | owner |
      |<part_no> | <pool_no> | 415   |


    And "<part_no>" has "NEXT_DATE" as "10 mondays time" new schema

    And I log in as "<user>"

    When the user searches for juror record "<part_no>" from the global search bar

    And I click on the "Juror details" link
    And I click on the "Add or change" link

    And I click on the "Enter a new name" link
    And I see "Enter a new name" on the page
    And I see "This new name will only become their legal name on their juror record after:" on the page
    And I see "When you enter a new name here, it will overwrite any previous pending name." on the page

    And I set "First name" to "FnameTester"
    And I set "Last name" to "LnameTesting"
    And I press the "Save" button
    And I see "Pending approval" on the page
    And I see the juror's new name "Fnametester Lnametesting" is pending approval
    And I enter a date of birth that will make the juror between 18 and 75
    And I press the "Save" button

    And I click on the Approve or reject link
    And I see "Approve or reject name change" on the page
    And I see "The juror has notified us of a change to their name. You should only approve this if you’ve seen proof of the name change." on the page
    And I set the radio button to "Approve"
    And I see "What evidence did the juror provide for their change of name?" on the page
    And I set the radio button to "Reject"
    And I see "Why did you reject the juror’s name change?" on the page
    Then I set the radio button to "Approve"
    And I set "What evidence did the juror provide for their change of name?" to "Passport"
    And I press the "Continue" button

    And I see "Run a police check on this juror" on the page
    And I press the "Run police check" button
    And I see "Fnametester Lnametesting" on the page

    Examples:
      |part_no   |pool_no    |user         |
      |641500900 |415170402  | MODTESTCOURT|


  @JurorTransformationWIP @NewSchemaConverted @JM-5469
  Scenario Outline: The system shall allow a jury officer to record a proof of change of name and reject name change

    Given I am on "Bureau" "test"
    Given the juror numbers have not been processed new schema
      | part_no   | pool_no 	| owner |
      | <part_no> |<pool_no>	| 400 	|


    And "<part_no>" has "NEXT_DATE" as "10 mondays time" new schema

    Then a new pool is inserted for where record has transferred to the court new schema
      |part_no   | pool_no   | owner |
      |<part_no> | <pool_no> | 415   |


    And "<part_no>" has "NEXT_DATE" as "10 mondays time" new schema

    And I log in as "<user>"

    When the user searches for juror record "<part_no>" from the global search bar

    And I click on the "Juror details" link
    And I click on the "Add or change" link

    And I click on the "Enter a new name" link
    And I see "Enter a new name" on the page
    And I see "This new name will only become their legal name on their juror record after:" on the page
    And I see "When you enter a new name here, it will overwrite any previous pending name." on the page

    And I set "First name" to "FnameTester"
    And I set "Last name" to "LnameTesting"
    And I press the "Save" button
    And I see "Pending approval" on the page
    And I see the juror's new name "Fnametester Lnametesting" is pending approval
    And I enter a date of birth that will make the juror between 18 and 75
    And I press the "Save" button

    And I click on the Approve or reject link
    And I see "Approve or reject name change" on the page
    And I see "The juror has notified us of a change to their name. You should only approve this if you’ve seen proof of the name change." on the page
    And I set the radio button to "Reject"
    And I see "Why did you reject the juror’s name change?" on the page
    And I set "Why did you reject the juror’s name change?" to "Juror is not allowed"
    And I press the "Continue" button
    And I see "Confirm you want to reject this name change" on the page
    And I see "Their name change request will be removed from their juror record. Their original name will continue to be used." on the page
    And I press the "Reject name change" button
    And I see "Mr Edward Palmer" on the page

    Examples:
      |part_no   |pool_no    |user         |
      |641500133 |415170402  | MODTESTCOURT|


  @JurorTransformationWIP @NewSchemaConverted @JM-5469
  Scenario Outline: The system shall allow a jury officer to record a proof of change of name

    Given I am on "Bureau" "test"
    Given the juror numbers have not been processed new schema
      | part_no   | pool_no 	| owner |
      | <part_no> |<pool_no>	| 400 	|


    And "<part_no>" has "NEXT_DATE" as "10 mondays time" new schema

    Then a new pool is inserted for where record has transferred to the court new schema
      |part_no   | pool_no   | owner |
      |<part_no> | <pool_no> | 415   |

    And I log in as "<user>"

    When the user searches for juror record "<part_no>" from the global search bar

    And I click on the "Juror details" link
    And I click on the "Add or change" link

    And I click on the "Fix error in current name" link

    #name longer than 20 characters
    And I set "First name" to "FnameTestertttttttttttttt"
    And I set "Last name" to "LnameTestinggggggggggggggg"
    And I press the "Save" button
    And I see error "Please check the first name"
    And I see error "Please check the last name"

    #special characters
    And I set "First name" to "FnameTester&#@!?%"
    And I set "Last name" to "FnameTester&#@!?%"
    And I press the "Save" button

    And I click on the "Enter a new name" link
    And I see "Enter a new name" on the page
    And I see "This new name will only become their legal name on their juror record after:" on the page
    And I see "When you enter a new name here, it will overwrite any previous pending name." on the page

    And I set "First name" to "FnameTester"
    And I set "Last name" to "LnameTesting"
    And I press the "Save" button

    And I see "Pending approval" on the page
    And I see the juror's new name "Fnametester Lnametesting" is pending approval
    And I enter a date of birth that will make the juror between 18 and 75
    And I press the "Save" button

    And I see "Pending approval" on the page
    And I see "Fnametester Lnametesting" on the page

    Examples:
      |part_no   |pool_no    |user         |
      |641500911 |415170402  | MODTESTCOURT|

  @JurorTransformationWIP  @NewSchemaConverted @JM-5469
  Scenario Outline: The system shall allow a jury officer to record a proof of change of name. Change name while recording paper summons

    Given I am on "Bureau" "test"
    Given the juror numbers have not been processed new schema
      | part_no   | pool_no 	| owner |
      | <part_no> |<pool_no>	| 400 	|


    And "<part_no>" has "NEXT_DATE" as "10 mondays time" new schema

    And I log in as "<user>"

    Then a new pool is inserted for where record has transferred to the court new schema
      |part_no   | pool_no   | owner |
      |<part_no> | <pool_no> | 415   |

    When the user searches for juror record "<part_no>" from the global search bar

    And I click the Enter summons reply button
    And I click on the "Enter a new name" link
    And I see "Enter a new name" on the page
    And I see "This new name will only become their legal name on their juror record after:" on the page
    And I see "When you enter a new name here, it will overwrite any previous pending name." on the page
    And I set "First name" to "FnameTester"
    And I set "Last name" to "LnameTesting"
    And I press the "Save" button
    And I see "Pending approval" on the page
    And I see the juror's new name "Mr Fnametester Lnametesting" is pending approval

    #juror details
    When I fill in all of the juror details for the summons reply
    And I click continue on the juror summons reply page

    #eligibility
    Then the juror summons reply eligibility page is displayed
    When I answer the juror summons reply eligibility questions
    And I click continue on the juror summons reply page

    #can attend on date
    Then the juror summons reply types page is displayed
    When I set the radio button to "Can serve on date shown in summons"
    And I click continue on the juror summons reply page

    #cjs
    Then the juror summons reply CJS employment page is displayed
    When I select that the juror has not worked in the criminal justice system
    And I click continue on the juror summons reply page

    #reasonable adjustments
    Then the juror summons reply reasonable adjustments page is displayed
    When I select that the juror does not need adjustments
    And I click continue on the juror summons reply page

    #confirm/sign
    Then the juror summons reply Signature page is displayed
    When I select that the summons reply has been signed
    And I click done on the juror summons reply page

    And I see "Pending" on the page
    And I see "Mr FnameTester LnameTesting" on the page

    Examples:
      |part_no   |pool_no    |user         |
      |641500752 |415170402  | MODTESTCOURT|