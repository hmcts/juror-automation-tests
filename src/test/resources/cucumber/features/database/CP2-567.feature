@ADMIN_Regression @CP2-567
Feature: Basic column check for SUBSCRIPTION_USERS.NOTIFICATION_STATUS 
	
Scenario: Column Checks
	Given "notification_status" exists in "crime_portal_db" "subscription_users" for the "front" end
	Then I see 1 row for "front" "crime_portal_db" "information_schema.columns" where "table_name" is "subscription_users" and "column_name" is "notification_status" and "data_type" is "character varying"
	#Then I see 1 row for "front" "crime_portal_db" "information_schema.columns" where "table_name" is "subscription_users" and "column_name" is "notification_status" and "character_maximum_length" is 3
	Then I see 1 row for "front" "crime_portal_db" "information_schema.columns" where "table_name" is "subscription_users" and "column_name" is "notification_status" and "column_default" is "'ON'::character varying"
	Then I see 1 row for "front" "crime_portal_db" "information_schema.columns" where "table_name" is "subscription_users" and "column_name" is "notification_status" and "udt_name" is "varchar"
