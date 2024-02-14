Feature: JM-3179

  @JurorTransformationMulti
  Scenario Outline: Test connection to new db and schema design

    Given I am on "Bureau" "postgres"

#    Given the juror numbers have not been processed new schema
#      |part_no   | pool_no   | owner |
#      |641500859 | 415171103 | 400   |

#    And "641500859" has "RET_DATE" as "7 mondays time" new schema
#    And "641500859" has "NEXT_DATE" as "7 mondays time" new schema

#    And records for juror "141500001" are deleted new schema
#    Given the juror "141500001" is inserted into pool "415230001" with a deferral date "9" Mondays in the future for court "415" new schema

#    Given I have cleared down deferrals for "9" weeks in the future for court "415" new schema

#    And the new pool for court "415" is deleted new schema
#    And a new pool is inserted for court "415" new schema

#    Then a new pool is inserted for where record has transferred to the court new schema
#      |part_no   | pool_no   | owner |
#      |641500657 | 415170402 | 415   |

    And a digital summons reply has been entered for the summoned juror "941599999" new schema

#    And I log in as "MODTESTBUREAU"
##
#    When the user searches for juror record "641500859" from the global search bar
#    And I record a happy path paper summons response
#    When the user searches for juror record "641500859" from the global search bar
#    And I click on the "Summons reply" link
#    And I click on the "View summons reply" link
#    And I click the More Actions button
#    And I click Awaiting Information
#    Then I see "Who are you waiting for information from?" on the page
#    And I mark this reply as awaiting information from "<waitingOnReplyFrom>"
#    Then I press the "Confirm" button
#    And I do not see "Select whether you’re waiting for information from either the juror, court or translation unit" on the page
#    And I do not see "The summons reply has been updated by another user" on the page
#    And I see the reply status has updated to "<updatedReplyStatus>"

    Examples:
    | waitingOnReplyFrom | updatedReplyStatus   |
    | Juror              | AWAITING JUROR INFO  |
