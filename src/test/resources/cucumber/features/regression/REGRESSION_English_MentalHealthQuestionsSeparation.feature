Feature: Regression 1st_MentalHealthQuestionsSeparation

@Regression
Scenario Outline: 1st party MHQ1=Y MHQ2=Y
	
	Given I am on "Public" "ithc"

	Given a bureau owned pool is created with jurors
		| court |juror_number  | pool_number	| att_date_weeks_in_future	| owner |
		| 452   |<juror_number>| <pool_number>	| 5				            | 400	|
		
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
	When I choose the "Yes" radio button
	
	#Check Name
	And I press the "Continue" button
	Then I see "Is this your address?" on the page
	When I choose the "Yes" radio button
	
	#Check Address
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
	Then I see "eligible for jury service" on the page
	
	When I press the "Continue" button
	Then I see "Since you turned 13, has your main address been in the UK, Channel Islands or Isle of Man for any period of at least 5 years?" on the page
	
	#Residency
	When I choose the "Yes" radio button
	And I press the "Continue" button
	
	Then I see "Have you worked in the criminal justice system in the last 5 years?" on the page
		
	#CJS no
	When I choose the "No" radio button
	And I press the "Continue" button
	
	Then I see "Are you currently on bail for a criminal offence?" on the page
		
	#Bail
	And I choose the "No" radio button
	And I press the "Continue" button
	
	Then I see "Have you been found guilty of a criminal offence?" on the page
	
	#Convictions
	When I choose the "No" radio button
	And I press the "Continue" button
	
	#Mental Health part 1
	When I choose the "Yes" radio button
	And I set "Provide details about how you're being detained, looked after or treated under the Mental Health Act" to "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede mollis pretium. Integer tincidunt. Cras dapibus. Vivamus elementum semper nisi. Aenean vulputate eleifend tellus. Aenean leo ligula, porttitor eu, consequat vitae, eleifend ac, enim. Aliquam lorem ante, dapibus in, viverra quis, feugiat a, tellus. Phasellus viverra nulla ut metus varius laoreet. Quisque rutrum. Aenean imperdiet. Etiam ultricies nisi vel augue. Curabitur ullamcorper ultricies nisi. Nam eget dui. Etiam rhoncus. Maecenas tempus, tellus eget condimentum rhoncus, sem quam semper libero, sit amet adipiscing sem neque sed ipsum. N"
	And I press the "Continue" button
	
	#Mental Health part 2
	When I choose the "Yes" radio button
	And I set "Provide brief details about why it was decided you lack mental capacity" to "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede mollis pretium. Integer tincidunt. Cras dapibus. Vivamus elementum semper nisi. Aenean vulputate eleifend tellus. Aenean leo ligula, porttitor eu, consequat vitae, eleifend ac, enim. Aliquam lorem ante, dapibus in, viverra quis, feugiat a, tellus. Phasellus viverra nulla ut metus varius laoreet. Quisque rutrum. Aenean imperdiet. Etiam ultricies nisi vel augue. Curabitur ullamcorper ultricies nisi. Nam eget dui. Etiam rhoncus. Maecenas tempus, tellus eget condimentum rhoncus, sem quam semper libero, sit amet adipiscing sem neque sed ipsum. N"
	And I press the "Continue" button
	
	Then I see "Check your start date" on the page
	
	#I can attend
	And I see "Yes, I can start on" on the page
	When I set the radio button to "Yes, I can start on"
	And  I press the "Continue" button	

	Then I see "Will you need help when you're at the court?" on the page
	
	#RA no
	When I choose the "No" radio button
	And I press the "Continue" button
	Then I see "Check your answers now" on the page
	
	#Check your answers
	And I check the "The information I have given is true to the best of my knowledge" checkbox
	And I press the "Submit" button
	
	#When I press the "Submit" button
	Then I see "We have sent you an email to say you have replied to your jury summons." on the page

	#Bureau
	Given I am on "Bureau" "ithc"
	And I log in as "MODTESTBUREAU"

	When I click on the "Search" link
	And I set "Juror number" to "<juror_number>"
	And I press the "Search" button
	And I click on "<juror_number>" in the same row as "<juror_number>"
	
	When I click on the "Eligibility" link
	Then I see "Attention" on the page
	And I see "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede mollis pretium. Integer tincidunt. Cras dapibus. Vivamus elementum semper nisi. Aenean vulputate eleifend tellus. Aenean leo ligula, porttitor eu, consequat vitae, eleifend ac, enim. Aliquam lorem ante, dapibus in, viverra quis, feugiat a, tellus. Phasellus viverra nulla ut metus varius laoreet. Quisque rutrum. Aenean imperdiet. Etiam ultricies nisi vel augue. Curabitur ullamcorper ultricies nisi. Nam eget dui. Etiam rhoncus. Maecenas tempus, tellus eget condimentum rhoncus, sem quam semper libero, sit amet adipiscing sem neque sed ipsum. N" on the page
	And I see "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede mollis pretium. Integer tincidunt. Cras dapibus. Vivamus elementum semper nisi. Aenean vulputate eleifend tellus. Aenean leo ligula, porttitor eu, consequat vitae, eleifend ac, enim. Aliquam lorem ante, dapibus in, viverra quis, feugiat a, tellus. Phasellus viverra nulla ut metus varius laoreet. Quisque rutrum. Aenean imperdiet. Etiam ultricies nisi vel augue. Curabitur ullamcorper ultricies nisi. Nam eget dui. Etiam rhoncus. Maecenas tempus, tellus eget condimentum rhoncus, sem quam semper libero, sit amet adipiscing sem neque sed ipsum. N" on the page
	And I do not see "[MENTAL HEALTH Q2]" on the page

