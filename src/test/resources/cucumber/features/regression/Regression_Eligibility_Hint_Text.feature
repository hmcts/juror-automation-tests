Feature: Regression Eligibility Hint Text

@Regression 
Scenario Outline: English_1st_Eligibility_Hint_Text
	Given I am on "Public" "bau-test"
	Given the juror numbers have not been processed
		| part_no 	| pool_no 	| owner |
		| <part_no> |<pool_no>	| 400 	|
		
	And "<part_no>" has "LNAME" as "<last_name>" 
	And "<part_no>" has "RET_DATE" as "5 mondays time"
	And "<part_no>" has "NEXT_DATE" as "5 mondays time"
	And "<part_no>" has "ZIP" as "<postcode>"
	
	Then I see "Reply to a jury summons" on the page
	
	Then I see "Are you replying for yourself or for someone else?" on the page
	
	When I set the radio button to "I am replying for myself"
	And I press the "Continue" button
	Then I see "Your juror details" on the page
	
	When I set "9-digit juror number" to "<part_no>"
	When I set "Juror last name" to "<last_name>"
	When I set "Juror postcode" to "<postcode>"
	And I press the "Continue" button
	Then I see "Is the name we have for you correct?" on the page
	
	#Check name
	
	When I set the radio button to "Yes"
	When I press the "Continue" button
	Then I see "Is this your address?" on the page
	
	#Check address
	
	When I set the radio button to "Yes"
	When I press the "Continue" button
	Then I see "What is your phone number?" on the page
	
	#Phone details
	
	When I set "Main phone" to "0207 821 1818"
	And I press the "Continue" button
	Then I see "What is your email address?" on the page
	
	#Email details
	
	When I set "Enter your email address" to "email@outlook.com"
	And I set "Enter your email address again" to "email@outlook.com"
	And I press the "Continue" button
	Then I see "What is your date of birth?" on the page
	
	#DoB
	
	When I set "Day" to "27"
	And I set "Month" to "04"
	And I set "Year" to "1981"
	And I press the "Continue" button
	
	Then I see "Confirm you're eligible for jury service" on the page
	
	When I press the "Continue" button
	
	#Residency Yes
	
	Then I see "Since you turned 13, has your main address been in the UK, Channel Islands or Isle of Man for any period of at least 5 years?" on the page
	When I set the radio button to "Yes"
	
	#help text
	
	Then I click on the "Need help answering this?" link
	
	And on the page I see
	|text|
	|To be eligible for jury service, your main address must have been in one of the following for any period of at least 5 years:|
	|UK|
	|Channel Islands|
	|Isle of Man|
	|This period must have been after your 13th birthday.|
	|What counts as a 5 year period|
	|Your main address must have been here for at least 5 years in a row. You may have been working, studying, retired or unemployed.|
	|It does not matter if you went away on long trips or holidays abroad during this time, as long as your main address was here.|
	|Example|
	|From age 15 to 22, your main address was in the UK, Channel Islands or Isle of Man but, after that, you settled in another country.|
	|This counts as a 5 year period and makes you eligible for jury service.|
	|What does not count|
	|If you had a main address here for shorter periods that were not consecutive, these do not count.|
	|For example, you had a main address here for 2 years. Then at a much later point, you returned here for another 3 years, then we would not add these together.|
	|This would not count as a 5 year period and so you would not be eligible for jury service.|
	|If you're still not sure or you're waiting on a decision from UK Visas and Immigration|
	|You must contact us to get advice on your specific situation.|
	|Jury Central Summoning Bureau|
	|jurysummoning@justice.gov.uk|
	|Telephone: 0300 456 1024|
	|Monday to Thursday 9am to 5pm|
	|Friday 9am to 3pm|
	
	Then I click on the "Need help answering this?" link
	
	And I see "Need help answering this?" on the page
	And I do not see "To be eligible for jury service, your main address must have been in one of the following for any period of at least 5 years:" on the page

	And I press the "Continue" button
	
	#CJS no
	
	Then I see "Have you worked in the criminal justice system in the last 5 years?" on the page
	When I set the radio button to "No"
	And I press the "Continue" button
	
	#Bail no
	
	When I set the radio button to "No"
	And I press the "Continue" button
	
	#Convictions no

	When I set the radio button to "No"
	And I click on the "Guidance on jury service if you have a conviction" link
	
	And on the page I see
	|text|
	|When you can do jury service|
	|You can do jury service if you've:|
	|had a speeding fine|
	|had points on your driving license|
	|been told to attend a speed awareness course|
	|This applies as long as you did not receive any of the sentences below.|
	|When you cannot do jury service|
	|You cannot do jury service if you've ever had one of the criminal sentences below in the UK, Channel Islands or Isle of Man.|
	|You also cannot do jury service if you've had one of these criminal sentences for a service offence under the Armed Forces Act 2006 anywhere in the world:|
	|imprisonment or detention for 5 years or more|
	|imprisonment for public protection or detention for public protection|
	|imprisonment, custody or detention for life|
	|an extended sentence under either of sections 226A, 226B, 227 or 228 of the Criminal Justice Act 2003, (including such a sentence imposed as a result of section 219A, 220, 221A or 222 of the Armed Forces Act 2006) or section 210A of the Criminal Procedure (Scotland) Act 1995|
	|detention at His Majesty's pleasure or during the pleasure of the Secretary of State|
	|You also cannot do jury service if you've had one of these criminal sentences in the last 10 years:|
	|you served any part of a sentence of imprisonment or detention|
	|you received a suspended sentence of imprisonment or a suspended order for detention|
	|You also cannot do jury service if, in the last 10 years in England and Wales, you've had a community order, including any of the following:|
	|community rehabilitation order|
	|community punishment order|
	|community punishment and rehabilitation order|
	|drug treatment and testing order|
	|drug abstinence order|
	|You also cannot do jury service if, in the last 10 years, you've had:|
	|any similar order under the law of Scotland, Northern Ireland, Isle of Man or any of the Channel Islands|
	|a community or overseas community order under the Armed Forces Act 2006|
	|If you serve on a jury when you know you should not because of a criminal conviction, you may be fined up to £5,000.|
	
	And I click on the "Guidance on jury service if you have a conviction" link
	
	And I do not see "When you can do jury service" on the page
	
	And I set the radio button to "Yes"
	
	And on the page I see
	|text|
	|For each conviction, give details of:|
	|the offence or offences you committed|
	|when this happened|
	|where you were convicted|
	|length of sentence|
	
	And I set the radio button to "No"
	
	And I press the "Continue" button
	
	#Mental health part 1 no

	When I set the radio button to "No"
	And I press the "Continue" button
	
	#Mental health part 2 no

	When I set the radio button to "No"
	And I press the "Continue" button
	
	#I can attend
	
	Then I see "Check your start date" on the page
	When I set the radio button to "Yes, I can start on"
	And  I press the "Continue" button
	
	#RA no
	
	Then I see "Will you need help when you're at the court?" on the page
	When I set the radio button to "No"
	And I press the "Continue" button
	
	#Check Your Answers
	
	Then I see "Check your answers now" on the page
	
	#When I press the "Submit" button
	
	When I check the "The information I have given is true to the best of my knowledge" checkbox
	And I press the "Submit" button
	Then I see "We have sent you an email to say you have replied to your jury summons." on the page
	
