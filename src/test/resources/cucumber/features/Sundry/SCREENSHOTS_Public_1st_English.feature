Feature: Screenshots


Scenario Outline: English 1st Party Straight Through
	
	Given I am on "Public" "juror-test02"
	
	#Then I take a screenshot
	
	Given the juror numbers have not been processed
		| part_no 	| pool_no 	| owner |
		| <part_no> |<pool_no>	| 400 	|
		
	And "<part_no>" has "LNAME" as "<last_name>"
	And "<part_no>" has "RET_DATE" as "5 mondays time"
	And "<part_no>" has "NEXT_DATE" as "5 mondays time"
	And "<part_no>" has "ZIP" as "<postcode>"
	
	Given auto straight through processing has been enabled
	
##1st or 3rd
	
	#error
	
	And I press the "Continue" button
	
	#Then I take a screenshot

	#move on
	
	And I set the radio button to "I am replying for myself"
	And I press the "Continue" button
	
	#Then I take a screenshot
	
##log on
	
	#error
	
	And I press the "Continue" button
	
	#Then I take a screenshot
	
	#move on
	
	When I set "9-digit juror number" to "<part_no>"
	And I set "Juror last name" to "<last_name>"
	And I set "Juror postcode" to "<postcode>"
	And I press the "Continue" button
	
##name
	
	#Then I take a screenshot
	
	#error
	
	And I press the "Continue" button
	
	#Then I take a screenshot
	
	#move on NO
	
	And I set the radio button to "No"
	And I press the "Continue" button
	
	#Then I take a screenshot
	
	Then I click on the "Back" link
	
	#move on YES
	
	And I set the radio button to "Yes"
	And I press the "Continue" button
	
##address
	
	#Then I take a screenshot

	#error
	
	When I press the "Continue" button
	
	#Then I take a screenshot
	
	#move on NO
	
	And I set the radio button to "No"
	And I press the "Continue" button
	
	#Then I take a screenshot
	
	Then I click on the "Back" link
	
	#move on YES
	
	And I set the radio button to "Yes"
	When I press the "Continue" button

##phone

	#Then I take a screenshot

	#error
	
	And I press the "Continue" button

	#Then I take a screenshot
	
	#move on
	
	When I set "Main phone" to "02078211818"
	And I press the "Continue" button

##email

	#Then I take a screenshot
	
	#error
	
	And I press the "Continue" button
	
	#Then I take a screenshot
	
	#move on
	
	When I set "Enter your email address" to "e@mail.com"
	When I set "Enter your email address again" to "e@mail.com"
	And I press the "Continue" button
	
##DOB

	#Then I take a screenshot

	#error
	
	And I press the "Continue" button

	#Then I take a screenshot
	
	#move on OVERAGE
	
	When I set "Day" to "01"
	And I set "Month" to "01"
	And I set "Year" to "1900"
	And I press the "Continue" button
	
	#Then I take a screenshot

	#move on
	
	And I click on the "Back" link
	
	When I set "Day" to "01"
	And I set "Month" to "01"
	And I set "Year" to "1990"
	And I press the "Continue" button
	
	#Then I take a screenshot

##qualifying

	When I press the "Continue" button
	
	#Then I take a screenshot

##residency

	#error
	
	And I press the "Continue" button
	
	#Then I take a screenshot
	
	#move on NO
	
	And I set the radio button to "No"
	
	#Then I take a screenshot
	
	#move on YES
	
	And I set the radio button to "Yes"
	And I press the "Continue" button
	
	#Then I take a screenshot
	
##CJS

	#error
	
	And I press the "Continue" button
	
	#Then I take a screenshot
	
	#move on YES
	
	When I set the radio button to "Yes"
	
	#Then I take a screenshot
	
	#move on NO
		
	When I set the radio button to "No"
	And I press the "Continue" button
	
	#Then I take a screenshot
	
##Bail
	
	#error
	
	And I press the "Continue" button
	
	#Then I take a screenshot
	
	#move on YES

	When I set the radio button to "Yes"
	
	#Then I take a screenshot
	
	#move on NO

	When I set the radio button to "No"
	And I press the "Continue" button
	
	#Then I take a screenshot
	
