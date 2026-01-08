Feature: Regression Accessibility Statement

@Regression
Scenario: English Accessibility Statement
	
	Given I am on "Public" "ithc"

  	#Accessibility Statement
   	And I click on the "Accessibility statement" link
   	And I switch to the new window

   	And I see "Accessibility statement for Reply to a jury summons" on the page
   	And I see "This accessibility statement applies to the Reply to a jury summons service at" on the page
   	And I click on the "https://www.gov.uk/reply-jury-summons" link
   	And I see "reply-jury-summons" in the URL
   	Then I press the "back" button on my browser
   
   	And I see "This website is run by HM Courts and Tribunals Service (HMCTS). We want as many people as possible to be able to use this website. For example, that means you should be able to:" on the page
   	And I see "change colours, contrast levels and fonts" on the page
   	And I see "zoom in up to 300% without the text spilling off the screen" on the page
   	And I see "navigate most of the website using just a keyboard" on the page
   	And I see "navigate most of the website using speech recognition software" on the page
   	And I see "listen to most of the website using a screen reader (including the most recent versions of JAWS, NVDA and VoiceOver)" on the page
   	And I see "We’ve also made the website text as simple as possible to understand." on the page
   	And I see "has advice on making your device easier to use if you have a disability." on the page
   	And I click on the "AbilityNet" link
   	And I see "abilitynet.org.uk" in the URL
   	Then I press the "back" button on my browser
   
   	Then I see "How accessible this website is" on the page
   	And I see "This website has been independently audited for accessibility and we are not aware of any parts of this website that are not fully accessible." on the page
   	And I see "Reporting accessibility problems with this website" on the page
  	Then I see "We’re always looking to improve the accessibility of this website. If you find any problems not listed on this page or think we’re not meeting accessibility requirements:" on the page
   
   	Then I see "email jurysummoning@justice.gov.uk" on the page
   	Then I see "call 0300 456 1024" on the page
   	Then I see "or write to us at:" on the page
   	Then I see "Jury Central Summoning Bureau" on the page
   	Then I see "Phoenix House" on the page
   	Then I see "Rushton Avenue" on the page
   	Then I see "Bradford" on the page
   	Then I see "BD3 7BH" on the page
   
   	Then I see "Enforcement procedure" on the page
   	Then I see "The Equality and Human Rights Commission (EHRC) is responsible for enforcing the Public Sector Bodies (Websites and Mobile Applications) (No. 2) Accessibility Regulations 2018 (the ‘accessibility regulations’). If you’re not happy with how we respond to your complaint," on the page
   	And I click on the "contact the Equality Advisory and Support Service (EASS)" link
   	And I see "equalityadvisoryservice" in the URL
   	Then I press the "back" button on my browser
   
   	Then I see "Contacting us by email or phone" on the page
   	And I see "You can contact our customer service team at the Jury Central Summoning Bureau:" on the page
   	And I see "email jurysummoning@justice.gov.uk" on the page
   	And I see "call 0300 456 1024" on the page
   
   	Then I see "Technical information about this website’s accessibility" on the page
   	Then I see "HMCTS is committed to making its website accessible, in accordance with the Public Sector Bodies (Websites and Mobile Applications) (No. 2) Accessibility Regulations 2018." on the page
   
   	Then I see "Compliance status" on the page
   	Then I see "This website is fully compliant with the Web Content Accessibility Guidelines version 2.2 AA standard." on the page
   	And I click on the "Web Content Accessibility Guidelines version 2.2" link
   	And I see "wcag" in the URL
   	Then I press the "back" button on my browser
   
   	And I see "Preparation of this accessibility statement" on the page
   	And I see "This statement was prepared on 27 August 2020. It was last reviewed on 17 December 2025." on the page
   	And I see "This website was last tested on 15 December 2025. The test was carried out by Digital Accessibility Centre Ltd." on the page
   
   	#Then I see "You can read the full accessibility test report." on the page
   	#And I click on the "read the full accessibility test report" link
   	#And I see "accessibility-statement/report" in the URL
   	#Then I press the "back" button on my browser
   	
   	And I see "If you require a copy of the full accessibility test report please contact Andrew Singleton Bisby." on the page

