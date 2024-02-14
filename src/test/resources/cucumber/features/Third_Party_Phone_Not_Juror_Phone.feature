Feature: Third_Party_Phone_Not_Juror_Phone

@Regression @JDB-3614 
Scenario Outline: English 3rd Party Gives Phone and Juror Email
	Given I am on "Public" "juror-test02"
	Given the juror numbers have not been processed
		| part_no 	| pool_no 	| owner |
		| <part_no> |<pool_no>	| 400 	|
		
	And "<part_no>" has "LNAME" as "<last_name>" 
	And "<part_no>" has "RET_DATE" as "5 mondays time"
	And "<part_no>" has "NEXT_DATE" as "5 mondays time"
	And "<part_no>" has "ZIP" as "<postcode>"
	
	Then I see "Reply to a jury summons" on the page
	
	And I set the radio button to "I am replying for someone else"
	And I press the "Continue" button
	Then I see "Their juror details" on the page
	
	#Juror Log In
	
	When I set "9-digit juror number" to "<part_no>"
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
	And I press the "Continue" button
	
	#Why are you replying title
	
	Then I see "Why are you replying for the other person?" on the page
	And I do not see "Why are you replying?" on the page
	
	#Why are you replying for the person?
	
	When I set the radio button to "The person is not here"
	And I press the "Continue" button
	Then I see "Is the name we have for them correct?" on the page
	
	#Check juror name
	
	When I set the radio button to "Yes"
	And I press the "Continue" button
	Then I see "Is this their address?" on the page
	
	#Check juror address
	
	When I set the radio button to "Yes"
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
	And I set the radio button to "Give a different email address for the juror"
	And I set "Enter email address" to "JurorEmail@outlook.com"
	And I set "Enter the email address again" to "JurorEmail@outlook.com"
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
	When I set the radio button to "No"
	And I press the "Continue" button
	
	#Bail
	
	Then I see "Is the person currently on bail for a criminal offence?" on the page
	When I see "Eligibility" on the page
	And I set the radio button to "No"
	And I press the "Continue" button
	
	#Convictions
	
	Then I see "Has the person been found guilty of a criminal offence?" on the page
	When I see "Eligibility" on the page
	When I set the radio button to "No"
	And I press the "Continue" button
	
	#Mental Health Sectioned
	
	Then I see "Is the person you're replying for being detained, looked after or treated under the Mental Health Act?" on the page
	When I see "Eligibility" on the page
	And I set the radio button to "No"
	And I press the "Continue" button
	
	#Mental Health Capacity
	
	Then I see "Has it been decided that the person you're replying for 'lacks mental capacity'?" on the page
	When I see "Eligibility" on the page
	And I set the radio button to "No"
	And I press the "Continue" button
	
	#The person can attend
	
	Then I see "Check your start date" on the page
	Then I set the radio button to "Yes, they can start on"
	And  I press the "Continue" button
	
	#RA no
	
	Then I see "Will the person you're replying for need help when they're at the court?" on the page
	When I set the radio button to "No"
	And I press the "Continue" button
	
	#Check your answers
	
	Then I see "Check your answers now" on the page
	When I see text "JurorEmail@outlook.com" in the same row as "Email"
	And I see text "0207 821 1818" in the same row as "Your main phone number"
	And I check the "The answers I have given for the person I'm replying for are true as far as I know." checkbox
	And I press the "Submit" button
	
	#When I press the "Submit" button
	
	Then I see "We have sent an email to say you have replied to this jury summons." on the page
	
	#Bureau
	
	Given I am on "Bureau" "juror-test02"	
	And I log in as "SYSTEM"
	
	When I click on the "Search" link
	And I set "Juror number" to "<part_no>"
	And I press the "Search" button
	And I click on "<part_no>" in the same row as "<part_no>"
	Then I see "641500189" on the page
	
	#Check that TP phone only appears for TP and juror email only appears for juror
	
	When I see "" in the same row as "Main Phone"
	And I see "JurorEmail@outlook.com" in the same row as "Email"
	And I see "0207 821 1818" in the same row as "Third party primary phone"
	And I see "" in the same row as "Third party email"
	
Examples:
	|part_no	|last_name	|postcode	|email            |pool_no		|
	|641500189	|DOE		|SW1H 9AJ	|email@outlook.com|415170401	|
	

