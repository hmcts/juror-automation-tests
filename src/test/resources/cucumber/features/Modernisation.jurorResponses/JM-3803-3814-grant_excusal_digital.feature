Feature: Grant excusal digital

  @JurorTransformationWIP @NewSchemaConverted @JurorDigitalNotConverted
  Scenario Outline: Test to grant excusal on digital response

    Given I am on "Public" "test"

    Given the juror numbers have not been processed new schema
      | part_no   | pool_no 	| owner |
      | <part_no> |<pool_no>	| 400 	|




    And I have submitted a first party English excusal response
      |part_no	|pool_number|last_name		|postcode	| email |
      |<part_no>|<pool_no>	|<last_name>	|<postcode>	|<email>|

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

    Given a bureau owned pool is created with jurors
      | court | juror_number  	    | pool_number	    | att_date_weeks_in_future	| owner |
      | 415   | <juror_number> 	    | <pool_number>     | 5				            | 400	|

    And I have submitted a first party English excusal response
      |part_no	      |pool_number    |last_name	|postcode	| email |
      |<juror_number> |<pool_number>  |<last_name>	|<postcode>	|<email>|

    Given I am on "Bureau" "test"

    And I log in as "<user>"
    When I click on the "Search" link
    And I set "Juror number" to "<juror_number>"
    And I press the "Search" button
    And I click on "<juror_number>" in the same row as "<juror_number>"
    And I select Process reply
    And I select the Excusal radio button
    And I click continue on the process reply page
    And I select "<dropDown>" from the dropdown
    And I select the Grant Excusal radio button
    And I click continue on the process reply page
    Then I see the excusal success message for "<excusalReason>"

    Examples:
      | dropDown       | excusalReason | user          | juror_number   | pool_number   | last_name           | postcode | email      |
      | C - CHILD CARE | child care    | MODTESTBUREAU | 041500155      | 415300254     | LNAMESIXZEROFOUR    | CH1 2AN  | e@mail.com |
      | D - DECEASED   | deceased      | MODTESTBUREAU | 041500155      | 415300254     | LNAMESIXZEROSIX     | CH1 2AN  | e@mail.com |
    
