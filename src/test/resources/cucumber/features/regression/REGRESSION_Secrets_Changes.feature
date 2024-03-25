Feature: Regression Secrets Changes Testing

#Public Straight through auto processed
#Public over/under age through auto processed
#Public Process in Bureau (deferral)
#Public Deceased auto processed
#Bureau change juror details
#Bureau change 3rd party details
#Bureau change juror Eligibility details
#Bureau change juror Def/Exc details
#Bureau change juror CJS Emp details
#Bureau change juror Reasonable Adjustments details
#Bureau Add notes
#Bureau Add Call Log
#Bureau check change log

@Secrets @NewSchemaConverted
Scenario Outline: Secrets Change - Public Straight through auto processed
	
	Given I am on "Public" "test"

	Given a bureau owned pool is created with jurors
		| court |juror_number  | pool_number	| att_date_weeks_in_future	| owner |
		| 452   |<juror_number>| <pool_number>	| 5				            | 400	|
		
	And juror "<juror_number>" has "LAST_NAME" as "<last_name>" new schema
	And juror "<juror_number>" has "POSTCODE" as "<postcode>" new schema
	
	And I set the radio button to "I am replying for myself"
	And I press the "Continue" button
	
	When I set "9-digit juror number" to "<juror_number>"
	And I set "Juror last name" to "<last_name>"
	And I set "Juror postcode" to "<postcode>"
	And I press the "Continue" button

	And I see "<last_name>" on the page
	And I choose the "Yes" radio button
	And I press the "Continue" button

	And I see "<postcode>" on the page
	And I choose the "Yes" radio button
	When I press the "Continue" button

	When I set "Main phone" to "02078211818"
	And I press the "Continue" button
	
	When I set "Enter your email address" to "<email>"
	When I set "Enter your email address again" to "<email>"
	And I press the "Continue" button

	When I set "Day" to "01"
	And I set "Month" to "01"
	And I set "Year" to "1990"
	And I press the "Continue" button

	#Qualify for jury service
	When I press the "Continue" button

	#Residency
	And I choose the "Yes" radio button
	And I press the "Continue" button
	
	#Mental Health Sectioned
	And I choose the "No" radio button
	And I press the "Continue" button
	
	#Mental Health Capacity
	And I choose the "No" radio button
	And I press the "Continue" button
	
	#Bail
	When I choose the "No" radio button
	And I press the "Continue" button
	
	#Convictions
	When I choose the "No" radio button
	And I press the "Continue" button
	
	#I can attend
	And I see "Yes, I can start on" on the page
	And  I press the "Continue" button

	#CJS no
	When I choose the "No" radio button
	And I press the "Continue" button
	
	#RA no
	When I choose the "No" radio button
	And I press the "Continue" button
	
	#Check your answers
	And I check the "The information I have given is true to the best of my knowledge" checkbox
	And I press the "Submit" button
	Then I see "We have sent you an email to say you have replied to your jury summons." on the page
	And I see "Download a copy of your summons reply PDF (65KB)" on the page
	
	Then on "JUROR_MOD" . "JUROR_RESPONSE" I see "PROCESSING_STATUS" is "CLOSED" where "JUROR_NUMBER" is "<juror_number>"
	Then on "JUROR" . "POOL" I see "RESPONDED" is "Y" where "PART_NO" is "<juror_number>"
	
	Given I am on "Bureau" "test"
	And I log in as "CPASS"
	
	When I click on the "Search" link
	And I set "Juror number" to "<juror_number>"
	And I press the "Search" button
	And I click on "<juror_number>" in the same row as "<juror_number>"
	And I see "Responded" on the page
	
	#error if you try to reply again
	Given I am on "Public" "juror-test01"
	
	And I set the radio button to "I am replying for myself"
	And I press the "Continue" button
	
	When I set "9-digit juror number" to "<juror_number>"
	And I set "Juror last name" to "<last_name>"
	And I set "Juror postcode" to "<postcode>"
	And I press the "Continue" button
	
	And I see "There is a problem" on the page
	And I see "You have no summons to complete." on the page
	
Examples:
	| juror_number	| last_name			| postcode	| email 		| pool_number	|
	| 045200164		| LNAMEONEONENINE	| CH1 2AN	| a@eeee.com	| 452300149		|
	
