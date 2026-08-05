Feature: JS-838

  @JurorTransformation
  Scenario Outline: Summon juror into court on DBD pilot and check summoned juror has been included

    Given I am on "Bureau" "ithc"

    Given a bureau owned pool is created with jurors
      | court |juror_number  | pool_number	| att_date_weeks_in_future	| owner |
      | 431   |<juror_number>| <pool_number>	| 5				        | 400	|

    And I clear all jurors from juror_pool for pool "<pool_number>" apart from juror "<juror_number>"

    And I log in as "MODTESTBUREAU"

    And I press the "Apps" button
    And I click on the "Pool management" link
    And I click on the "Search" link
    And I set "Pool number" to "<pool_number>"
    And I press the "Continue" button

    And I see "<pool_number>" on the page
    And I press the "Summon jurors" button
    And I click the change catchment area link
    And I set "Enter a court name or location code" to "415"
    And I press the "Continue" button
    And I set "Extra citizens to summon" to "1"
    And I press the "Summon more citizens" button
    And I click the juror number link that is not "<juror_number>"
    
    And I see "Juror is part of the digital by default pilot" on the page


    Examples:
      | juror_number	| pool_number	|
      | 043100186		| 431309163     |


  @JurorTransformation
  Scenario Outline: Send summons pack for juror in DBD - automatically and manually

    Given I am on "Bureau" "ithc"

    Given a bureau owned pool is created with jurors
      | court |juror_number  | pool_number	| att_date_weeks_in_future	| owner |
      | 431   |<juror_number>| <pool_number>	| 5				        | 400	|

    And I update "<juror_number>" to set them up for digital by default

    And I log in as "<user>"
    And the user searches for juror record "<juror_number>" from the global search bar
    And I see "Juror is part of the digital by default pilot" on the page
    And I click on the "Juror details" link
    And I click on the "Add or change" link
    And I set the radio button to "Paper"
    And I set "Date of birth" to "02/03/1990"
    And I press the "Save" button
    And I set the radio button to "Leave as Lewes"
    And I press the "Continue" button
    And I see "Communication preferences have been changed to paper" on the page
    And I see "Do you want to send a paper summons pack to the juror?" on the page
    And I set the radio button to "Yes"
    And I press the "Continue" button
    And I see "Paper summons sent" on the page

    And the user searches for juror record "<juror_number>" from the global search bar
    And I click on the "Juror details" link
    And I click on the "Send summons pack" link
    And I see "Are you sure you want to send a paper summons pack?" on the page
    And I see "A paper summons pack will be sent. This action will not send another summons letter." on the page
    And I press the "Yes - send summons pack" button
    And I see "Paper summons sent" on the page

    Examples:
      | juror_number	| pool_number	| user         |
      | 043127146		| 431309864     | MODTESTBUREAU |

  @JurorTransformation
  Scenario Outline: Reassign juror to court not in DBD pilot to remove them from DBD

    Given I am on "Bureau" "ithc"

    Given a bureau owned pool is created with jurors
      | court |juror_number  | pool_number	| att_date_weeks_in_future	| owner |
      | 431   |<juror_number>| <pool_number>	| 5				        | 400	|

    And I update "<juror_number>" to set them up for digital by default

    And I log in as "<user>"
    And the user searches for juror record "<juror_number>" from the global search bar
    And I see "Juror is part of the digital by default pilot" on the page

    And I press the "Update juror record" button
    And I set the radio button to "Reassign to another pool"
    And I press the "Continue" button
    And I click on the "Change court" link
    And I set "Enter a court name or location code" to "457"
    And I press the "Continue" button
    And I select any active pool from the reassign table
    And I press the "Continue" button
    And I see "Juror record updated: Reassigned to pool" on the page

    And the user searches for juror record "<juror_number>" from the global search bar
    And I do not see "Juror is part of the digital by default pilot" on the page

    Examples:
      | juror_number	| pool_number	| user         |
      | 043127188		| 431307764     | MODTESTBUREAU |
