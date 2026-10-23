Feature: JS-1120 DBD Survey link

  @JurorTransformation
  Scenario Outline: DBD Survey Link Visible on all screens for a digital response

    Given I am on "Public" "demo"

    Given a bureau owned pool is created with jurors
      | court |juror_number  | pool_number	| att_date_weeks_in_future	| owner |
      | 431   |<juror_number>| <pool_number>	| 1				        | 400	|

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

    #Confirmation page
    Then I see "Tell us about your experience" on the page
    And I see "Help us understand how easy or difficult you found replying to your jury summons online. Your feedback will be kept confidential and help us make replying easier for everyone." on the page
    And I see "The survey takes around 5 minutes to complete." on the page
    And I see link with text "Take the survey"
    When I click on the "Take the survey" link
    And I focus page to the new tab
    Then I see "Juror_Digital_Survey/" in the URL
    And I see "Jurors Digital Pilot Survey" on the page

    Examples:
      | juror_number	| last_name			| postcode	| email           	| pool_number	|
      | 043100181		| LNAMETWOSIXZERO	| BN7 1AA	| email@outlook.com	| 431300166		|

  @JurorTransformation
  Scenario Outline: Welsh DBD Survey Link Visible on all screens for a digital response

    Given I am on the welsh version of "Public" "ithc"

    Given a bureau owned pool is created with jurors
      | court |juror_number  | pool_number	| att_date_weeks_in_future	| owner |
      | 411   |<juror_number>| <pool_number>| 5				            | 400	|

    And juror "<juror_number>" has "LAST_NAME" as "<last_name>" new schema
    And juror "<juror_number>" has "POSTCODE" as "<postcode>" new schema
    And I update "<juror_number>" to set them up for digital by default

#    Then I see "Beth ddylwn ei wneud os oes angen cymorth arnaf i ymateb?" on the page

    And I set the radio button to "n ymateb dros fy hun"
    And I press the "Parhau" button
    Then I see "Eich manylion rheithiwr" on the page

	#Juror Log In
    When I set "Rhif rheithiwr" to "<juror_number>"
    When I set "Cyfenw" to "<last_name>"
    When I set "Cod post Rheithiwr" to "<postcode>"
    And I press the "Parhau" button

    #welsh translation not yet available