@Secrets @NewSchemaConverted
Scenario Outline: Secrets Change - Public over/under age through auto processed

	Given I am on "Public" "test"

	Given a bureau owned pool is created with jurors
		| court |juror_number  | pool_number	| att_date_weeks_in_future	| owner |
		| 452   |<juror_number>| <pool_number>	| 5				            | 400	|
	
	And juror "<juror_number>" has "LAST_NAME" as "<last_name>" new schema
	And juror "<juror_number>" has "POSTCODE" as "<postcode>" new schema
	
	And I set the radio button to "I am replying for myself"
	And I press the "Continue" button
	
	When I set "9-digit juror number" to "<juror_number>"
	When I set "Juror last name" to "<last_name>"
	When I set "Juror postcode" to "<postcode>"
	And I press the "Continue" button

	And I see "<last_name>" on the page
	When I choose the "Yes" radio button
	When I press the "Continue" button

	And I see "<postcode>" on the page
	When I choose the "Yes" radio button
	When I press the "Continue" button
	
	When I set "Main phone" to "02078211818"
	And I press the "Continue" button

	When I set "Enter your email address" to "<email>"
	And I set "Enter your email address again" to "<email>"
	And I press the "Continue" button
	
	When I set "Day" to "27"
	And I set "Month" to "04"
	And I set "Year" to "2005"
	And I press the "Continue" button
	
	And I press the "Continue" button

	Then I check the "The information I have given is true to the best of my knowledge" checkbox
	When I press the "Submit" button
	
	Then I see "You have completed your reply" on the page
	Then I see "<juror_number>" on the page
	
	Then on "JUROR_MOD" . "JUROR_RESPONSE" I see "PROCESSING_STATUS" is "CLOSED" where "JUROR_NUMBER" is "<juror_number>"
	Then on "JUROR_MOD" . "JUROR_POOL" I see "RESPONDED" is "Y" where "JUROR_NUMBER" is "<juror_number>"
	Then on "JUROR_MOD" . "JUROR_POOL" I see "DISQ_CODE" is "A" where "JUROR_NUMBER" is "<juror_number>"
	
	Given I am on "Bureau" "test"
	And I log in as "CPASS"
	
	When I click on the "Search" link
	And I set "Juror number" to "<juror_number>"
	And I press the "Search" button
	And I click on "<juror_number>" in the same row as "<juror_number>"
	And "Record status" is "Disqualified"
	And I see "Ineligible" on the page
	
Examples:
	| juror_number	| last_name			| postcode	| email 		| pool_number	|
	| 045200165		| LNAMEFIVEFIVEZERO	| CH1 2AN	| a@eeee.com	| 452300150		|

