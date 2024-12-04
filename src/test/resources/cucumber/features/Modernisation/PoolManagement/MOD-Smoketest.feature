Feature: MOD-Smoketest

  @Shakedown
  Scenario Outline: Smoketest
    Given I am on "bureau" "ithc"

    Given I delete pools created in the last 3 days new schema for court "415"
    Given I delete pools created in the last 3 days new schema for court "767"
    Given I delete pools created in the last 3 days new schema for court "471"
    Given I delete pools created in the last 3 days new schema for court "457"
    Given I delete pools created in the last 3 days new schema for court "452"
    Given I delete appearances data
    Given I delete trials data
    Given I refresh the voters table for court "452" new schema
    Given I refresh the voters table for court "457" new schema
    Given I refresh the voters table for court "471" new schema
    Given I refresh the voters table for court "415" new schema
    Given I refresh the voters table for court "767" new schema
    And voters for court "471" have been updated to postcode "CH2 2AN" new schema
    And voters for court "415" have been updated to postcode "CH2 2AN" new schema
    And voters for court "767" have been updated to postcode "CH2 2AN" new schema
    And voters for court "457" have been updated to postcode "SA1 4PF" new schema
    And voters for court "452" have been updated to postcode "SA1 4PF" new schema

    And I log in as "<user>"

    # Can see the pool request courts table tabs and fields

    When I navigate to the pool request screen

    And I see "Active pools" on the page
    Then I see link with text "Pool requests"
    And I see link with text "Active pools"
    And I see link with text "Deferral maintenance"
    And I see link with text "Search"

    Then I set input field with "ID" of "courtNameOrLocation" to "457"
    And I press the "Filter" button
    And I see "Swansea Crown Court" on the page

    Examples:
      | user	        |
      | MODTESTBUREAU	|
