Feature: JM-3725

  @JurorTransformationMulti @NewSchemaConverted
  Scenario Outline: Automatically disqualify a juror if they are over 75

   Given I am on "Bureau" "test"

    And I log in as "<user>"

    And I press the "Apps" button
    And I click on the "Pool management" link
    And I create a "Crown" court pool request for court "415" and summon jurors
    Then I select the pool that I have just created to move to the pool summary page
    And I select one of the jurors I have just summoned
    And I see "Juror status" on the page

    #record paper summons response
    And I click the Enter summons reply button
    And I enter a date of birth in the summons reply that will make the juror too old
    And I press the "Continue" button
    And I see "Check the date of birth" on the page
    And I see "Is their date of birth correct?" on the page
    And I press the "Yes - disqualify juror" button
    And I see the juror record updated banner containing "Disqualified (age)"

       Examples:
      | user          |
      | MODTESTBUREAU |


  @JurorTransformationMulti @NewSchemaConverted
  Scenario Outline: Automatically disqualify a juror if they are under 18

    Given I am on "Bureau" "test"

    And I log in as "<user>"

    And I press the "Apps" button
    And I click on the "Pool management" link
    And I create a "Crown" court pool request for court "415" and summon jurors
    Then I select the pool that I have just created to move to the pool summary page
    And I select one of the jurors I have just summoned
    And I see "Juror status" on the page

    #record paper summons response
    And I click the Enter summons reply button
    And I enter a date of birth in the summons reply that will make the juror too young
    And I press the "Continue" button
    And I see "Check the date of birth" on the page
    And I see "Is their date of birth correct?" on the page
    And I press the "Yes - disqualify juror" button
    And I see the juror record updated banner containing "Disqualified (age)"

    Examples:
      | user          |
      | MODTESTBUREAU |