##Convictions

	#error
	
	And I press the "Continue" button
	
	#Then I take a screenshot
	
	#move on YES
	
	When I set the radio button to "Yes"
	
	#Then I take a screenshot
	
	#move on NO
	
	When I set the radio button to "No"
	And I press the "Continue" button
	
	#Then I take a screenshot
		
##Mental Health Sectioned

	#error
	
	And I press the "Continue" button
	
	#Then I take a screenshot
	
	#move on YES
	
	And I set the radio button to "Yes"
	
	#Then I take a screenshot
	
	#move on No
	
	And I set the radio button to "No"
	And I press the "Continue" button
	
	#Then I take a screenshot
	
##Mental Health Capacity

	#error
	
	And I press the "Continue" button

	#Then I take a screenshot
	
	#move on YES
	
	And I set the radio button to "Yes"
	
	#Then I take a screenshot
	
	#move on NO
	
	And I set the radio button to "No"
	And I press the "Continue" button

	#Then I take a screenshot
	
##I can attend

	#error
	
	And  I press the "Continue" button
	
	#Then I take a screenshot
	
	#move on
	
	And I set the radio button to "Yes, I can start on"
	And  I press the "Continue" button
	
	#Then I take a screenshot

##Deferal

	And I click on the "Back" link
	
	When I set the radio button to "No, I need to change the date"
	And  I press the "Continue" button
	
	#Then I take a screenshot
	
	#reason
	
	When I set text area with "id" of "deferralReason" to "Deferral Reason"
	And I press the "Continue" button
	
	#Then I take a screenshot
	
	#Dates
	
	When I set the "First" single date field to a Monday "10" weeks in the future
	When I set the "Second" single date field date fieldte to a Monday "11" weeks in the future
	When I set the "Third" single date field to a Monday "12" weeks in the future
	
	And I press the "Continue" button
	
	#Then I take a screenshot
	
##Excusal

	And I click on the "Back" link
	And I click on the "Back" link
	And I click on the "Back" link
	
	When I set the radio button to "No, I cannot do jury service and need to be excused" 
	And  I press the "Continue" button
	
	#Then I take a screenshot
	
	#reason
	
	Then I set text area with "id" of "excusalReason" to "Excuse me please"
	
	And  I press the "Continue" button
	
	#Then I take a screenshot

##RA no
	
	#error
	
	And I press the "Continue" button
	
	#Then I take a screenshot
	
	#move on YES
	
	When I set the radio button to "Yes"
	
	#Then I take a screenshot

	#move on NO
	
	When I set the radio button to "No"
	And I press the "Continue" button
	
	#Then I take a screenshot
	
##Check your answers
	
	#error
	
	And I press the "Submit" button

	#Then I take a screenshot
	
	#move on
	
	And I check the "The information I have given is true to the best of my knowledge" checkbox
	And I press the "Submit" button

	#Then I take a screenshot
	
##HTML

	And I click on the "Download a copy of your summons reply HTML" link
	
	#Then I take a screenshot

Examples:
	|part_no	|last_name			|postcode	|email 		|pool_no	|
	|645200349	|LNAMETHREEFOURNINE	|SY2 6LU	|a@eeee.com	|452170401	|
	

Scenario Outline: English 3rd Party Straight Through
	
	Given I am on "Public" "juror-test02"
	
	#Then I take a screenshot
	
	Given the juror numbers have not been processed
		| part_no 	| pool_no 	| owner |
		| <part_no> |<pool_no>	| 400 	|
		
	And "<part_no>" has "LNAME" as "<last_name>"
	And "<part_no>" has "RET_DATE" as "5 mondays time"
	And "<part_no>" has "NEXT_DATE" as "5 mondays time"
	And "<part_no>" has "ZIP" as "<postcode>"
	
	Given auto straight through processing has been enabled
	
##1st or 3rd
	
	#error
	
	And I press the "Continue" button
	
	#Then I take a screenshot

	#move on
	
	And I set the radio button to "I am replying for someone else"
	And I press the "Continue" button
	
	#Then I take a screenshot
	
