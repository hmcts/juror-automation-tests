--delete from juror_mod.user_courts;
--commit;
--
--delete from juror_mod.user_roles;
--commit;

TRUNCATE TABLE juror_mod.users CASCADE;
commit;

INSERT INTO juror_mod.users (user_type, username, email, name, active, created_by)
VALUES ('BUREAU', 'MODTESTBUREAU', 'MODTESTBUREAU@email.gov.uk', 'MODTESTBUREAU', true, 'AUTO'),
       ('COURT', 'MODTESTCOURT', 'MODTESTCOURT@email.gov.uk', 'MODTESTCOURT', true, 'AUTO'),
       ('SYSTEM', 'AUTO', 'AUTO@email.gov.uk', 'AUTO', true, 'AUTO'),
       ('BUREAU', 'TeamPickListUser', 'TeamPickListUser@email.gov.uk', 'TeamPickListUser', true, 'AUTO'),
       ('BUREAU', 'AutomationStaffTWO', 'AutomationStaffTWO@email.gov.uk', 'AutomationStaffTWO', true, 'AUTO'),
       ('SYSTEM', 'SYSTEM', 'SYSTEM@email.gov.uk', 'SYSTEM', true, 'AUTO'),
       ('COURT', 'SJOUSER1', 'SJOUSER1@email.gov.uk', 'SJOUSER1', true, 'AUTO'),
       ('COURT', 'SJOUSER', 'SJOUSER@email.gov.uk', 'SJOUSER', true, 'AUTO'),
       ('BUREAU', 'CPASS', 'CPASS@email.gov.uk', 'CPASS', true, 'AUTO'),
       ('BUREAU', 'NEWUSER', 'NEWUSER@email.gov.uk', 'NEWUSER', true, 'AUTO'),
       ('BUREAU', 'ARAMIS1', 'ARAMIS1@email.gov.uk', 'ARAMIS1', true, 'AUTO'),
       ('COURT', 'CMANAGER', 'CMANAGER@email.gov.uk', 'CMANAGER', true, 'AUTO'),
       ('COURT', 'CMANAGER2', 'CMANAGER2@email.gov.uk', 'CMANAGER2', true, 'AUTO'),
       ('COURT', 'SHREWSBURY', 'SHREWSBURY@email.gov.uk', 'SHREWSBURY', true, 'AUTO'),
       ('ADMINISTRATOR', 'SYSTEMADMIN', 'SYSTEMADMIN@email.gov.uk', 'SYSTEMADMIN', true, 'AUTO'),
       ('COURT', 'MODCOURT', 'MODCOURT@email.gov.uk', 'MODCOURT', true, 'AUTO'),
       ('ADMINISTRATOR', 'ADMINUSER', 'cade.faulkner@hmcts.net', 'ADMINUSER', true, 'AUTO');
commit;


INSERT INTO juror_mod.user_roles (username, role)
VALUES ('MODTESTBUREAU', 'MANAGER'),
       ('CPASS', 'MANAGER'),
       ('SJOUSER1', 'SENIOR_JUROR_OFFICER'),
       ('SJOUSER', 'SENIOR_JUROR_OFFICER'),
       ('CMANAGER', 'MANAGER'),
       ('CMANAGER2', 'MANAGER');
commit;

INSERT INTO juror_mod.user_courts (username, loc_code)
VALUES ('MODTESTBUREAU', '400'),
       ('SYSTEMADMIN', '400'),
       ('MODTESTCOURT', '415'),
       ('MODCOURT', '415'),
       ('MODCOURT', '769'),
       ('MODCOURT', '416'),
       ('AUTO', '400'),
       ('TeamPickListUser', '400'),
       ('AutomationStaffTWO', '400'),
       ('SYSTEM', '400'),
       ('SJOUSER1', '416'),
       ('SJOUSER', '415'),
       ('CPASS', '400'),
       ('ARAMIS1', '400'),
       ('CMANAGER', '415'),
       ('CMANAGER2', '415'),
       ('SHREWSBURY', '452'),
       ('NEWUSER', '400'),
       ('ADMINUSER', '400');
commit;