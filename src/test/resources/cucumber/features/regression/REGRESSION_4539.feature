Feature: Regression JDB-4539

@Regression @NewSchemaConverted
Scenario Outline: English 1st Party ST JDB-4539
	
	Given I am on "Public" "test"

	Given a bureau owned pool is created with jurors
		| court 	|juror_number  		| pool_number	| att_date_weeks_in_future	| owner |
		| <court> 	|<juror_number> 	| <pool_number> | 5				            | 400	|
		
	And juror "<juror_number>" has "LAST_NAME" as "<last_name>" new schema
	And juror "<juror_number>" has "POSTCODE" as "<postcode>" new schema

   	And I do not see "You can ask a family member, friend or carer to help you." on the page
   	Then I click on the "What if I need help replying?" link
   	And I see "You can ask a family member, friend or carer to help you." on the page
   	And I see "They can reply for you or help you to do it yourself." on the page
   	And I see "You may be able to get help with using a computer at your local library." on the page
   	And I see "If you need more help, call 0300 456 1024." on the page
   	Then I click on the "What if I need help replying?" link
   	And I do not see "You can ask a family member, friend or carer to help you." on the page

	And I set the radio button to "I am replying for myself"
	And I see "You can still ask a family member or a person you trust to help you understand or reply." on the page
	And I press the "Continue" button
	And I see "Your juror details" on the page
	And I see "You can find your juror number on your jury summons letter." on the page
	
	And I do not see "If you do not have a juror number, please contact:" on the page
    And I click on the "I do not have a juror number" link
	Then I see "jurysummoning@justice.gov.uk" on the page
	And I see "If you do not have a juror number, please contact:" on the page
	Then I click on the "I do not have a juror number" link
    And I do not see "If you do not have a juror number, please contact:" on the page
	
	When I set "9-digit juror number" to "<juror_number>"
	And I set "Juror last name" to "<last_name>"
	And I set "Juror postcode" to "<postcode>"
	And I press the "Continue" button
	Then on the page I see
		| text	|
		| Your details |
		| Is the name we have for you correct? |
	
	And I set the radio button to "Yes"
	
	And I press the "Continue" button
	Then on the page I see
		| text	|
		| Is this your address? |
		
	And I do not see "If your address will change soon, give us your current address. This is so we can still contact you." on the page
    And I click on the "Will your address change soon?" link
	And I see "If your address will change soon, give us your current address. This is so we can still contact you." on the page
	Then I click on the "Will your address change soon?" link
    And I do not see "If your address will change soon, give us your current address. This is so we can still contact you." on the page

	And I set the radio button to "Yes"
	
	When I press the "Continue" button
	
	Then on the page I see
		| text	|
		|Your details|
		|What is your phone number?|
		|Please provide a UK phone number that we can use to reach you between 9am and 5pm, Monday to Friday.|
		|Main phone|
		|Another phone (optional)|

	When I set "Main phone" to "02078211818"
	And I press the "Continue" button

	Then on the page I see
		| text	|
		| Your details |
		| What is your email address? |
		| Enter your email address |
		| Enter your email address again |

    And I do not see "We'll use your email address to send you information and reminders about your jury service." on the page
    And I click on the "Why do we need your email address?" link
	And I see "We'll use your email address to send you information and reminders about your jury service." on the page
	Then I click on the "Why do we need your email address?" link
    And I do not see "We'll use your email address to send you information and reminders about your jury service." on the page
	
	When I set "Enter your email address" to "<email>"
	When I set "Enter your email address again" to "<email>"
	And I press the "Continue" button

	Then on the page I see
		| text	|
		| Your details	|
		| What is your date of birth?	|
		| For example, 15 03 1982 |
		| Help with date of birth |
	
	And I do not see "You need to tell us your date of birth so we can check you are a suitable age to be on a jury." on the page
    And I click on the "Help with date of birth" link
	And I see "You need to tell us your date of birth so we can check you are a suitable age to be on a jury." on the page
	Then I click on the "Help with date of birth" link
    And I do not see "You need to tell us your date of birth so we can check you are a suitable age to be on a jury." on the page
	
	When I set "Day" to "01"
	And I set "Month" to "01"
	And I set "Year" to "1990"
	And I press the "Continue" button

	#Qualify for jury service
	
	Then I see "Confirm you're eligible for jury service" on the page
	When I press the "Continue" button
	
	#Residency
	
	Then I see "Since you turned 13, has your main address been in the UK, Channel Islands or Isle of Man for any period of at least 5 years?" on the page
	When I see "Eligibility" on the page

	And I set the radio button to "Yes"
	And I press the "Continue" button
	
	#CJS
	
	Then I see "Have you worked in the criminal justice system in the last 5 years?" on the page
	And I do not see "Your job in the Criminal Justice System does not stop you doing jury service. But we may get in touch to find out more." on the page
    And I click on the "Why do we ask this?" link
	And I see "Your job in the Criminal Justice System does not stop you doing jury service. But we may get in touch to find out more." on the page
	Then I click on the "Why do we ask this?" link
    And I do not see "Your job in the Criminal Justice System does not stop you doing jury service. But we may get in touch to find out more." on the page
	
	#CJS no
	
	When I set the radio button to "No"
	And I press the "Continue" button
	
	#Bail
	
	Then I see "Are you currently on bail for a criminal offence?" on the page
	And I set the radio button to "No"
	And I press the "Continue" button
	
	#Convictions
	
	Then I see "Have you been found guilty of a criminal offence?" on the page
	When I set the radio button to "No"
	And I press the "Continue" button
	
	#Mental Health Sectioned
	
	Then I see "Are you being detained, looked after or treated under the Mental Health Act?" on the page
	And I set the radio button to "No"
	And I press the "Continue" button
	
	#Mental Health Capacity
	
	Then I see "Has it been decided that you 'lack mental capacity'?" on the page
	And I set the radio button to "No"
	And I press the "Continue" button
	
	#I can attend
	
	Then I see "Check your start date" on the page
	And I see "Yes, I can start on" on the page
	And I set the radio button to "Yes, I can start on"
	And  I press the "Continue" button
	
	#RA no
	
	Then I see "Will you need help when you're at the court?" on the page
	
	And I do not see "If you tell us you have an impairment or disability, we'll do all we can to help you and meet your needs in the court building when you do jury service." on the page
    And I click on the "Why do we ask this?" link
	And I see "If you tell us you have an impairment or disability, we'll do all we can to help you and meet your needs in the court building when you do jury service." on the page
	Then I click on the "Why do we ask this?" link
    And I do not see "If you tell us you have an impairment or disability, we'll do all we can to help you and meet your needs in the court building when you do jury service." on the page
	
	When I set the radio button to "No"
	And I press the "Continue" button
	Then I see "Check your answers now" on the page
	
	#Check your answers
	
	And I check the "The information I have given is true to the best of my knowledge" checkbox
	And I press the "Submit" button
	Then I see "We have sent you an email to say you have replied to your jury summons." on the page
	
