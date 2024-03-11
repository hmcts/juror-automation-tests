Feature: JM-3826 Request Additional Information

  @JurorTransformationMulti @NewSchemaConverted
  Scenario Outline: Request Additional Information JM-3826

   Given I am on "Bureau" "test"
   And I log in as "<user>"

   Given the juror numbers have not been processed new schema
    | part_no   | pool_no   | owner |
    | <part_no> | <pool_no> | 400   |




   When the user searches for juror record "<juror_number>" from the global search bar

   #record paper summons response
    And I click the Enter summons reply button
    Then the juror details form is displayed

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

   #skip straight through processing
   Then I see "Do you want to process this summons reply as responded now?" on the page
   Then I see "The juror’s answers mean this is a straight-through reply. So you can process it as responded now, or return later." on the page
   When I click on the "No, skip and process later" link

    Then the view summons reply page is displayed
    And I see the reply status has updated to "TO DO"

   #cancel and return
   And I see the reply status on the page
   And I click the More Actions button
   And I press the "Request juror info by post" button
   And I see "What information do you need from the juror?" on the page
   And I see "Juror details" on the page
   Then I click on the "Cancel" link
   And I see "View juror's record" on the page

    #awaiting information
    And I click the More Actions button
    And I press the "Mark as awaiting information" button
    And I set the radio button to "Juror"
    And I press the "Confirm" button

   #error message
   And I see the reply status has updated to "AWAITING JUROR INFO"
   And I click the More Actions button
   And I press the "Request juror info by post" button

   And I press the "Continue" button
   And I see error "Select what information you need from the juror"

   #additonal info/checking checkboxes work
   And I check the "Date of birth" checkbox
   And "Date of birth" is checked
   And I uncheck the "Date of birth" checkbox
   And "Date of birth" is unchecked
   And I check the "Date of birth" checkbox

   And I check the "Telephone number" checkbox
   And "Telephone number" is checked
   And I uncheck the "Telephone number" checkbox
   And "Telephone number" is unchecked
   And I check the "Telephone number" checkbox

   And I check the "Residency" checkbox
   And "Residency" is checked
   And I uncheck the "Residency" checkbox
   And "Residency" is unchecked
   And I check the "Residency" checkbox

   And I check the "Mental Health Act" checkbox
   And "Mental Health Act" is checked
   And I uncheck the "Mental Health Act" checkbox
   And "Mental Health Act" is unchecked
   And I check the "Mental Health Act" checkbox

   And I check the "Mental Capacity Act" checkbox
   And "Mental Capacity Act" is checked
   And I uncheck the "Mental Capacity Act" checkbox
   And "Mental Capacity Act" is unchecked
   And I check the "Mental Capacity Act" checkbox

   And I check the "Bail" checkbox
   And "Bail" is checked
   And I uncheck the "Bail" checkbox
   And "Bail" is unchecked
   And I check the "Bail" checkbox

   And I check the "Convictions" checkbox
   And "Convictions" is checked
   And I uncheck the "Convictions" checkbox
   And "Convictions" is unchecked
   And I check the "Convictions" checkbox

   And I check the "Can the juror serve on the date shown in summons?" checkbox
   And "Can the juror serve on the date shown in summons?" is checked
   And I uncheck the "Can the juror serve on the date shown in summons?" checkbox
   And "Can the juror serve on the date shown in summons?" is unchecked
   And I check the "Can the juror serve on the date shown in summons?" checkbox

   And I check the "Has the juror worked in the criminal justice system in the last 5 years?" checkbox
   And "Has the juror worked in the criminal justice system in the last 5 years?" is checked
   And I uncheck the "Has the juror worked in the criminal justice system in the last 5 years?" checkbox
   And "Has the juror worked in the criminal justice system in the last 5 years?" is unchecked
   And I check the "Has the juror worked in the criminal justice system in the last 5 years?" checkbox

   And I check the "Does the juror have a disability or impairment that means they’ll need extra support or facilities at court?" checkbox
   And "Does the juror have a disability or impairment that means they’ll need extra support or facilities at court?" is checked
   And I uncheck the "Does the juror have a disability or impairment that means they’ll need extra support or facilities at court?" checkbox
   And "Does the juror have a disability or impairment that means they’ll need extra support or facilities at court?" is unchecked
   And I check the "Does the juror have a disability or impairment that means they’ll need extra support or facilities at court?" checkbox

   And I check the "The juror needs to sign their summons reply" checkbox
   And "The juror needs to sign their summons reply" is checked
   And I uncheck the "The juror needs to sign their summons reply" checkbox
   And "The juror needs to sign their summons reply" is unchecked
   And I check the "The juror needs to sign their summons reply" checkbox

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
   Then I check that a "request information" letter has been generated

   #set to responded/completed
   And I press the "Process reply" button
   And I see "How do you want to process this reply?" on the page
   And I set the radio button to "Mark as responded"
   And I press the "Continue" button
   And I see "Mark as responded" on the page
   And I check the "Mark juror as 'responded'" checkbox
   And I press the "Confirm" button
   And I see "Summons reply for 641500413 FNAMEFOURONETHREE LNAMEFOURONETHREE successfully processed: Responded" in the response banner

   And the request letter for court "415" is deleted

   Examples:
    | part_no   | pool_no   | user          |
    | 641500413 | 415170501 | MODTESTBUREAU |