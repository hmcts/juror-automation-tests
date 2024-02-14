Feature: 1)JM-5070 As a jury officer I need to be able to change a jurors attendance date (FE)
  2)JM-4362 As a Jury officer I need to be able to confirm a jurors attendance (FE)

  @JurorTransformationWIP @newSchemaConverted @JM-5811
  Scenario Outline: Happy Path Test to create a new pool of jurors and change a jurors attendance date

    Given I am on "Bureau" "test"
    When a new pool with "3" responded jurors is inserted for court "415" with owner "415" and attendance date of today new schema
    And I log in as "<user>"
    And I navigate to the pool request screen
    And I click on active pools
    And I click on the "Search" link
    And I set "Pool number" to "<pool_no>"
    And I press the "Continue" button
    And I check the juror "<juror_number>" checkbox
    And I press the "Change next due at court" button
    And I enter a date "4" mondays in the future for the next due at court
    And I press the "Continue" button
    Then I verify confirmation text of jurors next due to attend "1 jurors will be next due to attend on:" on the page
    And I verify button "Continue" on the page

    Examples:
      |user       |juror_number   | pool_no   |
      |MODTESTCOURT |041500010      | 415333333 |


  @JurorTransformationWIP @newSchemaConverted @JM-5791 @5874
  Scenario Outline: Happy Path Test to create a new pool of jurors and confirm jurors attendance date

    #needs to go into single threaded

    Given I am on "Bureau" "test"
    And I Confirm all the data in the record attendance table is cleared
    When a new pool with "3" responded jurors is inserted for court "415" with owner "415" and attendance date of today new schema
    And I log in as "<user>"
    And I press the "Apps" button
    And I click on the "Juror management" link
    And I click on the "Record attendance" link
    Then I see "Record attendance" on the page
    And I see "UNCONFIRMED" on the page
    And I see "Check in" on the page
    And I see "Check out" on the page
    When I check the "Check in" checkbox
    And I set the radio button to "Check in"
    And I set "Hour" to "09"
    And I set "Minute" to "00"
    And I set the radio button to "am"
    And I input juror "<juror_number>" to be checked in
    And I press the "Check in juror" button
    Then I see "9:00am" in the same row as "<juror_number>"

    #Tap 'Record time’ from jurors search results
    And I refresh the page
    When I click on "Record time" in the same row as "<juror_number>"
    And I set "Hour" to "08"
    And I set "Minute" to "00"
    And I select the checkout radio button to "pm"
    And I press the "Check out juror" button
    Then I see "<juror_number>" in the same row as "8:00pm"
    And I am able to see and interact with the Record attendance tabs and fields
   #Tap check out for single juror

    When I set the radio button to "Check out"
    And I set "Hour" to "09"
    And I set "Minute" to "00"
    And I select the checkout radio button to "pm"
    And I input juror "<juror_number>" to be checked out
    And I press the "Check out juror" button
   # Then I see "<juror_number>" in the same row as "9:00pm"

   # press checkout all jurors
    #Below step will fail due to defect-JM-5860

    When I set the radio button to "Check out"
    And I set "Hour" to "10"
    And I set "Minute" to "00"
    And I set the radio button to "pm"
    And I input juror "<juror_number>" to be checked out
    And I press the "Check out all juror" button
    #And I see "<juror_number>" in the same row as "10:00pm"

   #  change button to change the check in and check out time of a juror
    When I click on "Change time" in the same row as "<juror_number>"
    And I set "check in" "Hour" to "1l"
    And I set "check in" "Minute" to "30"
    And I set the radio button to "am"
    And I set "check out" "Hour" to "7"
    And I set "check out" "Minute" to "00"
    And I set the radio button to "pm"
    And I press the "Save changes" button
    Then I see "11:30pm" in the same row as "<juror_number>"
    And I see "7:00am" in the same row as "<juror_number>"
    #confirm all attendences
    When I press the "Confirm all attendences" button
    And I press the "Confirm attendance list is correct" button
    Then I see "CONFIRMED" on the page

    Examples:
      |user       |juror_number   | pool_number   |
      |MODTESTCOURT |041500010      | 415333333     |

  @JurorTransformationWIP @newSchemaConverted @JM-5791 @JM-5883 @JM-5874
  Scenario Outline: create a new pool of jurors and verify attendance date for panel members

    Given I am on "Bureau" "test"
    When a new pool with "3" responded jurors is inserted for court "415" with owner "415" and attendance date of today new schema
    And I log in as "<user>"
    And I press the "Apps" button
    And I click on the "Juror management" link
    And I click on the "Record attendance" link
    Then I see "Record attendance" on the page
    # Verify the result for panel members
    When I set the radio button to "Check in"
    And I set "Hour" to "09"
    And I set "Minute" to "00"
    And I set the radio button to "am"
    And I input juror "<juror_number>" to be checked in
    And I press the "Check in juror" button
    Then I see "9:00am" in the same row as "<juror_number>"
    When I set the radio button to "Check out"
    And I set "Hour" to "10"
    And I set "Minute" to "00"
    And I set the radio button to "pm"
    And I input juror "<juror_number>" to be checked out
    #Test will fail due to defect JM-5883 JM-5874
    And I press the "Check out juror" button
    Then I see "Do you want to check out panelled jurors too" on the page

    Examples:
      |user       |juror_number   | pool_number   |
      |MODTESTCOURT |041500393      | 415333333     |