Examples:
	|juror_number	|last_name	|postcode	|email 		|pool_number| court |
	|041500029		|DOE		|SW1H 9AJ	|a@eeee.com	|415300120	| 415	|
	
@Regression @NewSchemaConverted
Scenario Outline: English 3rd Party St JDB-4539

	Given I am on "Public" "test"

	Given a bureau owned pool is created with jurors
		| court 	|juror_number  		| pool_number	| att_date_weeks_in_future	| owner |
		| <court> 	|<juror_number> 	| <pool_number> | 5				            | 400	|

	And juror "<juror_number>" has "LAST_NAME" as "<last_name>" new schema
	And juror "<juror_number>" has "POSTCODE" as "<postcode>" new schema
	
	Then I see "Reply to a jury summons" on the page
	
   	And I do not see "You can ask a family member, friend or carer to help you." on the page
   	Then I click on the "What if I need help replying?" link
   	And I see "You can ask a family member, friend or carer to help you." on the page
   	Then I click on the "What if I need help replying?" link
   	And I do not see "You can ask a family member, friend or carer to help you." on the page
		
	And I set the radio button to "I am replying for someone else"
	And I press the "Continue" button
	Then I see "Their juror details" on the page
	And I see "You can find their juror number on the jury summons letter." on the page
	
	And I do not see "If you do not have a juror number for the person you are replying for, please contact:" on the page
    And I click on the "do not have a juror number for the person" link
	Then I see "jurysummoning@justice.gov.uk" on the page
	And I see "If you do not have a juror number for the person you are replying for, please contact:" on the page
	Then I click on the "do not have a juror number for the person" link
    And I do not see "If you do not have a juror number for the person you are replying for, please contact:" on the page
	
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
	And I see "Provide a UK phone number that we can use to reach you between 9am and 5pm, Monday to Friday." on the page
	And I set "Main phone" to "0207 821 1818"
	And I check the "By email" checkbox
	And I set "Enter your email address" to "<email>"
	And I set "Enter your email address again" to "<email>"
	
   	And I do not see "If we need to get in touch with you to check anything about your response for the other person, we'll use the email or phone number you give us." on the page
   	Then I click on the "Why do we need your contact details?" link
   	And I see "If we need to get in touch with you to check anything about your response for the other person, we'll use the email or phone number you give us." on the page
   	Then I click on the "Why do we need your contact details?" link
  	And I do not see "If we need to get in touch with you to check anything about your response for the other person, we'll use the email or phone number you give us." on the page
	
   	And I do not see "If you are currently living abroad and do not have a UK telephone number, we will need to contact you using an email address." on the page
   	Then I click on the "If you are living abroad" link
   	And I see "If you are currently living abroad and do not have a UK telephone number, we will need to contact you using an email address." on the page
   	Then I click on the "If you are living abroad" link
 	And I do not see "If you are currently living abroad and do not have a UK telephone number, we will need to contact you using an email address." on the page
	
	And I press the "Continue" button
	
	#Why Replying
	Then I see "Why are you replying for the other person?" on the page
	When I set the radio button to "The person is not here"
	And I press the "Continue" button
	Then I see "Is the name we have for them correct?" on the page
	
	#Check juror name
	When I see "Juror Details" on the page
	And I set the radio button to "Yes"
	And I press the "Continue" button
	
	#Check juror address
	Then I see "Is this their address?" on the page
	
    And I do not see "If their address will change soon, give us their current address. This is so we can still contact them." on the page
    Then I click on the "Will their address change soon?" link
    And I see "If their address will change soon, give us their current address. This is so we can still contact them." on the page
    Then I click on the "Will their address change soon?" link
    And I do not see "If their address will change soon, give us their current address. This is so we can still contact them." on the page
	
	And I set the radio button to "Yes"
	And I press the "Continue" button
	Then I see "Give the date of birth for the person you're replying for" on the page
	
    And I do not see "You need to tell us the person's date of birth so we can check they are a suitable age to be on a jury." on the page
    Then I click on the "Help with date of birth" link
    And I see "You need to tell us the person's date of birth so we can check they are a suitable age to be on a jury." on the page
    Then I click on the "Help with date of birth" link
    And I do not see "You need to tell us the person's date of birth so we can check they are a suitable age to be on a jury." on the page
	
	#DoB
	And I set "Day" to "01"
	And I set "Month" to "01"	
	And I set "Year" to "1980"
	And I press the "Continue" button
	Then I see "We might need to get in touch with the person to ask them more questions or give them information about their jury service" on the page
	
	#Contacting the juror
	And I set the radio button to "Use the phone number that you have already given to contact you"
	And I set the radio button to "Use the email address that you have already given to contact you"
	
    And I do not see "We'll use the email address to send information and reminders about this jury service." on the page
    Then I click on the "Why do we need an email address?" link
    And I see "We'll use the email address to send information and reminders about this jury service." on the page
    Then I click on the "Why do we need an email address?" link
    And I do not see "We'll use the email address to send information and reminders about this jury service." on the page
	
	And I press the "Continue" button

	#Qualify for jury service
	When I see "Confirm if the person is eligible for jury service" on the page
	And I press the "Continue" button
	
	#Residency
	Then I see "Since they turned 13, has their main address been in the UK, Channel Islands or Isle of Man for any period of at least 5 years?" on the page
	When I see "Eligibility" on the page
	And I set the radio button to "Yes"
	And I press the "Continue" button
	
	#CJS no
	Then I see "Has the person you're replying for worked in the criminal justice system in the last 5 years?" on the page
	
    And I do not see "Working in the Criminal Justice system does not stop a person doing jury service. But we may get in touch to find out more." on the page
    Then I click on the "Why do we ask this?" link
    And I see "Working in the Criminal Justice system does not stop a person doing jury service. But we may get in touch to find out more." on the page
    Then I click on the "Why do we ask this?" link
    
	And I do not see "Working in the Criminal Justice system does not stop a person doing jury service. But we may get in touch to find out more." on the page
	When I set the radio button to "No"
	And I press the "Continue" button
	
	#Bail
	Then I see "Is the person currently on bail for a criminal offence?" on the page
	And I set the radio button to "No"
	And I press the "Continue" button
	
	#Convictions
	Then I see "Has the person been found guilty of a criminal offence?" on the page
	When I set the radio button to "No"
	And I press the "Continue" button
	
	#Mental Health Sectioned
	Then I see "Is the person you're replying for being detained, looked after or treated under the Mental Health Act?" on the page
	And I set the radio button to "No"
	And I press the "Continue" button
	
	#Mental Health Capacity
	Then I see "Has it been decided that the person you're replying for 'lacks mental capacity'?" on the page
	And I set the radio button to "No"
	And I press the "Continue" button
	
	#The person can attend
	Then I see "Check your start date" on the page
	Then I set the radio button to "Yes, they can start on"
	And  I press the "Continue" button
	
	#RA no
	Then I see "Will the person you're replying for need help when they're at the court?" on the page
	
	And I do not see "If you tell us the person you're replying for has an impairment or disability," on the page
    Then I click on the "Why do we ask this?" link
    And I see "If you tell us the person you're replying for has an impairment or disability," on the page
    Then I click on the "Why do we ask this?" link
    And I do not see "If you tell us the person you're replying for has an impairment or disability," on the page
    
	When I set the radio button to "No"
	And I press the "Continue" button
	Then I see "Check your answers now" on the page
	
	#Check your answers
	When I check the "The answers I have given for the person I'm replying for are true as far as I know." checkbox
		
	#When I press the "Submit" button
	And I press the "Submit" button
	
	Then I see "We have sent an email to say you have replied to this jury summons." on the page
	