Examples:
	| juror_number	| last_name			| postcode	| email            | pool_number|
	| 045200097		| LNAMEFIVETHREEZERO| CH1 2AN	| email@outlook.com| 452300096	|
	
@Regression
Scenario Outline: 1st party MHQ1=Y MHQ2=N
	
	Given I am on "Public" "ithc"

	Given a bureau owned pool is created with jurors
		| court |juror_number  | pool_number	| att_date_weeks_in_future	| owner |
		| 452   |<juror_number>| <pool_number>	| 5				            | 400	|
		
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
	When I choose the "Yes" radio button
	
	#Check Name
	And I press the "Continue" button
	Then I see "Is this your address?" on the page
	When I choose the "Yes" radio button
	
	#Check Address
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
	Then I see "eligible for jury service" on the page
	
	When I press the "Continue" button
	Then I see "Since you turned 13, has your main address been in the UK, Channel Islands or Isle of Man for any period of at least 5 years?" on the page
	
	#Residency
	When I choose the "Yes" radio button
	And I press the "Continue" button
	
	Then I see "Have you worked in the criminal justice system in the last 5 years?" on the page
	
	#CJS no
	When I choose the "No" radio button
	And I press the "Continue" button
	
	Then I see "Are you currently on bail for a criminal offence?" on the page
		
	#Bail
	And I choose the "No" radio button
	And I press the "Continue" button
	
	Then I see "Have you been found guilty of a criminal offence?" on the page
	
	#Convictions
	When I choose the "No" radio button
	And I press the "Continue" button
	
	#Mental Health part 1
	When I choose the "Yes" radio button
	And I set "Provide details" to "I am sectioned"
	And I press the "Continue" button
	
	#Mental Health part 2
	When I choose the "No" radio button
	And I press the "Continue" button
		
	Then I see "Check your start date" on the page
	
	#I can attend
	And I see "Yes, I can start on" on the page
	When I set the radio button to "Yes, I can start on"
	And  I press the "Continue" button
	
	Then I see "Will you need help when you're at the court?" on the page
	
	#RA no
	When I choose the "No" radio button
	And I press the "Continue" button
	Then I see "Check your answers now" on the page
	
	#Check your answers
	And I check the "The information I have given is true to the best of my knowledge" checkbox
	And I press the "Submit" button
	
	#When I press the "Submit" button
	Then I see "We have sent you an email to say you have replied to your jury summons." on the page

	#Bureau
	Given I am on "Bureau" "ithc"
	And I log in as "MODTESTBUREAU"

	When I click on the "Search" link
	And I set "Juror number" to "<juror_number>"
	And I press the "Search" button
	And I click on "<juror_number>" in the same row as "<juror_number>"
	
	When I click on the "Eligibility" link
	Then "Mental health act" is marked as requiring attention
	And I see "I am sectioned" on the page
	And I do not see "I lack capacity" on the page
	And I do not see "[MENTAL HEALTH Q2]" on the page

Examples:
	| juror_number	| last_name			| postcode	| email            | pool_number|
	| 045200098		| LNAMESIXZEROSEVEN	| CH1 2AN	| email@outlook.com| 452300097	|
	
