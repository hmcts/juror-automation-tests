@SmokeTest_Notify
Feature: Notify Email Test

@Smoketest @JDB-3595
Scenario Outline: 1st party straight through Notify Email Test

	Given I am on "Public" "test1.1"
	
	Given the juror numbers have not been processed
		| part_no 	| pool_no 	| owner |
		| <part_no> |<pool_no>	| 400 	|
		
	Given I have submitted a straight through response
		| part_no			|pool_number	| last_name			|postcode		| email 	|
		|<part_no>			|<pool_no>		| <last_name>		|<postcode>		|<email>	|
		
Examples:
	|part_no 	|pool		|last_name			|postcode	|email				|
	|644200931	|442170401	|LNAMENINETHREEONE	|NN1 3HQ	|e@mail.com	|