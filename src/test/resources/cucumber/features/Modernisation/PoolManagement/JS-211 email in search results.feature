Feature: JS-211

  @JurorTransformationMulti
  Scenario Outline: Juror email displayed on search results for Bureau users

    Given I am on "Bureau" "demo"

    And I log in as "<user>"

    Given a bureau owned pool is created with jurors
      | court | juror_number  	    | pool_number	    | att_date_weeks_in_future	| owner |
      | 415   | <juror_number_1> 	| <pool_number>     | 5				            | 400	|
      | 415   | <juror_number_2> 	| <pool_number>     | 5				            | 400	|
      | 415   | <juror_number_3> 	| <pool_number>     | 5				            | 400	|

    Given juror "<juror_number_1>" has "LAST_NAME" as "JONES" new schema
    Given juror "<juror_number_2>" has "LAST_NAME" as "JONES" new schema
    Given juror "<juror_number_3>" has "LAST_NAME" as "JONES" new schema

    Given juror "<juror_number_2>" has "H_EMAIL" as "longnameemaillongnameemaillongnameemail@email.com" new schema

    #search for juror3
    When the user searches for juror record "<juror_number_3>" from the global search bar

    #record paper summons response
    And I see "Jones" on the page
    And I click the Enter summons reply button
    Then the juror details form is displayed

    #juror details
    When I enter a date of birth that will make the juror between 18 and 75
    And I choose the "Yes" radio button
    And I set "Relationship to juror" to "Friend"
    And I set "Email (optional)" to "thirdaprty@email.com"
    And I choose the "Juror is not there" radio button
    And I click continue on the juror summons reply page

    #eligibility
    Then the juror summons reply eligibility page is displayed
    And I answer the juror summons reply eligibility questions
    And I click continue on the juror summons reply page

    #can attend on date
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

    And I press the "Process reply" button
    And I set the radio button to "Mark as responded"
    And I press the "Continue" button
    Then I see "Mark as responded" on the page
    And I check the "Mark juror as 'responded'" checkbox
    And I press the "Confirm" button

    #search results page displays email
    When I select the global search
    And I click on the "Advanced juror search" link
    And I set "Juror name" to "JONES"
    And I press the "Search" button

    Then I see "Jones" in the same row as "<juror_number_1>"
    And I see "Jones" in the same row as "<juror_number_2>"
    And I see "Jones" in the same row as "<juror_number_3>"

    Then I see "-" in the same row as "<juror_number_1>"
    And I see "longnameemaillongnameemaillongnameemail@email.com" in the same row as "<juror_number_2>"
    And I see "-" in the same row as "<juror_number_3>"


    Examples:
      | juror_number_1  | juror_number_2  | juror_number_3  | pool_number   | user         |
      | 041500170       | 041500171       | 041500172       | 415300250     | MODTESTBUREAU|

  @JurorTransformationMulti
  Scenario Outline: Juror email not displayed on search results for Court users

    Given I am on "Bureau" "demo"

    And I log in as "<user>"

    Given a bureau owned pool is created with jurors
      | court | juror_number  	    | pool_number	    | att_date_weeks_in_future	| owner |
      | 415   | <juror_number_1> 	| <pool_number>     | 5				            | 400	|
      | 415   | <juror_number_2> 	| <pool_number>     | 5				            | 400	|
      | 415   | <juror_number_3> 	| <pool_number>     | 5				            | 400	|

    Given a new pool is inserted for where record has transferred to the court new schema
      | part_no             | pool_no         | owner |
      | <juror_number_1>	| <pool_number>   | 415   |
      | <juror_number_2>	| <pool_number>   | 415   |
      | <juror_number_3>	| <pool_number>   | 415   |

    Given juror "<juror_number_1>" has "LAST_NAME" as "JONES" new schema
    Given juror "<juror_number_2>" has "LAST_NAME" as "JONES" new schema
    Given juror "<juror_number_3>" has "LAST_NAME" as "JONES" new schema

    Given juror "<juror_number_1>" has "H_EMAIL" as "email1@hotmail.com" new schema
    Given juror "<juror_number_2>" has "H_EMAIL" as "email2@hotmail.com" new schema
    Given juror "<juror_number_3>" has "H_EMAIL" as "email3@hotmail.com" new schema

    #search results page displays email
    When I select the global search
    And I click on the "Advanced juror search" link
    And I set "Juror name" to "JONES"
    And I press the "Search" button

    Then I see "Jones" in the same row as "<juror_number_1>"
    And I see "Jones" in the same row as "<juror_number_2>"
    And I see "Jones" in the same row as "<juror_number_3>"

    Then I do not see "email1@hotmail.com" on the page
    And I do not see "email2@hotmail.com" on the page
    And I do not see "email3@hotmail.com" on the page

    Examples:
      | juror_number_1  | juror_number_2  | juror_number_3  | pool_number   | user          |
      | 041500173       | 041500174       | 041500175       | 415300258     | MODTESTCOURT  |