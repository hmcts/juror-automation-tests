@ADMIN_Features @DB_GATEWAY_Basic
Feature: Basic database testing against Oracle

Scenario: Table Exists Check
	Given "message_audit" table exists within the "cp_soap_gateway_owner" schema
	#select * from SYS.all_tables where owner='CP_SOAP_GATEWAY_OWNER'	
	
Scenario: Column Checks
	#select * from SYS.ALL_TAB_COLS where owner='CP_SOAP_GATEWAY_OWNER' and table_name='MESSAGE_AUDIT'
	Then "CP_SOAP_GATEWAY_OWNER"."MESSAGE_AUDIT" has column "VERSION_NUMBER" with "DATA_TYPE" "NUMBER"
	
	Then "CP_SOAP_GATEWAY_OWNER"."MESSAGE_AUDIT" has column "VERSION_NUMBER" with "NULLABLE" "Y"
	Then "CP_SOAP_GATEWAY_OWNER"."MESSAGE_AUDIT" has column "VERSION_NUMBER" with "HIDDEN_COLUMN" "NO"
	
	
	Then "CP_SOAP_GATEWAY_OWNER"."MESSAGE_AUDIT" has column "UPDATED_DATE" with "DATA_TYPE" "TIMESTAMP(6)"
	Then "CP_SOAP_GATEWAY_OWNER"."MESSAGE_AUDIT" has column "ACTION_TYPE" with "CHAR_LENGTH" "200"
	
	#SELECT cols.column_name FROM all_constraints cons NATURAL JOIN all_cons_columns cols WHERE cons.constraint_type = 'P' AND table_name = UPPER('MESSAGE_AUDIT');
	Then "CP_SOAP_GATEWAY_OWNER"."MESSAGE_AUDIT" has constraint type "P" for column "MESSAGE_AUDIT_ID"
	