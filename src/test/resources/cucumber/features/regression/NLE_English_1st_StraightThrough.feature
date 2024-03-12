Feature: Regression English_1st_StraightThrough


Scenario Outline: English 1st Party Straight Through
	
	Given I am on "Public" "juror-nle"
	
	And I set the radio button to "I am replying for myself"

	And I press the "Continue" button
	
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

	And I set the radio button to "Yes"
	
	When I press the "Continue" button
	
	Then on the page I see
		|text	|
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
	
	When I set "Enter your email address" to "e@mail.com"
	When I set "Enter your email address again" to "e@mail.com"
	And I press the "Continue" button

	Then on the page I see
		| text	|
		| Your details	|
		| What is your date of birth?	|
		| For example, 15 03 1982 |
		| Help with date of birth |

	When I set "Day" to "01"
	And I set "Month" to "01"
	And I set "Year" to "1990"
	And I press the "Continue" button

	#Qualify for jury service
	
	#JDB-4636
	
	And I see "steps/qualify" in the URL

	When I press the "Continue" button
	Then I see "Since you turned 13, has your main address been in the UK, Channel Islands or Isle of Man for any period of at least 5 years?" on the page
	
	#Residency
	
	And I set the radio button to "Yes"
	And I press the "Continue" button
	
	#CJS no
	
	When I set the radio button to "No"
	And I press the "Continue" button
	
	#Bail

	When I set the radio button to "No"
	And I press the "Continue" button
	
	#Convictions
	
	When I set the radio button to "No"
	And I press the "Continue" button
		
	#Mental Health Sectioned

	And I set the radio button to "No"
	And I press the "Continue" button
	
	#Mental Health Capacity

	And I set the radio button to "No"
	And I press the "Continue" button
	
	#I can attend

	And I set the radio button to "Yes, I can start on"
	And  I press the "Continue" button

	#RA no
	
	When I set the radio button to "No"
	And I press the "Continue" button
	Then I see "Check your answers now" on the page
	
	#Check your answers
	
	And I check the "The information I have given is true to the best of my knowledge" checkbox
	And I press the "Submit" button

	Then I click on the "Download a copy of your summons reply HTML (15KB)" link
	And I see "You answered the eligibility questions" on the page
	
	
Examples:
	|part_no	|last_name	|postcode	|email 					|pool_no	|
	|041510967	|LNAMEIFG	|CH7 1NN	|e@mail.com	|415220702	|
	

Scenario Outline: English 1st Party Excusal 

	Given I am on "Public" "juror-nle"
	
	Then I see "Reply to a jury summons" on the page

	And I set the radio button to "I am replying for myself"
	And I press the "Continue" button
	
	#Juror Log In
	
	When I set "9-digit juror number" to "<juror_number>"
	When I set "Juror last name" to "<last_name>"
	When I set "Juror postcode" to "<postcode>"
	And I press the "Continue" button
	
	#Check Name
	
	When I set the radio button to "Yes"
	When I press the "Continue" button
	
	#Check Address

	When I set the radio button to "Yes"
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
	
	Then I see "Confirm you're eligible for jury service" on the page
	When I press the "Continue" button
	
	#Residency

	When I set the radio button to "Yes"
	And I press the "Continue" button
	
	#CJS

	When I set the radio button to "No"
	And I press the "Continue" button
	
	#Bail
	
	When I set the radio button to "No"
	And I press the "Continue" button
	
	#Convictions

	When I set the radio button to "No"
	And I press the "Continue" button
	
	#Mental Health part 1
	
	When I set the radio button to "No"
	And I press the "Continue" button
	
	#Mental Health part 2
	
	When I set the radio button to "No"
	And I press the "Continue" button
	
	#Confirm Date of Jury
	
	Then I see "Check your start date" on the page
	When I set the radio button to "No, I cannot do jury service and need to be excused" 
	And I press the "Continue" button
	
	#Excusal Reason
	
	When I set text area with "id" of "excusalReason" to "Excuse me please"
	And I press the "Continue" button
	
	#RA
	
	When I set the radio button to "No"
	And I press the "Continue" button
	
	#Check Your Answers Now
	
	When I check the "The information" checkbox
	And I press the "Submit" button
	And I see "You have completed your reply" on the page
	
