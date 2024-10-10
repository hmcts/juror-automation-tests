Feature: Grant excusal digital

  @JurorTransformationMulti
  Scenario Outline: Test to grant excusal on digital response

    Given I am on "Public" "ithc"

    Given a bureau owned pool is created with jurors
      | court | juror_number  	    | pool_number	    | att_date_weeks_in_future	| owner |
      | 415   | <juror_number> 	    | <pool_number>     | 5				            | 400	|

    And I have submitted a first party English excusal response
      |part_no     	|pool_number    |last_name		|postcode	| email |
      |<juror_number>|<pool_number>	|<last_name>	|<postcode>	|<email>|

    Given I am on "Bureau" "ithc"

    And I log in as "<user>"

    When the user searches for juror record "<juror_number>" from the global search bar
    Then I click the summons reply tab
    And I click on the view summons reply link
    Then the view summons reply page is displayed
    And I select Process reply
    And I select the Excusal radio button
    And I click continue on the process reply page
    And I select "<dropDown>" from the dropdown
    And I select the Grant Excusal radio button
    And I click continue on the process reply page
    When the user searches for juror record "<juror_number>" from the global search bar
    And I see the juror status has updated to "<excusalReason>"

    Examples:
      | dropDown       | excusalReason  | user          | juror_number   | pool_number   | last_name | postcode | email      |
      | C - CHILD CARE | Excused        | MODTESTBUREAU | 041517922      | 415170653     | lname     | CH2 2AA  | e@mail.com |
      | D - DECEASED   | Deceased       | MODTESTBUREAU | 041517923      | 415170654     | lname     | CH2 2AA  | e@mail.com |


  @JurorTransformation
  Scenario Outline: Test to grant excusal on digital response from juror record - bureau

    Given I am on "Public" "ithc"

    Given a bureau owned pool is created with jurors
      | court | juror_number  	    | pool_number	    | att_date_weeks_in_future	| owner |
      | 415   | <juror_number> 	    | <pool_number>     | 5				            | 400	|

    And juror "<juror_number>" has "LAST_NAME" as "<last_name>" new schema
    And juror "<juror_number>" has "POSTCODE" as "<postcode>" new schema

    And I have submitted a first party English excusal response
      |part_no	      |pool_number    |last_name	|postcode	| email |
      |<juror_number> |<pool_number>  |<last_name>	|<postcode>	|<email>|

    Given I am on "Bureau" "ithc"

    And I log in as "<user>"
    And the user searches for juror record "<juror_number>" from the global search bar
    And I click the update juror record button
    And I select the Excusal radio button
    And I click continue on the process reply page
    And I select "<dropDown>" from the dropdown
    And I select the Grant Excusal radio button
    And I click continue on the process reply page
    Then I see "<bannerText>" on the page

    Examples:
      | dropDown       | user          | juror_number   | pool_number   | last_name           | postcode | email      | bannerText                                        |
      | C - CHILD CARE | MODTESTBUREAU | 041500155      | 415300254     | LNAMESIXZEROFOUR    | CH1 2AN  | e@mail.com | Juror record updated: Excusal granted (child care)|
      | D - DECEASED   | MODTESTBUREAU | 041500155      | 415300254     | LNAMESIXZEROSIX     | CH1 2AN  | e@mail.com | Juror record updated: Excusal granted (deceased)  |

  @JurorTransformation
  Scenario Outline: Test to grant excusal on digital response from juror record - court

    Given I am on "Bureau" "ithc"

    Then a new pool is inserted for where record has transferred to the court new schema
      |part_no         | pool_no       | owner |
      |<juror_number>  | <pool_number> | 415   |

    And I log in as "<user>"
    And the user searches for juror record "<juror_number>" from the global search bar
    And I click the update juror record button
    And I select the Excusal radio button
    And I click continue on the process reply page
    And I select "<dropDown>" from the dropdown
    And I select the Grant Excusal radio button
    And I click continue on the process reply page
    And I choose the "No" radio button
    And I press the "Continue" button
    Then I see "<bannerText>" on the page

    Examples:
      | dropDown       | user         | juror_number   | pool_number   | bannerText                                     |
      | D - DECEASED   | MODTESTCOURT | 041500155      | 415300254     |Juror record updated: Excusal granted (deceased)|