@Regression
Scenario Outline: 1st party MHQ1=N MHQ2=Y
	
	Given I am on "Public" "ithc"

	Given a bureau owned pool is created with jurors
		| court |juror_number  | pool_number	| att_date_weeks_in_future	| owner |
		| 452   |<juror_number>| <pool_number>	| 5				            | 400	|
		
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
	And I choose the "Yes" radio button
	And I press the "Continue" button
	
	Then I see "Is this your address?" on the page
	
	#Check Address
	And I choose the "Yes" radio button
	And I press the "Continue" button
	
	#Phone Details
	When I set "Main phone" to "0207 821 1818"
	And I press the "Continue" button

	#Email
	When I set "Enter your email address" to "email@outlook.com"
	And I set "Enter your email address again" to "email@outlook.com"
	And I press the "Continue" button
	
	#DoB
	When I set "Day" to "27"
	And I set "Month" to "04"
	And I set "Year" to "1981"
	And I press the "Continue" button
	Then I see "eligible for jury service" on the page
	
	When I press the "Continue" button
	Then I see "Since you turned 13, has your main address been in the UK, Channel Islands or Isle of Man for any period of at least 5 years?" on the page
	
	#Residency
	When I choose the "Yes" radio button
	And I press the "Continue" button
	
	Then I see "Have you worked in the criminal justice system in the last 5 years?" on the page
	
	#CJS no
	When I choose the "No" radio button
	And I press the "Continue" button
	
	Then I see "Are you currently on bail for a criminal offence?" on the page
		
	#Bail
	And I choose the "No" radio button
	And I press the "Continue" button
	
	Then I see "Have you been found guilty of a criminal offence?" on the page
	
	#Convictions
	When I choose the "No" radio button
	And I press the "Continue" button
	
	#Mental Health part 1
	When I choose the "No" radio button
	And I press the "Continue" button
	
	#Mental Health part 2
	When I choose the "Yes" radio button
	And I set "Provide brief details about why it was decided you lack mental capacity" to "I lack capacity"
	And I press the "Continue" button
	
	Then I see "Check your start date" on the page
	
	#I can attend
	And I see "Yes, I can start on" on the page
	When I choose the "Yes" radio button
	And  I press the "Continue" button
	
	Then I see "Will you need help when you're at the court?" on the page
	
	#RA no
	When I choose the "No" radio button
	And I press the "Continue" button
	Then I see "Check your answers now" on the page
	
	#Check your answers
	And I check the "The information I have given is true to the best of my knowledge" checkbox
	And I press the "Submit" button
	
	#When I press the "Submit" button
	Then I see "We have sent you an email to say you have replied to your jury summons." on the page

	#Bureau
	Given I am on "Bureau" "ithc"
	And I log in as "MODTESTBUREAU"

	When I click on the "Search" link
	And I set "Juror number" to "<juror_number>"
	And I press the "Search" button
	And I click on "<juror_number>" in the same row as "<juror_number>"
	
	When I click on the "Eligibility" link
	Then "Mental health act" is marked as requiring attention
	And I do not see "I am sectioned" on the page
	And I see "I lack capacity" on the page
	And I do not see "[MENTAL HEALTH Q2]" on the page

Examples:
	| juror_number	| last_name			| postcode	| pool_number	|
	| 045200099		| LNAMEFIVETHREEONE	| CH1 2AN	| 452300098		|
	
@Regression
Scenario Outline: 1st party MHQ1=N MHQ2=N
	
	Given I am on "Public" "ithc"

	Given a bureau owned pool is created with jurors
		| court |juror_number  | pool_number	| att_date_weeks_in_future	| owner |
		| 452   |<juror_number>| <pool_number>	| 5				            | 400	|
		
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
	And I choose the "Yes" radio button
	And I press the "Continue" button
	Then I see "Is this your address?" on the page
	
	#Check Address
	And I choose the "Yes" radio button
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
	Then I see "eligible for jury service" on the page
	
	When I press the "Continue" button
	Then I see "Since you turned 13, has your main address been in the UK, Channel Islands or Isle of Man for any period of at least 5 years?" on the page
	
	#Residency
	When I choose the "Yes" radio button
	And I press the "Continue" button
	
	Then I see "Have you worked in the criminal justice system in the last 5 years?" on the page
	
	#CJS no
	When I choose the "No" radio button
	And I press the "Continue" button
	
	Then I see "Are you currently on bail for a criminal offence?" on the page
		
	#Bail
	And I choose the "No" radio button
	And I press the "Continue" button
	Then I see "Have you been found guilty of a criminal offence?" on the page
	
	#Convictions
	When I choose the "No" radio button
	And I press the "Continue" button
	
	#Mental Health part 1
	When I choose the "No" radio button
	And I press the "Continue" button
	
	#Mental Health part 2
	When I choose the "No" radio button
	And I press the "Continue" button
	
	Then I see "Check your start date" on the page
	
	#I can attend
	And I see "Yes, I can start on" on the page
	And I choose the "Yes" radio button
	And  I press the "Continue" button
	
	Then I see "Will you need help when you're at the court?" on the page
	
	#RA no
	When I choose the "No" radio button
	And I press the "Continue" button
	Then I see "Check your answers now" on the page
	
	#Check your answers
	And I check the "The information I have given is true to the best of my knowledge" checkbox
	And I press the "Submit" button
	
	#When I press the "Submit" button
	Then I see "We have sent you an email to say you have replied to your jury summons." on the page

	#Bureau
	Given I am on "Bureau" "ithc"
	And I log in as "MODTESTBUREAU"

	When I click on the "Search" link
	And I set "Juror number" to "<juror_number>"
	And I press the "Search" button
	And I click on "<juror_number>" in the same row as "<juror_number>"
	
	When I click on the "Eligibility" link
	Then I see "Pass" in the same row as "Mental health"
	And I do not see "I am sectioned" on the page
	And I do not see "I lack capacity" on the page
	And I do not see "[MENTAL HEALTH Q2]" on the page

