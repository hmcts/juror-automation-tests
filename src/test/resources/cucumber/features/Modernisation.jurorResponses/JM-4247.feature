Feature: JM-4247 Edit Juror Record as Court User

  @JurorTransformationMulti @NewSchemaConverted
  Scenario Outline: The system shall allow the Jury officer to edit a juror record for a juror in their control

    Given I am on "Bureau" "test"

    Given a bureau owned pool is created with jurors
      | court | juror_number  	    | pool_number	    | att_date_weeks_in_future	| owner |
      | 415   | <juror_number> 	    | <pool_number>     | 10			            | 400	|

    Then a new pool is inserted for where record has transferred to the court new schema
      |part_no        | pool_no       | owner |
      |<juror_number> | <pool_number> | 415   |

    And juror "<juror_number>" has "FIRST_NAME" as "Joe" new schema
    And juror "<juror_number>" has "LAST_NAME" as "Blogs" new schema

    And I log in as "<user>"
    When the user searches for juror record "<juror_number>" from the global search bar
    And I record a happy path paper summons response and process now
    When the user searches for juror record "<juror_number>" from the global search bar

    And I click on the "Juror details" link
    And I click on the "Add or change" link

    #change name
    And I click on the "Fix error in current name" link
    And I see "Fix error in current name" on the page
    And I see "You should only fix minor errors here. For example, if you need to remove a special character that's preventing a police check from being carried out." on the page

    And I set "First name" to "Testing"
    And I set "Last name" to "Test"
    And I press the "Save" button
    And I see the juror name has updated to "Testing Test"
    And I click on the "Enter a new name" link
    And I see "Enter a new name" on the page

    And I see "This new name will only become their legal name on their juror record after:" on the page
    And I see "When you enter a new name here, it will overwrite any previous pending name." on the page
    And I click on the "Cancel" link

    And I click on the "Change" link
    # change this section
    And I click on the "Change" link
    And I set "Address line 1" to "530 Test Name"
    And I set "Town or city" to "LONDON"
    And I click on the "Cancel" link
    And I click on the "Change" link
    And I set "Address line 1" to "530 Test Name"
    And I set "Town or city" to "LONDON"
    And I press the "Save" button

    And I enter a date of birth that will make the juror between 18 and 75
    And I set "Email (optional)" to "test@mail.com"
    When I select the yes radio button from the Third Party Juror details
    And I see "Name" on the page
    And I see "Relationship to juror" on the page
    And I set "Name" to "Steven"
    And I set "Relationship to juror" to "Friend"

    And I see "Additional requirements" on the page
    And I see "Will the juror need extra support or facilities at court" on the page
    When I select the yes radio button from the Additional Requirements Juror details
    And I see "Select a reason" on the page
    When I select "D - Diet" from the "Select a reason" dropdown
    And I set "What help does this juror need at court" to "Nutritional Guidance"
    And I press the "Save" button
    And I see "Testing Test" on the page

    Examples:
      | juror_number| pool_number|user         |
      | 041500123   | 415300223  | MODTESTCOURT|