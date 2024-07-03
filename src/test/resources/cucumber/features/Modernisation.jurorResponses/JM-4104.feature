Feature: JM-4104 - As a Bureau officer I need to be able to see the pool history

  @JurorTransformationWIP @JM-4467
  Scenario Outline: Test to check Bureau officer can see Pool history - new pool - deferrals added
  Given I am on "Bureau" "test"
  And I log in as "<user>"

    Given a bureau owned pool is created with jurors
      | court |juror_number  	| pool_number	| att_date_weeks_in_future	| owner |
      | 415   |<juror_number> 	| <pool_number> | 5				            | 400	|

  #create pool request
  And I press the "Apps" button
  And I click on the "Pool management" link

  Given the juror "<juror_number>" is inserted into pool "<pool_number>" with a deferral date "9" Mondays in the future for court "415"
  And a new pool is inserted for court "415" with a deferral date "0" weeks in the future
  And I create a "Civil" court pool request for court "415" with "1" deferral
  Then I select the pool that I have just created to move to the pool summary page
  And I click on the "History" link
  #JM-4467 raised Number of Deferrals should be showing - AC split between 4104 and 3987
  And I see the title "Number of Deferrals" in position "1" of the history
  And I click on the "Jurors" link
  And I press the "Summon jurors" button
  And I set "Citizens to summon" to "30"
  And I press the "Create pool and summon citizens" button
  And I see "Active pools" on the page
  Then I select the pool that I have just created to move to the pool summary page
  And I click on the "History" link
  And I see the title "Number of Deferrals" in position "2" of the history

    Examples:
      | user	      | juror_number  | pool_number |
      | MODTESTBUREAU  | 041500040     | 415300129   |

  @JurorTransformation
  Scenario: Test to check Bureau officer can see Pool history - new pool - summons issued
  Given I am on "Bureau" "test"
  And I log in as "MODTESTBUREAU"

  #create pool request
  And I press the "Apps" button
  And I click on the "Pool management" link
  And I create a "Civil" court pool request for court "415"
  Then I select the pool that I have just created to move to the pool summary page
  And I press the "Summon jurors" button
  And I set "Citizens to summon" to "30"
  And I press the "Create pool and summon citizens" button
  And I see "Active pools" on the page
  Then I select the pool that I have just created to move to the pool summary page
  And I click on the "History" link
  And I see the title "Number of Summons Issued" in position "1" of the history

  Then I clear down the data for the pool

  @JurorTransformation
  Scenario: Test to check Bureau officer can see Pool history - edit pool - summons issued
  Given I am on "Bureau" "test"
  And I log in as "MODTESTBUREAU"

  #create pool request
  And I press the "Apps" button
  And I click on the "Pool management" link
  And I create a "Civil" court pool request for court "415"
  Then I select the pool that I have just created to move to the pool summary page
  And I press the "Summon jurors" button
  And I set "Citizens to summon" to "30"
  And I press the "Create pool and summon citizens" button
  And I see "Active pools" on the page
  Then I select the pool that I have just created to move to the pool summary page
  And I click on the "History" link
  And I see the title "Number of Summons Issued" in position "1" of the history
  And I see the description "30 (New Pool Request)" in position "1" of the history
  And I click on the "Jurors" link
  And I press the "Summon jurors" button
  And I set "Extra citizens to summon" to "1"
  And I press the "Summon more citizens" button
  And I click on the "History" link
  And I see the title "Number of Summons Issued" in position "1" of the history
  And I see the description "1 (Add Pool Members)" in position "1" of the history

  Then I clear down the data for the pool

  @JurorTransformation
  Scenario: Test to check Bureau officer can see Pool history - edit pool - change pool request details
  Given I am on "Bureau" "test"
  And I log in as "MODTESTBUREAU"

  #create pool request
  And I press the "Apps" button
  And I click on the "Pool management" link
  And I create a "Civil" court pool request for court "415"
  Then I select the pool that I have just created to move to the pool summary page
  And I press the "Summon jurors" button
  And I set "Citizens to summon" to "30"
  And I press the "Create pool and summon citizens" button
  And I see "Active pools" on the page
  Then I select the pool that I have just created to move to the pool summary page
  And I press the "Edit pool" button
  And I set "Number of jurors requested" to "135"
  And I set "Reason for change" to "Too many jurors"
  And I press the "Save changes" button
  And I click on the "History" link
  And I see the title "Change Pool Request Details" in position "1" of the history
  And I see the description "Jurors Requested changed from 150 to 135" in position "1" of the history

  Then I clear down the data for the pool

  @JurorTransformation
  Scenario: Test to check Bureau officer can see Pool history - order of history is correct
  Given I am on "Bureau" "test"
  And I log in as "MODTESTBUREAU"

  #create pool request
  And I press the "Apps" button
  And I click on the "Pool management" link
  And I create a "Civil" court pool request for court "415"
  Then I select the pool that I have just created to move to the pool summary page
  And I press the "Summon jurors" button
  And I set "Citizens to summon" to "30"
  And I press the "Create pool and summon citizens" button
  And I see "Active pools" on the page
  Then I select the pool that I have just created to move to the pool summary page
  And I press the "Summon jurors" button
  And I set "Extra citizens to summon" to "1"
  And I press the "Summon more citizens" button
  And I press the "Edit pool" button
  And I set "Number of jurors requested" to "135"
  And I set "Reason for change" to "Too many jurors"
  And I press the "Save changes" button
  And I click on the "History" link
  And I see the title "Change Pool Request Details" in position "1" of the history
  And I see the description "Jurors Requested changed from 150 to 135" in position "1" of the history

  And I see the title "Number of Summons Issued" in position "2" of the history
  And I see the description "1 (Add Pool Members)" in position "2" of the history

  And I see the title "Number of Summons Issued" in position "3" of the history
  And I see the description "30 (New Pool Request)" in position "3" of the history

  Then I clear down the data for the pool

   @JurorTransformation @NewSchemaConverted
   Scenario: Test to check Bureau officer can see Pool history - times/dates are correct
   Given I am on "Bureau" "test"
   And I log in as "MODTESTBUREAU"

   #create pool request
   And I press the "Apps" button
   And I click on the "Pool management" link
   And I create a "Civil" court pool request for court "415"
   And I make a note of the time
   Then I select the pool that I have just created to move to the pool summary page
   And I press the "Summon jurors" button
   And I set "Citizens to summon" to "30"
   And I press the "Create pool and summon citizens" button
   And I make a note of the time
   And I see "Active pools" on the page
   Then I select the pool that I have just created to move to the pool summary page
   And I press the "Summon jurors" button
   And I set "Extra citizens to summon" to "1"
   And I press the "Summon more citizens" button
   And I make a note of the time
   And I press the "Edit pool" button
   And I set "Number of jurors requested" to "35"
   And I set "Reason for change" to "Too many jurors"
   And I press the "Save changes" button
   And I make a note of the time
   And I click on the "History" link
   And I see the title "Change Pool Request Details" in position "1" of the history
     And I see the description "Jurors Requested changed from 150 to 35" in position "1" of the history
   And I see the correct date and time in position "1" of the history

   And I see the title "Number of Summons Issued" in position "2" of the history
   And I see the description "1 (Add Pool Members)" in position "2" of the history
   And I see the correct date and time in position "2" of the history

   And I see the title "Number of Summons Issued" in position "3" of the history
   And I see the description "30 (New Pool Request)" in position "3" of the history
   And I see the correct date and time in position "3" of the history

   And I see the title "Change Pool Request Details" in position "4" of the history
   And I see the description "Pool Requested for 150 Jurors" in position "4" of the history
   And I see the correct date and time in position "4" of the history

  Then I clear down the data for the pool

  @JurorTransformationWIP @No_defect_ticket_raised_as_still_under_discussion
  Scenario: Test to check Bureau officer can see Pool history - history from deleted pool does not persist
    # may not be required, requirements for this are still under discussion
    # juror heritage kept the history for auditing but it was never shown to the user
    # discussion is whether to keep it in the ui or remove it from the ui but still keep it for auditing
  Given I am on "Bureau" "test"
  And I log in as "MODTESTBUREAU"

  #create pool request
  And I press the "Apps" button
  And I click on the "Pool management" link
  And I create a "Civil" court pool request for court "415"
  Then I select the pool that I have just created to move to the pool summary page
  And I press the "Delete pool request" button
  And I press the "Delete pool request" button
  And I create a "Civil" court pool request for court "415" using the same pool number
  Then I select the pool that I have just created to move to the pool summary page
  And I click on the "History" link
  And I do not see the title "Pool Deleted" in position "2" of the history

  Then I clear down the data for the pool


