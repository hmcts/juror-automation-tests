Feature: JM-2034 delete pool requests

  @JurorTransformationMulti
  Scenario Outline: Test to delete a pool request as a bureau user
    Given I am on "Bureau" "ithc"

    And I log in as "<user>"
    When I navigate to the pool request screen

    #create pool request
    Then I create a "<poolType>" court pool request for court "<court>"

    #delete pool request
    And I navigate to the pool search screen
    When I enter the pool number of the pool I have just created on the pool search screen
    And I press the "Continue" button

    And I click the delete pool request button
    Then I am asked if I'm sure I want to delete
    When I click the confirm deletion button
    Then a message is displayed on the pool requests page informing me that the pool has been deleted
    And the pool is no longer visible

    Examples:
      | user			| poolType | court |
      | MODTESTBUREAU   | Crown    | 415   |
      | MODTESTBUREAU   | High     | 415   |
      | MODTESTBUREAU   | Civil    | 415   |

  @JurorTransformationMulti
  Scenario Outline: Test that I am unable to delete a pool request with Jurors allocated to it

    Given I am on "Bureau" "ithc"

    And I log in as "<user>"
    When I navigate to the pool request screen

    #create pool request
    Then I create a "<poolType>" court pool request for court "<court>" with "0" deferral
    
    #add jurors
    And I navigate to the pool search screen
    When I enter the pool number of the pool I have just created on the pool search screen
    And I press the "Continue" button

    Then I press the "Summon jurors" button
    And I set "Citizens to summon" to "5"
    And I press the "Create pool and summon citizens" button

    #retrive pool from Active Pools
    And I navigate to the pool search screen
    And I enter the pool number of the pool I have just created on the pool search screen
    And I press the "Continue" button

    #try to delete
    And I click the delete pool request button
    Then I am asked if I'm sure I want to delete this pool
    When I click the confirm deletion button
    Then I see "Unable to delete pool" in the pool banner
    
    #tear down pool
    Then I clear down the data for the pool

    Examples:
      | user		  | poolType | court |
      | MODTESTBUREAU | Crown    | 415   |
      | MODTESTBUREAU | High     | 415   |
      | MODTESTBUREAU | Civil    | 415   |