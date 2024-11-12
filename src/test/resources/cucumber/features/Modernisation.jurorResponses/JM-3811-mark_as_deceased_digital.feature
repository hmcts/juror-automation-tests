Feature: JM-3811 Mark as deceased digital

  @JurorTransformationMulti
  Scenario Outline: Test to grant deceased excusal on digital response

    Given I am on "Public" "test"

    When a bureau owned pool is created with jurors
      | court |juror_number       | pool_number      | att_date_weeks_in_future | owner |
      | 415   |<juror_number>     | <pool_number>     | 5                      | 400  |

    And I have submitted a third party English deceased response
      |part_no           |pool_number   |last_name		|postcode	|email 	|
      |<juror_number>    |<pool_number>	|<last_name>	|<postcode>	|<email>|

    Given I am on "Bureau" "test"
    Given I log in as "<user>"
    
    And the user searches for juror record "<juror_number>" from the global search bar
    When I click the summons reply tab
    When I click on the view summons reply link
    And I see the reply status has updated to "Completed"
    And I see the juror status has updated to "Deceased"

    Examples:
      |juror_number		|pool_number	|last_name        |postcode |email      |user         |
      |041534788	    |415300701	    |lname            |CH2 2AA  |e@mail.com |MODTESTBUREAU|