##log on
	
	#error
	
	And I press the "Continue" button
	
	#Then I take a screenshot
	
	#move on
	
	When I set "9-digit juror number" to "<part_no>"
	And I set "Juror last name" to "<last_name>"
	And I set "Juror postcode" to "<postcode>"
	And I press the "Continue" button

	And I take a screenshot
	
##3rd party name

	#error

	And I press the "Continue" button
	
	And I take a screenshot
	
	#move on
	
	When I set "First name" to "FirstNameA"
	And I set "Last name" to "LastNameB"
	And I press the "Continue" button
	
	And I take a screenshot

##Relationship

	#error

	And I press the "Continue" button
	
	And I take a screenshot
	
	#move on

	And I set "How do you know the person you're replying for?" to "Friend"
	And I press the "Continue" button
	
	And I take a screenshot

##contact

	#error
	
	And I press the "Continue" button
	
	And I take a screenshot
	
	#move on
	
	And I check the "By phone (UK Numbers only)" checkbox
	And I set "Main phone" to "0207 821 1818"
	And I check the "By email" checkbox
	And I set "Enter your email address" to "email@outlook.com"
	And I set "Enter your email address again" to "email@outlook.com"
	And I press the "Continue" button
	
	And I take a screenshot

##why replying

	#error
	
	And I press the "Continue" button
	
	And I take a screenshot
	
	#moving on
	
	When I set the radio button to "The person is not here"
	And I press the "Continue" button
	
	And I take a screenshot
	
##name
	
	#Then I take a screenshot
	
	#error
	
	And I press the "Continue" button
	
	#Then I take a screenshot
	
	#move on NO
	
	And I set the radio button to "No"
	And I press the "Continue" button
	
	#Then I take a screenshot
	
	Then I click on the "Back" link
	
	#move on YES
	
	And I set the radio button to "Yes"
	And I press the "Continue" button
	
##address
	
	#Then I take a screenshot

	#error
	
	When I press the "Continue" button
	
	#Then I take a screenshot
	
	#move on NO
	
	And I set the radio button to "No"
	And I press the "Continue" button
	
	#Then I take a screenshot
	
	Then I click on the "Back" link
	
	#move on YES
	
	And I set the radio button to "Yes"
	When I press the "Continue" button

##DOB

	#Then I take a screenshot

	#error
	
	And I press the "Continue" button

	#Then I take a screenshot
	
	#move on OVERAGE
	
	When I set "Day" to "01"
	And I set "Month" to "01"
	And I set "Year" to "1900"
	And I press the "Continue" button
	
	#Then I take a screenshot

	#move on
	
	And I click on the "Back" link
	
	When I set "Day" to "01"
	And I set "Month" to "01"
	And I set "Year" to "1990"
	And I press the "Continue" button
	
	#Then I take a screenshot
	
##phone

	#error
	
	And I press the "Continue" button

	#Then I take a screenshot
	
	#move on
	
	And I set the radio button to "Use the phone number that you have already given to contact you"
	And I set the radio button to "Use the email address that you have already given to contact you"
	And I press the "Continue" button

##qualifying

	When I press the "Continue" button
	
	#Then I take a screenshot

##residency

	#error
	
	And I press the "Continue" button
	
	#Then I take a screenshot
	
	#move on NO
	
	And I set the radio button to "No"
	
	#Then I take a screenshot
	
	#move on YES
	
	And I set the radio button to "Yes"
	And I press the "Continue" button
	
	#Then I take a screenshot
	
##CJS

	#error
	
	And I press the "Continue" button
	
	#Then I take a screenshot
	
	#move on YES
	
	When I set the radio button to "Yes"
	
	#Then I take a screenshot
	
	#move on NO
		
	When I set the radio button to "No"
	And I press the "Continue" button
	
	#Then I take a screenshot
	
##Bail
	
	#error
	
	And I press the "Continue" button
	
	#Then I take a screenshot
	
	#move on YES

	When I set the radio button to "Yes"
	
	#Then I take a screenshot
	
	#move on NO

	When I set the radio button to "No"
	And I press the "Continue" button
	
	#Then I take a screenshot
	
