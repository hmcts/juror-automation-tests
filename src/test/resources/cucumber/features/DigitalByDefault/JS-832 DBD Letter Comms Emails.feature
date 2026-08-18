Feature: JS-838

  @Comms @DBD
  Scenario Outline: 1st Party Deferral accepted

    Given I am on "Public" "<environment>"

    When a bureau owned pool is created with jurors
      | court | juror_number   | pool_number   | att_date_weeks_in_future | owner |
      | 431   | <juror_number> | <pool_number> | 5                        | 400   |

    Given juror "<juror_number>" has "LAST_NAME" as "<last_name>" new schema
    Given juror "<juror_number>" has "POSTCODE" as "<postcode>" new schema
    Given I update "<juror_number>" to set them up for digital by default

    And I have submitted a first party English deferral response
      | part_no		    | pool_number   | last_name		| postcode	  | email   |
      | <juror_number>  | <pool_number>	| <last_name>	| <postcode>  | <email> |

    Given I am on "Bureau" "<environment>"
    And I log in as "MODTESTBUREAU"

    When I click on the "Search" link
    And I set "Juror number" to "<juror_number>"
    And I press the "Search" button
    And I click on "<juror_number>" in the same row as "<juror_number>"
    Then I see "Summoned" on the page

    When I select "Deferral" from Process reply

    Then I select "O - OTHER" from the "Reason for the deferral request" dropdown
    Then I select to Choose a different date
    Then I set the "alternate" choice to "51" Mondays in the future
    And I press the "Continue" button

    Then I see "There are no active pools for this date" on the page
    And I press the "Put in deferral maintenance" button
    And I see "Deferral granted" on the page

    Examples:
      | juror_number	| pool_number | last_name 	  | postcode  | email		| environment |
      | 643100091	    | 431170402   | DBDDEFGRANTED | SA1 4PF	  | e@mail.com  | ithc        |

  @Comms @DBD
  Scenario Outline: Postponement

    Given I am on "Public" "<environment>"

    When a bureau owned pool is created with jurors
      | court | juror_number   | pool_number   | att_date_weeks_in_future | owner |
      | 431   | <juror_number> | <pool_number> | 5                        | 400   |

    Given juror "<juror_number>" has "LAST_NAME" as "<last_name>" new schema
    Given juror "<juror_number>" has "POSTCODE" as "<postcode>" new schema
    Given I update "<juror_number>" to set them up for digital by default

    And I have submitted a first party English deferral response
      | part_no		    | pool_number   | last_name		| postcode	  | email   |
      | <juror_number>  | <pool_number>	| <last_name>	| <postcode>  | <email> |

    Given I am on "Bureau" "<environment>"
    And I log in as "MODTESTBUREAU"

    When I click on the "Search" link
    And I set "Juror number" to "<juror_number>"
    And I press the "Search" button
    And I click on "<juror_number>" in the same row as "<juror_number>"
    Then I see "Summoned" on the page

    When I select "Mark as responded" from Process reply
    And I check the "Mark juror as 'responded'" checkbox
    And I press the "Confirm" button
    Then I see the juror status has updated to "Responded"
    
    When I click on the "View juror's record" link
    And I see "Juror record" on the page
    And I press the "Update juror record" button
    And I choose the "Postpone service start date" radio button
    And I press the "Continue" button

    Then I enter a date "51" mondays in the future for the new service start date
    And I press the "Continue" button

    Then I see "There are no active pools for this date" on the page
    And I press the "Put in deferral maintenance" button
    Then I see "Postponed" on the page

    Examples:
      | juror_number	| pool_number | last_name 	 | postcode  | email	  | environment |
      | 643100092	    | 431170403   | DBDPOSTPONED | SA1 4PF	 | e@mail.com | ithc        |

  @Comms @DBD
  Scenario Outline: Excusal Granted

    Given I am on "Public" "<environment>"

    When a bureau owned pool is created with jurors
      | court | juror_number   | pool_number   | att_date_weeks_in_future | owner |
      | 431   | <juror_number> | <pool_number> | 5                        | 400   |

    Given juror "<juror_number>" has "LAST_NAME" as "<last_name>" new schema
    Given juror "<juror_number>" has "POSTCODE" as "<postcode>" new schema
    Given I update "<juror_number>" to set them up for digital by default

    And I have submitted a first party English excusal response
      | part_no		    | pool_number   | last_name		| postcode	  | email   |
      | <juror_number>  | <pool_number>	| <last_name>	| <postcode>  | <email> |

    Given I am on "Bureau" "<environment>"
    And I log in as "MODTESTBUREAU"

    When I click on the "Search" link
    And I set "Juror number" to "<juror_number>"
    And I press the "Search" button
    And I click on "<juror_number>" in the same row as "<juror_number>"
	Then I see "Summoned" on the page

    When I select "Excusal" from Process reply
    And I set the radio button to "Grant excusal"
    And I select "O - OTHER" from the "Reason for excusal request" dropdown
    And I press the "Continue" button
    Then I see the juror status has updated to "Excused"

    Examples:
      | juror_number	| pool_number | last_name 	  | postcode  | email		| environment |
      | 643100093	    | 431170404   | DBDEXCGRANTED | SA1 4PF	  | e@mail.com  | ithc        |

  @Comms @DBD
  Scenario Outline: Excusal Refused

    Given I am on "Public" "<environment>"

    When a bureau owned pool is created with jurors
      | court | juror_number   | pool_number   | att_date_weeks_in_future | owner |
      | 431   | <juror_number> | <pool_number> | 5                        | 400   |

    Given juror "<juror_number>" has "LAST_NAME" as "<last_name>" new schema
    Given juror "<juror_number>" has "POSTCODE" as "<postcode>" new schema
    Given I update "<juror_number>" to set them up for digital by default

    And I have submitted a first party English excusal response
      | part_no		    | pool_number   | last_name		| postcode	  | email   |
      | <juror_number>  | <pool_number>	| <last_name>	| <postcode>  | <email> |

    Given I am on "Bureau" "<environment>"
    And I log in as "MODTESTBUREAU"

    When I click on the "Search" link
    And I set "Juror number" to "<juror_number>"
    And I press the "Search" button
    And I click on "<juror_number>" in the same row as "<juror_number>"
    Then I see "Summoned" on the page

    When I select "Excusal" from Process reply
    And I set the radio button to "Refuse excusal"
    And I select "O - OTHER" from the "Reason for excusal request" dropdown
    And I press the "Continue" button
    Then I see the juror status has updated to "Summoned"
    
    When I click on the "View juror's record" link
    And I click the update juror record button
    And I set the radio button to "Mark as responded"
    And I press the "Continue" button
    Then I see "Mark as responded" on the page
    When I check the "Mark juror as 'responded'" checkbox
    And I press the "Confirm" button
    Then I see the juror status on the juror record screen has updated to "Responded"

    Examples:
      | juror_number	| pool_number | last_name 	  | postcode  | email		| environment |
      | 643100094	    | 431170405   | DBDEXCREFUSED | SA1 4PF	  | e@mail.com  | ithc        |

  @Comms @DBD
  Scenario Outline: Deferral Refused

    Given I am on "Public" "<environment>"

    When a bureau owned pool is created with jurors
      | court | juror_number   | pool_number   | att_date_weeks_in_future | owner |
      | 431   | <juror_number> | <pool_number> | 5                        | 400   |

    Given juror "<juror_number>" has "LAST_NAME" as "<last_name>" new schema
    Given juror "<juror_number>" has "POSTCODE" as "<postcode>" new schema
    Given I update "<juror_number>" to set them up for digital by default

    And I have submitted a first party English deferral response
      | part_no		    | pool_number   | last_name		| postcode	  | email   |
      | <juror_number>  | <pool_number>	| <last_name>	| <postcode>  | <email> |

    Given I am on "Bureau" "<environment>"
    And I log in as "MODTESTBUREAU"

    When I click on the "Search" link
    And I set "Juror number" to "<juror_number>"
    And I press the "Search" button
    And I click on "<juror_number>" in the same row as "<juror_number>"

    And I click the process reply button
    Then I select deferral request
    And I click continue on the juror summons reply page

    Then I select "O - OTHER" from the "Reason for the deferral request" dropdown
    Then I select to Choose a different date
    Then I set the "alternate" choice to "41" Mondays in the future
    And I press the "Continue" button

    Then I see "There are no active pools for this date" on the page
    And I press the "Put in deferral maintenance" button

    When the user searches for juror record "<juror_number>" from the global search bar
    And I see the juror status on the juror record screen has updated to "Deferred"

    And I click the update juror record button
    And I set the radio button to "Mark as responded"
    And I press the "Continue" button
    And I see "Mark as responded" on the page
    And I check the "Mark juror as 'responded'" checkbox
    And I press the "Confirm" button

    And I see the juror status on the juror record screen has updated to "Responded"

    And I click the update juror record button
    And I set the radio button to "Deferral - grant or refuse"
    Then I click continue on the update juror record screen
    And I select "O - OTHER" from the "Reason for the deferral request" dropdown
    And I set the radio button to "Refuse deferral"
    And I press the "Continue" button
    And I see "Deferral refused (other)" on the page
    And I see the number of deferrals is "1"
    And the warning icon is displayed next to the juror status

    Examples:
      | juror_number	| pool_number | last_name 	  | postcode  | email		| environment |
      | 643100095	    | 431170406   | DBDDEFREFUSED | SA1 4PF	  | e@mail.com  | ithc        |

  @Comms @DBD
  Scenario Outline: Withdrawal

    Given I am on "Public" "<environment>"

    When a bureau owned pool is created with jurors
      | court | juror_number   | pool_number   | att_date_weeks_in_future | owner |
      | 431   | <juror_number> | <pool_number> | 5                        | 400   |

    Given juror "<juror_number>" has "LAST_NAME" as "<last_name>" new schema
    Given juror "<juror_number>" has "POSTCODE" as "<postcode>" new schema
    Given I update "<juror_number>" to set them up for digital by default

    And I have submitted a first party English ineligibilty response
      | part_no		    | pool_number   | last_name		| postcode	  | email   |
      | <juror_number>  | <pool_number>	| <last_name>	| <postcode>  | <email> |

    Given I am on "Bureau" "<environment>"
    And I log in as "MODTESTBUREAU"

    When I click on the "Search" link
    And I set "Juror number" to "<juror_number>"
    And I press the "Search" button
    And I click on "<juror_number>" in the same row as "<juror_number>"
    And I click the process reply button
    Then I choose the "Disqualify" radio button
    And I press the "Continue" button
    And I choose the "R - Residency" radio button
    And I press the "Continue" button
    Then I see the juror record updated banner containing "Disqualified"

    Examples:
      | juror_number	| pool_number | last_name 	  | postcode  | email		| environment |
      | 643100096	    | 431170407   | DBDWITHDRAWAL | SA1 4PF	  | e@mail.com  | ithc        |