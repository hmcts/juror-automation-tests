Feature: JM-5060 - 5062

  @JurorTransformationMulti
  Scenario Outline: JM-5060 - Mark Juror as Failed to Attend
    Given I am on "Bureau" "test"

    Given a bureau owned pool is created with jurors
      | court |juror_number  	    | pool_number	    | att_date_weeks_in_future	| owner |
      | 415   |<juror_number> 	    | <pool_number>     | 5				            | 400	|

    Then a new pool is inserted for where record has transferred to the court new schema
      |part_no              | pool_no           | owner |
      |<juror_number>       | <pool_number>     | 415   |

    #log on and search for juror
    And I log in as "<user>"

    And I Confirm all the data in the record attendance table is cleared
    #put juror in state to have their attendance status set
    When the user searches for juror record "<juror_number>" from the global search bar
    And I record a happy path paper summons response
    And I click on the "No, skip and process later" link
    When the user searches for juror record "<juror_number>" from the global search bar
    Then I click the summons reply tab
    And I click on the view summons reply link
    And I press the "Process reply" button
    And I see "How do you want to process this reply?" on the page
    And I set the radio button to "Mark as responded"
    And I press the "Continue" button
    And I see "Mark as responded" on the page
    And I check the "Mark juror as 'responded'" checkbox
    And I press the "Confirm" button

    #mark as failed to attend/error checks
    When the user searches for juror record "<juror_number>" from the global search bar
    And I press the "Update juror record" button
    And I press the "Continue" button
    And I see error "Select how you want to update the juror record"
    And I set the radio button to "Change juror status to ‘Failed to attend’"
    And I press the "Continue" button
    And I see "This will complete their service and they will not be expected at court again" on the page
    And I press the "Change status to ‘Failed to attend’" button
    And I see "You must tick the box if you want to change this juror’s status to ‘Failed to attend’" in the error banner
    And I check the failed to attend checkbox
    And I press the "Change status to ‘Failed to attend’" button
    And I see the juror record updated banner containing "Failed to attend"
    And I see the juror status has updated to "Failed to attend"


    Examples:
      |user			|juror_number  | pool_number   |
      |MODTESTCOURT |041536188      | 415212883    |


  @JurorTransformationMulti
  Scenario Outline: JM-5060 - Mark Juror as Failed to Attend for a juror with an Attendance - Unhappy Path
    Given I am on "Bureau" "test"

    Given a bureau owned pool is created with jurors
      | court |juror_number  	    | pool_number	    | att_date_weeks_in_future	| owner |
      | 415   |<juror_number> 	    | <pool_number>     | 5				            | 400	|

    Then a new pool is inserted for where record has transferred to the court new schema
      |part_no              | pool_no           | owner |
      |<juror_number>       | <pool_number>     | 415   |


    #log on and search for juror
    And I log in as "<user>"

    And I Confirm all the data in the record attendance table is cleared
    When the user searches for juror record "<juror_number>" from the global search bar
    And I record a happy path paper summons response
    And I click on the "No, skip and process later" link

    When the user searches for juror record "<juror_number>" from the global search bar
    Then I click the summons reply tab
    And I click on the view summons reply link
    And I press the "Process reply" button
    And I see "How do you want to process this reply?" on the page
    And I set the radio button to "Mark as responded"
    And I press the "Continue" button
    And I see "Mark as responded" on the page
    And I check the "Mark juror as 'responded'" checkbox
    And I press the "Confirm" button

    #check in juror in order to list as attended
    And I press the "Apps" button
    And I click on the "Juror management" link
    And I click on the "Record attendance" link
    And I click on the "Jurors in waiting" link
    And I set the radio button to "Check in"
    And I set "Hour" to "09"
    And I set "Minute" to "00"
    And I set the radio button to "am"
    And I input juror "<juror_number>" to be checked in
    And I press the "Check in juror" button
    And I see "<juror_number>" in the same row as "9:00am"

    #attempt to mark as failed to attend
    When the user searches for juror record "<juror_number>" from the global search bar
    And I press the "Update juror record" button
    And I set the radio button to "Change juror status to ‘Failed to attend’"
    And I press the "Continue" button
    And I check the failed to attend checkbox
    And I press the "Change status to ‘Failed to attend’" button
    And I see "Unable to change this juror’s status to ‘Failed to attend’" in the error banner



    Examples:
      |user			|juror_number  | pool_number   |
      |MODTESTCOURT |041536189     | 415212883 |


  @JurorTransformationMulti
  Scenario Outline: JM-5060 - Mark Juror as Failed to Attend for a juror who has given a reasonable reason - Unhappy Path
    Given I am on "Bureau" "test"

    Given a bureau owned pool is created with jurors
      | court |juror_number  	    | pool_number	    | att_date_weeks_in_future	| owner |
      | 415   |<juror_number> 	    | <pool_number>     | 5				            | 400	|

    Then a new pool is inserted for where record has transferred to the court new schema
      |part_no              | pool_no           | owner |
      |<juror_number>       | <pool_number>     | 415   |

    #log on and search for juror
    And I log in as "<user>"

    And I Confirm all the data in the record attendance table is cleared
    When the user searches for juror record "<juror_number>" from the global search bar
    And I record a happy path paper summons response
    And I click on the "No, skip and process later" link

    When the user searches for juror record "<juror_number>" from the global search bar
    Then I click the summons reply tab
    And I click on the view summons reply link
    And I press the "Process reply" button
    And I see "How do you want to process this reply?" on the page
    And I set the radio button to "Mark as responded"
    And I press the "Continue" button
    And I see "Mark as responded" on the page
    And I check the "Mark juror as 'responded'" checkbox
    And I press the "Confirm" button

    When the user searches for juror record "<juror_number>" from the global search bar
    And I press the "Update juror record" button
    And I set the radio button to "Change juror status to ‘Failed to attend’"
    And I press the "Continue" button
    And I check the failed to attend checkbox
    And I press the "Change status to ‘Failed to attend’" button
    And I see the juror record updated banner containing "Failed to attend"
    And I see the juror status has updated to "Failed to attend"

    #attempt to mark as failed to attend again now that juror has given reasonable reason
    When the user searches for juror record "<juror_number>" from the global search bar
    And I press the "Update juror record" button
    And I do not see failed to attend radio button in the update juror record section

    Examples:
      |user			|juror_number  | pool_number   |
      |MODTESTCOURT |041536190      | 415212883 |


  @JurorTransformationMulti
  Scenario Outline: JM-5062 - Undo Failed to Attend
    Given I am on "Bureau" "test"

    Given a bureau owned pool is created with jurors
      | court |juror_number  	    | pool_number	    | att_date_weeks_in_future	| owner |
      | 415   |<juror_number> 	    | <pool_number>     | 5				            | 400	|

    Then a new pool is inserted for where record has transferred to the court new schema
      |part_no              | pool_no           | owner |
      |<juror_number>       | <pool_number>     | 415   |

    #log on and search for juror
    And I log in as "<user>"

    And I Confirm all the data in the record attendance table is cleared
    When the user searches for juror record "<juror_number>" from the global search bar
    And I record a happy path paper summons response
    And I click on the "No, skip and process later" link

    When the user searches for juror record "<juror_number>" from the global search bar
    Then I click the summons reply tab
    And I click on the view summons reply link
    And I press the "Process reply" button
    And I see "How do you want to process this reply?" on the page
    And I set the radio button to "Mark as responded"
    And I press the "Continue" button
    And I see "Mark as responded" on the page
    And I check the "Mark juror as 'responded'" checkbox
    And I press the "Confirm" button

    When the user searches for juror record "<juror_number>" from the global search bar
    And I press the "Update juror record" button
    And I set the radio button to "Change juror status to ‘Failed to attend’"
    And I press the "Continue" button
    And I check the failed to attend checkbox
    And I press the "Change status to ‘Failed to attend’" button
    And I see the juror record updated banner containing "Failed to attend"
    And I see the juror status has updated to "Failed to attend"

    #Undo failed to attend
    Given I am on "Bureau" "test"
    And I log in as "<user>"

    When the user searches for juror record "<juror_number>" from the global search bar
    And I press the "Update juror record" button
    And I set the radio button to "Undo ‘Failed to attend' juror status"
    And I press the "Continue" button
    And I check the "Tick to confirm the juror's status should revert to ‘Responded’" checkbox
    And I press the "Revert to ‘Responded’" button

    And I see the juror record updated banner containing "Responded"
    And I see the juror status has updated to "Responded"

    Examples:
      |user			|juror_number  | pool_number   |
      |MODTESTCOURT |741500319      | 415240833 |