@Regression_Single @JDB-3614 
Scenario Outline: English 3rd Party Gives Email and Juror Phone
	Given I am on "Public" "juror-test02"
	Given the juror numbers have not been processed
		| part_no 	| pool_no 	| owner |
		| <part_no> |<pool_no>	| 400 	|
	
	And "<part_no>" has "LNAME" as "<last_name>" 
	And "<part_no>" has "RET_DATE" as "5 mondays time"
	And "<part_no>" has "NEXT_DATE" as "5 mondays time"
	And "<part_no>" has "ZIP" as "<postcode>"
	
	Then I see "Reply to a jury summons" on the page
	
	And I set the radio button to "I am replying for someone else"
	And I press the "Continue" button
	Then I see "Their juror details" on the page
	
	#Juror Log In
	
	When I set "9-digit juror number" to "<part_no>"
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
	And I check the "By email" checkbox
	And I set "Enter your email address" to "TPEmail@outlook.com"
	And I set "Enter your email address again" to "TPEmail@outlook.com"
	And I press the "Continue" button
	
	#Why are you replying title
	
	Then I see "Why are you replying for the other person?" on the page
	And I do not see "Why are you replying?" on the page
	
	#Why are you replying for the person?
	
	When I set the radio button to "The person is not here"
	And I press the "Continue" button
	Then I see "Is the name we have for them correct?" on the page
	
	#Check juror name
	
	When I see "Juror Details" on the page
	And I set the radio button to "Yes"
	And I press the "Continue" button
	Then I see "Is this their address?" on the page
	
	#Check juror address
	
	When I see "Juror Details" on the page
	And I set the radio button to "Yes"
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
	And I set the radio button to "Give a different phone number for the juror"
	And I set "Main phone number" to "0207 821 4545"
	And I set the radio button to "Use the email address that you have already given to contact you"
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
	When I set the radio button to "No"
	And I press the "Continue" button
	
	#Bail
	
	Then I see "Is the person currently on bail for a criminal offence?" on the page
	When I see "Eligibility" on the page
	And I set the radio button to "No"
	And I press the "Continue" button
	
	#Convictions
	
	Then I see "Has the person been found guilty of a criminal offence?" on the page
	When I see "Eligibility" on the page
	When I set the radio button to "No"
	And I press the "Continue" button
	
	#Mental Health Sectioned
	
	Then I see "Is the person you're replying for being detained, looked after or treated under the Mental Health Act?" on the page
	When I see "Eligibility" on the page
	And I set the radio button to "No"
	And I press the "Continue" button
	
	#Mental Health Capacity
	
	Then I see "Has it been decided that the person you're replying for 'lacks mental capacity'?" on the page
	When I see "Eligibility" on the page
	And I set the radio button to "No"
	And I press the "Continue" button
	
	#The person can attend
	
	Then I see "Check your start date" on the page
	Then I set the radio button to "Yes, they can start on"
	And  I press the "Continue" button
	
	#RA no
	
	Then I see "Will the person you're replying for need help when they're at the court?" on the page
	When I set the radio button to "No"
	And I press the "Continue" button
	
	#Check your answers
	
	Then I see "Check your answers now" on the page
	When I see text "0207 821 4545" in the same row as "Main phone"
	And I see text "TPEmail@outlook.com" in the same row as "Your email address"
	And I check the "The answers I have given for the person I'm replying for are true as far as I know." checkbox
	And I press the "Submit" button
	
	#When I press the "Submit" button
	
	Then I see "We have sent an email to say you have replied to this jury summons." on the page
	
	#Bureau
	
	Given I am on "Bureau" "juror-test02"	
	And I log in as "SYSTEM"
	
	When I click on the "Search" link
	And I set "Juror number" to "<part_no>"
	And I press the "Search" button
	And I click on "<part_no>" in the same row as "<part_no>"
	Then I see "641500725" on the page
	
	#Check that TP email only appears for TP and juror phone only appears for juror
	
	When I see "0207 821 4545" in the same row as "Main Phone"
	And I see "" in the same row as "Email"
	And I see "TPEmail@outlook.com" in the same row as "Third party email"
	And I see "" in the same row as "Third party primary phone"
	
Examples:
	|part_no	|last_name	|postcode	|email            |pool_no	|
	|641500725	|DOE		|SW1H 9AJ	|email@outlook.com|415170401|
	