Examples:
	|juror_number	|last_name	|postcode	|email           	|pool_number| court |
	|041500030		|DOE		|SW1H 9AJ	|email@outlook.com	|415300121	| 415	|
	
	
@Regression @JDB-4539 
Scenario Outline: English 1st Party Deferral JDB-4539
	
	Given I am on "Public" "test"

	Given a bureau owned pool is created with jurors
		| court 	|juror_number  		| pool_number	| att_date_weeks_in_future	| owner |
		| <court> 	|<juror_number> 	| <pool_number> | 5				            | 400	|

	And juror "<juror_number>" has "LAST_NAME" as "<last_name>" new schema
	And juror "<juror_number>" has "POSTCODE" as "<postcode>" new schema

   	And I do not see "You can ask a family member, friend or carer to help you." on the page
   	Then I click on the "What if I need help replying?" link
   	And I see "You can ask a family member, friend or carer to help you." on the page
   	Then I click on the "What if I need help replying?" link
   	And I do not see "You can ask a family member, friend or carer to help you." on the page

	And I set the radio button to "I am replying for myself"
	And I see "You can still ask a family member or a person you trust to help you understand or reply." on the page
	And I press the "Continue" button
	And I see "Your juror details" on the page
	And I see "You can find your juror number on your jury summons letter." on the page
	
	And I do not see "If you do not have a juror number, please contact:" on the page
    And I click on the "I do not have a juror number" link
	Then I see "jurysummoning@justice.gov.uk" on the page
	And I see "If you do not have a juror number, please contact:" on the page
	Then I click on the "I do not have a juror number" link
    And I do not see "If you do not have a juror number, please contact:" on the page
	
	When I set "9-digit juror number" to "<juror_number>"
	And I set "Juror last name" to "<last_name>"
	And I set "Juror postcode" to "<postcode>"
	And I press the "Continue" button
	Then on the page I see
		| text	|
		| Your details |
		| Is the name we have for you correct? |
	
	And I set the radio button to "Yes"
	
	And I press the "Continue" button

	Then on the page I see
		| text	|
		| Is this your address? |
		
	And I do not see "If your address will change soon, give us your current address. This is so we can still contact you." on the page
    And I click on the "Will your address change soon?" link
	And I see "If your address will change soon, give us your current address. This is so we can still contact you." on the page
	Then I click on the "Will your address change soon?" link
    And I do not see "If your address will change soon, give us your current address. This is so we can still contact you." on the page

	And I set the radio button to "Yes"
	
	When I press the "Continue" button
	
	Then on the page I see
		| text	|
		|Your details|
		|What is your phone number?|
		|Please provide a UK phone number that we can use to reach you between 9am and 5pm, Monday to Friday.|
		|Main phone|
		|Another phone (optional)|

	When I set "Main phone" to "02078211818"
	And I press the "Continue" button

	Then on the page I see
		| text	|
		| Your details |
		| What is your email address? |
		| Enter your email address |
		| Enter your email address again |

    And I do not see "We'll use your email address to send you information and reminders about your jury service." on the page
    And I click on the "Why do we need your email address?" link
	And I see "We'll use your email address to send you information and reminders about your jury service." on the page
	Then I click on the "Why do we need your email address?" link
    And I do not see "We'll use your email address to send you information and reminders about your jury service." on the page
	
	When I set "Enter your email address" to "<email>"
	When I set "Enter your email address again" to "<email>"
	And I press the "Continue" button

	Then on the page I see
		| text	|
		| Your details	|
		| What is your date of birth?	|
		| For example, 15 03 1982 |
		| Help with date of birth |
	
	And I do not see "You need to tell us your date of birth so we can check you are a suitable age to be on a jury." on the page
    And I click on the "Help with date of birth" link
	And I see "You need to tell us your date of birth so we can check you are a suitable age to be on a jury." on the page
	Then I click on the "Help with date of birth" link
    And I do not see "You need to tell us your date of birth so we can check you are a suitable age to be on a jury." on the page
	
	When I set "Day" to "01"
	And I set "Month" to "01"
	And I set "Year" to "1990"
	And I press the "Continue" button

	#Qualify for jury service
	Then I see "Confirm you're eligible for jury service" on the page
	When I press the "Continue" button
	
	#Residency
	Then I see "Since you turned 13, has your main address been in the UK, Channel Islands or Isle of Man for any period of at least 5 years?" on the page
	When I see "Eligibility" on the page
	And I set the radio button to "Yes"
	And I press the "Continue" button
	
	#CJS
	And I do not see "Your job in the Criminal Justice System does not stop you doing jury service. But we may get in touch to find out more." on the page
    And I click on the "Why do we ask this?" link
	And I see "Your job in the Criminal Justice System does not stop you doing jury service. But we may get in touch to find out more." on the page
	Then I click on the "Why do we ask this?" link
    And I do not see "Your job in the Criminal Justice System does not stop you doing jury service. But we may get in touch to find out more." on the page
	
	When I set the radio button to "No"
	And I press the "Continue" button
	
	#Bail
	Then I see "Are you currently on bail for a criminal offence?" on the page
	And I set the radio button to "No"
	And I press the "Continue" button
	
	#Convictions
	Then I see "Have you been found guilty of a criminal offence?" on the page
	When I set the radio button to "No"
	And I press the "Continue" button
	
	#Mental Health Sectioned
	Then I see "Are you being detained, looked after or treated under the Mental Health Act?" on the page
	And I set the radio button to "No"
	And I press the "Continue" button
	
	#Mental Health Capacity
	Then I see "Has it been decided that you 'lack mental capacity'?" on the page
	And I set the radio button to "No"
	And I press the "Continue" button
	
	Then I see "Check your start date" on the page
	
	And I see "No, I need to change the date" on the page
	And I set the radio button to "No, I need to change the date"
	And I press the "Continue" button
	
	And I see "Tell us why you need another date for your jury service" on the page
	When I set text area with "id" of "deferralReason" to "Deferral Reason"
	And I press the "Continue" button
	
	Then I see "Choose 3 Mondays when you can start jury service" on the page

	When I set the "First" single date field to a Monday "9" weeks in the future
	When I set the "Second" single date field to a Monday "10" weeks in the future
	When I set the "Third" single date field to a Monday "11" weeks in the future
	
	And I press the "Continue" button

	#confirm dates
	When I set the radio button to "Yes"
	And I press the "Continue" button
	
	#help in court
	When I set the radio button to "No"
	And I press the "Continue" button
	
	Then I see "Check your answers now" on the page

	Then I check the "The information I have given is true to the best of my knowledge" checkbox
	
	When I press the "Submit" button
	
	Then I see "You have completed your reply" on the page	
	
