Feature: Bureau Create Juror Record

  @JurorTransformationMulti
  Scenario: Bureau Team Lead switch off create juror permissions

  Given I am on "Bureau" "ithc"

  #disable permissions
  Given I "disable" CREATE_JUROR permission for bureau user "MODTESTBUREAU"

  And I log in as "MODTESTBUREAU"

  # check I cant see create juror record button
  And I navigate to the pool request screen
  And I click on active pools
  And I click on the first pool in Active Pools
  And I do not see "Create juror record" on the page

  #enable permissions
  Given I "enable" CREATE_JUROR permission for bureau user "MODTESTBUREAU"

  @JurorTransformation
  Scenario: Bureau standard user with create juror permissions cannot access create juror button

    Given I am on "Bureau" "ithc"

    #enable permissions
    Given I "enable" CREATE_JUROR permission for bureau user "ARAMIS1"

    And I log in as "ARAMIS1"

  # check I cant see create juror record button
    And I navigate to the pool request screen
    And I click on active pools
    And I click on the first pool in Active Pools
    And I do not see "Create juror record" on the page

    #disable permissions
    Given I "disable" CREATE_JUROR permission for bureau user "ARAMIS1"

  @JurorTransformationMulti
  Scenario: Bureau Create Juror Record with a DOB - validation checks

    Given I am on "Bureau" "ithc"

    #enable permissions
    Given I "enable" CREATE_JUROR permission for bureau user "MODTESTBUREAU"

    And I log in as "MODTESTBUREAU"

    When I navigate to the pool request screen

    #create an active pool request
    And I create an active "Crown" court pool request for court "415", "10" Mondays in the future

    #add jurors
    And I navigate to the pool search screen
    When I enter the pool number of the pool I have just created on the pool search screen
    And I press the "Continue" button

    And I see "Create juror record" on the page
    And I press the "Create juror record" button

    #jurors name
    And I see "What's the juror's name?" on the page
    And I set "Title (optional)" to "Mr"
    And I set "First name" to "John"
    And I set "Last name" to "Stark"
    And I press the "Continue" button

    #dob/error check
    And I see "What's their date of birth?" on the page

    And I set "Date of birth" to "08/05/2050"
    And I press the "Continue" button
    And I see error "Date of birth must be in the past"

    And I set "Date of birth" to "08/13/1985"
    And I press the "Continue" button
    And I see error "Enter a real date of birth"

    And I set "Date of birth" to "1980/01/29"
    And I press the "Continue" button
    And I see error "Enter a date of birth in the correct format, for example, 31/01/1980"

    And I set "Date of birth" to "29.08.88"
    And I press the "Continue" button
    And I see error "Date of birth must only include numbers and forward slashes"

    And I set "Date of birth" to " "
    And I press the "Continue" button
    And I see error "Date of birth must only include numbers and forward slashes"

    And I set "Date of birth" to "29 08 88"
    And I press the "Continue" button
    And I see error "Date of birth must only include numbers and forward slashes"

    And I set "Date of birth" to "1 JUNE 1988"
    And I press the "Continue" button
    And I see error "Date of birth must only include numbers and forward slashes"

    And I set "Date of birth" to "101010"
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
    And I set "Main phone - UK only (optional)" to "07777777777"
    And I press the "Continue" button

    #notes
    And I see "Notes (optional)" on the page
    And I enter "Note testing" in the Notes text box
    And I press the "Continue" button
    And I see "Check your answers" on the page

    #check your answers page
    And I see "08 May 1992" in the same row as "Date of birth"
    And I see "Mr John Stark" in the same row as "Name"
    And I see "5 Testing Street" in the same row as "Address"
    And I see "07777777777" in the same row as "Main phone"
    And I see "-" in the same row as "Alternative phone"
    And I see "-" in the same row as "Email"
    And I see "Note testing" in the same row as "Notes"

    #change name
    And I click on the "Change" link in the same row as "Name" on Check your answers
    And I see "What's the juror's name?" on the page
    And I set "First name" to "Tony"
    And I press the "Continue" button
    And I click on the "Change" link in the same row as "Main phone" on Check your answers
    And I click on the "Cancel" link

    #create juror record
    And I press the "Create juror record" button

    #confirm juror is created and added to pool
    And I see "Juror record created for Tony Stark and summoned to pool" on the page
    And I see pool summoned total count is "2"
    And I see "Summoned" in the same row as "Stark"

    #check the new juror is added
    And I see pool summoned total count is "2"
    And I see "Summoned" in the same row as "Stark"

  @JurorTransformationMulti
  Scenario Outline: Bureau Create Juror Record - validation checks

    Given I am on "Bureau" "ithc"

    #enable permissions
    Given I "enable" CREATE_JUROR permission for bureau user "MODTESTBUREAU"

    And I log in as "MODTESTBUREAU"

    When I navigate to the pool request screen

    #create an active pool request
    And I create an active "Crown" court pool request for court "415", "10" Mondays in the future

    #add jurors
    And I navigate to the pool search screen
    When I enter the pool number of the pool I have just created on the pool search screen
    And I press the "Continue" button

    And I press the "Create juror record" button

    #jurors name
    And I see "What's the juror's name?" on the page
    
    #title
    And I set "Title (optional)" to "Professor-at-large"
    And I set "First name" to "John"
    And I set "Last name" to "Stark"
    And I press the "Continue" button
    And I see error "Title cannot contain more than 10 characters"

    And I set "Title (optional)" to ""

    #first name
    And I set "First name" to ""
    And I press the "Continue" button
    And I see error "Enter a first name"

    And I set "First name" to "aaaaaaaaaaaaaaaaaaaaa"
    And I press the "Continue" button
    And I see error "First name cannot contain more than 20 characters"

    And I set "First name" to "<fname>"

    #last name
    And I set "Last name" to ""
    And I press the "Continue" button
    And I see error "Enter a last name"

    And I set "Last name" to "<lname>"
    And I press the "Continue" button

    #dob - leave blank
    And I press the "Continue" button

    #address/error check
    And I see "What's the juror's address?" on the page
    And I press the "Continue" button

    And I see error "Enter address line 1"
    And I see error "Enter a town or city"
    And I see error "Enter a postcode"

    And I set "Address line 1" to " "
    And I set "Town or city" to " "
    And I set "Postcode" to " "
    And I press the "Continue" button

    And I see error "Enter address line 1"
    And I see error "Enter a town or city"
    And I see error "Enter a postcode"

    And I set "Address line 1" to "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
    And I set "Address line 2 (optional)" to "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
    And I set "Address line 3 (optional)" to "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
    And I set "Town or city" to "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
    And I set "County (optional)" to "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
    And I set "Postcode" to "CH1 2NN"
    And I press the "Continue" button

    And I see error "Address line 1 cannot contain more than 35 characters"
    And I see error "Address line 2 cannot contain more than 35 characters"
    And I see error "Address line 3 cannot contain more than 35 characters"
    And I see error "Town or city cannot contain more than 35 characters"
    And I see error "County cannot contain more than 35 characters"

    And I set "Address line 1" to "<line1>"
    And I set "Address line 2 (optional)" to "<line2>"
    And I set "Address line 3 (optional)" to "<line3>"
    And I set "Town or city" to "<town>"
    And I set "County (optional)" to "<county>"
    And I set "Postcode" to "<postcode>"
    And I press the "Continue" button

    #contact details
    And I see "Enter their contact details" on the page

    And I set "Main phone - UK only (optional)" to " "
    And I set "Alternative phone (optional)" to " "
    And I set "Email (optional)" to " "
    And I press the "Continue" button

    And I see error "Enter a valid main phone number"
    And I see error "Enter a valid alternative phone number"
    And I see error "Enter a valid email address"

    And I set "Main phone - UK only (optional)" to "1111111111111111111111111111111111111111111111111111111111111"
    And I set "Alternative phone (optional)" to "1111111111111111111111111111111111111111111111111111111111111"
    And I set "Email (optional)" to "1111111111111111111111111111111111111111111111111111111111111"
    And I press the "Continue" button

    And I see error "Enter a valid main phone number"
    And I see error "Enter a valid alternative phone number"
    And I see error "Enter a valid email address"

    And I set "Main phone - UK only (optional)" to "no phone"
    And I set "Alternative phone (optional)" to "no phone"
    And I set "Email (optional)" to "no email"
    And I press the "Continue" button

    And I see error "Enter a valid main phone number"
    And I see error "Enter a valid alternative phone number"
    And I see error "Enter a valid email address"

    And I set "Main phone - UK only (optional)" to "<mobile>"
    And I set "Alternative phone (optional)" to "<altphone>"
    And I set "Email (optional)" to "<email>"
    And I press the "Continue" button

    #notes
    And I see "Notes (optional)" on the page

    And I enter "These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are tThese are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are tThese are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are tThese are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are the details. These are t" in the Notes text box
    And I press the "Continue" button

    And I see error "The notes provided are too long"

    And I enter "Note testing" in the Notes text box
    And I press the "Continue" button
    And I see "Check your answers" on the page

    #check your answers page
    And I see "-" in the same row as "Date of birth"
    And I see "<fname> <lname>" in the same row as "Name"
    And I see "<line1>" in the same row as "Address"
    And I see "<line2>" on the page
    And I see "<line3>" on the page
    And I see "<town>" on the page
    And I see "<county>" on the page
    And I see "<postcode>" on the page
    And I see "<mobile>" in the same row as "Main phone"
    And I see "<altphone>" in the same row as "Alternative phone"
    And I see "<email>" in the same row as "Email"
    And I see "<notes>" in the same row as "Notes"

    #change name
    And I click on the "Change" link in the same row as "Name" on Check your answers
    And I see "What's the juror's name?" on the page
    And I set "First name" to "<fname>on"
    And I press the "Continue" button
    And I click on the "Change" link in the same row as "Main phone" on Check your answers
    And I click on the "Cancel" link

    #create juror record
    And I press the "Create juror record" button

    #confirm juror is created and added to pool
    And I see "Juror record created for <fname>on <lname> and summoned to pool" on the page
    And I see pool summoned total count is "2"
    And I see "Summoned" in the same row as "D'oe-smith"

    Examples:
    | fname       | lname       | email       | mobile        | altphone      | postcode  | line1             | line2   | line3   | town    | county  | notes         |
    | J'ohn-James | D'oe-Smith  | e@mail.com  | 07777777777   | 0121-111-1111 | CH1 2NN   | 5 Testing Street  | Line 2  | Line 3  | London  | County  | Note testing  |


  @JurorTransformationMulti
  Scenario: Create juror button not available on POOL REQUESTS

    Given I am on "Bureau" "ithc"

    #enable permissions
    Given I "enable" CREATE_JUROR permission for bureau user "MODTESTBUREAU"

    And I log in as "MODTESTBUREAU"

    When I navigate to the pool request screen

    #create an pool request
    And I create a "Crown" court pool request for court "415"

    #Create juror record button not available
    And I navigate to the pool search screen
    When I enter the pool number of the pool I have just created on the pool search screen
    And I press the "Continue" button

    And I do not see "Create juror record" on the page

  @JurorTransformationMulti
  Scenario Outline: Bureau Create Juror Record age validation - too old

    Given I am on "Bureau" "ithc"

    #enable permissions
    Given I "enable" CREATE_JUROR permission for bureau user "<user>"

    And I log in as "<user>"

    When I navigate to the pool request screen

    #create an active pool request
    And I create an active "Crown" court pool request for court "415", "10" Mondays in the future

    #add jurors
    And I navigate to the pool search screen
    When I enter the pool number of the pool I have just created on the pool search screen
    And I press the "Continue" button

    And I press the "Create juror record" button

    #jurors name
    And I see "What's the juror's name?" on the page
    And I set "First name" to "John"
    And I set "Last name" to "Stark"
    And I press the "Continue" button

    #dob/error check
    And I see "What's their date of birth?" on the page

    When I set the "Date of birth (optional)" single date field to a Monday "-4050" weeks in the future
    And I press the "Continue" button
    And I see "Check the date of birth" on the page
    And I see "years old and ineligible for jury service" on the page
    And I see "Is their date of birth correct?" on the page

    And I press the "Continue" button
    And I see error "Select whether their date of birth is correct or not"

    Then I choose the "No" radio button
    And I press the "Continue" button

    And I see "What's their date of birth?" on the page

    When I set the "Date of birth (optional)" single date field to a Monday "-4050" weeks in the future
    And I press the "Continue" button

    And I see "Is their date of birth correct?" on the page
    Then I choose the "Yes" radio button
    And I press the "Continue" button

    #returned to pool and juror has not been created
    And I see "Jurors in this pool" on the page
    And I see pool summoned total count is "1"

    Examples:
      |user			 |
      |MODTESTBUREAU |


  @JurorTransformationMulti
  Scenario Outline: Bureau Create Juror Record age validation - too young

    Given I am on "Bureau" "ithc"

    #enable permissions
    Given I "enable" CREATE_JUROR permission for bureau user "<user>"

    And I log in as "<user>"

    When I navigate to the pool request screen

    #create an active pool request
    And I create an active "Crown" court pool request for court "415", "10" Mondays in the future

    #add jurors
    And I navigate to the pool search screen
    When I enter the pool number of the pool I have just created on the pool search screen
    And I press the "Continue" button

    And I press the "Create juror record" button

    #jurors name
    And I see "What's the juror's name?" on the page
    And I set "First name" to "John"
    And I set "Last name" to "Stark"
    And I press the "Continue" button

    #dob/error check
    And I see "What's their date of birth?" on the page

    When I set the "Date of birth (optional)" single date field to a Monday "-500" weeks in the future
    And I press the "Continue" button
    And I see "Check the date of birth" on the page
    And I see "years old and ineligible for jury service" on the page
    And I see "Is their date of birth correct?" on the page

    And I press the "Continue" button
    And I see error "Select whether their date of birth is correct or not"

    Then I choose the "No" radio button
    And I press the "Continue" button

    And I see "What's their date of birth?" on the page

    When I set the "Date of birth (optional)" single date field to a Monday "-500" weeks in the future
    And I press the "Continue" button

    And I see "Is their date of birth correct?" on the page
    Then I choose the "Yes" radio button
    And I press the "Continue" button

    #returned to pool and juror has not been created
    And I see "Jurors in this pool" on the page
    And I see pool summoned total count is "1"

    Examples:
      |user			 |
      |MODTESTBUREAU |


  @JurorTransformationMulti
  Scenario Outline: Bureau Create Juror Record for juror outside of any court catchment area

    Given I am on "Bureau" "demo"

    #enable permissions
    Given I "enable" CREATE_JUROR permission for bureau user "<user>"

    And I log in as "<user>"

    When I navigate to the pool request screen

    #create an active pool request
    And I create an active "Crown" court pool request for court "415", "10" Mondays in the future

    #add jurors
    And I navigate to the pool search screen
    When I enter the pool number of the pool I have just created on the pool search screen
    And I press the "Continue" button

    And I press the "Create juror record" button

    #jurors name
    And I see "What's the juror's name?" on the page
    And I set "First name" to "John"
    And I set "Last name" to "Stark"
    And I press the "Continue" button

    #dob - leave blank
    And I see "What's their date of birth?" on the page
    And I press the "Continue" button

    #address/error check
    And I see "What's the juror's address?" on the page
    And I set "Address line 1" to "5 Testing Street"
    And I set "Town or city" to "London"
    And I set "Postcode" to "RX10 9AG"
    And I press the "Continue" button

    #catchment area check
    And I see "Juror's postcode is not in any court catchment area" on the page
    
    And I click on the "Check or change postcode" link
    And I see "What's the juror's address?" on the page

    And I press the "Continue" button

    And I see "Juror's postcode is not in any court catchment area" on the page
    And I press the "Create juror record anyway" button

    #contact details
    And I see "Enter their contact details" on the page
    And I set "Main phone - UK only (optional)" to "07777777777"
    And I press the "Continue" button

    #notes
    And I see "Notes (optional)" on the page
    And I enter "Note testing" in the Notes text box
    And I press the "Continue" button
    And I see "Check your answers" on the page

    #check your answers page
    And I see "-" in the same row as "Date of birth"
    And I see "John Stark" in the same row as "Name"
    And I see "5 Testing Street" in the same row as "Address"
    And I see "RX10 9AG" on the page
    And I see "07777777777" in the same row as "Main phone"
    And I see "-" in the same row as "Alternative phone"
    And I see "-" in the same row as "Email"
    And I see "Note testing" in the same row as "Notes"

    #create juror record
    And I press the "Create juror record" button

    #confirm juror is created and added to pool
    And I see "Juror record created for John Stark and summoned to pool" on the page
    And I see pool summoned total count is "2"
    And I see "Summoned" in the same row as "Stark"
    And I see "RX10 9AG" in the same row as "Stark"

    Examples:
      |user			 |
      |MODTESTBUREAU |


  @JurorTransformationMulti
  Scenario Outline: Bureau Create Juror Record - Satellite Court

    Given I am on "Bureau" "ithc"

    #enable permissions
    Given I "enable" CREATE_JUROR permission for bureau user "<user>"

    And I log in as "<user>"

    When I navigate to the pool request screen

    #create an active pool request
    And I create an active "Crown" court pool request for court "767", "10" Mondays in the future

    #add jurors
    And I navigate to the pool search screen
    When I enter the pool number of the pool I have just created on the pool search screen
    And I press the "Continue" button

    And I press the "Create juror record" button

    #jurors name
    And I see "What's the juror's name?" on the page
    And I set "First name" to "John"
    And I set "Last name" to "Stark"
    And I press the "Continue" button

    #dob leave blank
    And I see "What's their date of birth?" on the page
    And I press the "Continue" button

    #address/error check
    And I see "What's the juror's address?" on the page
    And I set "Address line 1" to "5 Testing Street"
    And I set "Town or city" to "London"
    And I set "Postcode" to "WA16 2AN"
    And I press the "Continue" button

    #contact details
    And I see "Enter their contact details" on the page
    And I set "Main phone - UK only (optional)" to "07777777777"
    And I press the "Continue" button

    #notes
    And I see "Notes (optional)" on the page
    And I enter "Note testing" in the Notes text box

    And I press the "Continue" button
    And I see "Check your answers" on the page

    #check your answers page
    And I see "-" in the same row as "Date of birth"
    And I see "John Stark" in the same row as "Name"
    And I see "5 Testing Street" in the same row as "Address"
    And I see "07777777777" in the same row as "Main phone"
    And I see "-" in the same row as "Alternative phone"
    And I see "-" in the same row as "Email"
    And I see "Note testing" in the same row as "Notes"

    #create juror record
    And I press the "Create juror record" button

    #confirm juror is created and added to pool
    And I see "Juror record created for John Stark and summoned to pool" on the page
    And I see pool summoned total count is "2"
    And I see "Summoned" in the same row as "Stark"

    #check the new juror is added
    And I see pool summoned total count is "2"
    And I see "Summoned" in the same row as "Stark"

    Examples:
      |user			 |
      |MODTESTBUREAU |