##Convictions

	#error
	
	And I press the "Continue" button
	
	#Then I take a screenshot
	
	#move on YES
	
	When I set the radio button to "Yes"
	
	#Then I take a screenshot
	
	#move on NO
	
	When I set the radio button to "No"
	And I press the "Continue" button
	
	#Then I take a screenshot
		
##Mental Health Sectioned

	#error
	
	And I press the "Continue" button
	
	#Then I take a screenshot
	
	#move on YES
	
	And I set the radio button to "Yes"
	
	#Then I take a screenshot
	
	#move on No
	
	And I set the radio button to "No"
	And I press the "Continue" button
	
	#Then I take a screenshot
	
##Mental Health Capacity

	#error
	
	And I press the "Continue" button

	#Then I take a screenshot
	
	#move on YES
	
	And I set the radio button to "Yes"
	
	#Then I take a screenshot
	
	#move on NO
	
	And I set the radio button to "No"
	And I press the "Continue" button

	#Then I take a screenshot
	
##I can attend

	#error
	
	And  I press the "Continue" button
	
	#Then I take a screenshot
	
	#move on
	
	And I set the radio button to "Yes, they can start on"
	And  I press the "Continue" button
	
	#Then I take a screenshot

##Deferal

	And I click on the "Back" link
	
	When I set the radio button to "No, we need to change the date"
	And  I press the "Continue" button
	
	#Then I take a screenshot
	
	#reason
	
	When I set text area with "id" of "deferralReason" to "Deferral Reason"
	And I press the "Continue" button
	
	#Then I take a screenshot
	
	#Dates
	
	When I set the "First" single date field to a Monday "10" weeks in the future
	When I set the "Second" single date field to a Monday "11" weeks in the future
	When I set the "Third" single date field to a Monday "12" weeks in the future
	
	And I press the "Continue" button
	
	#Then I take a screenshot
	
##Excusal

	And I click on the "Back" link
	And I click on the "Back" link
	And I click on the "Back" link
	
	When I set the radio button to "No, they cannot do" 
	And  I press the "Continue" button
	
	#Then I take a screenshot
	
	#reason
	
	Then I set text area with "id" of "excusalReason" to "Excuse me please"
	
	And  I press the "Continue" button
	
	#Then I take a screenshot

##RA no
	
	#error
	
	And I press the "Continue" button
	
	#Then I take a screenshot
	
	#move on YES
	
	When I set the radio button to "Yes"
	
	#Then I take a screenshot

	#move on NO
	
	When I set the radio button to "No"
	And I press the "Continue" button
	
	#Then I take a screenshot
	
##Check your answers
	
	#error
	
	And I press the "Submit" button

	#Then I take a screenshot
	
	#move on
	
	And I check the "The answers I have given for the person I'm replying for are true as far as I know." checkbox
	And I press the "Submit" button

	#Then I take a screenshot
	
##HTML

	And I click on the "Download a copy of your summons reply HTML" link
	
	#Then I take a screenshot

Examples:
	|part_no	|last_name			|postcode	|email 		|pool_no	|
	|645200349	|LNAMETHREEFOURNINE	|SY2 6LU	|a@eeee.com	|452170401	|



Scenario Outline: Welsh 1st Party Straight Through
	
	Given I am on the welsh version of "Public" "juror-test02"
	
	#Then I take a screenshot
	
	Given the juror numbers have not been processed
		| part_no 	| pool_no 	| owner |
		| <part_no> |<pool_no>	| 400 	|
		
	And "<part_no>" has "LNAME" as "<last_name>"
	And "<part_no>" has "RET_DATE" as "5 mondays time"
	And "<part_no>" has "NEXT_DATE" as "5 mondays time"
	And "<part_no>" has "ZIP" as "<postcode>"
	
	Given auto straight through processing has been enabled
	
##1st or 3rd
	
	#error
	
	And I press the "Parhau" button
	
	#Then I take a screenshot

	#move on
	
	And I set the radio button to "n ymateb dros fy hun"
	And I press the "Parhau" button
	
	#Then I take a screenshot
	
