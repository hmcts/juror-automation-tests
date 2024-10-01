Feature: Regression English_3rd_Deferral

  @Features @JM-7065
  Scenario Outline: English 3rd Party Deferral

	#return to @Regression when defect fixed

    Given I am on "Public" "test"

    Given a bureau owned pool is created with jurors
      | court | juror_number   | pool_number   | att_date_weeks_in_future | owner |
      | 452   | <juror_number> | <pool_number> | 5                        | 400   |

    And juror "<juror_number>" has "LAST_NAME" as "<last_name>" new schema
    And juror "<juror_number>" has "POSTCODE" as "<postcode>" new schema

    Then I see "Reply to a jury summons" on the page

    And I set the radio button to "I am replying for someone else"
    And I press the "Continue" button
    Then I see "Their juror details" on the page
	
	#Juror Log In
    When I set "9-digit juror number" to "<juror_number>"
    When I set "Juror last name" to "<last_name>"
    When I set "Juror postcode" to "<postcode>"
    And I press the "Continue" button
    Then I see "What is your name?" on the page
	
	#3rd Party Name
    When I see "Your Details" on the page
    When I set "First name" to "FirstNameA"
    And I set "Last name" to "LastNameB"
    And I press the "Continue" button
    Then I see "Your relationship to the person" on the page
	
	#Relationship to juror
    When I see "Your Details" on the page
    And I set "How do you know the person you're replying for?" to "Friend Friend Friend Friend Friend Friend Friend Friend Friend Friend Friend Friend Friend Friend Fr"
    And I press the "Continue" button
    Then I see "Your contact information" on the page
	
	#3rd Party Contact
    When I see "Your Details" on the page
    And I check the "By phone (UK Numbers only)" checkbox
    And I set "Main phone" to "0207 821 1818"
    And I check the "By email" checkbox
    And I set "Enter your email address" to "<email>"
    And I set "Enter your email address again" to "<email>"
    And I press the "Continue" button
	
	#Why are you replying title
    Then I see "Why are you replying for the other person?" on the page
    And I do not see "Why are you replying?" on the page
    When I set the radio button to "The person is not here"
    And I press the "Continue" button
    Then I see "Is the name we have for them correct?" on the page
	
	#Check juror name
    When I see "Juror Details" on the page
    And I choose the "Yes" radio button
    And I press the "Continue" button
    Then I see "Is this their address?" on the page
	
	#Check juror address
    When I see "Juror Details" on the page
    And I choose the "Yes" radio button
    And I press the "Continue" button
    Then I see "Give the date of birth for the person you're replying for" on the page
	
	#DoB
    When I see "Juror Details" on the page
    And I set "Day" to "01"
    And I set "Month" to "01"
	
	#JDB-3418 Checking age 18 works
    And I set "Year" to "2000"
    And I press the "Continue" button
    Then I see "We might need to get in touch with the person to ask them more questions or give them information about their jury service" on the page
	
	#Contacting the juror
    When I see "Juror Details" on the page
    And I set the radio button to "Use the phone number that you have already given to contact you"
    And I set the radio button to "Use the email address that you have already given to contact you"
    And I press the "Continue" button
	
	#Qualify for jury service
    When I see "Confirm if the person is eligible for jury service" on the page
    And I press the "Continue" button
	
	#Residency
    Then I see "Since they turned 13, has their main address been in the UK, Channel Islands or Isle of Man for any period of at least 5 years?" on the page
    When I see "Eligibility" on the page
    And I choose the "Yes" radio button
    And I press the "Continue" button
	
	#Have you ever worke
    Then I see "Has the person you're replying for worked in the criminal justice system in the last 5 years?" on the page
    When I choose the "No" radio button
    And I press the "Continue" button
	
	#Bail
    Then I see "Is the person currently on bail for a criminal offence?" on the page
    When I see "Eligibility" on the page
    And I choose the "No" radio button
    And I press the "Continue" button
	
	#Convictions
    Then I see "Has the person been found guilty of a criminal offence?" on the page
    When I see "Eligibility" on the page
    And I choose the "Yes" radio button
    And I set text area with "id" of "convictedDetails" to "Criminal Convictions"
    And I press the "Continue" button
	
	#Mental Health Sectioned
    Then I see "Is the person you're replying for being detained, looked after or treated under the Mental Health Act?" on the page
    When I see "Eligibility" on the page
    And I choose the "No" radio button
    And I press the "Continue" button
	
	#Mental Health Capacity
    Then I see "Has it been decided that the person you're replying for 'lacks mental capacity'?" on the page
    When I see "Eligibility" on the page
    And I choose the "No" radio button
    And I press the "Continue" button
	
	#Confirm Date of Jury
    Then I see "Check your start date" on the page
    When I set the radio button to "No, we need to change the date"
    And I press the "Continue" button
	
	#Deferral Reason
    And I see "steps/confirm-date/deferral-reason/tp" in the URL
    Then I see "Tell us why they need another date for their jury service" on the page
    When I set text area with "id" of "deferralReason" to "askForAnotherDateReasonWhy"
    And I press the "Continue" button
	
	#JDB-3445 Deferral Date Screen Layout
    And I see "steps/confirm-date/deferral-dates/tp" in the URL
    Then I see "Choose 3 Mondays when they can start jury service" on the page
	
	#check hint text
    Then I click on the "Will they need to serve longer than 2 weeks?" link
    And I see "Most jurors only need to serve 2 weeks." on the page
    And I see "They may be asked to serve for longer when they arrive at court." on the page
    And I see "If they cannot serve for more than 2 weeks, they'll be able to discuss this with the jury manager at court." on the page

    Then I click on the "What if there's a problem nearer the time and they cannot serve?" link
    And I see "You or they must contact us at that time to let us know." on the page
	
	#collapse hint text
    Then I click on the "Will they need to serve longer than 2 weeks?" link
    And I do not see "Most jurors only need to serve 2 weeks." on the page
    And I do not see "They may be asked to serve for longer when they arrive at court." on the page
    And I do not see "If they cannot serve for more than 2 weeks, they'll be able to discuss this with the jury manager at court." on the page

    Then I click on the "What if there's a problem nearer the time and they cannot serve?" link
    And I do not see "You or they must contact us at that time to let us know." on the page

    When I set the "First" single date field to a Monday "9" weeks in the future
    When I set the "Second" single date field to a Monday "10" weeks in the future
    When I set the "Third" single date field to a Monday "11" weeks in the future

    And I press the "Continue" button

    And on the page I see
      | text                                                                            |
      | Check dates                                                                     |
      | Dates they can start jury service                                               |
      | First choice                                                                    |
      | Second choice                                                                   |
      | Third choice                                                                    |
      | You do not need to tell us all other dates they're available.                   |
      | We'll choose one of these 3 dates.                                              |
      | In the unlikely event that we cannot use one of these dates, we'll contact you. |

    And I validate the "First" deferral date is "9" weeks in the future
    And I validate the "Second" deferral date is "10" weeks in the future
    And I validate the "Third" deferral date is "11" weeks in the future
	
	#check hint text
    Then I click on the "Will they need to serve longer than 2 weeks?" link
    And I see "Most jurors only need to serve 2 weeks." on the page
    And I see "They may be asked to serve for longer when they arrive at court." on the page
    And I see "If they cannot serve for more than 2 weeks, they'll be able to discuss this with the jury manager at court." on the page

    Then I click on the "What if there's a problem nearer the time and they cannot serve?" link
    And I see "You or they must contact us at that time to let us know." on the page
	
	#collapse hint text
    Then I click on the "Will they need to serve longer than 2 weeks?" link
    And I do not see "Most jurors only need to serve 2 weeks." on the page
    And I do not see "They may be asked to serve for longer when they arrive at court." on the page
    And I do not see "If they cannot serve for more than 2 weeks, they'll be able to discuss this with the jury manager at court." on the page

    Then I click on the "What if there's a problem nearer the time and they cannot serve?" link
    And I do not see "You or they must contact us at that time to let us know." on the page

    Then I choose the "Yes" radio button
    And I press the "Continue" button
	
	#help at court
    Then I see "Will the person you're replying for need help when they're at the court?" on the page
    When I choose the "No" radio button
    And I press the "Continue" button
	
	#check answers
    And on the page I see
      | text                                                                       |
      | Check your answers now                                                     |
      | Confirm the date of their jury service                                     |
      | I need to change the date of jury service for the person I'm answering for |
      | Tell us why they need another date for their jury service                  |
      | askForAnotherDateReasonWhy                                                 |
      | Choose 3 Mondays when they can start jury service                          |
      | First choice                                                               |
      | Second choice                                                              |
      | Third choice                                                               |

    And I validate the "First" deferral date is "9" weeks in the future
    And I validate the "Second" deferral date is "10" weeks in the future
    And I validate the "Third" deferral date is "11" weeks in the future

    When I check the "The answers I have given for the person I'm replying for are true as far as I know" checkbox
    And I press the "Submit" button

    Then on the page I see
      | text                                                                                                                                                                            |
      | You have completed your reply                                                                                                                                                   |
      | If we get in touch with them, they may need to give their juror number. It's also on the letter we sent them.                                                                   |
      | We have sent an email to say you have replied to this jury summons.                                                                                                             |
      | Download a copy of your summons reply                                                                                                                                           |
      | If they can do jury service, at least 2 weeks before it starts we'll send them:                                                                                                 |
      | a letter confirming the date of their jury service                                                                                                                              |
      | an information pack about being a juror and the court they're going to                                                                                                          |
      | Getting ready for jury service                                                                                                                                                  |
      | The information below is also in the email that we have sent.                                                                                                                   |
      | You or the person you've replied for, can watch this video on YouTube about what happens when you're a juror, so they know what to expect. The video takes 13 minutes to watch. |
      | Learn more about jury service. You can read the rules about discussing the trial and find out how to claim expenses.                                                            |
      | Calculate what expenses and allowances you can claim.                                                                                                                           |
      | What did you think of this service? (Takes 30 seconds)                                                                                                                          |

    And I do not see "Your Guide to Jury Service (PDF 85KB)" on the page

    Then I click on the "Download a copy of your summons reply HTML" link
    And on the page I see
      | text                                                                       |
      | Copy of your jury summons reply                                            |
      | Confirm the date of their jury service                                     |
      | I need to change the date of jury service for the person I'm answering for |
      | Tell us why they need another date for their jury service                  |
      | askForAnotherDateReasonWhy                                                 |
      | Choose 3 Mondays when they can start jury service                          |
      | First choice                                                               |
      | Second choice                                                              |
      | Third choice                                                               |

    And I validate the "First" deferral date is "9" weeks in the future
    And I validate the "Second" deferral date is "10" weeks in the future
    And I validate the "Third" deferral date is "11" weeks in the future

    Given I am on "Bureau" "test"
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
    Given I am on "Bureau" "test"
    And I see "Sign in" on the page
    When I log in as "CPASS"
    Then I see "<juror_number>" on the page
	#JM-7065
    Then I see "<juror_number>" has reply type indicator "INELIGIBLE"

    Examples:
      | juror_number | last_name        | postcode | email             | pool_number |
      | 045200081    | LNAMESIXSEVENSIX | CH1 2AN  | email@outlook.com | 452300080   |

  @Regression
  Scenario Outline: English 3rd Party Deferral - validation and errors

    Given I am on "Public" "ithc"

    Given a bureau owned pool is created with jurors
      | court | juror_number   | pool_number   | att_date_weeks_in_future | owner |
      | 452   | <juror_number> | <pool_number> | 5                        | 400   |

    And juror "<juror_number>" has "LAST_NAME" as "<last_name>" new schema
    And juror "<juror_number>" has "POSTCODE" as "<postcode>" new schema

    Then I see "Reply to a jury summons" on the page

    And I set the radio button to "I am replying for someone else"
    And I press the "Continue" button
    Then I see "Their juror details" on the page
	
	#Juror Log In
    When I set "9-digit juror number" to "<juror_number>"
    When I set "Juror last name" to "<last_name>"
    When I set "Juror postcode" to "<postcode>"
    And I press the "Continue" button
    Then I see "What is your name?" on the page
	
	#3rd Party Name
    When I see "Your Details" on the page
    When I set "First name" to "FirstNameA"
    And I set "Last name" to "LastNameB"
    And I press the "Continue" button
    Then I see "Your relationship to the person" on the page
	
	#Relationship to juror
    When I see "Your Details" on the page
    And I set "How do you know the person you're replying for?" to "Friend Friend Friend Friend Friend Friend Friend Friend Friend Friend Friend Friend Friend Friend Fr"
    And I press the "Continue" button
    Then I see "Your contact information" on the page
	
	#3rd Party Contact
    When I see "Your Details" on the page
    And I check the "By phone (UK Numbers only)" checkbox
    And I set "Main phone" to "0207 821 1818"
    And I check the "By email" checkbox
    And I set "Enter your email address" to "<email>"
    And I set "Enter your email address again" to "<email>"
    And I press the "Continue" button
	
	#Why are you replying title
    Then I see "Why are you replying for the other person?" on the page
    And I do not see "Why are you replying?" on the page
    When I set the radio button to "The person is not here"
    And I press the "Continue" button
    Then I see "Is the name we have for them correct?" on the page
	
	#Check juror name
    When I see "Juror Details" on the page
    And I choose the "Yes" radio button
    And I press the "Continue" button
    Then I see "Is this their address?" on the page
	
	#Check juror address
    When I see "Juror Details" on the page
    And I choose the "Yes" radio button
    And I press the "Continue" button
    Then I see "Give the date of birth for the person you're replying for" on the page
	
	#DoB
    When I see "Juror Details" on the page
    And I set "Day" to "01"
    And I set "Month" to "01"
	
	#JDB-3418 Checking age 18 works
    And I set "Year" to "2000"
    And I press the "Continue" button
    Then I see "We might need to get in touch with the person to ask them more questions or give them information about their jury service" on the page
	
	#Contacting the juror
    When I see "Juror Details" on the page
    And I set the radio button to "Use the phone number that you have already given to contact you"
    And I set the radio button to "Use the email address that you have already given to contact you"
    And I press the "Continue" button
	
	#Qualify for jury service
    When I see "Confirm if the person is eligible for jury service" on the page
    And I press the "Continue" button
	
	#Residency
    Then I see "Since they turned 13, has their main address been in the UK, Channel Islands or Isle of Man for any period of at least 5 years?" on the page
    When I see "Eligibility" on the page
    And I choose the "Yes" radio button
    And I press the "Continue" button
	
	#Have you ever worked
    Then I see "Has the person you're replying for worked in the criminal justice system in the last 5 years?" on the page
    When I choose the "No" radio button
    And I press the "Continue" button
	
	#Bail
    Then I see "Is the person currently on bail for a criminal offence?" on the page
    When I see "Eligibility" on the page
    And I choose the "No" radio button
    And I press the "Continue" button
	
	#Convictions
    Then I see "Has the person been found guilty of a criminal offence?" on the page
    When I see "Eligibility" on the page
    And I choose the "Yes" radio button
    And I set text area with "id" of "convictedDetails" to "Criminal Convictions"
    And I press the "Continue" button
	
	#Mental Health Sectioned
    Then I see "Is the person you're replying for being detained, looked after or treated under the Mental Health Act?" on the page
    When I see "Eligibility" on the page
    And I choose the "No" radio button
    And I press the "Continue" button
	
	#Mental Health Capacity
    Then I see "Has it been decided that the person you're replying for 'lacks mental capacity'?" on the page
    When I see "Eligibility" on the page
    And I choose the "No" radio button
    And I press the "Continue" button
	
	#Confirm Date of Jury
    Then I see "Check your start date" on the page

	#check errors
    And I press the "Continue" button
    And I see "There is a problem" on the page
    And I see "Select whether the person can start jury service on this date" on the page
	
	#check hint text
    Then I click on the "Will they need to serve longer than 2 weeks?" link
    And I see "Most jurors only need to serve 2 weeks." on the page
    And I see "They may be asked to serve for longer when they arrive at court." on the page
    And I see "If they cannot serve for more than 2 weeks, they'll be able to discuss this with the jury manager at court." on the page
    Then I click on the "What if there's a problem nearer the time and they cannot serve?" link
    And I see "You or they must contact us at that time to let us know." on the page
	
	#collapse hint text
    Then I click on the "Will they need to serve longer than 2 weeks?" link
    And I do not see "Most jurors only need to serve 2 weeks." on the page
    And I do not see "They may be asked to serve for longer when they arrive at court." on the page
    And I do not see "If they cannot serve for more than 2 weeks, they'll be able to discuss this with the jury manager at court." on the page

    Then I click on the "What if there's a problem nearer the time and they cannot serve?" link
    And I do not see "You or they must contact us at that time to let us know." on the page

    When I set the radio button to "No, we need to change the date"
    And I press the "Continue" button
	
	#Deferral Reason
    And I see "steps/confirm-date/deferral-reason/tp" in the URL
    Then I see "Tell us why they need another date for their jury service" on the page
	
	#deferral reason
    And I press the "Continue" button
    And I see "There is a problem" on the page
    And I see "Enter their reason for needing another date for jury service" on the page

    When I set text area with "id" of "deferralReason" to "Large amount of text here Large amount of text here Large amount of text here Large amount of text here Large amount of text here Large amount of text here Large amount of text here Large amount of text here Large amount of text here Large amount of text here Large amount of text here Large amount of text here Large amount of text here Large amount of text here Large amount of text here Large amount of text here Large amount of text here Large amount of text here Large amount of text here Large amount of text here Large amount of text here Large amount of text here Large amount of text here Large amount of text here Large amount of text here Large amount of text here Large amount of text here Large amount of text here Large amount of text here Large amount of text here Large amount of text here Large amount of text here Large amount of text here Large amount of text here Large amount of text here Large amount of text here Large amount of text here Large amount of text here Large amount of text here "
    And I see "You have 14 characters too many" on the page

    And I press the "Continue" button
    And I see "There is a problem" on the page
    And I see "The reason for asking for a later date for the person's jury service must be fewer characters" on the page

    When I set text area with "id" of "deferralReason" to "askForAnotherDateReasonWhy"
    And I press the "Continue" button
	
	#JDB-3445 Deferral Date Screen Layout
    And I see "steps/confirm-date/deferral-dates/tp" in the URL
    Then I see "Choose 3 Mondays when they can start jury service" on the page
	
	#check hint text
    Then I click on the "Will they need to serve longer than 2 weeks?" link
    And I see "Most jurors only need to serve 2 weeks." on the page
    And I see "They may be asked to serve for longer when they arrive at court." on the page
    And I see "If they cannot serve for more than 2 weeks, they'll be able to discuss this with the jury manager at court." on the page

    Then I click on the "What if there's a problem nearer the time and they cannot serve?" link
    And I see "You or they must contact us at that time to let us know." on the page
	
	#collapse hint text
    Then I click on the "Will they need to serve longer than 2 weeks?" link
    And I do not see "Most jurors only need to serve 2 weeks." on the page
    And I do not see "They may be asked to serve for longer when they arrive at court." on the page
    And I do not see "If they cannot serve for more than 2 weeks, they'll be able to discuss this with the jury manager at court." on the page

    Then I click on the "What if there's a problem nearer the time and they cannot serve?" link
    And I do not see "You or they must contact us at that time to let us know." on the page

    And I press the "Continue" button

    Then on the page I see
      | text                                                        |
      | There is a problem                                          |
      | Enter the first Monday they'd prefer to start jury service  |
      | Enter the second Monday they'd prefer to start jury service |
      | Enter the third Monday they'd prefer to start jury service  |

    #invalid input
    When I set "First choice" to "12 July"
    When I set "Second choice" to "13 July"
    When I set "Third choice" to "14 July"
    And I press the "Continue" button

    Then on the page I see
      | text                                                                                    |
      | There is a problem                                                                      |
      | Enter the first Monday they'd prefer to start jury service using the dd/mm/yyyy format  |
      | Enter the second Monday they'd prefer to start jury service using the dd/mm/yyyy format |
      | Enter the third Monday they'd prefer to start jury service using the dd/mm/yyyy format  |

    When I set the "First" single date field to a Monday "9" weeks in the future
    When I set the "Second" single date field to a Monday "10" weeks in the future
    When I set the "Third" single date field to a Monday "11" weeks in the future
    And I press the "Continue" button

    When I click on the "Back" link
    And I press the "Continue" button

    And on the page I see
      | text                                                                            |
      | Check dates                                                                     |
      | Dates they can start jury service                                               |
      | First choice                                                                    |
      | Second choice                                                                   |
      | Third choice                                                                    |
      | You do not need to tell us all other dates they're available.                   |
      | We'll choose one of these 3 dates.                                              |
      | In the unlikely event that we cannot use one of these dates, we'll contact you. |

    And I validate the "First" deferral date is "9" weeks in the future
    And I validate the "Second" deferral date is "10" weeks in the future
    And I validate the "Third" deferral date is "11" weeks in the future
	
	#check hint text
    Then I click on the "Will they need to serve longer than 2 weeks?" link
    And I see "Most jurors only need to serve 2 weeks." on the page
    And I see "They may be asked to serve for longer when they arrive at court." on the page
    And I see "If they cannot serve for more than 2 weeks, they'll be able to discuss this with the jury manager at court." on the page

    Then I click on the "What if there's a problem nearer the time and they cannot serve?" link
    And I see "You or they must contact us at that time to let us know." on the page
	
	#collapse hint text
    Then I click on the "Will they need to serve longer than 2 weeks?" link
    And I do not see "Most jurors only need to serve 2 weeks." on the page
    And I do not see "They may be asked to serve for longer when they arrive at court." on the page
    And I do not see "If they cannot serve for more than 2 weeks, they'll be able to discuss this with the jury manager at court." on the page

    Then I click on the "What if there's a problem nearer the time and they cannot serve?" link
    And I do not see "You or they must contact us at that time to let us know." on the page

    And I press the "Continue" button

    Then on the page I see
      | text                                                |
      | There is a problem                                  |
      | Select whether you want to proceed with these dates |

    Then I choose the "Yes" radio button
    And I press the "Continue" button
	
	#help at court
    Then I see "Will the person you're replying for need help when they're at the court?" on the page
    When I choose the "Yes" radio button
    Then I check the "Diabetes" checkbox
    And I press the "Continue" button
	
	#check answers
    And on the page I see
      | text                                                                       |
      | Check your answers now                                                     |
      | Confirm the date of their jury service                                     |
      | I need to change the date of jury service for the person I'm answering for |
      | Tell us why they need another date for their jury service                  |
      | askForAnotherDateReasonWhy                                                 |
      | Choose 3 Mondays when they can start jury service                          |
      | First choice                                                               |
      | Second choice                                                              |
      | Third choice                                                               |

    And I validate the "First" deferral date is "9" weeks in the future
    And I validate the "Second" deferral date is "10" weeks in the future
    And I validate the "Third" deferral date is "11" weeks in the future

    When I check the "The answers I have given for the person I'm replying for are true as far as I know" checkbox
    And I press the "Submit" button

    Then on the page I see
      | text                                                                                                                                                                            |
      | You have completed your reply                                                                                                                                                   |
      | If we get in touch with them, they may need to give their juror number. It's also on the letter we sent them.                                                                   |
      | We have sent an email to say you have replied to this jury summons.                                                                                                             |
      | Download a copy of your summons reply                                                                                                                                           |
      | If they can do jury service, at least 2 weeks before it starts we'll send them:                                                                                                 |
      | a letter confirming the date of their jury service                                                                                                                              |
      | an information pack about being a juror and the court they're going to                                                                                                          |
      | Getting ready for jury service                                                                                                                                                  |
      | The information below is also in the email that we have sent.                                                                                                                   |
      | You or the person you've replied for, can watch this video on YouTube about what happens when you're a juror, so they know what to expect. The video takes 13 minutes to watch. |
      | Learn more about jury service. You can read the rules about discussing the trial and find out how to claim expenses.                                                            |
      | Calculate what expenses and allowances you can claim.                                                                                                                           |
      | What did you think of this service? (Takes 30 seconds)                                                                                                                          |

    And I do not see "Your Guide to Jury Service (PDF 85KB)" on the page

    Then I click on the "Download a copy of your summons reply HTML" link

    And on the page I see
      | text                                                                       |
      | Your jury summons details                                                  |
      | Confirm the date of their jury service                                     |
      | I need to change the date of jury service for the person I'm answering for |
      | Tell us why they need another date for their jury service                  |
      | askForAnotherDateReasonWhy                                                 |
      | Choose 3 Mondays when they can start jury service                          |
      | First choice                                                               |
      | Second choice                                                              |
      | Third choice                                                               |

    And I validate the "First" deferral date is "9" weeks in the future
    And I validate the "Second" deferral date is "10" weeks in the future
    And I validate the "Third" deferral date is "11" weeks in the future

    Examples:
      | juror_number | last_name        | postcode | email             | pool_number |
      | 045200082    | LNAMESIXSEVENSIX | CH1 2AN  | email@outlook.com | 452300081   |

  @RegressionSingle
  Scenario Outline: English 3rd Party Deferral - Deferral Bank Holiday

    Given I am on "Public" "test"

    Given a bureau owned pool is created with jurors
      | court | juror_number   | pool_number   | att_date_weeks_in_future | owner |
      | 452   | <juror_number> | <pool_number> | 5                        | 400   |

    And juror "<juror_number>" has "LAST_NAME" as "<last_name>" new schema
    And juror "<juror_number>" has "POSTCODE" as "<postcode>" new schema

    Then I see "Reply to a jury summons" on the page

    And I set the radio button to "I am replying for someone else"
    And I press the "Continue" button
    Then I see "Their juror details" on the page
	
	#Juror Log In
    When I set "9-digit juror number" to "<juror_number>"
    When I set "Juror last name" to "<last_name>"
    When I set "Juror postcode" to "<postcode>"
    And I press the "Continue" button
    Then I see "What is your name?" on the page
	
	#3rd Party Name
    When I see "Your Details" on the page
    When I set "First name" to "FirstNameA"
    And I set "Last name" to "LastNameB"
    And I press the "Continue" button
    Then I see "Your relationship to the person" on the page
	
	#Relationship to juror
    When I see "Your Details" on the page
    And I set "How do you know the person you're replying for?" to "Friend Friend Friend Friend Friend Friend Friend Friend Friend Friend Friend Friend Friend Friend Fr"
    And I press the "Continue" button
    Then I see "Your contact information" on the page
	
	#3rd Party Contact
    When I see "Your Details" on the page
    And I check the "By phone (UK Numbers only)" checkbox
    And I set "Main phone" to "0207 821 1818"
    And I check the "By email" checkbox
    And I set "Enter your email address" to "<email>"
    And I set "Enter your email address again" to "<email>"
    And I press the "Continue" button
	
	#Why are you replying title
    Then I see "Why are you replying for the other person?" on the page
    And I do not see "Why are you replying?" on the page
    When I set the radio button to "The person is not here"
    And I press the "Continue" button
    Then I see "Is the name we have for them correct?" on the page
	
	#Check juror name
    When I see "Juror Details" on the page
    And I choose the "Yes" radio button
    And I press the "Continue" button
    Then I see "Is this their address?" on the page
	
	#Check juror address
    When I see "Juror Details" on the page
    And I choose the "Yes" radio button
    And I press the "Continue" button
    Then I see "Give the date of birth for the person you're replying for" on the page
	
	#DoB
    When I see "Juror Details" on the page
    And I set "Day" to "01"
    And I set "Month" to "01"
	
	#JDB-3418 Checking age 18 works
    And I set "Year" to "2000"
    And I press the "Continue" button
    Then I see "We might need to get in touch with the person to ask them more questions or give them information about their jury service" on the page
	
	#Contacting the juror
    When I see "Juror Details" on the page
    And I set the radio button to "Use the phone number that you have already given to contact you"
    And I set the radio button to "Use the email address that you have already given to contact you"
    And I press the "Continue" button
	
	#Qualify for jury service
    When I see "Confirm if the person is eligible for jury service" on the page
    And I press the "Continue" button
	
	#Residency
    Then I see "Since they turned 13, has their main address been in the UK, Channel Islands or Isle of Man for any period of at least 5 years?" on the page
    When I see "Eligibility" on the page
    And I choose the "Yes" radio button
    And I press the "Continue" button
	
	#Have you ever worked
    Then I see "Has the person you're replying for worked in the criminal justice system in the last 5 years?" on the page
    When I choose the "No" radio button
    And I press the "Continue" button
	
	#Bail
    Then I see "Is the person currently on bail for a criminal offence?" on the page
    When I see "Eligibility" on the page
    And I choose the "No" radio button
    And I press the "Continue" button
	
	#Convictions
    Then I see "Has the person been found guilty of a criminal offence?" on the page
    When I see "Eligibility" on the page
    And I choose the "Yes" radio button
    And I set text area with "id" of "convictedDetails" to "Criminal Convictions"
    And I press the "Continue" button
	
	#Mental Health Sectioned
    Then I see "Is the person you're replying for being detained, looked after or treated under the Mental Health Act?" on the page
    When I see "Eligibility" on the page
    And I choose the "No" radio button
    And I press the "Continue" button
	
	#Mental Health Capacity
    Then I see "Has it been decided that the person you're replying for 'lacks mental capacity'?" on the page
    When I see "Eligibility" on the page
    And I choose the "No" radio button
    And I press the "Continue" button
	
	#Confirm Date of Jury
    Then I see "Check your start date" on the page
    When I set the radio button to "No, we need to change the date"
    And I press the "Continue" button
	
	#Deferral Reason
    And I see "steps/confirm-date/deferral-reason/tp" in the URL
    Then I see "Tell us why they need another date for their jury service" on the page
    When I set text area with "id" of "deferralReason" to "askForAnotherDateReasonWhy"
    And I press the "Continue" button
	
	#JDB-3445 Deferral Date Screen Layout
    And I see "steps/confirm-date/deferral-dates/tp" in the URL
    Then I see "Choose 3 Mondays when they can start jury service" on the page
	
	#set bank holidays
    And I create a bank holiday "9" Mondays in the future for court/bureau "400" new schema
    When I set the "First" single date field to a Monday "9" weeks in the future
    When I set the "Second" single date field to a Monday "10" weeks in the future
    When I set the "Third" single date field to a Monday "11" weeks in the future

    And I press the "Continue" button

    And on the page I see
      | text                                                                            |
      | Check dates                                                                     |
      | Dates they can start jury service                                               |
      | First choice                                                                    |
      | Second choice                                                                   |
      | Third choice                                                                    |
      | You do not need to tell us all other dates they're available.                   |
      | We'll choose one of these 3 dates.                                              |
      | In the unlikely event that we cannot use one of these dates, we'll contact you. |

    And I validate the "First" deferral date is "9" weeks in the future
    And I validate the "Second" deferral date is "10" weeks in the future
    And I validate the "Third" deferral date is "11" weeks in the future

    Then I choose the "Yes" radio button
    And I press the "Continue" button
	
	#Bank Holiday
    Then on the page I see
      | text                                                                                                 |
      | At least one of the Mondays you selected is a bank holiday                                           |
      | You've selected at least one Monday that's a UK bank holiday.                                        |
      | If we choose this as their start date, their jury service will start on the Tuesday at the earliest. |
      | We'll send confirmation of the start date.                                                           |

    And I press the "Continue" button
	
	#help at court
    Then I see "Will the person you're replying for need help when they're at the court?" on the page
    When I choose the "No" radio button
    And I press the "Continue" button
	
	#check answers
    And on the page I see
      | text                                                                       |
      | Check your answers now                                                     |
      | Confirm the date of their jury service                                     |
      | I need to change the date of jury service for the person I'm answering for |
      | Tell us why they need another date for their jury service                  |
      | askForAnotherDateReasonWhy                                                 |
      | Choose 3 Mondays when they can start jury service                          |
      | First choice                                                               |
      | Second choice                                                              |
      | Third choice                                                               |
    And I validate the "First" deferral date is "9" weeks in the future
    And I validate the "Second" deferral date is "10" weeks in the future
    And I validate the "Third" deferral date is "11" weeks in the future

    When I check the "The answers I have given for the person I'm replying for are true as far as I know" checkbox
    And I press the "Submit" button

    Then on the page I see
      | text                                                                                                                                                                            |
      | You have completed your reply                                                                                                                                                   |
      | If we get in touch with them, they may need to give their juror number. It's also on the letter we sent them.                                                                   |
      | We have sent an email to say you have replied to this jury summons.                                                                                                             |
      | Download a copy of your summons reply                                                                                                                                           |
      | If they can do jury service, at least 2 weeks before it starts we'll send them:                                                                                                 |
      | a letter confirming the date of their jury service                                                                                                                              |
      | an information pack about being a juror and the court they're going to                                                                                                          |
      | Getting ready for jury service                                                                                                                                                  |
      | The information below is also in the email that we have sent.                                                                                                                   |
      | You or the person you've replied for, can watch this video on YouTube about what happens when you're a juror, so they know what to expect. The video takes 13 minutes to watch. |
      | Learn more about jury service. You can read the rules about discussing the trial and find out how to claim expenses.                                                            |
      | Calculate what expenses and allowances you can claim.                                                                                                                           |
      | What did you think of this service? (Takes 30 seconds)                                                                                                                          |

    And I do not see "Your Guide to Jury Service (PDF 85KB)" on the page

    Then I click on the "Download a copy of your summons reply HTML" link
    And on the page I see
      | text                                                                       |
      | Copy of your jury summons reply                                            |
      | Confirm the date of their jury service                                     |
      | I need to change the date of jury service for the person I'm answering for |
      | Tell us why they need another date for their jury service                  |
      | askForAnotherDateReasonWhy                                                 |
      | Choose 3 Mondays when they can start jury service                          |
      | First choice                                                               |
      | Second choice                                                              |
      | Third choice                                                               |
    And I validate the "First" deferral date is "9" weeks in the future
    And I validate the "Second" deferral date is "10" weeks in the future
    And I validate the "Third" deferral date is "11" weeks in the future

    And I delete bank holiday new schema

    Examples:
      | juror_number | last_name        | postcode | email             | pool_number |
      | 045200083    | LNAMESIXSEVENSIX | SW1H 9AJ | email@outlook.com | 452300082   |

  @RegressionSingle @NewScemaConverted
  Scenario Outline: English 3rd Party Deferral - Deferral >1 date is a Bank Holiday

    Given I am on "Public" "test"

    Given a bureau owned pool is created with jurors
      | court | juror_number   | pool_number   | att_date_weeks_in_future | owner |
      | 452   | <juror_number> | <pool_number> | 5                        | 400   |

    And juror "<juror_number>" has "LAST_NAME" as "<last_name>" new schema
    And juror "<juror_number>" has "POSTCODE" as "<postcode>" new schema

    Then I see "Reply to a jury summons" on the page

    And I set the radio button to "I am replying for someone else"
    And I press the "Continue" button
    Then I see "Their juror details" on the page
	
	#Juror Log In
    When I set "9-digit juror number" to "<juror_number>"
    When I set "Juror last name" to "<last_name>"
    When I set "Juror postcode" to "<postcode>"
    And I press the "Continue" button
    Then I see "What is your name?" on the page
	
	#3rd Party Name
    When I see "Your Details" on the page
    When I set "First name" to "FirstNameA"
    And I set "Last name" to "LastNameB"
    And I press the "Continue" button
    Then I see "Your relationship to the person" on the page
	
	#Relationship to juror
    When I see "Your Details" on the page
    And I set "How do you know the person you're replying for?" to "Friend Friend Friend Friend Friend Friend Friend Friend Friend Friend Friend Friend Friend Friend Fr"
    And I press the "Continue" button
    Then I see "Your contact information" on the page
	
	#3rd Party Contact
    When I see "Your Details" on the page
    And I check the "By phone (UK Numbers only)" checkbox
    And I set "Main phone" to "0207 821 1818"
    And I check the "By email" checkbox
    And I set "Enter your email address" to "<email>"
    And I set "Enter your email address again" to "<email>"
    And I press the "Continue" button
	
	#Why are you replying title
    Then I see "Why are you replying for the other person?" on the page
    And I do not see "Why are you replying?" on the page
    When I set the radio button to "The person is not here"
    And I press the "Continue" button
    Then I see "Is the name we have for them correct?" on the page
	
	#Check juror name
    When I see "Juror Details" on the page
    And I choose the "Yes" radio button
    And I press the "Continue" button
    Then I see "Is this their address?" on the page
	
	#Check juror address
    When I see "Juror Details" on the page
    And I choose the "Yes" radio button
    And I press the "Continue" button
    Then I see "Give the date of birth for the person you're replying for" on the page
	
	#DoB
    When I see "Juror Details" on the page
    And I set "Day" to "01"
    And I set "Month" to "01"
	
	#JDB-3418 Checking age 18 works
    And I set "Year" to "2000"
    And I press the "Continue" button
    Then I see "We might need to get in touch with the person to ask them more questions or give them information about their jury service" on the page
	
	#Contacting the juror
    When I see "Juror Details" on the page
    And I set the radio button to "Use the phone number that you have already given to contact you"
    And I set the radio button to "Use the email address that you have already given to contact you"
    And I press the "Continue" button
	
	#Qualify for jury service
    When I see "Confirm if the person is eligible for jury service" on the page
    And I press the "Continue" button
	
	#Residency
    Then I see "Since they turned 13, has their main address been in the UK, Channel Islands or Isle of Man for any period of at least 5 years?" on the page
    When I see "Eligibility" on the page
    And I choose the "Yes" radio button
    And I press the "Continue" button
	
	#Have you ever worked
    Then I see "Has the person you're replying for worked in the criminal justice system in the last 5 years?" on the page
    When I choose the "No" radio button
    And I press the "Continue" button
	
	#Bail
    Then I see "Is the person currently on bail for a criminal offence?" on the page
    When I see "Eligibility" on the page
    And I choose the "No" radio button
    And I press the "Continue" button
	
	#Convictions
    Then I see "Has the person been found guilty of a criminal offence?" on the page
    When I see "Eligibility" on the page
    And I choose the "Yes" radio button
    And I set text area with "id" of "convictedDetails" to "Criminal Convictions"
    And I press the "Continue" button
	
	#Mental Health Sectioned
    Then I see "Is the person you're replying for being detained, looked after or treated under the Mental Health Act?" on the page
    When I see "Eligibility" on the page
    And I choose the "No" radio button
    And I press the "Continue" button
	
	#Mental Health Capacity
    Then I see "Has it been decided that the person you're replying for 'lacks mental capacity'?" on the page
    When I see "Eligibility" on the page
    And I choose the "No" radio button
    And I press the "Continue" button
	
	#Confirm Date of Jury
    Then I see "Check your start date" on the page
    When I set the radio button to "No, we need to change the date"
    And I press the "Continue" button
	
	#Deferral Reason
    And I see "steps/confirm-date/deferral-reason/tp" in the URL
    Then I see "Tell us why they need another date for their jury service" on the page
    When I set text area with "id" of "deferralReason" to "askForAnotherDateReasonWhy"
    And I press the "Continue" button
	
	#JDB-3445 Deferral Date Screen Layout
    And I create a bank holiday "9" Mondays in the future for court/bureau "400" new schema
    And I create a bank holiday "10" Mondays in the future for court/bureau "400" new schema
    And I create a bank holiday "11" Mondays in the future for court/bureau "400" new schema

    And I see "steps/confirm-date/deferral-dates/tp" in the URL
    Then I see "Choose 3 Mondays when they can start jury service" on the page

    When I set the "First" single date field to a Monday "9" weeks in the future
    When I set the "Second" single date field to a Monday "10" weeks in the future
    When I set the "Third" single date field to a Monday "11" weeks in the future

    And I press the "Continue" button

    And on the page I see
      | text                                                                            |
      | Check dates                                                                     |
      | Dates they can start jury service                                               |
      | First choice                                                                    |
      | Second choice                                                                   |
      | Third choice                                                                    |
      | You do not need to tell us all other dates they're available.                   |
      | We'll choose one of these 3 dates.                                              |
      | In the unlikely event that we cannot use one of these dates, we'll contact you. |
    And I validate the "First" deferral date is "9" weeks in the future
    And I validate the "Second" deferral date is "10" weeks in the future
    And I validate the "Third" deferral date is "11" weeks in the future
    Then I choose the "Yes" radio button
    And I press the "Continue" button
	
	#Bank Holiday
    Then on the page I see
      | text                                                                                                 |
      | At least one of the Mondays you selected is a bank holiday                                           |
      | You've selected at least one Monday that's a UK bank holiday.                                        |
      | If we choose this as their start date, their jury service will start on the Tuesday at the earliest. |
      | We'll send confirmation of the start date.                                                           |

    And I press the "Continue" button
	
	#help at court
    Then I see "Will the person you're replying for need help when they're at the court?" on the page
    When I choose the "No" radio button
    And I press the "Continue" button
	
	#check answers
    And on the page I see
      | text                                                                       |
      | Check your answers now                                                     |
      | Confirm the date of their jury service                                     |
      | I need to change the date of jury service for the person I'm answering for |
      | Tell us why they need another date for their jury service                  |
      | askForAnotherDateReasonWhy                                                 |
      | Choose 3 Mondays when they can start jury service                          |
      | First choice                                                               |
      | Second choice                                                              |
    And I validate the "First" deferral date is "9" weeks in the future
    And I validate the "Second" deferral date is "10" weeks in the future
    And I validate the "Third" deferral date is "11" weeks in the future
    When I check the "The answers I have given for the person I'm replying for are true as far as I know" checkbox
    And I press the "Submit" button

    Then on the page I see
      | text                                                                                                                                                                            |
      | You have completed your reply                                                                                                                                                   |
      | If we get in touch with them, they may need to give their juror number. It's also on the letter we sent them.                                                                   |
      | We have sent an email to say you have replied to this jury summons.                                                                                                             |
      | Download a copy of your summons reply                                                                                                                                           |
      | If they can do jury service, at least 2 weeks before it starts we'll send them:                                                                                                 |
      | a letter confirming the date of their jury service                                                                                                                              |
      | an information pack about being a juror and the court they're going to                                                                                                          |
      | Getting ready for jury service                                                                                                                                                  |
      | The information below is also in the email that we have sent.                                                                                                                   |
      | You or the person you've replied for, can watch this video on YouTube about what happens when you're a juror, so they know what to expect. The video takes 13 minutes to watch. |
      | Learn more about jury service. You can read the rules about discussing the trial and find out how to claim expenses.                                                            |
      | Calculate what expenses and allowances you can claim.                                                                                                                           |
      | What did you think of this service? (Takes 30 seconds)                                                                                                                          |

    And I do not see "Your Guide to Jury Service (PDF 85KB)" on the page

    Then I click on the "Download a copy of your summons reply HTML" link
    And on the page I see
      | text                                                                       |
      | Copy of your jury summons reply                                            |
      | Confirm the date of their jury service                                     |
      | I need to change the date of jury service for the person I'm answering for |
      | Tell us why they need another date for their jury service                  |
      | askForAnotherDateReasonWhy                                                 |
      | Choose 3 Mondays when they can start jury service                          |
      | First choice                                                               |
      | Second choice                                                              |
      | Third choice                                                               |
    And I validate the "First" deferral date is "9" weeks in the future
    And I validate the "Second" deferral date is "10" weeks in the future
    And I validate the "Third" deferral date is "11" weeks in the future

    Then I delete bank holiday new schema

    Examples:
      | juror_number | last_name        | postcode | email             | pool_number |
      | 045200084    | LNAMESIXSEVENSIX | SW1H 9AJ | email@outlook.com | 452300083   |

  @RegressionSingle
  Scenario Outline: English 3rd Party Deferral - Deferral date 2 is a Bank Holiday

    Given I am on "Public" "test"

    Given a bureau owned pool is created with jurors
      | court | juror_number   | pool_number   | att_date_weeks_in_future | owner |
      | 452   | <juror_number> | <pool_number> | 5                        | 400   |

    And juror "<juror_number>" has "LAST_NAME" as "<last_name>" new schema
    And juror "<juror_number>" has "POSTCODE" as "<postcode>" new schema

    Then I see "Reply to a jury summons" on the page

    And I set the radio button to "I am replying for someone else"
    And I press the "Continue" button
    Then I see "Their juror details" on the page
	
	#Juror Log In
    When I set "9-digit juror number" to "<juror_number>"
    When I set "Juror last name" to "<last_name>"
    When I set "Juror postcode" to "<postcode>"
    And I press the "Continue" button
    Then I see "What is your name?" on the page
	
	#3rd Party Name
    When I see "Your Details" on the page
    When I set "First name" to "FirstNameA"
    And I set "Last name" to "LastNameB"
    And I press the "Continue" button
    Then I see "Your relationship to the person" on the page
	
	#Relationship to juror
    When I see "Your Details" on the page
    And I set "How do you know the person you're replying for?" to "Friend Friend Friend Friend Friend Friend Friend Friend Friend Friend Friend Friend Friend Friend Fr"
    And I press the "Continue" button
    Then I see "Your contact information" on the page
	
	#3rd Party Contact
    When I see "Your Details" on the page
    And I check the "By phone (UK Numbers only)" checkbox
    And I set "Main phone" to "0207 821 1818"
    And I check the "By email" checkbox
    And I set "Enter your email address" to "<email>"
    And I set "Enter your email address again" to "<email>"
    And I press the "Continue" button
	
	#Why are you replying title
    Then I see "Why are you replying for the other person?" on the page
    And I do not see "Why are you replying?" on the page
    When I set the radio button to "The person is not here"
    And I press the "Continue" button
    Then I see "Is the name we have for them correct?" on the page
	
	#Check juror name
    When I see "Juror Details" on the page
    And I choose the "Yes" radio button
    And I press the "Continue" button
    Then I see "Is this their address?" on the page
	
	#Check juror address
    When I see "Juror Details" on the page
    And I choose the "Yes" radio button
    And I press the "Continue" button
    Then I see "Give the date of birth for the person you're replying for" on the page
	
	#DoB
    When I see "Juror Details" on the page
    And I set "Day" to "01"
    And I set "Month" to "01"
	
	#JDB-3418 Checking age 18 works
    And I set "Year" to "2000"
    And I press the "Continue" button
    Then I see "We might need to get in touch with the person to ask them more questions or give them information about their jury service" on the page
	
	#Contacting the juror
    When I see "Juror Details" on the page
    And I set the radio button to "Use the phone number that you have already given to contact you"
    And I set the radio button to "Use the email address that you have already given to contact you"
    And I press the "Continue" button
	
	#Qualify for jury service
    When I see "Confirm if the person is eligible for jury service" on the page
    And I press the "Continue" button
	
	#Residency
    Then I see "Since they turned 13, has their main address been in the UK, Channel Islands or Isle of Man for any period of at least 5 years?" on the page
    When I see "Eligibility" on the page
    And I choose the "Yes" radio button
    And I press the "Continue" button
	
	#Have you ever worked
    Then I see "Has the person you're replying for worked in the criminal justice system in the last 5 years?" on the page
    When I choose the "No" radio button
    And I press the "Continue" button
	
	#Bail
    Then I see "Is the person currently on bail for a criminal offence?" on the page
    When I see "Eligibility" on the page
    And I choose the "No" radio button
    And I press the "Continue" button
	
	#Convictions
    Then I see "Has the person been found guilty of a criminal offence?" on the page
    When I see "Eligibility" on the page
    And I choose the "Yes" radio button
    And I set text area with "id" of "convictedDetails" to "Criminal Convictions"
    And I press the "Continue" button
	
	#Mental Health Sectioned
    Then I see "Is the person you're replying for being detained, looked after or treated under the Mental Health Act?" on the page
    When I see "Eligibility" on the page
    And I choose the "No" radio button
    And I press the "Continue" button
	
	#Mental Health Capacity
    Then I see "Has it been decided that the person you're replying for 'lacks mental capacity'?" on the page
    When I see "Eligibility" on the page
    And I choose the "No" radio button
    And I press the "Continue" button
	
	#Confirm Date of Jury
    Then I see "Check your start date" on the page
    When I set the radio button to "No, we need to change the date"
    And I press the "Continue" button
	
	#Deferral Reason
    And I see "steps/confirm-date/deferral-reason/tp" in the URL
    Then I see "Tell us why they need another date for their jury service" on the page
    When I set text area with "id" of "deferralReason" to "askForAnotherDateReasonWhy"
    And I press the "Continue" button
	
	#JDB-3445 Deferral Date Screen Layout
    And I see "steps/confirm-date/deferral-dates/tp" in the URL
    Then I see "Choose 3 Mondays when they can start jury service" on the page

    And I create a bank holiday "10" Mondays in the future for court/bureau "400" new schema
    When I set the "First" single date field to a Monday "9" weeks in the future
    When I set the "Second" single date field to a Monday "10" weeks in the future
    When I set the "Third" single date field to a Monday "11" weeks in the future

    And I press the "Continue" button

    And on the page I see
      | text                                                                            |
      | Check dates                                                                     |
      | Dates they can start jury service                                               |
      | First choice                                                                    |
      | Second choice                                                                   |
      | Third choice                                                                    |
      | You do not need to tell us all other dates they're available.                   |
      | We'll choose one of these 3 dates.                                              |
      | In the unlikely event that we cannot use one of these dates, we'll contact you. |

    And I validate the "First" deferral date is "9" weeks in the future
    And I validate the "Second" deferral date is "10" weeks in the future
    And I validate the "Third" deferral date is "11" weeks in the future

    Then I choose the "Yes" radio button
    And I press the "Continue" button
	
	#Bank Holiday
    Then on the page I see
      | text                                                                                                 |
      | At least one of the Mondays you selected is a bank holiday                                           |
      | You've selected at least one Monday that's a UK bank holiday.                                        |
      | If we choose this as their start date, their jury service will start on the Tuesday at the earliest. |
      | We'll send confirmation of the start date.                                                           |

    And I press the "Continue" button
	
	#help at court
    Then I see "Will the person you're replying for need help when they're at the court?" on the page
    When I choose the "No" radio button
    And I press the "Continue" button
	
	#check answers
    And on the page I see
      | text                                                                       |
      | Check your answers now                                                     |
      | Confirm the date of their jury service                                     |
      | I need to change the date of jury service for the person I'm answering for |
      | Tell us why they need another date for their jury service                  |
      | askForAnotherDateReasonWhy                                                 |
      | Choose 3 Mondays when they can start jury service                          |
      | First choice                                                               |
      | Second choice                                                              |
      | Third choice                                                               |
    And I validate the "First" deferral date is "9" weeks in the future
    And I validate the "Second" deferral date is "10" weeks in the future
    And I validate the "Third" deferral date is "11" weeks in the future

    When I check the "The answers I have given for the person I'm replying for are true as far as I know" checkbox
    And I press the "Submit" button

    Then on the page I see
      | text                                                                                                                                                                            |
      | You have completed your reply                                                                                                                                                   |
      | If we get in touch with them, they may need to give their juror number. It's also on the letter we sent them.                                                                   |
      | We have sent an email to say you have replied to this jury summons.                                                                                                             |
      | Download a copy of your summons reply                                                                                                                                           |
      | If they can do jury service, at least 2 weeks before it starts we'll send them:                                                                                                 |
      | a letter confirming the date of their jury service                                                                                                                              |
      | an information pack about being a juror and the court they're going to                                                                                                          |
      | Getting ready for jury service                                                                                                                                                  |
      | The information below is also in the email that we have sent.                                                                                                                   |
      | You or the person you've replied for, can watch this video on YouTube about what happens when you're a juror, so they know what to expect. The video takes 13 minutes to watch. |
      | Learn more about jury service. You can read the rules about discussing the trial and find out how to claim expenses.                                                            |
      | Calculate what expenses and allowances you can claim.                                                                                                                           |
      | What did you think of this service? (Takes 30 seconds)                                                                                                                          |

    And I do not see "Your Guide to Jury Service (PDF 85KB)" on the page

    Then I click on the "Download a copy of your summons reply HTML" link
    And on the page I see
      | text                                                                       |
      | Copy of your jury summons reply                                            |
      | Confirm the date of their jury service                                     |
      | I need to change the date of jury service for the person I'm answering for |
      | Tell us why they need another date for their jury service                  |
      | askForAnotherDateReasonWhy                                                 |
      | Choose 3 Mondays when they can start jury service                          |
      | First choice                                                               |
      | Second choice                                                              |
      | Third choice                                                               |
    And I validate the "First" deferral date is "9" weeks in the future
    And I validate the "Second" deferral date is "10" weeks in the future
    And I validate the "Third" deferral date is "11" weeks in the future

    And I delete bank holiday new schema

    Examples:
      | juror_number | last_name        | postcode | email             | pool_number |
      | 045200085    | LNAMESIXSEVENSIX | SW1H 9AJ | email@outlook.com | 452300084   |

  @RegressionSingle
  Scenario Outline: English 3rd Party Deferral - Deferral date 3 is a Bank Holiday

    Given I am on "Public" "test"

    Given a bureau owned pool is created with jurors
      | court | juror_number   | pool_number   | att_date_weeks_in_future | owner |
      | 452   | <juror_number> | <pool_number> | 5                        | 400   |

    And juror "<juror_number>" has "LAST_NAME" as "<last_name>" new schema
    And juror "<juror_number>" has "POSTCODE" as "<postcode>" new schema

    Then I see "Reply to a jury summons" on the page

    And I set the radio button to "I am replying for someone else"
    And I press the "Continue" button
    Then I see "Their juror details" on the page
	
	#Juror Log In
    When I set "9-digit juror number" to "<juror_number>"
    When I set "Juror last name" to "<last_name>"
    When I set "Juror postcode" to "<postcode>"
    And I press the "Continue" button
    Then I see "What is your name?" on the page
	
	#3rd Party Name
    When I see "Your Details" on the page
    When I set "First name" to "FirstNameA"
    And I set "Last name" to "LastNameB"
    And I press the "Continue" button
    Then I see "Your relationship to the person" on the page
	
	#Relationship to juror
    When I see "Your Details" on the page
    And I set "How do you know the person you're replying for?" to "Friend Friend Friend Friend Friend Friend Friend Friend Friend Friend Friend Friend Friend Friend Fr"
    And I press the "Continue" button
    Then I see "Your contact information" on the page
	
	#3rd Party Contact
    When I see "Your Details" on the page
    And I check the "By phone (UK Numbers only)" checkbox
    And I set "Main phone" to "0207 821 1818"
    And I check the "By email" checkbox
    And I set "Enter your email address" to "<email>"
    And I set "Enter your email address again" to "<email>"
    And I press the "Continue" button
	
	#Why are you replying title
    Then I see "Why are you replying for the other person?" on the page
    And I do not see "Why are you replying?" on the page
    When I set the radio button to "The person is not here"
    And I press the "Continue" button
    Then I see "Is the name we have for them correct?" on the page
	
	#Check juror name
    When I see "Juror Details" on the page
    And I choose the "Yes" radio button
    And I press the "Continue" button
    Then I see "Is this their address?" on the page
	
	#Check juror address
    When I see "Juror Details" on the page
    And I choose the "Yes" radio button
    And I press the "Continue" button
    Then I see "Give the date of birth for the person you're replying for" on the page
	
	#DoB
    When I see "Juror Details" on the page
    And I set "Day" to "01"
    And I set "Month" to "01"
	
	#JDB-3418 Checking age 18 works
    And I set "Year" to "2000"
    And I press the "Continue" button
    Then I see "We might need to get in touch with the person to ask them more questions or give them information about their jury service" on the page
	
	#Contacting the juror
    When I see "Juror Details" on the page
    And I set the radio button to "Use the phone number that you have already given to contact you"
    And I set the radio button to "Use the email address that you have already given to contact you"
    And I press the "Continue" button
	
	#Qualify for jury service
    When I see "Confirm if the person is eligible for jury service" on the page
    And I press the "Continue" button
	
	#Residency
    Then I see "Since they turned 13, has their main address been in the UK, Channel Islands or Isle of Man for any period of at least 5 years?" on the page
    When I see "Eligibility" on the page
    And I choose the "Yes" radio button
    And I press the "Continue" button
	
	#Have you ever worked
    Then I see "Has the person you're replying for worked in the criminal justice system in the last 5 years?" on the page
    When I choose the "No" radio button
    And I press the "Continue" button
	
	#Bail
    Then I see "Is the person currently on bail for a criminal offence?" on the page
    When I see "Eligibility" on the page
    And I choose the "No" radio button
    And I press the "Continue" button
	
	#Convictions
    Then I see "Has the person been found guilty of a criminal offence?" on the page
    When I see "Eligibility" on the page
    And I choose the "Yes" radio button
    And I set text area with "id" of "convictedDetails" to "Criminal Convictions"
    And I press the "Continue" button
	
	#Mental Health Sectioned
    Then I see "Is the person you're replying for being detained, looked after or treated under the Mental Health Act?" on the page
    When I see "Eligibility" on the page
    And I choose the "No" radio button
    And I press the "Continue" button
	
	#Mental Health Capacity
    Then I see "Has it been decided that the person you're replying for 'lacks mental capacity'?" on the page
    When I see "Eligibility" on the page
    And I choose the "No" radio button
    And I press the "Continue" button
	
	#Confirm Date of Jury
    Then I see "Check your start date" on the page
    When I set the radio button to "No, we need to change the date"
    And I press the "Continue" button
	
	#Deferral Reason
    And I see "steps/confirm-date/deferral-reason/tp" in the URL
    Then I see "Tell us why they need another date for their jury service" on the page
    When I set text area with "id" of "deferralReason" to "askForAnotherDateReasonWhy"
    And I press the "Continue" button
	
	#JDB-3445 Deferral Date Screen Layout
    And I see "steps/confirm-date/deferral-dates/tp" in the URL
    Then I see "Choose 3 Mondays when they can start jury service" on the page

    And I create a bank holiday "11" Mondays in the future for court/bureau "400" new schema

    When I set the "First" single date field to a Monday "9" weeks in the future
    When I set the "Second" single date field to a Monday "10" weeks in the future
    When I set the "Third" single date field to a Monday "11" weeks in the future
    And I press the "Continue" button

    And on the page I see
      | text                                                                            |
      | Check dates                                                                     |
      | Dates they can start jury service                                               |
      | First choice                                                                    |
      | Second choice                                                                   |
      | Third choice                                                                    |
      | You do not need to tell us all other dates they're available.                   |
      | We'll choose one of these 3 dates.                                              |
      | In the unlikely event that we cannot use one of these dates, we'll contact you. |

    And I validate the "First" deferral date is "9" weeks in the future
    And I validate the "Second" deferral date is "10" weeks in the future
    And I validate the "Third" deferral date is "11" weeks in the future

    Then I choose the "Yes" radio button
    And I press the "Continue" button
	
	#Bank Holiday
    Then on the page I see
      | text                                                                                                 |
      | At least one of the Mondays you selected is a bank holiday                                           |
      | You've selected at least one Monday that's a UK bank holiday.                                        |
      | If we choose this as their start date, their jury service will start on the Tuesday at the earliest. |
      | We'll send confirmation of the start date.                                                           |

    And I press the "Continue" button
	
	#help at court
    Then I see "Will the person you're replying for need help when they're at the court?" on the page
    When I choose the "No" radio button
    And I press the "Continue" button
	
	#check answers
    And on the page I see
      | text                                                                       |
      | Check your answers now                                                     |
      | Confirm the date of their jury service                                     |
      | I need to change the date of jury service for the person I'm answering for |
      | Tell us why they need another date for their jury service                  |
      | askForAnotherDateReasonWhy                                                 |
      | Choose 3 Mondays when they can start jury service                          |
      | First choice                                                               |
      | Second choice                                                              |
      | Third choice                                                               |

    And I validate the "First" deferral date is "9" weeks in the future
    And I validate the "Second" deferral date is "10" weeks in the future
    And I validate the "Third" deferral date is "11" weeks in the future

    When I check the "The answers I have given for the person I'm replying for are true as far as I know" checkbox
    And I press the "Submit" button

    Then on the page I see
      | text                                                                                                                                                                            |
      | You have completed your reply                                                                                                                                                   |
      | If we get in touch with them, they may need to give their juror number. It's also on the letter we sent them.                                                                   |
      | We have sent an email to say you have replied to this jury summons.                                                                                                             |
      | Download a copy of your summons reply                                                                                                                                           |
      | If they can do jury service, at least 2 weeks before it starts we'll send them:                                                                                                 |
      | a letter confirming the date of their jury service                                                                                                                              |
      | an information pack about being a juror and the court they're going to                                                                                                          |
      | Getting ready for jury service                                                                                                                                                  |
      | The information below is also in the email that we have sent.                                                                                                                   |
      | You or the person you've replied for, can watch this video on YouTube about what happens when you're a juror, so they know what to expect. The video takes 13 minutes to watch. |
      | Learn more about jury service. You can read the rules about discussing the trial and find out how to claim expenses.                                                            |
      | Calculate what expenses and allowances you can claim.                                                                                                                           |
      | What did you think of this service? (Takes 30 seconds)                                                                                                                          |

    And I do not see "Your Guide to Jury Service (PDF 85KB)" on the page

    Then I click on the "Download a copy of your summons reply HTML" link
    And on the page I see
      | text                                                                       |
      | Copy of your jury summons reply                                            |
      | Confirm the date of their jury service                                     |
      | I need to change the date of jury service for the person I'm answering for |
      | Tell us why they need another date for their jury service                  |
      | askForAnotherDateReasonWhy                                                 |
      | Choose 3 Mondays when they can start jury service                          |
      | First choice                                                               |
      | Second choice                                                              |
      | Third choice                                                               |

    And I validate the "First" deferral date is "9" weeks in the future
    And I validate the "Second" deferral date is "10" weeks in the future
    And I validate the "Third" deferral date is "11" weeks in the future

    And I delete bank holiday new schema

    Examples:
      | juror_number | last_name        | postcode | email             | pool_number |
      | 045200086    | LNAMESIXSEVENSIX | SW1H 9AJ | email@outlook.com | 452300085   |

  @Regression
  Scenario Outline: English 3rd Party Deferral - selected date makes juror >76

    Given I am on "Public" "test"

    Given a bureau owned pool is created with jurors
      | court | juror_number   | pool_number   | att_date_weeks_in_future | owner |
      | 452   | <juror_number> | <pool_number> | 11                       | 400   |

    And juror "<juror_number>" has "LAST_NAME" as "<last_name>" new schema
    And juror "<juror_number>" has "POSTCODE" as "<postcode>" new schema

    Then I see "Reply to a jury summons" on the page

    And I set the radio button to "I am replying for someone else"
    And I press the "Continue" button
    Then I see "Their juror details" on the page
	
	#Juror Log In
    When I set "9-digit juror number" to "<juror_number>"
    When I set "Juror last name" to "<last_name>"
    When I set "Juror postcode" to "<postcode>"
    And I press the "Continue" button
    Then I see "What is your name?" on the page
	
	#3rd Party Name
    When I see "Your Details" on the page
    When I set "First name" to "FirstNameA"
    And I set "Last name" to "LastNameB"
    And I press the "Continue" button
    Then I see "Your relationship to the person" on the page
	
	#Relationship to juror
    When I see "Your Details" on the page
    And I set "How do you know the person you're replying for?" to "Friend"
    And I press the "Continue" button
    Then I see "Your contact information" on the page
	
	#3rd Party Contact
    When I see "Your Details" on the page
    And I check the "By phone (UK Numbers only)" checkbox
    And I set "Main phone" to "0207 821 1818"
    And I check the "By email" checkbox
    And I set "Enter your email address" to "<email>"
    And I set "Enter your email address again" to "<email>"
    And I press the "Continue" button
	
	#Why are you replying title
    Then I see "Why are you replying for the other person?" on the page
    And I do not see "Why are you replying?" on the page
    When I set the radio button to "The person is not here"
    And I press the "Continue" button
    Then I see "Is the name we have for them correct?" on the page
	
	#Check juror name
    When I see "Juror Details" on the page
    And I choose the "Yes" radio button
    And I press the "Continue" button
    Then I see "Is this their address?" on the page
	
	#Check juror address
    When I see "Juror Details" on the page
    And I choose the "Yes" radio button
    And I press the "Continue" button
    Then I see "Give the date of birth for the person you're replying for" on the page
	
	#DoB
    When I see "Juror Details" on the page
    When I set the date of birth to a Monday "-3950" weeks in the future

    And I press the "Continue" button
    Then I see "We might need to get in touch with the person to ask them more questions or give them information about their jury service" on the page
	
	#Contacting the juror
    When I see "Juror Details" on the page
    And I set the radio button to "Use the phone number that you have already given to contact you"
    And I set the radio button to "Use the email address that you have already given to contact you"
    And I press the "Continue" button
	
	#Qualify for jury service
    When I see "Confirm if the person is eligible for jury service" on the page
    And I press the "Continue" button
	
	#Residency
    Then I see "Since they turned 13, has their main address been in the UK, Channel Islands or Isle of Man for any period of at least 5 years?" on the page
    When I see "Eligibility" on the page
    And I choose the "Yes" radio button
    And I press the "Continue" button
	
	#Have you ever worked
    Then I see "Has the person you're replying for worked in the criminal justice system in the last 5 years?" on the page
    When I choose the "No" radio button
    And I press the "Continue" button
	
	#Bail
    Then I see "Is the person currently on bail for a criminal offence?" on the page
    When I see "Eligibility" on the page
    And I choose the "No" radio button
    And I press the "Continue" button
	
	#Convictions
    Then I see "Has the person been found guilty of a criminal offence?" on the page
    When I see "Eligibility" on the page
    And I choose the "Yes" radio button
    And I set text area with "id" of "convictedDetails" to "Criminal Convictions"
    And I press the "Continue" button
	
	#Mental Health Sectioned
    Then I see "Is the person you're replying for being detained, looked after or treated under the Mental Health Act?" on the page
    When I see "Eligibility" on the page
    And I choose the "No" radio button
    And I press the "Continue" button
	
	#Mental Health Capacity
    Then I see "Has it been decided that the person you're replying for 'lacks mental capacity'?" on the page
    When I see "Eligibility" on the page
    And I choose the "No" radio button
    And I press the "Continue" button
	
	#Confirm Date of Jury
    Then I see "Check your start date" on the page
    When I set the radio button to "No, we need to change the date"
    And I press the "Continue" button
	
	#Deferral Reason
    And I see "steps/confirm-date/deferral-reason/tp" in the URL
    Then I see "Tell us why they need another date for their jury service" on the page
    When I set text area with "id" of "deferralReason" to "askForAnotherDateReasonWhy"
    And I press the "Continue" button
	
	#JDB-3445 Deferral Date Screen Layout
    And I see "steps/confirm-date/deferral-dates/tp" in the URL
    Then I see "Choose 3 Mondays when they can start jury service" on the page
	
	#check hint text
    Then I click on the "Will they need to serve longer than 2 weeks?" link
    And I see "Most jurors only need to serve 2 weeks." on the page
    And I see "They may be asked to serve for longer when they arrive at court." on the page
    And I see "If they cannot serve for more than 2 weeks, they'll be able to discuss this with the jury manager at court." on the page

    Then I click on the "What if there's a problem nearer the time and they cannot serve?" link
    And I see "You or they must contact us at that time to let us know." on the page
	
	#collapse hint text
    Then I click on the "Will they need to serve longer than 2 weeks?" link
    And I do not see "Most jurors only need to serve 2 weeks." on the page
    And I do not see "They may be asked to serve for longer when they arrive at court." on the page
    And I do not see "If they cannot serve for more than 2 weeks, they'll be able to discuss this with the jury manager at court." on the page

    Then I click on the "What if there's a problem nearer the time and they cannot serve?" link
    And I do not see "You or they must contact us at that time to let us know." on the page

    When I set the "First" single date field to a Monday "55" weeks in the future
    When I set the "Second" single date field to a Monday "56" weeks in the future
    When I set the "Third" single date field to a Monday "57" weeks in the future

    And I press the "Continue" button

    Then on the page I see
      | text                                                                                                   |
      | There is a problem                                                                                     |
      | Give another date, the juror will be older than 76 on this date and would not qualify for jury service |

    When I set the "First" single date field to a Monday "14" weeks in the future
    When I set the "Second" single date field to a Monday "13" weeks in the future
    When I set the "Third" single date field to a Monday "12" weeks in the future

    And I press the "Continue" button

    And on the page I see
      | text                                                                            |
      | Dates they can start jury service                                               |
      | First choice                                                                    |
      | Second choice                                                                   |
      | Third choice                                                                    |
      | You do not need to tell us all other dates they're available.                   |
      | We'll choose one of these 3 dates.                                              |
      | In the unlikely event that we cannot use one of these dates, we'll contact you. |

    And I validate the "First" deferral date is "12" weeks in the future
    And I validate the "Second" deferral date is "13" weeks in the future
    And I validate the "Third" deferral date is "14" weeks in the future
	
	#check hint text
    Then I click on the "Will they need to serve longer than 2 weeks?" link
    And I see "Most jurors only need to serve 2 weeks." on the page
    And I see "They may be asked to serve for longer when they arrive at court." on the page
    And I see "If they cannot serve for more than 2 weeks, they'll be able to discuss this with the jury manager at court." on the page

    Then I click on the "What if there's a problem nearer the time and they cannot serve?" link
    And I see "You or they must contact us at that time to let us know." on the page
	
	#collapse hint text
    Then I click on the "Will they need to serve longer than 2 weeks?" link
    And I do not see "Most jurors only need to serve 2 weeks." on the page
    And I do not see "They may be asked to serve for longer when they arrive at court." on the page
    And I do not see "If they cannot serve for more than 2 weeks, they'll be able to discuss this with the jury manager at court." on the page

    Then I click on the "What if there's a problem nearer the time and they cannot serve?" link
    And I do not see "You or they must contact us at that time to let us know." on the page

    Then I choose the "Yes" radio button
    And I press the "Continue" button
	
	#help at court
    Then I see "Will the person you're replying for need help when they're at the court?" on the page
    When I choose the "No" radio button
    And I press the "Continue" button

	#check answers
    And on the page I see
      | text                                                                       |
      | Check your answers now                                                     |
      | Confirm the date of their jury service                                     |
      | I need to change the date of jury service for the person I'm answering for |
      | Tell us why they need another date for their jury service                  |
      | askForAnotherDateReasonWhy                                                 |
      | Choose 3 Mondays when they can start jury service                          |
      | First choice                                                               |
      | Second choice                                                              |
      | Third choice                                                               |

    And I validate the "First" deferral date is "12" weeks in the future
    And I validate the "Second" deferral date is "13" weeks in the future
    And I validate the "Third" deferral date is "14" weeks in the future

    When I check the "The answers I have given for the person I'm replying for are true as far as I know" checkbox
    And I press the "Submit" button

    Then on the page I see
      | text                                                                                                                                                                            |
      | You have completed your reply                                                                                                                                                   |
      | If we get in touch with them, they may need to give their juror number. It's also on the letter we sent them.                                                                   |
      | We have sent an email to say you have replied to this jury summons.                                                                                                             |
      | Download a copy of your summons reply                                                                                                                                           |
      | If they can do jury service, at least 2 weeks before it starts we'll send them:                                                                                                 |
      | a letter confirming the date of their jury service                                                                                                                              |
      | an information pack about being a juror and the court they're going to                                                                                                          |
      | Getting ready for jury service                                                                                                                                                  |
      | The information below is also in the email that we have sent.                                                                                                                   |
      | You or the person you've replied for, can watch this video on YouTube about what happens when you're a juror, so they know what to expect. The video takes 13 minutes to watch. |
      | Learn more about jury service. You can read the rules about discussing the trial and find out how to claim expenses.                                                            |
      | Calculate what expenses and allowances you can claim.                                                                                                                           |
      | What did you think of this service? (Takes 30 seconds)                                                                                                                          |

    And I do not see "Your Guide to Jury Service (PDF 85KB)" on the page

    Then I click on the "Download a copy of your summons reply HTML" link
    And on the page I see
      | text                                                                       |
      | Copy of your jury summons reply                                            |
      | Confirm the date of their jury service                                     |
      | I need to change the date of jury service for the person I'm answering for |
      | Tell us why they need another date for their jury service                  |
      | askForAnotherDateReasonWhy                                                 |
      | Choose 3 Mondays when they can start jury service                          |
      | First choice                                                               |
      | Second choice                                                              |
      | Third choice                                                               |

    And I validate the "First" deferral date is "12" weeks in the future
    And I validate the "Second" deferral date is "13" weeks in the future
    And I validate the "Third" deferral date is "14" weeks in the future

    Examples:
      | juror_number | last_name        | postcode | pool_number | email      |
      | 045200087    | LNAMESIXSEVENSIX | SW1H 9AJ | 452300086   | e@mail.com |