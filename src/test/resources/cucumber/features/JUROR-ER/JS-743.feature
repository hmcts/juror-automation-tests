Feature: ELEC Deadline Date is passed

@JurorTransformation
Scenario Outline: Check Update window is now closed appears when deadline date is passed
  
  Given I am on "Bureau" "test"

  And I log in as "<user>"

  And I press the "Apps" button
  And I click on the "Electoral register" link

  Given I set ER deadline date to "today" new schema

  When I refresh the page
  Then I see "/electoral-register" in the URL
  And I see "Dashboard" on the page
  And I do not see "Update window is now closed" on the page
  And I do not see "The annual upload window for electoral register data has now closed. Local authorities can no longer upload electoral data." on the page
  And I do not see "To allow uploads, set a new deadline date." on the page

  Given I set ER deadline date to "yesterday" new schema

  When I refresh the page
  Then  I see "Dashboard" on the page
  And I see "Update window is now closed" on the page
  And I see "The annual upload window for electoral register data has now closed. Local authorities can no longer upload electoral data." on the page
  And I see "To allow uploads, set a new deadline date." on the page
  And I do not see link with text "Change deadline for local authorities"
  And I press the "Set a new deadline" button
  Then I see "Set deadline for local authorities" on the page
  And I click on the "Cancel" link
  Then I see "Dashboard" on the page

  Given I set ER deadline date to "30 mondays time" new schema
  When I refresh the page
  Then I see "/electoral-register" in the URL
  And I see "Dashboard" on the page
  And I do not see "Update window is now closed" on the page
  And I do not see "The annual upload window for electoral register data has now closed. Local authorities can no longer upload electoral data." on the page
  And I do not see "To allow uploads, set a new deadline date." on the page

  Examples:
    | user          |
    | MODTESTBUREAU |