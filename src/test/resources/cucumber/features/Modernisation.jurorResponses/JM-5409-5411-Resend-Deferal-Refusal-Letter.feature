Feature: 1)JM-5409,JM-5411 - As a Bureau/jury officer I need to resend a deferral refusal letters

  @JurorTransformationMulti
  Scenario Outline:Verify as a bureau officer can able to resend a deferral refusal letter

    Given I am on "Bureau" "demo"
    And I log in as "<user>"

    When a bureau owned pool is created with jurors
      | court | juror_number   | pool_number   | att_date_weeks_in_future | owner |
      | 415   | <juror_number> | <pool_number> | 5                        | 400   |

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

    Then I see the reply "status" on the response is "To Do"
    And I see the reply "type" on the response is "Deferral"
    And I press the "Process reply" button
    And I set the radio button to "Deferral request"
    And I press the "Continue" button
    And I set the "first" choice to "5" Mondays in the future
    And I set the "second" choice to "7" Mondays in the future
    And I set the "third" choice to "9" Mondays in the future
    And I press the "Continue" button
    And I select "O - OTHER" from the "Reason for the deferral request" dropdown
    And I set the radio button to "Choose a different date"
    And I set the "alternate" choice to "47" Mondays in the future
    And I press the "Continue" button
    And I press the "Put in deferral maintenance" button
    And I verify the banner message "Deferral granted" on the page
    When the user searches for juror record "<juror_number>" from the global search bar
    Then I see the juror status has updated to "Deferred"
    And I press the "Update juror record" button
    And I set the radio button to "Mark as responded"
    And I press the "Continue" button
    And I check the "Mark juror as 'responded'" checkbox
    And I press the "Confirm" button

    When the user searches for juror record "<juror_number>" from the global search bar
    And I click the update juror record button
    And I set the radio button to "Deferral - grant or refuse"
    And I press the "Continue" button
    And I select "O - OTHER" from the "Reason for the deferral request" dropdown
    When I set the radio button to "Refuse deferral"
    And I press the "Continue" button
    Then I see "Deferral refused (other)" on the page

    And I press the "Apps" button
    When I click on the "Documents" link
    And I click on the "Deferral refused letters" link
    And I press the "Search" button
    Then I see error "Select whether you want to search by juror or pool"
    And I set the radio button to "Juror"
    And I press the "Search" button
    And I see error "Enter juror number"
    And I set "Enter juror number" to "<juror_number>"
    And I press the "Search" button

    And I see "Pending" on the page
    And I see "Change" on the page
    And I update juror "<juror_number>" to change the status of printed in order to resend letter
    And I press the "Apps" button
    And I click on the "Documents" link
    And I click on the "Deferral refused letters" link
    And I set the radio button to "Juror"
    When I set "Enter juror number" to "<juror_number>"
    And I press the "Search" button
    And I see the printed letter for juror number "<juror_number>" in the letters table
    Then I am able to see and interact with the jurors Deferral Refused letter tabs and fields
    When I check the "<juror_number>" checkbox
    And I press the "Resend deferral refused letter" button
    Then I see "1 document sent for printing" on the page

    Examples:
      | juror_number | pool_number | user          |
      | 041520030    | 415300707   | MODTESTBUREAU |

  @JurorTransformationMulti
  Scenario Outline:As a bureau officer verify a deferred juror letter in printing stage can delete

    Given I am on "Bureau" "ithc"
    And I clear down the bulk print data table for Juror "<juror_number>"
    And I log in as "<user>"
    When a bureau owned pool is created with jurors
      | court | juror_number   | pool_number   | att_date_weeks_in_future | owner |
      | 415   | <juror_number> | <pool_number> | 5                        | 400   |

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

    Then I see the reply "status" on the response is "To Do"
    And I see the reply "type" on the response is "Deferral"
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
    And I verify the banner message "Deferral granted" on the page
    When the user searches for juror record "<juror_number>" from the global search bar
    Then I see the juror status has updated to "Deferred"

    And I click the update juror record button
    And I set the radio button to "Mark as responded"
    And I press the "Continue" button
    And I check the "Mark juror as 'responded'" checkbox
    And I press the "Confirm" button

    When the user searches for juror record "<juror_number>" from the global search bar
    And I click the update juror record button
    And I set the radio button to "Deferral - grant or refuse"
    And I press the "Continue" button
    And I select "O - OTHER" from the "Reason for the deferral request" dropdown
    When I set the radio button to "Refuse deferral"
    And I press the "Continue" button
    Then I see "Deferral refused (other)" on the page
     #delete a pending document
    And I press the "Apps" button
    And I click on the "Documents" link
    And I click on the "Deferral refused letters" link
    And I set the radio button to "Juror"
    When I set "Enter juror number" to "<juror_number>"
    And I press the "Search" button
    Then I see "Pending" on the page
    And I see "Change" on the page
    When I click on the "Delete" link
    Then I see "1 pending document deleted" on the page

    Examples:
      | juror_number | pool_number | user          |
      | 041520123    | 415300706   | MODTESTBUREAU |


  @JurorTransformationMulti
  Scenario Outline:Verify as a bureau user can view letters queued for printing and can delete it

    Given I am on "Bureau" "ithc"
    And I clear down the bulk print data table for Juror "<juror_number>"
    And I log in as "<user>"
    When a bureau owned pool is created with jurors
      | court | juror_number   | pool_number   | att_date_weeks_in_future | owner |
      | 415   | <juror_number> | <pool_number> | 5                        | 400   |

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

    Then I see the reply "status" on the response is "To Do"
    And I see the reply "type" on the response is "Deferral"
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
    And I verify the banner message "Deferral granted" on the page
    When the user searches for juror record "<juror_number>" from the global search bar
    Then I see the juror status has updated to "Deferred"
    And I click the update juror record button
    And I set the radio button to "Mark as responded"
    And I press the "Continue" button
    And I check the "Mark juror as 'responded'" checkbox
    And I press the "Confirm" button

    When the user searches for juror record "<juror_number>" from the global search bar
    And I click the update juror record button
    And I set the radio button to "Deferral - grant or refuse"
    And I press the "Continue" button
    And I select "O - OTHER" from the "Reason for the deferral request" dropdown
    When I set the radio button to "Refuse deferral"
    And I press the "Continue" button
    Then I see "Deferral refused (other)" on the page

   #navigate to documents and verify the printing message
    And I press the "Apps" button
    And I click on the "Documents" link
    And I click on the "Deferral refused letters" link
    When I set the radio button to "Show all letters queued for printing"
    And I press the "Search" button
    Then I see "041520124" on the page
    And I see "Change" on the page
    When I click on "Delete" in the same row as "<juror_number>"
    Then I see "1 pending document deleted" on the page

    Examples:
      | juror_number | pool_number | user          |
      | 041520124    | 415300708   | MODTESTBUREAU |


  @JurorTransformationMulti
  Scenario Outline:As a jury officer test a Deferred juror can resend a refused letter by searching via juror number

    Given I am on "Bureau" "ithc"
    When a bureau owned pool is created with jurors
      | court | juror_number   | pool_number   | att_date_weeks_in_future | owner |
      | 415   | <juror_number> | <pool_number> | 5                        | 400   |

    Then a new pool is inserted for where record has transferred to the court new schema
      | part_no        | pool_no       | owner |
      | <juror_number> | <pool_number> | 415   |

    And I log in as "<user>"
    And I update the bureau transfer date of the juror "<juror_number>"
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

    And I see the reply "status" on the response is "To Do"
    And I see the reply "type" on the response is "Deferral"
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
    And I press the "Continue" button
    And I select "O - OTHER" from the "Reason for the deferral request" dropdown
    When I set the radio button to "Refuse deferral"
    And I press the "Continue" button
    Then I see "Do you want to print a deferral refused letter?" on the page
    When I choose the "No" radio button
    And I press the "Continue" button
    Then I see "Deferral refused (other)" on the page

    And I press the "Apps" button
    When I click on the "Documents" link
    And I click on the "Deferral refused letters" link
    And I press the "Search" button
    Then I see error "Select whether you want to search by juror or pool"
    And I see "juror" on the page
    And I see "Pool" on the page
    And I see "Include printed" on the page
    And I see "Search" on the page
    And I set the radio button to "Juror"
    And I press the "Search" button
    And I see error "Enter juror number"
    When I set "Enter juror number" to "<juror_number>"
    And I press the "Search" button
    Then I see "Change" on the page
    And I see "Print deferral refused letter" on the page
    And I am able to see and interact with the jurors Deferral Refused letter tabs and fields
    When I check the "<juror_number>" checkbox
    And I press the "Print deferral refused letter" button
    Then I see "/documents/deferral-refused/letters-list?documentSearchBy=juror_number&jurorNumber=041530033" in the URL

    Examples:
      | juror_number | pool_number | user         |
      | 041530033    | 415300345   | MODTESTCOURT |

  @JurorTransformationMulti
  Scenario Outline:As a jury officer test a Deferred juror can resend a granted refused letter by searching via pool number

    Given I am on "Bureau" "ithc"

    When a bureau owned pool is created with jurors
      | court | juror_number   | pool_number   | att_date_weeks_in_future | owner |
      | 415   | <juror_number> | <pool_number> | 5                        | 400   |

    Then a new pool is inserted for where record has transferred to the court new schema
      | part_no        | pool_no       | owner |
      | <juror_number> | <pool_number> | 415   |

    And I log in as "<user>"
    And I update the bureau transfer date of the juror "<juror_number>"
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

    Then I see the reply "status" on the response is "To Do"
    And I see the reply "type" on the response is "Deferral"
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
    And I press the "Continue" button
    And I select "O - OTHER" from the "Reason for the deferral request" dropdown
    When I set the radio button to "Refuse deferral"
    And I press the "Continue" button
    Then I see "Do you want to print a deferral refused letter?" on the page
    When I choose the "Yes" radio button
    And I press the "Continue" button
    Then I see "Deferral refused (other)" on the page

    When I press the "Apps" button
    And I click on the "Documents" link
    And I click on the "Deferral refused letters" link
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
    And I see the printed letter for juror number "<juror_number>" in the letters table
    And I see "Print deferral refused letter" on the page
    When I check the "<juror_number>" checkbox
    And I press the "Print deferral refused letter" button
    Then I see "documents/deferral-refused/letters-list" in the URL

    Examples:
      | juror_number | pool_number | user         |
      | 041530029    | 415300305   | MODTESTCOURT |