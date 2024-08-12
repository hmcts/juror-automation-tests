Feature:As a Bureau/jury officer I want to re send a postponement letter

  @JurorTransformationMulti
  Scenario Outline:As a bureau officer test a postponement juror can resend a letter by searching via juror number

    Given I am on "Bureau" "test"
    And I log in as "<user>"

    When a bureau owned pool is created with jurors
      | court | juror_number   | pool_number   | att_date_weeks_in_future | owner |
      | 415   | <juror_number> | <pool_number> | 5                        | 400   |

    And the user searches for juror record "<juror_number>" from the global search bar
    And I clear down the bulk print data table for Juror "<juror_number>"
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
    And I set the radio button to "No"
    And I click continue on the juror summons reply page

  #confirm/sign
    And the juror summons reply Signature page is displayed
    When I select that the summons reply has been signed
    And I click done on the juror summons reply page
    Then I see "Do you want to process this summons reply as responded now?" on the page
    And I press the "Yes, process now" button
    And I click on the "<juror_number>" link
    And I press the "Update juror record" button
    And I set the radio button to "Postpone service start date"
    And I press the "Continue" button
    When I set the "Enter a new service start date" date to a Monday "38" weeks in the future
    And I press the "Continue" button
    Then I see "There are no active pools for this date" on the page
    And I press the "Put in deferral maintenance" button
    And I press the "Apps" button
    When I click on the "Documents" link
    And I click on the "Postponement letters" link
    Then I see "Juror" on the page
    And I see "Pool" on the page
    And I see "Show all letters queued for printing" on the page
    When I press the "Search" button
    Then I see error "Select whether you want to search by juror or pool"
    And I set the radio button to "Juror"
    And I press the "Search" button
    And I see error "Enter juror number"
    And I set "Enter juror number" to "<juror_number>"
    And I press the "Search" button
    And I see "Pending" on the page
    And I see "Change" on the page
    And I see "<juror_number>" on the page
    And I update juror "<juror_number>" to change the status of printed in order to resend letter
    And I press the "Apps" button
    And I click on the "Documents" link
    And I click on the "Postponement letters" link
    And I set the radio button to "Juror"
    And I set "Enter juror number" to "<juror_number>"
    And I press the "Search" button
    And I see the printed letter for juror number "<juror_number>" in the letters table
    And I am able to see and interact with the jurors Postponement letter tabs and fields
    And I check the "<juror_number>" checkbox
    When I press the "Resend postponement letter" button
    Then I see "1 document sent for printing" on the page

    Examples:
      | juror_number | pool_number | user          |
      | 041520043    | 415300725   | MODTESTBUREAU |

  @JurorTransformationMulti @NewSchemaConverted
  Scenario Outline:Verify as bureau officer postponement juror can delete the letter in pending stage

    Given I am on "Bureau" "test"
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
    When I set the radio button to "Can serve on date shown in summons"
    And I click continue on the juror summons reply page

  #cjs
    Then the juror summons reply CJS employment page is displayed
    When I select that the juror has not worked in the criminal justice system
    And I click continue on the juror summons reply page

  #reasonable adjustments
    Then the juror summons reply reasonable adjustments page is displayed
    And I set the radio button to "No"
    And I click continue on the juror summons reply page

  #confirm/sign
    Then the juror summons reply Signature page is displayed
    When I select that the summons reply has been signed
    And I click done on the juror summons reply page
    Then I see "Do you want to process this summons reply as responded now?" on the page
    And I press the "Yes, process now" button
    And I click on the "<juror_number>" link
    And I press the "Update juror record" button
    And I set the radio button to "Postpone service start date"
    And I press the "Continue" button
    When I set the "Enter a new service start date" date to a Monday "38" weeks in the future
    And I press the "Continue" button
    Then I see "There are no active pools for this date" on the page
    And I press the "Put in deferral maintenance" button
    And I press the "Apps" button
    When I click on the "Documents" link
    And I click on the "Postponement letters" link
    Then I see "Juror" on the page
    And I see "Pool" on the page
    And I see "Show all letters queued for printing" on the page
    When I press the "Search" button
    Then I see error "Select whether you want to search by juror or pool"
    And I set the radio button to "Juror"
    And I press the "Search" button
    And I see error "Enter juror number"
    And I set "Enter juror number" to "<juror_number>"
    And I press the "Search" button
    And I see "Pending" on the page
    And I see "Change" on the page
    And I see "<juror_number>" on the page
    When I click on the "Delete" link
    Then I see "1 pending document deleted" on the page

    Examples:
      | juror_number | pool_number | user          |
      | 041520056    | 415300723   | MODTESTBUREAU |


  @JurorTransformationMulti @NewSchemaConverted
  Scenario Outline:As a bureau officer test a postponement juror can resend a letter by searching via Pool number

    Given I am on "Bureau" "test"
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
    When I set the radio button to "Can serve on date shown in summons"
    And I click continue on the juror summons reply page

  #cjs
    Then the juror summons reply CJS employment page is displayed
    When I select that the juror has not worked in the criminal justice system
    And I click continue on the juror summons reply page

  #reasonable adjustments
    Then the juror summons reply reasonable adjustments page is displayed
    And I set the radio button to "No"
    And I click continue on the juror summons reply page

  #confirm/sign
    Then the juror summons reply Signature page is displayed
    When I select that the summons reply has been signed
    And I click done on the juror summons reply page
    Then I see "Do you want to process this summons reply as responded now?" on the page
    And I press the "Yes, process now" button
    And I click on the "<juror_number>" link
    And I press the "Update juror record" button
    And I set the radio button to "Postpone service start date"
    And I press the "Continue" button
    When I set the "Enter a new service start date" date to a Monday "38" weeks in the future
    And I press the "Continue" button
    Then I see "There are no active pools for this date" on the page
    And I press the "Put in deferral maintenance" button
    And I press the "Apps" button
    When I click on the "Documents" link
    And I click on the "Postponement letters" link
    Then I see "Juror" on the page
    And I see "Pool" on the page
    And I see "Show all letters queued for printing" on the page
    And I press the "Search" button
    And I see error "Select whether you want to search by juror or pool"
    And I set the radio button to "Pool"
    And I press the "Search" button
    And I see error "Enter pool number"
    And I set "Enter pool number" to "<pool_number>"
    And I press the "Search" button
    And I see "Pending" on the page
    And I see "Change" on the page
    And I see "<juror_number>" on the page
    And I update juror "<juror_number>" to change the status of printed in order to resend letter
    And I press the "Apps" button
    And I click on the "Documents" link
    And I click on the "Postponement letters" link
    And I set the radio button to "Pool"
    When I set "Enter pool number" to "<pool_number>"
    And I press the "Search" button
    Then I see the printed letter for juror number "<juror_number>" in the letters table
    And I am able to see and interact with the jurors Postponement letter tabs and fields
    And I check the "<juror_number>" checkbox
    When I press the "Resend postponement letter" button
    Then I see "1 document sent for printing" on the page

    Examples:
      | juror_number | pool_number | user          |
      | 041520044    | 415300726   | MODTESTBUREAU |


  @JurorTransformationMulti @NewSchemaConverted
  Scenario Outline:Verify show all letters queued for printing for postponement jurors and can delete it

    Given I am on "Bureau" "test"
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
    When I set the radio button to "Can serve on date shown in summons"
    And I click continue on the juror summons reply page

  #cjs
    Then the juror summons reply CJS employment page is displayed
    When I select that the juror has not worked in the criminal justice system
    And I click continue on the juror summons reply page

  #reasonable adjustments
    Then the juror summons reply reasonable adjustments page is displayed
    And I set the radio button to "No"
    And I click continue on the juror summons reply page

  #confirm/sign
    And the juror summons reply Signature page is displayed
    When I select that the summons reply has been signed
    And I click done on the juror summons reply page
    Then I see "Do you want to process this summons reply as responded now?" on the page
    And I press the "Yes, process now" button
    And I click on the "<juror_number>" link
    And I press the "Update juror record" button
    And I set the radio button to "Postpone service start date"
    And I press the "Continue" button
    When I set the "Enter a new service start date" date to a Monday "38" weeks in the future
    And I press the "Continue" button
    Then I see "There are no active pools for this date" on the page
    And I press the "Put in deferral maintenance" button
    And I press the "Apps" button
    When I click on the "Documents" link
    And I click on the "Postponement letters" link
    Then I see "Juror" on the page
    And I see "Pool" on the page
    And I see "Show all letters queued for printing" on the page
    When I press the "Search" button
    Then I see error "Select whether you want to search by juror or pool"
    When I set the radio button to "Show all letters queued for printing"
    And I press the "Search" button
    Then I see "<juror_number>" on the page
    And I see "Change" on the page
    When I click on "Delete" in the same row as "<juror_number>"
    Then I see "1 pending document deleted" on the page

    Examples:
      | juror_number | pool_number | user          |
      | 041520057    | 415300724   | MODTESTBUREAU |


  @JurorTransformationMulti @NewSchemaConverted
  Scenario Outline:As a jury officer test a postponement juror can re send a  letter by searching via juror number

    Given I am on "Bureau" "test"
    When a bureau owned pool is created with jurors
      | court | juror_number   | pool_number   | att_date_weeks_in_future | owner |
      | 415   | <juror_number> | <pool_number> | 5                        | 400   |

    Then a new pool is inserted for where record has transferred to the court new schema
      | part_no        | pool_no       | owner |
      | <juror_number> | <pool_number> | 415   |

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
    When I set the radio button to "Can serve on date shown in summons"
    And I click continue on the juror summons reply page

  #cjs
    Then the juror summons reply CJS employment page is displayed
    When I select that the juror has not worked in the criminal justice system
    And I click continue on the juror summons reply page

  #reasonable adjustments
    Then the juror summons reply reasonable adjustments page is displayed
    And I set the radio button to "No"
    And I click continue on the juror summons reply page

  #confirm/sign
    And the juror summons reply Signature page is displayed
    When I select that the summons reply has been signed
    And I click done on the juror summons reply page
    Then I see "Do you want to process this summons reply as responded now?" on the page
    And I press the "Yes, process now" button
    And the user searches for juror record "<juror_number>" from the global search bar
    And I press the "Update juror record" button
    And I set the radio button to "Postpone service start date"
    And I press the "Continue" button
    When I set the "Enter a new service start date" date to a Monday "38" weeks in the future
    And I press the "Continue" button
    Then I see "There are no active pools for this date" on the page
    And I press the "Put in deferral maintenance" button
    And I see "Do you want to print a postponement letter?" on the page
    When I set the radio button to "No"
    And I press the "Continue" button
    Then I see "Juror record updated: Postponed" on the page
    And I press the "Apps" button
    When I click on the "Documents" link
    And I click on the "Postponement letters" link
    And I press the "Search" button
    Then I see error "Select whether you want to search by juror or pool"
    And I see "juror" on the page
    And I see "Pool" on the page
    And I see "Include printed" on the page
    And I see "Search" on the page
    And I set the radio button to "Juror"
    And I press the "Search" button
    And I see error "Enter juror number"
    And I set "Enter juror number" to "<juror_number>"
    And I press the "Search" button
    And I see "Change" on the page
    And I see "Print postponement letter" on the page
    And I am able to see and interact with the jurors Postponement letter tabs and fields
    When I check the "<juror_number>" checkbox
    And I press the "Print postponement letter" button
    Then I see "documents/postponement/letters-list" in the URL

    Examples:
      | juror_number | pool_number | user         |
      | 041530090    | 415300306   | MODTESTCOURT |

  @JurorTransformationMulti @NewSchemaConverted
  Scenario Outline:Verify postponement juror with print letter searching via pool number

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
    When I set the radio button to "Can serve on date shown in summons"
    And I click continue on the juror summons reply page

  #cjs
    Then the juror summons reply CJS employment page is displayed
    When I select that the juror has not worked in the criminal justice system
    And I click continue on the juror summons reply page

  #reasonable adjustments
    Then the juror summons reply reasonable adjustments page is displayed
    And I set the radio button to "No"
    And I click continue on the juror summons reply page

  #confirm/sign
    And the juror summons reply Signature page is displayed
    When I select that the summons reply has been signed
    And I click done on the juror summons reply page
    Then I see "Do you want to process this summons reply as responded now?" on the page
    And I press the "Yes, process now" button
    And the user searches for juror record "<juror_number>" from the global search bar
    And I press the "Update juror record" button
    And I set the radio button to "Postpone service start date"
    And I press the "Continue" button
    When I set the "Enter a new service start date" date to a Monday "38" weeks in the future
    And I press the "Continue" button
    Then I see "There are no active pools for this date" on the page
    When I press the "Put in deferral maintenance" button
    Then I see "Do you want to print a postponement letter?" on the page
    When I set the radio button to "Yes"
    And I press the "Continue" button
    Then I see "Juror record updated: Postponed" on the page

    And I press the "Apps" button
    When I click on the "Documents" link
    And I click on the "Postponement letters" link
    And I press the "Search" button
    Then I see error "Select whether you want to search by juror or pool"
    And I see "juror" on the page
    And I see "Pool" on the page
    And I see "Include printed" on the page
    And I see "Search" on the page
    When I set the radio button to "Pool"
    And I press the "Search" button
    Then I see error "Enter pool number"
    When I set "Enter pool number" to "<pool_number>"
    And I check the "Include printed" checkbox
    And I press the "Search" button
    Then I see "Print postponement letter" on the page
    And I am able to see and interact with the jurors Postponement letter tabs and fields
    And I see the printed letter for juror number "<juror_number>" in the letters table
    When I check the juror "<juror_number>" checkbox
    And I press the "Print postponement letter" button
    Then I see "documents/postponement/letters-list" in the URL

    Examples:
      | juror_number | pool_number | user         |
      | 041530031    | 415300313   | MODTESTCOURT |




