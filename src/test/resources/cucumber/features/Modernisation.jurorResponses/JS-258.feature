Feature: JS-258

  @JurorTransformation
  Scenario Outline: JS-258 Auto Processed Responses are not marked 3rd party

    Given I am on "Public" "ithc"

    Given a bureau owned pool is created with jurors
      | court |juror_number   | pool_number	 | att_date_weeks_in_future| owner |
      | 452	  |<juror_number1>| <pool_number>| 5				       | 400   |
      | 452	  |<juror_number2>| <pool_number>| 5				       | 400   |

    #set up some responses
    And juror "<juror_number1>" has "LAST_NAME" as "<last_name>" new schema
    And juror "<juror_number1>" has "POSTCODE" as "<postcode>" new schema

    And juror "<juror_number2>" has "LAST_NAME" as "<last_name>" new schema
    And juror "<juror_number2>" has "POSTCODE" as "<postcode>" new schema

    And I have submitted a first party English straight through response
      | part_no			    | pool_number  | last_name	    | postcode	    | email   |
      | <juror_number1>		| <pool_number>| <last_name>	| <postcode>	| <email> |

    Given I am on "Bureau" "ithc"
    And I log in as "<user>"

    When the user searches for juror record "<juror_number2>" from the global search bar
    And I record a happy path paper summons response and process now

    When the user searches for juror record "<juror_number1>" from the global search bar
    And I click on the "Juror details" link
    And I do not see "Third party details" on the page

    When the user searches for juror record "<juror_number2>" from the global search bar
    And I click on the "Juror details" link
    And I do not see "Third party details" on the page

    Examples:
      | juror_number1 | juror_number2 | pool_number | last_name | postcode 	| email				| user          |
      | 452300249	  | 452300250	  | 045200271 	| LNAME		| NN1 3HQ	| email@outlook.com	| MODTESTBUREAU |