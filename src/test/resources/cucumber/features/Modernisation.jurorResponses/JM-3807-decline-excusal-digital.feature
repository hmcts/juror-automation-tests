Feature: Decline excusal digital

  @JurorTransformation
  Scenario Outline: Test to decline excusal on digital response
    
    Given I am on "Public" "ithc"

    Given a bureau owned pool is created with jurors
      | court | juror_number  	    | pool_number	    | att_date_weeks_in_future	| owner |
      | 415   | <juror_number> 	    | <pool_number>     | 5				            | 400	|

    And I have submitted a first party English excusal response
    | part_no	        | pool_number   | last_name		| postcode	  | email |
	| <juror_number>	| <pool_number>	| <last_name>	| <postcode>  |<email>|

    Given I am on "Bureau" "ithc"

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
    And I see "Summoned" on the page

    Examples:
      | dropDown       | user          | juror_number   | pool_number   | last_name   | postcode | email      |
      | C - CHILD CARE | MODTESTBUREAU | 041518981      | 415131102     | lname       | CH2 2AA  | e@mail.com |
      | D - DECEASED   | MODTESTBUREAU | 041518982      | 415131103     | lname       | CH2 2AA  | e@mail.com |