Examples:
	| juror_number	| last_name	| postcode	| email            | pool_number|
	| 045200100		| 415170401	| CH1 2AN	| email@outlook.com| 452300099	|

@Regression
Scenario Outline: English_3rd_YY

	Given I am on "Public" "ithc"

	Given a bureau owned pool is created with jurors
		| court |juror_number  | pool_number	| att_date_weeks_in_future	| owner |
		| 452   |<juror_number>| <pool_number>	| 5				            | 400	|
	
	And juror "<juror_number>" has "LAST_NAME" as "<last_name>" new schema
	And juror "<juror_number>" has "POSTCODE" as "<postcode>" new schema
	
	Then I see "Reply to a jury summons" on the page
	
	Then I see "Are you replying for yourself or for someone else?" on the page

	When I set the radio button to "I am replying for someone else"
	And I press the "Continue" button
	Then I see "Their juror details" on the page
	
	#Juror Log In
	When I set "9-digit juror number" to "<juror_number>"
	When I set "Juror last name" to "<last_name>"
	When I set "Juror postcode" to "<postcode>"
	And I press the "Continue" button
	Then I see "What is your name?" on the page
	
	#Third Party Name
	When I set "First name" to "FirstNameA"
	And I set "Last name" to "LastNameB"
	And I press the "Continue" button
	Then I see "Your relationship to the person" on the page
	
	#Third Party Relationship
	When I set "How do you know the person you're replying for?" to "Friend"
	And I press the "Continue" button
	Then I see "Your contact information" on the page
	
	#3rd Party Contact
	When I check the "By phone (UK Numbers only)" checkbox
	When I set "Main phone" to "02078211818"
	And I check the "By email" checkbox
	And I set "Enter your email address" to "<email>"
	And I set "Enter your email address again" to "<email>"
	And I press the "Continue" button
	Then I see "Why are you replying for the other person?" on the page
	
	#Why Replying
	When I set the radio button to "The person is not here"
	And I press the "Continue" button
	Then I see "Is the name we have for them correct?" on the page
	When I choose the "Yes" radio button
	
	#Check Juror Name
	And I press the "Continue" button
	Then I see "Is this their address?" on the page
	When I choose the "Yes" radio button
	
	#Check address
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
	Then I see "Since they turned 13, has their main address been in the UK, Channel Islands or Isle of Man for any period of at least 5 years?" on the page
	
	#Residency Yes
	When I choose the "Yes" radio button
	And I press the "Continue" button
	
	#CJS no
	Then I see "Has the person you're replying for worked in the criminal justice system in the last 5 years?" on the page
	When I choose the "No" radio button
	And I press the "Continue" button	

	#Bail no
	Then I see "Is the person currently on bail for a criminal offence?" on the page
	When I choose the "No" radio button
	And I press the "Continue" button
	
	#Convictions no
	Then I see "Has the person been found guilty of a criminal offence?" on the page
	When I choose the "No" radio button
	And I press the "Continue" button
	
	#Mental health part 1
	Then on the page I see
	|text|
	|Is the person you're replying for being detained, looked after or treated under the Mental Health Act?|
	|Only select yes if, under the Mental Health Act 1983, they're:|
	|being detained (sectioned) or liable to be detained|
	|resident in a hospital due to a mental disorder|
	|subject to a guardianship or community treatment order|
	
	And I click on the "Need help answering this?" link
	Then on the page I see
	|text|
	|A person cannot be on a jury if any of these statements apply.|
	|If they have mental health issues (including depression and anxiety) but are not being detained, looked after or treated under the Mental Health Act, they can still be on a jury.|
	|(If they feel they cannot complete jury service because of significant mental health issues, you can still ask for them to be excused or change their dates.)|

	When I choose the "Yes" radio button
	And I set "Provide details about how they're being detained, looked after or treated under the Mental Health Ac" to "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede mollis pretium. Integer tincidunt. Cras dapibus. Vivamus elementum semper nisi. Aenean vulputate eleifend tellus. Aenean leo ligula, porttitor eu, consequat vitae, eleifend ac, enim. Aliquam lorem ante, dapibus in, viverra quis, feugiat a, tellus. Phasellus viverra nulla ut metus varius laoreet. Quisque rutrum. Aenean imperdiet. Etiam ultricies nisi vel augue. Curabitur ullamcorper ultricies nisi. Nam eget dui. Etiam rhoncus. Maecenas tempus, tellus eget condimentum rhoncus, sem quam semper libero, sit amet adipiscing sem neque sed ipsum. N"
	
	And I press the "Continue" button

	#Mental health part 2
	And on the page I see
	|text|
	|Has it been decided that the person you're replying for 'lacks mental capacity'?|
	|This means, legally, they cannot make decisions for themselves.|
	
	And I click on the "Need help answering this?" link
	Then on the page I see
	|text|
	|If someone lacks mental capacity, they cannot:|
	|make their own decisions|
	|understand and retain information|
	|communicate thoughts and decisions to others|
	|Some people are medically certified under the Mental Capacity Act as lacking in mental capacity because of an accident or injury.|
	|Someone else may then need to be appointed to make decisions on their behalf.|
	|If a person lacks mental capacity, they cannot do jury service.|

	When I choose the "Yes" radio button
	And I set "Provide brief details about why it was decided they lack mental capacity" to "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede mollis pretium. Integer tincidunt. Cras dapibus. Vivamus elementum semper nisi. Aenean vulputate eleifend tellus. Aenean leo ligula, porttitor eu, consequat vitae, eleifend ac, enim. Aliquam lorem ante, dapibus in, viverra quis, feugiat a, tellus. Phasellus viverra nulla ut metus varius laoreet. Quisque rutrum. Aenean imperdiet. Etiam ultricies nisi vel augue. Curabitur ullamcorper ultricies nisi. Nam eget dui. Etiam rhoncus. Maecenas tempus, tellus eget condimentum rhoncus, sem quam semper libero, sit amet adipiscing sem neque sed ipsum. N"
		
	And I press the "Continue" button
	
	#I can attend
	Then I see "Check your start date" on the page
	Then I set the radio button to "Yes, they can start on"
	And  I press the "Continue" button

	#RA no
	Then I see "Will the person you're replying for need help when they're at the court?" on the page
	When I choose the "No" radio button
	And I press the "Continue" button

	#Check your answers
	Then I see "Check your answers now" on the page
	And I see text "Yes" in the same row as "Is the person you're replying for being detained, looked after or treated under the Mental Health Act?"
	And I see text "Yes" in the same row as "Has it been decided that the person you're replying for 'lacks mental capacity'?"
	
	#When I press the "Submit" button
	When I check the "The answers I have given for the person I'm replying for are true as far as I know." checkbox
	And I press the "Submit" button
	
	#Confirmation
	Then I see "You have completed your reply" on the page
	And I see "Download a copy of your summons reply HTML" on the page
	And I click on the "Download a copy of your summons reply HTML" link
	
	And I see "Copy of your jury summons reply" on the page
	And I see "<last_name>" in the same row as "Name"
	And I see "<juror_number>" in the same row as "Juror number"

	And I see "You answered the eligibility questions" on the page
	And I see "Yes" in the same row as "Is the person you're replying for being detained, looked after or treated under the Mental Health Act?"
	And I see "Yes" in the same row as "Has it been decided that the person you're replying for 'lacks mental capacity'?"

	Then I press the "back" button on my browser
	Then I see "You have completed your reply" on the page
	And I see "Download a copy of your summons reply HTML" on the page 

 	#Bureau
	Given I am on "Bureau" "ithc"
	And I log in as "MODTESTBUREAU"

	When I click on the "Search" link
	And I set "Juror number" to "<juror_number>"
	And I press the "Search" button
	And I click on "<juror_number>" in the same row as "<juror_number>"
	
	When I click on the "Eligibility" link
	Then "Mental health act" is marked as requiring attention
	And I see "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede mollis pretium. Integer tincidunt. Cras dapibus. Vivamus elementum semper nisi. Aenean vulputate eleifend tellus. Aenean leo ligula, porttitor eu, consequat vitae, eleifend ac, enim. Aliquam lorem ante, dapibus in, viverra quis, feugiat a, tellus. Phasellus viverra nulla ut metus varius laoreet. Quisque rutrum. Aenean imperdiet. Etiam ultricies nisi vel augue. Curabitur ullamcorper ultricies nisi. Nam eget dui. Etiam rhoncus. Maecenas tempus, tellus eget condimentum rhoncus, sem quam semper libero, sit amet adipiscing sem neque sed ipsum. N" on the page
	And I see "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede mollis pretium. Integer tincidunt. Cras dapibus. Vivamus elementum semper nisi. Aenean vulputate eleifend tellus. Aenean leo ligula, porttitor eu, consequat vitae, eleifend ac, enim. Aliquam lorem ante, dapibus in, viverra quis, feugiat a, tellus. Phasellus viverra nulla ut metus varius laoreet. Quisque rutrum. Aenean imperdiet. Etiam ultricies nisi vel augue. Curabitur ullamcorper ultricies nisi. Nam eget dui. Etiam rhoncus. Maecenas tempus, tellus eget condimentum rhoncus, sem quam semper libero, sit amet adipiscing sem neque sed ipsum. N" on the page

	And I do not see "[MENTAL HEALTH Q2]" on the page
	
