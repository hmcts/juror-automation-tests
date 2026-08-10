Feature: JS-319 Alternative phone number is correctly saved to the juror record

  @JurorTransformationMulti
  Scenario Outline: JS-319 Alternative phone number is correctly saved to the juror record DIGITAL

    Given I am on "Public" "ithc"

    Given a bureau owned pool is created with jurors
      | court | juror_number  	| pool_number	| att_date_weeks_in_future	| owner |
      | 415	| <juror_number1> 	| <pool_number> | 5				            | 400	|

    And juror "<juror_number1>" has "LAST_NAME" as "<last_name>" new schema
    And juror "<juror_number1>" has "POSTCODE" as "<postcode>" new schema

	#Response 1
    Then I see "Reply to a jury summons" on the page

    #log on as juror
    And I set the radio button to "I am replying for myself"
    And I press the "Continue" button
    And I set "9-digit juror number" to "<juror_number1>"
    And I set "Juror last name" to "<last_name>"
    And I set "Juror postcode" to "<postcode>"
    And I press the "Continue" button

    #name
    And I choose the "Yes" radio button
    And I press the "Continue" button

    #address
    And I choose the "Yes" radio button
    When I press the "Continue" button

	#contact
    When I set "Main phone" to "<mobile_phone>"
    And I set "Another phone (optional)" to "<landline_phone>"
    And I press the "Continue" button

    #email
    And I set "Enter your email address" to "test@gmail.com"
    And I set "Enter your email address again" to "test@gmail.com"
    And I press the "Continue" button

	#dob
    When I set "Day" to "01"
    And I set "Month" to "01"
    And I set "Year" to "1990"
    And I press the "Continue" button

	#Qualify for jury service
    When I press the "Continue" button

	#residency
    And I choose the "Yes" radio button
    And I press the "Continue" button

	#CJS no
    When I choose the "No" radio button
    And I press the "Continue" button

	#Bail
    And I choose the "No" radio button
    And I press the "Continue" button

	#Convictions
    When I choose the "No" radio button
    And I press the "Continue" button

	#Mental Health
    And I choose the "No" radio button
    And I press the "Continue" button

	#Mental Health Capacity
    And I choose the "No" radio button
    And I press the "Continue" button

	#I can attend
    And I set the radio button to "Yes, I can start on"
    And  I press the "Continue" button

	#RA yes
    When I choose the "Yes" radio button
    Then I check the "Diabetes" checkbox
    Then I set "Tell us about any special arrangements or help you need while you're doing jury service (optional)" to "Special Need is DIABETES"
    And I press the "Continue" button

    Then I check the "The information I have given is true to the best of my knowledge" checkbox
    And I press the "Submit" button

    Given I am on "Bureau" "ithc"
    And I log in as "<user>"

    When the user searches for juror record "<juror_number1>" from the global search bar

    And I click the summons reply tab
    And I click on the "View summons reply" link
    Then I see "<mobile_phone>" in the same row as "Main Phone"
    And I see "<landline_phone>" in the same row as "Alternative phone"

    #process response
    When I select "Mark as responded" from Process reply
    And I check the "Mark juror as 'responded'" checkbox
    And I press the "Confirm" button

    When I click on the "View juror's record" link
    And I click on the "Juror details" link
    Then I see "<mobile_phone>" in the same row as "Main phone"
    And I see "<landline_phone>" in the same row as "Other phone"

    Examples:
      | user          | juror_number1 | pool_number | mobile_phone  | landline_phone  | last_name  | postcode     |
      | MODTESTBUREAU | 041500168     | 415300184   | 07111111111   | 01212222222     | JONES      | CH2 2AA      |

  @JurorTransformationMulti
  Scenario Outline: JS-319 Alternative phone number is correctly saved to the juror record PAPER

    Given I am on "Bureau" "demo"

    Given a bureau owned pool is created with jurors
      | court | juror_number  	| pool_number	| att_date_weeks_in_future	| owner |
      | 415	| <juror_number1> 	| <pool_number> | 5				            | 400	|

    And juror "<juror_number1>" has "LAST_NAME" as "<last_name>" new schema
    And juror "<juror_number1>" has "POSTCODE" as "<postcode>" new schema

    And I log in as "<user>"

    When the user searches for juror record "<juror_number1>" from the global search bar

    #record paper summons response
    And I click the Enter summons reply button
    Then the juror details form is displayed

  #juror details
    When I fill in all of the juror details for the summons reply
    And I set "Alternative phone (optional)" to "<landline_phone>"
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
    And I choose the "No" radio button
    And I click continue on the juror summons reply page

  #confirm/sign
    Then the juror summons reply Signature page is displayed
    When I select that the summons reply has been signed
    And I click done on the juror summons reply page
    And I press the "Yes, process now" button

    And I click on the "<juror_number1>" link
    And I click the summons reply tab
    And I click on the "View summons reply" link
    Then I see "<mobile_phone>" in the same row as "Main Phone"
    And I see "<landline_phone>" in the same row as "Alternative phone"

    When I click on the "View juror's record" link
    And I click on the "Juror details" link
    Then I see "<mobile_phone>" in the same row as "Main phone"
    And I see "<landline_phone>" in the same row as "Other phone"

    Examples:
      | user          | juror_number1 | pool_number | mobile_phone  | landline_phone  | last_name  | postcode     |
      | MODTESTBUREAU | 041500169     | 415300185   | 07777777777   | 01212222222     | JONES      | CH2 2AA      |