#    #DBD landing screen
#    And I see link with text "Give feedback (opens in a new window or tab)"
#    When I click on the "Give feedback (opens in a new window or tab)" link
#    And I focus page to the new tab
#    Then I see "Juror_Digital_Survey/" in the URL
#    And I see "Jurors Digital Pilot Survey" on the page
#    And I focus page to the original tab
#
#    #when and where to attend
#    When I click on the "When and where to attend" link
#    Then I see "Your start date, court address, arrival time and security information." on the page
#    And I see link with text "Give feedback (opens in a new window or tab)"
#    When I click on the "Give feedback (opens in a new window or tab)" link
#    And I focus page to the new tab
#    Then I see "Juror_Digital_Survey/" in the URL
#    And I see "Jurors Digital Pilot Survey" on the page
#    And I focus page to the original tab
#    And I click on the "Back" link
#
#    #how jury service works
#    When I click on the "How jury service works" link
#    Then I see "What jury service is and who can be called" on the page
#    And I see link with text "Give feedback (opens in a new window or tab)"
#    When I click on the "Give feedback (opens in a new window or tab)" link
#    And I focus page to the new tab
#    Then I see "Juror_Digital_Survey/" in the URL
#    And I see "Jurors Digital Pilot Survey" on the page
#    And I focus page to the original tab
#    And I click on the "Back" link
#
#    #support and accessibility
#    When I click on the "Support and accessibility" link
#    Then I see "Support and accessibility" on the page
#    And I see link with text "Give feedback (opens in a new window or tab)"
#    When I click on the "Give feedback (opens in a new window or tab)" link
#    And I focus page to the new tab
#    Then I see "Juror_Digital_Survey/" in the URL
#    And I see "Jurors Digital Pilot Survey" on the page
#    And I focus page to the original tab
#    And I click on the "Back" link
#
#    #employment and time off
#    When I click on the "Employment and time off work" link
#    Then I see "Employment and time off work" on the page
#    And I see link with text "Give feedback (opens in a new window or tab)"
#    When I click on the "Give feedback (opens in a new window or tab)" link
#    And I focus page to the new tab
#    Then I see "Juror_Digital_Survey/" in the URL
#    And I see "Jurors Digital Pilot Survey" on the page
#    And I focus page to the original tab
#    And I click on the "Back" link
#
#    #claiming expenses
#    When I click on the "Claiming expenses" link
#    Then I see "You do not get paid for doing jury service but you can claim some money back towards loss of earnings, childcare, travel, and food and drink costs." on the page
#    And I see link with text "Give feedback (opens in a new window or tab)"
#    When I click on the "Give feedback (opens in a new window or tab)" link
#    And I focus page to the new tab
#    Then I see "Juror_Digital_Survey/" in the URL
#    And I see "Jurors Digital Pilot Survey" on the page
#    And I focus page to the original tab
#    And I click on the "Back" link
#
#    #ask to change your dates or be excused
#    When I click on the "Asking to change your dates or be excused" link
#    And I see "When you respond to your summons, you can ask to change your dates or to be excused from your jury service." on the page
#    And I see link with text "Give feedback (opens in a new window or tab)"
#    When I click on the "Give feedback (opens in a new window or tab)" link
#    And I focus page to the new tab
#    Then I see "Juror_Digital_Survey/" in the URL
#    And I see "Jurors Digital Pilot Survey" on the page
#    And I focus page to the original tab
#    And I click on the "Back" link
#
#    #eligibility
#    When I click on the "Juror eligibility" link
#    And I see "Who is eligible to serve on a jury?" on the page
#    And I see link with text "Give feedback (opens in a new window or tab)"
#    When I click on the "Give feedback (opens in a new window or tab)" link
#    And I focus page to the new tab
#    Then I see "Juror_Digital_Survey/" in the URL
#    And I see "Jurors Digital Pilot Survey" on the page
#    And I focus page to the original tab
#    And I click on the "Back" link
#
    #Start response - check name
    When I press the start your response button
    Then I see "A yw'r enw sydd gennym ar eich cyfer chi yn gywir?" on the page
    And I see link with text "Give feedback (opens in a new window or tab)"
    When I click on the "Give feedback (opens in a new window or tab)" link
    And I focus page to the new tab
    Then I see "Juror_Digital_Survey/" in the URL
    And I see "Jurors Digital Pilot Survey" on the page
    And I focus page to the original tab
    When I choose the "Ydy" radio button

	#Check address
    When I press the "Parhau" button
    Then I see "Eich cyfeiriad chi yw hwn?" on the page
    And I see link with text "Give feedback (opens in a new window or tab)"
    When I click on the "Give feedback (opens in a new window or tab)" link
    And I focus page to the new tab
    Then I see "Juror_Digital_Survey/" in the URL
    And I see "Jurors Digital Pilot Survey" on the page
    And I focus page to the original tab
    When I choose the "Ie" radio button

	#Check phone
    When I press the "Parhau" button
    Then I see "Beth yw eich rhif ffôn?" on the page
    And I see link with text "Give feedback (opens in a new window or tab)"
    When I click on the "Give feedback (opens in a new window or tab)" link
    And I focus page to the new tab
    Then I see "Juror_Digital_Survey/" in the URL
    And I see "Jurors Digital Pilot Survey" on the page
    And I focus page to the original tab

	#Phone details
    When I set "Prif rif ffôn" to "0207 821 1818"
    And I press the "Parhau" button

    #email
    Then I see "Beth yw eich cyfeiriad e-bost?" on the page
    And I see link with text "Give feedback (opens in a new window or tab)"
    When I click on the "Give feedback (opens in a new window or tab)" link
    And I focus page to the new tab
    Then I see "Juror_Digital_Survey/" in the URL
    And I see "Jurors Digital Pilot Survey" on the page
    And I focus page to the original tab

	#Email details
    When I set "Nodwch eich cyfeiriad e-bost" to "<email>"
    And I set "Nodwch eich cyfeiriad e-bost eto" to "<email>"
    And I press the "Parhau" button

	#DoB
    Then I see "Beth yw eich dyddiad geni?" on the page
    And I see link with text "Give feedback (opens in a new window or tab)"
    When I click on the "Give feedback (opens in a new window or tab)" link
    And I focus page to the new tab
    Then I see "Juror_Digital_Survey/" in the URL
    And I see "Jurors Digital Pilot Survey" on the page
    And I focus page to the original tab

    When I set "Diwrnod" to "27"
    And I set "Mis" to "04"
    And I set "Blwyddyn" to "1981"
    And I press the "Parhau" button

    Then I see "Cadarnhau a ydych yn gymwys i wasanaethu ar reithgor" on the page
    And I see link with text "Give feedback (opens in a new window or tab)"
    When I click on the "Give feedback (opens in a new window or tab)" link
    And I focus page to the new tab
    Then I see "Juror_Digital_Survey/" in the URL
    And I see "Jurors Digital Pilot Survey" on the page
    And I focus page to the original tab

    When I press the "Parhau" button
    Then I see "A ydych chi wedi byw yn y Deyrnas Unedig, Ynysoedd y Sianel neu Ynys Manaw am gyfnod parhaus o bum mlynedd neu fwy ers eich pen-blwydd yn 13 oed?" on the page
    And I see link with text "Give feedback (opens in a new window or tab)"
    When I click on the "Give feedback (opens in a new window or tab)" link
    And I focus page to the new tab
    Then I see "Juror_Digital_Survey/" in the URL
    And I see "Jurors Digital Pilot Survey" on the page
    And I focus page to the original tab

	#Residency Yes
    When I choose the "Do" radio button
    And I press the "Parhau" button

	#CJS no
    Then I see "A ydych chi wedi gweithio yn y system cyfiawnder troseddol yn y 5 mlynedd diwethaf?" on the page
    And I see link with text "Give feedback (opens in a new window or tab)"
    When I click on the "Give feedback (opens in a new window or tab)" link
    And I focus page to the new tab
    Then I see "Juror_Digital_Survey/" in the URL
    And I see "Jurors Digital Pilot Survey" on the page
    And I focus page to the original tab

    When I choose the "Nac ydw" radio button
    And I press the "Parhau" button

	#Bail no
    Then I see "Ydych chi ar fechnïaeth ar hyn o bryd am gyflawni trosedd?" on the page
    And I see link with text "Give feedback (opens in a new window or tab)"
    When I click on the "Give feedback (opens in a new window or tab)" link
    And I focus page to the new tab
    Then I see "Juror_Digital_Survey/" in the URL
    And I see "Jurors Digital Pilot Survey" on the page
    And I focus page to the original tab

    When I choose the "Nac ydw" radio button
    And I press the "Parhau" button

	#Convictions no
    Then I see "Ydych chi wedi'ch cael yn euog o drosedd?" on the page
    And I see link with text "Give feedback (opens in a new window or tab)"
    When I click on the "Give feedback (opens in a new window or tab)" link
    And I focus page to the new tab
    Then I see "Juror_Digital_Survey/" in the URL
    And I see "Jurors Digital Pilot Survey" on the page
    And I focus page to the original tab

    When I choose the "Naddo" radio button
    And I press the "Parhau" button

	#Mental health part 1 no
    Then I see "Ydych chi'n cael eich cadw, yn cael eich gwarchod neu eich trin o dan y Ddeddf Galluedd Meddyliol?" on the page
    And I see link with text "Give feedback (opens in a new window or tab)"
    When I click on the "Give feedback (opens in a new window or tab)" link
    And I focus page to the new tab
    Then I see "Juror_Digital_Survey/" in the URL
    And I see "Jurors Digital Pilot Survey" on the page
    And I focus page to the original tab

    When I choose the "Na" radio button
    And I press the "Parhau" button

	#Mental health part 2 no
    Then I see "A benderfynwyd nad oes gennych y gallu meddyliol?" on the page
    And I see link with text "Give feedback (opens in a new window or tab)"
    When I click on the "Give feedback (opens in a new window or tab)" link
    And I focus page to the new tab
    Then I see "Juror_Digital_Survey/" in the URL
    And I see "Jurors Digital Pilot Survey" on the page
    And I focus page to the original tab

    When I choose the "Na" radio button
    And I press the "Parhau" button

	#I can attend
    Then I see "Gwiriwch eich dyddiad dechrau" on the page
    And I see link with text "Give feedback (opens in a new window or tab)"
    When I click on the "Give feedback (opens in a new window or tab)" link
    And I focus page to the new tab
    Then I see "Juror_Digital_Survey/" in the URL
    And I see "Jurors Digital Pilot Survey" on the page
    And I focus page to the original tab

    And I set the radio button to "Ydw,"
    And  I press the "Parhau" button

	#RA no
    Then I see "A fyddech chi angen cymorth pan fyddwch yn y llys?" on the page
    And I see link with text "Give feedback (opens in a new window or tab)"
    When I click on the "Give feedback (opens in a new window or tab)" link
    And I focus page to the new tab
    Then I see "Juror_Digital_Survey/" in the URL
    And I see "Jurors Digital Pilot Survey" on the page
    And I focus page to the original tab

    When I choose the "Nac oes" radio button
    And I press the "Parhau" button
    Then I see "Gwiriwch eich ymatebion nawr" on the page
    And I see link with text "Give feedback (opens in a new window or tab)"
    When I click on the "Give feedback (opens in a new window or tab)" link
    And I focus page to the new tab
    Then I see "Juror_Digital_Survey/" in the URL
    And I see "Jurors Digital Pilot Survey" on the page
    And I focus page to the original tab

	#Check your answers
    When I check the "Mae'r wybodaeth a roddais uchod yn wir hyd eithaf fy ngwybodaeth." checkbox
    And I press the "Cyflwyno" button

	#When I press the "Submit" button
    Then I see "O leiaf 2 wythnos cyn ichi ddechrau gwasanaethu ar reithgor, byddwn yn anfon y canlynol atoch:" on the page
    And I see link with text "Give feedback (opens in a new window or tab)"
    When I click on the "Give feedback (opens in a new window or tab)" link
    And I focus page to the new tab
    Then I see "Juror_Digital_Survey/" in the URL
    And I see "Jurors Digital Pilot Survey" on the page
    And I focus page to the original tab

    #Confirmation page
    Then I see "Dywedwch wrthym am eich profiad" on the page
    And I see "Helpwch ni i ddeall pa mor hawdd neu anodd oedd ymateb i'ch gwŷs rheithgor ar-lein." on the page
    And I see "Cedwir eich adborth yn gyfrinachol a bydd yn ein helpu i'w gwneud yn haws ymateb i bawb." on the page
    And I see "Mae'r arolwg yn cymryd tua 5 munud i'w gwblhau." on the page
    And I see link with text "Cwblhewch yr arolwg"
    When I click on the "Cwblhewch yr arolwg" link
    And I focus page to the new tab
    Then I see "Juror_Digital_Survey/" in the URL
    And I see "Jurors Digital Pilot Survey" on the page

    Examples:
      | juror_number	| last_name			| postcode	| email           	| pool_number	|
      | 041100181		| LNAMETWOSIXZERO	| BN7 1AA	| email@outlook.com	| 411300166		|