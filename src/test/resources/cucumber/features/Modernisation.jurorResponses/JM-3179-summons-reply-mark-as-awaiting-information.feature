Feature: JM-3179

  @JurorTransformationMulti
  Scenario Outline: Test to mark paper summons reply as awaiting information

    Given I am on "Bureau" "demo"

    Given a bureau owned pool is created with jurors
      | court | juror_number  	    | pool_number	    | att_date_weeks_in_future	| owner |
      | 452   | <juror_number> 	    | <pool_number>     | 5				            | 400	|

    And I log in as "MODTESTBUREAU"

    When the user searches for juror record "<juror_number>" from the global search bar
    And I record a happy path paper summons response
    When the user searches for juror record "<juror_number>" from the global search bar
    And I click on the "Summons reply" link
    And I click on the "View summons reply" link
    And I click the More Actions button
    And I click Awaiting Information
    Then I see "Who are you waiting for information from?" on the page
    And I mark this reply as awaiting information from "<waitingOnReplyFrom>"
    Then I press the "Confirm" button
    And I do not see "Select whether you’re waiting for information from either the juror, court or translation unit" on the page
    And I do not see "The summons reply has been updated by another user" on the page
    And I see the reply status has updated to "<updatedReplyStatus>"

    Examples:
    | waitingOnReplyFrom | updatedReplyStatus   | juror_number | pool_number |
    | Juror              | Awaiting juror info  | 045200009    | 452300005   |
    | Court              | Awaiting court reply | 045200009    | 452300005   |
    | Translation unit   | Awaiting Translation | 045200009    | 452300005   |

  @JurorTransformationMulti
  Scenario Outline: Test to mark paper summons reply as awaiting information - validation

    Given I am on "Bureau" "demo"

    Given a bureau owned pool is created with jurors
      | court | juror_number  	    | pool_number	    | att_date_weeks_in_future	| owner |
      | 452   | <juror_number> 	    | <pool_number>     | 5				            | 400	|

    And I log in as "<user>"
    When the user searches for juror record "<juror_number>" from the global search bar
    And I record a happy path paper summons response
    When the user searches for juror record "<juror_number>" from the global search bar
    And I click on the "Summons reply" link
    And I click on the "View summons reply" link
    And I click the More Actions button
    And I click Awaiting Information
    Then I see "Who are you waiting for information from?" on the page
    Then I press the "Confirm" button
    And I see "Select whether you’re waiting for information from either the juror, court or translation unit" on the page

    Examples:
      | user          | juror_number   | pool_number |
      | MODTESTBUREAU | 045200010      | 452300006   |

  @JurorTransformationMulti
  Scenario Outline: Test to mark summons reply as awaiting information

    Given I am on "Bureau" "demo"

    Given a bureau owned pool is created with jurors
      | court | juror_number  	    | pool_number	    | att_date_weeks_in_future	| owner |
      | 452   | <juror_number> 	    | <pool_number>     | 5				            | 400	|

    And I log in as "MODTESTBUREAU"

    When the user searches for juror record "<juror_number>" from the global search bar
    And I record a happy path paper summons response
    When the user searches for juror record "<juror_number>" from the global search bar
    And I click on the "Summons reply" link
    And I click on the "View summons reply" link
    And I click the More Actions button
    And I click Awaiting Information
    Then I see "Who are you waiting for information from?" on the page
    And I mark this reply as awaiting information from "<waitingOnReplyFrom>"
    Then I press the "Confirm" button
    And I do not see "Select whether you’re waiting for information from either the juror, court or translation unit" on the page
    And I do not see "The summons reply has been updated by another user" on the page
    And I see the reply status has updated to "<updatedReplyStatus>"

    Examples:
      | waitingOnReplyFrom | updatedReplyStatus   | juror_number | pool_number |
      | Juror              | Awaiting juror info  | 045200011    | 452300007   |
      | Court              | Awaiting court reply | 045200011    | 452300007   |
      | Translation unit   | Awaiting Translation | 045200011    | 452300007   |

  @JurorTransformationMulti
  Scenario Outline: Test to mark summons reply as awaiting information - validation

    Given I am on "Bureau" "demo"

    Given a bureau owned pool is created with jurors
      | court | juror_number  	    | pool_number	    | att_date_weeks_in_future	| owner |
      | 415   | <juror_number> 	    | <pool_number>     | 7				            | 400	|

    And I log in as "<user>"
    When the user searches for juror record "<juror_number>" from the global search bar
    And I record a happy path paper summons response
    When the user searches for juror record "<juror_number>" from the global search bar
    And I click on the "Summons reply" link
    And I click on the "View summons reply" link
    And I click the More Actions button
    And I click Awaiting Information
    Then I see "Who are you waiting for information from?" on the page
    Then I press the "Confirm" button
    And I see "Select whether you’re waiting for information from either the juror, court or translation unit" on the page

    Examples:
      | user          | juror_number  | pool_number   |
      | MODTESTBUREAU | 041500133     | 415300233     |