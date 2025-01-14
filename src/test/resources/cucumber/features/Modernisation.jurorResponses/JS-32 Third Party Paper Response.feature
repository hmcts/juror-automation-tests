Feature: JS-32 Third Party paper response

  @JurorTransformationMulti
  Scenario Outline: Third party paper response - validation

    Given I am on "Bureau" "ithc"

    Given a bureau owned pool is created with jurors
      | court | juror_number  	    | pool_number	    | att_date_weeks_in_future	| owner |
      | 415   | <juror_number> 	    | <pool_number>     | 10			            | 400	|

    And juror "<juror_number>" has "FIRST_NAME" as "Joe" new schema
    And juror "<juror_number>" has "LAST_NAME" as "Blogs" new schema

    And I log in as "<user>"
    When the user searches for juror record "<juror_number>" from the global search bar

    #record paper summons response
    And I click the Enter summons reply button
    Then the juror details form is displayed

	#juror details
    When I fill in all of the juror details for the summons reply
    And I set the radio button to "Yes"

    #check relationship can only be 50 chars
    And I set "Relationship to juror" to "abc abc abc abc abcd abcd abcd abcde abcde abcde AB"
    And I press the "Continue" button
    And I see "Please check the third party relationship" in the error banner

    And I set "Relationship to juror" to "Relationship"
    And I choose the "Juror is not there" radio button

    And I click continue on the juror summons reply page

	#eligibility
    Then the juror summons reply eligibility page is displayed
    When I answer the juror summons reply eligibility questions
    And I click continue on the juror summons reply page

	#can attend on date
    Then the juror summons reply types page is displayed
    When I select that the juror can serve on the summons date
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
    Then the view summons reply page is displayed

    And I see the reply status has updated to "To Do"

    And I see "Contact Third Party" in the same row as "Main phone"
    And I see "Contact Third Party" in the same row as "Email"
    And I see "Contact Third Party" in the same row as "Alternative phone"


    Examples:
      | juror_number | pool_number |user            |
      | 041500082    | 415300172   | MODTESTBUREAU  |