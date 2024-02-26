Feature: JM-4326 - Defer a juror and then complete their service at a later date

  @JurorTransformationWIP @JM-5795
  Scenario Outline: Mark juror as deferred - Add to pool Happy path paper - Bureau Officer
    Given I am on "Bureau" "test"

    Given I log in as "<user>"

    Given a bureau owned pool is created with jurors
      | court |juror_number       | pool_number      | att_date_weeks_in_future | owner |
      | 415   |<juror_number>     | <pool_number>     | 5                      | 400  |
      | 415   |<juror_number_1>     | <pool_number>     | 5                      | 400  |

    And "<part_no>" has "NEXT_DATE" as "5 mondays time" new schema
    And pool "<pool_no>" has attendance date as "5 mondays time" new schema

    #create a pool to defer to
    Given I navigate to the pool request screen
    Given I create an active "Crown" court pool request for court "415", "14" Mondays in the future

    #search for juror and record paper response
    When the user searches for juror record "<juror_number>" from the global search bar
    Then I record a happy path deferral paper summons response
    And I see the reply "type" on the response is "DEFERRAL"

    #process response as deferral
    Then I click the process reply button
    Then I set the radio button to "Deferral request"
    And I click continue on the process reply page

    Then I set the "first" choice to "11" Mondays in the future
    Then I set the "second" choice to "12" Mondays in the future
    Then I set the "third" choice to "13" Mondays in the future
    And I click continue on the process reply page

    Then I select "O - OTHER" from the "Reason for the deferral request" dropdown
    Then I set the radio button to "Choose a different date"
    Then I set the "alternate" choice to "14" Mondays in the future
    And I press the "Continue" button

    Then I see "Select a pool for this date" on the page
    And I select the pool I created for the deferral
    And I press the "Continue" button

    And I do not see "Sorry, there is a technical problem" on the page
    And I see "Deferral granted (other)" on the page

    #check summons response
    When the user searches for juror record "<juror_number>" from the global search bar
    And I click on the "Summons reply" link
    #will fail here as a result of  JM-5795
    And I see the processing outcome of the summons reply on juror record is "Deferral - granted (other)"
    And I click on the "View summons reply" link
    And I see the reply status has updated to "COMPLETED"
    And I see the reply type has been updated to "DEFERRAL"

    Examples:
      |user			|password	|juror_number  |pool_number  |juror_number_1|
      |MODTESTBUREAU|Password1!	|041530012     |415300301|041530014|

  @JurorTransformationWIP @JM-5795
  Scenario Outline: Mark juror as deferred - Add to pool Happy path paper - Jury Officer
    Given I am on "Bureau" "test"

    Given the juror numbers have not been processed new schema
      |part_no   | pool_no   | owner |
      |<part_no> | <pool_no> | 400   |


    And "<part_no>" has "NEXT_DATE" as "5 mondays time" new schema

    Then a new pool is inserted for where record has transferred to the court new schema
      |part_no   | pool_no   | owner |
      |<part_no> | <pool_no> | 415   |


    And "<part_no>" has "NEXT_DATE" as "5 mondays time" new schema
    And pool "<pool_no>" has attendance date as "5 mondays time"

    #log on and search for juror
    And I log in as "<user>"
    When the user searches for juror record "<part_no>" from the global search bar

    #record paper summons type - deferral
    Then I record a happy path deferral paper summons response
    And I see the reply "type" on the response is "DEFERRAL"

    #process as deferral
    Then I click the process reply button
    Then I set the radio button to "Deferral request"
    And I click continue on the process reply page

    Then I set the "first" choice to "18" Mondays in the future
    Then I set the "second" choice to "19" Mondays in the future
    Then I set the "third" choice to "20" Mondays in the future
    And I click continue on the process reply page

    Then I select "O - OTHER" from the "Reason for the deferral request" dropdown
    Then I set the radio button to "Choose a different date"
    Then I set the "alternate" choice to "14" Mondays in the future
    And I press the "Continue" button

    #assign to pool
    Then I see "Select a pool for this date" on the page
    And I select one of the active pools available
    And I press the "Continue" button


    #check summons response
    When the user searches for juror record "<part_no>" from the global search bar
    And I click on the "Summons reply" link
    #will fail here as a result of  JM-5795
    And I see the processing outcome of the summons reply on juror record is "Deferral - granted (other)"
    And I click on the "View summons reply" link
    And I see the reply status has updated to "COMPLETED"
    And I see the reply type has been updated to "DEFERRAL"


    Examples:
      |user			|part_no  |pool_no  |
      |MODTESTCOURT |141500764|415240404|


  @JurorTransformationWIP @JM-5795
  Scenario Outline: Mark juror as deferred - Add to pool - Digital Response Bureau Officer
    Given I am on "Public" "test"

    Given the juror numbers have not been processed new schema
      | part_no   | pool_no   | owner |
      | <part_no> | <pool_no> | 400   |


    And "<part_no>" has "NEXT_DATE" as "5 mondays time" new schema
    And pool "<pool_no>" has attendance date as "5 mondays time"

    #record digital response
    And I record a digital response for a juror with a deferral
      | jurorNumber   | <part_no>        |
      | jurorLname    | LNAMESIXTWOFOUR  |
      | jurorPostcode | CH1 2AN          |

    #log on and create a pool to defer to
    Given I am on "Bureau" "test"
    Given I log in as "<user>"

    Given I navigate to the pool request screen
    Given I create an active "civil" court pool request for court "415", "14" Mondays in the future

    #search for juror and process reply
    When the user searches for juror record "<part_no>" from the global search bar
    And I click the summons reply tab
    And I click on the "View summons reply" link
    And I see the reply "type" on the response is "DEFERRAL"

    Then I click the process reply button
    Then I set the radio button to "Deferral request"
    And I click continue on the process reply page

    Then I select "O - OTHER" from the "Reason for the deferral request" dropdown
    Then I select to Choose a different date
    Then I set the "alternate" choice to "14" Mondays in the future
    And I press the "Continue" button

    Then I see "Select a pool for this date" on the page
    And I select the pool I created for the deferral
    And I press the "Continue" button

    And I do not see "Sorry, there is a technical problem" on the page
    And I see "Deferral granted (other)" on the page

    #search for juror and view reponse
    When the user searches for juror record "<part_no>" from the global search bar
    And I click on the "Summons reply" link
    And I click on the "View summons reply" link
    And I see the reply status has updated to "COMPLETED"


    Examples:
      |user			|part_no  |pool_no  |
      |MODTESTBUREAU|641500624|415170501|

  @JurorTransformationWIP @JM-4750 @JM-5795
  Scenario Outline: Mark juror as deferred - Add to pool - Digital Response Jury Officer
    Given I am on "Public" "test"

    Given the juror numbers have not been processed new schema
      | part_no   | pool_no   | owner |
      | <part_no> | <pool_no> | 400   |


    And "<part_no>" has "NEXT_DATE" as "5 mondays time" new schema
    And pool "<pool_no>" has attendance date as "5 mondays time"

    #record digital response
    And I record a digital response for a juror with a deferral
      | jurorNumber   | <part_no>        |
      | jurorLname    | LNAMEONEFIVENINE |
      | jurorPostcode | CH1 2AN          |

    #transfer pool to court
    Then a new pool is inserted for where record has transferred to the court new schema
      |part_no   | pool_no   | owner |
      |<part_no> | <pool_no> | 415   |

    Given I am on "Bureau" "test"
    And I log in as "<user>"

    #search for juror and view response
    When the user searches for juror record "<part_no>" from the global search bar
    And I click the summons reply tab

    #failing due to JM-4750
    And I click on the "View summons reply" link
    And I see the reply "type" on the response is "DEFERRAL"

    #process as deferral
    Then I click the process reply button
    Then I set the radio button to "Deferral request"
    And I click continue on the process reply page

    Then I select "O - OTHER" from the "Reason for the deferral request" dropdown
    Then I select to Choose a different date
    Then I set the "alternate" choice to "14" Mondays in the future
    And I press the "Continue" button

    #assign to pool
    Then I see "Select a pool for this date" on the page
    And I select one of the active pools available
    And I press the "Continue" button


    #check summons response
    When the user searches for juror record "<part_no>" from the global search bar
    And I click on the "Summons reply" link
    #will fail here as a result of  JM-5795
    And I see the processing outcome of the summons reply on juror record is "Deferral - granted (other)"
    And I click on the "View summons reply" link
    And I see the reply status has updated to "COMPLETED"
    And I see the reply type has been updated to "DEFERRAL"

    Examples:
      |user			|part_no  |pool_no  |
      |MODTESTCOURT |641500159|415240404|