Feature: As a jury/bureau officer I want to see a list of juror status codes

  @JurorTransformationMulti @NewSchemaConverted
  Scenario Outline: Test a bureau officer can see list of juror status codes

    Given I am on "Bureau" "test"
    When I log in as "<user>"
    And I click on the "Apps" link
    And I click on the "Bureau administration" link
    And I click on the "System codes" link
    Then I verify the system codes inside administration page
    When I click on the "Juror status codes" link
    Then I verify the list of juror codes

    Examples:
      | user           |
      | MODTESTBUREAU  |


  @JurorTransformationMulti @NewSchemaConverted
  Scenario Outline: Test a Jury manager can see list of juror status codes

    Given I am on "Bureau" "test"
    When I log in as "<user>"
    And I click on the "Apps" link
    And I click on the "Court administration" link
    And I click on the "System codes" link
    Then I verify the system codes inside administration page
    When I click on the "Juror status codes" link
    Then I verify the list of juror codes

    Examples:
      | user      |
      | CMANAGER  |