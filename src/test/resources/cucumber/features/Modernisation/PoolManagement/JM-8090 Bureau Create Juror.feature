Feature: Bureau Create Juror Record

  @JurorTransformationMulti
  Scenario: Bureau switch off create juror peermissions

    Given I am on "Bureau" "ithc"
    And I log in as "MODTESTBUREAU"

#    switch off permissions
#  Log in as user
#  check I cant see create juror record

  @JurorTransformation
  Scenario: Bureau user without create juror permissions

    Given I am on "Bureau" "ithc"
    And I log in as "<user>"

    And I click on the "Juror management" link
    And I do not see "Create juror record" on the page

  @JurorTransformationMulti
  Scenario Outline: Bureau Create Juror Record with a DOB

    Given I am on "Bureau" "ithc"
    And I log in as "<user>"

    And I click on the "Juror management" link
    And I press the "Create juror record" button

    And I select one of the active pools available from the create juror record screen
    And I press the "Continue" button

    #jurors name
    And I see "What's the juror's name?" on the page
    And I set "Title (optional)" to "Mr"
    And I set "First name" to "John"
    And I set "Last name" to "Stark"
    And I press the "Continue" button

    #dob/error check
    And I see "What's their date of birth?" on the page
    And I press the "Continue" button
    And I see error "Enter their date of birth"

    And I set "Date of birth" to "08/05/2050"
    And I press the "Continue" button
    And I see error "Date of birth must be in the past"

    And I set "Date of birth" to "08/13/1985"
    And I press the "Continue" button
    And I see error "Enter a real date of birth"

    And I set "Date of birth" to "1980/01/29"
    And I press the "Continue" button
    And I see error "Enter a date of birth in the correct format, for example, 31/01/1980"

    And I set "Date of birth" to "08/05/1992"
    And I press the "Continue" button

    #address/error check
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

    #change name
    And I click on the "Change" link in the same row as "Name" on Check your answers
    And I see "What's the juror's name?" on the page
    And I set "First name" to "Tony"
    And I press the "Continue" button
    And I click on the "Change" link in the same row as "Main phone" on Check your answers
    And I click on the "Cancel" link

    #create juror record
    And I press the "Create juror record" button
    And I see "Draft juror record created for Tony Stark - senior jury officer will need to approve this" on the page

    #trigger summons
    And I see the juror status on the juror record screen is "Summoned"
#    and i trigger the summons somehow
#    and I check the DB to ensure the summons is generated

    Examples:
      |user			|
      |MODTESTBUREAU|



  @JurorTransformationMulti
  Scenario Outline: Bureau Create Juror Record via existing pool - Happy Path

    Given I am on "Bureau" "ithc"
    And I log in as "<user>"

    And I click on the "Juror management" link
    And I press the "Create juror record" button

    And I select one of the active pools available from the create juror record screen
    And I press the "Continue" button

    #jurors name
    And I see "What's the juror's name?" on the page
    And I set "Title (optional)" to "Mr"
    And I set "First name" to "John"
    And I set "Last name" to "Doe"
    And I press the "Continue" button

    #no dob
    And I see "What's their date of birth?" on the page
#    And I set "Date of birth" to "08/05/1982"
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


    Examples:
      |user			 |
      |MODTESTBUREAU |

  @JurorTransformationMulti
  Scenario Outline: Bureau Create Juror Record via existing pool - Unhappy Path

    Given I am on "Bureau" "ithc"
    And I log in as "<user>"

    And I click on the "Juror management" link
    And I press the "Create juror record" button

    And I select one of the active pools available from the create juror record screen
    And I press the "Continue" button

    #jurors name/error check
    And I see "What's the juror's name?" on the page
    And I press the "Continue" button
    And I see error "Enter a first name"
    And I see error "Enter a last name"
    And I set "First name" to "TonyTestingTesterTwentyCharacters"
    And I set "Last name" to "JaneTestingTesterTwentyCharacters"
    And I press the "Continue" button
    And I see error "First name cannot contain more than 20 characters"
    And I see error "Last name cannot contain more than 20 characters"
    And I set "Title (optional)" to "Mr"
    And I set "First name" to "John"
    And I set "Last name" to "Stark"
    And I press the "Continue" button

    #no dob/error check
    And I see "What's their date of birth?" on the page
