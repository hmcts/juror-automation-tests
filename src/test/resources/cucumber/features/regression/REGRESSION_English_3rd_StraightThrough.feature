Feature: Regression English_3rd_StraightThrough

  @Regression @NewSchemaConverted
  Scenario Outline: English 3rd Party Straight Through

    Given I am on "Public" "test"

    Given a bureau owned pool is created with jurors
      | court | juror_number   | pool_number   | att_date_weeks_in_future | owner |
      | 452   | <juror_number> | <pool_number> | 5                        | 400   |

    And juror "<juror_number>" has "LAST_NAME" as "<last_name>" new schema
    And juror "<juror_number>" has "POSTCODE" as "<postcode>" new schema

    Then I see "Reply to a jury summons" on the page
    And I do not see "Beta" on the page
    And I see "Give feedback (opens in a new window or tab)" on the page

    And I set the radio button to "I am replying for someone else"
    And I press the "Continue" button
    And I see "steps/login/tp" in the URL
    Then I see "Their juror details" on the page
    And I see "You can find their juror number on the jury summons letter." on the page
    And I click on the "I do not have a juror number for the person" link
    And I see "jurysummoning@justice.gov.uk" on the page
    And I see "If you do not have a juror number for the person you are replying for, please contact:" on the page
	
	#Juror Log In
    When I set "9-digit juror number" to "<juror_number>"
    When I set "Juror last name" to "<last_name>"
    When I set "Juror postcode" to "<postcode>"
    And I press the "Continue" button
    Then I see "What is your name?" on the page
    And I do not see "Beta" on the page
    And I see "Give feedback (opens in a new window or tab)" on the page
	
	#3rd Party Name
    And I see "branches/third-party-details/name" in the URL
    When I see "Your Details" on the page
    When I set "First name" to "FirstNameA"
    And I set "Last name" to "LastNameB"
    And I press the "Continue" button
    Then I see "Your relationship to the person" on the page
    And I do not see "Beta" on the page
    And I see "Give feedback (opens in a new window or tab)" on the page
	
	#Relationship to juror
    And I see "branches/third-party-details/relationship" in the URL
    When I see "Your Details" on the page
    And I set "How do you know the person you're replying for?" to "Friend"
    And I press the "Continue" button
    Then I see "Your contact information" on the page
    And I do not see "Beta" on the page
    And I see "Give feedback (opens in a new window or tab)" on the page
	
	#3rd Party Contact
    And I see "branches/third-party-details/contact" in the URL
    When I see "Your Details" on the page
    And I check the "By phone (UK Numbers only)" checkbox
    And I see "Provide a UK phone number that we can use to reach you between 9am and 5pm, Monday to Friday." on the page
    And I set "Main phone" to "0207 821 1818"
    And I check the "By email" checkbox
    And I set "Enter your email address" to "email@outlook.com"
    And I set "Enter your email address again" to "email@outlook.com"
    And I click on the "If you are living abroad" link
    And I see "If you are currently living abroad and do not have a UK telephone number, we will need to contact you using an email address." on the page
    And I press the "Continue" button
	
	#Why Replying
    And I see "branches/third-party-reason" in the URL
    Then I see "Why are you replying for the other person?" on the page
    And I do not see "Beta" on the page
    And I see "Give feedback (opens in a new window or tab)" on the page
    And I do not see "Why are you replying?" on the page
    When I set the radio button to "The person is not here"
    And I see "They might be travelling, in hospital or away for more than a few days for some other reason." on the page
    And I see "The person is unable to reply by themselves" on the page
    And I see "The person cannot reply for themselves. This might be because they have a disability or impairment." on the page
    And I press the "Continue" button
    Then I see "Is the name we have for them correct?" on the page
    And I do not see "Beta" on the page
    And I see "Give feedback (opens in a new window or tab)" on the page
	
	#Check juror name
    And I see "branches/third-party-personal-details/name" in the URL
    When I see "Juror Details" on the page
    And I choose the "Yes" radio button
    And I press the "Continue" button
    Then I see "Is this their address?" on the page
    And I do not see "Beta" on the page
    And I see "Give feedback (opens in a new window or tab)" on the page
	
	#Check juror address
    And I see "branches/third-party-personal-details/address" in the URL
    When I see "Juror Details" on the page
    And I choose the "Yes" radio button
    And I press the "Continue" button
    Then I see "Give the date of birth for the person you're replying for" on the page
    And I do not see "Beta" on the page
    And I see "Give feedback (opens in a new window or tab)" on the page
	
	#DoB
    And I see "branches/third-party-personal-details/date-of-birth" in the URL
    When I see "Juror Details" on the page
    And I see "For example, 15 03 1982" on the page
    And I set "Day" to "01"
    And I set "Month" to "01"
	
	#JDB-3418 Checking age 18 works
    And I set "Year" to "2000"
    And I press the "Continue" button
    Then I see "We might need to get in touch with the person to ask them more questions or give them information about their jury service" on the page
    And I do not see "Beta" on the page
    And I see "Give feedback (opens in a new window or tab)" on the page
	
	#Contacting the juror
    And I see "branches/third-party-contact-details" in the URL
    When I see "Juror Details" on the page
    And I see "Give phone numbers that we can use to call you or the juror between 9am and 5pm, Monday to Friday." on the page
    And I set the radio button to "Use the phone number that you have already given to contact you"
    And I set the radio button to "Use the email address that you have already given to contact you"
    And I press the "Continue" button
    And I do not see "Beta" on the page
    And I see "Give feedback (opens in a new window or tab)" on the page
	
	#Qualify for jury service
	#JDB-4636
    And I see "steps/qualify/tp" in the URL
    Then I see "Confirm if the person is eligible for jury service" on the page
    And I do not see "Qualifying for jury service" on the page
    And I see "Your answers in this next section will help us check if the person you’re replying for can do jury service or not." on the page
    And I see "You must answer these questions even if you:" on the page
    And I see "think they’re not eligible" on the page
    And I see "want to ask for them to be excused" on the page
    And I see "You can ask for an excusal after this section, if needed." on the page
    And I do not see "Beta" on the page
    And I see "Give feedback (opens in a new window or tab)" on the page
    When I press the "Continue" button
	
	#Residency
    Then I see "Since they turned 13, has their main address been in the UK, Channel Islands or Isle of Man for any period of at least 5 years?" on the page
    And I see "steps/qualify/residency/tp" in the URL
    And I do not see "Qualifying for jury service" on the page
    When I see "Eligibility" on the page
    And I do not see "Beta" on the page
    And I see "Give feedback (opens in a new window or tab)" on the page
    And I click on the "Need help answering this?" link
    And I see "You must contact us to get advice on their specific situation." on the page
    And I choose the "Yes" radio button
    And I press the "Continue" button
	
	#CJS no
    Then I see "Has the person you're replying for worked in the criminal justice system in the last 5 years?" on the page
    And I see "steps/qualify/cjs-employed/tp" in the URL
    And I do not see "Beta" on the page
    When I see "Eligibility" on the page
    And I do not see "Qualifying for jury service" on the page
    And I see "Give feedback (opens in a new window or tab)" on the page
    When I choose the "No" radio button
    And I click on the "Why do we ask this?" link
    And I click on the "Back" link
    And I see "Eligibility" on the page
    And I see "Since they turned 13, has their main address been in the UK, Channel Islands or Isle of Man for any period of at least 5 years?" on the page
    And the radio button "Yes" is "Selected"
    And I press the "Continue" button
    Then I see "Has the person you're replying for worked in the criminal justice system in the last 5 years?" on the page
    When I choose the "No" radio button
    And I press the "Continue" button
	
	#Bail
    And I see "steps/qualify/bail/tp" in the URL
    And I see "Is the person currently on bail for a criminal offence?" on the page
    And I see "If the person you're answering for is on bail in criminal proceedings, they cannot do jury service." on the page
    And I do not see "Qualifying for jury service" on the page
    And I see "Eligibility" on the page
    And I do not see "Beta" on the page
    And I see "Give feedback (opens in a new window or tab)" on the page
    And I click on the "Back" link
    Then I see "Has the person you're replying for worked in the criminal justice system in the last 5 years?" on the page
    And the radio button "No" is "Selected"
    And I press the "Continue" button
    Then I see "Is the person currently on bail for a criminal offence?" on the page
    When I choose the "No" radio button
    And I press the "Continue" button
	
	#Convictions
    And I see "steps/qualify/convictions/tp" in the URL
    And I see "Has the person been found guilty of a criminal offence?" on the page
    And I do not see "Qualifying for jury service" on the page
    When I see "Eligibility" on the page
    And I do not see "Beta" on the page
    And I see "Give feedback (opens in a new window or tab)" on the page
	
	#JDB-4552
    When I click on the "Guidance on jury service if you have a conviction" link

    Then I see "When they can do jury service" on the page

    And on the page I see
      | text                                                                                                                                                                                                                                                                                        |
      | They can do jury service if they've:                                                                                                                                                                                                                                                        |
      | had a speeding fine                                                                                                                                                                                                                                                                         |
      | had points on their driving license                                                                                                                                                                                                                                                         |
      | been told to attend a speed awareness course                                                                                                                                                                                                                                                |
      | This applies as long as they did not receive any of the sentences below.                                                                                                                                                                                                                    |
      | When they cannot do jury service                                                                                                                                                                                                                                                            |
      | They cannot do jury service if they've ever had one of the criminal sentences below in the UK, Channel Islands or Isle of Man. They also cannot do jury service if they've had one of these criminal sentences for a service offence under the Armed Forces Act 2006 anywhere in the world: |
      | imprisonment or detention for 5 years or more                                                                                                                                                                                                                                               |
      | imprisonment for public protection or detention for public protection                                                                                                                                                                                                                       |
      | imprisonment, custody or detention for life                                                                                                                                                                                                                                                 |
      | an extended sentence under either of sections 226A, 226B, 227 or 228 of the Criminal Justice Act 2003, (including such a sentence imposed as a result of section 219A, 220, 221A or 222 of the Armed Forces Act 2006) or section 210A of the Criminal Procedure (Scotland) Act 1995         |
      | detention at His Majesty's pleasure or during the pleasure of the Secretary of State                                                                                                                                                                                                        |
      | They also cannot do jury service if they've had one of these criminal sentences in the last 10 years:                                                                                                                                                                                       |
      | they served any part of a sentence of imprisonment or detention                                                                                                                                                                                                                             |
      | they received a suspended sentence of imprisonment or a suspended order for detention                                                                                                                                                                                                       |
      | They also cannot do jury service if, in the last 10 years in England and Wales, they've had a community order, including any of the following:                                                                                                                                              |
      | community rehabilitation order                                                                                                                                                                                                                                                              |
      | community punishment order                                                                                                                                                                                                                                                                  |
      | community punishment and rehabilitation order                                                                                                                                                                                                                                               |
      | drug treatment and testing order                                                                                                                                                                                                                                                            |
      | drug abstinence order                                                                                                                                                                                                                                                                       |
      | They also cannot do jury service if, in the last 10 years, they've had:                                                                                                                                                                                                                     |
      | any similar order under the law of Scotland, Northern Ireland, Isle of Man or any of the Channel Islands                                                                                                                                                                                    |
      | a community or overseas community order under the Armed Forces Act 2006                                                                                                                                                                                                                     |
      | If someone serves on a jury when they know they should not because of a criminal conviction, they may be fined up to £5,000.                                                                                                                                                                |

    And I press the "Continue" button
    And I see "Has the person been found guilty of a criminal offence?" on the page
    When I choose the "No" radio button
    And I press the "Continue" button
		
	#Mental Health Sectioned
    And I see "steps/qualify/mental-health-sectioned/tp" in the URL
    And I see "Is the person you're replying for being detained, looked after or treated under the Mental Health Act?" on the page
    And I do not see "Qualifying for jury service" on the page
    When I see "Eligibility" on the page
    And I do not see "Beta" on the page
    And I see "Give feedback (opens in a new window or tab)" on the page
    And I click on the "Back" link
    And I see "Has the person been found guilty of a criminal offence?" on the page
    And the radio button "No" is "Selected"
    And I press the "Continue" button
    And I see "Is the person you're replying for being detained, looked after or treated under the Mental Health Act?" on the page
    And I choose the "No" radio button
    And I press the "Continue" button
	
	#Mental Health Capacity
    And I see "steps/qualify/mental-health-capacity/tp" in the URL
    Then I see "Has it been decided that the person you're replying for 'lacks mental capacity'?" on the page
    And I do not see "Qualifying for jury service" on the page
    When I see "Eligibility" on the page
    And I do not see "Beta" on the page
    And I see "Give feedback (opens in a new window or tab)" on the page
    And I click on the "Back" link
    And I see "Is the person you're replying for being detained, looked after or treated under the Mental Health Act?" on the page
    And the radio button "No" is "Selected"
    And I press the "Continue" button
    Then I see "Has it been decided that the person you're replying for 'lacks mental capacity'?" on the page
    And I choose the "No" radio button
    And I press the "Continue" button

    Then I see "Check your start date" on the page
    And I do not see "Eligibility" on the page
	
	#The person can attend
    And I see "steps/confirm-date/tp" in the URL
    Then I set the radio button to "Yes, they can start on"

    And  I press the "Continue" button

	#RA no
    And I see "steps/assistance/tp" in the URL
    When I choose the "No" radio button
    And I press the "Continue" button
    Then I see "Check your answers now" on the page
    And I do not see "Beta" on the page
    And I see "Give feedback (opens in a new window or tab)" on the page
	
	#Check your answers
    And I see "steps/confirm-information/tp" in the URL
    And I see "You answered the eligibility questions for the person you're replying for" on the page
    When I see text "No" in the same row as "Is the person you're replying for being detained, looked after or treated under the Mental Health Act?"
    And I see text "No" in the same row as "Has it been decided that the person you're replying for 'lacks mental capacity'?"
    And I see "I understand that the answers I have given may be checked and that I may be prosecuted if I have given false information on purpose." on the page
	
	#JDB-4552
    And I see "You may be convicted and fined up to £1000 if you give false information for the person summoned to evade jury service. This also applies if you fail to give us the information we need to decide if the person summoned is eligible to do jury service." on the page

    When I check the "The answers I have given for the person I'm replying for are true as far as I know." checkbox
    And I press the "Submit" button
	
	#When I press the "Submit" button
    And I see "steps/confirmation/tp" in the URL
    And I do not see "Beta" on the page
    And I see "Give feedback (opens in a new window or tab)" on the page
    Then I see "We have sent an email to say you have replied to this jury summons." on the page
    And I see "Download a copy of your summons reply PDF (65KB)" on the page
    Then I click on the "Download a copy of your summons reply HTML (15KB)" link
    And I see "You answered the eligibility questions for the person you're replying for" on the page

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
    When I log in as "CPASS"
    Then I see "<juror_number>" on the page
    Then I see "<juror_number>" has reply type indicator "Needs review"

    Examples:
      | juror_number | last_name       | postcode | email             | pool_number |
      | 045200091    | LNAMETWOSIXZERO | CH1 2AN  | email@outlook.com | 452300090   |

  @Regression @NewSchemaConverted
  Scenario Outline: English 3rd Party Straight Through Change Links

    Given I am on "Public" "test"

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
	
	#Why Replying
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
    And I set "Year" to "2000"
    And I press the "Continue" button
	
	#Contacting the juror
    And I set the radio button to "Use the phone number that you have already given to contact you"
    And I set the radio button to "Use the email address that you have already given to contact you"
    And I press the "Continue" button

	#Qualify for jury service
	#JDB-4636
    When I press the "Continue" button

	#Residency
    And I choose the "Yes" radio button
    And I press the "Continue" button
	
	#CJS no
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
    Then I set the radio button to "Yes, they can start on"
    And  I press the "Continue" button

	#RA no
    When I choose the "No" radio button
    And I press the "Continue" button
	
	#Check your answers
    Then I see "Check your answers now" on the page
	
	#change links
    When I click on the "Change" link in the same row as "Since they turned 13, has their main address been in the UK, Channel Islands or Isle of Man for any period of at least 5 years?"
    Then I see "Since they turned 13, has their main address been in the UK, Channel Islands or Isle of Man for any period of at least 5 years?" on the page
    When I see "Eligibility" on the page
    When I choose the "No" radio button
    And I set "Provide details" to "Residency information"
    And I press the "Continue" button
    Then I see text "Residency information" in the same row as "Since they turned 13, has their main address been in the UK, Channel Islands or Isle of Man for any period of at least 5 years?"

    When I click on the "Change" link in the same row as "Has the person you're replying for worked in the criminal justice system in the last 5 years?"
    Then I see "Has the person you're replying for worked in the criminal justice system in the last 5 years?" on the page
    When I see "Eligibility" on the page
    When I choose the "Yes" radio button
    And I check the "Police service" checkbox
    And I set "Which police service?" to "London Met Police"
    And I press the "Continue" button

    Then on the page I see
      | text              |
      | Yes               |
      | Police service    |
      | London Met Police |

    When I click on the "Change" link in the same row as "Is the person you're replying for being detained, looked after or treated under the Mental Health Act?"
    Then I see "Is the person you're replying for being detained, looked after or treated under the Mental Health Act?" on the page
    When I see "Eligibility" on the page
    When I choose the "Yes" radio button
    And I set "Provide details" to "I am sectioned and detained"
    And I press the "Continue" button
    Then I see text "Yes - I am sectioned and detained" in the same row as "Is the person you're replying for being detained, looked after or treated under the Mental Health Act?"

    When I click on the "Change" link in the same row as "Has it been decided that the person you're replying for 'lacks mental capacity'?"
    Then I see "Has it been decided that the person you're replying for 'lacks mental capacity'?" on the page
    When I see "Eligibility" on the page
    When I choose the "Yes" radio button
    And I set "Provide brief details about why it was decided they lack mental capacity" to "I lack capacity"
    And I press the "Continue" button
    Then I see text "Yes - I lack capacity" in the same row as "Has it been decided that the person you're replying for 'lacks mental capacity'?"

    When I click on the "Change" link in the same row as "Is the person currently on bail for a criminal offence?"
    Then I see "Is the person currently on bail for a criminal offence?" on the page
    When I see "Eligibility" on the page
    When I choose the "Yes" radio button
    And I set "Provide details" to "I am on bail for crimes"
    And I press the "Continue" button
    Then I see text "Yes - I am on bail for crimes" in the same row as "Is the person currently on bail for a criminal offence?"

    When I click on the "Change" link in the same row as "Has the person been convicted of a criminal offence and been given a sentence?"
    Then I see "Has the person been found guilty of a criminal offence?" on the page
    When I see "Eligibility" on the page
    When I choose the "Yes" radio button
    And I set text area with "id" of "convictedDetails" to "I am a convicted criminal"
    And I press the "Continue" button
    Then I see text "Yes - I am a convicted criminal" in the same row as "Has the person been convicted of a criminal offence and been given a sentence?"

	#submit
    And I check the "The answers I have given for the person I'm replying for are true as far as I know." checkbox
    And I press the "Submit" button

    Then I click on the "Download a copy of your summons reply HTML (15KB)" link
    And I see "You answered the eligibility questions" on the page

    Examples:
      | juror_number | last_name       | postcode | email      | pool_number |
      | 045200092    | LNAMEONEONENINE | CH1 2AN  | a@eeee.com | 452300091   |

  @Regression @NewSchemaConverted
  Scenario Outline: English 1st Party Straight Through Navigate Back

    Given I am on "Public" "test"

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
	
	#Why Replying
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
    And I set "Year" to "2000"
    And I press the "Continue" button
	
	#Contacting the juror
    And I set the radio button to "Use the phone number that you have already given to contact you"
    And I set the radio button to "Use the email address that you have already given to contact you"
    And I press the "Continue" button
	
	#eligiblity
    And I press the "Continue" button

	#Residency
    And I see "steps/qualify/residency/tp" in the URL
    And I do not see "Qualifying for jury service" on the page
    When I see "Eligibility" on the page

    And I choose the "Yes" radio button
    And I press the "Continue" button
	
	#CJS no
    And I see "steps/qualify/cjs-employed/tp" in the URL
    When I see "Eligibility" on the page
    And I do not see "Qualifying for jury service" on the page

    When I choose the "No" radio button
    And I press the "Continue" button
	
	#Bail
    And I see "steps/qualify/bail/tp" in the URL
    And I do not see "Qualifying for jury service" on the page
    And I see "Eligibility" on the page

    When I choose the "No" radio button
    And I press the "Continue" button
	
	#Convictions
    And I see "steps/qualify/convictions/tp" in the URL
    And I do not see "Qualifying for jury service" on the page
    When I see "Eligibility" on the page

    When I choose the "No" radio button
    And I press the "Continue" button
		
	#Mental Health Sectioned
    And I see "steps/qualify/mental-health-sectioned/tp" in the URL
    And I do not see "Qualifying for jury service" on the page
    When I see "Eligibility" on the page

    And I choose the "No" radio button
    And I press the "Continue" button
	
	#Mental Health Capacity
    And I see "steps/qualify/mental-health-capacity/tp" in the URL
    And I do not see "Qualifying for jury service" on the page
    When I see "Eligibility" on the page

    And I choose the "No" radio button
    And I press the "Continue" button

    Then I see "Check your start date" on the page

	#navigate back
    And I click on the "Back" link
    Then I see "Has it been decided that the person you're replying for 'lacks mental capacity'?" on the page
    And the radio button "No" is "Selected"

    And I click on the "Back" link
    Then I see "Is the person you're replying for being detained, looked after or treated under the Mental Health Act?" on the page
    And the radio button "No" is "Selected"

    And I click on the "Back" link
    Then I see "Has the person been found guilty of a criminal offence?" on the page
    And the radio button "No" is "Selected"

    And I click on the "Back" link
    Then I see "Is the person currently on bail for a criminal offence?" on the page
    And the radio button "No" is "Selected"

    And I click on the "Back" link
    Then I see "Has the person you're replying for worked in the criminal justice system in the last 5 years?" on the page
    And the radio button "No" is "Selected"

    And I click on the "Back" link
    Then I see "Since they turned 13, has their main address been in the UK, Channel Islands or Isle of Man for any period of at least 5 years?" on the page
    And the radio button "Yes" is "Selected"
	
	#navigate forward
    And I press the "Continue" button

    Then I see "Has the person you're replying for worked in the criminal justice system in the last 5 years?" on the page
    And the radio button "No" is "Selected"

    And I press the "Continue" button

    Then I see "Is the person currently on bail for a criminal offence?" on the page
    And the radio button "No" is "Selected"

    And I press the "Continue" button

    Then I see "Has the person been found guilty of a criminal offence?" on the page
    And the radio button "No" is "Selected"

    And I press the "Continue" button

    Then I see "Is the person you're replying for being detained, looked after or treated under the Mental Health Act?" on the page
    And the radio button "No" is "Selected"

    And I press the "Continue" button

    Then I see "Has it been decided that the person you're replying for 'lacks mental capacity'?" on the page
    And the radio button "No" is "Selected"

    And I press the "Continue" button
	
	#I can attend
    Then I see "Check your start date" on the page
    And I do not see "Eligibility" on the page

    Then I set the radio button to "Yes, they can start on"
    And I press the "Continue" button

	#RA no
    Then I see "Does the person have a disability or impairment that means they’ll need extra support or facilities in the court building where they are doing jury service?" on the page

    When I choose the "No" radio button

    And I press the "Continue" button
	
	#Check your answers
    Then I see "Check your answers now" on the page
    And I see "You answered the eligibility questions for the person you're replying for" on the page
	
	#submit
    And I check the "The answers I have given for the person I'm replying for are true as far as I know." checkbox
    And I press the "Submit" button

    Then I click on the "Download a copy of your summons reply HTML (15KB)" link
    And I see "You answered the eligibility questions for the person you're replying for" on the page

    Examples:
      | juror_number | last_name       | postcode | email      | pool_number |
      | 045200093    | LNAMEONEONENINE | CH1 2AN  | a@eeee.com | 452300092   |