##log on
	
	#error
	
	And I press the "Parhau" button
	
	#Then I take a screenshot
	
	#move on
	
	When I set "Rhif rheithiwr" to "<part_no>"
	When I set "Cyfenw" to "<last_name>"
	When I set "Cod post Rheithiwr" to "<postcode>"
	And I press the "Parhau" button
	
##name
	
	#Then I take a screenshot
	
	#error
	
	And I press the "Parhau" button
	
	#Then I take a screenshot
	
	#move on NO
	
	And I set the radio button to "Nac ydy"
	And I press the "Parhau" button
	
	#Then I take a screenshot
	
	Then I click on the "Cliciwch i fynd yn ôl" link
	
	#move on YES
	
	And I set the radio button to "Ydy"
	And I press the "Parhau" button
	
##address
	
	#Then I take a screenshot

	#error
	
	When I press the "Parhau" button
	
	#Then I take a screenshot
	
	#move on NO
	
	And I set the radio button to "Na"
	And I press the "Parhau" button
	
	#Then I take a screenshot
	
	Then I click on the "Cliciwch i fynd yn ôl" link
	
	#move on YES
	
	And I set the radio button to "Ie"
	When I press the "Parhau" button

##phone

	#Then I take a screenshot

	#error
	
	And I press the "Parhau" button

	#Then I take a screenshot
	
	#move on
	
	When I set "Prif rif ffôn" to "02078211818"
	And I press the "Parhau" button

##email

	#Then I take a screenshot
	
	#error
	
	And I press the "Parhau" button
	
	#Then I take a screenshot
	
	#move on
	
	And I set "Nodwch eich cyfeiriad e-bost" to "email@outlook.com"
	And I set "Nodwch eich cyfeiriad e-bost eto" to "email@outlook.com"
	And I press the "Parhau" button
	
##DOB

	#Then I take a screenshot

	#error
	
	And I press the "Parhau" button

	#Then I take a screenshot
	
	#move on OVERAGE
	
	When I set "Diwrnod" to "27"
	And I set "Mis" to "04"
	And I set "Blwyddyn" to "1900"
	And I press the "Parhau" button
	
	#Then I take a screenshot

	#move on
	
	And I click on the "Cliciwch i fynd yn ôl" link
	
	When I set "Diwrnod" to "27"
	And I set "Mis" to "04"
	And I set "Blwyddyn" to "1990"
	And I press the "Parhau" button
	
	#Then I take a screenshot

##qualifying

	When I press the "Parhau" button
	
	#Then I take a screenshot

##residency

	#error
	
	And I press the "Parhau" button
	
	#Then I take a screenshot
	
	#move on NO
	
	And I set the radio button to "Naddo"
	
	#Then I take a screenshot
	
	#move on YES
	
	And I set the radio button to "Do"
	And I press the "Parhau" button
	
	#Then I take a screenshot
	
##CJS

	#error
	
	And I press the "Parhau" button
	
	#Then I take a screenshot
	
	#move on YES
	
	When I set the radio button to "Ydw"
	
	#Then I take a screenshot
	
	#move on NO
		
	When I set the radio button to "Nac ydw"
	And I press the "Parhau" button
	
	#Then I take a screenshot
	
##Bail
	
	#error
	
	And I press the "Parhau" button
	
	#Then I take a screenshot
	
	#move on YES

	When I set the radio button to "Ydw"
	
	#Then I take a screenshot
	
	#move on NO

	When I set the radio button to "Nac ydw"
	And I press the "Parhau" button
	
	#Then I take a screenshot
	
##Convictions

	#error
	
	And I press the "Parhau" button
	
	#Then I take a screenshot
	
	#move on YES
	
	When I set the radio button to "Do"
	
	#Then I take a screenshot
	
	#move on NO
	
	When I set the radio button to "Naddo"
	And I press the "Parhau" button
	
	#Then I take a screenshot
		
##Mental Health Sectioned

	#error
	
	And I press the "Parhau" button
	
	#Then I take a screenshot
	
	#move on YES
	
	And I set the radio button to "Ie"
	
	#Then I take a screenshot
	
	#move on No
	
	And I set the radio button to "Na"
	And I press the "Parhau" button
	
	#Then I take a screenshot
	
