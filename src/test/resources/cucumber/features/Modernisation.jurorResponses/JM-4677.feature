Feature: JM-4677 - As a jury officer I need to create a trial

  @JurorTransformationMulti @NewSchemaConverted
  Scenario Outline: Create a Trial

    Given I am on "Bureau" "test"

    Given I have deleted court rooms for "767"
    Given I have inserted court rooms for "767"

    #log on and search for juror
    And I log in as "<user>" selecting court "415"

    And I press the "Apps" button
    And I click on the "Trial management" link
    And I press the "Create a trial" button
    And I see "Create a trial" on the page
    #error check
    And I press the "Create trial" button
    And I see error "Enter a trial number"
    And I see error "Select whether this is a criminal or civil trial"
    And I see error "Enter a start date for this trial"
    And I see error "Enter the judge’s name"
    And I see error "Select a court where this trial will take place"
    And I set the radio button to "Criminal"
    And I press the "Create trial" button
    And I see error "Enter defendants"

    #Create trial
    And I set "Case number" to "T202141674"
    And I set the radio button to "Criminal"
    And I see "Defendants" on the page
    Then I set the radio button to "Civil"
    And I see "Respondents" on the page
    And I set the radio button to "Criminal"
    And I set "Defendants" to "Defendant"
    And I set the "Start date for Trial" date to a Monday "10" weeks in the future

    And I set "Judge" to "PATRICIA H AITKEN"
    And I set the radio button to "Chester"
    And I see error "Select courtroom from provided list"
    And I set "Courtroom" to "JURY ASSEMBLY ROOM"
    And I press the "Create trial" button

    And I see the following juror information on the Trial details screen
      | Defendants           | Defendant                         |
      | Trial type           | Criminal                          |
      | Judge                | PATRICIA H AITKEN                 |
      | Courtroom            | Jury Assembly Room                |
      | Protected?           | No                                |

    Examples:
      |user			|
      |MODTESTCOURT |


  @JurorTransformationWIP
  Scenario Outline: Create a Trial and Edit Trial

    Given I am on "Bureau" "test"

    #log on and search for juror
    And I log in as "<user>"

    And I press the "Apps" button
    And I click on the "Juror management" link
    And I click on the "Manage trials" link
    And I press the "Create a trial" button
    And I see "Create a trial" on the page
    And I set "Case Number" to "T202341649"
    Then I set the radio button to "Civil"
    And I see "Respondents" on the page
    And I set "Respondents" to "Respondent"
    And I set the "Start date for Trial" date to a Monday "10" weeks in the future

    And I set "Judge" to "PATRICIA H AITKEN"
    And I set "Courtroom" to "JURY ASSEMBLY ROOM"
    And I check the "Protected" checkbox
    And I press the "Create Trial" button
    And I see "Do you want this trial to be protected" on the page
    And I see "All juror names will be anonymous so that their identity can be protected" on the page
    And I press the "Yes-continue" button

    And I see the following juror information on the Trial details screen
      | Respondents          | Respondent                        |
      | Trial type           | Civil                             |
      | Judge                | PATRICIA H AITKEN                 |
      | Courtroom            | Jury Assembly Room                |
      | Protected?           | Yes                               |

    #the edit trial functionality hasn't yet been built. WILL remove WIP tag when complete

    And I press the "Edit trial" button
    And I set "Judge" to "EDWARD MATTHEWS"
    And I press the "Save changes" button

#edited trial
    And I see the following juror information on the Trial details screen
      | Respondents          | Respondent                        |
      | Trial type           | Civil                             |
      | Judge                | EDWARD MATTHEWS                   |
      | Courtroom            | Jury Assembly Room                |
      | Protected?           | Yes                               |


    #check all trials for my trial
    And I press the "Apps" button
    And I click on the "Trial management" link

    And I set the radio button to "Active trials"
    And I see "T202341649" on the page

    Examples:
      |user			|
      |MODTESTCOURT |

  @JurorTransformationWIP @NewSchemaConverted @JM-5793
  Scenario Outline: Create a trial for user with access to multiple courts

    Given I am on "Bureau" "test"

    #log on and search for juror
    And I log in as "<user>"

    And I press the "Apps" button
    And I click on the "Trial management" link
    And I press the "Create a trial" button
    And I see "Create a trial" on the page

    #Create trial
    And I set "Case number" to "T202311519"
    And I set the radio button to "Criminal"
    And I set "Defendants" to "TESTING"
    And I set the "Start date for Trial" date to a Monday "10" weeks in the future

    And I set "Judge" to "PATRICIA H AITKEN"
    And I set the radio button to "Chester"
    And I set "Courtroom" to "JURY ASSEMBLY ROOM"
    And I press the "Create trial" button

    And I see the following juror information on the Trial details screen
      | Defendants           | TESTING                           |
      | Trial type           | Criminal                          |
      | Judge                | PATRICIA H AITKEN                 |
      | Courtroom            | Jury Assembly Room                |
      | Protected?           | No                                |


    And I press the "Apps" button
    And I click on the "Trial management" link
    And I press the "Create a trial" button
    And I see "Create a trial" on the page

    #Create trial
    And I set "Case number" to "T202341272"
    And I set the radio button to "Criminal"
    And I set "Defendants" to "TESTER"
    And I set the "Start date for Trial" date to a Monday "10" weeks in the future
    And I set "Judge" to "EDWARD MATTHEWS"
    #fails due to 5793
    And I set the radio button to "Lewes sitting at chichester"
    And I set "Courtroom" to "COURT ROOM 2"
    And I press the "Create trial" button

    And I see the following juror information on the Trial details screen
      | Defendants           | TESTER                            |
      | Trial type           | Criminal                          |
      | Judge                | EDWARD MATTHEWS                   |
      | Courtroom            | Court Room 2                      |
      | Protected?           | No                                |


    Examples:
      |user			|
      |MODTESTCOURT |