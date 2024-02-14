Feature: JM-5066 - As a SJO I need to approve a manually created juror

  @JurorTransformationMulti @NewSchemaConverted
  Scenario Outline: Approve Manually created juror as a senior jury officer

    Given I am on "Bureau" "test"
    And I log in as "<user>"
    And I click on the "Juror management" link
    And I press the "Create juror record" button
    And I set the radio button to "Create a pool to add the juror to"
    And I press the "Continue" button

    #create pool
    And I see "Create a pool for court use only" on the page
    And I set the "Service start date for new pool" date to a Monday "10" weeks in the future
    And I set the radio button to "Crown court"
    And I press the "Continue" button
    And I see "Check pool details" on the page
    And I press the "Create active pool" button

    #jurors name
    And I see "What's the juror's name?" on the page
    And I set "Title (optional)" to "Mr"
    And I set "First name" to "John"
    And I set "Last name" to "Doe"
    And I press the "Continue" button

    #dob
    And I see "What's their date of birth?" on the page
    And I set "Date of birth" to "08/05/1982"
    And I press the "Continue" button

    #address
    And I see "What's the juror's address?" on the page
    And I set "Address line 1" to "5 Testing Street"
    And I set "Town or city" to "London"
    And I set "Postcode" to "CH1 2AN"
    And I press the "Continue" button

    #contact details
    And I see "Enter their contact details" on the page
    And I set "Main phone - UK only (optional)" to "07739967653"
    And I press the "Continue" button

    #notes
    And I see "Notes (optional)" on the page
    And I enter "Note testing" in the Notes text box
    And I press the "Continue" button
    And I see "Check your answers" on the page

    #create juror record
    And I press the "Create juror record" button
    And I see "Draft juror record created for John Doe - senior jury officer will need to approve this" on the page
    Given I am on "Bureau" "test"
    And I log in as "SJOUSER"
    And I see senior jury officer notification banner
    And I click on the jurors to approve link from the sjo notification
    And I see "Approve jurors" on the page
    And I click on "Pending approval" in the same row as "Doe"
    And I see "Approve or reject pending juror" on the page
    And I set the radio button to "Approve"
    And I press the "Confirm" button
    And I see "Pending juror approved" on the page

    Examples:
      |user			|
      |MODTESTCOURT |

  @JurorTransformationMulti @NewSchemaConverted
  Scenario Outline: Reject Manually created juror as a senior jury officer
    Given I am on "Bureau" "test"
    And I log in as "<user>"

    And I click on the "Juror management" link
    And I press the "Create juror record" button
    And I set the radio button to "Create a pool to add the juror to"
    And I press the "Continue" button

    #create pool
    And I see "Create a pool for court use only" on the page
    And I set the "Service start date for new pool" date to a Monday "10" weeks in the future
    And I set the radio button to "Crown court"
    And I press the "Continue" button
    And I see "Check pool details" on the page
    And I press the "Create active pool" button

    #jurors name
    And I see "What's the juror's name?" on the page
    And I set "Title (optional)" to "Mrs"
    And I set "First name" to "Jane"
    And I set "Last name" to "Smith"
    And I press the "Continue" button

    #dob
    And I see "What's their date of birth?" on the page
    And I set "Date of birth" to "08/05/1982"
    And I press the "Continue" button

    #address
    And I see "What's the juror's address?" on the page
    And I set "Address line 1" to "5 Testing Street"
    And I set "Town or city" to "London"
    And I set "Postcode" to "CH1 2AN"
    And I press the "Continue" button

    #contact details
    And I see "Enter their contact details" on the page
    And I set "Main phone - UK only (optional)" to "07739967653"
    And I press the "Continue" button

    #notes
    And I see "Notes (optional)" on the page
    And I enter "Note testing" in the Notes text box
    And I press the "Continue" button
    And I see "Check your answers" on the page
    And I press the "Create juror record" button
    And I see "Draft juror record created for Jane Smith - senior jury officer will need to approve this" on the page

    #login as SJOUSER
    Given I am on "Bureau" "test"
    And I log in as "SJOUSER"
    And I see senior jury officer notification banner
    And I click on the jurors to approve link from the sjo notification
    And I see "Approve jurors" on the page
    And I click on "Pending approval" in the same row as "Smith"
    And I see "Approve or reject pending juror" on the page
    And I press the "Confirm" button
    And I see error "Select whether you want to approve or reject this pending juror"

    #reject juror
    And I set the radio button to "Reject"
    And I press the "Confirm" button
    And I see "You must enter a comment about why you rejected this pending juror" in the error banner
    And I comment "Juror wasn't ready" as reason for my rejection of juror
    And I press the "Confirm" button
    And I see "Pending juror rejected" on the page

    Examples:
      |user			|
      |MODTESTCOURT |


  @JurorTransformationMulti @NewSchemaConverted
  Scenario Outline: Create juror at a different court to senior jury officer

    Given I am on "Bureau" "test"
    And I log in as "<user>"
    And I click on the "Juror management" link
    And I press the "Create juror record" button
    And I set the radio button to "Create a pool to add the juror to"
    And I press the "Continue" button

    #create pool for court 415
    And I see "Create a pool for court use only" on the page
    And I set the "Service start date for new pool" date to a Monday "10" weeks in the future
    And I set the radio button to "Crown court"
    And I press the "Continue" button
    And I see "Check pool details" on the page
    And I press the "Create active pool" button

    #jurors name
    And I see "What's the juror's name?" on the page
    And I set "Title (optional)" to "Mr"
    And I set "First name" to "John"
    And I set "Last name" to "Doe"
    And I press the "Continue" button

    #dob
    And I see "What's their date of birth?" on the page
    And I set "Date of birth" to "08/05/1982"
    And I press the "Continue" button

    #address
    And I see "What's the juror's address?" on the page
    And I set "Address line 1" to "5 Testing Street"
    And I set "Town or city" to "London"
    And I set "Postcode" to "CH1 2AN"
    And I press the "Continue" button

    #contact details
    And I see "Enter their contact details" on the page
    And I set "Main phone - UK only (optional)" to "07739967653"
    And I press the "Continue" button

    #notes
    And I see "Notes (optional)" on the page
    And I enter "Note testing" in the Notes text box
    And I press the "Continue" button
    And I see "Check your answers" on the page

    #create juror record for juror at court 415
    And I press the "Create juror record" button
    And I see "Draft juror record created for John Doe - senior jury officer will need to approve this" on the page

    #login with SJO user who is assigned to 416 court
    Given I am on "Bureau" "test"
    And I log in as "SJOUSER1"
    And I do not see the senior jury officer notification banner

    And I click on the "Apps" link
    And I click on the "Juror management" link
    And I see "Approve jurors" on the page
    And I see "There are no pending jurors to approve" on the page

    Examples:
      |user			|
      |MODTESTCOURT |