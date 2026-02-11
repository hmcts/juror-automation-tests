Feature: Regression English_1st_MH

  @Regression
  Scenario Outline: Checking the word Act in Mental Health Act is capitalised

    Given I am on "Public" "test"

    Given a bureau owned pool is created with jurors
      | court | juror_number   | pool_number   | att_date_weeks_in_future | owner |
      | 452   | <juror_number> | <pool_number> | 5                        | 400   |

    And juror "<juror_number>" has "LAST_NAME" as "<last_name>" new schema
    And juror "<juror_number>" has "POSTCODE" as "<postcode>" new schema

    Then I see "Reply to a jury summons" on the page

    And I set the radio button to "I am replying for myself"
    And I press the "Continue" button
    Then I see "Your juror details" on the page
	
	#Juror Log In
    When I set "9-digit juror number" to "<juror_number>"
    When I set "Juror last name" to "<last_name>"
    When I set "Juror postcode" to "<postcode>"
    And I press the "Continue" button
    Then I see "Is the name we have for you correct?" on the page
	
	#Check Name
    When I choose the "No" radio button
    And I press the "Continue" button
    Then I set "First name" to ""
    And I set "Last name" to ""
    And I press the "Continue" button
    Then I see "Enter your first name" on the page
    Then I see "Enter your last name" on the page
    When I set "First name" to "FirstNamea"
    And I set "Last name" to "LastNameb"
    And I press the "Continue" button
    Then I see "Is this your address?" on the page
    When I click on the "Back" link
    Then I see "FirstNamea" on the page
    And I see "LastNameb" on the page
    When I choose the "Yes" radio button
    When I press the "Continue" button
    Then I see "Is this your address?" on the page
	
	#Check Address
    When I choose the "No" radio button
    And I press the "Continue" button
    Then I set "Address line 1" to ""
    And I set "Town or city" to ""
    And I set "County (optional)" to ""
    And I set "Postcode" to ""
    And I press the "Continue" button

    Then I see "Provide the town or city you live in" on the page
    Then I see "Enter your postcode" on the page
    When I set "Address line 1" to "123 Street"
    And I set "Town or city" to "London"
    And I set "County (optional)" to "County"
    And I set "Postcode" to "CH1 2AN"
    And I press the "Continue" button
    Then I see "What is your phone number?" on the page
    When I click on the "Back" link
    Then I see "123 Street" on the page
    And I see "London" on the page
    And I see "CH1 2AN" on the page
    When I choose the "Yes" radio button
    And I press the "Continue" button
    Then I see "What is your phone number?" on the page
	
	#Phone Details
    When I press the "Continue" button
    Then I see "Enter your main phone number" on the page
    When I set "Main phone" to "0207 821 1818"
    And I press the "Continue" button
    Then I see "What is your email address?" on the page
    When I click on the "Back" link
    Then I see "What is your phone number?" on the page
    And I press the "Continue" button
    Then I see "What is your email address?" on the page
	
	#Email

    When I press the "Continue" button
    Then I see "Enter your email address" on the page

    When I set "Enter your email address" to "<email>"
    And I set "Enter your email address again" to "<email>"
    And I press the "Continue" button
    Then I see "What is your date of birth?" on the page
    When I click on the "Back" link
    Then I see "What is your email address?" on the page
    And I press the "Continue" button
    Then I see "What is your date of birth?" on the page
	
	#DoB
    When I press the "Continue" button
    Then I see "There is a problem" on the page
    When I set "Day" to "27"
    And I set "Month" to "04"
    And I set "Year" to "1981"
    And I press the "Continue" button
    Then I see "Confirm you're eligible for jury service" on the page
    When I click on the "Back" link
    Then I see "What is your date of birth?" on the page
    And I press the "Continue" button
    Then I see "Confirm you're eligible for jury service" on the page

    When I press the "Continue" button
	
	#Residency
    Then I see "Have you lived in the UK, Channel Islands or Isle of Man for more than five consecutive years, since your 13th birthday?" on the page
    When I press the "Continue" button
    Then I see "Select yes if your main address has been in the UK, Channel Islands or Isle of Man for any period of at least 5 years, since you turned 13" on the page
    When I choose the "No" radio button
    And I press the "Continue" button
    Then I see "Provide details about where you have lived since your 13th birthday" on the page
    When I choose the "Yes" radio button
    And I press the "Continue" button
    When I click on the "Back" link
    Then I see "Have you lived in the UK, Channel Islands or Isle of Man for more than five consecutive years, since your 13th birthday?" on the page
    And I press the "Continue" button
	
	#CJS
    When I choose the "No" radio button
    And I press the "Continue" button
	
	#bail
    Then I see "Are you currently on bail for a criminal offence?" on the page
    When I click on the "Back" link
    Then I see "Have you worked in the criminal justice system in the last 5 years?" on the page
    When I press the "Continue" button
    Then I see "Are you currently on bail for a criminal offence?" on the page
    When I choose the "No" radio button
    And I press the "Continue" button
    Then I see "Have you been found guilty of a criminal offence?" on the page
	
	#JDB-4552
    When I click on the "Guidance on jury service if you have a conviction" link

    And on the page I see
      | text                                                                                                                                                                                                                                                                                |
      | When you can do jury service                                                                                                                                                                                                                                                        |
      | You can do jury service if you've:                                                                                                                                                                                                                                                  |
      | had a speeding fine                                                                                                                                                                                                                                                                 |
      | had points on your driving license                                                                                                                                                                                                                                                  |
      | been told to attend a speed awareness course                                                                                                                                                                                                                                        |
      | This applies as long as you did not receive any of the sentences below.                                                                                                                                                                                                             |
      | When you cannot do jury service                                                                                                                                                                                                                                                     |
      | You cannot do jury service if you've ever had one of the criminal sentences below in the UK, Channel Islands or Isle of Man.                                                                                                                                                        |
      | You also cannot do jury service if you've had one of these criminal sentences for a service offence under the Armed Forces Act 2006 anywhere in the world:                                                                                                                          |
      | imprisonment or detention for 5 years or more                                                                                                                                                                                                                                       |
      | imprisonment for public protection or detention for public protection                                                                                                                                                                                                               |
      | imprisonment, custody or detention for life                                                                                                                                                                                                                                         |
      | an extended sentence under either of sections 226A, 226B, 227 or 228 of the Criminal Justice Act 2003, (including such a sentence imposed as a result of section 219A, 220, 221A or 222 of the Armed Forces Act 2006) or section 210A of the Criminal Procedure (Scotland) Act 1995 |
      | detention at His Majesty's pleasure or during the pleasure of the Secretary of State                                                                                                                                                                                                |
      | You also cannot do jury service if you've had one of these criminal sentences in the last 10 years:                                                                                                                                                                                 |
      | you served any part of a sentence of imprisonment or detention                                                                                                                                                                                                                      |
      | you received a suspended sentence of imprisonment or a suspended order for detention                                                                                                                                                                                                |
      | You also cannot do jury service if, in the last 10 years in England and Wales, you've had a community order, including any of the following:                                                                                                                                        |
      | community rehabilitation order                                                                                                                                                                                                                                                      |
      | community punishment order                                                                                                                                                                                                                                                          |
      | community punishment and rehabilitation order                                                                                                                                                                                                                                       |
      | drug treatment and testing order                                                                                                                                                                                                                                                    |
      | drug abstinence order                                                                                                                                                                                                                                                               |
      | You also cannot do jury service if, in the last 10 years, you've had:                                                                                                                                                                                                               |
      | any similar order under the law of Scotland, Northern Ireland, Isle of Man or any of the Channel Islands                                                                                                                                                                            |
      | a community or overseas community order under the Armed Forces Act 2006                                                                                                                                                                                                             |
      | If you serve on a jury when you know you should not because of a criminal conviction, you may be fined up to £5,000.                                                                                                                                                                |

    When I choose the "No" radio button
    And I press the "Continue" button
	
	#Mental Health part 1
    Then I see "Are you being detained, looked after or treated under the Mental Health Act?" on the page
    When I press the "Continue" button
    Then I see "Select yes if you're being detained, looked after or treated under the Mental Health Act" on the page
    When I choose the "Yes" radio button
    And I press the "Continue" button
    Then I see "Provide details about how you're being detained, looked after or treated under the Mental Health Act" on the page
    When I choose the "No" radio button
    And I press the "Continue" button
    Then I see "Has it been decided that you 'lack mental capacity'?" on the page
    When I click on the "Back" link
    Then I see "Are you being detained, looked after or treated under the Mental Health Act?" on the page
    When I press the "Continue" button
	
	#Mental Health part 2
    Then I see "Has it been decided that you 'lack mental capacity'?" on the page

    When I click on the "Need help answering this?" link
    Then on the page I see
      | text                                                                                                                              |
      | If someone lacks mental capacity, they cannot:                                                                                    |
      | make their own decisions                                                                                                          |
      | understand and retain information                                                                                                 |
      | communicate thoughts and decisions to others                                                                                      |
      | Some people are medically certified under the Mental Capacity Act as lacking in mental capacity because of an accident or injury. |
      | Someone else may then need to be appointed to make decisions on their behalf.                                                     |
      | If a person lacks mental capacity, they cannot do jury service.                                                                   |

    When I press the "Continue" button
    Then I see "Select yes if it's been decided that you 'lack mental capacity'" on the page
    When I choose the "Yes" radio button
    And I press the "Continue" button
    Then I see "Provide brief details about why it was decided you lack mental capacity" on the page
    When I choose the "No" radio button
    And I press the "Continue" button

    And I see "Yes, I can start on" on the page
    And I set the radio button to "Yes, I can start on"
    And I press the "Continue" button
    When I choose the "No" radio button
    And I press the "Continue" button

    Then I see "Are you being detained, looked after or treated under the Mental Health Act?" on the page
    And I see "Has it been decided that you 'lack mental capacity'?" on the page

    And I check the "The information I have given is true to the best of my knowledge" checkbox
    And I see "You may be convicted and fined up to £1000 if you give false information to evade jury service. This also applies if you fail to give us the information we need to decide if you’re eligible to do jury service." on the page

    And I press the "Submit" button
	
	#Confirmation
    Then I see "You have completed your reply" on the page
    And I see "Download a copy of your summons reply HTML" on the page
    And I click on the "Download a copy of your summons reply HTML" link

    And I see "Copy of your jury summons reply" on the page

    And I see "You answered the eligibility questions" on the page
    And I see "No" in the same row as "Are you being detained, looked after or treated under the Mental Health Act?"
    And I see "No" in the same row as "Has it been decided that you 'lack mental capacity'?"

    Examples:
      | juror_number | last_name          | postcode | email             | pool_number |
      | 045200060    | LNAMESEVENFOURFIVE | CH1 2AN  | email@outlook.com | 452300059   |

  @Regression
  Scenario Outline: Checking MH questions have been split in Bureau and no text MENTAL HEALTH Q2 is visible

    Given I am on "Public" "ithc"

    Given a bureau owned pool is created with jurors
      | court | juror_number   | pool_number   | att_date_weeks_in_future | owner |
      | 452   | <juror_number> | <pool_number> | 5                        | 400   |

    And juror "<juror_number>" has "LAST_NAME" as "<last_name>" new schema
    And juror "<juror_number>" has "POSTCODE" as "<postcode>" new schema

    Then I see "Reply to a jury summons" on the page

    And I set the radio button to "I am replying for myself"
    And I press the "Continue" button
    And I set "9-digit juror number" to "<juror_number>"
    And I set "Juror last name" to "<last_name>"
    And I set "Juror postcode" to "<postcode>"
    And I press the "Continue" button
    Then on the page I see
      | text                                 |
      | Your details                         |
      | Is the name we have for you correct? |

    And I choose the "Yes" radio button
    And I press the "Continue" button

    Then on the page I see
      | text                  |
      | Is this your address? |

    And I choose the "Yes" radio button
    And I press the "Continue" button

    Then on the page I see
      | text                                                                                                 |
      | Your details                                                                                         |
      | What is your phone number?                                                                           |
      | Please provide a UK phone number that we can use to reach you between 9am and 5pm, Monday to Friday. |
      | Main phone                                                                                           |
      | Another phone (optional)                                                                             |

    When I press the "Continue" button
    Then on the page I see
      | text                         |
      | There is a problem           |
      | Enter your main phone number |

    When I set "Main phone" to "02078211818"
    And I press the "Continue" button

    Then on the page I see
      | text                           |
      | Your details                   |
      | What is your email address?    |
      | Enter your email address       |
      | Enter your email address again |

    When I press the "Continue" button
    Then on the page I see
      | text                     |
      | Your details             |
      | Enter your email address |

    When I set "Enter your email address" to "<email>"
    And I press the "Continue" button
    Then I see "Enter your email address and check that it matches the one in the first field" on the page
    When I set "Enter your email address again" to "<email>"
    And I press the "Continue" button

    Then on the page I see
      | text                        |
      | Your details                |
      | What is your date of birth? |
      | For example, 15 03 1982     |
      | Help with date of birth     |

    When I set "Day" to "01"
    And I set "Month" to "01"
    And I set "Year" to "1990"
    And I press the "Continue" button
    Then I see "Confirm you're eligible for jury service" on the page

    When I press the "Continue" button
	
	#Residency
    Then I see "Have you lived in the UK, Channel Islands or Isle of Man for more than five consecutive years, since your 13th birthday?" on the page
    When I see "Eligibility" on the page
    And I choose the "Yes" radio button
    And I press the "Continue" button
	
	#CJS no
    Then I see "Have you worked in the criminal justice system in the last 5 years?" on the page
    When I choose the "No" radio button
    And I press the "Continue" button
	
	#Bail
    Then I see "Are you currently on bail for a criminal offence?" on the page
    When I see "Eligibility" on the page
    And I choose the "No" radio button
    And I press the "Continue" button
	
	#Convictions
    Then I see "Have you been found guilty of a criminal offence?" on the page
    When I see "Eligibility" on the page
    When I choose the "No" radio button
    And I press the "Continue" button
	
	#Mental Health Sectioned
    Then I see "Are you being detained, looked after or treated under the Mental Health Act?" on the page
    And on the page I see
      | text                                                                         |
      | Are you being detained, looked after or treated under the Mental Health Act? |
      | Only select yes if, under the Mental Health Act 1983, you're:                |
      | being detained (sectioned) or liable to be detained                          |
      | resident in a hospital due to a mental disorder                              |
      | subject to a guardianship or community treatment order                       |
      | Need help answering this?                                                    |

    And I click on the "Need help answering this?" link
    And on the page I see
      | text                                                                                                                                                                                |
      | You cannot be on a jury if any of these statements apply to you.                                                                                                                    |
      | If you have mental health issues (including depression and anxiety) but you’re not being detained, looked after or treated under the Mental Health Act, you can still be on a jury. |
      | (If you feel you cannot complete jury service because of significant mental health issues, you can still ask to be excused or change your dates.)                                   |

    When I see "Eligibility" on the page
    And I choose the "Yes" radio button
    And I set "Provide details" to "I am sectioned"
    And I press the "Continue" button
	
	#Mental Health Capacity
    Then I see "Has it been decided that you 'lack mental capacity'?" on the page
    And on the page I see
      | text                                                         |
      | Has it been decided that you 'lack mental capacity'?         |
      | This means, legally, you cannot make decisions for yourself. |

    And I click on the "Need help answering this?" link
    And on the page I see
      | text                                                                                                                              |
      | If someone lacks mental capacity, they cannot:                                                                                    |
      | make their own decisions                                                                                                          |
      | understand and retain information                                                                                                 |
      | communicate thoughts and decisions to others                                                                                      |
      | Some people are medically certified under the Mental Capacity Act as lacking in mental capacity because of an accident or injury. |
      | Someone else may then need to be appointed to make decisions on their behalf.                                                     |
      | If a person lacks mental capacity, they cannot do jury service.                                                                   |

    When I see "Eligibility" on the page
    And I choose the "Yes" radio button
    And I set "Provide brief details about why it was decided you lack mental capacity" to "I lack capacity"
    And I press the "Continue" button
	
	#I can attend
    Then I see "Check your start date" on the page
    And I see "Yes, I can start on" on the page
    And I set the radio button to "Yes, I can start on"
    And  I press the "Continue" button
	
	#RA no
    Then I see "Will you need help when you're at the court?" on the page
    When I choose the "No" radio button
    And I press the "Continue" button
	
	#Check your answers
    Then I see "Check your answers now" on the page
    And I see text "Yes" in the same row as "Are you being detained, looked after or treated under the Mental Health Act?"
    And I see text "Yes" in the same row as "Has it been decided that you 'lack mental capacity'?"
    And I check the "The information I have given is true to the best of my knowledge" checkbox
    And I press the "Submit" button
	
	#Confirmation
    Then I see "You have completed your reply" on the page
    And I see "Download a copy of your summons reply HTML" on the page
    And I click on the "Download a copy of your summons reply HTML" link

    And I see "Copy of your jury summons reply" on the page
    And I see "<last_name>" in the same row as "Name"
    And I see "<juror_number>" in the same row as "Juror number"

    And I see "You answered the eligibility questions" on the page
    And I see "Yes" in the same row as "Are you being detained, looked after or treated under the Mental Health Act?"
    And I see "Yes" in the same row as "Has it been decided that you 'lack mental capacity'?"

    Then I press the "back" button on my browser
    Then I see "You have completed your reply" on the page
    And I see "Download a copy of your summons reply HTML" on the page
	
	#Bureau
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

    And I click on "<juror_number>" in the same row as "<juror_number>"

    When I click on the "Eligibility" link
    Then "Mental health act" is marked as requiring attention
    And I see "I am sectioned" on the page
    And I see "I lack capacity" on the page
    And I do not see "[MENTAL HEALTH Q2]" on the page

    Examples:
      | juror_number | last_name         | postcode | email      | pool_number |
      | 045200061    | LNAMESIXSEVENNINE | CH1 2AN  | a@eeee.com | 452300060   |