Examples:
	|juror_number	|pool_number|last_name			|postcode	|email 		| court |
	|041500031		|415300122	|LNAMESEVENONETHREE	|SY2 6LU	|e@eeee.com	| 415	|
	
		
@Regression @NewSchemaConverted
Scenario Outline: English 3rd Party Deferral JDB-4539

	Given I am on "Public" "test"

	Given a bureau owned pool is created with jurors
		| court 	|juror_number  		| pool_number	| att_date_weeks_in_future	| owner |
		| <court> 	|<juror_number> 	| <pool_number> | 5				            | 400	|

	And juror "<juror_number>" has "LAST_NAME" as "<last_name>" new schema
	And juror "<juror_number>" has "POSTCODE" as "<postcode>" new schema
	
	Then I see "Reply to a jury summons" on the page
	
   	And I do not see "You can ask a family member, friend or carer to help you." on the page
   	Then I click on the "What if I need help replying?" link
   	And I see "You can ask a family member, friend or carer to help you." on the page
   	Then I click on the "What if I need help replying?" link
   	And I do not see "You can ask a family member, friend or carer to help you." on the page
		
	And I set the radio button to "I am replying for someone else"
	And I press the "Continue" button
	Then I see "Their juror details" on the page
	And I see "You can find their juror number on the jury summons letter." on the page
	
	And I do not see "If you do not have a juror number for the person you are replying for, please contact:" on the page
    And I click on the "do not have a juror number for the person" link
	Then I see "jurysummoning@justice.gov.uk" on the page
	And I see "If you do not have a juror number for the person you are replying for, please contact:" on the page
	Then I click on the "do not have a juror number for the person" link
    And I do not see "If you do not have a juror number for the person you are replying for, please contact:" on the page
	
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
	And I see "Provide a UK phone number that we can use to reach you between 9am and 5pm, Monday to Friday." on the page
	And I set "Main phone" to "0207 821 1818"
	And I check the "By email" checkbox
	And I set "Enter your email address" to "<email>"
	And I set "Enter your email address again" to "<email>"
	
   	And I do not see "If we need to get in touch with you to check anything about your response for the other person, we'll use the email or phone number you give us." on the page
   	Then I click on the "Why do we need your contact details?" link
   	And I see "If we need to get in touch with you to check anything about your response for the other person, we'll use the email or phone number you give us." on the page
   	Then I click on the "Why do we need your contact details?" link
  	And I do not see "If we need to get in touch with you to check anything about your response for the other person, we'll use the email or phone number you give us." on the page
	
   	And I do not see "If you are currently living abroad and do not have a UK telephone number, we will need to contact you using an email address." on the page
   	Then I click on the "If you are living abroad" link
   	And I see "If you are currently living abroad and do not have a UK telephone number, we will need to contact you using an email address." on the page
   	Then I click on the "If you are living abroad" link
 	And I do not see "If you are currently living abroad and do not have a UK telephone number, we will need to contact you using an email address." on the page
	
	And I press the "Continue" button
	
	#Why Replying
	Then I see "Why are you replying for the other person?" on the page
	When I set the radio button to "The person is not here"
	And I press the "Continue" button
	Then I see "Is the name we have for them correct?" on the page
	
	#Check juror name
	When I see "Juror Details" on the page
	And I set the radio button to "Yes"
	And I press the "Continue" button
	
	#Check juror address
	Then I see "Is this their address?" on the page
	
    And I do not see "If their address will change soon, give us their current address. This is so we can still contact them." on the page
    Then I click on the "Will their address change soon?" link
    And I see "If their address will change soon, give us their current address. This is so we can still contact them." on the page
    Then I click on the "Will their address change soon?" link
    And I do not see "If their address will change soon, give us their current address. This is so we can still contact them." on the page
	
	And I set the radio button to "Yes"
	And I press the "Continue" button
	Then I see "Give the date of birth for the person you're replying for" on the page
	
    And I do not see "You need to tell us the person's date of birth so we can check they are a suitable age to be on a jury." on the page
    Then I click on the "Help with date of birth" link
    And I see "You need to tell us the person's date of birth so we can check they are a suitable age to be on a jury." on the page
    Then I click on the "Help with date of birth" link
    And I do not see "You need to tell us the person's date of birth so we can check they are a suitable age to be on a jury." on the page
	
	#DoB
	And I set "Day" to "01"
	And I set "Month" to "01"	
	And I set "Year" to "1980"
	And I press the "Continue" button
	Then I see "We might need to get in touch with the person to ask them more questions or give them information about their jury service" on the page
	
	#Contacting the juror
	And I set the radio button to "Use the phone number that you have already given to contact you"
	And I set the radio button to "Use the email address that you have already given to contact you"
	
    And I do not see "We'll use the email address to send information and reminders about this jury service." on the page
    Then I click on the "Why do we need an email address?" link
    And I see "We'll use the email address to send information and reminders about this jury service." on the page
    Then I click on the "Why do we need an email address?" link
    And I do not see "We'll use the email address to send information and reminders about this jury service." on the page
	
	And I press the "Continue" button

	#Qualify for jury service
	When I see "Confirm if the person is eligible for jury service" on the page
	And I press the "Continue" button
	
	#Residency
	Then I see "Since they turned 13, has their main address been in the UK, Channel Islands or Isle of Man for any period of at least 5 years?" on the page
	When I see "Eligibility" on the page
	And I set the radio button to "Yes"
	And I press the "Continue" button
	
	# Have you ever worked
	Then I see "Has the person you're replying for worked in the criminal justice system in the last 5 years?" on the page
	
	And I do not see "Working in the Criminal Justice system does not stop a person doing jury service. But we may get in touch to find out more." on the page
    Then I click on the "Why do we ask this?" link
    And I see "Working in the Criminal Justice system does not stop a person doing jury service. But we may get in touch to find out more." on the page
    Then I click on the "Why do we ask this?" link
	And I do not see "Working in the Criminal Justice system does not stop a person doing jury service. But we may get in touch to find out more." on the page
	When I set the radio button to "No"
	And I press the "Continue" button
	
	#Bail
	Then I see "Is the person currently on bail for a criminal offence?" on the page
	And I set the radio button to "No"
	And I press the "Continue" button
	
	#Convictions
	Then I see "Has the person been found guilty of a criminal offence?" on the page
	When I set the radio button to "No"
	And I press the "Continue" button
	
	#Mental Health Sectioned
	Then I see "Is the person you're replying for being detained, looked after or treated under the Mental Health Act?" on the page
	And I set the radio button to "No"
	And I press the "Continue" button
	
	#Mental Health Capacity
	Then I see "Has it been decided that the person you're replying for 'lacks mental capacity'?" on the page
	And I set the radio button to "No"
	And I press the "Continue" button
	
	Then I see "Check your start date" on the page
	When I set the radio button to "No, we need to change the date" 
	And I press the "Continue" button
	
	Then I see "Tell us why they need another date for their jury service" on the page
	
	#Deferral Reason
	When I set text area with "id" of "deferralReason" to "askForAnotherDateReasonWhy"
	And I press the "Continue" button
	
	#JDB-3445 Deferral Date Screen Layout
	Then I see "Choose 3 Mondays when they can start jury service" on the page
	
	When I set the "First" single date field to a Monday "9" weeks in the future
	When I set the "Second" single date field to a Monday "10" weeks in the future
	When I set the "Third" single date field to a Monday "11" weeks in the future
	And I press the "Continue" button
	
	Then I set the radio button to "Yes"
	And I press the "Continue" button
	
	When I click on the "Back" link 
	And I press the "Continue" button
	
	Then I set the radio button to "Yes"
	And I press the "Continue" button
	
	Then I see "Will the person you're replying for need help when they're at the court?" on the page
	
	When I set the radio button to "Yes"
	Then I check the "Diabetes" checkbox
	And I press the "Continue" button
	
	Then I see "Check your answers now" on the page
	
	When I check the "The answers I have given for the person I'm replying for are true as far as I know" checkbox
	And I press the "Submit" button
	
	Then I see "You have completed your reply" on the page
	
