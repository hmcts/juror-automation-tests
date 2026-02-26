Feature: ELEC Track which LAs have uploaded

@JurorTransformation
Scenario Outline: Track which LAs have uploaded
  
  Given I am on "Bureau" "test"

  #baseline ER local auth data
  Given all ER Local Authorities are set to not uploaded new schema
  Given all ER Local Authorities are set to active new schema
  Given all uploads for Local Authority "<localAuth>" are deleted new schema

  #log in
  And I log in as "<user>"

  #nav to electoral reg management
  And I press the "Apps" button
  And I click on the "Electoral register" link

  #check all elements
  Then I see "/electoral-register" in the URL
  And I see "Dashboard" on the page
  And I check the deadline date shown on screen matches the DB new schema

  Then I see days remaining is calculated correctly according to Deadline Date
  And the number of Not Uploaded on Electoral Register Management dash is correct

  #donut
  And the number Not Uploaded in the donut on Electoral Register Management dash is correct
  And the number of required LAs in the donut matches the number of active LAs
  And the number Uploaded in the donut on Electoral Register Management dash is correct

  And I see link with text "Change deadline for local authorities"
  And I see link with text "Download all authority emails"

  And the radio button "All statuses" is "selected"

  And I check the upload status shown on screen for LA "West Oxfordshire" matches the DB new schema
  And I check the last upload date shown on screen for LA "West Oxfordshire" matches the DB new schema

  And I filter on Local Authority "<localAuth>"
  Then the Local Authority returned in the results matches "<localAuth>"

  And I choose the "Not uploaded" radio button
  Then the Local Authority returned in the results matches "<localAuth>"

  And I choose the "Uploaded" radio button
  Then I see "No local authorities found." on the page

  And I choose the "All statuses" radio button
  Then the Local Authority returned in the results matches "<localAuth>"

  And I press the "Send reminder" button
  And I see error "At least one authority must be selected"

  And I see link with text "<localAuth>"
  And "<localAuth>" Local Authority in the results table has status "Not uploaded"
  And "<localAuth>" Local Authority in the results table has Last Data Upload "-"

  Examples:
  | localAuth   | user          |
  | Bradford    | MODTESTBUREAU |