Feature: JM-3725 JM-3726

  @JurorTransformationWIP @JurorDigitalNotConverted
  Scenario Outline: test to disqualify juror - too old - digital

    Given I am on "Public" "test"

    Given a bureau owned pool is created with jurors
      | court | juror_number  	    | pool_number	    | att_date_weeks_in_future	| owner |
      | 415   | <juror_number> 	    | <pool_number>     | 5				            | 400	|

    And I record a digital response for a juror that is too old
      |jurorNumber   | <juror_number> |
      |jurorLname    | <l_name>       |
      |jurorPostcode | <postcode>     |

    Given I am on "Bureau" "test"

    Given I log in as "MODTESTBUREAU"

    When the user searches for juror record "<juror_number>" from the global search bar
    Then I see the juror status on the juror record screen is "Disqualified"
    And I click the summons reply tab
    And I click on the "View summons reply" link
    And I see the reply "type" on the response is "Auto processed"
    And I see the juror status has updated to "Disqualified"
    And I see the reply "status" on the response is "COMPLETED"

    Examples:
      | juror_number  | l_name	                | postcode| pool_number	|
      | 041500150     | lname                   | CH2 2AA | 415300249 |

  @JurorTransformationWIP @JurorDigitalNotConverted
  Scenario Outline: test to disqualify juror - too young - digital

    Given I am on "Public" "test"

    Given a bureau owned pool is created with jurors
      | court | juror_number  	    | pool_number	    | att_date_weeks_in_future	| owner |
      | 415   | <juror_number> 	    | <pool_number>     | 5				            | 400	|

    And I record a digital response for a juror that is too young
      |jurorNumber   | <juror_number>   |
      |jurorLname    | <l_name>         |
      |jurorPostcode | <postcode>       |

    Given I am on "Bureau" "test"

    Given I log in as "MODTESTBUREAU"

    When the user searches for juror record "<juror_number>" from the global search bar
    Then I see the juror status on the juror record screen is "Disqualified"
    And I click the summons reply tab
    And I click on the "View summons reply" link
    And I see the reply "type" on the response is "Auto processed"
    And I see the juror status has updated to "Disqualified"
    And I see the reply "status" on the response is "COMPLETED"

    Examples:
      | juror_number  | l_name	                | postcode| pool_number	|
      | 041503277     | lname                   | CH2 2AA | 415300219 |

  @JurorTransformationWIP @JurorDigitalNotConverted
  Scenario Outline: test to disqualify juror - incorrect date provided - change date - digital

    Given I am on "Public" "test"

    Given a bureau owned pool is created with jurors
      | court | juror_number  	    | pool_number	    | att_date_weeks_in_future	| owner |
      | 415   | <juror_number> 	    | <pool_number>     | 5				            | 400	|

    And I record a digital response for a juror that provides an incorrect DoB and corrects it
      |jurorNumber   | <juror_number> |
      |jurorLname    | <l_name>       |
      |jurorPostcode | <postcode>     |

    Given I am on "Bureau" "test"

    Given I log in as "MODTESTBUREAU"

    When the user searches for juror record "<juror_number>" from the global search bar
    Then I see the juror status on the juror record screen is "Responded"
    And I click the summons reply tab
    And I click on the "View summons reply" link
    And I see the reply "type" on the response is "Auto processed"
    And I see the juror status has updated to "Responded"
    And I see the reply "status" on the response is "COMPLETED"

    Examples:
      | juror_number  | l_name	                | postcode| pool_number	|
      | 041503276     | lname                   | CH2 2AA | 415301229 |