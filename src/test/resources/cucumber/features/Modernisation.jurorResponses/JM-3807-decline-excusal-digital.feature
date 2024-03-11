Feature: Decline excusal digital

  @JurorTransformationWIP @NewSchemaConverted @JurorDigitalNotConverted
  Scenario Outline: Test to decline excusal on digital response
    
    Given I am on "Public" "test"

    Given the juror numbers have not been processed new schema
      | part_no   | pool_no 	| owner |
      | <part_no> |<pool_no>	| 400 	|



    
    And I have submitted a first party English excusal response
    |part_no	|pool_number|last_name		|postcode	| email |
	|<part_no>	|<pool_no>	|<last_name>	|<postcode>	|<email>|

    Given I am on "Bureau" "test"

    And I log in as "<user>"

    When I search for juror "<juror_number>"
    Then I click the summons reply tab
    And I click on the view summons reply link
    Then the view summons reply page is displayed
    And I select Process reply
    And I select the Excusal radio button
    And I click continue on the process reply page
    And I select "<dropDown>" from the dropdown
    And I select the Refuse Excusal radio button
    And I click continue on the process reply page
    Then I see the refuse excusal success message for "<excusalReason>"

    Examples:
      | dropDown       | excusalReason | user          | part_no   | pool_no   | last_name           | postcode | email      |
      | C - CHILD CARE | child care    | MODTESTBUREAU | 641500576 | 415170402 | LNAMEFIVESEVENSIX   | CH1 2AN  | e@mail.com |
      | D - DECEASED   | deceased      | MODTESTBUREAU | 641500577 | 415170402 | LNAMEFIVESEVENSEVEN | CH1 2AN  | e@mail.com |