Examples:
	|part_no	|last_name	|postcode	|email           		|pool_no	|
	|041510923	|LNAMEIBC	|CH3 1NN	|e@mail.com	|415170401	|
	|041510918	|LNAMEIAH	|CH6 1NN	|e@mail.com	|415170401	|
	|041510899	|LNAMEHII	|CH3 1NN	|e@mail.com	|415170401	|
	|041510894	|LNAMEHID	|CH6 1NN	|e@mail.com	|415170401	|
	|041510886	|LNAMEHHF	|CH6 1NN	|e@mail.com	|415170401	|
	|041510879	|LNAMEHGI	|CH7 1NN	|e@mail.com	|415170401	|
	|041510876	|LNAMEHGF	|CH4 1NN	|e@mail.com	|415170401	|
	|041510859	|LNAMEHEI	|CH3 1NN	|e@mail.com	|415170401	|
	|041510808	|LNAMEHJH	|CH8 1NN	|e@mail.com	|415170401	|
	|041510796	|LNAMEGIF	|CH4 1NN	|e@mail.com	|415170401	|

@NLE
Scenario Outline: English 1st Party Deferral

	Given I am on "Public" "juror-nle"
	
	Then I see "Reply to a jury summons" on the page
	
	And I set the radio button to "I am replying for myself"
	And I press the "Continue" button
	
	When I set "9-digit juror number" to "<juror_number>"
	When I set "Juror last name" to "<last_name>"
	When I set "Juror postcode" to "<postcode>"
	And I press the "Continue" button

	And I set the radio button to "Yes"
	And I press the "Continue" button
	
	And I set the radio button to "Yes"
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
	And I set the radio button to "Yes"
	And I press the "Continue" button
	
	Then I see "Have you worked in the criminal justice system in the last 5 years?" on the page
	When I set the radio button to "No"
	And I press the "Continue" button

	And I see "Are you currently on bail for a criminal offence?" on the page
	When I set the radio button to "No"
	And I press the "Continue" button
	
	Then I see "Have you been found guilty of a criminal offence?" on the page
	When I set the radio button to "No"
	And I press the "Continue" button
	
	And I see "Are you being detained, looked after or treated under the Mental Health Act?" on the page
	When I set the radio button to "No"
	And I press the "Continue" button
	
	Then I see "Has it been decided that you 'lack mental capacity'?" on the page
	When I set the radio button to "No"
	And I press the "Continue" button
	
	Then I see "Check your start date" on the page
	When I set the radio button to "No, I need to change the date"
	And I press the "Continue" button
	
	When I set text area with "id" of "deferralReason" to "Deferral Reason"
	And I press the "Continue" button
	
	When I set input field with "id" of "date1Day" to "26"
	When I set input field with "id" of "date1Month" to "09"
	When I set input field with "id" of "date1Year" to "2022"
	When I set input field with "id" of "date2Day" to "03"
	When I set input field with "id" of "date2Month" to "10"
	When I set input field with "id" of "date2Year" to "2022"
	When I set input field with "id" of "date3Day" to "10"
	When I set input field with "id" of "date3Month" to "10"
	When I set input field with "id" of "date3Year" to "2022"
	
	And I press the "Continue" button
	
	#check dates screen
	
	And I see "Check your dates" on the page
	And I set the radio button to "Yes"
	And I press the "Continue" button

	Then I see "Will you need help when you're at the court?" on the page
	When I set the radio button to "No"
	And I press the "Continue" button
	
	Then I see "Check your answers now" on the page
	Then I check the "The information I have given is true to the best of my knowledge" checkbox
	When I press the "Submit" button
	
	Then I see "You have completed your reply" on the page
	Then I see "<juror_number>" on the page
	
Examples:
	|part_no	|pool_no	|last_name	|postcode	|email 					| 
#	|041510776	|415220702	|LNAMEGGF	|CH8 1NN	|e@mail.com	|
#	|041510700	|415220702	|LNAMEGJJ	|CH4 1NN	|e@mail.com	|
#	|041510696	|415220702	|LNAMEFIF	|CH8 1NN	|e@mail.com	|
#	|041510693	|415220702	|LNAMEFIC	|CH5 1NN	|e@mail.com	|
#	|041510643	|415220702	|LNAMEFDC	|CH3 1NN	|e@mail.com	|
#	|041510639	|415220702	|LNAMEFCI	|CH7 1NN	|e@mail.com	|
#	|041510638	|415220702	|LNAMEFCH	|CH6 1NN	|e@mail.com	|
	|041510572	|415220702	|LNAMEEGB	|CH4 1NN	|e@mail.com	|
#	|041510559	|415220702	|LNAMEEEI	|CH7 1NN	|e@mail.com	|
#	|041510542	|415220702	|LNAMEEDB	|CH6 1NN	|e@mail.com	|