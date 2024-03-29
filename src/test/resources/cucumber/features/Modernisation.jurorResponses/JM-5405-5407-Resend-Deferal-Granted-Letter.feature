Feature: JM-5405-5407 - Resend deferral granted letter for Bureau and Jury users

  @JurorTransformationWIP @NewSchemaConverted @JM-6349 @JM-6351 @JM-6352
  Scenario Outline:As a bureau officer test a Deferred juror can resend a granted letter by searching via juror number

    Given I am on "Bureau" "test"
    And I log in as "<user>"

    When a bureau owned pool is created with jurors
      | court | juror_number  | pool_number     | att_date_weeks_in_future  | owner |
      | 415   | <juror_number>| <pool_number>   | 5                         | 400   |

    And the user searches for juror record "<juror_number>" from the global search bar

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
    When I set the radio button to "Deferral request"
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

    Then I see the reply "status" on the response is "TO DO"
    And I see the reply "type" on the response is "DEFERRAL"
    And I press the "Process reply" button
    And I set the radio button to "Deferral request"
    And I press the "Continue" button
    And I set the "first" choice to "5" Mondays in the future
    And I set the "second" choice to "7" Mondays in the future
    And I set the "third" choice to "9" Mondays in the future
    And I press the "Continue" button

    #error validation
    And I press the "Continue" button
    And I see error "Select a deferral reason"
    And I see error "Select whether you want to grant or refuse this deferral"

    And I select "O - OTHER" from the "Reason for the deferral request" dropdown
    And I set the radio button to "Choose a different date"
    And I set the "alternate" choice to "51" Mondays in the future
    And I press the "Continue" button
    And I press the "Put in deferral maintenance" button
    And I verify the banner message "Deferral granted (other)" on the page
    When the user searches for juror record "<juror_number>" from the global search bar
    Then I see the juror status has updated to "Deferred"
    And I click the update juror record button
    And I set the radio button to "Deferral - grant or refuse"
    And I click continue on the update juror record screen
    And I select "O - OTHER" from the "Reason for the deferral request" dropdown
    When I set the radio button to "Grant deferral"
    And I press the "Continue" button
    Then I see "Deferral granted (other)" on the page

    And I press the "Apps" button
    When I click on the "Documents" link
    And I click on the "Deferral granted letters" link
    And I press the "Search" button
    Then I see error "Select whether you want to search by juror or pool"
    And I set the radio button to "Juror"
    And I press the "Search" button
    And I see error "Enter juror name, number or postcode"
    And I set "Enter juror name, number or postcode" to "<juror_number>"
    And I press the "Search" button
    And I see "Pending" on the page
    And I see "Change" on the page
    And I update juror "<juror_number>" to change the status of printed in order to resend letter
    And I press the "Apps" button
    And I click on the "Documents" link
    And I click on the "Deferral granted letters" link
    And I set the radio button to "Juror"
    And I set "Enter juror name, number or postcode" to "<juror_number>"
    And I press the "Search" button
    And I see the printed letter for juror number "<juror_number>" in the letters table
    And I am able to see and interact with the jurors Deferral letter tabs and fields
    And I check the "<juror_number>" checkbox
    And I press the "Resend deferral granted letter" button
    And I see "1 document sent for printing" on the page

    Examples:
      | juror_number  | pool_number | user          |
      |  041520026    | 415300703   | MODTESTBUREAU |

  @JurorTransformationMulti @NewSchemaConverted
  Scenario Outline:As a bureau officer verify a deferral granted letter in printing stage can delete

    Given I am on "Bureau" "test"
    And I log in as "<user>"

    When a bureau owned pool is created with jurors
      | court | juror_number  | pool_number     | att_date_weeks_in_future   | owner  |
      | 415   | <juror_number>| <pool_number>   | 5                          | 400    |

    And the user searches for juror record "<juror_number>" from the global search bar

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

  #deferral
    Then the juror summons reply types page is displayed
    When I set the radio button to "Deferral request"
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

    Then I see the reply "status" on the response is "TO DO"
    And I see the reply "type" on the response is "DEFERRAL"
    And I press the "Process reply" button
    And I set the radio button to "Deferral request"
    And I press the "Continue" button
    And I set the "first" choice to "5" Mondays in the future
    And I set the "second" choice to "7" Mondays in the future
    And I set the "third" choice to "9" Mondays in the future
    And I press the "Continue" button
    And I select "O - OTHER" from the "Reason for the deferral request" dropdown
    And I set the radio button to "Choose a different date"
    And I set the "alternate" choice to "51" Mondays in the future
    And I press the "Continue" button
    And I press the "Put in deferral maintenance" button
    And I verify the banner message "Deferral granted (other)" on the page

  #delete a pending document
    And I press the "Apps" button
    And I click on the "Documents" link
    And I click on the "Deferral granted letters" link
    And I set the radio button to "Juror"
    When I set "Enter juror name, number or postcode" to "<juror_number>"
    And I press the "Search" button
    Then I see "Pending" on the page
    And I see "Change" on the page
    And I click on the "Delete" link
    And I see "1 pending document deleted" on the page

    Examples:
      | juror_number  | pool_number | user          |
      |  041520026    | 415300703   | MODTESTBUREAU |


  @JurorTransformationWIP @NewSchemaConverted @JM-6227
  Scenario Outline:As a bureau officer test a Deferred juror can resend a granted letter by searching via Pool number

    Given I am on "Bureau" "test"
    And I log in as "<user>"
    When a bureau owned pool is created with jurors
      | court   | juror_number    | pool_number     | att_date_weeks_in_future| owner |
      | 415     | <juror_number>  | <pool_number>   | 5                       | 400  |
      | 415     | <juror_number_1>| <pool_number>   | 5                       | 400  |

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
    When I set the radio button to "Deferral request"
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

    Then I see the reply "status" on the response is "TO DO"
    And I see the reply "type" on the response is "DEFERRAL"
    And I press the "Process reply" button
    And I set the radio button to "Deferral request"
    And I press the "Continue" button
    And I set the "first" choice to "5" Mondays in the future
    And I set the "second" choice to "7" Mondays in the future
    And I set the "third" choice to "9" Mondays in the future
    And I press the "Continue" button
    And I select "O - OTHER" from the "Reason for the deferral request" dropdown
    And I set the radio button to "Choose a different date"
    And I set the "alternate" choice to "51" Mondays in the future
    And I press the "Continue" button
    And I press the "Put in deferral maintenance" button
    And I verify the banner message "Deferral granted (other)" on the page
    When the user searches for juror record "<juror_number>" from the global search bar
    And I see the juror status has updated to "Deferred"
    And I click the update juror record button
    And I set the radio button to "Deferral - grant or refuse"
    Then I click continue on the update juror record screen
    And I select "O - OTHER" from the "Reason for the deferral request" dropdown
    When I set the radio button to "Grant deferral"
    And I press the "Continue" button
    Then I see "Deferral granted (other)" on the page

