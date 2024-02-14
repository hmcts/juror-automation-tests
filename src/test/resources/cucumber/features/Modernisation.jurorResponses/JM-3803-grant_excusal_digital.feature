Feature: Grant excusal digital

  @JurorTransformationWIP @NewSchemaConverted @JurorDigitalNotConverted
  Scenario Outline: Test to grant excusal on digital response

    Given I am on "Public" "test"

    Given the juror numbers have not been processed new schema
      | part_no   | pool_no 	| owner |
      | <part_no> |<pool_no>	| 400 	|


    And "<part_no>" has "NEXT_DATE" as "5 mondays time" new schema

    And I have submitted a first party English excusal response
      |part_no	|pool_number|last_name		|postcode	| email |
      |<part_no>|<pool_no>	|<last_name>	|<postcode>	|<email>|

    Given I am on "Bureau" "test"

    And I log in as "<user>"

    When I search for juror "<part_no>"
    Then I click the summons reply tab
    And I click on the view summons reply link
    Then the view summons reply page is displayed
    And I select Process reply
    And I select the Excusal radio button
    And I click continue on the process reply page
    And I select "<dropDown>" from the dropdown
    And I select the Grant Excusal radio button
    And I click continue on the process reply page
    Then I see the excusal success message for "<excusalReason>"

    Examples:
      | dropDown       | excusalReason | user          | part_no   | pool_no   | last_name           | postcode | email      |
      | C - CHILD CARE | child care    | MODTESTBUREAU | 641500588 | 415170402 | LNAMEFIVEEIGHTEIGHT | CH1 2AN  | e@mail.com |
      | D - DECEASED   | deceased      | MODTESTBUREAU | 641500602 | 415170402 | LNAMESIXZEROTWO     | CH1 2AN  | e@mail.com |


  @JurorTransformationWIP @NewSchemaConverted @JurorDigitalNotConverted
  Scenario Outline: Test to grant excusal on digital response from search

    Given I am on "Public" "test"

    Given the juror numbers have not been processed new schema
      | part_no   | pool_no 	| owner |
      | <part_no> |<pool_no>	| 400 	|


    And "<part_no>" has "NEXT_DATE" as "5 mondays time" new schema

    And I have submitted a first party English excusal response
      |part_no	|pool_number|last_name		|postcode	| email |
      |<part_no>|<pool_no>	|<last_name>	|<postcode>	|<email>|

    Given I am on "Bureau" "test"

    And I log in as "<user>"
    When I click on the "Search" link
    And I set "Juror number" to "<part_no>"
    And I press the "Search" button
    And I click on "<part_no>" in the same row as "<part_no>"
    And I select Process reply
    And I select the Excusal radio button
    And I click continue on the process reply page
    And I select "<dropDown>" from the dropdown
    And I select the Grant Excusal radio button
    And I click continue on the process reply page
    Then I see the excusal success message for "<excusalReason>"

    Examples:
      | dropDown       | excusalReason | user          | part_no   | pool_no   | last_name           | postcode | email      |
      | C - CHILD CARE | child care    | MODTESTBUREAU | 641500604 | 415170402 | LNAMESIXZEROFOUR    | CH1 2AN  | e@mail.com |
      | D - DECEASED   | deceased      | MODTESTBUREAU | 641500606 | 415170402 | LNAMESIXZEROSIX     | CH1 2AN  | e@mail.com |
    
