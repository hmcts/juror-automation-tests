Feature: JM-3351

  @JurorTransformationMulti
  Scenario: Test to filter pool requests
    Given I am on "Bureau" "test"

    And I log in as "MODTESTBUREAU"

    And I navigate to the pool request screen
    And I create a "Civil" court pool request for court "415"

    When I navigate to the pool request screen

    Then I set input field with "ID" of "courtNameOrLocation" to "415"
    Then I click on the "Chester (415)" link
    Then I press the "Filter" button

    Then only records from "Chester" are displayed


  @JurorTransformationMulti
  Scenario: Test to filter pool requests with no pools available
    Given I am on "Bureau" "test"
    And I log in as "MODTESTBUREAU"
    When I navigate to the pool request screen

    Then I set input field with "ID" of "courtNameOrLocation" to "449"
    Then I click on the "Reading (449)" link
    Then I press the "Filter" button

    Then no records are displayed

  @JurorTransformationMulti
  Scenario: Test to filter active pools
    Given I am on "Bureau" "test"
    And I log in as "MODTESTBUREAU"
    When I navigate to the pool request screen
    And I click on active pools

    Then I set input field with "ID" of "courtNameOrLocation" to "415"
    Then I click on the "Chester (415)" link
    Then I press the "Filter" button

    Then only active records from "Chester" are displayed


  @JurorTransformationMulti
  Scenario: Test to filter active pools with no pools available
    Given I am on "Bureau" "test"
    And I log in as "MODTESTBUREAU"
    When I navigate to the pool request screen
    And I click on active pools

    Then I set input field with "ID" of "courtNameOrLocation" to "449"
    Then I click on the "Reading (449)" link
    Then I press the "Filter" button

    Then no active records are displayed

  @JurorTransformationMulti
  Scenario: Test for clear filter button
    Given I am on "Bureau" "test"

    And I log in as "MODTESTBUREAU"

    And I navigate to the pool request screen

    Then I set input field with "ID" of "courtNameOrLocation" to "449"
    Then I click on the "Reading (449)" link
    Then I press the "Filter" button
    Then no records are displayed

    Then I click on the "Clear filter" link
    Then records are displayed