##Mental Health Capacity

	#error
	
	And I press the "Parhau" button

	#Then I take a screenshot
	
	#move on YES
	
	And I set the radio button to "Ie"
	
	#Then I take a screenshot
	
	#move on NO
	
	And I set the radio button to "Na"
	And I press the "Parhau" button

	#Then I take a screenshot
	
##I can attend

	#error
	
	And  I press the "Parhau" button
	
	#Then I take a screenshot
	
	#move on
	
	And I set the radio button to "Ydw, rydw i'n gallu dechrau"
	And  I press the "Parhau" button
	
	#Then I take a screenshot

##Deferal

	And I click on the "Cliciwch i fynd yn ôl" link
	
	When I set the radio button to "Nac ydw, hoffwn newid y dyddiad"
	And  I press the "Parhau" button
	
	#Then I take a screenshot
	
	#reason
	
	When I set text area with "id" of "deferralReason" to "Deferral Reason"
	And I press the "Parhau" button
	
	#Then I take a screenshot
	
	#Dates
	
	When I set the "First" single date field to a Monday "10" weeks in the future
	When I set the "Second" single date field to a Monday "11" weeks in the future
	When I set the "Third" single date field to a Monday "12" weeks in the future
	
	And I press the "Parhau" button
	
	#Then I take a screenshot
	
##Excusal

	And I click on the "Cliciwch i fynd yn ôl" link
	And I click on the "Cliciwch i fynd yn ôl" link
	And I click on the "Cliciwch i fynd yn ôl" link
	
	When I set the radio button to "Nac ydw, ni allaf wasanaethu ar reithgor a hoffwn gael fy esgusodi" 
	And  I press the "Parhau" button
	
	#Then I take a screenshot
	
	#reason
	
	Then I set text area with "id" of "excusalReason" to "Excuse me please"
	
	And  I press the "Parhau" button
	
	#Then I take a screenshot

##RA no
	
	#error
	
	And I press the "Parhau" button
	
	#Then I take a screenshot
	
	#move on YES
	
	When I set the radio button to "Oes"
	
	#Then I take a screenshot

	#move on NO
	
	When I set the radio button to "Nac oes"
	And I press the "Parhau" button
	
	#Then I take a screenshot
	
##Check your answers
	
	#error
	
	And I press the "Cyflwyno" button

	#Then I take a screenshot
	
	#move on
	
	And I check the "Mae'r wybodaeth a roddais uchod yn wir hyd eithaf fy ngwybodaeth." checkbox
	And I press the "Cyflwyno" button

	#Then I take a screenshot
	
##HTML

	And I click on the "Lawrlwythwch gopi o'ch ymateb i'r wŷs HTML (15KB)" link
	
	#Then I take a screenshot

Examples:
	|part_no	|last_name			|postcode	|email 		|pool_no	|
	|645200349	|LNAMETHREEFOURNINE	|SY2 6LU	|a@eeee.com	|452170401	|
	
@Screenshots
Scenario Outline: Welsh 3rd Party Straight Through
	
	Given I am on the welsh version of "Public" "juror-test02"
	
	#Then I take a screenshot
	
	Given the juror numbers have not been processed
		| part_no 	| pool_no 	| owner |
		| <part_no> |<pool_no>	| 400 	|
		
	And "<part_no>" has "LNAME" as "<last_name>"
	And "<part_no>" has "RET_DATE" as "5 mondays time"
	And "<part_no>" has "NEXT_DATE" as "5 mondays time"
	And "<part_no>" has "ZIP" as "<postcode>"
	
	Given auto straight through processing has been enabled
	
##1st or 3rd
	
	#error
	
	And I press the "Parhau" button
	
	#Then I take a screenshot

	#move on
	
	And I set the radio button to "Rwy'n ymateb ar ran rhywun arall"
	And I press the "Parhau" button
	
	#Then I take a screenshot
	
##log on
	
	#error
	
	And I press the "Parhau" button
	
	#Then I take a screenshot
	
	#move on
	
	When I set "Rhif rheithiwr" to "<part_no>"
	When I set "Cyfenw" to "<last_name>"
	When I set "Cod post Rheithiwr" to "<postcode>"
	And I press the "Parhau" button

	And I take a screenshot
	
