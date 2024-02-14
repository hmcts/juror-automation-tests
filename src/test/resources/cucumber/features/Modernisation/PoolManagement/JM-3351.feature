Feature: JM-3351

  @JurorTransformationMulti
  Scenario: Test to filter pool requests
    Given I am on "Bureau" "postgres"

    And I log in as "MODTESTBUREAU"

    And I navigate to the pool request screen
    And I create a "Civil" court pool request for court "415"

    When I navigate to the pool request screen
    When the user filters by "Chester (415)"
    Then only records from "Chester" are displayed


  @JurorTransformationMulti
  Scenario: Test to filter pool requests with no pools available
    Given I am on "Bureau" "postgres"

    And I log in as "MODTESTBUREAU"

    When I navigate to the pool request screen
    When the user filters by "Reading"
    Then no records are displayed

  @JurorTransformationMulti
  Scenario: Test to filter active pools
    Given I am on "Bureau" "postgres"
    And I log in as "MODTESTBUREAU"
    When I navigate to the pool request screen
    And I click on active pools
    When the user filters by "Chester (415)"
    Then only active records from "Chester" are displayed


  @JurorTransformationMulti
  Scenario: Test to filter active pools with no pools available
    Given I am on "Bureau" "postgres"

    And I log in as "MODTESTBUREAU"

    When I navigate to the pool request screen
    And I click on active pools
    When the user filters by "Reading"
    Then no active records are displayed

