Feature: ELEC Mark LA as Inactive

@elecRegManagement
Scenario Outline: Mark LA as Inactive
  
  Given I am on "Bureau" "test"
  And I log in as "<user>"

  And I press the "Apps" button
  And I click on the "Electoral register" link
  
  When I filter on Local Authority "<localAuth>"
  Then the Local Authority returned in the results matches "<localAuth>"
  
  When I click on the "<localAuth>" link
  Then I see link with text "Mark as inactive"
  
  When I click on the "Mark as inactive" link
  Then I see "Mark authority as inactive" on the page

  #no reason entered
  When I press the "Mark as inactive" button
  Then I see error "Enter a reason for deactivating the local authority"
  
  When I set text area with "id" of "inactiveReason" to "some reasons here"
  And I press the "Mark as inactive" button
  Then I see "Authority marked as inactive" on the page
  And I see link with text "Mark as active"
  
  When I click on the "Back" link
  Then I do not see "<localAuth>" on the page

  When I filter on Local Authority "<localAuth>"
  Then I see "Authority marked as inactive" on the page
  And I see link with text "Mark as active"

  Examples:
    | user          | localAuth |
    | MODTESTBUREAU | Eastleigh |