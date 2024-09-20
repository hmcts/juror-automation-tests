Feature: JM-7402

  @JurorTransformationMulti @NewSchemaConverted
  Scenario Outline: When clicking change court I want to ensure only linked/satellite courts are displayed and not all courts
    Given I am on "Bureau" "ithc"

    And I log in as "<user>"

    And I click the Change link to change the court
    And I see "Which court do you want to manage?" on the page
    And I see "CHESTER (415)" on the page
    And I see "KNUTSFORD (767)" on the page
    And I see "WARRINGTON (462)" on the page

    Given I am on "Bureau" "ithc"
    And I log in as "<user>" selecting court "462"


    And I click the Change link to change the court
    And I see "Which court do you want to manage?" on the page
    And I see "CHESTER (415)" on the page
    And I see "KNUTSFORD (767)" on the page
    And I see "WARRINGTON (462)" on the page

    Given I am on "Bureau" "ithc"
    And I log in as "<user>" selecting court "767"

    And I click the Change link to change the court
    And I see "Which court do you want to manage?" on the page
    And I see "CHESTER (415)" on the page
    And I see "KNUTSFORD (767)" on the page
    And I see "WARRINGTON (462)" on the page


    Examples:
      |user			|
      |MODTESTCOURT |