Examples:
	|juror_number	|last_name			|postcode	|email           	|pool_number| court |
	|041500032		|LNAMESIXSEVENSIX	|CH1 2AN	|email@outlook.com	|415300123	| 415	|
	
@Regression @NewSchemaConverted
Scenario Outline: English 1st Party Excusal JDB-4539
	
	Given I am on "Public" "test"

	Given a bureau owned pool is created with jurors
		| court 	|juror_number  		| pool_number	| att_date_weeks_in_future	| owner |
		| <court> 	|<juror_number> 	| <pool_number> | 5				            | 400	|

	And juror "<juror_number>" has "LAST_NAME" as "<last_name>" new schema
	And juror "<juror_number>" has "POSTCODE" as "<postcode>" new schema

   	And I do not see "You can ask a family member, friend or carer to help you." on the page
   	Then I click on the "What if I need help replying?" link
   	And I see "You can ask a family member, friend or carer to help you." on the page
   	Then I click on the "What if I need help replying?" link
   	And I do not see "You can ask a family member, friend or carer to help you." on the page

	And I set the radio button to "I am replying for myself"
	And I see "You can still ask a family member or a person you trust to help you understand or reply." on the page
	And I press the "Continue" button
	And I see "Your juror details" on the page
	And I see "You can find your juror number on your jury summons letter." on the page
	
	And I do not see "If you do not have a juror number, please contact:" on the page
    And I click on the "I do not have a juror number" link
	Then I see "jurysummoning@justice.gov.uk" on the page
	And I see "If you do not have a juror number, please contact:" on the page
	Then I click on the "I do not have a juror number" link
    And I do not see "If you do not have a juror number, please contact:" on the page
	
	When I set "9-digit juror number" to "<juror_number>"
	And I set "Juror last name" to "<last_name>"
	And I set "Juror postcode" to "<postcode>"
	And I press the "Continue" button
	Then on the page I see
		| text	|
		| Your details |
		| Is the name we have for you correct? |
	
	And I set the radio button to "Yes"
	
	And I press the "Continue" button
	Then on the page I see
		| text	|
		| Is this your address? |
		
	And I do not see "If your address will change soon, give us your current address. This is so we can still contact you." on the page
    And I click on the "Will your address change soon?" link
	And I see "If your address will change soon, give us your current address. This is so we can still contact you." on the page
	Then I click on the "Will your address change soon?" link
    And I do not see "If your address will change soon, give us your current address. This is so we can still contact you." on the page

	And I set the radio button to "Yes"
	
	When I press the "Continue" button
	
	Then on the page I see
		| text	|
		|Your details|
		|What is your phone number?|
		|Please provide a UK phone number that we can use to reach you between 9am and 5pm, Monday to Friday.|
		|Main phone|
		|Another phone (optional)|

	When I set "Main phone" to "02078211818"
	And I press the "Continue" button

	Then on the page I see
		| text	|
		| Your details |
		| What is your email address? |
		| Enter your email address |
		| Enter your email address again |

    And I do not see "We'll use your email address to send you information and reminders about your jury service." on the page
    And I click on the "Why do we need your email address?" link
	And I see "We'll use your email address to send you information and reminders about your jury service." on the page
	Then I click on the "Why do we need your email address?" link
    And I do not see "We'll use your email address to send you information and reminders about your jury service." on the page
	
	When I set "Enter your email address" to "<email>"
	When I set "Enter your email address again" to "<email>"
	And I press the "Continue" button

	Then on the page I see
		| text	|
		| Your details	|
		| What is your date of birth?	|
		| For example, 15 03 1982 |
		| Help with date of birth |
	
	And I do not see "You need to tell us your date of birth so we can check you are a suitable age to be on a jury." on the page
    And I click on the "Help with date of birth" link
	And I see "You need to tell us your date of birth so we can check you are a suitable age to be on a jury." on the page
	Then I click on the "Help with date of birth" link
    And I do not see "You need to tell us your date of birth so we can check you are a suitable age to be on a jury." on the page
	
	When I set "Day" to "01"
	And I set "Month" to "01"
	And I set "Year" to "1990"
	And I press the "Continue" button

	#Qualify for jury service
	Then I see "Confirm you're eligible for jury service" on the page
	When I press the "Continue" button
	
	#Residency
	Then I see "Since you turned 13, has your main address been in the UK, Channel Islands or Isle of Man for any period of at least 5 years?" on the page
	When I see "Eligibility" on the page

	And I set the radio button to "Yes"
	And I press the "Continue" button
	
	#CJS
	Then I see "Have you worked in the criminal justice system in the last 5 years?" on the page
	
	And I do not see "Your job in the Criminal Justice System does not stop you doing jury service. But we may get in touch to find out more." on the page
    And I click on the "Why do we ask this?" link
	And I see "Your job in the Criminal Justice System does not stop you doing jury service. But we may get in touch to find out more." on the page
	Then I click on the "Why do we ask this?" link
    And I do not see "Your job in the Criminal Justice System does not stop you doing jury service. But we may get in touch to find out more." on the page
	
	When I set the radio button to "No"
	And I press the "Continue" button
	
	#Bail
	Then I see "Are you currently on bail for a criminal offence?" on the page
	And I set the radio button to "No"
	And I press the "Continue" button
	
	#Convictions
	Then I see "Have you been found guilty of a criminal offence?" on the page
	When I set the radio button to "No"
	And I press the "Continue" button
	
	#Mental Health Sectioned
	Then I see "Are you being detained, looked after or treated under the Mental Health Act?" on the page
	And I set the radio button to "No"
	And I press the "Continue" button
	
	#Mental Health Capacity
	Then I see "Has it been decided that you 'lack mental capacity'?" on the page
	And I set the radio button to "No"
	And I press the "Continue" button
	
	Then I see "Check your start date" on the page
	
	When I set the radio button to "No, I cannot do jury service and need to be excused" 
	And I press the "Continue" button
	
	#Excusal Reason
	Then I see "Why do you need to be excused from jury service?" on the page
	When I set text area with "id" of "excusalReason" to "Excuse me please"
	
	And I do not see "You may need to prove your reason for why you cannot do jury service in the next 12 months. For example, if you are too ill, we might ask to see a letter from your doctor." on the page
    And I click on the "Will I need to provide evidence soon?" link
	And I see "Explain why you cannot do jury service in the next 12 months." on the page
	And I see "You do not need to attach or gather evidence before your summons deadline." on the page
	And I see "We'll contact you later if we need this." on the page
	Then I click on the "Will I need to provide evidence soon?" link
	And I press the "Continue" button
	
	#RA
	Then I see "Will you need help when you're at the court?" on the page
	And I do not see "If you tell us you have an impairment or disability, we'll do all we can to help you and meet your needs in the court building when you do jury service." on the page
    And I click on the "Why do we ask this?" link
	And I see "If you tell us you have an impairment or disability, we'll do all we can to help you and meet your needs in the court building when you do jury service." on the page
	Then I click on the "Why do we ask this?" link
    And I do not see "If you tell us you have an impairment or disability, we'll do all we can to help you and meet your needs in the court building when you do jury service." on the page
	
	When I set the radio button to "No"
	And I press the "Continue" button
	Then I see "Check your answers now" on the page
	
	When I check the "The information" checkbox
	And I press the "Submit" button
	And I see "You have completed your reply" on the page
	