##3rd party name

	#error

	And I press the "Parhau" button
	
	And I take a screenshot
	
	#move on
	
	When I set "Enw cyntaf" to "FirstNameA"
	And I set "Cyfenw" to "LastNameB"
	And I press the "Parhau" button
	
	And I take a screenshot

##Relationship

	#error

	And I press the "Parhau" button
	
	And I take a screenshot
	
	#move on

	And I set "Sut ydych chi'n adnabod yr unigolyn rydych yn ymateb ar ei ran?" to "Friend"
	And I press the "Parhau" button
	
	And I take a screenshot

##contact

	#error
	
	And I press the "Parhau" button
	
	And I take a screenshot
	
	#move on
	
	And I check the "Dros y ffôn (rhifau yn y DU yn unig)" checkbox
	And I set "Prif rif ffôn" to "0207 821 1818"
	And I check the "Trwy e-bost" checkbox
	And I set "Nodwch gyfeiriad e-bost" to "email@outlook.com"
	And I set "Nodwch gyfeiriad e-bost eto" to "email@outlook.com"
	And I press the "Parhau" button
	
	And I take a screenshot

##why replying

	#error
	
	And I press the "Parhau" button
	
	And I take a screenshot
	
	#moving on
	
	When I set the radio button to "Nid yw'r unigolyn yma"
	And I press the "Parhau" button
	
	And I take a screenshot
	
##name
	
	#Then I take a screenshot
	
	#error
	
	And I press the "Parhau" button
	
	#Then I take a screenshot
	
	#move on NO
	
	And I set the radio button to "Nac ydy"
	And I press the "Parhau" button
	
	#Then I take a screenshot
	
	Then I click on the "Cliciwch i fynd yn ôl" link
	
	#move on YES
	
	When I set the radio button to "Ydy"
	And I press the "Parhau" button
	
##address
	
	#Then I take a screenshot

	#error
	
	When I press the "Parhau" button
	
	#Then I take a screenshot
	
	#move on NO
	
	And I set the radio button to "Na"
	And I press the "Parhau" button
	
	#Then I take a screenshot
	
	Then I click on the "Cliciwch i fynd yn ôl" link
	
	#move on YES
	
	And I set the radio button to "Ie"
	When I press the "Parhau" button

##DOB

	#Then I take a screenshot

	#error
	
	And I press the "Parhau" button

	#Then I take a screenshot
	
	#move on OVERAGE
	
	And I set "Diwrnod" to "27"
	And I set "Mis" to "04"
	And I set "Blwyddyn" to "1900"
	And I press the "Parhau" button
	
	#Then I take a screenshot

	#move on
	
	And I click on the "Cliciwch i fynd yn ôl" link
	
	And I set "Diwrnod" to "27"
	And I set "Mis" to "04"
	And I set "Blwyddyn" to "1990"
	And I press the "Parhau" button
	
	#Then I take a screenshot
	
##phone

	#error
	
	And I press the "Parhau" button

	#Then I take a screenshot
	
	#move on
	
	And I set the radio button to "Defnyddio'r rhif ffôn rydych eisoes wedi'i ddarparu i gysylltu â chi"
	And I set the radio button to "Defnyddio'r cyfeiriad e-bost rydych eisoes wedi'i ddarparu i gysylltu â chi"
	And I press the "Parhau" button

##qualifying

	When I press the "Parhau" button
	
	#Then I take a screenshot

##residency

	#error
	
	And I press the "Parhau" button
	
	#Then I take a screenshot
	
	#move on NO
	
	And I set the radio button to "Naddo"
	
	#Then I take a screenshot
	
	#move on YES
	
	And I set the radio button to "Do"
	And I press the "Parhau" button
	
	#Then I take a screenshot
	
##CJS

	#error
	
	And I press the "Parhau" button
	
	#Then I take a screenshot
	
	#move on YES
	
	When I set the radio button to "Ydy"
	
	#Then I take a screenshot
	
	#move on NO
		
	When I set the radio button to "Nac ydy"
	And I press the "Parhau" button
	
	#Then I take a screenshot
	