#    And I press the "Continue" button
#    And I see error "Enter their date of birth"
#
#    And I set "Date of birth" to "08/05/2050"
#    And I press the "Continue" button
#    And I see error "Date of birth must be in the past"
#
#    And I set "Date of birth" to "08/13/1985"
#    And I press the "Continue" button
#    And I see error "Enter a real date of birth"
#
#    And I set "Date of birth" to "1980/01/29"
#    And I press the "Continue" button
#    And I see error "Enter a date of birth in the correct format, for example, 31/01/1980"
#
#    And I set "Date of birth" to "08/05/1992"
    And I press the "Continue" button

    #address/error check
    And I see "What's the juror's address?" on the page
    And I press the "Continue" button
    And I see error "Enter address line 1"
    And I see error "Enter a town or city"
    And I see error "Enter a postcode"
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

     #change name
    And I click on the "Change" link in the same row as "Name" on Check your answers
    And I see "What's the juror's name?" on the page
    And I set "First name" to "Tony"
    And I press the "Continue" button
    And I click on the "Change" link in the same row as "Main phone" on Check your answers
    And I click on the "Cancel" link


    #create juror record
    And I press the "Create juror record" button
    And I see "Draft juror record created for Tony Stark - senior jury officer will need to approve this" on the page

    Examples:
      |user			|
      |MODTESTBUREAU|


  @JurorTransformationMulti
  Scenario Outline: Bureau Create Juror Record via existing pool for juror too old

    Given I am on "Bureau" "ithc"
    And I log in as "<user>"

    And I click on the "Juror management" link
    And I press the "Create juror record" button

    And I select one of the active pools available from the create juror record screen
    And I press the "Continue" button

    #jurors name/error check
    And I see "What's the juror's name?" on the page
    And I press the "Continue" button
    And I see error "Enter a first name"
    And I see error "Enter a last name"
    And I set "Title (optional)" to "Mr"
    And I set "First name" to "John"
    And I set "Last name" to "Doe"
    And I press the "Continue" button

    #no dob/error check

    And I see "What's their date of birth?" on the page
#    And I set "Date of birth" to "01/01/1912"
#    And I press the "Continue" button
#    And I see "Check the date of birth" on the page
#    And I see "You entered the juror's date of birth as 01 January 1912." on the page
#    And I set the radio button to "Yes - you will not be able to continue creating a record for this juror"
    And I press the "Continue" button
    And I see "Manage jurors" on the page

    Examples:
      |user			 |
      |MODTESTBUREAU |

  @JurorTransformationMulti
  Scenario Outline: Bureau Create Juror Record via existing pool for juror too young

    Given I am on "Bureau" "ithc"
    And I log in as "<user>"

    And I click on the "Juror management" link
    And I press the "Create juror record" button

    And I select one of the active pools available from the create juror record screen
    And I press the "Continue" button

    #jurors name/error check
    And I see "What's the juror's name?" on the page
    And I press the "Continue" button
    And I see error "Enter a first name"
    And I see error "Enter a last name"
    And I set "Title (optional)" to "Mr"
    And I set "First name" to "John"
    And I set "Last name" to "Doe"
    And I press the "Continue" button

    #no dob/error check

    And I see "What's their date of birth?" on the page
#    And I set "Date of birth" to "01/01/2019"
#    And I press the "Continue" button
#    And I see "Check the date of birth" on the page
#    And I see "You entered the juror's date of birth as 01 January 2019." on the page
#    And I set the radio button to "Yes - you will not be able to continue creating a record for this juror"
    And I press the "Continue" button
    And I see "Manage jurors" on the page

    Examples:
      |user			 |
      |MODTESTBUREAU |

  @JurorTransformationMulti
  Scenario Outline: Bureau Create Juror Record via Create new pool

    Given I am on "Bureau" "ithc"
    And I log in as "<user>"

    And I click on the "Juror management" link
    And I press the "Create juror record" button
    And I press the "Continue" button
    And I see error "Select an option - create a new pool or add juror to an existing pool"
    And I set the radio button to "Create a pool to add the juror to"
    And I press the "Continue" button

    #create pool/error checks
    And I see "Create a pool for court use only" on the page
    And I press the "Continue" button
    And I see error "Enter a service start date"
    And I see error "Select the type of pool"
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

    #no dob
    And I see "What's their date of birth?" on the page
#    And I set "Date of birth" to "08/05/1982"
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

    Examples:
      |user			 |
      |MODTESTBUREAU |

  @JurorTransformationMulti
  Scenario Outline: Bureau Create Juror Record for juror outside of any court catchment area

    Given I am on "Bureau" "ithc"
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
    And I set "First name" to "Edward"
    And I set "Last name" to "Stevens"
    And I press the "Continue" button

    #no dob
    And I see "What's their date of birth?" on the page