Examples:
	| juror_number	| last_name			| postcode	| email           	| pool_number	|
	| 045200101		| LNAMENINETHREETWO	| CH1 2AN	| email@outlook.com	| 452300100		|

@Regression
Scenario Outline: English_3rd_YN

	Given I am on "Public" "ithc"

	Given a bureau owned pool is created with jurors
		| court |juror_number  | pool_number	| att_date_weeks_in_future	| owner |
		| 452   |<juror_number>| <pool_number>	| 5				            | 400	|
	
	And juror "<juror_number>" has "LAST_NAME" as "<last_name>" new schema
	And juror "<juror_number>" has "POSTCODE" as "<postcode>" new schema
	
	Then I see "Reply to a jury summons" on the page
	
	Then I see "Are you replying for yourself or for someone else?" on the page

	When I set the radio button to "I am replying for someone else"
	And I press the "Continue" button
	Then I see "Their juror details" on the page
	
	#Juror Log In
	When I set "9-digit juror number" to "<juror_number>"
	When I set "Juror last name" to "<last_name>"
	When I set "Juror postcode" to "<postcode>"
	And I press the "Continue" button
	Then I see "What is your name?" on the page
	
	#Third Party Name
	When I set "First name" to "FirstNameA"
	And I set "Last name" to "LastNameB"
	And I press the "Continue" button
	Then I see "Your relationship to the person" on the page
	
	#Third Party Relationship
	When I set "How do you know the person you're replying for?" to "Friend"
	And I press the "Continue" button
	Then I see "Your contact information" on the page
	
	#3rd Party Contact
	When I check the "By phone (UK Numbers only)" checkbox
	When I set "Main phone" to "02078211818"
	And I check the "By email" checkbox
	And I set "Enter your email address" to "<email>"
	And I set "Enter your email address again" to "<email>"
	And I press the "Continue" button
	Then I see "Why are you replying for the other person?" on the page
	
	#Why Replying
	When I set the radio button to "The person is not here"
	And I press the "Continue" button
	Then I see "Is the name we have for them correct?" on the page
	When I choose the "Yes" radio button
	
	#Check Juror Name
	And I press the "Continue" button
	Then I see "Is this their address?" on the page
	
	#Check address
	When I choose the "Yes" radio button
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
	Then I see "Since they turned 13, has their main address been in the UK, Channel Islands or Isle of Man for any period of at least 5 years?" on the page
	
	#Residency Yes
	When I choose the "Yes" radio button
	And I press the "Continue" button
	
	Then I see "Has the person you're replying for worked in the criminal justice system in the last 5 years?" on the page
	
	#CJS no
	When I choose the "No" radio button
	And I press the "Continue" button
	
	Then I see "Is the person currently on bail for a criminal offence?" on the page
	
	#Bail no
	When I choose the "No" radio button
	And I press the "Continue" button
	Then I see "Has the person been found guilty of a criminal offence?" on the page
	
	#Convictions no
	When I choose the "No" radio button
	And I press the "Continue" button
	
	Then I see "Is the person you're replying for being detained, looked after or treated under the Mental Health Act?" on the page
	
	#Mental health part 1
	When I choose the "Yes" radio button
	And I set "Provide details" to "They are sectioned"

	And I press the "Continue" button
	Then I see "Has it been decided that the person you're replying for 'lacks mental capacity'?" on the page
	
	#Mental health part 2
	When I choose the "No" radio button
	
	And I press the "Continue" button
	
	Then I see "Check your start date" on the page
	
	#I can attend
	Then I set the radio button to "Yes, they can start on"
	And  I press the "Continue" button
	
	Then I see "Will the person you're replying for need help when they're at the court?" on the page
	
	#RA no
	When I choose the "No" radio button
	And I press the "Continue" button
	
	Then I see "Check your answers now" on the page
	
	#When I press the "Submit" button
	When I check the "The answers I have given for the person I'm replying for are true as far as I know." checkbox
	And I press the "Submit" button
	Then I see "We have sent an email to say you have replied to this jury summons." on the page

	#Bureau
	Given I am on "Bureau" "ithc"
	And I log in as "MODTESTBUREAU"

	When I click on the "Search" link
	And I set "Juror number" to "<juror_number>"
	And I press the "Search" button
	And I click on "<juror_number>" in the same row as "<juror_number>"
	
	When I click on the "Eligibility" link
	Then "Mental health act" is marked as requiring attention
	And I see "They are sectioned" on the page
	And I do not see "They lack capacity" on the page
	And I do not see "[MENTAL HEALTH Q2]" on the page
	
