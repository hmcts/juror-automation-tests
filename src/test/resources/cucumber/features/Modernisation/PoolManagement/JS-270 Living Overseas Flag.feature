Feature: JS-270

  @JurorTransformationMulti
  Scenario Outline: Juror is living overseas flag BUREAU

    Given I am on "Bureau" "demo"

    And I log in as "<user>"

    Given a bureau owned pool is created with jurors
      | court | juror_number  	    | pool_number	    | att_date_weeks_in_future	| owner |
      | 415   | <juror_number_1> 	| <pool_number>     | 5				            | 400	|

    #search for juror1
    When the user searches for juror record "<juror_number_1>" from the global search bar

    #go to juror details page
    When I click on the "Juror details" link

    #default is living overseas is no and displays as "-"
    Then I see "-" in the same row as "Living overseas"
    
    #edit address
    When I click on the "Add or change" link
    And I choose Does The juror live overseas radio button "yes"
    And I enter a date of birth that will make the juror between 18 and 75
    And I press the "Save" button

    #check living overseas shows as Yes
    Then I see "Yes" in the same row as "Living overseas"

    #Now change living overseas to No
    When I click on the "Add or change" link
    And I choose Does The juror live overseas radio button "no"
    And I enter a date of birth that will make the juror between 18 and 75
    And I press the "Save" button

    #check living overseas shows as Yes
    Then I see "-" in the same row as "Living overseas"

    Examples:
      | juror_number_1  | pool_number   | user         |
      | 041500170       | 415300250     | MODTESTBUREAU|

  @JurorTransformationMulti
  Scenario Outline: Welsh flag shown for Welsh jurors BUREAU

    Given I am on "Bureau" "demo"

    And I log in as "<user>"

    Given a bureau owned pool is created with jurors
      | court | juror_number  	    | pool_number	    | att_date_weeks_in_future	| owner |
      | 457   | <juror_number_1> 	| <pool_number>     | 5				            | 400	|

    Given juror "<juror_number_1>" has "POSTCODE" as "SA1 2NN" new schema

    #search for juror1
    When the user searches for juror record "<juror_number_1>" from the global search bar

    #go to juror details page
    When I click on the "Juror details" link

    #default is living overseas is no and displays as "-"
    Then I see "-" in the same row as "Living overseas"
    And I see "No" in the same row as "Welsh language"

    #edit address
    When I click on the "Add or change" link
    And I choose Does The juror live overseas radio button "yes"
    And I enter a date of birth that will make the juror between 18 and 75
    And I see "Tick box if juror should get communications in Welsh (optional)" on the page
    And "Yes, send Welsh language communications" is unchecked
    And I press the "Save" button

    #check living overseas shows as Yes
    Then I see "Yes" in the same row as "Living overseas"

    #Now change living overseas to No
    When I click on the "Add or change" link
    And I choose Does The juror live overseas radio button "no"
    And I enter a date of birth that will make the juror between 18 and 75
    And I press the "Save" button

    #check living overseas shows as Yes
    Then I see "-" in the same row as "Living overseas"

    Examples:
      | juror_number_1  | pool_number   | user         |
      | 045700301       | 457300301     | MODTESTBUREAU|

  @JurorTransformationMulti
  Scenario Outline: Juror is living overseas flag COURT

    Given I am on "Bureau" "demo"

    And I log in as "<user>"

    Given a bureau owned pool is created with jurors
      | court | juror_number  	    | pool_number	    | att_date_weeks_in_future	| owner |
      | 415   | <juror_number_1> 	| <pool_number>     | 5				            | 400	|

    Then a new pool is inserted for where record has transferred to the court new schema
      |part_no               | pool_no          | owner |
      |<juror_number_1>      | <pool_number>    | 415   |

    #search for juror1
    When the user searches for juror record "<juror_number_1>" from the global search bar

    #go to juror details page
    When I click on the "Juror details" link

    #default is living overseas is no and displays as "-"
    Then I see "-" in the same row as "Living overseas"

    And I do not see "Welsh language" on the page

    #edit address
    When I click on the "Add or change" link
    And I choose Does The juror live overseas radio button "yes"
    And I enter a date of birth that will make the juror between 18 and 75
    And I do not see "Tick box if juror should get communications in Welsh (optional)" on the page
    And I press the "Save" button

    #check living overseas shows as Yes
    Then I see "Yes" in the same row as "Living overseas"

    #Now change living overseas to No
    When I click on the "Add or change" link
    And I choose Does The juror live overseas radio button "no"
    And I enter a date of birth that will make the juror between 18 and 75
    And I press the "Save" button

    #check living overseas shows as Yes
    Then I see "-" in the same row as "Living overseas"

    Examples:
      | juror_number_1  | pool_number   | user         |
      | 041500176       | 415300259     | MODTESTCOURT |

  @JurorTransformationMulti
  Scenario Outline: Welsh flag shown for Welsh jurors COURT

    Given I am on "Bureau" "demo"

    And I log in as "<user>" selecting court "457"

    Given a bureau owned pool is created with jurors
      | court | juror_number    | pool_number	    | att_date_weeks_in_future	| owner |
      | 457   | <juror_number> 	| <pool_number>     | 5				            | 400	|

    Then a new pool is inserted for where record has transferred to the court new schema
      |part_no             | pool_no          | owner |
      |<juror_number>      | <pool_number>    | 457   |

    #search for juror1
    When the user searches for juror record "<juror_number>" from the global search bar

    #go to juror details page
    When I click on the "Juror details" link

    #default is living overseas is no and displays as "-"
    Then I see "-" in the same row as "Living overseas"
    And I see "No" in the same row as "Welsh language"

    #edit address
    When I click on the "Add or change" link
    And I choose Does The juror live overseas radio button "yes"
    And I enter a date of birth that will make the juror between 18 and 75
    And I see "Tick box if juror should get communications in Welsh (optional)" on the page
    And "Yes, send Welsh language communications" is unchecked
    And I press the "Save" button

    #check living overseas shows as Yes
    Then I see "Yes" in the same row as "Living overseas"

    #Now change living overseas to No
    When I click on the "Add or change" link
    And I choose Does The juror live overseas radio button "no"
    And I enter a date of birth that will make the juror between 18 and 75
    And I press the "Save" button

    #check living overseas shows as Yes
    Then I see "-" in the same row as "Living overseas"

    Examples:
      | juror_number  | pool_number   | user    |
      | 045700130     | 457300300     | SWANSEA |