@Secrets @NewSchemaConverted
Scenario Outline: Secrets Change - Public Not Auto Processed (deferral)
	
	Given I am on "Public" "test"

	Given a bureau owned pool is created with jurors
		| court |juror_number  | pool_number	| att_date_weeks_in_future	| owner |
		| 452   |<juror_number>| <pool_number>	| 5				            | 400	|
		
	And juror "<juror_number>" has "LAST_NAME" as "<last_name>" new schema
	And juror "<juror_number>" has "POSTCODE" as "<postcode>" new schema
	
	And I set the radio button to "I am replying for myself"
	And I press the "Continue" button
	
	When I set "9-digit juror number" to "<juror_number>"
	And I set "Juror last name" to "<last_name>"
	And I set "Juror postcode" to "<postcode>"
	And I press the "Continue" button

	And I choose the "Yes" radio button
	And I press the "Continue" button

	And I choose the "Yes" radio button
	When I press the "Continue" button

	When I set "Main phone" to "02078211818"
	And I press the "Continue" button
	
	When I set "Enter your email address" to "<email>"
	When I set "Enter your email address again" to "<email>"
	And I press the "Continue" button

	When I set "Day" to "01"
	And I set "Month" to "01"
	And I set "Year" to "1990"
	And I press the "Continue" button

	#Qualify for jury service
	When I press the "Continue" button

	#Residency
	And I choose the "Yes" radio button
	And I press the "Continue" button
	
	#Mental Health Sectioned
	And I choose the "No" radio button
	And I press the "Continue" button
	
	#Mental Health Capacity
	And I choose the "No" radio button
	And I press the "Continue" button
	
	#Bail
	When I choose the "No" radio button
	And I press the "Continue" button
	
	#Convictions
	When I choose the "No" radio button
	And I press the "Continue" button
	
	#defer
	And I see "No, I need to change the date" on the page
	And I press the "Continue" button
	When I set text area with "id" of "deferralReason" to "Deferral Reason"
	And I press the "Continue" button

	When I set "First date" to "{7 mondays time}"
	When I set "Second date" to "{8 mondays time}"
	When I set "Third date" to "{9 mondays time}"
	And I press the "Continue" button

	#CJS no
	When I choose the "No" radio button
	And I press the "Continue" button
	
	#RA no
	When I choose the "No" radio button
	And I press the "Continue" button
	
	#Check your answers
	And I check the "The information I have given is true to the best of my knowledge" checkbox
	And I press the "Submit" button
	Then I see "We have sent you an email to say you have replied to your jury summons." on the page
	And I see "Download a copy of your summons reply PDF (65KB)" on the page
	
	Then on "JUROR_MOD" . "JUROR_RESPONSE" I see "PROCESSING_STATUS" is "TODO" where "JUROR_NUMBER" is "<juror_number>"
	Then on "JUROR_MOD" . "JUROR_POOL" I see "RESPONDED" is "N" where "JUROR_NUMBER" is "<juror_number>"
	And on "JUROR_MOD" . "JUROR_POOL" I see "STATUS" is "1" where "JUROR_NUMBER" is "<juror_number>"
	
#	Given I am on "Bureau" "juror-test01"
#	And I log in as "CPASS"
#	
#	When I click on the "Search" link
#	And I set "Juror number" to "<juror_number>"
#	And I press the "Search" button
#	And I click on "<juror_number>" in the same row as "<juror_number>"
#	And I see "Summoned" on the page
#	
#	Then I select "Deferral" from Process reply
#	And I set the radio button to "Accept deferral"
#	Then I see "Defer until" on the page
#	
#	When I set "Defer until" to "{7 mondays time}"
#	And I select "O - OTHER" from the "Reason for deferral request" dropdown
#	And I press the "Mark as completed" button
#	Then I see "Completed" on the page
#	
#	Then on "JUROR_MOD" . "JUROR_RESPONSE" I see "PROCESSING_STATUS" is "CLOSED" where "JUROR_NUMBER" is "<juror_number>"
#	Then on "JUROR_MOD" . "JUROR_RESPONSE" I see "PROCESSING_COMPLETE" is "Y" where "JUROR_NUMBER" is "<juror_number>"
#
#	Then on "JUROR" . "POOL" I see "RESPONDED" is "Y" where "part_no" is "<juror_number>"
#	And on "JUROR" . "POOL" I see "STATUS" is "7" where "part_no" is "<juror_number>"
#	
Examples:
	| juror_number	| last_name			| postcode	| email 		| pool_number	|
	| 045200166		| LNAMEONEONENINE	| CH1 2AN	| a@eeee.com	| 452300151		|