##Bail
	
	#error
	
	And I press the "Parhau" button
	
	#Then I take a screenshot
	
	#move on YES

	When I set the radio button to "Ydy"
	
	#Then I take a screenshot
	
	#move on NO

	When I set the radio button to "Nac ydy"
	And I press the "Parhau" button
	
	#Then I take a screenshot
	
##Convictions

	#error
	
	And I press the "Parhau" button
	
	#Then I take a screenshot
	
	#move on YES
	
	When I set the radio button to "Ydy"
	
	#Then I take a screenshot
	
	#move on NO
	
	When I set the radio button to "Nac ydy"
	And I press the "Parhau" button
	
	#Then I take a screenshot
		
##Mental Health Sectioned

	#error
	
	And I press the "Parhau" button
	
	#Then I take a screenshot
	
	#move on YES
	
	And I set the radio button to "Ie"
	
	#Then I take a screenshot
	
	#move on No
	
	And I set the radio button to "Na"
	And I press the "Parhau" button
	
	#Then I take a screenshot
	
##Mental Health Capacity

	#error
	
	And I press the "Parhau" button

	#Then I take a screenshot
	
	#move on YES
	
	And I set the radio button to "Ie"
	
	#Then I take a screenshot
	
	#move on NO
	
	And I set the radio button to "Na"
	And I press the "Parhau" button

	#Then I take a screenshot
	
##I can attend

	#error
	
	And  I press the "Parhau" button
	
	#Then I take a screenshot
	
	#move on
	
	When I set the radio button to "Ydi, mae'r unigolyn yn gallu dechrau ar"
	And  I press the "Parhau" button
	
	#Then I take a screenshot

##Deferal

	And I click on the "Cliciwch i fynd yn ôl" link
	
	When I set the radio button to "Nac ydi, rhaid newid y dyddiad"
	And  I press the "Parhau" button
	
	#Then I take a screenshot
	
	#reason
	
	When I set text area with "id" of "deferralReason" to "Deferral Reason"
	And I press the "Parhau" button
	
	#Then I take a screenshot
	
	#Dates
	
	When I set the "First" single date field to a Monday "10" weeks in the future
	When I set the "Second" single date field to a Monday "11" weeks in the future
	When I set the "Third" single date field to a Monday "12" weeks in the future
	
	And I press the "Parhau" button
	
	#Then I take a screenshot
	
##Excusal

	And I click on the "Cliciwch i fynd yn ôl" link
	And I click on the "Cliciwch i fynd yn ôl" link
	And I click on the "Cliciwch i fynd yn ôl" link
	
	And I set the radio button to "Nac ydi, ni all yr unigolyn wasanaethu ar reithgor a rhaid esgusodi"
	And  I press the "Parhau" button
	
	#Then I take a screenshot
	
	#reason
	
	Then I set text area with "id" of "excusalReason" to "Excuse me please"
	
	And  I press the "Parhau" button
	
	#Then I take a screenshot

##RA no
	
	#error
	
	And I press the "Parhau" button
	
	#Then I take a screenshot
	
	#move on YES
	
	When I set the radio button to "Oes"
	
	#Then I take a screenshot

	#move on NO
	
	When I set the radio button to "Nac oes"
	And I press the "Parhau" button
	
	#Then I take a screenshot
	
##Check your answers
	
	#error
	
	When I press the "Cyflwyno" button

	#Then I take a screenshot
	
	#move on
	
	Then I check the "wybodaeth rwyf wedi ei rhoi am yr unigolyn rwyf yn ymateb ar ei ran yn gywir." checkbox
	And I press the "Cyflwyno" button

	#Then I take a screenshot
	
##HTML

	Then I click on the "Lawrlwythwch gopi o'ch ymateb i'r wŷs HTML (15KB)" link
	
	#Then I take a screenshot

Examples:
	|part_no	|last_name			|postcode	|email 		|pool_no	|
	|645200349	|LNAMETHREEFOURNINE	|SY2 6LU	|a@eeee.com	|452170401	|
	