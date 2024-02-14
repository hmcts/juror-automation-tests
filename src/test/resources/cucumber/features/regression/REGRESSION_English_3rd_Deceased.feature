Feature: Regression English_3rd_Deceased

#TO DO: WELSH 3rd DECEASED

@Regression @replytypes @JDB-3666 @JDB-3983 
Scenario Outline: English 3rd Deceased
	Given I am on "Public" "juror-test02"
	Given the juror numbers have not been processed
		| part_no 	| pool_no 	| owner |
		| <part_no> |<pool_no>	| 400 	|

	And "<part_no>" has "LNAME" as "<last_name>" 
	And "<part_no>" has "FNAME" as "FNAMESEVENONETHREE"
	And "<part_no>" has "RET_DATE" as "5 mondays time"
	And "<part_no>" has "NEXT_DATE" as "5 mondays time"
	#And "<part_no>" has "FNAME" as "FNAMEEIGHTFIVEFIVE"
	And "<part_no>" has "Address" as "855 STREET NAME"
	#And "<part_no>" has "Address2" as "ANYTOWN"
	#And "<part_no>" has "Address3" as ""
	And "<part_no>" has "Address4" as "LONDON"
	And "<part_no>" has "ZIP" as "<postcode>"
	
	#Reply to jury summons
	
	Then I see "Reply to a jury summons" on the page
	
	Then I see "Are you replying for yourself or for someone else?" on the page
	And I set the radio button to "I am replying for someone else"
	And I press the "Continue" button
	Then I see "Their juror details" on the page
	
	#Login

	When I set "9-digit juror number" to "<part_no>"
	When I set "Juror last name" to "<last_name>"
	When I set "Juror postcode" to "<postcode>"
	And I press the "Continue" button
	Then I see "What is your name?" on the page
	
	#3rd Party Name
	
	When I set "First name" to "FirstName"
	And I set "Last name" to "LastName"
	And I press the "Continue" button
	Then I see "Your relationship to the person" on the page
	
	#Relationship to Juror
	
	When I set "How do you know the person you're replying for?" to "Friend"
	And I press the "Continue" button
	Then I see "Your contact information" on the page
	
	#3rd Party Contact
	
	When I check the "By phone (UK Numbers only)" checkbox
	And I check the "By email" checkbox
	And I set "Main phone" to "02078211818"
	And I set "Enter your email address" to "email@outlook.com"
	And I set "Enter your email address again" to "email@outlook.com"
	And I press the "Continue" button
	Then I see "Why are you replying for the other person?" on the page
	
	#Why Are You Replying
	
	When I set the radio button to "The person has died"
	And I press the "Continue" button
	Then I see "Check your answers now" on the page
	
	#Check Your Answers Now
	
	When I check the "The answers I have given for the person I'm replying for are true as far as I know" checkbox
	And I press the "Submit" button
	Then I see "You have completed your reply" on the page
	And I see "We have sent an email to say you have replied to this jury summons." on the page
	And I see "Download a copy of your summons reply" on the page
	And I see "You do not need to do anything else" on the page
	And I see "Jurors are selected at random from the electoral roll. This is not always completely up to date. That's why we sent a jury summons to this person. We do apologise for this and hope it has not caused too much distress." on the page

	Given I am on "Bureau" "juror-test02"
	And I log in
	
	When I click on the "Search" link
	And I set "Juror number" to "<part_no>"
	And I press the "Search" button
	Then I see "<part_no>" on the page

	Then I see "<part_no>" has reply type indicator "COMPLETED"
	
Examples:
	|part_no		|pool_no	|last_name	|postcode	|email 		| 
	|641500046		|415170401	|DOE		|SW1H 9AJ	|e@eeee.com|