#    And I set "Date of birth" to "08/05/1982"
    And I press the "Continue" button

    #address
    And I see "What's the juror's address?" on the page
    And I set "Address line 1" to "5 Testing Street"
    And I set "Town or city" to "London"
    And I set "Postcode" to "RG10 9AG"
    And I press the "Continue" button

    #catchment area check
    And I see "Juror's postcode is not in any court catchment area" on the page
    And I press the "Create juror record anyway" button

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
    And I see "Draft juror record created for Edward Stevens - senior jury officer will need to approve this" on the page

    Examples:
      |user			 |
      |MODTESTBUREAU |

  @JurorTransformationMulti
  Scenario Outline: Bureau Juror record shows manually created juror

    Given I am on "Bureau" "ithc"
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
    And I set "Last name" to "ManualSummon"
    And I press the "Continue" button

  #no dob
    And I see "What's their date of birth?" on the page
#    And I set "Date of birth" to "08/05/1982"
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
    And I see "Draft juror record created for John ManualSummon - senior jury officer will need to approve this" on the page

   #Approve Juror and check summons reply
    Given I am on "Bureau" "test"
    And I log in as "SJOUSER"
    And I see senior jury officer notification banner
    And I click on the jurors to approve link from the sjo notification
    And I see "Approve jurors" on the page
    And I click on "Pending approval" in the same row as "Manualsummon"
    And I see "Approve or reject pending juror" on the page
    When I approve juror and search record
    And I click on the Summons Reply tab
    Then I see "Juror was summoned in person" on the page

    Examples:
      |user          |
      |MODTESTBUREAU |


  @JurorTransformationMulti
  Scenario Outline: Bureau Create Juror Record via existing pool - Happy Path - Satellite Court

    Given I am on "Bureau" "ithc"
    And I log in as "<user>"

    And I click on the "Juror management" link
    And I press the "Create juror record" button

    And I select one of the active pools available from the create juror record screen
    And I press the "Continue" button

    #jurors name
    And I see "What's the juror's name?" on the page
    And I set "Title (optional)" to "Mr"
    And I set "First name" to "Testing"
    And I set "Last name" to "Edwards"
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
    And I see "Draft juror record created for Testing Edwards - senior jury officer will need to approve this" on the page

    Given I am on "Bureau" "ithc"
    And I log in as "SJOUSER"
    And I see senior jury officer notification banner


    Examples:
      |user			 |
      |MODTESTBUREAU |



  # i dont think any of these will be required as I dont think they will need to be approved

