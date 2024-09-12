Feature: JM-7847

  @JurorTransformationMulti @NewSchemaConverted
  Scenario Outline: As a Satellite court user when requesting a new pool the court should default to the current logged in court
    Given I am on "Bureau" "ithc"

    And I log in as "<user>"

    And I press the "Apps" button
    And I click on the "Pool management" link
    And I press the "Create pool" button
    And I set the radio button to "Request new pool from Bureau"
    And I press the "Continue" button
    And I see my court "Chester" under the sub heading "Court name or location code"

    And I press the "Apps" button
    And I click on the "Pool management" link
    And I press the "Create pool" button
    And I set the radio button to "Create pool for court use only"
    And I press the "Continue" button
    And I see "Chester" on the page

    And I press the "Apps" button
    And I click on the "Pool management" link
    And I press the "Create pool" button
    And I set the radio button to "Nil pool - no jurors to be added"
    And I press the "Continue" button
    And I see "Chester" on the page


    Given I am on "Bureau" "ithc"
    And I log in as "<user>" selecting court "462"

    And I press the "Apps" button
    And I click on the "Pool management" link
    And I press the "Create pool" button
    And I set the radio button to "Request new pool from Bureau"
    And I press the "Continue" button
    And I see my court "Warrington" under the sub heading "Court name or location code"

    And I press the "Apps" button
    And I click on the "Pool management" link
    And I press the "Create pool" button
    And I set the radio button to "Create pool for court use only"
    And I press the "Continue" button
    And I see "Warrington" on the page

    And I press the "Apps" button
    And I click on the "Pool management" link
    And I press the "Create pool" button
    And I set the radio button to "Nil pool - no jurors to be added"
    And I press the "Continue" button
    And I see "Warrington" on the page



    Given I am on "Bureau" "ithc"
    And I log in as "<user>" selecting court "767"

    And I press the "Apps" button
    And I click on the "Pool management" link
    And I press the "Create pool" button
    And I set the radio button to "Request new pool from Bureau"
    And I press the "Continue" button
    And I see my court "Knutsford" under the sub heading "Court name or location code"

    And I press the "Apps" button
    And I click on the "Pool management" link
    And I press the "Create pool" button
    And I set the radio button to "Create pool for court use only"
    And I press the "Continue" button
    And I see "Knutsford" on the page

    And I press the "Apps" button
    And I click on the "Pool management" link
    And I press the "Create pool" button
    And I set the radio button to "Nil pool - no jurors to be added"
    And I press the "Continue" button
    And I see "Knutsford" on the page


    Examples:
      |user			|
      |MODTESTCOURT |