@Regression
Scenario Outline: English 1st Party - Accessibility Statement on each page

	Given I am on "Public" "ithc"

	Given a bureau owned pool is created with jurors
		| court |juror_number  		| pool_number	| att_date_weeks_in_future	| owner |
		| 415 	|<juror_number> 	| <pool_number> | 5				            | 400	|

	And juror "<juror_number>" has "LAST_NAME" as "<last_name>" new schema
	And juror "<juror_number>" has "FIRST_NAME" as "FNAMESEVENONETHREE" new schema
	And juror "<juror_number>" has "ADDRESS_LINE_1" as "855 STREET NAME" new schema
	And juror "<juror_number>" has "ADDRESS_LINE_4" as "LONDON" new schema
	And juror "<juror_number>" has "POSTCODE" as "<postcode>" new schema
	
	Then I see "Reply to a jury summons" on the page
	And I see link with text "Accessibility statement"
	
	And I set the radio button to "I am replying for myself"
	And I press the "Continue" button
	Then I see "Your juror details" on the page
	And I see link with text "Accessibility statement"
	
	When I set "9-digit juror number" to "<juror_number>"
	When I set "Juror last name" to "<last_name>"
	When I set "Juror postcode" to "<postcode>"
	And I press the "Continue" button
	
	Then I see "Is the name we have for you correct?" on the page
	Then I see "LNAMESEVENONETHREE" on the page
	Then I see "FNAMESEVENONETHREE" on the page
	And I see link with text "Accessibility statement"
	And I choose the "No" radio button
	And I press the "Continue" button
	And I see link with text "Accessibility statement"
	When I set "First name" to "FIRSTNAMECHANGED"
	When I set "Last name" to "LASTNAMECHANGED"
	
	When I press the "Continue" button
	Then I see "855 STREET NAME" on the page
	Then I see "LONDON" on the page
	Then I see "<postcode>" on the page
	And I see link with text "Accessibility statement"
	
	And I choose the "No" radio button
	And I press the "Continue" button
	And I see link with text "Accessibility statement"
	When I set "Address line 1" to "123 STREET NAME"
	And I press the "Continue" button
	Then I see "What is your phone number?" on the page
	And I see link with text "Accessibility statement"
	
	When I press the "Continue" button
	Then I see "Enter your main phone number" on the page
	When I set "Main phone" to "02078211818"
	And I press the "Continue" button
	Then I see "What is your email address?" on the page
	And I see link with text "Accessibility statement"
	
	When I press the "Continue" button
	Then I see "Enter your email address" on the page
	Then I see "Enter your email address and check that it matches the one in the first field" on the page

	When I set "Enter your email address" to "<email>"
	When I set "Enter your email address again" to "<email>"
	And I press the "Continue" button
	Then I see "What is your date of birth" on the page
	And I see link with text "Accessibility statement"
	
	When I press the "Continue" button
	Then I see "There is a problem" on the page
	Then I see "Enter the day you were born" on the page
	And I do not see "Enter the month you were born" on the page
	And I do not see "Enter the year you were born" on the page
	
	When I set "Day" to "27"
	And I set "Month" to "04"
	And I set "Year" to "1981"
	And I press the "Continue" button
	Then I see "Confirm you're eligible for jury service" on the page
	And I see link with text "Accessibility statement"
	
	And I press the "Continue" button
	
	Then I see "Since you turned 13, has your main address been in the UK, Channel Islands or Isle of Man for any period of at least 5 years?" on the page
	And I see link with text "Accessibility statement"
	And I choose the "No" radio button
	And I set "Provide details" to "Residency"
	And I press the "Continue" button
	
	Then I see "Have you worked in the criminal justice system in the last 5 years?" on the page
	And I see link with text "Accessibility statement"
	Then I see "Have you worked in the criminal justice system in the last 5 years?" on the page
	When I choose the "No" radio button
	And I press the "Continue" button
	
	Then I see "bail" on the page
	And I see link with text "Accessibility statement"
	And I see "Are you currently on bail for a criminal offence?" on the page
	When I choose the "No" radio button
	And I press the "Continue" button
	
	Then I see "Have you been found guilty of a criminal offence?" on the page
	And I see link with text "Accessibility statement"
	When I choose the "No" radio button
	And I press the "Continue" button
	
	Then I see "Mental Health" on the page
	And I see link with text "Accessibility statement"
	And I see "Are you being detained, looked after or treated under the Mental Health Act?" on the page
	When I choose the "No" radio button
	And I press the "Continue" button
	
	Then I see "Has it been decided that you 'lack mental capacity'?" on the page
	And I see link with text "Accessibility statement"
	When I choose the "No" radio button
	And I press the "Continue" button
	
	And I see link with text "Accessibility statement"
	And I see "No, I need to change the date" on the page
	And I set the radio button to "No, I need to change the date"
	And I press the "Continue" button
	
	And I see "Tell us why you need another date for your jury service" on the page
	And I see link with text "Accessibility statement"
	When I set text area with "id" of "deferralReason" to "Deferral Reason"
	And I press the "Continue" button
	Then I see "Choose 3 Mondays when you can start jury service" on the page
	And I see link with text "Accessibility statement"

	When I set the "First" single date field to a Monday "19" weeks in the future
	When I set the "Second" single date field to a Monday "20" weeks in the future
	When I set the "Third" single date field to a Monday "21" weeks in the future

	And I press the "Continue" button
	
	#confirm dates
	And I choose the "Yes" radio button
	And I press the "Continue" button
	
	Then I see "Will you need help when you're at the court?" on the page
	And I see link with text "Accessibility statement"
	Then I see "Do you have a disability or impairment that means you’ll need extra support or facilities in the court building where you are doing your Jury Service?" on the page
	When I choose the "Yes" radio button
	Then I check the "Diabetes" checkbox
	And I press the "Continue" button
	Then I see "Check your answers now" on the page
	And I see link with text "Accessibility statement"
	
	Then I check the "The information I have given is true to the best of my knowledge" checkbox
	
	When I press the "Submit" button
	
	Then I see "You have completed your reply" on the page
	And I see link with text "Accessibility statement"
	Then I see "<juror_number>" on the page

