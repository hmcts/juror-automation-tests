Feature: JM-3686

  @JurorTransformationMulti @NewSchemaConverted
  Scenario Outline: JM-3686 - End to End test for updating paper response information from juror

    Given I am on "Bureau" "test"

    And I log in as "<user>"

    Given a bureau owned pool is created with jurors
      | court | juror_number  	    | pool_number	    | att_date_weeks_in_future	| owner |
      | 415   | <juror_number> 	    | <pool_number>     | 5				            | 400	|

    Given the request letter for juror "<juror_number>" is deleted new schema

    When the user searches for juror record "<juror_number>" from the global search bar

   #record paper summons response
    And I record a happy path paper summons response

   #skip straight through processing
    Then I see "Do you want to process this summons reply as responded now?" on the page
    Then I see "The juror’s answers mean this is a straight-through reply. So you can process it as responded now, or return later." on the page
    When I click on the "No, skip and process later" link

    When the user searches for juror record "<juror_number>" from the global search bar
    Then the view summons reply page is displayed

    And I click on the "Summons reply" link
    And I click on the "View summons reply" link
    And I see "Summons reply" on the page
    And I click on the "Add or change" link
    And I see "Juror details" on the page

   #juror details
    And I click on the "Fix error in current name" link
    And I set "First name" to "Steven"
    And I set "Last name" to "Test"
    And I press the "Review Edit" button
    And I press the "Continue" button

   #eligibility
    Then I click on the "Eligibility" link
    And I click on the "Add or change" link
    Then I set residency in the UK radio button to No
    And I press the "Continue" button
    Then I click on the "Eligibility" link
    And I see the eligibility of "Residency" is "Attention"

   #Deferral or excusal
    Then I click on the "Deferral or excusal" link
    And I click on the "Add or change" link
    And I set the radio button to "Excusal request"
    And I press the "Continue" button
    Then I click on the "Deferral or excusal" link
    And I see "Attention" on the page
    And I see "Excusal request" on the page

   #CJS Employment
    Then I click on the "CJS employment" link
    And I see "CJS employment" on the page
    And I click on the "Add or change" link
    And I choose the "Yes" radio button
    And I check the "Police force" checkbox
    And I set "Which police force?" to "Metropolitan police"
    And I press the "Continue" button
    Then I click on the "CJS employment" link
    And I see "Attention" on the page
    And I see "Police Force" on the page

   #Reasonable Adjustments

   Then I select the reasonable adjustments tab from the summons reply page
   And I see "Reasonable adjustments" on the page
   And I click on the "Add or change" link
   And I see "Will the juror need extra support or facilities at court?" on the page
   And I choose the "Yes" radio button
   And I see "Select reason" on the page
   When I select "D - Allergies" from the "Select reason" dropdown
   And I set "What help does the juror need at court" to "Nutritional Guidance"
   And I press the "Continue" button

    Then I select the Signature tab from the summons reply page
    And I click on the "Add or change" link
    And I see "Has the summons reply been signed?" on the page
    Then I choose the "No" radio button
    And I press the "Done" button
    And I see "Summons reply is missing essential information - reply cannot be processed until this information is entered." on the page
    Then I select the Signature tab from the summons reply page
    And I see "Required" on the page
    And I click on the "Add or change" link
    Then I choose the "Yes" radio button
    And I press the "Done" button
    And I do not see "Summons reply is missing essential information - reply cannot be processed until this information is entered." on the page

    And I click the More Actions button
    And I press the "Request juror info by post" button

    And I press the "Continue" button
    And I see error "Select what information you need from the juror"

   #additonal info/checking checkboxes work
    And I check the "Date of birth" checkbox
    And "Date of birth" is checked

    And I check the "Telephone number" checkbox
    And "Telephone number" is checked

    And I check the "Residency" checkbox
    And "Residency" is checked

    And I check the "Mental Health Act" checkbox
    And "Mental Health Act" is checked

    And I check the "Mental Capacity Act" checkbox
    And "Mental Capacity Act" is checked

    And I check the "Bail" checkbox
    And "Bail" is checked

    And I check the "Convictions" checkbox
    And "Convictions" is checked

    And I check the "Can the juror serve on the date shown in summons?" checkbox
    And "Can the juror serve on the date shown in summons?" is checked

    And I check the "Has the juror worked in the criminal justice system in the last 5 years?" checkbox
    And "Has the juror worked in the criminal justice system in the last 5 years?" is checked


    And I check the "Does the juror have a disability or impairment that means they’ll need extra support or facilities at court?" checkbox
    And "Does the juror have a disability or impairment that means they’ll need extra support or facilities at court?" is checked

    And I check the "The juror needs to sign their summons reply" checkbox
    And "The juror needs to sign their summons reply" is checked

    And I press the "Continue" button

   #prompted to created manual letter
    And I see "You need to manually create a letter to send to the juror" on the page
    And I see "A letter will not be sent automatically." on the page
    And I see "Create a letter requesting a signature on the summons reply, using the letter generator on the shared drive." on the page
    And I see "If you’re missing other information apart from the signature, you need to manually ask for this in the letter you create." on the page
    And I see "Post the letter to the juror along with the original summons reply for them to sign." on the page

   #back
    And I click on the "Back" link
    And I uncheck the "Has the juror worked in the criminal justice system in the last 5 years?" checkbox
    And I uncheck the "Does the juror have a disability or impairment that means they’ll need extra support or facilities at court?" checkbox
    And I uncheck the "The juror needs to sign their summons reply" checkbox

   #automatic letter
    And I press the "Continue" button
    And I see "A letter will be automatically sent to the juror requesting the missing information" on the page
    And I see "This will be sent tomorrow." on the page
    And I see "If you hear back from the juror before 6pm today, you should process the reply." on the page

    And I press the "Done" button

    And I see "Summons replies" on the page
    And I see link with text "View juror's record"

   #check request letter row
    Then I check that a "request information" letter has been generated new schema

    Examples:
      | juror_number| pool_number | user          |
      | 041500131   | 415300231	  | MODTESTBUREAU |