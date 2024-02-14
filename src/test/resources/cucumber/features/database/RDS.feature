@ADMIN_Features @CP2-371
Feature: Basic RDS Schema exists

Scenario: Basic RDS Tables Exist
	Given "acknowledgement_message" table exists within the "RDS" schema
	Given "compression_list" table exists within the "RDS" schema
	Given "data_audit" table exists within the "RDS" schema
	Given "databasechangelog" table exists within the "RDS" schema
	Given "databasechangeloglock" table exists within the "RDS" schema
	Given "internal_error_message" table exists within the "RDS" schema
	Given "log_message" table exists within the "RDS" schema
	Given "message_audit" table exists within the "RDS" schema
	Given "message_status" table exists within the "RDS" schema
	#select * from SYS.all_tables where owner='CP_SOAP_GATEWAY_OWNER'	