Examples:
	|part_no	|last_name			|postcode	|email           	|pool_no	|
	|645100224	|LNAMENINEFOURTWO	|SW1H 9AJ	|email@outlook.com	|451170401	|

@Regression 
Scenario Outline: English_3rd_Eligibility_Hint_Text
	Given I am on "Public" "bau-test"
	Given the juror numbers have not been processed
		| part_no 	| pool_no 	| owner |
		| <part_no> |<pool_no>	| 400 	|
	
	And "<part_no>" has "LNAME" as "<last_name>" 
	And "<part_no>" has "RET_DATE" as "5 mondays time"
	And "<part_no>" has "NEXT_DATE" as "5 mondays time"
	And "<part_no>" has "ZIP" as "<postcode>"
	
	Then I see "Reply to a jury summons" on the page
	
	Then I see "Are you replying for yourself or for someone else?" on the page

	When I set the radio button to "I am replying for someone else"
	And I press the "Continue" button
	
	When I set "9-digit juror number" to "<part_no>"
	When I set "Juror last name" to "<last_name>"
	When I set "Juror postcode" to "<postcode>"
	And I press the "Continue" button
	Then I see "What is your name?" on the page
	
	#Third Party Name

	When I set "First name" to "FirstName"
	And I set "Last name" to "LastName"
	And I press the "Continue" button
	Then I see "Your relationship to the person" on the page
	
	#Third Party Relationship

	When I set "How do you know the person you're replying for?" to "Friend"
	And I press the "Continue" button
	Then I see "Your contact information" on the page
	
	#3rd Party Contact

	And I check the "By phone" checkbox
	When I set "Main phone" to "02078211818"
	And I check the "By email" checkbox
	And I set "Enter your email address" to "email@outlook.com"
	And I set "Enter your email address again" to "email@outlook.com"
	And I press the "Continue" button
	Then I see "Why are you replying for the other person?" on the page
	
	#Why Replying

	When I set the radio button to "The person is not here"
	And I press the "Continue" button
	Then I see "Is the name we have for them correct?" on the page

	#Check Juror Name

	When I set the radio button to "Yes"
	And I press the "Continue" button
	Then I see "Is this their address?" on the page
	
	#Check address
	
	When I set the radio button to "Yes"
	And I press the "Continue" button
	Then I see "Give the date of birth for the person you're replying for" on the page
	
	#Juror DoB
	
	When I set "Day" to "27"
	And I set "Month" to "04"
	And I set "Year" to "1981"
	And I press the "Continue" button
	Then I see "We might need to get in touch with the person to ask them more questions or give them information about their jury service" on the page
	
	#Contacting the Juror
	
	When I set the radio button to "Use the phone number that you have already given to contact you"
	And I set the radio button to "Use the email address that you have already given to contact you"
	And I press the "Continue" button
	
	#Eligibility
	
	Then I see "Confirm if the person is eligible for jury service" on the page
	
	When I press the "Continue" button
	
	#Residency Yes
	
	Then I see "Since they turned 13, has their main address been in the UK, Channel Islands or Isle of Man for any period of at least 5 years?" on the page
	When I set the radio button to "Yes"
	
	#help text
	
	Then I click on the "Need help answering this?" link
	
	And I see "To be eligible for jury service, their main address must have been in one of the following for any period of at least 5 years:" on the page
	
	And on the page I see
	|text|
	|UK|
	|Channel Islands|
	|Isle of Man|
	|This period must have been after their 13th birthday.|
	|What counts as a 5 year period|
	|Their main address must have been here for at least 5 years in a row. They may have been working, studying, retired or unemployed.|
	|It does not matter if they went away on long trips or holidays abroad during this time, as long as their main address was here.|
	|Example|
	|From age 15 to 22, their main address was in the UK, Channel Islands or Isle of Man but, after that, they settled in another country.|
	|This counts as a 5 year period and makes them eligible for jury service.|
	|What does not count|
	|If they had a main address here for shorter periods that were not consecutive, these do not count.|
	|For example, they had a main address here for 2 years. Then at a much later point, they returned here for another 3 years, then we would not add these together.|
	|This would not count as a 5 year period and so they would not be eligible for jury service.|
	|If you're still not sure or they're waiting on a decision from UK Visas and Immigration|
	|You must contact us to get advice on their specific situation.|
	|Jury Central Summoning Bureau|
	|jurysummoning@justice.gov.uk|
	|Telephone: 0300 456 1024|
	|Monday to Thursday 9am to 5pm|
	|Friday 9am to 3pm|

	And I press the "Continue" button
	
	#CJS no
	
	Then I see "Has the person you're replying for worked in the criminal justice system in the last 5 years?" on the page
	When I set the radio button to "No"
	And I press the "Continue" button
	
	#Bail no

	When I set the radio button to "No"
	And I press the "Continue" button
	
	#Convictions no
	
	When I set the radio button to "No"
	And I click on the "Guidance on jury service if you have a conviction" link
	
	And on the page I see
	|text|
	|When they can do jury service|
	|They can do jury service if they've:|
	|had a speeding fine|
	|had points on their driving license|
	|been told to attend a speed awareness course|
	|This applies as long as they did not receive any of the sentences below.|
	|When they cannot do jury service|
	|They cannot do jury service if they've ever had one of the criminal sentences below in the UK, Channel Islands or Isle of Man. They also cannot do jury service if they've had one of these criminal sentences for a service offence under the Armed Forces Act 2006 anywhere in the world:|
	|imprisonment or detention for 5 years or more|
	|imprisonment for public protection or detention for public protection|
	|imprisonment, custody or detention for life|
	|an extended sentence under either of sections 226A, 226B, 227 or 228 of the Criminal Justice Act 2003, (including such a sentence imposed as a result of section 219A, 220, 221A or 222 of the Armed Forces Act 2006) or section 210A of the Criminal Procedure (Scotland) Act 1995|
	|detention at His Majesty's pleasure or during the pleasure of the Secretary of State|
	|They also cannot do jury service if they've had one of these criminal sentences in the last 10 years:|
	|they served any part of a sentence of imprisonment or detention|
	|they received a suspended sentence of imprisonment or a suspended order for detention|
	|They also cannot do jury service if, in the last 10 years in England and Wales, they've had a community order, including any of the following:|
	|community rehabilitation order|
	|community punishment order|
	|community punishment and rehabilitation order|
	|drug treatment and testing order|
	|drug abstinence order|
	|They also cannot do jury service if, in the last 10 years, they've had:|
	|any similar order under the law of Scotland, Northern Ireland, Isle of Man or any of the Channel Islands|
	|a community or overseas community order under the Armed Forces Act 2006|
	|If someone serves on a jury when they know they should not because of a criminal conviction, they may be fined up to £5,000.|
	
	And I click on the "Guidance on jury service if you have a conviction" link
	
	And I do not see "When they can do jury service" on the page
	
	And I set the radio button to "Yes"
	
	And on the page I see
	|text|
	|For each conviction, give details of:|
	|the offence or offences they committed|
	|when this happened|
	|where they were convicted|
	|length of sentence|
	
	And I set the radio button to "No"
	
	And I press the "Continue" button
	
	#Mental health part 1 no
	
	When I set the radio button to "No"
	And I press the "Continue" button
	
	#Mental health part 2 no

	When I set the radio button to "No"
	And I press the "Continue" button
	
	#I can attend
	
	Then I see "Check your start date" on the page
	Then I set the radio button to "Yes, they can start on"
	And  I press the "Continue" button
	
	#RA no
	
	Then I see "Will the person you're replying for need help when they're at the court?" on the page
	When I set the radio button to "No"
	And I press the "Continue" button
	
	Then I see "Check your answers now" on the page
	
	#Check Your Answers
	
	Then I see "Check your answers now" on the page
	
	#When I press the "Submit" button
	
	When I check the "The answers I have given for the person I'm replying for are true as far as I know." checkbox
	And I press the "Submit" button
	Then I see "We have sent an email to say you have replied to this jury summons." on the page
	
Examples:
	|part_no		|last_name			|postcode	|email           	|pool_no	|
	|645100912		|LNAMENINEEIGHTTWO	|SW1H 9AJ	|email@outlook.com	|451170401	|	