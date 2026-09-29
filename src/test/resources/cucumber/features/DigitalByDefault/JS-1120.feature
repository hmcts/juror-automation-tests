Feature: JS-1120 DBD Survey link

  @JurorTransformation
  Scenario Outline: DBD Survey Link Visible on all screens for a digital response

    Given I am on "Public" "ithc"

    Given a bureau owned pool is created with jurors
      | court |juror_number  | pool_number	| att_date_weeks_in_future	| owner |
      | 431   |<juror_number>| <pool_number>	| 5				        | 400	|

    And juror "<juror_number>" has "LAST_NAME" as "<last_name>" new schema
    And juror "<juror_number>" has "POSTCODE" as "<postcode>" new schema
    And I update "<juror_number>" to set them up for digital by default

    Then I see "Reply to a jury summons" on the page

    And I set the radio button to "I am replying for myself"
    And I press the "Continue" button
    Then I see "Your juror details" on the page

	#Juror Log In
    When I set "9-digit juror number" to "<juror_number>"
    When I set "Juror last name" to "<last_name>"
    When I set "Juror postcode" to "<postcode>"
    And I press the "Continue" button

    #DBD landing screen
    And I see link with text "Give feedback (opens in a new window or tab)"
    When I click on the "Give feedback (opens in a new window or tab)" link
    And I focus page to the new tab
    Then I see "Juror_Digital_Survey/" in the URL
    And I see "Jurors Digital Pilot Survey" on the page
    And I focus page to the original tab

    #when and where to attend
    When I click on the "When and where to attend" link
    Then I see "Your start date, court address, arrival time and security information." on the page
    And I see link with text "Give feedback (opens in a new window or tab)"
    When I click on the "Give feedback (opens in a new window or tab)" link
    And I focus page to the new tab
    Then I see "Juror_Digital_Survey/" in the URL
    And I see "Jurors Digital Pilot Survey" on the page
    And I focus page to the original tab
    And I click on the "Back" link

    #how jury service works
    When I click on the "How jury service works" link
    Then I see "What jury service is and who can be called" on the page
    And I see link with text "Give feedback (opens in a new window or tab)"
    When I click on the "Give feedback (opens in a new window or tab)" link
    And I focus page to the new tab
    Then I see "Juror_Digital_Survey/" in the URL
    And I see "Jurors Digital Pilot Survey" on the page
    And I focus page to the original tab
    And I click on the "Back" link

    #support and accessibility
    When I click on the "Support and accessibility" link
    Then I see "Support and accessibility" on the page
    And I see link with text "Give feedback (opens in a new window or tab)"
    When I click on the "Give feedback (opens in a new window or tab)" link
    And I focus page to the new tab
    Then I see "Juror_Digital_Survey/" in the URL
    And I see "Jurors Digital Pilot Survey" on the page
    And I focus page to the original tab
    And I click on the "Back" link

    #employment and time off
    When I click on the "Employment and time off work" link
    Then I see "Employment and time off work" on the page
    And I see link with text "Give feedback (opens in a new window or tab)"
    When I click on the "Give feedback (opens in a new window or tab)" link
    And I focus page to the new tab
    Then I see "Juror_Digital_Survey/" in the URL
    And I see "Jurors Digital Pilot Survey" on the page
    And I focus page to the original tab
    And I click on the "Back" link

    #claiming expenses
    When I click on the "Claiming expenses" link
    Then I see "You do not get paid for doing jury service but you can claim some money back towards loss of earnings, childcare, travel, and food and drink costs." on the page
    And I see link with text "Give feedback (opens in a new window or tab)"
    When I click on the "Give feedback (opens in a new window or tab)" link
    And I focus page to the new tab
    Then I see "Juror_Digital_Survey/" in the URL
    And I see "Jurors Digital Pilot Survey" on the page
    And I focus page to the original tab
    And I click on the "Back" link

    #ask to change your dates or be excused
    When I click on the "Asking to change your dates or be excused" link
    And I see "When you respond to your summons, you can ask to change your dates or to be excused from your jury service." on the page
    And I see link with text "Give feedback (opens in a new window or tab)"
    When I click on the "Give feedback (opens in a new window or tab)" link
    And I focus page to the new tab
    Then I see "Juror_Digital_Survey/" in the URL
    And I see "Jurors Digital Pilot Survey" on the page
    And I focus page to the original tab
    And I click on the "Back" link

    #eligibility
    When I click on the "Juror eligibility" link
    And I see "Who is eligible to serve on a jury?" on the page
    And I see link with text "Give feedback (opens in a new window or tab)"
    When I click on the "Give feedback (opens in a new window or tab)" link
    And I focus page to the new tab
    Then I see "Juror_Digital_Survey/" in the URL
    And I see "Jurors Digital Pilot Survey" on the page
    And I focus page to the original tab
    And I click on the "Back" link
    
    #Start response
    When I press the start your response button
    Then I see "Is the name we have for you correct?" on the page
    And I see link with text "Give feedback (opens in a new window or tab)"
    When I click on the "Give feedback (opens in a new window or tab)" link
    And I focus page to the new tab
    Then I see "Juror_Digital_Survey/" in the URL
    And I see "Jurors Digital Pilot Survey" on the page
    And I focus page to the original tab
    When I choose the "Yes" radio button

	#Check name
    When I press the "Continue" button
    Then I see "Is this your address?" on the page
    And I see link with text "Give feedback (opens in a new window or tab)"
    When I click on the "Give feedback (opens in a new window or tab)" link
    And I focus page to the new tab
    Then I see "Juror_Digital_Survey/" in the URL
    And I see "Jurors Digital Pilot Survey" on the page
    And I focus page to the original tab
    When I choose the "Yes" radio button

	#Check address
    When I press the "Continue" button
    Then I see "What is your phone number?" on the page
    And I see link with text "Give feedback (opens in a new window or tab)"
    When I click on the "Give feedback (opens in a new window or tab)" link
    And I focus page to the new tab
    Then I see "Juror_Digital_Survey/" in the URL
    And I see "Jurors Digital Pilot Survey" on the page
    And I focus page to the original tab

	#Phone details
    When I set "Main phone" to "0207 821 1818"
    And I press the "Continue" button


    Then I see "What is your email address?" on the page
    And I see link with text "Give feedback (opens in a new window or tab)"
    When I click on the "Give feedback (opens in a new window or tab)" link
    And I focus page to the new tab
    Then I see "Juror_Digital_Survey/" in the URL
    And I see "Jurors Digital Pilot Survey" on the page
    And I focus page to the original tab

	#Email details
    When I set "Enter your email address" to "<email>"
    And I set "Enter your email address again" to "<email>"
    And I press the "Continue" button

	#DoB
    Then I see "What is your date of birth?" on the page
    And I see link with text "Give feedback (opens in a new window or tab)"
    When I click on the "Give feedback (opens in a new window or tab)" link
    And I focus page to the new tab
    Then I see "Juror_Digital_Survey/" in the URL
    And I see "Jurors Digital Pilot Survey" on the page
    And I focus page to the original tab

    When I set "Day" to "27"
    And I set "Month" to "04"
    And I set "Year" to "1981"
    And I press the "Continue" button

    Then I see "Confirm you're eligible for jury service" on the page
    And I see link with text "Give feedback (opens in a new window or tab)"
    When I click on the "Give feedback (opens in a new window or tab)" link
    And I focus page to the new tab
    Then I see "Juror_Digital_Survey/" in the URL
    And I see "Jurors Digital Pilot Survey" on the page
    And I focus page to the original tab

    When I press the "Continue" button
    Then I see "Have you lived in the UK, Channel Islands or Isle of Man for more than five consecutive years, since your 13th birthday?" on the page
    And I see link with text "Give feedback (opens in a new window or tab)"
    When I click on the "Give feedback (opens in a new window or tab)" link
    And I focus page to the new tab
    Then I see "Juror_Digital_Survey/" in the URL
    And I see "Jurors Digital Pilot Survey" on the page
    And I focus page to the original tab

	#Residency Yes
    When I choose the "Yes" radio button
    And I press the "Continue" button

	#CJS no
    Then I see "Have you worked in the criminal justice system in the last 5 years?" on the page
    And I see link with text "Give feedback (opens in a new window or tab)"
    When I click on the "Give feedback (opens in a new window or tab)" link
    And I focus page to the new tab
    Then I see "Juror_Digital_Survey/" in the URL
    And I see "Jurors Digital Pilot Survey" on the page
    And I focus page to the original tab

    When I choose the "No" radio button
    And I press the "Continue" button

	#Bail no
    Then I see "Are you currently on bail for a criminal offence?" on the page
    And I see link with text "Give feedback (opens in a new window or tab)"
    When I click on the "Give feedback (opens in a new window or tab)" link
    And I focus page to the new tab
    Then I see "Juror_Digital_Survey/" in the URL
    And I see "Jurors Digital Pilot Survey" on the page
    And I focus page to the original tab

    When I choose the "No" radio button
    And I press the "Continue" button

	#Convictions no
    Then I see "Have you been found guilty of a criminal offence?" on the page
    And I see link with text "Give feedback (opens in a new window or tab)"
    When I click on the "Give feedback (opens in a new window or tab)" link
    And I focus page to the new tab
    Then I see "Juror_Digital_Survey/" in the URL
    And I see "Jurors Digital Pilot Survey" on the page
    And I focus page to the original tab

    When I choose the "No" radio button
    And I press the "Continue" button

	#Mental health part 1 no
    Then I see "Are you being detained, looked after or treated under the Mental Health Act?" on the page
    And I see link with text "Give feedback (opens in a new window or tab)"
    When I click on the "Give feedback (opens in a new window or tab)" link
    And I focus page to the new tab
    Then I see "Juror_Digital_Survey/" in the URL
    And I see "Jurors Digital Pilot Survey" on the page
    And I focus page to the original tab

    When I choose the "No" radio button
    And I press the "Continue" button

	#Mental health part 2 no
    Then I see "Has it been decided that you 'lack mental capacity'?" on the page
    And I see link with text "Give feedback (opens in a new window or tab)"
    When I click on the "Give feedback (opens in a new window or tab)" link
    And I focus page to the new tab
    Then I see "Juror_Digital_Survey/" in the URL
    And I see "Jurors Digital Pilot Survey" on the page
    And I focus page to the original tab

    When I choose the "No" radio button
    And I press the "Continue" button

	#I can attend
    Then I see "Check your start date" on the page
    And I see "Yes, I can start on" on the page
    And I see link with text "Give feedback (opens in a new window or tab)"
    When I click on the "Give feedback (opens in a new window or tab)" link
    And I focus page to the new tab
    Then I see "Juror_Digital_Survey/" in the URL
    And I see "Jurors Digital Pilot Survey" on the page
    And I focus page to the original tab

    And I set the radio button to "Yes, I can start on"
    And  I press the "Continue" button

	#RA no
    Then I see "Will you need help when you're at the court?" on the page
    And I see link with text "Give feedback (opens in a new window or tab)"
    When I click on the "Give feedback (opens in a new window or tab)" link
    And I focus page to the new tab
    Then I see "Juror_Digital_Survey/" in the URL
    And I see "Jurors Digital Pilot Survey" on the page
    And I focus page to the original tab

    When I choose the "No" radio button
    And I press the "Continue" button
    Then I see "Check your answers now" on the page
    And I see link with text "Give feedback (opens in a new window or tab)"
    When I click on the "Give feedback (opens in a new window or tab)" link
    And I focus page to the new tab
    Then I see "Juror_Digital_Survey/" in the URL
    And I see "Jurors Digital Pilot Survey" on the page
    And I focus page to the original tab

	#Check your answers
    When I check the "The information I have given is true to the best of my knowledge" checkbox
    And I press the "Submit" button

	#When I press the "Submit" button
    Then I see "We have sent you an email to say you have replied to your jury summons." on the page
    And I see link with text "Give feedback (opens in a new window or tab)"
    When I click on the "Give feedback (opens in a new window or tab)" link
    And I focus page to the new tab
    Then I see "Juror_Digital_Survey/" in the URL
    And I see "Jurors Digital Pilot Survey" on the page
    And I focus page to the original tab

    Examples:
      | juror_number	| last_name			| postcode	| email           	| pool_number	|
      | 043100181		| LNAMETWOSIXZERO	| BN7 1AA	| email@outlook.com	| 431300166		|