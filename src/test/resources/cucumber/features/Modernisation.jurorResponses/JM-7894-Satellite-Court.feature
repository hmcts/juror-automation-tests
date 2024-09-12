Feature: JM-7894

  @JurorTransformationMulti @NewSchemaConverted
  Scenario Outline: As a Satellite court user I should see the attendances for the court I am logged in as not the active court the juror is at
    Given I am on "Bureau" "ithc"

    Given a bureau owned pool is created with jurors
      | court | juror_number  	    | pool_number	    | att_date_weeks_in_future	| owner |
      | 415   | <juror_number> 	| <pool_number>     | 5				            | 400	|

    Then a new pool is inserted for where record has transferred to the court new schema
      |part_no            | pool_no       | owner |
      |<juror_number>    | <pool_number> | 415   |

    And I update juror "<juror_number>" to have a status of "Responded"

    And I log in as "<user>"

    And the user searches for juror record "<juror_number>" from the global search bar
    And I click on the "Attendance" link
    And I press the "Add attendance day" button

    When I set the "Attendance Day" date to 7 days in the past
    #check in on confirm attendance
    And I set juror check in hour to "9" on confirm attendance
    And I set juror check in minute to "20" on confirm attendance
    And I click on the am radio button for juror check in on confirm attendance

    #check out on confirm attendance
    And I set juror check out hour to "2" on confirm attendance
    And I set juror check out minute to "30" on confirm attendance
    And I click on the pm radio button for juror check out on confirm attendance
    And I press the "Add attendance day" button

    And the user searches for juror record "<juror_number>" from the global search bar

    And I press the "Update juror record" button
    And I set the radio button to "Reassign to another pool"
    And I press the "Continue" button
    And I click on the "Change court" link
    And I set the radio button to "Warrington (462)"
    And I press the "Continue" button
    And I select one of the active pools available
    And I press the "Continue" button
    And I see "Juror record updated: Reassigned to pool" on the page

    Given I am on "Bureau" "ithc"
    And I log in as "<user>" selecting court "462"

    And the user searches for juror record "<juror_number>" from the global search bar
    And I click on the "Attendance" link
    And I do not see "9:20am" on the page

    And I press the "Add attendance day" button

    When I set the "Attendance Day" date to 7 days in the past
    #check in on confirm attendance
    And I set juror check in hour to "9" on confirm attendance
    And I set juror check in minute to "45" on confirm attendance
    And I click on the am radio button for juror check in on confirm attendance

    #check out on confirm attendance
    And I set juror check out hour to "2" on confirm attendance
    And I set juror check out minute to "30" on confirm attendance
    And I click on the pm radio button for juror check out on confirm attendance
    And I press the "Add attendance day" button

    Given I am on "Bureau" "ithc"
    And I log in as "<user>"

    And the user searches for juror record "<juror_number>" from the global search bar
    And I click on the "Attendance" link
    And I do not see "9:45am" on the page

    Examples:
      |user			| juror_number  | pool_number |
      |MODTESTCOURT | 041524366      | 415313621  |