Feature: JM-4368 Jury Officer Can Manually Run a Police Check

  @JurorTransformationMulti
  Scenario Outline: Manually run police check - presence of link - not checked

    Given I am on "Bureau" "ithc"

    Given I log in as "MODTESTCOURT"

    Given a bureau owned pool is created with jurors
      | court | juror_number  	    | pool_number	    | att_date_weeks_in_future	| owner |
      | 415   | <juror_number> 	    | <pool_number>     | 5				            | 400	|

    Then a new pool is inserted for where record has transferred to the court new schema
      |part_no   	  | pool_no   	  | owner |
      |<juror_number> | <pool_number> | 415   |

    And I update juror "<juror_number>" to have a status of "Responded"
    And I search for juror "<juror_number>"
    And I see the police check value is "Not Checked"
    And I see the link to run a police check
    When I click the link to run a police check
    And I see "Run a police check on this juror" on the page
    And I see the button to run a police check

    Examples:
      | juror_number| pool_number |
      | 041500126	| 415300226	  |

  @JurorTransformationMulti
  Scenario Outline: Manually run police check - presence of link - there was a problem

    Given I am on "Bureau" "test"

    Given I log in as "MODTESTBUREAU"

    Given a bureau owned pool is created with jurors
      | court | juror_number  	    | pool_number	    | att_date_weeks_in_future	| owner |
      | 415   | <juror_number> 	    | <pool_number>     | 5				            | 400	|

    Then a new pool is inserted for where record has transferred to the court new schema
      |part_no   	  | pool_no   	  | owner |
      |<juror_number> | <pool_number> | 415   |

    Given I set Police Check to "P" and Phoenix Checked to "U" for "<juror_number>"
    Given I set Police Check to "<police_check_value>" for "<juror_number>" new schema
    And I search for juror "<juror_number>"
    And I see the police check value is "<police_check_status>"
    And I do not see the link to run a police check

    Examples:
      | juror_number| pool_number | police_check_value               | police_check_status                |
      | 041500127   | 415300227   | UNCHECKED_MAX_RETRIES_EXCEEDED   | Not Checked - There was a problem |
      | 041500127   | 415300227   | ERROR_RETRY_OTHER_ERROR_CODE     | In Progress                        |
      | 041500127   | 415300227   | ERROR_RETRY_UNEXPECTED_EXCEPTION | In Progress                        |

  @JurorTransformationMulti
  Scenario Outline: Manually run police check - presence of link - failed
    Given I am on "Bureau" "test"
    Given I log in as "MODTESTCOURT"

    Given a bureau owned pool is created with jurors
      | court | juror_number  	    | pool_number	    | att_date_weeks_in_future	| owner |
      | 415   | <juror_number> 	    | <pool_number>     | 5				            | 400	|

    Then a new pool is inserted for where record has transferred to the court new schema
      |part_no   	  | pool_no   	  | owner |
      |<juror_number> | <pool_number> | 415   |

    Given I set Police Check to "INELIGIBLE" for "<juror_number>" new schema
    And I search for juror "<juror_number>"
    And I see the police check value is "Failed"
    And I do not see the link to run a police check

    Examples:
      | juror_number| pool_number	|
      | 041500128	| 415300228	    |

  @JurorTransformationMulti
  Scenario Outline: Manually run police check - presence of link - passed

    Given I am on "Bureau" "test"

    Given I log in as "MODTESTCOURT"

    Given a bureau owned pool is created with jurors
      | court | juror_number  	    | pool_number	    | att_date_weeks_in_future	| owner |
      | 415   | <juror_number> 	    | <pool_number>     | 5				            | 400	|

    Then a new pool is inserted for where record has transferred to the court new schema
      |part_no   	  | pool_no   	  | owner |
      |<juror_number> | <pool_number> | 415   |

#    Given I set Police Check to "P" and Phoenix Checked to "C" for "<juror_number>"
    Given I set Police Check to "ELIGIBLE" for "<juror_number>" new schema
    And I search for juror "<juror_number>"
    And I see the police check value is "Passed"
    And I do not see the link to run a police check

    Examples:
      | juror_number| pool_number |
      | 041500129	| 415300229	  |

  @JurorTransformationWIP @Not_Implemented_In_Backend @JM-4580
  Scenario Outline: Manually run police check - police check runs NOT IMPLEMENTED IN BACKEND
    Given I am on "Bureau" "test"

    Given a bureau owned pool is created with jurors
      | court | juror_number  	    | pool_number	    | att_date_weeks_in_future	| owner |
      | 415   | <juror_number> 	    | <pool_number>     | 5				            | 400	|

    Then a new pool is inserted for where record has transferred to the court new schema
      |part_no   	  | pool_no   	  | owner |
      |<juror_number> | <pool_number> | 415   |

    Given I log in as "MODTESTCOURT"

    Given I set Police Check to "NOT_CHECKED" for "<juror_number>" new schema
    And I search for juror "<juror_number>"
    And I record a happy path paper summons response and process now
    And I search for juror "<juror_number>"
    And I see the police check value is "Not Checked"
    And I see the link to run a police check
    When I click the link to run a police check
    And I see "Run a police check on this juror" on the page
#  NOT IMPLEMENTED IN BACKEND
    And I see the button to run a police check
    And I click the button to run a police check
    And I see the police check value is not "Not checked"

    Examples:
      | juror_number  | pool_number |
      | 041500130     | 415300230   |