Examples:
	| juror_number	| last_name		| postcode	| email            | pool_number| court |
	| 041500033		| LNAMETWOTWOSIX| CH1 2AN	| email@outlook.com| 415300124	| 415   |
	
@Regression @NewSchemaConverted
Scenario Outline: English 3rd Party Excusal JDB-4539

	Given I am on "Public" "test"

	Given a bureau owned pool is created with jurors
		| court 	|juror_number  		| pool_number	| att_date_weeks_in_future	| owner |
		| <court> 	|<juror_number> 	| <pool_number> | 5				            | 400	|

	And juror "<juror_number>" has "LAST_NAME" as "<last_name>" new schema
	And juror "<juror_number>" has "POSTCODE" as "<postcode>" new schema
	
	Then I see "Reply to a jury summons" on the page
	
   	And I do not see "You can ask a family member, friend or carer to help you." on the page
   	Then I click on the "What if I need help replying?" link
   	And I see "You can ask a family member, friend or carer to help you." on the page
   	Then I click on the "What if I need help replying?" link
   	And I do not see "You can ask a family member, friend or carer to help you." on the page
		
	And I set the radio button to "I am replying for someone else"
	And I press the "Continue" button
	Then I see "Their juror details" on the page
	And I see "You can find their juror number on the jury summons letter." on the page
	
	And I do not see "If you do not have a juror number for the person you are replying for, please contact:" on the page
    And I click on the "do not have a juror number for the person" link
	Then I see "jurysummoning@justice.gov.uk" on the page
	And I see "If you do not have a juror number for the person you are replying for, please contact:" on the page
	Then I click on the "do not have a juror number for the person" link
    And I do not see "If you do not have a juror number for the person you are replying for, please contact:" on the page
	
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
	And I see "Provide a UK phone number that we can use to reach you between 9am and 5pm, Monday to Friday." on the page
	And I set "Main phone" to "0207 821 1818"
	And I check the "By email" checkbox
	And I set "Enter your email address" to "<email>"
	And I set "Enter your email address again" to "<email>"
	
   	And I do not see "If we need to get in touch with you to check anything about your response for the other person, we'll use the email or phone number you give us." on the page
   	Then I click on the "Why do we need your contact details?" link
   	And I see "If we need to get in touch with you to check anything about your response for the other person, we'll use the email or phone number you give us." on the page
   	Then I click on the "Why do we need your contact details?" link
  	And I do not see "If we need to get in touch with you to check anything about your response for the other person, we'll use the email or phone number you give us." on the page
	
   	And I do not see "If you are currently living abroad and do not have a UK telephone number, we will need to contact you using an email address." on the page
   	Then I click on the "If you are living abroad" link
   	And I see "If you are currently living abroad and do not have a UK telephone number, we will need to contact you using an email address." on the page
   	Then I click on the "If you are living abroad" link
 	And I do not see "If you are currently living abroad and do not have a UK telephone number, we will need to contact you using an email address." on the page
	
	And I press the "Continue" button
	
	#Why Replying
	Then I see "Why are you replying for the other person?" on the page
	When I set the radio button to "The person is not here"
	And I press the "Continue" button
	Then I see "Is the name we have for them correct?" on the page
	
	#Check juror name
	When I see "Juror Details" on the page
	And I set the radio button to "Yes"
	And I press the "Continue" button
	
	#Check juror address
	Then I see "Is this their address?" on the page
	
    And I do not see "If their address will change soon, give us their current address. This is so we can still contact them." on the page
    Then I click on the "Will their address change soon?" link
    And I see "If their address will change soon, give us their current address. This is so we can still contact them." on the page
    Then I click on the "Will their address change soon?" link
    And I do not see "If their address will change soon, give us their current address. This is so we can still contact them." on the page
	
	And I set the radio button to "Yes"
	And I press the "Continue" button
	Then I see "Give the date of birth for the person you're replying for" on the page
	
    And I do not see "You need to tell us the person's date of birth so we can check they are a suitable age to be on a jury." on the page
    Then I click on the "Help with date of birth" link
    And I see "You need to tell us the person's date of birth so we can check they are a suitable age to be on a jury." on the page
    Then I click on the "Help with date of birth" link
    And I do not see "You need to tell us the person's date of birth so we can check they are a suitable age to be on a jury." on the page
	
	#DoB
	And I set "Day" to "01"
	And I set "Month" to "01"	
	And I set "Year" to "1980"
	And I press the "Continue" button
	Then I see "We might need to get in touch with the person to ask them more questions or give them information about their jury service" on the page
	
	#Contacting the juror
	And I set the radio button to "Use the phone number that you have already given to contact you"
	And I set the radio button to "Use the email address that you have already given to contact you"
	
    And I do not see "We'll use the email address to send information and reminders about this jury service." on the page
    Then I click on the "Why do we need an email address?" link
    And I see "We'll use the email address to send information and reminders about this jury service." on the page
    Then I click on the "Why do we need an email address?" link
    And I do not see "We'll use the email address to send information and reminders about this jury service." on the page
	
	And I press the "Continue" button

	#Qualify for jury service
	When I see "Confirm if the person is eligible for jury service" on the page
	And I press the "Continue" button
	
	#Residency
	Then I see "Since they turned 13, has their main address been in the UK, Channel Islands or Isle of Man for any period of at least 5 years?" on the page
	When I see "Eligibility" on the page
	And I set the radio button to "Yes"
	And I press the "Continue" button
	
	#CJS
	Then I see "Has the person you're replying for worked in the criminal justice system in the last 5 years?" on the page
	
	And I do not see "Working in the Criminal Justice system does not stop a person doing jury service. But we may get in touch to find out more." on the page
    Then I click on the "Why do we ask this?" link
    And I see "Working in the Criminal Justice system does not stop a person doing jury service. But we may get in touch to find out more." on the page
    Then I click on the "Why do we ask this?" link
    
	And I do not see "Working in the Criminal Justice system does not stop a person doing jury service. But we may get in touch to find out more." on the page
	When I set the radio button to "No"
	And I press the "Continue" button
	
	#Bail
	Then I see "Is the person currently on bail for a criminal offence?" on the page
	And I set the radio button to "No"
	And I press the "Continue" button
	
	#Convictions
	Then I see "Has the person been found guilty of a criminal offence?" on the page
	When I set the radio button to "No"
	And I press the "Continue" button
	
	#Mental Health Sectioned
	Then I see "Is the person you're replying for being detained, looked after or treated under the Mental Health Act?" on the page
	And I set the radio button to "No"
	And I press the "Continue" button
	
	#Mental Health Capacity
	Then I see "Has it been decided that the person you're replying for 'lacks mental capacity'?" on the page
	And I set the radio button to "No"
	And I press the "Continue" button
	
	Then I see "Check your start date" on the page
	
	When I set the radio button to "No, they cannot do"  
	And I press the "Continue" button
	
	#Excusal Reason JDB-3653
	Then I see "Why do they need to be excused from jury service?" on the page
	And I set text area with "id" of "excusalReason" to "Excuse them please"
	
	Then I click on the "Will we need to provide evidence soon?" link
    And I see "If we need evidence, we'll contact you separately to tell you." on the page

	And I press the "Continue" button
	
	#RA
	Then I see "Will the person you're replying for need help when they're at the court?" on the page
	
	And I do not see "If you tell us the person you're replying for has an impairment or disability, we'll do all we can to help them and meet their needs in the court building when they do jury service." on the page
    Then I click on the "Why do we ask this?" link
    And I see "If you tell us the person you're replying for has an impairment or disability, we'll do all we can to help them and meet their needs in the court building when they do jury service." on the page
    Then I click on the "Why do we ask this?" link
    And I do not see "If you tell us the person you're replying for has an impairment or disability, we'll do all we can to help them and meet their needs in the court building when they do jury service." on the page
	
	When I set the radio button to "No"
	And I press the "Continue" button
	
	#Check Your Answers
	Then I see "Check your answers now" on the page
	
	When I check the "The answers I have given for the person I'm replying for are true as far as I know" checkbox
	And I press the "Submit" button
	And I see "You have completed your reply" on the page
	
Examples:
	|juror_number	|last_name			|postcode	|email       	    |pool_number| court |
	|644200230		|LNAMETWOSIXEIGHT	|CH1 2AN	|email@outlook.com	|442170501	| 415	|
	