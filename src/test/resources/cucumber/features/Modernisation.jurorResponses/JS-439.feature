Feature: JS-439 - As a bureau/court officer I want to be able to add comments around the 5 juror eligibility question

  @JurorTransformationMulti @NewSchemaConverted
  Scenario Outline: Test for Juror Eligibility Questions text boxes - Happy Path

   Given I am on "Bureau" "ithc"
   And I log in as "<user>"

   Given a bureau owned pool is created with jurors
    | court | juror_number  	    | pool_number	    | att_date_weeks_in_future	| owner |
    | 415   | <juror_number> 	    | <pool_number>     | 7				            | 400	|


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

    #living
    And I select the haven't lived consecutively radio button
    And I see "Provide details about where they have lived since their 13th birthday" on the page
    And I enter "This is a test where I am testing 1000 characters this is a test where I am testing 1000 characters this is a test where I am testing 1000 characters this is a test where I am testing 1000 characters this is a test where I am testing 1000 characters this is a test where I am testing 1000 characters this is a test where I am testing 1000 characters this is a test where I am testing 1000 characters this is a test where I am testing 1000 characters this is a test where I am testing 1000 characters this is a test where I am testing 1000 characters this is a test where I am testing 1000 characters this is a test where I am testing 1000 characters this is a test where I am testing 1000 characters this is a test where I am testing 1000 characters this is a test where I am testing 1000 characters this is a test where I am testing 1000 characters this is a test where I am testing 1000 characters this is a test where I am testing 1000 characters this is a test this is a test where I am testing 1" in the consecutively lived text box


    #mental health
    And I select that the yes radio button on mental health
    And I see "Provide details about how they're being detained, looked after or treated under the Mental Health Act" on the page
    And I enter "This is a test where I am testing 1000 characters this is a test where I am testing 1000 characters this is a test where I am testing 1000 characters this is a test where I am testing 1000 characters this is a test where I am testing 1000 characters this is a test where I am testing 1000 characters this is a test where I am testing 1000 characters this is a test where I am testing 1000 characters this is a test where I am testing 1000 characters this is a test where I am testing 1000 characters this is a test where I am testing 1000 characters this is a test where I am testing 1000 characters this is a test where I am testing 1000 characters this is a test where I am testing 1000 characters this is a test where I am testing 1000 characters this is a test where I am testing 1000 characters this is a test where I am testing 1000 characters this is a test where I am testing 1000 characters this is a test where I am testing 1000 characters this is a test this is a test where I am testing 1" in the mental health act text box

    #mental health capacity
    And I select that the yes radio button on mental health capacity
    And I see "Provide brief details about why it was decided they lack mental capacity" on the page
    And I enter "This is a test where I am testing 1000 characters this is a test where I am testing 1000 characters this is a test where I am testing 1000 characters this is a test where I am testing 1000 characters this is a test where I am testing 1000 characters this is a test where I am testing 1000 characters this is a test where I am testing 1000 characters this is a test where I am testing 1000 characters this is a test where I am testing 1000 characters this is a test where I am testing 1000 characters this is a test where I am testing 1000 characters this is a test where I am testing 1000 characters this is a test where I am testing 1000 characters this is a test where I am testing 1000 characters this is a test where I am testing 1000 characters this is a test where I am testing 1000 characters this is a test where I am testing 1000 characters this is a test where I am testing 1000 characters this is a test where I am testing 1000 characters this is a test this is a test where I am testing 1" in the mental health capacity text box
   
   
    #on bail
    And I select that the yes radio button for on bail
    And I see "Provide details about their bail and criminal offence" on the page
    And I enter "This is a test where I am testing 1000 characters this is a test where I am testing 1000 characters this is a test where I am testing 1000 characters this is a test where I am testing 1000 characters this is a test where I am testing 1000 characters this is a test where I am testing 1000 characters this is a test where I am testing 1000 characters this is a test where I am testing 1000 characters this is a test where I am testing 1000 characters this is a test where I am testing 1000 characters this is a test where I am testing 1000 characters this is a test where I am testing 1000 characters this is a test where I am testing 1000 characters this is a test where I am testing 1000 characters this is a test where I am testing 1000 characters this is a test where I am testing 1000 characters this is a test where I am testing 1000 characters this is a test where I am testing 1000 characters this is a test where I am testing 1000 characters this is a test this is a test where I am testing 1" in the on bail text box


    #criminal offence
    And I select that the yes radio button on criminal offence
    And I see "Provide details about their criminal offence" on the page
    And I see "For each conviction, give details of:" on the page
    And I see "the offence or offences they committed" on the page
    And I see "when this happened" on the page
    And I see "where they were convicted" on the page
    And I see "length of sentence" on the page
    And I enter "This is a test where I am testing 1000 characters this is a test where I am testing 1000 characters this is a test where I am testing 1000 characters this is a test where I am testing 1000 characters this is a test where I am testing 1000 characters this is a test where I am testing 1000 characters this is a test where I am testing 1000 characters this is a test where I am testing 1000 characters this is a test where I am testing 1000 characters this is a test where I am testing 1000 characters this is a test where I am testing 1000 characters this is a test where I am testing 1000 characters this is a test where I am testing 1000 characters this is a test where I am testing 1000 characters this is a test where I am testing 1000 characters this is a test where I am testing 1000 characters this is a test where I am testing 1000 characters this is a test where I am testing 1000 characters this is a test where I am testing 1000 characters this is a test this is a test where I am testing 1" in the convicted text box

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

    Then the view summons reply page is displayed
    And I see the reply status has updated to "To Do"


   Examples:
    | juror_number   | pool_number   | user          |
    | 041519388      | 415168549     | MODTESTBUREAU |


 @JurorTransformationMulti @NewSchemaConverted
 Scenario Outline: Test for Juror Eligibility Questions text boxes - Unhappy Path

  Given I am on "Bureau" "ithc"
  And I log in as "<user>"

  Given a bureau owned pool is created with jurors
   | court | juror_number  	    | pool_number	    | att_date_weeks_in_future	| owner |
   | 415   | <juror_number> 	| <pool_number>     | 7				            | 400	|


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

    #living
  And I select the haven't lived consecutively radio button
  And I see "Provide details about where they have lived since their 13th birthday" on the page
  And I enter "This is a test where I am testing 1000 characters this is a test where I am testing 1000 characters this is a test where I am testing 1000 characters this is a test where I am testing 1000 characters this is a test where I am testing 1000 characters this is a test where I am testing 1000 characters this is a test where I am testing 1000 characters this is a test where I am testing 1000 characters this is a test where I am testing 1000 characters this is a test where I am testing 1000 characters this is a test where I am testing 1000 characters this is a test where I am testing 1000 characters this is a test where I am testing 1000 characters this is a test where I am testing 1000 characters this is a test where I am testing 1000 characters this is a test where I am testing 1000 characters this is a test where I am testing 1000 characters this is a test where I am testing 1000 characters this is a test where I am testing 1000 characters this is a test this is a test where I am testing 1000 characters" in the consecutively lived text box


    #mental health
  And I select that the yes radio button on mental health
  And I see "Provide details about how they're being detained, looked after or treated under the Mental Health Act" on the page
  And I enter "This is a test where I am testing 1000 characters this is a test where I am testing 1000 characters this is a test where I am testing 1000 characters this is a test where I am testing 1000 characters this is a test where I am testing 1000 characters this is a test where I am testing 1000 characters this is a test where I am testing 1000 characters this is a test where I am testing 1000 characters this is a test where I am testing 1000 characters this is a test where I am testing 1000 characters this is a test where I am testing 1000 characters this is a test where I am testing 1000 characters this is a test where I am testing 1000 characters this is a test where I am testing 1000 characters this is a test where I am testing 1000 characters this is a test where I am testing 1000 characters this is a test where I am testing 1000 characters this is a test where I am testing 1000 characters this is a test where I am testing 1000 characters this is a test this is a test where I am testing 1000 characters" in the mental health act text box

    #mental health capacity
  And I select that the yes radio button on mental health capacity
  And I see "Provide brief details about why it was decided they lack mental capacity" on the page
  And I enter "This is a test where I am testing 1000 characters this is a test where I am testing 1000 characters this is a test where I am testing 1000 characters this is a test where I am testing 1000 characters this is a test where I am testing 1000 characters this is a test where I am testing 1000 characters this is a test where I am testing 1000 characters this is a test where I am testing 1000 characters this is a test where I am testing 1000 characters this is a test where I am testing 1000 characters this is a test where I am testing 1000 characters this is a test where I am testing 1000 characters this is a test where I am testing 1000 characters this is a test where I am testing 1000 characters this is a test where I am testing 1000 characters this is a test where I am testing 1000 characters this is a test where I am testing 1000 characters this is a test where I am testing 1000 characters this is a test where I am testing 1000 characters this is a test this is a test where I am testing 1000 characters" in the mental health capacity text box


    #on bail
  And I select that the yes radio button for on bail
  And I see "Provide details about their bail and criminal offence" on the page
  And I enter "This is a test where I am testing 1000 characters this is a test where I am testing 1000 characters this is a test where I am testing 1000 characters this is a test where I am testing 1000 characters this is a test where I am testing 1000 characters this is a test where I am testing 1000 characters this is a test where I am testing 1000 characters this is a test where I am testing 1000 characters this is a test where I am testing 1000 characters this is a test where I am testing 1000 characters this is a test where I am testing 1000 characters this is a test where I am testing 1000 characters this is a test where I am testing 1000 characters this is a test where I am testing 1000 characters this is a test where I am testing 1000 characters this is a test where I am testing 1000 characters this is a test where I am testing 1000 characters this is a test where I am testing 1000 characters this is a test where I am testing 1000 characters this is a test this is a test where I am testing 1000 characters" in the on bail text box


    #criminal offence
  And I select that the yes radio button on criminal offence
  And I see "Provide details about their criminal offence" on the page
  And I see "For each conviction, give details of:" on the page
  And I see "the offence or offences they committed" on the page
  And I see "when this happened" on the page
  And I see "where they were convicted" on the page
  And I see "length of sentence" on the page
  And I enter "This is a test where I am testing 1000 characters this is a test where I am testing 1000 characters this is a test where I am testing 1000 characters this is a test where I am testing 1000 characters this is a test where I am testing 1000 characters this is a test where I am testing 1000 characters this is a test where I am testing 1000 characters this is a test where I am testing 1000 characters this is a test where I am testing 1000 characters this is a test where I am testing 1000 characters this is a test where I am testing 1000 characters this is a test where I am testing 1000 characters this is a test where I am testing 1000 characters this is a test where I am testing 1000 characters this is a test where I am testing 1000 characters this is a test where I am testing 1000 characters this is a test where I am testing 1000 characters this is a test where I am testing 1000 characters this is a test where I am testing 1000 characters this is a test this is a test where I am testing 1000 characters" in the convicted text box

  And I click continue on the juror summons reply page
  And I see error "Details about where the person has lived since their 13th birthday must be 1000 characters or fewer"

  And I see error "Details about how they're being detained, looked after or treated under the Mental Health Act must be 1000 characters or fewer"

  And I see error "Details about why it was decided they lack mental capacity must be 1000 characters or fewer"

  And I see error "Details about their bail and criminal offence must be 1000 characters or fewer"
  
  And I see error "Details about their criminal offence must be 1000 characters or fewer"

  And I click on the "Cancel" link
  And I see "<juror_number>" on the page


  Examples:
   | juror_number   | pool_number   | user          |
   | 041519374      | 415168550     | MODTESTBUREAU |