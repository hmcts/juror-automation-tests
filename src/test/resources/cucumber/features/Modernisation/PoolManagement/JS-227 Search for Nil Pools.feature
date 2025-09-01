Feature: JS-227 Search for Nil Pools

  @JurorTransformation
  Scenario: Search for Nil Pools

    Given I am on "Bureau" "ithc"

    And I log in as "MODTESTCOURT"
    And I navigate to the pool request screen
    And I select to create a nil pool
    And I click the change link for the attendance date
    And I select a new date "4" week in the future

    And I change the pool type to "Crown"
    And I click the request pool button
    And I make a note of the pool number
    And I click the create nil pool confirmation button

    Given I am on "Bureau" "ithc"
    And I log in as "MODTESTBUREAU"
    And I navigate to the pool request screen
    And I navigate to the pool summoning progress screen
    And I enter "415" as the court
    And the radio button "Crown court" is "selected"
    And I click search
    And I do not see "There are no matching results" on the page
    And I can see the newly created pool
    And I see "Nil pool" on the page

    And I click on the "Search" link
    And I enter "415" as the court
    And I click on the "Advanced search" link
    And I check the "Nil pool" checkbox
    And I press the "Continue" button
    And I do not see "There are no matching results" on the page
    And I can see the newly created pool

    And I select the pool that I have just created to move to the pool summary page
    And I can see the newly created pool

    And I clear down the data for all the pools I created for this test new schema