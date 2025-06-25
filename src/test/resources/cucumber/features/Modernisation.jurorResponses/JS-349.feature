Feature: JS-349 - As a bureau user i want the app to throw an error when a leading space is on a jurors name

  @JurorTransformationMulti
  Scenario Outline: Test to ensure that I cannot enter a leading space in the jurors name

    Given I am on "Bureau" "ithc"

    Given a bureau owned pool is created with jurors
      | court | juror_number  	    | pool_number	    | att_date_weeks_in_future	| owner |
      | 415   | <juror_number> 	    | <pool_number>     | 5				            | 400	|
      | 415   | <juror_number_2> 	| <pool_number>     | 5				            | 400	|


    And I log in as "<user>"

    #fix error in current name
    When the user searches for juror record "<juror_number>" from the global search bar
    And I click on the "Juror details" link
    And I click on the "Add or change" link
    And I click on the "Fix error in current name" link
    And I see "Fix error in current name" on the page
    
    And I set "Title (optional)" to " Mr"
    And I set "First name" to " Testing"
    And I set "Last name" to " Test"
    And I press the "Review Edit" button
    
    And I see error "There is a leading space before the title, remove before saving"
    And I see error "There is a leading space before the first name, remove before saving"
    And I see error "There is a leading space before the last name, remove before saving"
    And I click on the "Cancel" link
    And I update juror "<juror_number>" to have a title of "    Mr" and a first name of "    Fname" and a last name of "    Lname"

    When the user searches for juror record "<juror_number>" from the global search bar
    And I click on the "Juror details" link
    And I click on the "Add or change" link
    And I click on the "Fix error in current name" link
    And I see "Fix error in current name" on the page

    And I press the "Review Edit" button
    And I see error "There is a leading space before the title, remove before saving"
    And I see error "There is a leading space before the first name, remove before saving"
    And I see error "There is a leading space before the last name, remove before saving"
    And I click on the "Cancel" link

    #enter a new name
    When the user searches for juror record "<juror_number_2>" from the global search bar
    And I click on the "Juror details" link
    And I click on the "Add or change" link
    And I click on the "Enter a new name" link
    And I see "Enter a new name" on the page

    And I set "Title (optional)" to " Mr"
    And I set "First name" to " Testing"
    And I set "Last name" to " Test"
    And I press the "Review Edit" button

    And I see error "There is a leading space before the title, remove before saving"
    And I see error "There is a leading space before the first name, remove before saving"
    And I see error "There is a leading space before the last name, remove before saving"


    Examples:
      | juror_number  | juror_number_2  | pool_number | user          |
      | 041577491     | 041577492       | 415345189   | MODTESTBUREAU |