#update the 2nd juror number to deferred
    When the user searches for juror record "<juror_number_1>" from the global search bar

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
    When I set the radio button to "Deferral request"
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

    Then I see the reply "status" on the response is "TO DO"
    And I see the reply "type" on the response is "DEFERRAL"
    And I press the "Process reply" button
    And I set the radio button to "Deferral request"
    And I press the "Continue" button
    And I set the "first" choice to "5" Mondays in the future
    And I set the "second" choice to "7" Mondays in the future
    And I set the "third" choice to "9" Mondays in the future
    And I press the "Continue" button
    And I select "O - OTHER" from the "Reason for the deferral request" dropdown
    And I set the radio button to "Choose a different date"
    And I set the "alternate" choice to "51" Mondays in the future
    And I press the "Continue" button
    And I press the "Put in deferral maintenance" button
    And I verify the banner message "Deferral granted (other)" on the page
    When the user searches for juror record "<juror_number>" from the global search bar
    And I see the juror status has updated to "Deferred"
    And I click the update juror record button
    And I set the radio button to "Deferral - grant or refuse"
    Then I click continue on the update juror record screen
    And I select "O - OTHER" from the "Reason for the deferral request" dropdown
    When I set the radio button to "Grant deferral"
    And I press the "Continue" button
    Then I see "Deferral granted (other)" on the page

  #search via pool  number and resend letter for first deferred juror
    When I press the "Apps" button
    And I click on the "Documents" link
    And I click on the "Deferral granted letters" link
    And I press the "Search" button
    Then I see error "Select whether you want to search by juror or pool"
    And I set the radio button to "Pool"
    And I set "Enter pool number" to "<pool_number>"
    And I press the "Search" button
    And I see "Pending" on the page
    And I see "Change" on the page
    And I update juror "<juror_number>" to change the status of printed in order to resend letter
    And I press the "Apps" button
    And I click on the "Documents" link
    And I click on the "Deferral granted letters" link
    And I set the radio button to "Pool"
    And I set "Enter pool number" to "<pool_number>"
    And I press the "Search" button
    And I check the "<juror_number>" checkbox
    When I press the "Resend deferral granted letter" button
    Then I see "1 document sent for printing" on the page
    And I update juror "<juror_number_1>" to have a status of "Excused"

    And I press the "Apps" button
    When I click on the "Documents" link
    And I click on the "Deferral granted letters" link
    And I press the "Search" button
    Then I see error "Select whether you want to search by juror or pool"
    And I set the radio button to "Pool"
    And I set "Enter pool number" to "<pool_number>"
    And I press the "Search" button
    Then I see "<juror_number>" in the same row as "Deferred"
    #Script will fail due to JM-6227
    And I see "<juror_number_1>" in the same row as "Excused"

    Examples:
      | juror_number  |juror_number_1|pool_number            | user          |
        |  041520026    | 041520027             |415300703   | MODTESTBUREAU |


  @JurorTransformationWIP @NewSchemaConverted @JM-6703
  Scenario Outline:Verify as a bureau user can view letters queued for printing and can delete it

    Given I am on "Bureau" "test"
    And I log in as "<user>"
    When a bureau owned pool is created with jurors
      | court   | juror_number  | pool_number     | att_date_weeks_in_future   | owner |
      | 415     | <juror_number>| <pool_number>   | 5                       | 400  |

    And the user searches for juror record "<juror_number>" from the global search bar

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
    When I set the radio button to "Deferral request"
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
    And the juror summons reply Signature page is displayed
    When I select that the summons reply has been signed
    And I click done on the juror summons reply page

    Then I see the reply "status" on the response is "TO DO"
    And I see the reply "type" on the response is "DEFERRAL"
    And I press the "Process reply" button
    And I set the radio button to "Deferral request"
    And I press the "Continue" button
    And I set the "first" choice to "5" Mondays in the future
    And I set the "second" choice to "7" Mondays in the future
    And I set the "third" choice to "9" Mondays in the future
    And I press the "Continue" button
    And I select "O - OTHER" from the "Reason for the deferral request" dropdown
    And I set the radio button to "Choose a different date"
    And I set the "alternate" choice to "51" Mondays in the future
    And I press the "Continue" button
    And I press the "Put in deferral maintenance" button
    And I verify the banner message "Deferral granted (other)" on the page
    When the user searches for juror record "<juror_number>" from the global search bar
    Then I see the juror status has updated to "Deferred"
    And I click the update juror record button
    And I set the radio button to "Deferral - grant or refuse"
    And I click continue on the update juror record screen
    And I select "O - OTHER" from the "Reason for the deferral request" dropdown
    When I set the radio button to "Grant deferral"
    Then I select to Choose a different date
    Then I set the "new" choice to "51" Mondays in the future
    And I press the "Continue" button
    Then I see "Deferral granted (other)" on the page


   #navigate to documents and verify the printing message
    And I press the "Apps" button
    And I click on the "Documents" link
    And I click on the "Deferral granted letters" link
    When I set the radio button to "Show all letters queued for printing"
    And I press the "Search" button
    Then I see "041520026" on the page
    And I see "Change" on the page
    When I click on "Delete" in the same row as "<juror_number>"
    And I see "1 pending document deleted" on the page

    Examples:
      | juror_number  |  pool_number | user          |
      |  041520026     |415300703   | MODTESTBUREAU |


  @JurorTransformationMultiWIP @NewSchemaConverted @JM-6686
  Scenario Outline:As a jury officer test a Deferred juror can print a granted letter by searching via juror number

    Given I am on "Bureau" "test"
    When a bureau owned pool is created with jurors
      | court |juror_number   | pool_number	    | att_date_weeks_in_future	| owner |
      | 415   | <juror_number>| <pool_number>   | 5                         | 400  |

    Then a new pool is inserted for where record has transferred to the court new schema
     |part_no        | pool_no           | owner |
     | <juror_number>| <pool_number>     | 415   |

    And I log in as "<user>"
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
    When I set the radio button to "Deferral request"
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
    And the juror summons reply Signature page is displayed
    When I select that the summons reply has been signed
    And I click done on the juror summons reply page

    And I see the reply "status" on the response is "TO DO"
    And I see the reply "type" on the response is "DEFERRAL"
    And I press the "Process reply" button
    And I set the radio button to "Deferral request"
    And I press the "Continue" button
    And I set the "first" choice to "5" Mondays in the future
    And I set the "second" choice to "7" Mondays in the future
    And I set the "third" choice to "9" Mondays in the future
    And I press the "Continue" button
    And I select "O - OTHER" from the "Reason for the deferral request" dropdown
    Then I set the radio button to "Choose a different date"
    And I set the "alternate" choice to "51" Mondays in the future
    And I press the "Continue" button
    And I press the "Put in deferral maintenance" button
    When the user searches for juror record "<juror_number>" from the global search bar
    Then I see the juror status has updated to "Deferred"
    And I click the update juror record button
    And I set the radio button to "Deferral - grant or refuse"
    Then I click continue on the update juror record screen
    And I select "O - OTHER" from the "Reason for the deferral request" dropdown
    When I set the radio button to "Grant deferral"
    And I press the "Continue" button

    And I see "Do you want to print a deferral granted letter?" on the page
    And I choose the "No" radio button
    And I press the "Continue" button

    Then I see "Deferral granted (other)" on the page

    And I press the "Apps" button
    When I click on the "Documents" link
    And I click on the "Deferral granted letters" link
    And I press the "Search" button
    Then I see error "Select whether you want to search by juror or pool"
    And I see "juror" on the page
    And I see "Pool" on the page
    And I see "Include printed" on the page
    And I see "Search" on the page
    And I set the radio button to "Juror"
    And I press the "Search" button
    And I see error "Enter juror name, number or postcode"
    When I set "Enter juror name, number or postcode" to "<juror_number>"
    And I press the "Search" button
    Then I see "Change" on the page
    And I see "Print deferral granted letter" on the page
    And I am able to see and interact with the jurors Deferral letter tabs and fields
    When I check the "<juror_number>" checkbox
    And I press the "Print deferral granted letter" button
    Then I see "https://juror-test-bureau.clouddev.online/documents/deferral-granted/letters-list?documentSearchBy=juror&jurorDetails=041530028" in the URL

    Examples:
      | juror_number  | pool_number | user         |
      |  041530027    | 415300305   | MODTESTCOURT |

  @JurorTransformationWIP @NewSchemaConverted @JM-6338
  Scenario Outline:As a jury officer test a Deferred juror can print a granted letter by searching via pool number

    Given I am on "Bureau" "test"
    When a bureau owned pool is created with jurors
      | court |juror_number  	    | pool_number	    | att_date_weeks_in_future	| owner |
      | 415   | <juror_number>| <pool_number>   | 5                          | 400  |

    Then a new pool is inserted for where record has transferred to the court new schema
      |part_no              | pool_no           | owner |
      | <juror_number>| <pool_number>     | 415   |

    And I log in as "<user>"
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
    When I set the radio button to "Deferral request"
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
    And the juror summons reply Signature page is displayed
    When I select that the summons reply has been signed
    And I click done on the juror summons reply page

    Then I see the reply "status" on the response is "TO DO"
    And I see the reply "type" on the response is "DEFERRAL"
    And I press the "Process reply" button
    And I set the radio button to "Deferral request"
    And I press the "Continue" button
    And I set the "first" choice to "5" Mondays in the future
    And I set the "second" choice to "7" Mondays in the future
    And I set the "third" choice to "9" Mondays in the future
    And I press the "Continue" button
    And I select "O - OTHER" from the "Reason for the deferral request" dropdown
    And I set the radio button to "Choose a different date"
    And I set the "alternate" choice to "51" Mondays in the future
    And I press the "Continue" button
    And I press the "Put in deferral maintenance" button
    When the user searches for juror record "<juror_number>" from the global search bar
    Then I see the juror status has updated to "Deferred"
    And I click the update juror record button
    And I set the radio button to "Deferral - grant or refuse"
    Then I click continue on the update juror record screen
    And I select "O - OTHER" from the "Reason for the deferral request" dropdown
    When I set the radio button to "Grant deferral"
    And I press the "Continue" button
    Then I see "Do you want to print a deferral granted letter?" on the page
    And I choose the "Yes" radio button
    And I press the "Continue" button
    And I return to the previous tab
    When I press the "Apps" button
    And I click on the "Documents" link
    And I click on the "Deferral granted letters" link
    And I press the "Search" button
    Then I see error "Select whether you want to search by juror or pool"
    And I see "juror" on the page
    And I see "Pool" on the page
    And I see "Include printed" on the page
    And I see "Search" on the page
    And I set the radio button to "Pool"
    And I press the "Search" button
    And I see error "Enter pool number"
    When I set "Enter pool number" to "<pool_number>"
    And I check the "Include printed" checkbox
    And I press the "Search" button
    Then I see "Change" on the page
    And I see "Print deferral granted letter" on the page
    And I am able to see and interact with the jurors Deferral letter tabs and fields
    #below step will fail due to JM-6338
    And I see the printed letter for juror number "<juror_number>" in the letters table
    When I check the "<juror_number>" checkbox
    And I see "<juror_number_1>" on the page
    And I press the "Print deferral granted letter" button
    Then I see "https://juror-test-bureau.clouddev.online/documents/deferral-granted/letters-list?documentSearchBy=pool&poolDetails=415300305&includePrinted=includePrinted" in the URL

    Examples:
      | juror_number  | juror_number_1|pool_number | user          |
      |  041530028    | 041530027   |415300305   | MODTESTCOURT   |

