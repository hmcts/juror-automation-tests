Feature: JM-3770

  @JurorTransformationMulti @NewSchemaConverted
  Scenario Outline: Disqualify Juror because of Residency reasons - Paper

    Given I am on "Bureau" "test"

    And I log in as "<user>"

    Given the juror numbers have not been processed new schema
      |part_no 	|pool_no 	|owner	|
      |<part_no>|<pool_no>	|400 	|

    Given "<juror_number>" has "NEXT_DATE" as "5 mondays time" new schema

    When the user searches for juror record "<juror_number>" from the global search bar

    #record paper summons response
    And I click the Enter summons reply button
    Then the juror details form is displayed

    #juror details
    When I fill in all of the juror details for the summons reply
    And I click continue on the juror summons reply page

    #eligibility
    Then the juror summons reply eligibility page is displayed

    #When I answer the juror summons reply eligibility questions
    When I answer the juror summons reply eligibility questions with juror Residency set to No
    And I click continue on the juror summons reply page

    #can attend on date
    Then the juror summons reply types page is displayed
    When I set the radio button to "Can serve on date shown in summons"
    And I click continue on the juror summons reply page

    #cjs
    Then the juror summons reply CJS employment page is displayed
    When I select that the juror has not worked in the criminal justice system
    And I click continue on the juror summons reply page

    #reasonable adjustments
    Then the juror summons reply reasonable adjustments page is displayed
    When I select that the juror does not need adjustments
    And I click continue on the juror summons reply page

    #confirm/sign
    Then the juror summons reply Signature page is displayed
    When I select that the summons reply has been signed
    And I click done on the juror summons reply page
    And I see "Summons replies" on the page

    And I press the "Process reply" button
    And I set the radio button to "Disqualify"
    And I press the "Continue" button

    And I set the radio button to "R - Residency"
    And I press the "Continue" button
    And I see "Summons reply for 641500575 FNAMEFIVESEVENFIVE LNAMEFIVESEVENFIVE successfully processed: Disqualified (Residency)" on the page

    Examples:
      |part_no	| pool_no   | user         |
      |641500575| 415170402 |MODTESTBUREAU |

  @JurorTransformationWIP @NewSchemaConverted @JurorDigitalNotConverted
  Scenario Outline: Disqualify Juror because of Residency reasons - Digital

    Given I am on "Public" "test"

    Given the juror numbers have not been processed new schema
      |part_no 	|pool_no 	|owner	|
      |<part_no>|<pool_no>	|400 	|

    Given "<juror_number>" has "NEXT_DATE" as "5 mondays time" new schema

	# Submit response in pool
    Given I have submitted a first party English ineligibilty response
      |part_no	    |pool_number|last_name		|postcode	|email 	|
      |<part_no>	|<pool_no>	|<last_name>	|<postcode>	|e@mail.com|

    #log on
    Given I am on "Bureau" "test"
    And I log in as "<user>"

    #search for response
    And I click on the "Search" link
    And I set "Juror number" to "<juror_number>"
    And I press the "Search" button
    When I click on "<juror_number>" in the same row as "<juror_number>"

	#check options/Disqualify juror
    And I press the "Process reply" button
    And I set the radio button to "Disqualify"
    And I click on the "Cancel" link
    And I press the "Process reply" button
    And I press the "Continue" button
    And I see error "Please select a response process type"
    And I set the radio button to "Disqualify"
    And I press the "Continue" button
    And I press the "Continue" button
    And I see error "Select the reason why you're disqualifying this juror"

    And I set the radio button to "R - Residency"
    And I press the "Continue" button
    And I see "Summons reply for 641500960 FNAMENINESIXZERO LNAMENINESIXZERO successfully processed: Disqualified (Residency)" on the page
    And I see "Your work" on the page

    Examples:
      |part_no	| user          | pool_no  |last_name         | postcode|
      |641500960| MODTESTBUREAU | 415170402| LNAMENINESIXZERO | CH1 2AN |