@Regression @JDB-4241 
Scenario Outline: English 3rd Party cannot proceed with response with missing phone
	Given I am on "Public" "juror-test02"
	Given the juror numbers have not been processed
		| part_no 	| pool_no 	| owner |
		| <part_no> |<pool_no>	| 400 	|
		
	And "<part_no>" has "LNAME" as "<last_name>" 
	And "<part_no>" has "RET_DATE" as "5 mondays time"
	And "<part_no>" has "NEXT_DATE" as "5 mondays time"
	And "<part_no>" has "ZIP" as "<postcode>"
	
	Then I see "Reply to a jury summons" on the page
	
	And I set the radio button to "I am replying for someone else"
	And I press the "Continue" button
	Then I see "Their juror details" on the page
	
	#Juror Log In
	
	When I set "9-digit juror number" to "<part_no>"
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
	And I check the "By email" checkbox
	And I set "Enter your email address" to "TPEmail@outlook.com"
	And I set "Enter your email address again" to "TPEmail@outlook.com"
	And I press the "Continue" button
	
	#Why are you replying title
	
	Then I see "Why are you replying for the other person?" on the page
	And I do not see "Why are you replying?" on the page
	
	#Why are you replying for the person?
	
	When I set the radio button to "The person is not here"
	And I press the "Continue" button
	Then I see "Is the name we have for them correct?" on the page
	
	#Check juror name
	
	When I set the radio button to "Yes"
	And I press the "Continue" button
	Then I see "Is this their address?" on the page
	
	#Check juror address
	
	When I set the radio button to "Yes"
	And I press the "Continue" button
	Then I see "Give the date of birth for the person you're replying for" on the page
	
	#DoB
	
	And I set "Day" to "01"
	And I set "Month" to "01"
	
	#JDB-3418 Checking age 18 works
	
	And I set "Year" to "2000"
	And I press the "Continue" button
	Then I see "We might need to get in touch with the person to ask them more questions or give them information about their jury service" on the page
	
	#Contacting the juror
	
	When I see "Juror Details" on the page
	And I set the radio button to "Use the email address that you have already given to contact you"
	And I press the "Continue" button
	Then I see "There is a problem" on the page
	And I see "Select a phone number for us to use to contact you or the juror" on the page
	
	When I set the radio button to "Use the phone number that you have already given to contact you"
	And I press the "Continue" button
	Then I see "You have not provided any phone number information. Please select the other option." on the page
	
	When I set the radio button to "Give a different phone number for the juror"
	And I set "Main phone number" to "0207 821 1818"
	And I press the "Continue" button
	Then I see "Confirm if the person is eligible for jury service" on the page
	
Examples:
	|part_no	|last_name	|postcode	|email            |pool_no	|
	|641500580	|DOE		|SW1H 9AJ	|email@outlook.com|415170401|
	
@Regression @JDB-4241
Scenario Outline: English 3rd Party cannot proceed with response with missing email
	Given I am on "Public" "juror-test02"
	Given the juror numbers have not been processed
		|part_no 	|pool_no 	|owner 	|
		|<part_no> 	|<pool_no>	|400 	|
	
	And "<part_no>" has "LNAME" as "<last_name>" 
	And "<part_no>" has "RET_DATE" as "5 mondays time"
	And "<part_no>" has "NEXT_DATE" as "5 mondays time"
	And "<part_no>" has "ZIP" as "<postcode>"
	
	Then I see "Reply to a jury summons" on the page
	
	And I set the radio button to "I am replying for someone else"
	And I press the "Continue" button
	Then I see "Their juror details" on the page
	
	#Juror Log In
	
	When I set "9-digit juror number" to "<part_no>"
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
	And I set "Main phone" to "02078211818"
	And I press the "Continue" button
	
	#Why are you replying title
	
	Then I see "Why are you replying for the other person?" on the page
	And I do not see "Why are you replying?" on the page
	
	#Why are you replying for the person?
	
	When I set the radio button to "The person is not here"
	And I press the "Continue" button
	Then I see "Is the name we have for them correct?" on the page
	
	#Check juror name
	
	When I see "Juror Details" on the page
	And I set the radio button to "Yes"
	And I press the "Continue" button
	Then I see "Is this their address?" on the page
	
	#Check juror address
	
	When I see "Juror Details" on the page
	And I set the radio button to "Yes"
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
	And I press the "Continue" button
	Then I see "There is a problem" on the page
	And I see "Select an email address for us to use to contact you or the juror" on the page
	
	When I set the radio button to "Use the email address that you have already given to contact you"
	And I press the "Continue" button
	Then I see "You have not provided any email address information. Please select the other option." on the page
	
	When I set the radio button to "Give a different email address for the juror"
	And I set "Enter email address" to "email@outlook.com"
	And I set "Enter the email address again" to "email@outlook.com"
	And I press the "Continue" button
	Then I see "Confirm if the person is eligible for jury service" on the page
	
Examples:
	|part_no	|last_name	|postcode	|email            |pool_no		|
	|641500584	|DOE		|SW1H 9AJ	|email@outlook.com|415170401	|