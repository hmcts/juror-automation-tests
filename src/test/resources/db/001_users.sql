--delete from juror_mod.user_courts;
--commit;
--
--delete from juror_mod.user_roles;
--commit;

TRUNCATE TABLE juror_mod.users CASCADE;
commit;

INSERT INTO juror_mod.users (user_type, username, email, name, active)
VALUES ('BUREAU', 'MODTESTBUREAU', 'MODTESTBUREAU@email.gov.uk', 'MODTESTBUREAU', true),
       ('COURT', 'MODTESTCOURT', 'MODTESTCOURT@email.gov.uk', 'MODTESTCOURT', true),
       ('SYSTEM', 'AUTO', 'AUTO@email.gov.uk', 'AUTO', true),
       ('BUREAU', 'TeamPickListUser', 'TeamPickListUser@email.gov.uk', 'TeamPickListUser', true),
       ('BUREAU', 'AutomationStaffTWO', 'AutomationStaffTWO@email.gov.uk', 'AutomationStaffTWO', true),
       ('SYSTEM', 'SYSTEM', 'SYSTEM@email.gov.uk', 'SYSTEM', true),
       ('COURT', 'SJOUSER1', 'SJOUSER1@email.gov.uk', 'SJOUSER1', true),
       ('COURT', 'SJOUSER', 'SJOUSER@email.gov.uk', 'SJOUSER', true),
       ('BUREAU', 'CPASS', 'CPASS@email.gov.uk', 'CPASS', true),
       ('BUREAU', 'NEWUSER', 'NEWUSER@email.gov.uk', 'NEWUSER', true),
       ('BUREAU', 'ARAMIS1', 'ARAMIS1@email.gov.uk', 'ARAMIS1', true),
       ('COURT', 'CMANAGER', 'CMANAGER@email.gov.uk', 'CMANAGER', true),
       ('COURT', 'CMANAGER2', 'CMANAGER2@email.gov.uk', 'CMANAGER2', true),
       ('COURT', 'SHREWSBURY', 'SHREWSBURY@email.gov.uk', 'SHREWSBURY', true),
       ('ADMINISTRATOR', 'SYSTEMADMIN', 'SYSTEMADMIN@email.gov.uk', 'SYSTEMADMIN', true),
       ('COURT', 'MODCOURT', 'MODCOURT@email.gov.uk', 'MODCOURT', true),
       ('ADMINISTRATOR', 'ADMINUSER', 'cade.faulkner@hmcts.net', 'ADMINUSER', true);
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