Feature: Regression English_ReplyTypesIndicator

#this test contains scenarios that test the reply types indicator which do not already exist in other scripts

  @Regression
  Scenario Outline: English 1st Party + Juror Details Change

    Given I am on "Public" "ithc"

    Given a bureau owned pool is created with jurors
      | court | juror_number   | pool_number   | att_date_weeks_in_future | owner |
      | 452   | <juror_number> | <pool_number> | 5                        | 400   |

    And juror "<juror_number>" has "LAST_NAME" as "<last_name>" new schema
    And juror "<juror_number>" has "POSTCODE" as "<postcode>" new schema

    And I set the radio button to "I am replying for myself"

    And I press the "Continue" button

    And I see "Your juror details" on the page

    When I set "9-digit juror number" to "<juror_number>"
    And I set "Juror last name" to "<last_name>"
    And I set "Juror postcode" to "<postcode>"
    And I press the "Continue" button

    And I choose the "No" radio button
    And I press the "Continue" button
    And I set "First name" to "Joe"
    And I set "Last name" to "Blogs"

    And I press the "Continue" button

    And I choose the "No" radio button
    When I press the "Continue" button
    And I set "Address line 1" to "99 The Road"
    And I set "Town or city" to "Town"

    When I press the "Continue" button

    When I set "Main phone" to "02078211818"
    And I press the "Continue" button

    When I set "Enter your email address" to "<email>"
    When I set "Enter your email address again" to "<email>"

    And I press the "Continue" button

    When I set "Day" to "01"
    And I set "Month" to "01"
    And I set "Year" to "1990"
    And I press the "Continue" button

	#Qualify for jury service
    When I press the "Continue" button

	#Residency
    And I choose the "Yes" radio button
    And I press the "Continue" button

	#CJS
    When I choose the "No" radio button
    And I press the "Continue" button

	#Bail
    When I choose the "No" radio button
    And I press the "Continue" button

	#Convictions
    When I choose the "No" radio button
    And I press the "Continue" button

	#Mental Health Sectioned
    And I choose the "No" radio button
    And I press the "Continue" button

	#Mental Health Capacity
    And I choose the "No" radio button
    And I press the "Continue" button

	#I can attend
    And I set the radio button to "Yes, I can start on"
    And  I press the "Continue" button

	#RA no
    When I choose the "No" radio button
    And I press the "Continue" button

	#Check your answers
    And I check the "The information I have given is true to the best of my knowledge" checkbox
    And I press the "Submit" button
    Then I see "We have sent you an email to say you have replied to your jury summons." on the page
    And I see "Download a copy of your summons reply PDF (65KB)" on the page
    Then I click on the "Download a copy of your summons reply HTML (15KB)" link
    And I see "You answered the eligibility questions" on the page

    Given I am on "Bureau" "ithc"
    And I log in as "MODTESTBUREAU"

    When I click on the "Search" link
    And I set "Juror number" to "<juror_number>"
    And I press the "Search" button
    Then I see "<juror_number>" on the page

    And I click link with ID "selectAllLink"
    And I press the "Send to..." button
    And I set input field with "id" of "sendToOfficer" to "CPASS"
    And I press the "Send" button
    And I press the "Send" button
    Then I see "Your work" on the page

    Then I click on the "Sign out" link
    Given I am on "Bureau" "ithc"

    When I log in as "CPASS"
    Then I see "<juror_number>" on the page
    Then I see "<juror_number>" has reply type indicator "Needs review"

    When I click on "<juror_number>" in the same row as "<juror_number>"
    And I see "Needs review" on the page

    Examples:
      | juror_number | last_name | postcode | email      | pool_number |
      | 045200136    | DOE       | SW1H 9AJ | a@eeee.com | 452300135   |


  @RegressionSingle
  Scenario Outline: English 1st Party + RA

    Given I am on "Public" "ithc"

    Given a bureau owned pool is created with jurors
      | court | juror_number   | pool_number   | att_date_weeks_in_future | owner |
      | 452   | <juror_number> | <pool_number> | 5                        | 400   |

    And juror "<juror_number>" has "LAST_NAME" as "<last_name>" new schema
    And juror "<juror_number>" has "FIRST_NAME" as "FNAMESEVENONETHREE" new schema
    And juror "<juror_number>" has "ADDRESS_LINE_1" as "855 STREET NAME" new schema
    And juror "<juror_number>" has "ADDRESS_LINE_4" as "LONDON" new schema
    And juror "<juror_number>" has "POSTCODE" as "<postcode>" new schema

    Then I see "Reply to a jury summons" on the page

    And I set the radio button to "I am replying for myself"
    And I press the "Continue" button
    Then I see "Your juror details" on the page

    When I set "9-digit juror number" to "<juror_number>"
    When I set "Juror last name" to "<last_name>"
    When I set "Juror postcode" to "<postcode>"
    And I press the "Continue" button

    Then I see "Is the name we have for you correct?" on the page
    And I choose the "Yes" radio button
    And I press the "Continue" button

    And I choose the "Yes" radio button
    And I press the "Continue" button

    When I set "Main phone" to "02078211818"
    And I press the "Continue" button

    When I set "Enter your email address" to "<email>"
    When I set "Enter your email address again" to "<email>"
    And I press the "Continue" button

    When I set "Day" to "27"
    And I set "Month" to "04"
    And I set "Year" to "1981"
    And I press the "Continue" button

    Then I see "Confirm you're eligible for jury service" on the page

    And I press the "Continue" button

    Then I see "Since you turned 13, has your main address been in the UK, Channel Islands or Isle of Man for any period of at least 5 years?" on the page
    And I choose the "Yes" radio button
    And I press the "Continue" button

    Then I see "Have you worked in the criminal justice system in the last 5 years?" on the page
    When I choose the "No" radio button
    And I press the "Continue" button

    And I see "Are you currently on bail for a criminal offence?" on the page
    When I choose the "No" radio button
    And I press the "Continue" button

    Then I see "Have you been found guilty of a criminal offence?" on the page
    When I choose the "No" radio button
    And I press the "Continue" button

    And I see "Are you being detained, looked after or treated under the Mental Health Act?" on the page
    When I choose the "No" radio button
    And I press the "Continue" button

    Then I see "Has it been decided that you 'lack mental capacity'?" on the page
    When I choose the "No" radio button
    And I press the "Continue" button

	#deferral
    When I set the radio button to "No, I need to change the date"
    And I press the "Continue" button

    When I set text area with "id" of "deferralReason" to "Deferral Reason"
    And I press the "Continue" button

    When I set the "First" single date field to a Monday "6" weeks in the future
    When I set the "Second" single date field to a Monday "7" weeks in the future
    When I set the "Third" single date field to a Monday "8" weeks in the future

    And I press the "Continue" button

	#check dates screen
    And I choose the "Yes" radio button
    And I press the "Continue" button

    Then I see "Will you need help when you're at the court?" on the page
    Then I see "Do you have a disability or impairment that means you’ll need extra support or facilities in the court building where you are doing your Jury Service?" on the page
    When I choose the "Yes" radio button
    Then I check the "Diabetes" checkbox
    And I press the "Continue" button
    Then I see "Check your answers now" on the page

    Then I check the "The information I have given is true to the best of my knowledge" checkbox

    When I press the "Submit" button

    Then I see "You have completed your reply" on the page
    Then I see "<juror_number>" on the page

    Then on "JUROR_MOD" . "JUROR_RESPONSE" I see "PROCESSING_STATUS" is "TODO" where "JUROR_NUMBER" is "<juror_number>"
    Then on "JUROR_MOD" . "JUROR_RESPONSE" I see "PROCESSING_COMPLETE" is "N" where "JUROR_NUMBER" is "<juror_number>"

    Given I am on "Bureau" "ithc"
    And I log in as "MODTESTBUREAU"

    When I click on the "Search" link
    And I set "Juror number" to "<juror_number>"
    And I press the "Search" button
    Then I see "<juror_number>" on the page

    And I click link with ID "selectAllLink"
    And I press the "Send to..." button
    And I set input field with "id" of "sendToOfficer" to "CPASS"
    And I press the "Send" button
    And I press the "Send" button
    Then I see "Your work" on the page

    Then I click on the "Sign out" link
    Given I am on "Bureau" "ithc"
    When I log in as "CPASS"
    Then I see "<juror_number>" on the page
    Then I see "<juror_number>" has reply type indicator "Deferral"

    When I click on "<juror_number>" in the same row as "<juror_number>"
    And I see "Deferral" on the page

    Examples:
      | juror_number | pool_number | last_name       | postcode | email      |
      | 045200137    | 452300136   | LNAMESIXONEZERO | SY2 6LU  | e@eeee.com |

  @Regression
  Scenario Outline: English 1st Party + Residency

    Given I am on "Public" "ithc"

    Given a bureau owned pool is created with jurors
      | court | juror_number   | pool_number   | att_date_weeks_in_future | owner |
      | 452   | <juror_number> | <pool_number> | 5                        | 400   |

    And juror "<juror_number>" has "LAST_NAME" as "<last_name>" new schema
    And juror "<juror_number>" has "FIRST_NAME" as "FNAMESEVENONETHREE" new schema

    And juror "<juror_number>" has "ADDRESS_LINE_1" as "855 STREET NAME" new schema
    And juror "<juror_number>" has "ADDRESS_LINE_4" as "LONDON" new schema
    And juror "<juror_number>" has "POSTCODE" as "<postcode>" new schema

    Then I see "Reply to a jury summons" on the page

    And I set the radio button to "I am replying for myself"
    And I press the "Continue" button
    Then I see "Your juror details" on the page

    When I set "9-digit juror number" to "<juror_number>"
    When I set "Juror last name" to "<last_name>"
    When I set "Juror postcode" to "<postcode>"
    And I press the "Continue" button

    Then I see "Is the name we have for you correct?" on the page
    And I choose the "Yes" radio button
    And I press the "Continue" button

    And I choose the "Yes" radio button
    And I press the "Continue" button

    When I set "Main phone" to "02078211818"
    And I press the "Continue" button

    When I set "Enter your email address" to "<email>"
    When I set "Enter your email address again" to "<email>"
    And I press the "Continue" button

    When I set "Day" to "27"
    And I set "Month" to "04"
    And I set "Year" to "1981"
    And I press the "Continue" button

    Then I see "Confirm you're eligible for jury service" on the page

    And I press the "Continue" button

    Then I see "Since you turned 13, has your main address been in the UK, Channel Islands or Isle of Man for any period of at least 5 years?" on the page
    And I choose the "No" radio button
    And I set "Provide details" to "some reasons"
    And I press the "Continue" button

    Then I see "Have you worked in the criminal justice system in the last 5 years?" on the page
    When I choose the "No" radio button
    And I press the "Continue" button

    And I see "Are you currently on bail for a criminal offence?" on the page
    When I choose the "No" radio button
    And I press the "Continue" button

    Then I see "Have you been found guilty of a criminal offence?" on the page
    When I choose the "No" radio button
    And I press the "Continue" button

    And I see "Are you being detained, looked after or treated under the Mental Health Act?" on the page
    When I choose the "No" radio button
    And I press the "Continue" button

    Then I see "Has it been decided that you 'lack mental capacity'?" on the page
    When I choose the "No" radio button
    And I press the "Continue" button
	
	#Straight through
    When I choose the "Yes" radio button
    And I press the "Continue" button

    Then I see "Will you need help when you're at the court?" on the page
    Then I see "Do you have a disability or impairment that means you’ll need extra support or facilities in the court building where you are doing your Jury Service?" on the page
    When I choose the "No" radio button
    And I press the "Continue" button

    Then I see "Check your answers now" on the page
    Then I check the "The information I have given is true to the best of my knowledge" checkbox
    When I press the "Submit" button

    Then I see "You have completed your reply" on the page
    Then I see "<juror_number>" on the page

    Then on "JUROR_MOD" . "JUROR_RESPONSE" I see "PROCESSING_STATUS" is "TODO" where "JUROR_NUMBER" is "<juror_number>"
    Then on "JUROR_MOD" . "JUROR_RESPONSE" I see "PROCESSING_COMPLETE" is "N" where "JUROR_NUMBER" is "<juror_number>"

    Given I am on "Bureau" "ithc"
    And I log in as "MODTESTBUREAU"

    When I click on the "Search" link
    And I set "Juror number" to "<juror_number>"
    And I press the "Search" button
    Then I see "<juror_number>" on the page

    And I click link with ID "selectAllLink"
    And I press the "Send to..." button
    And I set input field with "id" of "sendToOfficer" to "CPASS"
    And I press the "Send" button
    And I press the "Send" button
    Then I see "Your work" on the page

    Then I click on the "Sign out" link
    Given I am on "Bureau" "ithc"
    When I log in as "CPASS"
    Then I see "<juror_number>" on the page
    Then I see "<juror_number>" has reply type indicator "Needs review"

    When I click on "<juror_number>" in the same row as "<juror_number>"
    And I see "Ineligible" on the page

    Examples:
      | juror_number | pool_number | last_name          | postcode | email      |
      | 045200138    | 452300137   | LNAMESIXTHREESEVEN | SY2 6LU  | e@eeee.com |

  @Regression
  Scenario Outline: English 1st Party + Bail

    Given I am on "Public" "ithc"

    Given a bureau owned pool is created with jurors
      | court | juror_number   | pool_number   | att_date_weeks_in_future | owner |
      | 452   | <juror_number> | <pool_number> | 5                        | 400   |

    And juror "<juror_number>" has "LAST_NAME" as "<last_name>" new schema
    And juror "<juror_number>" has "FIRST_NAME" as "FNAMESEVENONETHREE" new schema

    And juror "<juror_number>" has "ADDRESS_LINE_1" as "855 STREET NAME" new schema
    And juror "<juror_number>" has "ADDRESS_LINE_4" as "LONDON" new schema
    And juror "<juror_number>" has "POSTCODE" as "<postcode>" new schema

    Then I see "Reply to a jury summons" on the page

    And I set the radio button to "I am replying for myself"
    And I press the "Continue" button
    Then I see "Your juror details" on the page

    When I set "9-digit juror number" to "<juror_number>"
    When I set "Juror last name" to "<last_name>"
    When I set "Juror postcode" to "<postcode>"
    And I press the "Continue" button

    Then I see "Is the name we have for you correct?" on the page
    And I choose the "Yes" radio button
    And I press the "Continue" button

    And I choose the "Yes" radio button
    And I press the "Continue" button

    When I set "Main phone" to "02078211818"
    And I press the "Continue" button

    When I set "Enter your email address" to "<email>"
    When I set "Enter your email address again" to "<email>"
    And I press the "Continue" button

    When I set "Day" to "27"
    And I set "Month" to "04"
    And I set "Year" to "1981"
    And I press the "Continue" button

    Then I see "Confirm you're eligible for jury service" on the page

    And I press the "Continue" button

    Then I see "Since you turned 13, has your main address been in the UK, Channel Islands or Isle of Man for any period of at least 5 years?" on the page
    And I choose the "Yes" radio button
    And I press the "Continue" button

    Then I see "Have you worked in the criminal justice system in the last 5 years?" on the page
    When I choose the "No" radio button
    And I press the "Continue" button

    And I see "Are you currently on bail for a criminal offence?" on the page
    When I choose the "Yes" radio button
    Then I set "Provide details about your bail and criminal offence" to "some details"
    And I press the "Continue" button

    Then I see "Have you been found guilty of a criminal offence?" on the page
    When I choose the "No" radio button
    And I press the "Continue" button

    And I see "Are you being detained, looked after or treated under the Mental Health Act?" on the page
    When I choose the "No" radio button
    And I press the "Continue" button

    Then I see "Has it been decided that you 'lack mental capacity'?" on the page
    When I choose the "No" radio button
    And I press the "Continue" button
	
	#Straight through
    When I choose the "Yes" radio button
    And I press the "Continue" button

    Then I see "Will you need help when you're at the court?" on the page
    Then I see "Do you have a disability or impairment that means you’ll need extra support or facilities in the court building where you are doing your Jury Service?" on the page
    When I choose the "No" radio button
    And I press the "Continue" button

    Then I see "Check your answers now" on the page
    Then I check the "The information I have given is true to the best of my knowledge" checkbox
    When I press the "Submit" button

    Then I see "You have completed your reply" on the page
    Then I see "<juror_number>" on the page

    Then on "JUROR_MOD" . "JUROR_RESPONSE" I see "PROCESSING_STATUS" is "TODO" where "JUROR_NUMBER" is "<juror_number>"
    Then on "JUROR_MOD" . "JUROR_RESPONSE" I see "PROCESSING_COMPLETE" is "N" where "JUROR_NUMBER" is "<juror_number>"

    Given I am on "Bureau" "ithc"
    And I log in as "MODTESTBUREAU"

    When I click on the "Search" link
    And I set "Juror number" to "<juror_number>"
    And I press the "Search" button
    Then I see "<juror_number>" on the page

    And I click link with ID "selectAllLink"
    And I press the "Send to..." button
    And I set input field with "id" of "sendToOfficer" to "CPASS"
    And I press the "Send" button
    And I press the "Send" button
    Then I see "Your work" on the page

    Then I click on the "Sign out" link
    Given I am on "Bureau" "ithc"
    When I log in as "CPASS"
    Then I see "<juror_number>" on the page
    Then I see "<juror_number>" has reply type indicator "Needs review"

    When I click on "<juror_number>" in the same row as "<juror_number>"
    And I see "Ineligible" on the page

    Examples:
      | juror_number | pool_number | last_name          | postcode | email      |
      | 045200139    | 452300138   | LNAMESIXTHREESEVEN | SY2 6LU  | e@eeee.com |

  @Regression
  Scenario Outline: English 3rd Party + Convictions

    Given I am on "Public" "ithc"

    Given a bureau owned pool is created with jurors
      | court | juror_number   | pool_number   | att_date_weeks_in_future | owner |
      | 452   | <juror_number> | <pool_number> | 5                        | 400   |

    And juror "<juror_number>" has "LAST_NAME" as "<last_name>" new schema
    And juror "<juror_number>" has "POSTCODE" as "<postcode>" new schema

    And I set the radio button to "I am replying for someone else"
    And I press the "Continue" button
	
	#Juror Log In
    When I set "9-digit juror number" to "<juror_number>"
    When I set "Juror last name" to "<last_name>"
    When I set "Juror postcode" to "<postcode>"
    And I press the "Continue" button
	
	#3rd Party Name
    When I set "First name" to "FirstNameA"
    And I set "Last name" to "LastNameB"
    And I press the "Continue" button
	
	#Relationship to juror
    And I set "How do you know the person you're replying for?" to "Friend"
    And I press the "Continue" button
	
	#3rd Party Contact
    And I check the "By phone (UK Numbers only)" checkbox
    And I set "Main phone" to "0207 821 1818"
    And I check the "By email" checkbox
    And I set "Enter your email address" to "<email>"
    And I set "Enter your email address again" to "<email>"
    And I press the "Continue" button
	
	#Why are you replying for the person?
    When I set the radio button to "The person is not here"
    And I press the "Continue" button
	
	#Check juror name
    And I choose the "Yes" radio button
    And I press the "Continue" button
	
	#Check juror address
    And I choose the "Yes" radio button
    And I press the "Continue" button
	
	#DoB
    And I set "Day" to "01"
    And I set "Month" to "01"
    And I set "Year" to "1980"
    And I press the "Continue" button

	#Contacting the juror
    And I set the radio button to "Use the phone number that you have already given to contact you"
    And I set the radio button to "Use the email address that you have already given to contact you"
    And I press the "Continue" button
	
	#Qualify for jury service
    And I press the "Continue" button
	
	#Residency
    And I choose the "Yes" radio button
    And I press the "Continue" button
	
	#CJS
    When I choose the "No" radio button
    And I press the "Continue" button
	
	#Bail
    And I choose the "No" radio button
    And I press the "Continue" button
	
	#Convictions
    When I choose the "Yes" radio button
    And I set text area with "id" of "convictedDetails" to "I am a convicted criminal"
    And I press the "Continue" button
	
	#Mental Health Sectioned
    And I choose the "No" radio button
    And I press the "Continue" button
	
	#Mental Health Capacity
    And I choose the "No" radio button
    And I press the "Continue" button
	
	#Confirm Date of Jury
    When I choose the "Yes" radio button
    And I press the "Continue" button
	
	#RA
    When I choose the "No" radio button
    And I press the "Continue" button
	
	#Check Your Answers
    When I check the "The answers I have given for the person I'm replying for are true as far as I know" checkbox
    And I press the "Submit" button
    And I see "You have completed your reply" on the page

    Given I am on "Bureau" "ithc"
    And I log in as "MODTESTBUREAU"

    When I click on the "Search" link
    And I set "Juror number" to "<juror_number>"
    And I press the "Search" button
    Then I see "<juror_number>" on the page

    And I click link with ID "selectAllLink"
    And I press the "Send to..." button
    And I set input field with "id" of "sendToOfficer" to "CPASS"
    And I press the "Send" button
    And I press the "Send" button
    Then I see "Your work" on the page

    Then I click on the "Sign out" link
    Given I am on "Bureau" "ithc"
    When I log in as "CPASS"
    Then I see "<juror_number>" on the page
    Then I see "<juror_number>" has reply type indicator "Needs review"

    When I click on "<juror_number>" in the same row as "<juror_number>"
    And I see "Ineligible" on the page

    Examples:
      | juror_number | last_name        | postcode | email             | pool_number |
      | 045200140    | LNAMESIXNINEFOUR | SY2 6LU  | email@outlook.com | 452300139   |

  @Regression
  Scenario Outline: English 3rd Party + Residency

    Given I am on "Public" "ithc"

    Given a bureau owned pool is created with jurors
      | court | juror_number   | pool_number   | att_date_weeks_in_future | owner |
      | 452   | <juror_number> | <pool_number> | 5                        | 400   |

    And juror "<juror_number>" has "LAST_NAME" as "<last_name>" new schema
    And juror "<juror_number>" has "POSTCODE" as "<postcode>" new schema

    And I set the radio button to "I am replying for someone else"
    And I press the "Continue" button
	
	#Juror Log In
    When I set "9-digit juror number" to "<juror_number>"
    When I set "Juror last name" to "<last_name>"
    When I set "Juror postcode" to "<postcode>"
    And I press the "Continue" button
	
	#3rd Party Name
    When I set "First name" to "FirstNameA"
    And I set "Last name" to "LastNameB"
    And I press the "Continue" button
	
	#Relationship to juror
    And I set "How do you know the person you're replying for?" to "Friend"
    And I press the "Continue" button
	
	#3rd Party Contact
    And I check the "By phone (UK Numbers only)" checkbox
    And I set "Main phone" to "0207 821 1818"
    And I check the "By email" checkbox
    And I set "Enter your email address" to "<email>"
    And I set "Enter your email address again" to "<email>"
    And I press the "Continue" button
	
	#Why are you replying for the person?
    When I set the radio button to "The person is not here"
    And I press the "Continue" button
	
	#Check juror name
    And I choose the "Yes" radio button
    And I press the "Continue" button
	
	#Check juror address
    And I choose the "Yes" radio button
    And I press the "Continue" button
	
	#DoB
    And I set "Day" to "01"
    And I set "Month" to "01"
    And I set "Year" to "1980"
    And I press the "Continue" button

	#Contacting the juror
    And I set the radio button to "Use the phone number that you have already given to contact you"
    And I set the radio button to "Use the email address that you have already given to contact you"
    And I press the "Continue" button
	
	#Qualify for jury service
    And I press the "Continue" button
	
	#Residency
    And I choose the "No" radio button
    And I set "Provide details about where the person you are answering for has lived since their 13th birthday" to "some details"
    And I press the "Continue" button
	
	#CJS
    When I choose the "No" radio button
    And I press the "Continue" button
	
	#Bail
    And I choose the "No" radio button
    And I press the "Continue" button
	
	#Convictions
    When I choose the "No" radio button
    And I press the "Continue" button
	
	#Mental Health Sectioned
    And I choose the "No" radio button
    And I press the "Continue" button
	
	#Mental Health Capacity
    And I choose the "No" radio button
    And I press the "Continue" button
	
	#Confirm Date of Jury
    When I choose the "Yes" radio button
    And I press the "Continue" button
	
	#RA
    When I choose the "No" radio button
    And I press the "Continue" button
	
	#Check Your Answers
    When I check the "The answers I have given for the person I'm replying for are true as far as I know" checkbox
    And I press the "Submit" button
    And I see "You have completed your reply" on the page

    Given I am on "Bureau" "ithc"
    And I log in as "MODTESTBUREAU"

    When I click on the "Search" link
    And I set "Juror number" to "<juror_number>"
    And I press the "Search" button
    Then I see "<juror_number>" on the page

    And I click link with ID "selectAllLink"
    And I press the "Send to..." button
    And I set input field with "id" of "sendToOfficer" to "CPASS"
    And I press the "Send" button
    And I press the "Send" button
    Then I see "Your work" on the page

    Then I click on the "Sign out" link
    Given I am on "Bureau" "ithc"
    When I log in as "CPASS"
    Then I see "<juror_number>" on the page
    Then I see "<juror_number>" has reply type indicator "Needs review"

    When I click on "<juror_number>" in the same row as "<juror_number>"
    And I see "Ineligible" on the page

    Examples:
      | juror_number | last_name         | postcode | email             | pool_number |
      | 045200141    | LNAMESEVENTWOZERO | SY2 6LU  | email@outlook.com | 452300140   |

  @Regression
  Scenario Outline: English 3rd Party + Bail
    Given I am on "Public" "ithc"

    Given a bureau owned pool is created with jurors
      | court | juror_number   | pool_number   | att_date_weeks_in_future | owner |
      | 452   | <juror_number> | <pool_number> | 5                        | 400   |

    And juror "<juror_number>" has "LAST_NAME" as "<last_name>" new schema
    And juror "<juror_number>" has "POSTCODE" as "<postcode>" new schema

    And I set the radio button to "I am replying for someone else"
    And I press the "Continue" button
	
	#Juror Log In
    When I set "9-digit juror number" to "<juror_number>"
    When I set "Juror last name" to "<last_name>"
    When I set "Juror postcode" to "<postcode>"
    And I press the "Continue" button
	
	#3rd Party Name
    When I set "First name" to "FirstNameA"
    And I set "Last name" to "LastNameB"
    And I press the "Continue" button
	
	#Relationship to juror
    And I set "How do you know the person you're replying for?" to "Friend"
    And I press the "Continue" button
	
	#3rd Party Contact
    And I check the "By phone (UK Numbers only)" checkbox
    And I set "Main phone" to "0207 821 1818"
    And I check the "By email" checkbox
    And I set "Enter your email address" to "<email>"
    And I set "Enter your email address again" to "<email>"
    And I press the "Continue" button
	
	#Why are you replying for the person?
    When I set the radio button to "The person is not here"
    And I press the "Continue" button
	
	#Check juror name
    And I choose the "Yes" radio button
    And I press the "Continue" button
	
	#Check juror address
    And I choose the "Yes" radio button
    And I press the "Continue" button
	
	#DoB
    And I set "Day" to "01"
    And I set "Month" to "01"
    And I set "Year" to "1980"
    And I press the "Continue" button

	#Contacting the juror
    And I set the radio button to "Use the phone number that you have already given to contact you"
    And I set the radio button to "Use the email address that you have already given to contact you"
    And I press the "Continue" button
	
	#Qualify for jury service
    And I press the "Continue" button
	
	#Residency
    And I choose the "Yes" radio button
    And I press the "Continue" button
	
	#CJS
    When I choose the "No" radio button
    And I press the "Continue" button
	
	#Bail
    And I choose the "Yes" radio button
    And I set "Provide details about the person's bail and criminal offence" to "some details"
    And I press the "Continue" button
	
	#Convictions
    When I choose the "No" radio button
    And I press the "Continue" button
	
	#Mental Health Sectioned
    And I choose the "No" radio button
    And I press the "Continue" button
	
	#Mental Health Capacity
    And I choose the "No" radio button
    And I press the "Continue" button
	
	#Confirm Date of Jury
    When I choose the "Yes" radio button
    And I press the "Continue" button
	
	#RA
    When I choose the "No" radio button
    And I press the "Continue" button
	
	#Check Your Answers
    When I check the "The answers I have given for the person I'm replying for are true as far as I know" checkbox
    And I press the "Submit" button
    And I see "You have completed your reply" on the page

    Given I am on "Bureau" "ithc"
    And I log in as "MODTESTBUREAU"

    When I click on the "Search" link
    And I set "Juror number" to "<juror_number>"
    And I press the "Search" button
    Then I see "<juror_number>" on the page

    And I click link with ID "selectAllLink"
    And I press the "Send to..." button
    And I set input field with "id" of "sendToOfficer" to "CPASS"
    And I press the "Send" button
    And I press the "Send" button
    Then I see "Your work" on the page

    Then I click on the "Sign out" link
    Given I am on "Bureau" "ithc"
    When I log in as "CPASS"
    Then I see "<juror_number>" on the page
    Then I see "<juror_number>" has reply type indicator "Needs review"

    When I click on "<juror_number>" in the same row as "<juror_number>"
    And I see "Ineligible" on the page

    Examples:
      | juror_number | last_name           | postcode | email             | pool_number |
      | 045200142    | LNAMESEVENFOURTHREE | SY2 6LU  | email@outlook.com | 452300141   |

  @Regression
  Scenario Outline: English 3rd Party + Mental Health

    Given I am on "Public" "ithc"

    Given a bureau owned pool is created with jurors
      | court | juror_number   | pool_number   | att_date_weeks_in_future | owner |
      | 452   | <juror_number> | <pool_number> | 5                        | 400   |

    And juror "<juror_number>" has "LAST_NAME" as "<last_name>" new schema
    And juror "<juror_number>" has "POSTCODE" as "<postcode>" new schema

    And I set the radio button to "I am replying for someone else"
    And I press the "Continue" button
	
	#Juror Log In
    When I set "9-digit juror number" to "<juror_number>"
    When I set "Juror last name" to "<last_name>"
    When I set "Juror postcode" to "<postcode>"
    And I press the "Continue" button
	
	#3rd Party Name
    When I set "First name" to "FirstNameA"
    And I set "Last name" to "LastNameB"
    And I press the "Continue" button
	
	#Relationship to juror
    And I set "How do you know the person you're replying for?" to "Friend"
    And I press the "Continue" button
	
	#3rd Party Contact
    And I check the "By phone (UK Numbers only)" checkbox
    And I set "Main phone" to "0207 821 1818"
    And I check the "By email" checkbox
    And I set "Enter your email address" to "<email>"
    And I set "Enter your email address again" to "<email>"
    And I press the "Continue" button
	
	#Why are you replying for the person?
    When I set the radio button to "The person is not here"
    And I press the "Continue" button
	
	#Check juror name
    And I choose the "Yes" radio button
    And I press the "Continue" button
	
	#Check juror address
    And I choose the "Yes" radio button
    And I press the "Continue" button
	
	#DoB
    And I set "Day" to "01"
    And I set "Month" to "01"
    And I set "Year" to "1980"
    And I press the "Continue" button

	#Contacting the juror
    And I set the radio button to "Use the phone number that you have already given to contact you"
    And I set the radio button to "Use the email address that you have already given to contact you"
    And I press the "Continue" button
	
	#Qualify for jury service
    And I press the "Continue" button
	
	#Residency
    And I choose the "Yes" radio button
    And I press the "Continue" button
	
	#CJS
    When I choose the "No" radio button
    And I press the "Continue" button
	
	#Bail
    And I choose the "No" radio button
    And I press the "Continue" button
	
	#Convictions
    When I choose the "No" radio button
    And I press the "Continue" button
	
	#Mental Health Sectioned
    And I choose the "Yes" radio button
    And I set "Provide details about how they're being detained, looked after or treated under the Mental Health Act" to "some details"
    And I press the "Continue" button
	
	#Mental Health Capacity
    And I choose the "Yes" radio button
    And I set "Provide brief details about why it was decided they lack mental capacity" to "some details"
    And I press the "Continue" button
	
	#Confirm Date of Jury
    When I choose the "Yes" radio button
    And I press the "Continue" button
	
	#RA
    When I choose the "No" radio button
    And I press the "Continue" button
	
	#Check Your Answers
    When I check the "The answers I have given for the person I'm replying for are true as far as I know" checkbox
    And I press the "Submit" button
    And I see "You have completed your reply" on the page

    Given I am on "Bureau" "ithc"
    And I log in as "MODTESTBUREAU"

    When I click on the "Search" link
    And I set "Juror number" to "<juror_number>"
    And I press the "Search" button
    Then I see "<juror_number>" on the page

    And I click link with ID "selectAllLink"
    And I press the "Send to..." button
    And I set input field with "id" of "sendToOfficer" to "CPASS"
    And I press the "Send" button
    And I press the "Send" button
    Then I see "Your work" on the page

    Then I click on the "Sign out" link
    Given I am on "Bureau" "ithc"
    When I log in as "CPASS"
    Then I see "<juror_number>" on the page
    Then I see "<juror_number>" has reply type indicator "Needs review"

    When I click on "<juror_number>" in the same row as "<juror_number>"
    And I see "Ineligible" on the page

    Examples:
      | juror_number | last_name           | postcode | email             | pool_number |
      | 045200143    | LNAMESEVENFOUREIGHT | SY2 6LU  | email@outlook.com | 452300142   |

  @Regression
  Scenario Outline: Multiple reply types

    Given I am on "Public" "ithc"

    Given auto straight through processing has been enabled new schema

    Given a bureau owned pool is created with jurors
      | court | juror_number          | pool_number   | att_date_weeks_in_future | owner |
      | 452   | <juror_number>        | <pool_number> | 5                        | 400   |
      | 452   | <juror_number_two>    | <pool_number> | 5                        | 400   |
      | 452   | <juror_number_three>  | <pool_number> | 5                        | 400   |
      | 452   | <juror_number_four>   | <pool_number> | 5                        | 400   |
      | 452   | <juror_number_five>   | <pool_number> | 5                        | 400   |
      | 452   | <juror_number_six>    | <pool_number> | 5                        | 400   |
      | 452   | <juror_number_eight>  | <pool_number> | 5                        | 400   |
      | 452   | <juror_number_ten>    | <pool_number> | 5                        | 400   |
      | 452   | <juror_number_eleven> | <pool_number> | 5                        | 400   |

    Given a bureau owned pool is created with jurors
      | court | juror_number         | pool_number       | att_date_weeks_in_future | owner |
      | 452   | <juror_number_seven> | <pool_number_two> | 5                        | 400   |

    Given a bureau owned pool is created with jurors
      | court | juror_number        | pool_number         | att_date_weeks_in_future | owner |
      | 452   | <juror_number_nine> | <pool_number_three> | 5                        | 400   |

    And juror "<juror_number>" has "LAST_NAME" as "<last_name>" new schema
    And juror "<juror_number>" has "POSTCODE" as "<postcode>" new schema

    And juror "<juror_number_two>" has "LAST_NAME" as "<last_name>" new schema
    And juror "<juror_number_two>" has "POSTCODE" as "<postcode>" new schema

    And juror "<juror_number_three>" has "LAST_NAME" as "<last_name>" new schema
    And juror "<juror_number_three>" has "POSTCODE" as "<postcode>" new schema

    And juror "<juror_number_four>" has "LAST_NAME" as "<last_name>" new schema
    And juror "<juror_number_four>" has "POSTCODE" as "<postcode>" new schema

    And juror "<juror_number_five>" has "LAST_NAME" as "<last_name>" new schema
    And juror "<juror_number_five>" has "POSTCODE" as "<postcode>" new schema

    And juror "<juror_number_six>" has "LAST_NAME" as "<last_name>" new schema
    And juror "<juror_number_six>" has "POSTCODE" as "<postcode>" new schema

    And juror "<juror_number_seven>" has "LAST_NAME" as "<last_name>" new schema
    And juror "<juror_number_seven>" has "POSTCODE" as "<postcode>" new schema

    And juror "<juror_number_eight>" has "LAST_NAME" as "<last_name>" new schema
    And juror "<juror_number_eight>" has "POSTCODE" as "<postcode>" new schema

    And juror "<juror_number_nine>" has "LAST_NAME" as "<last_name>" new schema
    And juror "<juror_number_nine>" has "POSTCODE" as "<postcode>" new schema

    And juror "<juror_number_ten>" has "LAST_NAME" as "<last_name>" new schema
    And juror "<juror_number_ten>" has "POSTCODE" as "<postcode>" new schema

    And juror "<juror_number_eleven>" has "LAST_NAME" as "<last_name>" new schema
    And juror "<juror_number_eleven>" has "POSTCODE" as "<postcode>" new schema

	#RESPONSE 1
	#3rd party MH
    Given I am on "Public" "ithc"

    And I set the radio button to "I am replying for someone else"
    And I press the "Continue" button

	#Juror Log In
    When I set "9-digit juror number" to "<juror_number>"
    When I set "Juror last name" to "<last_name>"
    When I set "Juror postcode" to "<postcode>"
    And I press the "Continue" button

	#3rd Party Name
    When I set "First name" to "FirstNameA"
    And I set "Last name" to "LastNameB"
    And I press the "Continue" button

	#Relationship to juror
    And I set "How do you know the person you're replying for?" to "Friend"
    And I press the "Continue" button

	#3rd Party Contact
    And I check the "By phone (UK Numbers only)" checkbox
    And I set "Main phone" to "0207 821 1818"
    And I check the "By email" checkbox
    And I set "Enter your email address" to "<email>"
    And I set "Enter your email address again" to "<email>"
    And I press the "Continue" button

	#Why are you replying for the person?
    When I set the radio button to "The person is not here"
    And I press the "Continue" button

	#Check juror nam
    And I choose the "Yes" radio button
    And I press the "Continue" button

	#Check juror address
    And I choose the "Yes" radio button
    And I press the "Continue" button

	#DoB
    And I set "Day" to "01"
    And I set "Month" to "01"
    And I set "Year" to "1980"
    And I press the "Continue" button

	#Contacting the juror
    And I set the radio button to "Use the phone number that you have already given to contact you"
    And I set the radio button to "Use the email address that you have already given to contact you"
    And I press the "Continue" button

	#Qualify for jury service
    And I press the "Continue" button

	#Residency
    And I choose the "Yes" radio button
    And I press the "Continue" button

	#CJS
    When I choose the "No" radio button
    And I press the "Continue" button

	#Bail
    And I choose the "No" radio button
    And I press the "Continue" button

	#Convictions
    When I choose the "No" radio button
    And I press the "Continue" button

	#Mental Health Sectioned
    And I choose the "Yes" radio button
    And I set "Provide details about how they're being detained, looked after or treated under the Mental Health Act" to "some details"
    And I press the "Continue" button

	#Mental Health Capacity
    And I choose the "Yes" radio button
    And I set "Provide brief details about why it was decided they lack mental capacity" to "some details"
    And I press the "Continue" button

	#Confirm Date of Jury
    When I choose the "Yes" radio button
    And I press the "Continue" button

	#RA
    When I choose the "No" radio button
    And I press the "Continue" button

	#Check Your Answers
    When I check the "The answers I have given for the person I'm replying for are true as far as I know" checkbox
    And I press the "Submit" button
    And I see "You have completed your reply" on the page

	#RESPONSE 2
	#3rd party bail
    Given I am on "Public" "ithc"

    And I set the radio button to "I am replying for someone else"
    And I press the "Continue" button

	#Juror Log In
    When I set "9-digit juror number" to "<juror_number_two>"
    When I set "Juror last name" to "<last_name>"
    When I set "Juror postcode" to "<postcode>"
    And I press the "Continue" button

	#3rd Party Name
    When I set "First name" to "FirstNameA"
    And I set "Last name" to "LastNameB"
    And I press the "Continue" button

	#Relationship to juror
    And I set "How do you know the person you're replying for?" to "Friend"
    And I press the "Continue" button

	#3rd Party Contact
    And I check the "By phone (UK Numbers only)" checkbox
    And I set "Main phone" to "0207 821 1818"
    And I check the "By email" checkbox
    And I set "Enter your email address" to "<email>"
    And I set "Enter your email address again" to "<email>"
    And I press the "Continue" button

	#Why are you replying for the person?
    When I set the radio button to "The person is not here"
    And I press the "Continue" button

	#Check juror name
    And I choose the "Yes" radio button
    And I press the "Continue" button

	#Check juror address
    And I choose the "Yes" radio button
    And I press the "Continue" button

	#DoB
    And I set "Day" to "01"
    And I set "Month" to "01"
    And I set "Year" to "1980"
    And I press the "Continue" button

	#Contacting the juror
    And I set the radio button to "Use the phone number that you have already given to contact you"
    And I set the radio button to "Use the email address that you have already given to contact you"
    And I press the "Continue" button

	#Qualify for jury service
    And I press the "Continue" button

	#Residency
    And I choose the "Yes" radio button
    And I press the "Continue" button

	#CJS
    When I choose the "No" radio button
    And I press the "Continue" button

	#Bail
    And I choose the "Yes" radio button
    And I set "Provide details about the person's bail and criminal offence" to "some details"
    And I press the "Continue" button

	#Convictions
    When I choose the "No" radio button
    And I press the "Continue" button

	#Mental Health Sectioned
    And I choose the "No" radio button
    And I press the "Continue" button

	#Mental Health Capacity
    And I choose the "No" radio button
    And I press the "Continue" button

	#Confirm Date of Jury
    When I choose the "Yes" radio button
    And I press the "Continue" button

	#RA
    When I choose the "No" radio button
    And I press the "Continue" button

	#Check Your Answers
    When I check the "The answers I have given for the person I'm replying for are true as far as I know" checkbox
    And I press the "Submit" button
    And I see "You have completed your reply" on the page

	#RESPONSE 3
	#3rd party residency
    Given I am on "Public" "ithc"

    And I set the radio button to "I am replying for someone else"
    And I press the "Continue" button

	#Juror Log In
    When I set "9-digit juror number" to "<juror_number_three>"
    When I set "Juror last name" to "<last_name>"
    When I set "Juror postcode" to "<postcode>"
    And I press the "Continue" button

	#3rd Party Name
    When I set "First name" to "FirstNameA"
    And I set "Last name" to "LastNameB"
    And I press the "Continue" button

	#Relationship to juror
    And I set "How do you know the person you're replying for?" to "Friend"
    And I press the "Continue" button

	#3rd Party Contact
    And I check the "By phone (UK Numbers only)" checkbox
    And I set "Main phone" to "0207 821 1818"
    And I check the "By email" checkbox
    And I set "Enter your email address" to "<email>"
    And I set "Enter your email address again" to "<email>"
    And I press the "Continue" button

	#Why are you replying for the person?
    When I set the radio button to "The person is not here"
    And I press the "Continue" button

	#Check juror name
    And I choose the "Yes" radio button
    And I press the "Continue" button

	#Check juror address
    And I choose the "Yes" radio button
    And I press the "Continue" button

	#DoB
    And I set "Day" to "01"
    And I set "Month" to "01"
    And I set "Year" to "1980"
    And I press the "Continue" button

	#Contacting the juror
    And I set the radio button to "Use the phone number that you have already given to contact you"
    And I set the radio button to "Use the email address that you have already given to contact you"
    And I press the "Continue" button

	#Qualify for jury service
    And I press the "Continue" button

	#Residency
    And I choose the "No" radio button
    And I set "Provide details about where the person you are answering for has lived since their 13th birthday" to "some details"
    And I press the "Continue" button

	#CJS
    When I choose the "No" radio button
    And I press the "Continue" button

	#Bail
    And I choose the "No" radio button
    And I press the "Continue" button

	#Convictions
    When I choose the "No" radio button
    And I press the "Continue" button

	#Mental Health Sectioned
    And I choose the "No" radio button
    And I press the "Continue" button

	#Mental Health Capacity
    And I choose the "No" radio button
    And I press the "Continue" button

	#Confirm Date of Jury
    When I choose the "Yes" radio button
    And I press the "Continue" button

	#RA
    When I choose the "No" radio button
    And I press the "Continue" button

	#Check Your Answers
    When I check the "The answers I have given for the person I'm replying for are true as far as I know" checkbox
    And I press the "Submit" button
    And I see "You have completed your reply" on the page

	#RESPONSE 4
	#3rd party convictions
    Given I am on "Public" "ithc"

    And I set the radio button to "I am replying for someone else"
    And I press the "Continue" button

	#Juror Log In
    When I set "9-digit juror number" to "<juror_number_four>"
    When I set "Juror last name" to "<last_name>"
    When I set "Juror postcode" to "<postcode>"
    And I press the "Continue" button

	#3rd Party Name
    When I set "First name" to "FirstNameA"
    And I set "Last name" to "LastNameB"
    And I press the "Continue" button

	#Relationship to juror
    And I set "How do you know the person you're replying for?" to "Friend"
    And I press the "Continue" button

	#3rd Party Contact
    And I check the "By phone (UK Numbers only)" checkbox
    And I set "Main phone" to "0207 821 1818"
    And I check the "By email" checkbox
    And I set "Enter your email address" to "<email>"
    And I set "Enter your email address again" to "<email>"
    And I press the "Continue" button

	#Why are you replying for the person?
    When I set the radio button to "The person is not here"
    And I press the "Continue" button

	#Check juror name
    And I choose the "Yes" radio button
    And I press the "Continue" button

	#Check juror address
    And I choose the "Yes" radio button
    And I press the "Continue" button

	#DoB
    And I set "Day" to "01"
    And I set "Month" to "01"
    And I set "Year" to "1980"
    And I press the "Continue" button

	#Contacting the juror
    And I set the radio button to "Use the phone number that you have already given to contact you"
    And I set the radio button to "Use the email address that you have already given to contact you"
    And I press the "Continue" button

	#Qualify for jury service
    And I press the "Continue" button

	#Residency
    And I choose the "Yes" radio button
    And I press the "Continue" button

	#CJS
    When I choose the "No" radio button
    And I press the "Continue" button

	#Bail
    And I choose the "No" radio button
    And I press the "Continue" button

	#Convictions
    When I choose the "Yes" radio button
    And I set text area with "id" of "convictedDetails" to "I am a convicted criminal"
    And I press the "Continue" button

	#Mental Health Sectioned
    And I choose the "No" radio button
    And I press the "Continue" button

	#Mental Health Capacity
    And I choose the "No" radio button
    And I press the "Continue" button

	#Confirm Date of Jury
    When I choose the "Yes" radio button
    And I press the "Continue" button

	#RA
    When I choose the "No" radio button
    And I press the "Continue" button

	#Check Your Answers
    When I check the "The answers I have given for the person I'm replying for are true as far as I know" checkbox
    And I press the "Submit" button
    And I see "You have completed your reply" on the page

	#RESPONSE 5
	#1st bail
    Given I am on "Public" "ithc"

    And I set the radio button to "I am replying for myself"
    And I press the "Continue" button
    Then I see "Your juror details" on the page

    When I set "9-digit juror number" to "<juror_number_five>"
    When I set "Juror last name" to "<last_name>"
    When I set "Juror postcode" to "<postcode>"
    And I press the "Continue" button

    Then I see "Is the name we have for you correct?" on the page
    And I choose the "Yes" radio button
    And I press the "Continue" button

    And I choose the "Yes" radio button
    And I press the "Continue" button

    When I set "Main phone" to "02078211818"
    And I press the "Continue" button

    When I set "Enter your email address" to "<email>"
    When I set "Enter your email address again" to "<email>"
    And I press the "Continue" button

    When I set "Day" to "27"
    And I set "Month" to "04"
    And I set "Year" to "1981"
    And I press the "Continue" button

    Then I see "Confirm you're eligible for jury service" on the page

    And I press the "Continue" button

    Then I see "Since you turned 13, has your main address been in the UK, Channel Islands or Isle of Man for any period of at least 5 years?" on the page
    And I choose the "Yes" radio button
    And I press the "Continue" button

    Then I see "Have you worked in the criminal justice system in the last 5 years?" on the page
    When I choose the "No" radio button
    And I press the "Continue" button

    And I see "Are you currently on bail for a criminal offence?" on the page
    When I choose the "Yes" radio button
    Then I set "Provide details about your bail and criminal offence" to "some details"
    And I press the "Continue" button

    Then I see "Have you been found guilty of a criminal offence?" on the page
    When I choose the "No" radio button
    And I press the "Continue" button

    And I see "Are you being detained, looked after or treated under the Mental Health Act?" on the page
    When I choose the "No" radio button
    And I press the "Continue" button

    Then I see "Has it been decided that you 'lack mental capacity'?" on the page
    When I choose the "No" radio button
    And I press the "Continue" button

	#Straight through
    When I choose the "Yes" radio button
    And I press the "Continue" button

    Then I see "Will you need help when you're at the court?" on the page
    Then I see "Do you have a disability or impairment that means you’ll need extra support or facilities in the court building where you are doing your Jury Service?" on the page
    When I choose the "No" radio button
    And I press the "Continue" button

    Then I see "Check your answers now" on the page
    Then I check the "The information I have given is true to the best of my knowledge" checkbox
    When I press the "Submit" button

    Then I see "You have completed your reply" on the page
    Then I see "<juror_number_five>" on the page

	#RESPONSE 6
	#1st residency
    Given I am on "Public" "ithc"

    And I set the radio button to "I am replying for myself"
    And I press the "Continue" button
    Then I see "Your juror details" on the page

    When I set "9-digit juror number" to "<juror_number_six>"
    When I set "Juror last name" to "<last_name>"
    When I set "Juror postcode" to "<postcode>"
    And I press the "Continue" button

    Then I see "Is the name we have for you correct?" on the page
    And I choose the "Yes" radio button
    And I press the "Continue" button

    And I choose the "Yes" radio button
    And I press the "Continue" button

    When I set "Main phone" to "02078211818"
    And I press the "Continue" button

    When I set "Enter your email address" to "<email>"
    When I set "Enter your email address again" to "<email>"
    And I press the "Continue" button

    When I set "Day" to "27"
    And I set "Month" to "04"
    And I set "Year" to "1981"
    And I press the "Continue" button

    Then I see "Confirm you're eligible for jury service" on the page

    And I press the "Continue" button

    Then I see "Since you turned 13, has your main address been in the UK, Channel Islands or Isle of Man for any period of at least 5 years?" on the page
    And I choose the "No" radio button
    And I set "Provide details" to "some reasons"
    And I press the "Continue" button

    Then I see "Have you worked in the criminal justice system in the last 5 years?" on the page
    When I choose the "No" radio button
    And I press the "Continue" button

    And I see "Are you currently on bail for a criminal offence?" on the page
    When I choose the "No" radio button
    And I press the "Continue" button

    Then I see "Have you been found guilty of a criminal offence?" on the page
    When I choose the "No" radio button
    And I press the "Continue" button

    And I see "Are you being detained, looked after or treated under the Mental Health Act?" on the page
    When I choose the "No" radio button
    And I press the "Continue" button

    Then I see "Has it been decided that you 'lack mental capacity'?" on the page
    When I choose the "No" radio button
    And I press the "Continue" button

	#Straight through
    When I choose the "Yes" radio button
    And I press the "Continue" button

    Then I see "Will you need help when you're at the court?" on the page
    Then I see "Do you have a disability or impairment that means you’ll need extra support or facilities in the court building where you are doing your Jury Service?" on the page
    When I choose the "No" radio button
    And I press the "Continue" button

    Then I see "Check your answers now" on the page
    Then I check the "The information I have given is true to the best of my knowledge" checkbox
    When I press the "Submit" button

    Then I see "You have completed your reply" on the page
    Then I see "<juror_number_six>" on the page

	#RESPONSE 7
	#1st details change
    Given I am on "Public" "ithc"

    And I set the radio button to "I am replying for myself"

    And I press the "Continue" button

    And I see "Your juror details" on the page

    When I set "9-digit juror number" to "<juror_number_seven>"
    And I set "Juror last name" to "<last_name>"
    And I set "Juror postcode" to "<postcode>"
    And I press the "Continue" button

    And I choose the "No" radio button
    And I press the "Continue" button
    And I set "First name" to "Joe"
    And I set "Last name" to "Blogs"

    And I press the "Continue" button

    And I choose the "No" radio button
    When I press the "Continue" button
    And I set "Address line 1" to "99 The Road"
    And I set "Town or city" to "Town"

    When I press the "Continue" button

    When I set "Main phone" to "02078211818"
    And I press the "Continue" button

    When I set "Enter your email address" to "e@mail.com"
    When I set "Enter your email address again" to "e@mail.com"

    And I press the "Continue" button

    When I set "Day" to "01"
    And I set "Month" to "01"
    And I set "Year" to "1990"
    And I press the "Continue" button

	#Qualify for jury service
    When I press the "Continue" button

	#Residency
    And I choose the "Yes" radio button
    And I press the "Continue" button

	#CJS
    When I choose the "No" radio button
    And I press the "Continue" button

	#Bail
    When I choose the "No" radio button
    And I press the "Continue" button

	#Convictions
    When I choose the "No" radio button
    And I press the "Continue" button

	#Mental Health Sectioned
    And I choose the "No" radio button
    And I press the "Continue" button

	#Mental Health Capacity
    And I choose the "No" radio button
    And I press the "Continue" button

	#I can attend
    And I set the radio button to "Yes, I can start on"
    And  I press the "Continue" button

	#RA no
    When I choose the "No" radio button
    And I press the "Continue" button

	#Check your answers
    Then I see "Check your answers now" on the page
    Then I check the "The information I have given is true to the best of my knowledge" checkbox
    When I press the "Submit" button

    Then I see "You have completed your reply" on the page
    Then I see "<juror_number_seven>" on the page

	#RESPONSE 8
	#1st deferral
    Given I am on "Public" "ithc"

    Then I see "Reply to a jury summons" on the page

    And I set the radio button to "I am replying for myself"
    And I press the "Continue" button
    Then I see "Your juror details" on the page

    When I set "9-digit juror number" to "<juror_number_eight>"
    When I set "Juror last name" to "<last_name>"
    When I set "Juror postcode" to "<postcode>"
    And I press the "Continue" button

    Then I see "Is the name we have for you correct?" on the page
    And I choose the "Yes" radio button
    And I press the "Continue" button

    And I choose the "Yes" radio button
    And I press the "Continue" button

    When I set "Main phone" to "02078211818"
    And I press the "Continue" button

    When I set "Enter your email address" to "<email>"
    When I set "Enter your email address again" to "<email>"
    And I press the "Continue" button

    When I set "Day" to "27"
    And I set "Month" to "04"
    And I set "Year" to "1981"
    And I press the "Continue" button

    Then I see "Confirm you're eligible for jury service" on the page

    And I press the "Continue" button

    Then I see "Since you turned 13, has your main address been in the UK, Channel Islands or Isle of Man for any period of at least 5 years?" on the page
    And I choose the "Yes" radio button
    And I press the "Continue" button

    Then I see "Have you worked in the criminal justice system in the last 5 years?" on the page
    When I choose the "No" radio button
    And I press the "Continue" button

    And I see "Are you currently on bail for a criminal offence?" on the page
    When I choose the "No" radio button
    And I press the "Continue" button

    Then I see "Have you been found guilty of a criminal offence?" on the page
    When I choose the "No" radio button
    And I press the "Continue" button

    And I see "Are you being detained, looked after or treated under the Mental Health Act?" on the page
    When I choose the "No" radio button
    And I press the "Continue" button

    Then I see "Has it been decided that you 'lack mental capacity'?" on the page
    When I choose the "No" radio button
    And I press the "Continue" button

	#deferral
    When I set the radio button to "No, I need to change the date"
    And I press the "Continue" button

    When I set text area with "id" of "deferralReason" to "Deferral Reason"
    And I press the "Continue" button

    When I set the "First" single date field to a Monday "6" weeks in the future
    When I set the "Second" single date field to a Monday "7" weeks in the future
    When I set the "Third" single date field to a Monday "8" weeks in the future

    And I press the "Continue" button

	#check dates screen
    And I choose the "Yes" radio button
    And I press the "Continue" button

    Then I see "Will you need help when you're at the court?" on the page
    Then I see "Do you have a disability or impairment that means you’ll need extra support or facilities in the court building where you are doing your Jury Service?" on the page
    When I choose the "Yes" radio button
    Then I check the "Diabetes" checkbox
    And I press the "Continue" button
    Then I see "Check your answers now" on the page

    Then I check the "The information I have given is true to the best of my knowledge" checkbox

    When I press the "Submit" button

    Then I see "You have completed your reply" on the page
    Then I see "<juror_number_eight>" on the page

	#RESPONSE 9
	#1st excusal
    Given I am on "Public" "ithc"

    Then I see "Reply to a jury summons" on the page

    And I set the radio button to "I am replying for myself"
    And I press the "Continue" button
    Then I see "Your juror details" on the page

	#Juror Log In
    When I set "9-digit juror number" to "<juror_number_nine>"
    When I set "Juror last name" to "<last_name>"
    When I set "Juror postcode" to "<postcode>"
    And I press the "Continue" button

	#Check Name
    When I choose the "Yes" radio button
    When I press the "Continue" button

	#Check Address
    When I choose the "Yes" radio button
    And I press the "Continue" button

	#Phone Details
    When I set "Main phone" to "0207 821 1818"
    And I press the "Continue" button

	#Email
    When I set "Enter your email address" to "<email>"
    And I set "Enter your email address again" to "<email>"
    And I press the "Continue" button

	#DoB
    When I set "Day" to "27"
    And I set "Month" to "04"
    And I set "Year" to "1981"
    And I press the "Continue" button

    When I press the "Continue" button

	#Residency
    When I choose the "Yes" radio button
    And I press the "Continue" button

	#CJS
    When I choose the "No" radio button
    And I press the "Continue" button

	#Bail
    When I choose the "No" radio button
    And I press the "Continue" button

	#Convictions
    When I choose the "No" radio button
    And I press the "Continue" button

	#Mental Health part 1
    When I choose the "No" radio button
    And I press the "Continue" button

	#Mental Health part 2
    When I choose the "No" radio button
    And I press the "Continue" button

	#Confirm Date of Jury
    When I set the radio button to "No, I cannot do jury service and need to be excused"
    And I press the "Continue" button

	#Excusal Reason
    When I set text area with "id" of "excusalReason" to "Excuse me please"
    And I press the "Continue" button

	#RA
    When I choose the "No" radio button
    And I press the "Continue" button

	#Check Your Answers Now
    When I check the "The information" checkbox
    And I press the "Submit" button
    And I see "You have completed your reply" on the page

	#RESPONSE 10
	#3rd Deceased
    Given I am on "Public" "ithc"

    And I have submitted a third party English deceased response
      | part_no            | pool_number   | last_name   | postcode   | email   |
      | <juror_number_ten> | <pool_number> | <last_name> | <postcode> | <email> |

	#RESPONSE 11
	#auto processed
    Given I am on "Public" "ithc"

    And I have submitted a first party English straight through response
      | part_no               | pool_number   | last_name   | postcode   | email   |
      | <juror_number_eleven> | <pool_number> | <last_name> | <postcode> | <email> |

    Given I am on "Bureau" "ithc"

    When I log in as "MODTESTBUREAU"

    When I click on the "Search" link
    And I set "Juror's pool number" to "<pool_number>"
    And I press the "Search" button
    And I see "<juror_number>" on the page

    And I click link with ID "selectAllLink"
    And I press the "Send to..." button
    And I set input field with "id" of "sendToOfficer" to "ARAMIS1"
    And I press the "Send" button
    And I press the "Send" button
    Then I see "Your work" on the page

    Then I click on the "Search" link

    And I set "Juror's pool number" to "<pool_number_two>"
    And I press the "Search" button

    And I see "<juror_number_seven>" on the page
    And I click link with ID "selectAllLink"
    And I press the "Send to..." button
    And I set input field with "id" of "sendToOfficer" to "ARAMIS1"
    And I press the "Send" button
    And I press the "Send" button
    Then I see "Your work" on the page

    Then I click on the "Search" link

    And I set "Juror's pool number" to "<pool_number_three>"
    And I press the "Search" button

    And I see "<juror_number_nine>" on the page
    And I click link with ID "selectAllLink"
    And I press the "Send to..." button
    And I set input field with "id" of "sendToOfficer" to "ARAMIS1"
    And I press the "Send" button
    And I press the "Send" button
    Then I see "Your work" on the page

    Then I click on the "Sign out" link
    Given I am on "Bureau" "ithc"

    Given I am on "Bureau" "ithc"

    And I log in as "ARAMIS1"

    Then I see "<juror_number>" has reply type indicator "Needs review"
    Then I see "<juror_number_two>" has reply type indicator "Needs review"
    Then I see "<juror_number_three>" has reply type indicator "Needs review"
    Then I see "<juror_number_four>" has reply type indicator "Needs review"
    Then I see "<juror_number_five>" has reply type indicator "Needs review"
    Then I see "<juror_number_six>" has reply type indicator "Needs review"
    Then I see "<juror_number_seven>" has reply type indicator "Needs review"
    Then I see "<juror_number_eight>" has reply type indicator "Deferral"
    Then I see "<juror_number_nine>" has reply type indicator "Excusal"

    When I click on "<juror_number>" in the same row as "<juror_number>"
    And I see "Ineligible" on the page

    Then I press the "Process reply" button
    Then I choose the "Mark as responded" radio button
    And I press the "Continue" button
    And I check the "Mark juror as 'responded'" checkbox
    And I press the "Confirm" button
    Then I see the juror record updated banner containing "Responded"

    Then I click on the "Back" link

    Then I see "<juror_number_two>" on the page
    When I click on "<juror_number_two>" in the same row as "<juror_number_two>"
    And I see "Ineligible" on the page

    Then I press the "Process reply" button
    Then I choose the "Mark as responded" radio button
    And I press the "Continue" button
    And I check the "Mark juror as 'responded'" checkbox
    And I press the "Confirm" button
    Then I see the juror record updated banner containing "Responded"

    Then I click on the "Back" link

    Then I see "<juror_number_three>" on the page
    When I click on "<juror_number_three>" in the same row as "<juror_number_three>"
    And I see "Ineligible" on the page

    Then I press the "Process reply" button
    Then I choose the "Mark as responded" radio button
    And I press the "Continue" button
    And I check the "Mark juror as 'responded'" checkbox
    And I press the "Confirm" button
    Then I see the juror record updated banner containing "Responded"

    Then I click on the "Back" link

    Then I see "<juror_number_four>" on the page
    When I click on "<juror_number_four>" in the same row as "<juror_number_four>"
    And I see "Ineligible" on the page

    Then I press the "Process reply" button
    Then I choose the "Mark as responded" radio button
    And I press the "Continue" button
    And I check the "Mark juror as 'responded'" checkbox
    And I press the "Confirm" button
    Then I see the juror record updated banner containing "Responded"

    Then I click on the "Back" link

    Then I see "<juror_number_five>" on the page
    When I click on "<juror_number_five>" in the same row as "<juror_number_five>"
    And I see "Ineligible" on the page

    Then I press the "Process reply" button
    Then I choose the "Mark as responded" radio button
    And I press the "Continue" button
    And I check the "Mark juror as 'responded'" checkbox
    And I press the "Confirm" button
    Then I see the juror record updated banner containing "Responded"

    Then I click on the "Back" link

    Then I see "<juror_number_six>" on the page
    When I click on "<juror_number_six>" in the same row as "<juror_number_six>"
    And I see "Ineligible" on the page

    Then I press the "Process reply" button
    Then I choose the "Mark as responded" radio button
    And I press the "Continue" button
    And I check the "Mark juror as 'responded'" checkbox
    And I press the "Confirm" button
    Then I see the juror record updated banner containing "Responded"

    Then I click on the "Back" link

    Then I see "<juror_number_seven>" on the page
    When I click on "<juror_number_seven>" in the same row as "<juror_number_seven>"
    And I see "Needs review" on the page

    Then I press the "Process reply" button
    Then I choose the "Mark as responded" radio button
    And I press the "Continue" button
    And I check the "Mark juror as 'responded'" checkbox
    And I press the "Confirm" button
    Then I see the juror record updated banner containing "Responded"

    Then I click on the "Back" link

    Then I see "<juror_number_eight>" on the page
    When I click on "<juror_number_eight>" in the same row as "<juror_number_eight>"
    And I see "Deferral" on the page

    Then I press the "Process reply" button
    Then I choose the "Mark as responded" radio button
    And I press the "Continue" button
    And I check the "Mark juror as 'responded'" checkbox
    And I press the "Confirm" button
    Then I see the juror record updated banner containing "Responded"

    Then I click on the "Back" link

    Then I see "<juror_number_nine>" on the page
    When I click on "<juror_number_nine>" in the same row as "<juror_number_nine>"
    And I see "Excusal" on the page

    Then I press the "Process reply" button
    Then I choose the "Mark as responded" radio button
    And I press the "Continue" button
    And I check the "Mark juror as 'responded'" checkbox
    And I press the "Confirm" button
    Then I see the juror record updated banner containing "Excusal refused"

    And I click on the "Search" link
    And I set "Juror number" to "<juror_number_ten>"
    And I press the "Search" button

    When I click on "<juror_number_ten>" in the same row as "<juror_number_ten>"
    And I see "Deceased" on the page

    And I click on the "Search" link
    And I set "Juror number" to "<juror_number_eleven>"
    And I press the "Search" button
    And I see "<juror_number_eleven>" on the page

    When I click on "<juror_number_eleven>" in the same row as "<juror_number_eleven>"
    And I see "Auto processed" on the page

    Then I click on the "Your work" link
    Then I click on the "Completed" link

    When I click on "<juror_number>" in the same row as "<juror_number>"
    And I see "Ineligible" on the page

    Then I click on the "Your work" link
    Then I click on the "Completed" link

    When I click on "<juror_number_two>" in the same row as "<juror_number_two>"
    And I see "Ineligible" on the page

    Then I click on the "Your work" link
    Then I click on the "Completed" link

    When I click on "<juror_number_three>" in the same row as "<juror_number_three>"
    And I see "Ineligible" on the page

    Then I click on the "Your work" link
    Then I click on the "Completed" link

    When I click on "<juror_number_four>" in the same row as "<juror_number_four>"
    And I see "Ineligible" on the page

    Then I click on the "Your work" link
    Then I click on the "Completed" link

    When I click on "<juror_number_five>" in the same row as "<juror_number_five>"
    And I see "Ineligible" on the page

    Then I click on the "Your work" link
    Then I click on the "Completed" link

    When I click on "<juror_number_six>" in the same row as "<juror_number_six>"
    And I see "Ineligible" on the page

    Then I click on the "Your work" link
    Then I click on the "Completed" link

    When I click on "<juror_number_seven>" in the same row as "<juror_number_seven>"
    And I see "Needs review" on the page

    Then I click on the "Your work" link
    Then I click on the "Completed" link

    When I click on "<juror_number_eight>" in the same row as "<juror_number_eight>"
    And I see "Deferral" on the page

    Then I click on the "Your work" link
    Then I click on the "Completed" link

    When I click on "<juror_number_nine>" in the same row as "<juror_number_nine>"
    And I see "Excusal" on the page

    Examples:
      | juror_number | juror_number_two | juror_number_three | juror_number_four | juror_number_five | juror_number_six | juror_number_seven | juror_number_eight | juror_number_nine | juror_number_ten | juror_number_eleven | last_name | postcode | email             | pool_number | pool_number_two | pool_number_three |
      | 045200144    | 045200145        | 045200146          | 045200147         | 045200148         | 045200149        | 045200150          | 045200151          | 045200152         | 045200153        | 045200154           | LNAME     | SY2 6LU  | email@outlook.com | 452300143   | 452300144       | 452300145         |


  @RegressionSingle
  Scenario Outline: Multiple reply types in Awaiting Information

    Given I am on "Public" "ithc"

    Given auto straight through processing has been enabled new schema

    Given a bureau owned pool is created with jurors
      | court | juror_number         | pool_number   | att_date_weeks_in_future | owner |
      | 452   | <juror_number>       | <pool_number> | 5                        | 400   |
      | 452   | <juror_number_two>   | <pool_number> | 5                        | 400   |
      | 452   | <juror_number_three> | <pool_number> | 5                        | 400   |
      | 452   | <juror_number_four>  | <pool_number> | 5                        | 400   |
      | 452   | <juror_number_five>  | <pool_number> | 5                        | 400   |
      | 452   | <juror_number_six>   | <pool_number> | 5                        | 400   |
      | 452   | <juror_number_eight> | <pool_number> | 5                        | 400   |

    Given a bureau owned pool is created with jurors
      | court | juror_number         | pool_number       | att_date_weeks_in_future | owner |
      | 452   | <juror_number_seven> | <pool_number_two> | 5                        | 400   |

    Given a bureau owned pool is created with jurors
      | court | juror_number        | pool_number         | att_date_weeks_in_future | owner |
      | 452   | <juror_number_nine> | <pool_number_three> | 5                        | 400   |

    And juror "<juror_number>" has "LAST_NAME" as "<last_name>" new schema
    And juror "<juror_number>" has "POSTCODE" as "<postcode>" new schema

    And juror "<juror_number_two>" has "LAST_NAME" as "<last_name>" new schema
    And juror "<juror_number_two>" has "POSTCODE" as "<postcode>" new schema

    And juror "<juror_number_three>" has "LAST_NAME" as "<last_name>" new schema
    And juror "<juror_number_three>" has "POSTCODE" as "<postcode>" new schema

    And juror "<juror_number_four>" has "LAST_NAME" as "<last_name>" new schema
    And juror "<juror_number_four>" has "POSTCODE" as "<postcode>" new schema

    And juror "<juror_number_five>" has "LAST_NAME" as "<last_name>" new schema
    And juror "<juror_number_five>" has "POSTCODE" as "<postcode>" new schema

    And juror "<juror_number_six>" has "LAST_NAME" as "<last_name>" new schema
    And juror "<juror_number_six>" has "POSTCODE" as "<postcode>" new schema

    And juror "<juror_number_seven>" has "LAST_NAME" as "<last_name>" new schema
    And juror "<juror_number_seven>" has "POSTCODE" as "<postcode>" new schema

    And juror "<juror_number_eight>" has "LAST_NAME" as "<last_name>" new schema
    And juror "<juror_number_eight>" has "POSTCODE" as "<postcode>" new schema

    And juror "<juror_number_nine>" has "LAST_NAME" as "<last_name>" new schema
    And juror "<juror_number_nine>" has "POSTCODE" as "<postcode>" new schema

	#RESPONSE 1
	#3rd party MH
    Given I am on "Public" "ithc"

    And I set the radio button to "I am replying for someone else"
    And I press the "Continue" button

	#Juror Log In
    When I set "9-digit juror number" to "<juror_number>"
    When I set "Juror last name" to "<last_name>"
    When I set "Juror postcode" to "<postcode>"
    And I press the "Continue" button

	#3rd Party Name
    When I set "First name" to "FirstNameA"
    And I set "Last name" to "LastNameB"
    And I press the "Continue" button

	#Relationship to juror
    And I set "How do you know the person you're replying for?" to "Friend"
    And I press the "Continue" button

	#3rd Party Contact
    And I check the "By phone (UK Numbers only)" checkbox
    And I set "Main phone" to "0207 821 1818"
    And I check the "By email" checkbox
    And I set "Enter your email address" to "<email>"
    And I set "Enter your email address again" to "<email>"
    And I press the "Continue" button

	#Why are you replying for the person?
    When I set the radio button to "The person is not here"
    And I press the "Continue" button

	#Check juror name
    And I choose the "Yes" radio button
    And I press the "Continue" button

	#Check juror address
    And I choose the "Yes" radio button
    And I press the "Continue" button

	#DoB
    And I set "Day" to "01"
    And I set "Month" to "01"
    And I set "Year" to "1980"
    And I press the "Continue" button

	#Contacting the juror
    And I set the radio button to "Use the phone number that you have already given to contact you"
    And I set the radio button to "Use the email address that you have already given to contact you"
    And I press the "Continue" button

	#Qualify for jury service
    And I press the "Continue" button

	#Residency
    And I choose the "Yes" radio button
    And I press the "Continue" button

	#CJS
    When I choose the "No" radio button
    And I press the "Continue" button

	#Bail
    And I choose the "No" radio button
    And I press the "Continue" button

	#Convictions
    When I choose the "No" radio button
    And I press the "Continue" button

	#Mental Health Sectioned
    And I choose the "Yes" radio button
    And I set "Provide details about how they're being detained, looked after or treated under the Mental Health Act" to "some details"
    And I press the "Continue" button

	#Mental Health Capacity
    And I choose the "Yes" radio button
    And I set "Provide brief details about why it was decided they lack mental capacity" to "some details"
    And I press the "Continue" button

	#Confirm Date of Jury
    When I choose the "Yes" radio button
    And I press the "Continue" button

	#RA
    When I choose the "No" radio button
    And I press the "Continue" button

	#Check Your Answers
    When I check the "The answers I have given for the person I'm replying for are true as far as I know" checkbox
    And I press the "Submit" button
    And I see "You have completed your reply" on the page

	#RESPONSE 2
	#3rd party bail
    Given I am on "Public" "ithc"

    And I set the radio button to "I am replying for someone else"
    And I press the "Continue" button

	#Juror Log In
    When I set "9-digit juror number" to "<juror_number_two>"
    When I set "Juror last name" to "<last_name>"
    When I set "Juror postcode" to "<postcode>"
    And I press the "Continue" button

	#3rd Party Name
    When I set "First name" to "FirstNameA"
    And I set "Last name" to "LastNameB"
    And I press the "Continue" button

	#Relationship to juror
    And I set "How do you know the person you're replying for?" to "Friend"
    And I press the "Continue" button

	#3rd Party Contact
    And I check the "By phone (UK Numbers only)" checkbox
    And I set "Main phone" to "0207 821 1818"
    And I check the "By email" checkbox
    And I set "Enter your email address" to "<email>"
    And I set "Enter your email address again" to "<email>"
    And I press the "Continue" button

	#Why are you replying for the person?
    When I set the radio button to "The person is not here"
    And I press the "Continue" button

	#Check juror name
    And I choose the "Yes" radio button
    And I press the "Continue" button

	#Check juror address
    And I choose the "Yes" radio button
    And I press the "Continue" button

	#DoB
    And I set "Day" to "01"
    And I set "Month" to "01"
    And I set "Year" to "1980"
    And I press the "Continue" button

	#Contacting the juror
    And I set the radio button to "Use the phone number that you have already given to contact you"
    And I set the radio button to "Use the email address that you have already given to contact you"
    And I press the "Continue" button

	#Qualify for jury service
    And I press the "Continue" button

	#Residency
    And I choose the "Yes" radio button
    And I press the "Continue" button

	#CJS
    When I choose the "No" radio button
    And I press the "Continue" button

	#Bail
    And I choose the "Yes" radio button
    And I set "Provide details about the person's bail and criminal offence" to "some details"
    And I press the "Continue" button

	#Convictions
    When I choose the "No" radio button
    And I press the "Continue" button

	#Mental Health Sectioned
    And I choose the "No" radio button
    And I press the "Continue" button

	#Mental Health Capacity
    And I choose the "No" radio button
    And I press the "Continue" button

	#Confirm Date of Jury
    When I choose the "Yes" radio button
    And I press the "Continue" button

	#RA
    When I choose the "No" radio button
    And I press the "Continue" button

	#Check Your Answers
    When I check the "The answers I have given for the person I'm replying for are true as far as I know" checkbox
    And I press the "Submit" button
    And I see "You have completed your reply" on the page

	#RESPONSE 3
	#3rd party residency
    Given I am on "Public" "ithc"
    And I set the radio button to "I am replying for someone else"
    And I press the "Continue" button

	#Juror Log In
    When I set "9-digit juror number" to "<juror_number_three>"
    When I set "Juror last name" to "<last_name>"
    When I set "Juror postcode" to "<postcode>"
    And I press the "Continue" button

	#3rd Party Name
    When I set "First name" to "FirstNameA"
    And I set "Last name" to "LastNameB"
    And I press the "Continue" button

	#Relationship to juror
    And I set "How do you know the person you're replying for?" to "Friend"
    And I press the "Continue" button

	#3rd Party Contact
    And I check the "By phone (UK Numbers only)" checkbox
    And I set "Main phone" to "0207 821 1818"
    And I check the "By email" checkbox
    And I set "Enter your email address" to "<email>"
    And I set "Enter your email address again" to "<email>"
    And I press the "Continue" button

	#Why are you replying for the person?
    When I set the radio button to "The person is not here"
    And I press the "Continue" button

	#Check juror name
    And I choose the "Yes" radio button
    And I press the "Continue" button

	#Check juror address
    And I choose the "Yes" radio button
    And I press the "Continue" button

	#DoB
    And I set "Day" to "01"
    And I set "Month" to "01"
    And I set "Year" to "1980"
    And I press the "Continue" button

	#Contacting the juror
    And I set the radio button to "Use the phone number that you have already given to contact you"
    And I set the radio button to "Use the email address that you have already given to contact you"
    And I press the "Continue" button

	#Qualify for jury service
    And I press the "Continue" button

	#Residency
    And I choose the "No" radio button
    And I set "Provide details about where the person you are answering for has lived since their 13th birthday" to "some details"
    And I press the "Continue" button

	#CJS
    When I choose the "No" radio button
    And I press the "Continue" button

	#Bail
    And I choose the "No" radio button
    And I press the "Continue" button

	#Convictions
    When I choose the "No" radio button
    And I press the "Continue" button

	#Mental Health Sectioned
    And I choose the "No" radio button
    And I press the "Continue" button

	#Mental Health Capacity
    And I choose the "No" radio button
    And I press the "Continue" button

	#Confirm Date of Jury
    When I choose the "Yes" radio button
    And I press the "Continue" button

	#RA
    When I choose the "No" radio button
    And I press the "Continue" button

	#Check Your Answers
    When I check the "The answers I have given for the person I'm replying for are true as far as I know" checkbox
    And I press the "Submit" button
    And I see "You have completed your reply" on the page

	#RESPONSE 4
	#3rd party convictions
    Given I am on "Public" "ithc"
    And I set the radio button to "I am replying for someone else"
    And I press the "Continue" button

	#Juror Log In
    When I set "9-digit juror number" to "<juror_number_four>"
    When I set "Juror last name" to "<last_name>"
    When I set "Juror postcode" to "<postcode>"
    And I press the "Continue" button

	#3rd Party Name
    When I set "First name" to "FirstNameA"
    And I set "Last name" to "LastNameB"
    And I press the "Continue" button

	#Relationship to juror
    And I set "How do you know the person you're replying for?" to "Friend"
    And I press the "Continue" button

	#3rd Party Contact
    And I check the "By phone (UK Numbers only)" checkbox
    And I set "Main phone" to "0207 821 1818"
    And I check the "By email" checkbox
    And I set "Enter your email address" to "<email>"
    And I set "Enter your email address again" to "<email>"
    And I press the "Continue" button

	#Why are you replying for the person?
    When I set the radio button to "The person is not here"
    And I press the "Continue" button

	#Check juror name
    And I choose the "Yes" radio button
    And I press the "Continue" button

	#Check juror address
    And I choose the "Yes" radio button
    And I press the "Continue" button

	#DoB
    When I set the date of birth to a Monday "-2950" weeks in the future
    And I press the "Continue" button

	#Contacting the juror
    And I set the radio button to "Use the phone number that you have already given to contact you"
    And I set the radio button to "Use the email address that you have already given to contact you"
    And I press the "Continue" button

	#Qualify for jury service
    And I press the "Continue" button

	#Residency
    And I choose the "Yes" radio button
    And I press the "Continue" button

	#CJS
    When I choose the "No" radio button
    And I press the "Continue" button

	#Bail
    And I choose the "No" radio button
    And I press the "Continue" button

	#Convictions
    When I choose the "Yes" radio button
    And I set text area with "id" of "convictedDetails" to "I am a convicted criminal"
    And I press the "Continue" button

	#Mental Health Sectioned
    And I choose the "No" radio button
    And I press the "Continue" button

	#Mental Health Capacity
    And I choose the "No" radio button
    And I press the "Continue" button

	#Confirm Date of Jury
    When I choose the "Yes" radio button
    And I press the "Continue" button

	#RA
    When I choose the "No" radio button
    And I press the "Continue" button

	#Check Your Answers
    When I check the "The answers I have given for the person I'm replying for are true as far as I know" checkbox
    And I press the "Submit" button
    And I see "You have completed your reply" on the page

	#RESPONSE 5
	#1st bail
    Given I am on "Public" "ithc"

    And I set the radio button to "I am replying for myself"
    And I press the "Continue" button
    Then I see "Your juror details" on the page

    When I set "9-digit juror number" to "<juror_number_five>"
    When I set "Juror last name" to "<last_name>"
    When I set "Juror postcode" to "<postcode>"
    And I press the "Continue" button

    Then I see "Is the name we have for you correct?" on the page
    And I choose the "Yes" radio button
    And I press the "Continue" button

    And I choose the "Yes" radio button
    And I press the "Continue" button

    When I set "Main phone" to "02078211818"
    And I press the "Continue" button

    When I set "Enter your email address" to "<email>"
    When I set "Enter your email address again" to "<email>"
    And I press the "Continue" button

    When I set "Day" to "27"
    And I set "Month" to "04"
    And I set "Year" to "1981"
    And I press the "Continue" button

    Then I see "Confirm you're eligible for jury service" on the page

    And I press the "Continue" button

    Then I see "Since you turned 13, has your main address been in the UK, Channel Islands or Isle of Man for any period of at least 5 years?" on the page
    And I choose the "Yes" radio button
    And I press the "Continue" button

    Then I see "Have you worked in the criminal justice system in the last 5 years?" on the page
    When I choose the "No" radio button
    And I press the "Continue" button

    And I see "Are you currently on bail for a criminal offence?" on the page
    When I choose the "Yes" radio button
    Then I set "Provide details about your bail and criminal offence" to "some details"
    And I press the "Continue" button

    Then I see "Have you been found guilty of a criminal offence?" on the page
    When I choose the "No" radio button
    And I press the "Continue" button

    And I see "Are you being detained, looked after or treated under the Mental Health Act?" on the page
    When I choose the "No" radio button
    And I press the "Continue" button

    Then I see "Has it been decided that you 'lack mental capacity'?" on the page
    When I choose the "No" radio button
    And I press the "Continue" button

	#Straight through
    When I choose the "Yes" radio button
    And I press the "Continue" button

    Then I see "Will you need help when you're at the court?" on the page
    Then I see "Do you have a disability or impairment that means you’ll need extra support or facilities in the court building where you are doing your Jury Service?" on the page
    When I choose the "No" radio button
    And I press the "Continue" button

    Then I see "Check your answers now" on the page
    Then I check the "The information I have given is true to the best of my knowledge" checkbox
    When I press the "Submit" button

    Then I see "You have completed your reply" on the page
    Then I see "<juror_number_five>" on the page

	#RESPONSE 6
	#1st residency
    Given I am on "Public" "ithc"

    And I set the radio button to "I am replying for myself"
    And I press the "Continue" button
    Then I see "Your juror details" on the page

    When I set "9-digit juror number" to "<juror_number_six>"
    When I set "Juror last name" to "<last_name>"
    When I set "Juror postcode" to "<postcode>"
    And I press the "Continue" button

    Then I see "Is the name we have for you correct?" on the page
    And I choose the "Yes" radio button
    And I press the "Continue" button

    And I choose the "Yes" radio button
    And I press the "Continue" button

    When I set "Main phone" to "02078211818"
    And I press the "Continue" button

    When I set "Enter your email address" to "<email>"
    When I set "Enter your email address again" to "<email>"
    And I press the "Continue" button

    When I set "Day" to "27"
    And I set "Month" to "04"
    And I set "Year" to "1981"
    And I press the "Continue" button

    Then I see "Confirm you're eligible for jury service" on the page

    And I press the "Continue" button

    Then I see "Since you turned 13, has your main address been in the UK, Channel Islands or Isle of Man for any period of at least 5 years?" on the page
    And I choose the "No" radio button
    And I set "Provide details" to "some reasons"
    And I press the "Continue" button

    Then I see "Have you worked in the criminal justice system in the last 5 years?" on the page
    When I choose the "No" radio button
    And I press the "Continue" button

    And I see "Are you currently on bail for a criminal offence?" on the page
    When I choose the "No" radio button
    And I press the "Continue" button

    Then I see "Have you been found guilty of a criminal offence?" on the page
    When I choose the "No" radio button
    And I press the "Continue" button

    And I see "Are you being detained, looked after or treated under the Mental Health Act?" on the page
    When I choose the "No" radio button
    And I press the "Continue" button

    Then I see "Has it been decided that you 'lack mental capacity'?" on the page
    When I choose the "No" radio button
    And I press the "Continue" button

	#Straight through
    When I choose the "Yes" radio button
    And I press the "Continue" button

    Then I see "Will you need help when you're at the court?" on the page
    Then I see "Do you have a disability or impairment that means you’ll need extra support or facilities in the court building where you are doing your Jury Service?" on the page
    When I choose the "No" radio button
    And I press the "Continue" button

    Then I see "Check your answers now" on the page
    Then I check the "The information I have given is true to the best of my knowledge" checkbox
    When I press the "Submit" button

    Then I see "You have completed your reply" on the page
    Then I see "<juror_number_six>" on the page

	#RESPONSE 7
	#1st details change
    Given I am on "Public" "ithc"

    And I set the radio button to "I am replying for myself"

    And I press the "Continue" button

    And I see "Your juror details" on the page

    When I set "9-digit juror number" to "<juror_number_seven>"
    And I set "Juror last name" to "<last_name>"
    And I set "Juror postcode" to "<postcode>"
    And I press the "Continue" button

    And I choose the "No" radio button
    And I press the "Continue" button
    And I set "First name" to "Joe"
    And I set "Last name" to "Blogs"

    And I press the "Continue" button

    And I choose the "No" radio button
    When I press the "Continue" button
    And I set "Address line 1" to "99 The Road"
    And I set "Town or city" to "Town"

    When I press the "Continue" button

    When I set "Main phone" to "02078211818"
    And I press the "Continue" button

    When I set "Enter your email address" to "<email>"
    When I set "Enter your email address again" to "<email>"

    And I press the "Continue" button

    When I set "Day" to "01"
    And I set "Month" to "01"
    And I set "Year" to "1990"
    And I press the "Continue" button

	#Qualify for jury service
	#JDB-4636
    When I press the "Continue" button

	#Residency
    And I choose the "Yes" radio button
    And I press the "Continue" button

	#CJS
    When I choose the "No" radio button
    And I press the "Continue" button

	#Bail
    When I choose the "No" radio button
    And I press the "Continue" button

	#Convictions
    When I choose the "No" radio button
    And I press the "Continue" button

	#Mental Health Sectioned
    And I choose the "No" radio button
    And I press the "Continue" button

	#Mental Health Capacity
    And I choose the "No" radio button
    And I press the "Continue" button

	#I can attend
    And I set the radio button to "Yes, I can start on"
    And  I press the "Continue" button

	#RA no
    When I choose the "No" radio button
    And I press the "Continue" button

	#Check your answers
    Then I see "Check your answers now" on the page
    Then I check the "The information I have given is true to the best of my knowledge" checkbox
    When I press the "Submit" button

    Then I see "You have completed your reply" on the page
    Then I see "<juror_number_seven>" on the page

	#RESPONSE 8
	#1st deferral
    Given I am on "Public" "ithc"

    Then I see "Reply to a jury summons" on the page

    And I set the radio button to "I am replying for myself"
    And I press the "Continue" button
    Then I see "Your juror details" on the page

    When I set "9-digit juror number" to "<juror_number_eight>"
    When I set "Juror last name" to "<last_name>"
    When I set "Juror postcode" to "<postcode>"
    And I press the "Continue" button

    Then I see "Is the name we have for you correct?" on the page
    And I choose the "Yes" radio button
    And I press the "Continue" button

    And I choose the "Yes" radio button
    And I press the "Continue" button

    When I set "Main phone" to "02078211818"
    And I press the "Continue" button

    When I set "Enter your email address" to "<email>"
    When I set "Enter your email address again" to "<email>"
    And I press the "Continue" button

    When I set "Day" to "27"
    And I set "Month" to "04"
    And I set "Year" to "1981"
    And I press the "Continue" button

    Then I see "Confirm you're eligible for jury service" on the page

    And I press the "Continue" button

    Then I see "Since you turned 13, has your main address been in the UK, Channel Islands or Isle of Man for any period of at least 5 years?" on the page
    And I choose the "Yes" radio button
    And I press the "Continue" button

    Then I see "Have you worked in the criminal justice system in the last 5 years?" on the page
    When I choose the "No" radio button
    And I press the "Continue" button

    And I see "Are you currently on bail for a criminal offence?" on the page
    When I choose the "No" radio button
    And I press the "Continue" button

    Then I see "Have you been found guilty of a criminal offence?" on the page
    When I choose the "No" radio button
    And I press the "Continue" button

    And I see "Are you being detained, looked after or treated under the Mental Health Act?" on the page
    When I choose the "No" radio button
    And I press the "Continue" button

    Then I see "Has it been decided that you 'lack mental capacity'?" on the page
    When I choose the "No" radio button
    And I press the "Continue" button

	#deferral
    When I set the radio button to "No, I need to change the date"
    And I press the "Continue" button

    When I set text area with "id" of "deferralReason" to "Deferral Reason"
    And I press the "Continue" button

    When I set the "First" single date field to a Monday "14" weeks in the future
    When I set the "Second" single date field to a Monday "13" weeks in the future
    When I set the "Third" single date field to a Monday "12" weeks in the future

    And I press the "Continue" button

	#check dates screen
    And I choose the "Yes" radio button
    And I press the "Continue" button

    Then I see "Will you need help when you're at the court?" on the page
    Then I see "Do you have a disability or impairment that means you’ll need extra support or facilities in the court building where you are doing your Jury Service?" on the page
    When I choose the "Yes" radio button
    Then I check the "Diabetes" checkbox
    And I press the "Continue" button
    Then I see "Check your answers now" on the page

    Then I check the "The information I have given is true to the best of my knowledge" checkbox

    When I press the "Submit" button

    Then I see "You have completed your reply" on the page
    Then I see "<juror_number_eight>" on the page

	#RESPONSE 9
	#1st excusal
    Given I am on "Public" "ithc"

    Then I see "Reply to a jury summons" on the page

    And I set the radio button to "I am replying for myself"
    And I press the "Continue" button
    Then I see "Your juror details" on the page

	#Juror Log In
    When I set "9-digit juror number" to "<juror_number_nine>"
    When I set "Juror last name" to "<last_name>"
    When I set "Juror postcode" to "<postcode>"
    And I press the "Continue" button

	#Check Name
    When I choose the "Yes" radio button
    When I press the "Continue" button

	#Check Address
    When I choose the "Yes" radio button
    And I press the "Continue" button

	#Phone Details
    When I set "Main phone" to "0207 821 1818"
    And I press the "Continue" button

	#Email
    When I set "Enter your email address" to "<email>"
    And I set "Enter your email address again" to "<email>"
    And I press the "Continue" button

	#DoB
    When I set "Day" to "27"
    And I set "Month" to "04"
    And I set "Year" to "1981"
    And I press the "Continue" button

    When I press the "Continue" button

	#Residency
    When I choose the "Yes" radio button
    And I press the "Continue" button

	#CJS
    When I choose the "No" radio button
    And I press the "Continue" button

	#Bail
    When I choose the "No" radio button
    And I press the "Continue" button

	#Convictions
    When I choose the "No" radio button
    And I press the "Continue" button

	#Mental Health part 1
    When I choose the "No" radio button
    And I press the "Continue" button

	#Mental Health part 2
    When I choose the "No" radio button
    And I press the "Continue" button

	#Confirm Date of Jury
    When I set the radio button to "No, I cannot do jury service and need to be excused"
    And I press the "Continue" button

	#Excusal Reason
    When I set text area with "id" of "excusalReason" to "Excuse me please"
    And I press the "Continue" button

	#RA
    When I choose the "No" radio button
    And I press the "Continue" button

	#Check Your Answers Now
    When I check the "The information" checkbox
    And I press the "Submit" button
    And I see "You have completed your reply" on the page

	#BUREAU
    Given I am on "Bureau" "ithc"
    And I log in as "MODTESTBUREAU"

    When I click on the "Search" link
    And I set "Juror's pool number" to "<pool_number>"
    And I press the "Search" button
    And I see "<juror_number>" on the page

    And I click link with ID "selectAllLink"
    And I press the "Send to..." button
    And I set input field with "id" of "sendToOfficer" to "CPASS"
    And I press the "Send" button
    And I press the "Send" button
    Then I see "Your work" on the page

    Then I click on the "Search" link

    And I set "Juror's pool number" to "<pool_number_two>"
    And I press the "Search" button

    And I see "<juror_number_seven>" on the page
    And I click link with ID "selectAllLink"
    And I press the "Send to..." button
    And I set input field with "id" of "sendToOfficer" to "CPASS"
    And I press the "Send" button
    And I press the "Send" button
    Then I see "Your work" on the page

    Then I click on the "Search" link

    And I set "Juror's pool number" to "<pool_number_three>"
    And I press the "Search" button

    And I see "<juror_number_nine>" on the page
    And I click link with ID "selectAllLink"
    And I press the "Send to..." button
    And I set input field with "id" of "sendToOfficer" to "CPASS"
    And I press the "Send" button
    And I press the "Send" button
    Then I see "Your work" on the page

    Then I click on the "Sign out" link
    Given I am on "Bureau" "ithc"

    Given I am on "Bureau" "ithc"
    When I log in as "CPASS"

	#Then I take a screenshot

    Then I see "<juror_number>" has reply type indicator "Needs review"
    Then I see "<juror_number_two>" has reply type indicator "Needs review"
    Then I see "<juror_number_three>" has reply type indicator "Needs review"
    Then I see "<juror_number_four>" has reply type indicator "Needs review"
    Then I see "<juror_number_five>" has reply type indicator "Needs review"
    Then I see "<juror_number_six>" has reply type indicator "Needs review"
    Then I see "<juror_number_seven>" has reply type indicator "Needs review"
    Then I see "<juror_number_eight>" has reply type indicator "Deferral"
    Then I see "<juror_number_nine>" has reply type indicator "Excusal"

    When I click on "<juror_number>" in the same row as "<juror_number>"

	#Then I take a screenshot
    And I see "Ineligible" on the page

    Then I press the "More actions" button
    Then I click on the "Mark as awaiting information" link
    And I set the radio button to "Juror"
    And I press the "Confirm" button
    Then I see "AWAITING JUROR INFO" on the page

    And I click on the "Your work" link

    Then I see "<juror_number_two>" on the page
    When I click on "<juror_number_two>" in the same row as "<juror_number_two>"
	
	#Then I take a screenshot
    And I see "Ineligible" on the page

    Then I press the "More actions" button
    Then I click on the "Mark as awaiting information" link
    And I set the radio button to "Juror"
    And I press the "Confirm" button
    Then I see "AWAITING JUROR INFO" on the page

    And I click on the "Your work" link

    Then I see "<juror_number_three>" on the page
    When I click on "<juror_number_three>" in the same row as "<juror_number_three>"
	
	#Then I take a screenshot
    And I see "Ineligible" on the page

    Then I press the "More actions" button
    Then I click on the "Mark as awaiting information" link
    And I set the radio button to "Juror"
    And I press the "Confirm" button
    Then I see "AWAITING JUROR INFO" on the page

    And I click on the "Your work" link

    Then I see "<juror_number_four>" on the page
    When I click on "<juror_number_four>" in the same row as "<juror_number_four>"
	
	#Then I take a screenshot
    And I see "Ineligible" on the page

    Then I press the "More actions" button
    Then I click on the "Mark as awaiting information" link
    And I set the radio button to "Juror"
    And I press the "Confirm" button
    Then I see "AWAITING JUROR INFO" on the page

    And I click on the "Your work" link

    Then I see "<juror_number_five>" on the page
    When I click on "<juror_number_five>" in the same row as "<juror_number_five>"
	
	#Then I take a screenshot
    And I see "Ineligible" on the page

    Then I press the "More actions" button
    Then I click on the "Mark as awaiting information" link
    And I set the radio button to "Juror"
    And I press the "Confirm" button
    Then I see "AWAITING JUROR INFO" on the page

    And I click on the "Your work" link

    Then I see "<juror_number_six>" on the page
    When I click on "<juror_number_six>" in the same row as "<juror_number_six>"
	
	#Then I take a screenshot
    And I see "Ineligible" on the page

    Then I press the "More actions" button
    Then I click on the "Mark as awaiting information" link
    And I set the radio button to "Juror"
    And I press the "Confirm" button
    Then I see "AWAITING JUROR INFO" on the page

    And I click on the "Your work" link

    Then I see "<juror_number_seven>" on the page
    When I click on "<juror_number_seven>" in the same row as "<juror_number_seven>"
	
	#Then I take a screenshot
    And I see "Needs review" on the page

    Then I press the "More actions" button
    Then I click on the "Mark as awaiting information" link
    And I set the radio button to "Juror"
    And I press the "Confirm" button
    Then I see "AWAITING JUROR INFO" on the page

    And I click on the "Your work" link

    Then I see "<juror_number_eight>" on the page
    When I click on "<juror_number_eight>" in the same row as "<juror_number_eight>"
	
	#Then I take a screenshot
    And I see "Deferral" on the page

    Then I press the "More actions" button
    Then I click on the "Mark as awaiting information" link
    And I set the radio button to "Juror"
    And I press the "Confirm" button
    Then I see "AWAITING JUROR INFO" on the page

    And I click on the "Your work" link

    Then I see "<juror_number_nine>" on the page
    When I click on "<juror_number_nine>" in the same row as "<juror_number_nine>"
	
	#Then I take a screenshot
    And I see "Excusal" on the page

    Then I press the "More actions" button
    Then I click on the "Mark as awaiting information" link
    And I set the radio button to "Juror"
    And I press the "Confirm" button
    Then I see "AWAITING JUROR INFO" on the page

    Then I click on the "Your work" link
    Then I click on the "Awaiting information" link

    When I click on "<juror_number>" in the same row as "<juror_number>"
	
	#Then I take a screenshot
    And I see "Needs review" on the page

    Then I click on the "Your work" link
    Then I click on the "Awaiting information" link

    When I click on "<juror_number_two>" in the same row as "<juror_number_two>"
	
	#Then I take a screenshot
    And I see "Needs review" on the page

    Then I click on the "Your work" link
    Then I click on the "Awaiting information" link

    When I click on "<juror_number_three>" in the same row as "<juror_number_three>"
	
	#Then I take a screenshot
    And I see "Needs review" on the page

    Then I click on the "Your work" link
    Then I click on the "Awaiting information" link

    When I click on "<juror_number_four>" in the same row as "<juror_number_four>"
	
	#Then I take a screenshot
    And I see "Needs review" on the page

    Then I click on the "Your work" link
    Then I click on the "Awaiting information" link

    When I click on "<juror_number_five>" in the same row as "<juror_number_five>"
	
	#Then I take a screenshot
    And I see "Needs review" on the page

    Then I click on the "Your work" link
    Then I click on the "Awaiting information" link

    When I click on "<juror_number_six>" in the same row as "<juror_number_six>"
	
	#Then I take a screenshot
    And I see "Needs review" on the page

    Then I click on the "Your work" link
    Then I click on the "Awaiting information" link

    When I click on "<juror_number_seven>" in the same row as "<juror_number_seven>"
	
	#Then I take a screenshot
    And I see "Needs review" on the page

    Then I click on the "Your work" link
    Then I click on the "Awaiting information" link

    When I click on "<juror_number_eight>" in the same row as "<juror_number_eight>"
	
	#Then I take a screenshot
    And I see "Needs review" on the page

    Then I click on the "Your work" link
    Then I click on the "Awaiting information" link

    When I click on "<juror_number_nine>" in the same row as "<juror_number_nine>"
	
	#Then I take a screenshot
    And I see "Needs review" on the page

    Examples:
      | juror_number | juror_number_two | juror_number_three | juror_number_four | juror_number_five | juror_number_six | juror_number_seven | juror_number_eight | juror_number_nine | last_name | postcode | email             | pool_number | pool_number_two | pool_number_three |
      | 045200155    | 045200156        | 045200157          | 045200158         | 045200159         | 045200160        | 045200161          | 045200162          | 045200163         | LNAME     | SY2 6LU  | email@outlook.com | 452300146   | 452300147       | 452300148         |