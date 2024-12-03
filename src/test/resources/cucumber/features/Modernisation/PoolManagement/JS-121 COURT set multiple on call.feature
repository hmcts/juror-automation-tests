Feature: JS-121 Set Multiple Jurors to On Call

  @JurorTransformationMulti
  Scenario Outline: Happy Path Set multiple jurors in a pool to On Call

    Given I am on "Bureau" "demo"

    Given a bureau owned pool is created with jurors
      | court | juror_number  	    | pool_number	| att_date_weeks_in_future	| owner |
      | 415   | <juror_number_1>	| <pool_number>	| 2				            | 400	|
      | 415   | <juror_number_2>	| <pool_number>	| 2				            | 400	|
      | 415   | <juror_number_3>	| <pool_number>	| 2				            | 400	|
      | 415   | <juror_number_4>	| <pool_number>	| 2				            | 400	|
      | 415   | <juror_number_5>	| <pool_number>	| 2				            | 400	|
      | 415   | <juror_number_6>	| <pool_number>	| 2				            | 400	|
      | 415   | <juror_number_7>	| <pool_number>	| 2				            | 400	|
      | 415   | <juror_number_8>	| <pool_number>	| 2				            | 400	|
      | 415   | <juror_number_9>	| <pool_number>	| 2				            | 400	|
      | 415   | <juror_number_10>	| <pool_number>	| 2				            | 400	|

    Given a new pool is inserted for where record has transferred to the court new schema
      | part_no             | pool_no         | owner |
      | <juror_number_1>	| <pool_number>   | 415   |
      | <juror_number_2>	| <pool_number>   | 415   |
      | <juror_number_3>	| <pool_number>   | 415   |
      | <juror_number_4>	| <pool_number>   | 415   |
      | <juror_number_5>	| <pool_number>   | 415   |
      | <juror_number_6>	| <pool_number>   | 415   |
      | <juror_number_7>	| <pool_number>   | 415   |
      | <juror_number_8>	| <pool_number>   | 415   |
      | <juror_number_9>	| <pool_number>   | 415   |
      | <juror_number_10>	| <pool_number>   | 415   |

    Given juror "<juror_number_1>" has "DOB" as "1971-08-13 00:00:00.000" new schema
    Given juror "<juror_number_2>" has "DOB" as "1971-08-13 00:00:00.000" new schema
    Given juror "<juror_number_3>" has "DOB" as "1971-08-13 00:00:00.000" new schema
    Given juror "<juror_number_4>" has "DOB" as "1971-08-13 00:00:00.000" new schema
    Given juror "<juror_number_5>" has "DOB" as "1971-08-13 00:00:00.000" new schema
    Given juror "<juror_number_6>" has "DOB" as "1971-08-13 00:00:00.000" new schema
    Given juror "<juror_number_7>" has "DOB" as "1971-08-13 00:00:00.000" new schema
    Given juror "<juror_number_8>" has "DOB" as "1971-08-13 00:00:00.000" new schema
    Given juror "<juror_number_9>" has "DOB" as "1971-08-13 00:00:00.000" new schema
    Given juror "<juror_number_10>" has "DOB" as "1971-08-13 00:00:00.000" new schema

    Given I update juror "<juror_number_1>" to have a status of "Responded"
    Given I update juror "<juror_number_2>" to have a status of "Responded"
    Given I update juror "<juror_number_3>" to have a status of "Responded"
    Given I update juror "<juror_number_4>" to have a status of "Panel"
    Given I update juror "<juror_number_5>" to have a status of "Panel"
    Given I update juror "<juror_number_6>" to have a status of "Panel"
    Given I update juror "<juror_number_7>" to have a status of "Juror"
    Given I update juror "<juror_number_8>" to have a status of "Juror"
    Given I update juror "<juror_number_9>" to have a status of "Juror"
    Given I update juror "<juror_number_10>" to have a status of "Responded"

    And I log in as "<user>"

    #search for my pool
    And I press the "Apps" button
    And I click on the "Pool management" link
    And I click on the "Search" link
    And I set "Pool number" to "<pool_number>"
    And I press the "Continue" button

    Then I see "/pool-management/pool-overview/<pool_number>" in the URL

    When I check the "Select All" checkbox

    Then "<juror_number_1>" is checked
    Then "<juror_number_2>" is checked
    Then "<juror_number_3>" is checked
    Then "<juror_number_4>" is checked
    Then "<juror_number_5>" is checked
    Then "<juror_number_6>" is checked
    Then "<juror_number_7>" is checked
    Then "<juror_number_8>" is checked
    Then "<juror_number_9>" is checked
    Then "<juror_number_10>" is checked

    When I press the "On call" button
    Then I see "Are you sure you want to put 10 juror(s) on call" on the page

    When I click on the "Cancel" link

    When I check the "Select All" checkbox

    Then "<juror_number_1>" is checked
    Then "<juror_number_2>" is checked
    Then "<juror_number_3>" is checked
    Then "<juror_number_4>" is checked
    Then "<juror_number_5>" is checked
    Then "<juror_number_6>" is checked
    Then "<juror_number_7>" is checked
    Then "<juror_number_8>" is checked
    Then "<juror_number_9>" is checked
    Then "<juror_number_10>" is checked

    When I press the "On call" button
    Then I see "Are you sure you want to put 10 juror(s) on call" on the page

    When I press the "Place juror(s) on call" button
    Then I see "10 jurors are now on call" in the pool banner
    And I see "On Call" in the same row as "<juror_number_1>"
    And I see "On Call" in the same row as "<juror_number_2>"
    And I see "On Call" in the same row as "<juror_number_3>"
    And I see "On Call" in the same row as "<juror_number_4>"
    And I see "On Call" in the same row as "<juror_number_5>"
    And I see "On Call" in the same row as "<juror_number_6>"
    And I see "On Call" in the same row as "<juror_number_7>"
    And I see "On Call" in the same row as "<juror_number_8>"
    And I see "On Call" in the same row as "<juror_number_9>"
    And I see "On Call" in the same row as "<juror_number_10>"
    
    When I click on the "Apps" link
    When I click on the "Reporting" link
    When I click on the "On call list" link
    And I set "Enter a pool number" to "<pool_number>"
    And I press the "Search" button
    And I select one of the active pools available
    And I press the "Continue" button
    Then I see "reporting/on-call/report" in the URL
    Then I see link with text "<juror_number_1>"
    Then I see link with text "<juror_number_2>"
    Then I see link with text "<juror_number_3>"
    Then I see link with text "<juror_number_4>"
    Then I see link with text "<juror_number_5>"
    Then I see link with text "<juror_number_6>"
    Then I see link with text "<juror_number_7>"
    Then I see link with text "<juror_number_8>"
    Then I see link with text "<juror_number_9>"
    Then I see link with text "<juror_number_10>"

    Examples:
      | user         | pool_number  | juror_number_1  | juror_number_2  | juror_number_3  | juror_number_4  | juror_number_5  | juror_number_6  | juror_number_7  | juror_number_8  | juror_number_9  | juror_number_10  |
      | MODTESTCOURT | 415300173    | 041500083       | 041500084       | 041500085       | 041500086       | 041500087       | 041500088       | 041500089       | 041500090       | 041500091       | 041500092        |

  @JurorTransformationMulti
  Scenario Outline: Unappy Path Set multiple jurors in a pool to On Call

    Given I am on "Bureau" "demo"

    Given a bureau owned pool is created with jurors
      | court | juror_number  	    | pool_number	| att_date_weeks_in_future	| owner |
      | 415   | <juror_number_1>	| <pool_number>	| 2				            | 400	|
      | 415   | <juror_number_2>	| <pool_number>	| 2				            | 400	|
      | 415   | <juror_number_3>	| <pool_number>	| 2				            | 400	|
      | 415   | <juror_number_4>	| <pool_number>	| 2				            | 400	|
      | 415   | <juror_number_5>	| <pool_number>	| 2				            | 400	|
      | 415   | <juror_number_6>	| <pool_number>	| 2				            | 400	|
      | 415   | <juror_number_7>	| <pool_number>	| 2				            | 400	|
      | 415   | <juror_number_8>	| <pool_number>	| 2				            | 400	|
      | 415   | <juror_number_9>	| <pool_number>	| 2				            | 400	|
      | 415   | <juror_number_10>	| <pool_number>	| 2				            | 400	|
      | 415   | <juror_number_11>	| <pool_number>	| 2				            | 400	|
      | 415   | <juror_number_12>	| <pool_number>	| 2				            | 400	|

    Given a new pool is inserted for where record has transferred to the court new schema
      | part_no             | pool_no         | owner |
      | <juror_number_1>	| <pool_number>   | 415   |
      | <juror_number_2>	| <pool_number>   | 415   |
      | <juror_number_3>	| <pool_number>   | 415   |
      | <juror_number_4>	| <pool_number>   | 415   |
      | <juror_number_5>	| <pool_number>   | 415   |
      | <juror_number_6>	| <pool_number>   | 415   |
      | <juror_number_7>	| <pool_number>   | 415   |
      | <juror_number_8>	| <pool_number>   | 415   |
      | <juror_number_9>	| <pool_number>   | 415   |
      | <juror_number_10>	| <pool_number>   | 415   |
      | <juror_number_11>	| <pool_number>   | 415   |
      | <juror_number_12>	| <pool_number>   | 415   |

    Given juror "<juror_number_2>" has "DOB" as "1971-08-13 00:00:00.000" new schema
    Given juror "<juror_number_3>" has "DOB" as "1971-08-13 00:00:00.000" new schema
    Given juror "<juror_number_4>" has "DOB" as "1971-08-13 00:00:00.000" new schema
    Given juror "<juror_number_5>" has "DOB" as "1971-08-13 00:00:00.000" new schema
    Given juror "<juror_number_6>" has "DOB" as "1971-08-13 00:00:00.000" new schema
    Given juror "<juror_number_7>" has "DOB" as "1971-08-13 00:00:00.000" new schema
    Given juror "<juror_number_8>" has "DOB" as "1971-08-13 00:00:00.000" new schema
    Given juror "<juror_number_9>" has "DOB" as "1971-08-13 00:00:00.000" new schema
    Given juror "<juror_number_10>" has "DOB" as "1971-08-13 00:00:00.000" new schema
    Given juror "<juror_number_11>" has "DOB" as "1971-08-13 00:00:00.000" new schema
    Given juror "<juror_number_12>" has "DOB" as "1971-08-13 00:00:00.000" new schema

    Given I update juror "<juror_number_8>" to have a status of "Responded"
    Given I update juror "<juror_number_9>" to have a status of "Responded"
    Given I update juror "<juror_number_10>" to have a status of "Responded"
    Given I update juror "<juror_number_11>" to have a status of "Responded"
    Given I update juror "<juror_number_12>" to have a status of "Responded"

    And I log in as "<user>"

    #excuse juror2
    And I search for juror "<juror_number_2>"
    And I press the "Update juror record" button
    And I choose the "Excusal - grant or refuse" radio button
    And I press the "Continue" button
    And I select "I - ILL" from the "Reason for excusal request" dropdown
    And I choose the "Grant excusal" radio button
    And I press the "Continue" button
    And I choose the "No" radio button
    And I press the "Continue" button
    Then I see the juror record updated banner containing "Excusal granted (ill)"

    #postpone juror3
    And I search for juror "<juror_number_3>"
    And I press the "Update juror record" button
    And I choose the "Postpone service start date" radio button
    And I press the "Continue" button
    And I enter a date "15" mondays in the future for the new service start date
    And I press the "Continue" button
    And I choose the "Add to pool" radio button
    And I press the "Continue" button
    And I choose the "No" radio button
    And I press the "Continue" button
    Then I see the juror record updated banner containing "Postponed"

    #disqualify juror4
    And I search for juror "<juror_number_4>"
    And I press the "Update juror record" button
    And I choose the "Disqualify juror" radio button
    And I press the "Continue" button
    And I choose the "D - Judicial Disqualification" radio button
    And I press the "Continue" button
    And I choose the "No" radio button
    And I press the "Continue" button
    Then I see the juror record updated banner containing "Disqualified"

    #deceased juror5
    And I search for juror "<juror_number_5>"
    And I press the "Update juror record" button
    And I choose the "Mark as deceased" radio button
    And I set "Comments to record in the juror’s history" to "deceased"
    And I press the "Continue" button
    Then I see the juror record updated banner containing "Deceased"

    #undeliverable juror6
    And I search for juror "<juror_number_6>"
    And I press the "Update juror record" button
    And I choose the "Mark summons as undeliverable" radio button
    And I press the "Continue" button
    Then I see the juror record updated banner containing "Summons undeliverable"

    #reasssign juror7
    And I search for juror "<juror_number_7>"
    And I press the "Update juror record" button
    And I choose the "Reassign to another pool" radio button
    And I press the "Continue" button
    And I choose the "Create a new pool and reassign to this" radio button
    And I press the "Continue" button
    Then I see "Reassigned to pool" on the page

    #defer juror8
    And I search for juror "<juror_number_8>"
    And I press the "Update juror record" button
    And I choose the "Deferral - grant or refuse" radio button
    And I press the "Continue" button
    And I select "I - ILL" from the "Reason for the deferral request" dropdown
    And I choose the "Grant deferral" radio button
    And I choose the "Other" radio button
    And I set "Deferral date" to "4 mondays time"
    And I press the "Continue" button
    And I choose the "Add to pool" radio button
    And I press the "Continue" button
    And I choose the "No" radio button
    And I press the "Continue" button
    Then I see the juror record updated banner containing "Deferral granted (ILL)"

    #complete juror9
    And I search for juror "<juror_number_9>"
    And I press the "Update juror record" button
    And I choose the "Complete service" radio button
    And I press the "Continue" button
    And I press the "Complete service" button
    Then I see "Juror's service completed" on the page

    #FTA juror10
    And I search for juror "<juror_number_10>"
    And I press the "Update juror record" button
    And I choose the "Change juror status to ‘Failed to attend’" radio button
    And I press the "Continue" button
    And I check the "Tick to confirm the juror has failed to attend at any point and has not given a reasonable reason" checkbox
    And "Tick to confirm the juror has failed to attend at any point and has not given a reasonable reason" is checked
    And I press the "Change status to ‘Failed to attend’" button
    Then I see "Failed to attend" on the page

    #transfer juror11
    And I press the "Apps" button
    And I click on the "Pool management" link
    And I click on the "Search" link
    And I set "Pool number" to "<pool_number>"
    And I press the "Continue" button
    And I check the checkbox in the same row as "<juror_number_11>"
    And I press the "Transfer" button
    And I set "Enter a court name or location code" to "442"
    And I click on the "Northampton (442)" link
    And I set "Enter a service start date" to "today"
    And I press the "Continue" button
    And I press the "Continue" button
    Then I see "1 juror transferred to Northampton (442)" in the pool banner
    And I check the checkbox in the same row as "<juror_number_11>"

    #on call juror12
    And I check the checkbox in the same row as "<juror_number_12>"
    And I press the "On call" button
    And I see "Are you sure you want to put 1 juror(s) on call" on the page
    And I press the "Place juror(s) on call" button
    Then I see "1 juror is now on call" in the pool banner

    #try to put on call again
    And I check the checkbox in the same row as "<juror_number_12>"
    And I press the "On call" button
    And I see "Are you sure you want to put 1 juror(s) on call" on the page
    And I press the "Place juror(s) on call" button
    Then I see "Failed to place 1 juror on call - Selected juror is already on call" on the page

    When I check the "Select All" checkbox
    And I uncheck the "Select All" checkbox
    And I press the "On call" button
    Then I see error "Select at least one juror"

    When I check the "Select All" checkbox

    Then "<juror_number_1>" is checked
    Then "<juror_number_2>" is checked
    Then "<juror_number_4>" is checked
    Then "<juror_number_5>" is checked
    Then "<juror_number_6>" is checked
    Then "<juror_number_9>" is checked
    Then "<juror_number_10>" is checked
    Then "<juror_number_11>" is checked
    Then "<juror_number_12>" is checked

    When I press the "On call" button
    Then I see "You cannot place some of these jurors on call" on the page
    Then I see "Cannot be placed on call due to juror status" on the page
    Then I see "You can only place a juror on call with a responded, panel or juror status. The following jurors have a different status and cannot be placed on call." on the page

    Then I see "Summoned" in the same row as "<juror_number_1>"
    Then I see "Excused" in the same row as "<juror_number_2>"
    Then I see "Disqualified" in the same row as "<juror_number_4>"
    Then I see "Excused" in the same row as "<juror_number_5>"
    Then I see "Undeliverable" in the same row as "<juror_number_6>"
    Then I see "Completed" in the same row as "<juror_number_9>"
    Then I see "Failed to attend" in the same row as "<juror_number_10>"
    Then I see "Transferred" in the same row as "<juror_number_11>"
    And I do not see "<juror_number_12>" on the page

    When I press the "Continue and place remaining jurors on call" button

    Then I see "Are you sure you want to put 1 juror(s) on call" on the page
    And I press the "Place juror(s) on call" button
    Then I see "Failed to place 1 juror on call - Selected juror is already on call" on the page
    And I see "On Call" in the same row as "<juror_number_12>"

    Examples:
      | user         | pool_number  | juror_number_1  | juror_number_2  | juror_number_3  | juror_number_4  | juror_number_5  | juror_number_6  | juror_number_7  | juror_number_8  | juror_number_9  | juror_number_10  | juror_number_11  | juror_number_12  |
      | MODTESTCOURT | 415300174    | 041500095       | 041500096       | 041500097       | 041500098       | 041500099       | 041500100       | 041500101       | 041500102       | 041500103       | 041500104        | 041500105        | 041500106        |
