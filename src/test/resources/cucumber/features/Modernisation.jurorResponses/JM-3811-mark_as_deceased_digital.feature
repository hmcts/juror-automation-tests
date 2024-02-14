Feature: JM-3811 Mark as deceased digital

  @JurorTransformationWIP @JM-3814
  Scenario Outline: Test to grant deceased excusal on digital response
    # To be implemented as part of story 3814
    Given I am on "Public" "test"

    Given the juror numbers have not been processed new schema
      |part_no   | pool_no   | owner |
      |<part_no> | <pool_no> | 400   |


    And "<part_no>" has "NEXT_DATE" as "1 mondays time" new schema
    
    And I have submitted a third party English deceased response
      |part_no	|pool_number|last_name		|postcode	|email 	|
      |<part_no>|<pool_no>	|<last_name>	|<postcode>	|<email>|

    Given I am on "Bureau" "test"
    Given I log in as "<user>"
    
    And the user searches for juror record "<part_no>" from the global search bar
    When I click the summons reply tab
     #fails due to defect JM-4742
    When I click on the view summons reply link
    And I select Process reply
    And I select the Excusal radio button
    And I click continue on the process reply page
    And I select "D - DECEASED" from the dropdown
    And I select the Grant Excusal radio button
    And I click continue on the process reply page
    #fails due to defect JM-4722
    Then I see the excusal success message for "deceased"
    When I navigate to the summons reply
    And I see the reply status has updated to "COMPLETED"
    And I see the juror status has updated to "Deceased"

    Examples:
      |part_no		|pool_no	|last_name        |postcode |email      |user         |
      |641500647	|415170402	|LNAMESIXFOURSEVEN|CH1 2AN  |e@mail.com |MODTESTBUREAU|