@Secrets @NewSchemaConverted
Scenario Outline: Secrets Change - Public Deceased auto processed
	
	Given I am on "Public" "test"

	Given a bureau owned pool is created with jurors
		| court |juror_number  | pool_number	| att_date_weeks_in_future	| owner |
		| 452   |<juror_number>| <pool_number>	| 5				            | 400	|

	And juror "<juror_number>" has "LAST_NAME" as "<last_name>" new schema
	And juror "<juror_number>" has "FIRST_NAME" as "FNAMESEVENONETHREE" new schema
	And juror "<juror_number>" has "ADDRESS_LINE_1" as "855 STREET NAME" new schema
	And juror "<juror_number>" has "ADDRESS_LINE_4" as "LONDON" new schema
	And juror "<juror_number>" has "POSTCODE" as "<postcode>" new schema
	
	And I set the radio button to "I am replying for someone else"
	And I press the "Continue" button

	When I set "9-digit juror number" to "<juror_number>"
	When I set "Juror last name" to "<last_name>"
	When I set "Juror postcode" to "<postcode>"
	And I press the "Continue" button
	
	When I set "First name" to "FirstName"
	And I set "Last name" to "LastName"
	And I press the "Continue" button

	When I set "How do you know the person you're replying for?" to "Friend"
	And I press the "Continue" button

	When I check the "By phone (UK Numbers only)" checkbox
	And I check the "By email" checkbox
	And I set "Main phone" to "02078211818"
	And I set "Enter your email address" to "<email>"
	And I set "Enter your email address again" to "<email>"
	And I press the "Continue" button

	When I set the radio button to "The person has died"
	And I press the "Continue" button
	
	When I check the "The answers I have given for the person I'm replying for are true as far as I know" checkbox
	And I press the "Submit" button
	Then I see "You have completed your reply" on the page
	And I see "Download a copy of your summons reply" on the page

	Then on "JUROR_MOD" . "JUROR_RESPONSE" I see "PROCESSING_STATUS" is "CLOSED" where "JUROR_NUMBER" is "<juror_number>"
	Then on "JUROR_MOD" . "JUROR_POOL" I see "RESPONDED" is "Y" where "JUROR_NUMBER" is "<juror_number>"
	Then on "JUROR_MOD" . "JUROR_POOL" I see "EXC_CODE" is "D" where "JUROR_NUMBER" is "<juror_number>"
	
	Given I am on "Bureau" "test"
	And I log in as "CPASS"
	
	When I click on the "Search" link
	And I set "Juror number" to "<juror_number>"
	And I press the "Search" button
	And I click on "<juror_number>" in the same row as "<juror_number>"
	And "Record status" is "Excused"
	And I see "Deceased" on the page
	
Examples:
	| juror_number	| last_name		| postcode	| email 		| pool_number	|
	| 045200167		|LNAMEONEONENINE| CH1 2AN	| a@eeee.com	| 452300152		|

