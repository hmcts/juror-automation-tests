Feature: Bureau Only Regression

@Regression_Invalid @Regression_DataTest
Scenario Outline: 
Need to clear the data for juror number = 641500990
	Delete row from where juror_number
		juror_response
			juror_response_aud
			juror_response_cjs_employment
			juror_response_special_needs
			
		change_log
			change_log_item
		
		staff_juror_response_audit
		
		
		
	set juror.pool where part_no
		is_active='Y'
		status = 1,
		responded ='N'
		READ_ONLY='Y'
		null
			title
			dob
			address3
			address4
			address5
			address6
			H_PHONE
			W_PHONE
			W_PH_LOCAL
			TIMES_SEL
			TRIAL_NO
			JUROR_NO
			DEF_DATE
			USER_EDTQ
			NOTES
			PHOENIX_DATE
			PHOENIX_CHECKED
			M_PHONE
			H_EMAIL
			CONTACT_PREFERENCE
			
			
		
		
		
	Given the juror numbers have not been processed
		| part_no 	| pool_no 	|
		| 641500990 |			|

	Given I have submitted a first party English straight through response
		| part_no			|pool_number	| last_name			|postcode	| email |
		|<part_no>			|<pool_no>		| <last_name>	|CH1 2AN	|a@a.com|
#		|<part_no_two>		|<pool_no>		| <last_name>	|CH1 2AN	|a@a.com|
	
Examples:
	| part_no		|last_name			|postcode	| email           |
	|641500990		|DOE	|SW1H 9AJ	|email@outlook.com|
	
