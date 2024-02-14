Feature: JM-4358

  @JurorTransformation @NewSchemaConverted
  Scenario Outline: Reassign a juror Bureau User - warning cannot be reassigned when status not 1 or 2

    Given I am on "Bureau" "test"
    And the new pool for court "415" with multiple statuses is deleted new schema
    And the voter record for "641591101" is deleted new schema
    And the voter record for "641591102" is deleted new schema
    And the voter record for "641591103" is deleted new schema
    And the voter record for "641591104" is deleted new schema
    And the voter record for "641591105" is deleted new schema
    And the voter record for "641591106" is deleted new schema
    And the voter record for "641591107" is deleted new schema
    And the voter record for "641591108" is deleted new schema
    And the voter record for "641591109" is deleted new schema
    And a new active pool is inserted for court "415" with multi statuses new schema
    And jurors are inserted into active pool "415" with multi statuses new schema
    And I log in as "<user>"
    When I navigate to the pool request screen
    And I click on active pools
    And I click on the "Search" link
    And I set "Pool number" to "<pool_no>"
    And I press the "Continue" button

    #Reassign Execused juror
    And I check the juror "641591105" checkbox
    Then I press the "Reassign" button
    And I select one of the active pools available
    And I press the "Continue" button
    And I verify reassign error message with the text "You can only move jurors with a responded or summoned status. The following jurors have a different status and cannot be moved."

    #Reassign Disqualified juror
    When I navigate to the pool request screen
    And I click on active pools
    And I click on the "Search" link
    And I set "Pool number" to "<pool_no>"
    And I press the "Continue" button
    And I check the juror "641591106" checkbox
    And I press the "Reassign" button
    And I select one of the active pools available
    And I press the "Continue" button
    Then I verify reassign error message with the text "You can only move jurors with a responded or summoned status. The following jurors have a different status and cannot be moved."

    #Reassign Deferred juror
    When I navigate to the pool request screen
    And I click on active pools
    And I click on the "Search" link
    And I set "Pool number" to "<pool_no>"
    And I press the "Continue" button
    And I check the juror "641591107" checkbox
    And I press the "Reassign" button
    And I select one of the active pools available
    And I press the "Continue" button
    Then I verify reassign error message with the text "You can only move jurors with a responded or summoned status. The following jurors have a different status and cannot be moved."

    #Reassign Reassigned juror
    When I navigate to the pool request screen
    And I click on active pools
    And I click on the "Search" link
    And I set "Pool number" to "<pool_no>"
    And I press the "Continue" button
    And I check the juror "641591108" checkbox
    And I press the "Reassign" button
    And I select one of the active pools available
    And I press the "Continue" button
    Then I verify reassign error message with the text "You can only move jurors with a responded or summoned status. The following jurors have a different status and cannot be moved."

    #Reassign Undeliverable juror
    When I navigate to the pool request screen
    And I click on active pools
    And I click on the "Search" link
    And I set "Pool number" to "<pool_no>"
    And I press the "Continue" button
    And I check the juror "641591109" checkbox
    And I press the "Reassign" button
    And I select one of the active pools available
    And I press the "Continue" button
    Then I verify reassign error message with the text "You can only move jurors with a responded or summoned status. The following jurors have a different status and cannot be moved."

    #Reassign Completed juror
    When I navigate to the pool request screen
    And I click on active pools
    And I click on the "Search" link
    And I set "Pool number" to "<pool_no>"
    And I press the "Continue" button
    And I check the juror "641591113" checkbox
    And I press the "Reassign" button
    And I select one of the active pools available
    And I press the "Continue" button
    Then I verify reassign error message with the text "You can only move jurors with a responded or summoned status. The following jurors have a different status and cannot be moved."

    #Reassign  Summoned juror
    #Failure the below step due to bug ticket-JM-5573
    When I navigate to the pool request screen
    And I click on active pools
    And I click on the "Search" link
    And I set "Pool number" to "<pool_no>"
    And I press the "Continue" button
    And I check the juror "641591101" checkbox
    And I press the "Reassign" button
    And I select one of the active pools available
    And I press the "Continue" button
    Then I see "1 jurors reassigned to pool" on the page

    #Reassign Responded juror
    When I navigate to the pool request screen
    And I click on active pools
    And I click on the "Search" link
    And I set "Pool number" to "<pool_no>"
    And I press the "Continue" button
    And I check the juror "641591102" checkbox
    And I press the "Reassign" button
    And I select one of the active pools available
    And I press the "Continue" button
    Then I see "1 jurors reassigned to pool" on the page

    Examples:
      |pool_no    | user          |
      |415911911  | MODTESTBUREAU |


  @JurorTransformationMulti @NewSchemaConverted
  Scenario Outline: Reassign a juror Bureau User - warning cannot be reassigned when juror will be over 75
    Given I am on "Bureau" "test"

    #And new pool requests are deleted new schema
    And the new pool for court "415" is deleted new schema
    And the voter record for "941599999" is deleted new schema
    And the voter record for "941599998" is deleted new schema
    And a new active pool is inserted for court "415" new schema
    And jurors are inserted into active pool "415" new schema
    And I log in as "<user>"

    #Can see the pool request courts table tabs and fields
    When I navigate to the pool request screen
    When I press the "Create pool" button
    And I set the radio button to "Request new pool"
    And I press the "Continue" button
    Then I see "Select a court for this pool" on the page

    #select court
    And I set input field with "ID" of "courtNameOrLocation" to "CHESTER"
    And I click on the "Chester (415)" link
    And I press the "Continue" button

    #complete new pool fields
    And I set the radio button to "Civil"
    And I set "Number of jurors required in total" to "150"
    And I press the "Continue" button

    #check pool number
    And I see the pool number of the pool

    #Request Pool
    And I submit the pool request

    #Search for Pool
    And I navigate to the pool search screen
    When I enter the pool number of the pool I have just created on the pool search screen
    And I press the "Continue" button
    Then I press the "Summon jurors" button
    And I set "Citizens to summon" to "5"
    And I press the "Create pool and summon citizens" button
    When I navigate to the pool request screen
    And I click on active pools
    And I click on the "Search" link
    And I set "Pool number" to "<pool_number>"
    And I press the "Continue" button
    And I check the juror "941599999" checkbox
    And I click on "941599999" in the same row as "941599999"
    And I click on the "Juror details" link
    And I click on the "Add or change" link
    And I change a date of birth of a juror that will make more than 75 years
    Then I press the "Save" button
    And I press the "Yes - disqualify juror" button
    And I navigate to the pool request screen
    And I click on active pools
    And I click on the "Search" link
    And I set "Pool number" to "<pool_number>"
    And I press the "Continue" button
    And I check the juror "941599999" checkbox
    When I press the "Reassign" button

    #Change court
    And I select the newly created pool from the reassign page
    And I press the "Continue" button
    Then I verify reassign error message with the text "You can only move jurors with a responded or summoned status. The following jurors have a different status and cannot be moved."

    Examples:
      |pool_number   | user          |
      |415222222     | MODTESTBUREAU |