@Secrets @NewSchemaConverted
Scenario Outline: Secrets Change Bureau

	Given I am on "Public" "test"

	#pool is urgent
	Given a bureau owned pool is created with jurors
		| court |juror_number  | pool_number	| att_date_weeks_in_future	| owner |
		| 452   |<juror_number>| <pool_number>	| 2				            | 400	|

	And juror "<juror_number>" has "LAST_NAME" as "<last_name>" new schema
	And juror "<juror_number>" has "POSTCODE" as "<postcode>" new schema
		
	And I set the radio button to "I am replying for someone else"
	And I press the "Continue" button
	
	When I set "9-digit juror number" to "<juror_number>"
	When I set "Juror last name" to "<last_name>"
	When I set "Juror postcode" to "<postcode>"
	And I press the "Continue" button
	
	When I set "First name" to "regrFirstName"
	And I set "Last name" to "regrLastName"
	And I press the "Continue" button
	
	And I set "How do you know the person you're replying for?" to "friend"
	And I press the "Continue" button
	
	And I check the "By phone (UK Numbers only)" checkbox
	And I check the "By email" checkbox
	And I set "Main phone" to "01111111119"
	And I set "Another phone (optional)" to "07222222229"
	And I set "Enter your email address" to "<email>"
	And I set "Enter your email address again" to "<email>"
	And I press the "Continue" button
	
	And I set the radio button to "The person is not here"
	And I press the "Continue" button

	And I choose the "Yes" radio button
	When I press the "Continue" button

	And I choose the "Yes" radio button
	When I press the "Continue" button
	
	And I set "Day" to "01"
	And I set "Month" to "01"
	And I set "Year" to "1990"
	And I press the "Continue" button
	
	And I set the radio button to "Give a different phone number for the juror"
	And I set "Main phone number" to "0333333339"
	And I set "Another phone number (optional)" to "07444444444"
	And I set the radio button to "Give a different email address for the juror"
	And I set "Enter email address" to "editableSummons@regressionJURORContactEmail.com"
	And I set "Enter the email address again" to "editableSummons@regressionJURORContactEmail.com"
	And I press the "Continue" button
	
	When I press the "Continue" button
	
	When I choose the "Yes" radio button
	And I press the "Continue" button
	
	When I choose the "No" radio button
	And I press the "Continue" button
	
	When I choose the "No" radio button
	And I press the "Continue" button
	
	When I choose the "No" radio button
	And I press the "Continue" button
	
	When I choose the "No" radio button
	And I press the "Continue" button
	
	Then I choose the "Yes" radio button
	And I press the "Continue" button
	
	When I choose the "No" radio button
	And I press the "Continue" button

	When I choose the "Yes" radio button
	When I press the "Continue" button

	And I choose the "No" radio button
	And I press the "Continue" button

	And I check the "The answers I have given for the person I'm replying for are true as far as I know." checkbox
	And I press the "Submit" button
	
	Then I see "You have completed your reply" on the page
	Then I see "<juror_number>" on the page
	
	Then on "JUROR_MOD" . "JUROR_RESPONSE" I see "PROCESSING_STATUS" is "TODO" where "JUROR_NUMBER" is "<juror_number>"
	Then on "JUROR_MOD" . "JUROR_RESPONSE" I see "PROCESSING_COMPLETE" is "N" where "JUROR_NUMBER" is "<juror_number>"
	Then on "JUROR_MOD" . "JUROR_POOL" I see "RESPONDED" is "N" where "JUROR_NUMBER" is "<juror_number>"

	Given I am on "Bureau" "test"
	And I log in as "CPASS"
	
	And I see "To do" on the page
	When I click on the "Search" link
	And I set "Juror number" to "<juror_number>"
	And I press the "Search" button
	And I click on "<juror_number>" in the same row as "<juror_number>"
	
	And I click on the "edit" link
	
	And I set "First name" to "Changed"
	And I set "Address line 1" to "NewRoad"
	And I set "Day" to "10"
	And I set "Main phone number" to "01214445555"
	And I set "Edit email address" to "e@mail.com"
	And I set "Confirm email address" to "e@mail.com"
		
	And I set "First name" to "ChangedThird" for "thirdParty"
	And I set "Relationship to juror" to "ChnagedRelationship" for "thirdParty"
	And I set "Main phone" to "07999999999" for "thirdParty"
	And I set "Edit email address" to "third@email.com" for "thirdParty"
	And I set "Confirm email address" to "third@email.com" for "thirdParty"
	And I click on the "save" link
	And I set "Please give a reason for the change to this summons reply" to "testNotesAB_TwoOnEditableC"
	And I press the "Save" button
	
	Then on "JUROR_MOD" . "JUROR_RESPONSE" I see "PROCESSING_COMPLETE" is "N" where "JUROR_NUMBER" is "<juror_number>"
	Then on "JUROR_MOD" . "JUROR_RESPONSE" I see "FIRST_NAME" is "Changed" where "JUROR_NUMBER" is "<juror_number>"
	Then on "JUROR_MOD" . "JUROR_RESPONSE" I see "ADDRESS" is "NewRoad" where "JUROR_NUMBER" is "<juror_number>"
	Then on "JUROR_MOD" . "JUROR_RESPONSE" I see "PHONE_NUMBER" is "01214445555" where "JUROR_NUMBER" is "<juror_number>"
	Then on "JUROR_MOD" . "JUROR_RESPONSE" I see "EMAIL" is "e@mail.com" where "JUROR_NUMBER" is "<juror_number>"
	Then on "JUROR_MOD" . "JUROR_RESPONSE" I see "THIRDPARTY_FNAME" is "ChangedThird" where "JUROR_NUMBER" is "<juror_number>"
	Then on "JUROR_MOD" . "JUROR_RESPONSE" I see "RELATIONSHIP" is "ChnagedRelationship" where "JUROR_NUMBER" is "<juror_number>"
	Then on "JUROR_MOD" . "JUROR_RESPONSE" I see "MAIN_PHONE" is "07999999999" where "JUROR_NUMBER" is "<juror_number>"
	Then on "JUROR_MOD" . "JUROR_RESPONSE" I see "EMAIL_ADDRESS" is "third@email.com" where "JUROR_NUMBER" is "<juror_number>"
	Then on "JUROR_MOD" . "JUROR_POOL" I see "RESPONDED" is "N" where "JUROR_NUMBER" is "<juror_number>"
	Then on "JUROR_MOD" . "JUROR_POOL" I see "STATUS" is "1" where "JUROR_NUMBER" is "<juror_number>"
	
	When I click on the "Eligibility" link
	
	When I click on the "edit" link
	
	And I choose the "No" radio button under "Residency"
	And I see "Provide details" on the page
	And I set text area with "id" of "residencyDetails" to "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede mollis pretium. Integer tincidunt. Cras dapibus. Vivamus elementum semper nisi. Aenean vulputate eleifend tellus. Aenean leo ligula, porttitor eu, consequat vitae, eleifend ac, enim. Aliquam lorem ante, dapibus in, viverra quis, feugiat a, tellus. Phasellus viverra nulla ut metus varius laoreet. Quisque rutrum. Aenean imperdiet. Etiam ultricies nisi vel augue. Curabitur ullamcorper ultricies nisi. Nam eget dui. Etiam rhoncus. Maecenas tempus, tellus eget condimentum rhoncus, sem quam semper libero, sit amet adipiscing sem neque sed ipsum. Naaaaaa"

	When I click on the "save" link
	And I set "Please give a reason for the change to this summons reply" to "testNotesABC"
	And I press the "Save" button
	
	Then I see "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede mollis pretium. Integer tincidunt. Cras dapibus. Vivamus elementum semper nisi. Aenean vulputate eleifend tellus. Aenean leo ligula, porttitor eu, consequat vitae, eleifend ac, enim. Aliquam lorem ante, dapibus in, viverra quis, feugiat a, tellus. Phasellus viverra nulla ut metus varius laoreet. Quisque rutrum. Aenean imperdiet. Etiam ultricies nisi vel augue. Curabitur ullamcorper ultricies nisi. Nam eget dui. Etiam rhoncus. Maecenas tempus, tellus eget condimentum rhoncus, sem quam semper libero, sit amet adipiscing sem neque sed ipsum. N" on the page
	
	Then on "JUROR_MOD" . "JUROR_RESPONSE" I see "RESIDENCY" is "N" where "JUROR_NUMBER" is "<juror_number>"
	Then on "JUROR_MOD" . "JUROR_RESPONSE" I see "RESIDENCY_DETAIL" is "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede mollis pretium. Integer tincidunt. Cras dapibus. Vivamus elementum semper nisi. Aenean vulputate eleifend tellus. Aenean leo ligula, porttitor eu, consequat vitae, eleifend ac, enim. Aliquam lorem ante, dapibus in, viverra quis, feugiat a, tellus. Phasellus viverra nulla ut metus varius laoreet. Quisque rutrum. Aenean imperdiet. Etiam ultricies nisi vel augue. Curabitur ullamcorper ultricies nisi. Nam eget dui. Etiam rhoncus. Maecenas tempus, tellus eget condimentum rhoncus, sem quam semper libero, sit amet adipiscing sem neque sed ipsum. N" where "JUROR_NUMBER" is "<juror_number>"
	Then on "JUROR_MOD" . "JUROR_POOL" I see "RESPONDED" is "N" where "JUROR_NUMBER" is "<juror_number>"

	When I click on the "Deferral or excusal" link
	
	When I click on the "edit" link

	And I set the radio button to "No, I need to change the date"
	
	Then I see "I need to change the date of my jury service" on the page
	And I set text area with "id" of "deferralReason" to "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede mollis pretium. Integer tincidunt. Cras dapibus. Vivamus elementum semper nisi. Aenean vulputate eleifend tellus. Aenean leo ligula, porttitor eu, consequat vitae, eleifend ac, enim. Aliquam lorem ante, dapibus in, viverra quis, feugiat a, tellus. Phasellus viverra nulla ut metus varius laoreet. Quisque rutrum. Aenean imperdiet. Etiam ultricies nisi vel augue. Curabitur ullamcorper ultricies nisi. Nam eget dui. Etiam rhoncus. Maecenas tempus, tellus eget condimentum rhoncus, sem quam semper libero, sit amet adipiscing sem neque sed ipsum. N"

	When I click on the "save" link

	And I set "Please give a reason for the change to this summons reply" to "testNotesAB_TwoOnEditableC"
	And I press the "Save" button

	Then on "JUROR_MOD" . "JUROR_RESPONSE" I see "DEFERRAL_REASON" is "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede mollis pretium. Integer tincidunt. Cras dapibus. Vivamus elementum semper nisi. Aenean vulputate eleifend tellus. Aenean leo ligula, porttitor eu, consequat vitae, eleifend ac, enim. Aliquam lorem ante, dapibus in, viverra quis, feugiat a, tellus. Phasellus viverra nulla ut metus varius laoreet. Quisque rutrum. Aenean imperdiet. Etiam ultricies nisi vel augue. Curabitur ullamcorper ultricies nisi. Nam eget dui. Etiam rhoncus. Maecenas tempus, tellus eget condimentum rhoncus, sem quam semper libero, sit amet adipiscing sem neque sed ipsum. N" where "JUROR_NUMBER" is "<juror_number>"
	Then on "JUROR_MOD" . "JUROR_POOL" I see "RESPONDED" is "N" where "JUROR_NUMBER" is "<juror_number>"
	
	When I click on the "CJS employee" link
	
	When I click on the "edit" link
	
	And I choose the "Yes" radio button
	And I check the "Police service" checkbox

	And I set text area with "id" of "cjsPoliceDetails" to "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede mollis pretium. Integer tincidunt. Cras dapibus. Vivamus elementum semper nisi. Aenean vulputate eleifend tellus. Aenean leo ligula, porttitor eu, consequat vitae, eleifend ac, enim. Aliquam lorem ante, dapibus in, viverra quis, feugiat a, tellus. Phasellus viverra nulla ut metus varius laoreet. Quisque rutrum. Aenean imperdiet. Etiam ultricies nisi vel augue. Curabitur ullamcorper ultricies nisi. Nam eget dui. Etiam rhoncus. Maecenas tempus, tellus eget condimentum rhoncus, sem quam semper libero, sit amet adipiscing sem neque sed ipsum. Naaaaaa"
	Then "cjsPoliceDetails" is "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede mollis pretium. Integer tincidunt. Cras dapibus. Vivamus elementum semper nisi. Aenean vulputate eleifend tellus. Aenean leo ligula, porttitor eu, consequat vitae, eleifend ac, enim. Aliquam lorem ante, dapibus in, viverra quis, feugiat a, tellus. Phasellus viverra nulla ut metus varius laoreet. Quisque rutrum. Aenean imperdiet. Etiam ultricies nisi vel augue. Curabitur ullamcorper ultricies nisi. Nam eget dui. Etiam rhoncus. Maecenas tempus, tellus eget condimentum rhoncus, sem quam semper libero, sit amet adipiscing sem neque sed ipsum. N"
	
	When I click on the "save" link
	And I set "Please give a reason for the change to this summons reply" to "CJSEmployeeChangeNotes"
	And I press the "Save" button

	Then on "JUROR_MOD" . "JUROR_RESPONSE_CJS_EMPLOYMENT" I see "CJS_EMPLOYER" is "Police Force" where "JUROR_NUMBER" is "<juror_number>"
	Then on "JUROR_MOD" . "JUROR_POOL" I see "RESPONDED" is "N" where "JUROR_NUMBER" is "<juror_number>"
	
	When I click on the "Reasonable adjustments" link
	
	When I click on the "edit" link
	And I check the "Limited mobility" checkbox

	When I click on the "save" link
	And I set "Please give a reason for the change to this summons reply" to "resonableAdjustmentsNote"
	And I press the "Save" button
	
	When I select "Mark as responded" from Process reply
	And I check the "Mark juror as 'responded'" checkbox
	And I press the "Confirm" button
	Then I see "Completed" on the page
	Then on "JUROR_MOD" . "JUROR_RESPONSE" I see "PROCESSING_COMPLETE" is "Y" where "JUROR_NUMBER" is "<juror_number>"
	Then on "JUROR" . "POOL" I see "RESPONDED" is "Y" where "PART_NO" is "<juror_number>"
	
Examples:
	| juror_number	| pool_number	| last_name			| postcode	| email 	|
	| 045200168		| 452300153		| LNAMETWOSIXZERO	| CH1 2AN	| a@a.com	|
	
@Secrets @NewSchemaConverted
Scenario: Secrets Change Dashboard
	Given I am on "Dashboard" "test"
	And I see "35,016" on the page