Examples:
	|juror_number	|pool_number|last_name			|postcode	|email 		|
	|041500034		|415300125	|LNAMESEVENONETHREE	|SY2 6LU	|e@eeee.com	|
	

@Regression
Scenario Outline: English 3rd Party - Accessibility statement on each page
	
	Given I am on "Public" "ithc"

	Given a bureau owned pool is created with jurors
		| court | juror_number  	| pool_number	| att_date_weeks_in_future	| owner |
		| 415	| <juror_number> 	| <pool_number> | 5				            | 400	|

	And juror "<juror_number>" has "LAST_NAME" as "<last_name>" new schema
	And juror "<juror_number>" has "POSTCODE" as "<postcode>" new schema
	
	Then I see "Reply to a jury summons" on the page
	And I see link with text "Accessibility statement"
	
	And I set the radio button to "I am replying for someone else"
	And I press the "Continue" button
	Then I see "Their juror details" on the page
	And I see link with text "Accessibility statement"
	
	#Juror Log In
	When I set "9-digit juror number" to "<juror_number>"
	When I set "Juror last name" to "<last_name>"
	When I set "Juror postcode" to "<postcode>"
	And I press the "Continue" button
	Then I see "What is your name?" on the page
	And I see link with text "Accessibility statement"
	
	#3rd Party Name
	When I see "Your Details" on the page
	When I set "First name" to "FirstNameA"
	And I set "Last name" to "LastNameB"
	And I press the "Continue" button
	Then I see "Your relationship to the person" on the page
	And I see link with text "Accessibility statement"
	
	#Relationship to juror
	When I see "Your Details" on the page
	And I set "How do you know the person you're replying for?" to "Friend Friend Friend Friend Friend Friend Friend Friend Friend Friend Friend Friend Friend Friend Fr"
	And I press the "Continue" button
	Then I see "Your contact information" on the page
	And I see link with text "Accessibility statement"
	
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
	And I see link with text "Accessibility statement"
	And I do not see "Why are you replying?" on the page
	When I set the radio button to "The person is not here"
	And I press the "Continue" button
	Then I see "Is the name we have for them correct?" on the page
	And I see link with text "Accessibility statement"
	
	#Check juror name
	When I see "Juror Details" on the page
	And I choose the "Yes" radio button
	And I press the "Continue" button
	Then I see "Is this their address?" on the page
	And I see link with text "Accessibility statement"
	
	#Check juror address
	When I see "Juror Details" on the page
	And I choose the "Yes" radio button
	And I press the "Continue" button
	Then I see "Give the date of birth for the person you're replying for" on the page
	And I see link with text "Accessibility statement"
	
	#DoB
	When I see "Juror Details" on the page
	And I set "Day" to "01"
	And I set "Month" to "01"
	
	#JDB-3418 Checking age 18 works
	And I set "Year" to "2000"
	And I press the "Continue" button
	Then I see "We might need to get in touch with the person to ask them more questions or give them information about their jury service" on the page
	And I see link with text "Accessibility statement"
	
	#Contacting the juror
	When I see "Juror Details" on the page
	And I set the radio button to "Use the phone number that you have already given to contact you"
	And I set the radio button to "Use the email address that you have already given to contact you"
	And I press the "Continue" button
	And I see link with text "Accessibility statement"
	
	#Qualify for jury service
	When I see "Confirm if the person is eligible for jury service" on the page
	And I press the "Continue" button
	
	#Residency
	Then I see "Since they turned 13, has their main address been in the UK, Channel Islands or Isle of Man for any period of at least 5 years?" on the page
	And I see link with text "Accessibility statement"
	When I see "Eligibility" on the page
	And I choose the "Yes" radio button
	And I press the "Continue" button
	
	#Have you ever worked
	Then I see "Has the person you're replying for worked in the criminal justice system in the last 5 years?" on the page
	And I see link with text "Accessibility statement"
	When I choose the "No" radio button
	And I press the "Continue" button
	
	#Bail
	Then I see "Is the person currently on bail for a criminal offence?" on the page
	And I see link with text "Accessibility statement"
	When I see "Eligibility" on the page
	And I choose the "No" radio button
	And I press the "Continue" button
	
	#Convictions
	Then I see "Has the person been found guilty of a criminal offence?" on the page
	And I see link with text "Accessibility statement"
	When I see "Eligibility" on the page
	And I choose the "Yes" radio button
	And I set text area with "id" of "convictedDetails" to "Criminal Convictions"
	And I press the "Continue" button
	
	#Mental Health Sectioned
	Then I see "Is the person you're replying for being detained, looked after or treated under the Mental Health Act?" on the page
	And I see link with text "Accessibility statement"
	When I see "Eligibility" on the page
	And I choose the "No" radio button
	And I press the "Continue" button
	
	#Mental Health Capacity
	Then I see "Has it been decided that the person you're replying for 'lacks mental capacity'?" on the page
	And I see link with text "Accessibility statement"
	When I see "Eligibility" on the page
	And I choose the "No" radio button
	And I press the "Continue" button
	
	#Confirm Date of Jury
	Then I see "Check your start date" on the page
	And I see link with text "Accessibility statement"
	When I set the radio button to "No, we need to change the date" 
	And I press the "Continue" button
	Then I see "Tell us why they need another date for their jury service" on the page
	And I see link with text "Accessibility statement"
	
	#Deferral Reason
	When I set text area with "id" of "deferralReason" to "askForAnotherDateReasonWhy"
	And I press the "Continue" button
	
	#JDB-3445 Deferral Date Screen Layout
	Then I see "Choose 3 Mondays when they can start jury service" on the page

	When I set the "First" single date field to a Monday "19" weeks in the future
	When I set the "Second" single date field to a Monday "20" weeks in the future
	When I set the "Third" single date field to a Monday "21" weeks in the future

	And I press the "Continue" button
	
	When I click on the "Back" link 
	And I press the "Continue" button
	
	#confirm dates
	And I choose the "Yes" radio button
	And I press the "Continue" button
	
	Then I see "Will the person you're replying for need help when they're at the court?" on the page
	And I see link with text "Accessibility statement"
	When I choose the "Yes" radio button
	Then I check the "Diabetes" checkbox
	And I press the "Continue" button
	
	Then I see "Check your answers now" on the page
	And I see link with text "Accessibility statement"
	
	When I check the "The answers I have given for the person I'm replying for are true as far as I know" checkbox
	And I press the "Submit" button
	
	Then I see "You have completed your reply" on the page
	And I see link with text "Accessibility statement"
	
Examples:
	|juror_number	|last_name			|postcode	|email           	|pool_number|
	|041500035		|LNAMESIXSEVENSIX	|CH1 2AN	|email@outlook.com	|415300126	|