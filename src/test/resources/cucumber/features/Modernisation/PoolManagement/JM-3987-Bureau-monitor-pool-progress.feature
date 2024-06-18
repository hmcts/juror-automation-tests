Feature: JM-3987 Monitor Pools Progress

  @JurorTransformation
  Scenario: Test to show nil pools on the summoning progress screen
    Given I am on "Bureau" "test"

    And I have cleared down deferrals for "4" weeks in the future for court "415"
    And I log in as "MODTESTCOURT"
    And I navigate to the pool request screen
    And I select to create a nil pool
    And I click the change link for the attendance date
    And I select a new date "4" week in the future

    And I change the pool type to "Civil"
    And I click the request pool button
    And I make a note of the pool number
    And I click the create nil pool confirmation button
    Given I am on "Bureau" "test"
    And I log in as "MODTESTBUREAU"
    And I navigate to the pool request screen
    And I navigate to the pool summoning progress screen
    And I enter "415" as the court
    And I select the "Civil" court type
    And I click search
    And I do not see "There are no matching results" on the page
    And I can see the newly created pool
    And I see "Nil pool" on the page
    And I clear down the data for all the pools I created for this test

  @JurorTransformation
  Scenario: Test to show the no pools requested message is displayed in weeks with no pools
    Given I am on "Bureau" "test"
    Given new pool requests are deleted
    Given the poolNumbers lists is empty
    Given I have cleared down the modernisation staff data
    Given I have created the modernisation staff data
    And I log in as "MODTESTBUREAU"
    And I navigate to the pool request screen
    And I create "1" new "High" pool requests each a week apart in court "415" with "10" jurors to summon
    And I navigate to the pool summoning progress screen
    And I see the summoning progress page banner
    And I enter "415" as the court
    And I select the "High" court type
    And I click search
    And I do not see "There are no matching results" on the page
    And I see all the pool numbers that were created are present on the screen
    And I see "No pools requested" on the page
    Then I clear down the data for all the pools I created for this test

  @JurorTransformation
  Scenario: Test for correct error message is returned when no pools are returned in the search
    Given I am on "Bureau" "test"
    Given new pool requests are deleted
    Given the poolNumbers lists is empty
    Given I have cleared down the modernisation staff data
    Given I have created the modernisation staff data
    And I log in as "MODTESTBUREAU"
    And I navigate to the pool request screen
    And I navigate to the pool summoning progress screen
    And I see the summoning progress page banner
    And I enter "123" as the court
    And I select the "Civil" court type
    And I click search
    And I do not see "Week 1" on the page
    And I see "There are no matching results" on the page
    And I see "selecting a court from the list" on the page
    And I see "checking the court type" on the page

  @JurorTransformation
  Scenario: Test for correct error message is returned when no search criteria are entered
    Given I am on "Bureau" "test"
    Given new pool requests are deleted
    Given the poolNumbers lists is empty
    Given I have cleared down the modernisation staff data
    Given I have created the modernisation staff data
    And I log in as "MODTESTBUREAU"
    And I navigate to the pool request screen
    And I navigate to the pool summoning progress screen
    And I see the summoning progress page banner
    And I click search
    And I do not see "Week 1" on the page
    And I see "There is a problem" on the page
    And I see "Pool type is missing" on the page
    And I see "Enter the name or location code for a court" on the page

  @JurorTransformation
  Scenario: Test for correct values on table
    Given I am on "Bureau" "test"
    Given new pool requests are deleted
    And I log in as "MODTESTBUREAU"
    And I navigate to the pool request screen
    And I create "1" new "Civil" pool requests each a week apart in court "415" with "160" jurors to summon
    And I navigate to the pool summoning progress screen
    And I see the summoning progress page banner
    And I enter "415" as the court
    And I select the "Civil" court type
    And I click search
    And I see the pool I created in a row on the search results with the values
      | requested   | 150  |
      | summoned    | 160  |
      | confirmed   | 0    |
      | balance     | -150 |
  And I clear down the data for all the pools I created for this test

  @JurorTransformation
  Scenario: Test to show all 8 weeks are populated when an active pool exist for that week
    Given I am on "Bureau" "test"
    Given new pool requests are deleted
    Given the poolNumbers lists is empty
    And I log in as "MODTESTBUREAU"
    And I navigate to the pool request screen
    And I create "8" new "Civil" pool requests each a week apart in court "415"
    And I navigate to the pool summoning progress screen
    And I see the summoning progress page banner
    And I enter "415" as the court
    And I select the "Civil" court type
    And I click search
    And I do not see "There are no matching results" on the page
    And I see all the pool numbers that were created are present on the screen
    Then I clear down the data for all the pools I created for this test

