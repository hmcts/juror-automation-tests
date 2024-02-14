Feature: Regression English_3rd_Underage

@Regression @JDB-3081 @JDB-3889 @JDB-3790 @JDB-3983 @JDB-4097 @JDB-4502 
Scenario Outline: English 3rd Party Underage
		
	Given I am on "Public" "bau-test"
	
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
	
	When I set "9-digit juror number" to "<part_no>"
	When I set "Juror last name" to "<last_name>"
	When I set "Juror postcode" to "<postcode>"
	And I press the "Continue" button
	Then I see "Your Details" on the page
	
	When I set "First name" to "FirstNamea"
	And I set "Last name" to "LastNameb"
	And I press the "Continue" button
	
	And I set "How do you know the person you're replying for?" to "Friend"
	And I press the "Continue" button
		
	And I check the "By phone (UK Numbers only)" checkbox
	And I set "Main phone" to "02078211818"
	And I check the "By email" checkbox
	When I set "Enter your email address" to "<email>"
	When I set "Enter your email address again" to "<email>"
	And I press the "Continue" button
	Then I see "Why are you replying for the other person?" on the page
	
	When I set the radio button to "The person is unable to reply by themselves"
	And I press the "Continue" button
	Then I see "Is the name we have for them correct?" on the page
	When I set the radio button to "Yes"
	
	When I press the "Continue" button
	Then I see "Is this their address?" on the page
	When I set the radio button to "Yes"
	
	When I press the "Continue" button
	Then I see "Give the date of birth for the person you're replying for" on the page
	
	When I set "Day" to "27"
	And I set "Month" to "04"
	And I set "Year" to "2006"
	
	#Moving past DoB Section
	
	And I press the "Continue" button
	Then I see "Is the date of birth correct?" on the page
	
	#And "Is the date of birth correct?" text is bold
	
	And I see "steps/your-details/confirm/tp" in the URL

	#change
	
	And I press the "Continue" button
	Then I see "There is a problem" on the page
	And I see "Tell us if their date of birth is correct" on the page
	
	Then I set the radio button to "No"
	And I press the "Continue" button
	
	#DoB
	
	When I set "Day" to ""
	And I set "Month" to ""
	And I set "Year" to ""
	When I press the "Continue" button
	Then I see "There is a problem" on the page
	
	#JDB-4502
	
	And I see "Enter the day the person was born" on the page
	And I do not see "Enter the month the person was born" on the page
	And I do not see "Enter the year the person was born" on the page

	#only day is set
	
	When I set "Day" to "27"
	When I press the "Continue" button
	Then I see "There is a problem" on the page
	And I see "Enter the month the person was born" on the page
	
	#day and month are set
	
	And I set "Month" to "04"
	When I press the "Continue" button
	Then I see "There is a problem" on the page
	And I see "Enter the year the person was born" on the page
	
	#only year is set
	
	When I set "Day" to ""
	And I set "Month" to ""
	And I set "Year" to "1988"
	When I press the "Continue" button
	Then I see "There is a problem" on the page
	And I see "Enter the day the person was born" on the page
	And I do not see "Enter the month the person was born" on the page
	And I do not see "Enter the year the person was born" on the page
	
	When I set "Day" to "27"
	And I set "Month" to "04"
	And I set "Year" to "198a"
	And I press the "Continue" button
	Then I see "There is a problem" on the page
	And I see "Enter the year the person was born as a 4 digit number. For example, 1982" on the page
	
	When I set "Day" to "27"
	And I set "Month" to "04"
	And I set "Year" to "2006"
	And I press the "Continue" button
	
	Then I set the radio button to "Yes"
	And I press the "Continue" button

	Then I see "Check your answers now" on the page
	And I see text "27 April 2006" in the same row as "Date of birth"
	
	Then I check the "The answers I have given for the person I'm replying for are true as far as I know." checkbox
	When I press the "Submit" button
	
	Then I see "You have completed your reply" on the page
	Then I see "<part_no>" on the page
	
Examples:
	|part_no	|last_name	|postcode	|email 		|pool_no	|
	|741500001	|LNAMEONE	|CH1 2AN	|a@eeee.com	|415181001	|