Examples:
	| juror_number	| last_name			| postcode	| email           	| pool_number	|
	| 045200102		| LNAMENINETHREETWO	| CH1 2AN	| email@outlook.com	| 452300101		|

@Regression
Scenario Outline: English_3rd_NY

	Given I am on "Public" "ithc"

	Given a bureau owned pool is created with jurors
		| court |juror_number  | pool_number	| att_date_weeks_in_future	| owner |
		| 452   |<juror_number>| <pool_number>	| 5				            | 400	|
	
	And juror "<juror_number>" has "LAST_NAME" as "<last_name>" new schema
	And juror "<juror_number>" has "POSTCODE" as "<postcode>" new schema
	
	Then I see "Reply to a jury summons" on the page

	Then I see "Are you replying for yourself or for someone else?" on the page

	When I set the radio button to "I am replying for someone else"
	And I press the "Continue" button
	Then I see "Their juror details" on the page
	
	#Juror Log In
	When I set "9-digit juror number" to "<juror_number>"
	When I set "Juror last name" to "<last_name>"
	When I set "Juror postcode" to "<postcode>"
	And I press the "Continue" button
	Then I see "What is your name?" on the page
	
	#Third Party Name
	When I set "First name" to "FirstNameA"
	And I set "Last name" to "LastNameB"
	And I press the "Continue" button
	
	Then I see "Your relationship to the person" on the page
	
	#Third Party Relationship
	When I set "How do you know the person you're replying for?" to "Friend"
	And I press the "Continue" button
	
	Then I see "Your contact information" on the page
	
	#3rd Party Contact
	When I check the "By phone (UK Numbers only)" checkbox
	When I set "Main phone" to "02078211818"
	And I check the "By email" checkbox
	And I set "Enter your email address" to "<email>"
	And I set "Enter your email address again" to "<email>"
	And I press the "Continue" button
	
	Then I see "Why are you replying for the other person?" on the page
	
	#Why Replying
	When I set the radio button to "The person is not here"
	And I press the "Continue" button
	
	Then I see "Is the name we have for them correct?" on the page
	
	#Check Juror Name
	And I choose the "Yes" radio button
	And I press the "Continue" button
	
	Then I see "Is this their address?" on the page
	
	#Check address
	And I choose the "Yes" radio button
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
	
	Then I see "Since they turned 13, has their main address been in the UK, Channel Islands or Isle of Man for any period of at least 5 years?" on the page
	
	#Residency Yes
	When I choose the "Yes" radio button
	And I press the "Continue" button
	
	Then I see "Has the person you're replying for worked in the criminal justice system in the last 5 years?" on the page
	
	#CJS no
	When I choose the "No" radio button
	And I press the "Continue" button
	
	Then I see "Is the person currently on bail for a criminal offence?" on the page
	
	#Bail no
	When I choose the "No" radio button
	And I press the "Continue" button
	Then I see "Has the person been found guilty of a criminal offence?" on the page
	
	#Convictions no
	When I choose the "No" radio button
	And I press the "Continue" button
	
	Then I see "Is the person you're replying for being detained, looked after or treated under the Mental Health Act?" on the page
	
	#Mental health part 1
	When I choose the "No" radio button

	And I press the "Continue" button
	Then I see "Has it been decided that the person you're replying for 'lacks mental capacity'?" on the page
	
	#Mental health part 2
	When I choose the "Yes" radio button
	And I set "Provide brief details about why it was decided they lack mental capacity" to "They lack capacity"
	
	And I press the "Continue" button
	
	Then I see "Check your start date" on the page
	
	#I can attend
	Then I set the radio button to "Yes, they can start on"
	And  I press the "Continue" button
	
	Then I see "Will the person you're replying for need help when they're at the court?" on the page
	
	#RA no
	When I choose the "No" radio button
	And I press the "Continue" button
	Then I see "Check your answers now" on the page
	
	#When I press the "Submit" button
	When I check the "The answers I have given for the person I'm replying for are true as far as I know." checkbox
	And I press the "Submit" button
	Then I see "We have sent an email to say you have replied to this jury summons." on the page

	#Bureau
	Given I am on "Bureau" "ithc"
	And I log in as "MODTESTBUREAU"

	When I click on the "Search" link
	And I set "Juror number" to "<juror_number>"
	And I press the "Search" button
	And I click on "<juror_number>" in the same row as "<juror_number>"
	
	When I click on the "Eligibility" link
	Then "Mental health act" is marked as requiring attention
	And I do not see "They are sectioned" on the page
	And I see "They lack capacity" on the page
	And I do not see "[MENTAL HEALTH Q2]" on the page
	
