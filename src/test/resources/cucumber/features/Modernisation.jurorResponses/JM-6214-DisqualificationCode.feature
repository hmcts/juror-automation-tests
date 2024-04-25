Feature: As a jury/bureau officer I want to see a list of disqualification code

  @JurorTransformationMulti @NewSchemaConverted
  Scenario Outline: Test a bureau officer can see list of disqualification codes

    Given I am on "Bureau" "test"
    When I log in as "<user>"
    And I click on the "Apps" link
    And I click on the "Bureau administration" link
    And I click on the "System codes" link
    Then I verify the system codes inside administration page
    When I click on the "Disqualified codes" link
    Then I verify the below list of Disqualification codes

  |A|	Less than eighteen years of age or over 75|
  |B|	On bail|
  |C|	Has been convicted of an offence|
  |D|	Judicial disqualification|
  |E|	Electronic police check failure|
  |M|	Suffering from a mental disorder|
  |R|	Not resident for the appropriate period|

    Examples:
      | user           |
      | MODTESTBUREAU  |


  @JurorTransformationMulti @NewSchemaConverted
  Scenario Outline: Test a Jury manager can see list of disqualification codes

    Given I am on "Bureau" "test"
    When I log in as "<user>"
    And I click on the "Apps" link
    And I click on the "Court administration" link
    And I click on the "System codes" link
    Then I verify the system codes inside administration page
    When I click on the "Disqualified codes" link
    Then I verify the below list of Disqualification codes

      |A|	Less than eighteen years of age or over 75|
      |B|	On bail|
      |C|	Has been convicted of an offence|
      |D|	Judicial disqualification|
      |E|	Electronic police check failure|
      |M|	Suffering from a mental disorder|
      |R|	Not resident for the appropriate period|

    Examples:
      | user      |
      | CMANAGER  |