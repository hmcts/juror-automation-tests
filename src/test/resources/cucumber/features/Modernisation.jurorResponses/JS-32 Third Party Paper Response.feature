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

  @JurorTransformationMulti
  Scenario Outline: Third party paper response where juror is contact JS-586

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

    #3rd party contact details
    And I set "First Name (optional)" to "Thirdparty"
    And I set "Last Name (optional)" to "Thirdparty"

    #check relationship can only be 50 chars
    And I set "Relationship to juror" to "abc abc abc abc abcd abcd abcd abcde abcde abcde AB"
    And I press the "Continue" button
    And I see "Please check the third party relationship" in the error banner

    And I set "Relationship to juror" to "Relationship"
    And I set "Main phone (optional)" to "07999999999"
    And I set "Another phone (optional)" to "07888888888"
    And I set input field with "id" of "thirdPartyEmailAddress" to "thirdparty@email.com"

    And I choose the "Juror is not there" radio button

    And I check the "Contact juror instead of third party for email communications" checkbox
    And I check the "Contact juror instead of third party for phone communications" checkbox

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

    And I see "07777777777" in the same row as "Main Phone"
    And I see "07777777711" in the same row as "Alternative phone"
    And I see "test@test.com" in the same row as "Email"

    And I do not see "Contact Third Party" on the page

    And I see "07999999999" in the same row as "Main phone"
    And I see "07888888888" in the same row as "Another phone"

    Examples:
      | juror_number | pool_number |user            |
      | 041500107    | 415300172   | MODTESTBUREAU  |