Examples:
	| juror_number	| last_name			| postcode	| email           	| pool_number	|
	| 045200103		| LNAMENINETHREETWO	| CH1 2AN	| email@outlook.com	| 452300102		|

@Regression
Scenario Outline: English_3rd_NN

	Given I am on "Public" "ithc"

	Given a bureau owned pool is created with jurors
		| court |juror_number  | pool_number	| att_date_weeks_in_future	| owner |
		| 452   |<juror_number>| <pool_number>	| 5				            | 400	|
	
	And juror "<juror_number>" has "LAST_NAME" as "<last_name>" new schema
	And juror "<juror_number>" has "POSTCODE" as "<postcode>" new schema
	
	Then I see "Reply to a jury summons" on the page
	
	Then I see "Are you replying for yourself or for someone else?" on the page

	When I set the radio button to "I am replying for someone else"
	And I press the "Continue" button
	
	Then I see "Their juror details" on the page
	
	#Juror Log In
	When I set "9-digit juror number" to "<juror_number>"
	When I set "Juror last name" to "<last_name>"
	When I set "Juror postcode" to "<postcode>"
	And I press the "Continue" button
	Then I see "What is your name?" on the page
	
	#Third Party Name
	When I set "First name" to "FirstNameA"
	And I set "Last name" to "LastNameB"
	And I press the "Continue" button
	Then I see "Your relationship to the person" on the page
	
	#Third Party Relationship
	When I set "How do you know the person you're replying for?" to "Friend"
	And I press the "Continue" button
	Then I see "Your contact information" on the page
	
	#3rd Party Contact
	When I check the "By phone (UK Numbers only)" checkbox
	When I set "Main phone" to "02078211818"
	And I check the "By email" checkbox
	And I set "Enter your email address" to "<email>"
	And I set "Enter your email address again" to "<email>"
	And I press the "Continue" button
	Then I see "Why are you replying for the other person?" on the page
	
	#Why Replying
	When I set the radio button to "The person is not here"
	And I press the "Continue" button
	Then I see "Is the name we have for them correct?" on the page
	
	#Check Juror Name
	And I choose the "Yes" radio button
	And I press the "Continue" button
	
	Then I see "Is this their address?" on the page
	
	#Check address
	And I choose the "Yes" radio button
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
	Then I see "Since they turned 13, has their main address been in the UK, Channel Islands or Isle of Man for any period of at least 5 years?" on the page
	
	#Residency Yes
	When I choose the "Yes" radio button
	And I press the "Continue" button
	
	Then I see "Has the person you're replying for worked in the criminal justice system in the last 5 years?" on the page
	
	#CJS no
	When I choose the "No" radio button
	And I press the "Continue" button
	
	Then I see "Is the person currently on bail for a criminal offence?" on the page
	
	#Bail no
	When I choose the "No" radio button
	And I press the "Continue" button
	
	Then I see "Has the person been found guilty of a criminal offence?" on the page
	
	#Convictions no
	When I choose the "No" radio button
	And I press the "Continue" button
	
	Then I see "Is the person you're replying for being detained, looked after or treated under the Mental Health Act?" on the page
	
	#Mental health part 1
	When I choose the "No" radio button

	And I press the "Continue" button
	Then I see "Has it been decided that the person you're replying for 'lacks mental capacity'?" on the page
	
	#Mental health part 2
	When I choose the "No" radio button
	
	And I press the "Continue" button
	
	Then I see "Check your start date" on the page
	
	#I can attend
	Then I set the radio button to "Yes, they can start on"
	And  I press the "Continue" button
	
	Then I see "Will the person you're replying for need help when they're at the court?" on the page
	
	#RA no
	When I choose the "No" radio button
	And I press the "Continue" button
	
	Then I see "Check your answers now" on the page
	
	#When I press the "Submit" button
	When I check the "The answers I have given for the person I'm replying for are true as far as I know." checkbox
	And I press the "Submit" button
	Then I see "We have sent an email to say you have replied to this jury summons." on the page

	#Bureau
	Given I am on "Bureau" "ithc"
	And I log in as "MODTESTBUREAU"

	When I click on the "Search" link
	And I set "Juror number" to "<juror_number>"
	And I press the "Search" button
	And I click on "<juror_number>" in the same row as "<juror_number>"
	
	When I click on the "Eligibility" link
	Then I see "Pass" in the same row as "Mental health"
	And I do not see "They are sectioned" on the page
	And I do not see "They lack capacity" on the page
	And I do not see "[MENTAL HEALTH Q2]" on the page
	
Examples:
	| juror_number	| last_name			| postcode	| email            | pool_number|
	| 045200104		| LNAMENINETHREETWO	| CH1 2AN	| email@outlook.com| 452300103	|