#Feature: JM-5066 - As a SJO I need to approve a manually created juror
#
#  @JurorTransformationMulti @NewSchemaConverted
#  Scenario Outline: Approve Manually created juror as a senior jury officer
#
#    Given I am on "Bureau" "test"
#    And I log in as "<user>"
#    And I click on the "Juror management" link
#    And I press the "Create juror record" button
#    And I set the radio button to "Create a pool to add the juror to"
#    And I press the "Continue" button
#
#    #create pool
#    And I see "Create a pool for court use only" on the page
#    And I set the "Service start date for new pool" date to a Monday "10" weeks in the future
#    And I set the radio button to "Crown court"
#    And I press the "Continue" button
#    And I see "Check pool details" on the page
#    And I press the "Create active pool" button
#
#    #jurors name
#    And I see "What's the juror's name?" on the page
#    And I set "Title (optional)" to "Mr"
#    And I set "First name" to "John"
#    And I set "Last name" to "Doe"
#    And I press the "Continue" button
#
#    #dob
#    And I see "What's their date of birth?" on the page
#    And I set "Date of birth" to "08/05/1982"
#    And I press the "Continue" button
#
#    #address
#    And I see "What's the juror's address?" on the page
#    And I set "Address line 1" to "5 Testing Street"
#    And I set "Town or city" to "London"
#    And I set "Postcode" to "CH1 2AN"
#    And I press the "Continue" button
#
#    #contact details
#    And I see "Enter their contact details" on the page
#    And I set "Main phone - UK only (optional)" to "07739967653"
#    And I press the "Continue" button
#
#    #notes
#    And I see "Notes (optional)" on the page
#    And I enter "Note testing" in the Notes text box
#    And I press the "Continue" button
#    And I see "Check your answers" on the page
#
#    #create juror record
#    And I press the "Create juror record" button
#    And I see "Draft juror record created for John Doe - senior jury officer will need to approve this" on the page
#    Given I am on "Bureau" "test"
#    And I log in as "SJOUSER"
#    And I see senior jury officer notification banner
#    And I click on the jurors to approve link from the sjo notification
#    And I see "Approve jurors" on the page
#    And I click on "Pending approval" in the same row as "Doe"
#    And I see "Approve or reject pending juror" on the page
#    And I set the radio button to "Approve"
#    And I press the "Confirm" button
#    And I see "Pending juror approved" on the page
#
#    Examples:
#      |user			|
#      |MODTESTCOURT |
#
#  @JurorTransformationMulti @NewSchemaConverted
#  Scenario Outline: Reject Manually created juror as a senior jury officer
#    Given I am on "Bureau" "test"
#    And I log in as "<user>"
#
#    And I click on the "Juror management" link
#    And I press the "Create juror record" button
#    And I set the radio button to "Create a pool to add the juror to"
#    And I press the "Continue" button
#
#    #create pool
#    And I see "Create a pool for court use only" on the page
#    And I set the "Service start date for new pool" date to a Monday "10" weeks in the future
#    And I set the radio button to "Crown court"
#    And I press the "Continue" button
#    And I see "Check pool details" on the page
#    And I press the "Create active pool" button
#
#    #jurors name
#    And I see "What's the juror's name?" on the page
#    And I set "Title (optional)" to "Mrs"
#    And I set "First name" to "Jane"
#    And I set "Last name" to "Smith"
#    And I press the "Continue" button
#
#    #dob
#    And I see "What's their date of birth?" on the page
#    And I set "Date of birth" to "08/05/1982"
#    And I press the "Continue" button
#
#    #address
#    And I see "What's the juror's address?" on the page
#    And I set "Address line 1" to "5 Testing Street"
#    And I set "Town or city" to "London"
#    And I set "Postcode" to "CH1 2AN"
#    And I press the "Continue" button
#
#    #contact details
#    And I see "Enter their contact details" on the page
#    And I set "Main phone - UK only (optional)" to "07739967653"
#    And I press the "Continue" button
#
#    #notes
#    And I see "Notes (optional)" on the page
#    And I enter "Note testing" in the Notes text box
#    And I press the "Continue" button
#    And I see "Check your answers" on the page
#    And I press the "Create juror record" button
#    And I see "Draft juror record created for Jane Smith - senior jury officer will need to approve this" on the page
#
#    #login as SJOUSER
#    Given I am on "Bureau" "test"
#    And I log in as "SJOUSER"
#    And I see senior jury officer notification banner
#    And I click on the jurors to approve link from the sjo notification
#    And I see "Approve jurors" on the page
#    And I click on "Pending approval" in the same row as "Smith"
#    And I see "Approve or reject pending juror" on the page
#    And I press the "Confirm" button
#    And I see error "Select whether you want to approve or reject this pending juror"
#
#    #reject juror
#    And I set the radio button to "Reject"
#    And I press the "Confirm" button
#    And I see "You must enter a comment about why you rejected this pending juror" in the error banner
#    And I comment "Juror wasn't ready" as reason for my rejection of juror
#    And I press the "Confirm" button
#    And I see "Pending juror rejected" on the page
#
#    Examples:
#      |user			|
#      |MODTESTCOURT |
#
#
#  @JurorTransformationMulti @NewSchemaConverted
#  Scenario Outline: Create juror at a different court to senior jury officer
#
#    Given I am on "Bureau" "test"
#    And I log in as "<user>"
#    And I click on the "Juror management" link
#    And I press the "Create juror record" button
#    And I set the radio button to "Create a pool to add the juror to"
#    And I press the "Continue" button
#
#    #create pool for court 415
#    And I see "Create a pool for court use only" on the page
#    And I set the "Service start date for new pool" date to a Monday "10" weeks in the future
#    And I set the radio button to "Crown court"
#    And I press the "Continue" button
#    And I see "Check pool details" on the page
#    And I press the "Create active pool" button
#
#    #jurors name
#    And I see "What's the juror's name?" on the page
#    And I set "Title (optional)" to "Mr"
#    And I set "First name" to "John"
#    And I set "Last name" to "Doe"
#    And I press the "Continue" button
#
#    #dob
#    And I see "What's their date of birth?" on the page
#    And I set "Date of birth" to "08/05/1982"
#    And I press the "Continue" button
#
#    #address
#    And I see "What's the juror's address?" on the page
#    And I set "Address line 1" to "5 Testing Street"
#    And I set "Town or city" to "London"
#    And I set "Postcode" to "CH1 2AN"
#    And I press the "Continue" button
#
#    #contact details
#    And I see "Enter their contact details" on the page
#    And I set "Main phone - UK only (optional)" to "07739967653"
#    And I press the "Continue" button
#
#    #notes
#    And I see "Notes (optional)" on the page
#    And I enter "Note testing" in the Notes text box
#    And I press the "Continue" button
#    And I see "Check your answers" on the page
#
#    #create juror record for juror at court 415
#    And I press the "Create juror record" button
#    And I see "Draft juror record created for John Doe - senior jury officer will need to approve this" on the page
#
#    #login with SJO user who is assigned to 416 court
#    Given I am on "Bureau" "test"
#    And I log in as "SJOUSER1"
#    And I do not see the senior jury officer notification banner
#
#    And I click on the "Apps" link
#    And I click on the "Juror management" link
#    And I see "Approve jurors" on the page
#    And I see "There are no pending jurors to approve" on the page
#
#    Examples:
#      |user			|
#      |MODTESTCOURT |